<?php
declare (strict_types=1);

namespace app\common\model;

use think\Model;

/**
 * @mixin \think\Model
 */
class Menu extends Model
{

    /**
     * url获取器
     *
     * @param $value
     *
     * @return string|null
     */
    public function getUrlAttr($value): ?string
    {
        if ($value) {
            return url($value)->build();
        }
        return null;
    }

    /**
     * 关联载入
     *
     * @return \think\model\relation\HasOne
     */
    public function module(): \think\model\relation\HasOne
    {
        return $this->hasOne(Module::class, 'id', 'module_id')->field('id,name')->bind(['module_name' => 'name']);
    }

    /**
     * 根据模块id回去内容
     *
     * @param $id
     *
     * @return \think\Collection
     */
    public static function getMenuByModuleId($id): \think\Collection
    {
        $where = [
            'is_show' => 1,
            'status' => 1,
            'parent_id' => 0,
            'module_id' => $id
        ];
        $field = ['id', 'name', 'url', 'is_auth', 'sort', 'module_id', 'parent_id', 'target', 'is_plugin'];
        $first = self::where($where)->field($field)->order('sort', 'asc')->select();
        $first->each(function ($item) {
            $menu = self::getMenuByParentId($item->id);
            $item->setAttr('child', $menu);
        });
        return $first;
    }

    /**
     * 根据父节点id获取菜单
     *
     * @param       $id
     * @param array $with
     *
     * @return \think\Collection
     */
    public static function getMenuByParentId($id, $with = []): \think\Collection
    {
        $where = [
            'is_show' => 1,
            'status' => 1,
            'parent_id' => $id
        ];
        $field = ['id', 'name', 'url', 'is_auth', 'sort', 'module_id', 'parent_id', 'target', 'is_plugin'];
        $first = self::where($where)->field($field)->order('sort', 'asc')->with($with)->select();
        $first->each(function ($item) {
            $menu = self::getMenuByParentId($item->id);
            $item->setAttr('child', $menu);
        });
        return $first;
    }

    /**
     * @param int $limit
     *
     * @return \think\Paginator
     */
    public static function allPage($limit = 10): \think\Paginator
    {
        $where = [];
        return self::where($where)->paginate($limit);
    }
}
