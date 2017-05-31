<?php
namespace Admin\Controller;
use Common\Controller\AdminbaseController;
class PublicController extends AdminbaseController
{
	public function __construct() {
		parent::__construct();

	}
    /*
     * 地址联动
     *
     */
    public function addajax() {
        $pid=I('post.pid');                   //上级id
        $string=I('post.string');
        $data=GetCity($pid);
        $str='';
        if($data){
            $str='<option value="a">请选择'.$string.'</option>';
            foreach ($data as $k => $v) {
                $str=$str.'<option value="'.$v["id"].'">'.$v["name"].'</option>';
            }
            echo $str;
        }
    }
	
}
?>