<?php 
namespace addons\test\controller;
use addons\test\Plugin;
class Index extends Plugin{

    public function index()
    {
        return $this->fetch();
    }
}