function initData() {
    $.ajax({
        url: requestUrl + 'cart/list',
        type: "GET",
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        success: function (data) {
            if (data.code == 200) {
                $('#div_cart_product_list').empty();
                $.each(data.data, function (i, cart) {
                    var totalPrice = cart.quantity * cart.price;
             $('#div_cart_product_list').append(`
          <div class="cart-item border-bottom padding-small">
          <div class="row">
            <div class="col-lg-4 col-md-3">
              <div class="row cart-info d-flex flex-wrap">
                <div class="col-lg-5">
                  <div class="card-image">
                    <img src="${cart.productPic}" alt="cloth" class="img-fluid">
                  </div>
                </div>
                <div class="col-lg-4">
                  <div class="card-detail">
                    <h3 class="card-title">
                      <a >${cart.productName}</a>
                    </h3>
                    <div class="card-price">
                      <span class="money text-primary" data-currency-usd="$${cart.price}">$${cart.price.toFixed(2)}</span>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="col-lg-6 col-md-7">
              <div class="row d-flex">
                <div class="col-md-6">
                  <div class="qty-number d-flex align-items-center justify-content-start">
                    <button class="decrement-button"  onclick="operateNum(this,'decr',${cart.price},${cart.id})">-</button>
                    <input type="text" name="quantity" class="spin-number-output" value="${cart.quantity}" min="1" max="100">
                    <button class="increment-button" id="btnIncreNum" onclick="operateNum(this,'incr',${cart.price},${cart.id})">+</button>
                  </div>
                </div>
                <div class="col-md-4">
                  <div class="total-price">
                    <span class="money text-primary">$${totalPrice.toFixed(2)}</span>
                  </div>
                </div>
              </div>
            </div>
            <div class="col-lg-1 col-md-2">
              <div class="cart-remove">
                <a onclick="deleteCart('${cart.id}')"><i class="icon icon-close"></i></a>
              </div>
            </div>
          </div>
        </div>`);
                });
            }
            var grandTotal = calculateTotal();
            $('#subTotalMoney').html(`<bdi> <span class="price-currency-symbol">$</span>${grandTotal.toFixed(2)}</bdi>`);
            $('#totalMoney').html(`<bdi> <span class="price-currency-symbol">$</span>${grandTotal.toFixed(2)}</bdi>`);
        },
        error: function (err) {
            console.error("Request failed:", err);
        }
    });
}

// 修改JavaScript
function operateNum(element, operation, price,id) {
    // 使用jQuery选择器来获取input元素
    var input = $(element).siblings('.spin-number-output');
    var currentQuantity = parseInt(input.val(), 10);
    var newQuantity = 0;
    if (operation === 'incr') {
        newQuantity = currentQuantity + 1;
    } else if (operation === 'decr' && newQuantity > 1) {
        newQuantity = currentQuantity - 1;
    }
    if (newQuantity <= 0) {
        input.val(1);
    } else {
        input.val(newQuantity);
    }
    updateProductNumber(id,newQuantity);
    updateTotalPrice(input, price);
}

// 确保updateTotalPrice函数已经定义
function updateTotalPrice(input, price) {
    var quantity = parseInt(input.val(), 10);
    var totalPrice = quantity * price;
    // 更新total-price的值
    var totalPriceElement = input.closest('.cart-item').find('.total-price .money');
    totalPriceElement.text('$' + totalPrice.toFixed(2));
    var grandTotal = calculateTotal();
    $('#subTotalMoney').html(`<bdi> <span class="price-currency-symbol">$</span>${grandTotal.toFixed(2)}</bdi>`);
    $('#totalMoney').html(`<bdi> <span class="price-currency-symbol">$</span>${grandTotal.toFixed(2)}</bdi>`);
}

function calculateTotal() {
    var total = 0;
    $('.total-price .money').each(function () {
        // 获取当前元素的文本内容，去掉'$'符号并转换为数字
        var price = parseFloat($(this).text().replace('$', ''));
        total += price;
    });
    return total;
}

function deleteCart(id) {
    $.ajax({
        url: requestUrl + 'cart/delete',
        type: 'POST',
        data: $.param({ // 使用$.param来转换数据
            ids: [id]
        }, true), // 第二个参数true表示使用traditional模式
        processData: false,
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
        success: function (data) {
            if (data.code == 200) {
                initData();
            }

        },
        error: function (error) {
            console.error('Error:', error);
        }
    });

}
function updateProductNumber(id,quantity ){
    $.ajax({
        url: requestUrl + 'cart/update/quantity',
        type: "GET",
        data: $.param({ // 使用$.param来转换数据
            id: id,
            quantity: quantity
        }, true), // 第二个参数true表示使用traditional模式
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        success: function (data) {
            if (data.code == 200) {
               initData();
            }
        },
        error: function (err) {
            console.error("Request failed:", err);
        }
    });
}
function enerateConfirmOrder(id,quantity ){
    $.ajax({
        url: requestUrl + 'order/generateConfirmOrder',
        type: 'POST',
        data: $.param({ // 使用$.param来转换数据
            ids: [id]
        }, true), // 第二个参数true表示使用traditional模式
        processData: false,
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
        success: function (data) {
            if (data.code == 200) {
                initData();
            }

        },
        error: function (error) {
            console.error('Error:', error);
        }
    });
}

$(document).ready(function () {
    initData();

});