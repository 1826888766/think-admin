<?php

namespace addons\test\controller;

use addons\test\Plugin;
use app\common\model\Menu;
use app\common\model\Module;

class Index extends Plugin
{

    public function index()
    {
        $module = Module::create([
            'name' => '系统',
            'status' => 1,
            'is_show' => 1
        ]);
        Menu::create([
            'name' => '系统菜单',
            'url' => 'console/menu/index',
            'module_id' => $module->id,
            'status' => 1,
            'is_show' => 1,
            'is_auth' => 1,
            'parent_id' => 0,
        ]);
        $menu = Menu::create([
            'name' => '系统用户',
            'url' => 'console/menu/index',
            'module_id' => $module->id,
            'status' => 1,
            'is_show' => 1,
            'is_auth' => 1,
            'parent_id' => 0,
        ]);
        Menu::create([
            'name' => '系统用户',
            'url' => 'console/user/index',
            'module_id' => $module->id,
            'status' => 1,
            'is_show' => 1,
            'is_auth' => 1,
            'parent_id' => 0,
        ]);
        Menu::create([
            'name' => '系统权限',
            'url' => 'console/auth/index',
            'module_id' => $module->id,
            'status' => 1,
            'is_show' => 1,
            'is_auth' => 1,
            'parent_id' => 0,
        ]);
        Menu::create([
            'name' => '系统角色',
            'url' => 'console/role/index',
            'module_id' => $module->id,
            'status' => 1,
            'is_show' => 1,
            'is_auth' => 1,
            'parent_id' => 0,
        ]);
    }
}