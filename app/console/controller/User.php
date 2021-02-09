<?php
declare (strict_types=1);

namespace app\console\controller;

use app\common\controller\ConsoleBase;
use app\common\controller\Response;
use app\common\model\Role as RoleModel;
use think\Model;
use think\Request;
use \app\common\model\User as UserModel;
use GatewayWorker\Lib\Gateway;

class User extends ConsoleBase
{
    /**
     * @var Model
     */
    protected $model = UserModel::class;
    protected $validate = "\\app\\common\\validate\\User";

    protected $validateAddScene = 'add';
    protected $formField = [
        ['field' => 'id', 'type' => 'hidden'],
        ['field' => 'nickname', 'label' => '昵称', 'mid' => '只能是汉字、字母和数字'],
        ['field' => 'username', 'label' => '登录账号', 'mid' => '只能是字母和数字'],
        ['field' => 'mobile', 'label' => '手机号'],
        ['field' => 'password', 'type' => 'password', 'label' => '密码'],
        ['field' => 'password_confirm', 'type' => 'password', 'label' => '确认密码'],
        ['field' => 'role_id[]', 'label' => '角色', 'type' => 'checkbox', 'value' => []],
        ['field' => 'status', 'label' => '状态', 'type' => 'radio', 'value' => "0|禁用,1|启用", 'default' => 1],
    ];

    public function index()
    {
        if ($this->request->isAjax()) {
            $where = getSearchWhere($this->request->param());
            $data = UserModel::allPage($where);
            return Response::layuiSuccess($data->items(), $data->total());
        }
        return $this->fetch();
    }

    public function add()
    {
        if (!$this->request->isAjax()) {
            $this->formField[6]['value'] = \app\common\model\Role::allSelect();
        }
        return parent::add();
    }

    public function edit($id)
    {
        if (!$this->request->isAjax()) {
            $this->formField[6]['value'] = \app\common\model\Role::allSelect();
            $data = $this->model->where(['id' => $id])->find()->toArray();
            $this->formData = $data;
        }

        return parent::edit($id);
    }

    public function role($id)
    {
        $user = $this->model->where(['id' => $id])->find();
        if ($this->request->isAjax()) {
            $user->role_id = $this->param['role_id'];
            if ($user->save()) {
                return Response::success();
            }
            return Response::fail(1, '保存失败');
        }
        if (!$user) {
            $this->error('用户不存在');
        }
        $roles = \app\common\model\Role::where(['status' => 1])->field('id as value,name')->select()->toArray();
        $this->assign('formConfig', [
            'action' => $this->request->action(),
            'field' => [
                ['field' => 'id', 'type' => 'hidden'],
                ['field' => 'role_id[]', 'label' => '角色', 'type' => 'checkbox', 'value' => $roles],
            ],
            'method' => 'POST',
            'data' => [
                "role_id" => $user->role_id,
                'id' => $id
            ]
        ]);
        return $this->fetch('template:form');
    }

    /**
     * 权限设置
     *
     * @param $id
     *
     * @return string|\think\response\Json
     */
    public function permission($id)
    {
        $user = $this->model->where(['id' => $id])->find();
        $menu_ids = [];
        foreach ($user->roles as $role) {
            $menu_id = RoleModel::getCheckMenuId($role->id, $user->menu_id);
            $menu_ids = array_merge_recursive($menu_ids, $menu_id);
        }

        if ($this->request->isAjax()) {
            $add = array_diff($this->param['menu_id'], $menu_ids);
            $del = array_diff($menu_ids, $this->param['menu_id']);

            $user->menu_id = [
                "add" => array_values($add),
                "del" => array_values($del)
            ];
            if (!$user->save()) {
                return Response::fail();
            }
            return Response::success();
        }
        $auth = RoleModel::allAuth();
        $this->assign('auth', RoleModel::tree($auth, $menu_ids));
        return $this->fetch();
    }

    public function send($id)
    {
        $user = $this->model->where(['id' => $id])->find();
        if(!$user || $user->getOrigin("online") == 0){
            return Response::fail(-1,"用户不存在或已下线");
        }
        $value = $this->request->param('value');
        $data = Gateway::sendToUid($id,json_encode(["message"=>$value,"type"=>"notice"]));
        return Response::success($data,"发送成功");
    }
}
