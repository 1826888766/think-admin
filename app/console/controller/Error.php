<?php 
namespace app\console\controller;

class Error
{
    public function __call($method,$args)
    {
        return $method;   
    }
    
}
