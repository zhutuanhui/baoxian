<?php
/**
 * Created by PhpStorm.
 * User: 小白
 * Date: 2017/5/18
 * Time: 17:48
 */
namespace Admin\Model;
use Think\Model;
class MemberTestResultModel extends Model{
    protected $tableName = 'member_test_result';

    public function index(){
        $where=array();
        $name=I('name');
        if($name){
            $where['b.name']=array('like','%'.$name.'%');
        }
        $parameter=M($this->tableName)->alias('a')
            ->join('left join member b ON a.member_num=b.m_number')
            ->where($where)
            ->field('*,a.id,a.create_time')
            ->select();
        foreach($parameter as $k=>$v){
            $parameter[$k]['test_result_str']=json_decode($v['test_result_str']);
        }
        return $parameter;
    }
    /*
     * 考试结果详细
     * $parameter['member_name']    管理员名称
     * $parameter['test_result_str']    考试结果json转换
     * */
    public function detailedResults(){
        $id=I('id');
        $parameter=M($this->tableName)->where('id='.$id)->find();
        $parameter['member_name']=M('member')->where('m_number='.$parameter['member_num'])->getField('name');
//        $parameter['test_result_str']=json_decode($parameter['test_result_str']);
//        p($parameter['test_result_str']->code);
        return $parameter;
    }
    /*
     * 生成PDF
     * */
    public function pdf(){
        $id=('id');
        $parameter=M($this->tableName)->where('id='.$id)->find();
        $parameter['member_name']=M('member')->where('m_number='.$parameter['member_num'])->getField('name');
        $parameter['test_result_str']=json_decode($parameter['test_result_str'],true);


        $content='<!doctype html>';
        $content.='<html lang="en">';
        $content.='<head>';
        $content.='<meta charset="UTF-8" />';
        $content.='<title>考试结果</title>';
        $content.='</head>';
        $content.='<body>';
        $content.='<div class="content">';

        $content.='<p align="center" style="color: #0a6ebd;font-size: 24px"><b>考试结果</b></p>';
        $content.=' <div style="color:#6a6a6a;letter-spacing:4px">';
        $content.='<p><span>姓名：';
        $content.=$parameter['member_name'];
        $content.='</span>';
        $content.='<span style="color:#fff;">12312312313';
        $content.='</span>';
      
        $content.='<span style="display:block">考试用时：';
        $content.=$parameter['time_cost'];
        $content.='</span>';
        $content.='<hr/>';
        foreach($parameter['test_result_str'] as $k=>$v){
            $content.='<p style=font-size: 20px><b>';
            $content.=$k+1;
            $content.='、</b>';
            $content.=   $v['problem'];
            $content.='</p>';
            $content.='<p style=" font-size: 14px">您的答案为：<span style="color:#0a6ebd;">';
            $content.=   $v['Answer'];
            $content.='</span></p>';
            $content.='<p style=" font-size: 14px">正确答案为：<span style="color:red;">';
            $content.=   $v['CorrectAnswer'];
            $content.='</span></p>';
        };
        $content.='</div>';
        $content.='</body>';
        $content.='</html>';


        return $content;
    }


}