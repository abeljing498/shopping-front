function initProductDetail(productId) {
    $.ajax({
        url: requestUrl + 'product/detail/' + productId,
        type: "GET",
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        success: function (data) {
            if (data.code == 200) {
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
                $("#product-stock").html(data.data.product.stock+" in stock");
                var keywords=data.data.product.keywords.split(' ');
                var htmlKey="";
                $.each(keywords, function (i, attValue) {
                    htmlKey += `
                      <li data-value="S" class="select-item">
                                    <a href="#">${attValue}</a>,
                                </li>`;
                });
                $("#ul-product-tags").append(htmlKey);
                $.each(data.data.productAttributeValueList, function (i, value) {
                    var attributeValueList = value.value.split(",");
                    var colorOptionsHtml = '';
                    $.each(attributeValueList, function (i, attValue) {
                        colorOptionsHtml += `
                    <li class="select-item" data-val="${attValue}" title="${attValue}">
                       <a href="#">${attValue}</a>
                    </li> `;
                    });
                    $.each(data.data.productAttributeList, function (i, attrs) {
                        if (attrs.id == value.productAttributeId) {
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


            }
        },
        error: function (err) {
            console.error("Request failed:", err);
        }
    });
}

function changeImageSorce(imgUrl) {
    $('#div-image-product-detail').attr('src', imgUrl);
}
function changeAttrValue(value) {
    $('#div-image-product-detail').attr('src', imgUrl);
}