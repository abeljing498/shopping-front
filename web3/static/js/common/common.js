// 设置全局 AJAX 配置
window.requestUrl = "http://localhost:8085/api/";
$.ajaxSetup({
    complete: function (jqXHR, textStatus) {
        try {
            var response = JSON.parse(jqXHR.responseText);
            if (response.code === 401) {
               alert("Please log in to your account!");
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
function ajaxRequest(method, url, data, callback) {
    $.ajax({
        type: method,
        url: requestUrl+url,
        data: data, // 传递参数
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
// 绑定按钮点击事件
// $(document).ready(function () {
//     $('#getBtn').click(function () {
//         // 定义 GET 请求的参数
//         var getParams = {
//             param1: 'value1',
//             param2: 'value2'
//         };
//         ajaxRequest('GET', 'http://example.com/api/data', getParams, function (response) {
//             console.log('GET Response:', response);
//         });
//     });
//
//     $('#postBtn').click(function () {
//         // 定义 POST 请求的参数
//         var postParams = {
//             key: 'value'
//         };
//         ajaxRequest('POST', 'http://example.com/api/submit', postParams, function (response) {
//             console.log('POST Response:', response);
//         });
//     });
// });
