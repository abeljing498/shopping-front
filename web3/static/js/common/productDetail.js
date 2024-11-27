var productData = null;
var productAttr = []; // 存储最终的JSON数组
var changeSelectionState = {}; // 跟踪每个属性的当前选择值
const colorMap = {
    Black: '#000000',
    Blue: '#1C9BB5',
    Green: '#63A809',
    Red: '#ff0000',
    Yellow: '#ffd700',
    Purple: '#800080',
    Orange: '#ffa500',
    Gray: '#808080',
    White: '#ffffff',
    Brown: '#a52a2a',
    Pink: '#ffc0cb',
    Cyan: '#00ffff'

};

function initProductDetail(productId) {
    productAttr = [];
    changeSelectionState = {};
    ajaxRequest('GET', 'product/detail/' + productId, null, 'application/json; charset=utf-8',function (response) {
        if (response.code == 200) {
            productData = response;
            var pic = response.data.product.pic;
            $('#img-main-pic').attr('src', pic);
            $("#a-product-name").text(response.data.product.name);
            $("#p-product-dsc").text(response.data.product.description);
            $("#s-product-price").text("$ " + response.data.product.price);
            $("#s-product-old-price").text("$" + response.data.product.originalPrice);
            $("#div-product-attr").empty();
            // 商品属性
            $.each(response.data.productAttributeList, function (index, item) {
                // 添加属性选择框
                if (item.type == 0) {
                    var attributeValueList = item.inputList.split(',');
                    if (attributeValueList.length > 1) {
                        // 默认选择第一个值
                        changeSelectionState[item.name] = false;
                        productAttr.push({"key": item.name, "value": attributeValueList[0]});
                    } else {
                        // 如果只有一个值，直接添加到JSON数组中
                        productAttr.push({"key": item.name, "value": attributeValueList[0]});
                    }
                    if (item.name === 'Color' || item.name === 'color') {
                        let colorOptionsHtml = item.inputList.split(',').map(option => {
                            // 获取颜色值
                            let colorValue = colorMap[option] || '#FFFFFF';
                            return `<li class="active ms-0" data-tooltip="tooltip"
                     data-placement="top" title="" data-color="${colorValue}" 
                     data-bs-original-title="${option}" 
                     aria-label="${option}" 
                     style="background-color:${colorValue};" onclick="changeSelectionAttr(this,'${item.name}','${option}','color')"></li>
                `;
                        }).join('');
                        var outAttrHtml = `
                <div class="widget-item d-flex">
                    <h4 class="widget-title">${item.name}:</h4>
                    <div class="widget-color">
                        <ul class="color-list ps-0">
                            ${colorOptionsHtml}
                        </ul>
                    </div>
                </div>
            `;
                        $("#div-product-attr").append(`${outAttrHtml}`);
                    } else {
                        let sizeOptionsHtml = item.inputList.split(',').map(option => {
                            return `
                    <li class="wc-size" onclick="changeSelectionAttr(this,'${item.name}','${option}','other')">
                        <a href="#">${option}</a>
                    </li> `;
                        }).join('');
                        var outAttrHtml = `
                            <div class="widget-item d-flex"><h4 class="widget-title">${item.name}:</h4>
                                        <div class="widget-size">
                                            <ul class="d-flex p-0">
                                               ${sizeOptionsHtml}
                                            </ul>
                                        </div>
                              </div> `;
                        $("#div-product-attr").append(`${outAttrHtml}`);
                    }
                } else {
                    const result = response.data.productAttributeValueList.find(itemAttr => itemAttr.productAttributeId === item.id);
                    if (result) {
                        var outAttrHtml = `
                            <div class="widget-item d-flex"><h4 class="widget-title">${item.name}:</h4>
                                        <div class="widget-size">
                                            <ul class="d-flex p-0">
                                              ${result.value}
                                            </ul>
                                        </div>
                              </div> `;
                        $("#div-product-attr").append(`${outAttrHtml}`);
                    }


                }
            })
            // 初始化所有的 tooltip
            var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-tooltip="tooltip"]'));
            tooltipTriggerList.map(function (tooltipTriggerEl) {
                return new bootstrap.Tooltip(tooltipTriggerEl);
            });

            $("#div-product-detail-img1").empty();
            $("#div-product-detail-img2").empty();
            let images1 = ' <div class="slick-slide" data-src="${item.pic}"><img src="${item.pic}" alt="Product"></div> ';
            let images2 = '<div class="divide"><img src="${item.pic}" alt="Product"></div> ';
            images1 = response.data.product.albumPics.split(',').map(option => {
                return `<div class="slick-slide" data-src="${option}"><img src="${option}" alt="Product"></div>`;
            }).join('');
            images2 = response.data.product.albumPics.split(',').map(option => {
                return `<div class="divide"><img src="${option}" alt="Product"></div>`;
            }).join('');
            $("#div-product-detail-img1").append(`${images1}`);
            $("#div-product-detail-img2").append(`${images2}`);
            initializeSlick();
        }

    })
}

function changeSelectionAttr(obj, attrsName, attrsValue, type) {
    changeSelectionState[attrsName] = true;
    // 更新JSON数组中的相应项
    for (var i = 0; i < productAttr.length; i++) {
        if (productAttr[i].key === attrsName) {
            productAttr[i].value = attrsValue;
            break;
        }
    }
    if (type === 'other') {
        $('.wc-size').removeClass('active');
        // 为当前选中的选项添加 active 类
        $(obj).addClass('active');
    }

}

$(document).ready(function () {
    var urlParams = new URLSearchParams(window.location.search);
    var id = urlParams.get('id');
    var data = initProductDetail(id);
    $('#btn_add_cart').click(function () {
        let allAttrsSelected = true;
        let msg = "";
        Object.keys(changeSelectionState).forEach(attrName => {
            if (!changeSelectionState[attrName]) {
                msg = `请先选择${attrName}`;
                allAttrsSelected = false;
                return false;
            }
        });
        if (allAttrsSelected === false) {
            alert(msg)
            return false;
        }
        var addCartVaule = {};
        addCartVaule.productId = productData.data.product.id;
        addCartVaule.productAttr = JSON.stringify(productAttr);
        addCartVaule.quantity = $('#quantity').val(); // 使用.val()来获取input的值
        // 发起POST请求到购物车添加端点
        ajaxRequest('POST', 'cart/add', addCartVaule,'application/json; charset=utf-8', function (response) {
            if (response.code == 200) {


            }

        })
    });

});

// 初始化 Slick 插件的函数
function initializeSlick() {
    // 检查是否已经存在 Slick 实例，如果有则销毁
    if ($('#div-product-detail-img1').hasClass('slick-initialized')) {
        $('#div-product-detail-img1').slick('unslick');
    }

    // 初始化 Slick 插件
    $('#div-product-detail-img1').slick({
        slidesToShow: 1,
        slidesToScroll: 1,
        arrows: false,
        fade: true,
        navText: ["<i class='flaticon-next'></i>", "<i class='flaticon-back'></i>"],
        asNavFor: '.slider-nav'
    });

    // 如果需要对第二个容器也进行初始化，可以类似处理
    if ($('#div-product-detail-img2').hasClass('slick-initialized')) {
        $('#div-product-detail-img2').slick('unslick');
    }

    $('#div-product-detail-img2').slick({
        slidesToShow: 4,
        slidesToScroll: 1,
        asNavFor: '.slider-five',
        dots: true,
        centerMode: true,
        focusOnSelect: true,
        arrows: true,
    });
}