var productData = null;
var productAttr = []; // 存储最终的JSON数组
var currentSelection = {}; // 跟踪每个属性的当前选择值
var changeSelectionState = {}; // 跟踪每个属性的当前选择值
function initProductDetail(productId) {
    ajaxRequest('GET', 'product/detail/' + productId, null, function (response) {
        if (response.code == 200) {
            productData = response;
            var pic = response.data.product.pic;
            var pics = "";
            if (response.data.product.albumPics !== '') {
                pics = pic + ',' + response.data.product.albumPics;
            } else {
                pics = pic;
            }
            $('#img-main-pic').attr('src', pic);
            $("#a-product-name").text(response.data.product.name);
            $("#p-product-dsc").text(response.data.product.description);
            $("#s-product-price").text("$ " + response.data.product.price);
            $("#s-product-old-price").text("$" + response.data.product.originalPrice);
            // 商品属性
            $.each(response.data.productAttributeList, function (index, item) {
                var attr = {};
                attr.name = item.name;
                attr.value = item.inputList;
                attr.type = item.type;
                productAttr.push(attr);
                // 添加属性选择框
                if (item.type == 0) {
                    var colorCode = '';
                    if (item.name ==='Color'|| item.name==='color') {
                        $("#div-product-attr").empty();
                        var attr = item.inputList.split(',');
                        var colorOptionsHtml='';
                        for (var i = 0; i < attr.length; i++) {
                            var color = attr[i];
                            //将以下代码替换成12种颜色代码
                            if (color.indexOf('Black') != -1) {
                                colorCode = '#000000'; // 黑色
                            } else if (color.indexOf('Blue') != -1) {
                                colorCode = '#1c9bb5'; // 蓝色
                            } else if (color.indexOf('Green') != -1) {
                                colorCode = '#63a809'; // 绿色
                            } else if (color.indexOf('Red') != -1) {
                                colorCode = '#ff0000'; // 红色
                            } else if (color.indexOf('Yellow') != -1) {
                                colorCode = '#ffd700'; // 黄色
                            } else if (color.indexOf('Purple') != -1) {
                                colorCode = '#800080'; // 紫色
                            } else if (color.indexOf('Orange') != -1) {
                                colorCode = '#ffa500'; // 橙色
                            } else if (color.indexOf('Gray') != -1) {
                                colorCode = '#808080'; // 灰色
                            } else if (color.indexOf('White') != -1) {
                                colorCode = '#ffffff'; // 白色
                            } else if (color.indexOf('Brown') != -1) {
                                colorCode = '#a52a2a'; // 棕色
                            } else if (color.indexOf('Pink') != -1) {
                                colorCode = '#ffc0cb'; // 粉色
                            } else if (color.indexOf('Cyan') != -1) {
                                colorCode = '#00ffff'; // 青色
                            } else {
                                colorCode = '#000000'; // 默认颜色为黑色
                            }
                            colorOptionsHtml += '<li class="active ms-0" data-tooltip="tooltip" data-placement="top" title="' + color + '" data-color="' + colorCode + '" data-bs-original-title="' + color + '" aria-label="Blue" style="background-color: rgb(28, 155, 181)";></li>';

                        }
                        $("#div-product-attr").append(`
                                <div class="widget-item d-flex" >
                                    <h4 class="widget-title">${item.name}:</h4>
                                    <div class="widget-color">
                                       <ul class="color-list ps-0">
                                       ${colorOptionsHtml}
                                       </ul>
                                    </div>
                                  </div>
                    `)

                    }else {

                    }

                }
            })


        }

    })
}