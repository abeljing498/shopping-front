$(document).ready(function () {
    searchProduct(1, 12, 1);
    initHotProductList();
    initCategoryList();
    $('#selectOrder').on('change', function () {
        // 获取选中的 value 值
        var selectedValue = $(this).val();
        // 调用查询方法并传递选中的值
        searchProduct(1, 12, selectedValue);
    });
});

function searchProduct(pageNum, pageSize, sort, productCategoryId) {
    var urlParams = new URLSearchParams(window.location.search);
    var productType = urlParams.get('productType');
    var params = {};
    params.pageNum = pageNum
    params.pageSize = pageSize;
    params.sort = sort;
    if (productCategoryId != null&&productCategoryId!=='all') {
        params.productCategoryId = productCategoryId;
    }
    ajaxRequest('GET', 'product/search', params, 'application/json; charset=utf-8', function (response) {

        $("#product-grid").empty();
        $.each(response.data.list, function (index, product) {
            var productHtml = `
           <div class="col-lg-4 col-sm-6">
                                <div class="product-grid-item">
                                    <div class="product-element-top"><a href="product-detail-v3.html?id=${product.id}"> <img
                                            class="thumbnail" src="${product.pic}" alt="${product.name}"> </a></div>
                                    <div class="ayira-buttons">
                                        <div class="ayira-wishlist-btn"><a class="" href="my-wishlist.html"><i
                                                class="flaticon-heart"></i></a></div>
                                        <div class="ayira-compare-btn"><a class="button ayira-tooltip"
                                                                          href="compare.html"><i
                                                class="flaticon-reload"></i></a></div>
                                        <div class="quick-view"><a href="#" class="open-quick-view"
                                                                   data-bs-toggle="modal"
                                                                   data-bs-target="#quick_view"><i
                                                class="flaticon-search-2"></i></a></div>
                                    </div>
                                    <div class="product-content">
                                        <div class="product-category-action">
                                            <div class="product-title"><a href="product-detail-v3.html?id=${product.id}">${product.name}</a></div>
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
                                                            <div class="old-price">$${product.originalPrice}</div>
                                                            <div class="sale-price">$${product.price}</div>
                                                        </div>
                                                    </div>
                                                    <div class="btn-add"><a href="javascript:void(0)"
                                                                            class="add_to_cart_button"> <i
                                                            class="fa fa-shopping-cart"></i> Add to cart</a></div>
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

            $("#product-grid").append(productHtml);

        });
        renderPagination(response.data.totalPage, pageNum);
    })
}

function initHotProductList() {
    var params = {};
    params.pageNum = 1;
    params.pageSize = 6;
    params.sort = 1;
    ajaxRequest('GET', 'home/hotProductList', params, 'application/json; charset=utf-8', function (response) {
        $("#widget_selling").empty();
        $.each(response.data, function (index, product) {
            var productHtml = `
              <li><div class="product-grid-item">
                                        <div class="product-element-top"><a href="product-detail-v3.html?id=${product.id}"> <img
                                                class="thumbnail" src="${product.pic}" alt="${product.name}"> </a></div>
                                        <div class="product-content">
                                            <div class="product-category-action d-block">
                                                <div class="product-title"><a href="product-detail-v3.html?id=${product.id}">${product.name}</div>
                                                <div class="wrap-price">
                                                    <div class="wrapp-swap">
                                                        <div class="swap-elements">
                                                            <div class="price">
                                                                <div class="product-price">
                                                                       <div class="sale-price">$${product.price}</div>
                                                                </div>
                                                            </div>
                                                            <div class="btn-add"><a href="javascript:void(0)"
                                                                                    class="add_to_cart_button"> <i
                                                                    class="fa fa-shopping-cart"></i> Add to cart</a>
                                                            </div>
                                                        </div>
                                                    </div>
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
                                            </div>
                                        </div>
                                    </div>
                                </li>
        `;

            $("#widget_selling").append(productHtml);
            $('#widget_selling').trigger('destroy.owl.carousel');
            $("#widget_selling").owlCarousel({
                items: 4,
                margin: 20,
                nav: true,
                autoplay: false,
                autoplayHoverPause: true,
                loop: false,
                navText: ["<i class='flaticon-back'></i>", "<i class='flaticon-next'></i>"],
                responsive: {
                    0: {items: 1,},
                    576: {items: 1,},
                    768: {items: 1, slideBy: 2},
                    991: {items: 1, loop: true, dots: true,},
                    1000: {items: 1, loop: true,},
                }
            });

        });

    })
}


function renderPagination(totalPages, currentPage) {

// 清空现有的分页元素
    $('.pagination').empty();

// 添加“上一页”按钮
    $('.pagination').append('<li class="page-item"><a class="page-link" href="#" aria-label="Previous"><i class="fa fa-angle-left"></i></a></li>');

    // 如果总页数小于等于5，则直接显示所有页码
    for (var i = 1; i <= totalPages; i++) {
        var activeClass = (i === currentPage) ? 'active' : ''; // 当前页的处理
        $('.pagination').append('<li class="page-item ' + activeClass + '"><a class="page-link" href="#">' + i + '</a></li>');
    }
// 添加“下一页”按钮
    $('.pagination').append('<li class="page-item"><a class="page-link" href="#" aria-label="Next"><i class="fa fa-angle-right"></i></a></li>');

// 为分页链接添加点击事件处理器
    $('.pagination .page-link').on('click', function (event) {
        event.preventDefault();
        var page = $(this).text();
        if (page === '...' || !$.isNumeric(page)) {
            return; // 省略号或非数字不做处理
        }

        // 更新当前页
        currentPage = parseInt(page, 10);
        // 在这里调用你的函数来加载新页面的内容
        searchProduct(currentPage, 12, 1);
    });
    // 为“上一页”按钮添加点击事件处理器
    $('.pagination [aria-label="Previous"]').on('click', function (event) {
        event.preventDefault();
        if (currentPage > 1) {
            currentPage--;
            searchProduct(currentPage, 12, 1);
        }
    });

// 为“下一页”按钮添加点击事件处理器
    $('.pagination [aria-label="Next"]').on('click', function (event) {
        event.preventDefault();
        if (currentPage < totalPages) {
            currentPage++;
            searchProduct(currentPage, 12, 1);
        }
    });


}

function generateCategoryList(data) {
    var $categoryList = $('#category-List');
    data.forEach(function (category) {
        var $categoryItem = $('<li></li>');
        var $categoryLink = $('<a href="#">' + category.name + '</a>');
        var $toggle = $('<div class="category-toggle collapsed" data-toggle="collapse" data-target="#category' + category.id + '"><span class="add"><i class="fa fa-angle-down"></i></span><span class="remove"><i class="fa fa-angle-up"></i></span></div>');
        var $subMenu = $('<div id="category' + category.id + '" class="collapse"></div>');
        var $subMenuList = $('<ul class="category-sub-menu list-unstyled"></ul>');
        var $allItem = $('<li><a href="#" data-value="all">All</a></li>');
        $subMenuList.append($allItem);
        if (category.children && category.children.length > 0) {
            category.children.forEach(function (child) {
                var $childItem = $('<li><a href="#" data-value="' + child.id + '">' + child.name + '</a></li>');
                $subMenuList.append($childItem);
            });
            $subMenu.append($subMenuList);
        }

        $categoryItem.append($categoryLink, $toggle, $subMenu);
        $categoryList.append($categoryItem);

    });

    // 启用Bootstrap的折叠功能
    // 绑定点击事件处理函数
    $('.category-toggle').on('click', function () {
        var $this = $(this);
        var targetId = $this.data('target');
        var $target = $(targetId);

        if ($target.hasClass('show')) {
            $target.removeClass('show');
            $this.addClass('collapsed');
        } else {
            $target.addClass('show');
            $this.removeClass('collapsed');
        }
    });
    // 为所有子项添加点击事件
    $categoryList.on('click', '.category-sub-menu a', function (event) {
        event.preventDefault(); // 阻止默认的链接行为

        var selectedValue = $(this).data('value'); // 获取自定义属性值
        console.log('Selected value:', selectedValue);

        // 在这里执行你的筛选逻辑或其他操作
        // 例如，如果你想要根据选定的值来过滤内容
        searchProduct(1, 12, 1, selectedValue);
    });
}

function initCategoryList() {
    ajaxRequest('GET', 'product/categoryTreeList', null, 'application/json; charset=utf-8', function (response) {
        $("#category-List").empty();
        generateCategoryList(response.data);
    })
}