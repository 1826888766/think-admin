var element, $, form;
layui.use(['element', 'jquery', 'form'], function () {
    element = layui.element;
    form = layui.form;
    $ = layui.jquery;
    // 渲染菜单
    if (typeof menus !== "undefined") {
        // 监听导航点击

        element.on('nav(mySlide)', function (elem) {
            var data = elem.data()
            if (!data.href) {
                return false;
            }
            setCookie('show_menu_id', data.id);
            var title = data.title || elem.text();
            if (iframe == 1) {
                var href = setUrlParams(data.href, {iframe: 1});
                var id = hex_md5(href);
                var dom = $(".layui-tab-title li[lay-id='" + id + "']");
                if (dom.length) {
                    element.tabChange("myIframe", id)
                    $("#" + id)[0].contentWindow.location.reload(true);
                    return
                }
                element.tabAdd("myIframe", {
                    title: title,
                    content: "<iframe id='" + id + "' class=\"iframe\" src=" + href + " frameborder=\"0\"></iframe>",
                    id: id
                });
                element.tabChange("myIframe", id)
            } else {
                window.location.href = setUrlParams(data.href)
            }
        });
        element.on('nav(myModule)', function (elem) {
            var data = elem.data()
            var index = data.index;
            setCookie('show_module_id', menus[index].id);
            renderMenus(menus[index] ? menus[index].child : [])
        });
        renderModules(menus);
        if (iframe == 0) {
            cacheMenu();
        } else {
            $("#myModule>li").eq(0).addClass('layui-this')
            renderMenus(menus[0] ? menus[0].child : [])
        }
    }
    /**
     * 监听开关
     */
    form.on("switch(changeSwitch)", function (obj) {
        var url = $(this).data('url')
        if (url && url !== "undefined") {

            var dom = $(this), field = dom.attr('name'), status = 0, func = function () {
                var data = {
                    edit_status: 1
                };
                data['field'] = field;
                data['val'] = status;
                url = setUrlParams(url, {id: dom.data('id')})
                $.get(url, data, function (res) {
                    layui.layer.msg(res.msg);
                    if (res.code != 0) {
                        dom.trigger('click');
                        form.render('checkbox');
                    }
                });
            };
            if (this.checked) {
                status = 1;
            }
            var confirm = $(this).attr('confirm');
            if (confirm === undefined) {
                func();
            } else {
                layer.confirm(confirm === 'undefined' ? '你确定要执行操作吗？' : confirm, {
                    title: false,
                    closeBtn: 0
                }, function (index) {
                    func();
                }, function () {
                    dom.trigger('click');
                    form.render('checkbox');
                });
            }
        }
        return false;
    })
    /**
     * 监听提交
     */
    form.on("submit(mlFormSubmit)", function (obj) {
        var action = $(obj.form).attr('action'), timeout = function () {
            setTimeout(function () {
                $(obj.elem).text('保存').prop('disabled', false).removeClass('layui-btn-danger')
            }, 1500)
        };
        $(obj.elem).text('提交中...').prop('disabled', true).addClass('layui-btn-disabled')
        $.ajax({
            url: action,
            method: "POST",
            data: obj.field,
            success: function (res) {
                $(obj.elem).text(res.msg).removeClass('layui-btn-disabled')
                if (res.code == 0) {
                    parent.layer.closeAll()
                    if (typeof parent.layui.ml != "undefined") {
                        parent.layui.ml.tableInstance.reload()
                    } else if(typeof parent.tableInstance!="undefined") {
                        parent.tableInstance.reload()
                    }else{
                        parent.location.reload()
                    }
                }
                timeout()
            },
            error: function (err) {
                $(obj.elem).text('请求出错').addClass('layui-btn-danger').removeClass('layui-btn-disabled')
                timeout()
            }
        })


        return false;
    })
})

function cacheMenu() {
    var module_id = getCookie('show_module_id');
    for (var key in menus) {
        if (menus.hasOwnProperty(key)) {
            if (menus[key].id == module_id) {
                $("#myModule>li").eq(key).addClass('layui-this')
                renderMenus(menus[key].child || [])
                var child = menus[key].child;
                return activeMenus(child)
            }
        }
    }
    $("#myModule>li").eq(0).addClass('layui-this')
    renderMenus(menus[0] ? menus[0].child : [])
}

function activeMenus(child) {
    var menu_id = getCookie('show_menu_id');
    var menu_ids = [];
    for (var key in child) {
        if (child.hasOwnProperty(key)) {
            if (child[key].id == menu_id) {
                menu_ids.push(key);
            } else {
                if (child[key].child && child[key].child.length > 0) {
                    var res = activeMenus(child.child)
                    if (res.length > 0) {
                        menu_ids.push(key);
                        menu_ids = menu_ids.concat(res)
                    }
                }
            }
        }
    }
    for (var index in menu_ids) {
        $("#mySlide>li").eq(menu_ids[index]).addClass('layui-this')
    }
}

function setCookie(cname, cvalue, exdays) {
    document.cookie = cname + "=" + cvalue + "; path=/ ";
}

function getCookie(cname) {
    var name = cname + "=";
    var ca = document.cookie.split(';');
    for (var i = 0; i < ca.length; i++) {
        var c = ca[i].trim();
        if (c.indexOf(name) == 0) {
            return c.substring(name.length, c.length);
        }
    }
    return "";
}

function del(id) {
    $.post("del", {
        id: id
    }, function (res) {
        layer.msg(res.msg)
        if (res.code == 0) {
            layui.ml.tableInstance.reload()
        }
    })
}

function formVal(filter, data) {
    layui.use(['form', 'jquery'], function () {
        var $ = layui.jquery;
        var dom = $('form[lay-filter="' + filter + '"]');
        var form = layui.form;
        for (var key in data) {
            var index, input;
            if (!data.hasOwnProperty(key)) {
                continue;
            }
            if ($.isArray(data[key])) {
                index = "[name='" + key + "[]']";
                input = dom.find(index);
            } else {
                index = "[name='" + key + "']";
                input = dom.find(index);
            }
            if (input.length == 0) {
                continue;
            }
            if ($(input[0]).attr('type') === 'checkbox') {
                if (typeof (data[key]) == 'object') {
                    for (var j in data[key]) {
                        dom.find(index + "[value='" + data[key][j] + "']").prop('checked', true)
                    }
                } else {
                    input.prop('checked', true);
                }
            } else if ($(input[0]).is('select')) {
                input.find('option[value="' + data[key] + '"]').prop("selected", true);
            } else if ($(input[0]).attr('type') === 'radio') {
                dom.find(index + '[value="' + data[key] + '"]').prop('checked', true);
            } else {
                $(input[0]).val(data[key])
            }
        }
        form.render()
    })

}

function layerOpen(url, params, title) {
    params = params || {};
    params['iframe'] = 1;
    if (typeof url == "object") {
        layer.open(url)
    } else {
        layer.open({
            content: setUrlParams(url, params),
            type: 2,
            title: title,
            area: ["850px", "650px"]
        })
    }

}

function back() {
    if (typeof parent.layer != "undefined") {
        parent.layer.closeAll()
    } else {
        window.location.back()
    }
}

function setUrlParams(url, param) {
    var params = [];
    for (var key in param) {
        if (param.hasOwnProperty(key)) {
            params.push(key + '=' + param[key])
        }
    }
    params = params.join('&');
    if (url.indexOf("?") !== -1) {
        url += params ? ("&" + params) : '';
    } else {
        url += params ? ("?" + params) : '';
    }

    return url;
}

function renderModules(modules) {
    var html = "";

    layui.$.each(modules, function (index) {
        html += '<li class="layui-nav-item"><a data-id="' + this.id + '" data-index="' + index + '" href="javascript:;">' + this.name + '</a></li>'
    })
    layui.$("#myModule").html(html);
    element.render('nav', 'myModule')
}

function renderMenus(menus, is_child) {
    var html = "";
    layui.$.each(menus, function () {
        if (is_child) {
            html += '<dl class="layui-nav-child">';
            if (this.target === '_blank') {
                html += '<dd><a target="_blank" data-id="' + this.id + '" href="' + this.url + '">' + this.name + '</a></dd>'
            } else {

                if (layui.$.isArray(this.child) && this.child.length > 0) {
                    html += '<dd><a href="javascript:void(0);" >' + this.name + '</a>';
                    html += renderMenus(this.child, true);
                } else {
                    html += '<dd><a href="javascript:void(0);" data-id="' + this.id + '" data-href="' + this.url + '">' + this.name + '</a>';
                }
            }
            html += '</dd></dl>';
        } else {
            html += '<li class="layui-nav-item layui-nav-itemed">';
            if (this.target === '_blank') {
                html += '<a target="_blank" data-id="' + this.id + '" href="' + this.url + '">' + this.name + '</a>'
            } else {

                if (layui.$.isArray(this.child) && this.child.length > 0) {
                    html += '<a href = "javascript:;" > ' + this.name + ' </a>';
                    html += renderMenus(this.child, true);
                } else {
                    html += '<a data-id="' + this.id + '" data-href="' + this.url + '" href = "javascript:;" > ' + this.name + ' </a>';
                }
            }
            html += '</li>';
        }
    })
    if (is_child) {
        return html;
    }
    layui.$("#mySlide").html(html);
    element.render('nav', 'mySlide')

}

/*
 * A JavaScript implementation of the RSA Data Security, Inc. MD5 Message
 * Digest Algorithm, as defined in RFC 1321.
 * Version 2.1 Copyright (C) Paul Johnston 1999 - 2002.
 * Other contributors: Greg Holt, Andrew Kepert, Ydnar, Lostinet
 * Distributed under the BSD License
 * See http://pajhome.org.uk/crypt/md5 for more info.
 */

/*
 * Configurable variables. You may need to tweak these to be compatible with
 * the server-side, but the defaults work in most cases.
 */
var hexcase = 0;  /* hex output format. 0 - lowercase; 1 - uppercase        */
var chrsz = 8;  /* bits per input character. 8 - ASCII; 16 - Unicode      */

/*
 * These are the functions you'll usually want to call
 * They take string arguments and return either hex or base-64 encoded strings
 */
function hex_md5(s) {
    return binl2hex(core_md5(str2binl(s), s.length * chrsz));
}

/*
 * Calculate the MD5 of an array of little-endian words, and a bit length
 */
function core_md5(x, len) {
    /* append padding */
    x[len >> 5] |= 0x80 << ((len) % 32);
    x[(((len + 64) >>> 9) << 4) + 14] = len;

    var a = 1732584193;
    var b = -271733879;
    var c = -1732584194;
    var d = 271733878;

    for (var i = 0; i < x.length; i += 16) {
        var olda = a;
        var oldb = b;
        var oldc = c;
        var oldd = d;

        a = md5_ff(a, b, c, d, x[i + 0], 7, -680876936);
        d = md5_ff(d, a, b, c, x[i + 1], 12, -389564586);
        c = md5_ff(c, d, a, b, x[i + 2], 17, 606105819);
        b = md5_ff(b, c, d, a, x[i + 3], 22, -1044525330);
        a = md5_ff(a, b, c, d, x[i + 4], 7, -176418897);
        d = md5_ff(d, a, b, c, x[i + 5], 12, 1200080426);
        c = md5_ff(c, d, a, b, x[i + 6], 17, -1473231341);
        b = md5_ff(b, c, d, a, x[i + 7], 22, -45705983);
        a = md5_ff(a, b, c, d, x[i + 8], 7, 1770035416);
        d = md5_ff(d, a, b, c, x[i + 9], 12, -1958414417);
        c = md5_ff(c, d, a, b, x[i + 10], 17, -42063);
        b = md5_ff(b, c, d, a, x[i + 11], 22, -1990404162);
        a = md5_ff(a, b, c, d, x[i + 12], 7, 1804603682);
        d = md5_ff(d, a, b, c, x[i + 13], 12, -40341101);
        c = md5_ff(c, d, a, b, x[i + 14], 17, -1502002290);
        b = md5_ff(b, c, d, a, x[i + 15], 22, 1236535329);

        a = md5_gg(a, b, c, d, x[i + 1], 5, -165796510);
        d = md5_gg(d, a, b, c, x[i + 6], 9, -1069501632);
        c = md5_gg(c, d, a, b, x[i + 11], 14, 643717713);
        b = md5_gg(b, c, d, a, x[i + 0], 20, -373897302);
        a = md5_gg(a, b, c, d, x[i + 5], 5, -701558691);
        d = md5_gg(d, a, b, c, x[i + 10], 9, 38016083);
        c = md5_gg(c, d, a, b, x[i + 15], 14, -660478335);
        b = md5_gg(b, c, d, a, x[i + 4], 20, -405537848);
        a = md5_gg(a, b, c, d, x[i + 9], 5, 568446438);
        d = md5_gg(d, a, b, c, x[i + 14], 9, -1019803690);
        c = md5_gg(c, d, a, b, x[i + 3], 14, -187363961);
        b = md5_gg(b, c, d, a, x[i + 8], 20, 1163531501);
        a = md5_gg(a, b, c, d, x[i + 13], 5, -1444681467);
        d = md5_gg(d, a, b, c, x[i + 2], 9, -51403784);
        c = md5_gg(c, d, a, b, x[i + 7], 14, 1735328473);
        b = md5_gg(b, c, d, a, x[i + 12], 20, -1926607734);

        a = md5_hh(a, b, c, d, x[i + 5], 4, -378558);
        d = md5_hh(d, a, b, c, x[i + 8], 11, -2022574463);
        c = md5_hh(c, d, a, b, x[i + 11], 16, 1839030562);
        b = md5_hh(b, c, d, a, x[i + 14], 23, -35309556);
        a = md5_hh(a, b, c, d, x[i + 1], 4, -1530992060);
        d = md5_hh(d, a, b, c, x[i + 4], 11, 1272893353);
        c = md5_hh(c, d, a, b, x[i + 7], 16, -155497632);
        b = md5_hh(b, c, d, a, x[i + 10], 23, -1094730640);
        a = md5_hh(a, b, c, d, x[i + 13], 4, 681279174);
        d = md5_hh(d, a, b, c, x[i + 0], 11, -358537222);
        c = md5_hh(c, d, a, b, x[i + 3], 16, -722521979);
        b = md5_hh(b, c, d, a, x[i + 6], 23, 76029189);
        a = md5_hh(a, b, c, d, x[i + 9], 4, -640364487);
        d = md5_hh(d, a, b, c, x[i + 12], 11, -421815835);
        c = md5_hh(c, d, a, b, x[i + 15], 16, 530742520);
        b = md5_hh(b, c, d, a, x[i + 2], 23, -995338651);

        a = md5_ii(a, b, c, d, x[i + 0], 6, -198630844);
        d = md5_ii(d, a, b, c, x[i + 7], 10, 1126891415);
        c = md5_ii(c, d, a, b, x[i + 14], 15, -1416354905);
        b = md5_ii(b, c, d, a, x[i + 5], 21, -57434055);
        a = md5_ii(a, b, c, d, x[i + 12], 6, 1700485571);
        d = md5_ii(d, a, b, c, x[i + 3], 10, -1894986606);
        c = md5_ii(c, d, a, b, x[i + 10], 15, -1051523);
        b = md5_ii(b, c, d, a, x[i + 1], 21, -2054922799);
        a = md5_ii(a, b, c, d, x[i + 8], 6, 1873313359);
        d = md5_ii(d, a, b, c, x[i + 15], 10, -30611744);
        c = md5_ii(c, d, a, b, x[i + 6], 15, -1560198380);
        b = md5_ii(b, c, d, a, x[i + 13], 21, 1309151649);
        a = md5_ii(a, b, c, d, x[i + 4], 6, -145523070);
        d = md5_ii(d, a, b, c, x[i + 11], 10, -1120210379);
        c = md5_ii(c, d, a, b, x[i + 2], 15, 718787259);
        b = md5_ii(b, c, d, a, x[i + 9], 21, -343485551);

        a = safe_add(a, olda);
        b = safe_add(b, oldb);
        c = safe_add(c, oldc);
        d = safe_add(d, oldd);
    }
    return Array(a, b, c, d);

}

/*
 * These functions implement the four basic operations the algorithm uses.
 */
function md5_cmn(q, a, b, x, s, t) {
    return safe_add(bit_rol(safe_add(safe_add(a, q), safe_add(x, t)), s), b);
}

function md5_ff(a, b, c, d, x, s, t) {
    return md5_cmn((b & c) | ((~b) & d), a, b, x, s, t);
}

function md5_gg(a, b, c, d, x, s, t) {
    return md5_cmn((b & d) | (c & (~d)), a, b, x, s, t);
}

function md5_hh(a, b, c, d, x, s, t) {
    return md5_cmn(b ^ c ^ d, a, b, x, s, t);
}

function md5_ii(a, b, c, d, x, s, t) {
    return md5_cmn(c ^ (b | (~d)), a, b, x, s, t);
}

/*
 * Add integers, wrapping at 2^32. This uses 16-bit operations internally
 * to work around bugs in some JS interpreters.
 */
function safe_add(x, y) {
    var lsw = (x & 0xFFFF) + (y & 0xFFFF);
    var msw = (x >> 16) + (y >> 16) + (lsw >> 16);
    return (msw << 16) | (lsw & 0xFFFF);
}

/*
 * Bitwise rotate a 32-bit number to the left.
 */
function bit_rol(num, cnt) {
    return (num << cnt) | (num >>> (32 - cnt));
}

/*
 * Convert a string to an array of little-endian words
 * If chrsz is ASCII, characters >255 have their hi-byte silently ignored.
 */
function str2binl(str) {
    var bin = Array();
    var mask = (1 << chrsz) - 1;
    for (var i = 0; i < str.length * chrsz; i += chrsz)
        bin[i >> 5] |= (str.charCodeAt(i / chrsz) & mask) << (i % 32);
    return bin;
}

/*
 * Convert an array of little-endian words to a hex string.
 */
function binl2hex(binarray) {
    var hex_tab = hexcase ? "0123456789ABCDEF" : "0123456789abcdef";
    var str = "";
    for (var i = 0; i < binarray.length * 4; i++) {
        str += hex_tab.charAt((binarray[i >> 2] >> ((i % 4) * 8 + 4)) & 0xF) +
            hex_tab.charAt((binarray[i >> 2] >> ((i % 4) * 8)) & 0xF);
    }
    return str;
}