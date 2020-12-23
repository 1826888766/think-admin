<?php
declare (strict_types = 1);

namespace app\console\controller;

use app\common\controller\ConsoleBase;

class Index extends ConsoleBase
{
    public function index()
    {
        return $this->fetch();
    }

    public function welcome()
    {
        return $this->fetch();
    }
}
