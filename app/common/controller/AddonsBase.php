<?php
/**
 * +----------------------------------------------------------------------
 * | think-addons [thinkphp6]
 * +----------------------------------------------------------------------
 *  .--,       .--,             | FILE: Addons.php
 * ( (  \.---./  ) )            | AUTHOR: byron
 *  '.__/o   o\__.'             | EMAIL: xiaobo.sun@qq.com
 *     {=  ^  =}                | QQ: 150093589
 *     /       \                | DATETIME: 2019/11/5 14:47
 *    //       \\               |
 *   //|   .   |\\              |
 *   "'\       /'"_.-~^`'-.     |
 *      \  _  /--'         `    |
 *    ___)( )(___               |-----------------------------------------
 *   (((__) (__)))              | 高山仰止,景行行止.虽不能至,心向往之。
 * +----------------------------------------------------------------------
 * | Copyright (c) 2019 http://www.zzstudio.net All rights reserved.
 * +----------------------------------------------------------------------
 */
declare(strict_types=1);

namespace app\common\controller;

use core\view\Think;
use think\App;
use think\helper\Str;
use think\facade\Config;
use think\facade\View;

abstract class AddonsBase extends ConsoleBase
{
    // app 容器
    protected $app;
    // 请求对象
    protected $request;
    // 当前插件标识
    protected $name;
    // 插件路径
    protected $addon_path;
    // 视图模型
    protected $view;
    // 插件配置
    protected $addon_config;
    // 插件信息
    protected $addon_info;

    /**
     * 插件构造函数
     * Addons constructor.
     *
     * @param \think\App $app
     */
    public function __construct(App $app)
    {
        $this->app = $app;
        $this->request = $app->request;
        $this->view = new Think($app,config("view"));
        $this->name = $this->getName();
        $this->addon_path = $app->addons->getAddonsPath() . $this->name . DIRECTORY_SEPARATOR;
        $this->addon_config = "addon_{$this->name}_config";
        $this->addon_info = "addon_{$this->name}_info";
        $this->view->config([
            'view_path' => $this->addon_path . 'view' . DIRECTORY_SEPARATOR,
        ]);
        // 控制器初始化
        $this->initialize();
    }

    // 初始化
    public function initialize()
    {
        parent::initialize();
    }

    /**
     * 获取插件标识
     *
     * @return mixed|null
     */
    final protected function getName()
    {
        $class = get_class($this);
        list(, $name,) = explode('\\', $class);
        $this->request->addon = $name;

        return $name;
    }


    /**
     * 插件基础信息
     *
     * @return array
     */
    final public function getInfo()
    {
        $info = Config::get($this->addon_info, []);
        if ($info) {
            return $info;
        }

        $info = $this->getConfig(true);
        Config::set($info, $this->addon_info);

        return isset($info) ? $info : [];
    }

    /**
     * 获取配置信息
     *
     * @param bool $type 是否获取完整配置
     *
     * @return array|mixed
     */
    final public function getConfig($type = false)
    {
        $config = Config::get($this->addon_config, []);
        if ($config && !$type) {
            return $config;
        }
        $config_file = $this->addon_path . 'config.php';
        if (is_file($config_file)) {
            $temp_arr = (array)include $config_file;
            if ($type) {
                return $temp_arr;
            }
            foreach ($temp_arr as $key => $value) {
                $config[$key] = $value['data'];
            }
            unset($temp_arr);
        }
        Config::set($config, $this->addon_config);

        return $config;
    }

    /**
     * 获取配置信息
     *
     * @return array|mixed
     */
    final public function getSetting()
    {
        $config_file = $this->addon_path . 'config.php';
        $config = [];
        if (is_file($config_file)) {
            $temp_arr = (array)include $config_file;
            foreach ($temp_arr as $key => $value) {
                $value['field'] = $key;
                $config[] = $value;
            }
            unset($temp_arr);
        }
        return $config;
    }


    public function saveConfig(array $param)
    {
        $config = $this->getConfig(true);

        foreach ($config as $key => $item) {
            if ($key == 'show') {
                $config[$key]['data'] = $param['show'] ?? 0;
            } else if ($key == 'status') {
                $config[$key]['data'] = $param['status'] ?? 0;
            } else {
                if ((isset($config[$key]['type']) && $config[$key]['type'] !== 'hidden') && !isset($config[$key]['disabled']) && !isset($config[$key]['readonly'])) {
                    $config[$key]['data'] = $param[$key] ?? $config[$key]['data'];
                }
            }
        }

        $content = "<?php\n";
        $content .= "return " . self::arrayToString($config) . ";";
        file_put_contents($this->addon_path . 'config.php', $content);
    }

    public static function arrayToString($array, $num = 1): string
    {
        $r = "\n\t";
        $string = "[";
        foreach ($array as $key => $item) {
            if ($num == 1) {
                $string .= "{$r}";
            }
            $string .= "\"$key\" => " . (is_array($item) ? self::arrayToString($item, $num + 1) : "\"$item\"") . ",";
        }
        if ($num == 1) {
            $string .= "\n";
        }
        $string .= "]";
        return $string;
    }

    //必须实现安装
    abstract public function install();

    //必须卸载插件方法
    abstract public function uninstall();

    public function setting()
    {
        $this->assign("formConfig", [
            'action' => $this->request->action(),
            'field' => $this->getSetting(),
            'method' => 'POST',
            'data' => $this->getConfig()
        ]);
        return $this->fetch("console@template:form");
    }
}
