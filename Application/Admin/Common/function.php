<?php


/**
 * 读取session中用户名称
 * @return [type] [description]
 */
function get_username(){
    return $_SESSION['username'];
}

/*截取字符*/
function get_string($str,$string){
    $lenth = $string;
    $sub = mb_substr($str,0,$lenth,'utf-8');
    if(strlen($str)>$lenth){
        $sub = $sub.'...';
    }
    return $sub;
}

//获取地址联动
function GetCity($pid=0) {
    $region_db=M('district');
    $where['parent_id']=$pid;
    $data=$region_db->where($where)->select();
    return $data;
}

//获取地址联动
function GetCityName($id) {

    $region_db=M('district');
    $where['id']=$id;
    $data=$region_db->where($where)->field('name')->find();
    return $data['name'];
}

/**
+----------------------------------------------------------
 * 产生随机字串，可用来自动生成密码
 * 默认长度6位 字母和数字混合 支持中文
+----------------------------------------------------------
 * @param string $len 长度
 * @param string $type 字串类型
 * 0 字母 1 数字 其它 混合
 * @param string $addChars 额外字符
+----------------------------------------------------------
 * @return string
+----------------------------------------------------------
 */
function rand_string($len = 6, $type = '', $addChars = '') {
    $str = '';
    switch ($type) {
        case 0 :
            $chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz' . $addChars;
            break;
        case 1 :
            $chars = str_repeat('0123456789', 3);
            break;
        case 2 :
            $chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' . $addChars;
            break;
        case 3 :
            $chars = 'abcdefghijklmnopqrstuvwxyz' . $addChars;
            break;
        default :
            // 默认去掉了容易混淆的字符oOLl和数字01，要添加请使用addChars参数
            $chars = 'ABCDEFGHIJKMNPQRSTUVWXYZabcdefghijkmnpqrstuvwxyz23456789' . $addChars;
            break;
    }
    if ($len > 10) {//位数过长重复字符串一定次数
        $chars = $type == 1 ? str_repeat($chars, $len) : str_repeat($chars, 5);
    }
    if ($type != 4) {
        $chars = str_shuffle($chars);
        $str = substr($chars, 0, $len);
    } else {
        // 中文随机字
        for ($i = 0; $i < $len; $i++) {
            $str .= msubstr($chars, floor(mt_rand(0, mb_strlen($chars, 'utf-8') - 1)), 1);
        }
    }
    return $str;
}


/*
*  功能：图片上传类
*  时间：2017-05-12
*  作者：赵浙豫
*/
//上传图片方法
function upload($savePath){
    if (!empty($_FILES)) {
        $upload = new \Think\Upload();// 实例化上传类
        $upload->maxSize   =     3145728 ;// 设置附件上传大小30MB
        $upload->exts      =     array('jpg', 'gif', 'png', 'jpeg');// 设置附件上传类型
        $upload->rootPath = './Upload/'; //根目录，默认./即可
        $upload->savePath = $savePath.'/'; //子目录, 可为空

        $upload->autoSub = TRUE; //是否自动生成二级子目录
        $upload->subName = array('date','Ymd'); //子目录规则

        // 上传文件
        $info   =   $upload->upload();//uploadOne
        if(!$info) {// 上传错误提示错误信息
            //$this->error($upload->getError());
        }else{// 上传成功
            foreach($info as $file){
                $path = '/Upload/'.$file['savepath'].$file['savename'];
                //上传到远程服务器
                $remote = remote_upload_img($path);
                if($remote){
                    $path = $remote;
                }
                $imgpath[$file['key']] = $path;
            }
            $response = array(
                'filePath'=>$imgpath['file'],
            );
            die(json_encode($response));
//            return json_encode($response);
        }
    }
}
//上传文件方法
function upload_file($savePath){
    if (!empty($_FILES)) {
        $upload = new \Think\Upload();// 实例化上传类
        $upload->maxSize   =     5242880 ;// 设置附件上传大小50MB
        $upload->exts      =     array('pdf','doc','docx');// 设置附件上传类型
        $upload->rootPath = './Upload/'; //根目录，默认./即可
        $upload->savePath = $savePath.'/'; //子目录, 可为空
        $upload->autoSub = TRUE; //是否自动生成二级子目录
        $upload->subName = array('date','Ymd'); //子目录规则
        // 上传文件
        $info   =   $upload->upload();//uploadOne
        if(!$info) {// 上传错误提示错误信息
            //$this->error($upload->getError());
        }else{// 上传成功
            foreach($info as $file){
                $path = '/Upload/'.$file['savepath'].$file['savename'];
                //上传到远程服务器
                $remote = remote_upload_img($path);
                if($remote){
                    $path = $remote;
                }
                $file[$file['key']] = $path;
            }
            /*$response = array(
                'filePath'=>$imgpath['file'],
            );*/
            return $file['file-2'];
           /* print_r($imgpath);die;
            die(json_encode($response));*/
//            return json_encode($response);
        }
    }
}
function remote_upload_img($path){
    $content = file_get_contents($path);
    if(!$path || !$content){
        return false;
    }
    $base64 = base64_encode($content);
    $uploadUrl = C('UPLOAD_IMAGE_URL').'/api/base64Upload';
    $data['image'] = $base64;
    $return = get_curl_info($uploadUrl, $data);
    if(!$return){
        return false;
    }
    $return = json_decode($return, true);
    if(is_array($return) && isset($return['code']) && $return['code'] == 1000){
        return $return['url'];
    }else{
        return false;
    }
    exit;

    $ch = curl_init();
    $path = dirname(dirname(dirname(dirname(__FILE__)))).DIRECTORY_SEPARATOR.$path;
    //加@符号curl就会把它当成是文件上传处理
    $data = array('img'=>'@'.$path);

    curl_setopt($ch,CURLOPT_URL,C('UPLOAD_IMAGE_URL'));
    curl_setopt($ch,CURLOPT_RETURNTRANSFER,true);
    curl_setopt($ch,CURLOPT_POST,true);
    curl_setopt($ch,CURLOPT_POSTFIELDS,$data);
    $result = curl_exec($ch);
    curl_close($ch);
    $result = json_decode($result, true);
    if(is_array($result) && isset($result['code']) && $result['code'] == 1000){
        return $result['url'];
    }else{
        return false;
    }
}
//curl获取外网信息
function get_curl_info($uri, $data = ''){
    $curl = curl_init();
    curl_setopt($curl, CURLOPT_URL, $uri);
    curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, FALSE);
    curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, FALSE);
    curl_setopt($curl, CURLOPT_POST, 1);
    curl_setopt($curl, CURLOPT_POSTFIELDS, $data);
    curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
    $result = curl_exec($curl);
    if (curl_errno($curl)) {
        return 'Errno' . curl_error($curl);
    }
    curl_close($curl);
    return $result;
   }

//返回地区分类
//$id 所属省id
function get_address_cate($id){
	$result=M('district_cate')->where('id='.$id)->getField('hot');
	return $result;
}
/*
*  功能：获取机构店铺名称
*  时间：2017-05-12
*  作者：lzt
*/
function GetStoreName($number,$level) {
    $region_db=M('organization');
    $where['org_code']=$number;
    $where['level']=$level;
    $data=$region_db->where($where)->field('name')->find();
    return $data['name'];
}
/*
*  功能：获取会员名称
*  时间：2017-05-12
*  作者：lzt
*/
function GetMemberName($number) {
    $region_db=M('member');
    $where['m_number']=$number;
    $data=$region_db->where($where)->field('name')->find();
    return $data['name'];
}
/**获取两个时间相差的月数
 * @author iyting <[<email address>]>
 * @param  [string] $date1 [结束时间 2017-5-1]
 * @param  [string] $date2 [开始时间 2017-4-1]
 * @param  string $tags  [分割符]
 * @return [int]        [相差的月数]
 */
function getMonthNum( $date1, $date2, $tags='-'){
      $time1 = strtotime($date1);
      $time2 = strtotime($date2);
      $date1 = explode($tags,$date1);
      $date2 = explode($tags,$date2);
      $months =abs($date1[0]-$date2[0])*12;
      if($time1 > $time2){
        return $months+$date1[1]-$date2[1];
      }else{
        return -($months+$date2[1]-$date1[1]);
      }
 }

/**
 * 生成pdf
 * @param  string $html      需要生成的内容
 */

function pdf($html){
//    p($html);die;
    vendor('Tcpdf.tcpdf');
//    $pdf = new \Tcpdf(PDF_PAGE_ORIENTATION, PDF_UNIT, PDF_PAGE_FORMAT, true, 'UTF-8', false);
    $pdf = new \Tcpdf('P', 'mm', 'A4', true, 'UTF-8', false);
    // 设置打印模式,设置文档信息
    $pdf->SetCreator(PDF_CREATOR);
    $pdf->SetAuthor('Nicola Asuni');
    $pdf->SetTitle('Examination result(考试结果)');
    $pdf->SetSubject('TCPDF Tutorial');
    $pdf->SetKeywords('TCPDF, PDF, PHP, example, test, guide');
    // 是否显示页眉和是否显示页脚
    $pdf->setPrintHeader(false);
    $pdf->setPrintFooter(true);
    // 设置页眉和页脚信息内容
    $pdf->SetHeaderData('logo.jpg', 40, 'Helloweba.com', '小白测试', array(0,64,255), array(0,64,128));
    $pdf->setFooterData(array(0,64,0), array(0,64,128));
    // 设置页眉和页脚字体
    $pdf->setHeaderFont(Array('dejavusans', '', '12'));
    $pdf->setFooterFont(Array('dejavusans', '', '10'));
    // 设置间距
    $pdf->SetHeaderMargin('5');
    $pdf->SetFooterMargin('10');
    // 设置左、上、右的间距
    $pdf->SetMargins('10', '10', '10');
    // 设置是否自动分页  距离底部多少距离时分页
    $pdf->SetAutoPageBreak(TRUE, '15');
    // 设置默认等宽字体
    $pdf->SetDefaultMonospacedFont('courier');
//    $pdf->SetDefaultMonospacedFont(PDF_FONT_MONOSPACED);
    // 设置行高
    $pdf->setCellHeightRatio(1);

    // 设置图像比例因子
    $pdf->setImageScale(1.25);
    /*$pdf->setImageScale(PDF_IMAGE_SCALE_RATIO);
    if (@file_exists(dirname(__FILE__).'/lang/eng.php')) {
        require_once(dirname(__FILE__).'/lang/eng.php');
        $pdf->setLanguageArray($l);
    }*/
    //设置默认字体子集模式
    $pdf->setFontSubsetting(true);
    // 设置字体
    $pdf->SetFont('stsongstdlight', '', 14, '', true);
    $pdf->AddPage();

//    $pdf->Write(0,$html,'', 0, 'L', true, 0, false, false, 0);
    $pdf->writeHTMLCell(0, 0, '', '', $html, 0, 1, 0, true, '', true);

    $pdf->Output(rand_string('9').'.pdf', 'I');
}

function getMenuList($act_list){
    //根据角色权限过滤菜单
    $menu_list = getAllMenu();
    if($act_list != 'all'){
        $right = M('manager_auth_node')->where("id in ($act_list)")->cache(true)->getField('authcode',true);
        foreach ($right as $val){
            $role_right .= $val.',';
        }
        $role_right = explode(',', $role_right);        
        foreach($menu_list as $k=>$mrr){
            foreach ($mrr['sub_menu'] as $j=>$v){
                if(!in_array($v['control'].'Controller@'.$v['act'], $role_right)){
                    unset($menu_list[$k]['sub_menu'][$j]);//过滤菜单
                }
            }
        }
    }
    return $menu_list;
}

function getAllMenu(){
    return  array(
         'Supplier' => array('name' => '供应商管理', 'icon'=>'Hui-iconfont', 'sub_menu' => array(
                    array('name' => '供应商管理', 'act'=>'index', 'control'=>'Supplier'),
            )),
           'Agreement' => array('name' => '协议管理', 'icon'=>'Hui-iconfont', 'sub_menu' => array(
                    array('name' => '协议录入', 'act'=>'index', 'control'=>'Agreement'),
            )),
           'Order' => array('name' => '订单管理', 'icon'=>'Hui-iconfont', 'sub_menu' => array(
                    array('name' => '协议录入', 'act'=>'index', 'control'=>'Order'),
            )),
            'Insurance' => array('name'=>'保单管理','icon'=>'Hui-iconfont','sub_menu'=>array(
                    array('name'=>'首期保单管理','act'=>'index','control'=>'Insurance'),
                    array('name'=>'续期保单管理','act'=>'index','control'=>'InsuranceRe'),
                 array('name'=>'首期保单导出','act'=>'index','control'=>'InsuranceExcel'),
                  array('name'=>'续期保单导出','act'=>'index','control'=>'InsuranceReExcel'),
                   array('name'=>'续期保单报表导出','act'=>'index','control'=>'InsuranceReReport'),
                  
            )),
           
            'Client' => array('name'=>'客户管理','icon'=>'fa-user','sub_menu'=>array(
                    array('name'=>'客户管理','act'=>'index','control'=>'Client'),
            )),
            'EarlyWarning' => array('name' => '考核预警管理', 'icon'=>'fa-book', 'sub_menu' => array(
                    array('name' => '考核预警管理', 'act'=>'index', 'control'=>'EarlyWarning'),
                    array('name' => '考核结果-筹备期', 'act'=>'check_result_prepara', 'control'=>'EarlyWarning'),
                    array('name' => '考核结果-经营期', 'act'=>'check_result_business', 'control'=>'EarlyWarning'),
                    array('name' => '分公司考核结果查询', 'act' =>'check_branch_result', 'control' => 'EarlyWarning'),
            )),
            'Product' => array('name' => '产品管理', 'icon'=>'fa-money', 'sub_menu' => array(
                    array('name' => '产品列表', 'act'=>'index', 'control'=>'Product'),
                    array('name' => '产品销售分类列表', 'act'=>'index', 'control'=>'ProductType'),
                    array('name' => '产品非销售分类列表', 'act'=>'index', 'control'=>'ProductUnsales'),
                    array('name' => '产品报表', 'act'=>'index', 'control'=>'ProductSurface'),
                    
            )),
            'ServiceQuestions' => array('name' => '服务中心', 'icon'=>'fa-bell', 'sub_menu' => array(
                    array('name' => '题库设置', 'act'=>'index', 'control'=>'ServiceQuestions'),
                    array('name' => '考试结果', 'act'=>'test_result', 'control'=>'ServiceQuestions'),
                    array('name' => '学习课堂', 'act'=>'index', 'control'=>'ReleaseAudit'),
                    array('name' => '课堂审核', 'act'=>'index', 'control'=>'LearningClassroom'),
                    array('name' => '常见问题','act'=>'index', 'control'=>'CommonProblem'),
                    array('name' => '留言处理','act'=>'index', 'control'=>'MessageProcessing'),
            )),
            'Organ' => array('name' => '机构管理', 'icon'=>'fa-flag', 'sub_menu' => array(
                    array('name' => '店铺申请', 'act'=>'apply', 'control'=>'Organ'),
                    array('name' => '机构列表', 'act'=>'index', 'control'=>'Organ'),
                    array('name' => '机构目标管理', 'act'=>'targe', 'control'=>'Organ'),
                    array('name' => '保监资料报送', 'act'=>'submitted', 'control'=>'Organ'),
            )),
            'Member' => array('name' => '会员管理', 'icon'=>'fa-comments', 'sub_menu' => array(
                    array('name' => '会员列表', 'act'=>'index', 'control'=>'Member'),
                    array('name' => '会员异动', 'act'=>'index', 'control'=>'MemChange'),
                    array('name' => '服务费计算', 'act'=>'MemSerFee', 'control'=>'index'),
                    array('name' => '积分管理', 'act'=>'topicList', 'control'=>'Topic'),
                    array('name' => '服务费配置', 'act'=>'index', 'control'=>'ServiceConfig'),
                    array('name' => '服务费查询', 'act'=>'select', 'control'=>'ServiceConfig'),
            )),
            'SetAuth' => array('name' => '管理员管理', 'icon'=>'fa-weixin', 'sub_menu' => array(
                    array('name' => '权限管理', 'act'=>'permission', 'control'=>'SetAuth'),
                    array('name' => '角色管理', 'act'=>'role', 'control'=>'SetAuth'),
                    array('name' => '管理员列表', 'act'=>'adminlist', 'control'=>'SetAuth'),
            )),
            'SettleAccount' => array('name' => '结算系统', 'icon'=>'fa-adjust', 'sub_menu' => array(
                    array('name' => '结算列表', 'act'=>'index', 'control'=>'SettleAccount'),
                  
            )),

            'Performance' => array('name' => '业绩管理', 'icon'=>'fa-plug', 'sub_menu' => array(
                    array('name' => '团队业绩管理', 'act'=>'teamCore', 'control'=>'Performance'),
                    array('name' => '个人业绩', 'act'=>'index', 'control'=>'PersonalPerformance'),
            )),
            'Systemcheck' => array('name' => '系统管理', 'icon'=>'fa-signal', 'sub_menu' => array(
                    array('name' => '考核设置', 'act'=>'index', 'control'=>'Systemcheck'),
                    array('name' => '品质系数', 'act'=>'index', 'control'=>'Continuous'),
                    array('name' => '系统时间设置', 'act'=>'index', 'control'=>'SystemTimeSetting'),
                    array('name' => '广告管理', 'act'=>'index', 'control'=>'Advertisement'),
            )),
            'AddDeductions' => array('name' => '导入管理', 'icon'=>'fa-anchor', 'sub_menu' => array(
                    array('name' => '新契约品质系数导入', 'act'=>'index', 'control'=>'NewContract'),
                    array('name' => '首期保单导入', 'act'=>'index', 'control'=>'InsuranceInput'),
                    array('name' => '续期保单导入', 'act'=>'index', 'control'=>'InsuranceInputRe'),
                    array('name' => '加扣款导入', 'act'=>'index', 'control'=>'AddDeductions'),
            ))
    );
}