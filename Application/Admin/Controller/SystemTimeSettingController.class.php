<?php
/**
 * Created by PhpStorm.
 * User: 小白
 * Date: 2017/5/24
 * Time: 10:55
 */
namespace Admin\Controller;
use Common\Controller\AdminbaseController;
class SystemTimeSettingController extends AdminbaseController{
    /*
     * 系统时间设置列表
     * */
    public function index(){
        $system = array('number'=>C('NUMBER'));
        $this->system=$system['number'];
        $this->display();
    }
    /*修改*/
    public function sitemessage(){
        if($_POST){
            $path = 'Application/Common/Conf/timesetting.php';
            $a= $this->set_config($path,$_POST['key']);
          if($a){
              $data['status']  = 1;
              $this->ajaxReturn($data);
              exit;
          }else{
              $data['status']  = 2;
              $this->ajaxReturn($data);
              exit;
          }
        }
    }
    /*设置配置*/
    private function set_config($file,$key,$value=false){
        $string = file_get_contents($file);
        if(!$string){
            $data['status']  = 3;
            $this->ajaxReturn($data);
            exit;
        }
        //判断是否为数组
        if(is_array($key)){
            foreach($key as $k=>$v){
                //遍历循环把键名与键值分别传输给replace_config方法
                $string = $this->replace_config($k,$v,$string);
            }

        }else{
            $string = $this->replace_config($key,$value,$string);
        }
        $list=file_put_contents($file,$string);
        if($list) {
            return true;
        } else  {
            $data['status']  = 4;
            $this->ajaxReturn($data);
            exit;
        }
    }
    /*正则判断，更换配置*/
    private function replace_config($key,$value,$string){
        //获取数据键名
        $preg = "/(['\"]\s*".$key."\s*['\"]\s*=\>\s*').*(\s*'\s*[,\)])/";
        //判断是否有匹配
        if(preg_match($preg,$string)){
            //正则替换
            $str =  preg_replace($preg,"\${1}$value\${2}",$string);
        }else{
            $preg = "/\s*\);/";
            $str = preg_replace($preg,"\r\n\t\t'$key'\t\t=>\t'$value',\${0}",$string);
        }
        return $str;
    }
}