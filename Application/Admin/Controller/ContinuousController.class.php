<?php
namespace Admin\Controller;
use Common\Controller\AdminbaseController;
class	ContinuousController extends AdminbaseController {
	public function index() {
		$result = M('coefficient_continuous') -> select();
		if (IS_AJAX) {
			$post = I('post.');
			//			重组数组
			foreach ($post['mincontinues'] as $k => $v) {
				$data[$k]['id'] = $post['id'][$k];
				$data[$k]['mincontinues'] = $post['mincontinues'][$k];
				$data[$k]['maxcontinues'] = $post['maxcontinues'][$k];
				$data[$k]['coefficient'] = $post['coefficient'][$k];
			}
			//			循环添加到首期手续费业推奖金表
			foreach ($data as $k => $v) {
				if ($data[$k]['id']) {
					$add = 'save';
				} else {
					$add = 'add';
				}
				$result = M('coefficient_continuous') -> $add($data[$k]);
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
		$this -> assign('result', $result);
		$this -> display();
	}

	//	删除品质系数
	public function del() {
		$id = I('post.id');
		if ($id) {
			$m = M('coefficient_continuous');
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