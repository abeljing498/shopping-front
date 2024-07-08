var productData = null;
var productAttr = []; // 存储最终的JSON数组
var currentSelection = {}; // 跟踪每个属性的当前选择值
function initProductDetail(productId) {
    $.ajax({
        url: requestUrl + 'product/detail/' + productId,
        type: "GET",
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        success: function (data) {
            if (data.code == 200) {
                productData = data;
                var pic = data.data.product.pic;
                var pics = "";
                if (data.data.product.albumPics !== '') {
                    pics = pic + ',' + data.data.product.albumPics;
                } else {
                    pics = pic;
                }

                var arr = pics.split(",");
                $.each(arr, function (i, pic) {
                    $('#div-product-man-pic').append(`
                        <div class="swiper-slide">
                           <img src="${pic}" alt="" onclick="changeImageSorce('${pic}')">
                        </div>
                    `);

                });
                $('#div-image-product-detail').attr('src', pic);
                $("#h-product-name").text(data.data.product.name);
                $("#p-product-detail").text(data.data.product.description);
                $("#s-product-price").text("$ " + data.data.product.price);
                $("#del-product-price").text("$" + data.data.product.originalPrice);
                $("#ul-product-category").append(`
                    <li data-value=${data.data.product.productCategoryName} class="select-item">
                    <a href="#">${data.data.product.productCategoryName}</a>
                </li>
                `);
                $("#product-stock").html(data.data.product.stock + " in stock");
                if (data.data.product.keywords !== '') {
                    var keywords = data.data.product.keywords.split(' ');
                    var htmlKey = "";
                    $.each(keywords, function (i, attValue) {
                        htmlKey += `
                      <li data-value=${attValue} class="select-item">
                                    <a href="#">${attValue}</a>
                                </li>`
                    });
                    $("#ul-product-tags").append(htmlKey);
                }
                $.each(data.data.productAttributeValueList, function (i, value) {
                    $.each(data.data.productAttributeList, function (i, attrs) {
                        if (attrs.id == value.productAttributeId) {
                            var attributeValueList = value.value.split(",");
                            var colorOptionsHtml = '';
                            // 如果属性值列表长度大于1，意味着需要用户选择
                            if (attributeValueList.length > 1) {
                                // 默认选择第一个值
                                currentSelection[attrs.name] = attributeValueList[0];
                                productAttr.push({"key": attrs.name, "value": attributeValueList[0]});
                            } else {
                                // 如果只有一个值，直接添加到JSON数组中
                                productAttr.push({"key": attrs.name, "value": attributeValueList[0]});
                            }
                            $.each(attributeValueList, function (i, attValue) {
                                colorOptionsHtml += `
                            <li class="select-item" data-val="${attValue}" title="${attValue}">
                               <a onclick="chooseAttr(this,'${attrs.name}','${attValue}')">${attValue}</a>
                            </li> `;
                            });
                            $("#div-product-attr").append(`
                             <div class="color-options product-select" >
                                <div class="color-toggle" data-option-index="0">
                                    <h4 class="item-title no-margin">${attrs.name}:</h4>
                                    <ul class="select-list list-unstyled d-flex">
                                             ${colorOptionsHtml}
                                    </ul>
                                </div>
                            </div>
                            `);
                        }
                    });
                });
                return data.data;
            }
        },
        error: function (err) {
            console.error("Request failed:", err);
        }
    });
}

function chooseAttr(element, attrsName, attrsValue) {

    // 更新当前选择状态
    currentSelection[attrsName] = attrsValue;
    // 更新JSON数组中的相应项
    for (var i = 0; i < productAttr.length; i++) {
        if (productAttr[i].key === attrsName) {
            productAttr[i].value = attrsValue;
            break;
        }
    }
    var parentLi = $(element).parent().parent();
    parentLi.find('a').removeClass('selected');
    // 为当前点击的<a>标签添加'selected'类
    $(element).addClass('selected');
}

function changeImageSorce(imgUrl) {
    $('#div-image-product-detail').attr('src', imgUrl);
}

function changeAttrValue(value) {
    $('#div-image-product-detail').attr('src', imgUrl);
}

$(document).ready(function () {
    var urlParams = new URLSearchParams(window.location.search);
    var id = urlParams.get('id');
    var data = initProductDetail(id);

    $('#btn_add_cart').click(function () {
        var addCartVaule = {};
        addCartVaule.price = productData.data.product.id;
        addCartVaule.productAttr = JSON.stringify(productAttr);
        addCartVaule.productBrand = productData.data.product.brandName;
        addCartVaule.productCategoryId = productData.data.product.productCategoryId;
        addCartVaule.productId = productData.data.product.id;
        addCartVaule.productName = productData.data.product.name;
        addCartVaule.productPic = productData.data.product.pic;
        addCartVaule.productSn = productData.data.product.productSn;
        addCartVaule.productSubTitle = productData.data.product.subTitle;
        addCartVaule.quantity = $('#quantity').val(); // 使用.val()来获取input的值
        // 发起POST请求到购物车添加端点
        $.ajax({
            url: requestUrl + 'cart/add',
            type: "POST",
            data: JSON.stringify(addCartVaule),
            contentType: "application/json; charset=utf-8",
            success: function (response) {
                if (response.code == 200) {
                    alert("添加到购物车成功！");
                    window.location.href = "cart.html";
                } else {
                    alert('添加到购物车失败！');
                }
            },
            error: function (err) {
                console.error("提交失败:", err);
            }
        });
    });
    initIncrementDecrement();
});

var initIncrementDecrement = function () {
    const decrementButton = document.querySelector('.decrement-button');
    const incrementButton = document.querySelector('.increment-button');
    const quantityInput = document.querySelector('#quantity');

    decrementButton.addEventListener('click', () => {
        if (quantityInput.value > 1) {
            quantityInput.value--;
        }
    });

    incrementButton.addEventListener('click', () => {
        if (quantityInput.value < 100) {
            quantityInput.value++;
        }
    });
}
