<?php
namespace Admin\Controller;
use Think\Controller;
/**
 * @description 后台登录控制器
 * @author [wangzhiqiang] <[<iyting@foxmail.com>]>
 */
class LoginController extends Controller
{
    /**
     * 登录页面
     * @return [type] [description]
     */
    public function index()
    {

       $this->display('login');

    }
    //验证码
    public function verify(){
        $Verify = new \Think\Verify();

        $Verify->codeSet = '0123456789';
        $Verify->fontSize = 15;
        $Verify->length = 4;
        $Verify->useNoise= false;// 关闭验证码杂点
        $Verify->useCurve=false;//关闭混淆曲线
        $Verify->entry();
    }
    /**
     * @desciption 登录验证
     * @author [wangzhiqiang] <[<iyting@foxmail>]>
     * @return [type] [description]
     */
    //登陆验证
    public function login(){
        if(IS_AJAX) {
            $username = I('post.username','','addslashes');
            $password = I('password','','md5');
            $code     = I('myverify','','strtolower');
             //验证验证码是否正确
            if(!($this->check_verify($code))){

                    $data['info'] = '验证码错误';
                    $data['type'] = 'code';


                    echo json_encode(['data'=>$data,'code'=>0,'message'=>'请求成功']);

            } else {    //验证码成功

                if ($username && $password) {

                    $result = M('manager')
                                ->where("username = '%s' and password= '%s'",array($username,$password))
                                ->find();

                    if (!$result) {
                        $data['info'] = '账户或密码错误';
                        $data['type'] = 'userinfo';
                        echo json_encode(['data'=>$data,'code'=>0,'message'=>'请求成功']);

                    } elseif($result['status'] !=1) {
                        $data['info'] = '账号被禁用，请联系超级管理员';
                        $data['type'] = 'error';
                        echo json_encode(['data'=>$data,'code'=>0,'message'=>'请求成功']);
                    } else {
                        //更新登陆信息
                        $data =array(
                            'id' => $result['id'],
                            'last_login_time' => time(),
                        );
                         //如果数据更新成功  跳转到后台主页
                        if(M('manager')->save($data)){
                            //获取用户权限列表
                            $acl_info = M('manager_auth_access')->where(array('role_id'=>$result['role_id']))->find();
                            session('act_list',$acl_info['node_id']);
                            session('adminId',$result['id']);
                            session('username',$result['username']);
//                          如果是分公司把分公司机构代码写入session
							session('organization_id',$result['organization_id']);	
                            $data['info'] = '操作成功，3秒后跳到后台管理系统';
                            $data['type'] = 'success';

                            echo json_encode(['data'=>$data,'code'=>1,'message'=>'请求成功']);

                        } else {
                            $data['info'] = '登录错误，请重新操作。';
                            $data['type'] = 'login_error';
                            echo json_encode(['data'=>$data,'code'=>0,'message'=>'请求成功']);
                        }
                    }

                } else {
                    echo 404;
                }

            }
        } else {
            //非法请求
            echo '222';exit;
        }



    }
    /**
     * @description 登出
     * @author  wangzhiqiang  iyting@foxmail.com
     * @return [type] [description]
     */
    public function logout(){

        session('adminId',null);
        session('username',null);
        redirect(U('Login/index'));
    }
     protected function check_verify($code){
        $verify = new \Think\Verify();
        return $verify->check($code);
    }


}
