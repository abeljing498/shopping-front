$(document).ready(function () {
    $('#btnLogin').click(function () {
        //判断输入是否为空
        if ($('#textUserName').val() === '') {
            alert("Email cannot be empty！");
            $('#textUserName').focus();
            return
        }
        if ($('#textPassword').val() === '') {
            alert("password cannot be empty");
            $('#textPassword').focus();
            return
        }
        var getParams = {
            email: $('#textUserName').val(),
            password: $('#textPassword').val()
        };
        // 发起POST请求到购物车添加端点
        ajaxRequest('POST', 'sso/login', getParams,null, function (response) {
            if (response.code == 200) {
                localStorage.setItem('token', response.data.token);
                alert("Login succeeded！");
                window.location.href = "shop.html";
            } else {
                alert('Incorrect username or password！');
            }

        })
    });
    $('#btnRegister').click(function () {
    //判断输入是否为空
        if ($('#textNewUsername').val() === '') {
            alert("username cannot be empty！");
            $('#textNewUsername').focus();
            return
        }
        if ($('#textNewEmail').val() === '') {
            alert("password cannot be empty");
            $('#textNewEmail').focus();
            return
        }
        if ($('#textNewPassword').val() === '') {
            alert("Email cannot be empty");
            $('#textNewPassword').focus();
            return
        }
        var getParams = {
            username: $('#textNewUsername').val(),
            email : $('#textNewEmail').val(),
            password: $('#textNewPassword').val(),
        };
        // 发起POST请求到购物车添加端点
        ajaxRequest('POST', 'sso/register', getParams, null,function (response) {
            if (response.code == 200) {
                localStorage.removeItem('token');
                alert("register succeeded！");
                $('#login').modal('show');
            } else {
                alert('User registration failed！');
            }

        })
    });

});