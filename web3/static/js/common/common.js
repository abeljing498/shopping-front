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
            var response = JSON.parse(jqXHR.responseText);
            if (response.code === 401) {
                $('#login').modal('show');
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
function ajaxRequest(method, url, data,contentType, callback) {
    $.ajax({
        type: method,
        url: requestUrl + url,
        data: data, // 传递参数
        contentType : contentType,
        success: function (response) {
            // 成功回调
            callback(response);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            // 在这里可以添加额外的错误处理逻辑
            console.error('AJAX Error in operation:', textStatus, errorThrown);
        }
    });
}

