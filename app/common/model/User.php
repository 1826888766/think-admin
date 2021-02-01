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

    public static function onAfterInsert(Model $model): void
    {
        $model->password = create_password($model->password);
    }

    public static function onAfterUpdate(Model $model): void
    {
        if ($model->password) {
            $model->password = create_password($model->password);
        } else {
            $model->hidden(['password']);
        }
    }

    public static function login($user)
    {
        $_user = self::where('username', $user['username'])->find();
        if (!$_user) {
            return "用户或手机号不存在";
        }

        $password_fail = $_user->password_fail;
        $password_fail = $password_fail ? $password_fail : 0;
        $password_fail_number = 5;
        if ($password_fail >= $password_fail_number) {
            return "连续登录{$password_fail}次错误,请联系管理员";
        }
        if ($_user->status != 1) {
            return "您已被管理员禁用";
        }
        if (!verity_password($user['password'], $_user['password'])) {
            $password_fail += 1;
            $_user->password_fail = $password_fail;
            $_user->save();
            return "密码错误，次数{$password_fail},错误{$password_fail_number}次将被禁用";
        }
        $_user->last_login_ip = request()->ip();
        $_user->last_login_time = time();
        $_user->save();
        session('login_token', $_user);
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

}
