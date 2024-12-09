$(document).ready(function () {
    var urlParams = new URLSearchParams(window.location.search);
    var username = urlParams.get('username');
    var nickname = urlParams.get('nickname');
    var strUserName = nickname;
    if (nickname == null) {
        strUserName = username;
    }
    // 显示用户信息strUserName
    $('#div_user_info').empty();
    $('#div_user_info').append(`<p>Hello ${strUserName} <a href="#" class="text_dark" onclick="logout()">Logout</a></p>`);

});