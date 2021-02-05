<?php
declare (strict_types=1);

namespace addons\httpclient;

use app\common\controller\AddonsBase;
use app\common\model\Menu;

/**
 * Plugin
 **/
class Plugin extends AddonsBase
{

    //安装插件方法
    public function install()
    {
        Menu::addPluginMenu(4, '接口测试', 'httpclient://Api/index');
        $this->saveConfig(['status' => 1]);
    }

    //卸载插件方法
    public function uninstall()
    {
        $this->saveConfig(['status' => 1]);
    }
}
