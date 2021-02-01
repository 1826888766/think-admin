<?php
declare (strict_types = 1);

namespace app;

use think\App;
use think\exception\ValidateException;
use think\facade\View;
use think\Validate;

/**
 * 控制器基础类
 */
abstract class BaseController
{
    /**
     * Request实例
     * @var \think\Request
     */
    protected $request;

    /**
     * 应用实例
     * @var \think\App
     */
    protected $app;

    protected $view;

    /**
     * 是否批量验证
     * @var bool
     */
    protected $batchValidate = false;

    /**
     * 控制器中间件
     * @var array
     */
    protected $middleware = [];

    /**
     * 构造方法
     * @access public
     * @param  App  $app  应用对象
     */
    public function __construct(App $app)
    {
        $this->app     = $app;
        $this->request = $this->app->request;
        $this->view =  View::instance();

        // 控制器初始化
        $this->initialize();
    }

    // 初始化
    protected function initialize()
    {
    }

    /**
     * 验证数据
     * @access protected
     * @param  array        $data     数据
     * @param  string|array $validate 验证器名或者验证规则数组
     * @param  array        $message  提示信息
     * @param  bool         $batch    是否批量验证
     * @return array|string|true
     * @throws ValidateException
     */
    protected function validate(array $data, $validate, array $message = [], bool $batch = false)
    {
        if (is_array($validate)) {
            $v = new Validate();
            $v->rule($validate);
        } else {
            if (strpos($validate, '.')) {
                // 支持场景
                [$validate, $scene] = explode('.', $validate);
            }
            $class = false !== strpos($validate, '\\') ? $validate : $this->app->parseClass('validate', $validate);
            $v     = new $class();
            if (!empty($scene)) {
                $v->scene($scene);
            }
        }

        $v->message($message);

        // 是否批量验证
        if ($batch || $this->batchValidate) {
            $v->batch(true);
        }
        if (true === $v->check($data)){
            return true;
        }else{
            return $v->getError();
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
