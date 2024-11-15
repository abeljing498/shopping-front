;console.log('源代码唯一下载地址: https://www.17sucai.com ');
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