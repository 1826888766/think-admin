<?php 
return [
    'name' => 'test',	// 插件标识
    'title' => '插件测试',	// 插件名称
    'description' => 'thinkph6插件测试',	// 插件简介
    'status' => 1,	// 状态
    'author' => 'byron sampson',
    'version' => '0.1',
    "display"=>[
        'title' => '是否显示:',
        'type' => 'radio',
        'options' => [
            '1' => '显示',
            '0' => '不显示'
        ],
        'value' => '1'
    ]
];