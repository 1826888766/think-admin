<?php
// 应用公共文件

if (!function_exists('model')) {
    /**
     * 对一个值调用给定的闭包，然后返回该值
     *
     * @param $name
     *
     * @return \think\Model
     */
    function model($name): \think\Model
    {
        return new $name();
    }
}

function create_password($password)
{
    return password_hash($password, PASSWORD_DEFAULT);
}

function verity_password($password, $hash): bool
{
    return password_verify($password, $hash);
}