<?php
declare (strict_types=1);

namespace app\common\model;

use think\helper\Str;
use think\Model;

/**
 * @mixin \think\Model
 */
class Menu extends Model
{
    public static function getMenuSelectByParentId($id, $theme = 0)
    {
        $data = self::getMenuByParentId($id, ['module']);
        return self::parseSelect($data->toArray(), $theme);
    }

    /**
     * 输出select数据
     *
     * @param     $data
     * @param int $theme
     * @param int $level
     *
     * @return array
     */
    public static function parseSelect($data, $theme = 0, $level = 0)
    {
        $new_data = [];
        $level_str = "";
        for ($i = 0; $i < $level; $i++) {
            $level_str .= "┊┈┈";
        }
        foreach ($data as $datum) {
            $module_name = isset($datum['module_name']) && $datum['module_name'] ? "【{$datum['module_name']}】" : "";
            if ($theme == 0) {
                $new_data[] = [$datum['id'], $level_str . $module_name . $datum['name']];
            } else {
                $new_data[] = ['value' => $datum['id'], 'name' => $level_str . $module_name . $datum['name']];
            }
            if (is_array($datum['child']) && count($datum['child']) > 0) {
                $new_data = array_merge_recursive($new_data, self::parseSelect($datum['child'], $theme, $level + 1));
            }
        }
        return $new_data;
    }

    public static function getMenuSelectByModuleId($id, $theme = 0): array
    {
        $data = self::getMenuByModuleId($id, ['module']);
        return self::parseSelect($data->toArray(), $theme);
    }

    /**
     * url获取器
     *
     * @param $value
     *
     * @return string|null
     */
    public function getUrlAttr($value): string
    {
        if ($value && !(Str::startsWith($value, 'http://') || Str::startsWith($value, 'https://'))) {
            return url($value)->domain(true)->build();
        }
        return $value;
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
    public static function getMenuByModuleId($id, $with = []): \think\Collection
    {
        $where = [
            'is_show' => 1,
            'status' => 1,
            'module_id' => $id,
            'parent_id' => 0,
        ];
        return self::list($where, $with);
    }

    public static function list($where = [], $with = [])
    {

        $field = ['id', 'name', 'url', 'is_auth', 'is_show', 'status', 'sort', 'module_id', 'parent_id', 'target', 'is_plugin'];
        $first = self::where($where)->field($field)->order('sort', 'asc')->order('id', 'asc')->select();
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
        return self::list($where, $with);
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
