<?php
namespace Admin\Controller;

use Common\Controller\AdminbaseController;


class InsuranceReExcelController extends AdminbaseController{
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
        

         $insurance = M('insurance_re');
         $result = $insurance -> join('LEFT JOIN renew  on insurance_re.policy_number = renew.insurance_num')
                              -> where($where)
                              -> order("insurance_re.id desc")
                              -> select();

         foreach ($result as $key => $value) {
            
            $result[$key]['surrender_date'] = date("Y-m-d",$value['surrender_date']);
            $result[$key]['hesitate_date'] = date("Y-m-d",$value['hesitate_date']);
            $result[$key]['customer_date'] = date("Y-m-d",$value['customer_date']);
            
            $result[$key]['insured_date_star'] = date("Y-m-d",$value['insured_date_star']);
            $result[$key]['return_visit_date'] = date("Y-m-d",$value['return_visit_date']);   
            $result[$key]['entry_date'] = date("Y-m-d",$value['entry_date']); 

            $result[$key]['two_time'] = date("Y-m-d",$value['two_time']); 
            $result[$key]['three_time'] = date("Y-m-d",$value['three_time']); 
            $result[$key]['four_time'] = date("Y-m-d",$value['four_time']); 
            $result[$key]['five_time'] = date("Y-m-d",$value['five_time']); 
            
         }
        // dump($province);
        $this -> assign('insurance',$result);
        $this -> display();
        }

	
     //保单导出
     
    public function export(){
        header("Content-Typ:text/html;charset=utf-8");
        vendor('Excel.PHPExcel');
        vendor('Excel.PHPExcel.IOFactory');
        //将查询条件存入缓存
        $where = S('condition');
       //续期保单清单数据$parameter
        $insurance = M('insurance_re');
        $parameter = $insurance -> join('LEFT JOIN renew  on insurance_re.policy_number = renew.insurance_num')
                              -> where($where)
                              -> order("insurance_re.id desc")
                              -> select();
                           

            foreach ($parameter as $k=>$v){


           
            $parameter[$k]['policy_status']=($v['policy_status']==1?'有效':'无效');
            $parameter[$k]['insurance_status']=($v['insurance_status']==1?'主险':'附加险');
            $parameter[$k]['payment_method']=($v['payment_method']==1?'支付宝':'微信');
            $parameter[$k]['insured_person_certificate']=($v['insured_person_certificate']==1?'身份证':'护照');

            $parameter[$k]['entry_date']=date('Y-m-d',$v['entry_date']);
            $parameter[$k]['insured_date']=date('Y-m-d',$v['insured_date']);   
            $parameter[$k]['surrender_date']=date('Y-m-d',$v['surrender_date']);


            $parameter[$k]['two_time'] = date("Y-m-d",$v['two_time']); 
            $parameter[$k]['three_time'] = date("Y-m-d",$v['three_time']); 
            $parameter[$k]['four_time'] = date("Y-m-d",$v['four_time']); 
            $parameter[$k]['five_time'] = date("Y-m-d",$v['five_time']); 
           
            


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
        $objPHPExcel->getActiveSheet()->setCellValue('AB1', "退保日期");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('AC1', "二次成功日期");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('AD1', "二次代理费");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('AE1', "二次是否成功");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('AF1', "三次成功日期");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('AG1', "三次代理费日期");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('AH1', "三次是否成功");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('AI1', "四次成功日期");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('AJ1', "四次代理费日期");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('AK1', "四次是否成功");//
        $objPHPExcel->getActiveSheet()->setCellValue('AL1', "五次成功日期");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('AM1', "五次代理费日期");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('AN1', "五次是否成功");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('AO1', "续期缴费次数");//设置列的值



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
                    ->setCellValue('U'.$i, $value['dress'])
                    ->setCellValue('V'.$i, $value['policy_holder_telephone'])
                    ->setCellValue('W'.$i, $value['insured_person_name']) 
                    ->setCellValue('X'.$i, $value['insured_person_certificate'])
                    ->setCellValue('Y'.$i, $value['insured_person_card'])
                    ->setCellValue('Z'.$i, $value['insured_person_telephone'])
                    ->setCellValue('AA'.$i, $value['insured_date'])
                    ->setCellValue('AB'.$i, $value['surrender_date'])

                    ->setCellValue('AC'.$i, $value['two_time'])
                    ->setCellValue('AD'.$i, $value['two_agency_fee'])
                    ->setCellValue('AE'.$i, $value['two_state'])
                    ->setCellValue('AF'.$i, $value['three_time'])
                    ->setCellValue('AG'.$i, $value['three_agency_fee'])
                    ->setCellValue('AH'.$i, $value['three_state'])
                    ->setCellValue('AI'.$i, $value['four_time'])
                    ->setCellValue('AJ'.$i, $value['four_agency_fee'])
                    ->setCellValue('AK'.$i, $value['four_state'])
                    ->setCellValue('AL'.$i, $value['five_time'])
                    ->setCellValue('AM'.$i, $value['five_agency_fee'])
                    ->setCellValue('AN'.$i, $value['five_state'])
                    ->setCellValue('AO'.$i, $value['renew_count']);
        
                $i++;
            }
        }

        $objPHPExcel->getActiveSheet(0)->setTitle('续期保单报表');



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