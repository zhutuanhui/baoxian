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
class CommonProblemController extends AdminbaseController{
    /*
     * 常见问题
     * */
    public function index(){
        $where='status!=-1';
        $question=D('question')->where($where)->select();
        $this->list=$question;
        $this->count=count($question);
        $this->display();
    }
    /*
     * 添加常见问题
     * */
    public function questionAdd(){
        $product=D('question');
        if(IS_AJAX){
            if($product->create()) {
                $result = $product->add();
                if ($result) {
                    $data['status'] = 1;
                    $this->ajaxReturn($data);
                    exit;
                } else {
                    $data['status'] = 0;
                    $this->ajaxReturn($data);
                    exit;
                }
            }
        }
        $this->display();
    }
    /*
     * 编辑常见问题
     * $id  问题ID
     * */
    public function questionEdit(){
        $question=D('question');
        $id=I('id');
        if(IS_AJAX){
            $param = array_filter(I('post.'));
            $param['last_update_time']=time();
            $return=$question->where(array('id'=>$id))->save($param);
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
        $parameter=$question->edit($id);
        $this->id=$id;
        $this->list=$parameter;
        $this->display();
    }
    /*
     * 常见问题状态
     * 状态：1=显示  0=未显示 -1=删除
     * */
    public function question_status(){
        $id=I('id');
        $status=I('status','',int);
        $case_item=D('question')-> where('id='.$id)->setField('status',$status);
        if($case_item AND $status==0){
            $data['status']  = 0;
            $this->ajaxReturn($data);
            exit;
        }elseif($case_item AND $status==-1){
            $data['status']  = 2;
            $this->ajaxReturn($data);
            exit;
        }else{
            $data['status']  = 1;
            $this->ajaxReturn($data);
            exit;
        }
    }

    /*
     * 常见问题详细
     * */
    public function detailed(){
        $id=I('id');
        $question=D('question')->detailed($id);
        $this->list = $question;
        $this->display();
    }
}