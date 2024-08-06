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
                            <img src="${data.data.advertiseList[2].pic}" alt="">
                            <div class="hero-text">
                                <h2>${data.data.advertiseList[2].name}</h2>
                                <h3>${data.data.advertiseList[2].note}</h3>
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
                            <h2>${data.data.advertiseList[1].name}</h2>
                            <h3>${data.data.advertiseList[1].note}</h3>
                            <a class="theme-btn" href="shop.html">Shop Now</a>
                        </div>
                    </div>
                    <div class="hero-content">
                        <div class="images">
                            <img src="${data.data.advertiseList[0].pic}" alt="">
                        </div>
                        <div class="hero-text">
                            <h2>${data.data.advertiseList[0].name}</h2>
                            <h3> <h2>${data.data.advertiseList[0].note}</h2></h3>
                            <a class="theme-btn" href="shop.html">Shop Now</a>
                        </div>
                    </div>
                </div>`);
                // $.each(data.data.newProductList, function (i, newProduct) {
                //     setNewProductDiv('div-new-products', newProduct);
                //
                // });
                // $.each(data.data.hotProductList, function (i, hotProduct) {
                //     setHotProductDiv('div-hot-product', hotProduct);
                //
                // });

            }
        },
        error: function (err) {
            console.error("Request failed:", err);
        }
    });
}

function setNewProductDiv(divId, newProduct) {
    $('#' + divId).append(`
                 <div class="swiper-slide">
                    <div class="product-item">
                        <div class="image-holder product-container">
                            <img src="${newProduct.pic}" alt="Books" class="product-image" style="height:100%;width:100%">
                        </div>
                        <div class="cart-concern">
                            <div class="cart-button d-flex justify-content-between align-items-center">
                                <button type="button" class="btn-wrap cart-link d-flex align-items-center"">add to cart
                                    <i class="icon icon-arrow-io"></i>
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
                                <a href="single-product.html?id=${newProduct.id}">${newProduct.name}</a>
                            </h3>
                            <span class="item-price text-primary">$${newProduct.price.toFixed(2)}</span>
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
                <div class="product-item col-lg-3 col-md-6 col-sm-6">
                        <div class="image-holder product-container" >
                            <img src="${newProduct.pic}" alt="Books" class="product-image" style="height:100%;width:100%">
                        </div>
                        <div class="cart-concern">
                            <div class="cart-button d-flex justify-content-between align-items-center">
                                <button type="button" class="btn-wrap cart-link d-flex align-items-center">add to cart
                                    <i class="icon icon-arrow-io"></i>
                                </button>
                                <button type="button" class="view-btn tooltip d-flex">
                                    <i class="icon icon-screen-full"></i>
                                    <span class="tooltip-text">Quick view</span>
                                </button>
                                <button type="button" class="wishlist-btn" >
                                    <i class="icon icon-heart"></i>
                                </button>
                            </div>
                        </div>
                        <div class="product-detail">
                            <h3 class="product-title">
                                <a href="single-product.html?id=${newProduct.id}">${newProduct.name}</a>
                            </h3>
                            <div class="item-price text-primary">$${newProduct.price}</div>
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


