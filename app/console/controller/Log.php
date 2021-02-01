<?php
declare (strict_types=1);

namespace app\console\controller;


use app\common\controller\ConsoleBase;
use app\common\controller\Response;
use app\common\model\Log as LogModel;

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

    public function disabled()
    {
        
    }
}
