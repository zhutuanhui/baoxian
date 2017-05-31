<?php
namespace Admin\Controller;

use Common\Controller\AdminbaseController;


class InsuranceReController extends AdminbaseController{
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
         	$result[$key]['entry_date'] = date("Y-m-d",$value['entry_date']); 
         	$result[$key]['insured_date']=date('Y-m-d',$value['insured_date']);

         	$result[$key]['two_time'] = date("Y-m-d",$value['two_time']); 
         	$result[$key]['three_time'] = date("Y-m-d",$value['three_time']); 
         	$result[$key]['four_time'] = date("Y-m-d",$value['four_time']); 
         	$result[$key]['five_time'] = date("Y-m-d",$value['five_time']); 
			
         }
        // dump($province);
        $this -> assign('insurance',$result);
        $this -> display();
		}


	//保单删除
	public function del(){

		$id = I('post.id');


		$m = M('insuranceRe');

		$d = M('renew');

		$result = $m -> where("policy_number = $id") -> delete();

		$d -> where("insurance_num = $id") -> delete();

		if($result){
			echo json_encode(1);
		}else{
			echo json_encode(0);
		}
	}	

//	续期保单添加ok
	public function addOk(){
	if(IS_AJAX){

		$m = D('InsuranceRe');
		$d = M('renew');

		if (!$m->create()){
     	// 如果创建失败 表示验证没有通过 输出错误提示信息
    	exit($m->getError());
	}else{
	     // 验证通过 可以进行其他数据操作
	    $arr = I('post.');
	   
	    $result = $m -> add($arr);

	    $result1 = $d -> add($arr);

	    

 		if($result){
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
}


	
	
	//保单编辑
	//根据保单号编辑
	
	public function edit(){

		$id = I('get.id');


		if($id){

			$m = M('insurance_re');

			$result = $m -> join('LEFT JOIN renew on insurance_re.policy_number = renew.insurance_num') -> where('policy_number = '.$id) -> find();

				 // p($result);die;

		//将时间戳日期转化为年月日时分秒格式
    

         	

         	$result['surrender_date'] = date("Y-m-d",$value['surrender_date']);
         	$result['hesitate_date'] = date("Y-m-d",$value['hesitate_date']);
         	$result['customer_date'] = date("Y-m-d",$value['customer_date']);
         	
         	$result['insured_date_star'] = date("Y-m-d",$value['insured_date_star']);
         	$result['return_visit_date'] = date("Y-m-d",$value['return_visit_date']);   
         	$result['entry_date'] = date("Y-m-d",$value['entry_date']); 
         	$result['insured_date'] = date("Y-m-d",$value['insured_date']);


         	$result['two_time'] = date("Y-m-d",$value['two_time']); 
         	$result['three_time'] = date("Y-m-d",$value['three_time']); 
         	$result['four_time'] = date("Y-m-d",$value['four_time']); 
         	$result['five_time'] = date("Y-m-d",$value['five_time']);         	

       

			
			$this->assign('result',$result);
		}
		

			//	如果是AJAX提交修改修改结果
		if(IS_AJAX){

			$m = D('insurance_re');
			if (!$m->create()){
	     // 如果创建失败 表示验证没有通过 输出错误提示信息
	     		exit($m->getError());
		}else{

			$d = $m -> create();
			$where = array('policy_number' => $d['policy_number']); 
		     // 验证通过 可以进行其他数据操作
		     $result = $m -> join('left join renew on insurance_re.policy_number = renew.insurance_num') -> where($where) -> save();
		     if($result){	

		     		$this -> success('编辑成功','Insurance/index');
		     	
		     	}else{

		     		$this -> error('编辑失败','Insurance/index');
		     	}
			}
		}
	
		$this->display();

	}
	

}
?>