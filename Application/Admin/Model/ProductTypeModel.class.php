<?php
/**
 * Created by PhpStorm.
 * User: 赵浙豫
 * Date: 2017/5/9
 * Time: 14:10
 */
namespace Admin\Model;
use Think\Model;
class ProductTypeModel extends Model
{
    //默认
    protected $tableName = 'product_type';

    /*
     * 产品分类列表
     * */
    public function index($where){
        $parameter=M($this->tableName)->where($where)->select();
        foreach($parameter as $k=>$v){
            $parameter[$k]['pname']=M($this->tableName)->where('id='.$v['parent_id'])->getField('cat_name');
        }
        return $parameter;
    }
    /*
     * 产品分类详细
     * */
    public function details(){
        $id=I('id');
        $parameter=M($this->tableName)->where(array('id'=>$id))->find();
        $parameter['manager_name']=M('manager')->where(array('id'=>$parameter['manager_id']))->getField('real_name');
        $parameter['pname']=M($this->tableName)->where('id='.$parameter['parent_id'])->getField('cat_name');
        return $parameter;
    }

    public function edit(){
        $id=I('id');
        $type=M($this->tableName)->select();
        $parameter=M($this->tableName)->where(array('id'=>$id))->find();
        return  array('parameter'=>$parameter,'product_type'=>$type);
    }
}