<?php
declare (strict_types=1);

namespace app\common\model;

use think\facade\Cache;
use think\Model;

/**
 * @mixin \think\Model
 */
class Module extends Model
{
    /**
     * 所有模块
     *
     * @return \think\Collection
     */
    public static function all()
    {
        $where = [
            'is_show' => 1,
            'status' => 1,
        ];
        return self::where($where)->order('id', 'asc')->select();
    }

    /**
     * 获取所有模块所有菜单
     *
     * @return \think\Collection
     */
    public static function allMenu(): \think\Collection
    {
        if (!Cache::has('all_menu') || env('APP_DEBUG')) {
            $all = self::all();
            $all->each(function ($item) {
                $menu = Menu::getMenuByModuleId($item->id);
                $item->setAttr('menu', $menu);
            });
            Cache::set('all_menu', $all);
            return $all;
        }
        return Cache::get('all_menu');
    }
}
