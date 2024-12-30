$(document).ready(function () {
    loadCartData();


});

function loadCartData() {

    ajaxRequest('GET', 'cart/list', null, null, function (response) {
        if (response.code == 200) {
            var $cartBody = $('#cartBody');
            $cartBody.empty(); // 清空现有的表格行
            var total=0
            $.each(response.data, function (index, item) {
                // 解析 productAttr 以获取所有属性
                var attrs = JSON.parse(item.productAttr);
                var attrHtml = '';

                // 为每个属性创建一个显示元素
                attrs.forEach(function (attr) {
                    attrHtml += `<div class="widget-item d-flex"><h4 class="widget-title">${attr.key}:</h4><div class="wc-size ms-1">${attr.value}</div></div>`;
                });

                var row = `
                    <tr>
                        <td class="product-action">
                            <div class="cart-product-remove"><a href="#" onclick="deleteCartPage(${item.id})"><i class="flaticon-error"></i></a></div>
                        </td>
                        <td class="product-image"><img src="${item.productPic}" alt="${item.productName}"></td>
                        <td class="product-name">
                            <a class="name" href="#">${item.productName}</a>
                            ${attrHtml}
                        </td>
                        <td class="product-price subtotal">
                            <div class="product-price"><span class="sale-price text_dark">$${item.price}</span></div>
                        </td>
                        <td>
                            <div class="product-quantity d-inline-flex">
                                <button type="button" class="sub" onclick="operateNum(this,'decr',${item.price},${item.id})">-</button>
                                <input type="text" value="${item.quantity}">
                                <button type="button" class="add" onclick="operateNum(this,'incr',${item.price},${item.id})">+</button>
                            </div>
                        </td>
                        <td class="product-price">
                            <div class="product-price"><span class="sale-price">$${(item.price * item.quantity).toFixed(2)}</span></div>
                        </td>
                    </tr>`;
                $cartBody.append(row);
                total+=item.price*item.quantity
            });
            updateTotalPrice(total);
        }

    })

}

function operateNum(element, operation, price, id) {
    // 使用jQuery选择器来获取input元素
    var input = $(element).siblings('input[type=text]');
    var currentQuantity = parseInt(input.val(), 10);
    var newQuantity = 0;
    if (operation === 'incr') {
        newQuantity = currentQuantity + 1;
    } else if (operation === 'decr' && currentQuantity > 1) {
        newQuantity = currentQuantity - 1;
    }
    if (newQuantity <= 0) {
        input.val(1);
        newQuantity = 1;
    } else {
        input.val(newQuantity);
        updateProductNumber(id, newQuantity);
    }
}

function updateTotalPrice(total) {
    $('#subTotalPrice').html('$'+total.toFixed(2));
    $('#totalPrice').html('$'+total.toFixed(2));
}



function updateProductNumber(id, quantity) {
    var params = {
        id: id,
        quantity: quantity
    };

    ajaxRequest('GET', 'cart/update/quantity', params, null, function (response) {
        if (response.code == 200) {
            loadCartData();
        }

    })
}

function deleteCartPage(id) {
    // 显示确认对话框
    var result = window.confirm("Are you sure you want to delete this item？");

// 根据用户的响应执行不同的操作
    if (result) {
        var params = {
            ids: [id]
        }
        ajaxRequest('POST', 'cart/delete', null, params, function (response) {
            if (response.code == 200) {
                loadCartData();
            }

        })
    } else {
        // 用户点击了“取消”
        console.log("用户取消了删除操作");

    }
}