<?php
/**
 * Created by PhpStorm.
 * User: 赵浙豫
 * Date: 2017/5/23
 * Time: 15:53
 */
namespace Admin\Controller;
//use Think\Controller;
use Common\Controller\AdminbaseController;
class AdvertisementController extends AdminbaseController{
    /*
     * 广告管理
     * */
    public function index(){
        $at_item=D('at_item');
        $parameter=$at_item->where('status!=-1')->select();
        $this->list=$parameter;
        $this->count=count($parameter);
        $this->display();
    }
    /*
     * 广告详细
     * */
    public function detailed(){
        $id=I('id');
        $at_item=D('at_item');
        $parameter=$at_item->where('id='.$id)->find();
        $parameter['manager_name']=M('manager')->where('id='.$parameter['manager_id'])->getField('real_name');
        $this->list=$parameter;
        $this->display();
    }
    /*
     * 添加广告
     * */
    public function itemAdd(){
        $at_item=D('at_item');
        $savePath='Item'; //定义图片上传路径
        upload($savePath);
        if(IS_AJAX){
            //回调函数过滤数组中的元素
            $param = array_filter($_POST);
            $param['create_time']=time();
            $param['manager_id']=session('adminId');
            $item_add=$at_item->add($param);
            if($item_add){
                $data['status']  = 1;
                $this->ajaxReturn($data);
                exit;
            }else{
                $data['status']  = 0;
                $this->ajaxReturn($data);
                exit;
            }
        }
        $this->display();
    }
    /*
     * 广告编辑
     * */
    public function typeEdit(){
        $at_item=D('at_item');
        $id=I('id');
        if(IS_AJAX){
      /*      $savePath='Item'; //定义图片上传路径
            upload($savePath);*/
            //回调函数过滤数组中的元素
            $param = array_filter($_POST);
            $param['last_update_time']=time();
            $param['manager_id']=session('adminId');
            $item_save=$at_item->where('id='.$id)->save($param);
            if($item_save){
                $data['status']  = 1;
                $this->ajaxReturn($data);
                exit;
            }else{
                $data['status']  = 0;
                $this->ajaxReturn($data);
                exit;
            }
        }
        $parameter=$at_item->where('id='.$id)->find();
        $this->list=$parameter;
        $this->id=$id;
        $this->display();
    }
    /*
     * 广告显示、不显示、删除
     * */
    public function item_type(){
        $at_item=D('at_item');
        $id=I('id');
        $status=I('status','',int);
        $item_type=$at_item-> where('id='.$id)->setField('status',$status);
        if($item_type AND $status==1){
            $data['status']  = 1;
            $this->ajaxReturn($data);
            exit;
        }elseif($item_type AND $status==-1){
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