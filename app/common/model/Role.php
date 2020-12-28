<?php
declare (strict_types=1);

namespace app\common\model;

use think\Model;

/**
 * @mixin \think\Model
 */
class Role extends Model
{

    public static function allPage($limit = 10): \think\Paginator
    {
        $where = [];
        return self::where($where)->paginate($limit);
    }

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

    public static function getCheckMenuId($id): array
    {
        $role = self::where(['id' => $id])->find();
        $checked = [];
        foreach ($role->roles as $value) {
            $checked[] = $value['id'];
        }
        return $checked;
    }

    public static function addRoleMenu($role_id, $menu)
    {
        $role = self::where(['id' => $role_id])->find();
        $role->roles()->detach();
        return $role->roles()->attach($menu);
    }

}
