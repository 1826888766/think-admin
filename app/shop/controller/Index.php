<?php
declare (strict_types = 1);

namespace app\shop\controller;

use app\common\controller\ConsoleBase;

class Index extends ConsoleBase
{
    public function index()
    {
        return '您好！这是一个[shop]示例应用';
    }
}
