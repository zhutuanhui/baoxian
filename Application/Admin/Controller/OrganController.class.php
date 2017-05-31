<?php namespace Admin\Controller;
use Common\Controller\AdminbaseController;
class OrganController extends AdminbaseController
{
	public function __construct() {
		parent::__construct();
		$this->member =M('Member');
		$this->insurance =M('insurance');
		$this->shop_apply=M('shop_apply');
		$this->organization=M('organization');
	}
//	店铺申请列表
	public function apply(){
	$m=$this->shop_apply;
	$result=$m
	->where('is_del=0')
	->select();
	if(IS_POST){
	    	$options = I('post.');
	    	$where = "";
	    	if ($options['start_time'] && $options['end_time']) {
				$where = array('start_time' =>array('egt',strtotime($options['start_time'])),'end_time'=>array('elt',strtotime($options['end_time'])) ); 
	    	}
	    	if ($options['member_number']) {
				$where[] = array('member_number' => $options['member_number']);
	    	}
	     	if ($options['shop_name']) {
				$where[] = array('shop_name' => $options['shop_name']);
	    	}
	    	if ($options['branch_result']) {
	    		switch($options['branch_result'])
	    		{
	    			case 3:
	    			$map['branch_result'] =0;
					$map['head_result'] = 0;
					$map['_logic'] = 'OR';
	    			$where[] =$map;
	    			break; 
	    			case 1:
	    			$map['branch_result'] =1;
					$map['head_result'] = 1;
					$map['_logic'] = 'OR';
	    			$where[] =$map;
	    			break;
	    			case 2:
	    			$where[] =array('prepare_result' =>1);
	    			break;
	    		}
	    	}
	        $insurance = $m
	            -> where($where)
	            -> select();
		}
	$result=isset($insurance) ? $insurance : $result;
	$this->assign('result',$result);
	$this->assign('num',count($result));
	$this->display();
	}

//	编辑申请结果
	public function edit(){
		if(IS_AJAX){
				$m=$this->shop_apply;
				$this->organization->startTrans();
				$this->member->startTrans();
				$this->insurance->startTrans();
				M('insurance_re')->startTrans();
				$data=I('post.');
				$data['create_apply']=strtotime($data['create_apply']);
				$data['start_time']=strtotime($data['start_time']);
				$data['end_time']=strtotime($data['end_time']);
//			  判断分公司总公司意见是否全部通过，如果全部通过且机构添加字段状态为未添加，则把店铺代码，开始筹备日期结束日期添加到机构表，把机构表店铺状态改为1
				if($data['branch_result']==2 && $data['head_result']==2 && $data['prepare_result']==0)
				{					
					$num=$data['member_number'];				
					$m_data=$m->join('member ON shop_apply.member_number = member.m_number')
							  ->join('member_profile ON shop_apply.member_number = member_profile.m_number')
							  ->where('member.m_number ='.$num.'&&'.$num.'= member_profile.m_number')	
							  ->find();
					$o_data['examine_standard']=get_address_cate($m_data['province']);
							
					$o_data['name']=$data['shop_name'];
					$o_data['org_code']=$data['member_shop'];
					$o_data['start_time']=$data['start_time'];
					$o_data['end_time']=$data['end_time'];
					$o_data['check_status']=1;
					$o_data['flagship_code']=$m_data['flagship_number'];
					
					$o_data['branch_shop_code']=$m_data['branch_shop_number'];
					$o_data['level']=3;
					$o_data['province_id']=$m_data['province'];
					$o_data['city_id']=$m_data['city'];
					$o_data['district_id']=$m_data['district'];
					$o_data['status']=0;
					$o_data['telphone']=$m_data['mobile'];
					$o_data['address']=$m_data['address'];
					$o_data['email']=$m_data['email'];
					$o_data['principal_number']=$m_data['m_number'];
					$o_data['create_time']=time();
//					把机构信息添加到机构表
					$om=$this->organization->add($o_data);
					if($om){					
						$data['prepare_result']=1;
					}
//				把店铺申请表添加状态改为1
	    		$result = $m->save($data);
//					查找所有该业务员的邀请会员代码
				$childerarr=$this->getchildrenmember($num);
				foreach($childerarr as $k=>$v){
//					修改业务员所属机构代码
					$data['shop_number']=$data['member_shop'];
					$md=$this->member->where('m_number='.$v)->save($data);
//					根据业务员代码修改首期保单所属机构代码
					$datace['standard_shop_number']=$data['member_shop'];
					$id=$this->insurance->where('salesman_number='.$v)->save($datace);
 //					修改续期保单所属机构代码
					$datare['standard_shop_number']=$data['member_shop'];
					$sd=M('insurance_re')->where('salesman_number='.$v)->save($datare);
				}
				}
				if($result && $md && $id && $sd){
//				ajax返回数据页面跳转
					$this->organization->commit();//提交事务成功
					$this->member->commit();//提交事务成功
					$this->insurance->commit();//提交事务成功
					M('insurance_re')->commit();//提交事务成功
                	$data['status']  = 1;
               	 	$this->ajaxReturn($data);
                	exit;
            	}else{
            		$this->organization->rollback();//事务有错回滚
					$this->member->rollback();//事务有错回滚
					$this->insurance->rollback();//事务有错回滚
					M('insurance_re')->rollback();//事务有错回滚
               		$data['status']  = 0;
                	$this->ajaxReturn($data);
                	exit;
          	  }
			}
		$id=I('get.id');
		if($id){
			$m=$this->shop_apply;
			$result=$m->where('shop_apply_id='.$id)->find();
		$this->assign('id',$id);
		$this->assign('result',$result);
		}
		$this->display();
	}
	//删除店铺申请
	public function del(){   
		$id=I('post.id');
		$m=$this->organization;
		$data['check_status'] = 0;
		$result=$m->where('org_id='.$id)->save($data);
		if($result){
			
			echo json_encode(1);
		}else{
			echo json_encode(0);
		}
	}
//	机构列表
	public function index(){
//		判断是否是分公司，如果是分公司只显示当前分公司旗下店铺
	$id=$_SESSION['organization_id'];
	if($id!=0){
		$where=array('branch_shop_code'=>$id);
		$where[]=array('check_status'=>1);
	}else{
		$where[]=array('check_status'=>1);
	}
	$result=$this->organization->where($where)->select();
	foreach($result as $k=>$v){
//		标准店
		if($result[$k]['level']==3){
			$result[$k]['suoshu_code']=$result[$k]['flagship_code'];
			$result[$k]['suoshu_name']=$this->organization->where('org_code='.$result[$k]['flagship_code'])->getField('name');
//		如果店铺代码不等于旗舰店代码等于分公司代码则该店为分公司，所属机构为空
		}elseif($result[$k]['level']==1){
			$result[$k]['suoshu_code']='--';
			$result[$k]['suoshu_name']='--';
		
//		为旗舰店，所属机构为分公司
		}else{
			$result[$k]['suoshu_code']=$result[$k]['branch_shop_code'];
			$result[$k]['suoshu_name']=$this->organization->where('org_code='.$result[$k]['branch_shop_code'])->getField('name');
		}
	}
	if(IS_POST){
	    	$options = I('post.');
	    	$where = "";
	    	if ($options['flagship_code']) {
				$where= array('flagship_code' => $options['flagship_code']);
	    	}
	    	if ($options['branch_shop_code']) {
				$where= array('branch_shop_code' => $options['branch_shop_code']);
	    	}
	
	    	if ($options['shop_name']) {
				$where[] = array('org_code' => $options['shop_name']);
	    	}
	    	if ($options['branch_result']) {
	    			$where[] = array('level' => $options['branch_result']);    		
	    	}
	    	if($id!=0){
			$where=array('branch_shop_code'=>$id);
			$where[]=array('check_status'=>1);
			}else{
				$where[]=array('check_status'=>1);
			}
	        $insurance = $this->organization
	            -> where($where)
	            -> select();
		}
	$result=isset($insurance) ? $insurance : $result;
	$this->assign('result',$result);
	$this->display();
	}
//	添加机构
	public function addOrgan(){
		if(IS_AJAX){
		$post=I('post.');
		$m=$this->member;
//		判断会员表中是否有该业务员代码
		$result=$m->where('m_number='.$post['principal_number'])->count();
		if($result==1){
//			判断会员表中该业务员旗舰店标准店代码是否为空，为空则为分公司
			$resultq=$m->where('m_number='.$post['principal_number'])->Field('flagship_number,shop_number')->find();
//			判断机构表中是否已存在该业务员 如有则为重复添加
			$resulto=$this->organization->where('principal_number='.$post['principal_number'])->count();
			if((!$resultq['flagship_number'] && !$resultq['shop_number']) && $resulto<1){
				$num=$post['principal_number'];
				$mm=$this->member
			 	->join('member_profile ON member.m_number = member_profile.m_number')
			    ->where('member.m_number ='.$num)
				->find();
			$add['org_code']=$mm['my_shop_number'];
			$add['branch_shop_code']=$mm['my_shop_number'];
			$add['name']=$post['name'];
			$add['level']=1;
			$add['introduce']=$post['introduce'];
			$add['province_id']=$mm['province'];
			$add['city_id']=$mm['city'];
			$add['district_id']=$mm['district'];
			$add['address']=$mm['address'];
			$add['status']=1;
			$add['telphone']=$mm['mobile'];
			$add['email']=$mm['email'];
			$add['principal_number']=$post['principal_number'];
			$add['check_status']=1;
			$add['create_time']=time();	
			$adds['shop_code']=$mm['my_shop_number'];
			$adds['shop_name']=$add['name'];
//			添加机构目标表
			$oms=M('organizational_goals')->add($adds);
			//			添加机构表
			$om=$this->organization->add($add);
					if($om && $oms){
						$data['data']=2;
						$data['message']='添加成功';
					}
			}else{
				$data['data']=3;
				$data['message']='业务员代码错误';
			}
		}else{
			$data['data']=1;
			$data['message']='该业务员不存在';
		}
		$this->ajaxReturn($data);
		}
	
		$this->display();
	}
//	机构编辑
	public function editOrgan(){
		$id=I('get.id');
		if($id){
			
			$result=$this->organization->field('org_id,org_code,name,flagship_code,branch_shop_code,telphone,address,create_time,start_time,introduce')->where('org_id='.$id)->find();
		}
		if(IS_AJAX){
			$data=I('post.');
			$data['start_time']=strtotime($data['start_time']);
			$result = $this->organization->save($data);
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
		$this->assign('result',$result);
		$this->display();
		
	}
	public function targe(){
		$result=M('organizational_goals')->select();
		if(IS_POST){
	    	$options = I('post.');
	    	$where = "";
	    	if ($options['shop_name']) {
				$where['shop_name']= array('like','%'.$options['shop_name'].'%');
	    	}
	        $insurance =M('organizational_goals')
	            -> where($where)
	            -> select();     
		}
		$result=isset($insurance) ? $insurance : $result;
		$this->assign('result',$result);
		$this->display();
	}
	public function editTarge(){
		$id=I('get.id');
		if($id){
		$result=M('organizational_goals')->where('id='.$id)->find();	
		}
		if(IS_AJAX){
			$post=I('post.');
			$result = M('organizational_goals')->save($post);
				if($result){
//				ajax返回数据页面跳转
                	$data['status']  = 1;
               	 	$this->ajaxReturn($data);
                	exit;
            	}else{
               		$data['status']  = 0;
                	$this->ajaxReturn($data);
                	exit;
          	  }
		}
		$this->assign('result',$result);
		$this->display();
	}
//	保监报送
	public function submitted(){
		if(IS_POST){
			$m=$this->insurance;
			$post=I('post.');
			$where="";
//			如果只选择时间按分公司为单位报送

			if(!$post['shop_code'] && !$post['shop_n'] && $post['start_time']){
		
		$code='branch_shop_number';
//			如果选择时间跟机构等级按该等级为单位报送
	}elseif(!$post['shop_code'] && $post['shop_n'] && $post['start_time']){
		
				switch($post['shop_n'])
	    		{
	    			case 1:
	    			$code = 'branch_shop_number';
	    			break; 
	    			case 2:
	    			$code ='flag_shop_number';
	    			break;
	    			case 3:
	    			$code ='standard_shop_number';
	    			break;
	    		}
	}elseif($post['shop_code'] && $post['shop_n'] && $post['start_time']){
		
				switch($post['shop_n'])
	    		{
	    			case 1:
	    			$code = 'branch_shop_number';
	    			break; 
	    			case 2:
	    			$code ='flag_shop_number';
	    			break;
	    			case 3:
	    			$code ='standard_shop_number';
	    			break;
	    		}
	    $where[]=array('organization.org_code'=>$post['shop_code']);
//	    如果选择日期跟店铺编码则报送该店铺为单位
	}elseif($post['shop_code'] && !$post['shop_n'] && $post['start_time']){
		
//		到机构表取到该机构是什么等级
		$in_level=$this->organization->where('org_code='.$post['shop_code'])->getField('level');
		switch($in_level)
	    		{
	    			case 1:
	    			$code = 'branch_shop_number';
	    			break; 
	    			case 2:
	    			$code ='flag_shop_number';
	    			break;
	    			case 3:
	    			$code ='standard_shop_number';
	    			break;
	    		}
	    $where[]=array('organization.org_code'=>$post['shop_code']);
	}
	////				选择任意一个时间返回本月的起止时间戳
				$time=$this->SetTime($post['start_time']);
				$where['insurance.insured_date']=array(array('gt',$time['stime']),array('lt',$time['etime']) );
				
				$num=$m->field($code.',sum(insurance_premium),organization.name,product.unsales_category_id')
				->join('product ON insurance.product_id = product.id')
				->join('organization ON insurance.'.$code.'= organization.org_code')
				->group('insurance.'.$code.',organization.name,product.unsales_category_id')
				->where($where)->select();
				
//				把相同机构的数据合并成一条数据
				$result=self::array_group_by($num,$code);
				foreach($result as $k=>$v){
						$arr[$k]['branch_shop_number'] = $v[0][$code]; 
						$arr[$k]['name']=$v[0]['name'];
						$arr[$k]['unsales_category_id']=$v[0]['unsales_category_id'];
						$arr[$k]['unsales_category_id1']=$v[1]['unsales_category_id'];
						$arr[$k]['insurance_premium']=$v[0]['sum(insurance_premium)'];
						$arr[$k]['insurance_premium1']=$v[1]['sum(insurance_premium)'];	
				}
				
		$this->assign('result',$arr);
//		把保单日期加入数据内
	
			
		$time=$post['start_time'];
		S('time',$time,1200);
		S('condition',$arr,1200);	
		}
		
		$this->display();
	}
		/*
	*  功能：根据给定时间计算筹备起止时间
	*  时间：2017-05-15
	*  作者：lzt
	*/
	public function SetTime($time){
		$syear = substr($time, 0, 4);
		$smonth = substr($time, 5,7);
		//计算开始时间
		//mktime(时,分,秒,月,天,年,is_dst);
		$setime['stime'] = mktime(0,0,0,$smonth,1,$syear);
		//计算结束时间
		$emonth = $smonth+1;
		if($emonth > 12 ){
			$emonth = $emonth - 12;
			$eyear = $syear +1;
		}else{
			$eyear = $syear;
		}
		$setime['etime'] = mktime(0,0,0,$emonth,0,$eyear);
		return $setime;
	}
//	处理保单报送数据分组
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
            foreach ($grouped as $key => $value) {
                $parms = array_merge([$value], array_slice($args, 2, func_num_args()));
                $grouped[$key] = call_user_func_array('array_group_by', $parms);
            }
        }
        return $grouped;
    }
    public function export(){
    	header("Content-Typ:text/html;charset=utf-8");
        vendor('Excel.PHPExcel');
        vendor('Excel.PHPExcel.IOFactory');
    	$parameter = S('condition');
    	$time = S('time');
//  	p($parameter);die;
        $objPHPExcel = new \PHPExcel();
        $objPHPExcel->getActiveSheet()->setCellValue('A1', "保单日期");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('B1', "机构代码");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('C1', "机构名称");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('D1', "人身险");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('E1', "财险");//设置列的值

        if($parameter){
            $i=2;
            foreach ($parameter as $key => $value) {
                $objPHPExcel->setActiveSheetIndex(0)
                    //Excel的第A列，uid是你查出数组的键值，下面以此类推
                    ->setCellValue('A'.$i, $time)
                    ->setCellValue('B'.$i, $value['branch_shop_number'])
                    ->setCellValue('C'.$i, $value['name'])
                    ->setCellValue('D'.$i, $value['insurance_premium'])
                    ->setCellValue('E'.$i, $value['insurance_premium1']);
                $i++;
            }
        }

        $objPHPExcel->getActiveSheet(0)->setTitle('保单报表');
        // $objPHPExcel->setActiveSheetIndex(0);
        header('Content-Type:application/vnd.ms-excel');
        header("Content-Disposition:attachment;filename=".$time."保监会报表.xls");
        header('Cache-Control: max-age=0');
        $objWriter = \PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel5');

        $objWriter->save('php://output');
        //清空缓存
        S('condition',null);
        S('time',null);
    }
// 	获取所有该业务员邀请的业务员代码（除已经是标准店的会员）
//$m_member 业务员代码
    public function getchildrenmember($m_member){
    	$member=$this->member->where('recommend_member_id='.$m_member)->getField('m_number',true);
    	$result=array();
    	if($member){
    		foreach($member as $k=>$v){
//  			该业务员店职级如果小于2则为普通会员则追加数组
    	$members=$this->member->where('m_number='.$v)->getField('member_level');  	
    	if($members<2){
    		$result[]=$v;
    		
    	}
    	$result=array_merge($result,$this->getchildrenmember($v));
    		}
    	}
    	return $result;
    }
}

?>