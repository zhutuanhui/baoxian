<?php
/**
 * Created by PhpStorm.
 * User: 赵浙豫
 * Date: 2017/5/9
 * Time: 14:10
 */
namespace Admin\Model;
use Think\Model;
class ProductModel extends Model
{
    //默认
    protected $tableName = 'product';

    /*
     * 产品列表显示
     * */
    public function index(){
    	$where='a.status!=-1';
//  	协议管理按供应商查看产品
    	/*$id=I('get.id');
    	if($id){
    		$wheres=array('a.supplier_id'=>$id);
    	}*/
        $parameter=M($this->tableName)
            ->alias('a')
            ->where($where)
//            ->where($wheres)
            ->join('left join product_type as b ON a.type_id = b.id')
            ->join('left join product_unsales_category as c ON a.unsales_category_id = c.id')
            ->join('left join supplier as d ON d.sup_id = a.supplier_id')
            ->field('*,a.id,b.cat_name as type_name,c.cat_name as unsales_name')
            ->select();

        //获取投保年龄最大值与最小值
        foreach($parameter as $k=>$v){
            $parameter[$k]['size']=M('product_rate')->where(array('product_id'=>$v['id']))->field('max(age),min(age)')->find();
        }
        return $parameter;
    }
    /*
     * 产品详细
     * $parameter                   产品详细
     * $parameter['size']           关联费率表查看投保年龄最大值与最小值
     * $parameter['supplier']       关联供应商
     * $parameter['product_type']      产品销售分类
     * $parameter['product_unsales']    产品非销售分类
     * $parameter['safeguard']      产品保障
     * $parameter['manager_name']   管理员姓名
     * $parameter['product_rules']  产品投保规则
     * */
    public function details(){
        $id=I('id');
        $parameter=M($this->tableName)->where(array('product.id'=>$id))->find();
        $parameter['size']=M('product_rate')->where(array('product_id'=>$parameter['id']))->field('max(age),min(age)')->find();
        $parameter['supplier']=M('supplier')->where(array('sup_id'=>$parameter['supplier_id']))->find();
        $parameter['type_name']=M('product_type')->where(array('id'=>$parameter['type_id']))->getField('cat_name');
        $parameter['product_unsales']=M('product_unsales_category')->where(array('id'=>$parameter['unsales_category_id']))->getField('cat_name');
        $parameter['safeguard']=M('product_safeguard')->where(array('product_id'=>$parameter['id']))->find();
        $parameter['manager_name']=M('manager')->where(array('id'=>$parameter['manager_id']))->getField('real_name');
        $parameter['product_rules']=M('product_rules')->where(array('product_id'=>$parameter['id']))->find();
        return $parameter;

    }
    /*
     * 产品编辑显示
     *  $parameter   查看对应的产品详细
     *  $supplier   供应商数据
     *  $type      产品销售分类列表
     *  $unsales_category   产品非销售分类列表
     *  $parameter['rules'] 产品投保规则
     * */
    public function edit(){
        $id=I('id');
        $supplier=D('supplier');
        $product_type=D('product_type');
        $unsales_category=D('product_unsales_category');
        $parameter=M($this->tableName)->where(array('id'=>$id))->find();
        $parameter['rules']=M('product_rules')->where(array('product_id'=>$id))->find();
        $supplier=$supplier->select();
        $type=$product_type->select();
        $unsales_category=$unsales_category->select();
        return array('detailed'=>$parameter,'supplier_select'=>$supplier,'product_type_name'=> $type,'unsales_type'=>$unsales_category);
    }
    /*
     * 产品报表列表
     * */
    public function report_forms($post){
        $where['a.status']='0';
        if($post['product_name']){
            $where['product_name']=array('like','%'.$post['product_name'].'%');
        }
        if($post['supplier_id']){
            $where['supplier_id']=$post['supplier_id'];
        }
        if($post['type_id']){
            $where['type_id']=$post['type_id'];
        }
        if($post['insales_id']){
            $where['unsales_category_id']=$post['insales_id'];
        }
        if ($post['start_time']) {
            $where['_string'] .= '  a.create_time>='.strtotime($post['start_time']);
            if ($post['end_time']) {
                $where['_string'].= ' AND a.create_time<='.strtotime($post['end_time']);
            }
        }
        $parameter=M($this->tableName)->alias('a')
            ->where($where)
            ->join('left join product_type as b ON a.type_id = b.id')
            ->join('left join supplier as c ON c.sup_id = a.supplier_id')
            ->join('left join product_unsales_category as d ON d.id=a.unsales_category_id')
            ->field(' a.create_time,a.id,a.premium,a.product_name,a.turnover,b.cat_name,d.cat_name as unsales_name,c.full_name')
            ->select();
        return $parameter;
    }
    /*
     * 产品报表导出
     * */
    public function export(){
        header("Content-Typ:text/html;charset=utf-8");
        vendor('Excel.PHPExcel');
        vendor('Excel.PHPExcel.IOFactory');
        $parameter=M($this->tableName)->alias('a')
            ->join('left join product_type as b ON a.type_id = b.id')
            ->join('left join supplier as c ON c.sup_id = a.supplier_id')
            ->join('left join product_unsales_category as d ON d.id=a.unsales_category_id')
            ->field(' a.create_time,a.id,a.premium,a.product_name,a.turnover,b.cat_name,d.cat_name as unsales_name,c.full_name')
            ->order('a.turnover desc,a.id asc')
            ->select();
        foreach ($parameter as $k=>$v){
            $create_time = $v['create_time'];
            $parameter[$k]['create_time']=date("Y-m-d H:i:s",$create_time);
        }

        $objPHPExcel = new \PHPExcel();
        $objPHPExcel->getActiveSheet()->setCellValue('A1', "产品编号");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('B1', "产品名称");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('C1', "产品销售分类名称");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('D1', "产品非销售分类名称");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('E1', "供应商");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('F1', "保费");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('G1', "销售量");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('H1', "时间");//设置列的值

        $objPHPExcel->getActiveSheet()->getColumnDimension('B')->setWidth(50);
        $objPHPExcel->getActiveSheet()->getColumnDimension('C')->setWidth(22);
        $objPHPExcel->getActiveSheet()->getColumnDimension('D')->setWidth(22);
        $objPHPExcel->getActiveSheet()->getColumnDimension('E')->setWidth(22);
        $objPHPExcel->getActiveSheet()->getColumnDimension('F')->setWidth(15);
        $objPHPExcel->getActiveSheet()->getColumnDimension('H')->setWidth(20);
        if($parameter){
            $i=2;
            foreach ($parameter as $key => $value) {
                $objPHPExcel->setActiveSheetIndex(0)
                    //Excel的第A列，uid是你查出数组的键值，下面以此类推
                    ->setCellValue('A'.$i, $value['id'])
                    ->setCellValue('B'.$i, $value['product_name'])
                    ->setCellValue('C'.$i, $value['cat_name'])
                    ->setCellValue('D'.$i, $value['unsales_name'])
                    ->setCellValue('E'.$i, $value['full_name'])
                    ->setCellValue('F'.$i, $value['premium'])
                    ->setCellValue('G'.$i, $value['turnover'])
                    ->setCellValue('H'.$i, $value['create_time']);
                $i++;
            }
        }
        $objPHPExcel->getActiveSheet(0)->setTitle('产品报表');
        // $objPHPExcel->setActiveSheetIndex(0);
        header('Content-Type:application/vnd.ms-excel');
        header('Content-Disposition:attachment;filename="product_surface.xls"');
        header('Cache-Control: max-age=0');
        $objWriter = \PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel5');
        $objWriter->save('php://output');
    }
}