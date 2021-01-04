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

    //
    public static function allPage($limit = 10)
    {
        return self::where([])->append(['roles'])->paginate($limit);
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
        if (!verity_password($user['password'], $_user['password'])) {
            return "密码错误";
        }
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
        return serialize($value);
    }

    public function getMenuIdAttr($value)
    {
        return unserialize($value);
    }

    public function getRolesAttr()
    {
        return Role::where('id', 'in', $this->getData('role_id'))->field('id,name')->select();
    }

}
