<?php
declare (strict_types=1);

namespace app\console\controller;

use app\common\controller\ConsoleBase;
use app\common\controller\Response;
use think\Request;
use \app\common\model\User as UserModel;

class User extends ConsoleBase
{
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
        ['field' => 'status', 'label' => '状态', 'type' => 'radio', 'value' => "0|禁用,1|启用",'default'=>1],
    ];

    public function index()
    {
        if ($this->request->isAjax()) {
            $data = UserModel::allPage();
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
            $data['role_id'] = explode(',',$data['role_id']);
            $this->formData = $data;
        }
        
        return parent::edit($id);
    }

    public function role()
    {
    
        return $this->fetch();   
    }

}
