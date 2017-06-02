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
		$time = time();
		$month = mktime(0, 0 , 0,date("m")-1,1,date("Y"));
		//dump($minfo);  die;
		//普通业务员服务费计算
		if(!$minfo['upt']){
			//首期寿险服务费
			$initial = $this->initial($minfo['upt'],$FeeCon['member'],$post['code'],'upt');
		//	dump($initial);
			//续期寿险服务费
			$renewal = $this->renewal($minfo['upt'],$post['code'],'upt');
		//	dump($renewal);
			//非寿险服务费
			$nonlife = $this->nonlife($minfo['upt'],$post['code'],'upt');
			//dump($nonlife);
			//其他家扣款统计
			$otherdeduc = $this->Otherdeduc($minfo['upt'],$post['code'],'upt');
		//	dump($otherdeduc);
			//计税（首期，续期，非寿）

			//整合会员的服务费
			$upt_save = array();
			//dump($minfo['upt']);
			foreach ($minfo['upt'] as $k=>$v){
				$upt_save[$v]['m_number'] = $v; //会员代码
				$upt_save[$v]['initial_service'] = $initial[$v]['initial']; //首推服务费
				$upt_save[$v]['renewal_service'] = $renewal[$v]['renewal']; //续期服务费
				$upt_save[$v]['nonlife_service'] = $nonlife[$v]['nonli'];   //非寿险服务费
				$upt_save[$v]['Debit'] = $otherdeduc[$v]["money"];   //其他加扣款
				$upt_save[$v]['deduction'] = 0;   //扣税金额
				$upt_save[$v]['already_pay'] = $nonlife[$v]['nonli'];   //已发工资
				$upt_save[$v]['Should_pay'] = $initial[$v]['initial']+ $renewal[$v]['renewal']+$nonlife[$v]['nonli'];   //应发工资
				$upt_save[$v]['actual_pay'] = $upt_save[$v]['Should_pay']-$upt_save[$v]['deduction']+$upt_save[$v]['Debit']-$upt_save[$v]['already_pay'];   //实发工资
				$upt_save[$v]['on_line'] = $upt_save[$v]['actual_pay'];   //线上发放
				$upt_save[$v]['branch_shop'] = 1;   //分公司意见   1=>未通过 2=>通过
				$upt_save[$v]['headquarters'] = 1;   //总公司意见 1=>未通过 2=>通过
				$upt_save[$v]['month'] = $month;   //服务费计算时间  以月份为单位
				$upt_save[$v]['time'] = $time;   //时间
			}
		 // dump($upt_save);
			//数据库存储
			$otherdeduc2 = $this->insertsql($minfo['upt'],$post['code'],'upt',$upt_save);
			if($otherdeduc2){
				$upt = 1;
			}else{
				$upt = 0;
			}
			//die;

		}else{
			$upt = 1;
		}
		//资深业务员服务费计算
		if(!$minfo['uzs']){
			//首期寿险服务费
			$initialzs = $this->initial($minfo['uzs'],$FeeCon['senior_member'],$post['code'],'uzs');
			//续期寿险服务费
			$renewalzs = $this->renewal($minfo['uzs'],$post['code'],'uzs');
			//非寿险服务费
			$nonlifezs = $this->nonlife($minfo['uzs'],$post['code'],'uzs');
			//其他家扣款统计
			$otherdeduczs = $this->Otherdeduc($minfo['uzs'],$post['code'],'uzs');
			//计税（首期，续期，非寿）

			//整合会员的服务费
			$uzs_save= array();
			foreach ($minfo['uzs'] as $k=>$v){
				$uzs_save[$v]['m_number'] = $v; //会员代码
				$uzs_save[$v]['initial_service'] = $initialzs[$v]['initial']; //首推服务费
				$uzs_save[$v]['renewal_service'] = $renewalzs[$v]['renewal']; //续期服务费
				$uzs_save[$v]['nonlife_service'] = $nonlifezs[$v]['nonli'];   //非寿险服务费
				$uzs_save[$v]['Debit'] = $otherdeduczs[$v]["money"];   //其他加扣款
				$uzs_save[$v]['deduction'] = 0;   //扣税金额
				$uzs_save[$v]['already_pay'] = $nonlifezs[$v]['nonli'];   //已发工资
				$uzs_save[$v]['Should_pay'] = $initialzs[$v]['initial']+ $renewalzs[$v]['renewal']+$nonlifezs[$v]['nonli'];   //应发工资
				$uzs_save[$v]['actual_pay'] = $uzs_save[$v]['Should_pay']-$uzs_save[$v]['deduction']+$uzs_save[$v]['Debit']-$uzs_save[$v]['already_pay'];   //实发工资
				$uzs_save[$v]['on_line'] = $uzs_save[$v]['actual_pay'];   //线上发放
				$uzs_save[$v]['branch_shop'] = 1;   //分公司意见   1=>未通过 2=>通过
				$uzs_save[$v]['headquarters'] = 1;   //总公司意见 1=>未通过 2=>通过
				$uzs_save[$v]['month'] = $month;   //服务费计算时间  以月份为单位
				$uzs_save[$v]['time'] = $time;   //时间
			}
			//数据库存储
			$otherdeduczs2 = $this->insertsql($minfo['uzs'],$post['code'],'uzs',$uzs_save);
			if($otherdeduczs2){
				$uzs = 1;
			}else{
				$uzs = 0;
			}

		}else{
			$uzs = 1;
		}
		//标准店筹备期服务费计算
		if($minfo['bzc']){
			dump($minfo['bzc']);
			//首期寿险服务费(线上百分比+线下百分比)
			$baifenbi = $FeeCon['standard_online']+$FeeCon['standard_line'];
		//	$initialzc = $this->initial($minfo['bzc'],$baifenbi,$post['code'],'bzc');
			//续期寿险服务费
		//	$renewalzc = $this->renewal($minfo['bzc'],$post['code'],'bzc');
			//非寿险服务费
		//	$nonlifezc = $this->nonlife($minfo['bzc'],$post['code'],'bzc');
			//管理利益manage
			$managezc = $this->manage($minfo['bzc'],$FeeCon['standard_manage'],$post['code'],'bzc');
			//育成利益foster
			//计税（首期，续期，非寿，管理，育成）
			die;
		}else{
			$bzc = 1;
		}
		//标准店经营期服务费计算
		if($minfo['bzj']){
			$bzj = $this->bzjcount();
			//首期寿险服务费(线上百分比+线下百分比)
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
			//首期寿险服务费(线上百分比+线下百分比)
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

		if($qjg&&$qjj&&$qjc&&$bzg&&$bzj&&$bzc&&$uzs&&$upu){

		}
	}
	/*
	*  功能：管理利益
	*  时间：2017-06-01
	*  作者：lzt
	*/
	public function manage($member,$ratio,$code,$type){
		//查询新契约品质系数
//		dump(10101010);
//		dump($member);
		$where['m_number'] = array('in',$member);
		$contract = M('new_contract_coefficient')->where($where)->getField('m_number,new_cont_cone',true);
		//判断缓存是否存在
//		$life = "initial_service_".$code."_".$type;
//		if(S($life)){
//			$insurance = S($life);
//		}else{
			//查询店长旗下所有有效保单的价值保费
			$insurance = $this->GetValPre($member,2);

		$count =array();
		foreach ($insurance as $k=>$v){
			if(!isset($count[$v['standard_shop_number']])){
				$count[$v['standard_shop_number']]['number'] = $v['standard_shop_number']; //业务员代码
				$count[$v['standard_shop_number']]['premium'] = floatval($v['value_premium']); //累计有效价值保费;
				$count[$v['standard_shop_number']]['contract'] = floatval($contract[$v['standard_shop_number']]); //新契约品质系数
			}else{
				$count[$v['standard_shop_number']]['premium'] += $v['value_premium']; //累计有效价值保费
			}
		}
		//dump($count);
		//计算业务员首期寿险服务费
		//dump($ratio);
		$manage_service = array();
		foreach ($count as $k=>$v){
			$manage_service[$k]['number'] =$v['number'];
			$manage_service[$k]['initial'] =$v['premium']*$v['contract']*$ratio;
		}
		//dump($initial_service);
		return $manage_service;
	}

	/*
	*  功能：数据库操作
	*  时间：2017-05-31
	*  作者：lzt
	*/
	public function insertsql($member,$code,$type,$save){
	//	dump($save);
		//查询业务员所属店铺
		//服务费计算表插入数据
		$saveid =array();
		$ser_fee_calc = M('service_fee_calculation');
		foreach($save as $k=>$v){
			$saveid[$k]["number"] = $k;
			$res = $ser_fee_calc->data($v)->add();
			if($res){
				$saveid[$k]["id"] = $res;
			}else{
				dump($saveid);
				return 0;
			}
		}
//		$life = "aaaaaaaaaaaaaa";
		//S($life,$saveid,14400);
//		$saveid = S($life);
		//dump($saveid);

		//服务费于保单关系表插入数据（首期，续期，非寿）
		$ser_fee_poli = M('service_fee_policy');
		$time =time();
		//获取首期缓存
		$life1 = "initial_service_".$code."_".$type;
		$initial = S($life1);
		$initial2 = array();
		//组装数据
		foreach ($initial as $ki=>$vi){
			$initial2[$vi['salesman_number']][$vi['policy_number']]['ser_feee_id'] =$saveid[$vi['salesman_number']]['id'];  //'服务费计算详情ID',
			$initial2[$vi['salesman_number']][$vi['policy_number']]['m_number'] =$vi['salesman_number'];  //会员代码
			$initial2[$vi['salesman_number']][$vi['policy_number']]['policy_number'] =$vi['policy_number']; // 保单号
			$initial2[$vi['salesman_number']][$vi['policy_number']]['policy_value'] =$vi['value_premium']; // 价保
			$initial2[$vi['salesman_number']][$vi['policy_number']]['policy_type'] =1; // '保险类型 1:首期，2续期，3非寿',
			$initial2[$vi['salesman_number']][$vi['policy_number']]['time'] =$time; // 时间
		}
		//插入数据库
		foreach ($initial2 as $ki2=>$vi2){
			foreach ($vi2 as $ki3=>$vi3){
				$res = $ser_fee_poli->data($vi3)->add();
				if(!$res){
					return 0;
				}
			}
		}
		//dump( Phpinfo());

		//获取续期缓存
		$life2 = "renewal_service_".$code."_".$type;
		$renewal = S($life2);
		$renewal2 = array();
		foreach ($renewal as $kr=>$vr){
			$renewal2[$vr['salesman_number']][$vr['policy_number']]['ser_feee_id'] =$saveid[$vr['salesman_number']]['id'];  //'服务费计算详情ID',
			$renewal2[$vr['salesman_number']][$vr['policy_number']]['m_number'] =$vr['salesman_number'];  //会员代码
			$renewal2[$vr['salesman_number']][$vr['policy_number']]['policy_number'] =$vr['policy_number']; // 保单号
			$renewal2[$vr['salesman_number']][$vr['policy_number']]['policy_value'] =$vr['insurance_premium']; // 规保
			$renewal2[$vr['salesman_number']][$vr['policy_number']]['policy_type'] =1; // '保险类型 1:首期，2续期，3非寿',
			$renewal2[$vr['salesman_number']][$vr['policy_number']]['time'] =$time; // 时间
		}
		//插入数据库
		foreach ($renewal2 as $kr2=>$vr2){
			foreach ($vr2 as $kr3=>$vr3){
				$res2 = $ser_fee_poli->data($vr3)->add();
				if(!$res2){
					return 0;
				}
			}
		}
	//	dump($renewal2);
		//获取非寿缓存
		$life3 = "nonlife_service_".$code."_".$type;
		$nonlife = S($life3);
		$nonlife2 = array();
		foreach ($nonlife as $kn=>$vn){
			$nonlife2[$vn['salesman_number']][$vn['policy_number']]['ser_feee_id'] =$saveid[$vn['salesman_number']]['id'];  //'服务费计算详情ID',
			$nonlife2[$vn['salesman_number']][$vn['policy_number']]['m_number'] =$vn['salesman_number'];  //会员代码
			$nonlife2[$vn['salesman_number']][$vn['policy_number']]['policy_number'] =$vn['policy_number']; // 保单号
			$nonlife2[$vn['salesman_number']][$vn['policy_number']]['policy_value'] =$vn['insurance_premium']; // 规保
			$nonlife2[$vn['salesman_number']][$vn['policy_number']]['policy_type'] =1; // '保险类型 1:首期，2续期，3非寿',
			$nonlife2[$vn['salesman_number']][$vn['policy_number']]['time'] =$time; // 时间
		}
		//插入数据库
		foreach ($nonlife2 as $kn2=>$vn2){
			foreach ($vn2 as $kn3=>$vn3){
				$res3 = $ser_fee_poli->data($vn3)->add();
				if(!$res3){
					return 0;
				}
			}
		}

	//	dump($nonlife2);
		//其他加扣款表修改数据
		$life3 = "otherdeduc_service_".$code."_".$type;
		$otherdeduc = S($life3);
		$otherid =array();
		foreach ($otherdeduc as $k=>$v){
			$otherid[] = $v['id'];
		}
		$where['id'] = array('in',$otherid);  //id
		$where['condition'] = 1;  //失效状态 0=》失效 1=》有效
		$date['condition'] = 0;
		$res4 = M('add_deductions')->where($where)->data($date)->save();
		if(!$res4){
			return 0;
		}
		return 1;

	}

	/*
	*  功能：其他加扣款统计
	*  时间：2017-05-31
	*  作者：lzt
	*/
	public function Otherdeduc($member,$code,$type){
		//dump($member);
		//判断缓存是否存在
		$life = "otherdeduc_service_".$code."_".$type;
		if(S($life)){
			$otherdeduc = S($life);
		}else{
			//查询业务员所有加扣款
			$where['salesman_number'] = array('in',$member);  //业务员代码
			$where['condition'] = 1;  //失效状态 0=》失效 1=》有效
			$otherdeduc = M('add_deductions')->where($where)->field('id,salesman_number,state,money')->select();
			S($life,$otherdeduc,3600);
		}

		//dump($otherdeduc);
		$renewal = array();
		//其他加扣款合计
		foreach ($otherdeduc  as $k=>$v){
			if($v['state'] == 1){
				$renewal[$v['salesman_number']]['money'] -= $v['money'];
			}else{
				$renewal[$v['salesman_number']]['money'] += $v['money'];
			}
		}
		//dump($renewal);
		return $renewal;
	}

	/*
	*  功能：续期服务费计算
	*  时间：2017-05-26
	*  作者：lzt
	*/
	public function renewal($member,$code,$type){
		//dump($member);
		//查询相关续期保单。
		//判断缓存是否存在
		$life = "renewal_service_".$code."_".$type;
		if(S($life)){
			$insu_re = S($life);
		}else{
			//查询业务员所有有效续期保单的规模
			//
			//保费
			$insu_re = $this->getinsure($member);
			S($life,$insu_re,3600);
		}

		//保单拆分13个月和其他月份
		$res = array();
		foreach ($insu_re as $kb =>$vb){
			if($vb['renew_count'] == 2 ){
				$res[$vb['salesman_number']]['two'][] = $vb;
			}else{
				$res[$vb['salesman_number']]['other'][] = $vb;
			}
		}

		//dump($insu_re);
		//查询续期品质系数
		$where['m_number'] = array('in',$member);  //业务员代码
		$coeffic = M('personal_coefficient')->where($where)->getField('m_number,coefficient',true);
	//	dump($coeffic);
		//计算服务费
		$renewal = array();
		foreach ($res as $k=>$v){
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
		$where['a.policy_status'] = 0; //保单状态有效
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
		if($ance_re) {
			$proid = array();
			foreach ($ance_re as $k => $v) {
				//统计产品
				$proid[] = $v['product_id'];
			}
			//dump($res);
			//产品id去重
			$prodid = array_unique($proid);
			//dump($prodid);
			//	dump(222222222222222222);
			$pwhere['product_id'] = array('in', $prodid);  //业务员代码
			$pwhere['renewal_type'] = 1;  //续期类型，1=>业务员，2=>供应商
			$settlement = M('settlement_renewal_contract')->where($pwhere)->field('product_id,length_of_renewal,payment_period,length_of_renewal,renewal_ratio')->select();
			//dump($settlement);
			//dump(33333333333333);
			//组合服务保单与服务费率
			$ance = array();
			foreach ($ance_re as $k => $v) {
				foreach ($settlement as $ka => $va) {
					if (($v['product_id'] == $va['product_id']) && ($v['payment_limit'] == $va['payment_period']) && ($v['renew_count'] == ($va['length_of_renewal'] + 1))) {
						$ance[$v['policy_number']] = $v;
						$ance[$v['policy_number']]['renewal_ratio'] = $va['renewal_ratio'];
					}
				}

			}
		}
			//dump($ance);

		//dump($res);
		return $ance;
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
			$insurance = $this->GetValPre($member,1);
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
	public function GetValPre($member,$type){
//		public function GetValPre(){
//		$member =array(
//		"7519170512",
//		"7521170516",
//		"7523170516",
//		"7526170516",
//		);
//		dump(111111);
//		dump($member);
	//	$type = 2;
		//获取时间节点
		$time = $this->get_time();
	//dump($time);
		$insurance=M("insurance");
		switch ($type){
			case 1:   //业务员
				$key = "salesman_number";
				break;
			case 2:   //标准店
				$key = "standard_shop_number";
				break;
			case 3:  //旗舰店
				$key = "flag_shop_number";
				break;
		}

		//正常保单统计---------------------------------------------------------------------------------------------------
		$nowhere["$key"] = array('in',$member); //业务员
		$nowhere['policy_status'] = 1; //保单状态有效
		$nowhere['insurance_type'] = 1; //寿险
		$se_time['0'] = $time['start_time'];
		$se_time['1'] = $time['end_time'];
		$nowhere['insured_date'] = array('between',$se_time); //承保日期
		$nowhere['return_date'] = array('lt',$time['receipt_time']); //回执日期
		$nowhere['return_visit_date'] = array('lt',$time['return_time']); //回访日期
		$normal = $insurance->where($nowhere)->field($key.',policy_number,value_premium')->select();
		//dump($normal);
		//跨月回执保单统计-----------------------------------------------------------------------------------------------
		$recwhere["$key"] = array('in',$member); //业务员
		$recwhere['policy_status'] = 1; //保单状态有效
		$recwhere['insurance_type'] = 1; //寿险
		$recwhere['insured_date'] = array('lt',$time['start_time']); //承保日期
		$receipt_time['0'] = $time['next_receipt_start_time'];
		$receipt_time['1'] = $time['next_receipt_end_time'];
		$recwhere['return_date'] = array('between',$receipt_time); //回执日期
		$recwhere['return_visit_date'] = array('lt',$time['return_time']); //回访日期
		//$receipt = $insurance->where($recwhere)->field('salesman_number,policy_number,value_premium')->select();
		$receipt = $insurance->where($recwhere)->field($key.',policy_number,value_premium')->select();
		//dump($receipt);
		//跨越回访保单统计-----------------------------------------------------------------------------------------------
		$retwhere["$key"] = array('in',$member); //业务员
		$retwhere['policy_status'] = 1; //保单状态有效
		$retwhere['insurance_type'] = 1; //寿险
		$retwhere['insured_date'] = array('lt',$time['start_time']); //承保日期
		$retwhere['return_date'] = array('lt',$time['receipt_time']); //回执日期
		$return_time['0'] = $time['next_return_start_time'];
		$return_time['1'] = $time['next_return_end_time'];
		$retwhere['return_visit_date'] = array('between',$return_time); //回访日期
		$return = $insurance->where($retwhere)->field($key.',policy_number,value_premium')->select();
	//	dump($return);
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
		//dump($return);

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
		//($return);
		//dump($return2);

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
		//$end_time = strtotime(date("Y-m-1 0:0:0",time()));
		//当前时间为5.20
		$end_time = strtotime(date("Y-m-1 0:0:0",'1495209600'));
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