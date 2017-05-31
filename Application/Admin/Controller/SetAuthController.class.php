<?php
namespace Admin\Controller;
use Common\Controller\AdminbaseController;
class SetAuthController extends AdminbaseController
{
	/**功能：
	  时间：2017-5-27
	  作者：zth
	*/
	public function role(){
		$data = M('manager_auth_role')->alias('a')
									  ->join('LEFT JOIN manager_auth_access b on b.role_id=a.id')
									  ->order('id desc')->select();
		foreach($data as $k=>$v){
			$where['id'] = array('in',$v['node_id']);
			$data[$k]['auth'] = M('manager_auth_node')->field('name')->where($where)->select();
		}
		$this->assign('datas',$data);
		$this->display();
	}
	public function rolesave(){
	
		if(IS_POST){
     		$data = I('post.');
     		if($data['name'] && $data['codes'] && $data['roledetail']){
     			$data['right'] = implode(',',$data['codes']);
     			//对角色表开启事物插入节点表中
     			$roleTrans = M('manager_auth_role');
     			//是修改角色进行操作
	     		if(!empty($data['role_id'])){
	     			if(M('manager_auth_role')->where(array('name'=>$data['name']))->count()>0){
	     				$arrAuth = array(
	     					'name'    =>$data['name'],
	     					'remark'   =>$data['roledetail'],
	     					'create_time'=>time()
	     				);
	     				//开启事物
	     				$roleTrans->startTrans();
	     				//修改角色
		     			$ret = $roleTrans->where(array('id'=>$data['role_id']))->save($arrAuth);
		     			if($ret){
							$access = array(
			     					'node_id'   =>$data['right'],
			     				);
							if(M('manager_auth_access')->where(array('role_id'=>$data['role_id']))->save($access)){
								$roleTrans->commit();
								exit(json_encode(array('code'=>1000,'msg'=>'修改成功！')));
							}else{
								$roleTrans->rollback();
			     				exit(json_encode(array('code'=>999,'msg'=>'修改失败')));
							}
							
		     			}else{
		     				$roleTrans->rollback();
		     				exit(json_encode(array('code'=>999,'msg'=>'修改失败！请重新修改')));
		     			}
	     			}else{
	     				exit(json_encode(array('code'=>999,'msg'=>'参数错误，请检查')));
	     			}
	     			
	     		}else{
	     			//是添加角色
	     			if(M('manager_auth_role')->where(array('name'=>$data['name']))->count()>0){
	     				exit(json_encode(array('code'=>999,'msg'=>'该角色名称已添加，请检查')));
	     			}
	     			$arrAuth = array(
	     					'name'    =>$data['name'],
	     					'remark'   =>$data['roledetail'],
	     					'create_time'=>time()
	     				);
	     			$roleTrans->startTrans();
	     			$retsid = $roleTrans->add($arrAuth);
	     			if($retsid){
	     				$access = array(
	     					'role_id'    =>$retsid,
	     					'node_id'   =>$data['right'],
	     				);
	     				if(M('manager_auth_access')->add($access)){
	     					$roleTrans->commit();
	     					exit(json_encode(array('code'=>1000,'msg'=>'添加成功')));
	     				}else{
	     					$roleTrans->rollback();
	     					exit(json_encode(array('code'=>999,'msg'=>'添加角色失败')));
	     				}
	     			}else{
	     				$roleTrans->rollback();
	     				exit(json_encode(array('code'=>999,'msg'=>'添加失败')));
	     			}
	     		}
	     		exit(json_encode(array('code'=>1000,'msg'=>'操作成功')));
	     		
	     	}else{
	     		exit(json_encode(array('code'=>999,'msg'=>'参数错误')));
	     	}
     }
	}
	//添加角色
	public function roleadd()
	{
		$role_id = I('get.role_id');
    	$tree = $detail = array();
    	if($role_id){
    		$detail = M('manager_auth_role')->alias('a')
    				->join('LEFT JOIN manager_auth_access b on b.role_id=a.id')
					->where("id=$role_id")->find();
    		$detail['act_list'] = explode(',', $detail['node_id']);

    		$this->assign('detail',$detail);
    	}
		$right = M('manager_auth_node')->order('id')->select();
		$arrlist = array();
		foreach ($right as $val){
			if(!empty($detail)){
				if(in_array($val['id'], $detail['act_list'])){$val['enable']=1;}else{$val['enable']=0;}
			}
			$modules[$val['group']][] = $val;
			$arrlist[$val['pid']][] = $val;
		}
		// dump($modules);
		// dump($arrlist);
		//权限组
		// $group = array('system'=>'系统设置','content'=>'内容管理','goods'=>'商品中心','member'=>'会员中心',
  //    			'order'=>'订单中心'
  //    	);
		$group = getAllMenu();
     	
		// print('<pre>');
		// print_r($modules);die;
		$this->assign('group',$group);
		$this->assign('arrlist',$arrlist);
		$this->assign('modules',$modules);
    	$this->display();
	}
	public function roledel()
	{
		$where['id'] = I('post.role_id');
		if($where['id']){
			$roleTrce = M('manager_auth_role');
			$roleTrce->startTrans();
			$result = $roleTrce->where($where)->delete();
			if($result){
				if(M('manager_auth_access')->where(array('role_id'=>$where['id']))->delete()){
						$roleTrce->commit();
						exit(json_encode(array('code'=>1000,'msg'=>'删除成功')));
					}else{
						$roleTrce->rollback();
	     				exit(json_encode(array('code'=>999,'msg'=>'删除失败!')));
					}
			}else{
				$roleTrce->rollback();
				exit(json_encode(array('code'=>999,'msg'=>'删除失败')));
			}
         }else{
         	exit(json_encode(array('code'=>999,'msg'=>'参数错误')));
         }
	}
	/**

	权限管理
	时间：2017-5-26
	  作者：zth


	*/
	public function permission()
	{
		$data = M('manager_auth_node')->select();
		$group = getAllMenu();
		$this->assign('datainfo',$data);
		$this->assign('group',$group);
		$this->display();
	}

	public function permissiondel()
	{
		$id = I('post.a_id');
		if(is_array($id)){
			$id = implode(',',$id);
		}
		
		if($id){
			$result = M('manager_auth_node')->where("id in ($id)")->delete();
			if($result){
				exit(json_encode(array('code'=>1000,'msg'=>'删除成功')));
			}else{
				exit(json_encode(array('code'=>999,'msg'=>'删除失败')));
			}
         }else{
         	exit(json_encode(array('code'=>999,'msg'=>'参数错误')));
         }
	}
	/**
	添加权限

	*/
	public function permissionadd()
	{
		if(IS_POST){
     		$data = I('post.');
     		if($data['name'] && $data['auth_group'] && $data['auth_code']){
     			$data['right'] = implode(',',$data['auth_code']);

	     		if(!empty($data['a_id'])){
	     			$arrAuth = array(
	     					'name'    =>$data['name'],
	     					'authcode'=>$data['right'],
	     					'group'   =>$data['auth_group'],
	     					'pid'   =>$data['auth_pid'],
	     					'create_time'=>time()
	     				);
	     			$ret = M('manager_auth_node')->where(array('id'=>$data['a_id']))->save($arrAuth);
	     			if($ret){
						exit(json_encode(array('code'=>1000,'msg'=>'操作成功！')));
	     			}else{
	     				exit(json_encode(array('code'=>999,'msg'=>'修改失败！请重新修改')));
	     			}
	     		}else{
	     			if(M('manager_auth_node')->where(array('name'=>$data['name']))->count()>0){
	     				exit(json_encode(array('code'=>999,'msg'=>'该权限名称已添加，请检查')));
	     			}
	     			unset($data['a_id']);
	     			$arrAuth = array(
	     					'name'    =>$data['name'],
	     					'authcode'=>$data['right'],
	     					'group'   =>$data['auth_group'],
	     					'pid'   =>$data['auth_pid'],
	     					'create_time'=>time()
	     				);
	     			M('manager_auth_node')->add($arrAuth);
	     		}
	     		exit(json_encode(array('code'=>1000,'msg'=>'操作成功')));
	     		
	     	}else{
	     		exit(json_encode(array('code'=>999,'msg'=>'参数错误')));
	     	}
     }
     	$id = I('get.a_id');
     	if($id){
     		$info = M('manager_auth_node')->where(array('id'=>$id))->find();
     		$info['right'] = explode(',', $info['authcode']);
     		$this->assign('info',$info);
     	}
     	$group = getAllMenu();
     	 // print("<pre>");
       //  print_r($group);
       //  print("<pre>");die;
     	$planPath = APP_PATH.'Admin/Controller';
     	$planList = array();
     	$dirRes   = opendir($planPath);
     	while($dir = readdir($dirRes))
     	{
     		if(!in_array($dir,array('.','..','.git')))
     		{
     			$planList[] = basename($dir,'.class.php');
     		}
     	}
     	// print('<pre>');
     	// print_r($planList);die;
     	$this->assign('planList',$planList);
     	$this->assign('group',$group);
     	$this->display();
	}

	//ajax获取控制器方法
	 function ajax_get_action()
     {
     	$control = I('controller');
     	$advContrl = get_class_methods("Admin\\Controller\\".$control);
     	$baseContrl = get_class_methods('Common\Controller\AdminbaseController');
     	// print('<pre>');
     	// print_r($advContrl);
     
     	$diffArray  = array_diff($advContrl,$baseContrl);
     
     	$html = '';
     	foreach ($diffArray as $val){
     		$html .= "<option value='".$val."'>".$val."</option>";
     	}
     	exit($html);
     }
     	//ajax获取控制器方法
	 function ajax_group_action()
     {
     	$group = I('controller');
		$diffArray = M('manager_auth_node')->field('id,name')->where(array('group'=>$group))->select();     
		dump($diffArray);
     	$html = '';
     	foreach ($diffArray as $val){
     		$html .= "<option value='".$val['id']."'>".$val['name']."</option>";
     	}
     	exit($html);
     }
	/**
	管理员列表
		2017-5-27
	*/
    public function adminlist()
	{
		$where['a.status'] = array('neq',-1);
		$datas = M('manager')->alias('a')->field('a.*,r.name')->where($where)
							 ->join('LEFT JOIN manager_auth_role r on r.id=a.role_id')
							 ->order('id')->select();
		$this->assign('datas',$datas);
		$this->display();
	}
	//添加管理员
	public function adminadd()
	{
		//角色数据
		$id = I('get.admin_id');
		if($id){
			$ret = M('manager')->where(array('id'=>$id))->find();
			$this->assign('info',$ret);
		}
		$role = M('manager_auth_role')->alias('a')
									  ->order('id')->select();
		$this->assign('roledatas',$role);
		$this->display();
	}
	//处理添加管理员
	public function adminsave()
	{
		if(IS_POST){
			//判断是添加和修改
			$datas = I('post.');
			$model = M('manager');
			if($datas['admin_id']){
				//修改管理员
				$res = $model->where(array('manager_number'=>$datas['manager_number'],'username'=>$datas['username']))->find();
				if(!$res){exit(json_encode(array('code'=>999,'msg'=>'该管理员不存在')));}
				$arr = array(
					'manager_number'=>$datas['manager_number'],
					'username'=>$datas['username'],
					'password'=>$datas['password'],
					'real_name'=>$datas['real_name'],
					'gender'=>$datas['gender'],
					'age'=>$datas['age'],
					'email'=>$datas['email'],
					'mobile'=>$datas['mobile'],
					'telphone'=>$datas['telphone'],
					'status'=>$datas['status'],
					'organization_id'=>$datas['organization_id'],
					'role_id'=>$datas['role_id'],
					'address'=>$datas['address'],
					'weixin'=>$datas['weixin'],
					'qq'=>$datas['qq'],
					);
				$result = $model->where(array('id'=>$datas['admin_id'],'username'=>$datas['username'],'password'=>$datas['password']))->find();
				if(!$result){
					$arr['password'] = md5($datas['password']);
				}
				$ret = $model->where(array('id'=>$datas['admin_id']))->save($arr);
				// echo $model->getLastSql();
				if($ret){
					exit(json_encode(array('code'=>1000,'msg'=>'修改成功')));
				}else{
					exit(json_encode(array('code'=>999,'msg'=>'修改失败')));
				}
			}else{
				//添加管理员
				$res = $model->where(array('manager_number'=>$datas['manager_number'],'username'=>$datas['username']))->find();
				if($res){exit(json_encode(array('code'=>999,'msg'=>'该管理员已经存在')));}
				$arr = array(
					'manager_number'=>$datas['manager_number'],
					'username'=>$datas['username'],
					'password'=>md5($datas['password']),
					'real_name'=>$datas['real_name'],
					'gender'=>$datas['gender'],
					'age'=>$datas['age'],
					'email'=>$datas['email'],
					'mobile'=>$datas['mobile'],
					'telphone'=>$datas['telphone'],
					'status'=>$datas['status'],
					'organization_id'=>$datas['organization_id'],
					'role_id'=>$datas['role_id'],
					'address'=>$datas['address'],
					'weixin'=>$datas['weixin'],
					'qq'=>$datas['qq'],
					'create_time'=>time()
					);
				$ret = $model->add($arr);
				// echo $model->getLastSql();die;
				if($ret){
					exit(json_encode(array('code'=>1000,'msg'=>'添加成功')));
				}else{
					exit(json_encode(array('code'=>999,'msg'=>'添加失败')));
				}

			}
		}else{
			exit(json_encode(array('code'=>999,'msg'=>'非法请求')));
		}
	}
	//删除admin修改状态
	public function admindel()
	{
		if(IS_POST){
			$id = I('post.m_id');
			if($id){
				$model = M('manager');
				$res = $model->where(array('id'=>$id))->find();
				if($res){
					$result = $model->where(array('id'=>$id))->save(array('status'=>-1));
					if($result){
						exit(json_encode(array('code'=>1000,'msg'=>'删除成功')));
					}else{
						exit(json_encode(array('code'=>999,'msg'=>'删除失败')));
					}
				}else{
					exit(json_encode(array('code'=>999,'msg'=>'参数错误')));
				}
			}else{
				exit(json_encode(array('code'=>999,'msg'=>'参数为空')));
			}
		}else{
			exit(json_encode(array('code'=>999,'msg'=>'非法请求')));
		}
	}


}