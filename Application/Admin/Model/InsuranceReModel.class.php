<?php
namespace Admin\Model;
use Think\Model;
class InsuranceReModel extends Model{

	//标题自动验证
	/*protected $_validate=array(

			array('full_name','require','请输入供应商名称'),
			array('province',        0,             '选择供应商地址省份',1,'notequal'),
			array('city',       	 0,             '选择供应商地址市区',1,'notequal'),
			array('town',        	 0,             '选择供应商地址区县',1,'notequal'),
			array('website_url',     'require',     '请输入公司网址'),
			array('website_url', 	'url',          '请填写正确的公司网址'),
			array('contacts',       'require',      '请填写联系人'),
			array('telphone','/^1[3|4|5|8][0-9]\d{4,8}$/','联系人手机号码错误！','0','regex',1),
			array('legal_person','require','法人不能为空'),
			array('legal_telphone','require','法人电话不能为空'),
			array('legal_telphone','/^1[3|4|5|8][0-9]\d{4,8}$/','法人手机号码错误！','0','regex',1),
			array('bank_register_name','require','开户行不能为空'),
			array('bank_card','require','银行卡号不能为空！'),
			array('bank_card','number','银行卡号只能为数字'),
			array('bank_card','0,25','银行卡号长度不符！',3,'length'),
			array('bank_name','require','开户人不能为空'),
			
	);*/

	//自动完成，在create时自动执行
	//array('填充字段','填充内容','填充条件','附加规则');
	//填充字段
	protected $_auto=array(
			array('entry_date','time',1,'function'),
			array('insured_date','getDate',1,'callback'),
			array('insured_date_star','getDate',1,'callback'),
			array('hesitation_end_date','getDate',1,'callback'),
			array('hesitation_end_date','getDate',1,'callback'),
			array('return_date','getDate',1,'callback'),
			array('return_visit_date','getDate',1,'callback'),
			array('customer_sign','getDate',1,'callback'),
			array('hesitate_date','getDate',1,'callback'),
			array('surrender_date','getDate',1,'callback'),
			array('pay_date','getDate',1,'callback'),
	);
	public function getDate(){
		$data=strtotime(I('post.pay_date'));
		
		return $data;
	}
}

?>