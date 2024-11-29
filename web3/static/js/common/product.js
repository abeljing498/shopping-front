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
    productAttr=[];
    changeSelectionState={};
    ajaxRequest('GET', 'product/detail/' + productId, null, null,function (response) {
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
        ajaxRequest('POST', 'cart/add', null, addCartVaule,function (response) {
            if (response.code == 200) {


            }

        })
    });
});
