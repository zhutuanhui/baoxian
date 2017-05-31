<?php
namespace Admin\Controller;

use Common\Controller\AdminbaseController;


class InsuranceInputController extends AdminbaseController{
	//首页展示
	public function index(){

        if(!empty($_FILES['file_stu']['name'])){

            $this -> import();
        }
        $m = M('Insurance');

        //获取当天凌晨时间戳
        $date1 = strtotime(date('Y-m-d'));

        $result = $m -> where("add_time > ".$date1) -> limit(10) -> order("id desc")-> select();
            foreach ($result as $key => $value) {

                $result[$key]['add_time'] = date('Y-m-d',$value['add_time']);

            }

            $this -> assign('result',$result);
            $this -> display();

		}

    //保单导入
	public function import(){
        //包含excel类库
        header("Content-Typ:text/html;charset=utf-8");
        vendor('Excel.PHPExcel.IOFactory');
        //上传excel文件
        if(!empty( $_FILES ['file_stu']['name'])){

            $tmp_file = $_FILES ['file_stu'] ['tmp_name'];
            $file_types = explode ( ".", $_FILES ['file_stu'] ['name'] );
            $file_type = $file_types [count ( $file_types ) - 1];
        }
    
         /*判别是不是.xls文件，判别是不是excel文件*/
         if (strtolower ( $file_type ) != "xlsx" && strtolower ( $file_type ) != "xls")              
        {
              $this->error ( '不是Excel文件，重新上传' );
         }
        /*设置上传路径*/
         $savePath =  $_SERVER['DOCUMENT_ROOT'] . '/public/upfile/Excel/';
        /*以时间来命名上传的文件*/
         $str = date ('Ymdhis'); 
         $file_name = $str . "." . $file_type;
         /*是否上传成功*/
         if (!copy ( $tmp_file, $savePath . $file_name)) 
          {
              $this->error ('上传失败');
          }


        //读取导入excel文件到数据库
        $filename = $savePath.$file_name;

        $objReader = \PHPExcel_IOFactory::createReader('Excel2007');//use excel2003 和  2007 format

        $objPHPExcel = \PHPExcel_IOFactory::load($filename);//加载文件

        $sheetCount = $objPHPExcel->getSheetCount();//获取总的sheet数

        for($i=0; $i<$sheetCount; $i++){

            $data = $objPHPExcel->getSheet($i)->toArray();

            if(!empty($data)){
               foreach($data as $k => $v){

               if ($k != 0){
                   $data ['branch_shop_number'] = $v[0];
                   $data ['standard_shop_number'] = $v[1];
                   $data ['flag_shop_number'] = $v[2];
                   $data ['salesman_number'] = $v[3];
                   $data ['salesman_name'] = $v[4];
                   $data ['entry_date'] = $v[5];
                   $data ['entry_name'] = $v[6];
                   $data ['provider_id'] = $v[7];
                   $data ['provider_name'] = $v[8];
                   $data ['insured_number'] = $v[9];
                   $data ['policy_number'] = $v[10];
                   $data ['policy_status'] = $v[11] = "有效"? 1 : 2;
                   $data ['insurance_name'] = $v[12];
                   $data ['insurance_status'] = $v[13] = "主险"?1 : 2;
                   $data ['insurance_money'] = $v[14];
                   $data ['insurance_premium'] = $v[15];
                   $data ['payment_method'] = $v[16] = "支付宝"? 1 : 2;
                   $data ['salesman_name'] = $v[17];
                   $data ['policy_holder_name'] = $v[18];
                   $data ['policy_holder_card'] = $v[19];
                  // $data [''] = $v[20];//地址
                   $data ['policy_holder_telephone'] = $v[21];
                   $data ['insured_person_name'] = $v[22];
                   $data ['insured_person_certificate'] = $v[23] = "身份证"? 1 : 2;
                   $data ['insured_person_card'] = $v[24];
                   $data ['insured_person_telephone'] = $v[25];
                   $data ['insured_date'] = $v[26];
                   $data ['insured_date_star'] = $v[27];
                   $data ['customer_date'] = $v[28];
                   $data ['return_date'] = $v[29];
                   $data ['hesitate_date'] = $v[30];
                   $data ['surrender_date'] = $v[31];
                   $data ['pay_date'] = $v[32];
                   $data ['add_time'] = time();



                   $result = M('insurance')-> add($data);
                  
                 if (!$result) 
                 {
                      $this->error ( '导入数据库失败' );
                  }
                
                 }

            }
        
            
        }
            

        }
          

   
        







    }
}


?>