<?php
/**
 * Created by PhpStorm.
 * User: 赵浙豫
 * Date: 2017/5/19
 * Time: 11：39
 */
namespace Admin\Controller;
use Common\Controller\AdminbaseController;
class ProductUnsalesController extends AdminbaseController{
    /*
     * 产品非销售分类列表
     * $where 条件 删除的不显示
     * $count   分类总数
     * $parameter   返回产品分类所有信息
     * */
    public function index(){
        $ProductUnsales=D('ProductUnsales');
        $where='state!=-1';
        $parameter=$ProductUnsales->index($where);
        $count=count($parameter);
        $this->count = $count;
        $this->parameter = $parameter;
        $this->display();
    }
    /*
     * 产品非销售分类详细
     * */
    public function detailed(){
        $id=I('id');
        $product_type=D('ProductUnsales');
        $parameter=$product_type->details($id);
        $this->list = $parameter;
        $this->display();
    }
    /*
     * 编辑产品分类
     * $parameter['parameter']  对应的数据
     * $parameter['product_type']   所有分类
     * $cat_name    判断分类是否存在
     * */
    public function typeEdit(){
        $ProductUnsales=D('ProductUnsales');
        $id=I('id');
        if(IS_AJAX){
            $param = array_filter(I('post.'));
            $param['last_update_time']=time();
            $param['manager_id']=session('adminId');
            $product_add=$ProductUnsales->where(array('id'=>$id))->save($param);
            if($product_add){
                $data['status']  = 1;
                $this->ajaxReturn($data);
                exit;
            }else{
                $data['status']  = 0;
                $this->ajaxReturn($data);
                exit;
            }
        }
        $parameter=$ProductUnsales->edit($id);
        $this->id=$id;
        $this->list=$parameter['parameter'];
        $this->product_type=$parameter['product_type'];
        $this->display();
    }
    /*
     * 添加产品分类
     * $parameter   所有分类
     * $cat_name    判断分类是否存在
     * $parameter   查出父级分类
     * */
    public function typeAdd(){
        $ProductUnsales=D('ProductUnsales');
        if(IS_AJAX){
            //回调函数过滤数组中的元素
            $param = array_filter(I('post.'));
            $param['create_time']=time();
            $param['manager_id']=session('adminId');
            $cat_name=$ProductUnsales->where(array('cat_name'=>$param['cat_name']))->find();
            if($cat_name){
                $data['status']  = 2;
                $this->ajaxReturn($data);
                exit;
            }else{
                $product_add=$ProductUnsales->add($param);
                if($product_add){
                    $data['status']  = 1;
                    $this->ajaxReturn($data);
                    exit;
                }else{
                    $data['status']  = 0;
                    $this->ajaxReturn($data);
                    exit;
                }
            }
        }
        $parameter=$ProductUnsales->select();
        $this->list=$parameter;
        $this->display();
    }

    /*
    * 产品分类停用、启用、删除
    * $id  分类ID
    * $status  分类状态 1=正常 0=停用 -1=删除
    * $product_type 销售分类表
    * $product   判断该分类是否在使用
    * $state_type   父分类状态
     * $parent_id   父分类ID
    * */
    public function product_type(){
        $id=I('id');
        $status=I('status','',int);
        $ProductUnsales=D('ProductUnsales');
        $parent_id=$ProductUnsales->where('id='.$id)->getField('parent_id');
        $pa=$ProductUnsales->where('parent_id='.$id)->select();
        foreach($pa as $k=>$v){
            $product1=D('product')->where('unsales_category_id='.$v['id'])->find();
        }
        $where['_string']="unsales_category_id=$id OR unsales_category_id=$parent_id";
        $product=D('product')->where($where)->select();
        if($product OR !is_null($product1)){
            $data['status']  = 1;
            $this->ajaxReturn($data);
            exit;
        }
        //停用父类的时候子类也停用，删除一样
        if($parent_id==0 AND $status==0 OR $status==-1){
            $ProductUnsales->where('id='.$id)->setField('state',$status);
            $ProductUnsales->where('parent_id='.$id)->setField('state',$status);
            $data['status']  = 0;
            $this->ajaxReturn($data);
            exit;
        }else{
            $state_type=$ProductUnsales->where('id='.$parent_id)->getField('state');
            //判断父分类否启用，如果不启用无法启用子分类
            if($state_type OR $state_type===NULL){
                $parameter=$ProductUnsales->where('id='.$id)->setField('state',$status);
                if($parameter AND  $status==0 OR $status==-1){
                    $data['status']  = 2;
                    $this->ajaxReturn($data);
                    exit;
                }else{
                    $data['status']  = 3;
                    $this->ajaxReturn($data);
                    exit;
                }
            }else{
                $data['status']  = 4;
                $this->ajaxReturn($data);
                exit;
            }

        }
    }
}