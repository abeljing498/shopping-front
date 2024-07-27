$(document).ready(function () {
    initData();

});

function initData() {
    initBrandList();
    initCategoryTreeList();
    searchProduct();


}

function initBrandList() {
    let params = {
        pageNum: 1, // 默认值为1
        pageSize: 6
    };

    $.ajax({
        url: requestUrl + 'brand/recommendList',
        type: "GET",
        data: params,
        success: function (data) {
            if (data.code === 200) {
                $('#ul-brands').empty();
                $("#ul-brands").append(`<li class="tags-item" data-id="all"> <a>All</a></li>`);
                $.each(data.data, function (i, dataObject) {
                    // 添加id属性以便于后续使用
                    const liElement = `<li class="tags-item" data-id="${dataObject.id}"> <a>${dataObject.name}</a></li>`;
                    $("#ul-brands").append(liElement);
                });

                // 使用事件委托，因为li是在DOM加载后动态添加的
                $('#ul-brands').on('click', '.tags-item', function () {
                    const id = $(this).data('id');
                    if (id == 'all') {
                        searchProduct(1, null, null, null, null);
                    } else {
                        searchProduct(1, id, null, null, null);
                    }

                });
            }
        },
        error: function (err) {
            console.error("Request failed:", err);
        }
    });
}

function initCategoryTreeList() {
    $.ajax({
        url: requestUrl + 'product/categoryTreeList',
        type: "GET",
        success: function (data) {
            if (data.code == 200) {
                $('#category-ul').empty();
                $("#category-ul").append(`<li data-tab-target="all" class="active tab">All</li>`);
                $.each(data.data, function (i, dataObject) {
                    $("#category-ul").append(`<li data-tab-target="${dataObject.id}" class="active tab">${dataObject.name}</li>`);
                });

            }
        },
        error: function (err) {
            console.error("Request failed:", err);
        }
    });
}

function addWishlist(id) {
    var addWishVaule = {};
    addWishVaule.productId = id;
    // 发起POST请求到购物车添加端点
    $.ajax({
        url: requestUrl + 'member/productCollection/add',
        type: "POST",
        data: JSON.stringify(addWishVaule),
        contentType: "application/json; charset=utf-8",
        success: function (response) {
            if (response.code == 200) {
                alert("收藏成功！");
                window.location.href = "wishlist.html";
            }
        },
        error: function (err) {
            console.error("提交失败:", err);
        }
    });

}

function searchProduct(pageNum, brandId, keyword, productCategoryId, sort) {
    let params = {
        pageNum: pageNum || 1, // 默认值为1
        pageSize: 12
    };

    // 动态添加参数，只有当参数非空时才添加
    if (brandId) {
        params.brandId = brandId;
    }
    if (keyword) {
        params.keyword = keyword;
    }
    if (productCategoryId) {
        params.productCategoryId = productCategoryId;
    }
    if (sort) {
        params.sort = sort;
    }

    $.ajax({
        url: requestUrl + 'product/search',
        type: "GET",
        data: params,
        success: function (data) {
            if (data.code == 200) {
                $('#div-products').empty();
                $.each(data.data.list, function (i, product) {
                    $('#div-products').append(`
                      <div class="product-item col-lg-4 col-md-6 col-sm-6" style="padding-bottom: 10px">
                        <div class="image-holder" style="height:75%;width:85%">
                            <img src="${product.pic}" alt="Books" class="product-image" style="height:100%;width:100%">
                        </div>
                        <div class="cart-concern">
                            <div class="cart-button d-flex justify-content-between align-items-center">
                                <button type="button" class="btn-wrap cart-link d-flex align-items-center">
                                    add to cart <i
                                    class="icon icon-arrow-io"></i>
                                </button>
                                <button type="button" class="view-btn tooltip d-flex">
                                    <i class="icon icon-screen-full"></i>
                                    <span class="tooltip-text">Quick view</span>
                                </button>
                                <button type="button" class="wishlist-btn">
                                    <i class="icon icon-heart"></i>
                                </button>
                            </div>
                        </div>
                        <div class="product-detail">
                            <h3 class="product-title">
                                <a href="single-product.html?id=${product.id}">${product.name}</a>
                            </h3>
                            <div class="item-price text-primary">$${product.price.toFixed(2)}</div>
                        </div>
                    </div>
                    `);
                    $('.btn-wrap.cart-link', '#div-products').last().on('click', function () {
                        addCart(product.id);
                    });
                    $('.view-btn.tooltip', '#div-products').last().on('click', function () {
                        window.location.href = "single-product.html?id=" + product.id;

                    });
                    $('.wishlist-btn', '#div-products').last().on('click', function () {
                        addWishlist(product.id);
                    });
                });
                setupPagination(data.data.totalPage); // 假设有5页，当前在第1页
            }
        },
        error: function (err) {
            console.error("Request failed:", err);
        }
    });
}


$(document).ready(function () {
    $('.tabs').on('click', '.tab', function (event) {
        event.preventDefault(); // 阻止默认行为，如果需要的话
        const target = $(this).data('tab-target'); // 获取data-tab-target的值
        const productCategoryId = target;
        console.info("productCategoryId:", productCategoryId);
        if (target === 'all') {
            searchProduct();
        } else {
            searchProduct(1, null, null, productCategoryId, null);
        }

    });
    $('#btn-search').click(function () {
        const keyword = $('#input-search').val();
        searchProduct(1, null, keyword, null, null);

    });

});


function setupPagination(totalPage) {
    // 假设有5页，当前在第1页
    $('#div-page').empty();
    for (let i = 1; i <= totalPage; i++) {
        $("#div-page").append(`<a class="page-numbers" onclick="changePage(${i})">${i}</a>`);
    }
}

function changePage(pageNum) {
    searchProduct(pageNum, null, null, null, null);
}

