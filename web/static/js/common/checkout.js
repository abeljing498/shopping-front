var cartIds = [];
$(document).ready(function () {
    var urlParams = new URLSearchParams(window.location.search);
    var orderId = urlParams.get('orderId');
    var carId = urlParams.get('carId');
    var payTotalMoney = urlParams.get('payTotalMoney');
    var payType = urlParams.get('payType');
    let allCountries = [];

    var token = localStorage.getItem('token');
    if (token) {
        $('#div_login_info').hide();
    } else {
        $('#div_login_info').show();
    }
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
    $('#btn_apply').click(function () {
        if ($('#text_coupon_code').val() == '') {
            alert("Please enter the coupon code!");
            $('#text_coupon_code').focus();
            return false;
        }
        // var order = {};
        // order.cartIds = cartIds
        // order.couponCode = $('#text_coupon_code').val();
        // // 发起POST请求到购物车添加端点
        // ajaxRequest('POST', 'member/coupon/applyCouponById', null, order, function (response) {
        //     if (response.code == 200) {
        //         if (response.data.length === 0) {
        //             alert("Sorry, there are no available coupons！")
        //             $('#text_coupon_code').focus();
        //         } else {
        //             $('#p_giftCard').empty();
        //             $('#p_giftCard').html("-" + response.data[0].amount);
        //             // loadCartData(response.data[0].amount);
        //         }
        //
        //     }
        //
        // })
        return  false;
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
    initAddressDetail();
    if (payType === 'buynow') {
        loadCartLocal(0.00);
    } else {
        loadCartData(0.00);
    }

});

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

function loadCartData(couponMoney) {
    ajaxRequest('GET', 'cart/list', null, null, function (response) {
        if (response.code == 200) {
            var $cartBody = $('#cartBody');
            $cartBody.empty(); // 清空现有的表格行
            var total = 0;

            $.each(response.data, function (index, item) {
                // 解析 productAttr 以获取所有属性
                var attrs = JSON.parse(item.productAttr);
                var attrValues = '';

                // 只提取属性值并用斜杠分隔，并设置样式
                if (attrs.length > 0) {
                    attrValues = attrs.map(function (attr) {
                        return `<span style="color: #ff4d4d; font-size: smaller;">${attr.value}</span>`;
                    }).join(' / ');
                    attrValues = `<br><small>${attrValues}</small>`;
                }

                // 构造新的行结构
                var row = `
                <tr>
                    <td class="product-name">
                        <p>${item.productName} × ${item.quantity}${attrValues}</p>
                    </td>
                    <td class="product-price">
                        <p>$${(item.price * item.quantity).toFixed(2)}</p>
                    </td>
                </tr>`;
                $cartBody.append(row);
                cartIds.push(item.id);
                total += item.price * item.quantity;
            });

            // 添加小计行（如果需要）
            var subtotalRow = `
            <tr>
                <td class="product-name"><p>Subtotal</p></td>
                <td class="product-price"><p>$${total.toFixed(2)}</p></td>
            </tr>
            <tr>
                <td class="product-name"><p>Gift card</p></td>
                <td class="product-price"><p id="p_giftCard">-$${couponMoney.toFixed(2)}</p></td>
            </tr>`;
            $cartBody.append(subtotalRow);
            $('#p_total_price').html("$" + (total - couponMoney).toFixed(2));
        }
    });

}

function loadCartLocal(couponMoney) {
    let item = getJsonData('buy_now_product');
    var $cartBody = $('#cartBody');
    $cartBody.empty(); // 清空现有的表格行
    var total = 0;
    var attrs = JSON.parse(item.productAttr);
    var attrValues = '';

    // 只提取属性值并用斜杠分隔，并设置样式
    if (attrs.length > 0) {
        attrValues = attrs.map(function (attr) {
            return `<span style="color: #ff4d4d; font-size: smaller;">${attr.value}</span>`;
        }).join(' / ');
        attrValues = `<br><small>${attrValues}</small>`;
    }
    var row = `
                <tr>
                    <td class="product-name">
                        <p>${item.productName} × ${item.quantity}${attrValues}</p>
                    </td>
                    <td class="product-price">
                        <p>$${(item.price * item.quantity).toFixed(2)}</p>
                    </td>
                </tr>`;
    $cartBody.append(row);
    total += item.price * item.quantity;
    var subtotalRow = `
            <tr>
                <td class="product-name"><p>Subtotal</p></td>
                <td class="product-price"><p>$${total.toFixed(2)}</p></td>
            </tr>
            <tr>
                <td class="product-name"><p>Gift card</p></td>
                <td class="product-price"><p id="p_giftCard">-$${couponMoney.toFixed(2)}</p></td>
            </tr>`;
    $cartBody.append(subtotalRow);
    $('#p_total_price').html("$" + (total - couponMoney).toFixed(2));

}

paypal.Buttons({

    createOrder: function (data, actions) {

        if (cartIds.length == 0) {
            alert("Please select products to shopping cart");
            return false;
        }
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
        var order = {};
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
        order.umsMemberReceiveAddress = address;
        order.cartIds = cartIds
        order.payType = 3;
        var token = localStorage.getItem('token');
        return fetch(requestUrl + 'order/generateOrder', {
            method: 'post',
            headers: {
                'content-type': 'application/json',
                'Authorization': 'Bearer ' + token,
                'anonId': getOrCreateAnonymousId(),
                'shopId': shoId
            }, body: JSON.stringify(order)
        }).then(function (res) {
            return res.json();
        }).then(function (orderData) {
            console.info(orderData)
            return orderData.data.orderId;
        });

    },
    onApprove: function (data, actions) {
        // 执行支付
        return fetch(requestUrl + 'paypal/execute-payment', {
            method: 'post',
            headers: {
                'content-type': 'application/json'
            },
            body: JSON.stringify(data)
        }).then(function (res) {
            return res.json();
        }).then(function (details) {
            if (details.code == 200) {
                alert("You have completed payment");
            }
        });
    }, onCancel: function (data) {
        return fetch(requestUrl + 'paypal/cancelPayment', {
            method: 'post',
            headers: {
                'content-type': 'application/json'
            },
            body: JSON.stringify(data)
        }).then(function (res) {
            return res.json();
        }).then(function (details) {
            if (details.code == 200) {
                alert("Payment was cancelled by the user.");
            }
        });
    }
}).render('#paypal-button-container');

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


