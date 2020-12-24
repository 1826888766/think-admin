<?php

namespace app\common\controller;

use app\BaseController;
use app\common\model\Module;
use think\facade\View;

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

    protected $checkLogin = true;

    protected $checkAuth = true;

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
        $this->assign('menus',$menus);
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