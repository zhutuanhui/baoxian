<?php
namespace Admin\Controller;
use Common\Controller\AdminbaseController;
class AgreementController extends AdminbaseController {
	//	协议录入
	public function index() {
		if (IS_POST) {
			$post = I('post.');
			if ($post['full_name']) {
				$where['full_name'] = array('like', '%' . $post['full_name'] . '%');
			}
			if ($post['contract_name']) {
				$where[]['contract_name'] = array('like', '%' . $post['contract_name'] . '%');
			}
		}
		$option = M('supplier') -> field('sup_id,full_name,contract_name,contract_type') -> where($where) -> select();
		$result = M('supplier') -> field('sup_id,full_name,contract_name,contract_type') -> select();
		$results = $option ? $option : $result;
		$this -> assign('result', $results);
		$this -> display();
	}	
	//	添加到首期手续费业推奖金表
	public function insurance() {
		$id = I('get.id');
		if (IS_AJAX) {
			$post = I('post.');
			//			重组数组
			foreach ($post['minimum_standard_permium'] as $k => $v){
				$data[$k]['id'] = $post['id'][$k];
				$data[$k]['provider_id'] = $post['provider_id'];
				$data[$k]['minimum_standard_permium'] = $post['minimum_standard_permium'][$k];
				$data[$k]['maximum_standard_premium'] = $post['maximum_standard_premium'][$k];
				$data[$k]['bonus_ratio'] = $post['bonus_ratio'][$k];
			}
			//			循环添加到首期手续费业推奖金表
			foreach ($data as $k => $v) {
				if ($data[$k]['id']) {
					$add = 'save';
				} else {
					$add = 'add';
				}
				$result = M('settlement_initial_fee_industry_bonus_proportion') -> $add($data[$k]);
			}
			if ($result) {
				$data['status'] = 1;
				$this -> ajaxReturn($data);
				exit ;
			} else {
				$data['status'] = 0;
				$this -> ajaxReturn($data);
				exit ;
			}
		}
		if ($id) {
			//			查出所有该供应商首期手续费业推奖金数据
			$result = M('settlement_initial_fee_industry_bonus_proportion') -> where('provider_id=' . $id) -> select();
			$this -> assign('result', $result);
		}

		$this -> assign('id', $id);
		$this -> display();
	}

	//	删除首期寿险业推奖金比例
	public function delins() {
		$id = I('post.id');
		if ($id) {

			$m = M('settlement_initial_fee_industry_bonus_proportion');

			$result = $m -> where('id=' . $id) -> delete();
			if ($result) {

				echo json_encode(1);
			} else {
				echo json_encode(0);
			}
		} else {
			echo json_encode(1);
		}
	}

	//	添加到首期手续费业推奖金表
	public function noinsurance() {
		$id = I('get.id');
		if (IS_AJAX) {
			$post = I('post.');

			//			重组数组
			foreach ($post['min_scale_premium'] as $k => $v) {
				$data[$k]['id'] = $post['id'][$k];
				$data[$k]['provider_id'] = $post['provider_id'];
				$data[$k]['min_scale_premium'] = $post['min_scale_premium'][$k];
				$data[$k]['max_scale_premium'] = $post['max_scale_premium'][$k];
				$data[$k]['non_life_insurance_premium'] = $post['non_life_insurance_premium'][$k];
			}
			//			循环添加到首期手续费业推奖金表
			foreach ($data as $k => $v) {
				if ($data[$k]['id']) {
					$add = 'save';
				} else {
					$add = 'add';
				}
				$result = M('settlement_non_life_insurance_premium') -> $add($data[$k]);
			}
			if ($result) {
				$data['status'] = 1;
				$this -> ajaxReturn($data);
				exit ;
			} else {
				$data['status'] = 0;
				$this -> ajaxReturn($data);
				exit ;
			}
		}
		if ($id) {
			//			查出所有该供应商非寿险业推奖金数据
			$result = M('settlement_non_life_insurance_premium') -> where('provider_id=' . $id) -> select();
			$this -> assign('result', $result);
		}

		$this -> assign('id', $id);
		$this -> display();
	}

	//	删除非寿险业推奖金比例
	public function nodelins() {
		$id = I('post.id');
		if ($id) {
			$m = M('settlement_non_life_insurance_premium');

			$result = $m -> where('id=' . $id) -> delete();
			if ($result) {

				echo json_encode(1);
			} else {
				echo json_encode(0);
			}
		} else {
			echo json_encode(1);
		}
	}

}
?>