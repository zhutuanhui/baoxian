<?php
/**
 *
 * 后台Controller继承类
 * @author [wangzhiqiang] <[<iyting@foxmail.com>]>
 * @date 2017-05-04
 */
namespace Common\Controller;
use Think\Controller;
class AdminbaseController extends Controller
{
    /**
     * 判断用户是否登录
     * @return [type] [description]
     */
    public function _initialize()
    {

        $sid = session('adminId');
        #$this->redirect('Index/index');
        //判断用户是否登陆
        if(!isset($sid ) ) {
            redirect(U('Admin/Login/index'));// 后台登陆控制器
             //$this->redirect('Index/index');
        }
         //过滤不需要登陆的行为
        if(in_array(ACTION_NAME,array('login','logout','vertify')) || in_array(CONTROLLER_NAME,array())){
            //return;
        }else{
            if(session('adminId') > 0 ){
                $this->check_priv();//检查管理员菜单操作权限
            }else{
                $this->error('请先登陆',U('Admin/Login/index'),1);
            }
        }
    }
    //检查管理员菜单操作权限
    public function check_priv()
    {
        $ctl = CONTROLLER_NAME;
        $act = ACTION_NAME;
        $act_list = session('act_list');
        //无需验证的操作
        $uneed_check = array('login','logout','vertifyHandle','vertify','imageUp','upload','login_task');
        if($ctl == 'Index' || $act_list == 'all'){
            //后台首页控制器无需验证,超级管理员无需验证
            return true;
        }elseif(strpos('ajax',$act) || in_array($act,$uneed_check)){
            //所有ajax请求不需要验证权限
            return true;
        }else{
            $right = M('manager_auth_node')->where("id in ($act_list)")->cache(true)->getField('authcode',true);
            foreach ($right as $val){
                $role_right .= $val.',';
            }
            $role_right = explode(',', $role_right);
            //检查是否拥有此操作权限
            if(!in_array($ctl.'Controller@'.$act, $role_right)){
                header("location:Index/auth");
                // $this->error('您没有权限',U('Admin/Index/auth'),2);
            }
        }
    }


}
