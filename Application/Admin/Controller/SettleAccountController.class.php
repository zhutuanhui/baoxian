<?php
namespace Admin\Controller;
use Common\Controller\AdminbaseController;
class SettleAccountController extends AdminbaseController
{
	/*功能：供应商结算
	  时间：2017-5-9
	  作者：LY
	*/
	/*供应商主页*/
	public function index(){
		$supplier_result=$this->supplier_name();
		$this->assign("supplier",$supplier_result);
		$this->display();
	}

	/*供应商主页所有结算*/
	public function settle(){
		/*获得表单传来的POST值，包括供应商Id 最小时间和最大时间*/

		$supplier_id  = I("supplier");
		$date_purview = I("time_purview");
/************************月份转换******************************************/
		/*若选择时间范围为5月，则$start_time为5月1日0:0:0，$end_time为6月1日0:0:0
		                         $receipt_time为6月11日0:0:0，$return_time为6月21日0:0:0*/
		/*起始时间*/
		$start_time   = strtotime($date_purview);
		/*结束时间*/
		$end_time     = strtotime("+1 Month",$start_time);
		/*获得回执回访等时间*/
		$time=$this->get_time($start_time,$end_time);

		//echo $start_time."<br/>".$end_time."<br/>".$receipt_time."<br/>".$return_time;

/************************实例化表*******************************************/
		//实例化供应商表
		$supplier=M("supplier");
		//实例化首期业推奖金表
		$industry_bonus_proportion=M("settlement_initial_fee_industry_bonus_proportion");
		//实例化首期非寿险业务奖金比例表
		$settlement_non_life_insurance_premium=M("settlement_non_life_insurance_premium");
		//实例化续期手续费奖金系数比例表
		$renewal_bonus_ratio=M("settlement_renewal_fee_rate");

/************************供应商名字******************************************/		
		$supplier_result  = $this->supplier_name();
		$this->assign("supplier",$supplier_result);

/**************************供应商********************************************/
		//利用供应商id查出供应商名称	
		$supplier_name    = $supplier->where("sup_id=".$supplier_id)->field("full_name")->find();
		//得到包含供应商名字
		$name  = $supplier_name["full_name"];
		$this->assign("supplier_name",$name);

/**********************首期寿险结算保费**************************************/
		/*签约比例：产品不同、同一产品缴费年期不同，签约比例不同*/
		/*设置唯一标识*/
		$life_sign = "";
		$life_sign = $supplier_id."_".$start_time."_".$end_time."_life";


		/*将结果存入缓存中*/
		if (S($life_sign)=="") {
			$life_insurance_result = $this->life_insurance($supplier_id,$start_time,$end_time,$time['receipt_time'],$time['return_time'],$time['next_receipt_start_time'],$time['next_receipt_end_time'],$time['next_return_start_time'],$time['next_return_end_time']);
			S($life_sign,$life_insurance_result,3600);
			$life_insurance_result = S($life_sign);
		}else{
			/*S($life_sign,NULL);
			$life_insurance_result = $this->life_insurance($supplier_id,$start_time,$end_time,$time['receipt_time'],$time['return_time'],$time['next_receipt_start_time'],$time['next_receipt_end_time'],$time['next_return_start_time'],$time['next_return_end_time']);
			S($life_sign,$life_insurance_result,3600);*/
			$life_insurance_result = S($life_sign);
		}

		//dump($life_insurance_result);
		//定义寿险结算保费
		$life_premium=0;
		foreach ($life_insurance_result as $key => $value) {
			/*结算保费=规模保费*签约比例*/
			$life_premium += $value["agent_cost"];
		}
		if ($life_premium == "") {
			$life_premium = 0;
		}
		/*将寿险结算结果的唯一标识传入页面*/
		$this->assign("life_sign",$life_sign);
		//将寿险结算保费输入页面；
		$this->assign("life_premium",$life_premium);


/**************************首期非寿险规模结算********************************/
		/*利用供应商Id，最大时间和最小时间查询保单表，要求保单类型为非寿险，包括车险,承保日期在时间段内
		关联保单表和产品表，拿到非寿险规模保费和签约比例*/
		/*设置唯一标识*/
		$non_life_sign = "";
		$non_life_sign = $supplier_id."_".$start_time."_".$end_time."_non_life";

		$non_life_insurance_result=$this->non_life_insurance($supplier_id,$start_time,$end_time);
		//dump($non_life_insurance_result);
		/*将结果存入缓存当中*/
		/*S($non_life_sign,$non_life_insurance_result,3600);
		S($non_life_sign,NULL);*/
		S($non_life_sign,$non_life_insurance_result,3600);
	    //定义非寿险结算保费
		$non_life_premium  = 0;
		//将非寿险保费输入页面；
		foreach ($non_life_insurance_result as $key => $value) {
			$non_life_premium += $value["agent_cost"];
		}
		if ($non_life_premium == "") {
			$non_life_premium = 0;
		}
		/*将非寿险的唯一标识传入页面*/
		$this->assign("non_life_sign",$non_life_sign);
		//将非寿险结算保费输输入页面
		$this->assign("non_life_premium",$non_life_premium);

/**************************首期业推奖计算***************************************/
		/*首期寿险标准保费对应相关的奖金*/
		/*将寿险结算保费计算中一起查询出的标准保费累加得到标准保费的总额*/
		$standard_premium  = 0;
		$life_insurance_result = S($life_sign);
		foreach ($life_insurance_result as $key => $value) {
			$standard_premium += $value["standard_money"];
		}
		if ($standard_premium == "") {
			$standard_premium = 0;
		}
		//echo $standard_premium;
		/*查询首期业推奖金表，将标准保费对应的业推奖金拿出*/
		$industry_bonus_result = $industry_bonus_proportion->where("provider_id=".$supplier_id." && ".
			                                                      $standard_premium." between minimum_standard_permium and maximum_standard_premium")
														   ->field("bonus_ratio")
														   ->find();
		//P($industry_bonus_result);
		if ($industry_bonus_result["bonus_ratio"]=="") {
			$industry_bonus_result["bonus_ratio"]=0;
		}											
		$this->assign("first_industry_bonus",$industry_bonus_result["bonus_ratio"]);

/************************首期非寿险业务奖金**************************************/
		/*非寿险规模保费总数对应相关的奖金*/
		/*非寿险规模保费*/						
		$non_life_scale_premium=0;
		/*循环非寿险查询结果，将规模保费累加*/
		foreach ($non_life_insurance_result as $key => $value) {
			$non_life_scale_premium += $value['insurance_premium'];
		}

		/*查询非寿险业务奖金表，将非寿险业务奖金查询出来*/
		$settlement_non_life_result = $settlement_non_life_insurance_premium->where("provider_id=".$supplier_id." &&".
			                                                                       $non_life_scale_premium." between min_scale_premium and max_scale_premium")
		                                                                  ->field("non_life_insurance_premium")
		                                                                  ->find();
		/*非寿险业务奖金*/
		$non_life_insurance_premium = $settlement_non_life_result["non_life_insurance_premium"];
		if ($non_life_insurance_premium == "") {
			$non_life_insurance_premium = 0;
		}
		//将非寿险业务奖金输入到页面上
		$this->assign("non_life_insurance_premium",$non_life_insurance_premium);


/************************首期手续费总计******************************************/
		/*首期手续费=首期寿险结算保费+首期寿险业推奖金+首期非寿险结算保费+首期非寿险业务奖金*/
		$initial_fee=0;
		$initial_fee=$life_premium+$first_industry_bonus+$non_life_premium+$non_life_insurance_premium;
		//将首期手续费总计输入到页面上
		$this->assign("initial_fee",$initial_fee);

/************************续期结算保费********************************************/
		/*续期结算保费*/
		$renewal_settle_premium=0;
		/*查询续期时间表，将续期时间在计算时间范围内的保单号拿出*/
		$renewal_time = M("renew");
		/*查询第五次缴费时间在计算时间范围内的所有保单号*/
		$five_time_result = $renewal_time ->table("renew as r")
		 								  ->join("insurance_re as i on r.insurance_num = i.policy_number")
		 								  ->join("settlement_renewal_contract as s on 
		 								  		  s.provider_id = i.provider_id 
		 								  		 ")
		 								  ->where("i.provider_id = ".$supplier_id." &&
										  		   i.real_insurance_premium != 0 &&
										  		   r.five_time between ".$start_time." and ".$end_time." &&
			                                       r.five_state = 1 &&
			                                       s.renewal_type = 2 &&
			                                       s.payment_period = i.payment_limit &&
			                                       s.length_of_renewal = r.renew_count")
										  ->field("r.insurance_num,r.renew_count,r.five_agency_fee,r.five_time,i.insurance_premium,i.real_insurance_premium,i.insured_date,i.provider_name,i.product_name,s.renewal_ratio")
										  ->select();
  		foreach ($five_time_result as $key => $value) {
        	$five_time_result[$key]["agency_fee"] = $value["five_agency_fee"];
        	$five_time_result[$key]["i_date"] = date("Y-m-d",$value["insured_date"]);
        	$five_time_result[$key]["r_date"] = date("Y-m-d",$value["five_time"]);
        }				
        //dump($five_time_result);
		/*查询第四次缴费时间在计算范围内的所有保单号*/
		$four_time_result = $renewal_time ->table("renew as r")
		 								  ->join("insurance_re as i on r.insurance_num = i.policy_number")
		 								  ->join("settlement_renewal_contract as s on 
		 								  		  s.provider_id = i.provider_id 
		 								  		 ")
		 								  ->where("i.provider_id = ".$supplier_id." &&
										  		   i.real_insurance_premium != 0 &&
										  		   r.four_time between ".$start_time." and ".$end_time." &&
			                                       r.four_state = 1 &&
			                                       s.renewal_type = 2 &&
			                                       s.payment_period = i.payment_limit &&
			                                       s.length_of_renewal = r.renew_count")
										  ->field("r.insurance_num,r.renew_count,r.four_agency_fee,r.four_time,i.insurance_premium,i.real_insurance_premium,i.insured_date,i.provider_name,i.product_name,s.renewal_ratio")
										  ->select();
  		foreach ($four_time_result as $key => $value) {
        	$four_time_result[$key]["agency_fee"] = $value["four_agency_fee"];
        	$four_time_result[$key]["i_date"] = date("Y-m-d",$value["insured_date"]);
        	$four_time_result[$key]["r_date"] = date("Y-m-d",$value["four_time"]);
        }										  
	   // dump($four_time_result);
		/*查询第三次缴费时间在计算范围内的所有保单号*/
		$three_time_result = $renewal_time ->table("renew as r")
		 								   ->join("insurance_re as i on r.insurance_num = i.policy_number")
		 								   ->join("settlement_renewal_contract as s on 
		 								  		  s.provider_id = i.provider_id 
		 								  		 ") 
		 								   ->where("i.provider_id = ".$supplier_id." &&
										  		   i.real_insurance_premium != 0 &&
										  		   r.three_time between ".$start_time." and ".$end_time." &&
			                                       r.three_state = 1 &&
			                                       s.renewal_type = 2 &&
			                                       s.payment_period = i.payment_limit &&
			                                       s.length_of_renewal = r.renew_count")
										   ->field("r.insurance_num,r.renew_count,r.three_agency_fee,r.three_time,i.insurance_premium,i.real_insurance_premium,i.insured_date,i.provider_name,i.product_name,s.renewal_ratio")
										   ->select();	
  		foreach ($three_time_result as $key => $value) {
        	$three_time_result[$key]["agency_fee"] = $value["three_agency_fee"];
        	$three_time_result[$key]["i_date"] = date("Y-m-d",$value["insured_date"]);
        	$three_time_result[$key]["r_date"] = date("Y-m-d",$value["three_time"]);
        }
		//dump($three_time_result);
	    /*查询第二次缴费时间在计算范围内的所有保单号*/
		$two_time_result = $renewal_time  ->table("renew as r")
		 								  ->join("insurance_re as i on r.insurance_num = i.policy_number")
		 								  ->join("settlement_renewal_contract as s on 
		 								  		  s.provider_id = i.provider_id 
		 								  		 ")
										  ->where("i.provider_id = ".$supplier_id." &&
										  		   i.real_insurance_premium != 0 &&
										  		   r.two_time between ".$start_time." and ".$end_time." &&
			                                       r.two_state = 1 &&
			                                       s.renewal_type = 2 &&
			                                       s.payment_period = i.payment_limit &&
			                                       s.length_of_renewal = r.renew_count")
										  ->field("r.insurance_num,r.renew_count,r.two_agency_fee,r.two_time,i.insurance_premium,i.real_insurance_premium,i.insured_date,i.provider_name,i.product_name,s.renewal_ratio")
										  ->select();							  

        foreach ($two_time_result as $key => $value) {
        	$two_time_result[$key]["agency_fee"] = $value["two_agency_fee"];
        	$two_time_result[$key]["i_date"] = date("Y-m-d",$value["insured_date"]);
        	$two_time_result[$key]["r_date"] = date("Y-m-d",$value["two_time"]);
        }
        //dump($two_time_result);
        /*将四种不同时期的数组合并*/
        $renewal_array = array();
        $renewal_array[1] = $two_time_result;
        $renewal_array[2] = $three_time_result;
        $renewal_array[3] = $four_time_result;
        $renewal_array[4] = $five_time_result;
        //dump($renewal_array);
        $renewal_result = array();
        /*循环数组，将代理费拿出*/
        foreach ($renewal_array as $key => $value) {
        	foreach ($value as $k => $v) {
        		$renewal_settle_premium += $v["agency_fee"];
        		$renewal_result[$k] =  $v;
        	}
        }
      // dump($renewal_result);
		/*判断所有代理费是否为空*/
		if ($renewal_settle_premium =="") {
			$renewal_settle_premium =0;
		}
		
		/*制作唯一标识*/
		$renewal_sign = $supplier_id."_".$start_time."_".$end_time."_renewal";
		/*将结果存入缓存*/
		/*S($renewal_sign,NULL);*/
		S($renewal_sign,$renewal_result);

		$this->assign("renewal_sign",$renewal_sign);
		/*将续期结算保费输入到页面上*/
		$this->assign("renewal_settle_premium",$renewal_settle_premium);


/************************续期继续率奖金******************************************/
	/*利用所选的时间算出所需要找到保单的续保日期*/
	$renewal_start_time = strtotime("-3 Month",$start_time);
	$renewal_end_time   = $start_time-1;
	//echo $renewal_start_date."<br/>".$renewal_end_time;

	/*判断续保开始日期是否在12月，若在，则计算累计继续率*/
	$start_month =date("m",$renewal_start_time);
	//echo $start_month."<br/>";
	if ($start_month == 12) {
		/*计算累计继续率开始时间*/
		$total_start_date = date("Y-1-1",$renewal_start_time);
		$total_start_time = strtotime($total_start_date);
		$total_end_time   = $renewal_end_time;

		//echo $total_start_date."<br/>".$total_end_time;
		$result = $this->get_renewal_bonus($supplier_id,$total_start_time,$total_end_time,$start_month);
	}else{
	/*连表查续期时间表和续期保单表*/
		$result = $this->get_renewal_bonus($supplier_id,$renewal_start_time,$renewal_end_time,$start_month);
	}
	//dump($result);
	/*定义新数组*/
	$rene_result_array = array(); 
	/*将数组改为续期时长=>产品id=>缴费年期=>该续期年限下的续期比例,总应收和总实收*/
	foreach ($result as $rene_length => $value) {
		foreach ($value as $k => $v) {
			$rene_result_array[$rene_length][$v["product_id"]][$v["payment_limit"]]["bonus_ratio"] += $v["real_insurance_premium"]/$v["insurance_premium"];
			$rene_result_array[$rene_length][$v["product_id"]][$v["payment_limit"]]["insurance_premium"] += $v["insurance_premium"];
			$rene_result_array[$rene_length][$v["product_id"]][$v["payment_limit"]]["real_insurance_premium"] += $v["real_insurance_premium"];
		}
	}
//	dump($rene_result_array);
	$renewal_bonus = "";
	/*循环数组，查询续期继续率奖金比例表,算出继续率奖金*/
	foreach ($rene_result_array as $key => $value) {
		foreach ($value as $ki => $val) {
			foreach ($val as $k => $v) {
				$ratio_result = $renewal_bonus_ratio ->where("length_of_renewal = ".$key." &&
															  product_id = ".$ki." &&
															  payment_period =".$k." && ".
															  $v["bonus_ratio"]." between minimum_continuation_rate and maximum_continuation_rate") 
													 ->field("bonus_coefficient")
													 ->find();

				$renewal_bonus += $ratio_result["bonus_coefficient"]*$v["real_insurance_premium"];
			}
		}
	}
	//dump($rene_result_array);
	$this->assign("renewal_bonus",$renewal_bonus);
/************************续期手续费总计******************************************/
		/*续期手续费总计=续期结算保费+续期奖金*/
		$renewal_fee=$renewal_settle_premium+$renewal_bonus;
		if ($renewal_fee=="") {
			$renewal_fee=0;
		}
		$this->assign("renewal_fee",$renewal_fee);

/************************总计****************************************************/
		/*总计=首期手续费总计+续期手续费总计*/
		$aggregate_amount=$initial_fee+$renewal_fee;
		if ($aggregate_amount=="") {
			$aggregate_amount=0;
		}
		$this->assign("aggregate_amount",$aggregate_amount);

/*************************展现页面******************************************/
		/*将主页显示数字存入缓存*/
		$index_array = array();
		/*供应商名称*/
		$index_array["supplier_name"] = $name;
		/*首先结算保费*/
		$index_array["life_premium"]  = $life_premium;
		/*非寿险结算保费*/
		$index_array["non_life_premium"] = $non_life_premium;
		/*首期业推奖*/
		$index_array["first_industry_bonus"] = $industry_bonus_result["bonus_ratio"];
		/*首期非寿险业务奖*/
		$index_array["non_life_insurance_premium"] = $non_life_insurance_premium;
		/*首期总计*/
		$index_array["initial_fee"] = $initial_fee;
		/*续期结算保费*/
		$index_array["renewal_settle_premium"] = $renewal_settle_premium;
		/*续期继续率奖金*/
		$index_array["renewal_bonus"] = $renewal_bonus;
		/*续期总计*/
		$index_array["renewal_fee"] = $renewal_fee;
		/*总计*/
		$index_array["aggregate_amount"] = $aggregate_amount;
		/*制作唯一标识*/
		$index_sign = $supplier_id."_".$start_time."_".$end_time."_index";
		S($index_sign);
		S($index_sign,$index_array,3600);
		$this->assign("index_sign",$index_sign);
		$this->display("index");
	}
/*************************寿险详细页****************************************/
	public function life_insurance_detail(){
		/*获得寿险结果的唯一标识*/
		$life_sign = I("life_sign");
		$this->assign("life_sign",$life_sign);
		$this->display();
	}
/*************************非寿险详细页*****************************************/
	public function non_life_premium(){
		/*获得非寿险的唯一标识*/
		$non_life_sign = I("non_life_sign");	
		$this->assign("non_life_sign",$non_life_sign);
		$this->display();
	}
/*************************续期详细页*******************************************/
	public function renewal_detail(){
		/*获得唯一标识*/
		$renewal_sign  = I("renewal_sign");
		$this->assign("renewal_sign",$renewal_sign);
		$this->display();
	}
/***********************************************************************************************/	

		/*查询所有供应商名字*/
	public function supplier_name(){
		$supplier=M("supplier");
		//查询所有供应商名字
		$supplier_result=$supplier->field("sup_id,full_name")->select();//查询所有供应商名字
		return $supplier_result;
	}
	/*保单合并函数*/
	public function insurance_merge($normal,$receipt,$return){
		/*存放重复的保单*/
		$repeat_result  =  array();
		/*跨月回执结果*/
		$receipt_result =  array();
		/*跨月回访结果*/
		$return_result  =  array();
		/*正常保单结果*/
		$normal_result  =  array();
		/*用回执单和回访单进行对比，拿出重复的和剩下的回执单*/
		foreach ($receipt as $key => $value) {
			if (in_array($value,$return)) {
				$repeat_result[$value["id"]]  = $value;
			}else{
				$receipt_result[$value["id"]] = $value;
			}
		}
		/*用回访单和重复单进行对比，拿出剩下的回访单*/
		foreach ($return as $key => $value) {
			if (!in_array($value,$repeat_result)) {
				$return_result[$value["id"]]  = $value;
			}
		}
		/*将正常单的键名改为保单id*/
		foreach ($normal as $key => $value) {
			$normal_result[$value["id"]]  =  $value;
		}
		/*将正常单，回执单和回访单合并*/
		$result=array_merge_recursive($normal_result,$repeat_result,$receipt_result,$return_result);
		return $result;

	}

	/*获得回执回访等时间*/
	public function get_time($start_time,$end_time){
		$time=array();
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

	/*查询寿险保单*/
	public function life_insurance($supplier_id,$start_time,$end_time,$receipt_time,$return_time,$next_receipt_start_time,$next_receipt_end_time,$next_return_start_time,$next_return_end_time){
		/*利用供应商id 最大时间和最小时间查询保单表，要求犹豫期退保日期和退保日期等于空，
		承保日期在时间段内，犹豫期截止日期、回执成功日期和回访成功日期小于最大日期20天。
		且保单类型为1(寿险)，保单状态为0(有效)
		*/

		/*实例化保单表*/
		$insurance=M("insurance");
		$normal_life_result=$insurance->table("insurance as i")
		                              ->join(" initial_contract_ratio as r on r.product_id=i.product_id &&
		                                	   i.payment_limit=r.payment_period")
		                              ->join("supplier as s on s.sup_id=i.provider_id")
		                              ->join("product as p on i.product_id=p.id")
		                              ->where("i.provider_id=".$supplier_id." &&
	                                 	  	   i.product_id=r.product_id &&
	                                 	   	   i.payment_limit=r.payment_period &&
	                                 	   	   i.insurance_type=1 &&
	                                 	  	   i.policy_status=1 &&
	                                 	  	   i.hesitate_date=0 &&
	                                 	  	   i.surrender_date=0 &&
	                                 	  	   i.insured_date between ".$start_time." and ".$end_time." &&
	                                 	  	   i.return_date<".$receipt_time."&&
	                                 	  	   i.return_visit_date<".$return_time)
	                                  ->field("s.full_name,r.scale,i.insurance_premium,i.standard_money,i.agent_cost,i.insured_date,i.payment_limit,i.policy_holder_name,i.id,i.policy_number,p.product_name")
	                                  ->select();
				       		/*******跨月回执*******/
		$next_receipt_result=$insurance->table("insurance as i")
		                               ->join(" initial_contract_ratio as r on r.product_id=i.product_id &&
		                                 	      i.payment_limit=r.payment_period")
		                               ->join("supplier as s on s.sup_id=i.provider_id")
		                               ->join("product as p on i.product_id=p.id")
		                               ->where("i.provider_id=".$supplier_id." &&
		                                 	    i.product_id=r.product_id &&
		                                 	    i.payment_limit=r.payment_period &&
		                                 	    i.insurance_type=1 &&
		                                 	  	i.policy_status=1 &&
		                                 	    i.hesitate_date=0 &&
		                                 	    i.surrender_date=0 &&
		                                 	    i.insured_date<".$start_time." &&
		                                 	    i.return_date between ".$next_receipt_start_time." and ".$next_receipt_end_time." &&
		                                 	    i.return_visit_date<".$return_time)
		                               ->field("s.full_name,r.scale,i.insurance_premium,i.standard_money,i.agent_cost,i.insured_date,i.payment_limit,i.policy_holder_name,i.id,i.policy_number,p.product_name")
		                               ->select();
		            /*******跨月回访*******/
		 $next_return_result=$insurance->table("insurance as i")
		                               ->join(" initial_contract_ratio as r on r.product_id=i.product_id &&
		                                 	      i.payment_limit=r.payment_period")
		                               ->join("supplier as s on s.sup_id=i.provider_id")
		                               ->join("product as p on i.product_id=p.id")
		                               ->where("i.provider_id=".$supplier_id." &&
		                                 	  	  i.product_id=r.product_id &&
		                                 	  	  i.payment_limit=r.payment_period &&
		                                 	  	  i.insurance_type=1 &&
		                                 	  	  i.policy_status=1 &&
		                                 	  	  i.hesitate_date=0 &&
		                                 	  	  i.surrender_date=0 &&
		                                 	  	  i.insured_date<".$start_time." &&
		                                 	  	  i.return_date<".$receipt_time." &&
		                                 	  	  i.return_visit_date between ".$next_return_start_time." and ".$next_return_end_time)
		                               ->field("s.full_name,r.scale,i.insurance_premium,i.standard_money,i.agent_cost,i.insured_date,i.payment_limit,i.policy_holder_name,i.id,i.policy_number,p.product_name")
		                               ->select();
		 /*调用保单合并函数，将正常保单，跨月回执保单和跨月回访保单合并在一起*/

		$life_insurance_result = $this->insurance_merge($normal_life_result,$next_receipt_result,$next_return_result);
		
		foreach ($life_insurance_result as $key => $value) {
			$life_insurance_result[$key]["date"]=date("Y-m-d",$value["insured_date"]);
		}
		return $life_insurance_result;
	}
	/*首期非寿险查询*/
	public function non_life_insurance($supplier_id,$start_time,$end_time){
		$insurance = M("insurance");
		$non_life_insurance_result=$insurance->table("insurance as i")
                                     ->join("product as p on p.id=i.product_id")
                                     ->join("supplier as s on s.sup_id=i.provider_id")
                                     ->where("i.provider_id=".$supplier_id."&&
                                     	      i.insurance_type!=1 &&
                                     	      i.insured_date between ".$start_time." and ".$end_time)
                                     ->field("i.insurance_premium,i.policy_holder_name,i.insured_date,s.full_name,i.policy_number,i.agent_cost,p.product_name,p.Initial_contract_ratio")
                                     ->select();
        foreach ($non_life_insurance_result as $key => $value) {
			$non_life_insurance_result[$key]["date"]=date("Y-m-d",$value["insured_date"]);
		}
		return $non_life_insurance_result;
	}

	public function get_result(){
		$sign = I("sign");
		$result = S($sign);
		$arr["data"]=$result;
		echo json_encode($arr);
	}
	/*继续率奖金算法*/
	public function get_renewal_bonus($supplier_id,$start_time,$end_time,$start_month){
		/*判断开始月份，若开始时间为12月，则承保日期在1月1日至12月31日*/
		if ($start_month == 12) {
			/*第二次缴费的承保日期时间范围*/
			$two_insured_start   = strtotime("-1 year",$start_time);
			$two_insured_end     = strtotime("-1 second",$start_time);
			/*第三次缴费的承保日期时间范围*/
			$three_insured_start = strtotime("-2 years",$start_time);
			$three_insured_end   = strtotime("-1 second",$two_insured_start);
			/*第四次缴费的承保日期时间范围*/
			$four_insured_start  = strtotime("-3 years",$start_time);
			$four_insured_end    = strtotime("-1 second",$three_insured_start);
			/*第五次缴费的承保日期时间范围*/
			$five_insured_start  = strtotime("-4 years",$start_time);
			$five_insured_end    = strtotime("-1 second",$four_insured_start);
		}else{
			/*第二次缴费的承保日期时间范围*/
			$two_insured_start   = strtotime("-1 year",$start_time);
			$two_insured_end     = strtotime("+1 Month,-1 second",$two_insured_start);
			/*第三次缴费的承保日期时间范围*/
			$three_insured_start = strtotime("-2 years",$start_time);
			$three_insured_end   = strtotime("+1 Month,-1 second",$three_insured_end);
			/*第四次缴费的承保日期时间范围*/
			$four_insured_start  = strtotime("-3 years",$start_time);
			$four_insured_end    = strtotime("+1 Month,-1 second",$four_insured_end);
			/*第五次缴费的承保日期时间范围*/
			$five_insured_start  = strtotime("-4 years",$start_time);
			$five_insured_end    = strtotime("+1 Month,-1 second",$five_insured_start);
		}
		/*实例化续保日期时间表*/
		$renewal_time = M("renew");
		/*获得第五次缴费日期的所有保单*/
		$five_result = $renewal_time ->table("renew as r")
									 ->join("insurance_re as i on i.policy_number = r.insurance_num")
				   			 	     ->where("i.provider_id = ".$supplier_id." &&
											  i.real_insurance_premium != 0 &&
											  i.insured_date between ".$five_insured_start." and ".$five_insured_end." &&
											  r.five_time between ".$start_time." and ".$end_time." &&
				                              r.five_state = 1")
					   			     ->field("i.policy_number,i.insurance_premium,i.real_insurance_premium,i.product_id,i.payment_limit")
					   			     ->select();
		/*获得第四次缴费日期的所有保单*/
		$four_result = $renewal_time ->table("renew as r")
		 						     ->join("insurance_re as i on r.insurance_num = i.policy_number")	 
		 							 ->where("i.provider_id = ".$supplier_id." &&
											  i.real_insurance_premium != 0 &&
											  i.insured_date between ".$four_insured_start." and ".$four_insured_end." &&
											  r.four_time between ".$start_time." and ".$end_time." &&
				                              r.four_state = 1")
									 ->field("i.policy_number,i.insurance_premium,i.real_insurance_premium,i.product_id,i.payment_limit")
									 ->select();
		/*查询第三次缴费日期的所有保单*/
		$three_result = $renewal_time ->table("renew as r")
		 						      ->join("insurance_re as i on r.insurance_num = i.policy_number")	 
		 						      ->where("i.provider_id = ".$supplier_id." &&
											   i.real_insurance_premium != 0 &&
											   i.insured_date between ".$three_insured_start." and ".$three_insured_end." &&
											   r.three_time between ".$start_time." and ".$end_time." &&
				                               r.three_state = 1")
									  ->field("i.policy_number,i.insurance_premium,i.real_insurance_premium,i.product_id,i.payment_limit")
									  ->select();
		/*查询第二次缴费日期的所有保单*/
		$two_result = $renewal_time ->table("renew as r")
		 						    ->join("insurance_re as i on r.insurance_num = i.policy_number")	 
		 							->where(" i.provider_id = ".$supplier_id." &&
											  i.real_insurance_premium != 0 &&
											  i.insured_date between ".$two_insured_start." and ".$two_insured_end." &&
											  r.two_time between ".$start_time." and ".$end_time." &&
				                              r.two_state = 1")
								    ->field("r.insurance_num,i.insurance_premium,i.real_insurance_premium,i.product_id,i.payment_limit")
								    ->select();
								    /*i.provider_id = ".$supplier_id." &&
						  		   i.real_insurance_premium != 0 &&
						  		   r.two_time between ".$start_time." and ".$end_time." &&
                                   r.two_state = 1 &&
                                   s.renewal_type = 2 &&
                                   s.payment_period = i.payment_limit &&
                                   s.length_of_renewal = r.renew_count")*/
		$arr = array();
		$arr[1] = $two_result;
		$arr[2] = $three_result;
		$arr[3] = $four_result;
		$arr[4] = $five_result;

		return $arr;

	}

}