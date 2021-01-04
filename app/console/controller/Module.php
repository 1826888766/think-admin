<?php
declare (strict_types=1);

namespace app\console\controller;

use app\common\controller\ConsoleBase;
use app\common\controller\Response;
use app\common\model\Module as ModuleModel;
use think\facade\Db;

class Module extends ConsoleBase
{

    protected $model = ModuleModel::class;

    protected $formField = [
        ['field' => 'name', 'label' => '菜单名称'],
        ['field' => 'sort', 'label' => '排序'],
        ['field' => 'is_show', "type" => 'radio', "default" => 1, "value" => "0|否,1|是", 'label' => '是否显示'],
        ['field' => 'status', "type" => 'radio', "default" => 1, "value" => "0|禁用,1|启用", 'label' => '是否禁用'],
    ];

    /**
     * 菜单管理
     *
     * @return string
     */
    public function index()
    {
        if ($this->request->isAjax()) {
            $list = ModuleModel::all();
            return Response::layuiSuccess($list, count($list));
        }

        return $this->fetch();
    }

}
