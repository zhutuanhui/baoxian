<?php namespace Admin\Controller;
use Common\Controller\AdminbaseController;
class ClientController extends AdminbaseController
{
//		客户列表
		public function index(){
		$m=M('client');
			    	//根据查询条件得到相应的数据展现到保单管理页面
		if(IS_POST){
	    	$options = I('post.');
	    	$where = "";
	    	if ($options['c_name']) {
				$where = array('c_name' => $options['c_name']); 
	    	}
	    
	
	    	if ($options['phone']) {
				$where[] = array('phone' => $options['phone']);
	    	}
	     	if ($options['sales_code']) {
				$where[] = array('sales_code' => $options['sales_code']);
	    	}
	    	if ($options['cu_category']) {
				$where[] = array('cu_category' => $options['cu_category']);
	    	}
	    	
	        $insurance = $m
	            -> where($where)
	            -> select();
          
            

		}
			$result=$m->select();
			$result=isset($insurance) ? $insurance : $result;
			$this->assign('num',count($result));
			$this->assign('result',$result);
			$this->display();
		}
//		客户编辑
		public function edit(){
			if(IS_AJAX){
				$m=M('client');
				$data=I('post.');
				$data['birthday']=implode('-',$data['birthday']);
	    		$result = $m->save($data);
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
			$id=I('get.id');
			if($id){
				$m=M('client');
				$result=$m->where('c_id='.$id)->find();
				$result['birthday']=explode('-',$result['birthday']);
				
				$this->assign('id',$id);
				$this->assign('result',$result);
			}
			
		$this->display();
		}
//删除指定客户
	public function del(){
		$id=I('post.id');
		$m=M('Client');
		$result=$m->delete($id);
		if($result){
			echo json_encode(1);
		}else{
			echo json_encode(0);
		}
	}	
		
		
		
		
		
		
		
		
		
		
		
		
		
		
}
	
	
	
?>