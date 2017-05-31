<?php
/**
 * Created by PhpStorm.
 * User: 小白
 * Date: 2017/5/15
 * Time: 15:37
 */
namespace Admin\Model;
use Think\Model;
class StudyModel extends Model{
    //默认
    protected $tableName = 'study';
    protected $_auto=array(
        array('create_time','time',1,'function'),
        array('check_time','time',1,'function'),
    );
    /*
     * 课堂列表
     * $status  类型
     * $title   标题
     * */
    public function index(){
//        $where=array();
        $where['_string']='check_status!=-2 AND check_status=1';
        $status=I('study_type');
        $title=I('title');
        if(!is_null($status)AND $status!=''){
            $where['study_type']=$status;
        }
        if($title){
            $where['title']=array('like','%'.$title.'%');
        }
        $parameter=M($this->tableName)->where($where)->select();
        return $parameter;
    }

    /*详细*/
    public function detailed()
    {
//        print_r(session());die;
        $id=I('id');
        $parameter=M($this->tableName)->where(array('id'=>$id))->find();
        return $parameter;
    }
    /*
     * 审核课堂列表
     * $title   标题
     * $check_status    审核状态
     * $publisher_name  作者
     * */
    public function check_index(){
        $check_status=I('check_status');
        $publisher_name=I('publisher_name');
        $title=I('title');
        if(!is_null($check_status)AND $check_status!=''){
            $where['check_status']=$check_status;
        }else{
            $where['_string']='check_status!=-2 AND check_status=0';
        }
        if($title){
            $where['title']=array('like','%'.$title.'%');
        }
        if($publisher_name){
            $where['publisher_name']=array('like','%'.$publisher_name.'%');
        }
        $parameter=M($this->tableName)->where($where)->select();
        return $parameter;
    }

    /*
   * 审核课堂列表状态(审核、删除)
   * $title   标题
   * $check_status    审核状态
   * $publisher_name  作者
   * */
    public function status()
    {
        $id=I('id');
        $status=I('status','',int);
        if($status!=-2){
            $parameter=array(
                'check_status'=>$status,
                'auditing_name'=>session('username'),
                'check_time'=>time(),
            );
        }else{
            $parameter=array(
                'check_status'=>$status,
            );
        }
        $case_item=D('study')-> where('id='.$id)->setField($parameter);
        return $case_item;
    }
}

