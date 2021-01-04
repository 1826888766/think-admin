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
        ['field' => 'target', 'label' => '跳转方式', "type" => 'radio', "default" => '_self', "value" => "_self|当前,_blank|新窗口"],
        ['field' => 'module_id', 'type' => 'hidden'],
        ['field' => 'id', 'type' => 'hidden'],
        ['field' => 'status', "type" => 'radio', "default" => 1, "value" => "0|禁用,1|启用", 'label' => '是否禁用'],
        ['field' => 'type', "type" => 'radio', "default" => 0, "value" => "0|视图,1|按钮", 'label' => '菜单类型'],
        ['field' => 'is_show', "type" => 'radio', "default" => 1, "value" => "0|否,1|是", 'label' => '是否显示'],
        ['field' => 'is_auth', "type" => 'radio', "default" => 1, "value" => "0|否,1|是", 'label' => '是否验权'],

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
            $list = MenuModel::where($where)->order('sort asc')->with(['module'])->select();
            $newList = [];
            foreach ($list as $item) {
                $newList[] = $item->getData();
            }
            return Response::layuiSuccess($newList, count($newList));
        }
        $module = \app\common\model\Module::order('id', 'asc')->select();
        $this->assign('module', $module);
        return $this->fetch();
    }

    public function add()
    {
        if (!$this->request->isAjax()) {
            $this->formField[0]['value'] = MenuModel::getMenuSelectByModuleId($this->param['module_id']);
            if (isset($this->param['id'])) {
                $this->formData['parent_id'] = $this->param['id'];
            }
            $this->formData['module_id'] = $this->param['module_id'];
        }
        return parent::add();
    }

    public function edit($id)
    {
        if (!$this->request->isAjax()) {
            $this->formField[0]['value'] = MenuModel::getMenuSelectByModuleId($this->param['module_id']);
        }
        return parent::edit($id);
    }

}
