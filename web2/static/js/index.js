function initData() {
    $.ajax({
        url: requestUrl + 'home/content',
        type: "GET",
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        success: function (data) {
            if (data.code == 200) {
                $('#adDivContent').empty();
                $('#adDivContent').append(`
                 <div class="col col-lg-6 col-12">
                    <div class="hero-content">
                        <div class="images">
                            <img src="${data.data.advertiseList[0].pic}" alt="">
                            <div class="hero-text">
                                <h3>${data.data.advertiseList[0].note}</h3>
                                <a class="theme-btn" href="shop.html">Shop Now</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col col-lg-6 col-12">
                    <div class="hero-content s2">
                        <div class="images">
                            <img src="${data.data.advertiseList[1].pic}" alt="">
                        </div>
                        <div class="hero-text">
                            ${data.data.advertiseList[1].note}
                            <a class="theme-btn" href="shop.html">Shop Now</a>
                        </div>
                    </div>
                    <div class="hero-content">
                        <div class="images">
                            <img src="${data.data.advertiseList[2].pic}" alt="">
                        </div>
                        <div class="hero-text"> 
                             ${data.data.advertiseList[2].note}
                            <a class="theme-btn" href="shop.html">Shop Now</a>
                        </div>
                    </div>
                </div>`);
                $.each(data.data.newProductList, function (i, newProduct) {
                    setNewProductDiv('div-new-products', newProduct);

                });
                $.each(data.data.hotProductList, function (i, hotProduct) {
                    setHotProductDiv('div-hot-product', hotProduct);

                });

            }
        },
        error: function (err) {
            console.error("Request failed:", err);
        }
    });
}

function setNewProductDiv(divId, newProduct) {
    $('#' + divId).append(`
                 <div class="product-single-item">
                    <div class="image">
                        <img src="static/picture/13.jpg" alt="">
                        <div class="card-icon">
                            <div class="hot">Hot</div>
                            <div class="hot-2">-70%</div>
                        </div>
                        <ul class="cart-wrap">
                            <li>
                                <a href="shop-single.html" data-bs-toggle="tooltip" data-bs-html="true" title="Shop"><i
                                        class="fi flaticon-shopping-bag"></i></a>
                            </li>
                            <li data-bs-toggle="modal" data-bs-target="#popup-quickview">
                                <button data-bs-toggle="tooltip" data-bs-html="true" title="Quick View"><i
                                        class="fi ti-eye"></i></button>
                            </li>
                            <li>
                                <a href="wishlist.html" data-bs-toggle="tooltip" data-bs-html="true" title="wishlist"><i
                                        class="fa flaticon-heart" aria-hidden="true"></i></a>
                            </li>
                        </ul>
                    </div>
                    <div class="text">
                        <div class="price">
                            <span class="present-price">$70.30</span>
                            <del class="old-price">$85.50</del>
                        </div>
                        <h2><a href="shop-single.html">Stylish man with hat</a></h2>
                        <div class="rating-product">
                            <i class="fa fa-star" aria-hidden="true"></i>
                            <i class="fa fa-star" aria-hidden="true"></i>
                            <i class="fa fa-star" aria-hidden="true"></i>
                            <i class="fa fa-star" aria-hidden="true"></i>
                            <i class="fa fa-star-half-o" aria-hidden="true"></i>
                            <span>13 reviews</span>
                        </div>
                    </div>
                </div>
                 `);
    $('.btn-wrap.cart-link', '#' + divId).last().on('click', function () {
        addCart(newProduct.id);
    });
    $('.view-btn.tooltip', '#' + divId).last().on('click', function () {
        window.location.href = "single-product.html?id=" + newProduct.id;

    });
}

function setHotProductDiv(divId, newProduct) {
    $('#' + divId).append(`
                 <div class="col-lg-3 col-md-4 col-sm-6 col-12">
                        <div class="product-single-item">
                            <div class="image">
                                <img src="static/picture/5.jpg" alt="">
                                <ul class="cart-wrap">
                                    <li>
                                        <a href="shop-single.html" data-bs-toggle="tooltip" data-bs-html="true"
                                           title="Shop"><i class="fi flaticon-shopping-bag"></i></a>
                                    </li>
                                    <li data-bs-toggle="modal" data-bs-target="#popup-quickview">
                                        <button data-bs-toggle="tooltip" data-bs-html="true" title="Quick View"><i
                                                class="fi ti-eye"></i></button>
                                    </li>
                                    <li>
                                        <a href="wishlist.html" data-bs-toggle="tooltip" data-bs-html="true"
                                           title="wishlist"><i class="fa flaticon-heart" aria-hidden="true"></i></a>
                                    </li>
                                </ul>
                            </div>
                            <div class="text">
                                <div class="price">
                                    <span class="present-price">$45.30</span>
                                    <del class="old-price">$70.50</del>
                                </div>
                                <h2><a href="shop-single.html">Woman winter cloths</a></h2>
                                <div class="rating-product">
                                    <i class="fa fa-star" aria-hidden="true"></i>
                                    <i class="fa fa-star" aria-hidden="true"></i>
                                    <i class="fa fa-star" aria-hidden="true"></i>
                                    <i class="fa fa-star" aria-hidden="true"></i>
                                    <i class="fa fa-star-half-o" aria-hidden="true"></i>
                                    <span>25 reviews</span>
                                </div>
                            </div>
                        </div>
                    </div>
                 `);
    $('.btn-wrap.cart-link', '#' + divId).last().on('click', function () {
        addCart(newProduct.id);
    });
    $('.view-btn.tooltip', '#' + divId).last().on('click', function () {
        window.location.href = "single-product.html?id=" + newProduct.id;

    });
}

function clickToProduct(id) {
    window.location.href = "single-product.html?id=" + id;
}

function setBrandList(brand) {
    $('#div-brand-list').append(` <img src="${brand.logo}" alt="phone" class="brand-image">`);
}


function initCategoryTreeList() {
    $.ajax({
        url: requestUrl + 'product/categoryTreeList',
        type: "GET",
        success: function (data) {
            if (data.code == 200) {
                $('#metis-menu').empty();
                $("#metis-menu").append('<li><a href="shop.html">All</a></li>');
                $.each(data.data, function (i, dataObject) {
                    var childHtml = '';
                    $.each(dataObject.children, function (i, childData) {
                        childHtml += '<li><a href="shop.html?catagoryId=' + childData.id + '">' + childData.name + '</a></li>';
                    });
                var menuEntry = `
                    <li class="header-catagory-item">
                        <a class="menu-down-arrow" href="#">${dataObject.name}</a>
                        <ul class="header-catagory-single">
                           ${childHtml}
                        </ul>
                    </li>`;
                $("#metis-menu").append(menuEntry);
                });

            }
        },
        error: function (err) {
            console.error("Request failed:", err);
        }
    });
}