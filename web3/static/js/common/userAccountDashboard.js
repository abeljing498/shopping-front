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
    let allCountries = [];

    // 使用 jQuery 的 $.getJSON 方法读取 JSON 文件
    $.getJSON('static/js/common/countries.json', function (countries) { // 确保路径正确指向你的 JSON 文件
        allCountries = countries;
        updateCountryList(allCountries);
    }).fail(function (jqxhr, textStatus, error) {
        console.error('Error loading countries:', textStatus, error);
    });
    // 添加清除按钮点击事件
    $('#clear-button').click(function () {
        $('#country-input').val(''); // 清除输入框内容
        updateCountryList(allCountries); // 恢复完整的国家列表
        $(this).hide(); // 隐藏清除按钮
    });

    // 当输入框失去焦点时，如果为空则隐藏清除按钮
    $('#country-input').blur(function () {
        if ($(this).val() === '') {
            $('#clear-button').hide();
        }
    });

    // 当输入框获得焦点时，如果有内容则显示清除按钮
    $('#country-input').focus(function () {
        if ($(this).val() !== '') {
            $('#clear-button').show();
        }
    });
    $('#a_save_address').click(function () {
        if ($('#fname').val() === '') {
            alert("First Name cannot be empty！");
            $('#fname').focus();
            return false
        }
        if ($('#lname').val() === '') {
            alert("Last Name cannot be empty");
            $('#lname').focus();
            return false
        }
        if ($('#country-input').val() === '') {
            alert("Country cannot be empty");
            $('#country-input').focus();
            return false
        }

        if ($('#text_address_name').val() === '') {
            alert("Street Address cannot be empty");
            $('#text_address_name').focus();
            return false;
        }
        if ($('#text_address_city').val() === '') {
            alert("Town / City cannot be empty");
            $('#text_address_city').focus();
            return false;
        }
        if ($('#text_zip').val() === '') {
            alert("Zip Code cannot be empty");
            $('#text_zip').focus();
            return false
        }
        if ($('#text_phone').val() === '') {
            alert("Phone cannot be empty");
            $('#text_phone').focus();
            return false;
        }
        if ($('#text_email').val() === '') {
            alert("Email cannot be empty");
            $('#text_email').focus();
            return false
        } else {
            var emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
            var email = $('#text_email').val();
            if (!emailRegex.test(email)) {
                alert("Please enter a valid email address！");
                $('#text_email').focus();
                return false;
            }
        }
        addUserAddress();
    });
    $('#a_user_info_save').click(function () {
        if ($('#inpt_user_info_nickname').val() === '') {
            alert("First Name cannot be empty！");
            $('#inpt_user_info_nickname').focus();
            return false
        }

        if ($('#inpt_user_info_email').val() === '') {
            alert("Email cannot be empty");
            $('#inpt_user_info_email').focus();
            return false
        } else {
            var emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
            var email = $('#inpt_user_info_email').val();
            if (!emailRegex.test(email)) {
                alert("Please enter a valid email address！");
                $('#inpt_user_info_email').focus();
                return false;
            }
        }


        updateUserInfo();
    });


    initAddressDetail();
    getUserInfoDetail();
});

// 辅助函数：更新 <datalist> 中的国家选项
function updateCountryList(countries) {
    const datalist = $('#country-list');
    datalist.empty(); // 清空当前选项

    countries.forEach(country => {
        $('<option>')
            .val(country.name) // 你可以选择使用 `country.chinese_name` 或 `country.name`
            .text(`${country.name} (${country.code}) - ${country.calling_code}`) // 显示更多信息可选
            .appendTo(datalist);
    });
}

function addUserAddress() {
    var address = {};
    address.firstName = $('#fname').val();
    address.name = $('#lname').val();
    address.company = $('#cname').val();
    address.country = $('#country-input').val();
    address.detailAddress = $('#text_address_name').val()+$('#inpt_unit_optional').val();
    address.city = $('#text_address_city').val();
    address.postCode = $('#text_zip').val();
    address.phoneNumber = $('#text_phone').val();
    address.email = $('#text_email').val();
    // 发起POST请求到购物车添加端点
    ajaxRequest('POST', 'member/address/add', null, address, function (response) {
        if (response.code == 200) {
            alert("save address successfully！")
        }

    })

}

function updateUserInfo() {
    var address = {};
    address.firstName = $('#inpt_user_info_nickname').val();
    address.name = $('#inpt_user_info_email').val();
    address.company = $('#cname').val();
    address.country = $('#country-input').val();
    address.detailAddress = $('#text_address_name').val()+$('#inpt_unit_optional').val();
    address.city = $('#text_address_city').val();
    address.postCode = $('#text_zip').val();
    address.phoneNumber = $('#text_phone').val();
    address.email = $('#text_email').val();
    // 发起POST请求到购物车添加端点
    ajaxRequest('POST', 'member/address/add', null, address, function (response) {
        if (response.code == 200) {
            alert("save address successfully！")
        }

    })

}

function initAddressDetail() {
    ajaxRequest('GET', 'member/address/list', null, null, function (response) {
        if (response.code == 200) {
            $.each(response.data, function (i, addressDetail) {
                $('#fname').val(addressDetail.firstName ?? '');
                $('#lname').val(addressDetail.name ?? '');
                $('#cname').val(addressDetail.company ?? '');
                if (addressDetail.country) {
                    $('#country-input').val(addressDetail.country);
                } else {
                    $('#country-input').val(''); // 或者设置一个默认的国家代码
                }
                $('#text_address_name').val(addressDetail.detailAddress ?? '');
                $('#text_address_city').val(addressDetail.city ?? '');
                $('#text_zip').val(addressDetail.postCode ?? '');
                $('#text_phone').val(addressDetail.phoneNumber ?? '');
                $('#text_email').val(addressDetail.email ?? '');
                $('#input_hidden_address_id').val(addressDetail.id ?? '');

            });


        }

    })
}

function getUserInfoDetail() {
    ajaxRequest('GET', 'sso/info', null, null, function (response) {
        if (response.code == 200) {
            $('#inpt_user_info_nickname').val(response.data.nickname)
            $('#inpt_user_info_email').val(response.data.email)
        }
    })
}