window.requestUrl = "http://localhost:8085/";
$(document).ready(function () {
    // 模拟登录后保存的token
    // 设置全局的AJAX请求拦截器
    $.ajaxSetup({
        beforeSend: function (xhr) {
            var token = localStorage.getItem('token');
            if (token) {
                xhr.setRequestHeader('Authorization', 'Bearer ' + token);
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            if (jqXHR.status === 401) {
                refreshToken();
                // 这里可以添加token刷新逻辑，然后重试请求
            }
        }
    });

    function refreshToken() {
        var oldToken = localStorage.getItem('token');
        if (!oldToken) return; // 如果没有Token，直接结束
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

});
