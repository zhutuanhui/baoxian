<?php
/**
 * Created by PhpStorm.
 * User: 孙贵登
 * Date: 2017/5/26
 * Time: 15:22
 */
namespace Admin\Controller;
//use Think\Controller;
use Common\Controller\AdminbaseController;
class ManMessageController extends AdminbaseController{
    /*
     * 标准店，旗舰店，会员列表
     * $name    会员姓名
     * $member_level  会员等级
     * */
    public function index(){
        $comments=D('member');
        $name=I('name');
        //$member_level=I('member_level');
        $parameter=$comments->index($name);
        foreach ($parameter as $v) {
          if($v['member_level']==0){
             $result['member_level']='会员';
          }elseif($v['member_level']==1) {
             $result['member_level']='资深业务员';
          }elseif($v['member_level']==2){
             $result['member_level']='标准店';
          }else{
             $result['member_level']='旗舰店';
          } 
          $result['name']=$v['name'];
          $result['total_income']=$v['total_income'];
          $parameters[]=$result;
        }
        $this->name=$name;
        $this->list=$parameters;
        $this->count=count($parameter);
        $this->display();
    }

    /*
     *发送消息
     * */
    public function send(){ 
        $comments=M('insu_message');
        $detail=M('insu_message_text');  
        $id=I('id');
        $text=I('text_content');
        $title=I('text_title');
        if(IS_AJAX){
            $datas['text_content']=$text;
            $datas['text_title']=$title;
            $datas['add_time']=time();
            $result=$detail->add($datas);
            if($result){
                $insertid=$result;
            }
            $param = array_filter(I('post.'));
            $param['send_time']=time();
            $param['to_member_id']=session('adminId');
            $param['rec_id']=$id;
            $param['type_message']=2;
            $param['send_way']=2;
            $param['text_id']=$insertid;
            $return=$comments->add($param);
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
        $this->assign('id',$id);
        $this->display();
    }
    /*
     *消息列表
     * */
    public function messagelist(){     
        $id=I('id');
        $list = M('insu_message a')
           ->join('left join member b ON a.rec_id=b.mid')
           ->join('left join insu_message_text c ON a.text_id=c.text_id')
           ->field('a.notify_id,a.send_way,a.type_message,a.text_id,a.send_time,b.member_level,c.text_content')
           ->select();
        foreach ($list as $v) {
            $result['notify_id']=$v['notify_id'];
            $result['text_id']=$v['text_id'];
            $result['text_content']=$v['text_content'];
            $result['send_time']=date('Y-m-d H:i:s',$v['send_time']);
            if($v['send_way']==2){
               $result['send_way']='站内信'; 
            }else{
               $result['send_way']='短信'; 
            }
            if($v['type_message']==2){
               $result['type_message']='人工发送'; 
            }else{
               $result['type_message']='系统发送'; 
            }
            if($v['member_level']==0){
             $result['member_level']='会员';
            }elseif($v['member_level']==1) {
             $result['member_level']='资深业务员';
            }elseif($v['member_level']==2){
             $result['member_level']='标准店';
            }else{
             $result['member_level']='旗舰店';
            } 
            $lists[]=$result;
        }   
        $this->assign('list',$lists);
        $this->count=count($list);
        $this->display();
    }
    /*
     * 回复
     * */
    public function reply(){
        $comments=D('leave_comments');
        $id=I('id');
        if(IS_AJAX){
            $param = array_filter(I('post.'));
            $param['recomments_date']=time();
            $param['reco_id']=session('adminId');
            $param['status']='1';
            $return=$comments->where(array('id'=>$id))->save($param);
            if($return){
                $data['status']  = 1;
                $this->ajaxReturn($data);
                exit;
            }else{
                $data['status']  = 0;
                $this->ajaxReturn($data);
                exit;
            }
        }
        $parameter=$comments->reply($id);
        $this->id=$id;
        $this->list=$parameter;
        $this->display();
    }
    /*
     * 删除
     * */
    public function del(){
        $id=I('text_id');
        $status=I('status','',int);
        $case_item=D('insu_message')-> where('text_id='.$id)->delete();
        if(case_item){
           $result=D('insu_message_text')-> where('text_id='.$id)->delete();
        }
        if($result AND $status==-1){
            $data['status']  = 2;
            $this->ajaxReturn($data);
            exit;
        }else{
            $data['status']  = 1;
            $this->ajaxReturn($data);
            exit;
        }
    }
    /*
     *系统发送
    */
     public function system(){
        $comments=D('member');
        $name=I('name');
        $parameter=$comments->indexs($name,$member_level);
        foreach ($parameter as $v) {
          if($v['member_level']==0){
             $result['member_level']='会员';
          }elseif($v['member_level']==1) {
             $result['member_level']='资深业务员';
          }elseif($v['member_level']==2){
             $result['member_level']='标准店';
          }else{
             $result['member_level']='旗舰店';
          } 
          $result['name']=$v['name'];
          $result['total_income']=$v['total_income'];
          $parameters[]=$result;
        }
        $this->name=$name;
        $this->list=$parameters;
        $this->count=count($parameter);
        $this->display();
    }

}