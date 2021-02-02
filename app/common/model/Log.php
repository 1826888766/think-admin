<?php


namespace app\common\model;


use think\Model;

class Log extends ModelBase
{
    public function getTypeAttr($value): string
    {
        $a = [
            1 => "系统日志",
            2 => "请求日志",
            3 => "接口日志",
            4 => "登录日志",
        ];
        return $a[$value];
    }

    public static function allPage($where = [])
    {
        $limit = request()->param('limit', 10);
        return self::where($where)->with(['admin'])->order('id desc')->paginate($limit);
    }

    public function admin()
    {
        return $this->hasOne(User::class, 'id', 'admin_id')->bind(['admin_name' => 'nickname']);
    }

    public static function add($data)
    {
        if ($data['param']) {
            $data['param'] = json_encode($data['param'], 256);
        }
        $time = date('Y-m-d H:i:s', strtotime('+1day'));
        $log = self::where($data)->order('id desc')->where('create_time', '<', strtotime($time))->where('create_time', '>', strtotime(date('Y-m-d 00:00:00')))->find();
        if ($log) {
            $log->count += 1;
            $log->save();
        } else {
            self::create($data);
        }
    }


}