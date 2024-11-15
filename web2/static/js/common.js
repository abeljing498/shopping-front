window.requestUrl = "http://localhost:8085/api/";
$(document).ready(function () {
    // 设置全局的AJAX请求拦截器
    $.ajaxSetup({
        beforeSend: function (xhr) {
            var token = localStorage.getItem('token');
            if (token) {
                xhr.setRequestHeader('Authorization', 'Bearer ' + token);
            }
        },
        complete: function (jqXHR, textStatus) {
            // 检查HTTP状态码
            if (jqXHR.responseJSON.code === 401) {
                var oldToken = localStorage.getItem('token');
                if (!oldToken) {
                    window.location.href = "login.html";
                }

                refreshToken();
            }
        }
    });


});
//写一个公共请求数据的方法要求token无需的时候跳转至登录页面


function refreshToken() {
    $.ajax({
        url: requestUrl + "/sso/refreshToken", // 假设的GET请求URL
        type: "GET",
        dataType: "json", // 假设返回的数据格式为JSON
        success: function (data) {
            // 成功刷新Token
            if (data.code == 200) {
                localStorage.setItem('token', data.data.token);
                // 重新发起之前失败的请求
                retryFailedRequest();
            } else {
                // 刷新Token失败，清除本地Token并跳转到登录页
                localStorage.removeItem('token');
                alert('登录失效，请重新登录');
                window.location.href = "login.html";
            }

        }, error: function () {
            // 刷新Token失败，清除本地Token并跳转到登录页
            localStorage.removeItem('token');
            alert('登录失效，请重新登录');
            window.location.href = "login.html";
        }
    });
}

function retryFailedRequest() {
    // 这里需要一种机制来识别并重新触发之前的请求
    // 一个简单的方法是利用jqXHR对象的retry函数（这个函数需要你自己实现）
    // 假设jqXHR对象上有retry方法
    if (typeof this.retry === "function") {
        this.retry();
    } else {
        // 如果没有具体的重试机制，可能需要更复杂的逻辑来跟踪和重发请求
        console.error("没有重试请求的机制");
    }
}

function addCart(id) {
    initProductDetail(id, function (productData) {
        var productAttr = []; // 存储最终的JSON数组
        var product = productData;
        var hasMultipleValues = false; // 添加一个标志变量
        $.each(product.productAttributeValueList, function (i, value) {
            $.each(product.productAttributeList, function (i, attrs) {
                if (attrs.id == value.productAttributeId) {
                    var attributeValueList = value.value.split(",");
                    var colorOptionsHtml = '';
                    // 如果属性值列表长度大于1，意味着需要用户选择
                    if (attributeValueList.length > 1) {
                        hasMultipleValues = true;
                        return false
                    } else {
                        productAttr.push({"key": attrs.name, "value": attributeValueList[0]});
                    }

                }
            });
        });
        if (hasMultipleValues) {
            alert("please select the attribute value and then add it!");
            window.location.href = "single-product.html?id=" + product.product.id;
            return false
        }
        var addCartVaule = {};
        addCartVaule.productId = product.product.id;
        addCartVaule.price = product.product.price;
        addCartVaule.productAttr = JSON.stringify(productAttr);
        addCartVaule.quantity = 1; // 使用.val()来获取input的值
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
}

function initProductDetail(productId, callback) {
    $.ajax({
        url: requestUrl + 'product/detail/' + productId,
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