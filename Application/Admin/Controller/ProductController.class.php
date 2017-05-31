<?php
/**
 * Created by PhpStorm.
 * User: 赵浙豫
 * Date: 2017/5/9
 * Time: 14:10
 */
namespace Admin\Controller;
//use Think\Controller;
use Common\Controller\AdminbaseController;
use Common\Controller\UploadImgController;
class ProductController extends AdminbaseController{
    /*
     * 产品列表
     * $product 产品数据库
     * $parameter   产品列表详情
     * $count       产品总数量
     * $where       条件
     * */
    public function index(){
        $product=D('product');
        $parameter=$product->index();
        $count=count($parameter);
        $this->count = $count;
        $this->parameter = $parameter;
        $this->display();
    }

    /*
     * 产品详细
     * $id  产品ID
     * $parameter   详细数据
     * */
    public function detailed(){
        $id=I('id');
        $product=D('product');
        $parameter=$product->details($id);
        $this->list=$parameter;
        $this->display();
    }
    /*
     * 添加产品
     * $supplier    供应商数据
     * $product_type    产品分类
     * $param       添加数据
     * $product_add 产品投保规则数据
     * */
    public function productAdd(){
        if(IS_AJAX){
            $product=D('product');
            $product_rules=D('product_rules');
            $Share= $this->Share();
            $product_add=$product->add($Share['param']);
            $Share['rule']['product_id']=$product_add;
            $product_rules->add($Share['rule']);
            if($product_add){
                $data['status']  = 1;
                $this->ajaxReturn($data);
                exit;
            }else{
                $data['status']  = 0;
                $this->ajaxReturn($data);
                exit;
            }
        }else{
            $supplier=M('supplier')->select();
            $product_type=M('product_type')->select();
            $unsales_category=M('product_unsales_category')->select();
            $this->supplier=$supplier;
            $this->sales=$product_type;
            $this->unsales=$unsales_category;
            $this->display();
        }
    }
    /*
     * 产品编辑
     * $id  产品ID
     * $parameter['detailed']   产品详细
     * $parameter['supplier_select']    供应商详细
     * $parameter['product_type']   产品分类
     * $Share   调用方法
     * */
    public function productEdit(){
        $product=D('product');
        $product_rules=D('product_rules');
        $id=I('id');
        if(IS_AJAX){
           $Share= $this->Share();
            $product_add=$product->where('id='.$id)->save($Share['param']);
            $product_rules->where('product_id='.$id)->save($Share['rule']);
            if($product_add){
                $data['status']  = 1;
                $this->ajaxReturn($data);
                exit;
            }else{
                $data['status']  = 0;
                $this->ajaxReturn($data);
                exit;
            }
        }else{
            $id=I('id');
            $parameter=$product->edit($id);
            $this->list=$parameter['detailed'];
            $this->id=$id;
            $this->supplier=$parameter['supplier_select'];
            $this->product_type_name=$parameter['product_type_name'];
            $this->unsales_type=$parameter['unsales_type'];
            $this->display();
        }
    }
    /*
     * 产品上下架以及删除
     * $id  产品ID
     * $status  产品状态 0=上架 1=下架 -1=删除
     * */
    public function upper_lower_frame(){
        $id=I('id');
        $status=I('status','',int);
        $case_item=D('product')-> where('id='.$id)->setField('status',$status);
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
     * 图片上传
     * */
    function upload(){
        $savePath='Product'; //定义图片上传路径
        $filePath=upload($savePath);
        return $filePath;
    }

    /*
     * 公用参数
     * */
    public function Share(){
        $data = array_filter($_POST);

        if(!$data['product_img']){
            $data['product_img']=I('productImg');
        }else{
            $data['product_img']=I('product_img');
        }

        $param=array(
            'product_title'=>$data['product_title'],
            'product_name'=>$data['product_name'],
            'content'=>$data['content'],
            'details'=>$data['details'],
            'product_label'=>$data['product_label'],
            'supplier_id'=>$data['supplier_id'],
            'fit_member'=>$data['fit_member'],
            'initial_contract_ratio'=>$data['initial_contract_ratio'],
            'product_img'=>$data['product_img'],
            'product_type'=>$data['product_type'],
            'product_state'=>$data['product_state'],
            'type_id'=>$data['type_id'],
            'unsales_category_id'=>$data['unsales_category_id'],
            'amount_insured'=>$data['amount_insured'],
            'initial_price'=>$data['initial_price'],
            'commission_rate'=>$data['commission_rate'],
            'fold_factor'=>$data['fold_factor'],
            'discount_coefficient'=>$data['discount_coefficient'],
            'premium'=>$data['premium'],
            'manager_id'=>session('adminId'),
            'create_time'=>time()
        );
        $rule=array(
            'insurance_tips'=>$data['insurance_tips'],
            'claim_tips'=>$data['claim_tips'],
            'clause_reading'=>$data['clause_reading'],
            'classic_case'=>$data['classic_case'],
            'create_time'=>time()
        );
        return array('param'=>$param,'rule'=>$rule);
    }
}