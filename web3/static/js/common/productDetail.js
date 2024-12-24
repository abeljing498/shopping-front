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

function initializeProductDetail(productId) {
    ajaxRequest('GET', 'product/detail/' + productId, null, null, function (response) {
        if (response.code == 200) {
            // 更新产品信息
            var pic = response.data.product.pic;
            $('#img-main-pic').attr('src', pic);
            $("#a-product-name").text(response.data.product.name);
            $("#p-product-dsc").text(response.data.product.description);
            $("#s-product-price").text("$ " + response.data.product.price);
            $("#s-product-old-price").text("$" + response.data.product.originalPrice);

            // 添加到愿望单点击事件
            $('#a_add_wish').click(function () {
                addWish(response.data.product.id);
            });

            // 渲染颜色和其他属性
            renderColors(response.data);
            renderOtherAttributes(response.data);

            // 初始化所有的 tooltip
            var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-tooltip="tooltip"]'));
            tooltipTriggerList.map(function (tooltipTriggerEl) {
                return new bootstrap.Tooltip(tooltipTriggerEl);
            });

            // 清空并重新填充图片展示区域
            $("#div-product-detail-img1").empty();
            $("#div-product-detail-img2").empty();

            // 构建主图和缩略图HTML字符串
            let mainImages = `<img src="${pic}" alt="Product" class="main-image">`;
            let thumbnailImages = `<div class="divide"><img src="${pic}" alt="Product" class="thumbnail"></div>`;

            // 如果有额外的相册图片，则追加它们
            if (response.data.product.albumPics) {
                const albumPics = response.data.product.albumPics.split(',');
                albumPics.forEach((option, index) => {
                    thumbnailImages += `<div class="divide"><img src="${option}" alt="Product" class="thumbnail"></div>`;
                    mainImages += `<img src="${pic}" alt="Product" class="main-image">`;
                });
            }

            // 将构建好的HTML插入到DOM中
            $("#div-product-detail-img1").html(mainImages);
            $("#div-product-detail-img2").html(thumbnailImages);

            let tempImageStorage = {};
            // SKU处理逻辑（保持不变）
            if (response.data.skuStockList) {
                response.data.skuStockList.forEach(sku => {
                    const attributes = JSON.parse(sku.spData).reduce((acc, curr) => {
                        acc[curr.key] = curr.value;
                        return acc;
                    }, {});
                    sku.attributes = attributes;
                    // 提取SKU中的图片信息，并存储在临时对象中
                    if (sku.pic && !tempImageStorage[sku.pic]) {
                        tempImageStorage[sku.pic] = {skuId: sku.id};
                    }
                    const key = Object.entries(attributes).sort().map(([k, v]) => `${k}-${v}`).join('_');
                    skuMap[key] = sku;
                });
                for (let imgSrc in tempImageStorage) {
                    thumbnailImages += `<div class="divide"><img src="${imgSrc}" alt="Product" class="thumbnail"></div>`;
                    mainImages += `<img src="${imgSrc}" alt="Product" class="main-image">`
                }
                $("#div-product-detail-img1").html(mainImages);
                $("#div-product-detail-img2").html(thumbnailImages);
            }
            // 绑定缩略图点击事件，在Slick初始化之后进行
            initializeSlick();

            // 点击缩略图时更新主图
            $("#div-product-detail-img2").on('click', '.thumbnail', function (event) {
                event.preventDefault(); // 防止默认行为
                const newSrc = $(this).attr('src');
                $(".main-image").attr('src', newSrc);
                // 移动焦点到主图
                $(".main-image").focus();
                $(".main-image").css('opacity', ''); // 清除内联样式中的 opacity
            });
        }
    });
}

// Slick Slider 初始化函数
function initializeSlick() {
    ('#div-product-detail-img1').slick({
        slidesToShow: 1,
        slidesToScroll: 1,
        arrows: false,
        fade: true,
        asNavFor: '#div-product-detail-img2',
        focusOnSelect: true // 当选择一个幻灯片时自动聚焦
    });
    $('#div-product-detail-img2').slick({
        slidesToShow: 4,
        slidesToScroll: 1,
        asNavFor: '#div-product-detail-img1',
        dots: false,
        centerMode: true,
        focusOnSelect: true // 当选择一个幻灯片时自动聚焦
    });
}

function handleSelection($element, attributeName, value) {

    selectedValues[attributeName] = value;
    const key = Object.entries(selectedValues).sort().map(([k, v]) => `${k}-${v}`).join('_');
    const matchingSku = skuMap[key];
    $('#div-product-detail-img1').html(`<img src="${matchingSku.pic}" class="main-image">`);
    console.info(matchingSku)
}


$(document).ready(function () {
    var urlParams = new URLSearchParams(window.location.search);
    var id = urlParams.get('id');
    initializeProductDetail(id);
    initializeSlick();
    $('.add_to_cart_button').click(function () {
        const key = Object.entries(selectedValues).sort().map(([k, v]) => `${k}-${v}`).join('_');
        const matchingSku = skuMap[key];
        var addCartVaule = {};
        addCartVaule.productId = id;
        addCartVaule.quantity = $('#quantity').val(); // 使用.val()来获取input的值
        if (matchingSku && matchingSku.id !== undefined && matchingSku.id !== null) {
            addCartVaule.productAttr = matchingSku.spData;
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