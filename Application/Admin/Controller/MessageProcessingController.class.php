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
class MessageProcessingController extends AdminbaseController{
    /*
     * 留言处理
     * $name    会员姓名
     * $status  留言状态
     * */
    public function index(){
        $comments=D('leave_comments');
        $name=I('name');
        $status=I('status',null,0);
        $parameter=$comments->index($name,$status);
        $this->name=$name;
        $this->status=$status;
        $this->list=$parameter;
        $this->count=count($parameter);
        $this->display();
    }

    /*
     *留言详细
     * */
    public function detailed(){
        $comments=D('leave_comments');
        $id=I('id');
        $parameter=$comments->detailed($id);
        $this->list=$parameter;
        $this->display();
    }
    /*
     * 回复
     * */
    public function reply(){
        $comments=D('leave_comments');
        $id=I('id');
        if(IS_AJAX){
            $param = array_filter(I('post.'));
            $param['recomments_date']=time();
            $param['reco_id']=session('adminId');
            $param['status']='1';
            $return=$comments->where(array('id'=>$id))->save($param);
            if($return){
                $data['status']  = 1;
                $this->ajaxReturn($data);
                exit;
            }else{
                $data['status']  = 0;
                $this->ajaxReturn($data);
                exit;
            }
        }
        $parameter=$comments->reply($id);
        $this->id=$id;
        $this->list=$parameter;
        $this->display();
    }
    /*
     * 删除
     * */
    public function leave_word_status(){
        $id=I('id');
        $status=I('status','',int);
        $case_item=D('leave_comments')-> where('id='.$id)->setField('status',$status);
       if($case_item AND $status==-1){
            $data['status']  = 1;
            $this->ajaxReturn($data);
            exit;
        }else{
            $data['status']  = 2;
            $this->ajaxReturn($data);
            exit;
        }
    }

}