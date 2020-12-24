<?php
declare (strict_types=1);

namespace app\console\controller;

use app\common\controller\ConsoleBase;
use app\common\controller\Response;
use think\facade\Cache;
use think\facade\View;

/**
 * 插件管理
 *
 * @Author   马良 1826888766@qq.com
 * @DateTime 2020-12-23 14:00:30
 */
class Addons extends ConsoleBase
{
    /**
     * 插件列表
     *
     * @Author   马良 1826888766@qq.com
     * @DateTime 2020-12-23 14:00:21
     */
    public function index()
    {
        if ($this->request->isAjax()) {
            $addons = $this->load();
            return Response::layuiSuccess($addons, count($addons));
        }
        return $this->fetch();
    }

    /**
     * 加载插件配置
     *
     * @Author   马良 1826888766@qq.com
     * @DateTime 2020-12-23 13:50:03
     * @return array
     */
    private function load(): array
    {
        if (!Cache::has('addonsConfig') || env('APP_DEBUG')) {
            $configs = glob(app()->getRootPath() . "addons/*/config.php");
            $addons = [];
            foreach ($configs as $file) {
                $config = include $file;
                $config['path'] = str_replace('/config.php', '', $file);
                $addons[] = $config;
            }
            Cache::set('addonsConfig', $addons);
            return $addons;
        }
        return Cache::get('addonsConfig');
    }

    public function install($id)
    {
        $addons = $this->searchAddons($id);
        if (!$addons) {
            return Response::fail(1, '插件不存在');
        }
        $name = $addons['id'];
        $class = "\\addons\\$name\\Plugin";
        $result = call_user_func([new $class($this->app), 'install']);
        if ($result === true) {
            return Response::success([], '安装成功');
        }
        return Response::fail(1, '安装失败');
    }

    private function searchAddons($id)
    {
        $addons = $this->load();
        $index = array_search($id, array_column($addons, 'id'));
        return $addons[$index];
    }

    public function uninstall($id)
    {
        $addons = $this->searchAddons($id);
        if (!$addons) {
            return Response::fail(1, '插件不存在');
        }
        $name = $addons['id'];
        $class = "\\addons\\$name\\Plugin";
        $result = call_user_func([new $class($this->app), 'uninstall']);
        if ($result === true) {
            return Response::success([], '卸载成功');
        }
        return Response::fail(1, '卸载失败');
    }

    public function del()
    {

    }
}
