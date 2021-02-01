<?php
declare (strict_types=1);

namespace app\middleware;

use app\common\model\Log;

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
            'note' => '全局请求中间件',
            'url' => $request->url(true),
            'param' => $request->param(),
            'request_ip' => $request->ip(),
            'type' => $type
        ];
        if ($user) {
            $data['admin_id'] = $user['id'];
        }

        Log::add($data);
        return $next($request);
    }
}
