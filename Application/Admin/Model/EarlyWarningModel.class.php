<?php
namespace Admin\Model;
use Think\Model;

class EarlyWarningModel extends Model{
    protected $tableName = 'check_warning';
    protected $member_obj = ''; //会员表
    protected $insurance_re = '';   //续期保单
    protected $renew = '';      //缴费时间表




    /**查询继续率
     * @author  iyting
     * @param  [array] $org_code       [店铺信息]
     * @param  [float] $bssessment_cri [继续率指标]
     * @return [type]                 [description]
     */
    public function get_prepar_proceed_percent($shop_info,$bssessment_cri){

        if(func_num_args()==2){

            if (!empty($shop_info['org_code'])) {
                $member_obj = M('member');
                $map['my_shop_number'] = array('eq',$shop_info['org_code']);

                $member_result = $member_obj->where($map)->getfield('register_time');

                if($member_result){
                    $start_time  = date('Y-n',time());
                    $end_time= date('Y-n',$member_result);


                    $diff_mon         = (getMonthNum($start_time,$end_time,'-'));
                    if(($diff_mon<24)){ //判断注册日期是否小于24个月
                        $data['bssessment_cri'] = $bssessment_cri; //继续率指标
                        $data['reached']        = 1.00; //为满足13个月按照百分百来算
                        $data['gap']            = 1.00-$bssessment_cri; //差距

                        //$data['bssessment_cri'] = $bssessment_cri; //继续率指标
                        return $data;
                    } else { //大于24个月

                        $now_check_re_end_time   = date('Y-n',strtotime('-15 months '));  //续期考核开始时间
                        $now_check_tr_grace_time = date('Y-n-1');   //续期考核结束时间
                        $first_check_start_time  = date('Y-n',strtotime('-24 months',strtotime($now_check_re_end_time)));   //承保开始日期
                        $first_check_end_time  = date('Y-n',strtotime('-11 months',strtotime($now_check_re_end_time))); //承保结束日期
                      /*    echo $now_check_re_end_time;
                        echo '<br/>';
                        echo $now_check_tr_grace_time;

                        echo '<br/>';

                        echo ($first_check_start_time);
                        echo '<br/>';
                           echo ($first_check_end_time);  echo '<br/>';*/

                        $condition['insurance_re.standard_shop_number'] = array('eq',$shop_info['org_code']);   //店铺代码

                            //承保日期
                        $condition['insurance_re.insured_date']         = array('between',array(strtotime($first_check_start_time),
                                                                                                strtotime($first_check_end_time)));
                        $condition['insurance_re.policy_status']        = array('eq',1);
                        $condition['insurance_re.insurance_type'] = array('eq',1);
                        $condition['renew.renew_count'] = array('eq',2);    //缴费次数
                        $condition['renew.two_time'] = array('between',array(strtotime($now_check_re_end_time),strtotime($now_check_tr_grace_time)));  //二次成功日期
                        $condition['renew.two_state'] = array('eq',1);  //二次是否成功

                        $insurance_re_obj = M('insurance_re'); //实例化续期保单表
                        $result = $insurance_re_obj->join('renew ON insurance_re.policy_number = renew.insurance_num ')
                                                   ->where($condition)
                                                   ->field('SUM(insurance_re.insurance_premium) as preminum,SUM(insurance_re.real_insurance_premium) as real_premium')
                                                   ->select();
                        if(is_null($result['real_premium'])){
                            $result['real_premiun'] = 0;
                        }
                        if(is_null($result['premium']) or $result['premium']==0){
                            return false;
                        }
                        $data['bssessment_cri'] = $bssessment_cri; //继续率指标
                        $data['reached']        = $result['real_premium']/$result['preminum']; //为满足13个月按照百分百来算
                        $data['gap']            = ($result['real_premium']/$result['preminum'])-$bssessment_cri; //差距
                        return  $data; #实收/应收=继续率


                    }
                }else{
                    return false;
                }

            } else {
                return false;
            }





        } else {
            return false;
        }


    }
    /**
     * 店铺考核结果
     * @param  [type] $shop_info [description]
     * @return [type]            [description]
     */
    public function get_check_is_success($shop_info){


        if(($shop_info['level']==3) and ($shop_info['status'] ==0)){
        //标准店筹备期
            if(($shop_info['business_gap']>=0) and ($shop_info['direct_recom_gap']>=0) and ($shop_info['continuation_rate_gap']>=0)){ //考核成功

                $organization_obj = M('organization');

                //考核成功将店铺升级到标准店经营期
                $map['org_code']      = array('eq',$shop_info['org_code']);

                $data['status']       = 1;

                $data['check_status'] = 1;
                $data['check_results'] = 0; //考核结果设置成维持
                $result = M('organization')->where($map)->save($data);
                return true;


            }else{  //考核失败

                //将会员表中所有会员店铺代码包括自己的改成 自己上一级的店铺代码

                //查询自己的推荐人店铺代码
                $recommend_member_id = M('member')->where('my_shop_number = '.$shop_info['org_code'])->getField('recommend_member_id');

                if($recommend_member_id){   //推荐人代码
                    //推荐人所属店铺
                    $recommend_member_id_shop_number = M('member')->where('m_number = '.$recommend_member_id)->getField('shop_number');

                    if($recommend_member_id_shop_number){
                        $model = new Model();
                        $model->startTrans();   //开启事务
                        $flag = false;
                        $org_data['check_status'] = 0;
                        $org_data['check_results'] = 4;
                        $maps['org_code']  = array('eq',$shop_info['org_code']);
                        $organization_obj =$model->table('organization')->where($maps)->save($org_data);

                        if($organization_obj === false) {

                            $flag = false;
                        }else {

                            $data['shop_number'] = $recommend_member_id_shop_number;
                            $result = $model->table('member')
                                            ->where('shop_number = '.$shop_info['org_code'])
                                            ->save($data); //更新会员表中所有店铺代码

                            $member_result_data['member_level'] =1;
                            $member_result = $model->table('member')
                                                    ->where('my_shop_number = '.$shop_info['org_code'])
                                                    ->save($member_result_data); //更新会员等级为资深业务经理

                            if(($result===false) or ($member_result===false)){   //判断是否更新成功
                                $flag = false;
                            }else{
                                $insurance_data['standard_shop_number'] = $recommend_member_id_shop_number;
                                $insurance_result   = $model->table('insurance')
                                                            ->where('standard_shop_number = '.$shop_info['org_code'])
                                                            ->save($insurance_data);//更新保单表中的店铺代码
                                if($insurance_result===false){

                                    $flag = false;
                                }else{
                                    $insurance_re_result = $model->table('insurance_re')
                                                                ->where('standard_shop_number = '.$shop_info['org_code'])
                                                                ->save($insurance_data);
                                    if($insurance_re_result === false){
                                        $flag = false;
                                    }else{
                                        $flag = true;
                                    }
                                }
                            }
                        }

                        if($flag){

                            $model->commit();

                        }else{
                            $model->rollback();

                        }
                    }
                }

                return false;
            }
        }elseif(($shop_info['level']==3) and ($shop_info['status']==-1) ) { //标准店观察期

            if(($shop_info['achievement_target_gap']>=0) and ($shop_info['direct_recom_people']>=0) and ($continuation_rate_gap>=0)){ //考核成功
                 $organization_obj = M('organization');
                //考核成功将店铺升级到标准店经营期
                $map['org_code'] = array('eq',$shop_info['org_code']);

                $data['status'] = 1;

                $data['check_status'] = 1;
                $data['check_results'] = 0; //考核结果设置成维持
                $result = M('organization')->where($map)->save($data);
                return true;

            }else { //标准店观察期考核失败

                //将会员表中所有会员店铺代码包括自己的改成 自己上一级的店铺代码

                //查询自己的推荐人店铺代码
                $recommend_member_id = M('member')->where('my_shop_number = '.$shop_info['org_code'])
                                                 ->getField('recommend_member_id');

                if($recommend_member_id){   //推荐人代码
                    //推荐人所属店铺
                    $recommend_member_id_shop_number = M('member')->where('m_number = '.$recommend_member_id)->getField('shop_number');

                    if($recommend_member_id_shop_number){
                        $model = new Model();
                        $model->startTrans();   //开启事务
                        $flag = false;
                        $org_data['check_status'] = 0;
                        $org_data['check_results'] = 2; //考核结果设置成降级
                        $organization_obj =$model->table('organization')->where('org_code = '.$shop_info['org_code'])->save($org_data);
                        if($organization_obj === false) {
                            $flag = false;
                        }else {
                            $data['shop_number'] = $recommend_member_id_shop_number;
                            $result = $model->table('member')->where('shop_number = '.$shop_info['org_code'])->save($data); //更新会员表中所有店铺代码
                            $member_result_data['member_level'] =1;
                            $member_result = $model->table('member')->where('my_shop_number = '.$shop_info['org_code'])->save($member_result_data); //更新会员等级为资深业务经理
                            if(($result===false) or ($member_result===false)){   //判断是否更新成功
                                $flag = false;
                            }else{
                                $insurance_data['standard_shop_number'] = $recommend_member_id_shop_number;
                                $insurance_result   = $model->table('insurance')->where('standard_shop_number = '.$shop_info['org_code'])->save($insurance_data);//更新保单表中的店铺代码
                                if($insurance_result===false){

                                    $flag = false;
                                }else{
                                    $insurance_re_result = $model->table('insurance_re')->where('standard_shop_number = '.$shop_info['org_code'])->save($insurance_data);
                                    if($insurance_re_result === false){
                                        $flag = false;
                                    }else{
                                        $flag = true;
                                    }
                                }
                            }
                        }

                        if($flag){
                            $model->commit();
                        }else{
                            $model->rollback();
                        }
                    }
                }

                return false;
            }
        }elseif(($shop_info['level']==2) and ($shop_info['status']==0)){    //旗舰店筹备期

            if(($shop_info['business_gap']>=0) and ($shop_info['direct_recom_gap']>=0) and ($shop_info['recommend_shop_rea_gap']>=0) and($shop_info['sub_people_rea_gap']>=0) and ($shop_info['continuation_rate_gap']>=0)){ //考核成功

                $organization_obj     = M('organization');
                //考核成功将店铺升级到旗舰店经营期
                $map['org_code']      = array('eq',$shop_info['org_code']);

                $data['status']       = 1;

                $data['check_status'] = 1;
                $data['check_results'] = 0; //考核结果设置成维持
                //$map['org_code'] = array('eq',$shop_info['org_code']);
                $result = M('organization')->where($map)
                                           ->save($data);
                return true;
            }else{  //旗舰店筹备期考核失败
                    //将会员表中所有会员店铺代码包括自己的改成 自己上一级的店铺代码

                //查询自己的推荐人店铺代码
                $recommend_member_id = M('member')->where('my_shop_number = '.$shop_info['org_code'])
                                                  ->getField('recommend_member_id');

                if($recommend_member_id){   //推荐人代码

                    $recommend_member_id_shop_number = M('member')->where('m_number = '.$recommend_member_id)
                                                                  ->getField('flagship_number');//查询推荐人所属旗舰店

                    if($recommend_member_id_shop_number){
                        $model = new Model();
                        $model->startTrans();   //开启事务
                        $flag = false;

                        $org_data['check_status'] = 1;
                        $org_data['status'] = 1;    //经营期
                        $org_data['level'] = 3;     //标准店等级
                        $org_data['check_results'] = 2; //考核结果筹备期没有过
                        $organization_obj =$model->table('organization')
                                                 ->where('shop_number = '.$shop_info['org_code'])
                                                 ->save($org_data); //更新机构表 将旗舰店筹备期降级为标准店经营期

                        if($organization_obj === false) {
                            $flag = false;
                        }else {

                            $data['shop_number']     = $shop_info['org_code'];
                            $data['flagship_number'] = $recommend_member_id_shop_number;    //推荐人所属旗舰店
                            $data['member_level']    = 2;   //更改会员等级为标准店店长

                            $result = $model->table('member')
                                            ->where('m_number = '.$shop_info['org_code'])
                                            ->save($data); //更新旗舰店店长的信息



                            $member_result_data['flagship_number'] = $recommend_member_id_shop_number; //推荐人所属旗舰店
                            /*****更新旗舰店下直属会员*****/
                            $member_result = $model->table('member')
                                                    ->where('shop_number = '.$shop_info['org_code'].' and flagship_number = '.$shop_info['org_code'])
                                                    ->save($member_result_data); //更新旗舰店直属会员

                            /***更新旗舰店下直属标准店***/
                            $sub_shop_change  = $model->table('member')
                                                      ->where('flagship_number = '.$shop_info['org_code'].' and shop_number != '.$shop_info['org_code'])
                                                      ->save($member_result_data); //更新原旗舰店下属标准店店员


                            if(($result === false) or ($member_result === false) or ($sub_shop_change === false)){   //判断是否更新成功
                                $flag = false;
                            }else{
                                //更新保单

                                $insurance_data['flag_shop_number'] = $recommend_member_id_shop_number;
                                $insurance_result =   $model->table('insurance')
                                                            ->where('standard_shop_number = '.$shop['org_code'].' and flag_shop_number = '.$shop_info['org_code'])
                                                            ->save($insurance_data);//更新保单表中的店铺代码

                                $insurance_change_shop = $model->table('insurance')
                                                               ->where('standard_shop_number != '.$shop['org_code'].' and flag_shop_number = '.$shop_info['org_code'])
                                                               ->save($insurance_data); //更新保单表中的下属标准店代码
                                if(($insurance_result===false) and ($insurance_change_shop===false)){

                                    $flag = false;
                                }else{  //更新续期保单

                                    $insurance_re_result = $model->table('insurance_re')
                                                                 ->where('standard_shop_number = '.$shop['org_code'].' and flag_shop_number = '.$shop_info['org_code'])
                                                                 ->save($insurance_data);   //更新保单表中的店铺代码
                                    $insurance_re_change_shop = $model->table('insurance')
                                                                       ->where('standard_shop_number != '.$shop['org_code'].' and flag_shop_number = '.$shop_info['org_code'])
                                                                       ->save($insurance_data); //更新保单表中下属标准店代码
                                    if(($insurance_re_result === false) and ($insurance_re_change_shop===false)){
                                        $flag = false;
                                    }else{
                                        $flag = true;
                                    }
                                }
                            }
                        }

                        if($flag){
                            $model->commit();
                        }else{
                            $model->rollback();
                        }
                    }else{ //推荐人没有旗舰店 查询分公司有没有其他的旗舰店
                        $branch_shop_code = $shop_info['branch_shop_code']; //分公司机构代码
                        //查询会员表查询分公司其他旗舰店
                        $branch_shop_map['branch_shop_code'] = array('eq',$branch_shop_code);
                        $branch_shop_map['member_level'] = array('eq',3);
                        $branch_shop_map['check_status'] = array('eq',1);
                        $branch_shop_map['m_number'] = array('neq',$shop_info['org_code']);
                        $bracnh_shop_oth_flagship = M('member')->where($branch_shop_map)->find();
                        if(!empty($bracnh_shop_oth_flagship['flagship_number'])){  //判断分公司是否有其他旗舰店
                            $model = new Model();
                            $model->startTrans();   //开启事务
                            $flag = false;

                            $org_data['check_status'] = 1;
                            $org_data['status'] = 1;    //经营期
                            $org_data['level'] = 3;     //标准店等级
                            $org_data['check_results'] = 2; //考核结果设置成降级
                            $organization_obj =$model->table('organization')
                                                     ->where('shop_number = '.$shop_info['org_code'])
                                                     ->save($org_data); //更新机构表 将旗舰店筹备期降级为标准店经营期
                            if ($organization_obj === false) {
                                $flag = false;

                            } else {
                                $data['shop_number']     = $shop_info['org_code'];
                                $data['flagship_number'] = $bracnh_shop_oth_flagship['flagship_number'];    //分公司其他旗舰店
                                $data['member_level']    = 2;   //更改会员等级为标准店店长

                                $result = $model->table('member')
                                                ->where('m_number = '.$shop_info['org_code'])
                                                ->save($data); //更新旗舰店店长的信息



                                $member_result_data['flagship_number'] = $bracnh_shop_oth_flagship['flagship_number']; //推荐人所属旗舰店
                                /*****更新旗舰店下直属会员*****/
                                $member_result = $model->table('member')
                                                        ->where('shop_number = '.$shop_info['org_code'].' and flagship_number = '.$shop_info['org_code'])
                                                        ->save($member_result_data); //更新旗舰店直属会员

                                /***更新旗舰店下直属标准店***/
                                $sub_shop_change  = $model->table('member')
                                                          ->where('flagship_number = '.$shop_info['org_code'].' and shop_number != '.$shop_info['org_code'])
                                                          ->save($member_result_data); //更新原旗舰店下属标准店店员
                                 if(($result === false) or ($member_result === false) or ($sub_shop_change === false)){   //判断是否更新成功
                                    $flag = false;
                                }else{
                                                    //更新保单

                                    $insurance_data['flag_shop_number'] = $bracnh_shop_oth_flagship['flagship_number'];
                                    $insurance_result =   $model->table('insurance')
                                                                ->where('standard_shop_number = '.$shop['org_code'].' and flag_shop_number = '.$shop_info['org_code'])
                                                                ->save($insurance_data);//更新保单表中的店铺代码

                                    $insurance_change_shop = $model->table('insurance')
                                                                   ->where('standard_shop_number != '.$shop['org_code'].' and flag_shop_number = '.$shop_info['org_code'])
                                                                   ->save($insurance_data); //更新保单表中的下属标准店代码
                                    if(($insurance_result===false) and ($insurance_change_shop===false)){

                                        $flag = false;
                                    }else{  //更新续期保单

                                        $insurance_re_result = $model->table('insurance_re')
                                                                     ->where('standard_shop_number = '.$shop['org_code'].' and flag_shop_number = '.$shop_info['org_code'])
                                                                     ->save($insurance_data);   //更新保单表中的店铺代码
                                        $insurance_re_change_shop = $model->table('insurance')
                                                                           ->where('standard_shop_number != '.$shop['org_code'].' and flag_shop_number = '.$shop_info['org_code'])
                                                                           ->save($insurance_data); //更新保单表中下属标准店代码
                                        if(($insurance_re_result === false) and ($insurance_re_change_shop===false)){
                                            $flag = false;
                                        }else{
                                            $flag = true;
                                        }
                                    }
                                }

                            }
                            if($flag){
                               $model->commit();
                            }else{
                                $model->rollback();
                            }

                        }else{  //如果没有则该降级旗舰店为分公司直属标准店

                            $model = new Model();
                            $model->startTrans();   //开启事务
                            $flag = false;

                            $org_data['check_status'] = 1;
                            $org_data['status'] = 1;    //经营期
                            $org_data['level'] = 3;     //标准店等级
                            $organization_obj =$model->table('organization')
                                                     ->where('shop_number = '.$shop_info['org_code'])
                                                     ->save($org_data); //更新机构表 将旗舰店筹备期降级为标准店经营期
                            if ($organization_obj === false) {
                                $flag = false;

                            } else {
                                $data['shop_number']     = $shop_info['org_code'];
                                $data['flagship_number'] = $shop_info['branch_shop_code'];    //分公司其他旗舰店
                                $data['member_level']    = 2;   //更改会员等级为标准店店长

                                $result = $model->table('member')
                                                ->where('m_number = '.$shop_info['org_code'])
                                                ->save($data); //更新旗舰店店长的信息



                                $member_result_data['flagship_number'] = $shop_info['branch_shop_code']; //推荐人所属旗舰店
                                /*****更新旗舰店下直属会员*****/
                                $member_result = $model->table('member')
                                                        ->where('shop_number = '.$shop_info['org_code'].' and flagship_number = '.$shop_info['org_code'])
                                                        ->save($member_result_data); //更新旗舰店直属会员

                                /***更新旗舰店下直属标准店***/
                                $sub_shop_change  = $model->table('member')
                                                          ->where('flagship_number = '.$shop_info['org_code'].' and shop_number != '.$shop_info['org_code'])
                                                          ->save($member_result_data); //更新原旗舰店下属标准店店员
                                 if(($result === false) or ($member_result === false) or ($sub_shop_change === false)){   //判断是否更新成功
                                    $flag = false;
                                }else{
                                                    //更新保单

                                    $insurance_data['flag_shop_number'] = $shop_info['branch_shop_code'];
                                    $insurance_result =   $model->table('insurance')
                                                                ->where('standard_shop_number = '.$shop['org_code'].' and flag_shop_number = '.$shop_info['org_code'])
                                                                ->save($insurance_data);//更新保单表中的店铺代码

                                    $insurance_change_shop = $model->table('insurance')
                                                                   ->where('standard_shop_number != '.$shop['org_code'].' and flag_shop_number = '.$shop_info['org_code'])
                                                                   ->save($insurance_data); //更新保单表中的下属标准店代码
                                    if(($insurance_result===false) and ($insurance_change_shop===false)){

                                        $flag = false;
                                    }else{  //更新续期保单

                                        $insurance_re_result = $model->table('insurance_re')
                                                                     ->where('standard_shop_number = '.$shop['org_code'].' and flag_shop_number = '.$shop_info['org_code'])
                                                                     ->save($insurance_data);   //更新保单表中的店铺代码
                                        $insurance_re_change_shop = $model->table('insurance')
                                                                           ->where('standard_shop_number != '.$shop['org_code'].' and flag_shop_number = '.$shop_info['org_code'])
                                                                           ->save($insurance_data); //更新保单表中下属标准店代码
                                        if(($insurance_re_result === false) and ($insurance_re_change_shop===false)){
                                            $flag = false;
                                        }else{
                                            $flag = true;
                                        }
                                    }
                                }

                            }
                            if($flag){
                               $model->commit();
                            }else{
                                $model->rollback();
                            }

                        }



                    }
                }


            }

        }elseif(($shop_info['level']==2) and ($shop_info['status']==-1)){ //旗舰店观察期
            if(($shop_info['business_gap']>=0) and ($shop_info['sub_people_rea_gap']>=0) and
             ($shop_info['recommend_shop_rea_gap']>=0) and($shop_info['continuation_rate_gap']>=0)){ //考核成功
                $organization_obj = M('organization');
                //考核成功将店铺升级到标准店经营期
                $map['org_code'] = array('eq',$shop_info['org_code']);

                $data['status'] = 1;

                $data['check_status'] = 1;
                $data['check_results'] = 0;
                //$map['org_code'] = array('eq',$shop_info['org_code']);
                $result = M('organization')->where($map)->save($data);
                return true;
            } else {  //旗舰店观察期考核不通过直接降级为标准店
                //将会员表中所有会员店铺代码包括自己的改成 自己上一级的店铺代码

                //查询自己的推荐人店铺代码
                $recommend_member_id = M('member')->where('my_shop_number = '.$shop_info['org_code'])
                                                  ->getField('recommend_member_id');

                if($recommend_member_id){   //推荐人代码

                    $recommend_member_id_shop_number = M('member')->where('m_number = '.$recommend_member_id)
                                                                  ->getField('flagship_number');//查询推荐人所属旗舰店

                    if($recommend_member_id_shop_number){
                        $model = new Model();
                        $model->startTrans();   //开启事务
                        $flag = false;

                        $org_data['check_status'] = 1;
                        $org_data['status'] = 1;    //经营期
                        $org_data['level'] = 3;     //标准店等级
                        $org_data['check_results'] = 2;
                        $organization_obj =$model->table('organization')
                                                 ->where('shop_number = '.$shop_info['org_code'])
                                                 ->save($org_data); //更新机构表 将旗舰店筹备期降级为标准店经营期

                        if($organization_obj === false) {
                            $flag = false;
                        }else {

                            $data['shop_number']     = $shop_info['org_code'];
                            $data['flagship_number'] = $recommend_member_id_shop_number;    //推荐人所属旗舰店
                            $data['member_level']    = 2;   //更改会员等级为标准店店长

                            $result = $model->table('member')
                                            ->where('m_number = '.$shop_info['org_code'])
                                            ->save($data); //更新旗舰店店长的信息



                            $member_result_data['flagship_number'] = $recommend_member_id_shop_number; //推荐人所属旗舰店
                            /*****更新旗舰店下直属会员*****/
                            $member_result = $model->table('member')
                                                    ->where('shop_number = '.$shop_info['org_code'].' and flagship_number = '.$shop_info['org_code'])
                                                    ->save($member_result_data); //更新旗舰店直属会员

                            /***更新旗舰店下直属标准店***/
                            $sub_shop_change  = $model->table('member')
                                                      ->where('flagship_number = '.$shop_info['org_code'].' and shop_number != '.$shop_info['org_code'])
                                                      ->save($member_result_data); //更新原旗舰店下属标准店店员


                            if(($result === false) or ($member_result === false) or ($sub_shop_change === false)){   //判断是否更新成功
                                $flag = false;
                            }else{
                                //更新保单

                                $insurance_data['flag_shop_number'] = $recommend_member_id_shop_number;
                                $insurance_result =   $model->table('insurance')
                                                            ->where('standard_shop_number = '.$shop['org_code'].' and flag_shop_number = '.$shop_info['org_code'])
                                                            ->save($insurance_data);//更新保单表中的店铺代码

                                $insurance_change_shop = $model->table('insurance')
                                                               ->where('standard_shop_number != '.$shop['org_code'].' and flag_shop_number = '.$shop_info['org_code'])
                                                               ->save($insurance_data); //更新保单表中的下属标准店代码
                                if(($insurance_result===false) and ($insurance_change_shop===false)){

                                    $flag = false;
                                }else{  //更新续期保单

                                    $insurance_re_result = $model->table('insurance_re')
                                                                 ->where('standard_shop_number = '.$shop['org_code'].' and flag_shop_number = '.$shop_info['org_code'])
                                                                 ->save($insurance_data);   //更新保单表中的店铺代码
                                    $insurance_re_change_shop = $model->table('insurance')
                                                                       ->where('standard_shop_number != '.$shop['org_code'].' and flag_shop_number = '.$shop_info['org_code'])
                                                                       ->save($insurance_data); //更新保单表中下属标准店代码
                                    if(($insurance_re_result === false) and ($insurance_re_change_shop===false)){
                                        $flag = false;
                                    }else{
                                        $flag = true;
                                    }
                                }
                            }
                        }

                        if($flag){
                            $model->commit();
                        }else{
                            $model->rollback();
                        }
                    }else{ //推荐人没有旗舰店 查询分公司有没有其他的旗舰店
                        $branch_shop_code = $shop_info['branch_shop_code']; //分公司机构代码
                        //查询会员表查询分公司其他旗舰店
                        $branch_shop_map['branch_shop_code'] = array('eq',$branch_shop_code);
                        $branch_shop_map['member_level'] = array('eq',3);
                        $branch_shop_map['check_status'] = array('eq',1);
                        $branch_shop_map['m_number'] = array('neq',$shop_info['org_code']);
                        $bracnh_shop_oth_flagship = M('member')->where($branch_shop_map)->find();
                        if(!empty($bracnh_shop_oth_flagship['flagship_number'])){  //判断分公司是否有其他旗舰店
                            $model = new Model();
                            $model->startTrans();   //开启事务
                            $flag = false;

                            $org_data['check_status'] = 1;
                            $org_data['status'] = 1;    //经营期
                            $org_data['level'] = 3;     //标准店等级
                            $organization_obj =$model->table('organization')
                                                     ->where('shop_number = '.$shop_info['org_code'])
                                                     ->save($org_data); //更新机构表 将旗舰店筹备期降级为标准店经营期
                            if ($organization_obj === false) {
                                $flag = false;

                            } else {
                                $data['shop_number']     = $shop_info['org_code'];
                                $data['flagship_number'] = $bracnh_shop_oth_flagship['flagship_number'];    //分公司其他旗舰店
                                $data['member_level']    = 2;   //更改会员等级为标准店店长

                                $result = $model->table('member')
                                                ->where('m_number = '.$shop_info['org_code'])
                                                ->save($data); //更新旗舰店店长的信息



                                $member_result_data['flagship_number'] = $bracnh_shop_oth_flagship['flagship_number']; //推荐人所属旗舰店
                                /*****更新旗舰店下直属会员*****/
                                $member_result = $model->table('member')
                                                        ->where('shop_number = '.$shop_info['org_code'].' and flagship_number = '.$shop_info['org_code'])
                                                        ->save($member_result_data); //更新旗舰店直属会员

                                /***更新旗舰店下直属标准店***/
                                $sub_shop_change  = $model->table('member')
                                                          ->where('flagship_number = '.$shop_info['org_code'].' and shop_number != '.$shop_info['org_code'])
                                                          ->save($member_result_data); //更新原旗舰店下属标准店店员
                                 if(($result === false) or ($member_result === false) or ($sub_shop_change === false)){   //判断是否更新成功
                                    $flag = false;
                                }else{
                                                    //更新保单

                                    $insurance_data['flag_shop_number'] = $bracnh_shop_oth_flagship['flagship_number'];
                                    $insurance_result =   $model->table('insurance')
                                                                ->where('standard_shop_number = '.$shop['org_code'].' and flag_shop_number = '.$shop_info['org_code'])
                                                                ->save($insurance_data);//更新保单表中的店铺代码

                                    $insurance_change_shop = $model->table('insurance')
                                                                   ->where('standard_shop_number != '.$shop['org_code'].' and flag_shop_number = '.$shop_info['org_code'])
                                                                   ->save($insurance_data); //更新保单表中的下属标准店代码
                                    if(($insurance_result===false) and ($insurance_change_shop===false)){

                                        $flag = false;
                                    }else{  //更新续期保单

                                        $insurance_re_result = $model->table('insurance_re')
                                                                     ->where('standard_shop_number = '.$shop['org_code'].' and flag_shop_number = '.$shop_info['org_code'])
                                                                     ->save($insurance_data);   //更新保单表中的店铺代码
                                        $insurance_re_change_shop = $model->table('insurance')
                                                                           ->where('standard_shop_number != '.$shop['org_code'].' and flag_shop_number = '.$shop_info['org_code'])
                                                                           ->save($insurance_data); //更新保单表中下属标准店代码
                                        if(($insurance_re_result === false) and ($insurance_re_change_shop===false)){
                                            $flag = false;
                                        }else{
                                            $flag = true;
                                        }
                                    }
                                }

                            }
                            if($flag){
                               $model->commit();
                            }else{
                                $model->rollback();
                            }

                        }else{  //如果没有则该降级旗舰店为分公司直属标准店

                            $model = new Model();
                            $model->startTrans();   //开启事务
                            $flag = false;

                            $org_data['check_status'] = 1;
                            $org_data['status'] = 1;    //经营期
                            $org_data['level'] = 3;     //标准店等级
                            $organization_obj =$model->table('organization')
                                                     ->where('shop_number = '.$shop_info['org_code'])
                                                     ->save($org_data); //更新机构表 将旗舰店筹备期降级为标准店经营期
                            if ($organization_obj === false) {
                                $flag = false;

                            } else {
                                $data['shop_number']     = $shop_info['org_code'];
                                $data['flagship_number'] = $shop_info['branch_shop_code'];    //分公司其他旗舰店
                                $data['member_level']    = 2;   //更改会员等级为标准店店长

                                $result = $model->table('member')
                                                ->where('m_number = '.$shop_info['org_code'])
                                                ->save($data); //更新旗舰店店长的信息



                                $member_result_data['flagship_number'] = $shop_info['branch_shop_code']; //推荐人所属旗舰店
                                /*****更新旗舰店下直属会员*****/
                                $member_result = $model->table('member')
                                                        ->where('shop_number = '.$shop_info['org_code'].' and flagship_number = '.$shop_info['org_code'])
                                                        ->save($member_result_data); //更新旗舰店直属会员

                                /***更新旗舰店下直属标准店***/
                                $sub_shop_change  = $model->table('member')
                                                          ->where('flagship_number = '.$shop_info['org_code'].' and shop_number != '.$shop_info['org_code'])
                                                          ->save($member_result_data); //更新原旗舰店下属标准店店员
                                 if(($result === false) or ($member_result === false) or ($sub_shop_change === false)){   //判断是否更新成功
                                    $flag = false;
                                }else{
                                                    //更新保单

                                    $insurance_data['flag_shop_number'] = $shop_info['branch_shop_code'];
                                    $insurance_result =   $model->table('insurance')
                                                                ->where('standard_shop_number = '.$shop['org_code'].' and flag_shop_number = '.$shop_info['org_code'])
                                                                ->save($insurance_data);//更新保单表中的店铺代码

                                    $insurance_change_shop = $model->table('insurance')
                                                                   ->where('standard_shop_number != '.$shop['org_code'].' and flag_shop_number = '.$shop_info['org_code'])
                                                                   ->save($insurance_data); //更新保单表中的下属标准店代码
                                    if(($insurance_result===false) and ($insurance_change_shop===false)){

                                        $flag = false;
                                    }else{  //更新续期保单

                                        $insurance_re_result = $model->table('insurance_re')
                                                                     ->where('standard_shop_number = '.$shop['org_code'].' and flag_shop_number = '.$shop_info['org_code'])
                                                                     ->save($insurance_data);   //更新保单表中的店铺代码
                                        $insurance_re_change_shop = $model->table('insurance')
                                                                           ->where('standard_shop_number != '.$shop['org_code'].' and flag_shop_number = '.$shop_info['org_code'])
                                                                           ->save($insurance_data); //更新保单表中下属标准店代码
                                        if(($insurance_re_result === false) and ($insurance_re_change_shop===false)){
                                            $flag = false;
                                        }else{
                                            $flag = true;
                                        }
                                    }
                                }

                            }
                            if($flag){
                               $model->commit();
                            }else{
                                $model->rollback();
                            }

                        }



                    }
                }
            }
        }elseif(($shop_info['level']==3) and ($shop_info['status']==1)){    //标准店经营期
                  //标准店经营期
            if(($shop_info['business_gap']>=0) and ($shop_info['direct_recom_gap']>=0) and ($shop_info['continuation_rate_gap']>=0)){ //考核成功
                //将机构表中店铺状态设置为观察期
                $condition['org_code'] = array('eq',$shop_info['org_code']);
                $data['status'] = -1;
                $data['check_results'] = 0;
                $result = M('organization')->where($condition)->save($data);
                return true;


            }else{  //考核失败 降级为观察期

                //将机构表中店铺状态设置为观察期
                $condition['org_code'] = array('eq',$shop_info['org_code']);
                $data['status'] = -1;
                $data['check_results'] = 1;
                $result = M('organization')->where($condition)->save($data);
                return false;
            }
        }elseif(($shop_info['level']==2) and ($shop_info['status']==1)){    //旗舰店经营期
            if(($shop_info['business_gap']>=0) and ($shop_info['sub_people_rea_gap']>=0) and
             ($shop_info['recommend_shop_rea_gap']>=0) and($shop_info['continuation_rate_gap']>=0)){ //考核成功

                $condition['org_code'] = array('eq',$shop_info['org_code']);
                $data['status'] = -1;
                $data['check_results'] = 0;
                $result = M('organization')->where($condition)->save($data);
                return true;


            } else {  //考核失败 降级为观察期

                //将机构表中店铺状态设置为观察期
                $condition['org_code'] = array('eq',$shop_info['org_code']);
                $data['status'] = -1;
                $data['check_results'] = 1;
                $result = M('organization')->where($condition)->save($data);

                return false;
            }
        }

    }

    /**
     *  修改筹备期考核结果
     * @param  [type] $org_code    [店铺编码]
     * @param  [type] $change_type [修改类型 1:成功 2:修改失败]
     * @return [type]              [description]
     */
    public function change_check_prepam_result($warning_obj_id,$change_type){

        if(func_num_args()==2){

            $condition['id'] = array('eq',$warning_obj_id);

            $shop_result     = M('check_warning')->where($condition)->find();

            if(!empty($shop_result)){

                if($change_type==1){    //成功操作
                    if($shop_result['check_status']==1){
                        $data['error'] = 1;
                        $data['msg']   = '请勿重复操作!';
                        echo json_encode($data);
                    } else {


                        if(($shop_result['shop_type'] == 3) and ($shop_result['shop_stage']==0) ){  //判断操作对象是否标准店筹备期
                                $model = new Model();
                                $model->startTrans();   //开启事务
                                $flag = false;
                                //更新机构表
                                $shop_condition['org_code']  = array('eq',$shop_result['shop_number']);
                                $org_data['status']            = 1;
                                $org_data['check_status']   = 1;
                                $org_data['check_results']   = 0;

                                $organization_obj =$model->table('organization')
                                                         ->where($shop_condition)
                                                         ->save($org_data); //更新机构表
                                if($organization_obj===false){
                                    $flag = false;
                                } else {

                                    //更新会员表
                                    $member_cond['m_number'] = array('eq',$shop_result['shop_number']);

                                    $member_data['shop_number'] = $shop_result['shop_number'];  //所属标准店代码
                                    $member_data['member_level'] = 2;

                                    $member_obj = $model ->table('member') -> where($member_cond) ->save($member_data);

                                    //更新会员表中推荐人是该店长的会员  会员所属标准店铺改为该会员
                                    $member_other_cond['member_level'] = array('in',array(1,0));    //去除已经是店长的会员
                                    $member_other_cond['recommend_member_id'] = array('eq',$shop_result['shop_number']); //推荐人是该店长

                                    $member_other_data['shop_number'] = $shop_result['shop_number'];
                                    $member_other_obj = $model->table('member')
                                                                ->where($member_other_cond)
                                                                ->getField('m_number',true);
                                    if($member_other_obj>1){
                                        //更新推荐人为自己的会员店铺代码为改操作店铺
                                        $update_member_other_cond['shop_number'] = array('in',$member_other_obj);
                                        $update_member_other = $model->table('member')
                                                                     ->where($update_member_other_cond)
                                                                     ->save($member_other_data);
                                    }

                                    if(($member_obj===false) and($member_other_obj===false)){
                                        $flag = false;
                                    }else{
                                        //更新表单表
                                        $insurance_condition['salesman_number'] = array('in',$member_other_obj);
                                        $insurance_data['standard_shop_number'] = $shop_result['shop_number'];
                                        $change_insurance_shop_number = $model->table('insurance')
                                                                                ->where($insurance_condition)
                                                                                ->save($insurance_data);

                                        if($change_insurance_shop_number===false){
                                            $flag = false;
                                        }else{

                                            //更新续期保单表
                                            $change_insurance_re_shop_number = $model->table('insurance_re')
                                                                                     ->where($insurance_condition)
                                                                                     ->save($insurance_data);
                                            if($change_insurance_re_shop_number===false){
                                                $flag = false;
                                            }else{  //更新考核预警表
                                                $change_check_condition['id'] = array('eq',$shop_result['id']);
                                                $change_check_data['check_status'] = 1;
                                                $change_check_waring_obj = $model->table('check_warning')
                                                                                ->where($change_check_condition)
                                                                                ->save($change_check_data);
                                                if($change_check_waring_obj===false){
                                                    $flag = false;
                                                }else{
                                                    $flag = true;
                                                }
                                            }
                                        }


                                    }


                                }
                                if($flag){
                                    $model->commit();
                                    $data['error'] = '0';
                                    $data['msg'] ='操作成功';
                                    echo json_encode($data);
                                }else{
                                    $model->rollback();
                                    $data['error'] = '1';
                                    $data['msg'] ='操作失败 请刷新重试!';
                                    echo json_encode($data);

                                }

                        }else { //旗舰店筹备期  将失败改为成功状态
                            $model = new Model();
                            $model->startTrans();   //开启事务
                            $flag = false;
                            //更新会员表修改自己的所属旗舰店
                            $member_data['flagship_number'] = $shop_result['shop_number'];
                            $change_member_own = $model->table('member')->where('m_number = '.$shop_result['shop_number'])
                                                                        ->save($member_data);
                            //更新会员中自己店铺所属会员的旗舰店
                             $map['shop_number'] = array('eq',$shop_result['shop_number']);
                             $map['member_level'] = array('in',array(0,1));


                             $change_member_own_shop_memb = $model->table('member')->where($map)->save($member_data);
                             if(($change_member_own===false) and($change_member_own_shop_memb===false)){
                                $flag = false;
                             }else{
                                  //查询会员表 将推荐人是该店长的店长店铺查询出来
                                $member_map['recommend_member_id'] = array('eq',$shop_result['shop_number']);//推荐人
                                $member_map['member_level'] = array('eq',2);    //会员等级为 标准店店长

                                $member_result = M('member')->where($member_map)->getField('my_shop_number',true);
                                if(count($member_result)){

                                    $change_member_shop_cond['my_shop_number'] = array('in',$member_result);
                                    $change_member_shop_cond['recommend_member_id'] = array('in',$member_result);
                                    $change_member_shop_cond['_logic'] = 'OR';

                                    $change_member_shop_obj = $model->table('member')->where($change_member_shop_cond)->save($member_data);

                                }
                                if($change_member_shop_obj===false){
                                    $flag = false;
                                }else{
                                    //更改机构表 将店铺升级到旗舰店店
                                    $organization_map['org_code'] = array('eq',$shop_result['shop_number']);

                                    $change_organization_data['level'] = 2;
                                    $change_organization_data['status'] = 1;
                                    $change_organization_data['check_results'] = 0;
                                    $change_organization_data['flagship_code'] = $shop_result['shop_number'];
                                    $change_organization_obj = $model->table('organization')
                                                                    ->where($organization_map)
                                                                    ->save($change_organization_data);
                                    if($change_organization_obj===false){

                                        $flag = false;
                                    }else{
                                        if(count($member_result)){
                                            //更改机构表下属标准店
                                            $organization_shop_map['org_code'] = array('in',$member_result);
                                            $change_organization_shop_data['flagship_code'] = $shop_result['shop_number'];
                                            $change_organization_shop_obj = $model->table('organization')
                                                                                  ->where($organization_shop_map)
                                                                                  ->save($change_organization_shop_data);
                                        }
                                        if($change_organization_shop_data===false){
                                            $flag = false;
                                        }else{
                                            //更新保单
                                            $insurance_condition['standard_shop_number'] =array('eq',$shop_result['shop_number']);
                                            $insurance_data['flag_shop_number'] = $shop_result['shop_number'];

                                            $change_insurance_obj = $model->table('insurance')
                                                                        ->where($insurance_condition)
                                                                        ->save($insurance_data);
                                             if(count($member_result)){
                                                //更改机构表下属标准店
                                                $insurance_shop_condition['standard_shop_number'] = array('in',$member_result);

                                                $change_insurance_shop_obj = $model->table('insurance')
                                                                                  ->where($insurance_shop_condition)
                                                                                  ->save($insurance_data);
                                            }


                                            if(($change_insurance_obj===false) and ($change_insurance_shop_obj===false)){
                                                $flag = false;
                                            }else{
                                                //更新续期保单表
                                                $insurance_condition['standard_shop_number'] =array('eq',$shop_result['shop_number']);
                                                $insurance_data['flag_shop_number'] = $shop_result['shop_number'];

                                                $change_insurance_re_obj = $model->table('insurance_re')
                                                                        ->where($insurance_condition)
                                                                        ->save($insurance_data);
                                                 if(count($member_result)){
                                                //更改机构表下属标准店
                                                    $insurance_shop_condition['standard_shop_number'] = array('in',$member_result);

                                                    $change_insurance_re_shop_obj = $model->table('insurance_re')
                                                                                        ->where($insurance_shop_condition)
                                                                                        ->save($insurance_data);

                                                }
                                                if(($change_insurance_re_obj===false) and ($change_insurance_re_shop_obj===false)){
                                                    $flag = false;
                                                }else{
                                                    //更新考核预警表
                                                    $change_check_condition['id'] = array('eq',$shop_result['id']);
                                                    $change_check_data['check_status'] = 1;
                                                    $change_check_waring_obj = $model->table('check_warning')
                                                                                 ->where($change_check_condition)
                                                                                 ->save($change_check_data);
                                                    if($change_check_waring_obj===false){
                                                        $flag = false;
                                                    }else{
                                                        $flag = true;
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                             }
                        }
                        if($flag){
                            $model->commit();
                            $data['error'] = '0';
                            $data['msg'] ='操作成功';
                            echo json_encode($data);
                        }else{
                            $model->rollback();
                            $data['error'] = '1';
                            $data['msg'] ='操作失败 请刷新重试!';
                            echo json_encode($data);

                        }
                    }

                } elseif($change_type==2) { //将考核结果从成功设置为失败

                    if($shop_result['check_status']==0){
                        $data['error'] = 1;
                        $data['msg']   = '请勿重复操作!';
                        echo json_encode($data);
                    }else{

                        if(($shop_result['shop_type'] == 3) and ($shop_result['shop_stage']==0) ){  //判断操作对象是否标准店筹备期

                                $model = new Model();
                                $model->startTrans();   //开启事务
                                $flag = false;
                                //更新机构表
                                $shop_condition['org_code'] = array('eq',$shop_result['shop_number']);
                                $org_data['status']         = 1;
                                $org_data['check_status']   = 0;
                                $org_data['check_results']   = 2;

                                $organization_obj =$model->table('organization')
                                                         ->where($shop_condition)
                                                         ->save($org_data); //更新机构表
                                if($organization_obj===false){
                                    $flag = false;
                                } else {

                                    //更新会员表 查询自己推荐人的所属标准店更新为自己的所属标准店
                                    $recommended_person_shop_cond['m_number'] = array('eq',$shop_result['recommend_member_id']);
                                    $recommended_shop = $model->table('member')
                                                              ->where($recommended_person_shop_cond)
                                                              ->find();

                                    $member_cond['m_number'] = array('eq',$shop_result['shop_number']);

                                    $member_data['shop_number'] =  $recommended_shop['shop_number'];  //所属标准店代码
                                    $member_data['member_level'] = 1;

                                    $member_obj = $model ->table('member') -> where($member_cond) ->save($member_data);

                                    //更新会员表中推荐人是该店长的会员  会员所属标准店铺改为该会员
                                    $member_other_cond['member_level'] = array('in',array(1,0));    //去除已经是店长的会员
                                    $member_other_cond['recommend_member_id'] = array('eq',$shop_result['shop_number']); //推荐人是该店长

                                    $member_other_data['shop_number'] = $recommended_shop['shop_number'];
                                    $member_other_obj = $model->table('member')
                                                                ->where($member_other_cond)
                                                                ->getField('m_number',true);
                                    if($member_other_obj>1){
                                        //更新推荐人为自己的会员店铺代码为该操作店铺
                                        $update_member_other_cond['shop_number'] = array('in',$member_other_obj);
                                        $update_member_other = $model->table('member')
                                                                     ->where($update_member_other_cond)
                                                                     ->save($member_other_data);
                                    }

                                    if(($member_obj===false) and($member_other_obj===false)){
                                        $flag = false;
                                    }else{
                                        //更新表单表
                                        $insurance_condition['salesman_number'] = array('in',$member_other_obj);
                                        $insurance_data['standard_shop_number'] =$recommended_shop['shop_number'];
                                        $change_insurance_shop_number = $model->table('insurance')
                                                                                ->where($insurance_condition)
                                                                                ->save($insurance_data);

                                        if($change_insurance_shop_number===false){
                                            $flag = false;
                                        }else{

                                            //更新续期保单表
                                            $change_insurance_re_shop_number = $model->table('insurance_re')
                                                                                     ->where($insurance_condition)
                                                                                     ->save($insurance_data);
                                            if($change_insurance_re_shop_number===false){
                                                $flag = false;
                                            }else{  //更新考核预警表
                                                $change_check_condition['id'] = array('eq',$shop_result['id']);
                                                $change_check_data['check_status'] = 0;
                                                $change_check_waring_obj = $model->table('check_warning')
                                                                                ->where($change_check_condition)
                                                                                ->save($change_check_data);
                                                if($change_check_waring_obj===false){
                                                    $flag = false;
                                                }else{
                                                    $flag = true;
                                                }
                                            }
                                        }


                                    }


                                }
                                if($flag){
                                    $model->commit();
                                    $data['error'] = '0';
                                    $data['msg'] ='操作成功';
                                    echo json_encode($data);
                                }else{
                                    $model->rollback();
                                    $data['error'] = '1';
                                    $data['msg'] ='操作失败 请刷新重试!';
                                    echo json_encode($data);

                                }

                        } else {

                             //更新查询自己推荐人的所属旗舰店更新为自己的所属旗舰店店
                                $flagship_number_cond['m_number'] = array('eq',$shop_result['recommend_member_id']);
                                $flagship_number_result = M('member')->where($recommended_person_shop_cond)->find();
                                if(!empty($flagship_number_result['flagship_number'])){  //判断所属推荐人旗舰店是否为空
                                    $flagship_number_data = $flagship_number_result['flagship_number'];
                                }else{  //如果推荐人旗舰店为空 就将旗舰店代码 设置为分公司直属
                                    $flagship_number_data = $shop_result['branch_shop_number'];
                                }

                            //旗舰店筹备期
                                $model = new Model();
                                $model->startTrans();   //开启事务
                                $flag = false;


                                //更新机构表
                                $shop_condition['org_code'] = array('eq',$shop_result['shop_number']);
                                $org_data['status']       = 1;
                                $org_data['check_status'] = 1;
                                $org_data['check_results'] = 2;
                                $org_data['level']        = 3;      //等级降级为标准店
                                $org_data['flagship_code']  = $flagship_number_data;

                                $organization_obj =$model->table('organization')
                                                         ->where($shop_condition)
                                                         ->save($org_data); //更新机构表
                                if($organization_obj===false){
                                    $flag = false;
                                } else {


                                    //更新会员表将自己的所属旗舰店改为推荐人所属的旗舰店
                                    $member_cond['m_number']        = array('eq',$shop_result['shop_number']);

                                    $member_data['shop_number']     =  $shop_result['shop_number'];  //所属标准店代码
                                    $member_data['member_level']    = 1;
                                    $member_data['flagship_number'] = $flagship_number_data;

                                    $member_obj = $model ->table('member') -> where($member_cond) ->save($member_data);

                                    //更新会员表中原旗舰店下属标准店的所属旗舰店为推荐人旗舰店
                                    $member_other_cond['flagship_number'] = array('eq',$shop_result['shop_number']);
                                    //$member_other_cond['recommend_member_id'] = array('eq',$shop_result['shop_number']); //推荐人是该店长

                                    $member_other_data['flagship_number'] = $flagship_number_data;
                                    $member_other_obj = $model  ->table('member')
                                                                ->where($member_other_cond)
                                                                ->getField('m_number',true);
                                    if($member_other_obj>1){

                                        $update_member_other_cond['shop_number'] = array('in',$member_other_obj);
                                        $update_member_other = $model->table('member')
                                                                     ->where($update_member_other_cond)
                                                                     ->save($member_other_data);
                                    }

                                    if(($member_obj===false) and($update_member_other===false)){
                                        $flag = false;
                                    }else{
                                        //更新旗舰店自己的保单
                                        $own_insurance_map['standard_shop_number'] = array('eq',$shop_result['shop_number']);
                                        $own_insurance_map['flag_shop_number'] = array('eq',$shop_result['shop_number']);
                                        $own_insurance_data['flag_shop_number'] = $flagship_number_data;
                                        $change_own_insurance = $model->table('insurance')
                                                                       ->where($own_insurance_map)
                                                                       ->save($own_insurance_data);

                                        /*****************************************************************/
                                        if($member_other_obj>1){
                                            //更新表单表
                                            $insurance_condition['salesman_number'] = array('in',$member_other_obj);
                                            $insurance_data['flag_shop_number']     = $flagship_number_data;
                                            $change_insurance_shop_number           = $model->table('insurance')
                                                                                            ->where($insurance_condition)
                                                                                            ->save($insurance_data);
                                        }


                                        if(($change_insurance_shop_number===false) and ($change_own_insurance === false)){
                                            $flag = false;
                                        }else{
                                            if($member_other_obj>1){
                                                //更新续期保单表
                                                $change_insurance_re_shop_number = $model->table('insurance_re')
                                                                                     ->where($insurance_condition)
                                                                                     ->save($insurance_data);
                                              }
                                             //更新自己续期保单表
                                            $change_own_insurance_re = $model->table('insurance_re')
                                                                       ->where($own_insurance_map)
                                                                       ->save($own_insurance_data);

                                            if(($change_insurance_re_shop_number===false) and ($change_own_insurance_re===false)){
                                                $flag = false;
                                            }else{  //更新考核预警表
                                                $change_check_condition['id'] = array('eq',$shop_result['id']);
                                                $change_check_data['check_status'] = 0;
                                                $change_check_waring_obj = $model->table('check_warning')
                                                                                 ->where($change_check_condition)
                                                                                 ->save($change_check_data);
                                                if($change_check_waring_obj===false){
                                                    $flag = false;
                                                }else{
                                                    $flag = true;
                                                }
                                            }
                                        }


                                    }


                                }
                                if($flag){
                                    $model->commit();
                                    $data['error'] = '0';
                                    $data['msg']   ='操作成功';
                                    echo json_encode($data);
                                }else{
                                    $model->rollback();
                                    $data['error'] = '1';
                                    $data['msg']   ='操作失败 请刷新重试!';
                                    echo json_encode($data);

                                }
                        }
                    }
                }



            } else {
                $data['error'] = 1;
                $data['msg']   = '记录不存在 请刷新重试!';
                echo json_encode($data);
            }

        }else{
            $data['error'] = 1;
            $data['msg']   = '参数不正确 请刷新重试!';
            echo json_encode($data);
        }
    }
        /**
     *  修改经营期考核结果
     * @param  [type] $org_code    [店铺编码]
     * @param  [type] $change_type [修改类型 1:成功 2:修改失败]
     * @return [type]              [description]
     */
    public function change_check_business_result($warning_obj_id,$change_type){

        if(func_num_args()==2){

            $condition['id'] = array('eq',$warning_obj_id);

            $shop_result     = M('check_warning')->where($condition)->find();

            if(!empty($shop_result)){

                if($change_type==1){    //成功操作
                    if($shop_result['check_status']==1){
                        $data['error'] = 1;
                        $data['msg']   = '请勿重复操作!';
                        echo json_encode($data);
                    } else {

                        $model = new Model();
                        $model->startTrans();   //开启事务
                        $flag = false;
                        if(($shop_result['shop_type']==3) and ($shop_result['shop_stage']==1)){ //标准店经营期

                            //将标准店从观察期手动设置为经营期
                            //查询机构表 将该店铺设置为经营期
                            $organization_map['org_code'] = array('eq',$shop_result['shop_number']);
                            $organization_data['status']  = 1;
                            $organization_data['check_results']  = 0;
                            $organization_obj = $model ->table('organization')
                                                        ->where($organization_map)
                                                        ->save($organization_data);

                            //更新考核结果表
                            $change_check_warning_map['id'] = array('eq',$warning_obj_id);
                            $change_check_warning_data['check_status'] = 1;
                            $change_check_warning_obj = $model  ->table('check_warning')
                                                                ->where($change_check_warning_map)
                                                                ->save($change_check_warning_data);

                            if(($organization_obj===false) and ($change_check_warning_obj===false)){
                                $flag = false;
                            }else {
                                $flag = true;
                            }


                        }elseif (($shop_result['shop_type']==3) and ($shop_result['shop_stage']==-1)) { //标准店观察期
                            //更新会员表 将该会员手动设置为店长
                            $member_map['m_number']      = array('eq',$shop_result['shop_number']);
                            $member_data['shop_number']  = $shop_result['shop_number'];
                            $member_data['member_level'] = 2;   //会员等级

                            $member_obj  = $model->table('member')->where($member_map)->save($member_data); //更新会员自己的信息
                            //更新店长下属会员信息

                            if($member_obj===false){
                                $flag = false;

                            }else {
                                  //查询会员是该店长的会员并且会员等级不是店长
                                $member_other_map['recommend_member_id'] = array('eq',$shop_result['shop_number']);
                                $member_other_map['member_level']        = array('in',array(0,1));
                                $member_other_data['shop_number']        = $shop_result['shop_number'];
                                $member_other_obj = $model->table('member')->where($member_other_map)->getField('m_number',true);
                                if(count($member_other_obj)){
                                    //更新会员表信息 将原店长下属会员更改回来
                                    $change_member_map['m_number'] = array('in',$member_other_obj);
                                    $change_other_obj = $model->table('member')
                                                              ->where($change_member_map)
                                                              ->save($member_other_data);
                                }

                                if($member_other_obj === false){
                                    $flag = false;
                                }else{
                                    //更改机构表
                                    $organization_map['org_code']      = array('eq',$shop_result['shop_number']);
                                    $organization_data['status']       = 1;
                                    $organization_data['check_status'] = 1;
                                    $organization_data['level']        = 3;
                                    $organization_data['check_results']  = 0;
                                    $organization_obj = $model->table('organization')
                                                              ->where($organization_map['org_code'])
                                                              ->save($organization_data);
                                    if($organization_obj===false){
                                        $flag = false;
                                    } else {
                                        //更改表单表
                                        $insurance_cond['salesman_number'] = array('eq',$shop_result['shop_number']);
                                        $insurance_data['standard_shop_number'] = $shop_result['shop_number'];
                                        $insurance_obj = $model->table('insurance')->where($insurance_cond)->save($insurance_data);
                                        $insurance_re_obj = $model->table('insurance_re')->where($insurance_cond)->save($insurance_data);
                                        if(($insurance_obj===false) and ($insurance_re_obj===false) ){
                                            $flag = false;
                                        }else{

                                             if(count($member_other_obj)){
                                                $insurance_other_cond['salesman_number'] = array('in',$member_other_obj);
                                                $insurance_other_obj = $model->table('insurance')
                                                                             ->where($insurance_other_cond)
                                                                             ->save($insurance_data);

                                                $insurance_other_re_obj = $model->table('insurance_re')
                                                                                ->where($insurance_other_cond)
                                                                                ->save($insurance_data);
                                                if(($insurance_other_obj===false) and ($insurance_other_re_obj===false)){
                                                    $flag = false;
                                                }else {
                                                    $flag = true;
                                                }
                                             } else {
                                                $flag = true;
                                             }
                                        }
                                    }
                                }

                            }


                        }elseif(($shop_result['shop_type']==2) and ($shop_result['shop_stage']==-1)) {    //旗舰店观察期


                            //更新会员表修改自己的所属旗舰店
                            $member_data['flagship_number'] = $shop_result['shop_number'];
                            $change_member_own = $model->table('member')->where('m_number = '.$shop_result['shop_number'])
                                                                        ->save($member_data);
                            //更新会员中自己店铺所属会员的旗舰店
                             $map['shop_number'] = array('eq',$shop_result['shop_number']);
                             $map['member_level'] = array('in',array(0,1));


                             $change_member_own_shop_memb = $model->table('member')->where($map)->save($member_data);
                             if(($change_member_own===false) and($change_member_own_shop_memb===false)){
                                $flag = false;
                             }else{
                                  //查询会员表 将推荐人是该店长的店长店铺查询出来
                                $member_map['recommend_member_id'] = array('eq',$shop_result['shop_number']);//推荐人
                                $member_map['member_level'] = array('eq',2);    //会员等级为 标准店店长

                                $member_result = M('member')->where($member_map)->getField('my_shop_number',true);
                                if(count($member_result)){

                                    $change_member_shop_cond['my_shop_number'] = array('in',$member_result);
                                    $change_member_shop_cond['recommend_member_id'] = array('in',$member_result);
                                    $change_member_shop_cond['_logic'] = 'OR';

                                    $change_member_shop_obj = $model->table('member')-where($change_member_shop_cond)->save($member_data);

                                }
                                if($change_member_shop_obj===false){
                                    $flag = false;
                                }else{
                                    //更改机构表 将店铺升级到期间店
                                    $organization_map['org_code'] = array('eq',$shop_result['shop_number']);

                                    $change_organization_data['level'] = 2;
                                    $change_organization_data['status'] = 1;
                                    $change_organization_data['flagship_code'] = $shop_result['shop_number'];
                                    $organization_data['check_results']  = 0;
                                    $change_organization_obj = $model->table('organization')
                                                                    ->where($organization_map)
                                                                    ->save($change_organization_data);
                                    if($change_organization_obj===false){

                                        $flag = false;
                                    }else{
                                        if(count($member_result)){
                                            //更改机构表下属标准店
                                            $organization_shop_map['org_code'] = array('in',$member_result);
                                            $change_organization_shop_data['flagship_code'] = $shop_result['shop_number'];
                                            $change_organization_shop_obj = $model->table('organization')
                                                                                  ->where($organization_shop_map)
                                                                                  ->save($change_organization_shop_data);
                                        }
                                        if($change_organization_shop_data===false){
                                            $flag = false;
                                        }else{
                                            //更新保单
                                            $insurance_condition['standard_shop_number'] =array('eq',$shop_result['shop_number']);
                                            $insurance_data['flag_shop_number'] = $shop_result['shop_number'];

                                            $change_insurance_obj = $model->table('insurance')
                                                                        ->where($insurance_condition)
                                                                        ->save($insurance_data);
                                             if(count($member_result)){
                                                //更改机构表下属标准店
                                                $insurance_shop_condition['standard_shop_number'] = array('in',$member_result);

                                                $change_insurance_shop_obj = $model->table('insurance')
                                                                                  ->where($insurance_shop_condition)
                                                                                  ->save($insurance_data);
                                            }


                                            if(($change_insurance_obj===false) and ($change_insurance_shop_obj===false)){
                                                $flag = false;
                                            }else{
                                                //更新续期保单表
                                                $insurance_condition['standard_shop_number'] =array('eq',$shop_result['shop_number']);
                                                $insurance_data['flag_shop_number'] = $shop_result['shop_number'];

                                                $change_insurance_re_obj = $model->table('insurance_re')
                                                                        ->where($insurance_condition)
                                                                        ->save($insurance_data);
                                                 if(count($member_result)){
                                                //更改机构表下属标准店
                                                    $insurance_shop_condition['standard_shop_number'] = array('in',$member_result);

                                                    $change_insurance_re_shop_obj = $model->table('insurance_re')
                                                                                        ->where($insurance_shop_condition)
                                                                                        ->save($insurance_data);

                                                }
                                                if(($change_insurance_re_obj===false) and ($change_insurance_re_shop_obj===false)){
                                                    $flag = false;
                                                }else{
                                                    //更新考核预警表
                                                    $change_check_condition['id'] = array('eq',$shop_result['id']);
                                                    $change_check_data['check_status'] = 1;
                                                    $change_check_waring_obj = $model->table('check_warning')
                                                                                 ->where($change_check_condition)
                                                                                 ->save($change_check_data);
                                                    if($change_check_waring_obj===false){
                                                        $flag = false;
                                                    }else{
                                                        $flag = true;
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                             }

                        }elseif(($shop_result['shop_type']==2) and ($shop_result['shop_stage']==1)){  //旗舰店经营期


                            //将旗舰店从观察期手动设置为经营期
                            //查询机构表 将该店铺设置为经营期
                            $organization_map['org_code'] = array('eq',$shop_result['shop_number']);
                            $organization_data['status']  = 1;
                            $organization_data['check_results']  = 0;
                            $organization_obj = $model  ->table('organization')
                                                        ->where($organization_map)
                                                        ->save($organization_data);


                            //更新考核结果表
                            $change_check_warning_map['id'] = array('eq',$warning_obj_id);
                            $change_check_warning_data['check_status'] = 1;
                            $change_check_warning_obj = $model  ->table('check_warning')
                                                                ->where($change_check_warning_map)
                                                                ->save($change_check_warning_data);

                            if(($organization_obj===false) and ($change_check_warning_obj===false)){
                                $flag = false;
                            }else {
                                $flag = true;
                            }
                        }


                        if($flag){
                            $model->commit();
                            $data['error'] = '0';
                            $data['msg']   ='操作成功';
                            echo json_encode($data);
                        }else{
                            $model->rollback();
                            $data['error'] = '1';
                            $data['msg']   ='操作失败 请刷新重试!';
                            echo json_encode($data);

                        }
                    }


                } elseif($change_type==2) { //将考核结果从成功设置为失败

                    if($shop_result['check_status']==0){
                        $data['error'] = 1;
                        $data['msg']   = '请勿重复操作!';
                        echo json_encode($data);
                    }else{
                        $model = new Model();
                        $model->startTrans();   //开启事务
                        $flag = false;
                        if(($shop_result['shop_type']==3) and ($shop_result['shop_stage']==1)){ //标准店经营期
                            //将标准店经营期变成观察期
                            //更新机构表 将店铺设置为观察期
                            $organization_map['org_code'] =  array('eq',$shop_result['shop_number']);
                            $organization_data['status']  =  -1 ;
                            $organization_data['check_results']  = 1;
                            $organization_obj = $model->table('organization')->where($organization_map)->save($organization_data);
                            if($organization_obj===false){
                                $flag = false;
                            }else{
                                //更新考核表
                                $check_warning_map['shop_number'] = array('eq',$shop_result['shop_number']);
                                $check_warning_map['id'] = array('eq',$shop_result['id']);

                                $change_check_obj = $model->table('check_warning')->where($check_warning_map)->save($check_warning_data);
                                if ($change_check_obj===false) {
                                    $flag = false;
                                } else {
                                    $flag = true;
                                }


                            }
                        }elseif(($shop_result['shop_type']==3) and ($shop_result['shop_stage']==-1)){   //标准店观察期
                            //更新机构表 将会员店铺降级
                                $shop_condition['org_code'] = array('eq',$shop_result['shop_number']);
                                $org_data['status']         = 1;
                                $org_data['check_status']   = 0;
                                $org_data['check_results']  = 2;
                                $organization_obj = $model->table('organization')
                                                         ->where($shop_condition)
                                                         ->save($org_data); //更新机构表
                                if($organization_obj === false){
                                    $flag = false;
                                } else {

                                    //更新会员表 查询自己推荐人的所属标准店更新为自己的所属标准店
                                    $recommended_person_shop_cond['m_number'] = array('eq',$shop_result['recommend_member_id']);
                                    $recommended_shop = $model->table('member')
                                                              ->where($recommended_person_shop_cond)
                                                              ->find();

                                    $member_cond['m_number'] = array('eq',$shop_result['shop_number']);

                                    $member_data['shop_number'] =  $recommended_shop['shop_number'];  //所属标准店代码
                                    $member_data['member_level'] = 1;

                                    $member_obj = $model ->table('member') -> where($member_cond) ->save($member_data);

                                    //更新会员表中推荐人是该店长的会员  会员所属标准店铺改为该会员
                                    $member_other_cond['member_level'] = array('in',array(1,0));    //去除已经是店长的会员
                                    $member_other_cond['recommend_member_id'] = array('eq',$shop_result['shop_number']); //推荐人是该店长

                                    $member_other_data['shop_number'] = $recommended_shop['shop_number'];
                                    $member_other_obj = $model->table('member')
                                                                ->where($member_other_cond)
                                                                ->getField('m_number',true);
                                    if($member_other_obj>1){
                                        //更新推荐人为自己的会员店铺代码为该操作店铺
                                        $update_member_other_cond['shop_number'] = array('in',$member_other_obj);
                                        $update_member_other = $model->table('member')
                                                                     ->where($update_member_other_cond)
                                                                     ->save($member_other_data);
                                    }

                                    if(($member_obj===false) and($member_other_obj===false)){
                                        $flag = false;
                                    }else{
                                        //更新表单表
                                        $insurance_condition['salesman_number'] = array('in',$member_other_obj);
                                        $insurance_data['standard_shop_number'] =$recommended_shop['shop_number'];
                                        $change_insurance_shop_number = $model->table('insurance')
                                                                                ->where($insurance_condition)
                                                                                ->save($insurance_data);

                                        if($change_insurance_shop_number===false){
                                            $flag = false;
                                        }else{

                                            //更新续期保单表
                                            $change_insurance_re_shop_number = $model->table('insurance_re')
                                                                                     ->where($insurance_condition)
                                                                                     ->save($insurance_data);
                                            if($change_insurance_re_shop_number===false){
                                                $flag = false;
                                            }else{  //更新考核预警表
                                                $change_check_condition['id'] = array('eq',$shop_result['id']);
                                                $change_check_data['check_status'] = 0;
                                                $change_check_waring_obj = $model->table('check_warning')
                                                                                ->where($change_check_condition)
                                                                                ->save($change_check_data);
                                                if($change_check_waring_obj===false){
                                                    $flag = false;
                                                }else{
                                                    $flag = true;
                                                }
                                            }
                                        }


                                    }


                                }

                            if($flag){
                                $model->commit();
                                $data['error'] = '0';
                                $data['msg']   ='操作成功';
                                echo json_encode($data);
                            }else{
                                $model->rollback();
                                $data['error'] = '1';
                                $data['msg']   ='操作失败 请刷新重试!';
                                echo json_encode($data);

                            }
                        }elseif(($shop_result['shop_type']==2) and ($shop_result['shop_stage']==-1)){   //旗舰店观察期

                        }elseif(($shop_result['shop_type']==2) and ($shop_result['shop_stage']==1)){    //旗舰店经营期
                            //将旗舰店经营期变成观察期
                            //更新机构表 将店铺设置为观察期
                            $organization_map['org_code'] =  array('eq',$shop_result['shop_number']);
                            $organization_data['status']  =  -1 ;
                            $organization_data['check_results']  =  1 ;

                            $organization_obj = $model->table('organization')->where($organization_map)->save($organization_data);

                            if($organization_obj===false){
                                $flag = false;
                            }else{
                                //更新考核表
                                $check_warning_map['shop_number'] = array('eq',$shop_result['shop_number']);
                                $check_warning_map['id'] = array('eq',$shop_result['id']);
                                $check_warning_data['check_status'] = 0;

                                $change_check_obj = $model->table('check_warning')->where($check_warning_map)->save($check_warning_data);

                                if ($change_check_obj===false) {
                                    $flag = false;
                                } else {
                                    $flag = true;
                                }


                            }

                        }

                        if($flag){
                            $model->commit();
                            $data['error'] = '0';
                            $data['msg']   ='操作成功';
                            echo json_encode($data);
                        }else{
                            $model->rollback();
                            $data['error'] = '1';
                            $data['msg']   ='操作失败 请刷新重试!';
                            echo json_encode($data);

                        }
                    }
                }



            } else {
                $data['error'] = 1;
                $data['msg']   = '记录不存在 请刷新重试!';
                echo json_encode($data);
            }

        }else{
            $data['error'] = 1;
            $data['msg']   = '参数不正确 请刷新重试!';
            echo json_encode($data);
        }
    }
}
