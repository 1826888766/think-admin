<?php
declare (strict_types=1);

namespace app\common\model;

use think\Model;

/**
 * @mixin \think\Model
 */
class User extends Model
{
    protected $hidden = ['password'];

    protected $type = [
        'last_login_time' => "date"
    ];

    public function getLastLoginTimeAttr($value)
    {
        if ($value) {
            return date("Y-m-d H:i:s", $value);
        }
        return "";
    }

    //
    public static function allPage($where = [], $limit = 10)
    {
        return self::where($where)->append(['roles'])->order('id desc')->paginate($limit);
    }

    public static function onBeforeInsert(Model $model): void
    {
        $model->password = create_password($model->password);
    }

    public static function onBeforeUpdate(Model $model): void
    {
        if (password_needs_rehash($model->password, PASSWORD_DEFAULT)) {
            $model->password = create_password($model->password);
        } else {
            $model->hidden(['password']);
        }
    }

    /**
     * @param array $user 用户输入的账户密码
     *
     * @return bool|string
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public static function login($param)
    {
        $user = self::where('username', $param['username'])->find();
        if (!$user) {
            return "用户或手机号不存在";
        }

        $password_fail = $user->password_fail;
        $password_fail = $password_fail ? $password_fail : 0;
        $password_fail_number = 5;
        if ($password_fail >= $password_fail_number) {
            return "连续登录{$password_fail}次错误,请联系管理员";
        }
        if ($user->status != 1) {
            return "您已被管理员禁用";
        }
        if (!verity_password($param['password'], $user['password'])) {
            $password_fail += 1;
            $user->password_fail = $password_fail;
            $user->save();
            return "密码错误，次数{$password_fail},错误{$password_fail_number}次将被禁用";
        }
        $user->last_login_ip = request()->ip();
        $user->last_login_time = time();
        $user->password_fail = 0;
        $user->save();
        session('login_token', $user);
        return true;
    }

    public static function checkLogin()
    {
        $user = session('login_token');
        if ($user) {
            return $user;
        }
        return false;
    }

    public function setRoleIdAttr($value): string
    {
        if ($value) {
            return join(',', $value);
        }
        return '';
    }

    public function getRoleIdAttr($value): array
    {
        if ($value) {
            return explode(',', $value);
        }
        return [];
    }

    public function setMenuIdAttr($value): string
    {
        if (!$value) {
            return $value;
        }
        return serialize($value);
    }

    public function getMenuIdAttr($value)
    {
        if (!$value) {
            return $value;
        }
        return unserialize($value);
    }

    public function getRolesAttr(): \think\Collection
    {
        return Role::where('id', 'in', $this->getData('role_id'))->field('id,name')->select();
    }

    public function getOnlineAttr($value)
    {
        $a = [
            0 => "下线",
            1 => "在线",
        ];
        return $a[$value];
    }

}
