<?php
namespace Admin\Controller;
use Common\Controller\AdminbaseController;
class IndexController extends AdminbaseController
{
    /**
     * 后台登陆首页控制器
     * @author wangzhiqiang <[<iyting@foxmail.com>]>
     * @return [type] [description]
     */
    public function index()
    {
        header("Content-type:text/html;charset=utf-8");
        $user_info['username'] = session('username');
        $name = 'ThinkPHP';
        $this->assign('name',$name);
	 //   $this->assign($user_info,'user_info',);
        $act_list = session('act_list');
        $menu_list = getMenuList($act_list);
        // print("<pre>");
        // print_r($menu_list);
        // print("<pre>");die;
        $this->assign('menu_list',$menu_list);
        $this->display();
    }

    public function welcome()
    {

        $this->display();
    }
    public function auth(){
        $this->display();
    }
}
