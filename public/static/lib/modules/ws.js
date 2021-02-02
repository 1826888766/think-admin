layui.define([
    'jquery',
], function (exports) {
    var ws = function () {
        this.version = "0.0.1";
        this.reconnectMax = 3;
        this.reconnect = 1;
        this.sleep = 3000;
        this.timeout = 0;
        this.heart_msg = '{"type":"ping"}';
        this.heart_sleep = 30000;
        this.heart_timeout = 0;
        this.connect()
    }

    ws.prototype.connect = function () {
        this.socket = new WebSocket("wss://think-admin.tspalace.top:2345");
        this.socket.onmessage = this.onmessage.bind(this);
        this.socket.onopen = this.onopen.bind(this);
        this.socket.onclose = this.onclose.bind(this);
    }

    ws.prototype.onopen = function () {
        this.reconnect = 1;
        clearTimeout(this.timeout)
        this.heart()
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
        this.socket.send(this.heart_msg)
        var that = this;
        this.heart_timeout = setTimeout(function () {
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
        }
    }

    ws.prototype.msg = function (msg, options) {
        var div = "<div>" + msg + "</div>"
        var config = $.extend({
            text: div,
            sticky: false,
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