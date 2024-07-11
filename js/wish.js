$(document).ready(function () {
    initData();

});

function initData() {
    let params = {
        pageNum: 1, // 默认值为1
        pageSize: 100
    };

    $.ajax({
        url: requestUrl + 'member/productCollection/list',
        type: "GET",
        data: params,
        success: function (data) {
            if (data.code === 200) {
                $('#div-wish-list').empty();
                $.each(data.data.list, function (i, dataObject) {
                    $("#div-wish-list").append(` <div class="wishlist-item border-bottom padding-small">
                    <div class="row align-items-center">
                        <div class="col-lg-4 col-md-3">
                            <div class="row wishlist-info d-flex flex-wrap">
                                <div class="col-lg-5">
                                    <div class="card-image">
                                        <img src="${dataObject.productPic}" alt="cloth" class="img-fluid">
                                    </div>
                                </div>
                                <div class="col-lg-4">
                                    <div class="card-detail">
                                        <h3 class="card-title">
                                            <a href="single-product.html?id=${dataObject.productId}">${dataObject.productName}</a>
                                        </h3>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-7">
                            <div class="row d-flex">
                                <div class="col-md-6">
                                    <div class="unit-price">
                                        <span class="money text-primary">$${dataObject.productPrice}</span>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="stock-status">
                                        <span>In stock</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-2 col-md-2">
                            <div class="wishlist-remove">
                                <a href="#"><i class="icon icon-close"></i></a>
                            </div>
                            <button type="button" class="btn btn-dark btn-wrap wishlist-link d-flex align-items-center">add to cart <i
                                class="icon icon-arrow-io"></i></button>
                        </div>
                    </div>
                </div>`);
                    $('.wishlist-remove', '#div-wish-list').last().on('click', function () {
                        deleteProduct(dataObject.productId);
                    });
                    $('.btn.btn-dark.btn-wrap.wishlist-link', '#div-wish-list').last().on('click', function () {
                        addCart(dataObject.productId);

                    });
                });

               
            }
        },
        error: function (err) {
            console.error("Request failed:", err);
        }
    });
    function deleteProduct(id) {
        let params = {
            productId: id
        };
        $.ajax({
            url: requestUrl + 'member/productCollection/delete',
            type: 'POST',
            data: params,
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
            success: function (data) {
                if (data.code == 200) {
                    initData();
                }

            },
            error: function (error) {
                console.error('Error:', error);
            }
        });
    }
}

