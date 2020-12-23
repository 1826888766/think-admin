<?php


namespace app\common\controller;


class Response
{
    /**
     * @param $data
     * @param int $code
     * @return \think\response\Json
     */
    public static function success($data,$code = 0)
    {
        return json(["code"=>$code,"msg"=>"请求成功","data"=>[]]);
    }

    /**
     * 错误返回
     * @param $code
     * @param string $msg
     * @return \think\response\Json
     */
    public static function fail($code,$msg="")
    {
        return  json(["code"=>$code,"msg"=>$msg,"data"=>[]]);
    }

    /**
     * layui数据
     * @param $data
     * @param $code
     * @param $msg
     * @return \think\response\Json
     */
    public static function layui($data,$code=0,$msg="")
    {
        return json(["data"=>$data,"code"=>$code,"msg"=>$msg]);
    }
}