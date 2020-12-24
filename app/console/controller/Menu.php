<?php
declare (strict_types=1);

namespace app\console\controller;

use app\common\controller\ConsoleBase;
use app\common\controller\Response;
use app\common\model\Menu as MenuModel;

class Menu extends ConsoleBase
{

    /**
     * 菜单管理
     *
     * @return string
     */
    public function index()
    {
        if ($this->request->isAjax()) {
            $list = MenuModel::getMenuByParentId(0, ['module']);
            return Response::layuiSuccess($list, count($list));
        }
        return $this->fetch();
    }
}
