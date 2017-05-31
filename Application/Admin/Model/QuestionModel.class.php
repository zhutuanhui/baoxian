<?php
/**
 * Created by PhpStorm.
 * User: 小白
 * Date: 2017/5/15
 * Time: 9:44
 */
namespace Admin\Model;
use Think\Model;
class QuestionModel extends Model{
    //默认
    protected $tableName = 'question';
    protected $_auto=array(
        array('create_time','time',1,'function'),
    );

    public function edit(){
        $id=I('id');
        $parameter=M($this->tableName)->where(array('id'=>$id))->find();
        return $parameter;
    }
    /*
     *常见问题详细
     * */
    public function detailed()
    {
        $id=I('id');
        $parameter=M($this->tableName)->where(array('id'=>$id))->find();
        return $parameter;
    }
}