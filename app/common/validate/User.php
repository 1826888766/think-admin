<?php
declare (strict_types=1);

namespace app\common\validate;

use think\Validate;

class User extends Validate
{
    /**
     * 定义验证规则
     * 格式：'字段名' =>  ['规则1','规则2'...]
     *
     * @var array
     */
    protected $rule = [
        'id' => 'require',
        'nickname' => 'require|chsDash',
        'username' => 'require|alphaNum',
        'mobile' => 'require|mobile',
        'password' => 'require|alphaNum|confirm',
        'role_id' => 'require',
    ];

    /**
     * 定义错误信息
     * 格式：'字段名.规则名' =>  '错误信息'
     *
     * @var array
     */
    protected $message = [];

    public function sceneAdd()
    {
        return $this->remove('id','require')->remove('password','require');
    }
    public function sceneInfo()
    {
        return $this->remove('role_id','require');
    }
}
