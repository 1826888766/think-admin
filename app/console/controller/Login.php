<?php


namespace app\console\controller;


use app\BaseController;
use app\common\controller\Response;

class Login extends BaseController
{
    public function index()
    {
        if ($this->request->isAjax()) {
            $data = [
                'username' => $this->request->param('username'),
                'password' => $this->request->param('password'),
                'captcha' => $this->request->param('captcha'),
            ];
            $validate = $this->validate($data, [
                'username|用户名或手机号' => 'require',
                'password|用户名或手机号' => 'require',
            ]);
            if ($validate !== true) {
                return Response::fail(1, $validate);
            }
            $login = \app\common\model\User::login($data);
            if ($login === true) {
                return Response::success();
            }
            return Response::fail(1, $login);
        }
        return $this->fetch();
    }
}