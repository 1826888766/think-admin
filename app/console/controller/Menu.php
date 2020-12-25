<?php
declare (strict_types=1);

namespace app\console\controller;

use app\common\controller\ConsoleBase;
use app\common\controller\Response;
use app\common\model\Menu as MenuModel;

class Menu extends ConsoleBase
{

    protected $model = MenuModel::class;
    protected $formData = [];

    protected $formField = [
        ['field' => 'parent_id', 'label' => '所属菜单', 'type' => 'select', "value" => []],
        ['field' => 'name', 'label' => '菜单名称'],
        ['field' => 'url', 'label' => '打开链接'],
        ['field' => 'sort', 'label' => '排序'],
        ['field' => 'is_show', "type" => 'radio', "default" => 1, "value" => "0|否,1|是", 'label' => '是否显示'],
        ['field' => 'is_auth', "type" => 'radio', "default" => 1, "value" => "0|否,1|是", 'label' => '是否验权'],
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
            $where = getSearchWhere($this->param);
            if($where){
                $list = MenuModel::getMenuByWhere($where, ['module']);
            }else{
                $list = MenuModel::getMenuByParentId(0, ['module']);
            }
            return Response::layuiSuccess($list, count($list));
        }
        return $this->fetch();
    }

    public function add()
    {
        if (!$this->request->isAjax()) {
            $this->formField[0]['value'] = MenuModel::getMenuSelectByParentId(0);
            $this->formData['parent_id'] = $this->param['id'];
        } else {
            $this->param['module_id'] = \app\common\model\Menu::where('id', $this->param['parent_id'])->value('module_id');
        }

        return parent::add();
    }

}
