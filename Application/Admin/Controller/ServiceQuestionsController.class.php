<?php
/**
 * Created by PhpStorm.
 * User: 赵浙豫
 * Date: 2017/5/11
 * Time: 15:53
 */
namespace Admin\Controller;
//use Think\Controller;
use Common\Controller\AdminbaseController;
class ServiceQuestionsController extends AdminbaseController{
    /*
     * 题库设置列表
     * */
    public function index(){
        $test_cont=D('test_cont');
        $parameter=$test_cont->index();
        $this->list=$parameter;
        $this->count=count($parameter);
        $this->display();
    }
    /*
     * 添加题库
     * $param   题库表数据
     * $test_cont_add   添加题库
     * $param1  答案表数据
     * */
    public function questionsAdd(){
        $test_cont=D('test_cont');
        $test_answer=D('test_answer');
        if(IS_AJAX){
            $param = array(
                'state'         =>  I('state'),
                'qustion_title'=>I('qustion_title'),
                'create_time'=>time()
            );
            //事物处理
            $test_cont->startTrans();
            $test_cont_add=$test_cont->add($param);
            $param1 = array(
                'test_id'       =>  $test_cont_add,
                'answer_name'   =>  I('answer_name'),
                'state'         =>  array('A', 'B', 'C', 'D',),
                'create_time'   =>  time()
            );
            if($test_cont_add){
                //循环添加答案内容
                foreach($param1['answer_name'] as $k=>$v){
                    $arr = array(
                        'test_id'       =>  $test_cont_add,
                        'answer_name'   =>  $v,
                        'state'         =>  $param1['state'][$k],
                        'create_time'   =>  time()
                    );
                    $test_answer_add=$test_answer->add($arr);
                }
                if($test_answer_add){
                    $test_cont->commit();
                    $data['status']  = 1;
                    $this->ajaxReturn($data);
                    exit;
                }else{
                    $test_cont->rollback();
                    $data['status']  = 0;
                    $this->ajaxReturn($data);
                    exit;
                }
            }else{
                $test_cont->rollback();
                $data['status']  = 0;
                $this->ajaxReturn($data);
                exit;
            }
        }
        $this->display();
    }
    /*
     * 编辑题库
     * */
    public function questionsEdit(){
        $test_cont=D('test_cont');
        $test_answer=D('test_answer');
        $id=I('id');
        if(IS_AJAX){
            $param = array(
                'qustion_title' =>  I('qustion_title') ,
                'state'         =>  I('state'),
            );
            //事物处理
            $test_cont->startTrans();
            $test_cont->where('id='.$id)->save($param);
            $param1 = array(
                'test_answer_id'=>  I('test_answer_id'),
                'answer_name'   =>  I('answer_name'),
                'state'         =>  array('A', 'B', 'C', 'D',),
            );
            //循环添加答案内容
            foreach($param1['answer_name'] as $k=>$v){
                $arr = array(
                    'answer_name'   =>  $v,
                    'state'         =>  $param1['state'][$k],
                );
                $test_answer_save=$test_answer->where('id='.$param1['test_answer_id'][$k])->save($arr);
            }
            if($test_answer_save!==false){
                $test_cont->commit();
                $data['status']  = 1;
                $this->ajaxReturn($data);
                exit;
            }else{
                $test_cont->rollback();
                $data['status']  = 0;
                $this->ajaxReturn($data);
                exit;
            }

        }
        $parameter=$test_cont->questionsEdit($id);
        $this->list=$parameter;
        $this->id=$id;
        $this->test_answer=$parameter['test_answer'];
        $this->display();
    }
    /*
     * 删除题库
     * */
    public function questions_del(){
        $test_cont=D('test_cont');
        $test_answer=D('test_answer');
        $id=I('id');
        //开启事物处理
        $test_cont->startTrans();
        $parameter=$test_cont->where(array('id'=>$id))->delete();
        if($parameter){
            $test_answer_delete=$test_answer->where(array('test_id'=>$id))->delete();
            if($test_answer_delete){
                $test_cont->commit();//成功
                $data['status']  = 1;
                $this->ajaxReturn($data);
                exit;
            }else{
                $test_cont->rollback();//失败
                $data['status']  = 2;
                $this->ajaxReturn($data);
                exit;
            }
        }else{
            $test_cont->rollback();//失败
            $data['status']  = 2;
            $this->ajaxReturn($data);
            exit;
        }
    }

    /*
     * 考试结果
     * */
    public function test_result(){
        $detailed=D('member_test_result');
        $name=I('name');
        $parameter=$detailed->index($name);
        $this->name=$name;
        $this->list=$parameter;
        $this->count=count($parameter);
        $this->display();
    }
    /*
     * 考试结果详细
     * */
    public function detailedResults(){
        $detailed=D('member_test_result');
        $id=I('id');
        $parameter=$detailed->detailedResults($id);
        $this->list=$parameter;
        $this->display();
    }

    /**
     * 生成pdf
     */
    public function pdf(){
        $detailed=D('member_test_result');
        $id=I('id');
        $parameter=$detailed->pdf($id);
        pdf($parameter);
    }
}