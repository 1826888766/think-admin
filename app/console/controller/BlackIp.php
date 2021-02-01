<?php
declare (strict_types = 1);

namespace app\console\controller;

use app\common\controller\ConsoleBase;
use app\common\controller\Response;
use app\common\model\BlackIp as BlackIpModel;
use think\Request;

class BlackIp extends ConsoleBase
{
    protected $model = BlackIpModel::class;

    protected $formField = [
        ['field' => 'id', 'type' => 'hidden'],
        ['field' => 'ip', 'label' => 'ip', 'mid' => '如：127.0.0.1'],
        ['field' => 'type', 'label' => '类型', 'type' => 'radio', 'value' => "1|黑名单,2|白名单", 'default' => 1],
        ['field' => 'status', 'label' => '状态', 'type' => 'radio', 'value' => "0|禁用,1|启用", 'default' => 1],
    ];
    /**
     * 显示资源列表
     */
    public function index()
    {
        if ($this->request->isAjax()) {
            $where = getSearchWhere($this->request->param());
            $data = BlackIpModel::allPage($where);
            return Response::layuiSuccess($data->items(), $data->total());
        }
        return $this->fetch();
    }

}
