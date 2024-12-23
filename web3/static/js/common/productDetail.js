let selectedValues = {};
let skuMap = {}; // 存储解析后的 SKU 数据，方便查找
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
    ajaxRequest('GET', 'product/detail/' + productId, null, null, function (response) {
        if (response.code == 200) {
            var pic = response.data.product.pic;
            $('#img-main-pic').attr('src', pic);
            $("#a-product-name").text(response.data.product.name);
            $("#p-product-dsc").text(response.data.product.description);
            $("#s-product-price").text("$ " + response.data.product.price);
            $("#s-product-old-price").text("$" + response.data.product.originalPrice);
            $("#div-product-attr").empty();
            $('#a_add_wish').click(function () {
                addWish(response.data.product.id);
            });

            renderColors(response.data);
            renderOtherAttributes(response.data);
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
            response.data.skuStockList.forEach(sku => {
                const attributes = JSON.parse(sku.spData).reduce((acc, curr) => {
                    acc[curr.key] = curr.value;
                    return acc;
                }, {});
                sku.attributes = attributes;
                // 将 SKU 按照其属性组合存入 map 中
                const key = Object.entries(attributes).sort().map(([k, v]) => `${k}-${v}`).join('_');
                skuMap[key] = sku;
            });

            initializeSlick();
        }

    })
}

function handleSelection($element, attributeName, value) {
    selectedValues[attributeName] = value;
    const key = Object.entries(selectedValues).sort().map(([k, v]) => `${k}-${v}`).join('_');
    const matchingSku = skuMap[key];
    console.info(matchingSku)
}


$(document).ready(function () {
    var urlParams = new URLSearchParams(window.location.search);
    var id = urlParams.get('id');
    var data = initProductDetail(id);
    $('.add_to_cart_button').click(function () {
        const key = Object.entries(selectedValues).sort().map(([k, v]) => `${k}-${v}`).join('_');
        const matchingSku = skuMap[key];
        console.info(matchingSku);
        var spuValue=JSON.stringify(matchingSku);
        var addCartVaule = {};
        addCartVaule.productId = id;
        addCartVaule.quantity = $('#quantity').val(); // 使用.val()来获取input的值
        if (matchingSku && matchingSku.id !== undefined && matchingSku.id !== null) {
            // 如果 matchingSku 包含 spData 和 id 字段，则添加到 addCartVaule
            if (Array.isArray(matchingSku.spData)) {
                addCartVaule.productAttr = matchingSku.spData;
            }

            if (matchingSku.id !== null) {
                addCartVaule.productSkuId = matchingSku.id;
            }
        }

        // 发起POST请求到购物车添加端点
        ajaxRequest('POST', 'cart/add', null, addCartVaule, function (response) {
            if (response.code == 200) {
                getMemberTotal();
                alert("Add shopping cart successfully！")
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

function renderColors(data) {
    $('#colors').empty();
    if (!Array.isArray(data.productAttributeList) || data.productAttributeList.length === 0) {
        return; // 如果不存在或为空，直接退出函数
    }
    const colorAttribute = data.productAttributeList.find(attr => attr.name === 'Color');
    if (colorAttribute) {
        let $attributeRow = $('<div>', {'class': 'attribute-row'});
        let $title = $('<span>', {'class': 'widget-title', text: colorAttribute.name + ': '});

        let $listContainer = $('<div>');
        $.each(colorAttribute.inputList.split(','), function (i, value) {
            let colorImageSrc = `static/picture/p-09.jpg`; // 假设图片路径是 images/颜色名.png
            let $tag = $('<span>', {
                'class': `wc-tag ${i === 0 ? 'active' : ''}`, // 默认选中第一个
                click: function (e) {
                    $(this).toggleClass('active').siblings().removeClass('active');
                    handleSelection($(this), colorAttribute.name, value.trim());
                }
            }).append(
                $('<img>', {src: colorImageSrc, alt: value.trim(), 'class': 'me-1'}),
                value.trim()
            );
            $listContainer.append($tag);
            // 如果是第一个元素，则设置为默认选中
            if (i === 0) {
                selectedValues[colorAttribute.name] = value.trim();
                $tag.addClass('active'); // 确保视觉上也显示为选中状态
            }
        });

        $attributeRow.append($title, $listContainer);
        $('#colors').append($attributeRow);
    }
}

function renderOtherAttributes(data) {
    $('#otherAttributes').empty();
    if (!Array.isArray(data.productAttributeList) || data.productAttributeList.length === 0) {
        return; // 如果不存在或为空，直接退出函数
    }
    const otherAttribute = data.productAttributeList;
    $.each(otherAttribute, function (index, attribute) {
        if (attribute.name !== 'Color' && attribute.type === 0) {
            let $attributeRow = $('<div>', {'class': 'attribute-row'});
            let $title = $('<span>', {'class': 'widget-title', text: attribute.name + ': '});
            let $listContainer = $('<div>');
            if (attribute.inputList !== "") {
                $.each(attribute.inputList.split(','), function (i, value) {
                    let $tag = $('<span>', {
                        'class': `wc-tag ${i === 0 ? 'active' : ''}`, // 默认选中第一个
                        click: function (e) {
                            $(this).toggleClass('active').siblings().removeClass('active');
                            handleSelection($(this), attribute.name, value.trim());
                        }
                    }).text(value.trim());
                    $listContainer.append($tag);
                    // 如果是第一个元素，则设置为默认选中
                    if (i === 0) {
                        selectedValues[attribute.name] = value.trim();
                        $tag.addClass('active'); // 确保视觉上也显示为选中状态
                    }
                });
                $attributeRow.append($title, $listContainer);
                $('#otherAttributes').append($attributeRow);
            }
        }
    });
}