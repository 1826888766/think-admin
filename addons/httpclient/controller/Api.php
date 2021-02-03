<?php
namespace addons\httpclient\controller;

use addons\httpclient\Plugin;

class Api extends Plugin
{
    public function index()
    {
        return $this->fetch();
    }
}