<?php
declare (strict_types=1);

namespace app\console\controller;


use app\common\controller\ConsoleBase;
use app\common\controller\Response;
use app\common\model\BlackIp;
use app\common\model\Log as LogModel;
use think\Cache;
use think\facade\Db;

class Log extends ConsoleBase
{
    protected $model = LogModel::class;

    public function index()
    {
        if ($this->request->isAjax()) {
            $where = getSearchWhere($this->request->param());
            $data = LogModel::allPage($where);
            return Response::layuiSuccess($data->items(), $data->total());
        }
        return $this->fetch();
    }

    public function disable(): \think\response\Json
    {
        $id = $this->param['id'];
        $log = LogModel::where(['id' => $id])->find();
        if (!$log) {
            return Response::fail(1,'禁用失败');
        }
        if (BlackIp::where(['ip' => $log->request_ip])->find()) {
            return Response::fail(1,'重复禁用');
        }
        $data = BlackIp::create(['ip' => $log->request_ip]);
        if ($data) {
            return Response::success('禁用成功');
        }
        return Response::fail(1,'禁用失败');
    }

    public function clear()
    {
        Db::query("truncate table ta_log;");
        return Response::success('清空成功');
    }
}
