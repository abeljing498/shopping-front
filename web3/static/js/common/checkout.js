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