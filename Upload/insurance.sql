/*
Navicat MySQL Data Transfer

Source Server         : 保险
Source Server Version : 50718
Source Host           : 10.0.2.16:3306
Source Database       : insurance

Target Server Type    : MYSQL
Target Server Version : 50718
File Encoding         : 65001

Date: 2017-06-02 15:21:13
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for add_deductions
-- ----------------------------
DROP TABLE IF EXISTS `add_deductions`;
CREATE TABLE `add_deductions` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `salesman_number` varchar(10) DEFAULT NULL COMMENT '业务员代码',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `state` tinyint(1) DEFAULT NULL COMMENT '状态 0=》加款 1=》扣款',
  `condition` tinyint(1) DEFAULT NULL COMMENT '失效状态 0=》失效 1=》有效',
  `money` float(10,2) DEFAULT NULL COMMENT '加扣款金额',
  `add_time` int(10) DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COMMENT='邱位鹏 其他加扣款表';

-- ----------------------------
-- Table structure for at_item
-- ----------------------------
DROP TABLE IF EXISTS `at_item`;
CREATE TABLE `at_item` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL COMMENT '广告名称',
  `type` varchar(50) DEFAULT NULL COMMENT '广告类别',
  `link` varchar(255) DEFAULT NULL COMMENT '广告链接',
  `logo` varchar(255) DEFAULT NULL COMMENT '广告图片',
  `start_time` date DEFAULT NULL COMMENT '广告开始时间',
  `end_time` date DEFAULT NULL COMMENT '广告结束时间',
  `content` text NOT NULL COMMENT '广告内容',
  `status` tinyint(1) DEFAULT '1' COMMENT '1=显示 2=不显示 -1=删除',
  `manager_id` int(10) DEFAULT NULL COMMENT '管理员ID',
  `create_time` int(10) DEFAULT NULL COMMENT '创建时间',
  `last_update_time` int(10) DEFAULT NULL COMMENT '最后修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='广告表(赵)';

-- ----------------------------
-- Table structure for cash_audit
-- ----------------------------
DROP TABLE IF EXISTS `cash_audit`;
CREATE TABLE `cash_audit` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `m_number` int(10) NOT NULL,
  `money` decimal(10,2) DEFAULT NULL COMMENT '提现金额',
  `bank_card` char(20) DEFAULT NULL COMMENT '提现账号',
  `status` tinyint(1) DEFAULT NULL COMMENT '提现状态 1=>提现中  2=>提现成功',
  `time` int(11) NOT NULL COMMENT '提现时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员提现审核表（卢）';

-- ----------------------------
-- Table structure for cash_log
-- ----------------------------
DROP TABLE IF EXISTS `cash_log`;
CREATE TABLE `cash_log` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `m_number` int(10) NOT NULL COMMENT '会员代码',
  `money` decimal(10,2) DEFAULT NULL COMMENT '金额',
  `note` varchar(255) DEFAULT NULL COMMENT '备注',
  `status` tinyint(1) DEFAULT NULL COMMENT '提现状态 1=>进账  2=>出账',
  `time` int(11) NOT NULL COMMENT '提现时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员资金日志表（卢）';

-- ----------------------------
-- Table structure for check_manpower_quota
-- ----------------------------
DROP TABLE IF EXISTS `check_manpower_quota`;
CREATE TABLE `check_manpower_quota` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '考核人力指标表主键id',
  `shop_number` int(10) unsigned NOT NULL COMMENT '店铺代码',
  `recommend_member` smallint(5) unsigned NOT NULL COMMENT '直接推荐人',
  `sub_manpower` smallint(5) unsigned NOT NULL COMMENT '所辖人力',
  `direct_recom_shop` smallint(5) unsigned NOT NULL COMMENT '直接推荐标准店',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='考核人力指标表 王志强';

-- ----------------------------
-- Table structure for check_warning
-- ----------------------------
DROP TABLE IF EXISTS `check_warning`;
CREATE TABLE `check_warning` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '考核表主键id',
  `shop_name` varchar(255) DEFAULT NULL COMMENT '店铺名称',
  `shop_number` varchar(255) NOT NULL COMMENT '考核店铺代码',
  `check_type` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '考核信息分类 0=>预警 1=>考核结果',
  `shop_type` tinyint(4) unsigned NOT NULL COMMENT '门店级别 1分公司 2旗舰店 3标准店',
  `shop_stage` tinyint(3) DEFAULT NULL COMMENT '店铺阶段  1=经营期 0=筹备期 -1=观察期',
  `branch_shop_number` varchar(255) NOT NULL COMMENT '所属分公司代码',
  `flagship_number` varchar(255) DEFAULT NULL COMMENT '所属旗舰店店铺',
  `recommend_member_id` int(10) unsigned DEFAULT NULL COMMENT '所属推荐人代码',
  `sub_manpower` smallint(5) unsigned DEFAULT NULL COMMENT '所辖人力目标',
  `sub_manpower_reached` smallint(6) DEFAULT NULL COMMENT '所辖人力达成数',
  `sub_manpower_gap` smallint(6) DEFAULT NULL COMMENT '所辖人力差距',
  `direct_recom_shop` smallint(5) unsigned DEFAULT NULL COMMENT '直接推荐标准店目标',
  `direct_recom_shop_reached` smallint(6) DEFAULT NULL COMMENT '直接推荐标准店达成数量',
  `direct_recom_shop_gap` smallint(6) DEFAULT NULL COMMENT '直接推荐标准店差距',
  `direct_recom_people` smallint(5) DEFAULT NULL COMMENT '直接推荐人目标',
  `direct_recom_people_reached` smallint(6) DEFAULT NULL COMMENT '直接推荐人达成人数',
  `direct_recom_people_gap` smallint(6) DEFAULT NULL COMMENT '直接推荐人差距',
  `achievement_target` decimal(10,2) unsigned DEFAULT NULL COMMENT '业绩指标',
  `achievement_target_reached` decimal(10,2) DEFAULT NULL COMMENT '业绩指标达成数',
  `achievement_target_gap` decimal(10,2) DEFAULT NULL,
  `continuation_rate` decimal(3,2) unsigned DEFAULT NULL COMMENT '继续率指标',
  `continuation_rate_rea` decimal(3,2) unsigned DEFAULT NULL COMMENT '继续率指标达成半分比',
  `continuation_rate_gap` decimal(3,2) DEFAULT NULL COMMENT '继续率差距',
  `check_status` tinyint(3) unsigned DEFAULT NULL COMMENT '考核结果是否成功 1=>成功 0=>失败',
  `check_time` int(11) DEFAULT NULL,
  `create_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1187 DEFAULT CHARSET=utf8 COMMENT='考核预警表 王志强';

-- ----------------------------
-- Table structure for client
-- ----------------------------
DROP TABLE IF EXISTS `client`;
CREATE TABLE `client` (
  `c_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `c_name` varchar(50) NOT NULL COMMENT '客户名称',
  `sex` tinyint(1) NOT NULL COMMENT '1男2女',
  `birthday` varchar(50) NOT NULL,
  `document_type` tinyint(1) NOT NULL COMMENT '证件类型 1身份证 2护照',
  `document_number` char(20) NOT NULL COMMENT '证件号码',
  `marital_status` int(11) NOT NULL COMMENT '婚姻状况 1已婚 2未婚',
  `work_unit` varchar(100) NOT NULL COMMENT '工作单位',
  `branch_office` int(11) NOT NULL COMMENT '所属分公司代码',
  `sales_code` int(11) NOT NULL COMMENT '所属业务员代码',
  `phone` varchar(20) NOT NULL COMMENT '手机号',
  `email` varchar(100) NOT NULL COMMENT '邮箱',
  `zip_code` int(11) NOT NULL COMMENT '邮编',
  `address` varchar(200) NOT NULL COMMENT '详细地址',
  `bank_name` varchar(50) NOT NULL COMMENT '银行名称',
  `bank_account` char(25) NOT NULL COMMENT '银行账号',
  `cu_category` int(11) NOT NULL COMMENT '客户类别 1意向 2成交',
  `explain` varchar(255) NOT NULL COMMENT '保险购买情况说明',
  PRIMARY KEY (`c_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='客户表（景）';

-- ----------------------------
-- Table structure for coefficient_continuous
-- ----------------------------
DROP TABLE IF EXISTS `coefficient_continuous`;
CREATE TABLE `coefficient_continuous` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mincontinues` float(11,2) NOT NULL COMMENT '13个月继续率最小值',
  `maxcontinues` float(11,2) NOT NULL COMMENT '13个月继续率最大值',
  `coefficient` float(11,2) NOT NULL COMMENT '续期品质系数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='13个月续期品质系数表（景）';

-- ----------------------------
-- Table structure for district
-- ----------------------------
DROP TABLE IF EXISTS `district`;
CREATE TABLE `district` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '名称',
  `parent_id` int(10) unsigned DEFAULT '0' COMMENT '上级地区ID',
  `path` varchar(255) DEFAULT NULL COMMENT ' 路径',
  `level` tinyint(3) unsigned DEFAULT '0' COMMENT '地区等级：1，省级；2，市级；3，县级；4，乡镇',
  `display_order` smallint(6) unsigned DEFAULT '0' COMMENT '显示顺序',
  `pinyin` varchar(255) DEFAULT NULL COMMENT '拼音',
  `used` tinyint(1) DEFAULT '0' COMMENT '1=使用 0=不使用',
  `hot` smallint(6) DEFAULT '0' COMMENT '热门城市 0=非热门 大于0热门',
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3300 DEFAULT CHARSET=utf8 COMMENT='地区表---赵';

-- ----------------------------
-- Table structure for district_cate
-- ----------------------------
DROP TABLE IF EXISTS `district_cate`;
CREATE TABLE `district_cate` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '名称',
  `parent_id` int(10) unsigned DEFAULT '0' COMMENT '上级地区ID',
  `path` varchar(255) DEFAULT NULL COMMENT ' 路径',
  `level` tinyint(3) unsigned DEFAULT '0' COMMENT '地区等级：1，省级；2，市级；3，县级；4，乡镇',
  `display_order` smallint(6) unsigned DEFAULT '0' COMMENT '显示顺序',
  `pinyin` varchar(255) DEFAULT NULL COMMENT '拼音',
  `used` tinyint(1) DEFAULT '0' COMMENT '1=使用 0=不使用',
  `hot` char(1) NOT NULL DEFAULT '0' COMMENT '城市分类 1 A 2B 3C',
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3243 DEFAULT CHARSET=utf8 COMMENT='地区分类表---景';

-- ----------------------------
-- Table structure for favorite
-- ----------------------------
DROP TABLE IF EXISTS `favorite`;
CREATE TABLE `favorite` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `m_number` int(10) NOT NULL COMMENT '会员代码',
  `product_id` int(10) NOT NULL COMMENT '产品ID',
  `time` int(11) NOT NULL COMMENT '时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员收藏表（卢）';

-- ----------------------------
-- Table structure for initial_contract_ratio
-- ----------------------------
DROP TABLE IF EXISTS `initial_contract_ratio`;
CREATE TABLE `initial_contract_ratio` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `product_id` int(11) NOT NULL COMMENT '产品id',
  `payment_period` int(11) NOT NULL COMMENT '缴费年期(5年填5，十年填10)',
  `scale` float(4,2) NOT NULL COMMENT '首期签约比例',
  `add_time` int(11) NOT NULL COMMENT '添加时间，默认时间戳格式',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='首期签约比例表 李杨';

-- ----------------------------
-- Table structure for insu_branch_performance
-- ----------------------------
DROP TABLE IF EXISTS `insu_branch_performance`;
CREATE TABLE `insu_branch_performance` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `branch_id` varchar(11) NOT NULL COMMENT '分公司代码',
  `mon_achieve` decimal(20,2) unsigned DEFAULT '0.00' COMMENT '本月业绩',
  `quar_achieve` decimal(20,2) unsigned DEFAULT '0.00' COMMENT '本季度业绩',
  `half_achieve` decimal(20,2) unsigned DEFAULT '0.00' COMMENT '本半年业绩',
  `year_achieve` decimal(20,2) unsigned DEFAULT '0.00' COMMENT '本年业绩',
  `mon_ranking` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '月度排名',
  `quar_ranking` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '季度排名',
  `half_ranking` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '本半年排名',
  `year_ranking` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '年度排名',
  `ranking_type` int(2) unsigned NOT NULL DEFAULT '1' COMMENT '排名类型  1=>寿险 2=>非寿险 3=>非寿不含车险',
  `ranking_time` int(11) NOT NULL DEFAULT '0' COMMENT '排名时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `branch_id` (`branch_id`) COMMENT '分公司ID唯一索引'
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8 COMMENT='lzj-分公司业绩排名表';

-- ----------------------------
-- Table structure for insu_flag_performance
-- ----------------------------
DROP TABLE IF EXISTS `insu_flag_performance`;
CREATE TABLE `insu_flag_performance` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `flag_id` varchar(11) NOT NULL DEFAULT '0' COMMENT '旗舰店ID',
  `mon_achieve` decimal(20,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '本月业绩',
  `quar_achieve` decimal(20,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '本季度业绩',
  `half_achieve` decimal(20,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '本半年业绩',
  `year_achieve` decimal(20,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '本年业绩',
  `mon_ranking` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '月度排名',
  `quar_ranking` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '季度排名',
  `half_ranking` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '本半年排名',
  `year_ranking` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '年度排名',
  `ranking_type` int(2) unsigned NOT NULL DEFAULT '1' COMMENT '排名类型  1=>寿险 2=>非寿险 3=>非寿不含车险',
  `ranking_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '排名时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `flag_id` (`flag_id`) COMMENT '旗舰店ID唯一索引'
) ENGINE=InnoDB AUTO_INCREMENT=137 DEFAULT CHARSET=utf8 COMMENT='lzj-旗舰店业绩排名表';

-- ----------------------------
-- Table structure for insu_mem_performance
-- ----------------------------
DROP TABLE IF EXISTS `insu_mem_performance`;
CREATE TABLE `insu_mem_performance` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `member_id` varchar(11) NOT NULL COMMENT '业务员编码',
  `mon_sum` int(10) NOT NULL DEFAULT '0' COMMENT '本月件数',
  `mon_achieve` decimal(20,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '本月业绩',
  `quar_sum` int(10) DEFAULT '0' COMMENT '本季度件数',
  `quar_achieve` decimal(20,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '本季度业绩',
  `half_sum` int(10) DEFAULT '0' COMMENT '本半年件数',
  `half_achieve` decimal(20,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '本半年业绩',
  `year_sum` int(10) DEFAULT '0' COMMENT '本年件数',
  `year_achieve` decimal(20,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '本年业绩',
  `mon_ranking` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '月度排名',
  `quar_ranking` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '季度排名',
  `half_ranking` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '本半年排名',
  `year_ranking` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '年度排名',
  `ranking_type` int(2) unsigned NOT NULL DEFAULT '1' COMMENT '排名类型 1=>寿险 2=>非寿险 3=>非寿不含车险',
  `ranking_time` int(11) NOT NULL DEFAULT '0' COMMENT '排名时间',
  PRIMARY KEY (`id`),
  KEY `member_id` (`member_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3706 DEFAULT CHARSET=utf8 COMMENT='lzj-会员业绩排名表';

-- ----------------------------
-- Table structure for insu_message
-- ----------------------------
DROP TABLE IF EXISTS `insu_message`;
CREATE TABLE `insu_message` (
  `notify_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '消息表ID',
  `to_member_id` int(10) unsigned NOT NULL COMMENT '发件人ID',
  `rec_id` int(10) unsigned NOT NULL COMMENT '收件人ID',
  `send_time` int(11) NOT NULL DEFAULT '0' COMMENT '发送时间',
  `text_id` int(11) NOT NULL COMMENT '站内信内容表ID',
  `status` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '消息读取状态',
  `type_message` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '信息类型（1 系统发送 2人工发送）',
  `send_way` tinyint(1) unsigned DEFAULT '0' COMMENT '发送方式（1 短信 2站内信）',
  PRIMARY KEY (`notify_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='lzj-站内信消息表';

-- ----------------------------
-- Table structure for insu_message_text
-- ----------------------------
DROP TABLE IF EXISTS `insu_message_text`;
CREATE TABLE `insu_message_text` (
  `text_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '内容表ＩＤ',
  `text_title` varchar(255) NOT NULL DEFAULT '' COMMENT '消息标题',
  `text_content` varchar(255) NOT NULL DEFAULT '' COMMENT '消息内容',
  `add_time` int(11) NOT NULL DEFAULT '0' COMMENT '添加时间',
  PRIMARY KEY (`text_id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COMMENT='lzj-站内消息内容表';

-- ----------------------------
-- Table structure for insu_rules
-- ----------------------------
DROP TABLE IF EXISTS `insu_rules`;
CREATE TABLE `insu_rules` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '规则Id',
  `product_id` int(11) NOT NULL COMMENT '产品Id',
  `insurance_tips` varchar(255) NOT NULL COMMENT '投保提示',
  `claim_tips` varchar(255) NOT NULL COMMENT '理赔额提示',
  `clause_reading` text NOT NULL COMMENT '条款阅读',
  `classic_case` text COMMENT '典型案例',
  `create_time` int(11) NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='产品投保规则\r\n李杨';

-- ----------------------------
-- Table structure for insu_stand_performance
-- ----------------------------
DROP TABLE IF EXISTS `insu_stand_performance`;
CREATE TABLE `insu_stand_performance` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `sand_id` varchar(10) NOT NULL COMMENT '店铺代码',
  `mon_achieve` decimal(20,2) unsigned DEFAULT '0.00' COMMENT '本月业绩',
  `quar_achieve` decimal(20,2) unsigned DEFAULT '0.00' COMMENT '本季度业绩',
  `half_achieve` decimal(20,2) unsigned DEFAULT '0.00' COMMENT '本半年业绩',
  `year_achieve` decimal(20,2) unsigned DEFAULT '0.00' COMMENT '本年业绩',
  `mon_ranking` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '月度排名',
  `quar_ranking` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '季度排名',
  `half_ranking` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '本半年排名',
  `year_ranking` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '年度排名',
  `ranking_type` tinyint(2) unsigned NOT NULL DEFAULT '1' COMMENT '排名类型  1=>寿险 2=>非寿险 3=>非寿不含车险',
  `ranking_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '排名时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sand_id` (`sand_id`) COMMENT '旗舰店ID唯一索引'
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8 COMMENT='lzj-标准店业绩排名表';

-- ----------------------------
-- Table structure for insu_sys_message
-- ----------------------------
DROP TABLE IF EXISTS `insu_sys_message`;
CREATE TABLE `insu_sys_message` (
  `sys_id` int(10) unsigned NOT NULL COMMENT '消息关系主键ID',
  `rec_id` int(10) unsigned NOT NULL COMMENT '收件人ID',
  `notify_id` int(10) unsigned NOT NULL COMMENT '消息表ID',
  `status` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '消息状态',
  PRIMARY KEY (`sys_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='lzj-会员消息关系表';

-- ----------------------------
-- Table structure for insurance
-- ----------------------------
DROP TABLE IF EXISTS `insurance`;
CREATE TABLE `insurance` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `branch_shop_number` varchar(10) DEFAULT NULL COMMENT '分公司代码',
  `standard_shop_number` varchar(10) DEFAULT NULL COMMENT '标准店代码',
  `flag_shop_number` varchar(10) DEFAULT NULL COMMENT '旗舰店',
  `salesman_number` varchar(11) DEFAULT NULL COMMENT '业务员代码=会员代码',
  `salesman_name` varchar(20) DEFAULT NULL COMMENT '业务员姓名',
  `entry_date` int(11) DEFAULT NULL COMMENT '录入日期',
  `entry_name` varchar(20) DEFAULT NULL COMMENT '录入人姓名',
  `provider_id` int(11) DEFAULT NULL COMMENT '供应商id',
  `product_name` varchar(50) DEFAULT NULL COMMENT '产品名称',
  `product_id` int(11) DEFAULT NULL COMMENT '产品id',
  `provider_name` varchar(60) DEFAULT NULL COMMENT '供应商名字',
  `insured_number` int(11) DEFAULT NULL COMMENT '投保单号',
  `policy_number` int(11) NOT NULL COMMENT '保单号',
  `policy_status` tinyint(4) DEFAULT NULL COMMENT '保单状态	1=>有效	2=>失效',
  `insurance_type` tinyint(1) DEFAULT NULL COMMENT '保单类型 1=>寿险  2=>非寿险(不含车险)  3=>车险',
  `insurance_name` varchar(80) DEFAULT NULL COMMENT '险种名称',
  `insurance_status` tinyint(4) DEFAULT NULL COMMENT '1 =》主险 2=》附加险',
  `insurance_money` float(11,2) DEFAULT NULL COMMENT '保额',
  `agent_cost` float(11,2) DEFAULT NULL COMMENT '代理费用',
  `standard_money` float(11,2) DEFAULT NULL COMMENT '标准保费',
  `value_premium` float(11,2) DEFAULT NULL COMMENT '价值保费',
  `insurance_premium` float(11,2) DEFAULT NULL COMMENT '规模保费',
  `payment_method` tinyint(4) DEFAULT NULL COMMENT '缴费方式 1=》支付宝  2=》微信',
  `payment_limit` int(11) DEFAULT NULL COMMENT '缴费年限',
  `policy_holder_name` varchar(20) DEFAULT NULL COMMENT '投保人姓名',
  `policy_holder_card` int(11) DEFAULT NULL COMMENT '投保人身份证',
  `dress` varchar(100) DEFAULT NULL COMMENT '投保人联系地址',
  `town` int(5) DEFAULT NULL COMMENT '投保人乡镇',
  `city` int(5) DEFAULT NULL COMMENT '投保人城市',
  `province` int(5) DEFAULT NULL COMMENT '投保人省份',
  `policy_holder_telephone` int(11) DEFAULT NULL COMMENT '投保人电话',
  `insured_person_name` varchar(4) DEFAULT NULL COMMENT '被保人姓名',
  `insured_person_certificate` tinyint(30) DEFAULT NULL COMMENT '被保人证件类型 1=>身份证 2=》护照',
  `insured_person_card` char(18) DEFAULT NULL COMMENT '被保人证件号',
  `insured_person_telephone` int(11) DEFAULT NULL COMMENT '被保人电话',
  `insured_date` int(11) DEFAULT NULL COMMENT '承保日期',
  `insured_date_star` int(11) DEFAULT NULL COMMENT '承包生效日期',
  `add_time` int(11) DEFAULT NULL COMMENT '保单导入日期',
  `pay_date` int(11) DEFAULT NULL COMMENT '缴费日期',
  `hesitation_end_date` int(11) DEFAULT NULL COMMENT '犹豫截止日期',
  `return_date` int(11) DEFAULT NULL COMMENT '回执递交日期',
  `return_visit_date` int(11) DEFAULT NULL COMMENT '回访成功日期',
  `customer_date` int(11) DEFAULT NULL COMMENT '客户签收日期',
  `hesitate_date` int(11) DEFAULT '0' COMMENT '犹豫期退保日期',
  `surrender_date` int(11) DEFAULT '0' COMMENT '退保日期',
  `business_type` varchar(20) DEFAULT NULL COMMENT '业务类型 ',
  PRIMARY KEY (`id`),
  UNIQUE KEY `policy_number` (`policy_number`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8 COMMENT='首期保单表（邱位鹏）';

-- ----------------------------
-- Table structure for insurance_re
-- ----------------------------
DROP TABLE IF EXISTS `insurance_re`;
CREATE TABLE `insurance_re` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `branch_shop_number` int(11) DEFAULT NULL COMMENT '分公司代码',
  `standard_shop_number` int(11) DEFAULT NULL COMMENT '标准店代码',
  `flag_shop_number` int(11) DEFAULT NULL COMMENT '旗舰店',
  `salesman_number` varchar(11) DEFAULT NULL COMMENT '业务员代码',
  `salesman_name` varchar(20) DEFAULT NULL COMMENT '业务员姓名',
  `entry_date` int(11) DEFAULT NULL COMMENT '录入日期',
  `entry_name` varchar(20) DEFAULT NULL COMMENT '录入人姓名',
  `provider_id` int(11) DEFAULT NULL COMMENT '供应商id',
  `product_id` int(11) DEFAULT NULL COMMENT '产品名称',
  `product_name` varchar(50) DEFAULT NULL COMMENT '产品名称',
  `provider_name` varchar(60) DEFAULT NULL COMMENT '供应商名字',
  `insured_number` int(11) DEFAULT NULL COMMENT '投保单号',
  `policy_number` int(11) DEFAULT NULL COMMENT '保单号',
  `policy_status` tinyint(4) DEFAULT NULL COMMENT '保单状态	0=>有效	1=>无效',
  `insurance_type` tinyint(1) DEFAULT NULL COMMENT '保单类型 1=>寿险  2=>非寿险(不含车险)  3=>车险',
  `insurance_name` varchar(80) DEFAULT '' COMMENT '险种名称',
  `insurance_status` tinyint(4) DEFAULT NULL COMMENT '主险/附加险',
  `insurance_money` float(11,2) DEFAULT NULL COMMENT '保额',
  `insurance_premium` float(11,2) DEFAULT NULL COMMENT '应收规模保费',
  `real_insurance_premium` float(11,2) DEFAULT NULL COMMENT '实收规模保费',
  `payment_method` tinyint(4) DEFAULT NULL COMMENT '缴费方式',
  `payment_limit` int(11) DEFAULT NULL COMMENT '缴费年期',
  `policy_holder_name` varchar(20) DEFAULT NULL COMMENT '投保人姓名',
  `policy_holder_card` int(11) DEFAULT NULL COMMENT '投保人身份证',
  `policy_holder_telephone` int(11) DEFAULT NULL COMMENT '投保人电话',
  `insured_person_name` varchar(4) DEFAULT NULL COMMENT '被保人姓名',
  `insured_person_certificate` varchar(30) DEFAULT NULL COMMENT '被保人证件类型',
  `insured_person_card` char(18) DEFAULT NULL COMMENT '被保人身份证',
  `insured_person_telephone` int(11) DEFAULT NULL COMMENT '被保人电话',
  `insured_date` int(11) DEFAULT NULL COMMENT '承保日期',
  `surrender_date` int(11) DEFAULT '0' COMMENT '退保日期',
  `add_time` int(11) DEFAULT NULL COMMENT '续期保单导入时间',
  `business_type` varchar(20) DEFAULT NULL COMMENT '业务类型 ',
  `dress` varchar(100) DEFAULT NULL COMMENT '投保人联系地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8 COMMENT='续期保单表（邱位鹏）';

-- ----------------------------
-- Table structure for leave_comments
-- ----------------------------
DROP TABLE IF EXISTS `leave_comments`;
CREATE TABLE `leave_comments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `member_num` int(10) NOT NULL DEFAULT '0' COMMENT '会员编码',
  `comments_info` text COMMENT '留言内容',
  `comments_date` int(10) DEFAULT NULL COMMENT '留言时间',
  `reco_id` int(10) NOT NULL DEFAULT '0' COMMENT '回复人ID',
  `recomments_info` text COMMENT '恢复内容',
  `recomments_date` int(10) DEFAULT NULL COMMENT '回复时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '回复状态: 0=>未回复 1=>已回复 -1=删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='留言处理表---赵';

-- ----------------------------
-- Table structure for life_detail
-- ----------------------------
DROP TABLE IF EXISTS `life_detail`;
CREATE TABLE `life_detail` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `provider_id` int(11) NOT NULL COMMENT '供应商id',
  `settle_time` int(11) NOT NULL COMMENT '结算时间',
  `insurance_number` int(11) NOT NULL COMMENT '保单号',
  `provider_name` varchar(50) NOT NULL COMMENT '供应商名字',
  `product_name` varchar(50) NOT NULL COMMENT '产品名称',
  `insurance_premium` int(11) NOT NULL COMMENT '规模保费',
  `standard_money` int(11) NOT NULL COMMENT '标准保费',
  `scale` float(4,2) NOT NULL COMMENT '签约比例',
  `agent_cost` int(11) NOT NULL COMMENT '代理费',
  `insured_date` int(11) NOT NULL COMMENT '投保日期',
  `payment_limit` int(11) NOT NULL COMMENT '缴费年期',
  `policy_holder_name` varchar(30) NOT NULL COMMENT '投保人姓名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='寿险详细页导出表 李杨';

-- ----------------------------
-- Table structure for manager
-- ----------------------------
DROP TABLE IF EXISTS `manager`;
CREATE TABLE `manager` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `manager_number` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '管理员代码',
  `username` varchar(50) NOT NULL COMMENT '登入名',
  `password` char(32) NOT NULL COMMENT '密码',
  `real_name` varchar(50) DEFAULT NULL COMMENT '真实姓名',
  `gender` tinyint(1) DEFAULT NULL COMMENT '性别:0=保密 1=男 2=女',
  `age` int(3) DEFAULT '0' COMMENT '年龄',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `mobile` char(11) DEFAULT NULL COMMENT '手机号',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态：1=正常 0=禁用 -1=删除',
  `telphone` char(15) DEFAULT NULL COMMENT '固定电话',
  `organization_id` varchar(10) DEFAULT NULL COMMENT '机构代码 总公司为0',
  `role_id` mediumint(9) DEFAULT '1' COMMENT '角色ID',
  `address` varchar(255) DEFAULT NULL COMMENT '地址',
  `weixin` varchar(50) DEFAULT NULL COMMENT '微信号',
  `qq` varchar(15) DEFAULT NULL COMMENT 'qq号',
  `last_login_time` int(10) DEFAULT '0' COMMENT '最后登入时间',
  `create_time` int(10) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `mobile` (`mobile`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='管理员表---赵';

-- ----------------------------
-- Table structure for manager_auth_access
-- ----------------------------
DROP TABLE IF EXISTS `manager_auth_access`;
CREATE TABLE `manager_auth_access` (
  `role_id` smallint(6) unsigned NOT NULL COMMENT '角色ID',
  `node_id` text NOT NULL COMMENT '节点ID',
  `level` tinyint(1) NOT NULL DEFAULT '0' COMMENT '节点类型 1=>应用(模块) 2=>控制器 3=>方法'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色与节点关系表\r\n';

-- ----------------------------
-- Table structure for manager_auth_node
-- ----------------------------
DROP TABLE IF EXISTS `manager_auth_node`;
CREATE TABLE `manager_auth_node` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '权限节点id',
  `name` varchar(100) NOT NULL DEFAULT '0' COMMENT '名称',
  `group` varchar(100) NOT NULL DEFAULT '0' COMMENT '所属分组',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '启用状态 0=>未启动 1=>启动',
  `remark` varchar(255) NOT NULL DEFAULT '0' COMMENT '备注信息',
  `sort` smallint(6) NOT NULL DEFAULT '0' COMMENT '排序',
  `pid` smallint(6) NOT NULL DEFAULT '0' COMMENT '父节点',
  `level` tinyint(1) NOT NULL DEFAULT '0' COMMENT '节点类型 1=>应用(模块) 2=>控制器 3=>方法',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `authcode` text NOT NULL COMMENT '权限码(控制器+动作)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 COMMENT='后台权限节点表\r\n李杨';

-- ----------------------------
-- Table structure for manager_auth_role
-- ----------------------------
DROP TABLE IF EXISTS `manager_auth_role`;
CREATE TABLE `manager_auth_role` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT COMMENT '角色id',
  `name` varchar(20) NOT NULL COMMENT '角色名称',
  `pid` smallint(6) DEFAULT NULL COMMENT '父角色Id',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '角色状态 1=>启动 0=>未启动',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `edit_time` int(11) NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='后台权限角色表\r\n李杨';

-- ----------------------------
-- Table structure for member
-- ----------------------------
DROP TABLE IF EXISTS `member`;
CREATE TABLE `member` (
  `mid` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键会员ID',
  `m_number` varchar(10) NOT NULL COMMENT '会员代码(工号)',
  `my_shop_number` varchar(10) DEFAULT NULL COMMENT '我的店铺代码',
  `shop_number` varchar(10) DEFAULT NULL COMMENT '所属标准店代码',
  `flagship_number` varchar(10) DEFAULT NULL COMMENT '所属旗舰店代码 ',
  `branch_shop_number` varchar(10) DEFAULT NULL COMMENT '所属分公司代码 ',
  `mobile` char(11) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '手机号',
  `email` varchar(40) DEFAULT NULL COMMENT '邮箱',
  `password` varchar(32) NOT NULL DEFAULT 'e10adc3949ba59abbe56e057f20f883e' COMMENT '密码',
  `pay_password` varchar(32) DEFAULT NULL COMMENT '提现密码',
  `name` varchar(30) DEFAULT NULL COMMENT '真实姓名	',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '会员状态 1=正常 0=禁用  -1=删除',
  `member_level` tinyint(1) NOT NULL DEFAULT '0' COMMENT '会员级别	\r\n0=>普通会员  1=>资深业务员\r\n 2=>标准店店长  3=>旗舰店店长',
  `integral` int(10) DEFAULT '0' COMMENT '会员积分	',
  `check_status` tinyint(1) DEFAULT '1' COMMENT '审核状态\r\n 0=审核中 1=审核通过 -1=未通过',
  `last_login_time` int(10) DEFAULT NULL COMMENT '最后登入时间	',
  `recommend_member_id` varchar(10) DEFAULT NULL COMMENT '推荐人代码',
  `register_time` int(10) DEFAULT NULL COMMENT '注册时间	',
  `total_income` float(11,2) DEFAULT '0.00' COMMENT '累计收入',
  `cash_income` float(11,2) DEFAULT '0.00' COMMENT '可提现收入',
  `current_income` float(11,2) DEFAULT '0.00' COMMENT '当月收入',
  PRIMARY KEY (`mid`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 COMMENT='会员表（卢）';

-- ----------------------------
-- Table structure for member_browsing
-- ----------------------------
DROP TABLE IF EXISTS `member_browsing`;
CREATE TABLE `member_browsing` (
  `id` int(11) NOT NULL COMMENT '浏览表id',
  `member_id` int(11) NOT NULL COMMENT '会员代码',
  `product_id` int(11) NOT NULL COMMENT '产品id',
  `create_time` int(11) NOT NULL COMMENT '浏览时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员浏览记录表\r\n李杨';

-- ----------------------------
-- Table structure for member_cash
-- ----------------------------
DROP TABLE IF EXISTS `member_cash`;
CREATE TABLE `member_cash` (
  `id` int(10) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `m_number` varchar(30) DEFAULT NULL COMMENT '会员编号',
  `name` varchar(30) DEFAULT NULL COMMENT '会员姓名',
  `money` float(11,2) DEFAULT NULL COMMENT '提现金额',
  `time` int(11) DEFAULT NULL COMMENT '提现时间',
  `status` tinyint(1) DEFAULT NULL COMMENT '状态， 0=>失败 1=>成功',
  `account_number` varchar(50) DEFAULT NULL COMMENT '提现账号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='会员提现记录表 李杨';

-- ----------------------------
-- Table structure for member_credit_log
-- ----------------------------
DROP TABLE IF EXISTS `member_credit_log`;
CREATE TABLE `member_credit_log` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `m_number` int(10) NOT NULL COMMENT '会员代码',
  `credit` int(10) DEFAULT NULL COMMENT '操作积分',
  `note` varchar(255) DEFAULT NULL COMMENT '备注',
  `status` tinyint(1) DEFAULT NULL COMMENT '状态 1=>减少  2=>增加',
  `time` int(11) NOT NULL COMMENT '时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员积分日志表（卢）';

-- ----------------------------
-- Table structure for member_credit_rule
-- ----------------------------
DROP TABLE IF EXISTS `member_credit_rule`;
CREATE TABLE `member_credit_rule` (
  `id` int(11) NOT NULL COMMENT '积分Id',
  `rule_name` varchar(20) DEFAULT NULL COMMENT '中文名',
  `alias_name` varchar(20) DEFAULT NULL COMMENT '英文名',
  `cycle_type` tinyint(1) NOT NULL COMMENT '奖励周期 0=一次 1=每天 2=整点 3=间隔分钟 4=周 5=月 6=年 7=不限',
  `cycle_time` int(11) NOT NULL COMMENT '间隔时间',
  `reward_num` tinyint(3) NOT NULL COMMENT '奖励次数',
  `no_repeat` tinyint(1) NOT NULL COMMENT '是否重复 1=重复 2=不重复',
  `operation_credit` int(11) DEFAULT NULL COMMENT '操作积分',
  `activity_credit` int(11) DEFAULT NULL COMMENT '活动积分',
  `money_credit` int(11) DEFAULT NULL COMMENT '消费积分',
  `manager_id` int(11) DEFAULT NULL COMMENT '管理员Id',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `last_update_time` int(11) DEFAULT NULL COMMENT '最后修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='积分规则表\r\n李杨';

-- ----------------------------
-- Table structure for member_favorite
-- ----------------------------
DROP TABLE IF EXISTS `member_favorite`;
CREATE TABLE `member_favorite` (
  `id` int(11) NOT NULL COMMENT '收藏表Id',
  `member_number` int(11) NOT NULL COMMENT '会员代码',
  `product_id` int(11) NOT NULL COMMENT '产品Id',
  `create_time` int(11) NOT NULL COMMENT '收藏时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `status` tinyint(1) NOT NULL COMMENT '状态 1=正常 -1=删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='关注收藏表\r\n李杨';

-- ----------------------------
-- Table structure for member_profile
-- ----------------------------
DROP TABLE IF EXISTS `member_profile`;
CREATE TABLE `member_profile` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `m_number` varchar(10) NOT NULL COMMENT '会员代码',
  `avatar` varchar(255) DEFAULT NULL COMMENT '头像',
  `gender` tinyint(1) DEFAULT NULL COMMENT '性别  男=1 女=0',
  `education` varchar(15) DEFAULT NULL COMMENT '学历',
  `identity_card` char(18) DEFAULT NULL COMMENT '身份证',
  `bank_card` char(20) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '银行卡卡号',
  `bank_name` varchar(40) DEFAULT NULL COMMENT '银行卡开户行',
  `birthday` int(10) NOT NULL COMMENT '生日',
  `province` smallint(6) NOT NULL COMMENT '省份ID',
  `city` smallint(6) NOT NULL COMMENT '城市ID',
  `district` smallint(6) NOT NULL COMMENT '地区ID	',
  `address` varchar(255) NOT NULL COMMENT '详细地址	',
  `weixin` varchar(30) NOT NULL COMMENT '微信号	',
  `qq` varchar(13) DEFAULT NULL COMMENT 'QQ号',
  `member_num` varchar(255) NOT NULL COMMENT '资格证号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COMMENT='会员详情表（卢）';

-- ----------------------------
-- Table structure for member_standard
-- ----------------------------
DROP TABLE IF EXISTS `member_standard`;
CREATE TABLE `member_standard` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `m_number` varchar(10) NOT NULL COMMENT '业务员代码',
  `branch_shop_number` varchar(10) NOT NULL COMMENT '分公司代码',
  `standard` varchar(100) NOT NULL COMMENT '达标月',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='会员达标人数表（卢）';

-- ----------------------------
-- Table structure for member_test_result
-- ----------------------------
DROP TABLE IF EXISTS `member_test_result`;
CREATE TABLE `member_test_result` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `member_num` int(10) NOT NULL DEFAULT '0' COMMENT '会员编码',
  `test_result_str` text COMMENT '考试结果字符',
  `detailed_state` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0=未通过 1=通过',
  `time_cost` float DEFAULT NULL COMMENT '考试用时',
  `create_time` int(10) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='会员考试结果表---赵\r\n\r\n';

-- ----------------------------
-- Table structure for new_contract_coefficient
-- ----------------------------
DROP TABLE IF EXISTS `new_contract_coefficient`;
CREATE TABLE `new_contract_coefficient` (
  `contract_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `m_number` varchar(10) NOT NULL COMMENT '会员代码',
  `new_cont_cone` float(3,2) NOT NULL DEFAULT '1.00' COMMENT '新契约品质系数',
  `input_time` int(10) DEFAULT NULL COMMENT '导入时间',
  `end_time` int(10) DEFAULT NULL COMMENT '失效时间',
  PRIMARY KEY (`contract_id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 COMMENT='新契约品质系数表\r\n李杨';

-- ----------------------------
-- Table structure for non_life_detail
-- ----------------------------
DROP TABLE IF EXISTS `non_life_detail`;
CREATE TABLE `non_life_detail` (
  `id` int(11) NOT NULL,
  `provider_id` int(11) NOT NULL COMMENT '供应商id',
  `settle_time` int(11) NOT NULL COMMENT '结算时间',
  `insurance_number` int(11) NOT NULL COMMENT '保单号',
  `provider_name` varchar(50) NOT NULL COMMENT '供应商名称',
  `product_name` varchar(50) NOT NULL COMMENT '产品名称',
  `insurance_premium` int(11) NOT NULL COMMENT '规模保费',
  `scale` float(4,2) NOT NULL COMMENT '签约比例',
  `agent_cost` int(11) NOT NULL COMMENT '代理费',
  `policy_holder_name` varchar(30) NOT NULL COMMENT '投保人姓名',
  `insured_date` int(11) NOT NULL COMMENT '投保日期',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='非寿险结算详细页导出表 李杨';

-- ----------------------------
-- Table structure for order_master
-- ----------------------------
DROP TABLE IF EXISTS `order_master`;
CREATE TABLE `order_master` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '订单id',
  `member_id` int(10) DEFAULT NULL COMMENT '会员id',
  `payment_method` tinyint(1) DEFAULT NULL COMMENT '支付方式  1=支付宝 2=微信 ',
  `pay_status` tinyint(1) DEFAULT NULL COMMENT '支付状态 1=支付成功2=未支付 3=失效',
  `pay_time` int(10) DEFAULT NULL COMMENT '支付时间',
  `create_time` int(10) DEFAULT NULL COMMENT '创建订单时间',
  `order_num` int(10) DEFAULT NULL COMMENT '订单号',
  `premium` int(10) DEFAULT NULL COMMENT '保费金融',
  `pay_money` float(10,2) DEFAULT NULL COMMENT '应付金额',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='订单主表（邱位鹏）';

-- ----------------------------
-- Table structure for order_schedule
-- ----------------------------
DROP TABLE IF EXISTS `order_schedule`;
CREATE TABLE `order_schedule` (
  `id` int(10) NOT NULL COMMENT '订单附表id',
  `order_num` int(10) DEFAULT NULL COMMENT '订单编号',
  `product_id` int(10) DEFAULT NULL COMMENT '产品id',
  `product_name` varchar(50) DEFAULT NULL COMMENT '产品名称',
  `policy_holder_name` varchar(20) DEFAULT NULL COMMENT '投保人姓名',
  `policy_holder_document_type` tinyint(1) DEFAULT NULL COMMENT '投保人证件类型 1=身份证 2=护照',
  `policy_holder_document_num` varchar(18) DEFAULT NULL COMMENT '投保人证件号码',
  `policy_holder_address` varchar(50) DEFAULT NULL COMMENT '投保人联系地址',
  `policy_holder_phone` char(11) DEFAULT NULL COMMENT '投保人电话',
  `insured_person_name` varchar(20) DEFAULT NULL COMMENT '被保人姓名',
  `insured_person_document_type` tinyint(1) DEFAULT NULL COMMENT '被保人证件类型',
  `insured_person_document_num` varchar(18) DEFAULT NULL COMMENT '被保人证件号码',
  `insured_person_address` varchar(50) DEFAULT NULL COMMENT '被保人地址',
  `insured_person_phone` int(11) DEFAULT NULL COMMENT '被保人电话',
  `insurance_type` tinyint(1) DEFAULT NULL COMMENT '保险类型 1=主险 2=附加险',
  `insurance_pay` int(10) DEFAULT NULL COMMENT '保险金额',
  `insurance_star` int(10) DEFAULT NULL COMMENT '保险开始时间',
  `insurance_end` int(10) DEFAULT NULL COMMENT '保险结束时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单附表（邱位鹏）';

-- ----------------------------
-- Table structure for org_target
-- ----------------------------
DROP TABLE IF EXISTS `org_target`;
CREATE TABLE `org_target` (
  `tar_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '机构目标主键id',
  `o_id` int(11) NOT NULL COMMENT '机构id',
  `cate` tinyint(1) NOT NULL COMMENT '险种1寿险 2非寿险不含车险 3车险',
  `target` int(11) NOT NULL COMMENT '险种目标',
  PRIMARY KEY (`tar_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='机构任务目标表（景）';

-- ----------------------------
-- Table structure for organization
-- ----------------------------
DROP TABLE IF EXISTS `organization`;
CREATE TABLE `organization` (
  `org_id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `org_code` varchar(10) NOT NULL COMMENT '门店编码',
  `flagship_code` varchar(10) DEFAULT NULL COMMENT '所属旗舰店编码',
  `branch_shop_code` varchar(10) DEFAULT NULL COMMENT '所属分公司代码',
  `name` varchar(60) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '门店名称',
  `level` smallint(1) unsigned NOT NULL COMMENT '门店级别 1分公司 2旗舰店 3标准店',
  `examine_standard` tinyint(3) unsigned DEFAULT NULL COMMENT '店铺考核标准类型 1=>A类 2=>B类 3=>C类',
  `introduce` varchar(255) DEFAULT NULL COMMENT '门店介绍',
  `province_id` smallint(6) NOT NULL COMMENT '省份ID',
  `city_id` smallint(6) NOT NULL COMMENT '城市ID',
  `check_results` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '考核结果 0=>维持 1=>观察 2=>降级 4=>筹备期考核失败',
  `district_id` smallint(6) NOT NULL COMMENT '城市ID',
  `address` varchar(255) NOT NULL COMMENT '详细地址',
  `lawyer_num` mediumint(8) DEFAULT NULL COMMENT '会员数量 先不写',
  `status` tinyint(1) NOT NULL COMMENT '门店状态 1=经营期 0=筹备期 -1=观察期',
  `telphone` varchar(20) NOT NULL COMMENT '电话',
  `fax` varchar(20) DEFAULT NULL COMMENT '传真',
  `email` varchar(60) NOT NULL COMMENT '邮箱',
  `principal_number` varchar(10) NOT NULL COMMENT '会员编码',
  `check_status` tinyint(3) unsigned DEFAULT NULL COMMENT '店铺状态 1=有效 0=失效 考核不通过时将店铺设置为失效',
  `create_time` int(10) NOT NULL COMMENT '成立时间',
  `start_time` int(11) DEFAULT NULL COMMENT '筹备开始时间',
  `end_time` int(11) DEFAULT NULL COMMENT '筹备结束时间',
  PRIMARY KEY (`org_id`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8 COMMENT='机构表（景）';

-- ----------------------------
-- Table structure for organizational_goals
-- ----------------------------
DROP TABLE IF EXISTS `organizational_goals`;
CREATE TABLE `organizational_goals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `shop_name` varchar(50) NOT NULL COMMENT '机构名称',
  `shop_code` varchar(10) NOT NULL COMMENT '机构代码',
  `insurance_target` decimal(10,0) unsigned DEFAULT NULL COMMENT '寿险目标',
  `not_insurance_target` decimal(10,0) unsigned DEFAULT NULL COMMENT '非寿险目标',
  `financial_target` decimal(10,0) unsigned DEFAULT NULL COMMENT '理财目标',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='机构目标表 （景）';

-- ----------------------------
-- Table structure for personal_coefficient
-- ----------------------------
DROP TABLE IF EXISTS `personal_coefficient`;
CREATE TABLE `personal_coefficient` (
  `id` int(10) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `m_number` varchar(10) DEFAULT NULL COMMENT '会员编号',
  `rate_continue` float(4,2) DEFAULT NULL COMMENT '继续率',
  `coefficient` float(4,2) DEFAULT NULL COMMENT '续期品质系数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='个人续期品质系数表 李杨';

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `product_title` varchar(120) DEFAULT NULL COMMENT '产品标题',
  `product_name` varchar(60) NOT NULL COMMENT '产品名称',
  `content` text COMMENT '产品简介',
  `details` text COMMENT '产品详细',
  `product_label` tinyint(1) DEFAULT NULL COMMENT '产品标识：1=>新品 2=>热销 3=>人气   4=>独家',
  `supplier_id` int(10) NOT NULL COMMENT '供应商ID',
  `fit_member` text COMMENT '适合人群',
  `initial_contract_ratio` decimal(3,2) DEFAULT NULL COMMENT '首期签约比例',
  `product_img` varchar(255) DEFAULT NULL COMMENT '产品图片',
  `product_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '产品分类 寿险 非寿险',
  `product_state` tinyint(1) NOT NULL DEFAULT '1' COMMENT '产品类型 线上线下',
  `type_id` smallint(6) DEFAULT NULL COMMENT ' 销售产品分类',
  `unsales_category_id` smallint(6) DEFAULT NULL COMMENT '非销售产品分类ID',
  `rate_name` varchar(255) DEFAULT NULL COMMENT '费率表名称',
  `amount_insured` smallint(6) DEFAULT '0' COMMENT '保额整倍数',
  `initial_price` decimal(9,2) DEFAULT '0.00' COMMENT '保额起步价',
  `commission_rate` decimal(3,2) DEFAULT NULL COMMENT '佣金比例(非寿)',
  `fold_factor` decimal(3,2) DEFAULT '0.00' COMMENT '折标系数',
  `discount_coefficient` decimal(3,2) DEFAULT '0.00' COMMENT '折价系数',
  `premium` decimal(9,2) DEFAULT '0.00' COMMENT '规模保费',
  `turnover` int(10) DEFAULT '0' COMMENT '成交量',
  `status` tinyint(1) DEFAULT '0' COMMENT '产品状态：0=上架 1=下架 -1=删除',
  `reviews_id` int(10) DEFAULT '0' COMMENT '产品评价ID',
  `grade` int(10) DEFAULT NULL COMMENT '产品总评分',
  `manager_id` int(10) unsigned NOT NULL DEFAULT '0',
  `last_update_time` int(10) DEFAULT NULL,
  `create_time` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8 COMMENT='产品表\r\n';

-- ----------------------------
-- Table structure for product_proposal
-- ----------------------------
DROP TABLE IF EXISTS `product_proposal`;
CREATE TABLE `product_proposal` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `tetle` varchar(60) DEFAULT NULL COMMENT '建议书标题',
  `Insured_person_name` varchar(50) DEFAULT NULL COMMENT '被保人姓名',
  `policy_holder_name` varchar(50) DEFAULT NULL COMMENT '投保人姓名',
  `manager_id` int(10) NOT NULL DEFAULT '0' COMMENT '管理员ID',
  `product_id` int(10) NOT NULL DEFAULT '0' COMMENT '产品ID',
  `payment_period` tinyint(2) NOT NULL DEFAULT '0' COMMENT '缴费年限',
  `guarantee_period` tinyint(2) NOT NULL DEFAULT '0' COMMENT '保障期限',
  `first_year_premium` decimal(9,2) NOT NULL DEFAULT '0.00' COMMENT '首年保费',
  `age` tinyint(3) NOT NULL DEFAULT '0' COMMENT '年龄',
  `gender` tinyint(1) NOT NULL DEFAULT '0' COMMENT '性别：0=保密 1=男 2=女',
  `the_sum_insured` decimal(9,2) NOT NULL DEFAULT '0.00' COMMENT '保额',
  `send_object_name` varchar(50) DEFAULT NULL COMMENT '发送对象姓名',
  `send_object_mobile` int(11) DEFAULT NULL COMMENT '发送对象手机号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='产品建议书表---赵';

-- ----------------------------
-- Table structure for product_rate
-- ----------------------------
DROP TABLE IF EXISTS `product_rate`;
CREATE TABLE `product_rate` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `product_id` int(10) unsigned DEFAULT NULL COMMENT '产品ID',
  `age` tinyint(3) NOT NULL DEFAULT '0' COMMENT '年龄',
  `sex` tinyint(1) NOT NULL DEFAULT '0' COMMENT '性别:0=保密 1=男 2-女',
  `payment_period` tinyint(2) NOT NULL DEFAULT '0' COMMENT '缴费期限',
  `base` int(10) NOT NULL DEFAULT '0' COMMENT '基数',
  `create_time` int(10) NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='费率表---赵';

-- ----------------------------
-- Table structure for product_reviews
-- ----------------------------
DROP TABLE IF EXISTS `product_reviews`;
CREATE TABLE `product_reviews` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `product_id` int(10) NOT NULL DEFAULT '0' COMMENT '产品Id',
  `memebre_id` int(10) NOT NULL DEFAULT '0' COMMENT '会员ID',
  `content` text COMMENT '评论内容',
  `star` tinyint(1) NOT NULL DEFAULT '0' COMMENT '评论星级',
  `create_time` int(10) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='产品评论表---赵';

-- ----------------------------
-- Table structure for product_rules
-- ----------------------------
DROP TABLE IF EXISTS `product_rules`;
CREATE TABLE `product_rules` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `product_id` int(10) NOT NULL DEFAULT '0' COMMENT '产品ID',
  `insurance_tips` text COMMENT '投保提示',
  `claim_tips` text COMMENT '理赔提示',
  `clause_reading` text COMMENT '条款阅读',
  `classic_case` text COMMENT '典型案例',
  `create_time` int(10) DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COMMENT='产品投保规则表---赵\r\n';

-- ----------------------------
-- Table structure for product_safeguard
-- ----------------------------
DROP TABLE IF EXISTS `product_safeguard`;
CREATE TABLE `product_safeguard` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `product_id` int(10) NOT NULL DEFAULT '0' COMMENT '产品ID',
  `tetle` varchar(255) DEFAULT NULL COMMENT '保障标题',
  `content` text COMMENT '保障内容',
  `manager_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '管理员ID',
  `period` int(10) NOT NULL DEFAULT '0' COMMENT '保障期限',
  `last_update_time` int(10) DEFAULT NULL COMMENT '修改时间',
  `create_time` int(10) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='产品服务保障---赵';

-- ----------------------------
-- Table structure for product_type
-- ----------------------------
DROP TABLE IF EXISTS `product_type`;
CREATE TABLE `product_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `parent_id` smallint(6) NOT NULL DEFAULT '0' COMMENT '父ID',
  `cat_name` varchar(30) NOT NULL COMMENT '分类名称',
  `cat_pic` varchar(255) DEFAULT NULL COMMENT '分类图标',
  `description` varchar(255) DEFAULT NULL COMMENT '分类描述',
  `manager_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '管理员ID',
  `state` tinyint(1) NOT NULL DEFAULT '1' COMMENT '分类状态：1=正常 0=停用 -1=删除',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '（弃用）分类类型： 0=销售 1=非销售',
  `last_update_time` int(10) DEFAULT NULL COMMENT '修改时间',
  `create_time` int(10) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cat_name` (`cat_name`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8 COMMENT='产品销售分类---赵';

-- ----------------------------
-- Table structure for product_unsales_category
-- ----------------------------
DROP TABLE IF EXISTS `product_unsales_category`;
CREATE TABLE `product_unsales_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `parent_id` smallint(6) NOT NULL DEFAULT '0' COMMENT '父ID',
  `cat_name` varchar(30) DEFAULT NULL COMMENT '分类名称',
  `cat_pic` varchar(255) DEFAULT NULL COMMENT '分类图标',
  `description` varchar(255) DEFAULT NULL COMMENT '分类描述',
  `manager_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '管理员ID',
  `state` tinyint(1) NOT NULL DEFAULT '1' COMMENT '分类状态：1=正常 0=停用 -1=删除',
  `last_update_time` int(10) DEFAULT NULL COMMENT '修改时间',
  `create_time` int(10) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cat_name` (`cat_name`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='产品非销售分类表---赵\r\n\r\n';

-- ----------------------------
-- Table structure for question
-- ----------------------------
DROP TABLE IF EXISTS `question`;
CREATE TABLE `question` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `title` varchar(60) DEFAULT NULL COMMENT '常见问题标题',
  `question_type_id` int(10) NOT NULL DEFAULT '0' COMMENT '常见问题分类ID',
  `describe` text COMMENT '常见问题描述',
  `views` int(10) NOT NULL DEFAULT '0' COMMENT '浏览数',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态：1=显示  0=未显示 -1=删除',
  `create_time` int(10) DEFAULT NULL COMMENT '创建时间',
  `last_update_time` int(10) DEFAULT '0' COMMENT '最后修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='常见问题表---赵';

-- ----------------------------
-- Table structure for question_type
-- ----------------------------
DROP TABLE IF EXISTS `question_type`;
CREATE TABLE `question_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(60) DEFAULT NULL COMMENT '分类名称',
  `father_id` int(10) NOT NULL DEFAULT '0' COMMENT '父ID',
  `description` varchar(255) DEFAULT NULL COMMENT '分类描述',
  `manager_id` int(10) NOT NULL DEFAULT '0' COMMENT '管理员ID',
  `last_update_time` int(10) DEFAULT NULL COMMENT '追后修改时间',
  `create_time` int(10) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='常见问题分类---赵';

-- ----------------------------
-- Table structure for renew
-- ----------------------------
DROP TABLE IF EXISTS `renew`;
CREATE TABLE `renew` (
  `re_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `insurance_num` int(10) DEFAULT NULL COMMENT '保单号',
  `two_time` int(10) DEFAULT NULL COMMENT '二次成功日期',
  `two_agency_fee` int(10) DEFAULT NULL COMMENT '二次代理费',
  `two_state` tinyint(1) DEFAULT NULL COMMENT '二次是否成功 1=》成功 2=》失败',
  `three_time` int(10) DEFAULT NULL COMMENT '三次成功日期',
  `three_agency_fee` int(10) DEFAULT NULL COMMENT '三次代理费',
  `three_state` tinyint(1) DEFAULT NULL COMMENT '三次缴费是否成功 1=》成功 2=》失败',
  `four_time` int(10) DEFAULT NULL COMMENT '四次成功日期',
  `four_agency_fee` int(10) DEFAULT NULL COMMENT '四次代理费',
  `four_state` int(1) DEFAULT NULL COMMENT '四次是否成功 1 成功 2失败',
  `five_time` int(10) DEFAULT NULL COMMENT '五次成功日期',
  `five_agency_fee` int(10) DEFAULT NULL COMMENT '五次代理费',
  `five_state` int(10) DEFAULT NULL COMMENT '五次是否成功 1成功 2失败',
  `renew_count` tinyint(1) DEFAULT NULL COMMENT '续期缴费次数',
  `add_time` int(10) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`re_id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COMMENT='邱位鹏  缴费时间表';

-- ----------------------------
-- Table structure for renewal_detail
-- ----------------------------
DROP TABLE IF EXISTS `renewal_detail`;
CREATE TABLE `renewal_detail` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `provider_id` int(11) NOT NULL COMMENT '供应商id',
  `settle_time` int(11) NOT NULL COMMENT '结算时间',
  `insurance_number` int(11) NOT NULL COMMENT '保单号',
  `provider_name` varchar(50) NOT NULL COMMENT '供应商名字',
  `product_name` varchar(50) NOT NULL COMMENT '产品名称',
  `insurance_premium` int(11) NOT NULL COMMENT '应收规模保费',
  `real_insurance_premium` int(11) NOT NULL COMMENT '实收规模保费',
  `insured_date` int(11) NOT NULL COMMENT '承保日期',
  `renewal_pay_date` int(11) NOT NULL COMMENT '续保日期',
  `renewal_number` smallint(6) NOT NULL COMMENT '续期年数',
  `scale` float(4,2) NOT NULL COMMENT '签约比例',
  `agent_cost` int(11) NOT NULL COMMENT '结算保费',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='续期结算保费详细页导出表 李杨';

-- ----------------------------
-- Table structure for service_fee_calculation
-- ----------------------------
DROP TABLE IF EXISTS `service_fee_calculation`;
CREATE TABLE `service_fee_calculation` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `m_number` int(10) NOT NULL COMMENT '会员代码',
  `shop_number` int(10) DEFAULT NULL COMMENT '所属标准店代码',
  `flagship_number` int(10) DEFAULT NULL COMMENT '所属旗舰店代码 ',
  `branch_shop_number` int(10) DEFAULT NULL COMMENT '所属分公司代码 ',
  `initial_service` decimal(10,2) DEFAULT NULL COMMENT '首推服务费',
  `renewal_service` decimal(10,2) DEFAULT NULL COMMENT '续期服务费',
  `nonlife_service` decimal(10,2) DEFAULT NULL COMMENT '非寿险服务费',
  `manage_interest` decimal(10,2) DEFAULT NULL COMMENT '管理利益',
  `bred_interest` decimal(10,2) DEFAULT NULL COMMENT '育成利益',
  `flagship_service` decimal(10,2) DEFAULT NULL COMMENT '旗舰店服务费',
  `Debit` decimal(10,2) DEFAULT NULL COMMENT '其他加扣款',
  `deduction` decimal(10,2) DEFAULT NULL COMMENT '扣税金额',
  `actual_pay` decimal(10,2) DEFAULT NULL COMMENT '实发工资',
  `already_pay` decimal(10,2) DEFAULT NULL COMMENT '已发工资',
  `Should_pay` decimal(10,2) DEFAULT NULL COMMENT '应发 工资',
  `on_line` decimal(10,2) DEFAULT NULL COMMENT '线上发放',
  `off_line` decimal(10,2) DEFAULT NULL COMMENT '线下发放',
  `branch_shop` tinyint(1) DEFAULT NULL COMMENT '分公司意见   1=>未通过 2=>通过',
  `headquarters` tinyint(1) DEFAULT NULL COMMENT '总公司意见 1=>未通过 2=>通过',
  `month` int(11) DEFAULT NULL COMMENT '服务费计算时间  以月份为单位',
  `time` int(11) NOT NULL COMMENT '时间 ',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='服务费计算表（卢）';

-- ----------------------------
-- Table structure for service_fee_config
-- ----------------------------
DROP TABLE IF EXISTS `service_fee_config`;
CREATE TABLE `service_fee_config` (
  `id` int(10) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `empty_time` smallint(6) DEFAULT NULL COMMENT '清空时间，为月份，最大不能超过12个月',
  `member` float(3,2) DEFAULT NULL COMMENT '会员比例',
  `senior_member` float(3,2) DEFAULT NULL COMMENT '资深经理比例',
  `standard_online` float(3,2) DEFAULT NULL COMMENT '标准店店长线上比例',
  `standard_line` float(3,2) DEFAULT NULL COMMENT '标准店店长线下比例',
  `standard_manage` float(3,2) DEFAULT NULL COMMENT '标准店管理利益',
  `standard_foster` float(3,2) DEFAULT NULL COMMENT '标准店育成店利益',
  `flagship` float(3,2) DEFAULT NULL COMMENT '旗舰店比例',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='服务器配置表 李杨';

-- ----------------------------
-- Table structure for service_fee_policy
-- ----------------------------
DROP TABLE IF EXISTS `service_fee_policy`;
CREATE TABLE `service_fee_policy` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `ser_feee_id` int(10) NOT NULL COMMENT '服务费计算详情ID',
  `m_number` varchar(10) NOT NULL COMMENT '会员代码',
  `policy_number` int(10) NOT NULL COMMENT '保单号',
  `policy_value` decimal(10,2) NOT NULL COMMENT '价保(首期)/规保（非寿/续期）',
  `policy_type` tinyint(1) NOT NULL COMMENT '保险类型 1:首期，2续期，3非寿',
  `time` int(11) NOT NULL COMMENT '时间 ',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=172 DEFAULT CHARSET=utf8 COMMENT='服务费于保单关系表（卢）';

-- ----------------------------
-- Table structure for settlement_initial_fee_industry_bonus_proportion
-- ----------------------------
DROP TABLE IF EXISTS `settlement_initial_fee_industry_bonus_proportion`;
CREATE TABLE `settlement_initial_fee_industry_bonus_proportion` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `provider_id` int(10) NOT NULL COMMENT '供应商id',
  `minimum_standard_permium` int(11) NOT NULL COMMENT '标准保费的最小值',
  `maximum_standard_premium` int(11) NOT NULL COMMENT '标准保费的最大值',
  `bonus_ratio` int(11) NOT NULL DEFAULT '0' COMMENT '首期手续费业推奖金',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='首期手续费业推奖金表 李杨';

-- ----------------------------
-- Table structure for settlement_management
-- ----------------------------
DROP TABLE IF EXISTS `settlement_management`;
CREATE TABLE `settlement_management` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `provider_id` mediumint(10) NOT NULL COMMENT '供应商id',
  `settle_time` int(11) DEFAULT NULL COMMENT '结算时间',
  `provider_name` varchar(30) NOT NULL COMMENT '供应商名字',
  `life_premium` int(11) NOT NULL COMMENT '寿险结算保费',
  `non_life_premium` int(11) NOT NULL COMMENT '非寿险结算总额',
  `industry_bonus` int(11) NOT NULL COMMENT '业推奖',
  `business_bonus` int(11) NOT NULL COMMENT '非寿险业务奖金',
  `total_first_premium` int(11) NOT NULL COMMENT '首期手续费总计',
  `renewal_premium` int(11) NOT NULL COMMENT '续期结算保费',
  `renewal_bonus` int(11) NOT NULL COMMENT '续期继续率奖金',
  `total_renewal_premium` int(11) NOT NULL COMMENT '续期手续费总计',
  `total_premium` int(11) NOT NULL COMMENT '累计总额',
  `add_time` int(11) NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='结算导出总表 李杨';

-- ----------------------------
-- Table structure for settlement_non_life_insurance_premium
-- ----------------------------
DROP TABLE IF EXISTS `settlement_non_life_insurance_premium`;
CREATE TABLE `settlement_non_life_insurance_premium` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `provider_id` int(11) NOT NULL COMMENT '供应商Id',
  `min_scale_premium` int(11) NOT NULL COMMENT '非寿险结算 最小规模保费',
  `max_scale_premium` int(11) NOT NULL COMMENT '非寿险结算 最大规模保费',
  `non_life_insurance_premium` int(11) NOT NULL COMMENT '非寿险业务奖金',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='非寿险业务奖金表 \r\n规模保费对应奖金数\r\n李杨';

-- ----------------------------
-- Table structure for settlement_renewal_contract
-- ----------------------------
DROP TABLE IF EXISTS `settlement_renewal_contract`;
CREATE TABLE `settlement_renewal_contract` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '签约比例表Id',
  `product_id` int(11) NOT NULL COMMENT '产品Id',
  `provider_id` int(11) NOT NULL COMMENT '供应商id',
  `renewal_type` tinyint(4) NOT NULL COMMENT '续期类型，1=>业务员，2=>供应商',
  `length_of_renewal` int(11) NOT NULL COMMENT '续期时长',
  `renewal_ratio` float(3,2) NOT NULL COMMENT '签约比例（供应商）/服务费率（业务员）',
  `payment_period` smallint(3) NOT NULL COMMENT '缴费年期',
  `add_time` int(11) NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8 COMMENT='续期签约比例表 李杨';

-- ----------------------------
-- Table structure for settlement_renewal_fee_rate
-- ----------------------------
DROP TABLE IF EXISTS `settlement_renewal_fee_rate`;
CREATE TABLE `settlement_renewal_fee_rate` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `product_id` int(11) NOT NULL COMMENT '产品id',
  `payment_period` int(3) NOT NULL COMMENT '缴费年期',
  `length_of_renewal` int(3) NOT NULL COMMENT '续期时长',
  `minimum_continuation_rate` float(3,2) NOT NULL COMMENT '继续率最小值',
  `maximum_continuation_rate` float(3,2) NOT NULL COMMENT '继续率最大值',
  `bonus_coefficient` float(4,2) NOT NULL COMMENT '续期手术费继续率奖金系数',
  `add_time` int(11) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8 COMMENT='续期手续费继续率奖金系数,\r\n继续率在范围内，产品Id 缴费年期 续期时长 不同继续率不同\r\n李杨';

-- ----------------------------
-- Table structure for shop_apply
-- ----------------------------
DROP TABLE IF EXISTS `shop_apply`;
CREATE TABLE `shop_apply` (
  `shop_apply_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `member_number` varchar(10) NOT NULL COMMENT '业务员代码',
  `member_shop` varchar(10) NOT NULL COMMENT '店铺代码',
  `shop_name` varchar(100) NOT NULL COMMENT '申请店铺名',
  `branch_shop_number` varchar(255) NOT NULL DEFAULT '' COMMENT '所属分公司代码',
  `member_name` varchar(50) NOT NULL COMMENT '业务员姓名',
  `create_apply` int(11) NOT NULL COMMENT '申请日期',
  `prepare_result` tinyint(1) NOT NULL DEFAULT '0' COMMENT ' 机构表添加结果是否成功0=>未成功 1=>成功',
  `branch_result` tinyint(1) NOT NULL DEFAULT '0' COMMENT '分公司意见 0=>未审核 1=>未通过 2=> 已通过',
  `head_result` tinyint(1) NOT NULL DEFAULT '0' COMMENT '总公司意见  0=>未审核 1=>未通过 2=> 已通过',
  `branch_remark` varchar(255) DEFAULT NULL COMMENT '分公司意见备注',
  `head_remark` varchar(255) DEFAULT NULL COMMENT '总公司意见备注',
  `start_time` int(11) NOT NULL COMMENT '考核开始时间',
  `end_time` int(11) NOT NULL COMMENT '考核结束时间',
  `is_del` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除 0没删 1删除',
  PRIMARY KEY (`shop_apply_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='店铺申请表（景）';

-- ----------------------------
-- Table structure for shop_assess_standard
-- ----------------------------
DROP TABLE IF EXISTS `shop_assess_standard`;
CREATE TABLE `shop_assess_standard` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键Id',
  `assess_range` tinyint(1) NOT NULL DEFAULT '0' COMMENT '考核期 0=连续三个月 1=半年',
  `business_ind` int(11) DEFAULT NULL COMMENT '业务指标',
  `business_base` smallint(6) DEFAULT NULL COMMENT '旗舰店业务指标基数(经营期和观察期)，A类地区90 B类地区48 C类地区30',
  `business_multiple` smallint(6) DEFAULT NULL COMMENT '旗舰店考核业务指标倍数（经营期和观察期）A类地区20 B类地区10 C类地区6',
  `first_hand_human` int(11) DEFAULT NULL COMMENT '直接推荐人数',
  `subordinate` int(11) DEFAULT NULL COMMENT '所辖人数',
  `first_hand_shop` smallint(6) DEFAULT '0' COMMENT '直接推荐标准店',
  `continuation_rate` float(3,2) NOT NULL COMMENT '13个月继续率',
  `shop_level` tinyint(4) NOT NULL COMMENT '店铺等级分类 1=标准店筹备期 2=标准店经营期和观察期 3=旗舰店筹备期 4=旗舰店经营期和观察期',
  `area_standard` tinyint(4) NOT NULL COMMENT '地区类型分类 1=A类指标 2=B类指标 3=C类指标',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 COMMENT='店铺考核标准表\r\n李杨';

-- ----------------------------
-- Table structure for study
-- ----------------------------
DROP TABLE IF EXISTS `study`;
CREATE TABLE `study` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(120) NOT NULL COMMENT '课堂标题',
  `content` text NOT NULL COMMENT '课堂内容',
  `study_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '发布类型：1=>产品知识讲堂 2=>销售技巧 3=>保险知识 4=>名人讲堂',
  `publish_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '发布人类型:1=>管理员 2=>会员',
  `publisher_id` int(10) NOT NULL DEFAULT '0' COMMENT '发布人ID',
  `publisher_name` varchar(50) DEFAULT NULL COMMENT '发布人姓名',
  `attachment_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '附件类型：1=>视频 2=>文档',
  `study_url` varchar(255) DEFAULT NULL COMMENT '视频URL',
  `click` int(10) NOT NULL DEFAULT '0' COMMENT '点击量',
  `file_path` varchar(255) DEFAULT '0' COMMENT '文件路径',
  `check_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '审核状态：0=未审核  1=审核通过  -1=审核失败 -2=删除',
  `auditing_name` varchar(50) DEFAULT NULL COMMENT '审核人姓名',
  `create_time` int(10) DEFAULT NULL COMMENT '创建时间',
  `check_time` int(10) DEFAULT NULL COMMENT '审核时间',
  `last_update_time` int(10) DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='学习课堂表---赵\r\n';

-- ----------------------------
-- Table structure for supplier
-- ----------------------------
DROP TABLE IF EXISTS `supplier`;
CREATE TABLE `supplier` (
  `sup_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '供应商ID',
  `sup_code` varchar(20) NOT NULL COMMENT '供应商代码',
  `sup_name` varchar(60) DEFAULT NULL COMMENT '供应商简称',
  `sup_type` tinyint(1) NOT NULL COMMENT '供应商类型  TINYINT  1=>人身险  2=>财产险 3=>意外险  4>车险 ',
  `full_name` varchar(255) NOT NULL COMMENT '供应商全称',
  `contract_name` varchar(10) DEFAULT NULL COMMENT '签约公司名称',
  `contract_type` int(1) DEFAULT NULL COMMENT '签约类型 1总对总 2总对分 3分对总 4分对分',
  `contract_code` varchar(10) DEFAULT NULL COMMENT '签约公司代码',
  `imglist` varchar(255) DEFAULT NULL COMMENT 'logo',
  `contacts` varchar(20) NOT NULL COMMENT '联系人',
  `telphone` varchar(20) NOT NULL COMMENT '联系电话',
  `website_url` varchar(255) NOT NULL COMMENT '供应商官网',
  `legal_person` varchar(20) NOT NULL COMMENT '法人',
  `legal_telphone` varchar(20) NOT NULL COMMENT '法人电话',
  `bank_card` char(20) NOT NULL COMMENT '银行卡卡号',
  `bank_register_name` varchar(255) NOT NULL COMMENT '开户银行',
  `bank_name` varchar(255) NOT NULL COMMENT '开户人',
  `sup_brief` text NOT NULL COMMENT '供应商简介',
  `sup_addtime` int(10) NOT NULL COMMENT '添加时间',
  `province` smallint(6) NOT NULL COMMENT '省份ID',
  `city` smallint(6) NOT NULL COMMENT '城市id',
  `town` smallint(6) NOT NULL COMMENT '地区ID',
  PRIMARY KEY (`sup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8 COMMENT='供应商表（景）';

-- ----------------------------
-- Table structure for test_answer
-- ----------------------------
DROP TABLE IF EXISTS `test_answer`;
CREATE TABLE `test_answer` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `test_id` int(10) NOT NULL DEFAULT '0' COMMENT '所属题目ID',
  `answer_name` varchar(255) NOT NULL COMMENT '答案内容',
  `state` varchar(50) NOT NULL DEFAULT '0',
  `create_time` int(10) DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=utf8 COMMENT='考试题库内容答案表---赵';

-- ----------------------------
-- Table structure for test_cont
-- ----------------------------
DROP TABLE IF EXISTS `test_cont`;
CREATE TABLE `test_cont` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `qustion_title` varchar(255) NOT NULL COMMENT '题目内容',
  `state` varchar(50) DEFAULT NULL COMMENT '正确答案',
  `create_time` int(10) DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `qustion_title` (`qustion_title`)
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8 COMMENT='考试题库表---赵';
