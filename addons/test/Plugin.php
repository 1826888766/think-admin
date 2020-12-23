<?php 
namespace addons\test;

use think\Addons;

class Plugin extends Addons {

    // 该插件的基础信息
    public $info = [
        'name' => 'test',	// 插件标识
        'title' => '插件测试',	// 插件名称
        'description' => 'thinkph6插件测试',	// 插件简介
        'status' => 1,	// 状态
        'author' => 'byron sampson',
        'version' => '0.1'
    ];

    public function install()
    {
        
    }

    public function uninstall()
    {
        
    }

}