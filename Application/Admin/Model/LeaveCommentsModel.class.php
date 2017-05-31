<?php
/**
 * Created by PhpStorm.
 * User: 小白
 * Date: 2017/5/15
 * Time: 13:51
 */
namespace Admin\Model;
use Think\Model;
class LeaveCommentsModel extends Model{
    //默认
    protected $tableName = 'leave_comments';

    public function index(){
        $where=array();
        $name=I('name');
        $status=I('status',null,0);
        if($name){
            $where['b.name']=array('like','%'.$name.'%');
        }
        if (!is_null($status)AND $status!='') {
            $where['a.status']=$status;
        }else{
            $where['_string']='a.status!=-1';
        }
        $parameter=M($this->tableName)->alias('a')
            ->join('left join member b ON a.member_num=b.m_number')
            ->where($where)
            ->field('*,a.status')
            ->select();
        return $parameter;
    }
    /*详细*/
    public function detailed()
    {
        $id=I('id');
        $parameter=M($this->tableName)->alias('a')
            ->join('left join member b ON a.member_num=b.m_number')
            ->join('left join manager c ON a.reco_id=c.id')
            ->where(array('a.id'=>$id))
            ->field('*,a.status,a.id')
            ->find();
        return $parameter;
    }
    /*回复*/
    public function reply(){
        $id=I('id');
        $parameter=M($this->tableName)->alias('a')
            ->join('left join member b ON a.member_num=b.m_number')
            ->where(array('a.id'=>$id))
            ->field('*,a.status')
            ->find();
        return $parameter;

    }
}

