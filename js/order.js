$(document).ready(function () {
    searchProduct('-1');
    $('#btn-all').click(function () {
        searchProduct('-1');
    });
    $('#btn-pending').click(function () {
        searchProduct('0');
    });
    $('#btn-ship').click(function () {
        searchProduct('1');
    });
    $('#btn-shipped').click(function () {
        searchProduct('2');
    });
    $('#btn-completed').click(function () {
        searchProduct('3');
    });
    $('#btn-closed').click(function () {
        searchProduct('4');
    });
});

function searchProduct(status) {
    let params = {
        pageNum: 1, // 默认值为1
        pageSize: 100
    };
    params.status = status;
    $.ajax({
        url: requestUrl + 'order/list',
        type: "GET",
        data: params,
        success: function (data) {
            $('#div-orders').empty();
            if (data.code == 200 && data.data.total !== 0) {
                var date = new Date();
                $.each(data.data.list, function (i, order) {
                    var state = order.status;
                    var btnOperate = ``;
                    let displayShippingInfo = false;
                    switch (order.status) {
                        case 0:
                            displayShippingInfo = false;
                            state = "Awaiting Pay";
                             btnOperate = `<button type="button" className="btn btn-sm btn-danger"
                            onClick="checkoutOrder('${order.id}')">Checkout</button`;
                            break;
                        case 1:
                            displayShippingInfo = false;
                            state = "Ready to Ship";
                            break;
                        case 2:
                            displayShippingInfo = true;
                            state = "Shipped";
                            btnOperate = `<button type="button" className="btn btn-sm btn-danger"
                            onClick="confirmOrder('${order.id}')">Confirm receipt</button`;
                            break;
                        case 3:
                            displayShippingInfo = true;
                            state = "Completed";
                            break;
                        case 4:
                            displayShippingInfo = false;
                            state = "Closed";
                            btnOperate = `<button type="button" className="btn btn-sm btn-danger"
                            onClick="deletOrder('${order.id}')">Delete</button>`;
                            break;
                    }

                    let shippingInfo = '';
                    if (displayShippingInfo) {
                        shippingInfo = ` 
                            <div class="container"> 
                                <div class="col-sm-12 col-md-4">
                                  <div class="card">
                                    <div class="card-body">
                                      <h6 class="card-subtitle mb-2 text-muted">Shipping Carrier</h6>
                                      <p class="card-text">${order.deliveryCompany}</p>
                                    </div>
                                  </div>
                                </div>
                            
                                <div class="col-sm-12 col-md-4">
                                  <div class="card">
                                    <div class="card-body">
                                      <h6 class="card-subtitle mb-2 text-muted">Tracking Number</h6>
                                      <p class="card-text">${order.deliverySn}</p>
                                    </div>
                                  </div>
                                </div>
                            
                                <div class="col-sm-12 col-md-4">
                                  <div class="card">
                                    <div class="card-body">
                                      <h6 class="card-subtitle mb-2 text-muted">Consignee</h6>
                                      <p class="card-text">${order.receiverName}</p>
                                    </div>
                                  </div>
                                </div>
                            
                                <div class="col-sm-12">
                                  <div class="card">
                                    <div class="card-body">
                                      <h6 class="card-subtitle mb-2 text-muted">Delivery Time</h6>
                                      <p class="card-text">${format(order.deliveryTime, "yyyy-MM-dd hh:mm:ss")}</p>
                                    </div>
                                  </div>
                                </div>
                              </div>
                            </div>
<hr>`;
                    }
                    let orderDetail = '';
                    var orderItemList = order.orderItemList;
                    $.each(orderItemList, function (i, product) {
                        const productAttrs = JSON.parse(product.productAttr);
                        let attrHtml = '';
                        productAttrs.forEach(attr => {
                            attrHtml += `${attr.key}: ${attr.value} `;
                        });
                        orderDetail += ` <div class="order-item">
                                                <div class="product-image">
                                                    <img src="${product.productPic}" alt="Product Image" class="img-fluid">
                                                </div>
                                                <div class="product-info">
                                                    <span class="product-name">${product.productName}</span>
                                                    <span class="quantity">x ${product.productQuantity}</span>
                                                    <span class="product-attributes"> ${attrHtml} </span>
                                                    <span class="price">$${product.productPrice.toFixed(2)}</span>
                                                </div>
                                            </div>`;

                    });
                    $('#div-orders').append(`  
               <div class="row">
                <hr>
                <div class="col-md-8 col-lg-6 mx-auto">
                    <div class="card mb-4">
                        <div class="card-body">
                            <h5 class="card-title">OrderNo：${order.orderSn}</h5>
                            <div class="order-meta">
                                <small class="text-muted">Order time: ${format(order.createTime, "yyyy-MM-dd hh:mm:ss")}</small>
                                <small class="text-success order-status">Status: ${state}</small>
                            </div>
                            <hr>
                            <div class="order-details">
                                ${orderDetail}
                            </div>
                            <hr> 
                       ${shippingInfo} 
                            <div class="d-flex justify-content-between align-items-center">
                                <p class="order-total">Total: $${order.payAmount.toFixed(2)}</p>
                                <div class="order-actions">
                                 ${btnOperate}
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>`);
                });
            } else {
                $('#div-orders').append(`
                <div class="row">
                    <hr>
                    <div class="col-md-8 col-lg-6 mx-auto">
                        <div class="card mb-4">
                            <div class="card-body">
                                <h5 class="card-title">No orders</h5>
                            </div>
                        </div>
                    </div>
                </div>`);
            }
        },
        error: function (err) {
            console.error("Request failed:", err);
        }
    });
}

function format(date, fmt) {
    if (!date) return "";
    if (!(date instanceof Date)) date = new Date(date);
    var o = {
        "M+": date.getMonth() + 1,
        "d+": date.getDate(),
        "h+": date.getHours(),
        "m+": date.getMinutes(),
        "s+": date.getSeconds(),
        "q+": Math.floor((date.getMonth() + 3) / 3),
        "S": date.getMilliseconds()
    };
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (date.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
        if (new RegExp("(" + k + ")").test(fmt))
            fmt = fmt.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
    return fmt;
}

function confirmOrder(id) {
    let params = {
        orderId: id
    };
    $.ajax({
        url: requestUrl + 'order/confirmReceiveOrder',
        type: 'POST',
        data: params,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        success: function (data) {
            if (data.code == 200) {
                searchProduct('-1');
            }

        },
        error: function (error) {
            console.error('Error:', error);
        }
    });
}

function deletOrder(id) {
    let params = {
        orderId: id
    };
    $.ajax({
        url: requestUrl + 'order/deleteOrder',
        type: 'POST',
        data: params,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        success: function (data) {
            if (data.code == 200) {
                searchProduct('-1');
            }

        },
        error: function (error) {
            console.error('Error:', error);
        }
    });
}

function checkoutOrder(id) {
    window.location.href = "checkout.html?orderId=" + id;
}