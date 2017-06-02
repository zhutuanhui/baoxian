<?php
namespace Admin\Controller;
use Common\Controller\AdminbaseController;
/*个人业绩查询
	2017.5.26
	LY
*/
class PersonalPerformanceController extends AdminbaseController
{
	
	public function index(){
		$this->display();
	}

	public function get_result(){
		$ins_type = I("ins_type");
		$org_type = I("org_type");
		$org_code = I("org_code");
		$member   = I("member");

		/*制作搜索条件*/
		$where = array();
		if ($ins_type == 0) {
			if ($org_type == 0 && $org_code == "请输入店铺编号" && $member == "请输入会员编号") {
				/*不做任何提示*/
				echo 1;
				exit;
			}else{
				/*提示选择险种类型*/
				echo 2;
				exit;
			}
		}else{
			if ($org_type == 0 && $org_code == "请输入店铺编号" && $member == "请输入会员编号") {
				/*提示选择其他搜索条件*/
				echo 3;
				exit;
			}else if ($org_type != 0 && $org_code == "请输入店铺编号" && $member == "请输入会员编号") {
				/*提示请输入店铺编号或会员编号*/
				echo 4;
				exit;
			}else if ($org_type == 0 && $org_code != "请输入店铺编号" && $member == "请输入会员编号") {
				/*提示选择机构类型*/
				echo 5;
				exit;
			}else{
					$where["ranking_type"] = $ins_type;
				/*制作搜索条件*/
				if ($org_type != 0 && $org_code != "请输入店铺编号" && $member == "请输入会员编号") {
					if ($org_type == 1) {
						$where["branch_shop_number"] = $org_code;
					}else if ($org_type == 2) {
						$where["flagship_number"] = $org_code;
					}else if ($org_type == 3) {
						$where["shop_number"] = $org_code;
					}else if ($org_type == 4) {
						$where["recommend_member_id"] = $org_code;
					}
				}else if ($org_type != 0 && $org_code != "请输入店铺编号" && $member != "请输入会员编号") {
					if ($org_type == 1) {
						$where["branch_shop_number"] = $org_code;
						$where["m_number"] = $member;
					}else if ($org_type == 2) {
						$where["flagship_number"] = $org_code;
						$where["m_number"] = $member;
					}else if ($org_type == 3) {
						$where["shop_number"] = $org_code;
						$where["m_number"] = $member;
					}else if ($org_type == 4) {
						$where["recommend_member_id"] = $org_code;
						$where["m_number"] = $member;
					}
					
				}else{
					$where["m_number"] = $member;
				}

			}
		}

		/*获得当前时间*/
		$current = time();
		/*当天0:0:0的时间戳*/
		$cur_time = strtotime(date("Y-m-d",$current));
		/*制作唯一标识*/
		$sign = $ins_type."_".$org_type."_".$org_code."_".$member."_".$cur_time;

		$condition =S($sign);

		if ($condition == "") {
		/*实例化会员表*/
		$member = M("member");
		/*查询会员表和会员业绩表*/
		$result = $member ->table("member as m")
						  ->join("insu_mem_performance as i on i.member_id = m.m_number")
						  ->where($where)
						  ->field("m.m_number,m.name,m.recommend_member_id,m.shop_number,m.flagship_number,m.branch_shop_number,i.mon_ranking,i.mon_achieve,i.mon_sum,i.quar_ranking,i.quar_sum,i.quar_achieve,i.half_sum,i.half_achieve,i.year_sum,i.year_achieve,i.half_ranking,i.year_ranking")
						  ->select();

		/*实例化保单表*/
		$insurance = M("insurance");
		foreach ($result as $key => $value) {
			/*获得当天所承包的件数及保费*/
			if ($ins_type == 1) {
				/*寿险，查询价值保费*/
				$life_result = $insurance ->where("salesman_number = ".$value["m_number"]." && 
												   insured_date > ".$cur_time." &&
												   policy_status = 1 &&
												   insurance_type = 1")
										  ->field("count(policy_number) as sum,sum(value_premium) as value_premium")
										  ->find();
					/*判断结果，计算业绩，件数和件均，件均，取两位小数*/
					if ($life_result != "") {
						/*本月业绩*/
						$result[$key]["mon_achieve"] = $value["mon_achieve"]+$life_result["value_premium"];
						$result[$key]["mon_sum"]     = $value["mon_sum"]+$life_result["sum"];
						$result[$key]["mon_average"] = round($result[$key]["mon_achieve"]/$result[$key]["mon_sum"],2);
						/*本季度业绩*/
						$result[$key]["quar_achieve"]= $value["quar_achieve"]+$life_result["value_premium"];
						$result[$key]["quar_sum"]    = $value["quar_sum"]+$life_result["sum"];
						$result[$key]["quar_average"]= round($result[$key]["quar_achieve"]/$result[$key]["quar_sum"],2);
						/*本半年业绩*/
						$result[$key]["half_achieve"]= $value["half_achieve"]+$life_result["value_premium"];
						$result[$key]["half_sum"]    = $value["half_sum"]+$life_result["sum"];
						$result[$key]["half_average"]= round($result[$key]["half_achieve"]/$result[$key]["half_sum"],2);
						/*本年业绩*/
						$result[$key]["year_achieve"]= $value["year_achieve"]+$life_result["value_premium"];
						$result[$key]["year_sum"]    = $value["year_sum"]+$life_result["sum"];
						$result[$key]["year_average"]= round($result[$key]["year_achieve"]/$result[$key]["year_sum"],2);
					}
					

			}else if ($ins_type == 2) {
				/*非寿险不含车险，查询规模保费*/
				$non_life_result = $insurance ->where("salesman_number = ".$value["m_number"]." && 
													   insured_date > ".$cur_time." &&
													   policy_status = 1 &&
													   insurance_type ==2")
											  ->field("count(policy_number) as sum,sum(insurance_premium) as insurance_premium")
											  ->find();
					/*判断结果，计算业绩，件数和件均，件均取两位小数*/
					if ($non_life_result != "") {
						/*本月业绩*/
						$result[$key]["mon_achieve"] = $value["mon_achieve"]+$non_life_result["insurance_premium"];
						$result[$key]["mon_sum"]     = $value["mon_sum"]+$non_life_result["sum"];
						$result[$key]["mon_average"] = round($result[$key]["mon_achieve"]/$result[$key]["mon_sum"],2);
						/*本季度业绩*/
						$result[$key]["quar_achieve"]= $value["quar_achieve"]+$non_life_result["insurance_premium"];
						$result[$key]["quar_sum"]    = $value["quar_sum"]+$non_life_result["sum"];
						$result[$key]["quar_average"]= round($result[$key]["quar_achieve"]/$result[$key]["quar_sum"],2);
						/*本半年业绩*/
						$result[$key]["half_achieve"]= $value["half_achieve"]+$non_life_result["insurance_premium"];
						$result[$key]["half_sum"]    = $value["half_sum"]+$non_life_result["sum"];
						$result[$key]["half_average"]= round($result[$key]["half_achieve"]/$result[$key]["half_sum"],2);
						/*本年业绩*/
						$result[$key]["year_achieve"]= $value["year_achieve"]+$non_life_result["insurance_premium"];
						$result[$key]["year_sum"]    = $value["year_sum"]+$non_life_result["sum"];
						$result[$key]["year_average"]= round($result[$key]["year_achieve"]/$result[$key]["year_sum"],2);
					}
					
			}else if ($ins_type == 3) {
				/*车险，查询规模保费*/
				$car_result = $insurance ->where("salesman_number = ".$value["m_number"]." && 
											      insured_date > ".$cur_time." &&
											      policy_status = 1 &&
											      insurance_type == 3")
									     ->field("count(policy_number) as sum,sum(insurance_premium) as insurance_premium")
								    	 ->find();
				/*判断结果，计算业绩，件数和件均，件均取两位小数*/
				if ($car_result != "") {
					/*本月业绩*/
					$result[$key]["mon_achieve"] = $value["mon_achieve"]+$car_result["insurance_premium"];
					$result[$key]["mon_sum"]     = $value["mon_sum"]+$car_result["sum"];
					$result[$key]["mon_average"] = round($result[$key]["mon_achieve"]/$result[$key]["mon_sum"],2);
					/*本季度业绩*/
					$result[$key]["quar_achieve"]= $value["quar_achieve"]+$car_result["insurance_premium"];
					$result[$key]["quar_sum"]    = $value["quar_sum"]+$car_result["sum"];
					$result[$key]["quar_average"]= round($result[$key]["quar_achieve"]/$result[$key]["quar_sum"],2);
					/*本半年业绩*/
					$result[$key]["half_achieve"]= $value["half_achieve"]+$car_result["insurance_premium"];
					$result[$key]["half_sum"]    = $value["half_sum"]+$car_result["sum"];
					$result[$key]["half_average"]= round($result[$key]["half_achieve"]/$result[$key]["half_sum"],2);
					/*本年业绩*/
					$result[$key]["year_achieve"]= $value["year_achieve"]+$car_result["insurance_premium"];
					$result[$key]["year_sum"]    = $value["year_sum"]+$car_result["sum"];
					$result[$key]["year_average"]= round($result[$key]["year_achieve"]/$result[$key]["year_sum"],2);
				}
					
			}
		}
			/*将结果存入缓存中*/
			S($sign,$result,86400);
			/*从缓存中拿值*/
			$result = S($sign);
		}else{
			/*从结果中拿值*/
			//S($sign,NULL);
			$result = S($sign);	
		}
		$res["data"] = $result;
		$this->ajaxReturn($res);	
	}


	/*定时脚本*/
	public function personal(){
		/*获得当前时间0:0:0*/
		$s_day = strtotime(date("Y-m-d",time()));
		/*获得当月时间0:0:0*/
		$s_month = strtotime(date("Y-m",time()));
		/*获得当季度的开始时间0:0:0*/
		if (date("m",time()) >= 1 && date("m",time()) <=3 ) {
			$s_quar = strtotime(date("Y-1-1",time()));
		}else if (date("m",time()) >= 4 && date("m",time()) <=6) {
			$s_quar = strtotime(date("Y-4-1",time()));
		}else if (date("m",time()) >= 7 && date("m",time()) <=9) {
			$s_quar = strtotime(date("Y-7-1",time()));
		}else if (date("m",time()) >= 10 && date("m",time()) <=12) {
			$s_quar = strtotime(date("Y-10-1",time()));
		}
		/*获得当前半年的开始时间*/
		if (date("m",time()) > 6) {
			$s_half = strtotime(date("Y-7-1",time()));
		}else{
			$s_half = strtotime(date("Y-1-1",time()));
		}
		/*获得当前年的开始时间*/
		$s_year = strtotime(date("Y-1-1",time()));

		/*查询寿险*/
		/*本月 保单类型为寿险，保单状态有效，承保时间在本月内*/
		$life_month = $this->get_arr($s_month,$s_day,1,1);
		//dump($life_month);
		/*本季度*/
		$life_quar = $this->get_arr($s_quar,$s_day,1,2);
		//dump($life_quar);
		/*本半年*/
		$life_half = $this->get_arr($s_half,$s_day,1,3);
		/*本年*/
		$life_year = $this->get_arr($s_year,$s_day,1,4);

		$life_res  = $this->merge_arr($life_month,$life_quar,$life_half,$life_year);
		//dump($life_res);
		$this->add_value($life_res,1);
		/*查询车险*/
		/*本月*/
		$car_month = $this->get_arr($s_month,$s_day,2,1);
		/*本季度*/
		$car_quar = $this->get_arr($s_quar,$s_day,2,2);
		/*本半年*/
		$car_half = $this->get_arr($s_half,$s_day,2,3);
		/*本年*/
		$car_year = $this->get_arr($s_year,$s_day,2,4);

		$car_res  = $this->merge_arr($car_month,$car_quar,$car_half,$car_year);
		$this->add_value($car_res,2);

		/*查询非寿不含车险*/
		/*本月*/
		$non_month = $this->get_arr($s_month,$s_day,3,1);
		/*本季度*/
		$non_quar = $this->get_arr($s_quar,$s_day,3,2);
		/*本半年*/
		$non_half = $this->get_arr($s_half,$s_day,3,3);
		/*本年*/
		$non_year = $this->get_arr($s_year,$s_day,3,4);

		$non_res  = $this->merge_arr($non_month,$non_quar,$non_half,$non_year);
		$this->add_value($non_res,3);
	}
	 public function get_arr($start,$end,$type,$genre){
	 	/*$start开始时间 $end结束时间 $type排名类型(寿险、非寿险，车险) $genre 时间范围(本月，本季度，本半年，本年)*/
	 	/*判断排名类型，如果为1则是寿险，需计算价值保费，非寿险计算规模保费*/
	 	if ($type == 1) {
	 		$premium = "value_premium";
	 	}else{
	 		$premium = "insurance_premium";
	 	}
	 	/*判断时间范围，获得对应的字段名*/
	 	if ($genre == 1) {
	 		/*本月*/
	 		$sum = "mon_sum";
	 		$achieve = "mon_achieve";
	 		$ranking = "mon_ranking";
	 	}else if ($genre == 2) {
	 		/*本季度*/
	 		$sum = "quar_sum";
	 		$achieve = "quar_achieve";
	 		$ranking = "quar_ranking";
	 	}else if ($genre == 3) {
	 		/*本半年*/
	 		$sum = "half_sum";
	 		$achieve = "half_achieve";
	 		$ranking = "half_ranking";
	 	}else if ($genre == 4) {
	 		/*本年*/
	 		$sum = "year_sum";
	 		$achieve = "year_achieve";
	 		$ranking = "year_ranking";
	 	}
	 	$insurance = M("insurance");
	 	/*查询寿险保单，按照会员编码分组*/
	 	$result = $insurance ->where("insurance_type = ".$type." && policy_status = 1 && insured_date between ".$start." and ".$end)
					    	 ->field("salesman_number,SUM(".$premium.") as premium,count(policy_number) as number")
							 ->group("salesman_number")
							 ->select();	
		/*按照钱数排序*/
		$res  = $this->arrSort($result,"premium",$ranking);
		/*重构数组，将对应数存入新数组*/
		$info = array();
		foreach ($res as $key => $value) {
			$info[$value["salesman_number"]]["member_id"] = $value["salesman_number"];
			$info[$value["salesman_number"]][$sum]     = $value["number"];
			$info[$value["salesman_number"]][$achieve] = $value["premium"];
			$info[$value["salesman_number"]][$ranking] = $value[$ranking];
			$info[$value["salesman_number"]]["ranking_type"] = $type;
			$info[$value["salesman_number"]]["ranking_time"] = time();
		}
		return $info;
		//dump($info);
		/*将数据存入数据库*/
/*		$this->add_value($info,$type);*/
	 }

	 public function add_value($arr,$type){
	 	/*实例化业绩表*/
	 	$performance = M("insu_mem_performance");
	 	foreach ($arr as $key => $value) {
	 		$where["member_id"] = $value["member_id"];
	 		$where["ranking_type"] = $type;
	 		/*查询数据库，如果有值则更新，没值则添加*/
	 		$res = $performance->where($where)
	 						   ->field("id")
	 						   ->find();
	 		/*判断结果*/
	 		if ($res != "") {
	 			//如果在则更新
	 			$re = $performance ->where($where)
	 						       ->save($value);
	 			//echo $re."<br/>";
	 		}else{
	 			//不在，添加
	 			$re = $performance ->add($value);
	 			//echo $re."<br/>";
	 		}
	 	}

	 }
	 /*排序方法*/
	 public function arrSort($arr,$pay='premium',$ranking){
        $addinfo = array();
        foreach($arr as $v){
            $addinfo[] = $v[$pay];  
        }

        array_multisort($addinfo,SORT_DESC,$arr);//数组排序
        //将排名追加到数组中
        foreach($arr as $key=>$val){
            $arr[$key][$ranking] = $key+1;
        }
        return $arr;
    }
    /*合并数组*/
   	public function merge_arr($month,$quar,$half,$year){
   		 $i = 0;
   		/*判断如果月业绩为空*/
   		if (empty($month) && !empty($quar) && !empty($half) && !empty($year) ) {
   			/*查询补集，将补集的值存入数组中*/
   			$one = array_intersect_key($quar,$half,$year);
   			foreach ($one as $key => $value) {
   				$result[$i] = array_merge($quar[$key],$half[$key],$year[$key]);
   				$i++;
   			}
   			foreach ($result as $key => $value) {
   				$result[$key]["mon_sum"] = 0;
   				$result[$key]["mon_achieve"] = 0;
   				$result[$key]["mon_ranking"] = 0;
   			}
   			/*判断季度业绩为空*/
   		}else if (empty($month) && empty($quar) && !empty($half) && !empty($year)) {
   			/*查询补集，将补集的值存入数组中*/
   			$one = array_intersect_key($half,$year);
   			foreach ($one as $key => $value) {
   				$result[$i] = array_merge($half[$key],$year[$key]);
   				$i++;
   			}
   			//dump($result);
   			foreach ($result as $key => $value) {
   				$result[$key]["mon_sum"] = 0;
   				$result[$key]["mon_achieve"] = 0;
   				$result[$key]["mon_ranking"] = 0;
   				$result[$key]["quar_sum"] = 0;
   				$result[$key]["quar_achieve"] = 0;
   				$result[$key]["quar_ranking"] = 0;
   			}
   			
   		}else if (empty($month) && empty($quar) && empty($half) && !empty($year)) {
   			foreach ($year as $key => $value) {
   				$result[$key]["mon_sum"] = 0;
   				$result[$key]["mon_achieve"] = 0;
   				$result[$key]["mon_ranking"] = 0;
   				$result[$key]["quar_sum"] = 0;
   				$result[$key]["quar_achieve"] = 0;
   				$result[$key]["quar_ranking"] = 0;
   				$result[$key]["half_sum"] = 0;
   				$result[$key]["half_achieve"] = 0;
   				$result[$key]["half_ranking"] = 0;
   				$result[$key]["year_sum"] = $value["year_sum"];
   				$result[$key]["year_achieve"] = $value["year_achieve"];
   				$result[$key]["year_ranking"] = $value["year_ranking"];
   			}
   		}else if (!empty($month) && !empty($quar) && !empty($half) && !empty($year)) {
   			$one = array_intersect_key($quar,$half,$year);
   			foreach ($one as $key => $value) {
   				$result[$i] = array_merge($quar[$key],$half[$key],$year[$key]);
   				$i++;
   			}
   		}
   		return $result;
   	}
}
?>
