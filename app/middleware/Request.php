<?php
declare (strict_types=1);

namespace app\middleware;

use app\common\model\BlackIp;
use app\common\model\Log;
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


        $user = session('user');
        $module = app('http')->getName();
        switch ($module) {
            case 'api':
                $type = 3;
                break;
            case 'console':
                $type = 1;
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

        Log::add($data);
        if ($disable) {
            return Response::create('当前ip：' . $request->ip() . ",已被限制请求");
        }
        return $next($request);
    }
}
