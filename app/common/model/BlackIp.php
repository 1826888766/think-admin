<?php
declare (strict_types = 1);

namespace app\common\model;

use think\Model;

/**
 * @mixin \think\Model
 */
class BlackIp extends ModelBase
{
    public function getTypeAttr($value): string
    {
        $a = [
            1 => "黑名单",
            2 => "白名单",
        ];
        return $a[$value];
    }

}
