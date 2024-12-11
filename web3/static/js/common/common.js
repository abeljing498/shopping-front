// 设置全局 AJAX 配置

window.requestUrl = "http://localhost:8085/api/";
$.ajaxSetup({
    beforeSend: function (xhr) {
        var token = localStorage.getItem('token');
        if (token) {
            xhr.setRequestHeader('Authorization', 'Bearer ' + token);
        }
    },
    complete: function (jqXHR, textStatus) {
        try {
            var isJson = isJsonString(jqXHR.responseText);
            if (isJson) {
                var response = JSON.parse(jqXHR.responseText);
                if (response.code === 401) {
                    $('#login').modal('show');
                }
            }
        } catch (e) {
            // 如果解析失败，忽略错误
            console.error('Failed to parse response:', e);
        }
    },
    error: function (jqXHR, textStatus, errorThrown) {
        // 处理其他错误
        console.error('Error:', textStatus, errorThrown);
    }
});

// 公共的 AJAX 请求函数
function ajaxRequest(method, url, params, json, callback) {
    // 创建 AJAX 请求配置对象
    var settings = {
        type: method,
        url: requestUrl + url,  // 假设 requestUrl 是全局变量或已经定义
        success: function (response) {
            if (callback && typeof callback === 'function') {
                callback(response);
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.error('AJAX Error in operation:', textStatus, errorThrown);
        }
    };

    // 如果有 URL 参数
    if (params) {
        // 将 params 转换成查询字符串
        var queryString = $.param(params);
        // 检查 URL 是否已经有查询字符串
        if (settings.url.indexOf('?') !== -1) {
            settings.url += '&' + queryString;
        } else {
            settings.url += '?' + queryString;
        }
    }

    // 如果是 POST 请求且有 JSON 数据
    if (method.toUpperCase() === 'POST' && json) {
        settings.contentType = 'application/json';
        settings.data = JSON.stringify(json);
    } else if (json) {  // 对于非 POST 请求，如果需要发送 JSON 数据
        settings.data = json;  // 直接使用 data 属性
        settings.contentType = 'application/json';  // 设置 content-type
    }

    // 发送 AJAX 请求
    $.ajax(settings);
}

function getCartInfo() {
    var $cartBody = $('#div_cart_dialog');
    $cartBody.empty(); // 清空现有的表格行
    $('#s_total_money').html('$' + 0.00)
    ajaxRequest('GET', 'cart/list', null, null, function (response) {
        if (response.code == 200) {
            $('.cart-offcanvas-wrapper').addClass('open');
            var total = 0
            $.each(response.data, function (index, item) {
                var row = `
                  <div class="cart-product-wrapper mb-4">
                                <div class="single-cart-product">
                                    <div class="cart-product-thumb"><a href=""><img src="${item.productPic}"
                                                                                    alt="${item.productName}"></a></div>
                                    <div class="cart-product-content"><h3 class="title no_after"><a href="">${item.productName}</a></h3>
                                        <div class="product-price"><span class="sale-price">$${item.price}*${item.quantity}</span></div>
                                    </div>
                                </div>
                                <div class="cart-product-remove"><a href="#" onclick="deleteCart(${item.id})"><i class="flaticon-error"></i></a></div>
                            </div>`;
                $cartBody.append(row);
                total += item.price * item.quantity
            });
            $('#s_total_money').html('$' + total)
            $('#s_common_cart_total_price').html(total)
        }

    })
}

function deleteCart(id) {
    // 显示确认对话框
    var result = window.confirm("Are you sure you want to delete this item？");

// 根据用户的响应执行不同的操作
    if (result) {
        var params = {
            ids: [id]
        }
        ajaxRequest('POST', 'cart/delete', null, params, function (response) {
            if (response.code == 200) {
                getCartInfo();
            }

        })
    } else {
        // 用户点击了“取消”
        console.log("用户取消了删除操作");

    }
}

function isJsonString(str) {
    try {
        JSON.parse(str);
    } catch (e) {
        return false;
    }
    return true;
}

function addWish(productId) {
    var params = {
        productId: productId
    }
    ajaxRequest('POST', 'member/productCollection/add', null, params, function (response) {
        if (response.code == 200) {
            getMemberTotal();
            alert("Added to wishlist successfully")
        }
    })
}

function getUserInfo() {
    ajaxRequest('GET', 'sso/info', null, null, function (response) {
        if (response.code == 200) {
            window.location.href = "my-acount-dashboard.html?username=" + response.data.username + "&nickname=" + response.data.nickname;
        }
    })
}

function logout() {
    var result = window.confirm("Are you sure you want to log out?");
    if (result) {
        localStorage.removeItem('token');
        window.location.href = "index.html";
    } else {
    }
}
function getMemberTotal(){
    ajaxRequest('GET', 'sso/getCartTotal', null, null, function (response) {
        if (response.code == 200) {
            $('#s_m_wishCount').html(response.data.collectTotal);
            $('#s_pc_wishCount').html(response.data.collectTotal);
            $('#s_common_cart_total_price').html(response.data.carInfo.cartTotalPrice);
        }
    })
}
