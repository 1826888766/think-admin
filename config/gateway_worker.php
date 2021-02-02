<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006-2018 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: liu21st <liu21st@gmail.com>
// +----------------------------------------------------------------------
// +----------------------------------------------------------------------
// | Workerman设置 仅对 php think worker:gateway 指令有效
// +----------------------------------------------------------------------
return [
    // 扩展自身需要的配置
    'protocol'              => env('gateway.protocol', 'websocket'), // 协议 支持 tcp udp unix http websocket text
    'host'                  => env('gateway.host', '0.0.0.0'), // 监听地址
    'port'                  => env('gateway.port', 2345), // 监听端口
    'socket'                => '', // 完整监听地址
    'context'               => [
        'ssl' => array(
            // 请使用绝对路径
            'local_cert'                 => '/www/server/panel/vhost/cert/think-admin.tspalace.top/fullchain.pem', // 也可以是crt文件
            'local_pk'                   => '/www/server/panel/vhost/cert/think-admin.tspalace.top/privkey.pem',
            'verify_peer'               => false,
            // 'allow_self_signed' => true, //如果是自签名证书需要开启此选项
        )
    ], // socket 上下文选项
    'register_deploy'       => true, // 是否需要部署register
    'businessWorker_deploy' => true, // 是否需要部署businessWorker
    'gateway_deploy'        => true, // 是否需要部署gateway
    'transport'             => 'ssl',
    // Register配置
    'registerAddress'       => '127.0.0.1:1236',

    // Gateway配置
    'name'                  => 'thinkphp',
    'count'                 => 1,
    'lanIp'                 => '127.0.0.1',
    'startPort'             => 2000,
    'daemonize'             => false,
    'pingInterval'          => 30,
    'pingNotResponseLimit'  => 0,
    'pingData'              => '{"type":"ping"}',

    // BusinsessWorker配置
    'businessWorker'        => [
        'name'         => 'BusinessWorker',
        'count'        => 1,
        'eventHandler' => '\think\worker\Events',
    ],

];
