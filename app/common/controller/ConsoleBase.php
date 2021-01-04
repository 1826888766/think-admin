<?php

namespace app\common\controller;

use app\BaseController;
use app\common\model\Module;
use app\common\model\User;
use think\facade\View;
use think\Model;

/**
 * 控制台基础控制器
 *
 * @Author   马良 1826888766@qq.com
 * @DateTime 2020-12-23 09:57:03
 */
class ConsoleBase extends BaseController
{

    use \think\Jump;

    protected $param = [];
    protected $checkLogin = true;
    protected $checkAuth = true;

    protected $formField = [];
    // 模型
    /**
     * @var \think\Model
     */
    protected $model = "";
    // 验证器
    protected $validate = "";
    // 添加验证场景
    protected $validateAddScene = "";
    // 编辑验证场景
    protected $validateEditScene = "";
    protected $formData = [];
    /**
     * @var Model
     */
    protected $user = null;

    /**
     * 初始化操作
     *
     * @Author   马良 1826888766@qq.com
     * @DateTime 2020-12-23 09:56:49
     */
    public function initialize()
    {
        $this->initAuth();
        if (!$this->request->isAjax()) {
            $this->initView();
            $this->initMenu();
        }
        $this->param = request()->param();
        unset($this->param['iframe']);
        if ($this->model) {
            $this->model = model($this->model);
        }
    }

    /**
     * 初始化视图
     *
     * @param mixed $name 配置的模板模板布局
     *
     * @Author   马良 1826888766@qq.com
     * @DateTime 2020-12-23 15:59:30
     * @return void
     */
    private function initView($iframe = 1)
    {
        $is_iframe = $this->request->param('iframe', 0);
        if ($is_iframe == 1) {
            $this->view->layout('iframe');
        } else {
            $this->view->layout('layout');
            if ($iframe == 1) {
                // 是iframe布局
                $this->openIframe();
            }
        }
        $this->assign('script', "");
        $this->assign('iframe', $iframe);
    }

    /**
     * 初始化菜单
     */
    private function initMenu()
    {
        $menus = Module::allMenu();
        $this->assign('menus', $menus);
    }

    private function initAuth()
    {
        if ($this->checkLogin) {
            $this->checkLogin();
        }
    }

    /**
     * 检查登录
     */
    private function checkLogin()
    {
        $this->user = User::checkLogin();
        if (false === $this->user) {
            $this->redirect(url('login/index')->domain(true)->build());
        }
    }

    /**
     * 添加基础操作
     *
     * @Author   马良 1826888766@qq.com
     * @DateTime 2020-12-29 15:44:35
     */
    public function add()
    {
        if ($this->request->isAjax()) {
            if ($this->validate) {
                $scene = $this->validateAddScene ? "." . $this->validateAddScene : "";
                $error = $this->validate($this->param, $this->validate . $scene);
                if (true !== $error) {
                    return Response::fail(1, $error);
                }
            }
            if ($this->model) {
                $data = $this->model->create($this->param);
                return Response::success($data);
            }
            return Response::fail(1, '模型不存在');

        }
        $this->assign('formConfig', [
            'action' => $this->request->action(),
            'field' => $this->formField,
            'method' => 'POST',
            'data' => $this->formData
        ]);
        return $this->fetch('template:form');
    }

    /**
     * 编辑基础
     *
     * @Author        马良 1826888766@qq.com
     * @DateTime      2020-12-29 15:45:42
     *
     * @param         [int] $id
     *
     * @return string||json
     */
    public function edit($id)
    {
        if ($this->request->isAjax()) {
            if (isset($this->param['edit_status'])) {
                return $this->status($id);
            }
            if ($this->validate) {
                $scene = $this->validateAddScene ? "." . $this->validateAddScene : "";
                $error = $this->validate($this->param, $this->validate . $scene);
                if (true !== $error) {
                    return Response::fail(1, $error);
                }
            }
            if ($this->model) {
                $data = $this->model->update($this->param);
                if ($data) {
                    return Response::success($data, '编辑成功');
                }
                return Response::fail(1, '编辑失败');
            }
            return Response::fail(1, '模型不存在');
        }
        $data = $this->formData ?: $this->model->where(['id' => $id])->find()->getData();
        $this->assign('formConfig', [
            'action' => $this->request->action(),
            'field' => $this->formField,
            'method' => 'POST',
            'data' => $data
        ]);
        return $this->fetch('template:form');
    }

    /**
     * 状态更新基础
     *
     * @Author   马良 1826888766@qq.com
     * @DateTime 2020-12-29 15:45:15
     *
     * @param    [int|array] $id
     */
    public function status($id)
    {
        if ($this->request->isAjax()) {
            $field = $this->request->param('field', 'status');
            $val = $this->request->param('val', null);
            if (is_null($val) || !$field) {
                return Response::fail(1, '参数错误');
            }
            if ($this->model) {
                $data = $this->model->update([$field => $val], ['id' => $id]);
                if ($data) {
                    return Response::success($data, '修改成功');
                }
                return Response::fail(1, '修改失败');
            }
            return Response::fail(1, '模型不存在');
        }
        return Response::fail(1, '不支持的请求');
    }

    /**
     * 删除基础
     *
     * @Author   马良 1826888766@qq.com
     * @DateTime 2020-12-29 15:46:09
     *
     * @param    [int|array] $id
     */
    public function del($id)
    {
        if ($this->request->isAjax()) {
            if ($this->model) {
                $data = $this->model->destroy($id);
                if ($data) {
                    return Response::success(true, '删除成功');
                }
                return Response::fail(1, '删除失败');
            }
            return Response::fail(1, '未定义模型');
        }
        return Response::fail(1, '不支持当前请求');
    }

    private function openIframe()
    {
        if ($this->request->controller(true) == "index" && $this->request->action(true) == "index") {
            $redirect_url = $this->request->param('redirect_url', '');
            if ($redirect_url) {
                $this->assign('script', "addtab('$redirect_url');");
            }
        } else {
            $this->redirect(url('console/index/index'), 302, ['redirect_url' => $this->request->url()]);
        }

    }


}