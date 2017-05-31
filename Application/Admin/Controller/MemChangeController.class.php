<?php
namespace Admin\Controller;
use Common\Controller\AdminbaseController;
class MemChangeController extends AdminbaseController
{
	public function __construct() {
		parent::__construct();
		$this->member =D('Member');
		$this->profile =D('member_profile');

	}
	/*
	*  功能：会员异动查询
	*  时间：2017-05-11
	*  作者：lzt
	*/
	public function index(){
		$post = $_POST;
		if($post){
			//根据查询条件不同显示列表
			$where['a.status'] = array('egt','0');
			if($post['m_number']){
				$where['a.m_number'] = $post['m_number'];
			}
			if($post['mobile']){
				$where['a.mobile'] = $post['mobile'];
			}
			if($post['identity_card']){
				$where['b.identity_card'] = $post['identity_card'];
			}
			$mation = $this->member->alias('a')->where($where)
				->join('member_profile as b on a.m_number = b.m_number ','left')->join('new_contract_coefficient as c on a.m_number = c.m_number ','left')
				->field('a.mid,a.name,a.m_number,b.gender,a.mobile,b.member_num,a.member_level,a.recommend_member_id,
						 a.shop_number,a.flagship_number,a.branch_shop_number,a.register_time,b.identity_card,c.new_cont_cone')
				->find();
			$this->assign('info',$mation);
			$this->display();
		}else{
			//首次点击显示页面
			$this->display();
		}
	}

	/*
    *  功能：会员异动（总）
    *  时间：017-05-09
    *  时间：017-05-15
    *  作者：lzt
    */
	public function Change(){
		$POST = $_POST;
		$this->member->startTrans(); //开启事务
		//会员异动 根据条件判断异动职级或推荐人
		if($POST['type'] == 1){
			//会员异动职级修改
			$y_level =$POST['content'];
			$m_number =$POST['m_number'];
			//查询会员基本信息
			$where['a.m_number'] = $m_number;
			$minfo = $this->member->alias('a')->where($where)
				->join('member_profile as b on a.m_number = b.m_number ','left')->field('a.name,a.m_number,a.my_shop_number,a.mobile,a.member_level,
                        a.recommend_member_id,a.shop_number,a.flagship_number,a.branch_shop_number,a.email,b.province,b.city,b.district,b.address')
				->find();
			$m_level =$minfo['member_level'];
			//修改职级
			$res1 =  $this->LevelEdit($m_number,$m_level,$y_level,$minfo['my_shop_number']);
			//修改保单中的店铺代码
			$res2 =  $this->InsuranceEdit($m_number,$m_level,$y_level,$minfo['my_shop_number']);
			//修改旗下会员和育成店，店铺代码，保单代码,
			$res3 =  $this->UnderMemberEdit($minfo,$y_level);
			//根据异动职级不同进行判断
			switch ($y_level){
				//标准
				case 2:
					//普通改标准
					//创建机构(添加店铺)
					$res4 =  $this->OrganizationAdd($minfo,$y_level);
					break;
				//旗舰
				case 3:
					if($m_level == 0){
						//普通改旗舰
						//创建机构(添加店铺)
						$res4 =  $this->OrganizationAdd($minfo,$y_level);
					}else{
						//标准改旗舰
						//修改机构店铺等级
						$res4 =  $this->OrganizationEdit($minfo);
					}
					break;
			}
			if($res1&&$res3){
				$this->member->commit();//提交事务成功
				echo 1;
			}else{
				$this->member->rollback();//事务有错回滚
			}
		}else{
			//会员异动推荐人修改
			//推荐人普通 会员普通1
				//修改会员推荐人，标店，旗舰
				//修改会员保单标店，旗舰
				//修改旗下会员标店，旗舰
				//旗下会员标店长修改旗舰
				//修改旗下会员保单标店，旗舰
				//旗下会员标店长保单修改旗舰
			//推荐人普通 会员标店2
				//修改会员推荐人，旗舰
				//修改会员保单旗舰
				//修改旗下会员旗舰
				//修改旗下会员保单旗舰
			//推荐人普通 会员旗舰3
				//修改会员推荐人
			//推荐人标准 会员普通4
				//修改会员推荐人，标店，旗舰
				//修改会员保单标店，旗舰
				//修改旗下会员标店，旗舰
				//旗下会员标店长修改旗舰
				//修改旗下会员保单标店，旗舰
				//旗下会员标店长保单修改旗舰
			//推荐人标准 会员标店5
				//修改会员推荐人，旗舰
				//修改会员保单旗舰
				//修改旗下会员旗舰
			//推荐人标准 会员旗舰6
				//修改会员推荐人
			//推荐人旗舰 会员普通7
				//修改会员推荐人，标店，旗舰
				//修改会员保单标店，旗舰
				//修改旗下会员标店，旗舰
				//旗下会员标店长修改旗舰
				//修改旗下会员保单标店，旗舰
				//旗下会员标店长保单修改旗舰
			//推荐人旗舰 会员标店8
				//修改会员推荐人，旗舰
				//修改会员保单旗舰
				//修改旗下会员旗舰
			//推荐人旗舰 会员旗舰9
				//修改会员推荐人

			//判断是否为旗下会员
			$y_number =$POST['content'];
			$m_number =$POST['m_number'];
			$unnumber = $this->GetUnderNumber3($m_number);
			if(!in_array($y_number, $unnumber)){
				//查询推荐人信息等级
				$where['m_number'] = $y_number;
				$yinfo = $this->member->where($where)
					->field('m_number,my_shop_number,member_level,shop_number,flagship_number')
					->find();
				//查询会员信息
				$mwhere['m_number'] = $m_number;
				$minfo = $this->member->where($mwhere)
					->field('name,m_number,member_level,shop_number,flagship_number')
					->find();
				//推荐人职级与会员职级比较
				$ylevel = $yinfo['member_level'];
				$mlevel = $minfo['member_level'];

				if(($ylevel==0||$ylevel==1)&&($mlevel==0||$mlevel==1)){
					//推荐人普通 会员普通
					$status = 1;
				}elseif (($ylevel==0||$mlevel==1)&&($mlevel==2)){
					//推荐人普通 会员标店
					$status = 2;
				}elseif (($ylevel==0||$mlevel==1)&&($mlevel==3)){
					//推荐人普通 会员旗舰
					$status = 3;
				}elseif (($ylevel==2)&&($mlevel==0||$mlevel==1)){
					//推荐人标准 会员普通
					$status = 4;
				}elseif (($ylevel==2)&&($mlevel==2)){
					//推荐人标准 会员标店
					$status = 5;
				}elseif (($ylevel==2)&&($mlevel==3)){
					//推荐人标准 会员旗舰
					$status = 6;
				}elseif (($ylevel==3)&&($mlevel==0||$mlevel==1)){
					//推荐人旗舰 会员普通
					$status = 7;
				}elseif (($ylevel==3)&&($mlevel==2)){
					//推荐人旗舰 会员标店
					$status = 8;
				}elseif (($ylevel==3)&&($mlevel==3)){
					//推荐人旗舰 会员旗舰
					$status = 9;
				}
				//根据不同的状态判断修改内容
				switch ($status){
					//会员普通
					case (1||4||7): //推荐人普通  //推荐人标准   //推荐人旗舰
						//修改会员推荐人，标店，旗舰
						$res1 = $this->RecommendEdit($m_number,$yinfo,1);
						//修改会员保单标店，旗舰
						$res2 = $this->

						RecInsuranceEdit($m_number,$yinfo,1);
						//修改旗下会员标店，旗舰
						$res3 =  $this->RecUnderMemEdit($m_number,$yinfo,1);
						if($res1&&$res3){
							$this->member->commit();//提交事务成功
							$this->ajaxreturn(1);
						}else{
							$this->member->rollback();//事务有错回滚
						}
						break;
					//会员标店
					case (2||5||8):  //推荐人普通   //推荐人标准   //推荐人旗舰
						//修改会员推荐人，旗舰
						$res1 = $this->RecommendEdit($m_number,$yinfo,2);
						//修改会员保单旗舰
						$res2 = $this->RecInsuranceEdit($m_number,$yinfo,2);
						//修改旗下会员旗舰
						$res3 =  $this->RecUnderMemEdit($m_number,$yinfo,2);
						if($res1&&$res2&&$res3){
							$this->member->commit();//提交事务成功
							$this->ajaxreturn(1);
						}else{
							$this->member->rollback();//事务有错回滚
						}
						break;
					//会员旗舰
					case (3||6||9):  //推荐人普通   //推荐人标准   //推荐人旗舰
						//修改会员推荐人
						$res1 = $this->RecommendEdit($m_number,$yinfo);
						if($res1){
							$this->member->commit();//提交事务成功
							$this->ajaxreturn(1);
						}else{
							$this->member->rollback();//事务有错回滚
						}
						break;
				}
			}else{
				$this->member->rollback();//事务有错回滚
				$this->ajaxreturn(2);
			}
		}
	}


	/*
    *  功能：会员异动推荐人（修改旗下会员和育成店，店铺代码，保单店铺代码）
    *  时间：2017-05-19
    *  作者：lzt
    */
	public function RecUnderMemEdit($m_number,$yinfo,$type){

		//根据会员职级不同进行判断
		switch ($type){
			//会员普通
			case 1:
					//查询旗下会员
				$u_number = $this->GetUnderNumber2($m_number);
					if($u_number['res2']||$u_number['res1']){
						//判断旗下标准店是否存在 如果存在则修改所属旗舰店
						if($u_number['res2']){
							//修改会员所属旗舰店
							$where['m_number'] =  array('in',$u_number['res2']);
							$data['flagship_number'] = $yinfo['flagship_number'];
							$res1 =$this->member->where($where)->data($data)->save();
							//修改会员保单的所属旗舰店
							$where['salesman_number'] = array('in',$u_number['res2']);
							$data['flag_shop_number'] = $yinfo['flagship_number'];
							$res2 =M('insurance')->where($where)->data($data)->save();
							$res3 =M('insurance_re')->where($where)->data($data)->save();
							if($res1){
								$res = 1;
							}
						}else{
							$res = 1;
						}
						//判断旗下会员是否存在 如果存在则修改所属旗舰店，所属标准店
						if($u_number['res1']){
							//修改会员标准店,所属标准店
							$where['m_number'] =  array('in',$u_number['res1']);
							$data['shop_number'] = $yinfo['shop_number'];
							$data['flagship_number'] = $yinfo['flagship_number'];
							$res4 =$this->member->where($where)->data($data)->save();
							//修改会员保单的标准店,所属标准店
							$where['salesman_number'] = array('in',$u_number['res1']);
							$data['standard_shop_number'] = $yinfo['shop_number'];
							$data['flag_shop_number'] = $yinfo['flagship_number'];
							$res5 =M('insurance')->where($where)->data($data)->save();
							$res6 =M('insurance_re')->where($where)->data($data)->save();
							if($res4){
								$res0 = 1;
							}
						}else{
							$res0 = 1;
						}
						if($res&&$res0){
							return 1;
						}
					}else{
						return 1;
					}

				break;
			//会员标店
			case 2:
				//获取旗下会员的代码
				$u_number = $this->GetUnderNumber3($m_number);
				//判断旗下会员是否存在 如果存在则修改所属标准店
				if($u_number) {
					//修改会员所属旗舰店
					$where['m_number'] =  array('in',$u_number);
					$data['flagship_number'] = $yinfo['flagship_number'];
					$res1 =$this->member->where($where)->data($data)->save();
					//修改会员保单的所属旗舰店
					$where['salesman_number'] = array('in',$u_number);
					$data['flag_shop_number'] = $yinfo['flagship_number'];
					$res2 =M('insurance')->where($where)->data($data)->save();
					$res3 =M('insurance_re')->where($where)->data($data)->save();
					if($res1){
						return 1;
					}
				}else{
					return 1;
				}
				break;
		}
	}

	/*
    *  功能：会员异动（修改旗下会员和育成店，店铺代码，保单店铺代码）
    *  时间：2017-05-15
    *  作者：lzt
    */
	public function UnderMemberEdit($minfo,$y_level){
		$res1 = $res2 = $res3 = $res4= $res5= $res6= 1;
		//根据异动职级不同进行判断
		switch ($y_level){
			//标准
			case 2:
				//普通改标准
				//获取旗下会员的代码
				$m_number = $this->GetUnderNumber($minfo['m_number']);
				//判断旗下会员是否存在 如果存在则修改所属标准店
				if($m_number) {
					//修改会员标准店
					$where['m_number'] = array('in', $m_number);
					$data['shop_number'] = $minfo['my_shop_number'];
					$res1 = $this->member->where($where)->data($data)->save();
					//修改会员保单的标准店
					$where['salesman_number'] = array('in', $m_number);
					$data['standard_shop_number'] = $minfo['my_shop_number'];
					$res2 = M('insurance')->where($where)->data($data)->save();
					$res3 = M('insurance_re')->where($where)->data($data)->save();
				}
				break;
			//旗舰
			case 3:
				if($minfo['member_level'] == 0){
					//普通改旗舰
					//查询旗下会员
					$m_number = $this->GetUnderNumber2($minfo['m_number']);
					//判断旗下标准店是否存在 如果存在则修改所属旗舰店
					if($m_number['res2']){
						//修改会员所属旗舰店
						$where['m_number'] =  array('in',$m_number['res2']);
						$data['flagship_number'] = $minfo['my_shop_number'];
						$res1 =$this->member->where($where)->data($data)->save();
						//修改会员保单的所属旗舰店
						$where['salesman_number'] = array('in',$m_number['res2']);
						$data['flag_shop_number'] = $minfo['my_shop_number'];
						$res2 =M('insurance')->where($where)->data($data)->save();
						$res3 =M('insurance_re')->where($where)->data($data)->save();
					}
					//判断旗下会员是否存在 如果存在则修改所属旗舰店，所属标准店
					if($m_number['res1']){
						//修改会员标准店,所属标准店
						$where['m_number'] =  array('in',$m_number['res1']);
						$data['shop_number'] = $minfo['my_shop_number'];
						$data['flagship_number'] = $minfo['my_shop_number'];
						$res4 =$this->member->where($where)->data($data)->save();
						//修改会员保单的标准店,所属标准店
						$where['salesman_number'] = array('in',$m_number['res1']);
						$data['standard_shop_number'] = $minfo['my_shop_number'];
						$data['flag_shop_number'] = $minfo['my_shop_number'];
						$res5 =M('insurance')->where($where)->data($data)->save();
						$res6 =M('insurance_re')->where($where)->data($data)->save();
					}
				}else{
					//标准改旗舰
					//查询所有会员，查询所有育成店会员修改所属旗舰店
					$m_number = $this->GetUnderNumber3($minfo['m_number']);
					if($m_number){
						//修改会员的所属旗舰店
						$where['m_number'] =  array('in',$m_number);
						$data['flagship_number'] = $minfo['my_shop_number'];
						$res1 =$this->member->where($where)->data($data)->save();
						//修改会员保单的所属旗舰店
						$where['salesman_number'] = array('in',$m_number);
						$data['flag_shop_number'] = $minfo['my_shop_number'];
						$res2 =M('insurance')->where($where)->data($data)->save();
						$res3 =M('insurance_re')->where($where)->data($data)->save();
					}
				}
				break;
		}
		if($res1){
			return 1;
		}
	}

	/*
	*  功能：递归查询旗下所有会员（普通改标准）
	*  时间：017-05-15
	*  作者：lzt
	*/
	public function GetUnderNumber($m_number){
		$where['recommend_member_id'] = array('in',$m_number);
		$where['member_level'] = array('lt',2);
		$number = $this->member->where($where)->getField('m_number',true);
		static $res = array();
		if($number){
			foreach ($number as $k=>$v){
				array_push($res,$v);
			}
				return	$this->GetUnderNumber($number);
		}else{
			return $res;

		}
	}


	/*
	*  功能：递归查询旗下所有会员2（普通改旗舰）
	*  时间：017-05-16
	*  作者：lzt
	*/
	public function GetUnderNumber2($m_number){
		$where['recommend_member_id'] = array('in',$m_number);
		$where['member_level'] = array('lt',3);
		$number = $this->member->where($where)->field('principal_number,status')->select();
		//普通改旗舰 业务员修改所属标准店 所属旗舰店  标准店及旗下会员需要修改所属旗舰店
		static $res1 = array();  //业务员代码
		static $res2 = array();  //标准店代码
		$number2 = array();
		if($number){
			foreach ($number as $k=>$v){
				if($v['member_level'] == 2 ){
					array_push($res2,$v['m_number']);
				}else{
					array_push($res1,$v['m_number']);
					array_push($number2,$v['m_number']);
				}
			}
			return	$this->GetUnderNumber($number2);
		}else{
			//查询标准店旗下会员的代码
			if($res2){
				$res2n = $this->GetUnderNumber3($res2);
			}
			$res['res1'] = $res1;
			$res['res2'] = $res2n;
			return $res;
		}
	}


	/*
	*  功能：递归查询旗下所有会员3（标准改旗舰）
	* 		 标准店改为旗舰店只需修改旗下会员及育成店和非育成店的所属旗舰店即可
	*  时间：017-05-16
	*  作者：lzt
	*/
	public function GetUnderNumber3($m_number){
		$where['recommend_member_id'] = array('in',$m_number);
		$where['member_level'] = array('lt',3);
		$number = $this->member->where($where)->getField('m_number',true);
		static $res = array();
		if($number){
			foreach ($number as $k=>$v){
				array_push($res,$v);
			}
			return	$this->GetUnderNumber3($number);
		}else{
			return $res;
		}

	}
	/*
	*  功能：会员异动（推荐人修改）
	*  时间：2017-05-19
	*  作者：lzt
	*/
	public function RecommendEdit($m_number,$yinfo,$type){
		$where['m_number'] = $m_number;
		$data['recommend_member_id'] = $yinfo['m_number'];
		switch ($type){
			case 1:
				$data['shop_number'] = $yinfo['shop_number'];
				$data['flagship_number'] = $yinfo['flagship_number'];
				break;
			case 2:
				$data['flagship_number'] = $yinfo['flagship_number'];
				break;
		}
		$res =$this->member->where($where)->data($data)->save();
		if($res){
			return 1;
		}
	}

	/*
	*  功能：会员异动推荐人（保单修改）
	*  时间：2017-05-19
	*  作者：lzt
	*/
	public function RecInsuranceEdit($m_number,$yinfo,$type){
		$where['salesman_number'] = $m_number;
		switch ($type){
			case 1:
				$data['standard_shop_number'] = $yinfo['shop_number'];
				$data['flag_shop_number'] = $yinfo['flagship_number'];
				break;
			case 2:
				$data['flag_shop_number'] = $yinfo['flagship_number'];
				break;
		}
		$res1 =M('insurance')->where($where)->data($data)->save();
		$res2 =M('insurance_re')->where($where)->data($data)->save();
		if($res1&&$res2){
			return 1;
		}
	}

	/*
	*  功能：会员异动（职级修改）
	*  时间：2017-05-15
	*  作者：lzt
	*/
	public function LevelEdit($m_number,$m_level,$y_level,$my_shop_number){
		$where['m_number'] = $m_number;
		$data['member_level'] = $y_level;
		//根据异动职级不同进行判断
		switch ($y_level){
			//标准
			case 2:
				//普通改标准
				$data['shop_number'] = $my_shop_number;
				break;
			//旗舰
			case 3:
				if($m_level == 0){
					//普通改旗舰
					$data['shop_number'] = $my_shop_number;
					$data['flagship_number'] = $my_shop_number;
				}else{
					//标准改旗舰
					$data['flagship_number'] = $my_shop_number;
				}
				break;
		}
		$res =$this->member->where($where)->data($data)->save();
		if($res){
			return 1;
		}
	}

	/*
	*  功能：会员异动（保单修改）
	*  时间：2017-05-15
	*  作者：lzt
	*/
	public function InsuranceEdit($m_number,$m_level,$y_level,$shop_number){
		$where['salesman_number'] = $m_number;
		switch ($y_level){
			//标准
			case 2:
				//普通改标准
				$data['standard_shop_number'] = $shop_number;
				break;
			//旗舰
			case 3:
				if($m_level == 0){
					//普通改旗舰
					$data['standard_shop_number'] = $shop_number;
					$data['flag_shop_number'] = $shop_number;
				}else{
					//标准改旗舰
					$data['flag_shop_number'] = $shop_number;
				}
				break;
		}
		$res1 =M('insurance')->where($where)->data($data)->save();
		$res2 =M('insurance_re')->where($where)->data($data)->save();
		if($res1&&$res2){
			return 1;
		}
	}

	/*
	*  功能：会员异动（创建机构(添加店铺)）
	*  时间：2017-05-15
	*  作者：lzt
	*/
	public function OrganizationAdd($minfo,$y_level)
	{
		$time = time();
		switch ($y_level) {
			//标准
			case 2:
				//普通改标准
				$data['org_code'] = $minfo['my_shop_number'];  //门店编码
				$data['flagship_code'] = $minfo['flagship_number']; //所属旗舰店编码
				$data['name'] = $minfo['name'] . "标准店铺";  //门店名称
				$data['level'] = 3; //门店级别 1分公司 2旗舰店 3标准店
				break;
			//旗舰
			case 3:
				//普通改旗舰
				$data['org_code'] = $minfo['my_shop_number'];  //门店编码
				$data['flagship_code'] = $minfo['my_shop_number']; //所属旗舰店编码
				$data['name'] = $minfo['name'] . "旗舰店铺";  //门店名称
				$data['level'] = 2; //门店级别 1分公司 2旗舰店 3标准店
				break;
		}
		$data['branch_shop_code'] = $minfo['branch_shop_number'];  //所属分公司代码
		$data['examine_standard'] = get_address_cate($minfo['province']);  //店铺考核标准类型 1=>A类 2=>B类 3=>C类
		$data['province_id'] = $minfo['province']; //'省份ID
		$data['city_id'] = $minfo['city'];  //城市ID
		$data['district_id'] = $minfo['district']; //城市ID
		$data['address'] = $minfo['address']; //详细地址
		$data['status'] = 0;  //门店状态 1=经营期 0=筹备期 -1=观察期
		$data['telphone'] = $minfo['mobile'];  //电话
		$data['email'] = $minfo['email']; //邮箱
		$data['principal_number'] = $minfo['m_number']; //会员编码
		$data['check_status'] = 1;  //店铺状态 1=有效 0=失效 考核不通过时将店铺设置为失效
		$data['create_time'] = $time;  //成立时间
		//根据当前时间计算筹备起止时间
		$setime = $this->SetTime($time);
		$data['start_time'] = $setime['stime'];   //筹备开始时间
		$data['end_time'] = $setime['etime'];    //筹备结束时间
		$res = M('organization')->data($data)->add();
		if($res){
			return 1;
		}
	}

	/*
	*  功能：会员异动（修改店铺职级，由标准店进入旗舰店筹备期）
	*  时间：2017-05-15
	*  作者：lzt
	*/
	public function OrganizationEdit($minfo){
		$time = time();
		$where['principal_number'] = $minfo['m_number']; //会员编码
		$data['flagship_code'] = $minfo['my_shop_number']; //所属旗舰店编码
		$data['level'] = 2; //门店级别 1分公司 2旗舰店 3标准店
		$data['status'] = 0;  //门店状态 1=经营期 0=筹备期 -1=观察期
		$data['create_time'] = $time;  //成立时间
		//根据当前时间计算筹备起止时间
		$setime = $this->SetTime($time);
		$data['start_time'] = $setime['stime'];   //筹备开始时间
		$data['end_time'] = $setime['etime'];    //筹备结束时间
		$res = M('organization')->where($where)->data($data)->save();
	
		if($res){
			return $res;
		}
	}

	/*
	*  功能：根据给定时间计算筹备起止时间
	*  时间：2017-05-15
	*  作者：lzt
	*/
	public function SetTime($time){
		$syear = date('Y', $time);
		$smonth = date('m', $time);
		//计算开始时间
		//mktime(时,分,秒,月,天,年,is_dst);
		$setime['stime'] = mktime(0,0,0,$smonth,1,$syear);
		//计算结束时间
		$emonth = $smonth+3;
		if($emonth > 12 ){
			$emonth = $emonth - 12;
			$eyear = $syear +1;
		}else{
			$eyear = $syear;
		}
		$setime['etime'] = mktime(0,0,0,$emonth,1,$eyear);
		return $setime;
	}



}
?>