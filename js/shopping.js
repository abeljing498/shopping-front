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
    }
    $.ajax({
        url: requestUrl + 'brand/recommendList',
        type: "GET",
        data: params,
        success: function (data) {
            if (data.code == 200) {
                $('#ul-brands').empty();
                // $("#category-ul").append(`<li data-tab-target="all" class="active tab">All</li>`);
                $.each(data.data, function (i, dataObject) {
                    $("#ul-brands").append(`<li class="tags-item"> <a>${dataObject.name}</a></li>`);
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

function searchProduct(pageNum, brandId, keyword, productCategoryId, sort) {
    let params = {
        pageNum: pageNum || 1, // 默认值为1
        pageSize: 6
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
        data: params, // 直接传递params对象
        // contentType: 不需要设置，GET请求默认使用正确的格式
        success: function (data) {
            if (data.code == 200) {
                // 处理数据...
                $.each(data.data, function (i, brand) {

                });
            }
        },
        error: function (err) {
            console.error("Request failed:", err);
        }
    });
    $(document).ready(function () {
        $('.tabs').on('click', '.tab', function (event) {
            event.preventDefault(); // 阻止默认行为，如果需要的话
            const target = $(this).data('tab-target'); // 获取data-tab-target的值
            const productCategoryId = target;
            if (target === 'all') {
                searchProduct();
            } else {
                searchProduct(1, undefined, undefined, productCategoryId, undefined);
            }

        });
    });
}