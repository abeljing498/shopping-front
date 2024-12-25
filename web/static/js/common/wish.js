$(document).ready(function () {
    loadWishData();


});

function loadWishData() {
    var params = {
        pageNum: 1,
        pageSize: 200
    }
    ajaxRequest('GET', 'member/productCollection/list', params, null, function (response) {

        if (response.code == 200) {
            var $wishBody = $('#div_wish_list');
            $wishBody.empty(); // 清空现有的表格行
            var total = 0;
            var rowDiv; // 用于存储当前行的引用
            var itemCounter = 0; // 计数器，用来追踪当前行中的项目数量
            $.each(response.data.list, function (index, item) {
                // 当itemCounter是4的倍数时创建新的行
                if (itemCounter % 4 === 0) {
                    // 如果不是第一个元素，先关闭上一个行
                    if (itemCounter !== 0) {
                        rowDiv.append('</div>'); // 关闭当前行
                    }
                    // 创建新行并添加到$wishBody
                    rowDiv = $('<div class="row"></div>');
                    $wishBody.append(rowDiv);
                }

                // 创建商品项并添加到当前行
                var productItem = `
                    <div class="col-md-3">
                        <div class="product-grid-item mt-0">
                            <div class="product-element-top"><a href="product-detail-v1.html?id=${item.productId}"><img class="thumbnail"
                                                                                                   src="${item.productPic}" 
                                                                                                   alt="${item.productName}"></a></div>
                            <div class="ayira-buttons">
                                <div class="ayira-cancel-btn"><a class="" href="#"><i class="flaticon-close" onclick="deleteWish(${item.id})"></i></a></div>
                            </div>
                            <div class="product-content">
                                <div class="product-category-action">
                                    <div class="product-title"><a href="product-detail-v1.html?id=${item.productId}">${item.productName}</a></div>
                                    <div class="product-rating d-flex">
                                        <ul class="d-flex">
                                            <li><i class="fa fa-star"></i></li>
                                            <li><i class="fa fa-star"></i></li>
                                            <li><i class="fa fa-star"></i></li>
                                            <li><i class="fa fa-star"></i></li>
                                            <li><i class="fa fa-star"></i></li>
                                        </ul>
                                        <span>(212)</span></div>
                                </div>
                                <div class="wrap-price">
                                    <div class="wrapp-swap">
                                        <div class="swap-elements">
                                            <div class="price">
                                                <div class="product-price">
                                                    <div class="old-price">$${item.originalPrice}</div>
                                                    <div class="sale-price">$${item.price}</div>
                                                </div>
                                            </div>
                                            <div class="btn-add"><a href="#" class="add_to_cart_button"><i
                                                    class="fa fa-shopping-cart"></i>Add to cart</a></div>
                                        </div>
                                    </div>
                                    <div class="swatches-on-grid">
                                        <div class="widget-color">
                                            <ul class="color-list ps-0">
                                                <li data-tooltip="tooltip" data-placement="top" title="Green"
                                                    data-color="#63a809"></li>
                                                <li data-tooltip="tooltip" data-placement="top" title="Pink"
                                                    data-color="#ee3e6d"></li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    `;
                rowDiv.append(productItem);

                itemCounter++;
            });

            // 确保最后一个行被正确关闭
            if (itemCounter % 4 !== 0 && itemCounter > 0) {
                rowDiv.append('</div>');
            }


        }


    })
}

function deleteWish(id) {
    var result = window.confirm("Are you sure you want to delete this item？");
    if (result) {
        var params = {
            id: id
        }
        ajaxRequest('POST', 'member/productCollection/delete', null, params, function (response) {
            if (response.code == 200) {
                loadWishData();
            }
        })
    } else {
    }


}