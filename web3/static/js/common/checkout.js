
$(document).ready(function () {
    var urlParams = new URLSearchParams(window.location.search);
    var orderId = urlParams.get('orderId');
    var carId = urlParams.get('carId');
    var payTotalMoney = urlParams.get('payTotalMoney');
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
    initAddressDetail();
    loadCartData();
});

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

function updateCountryList(countries) {
    const datalist = $('#country-list');
    datalist.empty(); // 清空当前选项

    countries.forEach(country => {
        $('<option>')
            .val(country.name) // 你可以选择使用 `country.chinese_name` 或 `country.name`
            .text(`${country.name} (${country.code}) - ${country.calling_code}`) // 显示更多信息可选
            .appendTo(datalist);
    });}
function loadCartData() {

    ajaxRequest('GET', 'cart/list', null, null, function (response) {
        if (response.code == 200) {
            var $cartBody = $('#cartBody');
            $cartBody.empty(); // 清空现有的表格行
            var total = 0;

            $.each(response.data, function (index, item) {
                // 解析 productAttr 以获取所有属性
                var attrs = JSON.parse(item.productAttr);
                var attrValues = '';

                // 只提取属性值并用斜杠分隔，并设置样式
                if (attrs.length > 0) {
                    attrValues = attrs.map(function (attr) {
                        return `<span style="color: #ff4d4d; font-size: smaller;">${attr.value}</span>`;
                    }).join(' / ');
                    attrValues = `<br><small>${attrValues}</small>`;
                }

                // 构造新的行结构
                var row = `
                <tr>
                    <td class="product-name">
                        <p>${item.productName} × ${item.quantity}${attrValues}</p>
                    </td>
                    <td class="product-price">
                        <p>$${(item.price * item.quantity).toFixed(2)}</p>
                    </td>
                </tr>`;
                $cartBody.append(row);

                total += item.price * item.quantity;
            });

            // 添加小计行（如果需要）
            var subtotalRow = `
            <tr>
                <td class="product-name"><p>Subtotal</p></td>
                <td class="product-price"><p>$${total.toFixed(2)}</p></td>
            </tr>
            <tr>
                <td class="product-name"><p>Gift card</p></td>
                <td class="product-price"><p>-$${total.toFixed(2)}</p></td>
            </tr>`;
            $cartBody.append(subtotalRow);
        }
    });

}
function validateFormFields() {
    // 定义验证规则
    const validationRules = [
        { selector: '#fname', minLength: 3, message: 'First name must be at least 3 characters long.' },
        { selector: '#lname', minLength: 3, message: 'Last name must be at least 3 characters long.' },
        { selector: '#cname', minLength: 3, message: 'Company name must be at least 3 characters long.' },
        { selector: '#country-input', minLength: 1, message: 'Please select a country.' },
        { selector: '#text_address_name', minLength: 10, message: 'Address name must be at least 10 characters long.' },
        { selector: '#text_address_city', minLength: 3, message: 'City must be at least 3 characters long.' },
        { selector: '#text_zip', minLength: 5, message: 'ZIP code must be at least 5 characters long.' },
        { selector: '#text_phone', minLength: 8, message: 'Phone number must be at least 8 digits long.' },
        {
            selector: '#text_email',
            rule: (value) => /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/.test(value) && value.length >= 5,
            message: 'Invalid email address format.'
        }
    ];

    // 验证函数
    function validateField(rule) {
        const value = $(rule.selector).val();
        let isValid;

        if (rule.rule) {
            isValid = rule.rule(value);
        } else {
            isValid = value && value.length >= rule.minLength;
        }

        handleValidationResult(rule.selector, isValid, rule.message);
        return isValid;
    }

    // 处理验证结果
    function handleValidationResult(selector, isValid, errorMsg) {
        if (!isValid) {
            console.log(`Error in field ${selector}: ${errorMsg}`);
            $(selector).focus(); // 假设有样式 .error 表示错误状态
            alert(errorMsg);
            return false;
        }
    }

    // 遍历并验证每个字段
    const results = validationRules.map(validateField);

    // 返回所有验证是否通过的结果
    return results.every(Boolean); // 如果所有验证都通过，则返回 true
}
// 确保这段代码在DOM完全加载后执行
document.addEventListener("DOMContentLoaded", function (event) {
    paypal.Buttons({
        // 设置样式选项 (可选)
        style: {
            layout: 'vertical', // vertical | horizontal
            color: 'gold',      // gold | blue | silver | black
            shape: 'rect',      // pill | rect
            label: 'pay'        // pay | checkout | buynow | paywith | installment
        },

        // 创建订单时调用此函数
        createOrder: function (data, actions) {
            if (validateFormFields()) {
                var address = {};
                address.firstName = $('#fname').val();
                address.name = $('#lname').val();
                address.company = $('#cname').val();
                address.country = $('#country-input\'').val();
                address.detailAddress = $('#text_address_name').val();
                address.city = $('#text_address_city').val();
                address.postCode = $('#text_zip').val();
                address.phoneNumber = $('#text_phone').val();
                address.email = $('#text_email').val();
                var token = localStorage.getItem('token');
                return fetch(requestUrl+'order/generateOrder', {
                    method: 'post',
                    headers: {
                        'content-type': 'application/json',
                        'Authorization':'Bearer ' + token
                    },
                    body: JSON.stringify({
                        // 这里发送必要的参数给服务器端，例如总价、货币类型等
                        total: '10.00', // 示例金额
                        currency: 'USD',
                        cancelUrl: 'http://localhost:8080/cancel',
                        successUrl: 'http://localhost:8080/success'
                    })
                }).then(function (res) {
                    return res.json();
                }).then(function (orderData) {
                    // 返回订单ID以进行下一步
                    return orderData.id;
                });
            }

        },

        // 当用户批准付款时调用此函数
        onApprove: function (data, actions) {
            return fetch(requestUrl+'/api/paypal/capture-payment', {
                method: 'post',
                headers: {
                    'content-type': 'application/json'
                },
                body: JSON.stringify({
                    orderID: data.orderID
                })
            }).then(function (res) {
                return res.json();
            }).then(function (details) {
                alert('Transaction completed by ' + details.payer.name.given_name);
                // 此处可以重定向到成功的页面或者更新UI
            });
        },

        // 如果用户取消付款，则调用此函数
        onCancel: function (data) {
            // 用户点击取消按钮后的逻辑
            console.log('The payment was cancelled');
        },

        // 发生错误时调用此函数
        onError: function (err) {
            // 错误处理逻辑
            console.error('An error occurred:', err);
        }
    }).render('#paypal-button-container'); // 渲染按钮到页面上的特定位置
});

