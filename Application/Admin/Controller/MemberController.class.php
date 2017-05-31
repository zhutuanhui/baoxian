<?php
namespace Admin\Controller;
use Common\Controller\AdminbaseController;
class MemberController extends AdminbaseController
{
	public function __construct() {
		parent::__construct();
		$this->member =D('Member');
		$this->profile =D('member_profile');

	}
	/*
	*  功能：会员查询列表页
	*  时间：2017-05-09
	*  作者：lzt
	*/
	public function index(){
		$post = $_POST;
		if($post){
			//根据查询条件不同显示列表
			$logtime['logmin'] = strtotime($post['logmin']);
			$logtime['logmax'] = strtotime($post['logmax']);
			$where['a.status'] = array('egt','0');
			if($post['logmin']&&$post['logmax']){
				$where['a.register_time'] = array('between',$logtime);
			}
			if($post['name']){
				$where['a.name'] = array('like',"%".$post['name']."%");
			}
			if($post['mobile']){
				$where['a.mobile'] = $post['mobile'];
			}
			if($post['identity_card']){
				$where['b.identity_card'] = $post['identity_card'];
			}
			$mation = $this->member->alias('a')->where($where)
				->join('member_profile as b on a.m_number = b.m_number ','left')->join('new_contract_coefficient as c on a.m_number = c.m_number ','left')
				->field('a.mid,a.name,a.m_number,b.gender,a.mobile,b.member_num,a.member_level,b.identity_card,c.new_cont_cone')
				->select();
			$time=$post['logmin'].'-'.$post['logmax'];
			S('time',$time,1200);
			S('where',$where,1200);
			$this->assign('info',$mation);
			$this->display();
		}else{
			//首次点击显示页面
			$this->display();
		}
	}
	
	/*
	*  功能：会员增加编辑页
	*  时间：017-05-09
	*  作者：lzt
	*/
	public function addedit(){
		$get = $_GET;
		if($get){
			//根据查询条件不同显示列表
			$where['a.m_number'] = $get['m_number'];
			$mation = $this->member->alias('a')->where($where)
				->join('member_profile as b on a.m_number = b.m_number ','left')->join('new_contract_coefficient as c on a.m_number = c.m_number ','left')
				->field('a.name,a.m_number,a.my_shop_number,a.mobile,a.email,a.check_status,a.integral,a.status,a.member_level,a.shop_number,a.flagship_number,a.branch_shop_number,
						b.gender,b.education,b.identity_card,b.bank_card,b.bank_name,b.birthday,b.province,b.city,b.district,b.address,b.weixin,b.qq,b.member_num,
						c.new_cont_cone')
				->find();
			$this->assign('info',$mation);
			//	地址三级联动
			$result=district($level='1',$pid='0');
			$this->assign('province',$result);
			$this->display();
		}else{
			//首次点击显示页面
			//	地址三级联动
			$result=district($level='1',$pid='0');
			$this->assign('province',$result);
			$this->display();
		}
	}

	/*
	*  功能：会员增加编辑保存
	*  时间：017-05-09
	*  作者：lzt
	*/
	public function AddEditDo(){

		$post = $_POST;

		if($post['m_number']){

			//会员修改
			//会员表修改
			$member['name'] = $post['name'];
			$member['mobile'] = $post['mobile'];
			$member['email'] = $post['email'];
			$member['check_status'] = $post['check_status'];
			$member['status'] = $post['status'];
			$where['m_number'] = $post['m_number'];
			$this->member->startTrans(); //开启事务
			$rese = $this->member->where($where)->data($member)->save();

			//会员详情表修改
			$profile['gender'] = $post['gender'];
			$profile['education'] = $post['education'];
			$profile['identity_card'] = $post['identity_card'];
			$profile['bank_card'] = $post['bank_card'];
			$profile['bank_name'] = $post['bank_name'];
			$profile['birthday'] = $post['birthday'];
			$profile['province'] = $post['province'];
			$profile['city'] = $post['city'];
			$profile['district'] = $post['district'];
			$profile['address'] = $post['address'];
			$profile['weixin'] = $post['weixin'];
			$profile['qq'] = $post['qq'];
			$profile['member_num'] = $post['member_num'];
			$rese2 = $this->profile->where($where)->data($profile)->save();
			if($rese||$rese2){
				$this->member->commit();//提交事务成功
				$data['status']  = 1;

			}else{
				$this->member->rollback();//事务有错回滚
				$data['status']  = 0;
			}
			$this->ajaxReturn($data);

		}else{
			//会员添加
			//会员表添加
			$member['name'] = $post['name'];
			$m_number=$this->setnum();
			$member['m_number'] = $m_number;
			$member['my_shop_number'] = $m_number;
			$member['mobile'] = $post['mobile'];
			$member['email'] = $post['email'];
			$member['check_status'] = $post['check_status'];
			$member['status'] = $post['status'];
			$member['member_level'] = $post['member_level'];
			$member['register_time'] = time();
			$this->member->startTrans(); //开启事务
			$rese = $this->member->data($member)->add();

			if(!$rese){
				$this->member->rollback();//事务有错回滚
				$data['status']  = 0;
			}
			//会员详情表添加
			$profile['m_number'] = $m_number;
			$profile['gender'] = $post['gender'];
			$profile['education'] = $post['education'];
			$profile['identity_card'] = $post['identity_card'];
			$profile['bank_card'] = $post['bank_card'];
			$profile['bank_name'] = $post['bank_name'];
			$profile['birthday'] = $post['birthday'];
			$profile['province'] = $post['province'];
			$profile['city'] = $post['city'];
			$profile['district'] = $post['district'];
			$profile['address'] = $post['address'];
			$profile['weixin'] = $post['weixin'];
			$profile['qq'] = $post['qq'];
			$profile['member_num'] = $post['member_num'];
			$rese2 = $this->profile->data($profile)->add();
			if(!$rese2){
				$this->member->rollback();//事务有错回滚
				$data['status']  = 0;
			}
			//新契约品质系数表添加
			$new['m_number'] = $m_number;
			$rese3 = M('new_contract_coefficient')->data($new)->add();
			if(!$rese3){
				$this->member->rollback();//事务有错回滚
				$data['status']  = 0;
			}else{
				$this->member->commit();//提交事务成功
				$data['status']  = 1;
			}
			$this->ajaxReturn($data);
		}
	}
	/*
	*  功能：会员删除
	*  时间：017-05-10
	*  作者：lzt
	*/
	public function delete(){

		$where['m_number']= $_POST['m_number'];
		$data['status'] = '-1';
		$rese = $this->member->where($where)->data($data)->save();
		if($rese ){
			echo '1';
		}
	}
	
	/*
	 * 生成代码（会员与我的店铺代码为同一代码）
	 *
	 */
	public function setnum(){

		$data=rand_string($len = 4, $type = '1');
		$time = date('ymd', time());
		$num = 	$data.$time;
		$mation = $this->member->where('m_number = '.$num)->field('mid')->find();
		if($mation){
			$this->setnum();
		}else{
			return $num;
		}
	}
//	导出会员
	public function export(){
		header("Content-Typ:text/html;charset=utf-8"); 
        vendor('Excel.PHPExcel');
        vendor('Excel.PHPExcel.IOFactory');
    	$where = S('where');
    	$time = S('time');
		$mation = $this->member->alias('a')->where($where)
				->join('member_profile as b on a.m_number = b.m_number ','left')->join('new_contract_coefficient as c on a.m_number = c.m_number ','left')
				->select();
//  	p($mation);die;
		foreach($mation as $k=>$v){
			switch ($mation[$k]['member_level']) {
				case '0':
					$mation[$k]['member_level']='普通业务员';
					break;
				case '1':
					$mation[$k]['member_level']='资深业务员';
					break;
				case '2':
					$mation[$k]['member_level']='标准店店长';
					break;
				case '3':
					$mation[$k]['member_level']='旗舰店店长';
					break;
				case '4':
					$mation[$k]['member_level']='分公司';
					break;
				default:
					$mation[$k]['member_level']='总公司';
					break;
			};
			switch ($mation[$k]['check_status']){
				case '0':
					$mation[$k]['check_status']='审核中';
					break;
				case '1':
					$mation[$k]['check_status']='审核通过';
					break;
				case '-1':
					$mation[$k]['check_status']='未通过';
					break;
			};
			$mation[$k]['gender']=$mation[$k]['gender']==1 ?'男':'女';
			$mation[$k]['last_login_time']=date('Y-m-d H:i:s',$mation[$k]['last_login_time']);
			$mation[$k]['register_time']=date('Y-m-d H:i:s',$mation[$k]['register_time']);
		}
        $objPHPExcel = new \PHPExcel();
        $objPHPExcel->getActiveSheet()->setCellValue('A1', "业务员代码");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('B1', "我的店铺代码");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('C1', "所属标准店代码");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('D1', "所属旗舰店代码");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('E1', "所属分公司代码");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('F1', "手机号");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('G1', "邮箱");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('H1', "真实姓名");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('I1', "会员级别");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('J1', "会员积分");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('K1', "审核状态");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('L1', "最后登入时间");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('M1', "推荐人代码");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('N1', "注册时间");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('O1', "累计收入");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('P1', "可提现收入");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('Q1', "当月收入");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('R1', "性别");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('S1', "学历");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('T1', "身份证");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('U1', "银行卡卡号");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('V1', "银行卡开户行");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('W1', "资格证号");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('X1', "地址");//设置列的值
        $objPHPExcel->getActiveSheet()->setCellValue('Y1', "新契约品质系数");//设置列的值
        if($mation){
            $i=2;
            foreach ($mation as $key => $value) {
                $objPHPExcel->setActiveSheetIndex(0)
                    //Excel的第A列，uid是你查出数组的键值，下面以此类推
                    ->setCellValue('A'.$i, $value['m_number'])
                    ->setCellValue('B'.$i, $value['my_shop_number'])
                    ->setCellValue('C'.$i, $value['shop_number'])
                    ->setCellValue('D'.$i, $value['flagship_number'])
                    ->setCellValue('E'.$i, $value['branch_shop_number'])
                    ->setCellValue('F'.$i, $value['mobile'])
                    ->setCellValue('G'.$i, $value['email'])
                    ->setCellValue('H'.$i, $value['name'])
                    ->setCellValue('I'.$i, $value['member_level'])
                    ->setCellValue('J'.$i, $value['integral'])
                    ->setCellValue('K'.$i, $value['check_status'])
                    ->setCellValue('L'.$i, $value['last_login_time'])
                    ->setCellValue('M'.$i, $value['recommend_member_id'])
                    ->setCellValue('N'.$i, $value['register_time'])
                    ->setCellValue('O'.$i, $value['total_income'])
                    ->setCellValue('P'.$i, $value['cash_income'])
                    ->setCellValue('Q'.$i, $value['current_income'])
                    ->setCellValue('R'.$i, $value['gender'])
                    ->setCellValue('S'.$i, $value['education'])
                    ->setCellValue('T'.$i, $value['identity_card'])
                    ->setCellValue('U'.$i, $value['bank_card'])
                    ->setCellValue('V'.$i, $value['bank_name'])
                    ->setCellValue('W'.$i, $value['member_num']) 
                    ->setCellValue('X'.$i, $value['address'])
                    ->setCellValue('Y'.$i, $value['new_cont_cone']);
                $i++;
            }
        }

        $objPHPExcel->getActiveSheet(0)->setTitle('会员报表');
        // $objPHPExcel->setActiveSheetIndex(0);
        header('Content-Type:application/vnd.ms-excel');
        header("Content-Disposition:attachment;filename=".$time."业务员报表.xls");
        header('Cache-Control: max-age=0');
        $objWriter = \PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel5');

        $objWriter->save('php://output');
        //清空缓存
        S('condition',null);
        S('time',null);	
	}
	
}
?>