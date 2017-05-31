<?php
namespace Admin\Controller;
use Common\Controller\AdminbaseController;
class OrderController extends AdminbaseController
{
	//订单列表
    public function index()
    {
    	//根据查询条件得到相应的数据展现到订单管理页面
    	$options = I('post.');
    	$where = "";
    	if ($options['order_num']) {
			$where = array('ga.order_num' => $options['order_num']);
    	}
    	
    	if ($options['policy_holder_name']) {
			$where[] = array('ga.policy_holder_name' => $options['policy_holder_name']);
    	}

  

        //判断日期范围
        if ($options['create_time1']) {
            $where['_string'] .= '  create_time >= '.strtotime($options['create_time1']);
            if ($options['create_time2']) {
                $where['_string'].= ' AND create_time <='.strtotime($options['create_time2']);
            }
        }


     	if ($options['pay_status']) {
			$where[] = array('a.pay_status' => $options['pay_status']);
    	}

        $order = M('order_master')
            -> alias('a')
            -> join('left join __ORDER_SCHEDULE__ ga on a.order_num=ga.order_num')
            -> where($where)
            -> select();

        //将时间戳日期转化为年月日时分秒格式
         foreach ($order as $k => $value) {

            $order[$k]['create_time'] = date("Y-m-d H:i:s",$value['create_time']);  
            $order[$k]['payment_method'] = ($value['payment_method'] == 1?'支付宝':'微信');

            if($value['pay_status'] == 1){
                $order[$k]['pay_status'] = '已支付';
            }else if($value['pay_status'] == 2){
                $order[$k]['pay_status'] = '未支付';
            }else{
                $order[$k]['pay_status'] = '失效';
            }
                  

         }
        //print_r($order);
        $count=count($order);
        $this -> assign('count',$count);
        $this -> assign('order',$order);
        $this -> display();


    }
    //订单详情
    public function details(){
    	$order_num = I('get.');
    	$num = $order_num['order_num'];
        $order = M('order_master')
            -> alias('a')
            -> join('left join __ORDER_SCHEDULE__ ga on a.order_num=ga.order_num')
            -> where('a.order_num ='.$num)
            -> select();
        $this -> assign('order',$order);
        $this -> display();
    }
    //订单编辑
   /* public function edit(){
    	$order_num = I('get.');
    	$num = $order_num['order_num'];
    	echo $num;
    	$order = M('order_master')
            -> alias('a')
            -> join('left join __ORDER_SCHEDULE__ ga on a.order_num=ga.order_num')
            -> where('a.order_num ='.$num)
            -> find();
           echo  "<pre>";
        print_r($order);
        	echo "</pre>";
        $this -> assign('order',$order);
        $this -> display();
    }
    //订单编辑ok
    public function editOk(){
    	$num = I('post.order_num');
    	
    	//	如果是post提交修改修改结果
		if(IS_POST){
			$m = M('order_master');
			if (!$m->create()){
	     // 如果创建失败 表示验证没有通过 输出错误提示信息
	     	exit($m->getError());
		}else{
		     // 验证通过 可以进行其他数据操作	   
		     $result = $m->save();
		     if($result){
		     	$this->success('编辑成功','order/index');
		     }

    	}
    }
		
}*/

    //订单删除 
    public function delete(){  

    	$order_num = $_POST;
    	$where['order_num'] = $order_num['order_num'];
        $where['pay_status'] = 3;
        $result = M('order_master')  
                 -> where($where) -> delete();
        if($result){
         	echo 1;
         }   

      
    }  
} 

