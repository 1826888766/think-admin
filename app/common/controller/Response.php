<?php
declare(strict_types=1);

namespace app\common\controller;

/**
 * 数据响应
 *
 * @package app\common\controller
 * @author  马良 1826888766@qq.com
 */
class Response
{
    /**
     * 正确返回
     *
     * @param mixed  $data
     * @param string $msg
     * @param int    $code
     *
     * @return \think\response\Json
     */
    public static function success($data = null, $msg = "请求成功", $code = 0): \think\response\Json
    {
        return json(["code" => $code, "msg" => $msg, "data" => []]);
    }

    /**
     * 错误返回
     *
     * @param        $code
     * @param string $msg
     *
     * @return \think\response\Json
     */
    public static function fail($code=1, $msg = ""): \think\response\Json
    {
        return json(["code" => $code, "msg" => $msg, "data" => []]);
    }

    /**
     * layui正确数据
     *
     * @param        $data
     * @param        $count
     * @param string $msg
     *
     * @return \think\response\Json
     */
    public static function layuiSuccess($data, $count, $msg = ""): \think\response\Json
    {
        return json(["data" => $data, 'count' => $count, "code" => 0, "msg" => $msg]);
    }

    /**
     * layui错误返回
     *
     * @param $msg
     *
     * @return \think\response\Json
     */
    public static function layuiFail($msg): \think\response\Json
    {
        return json(["data" => [], 'count' => 0, "code" => 1, "msg" => $msg]);
    }
}