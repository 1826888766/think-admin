layui.define([
    'jquery',
], function (exports) {
    var ws = function () {
        this.version = "0.0.1";
        this.reconnectMax = 3;
        this.reconnect = 1;
        this.sleep = 3000;
        this.timeout = 0;
        this.heart_msg = '{"type":"heart"}';
        this.heart_sleep = 30000;
        this.heart_timeout = 0;
    }

    ws.prototype.connect = function (url) {
        this.socket = new WebSocket(url);
        this.socket.onmessage = this.onmessage.bind(this);
        this.socket.onopen = this.onopen.bind(this);
        this.socket.onclose = this.onclose.bind(this);
    }

    ws.prototype.onopen = function () {
        this.reconnect = 1;
        clearTimeout(this.timeout)
        this.heart()
        this.msg("<a href=''>ip:84.17.57.165,小时请求已超过30</a>")
    }

    ws.prototype.disConnect = function () {
        var num = this.reconnect;
        if (num > this.reconnectMax) {
            this.msg('链接失败，请检查服务状态')
            return;
        }
        this.msg("正在尝试第" + num + "次重连")
        this.connect.bind(this).apply()
        var that = this;
        this.reconnect += 1;
        this.timeout = setTimeout(function () {
            that.disConnect.bind(this).apply()
        }, this.sleep)
    }

    ws.prototype.onclose = function () {
        this.disConnect()
    }

    ws.prototype.heart = function () {
        var that = this;
        clearTimeout(this.heart_timeout);
        this.heart_timeout = setTimeout(function () {
            that.socket.send(that.heart_msg)
            that.heart();
        }, this.heart_sleep)
    }

    ws.prototype.send = function (data) {
        if (typeof data != "string") {
            data = JSON.stringify(data)
        }
        this.heart();
        this.socket.send(data)
    }

    ws.prototype.onmessage = function (data) {
        var msgObj = JSON.parse(data.data)
        if (msgObj.type === "notice") {
            this.msg(msgObj.msg)
        } else if (msgObj.type === "ping") {
            this.socket.send(this.heart_msg)
        }
        this.heart()
    }

    ws.prototype.msg = function (msg, options) {
        var div = "<div class='toast-a'>" + msg + "</div>"
        var config = $.extend({
            text: div,
            sticky: true,
            position: 'top-right',
            type: 'success',
            closeText: "",
            close: null
        }, options)
        $(".layui-body").toastmessage("showToast", config)
    }
    var Ws = new ws();
    exports("ws", Ws)
})