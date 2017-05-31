<?php
namespace Admin\Controller;

use Common\Controller\AdminbaseController;


class InsuranceExcelController extends AdminbaseController{
	//保单首页展示
	public function index(){


    	//根据查询条件得到相应的数据展现到保单管理页面
    	$options = I('post.');
    	$where = "";
    	if ($options['policy_number']) {
			$where = array('policy_number' => $options['policy_number']); 
    	}
    	//判断
    	if ($options['insured_date1']) {
			$where['_string'] .= '  insured_date >= '.strtotime($options['insured_date1']);
			if ($options['insured_date2']) {
				$where['_string'].= ' AND insured_date<='.strtotime($options['insured_date2']);
			}
		}

    	if ($options['policy_holder_name']) {
			$where[] = array('policy_holder_name' => $options['policy_holder_name']);
    	}
     	if ($options['salesman_name']) {
			$where[] = array('salesman_name' => $options['salesman_name']);
    	}
    	
    	
    	$insurance1=M('insurance');
        $insurance = M('insurance')
            -> where($where)
            -> select();
            //经查询条件 放入缓存中
            S('condition',$where,300);
            
         //将时间戳日期转化为年月日格式
         foreach ($insurance as $k => $value) {

         	$insurance[$k]['hesitation_end_date'] = date("Y-m-d",$value['hesitation_end_date']);
         	$insurance[$k]['surrender_date'] = date("Y-m-d",$value['surrender_date']);
         	$insurance[$k]['hesitate_date'] = date("Y-m-d",$value['hesitate_date']);
         	$insurance[$k]['customer_date'] = date("Y-m-d",$value['customer_date']);
         	$insurance[$k]['return_date'] = date("Y-m-d",$value['return_date']);
         	$insurance[$k]['return_visit_date'] = date("Y-m-d",$value['return_visit_date']);
         	$insurance[$k]['pay_date'] = date("Y-m-d",$value['pay_date']);
         	$insurance[$k]['insured_date'] = date("Y-m-d",$value['insured_date']);
         	$insurance[$k]['insured_date_star'] = date("Y-m-d",$value['insured_date_star']);
         	$insurance[$k]['return_visit_date'] = date("Y-m-d",$value['return_visit_date']);   
         	$insurance[$k]['entry_date'] = date("Y-m-d",$value['entry_date']); 

         	$province = $insurance1->join('district ON insurance.province = district.id')->field('name')->select();
         
			$insurance[$k]['province']=$province[$k]['name'];

			$city = $insurance1->join('district ON insurance.city = district.id')->field('name')->select();
			$insurance[$k]['city']=$city[$k]['name'];
			$town = $insurance1->join('district ON insurance.town = district.id')->field('name')->select();
			$insurance[$k]['town']=$town[$k]['name'];

         }

      
        $this -> assign('insurance',$insurance);
        $this -> display();
		}

	
     //保单导出
     
    public function export(){
        header("Content-Typ:text/html;charset=utf-8");
        vendor('Excel.PHPExcel');
        vendor('Excel.PHPExcel.IOFactory');

        $where = S('condition');
        $district = M('district');

        $parameter = M('insurance')
            -> where($where)
            -> select();

            foreach ($parameter as $k=>$v){

            $province = $district->where(array('id'=>$v['province']))->field('name')->find();
         	$parameter[$k]['province'] = $province['name'];
         	$city = $district->where(array('id'=>$v['city']))->field('name')->find();
         	$parameter[$k]['city'] = $city['name'];
			$town = $district->where(array('id'=>$v['town']))->field('name')->find();
         	$parameter[$k]['town'] = $town['name'];


            $parameter[$k]['policy_status']=$v['policy_status']=1?'有效':'无效';
            $parameter[$k]['insurance_status']=$v['insurance_status']=1?'主险':'附加险';
            $parameter[$k]['payment_method']=$v['payment_method']=1?'支付宝':'微信';
            $parameter[$k]['insured_person_certificate']=$v['insured_person_certificate']=1?'身份证':'护照';
            $parameter[$k]['entry_date']=date('Y-m-d',$v['entry_date']);
            $parameter[$k]['insured_date']=date('Y-m-d',$v['insured_date']);
            $parameter[$k]['insured_date_star']=date('Y-m-d',$v['insured_date_star']);
            $parameter[$k]['customer_date']=date('Y-m-d',$v['customer_date']);
            $parameter[$k]['return_date']=date('Y-m-d',$v['return_date']);
            $parameter[$k]['surrender_date']=date('Y-m-d',$v['surrender_date']);
            $parameter[$k]['hesitate_date']=date('Y-m-d',$v['hesitate_date']);
            $parameter[$k]['pay_date']=date('Y-m-d',$v['pay_date']);
            


        }
        
        $objPHPExcel = new \PHPExcel();
        $objPHPExcel->getActiveSheet()->setCellValue('A1', "分公司");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('B1', "所属标准店");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('C1', "旗舰店");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('D1', "业务员代码");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('E1', "业务员姓名");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('F1', "录入日期");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('G1', "录入人");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('H1', "供应商代码");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('I1', "供应商");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('J1', "投保单号");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('K1', "保单号");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('L1', "保单状态");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('M1', "险种名称");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('N1', "主险/附加险");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('O1', "保险金额");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('P1', "应收保费");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('Q1', "缴费方式");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('R1', "缴费年期");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('S1', "投保人姓名");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('T1', "投保人身份证号");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('U1', "投保人联系地址");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('V1', "投保人电话");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('W1', "被保人姓名");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('X1', "被保人证件类型");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('Y1', "被保人证件号");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('Z1', "被保人电话");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('AA1', "承保日期");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('AB1', "生效日期");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('AC1', "客户签收日期");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('AD1', "回执递交日期");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('AE1', "犹豫期退保日期");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('AF1', "退保日期");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('AG1', "缴费日期");//设置列的值



        $objPHPExcel->getActiveSheet()->getColumnDimension('F')->setWidth(12);
        $objPHPExcel->getActiveSheet()->getColumnDimension('U')->setWidth(22);
        $objPHPExcel->getActiveSheet()->getColumnDimension('AA')->setWidth(12);
        $objPHPExcel->getActiveSheet()->getColumnDimension('AB')->setWidth(12);
        $objPHPExcel->getActiveSheet()->getColumnDimension('AC')->setWidth(12);
        $objPHPExcel->getActiveSheet()->getColumnDimension('AD')->setWidth(12);
        $objPHPExcel->getActiveSheet()->getColumnDimension('AF')->setWidth(12);
        $objPHPExcel->getActiveSheet()->getColumnDimension('AG')->setWidth(12);
        

        if($parameter){
            $i=2;
            foreach ($parameter as $key => $value) {
                $objPHPExcel->setActiveSheetIndex(0)
                    //Excel的第A列，uid是你查出数组的键值，下面以此类推
                    ->setCellValue('A'.$i, $value['branch_shop_number'])
                    ->setCellValue('B'.$i, $value['standard_shop_number'])
                    ->setCellValue('C'.$i, $value['flag_shop_number'])
                    ->setCellValue('D'.$i, $value['salesman_number'])
                    ->setCellValue('E'.$i, $value['salesman_name'])
                    ->setCellValue('F'.$i, $value['entry_date'])
                    ->setCellValue('G'.$i, $value['entry_name'])
                    ->setCellValue('H'.$i, $value['provider_id'])
                    ->setCellValue('I'.$i, $value['provider_name'])
                    ->setCellValue('J'.$i, $value['insured_number'])
                    ->setCellValue('K'.$i, $value['policy_number'])
                    ->setCellValue('L'.$i, $value['policy_status'])
                    ->setCellValue('M'.$i, $value['insurance_name'])
                    ->setCellValue('N'.$i, $value['insurance_status'])
                    ->setCellValue('O'.$i, $value['insurance_money'])
                    ->setCellValue('P'.$i, $value['insurance_premium'])
                    ->setCellValue('Q'.$i, $value['payment_method'])
                    ->setCellValue('R'.$i, $value['salesman_name'])
                    ->setCellValue('S'.$i, $value['policy_holder_name'])
                    ->setCellValue('T'.$i, $value['policy_holder_card'])
                    ->setCellValue('U'.$i, $value['province'].'-'.$value['city'].'-'.$value['town'])//地址
                    ->setCellValue('V'.$i, $value['policy_holder_telephone'])
                    ->setCellValue('W'.$i, $value['insured_person_name']) 
                    ->setCellValue('X'.$i, $value['insured_person_certificate'])
                    ->setCellValue('Y'.$i, $value['insured_person_card'])
                    ->setCellValue('Z'.$i, $value['insured_person_telephone'])
                    ->setCellValue('AA'.$i, $value['insured_date'])
                    ->setCellValue('AB'.$i, $value['insured_date_star'])
                    ->setCellValue('AC'.$i, $value['customer_date'])
                    ->setCellValue('AD'.$i, $value['return_date'])
                    ->setCellValue('AE'.$i, $value['hesitate_date'])
                    ->setCellValue('AF'.$i, $value['surrender_date'])
                    ->setCellValue('AG'.$i, $value['pay_date']);
                $i++;
            }
        }

        $objPHPExcel->getActiveSheet(0)->setTitle('保单报表');
        // $objPHPExcel->setActiveSheetIndex(0);
        header('Content-Type:application/vnd.ms-excel');
        header('Content-Disposition:attachment;filename="Insurance_surface.xls"');
        header('Cache-Control: max-age=0');
        $objWriter = \PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel5');

        $objWriter->save('php://output');
        //清空缓存
        S('condition',null);


    }


	
	

}


?>