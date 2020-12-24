<?php

namespace addons\test;

use think\Addons;
use think\App;

class Plugin extends Addons
{

    // 该插件的基础信息
    public $info;

    public function initialize()
    {
        $this->load();
    }

    /**
     * 加载配置
     */
    private function load()
    {
        $this->info = include __DIR__ . '/config.php';
    }

    public function install()
    {

        return true;
    }

    public function uninstall()
    {
        return true;
    }

    /**
     * @return false|mixed|string
     * @throws \think\Exception
     */
    public function setting()
    {
        return $this->display('1');
    }
}