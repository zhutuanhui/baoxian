<?php
return array(
	//'配置项'=>'配置值'
    'URL_CASE_INSENSITIVE'  =>  false,  //设置URL大小写
    'SHOW_PAGE_TraCE' 	=> true,// 显示页面Trace信息
    'S_TIME'			=>	10,//缓存时间
    'LOAD_EXT_CONFIG'   =>  'db,timesetting',// 加载扩展配置文件
    'MODULE_ALLOW_LIST' =>  array('Home','Admin'),// 允许访问的模块列表
    'URL_MODEL'         => 0,
    'DEFAULT_MODULE'    =>  'Admin',// 默认模块
//    'TMPL_FILE_DEPR'    =>  '_',//设置目录层次
    'TMPL_PARSE_STRING' =>  array(
        '__IMG__'   =>  'http://localhost/Insurance_Admin' // 图片URL地址
    ),

    'UPLOAD_IMAGE_URL' =>'' //服务器域名
);
