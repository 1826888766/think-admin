<?php


namespace app\common\model;


use think\Model;

class ModelBase extends Model
{

    public static function allPage($where = [])
    {
        $limit = request()->param('limit', 10);
        return self::where($where)->order('id desc')->paginate($limit);
    }
}