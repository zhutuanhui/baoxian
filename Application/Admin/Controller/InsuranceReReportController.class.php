<?php
namespace Admin\Controller;

use Common\Controller\AdminbaseController;


class InsuranceReReportController extends AdminbaseController{
	//保单首页展示
	public function index(){


        //根据查询条件得到相应的数据展现到保单管理页面
        $where = "";

        //获取前一年零两个月的月初日期时间戳和一年前的月末日期时间戳

        $thismonth = date('m');
        $thisyear = date('Y');



        if ($thismonth == 1) {
             $starmonth = 11;
             $staryear = $thisyear - 2;
        }else if($thismonth == 2){
             $starmonth = 12;
             $staryear = $thisyear - 2;
        }else{
             $starmonth = $thismonth - 2;
             $staryear = $thisyear - 1;
        }


        $startDay = $staryear . '-' . $starmonth . '-1';//前两个月的当月月初时间
        $startime = strtotime($startDay); //一年零两个月前月初时间戳

        $endThisMonth = mktime(23,59,59,date('m'),date('t'),date('Y') - 1);//一年前当月月末时间戳

     
        
        //查询判断
        
        $where['_string'] = '  insured_date >= '.$startime;

        
        $where['_string'].= ' AND insured_date<='.$endThisMonth;
   
         $insurance = M('insurance_re');
         $result = $insurance -> join('LEFT JOIN renew  on insurance_re.policy_number = renew.insurance_num')
                              -> where($where)
                              -> order("insurance_re.id desc")
                              -> select();


         foreach ($result as $key => $value) {
            
            $result[$key]['surrender_date'] = date("Y-m-d",$value['surrender_date']);//退保日期
            $result[$key]['insured_date'] = date("Y-m-d",$value['insured_date']);//承包日期
            
        
            
            
            $result[$key]['entry_date'] = date("Y-m-d",$value['entry_date']); 

            $result[$key]['two_time'] = date("Y-m-d",$value['two_time']); 
            $result[$key]['three_time'] = date("Y-m-d",$value['three_time']); 
            $result[$key]['four_time'] = date("Y-m-d",$value['four_time']); 
            $result[$key]['five_time'] = date("Y-m-d",$value['five_time']); 
            
         }
        $this -> assign('insurance',$result);
        $this -> display();
        }

	
     //续期保单导出
 public function export(){

		header("Content-Typ:text/html;charset=utf-8");
		vendor('Excel.PHPExcel');
		vendor('Excel.PHPExcel.IOFactory');
//		Vendor('PHPExcel.PHPExcel.Reader.Excel2007');
		$objPHPExcel = new \PHPExcel();
//		个人
		$arr=$this->getContinuation('salesman_number');
		$objPHPExcel->getActiveSheet(0)->setCellValue('A1', '个人继续率清单');
		
		//合并单元格  
    	$objPHPExcel->getActiveSheet(0)->mergeCells('A1:W1');
		$objPHPExcel->getActiveSheet(0)->mergeCells('A2:A3'); 
		$objPHPExcel->getActiveSheet(0)->mergeCells('B2:B3');   
		$objPHPExcel->getActiveSheet(0)->mergeCells('C2:C3'); 
		$objPHPExcel->getActiveSheet(0)->mergeCells('D2:D3'); 
		$objPHPExcel->getActiveSheet(0)->mergeCells('E2:E3');
		$objPHPExcel->getActiveSheet(0)->mergeCells('F2:N2');
		$objPHPExcel->getActiveSheet(0)->mergeCells('O2:W2');
	//设置居中  
    $objPHPExcel->getActiveSheet(0)->getStyle('A1:W1')->getAlignment()->setHorizontal(\PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
	$objPHPExcel->getActiveSheet(0)->getStyle('F2:N2')->getAlignment()->setHorizontal(\PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
	$objPHPExcel->getActiveSheet(0)->getStyle('O2:W2')->getAlignment()->setHorizontal(\PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
	//字体加粗  
    $objPHPExcel->getActiveSheet(0)->getStyle('A1')->getFont()->setName('宋体') //字体  
    ->setBold(true); //字体加粗
    $objPHPExcel->getActiveSheet(0)->getStyle('F2')->getFont()->setName('宋体') //字体  
    ->setBold(true); //字体加粗  
    $objPHPExcel->getActiveSheet(0)->getStyle('O2')->getFont()->setName('宋体') //字体  
    ->setBold(true); //字体加粗 
        $objPHPExcel ->setActiveSheetIndex(0)
       				 ->setCellValue('A2', "分公司")//设置列的值
                     ->setCellValue('B2', "旗舰店")//设置列的值
                     ->setCellValue('C2', "标准店")//设置列的值
                     ->setCellValue('D2', "业务员代码")//设置列的值
                     ->setCellValue('E2', "业务员姓名")//设置列的值
                     ->setCellValue('F2', "13个月单月继续率")//设置列的值
                     ->setCellValue('O2', "13个月累计继续率")//设置列的值
                     ->setCellValue('F3', "当月实收")//设置列的值
                     ->setCellValue('G3', "当月应收")//设置列的值
                     ->setCellValue('H3', "继续率")//设置列的值
                     ->setCellValue('I3', "宽一实收")//设置列的值*/
                     ->setCellValue('J3', "宽一应收")//设置列的值*/
                     ->setCellValue('K3', "继续率")//设置列的值*/
                     ->setCellValue('L3', "宽末实收")//设置列的值*/
                     ->setCellValue('M3', "宽末应收")//设置列的值*/
                     ->setCellValue('N3', "宽末继续率")//设置列的值*/
                     ->setCellValue('O3', "当月实收")//设置列的值
                     ->setCellValue('P3', "当月应收")//设置列的值
                     ->setCellValue('Q3', "继续率")//设置列的值
                     ->setCellValue('R3', "宽一实收")//设置列的值*/
                     ->setCellValue('S3', "宽一应收")//设置列的值*/
                     ->setCellValue('T3', "继续率")//设置列的值*/
                     ->setCellValue('U3', "宽末实收")//设置列的值*/
                     ->setCellValue('V3', "宽末应收")//设置列的值*/
                     ->setCellValue('W3', "宽末继续率");//设置列的值*/
        $objPHPExcel->getActiveSheet(0)->getColumnDimension('A')->setWidth(15);
        $objPHPExcel->getActiveSheet(0)->getColumnDimension('B')->setWidth(10);
        $objPHPExcel->getActiveSheet(0)->getColumnDimension('C')->setWidth(12);
        $objPHPExcel->getActiveSheet(0)->getColumnDimension('D')->setWidth(12);
        $objPHPExcel->getActiveSheet(0)->getColumnDimension('E')->setWidth(12);
        $objPHPExcel->getActiveSheet(0)->getColumnDimension('F')->setWidth(12);
        $objPHPExcel->getActiveSheet(0)->getColumnDimension('G')->setWidth(10);
        $objPHPExcel->getActiveSheet(0)->getColumnDimension('H')->setWidth(12);
        $objPHPExcel->getActiveSheet(0)->getColumnDimension('I')->setWidth(12);
        $objPHPExcel->getActiveSheet(0)->getColumnDimension('J')->setWidth(12);
        $objPHPExcel->getActiveSheet(0)->getColumnDimension('K')->setWidth(12);
		$objPHPExcel->getActiveSheet(0)->getColumnDimension('L')->setWidth(12);
		$objPHPExcel->getActiveSheet(0)->getColumnDimension('M')->setWidth(12);
		$objPHPExcel->getActiveSheet(0)->getColumnDimension('N')->setWidth(12);
		$objPHPExcel->getActiveSheet(0)->getColumnDimension('O')->setWidth(12);
		$objPHPExcel->getActiveSheet(0)->getColumnDimension('P')->setWidth(12);
		$objPHPExcel->getActiveSheet(0)->getColumnDimension('Q')->setWidth(12);
		$objPHPExcel->getActiveSheet(0)->getColumnDimension('R')->setWidth(12);
		$objPHPExcel->getActiveSheet(0)->getColumnDimension('S')->setWidth(12);
		$objPHPExcel->getActiveSheet(0)->getColumnDimension('T')->setWidth(12);
		$objPHPExcel->getActiveSheet(0)->getColumnDimension('U')->setWidth(12);   
        $a=4;
                foreach ($arr as $key => $value) {
           				 $objPHPExcel->setActiveSheetIndex()
                        ->setCellValue('A'.$a, $value['branch_shop_number'])
                        ->setCellValue('B'.$a, $value['flag_shop_number'])
                        ->setCellValue('C'.$a, $value['standard_shop_number'])
                        ->setCellValue('D'.$a, $value['salesman_number'])
                        ->setCellValue('E'.$a, $value['salesman_name'])
                        ->setCellValue('F'.$a, $value['fact'])//当月实收
                        ->setCellValue('G'.$a, $value['should'])//当月应收
                        ->setCellValue('H'.$a, $value['fact']/$value['should']?round($value['fact']/$value['should'],2)*100 .'%':'')//实收继续率
                        ->setCellValue('I'.$a, $value['fact1'])//宽一实收
                        ->setCellValue('J'.$a, $value['should1'])//宽一应收
                        ->setCellValue('K'.$a, $value['fact1']/$value['should1']?round($value['fact1']/$value['should1'],2)*100 .'%':'')//宽一继续率
                        ->setCellValue('L'.$a, $value['fact2'])//宽末实收
                        ->setCellValue('M'.$a, $value['should2'])//宽末应收
                        ->setCellValue('N'.$a, $value['fact2']/$value['should2']?round($value['fact2']/$value['should2'],2)*100 .'%':'')//宽末继续率
                        ->setCellValue('O'.$a, $value['facts'])
						->setCellValue('P'.$a, $value['shoulds'])
						->setCellValue('Q'.$a, $value['facts']/$value['shoulds']?round($value['facts']/$value['shoulds'],2)*100 .'%':'')//累计实收继续率
						->setCellValue('R'.$a, $value['facts1'])
						->setCellValue('S'.$a, $value['shoulds1'])
						->setCellValue('T'.$a, $value['facts1']/$value['shoulds1'] ?round($value['facts1']/$value['shoulds1'],2)*100 .'%' :'')
						->setCellValue('U'.$a, $value['facts2'])
						->setCellValue('V'.$a, $value['shoulds2'])
						->setCellValue('W'.$a, $value['facts2']/$value['shoulds2'] ? round($value['facts2']/$value['shoulds2'],2)*100 .'%' :'');
            $a++;
        }
        $objPHPExcel->getActiveSheet(0)->setTitle('个人');
//		------------------------------------标准店
	    $objPHPExcel ->createSheet(1);
        $objPHPExcel->setActiveSheetIndex(1);
//		//合并单元格  
    	$objPHPExcel->getActiveSheet(1)->mergeCells('A1:U1');
		$objPHPExcel->getActiveSheet(1)->mergeCells('A2:A3'); 
		$objPHPExcel->getActiveSheet(1)->mergeCells('B2:B3');   
		$objPHPExcel->getActiveSheet(1)->mergeCells('C2:C3'); 
		$objPHPExcel->getActiveSheet(1)->mergeCells('D2:L2');
		$objPHPExcel->getActiveSheet(1)->mergeCells('M2:U2');
	//设置居中  
    $objPHPExcel->getActiveSheet(1)->getStyle('A1:U1')->getAlignment()->setHorizontal(\PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
	$objPHPExcel->getActiveSheet(1)->getStyle('D2:L2')->getAlignment()->setHorizontal(\PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
	$objPHPExcel->getActiveSheet(1)->getStyle('M2:U2')->getAlignment()->setHorizontal(\PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
	//字体加粗  
    $objPHPExcel->getActiveSheet(1)->getStyle('A1')->getFont()->setName('宋体') //字体  
    ->setBold(true); //字体加粗
    $objPHPExcel->getActiveSheet(1)->getStyle('D2')->getFont()->setName('宋体') //字体  
    ->setBold(true); //字体加粗  
    $objPHPExcel->getActiveSheet(1)->getStyle('M2')->getFont()->setName('宋体') //字体  
    ->setBold(true); //字体加粗 
        $objPHPExcel ->setActiveSheetIndex(1)
					 ->setCellValue('A1', '部门继续率清单')
       				 ->setCellValue('A2', "分公司")//设置列的值
                     ->setCellValue('B2', "旗舰店")//设置列的值
                     ->setCellValue('C2', "标准店")//设置列的值
                     ->setCellValue('D2', "13个月单月继续率")//设置列的值
                     ->setCellValue('M2', "13个月累计继续率")//设置列的值
                     ->setCellValue('D3', "当月实收")//设置列的值
                     ->setCellValue('E3', "当月应收")//设置列的值
                     ->setCellValue('F3', "继续率")//设置列的值
                     ->setCellValue('G3', "宽一实收")//设置列的值*/
                     ->setCellValue('H3', "宽一应收")//设置列的值*/
                     ->setCellValue('I3', "继续率")//设置列的值*/
                     ->setCellValue('J3', "宽末实收")//设置列的值*/
                     ->setCellValue('K3', "宽末应收")//设置列的值*/
                     ->setCellValue('L3', "宽末继续率")//设置列的值*/
                     ->setCellValue('M3', "当月实收")//设置列的值
                     ->setCellValue('N3', "当月应收")//设置列的值
                     ->setCellValue('O3', "继续率")//设置列的值
                     ->setCellValue('P3', "宽一实收")//设置列的值*/
                     ->setCellValue('Q3', "宽一应收")//设置列的值*/
                     ->setCellValue('R3', "继续率")//设置列的值*/
                     ->setCellValue('S3', "宽末实收")//设置列的值*/
                     ->setCellValue('T3', "宽末应收")//设置列的值*/
                     ->setCellValue('U3', "宽末继续率");//设置列的值*/
        $objPHPExcel->getActiveSheet(1)->getColumnDimension('A')->setWidth(15);
        $objPHPExcel->getActiveSheet(1)->getColumnDimension('B')->setWidth(10);
        $objPHPExcel->getActiveSheet(1)->getColumnDimension('C')->setWidth(12);
        $objPHPExcel->getActiveSheet(1)->getColumnDimension('D')->setWidth(12);
        $objPHPExcel->getActiveSheet(1)->getColumnDimension('E')->setWidth(12);
        $objPHPExcel->getActiveSheet(1)->getColumnDimension('F')->setWidth(12);
        $objPHPExcel->getActiveSheet(1)->getColumnDimension('G')->setWidth(10);
        $objPHPExcel->getActiveSheet(1)->getColumnDimension('H')->setWidth(12);
        $objPHPExcel->getActiveSheet(1)->getColumnDimension('I')->setWidth(12);
        $objPHPExcel->getActiveSheet(1)->getColumnDimension('J')->setWidth(12);
        $objPHPExcel->getActiveSheet(1)->getColumnDimension('K')->setWidth(12);
		$objPHPExcel->getActiveSheet(1)->getColumnDimension('L')->setWidth(12);
		$objPHPExcel->getActiveSheet(1)->getColumnDimension('M')->setWidth(12);
		$objPHPExcel->getActiveSheet(1)->getColumnDimension('N')->setWidth(12);
		$objPHPExcel->getActiveSheet(1)->getColumnDimension('O')->setWidth(12);
		$objPHPExcel->getActiveSheet(1)->getColumnDimension('P')->setWidth(12);
		$objPHPExcel->getActiveSheet(1)->getColumnDimension('Q')->setWidth(12);
		$objPHPExcel->getActiveSheet(1)->getColumnDimension('R')->setWidth(12);
		$objPHPExcel->getActiveSheet(1)->getColumnDimension('S')->setWidth(12);
		$objPHPExcel->getActiveSheet(1)->getColumnDimension('T')->setWidth(12);
		$objPHPExcel->getActiveSheet(1)->getColumnDimension('U')->setWidth(12);
		$arr1=$this->getContinuation('standard_shop_number');   
        $a=4;
                foreach ($arr1 as $key => $value) {
           				 $objPHPExcel->setActiveSheetIndex(1)
                        ->setCellValue('A'.$a, $value['branch_shop_number'])
                        ->setCellValue('B'.$a, $value['flag_shop_number'])
                        ->setCellValue('C'.$a, $value['standard_shop_number'])
                        ->setCellValue('D'.$a, $value['fact'])//当月实收
                        ->setCellValue('E'.$a, $value['should'])//当月应收
                        ->setCellValue('F'.$a, $value['fact']/$value['should']?round($value['fact']/$value['should'],2)*100 .'%':'')//实收继续率
                        ->setCellValue('G'.$a, $value['fact1'])//宽一实收
                        ->setCellValue('H'.$a, $value['should1'])//宽一应收
                        ->setCellValue('I'.$a, $value['fact1']/$value['should1']?round($value['fact1']/$value['should1'],2)*100 .'%':'')//宽一继续率
                        ->setCellValue('J'.$a, $value['fact2'])//宽末实收
                        ->setCellValue('K'.$a, $value['should2'])//宽末应收
                        ->setCellValue('L'.$a, $value['fact2']/$value['should2']?round($value['fact2']/$value['should2'],2)*100 .'%':'')//宽末继续率
                        ->setCellValue('M'.$a, $value['facts'])
						->setCellValue('N'.$a, $value['shoulds'])
						->setCellValue('O'.$a, $value['facts']/$value['shoulds']?round($value['facts']/$value['shoulds'],2)*100 .'%':'')//累计实收继续率
						->setCellValue('P'.$a, $value['facts1'])
						->setCellValue('Q'.$a, $value['shoulds1'])
						->setCellValue('R'.$a, $value['facts1']/$value['shoulds1'] ?round($value['facts1']/$value['shoulds1'],2)*100 .'%' :'')
						->setCellValue('S'.$a, $value['facts2'])
						->setCellValue('T'.$a, $value['shoulds2'])
						->setCellValue('W'.$a, $value['facts2']/$value['shoulds2'] ? round($value['facts2']/$value['shoulds2'],2)*100 .'%' :'');
            $a++;
        }
		$objPHPExcel->getActiveSheet(1)->setTitle('部门');
////		-------------------------------------旗舰店
		$objPHPExcel ->createSheet(2);
        $objPHPExcel->setActiveSheetIndex(2);
//		//合并单元格  
    	$objPHPExcel->getActiveSheet(2)->mergeCells('A1:T1');
		$objPHPExcel->getActiveSheet(2)->mergeCells('A2:A3'); 
		$objPHPExcel->getActiveSheet(2)->mergeCells('B2:B3'); 
		$objPHPExcel->getActiveSheet(2)->mergeCells('C2:K2');
		$objPHPExcel->getActiveSheet(2)->mergeCells('L2:T2');
	//设置居中  
    $objPHPExcel->getActiveSheet(2)->getStyle('A1:T1')->getAlignment()->setHorizontal(\PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
	$objPHPExcel->getActiveSheet(2)->getStyle('C2:K2')->getAlignment()->setHorizontal(\PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
	$objPHPExcel->getActiveSheet(2)->getStyle('L2:T2')->getAlignment()->setHorizontal(\PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
	//字体加粗  
    $objPHPExcel->getActiveSheet(2)->getStyle('A1')->getFont()->setName('宋体') //字体  
    ->setBold(true); //字体加粗
    $objPHPExcel->getActiveSheet(2)->getStyle('C2')->getFont()->setName('宋体') //字体  
    ->setBold(true); //字体加粗  
    $objPHPExcel->getActiveSheet(2)->getStyle('L2')->getFont()->setName('宋体') //字体  
    ->setBold(true); //字体加粗 
        $objPHPExcel ->setActiveSheetIndex(2)
					 ->setCellValue('A1', '分区继续率清单')
       				 ->setCellValue('A2', "分公司")//设置列的值
                     ->setCellValue('B2', "旗舰店")//设置列的值
                     ->setCellValue('C2', "13个月单月继续率")//设置列的值
                     ->setCellValue('L2', "13个月累计继续率")//设置列的值
                     ->setCellValue('C3', "当月实收")//设置列的值
                     ->setCellValue('D3', "当月应收")//设置列的值
                     ->setCellValue('E3', "继续率")//设置列的值
                     ->setCellValue('F3', "宽一实收")//设置列的值*/
                     ->setCellValue('G3', "宽一应收")//设置列的值*/
                     ->setCellValue('H3', "继续率")//设置列的值*/
                     ->setCellValue('I3', "宽末实收")//设置列的值*/
                     ->setCellValue('J3', "宽末应收")//设置列的值*/
                     ->setCellValue('K3', "宽末继续率")//设置列的值*/
                     ->setCellValue('L3', "当月实收")//设置列的值
                     ->setCellValue('M3', "当月应收")//设置列的值
                     ->setCellValue('N3', "继续率")//设置列的值
                     ->setCellValue('O3', "宽一实收")//设置列的值*/
                     ->setCellValue('P3', "宽一应收")//设置列的值*/
                     ->setCellValue('Q3', "继续率")//设置列的值*/
                     ->setCellValue('R3', "宽末实收")//设置列的值*/
                     ->setCellValue('S3', "宽末应收")//设置列的值*/
                     ->setCellValue('T3', "宽末继续率");//设置列的值*/
        $objPHPExcel->getActiveSheet(2)->getColumnDimension('A')->setWidth(15);
        $objPHPExcel->getActiveSheet(2)->getColumnDimension('B')->setWidth(10);
        $objPHPExcel->getActiveSheet(2)->getColumnDimension('C')->setWidth(12);
        $objPHPExcel->getActiveSheet(2)->getColumnDimension('D')->setWidth(12);
        $objPHPExcel->getActiveSheet(2)->getColumnDimension('E')->setWidth(12);
        $objPHPExcel->getActiveSheet(2)->getColumnDimension('F')->setWidth(12);
        $objPHPExcel->getActiveSheet(2)->getColumnDimension('G')->setWidth(10);
        $objPHPExcel->getActiveSheet(2)->getColumnDimension('H')->setWidth(12);
        $objPHPExcel->getActiveSheet(2)->getColumnDimension('I')->setWidth(12);
        $objPHPExcel->getActiveSheet(2)->getColumnDimension('J')->setWidth(12);
        $objPHPExcel->getActiveSheet(2)->getColumnDimension('K')->setWidth(12);
		$objPHPExcel->getActiveSheet(2)->getColumnDimension('L')->setWidth(12);
		$objPHPExcel->getActiveSheet(2)->getColumnDimension('M')->setWidth(12);
		$objPHPExcel->getActiveSheet(2)->getColumnDimension('N')->setWidth(12);
		$objPHPExcel->getActiveSheet(2)->getColumnDimension('O')->setWidth(12);
		$objPHPExcel->getActiveSheet(2)->getColumnDimension('P')->setWidth(12);
		$objPHPExcel->getActiveSheet(2)->getColumnDimension('Q')->setWidth(12);
		$objPHPExcel->getActiveSheet(2)->getColumnDimension('R')->setWidth(12);
		$objPHPExcel->getActiveSheet(2)->getColumnDimension('S')->setWidth(12);
		$objPHPExcel->getActiveSheet(2)->getColumnDimension('T')->setWidth(12);
		$arr2=$this->getContinuation('flag_shop_number');   
        $a=4;
                foreach ($arr2 as $key => $value) {
           				 $objPHPExcel->setActiveSheetIndex(2)
                        ->setCellValue('A'.$a, $value['branch_shop_number'])
                        ->setCellValue('B'.$a, $value['flag_shop_number'])
                        ->setCellValue('C'.$a, $value['fact'])//当月实收
                        ->setCellValue('D'.$a, $value['should'])//当月应收
                        ->setCellValue('E'.$a, $value['fact']/$value['should']?round($value['fact']/$value['should'],2)*100 .'%':'')//实收继续率
                        ->setCellValue('F'.$a, $value['fact1'])//宽一实收
                        ->setCellValue('G'.$a, $value['should1'])//宽一应收
                        ->setCellValue('H'.$a, $value['fact1']/$value['should1']?round($value['fact1']/$value['should1'],2)*100 .'%':'')//宽一继续率
                        ->setCellValue('I'.$a, $value['fact2'])//宽末实收
                        ->setCellValue('G'.$a, $value['should2'])//宽末应收
                        ->setCellValue('K'.$a, $value['fact2']/$value['should2']?round($value['fact2']/$value['should2'],2)*100 .'%':'')//宽末继续率
                        ->setCellValue('L'.$a, $value['facts'])
						->setCellValue('M'.$a, $value['shoulds'])
						->setCellValue('N'.$a, $value['facts']/$value['shoulds']?round($value['facts']/$value['shoulds'],2)*100 .'%':'')//累计实收继续率
						->setCellValue('O'.$a, $value['facts1'])
						->setCellValue('P'.$a, $value['shoulds1'])
						->setCellValue('Q'.$a, $value['facts1']/$value['shoulds1'] ?round($value['facts1']/$value['shoulds1'],2)*100 .'%' :'')
						->setCellValue('R'.$a, $value['facts2'])
						->setCellValue('S'.$a, $value['shoulds2'])
						->setCellValue('T'.$a, $value['facts2']/$value['shoulds2'] ? round($value['facts2']/$value['shoulds2'],2)*100 .'%' :'');
            $a++;
        }
        $objPHPExcel->getActiveSheet(2)->setTitle('分区');
////		-----------------------------------分公司
		$objPHPExcel ->createSheet(3);
        $objPHPExcel->setActiveSheetIndex(3);
//		//合并单元格  
    	$objPHPExcel->getActiveSheet(3)->mergeCells('A1:AL1');
		$objPHPExcel->getActiveSheet(3)->mergeCells('A2:A3'); 
		$objPHPExcel->getActiveSheet(3)->mergeCells('B2:B3'); 
		$objPHPExcel->getActiveSheet(3)->mergeCells('C2:K2');
		$objPHPExcel->getActiveSheet(3)->mergeCells('L2:T2');
		$objPHPExcel->getActiveSheet(3)->mergeCells('U2:AC2');
		$objPHPExcel->getActiveSheet(3)->mergeCells('AD2:AL2');
	//设置居中  
    $objPHPExcel->getActiveSheet(3)->getStyle('A1:AL1')->getAlignment()->setHorizontal(\PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
	$objPHPExcel->getActiveSheet(3)->getStyle('C2:K2')->getAlignment()->setHorizontal(\PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
	$objPHPExcel->getActiveSheet(3)->getStyle('L2:T2')->getAlignment()->setHorizontal(\PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
	$objPHPExcel->getActiveSheet(3)->getStyle('U2:AC2')->getAlignment()->setHorizontal(\PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
	$objPHPExcel->getActiveSheet(3)->getStyle('AD2:AL2')->getAlignment()->setHorizontal(\PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
	//字体加粗  
    $objPHPExcel->getActiveSheet(3)->getStyle('A1')->getFont()->setName('宋体') //字体  
    ->setBold(true); //字体加粗
    $objPHPExcel->getActiveSheet(3)->getStyle('C2')->getFont()->setName('宋体') //字体  
    ->setBold(true); //字体加粗  
    $objPHPExcel->getActiveSheet(3)->getStyle('L2')->getFont()->setName('宋体') //字体  
    ->setBold(true); //字体加粗 
    $objPHPExcel->getActiveSheet(3)->getStyle('U2')->getFont()->setName('宋体') //字体  
    ->setBold(true);
	$objPHPExcel->getActiveSheet(3)->getStyle('AD2')->getFont()->setName('宋体') //字体  
    ->setBold(true);
        $objPHPExcel ->setActiveSheetIndex(3)
					 ->setCellValue('A1', '供应商继续率清单')
       				 ->setCellValue('A2', "分公司")//设置列的值
                     ->setCellValue('B2', "供应商")//设置列的值
                     ->setCellValue('C2', "13个月单月继续率")//设置列的值
                     ->setCellValue('L2', "13个月累计继续率")//设置列的值
                     ->setCellValue('U2', "25个月单月继续率")//设置列的值
                     ->setCellValue('AD2',"25个月累计继续率")//设置列的值
                     ->setCellValue('C3', "当月实收")//设置列的值
                     ->setCellValue('D3', "当月应收")//设置列的值
                     ->setCellValue('E3', "继续率")//设置列的值
                     ->setCellValue('F3', "宽一实收")//设置列的值*/
                     ->setCellValue('G3', "宽一应收")//设置列的值*/
                     ->setCellValue('H3', "继续率")//设置列的值*/
                     ->setCellValue('I3', "宽末实收")//设置列的值*/
                     ->setCellValue('J3', "宽末应收")//设置列的值*/
                     ->setCellValue('K3', "宽末继续率")//设置列的值*/
                     ->setCellValue('L3', "当月实收")//设置列的值
                     ->setCellValue('M3', "当月应收")//设置列的值
                     ->setCellValue('N3', "继续率")//设置列的值
                     ->setCellValue('O3', "宽一实收")//设置列的值*/
                     ->setCellValue('P3', "宽一应收")//设置列的值*/
                     ->setCellValue('Q3', "继续率")//设置列的值*/
                     ->setCellValue('R3', "宽末实收")//设置列的值*/
                     ->setCellValue('S3', "宽末实收")//设置列的值*/
                     ->setCellValue('T3', "继续率")//设置列的值*/
                     ->setCellValue('U3', "当月实收")//设置列的值
                     ->setCellValue('V3', "当月应收")//设置列的值
                     ->setCellValue('W3', "继续率")//设置列的值
                     ->setCellValue('X3', "宽一实收")//设置列的值*/
                     ->setCellValue('Y3', "宽一应收")//设置列的值*/
                     ->setCellValue('Z3', "继续率")//设置列的值*/
                     ->setCellValue('AA3', "宽末实收")//设置列的值*/
                     ->setCellValue('AB3', "宽末应收")//设置列的值*/
                     ->setCellValue('AC3', "宽末继续率")//设置列的值*/
                     ->setCellValue('AD3', "当月实收")//设置列的值
                     ->setCellValue('AE3', "当月应收")//设置列的值
                     ->setCellValue('AF3', "继续率")//设置列的值
                     ->setCellValue('AG3', "宽一实收")//设置列的值*/
                     ->setCellValue('AH3', "宽一应收")//设置列的值*/
                     ->setCellValue('AI3', "继续率")//设置列的值*/
                     ->setCellValue('AJ3', "宽末实收")//设置列的值*/
                     ->setCellValue('AK3', "宽末实收")//设置列的值*/
                     ->setCellValue('AL3', "继续率");//设置列的值*/
        $objPHPExcel->getActiveSheet(3)->getColumnDimension('A')->setWidth(15);
        $objPHPExcel->getActiveSheet(3)->getColumnDimension('B')->setWidth(15);
        $objPHPExcel->getActiveSheet(3)->getColumnDimension('C')->setWidth(12);
        $objPHPExcel->getActiveSheet(3)->getColumnDimension('D')->setWidth(12);
        $objPHPExcel->getActiveSheet(3)->getColumnDimension('E')->setWidth(12);
        $objPHPExcel->getActiveSheet(3)->getColumnDimension('F')->setWidth(12);
        $objPHPExcel->getActiveSheet(3)->getColumnDimension('G')->setWidth(10);
        $objPHPExcel->getActiveSheet(3)->getColumnDimension('H')->setWidth(12);
        $objPHPExcel->getActiveSheet(3)->getColumnDimension('I')->setWidth(12);
        $objPHPExcel->getActiveSheet(3)->getColumnDimension('J')->setWidth(12);
        $objPHPExcel->getActiveSheet(3)->getColumnDimension('K')->setWidth(12);
		$objPHPExcel->getActiveSheet(3)->getColumnDimension('L')->setWidth(12);
		$objPHPExcel->getActiveSheet(3)->getColumnDimension('M')->setWidth(12);
		$objPHPExcel->getActiveSheet(3)->getColumnDimension('N')->setWidth(12);
		$objPHPExcel->getActiveSheet(3)->getColumnDimension('O')->setWidth(12);
		$objPHPExcel->getActiveSheet(3)->getColumnDimension('P')->setWidth(12);
		$objPHPExcel->getActiveSheet(3)->getColumnDimension('Q')->setWidth(12);
		$objPHPExcel->getActiveSheet(3)->getColumnDimension('R')->setWidth(12);
		$objPHPExcel->getActiveSheet(3)->getColumnDimension('S')->setWidth(12);
		$objPHPExcel->getActiveSheet(3)->getColumnDimension('T')->setWidth(12);
		$objPHPExcel->getActiveSheet(3)->getColumnDimension('U')->setWidth(12);
        $objPHPExcel->getActiveSheet(3)->getColumnDimension('V')->setWidth(12);
        $objPHPExcel->getActiveSheet(3)->getColumnDimension('W')->setWidth(12);
        $objPHPExcel->getActiveSheet(3)->getColumnDimension('X')->setWidth(12);
        $objPHPExcel->getActiveSheet(3)->getColumnDimension('Y')->setWidth(10);
        $objPHPExcel->getActiveSheet(3)->getColumnDimension('Z')->setWidth(12);
        $objPHPExcel->getActiveSheet(3)->getColumnDimension('AA')->setWidth(12);
        $objPHPExcel->getActiveSheet(3)->getColumnDimension('AB')->setWidth(12);
        $objPHPExcel->getActiveSheet(3)->getColumnDimension('AC')->setWidth(12);
		$objPHPExcel->getActiveSheet(3)->getColumnDimension('AD')->setWidth(12);
		$objPHPExcel->getActiveSheet(3)->getColumnDimension('AE')->setWidth(12);
		$objPHPExcel->getActiveSheet(3)->getColumnDimension('AF')->setWidth(12);
		$objPHPExcel->getActiveSheet(3)->getColumnDimension('AG')->setWidth(12);
		$objPHPExcel->getActiveSheet(3)->getColumnDimension('AH')->setWidth(12);
		$objPHPExcel->getActiveSheet(3)->getColumnDimension('AI')->setWidth(12);
		$objPHPExcel->getActiveSheet(3)->getColumnDimension('AJ')->setWidth(12);
		$objPHPExcel->getActiveSheet(3)->getColumnDimension('AK')->setWidth(12);
		$objPHPExcel->getActiveSheet(3)->getColumnDimension('AL')->setWidth(12);
		$arr3=$this->getContinuation('branch_shop_number'); 
//		p($arr3);//die;  
        $a=4;
                foreach ($arr3 as $key => $value) {
						foreach($value as $k=>$v){
           				 $objPHPExcel->setActiveSheetIndex(3)
                        ->setCellValue('A'.$a, $key)
                        ->setCellValue('B'.$a, $v['provider_name'])
                        ->setCellValue('C'.$a, $v['fact'])//当月实收
						->setCellValue('D'.$a, $v['should'])	
                        ->setCellValue('E'.$a, $v['fact']/$v['should']?round($v['fact']/$v['should'],2)*100 .'%':'')//实收继续率
                        ->setCellValue('F'.$a, $v['fact1'])//宽一实收
                        ->setCellValue('G'.$a, $v['should1'])//宽一应收
                        ->setCellValue('H'.$a, $v['fact1']/$v['should1']?round($v['fact1']/$v['should1'],2)*100 .'%':'')//宽一继续率
                        ->setCellValue('I'.$a, $v['fact2'])//宽末实收
                        ->setCellValue('G'.$a, $v['should2'])//宽末应收
                        ->setCellValue('K'.$a, $v['fact2']/$v['should2']?round($v['fact2']/$v['should2'],2)*100 .'%':'')//宽末继续率
                        ->setCellValue('L'.$a, $v['facts'])
						->setCellValue('M'.$a, $V['shoulds'])
						->setCellValue('N'.$a, $V['facts']/$v['shoulds']?round($v['facts']/$v['shoulds'],2)*100 .'%':'')//累计实收继续率
						->setCellValue('O'.$a, $v['facts1'])
						->setCellValue('P'.$a, $v['shoulds1'])
						->setCellValue('Q'.$a, $v['facts1']/$v['shoulds1'] ?round($v['facts1']/$v['shoulds1'],2)*100 .'%' :'')
						->setCellValue('R'.$a, $v['facts2'])
						->setCellValue('S'.$a, $v['shoulds2'])
						->setCellValue('T'.$a, $v['facts2']/$v['shoulds2'] ? round($v['facts2']/$v['shoulds2'],2)*100 .'%' :'')
						->setCellValue('U'.$a, $v['fact3'])//当月实收
						->setCellValue('V'.$a, $v['should3'])	
                        ->setCellValue('W'.$a, $v['fact3']/$v['should3']?round($v['fact3']/$v['should3'],2)*100 .'%':'')//实收继续率
                        ->setCellValue('X'.$a, $v['fact4'])//宽一实收
                        ->setCellValue('Y'.$a, $v['should4'])//宽一应收
                        ->setCellValue('Z'.$a, $v['fact4']/$v['should4']?round($v['fact4']/$v['should4'],2)*100 .'%':'')//宽一继续率
                        ->setCellValue('AA'.$a, $v['fact5'])//宽末实收
                        ->setCellValue('AB'.$a, $v['should5'])//宽末应收
                        ->setCellValue('AC'.$a, $v['fact5']/$v['should5']?round($v['fact5']/$v['should5'],2)*100 .'%':'')//宽末继续率
                        ->setCellValue('AD'.$a, $v['facts3'])
						->setCellValue('AE'.$a, $V['shoulds3'])
						->setCellValue('AF'.$a, $V['facts3']/$v['shoulds3']?round($v['facts3']/$v['shoulds3'],2)*100 .'%':'')//累计实收继续率
						->setCellValue('AG'.$a, $v['facts4'])
						->setCellValue('AH'.$a, $v['shoulds4'])
						->setCellValue('AI'.$a, $v['facts4']/$v['shoulds4'] ?round($v['facts4']/$v['shoulds4'],2)*100 .'%' :'')
						->setCellValue('AJ'.$a, $v['facts5'])
						->setCellValue('AK'.$a, $v['shoulds5'])
						->setCellValue('AL'.$a, $v['facts5']/$v['shoulds5'] ? round($v['facts5']/$v['shoulds5'],2)*100 .'%' :'');
						$countt = $v['count'];
     					$a++;
						}
				$b=$a-$countt;
				$c=$a-1;
 				$objPHPExcel->setActiveSheetIndex(3)
				->setCellValue('A'.$a, $key.'合计')
				->setCellValue('C'.$a, '=SUM(C'.$b.':C'.$c.')')
				->setCellValue('D'.$a, '=SUM(D'.$b.':D'.$c.')')
				->setCellValue('E'.$a, '=IFERROR(C'.$a.'/D'.$c.',"")')
				->setCellValue('F'.$a, '=SUM(F'.$b.':F'.$c.')')
				->setCellValue('G'.$a, '=SUM(G'.$b.':G'.$c.')')
				->setCellValue('H'.$a, '=IFERROR(F'.$a.'/G'.$a.',"")')
				->setCellValue('I'.$a, '=SUM(I'.$b.':I'.$c.')')
				->setCellValue('J'.$a, '=SUM(J'.$b.':J'.$c.')')
				->setCellValue('K'.$a, '=IFERROR(I'.$a.'/J'.$a.',"")')
				->setCellValue('L'.$a, '=SUM(L'.$b.':L'.$c.')')
				->setCellValue('M'.$a, '=SUM(M'.$b.':M'.$c.')')
				->setCellValue('N'.$a, '=IFERROR(L'.$a.'/M'.$a.',"")')
				->setCellValue('O'.$a, '=SUM(O'.$b.':O'.$c.')')
				->setCellValue('P'.$a, '=SUM(P'.$b.':P'.$c.')')
				->setCellValue('Q'.$a, '=IFERROR(O'.$a.'/P'.$a.',"")')
				->setCellValue('R'.$a, '=SUM(R'.$b.':R'.$c.')')
				->setCellValue('S'.$a, '=SUM(S'.$b.':S'.$c.')')
				->setCellValue('T'.$a, '=IFERROR(R'.$a.'/S'.$a.',"")')
				->setCellValue('U'.$a, '=SUM(U'.$b.':U'.$c.')')
				->setCellValue('V'.$a, '=SUM(V'.$b.':V'.$c.')')
				->setCellValue('W'.$a, '=IFERROR(U'.$a.'/V'.$a.',"")')
				->setCellValue('X'.$a, '=SUM(X'.$b.':X'.$c.')')
				->setCellValue('Y'.$a, '=SUM(Y'.$b.':Y'.$c.')')
				->setCellValue('Z'.$a, '=IFERROR(X'.$a.'/Y'.$a.',"")')
				->setCellValue('AA'.$a, '=SUM(AA'.$b.':AA'.$c.')')
				->setCellValue('AB'.$a, '=SUM(AB'.$b.':AB'.$c.')')
				->setCellValue('AC'.$a, '=IFERROR(AA'.$a.'/AA'.$a.',"")')
				->setCellValue('AD'.$a, '=SUM(AD'.$b.':AD'.$c.')')
				->setCellValue('AE'.$a, '=SUM(AE'.$b.':AE'.$c.')')
				->setCellValue('AF'.$a, '=IFERROR(AD'.$a.':AE'.$a.',"")')
				->setCellValue('AG'.$a, '=SUM(AG'.$b.':AG'.$c.')')
				->setCellValue('AH'.$a, '=SUM(AH'.$b.':AH'.$c.')')
				->setCellValue('AI'.$a, '=IFERROR(AG'.$a.'/AH'.$a.',"")')
				->setCellValue('AJ'.$a, '=SUM(AJ'.$b.':AJ'.$c.')')
				->setCellValue('AK'.$a, '=SUM(AK'.$b.':AK'.$c.')')
				->setCellValue('AL'.$a, '= AJ'.$a.'/Ak'.$a);
//				合并单元格
				$objPHPExcel->getActiveSheet(3)->mergeCells('A'.$a.':B'.$a);
				$objPHPExcel->getActiveSheet(3)->mergeCells('A'.$b.':A'.$c);
//				文字居中
				$objPHPExcel->getActiveSheet(3)->getStyle('A'.$b.':A'.$c)->getAlignment()->setHorizontal(\PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
				$objPHPExcel->getActiveSheet()->getStyle('A'.$b)->getAlignment()->setVertical(\PHPExcel_Style_Alignment::VERTICAL_CENTER);
				$objPHPExcel->getActiveSheet(3)->getStyle('A'.$a.':B'.$a)->getAlignment()->setHorizontal(\PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
				$a++;
				
			$all=$a;		
        }
		$al=$all-1;
		$objPHPExcel->setActiveSheetIndex(3)
									   ->setCellValue('C'.$all, '=SUM(C4:C'.$al.')/2')
									   ->setCellValue('D'.$all, '=SUM(D4:D'.$al.')/2')
									   ->setCellValue('F'.$all, '=SUM(F4:F'.$al.')/2')
									   ->setCellValue('G'.$all, '=SUM(G4:G'.$al.')/2')
									   ->setCellValue('I'.$all, '=SUM(I4:I'.$al.')/2')
									   ->setCellValue('J'.$all, '=SUM(J4:J'.$al.')/2')
									   ->setCellValue('L'.$all, '=SUM(L4:L'.$al.')/2')
									   ->setCellValue('M'.$all, '=SUM(M4:M'.$al.')/2')
									   ->setCellValue('O'.$all, '=SUM(O4:O'.$al.')/2')
									   ->setCellValue('P'.$all, '=SUM(P4:P'.$al.')/2')
									   ->setCellValue('R'.$all, '=SUM(R4:R'.$al.')/2')
									   ->setCellValue('S'.$all, '=SUM(S4:S'.$al.')/2')			   
									   ->setCellValue('U'.$all, '=SUM(U4:U'.$al.')/2')
									   ->setCellValue('V'.$all, '=SUM(V4:V'.$al.')/2')
									   ->setCellValue('X'.$all, '=SUM(X4:X'.$al.')/2')
									   ->setCellValue('Y'.$all, '=SUM(Y4:Y'.$al.')/2')
									   ->setCellValue('AA'.$all, '=SUM(AA4:AA'.$al.')/2')
									   ->setCellValue('AB'.$all, '=SUM(AB4:AB'.$al.')/2')
									   ->setCellValue('AD'.$all, '=SUM(AD4:AD'.$al.')/2')
									   ->setCellValue('AE'.$all, '=SUM(AE4:AE'.$al.')/2')
									   ->setCellValue('AG'.$all, '=SUM(AG4:AG'.$al.')/2')
									   ->setCellValue('AH'.$all, '=SUM(AH4:AH'.$al.')/2')
									   ->setCellValue('AJ'.$all, '=SUM(AJ4:AJ'.$al.')/2')
									   ->setCellValue('AK'.$all, '=SUM(AK4:AK'.$al.')/2');
									   
		$objPHPExcel->getActiveSheet(3)->mergeCells('A'.$all.':B'.$all)
										->setCellValue('A'.$all, "系统合计");//设置列的值*/
//										文字居中
		$objPHPExcel->getActiveSheet(3)->getStyle('A'.$all.':B'.$all)->getAlignment()->setHorizontal(\PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
        $objPHPExcel->getActiveSheet(3)->setTitle('分公司');
        header('Content-Type:application/vnd.ms-excel');
        header('Content-Disposition:attachment;filename="保单.xls"');
        header('Cache-Control: max-age=0');
        $objWriter = \PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel5');

        $objWriter->save('php://output'); 
//  header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');  
//  header('Content-Disposition: attachment;filename="links_out.xlsx"');  
//  header('Cache-Control: max-age=0');  
//  $objWriter = \PHPExcel_IOFactory::createWriter($objExcel, 'Excel2007');  
//  $objWriter->save('php://output'); 
    }

   public static function array_group_by($arr, $key)
    {
        $grouped = [];
        foreach ($arr as $value) {
            $grouped[$value[$key]][] = $value;
        }
        // Recursively build a nested grouping if more parameters are supplied
        // Each grouped array value is grouped according to the next sequential key
        if (func_num_args() > 2) {
            $args = func_get_args();
            foreach ($grouped as $key => $value){
                $parms = array_merge([$value], array_slice($args, 2, func_num_args()));
                $grouped[$key] = call_user_func_array('array_group_by', $parms);
            }
        }
        return $grouped;
    }
	/*
	 * $type 机构
	 * return array 
	 * 获得个人标准店旗舰店分公司继续率
	 * 13个月当月应收  实收  	宽一实收  	应收    宽末实收  	应收    	 13个月累计当月应收	应收  	宽一实收		应收		宽末实收		应收			
	 * 		should	  fact   should1 	fact1 should2	should2		shoulds			facts	shoulds1	facts1	shoulds2	shoulds2		
	 * 25个月当月应收	应收  	宽一实收		应收		宽末实收		应收		25个月累计当月应收	应收  	宽一实收		应收		宽末实收		应收	
	 * should3			fact3 	should4		fact4	should5		fact5	shoulds3			facts3	shoulds4	facts4	shoulds5	facts5
	 * */
	public function getContinuation($type) {
		$thismonth = date('m');
		$thisyear = date('Y');
		$insurance = M('insurance_re');
				//		分公司25个月继续率
		if($type=='branch_shop_number'){
				//当月应收实收
		$starttime = mktime(0, 0, 0, date('m'), 1, date('Y') - 1);
		//两年前当月月初时间
		$endtime = mktime(23, 59, 59, date('m'), date('t'), date('Y') - 1);

		//一年前当月月末时间戳

		$condition['insured_date'] = array( array('ELT', $endtime), array('EGT', $starttime));
		$condition['policy_status']=array('eq',0);
		$parameter1 = $insurance 
					 -> field('branch_shop_number,provider_name,provider_id,sum(insurance_premium) as should,sum(real_insurance_premium) as fact')
					 -> group('branch_shop_number,provider_name,provider_id')
			    	 -> where($condition)
					 -> select();
		//		13个月累计当月实收
		$starttimes = mktime(0, 0, 0, date('m') + 1, 1, date('Y') - 2);
		//两年前下月月初时间

		$endtimes = mktime(23, 59, 59, date('m'), date('t'), date('Y'));
				
		//一年前当月月末时间戳
		$conditions['insured_date'] = array( array('ELT', $endtimes), array('EGT', $starttimes));
		$conditions['policy_status']=array('eq',0);
		$parameters1 =$insurance 
					 -> field('branch_shop_number,provider_name,provider_id,sum(insurance_premium) as shoulds,sum(real_insurance_premium) as facts')
					 -> group('branch_shop_number,provider_name,provider_id')
			    	 -> where($conditions)
					 -> select();		
		//宽一应收实收
		if ($thismonth == 1) {
			$starmonth = 12;
			$staryear = $thisyear - 2;
		} else {
			$starmonth = $thismonth - 1;
			$staryear = $thisyear - 1;
		}
		$starttime1 = mktime(0, 0, 0, $starmonth, 1, $staryear);
		//一年前前一个月月初时间

		$endtime1 = mktime(0, 0, 0, $starmonth + 1, 1, $staryear);
		//一年前前当月月初时间
		$condition1['insured_date'] = array( array('LT', $endtime1), array('GT', $starttime1));
		$condition1['policy_status']=array('eq',0);
		$parameter2 = $insurance 
				 -> field('branch_shop_number,provider_name,provider_id,sum(insurance_premium) as should1,sum(real_insurance_premium) as fact1')
				 -> group('branch_shop_number,provider_name,provider_id')
		    	 -> where($condition1)
				 -> select();
		//		13个月累计宽一
		$starttimes1 = mktime(0, 0, 0, $starmonth + 1, 1, $staryear - 1);
		//一年前前一个月月初时间

		$endtimes1 = mktime(0, 0, 0, $starmonth + 1, 1, $staryear);
				
		//一年前前当月月初时间
		$conditions1['insured_date'] = array( array('LT', $endtimes1), array('GT', $starttimes1));
		$conditions1['policy_status']=array('eq',0);
		$parameters2 = $insurance 
					 -> field('branch_shop_number,provider_name,provider_id,sum(insurance_premium) as shoulds1,sum(real_insurance_premium) as facts1')
					 -> group('branch_shop_number,provider_name,provider_id')
			    	 -> where($conditions1)
					 -> select();
		//				-------------------------------------------------------------------------------
		//当月宽末应收实收

		if ($thismonth == 1) {
			$starmonth = 11;
			$staryear = $thisyear - 2;
		} else if ($thismonth == 2) {
			$starmonth = 12;
			$staryear = $thisyear - 2;
		} else {
			$starmonth = $thismonth - 2;
			$staryear = $thisyear - 1;
		}

		$starttime2 = mktime(0, 0, 0, $starmonth, 1, $staryear);
		//一年前前二个月月初时间

		$endtime2 = mktime(0, 0, 0, $starmonth + 1, 1, $staryear);
		//一年前前当月月初时间
		
		$condition2['insured_date'] = array( array('ELT', $endtime2), array('EGT', $starttime2));
		$condition2['policy_status']=array('eq',0);
		$parameter3 = $insurance 
					 -> field('branch_shop_number,provider_name,provider_id,sum(insurance_premium) as should2,sum(real_insurance_premium) as fact2')
					 -> group('branch_shop_number,provider_name,provider_id')
			    	 -> where($condition2)
					 -> select();
		//     	累计宽末
		$starttimes2 = mktime(0, 0, 0, $starmonth + 1, 1, $staryear - 1);
		//两年前前一个月月初时间
		$endtimes2 = mktime(0, 0, 0, $starmonth + 1, 1, $staryear);
		//一年前前当月月初时间
		
		$conditions2['insured_date'] = array( array('ELT', $endtimes2), array('EGT', $starttimes2));
		$conditions2['policy_status']=array('eq',0);
		$parameters3 = $insurance 
					 -> field('branch_shop_number,provider_name,provider_id,sum(insurance_premium) as shoulds2,sum(real_insurance_premium) as facts2')
					 -> group('branch_shop_number,provider_name,provider_id')
			    	 -> where($conditions2)
					 -> select();
					 
					 
					 
					 
			//25个月当月应收实收
		$starttime = mktime(0, 0, 0, date('m'), 1, date('Y') - 2);
		//两年前当月月初时间
		$endtime = mktime(23, 59, 59, date('m'), date('t'), date('Y') - 2);

		//一年前当月月末时间戳

		$condition3['insured_date'] = array( array('ELT', $endtime), array('EGT', $starttime));
		$condition3['policy_status']=array('eq',0);
		$parameter1s = $insurance 
					 -> field('branch_shop_number,provider_name,provider_id,sum(insurance_premium) as should3,sum(real_insurance_premium) as fact3')
					 -> group('branch_shop_number,provider_name,provider_id')
			    	 -> where($condition3)
					 -> select();
		//		25个月累计当月实收
		$starttimes = mktime(0, 0, 0, date('m') + 1, 1, date('Y') - 3);
		//两年前下月月初时间

		$endtimes = mktime(23, 59, 59, date('m'), date('t'), date('Y') - 1);
				
		$conditions3['insured_date'] = array( array('ELT', $endtimes), array('EGT', $starttimes));
		$conditions3['policy_status']=array('eq',0);
		$parameters1s =$insurance 
					 -> field('branch_shop_number,provider_name,provider_id,sum(insurance_premium) as shoulds3,sum(real_insurance_premium) as facts3')
					 -> group('branch_shop_number,provider_name,provider_id')
			    	 -> where($conditions3)
					 -> select();		
		//宽一应收实收
		if ($thismonth == 1) {
			$starmonth = 12;
			$staryear = $thisyear - 2;
		} else {
			$starmonth = $thismonth - 1;
			$staryear = $thisyear - 1;
		}
		$starttime1 = mktime(0, 0, 0, $starmonth, 1, $staryear-1);
		//一年前前一个月月初时间

		$endtime1 = mktime(0, 0, 0, $starmonth + 1, 1, $staryear-1);
		
		//一年前前当月月初时间
		$condition4['insured_date'] = array( array('LT', $endtime1), array('GT', $starttime1));
		$condition4['policy_status']=array('eq',0);
		$parameter2s = $insurance 
			 -> field('branch_shop_number,provider_name,provider_id,sum(insurance_premium) as should4,sum(real_insurance_premium) as fact4')
			 -> group('branch_shop_number,provider_name,provider_id')
	    	 -> where($condition4)
			 -> select();
		//		25个月累计宽一
		$starttimes1 = mktime(0, 0, 0, $starmonth + 1, 1, $staryear - 2);
		$endtimes1 = mktime(0, 0, 0, $starmonth + 1, 1, $staryear);
		$conditions4['insured_date'] = array( array('LT', $endtimes1), array('GT', $starttimes1));
		$conditions4['policy_status']=array('eq',0);
		$parameters2s = $insurance 
					 -> field('branch_shop_number,provider_name,provider_id,sum(insurance_premium) as shoulds4,sum(real_insurance_premium) as facts4')
					 -> group('branch_shop_number,provider_name,provider_id')
			    	 -> where($conditions4)
					 -> select();
		//				-------------------------------------------------------------------------------
		//当月宽末应收实收

		if ($thismonth == 1) {
			$starmonth = 11;
			$staryear = $thisyear - 2;
		} else if ($thismonth == 2) {
			$starmonth = 12;
			$staryear = $thisyear - 2;
		} else {
			$starmonth = $thismonth - 2;
			$staryear = $thisyear - 1;
		}

		$starttime2 = mktime(0, 0, 0, $starmonth, 1, $staryear-1);
		//一年前前二个月月初时间

		$endtime2 = mktime(0, 0, 0, $starmonth + 1, 1, $staryear-1);
		//一年前前当月月初时间
		
		$condition5['insured_date'] = array( array('ELT', $endtime2), array('EGT', $starttime2));
		$condition5['policy_status']=array('eq',0);
		$parameter3s = $insurance 
					 -> field('branch_shop_number,provider_name,provider_id,sum(insurance_premium) as should5,sum(real_insurance_premium) as fact5')
					 -> group('branch_shop_number,provider_name,provider_id')
			    	 -> where($condition5)
					 -> select();
		//     	累计宽末
		$starttimes2 = mktime(0, 0, 0, $starmonth + 1, 1, $staryear - 2);
		//两年前前一个月月初时间
		$endtimes2 = mktime(0, 0, 0, $starmonth + 1, 1, $staryear);
		//一年前前当月月初时间
		$conditions5['insured_date'] = array( array('ELT', $endtimes2), array('EGT', $starttimes2));
		$conditions5['policy_status']=array('eq',0);
		$parameters3s = $insurance 
					 -> field('branch_shop_number,provider_name,provider_id,sum(insurance_premium) as shoulds5,sum(real_insurance_premium) as facts5')
					 -> group('branch_shop_number,provider_name,provider_id')
			    	 -> where($conditions5)
					 -> select();
					 
		$a = array_merge($parameter1, $parameter2, $parameter3, $parameters1, $parameters2, $parameters3,$parameter1s, $parameter2s, $parameter3s, $parameters1s, $parameters2s, $parameters3s);
		$b = self::array_group_by($a, $type);
		foreach($b as $k=>$v){
			$b[$k]=self::array_group_by($b[$k], provider_name);
		}
		foreach($b as $k=>$v){
			foreach($v as $kk=>$vv){
				foreach($vv as $kkk=>$vvv){
					foreach($vvv as $kkkk=>$vvvv)
					$arr[$k][$kk][$kkkk]=$vvvv;
					$arr[$k][$kk]['count']=count($v);
				}
			}
		}
//		p($arr);die;
		return $arr;
		
		}else{
			
		
		//当月应收实收
		$starttime = mktime(0, 0, 0, date('m'), 1, date('Y') - 1);
		//一年前当月月初时间

		$endtime = mktime(23, 59, 59, date('m'), date('t'), date('Y') - 1);
		//一年前当月月末时间戳

		$condition['insured_date'] = array( array('ELT', $endtime), array('EGT', $starttime));
		$condition['policy_status']=array('eq',0);
		$parameter1 = $insurance -> field('branch_shop_number,standard_shop_number,flag_shop_number,salesman_number,salesman_name,sum(insurance_premium) as should,sum(real_insurance_premium) as fact') -> group('branch_shop_number,standard_shop_number,flag_shop_number,salesman_number,salesman_name') -> where($condition) -> select();
		//		累计当月实收
		$starttimes = mktime(0, 0, 0, date('m') + 1, 1, date('Y') - 2);
		//两年前下月月初时间

		$endtimes = mktime(23, 59, 59, date('m'), date('t'), date('Y') - 1);
		//一年前当月月末时间戳
		$conditions['insured_date'] = array( array('ELT', $endtimes), array('EGT', $starttimes));
		$conditions['policy_status']=array('eq',0);
		$parameters1 = $insurance -> field('branch_shop_number,standard_shop_number,flag_shop_number,salesman_number,salesman_name,sum(insurance_premium) as shoulds,sum(real_insurance_premium) as facts') -> group('branch_shop_number,standard_shop_number,flag_shop_number,salesman_number,salesman_name') -> where($conditions) -> select();
		//								 ---------------------------------------------------------------------------------------
		//宽一应收实收
		if ($thismonth == 1) {
			$starmonth = 12;
			$staryear = $thisyear - 2;
		} else {
			$starmonth = $thismonth - 1;
			$staryear = $thisyear - 1;
		}
		$starttime1 = mktime(0, 0, 0, $starmonth, 1, $staryear);
		//一年前前一个月月初时间

		$endtime1 = mktime(0, 0, 0, $starmonth + 1, 1, $staryear);
		//一年前前当月月初时间
		$condition1['insured_date'] = array( array('LT', $endtime1), array('GT', $starttime1));
		$condition1['policy_status']=array('eq',0);
		$parameter2 = $insurance -> field('branch_shop_number,standard_shop_number,flag_shop_number,salesman_number,salesman_name,sum(insurance_premium) as should1,sum(real_insurance_premium) as fact1') -> group('branch_shop_number,standard_shop_number,flag_shop_number,salesman_number,salesman_name') -> where($condition1) -> select();
		//		累计宽一
		$starttimes1 = mktime(0, 0, 0, $starmonth + 1, 1, $staryear - 1);
		//一年前前一个月月初时间

		$endtimes1 = mktime(0, 0, 0, $starmonth + 1, 1, $staryear);
		//一年前前当月月初时间
		$conditions1['insured_date'] = array( array('LT', $endtimes1), array('GT', $starttimes1));
		$conditions1['policy_status']=array('eq',0);
		$parameters2 = $insurance -> field('branch_shop_number,standard_shop_number,flag_shop_number,salesman_number,salesman_name,sum(insurance_premium) as shoulds1,sum(real_insurance_premium) as facts1') -> group('branch_shop_number,standard_shop_number,flag_shop_number,salesman_number,salesman_name') -> where($conditions1) -> select();
		//				-------------------------------------------------------------------------------
		//当月宽末应收实收

		if ($thismonth == 1) {
			$starmonth = 11;
			$staryear = $thisyear - 2;
		} else if ($thismonth == 2) {
			$starmonth = 12;
			$staryear = $thisyear - 2;
		} else {
			$starmonth = $thismonth - 2;
			$staryear = $thisyear - 1;
		}

		$starttime2 = mktime(0, 0, 0, $starmonth, 1, $staryear);
		//一年前前二个月月初时间

		$endtime2 = mktime(0, 0, 0, $starmonth + 1, 1, $staryear);
		//一年前前当月月初时间
		$condition2['insured_date'] = array( array('ELT', $endtime2), array('EGT', $starttime2));
		$condition2['policy_status']=array('eq',0);
		$parameter3 = $insurance -> field('branch_shop_number,standard_shop_number,flag_shop_number,salesman_number,salesman_name,sum(insurance_premium) as should2,sum(real_insurance_premium) as fact2') -> group('branch_shop_number,standard_shop_number,flag_shop_number,salesman_number,salesman_name') -> where($condition2) -> select();
		//     	累计宽末
		$starttimes2 = mktime(0, 0, 0, $starmonth + 1, 1, $staryear - 1);
		//两年前前一个月月初时间
		$endtimes2 = mktime(0, 0, 0, $starmonth + 1, 1, $staryear);
		//一年前前当月月初时间

		$conditions2['insured_date'] = array( array('ELT', $endtimes2), array('EGT', $starttimes2));
		$conditions2['policy_status']=array('eq',0);
		$parameters3 = $insurance -> field('branch_shop_number,standard_shop_number,flag_shop_number,salesman_number,salesman_name,sum(insurance_premium) as shoulds2,sum(real_insurance_premium) as facts2') -> group('branch_shop_number,standard_shop_number,flag_shop_number,salesman_number,salesman_name') -> where($conditions2) -> select();
		$a = array_merge($parameter1, $parameter2, $parameter3, $parameters1, $parameters2, $parameters3);
		$b = self::array_group_by($a, $type);
		
		switch ($type) {
			case 'salesman_number' :
				foreach ($b as $k => $v) {
					foreach ($v as $kk => $vv) {
						foreach ($vv as $kkk => $vvv) {
							$arr[$k][$kkk] = $vvv;
						}
					}
				}
				break;
			default :
				$array = array('should', 'fact', 'should1', 'fact1', 'should2', 'fact2', 'shoulds', 'facts', 'shoulds1', 'facts1', 'shoulds2', 'facts2');
				foreach ($b as $k => $v) {
					foreach ($v as $kk => $vv) {
						foreach ($vv as $kkk => $vvv) {
							if (in_array($kkk, $array)) {
								$arr[$k][$kkk] += $vvv;
							} else {

								$arr[$k][$kkk] = $vvv;
							}

						}
					}
				}
				break;
		}
		return $arr;
		}
	}

}


?>