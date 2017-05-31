<?php
/**
 * 后台业绩管理控制器.
 * User: lzj
 * Date: 2017/5/6
 * Time: 10:21
 */

namespace Admin\Controller;
use Common\Controller\AdminbaseController;
class PerformanceController extends AdminbaseController{
    /*
     * 分公司昨日业绩排名及业绩 脚本
     * */
    public function branchAchieve(){
        $tmodel = D('insurance');//实例化首期表
        //查询所有分公司下的旗舰店首期寿险业绩；
        $branchPerformanceModel = M('insu_branch_performance');//实例化分公司昨日业绩排名表
        /******************分公司昨日本月业绩及排名start***************/
        //首期，保单类型-寿险-insurance_type=1，保单状态-policy_status（有效），时间-insured_date-(当月，本季度，本半年，本年)，分公司代码=post获取到的分公司代码
//                SELECT obj.standard_shop_number,obj.branch_shop_number,obj.pay2,@rownum := @rownum + 1 AS rownum FROM (SELECT `standard_shop_number`, `branch_shop_number` ,SUM(insurance_premium) as pay2 FROM `insurance` WHERE ( insurance_type=1 and policy_status=1 and FROM_UNIXTIME(insured_date,"%Y-%m")=DATE_FORMAT(NOW(),"%Y-%m") and branch_shop_number=35) GROUP BY standard_shop_number ORDER BY pay2 DESC) AS obj,(SELECT @rownum := 0) r;
        $res2 = $tmodel
            ->field('branch_shop_number,SUM(insurance_premium) as pay')//分公司代码，保险保费
            ->where('insurance_type=1 and policy_status=1 and FROM_UNIXTIME(insured_date,"%Y-%m")=DATE_FORMAT(NOW(),"%Y-%m")')
            ->group('branch_shop_number') //根据分公司分组
//                    ->order('pay desc')         //根据保险保费倒序排名
            ->select();
        //调用二维数组排序并追加排名 方法
        $mon_res = $this->arrSort($res2,'pay','mon_ranking');
        //重构数组，使其能插入到数据表中
        $mon_info = array();
        foreach($mon_res as $key=>$value){
            $mon_info[$key]['branch_id'] = $value['branch_shop_number'];    //分公司ID
            $mon_info[$key]['mon_achieve'] = $value['pay'];                 //分公司昨日本月业绩
            $mon_info[$key]['mon_ranking'] = $value['mon_ranking'];         //分公司昨日本月排名
            $mon_info[$key]['ranking_time'] = time();                       //查询时间
        }
        //添加前判断分公司ID是否存在于表中，存在则修改，不存在则添加
        $sql = " INSERT INTO insu_branch_performance (branch_id,mon_achieve,mon_ranking,ranking_time) VALUES ";
        foreach($mon_info as $a=>$b){
            $sql .= "('".$b['branch_id']."',".$b['mon_achieve'].",".$b['mon_ranking'].",'".$b['ranking_time']."'),";
        }
        $sql = rtrim($sql,',');//去除右边逗号
        $sql .= " ON DUPLICATE KEY UPDATE mon_achieve = VALUES(mon_achieve),mon_ranking = VALUES(mon_ranking),ranking_time = VALUES(ranking_time)";
        //执行sql语句，插入或更新
        $result = $branchPerformanceModel->execute($sql);
        /******************分公司昨日本月业绩及排名end***************/
        /******************分公司昨日本季度业绩及排名start***************/
        //首期，保单类型-寿险-insurance_type=1，保单状态-policy_status（有效），时间-insured_date-(当月，本季度，本半年，本年)，分公司代码=post获取到的分公司代码
//              （原生含排名）  SELECT obj.standard_shop_number,obj.branch_shop_number,obj.pay2,@rownum := @rownum + 1 AS rownum FROM (SELECT `standard_shop_number`, `branch_shop_number` ,SUM(insurance_premium) as pay2 FROM `insurance` WHERE ( insurance_type=1 and policy_status=1 and QUARTER(FROM_UNIXTIME(insured_date,"%Y-%m-%d"))=QUARTER(DATE_FORMAT(NOW(),"%Y-%m-%d")) and branch_shop_number=35) GROUP BY standard_shop_number ORDER BY pay2 DESC) AS obj,(SELECT @rownum := 0) r;
        $res3 = $tmodel
            ->field('branch_shop_number,SUM(insurance_premium) as quarter_pay')//分公司代码，保险保费
            ->where('insurance_type=1 and policy_status=1 and QUARTER(FROM_UNIXTIME(insured_date,"%Y-%m-%d"))=QUARTER(DATE_FORMAT(NOW(),"%Y-%m-%d"))')
            ->group('branch_shop_number')//根据分公司分组
//                    ->order('quarter_pay desc')//根据保险保费倒序排名
            ->select();
        //调用二维数组排序并追加排名 方法
        $quarter_res = $this->arrSort($res3,'quarter_pay','quar_ranking');
        //重构数组，使其能插入到数据表中
        $quarter_info = array();
        foreach($quarter_res as $qkey=>$qvalue){
            $quarter_info[$qkey]['branch_id'] = $qvalue['branch_shop_number'];  //分公司ID
            $quarter_info[$qkey]['quar_achieve'] = $qvalue['quarter_pay'];      //分公司本季度业绩
            $quarter_info[$qkey]['quar_ranking'] = $qvalue['quar_ranking'];     //分公司本季度排名
            $quarter_info[$qkey]['ranking_time'] = time();                      //查询时间
        }
        //添加前判断旗舰店ID是否存在于表中，存在则修改，不存在则添加
        $quar_sql = " INSERT INTO insu_branch_performance (branch_id,quar_achieve,quar_ranking,ranking_time) VALUES ";
        foreach($quarter_info as $qk=>$qv){
            $quar_sql .= "('".$qv['branch_id']."',".$qv['quar_achieve'].",".$qv['quar_ranking'].",'".$qv['ranking_time']."'),";
        }
        $quar_sql = rtrim($quar_sql,',');//去除右边逗号
        $quar_sql .= " ON DUPLICATE KEY UPDATE quar_achieve = VALUES(quar_achieve),quar_ranking = VALUES(quar_ranking),ranking_time = VALUES(ranking_time)";
        //执行sql语句，插入或更新
        $quar_result = $branchPerformanceModel->execute($quar_sql);
        /******************分公司昨日本季度业绩及排名end***************/
        /******************分公司昨日本半年业绩及排名start***************/
        $res4 = $tmodel
            ->where('
                            insurance_type=1 and policy_status=1 AND
                            if(
                                MONTH(DATE_FORMAT(NOW(),"%Y-%m-%d"))+0 <= 6,
                                YEAR(FROM_UNIXTIME(insured_date,"%Y-%m-%d"))=YEAR(DATE_FORMAT(NOW(),"%Y-%m-%d"))
                                    AND MONTH(FROM_UNIXTIME(insured_date,"%Y-%m-%d"))+0 <= 6,
                                YEAR(FROM_UNIXTIME(insured_date,"%Y-%m-%d"))=YEAR(DATE_FORMAT(NOW(),"%Y-%m-%d"))
                                    AND MONTH(FROM_UNIXTIME(insured_date,"%Y-%m-%d"))+0 >= 7
                            )')
            ->field('branch_shop_number,SUM(insurance_premium) as half_pay')//分公司代码，保险保费
            ->group('branch_shop_number')
//                    ->order('half_pay desc')
            ->select();
        //调用二维数组排序并追加排名 方法
        $half_res = $this->arrSort($res4,'half_pay','half_ranking');
        //重构数组，使其能插入到数据表中
        $half_info = array();
        foreach($half_res as $hkey=>$hvalue){
            $half_info[$hkey]['branch_id'] = $hvalue['branch_shop_number'];     //旗舰店ID
            $half_info[$hkey]['half_achieve'] = $hvalue['half_pay'];        //旗舰店半年业绩
            $half_info[$hkey]['half_ranking'] = $hvalue['half_ranking'];    //旗舰店半年排名
            $half_info[$hkey]['ranking_time'] = time();        //查询时间
        }
        //添加前判断分公司ID是否存在于表中，存在则修改，不存在则添加
        $half_sql = " INSERT INTO insu_branch_performance (branch_id,half_achieve,half_ranking,ranking_time) VALUES ";
        foreach($half_info as $hk=>$hv){
            $half_sql .= "('".$hv['branch_id']."',".$hv['half_achieve'].",".$hv['half_ranking'].",'".$hv['ranking_time']."'),";
        }
        $half_sql = rtrim($half_sql,',');//去除右边逗号
        $half_sql .= " ON DUPLICATE KEY UPDATE half_achieve = VALUES(half_achieve),half_ranking = VALUES(half_ranking),ranking_time = VALUES(ranking_time)";
        //执行sql语句，插入或更新
        $half_result = $branchPerformanceModel->execute($half_sql);
        /******************分公司昨日本半年业绩及排名end***************/
        /******************分公司昨日本年业绩及排名start***************/
        //首期，保单类型-寿险-insurance_type=1，保单状态-policy_status（有效），时间-insured_date-(当月，本季度，本半年，本年)
//                SELECT obj.standard_shop_number,obj.branch_shop_number,obj.pay2,@rownum := @rownum + 1 AS rownum FROM (SELECT `standard_shop_number`, `branch_shop_number` ,SUM(insurance_premium) as pay2 FROM `insurance` WHERE ( insurance_type=1 and policy_status=1 and YEAR(FROM_UNIXTIME(insured_date,"%Y-%m-%d"))=YEAR(DATE_FORMAT(NOW(),"%Y-%m-%d")) and branch_shop_number=35) GROUP BY standard_shop_number ORDER BY pay2 DESC) AS obj,(SELECT @rownum := 0) r;
        $res5 = $tmodel
            ->field('branch_shop_number,SUM(insurance_premium) as year_pay')//旗舰店代码，分公司代码，保险保费
            ->where('insurance_type=1 and policy_status=1 and YEAR(FROM_UNIXTIME(insured_date,"%Y-%m-%d"))=YEAR(DATE_FORMAT(NOW(),"%Y-%m-%d"))')
            ->group('branch_shop_number')//根据标准店分组
//                    ->order('year_pay desc')//根据保险保费倒序排名
            ->select();

        //调用二维数组排序并追加排名 方法
        $year_res = $this->arrSort($res5,'year_pay','year_ranking');
        //重构数组，使其能插入到数据表中
        $year_info = array();
        foreach($year_res as $ykey=>$yvalue){
            $year_info[$ykey]['branch_id'] = $yvalue['branch_shop_number'];     //旗舰店ID
            $year_info[$ykey]['year_achieve'] = $yvalue['year_pay'];    //旗舰店本年业绩
            $year_info[$ykey]['year_ranking'] = $yvalue['year_ranking'];    //旗舰店本年排名
            $year_info[$ykey]['ranking_time'] = time();        //查询时间
        }
        //添加前判断旗舰店ID是否存在于表中，存在则修改，不存在则添加
        $year_sql = " INSERT INTO insu_branch_performance (branch_id,year_achieve,year_ranking,ranking_time) VALUES ";
        foreach($year_info as $yk=>$yv){
            $year_sql .= "('".$yv['branch_id']."',".$yv['year_achieve'].",".$yv['year_ranking'].",'".$yv['ranking_time']."'),";
        }
        $year_sql = rtrim($year_sql,',');//去除右边逗号
        $year_sql .= " ON DUPLICATE KEY UPDATE year_achieve = VALUES(year_achieve),year_ranking = VALUES(year_ranking),ranking_time = VALUES(ranking_time)";
        //执行sql语句，插入或更新
        $year_result = $branchPerformanceModel->execute($year_sql);
        /******************分公司昨日本年业绩及排名end***************/
    }

    /*
     * 旗舰店昨日业绩排名及业绩 脚本
     *
     * */
    public function flagAchieve(){
        $tmodel = D('insurance');//实例化首期表
        //查询所有分公司下的旗舰店首期寿险业绩；
        $flagPerformanceModel = M('insu_flag_performance');//实例化旗舰店昨日业绩排名表
        /******************旗舰店昨日本月业绩及排名start***************/
        //首期，保单类型-寿险-insurance_type=1，保单状态-policy_status（有效），时间-insured_date-(当月，本季度，本半年，本年)，分公司代码=post获取到的分公司代码
//                SELECT obj.standard_shop_number,obj.branch_shop_number,obj.pay2,@rownum := @rownum + 1 AS rownum FROM (SELECT `standard_shop_number`, `branch_shop_number` ,SUM(insurance_premium) as pay2 FROM `insurance` WHERE ( insurance_type=1 and policy_status=1 and FROM_UNIXTIME(insured_date,"%Y-%m")=DATE_FORMAT(NOW(),"%Y-%m") and branch_shop_number=35) GROUP BY standard_shop_number ORDER BY pay2 DESC) AS obj,(SELECT @rownum := 0) r;
        $res2 = $tmodel
            ->field('flag_shop_number,SUM(insurance_premium) as pay')//旗舰店代码，保险保费
            ->where('insurance_type=1 and policy_status=1 and FROM_UNIXTIME(insured_date,"%Y-%m")=DATE_FORMAT(NOW(),"%Y-%m")')
            ->group('flag_shop_number') //根据旗舰店分组
//                    ->order('pay desc')         //根据保险保费倒序排名
            ->select();
        //调用二维数组排序并追加排名 方法
        $mon_res = $this->arrSort($res2,'pay','mon_ranking');
        //重构数组，使其能插入到数据表中
        $mon_info = array();
        foreach($mon_res as $key=>$value){
            $mon_info[$key]['flag_id'] = $value['flag_shop_number'];        //旗舰店ID
            $mon_info[$key]['mon_achieve'] = $value['pay'];                 //旗舰店昨日本月业绩
            $mon_info[$key]['mon_ranking'] = $value['mon_ranking'];         //旗舰店昨日本月排名
            $mon_info[$key]['ranking_time'] = time();                       //查询时间
        }
        //添加前判断旗舰店ID是否存在于表中，存在则修改，不存在则添加
        $sql = " INSERT INTO insu_flag_performance (flag_id,mon_achieve,mon_ranking,ranking_time) VALUES ";
        foreach($mon_info as $a=>$b){
            $sql .= "('".$b['flag_id']."',".$b['mon_achieve'].",".$b['mon_ranking'].",'".$b['ranking_time']."'),";
        }
        $sql = rtrim($sql,',');//去除右边逗号
        $sql .= " ON DUPLICATE KEY UPDATE mon_achieve = VALUES(mon_achieve),mon_ranking = VALUES(mon_ranking),ranking_time = VALUES(ranking_time)";
        //执行sql语句，插入或更新
        $result = $flagPerformanceModel->execute($sql);
        /******************旗舰店昨日本月业绩及排名end***************/
        /******************旗舰店昨日本季度业绩及排名start***************/
        //首期，保单类型-寿险-insurance_type=1，保单状态-policy_status（有效），时间-insured_date-(当月，本季度，本半年，本年)，分公司代码=post获取到的分公司代码
//              （原生含排名）  SELECT obj.standard_shop_number,obj.branch_shop_number,obj.pay2,@rownum := @rownum + 1 AS rownum FROM (SELECT `standard_shop_number`, `branch_shop_number` ,SUM(insurance_premium) as pay2 FROM `insurance` WHERE ( insurance_type=1 and policy_status=1 and QUARTER(FROM_UNIXTIME(insured_date,"%Y-%m-%d"))=QUARTER(DATE_FORMAT(NOW(),"%Y-%m-%d")) and branch_shop_number=35) GROUP BY standard_shop_number ORDER BY pay2 DESC) AS obj,(SELECT @rownum := 0) r;
        $res3 = $tmodel
            ->field('flag_shop_number,SUM(insurance_premium) as quarter_pay')//旗舰店代码，保险保费
            ->where('insurance_type=1 and policy_status=1 and QUARTER(FROM_UNIXTIME(insured_date,"%Y-%m-%d"))=QUARTER(DATE_FORMAT(NOW(),"%Y-%m-%d"))')
            ->group('flag_shop_number')//根据标准店分组
//                    ->order('quarter_pay desc')//根据保险保费倒序排名
            ->select();
        //调用二维数组排序并追加排名 方法
        $quarter_res = $this->arrSort($res3,'quarter_pay','quar_ranking');
        //重构数组，使其能插入到数据表中
        $quarter_info = array();
        foreach($quarter_res as $qkey=>$qvalue){
            $quarter_info[$qkey]['flag_id'] = $qvalue['flag_shop_number'];      //旗舰店ID
            $quarter_info[$qkey]['quar_achieve'] = $qvalue['quarter_pay'];      //旗舰店本季度业绩
            $quarter_info[$qkey]['quar_ranking'] = $qvalue['quar_ranking'];     //旗舰店本季度排名
            $quarter_info[$qkey]['ranking_time'] = time();         //查询时间
        }
        //添加前判断旗舰店ID是否存在于表中，存在则修改，不存在则添加
        $quar_sql = " INSERT INTO insu_flag_performance (flag_id,quar_achieve,quar_ranking,ranking_time) VALUES ";
        foreach($quarter_info as $qk=>$qv){
            $quar_sql .= "('".$qv['flag_id']."',".$qv['quar_achieve'].",".$qv['quar_ranking'].",'".$qv['ranking_time']."'),";
        }
        $quar_sql = rtrim($quar_sql,',');//去除右边逗号
        $quar_sql .= " ON DUPLICATE KEY UPDATE quar_achieve = VALUES(quar_achieve),quar_ranking = VALUES(quar_ranking),ranking_time = VALUES(ranking_time)";
        //执行sql语句，插入或更新
        $quar_result = $flagPerformanceModel->execute($quar_sql);
        /******************旗舰店昨日本季度业绩及排名end***************/
        /******************旗舰店昨日本半年业绩及排名start***************/
        $res4 = $tmodel
            ->where('
                            insurance_type=1 and policy_status=1 AND
                            if(
                                MONTH(DATE_FORMAT(NOW(),"%Y-%m-%d"))+0 <= 6,
                                YEAR(FROM_UNIXTIME(insured_date,"%Y-%m-%d"))=YEAR(DATE_FORMAT(NOW(),"%Y-%m-%d"))
                                    AND MONTH(FROM_UNIXTIME(insured_date,"%Y-%m-%d"))+0 <= 6,
                                YEAR(FROM_UNIXTIME(insured_date,"%Y-%m-%d"))=YEAR(DATE_FORMAT(NOW(),"%Y-%m-%d"))
                                    AND MONTH(FROM_UNIXTIME(insured_date,"%Y-%m-%d"))+0 >= 7
                            )')
            ->field('flag_shop_number,SUM(insurance_premium) as half_pay')//旗舰店代码，分公司代码，保险保费
            ->group('flag_shop_number')
//                    ->order('half_pay desc')
            ->select();
        //调用二维数组排序并追加排名 方法
        $half_res = $this->arrSort($res4,'half_pay','half_ranking');
        //重构数组，使其能插入到数据表中
        $half_info = array();
        foreach($half_res as $hkey=>$hvalue){
            $half_info[$hkey]['flag_id'] = $hvalue['flag_shop_number'];     //旗舰店ID
            $half_info[$hkey]['half_achieve'] = $hvalue['half_pay'];        //旗舰店半年业绩
            $half_info[$hkey]['half_ranking'] = $hvalue['half_ranking'];    //旗舰店半年排名
            $half_info[$hkey]['ranking_time'] = time();        //查询时间
        }
        //添加前判断旗舰店ID是否存在于表中，存在则修改，不存在则添加
        $half_sql = " INSERT INTO insu_flag_performance (flag_id,half_achieve,half_ranking,ranking_time) VALUES ";
        foreach($half_info as $hk=>$hv){
            $half_sql .= "('".$hv['flag_id']."',".$hv['half_achieve'].",".$hv['half_ranking'].",'".$hv['ranking_time']."'),";
        }
        $half_sql = rtrim($half_sql,',');//去除右边逗号
        $half_sql .= " ON DUPLICATE KEY UPDATE half_achieve = VALUES(half_achieve),half_ranking = VALUES(half_ranking),ranking_time = VALUES(ranking_time)";
        //执行sql语句，插入或更新
        $half_result = $flagPerformanceModel->execute($half_sql);
        /******************旗舰店昨日本半年业绩及排名end***************/
        /******************旗舰店昨日本年业绩及排名start***************/
        //首期，保单类型-寿险-insurance_type=1，保单状态-policy_status（有效），时间-insured_date-(当月，本季度，本半年，本年)
//                SELECT obj.standard_shop_number,obj.branch_shop_number,obj.pay2,@rownum := @rownum + 1 AS rownum FROM (SELECT `standard_shop_number`, `branch_shop_number` ,SUM(insurance_premium) as pay2 FROM `insurance` WHERE ( insurance_type=1 and policy_status=1 and YEAR(FROM_UNIXTIME(insured_date,"%Y-%m-%d"))=YEAR(DATE_FORMAT(NOW(),"%Y-%m-%d")) and branch_shop_number=35) GROUP BY standard_shop_number ORDER BY pay2 DESC) AS obj,(SELECT @rownum := 0) r;
        $res5 = $tmodel
            ->field('flag_shop_number,SUM(insurance_premium) as year_pay')//旗舰店代码，分公司代码，保险保费
            ->where('insurance_type=1 and policy_status=1 and YEAR(FROM_UNIXTIME(insured_date,"%Y-%m-%d"))=YEAR(DATE_FORMAT(NOW(),"%Y-%m-%d"))')
            ->group('flag_shop_number')//根据标准店分组
//                    ->order('year_pay desc')//根据保险保费倒序排名
            ->select();

        //调用二维数组排序并追加排名 方法
        $year_res = $this->arrSort($res5,'year_pay','year_ranking');
        //重构数组，使其能插入到数据表中
        $year_info = array();
        foreach($year_res as $ykey=>$yvalue){
            $year_info[$ykey]['flag_id'] = $yvalue['flag_shop_number'];     //旗舰店ID
            $year_info[$ykey]['year_achieve'] = $yvalue['year_pay'];    //旗舰店本年业绩
            $year_info[$ykey]['year_ranking'] = $yvalue['year_ranking'];    //旗舰店本年排名
            $year_info[$ykey]['ranking_time'] = time();        //查询时间
        }
        //添加前判断旗舰店ID是否存在于表中，存在则修改，不存在则添加
        $year_sql = " INSERT INTO insu_flag_performance (flag_id,year_achieve,year_ranking,ranking_time) VALUES ";
        foreach($year_info as $yk=>$yv){
            $year_sql .= "('".$yv['flag_id']."',".$yv['year_achieve'].",".$yv['year_ranking'].",'".$yv['ranking_time']."'),";
        }
        $year_sql = rtrim($year_sql,',');//去除右边逗号
        $year_sql .= " ON DUPLICATE KEY UPDATE year_achieve = VALUES(year_achieve),year_ranking = VALUES(year_ranking),ranking_time = VALUES(ranking_time)";
        //执行sql语句，插入或更新
        $year_result = $flagPerformanceModel->execute($year_sql);
        /******************旗舰店昨日本年业绩及排名end***************/
    }

    /*
     * 标准店昨日业绩排名及业绩 脚本
     *
     * */
    public function standAchiev(){
        //查询所有标准店首期寿险业绩
        $tmodel = D('insurance');//实例化首期表
        $standPerformanceModel = M('insu_stand_performance'); //实例化标准店昨日业绩排名表
        /*********************标准店昨日本月业绩及排名start******************/
        //首期，保单类型-寿险-insurance_type=1，保单状态-policy_status（有效），时间-insured_date-(当天，当月，本季度，本半年，本年)，分公司代码=post获取到的分公司代码
//                SELECT obj.standard_shop_number,obj.branch_shop_number,obj.pay2,@rownum := @rownum + 1 AS rownum FROM (SELECT `standard_shop_number`, `branch_shop_number` ,SUM(insurance_premium) as pay2 FROM `insurance` WHERE ( insurance_type=1 and policy_status=1 and FROM_UNIXTIME(insured_date,"%Y-%m")=DATE_FORMAT(NOW(),"%Y-%m") and branch_shop_number=35) GROUP BY standard_shop_number ORDER BY pay2 DESC) AS obj,(SELECT @rownum := 0) r;
        $stand_res2 = $tmodel->where('insurance_type=1 and policy_status=1 and FROM_UNIXTIME(insured_date,"%Y-%m")=DATE_FORMAT(NOW(),"%Y-%m")')
            ->field('standard_shop_number,SUM(insurance_premium) as mon_pay')//标准店代码，当月开单人力，保险保费
            ->group('standard_shop_number')//根据旗舰店分组
//                    ->order('mon_pay desc')//根据保险保费倒序排名
            ->select();
        //调用二维数组排序并追加排名 方法
        $mon_res2 = $this->arrSort($stand_res2,'mon_pay','mon_ranking');
        //重构数组，使其能插入到数据表中
        $mon_info2 = array();
        foreach($mon_res2 as $mkey2=>$mvalue2){
            $mon_info2[$mkey2]['sand_id'] = $mvalue2['standard_shop_number'];       //标准店ID
            $mon_info2[$mkey2]['mon_achieve'] = $mvalue2['mon_pay'];                //标准店本月业绩
            $mon_info2[$mkey2]['mon_ranking'] = $mvalue2['mon_ranking'];            //标准店本月排名
            $mon_info2[$mkey2]['ranking_time'] = time();               //查询时间
        }
        //添加前判断旗舰店ID是否存在于表中，存在则修改，不存在则添加
        $mon_sql = " INSERT INTO insu_stand_performance (sand_id,mon_achieve,mon_ranking,ranking_time) VALUES ";
        foreach($mon_info2 as $mk=>$mv){
            $mon_sql .= "('".$mv['sand_id']."',".$mv['mon_achieve'].",".$mv['mon_ranking'].",'".$mv['ranking_time']."'),";
        }
        $mon_sql = rtrim($mon_sql,',');//去除右边逗号
        $mon_sql .= " ON DUPLICATE KEY UPDATE mon_achieve = VALUES(mon_achieve),mon_ranking = VALUES(mon_ranking),ranking_time = VALUES(ranking_time)";
        //执行sql语句，插入或更新
        $mon_result = $standPerformanceModel->execute($mon_sql);
        /*********************标准店昨日本月业绩及排名end******************/
        /*********************标准店昨日本季度业绩及排名start******************/
        //首期，保单类型-寿险-insurance_type=1，保单状态-policy_status（有效），时间-insured_date-(当天，当月，本季度，本半年，本年)，
        $stand_res3 = $tmodel->where('insurance_type=1 and policy_status=1 and QUARTER(FROM_UNIXTIME(insured_date,"%Y-%m-%d"))=QUARTER(DATE_FORMAT(NOW(),"%Y-%m-%d"))')
            ->field('standard_shop_number,SUM(insurance_premium) as quar_pay')//标准店代码，本季度开单人力，保险保费
            ->group('standard_shop_number')//根据标准店分组
//                    ->order('quar_pay desc')//根据保险保费倒序排名
            ->select();
        //调用二维数组排序并追加排名 方法
        $quar_res2 = $this->arrSort($stand_res3,'quar_pay','quar_ranking');
        //重构数组，使其能插入到数据表中
        $quar_info2 = array();
        foreach($quar_res2 as $qkey2=>$qvalue2){
            $quar_info2[$qkey2]['sand_id'] = $qvalue2['standard_shop_number'];       //标准店ID
            $quar_info2[$qkey2]['quar_achieve'] = $qvalue2['quar_pay'];               //标准店本季度业绩
            $quar_info2[$qkey2]['quar_ranking'] = $qvalue2['quar_ranking'];            //标准店本季度排名
            $quar_info2[$qkey2]['ranking_time'] = time();               //查询时间
        }
        //添加前判断旗舰店ID是否存在于表中，存在则修改，不存在则添加
        $quar_sql = " INSERT INTO insu_stand_performance (sand_id,quar_achieve,quar_ranking,ranking_time) VALUES ";
        foreach($quar_info2 as $qk=>$qv){
            $quar_sql .= "('".$qv['sand_id']."',".$qv['quar_achieve'].",".$qv['quar_ranking'].",'".$qv['ranking_time']."'),";
        }
        $quar_sql = rtrim($quar_sql,',');//去除右边逗号
        $quar_sql .= " ON DUPLICATE KEY UPDATE quar_achieve = VALUES(quar_achieve),quar_ranking = VALUES(quar_ranking),ranking_time = VALUES(ranking_time)";
        //执行sql语句，插入或更新
        $quar_result = $standPerformanceModel->execute($quar_sql);
        /*********************标准店昨日本季度业绩及排名end******************/
        /*********************标准店昨日本半年业绩及排名start******************/
        $stand_res4 = $tmodel->where('
                            insurance_type=1 and policy_status=1 AND
                            if(
                                MONTH(DATE_FORMAT(NOW(),"%Y-%m-%d"))+0 <= 6,
                                YEAR(FROM_UNIXTIME(insured_date,"%Y-%m-%d"))=YEAR(DATE_FORMAT(NOW(),"%Y-%m-%d"))
                                    AND MONTH(FROM_UNIXTIME(insured_date,"%Y-%m-%d"))+0 <= 6,
                                YEAR(FROM_UNIXTIME(insured_date,"%Y-%m-%d"))=YEAR(DATE_FORMAT(NOW(),"%Y-%m-%d"))
                                    AND MONTH(FROM_UNIXTIME(insured_date,"%Y-%m-%d"))+0 >= 7
                            )')
            ->field('standard_shop_number,SUM(insurance_premium) as half_pay')//标准店代码，分公司代码，本半年开单人力，保险保费
            ->group('standard_shop_number')
//                    ->order('half_pay desc')
            ->select();
        //调用二维数组排序并追加排名 方法
        $half_res2 = $this->arrSort($stand_res4,'half_pay','half_ranking');
        //重构数组，使其能插入到数据表中
        $half_info2 = array();
        foreach($half_res2 as $hkey2=>$hvalue2){
            $half_info2[$hkey2]['sand_id'] = $hvalue2['standard_shop_number'];          //标准店ID
            $half_info2[$hkey2]['half_achieve'] = $hvalue2['half_pay'];                 //标准店本半年业绩
            $half_info2[$hkey2]['half_ranking'] = $hvalue2['half_ranking'];             //标准店本半年排名
            $half_info2[$hkey2]['ranking_time'] = time();                  //查询时间
        }
        //添加前判断旗舰店ID是否存在于表中，存在则修改，不存在则添加
        $half_sql = " INSERT INTO insu_stand_performance (sand_id,half_achieve,half_ranking,ranking_time) VALUES ";
        foreach($half_info2 as $hk=>$hv){
            $half_sql .= "('".$hv['sand_id']."',".$hv['half_achieve'].",".$hv['half_ranking'].",'".$hv['ranking_time']."'),";
        }
        $half_sql = rtrim($half_sql,',');//去除右边逗号
        $half_sql .= " ON DUPLICATE KEY UPDATE half_achieve = VALUES(half_achieve),half_ranking = VALUES(half_ranking),ranking_time = VALUES(ranking_time)";
        //执行sql语句，插入或更新
        $half_result = $standPerformanceModel->execute($half_sql);
        /*********************标准店昨日本半年业绩及排名end*******************/
        /*********************标准店昨日本年业绩及排名start******************/
        //首期，保单类型-寿险-insurance_type=1，保单状态-policy_status（有效），时间-insured_date-(当天，当月，本季度，本半年，本年)，分公司代码=post获取到的分公司代码
//                SELECT obj.standard_shop_number,obj.branch_shop_number,obj.pay2,@rownum := @rownum + 1 AS rownum FROM (SELECT `standard_shop_number`, `branch_shop_number` ,SUM(insurance_premium) as pay2 FROM `insurance` WHERE ( insurance_type=1 and policy_status=1 and YEAR(FROM_UNIXTIME(insured_date,"%Y-%m-%d"))=YEAR(DATE_FORMAT(NOW(),"%Y-%m-%d")) and branch_shop_number=35) GROUP BY standard_shop_number ORDER BY pay2 DESC) AS obj,(SELECT @rownum := 0) r;
        $stand_res5 = $tmodel->where('insurance_type=1 and policy_status=1 and YEAR(FROM_UNIXTIME(insured_date,"%Y-%m-%d"))=YEAR(DATE_FORMAT(NOW(),"%Y-%m-%d"))')
            ->field('standard_shop_number,SUM(insurance_premium) as year_pay')//标准店代码，分公司代码，本年开单人力，保险保费
            ->group('standard_shop_number')//根据标准店分组
//                    ->order('year_pay desc')//根据保险保费倒序排名
            ->select();
        //调用二维数组排序并追加排名 方法
        $year_res2 = $this->arrSort($stand_res5,'year_pay','year_ranking');
        //重构数组，使其能插入到数据表中
        $year_info2 = array();
        foreach($year_res2 as $ykey2=>$yvalue2){
            $year_info2[$ykey2]['sand_id'] = $yvalue2['standard_shop_number'];          //标准店ID
            $year_info2[$ykey2]['year_achieve'] = $yvalue2['year_pay'];                 //标准店昨日本年业绩
            $year_info2[$ykey2]['year_ranking'] = $yvalue2['year_ranking'];             //标准店昨日本年排名
            $year_info2[$ykey2]['ranking_time'] = time();                  //查询时间
        }
        //添加前判断旗舰店ID是否存在于表中，存在则修改，不存在则添加
        $year_sql = " INSERT INTO insu_stand_performance (sand_id,year_achieve,year_ranking,ranking_time) VALUES ";
        foreach($year_info2 as $yk=>$yv){
            $year_sql .= "('".$yv['sand_id']."',".$yv['year_achieve'].",".$yv['year_ranking'].",'".$yv['ranking_time']."'),";
        }
        $year_sql = rtrim($year_sql,',');//去除右边逗号
        $year_sql .= " ON DUPLICATE KEY UPDATE year_achieve = VALUES(year_achieve),year_ranking = VALUES(year_ranking),ranking_time = VALUES(ranking_time)";
        //执行sql语句，插入或更新
        $year_result = $standPerformanceModel->execute($year_sql);
        /*********************标准店昨日本年业绩及排名end******************/
    }

    /*
     * 个人业绩昨日排名  执行脚本
     *
     * */
    public function personalAchieve(){
        $tmodel = D('insurance');//实例化首期表
        //查询所有分公司下的会员首期寿险业绩；
        $memPerformanceModel = M('insu_mem_performance');//实例化个人昨日业绩排名表
        /******************会员昨日本月业绩及排名start***************/
        //首期，保单类型-寿险-insurance_type=1，保单状态-policy_status（有效），时间-insured_date-(当月，本季度，本半年，本年)
        $res2 = $tmodel
            ->field('salesman_number,SUM(insurance_premium) as pay')//会员代码，保险保费
            ->where('insurance_type=1 and policy_status=1 and FROM_UNIXTIME(insured_date,"%Y-%m")=DATE_FORMAT(NOW(),"%Y-%m")')
            ->group('salesman_number') //根据会员分组
//                    ->order('pay desc')         //根据保险保费倒序排名
            ->select();
        //调用二维数组排序并追加排名 方法
        $mon_res = $this->arrSort($res2,'pay','mon_ranking');
        //重构数组，使其能插入到数据表中
        $mon_info = array();
        foreach($mon_res as $key=>$value){
            $mon_info[$key]['member_id'] = $value['salesman_number'];        //会员个人ID
            $mon_info[$key]['mon_achieve'] = $value['pay'];                 //会员昨日本月业绩
            $mon_info[$key]['mon_ranking'] = $value['mon_ranking'];         //会员昨日本月排名
            $mon_info[$key]['ranking_time'] = time();                       //查询时间
        }
        //添加前判断会员ID是否存在于表中，存在则修改，不存在则添加
        $sql = " INSERT INTO insu_mem_performance (member_id,mon_achieve,mon_ranking,ranking_time) VALUES ";
        foreach($mon_info as $a=>$b){
            $sql .= "('".$b['member_id']."',".$b['mon_achieve'].",".$b['mon_ranking'].",'".$b['ranking_time']."'),";
        }
        $sql = rtrim($sql,',');//去除右边逗号
        $sql .= " ON DUPLICATE KEY UPDATE mon_achieve = VALUES(mon_achieve),mon_ranking = VALUES(mon_ranking),ranking_time = VALUES(ranking_time)";
        //执行sql语句，插入或更新
        $result = $memPerformanceModel->execute($sql);
        /******************会员昨日本月业绩及排名end***************/
        /******************会员昨日本季度业绩及排名start***************/
        //首期，保单类型-寿险-insurance_type=1，保单状态-policy_status（有效），时间-insured_date-(当月，本季度，本半年，本年)
        $res3 = $tmodel
            ->field('salesman_number,SUM(insurance_premium) as quarter_pay')//会员代码，保险保费
            ->where('insurance_type=1 and policy_status=1 and QUARTER(FROM_UNIXTIME(insured_date,"%Y-%m-%d"))=QUARTER(DATE_FORMAT(NOW(),"%Y-%m-%d"))')
            ->group('salesman_number')//根据标准店分组
//                    ->order('quarter_pay desc')//根据保险保费倒序排名
            ->select();
        //调用二维数组排序并追加排名 方法
        $quarter_res = $this->arrSort($res3,'quarter_pay','quar_ranking');
        //重构数组，使其能插入到数据表中
        $quarter_info = array();
        foreach($quarter_res as $qkey=>$qvalue){
            $quarter_info[$qkey]['member_id'] = $qvalue['salesman_number'];     //会员ID
            $quarter_info[$qkey]['quar_achieve'] = $qvalue['quarter_pay'];      //会员本季度业绩
            $quarter_info[$qkey]['quar_ranking'] = $qvalue['quar_ranking'];     //会员本季度排名
            $quarter_info[$qkey]['ranking_time'] = time();                      //查询时间
        }
        //添加前判断会员ID是否存在于表中，存在则修改，不存在则添加
        $quar_sql = " INSERT INTO insu_mem_performance (member_id,quar_achieve,quar_ranking,ranking_time) VALUES ";
        foreach($quarter_info as $qk=>$qv){
            $quar_sql .= "('".$qv['member_id']."',".$qv['quar_achieve'].",".$qv['quar_ranking'].",'".$qv['ranking_time']."'),";
        }
        $quar_sql = rtrim($quar_sql,',');//去除右边逗号
        $quar_sql .= " ON DUPLICATE KEY UPDATE quar_achieve = VALUES(quar_achieve),quar_ranking = VALUES(quar_ranking),ranking_time = VALUES(ranking_time)";
        //执行sql语句，插入或更新
        $quar_result = $memPerformanceModel->execute($quar_sql);
        /******************会员昨日本季度业绩及排名end  ***************/
        /******************会员昨日本半年业绩及排名start***************/
        $res4 = $tmodel
            ->where('
                            insurance_type=1 and policy_status=1 AND
                            if(
                                MONTH(DATE_FORMAT(NOW(),"%Y-%m-%d"))+0 <= 6,
                                YEAR(FROM_UNIXTIME(insured_date,"%Y-%m-%d"))=YEAR(DATE_FORMAT(NOW(),"%Y-%m-%d"))
                                    AND MONTH(FROM_UNIXTIME(insured_date,"%Y-%m-%d"))+0 <= 6,
                                YEAR(FROM_UNIXTIME(insured_date,"%Y-%m-%d"))=YEAR(DATE_FORMAT(NOW(),"%Y-%m-%d"))
                                    AND MONTH(FROM_UNIXTIME(insured_date,"%Y-%m-%d"))+0 >= 7
                            )')
            ->field('salesman_number,SUM(insurance_premium) as half_pay')//会员代码，保险保费
            ->group('salesman_number')
//                    ->order('half_pay desc')
            ->select();
        //调用二维数组排序并追加排名 方法
        $half_res = $this->arrSort($res4,'half_pay','half_ranking');
        //重构数组，使其能插入到数据表中
        $half_info = array();
        foreach($half_res as $hkey=>$hvalue){
            $half_info[$hkey]['member_id'] = $hvalue['salesman_number'];    //会员ID
            $half_info[$hkey]['half_achieve'] = $hvalue['half_pay'];        //会员半年业绩
            $half_info[$hkey]['half_ranking'] = $hvalue['half_ranking'];    //会员半年排名
            $half_info[$hkey]['ranking_time'] = time();                     //查询时间
        }
        //添加前判断旗舰店ID是否存在于表中，存在则修改，不存在则添加
        $half_sql = " INSERT INTO insu_mem_performance (member_id,half_achieve,half_ranking,ranking_time) VALUES ";
        foreach($half_info as $hk=>$hv){
            $half_sql .= "('".$hv['member_id']."',".$hv['half_achieve'].",".$hv['half_ranking'].",'".$hv['ranking_time']."'),";
        }
        $half_sql = rtrim($half_sql,',');//去除右边逗号
        $half_sql .= " ON DUPLICATE KEY UPDATE half_achieve = VALUES(half_achieve),half_ranking = VALUES(half_ranking),ranking_time = VALUES(ranking_time)";
        //执行sql语句，插入或更新
        $half_result = $memPerformanceModel->execute($half_sql);
        /******************会员昨日本半年业绩及排名end***************/
        /******************会员昨日本年业绩及排名start***************/
        //首期，保单类型-寿险-insurance_type=1，保单状态-policy_status（有效），时间-insured_date-(当月，本季度，本半年，本年)
        $res5 = $tmodel
            ->field('salesman_number,SUM(insurance_premium) as year_pay')//会员代码，保险保费
            ->where('insurance_type=1 and policy_status=1 and YEAR(FROM_UNIXTIME(insured_date,"%Y-%m-%d"))=YEAR(DATE_FORMAT(NOW(),"%Y-%m-%d"))')
            ->group('salesman_number')//根据标准店分组
//                    ->order('year_pay desc')//根据保险保费倒序排名
            ->select();

        //调用二维数组排序并追加排名 方法
        $year_res = $this->arrSort($res5,'year_pay','year_ranking');
        //重构数组，使其能插入到数据表中
        $year_info = array();
        foreach($year_res as $ykey=>$yvalue){
            $year_info[$ykey]['member_id'] = $yvalue['salesman_number'];        //会员ID
            $year_info[$ykey]['year_achieve'] = $yvalue['year_pay'];            //会员本年业绩
            $year_info[$ykey]['year_ranking'] = $yvalue['year_ranking'];        //会员本年排名
            $year_info[$ykey]['ranking_time'] = time();                         //查询时间
        }
        //添加前判断会员ID是否存在于表中，存在则修改，不存在则添加
        $year_sql = " INSERT INTO insu_mem_performance (member_id,year_achieve,year_ranking,ranking_time) VALUES ";
        foreach($year_info as $yk=>$yv){
            $year_sql .= "('".$yv['member_id']."',".$yv['year_achieve'].",".$yv['year_ranking'].",'".$yv['ranking_time']."'),";
        }
        $year_sql = rtrim($year_sql,',');//去除右边逗号
        $year_sql .= " ON DUPLICATE KEY UPDATE year_achieve = VALUES(year_achieve),year_ranking = VALUES(year_ranking),ranking_time = VALUES(ranking_time)";
        //执行sql语句，插入或更新
        $year_result = $memPerformanceModel->execute($year_sql);
        /******************会员昨日本年业绩及排名end***************/
    }


    /*
     *
     * 二维数组排序并追加排名，重构数组使其能插入到排名表
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

    //个人业绩
    public function personal(){
        if(IS_POST){
            //接收查询条件值
            $param = I('post.');
            if((!empty($param['bianma']) && !empty($param['bianmazhi'])) || !empty($param['salesman_name'])){
                $iModel = M('insurance');
                //判断编码类型和编码值
                $bianma = strval(htmlspecialchars($param['bianmazhi']));
                //判断编码值是否为数字或数字字符串
                if(is_numeric($bianma)){
                    $mtype = $param['bianma'];  //编码类型
                    $where[$mtype] = $bianma;
                }
                $uname = htmlspecialchars($param['salesman_name']);
                if(!empty($uname)){
                    $where['salesman_name'] = array('LIKE','%'.$uname.'%');
                }
                $where['insurance_type'] = 1;
                $where['policy_status'] = 1;
                $where['FROM_UNIXTIME(insured_date,"%Y-%m-%d")'] = date("Y-m-d");
                if(!empty($where)){
                    //搜索会员当日业绩
                    $res = $iModel
                        ->field('salesman_number,SUM(insurance_premium) as pay')
                        ->where($where)
                        ->group('salesman_number')
                        ->select();
                }
            }else{
                var_dump(1111);exit;
            }
        }
        $this->display();
    }


    /*
     * 团队业绩查询
     *
     * */
    public function teamCore(){
        $tmodel = D('insurance');//实例化首期表
        $mmodel = D('member');//实例化会员表
        $omodel = D('organization');//实例化机构表
        $ogmodel = D('organizational_goals');//实例化机构目标表
        //请求搜索
        if(!empty($_POST)){
            $param = I('post.');
            $branch_shop_number = $param['branch_shop_number'];//所属分公司代码
            $flag_shop_number = $param['flag_shop_number'];//所属旗舰店代码
            $stand_shop_number = $param['stand_shop_number'];//所属标准店代码
            //空值搜索，不查询；
            if(empty($param['branch_shop_number']) && empty($param['flag_shop_number']) && empty($param['stand_shop_number'])){
                $this->display();
                return false;
            }
            //查找分公司
            else if(!empty($param['branch_shop_number']) && empty($param['flag_shop_number']) && empty($param['stand_shop_number'])){
                $branchModel = D('insu_branch_performance');//实例化分公司昨日排名表
                //查询所有分公司首期寿险业绩；
                //当日业绩
                //首期，保单类型-寿险-insurance_type=1，保单状态-policy_status（有效），时间-insured_date-(当天，当月，本季度，本半年，本年)，分公司代码=post获取到的分公司代码
//                SELECT `standard_shop_number`, `branch_shop_number` ,SUM(insurance_premium) as pay2 FROM `insurance` WHERE ( insurance_type=1 and policy_status=1 and FROM_UNIXTIME(insured_date,"%Y-%m-%d")=DATE_FORMAT(NOW(),"%Y-%m-%d") and branch_shop_number=35) GROUP BY standard_shop_number ORDER BY pay2 DESC;
                $res = $tmodel
                    ->field('branch_shop_number,SUM(insurance_premium) as day_pay')//旗舰店代码，保险保费
                    ->where('insurance_type=1 AND policy_status=1 AND FROM_UNIXTIME(insured_date,"%Y-%m-%d")=DATE_FORMAT(NOW(),"%Y-%m-%d") AND branch_shop_number="'.$branch_shop_number.'"')
                    ->group('branch_shop_number')//根据旗舰店分组
//                    ->order('day_pay desc')//根据保险保费倒序排名
                    ->select();
                /*搜索分公司昨日排名业绩表*/
                $branchInfo = $branchModel
                    ->where('branch_id = "'.$branch_shop_number.'"')
                    ->select();
                //查找分公司的名称及规模人力
                $member = $mmodel
                    ->alias('m')
                    ->join('organization as o ON m.branch_shop_number = o.branch_shop_code AND o.level=1','left')
                    ->field('m.branch_shop_number,count(m.m_number) as count,o.name')
                    ->where('m.branch_shop_number= '.$branch_shop_number)
                    ->group('o.name')
                    ->select();
                //查找当月开单人力
                $policy_mon = $tmodel
                    ->field('count( distinct salesman_number) as policy_num')
                    ->where('branch_shop_number = '.$branch_shop_number.' AND insurance_type = 1 AND policy_status=1 AND FROM_UNIXTIME(insured_date,"%Y-%m")=DATE_FORMAT(NOW(),"%Y-%m")')
                    ->select();
                //查找当季度开单人力
                $policy_quar = $tmodel
                    ->field('count( distinct salesman_number) as policy_num')
                    ->where('branch_shop_number = '.$branch_shop_number.' AND insurance_type = 1 AND policy_status=1 AND QUARTER(FROM_UNIXTIME(insured_date,"%Y-%m-%d"))=QUARTER(DATE_FORMAT(NOW(),"%Y-%m-%d"))')
                    ->select();
                //查找本半年开单人力
                $policy_half = $tmodel
                    ->field('count( distinct salesman_number) as policy_num')
                    ->where('branch_shop_number = '.$branch_shop_number.' AND insurance_type = 1 AND policy_status=1 AND if(
                                MONTH(DATE_FORMAT(NOW(),"%Y-%m-%d"))+0 <= 6,
                                YEAR(FROM_UNIXTIME(insured_date,"%Y-%m-%d"))=YEAR(DATE_FORMAT(NOW(),"%Y-%m-%d"))
                                    AND MONTH(FROM_UNIXTIME(insured_date,"%Y-%m-%d"))+0 <= 6,
                                YEAR(FROM_UNIXTIME(insured_date,"%Y-%m-%d"))=YEAR(DATE_FORMAT(NOW(),"%Y-%m-%d"))
                                    AND MONTH(FROM_UNIXTIME(insured_date,"%Y-%m-%d"))+0 >= 7
                            )')
                    ->select();
                //查找本年开单人力
                $policy_year = $tmodel
                    ->field('count( distinct salesman_number) as policy_num')
                    ->where('branch_shop_number = '.$branch_shop_number.' AND insurance_type = 1 AND policy_status=1 AND YEAR(FROM_UNIXTIME(insured_date,"%Y-%m-%d"))=YEAR(DATE_FORMAT(NOW(),"%Y-%m-%d"))')
                    ->select();
                //查找机构目标
                $branchgoals = $ogmodel
                    ->field('shop_code,insurance_target')
                    ->where('shop_code='.$branch_shop_number)
                    ->find();
                //将当日业绩同昨日统计业绩组合在一起，并把当日业绩同昨日统计业绩相加
                foreach($branchInfo as $k=>$v){
                    $branchInfo[$k]['day_achieve'] .= strval($res[$k]['day_pay']);  // 当日业绩
                    $branchInfo[$k]['name'] .= $member[$k]['name'];         //分公司名称
                    $branchInfo[$k]['num_count'] .= $member[$k]['count'];   //规模人力
                    $branchInfo[$k]['policy_mon'] .= $policy_mon[$k]['policy_num'];//本月开单人力
                    $branchInfo[$k]['policy_quar'] .= $policy_quar[$k]['policy_num'];//本季度开单人力
                    $branchInfo[$k]['policy_half'] .= $policy_half[$k]['policy_num'];//本半年开单人力
                    $branchInfo[$k]['policy_year'] .= $policy_year[$k]['policy_num'];//本年开单人力
                    $branchInfo[$k]['mon_achieve'] = strval($v['mon_achieve']) + strval($res[$k]['day_pay']); //本月业绩
                    $branchInfo[$k]['quar_achieve'] = strval($v['quar_achieve']) + strval($res[$k]['day_pay']);//本季度业绩
                    $branchInfo[$k]['half_achieve'] = strval($v['half_achieve']) + strval($res[$k]['day_pay']);//本半年业绩
                    $branchInfo[$k]['year_achieve'] = strval($v['year_achieve']) + strval($res[$k]['day_pay']);//本年业绩
                    $branchInfo[$k]['branch_gouls'] = $branchInfo[$k]['year_achieve']/$branchgoals['insurance_target']*100 .'%';//机构目标
                }

                $this->assign('branchInfo',$branchInfo);
                $this->assign('branch_id',$branch_shop_number);
                $this->display();
            }
            //查找旗舰店
            else if(!empty($param['branch_shop_number']) && !empty($param['flag_shop_number'])  && empty($param['stand_shop_number'])){ //查询所有分公司下的旗舰店首期寿险业绩
                $flagModel = D('insu_flag_performance');//实例化旗舰店昨日排名表
                //当日业绩
                //首期，保单类型-寿险-insurance_type=1，保单状态-policy_status（有效），时间-insured_date-(当天，当月，本季度，本半年，本年)，分公司代码=post获取到的分公司代码
                $res = $tmodel->where('insurance_type=1 AND policy_status=1 AND FROM_UNIXTIME(insured_date,"%Y-%m-%d")=DATE_FORMAT(NOW(),"%Y-%m-%d") AND branch_shop_number="'.$branch_shop_number.'" AND flag_shop_number='.$flag_shop_number)
                    ->field('flag_shop_number,branch_shop_number,SUM(insurance_premium) as pay')//旗舰店代码，分公司代码，保险保费
                    ->group('flag_shop_number')//根据标准店分组
                    ->order('pay desc')//根据保险保费倒序排名
                    ->select();
                /*搜索旗舰店昨日排名业绩表*/
                $flagInfo = $flagModel
                    ->where('flag_id = "'.$flag_shop_number.'"')
                    ->select();
                //查找旗舰店的名称及规模人力
                $member = $mmodel
                    ->alias('m')
                    ->join('organization as o ON m.flagship_number = o.flagship_code AND o.level=2','left')
                    ->field('m.flagship_number,count(m.m_number) as count,o.name')
                    ->where('m.flagship_number= '.$flag_shop_number)
                    ->group('o.name')
                    ->select();
                //查找当月开单人力
                $policy_mon = $tmodel
                    ->field('count( distinct salesman_number) as policy_num')
                    ->where('flag_shop_number = '.$flag_shop_number.' AND insurance_type = 1 AND policy_status=1 AND FROM_UNIXTIME(insured_date,"%Y-%m")=DATE_FORMAT(NOW(),"%Y-%m")')
                    ->select();
                //查找当季度开单人力
                $policy_quar = $tmodel
                    ->field('count( distinct salesman_number) as policy_num')
                    ->where('flag_shop_number = '.$flag_shop_number.' AND insurance_type = 1 AND policy_status=1 AND QUARTER(FROM_UNIXTIME(insured_date,"%Y-%m-%d"))=QUARTER(DATE_FORMAT(NOW(),"%Y-%m-%d"))')
                    ->select();
                //查找本半年开单人力
                $policy_half = $tmodel
                    ->field('count( distinct salesman_number) as policy_num')
                    ->where('flag_shop_number = '.$flag_shop_number.' AND insurance_type = 1 AND policy_status=1 AND if(
                                MONTH(DATE_FORMAT(NOW(),"%Y-%m-%d"))+0 <= 6,
                                YEAR(FROM_UNIXTIME(insured_date,"%Y-%m-%d"))=YEAR(DATE_FORMAT(NOW(),"%Y-%m-%d"))
                                    AND MONTH(FROM_UNIXTIME(insured_date,"%Y-%m-%d"))+0 <= 6,
                                YEAR(FROM_UNIXTIME(insured_date,"%Y-%m-%d"))=YEAR(DATE_FORMAT(NOW(),"%Y-%m-%d"))
                                    AND MONTH(FROM_UNIXTIME(insured_date,"%Y-%m-%d"))+0 >= 7
                            )')
                    ->select();
                //查找本年开单人力
                $policy_year = $tmodel
                    ->field('count( distinct salesman_number) as policy_num')
                    ->where('flag_shop_number = '.$flag_shop_number.' AND insurance_type = 1 AND policy_status=1 AND YEAR(FROM_UNIXTIME(insured_date,"%Y-%m-%d"))=YEAR(DATE_FORMAT(NOW(),"%Y-%m-%d"))')
                    ->select();
                //查找机构目标
                $branchgoals = $ogmodel
                    ->field('shop_code,insurance_target')
                    ->where('shop_code='.$flag_shop_number)
                    ->find();

                //将当日业绩同昨日统计业绩组合在一起，并把当日业绩同昨日统计业绩相加
                foreach($flagInfo as $fk=>$fv){
                    $flagInfo[$fk]['day_achieve'] .= strval($res[$fk]['day_pay']);  // 当日业绩
                    $flagInfo[$fk]['name'] .= $member[$fk]['name'];         //分公司名称
                    $flagInfo[$fk]['num_count'] .= $member[$fk]['count'];   //规模人力
                    $flagInfo[$fk]['policy_mon'] .= $policy_mon[$fk]['policy_num'];//本月开单人力
                    $flagInfo[$fk]['policy_quar'] .= $policy_quar[$fk]['policy_num'];//本季度开单人力
                    $flagInfo[$fk]['policy_half'] .= $policy_half[$fk]['policy_num'];//本半年开单人力
                    $flagInfo[$fk]['policy_year'] .= $policy_year[$fk]['policy_num'];//本年开单人力
                    $flagInfo[$fk]['mon_achieve'] = strval($fv['mon_achieve']) + strval($res[$fk]['day_pay']); //本月业绩
                    $flagInfo[$fk]['quar_achieve'] = strval($fv['quar_achieve']) + strval($res[$fk]['day_pay']);//本季度业绩
                    $flagInfo[$fk]['half_achieve'] = strval($fv['half_achieve']) + strval($res[$fk]['day_pay']);//本半年业绩
                    $flagInfo[$fk]['year_achieve'] = strval($fv['year_achieve']) + strval($res[$fk]['day_pay']);//本年业绩
                    $flagInfo[$fk]['branch_gouls'] = $flagInfo[$fk]['year_achieve']/$branchgoals['insurance_target']*100 .'%';//机构目标
                }
                $this->assign('branchInfo',$flagInfo);
                $this->assign('branch_id',$branch_shop_number);
                $this->assign('flag_id',$flag_shop_number);
                $this->display();

            }
            //查找标准店
            else if(!empty($param['branch_shop_number']) && !empty($param['flag_shop_number'])  && !empty($param['stand_shop_number'])){//查询所在分公司下的旗舰店下的标准店首期寿险业绩
                $standModel = D('insu_stand_performance');
                //当日业绩
                //首期，保单类型-寿险-insurance_type=1，保单状态-policy_status（有效），时间-insured_date-(当天，当月，本季度，本半年，本年)，分公司代码=post获取到的分公司代码
                $res = $tmodel->where('insurance_type=1 AND policy_status=1 AND FROM_UNIXTIME(insured_date,"%Y-%m-%d")=DATE_FORMAT(NOW(),"%Y-%m-%d") AND branch_shop_number="'.$branch_shop_number.'" AND flag_shop_number="'.$flag_shop_number.'" AND standard_shop_number="'.$stand_shop_number.'"')
                    ->field('standard_shop_number,flag_shop_number,branch_shop_number,SUM(insurance_premium) as pay')//旗舰店代码，分公司代码，保险保费
                    ->group('standard_shop_number')//根据标准店分组
                    ->order('pay desc')//根据保险保费倒序排名
                    ->select();
                /*搜索标准店昨日排名业绩表*/
                $standInfo = $standModel
                    ->where('sand_id = "'.$stand_shop_number.'"')
                    ->select();
                //查找标准店的名称及规模人力
                $member = $mmodel
                    ->alias('m')
                    ->join('organization as o ON m.shop_number = o.org_code AND o.level=3','left')
                    ->field('m.shop_number,count(m.m_number) as count,o.name')
                    ->where('m.shop_number= '.$stand_shop_number)
                    ->group('o.name')
                    ->select();
                //查找当月开单人力
                $policy_mon = $tmodel
                    ->field('count( distinct salesman_number) as policy_num')
                    ->where('standard_shop_number = '.$stand_shop_number.' AND insurance_type = 1 AND policy_status=1 AND FROM_UNIXTIME(insured_date,"%Y-%m")=DATE_FORMAT(NOW(),"%Y-%m")')
                    ->select();
                //查找当季度开单人力
                $policy_quar = $tmodel
                    ->field('count( distinct salesman_number) as policy_num')
                    ->where('standard_shop_number = '.$stand_shop_number.' AND insurance_type = 1 AND policy_status=1 AND QUARTER(FROM_UNIXTIME(insured_date,"%Y-%m-%d"))=QUARTER(DATE_FORMAT(NOW(),"%Y-%m-%d"))')
                    ->select();
                //查找本半年开单人力
                $policy_half = $tmodel
                    ->field('count( distinct salesman_number) as policy_num')
                    ->where('standard_shop_number = '.$stand_shop_number.' AND insurance_type = 1 AND policy_status=1 AND if(
                                MONTH(DATE_FORMAT(NOW(),"%Y-%m-%d"))+0 <= 6,
                                YEAR(FROM_UNIXTIME(insured_date,"%Y-%m-%d"))=YEAR(DATE_FORMAT(NOW(),"%Y-%m-%d"))
                                    AND MONTH(FROM_UNIXTIME(insured_date,"%Y-%m-%d"))+0 <= 6,
                                YEAR(FROM_UNIXTIME(insured_date,"%Y-%m-%d"))=YEAR(DATE_FORMAT(NOW(),"%Y-%m-%d"))
                                    AND MONTH(FROM_UNIXTIME(insured_date,"%Y-%m-%d"))+0 >= 7
                            )')
                    ->select();
                //查找本年开单人力
                $policy_year = $tmodel
                    ->field('count( distinct salesman_number) as policy_num')
                    ->where('standard_shop_number = '.$stand_shop_number.' AND insurance_type = 1 AND policy_status=1 AND YEAR(FROM_UNIXTIME(insured_date,"%Y-%m-%d"))=YEAR(DATE_FORMAT(NOW(),"%Y-%m-%d"))')
                    ->select();
                //查找机构目标
                $branchgoals = $ogmodel
                    ->field('shop_code,insurance_target')
                    ->where('shop_code='.$stand_shop_number)
                    ->find();
                //将当日业绩同昨日统计业绩组合在一起，并把当日业绩同昨日统计业绩相加
                foreach($standInfo as $sk=>$sv){
                    $standInfo[$sk]['day_achieve'] .= strval($res[$sk]['day_pay']);  // 当日业绩
                    $standInfo[$sk]['name'] .= $member[$sk]['name'];         //分公司名称
                    $standInfo[$sk]['num_count'] .= $member[$sk]['count'];   //规模人力
                    $standInfo[$sk]['policy_mon'] .= $policy_mon[$sk]['policy_num'];//本月开单人力
                    $standInfo[$sk]['policy_quar'] .= $policy_quar[$sk]['policy_num'];//本季度开单人力
                    $standInfo[$sk]['policy_half'] .= $policy_half[$sk]['policy_num'];//本半年开单人力
                    $standInfo[$sk]['policy_year'] .= $policy_year[$sk]['policy_num'];//本年开单人力
                    $standInfo[$sk]['mon_achieve'] = strval($sv['mon_achieve']) + strval($res[$sk]['day_pay']); //本月业绩
                    $standInfo[$sk]['quar_achieve'] = strval($sv['quar_achieve']) + strval($res[$sk]['day_pay']);//本季度业绩
                    $standInfo[$sk]['half_achieve'] = strval($sv['half_achieve']) + strval($res[$sk]['day_pay']);//本半年业绩
                    $standInfo[$sk]['year_achieve'] = strval($sv['year_achieve']) + strval($res[$sk]['day_pay']);//本年业绩
                    $standInfo[$sk]['branch_gouls'] = $standInfo[$sk]['year_achieve']/$branchgoals['insurance_target']*100 .'%';//机构目标
                }
                $this->assign('branchInfo',$standInfo);
                $this->assign('branch_id',$branch_shop_number);
                $this->assign('flag_id',$flag_shop_number);
                $this->assign('stand_id',$stand_shop_number);
                $this->display();
            }
        }else{
            //进入页面 加载机构联动菜单
            // level 门店级别 1分公司 2旗舰店 3标准店
            $shop =  shopMenu(1);
            $this->assign('shop',$shop);
            $this->display();
        }
    }

    //异步机构联动菜单请求
    public function branchAjax() {
        $bid=I('post.branchid');                   //分公司id
        $fid=I('post.flagid');                   //旗舰店id
        $level=I('post.level');                   //等级
        $string=I('post.string');                   //描述
        $data=shopMenu($level,$bid,$fid);
        if($level == 2){
            $shopname = 'flagship_code';
        }elseif($level == 3){
            $shopname = 'org_code';
        }
        if($data){
            $str='<option value="">请选择'.$string.'</option>';
            foreach ($data as $k => $v) {
                $str=$str.'<option value="'.$v[$shopname].'">'.$v["name"].'</option>';
            }
            echo $str;
        }
    }
}