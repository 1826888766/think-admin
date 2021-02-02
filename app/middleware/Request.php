<?php
declare (strict_types=1);

namespace app\middleware;

use app\common\model\BlackIp;
use app\common\model\Log;
use GatewayWorker\Lib\Gateway;
use think\facade\Cache;
use think\Response;

class Request
{
    /**
     * 处理请求
     *
     * @param \think\Request $request
     * @param \Closure       $next
     *
     * @return Response
     */
    public function handle($request, \Closure $next)
    {
        // 白名单
        $disable = false;
        $white = BlackIp::where(['type' => 2, 'status' => 1])->column('ip');
        if (empty($white)) {
            // 黑名单模式
            $ip = BlackIp::where(['ip' => $request->ip(), 'status' => 1])->find();
            if ($ip) {
                $disable = true;
                $ip->count += 1;
                $ip->save();
            }
        } else {
            // 白名单模式
            if (array_search($request->ip(), $white) === false) {
                $disable = true;
            }
        }
        $user = session('login_token');
        $module = app('http')->getName();
        switch ($module) {
            case 'api':
                $type = 3;
                break;
            case 'console':
                $type = 1;
                if ($request->controller() == "Login") {
                    $type = 4;
                }
                break;
            default:
                if ($request->isAjax()) {
                    $type = 2;
                    break;
                }
                $type = 1;
                break;
        }
        $data = [
            'note' => ($disable ? '【已拦截】' : '【正常】') . '全局请求中间件',
            'url' => $request->url(true),
            'param' => $request->param(),
            'request_ip' => $request->ip(),
            'type' => $type
        ];
        if ($user) {
            $data['admin_id'] = $user['id'];
        }
        $this->checkRequestIpCount($request);
        Log::add($data);
        if ($disable) {
            return Response::create('<h1 style="text-align: center"> 403 Forbidden</h1><h3 style="text-align: center">ip:' . $request->ip() . '</h3>', "html", 403);
        }
        return $next($request);
    }

    public function checkRequestIpCount($request)
    {
        $max = 30;
        $key = "ip_" . md5($request->ip() . date("YmdH"));
        if (Cache::has($key)) {
            $num = Cache::get($key) + 1;
        } else {
            $num = 1;
        }
        if ($num > $max) {
            $url = url('console/black_ip/index')->domain(true)->build();
            $send_data = ['type' => 'notice', 'msg' => "<a href='{$url}'>ip:{$request->ip()},小时请求已超过{$max}>>>点击前往</a>"];
            if (strtoupper(substr(PHP_OS, 0, 3)) !== 'WIN') {
                Gateway::sendToAll(json_encode($send_data));
            }
        }
        Cache::set($key, $num);
    }
}
