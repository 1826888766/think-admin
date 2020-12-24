<?php
// 应用公共文件

if (!function_exists('model')) {
    /**
     * 对一个值调用给定的闭包，然后返回该值
     *
     * @param $name
     * @return \think\Model
     */
    function model($name): \think\Model
    {
        $module = app()->getName();
        if ($name instanceof \think\Model) {
            return $name;
        } elseif (is_string($name) && strpos($name, '/') !== false) {
            return new $name();
        } else {
            $name = "\\app\\$module\\model\\$name";
            return new $name();
        }
    }
}