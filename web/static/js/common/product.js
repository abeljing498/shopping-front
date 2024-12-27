let selectedValues = {};
let skuMap = {}; // 存储解析后的 SKU 数据，方便查找


function initProductDetail(productId) {
    productAttr = [];
    changeSelectionState = {};
    $("#hid_product_id").val(productId)
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
            }
            // 渲染颜色和其他属性
            renderColors(response.data);
            renderOtherAttributes(response.data);
            // 初始化所有的 tooltip
            var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-tooltip="tooltip"]'));
            tooltipTriggerList.map(function (tooltipTriggerEl) {
                return new bootstrap.Tooltip(tooltipTriggerEl);
            });

        }

    })
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
            var colorImageSrc = getColorPic(colorAttribute.name, value.trim()); // 假设图片路径是 images/颜色名.png
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

$(document).ready(function () {
    $('#btn_add_cart').click(function () {
        const key = Object.entries(selectedValues).sort().map(([k, v]) => `${k}-${v}`).join('_');
        const matchingSku = skuMap[key];
        var addCartVaule = {};
        addCartVaule.productId = $("#hid_product_id").val();
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
function getColorPic(attributeName, value) {
    var filterValue = {};
    filterValue[attributeName] = value;
    const key = Object.entries(filterValue).sort().map(([k, v]) => `${k}-${v}`).join('_');
    const matchingSku = skuMap[key];
    return matchingSku.pic;
}
function handleSelection($element, attributeName, value) {
    selectedValues[attributeName] = value;
    const key = Object.entries(selectedValues).sort().map(([k, v]) => `${k}-${v}`).join('_');
    const matchingSku = skuMap[key];
    $('#img-main-pic').attr('src', matchingSku.pic);
}