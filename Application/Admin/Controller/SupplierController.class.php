<?php
namespace Admin\Controller;
use Common\Controller\AdminbaseController;
use Common\Controller\UploadImgController;
class SupplierController extends AdminbaseController
{
//	供应商主页
	public function index(){
		$m=M('Supplier');
		$result=$m->select();
		foreach($result as $k=>$v){
			$province=$m->join('district ON supplier.province = district.id')->field('name')->select();
			
			$result[$k]['province']=$province[$k]['name'];
			$city=$m->join('district ON supplier.city = district.id')->field('name')->select();
			$result[$k]['city']=$city[$k]['name'];
			$town=$m->join('district ON supplier.town = district.id')->field('name')->select();
			$result[$k]['town']=$town[$k]['name'];
			$result[$k]['imglist']=__ROOT__.$result[$k]['imglist'];
		}

		$this->assign('supp',$result);
		$this->display();
	}


//	供应商添加
	public function product(){
	if(IS_AJAX){
//		p($_POST);die;
		$m=D('Supplier');
		if (!$m->create()){
     // 如果创建失败 表示验证没有通过 输出错误提示信息
     exit($m->getError());
	}else{
	     // 验证通过 可以进行其他数据操作
	   
	     $result = $m->add();
 		if($result){
                $data['status']  = 1;
                $this->ajaxReturn($data);
                exit;
            }else{
                $data['status']  = 0;
                $this->ajaxReturn($data);
                exit;
            }
	}

	}
//	地址三级联动
	$result=district($level='1',$pid='0');
    $this->assign('province',$result); 	
    $this->display();
 
	}
//	图片上传
	public function upload(){
		$savePath='Supplier'; //定义图片上传路径
		$upload_obj = new UploadImgController;
		$upload_obj->upload($savePath);
	}

//	地址三级联动返回json数据
	public function product2(){
	$pid=$_REQUEST['pid'];	
	$level=$_REQUEST['type'];
	$result=district($level,$pid);
	echo json_encode($result);
 
}
//删除指定数据
	public function del(){
		$id=I('post.id');
		$m=M('Supplier');
		$ms=M('product')->where('supplier_id='.$id)->getField('id',true);
		if($ms){
			
			echo json_encode(2);
		}else{
			
			$result=$m->delete($id);
			if($result){
				echo json_encode(1);
			}else{
				echo json_encode(0);
			}
		}
	}
//	编辑供应商
	public function edit(){
		$id=I('get.id');
		if($id){
			$m=M('Supplier');
			$result=$m->where('sup_id='.$id)->find();
			
			$result['provinces']=M('district')->where('id='.$result['province'])->getField('name');
			$result['citys']=M('district')->where('id='.$result['city'])->getField('name');
			$result['towns']=M('district')->where('id='.$result['town'])->getField('name');
			$result['imglist']=__ROOT__.$result['imglist'];
			$this->assign('id',$id);	
			$this->assign('supp',$result);
		}
//	如果是post提交修改修改结果
	if(IS_AJAX){
		
		$m=D('Supplier');
		if (!$m->create()){
     // 如果创建失败 表示验证没有通过 输出错误提示信息
     exit($m->getError());
	}else{
	     // 验证通过 可以进行其他数据操作
	   
	     $result = $m->save();
	  
	     	if($result){
                $data['status']  = 1;
                $this->ajaxReturn($data);
                exit;
            }else{
                $data['status']  = 0;
                $this->ajaxReturn($data);
                exit;
            }
	     	
		}
	}
	//	地址三级联动
	$result=district($level='1',$pid='0');
    $this->assign('province',$result); 	
	$this->display();
	}
}
?>