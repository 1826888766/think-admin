<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006-2018 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: liu21st <liu21st@gmail.com>
// +----------------------------------------------------------------------

namespace app\common\command;

use app\common\controller\AddonsBase;
use think\console\command\Make;
use think\console\Input;
use think\console\Output;

class Addons extends Make
{
    protected $type = "Addons";

    protected function configure()
    {
        parent::configure();
        $this->setName('make:addons')
            ->setDescription('Create a new addons class');
    }

    protected function execute(Input $input, Output $output)
    {
        $name = trim($input->getArgument('name'));
        parent::execute($input, $output);
        $namespace = $this->getNamespace($name);
        $config = $this->getPathName($namespace . '\\config');
        $config_data = [
            "id" => ["data" => "httpclient", "label" => "标识"],
            "title" => ["data" => "", "label" => "名称"],
            "show" => ["data" => "0", "label" => "显示"],
            "status" => ["data" => "1", "label" => "状态"],
            "setting" => ["data" => "1", "label" => "显示设置"],
            "version" => ["data" => "", "label" => "版本"],
        ];
        $content = "<?php\nreturn " . AddonsBase::arrayToString($config_data) . ";";
        file_put_contents($config, $content);
        mkdir($namespace . '\\controller');
        mkdir($namespace . '\\view');
    }

    protected function getStub(): string
    {
        return __DIR__ . DIRECTORY_SEPARATOR . 'stubs' . DIRECTORY_SEPARATOR . 'addons.stub';
    }

    protected function getPathName(string $name): string
    {
        $name = str_replace('app\\', '', $name);
        return $this->app->getRootPath() . ltrim(str_replace('\\', '/', $name), '/') . '.php';
    }

    protected function getClassName(string $name): string
    {
        return $this->getNamespace($name) . '\\' . "Plugin";
    }

    protected function getNamespace(string $app): string
    {
        return 'addons\\' . $app;
    }
}
