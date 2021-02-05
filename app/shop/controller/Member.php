<?php
declare (strict_types = 1);

namespace app\shop\controller;

use app\common\controller\ConsoleBase;

class Member extends ConsoleBase
{
    /**
     * 显示资源列表
     */
    public function index()
    {
        return $this->fetch();
    }

}
