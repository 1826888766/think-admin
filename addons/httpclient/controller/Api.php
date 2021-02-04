<?php

namespace addons\httpclient\controller;

use addons\httpclient\Plugin;
use think\helper\Str;

class Api extends Plugin
{
    public function index()
    {
        return $this->fetch();
    }

    public function send()
    {
        $param = $this->request->param();
        $result = $this->request($param['url'], $param['method']??'get', $param['param']??[], $param['header']??[], $param['cookie']??[]);
        return json($result);
    }


    function request($url, $method = "get", $params = array(), $header = array(), $cookie = [])
    {
        if ($method == "get"){
            if(stripos($url,"?")){
                $url.="&".http_build_query($params);
            }else{
                $url.="?".http_build_query($params);
            }
        }
        $curl  =  curl_init ( ) ;
        curl_setopt ( $curl , CURLOPT_URL ,  $url ) ;
        curl_setopt ( $curl , CURLOPT_USERAGENT ,  'Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.1; Trident/6.0)' ) ;
        curl_setopt ( $curl , CURLOPT_FOLLOWLOCATION ,  1 ) ;
        curl_setopt ( $curl , CURLOPT_AUTOREFERER ,  1 ) ;
        curl_setopt ( $curl , CURLOPT_REFERER ,  "http://www.baidu.com" ) ;
        if ( $method=="post" )  {
            curl_setopt ( $curl , CURLOPT_POST ,  1 ) ;
            curl_setopt ( $curl , CURLOPT_POSTFIELDS ,  http_build_query ( $params ) ) ;
        }
        curl_setopt($curl, CURLOPT_ENCODING, "");
        if(Str::startsWith($url, "https://")) {
            curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
            curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, false);
        }
        if ($header){
            curl_setopt($curl, CURLOPT_HTTPHEADER, $header);
        }

        if ( $cookie )  {
            curl_setopt ( $curl , CURLOPT_COOKIE ,  http_build_cookie($cookie)) ;
        }
        curl_setopt ( $curl , CURLOPT_HEADER ,  true ) ;
        curl_setopt ( $curl , CURLOPT_TIMEOUT ,  10 ) ;
        curl_setopt ( $curl , CURLOPT_RETURNTRANSFER ,  1 ) ;
        $data  =  curl_exec ( $curl ) ;
        if  ( curl_errno ( $curl ) )  {
            return  curl_error ( $curl ) ;
        }

        curl_close ( $curl ) ;
            list ($header ,  $body )  =  explode ( "\r\n\r\n" ,  $data ,  2 ) ;
            preg_match_all ( "/Set\-Cookie:([^;]*);/" ,  $header ,  $matches ) ;
        $cookie   =  $matches [ 1 ] ;
        $httpCode = explode(" ", $header)[1];
        if(! mb_check_encoding($body, 'utf-8')) {
            $body = mb_convert_encoding($body,'UTF-8',['ASCII','UTF-8','GB2312','GBK']);
        }
        return ["header"=>$header,"responseText"=>$body,"cookie"=>$cookie,"status"=>$httpCode];
    }


}