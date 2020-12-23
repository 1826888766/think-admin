<?php
declare (strict_types = 1);

namespace app\console\controller;

use app\common\controller\ConsoleBase;
use think\facade\View;

/**
 * 插件管理
 *
 * @Author 马良 1826888766@qq.com
 * @DateTime 2020-12-23 14:00:30
 */
class Addons extends ConsoleBase
{
    /**
     * 插件列表
     *
     * @Author 马良 1826888766@qq.com
     * @DateTime 2020-12-23 14:00:21
     * @return void
     */
    public function index()
    {
        $addons = $this->load();
        $this->assign('list',$addons);
        return $this->fetch();
    }

    /**
     * 加载插件配置
     *
     * @Author 马良 1826888766@qq.com
     * @DateTime 2020-12-23 13:50:03
     * @return array
     */
    private function load():array
    {
        $configs = glob(app()->getRootPath() . "addons/*/config.php");
        $addons = [];
        foreach($configs as $config){
            $addons[] = include $config;
        }
        return $addons;
    }
}
