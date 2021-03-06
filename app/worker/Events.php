<?php


namespace app\worker;


use app\common\model\User;
use GatewayWorker\Lib\Gateway;
use think\App;
use think\facade\Session;
use Workerman\Worker;

class Events
{
    /**
     * onWorkerStart 事件回调
     * 当businessWorker进程启动时触发。每个进程生命周期内都只会触发一次
     *
     * @access public
     *
     * @param \Workerman\Worker $businessWorker
     *
     * @return void
     */
    public static function onWorkerStart(Worker $businessWorker)
    {
        $businessWorker->transport = "ssl";
    }

    /**
     * onConnect 事件回调
     * 当客户端连接上gateway进程时(TCP三次握手完毕时)触发
     *
     * @access public
     *
     * @param int $client_id
     *
     * @return void
     */
    public static function onConnect($client_id)
    {
    }

    /**
     * onWebSocketConnect 事件回调
     * 当客户端连接上gateway完成websocket握手时触发
     *
     * @param integer $client_id 断开连接的客户端client_id
     * @param mixed   $data
     *
     * @return void
     */
    public static function onWebSocketConnect($client_id, $data)
    {
        $param = $data['get'];
        Gateway::bindUid($client_id, $param['id']);
        User::update(['online' => 1, 'id' => $param['id'], 'client_id' => $client_id]);
    }

    /**
     * onMessage 事件回调
     * 当客户端发来数据(Gateway进程收到数据)后触发
     *
     * @access public
     *
     * @param int   $client_id
     * @param mixed $data
     *
     * @return void
     */
    public static function onMessage($client_id, $data)
    {
        Gateway::sendToCurrentClient($data);
    }

    /**
     * onClose 事件回调 当用户断开连接时触发的方法
     *
     * @param integer $client_id 断开连接的客户端client_id
     *
     * @return void
     */
    public static function onClose($client_id)
    {
        User::update(['online' => 0, 'client_id' => null], ['client_id' => $client_id]);
    }

    /**
     * onWorkerStop 事件回调
     * 当businessWorker进程退出时触发。每个进程生命周期内都只会触发一次。
     *
     * @param \Workerman\Worker $businessWorker
     *
     * @return void
     */
    public static function onWorkerStop(Worker $businessWorker)
    {
        echo "WorkerStop\n";
    }
}