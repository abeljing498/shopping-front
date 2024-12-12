$(document).ready(function () {
    var urlParams = new URLSearchParams(window.location.search);
    var username = urlParams.get('username');
    var nickname = urlParams.get('nickname');
    var strUserName = nickname;
    if (nickname == null) {
        strUserName = username;
    }
    // 显示用户信息strUserName
    $('#div_user_info').empty();
    $('#div_user_info').append(`<p>Hello ${strUserName} <a href="#" class="text_dark" onclick="logout()">Logout</a></p>`);
    let allCountries = [];

    // 使用 jQuery 的 $.getJSON 方法读取 JSON 文件
    $.getJSON('static/js/common/countries.json', function (countries) { // 确保路径正确指向你的 JSON 文件
        allCountries = countries;
        updateCountryList(allCountries);
    }).fail(function (jqxhr, textStatus, error) {
        console.error('Error loading countries:', textStatus, error);
    });
    // 添加清除按钮点击事件
    $('#clear-button').click(function () {
        $('#country-input').val(''); // 清除输入框内容
        updateCountryList(allCountries); // 恢复完整的国家列表
        $(this).hide(); // 隐藏清除按钮
    });

    // 当输入框失去焦点时，如果为空则隐藏清除按钮
    $('#country-input').blur(function () {
        if ($(this).val() === '') {
            $('#clear-button').hide();
        }
    });

    // 当输入框获得焦点时，如果有内容则显示清除按钮
    $('#country-input').focus(function () {
        if ($(this).val() !== '') {
            $('#clear-button').show();
        }
    });
    $('#a_save_address').click(function () {
        if ($('#fname').val() === '') {
            alert("First Name cannot be empty！");
            $('#fname').focus();
            return false
        }
        if ($('#lname').val() === '') {
            alert("Last Name cannot be empty");
            $('#lname').focus();
            return false
        }
        if ($('#country-input').val() === '') {
            alert("Country cannot be empty");
            $('#country-input').focus();
            return false
        }

        if ($('#text_address_name').val() === '') {
            alert("Street Address cannot be empty");
            $('#text_address_name').focus();
            return false;
        }
        if ($('#text_address_city').val() === '') {
            alert("Town / City cannot be empty");
            $('#text_address_city').focus();
            return false;
        }
        if ($('#text_zip').val() === '') {
            alert("Zip Code cannot be empty");
            $('#text_zip').focus();
            return false
        }
        if ($('#text_phone').val() === '') {
            alert("Phone cannot be empty");
            $('#text_phone').focus();
            return false;
        }
        if ($('#text_email').val() === '') {
            alert("Email cannot be empty");
            $('#text_email').focus();
            return false
        } else {
            var emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
            var email = $('#text_email').val();
            if (!emailRegex.test(email)) {
                alert("Please enter a valid email address！");
                $('#text_email').focus();
                return false;
            }
        }
        addUserAddress();
    });
    $('#a_user_info_save').click(function () {
        if ($('#inpt_user_info_nickname').val() === '') {
            alert("First Name cannot be empty！");
            $('#inpt_user_info_nickname').focus();
            return false
        }

        if ($('#inpt_user_info_email').val() === '') {
            alert("Email cannot be empty");
            $('#inpt_user_info_email').focus();
            return false
        } else {
            var emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
            var email = $('#inpt_user_info_email').val();
            if (!emailRegex.test(email)) {
                alert("Please enter a valid email address！");
                $('#inpt_user_info_email').focus();
                return false;
            }
        }
        if ($('#input_original_password').val().length > 0) {
            if ($('#input_new_password').val() === '') {
                alert("The new password cannot be empty！");
                $('#input_new_password').focus();
                return false
            }
            if ($('#input_confirm_password').val() === '') {
                alert("Confirm password cannot be empty！");
                $('#input_confirm_password').focus();
                return false
            }
            if ($('#input_new_password').val().length < 8) {
                console.info($('#input_new_password').val().length);
                alert("The new password cannot be less than 8 characters！");
                $('#input_new_password').focus();
                return false
            }
            if ($('#input_confirm_password').val().length < 8) {
                console.info($('#input_confirm_password').val().length);
                alert("The Confirm password cannot be less than 8 characters！");
                $('#input_confirm_password').focus();
                return false
            }
            if ($('#input_new_password').val() != $('#input_confirm_password').val()) {
                alert("The two password inputs are inconsistent！");
                $('#input_new_password').focus();
                return false
            }
        }
        updateUserInfo();
    });


    initAddressDetail();
    getUserInfoDetail();
    getOrderList('1');
});

// 辅助函数：更新 <datalist> 中的国家选项
function updateCountryList(countries) {
    const datalist = $('#country-list');
    datalist.empty(); // 清空当前选项

    countries.forEach(country => {
        $('<option>')
            .val(country.name) // 你可以选择使用 `country.chinese_name` 或 `country.name`
            .text(`${country.name} (${country.code}) - ${country.calling_code}`) // 显示更多信息可选
            .appendTo(datalist);
    });
}

function addUserAddress() {
    var address = {};
    address.firstName = $('#fname').val();
    address.name = $('#lname').val();
    address.company = $('#cname').val();
    address.country = $('#country-input').val();
    address.detailAddress = $('#text_address_name').val() + $('#inpt_unit_optional').val();
    address.city = $('#text_address_city').val();
    address.postCode = $('#text_zip').val();
    address.phoneNumber = $('#text_phone').val();
    address.email = $('#text_email').val();
    // 发起POST请求到购物车添加端点
    ajaxRequest('POST', 'member/address/add', null, address, function (response) {
        if (response.code == 200) {
            alert("save successfully！");
        }

    })

}

function updateUserInfo() {
    var userInfo = {};
    userInfo.nickname = $('#inpt_user_info_nickname').val();
    userInfo.password = $('#input_confirm_password').val();
    userInfo.email = $('#inpt_user_info_email').val();
    userInfo.originalPassword = $('#input_original_password').val();
    // 发起POST请求到购物车添加端点
    ajaxRequest('POST', 'sso/updateUserInfo', userInfo, null, function (response) {
        if (response.code == 200) {
            if ($('#input_original_password').val().length > 0) {
                localStorage.removeItem('token');
                alert("password changed successfully!");
            } else {
                alert("save successfully！")
            }

        } else {
            alert(response.message);
        }

    })

}

function initAddressDetail() {
    ajaxRequest('GET', 'member/address/list', null, null, function (response) {
        if (response.code == 200) {
            $.each(response.data, function (i, addressDetail) {
                $('#fname').val(addressDetail.firstName ?? '');
                $('#lname').val(addressDetail.name ?? '');
                $('#cname').val(addressDetail.company ?? '');
                if (addressDetail.country) {
                    $('#country-input').val(addressDetail.country);
                } else {
                    $('#country-input').val(''); // 或者设置一个默认的国家代码
                }
                $('#text_address_name').val(addressDetail.detailAddress ?? '');
                $('#text_address_city').val(addressDetail.city ?? '');
                $('#text_zip').val(addressDetail.postCode ?? '');
                $('#text_phone').val(addressDetail.phoneNumber ?? '');
                $('#text_email').val(addressDetail.email ?? '');
                $('#input_hidden_address_id').val(addressDetail.id ?? '');

            });
        }

    })
}

function getUserInfoDetail() {
    ajaxRequest('GET', 'sso/info', null, null, function (response) {
        if (response.code == 200) {
            $('#inpt_user_info_nickname').val(response.data.nickname)
            $('#inpt_user_info_email').val(response.data.email)
        }
    })
}

function getOrderList(status) {
    var orders = [
        {
            "orderSn": "202407250100000022",
            "orderCreateTime": "2024-07-25T14:30:00Z",
            "items": [

                {
                    "id": 134,
                    "orderId": 101,
                    "productId": 29,
                    "productPic": "http://localhost:9000/mall/20241119/p-38.jpg",
                    "productName": "Stylish Grey T-Shirt",
                    "productBrand": "苹果",
                    "productPrice": 5499,
                    "productQuantity": 1,
                    "productAttr": "[{\"key\":\"颜色\",\"value\":\"银色\"},{\"key\":\"屏幕尺寸\",\"value\":\"4.7\"}]"
                }, {
                    "id": 134,
                    "orderId": 101,
                    "productId": 29,
                    "productPic": "http://localhost:9000/mall/20241119/p-38.jpg",
                    "productName": "Stylish Grey T-Shirt",
                    "productBrand": "苹果",
                    "productPrice": 5499,
                    "productQuantity": 1,
                    "productAttr": "[{\"key\":\"颜色\",\"value\":\"银色\"},{\"key\":\"屏幕尺寸\",\"value\":\"4.7\"},{\"key\":\"网络\",\"value\":\"4G\"},{\"key\":\"系统\",\"value\":\"IOS\"},{\"key\":\"电池容量\",\"value\":\"1960ml\"}]"
                }, {
                    "id": 134,
                    "orderId": 101,
                    "productId": 29,
                    "productPic": "http://localhost:9000/mall/20241119/p-38.jpg",
                    "productName": "Stylish Grey T-Shirt",
                    "productBrand": "苹果",
                    "productPrice": 5499,
                    "productQuantity": 1,
                    "productAttr": "[{\"key\":\"颜色\",\"value\":\"银色\"},{\"key\":\"屏幕尺寸\",\"value\":\"4.7\"},{\"key\":\"网络\",\"value\":\"4G\"},{\"key\":\"系统\",\"value\":\"IOS\"},{\"key\":\"电池容量\",\"value\":\"1960ml\"}]"
                }
            ]
        },
        {
            "orderSn": "202407250100000033",
            "orderCreateTime": "2024-07-25T14:30:00Z",
            "items": [

                {
                    "id": 134,
                    "orderId": 101,
                    "productId": 29,
                    "productPic": "http://localhost:9000/mall/20241112/p-03.jpg",
                    "productName": "Stylish Grey T-Shirt",
                    "productBrand": "苹果",
                    "productPrice": 5499,
                    "productQuantity": 1,
                    "productAttr": "[{\"key\":\"颜色\",\"value\":\"银色\"},{\"key\":\"屏幕尺寸\",\"value\":\"4.7\"},{\"key\":\"网络\",\"value\":\"4G\"},{\"key\":\"系统\",\"value\":\"IOS\"},{\"key\":\"电池容量\",\"value\":\"1960ml\"}]"
                }, {
                    "id": 134,
                    "orderId": 101,
                    "productId": 29,
                    "productPic": "http://localhost:9000/mall/20241112/p-03.jpg",
                    "productName": "Stylish Grey T-Shirt",
                    "productBrand": "苹果",
                    "productPrice": 5499,
                    "productQuantity": 1,
                    "productAttr": "[{\"key\":\"颜色\",\"value\":\"银色\"},{\"key\":\"屏幕尺寸\",\"value\":\"4.7\"},{\"key\":\"网络\",\"value\":\"4G\"},{\"key\":\"系统\",\"value\":\"IOS\"},{\"key\":\"电池容量\",\"value\":\"1960ml\"}]"
                }, {
                    "id": 134,
                    "orderId": 101,
                    "productId": 29,
                    "productPic": "http://localhost:9000/mall/20241112/p-03.jpg",
                    "productName": "Stylish Grey T-Shirt",
                    "productBrand": "苹果",
                    "productPrice": 5499,
                    "productQuantity": 1,
                    "productAttr": "[{\"key\":\"颜色\",\"value\":\"银色\"},{\"key\":\"屏幕尺寸\",\"value\":\"4.7\"},{\"key\":\"网络\",\"value\":\"4G\"},{\"key\":\"系统\",\"value\":\"IOS\"},{\"key\":\"电池容量\",\"value\":\"1960ml\"}]"
                }
            ]
        }
    ];
    let params = {
        pageNum: 1, // 默认值为1
        pageSize: 100
    };
    params.status = status;
    $('#div_oder_list').empty();
    $.each(orders, function(orderIndex, order){
        var $orderDiv = $('<div class="my-account-order order-border"><h3 class="widget-title">Order # ' + order.orderSn + '</h3></div>');
        $.each(order.items, function(itemIndex, item){
            var unitPrice = formatPrice(item.productPrice);
            var totalPrice = formatPrice(item.productPrice * item.productQuantity);

            var $row = $('<div class="row"></div>').appendTo($orderDiv);

            // 商品图片和信息
            var $colInfo = $('<div class="col-md-6"><div class="row"></div></div>').appendTo($row);
            var $imgCol = $('<div class="col-md-3"></div>').appendTo($colInfo.find('.row'));
            var $infoCol = $('<div class="col-md-8"></div>').appendTo($colInfo.find('.row'));

            $('<div class="order-img"><img class="w-100" src="' + item.productPic + '" alt="' + item.productName + '"></div>')
                .appendTo($imgCol);
            $('<div class="product-info"></div>')
                .append('<div class="product-title"><a>' + item.productName + '</a></div>')
                .appendTo($infoCol);

            // 商品属性
            var attrs = parseAttrs(item.productAttr);
            $.each(attrs, function(attrIndex, attr){
                var $attrDiv = $('<div class="widget-item d-flex"></div>').appendTo($infoCol);
                $attrDiv.append('<h4 class="widget-title">' + attr.key + ':</h4>');
                $attrDiv.append('<div class="wc-size ms-1">' + attr.value + '</div>');
            });
            // 商品数量、单价、总价
            var $priceCol = $('<div class="col-md-2"></div>').appendTo($row);
            $priceCol.append('<span class="sale-price">Quantity:' + item.productQuantity + '</span>');
            $priceCol.append('<span class="sale-price">Unit Price:'+ unitPrice+ '</span>');
            $priceCol.append('<span class="sale-price">Total Price:'+ totalPrice +'</span>');
            // 订单状态等信息
            var $statusCol = $('<div class="col-md-4"></div>').appendTo($row);
            var $deliveredStatus = $('<div class="delivered_status"></div>').appendTo($statusCol);
            $deliveredStatus.append('<div class="delivered-date">Delivered on Sun, Jan 31</div>');
            $deliveredStatus.append('<div class="order-status">  <div class="canceled"></div>Your item has been delivered</div>');
            $deliveredStatus.append('<div class="order-rate"><a><i class="fa fa-star"></i>Rate &amp;Review Product</a></div>');
        });

        $('#div_oder_list').append($orderDiv);
    });
}

// 辅助函数：格式化日期
function formatDate(isoString) {
    var date = new Date(isoString);
    return date.toLocaleDateString('en-US', { weekday: 'short', year: 'numeric', month: 'short', day: 'numeric' });
}

// 辅助函数：获取产品属性值
function formatPrice(price) {
    return '$' + (price).toFixed(2); // 如果价格是以分为单位存储的
}

function parseAttrs(attrsStr) {
    try {
        return JSON.parse(attrsStr);
    } catch (e) {
        console.error('Error parsing product attributes:', e);
        return [];
    }
}