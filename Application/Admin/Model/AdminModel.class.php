<?php
/**

        2017-6-1

*/
namespace Admin\Model;
use Think\Model;
class AdminModel extends Model{
    //默认
    protected $tableName = 'manager';

    public function managerList(){
            /**************************************** 搜索 ****************************************/
        $where = array();
        if($username = I('post.admin'))
            $where['username'] = array('like', "%$username%");
            if(I('post.start_time')){
                $tstart = strtotime(I('post.start_time'));
            }else{
                 $tstart = 0;
            }
            if(I('post.end_time')){
                 $tend = strtotime(I('post.end_time'));
             }else{
                $tend = time();
             }
            $where['last_login_time'] = array(array('EGT',$tstart),array('ELT',$tend), 'and') ;
            $where['a.status'] = array('neq', -1);
        /************************************* 翻页 ****************************************/
        $count = M($this->tableName)->alias('a')->where($where)->count();
        // echo M($this->tableName)->getLastSql();die;
        $data['count'] = $count;
        $pageSize  =10;
        $page = new \Think\Page($count, $pageSize);
        // 配置翻页的样式
        $page->setConfig('prev', '上一页');
        $page->setConfig('next', '下一页');
        $data['page'] = $page->show();
        /************************************** 取数据 ******************************************/
        $data['data'] = M($this->tableName)->alias('a')->field('a.*,r.name')->where($where)
                          ->join('LEFT JOIN manager_auth_role r on r.id=a.role_id')
                          ->limit($page->firstRow.','.$page->listRows)
                          ->order('id')->select();
        return $data;
    }

    public function get_manager_list(){
        $param = I('param.');
        if($param['admin']){
            $map['a.username'] = array('like',"%{$param['admin']}%");
        }
        if($param['start_time']){
            $start_time = strtotime($param['start_time']);
        } else {
            $start_time = 0;
        }
        if($param['end_time']){
            $end_time = strtotime($param['end_time'])+86400;
        } else {
            $end_time = time();
        }
        $map['a.last_login_time']  = array(array('egt',$start_time),array('elt',$end_time),'and'); 
        $map['a.status'] = array('neq', -1);
        $data = M($this->tableName)->alias('a')
                                            ->field('a.*,r.name')
                                            ->where($map)
                                            ->join('LEFT JOIN manager_auth_role r on r.id=a.role_id')
                                            ->order('id')
                                            ->select();
        foreach($data as $key => $val){
            $data[$key]['create_time'] = date('Y-m-d H:i',$val['create_time']);
            if($data[$key]['last_login_time']){
                $data[$key]['last_login_time'] = date('Y-m-d H:i',$val['last_login_time']);
            }else{
                $data[$key]['last_login_time'] = 0;
            }
        }
        return $data;
    }
   
}

