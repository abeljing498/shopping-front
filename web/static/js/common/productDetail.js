let selectedValues = {};
let skuMap = {}; // 存储解析后的 SKU 数据，方便查找
function initializeProductDetail(productId) {
    $("#div_product_detail_description").empty();
    $("#div_another_note").empty();
    ajaxRequest('GET', 'product/detail/' + productId, null, null, function (response) {
        if (response.code == 200) {
            // 更新产品信息
            var pic = response.data.product.pic;
            $('#img-main-pic').attr('src', pic);
            $("#a-product-name").text(response.data.product.name);
            $("#p-product-dsc").text(response.data.product.description);
            $("#s-product-price").text("$ " + response.data.product.price);
            $("#s-product-old-price").text("$" + response.data.product.originalPrice);
            $("#div_product_detail_description").html(response.data.product.detailHtml);
            $("#div_another_note").html(response.data.product.note);
            $('#a_add_wish').click(function () {
                addWish(response.data.product.id);
            });
            // 初始化所有的 tooltip
            var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-tooltip="tooltip"]'));
            tooltipTriggerList.map(function (tooltipTriggerEl) {
                return new bootstrap.Tooltip(tooltipTriggerEl);
            });

            // 清空并重新填充图片展示区域
            $("#div-product-detail-img1").empty();
            $("#div-product-detail-img2").empty();

            // 构建主图和缩略图HTML字符串
            let mainImages = `<img src="${pic}" alt="Product" class="main-image">`;
            let thumbnailImages = `<div class="divide"><img src="${pic}" alt="Product" class="thumbnail"></div>`;

            // 如果有额外的相册图片，则追加它们
            if (response.data.product.albumPics) {
                const albumPics = response.data.product.albumPics.split(',');
                albumPics.forEach((option, index) => {
                    thumbnailImages += `<div class="divide"><img src="${option}" alt="Product" class="thumbnail"></div>`;
                    mainImages += `<img src="${pic}" alt="Product" class="main-image">`;
                });
            }

            // 将构建好的HTML插入到DOM中
            $("#div-product-detail-img1").html(mainImages);
            $("#div-product-detail-img2").html(thumbnailImages);

            let tempImageStorage = {};
            // SKU处理逻辑（保持不变）
            if (response.data.skuStockList) {
                response.data.skuStockList.forEach(sku => {
                    const attributes = JSON.parse(sku.spData).reduce((acc, curr) => {
                        acc[curr.key] = curr.value;
                        return acc;
                    }, {});
                    sku.attributes = attributes;
                    // 提取SKU中的图片信息，并存储在临时对象中
                    if (sku.pic && !tempImageStorage[sku.pic]) {
                        tempImageStorage[sku.pic] = {skuId: sku.id};
                    }
                    const key = Object.entries(attributes).sort().map(([k, v]) => `${k}-${v}`).join('_');
                    skuMap[key] = sku;
                });
                for (let imgSrc in tempImageStorage) {
                    thumbnailImages += `<div class="divide"><img src="${imgSrc}" alt="Product" class="thumbnail"></div>`;
                    mainImages += `<img src="${imgSrc}" alt="Product" class="main-image">`
                }
                $("#div-product-detail-img1").html(mainImages);
                $("#div-product-detail-img2").html(thumbnailImages);
            }
            // 绑定缩略图点击事件，在Slick初始化之后进行
            initializeSlick();
            // 渲染颜色和其他属性
            renderColors(response.data);
            renderOtherAttributes(response.data);
            // 点击缩略图时更新主图
            $("#div-product-detail-img2").on('click', '.thumbnail', function (event) {
                event.preventDefault(); // 防止默认行为
                const newSrc = $(this).attr('src');
                $(".main-image").attr('src', newSrc);
                // 移动焦点到主图
                $(".main-image").focus();
                $(".main-image").css('opacity', ''); // 清除内联样式中的 opacity
            });
        }
    });
}

// Slick Slider 初始化函数
function initializeSlick() {
    ('#div-product-detail-img1').slick({
        slidesToShow: 1,
        slidesToScroll: 1,
        arrows: false,
        fade: true,
        asNavFor: '#div-product-detail-img2',
        focusOnSelect: true // 当选择一个幻灯片时自动聚焦
    });
    $('#div-product-detail-img2').slick({
        slidesToShow: 4,
        slidesToScroll: 1,
        asNavFor: '#div-product-detail-img1',
        dots: false,
        centerMode: true,
        focusOnSelect: true // 当选择一个幻灯片时自动聚焦
    });
}

function handleSelection($element, attributeName, value) {
    selectedValues[attributeName] = value;
    const key = Object.entries(selectedValues).sort().map(([k, v]) => `${k}-${v}`).join('_');
    const matchingSku = skuMap[key];
    $('#div-product-detail-img1').html(`<img src="${matchingSku.pic}" class="main-image">`);
    console.info(matchingSku)
}
function getColorPic(attributeName, value) {
    var filterValue = {};
    filterValue[attributeName] = value;
    const key = Object.entries(filterValue).sort().map(([k, v]) => `${k}-${v}`).join('_');
    const matchingSku = skuMap[key];
    return matchingSku.pic;
}

$(document).ready(function () {
    var urlParams = new URLSearchParams(window.location.search);
    var id = urlParams.get('id');
    initializeProductDetail(id);
    initializeSlick();
    userReview(1, 20, id);
    $('#btn_add_to_cart').click(function () {
        const key = Object.entries(selectedValues).sort().map(([k, v]) => `${k}-${v}`).join('_');
        const matchingSku = skuMap[key];
        var addCartVaule = {};
        addCartVaule.productId = id;
        addCartVaule.quantity = $('#quantity').val(); // 使用.val()来获取input的值
        if (matchingSku && matchingSku.id !== undefined && matchingSku.id !== null) {
            addCartVaule.productAttr = matchingSku.spData;
            if (matchingSku.id !== null) {
                addCartVaule.productSkuId = matchingSku.id;
            }
        }

        // 发起POST请求到购物车添加端点
        ajaxRequest('POST', 'cart/add', null, addCartVaule, function (response) {
            if (response.code == 200) {
                getMemberTotal();
                alert("Add shopping cart successfully！")
            }

        })

    });
    $('#btn_buy_now').click(function () {
        const key = Object.entries(selectedValues).sort().map(([k, v]) => `${k}-${v}`).join('_');
        const matchingSku = skuMap[key];
        var addCartVaule = {};
        addCartVaule.productId = id;
        addCartVaule.quantity = $('#quantity').val(); // 使用.val()来获取input的值
        if (matchingSku && matchingSku.id !== undefined && matchingSku.id !== null) {
            addCartVaule.productAttr = matchingSku.spData;
            if (matchingSku.id !== null) {
                addCartVaule.productSkuId = matchingSku.id;
            }
            addCartVaule.productName =  $("#a-product-name").text();
            addCartVaule.price = matchingSku.price;
        }
        storeJsonData('buy_now_product', addCartVaule);
        storeJsonData('cheak_out_type', "buyNow");
        window.location.href = 'checkout.html'; // 设置要跳转的URL

    });
    $('#btn_add_review').click(function () {
        addUserReview(id);
    });



    var stars = document.querySelectorAll('.star');
    var scoreInput = document.getElementById('text_nick_score');
    // 为每个星级元素添加点击事件监听器
    stars.forEach(function (star) {
        star.addEventListener('click', function () {
            // 设置隐藏输入字段的值为当前星级的数据值
            scoreInput.value = this.getAttribute('data-value');
        });
    });

});

// 初始化 Slick 插件的函数
function initializeSlick() {
    // 检查是否已经存在 Slick 实例，如果有则销毁
    if ($('#div-product-detail-img1').hasClass('slick-initialized')) {
        $('#div-product-detail-img1').slick('unslick');
    }

    // 初始化 Slick 插件
    $('#div-product-detail-img1').slick({
        slidesToShow: 1,
        slidesToScroll: 1,
        arrows: false,
        fade: true,
        navText: ["<i class='flaticon-next'></i>", "<i class='flaticon-back'></i>"],
        asNavFor: '.slider-nav'
    });

    // 如果需要对第二个容器也进行初始化，可以类似处理
    if ($('#div-product-detail-img2').hasClass('slick-initialized')) {
        $('#div-product-detail-img2').slick('unslick');
    }

    $('#div-product-detail-img2').slick({
        slidesToShow: 4,
        slidesToScroll: 1,
        asNavFor: '.slider-five',
        dots: true,
        centerMode: true,
        focusOnSelect: true,
        arrows: true,
    });
}

function renderColors(data) {
    $('#colors').empty();
    if (!Array.isArray(data.productAttributeList) || data.productAttributeList.length === 0) {
        return; // 如果不存在或为空，直接退出函数
    }
    const colorAttribute = data.productAttributeList.find(attr => attr.name === 'Color');
    if (colorAttribute) {
        let $attributeRow = $('<div>', {'class': 'attribute-row'});
        let $title = $('<span>', {'class': 'widget-title', text: colorAttribute.name + ': '});

        let $listContainer = $('<div>');
        $.each(colorAttribute.inputList.split(','), function (i, value) {
            var colorImageSrc = getColorPic(colorAttribute.name, value.trim()); // 假设图片路径是 images/颜色名.png
            let $tag = $('<span>', {
                'class': `wc-tag ${i === 0 ? 'active' : ''}`, // 默认选中第一个
                click: function (e) {
                    $(this).toggleClass('active').siblings().removeClass('active');
                    handleSelection($(this), colorAttribute.name, value.trim());
                }
            }).append(
                $('<img>', {src: colorImageSrc, alt: value.trim(), 'class': 'me-1'}),
                value.trim()
            );
            $listContainer.append($tag);
            // 如果是第一个元素，则设置为默认选中
            if (i === 0) {
                selectedValues[colorAttribute.name] = value.trim();
                $tag.addClass('active'); // 确保视觉上也显示为选中状态
            }
        });

        $attributeRow.append($title, $listContainer);
        $('#colors').append($attributeRow);
    }
}

function renderOtherAttributes(data) {
    $('#otherAttributes').empty();
    if (!Array.isArray(data.productAttributeList) || data.productAttributeList.length === 0) {
        return; // 如果不存在或为空，直接退出函数
    }
    const otherAttribute = data.productAttributeList;
    $.each(otherAttribute, function (index, attribute) {
        if (attribute.name !== 'Color' && attribute.type === 0) {
            let $attributeRow = $('<div>', {'class': 'attribute-row'});
            let $title = $('<span>', {'class': 'widget-title', text: attribute.name + ': '});
            let $listContainer = $('<div>');
            if (attribute.inputList !== "") {
                $.each(attribute.inputList.split(','), function (i, value) {
                    let $tag = $('<span>', {
                        'class': `wc-tag ${i === 0 ? 'active' : ''}`, // 默认选中第一个
                        click: function (e) {
                            $(this).toggleClass('active').siblings().removeClass('active');
                            handleSelection($(this), attribute.name, value.trim());
                        }
                    }).text(value.trim());
                    $listContainer.append($tag);
                    // 如果是第一个元素，则设置为默认选中
                    if (i === 0) {
                        selectedValues[attribute.name] = value.trim();
                        $tag.addClass('active'); // 确保视觉上也显示为选中状态
                    }
                });
                $attributeRow.append($title, $listContainer);
                $('#otherAttributes').append($attributeRow);
            }
        }
    });
}


function addUserReview(productId) {
    var emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
    var name = $('#text_nick_name').val().trim();
    var email = $('#text_nick_email').val().trim();
    var review = $('#text_nick_review').val().trim();
    // Validate Name field
    if (!name) {
        alert('Name is required.');
        $('#text_nick_name').focus();
        return;
    }

    // Validate Email field
    if (!email) {
        alert('Please enter a valid email address.');
        $('#text_nick_email').focus();
        return;
    } else if (!emailPattern.test(email)) {
        $('#text_nick_email').focus();
        alert('Please enter a valid email address.');
        return;
    }

    // Validate Review field
    if (!review) {
        $('#text_nick_review').focus();
        alert('Review is required.');
        return;
    }
    var review = {};
    review.productId = productId;
    review.nickName = $('#text_nick_name').val();
    review.score = $('#text_nick_score').val();
    review.review = $('#text_nick_review').val();
    review.email = $('#text_nick_email').val();
    // 获取或创建要插入评论的目标容器
    ajaxRequest('POST', 'product/addUserReview', null, review, function (response) {
        if (response.code == 200) {
            alert("thank you for your feedback!");
            userReview(1, 10, productId);
        }
    });
}

// 更新星形显示以反映当前选择的分数
function updateStarDisplay() {
    var currentScore = parseInt(scoreInput.value);
    stars.forEach(function (star, index) {
        if (index < currentScore - 1) {
            star.querySelector('i').classList.replace('fa-star-o', 'fa-star');
        } else {
            star.querySelector('i').classList.replace('fa-star', 'fa-star-o');
        }
    });
}


function userReview(pageNum, pageSize, productId) {
    // 获取或创建要插入评论的目标容器
    var $commentsContainer = $('.reviews-comment .comment-items');
    // 清空当前评论（如果有的话）
    $commentsContainer.empty();
    $('#h_review_total').empty();
    $('#a_review_total').empty();
    $('#span_reviews_total').empty();
    $('#span_reviews_total_pc').empty();

    var params = {};
    params.pageNum = pageNum
    params.pageSize = pageSize;
    params.productId = productId;
    ajaxRequest('GET', 'product/userReview', params, null, function (response) {
        $('#h_review_total').html(`${response.data.total} Reviews`);
        $('#a_review_total').html(` Reviews (${response.data.total})`);
        $('#span_reviews_total').html(`(${response.data.total} customer reviews)`);
        $('#span_reviews_total_pc').html(`(${response.data.total} customer reviews)`);
            $.each(response.data.list, function (index, review) {
                // 创建单条评论的HTML结构
                var $commentItem = $(`
                  <li>
                    <div class="single-comment">
                      <div class="comment-thumb"><img src="static/picture/user.png" alt=""></div>
                      <div class="comment-content">
                        <div class="comment-name-date d-flex">
                          <h5 class="name">${review.nickName} - </h5>
                          <span class="date">${new Date(review.createTime).toLocaleDateString()}</span>
                        </div>
                         <div class="product-rating d-flex">
                        <ul class="d-flex ps-0">
                        ${generateStars(review.score)}
                        </ul></div> 
                        <p>${review.review}</p>
                      </div>
                    </div>
                  </li>
                `);
                $commentsContainer.append($commentItem);
            });

    });
}

function generateStars(score) {
    var starHtml = '';
    var fullStar = ' <li><i class="fa fa-star"></i></li>'; // 实心星

    // 遍历5次，为每个星生成HTML
    for (var i = 1; i <= score; i++) {
        starHtml += fullStar;

    }

    return starHtml;
}
