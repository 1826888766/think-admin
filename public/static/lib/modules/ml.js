function eq(a, b) {
    return a == b;
}

layui.define([
    'jquery',
    'form',
    'table',
    'laydate',
    'laytpl',
    'upload',

], function (exports) {
    'use strict';
    const $ = layui.$;
    const table = layui.table;
    const laydate = layui.laydate;
    const form = layui.form;
    const laytpl = layui.laytpl;
    const upload = layui.upload;
    var searchTpl = " <style>\n" +
        "        .page-toolbar {\n" +
        "            height: auto;\n" +
        "        }\n" +
        "\n" +
        "        .page-filter {\n" +
        "            height: auto;\n" +
        "        }\n" +
        "    </style>\n" +
        "    <div class=\"layui-form-item\">\n" +
        "        {{# for (var key in d.field){\n" +
        "        var item = d.field[key];\n" +
        "        }}\n" +
        "        <div class=\"layui-inline\">\n" +
        "            {{# if(item.showLabel!==false){ }}\n" +
        "            <label class=\"layui-form-label\" style=\" min-width: 60px;width: auto;\">{{item.title}}</label>\n" +
        "            {{# } }}\n" +
        "            <div class=\"layui-input-inline\" style=\"width: {{d.width?d.width:180}}px;\">\n" +
        "                {{# if (item.type == 'select') { }}\n" +
        "                <select data-key=\"{{key}}\" {{item.search ?'lay-search':''}}\n" +
        "                lay-filter=\"mlSearchSelect\"\n" +
        "                name=\"{{item.field}}\">\n" +
        "                {{# for(var i in item.options) {\n" +
        "                var option = item.options[i];\n" +
        "                }}\n" +
        "                <option value=\"{{option.value}}\" {{option.value==item.value?'selected':''}}>{{option.name}}</option>\n" +
        "                {{# } }}\n" +
        "                </select>\n" +
        "                {{# } else if(item.type == 'date') { }}\n" +
        "                <input type=\"text\" data-key=\"{{key}}\"\n" +
        "                       name=\"{{item.field}}\"\n" +
        "                       autocomplete=\"off\"\n" +
        "                       value=\"{{item.value||''}}\"\n" +
        "                       placeholder=\"{{item.placeholder||('请选择'+item.title)}}\"\n" +
        "                       class=\"layui-input date{{item.range?'-range':''}}\">\n" +
        "                {{# } else { }}\n" +
        "                <input data-key=\"{{key}}\"\n" +
        "                       value=\"{{item.value||''}}\"\n" +
        "                       autocomplete=\"off\"\n" +
        "                       type=\"text\" name=\"{{item.field}}\"\n" +
        "                       placeholder=\"{{item.placeholder||('请输入'+item.title)}}\"\n" +
        "                       class=\"layui-input\">\n" +
        "                {{# } }}\n" +
        "            </div>\n" +
        "        </div>\n" +
        "        {{# } }}\n" +
        "\n" +
        "        <div class=\"layui-inline\">\n" +
        "            <button type=\"submit\" lay-submit lay-filter=\"mlSearch\"\n" +
        "                    class=\"layui-btn layui-btn-normal\">\n" +
        "                搜索\n" +
        "            </button>\n" +
        "            <button type=\"reset\" onclick=\"ml.reload()\"\n" +
        "                    class=\"layui-btn layui-btn-primary \">\n" +
        "                重置\n" +
        "            </button>\n" +
        "        </div>\n" +
        "    </div>";
    var ml = function () {
        this.v = "0.0.1";
        this.config = {}
    }
    ml.prototype.on = function (e, t) {
        return layui.onevent.call(e, t)
    }

    ml.prototype.success = function () {
    }

    ml.prototype.render = function (config) {
        this.config = initConfig(config)
        renderSearchForm(this.config.search)
        renderTable(this.config.table)
        this.searchListen();
        this.tableListen();
        this.success()
    }
    ml.prototype.search = null

    ml.prototype.reload = function (config) {
        config && (this.config = initConfig(config));
        reloadSearchForm(this.config.search)
        reloadTable(this.config.table)
    }
    ml.prototype.reloadTable = function (config) {
        config && (this.config = initConfig(config));
        reloadTable(this.config.table)
    }
    ml.prototype.reloadSearch = function (config) {
        config && (this.config = initConfig(config));
        reloadSearchForm(this.config.search)
    }

    function createBtns(btns) {
        var html = [];
        $.each(btns, function () {
            var btn = "<span onclick=" + this.click + " class='layui-btn layui-btn-xs " + (this.class || 'layui-btn-normal') + " '>" + this.title + "</span>"
            html.push(btn)
        })
        return "<div><div class='layui-btn-group '>" + html.join("") + "</div></div>"
    }

    function createSwitch(row) {
        var value = row.default ? row.default.split("|") : [];
        var valueDefault = 0;
        var valueChecked = 1;
        if (value.length === 2) {
            valueDefault = value[0]
            valueChecked = value[1]
        } else if (value.length === 1) {
            valueChecked = value[0];
        }
        var text = row.text || '是|否'
        return "<div><input data-id='{{d.id}}' data-url='" + row.url + "' " +
        'confirm="'+row.confirm + '"'  + "name='"+row.field+"'" +
            "{{eq(d." + row.field + "," + valueChecked + ")?'checked':' '}}" +
            " lay-filter='mlSwitch' type='checkbox' value='" + valueDefault + "|" + valueChecked + "' lay-skin='switch'  lay-text='" + text + "'></div>";
    }

    function getUpdateField(config) {
        var update = [];
        $.each(config, function () {
            if (this.update !== false && this.field && this.field !== 'field') {
                update.push(this.field)
            }
        })
        return update;
    }

    function initConfig(config) {
        var filed = []
        $.each(config.cols[0], function () {
            if (this.search) {
                filed.push(this)
            }
            if (this.field == "field") {
                this['templet'] = this['templet'] || createBtns(this.btns)
            }

            if (this.type == "switch") {
                this['templet'] = this['templet'] || createSwitch(this)
            }
        })
        var new_config = {
            table: $.extend({
                elem: "#mlTableData",
                page: true,
                url: GetUrlRelativePath()
            }, config),
            search: {
                elem: config.search_elem || "#mlTableDataSearch",
                field: filed
            },
            update: {
                field: config.update_field || getUpdateField(config.cols[0]),
                url: config.update_url || "edit",
                primary: config.update_primary || "id"
            }
        };

        return new_config;
    }

    function GetUrlRelativePath() {
        var url = document.location.toString();
        var arrUrl = url.split("//");

        var start = arrUrl[1].indexOf("/");
        var relUrl = arrUrl[1].substring(start);

        if (relUrl.indexOf("?") != -1) {
            relUrl = relUrl.split("?")[0];
        }
        return relUrl;
    }

    function renderSearchForm(config) {
        var html = laytpl(searchTpl).render(config)
        $(config.elem).html(html)
        form.render()
    }

    function reloadSearchForm(config) {
        var formJson = {};
        // 转换表单为json
        var formArray = dom.serializeArray();
        $.each(formArray, function () {
            if (formJson[this.name]) {
                if (!formJson[this.name].push) {
                    formJson[this.name] = [formJson[this.name]];
                }
                formJson[this.name].push(this.value || '');
            } else {
                formJson[this.name] = this.value || '';
            }
        });

        if (config.field) {
            $.each(config.field, function () {
                if (formJson.hasOwnProperty(this.field) && formJson[this.field]) {
                    if (!this.value) {
                        this['value'] = formJson[this.field]
                    }
                }
            });
        }
        renderSearchForm(config)
    }


    function renderTable(config) {
        ml.tableInstance = table.render(config)
    }


    function reloadTable(config) {
        ml.tableInstance.reload(config)
    }

    // 渲染多个上传组件
    ml.prototype.renderUploadList = function (elem) {
        var uploadConfig = {
            elem: elem,
            choose: function (obj) {
                console.log(obj)
                var item = this.item;
                var data = $(item).data()
                // 是否预览
                if (data.preview) {
                    var demoListView = $('#' + data.name + 'List')
                    var files; //将每次选择的文件追加到文件队列

                    if (this.multiple) {
                        files = this.files = obj.pushFile()
                    } else {
                        this.files = [];
                        files = this.files = obj.pushFile();
                        demoListView.html("")
                    }
                    if (this.accept !== 'images') {
                        //读取本地文件
                        obj.preview(function (index, file, result) {
                            var tr = $(['<tr id="upload-' + index + '">'
                                , '<td>' + file.name + '</td>'
                                , '<td>' + (file.size / 1024).toFixed(1) + 'kb</td>'
                                , '<td>等待上传</td>'
                                , '<td>'
                                , '<button type="button" class="layui-btn layui-btn-xs ml-upload-reload layui-hide">重传</button>'
                                , '<button type="button" class="layui-btn layui-btn-xs layui-btn-danger ml-upload-delete">删除</button>'
                                , '</td>'
                                , '</tr>'].join(''));

                            //单个重传
                            tr.find('.ml-upload-reload').on('click', function () {
                                tr.remove();
                                obj.upload(index, file);
                            });

                            //删除
                            tr.find('.ml-upload-delete').on('click', function () {
                                delete files[index]; //删除对应的文件
                                tr.remove();
                                $(item).next()[0].value = ''; //清空 input file 值，以免删除后出现同名文件不可选
                            });
                            demoListView.append(tr);
                        });
                    } else {
                        obj.preview(function (index, file, result) {
                            $('#demo1').attr('src', result); //图片链接（base64）
                            var tr = $([
                                '<tr id="upload-' + index + '">'
                                , '<td>' + '<img src=' + result + '> ' + file.name + '</td>'
                                , '<td>' + (file.size / 1024).toFixed(1) + 'kb</td>'
                                , '<td>等待上传</td>'
                                , '<td>'
                                , '<button type="button" class="layui-btn layui-btn-xs ml-upload-reload layui-hide">重传</button>'
                                , '<button type="button" class="layui-btn layui-btn-xs layui-btn-danger ml-upload-delete">删除</button>'
                                , '</td>'
                                , '</tr>'].join(''));
                            //单个重传
                            tr.find('.ml-upload-reload').on('click', function () {
                                tr.remove();
                                obj.upload(index, file);
                            });

                            //删除
                            tr.find('.ml-upload-delete').on('click', function () {
                                delete files[index]; //删除对应的文件
                                tr.remove();
                                $(item).next()[0].value = ''; //清空 input file 值，以免删除后出现同名文件不可选
                            });
                            demoListView.append(tr);
                        });
                    }
                }

            },
            url: "/console/upload/index?full_path=yes"
            , done: function (res, index, upload) {
                //获取当前触发上传的元素，一般用于 elem 绑定 class 的情况，注意：此乃 layui 2.1.0 新增
                var item = this.item;
                console.log(this);
                var data = $(item).data()
                var demoListView = $('#' + data.name + 'List')
                var domInput = $("input[name='" + data.name + "']");

                var value = domInput.val().split(',')
                if (res.code = 1) { //上传成功
                    // 是否多图
                    if (this.multiple) {
                        value[index] = res.data.file;
                    } else {
                        value = [res.data.file];
                    }
                    domInput.val(value.join(','));
                    if ($(item).hasClass('layui-btn-avatar')){
                        $(item).find('img').attr('src',value.join(',')).removeClass('layui-hide')
                        $(item).find('.layui-avatar-bg').addClass('layui-hide')
                        return ;
                    }

                    if (data.preview) {
                        if (data.type == 'file') {
                            var tr = demoListView.find('tr#upload-' + index)
                                , tds = tr.children();
                            tds.eq(2).html('<span style="color: #5FB878;">上传成功</span>');
                            tds.eq(3).html(''); //清空操作
                            return delete this.files[index]; //删除文件队列已经上传成功的文件
                        }
                    } else {
                        var tr = demoListView.find('tr#upload-' + index)
                            , tds = tr.children();
                        tds.eq(2).html('<span style="color: #5FB878;">上传成功</span>');
                        tds.eq(3).html(''); //清空操作
                        return delete this.files[index]; //删除文件队列已经上传成功的文件
                    }
                }
                this.error(index, upload);
            }, error: function (index, upload) {
                var item = this.item;
                var data = $(item).data()
                var demoListView = $('#' + data.name + 'List')
                setTimeout(function () {
                    var tr = demoListView.find('tr#upload-' + index)
                        , tds = tr.children();
                    tds.eq(2).html('<span style="color: #FF5722;">上传失败</span>');
                    tds.eq(3).find('.ml-upload-reload').removeClass('layui-hide'); //显示重传
                })

            }
        }
        $(elem).each(function () {
            uploadConfig.elem = this
            var layData = $(this).attr('lay-data');
            layData = new Function("return " + layData)();
            var newUploadConfig = $.extend(layData || {}, uploadConfig)
            upload.render(newUploadConfig)
        })

    }

    ml.prototype.searchListen = function () {
        var searchDom = $(this.config.search.elem)
        var that = this;
        form.on("submit(mlSearch)", function (obj) {
            typeof that.search == "function" && that.search(obj);
            reloadTable({
                where: obj.field,
                page: {
                    curr: 1
                }
            })
            return false;
        })
        form.on('select(mlSearchSelect)', selectChange)
        searchDom.on("change", "input", inputChange)

        function inputChange() {
            var key = $(this).data('key');
            var field = that.config.search.field[key]
            var data = {
                type: "input",
                value: $(this).val(),
                name: field.name,
                field: field
            }
            that.config.search.field[key].value = data.value
            typeof that.config.search.change == "function" && that.config.search.change(data, that.config.search);
        }

        function selectChange(obj) {
            var key = $(obj.elem).data('key');
            var field = that.config.search.field[key]
            var data = {
                type: "select",
                value: obj.value,
                name: field.name,
                field: field
            }
            that.config.search.field[key].value = obj.value
            typeof that.config.search.change == "function" && that.config.search.change(data, that.config.search);
        }

        $(".date").each(function () {
            laydate.render({
                elem: this, done: dateChange,
                mark: {},
                isInitValue: false,
            })
        })
        $(".date-range").each(function () {
            laydate.render({
                elem: this,
                range: true,
                mark: {},
                isInitValue: false,
                done: dateChange
            })
        })

        function dateChange(value, date, endDate) {
            var elem = $(this)[0].elem;
            var key = $(elem).data('key');
            var field = that.config.search.field[key]
            var data = {
                type: "date",
                value: value,
                name: field.name,
                field: field
            }
            that.config.search.field[key].value = value
            typeof that.config.search.change == "function" && that.config.search.change(data, that.config.search);
        }
    }

    ml.prototype.setUpdateParam = function (update) {
        var data = {};
        $.each(this.config.update.field, function () {
            data[this] = update[this]
        })
        return data;
    }
    ml.prototype.tableListen = function () {
        var that = this;
        form.on("switch(mlSwitch)", function (obj) {
            if (typeof that.switch == "function") {
                return that.switch(obj);
            }
            var url = $(this).data('url')
            if (url && url !== "undefined") {

                var dom = $(this),field=dom.attr('name'), status = 0, func = function () {
                    var data = {
                        edit_status:1
                    };
                    data['field'] = field;
                    data['val'] = status;
                    url = setUrlParams(url,{id:dom.data('id')})
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
        table.on("edit(myTable)", function (obj) {
            var data = obj.data;
            data[obj.field] = obj.value;
            var params = that.setUpdateParam(data)
            params[that.config.update.primary] = data[that.config.update.primary];
            if (!params[that.config.update.primary]) {
                return layer.msg('主键不存在');
            }
            $.post(that.config.update.url, params, function (res) {
                layer.msg(res.msg);
                if (res.code == 0) {
                    ml.tableInstance.reload()
                }
            })
        })
    }

    ml = new ml();
    exports("ml", ml)
});
