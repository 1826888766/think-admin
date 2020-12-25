<?php

namespace app\common\controller;

use app\BaseController;
use app\common\model\Module;
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

    /**
     * 视图实例
     *
     * @var \think\View
     */
    protected $view;
    protected $param = [];
    protected $checkLogin = true;
    protected $checkAuth = true;

    protected $formField = [];
    // 模型
    /**
     * @var Model
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
     * 初始化操作
     *
     * @Author   马良 1826888766@qq.com
     * @DateTime 2020-12-23 09:56:49
     */
    public function initialize()
    {
        if (!$this->request->isAjax()) {
            $this->initView();
            $this->initMenu();
        }
        $this->param = request()->param();
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
        $this->view = View::instance();
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

    public function add()
    {
        if ($this->request->isAjax()) {
            if ($this->validate){
                $scene = $this->validateAddScene ? ":" . $this->validateAddScene : "";
                $error = $this->validate($this->param, $this->validate . $scene);
                if (true !== $error) {
                    return Response::fail(1, $error);
                }
            }
            if ($this->model){
                $data = $this->model->create($this->param);
                return Response::success($data);
            }
           return Response::fail(1,'请完善');

        }
        $this->assign('formConfig', [
            'action' => $this->request->action(),
            'field' => $this->formField,
            'method' => 'POST',
            'data' => $this->formData
        ]);
        return $this->fetch('template:form');
    }

    public function edit($id)
    {
        if ($this->request->isAjax()) {
            if ($this->validate) {
                $scene = $this->validateAddScene ? ":" . $this->validateAddScene : "";
                $error = $this->validate($this->param, $this->validate . $scene);
                if (true !== $error) {
                    return Response::fail(1, $error);
                }
            }
            if ($this->model) {
                $data = $this->model->where('id', $this->param['id'])->update($this->param);
                if ($data) {
                    return Response::success($data, '编辑成功');
                }
                return Response::fail(1, '编辑失败');
            }
            return Response::success([]);
        }
        $data = $this->model->where(['id' => $id])->find();
        $this->assign('formConfig', [
            'action' => $this->request->action(),
            'field' => $this->formField,
            'method' => 'POST',
            'data' => $data
        ]);
        return $this->fetch('template:form');
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

    /**
     * 渲染模板
     *
     * @Author   马良 1826888766@qq.com
     * @DateTime 2020-12-23 10:00:06
     *
     * @param string $template
     * @param array  $vars
     *
     * @return string
     */
    public function fetch($template = "", $vars = []): string
    {
        return $this->view->fetch($template, $vars);
    }

    /**
     * 渲染内容
     *
     * @Author   马良 1826888766@qq.com
     * @DateTime 2020-12-23 13:42:32
     *
     * @param string $content
     * @param array  $vars
     *
     * @return string
     */
    public function display($content = "", $vars = []): string
    {
        return $this->view->display($content, $vars);
    }

    /**
     * 模板赋值
     *
     * @Author   马良 1826888766@qq.com
     * @DateTime 2020-12-23 13:42:02
     *
     * @param string|array $name
     * @param mixed        $value
     *
     * @return \think\View
     */
    public function assign($name, $value = null): \think\View
    {
        return $this->view->assign($name, $value);
    }

    /**
     * 模板引擎
     *
     * @Author   马良 1826888766@qq.com
     * @DateTime 2020-12-23 13:43:21
     *
     * @param string $type
     *
     * @return \think\View
     */
    public function engine($type = 'Think'): \think\View
    {
        return $this->view = View::engine($type);
    }

}