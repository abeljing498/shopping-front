// 设置全局 AJAX 配置
let shoId = "myshopId";

window.requestUrl = "http://localhost:8085/api/";
$.ajaxSetup({
    beforeSend: function (xhr) {
        xhr.setRequestHeader('anonId', getOrCreateAnonymousId());
        xhr.setRequestHeader('shopId', shoId);
        var token = localStorage.getItem('token');
        if (token) {
            xhr.setRequestHeader('Authorization', 'Bearer ' + token);
        }
    },
    complete: function (jqXHR, textStatus) {
        try {
            var isJson = isJsonString(jqXHR.responseText);
            if (isJson) {
                var response = JSON.parse(jqXHR.responseText);
                if (response.code === 401) {
                    $('#login').modal('show');
                }
            }
        } catch (e) {
            // 如果解析失败，忽略错误
            console.error('Failed to parse response:', e);
        }
    },
    error: function (jqXHR, textStatus, errorThrown) {
        // 处理其他错误
        console.error('Error:', textStatus, errorThrown);
    }
});

// 公共的 AJAX 请求函数
function ajaxRequest(method, url, params, json, callback) {
    // 创建 AJAX 请求配置对象
    var settings = {
        type: method,
        url: requestUrl + url,  // 假设 requestUrl 是全局变量或已经定义
        success: function (response) {
            if (callback && typeof callback === 'function') {
                callback(response);
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.error('AJAX Error in operation:', textStatus, errorThrown);
        }
    };

    // 如果有 URL 参数
    if (params) {
        // 将 params 转换成查询字符串
        var queryString = $.param(params);
        // 检查 URL 是否已经有查询字符串
        if (settings.url.indexOf('?') !== -1) {
            settings.url += '&' + queryString;
        } else {
            settings.url += '?' + queryString;
        }
    }

    // 如果是 POST 请求且有 JSON 数据
    if (method.toUpperCase() === 'POST' && json) {
        settings.contentType = 'application/json';
        settings.data = JSON.stringify(json);
    } else if (json) {  // 对于非 POST 请求，如果需要发送 JSON 数据
        settings.data = json;  // 直接使用 data 属性
        settings.contentType = 'application/json';  // 设置 content-type
    }

    // 发送 AJAX 请求
    $.ajax(settings);
}

function getCartInfo() {
    var $cartBody = $('#div_cart_dialog');
    $cartBody.empty(); // 清空现有的表格行
    $('#s_total_money').html('$' + 0.00)
    ajaxRequest('GET', 'cart/list', null, null, function (response) {
        if (response.code == 200) {
            $('.cart-offcanvas-wrapper').addClass('open');
            var total = 0
            $.each(response.data, function (index, item) {
                // var attrs = JSON.parse(item.productAttr);
                // var attrHtml = '';
                //
                // // 为每个属性创建一个显示元素
                // attrs.forEach(function (attr) {
                //     attrHtml += `<span className="sale-price">${attr.key}:${attr.value}</span>`;
                //
                // });
                var row = `
                  <div class="cart-product-wrapper mb-4">
                                <div class="single-cart-product">
                                    <div class="cart-product-thumb"><a href=""><img src="${item.productPic}"
                                                                                    alt="${item.productName}"></a></div>
                                    <div class="cart-product-content">
                                    <h3 class="title no_after"><a href="">${item.productName}</a></h3>
                                    <div class="product-price"><span class="sale-price">$${item.price}*${item.quantity}</span></div>  
                                    </div>
                                </div>
                                <div class="cart-product-remove"><a href="#" onclick="deleteCart(${item.id})"><i class="flaticon-error"></i></a></div>
                            </div>`;
                $cartBody.append(row);
                total += item.price * item.quantity
            });
            $('#s_total_money').html('$' + total)
            $('#s_common_cart_total_price').html(total)
        }

    })
}

function deleteCart(id) {
    // 显示确认对话框
    var result = window.confirm("Are you sure you want to delete this item？");

// 根据用户的响应执行不同的操作
    if (result) {
        var params = {
            ids: [id]
        }
        ajaxRequest('POST', 'cart/delete', null, params, function (response) {
            if (response.code == 200) {
                getCartInfo();
            }

        })
    } else {
        // 用户点击了“取消”
        console.log("用户取消了删除操作");

    }
}

function isJsonString(str) {
    try {
        JSON.parse(str);
    } catch (e) {
        return false;
    }
    return true;
}

function addWish(productId) {
    var params = {
        productId: productId
    }
    ajaxRequest('POST', 'member/productCollection/add', null, params, function (response) {
        if (response.code == 200) {
            getMemberTotal();
            alert("Added to wishlist successfully")
        }
    })
}

function getUserInfo() {
    ajaxRequest('GET', 'sso/info', null, null, function (response) {
        if (response.code == 200) {
            window.location.href = "my-acount-dashboard.html?username=" + response.data.username + "&nickname=" + response.data.nickname;
        }
    })
}

function logout() {
    var result = window.confirm("Are you sure you want to log out?");
    if (result) {
        localStorage.removeItem('token');
        window.location.href = "index.html";
    } else {
    }
}

function getMemberTotal() {
    $('#s_m_wishCount').empty();
    $('#s_pc_wishCount').empty();
    $('#s_common_cart_total_price').empty();
    var token = localStorage.getItem('token');
    if (token != null) {
        ajaxRequest('GET', 'sso/getCartTotal', null, null, function (response) {
            if (response.code == 200) {
                $('#s_m_wishCount').html(response.data.collectTotal);
                $('#s_pc_wishCount').html(response.data.collectTotal);
                $('#s_common_cart_total_price').html(response.data.carInfo.cartTotalPrice);
            }
        })
    } else {
        ajaxRequest('GET', 'visitor/getCartTotal', null, null, function (response) {
            if (response.code == 200) {
                $('#s_m_wishCount').html(response.data.collectTotal);
                $('#s_pc_wishCount').html(response.data.collectTotal);
                $('#s_common_cart_total_price').html(response.data.carInfo.cartTotalPrice);
            }
        })
    }

}

function validateEmail(email) {
    // 定义一个正则表达式来匹配电子邮件格式
    const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

    // 测试输入的email是否匹配正则表达式
    return emailRegex.test(email);
}

function loadAndInitializeHeader() {
    $("#head_div").load("header.html", function () {
        initializeHeaderEvents();
        getMemberTotal();
    });
    $("#footer-placeholder").load("footer.html");

}

function initializeHeaderEvents() {
    $('#btnLogin').click(function () {
        //判断输入是否为空
        if ($('#textUserName').val() === '') {
            alert("Email cannot be empty！");
            $('#textUserName').focus();
            return
        }
        if ($('#textPassword').val() === '') {
            alert("password cannot be empty");
            $('#textPassword').focus();
            return
        }
        var getParams = {
            email: $('#textUserName').val(),
            password: $('#textPassword').val()
        };
        // 发起POST请求到购物车添加端点
        ajaxRequest('POST', 'sso/login', getParams, null, function (response) {
            if (response.code == 200) {
                localStorage.setItem('token', response.data.token);
                alert("Login succeeded！");
                window.location.href = "shop.html";
            } else {
                alert('Incorrect username or password！');
            }

        })
    });
    $('#btnRegister').click(function () {
        //判断输入是否为空
        if ($('#textNewUsername').val() === '') {
            alert("username cannot be empty！");
            $('#textNewUsername').focus();
            return
        }
        if ($('#textNewEmail').val() === '') {
            alert("password cannot be empty");
            $('#textNewEmail').focus();
            return
        }
        if ($('#textNewPassword').val() === '') {
            alert("Email cannot be empty");
            $('#textNewPassword').focus();
            return
        }
        var getParams = {
            username: $('#textNewUsername').val(),
            email: $('#textNewEmail').val(),
            password: $('#textNewPassword').val(),
        };
        // 发起POST请求到购物车添加端点
        ajaxRequest('POST', 'sso/register', getParams, null, function (response) {
            if (response.code == 200) {
                localStorage.removeItem('token');
                alert("register succeeded！");
                $('#login').modal('show');
            } else {
                alert('User registration failed！');
            }

        })
    });
    customFunction();
}

function customFunction() {
    if (location.href.indexOf('ile:') < 0) {
        if (location.href.indexOf('mb') < 0) {
        }
    }
    ;$(window).on("scroll", function (a) {
        var b = $(window).scrollTop();
        if (b < 150) {
            $(".header-bottom, .header-mobile").removeClass("sticky")
        } else {
            $(".header-bottom, .header-mobile").addClass("sticky")
        }
    });
    $(".header-action-btn-search").on("click", function () {
        $("body").addClass("fix");
        $(".offcanvas-search").addClass("open")
    });
    $(".offcanvas-btn-close,.body-overlay").on("click", function () {
        $("body").removeClass("fix");
        $(".offcanvas-search").removeClass("open")
    });
    $(".header-action-btn-cart").on("click", function () {
        $("body").addClass("fix");
        $(".cart-offcanvas-wrapper").addClass("open")
    });
    $(".offcanvas-btn-close,.offcanvas-overlay").on("click", function () {
        $("body").removeClass("fix");
        $(".cart-offcanvas-wrapper").removeClass("open")
    });
    $(".mobile-menu-open").on("click", function () {
        $(".offcanvas-menu").addClass("open");
        $(".menu-overlay").addClass("open")
    });
    $(".menu-close").on("click", function () {
        $(".offcanvas-menu").removeClass("open");
        $(".menu-overlay").removeClass("open")
    });
    $(".menu-overlay").on("click", function () {
        $(".offcanvas-menu").removeClass("open");
        $(".menu-overlay").removeClass("open")
    });
    $(".add").on("click", function () {
        if ($(this).prev().val()) {
            $(this).prev().val(+$(this).prev().val() + 1)
        }
    });
    $(".sub").on("click", function () {
        if ($(this).next().val() > 1) {
            if ($(this).next().val() > 1) {
                $(this).next().val(+$(this).next().val() - 1)
            }
        }
    });
    var $offCanvasNav = $(".mobile-ayira-menu"),
        $offCanvasNavSubMenu = $offCanvasNav.find(".sub-menu, .mega-sub-menu, .menu-item ");
    $offCanvasNavSubMenu.parent().prepend('<span class="mobile-menu-expand"></span>');
    $offCanvasNavSubMenu.slideUp();
    $offCanvasNav.on("click", "li a, li .mobile-menu-expand, li .menu-title", function (b) {
        var a = $(this);
        if ((a.parent().attr("class").match(/\b(menu-item-has-children|has-children|has-sub-menu)\b/)) && (a.attr("href") === "#" || a.hasClass("mobile-menu-expand"))) {
            b.preventDefault();
            if (a.siblings("ul:visible").length) {
                a.parent("li").removeClass("active-expand");
                a.siblings("ul").slideUp()
            } else {
                a.parent("li").addClass("active-expand");
                a.closest("li").siblings("li").find("ul:visible").slideUp();
                a.closest("li").siblings("li").removeClass("active-expand");
                a.siblings("ul").slideDown()
            }
        }
    });
    $(".sub-menu, .mega-sub-menu, .menu-item").parent("li").addClass("menu-item-has-children");
    $(".ayira-menu .mega-sub-menu").parent("li").css("position", "static");
    $("#rating li").on("mouseover", function () {
        var a = parseInt($(this).data("value"), 10);
        var b = $(this).parent().children("li.star");
        Array.from(b, function (d) {
            var e = d.dataset.value;
            var c = d.firstChild;
            if (e <= a) {
                c.classList.add("hover")
            } else {
                c.classList.remove("hover")
            }
        })
    });
    $("#rating").on("mouseleave", function () {
        var a = $(this).find("li.star i");
        Array.from(a, function (b) {
            b.classList.remove("hover")
        })
    });
    $("#rating li").on("click", function (a) {
        var b = parseInt($(this).data("value"), 10);
        var c = $(this).parent().children("li.star");
        Array.from(c, function (e) {
            var f = e.dataset.value;
            var d = e.firstChild;
            if (f <= b) {
                d.classList.remove("hover", "fa-star-o");
                d.classList.add("fa-star")
            } else {
                d.classList.remove("fa-star");
                d.classList.add("fa-star-o")
            }
        })
    });
    var checked = $(".payment-radio input:checked");
    if (checked) {
        $(checked).siblings(".payment-details").slideDown(500)
    }
    $(".payment-radio input").on("change", function () {
        $(".payment-details").slideUp(500);
        $(this).siblings(".payment-details").slideToggle(500)
    });
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-tooltip="tooltip"]'));
    var tooltipList = tooltipTriggerList.map(function (a) {
        return new bootstrap.Tooltip(a)
    });
    $(".color-list li").each(function () {
        var a = $(this).attr("data-color");
        $(this).css("background-color", a)
    });
    $(".color-list li").on("click", function () {
        $(this).siblings(this).removeClass("active").end().addClass("active")
    });
    $(".color-list a").each(function () {
        var a = $(this).attr("data-color");
        $(this).css("background-color", a)
    });
    $(".color-list a").on("click", function () {
        $(this).siblings(this).removeClass("active").end().addClass("active")
    });
    $(".widget-size li").on("click", function () {
        $(this).siblings(this).removeClass("active").end().addClass("active")
    });
    $("#new_arrivals").owlCarousel({
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
    });
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
    $("#trendingCollections").owlCarousel({
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
    $("#lookbook").owlCarousel({
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
            768: {items: 2,},
            991: {items: 2, loop: true, dots: true,},
            1000: {items: 2, loop: true,},
        }
    });
    $("#best_selling").owlCarousel({
        items: 4,
        margin: 30,
        nav: true,
        autoplay: false,
        autoplayHoverPause: true,
        loop: false,
        navText: ["<i class='flaticon-left-arrow'></i>", "<i class='flaticon-right-arrow'></i>"],
        responsive: {
            0: {items: 1, slideBy: 1},
            576: {items: 2,},
            768: {items: 3, slideBy: 3},
            991: {items: 3, loop: true, dots: true,},
            1000: {items: 4, loop: true,},
        }
    });
    $("#trending_products").owlCarousel({
        items: 4,
        margin: 30,
        nav: true,
        autoplay: false,
        autoplayHoverPause: true,
        loop: false,
        navText: ["<i class='flaticon-left-arrow'></i>", "<i class='flaticon-right-arrow'></i>"],
        responsive: {
            0: {items: 1, slideBy: 1},
            576: {items: 2,},
            768: {items: 3, slideBy: 3},
            991: {items: 3, loop: true, dots: true,},
            1000: {items: 4, loop: true,},
        }
    });
    $("#testimonials").owlCarousel({
        stagePadding: 98,
        loop: true,
        margin: 30,
        nav: true,
        navText: ["<i class='flaticon-left-arrow'></i>", "<i class='flaticon-right-arrow'></i>"],
        responsive: {0: {items: 1, stagePadding: 0,}, 600: {items: 1, stagePadding: 0,}, 1000: {items: 1}}
    });
    $("#brands").owlCarousel({
        loop: true,
        margin: 30,
        nav: true,
        navText: ["<i class='flaticon-back'></i>", "<i class='flaticon-next'></i>"],
        responsive: {0: {items: 2}, 600: {items: 3}, 1000: {items: 5}}
    });
    $("#latest_news").owlCarousel({
        loop: true,
        margin: 30,
        nav: true,
        navText: ["<i class='flaticon-left-arrow'></i>", "<i class='flaticon-right-arrow'></i>"],
        responsive: {
            0: {items: 1, slideBy: 1},
            576: {items: 2,},
            768: {items: 2, slideBy: 2},
            991: {items: 3, loop: true, dots: true,},
            1000: {items: 3, loop: true,},
        }
    });
    $("#instagram").owlCarousel({
        items: 4,
        margin: 1,
        nav: true,
        autoplay: false,
        autoplayHoverPause: true,
        loop: false,
        navText: ["<i class='flaticon-left-arrow'></i>", "<i class='flaticon-right-arrow'></i>"],
        responsive: {
            0: {items: 1,},
            576: {items: 3,},
            768: {items: 4, slideBy: 4},
            991: {items: 3, loop: true, dots: true,},
            1000: {items: 5, loop: true,},
            1200: {items: 6, loop: true,},
        }
    });
    $("#testimonials-tow").owlCarousel({
        loop: true,
        margin: 30,
        nav: true,
        autoplay: true,
        navText: ["<i class='fa fa-arrow-left'></i>", "<i class='fa fa-arrow-right'></i>"],
        responsive: {0: {items: 1}, 767: {items: 1}, 1000: {items: 3}}
    });
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
    $(".filters").on("click", function () {
        $(".filters-area").slideToggle("slow");
        $(this).toggleClass("main")
    });
    $(function () {
        return $(".modal").on("show.bs.modal", function () {
            var a;
            a = this;
            $(".modal").each(function () {
                if (this !== a) {
                    $(this).modal("hide")
                }
            })
        })
    });
    $('a[href="#"]').on("click", function (a) {
        return false;
        a.preventDefault()
    });
    $(".point").on("click", function () {
        var a = $(this).attr("data-image");
        var b = $(this).attr("data-price");
        var c = $(this).attr("data-title");
        $(".product-hero .thumbnail").attr("src", a);
        $(".product-hero .product-title").text(c);
        $(".product-hero .sale-price").text(b);
        $("body").addClass("fix");
        $(".product-hero").addClass("open")
    });
    $(".point-btn-close,.body-overlay").on("click", function () {
        $("body").removeClass("fix");
        $(".product-hero").removeClass("open")
    });
    ;console.log('源代码唯一下载地址: https://www.17sucai.com ');
    if (location.href.indexOf('ile:') < 0) {
        if (location.href.indexOf('mb') < 0) {
        }
    }
    ;
}

$(document).ready(function () {
    loadAndInitializeHeader();

});

function getOrCreateAnonymousId() {
    let anonId = localStorage.getItem('anonUserId');
    if (!anonId) {
        // 如果没有找到匿名ID，则生成新的并保存
        anonId = 'anon-' + Date.now().toString(36) + Math.random().toString(36).substr(2, 5);
        localStorage.setItem('anonUserId', anonId);
    }

    return anonId;
}

// 存储JSON数据
function storeJsonData(key, jsonData) {
    localStorage.setItem(key, JSON.stringify(jsonData));
}

// 获取JSON数据
function getJsonData(key) {
    return JSON.parse(localStorage.getItem(key));
}

// 清除JSON数据
function clearJsonData(key) {
    localStorage.removeItem(key);
}
