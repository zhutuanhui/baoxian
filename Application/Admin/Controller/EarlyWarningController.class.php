<?php
/**
 * 考核预警管理
 */
namespace Admin\Controller;
use Common\Controller\AdminbaseController;
use think\Controller;

class EarlyWarningController extends AdminbaseController
{


    /**
     * 考核预警列表页面 没有数据
     * @author iyting <[<iyting@foxmail.com>]>
     * @return [type] [description]
     * @date  2017/05/9
     */
    public function index()
    {

        $this->list_tables();


    }
    /**
     *考核预警列表 带数据
     *@author iyting <[<iyting@foxmail >]>
     * @return [type] [description]
     */

    public function list_tables()
    {
        if(IS_POST){
            if(I('post.branch')) {
                $keyword = I('post.branch');
                $condition['org_code']  = $keyword;
                $this->assign('serach_keyword',$keyword);
            }
        }
        $this->assign('branch_office',$this->_get_branch_code());
        $this->display('index');

    }
    /**
     *  计算标准店旗舰店业务指标
     * @param  [array] $param [机构数组]
     * @return [type]        [description]
     */
    public function business_indicators(&$param)
    {
        if(is_array($param)) {
            $assess_obj = M('shop_assess_standard');

            foreach ($param as &$value) {   //循环设置店铺状态考核标准
                $value['shop_level'] = $this->_get_shop_level($value['level'],$value['status']);
            }

        } else {
            return '参数不正确';
        }
    }

    /**
     * 根据店铺状态返回店铺考核标准表等级
     * @author iyting <[<iyting@foxmail.com>]>
     * @param  [int] $shop_level  [店铺等级]
     * @param  [int] $shop_status [店铺状态]
     * @return [type]              [description]
     */
    protected function _get_shop_level($shop_level,$shop_status)
    {
        if(isset($shop_level) && isset($shop_status)) {

            if ($shop_level==2) {    //旗舰店
                if($shop_status==1 or $shop_status==-1){        //旗舰店经营期和观察期
                    return 4;
                } elseif ($shop_status==0) {        //旗舰店筹备期
                    return 3;
                }

            } elseif($shop_level==3) {  //标准店

                if ($shop_status==1 or $shop_status==-1) {
                    return 2;   //标准店经营期和观察期
                } elseif($shop_status==0) {

                    return 1;   //标准店筹备期
                }

            } else {
                return false;
            }
        } else {
            return false;
        }

    }
    /**
     * 查询考核店铺标准表 将所有店铺考核标准查询出来放入缓存
     * @author iyting <[<iyting@foxmail.com>]>
     * @return [type] [description]
     */
    protected function _get_cache_shop_assess_standrd()
    {

        $shop_assess_model = M('shop_assess_standard');

        //A类标准
        $result_1_1 = $shop_assess_model
                    ->cache('result_1_1',60)
                    ->where('shop_level = 1 and area_standard = 1')
                    ->find();   //A类标准 标准店筹备期
        $result_1_2 = $shop_assess_model
                    ->cache('result_1_2',60)
                    ->where('shop_level = 1 and area_standard = 2')
                    ->find();   //A类标准 标准店经营期和观察期
        $result_1_3 = $shop_assess_model
                    ->cache('result_1_3',60)
                    ->where('shop_level = 1 and area_standard = 3')
                    ->find();   //A类标准 旗舰店筹备期
        $result_1_4 = $shop_assess_model
                    ->cache('result_1_4',60)
                    ->where('shop_level = 1 and area_standard = 4')
                    ->find();   //A类标准 旗舰店经营期和观察期期
        //B类标准

        $result_2_1 = $shop_assess_model
                    ->cache('result_2_1',60)
                    ->where('shop_level = 2 and area_standard = 1')
                    ->find();   //B类标准 标准店筹备期
        $result_2_2 = $shop_assess_model
                    ->cache('result_2_2',60)
                    ->where('shop_level = 2 and area_standard = 2')
                    ->find();   //B类标准 标准店经营期和观察期
        $result_2_3 = $shop_assess_model
                    ->cache('result_2_3',60)
                    ->where('shop_level = 2 and area_standard = 3')
                    ->find();   //B类标准 旗舰店筹备期
        $result_2_4 = $shop_assess_model
                    ->cache('result_2_4',60)
                    ->where('shop_level = 2 and area_standard = 4')
                    ->find();   //B类标准 旗舰店经营期和观察期期
         //C类标准

        $result_3_1 = $shop_assess_model
                    ->cache('result_3_1',60)
                    ->where('shop_level = 2 and area_standard = 1')
                    ->find();   //C类标准 标准店筹备期
        $result_3_2 = $shop_assess_model
                    ->cache('result_3_2',60)
                    ->where('shop_level = 2 and area_standard = 2')
                    ->find();   //C类标准 标准店经营期和观察期
        $result_3_3 = $shop_assess_model
                    ->cache('result_3_3',60)
                    ->where('shop_level = 2 and area_standard = 3')
                    ->find();   //C类标准 旗舰店筹备期
        $result_3_4 = $shop_assess_model
                    ->cache('result_3_4',60)
                    ->where('shop_level = 2 and area_standard = 4')
                    ->find();   //C类标准 旗舰店经营期和观察期

    }
    /**
     *   //查询出机构表所有分公司
     * @return [type] [description]
     */
    protected function _get_branch_code()
    {

        $condition['level'] = array('eq','1') ; //将分公司从查询表中剔除
        $result =M('organization')
                ->where($condition)
                ->field('org_id,branch_shop_code,org_code,name,level,examine_standard,status')
                ->select();
        return $result;
  }
     /**
     *   //查询出考核预警表考核结果所以考核时间
     * @return [type] [description]
     */
    protected function _get_check_result_date()
    {

        $condition['check_type'] = array('eq','1') ; //预警表中未考核结果的条件
        $condition['shop_type'] = array('neq','1') ; //去除分公司


        $result = M('check_warning')->where($condition)->field('check_time')->group('check_time')->select();
        return $result;
  }
    /**
     * 查询预警管理表
     * @return [type] [description]
     */
    public function get_list_tables(){

        $param = I('param.');

        $page_start = $param['page'];
        $page_limit = $param['limit'];


        $condition['shop_type'] = array('neq','1') ; //将分公司从查询表中剔除
        $condition['check_type'] = array('eq','0') ; //查询考核预警表不是考核结果的数据

        if($param['condition']!=0) {

            $condition['branch_shop_number'] = array('eq',$param['condition']);

        }

        $check_warning_obj = M('check_warning');
        $max_check_time = $check_warning_obj->max('check_time');        //查询表中考核时间最大的 即最新数据
        if(!empty($max_check_time)){
            $condition['check_time'] = array('eq',$max_check_time);
        }

        $check_warning_count = $check_warning_obj->where($condition)
                                                 ->count();

        $check_warning_result = $check_warning_obj->where($condition)
                                                  ->page("{$page_start},{$page_limit}")
                                                  ->select();


        $data['draw'] = intval($param['draw']);
        $data['total'] = $check_warning_count;
        $data['data'] = $check_warning_result;

        echo json_encode($data);
    }

    /**
     * 手动预警
     * @return [type] [description]
     */
    public function passivity_warning() {
        if(IS_AJAX){

            $this->_get_waring_info();
        }


    }
    public function _get_waring_info(){

        $param = I('param.');

        //查询出机构表所有标准店 旗舰店
        $condition['level'] = array('neq','1') ; //将分公司从查询表中剔除
        $condition['check_status'] = array('eq','1') ; //去除失效店铺

        $result = M('organization')
                ->where($condition)
                ->field('org_id,
                        org_code,
                        name,
                        level,
                        branch_shop_code,
                        flagship_code,
                        examine_standard,
                        status,
                        start_time,
                        end_time,
                        principal_number')
            ->select();


        //计算各个店铺不同状态（筹备期 经营期）的业务指标
        $this->business_indicators($result);

        //将各个店铺不同的考核标准查询出来放入缓存
        $this->_get_cache_shop_assess_standrd();
        foreach ($result as &$value) {
             //店铺指标
            $business  = S('result_'.$value['examine_standard'].'_'.$value['shop_level']);

            //业指参考

            if($business!=false) {
                $result_business_indicators = $this->_get_shop_business_indicators($value,$business);
                $value['business_ind']           = $result_business_indicators['business_ind']['aims'];//业指参考
                $value['business_reached']       = $result_business_indicators['business_ind']['reached'];
                $value['business_gap']           = $result_business_indicators['business_ind']['gap'];
                $value['direct_recom_nums']      = $result_business_indicators['direct_recom_nums']['aims'];//直接推荐会员
                $value['direct_recom_reached']   = $result_business_indicators['direct_recom_nums']['reached'];
                $value['direct_recom_gap']       = $result_business_indicators['direct_recom_nums']['gap'];
                $value['sub_people_rea']         = $result_business_indicators['sub_people_rea']['aims'];//所辖会员
                $value['sub_people_rea_reached'] = $result_business_indicators['sub_people_rea']['reached'];
                $value['sub_people_rea_gap']     = $result_business_indicators['sub_people_rea']['gap'];
                $value['recommend_shop_rea']         = $result_business_indicators['recommend_shop_rea']['aims'];   //直接推荐标准店
                $value['recommend_shop_rea_reached'] = $result_business_indicators['recommend_shop_rea']['reached'];
                $value['recommend_shop_rea_gap']     = $result_business_indicators['recommend_shop_rea']['gap'];
            }



        }

        $now_time = time();
        //添加到考核预警表
        foreach ($result as $c_key => $c_value) {

                                $dataList[]= array(
                                'shop_number'                 =>$c_value['org_code'],
                                'shop_name'                   =>$c_value['name'],
                                'shop_type'                   =>$c_value['level'],
                                'check_type'                   =>0,
                                'shop_stage'                  =>$c_value['status'],
                                'branch_shop_number'          =>$c_value['branch_shop_code'],
                                'flagship_number'             =>$c_value['flagship_code'],
                                'sub_manpower'                =>$c_value['sub_people_rea'],     //所辖会员
                                'sub_manpower_reached'        =>$c_value['sub_people_rea_reached'],
                                'sub_manpower_gap'            =>$c_value['sub_people_rea_gap'],
                                'direct_recom_shop'           =>$c_value['recommend_shop_rea'],    //直接推荐标准店
                                'direct_recom_shop_reached'   =>$c_value['recommend_shop_rea_reached'],
                                'direct_recom_shop_gap'       =>$c_value['recommend_shop_rea_gap'],

                                'direct_recom_people'         =>$c_value['direct_recom_nums'],  //直接推荐会员
                                'direct_recom_people_reached' =>$c_value['direct_recom_reached'],
                                'direct_recom_people_gap'     =>$c_value['direct_recom_gap'],
                                'achievement_target'          =>$c_value['business_ind'],    //业务指标
                                'achievement_target_reached'  =>$c_value['business_reached'],
                                'achievement_target_gap'      =>$c_value['business_gap'],
                                'create_time'                 =>$now_time,
                                'check_time'                  =>$now_time,
                             /*   'achievement_target_gap'     =>$c_value['business_gap'],    //继续率
                                'achievement_target_gap'     =>$c_value['business_gap'],
                                'achievement_target_gap'     =>$c_value['business_gap'],*/

                                );
        }

            $check_warning_obj = M('check_warning');

            $check_warning_result = $check_warning_obj->addall($dataList);
            if($check_warning_result) {
                 $this->ajaxReturn($data['status']=1);


            } else {
                $this->ajaxReturn($data['status']=0);
            }


    }
    /**
     * 查询各个店铺考核预警数据
     * @author iyting <[<email address>]>
     * @date 2017/05/11
     * @param  [type] $shop_info      [店铺信息]
     * @param  [type] $business     [该店铺考核相应指标]
     * @return [type]                [description]
     */

    protected function _get_shop_business_indicators($shop_info,$business)
    {

        if(func_num_args()==2){ //判断参数是否存在
            if($shop_info['status'] == 0 ){      //判断店铺是否筹备期

                if($shop_info['level']==2){ //旗舰店
                    $condition = " `flag_shop_number` = '".$shop_info['org_code']."'";
                  //  $condition['flag_shop_number'] = array('eq',$shop_info['org_code']); //旗舰店店铺代码

                } elseif($shop_info['level'] == 3) {  //标准店
                    $condition = " `standard_shop_number` = '".$shop_info['org_code']."'";
                }

                $beginThismonth =  strtotime(date('Y-m-01',$shop_info['start_time']));  //筹备期考核起始月份
                $endThismonth = strtotime('+3 month',$beginThismonth);      //筹备期考核结束时间

                //回访成功日期
                $return_visit_date = strtotime('+20 day',$endThismonth);
                //回执日期
                $return_date = strtotime('+10 day',$endThismonth);
                //查询该店铺当月首期寿险业务指标
                //拼接sql查询语句
                $sql_query=<<<EOF
                SELECT
                    SUM(value_premium) AS tp_sum
                FROM
                    `insurance`
                WHERE
                $condition
                AND `insurance_type` = 1
                AND `insurance_status` = 1
                AND `surrender_date` =0
                AND `hesitate_date` =0

                AND (
                    insured_date >= $beginThismonth
                    AND insured_date < $endThismonth
                )
                AND (
                    return_visit_date <= $return_visit_date
                    AND return_visit_date != 0
                    AND return_visit_date IS NOT NULL
                )
                AND (
                    return_date <= $return_date
                    AND return_visit_date != 0
                    AND return_visit_date IS NOT NULL
                )
                LIMIT 1
EOF;

                // 实例化一个model对象 没有对应任何数据表
                $insurance_model = new \Think\Model();
                //对考核业务指标价值保费进行求和
                $result = $insurance_model->query($sql_query);
                $result = current(array_column($result,'tp_sum'));

                /**查询筹备期店长所属会员有没有与自己同一时间筹备考核时间  如果有 则考核业务指标降低50%**/
                $member_result = M('member')
                                ->where('recommend_member_id = '.$shop_info['principal_number'])
                                ->getField('m_number',true);

                if(!empty($member_result)) {
                    $map['principal_number']  = array('in',$member_result);

                   $org_result  =  M('organization')->where($map)
                                                    ->field('month(from_unixtime(start_time)) as start_month')
                                                    ->select();
                    if(!empty($org_result)){
                        $org_result_start_month = array_column($org_result, 'start_month');
                        $shop_info_start_month = date('n',$shop_info['start_time']);

                        //判断是否含有和自己筹备起始月一样的店铺
                        if(in_array($shop_info_start_month,$org_result_start_month)) {
                            $business['business_ind']*=0.5; //业务指标降低50%

                        }

                    }
                }

                /****************************************************************************************/
                  /**人力指标**/
                //所属店铺直接推荐人
                $direct_recom_nums = $this->_get_direct_recom_nums($shop_info['principal_number'],$endThismonth);

                if($direct_recom_nums) {
                    $business_result['direct_recom_nums'] =array(
                                                        'aims'    => $business['first_hand_human'],
                                                        'reached' => $direct_recom_nums,
                                                        'gap'     => $direct_recom_nums-$business['first_hand_human']
                                                        );

                } else {
                     $business_result['direct_recom_nums'] =array(
                                                        'aims'    => $business['first_hand_human'],
                                                        'reached' => $direct_recom_nums,
                                                        'gap'     => $direct_recom_nums-$business['first_hand_human']
                                                        );
                }
                //判断店铺类型 是否旗舰店  旗舰店需要计算所辖人数和直接推荐标准店
                 if ($shop_info['level']==2) { //旗舰店

                    //查询所辖会员
                        $member_obj = M('member');

                        $map['recommend_member_id'] = array('eq',$shop_info['principal_number']);
                        $map['flagship_number']     = array('eq',$shop_info['org_code']);

                        $map['register_time']       = array('lt',$endThismonth);
                        $map['status']              = array('eq',1);
                        $sub_people_count           = $member_obj->where($map)->count();  //所辖人力总数

                        if ($sub_people_count) {
                             $business_result['sub_people_rea'] = array(
                                            'aims'    => $business['sub_people_rea'],
                                            'reached' => $sub_people_count,
                                            'gap'     => $sub_people_count-$business['sub_people_rea']);
                        } else {
                            $business_result['sub_people_rea'] = array(
                                            'aims'    => $business['sub_people_rea'],
                                            'reached' => 0,
                                            'gap'     => $sub_people_count-$business['sub_people_rea']);
                        }


                    $recommend_shop_rea_cout = $this->_get_direct_shop($shop_info,$endThismonth);
                     if ($recommend_shop_rea_cout) {
                             $business_result['recommend_shop_rea'] = array(
                                            'aims'    => $business['recommend_shop_rea'],
                                            'reached' => $recommend_shop_rea_cout,
                                            'gap'     => $recommend_shop_rea_cout-$business['recommend_shop_rea']);
                        } else {
                            $business_result['recommend_shop_rea'] = array(
                                            'aims'    => $business['recommend_shop_rea'],
                                            'reached' => 0,
                                            'gap'     => $recommend_shop_rea_cout-$business['recommend_shop_rea']);
                        }
                } else {
                    $recommend_shop_rea_cout = $this->_get_direct_shop($shop_info,$endThismonth);

                    $business_result['sub_people_rea'] = array('aims' => 0,'reached' => 0, 'gap' => 0);
                    $business_result['recommend_shop_rea'] = array('aims' => 0, 'reached' => 0,'gap' => 0);

                }

               /*******************************************************************/
                if ($result) { //计算业务指标 达成和差距


                    $business_result['business_ind'] = array(
                                            'aims'    => $business['business_ind'],
                                            'reached' => $result,
                                            'gap'     => $result-$business['business_ind']);


                } elseif(is_null($result)) {

                    $business_result['business_ind'] = array(
                                            'aims'    => $business['business_ind'],
                                            'reached' => 0,
                                            'gap'     => $result-$business['business_ind']);

                }


                return $business_result;

            } else {        //店铺经营期考核指标

                if($shop_info['level']==2){ //旗舰店
                    $condition = ' `flag_shop_number` = '.$shop_info['org_code'];

                } elseif($shop_info['level'] == 3) {  //标准店
                    $condition = ' `standard_shop_number` = '.$shop_info['org_code'];
                }

                $endparamDate    = (date('Y-m-1',$shop_info['end_time']));
                 //店铺经营期开始时间为筹备期结束时间的下个月
                $beginDateMon    = getdate(strtotime('+1 month ',$shop_info['end_time'])); //经营期考核开始时间

                $nowDateInfo   = getdate(time());

                $nowMon = $nowDateInfo['mon'];
                $nowDay = $nowDateInfo['mday'];

                $is_check_six_year = 0;//是否满足自然半年

                if( $nowMon >= 7 ){ // 7 8 9 10 11 12  //下半年预警
                    $differMon =  getMonthNum(date('Y-12-1'),$endparamDate);

                    if($differMon > 6){//满足自然半年
                        $is_check_six_year = 1;
                    }elseif($differMon == 6) { //首期自然半年   判断是否有同时筹备
                        $is_check_six_year = 2;
                    }elseif($differMon < 6) {
                        //不足自然半年 按实际考核业绩算 判断是否有同时筹备
                        $is_check_six_year = 3;
                    }

                    $beginThismonth = date('Y-7-1');
                    $endThismonth = date('Y-1-1',strtotime('+1 year'));

                }elseif($nowMon <= 6) { // 1 2 3 4 5   上半年预警

                    $differMon =  getMonthNum(date('Y-6-1'),$endparamDate);

                    if($differMon > 6){//满足自然半年
                         $is_check_six_year = 1;
                    }elseif($differMon == 6) { //首期自然半年   判断是否有同时筹备
                        $is_check_six_year = 2;
                    }elseif($differMon < 6 ) {
                        //不足自然半年 按实际考核业绩算 判断是否有同时筹备
                        $is_check_six_year = 3;
                    }

                    $beginThismonth = date('Y-1-1',time());

                    $endThismonth = date('Y-7-1',time());
                }







                //回执日期
                $return_date       = strtotime('+10 day',$endThismonth);
                 //回访成功日期
                $return_visit_date = strtotime('+20 day',$endThismonth);
                //查询该店铺当月首期寿险业务指标
                //拼接sql查询语句
                $sql_query=<<<EOF
                SELECT
                    SUM(value_premium) AS tp_sum FROM `insurance`
                WHERE $condition AND `insurance_type` = 1
                AND `insurance_status` = 1
                AND `surrender_date` =0
                AND `hesitate_date` =0

                AND (
                    insured_date >= $beginThismonth
                    AND insured_date < $endThismonth
                )
                AND (
                    return_visit_date < $return_visit_date
                    AND return_visit_date != 0
                    AND return_visit_date IS NOT NULL
                )
                AND (
                    return_date < $return_date
                    AND return_visit_date != 0
                    AND return_visit_date IS NOT NULL
                )
                LIMIT 1
EOF;

                 // 实例化一个model对象 没有对应任何数据表
                $insurance_model = new \Think\Model();
                //对考核业务指标价值保费进行求和
                $result = $insurance_model->query($sql_query);
                $result = current(array_column($result,'tp_sum'));

                /****************************************************************************************/
                  /**人力指标**/
                //所属店铺直接推荐人  //经营期没有直接推荐人指标
                $business_result['direct_recom_nums'] =array('aims'    => 0,'reached' => 0,'gap'     => 0);

                //判断店铺类型 是否旗舰店  旗舰店需要计算所辖人数和直接推荐标准店
                 if ($shop_info['level']==2) { //旗舰店

                    //查询所辖会员
                        $member_obj = M('member');

                        $map['recommend_member_id'] = array('eq',$shop_info['principal_number']);
                        $map['flagship_number']     = array('eq',$shop_info['org_code']);

                        $map['register_time']       = array('lt',$endThismonth);
                        $map['status']              = array('eq',1);
                        $sub_people_count           = $member_obj->where($map)->count();  //所辖人力总数

                        if ($sub_people_count) {                    //所辖人力总数
                             $business_result['sub_people_rea'] = array(
                                            'aims'    => $business['sub_people_rea'],
                                            'reached' => $sub_people_count,
                                            'gap'     => $sub_people_count-$business['sub_people_rea']);
                        } else {
                            $business_result['sub_people_rea'] = array(
                                            'aims'    => $business['sub_people_rea'],
                                            'reached' => 0,
                                            'gap'     => $sub_people_count-$business['sub_people_rea']);
                        }


                     $recommend_shop_rea_cout = $this->_get_sub_shop($shop_info,$endThismonth);   //直接推荐标准店

                     if ($recommend_shop_rea_cout) {
                             $business_result['recommend_shop_rea'] = array(
                                            'aims'    => $business['recommend_shop_rea'],
                                            'reached' => $recommend_shop_rea_cout,
                                            'gap'     => $recommend_shop_rea_cout-$business['recommend_shop_rea']);
                    } else {
                            $business_result['recommend_shop_rea'] = array(
                                            'aims'    => $business['recommend_shop_rea'],
                                            'reached' => 0,
                                            'gap'     => $recommend_shop_rea_cout-$business['recommend_shop_rea']);


                    }

                       /*******************************************************************/
                    if ($result) { //计算业务指标 达成和差距


                        $business_result['business_ind'] = array(
                                                'aims'    => $business['business_base']+($recommend_shop_rea_cout-3)*$business['business_multiple'],
                                                'reached' => $result,
                                                'gap'     => $result-($business['business_base']+($recommend_shop_rea_cout-3)*$business['business_multiple'])
                                                    );


                    } elseif(is_null($result)) {

                        $business_result['business_ind'] = array(
                                                'aims'    => $business['business_ind'],
                                                'reached' => 0,
                                                'gap'     => $result-($business['business_base']+($recommend_shop_rea_cout-3)*$business['business_multiple']));

                    }

                } else {    //标准店经营期

                    $isPercent50 = false;   //业务指标降低50%flag
                    $member_obj = M('member');

                    $business_result['recommend_shop_rea'] = array('aims' => 0, 'reached' => 0,'gap' => 0); //直接推荐标准店

                    if($is_check_six_year==2 or $is_check_six_year ==3){    //判断是否达到查询同时筹备条件
                         /**查询经营期店长所属会员有没有与自己同一时间筹备考核时间  如果有 则考核业务指标降低50%**/
                        $member_result = $member_obj
                                    ->where('recommend_member_id = '.$shop_info['principal_number'])
                                    ->getField('m_number',true);

                        if(!empty($member_result)) {
                            $map['principal_number']  = array('in',$member_result);
                            $map['status']  = array('eq',1);

                            $org_result  =  M('organization')->where($map)
                                                            ->field('month(from_unixtime(end_time)) as end_month')
                                                            ->select();
                            if(!empty($org_result)){
                                $org_result_start_month = array_column($org_result, 'end_month');
                                $shop_info_start_month = date('n',$shop_info['end_time']);

                                //判断是否含有和自己经营期起始月一样的店铺
                                if(in_array($shop_info_start_month,$org_result_start_month)) {

                                    $isPercent50 = true;

                                }

                            }
                        }

                    }#判断是否查询同时筹备闭合标签

                    //查询所辖会员
                    $map['recommend_member_id'] = array('eq',$shop_info['principal_number']);
                    $map['flagship_number']     = array('eq',$shop_info['org_code']);

                    $map['register_time']       = array('lt',$endThismonth);
                    $map['status']              = array('eq',1);
                    $sub_people_count           = $member_obj->where($map)->count();  //所辖人力总数

                    //所辖人力总数
                    if ($sub_people_count) {
                         $business_result['sub_people_rea'] = array(
                                    'aims'    => $business['sub_people_rea'],
                                    'reached' => $sub_people_count,
                                    'gap'     => $sub_people_count-$business['sub_people_rea']);

                    } else {
                        $business_result['sub_people_rea'] = array(
                                        'aims'    => $business['sub_people_rea'],
                                        'reached' => 0,
                                        'gap'     => $sub_people_count-$business['sub_people_rea']);
                    }

                      /*******************************************************************/
                    if ($result) { //计算业务指标 达成和差距

                         //如果达到业务指标达到降低50%指标 而且不足自然半年
                         //
                        if($isPercent50 && $is_check_six_year ==3 ){
                            $business_result['business_ind'] = array(
                                        'aims'    => $business['business_ind']/6*$differMon,
                                        'reached' => $sub_people_count,
                                        'gap'     => $sub_people_count-$business['business_ind']);
                        } elseif($isPercent50 && $is_check_six_year == 2) { //如果达到业务指标达到降低50%指标 而且足自然半年
                            $business_result['business_ind'] = array(
                                        'aims'    => $business['business_ind']*0.5,
                                        'reached' => $sub_people_count,
                                        'gap'     => $sub_people_count-$business['business_ind']);
                        } else {
                             $business_result['business_ind'] = array(
                                        'aims'    => $business['business_ind'],
                                        'reached' => $sub_people_count,
                                        'gap'     => $sub_people_count-$business['business_ind']);
                        }
                    } elseif(is_null($result)) {

                        $business_result['business_ind'] = array(
                                                'aims'    => $business['business_ind'],
                                                'reached' => 0,
                                                'gap'     => $result-$business['business_ind']);

                    }


                }

                return $business_result;
        }

        } else {

            return false;
        }

    }

    /**
     *
     * 获取会员直接推荐人数
     * @author iyting <[<iyting@foxmail address>]>
     * @date 2017/05/11
     * @param  [type] $member_code [会员编码]
     * @param [type] $endThismonth [<考核结束日期>]
     * @return [type]              [description]
     */
    public function _get_direct_recom_nums ($member_code,$endThismonth){

        if(func_num_args()>0){
            $member_obj = M('member');
            $map['recommend_member_id'] = array('eq',$member_code);
            $map['register_time'] = array('lt',$endThismonth);
            $map['status'] = array('eq',1);
            $result = $member_obj->where($map)->count();

            return $result;
        }else{
            return false;
        }
    }
    /**
     * 获取直接推荐标准店
     *  @author iyting <[<iyting@foxmail.com]>
     *  @date 2017/5/12
     *  @param [type] $[shop_info] [<店铺详细信息>]
     *  @param [type] $[endThismonth] [<考核结束日期>]
      */
    public function _get_direct_shop($shop_info,$endThismonth){
        if (func_num_args()==2) {
            $organization_obj     = M ('organization');
            $map['flagship_code'] = array('eq',$shop_info['org_code']);
            $map['check_status']  = array('eq',1);
            $map['create_time']   = array('lt',$endThismonth);

            $result               = $organization_obj->where($map)
                                                     ->count();

            return $result;
        } else {
            return false;
        }

    }
    /**
     * 获取旗舰店所辖标准店
     * @param  [type] $shop_info    [description]
     * @param  [type] $endThismonth [description]
     * @return [type]               [description]
     */
    public function _get_sub_shop($shop_info,$endThismonth){
        if(func_num_args()==2){
            $organization_obj     = M ('organization');
            $map['flagship_code'] = array('eq',$shop_info['org_code']);
            $map['check_status']  = array('eq',1);
            $map['create_time']   = array('lt',$endThismonth);
            $map['status']   = array('neq',0);  //排除筹备期

            $result               = $organization_obj->where($map)
                                                     ->count();
        } else {
            return false;
        }
    }
    /**
     * 考核结果筹备期
     * @author iyting <[<email address>]>
     * @return [type] [description]
     */
    public function check_result_prepara()
    {
        if(IS_AJAX){

            $param = I('param.');

            if($param['page'] && $param['limit']){
                $page_start = $param['page'];
                $page_limit = $param['limt'];
            }else {
                $page_start = $param['start'];
                $page_limit = $param['length'];
            }

            if($param['condition']!=0) {    //分公司
                $condition['branch_shop_number'] =$param['condition'];
            }

            if($param['shop_number']!=0) {        //店铺代码
                $condition['shop_number'] =$param['shop_number'];
            }
            if($param['shop_type']!=0) {        //店铺类型
                $condition['shop_type'] =$param['shop_type'];
            }else{
                $condition['shop_type'] = array('neq',1) ; //将分公司从查询表中剔除
            }

            $condition['check_type'] = array('eq',1) ; //查询考核预警表是考核结果的数据
            $condition['shop_stage'] = array('eq',0) ; //筹备类型店铺
            $check_warning_obj = M('check_warning');
            if($param['date_scope']!=0) {

                $condition['check_time'] = array('eq',$param['date_scope']);
            }else{
                 $max_check_time = $check_warning_obj->where($condition)->max('check_time');        //查询表中考核时间最大的 即最新数据
            }



            if(!empty($max_check_time)){
                $condition['check_time'] = array('eq',$max_check_time);
            }

            $check_warning_count = $check_warning_obj->where($condition)->count();
            $check_warning_result = $check_warning_obj->where($condition)
                                                      ->page("{$page_start},{$page_limit}")
                                                      ->select();


            $data['draw'] = intval($param['draw']);
            $data['total'] = $check_warning_count;
            $data['data'] = $check_warning_result;

            echo json_encode($data);
        }else{
            if(IS_POST){
                if(I('post.branch')) {
                    $keyword = I('post.branch');
                    $condition['org_code']  = $keyword;
                    $this->assign('serach_keyword',$keyword);
                }
            }

            //var_dump(array_column($this->_get_check_result_date(), 'check_time'));exit;
            $this->assign('branch_office',$this->_get_branch_code());
            $this->assign('check_time',array_column($this->_get_check_result_date(), 'check_time'));
            $this->display('prepara_check');
        }


    }
    /**
     * 经营期考核结果计算方法
     */
    public function get_check_business(){
        $organization_obj = M('organization');

        //查询机构表有效经营期店铺
        $condition['status'] = array('neq',0);
        $condition['level'] = array('neq',1);   //去除筹备期店铺

        $condition['check_status'] = array('eq',1); //店铺状态有效

        $result = $organization_obj->where($condition)
                                    ->field('introduce,address,lawyer_num,telphone,fax,email',true)
                                    ->select();



        if($result){


            //计算各个店铺不同状态（ 经营期）的业务指标
            $this->business_indicators($result);

            //将各个店铺不同的考核标准查询出来放入缓存
            $this->_get_cache_shop_assess_standrd();

            foreach ($result as &$value) {
             //店铺指标
                $business  = S('result_'.$value['examine_standard'].'_'.$value['shop_level']);

                if($business!=false) {
                    $result_business_indicators     = $this->_get_shop_business_indicators($value,$business);
                    $value['business_ind']           = $result_business_indicators['business_ind']['aims'];//业指参考
                    $value['business_reached']       = $result_business_indicators['business_ind']['reached'];
                    $value['business_gap']           = $result_business_indicators['business_ind']['gap'];
                    $value['direct_recom_nums']      = $result_business_indicators['direct_recom_nums']['aims'];//直接推荐会员
                    $value['direct_recom_reached']   = $result_business_indicators['direct_recom_nums']['reached'];
                    $value['direct_recom_gap']       = $result_business_indicators['direct_recom_nums']['gap'];
                    $value['sub_people_rea']         = $result_business_indicators['sub_people_rea']['aims'];//所辖会员
                    $value['sub_people_rea_reached'] = $result_business_indicators['sub_people_rea']['reached'];
                    $value['sub_people_rea_gap']     = $result_business_indicators['sub_people_rea']['gap'];
                    $value['recommend_shop_rea']         = $result_business_indicators['recommend_shop_rea']['aims'];   //直接推荐标准店
                    $value['recommend_shop_rea_reached'] = $result_business_indicators['recommend_shop_rea']['reached'];
                    $value['recommend_shop_rea_gap']     = $result_business_indicators['recommend_shop_rea']['gap'];

                    $get_prepar_proceed_percent = D('EarlyWarning')->get_prepar_proceed_percent($value,$business['continuation_rate']);  //继续率

                    $value['continuation_rate']         = $get_prepar_proceed_percent['bssessment_cri'];   //直接推荐标准店
                    $value['continuation_rate_rea']     = $get_prepar_proceed_percent['reached'];
                    $value['continuation_rate_gap']     = $get_prepar_proceed_percent['gap'];

                    $get_check_is_success       = D('EarlyWarning')->get_check_is_success($value);

                    if($get_check_is_success===true){   //考核成功

                        $value['check_status'] = 1;

                        if($value['level'] == 3){ //判断是否标准店

                            if($value['status'] == 1){    //判断是否经营期
                                $value['check_results'] = 0; //设置店铺为维持
                            }elseif ($value['status']==-1) { //判断是否观察期

                                $value['check_results'] = 0; //设置店铺为维持
                            }

                        }elseif($value['level'] == 2){  //判断是否旗舰店
                            if($value['status'] == 1){    //判断是否经营期
                                $value['check_results'] = 0; //设置店铺为维持
                            }elseif ($value['status'] == -1) { //判断是否观察期

                                $value['check_results'] = 0; //设置店铺为维持
                            }
                        }

                    }else{

                        $value['check_status'] = 0;
                        if($value['level']==3){ //判断是否标准店

                            if($value['status']==1){    //判断是否经营期
                                $value['check_results'] = 1; //设置店铺为观察

                            }elseif ($value['status']==-1) { //判断是否观察期

                                $value['check_results']=2 ; //设置店铺为降级
                            }

                        }elseif($value['level'] == 2){  //判断是否旗舰店
                            if($value['status'] == 1){    //判断是否经营期

                                $value['check_results'] = 0; //设置店铺为维持

                            }elseif ($value['status'] == -1) { //判断是否观察期

                                $value['check_results'] = 2; //设置店铺降级
                            }
                        }
                    }


                }
            }

            $now_time = time();
                //添加到考核预警表
             foreach ($result as $c_key => $c_value) {
                                $dataList[]= array(
                                'shop_number'                 =>$c_value['org_code'],
                                'shop_name'                   =>$c_value['name'],
                                'shop_type'                   =>$c_value['level'],
                                'check_type'                   =>1,
                                'shop_stage'                  =>$c_value['status'],
                                'branch_shop_number'          =>$c_value['branch_shop_code'],
                                'flagship_number'             =>$c_value['flagship_code'],
                                'sub_manpower'                =>$c_value['sub_people_rea'],     //所辖会员
                                'sub_manpower_reached'        =>$c_value['sub_people_rea_reached'],
                                'sub_manpower_gap'            =>$c_value['sub_people_rea_gap'],
                                'direct_recom_shop'           =>$c_value['recommend_shop_rea'],    //直接推荐标准店
                                'direct_recom_shop_reached'   =>$c_value['recommend_shop_rea_reached'],
                                'direct_recom_shop_gap'       =>$c_value['recommend_shop_rea_gap'],

                                'direct_recom_people'         =>$c_value['direct_recom_nums'],  //直接推荐会员
                                'direct_recom_people_reached' =>$c_value['direct_recom_reached'],
                                'direct_recom_people_gap'     =>$c_value['direct_recom_gap'],
                                'achievement_target'          =>$c_value['business_ind'],    //业务指标
                                'achievement_target_reached'  =>$c_value['business_reached'],
                                'achievement_target_gap'      =>$c_value['business_gap'],
                                'create_time'                 =>$now_time,
                                'check_time'                  =>$now_time,

                                'continuation_rate'         =>$c_value['continuation_rate'],    //继续率
                                'continuation_rate_rea'     =>$c_value['continuation_rate_rea'],
                                'continuation_rate_gap'     =>$c_value['continuation_rate_gap'],
                                'check_status'     =>$c_value['check_status'],

                                );
                }


            $check_warning_obj = M('check_warning');

            $check_warning_result = $check_warning_obj->addall($dataList);



        }
    }
    /**
     * 筹备期考核结果计算方法
     * @return [type] [description]
     */
    public function get_check_prepare_result(){

        $organization_obj = M('organization');

        //查询机构表有效筹备期店铺
        $condition['status'] = array('eq',0);   //筹备期店铺
        $condition['check_status'] = array('eq',1); //店铺状态有效

        $result = $organization_obj->where($condition)
                                    ->field('introduce,address,lawyer_num,telphone,fax,email',true)
                                    ->select();

        //将系统当前时间和筹备期结束时间相减得差月份 如果为一 表示为当月考核结果店铺
        $result = array_filter($result,array($this,'array_filter_prepare_date'));

        if($result){    //过滤的数组里有要考核的筹备期店铺


            //计算各个店铺不同状态（筹备期 经营期）的业务指标
            $this->business_indicators($result);

            //将各个店铺不同的考核标准查询出来放入缓存
            $this->_get_cache_shop_assess_standrd();

            foreach ($result as &$value) {
             //店铺指标

                $business  = S('result_'.$value['examine_standard'].'_'.$value['shop_level']);

                if($business!=false) {
                    $result_business_indicators = $this->_get_shop_business_indicators($value,$business);
                    $value['business_ind']           = $result_business_indicators['business_ind']['aims'];//业指参考
                    $value['business_reached']       = $result_business_indicators['business_ind']['reached'];
                    $value['business_gap']           = $result_business_indicators['business_ind']['gap'];
                    $value['direct_recom_nums']      = $result_business_indicators['direct_recom_nums']['aims'];//直接推荐会员
                    $value['direct_recom_reached']   = $result_business_indicators['direct_recom_nums']['reached'];
                    $value['direct_recom_gap']       = $result_business_indicators['direct_recom_nums']['gap'];
                    $value['sub_people_rea']         = $result_business_indicators['sub_people_rea']['aims'];//所辖会员
                    $value['sub_people_rea_reached'] = $result_business_indicators['sub_people_rea']['reached'];
                    $value['sub_people_rea_gap']     = $result_business_indicators['sub_people_rea']['gap'];
                    $value['recommend_shop_rea']         = $result_business_indicators['recommend_shop_rea']['aims'];   //直接推荐标准店
                    $value['recommend_shop_rea_reached'] = $result_business_indicators['recommend_shop_rea']['reached'];
                    $value['recommend_shop_rea_gap']     = $result_business_indicators['recommend_shop_rea']['gap'];

                    $get_prepar_proceed_percent = D('EarlyWarning')->get_prepar_proceed_percent($value,$business['continuation_rate']);  //继续率

                    $value['continuation_rate']         = $get_prepar_proceed_percent['bssessment_cri']; //继续率
                    $value['continuation_rate_rea']     = $get_prepar_proceed_percent['reached'];
                    $value['continuation_rate_gap']     = $get_prepar_proceed_percent['gap'];

                    $get_check_is_success       = D('EarlyWarning')->get_check_is_success($value);

                    if($get_check_is_success===true){
                        $value['check_status'] = 1;
                    }else{
                        $value['check_status'] = 0;
                    }


                }
            }

            $now_time = time();
                //添加到考核预警表
             foreach ($result as $c_key => $c_value) {
                                $dataList[]= array(
                                'shop_number'                 =>$c_value['org_code'],
                                'shop_name'                   =>$c_value['name'],
                                'shop_type'                   =>$c_value['level'],
                                'check_type'                   =>1,
                                'shop_stage'                  =>$c_value['status'],
                                'branch_shop_number'          =>$c_value['branch_shop_code'],
                                'flagship_number'             =>$c_value['flagship_code'],
                                'sub_manpower'                =>$c_value['sub_people_rea'],     //所辖会员
                                'sub_manpower_reached'        =>$c_value['sub_people_rea_reached'],
                                'sub_manpower_gap'            =>$c_value['sub_people_rea_gap'],
                                'direct_recom_shop'           =>$c_value['recommend_shop_rea'],    //直接推荐标准店
                                'direct_recom_shop_reached'   =>$c_value['recommend_shop_rea_reached'],
                                'direct_recom_shop_gap'       =>$c_value['recommend_shop_rea_gap'],

                                'direct_recom_people'         =>$c_value['direct_recom_nums'],  //直接推荐会员
                                'direct_recom_people_reached' =>$c_value['direct_recom_reached'],
                                'direct_recom_people_gap'     =>$c_value['direct_recom_gap'],
                                'achievement_target'          =>$c_value['business_ind'],    //业务指标
                                'achievement_target_reached'  =>$c_value['business_reached'],
                                'achievement_target_gap'      =>$c_value['business_gap'],
                                'create_time'                 =>$now_time,
                                'check_time'                  =>$now_time,

                                'continuation_rate'         =>$c_value['continuation_rate'],    //继续率
                                'continuation_rate_rea'     =>$c_value['continuation_rate_rea'],
                                'continuation_rate_gap'     =>$c_value['continuation_rate_gap'],
                                'check_status'     =>$c_value['check_status'],

                                );
                }


            $check_warning_obj = M('check_warning');

            $check_warning_result = $check_warning_obj->addall($dataList);



        }

    }
    /**
     * 筹备期考核结果调用回调函数
     * @return [type] [description]
     */
    protected function array_filter_prepare_date($var){
            $nowMon = date('Y-n',time());

            if($var['end_time']==0){
                return false;
            }else{
                $end_time_mon = date('Y-n',$var['end_time']);

                //将系统当前时间和筹备期结束时间相减得差月份
                $result = getMonthNum($nowMon,$end_time_mon);

                if($result==1){ //如果时间差为一个月
                    return true;
                } else {
                    return false;
                }
            }


    }
    /**
     * 经营期结果查询
     */
    public function check_result_business(){
        if(IS_AJAX){

            $param = I('param.');

            if($param['page'] && $param['limit']){
                $page_start = $param['page'];
                $page_limit = $param['limt'];
            }else {
                $page_start = $param['start'];
                $page_limit = $param['length'];
            }

            if($param['condition']!=0) {    //分公司
                $condition['branch_shop_number'] =$param['condition'];
            }

            if($param['shop_number']!=0) {        //店铺代码
                $condition['shop_number'] =$param['shop_number'];
            }
            if($param['shop_type']!=0) {        //店铺类型
                $condition['shop_type'] =$param['shop_type'];
            }else{
                $condition['shop_type'] = array('neq',1) ; //将分公司从查询表中剔除
            }

            $condition['check_type'] = array('eq',1) ; //查询考核预警表是考核结果的数据
            $condition['shop_stage'] = array('neq',0) ; //筹备类型店铺
            $check_warning_obj = M('check_warning');
            if($param['date_scope']!=0) {

                $condition['check_time'] = array('eq',$param['date_scope']);
            }else{
                 $max_check_time = $check_warning_obj->where($condition)->max('check_time');        //查询表中考核时间最大的 即最新数据
            }



            if(!empty($max_check_time)){
                $condition['check_time'] = array('eq',$max_check_time);
            }

            $check_warning_count = $check_warning_obj->where($condition)->count();
            $check_warning_result = $check_warning_obj->where($condition)
                                                      ->page("{$page_start},{$page_limit}")
                                                      ->select();


            $data['draw'] = intval($param['draw']);
            $data['total'] = $check_warning_count;
            $data['data'] = $check_warning_result;

            echo json_encode($data);
        }else{
            if(IS_POST){
                if(I('post.branch')) {
                    $keyword = I('post.branch');
                    $condition['org_code']  = $keyword;
                    $this->assign('serach_keyword',$keyword);
                }
            }


            $this->assign('branch_office',$this->_get_branch_code());
            $this->assign('check_time',array_column($this->_get_check_result_date(), 'check_time'));
            $this->display('business_check');
        }


    }
    /**
     * 分公司考核结果
     * @return [type] [description]
     */
    public function check_branch_result(){
        $organization_obj = M('organization');
        $check_warning_obj = M('check_warning');
        //查询机构表所有分公司
        $branch_map['level'] = array('eq',1);
        $branch_map['check_status'] = array('eq',1);
        $branch_list = $organization_obj->where($branch_map)
                                        ->field('org_code,name')
                                        ->select(); //获取机构表所有分公司
        if(IS_AJAX){


            $data_cache = S('check_bracnh_data');

            if(!$data_cache){

                $flagship_maintain = $organization_obj  ->field('branch_shop_code as org_code,COUNT(check_results) as flagship_maintain')
                                                        ->where('check_results = 0 and level = 2')
                                                        ->group('branch_shop_code')
                                                        ->select(); //获取各分公司旗舰店维持数量

                $flagship_observed = $organization_obj  ->field('branch_shop_code as org_code,COUNT(check_results) as flagship_observed')
                                                        ->where('check_results = 1 and level = 2')
                                                        ->group('branch_shop_code')
                                                        ->select(); //获取各分公司旗舰店观察数量

                $flagship_demote = $organization_obj  ->field('branch_shop_code as org_code,COUNT(check_results) as flagship_demote')
                                                        ->where('check_results = 2 and level = 2')
                                                        ->group('branch_shop_code')
                                                        ->select(); //获取各分公司旗舰店观察数量
                $shop_maintain = $organization_obj  ->field('branch_shop_code as org_code,COUNT(check_results) as shop_maintain')
                                                        ->where('check_results = 0 and level = 3')
                                                        ->group('branch_shop_code')
                                                        ->select(); //获取各分公司旗舰店维持数量

                $shop_observed = $organization_obj  ->field('branch_shop_code as org_code,COUNT(check_results) as shop_observed')
                                                        ->where('check_results = 1 and level = 3')
                                                        ->group('branch_shop_code')
                                                        ->select(); //获取各分公司旗舰店观察数量

                $shop_demote = $organization_obj  ->field('branch_shop_code as org_code,COUNT(check_results) as shop_demote')
                                                        ->where('check_results = 2 and level = 3')
                                                        ->group('branch_shop_code')
                                                        ->select(); //获取各分公司旗舰店观察数量
                //获取分公司会员达标数
                $now_month = date('n',time());  //当前月份
                //判断当前月份是上半年还是下半年
                if ($now_month>6) { //下半年
                    $standard_map['standard']  = array(array('gt',strtotime(date('Y-7-20'))),array('lt',strtotime(date('Y-12-31'))));
                    $shop_apply_map['create_apply']  = array(array('gt',strtotime(date('Y-7-20'))),array('lt',strtotime(date('Y-12-31'))));

                } elseif($now_month<=6) {   //上半年
                       $standard_map['standard']  = array(array('gt',strtotime(date('Y-1-1'))),array('lt',strtotime(date('Y-7-20'))));
                       $shop_apply_map['create_apply']  = array(array('gt',strtotime(date('Y-1-1'))),array('lt',strtotime(date('Y-7-20'))));

                }


                $member_list =  M('member_standard')->field('branch_shop_number,count(*) as standards')
                                                    ->group('branch_shop_number')
                                                    ->where($standard_map)
                                                    ->select();
                //获取会员申请数
                $shop_apply_list = M('shop_apply')->where($shop_apply_map)->group('branch_shop_number')->field('branch_shop_number,count(*) as shop_counts')->select();

                foreach ($branch_list as $key => $value) {
                    $branch_list[$key]['flagship_maintain'] = 0; //旗舰店维持
                    $branch_list[$key]['flagship_observed'] = 0; //旗舰店观察
                    $branch_list[$key]['flagship_demote']   = 0; //旗舰店降级
                    $branch_list[$key]['shop_maintain']     = 0; //标准店维持
                    $branch_list[$key]['shop_observed']     = 0; //标准店观察
                    $branch_list[$key]['shop_demote']       = 0; //标准店降级
                    $branch_list[$key]['member_standard']   = 0;    //会员达标数
                    $branch_list[$key]['member_apply']      = 0;    //会员申请数
                    $branch_list[$key]['member_apply_rate'] = 0;    //会员申请率



                    foreach ($flagship_maintain as $k => $v) {
                        if ($value["org_code"] == $v["org_code"]) {
                            $branch_list[$key]['flagship_maintain'] = $v['flagship_maintain'];
                        }
                    }
                    foreach ($flagship_observed as $v2) {
                        if($value['org_code']==$v2['org_code']){
                            $branch_list[$key]['flagship_observed'] = $v2['flagship_observed'];

                        }
                    }
                    foreach ($flagship_demote as $v6) {
                        if($value['org_code']==$v6['org_code']){
                            $branch_list[$key]['flagship_demote'] = $v6['flagship_demote'];

                        }
                    }
                    foreach ($shop_maintain as  $v3) {
                        if($value['org_code']==$v3['org_code']){
                            $branch_list[$key]['shop_maintain'] = $v3['shop_maintain'];

                        }
                    }
                    foreach ($shop_observed as  $v4) {
                        if($value['org_code']==$v4['org_code']){
                            $branch_list[$key]['shop_observed'] = $v4['shop_observed'];

                        }
                    }
                    foreach ($shop_demote as  $v5) {
                        if($value['org_code']==$v5['org_code']){
                            $branch_list[$key]['shop_demote'] = $v5['shop_demote'];

                        }
                    }
                     foreach ($member_list as $k => $v7) {   //会员达标数
                        if ($value["org_code"] == $v7["branch_shop_number"]) {
                            $branch_list[$key]['member_standard'] = $v7['standards'];
                        }
                    }
                    foreach ($shop_apply_list as $k => $v8) {   //会员申请数
                        if ($value["org_code"] == $v8["branch_shop_number"]) {
                            $branch_list[$key]['member_apply'] = $v8['shop_counts'];
                        }
                    }
                    //会员申请率
                    if( $branch_list[$key]['member_standard']==0){
                        $branch_list[$key]['member_apply_rate'] = 0;
                    }else{
                        $branch_list[$key]['member_apply_rate'] = ($branch_list[$key]['member_apply'])/($branch_list[$key]['member_standard']);
                    }

              }
                $arr_sum['org_code'] ='合计';
                $arr_sum['name'] ='合计';
                $arr_sum['flagship_maintain'] = array_sum(array_column($branch_list, 'flagship_maintain'));
                $arr_sum['flagship_observed'] = array_sum(array_column($branch_list, 'flagship_observed'));
                $arr_sum['flagship_demote']   = array_sum(array_column($branch_list, 'flagship_demote'));
                $arr_sum['shop_maintain']     = array_sum(array_column($branch_list, 'shop_maintain'));
                $arr_sum['shop_observed']     = array_sum(array_column($branch_list, 'shop_observed'));
                $arr_sum['shop_demote']       = array_sum(array_column($branch_list, 'shop_demote'));
                $arr_sum['member_standard']   = array_sum(array_column($branch_list, 'member_standard'));
                $arr_sum['member_apply']      = array_sum(array_column($branch_list, 'shop_counts'));
                if($arr_sum['member_standard']==0) {
                    $arr_sum['member_apply_rate'] =  0;
                }else{
                    $arr_sum['member_apply_rate'] =  $arr_sum['member_apply']/$arr_sum['member_standard'];
                }

                array_push($branch_list, $arr_sum);

                S('check_bracnh_data',$branch_list,3600);

                $result = S('check_bracnh_data');

                $arr["data"]=$result;

                echo json_encode($arr);
            }else{

                $result = S('check_bracnh_data');
                $branch_code = I('param.branch');

                if($branch_code){
                    foreach ($result as $key => $value) {
                        if($value['org_code'] != $branch_code){

                            unset($result[$key]);
                        }
                    }

                    $arr["data"]=array_values($result);
                }else{

                    $arr["data"]=$result;
                }

                echo json_encode($arr);

            }

        }else{
                $this->assign('branch_list',$branch_list);
                $this->display('check_branch');
        }




    }
    protected function _array_filter_check_branch($var){
        var_dump($var);
    }
    /**
     * 分公司考核结果目标达成率
     * wzq
     * 查询保单表分公司首期保单价值保费
     * @return [type] [description]
     */
    public function _check_branch_result_aims(){

    }

    public function test(){
        $obj = D('EarlyWarning');

        var_dump(iconv('UTF-8', 'GBK', $obj->get_prepar_proceed_percent()));
    }

    public function change_check_result(){
        if(IS_AJAX){
            $org_code    = I("param.org_code");    //店铺编码
            $change_type = I("param.type"); // 操作类型 1 修改成功 2 修改失败
            if($org_code or $change_type){
                $change_check  = D('EarlyWarning');
                return $change_check->change_check_prepam_result($org_code,$change_type);
            }else{
                $data['error'] = 1;
                $data['msg'] = '缺少参数 请刷新重试';
                return json_encode($data);
            }
        }
    }
    public function change_check_business_result(){
        if(IS_AJAX){
            $org_code    = I("param.org_code");    //店铺编码
            $change_type = I("param.type"); // 操作类型 1 修改成功 2 修改失败
            if($org_code or $change_type){
                $change_check  = D('EarlyWarning');
                return $change_check->change_check_business_result($org_code,$change_type);
            }else{
                $data['error'] = 1;
                $data['msg'] = '缺少参数 请刷新重试';
                return json_encode($data);
            }
        }
    }
}

