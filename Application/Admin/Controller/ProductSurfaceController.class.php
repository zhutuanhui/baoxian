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
class ProductSurfaceController extends AdminbaseController{
    /*
     * 产品报表
     * $start_time  开始时间
     * $end_time    结束时间
     * $product_name    产品名称
     * $supplier_id     供应商ID
     * $type_id         类型ID
     * $parameter       产品表表数据
     * $product_type    销售产品分类
     * $supplier        供应商列表
     * $count           产品报表总数量
     * $insales_id      非销售列表分类
     * */
    public function index(){
        $product=D('product');
        $where=array(
            'product_name'=>I('product_name'),
            'supplier_id'=>I('supplier_id'),
            'type_id'=>I('type_id'),
            'start_time'=>I('start_time'),
            'end_time'=>I('end_time'),
            'insales_id'=>I('insales_id'),
        );
        $parameter=$product->report_forms($where);
        $product_type=D('product_type')->select();
        $insales_name=D('product_unsales_category')->select();
        $supplier=D('supplier')->select();
        $count=count($parameter);
        $this->where = $where;
        $this->count = $count;
        $this->type = $product_type;
        $this->insales=$insales_name;
        $this->supplier= $supplier;
        $this->parameter = $parameter;
        $this->display();
    }

    /*
     *报表导出
     * */
    public function export(){
        $product=D('product');
        $product->export();
    }
}