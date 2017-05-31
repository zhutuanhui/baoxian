<?php
/**
 * Created by PhpStorm.
 * User: 小白
 * Date: 2017/5/15
 * Time: 13:51
 */
namespace Admin\Model;
use Think\Model;
class MemberModel extends Model{
    //默认
    protected $tableName = 'member';

    public function index(){
        $where=array();   
        $name= I('name');
        if(isset($name)){
            $where['name']=array('like','%'.$name.'%'); 
        }
        $parameter=M($this->tableName)
            ->where($where)
            ->select();
        return $parameter;
    }

    public function indexs(){
        $where=array();   
        $name= I('name');
        $member_level=0;
        if(isset($name)){
            $where['name']=array('like','%'.$name.'%'); 
        }        
            $where['member_level']=$member_level;   
        $parameter=M($this->tableName)
            ->where($where)
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

