<?php


namespace app\console\tags;

use Exception;
use think\template\TagLib;

class Ta extends TagLib
{
    /**
     * 定义标签列表
     */
    protected $tags = [
        // 标签定义： attr 属性列表 close 是否闭合（0 或者1 默认1） alias 标签别名 level 嵌套层次
        'button' => ['attr' => 'id,type,class,url,ajax,size,confirm,reload,iframe', 'alias' => "btn", 'close' => 1], //闭合标签，默认为不闭合
    ];

    /**
     * 按钮支持异步提交
     *
     * @param array  $tag
     * @param string $content
     *
     * @return string
     */
    public function tagButton(array $tag, string $content): string
    {
        $theme = $tag['theme'] ?? '';
        $id = $tag['id'] ?? createId('btn');
        $size = $tag['size'] ?? 'sm';
        $type = $tag['type'] ?? 'button';
        $class = "layui-btn layui-btn-{$size} layui-btn-{$theme}";
        $content = "<button id='{$id}' type='$type' class='$class' >{$content}</button>";
        $url = $tag['url'] ?? '';
        if ($url) {
            $iframe = $tag['iframe'] ?? false;
            $reload = $tag['reload'] ?? true;
            $ajax = $tag['ajax'] ?? true;
            if ($iframe) {
                $confirm = $tag['confirm'] ?? '';
                $content .= $this->parseJump($id, $url, $confirm, $iframe);
            } else if ($ajax) {
                $confirm = $tag['confirm'] ?? '确认执行当前操作吗？';
                $content .= $this->parseAjax($id, $url, $confirm, $reload);
            }
        }
        return $content;
    }

    public function parseAjax($id, $url, $confirm = "", $reload = false): string
    {
        if ($reload && $reload !== "false" && $reload !== 0 && $reload !== "0") {
            $reload = "location.reload()";
        } else {
            $reload = "";
        }
        return "<script>
    $('#{$id}').click(function() {
          if ('{$confirm}'){
            layer.confirm('{$confirm}',{
                title:'提示'
            },function() {
              $.ajax({
                    url:'{$url}',
                    method:'POST',
                    success:function (res){
                        layer.msg(res.msg)
                        if(res.code == 0){
                            {$reload}
                        }
                    }
                })
            })
        }else{
            $.ajax({
                url:'{$url}',
                method:'POST',
                success:function (res){
                    layer.msg(res.msg)
                    if(res.code == 0){
                        {$reload}
                    }
                }
            })
        }
    })
    </script>";
    }

    public function parseJump($id, $url, $confirm = "", $iframe = false): string
    {

        return "<script>
    $('#{$id}').click(function() {
          if ('{$confirm}'){
            layer.confirm('{$confirm}',{
                title:'提示'
            },function() {
               if ('{$iframe}' == true) {
                layerOpen('{$url}')
            } else {
               location.href = '{$url}'
            }
            })
        }else{
             if ('{$iframe}' == true) {
                layerOpen('{$url}')
            } else {
               location.href = '{$url}'
            }
           
        }
    })
    </script>";
    }
}