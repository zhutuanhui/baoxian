<?php
/**
 * 后考核设置.
 * User: zth
 * Date: 2017-5-18
 * Time: 14:00
 */
namespace Admin\Controller;
use Common\Controller\AdminbaseController;
class SystemcheckController extends AdminbaseController{
    //团队业绩查询添加到排名表
    public function index(){
        $model = M('shop_assess_standard');
        $datas = $model->select();
        // print('<pre>');
//         p($datas);
        $this->assign('datas',$datas);
        $this->display();
    }
    /**
     * 添加考核设置
     * @param   2017-5-19
     * @return  
     * */
    public function checkadd(){
        if(I('get.id')){
            $model = M('shop_assess_standard');
            $datas = $model->select();
        }
        $this->display();
    }
      /**
     * 处理添加考核设置
     * @param   2017-5-19
     * @return  
     * */
    public function doadd(){
          if(IS_AJAX){
            $model = M('shop_assess_standard');
            $param = array_filter(I('post.'));
            $rets = $model->add($param);
            if($rets){
                exit(json_encode(array('code'=>1000,'msg'=>'成功')));
            }else{
                exit(json_encode(array('code'=>999,'msg'=>'失败')));
            }
        }else{
            exit(json_encode(array('code'=>999,'msg'=>'非法请求')));
        }
    }
    /*
     *
     * 二维数组排序并追加排名
     * @param   $arr  二维数组
     * @param   $pay   业绩字段名
     * @param   $ranking 排序后添加的排名字段名
     * @return  排序并追加排名后的二维数组
     * */
    public function arrSort($arr,$pay='pay',$ranking){
        $addinfo = array();
        foreach($arr as $v){
            $addinfo[] = $v[$pay];            //旗舰店本月业绩；
        }
        array_multisort($addinfo,SORT_DESC,$arr);//数组排序
        //将排名追加到数组中
        foreach($arr as $key=>$val){
            $arr[$key][$ranking] = $key+1;
        }
        return $arr;
    }
//  删除考核
    public function del(){
    	$id=I('post.id');
    	if($id){
    	$model = M('shop_assess_standard');
    	$result=$model->delete($id);
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
//  编辑
	public function edit(){
		$id=I('get.id');
		if($id){
			$result = M('shop_assess_standard')->where('id='.$id)->find();
		}
		if(IS_AJAX){
			$data=array_filter(I('post.'));
			$result = M('shop_assess_standard')->save($data);
			if($result){
				exit(json_encode(array('code'=>1000,'msg'=>'编辑成功')));
			}else{
				exit(json_encode(array('code'=>999,'msg'=>'编辑失败')));
			}
		}
		$this->assign('id',$id);
		$this->assign('result',$result);
		$this->display();
	}
   
}