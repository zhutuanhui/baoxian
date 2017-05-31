<?php
/**
 * Created by PhpStorm.
 * User: 赵浙豫
 * Date: 2017/5/11
 * Time: 15:53
 */
namespace Admin\Controller;
//use Think\Controller;
use Common\Controller\AdminbaseController;
class LearningClassroomController extends AdminbaseController{
    /*
     * 课堂审核
     * $check_status    审核状态
     * $publisher_name  作者
     * $title           标题
     * */
    public function index(){
        $study=D('study');
        $check_status=I('check_status',null,0);
        $publisher_name=I('publisher_name');
        $title=I('title');
        $parameter=$study->check_index($check_status,$publisher_name,$title);
        $this->check_status=$check_status;
        $this->publisher_name=$publisher_name;
        $this->title=$title;
        $this->count=count($parameter);
        $this->list=$parameter;
        $this->display();
    }

    /*
     * 审核与删除
     * */
    public function classroom_status(){
        $id=I('id');
        $status=I('status','',int);
        $case_item=D('study')->status($id,$status);
        if($case_item AND $status==1){
            $data['status']  = 1;
            $this->ajaxReturn($data);
            exit;
        }elseif($case_item AND $status==-2){
            $data['status']  = 3;
            $this->ajaxReturn($data);
            exit;
        }else{
            $data['status']  = 2;
            $this->ajaxReturn($data);
            exit;
        }
    }
}