<?php


namespace app\console\controller;


use app\common\controller\ConsoleBase;
use app\common\controller\Response;

class Login extends ConsoleBase
{

    public function initialize()
    {
        // 禁用登录校验
        if ($this->request->action() == 'index'||$this->request->action() == 'logout') {
            $this->checkLogin = false;
            $this->checkAuth = false;
            $this->iframe = 0;
        }
        parent::initialize(); // TODO: Change the autogenerated stub
        $this->view->layout(false);
    }

    public function index()
    {
        $login_fail = session('login_fail');
        $login_fail_number = 3;
        if ($this->request->isAjax()) {
            $data = [
                'username' => $this->request->param('username'),
                'password' => $this->request->param('password'),
                'captcha' => $this->request->param('captcha'),
            ];
            $rule = [
                'username|用户名或手机号' => 'require',
                'password|密码' => 'require',
            ];
            if ($login_fail >= 3) {
                $rule['captcha|验证码'] = 'require|captcha';
            }
            $validate = $this->validate($data, $rule);
            if ($validate !== true) {
                return Response::fail(1, $validate);
            }
            $login = \app\common\model\User::login($data);
            if ($login === true) {
                return Response::success();
            }
            $login_fail = $login_fail ? ($login_fail + 1) : 1;
            session('login_fail', $login_fail);
            if ($login_fail >= $login_fail_number) {
                return Response::fail(2, $login);
            }
            return Response::fail(1, $login);
        }
        $this->assign('login_fail', $login_fail);
        $this->assign('login_fail_number', $login_fail_number);
        return $this->fetch();
    }

    public function logout()
    {
        session('login_token', null);
        return redirect(url('login/index'));
    }

    public function info()
    {
        $user = session('login_token');
        if (!$user) {
            return redirect(url('login/index'));
        }
        return $this->fetch();
    }
}