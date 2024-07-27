$(document).ready(function () {
    var urlParams = new URLSearchParams(window.location.search);
    var orderId = urlParams.get('orderId');
    var carId = urlParams.get('carId');
    var payTotalMoney = urlParams.get('payTotalMoney');
    if (payTotalMoney != '') {
        $('#span_subtotal').html(`<bdi><span className="price-currency-symbol">$</span>${payTotalMoney} </bdi>`);
        $('#span_total').html(`<bdi><span className="price-currency-symbol">$</span>${payTotalMoney} </bdi>`);

    }
    $('#input_hidden_card_id').val(carId);
    $('#input_hidden_order_id').val(orderId);
    if (orderId !== null) {
        initOrderDetail(orderId);
    } else {
        initAddressDetail();
    }

    $('#btn_payOrder').click(function () {
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
        if ($('#select_country').val() === '') {
            alert("Country cannot be empty");
            $('#select_country').focus();
            return false
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
        if ($('#text_address_name').val() === '') {
            alert("Street Address cannot be empty");
            $('#text_address_name').focus();
            return false;
        }
        if ($('#text_phone').val() === '') {
            alert("Phone cannot be empty");
            $('#text_phone').focus();
            return false;
        }
        if ($('#text_zip').val() === '') {
            alert("Zip Code cannot be empty");
            $('#text_zip').focus();
            return false
        }
        if ($('#text_address_city').val() === '') {
            alert("Town / City cannot be empty");
            $('#text_address_city').focus();
            return false;
        }
        alert("Order is submitted successfully！");
        if ($('#input_hidden_address_id').val() === '') {
            addUserAddress();
        } else {
            updateUserAddress();
        }
    });
});

function updateUserAddress() {
    var address = {};
    address.firstName = $('#fname').val();
    address.name = $('#lname').val();
    address.company = $('#cname').val();
    address.country = $('#select_country').val();
    address.detailAddress = $('#text_address_name').val();
    address.city = $('#text_address_city').val();
    address.postCode = $('#text_zip').val();
    address.phoneNumber = $('#text_phone').val();
    address.email = $('#text_email').val();
    $.ajax({
        url: requestUrl + 'member/address/update/' + $('#input_hidden_address_id').val(),
        type: "POST",
        data: JSON.stringify(address),
        contentType: "application/json; charset=utf-8",
        success: function (response) {
            if (response.code == 200) {
                console.log("address update success")
                createOrder();
            } else {
                console.log("address update fail")
            }
        },
        error: function (err) {
            console.error("提交失败:", err);
        }
    });

}

function addUserAddress() {
    var address = {};
    address.firstName = $('#fname').val();
    address.name = $('#lname').val();
    address.company = $('#cname').val();
    address.country = $('#select_country').val();
    address.detailAddress = $('#text_address_name').val();
    address.city = $('#text_address_city').val();
    address.postCode = $('#text_zip').val();
    address.phoneNumber = $('#text_phone').val();
    address.email = $('#text_email').val();
    // 发起POST请求到购物车添加端点
    $.ajax({
        url: requestUrl + 'member/address/add',
        type: "POST",
        data: JSON.stringify(address),
        contentType: "application/json; charset=utf-8",
        success: function (response) {
            if (response.code == 200) {
                createOrder();
            } else {
                console.log("address add fail")
            }
        },
        error: function (err) {
            console.error("提交失败:", err);
        }
    });

}

function initOrderDetail(orderId) {
    $.ajax({
        url: requestUrl + 'order/detail/' + orderId,
        type: "GET",
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        success: function (data) {
            if (data.code == 200) {
                var orderDetail = data.data;
                $('#span_subtotal').html(`<bdi><span className="price-currency-symbol">$</span>${orderDetail.totalAmount.toFixed(2)} </bdi>`);
                $('#span_total').html(`<bdi><span className="price-currency-symbol">$</span>${orderDetail.totalAmount.toFixed(2)} </bdi>`);
                initAddressDetail();
            }
        },
        error: function (err) {
            console.error("Request failed:", err);
        }
    });
}

function initAddressDetail() {
    $.ajax({
        url: requestUrl + 'member/address/list',
        type: "GET",
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        success: function (data) {
            if (data.code == 200) {
                $.each(data.data, function (i, addressDetail) {
                    $('#fname').val(addressDetail.firstName ?? '');
                    $('#lname').val(addressDetail.name ?? '');
                    $('#cname').val(addressDetail.company ?? '');
                    if (addressDetail.country) {
                        $('#select_country').val(addressDetail.country);
                    } else {
                        $('#select_country').val(''); // 或者设置一个默认的国家代码
                    }
                    $('#text_address_name').val(addressDetail.detailAddress ?? '');
                    $('#text_address_city').val(addressDetail.city ?? '');
                    $('#text_zip').val(addressDetail.postCode ?? '');
                    $('#text_phone').val(addressDetail.phoneNumber ?? '');
                    $('#text_email').val(addressDetail.email ?? '');
                    $('#input_hidden_address_id').val(addressDetail.id ?? '');

                });


            }
        },
        error: function (err) {
            console.error("Request failed:", err);
        }
    });


}

function createOrder() {
    if ($('#input_hidden_order_id').val() === '') {
        var order = {};
        if ($('#input_hidden_card_id').val() === '') {
            initUserCartList(function (data) {
                var cartIds = [];
                $.each(data, function (i, cartDetail) {
                    cartIds.push(cartDetail.id);
                });
                order.cartIds = cartIds
                order.payType = 0;
                requestCreateDetail(order);
            });

        } else {
            var cartIds = [$('#input_hidden_card_id').val()];
            order.cartIds = cartIds
            order.payType = 0;
            requestCreateDetail(order);
        }

    } else {
        payOrder($('#input_hidden_order_id').val())
    }
}

function initUserCartList(callback) {
    $.ajax({
        url: requestUrl + 'cart/list',
        type: "GET",
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        success: function (data) {
            if (data.code == 200) {
                callback(data.data);
            }
        },
        error: function (err) {
            console.error("Request failed:", err);
        }
    });
}

function payOrder(id) {

    $.ajax({
        url: requestUrl + 'paypal/pay/' + id,
        type: "POST",
        contentType: "application/json; charset=utf-8",
        success: function (response) {
            if (response.code == 200) {
                window.location.href = response.data;
            } else {
                window.location.href ='thank-you.html?status=fail';
            }
        },
        error: function (err) {
            console.error("提交失败:", err);
        }
    });
}
function requestCreateDetail(order){
    if (order.cartIds == null || order.cartIds.length == 0) {
        alert("Please select a product！");
        return false;
    }
    // 发起POST请求到购物车添加端点
    $.ajax({
        url: requestUrl + 'order/generateOrder',
        type: "POST",
        data: JSON.stringify(order),
        contentType: "application/json; charset=utf-8",
        success: function (response) {
            if (response.code == 200) {
                var data = response.data;
                payOrder(data.order.id);
                console.log("generateOrder update success")
            } else {
                console.log("generateOrder update fail")
            }
        },
        error: function (err) {
            console.error("提交失败:", err);
        }
    });
}