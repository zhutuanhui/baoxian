<?php
/**
 * Created by PhpStorm.
 * User: 小白
 * Date: 2017/5/12
 * Time: 16:35
 */
namespace Admin\Model;
use Think\Model;
class TestContModel extends Model
{
    //默认
    protected $tableName = 'test_cont';

    public function index(){
        $parameter=M($this->tableName)->select();
        foreach($parameter as $k=>$v){
            $parameter[$k]['test_answer']=M('test_answer')->where(array('state'=>$v['state'],'test_id'=>$v['id']))->getField('answer_name');
        }

        return $parameter;
    }

    public function questionsEdit()
    {
        $id=I('id');
        $parameter=M($this->tableName)->where(array('id'=>$id))->find();
        $parameter['test_answer']=M('test_answer')->where(array('test_id'=>$id))->select();

        return $parameter;
    }
}