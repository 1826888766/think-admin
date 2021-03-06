<?php
declare (strict_types=1);

namespace app\common\model;

use think\Model;

/**
 * @mixin \think\Model
 */
class Role extends ModelBase
{
    public static function allAuth()
    {
        $module = Module::all();
        $module->each(function ($value) {
            $menu = Menu::getMenuByModuleId($value->id);
            $value->setAttr('child', $menu);
        });
        return $module;
    }

    public static function tree($data, $checked = [])
    {
        $tree = [];
        foreach ($data as $datum) {
            $child = [];
            if ($datum['child']) {
                $child = self::tree($datum['child'], $checked);
            }
            $tree[] = [
                'title' => $datum['name'],
                'children' => $child,
                'spread' => true,
                'id' => $datum['id'],
                'field' => 'menu_id[]',
                'checked' => in_array($datum['id'], $checked)
            ];
        }
        return $tree;
    }

    public static function allSelect()
    {
        return self::field('name,id as value')->select()->toArray();
    }

    public function roles(): \think\model\relation\BelongsToMany
    {
        return $this->belongsToMany(Menu::class, RoleMenu::class, 'menu_id', 'role_id');
    }

    /**
     * 获取当前角色拥有的权限
     *
     * @param array $id        角色id
     * @param array $menu_diff 单独分配的权限
     *
     * @return array
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public static function getCheckMenuId($id, $menu_diff = []): array
    {
        $role = self::where(['id' => $id])->find();
        $checked = [];
        foreach ($role->roles as $value) {
            $checked[] = $value['id'];
        }
        if (isset($menu_diff['add']) && is_array($menu_diff['add'])) {
            $checked = array_merge_recursive($checked, $menu_diff['add']);
        }
        if (isset($menu_diff['del']) && is_array($menu_diff['del'])) {
            foreach ($menu_diff['del'] as $item) {
                $index = array_search(intval($item), $checked);
                if (false !== $index) {
                    unset($checked[$index]);
                }
            }
        }
        return $checked;
    }

    public static function addRoleMenu($role_id, $menu_ids)
    {
        $role = self::where(['id' => $role_id])->find();
        $role->roles()->detach();
        return $role->roles()->attach(array_values($menu_ids));
    }

    /**
     * 检查权限
     *
     * @param Model|null $user    登录用户
     * @param int        $menu_id 按钮id
     *
     * @return bool
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public static function checkAuth(?Model $user, $menu_id): bool
    {
        if (!$user) {
            return false;
        }
        $checked = self::getCheckMenuId($user->role_id, $user->menu_id);
        if (in_array($menu_id, $checked)) {
            return true;
        }

        return false;

    }

}
