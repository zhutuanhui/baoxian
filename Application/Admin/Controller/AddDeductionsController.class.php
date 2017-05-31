<?php
namespace Admin\Controller;

use Common\Controller\AdminbaseController;


class AddDeductionsController extends AdminbaseController{
	//保单首页展示
	public function index(){

        if(!empty($_FILES['file_stu']['name'])){

            $this -> import();
        }
        $m = M('add_deductions');

        //获取当天凌晨时间戳
        $date1 = strtotime(date('Y-m-d'));

        $result = $m -> where("add_time > ".$date1) -> limit(10) -> order("id desc")-> select();
            foreach ($result as $key => $value) {
                $result[$key]['add_time'] = date('Y-m-d',$value['add_time']);
                $result[$key]['state'] = $v['state'] = 0? '加款':'扣款';
                $result[$key]['condition'] = $v['condition'] = 0? '失效':'有效';
            }

            $this -> assign('result',$result);
            $this -> display();

		}

    //新契约品质系数导入
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
                   $data ['salesman_number'] = $v[1];
                   $data ['state'] = $v [2] = '扣款'? 0 : 1;
                   $data ['condition'] = $v [3] = '失效'? 0 : 1;
                   $data ['add_time'] = time();
                   $data ['money'] = $v[5];
                   $data ['remark'] = $v[6];
                   $result = M ( 'add_deductions' )->add ( $data );
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