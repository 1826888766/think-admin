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
     * @param null $user
     *
     * @return \think\Collection
     */
    public static function allMenu($user = null): \think\Collection
    {
        if (!$user) {
            return new \think\Collection();
        }
        // 如果是管理员或者是超管权限
        if ($user->id == 1 || array_search('1', $user->role_id) !== false) {
            return Menu::allMenu();
        } else {
            $checked = Role::getCheckMenuId($user->role_id, $user->menu_id);
            return Menu::listByIds($checked);
        }
    }
}
