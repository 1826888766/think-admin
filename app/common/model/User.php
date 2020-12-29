<?php
declare (strict_types=1);

namespace app\common\model;

use think\helper\Str;
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
        return self::with(['roles'])->paginate($limit);
    }

    public static function onAfterInsert(Model $model): void
    {
        $model->password = create_password($model->password);
    }

    public static function onAfterUpdate(Model $model): void
    {
        if ($model->password) {
            $model->password = create_password($model->password);
        }else{
            $model->hidden(['password']);
        }
    }

    public function setRoleIdAttr($value): string
    {
        if ($value) {
            return join(',', $value);
        }
        return '';
    }

    public function roles()
    {
        return $this->hasMany(Role::class,'id', 'role_id');
    }

}
