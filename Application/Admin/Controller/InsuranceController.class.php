<?php
namespace Admin\Controller;

use Common\Controller\AdminbaseController;


class InsuranceController extends AdminbaseController{
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
    	
    	//实例化地区数据
    	$district = M('district');
    	
        $insurance = M('insurance')
            -> where($where)
            -> select();
            
         //将时间戳日期转化为年月日时分秒格式
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

         	$province = $district -> where(array('id' => $value['province'])) -> field('name') -> find();
			$insurance[$k]['province']=$province['name'];
			$province = $district -> where(array('id' => $value['city'])) -> field('name') -> find();
			$insurance[$k]['city']=$province['name'];
			$province = $district -> where(array('id' => $value['town'])) -> field('name') -> find();
			$insurance[$k]['town']=$province['name'];
         }
        $this -> assign('insurance',$insurance);
        $this -> display();
		}


	//保单删除
	public function del(){

		$id = I('post.id');

		$m = M('insurance');

		$result = $m -> where("policy_number = $id") -> delete();

		if($result){
			echo json_encode(1);
		}else{
			echo json_encode(0);
		}
	}	

//	供应商添加ok
	public function addOk(){
	if(IS_AJAX){
		$m=D('Insurance');
		if (!$m->create()){
     // 如果创建失败 表示验证没有通过 输出错误提示信息
     exit($m->getError());
	}else{
	     // 验证通过 可以进行其他数据操作
	   
	     $result = $m->add();
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

	//保单添加
	public function add(){

		$result = district($level='1',$pid='0');
    	$this -> assign('province',$result); 	
 
		$this -> display();

	}
	//保单添加ok
	/*public function addOk(){

		if(IS_POST){
			
			$m = D('Insurance');


			if (!$m->create()){

	     // 如果创建失败 表示验证没有通过 输出错误提示信息
	     exit($m->getError());

		}else{
		     // 验证通过 可以进行其他数据操作
		   	
		     $result = $m->add();
		     if($result){
		     	$this -> success('添加成功','Insurance/index');
		     }else{
		     	$this -> error('添加失败','Insurance/add');
		     }
		}
	  }
	}*/
	
	
	//	地址三级联动返回json数据
	//	
	public function product2(){

		$pid = $_REQUEST['pid'];	
		$level = $_REQUEST['type'];
		$result = district($level,$pid);
		echo json_encode($result);
 
	}
	//保单编辑
	//根据保单号编辑
	
	public function edit(){

		$id = I('get.id');

		if($id){

			$m = M('Insurance');

			$result = $m -> where('policy_number = '.$id) -> find();
				// p($result);

		//将时间戳日期转化为年月日时分秒格式
    

         	$result['hesitation_end_date'] = date("Y-m-d",$value['hesitation_end_date']);
         	$result['surrender_date'] = date("Y-m-d",$value['surrender_date']);
         	$result['hesitate_date'] = date("Y-m-d ",$value['hesitate_date']);
         	$result['customer_date'] = date("Y-m-d ",$value['customer_date']);
         	$result['return_date'] = date("Y-m-d",$value['return_date']);
         	$result['return_visit_date'] = date("Y-m-d",$value['return_visit_date']);
         	$result['pay_date'] = date("Y-m-d ",$value['pay_date']);
         	$result['insured_date'] = date("Y-m-d ",$value['insured_date']);
         	$result['insured_date_star'] = date("Y-m-d ",$value['insured_date_star']);
         	$result['return_visit_date'] = date("Y-m-d ",$value['return_visit_date']);         	

        

	
			
			/*$result['provinces'] = M('district')->where('id='.$result['province'])->getField('name');
			$result['citys'] = M('district')->where('id='.$result['city'])->getField('name');
			$result['towns'] = M('district')->where('id='.$result['town'])->getField('name');*/
			
			$this->assign('result',$result);
		}

			//	如果是AJAX提交修改修改结果
		if(IS_AJAX){

			$m = D('Insurance');
			if (!$m->create()){
	     // 如果创建失败 表示验证没有通过 输出错误提示信息
	    	exit($m->getError());
		}else{

			$d = $m -> create();
			$where = array('policy_number' => $d['policy_number']); 
		     // 验证通过 可以进行其他数据操作
		     $result = $m -> where($where) -> save();
		     if($result){	

		     	$this -> success('编辑成功','Insurance/index');
		     	
		     	}else{

		     		$this -> error('编辑失败','Insurance/index');
		     	}
			}
		}
		//	地址三级联动
		$result=district($level='1',$pid='0');
	    $this->assign('province',$result); 	
		$this->display();

	}
	

}


?>