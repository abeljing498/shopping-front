$(document).ready(function () {
    var urlParams = new URLSearchParams(window.location.search);
    var orderId = urlParams.get('orderId');
    var carId = urlParams.get('carId');
    $('#input_hidden_card_id').val(carId);
    if (orderId !== null) {
        initOrderDetail(orderId);
    } else {
        initAddressDetail();
    }

    $('#btn_payOrder').click(function () {
        address.firstName = $('#fname').val();
        address.name = $('#lname').val();
        address.company = $('#cname').val();
        address.country = $('#select_country').val();
        address.detailAddress = $('#text_address_name').val();
        address.city = $('#text_address_city').val();
        address.postCode = $('#text_zip').val();
        address.phoneNumber = $('#text_phone').val();
        address.email = $('#text_email').val();
        if ($('#fname').val() === '') {
            alert("First Name cannot be empty！");
            $('#fname').focus();
            return
        }
        if ($('#lname').val() === '') {
            alert("Last Name cannot be empty");
            $('#lname').focus();
            return
        }
        if ($('#select_country').val() === '') {
            alert("Country cannot be empty");
            $('#select_country').focus();
            return
        }
        if ($('#text_email').val() === '') {
            alert("Email cannot be empty");
            $('#text_email').focus();
            return
        } else {
            var emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
            var email = $('#text_email').val();
            if (!emailRegex.test(email)) {
                alert("Please enter a valid email address！");
                $('#text_email').focus();
                return;
            }
        }
        if ($('#text_address_name').val() === '') {
            alert("Street Address cannot be empty");
            $('#text_address_name').focus();
            return
        }
        if ($('#text_phone').val() === '') {
            alert("Phone cannot be empty");
            $('#text_phone').focus();
            return
        }
        if ($('#text_zip').val() === '') {
            alert("Zip Code cannot be empty");
            $('#text_zip').focus();
            return
        }
        if ($('#text_address_city').val() === '') {
            alert("Town / City cannot be empty");
            $('#text_address_city').focus();
            return
        }
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
    // 发起POST请求到购物车添加端点
    $.ajax({
        url: requestUrl + 'member/address/update/' + $('#input_hidden_address_id').val(),
        type: "POST",
        data: JSON.stringify(addCartVaule),
        contentType: "application/json; charset=utf-8",
        success: function (response) {
            if (response.code == 200) {
                console.log("address update success")
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
        data: JSON.stringify(addCartVaule),
        contentType: "application/json; charset=utf-8",
        success: function (response) {
            if (response.code == 200) {
                console.log("address update success")
            } else {
                console.log("address update fail")
            }
        },
        error: function (err) {
            console.error("提交失败:", err);
        }
    });

}

function initOrderDetail(orderId) {
    $.ajax({
        url: requestUrl + 'order/detail' + orderId,
        type: "GET",
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        success: function (data) {
            if (data.code == 200) {
                var orderDetail = data.data;
                $('#fname').val(orderDetail.receiverFirstName ?? '');
                $('#lname').val(orderDetail.receiverName ?? '');
                $('#cname').val(orderDetail.company ?? '');
                if (orderDetail.country) {
                    $('#select_country').val(orderDetail.country);
                } else {
                    $('#select_country').val(''); // 或者设置一个默认的国家代码
                }
                $('#text_address_name').val(orderDetail.receiverDetailAddress ?? '');
                $('#text_address_city').val(orderDetail.receiverCity ?? '');
                $('#text_zip').val(orderDetail.receiverPostCode ?? '');
                $('#text_phone').val(orderDetail.receiverPhone ?? '');
                $('#text_email').val(orderDetail.email ?? '');

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
    if ($('#input_hidden_card_id').val() === '') {
        var data = initUserCartList();
    } else {

    }
}

function initUserCartList(callback) {
    $.ajax({
        url: requestUrl + '/cart/list',
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