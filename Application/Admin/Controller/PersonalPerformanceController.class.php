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
				/*搜索条件*/
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

			S($sign,$result,86400);
			$result = S($sign);
		}else{
			//S($sign,NULL);
			$result = S($sign);	
		}






		$res["data"] = $result;
		$this->ajaxReturn($res);
		



		
	}
}
?>
