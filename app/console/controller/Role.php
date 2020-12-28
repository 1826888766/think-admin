<?php
declare (strict_types=1);

namespace app\console\controller;

use app\common\controller\ConsoleBase;
use app\common\controller\Response;
use think\Request;
use app\common\model\Role as RoleModel;

class Role extends ConsoleBase
{
    protected $model = RoleModel::class;

    protected $formField = [
        ['field' => 'id', 'type' => 'hidden'],
        ['field' => 'name', 'label' => '角色名称'],
        ['field' => 'status', 'label' => '状态', 'type' => 'radio', 'value' => '0|禁用,1|启用', 'default' => '1'],
    ];

    public function index()
    {
        if ($this->request->isAjax()) {
            $data = RoleModel::allPage();
            return Response::layuiSuccess($data->items(), $data->total());
        }
        return $this->fetch();
    }

    public function add()
    {
        return parent::add();
    }

    /**
     * 权限设置
     */
    public function permission()
    {
        if ($this->request->isAjax()) {
            $data = RoleModel::addRoleMenu($this->param['id'], $this->param['menu_id']);
            return Response::success($data);
        }
        $menu_id = RoleModel::getCheckMenuId($this->param['id']);
        $auth = RoleModel::allAuth();
        $this->assign('auth', RoleModel::tree($auth, $menu_id));
        return $this->fetch();
    }

}
