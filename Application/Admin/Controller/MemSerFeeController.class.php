<?php
namespace Admin\Controller;
use Common\Controller\AdminbaseController;
class MemSerFeeController extends AdminbaseController
{
	public function __construct() {
		parent::__construct();
		$this->member =D('Member');
		$this->profile =D('member_profile');
		$this->serfee =D('service_fee_calculation');
		$this->serfeepo =D('service_fee_policy');
	}
	/*
	*  功能：服务费分公司列表
	*  时间：2017-05-22
	*  作者：lzt
	*/
	public function index(){
			//根据查询条件不同显示列表
			$where['level'] = 1;
			$mation = M('organization')->where($where)->field('org_id,org_code,name')->select();
			$this->assign('info',$mation);
			$this->display();
	}

	/*
    *  功能：会员服务费计算（总）
    *  时间：2017-05-22
    *  作者：lzt
    */
	public function Calculate(){
		$post = $_POST;
		//查询服务费比例
		$FeeCon = M('service_fee_config')->where('id = 1')->find();
		//查询分公司旗下所有会员，并按照职级与店铺状态分组返回数据 upt普通，uzs资深，bzc标准筹备，bzj标准经营，bzg标准观察，qjc旗舰筹备，qjj旗舰经营，qjg旗舰观察
		$post['code'] = '100003';
		$minfo =$this->GetUnderNumber($post['code']);
		//dump($minfo);  die;
		//普通业务员服务费计算
		if($minfo['upt']){
			//首期寿险服务费
			$initial = $this->initial($minfo['upt'],$FeeCon['member'],$post['code'],'upt');
			dump($initial);
			//续期寿险服务费
			$renewal = $this->renewal($minfo['upt'],$post['code'],'upt');
			dump($renewal);
			//非寿险服务费
			$nonlife = $this->nonlife($minfo['upt'],$post['code'],'upt');
			//dump($nonlife);
			//整合会员的服务费
			$upt = array();
			foreach ($initial as $k=>$v){
				$upt[$k]['number'] = $v['number'];
				$upt[$k]['initial'] = $v['initial'];
				$upt[$k]['renewal'] = $renewal[$k]['renewal'];
				$upt[$k]['nonli'] = $nonlife[$k]['nonli'];
			}
		  //dump($upt);
			die;
			//计税（首期，续期，非寿）
		}else{
			$upt = 1;
		}
		//资深业务员服务费计算
		if($minfo['uzs']){
			//首期寿险服务费
			$initial = $this->initial();
			//续期寿险服务费
			$renewal = $this->renewal();
			//非寿险服务费
			$nonlife = $this->nonlife();
			//计税（首期，续期，非寿）
		}else{
			$uzs = 1;
		}
		//标准店筹备期服务费计算
		if($minfo['bzc']){
			$bzc = $this->bzccount();
			//首期寿险服务费(线上百分比+线下百分比)
			//续期寿险服务费
			//非寿险服务费
			//管理利益
			//育成利益
			//计税（首期，续期，非寿，管理，育成）
		}else{
			$bzc = 1;
		}
		//标准店经营期服务费计算
		if($minfo['bzj']){
			$bzj = $this->bzjcount();
			//首期寿险服务费（线上百分比）
			//首期寿险服务费（线下百分比）
			//续期寿险服务费
			//非寿险服务费
			//管理利益
			//育成利益
			//计税（首期（线上），非寿）
		}else{
			$bzj = 1;
		}
		//标准店观察期服务费计算
		if($minfo['bzg']){
			$bzg = $this->bzgcount();
			//首期寿险服务费（线上百分比）
			//首期寿险服务费（线下百分比）
			//续期寿险服务费
			//非寿险服务费
			//计税（首期（线上），非寿）
		}else{
			$bzg = 1;
		}
		//旗舰店筹备期服务费计算
		if($minfo['qjc']){
			$qjc = $this->qjccount();
			//首期寿险服务费（团队）
			//续期寿险服务费（个人）
			//非寿险服务费（个人）
			//计税（首期，续期，非寿）
		}else{
			$qjc = 1;
		}
		//旗舰标准店经营期服务费计算
		if($minfo['qjj']){
			$qjj = $this->qjjcount();
			//首期寿险服务费（团队）
			//续期寿险服务费（个人）
			//非寿险服务费（个人）
			//计税（非寿）
		}else{
			$qjj = 1;
		}
		//旗舰店观察期服务费计算
		if($minfo['qjg']){
			//旗舰店观察期与标准店经营期相同
			$qjg = $this->qjgcount();
			//首期寿险服务费（线上百分比）
			//首期寿险服务费（线下百分比）
			//续期寿险服务费
			//非寿险服务费
			//管理利益
			//育成利益
			//计税（首期（线上），非寿）
		}else{
			$qjg = 1;
		}
		//dump($minfo);
		die;
		//根据会员代码计算首期服务费
		//根据会员代码计算续期服务费
		//根据会员代码计算非寿险服务费
		//根据会员代码查询其他加扣款

	}
	/*
	*  功能：续期服务费计算
	*  时间：2017-05-26
	*  作者：lzt
	*/
	public function renewal($member,$code,$type){
		//dump($member);
		//查询相关续期保单并对保单分类 13个月 //25个月。。。。
		//判断缓存是否存在
		$life = "renewal_service_".$code."_".$type;
		if(S($life)){
			$insu_re = S($life);
		}else{
			//查询业务员所有有效保单的价值保费
			$insu_re = $this->getinsure($member);
			S($life,$insu_re,3600);
		}
		//dump($insu_re);
		//查询续期品质系数
		$where['m_number'] = array('in',$member);  //业务员代码
		$coeffic = M('personal_coefficient')->where($where)->getField('m_number,coefficient',true);
	//	dump($coeffic);
		//计算服务费
		$renewal = array();
		foreach ($insu_re as $k=>$v){
			//13个月服务费计算
			foreach ($v['two']  as $kt=>$vt){
				if(isset($renewal[$k])){
					$renewal[$k]['renewal'] += $vt['insurance_premium']*$vt['renewal_ratio']*$coeffic[$k];
				}else{
					$renewal[$k]['number'] = $k;
					$renewal[$k]['renewal'] = $vt['insurance_premium']*$vt['renewal_ratio']*$coeffic[$k];
				}
			}
			//其他月份服务费计算
			foreach ($v['other']  as $ko=>$vo){
				if(isset($renewal[$k])){
					$renewal[$k]['renewal'] += $vo['insurance_premium']*$vo['renewal_ratio'];
				}else{
					$renewal[$k]['number'] = $k;
					$renewal[$k]['renewal'] = $vo['insurance_premium']*$vo['renewal_ratio'];
				}
			}
		}
		//dump($renewal);
		return $renewal;

	}
	/*
	*  功能：查询相关续期保单并对保单分类 13个月 //25个月。。。。
	*  时间：2017-05-26
	*  作者：lzt
	*/
	public function getinsure($member){
		$time = $this->get_time();
	//	dump($member);
		$where['a.salesman_number'] = array('in',$member);  //业务员代码
		$where['a.policy_status'] = 1; //保单状态有效
		$se_time['0'] = $time['start_time'];
		$se_time['1'] = $time['end_time'];
		$where['b.two_time|b.three_time|b.four_time|b.five_time'] = array('between',$se_time);  //缴费日期
		$where['b.two_state|b.three_state|b.four_state|b.five_state'] = 1;  //缴费状态
		$insurance_re=M("insurance_re");
		$ance_re = $insurance_re->alias('a')->where($where)
			->join('renew as b on a.policy_number = b.insurance_num ','left')
			->field('a.insurance_premium,a.policy_number,a.salesman_number,a.product_id,a.payment_limit,b.renew_count')->select();
		//dump($ance_re);
		//dump(11111111111);
		if($ance_re){
			$proid =array();
			foreach ($ance_re as $k=>$v){
				//统计产品
				$proid[] = $v['product_id'];
			}
			//dump($res);
			//产品id去重
			$prodid = array_unique($proid);
			//dump($prodid);
		//	dump(222222222222222222);
			$pwhere['product_id'] = array('in',$prodid);  //业务员代码
			$pwhere['renewal_type'] = 1;  //续期类型，1=>业务员，2=>供应商
			$settlement =M('settlement_renewal_contract')->where($pwhere)->field('product_id,length_of_renewal,payment_period,length_of_renewal,renewal_ratio')->select();
			//dump($settlement);
			//dump(33333333333333);
			//组合服务保单与服务费率
			$ance = array();
			foreach ($ance_re as $k =>$v){
				foreach ($settlement as $ka=>$va){
					if(($v['product_id'] == $va['product_id'])&&($v['payment_limit'] == $va['payment_period'])&&($v['renew_count'] == ($va['length_of_renewal']+1))){
						$ance[$v['policy_number']] = $v;
						$ance[$v['policy_number']]['renewal_ratio'] = $va['renewal_ratio'];
					}
				}
			}
			//dump($ance);
			//保单拆分13个月和其他月份
			$res = array();
			foreach ($ance as $kb =>$vb){
					if($vb['renew_count'] == 2 ){
						$res[$vb['salesman_number']]['two'][] = $vb;
					}else{
						$res[$vb['salesman_number']]['other'][] = $vb;
					}
				}
			}
		//dump($res);
		return $res;
	}





	/*
    *  功能：非寿险服务费计算
    *  时间：2017-05-24
    *  作者：lzt
    */
	public function nonlife($member,$code,$type){
		$time = $this->get_time();
		//dump($time);
		//判断缓存是否存在
		$life = "nonlife_service_".$code."_".$type;
		if(S($life)){
			$nonli = S($life);
		}else{
			//查询业务员所有非寿险保单
			$insurance=M("insurance");
			$where['a.salesman_number'] = array('in',$member); //业务员
			$where['a.policy_status'] = 1; //保单状态有效
			$where['a.insurance_type'] = array('in',"2,3"); //非寿险
			$se_time['0'] = $time['start_time'];
			$se_time['1'] = $time['end_time'];
			$where['a.insured_date'] = array('between',$se_time); //承保日期
			$nonli = $insurance->alias('a')->where($where)
				->join('product as b on a.product_id = b.id ','left')
				->field('a.salesman_number,a.policy_number,a.insurance_premium,b.commission_rate')->select();
			//存缓存
			S($life,$nonli,3600);
		}
		//非寿险服务费计算
		$count =array();
		foreach ($nonli as $k=>$v){
			if(!isset($count[$v['salesman_number']])){
				$count[$v['salesman_number']]['number'] = $v['salesman_number']; //业务员代码
				$count[$v['salesman_number']]['nonli'] = $v['insurance_premium']*$v['commission_rate']; //非寿险服务费;
			}else{
				$count[$v['salesman_number']]['nonli'] += $v['insurance_premium']*$v['commission_rate']; //非寿险服务费
			}
		}
		return $count;
	}
	/*
    *  功能：首期寿险服务费计算
    *  时间：2017-05-23
    *  作者：lzt
    */
	public function initial($member,$ratio,$code,$type){
		//查询新契约品质系数
		//dump($member);
		$where['m_number'] = array('in',$member);
		$contract = M('new_contract_coefficient')->where($where)->getField('m_number,new_cont_cone',true);
		//判断缓存是否存在
		$life = "initial_service_".$code."_".$type;
		if(S($life)){
			$insurance = S($life);
		}else{
			//查询业务员所有有效保单的价值保费
			$insurance = $this->GetValPre($member);
			S($life,$insurance,3600);
		}

		//组装数组
		$count =array();
		foreach ($insurance as $k=>$v){
			if(!isset($count[$v['salesman_number']])){
				$count[$v['salesman_number']]['number'] = $v['salesman_number']; //业务员代码
				$count[$v['salesman_number']]['premium'] = floatval($v['value_premium']); //累计有效价值保费;
				$count[$v['salesman_number']]['contract'] = floatval($contract[$v['salesman_number']]); //新契约品质系数
			}else{
				$count[$v['salesman_number']]['premium'] += $v['value_premium']; //累计有效价值保费
			}
		}
		//dump($count);
		//计算业务员首期寿险服务费
		//dump($ratio);
		$initial_service = array();
		foreach ($count as $k=>$v){
			$initial_service[$k]['number'] =$v['number'];
			$initial_service[$k]['initial'] =$v['premium']*$v['contract']*$ratio;
		}
		//dump($initial_service);
		return $initial_service;
	}

	/*
	*  功能：查询业务员所有有效保单的价值保费
	*  时间：2017-05-23
	*  作者：lzt
	*/
	public function GetValPre($member){
		//dump($member);
		//获取时间节点
		$time = $this->get_time();
	//dump($time);
		$insurance=M("insurance");
		//正常保单统计---------------------------------------------------------------------------------------------------
		$nowhere['salesman_number'] = array('in',$member); //业务员
		$nowhere['policy_status'] = 1; //保单状态有效
		$nowhere['insurance_type'] = 1; //寿险
		$se_time['0'] = $time['start_time'];
		$se_time['1'] = $time['end_time'];
		$nowhere['insured_date'] = array('between',$se_time); //承保日期
		$nowhere['return_date'] = array('lt',$time['receipt_time']); //回执日期
		$nowhere['return_visit_date'] = array('lt',$time['return_time']); //回访日期
		$normal = $insurance->where($nowhere)->field('salesman_number,policy_number,value_premium')->select();
		//dump($normal);
		//跨月回执保单统计-----------------------------------------------------------------------------------------------
		$recwhere['salesman_number'] = array('in',$member); //业务员
		$recwhere['policy_status'] = 1; //保单状态有效
		$recwhere['insurance_type'] = 1; //寿险
		$recwhere['insured_date'] = array('lt',$time['start_time']); //承保日期
		$receipt_time['0'] = $time['next_receipt_start_time'];
		$receipt_time['1'] = $time['next_receipt_end_time'];
		$recwhere['return_date'] = array('between',$receipt_time); //回执日期
		$recwhere['return_visit_date'] = array('lt',$time['return_time']); //回访日期
		$receipt = $insurance->where($recwhere)->field('salesman_number,policy_number,value_premium')->select();
		//dump($receipt);
		//跨越回访保单统计-----------------------------------------------------------------------------------------------
		$retwhere['salesman_number'] = array('in',$member); //业务员
		$retwhere['policy_status'] = 1; //保单状态有效
		$retwhere['insurance_type'] = 1; //寿险
		$retwhere['insured_date'] = array('lt',$time['start_time']); //承保日期
		$retwhere['return_date'] = array('lt',$time['receipt_time']); //回执日期
		$return_time['0'] = $time['next_return_start_time'];
		$return_time['1'] = $time['next_return_end_time'];
		$retwhere['return_visit_date'] = array('between',$return_time); //回访日期
		$return = $insurance->where($retwhere)->field('salesman_number,policy_number,value_premium')->select();
		//dump($return);
		//保单去重
		if($receipt&&$return){
			//dump(11111111111);
			$receiptturn =$this->insurance_merge($receipt,$return);
		//	dump($receiptturn);
		}elseif ($receipt){
			$receiptturn = $receipt;
		}elseif ($return){
			$receiptturn = $return;
		}
		//合并保单
		$insur = array_merge($normal,$receiptturn);
		//dump($insur);
		return $insur;
		//返回数据
	}

	/*
	*  功能：保单合并去重复
	*  时间：2017-05-24
	*  作者：lzt
	*/
	public function insurance_merge($receipt,$return){
		//合并数组
		$receiptturn = array_merge($receipt,$return);
		//dump($receiptturn);
		//去重
		$item = array();
		$item2 = array();
		foreach ($receiptturn as $k =>$v){
			if(!isset($item[$v['policy_number']])){
				$item[$v['policy_number']]=$v;
			}
		}
		foreach ($item as $k1=>$v1){
			array_push($item2,$v1);
		}
		//dump($item2);
		return $item2;
	}
	/*
	*  功能：保单测试数据追加
	*  时间：2017-05-23
	*  作者：
	*/
	public function addceshi(){
//		[0] => string(10) "7519170512"
//		[1] => string(10) "7521170516"
//		[2] => string(10) "7523170516"
//		[3] => string(10) "7526170516"
		$data['branch_shop_number'] = '100003';  //分公司代码
		$data['standard_shop_number'] = '7518170516';  //标准店代码
		$data['flag_shop_number'] = '7518170516';  //旗舰店
		$data['salesman_number'] = '7519170512';  //业务员代码
		$data['policy_number'] = '737373';  //保单号
		$data['policy_status'] = '1';  //保单状态	1=>有效	2=>失效
		$data['insurance_type'] = '2';  //保单类型 1=>寿险  2=>非寿险(不含车险)  3=>车险
		$data['insurance_money'] = '1000';  //保额
		$data['value_premium'] = '80';  //价值保费
		$data['insurance_premium'] = '100';  //规模保费
		$data['insured_date'] = '1492531200';  //承保日期 3.11
		$data['return_date'] = '';  //回执递交日期4.5
		$data['return_visit_date'] = '';  //回访成功日期 5.19
		$insurance=M("insurance");
		$return = $insurance->data($data)->add();
		dump($return);

	}
	/*
	*  功能：续期保单测试数据追加
	*  时间：2017-05-27
	*  作者：lzt
	*/
	public function addceshi_re(){
//		[0] => string(10) "7519170512"
//		[1] => string(10) "7521170516"
//		[2] => string(10) "7523170516"
//		[3] => string(10) "7526170516"
		$insurance = '272727';
		$name = '7526170516';
		$data['branch_shop_number'] = '100003';  //分公司代码
		$data['standard_shop_number'] = '7518170516';  //标准店代码
		$data['flag_shop_number'] = '7518170516';  //旗舰店
		$data['salesman_number'] = $name;  //业务员代码
		$data['product_id'] = '737373';  //产品id
		$data['policy_number'] = $insurance;  //保单号
		$data['policy_status'] = '1';  //保单状态	1=>有效	2=>失效
		$data['insurance_money'] = '1000';  //保额
		$data['insurance_premium'] = '100';  //规模保费
		$data['insured_date'] = '1492531200';  //承保日期 3.11
		$insurance=M("insurance_re");
		$return = $insurance->data($data)->add();
		$data2['insurance_num'] = $insurance;  //保单号
		$data2['two_time'] = '1492621261';  //二次成功日期
		$data2['two_state'] = '1';  //二次是否成功 1=》成功 2=》失败
		$data2['three_time'] = '1492621261';  //三次成功日期
		$data2['three_state'] = '1';  //三次缴费是否成功 1=》成功 2=》失败
		$data2['four_time'] = '1492621261';  //四次成功日期
		$data2['four_state'] = '1';  //四次是否成功 1 成功 2失败
		$data2['five_time'] = '1492621261';  //五次成功日期
		$data2['five_state'] = '1';  //五次是否成功 1成功 2失败
		$data2['renew_count'] = 5;  //续期缴费次数
		$return2 = M('renew')->data($data2)->add();
		dump($return);
		dump($return2);

	}
	/*
*  功能：签约比例测试数据添加
*  时间：2017-05-27
*  作者：lzt
*/
	public function settlement(){
//		产品id为 27，28，29，30"

		$data['product_id'] = '30';  //产品Id
		$data['provider_id'] = '23';  //供应商id'
		$data['renewal_type'] = '1';  //续期类型，1=>业务员，2=>供应商
		$data['length_of_renewal'] = '4';  //续期时长
		$data['payment_period'] = "10";  //缴费年期
		$data['renewal_ratio'] = '0.5';  //签约比例（供应商）/服务费率（业务员）
		$data['add_time'] = time();
		$return2 = M('settlement_renewal_contract')->data($data)->add();
		dump($return2);

	}



	/*
	*  功能：获得回执回访等时间
	*  时间：2017-05-23
	*  作者：
	*/
	public function get_time(){
		//当前月开始时间
		$end_time = strtotime(date("Y-m-1 0:0:0",time()));;
		//上月开始时间
		$start_time = strtotime("-1 Month",$end_time);

		$time=array();
		/*开始时间*/
		$time['start_time']  = $start_time;
		/*结束时间*/
		$time['end_time']  = $end_time;
		/*回执时间*/
		$time['receipt_time']  = strtotime("+10 days",$end_time);
		/*回访时间*/
		$time['return_time']   = strtotime("+20 days",$end_time);
		/*跨月回执的回执时间范围*/
		$time['next_receipt_start_time'] = strtotime("+10 days",$start_time);
		$time['next_receipt_end_time']   = strtotime("+10 days",$end_time);
		/*跨月回访的回访时间范围*/
		$time['next_return_start_time']  = strtotime("+20 days",$start_time);
		$time['next_return_end_time']    = strtotime("+20 days",$end_time);
		return $time;
	}

	/*
	*  功能：查询旗下所有会员
	*  时间：2017-05-22
	*  作者：lzt
	*/
	public function GetUnderNumber($code){
		$where['branch_shop_number'] = $code;
		$where['status'] = 1;
		$number = $this->member->where($where)->field('m_number,member_level')->select();
		foreach ($number as $k=>$v){
			switch ($v['member_level']){
				case 0:  //普通会员
					$minfo['upt'][] = $v['m_number'];
					break;
				case 1: //资深会员
					$minfo['uzs'][] = $v['m_number'];
					break;
				case 2: //标准店长
					$bz[] = $v['m_number'];
					break;
				case 3:  //旗舰店长
					$qj[] = $v['m_number'];
					break;
			}
		}
		$organi = M('organization');
		//标准店长按照店铺状态分类
		if($bz){
			$where2['principal_number'] = array('in',$bz);
			$where2['level'] = 3;
			$obz = $organi->where($where2)->field('principal_number,status')->select();
			foreach ($obz as $k=>$v){
				switch ($v['status']){
					case 0:  //筹备期
						$minfo['bzc'][] = $v['principal_number'];
						break;
					case 1: //经营期
						$minfo['bzj'][] = $v['principal_number'];
						break;
					case -1: //观察期
						$minfo['bzg'][] = $v['principal_number'];
						break;
				}
			}
		}
		//旗舰店长按照店铺状态分类
		if($qj){
			$where3['principal_number'] = array('in',$qj);
			$where3['level'] = 2;
			$oqj = $organi->where($where3)->field('principal_number,status')->select();
			foreach ($oqj as $k=>$v){
				switch ($v['status']){
					case 0:  //筹备期
						$minfo['qjc'][] = $v['principal_number'];
						break;
					case 1: //经营期
						$minfo['qjj'][] = $v['principal_number'];
						break;
					case -1: //观察期
						$minfo['qjg'][] = $v['principal_number'];
						break;
				}
			}
		}
		//dump($minfo);
		return $minfo;

	}












}
?>