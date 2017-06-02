<?php
namespace Admin\Controller;
use Common\Controller\AdminbaseController;
/*功能：服务费配置
  时间：2017.5.22
  作者： LY
*/
class ServiceConfigController extends AdminbaseController
{

	public function index(){
		$this->display();
	}
	public function get_value(){
		$service = M("service_fee_config");
		$result  = $service ->find();
		 $this->ajaxReturn($result);
	}
	/*数据更新*/
	public function storager(){
		$column = I("column");
		$value  = I("value");
		//*更改数据库中的值*/
		if ($column == "empty_time" && $value>12) {
			echo 1;
		}else if ($column == "empty_time" && $value<1) {
			echo 2;
		}else if ($column != "empty_time" && $value>1){
			echo 3;
		}else{
			$service = M("service_fee_config");
			$data[$column] = $value;
			$result  = $service->where("id = 1")->save($data);

			$res = $service->where("id = 1")->field($column)->find();

			echo  json_encode($res[$column]);
		}
	}


	public function select(){
		$this->display();
	}
	public function lookup(){
		$org_type = I("org_type");
		$org_code = I("org_code");
		$member   = I("member");

		$table = M("member");
		$where  = array();
		/*设置返回数组*/
		$arr = array();
		/*判断条件，如果三个条件都为空，则不显示任何提示*/
		if ($org_type == 0 && $org_code == "所属店铺编号" && $member == "会员编号" ) {
			/*不做任何提示*/
			echo 1;
		}else if ($org_type != 0 && $org_code == "所属店铺编号" && $member == "会员编号") {
			/*提示请输入店铺编号或会员编号*/
			echo 2;
		}else if ($org_type == 0 && $org_code != "所属店铺编号" && $member == "会员编号") {
			/*提示请选择机构类型*/
			echo 3;
		}else if ($org_type != 0 && $org_code != "所属店铺编号" && $member != "会员编号") {
			/*根据条件查询数据库*/
			if ($org_type == 1) {
				$where["branch_shop_number"] = $org_code;
			}else if ($org_type == 2) {
				$where["flagship_number"] = $org_code;
			}else if ($org_type == 3) {
				$where["shop_number"] = $org_code;
			}
			$where["m_number"] = $member;
			/*查询数据库*/
			$result = $table ->where($where)
							  ->field("m_number,name,mobile,total_income,cash_income,current_income")
							  ->select();
			foreach ($result as $key => $value) {
				$result[$key]["draw"] = "<a href=".U("Admin/ServiceConfig/cash_record",array("m_number"=>$value["m_number"]))." >查看</a>";
				$result[$key]["look"] = "<a href=".U("Admin/ServiceConfig/cash_pay",array("m_number"=>$value["m_number"]))." >查看</a>";
			}
			$res["data"]=$result;
			$this->ajaxReturn($res);
		}else if ($org_type != 0 && $org_code != "所属店铺编号" && $member == "会员编号") {
			if ($org_type == 1) {
				$where["branch_shop_number"] = $org_code;
			}else if ($org_type == 2) {
				$where["flagship_number"] = $org_code;
			}else if ($org_type == 3) {
				$where["shop_number"] = $org_code;
			}
			/*查询数据库*/
			$result = $table ->where($where)
							  ->field("m_number,name,mobile,total_income,cash_income,current_income")
							  ->select();
			foreach ($result as $key => $value) {
				$result[$key]["draw"] = "<a href=".U("Admin/ServiceConfig/cash_record",array("m_number"=>$value["m_number"]))." >查看</a>";
				$result[$key]["look"] = "<a href=".U("Admin/ServiceConfig/cash_pay",array("m_number"=>$value["m_number"]))." >查看</a>";
			}
			$res["data"]=$result;
			$this->ajaxReturn($res);
		}else if ($member != "会员编号") {
			$where["m_number"]   = $member;
			/*查询数据库*/
			$result = $table ->where($where)
							  ->field("m_number,name,mobile,total_income,cash_income,current_income")
							  ->select();
			foreach ($result as $key => $value) {
				$result[$key]["draw"] = "<a href=".U("Admin/ServiceConfig/cash_record",array("m_number"=>$value["m_number"]))." >查看</a>";
				$result[$key]["look"] = "<a href=".U("Admin/ServiceConfig/cash_pay",array("m_number"=>$value["m_number"]))." >查看</a>";
			}
			$res["data"]=$result;
			$this->ajaxReturn($res);
		}

	}
	/*提现记录控制器*/
	public function cash_record(){

		$m_number = I("m_number");
		$this->assign("m_number",$m_number);
		$this->display();
	}
	/*查询提现记录*/
	public function get_record(){
		$m_number = I("m_number");
		if ($m_number) {
			/*根据会员编码查询会员提现记录表，以时间排序*/
			$member_cash = M("member_cash");
			/*制作查询条件*/
			$where["m_number"] = $m_number;
			/*查询结果*/
			$result = $member_cash->where($where)
								  ->order("time desc")
								  ->field("m_number,name,money,time,status,account_number")
								  ->select();
			/*判断查询结果*/
			if ($result == "") {
				echo 1;
			}else{
				/*循环结果，将状态中的0 1改为成功失败，并将时间戳格式的时间改为年月日格式*/
				foreach ($result as $key => $value) {
					if ($value["status"] == 0) {
						$result[$key]["status"] = "失败";
					}else if ($value["status"] == 1) {
						$result[$key]["status"] = "成功";
					}
					$result[$key]["date"] = date("Y-m-d",$value["time"]);
				}
				$res["data"] = $result;
				$this->ajaxReturn($res);
			}
		}		
	}
	/*工资条详细页*/
	public function cash_pay(){
		$m_number = I("m_number");
		$this->assign("m_number",$m_number);
		$this->display();
	}
	/*查看工资条*/
	public function get_pay(){
		$m_number = I("m_number");
		if ($m_number) {
			$result = $this->get_pay_value($m_number);
			/*判断结果，如果结果为空，则返回1*/
			if ($result == "") {
				echo 1;
			}else{
				/*返回ajax结果*/
				$res["data"] = $result;
				$this->ajaxReturn($res);
			}
			
		}
	}
	/*查询服务费计算表*/
	public function get_pay_value($m_number){
		/*实例化服务费计算表*/
		$service_fee = M("service_fee_calculation");
		/*获得当前月*/
		$cur_month = strtotime(date("Y-m",time()));
		/*制作搜索条件*/
		$where = array();
		/*判断当前时间，如果大于每月的21号0:0:0则计算当前6个月，包括这个月*/
		if (date("d",time()) > 21) {
			/*获得之前一个月*/
			$last_one = strtotime("-1 Month",$cur_month);
			/*获得之前第二个月*/
			$last_two = strtotime("-2 Months",$cur_month);
			/*获得之前第三个月*/
			$last_three = strtotime("-3 Months",$cur_month);
			/*获得之前第四个月*/
			$last_four  = strtotime("-4 Months",$cur_month);
			/*获得之前第五个月*/
			$last_five  = strtotime("-5 Months",$cur_month);
			/*制作搜索条件*/
			$where[0]["m_number"] = $m_number;
			$where[0]["month"] = $cur_month;

			$where[1]["m_number"] = $m_number;
			$where[1]["month"] = $last_one;

			$where[2]["m_number"] = $m_number;
			$where[2]["month"] = $last_two;

			$where[3]["m_number"] = $m_number;
			$where[3]["month"] = $last_three;

			$where[4]["m_number"] = $m_number;
			$where[4]["month"] = $last_four;

			$where[5]["m_number"] = $m_number;
			$where[5]["month"] = $last_five;
			
		}else {
			/*计算之前6个月*/
			/*获得之前一个月*/
			$last_one = strtotime("-1 Month",$cur_month);
			/*获得之前第二个月*/
			$last_two = strtotime("-2 Months",$cur_month);
			/*获得之前第三个月*/
			$last_three = strtotime("-3 Months",$cur_month);
			/*获得之前第四个月*/
			$last_four  = strtotime("-4 Months",$cur_month);
			/*获得之前第五个月*/
			$last_five  = strtotime("-5 Months",$cur_month);
			/*获得之前第六个月*/
			$last_six   = strtotime("-6 Months",$cur_month);
			/*制作搜索条件*/
			$where[0]["m_number"] = $m_number;
			$where[0]["month"] = $last_one;

			$where[1]["m_number"] = $m_number;
			$where[1]["month"] = $last_two;

			$where[2]["m_number"] = $m_number;
			$where[2]["month"] = $last_three;

			$where[3]["m_number"] = $m_number;
			$where[3]["month"] = $last_four;

			$where[4]["m_number"] = $m_number;
			$where[4]["month"] = $last_five;

			$where[5]["m_number"] = $m_number;
			$where[5]["month"] = $last_six;		
		}
		$res = array();
		$i = 0;
		foreach ($where as $key => $value) {
			/*根据条件查询服务费计算表*/
			$result = $service_fee ->where($value)
								   ->field("m_number,initial_service,renewal_service,nonlife_service,manage_interest,bred_interest,flagship_service,Debit,deduction,actual_pay,already_pay,Should_pay,on_line,off_line,Month")
							 	  ->find();
			/*判断结果是否有值*/
			if ($result) {
				foreach ($result as $k => $v) {
					/*如果某项结果为空，则赋值0*/
					if ($v == "") {
						$result[$k] = 0;
					}
					/*将时间戳格式改为年月格式*/
					if ($k == "month") {
						$result[$k] = date("Y-m",$v);
					}
				}
				/*将修改后的结果存入数组当中*/
				$res[$i] = $result;
				$i++;
			}
		}

		return $res;
	}



	/*定时任务，计算续期品质系数*/
	public function get_renew_factor(){
		/*获得当前时间*/
		$current_time = time();
		/*拿出当前时间的日期*/
		$current_day  = date("d",$current_time);
		/*判断当前日如果为1号，那么执行下面程序*/
		if ($current_day == 1) {
			/*计算续保日期*/
			$renew_start_time = strtotime("-3 Months",$current_time);
			/*续保开始日期的零时零分零秒*/
			$renew_start_date = date("Y-m-d",$renew_start_time);
			$renew_start_time = strtotime($renew_start_date);
			/*续保结束日期*/
			$renew_end_time = strtotime("+3 Months,-1 second",$renew_start_time);
			/*获得承保开始时间*/
			$insured_start_time = strtotime("-1 year",$renew_start_time);
			/*获得承保结束时间*/
			$insured_end_time   = strtotime("-1 year",$renew_end_time);

			/*查询续期保单表和缴费日期表*/
			$insurance = M("insurance_re");
			$coefficient_continuous = M("coefficient_continuous");
			$result = $insurance ->table("insurance_re as i")
								 ->join("renew as r on r.insurance_num = i.policy_number")
								 ->where("i.insured_date between ".$insured_start_time." and ".$insured_end_time." and
								 		  r.two_time between ".$renew_start_time." and ".$renew_end_time)
								 ->field("i.salesman_number,i.insurance_premium,i.real_insurance_premium")
								 ->select();
			/*设计新数组*/
			$new_arr = array();
			foreach ($result as $key => $value) {
				$new_arr[$value["salesman_number"]]["insurance_premium"] +=$value["insurance_premium"];
				$new_arr[$value["salesman_number"]]["real_insurance_premium"] +=$value["real_insurance_premium"];
			}
			/*将数组中的应收和实收保费换算成继续率*/
			$rato = array();
			foreach ($new_arr as $key => $value) {
				$rato[$key] = $value["real_insurance_premium"]/$value["insurance_premium"];
			}
			/*将利用继续率找到续期品质系数*/
			$coefficient = array();
			foreach ($rato as $key => $value) {
				$result = $coefficient_continuous->where($value." between mincontinues and maxcontinues")
												 ->field("coefficient")
												 ->find();
				$coefficient[$key]["coefficient"] = $result["coefficient"];
				$coefficient[$key]["rato"] = $value;
			}
			//p($coefficient);

			$table = M("personal_coefficient");
			foreach ($coefficient as $key => $value) {
				/*判断个人续期品质系数表里是否有该成员的编号*/
				$result = $table->where("m_number = ".$key)->field("id")->find();
				if ($result) {
					/*更新*/
					$data["rate_continue"] = $value["rato"];
					$data["coefficient"]   = $value["coefficient"];
					$a = $table ->where("m_number = ".$key)
						   ->save($data);
				}else{
					/*添加*/
					$data["m_number"] = $key;
					$data["rate_continue"] = $value["rato"];
					$data["coefficient"]   = $value["coefficient"];
					$table ->add($data);
				}
			}
		}
	}
}
?>