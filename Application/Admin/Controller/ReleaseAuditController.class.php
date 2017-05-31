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
class ReleaseAuditController extends AdminbaseController{
    /*
     * 学习课堂
     * $parameter   所有信息
     * count        总数
     * $status      类型
     * $title       标题
     * */
    public function index(){
        $study=D('study');
        $status=I('study_type');
        $title=I('title');
        $parameter=$study->index($status,$title);
        $this->status=$status;
        $this->title=$title;
        $this->count=count($parameter);
        $this->list=$parameter;
        $this->display();
    }
    /*
     * 详细
     * */
    public function detailed(){
        $id=I('id');
        $study=D('study');
        $parameter=$study->detailed($id);
        $this->list=$parameter;
        $this->display();
    }
    /*
     * 上传课堂
     * */
    public function studyAdd(){
        $study=D('study');
        if(IS_AJAX){
            //判断session是否有数据(后台)
            if(!is_null(session('adminId')) AND !is_null(session('username'))){
                $_POST['publisher_id']=session('adminId');
                $_POST['publisher_name']=session('username');
                $_POST['publish_type']='1';
            }else{
                $_POST['publisher_id']=session('memberId');
                $_POST['publisher_name']=session('membername');
                $_POST['publish_type']='2';
            }
            $_POST['check_status']='1';
            $_POST['auditing_name']=session('username');
            //获取文件路径
            $savePath='UploadFile'; //定义图片上传路径
            $_POST['file_path']=upload_file($savePath);
            if($study->create($_POST)) {
                $result = $study->add();
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
     * 编辑学习课堂
     * */
    public function studyEdit(){
        $study=D('study');
        $id=I('id');
        if(IS_AJAX){
            $param = array_filter(I('post.'));
            $param['publisher_id']=session('adminId');
            $param['publisher_name']=session('username');
            $param['publish_type']='1';
            $param['last_update_time']=time();
            $savePath='StudyFile'; //定义图片上传路径
            $_POST['file_path']=upload_file($savePath);
            $return=$study->where(array('id'=>$id))->save($param);
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
        $parameter=$study->where(array('id'=>$id))->find();
        $this->list=$parameter;
        $this->id=$id;
        $this->display();
    }
    /*
     * 删除课堂
     * */
    public function delete_study(){
        $id=I('id');
        $status=I('status','',int);
        $case_item=D('study')-> where('id='.$id)->setField('check_status',$status);
        if($case_item AND $status==-2){
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