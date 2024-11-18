// 绑定按钮点击事件
$(document).ready(function () {
    initData();
});

function initData() {

    // 定义 GET 请求的参数
    ajaxRequest('GET', 'home/content', null, function (response) {
        if (response.code !== 200) {
            return;
        }
        if (response.data.advertiseList[0]) {
            $("#imageAd1").attr("src", response.data.advertiseList[0].pic);
            $('#hrefAd1').attr('href', response.data.advertiseList[0].url);

        }
        if (response.data.advertiseList[1]) {
            $("#imageAd2").attr("src", response.data.advertiseList[1].pic);
            $('#hrefAd2').attr('href', response.data.advertiseList[1].url);
        }
        if (response.data.advertiseList[2]) {
            $("#imageAd3").attr("src", response.data.advertiseList[2].pic);
            $('#hrefAd3').attr('href', response.data.advertiseList[2].url);
        }
        // 如何动态加载后在实现owl.carousel.min 插件
        $("#new_arrivals").empty();
        $.each(response.data.newProductList, function (index, product) {
            var productHtml = `
             <li>
              <input type="hidden" id="hidden-product-id" value="${product.id}"> 
                        <div class="product-grid-item">
                            <div class="product-element-top">
                                <a href="product-detail-v1.html">
                                    <img class="thumbnail"
                                         src="${product.pic}"
                                         alt="${product.name}"> </a>
                                <span class="new product-label">New</span>
                            </div>
                            <div class="ayira-buttons">
                                <div class="ayira-wishlist-btn"><a class="" href="my-wishlist.html"><i
                                        class="flaticon-heart"></i></a></div>
                                <div class="ayira-compare-btn"><a class="button ayira-tooltip" href="compare.html"><i
                                        class="flaticon-reload"></i></a></div>
                                <div class="quick-view"><a href="#" class="open-quick-view" data-bs-toggle="modal"
                                                           data-bs-target="#quick_view"><i
                                        class="flaticon-search-2"></i></a></div>
                            </div>
                            <div class="product-content">
                                <div class="product-category-action">
                                    <div class="product-title"><a href="product-detail-v1.html">${product.name}</a>
                                    </div>
                                    <div class="product-rating d-flex">
                                        <ul class="d-flex">
                                            <li><i class="fa fa-star"></i></li>
                                            <li><i class="fa fa-star"></i></li>
                                            <li><i class="fa fa-star"></i></li>
                                            <li><i class="fa fa-star"></i></li>
                                            <li><i class="fa fa-star"></i></li>
                                        </ul>
                                        <span>(10)</span></div>
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
                                            <div class="btn-add header-action-btn-cart"><a href="javascript:void(0)"
                                                                                           class="add_to_cart_button">
                                                <i class="fa fa-shopping-cart"></i> Add to cart</a></div>
                                        </div>
                                    </div> 
                                </div>
                            </div>
                        </div>
                    </li>
        `;

            $("#new_arrivals").append(productHtml);
        });
        $('#new_arrivals').trigger('destroy.owl.carousel');
        $('#new_arrivals').owlCarousel({
            items: 4,
            margin: 30,
            nav: true,
            autoplay: false,
            autoplayHoverPause: true,
            loop: false,
            navText: ["<i class='flaticon-left-arrow'></i>", "<i class='flaticon-right-arrow'></i>"],
            responsive: {
                0: {items: 1,},
                576: {items: 2,},
                768: {items: 3, slideBy: 2},
                991: {items: 3, loop: true, dots: true,},
                1000: {items: 4, loop: true,},
            }
        })
        $("#collections").empty();
        $.each(response.data.featuredProductList, function (index, product) {
                var productHtml = `
                    <li> 
                        <div class="product-grid-item">
                            <div class="product-element-top"><a href="product-detail-v1.html"> 
                            <img class="thumbnail"src="${product.pic}" alt="${product.name}"> </a>
                                <span class="off product-label">20% off</span></div>
                            <div class="ayira-buttons">
                                <div class="ayira-wishlist-btn"><a class="" href="my-wishlist.html"><i
                                        class="flaticon-heart"></i></a></div>
                                <div class="ayira-compare-btn"><a class="button ayira-tooltip" href="compare.html"><i
                                        class="flaticon-reload"></i></a></div>
                                <div class="quick-view"><a href="#" class="open-quick-view" data-bs-toggle="modal"
                                                           data-bs-target="#quick_view" > 
                                                           <i class="flaticon-search-2"></i></a></div>
                            </div>
                            <div class="product-content">
                                <div class="product-category-action">
                                    <div class="product-title"><a href="product-detail-v1.html">${product.name}</a>
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
                                <div class="wrap-price">
                                    <div class="wrapp-swap">
                                        <div class="swap-elements">
                                            <div class="price">
                                                <div class="product-price">
                                                    <div class="old-price">$${product.originalPrice}</div>
                                                    <div class="sale-price">$${product.price}</div>
                                                </div>
                                            </div>
                                            <div class="btn-add header-action-btn-cart"><a href="javascript:void(0)"
                                                                                           class="add_to_cart_button">
                                                <i class="fa fa-shopping-cart"></i> Add to cart</a></div>
                                        </div> 
                                    </div>
                                </div>
                            </div>
                        </div>
                    </li>
        `;
                //动态给quick-view添加点击事件
                $("#collections").append(productHtml);
            $('.open-quick-view', '#collections').last().on('click', function () {
                openProductDetail(product.id);
            });
            }
        );
        $('#collections').trigger('destroy.owl.carousel');
        $("#collections").owlCarousel({
            items: 4,
            margin: 30,
            nav: true,
            autoplay: false,
            autoplayHoverPause: true,
            loop: false,
            navText: ["<i class='flaticon-left-arrow'></i>", "<i class='flaticon-right-arrow'></i>"],
            responsive: {
                0: {items: 1,},
                576: {items: 2,},
                768: {items: 3,},
                991: {items: 3, loop: true, dots: true,},
                1000: {items: 4, loop: true,},
            }
        });
        $("#trending_products").empty();
        $.each(response.data.trendingProductList, function (index, product) {
            var productHtml = `
            <li>
                    <input type="hidden" id="hidden-product-id" value="${product.id}"> 
                        <div class="product-grid-item">
                            <div class="product-element-top"><a href="product-detail-v1.html"> <img class="thumbnail" src="${product.pic}" alt="${product.name}"> </a>
                            </div>
                            <div class="ayira-buttons">
                                <div class="ayira-wishlist-btn"><a class="" href="my-wishlist.html"><i
                                        class="flaticon-heart"></i></a></div>
                                <div class="ayira-compare-btn"><a class="button ayira-tooltip" href="compare.html"><i
                                        class="flaticon-reload"></i></a></div>
                                <div class="quick-view"><a href="#" class="open-quick-view" data-bs-toggle="modal"
                                                           data-bs-target="#quick_view"><i
                                        class="flaticon-search-2"></i></a></div>
                            </div>
                            <div class="product-content">
                                <div class="product-category-action">
                                    <div class="product-title"><a href="product-detail-v1.html">${product.name}</a>
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
                                <div class="wrap-price">
                                    <div class="wrapp-swap">
                                        <div class="swap-elements">
                                            <div class="price">
                                                <div class="product-price">
                                                    <div class="old-price">$${product.originalPrice}</div>
                                                    <div class="sale-price">$${product.price}</div>
                                                </div>
                                            </div>
                                            <div class="btn-add header-action-btn-cart"><a href="javascript:void(0)"
                                                                                           class="add_to_cart_button">
                                                <i class="fa fa-shopping-cart"></i> Add to cart</a></div>
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
                    </li>
        `;
            $("#trending_products").append(productHtml);

        });
        $('#trending_products').trigger('destroy.owl.carousel');
        $("#trending_products").owlCarousel({
            items: 4,
            margin: 30,
            nav: true,
            autoplay: false,
            autoplayHoverPause: true,
            loop: false,
            navText: ["<i class='flaticon-left-arrow'></i>", "<i class='flaticon-right-arrow'></i>"],
            responsive: {
                0: {items: 1,},
                576: {items: 2,},
                768: {items: 3,},
                991: {items: 3, loop: true, dots: true,},
                1000: {items: 4, loop: true,},
            }
        });
        $("#best_selling").empty();
        $.each(response.data.hotProductList, function (index, product) {
            var productHtml = `
            <li>
             <input type="hidden" id="hidden-product-id" value="${product.id}">  
                        <div class="product-grid-item">
                            <div class="product-element-top"><a href="product-detail-v1.html"> <img class="thumbnail" src="${product.pic}" alt="${product.name}"> </a>
                            </div>
                            <div class="ayira-buttons">
                                <div class="ayira-wishlist-btn"><a class="" href="my-wishlist.html"><i
                                        class="flaticon-heart"></i></a></div>
                                <div class="ayira-compare-btn"><a class="button ayira-tooltip" href="compare.html"><i
                                        class="flaticon-reload"></i></a></div>
                                <div class="quick-view"><a href="#" class="open-quick-view" data-bs-toggle="modal"
                                                           data-bs-target="#quick_view"><i
                                        class="flaticon-search-2"></i></a></div>
                            </div>
                            <div class="product-content">
                                <div class="product-category-action">
                                    <div class="product-title"><a href="product-detail-v1.html">${product.name}</a>
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
                                <div class="wrap-price">
                                    <div class="wrapp-swap">
                                        <div class="swap-elements">
                                            <div class="price">
                                                <div class="product-price">
                                                    <div class="old-price">$${product.originalPrice}</div>
                                                    <div class="sale-price">$${product.price}</div>
                                                </div>
                                            </div>
                                            <div class="btn-add header-action-btn-cart"><a href="javascript:void(0)"
                                                                                           class="add_to_cart_button">
                                                <i class="fa fa-shopping-cart"></i> Add to cart</a></div>
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
                    </li>
        `;
            $("#best_selling").append(productHtml);
        });
        $('#best_selling').trigger('destroy.owl.carousel');
        $('#best_selling').owlCarousel({
            items: 4,
            margin: 30,
            nav: true,
            autoplay: false,
            autoplayHoverPause: true,
            loop: false,
            navText: ["<i class='flaticon-left-arrow'></i>", "<i class='flaticon-right-arrow'></i>"],
            responsive: {
                0: {items: 1,},
                576: {items: 2,},
                768: {items: 3, slideBy: 2},
                991: {items: 3, loop: true, dots: true,},
                1000: {items: 4, loop: true,},
            }
        })

    })
    ;

    function generateStars() {
        var rating = Math.random() * (5 - 4) + 4;
        var starsHtml = '';
        for (var i = 0; i < rating; i++) {
            starsHtml += '<li><i class="fa fa-star"></i></li>';
        }
        return starsHtml;
    }
    function openProductDetail(id){

        ajaxRequest('GET', 'product/detail/'+id, null, function (response) {
            console.log('GET Response:', response);
        });
    }
}