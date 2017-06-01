<?php
namespace Admin\Controller;

use Common\Controller\AdminbaseController;
/**
*
*/
class SettleExcelController extends AdminbaseController
{

	public function get_excel(){
		/*判断时哪里的导出*/
		$number = I("number");
		$index_sign = I("index_sign");
		$life_sign  = I("life_sign");
		$non_life_sign = I("non_life_sign");
		$renewal_sign  = I("renewal_sign");
        /*制作文件名*/
        if ($index_sign != "") {
            $arr      = explode("_", $index_sign);
            $date     = date("Y年m月",$arr[1]);
            $supplier = M("supplier")->where("sup_id = ".$arr[0])->field("full_name")->find();

        }else if ($life_sign != "") {
            $arr      = explode("_", $life_sign);
            $date     = date("Y年m月",$arr[1]);
            $supplier = M("supplier")->where("sup_id = ".$arr[0])->field("full_name")->find();

        }else if ($non_life_sign != "") {
            $arr      = explode("_", $non_life_sign);
            $date     = date("Y年m月",$arr[1]);
            $supplier = M("supplier")->where("sup_id = ".$arr[0])->field("full_name")->find();

        }else if ($renewal_sign != "") {
            $arr      = explode("_", $renewal_sign);
            $date     = date("Y年m月",$arr[1]);
            $supplier = M("supplier")->where("sup_id = ".$arr[0])->field("full_name")->find();

        }else{
            $this->error("未知错误，请重试");
        }
        $file_name = $supplier["full_name"].$date;
        /*判断时哪里想要导出什么页*/
		if ($number == 1) {
			/*所有页*/
			$this->get_all($index_sign,$life_sign,$non_life_sign,$renewal_sign,$file_name);
		}else if ($number == 2) {
			/*为寿险详细页*/
			$this->get_life($life_sign,$file_name);
		}else if ($number == 3) {
			/*为非寿险详细页*/
			$this->get_non_life($non_life_sign,$file_name);
		}else if ($number == 4) {
			/*为续期保单*/
			$this->get_renewal($renewal_sign,$file_name);
		}else{
			$this->error("未知错误，请重试");
		}
	}
	public function get_all($index_sign,$life_sign,$non_life_sign,$renewal_sign,$file_name){

        header("Content-Typ:text/html;charset=utf-8");
        vendor('Excel.PHPExcel');
        vendor('Excel.PHPExcel.IOFactory');
		$objPHPExcel = new \PHPExcel();
        /*设置首页的工作sheet*/
        $objPHPExcel ->setActiveSheetIndex(0)
                     ->setCellValue('A1', "供应商")//设置列的值
                     ->setCellValue('B1', "首期寿险结算保费")//设置列的值
                     ->setCellValue('C1', "首期非寿险结算保费")//设置列的值
                     ->setCellValue('D1', "首期寿险业推奖金")//设置列的值
                     ->setCellValue('E1', "首期非寿险业务奖金")//设置列的值
                     ->setCellValue('F1', "首期手续费总计")//设置列的值
                     ->setCellValue('G1', "续期结算保费")//设置列的值
                     ->setCellValue('H1', "续期继续率奖金")//设置列的值
                     ->setCellValue('I1', "续期手续费总计")//设置列的值
                     ->setCellValue('J1', "总计");//设置列的值*/
        /*设置字段宽度*/
        $objPHPExcel ->getActiveSheet(0) ->getColumnDimension('A') ->setWidth(10);
        $objPHPExcel ->getActiveSheet(0) ->getColumnDimension('B') ->setWidth(20);
        $objPHPExcel ->getActiveSheet(0) ->getColumnDimension('C') ->setWidth(22);
        $objPHPExcel ->getActiveSheet(0) ->getColumnDimension('D') ->setWidth(20);
        $objPHPExcel ->getActiveSheet(0) ->getColumnDimension('E') ->setWidth(22);
        $objPHPExcel ->getActiveSheet(0) ->getColumnDimension('F') ->setWidth(18);
        $objPHPExcel ->getActiveSheet(0) ->getColumnDimension('G') ->setWidth(16);
        $objPHPExcel ->getActiveSheet(0) ->getColumnDimension('H') ->setWidth(18);
        $objPHPExcel ->getActiveSheet(0) ->getColumnDimension('I') ->setWidth(18);
        $objPHPExcel ->getActiveSheet(0) ->getColumnDimension('J') ->setWidth(6);
        $index = S($index_sign);
        $i = 2;
        $objPHPExcel->setActiveSheetIndex(0)
                    ->setCellValue('A'.$i, $index['supplier_name'])
                    ->setCellValue('B'.$i, $index['life_premium'])
                    ->setCellValue('C'.$i, $index['non_life_premium'])
                    ->setCellValue('D'.$i, $index['first_industry_bonus'])
                    ->setCellValue('E'.$i, $index['non_life_insurance_premium'])
                    ->setCellValue('F'.$i, $index['initial_fee'])
                    ->setCellValue('G'.$i, $index['renewal_settle_premium'])
                    ->setCellValue('H'.$i, $index['renewal_bonus'])
                    ->setCellValue('I'.$i, $index['renewal_fee'])
                    ->setCellValue('J'.$i, $index['aggregate_amount']);

        $objPHPExcel ->getActiveSheet(0)->setTitle("总计");

        /*设置寿险详细页的工作sheet*/
        $life_result = S($life_sign);
        $objPHPExcel ->createSheet(1);
        $objPHPExcel ->setActiveSheetIndex(1)
                     ->setCellValue('A1', "保单号")//设置列的值
                     ->setCellValue('B1', "供应商")//设置列的值
                     ->setCellValue('C1', "产品名称")//设置列的值
                     ->setCellValue('D1', "规模保费")//设置列的值
                     ->setCellValue('E1', "标准保费")//设置列的值
                     ->setCellValue('F1', "签约比例")//设置列的值
                     ->setCellValue('G1', "代理费")//设置列的值
                     ->setCellValue('H1', "投保日期")//设置列的值
                     ->setCellValue('I1', "缴费年期")//设置列的值
                     ->setCellValue('J1', "客户姓名");//设置列的值*/

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

        $a=2;
        foreach ($life_result as $key => $value) {

            $objPHPExcel->setActiveSheetIndex(1)
                        ->setCellValue('A'.$a, $value['policy_number'])
                        ->setCellValue('B'.$a, $value['full_name'])
                        ->setCellValue('C'.$a, $value['product_name'])
                        ->setCellValue('D'.$a, $value['insurance_premium'])
                        ->setCellValue('E'.$a, $value['standard_money'])
                        ->setCellValue('F'.$a, $value['scale'])
                        ->setCellValue('G'.$a, $value['agent_cost'])
                        ->setCellValue('H'.$a, $value['date'])
                        ->setCellValue('I'.$a, $value['payment_limit'])
                        ->setCellValue('J'.$a, $value['policy_holder_name']);
            $a++;
        }
        $objPHPExcel->getActiveSheet(1)->setTitle('寿险结算详细表');

        /*设置非寿险详细页的工作sheet*/
        $non_life_result = S($non_life_sign);
        $objPHPExcel ->createSheet(2);
        $objPHPExcel ->setActiveSheetIndex(2)
                     ->setCellValue('A1', "保单号")//设置列的值
                     ->setCellValue('B1', "供应商")//设置列的值
                     ->setCellValue('C1', "产品名称")//设置列的值
                     ->setCellValue('D1', "规模保费")//设置列的值
                     ->setCellValue('E1', "签约比例")//设置列的值
                     ->setCellValue('F1', "代理费")//设置列的值
                     ->setCellValue('G1', "客户姓名")//设置列的值
                     ->setCellValue('H1', "投保日期");//设置列的值

        $objPHPExcel->getActiveSheet(2)->getColumnDimension('A')->setWidth(15);
        $objPHPExcel->getActiveSheet(2)->getColumnDimension('B')->setWidth(15);
        $objPHPExcel->getActiveSheet(2)->getColumnDimension('C')->setWidth(16);
        $objPHPExcel->getActiveSheet(2)->getColumnDimension('D')->setWidth(16);
        $objPHPExcel->getActiveSheet(2)->getColumnDimension('E')->setWidth(16);
        $objPHPExcel->getActiveSheet(2)->getColumnDimension('F')->setWidth(12);
        $objPHPExcel->getActiveSheet(2)->getColumnDimension('G')->setWidth(16);
        $objPHPExcel->getActiveSheet(2)->getColumnDimension('H')->setWidth(16);


        $b=2;
        foreach ($non_life_result as $key => $value) {

            $objPHPExcel->setActiveSheetIndex(2)
                        ->setCellValue('A'.$b, $value['policy_number'])
                        ->setCellValue('B'.$b, $value['full_name'])
                        ->setCellValue('C'.$b, $value['product_name'])
                        ->setCellValue('D'.$b, $value['insurance_premium'])
                        ->setCellValue('E'.$b, $value['initial_contract_ratio'])
                        ->setCellValue('F'.$b, $value['agent_cost'])
                        ->setCellValue('G'.$b, $value['policy_holder_name'])
                        ->setCellValue('H'.$b, $value['date']);
            $b++;
        }
        $objPHPExcel->getActiveSheet(2)->setTitle('非寿险结算详细表');

        /*续期详细页工作sheet*/
        $renewal = S($renewal_sign);
        $objPHPExcel ->createSheet(3);
        $objPHPExcel ->setActiveSheetIndex(3)
                     ->setCellValue('A1', "保单号")//设置列的值
                     ->setCellValue('B1', "供应商")//设置列的值
                     ->setCellValue('C1', "产品名称")//设置列的值
                     ->setCellValue('D1', "应收保费")//设置列的值
                     ->setCellValue('E1', "实收保费")//设置列的值
                     ->setCellValue('F1', "承保日期")//设置列的值
                     ->setCellValue('G1', "续保日期")//设置列的值
                     ->setCellValue('H1', "续期年数")//设置列的值
                     ->setCellValue('I1', "签约比例")//设置列的值
                     ->setCellValue('J1', "结算保费");//设置列的值*/

        $objPHPExcel->getActiveSheet(3)->getColumnDimension('A')->setWidth(15);
        $objPHPExcel->getActiveSheet(3)->getColumnDimension('B')->setWidth(10);
        $objPHPExcel->getActiveSheet(3)->getColumnDimension('C')->setWidth(12);
        $objPHPExcel->getActiveSheet(3)->getColumnDimension('D')->setWidth(12);
        $objPHPExcel->getActiveSheet(3)->getColumnDimension('E')->setWidth(12);
        $objPHPExcel->getActiveSheet(3)->getColumnDimension('F')->setWidth(12);
        $objPHPExcel->getActiveSheet(3)->getColumnDimension('G')->setWidth(12);
        $objPHPExcel->getActiveSheet(3)->getColumnDimension('H')->setWidth(12);
        $objPHPExcel->getActiveSheet(3)->getColumnDimension('I')->setWidth(12);
        $objPHPExcel->getActiveSheet(3)->getColumnDimension('J')->setWidth(12);

        $c=2;
        foreach ($renewal as $key => $value) {

            $objPHPExcel->setActiveSheetIndex(3)
                        ->setCellValue('A'.$c, $value['insurance_num'])
                        ->setCellValue('B'.$c, $value['provider_name'])
                        ->setCellValue('C'.$c, $value['product_name'])
                        ->setCellValue('D'.$c, $value['insurance_premium'])
                        ->setCellValue('E'.$c, $value['real_insurance_premium'])
                        ->setCellValue('F'.$c, $value['i_date'])
                        ->setCellValue('G'.$c, $value['r_date'])
                        ->setCellValue('H'.$c, $value['renew_count'])
                        ->setCellValue('I'.$c, $value['renewal_ratio'])
                        ->setCellValue('J'.$c, $value['agency_fee']);
            $c++;
        }
        $objPHPExcel->getActiveSheet(3)->setTitle('续期结算详细表');

        /*浏览器输出*/
        $filename = $file_name."结算表.xls";
        header('Content-Type: application/vnd.ms-excel; charset=utf-8');
        header("Content-Disposition: attachment;filename=".$filename);
        header('Cache-Control: max-age=0');
        $objWriter = \PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel5');
        $objWriter->save('php://output');



    	}

	/*寿险结算详细页*/
	public function get_life($life_sign,$file_name){
		header("Content-Typ:text/html;charset=utf-8");
        vendor('Excel.PHPExcel');
        vendor('Excel.PHPExcel.IOFactory');

        $result = S($life_sign);

        $objPHPExcel = new \PHPExcel();
        $objPHPExcel->setActiveSheetIndex(0)
                    ->setCellValue('A1', "保单号")//设置列的值
                    ->setCellValue('B1', "供应商")//设置列的值
                    ->setCellValue('C1', "产品名称")//设置列的值
                    ->setCellValue('D1', "规模保费")//设置列的值
                    ->setCellValue('E1', "标准保费")//设置列的值
                    ->setCellValue('F1', "签约比例")//设置列的值
                    ->setCellValue('G1', "代理费")//设置列的值
                    ->setCellValue('H1', "投保日期")//设置列的值
                    ->setCellValue('I1', "缴费年期")//设置列的值
                    ->setCellValue('J1', "客户姓名");//设置列的值*/

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

        $i=2;
        foreach ($result as $key => $value) {

            $objPHPExcel->setActiveSheetIndex(0)
                        ->setCellValue('A'.$i, $value['policy_number'])
                        ->setCellValue('B'.$i, $value['full_name'])
                        ->setCellValue('C'.$i, $value['product_name'])
                        ->setCellValue('D'.$i, $value['insurance_premium'])
                        ->setCellValue('E'.$i, $value['standard_money'])
                        ->setCellValue('F'.$i, $value['scale'])
                        ->setCellValue('G'.$i, $value['agent_cost'])
                        ->setCellValue('H'.$i, $value['date'])
                        ->setCellValue('I'.$i, $value['payment_limit'])
                        ->setCellValue('J'.$i, $value['policy_holder_name']);
            $i++;
        }
        $objPHPExcel->getActiveSheet(0)->setTitle('寿险结算详细表');
        $filename = $file_name."寿险结算详细表.xls";
        header('Content-Type: application/vnd.ms-excel; charset=utf-8');
        header("Content-Disposition: attachment;filename=".$filename);
        header('Cache-Control: max-age=0');
        $objWriter = \PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel5');

        $objWriter->save('php://output');
	}
	/*非寿险结算详细页*/
	public function get_non_life($non_life_sign,$file_name){
		header("Content-Typ:text/html;charset=utf-8");
        vendor('Excel.PHPExcel');
        vendor('Excel.PHPExcel.IOFactory');

        $result = S($non_life_sign);
        $objPHPExcel = new \PHPExcel();
        $objPHPExcel->getActiveSheet()->setCellValue('A1', "保单号");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('B1', "供应商");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('C1', "产品名称");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('D1', "规模保费");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('E1', "签约比例");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('F1', "代理费");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('G1', "客户姓名");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('H1', "投保日期");//设置列的值

        $objPHPExcel->getActiveSheet()->getColumnDimension('A')->setWidth(15);
        $objPHPExcel->getActiveSheet()->getColumnDimension('B')->setWidth(15);
        $objPHPExcel->getActiveSheet()->getColumnDimension('C')->setWidth(16);
        $objPHPExcel->getActiveSheet()->getColumnDimension('D')->setWidth(16);
        $objPHPExcel->getActiveSheet()->getColumnDimension('E')->setWidth(16);
        $objPHPExcel->getActiveSheet()->getColumnDimension('F')->setWidth(12);
        $objPHPExcel->getActiveSheet()->getColumnDimension('G')->setWidth(16);
        $objPHPExcel->getActiveSheet()->getColumnDimension('H')->setWidth(16);


        $i=2;
        foreach ($result as $key => $value) {

			$objPHPExcel->setActiveSheetIndex(0)
	                    ->setCellValue('A'.$i, $value['policy_number'])
	                    ->setCellValue('B'.$i, $value['full_name'])
	                    ->setCellValue('C'.$i, $value['product_name'])
	                    ->setCellValue('D'.$i, $value['insurance_premium'])
	                    ->setCellValue('E'.$i, $value['initial_contract_ratio'])
	                    ->setCellValue('F'.$i, $value['agent_cost'])
	                    ->setCellValue('G'.$i, $value['policy_holder_name'])
	                    ->setCellValue('H'.$i, $value['date']);
	        $i++;
		}
		$objPHPExcel->getActiveSheet(0)->setTitle('非寿险结算详细表');
        $filename = $file_name."非寿险结算详细表.xls";
        header('Content-Type: application/vnd.ms-excel; charset=utf-8');
        header("Content-Disposition: attachment;filename=".$filename);
        header('Cache-Control: max-age=0');
        $objWriter = \PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel5');

        $objWriter->save('php://output');
	}
	/*续期保单*/
	public function get_renewal($renewal_sign,$file_name){
		header("Content-Typ:text/html;charset=utf-8");
        vendor('Excel.PHPExcel');
        vendor('Excel.PHPExcel.IOFactory');

        $result = S($renewal_sign);

        $objPHPExcel = new \PHPExcel();
        $objPHPExcel->getActiveSheet()->setCellValue('A1', "保单号");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('B1', "供应商");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('C1', "产品名称");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('D1', "应收保费");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('E1', "实收保费");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('F1', "承保日期");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('G1', "续保日期");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('H1', "续期年数");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('I1', "签约比例");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('J1', "结算保费");//设置列的值

        $objPHPExcel->getActiveSheet()->getColumnDimension('A')->setWidth(15);
        $objPHPExcel->getActiveSheet()->getColumnDimension('B')->setWidth(10);
        $objPHPExcel->getActiveSheet()->getColumnDimension('C')->setWidth(12);
        $objPHPExcel->getActiveSheet()->getColumnDimension('D')->setWidth(12);
        $objPHPExcel->getActiveSheet()->getColumnDimension('E')->setWidth(12);
        $objPHPExcel->getActiveSheet()->getColumnDimension('F')->setWidth(12);
        $objPHPExcel->getActiveSheet()->getColumnDimension('G')->setWidth(12);
        $objPHPExcel->getActiveSheet()->getColumnDimension('H')->setWidth(12);
        $objPHPExcel->getActiveSheet()->getColumnDimension('I')->setWidth(12);
		$objPHPExcel->getActiveSheet()->getColumnDimension('J')->setWidth(12);

        $i=2;
		foreach ($result as $key => $value) {

			$objPHPExcel->setActiveSheetIndex(0)
	                    ->setCellValue('A'.$i, $value['insurance_num'])
	                    ->setCellValue('B'.$i, $value['provider_name'])
	                    ->setCellValue('C'.$i, $value['product_name'])
	                    ->setCellValue('D'.$i, $value['insurance_premium'])
	                    ->setCellValue('E'.$i, $value['real_insurance_premium'])
	                    ->setCellValue('F'.$i, $value['i_date'])
	                    ->setCellValue('G'.$i, $value['r_date'])
	                    ->setCellValue('H'.$i, $value['renew_count'])
	                    ->setCellValue('I'.$i, $value['renewal_ratio'])
	                    ->setCellValue('J'.$i, $value['agency_fee']);
	        $i++;
		}
		$objPHPExcel->getActiveSheet(0)->setTitle('续期结算详细表');
        $filename = $file_name."续期结算详细表.xls";
        header('Content-Type: application/vnd.ms-excel; charset=utf-8');
        header("Content-Disposition: attachment;filename=".$filename);
        header('Cache-Control: max-age=0');
        $objWriter = \PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel5');

        $objWriter->save('php://output');

	}
    /**
     * 导出分公司考核结果到excel
     * @return [type] [description]
     */
    public function get_check_branch_result(){

        header("Content-Typ:text/html;charset=utf-8");
        vendor('Excel.PHPExcel');
        vendor('Excel.PHPExcel.IOFactory');
        $objPHPExcel = new \PHPExcel();

         /*设置首页的工作sheet*/
        $objPHPExcel ->setActiveSheetIndex(0)
                     ->setCellValue('A1', "分公司")//设置列的值
                     ->setCellValue('B1', "旗舰店")//设置列的值
                     ->setCellValue('E1', "标准店")//设置列的值
                     ->setCellValue('H1', "会员")//设置列的值
                     ->setCellValue('B2', "维持")//设置列的值
                     ->setCellValue('C2', "降级")//设置列的值
                     ->setCellValue('D2', "观察")//设置列的值
                     ->setCellValue('E2', "维持")//设置列的值
                     ->setCellValue('F2', "降级")//设置列的值
                     ->setCellValue('G2', "观察")//设置列的值
                     ->setCellValue('H2', "达标人数")//设置列的值
                     ->setCellValue('I2', "申请人数")//设置列的值
                     ->setCellValue('J2', "申请率");//设置列的值

        //合并单元格
        $objPHPExcel->getActiveSheet(0)->mergeCells('A1:A2');
        $objPHPExcel->getActiveSheet(0)->mergeCells('B1:D1');
        $objPHPExcel->getActiveSheet(0)->mergeCells('E1:G1');
        $objPHPExcel->getActiveSheet(0)->mergeCells('H1:J1');
        //设置居中

        $objPHPExcel->getDefaultStyle()->getAlignment()->setVertical(\PHPExcel_Style_Alignment::VERTICAL_CENTER)->setHorizontal(\PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
        //设置行高
        $objPHPExcel->getActiveSheet(1)->getRowDimension(1)->setRowHeight(30);
        $objPHPExcel->getActiveSheet(1)->getRowDimension(2)->setRowHeight(30);
        $objPHPExcel->getActiveSheet(1)->getDefaultStyle()->getFont()->setName("微软雅黑");//设置默认字体大小和格式
        $objPHPExcel->getActiveSheet(1)->getStyle('A1:A2')->getFont()->setName('微软雅黑') //字体
        ->setBold(true); //字体加粗
        $objPHPExcel->getActiveSheet(1)->getStyle('B1:D1')->getFont()->setBold(true); //字体加粗
        $objPHPExcel->getActiveSheet(1)->getStyle('E1:G1')->getFont()->setBold(true); //字体加粗
        $objPHPExcel->getActiveSheet(1)->getStyle('H1:J1')->getFont()->setBold(true); //字体加粗
        $objPHPExcel->getActiveSheet(1)->getStyle('B2:J2')->getFont()->setBold(true); //字体加粗


        /*设置字段宽度*/
        $objPHPExcel ->getActiveSheet(0) ->getColumnDimension('A') ->setWidth(40);
        $objPHPExcel ->getActiveSheet(0) ->getColumnDimension('B') ->setWidth(18);
        $objPHPExcel ->getActiveSheet(0) ->getColumnDimension('C') ->setWidth(18);
        $objPHPExcel ->getActiveSheet(0) ->getColumnDimension('D') ->setWidth(18);
        $objPHPExcel ->getActiveSheet(0) ->getColumnDimension('E') ->setWidth(18);
        $objPHPExcel ->getActiveSheet(0) ->getColumnDimension('F') ->setWidth(18);
        $objPHPExcel ->getActiveSheet(0) ->getColumnDimension('G') ->setWidth(18);
        $objPHPExcel ->getActiveSheet(0) ->getColumnDimension('H') ->setWidth(18);
        $objPHPExcel ->getActiveSheet(0) ->getColumnDimension('I') ->setWidth(18);
        $objPHPExcel ->getActiveSheet(0) ->getColumnDimension('J') ->setWidth(18);
        $data_cache = S('check_bracnh_data');
        $branch_code = I('param.branch');

        if($branch_code){
            foreach ($data_cache as $key => $value) {
                if($value['org_code'] != $branch_code){
                        unset($data_cache[$key]);
                }
            }
                $data_cache=array_values($data_cache);
        }



        $a = 3;
         foreach ($data_cache as $key => $value) {
                    $objPHPExcel->setActiveSheetIndex(0)
                        ->setCellValue('A'.$a, $value['name'])
                        ->setCellValue('B'.$a, $value['flagship_maintain'])
                        ->setCellValue('C'.$a, $value['flagship_demote'])
                        ->setCellValue('D'.$a, $value['flagship_observed'])
                        ->setCellValue('E'.$a, $value['shop_maintain'])
                        ->setCellValue('F'.$a, $value['shop_observed'])
                        ->setCellValue('G'.$a, $value['shop_demote'])
                        ->setCellValue('H'.$a, $value['member_standard'])
                        ->setCellValue('I'.$a, $value['member_apply'])
                        ->setCellValue('J'.$a, $value['member_apply_rate']);

            $a++;
        }
        $objPHPExcel->getActiveSheet()->getStyle('A1:J'.--$a)->getBorders()->getAllBorders()->setBorderStyle(\PHPExcel_Style_Border::BORDER_THIN);  //设置表格边框

        $objPHPExcel ->getActiveSheet(0)->setTitle("分公司考核结果");
         /*浏览器输出*/
            $filename = $file_name."分公司考核结果表_".time().".xls";
            header('Content-Type: application/vnd.ms-excel; charset=utf-8');
            header("Content-Disposition: attachment;filename=".$filename);
            header('Cache-Control: max-age=0');
            $objWriter = \PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel5');
            $objWriter->save('php://output');

    }
}


?>
