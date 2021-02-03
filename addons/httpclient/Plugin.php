<?php
declare (strict_types = 1);

namespace addons\httpclient;

use app\common\controller\AddonsBase;

/**
 * Plugin
 **/
class Plugin extends AddonsBase
{

    // 初始化
    protected function initialize()
    {
        // TODO 初始化操作
    }

    //安装插件方法
    public function install(){
        $this->saveConfig(['status'=>1]);
    }

    //卸载插件方法
    public function uninstall(){}


}
