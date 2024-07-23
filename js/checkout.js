$(document).ready(function () {
    var urlParams = new URLSearchParams(window.location.search);
    var orderId = urlParams.get('orderId');
    if (orderId !== null) {
        initProductDetail(orderId);
    }
    var data = initProductDetail(id);

    $('#btn_add_cart').click(function () {
        let allAttrsSelected = true;
        let msg = "";
        Object.keys(changeSelectionState).forEach(attrName => {
            if (!changeSelectionState[attrName]) {
                msg = `请先选择${attrName}`;
                allAttrsSelected = false;
                return false;
            }
        });
        if (allAttrsSelected === false) {
            alert(msg)
            return false;
        }
        var addCartVaule = {};
        addCartVaule.productId = productData.data.product.id;
        addCartVaule.productAttr = JSON.stringify(productAttr);
        addCartVaule.quantity = $('#quantity').val(); // 使用.val()来获取input的值
        // 发起POST请求到购物车添加端点
        $.ajax({
            url: requestUrl + 'cart/add',
            type: "POST",
            data: JSON.stringify(addCartVaule),
            contentType: "application/json; charset=utf-8",
            success: function (response) {
                if (response.code == 200) {
                    alert("添加到购物车成功！");
                    window.location.href = "cart.html";
                } else {
                    alert('添加到购物车失败！');
                }
            },
            error: function (err) {
                console.error("提交失败:", err);
            }
        });
    });
    initIncrementDecrement();
});


function initProductDetail(orderId) {
    $.ajax({
        url: requestUrl + 'order/detail' + orderId,
        type: "GET",
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        success: function (data) {
            if (data.code == 200) {
                    var orderDetail = data.data;
                    $('#fname').text(orderDetail.name);
                    $('#lname').text(order.productName);
                    $('#cname').text(order.productPrice);
                    $('#select_country').text(JSON.stringify(order.productAttr));
                    $('#text_address_name').val(order.count);
                $('#text_address_state').val(order.count);
                $('#text_address_city').val(order.count);
                $('#text_zip').val(order.count);
                $('text_phone').val(order.count);
                $('text_email').val(order.count);
                $('text_address_suite').val(order.count);

            }
        },
        error: function (err) {
            console.error("Request failed:", err);
        }
    });
}

function initAddressDetail() {
    $.ajax({
        url: requestUrl + 'order/detail' + orderId,
        type: "GET",
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        success: function (data) {
            if (data.code == 200) {

            }
        },
        error: function (err) {
            console.error("Request failed:", err);
        }
    });
}