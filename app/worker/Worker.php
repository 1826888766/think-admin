<?php


namespace app\worker;


use think\worker\Server;

class Worker extends Server
{

    protected $port = "2345";

    protected $host = "0.0.0.0";

    protected $protocol = "websocket";

    public function onMessage($connection, $data)
    {
        $data = json_decode($data, true);
        $connection->send(json_encode($data));
    }

    public function onConnect($connection)
    {
        $data = ["type" => "notice", "msg" => "链接成功"];
        $connection->send(json_encode($data));
    }
}