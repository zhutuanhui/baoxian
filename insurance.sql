/*
Navicat MySQL Data Transfer

Source Server         : 保险
Source Server Version : 50718
Source Host           : 10.0.2.16:3306
Source Database       : insurance

Target Server Type    : MYSQL
Target Server Version : 50718
File Encoding         : 65001

Date: 2017-06-01 17:52:26
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
-- Records of add_deductions
-- ----------------------------
INSERT INTO `add_deductions` VALUES ('1', '2', '李杨', '1', '1', null, '1494999296');
INSERT INTO `add_deductions` VALUES ('2', '3', '李杨', '1', '1', null, '1494999296');
INSERT INTO `add_deductions` VALUES ('3', '2', '1000', '0', '0', null, '1495000426');
INSERT INTO `add_deductions` VALUES ('4', '3', '1000', '0', '0', null, '1495000426');
INSERT INTO `add_deductions` VALUES ('5', '2', '李杨', '0', '0', '1000.00', '1495000550');
INSERT INTO `add_deductions` VALUES ('6', '3', '李杨', '0', '0', '1000.00', '1495000550');
INSERT INTO `add_deductions` VALUES ('7', '2', '李杨', '0', '0', '1000.00', '1495000795');
INSERT INTO `add_deductions` VALUES ('8', '3', '李杨', '0', '0', '1000.00', '1495000795');
INSERT INTO `add_deductions` VALUES ('9', '2', '李杨', '0', '0', '1000.00', '1495000882');
INSERT INTO `add_deductions` VALUES ('10', '3', '李杨', '0', '0', '1000.00', '1495000882');
INSERT INTO `add_deductions` VALUES ('11', '2', '李杨', '0', '0', '1000.00', '1495001569');
INSERT INTO `add_deductions` VALUES ('12', '3', '李杨', '0', '0', '1000.00', '1495001569');
INSERT INTO `add_deductions` VALUES ('13', '4', '京冰帅', '0', '0', '2000.00', '1495001569');
INSERT INTO `add_deductions` VALUES ('14', '7519170512', 'luzhitao', '1', '0', '10.00', '1494999296');
INSERT INTO `add_deductions` VALUES ('15', '7519170512', 'luzhbitao', '1', '0', '8.00', '1494999296');
INSERT INTO `add_deductions` VALUES ('16', '7521170516', 'luzhitao ', '1', '0', '20.00', '1494999296');
INSERT INTO `add_deductions` VALUES ('17', '7521170516', 'luyzhgiotao', '0', '0', '30.00', '1494999296');
INSERT INTO `add_deductions` VALUES ('18', '7523170516', 'luzhitao ', '0', '0', '25.00', '1494999296');
INSERT INTO `add_deductions` VALUES ('19', '7526170516', 'luzhitao', '1', '0', '30.00', '1494999296');

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
-- Records of at_item
-- ----------------------------
INSERT INTO `at_item` VALUES ('1', '产品logo图', '服务中心', 'https://image.baidu.com', '/Upload/Item/20170524/5924df9010dec.jpg', '2017-05-23', '2017-05-24', '<p><strong>产品logo图展示轮播</strong></p>', '1', '1', '1495531266', '1495588769');
INSERT INTO `at_item` VALUES ('2', '广告测试', '服务', 'http://tool.chinaz.com/Tools/unixtime.aspx', '/Upload/Item/20170523/592400c74c735.jpg', '2017-05-23', '2017-05-26', '<p>撒打算打算维权网全文</p>', '1', '1', '1495531721', null);
INSERT INTO `at_item` VALUES ('3', '小赵广告测试', '广告测试', 'http://www.baoxian.com', '/Upload/Item/20170524/5924e8307f7e5.jpg', '2017-05-23', '2017-05-26', '<p><span style=\"color: rgb(255, 0, 0);\"><strong>测试一下有没有问题</strong></span></p>', '1', '1', '1495590961', '1495591216');
INSERT INTO `at_item` VALUES ('4', '测试广告', '测试下', 'http://www.baoxian.com', '/Upload/Item/20170524/5924e958737da.jpg', '2017-05-07', '2017-05-09', '<p><em>哈哈哈哈哈哈哈</em></p>', '1', '1', '1495591257', null);

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
-- Records of cash_audit
-- ----------------------------

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
-- Records of cash_log
-- ----------------------------

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
-- Records of check_manpower_quota
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=1171 DEFAULT CHARSET=utf8 COMMENT='考核预警表 王志强';

-- ----------------------------
-- Records of check_warning
-- ----------------------------
INSERT INTO `check_warning` VALUES ('1003', '龙门客栈', '2345', '0', '3', '1', '35', '1000', null, null, '0', '0', '0', '0', '0', '0', '0', '0', '90000.00', '0.00', '-90000.00', null, null, null, null, '1495863231', '1495863231');
INSERT INTO `check_warning` VALUES ('1004', '希尔顿', '11111', '0', '2', '0', '35', '2345', null, null, '0', '0', null, '0', '0', '30', '0', '-30', '60000.00', '0.00', '-60000.00', null, null, null, null, '1495863231', '1495863231');
INSERT INTO `check_warning` VALUES ('1005', '喜来登', '2223', '0', '3', '0', '35', '235', null, '0', '0', '0', '0', '0', '0', '30', '0', '-30', '150000.00', '0.00', '-150000.00', null, null, null, null, '1495863231', '1495863231');
INSERT INTO `check_warning` VALUES ('1006', '圆山大酒店', '2600', '0', '3', '-1', '25', '1000', null, null, '0', '0', '0', '0', '0', '0', '0', '0', '90000.00', '0.00', '-90000.00', null, null, null, null, '1495863231', '1495863231');
INSERT INTO `check_warning` VALUES ('1007', '同福客栈', '35', '0', '3', '0', '25', '12345678', null, '0', '0', '0', '0', '0', '0', '30', '0', '-30', '150000.00', '0.00', '-150000.00', null, null, null, null, '1495863231', '1495863231');
INSERT INTO `check_warning` VALUES ('1008', '潇湘馆', '25', '0', '3', '0', '123456789', '123456789', null, '0', '0', '0', '0', '0', '0', '30', '0', '-30', '150000.00', '0.00', '-150000.00', null, null, null, null, '1495863231', '1495863231');
INSERT INTO `check_warning` VALUES ('1009', '旗舰店', '132332', '0', '2', '0', '100001', '132332', null, null, '0', '0', null, '2', '2', '30', '0', '-30', '60000.00', '0.00', '-60000.00', null, null, null, null, '1495863231', '1495863231');
INSERT INTO `check_warning` VALUES ('1010', '标准店', '1323321', '0', '3', '0', '100001', '132332', null, '0', '0', '0', '0', '0', '0', '30', '0', '-30', '150000.00', '100.00', '-149900.00', null, null, null, null, '1495863231', '1495863231');
INSERT INTO `check_warning` VALUES ('1011', '店铺3', '132332', '0', '3', '0', '1000001', '1000', null, '0', '0', '0', '0', '0', '0', null, '3', '3', '300000.00', '0.00', '-300000.00', null, null, null, null, '1495863231', '1495863231');
INSERT INTO `check_warning` VALUES ('1012', '店铺1', '12335', '0', '3', '0', '1000004', '100004', null, '0', '0', '0', '0', '0', '0', null, '0', '0', '300000.00', '0.00', '-300000.00', null, null, null, null, '1495863231', '1495863231');
INSERT INTO `check_warning` VALUES ('1013', '店铺1', '12335', '0', '3', '0', '1000004', '100004', null, '0', '0', '0', '0', '0', '0', null, '0', '0', '300000.00', '0.00', '-300000.00', null, null, null, null, '1495863231', '1495863231');
INSERT INTO `check_warning` VALUES ('1014', '卢标经营', '2147483647', '0', '3', '-1', '100003', '2147483647', null, null, '0', '0', '0', '0', '0', '0', '0', '0', '180000.00', '0.00', '-180000.00', null, null, null, null, '1495863231', '1495863231');
INSERT INTO `check_warning` VALUES ('1015', '卢旗舰经营', '2147483647', '0', '2', '1', '100003', '2147483647', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1495863231', '1495863231');
INSERT INTO `check_warning` VALUES ('1016', '卢标筹备', '2147483647', '0', '3', '0', '100003', '2147483647', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1495863231', '1495863231');
INSERT INTO `check_warning` VALUES ('1017', '卢旗舰筹备', '2147483647', '0', '2', '0', '100003', '2147483647', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1495863231', '1495863231');
INSERT INTO `check_warning` VALUES ('1018', '卢旗舰观察', '2147483647', '0', '2', '-1', '100003', '2147483647', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1495863231', '1495863231');
INSERT INTO `check_warning` VALUES ('1019', '龙门客栈', '2345', '1', '3', '1', '35', '1000', null, null, '0', '0', '0', '0', '0', '0', '0', '0', '90000.00', '0.00', '-90000.00', null, null, null, '0', '1495863313', '1495863313');
INSERT INTO `check_warning` VALUES ('1020', '圆山大酒店', '2600', '1', '3', '-1', '25', '1000', null, null, '0', '0', '0', '0', '0', '0', '0', '0', '90000.00', '0.00', '-90000.00', null, null, null, '1', '1495863313', '1495863313');
INSERT INTO `check_warning` VALUES ('1021', '卢标经营', '2147483647', '1', '3', '-1', '100003', '2147483647', null, null, '0', '0', '0', '0', '0', '0', '0', '0', '180000.00', '0.00', '-180000.00', null, null, null, '1', '1495863313', '1495863313');
INSERT INTO `check_warning` VALUES ('1022', '卢旗舰经营', '2147483647', '1', '2', '1', '100003', '2147483647', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1', '1495863313', '1495863313');
INSERT INTO `check_warning` VALUES ('1023', '卢旗舰观察', '2147483647', '1', '2', '-1', '100003', '2147483647', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1', '1495863313', '1495863313');
INSERT INTO `check_warning` VALUES ('1024', '龙门客栈', '2345', '0', '3', '-1', '2147483647', '1000', null, null, '0', '0', '0', '0', '0', '0', '0', '0', '90000.00', '0.00', '-90000.00', null, null, null, null, '1496195466', '1496195466');
INSERT INTO `check_warning` VALUES ('1025', '希尔顿', '11111', '0', '2', '0', '2147483647', '2345', null, null, '0', '0', null, '0', '0', '30', '0', '-30', '60000.00', '0.00', '-60000.00', null, null, null, null, '1496195466', '1496195466');
INSERT INTO `check_warning` VALUES ('1026', '喜来登', '2223', '0', '3', '0', '2147483647', '235', null, '0', '0', '0', '0', '0', '0', '30', '0', '-30', '150000.00', '0.00', '-150000.00', null, null, null, null, '1496195466', '1496195466');
INSERT INTO `check_warning` VALUES ('1027', '圆山大酒店', '2600', '0', '3', '1', '25', '1000', null, null, '0', '0', '0', '0', '0', '0', '0', '0', '90000.00', '0.00', '-90000.00', null, null, null, null, '1496195466', '1496195466');
INSERT INTO `check_warning` VALUES ('1028', '同福客栈', '35', '0', '3', '0', '25', '12345678', null, '0', '0', '0', '0', '0', '0', '30', '0', '-30', '150000.00', '0.00', '-150000.00', null, null, null, null, '1496195466', '1496195466');
INSERT INTO `check_warning` VALUES ('1029', '潇湘馆', '25', '0', '3', '0', '123456789', '123456789', null, '0', '0', '0', '0', '0', '0', '30', '0', '-30', '150000.00', '0.00', '-150000.00', null, null, null, null, '1496195466', '1496195466');
INSERT INTO `check_warning` VALUES ('1030', '旗舰店', '132332', '0', '2', '0', '100001', '132332', null, null, '0', '0', null, '2', '2', '30', '0', '-30', '60000.00', '0.00', '-60000.00', null, null, null, null, '1496195466', '1496195466');
INSERT INTO `check_warning` VALUES ('1031', '标准店', '1323321', '0', '3', '0', '100001', '132332', null, '0', '0', '0', '0', '0', '0', '30', '0', '-30', '150000.00', '100.00', '-149900.00', null, null, null, null, '1496195466', '1496195466');
INSERT INTO `check_warning` VALUES ('1032', '店铺3', '132332', '0', '3', '0', '123456789', '1000', null, '0', '0', '0', '0', '0', '0', null, '3', '3', '300000.00', '0.00', '-300000.00', null, null, null, null, '1496195466', '1496195466');
INSERT INTO `check_warning` VALUES ('1033', '店铺1', '12335', '0', '3', '0', '123456789', '100004', null, '0', '0', '0', '0', '0', '0', null, '0', '0', '300000.00', '0.00', '-300000.00', null, null, null, null, '1496195466', '1496195466');
INSERT INTO `check_warning` VALUES ('1034', '店铺1', '12335', '0', '3', '0', '123456789', '100004', null, '0', '0', '0', '0', '0', '0', null, '0', '0', '300000.00', '0.00', '-300000.00', null, null, null, null, '1496195466', '1496195466');
INSERT INTO `check_warning` VALUES ('1035', '卢标经营', '2147483647', '0', '3', '1', '100003', '2147483647', null, null, '0', '0', '0', '0', '0', '0', '0', '0', '180000.00', '0.00', '-180000.00', null, null, null, null, '1496195466', '1496195466');
INSERT INTO `check_warning` VALUES ('1036', '卢旗舰经营', '2147483647', '0', '2', '1', '100003', '2147483647', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1496195466', '1496195466');
INSERT INTO `check_warning` VALUES ('1037', '卢标筹备', '2147483647', '0', '3', '0', '100003', '2147483647', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1496195466', '1496195466');
INSERT INTO `check_warning` VALUES ('1038', '卢旗舰筹备', '2147483647', '0', '2', '0', '2147483647', '2147483647', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1496195466', '1496195466');
INSERT INTO `check_warning` VALUES ('1039', '卢旗舰观察', '2147483647', '0', '2', '-1', '100003', '2147483647', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1496195466', '1496195466');
INSERT INTO `check_warning` VALUES ('1040', '龙门客栈', '2345', '0', '3', '-1', '3905170511', '1000', null, null, '0', '0', '0', '0', '0', '0', '0', '0', '90000.00', '0.00', '-90000.00', null, null, null, null, '1496281106', '1496281106');
INSERT INTO `check_warning` VALUES ('1041', '希尔顿', '11111', '0', '2', '0', '3905170511', '2345', null, null, '0', '0', null, '0', '0', '30', '0', '-30', '60000.00', '0.00', '-60000.00', null, null, null, null, '1496281106', '1496281106');
INSERT INTO `check_warning` VALUES ('1042', '喜来登', '2223', '0', '3', '0', '3905170511', '235', null, '0', '0', '0', '0', '0', '0', '30', '0', '-30', '150000.00', '0.00', '-150000.00', null, null, null, null, '1496281106', '1496281106');
INSERT INTO `check_warning` VALUES ('1043', '圆山大酒店', '2600', '0', '3', '1', '25', '1000', null, null, '0', '0', '0', '0', '0', '0', '0', '0', '90000.00', '0.00', '-90000.00', null, null, null, null, '1496281106', '1496281106');
INSERT INTO `check_warning` VALUES ('1044', '同福客栈', '35', '0', '3', '0', '25', '12345678', null, '0', '0', '0', '0', '0', '0', '30', '0', '-30', '150000.00', '0.00', '-150000.00', null, null, null, null, '1496281106', '1496281106');
INSERT INTO `check_warning` VALUES ('1045', '潇湘馆', '25', '0', '3', '0', '123456789', '123456789', null, '0', '0', '0', '0', '0', '0', '30', '0', '-30', '150000.00', '0.00', '-150000.00', null, null, null, null, '1496281106', '1496281106');
INSERT INTO `check_warning` VALUES ('1046', '旗舰店', '132332', '0', '2', '0', '100001', '132332', null, null, '0', '0', null, '2', '2', '30', '0', '-30', '60000.00', '0.00', '-60000.00', null, null, null, null, '1496281106', '1496281106');
INSERT INTO `check_warning` VALUES ('1047', '标准店', '1323321', '0', '3', '0', '100001', '132332', null, '0', '0', '0', '0', '0', '0', '30', '0', '-30', '150000.00', '600.12', '-149399.88', null, null, null, null, '1496281106', '1496281106');
INSERT INTO `check_warning` VALUES ('1048', '店铺3', '132332', '0', '3', '0', '123456789', '1000', null, '0', '0', '0', '0', '0', '0', null, '3', '3', '300000.00', '400.36', '-299599.64', null, null, null, null, '1496281106', '1496281106');
INSERT INTO `check_warning` VALUES ('1049', '店铺1', '12335', '0', '3', '0', '123456789', '100004', null, '0', '0', '0', '0', '0', '0', null, '0', '0', '300000.00', '0.00', '-300000.00', null, null, null, null, '1496281106', '1496281106');
INSERT INTO `check_warning` VALUES ('1050', '店铺1', '12335', '0', '3', '0', '123456789', '100004', null, '0', '0', '0', '0', '0', '0', null, '0', '0', '300000.00', '0.00', '-300000.00', null, null, null, null, '1496281106', '1496281106');
INSERT INTO `check_warning` VALUES ('1051', '卢标经营', '7522170516', '0', '3', '1', '100003', '7518170516', null, null, '0', '0', '0', '0', '0', '0', '0', '0', '180000.00', '0.00', '-180000.00', null, null, null, null, '1496281106', '1496281106');
INSERT INTO `check_warning` VALUES ('1052', '卢旗舰经营', '7518170516', '0', '2', '1', '100003', '7518170516', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1496281106', '1496281106');
INSERT INTO `check_warning` VALUES ('1053', '卢标筹备', '7520170244', '0', '3', '0', '100003', '7520170244', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1496281106', '1496281106');
INSERT INTO `check_warning` VALUES ('1054', '卢旗舰筹备', '7525170516', '0', '2', '0', '3905170511', '7525170516', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1496281106', '1496281106');
INSERT INTO `check_warning` VALUES ('1055', '卢旗舰观察', '7527170516', '0', '2', '-1', '100003', '7527170516', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1496281106', '1496281106');
INSERT INTO `check_warning` VALUES ('1056', '龙门客栈', '2345', '0', '3', '-1', '3905170511', '1000', null, null, '0', '0', '0', '0', '0', '0', '0', '0', '90000.00', '0.00', '-90000.00', null, null, null, null, '1496281111', '1496281111');
INSERT INTO `check_warning` VALUES ('1057', '希尔顿', '11111', '0', '2', '0', '3905170511', '2345', null, null, '0', '0', null, '0', '0', '30', '0', '-30', '60000.00', '0.00', '-60000.00', null, null, null, null, '1496281111', '1496281111');
INSERT INTO `check_warning` VALUES ('1058', '喜来登', '2223', '0', '3', '0', '3905170511', '235', null, '0', '0', '0', '0', '0', '0', '30', '0', '-30', '150000.00', '0.00', '-150000.00', null, null, null, null, '1496281111', '1496281111');
INSERT INTO `check_warning` VALUES ('1059', '圆山大酒店', '2600', '0', '3', '1', '25', '1000', null, null, '0', '0', '0', '0', '0', '0', '0', '0', '90000.00', '0.00', '-90000.00', null, null, null, null, '1496281111', '1496281111');
INSERT INTO `check_warning` VALUES ('1060', '同福客栈', '35', '0', '3', '0', '25', '12345678', null, '0', '0', '0', '0', '0', '0', '30', '0', '-30', '150000.00', '0.00', '-150000.00', null, null, null, null, '1496281111', '1496281111');
INSERT INTO `check_warning` VALUES ('1061', '潇湘馆', '25', '0', '3', '0', '123456789', '123456789', null, '0', '0', '0', '0', '0', '0', '30', '0', '-30', '150000.00', '0.00', '-150000.00', null, null, null, null, '1496281111', '1496281111');
INSERT INTO `check_warning` VALUES ('1062', '旗舰店', '132332', '0', '2', '0', '100001', '132332', null, null, '0', '0', null, '2', '2', '30', '0', '-30', '60000.00', '0.00', '-60000.00', null, null, null, null, '1496281111', '1496281111');
INSERT INTO `check_warning` VALUES ('1063', '标准店', '1323321', '0', '3', '0', '100001', '132332', null, '0', '0', '0', '0', '0', '0', '30', '0', '-30', '150000.00', '600.12', '-149399.88', null, null, null, null, '1496281111', '1496281111');
INSERT INTO `check_warning` VALUES ('1064', '店铺3', '132332', '0', '3', '0', '123456789', '1000', null, '0', '0', '0', '0', '0', '0', null, '3', '3', '300000.00', '400.36', '-299599.64', null, null, null, null, '1496281111', '1496281111');
INSERT INTO `check_warning` VALUES ('1065', '店铺1', '12335', '0', '3', '0', '123456789', '100004', null, '0', '0', '0', '0', '0', '0', null, '0', '0', '300000.00', '0.00', '-300000.00', null, null, null, null, '1496281111', '1496281111');
INSERT INTO `check_warning` VALUES ('1066', '店铺1', '12335', '0', '3', '0', '123456789', '100004', null, '0', '0', '0', '0', '0', '0', null, '0', '0', '300000.00', '0.00', '-300000.00', null, null, null, null, '1496281111', '1496281111');
INSERT INTO `check_warning` VALUES ('1067', '卢标经营', '7522170516', '0', '3', '1', '100003', '7518170516', null, null, '0', '0', '0', '0', '0', '0', '0', '0', '180000.00', '0.00', '-180000.00', null, null, null, null, '1496281111', '1496281111');
INSERT INTO `check_warning` VALUES ('1068', '卢旗舰经营', '7518170516', '0', '2', '1', '100003', '7518170516', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1496281111', '1496281111');
INSERT INTO `check_warning` VALUES ('1069', '卢标筹备', '7520170244', '0', '3', '0', '100003', '7520170244', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1496281111', '1496281111');
INSERT INTO `check_warning` VALUES ('1070', '卢旗舰筹备', '7525170516', '0', '2', '0', '3905170511', '7525170516', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1496281111', '1496281111');
INSERT INTO `check_warning` VALUES ('1071', '卢旗舰观察', '7527170516', '0', '2', '-1', '100003', '7527170516', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1496281111', '1496281111');
INSERT INTO `check_warning` VALUES ('1072', '龙门客栈', '2345', '0', '3', '-1', '3905170511', '1000', null, null, '0', '0', '0', '0', '0', '0', '0', '0', '90000.00', '0.00', '-90000.00', null, null, null, null, '1496281969', '1496281969');
INSERT INTO `check_warning` VALUES ('1073', '希尔顿', '11111', '0', '2', '0', '3905170511', '2345', null, null, '0', '0', null, '0', '0', '30', '0', '-30', '60000.00', '0.00', '-60000.00', null, null, null, null, '1496281969', '1496281969');
INSERT INTO `check_warning` VALUES ('1074', '喜来登', '2223', '0', '3', '0', '3905170511', '235', null, '0', '0', '0', '0', '0', '0', '30', '0', '-30', '150000.00', '0.00', '-150000.00', null, null, null, null, '1496281969', '1496281969');
INSERT INTO `check_warning` VALUES ('1075', '圆山大酒店', '2600', '0', '3', '1', '25', '1000', null, null, '0', '0', '0', '0', '0', '0', '0', '0', '90000.00', '0.00', '-90000.00', null, null, null, null, '1496281969', '1496281969');
INSERT INTO `check_warning` VALUES ('1076', '同福客栈', '35', '0', '3', '0', '25', '12345678', null, '0', '0', '0', '0', '0', '0', '30', '0', '-30', '150000.00', '0.00', '-150000.00', null, null, null, null, '1496281969', '1496281969');
INSERT INTO `check_warning` VALUES ('1077', '潇湘馆', '25', '0', '3', '0', '123456789', '123456789', null, '0', '0', '0', '0', '0', '0', '30', '0', '-30', '150000.00', '0.00', '-150000.00', null, null, null, null, '1496281969', '1496281969');
INSERT INTO `check_warning` VALUES ('1078', '旗舰店', '132332', '0', '2', '0', '100001', '132332', null, null, '0', '0', null, '2', '2', '30', '0', '-30', '60000.00', '0.00', '-60000.00', null, null, null, null, '1496281969', '1496281969');
INSERT INTO `check_warning` VALUES ('1079', '标准店', '1323321', '0', '3', '0', '100001', '132332', null, '0', '0', '0', '0', '0', '0', '30', '0', '-30', '150000.00', '600.12', '-149399.88', null, null, null, null, '1496281969', '1496281969');
INSERT INTO `check_warning` VALUES ('1080', '店铺3', '132332', '0', '3', '0', '123456789', '1000', null, '0', '0', '0', '0', '0', '0', null, '3', '3', '300000.00', '400.36', '-299599.64', null, null, null, null, '1496281969', '1496281969');
INSERT INTO `check_warning` VALUES ('1081', '店铺1', '12335', '0', '3', '0', '123456789', '100004', null, '0', '0', '0', '0', '0', '0', null, '0', '0', '300000.00', '0.00', '-300000.00', null, null, null, null, '1496281969', '1496281969');
INSERT INTO `check_warning` VALUES ('1082', '店铺1', '12335', '0', '3', '0', '123456789', '100004', null, '0', '0', '0', '0', '0', '0', null, '0', '0', '300000.00', '0.00', '-300000.00', null, null, null, null, '1496281969', '1496281969');
INSERT INTO `check_warning` VALUES ('1083', '卢标经营', '7522170516', '0', '3', '1', '100003', '7518170516', null, null, '0', '0', '0', '0', '0', '0', '0', '0', '180000.00', '0.00', '-180000.00', null, null, null, null, '1496281969', '1496281969');
INSERT INTO `check_warning` VALUES ('1084', '卢旗舰经营', '7518170516', '0', '2', '1', '100003', '7518170516', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1496281969', '1496281969');
INSERT INTO `check_warning` VALUES ('1085', '卢标筹备', '7520170244', '0', '3', '0', '100003', '7520170244', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1496281969', '1496281969');
INSERT INTO `check_warning` VALUES ('1086', '卢旗舰筹备', '7525170516', '0', '2', '0', '3905170511', '7525170516', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1496281969', '1496281969');
INSERT INTO `check_warning` VALUES ('1087', '卢旗舰观察', '7527170516', '0', '2', '-1', '100003', '7527170516', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1496281969', '1496281969');
INSERT INTO `check_warning` VALUES ('1088', '龙门客栈', '2345', '0', '3', '-1', '3905170511', '1000', null, null, '0', '0', '0', '0', '0', '0', '0', '0', '90000.00', '0.00', '-90000.00', null, null, null, null, '1496281977', '1496281977');
INSERT INTO `check_warning` VALUES ('1089', '希尔顿', '11111', '0', '2', '0', '3905170511', '2345', null, null, '0', '0', null, '0', '0', '30', '0', '-30', '60000.00', '0.00', '-60000.00', null, null, null, null, '1496281977', '1496281977');
INSERT INTO `check_warning` VALUES ('1090', '喜来登', '2223', '0', '3', '0', '3905170511', '235', null, '0', '0', '0', '0', '0', '0', '30', '0', '-30', '150000.00', '0.00', '-150000.00', null, null, null, null, '1496281977', '1496281977');
INSERT INTO `check_warning` VALUES ('1091', '圆山大酒店', '2600', '0', '3', '1', '25', '1000', null, null, '0', '0', '0', '0', '0', '0', '0', '0', '90000.00', '0.00', '-90000.00', null, null, null, null, '1496281977', '1496281977');
INSERT INTO `check_warning` VALUES ('1092', '同福客栈', '35', '0', '3', '0', '25', '12345678', null, '0', '0', '0', '0', '0', '0', '30', '0', '-30', '150000.00', '0.00', '-150000.00', null, null, null, null, '1496281977', '1496281977');
INSERT INTO `check_warning` VALUES ('1093', '潇湘馆', '25', '0', '3', '0', '123456789', '123456789', null, '0', '0', '0', '0', '0', '0', '30', '0', '-30', '150000.00', '0.00', '-150000.00', null, null, null, null, '1496281977', '1496281977');
INSERT INTO `check_warning` VALUES ('1094', '旗舰店', '132332', '0', '2', '0', '100001', '132332', null, null, '0', '0', null, '2', '2', '30', '0', '-30', '60000.00', '0.00', '-60000.00', null, null, null, null, '1496281977', '1496281977');
INSERT INTO `check_warning` VALUES ('1095', '标准店', '1323321', '0', '3', '0', '100001', '132332', null, '0', '0', '0', '0', '0', '0', '30', '0', '-30', '150000.00', '600.12', '-149399.88', null, null, null, null, '1496281977', '1496281977');
INSERT INTO `check_warning` VALUES ('1096', '店铺3', '132332', '0', '3', '0', '123456789', '1000', null, '0', '0', '0', '0', '0', '0', null, '3', '3', '300000.00', '400.36', '-299599.64', null, null, null, null, '1496281977', '1496281977');
INSERT INTO `check_warning` VALUES ('1097', '店铺1', '12335', '0', '3', '0', '123456789', '100004', null, '0', '0', '0', '0', '0', '0', null, '0', '0', '300000.00', '0.00', '-300000.00', null, null, null, null, '1496281977', '1496281977');
INSERT INTO `check_warning` VALUES ('1098', '店铺1', '12335', '0', '3', '0', '123456789', '100004', null, '0', '0', '0', '0', '0', '0', null, '0', '0', '300000.00', '0.00', '-300000.00', null, null, null, null, '1496281977', '1496281977');
INSERT INTO `check_warning` VALUES ('1099', '卢标经营', '7522170516', '0', '3', '1', '100003', '7518170516', null, null, '0', '0', '0', '0', '0', '0', '0', '0', '180000.00', '0.00', '-180000.00', null, null, null, null, '1496281977', '1496281977');
INSERT INTO `check_warning` VALUES ('1100', '卢旗舰经营', '7518170516', '0', '2', '1', '100003', '7518170516', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1496281977', '1496281977');
INSERT INTO `check_warning` VALUES ('1101', '卢标筹备', '7520170244', '0', '3', '0', '100003', '7520170244', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1496281977', '1496281977');
INSERT INTO `check_warning` VALUES ('1102', '卢旗舰筹备', '7525170516', '0', '2', '0', '3905170511', '7525170516', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1496281977', '1496281977');
INSERT INTO `check_warning` VALUES ('1103', '卢旗舰观察', '7527170516', '0', '2', '-1', '100003', '7527170516', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1496281977', '1496281977');
INSERT INTO `check_warning` VALUES ('1104', '龙门客栈', '2345', '0', '3', '-1', '3905170511', '1000', null, null, '0', '0', '0', '0', '0', '0', '0', '0', '90000.00', '0.00', '-90000.00', null, null, null, null, '1496282005', '1496282005');
INSERT INTO `check_warning` VALUES ('1105', '希尔顿', '11111', '0', '2', '0', '3905170511', '2345', null, null, '0', '0', null, '0', '0', '30', '0', '-30', '60000.00', '0.00', '-60000.00', null, null, null, null, '1496282005', '1496282005');
INSERT INTO `check_warning` VALUES ('1106', '喜来登', '2223', '0', '3', '0', '3905170511', '235', null, '0', '0', '0', '0', '0', '0', '30', '0', '-30', '150000.00', '0.00', '-150000.00', null, null, null, null, '1496282005', '1496282005');
INSERT INTO `check_warning` VALUES ('1107', '圆山大酒店', '2600', '0', '3', '1', '25', '1000', null, null, '0', '0', '0', '0', '0', '0', '0', '0', '90000.00', '0.00', '-90000.00', null, null, null, null, '1496282005', '1496282005');
INSERT INTO `check_warning` VALUES ('1108', '同福客栈', '35', '0', '3', '0', '25', '12345678', null, '0', '0', '0', '0', '0', '0', '30', '0', '-30', '150000.00', '0.00', '-150000.00', null, null, null, null, '1496282005', '1496282005');
INSERT INTO `check_warning` VALUES ('1109', '潇湘馆', '25', '0', '3', '0', '123456789', '123456789', null, '0', '0', '0', '0', '0', '0', '30', '0', '-30', '150000.00', '0.00', '-150000.00', null, null, null, null, '1496282005', '1496282005');
INSERT INTO `check_warning` VALUES ('1110', '旗舰店', '132332', '0', '2', '0', '100001', '132332', null, null, '0', '0', null, '2', '2', '30', '0', '-30', '60000.00', '0.00', '-60000.00', null, null, null, null, '1496282005', '1496282005');
INSERT INTO `check_warning` VALUES ('1111', '标准店', '1323321', '0', '3', '0', '100001', '132332', null, '0', '0', '0', '0', '0', '0', '30', '0', '-30', '150000.00', '600.12', '-149399.88', null, null, null, null, '1496282005', '1496282005');
INSERT INTO `check_warning` VALUES ('1112', '店铺3', '132332', '0', '3', '0', '123456789', '1000', null, '0', '0', '0', '0', '0', '0', null, '3', '3', '300000.00', '400.36', '-299599.64', null, null, null, null, '1496282005', '1496282005');
INSERT INTO `check_warning` VALUES ('1113', '店铺1', '12335', '0', '3', '0', '123456789', '100004', null, '0', '0', '0', '0', '0', '0', null, '0', '0', '300000.00', '0.00', '-300000.00', null, null, null, null, '1496282005', '1496282005');
INSERT INTO `check_warning` VALUES ('1114', '店铺1', '12335', '0', '3', '0', '123456789', '100004', null, '0', '0', '0', '0', '0', '0', null, '0', '0', '300000.00', '0.00', '-300000.00', null, null, null, null, '1496282005', '1496282005');
INSERT INTO `check_warning` VALUES ('1115', '卢标经营', '7522170516', '0', '3', '1', '100003', '7518170516', null, null, '0', '0', '0', '0', '0', '0', '0', '0', '180000.00', '0.00', '-180000.00', null, null, null, null, '1496282005', '1496282005');
INSERT INTO `check_warning` VALUES ('1116', '卢旗舰经营', '7518170516', '0', '2', '1', '100003', '7518170516', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1496282005', '1496282005');
INSERT INTO `check_warning` VALUES ('1117', '卢标筹备', '7520170244', '0', '3', '0', '100003', '7520170244', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1496282005', '1496282005');
INSERT INTO `check_warning` VALUES ('1118', '卢旗舰筹备', '7525170516', '0', '2', '0', '3905170511', '7525170516', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1496282005', '1496282005');
INSERT INTO `check_warning` VALUES ('1119', '卢旗舰观察', '7527170516', '0', '2', '-1', '100003', '7527170516', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1496282005', '1496282005');
INSERT INTO `check_warning` VALUES ('1120', '龙门客栈', '2345', '0', '3', '-1', '3905170511', '1000', null, null, '0', '0', '0', '0', '0', '0', '0', '0', '90000.00', '0.00', '-90000.00', null, null, null, null, '1496282101', '1496282101');
INSERT INTO `check_warning` VALUES ('1121', '希尔顿', '11111', '0', '2', '0', '3905170511', '2345', null, null, '0', '0', null, '0', '0', '30', '0', '-30', '60000.00', '0.00', '-60000.00', null, null, null, null, '1496282101', '1496282101');
INSERT INTO `check_warning` VALUES ('1122', '喜来登', '2223', '0', '3', '0', '3905170511', '235', null, '0', '0', '0', '0', '0', '0', '30', '0', '-30', '150000.00', '0.00', '-150000.00', null, null, null, null, '1496282101', '1496282101');
INSERT INTO `check_warning` VALUES ('1123', '圆山大酒店', '2600', '0', '3', '1', '25', '1000', null, null, '0', '0', '0', '0', '0', '0', '0', '0', '90000.00', '0.00', '-90000.00', null, null, null, null, '1496282101', '1496282101');
INSERT INTO `check_warning` VALUES ('1124', '同福客栈', '35', '0', '3', '0', '25', '12345678', null, '0', '0', '0', '0', '0', '0', '30', '0', '-30', '150000.00', '0.00', '-150000.00', null, null, null, null, '1496282101', '1496282101');
INSERT INTO `check_warning` VALUES ('1125', '潇湘馆', '25', '0', '3', '0', '123456789', '123456789', null, '0', '0', '0', '0', '0', '0', '30', '0', '-30', '150000.00', '0.00', '-150000.00', null, null, null, null, '1496282101', '1496282101');
INSERT INTO `check_warning` VALUES ('1126', '旗舰店', '132332', '0', '2', '0', '100001', '132332', null, null, '0', '0', null, '2', '2', '30', '0', '-30', '60000.00', '0.00', '-60000.00', null, null, null, null, '1496282101', '1496282101');
INSERT INTO `check_warning` VALUES ('1127', '标准店', '1323321', '0', '3', '0', '100001', '132332', null, '0', '0', '0', '0', '0', '0', '30', '0', '-30', '150000.00', '600.12', '-149399.88', null, null, null, null, '1496282101', '1496282101');
INSERT INTO `check_warning` VALUES ('1128', '店铺3', '132332', '0', '3', '0', '123456789', '1000', null, '0', '0', '0', '0', '0', '0', null, '3', '3', '300000.00', '400.36', '-299599.64', null, null, null, null, '1496282101', '1496282101');
INSERT INTO `check_warning` VALUES ('1129', '店铺1', '12335', '0', '3', '0', '123456789', '100004', null, '0', '0', '0', '0', '0', '0', null, '0', '0', '300000.00', '0.00', '-300000.00', null, null, null, null, '1496282101', '1496282101');
INSERT INTO `check_warning` VALUES ('1130', '店铺1', '12335', '0', '3', '0', '123456789', '100004', null, '0', '0', '0', '0', '0', '0', null, '0', '0', '300000.00', '0.00', '-300000.00', null, null, null, null, '1496282101', '1496282101');
INSERT INTO `check_warning` VALUES ('1131', '卢标经营', '7522170516', '0', '3', '1', '100003', '7518170516', null, null, '0', '0', '0', '0', '0', '0', '0', '0', '180000.00', '0.00', '-180000.00', null, null, null, null, '1496282101', '1496282101');
INSERT INTO `check_warning` VALUES ('1132', '卢旗舰经营', '7518170516', '0', '2', '1', '100003', '7518170516', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1496282101', '1496282101');
INSERT INTO `check_warning` VALUES ('1133', '卢标筹备', '7520170244', '0', '3', '0', '100003', '7520170244', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1496282101', '1496282101');
INSERT INTO `check_warning` VALUES ('1134', '卢旗舰筹备', '7525170516', '0', '2', '0', '3905170511', '7525170516', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1496282101', '1496282101');
INSERT INTO `check_warning` VALUES ('1135', '卢旗舰观察', '7527170516', '0', '2', '-1', '100003', '7527170516', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1496282101', '1496282101');
INSERT INTO `check_warning` VALUES ('1136', '旗舰店', '132332', '1', '2', '0', '100001', '132332', null, null, '0', '0', null, '2', '2', '30', '0', '-30', '60000.00', '0.00', '-60000.00', null, null, null, '1', '1496282295', '1496282295');
INSERT INTO `check_warning` VALUES ('1137', '标准店', '1323321', '1', '3', '0', '100001', '132332', null, '0', '0', '0', '0', '0', '0', '30', '0', '-30', '150000.00', '600.12', '-149399.88', null, null, null, '0', '1496282295', '1496282295');
INSERT INTO `check_warning` VALUES ('1138', '店铺3', '132332', '1', '3', '0', '123456789', '1000', null, '0', '0', '0', '0', '0', '0', null, '3', '3', '300000.00', '400.36', '-299599.64', null, null, null, '0', '1496282295', '1496282295');
INSERT INTO `check_warning` VALUES ('1139', '龙门客栈', '2345', '0', '3', '-1', '3905170511', '1000', null, null, '0', '0', '0', '0', '0', '0', '0', '0', '90000.00', '0.00', '-90000.00', null, null, null, null, '1496282929', '1496282929');
INSERT INTO `check_warning` VALUES ('1140', '希尔顿', '11111', '0', '2', '0', '3905170511', '2345', null, null, '0', '0', null, '0', '0', '30', '0', '-30', '60000.00', '0.00', '-60000.00', null, null, null, null, '1496282929', '1496282929');
INSERT INTO `check_warning` VALUES ('1141', '喜来登', '2223', '0', '3', '0', '3905170511', '235', null, '0', '0', '0', '0', '0', '0', '30', '0', '-30', '150000.00', '0.00', '-150000.00', null, null, null, null, '1496282929', '1496282929');
INSERT INTO `check_warning` VALUES ('1142', '圆山大酒店', '2600', '0', '3', '1', '25', '1000', null, null, '0', '0', '0', '0', '0', '0', '0', '0', '90000.00', '0.00', '-90000.00', null, null, null, null, '1496282929', '1496282929');
INSERT INTO `check_warning` VALUES ('1143', '同福客栈', '35', '0', '3', '0', '25', '12345678', null, '0', '0', '0', '0', '0', '0', '30', '0', '-30', '150000.00', '0.00', '-150000.00', null, null, null, null, '1496282929', '1496282929');
INSERT INTO `check_warning` VALUES ('1144', '潇湘馆', '25', '0', '3', '0', '123456789', '123456789', null, '0', '0', '0', '0', '0', '0', '30', '0', '-30', '150000.00', '0.00', '-150000.00', null, null, null, null, '1496282929', '1496282929');
INSERT INTO `check_warning` VALUES ('1145', '旗舰店', '132332', '0', '2', '0', '100001', '132332', null, null, '0', '0', null, '2', '2', '30', '0', '-30', '60000.00', '0.00', '-60000.00', null, null, null, null, '1496282929', '1496282929');
INSERT INTO `check_warning` VALUES ('1146', '标准店', '1323321', '0', '3', '0', '100001', '132332', null, '0', '0', '0', '0', '0', '0', '30', '0', '-30', '150000.00', '600.12', '-149399.88', null, null, null, null, '1496282929', '1496282929');
INSERT INTO `check_warning` VALUES ('1147', '店铺3', '132332', '0', '3', '0', '123456789', '1000', null, '0', '0', '0', '0', '0', '0', null, '3', '3', '300000.00', '400.36', '-299599.64', null, null, null, null, '1496282929', '1496282929');
INSERT INTO `check_warning` VALUES ('1148', '店铺1', '12335', '0', '3', '0', '123456789', '100004', null, '0', '0', '0', '0', '0', '0', null, '0', '0', '300000.00', '0.00', '-300000.00', null, null, null, null, '1496282929', '1496282929');
INSERT INTO `check_warning` VALUES ('1149', '店铺1', '12335', '0', '3', '0', '123456789', '100004', null, '0', '0', '0', '0', '0', '0', null, '0', '0', '300000.00', '0.00', '-300000.00', null, null, null, null, '1496282929', '1496282929');
INSERT INTO `check_warning` VALUES ('1150', '卢标经营', '7522170516', '0', '3', '1', '100003', '7518170516', null, null, '0', '0', '0', '0', '0', '0', '0', '0', '180000.00', '0.00', '-180000.00', null, null, null, null, '1496282929', '1496282929');
INSERT INTO `check_warning` VALUES ('1151', '卢旗舰经营', '7518170516', '0', '2', '1', '100003', '7518170516', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1496282929', '1496282929');
INSERT INTO `check_warning` VALUES ('1152', '卢标筹备', '7520170244', '0', '3', '0', '100003', '7520170244', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1496282929', '1496282929');
INSERT INTO `check_warning` VALUES ('1153', '卢旗舰筹备', '7525170516', '0', '2', '0', '3905170511', '7525170516', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1496282929', '1496282929');
INSERT INTO `check_warning` VALUES ('1154', '卢旗舰观察', '7527170516', '0', '2', '-1', '100003', '7527170516', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1496282929', '1496282929');
INSERT INTO `check_warning` VALUES ('1155', '龙门客栈', '2345', '0', '3', '-1', '3905170511', '1000', null, null, '0', '0', '0', '0', '0', '0', '0', '0', '90000.00', '0.00', '-90000.00', null, null, null, null, '1496310035', '1496310035');
INSERT INTO `check_warning` VALUES ('1156', '希尔顿', '11111', '0', '2', '0', '3905170511', '2345', null, null, '0', '0', null, '0', '0', '30', '0', '-30', '60000.00', '0.00', '-60000.00', null, null, null, null, '1496310035', '1496310035');
INSERT INTO `check_warning` VALUES ('1157', '喜来登', '2223', '0', '3', '0', '3905170511', '235', null, '0', '0', '0', '0', '0', '0', '30', '0', '-30', '150000.00', '0.00', '-150000.00', null, null, null, null, '1496310035', '1496310035');
INSERT INTO `check_warning` VALUES ('1158', '圆山大酒店', '2600', '0', '3', '1', '25', '1000', null, null, '0', '0', '0', '0', '0', '0', '0', '0', '90000.00', '0.00', '-90000.00', null, null, null, null, '1496310035', '1496310035');
INSERT INTO `check_warning` VALUES ('1159', '同福客栈', '35', '0', '3', '0', '25', '12345678', null, '0', '0', '0', '0', '0', '0', '30', '0', '-30', '150000.00', '0.00', '-150000.00', null, null, null, null, '1496310035', '1496310035');
INSERT INTO `check_warning` VALUES ('1160', '潇湘馆', '25', '0', '3', '0', '123456789', '123456789', null, '0', '0', '0', '0', '0', '0', '30', '0', '-30', '150000.00', '0.00', '-150000.00', null, null, null, null, '1496310035', '1496310035');
INSERT INTO `check_warning` VALUES ('1161', '旗舰店', '132332', '0', '2', '1', '100001', '132332', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1496310035', '1496310035');
INSERT INTO `check_warning` VALUES ('1162', '标准店', '1323321', '0', '3', '0', '100001', '132332', null, '0', '0', '0', '0', '0', '0', '30', '0', '-30', '150000.00', '600.12', '-149399.88', null, null, null, null, '1496310035', '1496310035');
INSERT INTO `check_warning` VALUES ('1163', '店铺3', '132332', '0', '2', '1', '123456789', '132332', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1496310035', '1496310035');
INSERT INTO `check_warning` VALUES ('1164', '店铺1', '12335', '0', '3', '0', '123456789', '100004', null, '0', '0', '0', '0', '0', '0', null, '0', '0', '300000.00', '0.00', '-300000.00', null, null, null, null, '1496310035', '1496310035');
INSERT INTO `check_warning` VALUES ('1165', '店铺1', '12335', '0', '3', '0', '123456789', '100004', null, '0', '0', '0', '0', '0', '0', null, '0', '0', '300000.00', '0.00', '-300000.00', null, null, null, null, '1496310035', '1496310035');
INSERT INTO `check_warning` VALUES ('1166', '卢标经营', '7522170516', '0', '3', '1', '100003', '7518170516', null, null, '0', '0', '0', '0', '0', '0', '0', '0', '180000.00', '0.00', '-180000.00', null, null, null, null, '1496310035', '1496310035');
INSERT INTO `check_warning` VALUES ('1167', '卢旗舰经营', '7518170516', '0', '2', '1', '100003', '7518170516', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1496310035', '1496310035');
INSERT INTO `check_warning` VALUES ('1168', '卢标筹备', '7520170244', '0', '3', '0', '100003', '7520170244', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1496310035', '1496310035');
INSERT INTO `check_warning` VALUES ('1169', '卢旗舰筹备', '7525170516', '0', '2', '0', '3905170511', '7525170516', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1496310035', '1496310035');
INSERT INTO `check_warning` VALUES ('1170', '卢旗舰观察', '7527170516', '0', '2', '-1', '100003', '7527170516', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1496310035', '1496310035');

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
-- Records of client
-- ----------------------------
INSERT INTO `client` VALUES ('1', '景兵帅', '1', '2012-3-5', '1', '130527199310271613', '1', '工作单位', '12313', '654', '18231981027', '304913539@qq.com', '54400', '北京朝阳', '建行', '62170000130000737576', '2', '保险购买情况说明');
INSERT INTO `client` VALUES ('2', '阿斯', '2', '2015-2-6', '2', '13052719932323651', '1', '工作单位2', '321322', '654', '182319810', '304913539@qq.com', '35513', '朝阳', '6217001656565', '6217000130000737576', '2', '保险购买情');

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
-- Records of coefficient_continuous
-- ----------------------------
INSERT INTO `coefficient_continuous` VALUES ('1', '0.60', '0.80', '1.05');
INSERT INTO `coefficient_continuous` VALUES ('2', '0.85', '0.98', '1.23');

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
-- Records of district
-- ----------------------------
INSERT INTO `district` VALUES ('1', '北京', '0', ',1,', '1', '0', 'beijing', '1', '0');
INSERT INTO `district` VALUES ('2', '北京市', '1', ',,2,', '2', '0', 'beijingshi', '1', '0');
INSERT INTO `district` VALUES ('3', '东城区', '2', ',1,2,3,', '3', '0', 'dongchengqu', '1', '0');
INSERT INTO `district` VALUES ('4', '西城区', '2', ',1,2,4,', '3', '0', 'xichengqu', '1', '0');
INSERT INTO `district` VALUES ('7', '朝阳区', '2', ',1,2,7,', '3', '0', 'chaoyangqu', '1', '0');
INSERT INTO `district` VALUES ('8', '丰台区', '2', ',1,2,8,', '3', '0', 'fengtaiqu', '1', '0');
INSERT INTO `district` VALUES ('9', '石景山区', '2', ',1,2,9,', '3', '0', 'shijingshanqu', '1', '0');
INSERT INTO `district` VALUES ('10', '海淀区', '2', ',1,2,10,', '3', '0', 'haidianqu', '1', '0');
INSERT INTO `district` VALUES ('11', '门头沟区', '2', ',1,2,11,', '3', '0', 'mentougouqu', '1', '0');
INSERT INTO `district` VALUES ('12', '房山区', '2', ',1,2,12,', '3', '0', 'fangshanqu', '1', '0');
INSERT INTO `district` VALUES ('13', '通州区', '2', ',1,2,13,', '3', '0', 'tongzhouqu', '1', '0');
INSERT INTO `district` VALUES ('14', '顺义区', '2', ',1,2,14,', '3', '0', 'shunyiqu', '1', '0');
INSERT INTO `district` VALUES ('15', '昌平区', '2', ',1,2,15,', '3', '0', 'changpingqu', '1', '0');
INSERT INTO `district` VALUES ('16', '大兴区', '2', ',1,2,16,', '3', '0', 'daxingqu', '1', '0');
INSERT INTO `district` VALUES ('17', '怀柔区', '2', ',1,2,17,', '3', '0', 'huairouqu', '1', '0');
INSERT INTO `district` VALUES ('18', '平谷区', '2', ',1,2,18,', '3', '0', 'pingguqu', '1', '0');
INSERT INTO `district` VALUES ('19', '密云县', '2', ',1,2,19,', '3', '0', 'miyunxian', '1', '0');
INSERT INTO `district` VALUES ('20', '延庆县', '2', ',1,2,20,', '3', '0', 'yanqingxian', '1', '0');
INSERT INTO `district` VALUES ('21', '上海', '0', ',21,', '1', '0', 'shanghai', '1', '0');
INSERT INTO `district` VALUES ('22', '上海市', '21', ',21,22,', '2', '0', 'shanghaishi', '1', '0');
INSERT INTO `district` VALUES ('23', '黄浦区', '23', ',21,22,23,', '3', '0', 'huangpuqu', '0', '0');
INSERT INTO `district` VALUES ('24', '卢湾区', '22', ',21,22,24,', '3', '0', 'luwanqu', '1', '0');
INSERT INTO `district` VALUES ('25', '徐汇区', '22', ',21,22,25,', '3', '0', 'xuhuiqu', '1', '0');
INSERT INTO `district` VALUES ('26', '长宁区', '22', ',21,22,26,', '3', '0', 'changningqu', '1', '0');
INSERT INTO `district` VALUES ('27', '静安区', '22', ',21,22,27,', '3', '0', 'jinganqu', '1', '0');
INSERT INTO `district` VALUES ('28', '普陀区', '22', ',21,22,28,', '3', '0', 'putuoqu', '1', '0');
INSERT INTO `district` VALUES ('29', '闸北区', '22', ',21,22,29,', '3', '0', 'zhabeiqu', '1', '0');
INSERT INTO `district` VALUES ('30', '虹口区', '22', ',21,22,30,', '3', '0', 'hongkouqu', '1', '0');
INSERT INTO `district` VALUES ('31', '杨浦区', '22', ',21,22,31,', '3', '0', 'yangpuqu', '1', '0');
INSERT INTO `district` VALUES ('32', '闵行区', '22', ',21,22,32,', '3', '0', 'xingqu', '1', '0');
INSERT INTO `district` VALUES ('33', '宝山区', '22', ',21,22,33,', '3', '0', 'baoshanqu', '1', '0');
INSERT INTO `district` VALUES ('34', '嘉定区', '22', ',21,22,34,', '3', '0', 'jiadingqu', '1', '0');
INSERT INTO `district` VALUES ('35', '浦东新区', '22', ',21,22,35,', '3', '0', 'pudongxinqu', '1', '0');
INSERT INTO `district` VALUES ('36', '金山区', '22', ',21,22,36,', '3', '0', 'jinshanqu', '1', '0');
INSERT INTO `district` VALUES ('37', '松江区', '22', ',21,22,37,', '3', '0', 'songjiangqu', '1', '0');
INSERT INTO `district` VALUES ('38', '青浦区', '22', ',21,22,38,', '3', '0', 'qingpuqu', '1', '0');
INSERT INTO `district` VALUES ('39', '南汇区', '22', ',21,22,39,', '3', '0', 'nanhuiqu', '1', '0');
INSERT INTO `district` VALUES ('40', '奉贤区', '22', ',21,22,40,', '3', '0', 'fengxianqu', '1', '0');
INSERT INTO `district` VALUES ('41', '崇明县', '22', ',21,22,41,', '3', '0', 'chongmingxian', '1', '0');
INSERT INTO `district` VALUES ('42', '天津', '0', ',42,', '1', '0', 'tianjin', '0', '0');
INSERT INTO `district` VALUES ('43', '天津市', '42', ',42,43,', '2', '0', 'tianjinshi', '0', '0');
INSERT INTO `district` VALUES ('44', '和平区', '43', ',42,43,44,', '3', '0', 'hepingqu', '0', '0');
INSERT INTO `district` VALUES ('45', '河东区', '43', ',42,43,45,', '3', '0', 'hedongqu', '0', '0');
INSERT INTO `district` VALUES ('46', '河西区', '43', ',42,43,46,', '3', '0', 'hexiqu', '0', '0');
INSERT INTO `district` VALUES ('47', '南开区', '43', ',42,43,47,', '3', '0', 'nankaiqu', '0', '0');
INSERT INTO `district` VALUES ('48', '河北区', '43', ',42,43,48,', '3', '0', 'hebeiqu', '0', '0');
INSERT INTO `district` VALUES ('49', '红桥区', '43', ',42,43,49,', '3', '0', 'hongqiaoqu', '0', '0');
INSERT INTO `district` VALUES ('50', '塘沽区', '43', ',42,43,50,', '3', '0', 'tangguqu', '0', '0');
INSERT INTO `district` VALUES ('51', '汉沽区', '43', ',42,43,51,', '3', '0', 'hanguqu', '0', '0');
INSERT INTO `district` VALUES ('52', '大港区', '43', ',42,43,52,', '3', '0', 'dagangqu', '0', '0');
INSERT INTO `district` VALUES ('53', '东丽区', '43', ',42,43,53,', '3', '0', 'dongliqu', '0', '0');
INSERT INTO `district` VALUES ('54', '西青区', '43', ',42,43,54,', '3', '0', 'xiqingqu', '0', '0');
INSERT INTO `district` VALUES ('55', '津南区', '43', ',42,43,55,', '3', '0', 'jinnanqu', '0', '0');
INSERT INTO `district` VALUES ('56', '北辰区', '43', ',42,43,56,', '3', '0', 'beichenqu', '0', '0');
INSERT INTO `district` VALUES ('57', '武清区', '43', ',42,43,57,', '3', '0', 'wuqingqu', '0', '0');
INSERT INTO `district` VALUES ('58', '宝坻区', '43', ',42,43,58,', '3', '0', 'baoqu', '0', '0');
INSERT INTO `district` VALUES ('59', '宁河县', '43', ',42,43,59,', '3', '0', 'ninghexian', '0', '0');
INSERT INTO `district` VALUES ('60', '静海县', '43', ',42,43,60,', '3', '0', 'jinghaixian', '0', '0');
INSERT INTO `district` VALUES ('61', '蓟县', '43', ',42,43,61,', '3', '0', 'jixian', '0', '0');
INSERT INTO `district` VALUES ('62', '重庆', '0', ',62,', '1', '0', 'zhongqing', '0', '0');
INSERT INTO `district` VALUES ('63', '重庆市', '62', ',62,63,', '2', '0', 'zhongqingshi', '0', '0');
INSERT INTO `district` VALUES ('64', '万州区', '63', ',62,63,64,', '3', '0', 'wanzhouqu', '0', '0');
INSERT INTO `district` VALUES ('65', '涪陵区', '63', ',62,63,65,', '3', '0', 'fulingqu', '0', '0');
INSERT INTO `district` VALUES ('66', '渝中区', '63', ',62,63,66,', '3', '0', 'yuzhongqu', '0', '0');
INSERT INTO `district` VALUES ('67', '大渡口区', '63', ',62,63,67,', '3', '0', 'dadukouqu', '0', '0');
INSERT INTO `district` VALUES ('68', '江北区', '63', ',62,63,68,', '3', '0', 'jiangbeiqu', '0', '0');
INSERT INTO `district` VALUES ('69', '沙坪坝区', '63', ',62,63,69,', '3', '0', 'shapingbaqu', '0', '0');
INSERT INTO `district` VALUES ('70', '九龙坡区', '63', ',62,63,70,', '3', '0', 'jiulongpoqu', '0', '0');
INSERT INTO `district` VALUES ('71', '南岸区', '63', ',62,63,71,', '3', '0', 'nananqu', '0', '0');
INSERT INTO `district` VALUES ('72', '北碚区', '63', ',62,63,72,', '3', '0', 'beiqu', '0', '0');
INSERT INTO `district` VALUES ('73', '万盛区', '63', ',62,63,73,', '3', '0', 'wanshengqu', '0', '0');
INSERT INTO `district` VALUES ('74', '双桥区', '63', ',62,63,74,', '3', '0', 'shuangqiaoqu', '0', '0');
INSERT INTO `district` VALUES ('75', '渝北区', '63', ',62,63,75,', '3', '0', 'yubeiqu', '0', '0');
INSERT INTO `district` VALUES ('76', '巴南区', '63', ',62,63,76,', '3', '0', 'bananqu', '0', '0');
INSERT INTO `district` VALUES ('77', '黔江区', '63', ',62,63,77,', '3', '0', 'qianjiangqu', '0', '0');
INSERT INTO `district` VALUES ('78', '长寿区', '63', ',62,63,78,', '3', '0', 'changshouqu', '0', '0');
INSERT INTO `district` VALUES ('79', '綦江县', '63', ',62,63,79,', '3', '0', 'jiangxian', '0', '0');
INSERT INTO `district` VALUES ('80', '潼南县', '63', ',62,63,80,', '3', '0', 'nanxian', '0', '0');
INSERT INTO `district` VALUES ('81', '铜梁县', '63', ',62,63,81,', '3', '0', 'tongliangxian', '0', '0');
INSERT INTO `district` VALUES ('82', '大足县', '63', ',62,63,82,', '3', '0', 'dazuxian', '0', '0');
INSERT INTO `district` VALUES ('83', '荣昌县', '63', ',62,63,83,', '3', '0', 'rongchangxian', '0', '0');
INSERT INTO `district` VALUES ('84', '璧山县', '63', ',62,63,84,', '3', '0', 'shanxian', '0', '0');
INSERT INTO `district` VALUES ('85', '梁平县', '63', ',62,63,85,', '3', '0', 'liangpingxian', '0', '0');
INSERT INTO `district` VALUES ('86', '城口县', '63', ',62,63,86,', '3', '0', 'chengkouxian', '0', '0');
INSERT INTO `district` VALUES ('87', '丰都县', '63', ',62,63,87,', '3', '0', 'fengduxian', '0', '0');
INSERT INTO `district` VALUES ('88', '垫江县', '63', ',62,63,88,', '3', '0', 'dianjiangxian', '0', '0');
INSERT INTO `district` VALUES ('89', '武隆县', '63', ',62,63,89,', '3', '0', 'wulongxian', '0', '0');
INSERT INTO `district` VALUES ('90', '忠县', '63', ',62,63,90,', '3', '0', 'zhongxian', '0', '0');
INSERT INTO `district` VALUES ('91', '开县', '63', ',62,63,91,', '3', '0', 'kaixian', '0', '0');
INSERT INTO `district` VALUES ('92', '云阳县', '63', ',62,63,92,', '3', '0', 'yunyangxian', '0', '0');
INSERT INTO `district` VALUES ('93', '奉节县', '63', ',62,63,93,', '3', '0', 'fengjiexian', '0', '0');
INSERT INTO `district` VALUES ('94', '巫山县', '63', ',62,63,94,', '3', '0', 'wushanxian', '0', '0');
INSERT INTO `district` VALUES ('95', '巫溪县', '63', ',62,63,95,', '3', '0', 'wuxixian', '0', '0');
INSERT INTO `district` VALUES ('96', '石柱土家族自治县', '63', ',62,63,96,', '3', '0', 'shizhutujiazuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('97', '秀山土家族苗族自治县', '63', ',62,63,97,', '3', '0', 'xiushantujiazumiaozuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('98', '酉阳土家族苗族自治县', '63', ',62,63,98,', '3', '0', 'youyangtujiazumiaozuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('99', '彭水苗族土家族自治县', '63', ',62,63,99,', '3', '0', 'pengshuimiaozutujiazuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('100', '江津市', '63', ',62,63,100,', '3', '0', 'jiangjinshi', '0', '0');
INSERT INTO `district` VALUES ('101', '合川市', '63', ',62,63,101,', '3', '0', 'hechuanshi', '0', '0');
INSERT INTO `district` VALUES ('102', '永川市', '63', ',62,63,102,', '3', '0', 'yongchuanshi', '0', '0');
INSERT INTO `district` VALUES ('103', '南川市', '63', ',62,63,103,', '3', '0', 'nanchuanshi', '0', '0');
INSERT INTO `district` VALUES ('104', '安徽省', '0', ',104,', '1', '0', 'anhuisheng', '0', '0');
INSERT INTO `district` VALUES ('105', '合肥市', '104', ',104,105,', '2', '0', 'hefeishi', '0', '0');
INSERT INTO `district` VALUES ('106', '瑶海区', '105', ',104,105,106,', '3', '0', 'yaohaiqu', '0', '0');
INSERT INTO `district` VALUES ('107', '庐阳区', '105', ',104,105,107,', '3', '0', 'luyangqu', '0', '0');
INSERT INTO `district` VALUES ('108', '蜀山区', '105', ',104,105,108,', '3', '0', 'shushanqu', '0', '0');
INSERT INTO `district` VALUES ('109', '包河区', '105', ',104,105,109,', '3', '0', 'baohequ', '0', '0');
INSERT INTO `district` VALUES ('110', '长丰县', '105', ',104,105,110,', '3', '0', 'changfengxian', '0', '0');
INSERT INTO `district` VALUES ('111', '肥东县', '105', ',104,105,111,', '3', '0', 'feidongxian', '0', '0');
INSERT INTO `district` VALUES ('112', '肥西县', '105', ',104,105,112,', '3', '0', 'feixixian', '0', '0');
INSERT INTO `district` VALUES ('113', '安庆市', '104', ',104,113,', '2', '0', 'anqingshi', '0', '0');
INSERT INTO `district` VALUES ('114', '迎江区', '113', ',104,113,114,', '3', '0', 'yingjiangqu', '0', '0');
INSERT INTO `district` VALUES ('115', '大观区', '113', ',104,113,115,', '3', '0', 'daguanqu', '0', '0');
INSERT INTO `district` VALUES ('116', '郊区', '113', ',104,113,116,', '3', '0', 'jiaoqu', '0', '0');
INSERT INTO `district` VALUES ('117', '怀宁县', '113', ',104,113,117,', '3', '0', 'huainingxian', '0', '0');
INSERT INTO `district` VALUES ('118', '枞阳县', '113', ',104,113,118,', '3', '0', 'yangxian', '0', '0');
INSERT INTO `district` VALUES ('119', '潜山县', '113', ',104,113,119,', '3', '0', 'qianshanxian', '0', '0');
INSERT INTO `district` VALUES ('120', '太湖县', '113', ',104,113,120,', '3', '0', 'taihuxian', '0', '0');
INSERT INTO `district` VALUES ('121', '宿松县', '113', ',104,113,121,', '3', '0', 'susongxian', '0', '0');
INSERT INTO `district` VALUES ('122', '望江县', '113', ',104,113,122,', '3', '0', 'wangjiangxian', '0', '0');
INSERT INTO `district` VALUES ('123', '岳西县', '113', ',104,113,123,', '3', '0', 'yuexixian', '0', '0');
INSERT INTO `district` VALUES ('124', '桐城市', '113', ',104,113,124,', '3', '0', 'tongchengshi', '0', '0');
INSERT INTO `district` VALUES ('125', '蚌埠市', '104', ',104,125,', '2', '0', 'bangbushi', '0', '0');
INSERT INTO `district` VALUES ('126', '龙子湖区', '125', ',104,125,126,', '3', '0', 'longzihuqu', '0', '0');
INSERT INTO `district` VALUES ('127', '蚌山区', '125', ',104,125,127,', '3', '0', 'bangshanqu', '0', '0');
INSERT INTO `district` VALUES ('128', '禹会区', '125', ',104,125,128,', '3', '0', 'yuhuiqu', '0', '0');
INSERT INTO `district` VALUES ('129', '淮上区', '125', ',104,125,129,', '3', '0', 'huaishangqu', '0', '0');
INSERT INTO `district` VALUES ('130', '怀远县', '125', ',104,125,130,', '3', '0', 'huaiyuanxian', '0', '0');
INSERT INTO `district` VALUES ('131', '五河县', '125', ',104,125,131,', '3', '0', 'wuhexian', '0', '0');
INSERT INTO `district` VALUES ('132', '固镇县', '125', ',104,125,132,', '3', '0', 'guzhenxian', '0', '0');
INSERT INTO `district` VALUES ('133', '亳州市', '104', ',104,133,', '2', '0', 'zhoushi', '0', '0');
INSERT INTO `district` VALUES ('134', '谯城区', '133', ',104,133,134,', '3', '0', 'chengqu', '0', '0');
INSERT INTO `district` VALUES ('135', '涡阳县', '133', ',104,133,135,', '3', '0', 'woyangxian', '0', '0');
INSERT INTO `district` VALUES ('136', '蒙城县', '133', ',104,133,136,', '3', '0', 'mengchengxian', '0', '0');
INSERT INTO `district` VALUES ('137', '利辛县', '133', ',104,133,137,', '3', '0', 'lixinxian', '0', '0');
INSERT INTO `district` VALUES ('138', '巢湖市', '104', ',104,138,', '2', '0', 'chaohushi', '0', '0');
INSERT INTO `district` VALUES ('139', '居巢区', '138', ',104,138,139,', '3', '0', 'juchaoqu', '0', '0');
INSERT INTO `district` VALUES ('140', '庐江县', '138', ',104,138,140,', '3', '0', 'lujiangxian', '0', '0');
INSERT INTO `district` VALUES ('141', '无为县', '138', ',104,138,141,', '3', '0', 'wuweixian', '0', '0');
INSERT INTO `district` VALUES ('142', '含山县', '138', ',104,138,142,', '3', '0', 'hanshanxian', '0', '0');
INSERT INTO `district` VALUES ('143', '和县', '138', ',104,138,143,', '3', '0', 'hexian', '0', '0');
INSERT INTO `district` VALUES ('144', '池州市', '104', ',104,144,', '2', '0', 'chizhoushi', '0', '0');
INSERT INTO `district` VALUES ('145', '贵池区', '144', ',104,144,145,', '3', '0', 'guichiqu', '0', '0');
INSERT INTO `district` VALUES ('146', '东至县', '144', ',104,144,146,', '3', '0', 'dongzhixian', '0', '0');
INSERT INTO `district` VALUES ('147', '石台县', '144', ',104,144,147,', '3', '0', 'shitaixian', '0', '0');
INSERT INTO `district` VALUES ('148', '青阳县', '144', ',104,144,148,', '3', '0', 'qingyangxian', '0', '0');
INSERT INTO `district` VALUES ('149', '滁州市', '104', ',104,149,', '2', '0', 'chuzhoushi', '0', '0');
INSERT INTO `district` VALUES ('150', '琅琊区', '149', ',104,149,150,', '3', '0', 'langqu', '0', '0');
INSERT INTO `district` VALUES ('151', '南谯区', '149', ',104,149,151,', '3', '0', 'nanqu', '0', '0');
INSERT INTO `district` VALUES ('152', '来安县', '149', ',104,149,152,', '3', '0', 'laianxian', '0', '0');
INSERT INTO `district` VALUES ('153', '全椒县', '149', ',104,149,153,', '3', '0', 'quanjiaoxian', '0', '0');
INSERT INTO `district` VALUES ('154', '定远县', '149', ',104,149,154,', '3', '0', 'dingyuanxian', '0', '0');
INSERT INTO `district` VALUES ('155', '凤阳县', '149', ',104,149,155,', '3', '0', 'fengyangxian', '0', '0');
INSERT INTO `district` VALUES ('156', '天长市', '149', ',104,149,156,', '3', '0', 'tianchangshi', '0', '0');
INSERT INTO `district` VALUES ('157', '明光市', '149', ',104,149,157,', '3', '0', 'mingguangshi', '0', '0');
INSERT INTO `district` VALUES ('158', '阜阳市', '104', ',104,158,', '2', '0', 'fuyangshi', '0', '0');
INSERT INTO `district` VALUES ('159', '颍州区', '158', ',104,158,159,', '3', '0', 'zhouqu', '0', '0');
INSERT INTO `district` VALUES ('160', '颍东区', '158', ',104,158,160,', '3', '0', 'dongqu', '0', '0');
INSERT INTO `district` VALUES ('161', '颍泉区', '158', ',104,158,161,', '3', '0', 'quanqu', '0', '0');
INSERT INTO `district` VALUES ('162', '临泉县', '158', ',104,158,162,', '3', '0', 'linquanxian', '0', '0');
INSERT INTO `district` VALUES ('163', '太和县', '158', ',104,158,163,', '3', '0', 'taihexian', '0', '0');
INSERT INTO `district` VALUES ('164', '阜南县', '158', ',104,158,164,', '3', '0', 'funanxian', '0', '0');
INSERT INTO `district` VALUES ('165', '颍上县', '158', ',104,158,165,', '3', '0', 'shangxian', '0', '0');
INSERT INTO `district` VALUES ('166', '界首市', '158', ',104,158,166,', '3', '0', 'jieshoushi', '0', '0');
INSERT INTO `district` VALUES ('167', '淮北市', '104', ',104,167,', '2', '0', 'huaibeishi', '0', '0');
INSERT INTO `district` VALUES ('168', '杜集区', '167', ',104,167,168,', '3', '0', 'dujiqu', '0', '0');
INSERT INTO `district` VALUES ('169', '相山区', '167', ',104,167,169,', '3', '0', 'xiangshanqu', '0', '0');
INSERT INTO `district` VALUES ('170', '烈山区', '167', ',104,167,170,', '3', '0', 'lieshanqu', '0', '0');
INSERT INTO `district` VALUES ('171', '濉溪县', '167', ',104,167,171,', '3', '0', 'xixian', '0', '0');
INSERT INTO `district` VALUES ('172', '淮南市', '104', ',104,172,', '2', '0', 'huainanshi', '0', '0');
INSERT INTO `district` VALUES ('173', '大通区', '172', ',104,172,173,', '3', '0', 'datongqu', '0', '0');
INSERT INTO `district` VALUES ('174', '田家庵区', '172', ',104,172,174,', '3', '0', 'tianjiaqu', '0', '0');
INSERT INTO `district` VALUES ('175', '谢家集区', '172', ',104,172,175,', '3', '0', 'xiejiajiqu', '0', '0');
INSERT INTO `district` VALUES ('176', '八公山区', '172', ',104,172,176,', '3', '0', 'bagongshanqu', '0', '0');
INSERT INTO `district` VALUES ('177', '潘集区', '172', ',104,172,177,', '3', '0', 'panjiqu', '0', '0');
INSERT INTO `district` VALUES ('178', '凤台县', '172', ',104,172,178,', '3', '0', 'fengtaixian', '0', '0');
INSERT INTO `district` VALUES ('179', '黄山市', '104', ',104,179,', '2', '0', 'huangshanshi', '0', '0');
INSERT INTO `district` VALUES ('180', '屯溪区', '179', ',104,179,180,', '3', '0', 'tunxiqu', '0', '0');
INSERT INTO `district` VALUES ('181', '黄山区', '179', ',104,179,181,', '3', '0', 'huangshanqu', '0', '0');
INSERT INTO `district` VALUES ('182', '徽州区', '179', ',104,179,182,', '3', '0', 'huizhouqu', '0', '0');
INSERT INTO `district` VALUES ('183', '歙县', '179', ',104,179,183,', '3', '0', 'xian', '0', '0');
INSERT INTO `district` VALUES ('184', '休宁县', '179', ',104,179,184,', '3', '0', 'xiuningxian', '0', '0');
INSERT INTO `district` VALUES ('185', '黟县', '179', ',104,179,185,', '3', '0', 'xian', '0', '0');
INSERT INTO `district` VALUES ('186', '祁门县', '179', ',104,179,186,', '3', '0', 'qimenxian', '0', '0');
INSERT INTO `district` VALUES ('187', '六安市', '104', ',104,187,', '2', '0', 'liuanshi', '0', '0');
INSERT INTO `district` VALUES ('188', '金安区', '187', ',104,187,188,', '3', '0', 'jinanqu', '0', '0');
INSERT INTO `district` VALUES ('189', '裕安区', '187', ',104,187,189,', '3', '0', 'yuanqu', '0', '0');
INSERT INTO `district` VALUES ('190', '寿县', '187', ',104,187,190,', '3', '0', 'shouxian', '0', '0');
INSERT INTO `district` VALUES ('191', '霍邱县', '187', ',104,187,191,', '3', '0', 'huoqiuxian', '0', '0');
INSERT INTO `district` VALUES ('192', '舒城县', '187', ',104,187,192,', '3', '0', 'shuchengxian', '0', '0');
INSERT INTO `district` VALUES ('193', '金寨县', '187', ',104,187,193,', '3', '0', 'jinzhaixian', '0', '0');
INSERT INTO `district` VALUES ('194', '霍山县', '187', ',104,187,194,', '3', '0', 'huoshanxian', '0', '0');
INSERT INTO `district` VALUES ('195', '马鞍山市', '104', ',104,195,', '2', '0', 'maanshanshi', '0', '0');
INSERT INTO `district` VALUES ('196', '金家庄区', '195', ',104,195,196,', '3', '0', 'jinjiazhuangqu', '0', '0');
INSERT INTO `district` VALUES ('197', '花山区', '195', ',104,195,197,', '3', '0', 'huashanqu', '0', '0');
INSERT INTO `district` VALUES ('198', '雨山区', '195', ',104,195,198,', '3', '0', 'yushanqu', '0', '0');
INSERT INTO `district` VALUES ('199', '当涂县', '195', ',104,195,199,', '3', '0', 'dangtuxian', '0', '0');
INSERT INTO `district` VALUES ('200', '宿州市', '104', ',104,200,', '2', '0', 'suzhoushi', '0', '0');
INSERT INTO `district` VALUES ('201', '墉桥区', '200', ',104,200,201,', '3', '0', 'qiaoqu', '0', '0');
INSERT INTO `district` VALUES ('202', '砀山县', '200', ',104,200,202,', '3', '0', 'shanxian', '0', '0');
INSERT INTO `district` VALUES ('203', '萧县', '200', ',104,200,203,', '3', '0', 'xiaoxian', '0', '0');
INSERT INTO `district` VALUES ('204', '灵璧县', '200', ',104,200,204,', '3', '0', 'lingxian', '0', '0');
INSERT INTO `district` VALUES ('205', '泗县', '200', ',104,200,205,', '3', '0', 'xian', '0', '0');
INSERT INTO `district` VALUES ('206', '铜陵市', '104', ',104,206,', '2', '0', 'tonglingshi', '0', '0');
INSERT INTO `district` VALUES ('207', '铜官山区', '206', ',104,206,207,', '3', '0', 'tongguanshanqu', '0', '0');
INSERT INTO `district` VALUES ('208', '狮子山区', '206', ',104,206,208,', '3', '0', 'shizishanqu', '0', '0');
INSERT INTO `district` VALUES ('209', '郊区', '206', ',104,206,209,', '3', '0', 'jiaoqu', '0', '0');
INSERT INTO `district` VALUES ('210', '铜陵县', '206', ',104,206,210,', '3', '0', 'tonglingxian', '0', '0');
INSERT INTO `district` VALUES ('211', '芜湖市', '104', ',104,211,', '2', '0', 'wuhushi', '0', '0');
INSERT INTO `district` VALUES ('212', '镜湖区', '211', ',104,211,212,', '3', '0', 'jinghuqu', '0', '0');
INSERT INTO `district` VALUES ('213', '马塘区', '211', ',104,211,213,', '3', '0', 'matangqu', '0', '0');
INSERT INTO `district` VALUES ('214', '新芜区', '211', ',104,211,214,', '3', '0', 'xinwuqu', '0', '0');
INSERT INTO `district` VALUES ('215', '鸠江区', '211', ',104,211,215,', '3', '0', 'jiangqu', '0', '0');
INSERT INTO `district` VALUES ('216', '芜湖县', '211', ',104,211,216,', '3', '0', 'wuhuxian', '0', '0');
INSERT INTO `district` VALUES ('217', '繁昌县', '211', ',104,211,217,', '3', '0', 'fanchangxian', '0', '0');
INSERT INTO `district` VALUES ('218', '南陵县', '211', ',104,211,218,', '3', '0', 'nanlingxian', '0', '0');
INSERT INTO `district` VALUES ('219', '宣城市', '104', ',104,219,', '2', '0', 'xuanchengshi', '0', '0');
INSERT INTO `district` VALUES ('220', '宣州区', '219', ',104,219,220,', '3', '0', 'xuanzhouqu', '0', '0');
INSERT INTO `district` VALUES ('221', '郎溪县', '219', ',104,219,221,', '3', '0', 'langxixian', '0', '0');
INSERT INTO `district` VALUES ('222', '广德县', '219', ',104,219,222,', '3', '0', 'guangdexian', '0', '0');
INSERT INTO `district` VALUES ('223', '泾县', '219', ',104,219,223,', '3', '0', 'xian', '0', '0');
INSERT INTO `district` VALUES ('224', '绩溪县', '219', ',104,219,224,', '3', '0', 'jixixian', '0', '0');
INSERT INTO `district` VALUES ('225', '旌德县', '219', ',104,219,225,', '3', '0', 'dexian', '0', '0');
INSERT INTO `district` VALUES ('226', '宁国市', '219', ',104,219,226,', '3', '0', 'ningguoshi', '0', '0');
INSERT INTO `district` VALUES ('227', '福建省', '0', ',227,', '1', '0', 'fujiansheng', '0', '0');
INSERT INTO `district` VALUES ('228', '福州市', '227', ',227,228,', '2', '0', 'fuzhoushi', '0', '0');
INSERT INTO `district` VALUES ('229', '鼓楼区', '228', ',227,228,229,', '3', '0', 'gulouqu', '0', '0');
INSERT INTO `district` VALUES ('230', '台江区', '228', ',227,228,230,', '3', '0', 'taijiangqu', '0', '0');
INSERT INTO `district` VALUES ('231', '仓山区', '228', ',227,228,231,', '3', '0', 'cangshanqu', '0', '0');
INSERT INTO `district` VALUES ('232', '马尾区', '228', ',227,228,232,', '3', '0', 'maweiqu', '0', '0');
INSERT INTO `district` VALUES ('233', '晋安区', '228', ',227,228,233,', '3', '0', 'jinanqu', '0', '0');
INSERT INTO `district` VALUES ('234', '闽侯县', '228', ',227,228,234,', '3', '0', 'minhouxian', '0', '0');
INSERT INTO `district` VALUES ('235', '连江县', '228', ',227,228,235,', '3', '0', 'lianjiangxian', '0', '0');
INSERT INTO `district` VALUES ('236', '罗源县', '228', ',227,228,236,', '3', '0', 'luoyuanxian', '0', '0');
INSERT INTO `district` VALUES ('237', '闽清县', '228', ',227,228,237,', '3', '0', 'minqingxian', '0', '0');
INSERT INTO `district` VALUES ('238', '永泰县', '228', ',227,228,238,', '3', '0', 'yongtaixian', '0', '0');
INSERT INTO `district` VALUES ('239', '平潭县', '228', ',227,228,239,', '3', '0', 'pingtanxian', '0', '0');
INSERT INTO `district` VALUES ('240', '福清市', '228', ',227,228,240,', '3', '0', 'fuqingshi', '0', '0');
INSERT INTO `district` VALUES ('241', '长乐市', '228', ',227,228,241,', '3', '0', 'changleshi', '0', '0');
INSERT INTO `district` VALUES ('242', '龙岩市', '227', ',227,242,', '2', '0', 'longyanshi', '0', '0');
INSERT INTO `district` VALUES ('243', '新罗区', '242', ',227,242,243,', '3', '0', 'xinluoqu', '0', '0');
INSERT INTO `district` VALUES ('244', '长汀县', '242', ',227,242,244,', '3', '0', 'changtingxian', '0', '0');
INSERT INTO `district` VALUES ('245', '永定县', '242', ',227,242,245,', '3', '0', 'yongdingxian', '0', '0');
INSERT INTO `district` VALUES ('246', '上杭县', '242', ',227,242,246,', '3', '0', 'shanghangxian', '0', '0');
INSERT INTO `district` VALUES ('247', '武平县', '242', ',227,242,247,', '3', '0', 'wupingxian', '0', '0');
INSERT INTO `district` VALUES ('248', '连城县', '242', ',227,242,248,', '3', '0', 'lianchengxian', '0', '0');
INSERT INTO `district` VALUES ('249', '漳平市', '242', ',227,242,249,', '3', '0', 'zhangpingshi', '0', '0');
INSERT INTO `district` VALUES ('250', '南平市', '227', ',227,250,', '2', '0', 'nanpingshi', '0', '0');
INSERT INTO `district` VALUES ('251', '延平区', '250', ',227,250,251,', '3', '0', 'yanpingqu', '0', '0');
INSERT INTO `district` VALUES ('252', '顺昌县', '250', ',227,250,252,', '3', '0', 'shunchangxian', '0', '0');
INSERT INTO `district` VALUES ('253', '浦城县', '250', ',227,250,253,', '3', '0', 'puchengxian', '0', '0');
INSERT INTO `district` VALUES ('254', '光泽县', '250', ',227,250,254,', '3', '0', 'guangzexian', '0', '0');
INSERT INTO `district` VALUES ('255', '松溪县', '250', ',227,250,255,', '3', '0', 'songxixian', '0', '0');
INSERT INTO `district` VALUES ('256', '政和县', '250', ',227,250,256,', '3', '0', 'zhenghexian', '0', '0');
INSERT INTO `district` VALUES ('257', '邵武市', '250', ',227,250,257,', '3', '0', 'shaowushi', '0', '0');
INSERT INTO `district` VALUES ('258', '武夷山市', '250', ',227,250,258,', '3', '0', 'wuyishanshi', '0', '0');
INSERT INTO `district` VALUES ('259', '建瓯市', '250', ',227,250,259,', '3', '0', 'jianshi', '0', '0');
INSERT INTO `district` VALUES ('260', '建阳市', '250', ',227,250,260,', '3', '0', 'jianyangshi', '0', '0');
INSERT INTO `district` VALUES ('261', '宁德市', '227', ',227,261,', '2', '0', 'ningdeshi', '0', '0');
INSERT INTO `district` VALUES ('262', '蕉城区', '261', ',227,261,262,', '3', '0', 'jiaochengqu', '0', '0');
INSERT INTO `district` VALUES ('263', '霞浦县', '261', ',227,261,263,', '3', '0', 'xiapuxian', '0', '0');
INSERT INTO `district` VALUES ('264', '古田县', '261', ',227,261,264,', '3', '0', 'gutianxian', '0', '0');
INSERT INTO `district` VALUES ('265', '屏南县', '261', ',227,261,265,', '3', '0', 'pingnanxian', '0', '0');
INSERT INTO `district` VALUES ('266', '寿宁县', '261', ',227,261,266,', '3', '0', 'shouningxian', '0', '0');
INSERT INTO `district` VALUES ('267', '周宁县', '261', ',227,261,267,', '3', '0', 'zhouningxian', '0', '0');
INSERT INTO `district` VALUES ('268', '柘荣县', '261', ',227,261,268,', '3', '0', 'rongxian', '0', '0');
INSERT INTO `district` VALUES ('269', '福安市', '261', ',227,261,269,', '3', '0', 'fuanshi', '0', '0');
INSERT INTO `district` VALUES ('270', '福鼎市', '261', ',227,261,270,', '3', '0', 'fudingshi', '0', '0');
INSERT INTO `district` VALUES ('271', '莆田市', '227', ',227,271,', '2', '0', 'putianshi', '0', '0');
INSERT INTO `district` VALUES ('272', '城厢区', '271', ',227,271,272,', '3', '0', 'chengxiangqu', '0', '0');
INSERT INTO `district` VALUES ('273', '涵江区', '271', ',227,271,273,', '3', '0', 'hanjiangqu', '0', '0');
INSERT INTO `district` VALUES ('274', '荔城区', '271', ',227,271,274,', '3', '0', 'lichengqu', '0', '0');
INSERT INTO `district` VALUES ('275', '秀屿区', '271', ',227,271,275,', '3', '0', 'xiuyuqu', '0', '0');
INSERT INTO `district` VALUES ('276', '仙游县', '271', ',227,271,276,', '3', '0', 'xianyouxian', '0', '0');
INSERT INTO `district` VALUES ('277', '泉州市', '227', ',227,277,', '2', '0', 'quanzhoushi', '0', '0');
INSERT INTO `district` VALUES ('278', '鲤城区', '277', ',227,277,278,', '3', '0', 'lichengqu', '0', '0');
INSERT INTO `district` VALUES ('279', '丰泽区', '277', ',227,277,279,', '3', '0', 'fengzequ', '0', '0');
INSERT INTO `district` VALUES ('280', '洛江区', '277', ',227,277,280,', '3', '0', 'luojiangqu', '0', '0');
INSERT INTO `district` VALUES ('281', '泉港区', '277', ',227,277,281,', '3', '0', 'quangangqu', '0', '0');
INSERT INTO `district` VALUES ('282', '惠安县', '277', ',227,277,282,', '3', '0', 'huianxian', '0', '0');
INSERT INTO `district` VALUES ('283', '安溪县', '277', ',227,277,283,', '3', '0', 'anxixian', '0', '0');
INSERT INTO `district` VALUES ('284', '永春县', '277', ',227,277,284,', '3', '0', 'yongchunxian', '0', '0');
INSERT INTO `district` VALUES ('285', '德化县', '277', ',227,277,285,', '3', '0', 'dehuaxian', '0', '0');
INSERT INTO `district` VALUES ('286', '金门县', '277', ',227,277,286,', '3', '0', 'jinmenxian', '0', '0');
INSERT INTO `district` VALUES ('287', '石狮市', '277', ',227,277,287,', '3', '0', 'shishishi', '0', '0');
INSERT INTO `district` VALUES ('288', '晋江市', '277', ',227,277,288,', '3', '0', 'jinjiangshi', '0', '0');
INSERT INTO `district` VALUES ('289', '南安市', '277', ',227,277,289,', '3', '0', 'nananshi', '0', '0');
INSERT INTO `district` VALUES ('290', '三明市', '227', ',227,290,', '2', '0', 'sanmingshi', '0', '0');
INSERT INTO `district` VALUES ('291', '梅列区', '290', ',227,290,291,', '3', '0', 'meiliequ', '0', '0');
INSERT INTO `district` VALUES ('292', '三元区', '290', ',227,290,292,', '3', '0', 'sanyuanqu', '0', '0');
INSERT INTO `district` VALUES ('293', '明溪县', '290', ',227,290,293,', '3', '0', 'mingxixian', '0', '0');
INSERT INTO `district` VALUES ('294', '清流县', '290', ',227,290,294,', '3', '0', 'qingliuxian', '0', '0');
INSERT INTO `district` VALUES ('295', '宁化县', '290', ',227,290,295,', '3', '0', 'ninghuaxian', '0', '0');
INSERT INTO `district` VALUES ('296', '大田县', '290', ',227,290,296,', '3', '0', 'datianxian', '0', '0');
INSERT INTO `district` VALUES ('297', '尤溪县', '290', ',227,290,297,', '3', '0', 'youxixian', '0', '0');
INSERT INTO `district` VALUES ('298', '沙县', '290', ',227,290,298,', '3', '0', 'shaxian', '0', '0');
INSERT INTO `district` VALUES ('299', '将乐县', '290', ',227,290,299,', '3', '0', 'jianglexian', '0', '0');
INSERT INTO `district` VALUES ('300', '泰宁县', '290', ',227,290,300,', '3', '0', 'tainingxian', '0', '0');
INSERT INTO `district` VALUES ('301', '建宁县', '290', ',227,290,301,', '3', '0', 'jianningxian', '0', '0');
INSERT INTO `district` VALUES ('302', '永安市', '290', ',227,290,302,', '3', '0', 'yonganshi', '0', '0');
INSERT INTO `district` VALUES ('303', '厦门市', '227', ',227,303,', '2', '0', 'xiamenshi', '0', '0');
INSERT INTO `district` VALUES ('304', '思明区', '303', ',227,303,304,', '3', '0', 'simingqu', '0', '0');
INSERT INTO `district` VALUES ('305', '海沧区', '303', ',227,303,305,', '3', '0', 'haicangqu', '0', '0');
INSERT INTO `district` VALUES ('306', '湖里区', '303', ',227,303,306,', '3', '0', 'huliqu', '0', '0');
INSERT INTO `district` VALUES ('307', '集美区', '303', ',227,303,307,', '3', '0', 'jimeiqu', '0', '0');
INSERT INTO `district` VALUES ('308', '同安区', '303', ',227,303,308,', '3', '0', 'tonganqu', '0', '0');
INSERT INTO `district` VALUES ('309', '翔安区', '303', ',227,303,309,', '3', '0', 'xianganqu', '0', '0');
INSERT INTO `district` VALUES ('310', '漳州市', '227', ',227,310,', '2', '0', 'zhangzhoushi', '0', '0');
INSERT INTO `district` VALUES ('311', '芗城区', '310', ',227,310,311,', '3', '0', 'chengqu', '0', '0');
INSERT INTO `district` VALUES ('312', '龙文区', '310', ',227,310,312,', '3', '0', 'longwenqu', '0', '0');
INSERT INTO `district` VALUES ('313', '云霄县', '310', ',227,310,313,', '3', '0', 'yunxiaoxian', '0', '0');
INSERT INTO `district` VALUES ('314', '漳浦县', '310', ',227,310,314,', '3', '0', 'zhangpuxian', '0', '0');
INSERT INTO `district` VALUES ('315', '诏安县', '310', ',227,310,315,', '3', '0', 'anxian', '0', '0');
INSERT INTO `district` VALUES ('316', '长泰县', '310', ',227,310,316,', '3', '0', 'changtaixian', '0', '0');
INSERT INTO `district` VALUES ('317', '东山县', '310', ',227,310,317,', '3', '0', 'dongshanxian', '0', '0');
INSERT INTO `district` VALUES ('318', '南靖县', '310', ',227,310,318,', '3', '0', 'nanjingxian', '0', '0');
INSERT INTO `district` VALUES ('319', '平和县', '310', ',227,310,319,', '3', '0', 'pinghexian', '0', '0');
INSERT INTO `district` VALUES ('320', '华安县', '310', ',227,310,320,', '3', '0', 'huaanxian', '0', '0');
INSERT INTO `district` VALUES ('321', '龙海市', '310', ',227,310,321,', '3', '0', 'longhaishi', '0', '0');
INSERT INTO `district` VALUES ('322', '甘肃省', '0', ',322,', '1', '0', 'gansusheng', '0', '0');
INSERT INTO `district` VALUES ('323', '兰州市', '322', ',322,323,', '2', '0', 'lanzhoushi', '0', '0');
INSERT INTO `district` VALUES ('324', '城关区', '323', ',322,323,324,', '3', '0', 'chengguanqu', '0', '0');
INSERT INTO `district` VALUES ('325', '七里河区', '323', ',322,323,325,', '3', '0', 'qilihequ', '0', '0');
INSERT INTO `district` VALUES ('326', '西固区', '323', ',322,323,326,', '3', '0', 'xiguqu', '0', '0');
INSERT INTO `district` VALUES ('327', '安宁区', '323', ',322,323,327,', '3', '0', 'anningqu', '0', '0');
INSERT INTO `district` VALUES ('328', '红古区', '323', ',322,323,328,', '3', '0', 'hongguqu', '0', '0');
INSERT INTO `district` VALUES ('329', '永登县', '323', ',322,323,329,', '3', '0', 'yongdengxian', '0', '0');
INSERT INTO `district` VALUES ('330', '皋兰县', '323', ',322,323,330,', '3', '0', 'gaolanxian', '0', '0');
INSERT INTO `district` VALUES ('331', '榆中县', '323', ',322,323,331,', '3', '0', 'yuzhongxian', '0', '0');
INSERT INTO `district` VALUES ('332', '白银市', '322', ',322,332,', '2', '0', 'baiyinshi', '0', '0');
INSERT INTO `district` VALUES ('333', '白银区', '332', ',322,332,333,', '3', '0', 'baiyinqu', '0', '0');
INSERT INTO `district` VALUES ('334', '平川区', '332', ',322,332,334,', '3', '0', 'pingchuanqu', '0', '0');
INSERT INTO `district` VALUES ('335', '靖远县', '332', ',322,332,335,', '3', '0', 'jingyuanxian', '0', '0');
INSERT INTO `district` VALUES ('336', '会宁县', '332', ',322,332,336,', '3', '0', 'huiningxian', '0', '0');
INSERT INTO `district` VALUES ('337', '景泰县', '332', ',322,332,337,', '3', '0', 'jingtaixian', '0', '0');
INSERT INTO `district` VALUES ('338', '定西市', '322', ',322,338,', '2', '0', 'dingxishi', '0', '0');
INSERT INTO `district` VALUES ('339', '安定区', '338', ',322,338,339,', '3', '0', 'andingqu', '0', '0');
INSERT INTO `district` VALUES ('340', '通渭县', '338', ',322,338,340,', '3', '0', 'tongweixian', '0', '0');
INSERT INTO `district` VALUES ('341', '陇西县', '338', ',322,338,341,', '3', '0', 'longxixian', '0', '0');
INSERT INTO `district` VALUES ('342', '渭源县', '338', ',322,338,342,', '3', '0', 'weiyuanxian', '0', '0');
INSERT INTO `district` VALUES ('343', '临洮县', '338', ',322,338,343,', '3', '0', 'linxian', '0', '0');
INSERT INTO `district` VALUES ('344', '漳县', '338', ',322,338,344,', '3', '0', 'zhangxian', '0', '0');
INSERT INTO `district` VALUES ('345', '岷县', '338', ',322,338,345,', '3', '0', 'xian', '0', '0');
INSERT INTO `district` VALUES ('346', '甘南藏族自治州', '322', ',322,346,', '2', '0', 'gannancangzuzizhizhou', '0', '0');
INSERT INTO `district` VALUES ('347', '合作市', '346', ',322,346,347,', '3', '0', 'hezuoshi', '0', '0');
INSERT INTO `district` VALUES ('348', '临潭县', '346', ',322,346,348,', '3', '0', 'lintanxian', '0', '0');
INSERT INTO `district` VALUES ('349', '卓尼县', '346', ',322,346,349,', '3', '0', 'zhuonixian', '0', '0');
INSERT INTO `district` VALUES ('350', '舟曲县', '346', ',322,346,350,', '3', '0', 'zhouquxian', '0', '0');
INSERT INTO `district` VALUES ('351', '迭部县', '346', ',322,346,351,', '3', '0', 'diebuxian', '0', '0');
INSERT INTO `district` VALUES ('352', '玛曲县', '346', ',322,346,352,', '3', '0', 'maquxian', '0', '0');
INSERT INTO `district` VALUES ('353', '碌曲县', '346', ',322,346,353,', '3', '0', 'luquxian', '0', '0');
INSERT INTO `district` VALUES ('354', '夏河县', '346', ',322,346,354,', '3', '0', 'xiahexian', '0', '0');
INSERT INTO `district` VALUES ('355', '嘉峪关市', '322', ',322,355,', '2', '0', 'jiayuguanshi', '0', '0');
INSERT INTO `district` VALUES ('356', '金昌市', '322', ',322,356,', '2', '0', 'jinchangshi', '0', '0');
INSERT INTO `district` VALUES ('357', '金川区', '356', ',322,356,357,', '3', '0', 'jinchuanqu', '0', '0');
INSERT INTO `district` VALUES ('358', '永昌县', '356', ',322,356,358,', '3', '0', 'yongchangxian', '0', '0');
INSERT INTO `district` VALUES ('359', '酒泉市', '322', ',322,359,', '2', '0', 'jiuquanshi', '0', '0');
INSERT INTO `district` VALUES ('360', '肃州区', '359', ',322,359,360,', '3', '0', 'suzhouqu', '0', '0');
INSERT INTO `district` VALUES ('361', '金塔县', '359', ',322,359,361,', '3', '0', 'jintaxian', '0', '0');
INSERT INTO `district` VALUES ('362', '安西县', '359', ',322,359,362,', '3', '0', 'anxixian', '0', '0');
INSERT INTO `district` VALUES ('363', '肃北蒙古族自治县', '359', ',322,359,363,', '3', '0', 'subeimengguzuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('364', '阿克塞哈萨克族自治县', '359', ',322,359,364,', '3', '0', 'akesaihasakezuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('365', '玉门市', '359', ',322,359,365,', '3', '0', 'yumenshi', '0', '0');
INSERT INTO `district` VALUES ('366', '敦煌市', '359', ',322,359,366,', '3', '0', 'dunhuangshi', '0', '0');
INSERT INTO `district` VALUES ('367', '临夏回族自治州', '322', ',322,367,', '2', '0', 'linxiahuizuzizhizhou', '0', '0');
INSERT INTO `district` VALUES ('368', '临夏市', '367', ',322,367,368,', '3', '0', 'linxiashi', '0', '0');
INSERT INTO `district` VALUES ('369', '临夏县', '367', ',322,367,369,', '3', '0', 'linxiaxian', '0', '0');
INSERT INTO `district` VALUES ('370', '康乐县', '367', ',322,367,370,', '3', '0', 'kanglexian', '0', '0');
INSERT INTO `district` VALUES ('371', '永靖县', '367', ',322,367,371,', '3', '0', 'yongjingxian', '0', '0');
INSERT INTO `district` VALUES ('372', '广河县', '367', ',322,367,372,', '3', '0', 'guanghexian', '0', '0');
INSERT INTO `district` VALUES ('373', '和政县', '367', ',322,367,373,', '3', '0', 'hezhengxian', '0', '0');
INSERT INTO `district` VALUES ('374', '东乡族自治县', '367', ',322,367,374,', '3', '0', 'dongxiangzuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('375', '积石山保安族东乡族撒拉族自治县', '367', ',322,367,375,', '3', '0', 'jishishanbaoanzudongxiangzusalazuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('376', '陇南市', '322', ',322,376,', '2', '0', 'longnanshi', '0', '0');
INSERT INTO `district` VALUES ('377', '武都区', '376', ',322,376,377,', '3', '0', 'wuduqu', '0', '0');
INSERT INTO `district` VALUES ('378', '成县', '376', ',322,376,378,', '3', '0', 'chengxian', '0', '0');
INSERT INTO `district` VALUES ('379', '文县', '376', ',322,376,379,', '3', '0', 'wenxian', '0', '0');
INSERT INTO `district` VALUES ('380', '宕昌县', '376', ',322,376,380,', '3', '0', 'changxian', '0', '0');
INSERT INTO `district` VALUES ('381', '康县', '376', ',322,376,381,', '3', '0', 'kangxian', '0', '0');
INSERT INTO `district` VALUES ('382', '西和县', '376', ',322,376,382,', '3', '0', 'xihexian', '0', '0');
INSERT INTO `district` VALUES ('383', '礼县', '376', ',322,376,383,', '3', '0', 'lixian', '0', '0');
INSERT INTO `district` VALUES ('384', '徽县', '376', ',322,376,384,', '3', '0', 'huixian', '0', '0');
INSERT INTO `district` VALUES ('385', '两当县', '376', ',322,376,385,', '3', '0', 'liangdangxian', '0', '0');
INSERT INTO `district` VALUES ('386', '平凉市', '322', ',322,386,', '2', '0', 'pingliangshi', '0', '0');
INSERT INTO `district` VALUES ('387', '崆峒区', '386', ',322,386,387,', '3', '0', 'qu', '0', '0');
INSERT INTO `district` VALUES ('388', '泾川县', '386', ',322,386,388,', '3', '0', 'chuanxian', '0', '0');
INSERT INTO `district` VALUES ('389', '灵台县', '386', ',322,386,389,', '3', '0', 'lingtaixian', '0', '0');
INSERT INTO `district` VALUES ('390', '崇信县', '386', ',322,386,390,', '3', '0', 'chongxinxian', '0', '0');
INSERT INTO `district` VALUES ('391', '华亭县', '386', ',322,386,391,', '3', '0', 'huatingxian', '0', '0');
INSERT INTO `district` VALUES ('392', '庄浪县', '386', ',322,386,392,', '3', '0', 'zhuanglangxian', '0', '0');
INSERT INTO `district` VALUES ('393', '静宁县', '386', ',322,386,393,', '3', '0', 'jingningxian', '0', '0');
INSERT INTO `district` VALUES ('394', '庆阳市', '322', ',322,394,', '2', '0', 'qingyangshi', '0', '0');
INSERT INTO `district` VALUES ('395', '西峰区', '394', ',322,394,395,', '3', '0', 'xifengqu', '0', '0');
INSERT INTO `district` VALUES ('396', '庆城县', '394', ',322,394,396,', '3', '0', 'qingchengxian', '0', '0');
INSERT INTO `district` VALUES ('397', '环县', '394', ',322,394,397,', '3', '0', 'huanxian', '0', '0');
INSERT INTO `district` VALUES ('398', '华池县', '394', ',322,394,398,', '3', '0', 'huachixian', '0', '0');
INSERT INTO `district` VALUES ('399', '合水县', '394', ',322,394,399,', '3', '0', 'heshuixian', '0', '0');
INSERT INTO `district` VALUES ('400', '正宁县', '394', ',322,394,400,', '3', '0', 'zhengningxian', '0', '0');
INSERT INTO `district` VALUES ('401', '宁县', '394', ',322,394,401,', '3', '0', 'ningxian', '0', '0');
INSERT INTO `district` VALUES ('402', '镇原县', '394', ',322,394,402,', '3', '0', 'zhenyuanxian', '0', '0');
INSERT INTO `district` VALUES ('403', '天水市', '322', ',322,403,', '2', '0', 'tianshuishi', '0', '0');
INSERT INTO `district` VALUES ('404', '秦城区', '403', ',322,403,404,', '3', '0', 'qinchengqu', '0', '0');
INSERT INTO `district` VALUES ('405', '北道区', '403', ',322,403,405,', '3', '0', 'beidaoqu', '0', '0');
INSERT INTO `district` VALUES ('406', '清水县', '403', ',322,403,406,', '3', '0', 'qingshuixian', '0', '0');
INSERT INTO `district` VALUES ('407', '秦安县', '403', ',322,403,407,', '3', '0', 'qinanxian', '0', '0');
INSERT INTO `district` VALUES ('408', '甘谷县', '403', ',322,403,408,', '3', '0', 'ganguxian', '0', '0');
INSERT INTO `district` VALUES ('409', '武山县', '403', ',322,403,409,', '3', '0', 'wushanxian', '0', '0');
INSERT INTO `district` VALUES ('410', '张家川回族自治县', '403', ',322,403,410,', '3', '0', 'zhangjiachuanhuizuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('411', '武威市', '322', ',322,411,', '2', '0', 'wuweishi', '0', '0');
INSERT INTO `district` VALUES ('412', '凉州区', '411', ',322,411,412,', '3', '0', 'liangzhouqu', '0', '0');
INSERT INTO `district` VALUES ('413', '民勤县', '411', ',322,411,413,', '3', '0', 'minqinxian', '0', '0');
INSERT INTO `district` VALUES ('414', '古浪县', '411', ',322,411,414,', '3', '0', 'gulangxian', '0', '0');
INSERT INTO `district` VALUES ('415', '天祝藏族自治县', '411', ',322,411,415,', '3', '0', 'tianzhucangzuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('416', '张掖市', '322', ',322,416,', '2', '0', 'zhangyeshi', '0', '0');
INSERT INTO `district` VALUES ('417', '甘州区', '416', ',322,416,417,', '3', '0', 'ganzhouqu', '0', '0');
INSERT INTO `district` VALUES ('418', '肃南裕固族自治县', '416', ',322,416,418,', '3', '0', 'sunanyuguzuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('419', '民乐县', '416', ',322,416,419,', '3', '0', 'minlexian', '0', '0');
INSERT INTO `district` VALUES ('420', '临泽县', '416', ',322,416,420,', '3', '0', 'linzexian', '0', '0');
INSERT INTO `district` VALUES ('421', '高台县', '416', ',322,416,421,', '3', '0', 'gaotaixian', '0', '0');
INSERT INTO `district` VALUES ('422', '山丹县', '416', ',322,416,422,', '3', '0', 'shandanxian', '0', '0');
INSERT INTO `district` VALUES ('423', '广东省', '0', ',423,', '1', '0', 'guangdongsheng', '1', '0');
INSERT INTO `district` VALUES ('424', '广州市', '423', ',423,424,', '2', '0', 'guangzhoushi', '1', '0');
INSERT INTO `district` VALUES ('425', '东山区', '424', ',423,424,425,', '3', '0', 'dongshanqu', '0', '0');
INSERT INTO `district` VALUES ('426', '荔湾区', '424', ',423,424,426,', '3', '0', 'liwanqu', '0', '0');
INSERT INTO `district` VALUES ('427', '越秀区', '424', ',423,424,427,', '3', '0', 'yuexiuqu', '0', '0');
INSERT INTO `district` VALUES ('428', '海珠区', '424', ',423,424,428,', '3', '0', 'haizhuqu', '0', '0');
INSERT INTO `district` VALUES ('429', '天河区', '424', ',423,424,429,', '3', '0', 'tianhequ', '0', '0');
INSERT INTO `district` VALUES ('430', '芳村区', '424', ',423,424,430,', '3', '0', 'fangcunqu', '0', '0');
INSERT INTO `district` VALUES ('431', '白云区', '424', ',423,424,431,', '3', '0', 'baiyunqu', '0', '0');
INSERT INTO `district` VALUES ('432', '黄埔区', '424', ',423,424,432,', '3', '0', 'huangpuqu', '0', '0');
INSERT INTO `district` VALUES ('433', '番禺区', '424', ',423,424,433,', '3', '0', 'fanqu', '0', '0');
INSERT INTO `district` VALUES ('434', '花都区', '424', ',423,424,434,', '3', '0', 'huaduqu', '0', '0');
INSERT INTO `district` VALUES ('435', '增城市', '424', ',423,424,435,', '3', '0', 'zengchengshi', '0', '0');
INSERT INTO `district` VALUES ('436', '从化市', '424', ',423,424,436,', '3', '0', 'conghuashi', '0', '0');
INSERT INTO `district` VALUES ('437', '潮州市', '423', ',423,437,', '2', '0', 'chaozhoushi', '0', '0');
INSERT INTO `district` VALUES ('438', '湘桥区', '437', ',423,437,438,', '3', '0', 'xiangqiaoqu', '0', '0');
INSERT INTO `district` VALUES ('439', '潮安县', '437', ',423,437,439,', '3', '0', 'chaoanxian', '0', '0');
INSERT INTO `district` VALUES ('440', '饶平县', '437', ',423,437,440,', '3', '0', 'raopingxian', '0', '0');
INSERT INTO `district` VALUES ('441', '东莞市', '423', ',423,441,', '2', '0', 'dongshi', '0', '0');
INSERT INTO `district` VALUES ('442', '佛山市', '423', ',423,442,', '2', '0', 'foshanshi', '0', '0');
INSERT INTO `district` VALUES ('443', '禅城区', '442', ',423,442,443,', '3', '0', 'chengqu', '0', '0');
INSERT INTO `district` VALUES ('444', '南海区', '442', ',423,442,444,', '3', '0', 'nanhaiqu', '0', '0');
INSERT INTO `district` VALUES ('445', '顺德区', '442', ',423,442,445,', '3', '0', 'shundequ', '0', '0');
INSERT INTO `district` VALUES ('446', '三水区', '442', ',423,442,446,', '3', '0', 'sanshuiqu', '0', '0');
INSERT INTO `district` VALUES ('447', '高明区', '442', ',423,442,447,', '3', '0', 'gaomingqu', '0', '0');
INSERT INTO `district` VALUES ('448', '河源市', '423', ',423,448,', '2', '0', 'heyuanshi', '0', '0');
INSERT INTO `district` VALUES ('449', '源城区', '448', ',423,448,449,', '3', '0', 'yuanchengqu', '0', '0');
INSERT INTO `district` VALUES ('450', '紫金县', '448', ',423,448,450,', '3', '0', 'zijinxian', '0', '0');
INSERT INTO `district` VALUES ('451', '龙川县', '448', ',423,448,451,', '3', '0', 'longchuanxian', '0', '0');
INSERT INTO `district` VALUES ('452', '连平县', '448', ',423,448,452,', '3', '0', 'lianpingxian', '0', '0');
INSERT INTO `district` VALUES ('453', '和平县', '448', ',423,448,453,', '3', '0', 'hepingxian', '0', '0');
INSERT INTO `district` VALUES ('454', '东源县', '448', ',423,448,454,', '3', '0', 'dongyuanxian', '0', '0');
INSERT INTO `district` VALUES ('455', '惠州市', '423', ',423,455,', '2', '0', 'huizhoushi', '0', '0');
INSERT INTO `district` VALUES ('456', '惠城区', '455', ',423,455,456,', '3', '0', 'huichengqu', '0', '0');
INSERT INTO `district` VALUES ('457', '惠阳区', '455', ',423,455,457,', '3', '0', 'huiyangqu', '0', '0');
INSERT INTO `district` VALUES ('458', '博罗县', '455', ',423,455,458,', '3', '0', 'boluoxian', '0', '0');
INSERT INTO `district` VALUES ('459', '惠东县', '455', ',423,455,459,', '3', '0', 'huidongxian', '0', '0');
INSERT INTO `district` VALUES ('460', '龙门县', '455', ',423,455,460,', '3', '0', 'longmenxian', '0', '0');
INSERT INTO `district` VALUES ('461', '江门市', '423', ',423,461,', '2', '0', 'jiangmenshi', '0', '0');
INSERT INTO `district` VALUES ('462', '蓬江区', '461', ',423,461,462,', '3', '0', 'pengjiangqu', '0', '0');
INSERT INTO `district` VALUES ('463', '江海区', '461', ',423,461,463,', '3', '0', 'jianghaiqu', '0', '0');
INSERT INTO `district` VALUES ('464', '新会区', '461', ',423,461,464,', '3', '0', 'xinhuiqu', '0', '0');
INSERT INTO `district` VALUES ('465', '台山市', '461', ',423,461,465,', '3', '0', 'taishanshi', '0', '0');
INSERT INTO `district` VALUES ('466', '开平市', '461', ',423,461,466,', '3', '0', 'kaipingshi', '0', '0');
INSERT INTO `district` VALUES ('467', '鹤山市', '461', ',423,461,467,', '3', '0', 'heshanshi', '0', '0');
INSERT INTO `district` VALUES ('468', '恩平市', '461', ',423,461,468,', '3', '0', 'enpingshi', '0', '0');
INSERT INTO `district` VALUES ('469', '揭阳市', '423', ',423,469,', '2', '0', 'jieyangshi', '0', '0');
INSERT INTO `district` VALUES ('470', '榕城区', '469', ',423,469,470,', '3', '0', 'chengqu', '0', '0');
INSERT INTO `district` VALUES ('471', '揭东县', '469', ',423,469,471,', '3', '0', 'jiedongxian', '0', '0');
INSERT INTO `district` VALUES ('472', '揭西县', '469', ',423,469,472,', '3', '0', 'jiexixian', '0', '0');
INSERT INTO `district` VALUES ('473', '惠来县', '469', ',423,469,473,', '3', '0', 'huilaixian', '0', '0');
INSERT INTO `district` VALUES ('474', '普宁市', '469', ',423,469,474,', '3', '0', 'puningshi', '0', '0');
INSERT INTO `district` VALUES ('475', '茂名市', '423', ',423,475,', '2', '0', 'maomingshi', '0', '0');
INSERT INTO `district` VALUES ('476', '茂南区', '475', ',423,475,476,', '3', '0', 'maonanqu', '0', '0');
INSERT INTO `district` VALUES ('477', '茂港区', '475', ',423,475,477,', '3', '0', 'maogangqu', '0', '0');
INSERT INTO `district` VALUES ('478', '电白县', '475', ',423,475,478,', '3', '0', 'dianbaixian', '0', '0');
INSERT INTO `district` VALUES ('479', '高州市', '475', ',423,475,479,', '3', '0', 'gaozhoushi', '0', '0');
INSERT INTO `district` VALUES ('480', '化州市', '475', ',423,475,480,', '3', '0', 'huazhoushi', '0', '0');
INSERT INTO `district` VALUES ('481', '信宜市', '475', ',423,475,481,', '3', '0', 'xinyishi', '0', '0');
INSERT INTO `district` VALUES ('482', '梅江区', '423', ',423,482,', '2', '0', 'meijiangqu', '0', '0');
INSERT INTO `district` VALUES ('483', '梅州市', '423', ',423,483,', '2', '0', 'meizhoushi', '0', '0');
INSERT INTO `district` VALUES ('484', '梅县', '483', ',423,483,484,', '3', '0', 'meixian', '0', '0');
INSERT INTO `district` VALUES ('485', '大埔县', '483', ',423,483,485,', '3', '0', 'dapuxian', '0', '0');
INSERT INTO `district` VALUES ('486', '丰顺县', '483', ',423,483,486,', '3', '0', 'fengshunxian', '0', '0');
INSERT INTO `district` VALUES ('487', '五华县', '483', ',423,483,487,', '3', '0', 'wuhuaxian', '0', '0');
INSERT INTO `district` VALUES ('488', '平远县', '483', ',423,483,488,', '3', '0', 'pingyuanxian', '0', '0');
INSERT INTO `district` VALUES ('489', '蕉岭县', '483', ',423,483,489,', '3', '0', 'jiaolingxian', '0', '0');
INSERT INTO `district` VALUES ('490', '兴宁市', '483', ',423,483,490,', '3', '0', 'xingningshi', '0', '0');
INSERT INTO `district` VALUES ('491', '清远市', '423', ',423,491,', '2', '0', 'qingyuanshi', '0', '0');
INSERT INTO `district` VALUES ('492', '清城区', '491', ',423,491,492,', '3', '0', 'qingchengqu', '0', '0');
INSERT INTO `district` VALUES ('493', '佛冈县', '491', ',423,491,493,', '3', '0', 'fogangxian', '0', '0');
INSERT INTO `district` VALUES ('494', '阳山县', '491', ',423,491,494,', '3', '0', 'yangshanxian', '0', '0');
INSERT INTO `district` VALUES ('495', '连山壮族瑶族自治县', '491', ',423,491,495,', '3', '0', 'lianshanzhuangzuyaozuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('496', '连南瑶族自治县', '491', ',423,491,496,', '3', '0', 'liannanyaozuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('497', '清新县', '491', ',423,491,497,', '3', '0', 'qingxinxian', '0', '0');
INSERT INTO `district` VALUES ('498', '英德市', '491', ',423,491,498,', '3', '0', 'yingdeshi', '0', '0');
INSERT INTO `district` VALUES ('499', '连州市', '491', ',423,491,499,', '3', '0', 'lianzhoushi', '0', '0');
INSERT INTO `district` VALUES ('500', '汕头市', '423', ',423,500,', '2', '0', 'shantoushi', '0', '0');
INSERT INTO `district` VALUES ('501', '龙湖区', '500', ',423,500,501,', '3', '0', 'longhuqu', '0', '0');
INSERT INTO `district` VALUES ('502', '金平区', '500', ',423,500,502,', '3', '0', 'jinpingqu', '0', '0');
INSERT INTO `district` VALUES ('503', '濠江区', '500', ',423,500,503,', '3', '0', 'jiangqu', '0', '0');
INSERT INTO `district` VALUES ('504', '潮阳区', '500', ',423,500,504,', '3', '0', 'chaoyangqu', '0', '0');
INSERT INTO `district` VALUES ('505', '潮南区', '500', ',423,500,505,', '3', '0', 'chaonanqu', '0', '0');
INSERT INTO `district` VALUES ('506', '澄海区', '500', ',423,500,506,', '3', '0', 'chenghaiqu', '0', '0');
INSERT INTO `district` VALUES ('507', '南澳县', '500', ',423,500,507,', '3', '0', 'nanaoxian', '0', '0');
INSERT INTO `district` VALUES ('508', '汕尾市', '423', ',423,508,', '2', '0', 'shanweishi', '0', '0');
INSERT INTO `district` VALUES ('509', '城区', '508', ',423,508,509,', '3', '0', 'chengqu', '0', '0');
INSERT INTO `district` VALUES ('510', '海丰县', '508', ',423,508,510,', '3', '0', 'haifengxian', '0', '0');
INSERT INTO `district` VALUES ('511', '陆河县', '508', ',423,508,511,', '3', '0', 'luhexian', '0', '0');
INSERT INTO `district` VALUES ('512', '陆丰市', '508', ',423,508,512,', '3', '0', 'lufengshi', '0', '0');
INSERT INTO `district` VALUES ('513', '韶关市', '423', ',423,513,', '2', '0', 'shaoguanshi', '0', '0');
INSERT INTO `district` VALUES ('514', '武江区', '513', ',423,513,514,', '3', '0', 'wujiangqu', '0', '0');
INSERT INTO `district` VALUES ('515', '浈江区', '513', ',423,513,515,', '3', '0', 'jiangqu', '0', '0');
INSERT INTO `district` VALUES ('516', '曲江区', '513', ',423,513,516,', '3', '0', 'qujiangqu', '0', '0');
INSERT INTO `district` VALUES ('517', '始兴县', '513', ',423,513,517,', '3', '0', 'shixingxian', '0', '0');
INSERT INTO `district` VALUES ('518', '仁化县', '513', ',423,513,518,', '3', '0', 'renhuaxian', '0', '0');
INSERT INTO `district` VALUES ('519', '翁源县', '513', ',423,513,519,', '3', '0', 'wengyuanxian', '0', '0');
INSERT INTO `district` VALUES ('520', '乳源瑶族自治县', '513', ',423,513,520,', '3', '0', 'ruyuanyaozuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('521', '新丰县', '513', ',423,513,521,', '3', '0', 'xinfengxian', '0', '0');
INSERT INTO `district` VALUES ('522', '乐昌市', '513', ',423,513,522,', '3', '0', 'lechangshi', '0', '0');
INSERT INTO `district` VALUES ('523', '南雄市', '513', ',423,513,523,', '3', '0', 'nanxiongshi', '0', '0');
INSERT INTO `district` VALUES ('524', '深圳市', '423', ',423,524,', '2', '0', 'shenshi', '1', '0');
INSERT INTO `district` VALUES ('525', '罗湖区', '524', ',423,524,525,', '3', '0', 'luohuqu', '0', '0');
INSERT INTO `district` VALUES ('526', '福田区', '524', ',423,524,526,', '3', '0', 'futianqu', '0', '0');
INSERT INTO `district` VALUES ('527', '南山区', '524', ',423,524,527,', '3', '0', 'nanshanqu', '0', '0');
INSERT INTO `district` VALUES ('528', '宝安区', '524', ',423,524,528,', '3', '0', 'baoanqu', '0', '0');
INSERT INTO `district` VALUES ('529', '龙岗区', '524', ',423,524,529,', '3', '0', 'longgangqu', '0', '0');
INSERT INTO `district` VALUES ('530', '盐田区', '524', ',423,524,530,', '3', '0', 'yantianqu', '0', '0');
INSERT INTO `district` VALUES ('531', '阳江市', '423', ',423,531,', '2', '0', 'yangjiangshi', '0', '0');
INSERT INTO `district` VALUES ('532', '江城区', '531', ',423,531,532,', '3', '0', 'jiangchengqu', '0', '0');
INSERT INTO `district` VALUES ('533', '阳西县', '531', ',423,531,533,', '3', '0', 'yangxixian', '0', '0');
INSERT INTO `district` VALUES ('534', '阳东县', '531', ',423,531,534,', '3', '0', 'yangdongxian', '0', '0');
INSERT INTO `district` VALUES ('535', '阳春市', '531', ',423,531,535,', '3', '0', 'yangchunshi', '0', '0');
INSERT INTO `district` VALUES ('536', '云浮市', '423', ',423,536,', '2', '0', 'yunfushi', '0', '0');
INSERT INTO `district` VALUES ('537', '云城区', '536', ',423,536,537,', '3', '0', 'yunchengqu', '0', '0');
INSERT INTO `district` VALUES ('538', '新兴县', '536', ',423,536,538,', '3', '0', 'xinxingxian', '0', '0');
INSERT INTO `district` VALUES ('539', '郁南县', '536', ',423,536,539,', '3', '0', 'yunanxian', '0', '0');
INSERT INTO `district` VALUES ('540', '云安县', '536', ',423,536,540,', '3', '0', 'yunanxian', '0', '0');
INSERT INTO `district` VALUES ('541', '罗定市', '536', ',423,536,541,', '3', '0', 'luodingshi', '0', '0');
INSERT INTO `district` VALUES ('542', '湛江市', '423', ',423,542,', '2', '0', 'zhanjiangshi', '0', '0');
INSERT INTO `district` VALUES ('543', '赤坎区', '542', ',423,542,543,', '3', '0', 'chikanqu', '0', '0');
INSERT INTO `district` VALUES ('544', '霞山区', '542', ',423,542,544,', '3', '0', 'xiashanqu', '0', '0');
INSERT INTO `district` VALUES ('545', '坡头区', '542', ',423,542,545,', '3', '0', 'potouqu', '0', '0');
INSERT INTO `district` VALUES ('546', '麻章区', '542', ',423,542,546,', '3', '0', 'mazhangqu', '0', '0');
INSERT INTO `district` VALUES ('547', '遂溪县', '542', ',423,542,547,', '3', '0', 'suixixian', '0', '0');
INSERT INTO `district` VALUES ('548', '徐闻县', '542', ',423,542,548,', '3', '0', 'xuwenxian', '0', '0');
INSERT INTO `district` VALUES ('549', '廉江市', '542', ',423,542,549,', '3', '0', 'lianjiangshi', '0', '0');
INSERT INTO `district` VALUES ('550', '雷州市', '542', ',423,542,550,', '3', '0', 'leizhoushi', '0', '0');
INSERT INTO `district` VALUES ('551', '吴川市', '542', ',423,542,551,', '3', '0', 'wuchuanshi', '0', '0');
INSERT INTO `district` VALUES ('552', '肇庆市', '423', ',423,552,', '2', '0', 'zhaoqingshi', '0', '0');
INSERT INTO `district` VALUES ('553', '端州区', '552', ',423,552,553,', '3', '0', 'duanzhouqu', '0', '0');
INSERT INTO `district` VALUES ('554', '鼎湖区', '552', ',423,552,554,', '3', '0', 'dinghuqu', '0', '0');
INSERT INTO `district` VALUES ('555', '广宁县', '552', ',423,552,555,', '3', '0', 'guangningxian', '0', '0');
INSERT INTO `district` VALUES ('556', '怀集县', '552', ',423,552,556,', '3', '0', 'huaijixian', '0', '0');
INSERT INTO `district` VALUES ('557', '封开县', '552', ',423,552,557,', '3', '0', 'fengkaixian', '0', '0');
INSERT INTO `district` VALUES ('558', '德庆县', '552', ',423,552,558,', '3', '0', 'deqingxian', '0', '0');
INSERT INTO `district` VALUES ('559', '高要市', '552', ',423,552,559,', '3', '0', 'gaoyaoshi', '0', '0');
INSERT INTO `district` VALUES ('560', '四会市', '552', ',423,552,560,', '3', '0', 'sihuishi', '0', '0');
INSERT INTO `district` VALUES ('561', '中山市', '423', ',423,561,', '2', '0', 'zhongshanshi', '0', '0');
INSERT INTO `district` VALUES ('562', '珠海市', '423', ',423,562,', '2', '0', 'zhuhaishi', '0', '0');
INSERT INTO `district` VALUES ('563', '香洲区', '562', ',423,562,563,', '3', '0', 'xiangzhouqu', '0', '0');
INSERT INTO `district` VALUES ('564', '斗门区', '562', ',423,562,564,', '3', '0', 'doumenqu', '0', '0');
INSERT INTO `district` VALUES ('565', '金湾区', '562', ',423,562,565,', '3', '0', 'jinwanqu', '0', '0');
INSERT INTO `district` VALUES ('690', '贵州省', '0', ',690,', '1', '0', 'guizhousheng', '0', '0');
INSERT INTO `district` VALUES ('691', '贵阳市', '690', ',690,691,', '2', '0', 'guiyangshi', '0', '0');
INSERT INTO `district` VALUES ('692', '南明区', '691', ',690,691,692,', '3', '0', 'nanmingqu', '0', '0');
INSERT INTO `district` VALUES ('693', '云岩区', '691', ',690,691,693,', '3', '0', 'yunyanqu', '0', '0');
INSERT INTO `district` VALUES ('694', '花溪区', '691', ',690,691,694,', '3', '0', 'huaxiqu', '0', '0');
INSERT INTO `district` VALUES ('695', '乌当区', '691', ',690,691,695,', '3', '0', 'wudangqu', '0', '0');
INSERT INTO `district` VALUES ('696', '白云区', '691', ',690,691,696,', '3', '0', 'baiyunqu', '0', '0');
INSERT INTO `district` VALUES ('697', '小河区', '691', ',690,691,697,', '3', '0', 'xiaohequ', '0', '0');
INSERT INTO `district` VALUES ('698', '开阳县', '691', ',690,691,698,', '3', '0', 'kaiyangxian', '0', '0');
INSERT INTO `district` VALUES ('699', '息烽县', '691', ',690,691,699,', '3', '0', 'xifengxian', '0', '0');
INSERT INTO `district` VALUES ('700', '修文县', '691', ',690,691,700,', '3', '0', 'xiuwenxian', '0', '0');
INSERT INTO `district` VALUES ('701', '清镇市', '691', ',690,691,701,', '3', '0', 'qingzhenshi', '0', '0');
INSERT INTO `district` VALUES ('702', '安顺市', '690', ',690,702,', '2', '0', 'anshunshi', '0', '0');
INSERT INTO `district` VALUES ('703', '西秀区', '702', ',690,702,703,', '3', '0', 'xixiuqu', '0', '0');
INSERT INTO `district` VALUES ('704', '平坝县', '702', ',690,702,704,', '3', '0', 'pingbaxian', '0', '0');
INSERT INTO `district` VALUES ('705', '普定县', '702', ',690,702,705,', '3', '0', 'pudingxian', '0', '0');
INSERT INTO `district` VALUES ('706', '镇宁布依族苗族自治县', '702', ',690,702,706,', '3', '0', 'zhenningbuyizumiaozuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('707', '关岭布依族苗族自治县', '702', ',690,702,707,', '3', '0', 'guanlingbuyizumiaozuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('708', '紫云苗族布依族自治县', '702', ',690,702,708,', '3', '0', 'ziyunmiaozubuyizuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('709', '毕节地区', '690', ',690,709,', '2', '0', 'bijiediqu', '0', '0');
INSERT INTO `district` VALUES ('710', '毕节市', '709', ',690,709,710,', '3', '0', 'bijieshi', '0', '0');
INSERT INTO `district` VALUES ('711', '大方县', '709', ',690,709,711,', '3', '0', 'dafangxian', '0', '0');
INSERT INTO `district` VALUES ('712', '黔西县', '709', ',690,709,712,', '3', '0', 'qianxixian', '0', '0');
INSERT INTO `district` VALUES ('713', '金沙县', '709', ',690,709,713,', '3', '0', 'jinshaxian', '0', '0');
INSERT INTO `district` VALUES ('714', '织金县', '709', ',690,709,714,', '3', '0', 'zhijinxian', '0', '0');
INSERT INTO `district` VALUES ('715', '纳雍县', '709', ',690,709,715,', '3', '0', 'nayongxian', '0', '0');
INSERT INTO `district` VALUES ('716', '威宁彝族回族苗族自治县', '709', ',690,709,716,', '3', '0', 'weiningyizuhuizumiaozuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('717', '赫章县', '709', ',690,709,717,', '3', '0', 'hezhangxian', '0', '0');
INSERT INTO `district` VALUES ('718', '六盘水市', '690', ',690,718,', '2', '0', 'liupanshuishi', '0', '0');
INSERT INTO `district` VALUES ('719', '钟山区', '718', ',690,718,719,', '3', '0', 'zhongshanqu', '0', '0');
INSERT INTO `district` VALUES ('720', '六枝特区', '718', ',690,718,720,', '3', '0', 'liuzhitequ', '0', '0');
INSERT INTO `district` VALUES ('721', '水城县', '718', ',690,718,721,', '3', '0', 'shuichengxian', '0', '0');
INSERT INTO `district` VALUES ('722', '盘县', '718', ',690,718,722,', '3', '0', 'panxian', '0', '0');
INSERT INTO `district` VALUES ('723', '黔东南苗族侗族自治州', '690', ',690,723,', '2', '0', 'qiandongnanmiaozudongzuzizhizhou', '0', '0');
INSERT INTO `district` VALUES ('724', '凯里市', '723', ',690,723,724,', '3', '0', 'kailishi', '0', '0');
INSERT INTO `district` VALUES ('725', '黄平县', '723', ',690,723,725,', '3', '0', 'huangpingxian', '0', '0');
INSERT INTO `district` VALUES ('726', '施秉县', '723', ',690,723,726,', '3', '0', 'shibingxian', '0', '0');
INSERT INTO `district` VALUES ('727', '三穗县', '723', ',690,723,727,', '3', '0', 'sansuixian', '0', '0');
INSERT INTO `district` VALUES ('728', '镇远县', '723', ',690,723,728,', '3', '0', 'zhenyuanxian', '0', '0');
INSERT INTO `district` VALUES ('729', '岑巩县', '723', ',690,723,729,', '3', '0', 'gongxian', '0', '0');
INSERT INTO `district` VALUES ('730', '天柱县', '723', ',690,723,730,', '3', '0', 'tianzhuxian', '0', '0');
INSERT INTO `district` VALUES ('731', '锦屏县', '723', ',690,723,731,', '3', '0', 'jinpingxian', '0', '0');
INSERT INTO `district` VALUES ('732', '剑河县', '723', ',690,723,732,', '3', '0', 'jianhexian', '0', '0');
INSERT INTO `district` VALUES ('733', '台江县', '723', ',690,723,733,', '3', '0', 'taijiangxian', '0', '0');
INSERT INTO `district` VALUES ('734', '黎平县', '723', ',690,723,734,', '3', '0', 'lipingxian', '0', '0');
INSERT INTO `district` VALUES ('735', '榕江县', '723', ',690,723,735,', '3', '0', 'jiangxian', '0', '0');
INSERT INTO `district` VALUES ('736', '从江县', '723', ',690,723,736,', '3', '0', 'congjiangxian', '0', '0');
INSERT INTO `district` VALUES ('737', '雷山县', '723', ',690,723,737,', '3', '0', 'leishanxian', '0', '0');
INSERT INTO `district` VALUES ('738', '麻江县', '723', ',690,723,738,', '3', '0', 'majiangxian', '0', '0');
INSERT INTO `district` VALUES ('739', '丹寨县', '723', ',690,723,739,', '3', '0', 'danzhaixian', '0', '0');
INSERT INTO `district` VALUES ('740', '黔南布依族苗族自治州', '690', ',690,740,', '2', '0', 'qiannanbuyizumiaozuzizhizhou', '0', '0');
INSERT INTO `district` VALUES ('741', '都匀市', '740', ',690,740,741,', '3', '0', 'duyunshi', '0', '0');
INSERT INTO `district` VALUES ('742', '福泉市', '740', ',690,740,742,', '3', '0', 'fuquanshi', '0', '0');
INSERT INTO `district` VALUES ('743', '荔波县', '740', ',690,740,743,', '3', '0', 'liboxian', '0', '0');
INSERT INTO `district` VALUES ('744', '贵定县', '740', ',690,740,744,', '3', '0', 'guidingxian', '0', '0');
INSERT INTO `district` VALUES ('745', '瓮安县', '740', ',690,740,745,', '3', '0', 'wenganxian', '0', '0');
INSERT INTO `district` VALUES ('746', '独山县', '740', ',690,740,746,', '3', '0', 'dushanxian', '0', '0');
INSERT INTO `district` VALUES ('747', '平塘县', '740', ',690,740,747,', '3', '0', 'pingtangxian', '0', '0');
INSERT INTO `district` VALUES ('748', '罗甸县', '740', ',690,740,748,', '3', '0', 'luodianxian', '0', '0');
INSERT INTO `district` VALUES ('749', '长顺县', '740', ',690,740,749,', '3', '0', 'changshunxian', '0', '0');
INSERT INTO `district` VALUES ('750', '龙里县', '740', ',690,740,750,', '3', '0', 'longlixian', '0', '0');
INSERT INTO `district` VALUES ('751', '惠水县', '740', ',690,740,751,', '3', '0', 'huishuixian', '0', '0');
INSERT INTO `district` VALUES ('752', '三都水族自治县', '740', ',690,740,752,', '3', '0', 'sandushuizuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('753', '黔西南布依族苗族自治州', '690', ',690,753,', '2', '0', 'qianxinanbuyizumiaozuzizhizhou', '0', '0');
INSERT INTO `district` VALUES ('754', '兴义市', '753', ',690,753,754,', '3', '0', 'xingyishi', '0', '0');
INSERT INTO `district` VALUES ('755', '兴仁县', '753', ',690,753,755,', '3', '0', 'xingrenxian', '0', '0');
INSERT INTO `district` VALUES ('756', '普安县', '753', ',690,753,756,', '3', '0', 'puanxian', '0', '0');
INSERT INTO `district` VALUES ('757', '晴隆县', '753', ',690,753,757,', '3', '0', 'qinglongxian', '0', '0');
INSERT INTO `district` VALUES ('758', '贞丰县', '753', ',690,753,758,', '3', '0', 'zhenfengxian', '0', '0');
INSERT INTO `district` VALUES ('759', '望谟县', '753', ',690,753,759,', '3', '0', 'wangxian', '0', '0');
INSERT INTO `district` VALUES ('760', '册亨县', '753', ',690,753,760,', '3', '0', 'cehengxian', '0', '0');
INSERT INTO `district` VALUES ('761', '安龙县', '753', ',690,753,761,', '3', '0', 'anlongxian', '0', '0');
INSERT INTO `district` VALUES ('762', '铜仁地区', '690', ',690,762,', '2', '0', 'tongrendiqu', '0', '0');
INSERT INTO `district` VALUES ('763', '铜仁市', '762', ',690,762,763,', '3', '0', 'tongrenshi', '0', '0');
INSERT INTO `district` VALUES ('764', '江口县', '762', ',690,762,764,', '3', '0', 'jiangkouxian', '0', '0');
INSERT INTO `district` VALUES ('765', '玉屏侗族自治县', '762', ',690,762,765,', '3', '0', 'yupingdongzuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('766', '石阡县', '762', ',690,762,766,', '3', '0', 'shixian', '0', '0');
INSERT INTO `district` VALUES ('767', '思南县', '762', ',690,762,767,', '3', '0', 'sinanxian', '0', '0');
INSERT INTO `district` VALUES ('768', '印江土家族苗族自治县', '762', ',690,762,768,', '3', '0', 'yinjiangtujiazumiaozuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('769', '德江县', '762', ',690,762,769,', '3', '0', 'dejiangxian', '0', '0');
INSERT INTO `district` VALUES ('770', '沿河土家族自治县', '762', ',690,762,770,', '3', '0', 'yanhetujiazuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('771', '松桃苗族自治县', '762', ',690,762,771,', '3', '0', 'songtaomiaozuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('772', '万山特区', '762', ',690,762,772,', '3', '0', 'wanshantequ', '0', '0');
INSERT INTO `district` VALUES ('773', '遵义市', '690', ',690,773,', '2', '0', 'zunyishi', '0', '0');
INSERT INTO `district` VALUES ('774', '红花岗区', '773', ',690,773,774,', '3', '0', 'honghuagangqu', '0', '0');
INSERT INTO `district` VALUES ('775', '汇川区', '773', ',690,773,775,', '3', '0', 'huichuanqu', '0', '0');
INSERT INTO `district` VALUES ('776', '遵义县', '773', ',690,773,776,', '3', '0', 'zunyixian', '0', '0');
INSERT INTO `district` VALUES ('777', '桐梓县', '773', ',690,773,777,', '3', '0', 'tongxian', '0', '0');
INSERT INTO `district` VALUES ('778', '绥阳县', '773', ',690,773,778,', '3', '0', 'suiyangxian', '0', '0');
INSERT INTO `district` VALUES ('779', '正安县', '773', ',690,773,779,', '3', '0', 'zhenganxian', '0', '0');
INSERT INTO `district` VALUES ('780', '道真仡佬族苗族自治县', '773', ',690,773,780,', '3', '0', 'daozhenlaozumiaozuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('781', '务川仡佬族苗族自治县', '773', ',690,773,781,', '3', '0', 'wuchuanlaozumiaozuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('782', '凤冈县', '773', ',690,773,782,', '3', '0', 'fenggangxian', '0', '0');
INSERT INTO `district` VALUES ('783', '湄潭县', '773', ',690,773,783,', '3', '0', 'tanxian', '0', '0');
INSERT INTO `district` VALUES ('784', '余庆县', '773', ',690,773,784,', '3', '0', 'yuqingxian', '0', '0');
INSERT INTO `district` VALUES ('785', '习水县', '773', ',690,773,785,', '3', '0', 'xishuixian', '0', '0');
INSERT INTO `district` VALUES ('786', '赤水市', '773', ',690,773,786,', '3', '0', 'chishuishi', '0', '0');
INSERT INTO `district` VALUES ('787', '仁怀市', '773', ',690,773,787,', '3', '0', 'renhuaishi', '0', '0');
INSERT INTO `district` VALUES ('788', '海南省', '0', ',788,', '1', '0', 'hainansheng', '0', '0');
INSERT INTO `district` VALUES ('789', '海口市', '788', ',788,789,', '2', '0', 'haikoushi', '0', '0');
INSERT INTO `district` VALUES ('790', '秀英区', '789', ',788,789,790,', '3', '0', 'xiuyingqu', '0', '0');
INSERT INTO `district` VALUES ('791', '龙华区', '789', ',788,789,791,', '3', '0', 'longhuaqu', '0', '0');
INSERT INTO `district` VALUES ('792', '琼山区', '789', ',788,789,792,', '3', '0', 'qiongshanqu', '0', '0');
INSERT INTO `district` VALUES ('793', '美兰区', '789', ',788,789,793,', '3', '0', 'meilanqu', '0', '0');
INSERT INTO `district` VALUES ('794', '白沙黎族自治县', '788', ',788,794,', '2', '0', 'baishalizuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('795', '保亭黎族苗族自治县', '788', ',788,795,', '2', '0', 'baotinglizumiaozuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('796', '昌江黎族自治县', '788', ',788,796,', '2', '0', 'changjianglizuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('797', '澄迈县', '788', ',788,797,', '2', '0', 'chengmaixian', '0', '0');
INSERT INTO `district` VALUES ('798', '儋州市', '788', ',788,798,', '2', '0', 'zhoushi', '0', '0');
INSERT INTO `district` VALUES ('799', '定安县', '788', ',788,799,', '2', '0', 'dinganxian', '0', '0');
INSERT INTO `district` VALUES ('800', '东方市', '788', ',788,800,', '2', '0', 'dongfangshi', '0', '0');
INSERT INTO `district` VALUES ('801', '乐东黎族自治县', '788', ',788,801,', '2', '0', 'ledonglizuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('802', '临高县', '788', ',788,802,', '2', '0', 'lingaoxian', '0', '0');
INSERT INTO `district` VALUES ('803', '陵水黎族自治县', '788', ',788,803,', '2', '0', 'lingshuilizuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('804', '南沙群岛', '788', ',788,804,', '2', '0', 'nanshaqundao', '0', '0');
INSERT INTO `district` VALUES ('805', '琼海市', '788', ',788,805,', '2', '0', 'qionghaishi', '0', '0');
INSERT INTO `district` VALUES ('806', '琼中黎族苗族自治县', '788', ',788,806,', '2', '0', 'qiongzhonglizumiaozuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('807', '三亚市', '788', ',788,807,', '2', '0', 'sanyashi', '0', '0');
INSERT INTO `district` VALUES ('808', '屯昌县', '788', ',788,808,', '2', '0', 'tunchangxian', '0', '0');
INSERT INTO `district` VALUES ('809', '万宁市', '788', ',788,809,', '2', '0', 'wanningshi', '0', '0');
INSERT INTO `district` VALUES ('810', '文昌市', '788', ',788,810,', '2', '0', 'wenchangshi', '0', '0');
INSERT INTO `district` VALUES ('811', '五指山市', '788', ',788,811,', '2', '0', 'wuzhishanshi', '0', '0');
INSERT INTO `district` VALUES ('812', '西沙群岛', '788', ',788,812,', '2', '0', 'xishaqundao', '0', '0');
INSERT INTO `district` VALUES ('813', '中沙群岛的岛礁及其海域', '788', ',788,813,', '2', '0', 'zhongshaqundaodedaojiaojiqihaiyu', '0', '0');
INSERT INTO `district` VALUES ('814', '河北省', '0', ',814,', '1', '0', 'hebeisheng', '0', '0');
INSERT INTO `district` VALUES ('815', '石家庄市', '814', ',814,815,', '2', '0', 'shijiazhuangshi', '0', '0');
INSERT INTO `district` VALUES ('816', '长安区', '815', ',814,815,816,', '3', '0', 'changanqu', '0', '0');
INSERT INTO `district` VALUES ('817', '桥东区', '815', ',814,815,817,', '3', '0', 'qiaodongqu', '0', '0');
INSERT INTO `district` VALUES ('818', '桥西区', '815', ',814,815,818,', '3', '0', 'qiaoxiqu', '0', '0');
INSERT INTO `district` VALUES ('819', '新华区', '815', ',814,815,819,', '3', '0', 'xinhuaqu', '0', '0');
INSERT INTO `district` VALUES ('820', '井陉矿区', '815', ',814,815,820,', '3', '0', 'jingkuangqu', '0', '0');
INSERT INTO `district` VALUES ('821', '裕华区', '815', ',814,815,821,', '3', '0', 'yuhuaqu', '0', '0');
INSERT INTO `district` VALUES ('822', '井陉县', '815', ',814,815,822,', '3', '0', 'jingxian', '0', '0');
INSERT INTO `district` VALUES ('823', '正定县', '815', ',814,815,823,', '3', '0', 'zhengdingxian', '0', '0');
INSERT INTO `district` VALUES ('824', '栾城县', '815', ',814,815,824,', '3', '0', 'chengxian', '0', '0');
INSERT INTO `district` VALUES ('825', '行唐县', '815', ',814,815,825,', '3', '0', 'xingtangxian', '0', '0');
INSERT INTO `district` VALUES ('826', '灵寿县', '815', ',814,815,826,', '3', '0', 'lingshouxian', '0', '0');
INSERT INTO `district` VALUES ('827', '高邑县', '815', ',814,815,827,', '3', '0', 'gaoyixian', '0', '0');
INSERT INTO `district` VALUES ('828', '深泽县', '815', ',814,815,828,', '3', '0', 'shenzexian', '0', '0');
INSERT INTO `district` VALUES ('829', '赞皇县', '815', ',814,815,829,', '3', '0', 'zanhuangxian', '0', '0');
INSERT INTO `district` VALUES ('830', '无极县', '815', ',814,815,830,', '3', '0', 'wujixian', '0', '0');
INSERT INTO `district` VALUES ('831', '平山县', '815', ',814,815,831,', '3', '0', 'pingshanxian', '0', '0');
INSERT INTO `district` VALUES ('832', '元氏县', '815', ',814,815,832,', '3', '0', 'yuanshixian', '0', '0');
INSERT INTO `district` VALUES ('833', '赵县', '815', ',814,815,833,', '3', '0', 'zhaoxian', '0', '0');
INSERT INTO `district` VALUES ('834', '辛集市', '815', ',814,815,834,', '3', '0', 'xinjishi', '0', '0');
INSERT INTO `district` VALUES ('835', '藁城市', '815', ',814,815,835,', '3', '0', 'chengshi', '0', '0');
INSERT INTO `district` VALUES ('836', '晋州市', '815', ',814,815,836,', '3', '0', 'jinzhoushi', '0', '0');
INSERT INTO `district` VALUES ('837', '新乐市', '815', ',814,815,837,', '3', '0', 'xinleshi', '0', '0');
INSERT INTO `district` VALUES ('838', '鹿泉市', '815', ',814,815,838,', '3', '0', 'luquanshi', '0', '0');
INSERT INTO `district` VALUES ('839', '保定市', '814', ',814,839,', '2', '0', 'baodingshi', '0', '0');
INSERT INTO `district` VALUES ('840', '新市区', '839', ',814,839,840,', '3', '0', 'xinshiqu', '0', '0');
INSERT INTO `district` VALUES ('841', '北市区', '839', ',814,839,841,', '3', '0', 'beishiqu', '0', '0');
INSERT INTO `district` VALUES ('842', '南市区', '839', ',814,839,842,', '3', '0', 'nanshiqu', '0', '0');
INSERT INTO `district` VALUES ('843', '满城县', '839', ',814,839,843,', '3', '0', 'manchengxian', '0', '0');
INSERT INTO `district` VALUES ('844', '清苑县', '839', ',814,839,844,', '3', '0', 'qingyuanxian', '0', '0');
INSERT INTO `district` VALUES ('845', '涞水县', '839', ',814,839,845,', '3', '0', 'shuixian', '0', '0');
INSERT INTO `district` VALUES ('846', '阜平县', '839', ',814,839,846,', '3', '0', 'fupingxian', '0', '0');
INSERT INTO `district` VALUES ('847', '徐水县', '839', ',814,839,847,', '3', '0', 'xushuixian', '0', '0');
INSERT INTO `district` VALUES ('848', '定兴县', '839', ',814,839,848,', '3', '0', 'dingxingxian', '0', '0');
INSERT INTO `district` VALUES ('849', '唐县', '839', ',814,839,849,', '3', '0', 'tangxian', '0', '0');
INSERT INTO `district` VALUES ('850', '高阳县', '839', ',814,839,850,', '3', '0', 'gaoyangxian', '0', '0');
INSERT INTO `district` VALUES ('851', '容城县', '839', ',814,839,851,', '3', '0', 'rongchengxian', '0', '0');
INSERT INTO `district` VALUES ('852', '涞源县', '839', ',814,839,852,', '3', '0', 'yuanxian', '0', '0');
INSERT INTO `district` VALUES ('853', '望都县', '839', ',814,839,853,', '3', '0', 'wangduxian', '0', '0');
INSERT INTO `district` VALUES ('854', '安新县', '839', ',814,839,854,', '3', '0', 'anxinxian', '0', '0');
INSERT INTO `district` VALUES ('855', '易县', '839', ',814,839,855,', '3', '0', 'yixian', '0', '0');
INSERT INTO `district` VALUES ('856', '曲阳县', '839', ',814,839,856,', '3', '0', 'quyangxian', '0', '0');
INSERT INTO `district` VALUES ('857', '蠡县', '839', ',814,839,857,', '3', '0', 'xian', '0', '0');
INSERT INTO `district` VALUES ('858', '顺平县', '839', ',814,839,858,', '3', '0', 'shunpingxian', '0', '0');
INSERT INTO `district` VALUES ('859', '博野县', '839', ',814,839,859,', '3', '0', 'boyexian', '0', '0');
INSERT INTO `district` VALUES ('860', '雄县', '839', ',814,839,860,', '3', '0', 'xiongxian', '0', '0');
INSERT INTO `district` VALUES ('861', '涿州市', '839', ',814,839,861,', '3', '0', 'zhoushi', '0', '0');
INSERT INTO `district` VALUES ('862', '定州市', '839', ',814,839,862,', '3', '0', 'dingzhoushi', '0', '0');
INSERT INTO `district` VALUES ('863', '安国市', '839', ',814,839,863,', '3', '0', 'anguoshi', '0', '0');
INSERT INTO `district` VALUES ('864', '高碑店市', '839', ',814,839,864,', '3', '0', 'gaobeidianshi', '0', '0');
INSERT INTO `district` VALUES ('865', '沧州市', '814', ',814,865,', '2', '0', 'cangzhoushi', '0', '0');
INSERT INTO `district` VALUES ('866', '新华区', '865', ',814,865,866,', '3', '0', 'xinhuaqu', '0', '0');
INSERT INTO `district` VALUES ('867', '运河区', '865', ',814,865,867,', '3', '0', 'yunhequ', '0', '0');
INSERT INTO `district` VALUES ('868', '沧县', '865', ',814,865,868,', '3', '0', 'cangxian', '0', '0');
INSERT INTO `district` VALUES ('869', '青县', '865', ',814,865,869,', '3', '0', 'qingxian', '0', '0');
INSERT INTO `district` VALUES ('870', '东光县', '865', ',814,865,870,', '3', '0', 'dongguangxian', '0', '0');
INSERT INTO `district` VALUES ('871', '海兴县', '865', ',814,865,871,', '3', '0', 'haixingxian', '0', '0');
INSERT INTO `district` VALUES ('872', '盐山县', '865', ',814,865,872,', '3', '0', 'yanshanxian', '0', '0');
INSERT INTO `district` VALUES ('873', '肃宁县', '865', ',814,865,873,', '3', '0', 'suningxian', '0', '0');
INSERT INTO `district` VALUES ('874', '南皮县', '865', ',814,865,874,', '3', '0', 'nanpixian', '0', '0');
INSERT INTO `district` VALUES ('875', '吴桥县', '865', ',814,865,875,', '3', '0', 'wuqiaoxian', '0', '0');
INSERT INTO `district` VALUES ('876', '献县', '865', ',814,865,876,', '3', '0', 'xianxian', '0', '0');
INSERT INTO `district` VALUES ('877', '孟村回族自治县', '865', ',814,865,877,', '3', '0', 'mengcunhuizuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('878', '泊头市', '865', ',814,865,878,', '3', '0', 'botoushi', '0', '0');
INSERT INTO `district` VALUES ('879', '任丘市', '865', ',814,865,879,', '3', '0', 'renqiushi', '0', '0');
INSERT INTO `district` VALUES ('880', '黄骅市', '865', ',814,865,880,', '3', '0', 'huangshi', '0', '0');
INSERT INTO `district` VALUES ('881', '河间市', '865', ',814,865,881,', '3', '0', 'hejianshi', '0', '0');
INSERT INTO `district` VALUES ('882', '承德市', '814', ',814,882,', '2', '0', 'chengdeshi', '0', '0');
INSERT INTO `district` VALUES ('883', '双桥区', '882', ',814,882,883,', '3', '0', 'shuangqiaoqu', '0', '0');
INSERT INTO `district` VALUES ('884', '双滦区', '882', ',814,882,884,', '3', '0', 'shuangluanqu', '0', '0');
INSERT INTO `district` VALUES ('885', '鹰手营子矿区', '882', ',814,882,885,', '3', '0', 'yingshouyingzikuangqu', '0', '0');
INSERT INTO `district` VALUES ('886', '承德县', '882', ',814,882,886,', '3', '0', 'chengdexian', '0', '0');
INSERT INTO `district` VALUES ('887', '兴隆县', '882', ',814,882,887,', '3', '0', 'xinglongxian', '0', '0');
INSERT INTO `district` VALUES ('888', '平泉县', '882', ',814,882,888,', '3', '0', 'pingquanxian', '0', '0');
INSERT INTO `district` VALUES ('889', '滦平县', '882', ',814,882,889,', '3', '0', 'luanpingxian', '0', '0');
INSERT INTO `district` VALUES ('890', '隆化县', '882', ',814,882,890,', '3', '0', 'longhuaxian', '0', '0');
INSERT INTO `district` VALUES ('891', '丰宁满族自治县', '882', ',814,882,891,', '3', '0', 'fengningmanzuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('892', '宽城满族自治县', '882', ',814,882,892,', '3', '0', 'kuanchengmanzuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('893', '围场满族蒙古族自治县', '882', ',814,882,893,', '3', '0', 'weichangmanzumengguzuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('894', '邯郸市', '814', ',814,894,', '2', '0', 'handanshi', '0', '0');
INSERT INTO `district` VALUES ('895', '邯山区', '894', ',814,894,895,', '3', '0', 'hanshanqu', '0', '0');
INSERT INTO `district` VALUES ('896', '丛台区', '894', ',814,894,896,', '3', '0', 'congtaiqu', '0', '0');
INSERT INTO `district` VALUES ('897', '复兴区', '894', ',814,894,897,', '3', '0', 'fuxingqu', '0', '0');
INSERT INTO `district` VALUES ('898', '峰峰矿区', '894', ',814,894,898,', '3', '0', 'fengfengkuangqu', '0', '0');
INSERT INTO `district` VALUES ('899', '邯郸县', '894', ',814,894,899,', '3', '0', 'handanxian', '0', '0');
INSERT INTO `district` VALUES ('900', '临漳县', '894', ',814,894,900,', '3', '0', 'linzhangxian', '0', '0');
INSERT INTO `district` VALUES ('901', '成安县', '894', ',814,894,901,', '3', '0', 'chenganxian', '0', '0');
INSERT INTO `district` VALUES ('902', '大名县', '894', ',814,894,902,', '3', '0', 'damingxian', '0', '0');
INSERT INTO `district` VALUES ('903', '涉县', '894', ',814,894,903,', '3', '0', 'shexian', '0', '0');
INSERT INTO `district` VALUES ('904', '磁县', '894', ',814,894,904,', '3', '0', 'cixian', '0', '0');
INSERT INTO `district` VALUES ('905', '肥乡县', '894', ',814,894,905,', '3', '0', 'feixiangxian', '0', '0');
INSERT INTO `district` VALUES ('906', '永年县', '894', ',814,894,906,', '3', '0', 'yongnianxian', '0', '0');
INSERT INTO `district` VALUES ('907', '邱县', '894', ',814,894,907,', '3', '0', 'qiuxian', '0', '0');
INSERT INTO `district` VALUES ('908', '鸡泽县', '894', ',814,894,908,', '3', '0', 'jizexian', '0', '0');
INSERT INTO `district` VALUES ('909', '广平县', '894', ',814,894,909,', '3', '0', 'guangpingxian', '0', '0');
INSERT INTO `district` VALUES ('910', '馆陶县', '894', ',814,894,910,', '3', '0', 'guantaoxian', '0', '0');
INSERT INTO `district` VALUES ('911', '魏县', '894', ',814,894,911,', '3', '0', 'weixian', '0', '0');
INSERT INTO `district` VALUES ('912', '曲周县', '894', ',814,894,912,', '3', '0', 'quzhouxian', '0', '0');
INSERT INTO `district` VALUES ('913', '武安市', '894', ',814,894,913,', '3', '0', 'wuanshi', '0', '0');
INSERT INTO `district` VALUES ('914', '衡水市', '814', ',814,914,', '2', '0', 'hengshuishi', '0', '0');
INSERT INTO `district` VALUES ('915', '桃城区', '914', ',814,914,915,', '3', '0', 'taochengqu', '0', '0');
INSERT INTO `district` VALUES ('916', '枣强县', '914', ',814,914,916,', '3', '0', 'zaoqiangxian', '0', '0');
INSERT INTO `district` VALUES ('917', '武邑县', '914', ',814,914,917,', '3', '0', 'wuyixian', '0', '0');
INSERT INTO `district` VALUES ('918', '武强县', '914', ',814,914,918,', '3', '0', 'wuqiangxian', '0', '0');
INSERT INTO `district` VALUES ('919', '饶阳县', '914', ',814,914,919,', '3', '0', 'raoyangxian', '0', '0');
INSERT INTO `district` VALUES ('920', '安平县', '914', ',814,914,920,', '3', '0', 'anpingxian', '0', '0');
INSERT INTO `district` VALUES ('921', '故城县', '914', ',814,914,921,', '3', '0', 'guchengxian', '0', '0');
INSERT INTO `district` VALUES ('922', '景县', '914', ',814,914,922,', '3', '0', 'jingxian', '0', '0');
INSERT INTO `district` VALUES ('923', '阜城县', '914', ',814,914,923,', '3', '0', 'fuchengxian', '0', '0');
INSERT INTO `district` VALUES ('924', '冀州市', '914', ',814,914,924,', '3', '0', 'jizhoushi', '0', '0');
INSERT INTO `district` VALUES ('925', '深州市', '914', ',814,914,925,', '3', '0', 'shenzhoushi', '0', '0');
INSERT INTO `district` VALUES ('926', '廊坊市', '814', ',814,926,', '2', '0', 'langfangshi', '0', '0');
INSERT INTO `district` VALUES ('927', '安次区', '926', ',814,926,927,', '3', '0', 'anciqu', '0', '0');
INSERT INTO `district` VALUES ('928', '广阳区', '926', ',814,926,928,', '3', '0', 'guangyangqu', '0', '0');
INSERT INTO `district` VALUES ('929', '固安县', '926', ',814,926,929,', '3', '0', 'guanxian', '0', '0');
INSERT INTO `district` VALUES ('930', '永清县', '926', ',814,926,930,', '3', '0', 'yongqingxian', '0', '0');
INSERT INTO `district` VALUES ('931', '香河县', '926', ',814,926,931,', '3', '0', 'xianghexian', '0', '0');
INSERT INTO `district` VALUES ('932', '大城县', '926', ',814,926,932,', '3', '0', 'dachengxian', '0', '0');
INSERT INTO `district` VALUES ('933', '文安县', '926', ',814,926,933,', '3', '0', 'wenanxian', '0', '0');
INSERT INTO `district` VALUES ('934', '大厂回族自治县', '926', ',814,926,934,', '3', '0', 'dachanghuizuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('935', '霸州市', '926', ',814,926,935,', '3', '0', 'bazhoushi', '0', '0');
INSERT INTO `district` VALUES ('936', '三河市', '926', ',814,926,936,', '3', '0', 'sanheshi', '0', '0');
INSERT INTO `district` VALUES ('937', '秦皇岛市', '814', ',814,937,', '2', '0', 'qinhuangdaoshi', '0', '0');
INSERT INTO `district` VALUES ('938', '海港区', '937', ',814,937,938,', '3', '0', 'haigangqu', '0', '0');
INSERT INTO `district` VALUES ('939', '山海关区', '937', ',814,937,939,', '3', '0', 'shanhaiguanqu', '0', '0');
INSERT INTO `district` VALUES ('940', '北戴河区', '937', ',814,937,940,', '3', '0', 'beidaihequ', '0', '0');
INSERT INTO `district` VALUES ('941', '青龙满族自治县', '937', ',814,937,941,', '3', '0', 'qinglongmanzuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('942', '昌黎县', '937', ',814,937,942,', '3', '0', 'changlixian', '0', '0');
INSERT INTO `district` VALUES ('943', '抚宁县', '937', ',814,937,943,', '3', '0', 'funingxian', '0', '0');
INSERT INTO `district` VALUES ('944', '卢龙县', '937', ',814,937,944,', '3', '0', 'lulongxian', '0', '0');
INSERT INTO `district` VALUES ('945', '唐山市', '814', ',814,945,', '2', '0', 'tangshanshi', '0', '0');
INSERT INTO `district` VALUES ('946', '路南区', '945', ',814,945,946,', '3', '0', 'lunanqu', '0', '0');
INSERT INTO `district` VALUES ('947', '路北区', '945', ',814,945,947,', '3', '0', 'lubeiqu', '0', '0');
INSERT INTO `district` VALUES ('948', '古冶区', '945', ',814,945,948,', '3', '0', 'guyequ', '0', '0');
INSERT INTO `district` VALUES ('949', '开平区', '945', ',814,945,949,', '3', '0', 'kaipingqu', '0', '0');
INSERT INTO `district` VALUES ('950', '丰南区', '945', ',814,945,950,', '3', '0', 'fengnanqu', '0', '0');
INSERT INTO `district` VALUES ('951', '丰润区', '945', ',814,945,951,', '3', '0', 'fengrunqu', '0', '0');
INSERT INTO `district` VALUES ('952', '滦县', '945', ',814,945,952,', '3', '0', 'luanxian', '0', '0');
INSERT INTO `district` VALUES ('953', '滦南县', '945', ',814,945,953,', '3', '0', 'luannanxian', '0', '0');
INSERT INTO `district` VALUES ('954', '乐亭县', '945', ',814,945,954,', '3', '0', 'letingxian', '0', '0');
INSERT INTO `district` VALUES ('955', '迁西县', '945', ',814,945,955,', '3', '0', 'qianxixian', '0', '0');
INSERT INTO `district` VALUES ('956', '玉田县', '945', ',814,945,956,', '3', '0', 'yutianxian', '0', '0');
INSERT INTO `district` VALUES ('957', '唐海县', '945', ',814,945,957,', '3', '0', 'tanghaixian', '0', '0');
INSERT INTO `district` VALUES ('958', '遵化市', '945', ',814,945,958,', '3', '0', 'zunhuashi', '0', '0');
INSERT INTO `district` VALUES ('959', '迁安市', '945', ',814,945,959,', '3', '0', 'qiananshi', '0', '0');
INSERT INTO `district` VALUES ('960', '邢台市', '814', ',814,960,', '2', '0', 'xingtaishi', '0', '0');
INSERT INTO `district` VALUES ('961', '桥东区', '960', ',814,960,961,', '3', '0', 'qiaodongqu', '0', '0');
INSERT INTO `district` VALUES ('962', '桥西区', '960', ',814,960,962,', '3', '0', 'qiaoxiqu', '0', '0');
INSERT INTO `district` VALUES ('963', '邢台县', '960', ',814,960,963,', '3', '0', 'xingtaixian', '0', '0');
INSERT INTO `district` VALUES ('964', '临城县', '960', ',814,960,964,', '3', '0', 'linchengxian', '0', '0');
INSERT INTO `district` VALUES ('965', '内丘县', '960', ',814,960,965,', '3', '0', 'neiqiuxian', '0', '0');
INSERT INTO `district` VALUES ('966', '柏乡县', '960', ',814,960,966,', '3', '0', 'baixiangxian', '0', '0');
INSERT INTO `district` VALUES ('967', '隆尧县', '960', ',814,960,967,', '3', '0', 'longyaoxian', '0', '0');
INSERT INTO `district` VALUES ('968', '任县', '960', ',814,960,968,', '3', '0', 'renxian', '0', '0');
INSERT INTO `district` VALUES ('969', '南和县', '960', ',814,960,969,', '3', '0', 'nanhexian', '0', '0');
INSERT INTO `district` VALUES ('970', '宁晋县', '960', ',814,960,970,', '3', '0', 'ningjinxian', '0', '0');
INSERT INTO `district` VALUES ('971', '巨鹿县', '960', ',814,960,971,', '3', '0', 'juluxian', '0', '0');
INSERT INTO `district` VALUES ('972', '新河县', '960', ',814,960,972,', '3', '0', 'xinhexian', '0', '0');
INSERT INTO `district` VALUES ('973', '广宗县', '960', ',814,960,973,', '3', '0', 'guangzongxian', '0', '0');
INSERT INTO `district` VALUES ('974', '平乡县', '960', ',814,960,974,', '3', '0', 'pingxiangxian', '0', '0');
INSERT INTO `district` VALUES ('975', '威县', '960', ',814,960,975,', '3', '0', 'weixian', '0', '0');
INSERT INTO `district` VALUES ('976', '清河县', '960', ',814,960,976,', '3', '0', 'qinghexian', '0', '0');
INSERT INTO `district` VALUES ('977', '临西县', '960', ',814,960,977,', '3', '0', 'linxixian', '0', '0');
INSERT INTO `district` VALUES ('978', '南宫市', '960', ',814,960,978,', '3', '0', 'nangongshi', '0', '0');
INSERT INTO `district` VALUES ('979', '沙河市', '960', ',814,960,979,', '3', '0', 'shaheshi', '0', '0');
INSERT INTO `district` VALUES ('980', '张家口市', '814', ',814,980,', '2', '0', 'zhangjiakoushi', '0', '0');
INSERT INTO `district` VALUES ('981', '桥东区', '980', ',814,980,981,', '3', '0', 'qiaodongqu', '0', '0');
INSERT INTO `district` VALUES ('982', '桥西区', '980', ',814,980,982,', '3', '0', 'qiaoxiqu', '0', '0');
INSERT INTO `district` VALUES ('983', '宣化区', '980', ',814,980,983,', '3', '0', 'xuanhuaqu', '0', '0');
INSERT INTO `district` VALUES ('984', '下花园区', '980', ',814,980,984,', '3', '0', 'xiahuayuanqu', '0', '0');
INSERT INTO `district` VALUES ('985', '宣化县', '980', ',814,980,985,', '3', '0', 'xuanhuaxian', '0', '0');
INSERT INTO `district` VALUES ('986', '张北县', '980', ',814,980,986,', '3', '0', 'zhangbeixian', '0', '0');
INSERT INTO `district` VALUES ('987', '康保县', '980', ',814,980,987,', '3', '0', 'kangbaoxian', '0', '0');
INSERT INTO `district` VALUES ('988', '沽源县', '980', ',814,980,988,', '3', '0', 'guyuanxian', '0', '0');
INSERT INTO `district` VALUES ('989', '尚义县', '980', ',814,980,989,', '3', '0', 'shangyixian', '0', '0');
INSERT INTO `district` VALUES ('990', '蔚县', '980', ',814,980,990,', '3', '0', 'weixian', '0', '0');
INSERT INTO `district` VALUES ('991', '阳原县', '980', ',814,980,991,', '3', '0', 'yangyuanxian', '0', '0');
INSERT INTO `district` VALUES ('992', '怀安县', '980', ',814,980,992,', '3', '0', 'huaianxian', '0', '0');
INSERT INTO `district` VALUES ('993', '万全县', '980', ',814,980,993,', '3', '0', 'wanquanxian', '0', '0');
INSERT INTO `district` VALUES ('994', '怀来县', '980', ',814,980,994,', '3', '0', 'huailaixian', '0', '0');
INSERT INTO `district` VALUES ('995', '涿鹿县', '980', ',814,980,995,', '3', '0', 'luxian', '0', '0');
INSERT INTO `district` VALUES ('996', '赤城县', '980', ',814,980,996,', '3', '0', 'chichengxian', '0', '0');
INSERT INTO `district` VALUES ('997', '崇礼县', '980', ',814,980,997,', '3', '0', 'chonglixian', '0', '0');
INSERT INTO `district` VALUES ('998', '河南省', '0', ',998,', '1', '0', 'henansheng', '0', '0');
INSERT INTO `district` VALUES ('999', '郑州市', '998', ',998,999,', '2', '0', 'zhengzhoushi', '0', '0');
INSERT INTO `district` VALUES ('1000', '中原区', '999', ',998,999,1000,', '3', '0', 'zhongyuanqu', '0', '0');
INSERT INTO `district` VALUES ('1001', '二七区', '999', ',998,999,1001,', '3', '0', 'erqiqu', '0', '0');
INSERT INTO `district` VALUES ('1002', '管城回族区', '999', ',998,999,1002,', '3', '0', 'guanchenghuizuqu', '0', '0');
INSERT INTO `district` VALUES ('1003', '金水区', '999', ',998,999,1003,', '3', '0', 'jinshuiqu', '0', '0');
INSERT INTO `district` VALUES ('1004', '上街区', '999', ',998,999,1004,', '3', '0', 'shangjiequ', '0', '0');
INSERT INTO `district` VALUES ('1005', '邙山区', '999', ',998,999,1005,', '3', '0', 'shanqu', '0', '0');
INSERT INTO `district` VALUES ('1006', '中牟县', '999', ',998,999,1006,', '3', '0', 'zhongmouxian', '0', '0');
INSERT INTO `district` VALUES ('1007', '巩义市', '999', ',998,999,1007,', '3', '0', 'gongyishi', '0', '0');
INSERT INTO `district` VALUES ('1008', '荥阳市', '999', ',998,999,1008,', '3', '0', 'yangshi', '0', '0');
INSERT INTO `district` VALUES ('1009', '新密市', '999', ',998,999,1009,', '3', '0', 'xinmishi', '0', '0');
INSERT INTO `district` VALUES ('1010', '新郑市', '999', ',998,999,1010,', '3', '0', 'xinzhengshi', '0', '0');
INSERT INTO `district` VALUES ('1011', '登封市', '999', ',998,999,1011,', '3', '0', 'dengfengshi', '0', '0');
INSERT INTO `district` VALUES ('1012', '安阳市', '998', ',998,1012,', '2', '0', 'anyangshi', '0', '0');
INSERT INTO `district` VALUES ('1013', '文峰区', '1012', ',998,1012,1013,', '3', '0', 'wenfengqu', '0', '0');
INSERT INTO `district` VALUES ('1014', '北关区', '1012', ',998,1012,1014,', '3', '0', 'beiguanqu', '0', '0');
INSERT INTO `district` VALUES ('1015', '殷都区', '1012', ',998,1012,1015,', '3', '0', 'yinduqu', '0', '0');
INSERT INTO `district` VALUES ('1016', '龙安区', '1012', ',998,1012,1016,', '3', '0', 'longanqu', '0', '0');
INSERT INTO `district` VALUES ('1017', '安阳县', '1012', ',998,1012,1017,', '3', '0', 'anyangxian', '0', '0');
INSERT INTO `district` VALUES ('1018', '汤阴县', '1012', ',998,1012,1018,', '3', '0', 'tangyinxian', '0', '0');
INSERT INTO `district` VALUES ('1019', '滑县', '1012', ',998,1012,1019,', '3', '0', 'huaxian', '0', '0');
INSERT INTO `district` VALUES ('1020', '内黄县', '1012', ',998,1012,1020,', '3', '0', 'neihuangxian', '0', '0');
INSERT INTO `district` VALUES ('1021', '林州市', '1012', ',998,1012,1021,', '3', '0', 'linzhoushi', '0', '0');
INSERT INTO `district` VALUES ('1022', '鹤壁市', '998', ',998,1022,', '2', '0', 'hebishi', '0', '0');
INSERT INTO `district` VALUES ('1023', '鹤山区', '1022', ',998,1022,1023,', '3', '0', 'heshanqu', '0', '0');
INSERT INTO `district` VALUES ('1024', '山城区', '1022', ',998,1022,1024,', '3', '0', 'shanchengqu', '0', '0');
INSERT INTO `district` VALUES ('1025', '淇滨区', '1022', ',998,1022,1025,', '3', '0', 'binqu', '0', '0');
INSERT INTO `district` VALUES ('1026', '浚县', '1022', ',998,1022,1026,', '3', '0', 'junxian', '0', '0');
INSERT INTO `district` VALUES ('1027', '淇县', '1022', ',998,1022,1027,', '3', '0', 'xian', '0', '0');
INSERT INTO `district` VALUES ('1028', '济源市', '998', ',998,1028,', '2', '0', 'jiyuanshi', '0', '0');
INSERT INTO `district` VALUES ('1029', '焦作市', '998', ',998,1029,', '2', '0', 'jiaozuoshi', '0', '0');
INSERT INTO `district` VALUES ('1030', '解放区', '1029', ',998,1029,1030,', '3', '0', 'jiefangqu', '0', '0');
INSERT INTO `district` VALUES ('1031', '中站区', '1029', ',998,1029,1031,', '3', '0', 'zhongzhanqu', '0', '0');
INSERT INTO `district` VALUES ('1032', '马村区', '1029', ',998,1029,1032,', '3', '0', 'macunqu', '0', '0');
INSERT INTO `district` VALUES ('1033', '山阳区', '1029', ',998,1029,1033,', '3', '0', 'shanyangqu', '0', '0');
INSERT INTO `district` VALUES ('1034', '修武县', '1029', ',998,1029,1034,', '3', '0', 'xiuwuxian', '0', '0');
INSERT INTO `district` VALUES ('1035', '博爱县', '1029', ',998,1029,1035,', '3', '0', 'boaixian', '0', '0');
INSERT INTO `district` VALUES ('1036', '武陟县', '1029', ',998,1029,1036,', '3', '0', 'wuxian', '0', '0');
INSERT INTO `district` VALUES ('1037', '温县', '1029', ',998,1029,1037,', '3', '0', 'wenxian', '0', '0');
INSERT INTO `district` VALUES ('1038', '济源市', '1029', ',998,1029,1038,', '3', '0', 'jiyuanshi', '0', '0');
INSERT INTO `district` VALUES ('1039', '沁阳市', '1029', ',998,1029,1039,', '3', '0', 'qinyangshi', '0', '0');
INSERT INTO `district` VALUES ('1040', '孟州市', '1029', ',998,1029,1040,', '3', '0', 'mengzhoushi', '0', '0');
INSERT INTO `district` VALUES ('1041', '开封市', '998', ',998,1041,', '2', '0', 'kaifengshi', '0', '0');
INSERT INTO `district` VALUES ('1042', '龙亭区', '1041', ',998,1041,1042,', '3', '0', 'longtingqu', '0', '0');
INSERT INTO `district` VALUES ('1043', '顺河回族区', '1041', ',998,1041,1043,', '3', '0', 'shunhehuizuqu', '0', '0');
INSERT INTO `district` VALUES ('1044', '鼓楼区', '1041', ',998,1041,1044,', '3', '0', 'gulouqu', '0', '0');
INSERT INTO `district` VALUES ('1045', '南关区', '1041', ',998,1041,1045,', '3', '0', 'nanguanqu', '0', '0');
INSERT INTO `district` VALUES ('1046', '郊区', '1041', ',998,1041,1046,', '3', '0', 'jiaoqu', '0', '0');
INSERT INTO `district` VALUES ('1047', '杞县', '1041', ',998,1041,1047,', '3', '0', 'xian', '0', '0');
INSERT INTO `district` VALUES ('1048', '通许县', '1041', ',998,1041,1048,', '3', '0', 'tongxuxian', '0', '0');
INSERT INTO `district` VALUES ('1049', '尉氏县', '1041', ',998,1041,1049,', '3', '0', 'weishixian', '0', '0');
INSERT INTO `district` VALUES ('1050', '开封县', '1041', ',998,1041,1050,', '3', '0', 'kaifengxian', '0', '0');
INSERT INTO `district` VALUES ('1051', '兰考县', '1041', ',998,1041,1051,', '3', '0', 'lankaoxian', '0', '0');
INSERT INTO `district` VALUES ('1052', '洛阳市', '998', ',998,1052,', '2', '0', 'luoyangshi', '0', '0');
INSERT INTO `district` VALUES ('1053', '老城区', '1052', ',998,1052,1053,', '3', '0', 'laochengqu', '0', '0');
INSERT INTO `district` VALUES ('1054', '西工区', '1052', ',998,1052,1054,', '3', '0', 'xigongqu', '0', '0');
INSERT INTO `district` VALUES ('1055', '廛河回族区', '1052', ',998,1052,1055,', '3', '0', 'hehuizuqu', '0', '0');
INSERT INTO `district` VALUES ('1056', '涧西区', '1052', ',998,1052,1056,', '3', '0', 'jianxiqu', '0', '0');
INSERT INTO `district` VALUES ('1057', '吉利区', '1052', ',998,1052,1057,', '3', '0', 'jiliqu', '0', '0');
INSERT INTO `district` VALUES ('1058', '洛龙区', '1052', ',998,1052,1058,', '3', '0', 'luolongqu', '0', '0');
INSERT INTO `district` VALUES ('1059', '孟津县', '1052', ',998,1052,1059,', '3', '0', 'mengjinxian', '0', '0');
INSERT INTO `district` VALUES ('1060', '新安县', '1052', ',998,1052,1060,', '3', '0', 'xinanxian', '0', '0');
INSERT INTO `district` VALUES ('1061', '栾川县', '1052', ',998,1052,1061,', '3', '0', 'chuanxian', '0', '0');
INSERT INTO `district` VALUES ('1062', '嵩县', '1052', ',998,1052,1062,', '3', '0', 'xian', '0', '0');
INSERT INTO `district` VALUES ('1063', '汝阳县', '1052', ',998,1052,1063,', '3', '0', 'ruyangxian', '0', '0');
INSERT INTO `district` VALUES ('1064', '宜阳县', '1052', ',998,1052,1064,', '3', '0', 'yiyangxian', '0', '0');
INSERT INTO `district` VALUES ('1065', '洛宁县', '1052', ',998,1052,1065,', '3', '0', 'luoningxian', '0', '0');
INSERT INTO `district` VALUES ('1066', '伊川县', '1052', ',998,1052,1066,', '3', '0', 'yichuanxian', '0', '0');
INSERT INTO `district` VALUES ('1067', '偃师市', '1052', ',998,1052,1067,', '3', '0', 'shishi', '0', '0');
INSERT INTO `district` VALUES ('1068', '漯河市', '998', ',998,1068,', '2', '0', 'heshi', '0', '0');
INSERT INTO `district` VALUES ('1069', '源汇区', '1068', ',998,1068,1069,', '3', '0', 'yuanhuiqu', '0', '0');
INSERT INTO `district` VALUES ('1070', '郾城区', '1068', ',998,1068,1070,', '3', '0', 'chengqu', '0', '0');
INSERT INTO `district` VALUES ('1071', '召陵区', '1068', ',998,1068,1071,', '3', '0', 'zhaolingqu', '0', '0');
INSERT INTO `district` VALUES ('1072', '舞阳县', '1068', ',998,1068,1072,', '3', '0', 'wuyangxian', '0', '0');
INSERT INTO `district` VALUES ('1073', '临颍县', '1068', ',998,1068,1073,', '3', '0', 'linxian', '0', '0');
INSERT INTO `district` VALUES ('1074', '南阳市', '998', ',998,1074,', '2', '0', 'nanyangshi', '0', '0');
INSERT INTO `district` VALUES ('1075', '宛城区', '1074', ',998,1074,1075,', '3', '0', 'wanchengqu', '0', '0');
INSERT INTO `district` VALUES ('1076', '卧龙区', '1074', ',998,1074,1076,', '3', '0', 'wolongqu', '0', '0');
INSERT INTO `district` VALUES ('1077', '南召县', '1074', ',998,1074,1077,', '3', '0', 'nanzhaoxian', '0', '0');
INSERT INTO `district` VALUES ('1078', '方城县', '1074', ',998,1074,1078,', '3', '0', 'fangchengxian', '0', '0');
INSERT INTO `district` VALUES ('1079', '西峡县', '1074', ',998,1074,1079,', '3', '0', 'xixiaxian', '0', '0');
INSERT INTO `district` VALUES ('1080', '镇平县', '1074', ',998,1074,1080,', '3', '0', 'zhenpingxian', '0', '0');
INSERT INTO `district` VALUES ('1081', '内乡县', '1074', ',998,1074,1081,', '3', '0', 'neixiangxian', '0', '0');
INSERT INTO `district` VALUES ('1082', '淅川县', '1074', ',998,1074,1082,', '3', '0', 'chuanxian', '0', '0');
INSERT INTO `district` VALUES ('1083', '社旗县', '1074', ',998,1074,1083,', '3', '0', 'sheqixian', '0', '0');
INSERT INTO `district` VALUES ('1084', '唐河县', '1074', ',998,1074,1084,', '3', '0', 'tanghexian', '0', '0');
INSERT INTO `district` VALUES ('1085', '新野县', '1074', ',998,1074,1085,', '3', '0', 'xinyexian', '0', '0');
INSERT INTO `district` VALUES ('1086', '桐柏县', '1074', ',998,1074,1086,', '3', '0', 'tongbaixian', '0', '0');
INSERT INTO `district` VALUES ('1087', '邓州市', '1074', ',998,1074,1087,', '3', '0', 'dengzhoushi', '0', '0');
INSERT INTO `district` VALUES ('1088', '平顶山市', '998', ',998,1088,', '2', '0', 'pingdingshanshi', '0', '0');
INSERT INTO `district` VALUES ('1089', '新华区', '1088', ',998,1088,1089,', '3', '0', 'xinhuaqu', '0', '0');
INSERT INTO `district` VALUES ('1090', '卫东区', '1088', ',998,1088,1090,', '3', '0', 'weidongqu', '0', '0');
INSERT INTO `district` VALUES ('1091', '石龙区', '1088', ',998,1088,1091,', '3', '0', 'shilongqu', '0', '0');
INSERT INTO `district` VALUES ('1092', '湛河区', '1088', ',998,1088,1092,', '3', '0', 'zhanhequ', '0', '0');
INSERT INTO `district` VALUES ('1093', '宝丰县', '1088', ',998,1088,1093,', '3', '0', 'baofengxian', '0', '0');
INSERT INTO `district` VALUES ('1094', '叶县', '1088', ',998,1088,1094,', '3', '0', 'yexian', '0', '0');
INSERT INTO `district` VALUES ('1095', '鲁山县', '1088', ',998,1088,1095,', '3', '0', 'lushanxian', '0', '0');
INSERT INTO `district` VALUES ('1096', '郏县', '1088', ',998,1088,1096,', '3', '0', 'xian', '0', '0');
INSERT INTO `district` VALUES ('1097', '舞钢市', '1088', ',998,1088,1097,', '3', '0', 'wugangshi', '0', '0');
INSERT INTO `district` VALUES ('1098', '汝州市', '1088', ',998,1088,1098,', '3', '0', 'ruzhoushi', '0', '0');
INSERT INTO `district` VALUES ('1099', '濮阳市', '998', ',998,1099,', '2', '0', 'yangshi', '0', '0');
INSERT INTO `district` VALUES ('1100', '华龙区', '1099', ',998,1099,1100,', '3', '0', 'hualongqu', '0', '0');
INSERT INTO `district` VALUES ('1101', '清丰县', '1099', ',998,1099,1101,', '3', '0', 'qingfengxian', '0', '0');
INSERT INTO `district` VALUES ('1102', '南乐县', '1099', ',998,1099,1102,', '3', '0', 'nanlexian', '0', '0');
INSERT INTO `district` VALUES ('1103', '范县', '1099', ',998,1099,1103,', '3', '0', 'fanxian', '0', '0');
INSERT INTO `district` VALUES ('1104', '台前县', '1099', ',998,1099,1104,', '3', '0', 'taiqianxian', '0', '0');
INSERT INTO `district` VALUES ('1105', '濮阳县', '1099', ',998,1099,1105,', '3', '0', 'yangxian', '0', '0');
INSERT INTO `district` VALUES ('1106', '三门峡市', '998', ',998,1106,', '2', '0', 'sanmenxiashi', '0', '0');
INSERT INTO `district` VALUES ('1107', '湖滨区', '1106', ',998,1106,1107,', '3', '0', 'hubinqu', '0', '0');
INSERT INTO `district` VALUES ('1108', '渑池县', '1106', ',998,1106,1108,', '3', '0', 'chixian', '0', '0');
INSERT INTO `district` VALUES ('1109', '陕县', '1106', ',998,1106,1109,', '3', '0', 'shanxian', '0', '0');
INSERT INTO `district` VALUES ('1110', '卢氏县', '1106', ',998,1106,1110,', '3', '0', 'lushixian', '0', '0');
INSERT INTO `district` VALUES ('1111', '义马市', '1106', ',998,1106,1111,', '3', '0', 'yimashi', '0', '0');
INSERT INTO `district` VALUES ('1112', '灵宝市', '1106', ',998,1106,1112,', '3', '0', 'lingbaoshi', '0', '0');
INSERT INTO `district` VALUES ('1113', '商丘市', '998', ',998,1113,', '2', '0', 'shangqiushi', '0', '0');
INSERT INTO `district` VALUES ('1114', '梁园区', '1113', ',998,1113,1114,', '3', '0', 'liangyuanqu', '0', '0');
INSERT INTO `district` VALUES ('1115', '睢阳区', '1113', ',998,1113,1115,', '3', '0', 'yangqu', '0', '0');
INSERT INTO `district` VALUES ('1116', '民权县', '1113', ',998,1113,1116,', '3', '0', 'minquanxian', '0', '0');
INSERT INTO `district` VALUES ('1117', '睢县', '1113', ',998,1113,1117,', '3', '0', 'xian', '0', '0');
INSERT INTO `district` VALUES ('1118', '宁陵县', '1113', ',998,1113,1118,', '3', '0', 'ninglingxian', '0', '0');
INSERT INTO `district` VALUES ('1119', '柘城县', '1113', ',998,1113,1119,', '3', '0', 'chengxian', '0', '0');
INSERT INTO `district` VALUES ('1120', '虞城县', '1113', ',998,1113,1120,', '3', '0', 'yuchengxian', '0', '0');
INSERT INTO `district` VALUES ('1121', '夏邑县', '1113', ',998,1113,1121,', '3', '0', 'xiayixian', '0', '0');
INSERT INTO `district` VALUES ('1122', '永城市', '1113', ',998,1113,1122,', '3', '0', 'yongchengshi', '0', '0');
INSERT INTO `district` VALUES ('1123', '新乡市', '998', ',998,1123,', '2', '0', 'xinxiangshi', '0', '0');
INSERT INTO `district` VALUES ('1124', '红旗区', '1123', ',998,1123,1124,', '3', '0', 'hongqiqu', '0', '0');
INSERT INTO `district` VALUES ('1125', '卫滨区', '1123', ',998,1123,1125,', '3', '0', 'weibinqu', '0', '0');
INSERT INTO `district` VALUES ('1126', '凤泉区', '1123', ',998,1123,1126,', '3', '0', 'fengquanqu', '0', '0');
INSERT INTO `district` VALUES ('1127', '牧野区', '1123', ',998,1123,1127,', '3', '0', 'muyequ', '0', '0');
INSERT INTO `district` VALUES ('1128', '新乡县', '1123', ',998,1123,1128,', '3', '0', 'xinxiangxian', '0', '0');
INSERT INTO `district` VALUES ('1129', '获嘉县', '1123', ',998,1123,1129,', '3', '0', 'huojiaxian', '0', '0');
INSERT INTO `district` VALUES ('1130', '原阳县', '1123', ',998,1123,1130,', '3', '0', 'yuanyangxian', '0', '0');
INSERT INTO `district` VALUES ('1131', '延津县', '1123', ',998,1123,1131,', '3', '0', 'yanjinxian', '0', '0');
INSERT INTO `district` VALUES ('1132', '封丘县', '1123', ',998,1123,1132,', '3', '0', 'fengqiuxian', '0', '0');
INSERT INTO `district` VALUES ('1133', '长垣县', '1123', ',998,1123,1133,', '3', '0', 'changyuanxian', '0', '0');
INSERT INTO `district` VALUES ('1134', '卫辉市', '1123', ',998,1123,1134,', '3', '0', 'weihuishi', '0', '0');
INSERT INTO `district` VALUES ('1135', '辉县市', '1123', ',998,1123,1135,', '3', '0', 'huixianshi', '0', '0');
INSERT INTO `district` VALUES ('1136', '信阳市', '998', ',998,1136,', '2', '0', 'xinyangshi', '0', '0');
INSERT INTO `district` VALUES ('1137', '师河区', '1136', ',998,1136,1137,', '3', '0', 'shihequ', '0', '0');
INSERT INTO `district` VALUES ('1138', '平桥区', '1136', ',998,1136,1138,', '3', '0', 'pingqiaoqu', '0', '0');
INSERT INTO `district` VALUES ('1139', '罗山县', '1136', ',998,1136,1139,', '3', '0', 'luoshanxian', '0', '0');
INSERT INTO `district` VALUES ('1140', '光山县', '1136', ',998,1136,1140,', '3', '0', 'guangshanxian', '0', '0');
INSERT INTO `district` VALUES ('1141', '新县', '1136', ',998,1136,1141,', '3', '0', 'xinxian', '0', '0');
INSERT INTO `district` VALUES ('1142', '商城县', '1136', ',998,1136,1142,', '3', '0', 'shangchengxian', '0', '0');
INSERT INTO `district` VALUES ('1143', '固始县', '1136', ',998,1136,1143,', '3', '0', 'gushixian', '0', '0');
INSERT INTO `district` VALUES ('1144', '潢川县', '1136', ',998,1136,1144,', '3', '0', 'chuanxian', '0', '0');
INSERT INTO `district` VALUES ('1145', '淮滨县', '1136', ',998,1136,1145,', '3', '0', 'huaibinxian', '0', '0');
INSERT INTO `district` VALUES ('1146', '息县', '1136', ',998,1136,1146,', '3', '0', 'xixian', '0', '0');
INSERT INTO `district` VALUES ('1147', '许昌市', '998', ',998,1147,', '2', '0', 'xuchangshi', '0', '0');
INSERT INTO `district` VALUES ('1148', '魏都区', '1147', ',998,1147,1148,', '3', '0', 'weiduqu', '0', '0');
INSERT INTO `district` VALUES ('1149', '许昌县', '1147', ',998,1147,1149,', '3', '0', 'xuchangxian', '0', '0');
INSERT INTO `district` VALUES ('1150', '鄢陵县', '1147', ',998,1147,1150,', '3', '0', 'lingxian', '0', '0');
INSERT INTO `district` VALUES ('1151', '襄城县', '1147', ',998,1147,1151,', '3', '0', 'xiangchengxian', '0', '0');
INSERT INTO `district` VALUES ('1152', '禹州市', '1147', ',998,1147,1152,', '3', '0', 'yuzhoushi', '0', '0');
INSERT INTO `district` VALUES ('1153', '长葛市', '1147', ',998,1147,1153,', '3', '0', 'changgeshi', '0', '0');
INSERT INTO `district` VALUES ('1154', '周口市', '998', ',998,1154,', '2', '0', 'zhoukoushi', '0', '0');
INSERT INTO `district` VALUES ('1155', '川汇区', '1154', ',998,1154,1155,', '3', '0', 'chuanhuiqu', '0', '0');
INSERT INTO `district` VALUES ('1156', '扶沟县', '1154', ',998,1154,1156,', '3', '0', 'fugouxian', '0', '0');
INSERT INTO `district` VALUES ('1157', '西华县', '1154', ',998,1154,1157,', '3', '0', 'xihuaxian', '0', '0');
INSERT INTO `district` VALUES ('1158', '商水县', '1154', ',998,1154,1158,', '3', '0', 'shangshuixian', '0', '0');
INSERT INTO `district` VALUES ('1159', '沈丘县', '1154', ',998,1154,1159,', '3', '0', 'shenqiuxian', '0', '0');
INSERT INTO `district` VALUES ('1160', '郸城县', '1154', ',998,1154,1160,', '3', '0', 'danchengxian', '0', '0');
INSERT INTO `district` VALUES ('1161', '淮阳县', '1154', ',998,1154,1161,', '3', '0', 'huaiyangxian', '0', '0');
INSERT INTO `district` VALUES ('1162', '太康县', '1154', ',998,1154,1162,', '3', '0', 'taikangxian', '0', '0');
INSERT INTO `district` VALUES ('1163', '鹿邑县', '1154', ',998,1154,1163,', '3', '0', 'luyixian', '0', '0');
INSERT INTO `district` VALUES ('1164', '项城市', '1154', ',998,1154,1164,', '3', '0', 'xiangchengshi', '0', '0');
INSERT INTO `district` VALUES ('1165', '驻马店市', '998', ',998,1165,', '2', '0', 'zhumadianshi', '0', '0');
INSERT INTO `district` VALUES ('1166', '驿城区', '1165', ',998,1165,1166,', '3', '0', 'chengqu', '0', '0');
INSERT INTO `district` VALUES ('1167', '西平县', '1165', ',998,1165,1167,', '3', '0', 'xipingxian', '0', '0');
INSERT INTO `district` VALUES ('1168', '上蔡县', '1165', ',998,1165,1168,', '3', '0', 'shangcaixian', '0', '0');
INSERT INTO `district` VALUES ('1169', '平舆县', '1165', ',998,1165,1169,', '3', '0', 'pingyuxian', '0', '0');
INSERT INTO `district` VALUES ('1170', '正阳县', '1165', ',998,1165,1170,', '3', '0', 'zhengyangxian', '0', '0');
INSERT INTO `district` VALUES ('1171', '确山县', '1165', ',998,1165,1171,', '3', '0', 'queshanxian', '0', '0');
INSERT INTO `district` VALUES ('1172', '泌阳县', '1165', ',998,1165,1172,', '3', '0', 'miyangxian', '0', '0');
INSERT INTO `district` VALUES ('1173', '汝南县', '1165', ',998,1165,1173,', '3', '0', 'runanxian', '0', '0');
INSERT INTO `district` VALUES ('1174', '遂平县', '1165', ',998,1165,1174,', '3', '0', 'suipingxian', '0', '0');
INSERT INTO `district` VALUES ('1175', '新蔡县', '1165', ',998,1165,1175,', '3', '0', 'xincaixian', '0', '0');
INSERT INTO `district` VALUES ('1176', '黑龙江省', '0', ',1176,', '1', '0', 'heilongjiangsheng', '0', '0');
INSERT INTO `district` VALUES ('1177', '哈尔滨市', '1176', ',1176,1177,', '2', '0', 'haerbinshi', '0', '0');
INSERT INTO `district` VALUES ('1178', '道里区', '1177', ',1176,1177,1178,', '3', '0', 'daoliqu', '0', '0');
INSERT INTO `district` VALUES ('1179', '南岗区', '1177', ',1176,1177,1179,', '3', '0', 'nangangqu', '0', '0');
INSERT INTO `district` VALUES ('1180', '道外区', '1177', ',1176,1177,1180,', '3', '0', 'daowaiqu', '0', '0');
INSERT INTO `district` VALUES ('1181', '香坊区', '1177', ',1176,1177,1181,', '3', '0', 'xiangfangqu', '0', '0');
INSERT INTO `district` VALUES ('1182', '动力区', '1177', ',1176,1177,1182,', '3', '0', 'dongliqu', '0', '0');
INSERT INTO `district` VALUES ('1183', '平房区', '1177', ',1176,1177,1183,', '3', '0', 'pingfangqu', '0', '0');
INSERT INTO `district` VALUES ('1184', '松北区', '1177', ',1176,1177,1184,', '3', '0', 'songbeiqu', '0', '0');
INSERT INTO `district` VALUES ('1185', '呼兰区', '1177', ',1176,1177,1185,', '3', '0', 'hulanqu', '0', '0');
INSERT INTO `district` VALUES ('1186', '依兰县', '1177', ',1176,1177,1186,', '3', '0', 'yilanxian', '0', '0');
INSERT INTO `district` VALUES ('1187', '方正县', '1177', ',1176,1177,1187,', '3', '0', 'fangzhengxian', '0', '0');
INSERT INTO `district` VALUES ('1188', '宾县', '1177', ',1176,1177,1188,', '3', '0', 'binxian', '0', '0');
INSERT INTO `district` VALUES ('1189', '巴彦县', '1177', ',1176,1177,1189,', '3', '0', 'bayanxian', '0', '0');
INSERT INTO `district` VALUES ('1190', '木兰县', '1177', ',1176,1177,1190,', '3', '0', 'mulanxian', '0', '0');
INSERT INTO `district` VALUES ('1191', '通河县', '1177', ',1176,1177,1191,', '3', '0', 'tonghexian', '0', '0');
INSERT INTO `district` VALUES ('1192', '延寿县', '1177', ',1176,1177,1192,', '3', '0', 'yanshouxian', '0', '0');
INSERT INTO `district` VALUES ('1193', '阿城市', '1177', ',1176,1177,1193,', '3', '0', 'achengshi', '0', '0');
INSERT INTO `district` VALUES ('1194', '双城市', '1177', ',1176,1177,1194,', '3', '0', 'shuangchengshi', '0', '0');
INSERT INTO `district` VALUES ('1195', '尚志市', '1177', ',1176,1177,1195,', '3', '0', 'shangzhishi', '0', '0');
INSERT INTO `district` VALUES ('1196', '五常市', '1177', ',1176,1177,1196,', '3', '0', 'wuchangshi', '0', '0');
INSERT INTO `district` VALUES ('1197', '大庆市', '1176', ',1176,1197,', '2', '0', 'daqingshi', '0', '0');
INSERT INTO `district` VALUES ('1198', '萨尔图区', '1197', ',1176,1197,1198,', '3', '0', 'saertuqu', '0', '0');
INSERT INTO `district` VALUES ('1199', '龙凤区', '1197', ',1176,1197,1199,', '3', '0', 'longfengqu', '0', '0');
INSERT INTO `district` VALUES ('1200', '让胡路区', '1197', ',1176,1197,1200,', '3', '0', 'ranghuluqu', '0', '0');
INSERT INTO `district` VALUES ('1201', '红岗区', '1197', ',1176,1197,1201,', '3', '0', 'honggangqu', '0', '0');
INSERT INTO `district` VALUES ('1202', '大同区', '1197', ',1176,1197,1202,', '3', '0', 'datongqu', '0', '0');
INSERT INTO `district` VALUES ('1203', '肇州县', '1197', ',1176,1197,1203,', '3', '0', 'zhaozhouxian', '0', '0');
INSERT INTO `district` VALUES ('1204', '肇源县', '1197', ',1176,1197,1204,', '3', '0', 'zhaoyuanxian', '0', '0');
INSERT INTO `district` VALUES ('1205', '林甸县', '1197', ',1176,1197,1205,', '3', '0', 'lindianxian', '0', '0');
INSERT INTO `district` VALUES ('1206', '杜尔伯特蒙古族自治县', '1197', ',1176,1197,1206,', '3', '0', 'duerbotemengguzuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('1207', '大兴安岭地区', '1176', ',1176,1207,', '2', '0', 'daxinganlingdiqu', '0', '0');
INSERT INTO `district` VALUES ('1208', '呼玛县', '1207', ',1176,1207,1208,', '3', '0', 'humaxian', '0', '0');
INSERT INTO `district` VALUES ('1209', '塔河县', '1207', ',1176,1207,1209,', '3', '0', 'tahexian', '0', '0');
INSERT INTO `district` VALUES ('1210', '漠河县', '1207', ',1176,1207,1210,', '3', '0', 'mohexian', '0', '0');
INSERT INTO `district` VALUES ('1211', '鹤岗市', '1176', ',1176,1211,', '2', '0', 'hegangshi', '0', '0');
INSERT INTO `district` VALUES ('1212', '向阳区', '1211', ',1176,1211,1212,', '3', '0', 'xiangyangqu', '0', '0');
INSERT INTO `district` VALUES ('1213', '工农区', '1211', ',1176,1211,1213,', '3', '0', 'gongnongqu', '0', '0');
INSERT INTO `district` VALUES ('1214', '南山区', '1211', ',1176,1211,1214,', '3', '0', 'nanshanqu', '0', '0');
INSERT INTO `district` VALUES ('1215', '兴安区', '1211', ',1176,1211,1215,', '3', '0', 'xinganqu', '0', '0');
INSERT INTO `district` VALUES ('1216', '东山区', '1211', ',1176,1211,1216,', '3', '0', 'dongshanqu', '0', '0');
INSERT INTO `district` VALUES ('1217', '兴山区', '1211', ',1176,1211,1217,', '3', '0', 'xingshanqu', '0', '0');
INSERT INTO `district` VALUES ('1218', '萝北县', '1211', ',1176,1211,1218,', '3', '0', 'luobeixian', '0', '0');
INSERT INTO `district` VALUES ('1219', '绥滨县', '1211', ',1176,1211,1219,', '3', '0', 'suibinxian', '0', '0');
INSERT INTO `district` VALUES ('1220', '黑河市', '1176', ',1176,1220,', '2', '0', 'heiheshi', '0', '0');
INSERT INTO `district` VALUES ('1221', '爱辉区', '1220', ',1176,1220,1221,', '3', '0', 'aihuiqu', '0', '0');
INSERT INTO `district` VALUES ('1222', '嫩江县', '1220', ',1176,1220,1222,', '3', '0', 'nenjiangxian', '0', '0');
INSERT INTO `district` VALUES ('1223', '逊克县', '1220', ',1176,1220,1223,', '3', '0', 'xunkexian', '0', '0');
INSERT INTO `district` VALUES ('1224', '孙吴县', '1220', ',1176,1220,1224,', '3', '0', 'sunwuxian', '0', '0');
INSERT INTO `district` VALUES ('1225', '北安市', '1220', ',1176,1220,1225,', '3', '0', 'beianshi', '0', '0');
INSERT INTO `district` VALUES ('1226', '五大连池市', '1220', ',1176,1220,1226,', '3', '0', 'wudalianchishi', '0', '0');
INSERT INTO `district` VALUES ('1227', '鸡西市', '1176', ',1176,1227,', '2', '0', 'jixishi', '0', '0');
INSERT INTO `district` VALUES ('1228', '鸡冠区', '1227', ',1176,1227,1228,', '3', '0', 'jiguanqu', '0', '0');
INSERT INTO `district` VALUES ('1229', '恒山区', '1227', ',1176,1227,1229,', '3', '0', 'hengshanqu', '0', '0');
INSERT INTO `district` VALUES ('1230', '滴道区', '1227', ',1176,1227,1230,', '3', '0', 'didaoqu', '0', '0');
INSERT INTO `district` VALUES ('1231', '梨树区', '1227', ',1176,1227,1231,', '3', '0', 'lishuqu', '0', '0');
INSERT INTO `district` VALUES ('1232', '城子河区', '1227', ',1176,1227,1232,', '3', '0', 'chengzihequ', '0', '0');
INSERT INTO `district` VALUES ('1233', '麻山区', '1227', ',1176,1227,1233,', '3', '0', 'mashanqu', '0', '0');
INSERT INTO `district` VALUES ('1234', '鸡东县', '1227', ',1176,1227,1234,', '3', '0', 'jidongxian', '0', '0');
INSERT INTO `district` VALUES ('1235', '虎林市', '1227', ',1176,1227,1235,', '3', '0', 'hulinshi', '0', '0');
INSERT INTO `district` VALUES ('1236', '密山市', '1227', ',1176,1227,1236,', '3', '0', 'mishanshi', '0', '0');
INSERT INTO `district` VALUES ('1237', '佳木斯市', '1176', ',1176,1237,', '2', '0', 'jiamusishi', '0', '0');
INSERT INTO `district` VALUES ('1238', '永红区', '1237', ',1176,1237,1238,', '3', '0', 'yonghongqu', '0', '0');
INSERT INTO `district` VALUES ('1239', '向阳区', '1237', ',1176,1237,1239,', '3', '0', 'xiangyangqu', '0', '0');
INSERT INTO `district` VALUES ('1240', '前进区', '1237', ',1176,1237,1240,', '3', '0', 'qianjinqu', '0', '0');
INSERT INTO `district` VALUES ('1241', '东风区', '1237', ',1176,1237,1241,', '3', '0', 'dongfengqu', '0', '0');
INSERT INTO `district` VALUES ('1242', '郊区', '1237', ',1176,1237,1242,', '3', '0', 'jiaoqu', '0', '0');
INSERT INTO `district` VALUES ('1243', '桦南县', '1237', ',1176,1237,1243,', '3', '0', 'nanxian', '0', '0');
INSERT INTO `district` VALUES ('1244', '桦川县', '1237', ',1176,1237,1244,', '3', '0', 'chuanxian', '0', '0');
INSERT INTO `district` VALUES ('1245', '汤原县', '1237', ',1176,1237,1245,', '3', '0', 'tangyuanxian', '0', '0');
INSERT INTO `district` VALUES ('1246', '抚远县', '1237', ',1176,1237,1246,', '3', '0', 'fuyuanxian', '0', '0');
INSERT INTO `district` VALUES ('1247', '同江市', '1237', ',1176,1237,1247,', '3', '0', 'tongjiangshi', '0', '0');
INSERT INTO `district` VALUES ('1248', '富锦市', '1237', ',1176,1237,1248,', '3', '0', 'fujinshi', '0', '0');
INSERT INTO `district` VALUES ('1249', '牡丹江市', '1176', ',1176,1249,', '2', '0', 'mudanjiangshi', '0', '0');
INSERT INTO `district` VALUES ('1250', '东安区', '1249', ',1176,1249,1250,', '3', '0', 'donganqu', '0', '0');
INSERT INTO `district` VALUES ('1251', '阳明区', '1249', ',1176,1249,1251,', '3', '0', 'yangmingqu', '0', '0');
INSERT INTO `district` VALUES ('1252', '爱民区', '1249', ',1176,1249,1252,', '3', '0', 'aiminqu', '0', '0');
INSERT INTO `district` VALUES ('1253', '西安区', '1249', ',1176,1249,1253,', '3', '0', 'xianqu', '0', '0');
INSERT INTO `district` VALUES ('1254', '东宁县', '1249', ',1176,1249,1254,', '3', '0', 'dongningxian', '0', '0');
INSERT INTO `district` VALUES ('1255', '林口县', '1249', ',1176,1249,1255,', '3', '0', 'linkouxian', '0', '0');
INSERT INTO `district` VALUES ('1256', '绥芬河市', '1249', ',1176,1249,1256,', '3', '0', 'suifenheshi', '0', '0');
INSERT INTO `district` VALUES ('1257', '海林市', '1249', ',1176,1249,1257,', '3', '0', 'hailinshi', '0', '0');
INSERT INTO `district` VALUES ('1258', '宁安市', '1249', ',1176,1249,1258,', '3', '0', 'ninganshi', '0', '0');
INSERT INTO `district` VALUES ('1259', '穆棱市', '1249', ',1176,1249,1259,', '3', '0', 'mulengshi', '0', '0');
INSERT INTO `district` VALUES ('1260', '七台河市', '1176', ',1176,1260,', '2', '0', 'qitaiheshi', '0', '0');
INSERT INTO `district` VALUES ('1261', '新兴区', '1260', ',1176,1260,1261,', '3', '0', 'xinxingqu', '0', '0');
INSERT INTO `district` VALUES ('1262', '桃山区', '1260', ',1176,1260,1262,', '3', '0', 'taoshanqu', '0', '0');
INSERT INTO `district` VALUES ('1263', '茄子河区', '1260', ',1176,1260,1263,', '3', '0', 'qiezihequ', '0', '0');
INSERT INTO `district` VALUES ('1264', '勃利县', '1260', ',1176,1260,1264,', '3', '0', 'bolixian', '0', '0');
INSERT INTO `district` VALUES ('1265', '齐齐哈尔市', '1176', ',1176,1265,', '2', '0', 'qiqihaershi', '0', '0');
INSERT INTO `district` VALUES ('1266', '龙沙区', '1265', ',1176,1265,1266,', '3', '0', 'longshaqu', '0', '0');
INSERT INTO `district` VALUES ('1267', '建华区', '1265', ',1176,1265,1267,', '3', '0', 'jianhuaqu', '0', '0');
INSERT INTO `district` VALUES ('1268', '铁锋区', '1265', ',1176,1265,1268,', '3', '0', 'tiefengqu', '0', '0');
INSERT INTO `district` VALUES ('1269', '昂昂溪区', '1265', ',1176,1265,1269,', '3', '0', 'angangxiqu', '0', '0');
INSERT INTO `district` VALUES ('1270', '富拉尔基区', '1265', ',1176,1265,1270,', '3', '0', 'fulaerjiqu', '0', '0');
INSERT INTO `district` VALUES ('1271', '碾子山区', '1265', ',1176,1265,1271,', '3', '0', 'nianzishanqu', '0', '0');
INSERT INTO `district` VALUES ('1272', '梅里斯达斡尔族区', '1265', ',1176,1265,1272,', '3', '0', 'meilisidawoerzuqu', '0', '0');
INSERT INTO `district` VALUES ('1273', '龙江县', '1265', ',1176,1265,1273,', '3', '0', 'longjiangxian', '0', '0');
INSERT INTO `district` VALUES ('1274', '依安县', '1265', ',1176,1265,1274,', '3', '0', 'yianxian', '0', '0');
INSERT INTO `district` VALUES ('1275', '泰来县', '1265', ',1176,1265,1275,', '3', '0', 'tailaixian', '0', '0');
INSERT INTO `district` VALUES ('1276', '甘南县', '1265', ',1176,1265,1276,', '3', '0', 'gannanxian', '0', '0');
INSERT INTO `district` VALUES ('1277', '富裕县', '1265', ',1176,1265,1277,', '3', '0', 'fuyuxian', '0', '0');
INSERT INTO `district` VALUES ('1278', '克山县', '1265', ',1176,1265,1278,', '3', '0', 'keshanxian', '0', '0');
INSERT INTO `district` VALUES ('1279', '克东县', '1265', ',1176,1265,1279,', '3', '0', 'kedongxian', '0', '0');
INSERT INTO `district` VALUES ('1280', '拜泉县', '1265', ',1176,1265,1280,', '3', '0', 'baiquanxian', '0', '0');
INSERT INTO `district` VALUES ('1281', '讷河市', '1265', ',1176,1265,1281,', '3', '0', 'heshi', '0', '0');
INSERT INTO `district` VALUES ('1282', '双鸭山市', '1176', ',1176,1282,', '2', '0', 'shuangyashanshi', '0', '0');
INSERT INTO `district` VALUES ('1283', '尖山区', '1282', ',1176,1282,1283,', '3', '0', 'jianshanqu', '0', '0');
INSERT INTO `district` VALUES ('1284', '岭东区', '1282', ',1176,1282,1284,', '3', '0', 'lingdongqu', '0', '0');
INSERT INTO `district` VALUES ('1285', '四方台区', '1282', ',1176,1282,1285,', '3', '0', 'sifangtaiqu', '0', '0');
INSERT INTO `district` VALUES ('1286', '宝山区', '1282', ',1176,1282,1286,', '3', '0', 'baoshanqu', '0', '0');
INSERT INTO `district` VALUES ('1287', '集贤县', '1282', ',1176,1282,1287,', '3', '0', 'jixianxian', '0', '0');
INSERT INTO `district` VALUES ('1288', '友谊县', '1282', ',1176,1282,1288,', '3', '0', 'youyixian', '0', '0');
INSERT INTO `district` VALUES ('1289', '宝清县', '1282', ',1176,1282,1289,', '3', '0', 'baoqingxian', '0', '0');
INSERT INTO `district` VALUES ('1290', '饶河县', '1282', ',1176,1282,1290,', '3', '0', 'raohexian', '0', '0');
INSERT INTO `district` VALUES ('1291', '绥化市', '1176', ',1176,1291,', '2', '0', 'suihuashi', '0', '0');
INSERT INTO `district` VALUES ('1292', '北林区', '1291', ',1176,1291,1292,', '3', '0', 'beilinqu', '0', '0');
INSERT INTO `district` VALUES ('1293', '望奎县', '1291', ',1176,1291,1293,', '3', '0', 'wangkuixian', '0', '0');
INSERT INTO `district` VALUES ('1294', '兰西县', '1291', ',1176,1291,1294,', '3', '0', 'lanxixian', '0', '0');
INSERT INTO `district` VALUES ('1295', '青冈县', '1291', ',1176,1291,1295,', '3', '0', 'qinggangxian', '0', '0');
INSERT INTO `district` VALUES ('1296', '庆安县', '1291', ',1176,1291,1296,', '3', '0', 'qinganxian', '0', '0');
INSERT INTO `district` VALUES ('1297', '明水县', '1291', ',1176,1291,1297,', '3', '0', 'mingshuixian', '0', '0');
INSERT INTO `district` VALUES ('1298', '绥棱县', '1291', ',1176,1291,1298,', '3', '0', 'suilengxian', '0', '0');
INSERT INTO `district` VALUES ('1299', '安达市', '1291', ',1176,1291,1299,', '3', '0', 'andashi', '0', '0');
INSERT INTO `district` VALUES ('1300', '肇东市', '1291', ',1176,1291,1300,', '3', '0', 'zhaodongshi', '0', '0');
INSERT INTO `district` VALUES ('1301', '海伦市', '1291', ',1176,1291,1301,', '3', '0', 'hailunshi', '0', '0');
INSERT INTO `district` VALUES ('1302', '伊春市', '1176', ',1176,1302,', '2', '0', 'yichunshi', '0', '0');
INSERT INTO `district` VALUES ('1303', '伊春区', '1302', ',1176,1302,1303,', '3', '0', 'yichunqu', '0', '0');
INSERT INTO `district` VALUES ('1304', '南岔区', '1302', ',1176,1302,1304,', '3', '0', 'nanchaqu', '0', '0');
INSERT INTO `district` VALUES ('1305', '友好区', '1302', ',1176,1302,1305,', '3', '0', 'youhaoqu', '0', '0');
INSERT INTO `district` VALUES ('1306', '西林区', '1302', ',1176,1302,1306,', '3', '0', 'xilinqu', '0', '0');
INSERT INTO `district` VALUES ('1307', '翠峦区', '1302', ',1176,1302,1307,', '3', '0', 'cuiluanqu', '0', '0');
INSERT INTO `district` VALUES ('1308', '新青区', '1302', ',1176,1302,1308,', '3', '0', 'xinqingqu', '0', '0');
INSERT INTO `district` VALUES ('1309', '美溪区', '1302', ',1176,1302,1309,', '3', '0', 'meixiqu', '0', '0');
INSERT INTO `district` VALUES ('1310', '金山屯区', '1302', ',1176,1302,1310,', '3', '0', 'jinshantunqu', '0', '0');
INSERT INTO `district` VALUES ('1311', '五营区', '1302', ',1176,1302,1311,', '3', '0', 'wuyingqu', '0', '0');
INSERT INTO `district` VALUES ('1312', '乌马河区', '1302', ',1176,1302,1312,', '3', '0', 'wumahequ', '0', '0');
INSERT INTO `district` VALUES ('1313', '汤旺河区', '1302', ',1176,1302,1313,', '3', '0', 'tangwanghequ', '0', '0');
INSERT INTO `district` VALUES ('1314', '带岭区', '1302', ',1176,1302,1314,', '3', '0', 'dailingqu', '0', '0');
INSERT INTO `district` VALUES ('1315', '乌伊岭区', '1302', ',1176,1302,1315,', '3', '0', 'wuyilingqu', '0', '0');
INSERT INTO `district` VALUES ('1316', '红星区', '1302', ',1176,1302,1316,', '3', '0', 'hongxingqu', '0', '0');
INSERT INTO `district` VALUES ('1317', '上甘岭区', '1302', ',1176,1302,1317,', '3', '0', 'shangganlingqu', '0', '0');
INSERT INTO `district` VALUES ('1318', '嘉荫县', '1302', ',1176,1302,1318,', '3', '0', 'jiayinxian', '0', '0');
INSERT INTO `district` VALUES ('1319', '铁力市', '1302', ',1176,1302,1319,', '3', '0', 'tielishi', '0', '0');
INSERT INTO `district` VALUES ('1320', '湖北省', '0', ',1320,', '1', '0', 'hubeisheng', '0', '0');
INSERT INTO `district` VALUES ('1321', '武汉市', '1320', ',1320,1321,', '2', '0', 'wuhanshi', '0', '0');
INSERT INTO `district` VALUES ('1322', '江岸区', '1321', ',1320,1321,1322,', '3', '0', 'jianganqu', '0', '0');
INSERT INTO `district` VALUES ('1323', '江汉区', '1321', ',1320,1321,1323,', '3', '0', 'jianghanqu', '0', '0');
INSERT INTO `district` VALUES ('1324', '硚口区', '1321', ',1320,1321,1324,', '3', '0', 'qiaokouqu', '0', '0');
INSERT INTO `district` VALUES ('1325', '汉阳区', '1321', ',1320,1321,1325,', '3', '0', 'hanyangqu', '0', '0');
INSERT INTO `district` VALUES ('1326', '武昌区', '1321', ',1320,1321,1326,', '3', '0', 'wuchangqu', '0', '0');
INSERT INTO `district` VALUES ('1327', '青山区', '1321', ',1320,1321,1327,', '3', '0', 'qingshanqu', '0', '0');
INSERT INTO `district` VALUES ('1328', '洪山区', '1321', ',1320,1321,1328,', '3', '0', 'hongshanqu', '0', '0');
INSERT INTO `district` VALUES ('1329', '东西湖区', '1321', ',1320,1321,1329,', '3', '0', 'dongxihuqu', '0', '0');
INSERT INTO `district` VALUES ('1330', '汉南区', '1321', ',1320,1321,1330,', '3', '0', 'hannanqu', '0', '0');
INSERT INTO `district` VALUES ('1331', '蔡甸区', '1321', ',1320,1321,1331,', '3', '0', 'caidianqu', '0', '0');
INSERT INTO `district` VALUES ('1332', '江夏区', '1321', ',1320,1321,1332,', '3', '0', 'jiangxiaqu', '0', '0');
INSERT INTO `district` VALUES ('1333', '黄陂区', '1321', ',1320,1321,1333,', '3', '0', 'huangqu', '0', '0');
INSERT INTO `district` VALUES ('1334', '新洲区', '1321', ',1320,1321,1334,', '3', '0', 'xinzhouqu', '0', '0');
INSERT INTO `district` VALUES ('1335', '鄂州市', '1320', ',1320,1335,', '2', '0', 'ezhoushi', '0', '0');
INSERT INTO `district` VALUES ('1336', '梁子湖区', '1335', ',1320,1335,1336,', '3', '0', 'liangzihuqu', '0', '0');
INSERT INTO `district` VALUES ('1337', '华容区', '1335', ',1320,1335,1337,', '3', '0', 'huarongqu', '0', '0');
INSERT INTO `district` VALUES ('1338', '鄂城区', '1335', ',1320,1335,1338,', '3', '0', 'echengqu', '0', '0');
INSERT INTO `district` VALUES ('1339', '恩施土家族苗族自治州', '1320', ',1320,1339,', '2', '0', 'enshitujiazumiaozuzizhizhou', '0', '0');
INSERT INTO `district` VALUES ('1340', '恩施市', '1339', ',1320,1339,1340,', '3', '0', 'enshishi', '0', '0');
INSERT INTO `district` VALUES ('1341', '利川市', '1339', ',1320,1339,1341,', '3', '0', 'lichuanshi', '0', '0');
INSERT INTO `district` VALUES ('1342', '建始县', '1339', ',1320,1339,1342,', '3', '0', 'jianshixian', '0', '0');
INSERT INTO `district` VALUES ('1343', '巴东县', '1339', ',1320,1339,1343,', '3', '0', 'badongxian', '0', '0');
INSERT INTO `district` VALUES ('1344', '宣恩县', '1339', ',1320,1339,1344,', '3', '0', 'xuanenxian', '0', '0');
INSERT INTO `district` VALUES ('1345', '咸丰县', '1339', ',1320,1339,1345,', '3', '0', 'xianfengxian', '0', '0');
INSERT INTO `district` VALUES ('1346', '来凤县', '1339', ',1320,1339,1346,', '3', '0', 'laifengxian', '0', '0');
INSERT INTO `district` VALUES ('1347', '鹤峰县', '1339', ',1320,1339,1347,', '3', '0', 'hefengxian', '0', '0');
INSERT INTO `district` VALUES ('1348', '黄冈市', '1320', ',1320,1348,', '2', '0', 'huanggangshi', '0', '0');
INSERT INTO `district` VALUES ('1349', '黄州区', '1348', ',1320,1348,1349,', '3', '0', 'huangzhouqu', '0', '0');
INSERT INTO `district` VALUES ('1350', '团风县', '1348', ',1320,1348,1350,', '3', '0', 'tuanfengxian', '0', '0');
INSERT INTO `district` VALUES ('1351', '红安县', '1348', ',1320,1348,1351,', '3', '0', 'honganxian', '0', '0');
INSERT INTO `district` VALUES ('1352', '罗田县', '1348', ',1320,1348,1352,', '3', '0', 'luotianxian', '0', '0');
INSERT INTO `district` VALUES ('1353', '英山县', '1348', ',1320,1348,1353,', '3', '0', 'yingshanxian', '0', '0');
INSERT INTO `district` VALUES ('1354', '浠水县', '1348', ',1320,1348,1354,', '3', '0', 'shuixian', '0', '0');
INSERT INTO `district` VALUES ('1355', '蕲春县', '1348', ',1320,1348,1355,', '3', '0', 'chunxian', '0', '0');
INSERT INTO `district` VALUES ('1356', '黄梅县', '1348', ',1320,1348,1356,', '3', '0', 'huangmeixian', '0', '0');
INSERT INTO `district` VALUES ('1357', '麻城市', '1348', ',1320,1348,1357,', '3', '0', 'machengshi', '0', '0');
INSERT INTO `district` VALUES ('1358', '武穴市', '1348', ',1320,1348,1358,', '3', '0', 'wuxueshi', '0', '0');
INSERT INTO `district` VALUES ('1359', '黄石市', '1320', ',1320,1359,', '2', '0', 'huangshishi', '0', '0');
INSERT INTO `district` VALUES ('1360', '黄石港区', '1359', ',1320,1359,1360,', '3', '0', 'huangshigangqu', '0', '0');
INSERT INTO `district` VALUES ('1361', '西塞山区', '1359', ',1320,1359,1361,', '3', '0', 'xisaishanqu', '0', '0');
INSERT INTO `district` VALUES ('1362', '下陆区', '1359', ',1320,1359,1362,', '3', '0', 'xialuqu', '0', '0');
INSERT INTO `district` VALUES ('1363', '铁山区', '1359', ',1320,1359,1363,', '3', '0', 'tieshanqu', '0', '0');
INSERT INTO `district` VALUES ('1364', '阳新县', '1359', ',1320,1359,1364,', '3', '0', 'yangxinxian', '0', '0');
INSERT INTO `district` VALUES ('1365', '大冶市', '1359', ',1320,1359,1365,', '3', '0', 'dayeshi', '0', '0');
INSERT INTO `district` VALUES ('1366', '荆门市', '1320', ',1320,1366,', '2', '0', 'jingmenshi', '0', '0');
INSERT INTO `district` VALUES ('1367', '东宝区', '1366', ',1320,1366,1367,', '3', '0', 'dongbaoqu', '0', '0');
INSERT INTO `district` VALUES ('1368', '掇刀区', '1366', ',1320,1366,1368,', '3', '0', 'duodaoqu', '0', '0');
INSERT INTO `district` VALUES ('1369', '京山县', '1366', ',1320,1366,1369,', '3', '0', 'jingshanxian', '0', '0');
INSERT INTO `district` VALUES ('1370', '沙洋县', '1366', ',1320,1366,1370,', '3', '0', 'shayangxian', '0', '0');
INSERT INTO `district` VALUES ('1371', '钟祥市', '1366', ',1320,1366,1371,', '3', '0', 'zhongxiangshi', '0', '0');
INSERT INTO `district` VALUES ('1372', '荆州市', '1320', ',1320,1372,', '2', '0', 'jingzhoushi', '0', '0');
INSERT INTO `district` VALUES ('1373', '沙市区', '1372', ',1320,1372,1373,', '3', '0', 'shashiqu', '0', '0');
INSERT INTO `district` VALUES ('1374', '荆州区', '1372', ',1320,1372,1374,', '3', '0', 'jingzhouqu', '0', '0');
INSERT INTO `district` VALUES ('1375', '公安县', '1372', ',1320,1372,1375,', '3', '0', 'gonganxian', '0', '0');
INSERT INTO `district` VALUES ('1376', '监利县', '1372', ',1320,1372,1376,', '3', '0', 'jianlixian', '0', '0');
INSERT INTO `district` VALUES ('1377', '江陵县', '1372', ',1320,1372,1377,', '3', '0', 'jianglingxian', '0', '0');
INSERT INTO `district` VALUES ('1378', '石首市', '1372', ',1320,1372,1378,', '3', '0', 'shishoushi', '0', '0');
INSERT INTO `district` VALUES ('1379', '洪湖市', '1372', ',1320,1372,1379,', '3', '0', 'honghushi', '0', '0');
INSERT INTO `district` VALUES ('1380', '松滋市', '1372', ',1320,1372,1380,', '3', '0', 'songzishi', '0', '0');
INSERT INTO `district` VALUES ('1381', '潜江市', '1320', ',1320,1381,', '2', '0', 'qianjiangshi', '0', '0');
INSERT INTO `district` VALUES ('1382', '神农架林区', '1320', ',1320,1382,', '2', '0', 'shennongjialinqu', '0', '0');
INSERT INTO `district` VALUES ('1383', '十堰市', '1320', ',1320,1383,', '2', '0', 'shiyanshi', '0', '0');
INSERT INTO `district` VALUES ('1384', '茅箭区', '1383', ',1320,1383,1384,', '3', '0', 'maojianqu', '0', '0');
INSERT INTO `district` VALUES ('1385', '张湾区', '1383', ',1320,1383,1385,', '3', '0', 'zhangwanqu', '0', '0');
INSERT INTO `district` VALUES ('1386', '郧县', '1383', ',1320,1383,1386,', '3', '0', 'yunxian', '0', '0');
INSERT INTO `district` VALUES ('1387', '郧西县', '1383', ',1320,1383,1387,', '3', '0', 'yunxixian', '0', '0');
INSERT INTO `district` VALUES ('1388', '竹山县', '1383', ',1320,1383,1388,', '3', '0', 'zhushanxian', '0', '0');
INSERT INTO `district` VALUES ('1389', '竹溪县', '1383', ',1320,1383,1389,', '3', '0', 'zhuxixian', '0', '0');
INSERT INTO `district` VALUES ('1390', '房县', '1383', ',1320,1383,1390,', '3', '0', 'fangxian', '0', '0');
INSERT INTO `district` VALUES ('1391', '丹江口市', '1383', ',1320,1383,1391,', '3', '0', 'danjiangkoushi', '0', '0');
INSERT INTO `district` VALUES ('1392', '随州市', '1320', ',1320,1392,', '2', '0', 'suizhoushi', '0', '0');
INSERT INTO `district` VALUES ('1393', '曾都区', '1392', ',1320,1392,1393,', '3', '0', 'zengduqu', '0', '0');
INSERT INTO `district` VALUES ('1394', '广水市', '1392', ',1320,1392,1394,', '3', '0', 'guangshuishi', '0', '0');
INSERT INTO `district` VALUES ('1395', '天门市', '1320', ',1320,1395,', '2', '0', 'tianmenshi', '0', '0');
INSERT INTO `district` VALUES ('1396', '仙桃市', '1320', ',1320,1396,', '2', '0', 'xiantaoshi', '0', '0');
INSERT INTO `district` VALUES ('1397', '咸宁市', '1320', ',1320,1397,', '2', '0', 'xianningshi', '0', '0');
INSERT INTO `district` VALUES ('1398', '咸安区', '1397', ',1320,1397,1398,', '3', '0', 'xiananqu', '0', '0');
INSERT INTO `district` VALUES ('1399', '嘉鱼县', '1397', ',1320,1397,1399,', '3', '0', 'jiayuxian', '0', '0');
INSERT INTO `district` VALUES ('1400', '通城县', '1397', ',1320,1397,1400,', '3', '0', 'tongchengxian', '0', '0');
INSERT INTO `district` VALUES ('1401', '崇阳县', '1397', ',1320,1397,1401,', '3', '0', 'chongyangxian', '0', '0');
INSERT INTO `district` VALUES ('1402', '通山县', '1397', ',1320,1397,1402,', '3', '0', 'tongshanxian', '0', '0');
INSERT INTO `district` VALUES ('1403', '赤壁市', '1397', ',1320,1397,1403,', '3', '0', 'chibishi', '0', '0');
INSERT INTO `district` VALUES ('1404', '襄樊市', '1320', ',1320,1404,', '2', '0', 'xiangfanshi', '0', '0');
INSERT INTO `district` VALUES ('1405', '襄城区', '1404', ',1320,1404,1405,', '3', '0', 'xiangchengqu', '0', '0');
INSERT INTO `district` VALUES ('1406', '樊城区', '1404', ',1320,1404,1406,', '3', '0', 'fanchengqu', '0', '0');
INSERT INTO `district` VALUES ('1407', '襄阳区', '1404', ',1320,1404,1407,', '3', '0', 'xiangyangqu', '0', '0');
INSERT INTO `district` VALUES ('1408', '南漳县', '1404', ',1320,1404,1408,', '3', '0', 'nanzhangxian', '0', '0');
INSERT INTO `district` VALUES ('1409', '谷城县', '1404', ',1320,1404,1409,', '3', '0', 'guchengxian', '0', '0');
INSERT INTO `district` VALUES ('1410', '保康县', '1404', ',1320,1404,1410,', '3', '0', 'baokangxian', '0', '0');
INSERT INTO `district` VALUES ('1411', '老河口市', '1404', ',1320,1404,1411,', '3', '0', 'laohekoushi', '0', '0');
INSERT INTO `district` VALUES ('1412', '枣阳市', '1404', ',1320,1404,1412,', '3', '0', 'zaoyangshi', '0', '0');
INSERT INTO `district` VALUES ('1413', '宜城市', '1404', ',1320,1404,1413,', '3', '0', 'yichengshi', '0', '0');
INSERT INTO `district` VALUES ('1414', '孝感市', '1320', ',1320,1414,', '2', '0', 'xiaoganshi', '0', '0');
INSERT INTO `district` VALUES ('1415', '孝南区', '1414', ',1320,1414,1415,', '3', '0', 'xiaonanqu', '0', '0');
INSERT INTO `district` VALUES ('1416', '孝昌县', '1414', ',1320,1414,1416,', '3', '0', 'xiaochangxian', '0', '0');
INSERT INTO `district` VALUES ('1417', '大悟县', '1414', ',1320,1414,1417,', '3', '0', 'dawuxian', '0', '0');
INSERT INTO `district` VALUES ('1418', '云梦县', '1414', ',1320,1414,1418,', '3', '0', 'yunmengxian', '0', '0');
INSERT INTO `district` VALUES ('1419', '应城市', '1414', ',1320,1414,1419,', '3', '0', 'yingchengshi', '0', '0');
INSERT INTO `district` VALUES ('1420', '安陆市', '1414', ',1320,1414,1420,', '3', '0', 'anlushi', '0', '0');
INSERT INTO `district` VALUES ('1421', '汉川市', '1414', ',1320,1414,1421,', '3', '0', 'hanchuanshi', '0', '0');
INSERT INTO `district` VALUES ('1422', '宜昌市', '1320', ',1320,1422,', '2', '0', 'yichangshi', '0', '0');
INSERT INTO `district` VALUES ('1423', '西陵区', '1422', ',1320,1422,1423,', '3', '0', 'xilingqu', '0', '0');
INSERT INTO `district` VALUES ('1424', '伍家岗区', '1422', ',1320,1422,1424,', '3', '0', 'wujiagangqu', '0', '0');
INSERT INTO `district` VALUES ('1425', '点军区', '1422', ',1320,1422,1425,', '3', '0', 'dianjunqu', '0', '0');
INSERT INTO `district` VALUES ('1426', '猇亭区', '1422', ',1320,1422,1426,', '3', '0', 'tingqu', '0', '0');
INSERT INTO `district` VALUES ('1427', '夷陵区', '1422', ',1320,1422,1427,', '3', '0', 'yilingqu', '0', '0');
INSERT INTO `district` VALUES ('1428', '远安县', '1422', ',1320,1422,1428,', '3', '0', 'yuananxian', '0', '0');
INSERT INTO `district` VALUES ('1429', '兴山县', '1422', ',1320,1422,1429,', '3', '0', 'xingshanxian', '0', '0');
INSERT INTO `district` VALUES ('1430', '秭归县', '1422', ',1320,1422,1430,', '3', '0', 'guixian', '0', '0');
INSERT INTO `district` VALUES ('1431', '长阳土家族自治县', '1422', ',1320,1422,1431,', '3', '0', 'changyangtujiazuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('1432', '五峰土家族自治县', '1422', ',1320,1422,1432,', '3', '0', 'wufengtujiazuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('1433', '宜都市', '1422', ',1320,1422,1433,', '3', '0', 'yidushi', '0', '0');
INSERT INTO `district` VALUES ('1434', '当阳市', '1422', ',1320,1422,1434,', '3', '0', 'dangyangshi', '0', '0');
INSERT INTO `district` VALUES ('1435', '枝江市', '1422', ',1320,1422,1435,', '3', '0', 'zhijiangshi', '0', '0');
INSERT INTO `district` VALUES ('1436', '湖南省', '0', ',1436,', '1', '0', 'hunansheng', '0', '0');
INSERT INTO `district` VALUES ('1437', '长沙市', '1436', ',1436,1437,', '2', '0', 'changshashi', '0', '0');
INSERT INTO `district` VALUES ('1438', '芙蓉区', '1437', ',1436,1437,1438,', '3', '0', 'rongqu', '0', '0');
INSERT INTO `district` VALUES ('1439', '天心区', '1437', ',1436,1437,1439,', '3', '0', 'tianxinqu', '0', '0');
INSERT INTO `district` VALUES ('1440', '岳麓区', '1437', ',1436,1437,1440,', '3', '0', 'yueluqu', '0', '0');
INSERT INTO `district` VALUES ('1441', '开福区', '1437', ',1436,1437,1441,', '3', '0', 'kaifuqu', '0', '0');
INSERT INTO `district` VALUES ('1442', '雨花区', '1437', ',1436,1437,1442,', '3', '0', 'yuhuaqu', '0', '0');
INSERT INTO `district` VALUES ('1443', '长沙县', '1437', ',1436,1437,1443,', '3', '0', 'changshaxian', '0', '0');
INSERT INTO `district` VALUES ('1444', '望城县', '1437', ',1436,1437,1444,', '3', '0', 'wangchengxian', '0', '0');
INSERT INTO `district` VALUES ('1445', '宁乡县', '1437', ',1436,1437,1445,', '3', '0', 'ningxiangxian', '0', '0');
INSERT INTO `district` VALUES ('1446', '浏阳市', '1437', ',1436,1437,1446,', '3', '0', 'yangshi', '0', '0');
INSERT INTO `district` VALUES ('1447', '常德市', '1436', ',1436,1447,', '2', '0', 'changdeshi', '0', '0');
INSERT INTO `district` VALUES ('1448', '武陵区', '1447', ',1436,1447,1448,', '3', '0', 'wulingqu', '0', '0');
INSERT INTO `district` VALUES ('1449', '鼎城区', '1447', ',1436,1447,1449,', '3', '0', 'dingchengqu', '0', '0');
INSERT INTO `district` VALUES ('1450', '安乡县', '1447', ',1436,1447,1450,', '3', '0', 'anxiangxian', '0', '0');
INSERT INTO `district` VALUES ('1451', '汉寿县', '1447', ',1436,1447,1451,', '3', '0', 'hanshouxian', '0', '0');
INSERT INTO `district` VALUES ('1452', '澧县', '1447', ',1436,1447,1452,', '3', '0', 'xian', '0', '0');
INSERT INTO `district` VALUES ('1453', '临澧县', '1447', ',1436,1447,1453,', '3', '0', 'linxian', '0', '0');
INSERT INTO `district` VALUES ('1454', '桃源县', '1447', ',1436,1447,1454,', '3', '0', 'taoyuanxian', '0', '0');
INSERT INTO `district` VALUES ('1455', '石门县', '1447', ',1436,1447,1455,', '3', '0', 'shimenxian', '0', '0');
INSERT INTO `district` VALUES ('1456', '津市市', '1447', ',1436,1447,1456,', '3', '0', 'jinshishi', '0', '0');
INSERT INTO `district` VALUES ('1457', '郴州市', '1436', ',1436,1457,', '2', '0', 'chenzhoushi', '0', '0');
INSERT INTO `district` VALUES ('1458', '北湖区', '1457', ',1436,1457,1458,', '3', '0', 'beihuqu', '0', '0');
INSERT INTO `district` VALUES ('1459', '苏仙区', '1457', ',1436,1457,1459,', '3', '0', 'suxianqu', '0', '0');
INSERT INTO `district` VALUES ('1460', '桂阳县', '1457', ',1436,1457,1460,', '3', '0', 'guiyangxian', '0', '0');
INSERT INTO `district` VALUES ('1461', '宜章县', '1457', ',1436,1457,1461,', '3', '0', 'yizhangxian', '0', '0');
INSERT INTO `district` VALUES ('1462', '永兴县', '1457', ',1436,1457,1462,', '3', '0', 'yongxingxian', '0', '0');
INSERT INTO `district` VALUES ('1463', '嘉禾县', '1457', ',1436,1457,1463,', '3', '0', 'jiahexian', '0', '0');
INSERT INTO `district` VALUES ('1464', '临武县', '1457', ',1436,1457,1464,', '3', '0', 'linwuxian', '0', '0');
INSERT INTO `district` VALUES ('1465', '汝城县', '1457', ',1436,1457,1465,', '3', '0', 'ruchengxian', '0', '0');
INSERT INTO `district` VALUES ('1466', '桂东县', '1457', ',1436,1457,1466,', '3', '0', 'guidongxian', '0', '0');
INSERT INTO `district` VALUES ('1467', '安仁县', '1457', ',1436,1457,1467,', '3', '0', 'anrenxian', '0', '0');
INSERT INTO `district` VALUES ('1468', '资兴市', '1457', ',1436,1457,1468,', '3', '0', 'zixingshi', '0', '0');
INSERT INTO `district` VALUES ('1469', '衡阳市', '1436', ',1436,1469,', '2', '0', 'hengyangshi', '0', '0');
INSERT INTO `district` VALUES ('1470', '珠晖区', '1469', ',1436,1469,1470,', '3', '0', 'zhuqu', '0', '0');
INSERT INTO `district` VALUES ('1471', '雁峰区', '1469', ',1436,1469,1471,', '3', '0', 'yanfengqu', '0', '0');
INSERT INTO `district` VALUES ('1472', '石鼓区', '1469', ',1436,1469,1472,', '3', '0', 'shiguqu', '0', '0');
INSERT INTO `district` VALUES ('1473', '蒸湘区', '1469', ',1436,1469,1473,', '3', '0', 'zhengxiangqu', '0', '0');
INSERT INTO `district` VALUES ('1474', '南岳区', '1469', ',1436,1469,1474,', '3', '0', 'nanyuequ', '0', '0');
INSERT INTO `district` VALUES ('1475', '衡阳县', '1469', ',1436,1469,1475,', '3', '0', 'hengyangxian', '0', '0');
INSERT INTO `district` VALUES ('1476', '衡南县', '1469', ',1436,1469,1476,', '3', '0', 'hengnanxian', '0', '0');
INSERT INTO `district` VALUES ('1477', '衡山县', '1469', ',1436,1469,1477,', '3', '0', 'hengshanxian', '0', '0');
INSERT INTO `district` VALUES ('1478', '衡东县', '1469', ',1436,1469,1478,', '3', '0', 'hengdongxian', '0', '0');
INSERT INTO `district` VALUES ('1479', '祁东县', '1469', ',1436,1469,1479,', '3', '0', 'qidongxian', '0', '0');
INSERT INTO `district` VALUES ('1480', '耒阳市', '1469', ',1436,1469,1480,', '3', '0', 'yangshi', '0', '0');
INSERT INTO `district` VALUES ('1481', '常宁市', '1469', ',1436,1469,1481,', '3', '0', 'changningshi', '0', '0');
INSERT INTO `district` VALUES ('1482', '怀化市', '1436', ',1436,1482,', '2', '0', 'huaihuashi', '0', '0');
INSERT INTO `district` VALUES ('1483', '鹤城区', '1482', ',1436,1482,1483,', '3', '0', 'hechengqu', '0', '0');
INSERT INTO `district` VALUES ('1484', '中方县', '1482', ',1436,1482,1484,', '3', '0', 'zhongfangxian', '0', '0');
INSERT INTO `district` VALUES ('1485', '沅陵县', '1482', ',1436,1482,1485,', '3', '0', 'lingxian', '0', '0');
INSERT INTO `district` VALUES ('1486', '辰溪县', '1482', ',1436,1482,1486,', '3', '0', 'chenxixian', '0', '0');
INSERT INTO `district` VALUES ('1487', '溆浦县', '1482', ',1436,1482,1487,', '3', '0', 'puxian', '0', '0');
INSERT INTO `district` VALUES ('1488', '会同县', '1482', ',1436,1482,1488,', '3', '0', 'huitongxian', '0', '0');
INSERT INTO `district` VALUES ('1489', '麻阳苗族自治县', '1482', ',1436,1482,1489,', '3', '0', 'mayangmiaozuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('1490', '新晃侗族自治县', '1482', ',1436,1482,1490,', '3', '0', 'xinhuangdongzuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('1491', '芷江侗族自治县', '1482', ',1436,1482,1491,', '3', '0', 'jiangdongzuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('1492', '靖州苗族侗族自治县', '1482', ',1436,1482,1492,', '3', '0', 'jingzhoumiaozudongzuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('1493', '通道侗族自治县', '1482', ',1436,1482,1493,', '3', '0', 'tongdaodongzuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('1494', '洪江市', '1482', ',1436,1482,1494,', '3', '0', 'hongjiangshi', '0', '0');
INSERT INTO `district` VALUES ('1495', '娄底市', '1436', ',1436,1495,', '2', '0', 'loudishi', '0', '0');
INSERT INTO `district` VALUES ('1496', '娄星区', '1495', ',1436,1495,1496,', '3', '0', 'louxingqu', '0', '0');
INSERT INTO `district` VALUES ('1497', '双峰县', '1495', ',1436,1495,1497,', '3', '0', 'shuangfengxian', '0', '0');
INSERT INTO `district` VALUES ('1498', '新化县', '1495', ',1436,1495,1498,', '3', '0', 'xinhuaxian', '0', '0');
INSERT INTO `district` VALUES ('1499', '冷水江市', '1495', ',1436,1495,1499,', '3', '0', 'lengshuijiangshi', '0', '0');
INSERT INTO `district` VALUES ('1500', '涟源市', '1495', ',1436,1495,1500,', '3', '0', 'lianyuanshi', '0', '0');
INSERT INTO `district` VALUES ('1501', '邵阳市', '1436', ',1436,1501,', '2', '0', 'shaoyangshi', '0', '0');
INSERT INTO `district` VALUES ('1502', '双清区', '1501', ',1436,1501,1502,', '3', '0', 'shuangqingqu', '0', '0');
INSERT INTO `district` VALUES ('1503', '大祥区', '1501', ',1436,1501,1503,', '3', '0', 'daxiangqu', '0', '0');
INSERT INTO `district` VALUES ('1504', '北塔区', '1501', ',1436,1501,1504,', '3', '0', 'beitaqu', '0', '0');
INSERT INTO `district` VALUES ('1505', '邵东县', '1501', ',1436,1501,1505,', '3', '0', 'shaodongxian', '0', '0');
INSERT INTO `district` VALUES ('1506', '新邵县', '1501', ',1436,1501,1506,', '3', '0', 'xinshaoxian', '0', '0');
INSERT INTO `district` VALUES ('1507', '邵阳县', '1501', ',1436,1501,1507,', '3', '0', 'shaoyangxian', '0', '0');
INSERT INTO `district` VALUES ('1508', '隆回县', '1501', ',1436,1501,1508,', '3', '0', 'longhuixian', '0', '0');
INSERT INTO `district` VALUES ('1509', '洞口县', '1501', ',1436,1501,1509,', '3', '0', 'dongkouxian', '0', '0');
INSERT INTO `district` VALUES ('1510', '绥宁县', '1501', ',1436,1501,1510,', '3', '0', 'suiningxian', '0', '0');
INSERT INTO `district` VALUES ('1511', '新宁县', '1501', ',1436,1501,1511,', '3', '0', 'xinningxian', '0', '0');
INSERT INTO `district` VALUES ('1512', '城步苗族自治县', '1501', ',1436,1501,1512,', '3', '0', 'chengbumiaozuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('1513', '武冈市', '1501', ',1436,1501,1513,', '3', '0', 'wugangshi', '0', '0');
INSERT INTO `district` VALUES ('1514', '湘潭市', '1436', ',1436,1514,', '2', '0', 'xiangtanshi', '0', '0');
INSERT INTO `district` VALUES ('1515', '雨湖区', '1514', ',1436,1514,1515,', '3', '0', 'yuhuqu', '0', '0');
INSERT INTO `district` VALUES ('1516', '岳塘区', '1514', ',1436,1514,1516,', '3', '0', 'yuetangqu', '0', '0');
INSERT INTO `district` VALUES ('1517', '湘潭县', '1514', ',1436,1514,1517,', '3', '0', 'xiangtanxian', '0', '0');
INSERT INTO `district` VALUES ('1518', '湘乡市', '1514', ',1436,1514,1518,', '3', '0', 'xiangxiangshi', '0', '0');
INSERT INTO `district` VALUES ('1519', '韶山市', '1514', ',1436,1514,1519,', '3', '0', 'shaoshanshi', '0', '0');
INSERT INTO `district` VALUES ('1520', '湘西土家族苗族自治州', '1436', ',1436,1520,', '2', '0', 'xiangxitujiazumiaozuzizhizhou', '0', '0');
INSERT INTO `district` VALUES ('1521', '吉首市', '1520', ',1436,1520,1521,', '3', '0', 'jishoushi', '0', '0');
INSERT INTO `district` VALUES ('1522', '泸溪县', '1520', ',1436,1520,1522,', '3', '0', 'xixian', '0', '0');
INSERT INTO `district` VALUES ('1523', '凤凰县', '1520', ',1436,1520,1523,', '3', '0', 'fenghuangxian', '0', '0');
INSERT INTO `district` VALUES ('1524', '花垣县', '1520', ',1436,1520,1524,', '3', '0', 'huayuanxian', '0', '0');
INSERT INTO `district` VALUES ('1525', '保靖县', '1520', ',1436,1520,1525,', '3', '0', 'baojingxian', '0', '0');
INSERT INTO `district` VALUES ('1526', '古丈县', '1520', ',1436,1520,1526,', '3', '0', 'guzhangxian', '0', '0');
INSERT INTO `district` VALUES ('1527', '永顺县', '1520', ',1436,1520,1527,', '3', '0', 'yongshunxian', '0', '0');
INSERT INTO `district` VALUES ('1528', '龙山县', '1520', ',1436,1520,1528,', '3', '0', 'longshanxian', '0', '0');
INSERT INTO `district` VALUES ('1529', '益阳市', '1436', ',1436,1529,', '2', '0', 'yiyangshi', '0', '0');
INSERT INTO `district` VALUES ('1530', '资阳区', '1529', ',1436,1529,1530,', '3', '0', 'ziyangqu', '0', '0');
INSERT INTO `district` VALUES ('1531', '赫山区', '1529', ',1436,1529,1531,', '3', '0', 'heshanqu', '0', '0');
INSERT INTO `district` VALUES ('1532', '南县', '1529', ',1436,1529,1532,', '3', '0', 'nanxian', '0', '0');
INSERT INTO `district` VALUES ('1533', '桃江县', '1529', ',1436,1529,1533,', '3', '0', 'taojiangxian', '0', '0');
INSERT INTO `district` VALUES ('1534', '安化县', '1529', ',1436,1529,1534,', '3', '0', 'anhuaxian', '0', '0');
INSERT INTO `district` VALUES ('1535', '沅江市', '1529', ',1436,1529,1535,', '3', '0', 'jiangshi', '0', '0');
INSERT INTO `district` VALUES ('1536', '永州市', '1436', ',1436,1536,', '2', '0', 'yongzhoushi', '0', '0');
INSERT INTO `district` VALUES ('1537', '芝山区', '1536', ',1436,1536,1537,', '3', '0', 'zhishanqu', '0', '0');
INSERT INTO `district` VALUES ('1538', '冷水滩区', '1536', ',1436,1536,1538,', '3', '0', 'lengshuitanqu', '0', '0');
INSERT INTO `district` VALUES ('1539', '祁阳县', '1536', ',1436,1536,1539,', '3', '0', 'qiyangxian', '0', '0');
INSERT INTO `district` VALUES ('1540', '东安县', '1536', ',1436,1536,1540,', '3', '0', 'donganxian', '0', '0');
INSERT INTO `district` VALUES ('1541', '双牌县', '1536', ',1436,1536,1541,', '3', '0', 'shuangpaixian', '0', '0');
INSERT INTO `district` VALUES ('1542', '道县', '1536', ',1436,1536,1542,', '3', '0', 'daoxian', '0', '0');
INSERT INTO `district` VALUES ('1543', '江永县', '1536', ',1436,1536,1543,', '3', '0', 'jiangyongxian', '0', '0');
INSERT INTO `district` VALUES ('1544', '宁远县', '1536', ',1436,1536,1544,', '3', '0', 'ningyuanxian', '0', '0');
INSERT INTO `district` VALUES ('1545', '蓝山县', '1536', ',1436,1536,1545,', '3', '0', 'lanshanxian', '0', '0');
INSERT INTO `district` VALUES ('1546', '新田县', '1536', ',1436,1536,1546,', '3', '0', 'xintianxian', '0', '0');
INSERT INTO `district` VALUES ('1547', '江华瑶族自治县', '1536', ',1436,1536,1547,', '3', '0', 'jianghuayaozuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('1548', '岳阳市', '1436', ',1436,1548,', '2', '0', 'yueyangshi', '0', '0');
INSERT INTO `district` VALUES ('1549', '岳阳楼区', '1548', ',1436,1548,1549,', '3', '0', 'yueyanglouqu', '0', '0');
INSERT INTO `district` VALUES ('1550', '云溪区', '1548', ',1436,1548,1550,', '3', '0', 'yunxiqu', '0', '0');
INSERT INTO `district` VALUES ('1551', '君山区', '1548', ',1436,1548,1551,', '3', '0', 'junshanqu', '0', '0');
INSERT INTO `district` VALUES ('1552', '岳阳县', '1548', ',1436,1548,1552,', '3', '0', 'yueyangxian', '0', '0');
INSERT INTO `district` VALUES ('1553', '华容县', '1548', ',1436,1548,1553,', '3', '0', 'huarongxian', '0', '0');
INSERT INTO `district` VALUES ('1554', '湘阴县', '1548', ',1436,1548,1554,', '3', '0', 'xiangyinxian', '0', '0');
INSERT INTO `district` VALUES ('1555', '平江县', '1548', ',1436,1548,1555,', '3', '0', 'pingjiangxian', '0', '0');
INSERT INTO `district` VALUES ('1556', '汨罗市', '1548', ',1436,1548,1556,', '3', '0', 'luoshi', '0', '0');
INSERT INTO `district` VALUES ('1557', '临湘市', '1548', ',1436,1548,1557,', '3', '0', 'linxiangshi', '0', '0');
INSERT INTO `district` VALUES ('1558', '张家界市', '1436', ',1436,1558,', '2', '0', 'zhangjiajieshi', '0', '0');
INSERT INTO `district` VALUES ('1559', '永定区', '1558', ',1436,1558,1559,', '3', '0', 'yongdingqu', '0', '0');
INSERT INTO `district` VALUES ('1560', '武陵源区', '1558', ',1436,1558,1560,', '3', '0', 'wulingyuanqu', '0', '0');
INSERT INTO `district` VALUES ('1561', '慈利县', '1558', ',1436,1558,1561,', '3', '0', 'cilixian', '0', '0');
INSERT INTO `district` VALUES ('1562', '桑植县', '1558', ',1436,1558,1562,', '3', '0', 'sangzhixian', '0', '0');
INSERT INTO `district` VALUES ('1563', '株洲市', '1436', ',1436,1563,', '2', '0', 'zhuzhoushi', '0', '0');
INSERT INTO `district` VALUES ('1564', '荷塘区', '1563', ',1436,1563,1564,', '3', '0', 'hetangqu', '0', '0');
INSERT INTO `district` VALUES ('1565', '芦淞区', '1563', ',1436,1563,1565,', '3', '0', 'luqu', '0', '0');
INSERT INTO `district` VALUES ('1566', '石峰区', '1563', ',1436,1563,1566,', '3', '0', 'shifengqu', '0', '0');
INSERT INTO `district` VALUES ('1567', '天元区', '1563', ',1436,1563,1567,', '3', '0', 'tianyuanqu', '0', '0');
INSERT INTO `district` VALUES ('1568', '株洲县', '1563', ',1436,1563,1568,', '3', '0', 'zhuzhouxian', '0', '0');
INSERT INTO `district` VALUES ('1569', '攸县', '1563', ',1436,1563,1569,', '3', '0', 'xian', '0', '0');
INSERT INTO `district` VALUES ('1570', '茶陵县', '1563', ',1436,1563,1570,', '3', '0', 'chalingxian', '0', '0');
INSERT INTO `district` VALUES ('1571', '炎陵县', '1563', ',1436,1563,1571,', '3', '0', 'yanlingxian', '0', '0');
INSERT INTO `district` VALUES ('1572', '醴陵市', '1563', ',1436,1563,1572,', '3', '0', 'lingshi', '0', '0');
INSERT INTO `district` VALUES ('1573', '吉林省', '0', ',1573,', '1', '0', 'jilinsheng', '0', '0');
INSERT INTO `district` VALUES ('1574', '长春市', '1573', ',1573,1574,', '2', '0', 'changchunshi', '0', '0');
INSERT INTO `district` VALUES ('1575', '南关区', '1574', ',1573,1574,1575,', '3', '0', 'nanguanqu', '0', '0');
INSERT INTO `district` VALUES ('1576', '宽城区', '1574', ',1573,1574,1576,', '3', '0', 'kuanchengqu', '0', '0');
INSERT INTO `district` VALUES ('1577', '朝阳区', '1574', ',1573,1574,1577,', '3', '0', 'chaoyangqu', '0', '0');
INSERT INTO `district` VALUES ('1578', '二道区', '1574', ',1573,1574,1578,', '3', '0', 'erdaoqu', '0', '0');
INSERT INTO `district` VALUES ('1579', '绿园区', '1574', ',1573,1574,1579,', '3', '0', 'lvyuanqu', '0', '0');
INSERT INTO `district` VALUES ('1580', '双阳区', '1574', ',1573,1574,1580,', '3', '0', 'shuangyangqu', '0', '0');
INSERT INTO `district` VALUES ('1581', '农安县', '1574', ',1573,1574,1581,', '3', '0', 'nonganxian', '0', '0');
INSERT INTO `district` VALUES ('1582', '九台市', '1574', ',1573,1574,1582,', '3', '0', 'jiutaishi', '0', '0');
INSERT INTO `district` VALUES ('1583', '榆树市', '1574', ',1573,1574,1583,', '3', '0', 'yushushi', '0', '0');
INSERT INTO `district` VALUES ('1584', '德惠市', '1574', ',1573,1574,1584,', '3', '0', 'dehuishi', '0', '0');
INSERT INTO `district` VALUES ('1585', '白城市', '1573', ',1573,1585,', '2', '0', 'baichengshi', '0', '0');
INSERT INTO `district` VALUES ('1586', '洮北区', '1585', ',1573,1585,1586,', '3', '0', 'beiqu', '0', '0');
INSERT INTO `district` VALUES ('1587', '镇赉县', '1585', ',1573,1585,1587,', '3', '0', 'zhenxian', '0', '0');
INSERT INTO `district` VALUES ('1588', '通榆县', '1585', ',1573,1585,1588,', '3', '0', 'tongyuxian', '0', '0');
INSERT INTO `district` VALUES ('1589', '洮南市', '1585', ',1573,1585,1589,', '3', '0', 'nanshi', '0', '0');
INSERT INTO `district` VALUES ('1590', '大安市', '1585', ',1573,1585,1590,', '3', '0', 'daanshi', '0', '0');
INSERT INTO `district` VALUES ('1591', '白山市', '1573', ',1573,1591,', '2', '0', 'baishanshi', '0', '0');
INSERT INTO `district` VALUES ('1592', '八道江区', '1591', ',1573,1591,1592,', '3', '0', 'badaojiangqu', '0', '0');
INSERT INTO `district` VALUES ('1593', '抚松县', '1591', ',1573,1591,1593,', '3', '0', 'fusongxian', '0', '0');
INSERT INTO `district` VALUES ('1594', '靖宇县', '1591', ',1573,1591,1594,', '3', '0', 'jingyuxian', '0', '0');
INSERT INTO `district` VALUES ('1595', '长白朝鲜族自治县', '1591', ',1573,1591,1595,', '3', '0', 'changbaichaoxianzuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('1596', '江源县', '1591', ',1573,1591,1596,', '3', '0', 'jiangyuanxian', '0', '0');
INSERT INTO `district` VALUES ('1597', '临江市', '1591', ',1573,1591,1597,', '3', '0', 'linjiangshi', '0', '0');
INSERT INTO `district` VALUES ('1598', '吉林市', '1573', ',1573,1598,', '2', '0', 'jilinshi', '0', '0');
INSERT INTO `district` VALUES ('1599', '昌邑区', '1598', ',1573,1598,1599,', '3', '0', 'changyiqu', '0', '0');
INSERT INTO `district` VALUES ('1600', '龙潭区', '1598', ',1573,1598,1600,', '3', '0', 'longtanqu', '0', '0');
INSERT INTO `district` VALUES ('1601', '船营区', '1598', ',1573,1598,1601,', '3', '0', 'chuanyingqu', '0', '0');
INSERT INTO `district` VALUES ('1602', '丰满区', '1598', ',1573,1598,1602,', '3', '0', 'fengmanqu', '0', '0');
INSERT INTO `district` VALUES ('1603', '永吉县', '1598', ',1573,1598,1603,', '3', '0', 'yongjixian', '0', '0');
INSERT INTO `district` VALUES ('1604', '蛟河市', '1598', ',1573,1598,1604,', '3', '0', 'heshi', '0', '0');
INSERT INTO `district` VALUES ('1605', '桦甸市', '1598', ',1573,1598,1605,', '3', '0', 'dianshi', '0', '0');
INSERT INTO `district` VALUES ('1606', '舒兰市', '1598', ',1573,1598,1606,', '3', '0', 'shulanshi', '0', '0');
INSERT INTO `district` VALUES ('1607', '磐石市', '1598', ',1573,1598,1607,', '3', '0', 'panshishi', '0', '0');
INSERT INTO `district` VALUES ('1608', '辽源市', '1573', ',1573,1608,', '2', '0', 'liaoyuanshi', '0', '0');
INSERT INTO `district` VALUES ('1609', '龙山区', '1608', ',1573,1608,1609,', '3', '0', 'longshanqu', '0', '0');
INSERT INTO `district` VALUES ('1610', '西安区', '1608', ',1573,1608,1610,', '3', '0', 'xianqu', '0', '0');
INSERT INTO `district` VALUES ('1611', '东丰县', '1608', ',1573,1608,1611,', '3', '0', 'dongfengxian', '0', '0');
INSERT INTO `district` VALUES ('1612', '东辽县', '1608', ',1573,1608,1612,', '3', '0', 'dongliaoxian', '0', '0');
INSERT INTO `district` VALUES ('1613', '四平市', '1573', ',1573,1613,', '2', '0', 'sipingshi', '0', '0');
INSERT INTO `district` VALUES ('1614', '铁西区', '1613', ',1573,1613,1614,', '3', '0', 'tiexiqu', '0', '0');
INSERT INTO `district` VALUES ('1615', '铁东区', '1613', ',1573,1613,1615,', '3', '0', 'tiedongqu', '0', '0');
INSERT INTO `district` VALUES ('1616', '梨树县', '1613', ',1573,1613,1616,', '3', '0', 'lishuxian', '0', '0');
INSERT INTO `district` VALUES ('1617', '伊通满族自治县', '1613', ',1573,1613,1617,', '3', '0', 'yitongmanzuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('1618', '公主岭市', '1613', ',1573,1613,1618,', '3', '0', 'gongzhulingshi', '0', '0');
INSERT INTO `district` VALUES ('1619', '双辽市', '1613', ',1573,1613,1619,', '3', '0', 'shuangliaoshi', '0', '0');
INSERT INTO `district` VALUES ('1620', '松原市', '1573', ',1573,1620,', '2', '0', 'songyuanshi', '0', '0');
INSERT INTO `district` VALUES ('1621', '宁江区', '1620', ',1573,1620,1621,', '3', '0', 'ningjiangqu', '0', '0');
INSERT INTO `district` VALUES ('1622', '前郭尔罗斯蒙古族自治县', '1620', ',1573,1620,1622,', '3', '0', 'qianguoerluosimengguzuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('1623', '长岭县', '1620', ',1573,1620,1623,', '3', '0', 'changlingxian', '0', '0');
INSERT INTO `district` VALUES ('1624', '乾安县', '1620', ',1573,1620,1624,', '3', '0', 'qiananxian', '0', '0');
INSERT INTO `district` VALUES ('1625', '扶余县', '1620', ',1573,1620,1625,', '3', '0', 'fuyuxian', '0', '0');
INSERT INTO `district` VALUES ('1626', '通化市', '1573', ',1573,1626,', '2', '0', 'tonghuashi', '0', '0');
INSERT INTO `district` VALUES ('1627', '东昌区', '1626', ',1573,1626,1627,', '3', '0', 'dongchangqu', '0', '0');
INSERT INTO `district` VALUES ('1628', '二道江区', '1626', ',1573,1626,1628,', '3', '0', 'erdaojiangqu', '0', '0');
INSERT INTO `district` VALUES ('1629', '通化县', '1626', ',1573,1626,1629,', '3', '0', 'tonghuaxian', '0', '0');
INSERT INTO `district` VALUES ('1630', '辉南县', '1626', ',1573,1626,1630,', '3', '0', 'huinanxian', '0', '0');
INSERT INTO `district` VALUES ('1631', '柳河县', '1626', ',1573,1626,1631,', '3', '0', 'liuhexian', '0', '0');
INSERT INTO `district` VALUES ('1632', '梅河口市', '1626', ',1573,1626,1632,', '3', '0', 'meihekoushi', '0', '0');
INSERT INTO `district` VALUES ('1633', '集安市', '1626', ',1573,1626,1633,', '3', '0', 'jianshi', '0', '0');
INSERT INTO `district` VALUES ('1634', '延边朝鲜族自治州', '1573', ',1573,1634,', '2', '0', 'yanbianchaoxianzuzizhizhou', '0', '0');
INSERT INTO `district` VALUES ('1635', '延吉市', '1634', ',1573,1634,1635,', '3', '0', 'yanjishi', '0', '0');
INSERT INTO `district` VALUES ('1636', '图们市', '1634', ',1573,1634,1636,', '3', '0', 'tumenshi', '0', '0');
INSERT INTO `district` VALUES ('1637', '敦化市', '1634', ',1573,1634,1637,', '3', '0', 'dunhuashi', '0', '0');
INSERT INTO `district` VALUES ('1638', '珲春市', '1634', ',1573,1634,1638,', '3', '0', 'chunshi', '0', '0');
INSERT INTO `district` VALUES ('1639', '龙井市', '1634', ',1573,1634,1639,', '3', '0', 'longjingshi', '0', '0');
INSERT INTO `district` VALUES ('1640', '和龙市', '1634', ',1573,1634,1640,', '3', '0', 'helongshi', '0', '0');
INSERT INTO `district` VALUES ('1641', '汪清县', '1634', ',1573,1634,1641,', '3', '0', 'wangqingxian', '0', '0');
INSERT INTO `district` VALUES ('1642', '安图县', '1634', ',1573,1634,1642,', '3', '0', 'antuxian', '0', '0');
INSERT INTO `district` VALUES ('1643', '江苏省', '0', ',1643,', '1', '0', 'jiangsusheng', '0', '0');
INSERT INTO `district` VALUES ('1644', '南京市', '1643', ',1643,1644,', '2', '0', 'nanjingshi', '0', '0');
INSERT INTO `district` VALUES ('1645', '玄武区', '1644', ',1643,1644,1645,', '3', '0', 'xuanwuqu', '0', '0');
INSERT INTO `district` VALUES ('1646', '白下区', '1644', ',1643,1644,1646,', '3', '0', 'baixiaqu', '0', '0');
INSERT INTO `district` VALUES ('1647', '秦淮区', '1644', ',1643,1644,1647,', '3', '0', 'qinhuaiqu', '0', '0');
INSERT INTO `district` VALUES ('1648', '建邺区', '1644', ',1643,1644,1648,', '3', '0', 'jianqu', '0', '0');
INSERT INTO `district` VALUES ('1649', '鼓楼区', '1644', ',1643,1644,1649,', '3', '0', 'gulouqu', '0', '0');
INSERT INTO `district` VALUES ('1650', '下关区', '1644', ',1643,1644,1650,', '3', '0', 'xiaguanqu', '0', '0');
INSERT INTO `district` VALUES ('1651', '浦口区', '1644', ',1643,1644,1651,', '3', '0', 'pukouqu', '0', '0');
INSERT INTO `district` VALUES ('1652', '栖霞区', '1644', ',1643,1644,1652,', '3', '0', 'qixiaqu', '0', '0');
INSERT INTO `district` VALUES ('1653', '雨花台区', '1644', ',1643,1644,1653,', '3', '0', 'yuhuataiqu', '0', '0');
INSERT INTO `district` VALUES ('1654', '江宁区', '1644', ',1643,1644,1654,', '3', '0', 'jiangningqu', '0', '0');
INSERT INTO `district` VALUES ('1655', '六合区', '1644', ',1643,1644,1655,', '3', '0', 'liuhequ', '0', '0');
INSERT INTO `district` VALUES ('1656', '溧水县', '1644', ',1643,1644,1656,', '3', '0', 'shuixian', '0', '0');
INSERT INTO `district` VALUES ('1657', '高淳县', '1644', ',1643,1644,1657,', '3', '0', 'gaochunxian', '0', '0');
INSERT INTO `district` VALUES ('1658', '常州市', '1643', ',1643,1658,', '2', '0', 'changzhoushi', '0', '0');
INSERT INTO `district` VALUES ('1659', '天宁区', '1658', ',1643,1658,1659,', '3', '0', 'tianningqu', '0', '0');
INSERT INTO `district` VALUES ('1660', '钟楼区', '1658', ',1643,1658,1660,', '3', '0', 'zhonglouqu', '0', '0');
INSERT INTO `district` VALUES ('1661', '戚墅堰区', '1658', ',1643,1658,1661,', '3', '0', 'qishuyanqu', '0', '0');
INSERT INTO `district` VALUES ('1662', '新北区', '1658', ',1643,1658,1662,', '3', '0', 'xinbeiqu', '0', '0');
INSERT INTO `district` VALUES ('1663', '武进区', '1658', ',1643,1658,1663,', '3', '0', 'wujinqu', '0', '0');
INSERT INTO `district` VALUES ('1664', '溧阳市', '1658', ',1643,1658,1664,', '3', '0', 'yangshi', '0', '0');
INSERT INTO `district` VALUES ('1665', '金坛市', '1658', ',1643,1658,1665,', '3', '0', 'jintanshi', '0', '0');
INSERT INTO `district` VALUES ('1666', '淮安市', '1643', ',1643,1666,', '2', '0', 'huaianshi', '0', '0');
INSERT INTO `district` VALUES ('1667', '清河区', '1666', ',1643,1666,1667,', '3', '0', 'qinghequ', '0', '0');
INSERT INTO `district` VALUES ('1668', '楚州区', '1666', ',1643,1666,1668,', '3', '0', 'chuzhouqu', '0', '0');
INSERT INTO `district` VALUES ('1669', '淮阴区', '1666', ',1643,1666,1669,', '3', '0', 'huaiyinqu', '0', '0');
INSERT INTO `district` VALUES ('1670', '清浦区', '1666', ',1643,1666,1670,', '3', '0', 'qingpuqu', '0', '0');
INSERT INTO `district` VALUES ('1671', '涟水县', '1666', ',1643,1666,1671,', '3', '0', 'lianshuixian', '0', '0');
INSERT INTO `district` VALUES ('1672', '洪泽县', '1666', ',1643,1666,1672,', '3', '0', 'hongzexian', '0', '0');
INSERT INTO `district` VALUES ('1673', '盱眙县', '1666', ',1643,1666,1673,', '3', '0', 'xian', '0', '0');
INSERT INTO `district` VALUES ('1674', '金湖县', '1666', ',1643,1666,1674,', '3', '0', 'jinhuxian', '0', '0');
INSERT INTO `district` VALUES ('1675', '连云港市', '1643', ',1643,1675,', '2', '0', 'lianyungangshi', '0', '0');
INSERT INTO `district` VALUES ('1676', '连云区', '1675', ',1643,1675,1676,', '3', '0', 'lianyunqu', '0', '0');
INSERT INTO `district` VALUES ('1677', '新浦区', '1675', ',1643,1675,1677,', '3', '0', 'xinpuqu', '0', '0');
INSERT INTO `district` VALUES ('1678', '海州区', '1675', ',1643,1675,1678,', '3', '0', 'haizhouqu', '0', '0');
INSERT INTO `district` VALUES ('1679', '赣榆县', '1675', ',1643,1675,1679,', '3', '0', 'ganyuxian', '0', '0');
INSERT INTO `district` VALUES ('1680', '东海县', '1675', ',1643,1675,1680,', '3', '0', 'donghaixian', '0', '0');
INSERT INTO `district` VALUES ('1681', '灌云县', '1675', ',1643,1675,1681,', '3', '0', 'guanyunxian', '0', '0');
INSERT INTO `district` VALUES ('1682', '灌南县', '1675', ',1643,1675,1682,', '3', '0', 'guannanxian', '0', '0');
INSERT INTO `district` VALUES ('1683', '南通市', '1643', ',1643,1683,', '2', '0', 'nantongshi', '0', '0');
INSERT INTO `district` VALUES ('1684', '崇川区', '1683', ',1643,1683,1684,', '3', '0', 'chongchuanqu', '0', '0');
INSERT INTO `district` VALUES ('1685', '港闸区', '1683', ',1643,1683,1685,', '3', '0', 'gangzhaqu', '0', '0');
INSERT INTO `district` VALUES ('1686', '海安县', '1683', ',1643,1683,1686,', '3', '0', 'haianxian', '0', '0');
INSERT INTO `district` VALUES ('1687', '如东县', '1683', ',1643,1683,1687,', '3', '0', 'rudongxian', '0', '0');
INSERT INTO `district` VALUES ('1688', '启东市', '1683', ',1643,1683,1688,', '3', '0', 'qidongshi', '0', '0');
INSERT INTO `district` VALUES ('1689', '如皋市', '1683', ',1643,1683,1689,', '3', '0', 'rugaoshi', '0', '0');
INSERT INTO `district` VALUES ('1690', '通州市', '1683', ',1643,1683,1690,', '3', '0', 'tongzhoushi', '0', '0');
INSERT INTO `district` VALUES ('1691', '海门市', '1683', ',1643,1683,1691,', '3', '0', 'haimenshi', '0', '0');
INSERT INTO `district` VALUES ('1692', '苏州市', '1643', ',1643,1692,', '2', '0', 'suzhoushi', '0', '0');
INSERT INTO `district` VALUES ('1693', '沧浪区', '1692', ',1643,1692,1693,', '3', '0', 'canglangqu', '0', '0');
INSERT INTO `district` VALUES ('1694', '平江区', '1692', ',1643,1692,1694,', '3', '0', 'pingjiangqu', '0', '0');
INSERT INTO `district` VALUES ('1695', '金阊区', '1692', ',1643,1692,1695,', '3', '0', 'jinqu', '0', '0');
INSERT INTO `district` VALUES ('1696', '虎丘区', '1692', ',1643,1692,1696,', '3', '0', 'huqiuqu', '0', '0');
INSERT INTO `district` VALUES ('1697', '吴中区', '1692', ',1643,1692,1697,', '3', '0', 'wuzhongqu', '0', '0');
INSERT INTO `district` VALUES ('1698', '相城区', '1692', ',1643,1692,1698,', '3', '0', 'xiangchengqu', '0', '0');
INSERT INTO `district` VALUES ('1699', '常熟市', '1692', ',1643,1692,1699,', '3', '0', 'changshushi', '0', '0');
INSERT INTO `district` VALUES ('1700', '张家港市', '1692', ',1643,1692,1700,', '3', '0', 'zhangjiagangshi', '0', '0');
INSERT INTO `district` VALUES ('1701', '昆山市', '1692', ',1643,1692,1701,', '3', '0', 'kunshanshi', '0', '0');
INSERT INTO `district` VALUES ('1702', '吴江市', '1692', ',1643,1692,1702,', '3', '0', 'wujiangshi', '0', '0');
INSERT INTO `district` VALUES ('1703', '太仓市', '1692', ',1643,1692,1703,', '3', '0', 'taicangshi', '0', '0');
INSERT INTO `district` VALUES ('1704', '宿迁市', '1643', ',1643,1704,', '2', '0', 'suqianshi', '0', '0');
INSERT INTO `district` VALUES ('1705', '宿城区', '1704', ',1643,1704,1705,', '3', '0', 'suchengqu', '0', '0');
INSERT INTO `district` VALUES ('1706', '宿豫区', '1704', ',1643,1704,1706,', '3', '0', 'suyuqu', '0', '0');
INSERT INTO `district` VALUES ('1707', '沭阳县', '1704', ',1643,1704,1707,', '3', '0', 'yangxian', '0', '0');
INSERT INTO `district` VALUES ('1708', '泗阳县', '1704', ',1643,1704,1708,', '3', '0', 'yangxian', '0', '0');
INSERT INTO `district` VALUES ('1709', '泗洪县', '1704', ',1643,1704,1709,', '3', '0', 'hongxian', '0', '0');
INSERT INTO `district` VALUES ('1710', '泰州市', '1643', ',1643,1710,', '2', '0', 'taizhoushi', '0', '0');
INSERT INTO `district` VALUES ('1711', '海陵区', '1710', ',1643,1710,1711,', '3', '0', 'hailingqu', '0', '0');
INSERT INTO `district` VALUES ('1712', '高港区', '1710', ',1643,1710,1712,', '3', '0', 'gaogangqu', '0', '0');
INSERT INTO `district` VALUES ('1713', '兴化市', '1710', ',1643,1710,1713,', '3', '0', 'xinghuashi', '0', '0');
INSERT INTO `district` VALUES ('1714', '靖江市', '1710', ',1643,1710,1714,', '3', '0', 'jingjiangshi', '0', '0');
INSERT INTO `district` VALUES ('1715', '泰兴市', '1710', ',1643,1710,1715,', '3', '0', 'taixingshi', '0', '0');
INSERT INTO `district` VALUES ('1716', '姜堰市', '1710', ',1643,1710,1716,', '3', '0', 'jiangyanshi', '0', '0');
INSERT INTO `district` VALUES ('1717', '无锡市', '1643', ',1643,1717,', '2', '0', 'wuxishi', '0', '0');
INSERT INTO `district` VALUES ('1718', '崇安区', '1717', ',1643,1717,1718,', '3', '0', 'chonganqu', '0', '0');
INSERT INTO `district` VALUES ('1719', '南长区', '1717', ',1643,1717,1719,', '3', '0', 'nanchangqu', '0', '0');
INSERT INTO `district` VALUES ('1720', '北塘区', '1717', ',1643,1717,1720,', '3', '0', 'beitangqu', '0', '0');
INSERT INTO `district` VALUES ('1721', '锡山区', '1717', ',1643,1717,1721,', '3', '0', 'xishanqu', '0', '0');
INSERT INTO `district` VALUES ('1722', '惠山区', '1717', ',1643,1717,1722,', '3', '0', 'huishanqu', '0', '0');
INSERT INTO `district` VALUES ('1723', '滨湖区', '1717', ',1643,1717,1723,', '3', '0', 'binhuqu', '0', '0');
INSERT INTO `district` VALUES ('1724', '江阴市', '1717', ',1643,1717,1724,', '3', '0', 'jiangyinshi', '0', '0');
INSERT INTO `district` VALUES ('1725', '宜兴市', '1717', ',1643,1717,1725,', '3', '0', 'yixingshi', '0', '0');
INSERT INTO `district` VALUES ('1726', '徐州市', '1643', ',1643,1726,', '2', '0', 'xuzhoushi', '0', '0');
INSERT INTO `district` VALUES ('1727', '鼓楼区', '1726', ',1643,1726,1727,', '3', '0', 'gulouqu', '0', '0');
INSERT INTO `district` VALUES ('1728', '云龙区', '1726', ',1643,1726,1728,', '3', '0', 'yunlongqu', '0', '0');
INSERT INTO `district` VALUES ('1729', '九里区', '1726', ',1643,1726,1729,', '3', '0', 'jiuliqu', '0', '0');
INSERT INTO `district` VALUES ('1730', '贾汪区', '1726', ',1643,1726,1730,', '3', '0', 'jiawangqu', '0', '0');
INSERT INTO `district` VALUES ('1731', '泉山区', '1726', ',1643,1726,1731,', '3', '0', 'quanshanqu', '0', '0');
INSERT INTO `district` VALUES ('1732', '丰县', '1726', ',1643,1726,1732,', '3', '0', 'fengxian', '0', '0');
INSERT INTO `district` VALUES ('1733', '沛县', '1726', ',1643,1726,1733,', '3', '0', 'peixian', '0', '0');
INSERT INTO `district` VALUES ('1734', '铜山县', '1726', ',1643,1726,1734,', '3', '0', 'tongshanxian', '0', '0');
INSERT INTO `district` VALUES ('1735', '睢宁县', '1726', ',1643,1726,1735,', '3', '0', 'ningxian', '0', '0');
INSERT INTO `district` VALUES ('1736', '新沂市', '1726', ',1643,1726,1736,', '3', '0', 'xinyishi', '0', '0');
INSERT INTO `district` VALUES ('1737', '邳州市', '1726', ',1643,1726,1737,', '3', '0', 'zhoushi', '0', '0');
INSERT INTO `district` VALUES ('1738', '盐城市', '1643', ',1643,1738,', '2', '0', 'yanchengshi', '0', '0');
INSERT INTO `district` VALUES ('1739', '亭湖区', '1738', ',1643,1738,1739,', '3', '0', 'tinghuqu', '0', '0');
INSERT INTO `district` VALUES ('1740', '盐都区', '1738', ',1643,1738,1740,', '3', '0', 'yanduqu', '0', '0');
INSERT INTO `district` VALUES ('1741', '响水县', '1738', ',1643,1738,1741,', '3', '0', 'xiangshuixian', '0', '0');
INSERT INTO `district` VALUES ('1742', '滨海县', '1738', ',1643,1738,1742,', '3', '0', 'binhaixian', '0', '0');
INSERT INTO `district` VALUES ('1743', '阜宁县', '1738', ',1643,1738,1743,', '3', '0', 'funingxian', '0', '0');
INSERT INTO `district` VALUES ('1744', '射阳县', '1738', ',1643,1738,1744,', '3', '0', 'sheyangxian', '0', '0');
INSERT INTO `district` VALUES ('1745', '建湖县', '1738', ',1643,1738,1745,', '3', '0', 'jianhuxian', '0', '0');
INSERT INTO `district` VALUES ('1746', '东台市', '1738', ',1643,1738,1746,', '3', '0', 'dongtaishi', '0', '0');
INSERT INTO `district` VALUES ('1747', '大丰市', '1738', ',1643,1738,1747,', '3', '0', 'dafengshi', '0', '0');
INSERT INTO `district` VALUES ('1748', '扬州市', '1643', ',1643,1748,', '2', '0', 'yangzhoushi', '0', '0');
INSERT INTO `district` VALUES ('1749', '广陵区', '1748', ',1643,1748,1749,', '3', '0', 'guanglingqu', '0', '0');
INSERT INTO `district` VALUES ('1750', '邗江区', '1748', ',1643,1748,1750,', '3', '0', 'jiangqu', '0', '0');
INSERT INTO `district` VALUES ('1751', '郊区', '1748', ',1643,1748,1751,', '3', '0', 'jiaoqu', '0', '0');
INSERT INTO `district` VALUES ('1752', '宝应县', '1748', ',1643,1748,1752,', '3', '0', 'baoyingxian', '0', '0');
INSERT INTO `district` VALUES ('1753', '仪征市', '1748', ',1643,1748,1753,', '3', '0', 'yizhengshi', '0', '0');
INSERT INTO `district` VALUES ('1754', '高邮市', '1748', ',1643,1748,1754,', '3', '0', 'gaoyoushi', '0', '0');
INSERT INTO `district` VALUES ('1755', '江都市', '1748', ',1643,1748,1755,', '3', '0', 'jiangdushi', '0', '0');
INSERT INTO `district` VALUES ('1756', '镇江市', '1643', ',1643,1756,', '2', '0', 'zhenjiangshi', '0', '0');
INSERT INTO `district` VALUES ('1757', '京口区', '1756', ',1643,1756,1757,', '3', '0', 'jingkouqu', '0', '0');
INSERT INTO `district` VALUES ('1758', '润州区', '1756', ',1643,1756,1758,', '3', '0', 'runzhouqu', '0', '0');
INSERT INTO `district` VALUES ('1759', '丹徒区', '1756', ',1643,1756,1759,', '3', '0', 'dantuqu', '0', '0');
INSERT INTO `district` VALUES ('1760', '丹阳市', '1756', ',1643,1756,1760,', '3', '0', 'danyangshi', '0', '0');
INSERT INTO `district` VALUES ('1761', '扬中市', '1756', ',1643,1756,1761,', '3', '0', 'yangzhongshi', '0', '0');
INSERT INTO `district` VALUES ('1762', '句容市', '1756', ',1643,1756,1762,', '3', '0', 'jurongshi', '0', '0');
INSERT INTO `district` VALUES ('1763', '江西省', '0', ',1763,', '1', '0', 'jiangxisheng', '0', '0');
INSERT INTO `district` VALUES ('1764', '南昌市', '1763', ',1763,1764,', '2', '0', 'nanchangshi', '0', '0');
INSERT INTO `district` VALUES ('1765', '东湖区', '1764', ',1763,1764,1765,', '3', '0', 'donghuqu', '0', '0');
INSERT INTO `district` VALUES ('1766', '西湖区', '1764', ',1763,1764,1766,', '3', '0', 'xihuqu', '0', '0');
INSERT INTO `district` VALUES ('1767', '青云谱区', '1764', ',1763,1764,1767,', '3', '0', 'qingyunpuqu', '0', '0');
INSERT INTO `district` VALUES ('1768', '湾里区', '1764', ',1763,1764,1768,', '3', '0', 'wanliqu', '0', '0');
INSERT INTO `district` VALUES ('1769', '青山湖区', '1764', ',1763,1764,1769,', '3', '0', 'qingshanhuqu', '0', '0');
INSERT INTO `district` VALUES ('1770', '南昌县', '1764', ',1763,1764,1770,', '3', '0', 'nanchangxian', '0', '0');
INSERT INTO `district` VALUES ('1771', '新建县', '1764', ',1763,1764,1771,', '3', '0', 'xinjianxian', '0', '0');
INSERT INTO `district` VALUES ('1772', '安义县', '1764', ',1763,1764,1772,', '3', '0', 'anyixian', '0', '0');
INSERT INTO `district` VALUES ('1773', '进贤县', '1764', ',1763,1764,1773,', '3', '0', 'jinxianxian', '0', '0');
INSERT INTO `district` VALUES ('1774', '抚州市', '1763', ',1763,1774,', '2', '0', 'fuzhoushi', '0', '0');
INSERT INTO `district` VALUES ('1775', '临川区', '1774', ',1763,1774,1775,', '3', '0', 'linchuanqu', '0', '0');
INSERT INTO `district` VALUES ('1776', '南城县', '1774', ',1763,1774,1776,', '3', '0', 'nanchengxian', '0', '0');
INSERT INTO `district` VALUES ('1777', '黎川县', '1774', ',1763,1774,1777,', '3', '0', 'lichuanxian', '0', '0');
INSERT INTO `district` VALUES ('1778', '南丰县', '1774', ',1763,1774,1778,', '3', '0', 'nanfengxian', '0', '0');
INSERT INTO `district` VALUES ('1779', '崇仁县', '1774', ',1763,1774,1779,', '3', '0', 'chongrenxian', '0', '0');
INSERT INTO `district` VALUES ('1780', '乐安县', '1774', ',1763,1774,1780,', '3', '0', 'leanxian', '0', '0');
INSERT INTO `district` VALUES ('1781', '宜黄县', '1774', ',1763,1774,1781,', '3', '0', 'yihuangxian', '0', '0');
INSERT INTO `district` VALUES ('1782', '金溪县', '1774', ',1763,1774,1782,', '3', '0', 'jinxixian', '0', '0');
INSERT INTO `district` VALUES ('1783', '资溪县', '1774', ',1763,1774,1783,', '3', '0', 'zixixian', '0', '0');
INSERT INTO `district` VALUES ('1784', '东乡县', '1774', ',1763,1774,1784,', '3', '0', 'dongxiangxian', '0', '0');
INSERT INTO `district` VALUES ('1785', '广昌县', '1774', ',1763,1774,1785,', '3', '0', 'guangchangxian', '0', '0');
INSERT INTO `district` VALUES ('1786', '赣州市', '1763', ',1763,1786,', '2', '0', 'ganzhoushi', '0', '0');
INSERT INTO `district` VALUES ('1787', '章贡区', '1786', ',1763,1786,1787,', '3', '0', 'zhanggongqu', '0', '0');
INSERT INTO `district` VALUES ('1788', '赣县', '1786', ',1763,1786,1788,', '3', '0', 'ganxian', '0', '0');
INSERT INTO `district` VALUES ('1789', '信丰县', '1786', ',1763,1786,1789,', '3', '0', 'xinfengxian', '0', '0');
INSERT INTO `district` VALUES ('1790', '大余县', '1786', ',1763,1786,1790,', '3', '0', 'dayuxian', '0', '0');
INSERT INTO `district` VALUES ('1791', '上犹县', '1786', ',1763,1786,1791,', '3', '0', 'shangyouxian', '0', '0');
INSERT INTO `district` VALUES ('1792', '崇义县', '1786', ',1763,1786,1792,', '3', '0', 'chongyixian', '0', '0');
INSERT INTO `district` VALUES ('1793', '安远县', '1786', ',1763,1786,1793,', '3', '0', 'anyuanxian', '0', '0');
INSERT INTO `district` VALUES ('1794', '龙南县', '1786', ',1763,1786,1794,', '3', '0', 'longnanxian', '0', '0');
INSERT INTO `district` VALUES ('1795', '定南县', '1786', ',1763,1786,1795,', '3', '0', 'dingnanxian', '0', '0');
INSERT INTO `district` VALUES ('1796', '全南县', '1786', ',1763,1786,1796,', '3', '0', 'quannanxian', '0', '0');
INSERT INTO `district` VALUES ('1797', '宁都县', '1786', ',1763,1786,1797,', '3', '0', 'ningduxian', '0', '0');
INSERT INTO `district` VALUES ('1798', '于都县', '1786', ',1763,1786,1798,', '3', '0', 'yuduxian', '0', '0');
INSERT INTO `district` VALUES ('1799', '兴国县', '1786', ',1763,1786,1799,', '3', '0', 'xingguoxian', '0', '0');
INSERT INTO `district` VALUES ('1800', '会昌县', '1786', ',1763,1786,1800,', '3', '0', 'huichangxian', '0', '0');
INSERT INTO `district` VALUES ('1801', '寻乌县', '1786', ',1763,1786,1801,', '3', '0', 'xunwuxian', '0', '0');
INSERT INTO `district` VALUES ('1802', '石城县', '1786', ',1763,1786,1802,', '3', '0', 'shichengxian', '0', '0');
INSERT INTO `district` VALUES ('1803', '瑞金市', '1786', ',1763,1786,1803,', '3', '0', 'ruijinshi', '0', '0');
INSERT INTO `district` VALUES ('1804', '南康市', '1786', ',1763,1786,1804,', '3', '0', 'nankangshi', '0', '0');
INSERT INTO `district` VALUES ('1805', '吉安市', '1763', ',1763,1805,', '2', '0', 'jianshi', '0', '0');
INSERT INTO `district` VALUES ('1806', '吉州区', '1805', ',1763,1805,1806,', '3', '0', 'jizhouqu', '0', '0');
INSERT INTO `district` VALUES ('1807', '青原区', '1805', ',1763,1805,1807,', '3', '0', 'qingyuanqu', '0', '0');
INSERT INTO `district` VALUES ('1808', '吉安县', '1805', ',1763,1805,1808,', '3', '0', 'jianxian', '0', '0');
INSERT INTO `district` VALUES ('1809', '吉水县', '1805', ',1763,1805,1809,', '3', '0', 'jishuixian', '0', '0');
INSERT INTO `district` VALUES ('1810', '峡江县', '1805', ',1763,1805,1810,', '3', '0', 'xiajiangxian', '0', '0');
INSERT INTO `district` VALUES ('1811', '新干县', '1805', ',1763,1805,1811,', '3', '0', 'xinganxian', '0', '0');
INSERT INTO `district` VALUES ('1812', '永丰县', '1805', ',1763,1805,1812,', '3', '0', 'yongfengxian', '0', '0');
INSERT INTO `district` VALUES ('1813', '泰和县', '1805', ',1763,1805,1813,', '3', '0', 'taihexian', '0', '0');
INSERT INTO `district` VALUES ('1814', '遂川县', '1805', ',1763,1805,1814,', '3', '0', 'suichuanxian', '0', '0');
INSERT INTO `district` VALUES ('1815', '万安县', '1805', ',1763,1805,1815,', '3', '0', 'wananxian', '0', '0');
INSERT INTO `district` VALUES ('1816', '安福县', '1805', ',1763,1805,1816,', '3', '0', 'anfuxian', '0', '0');
INSERT INTO `district` VALUES ('1817', '永新县', '1805', ',1763,1805,1817,', '3', '0', 'yongxinxian', '0', '0');
INSERT INTO `district` VALUES ('1818', '井冈山市', '1805', ',1763,1805,1818,', '3', '0', 'jinggangshanshi', '0', '0');
INSERT INTO `district` VALUES ('1819', '景德镇市', '1763', ',1763,1819,', '2', '0', 'jingdezhenshi', '0', '0');
INSERT INTO `district` VALUES ('1820', '昌江区', '1819', ',1763,1819,1820,', '3', '0', 'changjiangqu', '0', '0');
INSERT INTO `district` VALUES ('1821', '珠山区', '1819', ',1763,1819,1821,', '3', '0', 'zhushanqu', '0', '0');
INSERT INTO `district` VALUES ('1822', '浮梁县', '1819', ',1763,1819,1822,', '3', '0', 'fuliangxian', '0', '0');
INSERT INTO `district` VALUES ('1823', '乐平市', '1819', ',1763,1819,1823,', '3', '0', 'lepingshi', '0', '0');
INSERT INTO `district` VALUES ('1824', '九江市', '1763', ',1763,1824,', '2', '0', 'jiujiangshi', '0', '0');
INSERT INTO `district` VALUES ('1825', '庐山区', '1824', ',1763,1824,1825,', '3', '0', 'lushanqu', '0', '0');
INSERT INTO `district` VALUES ('1826', '浔阳区', '1824', ',1763,1824,1826,', '3', '0', 'yangqu', '0', '0');
INSERT INTO `district` VALUES ('1827', '九江县', '1824', ',1763,1824,1827,', '3', '0', 'jiujiangxian', '0', '0');
INSERT INTO `district` VALUES ('1828', '武宁县', '1824', ',1763,1824,1828,', '3', '0', 'wuningxian', '0', '0');
INSERT INTO `district` VALUES ('1829', '修水县', '1824', ',1763,1824,1829,', '3', '0', 'xiushuixian', '0', '0');
INSERT INTO `district` VALUES ('1830', '永修县', '1824', ',1763,1824,1830,', '3', '0', 'yongxiuxian', '0', '0');
INSERT INTO `district` VALUES ('1831', '德安县', '1824', ',1763,1824,1831,', '3', '0', 'deanxian', '0', '0');
INSERT INTO `district` VALUES ('1832', '星子县', '1824', ',1763,1824,1832,', '3', '0', 'xingzixian', '0', '0');
INSERT INTO `district` VALUES ('1833', '都昌县', '1824', ',1763,1824,1833,', '3', '0', 'duchangxian', '0', '0');
INSERT INTO `district` VALUES ('1834', '湖口县', '1824', ',1763,1824,1834,', '3', '0', 'hukouxian', '0', '0');
INSERT INTO `district` VALUES ('1835', '彭泽县', '1824', ',1763,1824,1835,', '3', '0', 'pengzexian', '0', '0');
INSERT INTO `district` VALUES ('1836', '瑞昌市', '1824', ',1763,1824,1836,', '3', '0', 'ruichangshi', '0', '0');
INSERT INTO `district` VALUES ('1837', '萍乡市', '1763', ',1763,1837,', '2', '0', 'pingxiangshi', '0', '0');
INSERT INTO `district` VALUES ('1838', '安源区', '1837', ',1763,1837,1838,', '3', '0', 'anyuanqu', '0', '0');
INSERT INTO `district` VALUES ('1839', '湘东区', '1837', ',1763,1837,1839,', '3', '0', 'xiangdongqu', '0', '0');
INSERT INTO `district` VALUES ('1840', '莲花县', '1837', ',1763,1837,1840,', '3', '0', 'lianhuaxian', '0', '0');
INSERT INTO `district` VALUES ('1841', '上栗县', '1837', ',1763,1837,1841,', '3', '0', 'shanglixian', '0', '0');
INSERT INTO `district` VALUES ('1842', '芦溪县', '1837', ',1763,1837,1842,', '3', '0', 'luxixian', '0', '0');
INSERT INTO `district` VALUES ('1843', '上饶市', '1763', ',1763,1843,', '2', '0', 'shangraoshi', '0', '0');
INSERT INTO `district` VALUES ('1844', '信州区', '1843', ',1763,1843,1844,', '3', '0', 'xinzhouqu', '0', '0');
INSERT INTO `district` VALUES ('1845', '上饶县', '1843', ',1763,1843,1845,', '3', '0', 'shangraoxian', '0', '0');
INSERT INTO `district` VALUES ('1846', '广丰县', '1843', ',1763,1843,1846,', '3', '0', 'guangfengxian', '0', '0');
INSERT INTO `district` VALUES ('1847', '玉山县', '1843', ',1763,1843,1847,', '3', '0', 'yushanxian', '0', '0');
INSERT INTO `district` VALUES ('1848', '铅山县', '1843', ',1763,1843,1848,', '3', '0', 'qianshanxian', '0', '0');
INSERT INTO `district` VALUES ('1849', '横峰县', '1843', ',1763,1843,1849,', '3', '0', 'hengfengxian', '0', '0');
INSERT INTO `district` VALUES ('1850', '弋阳县', '1843', ',1763,1843,1850,', '3', '0', 'yangxian', '0', '0');
INSERT INTO `district` VALUES ('1851', '余干县', '1843', ',1763,1843,1851,', '3', '0', 'yuganxian', '0', '0');
INSERT INTO `district` VALUES ('1852', '鄱阳县', '1843', ',1763,1843,1852,', '3', '0', 'yangxian', '0', '0');
INSERT INTO `district` VALUES ('1853', '万年县', '1843', ',1763,1843,1853,', '3', '0', 'wannianxian', '0', '0');
INSERT INTO `district` VALUES ('1854', '婺源县', '1843', ',1763,1843,1854,', '3', '0', 'yuanxian', '0', '0');
INSERT INTO `district` VALUES ('1855', '德兴市', '1843', ',1763,1843,1855,', '3', '0', 'dexingshi', '0', '0');
INSERT INTO `district` VALUES ('1856', '新余市', '1763', ',1763,1856,', '2', '0', 'xinyushi', '0', '0');
INSERT INTO `district` VALUES ('1857', '渝水区', '1856', ',1763,1856,1857,', '3', '0', 'yushuiqu', '0', '0');
INSERT INTO `district` VALUES ('1858', '分宜县', '1856', ',1763,1856,1858,', '3', '0', 'fenyixian', '0', '0');
INSERT INTO `district` VALUES ('1859', '宜春市', '1763', ',1763,1859,', '2', '0', 'yichunshi', '0', '0');
INSERT INTO `district` VALUES ('1860', '袁州区', '1859', ',1763,1859,1860,', '3', '0', 'yuanzhouqu', '0', '0');
INSERT INTO `district` VALUES ('1861', '奉新县', '1859', ',1763,1859,1861,', '3', '0', 'fengxinxian', '0', '0');
INSERT INTO `district` VALUES ('1862', '万载县', '1859', ',1763,1859,1862,', '3', '0', 'wanzaixian', '0', '0');
INSERT INTO `district` VALUES ('1863', '上高县', '1859', ',1763,1859,1863,', '3', '0', 'shanggaoxian', '0', '0');
INSERT INTO `district` VALUES ('1864', '宜丰县', '1859', ',1763,1859,1864,', '3', '0', 'yifengxian', '0', '0');
INSERT INTO `district` VALUES ('1865', '靖安县', '1859', ',1763,1859,1865,', '3', '0', 'jinganxian', '0', '0');
INSERT INTO `district` VALUES ('1866', '铜鼓县', '1859', ',1763,1859,1866,', '3', '0', 'tongguxian', '0', '0');
INSERT INTO `district` VALUES ('1867', '丰城市', '1859', ',1763,1859,1867,', '3', '0', 'fengchengshi', '0', '0');
INSERT INTO `district` VALUES ('1868', '樟树市', '1859', ',1763,1859,1868,', '3', '0', 'zhangshushi', '0', '0');
INSERT INTO `district` VALUES ('1869', '高安市', '1859', ',1763,1859,1869,', '3', '0', 'gaoanshi', '0', '0');
INSERT INTO `district` VALUES ('1870', '鹰潭市', '1763', ',1763,1870,', '2', '0', 'yingtanshi', '0', '0');
INSERT INTO `district` VALUES ('1871', '月湖区', '1870', ',1763,1870,1871,', '3', '0', 'yuehuqu', '0', '0');
INSERT INTO `district` VALUES ('1872', '余江县', '1870', ',1763,1870,1872,', '3', '0', 'yujiangxian', '0', '0');
INSERT INTO `district` VALUES ('1873', '贵溪市', '1870', ',1763,1870,1873,', '3', '0', 'guixishi', '0', '0');
INSERT INTO `district` VALUES ('1874', '辽宁省', '0', ',1874,', '1', '0', 'liaoningsheng', '0', '0');
INSERT INTO `district` VALUES ('1875', '沈阳市', '1874', ',1874,1875,', '2', '0', 'shenyangshi', '0', '0');
INSERT INTO `district` VALUES ('1876', '和平区', '1875', ',1874,1875,1876,', '3', '0', 'hepingqu', '0', '0');
INSERT INTO `district` VALUES ('1877', '沈河区', '1875', ',1874,1875,1877,', '3', '0', 'shenhequ', '0', '0');
INSERT INTO `district` VALUES ('1878', '大东区', '1875', ',1874,1875,1878,', '3', '0', 'dadongqu', '0', '0');
INSERT INTO `district` VALUES ('1879', '皇姑区', '1875', ',1874,1875,1879,', '3', '0', 'huangguqu', '0', '0');
INSERT INTO `district` VALUES ('1880', '铁西区', '1875', ',1874,1875,1880,', '3', '0', 'tiexiqu', '0', '0');
INSERT INTO `district` VALUES ('1881', '苏家屯区', '1875', ',1874,1875,1881,', '3', '0', 'sujiatunqu', '0', '0');
INSERT INTO `district` VALUES ('1882', '东陵区', '1875', ',1874,1875,1882,', '3', '0', 'donglingqu', '0', '0');
INSERT INTO `district` VALUES ('1883', '新城子区', '1875', ',1874,1875,1883,', '3', '0', 'xinchengziqu', '0', '0');
INSERT INTO `district` VALUES ('1884', '于洪区', '1875', ',1874,1875,1884,', '3', '0', 'yuhongqu', '0', '0');
INSERT INTO `district` VALUES ('1885', '辽中县', '1875', ',1874,1875,1885,', '3', '0', 'liaozhongxian', '0', '0');
INSERT INTO `district` VALUES ('1886', '康平县', '1875', ',1874,1875,1886,', '3', '0', 'kangpingxian', '0', '0');
INSERT INTO `district` VALUES ('1887', '法库县', '1875', ',1874,1875,1887,', '3', '0', 'fakuxian', '0', '0');
INSERT INTO `district` VALUES ('1888', '新民市', '1875', ',1874,1875,1888,', '3', '0', 'xinminshi', '0', '0');
INSERT INTO `district` VALUES ('1889', '鞍山市', '1874', ',1874,1889,', '2', '0', 'anshanshi', '0', '0');
INSERT INTO `district` VALUES ('1890', '铁东区', '1889', ',1874,1889,1890,', '3', '0', 'tiedongqu', '0', '0');
INSERT INTO `district` VALUES ('1891', '铁西区', '1889', ',1874,1889,1891,', '3', '0', 'tiexiqu', '0', '0');
INSERT INTO `district` VALUES ('1892', '立山区', '1889', ',1874,1889,1892,', '3', '0', 'lishanqu', '0', '0');
INSERT INTO `district` VALUES ('1893', '千山区', '1889', ',1874,1889,1893,', '3', '0', 'qianshanqu', '0', '0');
INSERT INTO `district` VALUES ('1894', '台安县', '1889', ',1874,1889,1894,', '3', '0', 'taianxian', '0', '0');
INSERT INTO `district` VALUES ('1895', '岫岩满族自治县', '1889', ',1874,1889,1895,', '3', '0', 'yanmanzuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('1896', '海城市', '1889', ',1874,1889,1896,', '3', '0', 'haichengshi', '0', '0');
INSERT INTO `district` VALUES ('1897', '本溪市', '1874', ',1874,1897,', '2', '0', 'benxishi', '0', '0');
INSERT INTO `district` VALUES ('1898', '平山区', '1897', ',1874,1897,1898,', '3', '0', 'pingshanqu', '0', '0');
INSERT INTO `district` VALUES ('1899', '溪湖区', '1897', ',1874,1897,1899,', '3', '0', 'xihuqu', '0', '0');
INSERT INTO `district` VALUES ('1900', '明山区', '1897', ',1874,1897,1900,', '3', '0', 'mingshanqu', '0', '0');
INSERT INTO `district` VALUES ('1901', '南芬区', '1897', ',1874,1897,1901,', '3', '0', 'nanfenqu', '0', '0');
INSERT INTO `district` VALUES ('1902', '本溪满族自治县', '1897', ',1874,1897,1902,', '3', '0', 'benximanzuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('1903', '桓仁满族自治县', '1897', ',1874,1897,1903,', '3', '0', 'huanrenmanzuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('1904', '朝阳市', '1874', ',1874,1904,', '2', '0', 'chaoyangshi', '0', '0');
INSERT INTO `district` VALUES ('1905', '双塔区', '1904', ',1874,1904,1905,', '3', '0', 'shuangtaqu', '0', '0');
INSERT INTO `district` VALUES ('1906', '龙城区', '1904', ',1874,1904,1906,', '3', '0', 'longchengqu', '0', '0');
INSERT INTO `district` VALUES ('1907', '朝阳县', '1904', ',1874,1904,1907,', '3', '0', 'chaoyangxian', '0', '0');
INSERT INTO `district` VALUES ('1908', '建平县', '1904', ',1874,1904,1908,', '3', '0', 'jianpingxian', '0', '0');
INSERT INTO `district` VALUES ('1909', '喀喇沁左翼蒙古族自治县', '1904', ',1874,1904,1909,', '3', '0', 'kalaqinzuoyimengguzuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('1910', '北票市', '1904', ',1874,1904,1910,', '3', '0', 'beipiaoshi', '0', '0');
INSERT INTO `district` VALUES ('1911', '凌源市', '1904', ',1874,1904,1911,', '3', '0', 'lingyuanshi', '0', '0');
INSERT INTO `district` VALUES ('1912', '大连市', '1874', ',1874,1912,', '2', '0', 'dalianshi', '0', '0');
INSERT INTO `district` VALUES ('1913', '中山区', '1912', ',1874,1912,1913,', '3', '0', 'zhongshanqu', '0', '0');
INSERT INTO `district` VALUES ('1914', '西岗区', '1912', ',1874,1912,1914,', '3', '0', 'xigangqu', '0', '0');
INSERT INTO `district` VALUES ('1915', '沙河口区', '1912', ',1874,1912,1915,', '3', '0', 'shahekouqu', '0', '0');
INSERT INTO `district` VALUES ('1916', '甘井子区', '1912', ',1874,1912,1916,', '3', '0', 'ganjingziqu', '0', '0');
INSERT INTO `district` VALUES ('1917', '旅顺口区', '1912', ',1874,1912,1917,', '3', '0', 'lvshunkouqu', '0', '0');
INSERT INTO `district` VALUES ('1918', '金州区', '1912', ',1874,1912,1918,', '3', '0', 'jinzhouqu', '0', '0');
INSERT INTO `district` VALUES ('1919', '长海县', '1912', ',1874,1912,1919,', '3', '0', 'changhaixian', '0', '0');
INSERT INTO `district` VALUES ('1920', '瓦房店市', '1912', ',1874,1912,1920,', '3', '0', 'wafangdianshi', '0', '0');
INSERT INTO `district` VALUES ('1921', '普兰店市', '1912', ',1874,1912,1921,', '3', '0', 'pulandianshi', '0', '0');
INSERT INTO `district` VALUES ('1922', '庄河市', '1912', ',1874,1912,1922,', '3', '0', 'zhuangheshi', '0', '0');
INSERT INTO `district` VALUES ('1923', '丹东市', '1874', ',1874,1923,', '2', '0', 'dandongshi', '0', '0');
INSERT INTO `district` VALUES ('1924', '元宝区', '1923', ',1874,1923,1924,', '3', '0', 'yuanbaoqu', '0', '0');
INSERT INTO `district` VALUES ('1925', '振兴区', '1923', ',1874,1923,1925,', '3', '0', 'zhenxingqu', '0', '0');
INSERT INTO `district` VALUES ('1926', '振安区', '1923', ',1874,1923,1926,', '3', '0', 'zhenanqu', '0', '0');
INSERT INTO `district` VALUES ('1927', '宽甸满族自治县', '1923', ',1874,1923,1927,', '3', '0', 'kuandianmanzuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('1928', '东港市', '1923', ',1874,1923,1928,', '3', '0', 'donggangshi', '0', '0');
INSERT INTO `district` VALUES ('1929', '凤城市', '1923', ',1874,1923,1929,', '3', '0', 'fengchengshi', '0', '0');
INSERT INTO `district` VALUES ('1930', '抚顺市', '1874', ',1874,1930,', '2', '0', 'fushunshi', '0', '0');
INSERT INTO `district` VALUES ('1931', '新抚区', '1930', ',1874,1930,1931,', '3', '0', 'xinfuqu', '0', '0');
INSERT INTO `district` VALUES ('1932', '东洲区', '1930', ',1874,1930,1932,', '3', '0', 'dongzhouqu', '0', '0');
INSERT INTO `district` VALUES ('1933', '望花区', '1930', ',1874,1930,1933,', '3', '0', 'wanghuaqu', '0', '0');
INSERT INTO `district` VALUES ('1934', '顺城区', '1930', ',1874,1930,1934,', '3', '0', 'shunchengqu', '0', '0');
INSERT INTO `district` VALUES ('1935', '抚顺县', '1930', ',1874,1930,1935,', '3', '0', 'fushunxian', '0', '0');
INSERT INTO `district` VALUES ('1936', '新宾满族自治县', '1930', ',1874,1930,1936,', '3', '0', 'xinbinmanzuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('1937', '清原满族自治县', '1930', ',1874,1930,1937,', '3', '0', 'qingyuanmanzuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('1938', '阜新市', '1874', ',1874,1938,', '2', '0', 'fuxinshi', '0', '0');
INSERT INTO `district` VALUES ('1939', '海州区', '1938', ',1874,1938,1939,', '3', '0', 'haizhouqu', '0', '0');
INSERT INTO `district` VALUES ('1940', '新邱区', '1938', ',1874,1938,1940,', '3', '0', 'xinqiuqu', '0', '0');
INSERT INTO `district` VALUES ('1941', '太平区', '1938', ',1874,1938,1941,', '3', '0', 'taipingqu', '0', '0');
INSERT INTO `district` VALUES ('1942', '清河门区', '1938', ',1874,1938,1942,', '3', '0', 'qinghemenqu', '0', '0');
INSERT INTO `district` VALUES ('1943', '细河区', '1938', ',1874,1938,1943,', '3', '0', 'xihequ', '0', '0');
INSERT INTO `district` VALUES ('1944', '阜新蒙古族自治县', '1938', ',1874,1938,1944,', '3', '0', 'fuxinmengguzuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('1945', '彰武县', '1938', ',1874,1938,1945,', '3', '0', 'zhangwuxian', '0', '0');
INSERT INTO `district` VALUES ('1946', '葫芦岛市', '1874', ',1874,1946,', '2', '0', 'huludaoshi', '0', '0');
INSERT INTO `district` VALUES ('1947', '连山区', '1946', ',1874,1946,1947,', '3', '0', 'lianshanqu', '0', '0');
INSERT INTO `district` VALUES ('1948', '龙港区', '1946', ',1874,1946,1948,', '3', '0', 'longgangqu', '0', '0');
INSERT INTO `district` VALUES ('1949', '南票区', '1946', ',1874,1946,1949,', '3', '0', 'nanpiaoqu', '0', '0');
INSERT INTO `district` VALUES ('1950', '绥中县', '1946', ',1874,1946,1950,', '3', '0', 'suizhongxian', '0', '0');
INSERT INTO `district` VALUES ('1951', '建昌县', '1946', ',1874,1946,1951,', '3', '0', 'jianchangxian', '0', '0');
INSERT INTO `district` VALUES ('1952', '兴城市', '1946', ',1874,1946,1952,', '3', '0', 'xingchengshi', '0', '0');
INSERT INTO `district` VALUES ('1953', '锦州市', '1874', ',1874,1953,', '2', '0', 'jinzhoushi', '0', '0');
INSERT INTO `district` VALUES ('1954', '古塔区', '1953', ',1874,1953,1954,', '3', '0', 'gutaqu', '0', '0');
INSERT INTO `district` VALUES ('1955', '凌河区', '1953', ',1874,1953,1955,', '3', '0', 'linghequ', '0', '0');
INSERT INTO `district` VALUES ('1956', '太和区', '1953', ',1874,1953,1956,', '3', '0', 'taihequ', '0', '0');
INSERT INTO `district` VALUES ('1957', '黑山县', '1953', ',1874,1953,1957,', '3', '0', 'heishanxian', '0', '0');
INSERT INTO `district` VALUES ('1958', '义县', '1953', ',1874,1953,1958,', '3', '0', 'yixian', '0', '0');
INSERT INTO `district` VALUES ('1959', '凌海市', '1953', ',1874,1953,1959,', '3', '0', 'linghaishi', '0', '0');
INSERT INTO `district` VALUES ('1960', '北宁市', '1953', ',1874,1953,1960,', '3', '0', 'beiningshi', '0', '0');
INSERT INTO `district` VALUES ('1961', '辽阳市', '1874', ',1874,1961,', '2', '0', 'liaoyangshi', '0', '0');
INSERT INTO `district` VALUES ('1962', '白塔区', '1961', ',1874,1961,1962,', '3', '0', 'baitaqu', '0', '0');
INSERT INTO `district` VALUES ('1963', '文圣区', '1961', ',1874,1961,1963,', '3', '0', 'wenshengqu', '0', '0');
INSERT INTO `district` VALUES ('1964', '宏伟区', '1961', ',1874,1961,1964,', '3', '0', 'hongweiqu', '0', '0');
INSERT INTO `district` VALUES ('1965', '弓长岭区', '1961', ',1874,1961,1965,', '3', '0', 'gongchanglingqu', '0', '0');
INSERT INTO `district` VALUES ('1966', '太子河区', '1961', ',1874,1961,1966,', '3', '0', 'taizihequ', '0', '0');
INSERT INTO `district` VALUES ('1967', '辽阳县', '1961', ',1874,1961,1967,', '3', '0', 'liaoyangxian', '0', '0');
INSERT INTO `district` VALUES ('1968', '灯塔市', '1961', ',1874,1961,1968,', '3', '0', 'dengtashi', '0', '0');
INSERT INTO `district` VALUES ('1969', '盘锦市', '1874', ',1874,1969,', '2', '0', 'panjinshi', '0', '0');
INSERT INTO `district` VALUES ('1970', '双台子区', '1969', ',1874,1969,1970,', '3', '0', 'shuangtaiziqu', '0', '0');
INSERT INTO `district` VALUES ('1971', '兴隆台区', '1969', ',1874,1969,1971,', '3', '0', 'xinglongtaiqu', '0', '0');
INSERT INTO `district` VALUES ('1972', '大洼县', '1969', ',1874,1969,1972,', '3', '0', 'dawaxian', '0', '0');
INSERT INTO `district` VALUES ('1973', '盘山县', '1969', ',1874,1969,1973,', '3', '0', 'panshanxian', '0', '0');
INSERT INTO `district` VALUES ('1974', '铁岭市', '1874', ',1874,1974,', '2', '0', 'tielingshi', '0', '0');
INSERT INTO `district` VALUES ('1975', '银州区', '1974', ',1874,1974,1975,', '3', '0', 'yinzhouqu', '0', '0');
INSERT INTO `district` VALUES ('1976', '清河区', '1974', ',1874,1974,1976,', '3', '0', 'qinghequ', '0', '0');
INSERT INTO `district` VALUES ('1977', '铁岭县', '1974', ',1874,1974,1977,', '3', '0', 'tielingxian', '0', '0');
INSERT INTO `district` VALUES ('1978', '西丰县', '1974', ',1874,1974,1978,', '3', '0', 'xifengxian', '0', '0');
INSERT INTO `district` VALUES ('1979', '昌图县', '1974', ',1874,1974,1979,', '3', '0', 'changtuxian', '0', '0');
INSERT INTO `district` VALUES ('1980', '调兵山市', '1974', ',1874,1974,1980,', '3', '0', 'diaobingshanshi', '0', '0');
INSERT INTO `district` VALUES ('1981', '开原市', '1974', ',1874,1974,1981,', '3', '0', 'kaiyuanshi', '0', '0');
INSERT INTO `district` VALUES ('1982', '营口市', '1874', ',1874,1982,', '2', '0', 'yingkoushi', '0', '0');
INSERT INTO `district` VALUES ('1983', '站前区', '1982', ',1874,1982,1983,', '3', '0', 'zhanqianqu', '0', '0');
INSERT INTO `district` VALUES ('1984', '西市区', '1982', ',1874,1982,1984,', '3', '0', 'xishiqu', '0', '0');
INSERT INTO `district` VALUES ('1985', '鲅鱼圈区', '1982', ',1874,1982,1985,', '3', '0', 'yuquanqu', '0', '0');
INSERT INTO `district` VALUES ('1986', '老边区', '1982', ',1874,1982,1986,', '3', '0', 'laobianqu', '0', '0');
INSERT INTO `district` VALUES ('1987', '盖州市', '1982', ',1874,1982,1987,', '3', '0', 'gaizhoushi', '0', '0');
INSERT INTO `district` VALUES ('1988', '大石桥市', '1982', ',1874,1982,1988,', '3', '0', 'dashiqiaoshi', '0', '0');
INSERT INTO `district` VALUES ('1989', '内蒙古省', '0', ',1989,', '1', '0', 'neimenggusheng', '0', '0');
INSERT INTO `district` VALUES ('1990', '呼和浩特市', '1989', ',1989,1990,', '2', '0', 'huhehaoteshi', '0', '0');
INSERT INTO `district` VALUES ('1991', '新城区', '1990', ',1989,1990,1991,', '3', '0', 'xinchengqu', '0', '0');
INSERT INTO `district` VALUES ('1992', '回民区', '1990', ',1989,1990,1992,', '3', '0', 'huiminqu', '0', '0');
INSERT INTO `district` VALUES ('1993', '玉泉区', '1990', ',1989,1990,1993,', '3', '0', 'yuquanqu', '0', '0');
INSERT INTO `district` VALUES ('1994', '赛罕区', '1990', ',1989,1990,1994,', '3', '0', 'saihanqu', '0', '0');
INSERT INTO `district` VALUES ('1995', '土默特左旗', '1990', ',1989,1990,1995,', '3', '0', 'tumotezuoqi', '0', '0');
INSERT INTO `district` VALUES ('1996', '托克托县', '1990', ',1989,1990,1996,', '3', '0', 'tuoketuoxian', '0', '0');
INSERT INTO `district` VALUES ('1997', '和林格尔县', '1990', ',1989,1990,1997,', '3', '0', 'helingeerxian', '0', '0');
INSERT INTO `district` VALUES ('1998', '清水河县', '1990', ',1989,1990,1998,', '3', '0', 'qingshuihexian', '0', '0');
INSERT INTO `district` VALUES ('1999', '武川县', '1990', ',1989,1990,1999,', '3', '0', 'wuchuanxian', '0', '0');
INSERT INTO `district` VALUES ('2000', '阿拉善盟', '1989', ',1989,2000,', '2', '0', 'alashanmeng', '0', '0');
INSERT INTO `district` VALUES ('2001', '阿拉善左旗', '2000', ',1989,2000,2001,', '3', '0', 'alashanzuoqi', '0', '0');
INSERT INTO `district` VALUES ('2002', '阿拉善右旗', '2000', ',1989,2000,2002,', '3', '0', 'alashanyouqi', '0', '0');
INSERT INTO `district` VALUES ('2003', '额济纳旗', '2000', ',1989,2000,2003,', '3', '0', 'ejinaqi', '0', '0');
INSERT INTO `district` VALUES ('2004', '巴彦淖尔市', '1989', ',1989,2004,', '2', '0', 'bayannaoershi', '0', '0');
INSERT INTO `district` VALUES ('2005', '临河区', '2004', ',1989,2004,2005,', '3', '0', 'linhequ', '0', '0');
INSERT INTO `district` VALUES ('2006', '五原县', '2004', ',1989,2004,2006,', '3', '0', 'wuyuanxian', '0', '0');
INSERT INTO `district` VALUES ('2007', '磴口县', '2004', ',1989,2004,2007,', '3', '0', 'kouxian', '0', '0');
INSERT INTO `district` VALUES ('2008', '乌拉特前旗', '2004', ',1989,2004,2008,', '3', '0', 'wulateqianqi', '0', '0');
INSERT INTO `district` VALUES ('2009', '乌拉特中旗', '2004', ',1989,2004,2009,', '3', '0', 'wulatezhongqi', '0', '0');
INSERT INTO `district` VALUES ('2010', '乌拉特后旗', '2004', ',1989,2004,2010,', '3', '0', 'wulatehouqi', '0', '0');
INSERT INTO `district` VALUES ('2011', '杭锦后旗', '2004', ',1989,2004,2011,', '3', '0', 'hangjinhouqi', '0', '0');
INSERT INTO `district` VALUES ('2012', '包头市', '1989', ',1989,2012,', '2', '0', 'baotoushi', '0', '0');
INSERT INTO `district` VALUES ('2013', '东河区', '2012', ',1989,2012,2013,', '3', '0', 'donghequ', '0', '0');
INSERT INTO `district` VALUES ('2014', '昆都仑区', '2012', ',1989,2012,2014,', '3', '0', 'kundulunqu', '0', '0');
INSERT INTO `district` VALUES ('2015', '青山区', '2012', ',1989,2012,2015,', '3', '0', 'qingshanqu', '0', '0');
INSERT INTO `district` VALUES ('2016', '石拐区', '2012', ',1989,2012,2016,', '3', '0', 'shiguaiqu', '0', '0');
INSERT INTO `district` VALUES ('2017', '白云矿区', '2012', ',1989,2012,2017,', '3', '0', 'baiyunkuangqu', '0', '0');
INSERT INTO `district` VALUES ('2018', '九原区', '2012', ',1989,2012,2018,', '3', '0', 'jiuyuanqu', '0', '0');
INSERT INTO `district` VALUES ('2019', '土默特右旗', '2012', ',1989,2012,2019,', '3', '0', 'tumoteyouqi', '0', '0');
INSERT INTO `district` VALUES ('2020', '固阳县', '2012', ',1989,2012,2020,', '3', '0', 'guyangxian', '0', '0');
INSERT INTO `district` VALUES ('2021', '达尔罕茂明安联合旗', '2012', ',1989,2012,2021,', '3', '0', 'daerhanmaominganlianheqi', '0', '0');
INSERT INTO `district` VALUES ('2022', '赤峰市', '1989', ',1989,2022,', '2', '0', 'chifengshi', '0', '0');
INSERT INTO `district` VALUES ('2023', '红山区', '2022', ',1989,2022,2023,', '3', '0', 'hongshanqu', '0', '0');
INSERT INTO `district` VALUES ('2024', '元宝山区', '2022', ',1989,2022,2024,', '3', '0', 'yuanbaoshanqu', '0', '0');
INSERT INTO `district` VALUES ('2025', '松山区', '2022', ',1989,2022,2025,', '3', '0', 'songshanqu', '0', '0');
INSERT INTO `district` VALUES ('2026', '阿鲁科尔沁旗', '2022', ',1989,2022,2026,', '3', '0', 'alukeerqinqi', '0', '0');
INSERT INTO `district` VALUES ('2027', '巴林左旗', '2022', ',1989,2022,2027,', '3', '0', 'balinzuoqi', '0', '0');
INSERT INTO `district` VALUES ('2028', '巴林右旗', '2022', ',1989,2022,2028,', '3', '0', 'balinyouqi', '0', '0');
INSERT INTO `district` VALUES ('2029', '林西县', '2022', ',1989,2022,2029,', '3', '0', 'linxixian', '0', '0');
INSERT INTO `district` VALUES ('2030', '克什克腾旗', '2022', ',1989,2022,2030,', '3', '0', 'keshiketengqi', '0', '0');
INSERT INTO `district` VALUES ('2031', '翁牛特旗', '2022', ',1989,2022,2031,', '3', '0', 'wengniuteqi', '0', '0');
INSERT INTO `district` VALUES ('2032', '喀喇沁旗', '2022', ',1989,2022,2032,', '3', '0', 'kalaqinqi', '0', '0');
INSERT INTO `district` VALUES ('2033', '宁城县', '2022', ',1989,2022,2033,', '3', '0', 'ningchengxian', '0', '0');
INSERT INTO `district` VALUES ('2034', '敖汉旗', '2022', ',1989,2022,2034,', '3', '0', 'aohanqi', '0', '0');
INSERT INTO `district` VALUES ('2035', '鄂尔多斯市', '1989', ',1989,2035,', '2', '0', 'eerduosishi', '0', '0');
INSERT INTO `district` VALUES ('2036', '东胜区', '2035', ',1989,2035,2036,', '3', '0', 'dongshengqu', '0', '0');
INSERT INTO `district` VALUES ('2037', '达拉特旗', '2035', ',1989,2035,2037,', '3', '0', 'dalateqi', '0', '0');
INSERT INTO `district` VALUES ('2038', '准格尔旗', '2035', ',1989,2035,2038,', '3', '0', 'zhungeerqi', '0', '0');
INSERT INTO `district` VALUES ('2039', '鄂托克前旗', '2035', ',1989,2035,2039,', '3', '0', 'etuokeqianqi', '0', '0');
INSERT INTO `district` VALUES ('2040', '鄂托克旗', '2035', ',1989,2035,2040,', '3', '0', 'etuokeqi', '0', '0');
INSERT INTO `district` VALUES ('2041', '杭锦旗', '2035', ',1989,2035,2041,', '3', '0', 'hangjinqi', '0', '0');
INSERT INTO `district` VALUES ('2042', '乌审旗', '2035', ',1989,2035,2042,', '3', '0', 'wushenqi', '0', '0');
INSERT INTO `district` VALUES ('2043', '伊金霍洛旗', '2035', ',1989,2035,2043,', '3', '0', 'yijinhuoluoqi', '0', '0');
INSERT INTO `district` VALUES ('2044', '呼伦贝尔市', '1989', ',1989,2044,', '2', '0', 'hulunbeiershi', '0', '0');
INSERT INTO `district` VALUES ('2045', '海拉尔区', '2044', ',1989,2044,2045,', '3', '0', 'hailaerqu', '0', '0');
INSERT INTO `district` VALUES ('2046', '阿荣旗', '2044', ',1989,2044,2046,', '3', '0', 'arongqi', '0', '0');
INSERT INTO `district` VALUES ('2047', '莫力达瓦达斡尔族自治旗', '2044', ',1989,2044,2047,', '3', '0', 'molidawadawoerzuzizhiqi', '0', '0');
INSERT INTO `district` VALUES ('2048', '鄂伦春自治旗', '2044', ',1989,2044,2048,', '3', '0', 'elunchunzizhiqi', '0', '0');
INSERT INTO `district` VALUES ('2049', '鄂温克族自治旗', '2044', ',1989,2044,2049,', '3', '0', 'ewenkezuzizhiqi', '0', '0');
INSERT INTO `district` VALUES ('2050', '陈巴尔虎旗', '2044', ',1989,2044,2050,', '3', '0', 'chenbaerhuqi', '0', '0');
INSERT INTO `district` VALUES ('2051', '新巴尔虎左旗', '2044', ',1989,2044,2051,', '3', '0', 'xinbaerhuzuoqi', '0', '0');
INSERT INTO `district` VALUES ('2052', '新巴尔虎右旗', '2044', ',1989,2044,2052,', '3', '0', 'xinbaerhuyouqi', '0', '0');
INSERT INTO `district` VALUES ('2053', '满洲里市', '2044', ',1989,2044,2053,', '3', '0', 'manzhoulishi', '0', '0');
INSERT INTO `district` VALUES ('2054', '牙克石市', '2044', ',1989,2044,2054,', '3', '0', 'yakeshishi', '0', '0');
INSERT INTO `district` VALUES ('2055', '扎兰屯市', '2044', ',1989,2044,2055,', '3', '0', 'zhalantunshi', '0', '0');
INSERT INTO `district` VALUES ('2056', '额尔古纳市', '2044', ',1989,2044,2056,', '3', '0', 'eergunashi', '0', '0');
INSERT INTO `district` VALUES ('2057', '根河市', '2044', ',1989,2044,2057,', '3', '0', 'genheshi', '0', '0');
INSERT INTO `district` VALUES ('2058', '通辽市', '1989', ',1989,2058,', '2', '0', 'tongliaoshi', '0', '0');
INSERT INTO `district` VALUES ('2059', '科尔沁区', '2058', ',1989,2058,2059,', '3', '0', 'keerqinqu', '0', '0');
INSERT INTO `district` VALUES ('2060', '科尔沁左翼中旗', '2058', ',1989,2058,2060,', '3', '0', 'keerqinzuoyizhongqi', '0', '0');
INSERT INTO `district` VALUES ('2061', '科尔沁左翼后旗', '2058', ',1989,2058,2061,', '3', '0', 'keerqinzuoyihouqi', '0', '0');
INSERT INTO `district` VALUES ('2062', '开鲁县', '2058', ',1989,2058,2062,', '3', '0', 'kailuxian', '0', '0');
INSERT INTO `district` VALUES ('2063', '库伦旗', '2058', ',1989,2058,2063,', '3', '0', 'kulunqi', '0', '0');
INSERT INTO `district` VALUES ('2064', '奈曼旗', '2058', ',1989,2058,2064,', '3', '0', 'naimanqi', '0', '0');
INSERT INTO `district` VALUES ('2065', '扎鲁特旗', '2058', ',1989,2058,2065,', '3', '0', 'zhaluteqi', '0', '0');
INSERT INTO `district` VALUES ('2066', '霍林郭勒市', '2058', ',1989,2058,2066,', '3', '0', 'huolinguoleshi', '0', '0');
INSERT INTO `district` VALUES ('2067', '乌海市', '1989', ',1989,2067,', '2', '0', 'wuhaishi', '0', '0');
INSERT INTO `district` VALUES ('2068', '海勃湾区', '2067', ',1989,2067,2068,', '3', '0', 'haibowanqu', '0', '0');
INSERT INTO `district` VALUES ('2069', '海南区', '2067', ',1989,2067,2069,', '3', '0', 'hainanqu', '0', '0');
INSERT INTO `district` VALUES ('2070', '乌达区', '2067', ',1989,2067,2070,', '3', '0', 'wudaqu', '0', '0');
INSERT INTO `district` VALUES ('2071', '乌兰察布市', '1989', ',1989,2071,', '2', '0', 'wulanchabushi', '0', '0');
INSERT INTO `district` VALUES ('2072', '集宁区', '2071', ',1989,2071,2072,', '3', '0', 'jiningqu', '0', '0');
INSERT INTO `district` VALUES ('2073', '卓资县', '2071', ',1989,2071,2073,', '3', '0', 'zhuozixian', '0', '0');
INSERT INTO `district` VALUES ('2074', '化德县', '2071', ',1989,2071,2074,', '3', '0', 'huadexian', '0', '0');
INSERT INTO `district` VALUES ('2075', '商都县', '2071', ',1989,2071,2075,', '3', '0', 'shangduxian', '0', '0');
INSERT INTO `district` VALUES ('2076', '兴和县', '2071', ',1989,2071,2076,', '3', '0', 'xinghexian', '0', '0');
INSERT INTO `district` VALUES ('2077', '凉城县', '2071', ',1989,2071,2077,', '3', '0', 'liangchengxian', '0', '0');
INSERT INTO `district` VALUES ('2078', '察哈尔右翼前旗', '2071', ',1989,2071,2078,', '3', '0', 'chahaeryouyiqianqi', '0', '0');
INSERT INTO `district` VALUES ('2079', '察哈尔右翼中旗', '2071', ',1989,2071,2079,', '3', '0', 'chahaeryouyizhongqi', '0', '0');
INSERT INTO `district` VALUES ('2080', '察哈尔右翼后旗', '2071', ',1989,2071,2080,', '3', '0', 'chahaeryouyihouqi', '0', '0');
INSERT INTO `district` VALUES ('2081', '四子王旗', '2071', ',1989,2071,2081,', '3', '0', 'siziwangqi', '0', '0');
INSERT INTO `district` VALUES ('2082', '丰镇市', '2071', ',1989,2071,2082,', '3', '0', 'fengzhenshi', '0', '0');
INSERT INTO `district` VALUES ('2083', '锡林郭勒盟', '1989', ',1989,2083,', '2', '0', 'xilinguolemeng', '0', '0');
INSERT INTO `district` VALUES ('2084', '二连浩特市', '2083', ',1989,2083,2084,', '3', '0', 'erlianhaoteshi', '0', '0');
INSERT INTO `district` VALUES ('2085', '锡林浩特市', '2083', ',1989,2083,2085,', '3', '0', 'xilinhaoteshi', '0', '0');
INSERT INTO `district` VALUES ('2086', '阿巴嘎旗', '2083', ',1989,2083,2086,', '3', '0', 'abagaqi', '0', '0');
INSERT INTO `district` VALUES ('2087', '苏尼特左旗', '2083', ',1989,2083,2087,', '3', '0', 'sunitezuoqi', '0', '0');
INSERT INTO `district` VALUES ('2088', '苏尼特右旗', '2083', ',1989,2083,2088,', '3', '0', 'suniteyouqi', '0', '0');
INSERT INTO `district` VALUES ('2089', '东乌珠穆沁旗', '2083', ',1989,2083,2089,', '3', '0', 'dongwuzhumuqinqi', '0', '0');
INSERT INTO `district` VALUES ('2090', '西乌珠穆沁旗', '2083', ',1989,2083,2090,', '3', '0', 'xiwuzhumuqinqi', '0', '0');
INSERT INTO `district` VALUES ('2091', '太仆寺旗', '2083', ',1989,2083,2091,', '3', '0', 'taipusiqi', '0', '0');
INSERT INTO `district` VALUES ('2092', '镶黄旗', '2083', ',1989,2083,2092,', '3', '0', 'xianghuangqi', '0', '0');
INSERT INTO `district` VALUES ('2093', '正镶白旗', '2083', ',1989,2083,2093,', '3', '0', 'zhengxiangbaiqi', '0', '0');
INSERT INTO `district` VALUES ('2094', '正蓝旗', '2083', ',1989,2083,2094,', '3', '0', 'zhenglanqi', '0', '0');
INSERT INTO `district` VALUES ('2095', '多伦县', '2083', ',1989,2083,2095,', '3', '0', 'duolunxian', '0', '0');
INSERT INTO `district` VALUES ('2096', '兴安盟', '1989', ',1989,2096,', '2', '0', 'xinganmeng', '0', '0');
INSERT INTO `district` VALUES ('2097', '乌兰浩特市', '2096', ',1989,2096,2097,', '3', '0', 'wulanhaoteshi', '0', '0');
INSERT INTO `district` VALUES ('2098', '阿尔山市', '2096', ',1989,2096,2098,', '3', '0', 'aershanshi', '0', '0');
INSERT INTO `district` VALUES ('2099', '科尔沁右翼前旗', '2096', ',1989,2096,2099,', '3', '0', 'keerqinyouyiqianqi', '0', '0');
INSERT INTO `district` VALUES ('2100', '科尔沁右翼中旗', '2096', ',1989,2096,2100,', '3', '0', 'keerqinyouyizhongqi', '0', '0');
INSERT INTO `district` VALUES ('2101', '扎赉特旗', '2096', ',1989,2096,2101,', '3', '0', 'zhateqi', '0', '0');
INSERT INTO `district` VALUES ('2102', '突泉县', '2096', ',1989,2096,2102,', '3', '0', 'tuquanxian', '0', '0');
INSERT INTO `district` VALUES ('2103', '宁夏省', '0', ',2103,', '1', '0', 'ningxiasheng', '0', '0');
INSERT INTO `district` VALUES ('2104', '银川市', '2103', ',2103,2104,', '2', '0', 'yinchuanshi', '0', '0');
INSERT INTO `district` VALUES ('2105', '兴庆区', '2104', ',2103,2104,2105,', '3', '0', 'xingqingqu', '0', '0');
INSERT INTO `district` VALUES ('2106', '西夏区', '2104', ',2103,2104,2106,', '3', '0', 'xixiaqu', '0', '0');
INSERT INTO `district` VALUES ('2107', '金凤区', '2104', ',2103,2104,2107,', '3', '0', 'jinfengqu', '0', '0');
INSERT INTO `district` VALUES ('2108', '永宁县', '2104', ',2103,2104,2108,', '3', '0', 'yongningxian', '0', '0');
INSERT INTO `district` VALUES ('2109', '贺兰县', '2104', ',2103,2104,2109,', '3', '0', 'helanxian', '0', '0');
INSERT INTO `district` VALUES ('2110', '灵武市', '2104', ',2103,2104,2110,', '3', '0', 'lingwushi', '0', '0');
INSERT INTO `district` VALUES ('2111', '固原市', '2103', ',2103,2111,', '2', '0', 'guyuanshi', '0', '0');
INSERT INTO `district` VALUES ('2112', '原州区', '2111', ',2103,2111,2112,', '3', '0', 'yuanzhouqu', '0', '0');
INSERT INTO `district` VALUES ('2113', '西吉县', '2111', ',2103,2111,2113,', '3', '0', 'xijixian', '0', '0');
INSERT INTO `district` VALUES ('2114', '隆德县', '2111', ',2103,2111,2114,', '3', '0', 'longdexian', '0', '0');
INSERT INTO `district` VALUES ('2115', '泾源县', '2111', ',2103,2111,2115,', '3', '0', 'yuanxian', '0', '0');
INSERT INTO `district` VALUES ('2116', '彭阳县', '2111', ',2103,2111,2116,', '3', '0', 'pengyangxian', '0', '0');
INSERT INTO `district` VALUES ('2117', '石嘴山市', '2103', ',2103,2117,', '2', '0', 'shizuishanshi', '0', '0');
INSERT INTO `district` VALUES ('2118', '大武口区', '2117', ',2103,2117,2118,', '3', '0', 'dawukouqu', '0', '0');
INSERT INTO `district` VALUES ('2119', '惠农区', '2117', ',2103,2117,2119,', '3', '0', 'huinongqu', '0', '0');
INSERT INTO `district` VALUES ('2120', '平罗县', '2117', ',2103,2117,2120,', '3', '0', 'pingluoxian', '0', '0');
INSERT INTO `district` VALUES ('2121', '吴忠市', '2103', ',2103,2121,', '2', '0', 'wuzhongshi', '0', '0');
INSERT INTO `district` VALUES ('2122', '利通区', '2121', ',2103,2121,2122,', '3', '0', 'litongqu', '0', '0');
INSERT INTO `district` VALUES ('2123', '盐池县', '2121', ',2103,2121,2123,', '3', '0', 'yanchixian', '0', '0');
INSERT INTO `district` VALUES ('2124', '同心县', '2121', ',2103,2121,2124,', '3', '0', 'tongxinxian', '0', '0');
INSERT INTO `district` VALUES ('2125', '青铜峡市', '2121', ',2103,2121,2125,', '3', '0', 'qingtongxiashi', '0', '0');
INSERT INTO `district` VALUES ('2126', '中卫市', '2103', ',2103,2126,', '2', '0', 'zhongweishi', '0', '0');
INSERT INTO `district` VALUES ('2127', '沙坡头区', '2126', ',2103,2126,2127,', '3', '0', 'shapotouqu', '0', '0');
INSERT INTO `district` VALUES ('2128', '中宁县', '2126', ',2103,2126,2128,', '3', '0', 'zhongningxian', '0', '0');
INSERT INTO `district` VALUES ('2129', '海原县', '2126', ',2103,2126,2129,', '3', '0', 'haiyuanxian', '0', '0');
INSERT INTO `district` VALUES ('2130', '青海', '0', ',2130,', '1', '0', 'qinghai', '0', '0');
INSERT INTO `district` VALUES ('2131', '西宁市', '2130', ',2130,2131,', '2', '0', 'xiningshi', '0', '0');
INSERT INTO `district` VALUES ('2132', '城东区', '2131', ',2130,2131,2132,', '3', '0', 'chengdongqu', '0', '0');
INSERT INTO `district` VALUES ('2133', '城中区', '2131', ',2130,2131,2133,', '3', '0', 'chengzhongqu', '0', '0');
INSERT INTO `district` VALUES ('2134', '城西区', '2131', ',2130,2131,2134,', '3', '0', 'chengxiqu', '0', '0');
INSERT INTO `district` VALUES ('2135', '城北区', '2131', ',2130,2131,2135,', '3', '0', 'chengbeiqu', '0', '0');
INSERT INTO `district` VALUES ('2136', '大通回族土族自治县', '2131', ',2130,2131,2136,', '3', '0', 'datonghuizutuzuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('2137', '湟中县', '2131', ',2130,2131,2137,', '3', '0', 'zhongxian', '0', '0');
INSERT INTO `district` VALUES ('2138', '湟源县', '2131', ',2130,2131,2138,', '3', '0', 'yuanxian', '0', '0');
INSERT INTO `district` VALUES ('2139', '果洛藏族自治州', '2130', ',2130,2139,', '2', '0', 'guoluocangzuzizhizhou', '0', '0');
INSERT INTO `district` VALUES ('2140', '玛沁县', '2139', ',2130,2139,2140,', '3', '0', 'maqinxian', '0', '0');
INSERT INTO `district` VALUES ('2141', '班玛县', '2139', ',2130,2139,2141,', '3', '0', 'banmaxian', '0', '0');
INSERT INTO `district` VALUES ('2142', '甘德县', '2139', ',2130,2139,2142,', '3', '0', 'gandexian', '0', '0');
INSERT INTO `district` VALUES ('2143', '达日县', '2139', ',2130,2139,2143,', '3', '0', 'darixian', '0', '0');
INSERT INTO `district` VALUES ('2144', '久治县', '2139', ',2130,2139,2144,', '3', '0', 'jiuzhixian', '0', '0');
INSERT INTO `district` VALUES ('2145', '玛多县', '2139', ',2130,2139,2145,', '3', '0', 'maduoxian', '0', '0');
INSERT INTO `district` VALUES ('2146', '海北藏族自治州', '2130', ',2130,2146,', '2', '0', 'haibeicangzuzizhizhou', '0', '0');
INSERT INTO `district` VALUES ('2147', '门源回族自治县', '2146', ',2130,2146,2147,', '3', '0', 'menyuanhuizuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('2148', '祁连县', '2146', ',2130,2146,2148,', '3', '0', 'qilianxian', '0', '0');
INSERT INTO `district` VALUES ('2149', '海晏县', '2146', ',2130,2146,2149,', '3', '0', 'haixian', '0', '0');
INSERT INTO `district` VALUES ('2150', '刚察县', '2146', ',2130,2146,2150,', '3', '0', 'gangchaxian', '0', '0');
INSERT INTO `district` VALUES ('2151', '海东地区', '2130', ',2130,2151,', '2', '0', 'haidongdiqu', '0', '0');
INSERT INTO `district` VALUES ('2152', '平安县', '2151', ',2130,2151,2152,', '3', '0', 'pinganxian', '0', '0');
INSERT INTO `district` VALUES ('2153', '民和回族土族自治县', '2151', ',2130,2151,2153,', '3', '0', 'minhehuizutuzuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('2154', '乐都县', '2151', ',2130,2151,2154,', '3', '0', 'leduxian', '0', '0');
INSERT INTO `district` VALUES ('2155', '互助土族自治县', '2151', ',2130,2151,2155,', '3', '0', 'huzhutuzuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('2156', '化隆回族自治县', '2151', ',2130,2151,2156,', '3', '0', 'hualonghuizuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('2157', '循化撒拉族自治县', '2151', ',2130,2151,2157,', '3', '0', 'xunhuasalazuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('2158', '海南藏族自治州', '2130', ',2130,2158,', '2', '0', 'hainancangzuzizhizhou', '0', '0');
INSERT INTO `district` VALUES ('2159', '共和县', '2158', ',2130,2158,2159,', '3', '0', 'gonghexian', '0', '0');
INSERT INTO `district` VALUES ('2160', '同德县', '2158', ',2130,2158,2160,', '3', '0', 'tongdexian', '0', '0');
INSERT INTO `district` VALUES ('2161', '贵德县', '2158', ',2130,2158,2161,', '3', '0', 'guidexian', '0', '0');
INSERT INTO `district` VALUES ('2162', '兴海县', '2158', ',2130,2158,2162,', '3', '0', 'xinghaixian', '0', '0');
INSERT INTO `district` VALUES ('2163', '贵南县', '2158', ',2130,2158,2163,', '3', '0', 'guinanxian', '0', '0');
INSERT INTO `district` VALUES ('2164', '海西蒙古族藏族自治州', '2130', ',2130,2164,', '2', '0', 'haiximengguzucangzuzizhizhou', '0', '0');
INSERT INTO `district` VALUES ('2165', '格尔木市', '2164', ',2130,2164,2165,', '3', '0', 'geermushi', '0', '0');
INSERT INTO `district` VALUES ('2166', '德令哈市', '2164', ',2130,2164,2166,', '3', '0', 'delinghashi', '0', '0');
INSERT INTO `district` VALUES ('2167', '乌兰县', '2164', ',2130,2164,2167,', '3', '0', 'wulanxian', '0', '0');
INSERT INTO `district` VALUES ('2168', '都兰县', '2164', ',2130,2164,2168,', '3', '0', 'dulanxian', '0', '0');
INSERT INTO `district` VALUES ('2169', '天峻县', '2164', ',2130,2164,2169,', '3', '0', 'tianjunxian', '0', '0');
INSERT INTO `district` VALUES ('2170', '黄南藏族自治州', '2130', ',2130,2170,', '2', '0', 'huangnancangzuzizhizhou', '0', '0');
INSERT INTO `district` VALUES ('2171', '同仁县', '2170', ',2130,2170,2171,', '3', '0', 'tongrenxian', '0', '0');
INSERT INTO `district` VALUES ('2172', '尖扎县', '2170', ',2130,2170,2172,', '3', '0', 'jianzhaxian', '0', '0');
INSERT INTO `district` VALUES ('2173', '泽库县', '2170', ',2130,2170,2173,', '3', '0', 'zekuxian', '0', '0');
INSERT INTO `district` VALUES ('2174', '河南蒙古族自治县', '2170', ',2130,2170,2174,', '3', '0', 'henanmengguzuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('2175', '玉树藏族自治州', '2130', ',2130,2175,', '2', '0', 'yushucangzuzizhizhou', '0', '0');
INSERT INTO `district` VALUES ('2176', '玉树县', '2175', ',2130,2175,2176,', '3', '0', 'yushuxian', '0', '0');
INSERT INTO `district` VALUES ('2177', '杂多县', '2175', ',2130,2175,2177,', '3', '0', 'zaduoxian', '0', '0');
INSERT INTO `district` VALUES ('2178', '称多县', '2175', ',2130,2175,2178,', '3', '0', 'chengduoxian', '0', '0');
INSERT INTO `district` VALUES ('2179', '治多县', '2175', ',2130,2175,2179,', '3', '0', 'zhiduoxian', '0', '0');
INSERT INTO `district` VALUES ('2180', '囊谦县', '2175', ',2130,2175,2180,', '3', '0', 'nangqianxian', '0', '0');
INSERT INTO `district` VALUES ('2181', '曲麻莱县', '2175', ',2130,2175,2181,', '3', '0', 'qumalaixian', '0', '0');
INSERT INTO `district` VALUES ('2182', '山东省', '0', ',2182,', '1', '0', 'shandongsheng', '0', '0');
INSERT INTO `district` VALUES ('2183', '济南市', '2182', ',2182,2183,', '2', '0', 'jinanshi', '0', '0');
INSERT INTO `district` VALUES ('2184', '历下区', '2183', ',2182,2183,2184,', '3', '0', 'lixiaqu', '0', '0');
INSERT INTO `district` VALUES ('2185', '市中区', '2183', ',2182,2183,2185,', '3', '0', 'shizhongqu', '0', '0');
INSERT INTO `district` VALUES ('2186', '槐荫区', '2183', ',2182,2183,2186,', '3', '0', 'huaiyinqu', '0', '0');
INSERT INTO `district` VALUES ('2187', '天桥区', '2183', ',2182,2183,2187,', '3', '0', 'tianqiaoqu', '0', '0');
INSERT INTO `district` VALUES ('2188', '历城区', '2183', ',2182,2183,2188,', '3', '0', 'lichengqu', '0', '0');
INSERT INTO `district` VALUES ('2189', '长清区', '2183', ',2182,2183,2189,', '3', '0', 'changqingqu', '0', '0');
INSERT INTO `district` VALUES ('2190', '平阴县', '2183', ',2182,2183,2190,', '3', '0', 'pingyinxian', '0', '0');
INSERT INTO `district` VALUES ('2191', '济阳县', '2183', ',2182,2183,2191,', '3', '0', 'jiyangxian', '0', '0');
INSERT INTO `district` VALUES ('2192', '商河县', '2183', ',2182,2183,2192,', '3', '0', 'shanghexian', '0', '0');
INSERT INTO `district` VALUES ('2193', '章丘市', '2183', ',2182,2183,2193,', '3', '0', 'zhangqiushi', '0', '0');
INSERT INTO `district` VALUES ('2194', '滨州市', '2182', ',2182,2194,', '2', '0', 'binzhoushi', '0', '0');
INSERT INTO `district` VALUES ('2195', '滨城区', '2194', ',2182,2194,2195,', '3', '0', 'binchengqu', '0', '0');
INSERT INTO `district` VALUES ('2196', '惠民县', '2194', ',2182,2194,2196,', '3', '0', 'huiminxian', '0', '0');
INSERT INTO `district` VALUES ('2197', '阳信县', '2194', ',2182,2194,2197,', '3', '0', 'yangxinxian', '0', '0');
INSERT INTO `district` VALUES ('2198', '无棣县', '2194', ',2182,2194,2198,', '3', '0', 'wuxian', '0', '0');
INSERT INTO `district` VALUES ('2199', '沾化县', '2194', ',2182,2194,2199,', '3', '0', 'zhanhuaxian', '0', '0');
INSERT INTO `district` VALUES ('2200', '博兴县', '2194', ',2182,2194,2200,', '3', '0', 'boxingxian', '0', '0');
INSERT INTO `district` VALUES ('2201', '邹平县', '2194', ',2182,2194,2201,', '3', '0', 'zoupingxian', '0', '0');
INSERT INTO `district` VALUES ('2202', '德州市', '2182', ',2182,2202,', '2', '0', 'dezhoushi', '0', '0');
INSERT INTO `district` VALUES ('2203', '德城区', '2202', ',2182,2202,2203,', '3', '0', 'dechengqu', '0', '0');
INSERT INTO `district` VALUES ('2204', '陵县', '2202', ',2182,2202,2204,', '3', '0', 'lingxian', '0', '0');
INSERT INTO `district` VALUES ('2205', '宁津县', '2202', ',2182,2202,2205,', '3', '0', 'ningjinxian', '0', '0');
INSERT INTO `district` VALUES ('2206', '庆云县', '2202', ',2182,2202,2206,', '3', '0', 'qingyunxian', '0', '0');
INSERT INTO `district` VALUES ('2207', '临邑县', '2202', ',2182,2202,2207,', '3', '0', 'linyixian', '0', '0');
INSERT INTO `district` VALUES ('2208', '齐河县', '2202', ',2182,2202,2208,', '3', '0', 'qihexian', '0', '0');
INSERT INTO `district` VALUES ('2209', '平原县', '2202', ',2182,2202,2209,', '3', '0', 'pingyuanxian', '0', '0');
INSERT INTO `district` VALUES ('2210', '夏津县', '2202', ',2182,2202,2210,', '3', '0', 'xiajinxian', '0', '0');
INSERT INTO `district` VALUES ('2211', '武城县', '2202', ',2182,2202,2211,', '3', '0', 'wuchengxian', '0', '0');
INSERT INTO `district` VALUES ('2212', '乐陵市', '2202', ',2182,2202,2212,', '3', '0', 'lelingshi', '0', '0');
INSERT INTO `district` VALUES ('2213', '禹城市', '2202', ',2182,2202,2213,', '3', '0', 'yuchengshi', '0', '0');
INSERT INTO `district` VALUES ('2214', '东营市', '2182', ',2182,2214,', '2', '0', 'dongyingshi', '0', '0');
INSERT INTO `district` VALUES ('2215', '东营区', '2214', ',2182,2214,2215,', '3', '0', 'dongyingqu', '0', '0');
INSERT INTO `district` VALUES ('2216', '河口区', '2214', ',2182,2214,2216,', '3', '0', 'hekouqu', '0', '0');
INSERT INTO `district` VALUES ('2217', '垦利县', '2214', ',2182,2214,2217,', '3', '0', 'kenlixian', '0', '0');
INSERT INTO `district` VALUES ('2218', '利津县', '2214', ',2182,2214,2218,', '3', '0', 'lijinxian', '0', '0');
INSERT INTO `district` VALUES ('2219', '广饶县', '2214', ',2182,2214,2219,', '3', '0', 'guangraoxian', '0', '0');
INSERT INTO `district` VALUES ('2220', '菏泽市', '2182', ',2182,2220,', '2', '0', 'hezeshi', '0', '0');
INSERT INTO `district` VALUES ('2221', '牡丹区', '2220', ',2182,2220,2221,', '3', '0', 'mudanqu', '0', '0');
INSERT INTO `district` VALUES ('2222', '曹县', '2220', ',2182,2220,2222,', '3', '0', 'caoxian', '0', '0');
INSERT INTO `district` VALUES ('2223', '单县', '2220', ',2182,2220,2223,', '3', '0', 'danxian', '0', '0');
INSERT INTO `district` VALUES ('2224', '成武县', '2220', ',2182,2220,2224,', '3', '0', 'chengwuxian', '0', '0');
INSERT INTO `district` VALUES ('2225', '巨野县', '2220', ',2182,2220,2225,', '3', '0', 'juyexian', '0', '0');
INSERT INTO `district` VALUES ('2226', '郓城县', '2220', ',2182,2220,2226,', '3', '0', 'chengxian', '0', '0');
INSERT INTO `district` VALUES ('2227', '鄄城县', '2220', ',2182,2220,2227,', '3', '0', 'chengxian', '0', '0');
INSERT INTO `district` VALUES ('2228', '定陶县', '2220', ',2182,2220,2228,', '3', '0', 'dingtaoxian', '0', '0');
INSERT INTO `district` VALUES ('2229', '东明县', '2220', ',2182,2220,2229,', '3', '0', 'dongmingxian', '0', '0');
INSERT INTO `district` VALUES ('2230', '济宁市', '2182', ',2182,2230,', '2', '0', 'jiningshi', '0', '0');
INSERT INTO `district` VALUES ('2231', '市中区', '2230', ',2182,2230,2231,', '3', '0', 'shizhongqu', '0', '0');
INSERT INTO `district` VALUES ('2232', '任城区', '2230', ',2182,2230,2232,', '3', '0', 'renchengqu', '0', '0');
INSERT INTO `district` VALUES ('2233', '微山县', '2230', ',2182,2230,2233,', '3', '0', 'weishanxian', '0', '0');
INSERT INTO `district` VALUES ('2234', '鱼台县', '2230', ',2182,2230,2234,', '3', '0', 'yutaixian', '0', '0');
INSERT INTO `district` VALUES ('2235', '金乡县', '2230', ',2182,2230,2235,', '3', '0', 'jinxiangxian', '0', '0');
INSERT INTO `district` VALUES ('2236', '嘉祥县', '2230', ',2182,2230,2236,', '3', '0', 'jiaxiangxian', '0', '0');
INSERT INTO `district` VALUES ('2237', '汶上县', '2230', ',2182,2230,2237,', '3', '0', 'shangxian', '0', '0');
INSERT INTO `district` VALUES ('2238', '泗水县', '2230', ',2182,2230,2238,', '3', '0', 'shuixian', '0', '0');
INSERT INTO `district` VALUES ('2239', '梁山县', '2230', ',2182,2230,2239,', '3', '0', 'liangshanxian', '0', '0');
INSERT INTO `district` VALUES ('2240', '曲阜市', '2230', ',2182,2230,2240,', '3', '0', 'qufushi', '0', '0');
INSERT INTO `district` VALUES ('2241', '兖州市', '2230', ',2182,2230,2241,', '3', '0', 'zhoushi', '0', '0');
INSERT INTO `district` VALUES ('2242', '邹城市', '2230', ',2182,2230,2242,', '3', '0', 'zouchengshi', '0', '0');
INSERT INTO `district` VALUES ('2243', '莱芜市', '2182', ',2182,2243,', '2', '0', 'laiwushi', '0', '0');
INSERT INTO `district` VALUES ('2244', '莱城区', '2243', ',2182,2243,2244,', '3', '0', 'laichengqu', '0', '0');
INSERT INTO `district` VALUES ('2245', '钢城区', '2243', ',2182,2243,2245,', '3', '0', 'gangchengqu', '0', '0');
INSERT INTO `district` VALUES ('2246', '聊城市', '2182', ',2182,2246,', '2', '0', 'liaochengshi', '0', '0');
INSERT INTO `district` VALUES ('2247', '东昌府区', '2246', ',2182,2246,2247,', '3', '0', 'dongchangfuqu', '0', '0');
INSERT INTO `district` VALUES ('2248', '阳谷县', '2246', ',2182,2246,2248,', '3', '0', 'yangguxian', '0', '0');
INSERT INTO `district` VALUES ('2249', '莘县', '2246', ',2182,2246,2249,', '3', '0', 'xian', '0', '0');
INSERT INTO `district` VALUES ('2250', '茌平县', '2246', ',2182,2246,2250,', '3', '0', 'pingxian', '0', '0');
INSERT INTO `district` VALUES ('2251', '东阿县', '2246', ',2182,2246,2251,', '3', '0', 'dongaxian', '0', '0');
INSERT INTO `district` VALUES ('2252', '冠县', '2246', ',2182,2246,2252,', '3', '0', 'guanxian', '0', '0');
INSERT INTO `district` VALUES ('2253', '高唐县', '2246', ',2182,2246,2253,', '3', '0', 'gaotangxian', '0', '0');
INSERT INTO `district` VALUES ('2254', '临清市', '2246', ',2182,2246,2254,', '3', '0', 'linqingshi', '0', '0');
INSERT INTO `district` VALUES ('2255', '临沂市', '2182', ',2182,2255,', '2', '0', 'linyishi', '0', '0');
INSERT INTO `district` VALUES ('2256', '兰山区', '2255', ',2182,2255,2256,', '3', '0', 'lanshanqu', '0', '0');
INSERT INTO `district` VALUES ('2257', '罗庄区', '2255', ',2182,2255,2257,', '3', '0', 'luozhuangqu', '0', '0');
INSERT INTO `district` VALUES ('2258', '河东区', '2255', ',2182,2255,2258,', '3', '0', 'hedongqu', '0', '0');
INSERT INTO `district` VALUES ('2259', '沂南县', '2255', ',2182,2255,2259,', '3', '0', 'yinanxian', '0', '0');
INSERT INTO `district` VALUES ('2260', '郯城县', '2255', ',2182,2255,2260,', '3', '0', 'chengxian', '0', '0');
INSERT INTO `district` VALUES ('2261', '沂水县', '2255', ',2182,2255,2261,', '3', '0', 'yishuixian', '0', '0');
INSERT INTO `district` VALUES ('2262', '苍山县', '2255', ',2182,2255,2262,', '3', '0', 'cangshanxian', '0', '0');
INSERT INTO `district` VALUES ('2263', '费县', '2255', ',2182,2255,2263,', '3', '0', 'feixian', '0', '0');
INSERT INTO `district` VALUES ('2264', '平邑县', '2255', ',2182,2255,2264,', '3', '0', 'pingyixian', '0', '0');
INSERT INTO `district` VALUES ('2265', '莒南县', '2255', ',2182,2255,2265,', '3', '0', 'nanxian', '0', '0');
INSERT INTO `district` VALUES ('2266', '蒙阴县', '2255', ',2182,2255,2266,', '3', '0', 'mengyinxian', '0', '0');
INSERT INTO `district` VALUES ('2267', '临沭县', '2255', ',2182,2255,2267,', '3', '0', 'linxian', '0', '0');
INSERT INTO `district` VALUES ('2268', '青岛市', '2182', ',2182,2268,', '2', '0', 'qingdaoshi', '0', '0');
INSERT INTO `district` VALUES ('2269', '市南区', '2268', ',2182,2268,2269,', '3', '0', 'shinanqu', '0', '0');
INSERT INTO `district` VALUES ('2270', '市北区', '2268', ',2182,2268,2270,', '3', '0', 'shibeiqu', '0', '0');
INSERT INTO `district` VALUES ('2271', '四方区', '2268', ',2182,2268,2271,', '3', '0', 'sifangqu', '0', '0');
INSERT INTO `district` VALUES ('2272', '黄岛区', '2268', ',2182,2268,2272,', '3', '0', 'huangdaoqu', '0', '0');
INSERT INTO `district` VALUES ('2273', '崂山区', '2268', ',2182,2268,2273,', '3', '0', 'shanqu', '0', '0');
INSERT INTO `district` VALUES ('2274', '李沧区', '2268', ',2182,2268,2274,', '3', '0', 'licangqu', '0', '0');
INSERT INTO `district` VALUES ('2275', '城阳区', '2268', ',2182,2268,2275,', '3', '0', 'chengyangqu', '0', '0');
INSERT INTO `district` VALUES ('2276', '胶州市', '2268', ',2182,2268,2276,', '3', '0', 'jiaozhoushi', '0', '0');
INSERT INTO `district` VALUES ('2277', '即墨市', '2268', ',2182,2268,2277,', '3', '0', 'jimoshi', '0', '0');
INSERT INTO `district` VALUES ('2278', '平度市', '2268', ',2182,2268,2278,', '3', '0', 'pingdushi', '0', '0');
INSERT INTO `district` VALUES ('2279', '胶南市', '2268', ',2182,2268,2279,', '3', '0', 'jiaonanshi', '0', '0');
INSERT INTO `district` VALUES ('2280', '莱西市', '2268', ',2182,2268,2280,', '3', '0', 'laixishi', '0', '0');
INSERT INTO `district` VALUES ('2281', '日照市', '2182', ',2182,2281,', '2', '0', 'rizhaoshi', '0', '0');
INSERT INTO `district` VALUES ('2282', '东港区', '2281', ',2182,2281,2282,', '3', '0', 'donggangqu', '0', '0');
INSERT INTO `district` VALUES ('2283', '岚山区', '2281', ',2182,2281,2283,', '3', '0', 'shanqu', '0', '0');
INSERT INTO `district` VALUES ('2284', '五莲县', '2281', ',2182,2281,2284,', '3', '0', 'wulianxian', '0', '0');
INSERT INTO `district` VALUES ('2285', '莒县', '2281', ',2182,2281,2285,', '3', '0', 'xian', '0', '0');
INSERT INTO `district` VALUES ('2286', '泰安市', '2182', ',2182,2286,', '2', '0', 'taianshi', '0', '0');
INSERT INTO `district` VALUES ('2287', '泰山区', '2286', ',2182,2286,2287,', '3', '0', 'taishanqu', '0', '0');
INSERT INTO `district` VALUES ('2288', '岱岳区', '2286', ',2182,2286,2288,', '3', '0', 'yuequ', '0', '0');
INSERT INTO `district` VALUES ('2289', '宁阳县', '2286', ',2182,2286,2289,', '3', '0', 'ningyangxian', '0', '0');
INSERT INTO `district` VALUES ('2290', '东平县', '2286', ',2182,2286,2290,', '3', '0', 'dongpingxian', '0', '0');
INSERT INTO `district` VALUES ('2291', '新泰市', '2286', ',2182,2286,2291,', '3', '0', 'xintaishi', '0', '0');
INSERT INTO `district` VALUES ('2292', '肥城市', '2286', ',2182,2286,2292,', '3', '0', 'feichengshi', '0', '0');
INSERT INTO `district` VALUES ('2293', '威海市', '2182', ',2182,2293,', '2', '0', 'weihaishi', '0', '0');
INSERT INTO `district` VALUES ('2294', '环翠区', '2293', ',2182,2293,2294,', '3', '0', 'huancuiqu', '0', '0');
INSERT INTO `district` VALUES ('2295', '文登市', '2293', ',2182,2293,2295,', '3', '0', 'wendengshi', '0', '0');
INSERT INTO `district` VALUES ('2296', '荣成市', '2293', ',2182,2293,2296,', '3', '0', 'rongchengshi', '0', '0');
INSERT INTO `district` VALUES ('2297', '乳山市', '2293', ',2182,2293,2297,', '3', '0', 'rushanshi', '0', '0');
INSERT INTO `district` VALUES ('2298', '潍坊市', '2182', ',2182,2298,', '2', '0', 'weifangshi', '0', '0');
INSERT INTO `district` VALUES ('2299', '潍城区', '2298', ',2182,2298,2299,', '3', '0', 'weichengqu', '0', '0');
INSERT INTO `district` VALUES ('2300', '寒亭区', '2298', ',2182,2298,2300,', '3', '0', 'hantingqu', '0', '0');
INSERT INTO `district` VALUES ('2301', '坊子区', '2298', ',2182,2298,2301,', '3', '0', 'fangziqu', '0', '0');
INSERT INTO `district` VALUES ('2302', '奎文区', '2298', ',2182,2298,2302,', '3', '0', 'kuiwenqu', '0', '0');
INSERT INTO `district` VALUES ('2303', '临朐县', '2298', ',2182,2298,2303,', '3', '0', 'linxian', '0', '0');
INSERT INTO `district` VALUES ('2304', '昌乐县', '2298', ',2182,2298,2304,', '3', '0', 'changlexian', '0', '0');
INSERT INTO `district` VALUES ('2305', '青州市', '2298', ',2182,2298,2305,', '3', '0', 'qingzhoushi', '0', '0');
INSERT INTO `district` VALUES ('2306', '诸城市', '2298', ',2182,2298,2306,', '3', '0', 'zhuchengshi', '0', '0');
INSERT INTO `district` VALUES ('2307', '寿光市', '2298', ',2182,2298,2307,', '3', '0', 'shouguangshi', '0', '0');
INSERT INTO `district` VALUES ('2308', '安丘市', '2298', ',2182,2298,2308,', '3', '0', 'anqiushi', '0', '0');
INSERT INTO `district` VALUES ('2309', '高密市', '2298', ',2182,2298,2309,', '3', '0', 'gaomishi', '0', '0');
INSERT INTO `district` VALUES ('2310', '昌邑市', '2298', ',2182,2298,2310,', '3', '0', 'changyishi', '0', '0');
INSERT INTO `district` VALUES ('2311', '烟台市', '2182', ',2182,2311,', '2', '0', 'yantaishi', '0', '0');
INSERT INTO `district` VALUES ('2312', '芝罘区', '2311', ',2182,2311,2312,', '3', '0', 'zhiqu', '0', '0');
INSERT INTO `district` VALUES ('2313', '福山区', '2311', ',2182,2311,2313,', '3', '0', 'fushanqu', '0', '0');
INSERT INTO `district` VALUES ('2314', '牟平区', '2311', ',2182,2311,2314,', '3', '0', 'moupingqu', '0', '0');
INSERT INTO `district` VALUES ('2315', '莱山区', '2311', ',2182,2311,2315,', '3', '0', 'laishanqu', '0', '0');
INSERT INTO `district` VALUES ('2316', '长岛县', '2311', ',2182,2311,2316,', '3', '0', 'changdaoxian', '0', '0');
INSERT INTO `district` VALUES ('2317', '龙口市', '2311', ',2182,2311,2317,', '3', '0', 'longkoushi', '0', '0');
INSERT INTO `district` VALUES ('2318', '莱阳市', '2311', ',2182,2311,2318,', '3', '0', 'laiyangshi', '0', '0');
INSERT INTO `district` VALUES ('2319', '莱州市', '2311', ',2182,2311,2319,', '3', '0', 'laizhoushi', '0', '0');
INSERT INTO `district` VALUES ('2320', '蓬莱市', '2311', ',2182,2311,2320,', '3', '0', 'penglaishi', '0', '0');
INSERT INTO `district` VALUES ('2321', '招远市', '2311', ',2182,2311,2321,', '3', '0', 'zhaoyuanshi', '0', '0');
INSERT INTO `district` VALUES ('2322', '栖霞市', '2311', ',2182,2311,2322,', '3', '0', 'qixiashi', '0', '0');
INSERT INTO `district` VALUES ('2323', '海阳市', '2311', ',2182,2311,2323,', '3', '0', 'haiyangshi', '0', '0');
INSERT INTO `district` VALUES ('2324', '枣庄市', '2182', ',2182,2324,', '2', '0', 'zaozhuangshi', '0', '0');
INSERT INTO `district` VALUES ('2325', '市中区', '2324', ',2182,2324,2325,', '3', '0', 'shizhongqu', '0', '0');
INSERT INTO `district` VALUES ('2326', '薛城区', '2324', ',2182,2324,2326,', '3', '0', 'xuechengqu', '0', '0');
INSERT INTO `district` VALUES ('2327', '峄城区', '2324', ',2182,2324,2327,', '3', '0', 'chengqu', '0', '0');
INSERT INTO `district` VALUES ('2328', '台儿庄区', '2324', ',2182,2324,2328,', '3', '0', 'taierzhuangqu', '0', '0');
INSERT INTO `district` VALUES ('2329', '山亭区', '2324', ',2182,2324,2329,', '3', '0', 'shantingqu', '0', '0');
INSERT INTO `district` VALUES ('2330', '滕州市', '2324', ',2182,2324,2330,', '3', '0', 'zhoushi', '0', '0');
INSERT INTO `district` VALUES ('2331', '淄博市', '2182', ',2182,2331,', '2', '0', 'ziboshi', '0', '0');
INSERT INTO `district` VALUES ('2332', '淄川区', '2331', ',2182,2331,2332,', '3', '0', 'zichuanqu', '0', '0');
INSERT INTO `district` VALUES ('2333', '张店区', '2331', ',2182,2331,2333,', '3', '0', 'zhangdianqu', '0', '0');
INSERT INTO `district` VALUES ('2334', '博山区', '2331', ',2182,2331,2334,', '3', '0', 'boshanqu', '0', '0');
INSERT INTO `district` VALUES ('2335', '临淄区', '2331', ',2182,2331,2335,', '3', '0', 'linziqu', '0', '0');
INSERT INTO `district` VALUES ('2336', '周村区', '2331', ',2182,2331,2336,', '3', '0', 'zhoucunqu', '0', '0');
INSERT INTO `district` VALUES ('2337', '桓台县', '2331', ',2182,2331,2337,', '3', '0', 'huantaixian', '0', '0');
INSERT INTO `district` VALUES ('2338', '高青县', '2331', ',2182,2331,2338,', '3', '0', 'gaoqingxian', '0', '0');
INSERT INTO `district` VALUES ('2339', '沂源县', '2331', ',2182,2331,2339,', '3', '0', 'yiyuanxian', '0', '0');
INSERT INTO `district` VALUES ('2340', '山西省', '0', ',2340,', '1', '0', 'shanxisheng', '0', '0');
INSERT INTO `district` VALUES ('2341', '太原市', '2340', ',2340,2341,', '2', '0', 'taiyuanshi', '0', '0');
INSERT INTO `district` VALUES ('2342', '小店区', '2341', ',2340,2341,2342,', '3', '0', 'xiaodianqu', '0', '0');
INSERT INTO `district` VALUES ('2343', '迎泽区', '2341', ',2340,2341,2343,', '3', '0', 'yingzequ', '0', '0');
INSERT INTO `district` VALUES ('2344', '杏花岭区', '2341', ',2340,2341,2344,', '3', '0', 'xinghualingqu', '0', '0');
INSERT INTO `district` VALUES ('2345', '尖草坪区', '2341', ',2340,2341,2345,', '3', '0', 'jiancaopingqu', '0', '0');
INSERT INTO `district` VALUES ('2346', '万柏林区', '2341', ',2340,2341,2346,', '3', '0', 'wanbailinqu', '0', '0');
INSERT INTO `district` VALUES ('2347', '晋源区', '2341', ',2340,2341,2347,', '3', '0', 'jinyuanqu', '0', '0');
INSERT INTO `district` VALUES ('2348', '清徐县', '2341', ',2340,2341,2348,', '3', '0', 'qingxuxian', '0', '0');
INSERT INTO `district` VALUES ('2349', '阳曲县', '2341', ',2340,2341,2349,', '3', '0', 'yangquxian', '0', '0');
INSERT INTO `district` VALUES ('2350', '娄烦县', '2341', ',2340,2341,2350,', '3', '0', 'loufanxian', '0', '0');
INSERT INTO `district` VALUES ('2351', '古交市', '2341', ',2340,2341,2351,', '3', '0', 'gujiaoshi', '0', '0');
INSERT INTO `district` VALUES ('2352', '长治市', '2340', ',2340,2352,', '2', '0', 'changzhishi', '0', '0');
INSERT INTO `district` VALUES ('2353', '城区', '2352', ',2340,2352,2353,', '3', '0', 'chengqu', '0', '0');
INSERT INTO `district` VALUES ('2354', '郊区', '2352', ',2340,2352,2354,', '3', '0', 'jiaoqu', '0', '0');
INSERT INTO `district` VALUES ('2355', '长治县', '2352', ',2340,2352,2355,', '3', '0', 'changzhixian', '0', '0');
INSERT INTO `district` VALUES ('2356', '襄垣县', '2352', ',2340,2352,2356,', '3', '0', 'xiangyuanxian', '0', '0');
INSERT INTO `district` VALUES ('2357', '屯留县', '2352', ',2340,2352,2357,', '3', '0', 'tunliuxian', '0', '0');
INSERT INTO `district` VALUES ('2358', '平顺县', '2352', ',2340,2352,2358,', '3', '0', 'pingshunxian', '0', '0');
INSERT INTO `district` VALUES ('2359', '黎城县', '2352', ',2340,2352,2359,', '3', '0', 'lichengxian', '0', '0');
INSERT INTO `district` VALUES ('2360', '壶关县', '2352', ',2340,2352,2360,', '3', '0', 'huguanxian', '0', '0');
INSERT INTO `district` VALUES ('2361', '长子县', '2352', ',2340,2352,2361,', '3', '0', 'changzixian', '0', '0');
INSERT INTO `district` VALUES ('2362', '武乡县', '2352', ',2340,2352,2362,', '3', '0', 'wuxiangxian', '0', '0');
INSERT INTO `district` VALUES ('2363', '沁县', '2352', ',2340,2352,2363,', '3', '0', 'qinxian', '0', '0');
INSERT INTO `district` VALUES ('2364', '沁源县', '2352', ',2340,2352,2364,', '3', '0', 'qinyuanxian', '0', '0');
INSERT INTO `district` VALUES ('2365', '潞城市', '2352', ',2340,2352,2365,', '3', '0', 'luchengshi', '0', '0');
INSERT INTO `district` VALUES ('2366', '大同市', '2340', ',2340,2366,', '2', '0', 'datongshi', '0', '0');
INSERT INTO `district` VALUES ('2367', '城区', '2366', ',2340,2366,2367,', '3', '0', 'chengqu', '0', '0');
INSERT INTO `district` VALUES ('2368', '矿区', '2366', ',2340,2366,2368,', '3', '0', 'kuangqu', '0', '0');
INSERT INTO `district` VALUES ('2369', '南郊区', '2366', ',2340,2366,2369,', '3', '0', 'nanjiaoqu', '0', '0');
INSERT INTO `district` VALUES ('2370', '新荣区', '2366', ',2340,2366,2370,', '3', '0', 'xinrongqu', '0', '0');
INSERT INTO `district` VALUES ('2371', '阳高县', '2366', ',2340,2366,2371,', '3', '0', 'yanggaoxian', '0', '0');
INSERT INTO `district` VALUES ('2372', '天镇县', '2366', ',2340,2366,2372,', '3', '0', 'tianzhenxian', '0', '0');
INSERT INTO `district` VALUES ('2373', '广灵县', '2366', ',2340,2366,2373,', '3', '0', 'guanglingxian', '0', '0');
INSERT INTO `district` VALUES ('2374', '灵丘县', '2366', ',2340,2366,2374,', '3', '0', 'lingqiuxian', '0', '0');
INSERT INTO `district` VALUES ('2375', '浑源县', '2366', ',2340,2366,2375,', '3', '0', 'hunyuanxian', '0', '0');
INSERT INTO `district` VALUES ('2376', '左云县', '2366', ',2340,2366,2376,', '3', '0', 'zuoyunxian', '0', '0');
INSERT INTO `district` VALUES ('2377', '大同县', '2366', ',2340,2366,2377,', '3', '0', 'datongxian', '0', '0');
INSERT INTO `district` VALUES ('2378', '晋城市', '2340', ',2340,2378,', '2', '0', 'jinchengshi', '0', '0');
INSERT INTO `district` VALUES ('2379', '城区', '2378', ',2340,2378,2379,', '3', '0', 'chengqu', '0', '0');
INSERT INTO `district` VALUES ('2380', '沁水县', '2378', ',2340,2378,2380,', '3', '0', 'qinshuixian', '0', '0');
INSERT INTO `district` VALUES ('2381', '阳城县', '2378', ',2340,2378,2381,', '3', '0', 'yangchengxian', '0', '0');
INSERT INTO `district` VALUES ('2382', '陵川县', '2378', ',2340,2378,2382,', '3', '0', 'lingchuanxian', '0', '0');
INSERT INTO `district` VALUES ('2383', '泽州县', '2378', ',2340,2378,2383,', '3', '0', 'zezhouxian', '0', '0');
INSERT INTO `district` VALUES ('2384', '高平市', '2378', ',2340,2378,2384,', '3', '0', 'gaopingshi', '0', '0');
INSERT INTO `district` VALUES ('2385', '晋中市', '2340', ',2340,2385,', '2', '0', 'jinzhongshi', '0', '0');
INSERT INTO `district` VALUES ('2386', '榆次区', '2385', ',2340,2385,2386,', '3', '0', 'yuciqu', '0', '0');
INSERT INTO `district` VALUES ('2387', '榆社县', '2385', ',2340,2385,2387,', '3', '0', 'yushexian', '0', '0');
INSERT INTO `district` VALUES ('2388', '左权县', '2385', ',2340,2385,2388,', '3', '0', 'zuoquanxian', '0', '0');
INSERT INTO `district` VALUES ('2389', '和顺县', '2385', ',2340,2385,2389,', '3', '0', 'heshunxian', '0', '0');
INSERT INTO `district` VALUES ('2390', '昔阳县', '2385', ',2340,2385,2390,', '3', '0', 'xiyangxian', '0', '0');
INSERT INTO `district` VALUES ('2391', '寿阳县', '2385', ',2340,2385,2391,', '3', '0', 'shouyangxian', '0', '0');
INSERT INTO `district` VALUES ('2392', '太谷县', '2385', ',2340,2385,2392,', '3', '0', 'taiguxian', '0', '0');
INSERT INTO `district` VALUES ('2393', '祁县', '2385', ',2340,2385,2393,', '3', '0', 'qixian', '0', '0');
INSERT INTO `district` VALUES ('2394', '平遥县', '2385', ',2340,2385,2394,', '3', '0', 'pingyaoxian', '0', '0');
INSERT INTO `district` VALUES ('2395', '灵石县', '2385', ',2340,2385,2395,', '3', '0', 'lingshixian', '0', '0');
INSERT INTO `district` VALUES ('2396', '介休市', '2385', ',2340,2385,2396,', '3', '0', 'jiexiushi', '0', '0');
INSERT INTO `district` VALUES ('2397', '临汾市', '2340', ',2340,2397,', '2', '0', 'linfenshi', '0', '0');
INSERT INTO `district` VALUES ('2398', '尧都区', '2397', ',2340,2397,2398,', '3', '0', 'yaoduqu', '0', '0');
INSERT INTO `district` VALUES ('2399', '曲沃县', '2397', ',2340,2397,2399,', '3', '0', 'quwoxian', '0', '0');
INSERT INTO `district` VALUES ('2400', '翼城县', '2397', ',2340,2397,2400,', '3', '0', 'yichengxian', '0', '0');
INSERT INTO `district` VALUES ('2401', '襄汾县', '2397', ',2340,2397,2401,', '3', '0', 'xiangfenxian', '0', '0');
INSERT INTO `district` VALUES ('2402', '洪洞县', '2397', ',2340,2397,2402,', '3', '0', 'hongdongxian', '0', '0');
INSERT INTO `district` VALUES ('2403', '古县', '2397', ',2340,2397,2403,', '3', '0', 'guxian', '0', '0');
INSERT INTO `district` VALUES ('2404', '安泽县', '2397', ',2340,2397,2404,', '3', '0', 'anzexian', '0', '0');
INSERT INTO `district` VALUES ('2405', '浮山县', '2397', ',2340,2397,2405,', '3', '0', 'fushanxian', '0', '0');
INSERT INTO `district` VALUES ('2406', '吉县', '2397', ',2340,2397,2406,', '3', '0', 'jixian', '0', '0');
INSERT INTO `district` VALUES ('2407', '乡宁县', '2397', ',2340,2397,2407,', '3', '0', 'xiangningxian', '0', '0');
INSERT INTO `district` VALUES ('2408', '大宁县', '2397', ',2340,2397,2408,', '3', '0', 'daningxian', '0', '0');
INSERT INTO `district` VALUES ('2409', '隰县', '2397', ',2340,2397,2409,', '3', '0', 'xian', '0', '0');
INSERT INTO `district` VALUES ('2410', '永和县', '2397', ',2340,2397,2410,', '3', '0', 'yonghexian', '0', '0');
INSERT INTO `district` VALUES ('2411', '蒲县', '2397', ',2340,2397,2411,', '3', '0', 'puxian', '0', '0');
INSERT INTO `district` VALUES ('2412', '汾西县', '2397', ',2340,2397,2412,', '3', '0', 'fenxixian', '0', '0');
INSERT INTO `district` VALUES ('2413', '侯马市', '2397', ',2340,2397,2413,', '3', '0', 'houmashi', '0', '0');
INSERT INTO `district` VALUES ('2414', '霍州市', '2397', ',2340,2397,2414,', '3', '0', 'huozhoushi', '0', '0');
INSERT INTO `district` VALUES ('2415', '吕梁市', '2340', ',2340,2415,', '2', '0', 'lvliangshi', '0', '0');
INSERT INTO `district` VALUES ('2416', '离石区', '2415', ',2340,2415,2416,', '3', '0', 'lishiqu', '0', '0');
INSERT INTO `district` VALUES ('2417', '文水县', '2415', ',2340,2415,2417,', '3', '0', 'wenshuixian', '0', '0');
INSERT INTO `district` VALUES ('2418', '交城县', '2415', ',2340,2415,2418,', '3', '0', 'jiaochengxian', '0', '0');
INSERT INTO `district` VALUES ('2419', '兴县', '2415', ',2340,2415,2419,', '3', '0', 'xingxian', '0', '0');
INSERT INTO `district` VALUES ('2420', '临县', '2415', ',2340,2415,2420,', '3', '0', 'linxian', '0', '0');
INSERT INTO `district` VALUES ('2421', '柳林县', '2415', ',2340,2415,2421,', '3', '0', 'liulinxian', '0', '0');
INSERT INTO `district` VALUES ('2422', '石楼县', '2415', ',2340,2415,2422,', '3', '0', 'shilouxian', '0', '0');
INSERT INTO `district` VALUES ('2423', '岚县', '2415', ',2340,2415,2423,', '3', '0', 'xian', '0', '0');
INSERT INTO `district` VALUES ('2424', '方山县', '2415', ',2340,2415,2424,', '3', '0', 'fangshanxian', '0', '0');
INSERT INTO `district` VALUES ('2425', '中阳县', '2415', ',2340,2415,2425,', '3', '0', 'zhongyangxian', '0', '0');
INSERT INTO `district` VALUES ('2426', '交口县', '2415', ',2340,2415,2426,', '3', '0', 'jiaokouxian', '0', '0');
INSERT INTO `district` VALUES ('2427', '孝义市', '2415', ',2340,2415,2427,', '3', '0', 'xiaoyishi', '0', '0');
INSERT INTO `district` VALUES ('2428', '汾阳市', '2415', ',2340,2415,2428,', '3', '0', 'fenyangshi', '0', '0');
INSERT INTO `district` VALUES ('2429', '朔州市', '2340', ',2340,2429,', '2', '0', 'shuozhoushi', '0', '0');
INSERT INTO `district` VALUES ('2430', '朔城区', '2429', ',2340,2429,2430,', '3', '0', 'shuochengqu', '0', '0');
INSERT INTO `district` VALUES ('2431', '平鲁区', '2429', ',2340,2429,2431,', '3', '0', 'pingluqu', '0', '0');
INSERT INTO `district` VALUES ('2432', '山阴县', '2429', ',2340,2429,2432,', '3', '0', 'shanyinxian', '0', '0');
INSERT INTO `district` VALUES ('2433', '应县', '2429', ',2340,2429,2433,', '3', '0', 'yingxian', '0', '0');
INSERT INTO `district` VALUES ('2434', '右玉县', '2429', ',2340,2429,2434,', '3', '0', 'youyuxian', '0', '0');
INSERT INTO `district` VALUES ('2435', '怀仁县', '2429', ',2340,2429,2435,', '3', '0', 'huairenxian', '0', '0');
INSERT INTO `district` VALUES ('2436', '忻州市', '2340', ',2340,2436,', '2', '0', 'xinzhoushi', '0', '0');
INSERT INTO `district` VALUES ('2437', '忻府区', '2436', ',2340,2436,2437,', '3', '0', 'xinfuqu', '0', '0');
INSERT INTO `district` VALUES ('2438', '定襄县', '2436', ',2340,2436,2438,', '3', '0', 'dingxiangxian', '0', '0');
INSERT INTO `district` VALUES ('2439', '五台县', '2436', ',2340,2436,2439,', '3', '0', 'wutaixian', '0', '0');
INSERT INTO `district` VALUES ('2440', '代县', '2436', ',2340,2436,2440,', '3', '0', 'daixian', '0', '0');
INSERT INTO `district` VALUES ('2441', '繁峙县', '2436', ',2340,2436,2441,', '3', '0', 'fanzhixian', '0', '0');
INSERT INTO `district` VALUES ('2442', '宁武县', '2436', ',2340,2436,2442,', '3', '0', 'ningwuxian', '0', '0');
INSERT INTO `district` VALUES ('2443', '静乐县', '2436', ',2340,2436,2443,', '3', '0', 'jinglexian', '0', '0');
INSERT INTO `district` VALUES ('2444', '神池县', '2436', ',2340,2436,2444,', '3', '0', 'shenchixian', '0', '0');
INSERT INTO `district` VALUES ('2445', '五寨县', '2436', ',2340,2436,2445,', '3', '0', 'wuzhaixian', '0', '0');
INSERT INTO `district` VALUES ('2446', '岢岚县', '2436', ',2340,2436,2446,', '3', '0', 'xian', '0', '0');
INSERT INTO `district` VALUES ('2447', '河曲县', '2436', ',2340,2436,2447,', '3', '0', 'hequxian', '0', '0');
INSERT INTO `district` VALUES ('2448', '保德县', '2436', ',2340,2436,2448,', '3', '0', 'baodexian', '0', '0');
INSERT INTO `district` VALUES ('2449', '偏关县', '2436', ',2340,2436,2449,', '3', '0', 'pianguanxian', '0', '0');
INSERT INTO `district` VALUES ('2450', '原平市', '2436', ',2340,2436,2450,', '3', '0', 'yuanpingshi', '0', '0');
INSERT INTO `district` VALUES ('2451', '阳泉市', '2340', ',2340,2451,', '2', '0', 'yangquanshi', '0', '0');
INSERT INTO `district` VALUES ('2452', '城区', '2451', ',2340,2451,2452,', '3', '0', 'chengqu', '0', '0');
INSERT INTO `district` VALUES ('2453', '矿区', '2451', ',2340,2451,2453,', '3', '0', 'kuangqu', '0', '0');
INSERT INTO `district` VALUES ('2454', '郊区', '2451', ',2340,2451,2454,', '3', '0', 'jiaoqu', '0', '0');
INSERT INTO `district` VALUES ('2455', '平定县', '2451', ',2340,2451,2455,', '3', '0', 'pingdingxian', '0', '0');
INSERT INTO `district` VALUES ('2456', '盂县', '2451', ',2340,2451,2456,', '3', '0', 'yuxian', '0', '0');
INSERT INTO `district` VALUES ('2457', '运城市', '2340', ',2340,2457,', '2', '0', 'yunchengshi', '0', '0');
INSERT INTO `district` VALUES ('2458', '盐湖区', '2457', ',2340,2457,2458,', '3', '0', 'yanhuqu', '0', '0');
INSERT INTO `district` VALUES ('2459', '临猗县', '2457', ',2340,2457,2459,', '3', '0', 'linxian', '0', '0');
INSERT INTO `district` VALUES ('2460', '万荣县', '2457', ',2340,2457,2460,', '3', '0', 'wanrongxian', '0', '0');
INSERT INTO `district` VALUES ('2461', '闻喜县', '2457', ',2340,2457,2461,', '3', '0', 'wenxixian', '0', '0');
INSERT INTO `district` VALUES ('2462', '稷山县', '2457', ',2340,2457,2462,', '3', '0', 'shanxian', '0', '0');
INSERT INTO `district` VALUES ('2463', '新绛县', '2457', ',2340,2457,2463,', '3', '0', 'xinxian', '0', '0');
INSERT INTO `district` VALUES ('2464', '绛县', '2457', ',2340,2457,2464,', '3', '0', 'xian', '0', '0');
INSERT INTO `district` VALUES ('2465', '垣曲县', '2457', ',2340,2457,2465,', '3', '0', 'yuanquxian', '0', '0');
INSERT INTO `district` VALUES ('2466', '夏县', '2457', ',2340,2457,2466,', '3', '0', 'xiaxian', '0', '0');
INSERT INTO `district` VALUES ('2467', '平陆县', '2457', ',2340,2457,2467,', '3', '0', 'pingluxian', '0', '0');
INSERT INTO `district` VALUES ('2468', '芮城县', '2457', ',2340,2457,2468,', '3', '0', 'chengxian', '0', '0');
INSERT INTO `district` VALUES ('2469', '永济市', '2457', ',2340,2457,2469,', '3', '0', 'yongjishi', '0', '0');
INSERT INTO `district` VALUES ('2470', '河津市', '2457', ',2340,2457,2470,', '3', '0', 'hejinshi', '0', '0');
INSERT INTO `district` VALUES ('2471', '陕西省', '0', ',2471,', '1', '0', 'shanxisheng', '0', '0');
INSERT INTO `district` VALUES ('2472', '西安市', '2471', ',2471,2472,', '2', '0', 'xianshi', '0', '0');
INSERT INTO `district` VALUES ('2473', '新城区', '2472', ',2471,2472,2473,', '3', '0', 'xinchengqu', '0', '0');
INSERT INTO `district` VALUES ('2474', '碑林区', '2472', ',2471,2472,2474,', '3', '0', 'beilinqu', '0', '0');
INSERT INTO `district` VALUES ('2475', '莲湖区', '2472', ',2471,2472,2475,', '3', '0', 'lianhuqu', '0', '0');
INSERT INTO `district` VALUES ('2476', '灞桥区', '2472', ',2471,2472,2476,', '3', '0', 'qiaoqu', '0', '0');
INSERT INTO `district` VALUES ('2477', '未央区', '2472', ',2471,2472,2477,', '3', '0', 'weiyangqu', '0', '0');
INSERT INTO `district` VALUES ('2478', '雁塔区', '2472', ',2471,2472,2478,', '3', '0', 'yantaqu', '0', '0');
INSERT INTO `district` VALUES ('2479', '阎良区', '2472', ',2471,2472,2479,', '3', '0', 'yanliangqu', '0', '0');
INSERT INTO `district` VALUES ('2480', '临潼区', '2472', ',2471,2472,2480,', '3', '0', 'linqu', '0', '0');
INSERT INTO `district` VALUES ('2481', '长安区', '2472', ',2471,2472,2481,', '3', '0', 'changanqu', '0', '0');
INSERT INTO `district` VALUES ('2482', '蓝田县', '2472', ',2471,2472,2482,', '3', '0', 'lantianxian', '0', '0');
INSERT INTO `district` VALUES ('2483', '周至县', '2472', ',2471,2472,2483,', '3', '0', 'zhouzhixian', '0', '0');
INSERT INTO `district` VALUES ('2484', '户县', '2472', ',2471,2472,2484,', '3', '0', 'huxian', '0', '0');
INSERT INTO `district` VALUES ('2485', '高陵县', '2472', ',2471,2472,2485,', '3', '0', 'gaolingxian', '0', '0');
INSERT INTO `district` VALUES ('2486', '安康市', '2471', ',2471,2486,', '2', '0', 'ankangshi', '0', '0');
INSERT INTO `district` VALUES ('2487', '汉滨区', '2486', ',2471,2486,2487,', '3', '0', 'hanbinqu', '0', '0');
INSERT INTO `district` VALUES ('2488', '汉阴县', '2486', ',2471,2486,2488,', '3', '0', 'hanyinxian', '0', '0');
INSERT INTO `district` VALUES ('2489', '石泉县', '2486', ',2471,2486,2489,', '3', '0', 'shiquanxian', '0', '0');
INSERT INTO `district` VALUES ('2490', '宁陕县', '2486', ',2471,2486,2490,', '3', '0', 'ningshanxian', '0', '0');
INSERT INTO `district` VALUES ('2491', '紫阳县', '2486', ',2471,2486,2491,', '3', '0', 'ziyangxian', '0', '0');
INSERT INTO `district` VALUES ('2492', '岚皋县', '2486', ',2471,2486,2492,', '3', '0', 'gaoxian', '0', '0');
INSERT INTO `district` VALUES ('2493', '平利县', '2486', ',2471,2486,2493,', '3', '0', 'pinglixian', '0', '0');
INSERT INTO `district` VALUES ('2494', '镇坪县', '2486', ',2471,2486,2494,', '3', '0', 'zhenpingxian', '0', '0');
INSERT INTO `district` VALUES ('2495', '旬阳县', '2486', ',2471,2486,2495,', '3', '0', 'xunyangxian', '0', '0');
INSERT INTO `district` VALUES ('2496', '白河县', '2486', ',2471,2486,2496,', '3', '0', 'baihexian', '0', '0');
INSERT INTO `district` VALUES ('2497', '宝鸡市', '2471', ',2471,2497,', '2', '0', 'baojishi', '0', '0');
INSERT INTO `district` VALUES ('2498', '渭滨区', '2497', ',2471,2497,2498,', '3', '0', 'weibinqu', '0', '0');
INSERT INTO `district` VALUES ('2499', '金台区', '2497', ',2471,2497,2499,', '3', '0', 'jintaiqu', '0', '0');
INSERT INTO `district` VALUES ('2500', '陈仓区', '2497', ',2471,2497,2500,', '3', '0', 'chencangqu', '0', '0');
INSERT INTO `district` VALUES ('2501', '凤翔县', '2497', ',2471,2497,2501,', '3', '0', 'fengxiangxian', '0', '0');
INSERT INTO `district` VALUES ('2502', '岐山县', '2497', ',2471,2497,2502,', '3', '0', 'shanxian', '0', '0');
INSERT INTO `district` VALUES ('2503', '扶风县', '2497', ',2471,2497,2503,', '3', '0', 'fufengxian', '0', '0');
INSERT INTO `district` VALUES ('2504', '眉县', '2497', ',2471,2497,2504,', '3', '0', 'meixian', '0', '0');
INSERT INTO `district` VALUES ('2505', '陇县', '2497', ',2471,2497,2505,', '3', '0', 'longxian', '0', '0');
INSERT INTO `district` VALUES ('2506', '千阳县', '2497', ',2471,2497,2506,', '3', '0', 'qianyangxian', '0', '0');
INSERT INTO `district` VALUES ('2507', '麟游县', '2497', ',2471,2497,2507,', '3', '0', 'youxian', '0', '0');
INSERT INTO `district` VALUES ('2508', '凤县', '2497', ',2471,2497,2508,', '3', '0', 'fengxian', '0', '0');
INSERT INTO `district` VALUES ('2509', '太白县', '2497', ',2471,2497,2509,', '3', '0', 'taibaixian', '0', '0');
INSERT INTO `district` VALUES ('2510', '汉中市', '2471', ',2471,2510,', '2', '0', 'hanzhongshi', '0', '0');
INSERT INTO `district` VALUES ('2511', '汉台区', '2510', ',2471,2510,2511,', '3', '0', 'hantaiqu', '0', '0');
INSERT INTO `district` VALUES ('2512', '南郑县', '2510', ',2471,2510,2512,', '3', '0', 'nanzhengxian', '0', '0');
INSERT INTO `district` VALUES ('2513', '城固县', '2510', ',2471,2510,2513,', '3', '0', 'chengguxian', '0', '0');
INSERT INTO `district` VALUES ('2514', '洋县', '2510', ',2471,2510,2514,', '3', '0', 'yangxian', '0', '0');
INSERT INTO `district` VALUES ('2515', '西乡县', '2510', ',2471,2510,2515,', '3', '0', 'xixiangxian', '0', '0');
INSERT INTO `district` VALUES ('2516', '勉县', '2510', ',2471,2510,2516,', '3', '0', 'mianxian', '0', '0');
INSERT INTO `district` VALUES ('2517', '宁强县', '2510', ',2471,2510,2517,', '3', '0', 'ningqiangxian', '0', '0');
INSERT INTO `district` VALUES ('2518', '略阳县', '2510', ',2471,2510,2518,', '3', '0', 'lueyangxian', '0', '0');
INSERT INTO `district` VALUES ('2519', '镇巴县', '2510', ',2471,2510,2519,', '3', '0', 'zhenbaxian', '0', '0');
INSERT INTO `district` VALUES ('2520', '留坝县', '2510', ',2471,2510,2520,', '3', '0', 'liubaxian', '0', '0');
INSERT INTO `district` VALUES ('2521', '佛坪县', '2510', ',2471,2510,2521,', '3', '0', 'fopingxian', '0', '0');
INSERT INTO `district` VALUES ('2522', '商洛市', '2471', ',2471,2522,', '2', '0', 'shangluoshi', '0', '0');
INSERT INTO `district` VALUES ('2523', '商州区', '2522', ',2471,2522,2523,', '3', '0', 'shangzhouqu', '0', '0');
INSERT INTO `district` VALUES ('2524', '洛南县', '2522', ',2471,2522,2524,', '3', '0', 'luonanxian', '0', '0');
INSERT INTO `district` VALUES ('2525', '丹凤县', '2522', ',2471,2522,2525,', '3', '0', 'danfengxian', '0', '0');
INSERT INTO `district` VALUES ('2526', '商南县', '2522', ',2471,2522,2526,', '3', '0', 'shangnanxian', '0', '0');
INSERT INTO `district` VALUES ('2527', '山阳县', '2522', ',2471,2522,2527,', '3', '0', 'shanyangxian', '0', '0');
INSERT INTO `district` VALUES ('2528', '镇安县', '2522', ',2471,2522,2528,', '3', '0', 'zhenanxian', '0', '0');
INSERT INTO `district` VALUES ('2529', '柞水县', '2522', ',2471,2522,2529,', '3', '0', 'zuoshuixian', '0', '0');
INSERT INTO `district` VALUES ('2530', '铜川市', '2471', ',2471,2530,', '2', '0', 'tongchuanshi', '0', '0');
INSERT INTO `district` VALUES ('2531', '王益区', '2530', ',2471,2530,2531,', '3', '0', 'wangyiqu', '0', '0');
INSERT INTO `district` VALUES ('2532', '印台区', '2530', ',2471,2530,2532,', '3', '0', 'yintaiqu', '0', '0');
INSERT INTO `district` VALUES ('2533', '耀州区', '2530', ',2471,2530,2533,', '3', '0', 'yaozhouqu', '0', '0');
INSERT INTO `district` VALUES ('2534', '宜君县', '2530', ',2471,2530,2534,', '3', '0', 'yijunxian', '0', '0');
INSERT INTO `district` VALUES ('2535', '渭南市', '2471', ',2471,2535,', '2', '0', 'weinanshi', '0', '0');
INSERT INTO `district` VALUES ('2536', '临渭区', '2535', ',2471,2535,2536,', '3', '0', 'linweiqu', '0', '0');
INSERT INTO `district` VALUES ('2537', '华县', '2535', ',2471,2535,2537,', '3', '0', 'huaxian', '0', '0');
INSERT INTO `district` VALUES ('2538', '潼关县', '2535', ',2471,2535,2538,', '3', '0', 'guanxian', '0', '0');
INSERT INTO `district` VALUES ('2539', '大荔县', '2535', ',2471,2535,2539,', '3', '0', 'dalixian', '0', '0');
INSERT INTO `district` VALUES ('2540', '合阳县', '2535', ',2471,2535,2540,', '3', '0', 'heyangxian', '0', '0');
INSERT INTO `district` VALUES ('2541', '澄城县', '2535', ',2471,2535,2541,', '3', '0', 'chengchengxian', '0', '0');
INSERT INTO `district` VALUES ('2542', '蒲城县', '2535', ',2471,2535,2542,', '3', '0', 'puchengxian', '0', '0');
INSERT INTO `district` VALUES ('2543', '白水县', '2535', ',2471,2535,2543,', '3', '0', 'baishuixian', '0', '0');
INSERT INTO `district` VALUES ('2544', '富平县', '2535', ',2471,2535,2544,', '3', '0', 'fupingxian', '0', '0');
INSERT INTO `district` VALUES ('2545', '韩城市', '2535', ',2471,2535,2545,', '3', '0', 'hanchengshi', '0', '0');
INSERT INTO `district` VALUES ('2546', '华阴市', '2535', ',2471,2535,2546,', '3', '0', 'huayinshi', '0', '0');
INSERT INTO `district` VALUES ('2547', '咸阳市', '2471', ',2471,2547,', '2', '0', 'xianyangshi', '0', '0');
INSERT INTO `district` VALUES ('2548', '秦都区', '2547', ',2471,2547,2548,', '3', '0', 'qinduqu', '0', '0');
INSERT INTO `district` VALUES ('2549', '杨凌区', '2547', ',2471,2547,2549,', '3', '0', 'yanglingqu', '0', '0');
INSERT INTO `district` VALUES ('2550', '渭城区', '2547', ',2471,2547,2550,', '3', '0', 'weichengqu', '0', '0');
INSERT INTO `district` VALUES ('2551', '三原县', '2547', ',2471,2547,2551,', '3', '0', 'sanyuanxian', '0', '0');
INSERT INTO `district` VALUES ('2552', '泾阳县', '2547', ',2471,2547,2552,', '3', '0', 'yangxian', '0', '0');
INSERT INTO `district` VALUES ('2553', '乾县', '2547', ',2471,2547,2553,', '3', '0', 'qianxian', '0', '0');
INSERT INTO `district` VALUES ('2554', '礼泉县', '2547', ',2471,2547,2554,', '3', '0', 'liquanxian', '0', '0');
INSERT INTO `district` VALUES ('2555', '永寿县', '2547', ',2471,2547,2555,', '3', '0', 'yongshouxian', '0', '0');
INSERT INTO `district` VALUES ('2556', '彬县', '2547', ',2471,2547,2556,', '3', '0', 'binxian', '0', '0');
INSERT INTO `district` VALUES ('2557', '长武县', '2547', ',2471,2547,2557,', '3', '0', 'changwuxian', '0', '0');
INSERT INTO `district` VALUES ('2558', '旬邑县', '2547', ',2471,2547,2558,', '3', '0', 'xunyixian', '0', '0');
INSERT INTO `district` VALUES ('2559', '淳化县', '2547', ',2471,2547,2559,', '3', '0', 'chunhuaxian', '0', '0');
INSERT INTO `district` VALUES ('2560', '武功县', '2547', ',2471,2547,2560,', '3', '0', 'wugongxian', '0', '0');
INSERT INTO `district` VALUES ('2561', '兴平市', '2547', ',2471,2547,2561,', '3', '0', 'xingpingshi', '0', '0');
INSERT INTO `district` VALUES ('2562', '延安市', '2471', ',2471,2562,', '2', '0', 'yananshi', '0', '0');
INSERT INTO `district` VALUES ('2563', '宝塔区', '2562', ',2471,2562,2563,', '3', '0', 'baotaqu', '0', '0');
INSERT INTO `district` VALUES ('2564', '延长县', '2562', ',2471,2562,2564,', '3', '0', 'yanchangxian', '0', '0');
INSERT INTO `district` VALUES ('2565', '延川县', '2562', ',2471,2562,2565,', '3', '0', 'yanchuanxian', '0', '0');
INSERT INTO `district` VALUES ('2566', '子长县', '2562', ',2471,2562,2566,', '3', '0', 'zichangxian', '0', '0');
INSERT INTO `district` VALUES ('2567', '安塞县', '2562', ',2471,2562,2567,', '3', '0', 'ansaixian', '0', '0');
INSERT INTO `district` VALUES ('2568', '志丹县', '2562', ',2471,2562,2568,', '3', '0', 'zhidanxian', '0', '0');
INSERT INTO `district` VALUES ('2569', '吴旗县', '2562', ',2471,2562,2569,', '3', '0', 'wuqixian', '0', '0');
INSERT INTO `district` VALUES ('2570', '甘泉县', '2562', ',2471,2562,2570,', '3', '0', 'ganquanxian', '0', '0');
INSERT INTO `district` VALUES ('2571', '富县', '2562', ',2471,2562,2571,', '3', '0', 'fuxian', '0', '0');
INSERT INTO `district` VALUES ('2572', '洛川县', '2562', ',2471,2562,2572,', '3', '0', 'luochuanxian', '0', '0');
INSERT INTO `district` VALUES ('2573', '宜川县', '2562', ',2471,2562,2573,', '3', '0', 'yichuanxian', '0', '0');
INSERT INTO `district` VALUES ('2574', '黄龙县', '2562', ',2471,2562,2574,', '3', '0', 'huanglongxian', '0', '0');
INSERT INTO `district` VALUES ('2575', '黄陵县', '2562', ',2471,2562,2575,', '3', '0', 'huanglingxian', '0', '0');
INSERT INTO `district` VALUES ('2576', '榆林市', '2471', ',2471,2576,', '2', '0', 'yulinshi', '0', '0');
INSERT INTO `district` VALUES ('2577', '榆阳区', '2576', ',2471,2576,2577,', '3', '0', 'yuyangqu', '0', '0');
INSERT INTO `district` VALUES ('2578', '神木县', '2576', ',2471,2576,2578,', '3', '0', 'shenmuxian', '0', '0');
INSERT INTO `district` VALUES ('2579', '府谷县', '2576', ',2471,2576,2579,', '3', '0', 'fuguxian', '0', '0');
INSERT INTO `district` VALUES ('2580', '横山县', '2576', ',2471,2576,2580,', '3', '0', 'hengshanxian', '0', '0');
INSERT INTO `district` VALUES ('2581', '靖边县', '2576', ',2471,2576,2581,', '3', '0', 'jingbianxian', '0', '0');
INSERT INTO `district` VALUES ('2582', '定边县', '2576', ',2471,2576,2582,', '3', '0', 'dingbianxian', '0', '0');
INSERT INTO `district` VALUES ('2583', '绥德县', '2576', ',2471,2576,2583,', '3', '0', 'suidexian', '0', '0');
INSERT INTO `district` VALUES ('2584', '米脂县', '2576', ',2471,2576,2584,', '3', '0', 'mizhixian', '0', '0');
INSERT INTO `district` VALUES ('2585', '佳县', '2576', ',2471,2576,2585,', '3', '0', 'jiaxian', '0', '0');
INSERT INTO `district` VALUES ('2586', '吴堡县', '2576', ',2471,2576,2586,', '3', '0', 'wubaoxian', '0', '0');
INSERT INTO `district` VALUES ('2587', '清涧县', '2576', ',2471,2576,2587,', '3', '0', 'qingjianxian', '0', '0');
INSERT INTO `district` VALUES ('2588', '子洲县', '2576', ',2471,2576,2588,', '3', '0', 'zizhouxian', '0', '0');
INSERT INTO `district` VALUES ('2589', '四川省', '0', ',2589,', '1', '0', 'sichuansheng', '0', '0');
INSERT INTO `district` VALUES ('2590', '成都市', '2589', ',2589,2590,', '2', '0', 'chengdushi', '0', '0');
INSERT INTO `district` VALUES ('2591', '锦江区', '2590', ',2589,2590,2591,', '3', '0', 'jinjiangqu', '0', '0');
INSERT INTO `district` VALUES ('2592', '青羊区', '2590', ',2589,2590,2592,', '3', '0', 'qingyangqu', '0', '0');
INSERT INTO `district` VALUES ('2593', '金牛区', '2590', ',2589,2590,2593,', '3', '0', 'jinniuqu', '0', '0');
INSERT INTO `district` VALUES ('2594', '武侯区', '2590', ',2589,2590,2594,', '3', '0', 'wuhouqu', '0', '0');
INSERT INTO `district` VALUES ('2595', '成华区', '2590', ',2589,2590,2595,', '3', '0', 'chenghuaqu', '0', '0');
INSERT INTO `district` VALUES ('2596', '龙泉驿区', '2590', ',2589,2590,2596,', '3', '0', 'longquanqu', '0', '0');
INSERT INTO `district` VALUES ('2597', '青白江区', '2590', ',2589,2590,2597,', '3', '0', 'qingbaijiangqu', '0', '0');
INSERT INTO `district` VALUES ('2598', '新都区', '2590', ',2589,2590,2598,', '3', '0', 'xinduqu', '0', '0');
INSERT INTO `district` VALUES ('2599', '温江区', '2590', ',2589,2590,2599,', '3', '0', 'wenjiangqu', '0', '0');
INSERT INTO `district` VALUES ('2600', '金堂县', '2590', ',2589,2590,2600,', '3', '0', 'jintangxian', '0', '0');
INSERT INTO `district` VALUES ('2601', '双流县', '2590', ',2589,2590,2601,', '3', '0', 'shuangliuxian', '0', '0');
INSERT INTO `district` VALUES ('2602', '郫县', '2590', ',2589,2590,2602,', '3', '0', 'xian', '0', '0');
INSERT INTO `district` VALUES ('2603', '大邑县', '2590', ',2589,2590,2603,', '3', '0', 'dayixian', '0', '0');
INSERT INTO `district` VALUES ('2604', '蒲江县', '2590', ',2589,2590,2604,', '3', '0', 'pujiangxian', '0', '0');
INSERT INTO `district` VALUES ('2605', '新津县', '2590', ',2589,2590,2605,', '3', '0', 'xinjinxian', '0', '0');
INSERT INTO `district` VALUES ('2606', '都江堰市', '2590', ',2589,2590,2606,', '3', '0', 'dujiangyanshi', '0', '0');
INSERT INTO `district` VALUES ('2607', '彭州市', '2590', ',2589,2590,2607,', '3', '0', 'pengzhoushi', '0', '0');
INSERT INTO `district` VALUES ('2608', '邛崃市', '2590', ',2589,2590,2608,', '3', '0', 'shi', '0', '0');
INSERT INTO `district` VALUES ('2609', '崇州市', '2590', ',2589,2590,2609,', '3', '0', 'chongzhoushi', '0', '0');
INSERT INTO `district` VALUES ('2610', '阿坝藏族羌族自治州', '2589', ',2589,2610,', '2', '0', 'abacangzuqiangzuzizhizhou', '0', '0');
INSERT INTO `district` VALUES ('2611', '汶川县', '2610', ',2589,2610,2611,', '3', '0', 'chuanxian', '0', '0');
INSERT INTO `district` VALUES ('2612', '理县', '2610', ',2589,2610,2612,', '3', '0', 'lixian', '0', '0');
INSERT INTO `district` VALUES ('2613', '茂县', '2610', ',2589,2610,2613,', '3', '0', 'maoxian', '0', '0');
INSERT INTO `district` VALUES ('2614', '松潘县', '2610', ',2589,2610,2614,', '3', '0', 'songpanxian', '0', '0');
INSERT INTO `district` VALUES ('2615', '九寨沟县', '2610', ',2589,2610,2615,', '3', '0', 'jiuzhaigouxian', '0', '0');
INSERT INTO `district` VALUES ('2616', '金川县', '2610', ',2589,2610,2616,', '3', '0', 'jinchuanxian', '0', '0');
INSERT INTO `district` VALUES ('2617', '小金县', '2610', ',2589,2610,2617,', '3', '0', 'xiaojinxian', '0', '0');
INSERT INTO `district` VALUES ('2618', '黑水县', '2610', ',2589,2610,2618,', '3', '0', 'heishuixian', '0', '0');
INSERT INTO `district` VALUES ('2619', '马尔康县', '2610', ',2589,2610,2619,', '3', '0', 'maerkangxian', '0', '0');
INSERT INTO `district` VALUES ('2620', '壤塘县', '2610', ',2589,2610,2620,', '3', '0', 'rangtangxian', '0', '0');
INSERT INTO `district` VALUES ('2621', '阿坝县', '2610', ',2589,2610,2621,', '3', '0', 'abaxian', '0', '0');
INSERT INTO `district` VALUES ('2622', '若尔盖县', '2610', ',2589,2610,2622,', '3', '0', 'ruoergaixian', '0', '0');
INSERT INTO `district` VALUES ('2623', '红原县', '2610', ',2589,2610,2623,', '3', '0', 'hongyuanxian', '0', '0');
INSERT INTO `district` VALUES ('2624', '巴中市', '2589', ',2589,2624,', '2', '0', 'bazhongshi', '0', '0');
INSERT INTO `district` VALUES ('2625', '巴州区', '2624', ',2589,2624,2625,', '3', '0', 'bazhouqu', '0', '0');
INSERT INTO `district` VALUES ('2626', '通江县', '2624', ',2589,2624,2626,', '3', '0', 'tongjiangxian', '0', '0');
INSERT INTO `district` VALUES ('2627', '南江县', '2624', ',2589,2624,2627,', '3', '0', 'nanjiangxian', '0', '0');
INSERT INTO `district` VALUES ('2628', '平昌县', '2624', ',2589,2624,2628,', '3', '0', 'pingchangxian', '0', '0');
INSERT INTO `district` VALUES ('2629', '达州市', '2589', ',2589,2629,', '2', '0', 'dazhoushi', '0', '0');
INSERT INTO `district` VALUES ('2630', '通川区', '2629', ',2589,2629,2630,', '3', '0', 'tongchuanqu', '0', '0');
INSERT INTO `district` VALUES ('2631', '达县', '2629', ',2589,2629,2631,', '3', '0', 'daxian', '0', '0');
INSERT INTO `district` VALUES ('2632', '宣汉县', '2629', ',2589,2629,2632,', '3', '0', 'xuanhanxian', '0', '0');
INSERT INTO `district` VALUES ('2633', '开江县', '2629', ',2589,2629,2633,', '3', '0', 'kaijiangxian', '0', '0');
INSERT INTO `district` VALUES ('2634', '大竹县', '2629', ',2589,2629,2634,', '3', '0', 'dazhuxian', '0', '0');
INSERT INTO `district` VALUES ('2635', '渠县', '2629', ',2589,2629,2635,', '3', '0', 'quxian', '0', '0');
INSERT INTO `district` VALUES ('2636', '万源市', '2629', ',2589,2629,2636,', '3', '0', 'wanyuanshi', '0', '0');
INSERT INTO `district` VALUES ('2637', '德阳市', '2589', ',2589,2637,', '2', '0', 'deyangshi', '0', '0');
INSERT INTO `district` VALUES ('2638', '旌阳区', '2637', ',2589,2637,2638,', '3', '0', 'yangqu', '0', '0');
INSERT INTO `district` VALUES ('2639', '中江县', '2637', ',2589,2637,2639,', '3', '0', 'zhongjiangxian', '0', '0');
INSERT INTO `district` VALUES ('2640', '罗江县', '2637', ',2589,2637,2640,', '3', '0', 'luojiangxian', '0', '0');
INSERT INTO `district` VALUES ('2641', '广汉市', '2637', ',2589,2637,2641,', '3', '0', 'guanghanshi', '0', '0');
INSERT INTO `district` VALUES ('2642', '什邡市', '2637', ',2589,2637,2642,', '3', '0', 'shishi', '0', '0');
INSERT INTO `district` VALUES ('2643', '绵竹市', '2637', ',2589,2637,2643,', '3', '0', 'mianzhushi', '0', '0');
INSERT INTO `district` VALUES ('2644', '甘孜藏族自治州', '2589', ',2589,2644,', '2', '0', 'ganzicangzuzizhizhou', '0', '0');
INSERT INTO `district` VALUES ('2645', '康定县', '2644', ',2589,2644,2645,', '3', '0', 'kangdingxian', '0', '0');
INSERT INTO `district` VALUES ('2646', '泸定县', '2644', ',2589,2644,2646,', '3', '0', 'dingxian', '0', '0');
INSERT INTO `district` VALUES ('2647', '丹巴县', '2644', ',2589,2644,2647,', '3', '0', 'danbaxian', '0', '0');
INSERT INTO `district` VALUES ('2648', '九龙县', '2644', ',2589,2644,2648,', '3', '0', 'jiulongxian', '0', '0');
INSERT INTO `district` VALUES ('2649', '雅江县', '2644', ',2589,2644,2649,', '3', '0', 'yajiangxian', '0', '0');
INSERT INTO `district` VALUES ('2650', '道孚县', '2644', ',2589,2644,2650,', '3', '0', 'daoxian', '0', '0');
INSERT INTO `district` VALUES ('2651', '炉霍县', '2644', ',2589,2644,2651,', '3', '0', 'luhuoxian', '0', '0');
INSERT INTO `district` VALUES ('2652', '甘孜县', '2644', ',2589,2644,2652,', '3', '0', 'ganzixian', '0', '0');
INSERT INTO `district` VALUES ('2653', '新龙县', '2644', ',2589,2644,2653,', '3', '0', 'xinlongxian', '0', '0');
INSERT INTO `district` VALUES ('2654', '德格县', '2644', ',2589,2644,2654,', '3', '0', 'degexian', '0', '0');
INSERT INTO `district` VALUES ('2655', '白玉县', '2644', ',2589,2644,2655,', '3', '0', 'baiyuxian', '0', '0');
INSERT INTO `district` VALUES ('2656', '石渠县', '2644', ',2589,2644,2656,', '3', '0', 'shiquxian', '0', '0');
INSERT INTO `district` VALUES ('2657', '色达县', '2644', ',2589,2644,2657,', '3', '0', 'sedaxian', '0', '0');
INSERT INTO `district` VALUES ('2658', '理塘县', '2644', ',2589,2644,2658,', '3', '0', 'litangxian', '0', '0');
INSERT INTO `district` VALUES ('2659', '巴塘县', '2644', ',2589,2644,2659,', '3', '0', 'batangxian', '0', '0');
INSERT INTO `district` VALUES ('2660', '乡城县', '2644', ',2589,2644,2660,', '3', '0', 'xiangchengxian', '0', '0');
INSERT INTO `district` VALUES ('2661', '稻城县', '2644', ',2589,2644,2661,', '3', '0', 'daochengxian', '0', '0');
INSERT INTO `district` VALUES ('2662', '得荣县', '2644', ',2589,2644,2662,', '3', '0', 'derongxian', '0', '0');
INSERT INTO `district` VALUES ('2663', '广安市', '2589', ',2589,2663,', '2', '0', 'guanganshi', '0', '0');
INSERT INTO `district` VALUES ('2664', '广安区', '2663', ',2589,2663,2664,', '3', '0', 'guanganqu', '0', '0');
INSERT INTO `district` VALUES ('2665', '岳池县', '2663', ',2589,2663,2665,', '3', '0', 'yuechixian', '0', '0');
INSERT INTO `district` VALUES ('2666', '武胜县', '2663', ',2589,2663,2666,', '3', '0', 'wushengxian', '0', '0');
INSERT INTO `district` VALUES ('2667', '邻水县', '2663', ',2589,2663,2667,', '3', '0', 'linshuixian', '0', '0');
INSERT INTO `district` VALUES ('2668', '华莹市', '2663', ',2589,2663,2668,', '3', '0', 'huayingshi', '0', '0');
INSERT INTO `district` VALUES ('2669', '广元市', '2589', ',2589,2669,', '2', '0', 'guangyuanshi', '0', '0');
INSERT INTO `district` VALUES ('2670', '市中区', '2669', ',2589,2669,2670,', '3', '0', 'shizhongqu', '0', '0');
INSERT INTO `district` VALUES ('2671', '元坝区', '2669', ',2589,2669,2671,', '3', '0', 'yuanbaqu', '0', '0');
INSERT INTO `district` VALUES ('2672', '朝天区', '2669', ',2589,2669,2672,', '3', '0', 'chaotianqu', '0', '0');
INSERT INTO `district` VALUES ('2673', '旺苍县', '2669', ',2589,2669,2673,', '3', '0', 'wangcangxian', '0', '0');
INSERT INTO `district` VALUES ('2674', '青川县', '2669', ',2589,2669,2674,', '3', '0', 'qingchuanxian', '0', '0');
INSERT INTO `district` VALUES ('2675', '剑阁县', '2669', ',2589,2669,2675,', '3', '0', 'jiangexian', '0', '0');
INSERT INTO `district` VALUES ('2676', '苍溪县', '2669', ',2589,2669,2676,', '3', '0', 'cangxixian', '0', '0');
INSERT INTO `district` VALUES ('2677', '乐山市', '2589', ',2589,2677,', '2', '0', 'leshanshi', '0', '0');
INSERT INTO `district` VALUES ('2678', '市中区', '2677', ',2589,2677,2678,', '3', '0', 'shizhongqu', '0', '0');
INSERT INTO `district` VALUES ('2679', '沙湾区', '2677', ',2589,2677,2679,', '3', '0', 'shawanqu', '0', '0');
INSERT INTO `district` VALUES ('2680', '五通桥区', '2677', ',2589,2677,2680,', '3', '0', 'wutongqiaoqu', '0', '0');
INSERT INTO `district` VALUES ('2681', '金口河区', '2677', ',2589,2677,2681,', '3', '0', 'jinkouhequ', '0', '0');
INSERT INTO `district` VALUES ('2682', '犍为县', '2677', ',2589,2677,2682,', '3', '0', 'weixian', '0', '0');
INSERT INTO `district` VALUES ('2683', '井研县', '2677', ',2589,2677,2683,', '3', '0', 'jingyanxian', '0', '0');
INSERT INTO `district` VALUES ('2684', '夹江县', '2677', ',2589,2677,2684,', '3', '0', 'jiajiangxian', '0', '0');
INSERT INTO `district` VALUES ('2685', '沐川县', '2677', ',2589,2677,2685,', '3', '0', 'chuanxian', '0', '0');
INSERT INTO `district` VALUES ('2686', '峨边彝族自治县', '2677', ',2589,2677,2686,', '3', '0', 'ebianyizuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('2687', '马边彝族自治县', '2677', ',2589,2677,2687,', '3', '0', 'mabianyizuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('2688', '峨眉山市', '2677', ',2589,2677,2688,', '3', '0', 'emeishanshi', '0', '0');
INSERT INTO `district` VALUES ('2689', '凉山彝族自治州', '2589', ',2589,2689,', '2', '0', 'liangshanyizuzizhizhou', '0', '0');
INSERT INTO `district` VALUES ('2690', '西昌市', '2689', ',2589,2689,2690,', '3', '0', 'xichangshi', '0', '0');
INSERT INTO `district` VALUES ('2691', '木里藏族自治县', '2689', ',2589,2689,2691,', '3', '0', 'mulicangzuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('2692', '盐源县', '2689', ',2589,2689,2692,', '3', '0', 'yanyuanxian', '0', '0');
INSERT INTO `district` VALUES ('2693', '德昌县', '2689', ',2589,2689,2693,', '3', '0', 'dechangxian', '0', '0');
INSERT INTO `district` VALUES ('2694', '会理县', '2689', ',2589,2689,2694,', '3', '0', 'huilixian', '0', '0');
INSERT INTO `district` VALUES ('2695', '会东县', '2689', ',2589,2689,2695,', '3', '0', 'huidongxian', '0', '0');
INSERT INTO `district` VALUES ('2696', '宁南县', '2689', ',2589,2689,2696,', '3', '0', 'ningnanxian', '0', '0');
INSERT INTO `district` VALUES ('2697', '普格县', '2689', ',2589,2689,2697,', '3', '0', 'pugexian', '0', '0');
INSERT INTO `district` VALUES ('2698', '布拖县', '2689', ',2589,2689,2698,', '3', '0', 'butuoxian', '0', '0');
INSERT INTO `district` VALUES ('2699', '金阳县', '2689', ',2589,2689,2699,', '3', '0', 'jinyangxian', '0', '0');
INSERT INTO `district` VALUES ('2700', '昭觉县', '2689', ',2589,2689,2700,', '3', '0', 'zhaojuexian', '0', '0');
INSERT INTO `district` VALUES ('2701', '喜德县', '2689', ',2589,2689,2701,', '3', '0', 'xidexian', '0', '0');
INSERT INTO `district` VALUES ('2702', '冕宁县', '2689', ',2589,2689,2702,', '3', '0', 'mianningxian', '0', '0');
INSERT INTO `district` VALUES ('2703', '越西县', '2689', ',2589,2689,2703,', '3', '0', 'yuexixian', '0', '0');
INSERT INTO `district` VALUES ('2704', '甘洛县', '2689', ',2589,2689,2704,', '3', '0', 'ganluoxian', '0', '0');
INSERT INTO `district` VALUES ('2705', '美姑县', '2689', ',2589,2689,2705,', '3', '0', 'meiguxian', '0', '0');
INSERT INTO `district` VALUES ('2706', '雷波县', '2689', ',2589,2689,2706,', '3', '0', 'leiboxian', '0', '0');
INSERT INTO `district` VALUES ('2707', '泸州市', '2589', ',2589,2707,', '2', '0', 'zhoushi', '0', '0');
INSERT INTO `district` VALUES ('2708', '江阳区', '2707', ',2589,2707,2708,', '3', '0', 'jiangyangqu', '0', '0');
INSERT INTO `district` VALUES ('2709', '纳溪区', '2707', ',2589,2707,2709,', '3', '0', 'naxiqu', '0', '0');
INSERT INTO `district` VALUES ('2710', '龙马潭区', '2707', ',2589,2707,2710,', '3', '0', 'longmatanqu', '0', '0');
INSERT INTO `district` VALUES ('2711', '泸县', '2707', ',2589,2707,2711,', '3', '0', 'xian', '0', '0');
INSERT INTO `district` VALUES ('2712', '合江县', '2707', ',2589,2707,2712,', '3', '0', 'hejiangxian', '0', '0');
INSERT INTO `district` VALUES ('2713', '叙永县', '2707', ',2589,2707,2713,', '3', '0', 'xuyongxian', '0', '0');
INSERT INTO `district` VALUES ('2714', '古蔺县', '2707', ',2589,2707,2714,', '3', '0', 'guxian', '0', '0');
INSERT INTO `district` VALUES ('2715', '眉山市', '2589', ',2589,2715,', '2', '0', 'meishanshi', '0', '0');
INSERT INTO `district` VALUES ('2716', '东坡区', '2715', ',2589,2715,2716,', '3', '0', 'dongpoqu', '0', '0');
INSERT INTO `district` VALUES ('2717', '仁寿县', '2715', ',2589,2715,2717,', '3', '0', 'renshouxian', '0', '0');
INSERT INTO `district` VALUES ('2718', '彭山县', '2715', ',2589,2715,2718,', '3', '0', 'pengshanxian', '0', '0');
INSERT INTO `district` VALUES ('2719', '洪雅县', '2715', ',2589,2715,2719,', '3', '0', 'hongyaxian', '0', '0');
INSERT INTO `district` VALUES ('2720', '丹棱县', '2715', ',2589,2715,2720,', '3', '0', 'danlengxian', '0', '0');
INSERT INTO `district` VALUES ('2721', '青神县', '2715', ',2589,2715,2721,', '3', '0', 'qingshenxian', '0', '0');
INSERT INTO `district` VALUES ('2722', '绵阳市', '2589', ',2589,2722,', '2', '0', 'mianyangshi', '0', '0');
INSERT INTO `district` VALUES ('2723', '涪城区', '2722', ',2589,2722,2723,', '3', '0', 'fuchengqu', '0', '0');
INSERT INTO `district` VALUES ('2724', '游仙区', '2722', ',2589,2722,2724,', '3', '0', 'youxianqu', '0', '0');
INSERT INTO `district` VALUES ('2725', '三台县', '2722', ',2589,2722,2725,', '3', '0', 'santaixian', '0', '0');
INSERT INTO `district` VALUES ('2726', '盐亭县', '2722', ',2589,2722,2726,', '3', '0', 'yantingxian', '0', '0');
INSERT INTO `district` VALUES ('2727', '安县', '2722', ',2589,2722,2727,', '3', '0', 'anxian', '0', '0');
INSERT INTO `district` VALUES ('2728', '梓潼县', '2722', ',2589,2722,2728,', '3', '0', 'xian', '0', '0');
INSERT INTO `district` VALUES ('2729', '北川羌族自治县', '2722', ',2589,2722,2729,', '3', '0', 'beichuanqiangzuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('2730', '平武县', '2722', ',2589,2722,2730,', '3', '0', 'pingwuxian', '0', '0');
INSERT INTO `district` VALUES ('2731', '江油市', '2722', ',2589,2722,2731,', '3', '0', 'jiangyoushi', '0', '0');
INSERT INTO `district` VALUES ('2732', '内江市', '2589', ',2589,2732,', '2', '0', 'neijiangshi', '0', '0');
INSERT INTO `district` VALUES ('2733', '市中区', '2732', ',2589,2732,2733,', '3', '0', 'shizhongqu', '0', '0');
INSERT INTO `district` VALUES ('2734', '东兴区', '2732', ',2589,2732,2734,', '3', '0', 'dongxingqu', '0', '0');
INSERT INTO `district` VALUES ('2735', '威远县', '2732', ',2589,2732,2735,', '3', '0', 'weiyuanxian', '0', '0');
INSERT INTO `district` VALUES ('2736', '资中县', '2732', ',2589,2732,2736,', '3', '0', 'zizhongxian', '0', '0');
INSERT INTO `district` VALUES ('2737', '隆昌县', '2732', ',2589,2732,2737,', '3', '0', 'longchangxian', '0', '0');
INSERT INTO `district` VALUES ('2738', '南充市', '2589', ',2589,2738,', '2', '0', 'nanchongshi', '0', '0');
INSERT INTO `district` VALUES ('2739', '顺庆区', '2738', ',2589,2738,2739,', '3', '0', 'shunqingqu', '0', '0');
INSERT INTO `district` VALUES ('2740', '高坪区', '2738', ',2589,2738,2740,', '3', '0', 'gaopingqu', '0', '0');
INSERT INTO `district` VALUES ('2741', '嘉陵区', '2738', ',2589,2738,2741,', '3', '0', 'jialingqu', '0', '0');
INSERT INTO `district` VALUES ('2742', '南部县', '2738', ',2589,2738,2742,', '3', '0', 'nanbuxian', '0', '0');
INSERT INTO `district` VALUES ('2743', '营山县', '2738', ',2589,2738,2743,', '3', '0', 'yingshanxian', '0', '0');
INSERT INTO `district` VALUES ('2744', '蓬安县', '2738', ',2589,2738,2744,', '3', '0', 'penganxian', '0', '0');
INSERT INTO `district` VALUES ('2745', '仪陇县', '2738', ',2589,2738,2745,', '3', '0', 'yilongxian', '0', '0');
INSERT INTO `district` VALUES ('2746', '西充县', '2738', ',2589,2738,2746,', '3', '0', 'xichongxian', '0', '0');
INSERT INTO `district` VALUES ('2747', '阆中市', '2738', ',2589,2738,2747,', '3', '0', 'zhongshi', '0', '0');
INSERT INTO `district` VALUES ('2748', '攀枝花市', '2589', ',2589,2748,', '2', '0', 'panzhihuashi', '0', '0');
INSERT INTO `district` VALUES ('2749', '东区', '2748', ',2589,2748,2749,', '3', '0', 'dongqu', '0', '0');
INSERT INTO `district` VALUES ('2750', '西区', '2748', ',2589,2748,2750,', '3', '0', 'xiqu', '0', '0');
INSERT INTO `district` VALUES ('2751', '仁和区', '2748', ',2589,2748,2751,', '3', '0', 'renhequ', '0', '0');
INSERT INTO `district` VALUES ('2752', '米易县', '2748', ',2589,2748,2752,', '3', '0', 'miyixian', '0', '0');
INSERT INTO `district` VALUES ('2753', '盐边县', '2748', ',2589,2748,2753,', '3', '0', 'yanbianxian', '0', '0');
INSERT INTO `district` VALUES ('2754', '遂宁市', '2589', ',2589,2754,', '2', '0', 'suiningshi', '0', '0');
INSERT INTO `district` VALUES ('2755', '船山区', '2754', ',2589,2754,2755,', '3', '0', 'chuanshanqu', '0', '0');
INSERT INTO `district` VALUES ('2756', '安居区', '2754', ',2589,2754,2756,', '3', '0', 'anjuqu', '0', '0');
INSERT INTO `district` VALUES ('2757', '蓬溪县', '2754', ',2589,2754,2757,', '3', '0', 'pengxixian', '0', '0');
INSERT INTO `district` VALUES ('2758', '射洪县', '2754', ',2589,2754,2758,', '3', '0', 'shehongxian', '0', '0');
INSERT INTO `district` VALUES ('2759', '大英县', '2754', ',2589,2754,2759,', '3', '0', 'dayingxian', '0', '0');
INSERT INTO `district` VALUES ('2760', '雅安市', '2589', ',2589,2760,', '2', '0', 'yaanshi', '0', '0');
INSERT INTO `district` VALUES ('2761', '雨城区', '2760', ',2589,2760,2761,', '3', '0', 'yuchengqu', '0', '0');
INSERT INTO `district` VALUES ('2762', '名山县', '2760', ',2589,2760,2762,', '3', '0', 'mingshanxian', '0', '0');
INSERT INTO `district` VALUES ('2763', '荥经县', '2760', ',2589,2760,2763,', '3', '0', 'jingxian', '0', '0');
INSERT INTO `district` VALUES ('2764', '汉源县', '2760', ',2589,2760,2764,', '3', '0', 'hanyuanxian', '0', '0');
INSERT INTO `district` VALUES ('2765', '石棉县', '2760', ',2589,2760,2765,', '3', '0', 'shimianxian', '0', '0');
INSERT INTO `district` VALUES ('2766', '天全县', '2760', ',2589,2760,2766,', '3', '0', 'tianquanxian', '0', '0');
INSERT INTO `district` VALUES ('2767', '芦山县', '2760', ',2589,2760,2767,', '3', '0', 'lushanxian', '0', '0');
INSERT INTO `district` VALUES ('2768', '宝兴县', '2760', ',2589,2760,2768,', '3', '0', 'baoxingxian', '0', '0');
INSERT INTO `district` VALUES ('2769', '宜宾市', '2589', ',2589,2769,', '2', '0', 'yibinshi', '0', '0');
INSERT INTO `district` VALUES ('2770', '翠屏区', '2769', ',2589,2769,2770,', '3', '0', 'cuipingqu', '0', '0');
INSERT INTO `district` VALUES ('2771', '宜宾县', '2769', ',2589,2769,2771,', '3', '0', 'yibinxian', '0', '0');
INSERT INTO `district` VALUES ('2772', '南溪县', '2769', ',2589,2769,2772,', '3', '0', 'nanxixian', '0', '0');
INSERT INTO `district` VALUES ('2773', '江安县', '2769', ',2589,2769,2773,', '3', '0', 'jianganxian', '0', '0');
INSERT INTO `district` VALUES ('2774', '长宁县', '2769', ',2589,2769,2774,', '3', '0', 'changningxian', '0', '0');
INSERT INTO `district` VALUES ('2775', '高县', '2769', ',2589,2769,2775,', '3', '0', 'gaoxian', '0', '0');
INSERT INTO `district` VALUES ('2776', '珙县', '2769', ',2589,2769,2776,', '3', '0', 'xian', '0', '0');
INSERT INTO `district` VALUES ('2777', '筠连县', '2769', ',2589,2769,2777,', '3', '0', 'lianxian', '0', '0');
INSERT INTO `district` VALUES ('2778', '兴文县', '2769', ',2589,2769,2778,', '3', '0', 'xingwenxian', '0', '0');
INSERT INTO `district` VALUES ('2779', '屏山县', '2769', ',2589,2769,2779,', '3', '0', 'pingshanxian', '0', '0');
INSERT INTO `district` VALUES ('2780', '资阳市', '2589', ',2589,2780,', '2', '0', 'ziyangshi', '0', '0');
INSERT INTO `district` VALUES ('2781', '雁江区', '2780', ',2589,2780,2781,', '3', '0', 'yanjiangqu', '0', '0');
INSERT INTO `district` VALUES ('2782', '安岳县', '2780', ',2589,2780,2782,', '3', '0', 'anyuexian', '0', '0');
INSERT INTO `district` VALUES ('2783', '乐至县', '2780', ',2589,2780,2783,', '3', '0', 'lezhixian', '0', '0');
INSERT INTO `district` VALUES ('2784', '简阳市', '2780', ',2589,2780,2784,', '3', '0', 'jianyangshi', '0', '0');
INSERT INTO `district` VALUES ('2785', '自贡市', '2589', ',2589,2785,', '2', '0', 'zigongshi', '0', '0');
INSERT INTO `district` VALUES ('2786', '自流井区', '2785', ',2589,2785,2786,', '3', '0', 'ziliujingqu', '0', '0');
INSERT INTO `district` VALUES ('2787', '贡井区', '2785', ',2589,2785,2787,', '3', '0', 'gongjingqu', '0', '0');
INSERT INTO `district` VALUES ('2788', '大安区', '2785', ',2589,2785,2788,', '3', '0', 'daanqu', '0', '0');
INSERT INTO `district` VALUES ('2789', '沿滩区', '2785', ',2589,2785,2789,', '3', '0', 'yantanqu', '0', '0');
INSERT INTO `district` VALUES ('2790', '荣县', '2785', ',2589,2785,2790,', '3', '0', 'rongxian', '0', '0');
INSERT INTO `district` VALUES ('2791', '富顺县', '2785', ',2589,2785,2791,', '3', '0', 'fushunxian', '0', '0');
INSERT INTO `district` VALUES ('2987', '云南省', '0', ',2987,', '1', '0', 'yunnansheng', '0', '0');
INSERT INTO `district` VALUES ('2988', '昆明市', '2987', ',2987,2988,', '2', '0', 'kunmingshi', '0', '0');
INSERT INTO `district` VALUES ('2989', '五华区', '2988', ',2987,2988,2989,', '3', '0', 'wuhuaqu', '0', '0');
INSERT INTO `district` VALUES ('2990', '盘龙区', '2988', ',2987,2988,2990,', '3', '0', 'panlongqu', '0', '0');
INSERT INTO `district` VALUES ('2991', '官渡区', '2988', ',2987,2988,2991,', '3', '0', 'guanduqu', '0', '0');
INSERT INTO `district` VALUES ('2992', '西山区', '2988', ',2987,2988,2992,', '3', '0', 'xishanqu', '0', '0');
INSERT INTO `district` VALUES ('2993', '东川区', '2988', ',2987,2988,2993,', '3', '0', 'dongchuanqu', '0', '0');
INSERT INTO `district` VALUES ('2994', '呈贡县', '2988', ',2987,2988,2994,', '3', '0', 'chenggongxian', '0', '0');
INSERT INTO `district` VALUES ('2995', '晋宁县', '2988', ',2987,2988,2995,', '3', '0', 'jinningxian', '0', '0');
INSERT INTO `district` VALUES ('2996', '富民县', '2988', ',2987,2988,2996,', '3', '0', 'fuminxian', '0', '0');
INSERT INTO `district` VALUES ('2997', '宜良县', '2988', ',2987,2988,2997,', '3', '0', 'yiliangxian', '0', '0');
INSERT INTO `district` VALUES ('2998', '石林彝族自治县', '2988', ',2987,2988,2998,', '3', '0', 'shilinyizuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('2999', '嵩明县', '2988', ',2987,2988,2999,', '3', '0', 'mingxian', '0', '0');
INSERT INTO `district` VALUES ('3000', '禄劝彝族苗族自治县', '2988', ',2987,2988,3000,', '3', '0', 'luquanyizumiaozuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('3001', '寻甸回族彝族自治县', '2988', ',2987,2988,3001,', '3', '0', 'xundianhuizuyizuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('3002', '安宁市', '2988', ',2987,2988,3002,', '3', '0', 'anningshi', '0', '0');
INSERT INTO `district` VALUES ('3003', '保山市', '2987', ',2987,3003,', '2', '0', 'baoshanshi', '0', '0');
INSERT INTO `district` VALUES ('3004', '隆阳区', '3003', ',2987,3003,3004,', '3', '0', 'longyangqu', '0', '0');
INSERT INTO `district` VALUES ('3005', '施甸县', '3003', ',2987,3003,3005,', '3', '0', 'shidianxian', '0', '0');
INSERT INTO `district` VALUES ('3006', '腾冲县', '3003', ',2987,3003,3006,', '3', '0', 'tengchongxian', '0', '0');
INSERT INTO `district` VALUES ('3007', '龙陵县', '3003', ',2987,3003,3007,', '3', '0', 'longlingxian', '0', '0');
INSERT INTO `district` VALUES ('3008', '昌宁县', '3003', ',2987,3003,3008,', '3', '0', 'changningxian', '0', '0');
INSERT INTO `district` VALUES ('3009', '楚雄彝族自治州', '2987', ',2987,3009,', '2', '0', 'chuxiongyizuzizhizhou', '0', '0');
INSERT INTO `district` VALUES ('3010', '楚雄市', '3009', ',2987,3009,3010,', '3', '0', 'chuxiongshi', '0', '0');
INSERT INTO `district` VALUES ('3011', '双柏县', '3009', ',2987,3009,3011,', '3', '0', 'shuangbaixian', '0', '0');
INSERT INTO `district` VALUES ('3012', '牟定县', '3009', ',2987,3009,3012,', '3', '0', 'moudingxian', '0', '0');
INSERT INTO `district` VALUES ('3013', '南华县', '3009', ',2987,3009,3013,', '3', '0', 'nanhuaxian', '0', '0');
INSERT INTO `district` VALUES ('3014', '姚安县', '3009', ',2987,3009,3014,', '3', '0', 'yaoanxian', '0', '0');
INSERT INTO `district` VALUES ('3015', '大姚县', '3009', ',2987,3009,3015,', '3', '0', 'dayaoxian', '0', '0');
INSERT INTO `district` VALUES ('3016', '永仁县', '3009', ',2987,3009,3016,', '3', '0', 'yongrenxian', '0', '0');
INSERT INTO `district` VALUES ('3017', '元谋县', '3009', ',2987,3009,3017,', '3', '0', 'yuanmouxian', '0', '0');
INSERT INTO `district` VALUES ('3018', '武定县', '3009', ',2987,3009,3018,', '3', '0', 'wudingxian', '0', '0');
INSERT INTO `district` VALUES ('3019', '禄丰县', '3009', ',2987,3009,3019,', '3', '0', 'lufengxian', '0', '0');
INSERT INTO `district` VALUES ('3020', '大理白族自治州', '2987', ',2987,3020,', '2', '0', 'dalibaizuzizhizhou', '0', '0');
INSERT INTO `district` VALUES ('3021', '大理市', '3020', ',2987,3020,3021,', '3', '0', 'dalishi', '0', '0');
INSERT INTO `district` VALUES ('3022', '漾濞彝族自治县', '3020', ',2987,3020,3022,', '3', '0', 'yangyizuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('3023', '祥云县', '3020', ',2987,3020,3023,', '3', '0', 'xiangyunxian', '0', '0');
INSERT INTO `district` VALUES ('3024', '宾川县', '3020', ',2987,3020,3024,', '3', '0', 'binchuanxian', '0', '0');
INSERT INTO `district` VALUES ('3025', '弥渡县', '3020', ',2987,3020,3025,', '3', '0', 'miduxian', '0', '0');
INSERT INTO `district` VALUES ('3026', '南涧彝族自治县', '3020', ',2987,3020,3026,', '3', '0', 'nanjianyizuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('3027', '巍山彝族回族自治县', '3020', ',2987,3020,3027,', '3', '0', 'weishanyizuhuizuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('3028', '永平县', '3020', ',2987,3020,3028,', '3', '0', 'yongpingxian', '0', '0');
INSERT INTO `district` VALUES ('3029', '云龙县', '3020', ',2987,3020,3029,', '3', '0', 'yunlongxian', '0', '0');
INSERT INTO `district` VALUES ('3030', '洱源县', '3020', ',2987,3020,3030,', '3', '0', 'eryuanxian', '0', '0');
INSERT INTO `district` VALUES ('3031', '剑川县', '3020', ',2987,3020,3031,', '3', '0', 'jianchuanxian', '0', '0');
INSERT INTO `district` VALUES ('3032', '鹤庆县', '3020', ',2987,3020,3032,', '3', '0', 'heqingxian', '0', '0');
INSERT INTO `district` VALUES ('3033', '德宏傣族景颇族自治州', '2987', ',2987,3033,', '2', '0', 'dehongdaizujingpozuzizhizhou', '0', '0');
INSERT INTO `district` VALUES ('3034', '瑞丽市', '3033', ',2987,3033,3034,', '3', '0', 'ruilishi', '0', '0');
INSERT INTO `district` VALUES ('3035', '潞西市', '3033', ',2987,3033,3035,', '3', '0', 'luxishi', '0', '0');
INSERT INTO `district` VALUES ('3036', '梁河县', '3033', ',2987,3033,3036,', '3', '0', 'lianghexian', '0', '0');
INSERT INTO `district` VALUES ('3037', '盈江县', '3033', ',2987,3033,3037,', '3', '0', 'yingjiangxian', '0', '0');
INSERT INTO `district` VALUES ('3038', '陇川县', '3033', ',2987,3033,3038,', '3', '0', 'longchuanxian', '0', '0');
INSERT INTO `district` VALUES ('3039', '迪庆藏族自治州', '2987', ',2987,3039,', '2', '0', 'diqingcangzuzizhizhou', '0', '0');
INSERT INTO `district` VALUES ('3040', '香格里拉县', '3039', ',2987,3039,3040,', '3', '0', 'xianggelilaxian', '0', '0');
INSERT INTO `district` VALUES ('3041', '德钦县', '3039', ',2987,3039,3041,', '3', '0', 'deqinxian', '0', '0');
INSERT INTO `district` VALUES ('3042', '维西傈僳族自治县', '3039', ',2987,3039,3042,', '3', '0', 'weixilisuzuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('3043', '红河哈尼族彝族自治州', '2987', ',2987,3043,', '2', '0', 'honghehanizuyizuzizhizhou', '0', '0');
INSERT INTO `district` VALUES ('3044', '个旧市', '3043', ',2987,3043,3044,', '3', '0', 'gejiushi', '0', '0');
INSERT INTO `district` VALUES ('3045', '开远市', '3043', ',2987,3043,3045,', '3', '0', 'kaiyuanshi', '0', '0');
INSERT INTO `district` VALUES ('3046', '蒙自县', '3043', ',2987,3043,3046,', '3', '0', 'mengzixian', '0', '0');
INSERT INTO `district` VALUES ('3047', '屏边苗族自治县', '3043', ',2987,3043,3047,', '3', '0', 'pingbianmiaozuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('3048', '建水县', '3043', ',2987,3043,3048,', '3', '0', 'jianshuixian', '0', '0');
INSERT INTO `district` VALUES ('3049', '石屏县', '3043', ',2987,3043,3049,', '3', '0', 'shipingxian', '0', '0');
INSERT INTO `district` VALUES ('3050', '弥勒县', '3043', ',2987,3043,3050,', '3', '0', 'milexian', '0', '0');
INSERT INTO `district` VALUES ('3051', '泸西县', '3043', ',2987,3043,3051,', '3', '0', 'xixian', '0', '0');
INSERT INTO `district` VALUES ('3052', '元阳县', '3043', ',2987,3043,3052,', '3', '0', 'yuanyangxian', '0', '0');
INSERT INTO `district` VALUES ('3053', '红河县', '3043', ',2987,3043,3053,', '3', '0', 'honghexian', '0', '0');
INSERT INTO `district` VALUES ('3054', '金平苗族瑶族傣族自治县', '3043', ',2987,3043,3054,', '3', '0', 'jinpingmiaozuyaozudaizuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('3055', '绿春县', '3043', ',2987,3043,3055,', '3', '0', 'lvchunxian', '0', '0');
INSERT INTO `district` VALUES ('3056', '河口瑶族自治县', '3043', ',2987,3043,3056,', '3', '0', 'hekouyaozuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('3057', '丽江市', '2987', ',2987,3057,', '2', '0', 'lijiangshi', '0', '0');
INSERT INTO `district` VALUES ('3058', '古城区', '3057', ',2987,3057,3058,', '3', '0', 'guchengqu', '0', '0');
INSERT INTO `district` VALUES ('3059', '玉龙纳西族自治县', '3057', ',2987,3057,3059,', '3', '0', 'yulongnaxizuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('3060', '永胜县', '3057', ',2987,3057,3060,', '3', '0', 'yongshengxian', '0', '0');
INSERT INTO `district` VALUES ('3061', '华坪县', '3057', ',2987,3057,3061,', '3', '0', 'huapingxian', '0', '0');
INSERT INTO `district` VALUES ('3062', '宁蒗彝族自治县', '3057', ',2987,3057,3062,', '3', '0', 'ningyizuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('3063', '临沧市', '2987', ',2987,3063,', '2', '0', 'lincangshi', '0', '0');
INSERT INTO `district` VALUES ('3064', '临翔区', '3063', ',2987,3063,3064,', '3', '0', 'linxiangqu', '0', '0');
INSERT INTO `district` VALUES ('3065', '凤庆县', '3063', ',2987,3063,3065,', '3', '0', 'fengqingxian', '0', '0');
INSERT INTO `district` VALUES ('3066', '云县', '3063', ',2987,3063,3066,', '3', '0', 'yunxian', '0', '0');
INSERT INTO `district` VALUES ('3067', '永德县', '3063', ',2987,3063,3067,', '3', '0', 'yongdexian', '0', '0');
INSERT INTO `district` VALUES ('3068', '镇康县', '3063', ',2987,3063,3068,', '3', '0', 'zhenkangxian', '0', '0');
INSERT INTO `district` VALUES ('3069', '双江拉祜族佤族布朗族傣族自治县', '3063', ',2987,3063,3069,', '3', '0', 'shuangjianglazuzubulangzudaizuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('3070', '耿马傣族佤族自治县', '3063', ',2987,3063,3070,', '3', '0', 'gengmadaizuzuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('3071', '沧源佤族自治县', '3063', ',2987,3063,3071,', '3', '0', 'cangyuanzuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('3072', '怒江傈僳族自治州', '2987', ',2987,3072,', '2', '0', 'nujianglisuzuzizhizhou', '0', '0');
INSERT INTO `district` VALUES ('3073', '泸水县', '3072', ',2987,3072,3073,', '3', '0', 'shuixian', '0', '0');
INSERT INTO `district` VALUES ('3074', '福贡县', '3072', ',2987,3072,3074,', '3', '0', 'fugongxian', '0', '0');
INSERT INTO `district` VALUES ('3075', '贡山独龙族怒族自治县', '3072', ',2987,3072,3075,', '3', '0', 'gongshandulongzunuzuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('3076', '兰坪白族普米族自治县', '3072', ',2987,3072,3076,', '3', '0', 'lanpingbaizupumizuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('3077', '曲靖市', '2987', ',2987,3077,', '2', '0', 'qujingshi', '0', '0');
INSERT INTO `district` VALUES ('3078', '麒麟区', '3077', ',2987,3077,3078,', '3', '0', 'qu', '0', '0');
INSERT INTO `district` VALUES ('3079', '马龙县', '3077', ',2987,3077,3079,', '3', '0', 'malongxian', '0', '0');
INSERT INTO `district` VALUES ('3080', '陆良县', '3077', ',2987,3077,3080,', '3', '0', 'luliangxian', '0', '0');
INSERT INTO `district` VALUES ('3081', '师宗县', '3077', ',2987,3077,3081,', '3', '0', 'shizongxian', '0', '0');
INSERT INTO `district` VALUES ('3082', '罗平县', '3077', ',2987,3077,3082,', '3', '0', 'luopingxian', '0', '0');
INSERT INTO `district` VALUES ('3083', '富源县', '3077', ',2987,3077,3083,', '3', '0', 'fuyuanxian', '0', '0');
INSERT INTO `district` VALUES ('3084', '会泽县', '3077', ',2987,3077,3084,', '3', '0', 'huizexian', '0', '0');
INSERT INTO `district` VALUES ('3085', '沾益县', '3077', ',2987,3077,3085,', '3', '0', 'zhanyixian', '0', '0');
INSERT INTO `district` VALUES ('3086', '宣威市', '3077', ',2987,3077,3086,', '3', '0', 'xuanweishi', '0', '0');
INSERT INTO `district` VALUES ('3087', '思茅市', '2987', ',2987,3087,', '2', '0', 'simaoshi', '0', '0');
INSERT INTO `district` VALUES ('3088', '翠云区', '3087', ',2987,3087,3088,', '3', '0', 'cuiyunqu', '0', '0');
INSERT INTO `district` VALUES ('3089', '普洱哈尼族彝族自治县', '3087', ',2987,3087,3089,', '3', '0', 'puerhanizuyizuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('3090', '墨江哈尼族自治县', '3087', ',2987,3087,3090,', '3', '0', 'mojianghanizuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('3091', '景东彝族自治县', '3087', ',2987,3087,3091,', '3', '0', 'jingdongyizuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('3092', '景谷傣族彝族自治县', '3087', ',2987,3087,3092,', '3', '0', 'jinggudaizuyizuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('3093', '镇沅彝族哈尼族拉祜族自治县', '3087', ',2987,3087,3093,', '3', '0', 'zhenyizuhanizulazuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('3094', '江城哈尼族彝族自治县', '3087', ',2987,3087,3094,', '3', '0', 'jiangchenghanizuyizuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('3095', '孟连傣族拉祜族佤族自治县', '3087', ',2987,3087,3095,', '3', '0', 'mengliandaizulazuzuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('3096', '澜沧拉祜族自治县', '3087', ',2987,3087,3096,', '3', '0', 'lancanglazuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('3097', '西盟佤族自治县', '3087', ',2987,3087,3097,', '3', '0', 'ximengzuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('3098', '文山壮族苗族自治州', '2987', ',2987,3098,', '2', '0', 'wenshanzhuangzumiaozuzizhizhou', '0', '0');
INSERT INTO `district` VALUES ('3099', '文山县', '3098', ',2987,3098,3099,', '3', '0', 'wenshanxian', '0', '0');
INSERT INTO `district` VALUES ('3100', '砚山县', '3098', ',2987,3098,3100,', '3', '0', 'yanshanxian', '0', '0');
INSERT INTO `district` VALUES ('3101', '西畴县', '3098', ',2987,3098,3101,', '3', '0', 'xichouxian', '0', '0');
INSERT INTO `district` VALUES ('3102', '麻栗坡县', '3098', ',2987,3098,3102,', '3', '0', 'malipoxian', '0', '0');
INSERT INTO `district` VALUES ('3103', '马关县', '3098', ',2987,3098,3103,', '3', '0', 'maguanxian', '0', '0');
INSERT INTO `district` VALUES ('3104', '丘北县', '3098', ',2987,3098,3104,', '3', '0', 'qiubeixian', '0', '0');
INSERT INTO `district` VALUES ('3105', '广南县', '3098', ',2987,3098,3105,', '3', '0', 'guangnanxian', '0', '0');
INSERT INTO `district` VALUES ('3106', '富宁县', '3098', ',2987,3098,3106,', '3', '0', 'funingxian', '0', '0');
INSERT INTO `district` VALUES ('3107', '西双版纳傣族自治州', '2987', ',2987,3107,', '2', '0', 'xishuangbannadaizuzizhizhou', '0', '0');
INSERT INTO `district` VALUES ('3108', '景洪市', '3107', ',2987,3107,3108,', '3', '0', 'jinghongshi', '0', '0');
INSERT INTO `district` VALUES ('3109', '勐海县', '3107', ',2987,3107,3109,', '3', '0', 'haixian', '0', '0');
INSERT INTO `district` VALUES ('3110', '勐腊县', '3107', ',2987,3107,3110,', '3', '0', 'laxian', '0', '0');
INSERT INTO `district` VALUES ('3111', '玉溪市', '2987', ',2987,3111,', '2', '0', 'yuxishi', '0', '0');
INSERT INTO `district` VALUES ('3112', '红塔区', '3111', ',2987,3111,3112,', '3', '0', 'hongtaqu', '0', '0');
INSERT INTO `district` VALUES ('3113', '江川县', '3111', ',2987,3111,3113,', '3', '0', 'jiangchuanxian', '0', '0');
INSERT INTO `district` VALUES ('3114', '澄江县', '3111', ',2987,3111,3114,', '3', '0', 'chengjiangxian', '0', '0');
INSERT INTO `district` VALUES ('3115', '通海县', '3111', ',2987,3111,3115,', '3', '0', 'tonghaixian', '0', '0');
INSERT INTO `district` VALUES ('3116', '华宁县', '3111', ',2987,3111,3116,', '3', '0', 'huaningxian', '0', '0');
INSERT INTO `district` VALUES ('3117', '易门县', '3111', ',2987,3111,3117,', '3', '0', 'yimenxian', '0', '0');
INSERT INTO `district` VALUES ('3118', '峨山彝族自治县', '3111', ',2987,3111,3118,', '3', '0', 'eshanyizuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('3119', '新平彝族傣族自治县', '3111', ',2987,3111,3119,', '3', '0', 'xinpingyizudaizuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('3120', '元江哈尼族彝族傣族自治县', '3111', ',2987,3111,3120,', '3', '0', 'yuanjianghanizuyizudaizuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('3121', '昭通市', '2987', ',2987,3121,', '2', '0', 'zhaotongshi', '0', '0');
INSERT INTO `district` VALUES ('3122', '昭阳区', '3121', ',2987,3121,3122,', '3', '0', 'zhaoyangqu', '0', '0');
INSERT INTO `district` VALUES ('3123', '鲁甸县', '3121', ',2987,3121,3123,', '3', '0', 'ludianxian', '0', '0');
INSERT INTO `district` VALUES ('3124', '巧家县', '3121', ',2987,3121,3124,', '3', '0', 'qiaojiaxian', '0', '0');
INSERT INTO `district` VALUES ('3125', '盐津县', '3121', ',2987,3121,3125,', '3', '0', 'yanjinxian', '0', '0');
INSERT INTO `district` VALUES ('3126', '大关县', '3121', ',2987,3121,3126,', '3', '0', 'daguanxian', '0', '0');
INSERT INTO `district` VALUES ('3127', '永善县', '3121', ',2987,3121,3127,', '3', '0', 'yongshanxian', '0', '0');
INSERT INTO `district` VALUES ('3128', '绥江县', '3121', ',2987,3121,3128,', '3', '0', 'suijiangxian', '0', '0');
INSERT INTO `district` VALUES ('3129', '镇雄县', '3121', ',2987,3121,3129,', '3', '0', 'zhenxiongxian', '0', '0');
INSERT INTO `district` VALUES ('3130', '彝良县', '3121', ',2987,3121,3130,', '3', '0', 'yiliangxian', '0', '0');
INSERT INTO `district` VALUES ('3131', '威信县', '3121', ',2987,3121,3131,', '3', '0', 'weixinxian', '0', '0');
INSERT INTO `district` VALUES ('3132', '水富县', '3121', ',2987,3121,3132,', '3', '0', 'shuifuxian', '0', '0');
INSERT INTO `district` VALUES ('3133', '浙江省', '0', ',3133,', '1', '0', 'zhejiangsheng', '0', '0');
INSERT INTO `district` VALUES ('3134', '杭州市', '3133', ',3133,3134,', '2', '0', 'hangzhoushi', '0', '0');
INSERT INTO `district` VALUES ('3135', '上城区', '3134', ',3133,3134,3135,', '3', '0', 'shangchengqu', '0', '0');
INSERT INTO `district` VALUES ('3136', '下城区', '3134', ',3133,3134,3136,', '3', '0', 'xiachengqu', '0', '0');
INSERT INTO `district` VALUES ('3137', '江干区', '3134', ',3133,3134,3137,', '3', '0', 'jiangganqu', '0', '0');
INSERT INTO `district` VALUES ('3138', '拱墅区', '3134', ',3133,3134,3138,', '3', '0', 'gongshuqu', '0', '0');
INSERT INTO `district` VALUES ('3139', '西湖区', '3134', ',3133,3134,3139,', '3', '0', 'xihuqu', '0', '0');
INSERT INTO `district` VALUES ('3140', '滨江区', '3134', ',3133,3134,3140,', '3', '0', 'binjiangqu', '0', '0');
INSERT INTO `district` VALUES ('3141', '萧山区', '3134', ',3133,3134,3141,', '3', '0', 'xiaoshanqu', '0', '0');
INSERT INTO `district` VALUES ('3142', '余杭区', '3134', ',3133,3134,3142,', '3', '0', 'yuhangqu', '0', '0');
INSERT INTO `district` VALUES ('3143', '桐庐县', '3134', ',3133,3134,3143,', '3', '0', 'tongluxian', '0', '0');
INSERT INTO `district` VALUES ('3144', '淳安县', '3134', ',3133,3134,3144,', '3', '0', 'chunanxian', '0', '0');
INSERT INTO `district` VALUES ('3145', '建德市', '3134', ',3133,3134,3145,', '3', '0', 'jiandeshi', '0', '0');
INSERT INTO `district` VALUES ('3146', '富阳市', '3134', ',3133,3134,3146,', '3', '0', 'fuyangshi', '0', '0');
INSERT INTO `district` VALUES ('3147', '临安市', '3134', ',3133,3134,3147,', '3', '0', 'linanshi', '0', '0');
INSERT INTO `district` VALUES ('3148', '湖州市', '3133', ',3133,3148,', '2', '0', 'huzhoushi', '0', '0');
INSERT INTO `district` VALUES ('3149', '吴兴区', '3148', ',3133,3148,3149,', '3', '0', 'wuxingqu', '0', '0');
INSERT INTO `district` VALUES ('3150', '南浔区', '3148', ',3133,3148,3150,', '3', '0', 'nanqu', '0', '0');
INSERT INTO `district` VALUES ('3151', '德清县', '3148', ',3133,3148,3151,', '3', '0', 'deqingxian', '0', '0');
INSERT INTO `district` VALUES ('3152', '长兴县', '3148', ',3133,3148,3152,', '3', '0', 'changxingxian', '0', '0');
INSERT INTO `district` VALUES ('3153', '安吉县', '3148', ',3133,3148,3153,', '3', '0', 'anjixian', '0', '0');
INSERT INTO `district` VALUES ('3154', '嘉兴市', '3133', ',3133,3154,', '2', '0', 'jiaxingshi', '0', '0');
INSERT INTO `district` VALUES ('3155', '秀城区', '3154', ',3133,3154,3155,', '3', '0', 'xiuchengqu', '0', '0');
INSERT INTO `district` VALUES ('3156', '秀洲区', '3154', ',3133,3154,3156,', '3', '0', 'xiuzhouqu', '0', '0');
INSERT INTO `district` VALUES ('3157', '嘉善县', '3154', ',3133,3154,3157,', '3', '0', 'jiashanxian', '0', '0');
INSERT INTO `district` VALUES ('3158', '海盐县', '3154', ',3133,3154,3158,', '3', '0', 'haiyanxian', '0', '0');
INSERT INTO `district` VALUES ('3159', '海宁市', '3154', ',3133,3154,3159,', '3', '0', 'hainingshi', '0', '0');
INSERT INTO `district` VALUES ('3160', '平湖市', '3154', ',3133,3154,3160,', '3', '0', 'pinghushi', '0', '0');
INSERT INTO `district` VALUES ('3161', '桐乡市', '3154', ',3133,3154,3161,', '3', '0', 'tongxiangshi', '0', '0');
INSERT INTO `district` VALUES ('3162', '金华市', '3133', ',3133,3162,', '2', '0', 'jinhuashi', '0', '0');
INSERT INTO `district` VALUES ('3163', '婺城区', '3162', ',3133,3162,3163,', '3', '0', 'chengqu', '0', '0');
INSERT INTO `district` VALUES ('3164', '金东区', '3162', ',3133,3162,3164,', '3', '0', 'jindongqu', '0', '0');
INSERT INTO `district` VALUES ('3165', '武义县', '3162', ',3133,3162,3165,', '3', '0', 'wuyixian', '0', '0');
INSERT INTO `district` VALUES ('3166', '浦江县', '3162', ',3133,3162,3166,', '3', '0', 'pujiangxian', '0', '0');
INSERT INTO `district` VALUES ('3167', '磐安县', '3162', ',3133,3162,3167,', '3', '0', 'pananxian', '0', '0');
INSERT INTO `district` VALUES ('3168', '兰溪市', '3162', ',3133,3162,3168,', '3', '0', 'lanxishi', '0', '0');
INSERT INTO `district` VALUES ('3169', '义乌市', '3162', ',3133,3162,3169,', '3', '0', 'yiwushi', '0', '0');
INSERT INTO `district` VALUES ('3170', '东阳市', '3162', ',3133,3162,3170,', '3', '0', 'dongyangshi', '0', '0');
INSERT INTO `district` VALUES ('3171', '永康市', '3162', ',3133,3162,3171,', '3', '0', 'yongkangshi', '0', '0');
INSERT INTO `district` VALUES ('3172', '丽水市', '3133', ',3133,3172,', '2', '0', 'lishuishi', '0', '0');
INSERT INTO `district` VALUES ('3173', '莲都区', '3172', ',3133,3172,3173,', '3', '0', 'lianduqu', '0', '0');
INSERT INTO `district` VALUES ('3174', '青田县', '3172', ',3133,3172,3174,', '3', '0', 'qingtianxian', '0', '0');
INSERT INTO `district` VALUES ('3175', '缙云县', '3172', ',3133,3172,3175,', '3', '0', 'yunxian', '0', '0');
INSERT INTO `district` VALUES ('3176', '遂昌县', '3172', ',3133,3172,3176,', '3', '0', 'suichangxian', '0', '0');
INSERT INTO `district` VALUES ('3177', '松阳县', '3172', ',3133,3172,3177,', '3', '0', 'songyangxian', '0', '0');
INSERT INTO `district` VALUES ('3178', '云和县', '3172', ',3133,3172,3178,', '3', '0', 'yunhexian', '0', '0');
INSERT INTO `district` VALUES ('3179', '庆元县', '3172', ',3133,3172,3179,', '3', '0', 'qingyuanxian', '0', '0');
INSERT INTO `district` VALUES ('3180', '景宁畲族自治县', '3172', ',3133,3172,3180,', '3', '0', 'jingningzuzizhixian', '0', '0');
INSERT INTO `district` VALUES ('3181', '龙泉市', '3172', ',3133,3172,3181,', '3', '0', 'longquanshi', '0', '0');
INSERT INTO `district` VALUES ('3182', '宁波市', '3133', ',3133,3182,', '2', '0', 'ningboshi', '0', '0');
INSERT INTO `district` VALUES ('3183', '海曙区', '3182', ',3133,3182,3183,', '3', '0', 'haishuqu', '0', '0');
INSERT INTO `district` VALUES ('3184', '江东区', '3182', ',3133,3182,3184,', '3', '0', 'jiangdongqu', '0', '0');
INSERT INTO `district` VALUES ('3185', '江北区', '3182', ',3133,3182,3185,', '3', '0', 'jiangbeiqu', '0', '0');
INSERT INTO `district` VALUES ('3186', '北仑区', '3182', ',3133,3182,3186,', '3', '0', 'beilunqu', '0', '0');
INSERT INTO `district` VALUES ('3187', '镇海区', '3182', ',3133,3182,3187,', '3', '0', 'zhenhaiqu', '0', '0');
INSERT INTO `district` VALUES ('3188', '鄞州区', '3182', ',3133,3182,3188,', '3', '0', 'zhouqu', '0', '0');
INSERT INTO `district` VALUES ('3189', '象山县', '3182', ',3133,3182,3189,', '3', '0', 'xiangshanxian', '0', '0');
INSERT INTO `district` VALUES ('3190', '宁海县', '3182', ',3133,3182,3190,', '3', '0', 'ninghaixian', '0', '0');
INSERT INTO `district` VALUES ('3191', '余姚市', '3182', ',3133,3182,3191,', '3', '0', 'yuyaoshi', '0', '0');
INSERT INTO `district` VALUES ('3192', '慈溪市', '3182', ',3133,3182,3192,', '3', '0', 'cixishi', '0', '0');
INSERT INTO `district` VALUES ('3193', '奉化市', '3182', ',3133,3182,3193,', '3', '0', 'fenghuashi', '0', '0');
INSERT INTO `district` VALUES ('3194', '衢州市', '3133', ',3133,3194,', '2', '0', 'zhoushi', '0', '0');
INSERT INTO `district` VALUES ('3195', '柯城区', '3194', ',3133,3194,3195,', '3', '0', 'kechengqu', '0', '0');
INSERT INTO `district` VALUES ('3196', '衢江区', '3194', ',3133,3194,3196,', '3', '0', 'jiangqu', '0', '0');
INSERT INTO `district` VALUES ('3197', '常山县', '3194', ',3133,3194,3197,', '3', '0', 'changshanxian', '0', '0');
INSERT INTO `district` VALUES ('3198', '开化县', '3194', ',3133,3194,3198,', '3', '0', 'kaihuaxian', '0', '0');
INSERT INTO `district` VALUES ('3199', '龙游县', '3194', ',3133,3194,3199,', '3', '0', 'longyouxian', '0', '0');
INSERT INTO `district` VALUES ('3200', '江山市', '3194', ',3133,3194,3200,', '3', '0', 'jiangshanshi', '0', '0');
INSERT INTO `district` VALUES ('3201', '绍兴市', '3133', ',3133,3201,', '2', '0', 'shaoxingshi', '0', '0');
INSERT INTO `district` VALUES ('3202', '越城区', '3201', ',3133,3201,3202,', '3', '0', 'yuechengqu', '0', '0');
INSERT INTO `district` VALUES ('3203', '绍兴县', '3201', ',3133,3201,3203,', '3', '0', 'shaoxingxian', '0', '0');
INSERT INTO `district` VALUES ('3204', '新昌县', '3201', ',3133,3201,3204,', '3', '0', 'xinchangxian', '0', '0');
INSERT INTO `district` VALUES ('3205', '诸暨市', '3201', ',3133,3201,3205,', '3', '0', 'zhushi', '0', '0');
INSERT INTO `district` VALUES ('3206', '上虞市', '3201', ',3133,3201,3206,', '3', '0', 'shangyushi', '0', '0');
INSERT INTO `district` VALUES ('3207', '嵊州市', '3201', ',3133,3201,3207,', '3', '0', 'zhoushi', '0', '0');
INSERT INTO `district` VALUES ('3208', '台州市', '3133', ',3133,3208,', '2', '0', 'taizhoushi', '0', '0');
INSERT INTO `district` VALUES ('3209', '椒江区', '3208', ',3133,3208,3209,', '3', '0', 'jiaojiangqu', '0', '0');
INSERT INTO `district` VALUES ('3210', '黄岩区', '3208', ',3133,3208,3210,', '3', '0', 'huangyanqu', '0', '0');
INSERT INTO `district` VALUES ('3211', '路桥区', '3208', ',3133,3208,3211,', '3', '0', 'luqiaoqu', '0', '0');
INSERT INTO `district` VALUES ('3212', '玉环县', '3208', ',3133,3208,3212,', '3', '0', 'yuhuanxian', '0', '0');
INSERT INTO `district` VALUES ('3213', '三门县', '3208', ',3133,3208,3213,', '3', '0', 'sanmenxian', '0', '0');
INSERT INTO `district` VALUES ('3214', '天台县', '3208', ',3133,3208,3214,', '3', '0', 'tiantaixian', '0', '0');
INSERT INTO `district` VALUES ('3215', '仙居县', '3208', ',3133,3208,3215,', '3', '0', 'xianjuxian', '0', '0');
INSERT INTO `district` VALUES ('3216', '温岭市', '3208', ',3133,3208,3216,', '3', '0', 'wenlingshi', '0', '0');
INSERT INTO `district` VALUES ('3217', '临海市', '3208', ',3133,3208,3217,', '3', '0', 'linhaishi', '0', '0');
INSERT INTO `district` VALUES ('3218', '温州市', '3133', ',3133,3218,', '2', '0', 'wenzhoushi', '0', '0');
INSERT INTO `district` VALUES ('3219', '鹿城区', '3218', ',3133,3218,3219,', '3', '0', 'luchengqu', '0', '0');
INSERT INTO `district` VALUES ('3220', '龙湾区', '3218', ',3133,3218,3220,', '3', '0', 'longwanqu', '0', '0');
INSERT INTO `district` VALUES ('3221', '瓯海区', '3218', ',3133,3218,3221,', '3', '0', 'haiqu', '0', '0');
INSERT INTO `district` VALUES ('3222', '洞头县', '3218', ',3133,3218,3222,', '3', '0', 'dongtouxian', '0', '0');
INSERT INTO `district` VALUES ('3223', '永嘉县', '3218', ',3133,3218,3223,', '3', '0', 'yongjiaxian', '0', '0');
INSERT INTO `district` VALUES ('3224', '平阳县', '3218', ',3133,3218,3224,', '3', '0', 'pingyangxian', '0', '0');
INSERT INTO `district` VALUES ('3225', '苍南县', '3218', ',3133,3218,3225,', '3', '0', 'cangnanxian', '0', '0');
INSERT INTO `district` VALUES ('3226', '文成县', '3218', ',3133,3218,3226,', '3', '0', 'wenchengxian', '0', '0');
INSERT INTO `district` VALUES ('3227', '泰顺县', '3218', ',3133,3218,3227,', '3', '0', 'taishunxian', '0', '0');
INSERT INTO `district` VALUES ('3228', '瑞安市', '3218', ',3133,3218,3228,', '3', '0', 'ruianshi', '0', '0');
INSERT INTO `district` VALUES ('3229', '乐清市', '3218', ',3133,3218,3229,', '3', '0', 'leqingshi', '0', '0');
INSERT INTO `district` VALUES ('3230', '舟山市', '3133', ',3133,3230,', '2', '0', 'zhoushanshi', '0', '0');
INSERT INTO `district` VALUES ('3231', '定海区', '3230', ',3133,3230,3231,', '3', '0', 'dinghaiqu', '0', '0');
INSERT INTO `district` VALUES ('3232', '普陀区', '3230', ',3133,3230,3232,', '3', '0', 'putuoqu', '0', '0');
INSERT INTO `district` VALUES ('3233', '岱山县', '3230', ',3133,3230,3233,', '3', '0', 'shanxian', '0', '0');
INSERT INTO `district` VALUES ('3234', '嵊泗县', '3230', ',3133,3230,3234,', '3', '0', 'xian', '0', '0');
INSERT INTO `district` VALUES ('3235', '香港', '0', ',3235,', '1', '0', 'xianggang', '0', '0');
INSERT INTO `district` VALUES ('3236', '九龙', '3235', ',3235,3236,', '2', '0', 'jiulong', '0', '0');
INSERT INTO `district` VALUES ('3237', '香港岛', '3235', ',3235,3237,', '2', '0', 'xianggangdao', '0', '0');
INSERT INTO `district` VALUES ('3238', '新界', '3235', ',3235,3238,', '2', '0', 'xinjie', '0', '0');
INSERT INTO `district` VALUES ('3239', '澳门', '0', ',3239,', '1', '0', 'aomen', '0', '0');
INSERT INTO `district` VALUES ('3240', '澳门半岛', '3239', ',3239,3240,', '2', '0', 'aomenbandao', '0', '0');
INSERT INTO `district` VALUES ('3241', '离岛', '3239', ',3239,3241,', '2', '0', 'lidao', '0', '0');
INSERT INTO `district` VALUES ('3242', '台湾', '0', ',3242,', '1', '0', 'taiwan', '0', '0');
INSERT INTO `district` VALUES ('3243', '台北市', '3242', ',3242,3243,', '2', '0', 'taibeishi', '0', '0');
INSERT INTO `district` VALUES ('3244', '高雄市', '3242', ',3242,3244,', '2', '0', 'gaoxiongshi', '0', '0');
INSERT INTO `district` VALUES ('3245', '高雄县', '3242', ',3242,3245,', '2', '0', 'gaoxiongxian', '0', '0');
INSERT INTO `district` VALUES ('3246', '花莲县', '3242', ',3242,3246,', '2', '0', 'hualianxian', '0', '0');
INSERT INTO `district` VALUES ('3247', '基隆市', '3242', ',3242,3247,', '2', '0', 'jilongshi', '0', '0');
INSERT INTO `district` VALUES ('3248', '嘉义市', '3242', ',3242,3248,', '2', '0', 'jiayishi', '0', '0');
INSERT INTO `district` VALUES ('3249', '嘉义县', '3242', ',3242,3249,', '2', '0', 'jiayixian', '0', '0');
INSERT INTO `district` VALUES ('3250', '金门县', '3242', ',3242,3250,', '2', '0', 'jinmenxian', '0', '0');
INSERT INTO `district` VALUES ('3251', '苗栗县', '3242', ',3242,3251,', '2', '0', 'miaolixian', '0', '0');
INSERT INTO `district` VALUES ('3252', '南投县', '3242', ',3242,3252,', '2', '0', 'nantouxian', '0', '0');
INSERT INTO `district` VALUES ('3253', '澎湖县', '3242', ',3242,3253,', '2', '0', 'penghuxian', '0', '0');
INSERT INTO `district` VALUES ('3254', '屏东县', '3242', ',3242,3254,', '2', '0', 'pingdongxian', '0', '0');
INSERT INTO `district` VALUES ('3255', '台北县', '3242', ',3242,3255,', '2', '0', 'taibeixian', '0', '0');
INSERT INTO `district` VALUES ('3256', '台东县', '3242', ',3242,3256,', '2', '0', 'taidongxian', '0', '0');
INSERT INTO `district` VALUES ('3257', '台南市', '3242', ',3242,3257,', '2', '0', 'tainanshi', '0', '0');
INSERT INTO `district` VALUES ('3258', '台南县', '3242', ',3242,3258,', '2', '0', 'tainanxian', '0', '0');
INSERT INTO `district` VALUES ('3259', '台中市', '3242', ',3242,3259,', '2', '0', 'taizhongshi', '0', '0');
INSERT INTO `district` VALUES ('3260', '台中县', '3242', ',3242,3260,', '2', '0', 'taizhongxian', '0', '0');
INSERT INTO `district` VALUES ('3261', '桃园县', '3242', ',3242,3261,', '2', '0', 'taoyuanxian', '0', '0');
INSERT INTO `district` VALUES ('3262', '新竹市', '3242', ',3242,3262,', '2', '0', 'xinzhushi', '0', '0');
INSERT INTO `district` VALUES ('3263', '新竹县', '3263', ',,3263,', '2', '0', 'xinzhuxian', '0', '0');
INSERT INTO `district` VALUES ('3264', '宜兰县', '3242', ',3242,3264,', '2', '0', 'yilanxian', '0', '0');
INSERT INTO `district` VALUES ('3265', '云林县', '3242', ',3242,3265,', '2', '0', 'yunlinxian', '0', '0');
INSERT INTO `district` VALUES ('3266', '彰化县', '3242', ',3242,3266,', '2', '0', 'zhanghuaxian', '0', '0');
INSERT INTO `district` VALUES ('3267', '高新区', '2590', ',2589,2590,3267,', '3', '0', 'gaoxinqu', '0', '0');
INSERT INTO `district` VALUES ('3268', '天府新区', '2590', ',2589,2590,3268,', '3', '0', 'tianfuxinqu', '0', '0');
INSERT INTO `district` VALUES ('3269', '龙华新区', '524', ',423,524,3269,', '3', '0', 'longhuaxinqu', '0', '0');
INSERT INTO `district` VALUES ('3299', '小上海', '22', ',21,22,3299,', '3', '0', 'xiaojingcheng', '0', '1');

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
-- Records of district_cate
-- ----------------------------
INSERT INTO `district_cate` VALUES ('1', '北京', '0', ',1,', '1', '0', 'beijing', '1', '1');
INSERT INTO `district_cate` VALUES ('21', '上海', '0', ',21,', '1', '0', 'shanghai', '1', '1');
INSERT INTO `district_cate` VALUES ('42', '天津', '0', ',42,', '1', '0', 'tianjin', '0', '2');
INSERT INTO `district_cate` VALUES ('62', '重庆', '0', ',62,', '1', '0', 'zhongqing', '0', '2');
INSERT INTO `district_cate` VALUES ('104', '安徽省', '0', ',104,', '1', '0', 'anhuisheng', '0', '2');
INSERT INTO `district_cate` VALUES ('227', '福建省', '0', ',227,', '1', '0', 'fujiansheng', '0', '2');
INSERT INTO `district_cate` VALUES ('322', '甘肃省', '0', ',322,', '1', '0', 'gansusheng', '0', '3');
INSERT INTO `district_cate` VALUES ('423', '广东省', '0', ',423,', '1', '0', 'guangdongsheng', '1', '1');
INSERT INTO `district_cate` VALUES ('524', '深圳市', '423', ',423,524,', '2', '0', 'shenshi', '1', '1');
INSERT INTO `district_cate` VALUES ('690', '贵州省', '0', ',690,', '1', '0', 'guizhousheng', '0', '3');
INSERT INTO `district_cate` VALUES ('788', '海南省', '0', ',788,', '1', '0', 'hainansheng', '0', '3');
INSERT INTO `district_cate` VALUES ('814', '河北省', '0', ',814,', '1', '0', 'hebeisheng', '0', '2');
INSERT INTO `district_cate` VALUES ('998', '河南省', '0', ',998,', '1', '0', 'henansheng', '0', '2');
INSERT INTO `district_cate` VALUES ('1176', '黑龙江省', '0', ',1176,', '1', '0', 'heilongjiangsheng', '0', '2');
INSERT INTO `district_cate` VALUES ('1320', '湖北省', '0', ',1320,', '1', '0', 'hubeisheng', '0', '2');
INSERT INTO `district_cate` VALUES ('1436', '湖南省', '0', ',1436,', '1', '0', 'hunansheng', '0', '2');
INSERT INTO `district_cate` VALUES ('1573', '吉林省', '0', ',1573,', '1', '0', 'jilinsheng', '0', '2');
INSERT INTO `district_cate` VALUES ('1643', '江苏省', '0', ',1643,', '1', '0', 'jiangsusheng', '0', '2');
INSERT INTO `district_cate` VALUES ('1763', '江西省', '0', ',1763,', '1', '0', 'jiangxisheng', '0', '2');
INSERT INTO `district_cate` VALUES ('1874', '辽宁省', '0', ',1874,', '1', '0', 'liaoningsheng', '0', '2');
INSERT INTO `district_cate` VALUES ('1989', '内蒙古省', '0', ',1989,', '1', '0', 'neimenggusheng', '0', '3');
INSERT INTO `district_cate` VALUES ('2103', '宁夏省', '0', ',2103,', '1', '0', 'ningxiasheng', '0', '3');
INSERT INTO `district_cate` VALUES ('2130', '青海', '0', ',2130,', '1', '0', 'qinghai', '0', '3');
INSERT INTO `district_cate` VALUES ('2182', '山东省', '0', ',2182,', '1', '0', 'shandongsheng', '0', '2');
INSERT INTO `district_cate` VALUES ('2340', '山西省', '0', ',2340,', '1', '0', 'shanxisheng', '0', '2');
INSERT INTO `district_cate` VALUES ('2471', '陕西省', '0', ',2471,', '1', '0', 'shanxisheng', '0', '3');
INSERT INTO `district_cate` VALUES ('2589', '四川省', '0', ',2589,', '1', '0', 'sichuansheng', '0', '2');
INSERT INTO `district_cate` VALUES ('2987', '云南省', '0', ',2987,', '1', '0', 'yunnansheng', '0', '3');
INSERT INTO `district_cate` VALUES ('3133', '浙江省', '0', ',3133,', '1', '0', 'zhejiangsheng', '0', '2');
INSERT INTO `district_cate` VALUES ('3235', '香港', '0', ',3235,', '1', '0', 'xianggang', '0', '0');
INSERT INTO `district_cate` VALUES ('3239', '澳门', '0', ',3239,', '1', '0', 'aomen', '0', '0');
INSERT INTO `district_cate` VALUES ('3242', '台湾', '0', ',3242,', '1', '0', 'taiwan', '0', '0');

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
-- Records of favorite
-- ----------------------------

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
-- Records of initial_contract_ratio
-- ----------------------------
INSERT INTO `initial_contract_ratio` VALUES ('1', '4', '3', '0.70', '1493600000');
INSERT INTO `initial_contract_ratio` VALUES ('2', '4', '5', '0.80', '1493600000');
INSERT INTO `initial_contract_ratio` VALUES ('3', '5', '3', '0.75', '1493600000');
INSERT INTO `initial_contract_ratio` VALUES ('4', '5', '5', '0.80', '1493600000');
INSERT INTO `initial_contract_ratio` VALUES ('5', '6', '3', '0.68', '1493600000');
INSERT INTO `initial_contract_ratio` VALUES ('6', '6', '5', '0.72', '1493600000');

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
-- Records of insu_branch_performance
-- ----------------------------
INSERT INTO `insu_branch_performance` VALUES ('44', '35', '3611.00', '7611.00', '7611.00', '7611.00', '1', '1', '1', '1', '1', '1495418581');
INSERT INTO `insu_branch_performance` VALUES ('45', 'a25', '400.00', '400.00', '400.00', '400.00', '2', '2', '2', '2', '1', '1495418581');

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
-- Records of insu_flag_performance
-- ----------------------------
INSERT INTO `insu_flag_performance` VALUES ('92', '2223', '500.00', '500.00', '500.00', '500.00', '3', '6', '6', '6', '1', '1495441025');
INSERT INTO `insu_flag_performance` VALUES ('93', '1213', '1100.00', '1100.00', '1100.00', '1100.00', '2', '2', '2', '2', '1', '1495441025');
INSERT INTO `insu_flag_performance` VALUES ('94', '2600', '500.00', '500.00', '500.00', '500.00', '4', '7', '7', '7', '1', '1495441025');
INSERT INTO `insu_flag_performance` VALUES ('95', '2500', '400.00', '400.00', '400.00', '400.00', '5', '11', '11', '11', '1', '1495441025');
INSERT INTO `insu_flag_performance` VALUES ('96', '11111', '11.00', '11.00', '11.00', '11.00', '6', '14', '14', '14', '1', '1495441025');
INSERT INTO `insu_flag_performance` VALUES ('97', '4612313', '0.00', '700.00', '700.00', '700.00', '0', '3', '3', '3', '1', '1495441025');
INSERT INTO `insu_flag_performance` VALUES ('98', '431', '0.00', '600.00', '600.00', '600.00', '0', '4', '4', '4', '1', '1495441025');
INSERT INTO `insu_flag_performance` VALUES ('99', '46321', '0.00', '600.00', '600.00', '600.00', '0', '5', '5', '5', '1', '1495441025');
INSERT INTO `insu_flag_performance` VALUES ('100', '15305', '0.00', '500.00', '500.00', '500.00', '0', '8', '8', '8', '1', '1495441025');
INSERT INTO `insu_flag_performance` VALUES ('101', '454215', '0.00', '500.00', '500.00', '500.00', '0', '9', '9', '9', '1', '1495441025');
INSERT INTO `insu_flag_performance` VALUES ('102', '2', '0.00', '400.00', '400.00', '400.00', '0', '10', '10', '10', '1', '1495441025');
INSERT INTO `insu_flag_performance` VALUES ('103', '21321', '0.00', '400.00', '400.00', '400.00', '0', '12', '12', '12', '1', '1495441025');
INSERT INTO `insu_flag_performance` VALUES ('104', '13213', '0.00', '300.00', '300.00', '300.00', '0', '13', '13', '13', '1', '1495441025');
INSERT INTO `insu_flag_performance` VALUES ('136', '2345', '1500.00', '1500.00', '1500.00', '1500.00', '1', '1', '1', '1', '1', '1495441025');

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
) ENGINE=InnoDB AUTO_INCREMENT=3632 DEFAULT CHARSET=utf8 COMMENT='lzj-会员业绩排名表';

-- ----------------------------
-- Records of insu_mem_performance
-- ----------------------------
INSERT INTO `insu_mem_performance` VALUES ('3615', '7519170512', '0', '0.00', '3', '1030.12', '3', '1030.12', '3', '1030.12', '0', '1', '1', '1', '1', '1496310653');
INSERT INTO `insu_mem_performance` VALUES ('3616', '111', '0', '0.00', '3', '823.04', '3', '823.04', '3', '823.04', '0', '2', '2', '2', '1', '1496310653');
INSERT INTO `insu_mem_performance` VALUES ('3617', '121321', '0', '0.00', '1', '663.72', '1', '663.72', '1', '663.72', '0', '3', '3', '3', '1', '1496310653');
INSERT INTO `insu_mem_performance` VALUES ('3618', '354321', '0', '0.00', '1', '600.78', '1', '600.78', '1', '600.78', '0', '4', '4', '4', '1', '1496310653');
INSERT INTO `insu_mem_performance` VALUES ('3619', '3', '0', '0.00', '1', '552.63', '1', '552.63', '1', '552.63', '0', '5', '5', '5', '1', '1496310653');
INSERT INTO `insu_mem_performance` VALUES ('3620', '213', '0', '0.00', '1', '500.72', '1', '500.72', '1', '500.72', '0', '6', '6', '6', '1', '1496310653');
INSERT INTO `insu_mem_performance` VALUES ('3621', '153123.', '0', '0.00', '1', '500.68', '1', '500.68', '1', '500.68', '0', '7', '7', '7', '1', '1496310653');
INSERT INTO `insu_mem_performance` VALUES ('3622', '432121', '0', '0.00', '1', '488.26', '1', '488.26', '1', '488.26', '0', '8', '8', '8', '1', '1496310653');
INSERT INTO `insu_mem_performance` VALUES ('3623', '5132', '0', '0.00', '1', '456.76', '1', '456.76', '1', '456.76', '0', '9', '10', '10', '1', '1496310653');
INSERT INTO `insu_mem_performance` VALUES ('3624', '1001', '0', '0.00', '1', '400.36', '1', '400.36', '1', '400.36', '0', '10', '11', '11', '1', '1496310653');
INSERT INTO `insu_mem_performance` VALUES ('3625', '7523170516', '0', '0.00', '3', '240.00', '6', '480.00', '6', '480.00', '0', '11', '9', '9', '1', '1496310653');
INSERT INTO `insu_mem_performance` VALUES ('3626', '7526170516', '0', '0.00', '3', '240.00', '3', '240.00', '3', '240.00', '0', '12', '12', '12', '1', '1496310653');
INSERT INTO `insu_mem_performance` VALUES ('3627', '22', '0', '0.00', '2', '150.18', '2', '150.18', '2', '150.18', '0', '13', '13', '13', '1', '1496310653');
INSERT INTO `insu_mem_performance` VALUES ('3628', '23', '0', '0.00', '2', '140.90', '2', '140.90', '2', '140.90', '0', '14', '14', '14', '1', '1496310653');
INSERT INTO `insu_mem_performance` VALUES ('3629', '7428170510', '0', '0.00', '1', '100.00', '1', '100.00', '1', '100.00', '0', '15', '15', '15', '1', '1496310653');
INSERT INTO `insu_mem_performance` VALUES ('3630', '7521170516', '0', '0.00', '1', '80.00', '1', '80.00', '1', '80.00', '0', '16', '16', '16', '1', '1496310653');
INSERT INTO `insu_mem_performance` VALUES ('3631', '7520170516', '0', '0.00', '1', '11.00', '1', '11.00', '1', '11.00', '0', '17', '17', '17', '1', '1496310653');

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
-- Records of insu_message
-- ----------------------------
INSERT INTO `insu_message` VALUES ('6', '1', '23', '1495873166', '30', '0', '2', '2');
INSERT INTO `insu_message` VALUES ('7', '1', '0', '1496196165', '31', '0', '2', '2');

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
-- Records of insu_message_text
-- ----------------------------
INSERT INTO `insu_message_text` VALUES ('2', 'qa', 'aa', '1495865319');
INSERT INTO `insu_message_text` VALUES ('3', 'qa', 'aa', '1495865324');
INSERT INTO `insu_message_text` VALUES ('4', 'qa', 'aa', '1495865325');
INSERT INTO `insu_message_text` VALUES ('5', 'qa', 'aa', '1495865326');
INSERT INTO `insu_message_text` VALUES ('6', 'qa', 'aa', '1495865328');
INSERT INTO `insu_message_text` VALUES ('7', 'aa', 'aa', '1495865393');
INSERT INTO `insu_message_text` VALUES ('8', 'aa', 'aa', '1495865403');
INSERT INTO `insu_message_text` VALUES ('9', 'aa', 'aa', '1495865405');
INSERT INTO `insu_message_text` VALUES ('10', 'aa', 'aa', '1495865415');
INSERT INTO `insu_message_text` VALUES ('11', 'aa', 'aa', '1495865416');
INSERT INTO `insu_message_text` VALUES ('12', 'aa', 'aa', '1495865416');
INSERT INTO `insu_message_text` VALUES ('13', 'aa', 'aa', '1495865416');
INSERT INTO `insu_message_text` VALUES ('14', 'aa', 'aa', '1495865417');
INSERT INTO `insu_message_text` VALUES ('15', 'aa', 'aa', '1495865417');
INSERT INTO `insu_message_text` VALUES ('16', 'aa', 'aa', '1495865417');
INSERT INTO `insu_message_text` VALUES ('17', 'aa', 'aa', '1495865428');
INSERT INTO `insu_message_text` VALUES ('18', 'aa', 'aa', '1495865431');
INSERT INTO `insu_message_text` VALUES ('19', 'aa', 'aa', '1495865464');
INSERT INTO `insu_message_text` VALUES ('20', 'aa', 'aa', '1495865495');
INSERT INTO `insu_message_text` VALUES ('21', 'aa', 'aa', '1495865541');
INSERT INTO `insu_message_text` VALUES ('22', 'qa', 'aa', '1495865626');
INSERT INTO `insu_message_text` VALUES ('23', 'aa', 'aa', '1495865738');
INSERT INTO `insu_message_text` VALUES ('24', 'aa', 'aa', '1495865795');
INSERT INTO `insu_message_text` VALUES ('26', 'qq', 'qasdadasd', '1495865916');
INSERT INTO `insu_message_text` VALUES ('27', 'aadsadw', 'qwadas ', '1495868090');
INSERT INTO `insu_message_text` VALUES ('30', '呵呵', '哈哈三大', '1495873166');
INSERT INTO `insu_message_text` VALUES ('31', 'sada', 'dsadsa', '1496196165');

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
-- Records of insu_rules
-- ----------------------------

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
-- Records of insu_stand_performance
-- ----------------------------
INSERT INTO `insu_stand_performance` VALUES ('44', '1002', '2000.00', '2000.00', '2000.00', '2000.00', '1', '1', '1', '1', '1', '1495185511');
INSERT INTO `insu_stand_performance` VALUES ('45', '12132', '600.00', '600.00', '600.00', '600.00', '2', '4', '4', '4', '1', '1495185511');
INSERT INTO `insu_stand_performance` VALUES ('46', '2600', '500.00', '500.00', '500.00', '500.00', '3', '6', '6', '6', '1', '1495185511');
INSERT INTO `insu_stand_performance` VALUES ('47', '260023', '500.00', '500.00', '500.00', '500.00', '4', '8', '8', '8', '1', '1495185511');
INSERT INTO `insu_stand_performance` VALUES ('48', '2500', '400.00', '400.00', '400.00', '400.00', '5', '10', '10', '10', '1', '1495185511');
INSERT INTO `insu_stand_performance` VALUES ('49', '1323321', '11.00', '11.00', '11.00', '11.00', '6', '14', '14', '14', '1', '1495185511');
INSERT INTO `insu_stand_performance` VALUES ('50', '45621', '0.00', '700.00', '700.00', '700.00', '0', '2', '2', '2', '1', '1495185511');
INSERT INTO `insu_stand_performance` VALUES ('51', '121', '0.00', '600.00', '600.00', '600.00', '0', '3', '3', '3', '1', '1495185511');
INSERT INTO `insu_stand_performance` VALUES ('52', '43554', '0.00', '600.00', '600.00', '600.00', '0', '5', '5', '5', '1', '1495185511');
INSERT INTO `insu_stand_performance` VALUES ('53', '121215', '0.00', '500.00', '500.00', '500.00', '0', '7', '7', '7', '1', '1495185511');
INSERT INTO `insu_stand_performance` VALUES ('54', '13213453', '0.00', '500.00', '500.00', '500.00', '0', '9', '9', '9', '1', '1495185511');
INSERT INTO `insu_stand_performance` VALUES ('55', '8521', '0.00', '400.00', '400.00', '400.00', '0', '11', '11', '11', '1', '1495185511');
INSERT INTO `insu_stand_performance` VALUES ('56', '43121', '0.00', '400.00', '400.00', '400.00', '0', '12', '12', '12', '1', '1495185511');
INSERT INTO `insu_stand_performance` VALUES ('57', '13213', '0.00', '300.00', '300.00', '300.00', '0', '13', '13', '13', '1', '1495185511');

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
-- Records of insu_sys_message
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8 COMMENT='首期保单表（邱位鹏）';

-- ----------------------------
-- Records of insurance
-- ----------------------------
INSERT INTO `insurance` VALUES ('24', '35', '1323321', '2345', '22', '22', '1494481984', '22', '20', null, '4', '1', '22', '13235431', '1', '1', '22', '1', '22.00', '405.00', '405.00', '100.00', '500.00', '0', '3', '22', '22', null, '0', '0', '0', '22', '22', '1', '22', '22', '1495604551', '1493568000', null, '1493568000', '1493568000', '1493568000', '1493568000', '-28800', '0', '0', null);
INSERT INTO `insurance` VALUES ('25', '25', '132332', '132332', '7428170510', '1', '1494481984', '25', '20', null, '6', null, '25', '25', '1', '1', '25', '0', '25.00', '280.00', '280.00', '100.00', '400.00', '0', '3', '25', '25', null, '0', '0', '0', '25', '25', null, '25', '25', '1495418896', '1493654400', null, '1493654400', '1493654400', '1493654400', '1493654400', null, '0', '0', null);
INSERT INTO `insurance` VALUES ('26', '35', '1323321', '2600', '7519170512', '11', '1494491663', '26', '20', null, '5', '1', '26', '26', '1', '1', '22', '1', '26.00', '400.00', '400.00', '500.12', '500.12', '0', '5', '26', '26', null, '44', '43', '42', '26', '26', '1', '26', '26', '1495418896', '1493568000', null, '-28800', '-28800', '1493568000', '1493568000', '-28800', '0', '0', null);
INSERT INTO `insurance` VALUES ('27', '35', '1323321', '111', '7518170512', '11', '1494491700', '11', '20', null, '3', '', '11', '11', '2', '2', '11', '0', '11.00', '420.00', null, '600.00', '600.00', '0', '11', '11', '11', null, '45', '43', '42', '11', '11', null, '', '11', '1493654400', '1493654400', null, '-28800', '-28800', '1493654400', '1493654400', '-28800', '-28800', '-28800', null);
INSERT INTO `insurance` VALUES ('28', '35', '132332', '132332', '1001', '223', '1494492296', '22', '20', null, '3', null, '22', '22', '1', '1', '22', '1', '22.00', '280.00', null, '400.36', '400.00', '1', '22', '22', '22', null, '1576', '1574', '1573', '222', '22', null, '22', '22', '1495604551', '1493654400', null, null, null, '1493654400', '1493654400', null, '0', '0', null);
INSERT INTO `insurance` VALUES ('33', '35', '1323321', '11111', '7520170516', '333', '1494492521', '33', '33', null, null, null, '333', '333', '1', '1', '333', '1', '333.00', null, null, '11.00', '11.00', '0', '11', '11', '11', null, '0', '0', '0', '11', '11', null, '11', '11', '1493654400', null, null, null, null, null, null, null, '0', '0', null);
INSERT INTO `insurance` VALUES ('34', '35', '2600', '1213', '111', '11', '1494492521', '33', '20', null, '6', '1', '333', '12312313', '1', '1', '312', null, null, '350.00', '350.00', '500.36', '500.00', null, '3', '12', '231', null, '0', '0', '0', '1321321', '3132', null, null, null, '1493654400', null, null, null, null, '1494522000', '1497200400', null, '0', '0', null);
INSERT INTO `insurance` VALUES ('35', '35', '12132', '1213', '213', '213', '1494492521', '33', '20', null, '6', '1', '333', '13135', '1', '1', '123', null, null, '420.00', '420.00', '500.72', '600.00', null, '3', '12', null, null, null, null, null, null, null, null, null, null, '1493654400', null, null, null, null, '1494435600', '1494867600', null, '0', '0', null);
INSERT INTO `insurance` VALUES ('36', '35', '13213', '13213', '111', '11', '1494492521', '33', '20', null, '6', '1', '333', '13215312', '1', '1', '642', null, null, '210.00', '210.00', '250.00', '300.00', null, '3', null, null, null, null, null, null, null, null, null, null, null, '1491062400', null, null, null, null, '1494349200', '1495386000', null, '0', '0', null);
INSERT INTO `insurance` VALUES ('37', '35', '13213453', '454215', '111', '11', '1494492521', '33', '20', null, '6', '1', '33', '12153', '1', '1', '1215', null, null, '350.00', '350.00', '72.68', '500.00', null, '3', '12', '1231', null, null, null, null, null, null, null, null, null, '1491062400', null, null, null, null, '1494349200', '1495386000', null, '0', '0', null);
INSERT INTO `insurance` VALUES ('38', '35', '43554', '46321', '354321', '121', '1494492322', '33', '20', null, '6', '1', '333', '1354312', '1', '1', '1354', null, null, '420.00', '420.00', '600.78', '600.00', null, '3', '123', '1531', null, null, null, null, null, null, null, null, null, '1491062400', null, null, null, null, '1494349200', '1495386000', null, '0', '0', null);
INSERT INTO `insurance` VALUES ('39', '35', '45621', '4612313', '153123.', '11', '1494492322', '33', '20', null, '6', '1', '33', '15321', '1', '1', '2315', null, null, '490.00', '490.00', '500.68', '700.00', null, '3', '5264', '82212', null, null, null, null, null, null, null, null, null, '1491062400', null, null, null, null, '1494349200', '1495386000', null, '0', '0', null);
INSERT INTO `insurance` VALUES ('40', '35', '121215', '15305', '432121', '153', '1494492322', '33', '20', null, '6', '1', '1221', '153122', '1', '1', '182', null, null, '350.00', '350.00', '488.26', '500.00', null, '3', '82', '81321', null, null, null, null, null, null, null, null, null, '1491062400', null, null, null, null, '1494349200', '1495386000', null, '0', '0', null);
INSERT INTO `insurance` VALUES ('41', '35', '8521', '21321', '5132', '15312', '1494492322', '33', '20', null, '6', '1', '32', '14151321', '1', '1', '11321', null, null, '280.00', '280.00', '456.76', '400.00', null, '3', '45132', '8213', null, null, null, null, null, null, null, null, null, '1491062400', null, null, null, null, '1494349200', '1495386000', null, '0', '0', null);
INSERT INTO `insurance` VALUES ('42', '35', '43121', '2', '3', '232132', '1494492322', '33', '20', null, '6', '1', '32326', '151321', '1', '1', '543123', null, null, '280.00', '280.00', '552.63', '400.00', null, '3', '354231', '121', null, null, null, null, null, null, null, null, null, '1491062400', null, null, null, null, '1494349200', '1495386000', null, '0', '0', null);
INSERT INTO `insurance` VALUES ('43', '35', '121', '431', '121321', '4312', '1494492322', '33', '20', null, '6', '1', '1321', '5121', '1', '1', '151231', null, null, '420.00', '420.00', '663.72', '600.00', null, '3', '43121', '854231', null, null, null, null, null, null, null, null, null, '1491062400', null, null, null, null, '1494349200', '1495386000', null, '0', '0', null);
INSERT INTO `insurance` VALUES ('45', '35', '1323321', '2223', '23', '22', '2017', '22', '20', null, null, '1', '22', '111111', '1', '1', '22', '1', '22.00', null, null, '72.51', '1000000.00', '1', null, '22', '22', null, null, null, null, '22', '22', '1', '22', '22', '1495161304', '2017', null, '2017', null, '2017', null, null, '1970', '1970', null);
INSERT INTO `insurance` VALUES ('47', '35', '1323321', '2345', '23', '22', '2017', '22', '20', null, null, '1', '22', '2222', '1', '1', '22', '1', '22.00', null, null, '68.39', '500.00', '1', null, '22', '22', null, null, null, null, '22', '22', '1', '22', '22', '1493654400', '2017', null, '2017', null, '2017', null, null, '1970', '1970', null);
INSERT INTO `insurance` VALUES ('49', '35', '1323321', '2345', '22', '22', '2017', '22', '20', null, null, '1', '22', '2222222', '1', '1', '22', '1', '22.00', null, null, '50.18', '500.00', '1', null, '22', '22', null, null, null, null, '22', '22', '1', '22', '22', '1495161304', '2017', '1495010639', '2017', null, '2017', null, null, '1970', '1970', null);
INSERT INTO `insurance` VALUES ('50', '100003', '7518170516', '7518170516', '7519170512', null, null, null, null, null, null, null, null, '191919', '1', '1', null, null, '1000.00', null, null, '80.00', '100.00', null, null, null, null, null, null, null, null, null, null, null, null, null, '1492617600', null, null, null, null, '1494259200', '1494518400', null, '0', '0', null);
INSERT INTO `insurance` VALUES ('51', '100003', '7520170244', '7518170516', '7521170516', '22', null, null, null, null, null, null, null, '212121', '1', '1', null, null, '1000.00', null, null, '80.00', '100.00', null, null, null, null, null, null, null, null, null, null, null, null, null, '1492617600', null, null, null, null, '1492790400', '1493049600', null, '0', '0', null);
INSERT INTO `insurance` VALUES ('52', '100003', '7520170516', '7518170516', '7523170516', '22', null, null, null, null, null, null, null, '232323', '1', '1', null, null, '1000.00', null, null, '80.00', '100.00', null, null, null, null, null, null, null, null, null, null, null, null, null, '1492185600', null, null, null, null, '1492185600', '1492617600', null, '0', '0', null);
INSERT INTO `insurance` VALUES ('53', '100003', '7525170516', '7525170516', '7526170516', '123', null, null, null, null, null, null, null, '262626', '1', '1', null, null, '1000.00', null, null, '80.00', '100.00', null, null, null, null, null, null, null, null, null, null, null, null, null, '1492185600', null, null, null, null, '1492185600', '1492617600', null, '0', '0', null);
INSERT INTO `insurance` VALUES ('54', '100003', '7525170516', '7525170516', '7526170516', '22', null, null, null, null, null, null, null, '272727', '1', '1', null, null, '1000.00', null, null, '80.00', '100.00', null, null, null, null, null, null, null, null, null, null, null, null, null, '1492704000', null, null, null, null, '1492704000', '1494432000', null, '0', '0', null);
INSERT INTO `insurance` VALUES ('56', '100003', '7525170516', '7525170516', '7526170516', '11', null, null, null, null, null, null, null, '282828', '1', '1', null, null, '1000.00', null, null, '80.00', '100.00', null, null, null, null, null, null, null, null, null, null, null, null, null, '1492617600', null, null, null, null, '1492617600', '1495123200', null, '0', '0', null);
INSERT INTO `insurance` VALUES ('57', '100003', '7520170516', '7518170516', '7523170516', '1', null, null, null, null, null, null, null, '242424', '1', '1', null, null, '1000.00', null, null, '80.00', '100.00', null, null, null, null, null, null, null, null, null, null, null, null, null, '1492617600', null, null, null, null, '1492617600', '1495123200', null, '0', '0', null);
INSERT INTO `insurance` VALUES ('59', '100003', '7520170516', '7518170516', '7523170516', '11', null, null, null, null, null, null, null, '252525', '1', '1', null, null, '1000.00', null, null, '80.00', '100.00', null, null, null, null, null, null, null, null, null, null, null, null, null, '1492531200', null, null, null, null, '1492531200', '1495123200', null, '0', '0', null);
INSERT INTO `insurance` VALUES ('60', '100003', '7520170516', '7518170516', '7523170516', null, null, null, null, null, null, null, null, '303030', '1', '1', null, null, '1000.00', null, null, '80.00', '100.00', null, null, null, null, null, null, null, null, null, null, null, null, null, '1489161600', null, null, null, null, '1492185600', '1492185600', null, '0', '0', null);
INSERT INTO `insurance` VALUES ('61', '100003', '7520170516', '7518170516', '7523170516', null, null, null, null, null, null, null, null, '313131', '1', '1', null, null, '1000.00', null, null, '80.00', '100.00', null, null, null, null, null, null, null, null, null, null, null, null, null, '1489161600', null, null, null, null, '1494172800', '1494259200', null, '0', '0', null);
INSERT INTO `insurance` VALUES ('62', '100003', '7520170516', '7518170516', '7523170516', null, null, null, null, null, null, null, null, '323232', '1', '1', null, null, '1000.00', null, null, '80.00', '100.00', null, null, null, null, null, null, null, null, null, null, null, null, null, '1489161600', null, null, null, null, '1491321600', '1495123200', null, '0', '0', null);
INSERT INTO `insurance` VALUES ('63', '100003', '7520170516', '7518170516', '7523170516', null, null, null, null, null, '27', null, null, '333333', '1', '2', null, null, '1000.00', null, null, '80.00', '100.00', null, null, null, null, null, null, null, null, null, null, null, null, null, '1492531200', null, null, null, null, '0', '0', null, '0', '0', null);
INSERT INTO `insurance` VALUES ('64', '100003', '7520170516', '7518170516', '7523170516', null, null, null, null, null, '28', null, null, '343434', '1', '3', null, null, '1000.00', null, null, '80.00', '100.00', null, null, null, null, null, null, null, null, null, null, null, null, null, '1492531200', null, null, null, null, '0', '0', null, '0', '0', null);
INSERT INTO `insurance` VALUES ('66', '100003', '7525170516', '7525170516', '7526170516', null, null, null, null, null, '27', null, null, '353535', '1', '3', null, null, '1000.00', null, null, '80.00', '100.00', null, null, null, null, null, null, null, null, null, null, null, null, null, '1492531200', null, null, null, null, '0', '0', null, '0', '0', null);
INSERT INTO `insurance` VALUES ('67', '100003', '7525170516', '7525170516', '7526170516', null, null, null, null, null, '28', null, null, '363636', '1', '2', null, null, '1000.00', null, null, '80.00', '100.00', null, null, null, null, null, null, null, null, null, null, null, null, null, '1492531200', null, null, null, null, '0', '0', null, '0', '0', null);
INSERT INTO `insurance` VALUES ('68', '100003', '7520170244', '7518170516', '7521170516', null, null, null, null, null, '27', null, null, '373737', '1', '2', null, null, '1000.00', null, null, '80.00', '100.00', null, null, null, null, null, null, null, null, null, null, null, null, null, '1492531200', null, null, null, null, '0', '0', null, '0', '0', null);
INSERT INTO `insurance` VALUES ('69', '100003', '7520170244', '7518170516', '7521170516', null, null, null, null, null, '28', null, null, '383838', '1', '3', null, null, '1000.00', null, null, '80.00', '100.00', null, null, null, null, null, null, null, null, null, null, null, null, null, '1492531200', null, null, null, null, '0', '0', null, '0', '0', null);
INSERT INTO `insurance` VALUES ('71', '100003', '7518170516', '7518170516', '7519170512', null, null, null, null, null, '27', null, null, '393939', '1', '3', null, null, '1000.00', null, null, '80.00', '100.00', null, null, null, null, null, null, null, null, null, null, null, null, null, '1492531200', null, null, null, null, '0', '0', null, '0', '0', null);
INSERT INTO `insurance` VALUES ('72', '100003', '7518170516', '7518170516', '7519170512', null, null, null, null, null, '28', null, null, '727272', '1', '3', null, null, '1000.00', null, null, '80.00', '100.00', null, null, null, null, null, null, null, null, null, null, null, null, null, '1492531200', null, null, null, null, '0', '0', null, '0', '0', null);
INSERT INTO `insurance` VALUES ('73', '100003', '7518170516', '7518170516', '7519170512', null, null, null, null, null, '27', null, null, '737373', '1', '2', null, null, '1000.00', null, null, '80.00', '100.00', null, null, null, null, null, null, null, null, null, null, null, null, null, '1492531200', null, null, null, null, '0', '0', null, '0', '0', null);
INSERT INTO `insurance` VALUES ('74', '100003', '7518170516', '7518170516', '7519170512', '1001', '1494492322', '22', '20', null, '6', '1', '123456', '123456', '1', '1', '123456', '1', '600.00', '420.00', '450.00', '450.00', '600.00', '0', '3', '123321', '515', null, null, null, null, null, null, null, null, null, '1494565526', null, null, null, null, null, null, null, '0', '0', null);

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
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8 COMMENT='续期保单表（邱位鹏）';

-- ----------------------------
-- Records of insurance_re
-- ----------------------------
INSERT INTO `insurance_re` VALUES ('1', '1123', '123', '12', '111', '111', '1495162093', '13', '20', '6', '产品6', '中国人寿', '13', '1324613215', '0', '1', '13', '1', '1.00', '500.00', '300.00', '1', '1', 'aaa', '13', '1', '312', '1', '1', '123', '1459440080', '-28800', null, null, '山东省德州市平原县');
INSERT INTO `insurance_re` VALUES ('2', '12323', '132332', '132332', '7428170510', '7428170510', '1495163096', '123', '20', '6', null, '1', '123', '461213435', '0', '1', '23', '1', '1.00', '500.00', '100.00', '1', '3', 'dad', '123', '1', '23', '1', '1', '23', '1456761700', '-28800', null, null, '内蒙古');
INSERT INTO `insurance_re` VALUES ('3', '1123', '123', '12', '111', '111', '1494497513', '111', '20', '6', null, '1', '111', '343543434', '0', '1', '11', '1', '1.00', '500.00', '300.00', '1', '5', 'bbb', '111', '1', '111', '1', '1', '111', '1337101200', '-28800', null, null, null);
INSERT INTO `insurance_re` VALUES ('7', '1112314', '132332', '132332', '7520170516', '44342', '1494492697', '123', '20', '6', '产品6', '中国人寿', '5645', '123', '0', '1', '4686', '1', '45645.00', '500.00', '400.00', '1', '4', '45645', '45645', '1231', '1231', null, '12312', '1231', '1456761700', '-28800', null, null, null);
INSERT INTO `insurance_re` VALUES ('9', '0', null, '1000', '1004', '22', '2017', '22', '20', '6', null, '1', '22', '2222222', '0', null, '22', '1', '22.00', '500.00', '500.00', '1', '2', '22', '22', '22', '22', '1', '22', '22', '1463331600', '1970', '1495096586', null, null);
INSERT INTO `insurance_re` VALUES ('10', '66', '666', '666', '66', '66', '1495170727', '66', '66', null, null, null, '66', '66', '0', null, '66', '1', '66.00', '666.00', null, '1', '6', '666', '666', '666', '666', null, '66', '666', '1459440080', '0', null, null, null);
INSERT INTO `insurance_re` VALUES ('12', '777', '777', '77', '77', '77', '1495171964', '77', '77', null, null, '人寿', '77', '77', '0', null, '77', '0', '11.00', '700.00', '200.00', '0', '11', '1', '111', '1', '11', null, '1', '11', '1396281800', '0', null, null, 'beijing');
INSERT INTO `insurance_re` VALUES ('21', '1112314', '132332', '132332', '7520170516', '44342', null, null, null, null, null, null, null, null, '0', null, null, null, null, '300.00', '300.00', null, null, null, null, null, null, null, null, null, '1460736000', '0', null, null, null);
INSERT INTO `insurance_re` VALUES ('22', '100003', '2147483647', '2147483647', '7519170512', null, null, null, null, '27', null, null, null, '101010', '0', null, '', null, '1000.00', '100.00', null, null, '5', null, null, null, null, null, null, null, '1492531200', '0', null, null, null);
INSERT INTO `insurance_re` VALUES ('23', '100003', '2147483647', '2147483647', '7519170512', null, null, null, null, '28', null, null, null, '111111', '0', null, '', null, '1000.00', '100.00', null, null, '10', null, null, null, null, null, null, null, '1492531200', '0', null, null, null);
INSERT INTO `insurance_re` VALUES ('24', '100003', '2147483647', '2147483647', '7519170512', null, null, null, null, '29', null, null, null, '121212', '0', null, '', null, '1000.00', '100.00', null, null, '5', null, null, null, null, null, null, null, '1492531200', '0', null, null, null);
INSERT INTO `insurance_re` VALUES ('25', '100003', '2147483647', '2147483647', '7519170512', null, null, null, null, '30', null, null, null, '131313', '0', null, '', null, '1000.00', '100.00', null, null, '10', null, null, null, null, null, null, null, '1492531200', '0', null, null, null);
INSERT INTO `insurance_re` VALUES ('26', '100003', '2147483647', '2147483647', '7521170516', null, null, null, null, '27', null, null, null, '141414', '0', null, '', null, '1000.00', '100.00', null, null, '5', null, null, null, null, null, null, null, '1492531200', '0', null, null, null);
INSERT INTO `insurance_re` VALUES ('27', '100003', '2147483647', '2147483647', '7521170516', null, null, null, null, '28', null, null, null, '151515', '0', null, '', null, '1000.00', '100.00', null, null, '5', null, null, null, null, null, null, null, '1492531200', '0', null, null, null);
INSERT INTO `insurance_re` VALUES ('28', '100003', '2147483647', '2147483647', '7521170516', null, null, null, null, '28', null, null, null, '161616', '0', null, '', null, '1000.00', '100.00', null, null, '5', null, null, null, null, null, null, null, '1492531200', '0', null, null, null);
INSERT INTO `insurance_re` VALUES ('29', '100003', '2147483647', '2147483647', '7521170516', null, null, null, null, '29', null, null, null, '171717', '0', null, '', null, '1000.00', '100.00', null, null, '5', null, null, null, null, null, null, null, '1492531200', '0', null, null, null);
INSERT INTO `insurance_re` VALUES ('30', '100003', '2147483647', '2147483647', '7523170516', null, null, null, null, '30', null, null, null, '181818', '0', null, '', null, '1000.00', '100.00', null, null, '10', null, null, null, null, null, null, null, '1492531200', '0', null, null, null);
INSERT INTO `insurance_re` VALUES ('31', '100003', '2147483647', '2147483647', '7523170516', null, null, null, null, '27', null, null, null, '191919', '0', null, '', null, '1000.00', '100.00', null, null, '10', null, null, null, null, null, null, null, '1492531200', '0', null, null, null);
INSERT INTO `insurance_re` VALUES ('32', '100003', '2147483647', '2147483647', '7523170516', null, null, null, null, '29', null, null, null, '202020', '0', null, '', null, '1000.00', '100.00', null, null, '5', null, null, null, null, null, null, null, '1492531200', '0', null, null, null);
INSERT INTO `insurance_re` VALUES ('33', '100003', '2147483647', '2147483647', '7523170516', null, null, null, null, '30', null, null, null, '222222', '0', null, '', null, '1000.00', '100.00', null, null, '10', null, null, null, null, null, null, null, '1492531200', '0', null, null, null);
INSERT INTO `insurance_re` VALUES ('34', '100003', '2147483647', '2147483647', '7526170516', null, null, null, null, '27', null, null, null, '232323', '0', null, '', null, '1000.00', '100.00', null, null, '5', null, null, null, null, null, null, null, '1492531200', '0', null, null, null);
INSERT INTO `insurance_re` VALUES ('35', '100003', '2147483647', '2147483647', '7526170516', null, null, null, null, '28', null, null, null, '242424', '0', null, '', null, '1000.00', '100.00', null, null, '10', null, null, null, null, null, null, null, '1492531200', '0', null, null, null);
INSERT INTO `insurance_re` VALUES ('36', '100003', '2147483647', '2147483647', '7526170516', null, null, null, null, '29', null, null, null, '252525', '0', null, '', null, '1000.00', '100.00', null, null, '5', null, null, null, null, null, null, null, '1492531200', '0', null, null, null);
INSERT INTO `insurance_re` VALUES ('37', '100003', '2147483647', '2147483647', '7526170516', null, null, null, null, '30', null, null, null, '262626', '0', null, '', null, '1000.00', '100.00', null, null, '10', null, null, null, null, null, null, null, '1492531200', '0', null, null, null);
INSERT INTO `insurance_re` VALUES ('38', '100003', '2147483647', '2147483647', '7526170516', null, null, null, null, '28', null, null, null, '272727', '0', null, '', null, '1000.00', '100.00', null, null, '10', null, null, null, null, null, null, null, '1492531200', '0', null, null, null);
INSERT INTO `insurance_re` VALUES ('39', '1112314', '777', '77', '77', '77', '1495171964', '77', '77', null, null, '人寿', '77', '77', '0', '1', '77', '1', '11.00', '300.00', '100.00', '1', '6', '16556', '111', '1', '11', null, '66', '666', '1430409700', '0', null, null, null);
INSERT INTO `insurance_re` VALUES ('40', '777', '77', '77', '77', '77', '1495171964', '景', '88', '6', '产品1', '人寿', '77', '77', '0', '2', '寿险', '1', '10000.00', '200.00', '200.00', '1', '1', '666', '666', '666', '666', '1', '66', '666', '1430409800', '0', null, null, null);

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
-- Records of leave_comments
-- ----------------------------
INSERT INTO `leave_comments` VALUES ('1', '1002', '123123123', '1494830963', '1', 'ceasdas ', '1494830963', '1');

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
-- Records of life_detail
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='管理员表---赵';

-- ----------------------------
-- Records of manager
-- ----------------------------
INSERT INTO `manager` VALUES ('1', '1', 'admin', '96e79218965eb72c92a549dd5a330112', 'admin', null, '11', '123@qq.com', '18518695431', '1', '', '0', '4', '', '', '', '1496308060', '1495874302');
INSERT INTO `manager` VALUES ('2', '2', 'admin888', '96e79218965eb72c92a549dd5a330112', 'admin888', null, '12', '54444444@qq.com', '13526565534', '0', '', '100001', '4', '', '123', '993254628', '0', '1494841204');
INSERT INTO `manager` VALUES ('3', '45', '你好', 'e10adc3949ba59abbe56e057f20f883e', 'admin', null, '0', '545464@qq.com', '13126565534', '1', '', '7676', '3', '7676', '', '', '0', '1495873006');
INSERT INTO `manager` VALUES ('4', '4546', '不知道', 'e10adc3949ba59abbe56e057f20f883e', '不知道', null, '0', '540888qq@qq.com', '13522864800', '1', '', '', '3', '', '', '', '1496299993', '1496197261');
INSERT INTO `manager` VALUES ('9', '56', '5656', 'e10adc3949ba59abbe56e057f20f883e', '5656', null, '135228648', '565@qq.com', '13522864801', '0', '', '', '3', '', '', '', '0', '1496309354');
INSERT INTO `manager` VALUES ('10', '454', '4545', 'e10adc3949ba59abbe56e057f20f883e', '5464', null, '0', '131313@qq.com', '13522556684', '-1', '', '', '3', '', '', '', '0', '1496309394');

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
-- Records of manager_auth_access
-- ----------------------------
INSERT INTO `manager_auth_access` VALUES ('3', '29,30,34,35,28,32,33', '0');
INSERT INTO `manager_auth_access` VALUES ('4', 'all', '0');
INSERT INTO `manager_auth_access` VALUES ('5', '29,30,34,35', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 COMMENT='后台权限节点表\r\n李杨';

-- ----------------------------
-- Records of manager_auth_node
-- ----------------------------
INSERT INTO `manager_auth_node` VALUES ('28', '供应商管理', 'Supplier', '0', '0', '0', '0', '0', '1496216429', 'SupplierController@index');
INSERT INTO `manager_auth_node` VALUES ('29', '添加供应商', 'Supplier', '0', '0', '0', '28', '0', '1496219103', 'SupplierController@product');
INSERT INTO `manager_auth_node` VALUES ('30', '编辑 删除 供应商', 'Supplier', '0', '0', '0', '28', '0', '1496219192', 'SupplierController@edit,SupplierController@del');
INSERT INTO `manager_auth_node` VALUES ('32', '协议录入', 'Agreement', '0', '0', '0', '0', '0', '1496288128', 'AgreementController@index');
INSERT INTO `manager_auth_node` VALUES ('33', '订单管理', 'Order', '0', '0', '0', '0', '0', '1496297669', 'OrderController@index');
INSERT INTO `manager_auth_node` VALUES ('34', '订单详情页', 'Order', '0', '0', '0', '33', '0', '1496297814', 'OrderController@details');
INSERT INTO `manager_auth_node` VALUES ('35', '删除订单', 'Order', '0', '0', '0', '33', '0', '1496297842', 'OrderController@delete');

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
-- Records of manager_auth_role
-- ----------------------------
INSERT INTO `manager_auth_role` VALUES ('3', '总编', null, '0', '只对栏目有添加审核功能', '1496303063', '0');
INSERT INTO `manager_auth_role` VALUES ('4', '超级管理员', null, '0', '拥有所有权限', '1496204705', '0');
INSERT INTO `manager_auth_role` VALUES ('5', '客服', null, '0', '服务保险', '1496298569', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 COMMENT='会员表（卢）';

-- ----------------------------
-- Records of member
-- ----------------------------
INSERT INTO `member` VALUES ('1', '1001', '1001', '132332', '132332', '35', '18610415485', '10481618@qq.com', '0', '', '卢志涛', '1', '1', '200', '1', '1492654210', '0', '1492654210', '150.00', '100.00', '50.00');
INSERT INTO `member` VALUES ('2', '1002', '1002', '132332', '132332', '35', '15655206598', 'iyting@foxmail.com', '1111', '1', 'wang', '1', '1', '0', '1', '1492654210', '1001', '1492654210', null, null, null);
INSERT INTO `member` VALUES ('14', '100003', '100003', '1002', '100003', '35', '15255565696', '', 'e10adc3949ba59abbe56e057f20f883e', null, 'aa', '1', '1', '0', '1', null, '1002', '1494403097', '200.00', '100.00', '100.00');
INSERT INTO `member` VALUES ('18', '1004', '1004', '110', '2345', '35', '15858585989', '', 'e10adc3949ba59abbe56e057f20f883e', null, 'ddgggg', '1', '0', '0', '1', null, '1002', '1494416567', null, null, null);
INSERT INTO `member` VALUES ('19', '7428170510', '', '1323321', null, null, 'ww', '', 'e10adc3949ba59abbe56e057f20f883e', null, '哇哇哇哇哇哇哇', '1', '0', '0', '1', null, '1001', '1494416609', null, null, null);
INSERT INTO `member` VALUES ('20', '3296170510', '3296170510', null, null, null, '11', '', 'e10adc3949ba59abbe56e057f20f883e', null, 'sss', '1', '0', '0', '1', null, null, '1494416669', null, null, null);
INSERT INTO `member` VALUES ('21', '7589170510', '7589170510', null, null, null, 'dd', '', 'e10adc3949ba59abbe56e057f20f883e', null, 'ddd', '1', '0', '0', '1', null, null, '1494416693', null, null, null);
INSERT INTO `member` VALUES ('22', '0863170510', '0863170510', null, null, null, '考虑，ki', '', 'e10adc3949ba59abbe56e057f20f883e', null, 'ddgggg', '1', '0', '0', '1', null, null, '1494416777', null, null, null);
INSERT INTO `member` VALUES ('23', '5782170511', '5782170511', null, null, null, '1010', '', 'e10adc3949ba59abbe56e057f20f883e', null, '张三', '1', '1', '0', '1', null, null, '1494465508', null, null, null);
INSERT INTO `member` VALUES ('24', '3905170511', '3905170511', '1323321', null, null, 'rtg', '', 'e10adc3949ba59abbe56e057f20f883e', null, 'ddd', '1', '0', '0', '1', null, '1002', '1494465751', null, null, null);
INSERT INTO `member` VALUES ('25', '7691170512', '7691170512', '1323321', '2345', '123456789', '17099089989', '', 'e10adc3949ba59abbe56e057f20f883e', null, '卢志涛', '1', '0', '0', '1', null, '7428170510', '1494555598', null, null, null);
INSERT INTO `member` VALUES ('26', '7518170512', '', '1323321', null, null, '18546762954', '', 'e10adc3949ba59abbe56e057f20f883e', null, '会员', '1', '0', '0', '1', null, '1001', '1494571268', null, null, null);
INSERT INTO `member` VALUES ('27', '7518170516', '7518170516', '7518170516', '7518170516', '100003', null, null, 'e10adc3949ba59abbe56e057f20f883e', null, '旗舰店', '1', '3', '0', '1', null, '100003', null, null, null, null);
INSERT INTO `member` VALUES ('28', '7519170512', '7519170516', '7518170516', '7518170516', '100003', null, null, 'e10adc3949ba59abbe56e057f20f883e', null, '旗直辖', '1', '0', '0', '1', null, '7518170516', null, null, null, null);
INSERT INTO `member` VALUES ('29', '7520170244', '7520170516', '7520170244', '7518170516', '100003', null, null, 'e10adc3949ba59abbe56e057f20f883e', null, '标准店', '1', '2', '0', '1', null, '7518170516', null, null, null, null);
INSERT INTO `member` VALUES ('30', '7521170516', '7521170516', '7520170244', '7518170516', '100003', null, null, 'e10adc3949ba59abbe56e057f20f883e', null, '标准1', '1', '0', '0', '1', null, '7520170516', null, null, null, null);
INSERT INTO `member` VALUES ('31', '7522170516', '7522170516', '7522170516', '7518170516', '100003', null, null, 'e10adc3949ba59abbe56e057f20f883e', null, '标准2', '1', '2', '0', '1', null, '7520170516', null, null, null, null);
INSERT INTO `member` VALUES ('32', '7523170516', '7523170516', '7520170516', '7518170516', '100003', null, null, 'e10adc3949ba59abbe56e057f20f883e', null, '标1推', '1', '0', '0', '1', null, '7521170516', null, null, null, null);
INSERT INTO `member` VALUES ('33', '7524170516', '7524170516', '7520170516', '7518170516', '100003', '54552', '22323', 'e10adc3949ba59abbe56e057f20f883e', '333', '标2推', '1', '1', '44', '1', '44', '7523170516', '11', null, null, null);
INSERT INTO `member` VALUES ('34', '7525170516', '7525170516', '7525170515', '7525170516', '100003', null, null, 'e10adc3949ba59abbe56e057f20f883e', null, '旗舰2', '1', '2', '0', '1', null, '100003', null, null, null, null);
INSERT INTO `member` VALUES ('35', '7526170516', '7526170516', '7525170516', '7525170516', '100003', null, null, 'e10adc3949ba59abbe56e057f20f883e', null, '会员2', '1', '0', '0', '1', null, '7525170516', null, null, null, null);
INSERT INTO `member` VALUES ('36', '7527170516', '7527170516', '7527170516', '7527170516', '100003', null, null, 'e10adc3949ba59abbe56e057f20f883e', null, '旗舰店3', '1', '3', '0', '1', null, '100003', null, null, null, null);

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
-- Records of member_browsing
-- ----------------------------

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
-- Records of member_cash
-- ----------------------------
INSERT INTO `member_cash` VALUES ('0000000001', '1001', '卢志涛', '200.00', '1495209600', '1', '123456789');
INSERT INTO `member_cash` VALUES ('0000000002', '1001', '卢志涛', '300.00', '1495123200', '0', '123456789');
INSERT INTO `member_cash` VALUES ('0000000003', '1001', '卢志涛', '400.00', '1495036800', '1', '123456789');
INSERT INTO `member_cash` VALUES ('0000000004', '1001', '卢志涛', '100.00', '1494950400', '0', '123456789');
INSERT INTO `member_cash` VALUES ('0000000005', '1001', '卢志涛', '50.00', '1494864000', '1', '123456789');
INSERT INTO `member_cash` VALUES ('0000000006', '1001', '卢志涛', '25.00', '1494777600', '0', '123456789');
INSERT INTO `member_cash` VALUES ('0000000007', '1001', '卢志涛', '95.00', '1494691200', '1', '123456789');
INSERT INTO `member_cash` VALUES ('0000000008', '1001', '卢志涛', '110.00', '1494604800', '0', '123456789');
INSERT INTO `member_cash` VALUES ('0000000009', '1001', '卢志涛', '650.00', '1494518400', '1', '123456789');
INSERT INTO `member_cash` VALUES ('0000000010', '1001', '卢志涛', '380.00', '1494432000', '0', '123456789');
INSERT INTO `member_cash` VALUES ('0000000011', '1001', '卢志涛', '400.00', '1494345600', '1', '123456789');
INSERT INTO `member_cash` VALUES ('0000000012', '1001', '卢志涛', '115.00', '1495382400', '0', '123456789');

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
-- Records of member_credit_log
-- ----------------------------

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
-- Records of member_credit_rule
-- ----------------------------

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
-- Records of member_favorite
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='会员详情表（卢）';

-- ----------------------------
-- Records of member_profile
-- ----------------------------
INSERT INTO `member_profile` VALUES ('5', '1001', null, '1', '', 'daws', '', '', '0', '227', '261', '265', '', '', '', '');
INSERT INTO `member_profile` VALUES ('9', '1004', null, '1', '', '111111', '', '', '0', '227', '0', '0', '', '', '', '');
INSERT INTO `member_profile` VALUES ('10', '7428170510', null, '1', '', '1111', '', '', '0', '0', '0', '0', '', '', '', '');
INSERT INTO `member_profile` VALUES ('11', '3296170510', null, '1', '', '11', '', '', '0', '0', '0', '0', '', '', '', '');
INSERT INTO `member_profile` VALUES ('12', '7589170510', null, '1', '', 'dd', '', '', '0', '0', '0', '0', '', '', '', '');
INSERT INTO `member_profile` VALUES ('13', '0863170510', null, '1', '', 'hfg', '', '', '0', '0', '0', '0', '', '', '', '');
INSERT INTO `member_profile` VALUES ('14', '5782170511', null, '1', '', '41216', '', '', '0', '0', '0', '0', '', '', '', '');
INSERT INTO `member_profile` VALUES ('15', '3905170511', null, '1', '', 'hdfb', '', '', '0', '0', '0', '0', '', '', '', '');
INSERT INTO `member_profile` VALUES ('16', '7691170512', null, '1', '', '412726199007014116', '', '', '0', '104', '138', '139', '', '', '', '');
INSERT INTO `member_profile` VALUES ('17', '7524170516', 'ddd', '1', '22', '123', '11', '11', '0', '1', '0', '0', '2', '22', '22', '22');

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
-- Records of member_standard
-- ----------------------------
INSERT INTO `member_standard` VALUES ('1', '1004', '12335', '店铺1');
INSERT INTO `member_standard` VALUES ('2', '1002', '5465', '店铺2');
INSERT INTO `member_standard` VALUES ('3', '1001', '132332', '店铺3');

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
-- Records of member_test_result
-- ----------------------------
INSERT INTO `member_test_result` VALUES ('1', '1001', '[{\"problem\":\"1+5=?\",\"Answer\":\"C\\u30017\",\"CorrectAnswer\":\"A\\u30016\"},{\"problem\":\"1+9=?\",\"Answer\":\"B\\u30017\",\"CorrectAnswer\":\"D\\u300110\"}]', '0', '60', null);

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
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8 COMMENT='新契约品质系数表\r\n李杨';

-- ----------------------------
-- Records of new_contract_coefficient
-- ----------------------------
INSERT INTO `new_contract_coefficient` VALUES ('1', '1001', '0.30', '0', '0');
INSERT INTO `new_contract_coefficient` VALUES ('4', '2502170510', '1.00', null, null);
INSERT INTO `new_contract_coefficient` VALUES ('8', '9645170510', '1.00', null, null);
INSERT INTO `new_contract_coefficient` VALUES ('9', '7428170510', '1.00', null, null);
INSERT INTO `new_contract_coefficient` VALUES ('10', '3296170510', '1.00', null, null);
INSERT INTO `new_contract_coefficient` VALUES ('11', '7589170510', '1.00', null, null);
INSERT INTO `new_contract_coefficient` VALUES ('12', '0863170510', '1.00', null, null);
INSERT INTO `new_contract_coefficient` VALUES ('13', '5782170511', '1.00', null, null);
INSERT INTO `new_contract_coefficient` VALUES ('14', '3905170511', '1.00', null, null);
INSERT INTO `new_contract_coefficient` VALUES ('15', '7691170512', '1.00', null, null);
INSERT INTO `new_contract_coefficient` VALUES ('16', '7518170512', '1.00', null, null);
INSERT INTO `new_contract_coefficient` VALUES ('17', '2', '0.10', '1', '1');
INSERT INTO `new_contract_coefficient` VALUES ('18', '3', '0.20', '2', '2');
INSERT INTO `new_contract_coefficient` VALUES ('19', '2', '0.10', '1494923815', '1');
INSERT INTO `new_contract_coefficient` VALUES ('20', '3', '0.20', '1494923815', '2');
INSERT INTO `new_contract_coefficient` VALUES ('21', '2', '0.10', '1494983283', '1');
INSERT INTO `new_contract_coefficient` VALUES ('22', '3', '0.20', '1494983283', '2');
INSERT INTO `new_contract_coefficient` VALUES ('23', '2', '0.10', '1494983294', '1');
INSERT INTO `new_contract_coefficient` VALUES ('24', '3', '0.20', '1494983294', '2');
INSERT INTO `new_contract_coefficient` VALUES ('25', '7519170512', '0.20', null, null);
INSERT INTO `new_contract_coefficient` VALUES ('26', '7521170516', '0.60', null, null);
INSERT INTO `new_contract_coefficient` VALUES ('27', '7523170516', '0.80', null, null);
INSERT INTO `new_contract_coefficient` VALUES ('28', '7526170516', '1.00', null, null);

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
-- Records of non_life_detail
-- ----------------------------

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
-- Records of order_master
-- ----------------------------
INSERT INTO `order_master` VALUES ('3', '1', '1', '1', '1', '1', '3', '1', '1.00');

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
-- Records of order_schedule
-- ----------------------------
INSERT INTO `order_schedule` VALUES ('1', '3', '1', '意外伤害', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', null, null);

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
-- Records of org_target
-- ----------------------------

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
-- Records of organization
-- ----------------------------
INSERT INTO `organization` VALUES ('1', '123456789', '0', '123456789', '河北分公司', '1', '0', '河北分公司啊啊啊', '4', '4', '0', '4', '河北', '500', '1', '1231231321', '123151', '1321321', '321321321', '1', '12313546', '0', '0');
INSERT INTO `organization` VALUES ('2', '1002', '0', '123456789', 'iyting标准店店铺', '3', '1', '标准店铺', '4', '4', '0', '4', '北京', '566', '0', '1565526852', '125222', '12222', '1002', '0', '12245661', '1485907200', '1491004800');
INSERT INTO `organization` VALUES ('3', '2345', '1000', '3905170511', '龙门客栈', '3', '1', '阿斯顿发阿斯顿发阿萨德发送', '4', '4', '1', '4', '北京', '1', '-1', '15655206598', '12322', '1222', '1003', '1', '111111111', '1485878400', '1491004800');
INSERT INTO `organization` VALUES ('4', '11111', '2345', '3905170511', '希尔顿', '2', '1', '店1', '4', '4', '2', '4', '北京', '1', '0', '15655206598', '12222', '1112', '1004', '1', '1', '1435680000', '1435680000');
INSERT INTO `organization` VALUES ('5', '2223', '235', '3905170511', '喜来登', '3', '1', '店3', '4', '4', '0', '4', '北京', '1', '0', '15685555555', '11111', '111', '11', '1', '1', '0', '0');
INSERT INTO `organization` VALUES ('6', '2600', '1000', '25', '圆山大酒店', '3', '1', '店3', '4', '4', '0', '4', '北京', '1', '1', '15685555555', '11111', '111', '11', '1', '1', '0', '0');
INSERT INTO `organization` VALUES ('7', '35', '12345678', '25', '同福客栈', '3', '1', '店3', '4', '4', '0', '4', '北京', '1', '0', '15685555555', '11111', '111', '11', '1', '1', '0', '0');
INSERT INTO `organization` VALUES ('8', '25', '123456789', '123456789', '潇湘馆', '3', '1', '店3', '4', '4', '0', '4', '北京', '1', '0', '15685555555', '11111', '111', '11', '1', '1', '0', '0');
INSERT INTO `organization` VALUES ('15', '100001', '1015', '100001', '分公司', '1', null, '店3', '4', '4', '0', '4', '北京', '1', '0', '15685555555', '11111', '111', '11', '1', '1', '0', '0');
INSERT INTO `organization` VALUES ('28', '132332', '132332', '100001', '旗舰店', '2', '1', null, '227', '261', '0', '265', '', null, '1', '18610415485', null, '10481618@qq.com', '10065', '1', '1494551801', '1494432000', '1494432000');
INSERT INTO `organization` VALUES ('29', '1323321', '132332', '100001', '标准店', '3', '1', null, '227', '261', '0', '265', '', null, '0', '18610415485', null, '10481618@qq.com', '1008', '1', '1494556297', '1494432000', '1494432000');
INSERT INTO `organization` VALUES ('30', '1323322', '100001', '100001', '店铺3', '3', '1', null, '227', '261', '0', '265', '', null, '0', '18610415485', null, '10481618@qq.com', '1005', '0', '1494556740', '1494432000', '1494432000');
INSERT INTO `organization` VALUES ('31', '100003', '100003', '100003', '卢志涛分公司', '1', '1', '卢志涛分公司的门店介绍', '1', '2', '0', '3', '平安里33弄', null, '1', '17099088999', null, '10481616@qq.com', '100003', '1', '1489291932', null, null);
INSERT INTO `organization` VALUES ('39', '3905170511', null, '3905170511', '添加机构目标表测试', '1', null, '的点点滴滴多多多', '0', '0', '0', '0', '', null, '1', 'rtg', null, '', '3905170511', '1', '1494904648', null, null);
INSERT INTO `organization` VALUES ('82', '132332', '132332', '123456789', '店铺3', '2', '2', null, '227', '261', '0', '265', '', null, '1', '18610415485', null, '10481618@qq.com', '1001', '1', '1495437334', '1494432000', '1494432000');
INSERT INTO `organization` VALUES ('84', '12335', '100004', '123456789', '店铺1', '3', '2', null, '227', '0', '0', '0', '', null, '0', '15858585989', null, '', '1004', '1', '1495438300', '-28800', '-28800');
INSERT INTO `organization` VALUES ('89', '12335', '100004', '123456789', '店铺1', '3', '2', null, '227', '0', '0', '0', '', null, '0', '15858585989', null, '', '1004', '1', '1495438626', '-28800', '-28800');
INSERT INTO `organization` VALUES ('91', '7522170516', '7518170516', '100003', '卢标经营', '3', '2', null, '227', '0', '0', '0', '', null, '1', '15858585989', null, '', '7522170516', '1', '1495438831', '-28800', '-28800');
INSERT INTO `organization` VALUES ('92', '7518170516', '7518170516', '100003', '卢旗舰经营', '2', null, null, '1', '1', '0', '1', '1', null, '1', '11', '11', '110', '7518170516', '1', '1495438626', '1495438626', '1495438626');
INSERT INTO `organization` VALUES ('93', '7520170244', '7520170244', '100003', '卢标筹备', '3', null, null, '1', '2', '0', '3', '3', '0', '0', '1', '1', '1', '7520170244', '1', '1495438626', null, null);
INSERT INTO `organization` VALUES ('94', '7525170516', '7525170516', '3905170511', '卢旗舰筹备', '2', null, null, '1', '1', '0', '1', '1', null, '0', '11', '11', '11', '7525170516', '1', '1495438626', null, null);
INSERT INTO `organization` VALUES ('95', '7527170516', '7527170516', '100003', '卢旗舰观察', '2', null, null, '1', '1', '0', '1', '1', null, '-1', '11', '1', '1', '7527170516', '1', '1495438626', '1495438626', '1495438626');

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
-- Records of organizational_goals
-- ----------------------------
INSERT INTO `organizational_goals` VALUES ('1', '名字', '10001', '25000', '100', '65140');
INSERT INTO `organizational_goals` VALUES ('2', '添加机构目标表测试', '3905170511', '5000', '888888', '10000');
INSERT INTO `organizational_goals` VALUES ('3', '河北分公司', '35', '10000', '1000', '1000');
INSERT INTO `organizational_goals` VALUES ('4', '希尔顿', '2345', '1000', '1000', '1000');
INSERT INTO `organizational_goals` VALUES ('5', '标准店', '1323321', '2000', '1000', '300');

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
-- Records of personal_coefficient
-- ----------------------------
INSERT INTO `personal_coefficient` VALUES ('0000000001', '1', '0.66', '0.66');
INSERT INTO `personal_coefficient` VALUES ('0000000002', '1', '0.86', '0.86');
INSERT INTO `personal_coefficient` VALUES ('0000000003', '111', '0.60', '0.85');
INSERT INTO `personal_coefficient` VALUES ('0000000004', '51', '0.32', '0.32');
INSERT INTO `personal_coefficient` VALUES ('0000000005', '7519170512', '0.60', '0.50');
INSERT INTO `personal_coefficient` VALUES ('0000000006', '7521170516', '0.80', '0.80');
INSERT INTO `personal_coefficient` VALUES ('0000000007', '7523170516', '0.80', '0.60');
INSERT INTO `personal_coefficient` VALUES ('0000000008', '7526170516', '0.60', '0.50');

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
  `product_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '产品分类',
  `product_state` tinyint(1) NOT NULL DEFAULT '1' COMMENT '产品类型',
  `type_id` smallint(6) DEFAULT NULL,
  `unsales_category_id` smallint(6) DEFAULT NULL COMMENT '非销售产品分类ID',
  `rate_name` varchar(255) DEFAULT NULL COMMENT '费率表名称',
  `amount_insured` smallint(6) DEFAULT '0' COMMENT '保额整倍数',
  `initial_price` decimal(9,2) DEFAULT '0.00' COMMENT '保额起步价',
  `commission_rate` decimal(3,2) DEFAULT NULL COMMENT '佣金比例(非寿)',
  `fold_factor` decimal(3,2) DEFAULT '0.00',
  `discount_coefficient` decimal(3,2) DEFAULT '0.00',
  `premium` decimal(9,2) DEFAULT '0.00',
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
-- Records of product
-- ----------------------------
INSERT INTO `product` VALUES ('27', '主编未死，只是更多变成了产品经理', '主编不会死，只是更多变成了产品经理，或者在转型成为产品经理的路上。', '<p style=\"text-align: center;\">&nbsp;<img src=\"/ueditor/php/upload/image/20170523/5923971c36c0d.jpg\" title=\"1495506542715274.jpg\" alt=\"2.jpg\" width=\"543\" height=\"316\" style=\"width: 543px; height: 316px;\"/></p><p><br/></p><p style=\"box-sizing: border-box; border: 0px; font-family: &quot;PingFang SC&quot;, &quot;Hiragino Sans GB&quot;, &quot;Microsoft YaHei&quot;, STHeiti, &quot;WenQuanYi Micro Hei&quot;, Helvetica, Arial, sans-serif; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(102, 102, 102); white-space: normal; margin-bottom: 15px; margin-top: 5px;\"><span style=\"font-family: 宋体, SimSun;\">我们身处的，几乎就是一个主编和产品经理互相成长、互相成就的互联网世界。</span></p><p style=\"box-sizing: border-box; border: 0px; font-family: &quot;PingFang SC&quot;, &quot;Hiragino Sans GB&quot;, &quot;Microsoft YaHei&quot;, STHeiti, &quot;WenQuanYi Micro Hei&quot;, Helvetica, Arial, sans-serif; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(102, 102, 102); white-space: normal; margin-bottom: 15px; margin-top: 5px;\"><span style=\"font-family: 宋体, SimSun;\">陈彤离开供职十七年的新浪，转战小米后又回归网媒行业，去了一点资讯。他的继任者、新浪的第二代总编辑周晓鹏加盟阿里文娱集团，负责盘活大鱼号的内容体系。被称为“中国引入高科技产业风险基金第一人”、IDG创始合伙人熊晓鸽和新闻报道渊源颇深。</span></p><p style=\"box-sizing: border-box; border: 0px; font-family: &quot;PingFang SC&quot;, &quot;Hiragino Sans GB&quot;, &quot;Microsoft YaHei&quot;, STHeiti, &quot;WenQuanYi Micro Hei&quot;, Helvetica, Arial, sans-serif; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(102, 102, 102); white-space: normal; margin-bottom: 15px; margin-top: 5px;\"><span style=\"font-family: 宋体, SimSun;\">知乎的周源和摩拜的胡玮炜都是记者出身，诸多传统平媒的主编们投身互联网浪潮之中创造新的连接，无数自媒体在张小龙的微信公众号上你方唱罢我登场，各式各样的技术产品也都在加码内容……</span></p><p style=\"box-sizing: border-box; border: 0px; font-family: &quot;PingFang SC&quot;, &quot;Hiragino Sans GB&quot;, &quot;Microsoft YaHei&quot;, STHeiti, &quot;WenQuanYi Micro Hei&quot;, Helvetica, Arial, sans-serif; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(102, 102, 102); white-space: normal; margin-bottom: 15px; margin-top: 5px;\"><span style=\"font-family: 宋体, SimSun;\">对主编和产品经理们来说，终其一生，无非就是要在“灵与肉”之间寻求一个平衡点。肉即肉身和人之本能，灵是指价值观、话语权和市场占有率。电影《七宗罪》里摆出了天主教教义所指的人性七宗罪：“暴食”、“贪婪”、“懒惰”、“嫉妒”、“骄傲”、“淫欲”、“愤怒”。“一款好的社交产品，一定是能迎合人性七宗罪中的其中之一。”这句话来自Linkedin的创始人，同时也是硅谷异常成功的风投家Reid Hoffman。</span></p><p style=\"box-sizing: border-box; border: 0px; font-family: &quot;PingFang SC&quot;, &quot;Hiragino Sans GB&quot;, &quot;Microsoft YaHei&quot;, STHeiti, &quot;WenQuanYi Micro Hei&quot;, Helvetica, Arial, sans-serif; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(102, 102, 102); white-space: normal; margin-bottom: 15px; margin-top: 5px;\"><span style=\"font-family: 宋体, SimSun;\">其实，何止社交产品，所有的互联网产品运营都遵循此道。</span></p><p style=\"box-sizing: border-box; border: 0px; font-family: &quot;PingFang SC&quot;, &quot;Hiragino Sans GB&quot;, &quot;Microsoft YaHei&quot;, STHeiti, &quot;WenQuanYi Micro Hei&quot;, Helvetica, Arial, sans-serif; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(102, 102, 102); white-space: normal; margin-bottom: 15px; margin-top: 5px;\"><span style=\"font-family: 宋体, SimSun;\">而现在火热的所谓消费升级，首先是情绪和欲望的升级和衍生。消费场景和消费成熟度发生巨大变化，每个个体都在寻求心理排序的相对上升，这直接促成高频词汇”消费升级”的诞生。但这总归是一个宏观概念，是一种方向和潮流。对主编和产品经理们来说，需要具体看看在此背景之中所能诞生的商业机会。</span></p><p style=\"box-sizing: border-box; border: 0px; font-family: &quot;PingFang SC&quot;, &quot;Hiragino Sans GB&quot;, &quot;Microsoft YaHei&quot;, STHeiti, &quot;WenQuanYi Micro Hei&quot;, Helvetica, Arial, sans-serif; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(102, 102, 102); white-space: normal; margin-bottom: 15px; margin-top: 5px;\"><span style=\"font-family: 宋体, SimSun;\">欧睿信息咨询此前发布的《2016年全球消费者十大趋势》报告中提出：消费者现在更愿意花钱买时间；吃得越来越健康；越来越“挑剔”，更喜欢有价值创新的高性价比产品；中性风走俏，尤其在服装和玩具行业，商品层面两性之间的区别日渐模糊；心理健康受关注，相关商品变得畅销……</span></p><p style=\"box-sizing: border-box; border: 0px; font-family: &quot;PingFang SC&quot;, &quot;Hiragino Sans GB&quot;, &quot;Microsoft YaHei&quot;, STHeiti, &quot;WenQuanYi Micro Hei&quot;, Helvetica, Arial, sans-serif; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(102, 102, 102); white-space: normal; margin-bottom: 15px; margin-top: 5px;\"><span style=\"font-family: 宋体, SimSun;\">上述这个描述已经很接地气了，但我更喜欢分众传媒创始人江南春的总结：<span style=\"box-sizing: border-box; border: 0px; font-family: inherit; font-style: inherit; font-weight: 700; margin: 0px; outline: 0px; padding: 0px; vertical-align: baseline;\">消费者怕死、怕老、爱美、缺爱</span>。其中，“爱美”系就已经诞生了很多细分机会，互联网+健身、情趣产业、护肤美妆以及美容整容，甚至还有细分到只做一条裙子的、只做一双高跟鞋的和只做内衣的。这些领域中，因为女性展现出了极强的战斗力，一系列针对她们需求的创业项目陆续推出。</span></p><p style=\"box-sizing: border-box; border: 0px; font-family: &quot;PingFang SC&quot;, &quot;Hiragino Sans GB&quot;, &quot;Microsoft YaHei&quot;, STHeiti, &quot;WenQuanYi Micro Hei&quot;, Helvetica, Arial, sans-serif; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(102, 102, 102); white-space: normal; margin-bottom: 15px; margin-top: 5px;\"><span style=\"font-family: 宋体, SimSun;\">主编和产品经理们开始在这个赛道上大展拳脚。于困困辞去《纽约时报》中文网副总编一职，创办了雅痞女青年的生活分享及购物社区“玲珑”，前《博客天下》主编重启新世相的同时打造了“女性日系潮流社区”桃花岛，前网易新闻客户端负责人龙志专为大码女性做了时尚社区“凹凸曼”。</span></p><p style=\"box-sizing: border-box; border: 0px; font-family: &quot;PingFang SC&quot;, &quot;Hiragino Sans GB&quot;, &quot;Microsoft YaHei&quot;, STHeiti, &quot;WenQuanYi Micro Hei&quot;, Helvetica, Arial, sans-serif; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(102, 102, 102); white-space: normal; margin-bottom: 15px; margin-top: 5px;\"><span style=\"font-family: 宋体, SimSun;\">另一边，在一家创业公司做产品总监的徐黛妮再度创业，做了内衣推荐平台“氧气”。打法清奇的互联网大厂网易再次以清奇的方式切入进来。丁磊麾下明星产品经理王诗沐继网易云音乐之后，打磨出新作“网易美学”，瞄准美妆这个垂直领域。</span></p><p style=\"box-sizing: border-box; border: 0px; font-family: &quot;PingFang SC&quot;, &quot;Hiragino Sans GB&quot;, &quot;Microsoft YaHei&quot;, STHeiti, &quot;WenQuanYi Micro Hei&quot;, Helvetica, Arial, sans-serif; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(102, 102, 102); white-space: normal; margin-bottom: 15px; margin-top: 5px;\"><span style=\"font-family: 宋体, SimSun;\">这些项目无一例外都是在过去两三年间伴随着“新中产崛起”而出炉。但爱美之心，自古有之。丁磊说，早在中国上古三代时期，人类就已经有化妆需求。先秦古籍《山海经》里，也提到过一百多种药物，其中就有十几种是跟美容相关。大家现在很熟悉的管状口红，也已经有一百多年的历史。</span></p><p style=\"box-sizing: border-box; border: 0px; font-family: &quot;PingFang SC&quot;, &quot;Hiragino Sans GB&quot;, &quot;Microsoft YaHei&quot;, STHeiti, &quot;WenQuanYi Micro Hei&quot;, Helvetica, Arial, sans-serif; outline: 0px; padding: 0px; vertical-align: baseline; color: rgb(102, 102, 102); white-space: normal; margin-bottom: 15px; margin-top: 5px;\"><span style=\"font-family: 宋体, SimSun;\">“用户对美的追求不仅停留在脸部，还延伸到了更广义的身体层面，追求广义的美最终都是为了让自己成为更接近自我认同的自己。”丁磊这句话解释了女性消费升级的心理动因。</span></p><p><br/></p>', '<p><strong><span style=\"font-family: &quot;PingFang SC&quot;, &quot;Hiragino Sans GB&quot;, &quot;Microsoft YaHei&quot;, STHeiti, &quot;WenQuanYi Micro Hei&quot;, Helvetica, Arial, sans-serif; color: rgb(255, 0, 0);\">王诗沐说：</span></strong></p><p style=\"line-height: 1.75em; text-align: justify;\"><em><span style=\"letter-spacing: 0.16px; background-color: rgb(250, 250, 250); color: rgb(102, 102, 102); font-family: &quot;PingFang SC&quot;, &quot;Hiragino Sans GB&quot;, &quot;Microsoft YaHei&quot;, STHeiti, &quot;WenQuanYi Micro Hei&quot;, Helvetica, Arial, sans-serif; border: 1px solid rgb(0, 0, 0); font-size: 18px;\">“UGC内容是网易美学社交之路的基础和开始，未来的社交一定是基于内容的创造，社交的媒介不仅是通讯，更是内容。而知识是能够提供价值的载体，用户对美妆信息需求极高，权威内容却很少，在这种情况下美妆知识的价值就尤为凸显。”</span></em></p>', '4', '69', '<ol class=\" list-paddingleft-2\" style=\"list-style-type: decimal;\"><li><p><strong>成年人<span style=\"color: rgb(255, 0, 0);\">(孕妇不适合)</span></strong></p></li><li><p><strong>老年人</strong></p></li><li><p><strong>儿童</strong></p></li></ol><p><br/></p>', '9.90', '/Upload/Product/20170523/5923971c36c0d.jpg', '2', '1', '48', '5', null, '200', '90000.00', '9.90', '2.30', '3.00', '60000.00', '0', '0', '0', null, '1', '0', '1495382400');
INSERT INTO `product` VALUES ('28', '平安宝贝少儿综合医疗保险', '平安宝贝少儿综合医疗保险', '<p><img src=\"/ueditor/php/upload/image/20170523/1495517233118810.png\" width=\"24\" height=\"24\" alt=\"图标\" title=\"少儿重大疾病\" style=\"border: none; vertical-align: middle;\"/>少儿重大疾病&nbsp;&nbsp;&nbsp;&nbsp;1万元&nbsp;&nbsp;&nbsp;&nbsp;在保险期间内,若被保险人自等待期30天后(续保者不受此限制)被确诊初次患有<strong><label rel=\"prompt\" class=\"trial-prompt primary-link\" data-prompt-width=\"\" data-prompt-html=\" &lt;div class=&#39;prompt-content&#39;&gt;恶性肿瘤、重大器官移植术或造血干细胞移植术、急性或亚急性重症肝炎、良性脑肿瘤、脑炎后遗症或脑膜炎后遗症、深度昏迷、双耳失聪、双目失明、瘫痪、严重脑损伤、严重Ⅲ度烧伤、急性肾功能衰竭尿毒症期、重症心肌炎伴充血性心力衰竭、严重急性再生障碍性贫血、脊髓灰质炎(瘫痪型)&lt;/div&gt;\" data-prompt-position=\"top\" for=\"\" content=\"恶性肿瘤、重大器官移植术或造血干细胞移植术、急性或亚急性重症肝炎、良性脑肿瘤、脑炎后遗症或脑膜炎后遗症、深度昏迷、双耳失聪、双目失明、瘫痪、严重脑损伤、严重Ⅲ度烧伤、急性肾功能衰竭尿毒症期、重症心肌炎伴充血性心力衰竭、严重急性再生障碍性贫血、脊髓灰质炎(瘫痪型)\" style=\"cursor: pointer; color: rgb(33, 80, 162);\">重大疾病[注]</label></strong>的,保险公司将按保单载明的保额给付保险金,保险责任终止。(等待期30天)</p>', '<p><img src=\"/ueditor/php/upload/image/20170523/1495506510280179.jpg\" alt=\"1495506510280179.jpg\" width=\"430\" height=\"377\" style=\"width: 430px; height: 377px;\"/></p>', '2', '69', '<ol class=\" list-paddingleft-2\" style=\"list-style-type: decimal;\"><li><p>老年人</p></li><li><p>儿童</p></li><li><p>年轻人</p></li></ol>', '9.90', '/Upload/Product/20170523/5923c9278a50e.jpg', '2', '1', '49', '6', null, '200', '90000.00', '9.60', '2.30', '3.00', '60000.00', '0', '0', '0', null, '1', '0', '1495613732');
INSERT INTO `product` VALUES ('29', '1如E家庭财产保险计划为您的房屋主体及室内财产损失提供全方位保障。', '如E家庭财产保险计划', '<p style=\"text-align: center;\"><span style=\"color: rgb(255, 255, 255); font-family: Arial, Helvetica, sans-serif; font-size: 12px; background-color: rgb(0, 160, 102);\">本产品为“如E家庭财产保险计划”，产品报备文件编号为“(国寿产险)(备案)[2009]N25号、(国寿产险)(备案)[2009]N27号”，由“中国人寿财产保险股份有限公司”承保，“中国人寿财产保险股份有限公司”经营区域为全国。产品条款包括家庭财产保险条款、附加盗抢保险条款、附加家用电器用电安全保险条款、附加管道破裂及水渍保险条款、附加第三者责任保险条款、附加费用扩展条款、附加现金、首饰盗抢保险条款等。<span style=\"color: rgb(255, 255, 255); font-family: Arial, Helvetica, sans-serif; font-size: 12px; background-color: rgb(0, 160, 102);\">本产品为“如E家庭财产保险计划”，产品报备文件编号为“(国寿产险)(备案)[2009]N25号、(国寿产险)(备案)[2009]N27号”，由“中国人寿财产保险股份有限公司”承保，“中国人寿财产保险股份有限公司”经营区域为全国。产品条款包括家庭财产保险条款、附加盗抢保险条款、附加家用电器用电安全保险条款、附加管道破裂及水渍保险条款、附加第三者责任保险条款、附加费用扩展条款、附加现金、首饰盗抢保险<span style=\"color: rgb(255, 255, 255); font-family: Arial, Helvetica, sans-serif; font-size: 12px; background-color: rgb(0, 160, 102); border: 1px solid rgb(0, 0, 0);\"></span>条款等。</span>收到罚单阿斯顿发送到少点阿斯顿发</span></p>', '<p><strong><span style=\"color: rgb(255, 255, 255); font-family: Arial, Helvetica, sans-serif; font-size: 12px; background-color: rgb(0, 160, 102);\">本产品为“如E家庭财产保险计划”，产品报备文件编号为“(国寿产险)(备案)[2009]N25号、(国寿产险)(备案)[2009]N27号”，由“中国人寿财产保险股份有限公司”承保，“中国人寿财产保险股份有限公司”经营区域为全国。产品条款包括家庭财产保险条款、附加盗抢保险条款、附加家用电器用电安全保险条款、附加管道破裂及水渍保险条款、附加第三者责任保险条款、附加费用扩展条款、附加现金、首饰盗抢保险条款等。</span>阿斯顿发阿斯顿发按时阿斯顿发啊fgaa</strong></p>', '1', '20', '<p>asdf<span style=\"color: rgb(255, 255, 255); font-family: Arial, Helvetica, sans-serif; font-size: 12px; background-color: rgb(0, 160, 102);\">本产品为“如E家庭财产保险计划”，产品报备文件编号为“(国寿产险)(备案)[2009]N25号、(国寿产险)(备案)[2009]N27号”，由“中国人寿财产保险股份有限公司”承保，“中国人寿财产保险股份有限公司”经营区域为全国。产品条款包括家庭财产保险条款、附加盗抢保险条款、附加家用电器用电安全保险条款、附加管道破裂及水渍保险条款、附加第三者责任保险条款、附加费用扩展条款、附加现金、首饰盗抢保险条款等。</span></p>', '3.00', '', '2', '1', '48', '5', null, '3', '3.00', '3.00', '3.00', '3.00', '1000000.00', '0', '0', '0', null, '1', null, '1495782905');
INSERT INTO `product` VALUES ('30', '请问', '请问', '<p><span style=\"color: rgb(145, 145, 145); font-family: Arial; font-size: 12px; background-color: rgb(255, 255, 255);\">如E公民出境保险计划适合因旅游、留学、探亲访友、外交、访问、考察、短期培训而出境的人员，提供最高30万的意外伤害保障。</span></p>', '<p><span style=\"color: rgb(145, 145, 145); font-family: Arial; font-size: 12px; background-color: rgb(255, 255, 255);\">如E公民出境保险计划适合因旅游、留学、探亲访友、外交、访问、考察、短期培训而出境的人员，提供最高30万的意外伤害保障。</span></p>', '1', '20', '<p><span style=\"color: rgb(145, 145, 145); font-family: Arial; font-size: 12px; background-color: rgb(255, 255, 255);\">如E公民出境保险计划适合因旅游、留学、探亲访友、外交、访问、考察、短期培训而出境的人员，提供最高30万的意外伤害保障。</span></p>', '1.00', '', '2', '1', '48', '5', null, '1', '1.00', '1.00', '1.00', '1.00', '1.00', '0', '-1', '0', null, '1', null, '1495852585');
INSERT INTO `product` VALUES ('31', '请问', '请问', '<p><span style=\"color: rgb(145, 145, 145); font-family: Arial; font-size: 12px; background-color: rgb(255, 255, 255);\">如E公民出境保险计划适合因旅游、留学、探亲访友、外交、访问、考察、短期培训而出境的人员，提供最高30万的意外伤害保障。</span></p>', '<p><span style=\"color: rgb(145, 145, 145); font-family: Arial; font-size: 12px; background-color: rgb(255, 255, 255);\">如E公民出境保险计划适合因旅游、留学、探亲访友、外交、访问、考察、短期培训而出境的人员，提供最高30万的意外伤害保障。</span></p>', '1', '20', '<p><span style=\"color: rgb(145, 145, 145); font-family: Arial; font-size: 12px; background-color: rgb(255, 255, 255);\">如E公民出境保险计划适合因旅游、留学、探亲访友、外交、访问、考察、短期培训而出境的人员，提供最高30万的意外伤害保障。</span></p>', '1.00', '', '1', '1', '48', '5', null, '1', '1.00', '1.00', '1.00', '1.00', '1.00', '0', '0', '0', null, '1', null, '1495857428');
INSERT INTO `product` VALUES ('32', '如E公民如E公民出境保险计划适合因旅游、留学、探亲访友、外交、访问、考察、短期培训而出境的人员，提供最高30万的意外伤害保障。出境保险计划适合因旅游、留学、探亲访友、外交、访问、考察、短期培训而出境的人员，提供最高30万的意外伤害保障。', 'v', '<p><span style=\"color: rgb(145, 145, 145); font-family: Arial; font-size: 12px; background-color: rgb(255, 255, 255);\">如E公民出境保险计划适合因旅游、留学、探亲访友、外交、访问、考察、短期培训而出境的人员，提供最高30万的意外伤害保障。</span></p>', '<p><span style=\"color: rgb(145, 145, 145); font-family: Arial; font-size: 12px; background-color: rgb(255, 255, 255);\">如E公民出境保险计划适合因旅游、留学、探亲访友、外交、访问、考察、短期培训而出境的人员，提供最高30万的意外伤害保障。</span></p>', '1', '20', '<p><span style=\"color: rgb(145, 145, 145); font-family: Arial; font-size: 12px; background-color: rgb(255, 255, 255);\">如E公民出境保险计划适合因旅游、留学、探亲访友、外交、访问、考察、短期培训而出境的人员，提供最高30万的意外伤害保障。</span></p>', '1.00', '', '2', '1', '48', '5', null, '1', '1.00', '1.00', '1.00', '1.00', '1.00', '0', '-1', '0', null, '1', null, '1495852757');
INSERT INTO `product` VALUES ('33', '如E公民如E公民出境保险计划适合因旅游、留学、探亲访友、外交、访问、考察、短期培训而出境的人员，提供最高30万的意外伤害保障。出境保险计划适合因旅游、留学、探亲访友、外交、访问、考察、短期培训而出境的人员，提供最高30万的意外伤害保障。', 'v', '<p><span style=\"color: rgb(145, 145, 145); font-family: Arial; font-size: 12px; background-color: rgb(255, 255, 255);\">如E公民出境保险计划适合因旅游、留学、探亲访友、外交、访问、考察、短期培训而出境的人员，提供最高30万的意外伤害保障。</span></p>', '<p><span style=\"color: rgb(145, 145, 145); font-family: Arial; font-size: 12px; background-color: rgb(255, 255, 255);\">如E公民出境保险计划适合因旅游、留学、探亲访友、外交、访问、考察、短期培训而出境的人员，提供最高30万的意外伤害保障。</span></p>', '1', '20', '<p><span style=\"color: rgb(145, 145, 145); font-family: Arial; font-size: 12px; background-color: rgb(255, 255, 255);\">如E公民出境保险计划适合因旅游、留学、探亲访友、外交、访问、考察、短期培训而出境的人员，提供最高30万的意外伤害保障。</span></p>', '1.00', '', '2', '1', '48', '5', null, '1', '1.00', '1.00', '1.00', '1.00', '1.00', '0', '-1', '0', null, '1', null, '1495852758');
INSERT INTO `product` VALUES ('34', 'PHP是世界上最好的语言', '1PHP是世界上最好的语言', '<p>PHP是世界上最好的语言</p>', '<p>PHP是世界上最好的语言</p>', '1', '24', '<p>PHP是世界上最好的语言</p>', '1.00', '', '2', '1', '48', '5', null, '1', '99999.00', '1.00', '1.00', '1.00', '1.00', '0', '0', '0', null, '1', null, '1495856177');
INSERT INTO `product` VALUES ('35', '123人', '123 ', '<p>1</p>', '<p>1</p>', '1', '20', '<p>1</p>', '1.00', '', '2', '1', null, null, null, '1', '1.00', '1.00', '1.00', '1.00', '1.00', '0', '-1', '0', null, '1', null, '1495856545');
INSERT INTO `product` VALUES ('36', '123人', '123 ', '<p>1</p>', '<p>1</p>', '1', '20', '<p>1</p>', '1.00', '', '2', '1', null, null, null, '1', '1.00', '1.00', '1.00', '1.00', '1.00', '0', '-1', '0', null, '1', null, '1495856712');
INSERT INTO `product` VALUES ('37', '123人', '123 ', '<p>1</p>', '<p>1</p>', '1', '20', '<p>1</p>', '1.00', '', '2', '1', null, null, null, '1', '1.00', '1.00', '1.00', '1.00', '1.00', '0', '-1', '0', null, '1', null, '1495856713');
INSERT INTO `product` VALUES ('38', '123人', '123 ', '<p>1</p>', '<p>1</p>', '1', '20', '<p>1</p>', '1.00', '', '2', '1', null, null, null, '1', '1.00', '1.00', '1.00', '1.00', '1.00', '0', '-1', '0', null, '1', null, '1495856733');
INSERT INTO `product` VALUES ('39', '1', '1PHP是世界上最好的语言', '<p>PHP是</p><p><br/></p>', '<p style=\"white-space: normal;\">PHP是</p><p><br/></p>', '1', '20', '<p style=\"white-space: normal;\">PHP是</p><p><br/></p>', '1.00', '', '2', '1', '48', '5', null, '1', '1.00', '1.00', '1.00', '1.00', '1.00', '0', '-1', '0', null, '1', null, '1495857304');
INSERT INTO `product` VALUES ('40', '去玩儿', '去玩儿', '<p>佣金比例(非寿)</p>', '<p>佣金比例(非寿)</p>', '1', '20', '<p>佣金比例(非寿)</p>', null, '', '1', '1', '48', '5', null, '1', '1.00', null, '1.00', '1.00', '1.00', '0', '0', '0', null, '1', null, '1495863963');
INSERT INTO `product` VALUES ('41', '商业机动车辆保险', '商业机动车辆保险', '<p class=\"ttit\" style=\"margin: 0px auto; padding: 5px; border-width: 2px; border-style: solid; border-color: rgb(255, 255, 255); background: rgb(0, 160, 102); color: rgb(255, 255, 255); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal;\">本产品为“商业机动车辆保险”，产品报备文件编号为“H2015102”，由“中国人寿财产保险股份有限公司”承保，“中国人寿财产保险股份有限公司”经营区域为全国，产品条款包括：机动车第三者责任保险条款、机动车损失保险条款、机动车车上人员责任保险条款、机动车盗抢保险条款、玻璃单独破碎险条款、车身划痕损失险条款、可选免赔额特约条款、不计免赔率特约条款、自燃损失险条款、新增加设备损失保险条款、发动机特别损失险条款、机动车停驶损失险条款、附加换件特约条款、随车行李物品损失保险条款、附加交通事故精神损害赔偿责任保险条款、异地出险住宿费特约条款、法律费用特约条款、多次事故免赔率特约条款、节假日行驶区域扩展特约条款等。</p><p style=\"margin: 0px auto; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">保险期间内，被保险人或其允许的合法驾驶人在使用被保险机动车过程中，因下列原因造成被保险机动车的损失，保险人依照本保险合同的约定负责赔偿：</p><p style=\"margin: 0px auto; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">（一） 碰撞、倾覆、坠落；</p><p style=\"margin: 0px auto; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">（二） 火灾、爆炸；</p><p style=\"margin: 0px auto; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">（三） 外界物体坠落、倒塌；</p><p style=\"margin: 0px auto; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">（四） 暴风、龙卷风；</p><p style=\"margin: 0px auto; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">（五） 雷击、雹灾、暴雨、洪水、海啸；</p><p style=\"margin: 0px auto; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">（六） 地陷、冰陷、崖崩、雪崩、泥石流、滑坡；</p><p style=\"margin: 0px auto; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">（七） 载运被保险机动车的渡船遭受自然灾害（只限于驾驶人随船的情形）。</p><p style=\"margin: 0px auto; padding: 0px; font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(250, 135, 0);\">*以上描述为简要介绍，最终均以条款为准！</p><table width=\"660\"><tbody style=\"margin: 0px auto; padding: 0px;\"><tr style=\"margin: 0px auto; padding: 0px;\" class=\"firstRow\"><td class=\"ttit\" style=\"margin: 0px auto; padding-right: 5px; padding-left: 5px; border-width: 2px; border-color: rgb(255, 255, 255); background: rgb(0, 160, 102); color: rgb(255, 255, 255);\" height=\"30\"><strong style=\"margin: 0px auto; padding: 0px;\">投诉渠道</strong></td></tr><tr style=\"margin: 0px auto; padding: 0px;\"><td class=\"ttit1\" style=\"margin: 0px auto; padding-right: 5px; padding-left: 5px; border-width: 2px; border-color: rgb(255, 255, 255);\" height=\"30\">如果您在购买产品的过程中，如发现本公司人员有违法违规行为，或认为自身权益受到侵犯，请您保留相关证据并向本公司投诉，投诉电话：95519</td></tr><tr style=\"margin: 0px auto; padding: 0px;\"><td class=\"ttit\" style=\"margin: 0px auto; padding-right: 5px; padding-left: 5px; border-width: 2px; border-color: rgb(255, 255, 255); background: rgb(0, 160, 102); color: rgb(255, 255, 255);\" height=\"30\"><strong style=\"margin: 0px auto; padding: 0px;\">如实告知义务</strong></td></tr><tr style=\"margin: 0px auto; padding: 0px;\"><td class=\"ttit1\" style=\"margin: 0px auto; padding-right: 5px; padding-left: 5px; border-width: 2px; border-color: rgb(255, 255, 255);\" height=\"30\">我们就您和被保人的有关情况提出询问，您应当如实告知。如果您因故意或者重大过失未履行规定的如实告知义务，足以影响我们决定是否同意承保或者提高保险费率，我们有权解除合同。</td></tr><tr style=\"margin: 0px auto; padding: 0px;\"><td class=\"ttit\" style=\"margin: 0px auto; padding-right: 5px; padding-left: 5px; border-width: 2px; border-color: rgb(255, 255, 255); background: rgb(0, 160, 102); color: rgb(255, 255, 255);\" height=\"30\"><strong style=\"margin: 0px auto; padding: 0px;\">信息安全承诺</strong></td></tr><tr style=\"margin: 0px auto; padding: 0px;\"><td class=\"ttit1\" style=\"margin: 0px auto; padding-right: 5px; padding-left: 5px; border-width: 2px; border-color: rgb(255, 255, 255);\" height=\"30\">我们严格遵守现行的关于个人信息、数据及隐私保护法律法规，采取充分的技术手段和制度管理，保护您提供给我们的个人信息、信息和隐私不受到非法的泄露或披露给未获授权的第三方。请您放心。</td></tr><tr style=\"margin: 0px auto; padding: 0px;\"><td class=\"ttit\" style=\"margin: 0px auto; padding-right: 5px; padding-left: 5px; border-width: 2px; border-color: rgb(255, 255, 255); background: rgb(0, 160, 102); color: rgb(255, 255, 255);\" height=\"30\"><strong style=\"margin: 0px auto; padding: 0px;\">保单形式</strong></td></tr><tr style=\"margin: 0px auto; padding: 0px;\"><td class=\"ttit1\" style=\"margin: 0px auto; padding-right: 5px; padding-left: 5px; border-width: 2px; border-color: rgb(255, 255, 255);\" height=\"30\">本合同采用电子保险单的形式承保，您可以通过95519查询保单。如您需要发票，请拨打客服热线：95519。<br/><br/></td></tr></tbody></table><p><br/></p>', '<p class=\"ttit\" style=\"margin: 0px auto; padding: 5px; border-width: 2px; border-style: solid; border-color: rgb(255, 255, 255); background: rgb(0, 160, 102); color: rgb(255, 255, 255); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal;\">本产品为“商业机动车辆保险”，产品报备文件编号为“H2015102”，由“中国人寿财产保险股份有限公司”承保，“中国人寿财产保险股份有限公司”经营区域为全国，产品条款包括：机动车第三者责任保险条款、机动车损失保险条款、机动车车上人员责任保险条款、机动车盗抢保险条款、玻璃单独破碎险条款、车身划痕损失险条款、可选免赔额特约条款、不计免赔率特约条款、自燃损失险条款、新增加设备损失保险条款、发动机特别损失险条款、机动车停驶损失险条款、附加换件特约条款、随车行李物品损失保险条款、附加交通事故精神损害赔偿责任保险条款、异地出险住宿费特约条款、法律费用特约条款、多次事故免赔率特约条款、节假日行驶区域扩展特约条款等。</p><p style=\"margin: 0px auto; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">保险期间内，被保险人或其允许的合法驾驶人在使用被保险机动车过程中，因下列原因造成被保险机动车的损失，保险人依照本保险合同的约定负责赔偿：</p><p style=\"margin: 0px auto; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">（一） 碰撞、倾覆、坠落；</p><p style=\"margin: 0px auto; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">（二） 火灾、爆炸；</p><p style=\"margin: 0px auto; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">（三） 外界物体坠落、倒塌；</p><p style=\"margin: 0px auto; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">（四） 暴风、龙卷风；</p><p style=\"margin: 0px auto; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">（五） 雷击、雹灾、暴雨、洪水、海啸；</p><p style=\"margin: 0px auto; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">（六） 地陷、冰陷、崖崩、雪崩、泥石流、滑坡；</p><p style=\"margin: 0px auto; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">（七） 载运被保险机动车的渡船遭受自然灾害（只限于驾驶人随船的情形）。</p><p style=\"margin: 0px auto; padding: 0px; font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(250, 135, 0);\">*以上描述为简要介绍，最终均以条款为准！</p><table width=\"660\"><tbody style=\"margin: 0px auto; padding: 0px;\"><tr style=\"margin: 0px auto; padding: 0px;\" class=\"firstRow\"><td class=\"ttit\" style=\"margin: 0px auto; padding-right: 5px; padding-left: 5px; border-width: 2px; border-color: rgb(255, 255, 255); background: rgb(0, 160, 102); color: rgb(255, 255, 255);\" height=\"30\"><strong style=\"margin: 0px auto; padding: 0px;\">投诉渠道</strong></td></tr><tr style=\"margin: 0px auto; padding: 0px;\"><td class=\"ttit1\" style=\"margin: 0px auto; padding-right: 5px; padding-left: 5px; border-width: 2px; border-color: rgb(255, 255, 255);\" height=\"30\">如果您在购买产品的过程中，如发现本公司人员有违法违规行为，或认为自身权益受到侵犯，请您保留相关证据并向本公司投诉，投诉电话：95519</td></tr><tr style=\"margin: 0px auto; padding: 0px;\"><td class=\"ttit\" style=\"margin: 0px auto; padding-right: 5px; padding-left: 5px; border-width: 2px; border-color: rgb(255, 255, 255); background: rgb(0, 160, 102); color: rgb(255, 255, 255);\" height=\"30\"><strong style=\"margin: 0px auto; padding: 0px;\">如实告知义务</strong></td></tr><tr style=\"margin: 0px auto; padding: 0px;\"><td class=\"ttit1\" style=\"margin: 0px auto; padding-right: 5px; padding-left: 5px; border-width: 2px; border-color: rgb(255, 255, 255);\" height=\"30\">我们就您和被保人的有关情况提出询问，您应当如实告知。如果您因故意或者重大过失未履行规定的如实告知义务，足以影响我们决定是否同意承保或者提高保险费率，我们有权解除合同。</td></tr><tr style=\"margin: 0px auto; padding: 0px;\"><td class=\"ttit\" style=\"margin: 0px auto; padding-right: 5px; padding-left: 5px; border-width: 2px; border-color: rgb(255, 255, 255); background: rgb(0, 160, 102); color: rgb(255, 255, 255);\" height=\"30\"><strong style=\"margin: 0px auto; padding: 0px;\">信息安全承诺</strong></td></tr><tr style=\"margin: 0px auto; padding: 0px;\"><td class=\"ttit1\" style=\"margin: 0px auto; padding-right: 5px; padding-left: 5px; border-width: 2px; border-color: rgb(255, 255, 255);\" height=\"30\">我们严格遵守现行的关于个人信息、数据及隐私保护法律法规，采取充分的技术手段和制度管理，保护您提供给我们的个人信息、信息和隐私不受到非法的泄露或披露给未获授权的第三方。请您放心。</td></tr><tr style=\"margin: 0px auto; padding: 0px;\"><td class=\"ttit\" style=\"margin: 0px auto; padding-right: 5px; padding-left: 5px; border-width: 2px; border-color: rgb(255, 255, 255); background: rgb(0, 160, 102); color: rgb(255, 255, 255);\" height=\"30\"><strong style=\"margin: 0px auto; padding: 0px;\">保单形式</strong></td></tr><tr style=\"margin: 0px auto; padding: 0px;\"><td class=\"ttit1\" style=\"margin: 0px auto; padding-right: 5px; padding-left: 5px; border-width: 2px; border-color: rgb(255, 255, 255);\" height=\"30\">本合同采用电子保险单的形式承保，您可以通过95519查询保单。如您需要发票，请拨打客服热线：95519。<br/><br/></td></tr></tbody></table><p><br/></p>', '2', '20', '<p class=\"ttit\" style=\"margin: 0px auto; padding: 5px; border-width: 2px; border-style: solid; border-color: rgb(255, 255, 255); background: rgb(0, 160, 102); color: rgb(255, 255, 255); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal;\">本产品为“商业机动车辆保险”，产品报备文件编号为“H2015102”，由“中国人寿财产保险股份有限公司”承保，“中国人寿财产保险股份有限公司”经营区域为全国，产品条款包括：机动车第三者责任保险条款、机动车损失保险条款、机动车车上人员责任保险条款、机动车盗抢保险条款、玻璃单独破碎险条款、车身划痕损失险条款、可选免赔额特约条款、不计免赔率特约条款、自燃损失险条款、新增加设备损失保险条款、发动机特别损失险条款、机动车停驶损失险条款、附加换件特约条款、随车行李物品损失保险条款、附加交通事故精神损害赔偿责任保险条款、异地出险住宿费特约条款、法律费用特约条款、多次事故免赔率特约条款、节假日行驶区域扩展特约条款等。</p><p style=\"margin: 0px auto; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">保险期间内，被保险人或其允许的合法驾驶人在使用被保险机动车过程中，因下列原因造成被保险机动车的损失，保险人依照本保险合同的约定负责赔偿：</p><p style=\"margin: 0px auto; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">（一） 碰撞、倾覆、坠落；</p><p style=\"margin: 0px auto; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">（二） 火灾、爆炸；</p><p style=\"margin: 0px auto; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">（三） 外界物体坠落、倒塌；</p><p style=\"margin: 0px auto; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">（四） 暴风、龙卷风；</p><p style=\"margin: 0px auto; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">（五） 雷击、雹灾、暴雨、洪水、海啸；</p><p style=\"margin: 0px auto; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">（六） 地陷、冰陷、崖崩、雪崩、泥石流、滑坡；</p><p style=\"margin: 0px auto; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">（七） 载运被保险机动车的渡船遭受自然灾害（只限于驾驶人随船的情形）。</p><p style=\"margin: 0px auto; padding: 0px; font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(250, 135, 0);\">*以上描述为简要介绍，最终均以条款为准！</p><table width=\"660\"><tbody style=\"margin: 0px auto; padding: 0px;\"><tr style=\"margin: 0px auto; padding: 0px;\" class=\"firstRow\"><td class=\"ttit\" style=\"margin: 0px auto; padding-right: 5px; padding-left: 5px; border-width: 2px; border-color: rgb(255, 255, 255); background: rgb(0, 160, 102); color: rgb(255, 255, 255);\" height=\"30\"><strong style=\"margin: 0px auto; padding: 0px;\">投诉渠道</strong></td></tr><tr style=\"margin: 0px auto; padding: 0px;\"><td class=\"ttit1\" style=\"margin: 0px auto; padding-right: 5px; padding-left: 5px; border-width: 2px; border-color: rgb(255, 255, 255);\" height=\"30\">如果您在购买产品的过程中，如发现本公司人员有违法违规行为，或认为自身权益受到侵犯，请您保留相关证据并向本公司投诉，投诉电话：95519</td></tr><tr style=\"margin: 0px auto; padding: 0px;\"><td class=\"ttit\" style=\"margin: 0px auto; padding-right: 5px; padding-left: 5px; border-width: 2px; border-color: rgb(255, 255, 255); background: rgb(0, 160, 102); color: rgb(255, 255, 255);\" height=\"30\"><strong style=\"margin: 0px auto; padding: 0px;\">如实告知义务</strong></td></tr><tr style=\"margin: 0px auto; padding: 0px;\"><td class=\"ttit1\" style=\"margin: 0px auto; padding-right: 5px; padding-left: 5px; border-width: 2px; border-color: rgb(255, 255, 255);\" height=\"30\">我们就您和被保人的有关情况提出询问，您应当如实告知。如果您因故意或者重大过失未履行规定的如实告知义务，足以影响我们决定是否同意承保或者提高保险费率，我们有权解除合同。</td></tr><tr style=\"margin: 0px auto; padding: 0px;\"><td class=\"ttit\" style=\"margin: 0px auto; padding-right: 5px; padding-left: 5px; border-width: 2px; border-color: rgb(255, 255, 255); background: rgb(0, 160, 102); color: rgb(255, 255, 255);\" height=\"30\"><strong style=\"margin: 0px auto; padding: 0px;\">信息安全承诺</strong></td></tr><tr style=\"margin: 0px auto; padding: 0px;\"><td class=\"ttit1\" style=\"margin: 0px auto; padding-right: 5px; padding-left: 5px; border-width: 2px; border-color: rgb(255, 255, 255);\" height=\"30\">我们严格遵守现行的关于个人信息、数据及隐私保护法律法规，采取充分的技术手段和制度管理，保护您提供给我们的个人信息、信息和隐私不受到非法的泄露或披露给未获授权的第三方。请您放心。</td></tr><tr style=\"margin: 0px auto; padding: 0px;\"><td class=\"ttit\" style=\"margin: 0px auto; padding-right: 5px; padding-left: 5px; border-width: 2px; border-color: rgb(255, 255, 255); background: rgb(0, 160, 102); color: rgb(255, 255, 255);\" height=\"30\"><strong style=\"margin: 0px auto; padding: 0px;\">保单形式</strong></td></tr><tr style=\"margin: 0px auto; padding: 0px;\"><td class=\"ttit1\" style=\"margin: 0px auto; padding-right: 5px; padding-left: 5px; border-width: 2px; border-color: rgb(255, 255, 255);\" height=\"30\">本合同采用电子保险单的形式承保，您可以通过95519查询保单。如您需要发票，请拨打客服热线：95519。<br/><br/></td></tr></tbody></table><p><br/></p>', null, '/Upload/Product/20170527/5929169c9d5d2.jpg', '1', '2', '48', '7', null, '1', '2.22', null, '3.33', '4.44', '4.00', '0', '0', '0', null, '1', null, '1495864989');
INSERT INTO `product` VALUES ('42', '表设计有误差', '表设计有误差', '<p>大声道阿萨德发送到按时</p>', '<p>阿萨德发送到</p>', '1', '20', '<p>阿萨德阿萨德</p>', null, '', '1', '1', '48', '5', null, '1', '1.00', null, '1.00', '1.00', '1.00', '0', '-1', '0', null, '1', null, '1495867743');
INSERT INTO `product` VALUES ('43', '111', '1111', '<p>士大夫<br/></p>', '<p>水电费</p>', '1', '20', '<p>阿斯顿发</p>', null, '', '1', '1', '48', '6', null, '1', '1.00', null, '1.00', '1.00', '1.00', '0', '0', '0', null, '1', null, '1496201466');
INSERT INTO `product` VALUES ('44', '11', '111', '<p>1</p>', '<p>1</p>', '1', '20', '<p>1</p>', null, '', '1', '1', '48', '5', null, '1', '1.00', null, '1.00', '1.00', '1.00', '0', '0', '0', null, '1', null, '1496201597');
INSERT INTO `product` VALUES ('45', '1阿发', '缺乏', '<p>1</p>', '<p>1</p>', '1', '20', '<p>11</p>', '1.00', '', '2', '1', '48', '5', null, '1', '1.00', '1.00', '1.00', '1.00', '1.00', '0', '0', '0', null, '1', null, '1496201695');
INSERT INTO `product` VALUES ('46', '2', '2', '<p>2</p>', null, '1', '20', null, null, '', '1', '1', '48', '5', null, '2', '2.00', null, '2.00', '2.00', '2.00', '0', '0', '0', null, '1', null, '1496202015');
INSERT INTO `product` VALUES ('47', '2', '2', '<p>2</p>', null, '1', '20', null, null, '/Upload/Product/20170531/592e3f254e349.jpg', '1', '1', '48', '5', null, '2', '2.00', null, '2.00', '2.00', '2.00', '0', '0', '0', null, '1', null, '1496205346');
INSERT INTO `product` VALUES ('48', '1', '1PHP是世界上最好的语言', '<p>1111111111</p>', '<p>1111111111</p>', '1', '20', '<p>111111111111111111</p>', null, '', '1', '1', '48', '5', null, '1', '1.00', null, '1.00', '1.00', '1.00', '0', '0', '0', null, '1', null, '1496208988');
INSERT INTO `product` VALUES ('49', '如E公民出境保险计划适合因旅游、留学、探亲访友、外交、访问、考察、短期培训而出境的人员，提供最高30万的意外伤害保障。', '如E公民出境保险计划适合因旅游、留学、探亲访友、外交、访问、考察、短期培训而出境的人员，提供最高30万的意外伤害保障。', '<p>11111</p>', '<p>111111111</p>', '1', '20', '<p>11111111</p>', null, '', '1', '1', '48', '5', null, '1', '1.00', null, '1.00', '1.00', '1.00', '0', '0', '0', null, '1', null, '1496209053');
INSERT INTO `product` VALUES ('50', '如E公民出境保险计划适合因旅游、留学、探亲访友、外交、访问、考察、短期培训而出境的人员，提供最高30万的意外伤害保障。', '1PHP是世界上最好的语言', '<p>1</p>', '<p>1</p>', '1', '20', '<p>1</p>', null, '', '1', '1', '48', '5', null, '1', '1.00', null, '1.00', '1.00', '1.00', '0', '0', '0', null, '1', null, '1496209204');
INSERT INTO `product` VALUES ('51', '如E公民出境保险计划适合因旅游、留学、探亲访友、外交、访问、考察、短期培训而出境的人员，提供最高30万的意外伤害保障。', '如E公民出境保险计划适合因旅游、留学、探亲访友、外交、访问、考察、短期培训而出境的人员，提供最高30万的意外伤害保障。', null, null, '1', '20', null, null, '', '1', '1', '48', '5', null, '1', '1.00', null, '1.00', '1.00', '1.00', '0', '0', '0', null, '1', null, '1496209461');
INSERT INTO `product` VALUES ('52', '如E公民出境保险计划适合因旅游、留学、探亲访友、外交、访问、考察、短期培训而出境的人员，提供最高30万的意外伤害保障。', '如E公民出境保险计划适合因旅游、留学、探亲访友、外交、访问、考察、短期培训而出境的人员，提供最高30万的意外伤害保障。', '<p>1</p>', '<p>1</p>', '1', '20', '<p>1</p>', null, '', '1', '1', '48', '5', null, '1', '1.00', null, '1.00', '1.00', '1.00', '0', '0', '0', null, '1', null, '1496209632');
INSERT INTO `product` VALUES ('53', '去玩儿', '去玩儿', '<p>11111111</p>', '<p>111111</p>', '1', '20', '<p>111111</p>', null, '', '1', '1', '48', '5', null, '1', '1.00', null, '1.00', '1.00', '1.00', '0', '0', '0', null, '1', null, '1496210627');
INSERT INTO `product` VALUES ('54', '如E公民出境保险计划适合因旅游、留学、探亲访友、外交、访问、考察、短期培训而出境的人员，提供最高30万的意外伤害保障。', '如E公民出境保险计划适合因旅游、留学、探亲访友、外交、访问、考察、短期培训而出境的人员，提供最高30万的意外伤害保障。', null, null, '1', '20', null, null, '', '1', '1', '48', '5', null, '1', '1.00', null, '1.00', '1.00', '1.00', '0', '0', '0', null, '1', null, '1496210780');

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
-- Records of product_proposal
-- ----------------------------

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
-- Records of product_rate
-- ----------------------------
INSERT INTO `product_rate` VALUES ('1', '21', '11', '1', '10', '2', '0');
INSERT INTO `product_rate` VALUES ('4', '21', '1', '1', '10', '2', '0');
INSERT INTO `product_rate` VALUES ('5', '21', '22', '2', '11', '3', '0');

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
-- Records of product_reviews
-- ----------------------------

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
-- Records of product_rules
-- ----------------------------
INSERT INTO `product_rules` VALUES ('2', '27', '<p><em><span style=\"color: rgb(85, 85, 85); font-family: &quot;Microsoft Yahei&quot;, &quot;Hiragino Sans GB&quot;, &quot;Helvetica Neue&quot;, Helvetica, tahoma, arial, &quot;WenQuanYi Micro Hei&quot;, Verdana, sans-serif, 宋体; font-size: 14px; background-color: rgb(255, 255, 255);\">投保提示</span></em></p>', '<p><span style=\"color: rgb(85, 85, 85); font-family: &quot;Microsoft Yahei&quot;, &quot;Hiragino Sans GB&quot;, &quot;Helvetica Neue&quot;, Helvetica, tahoma, arial, &quot;WenQuanYi Micro Hei&quot;, Verdana, sans-serif, 宋体; font-size: 14px; background-color: rgb(255, 255, 255); text-decoration: underline;\">理赔提示</span></p>', '<p><span style=\"border: 1px solid rgb(0, 0, 0);\"><span style=\"color: rgb(85, 85, 85); font-family: &quot;Microsoft Yahei&quot;, &quot;Hiragino Sans GB&quot;, &quot;Helvetica Neue&quot;, Helvetica, tahoma, arial, &quot;WenQuanYi Micro Hei&quot;, Verdana, sans-serif, 宋体; font-size: 14px; background-color: rgb(255, 255, 255);\">条款阅读</span></span></p>', '<p><span style=\"color: rgb(85, 85, 85); font-family: &quot;Microsoft Yahei&quot;, &quot;Hiragino Sans GB&quot;, &quot;Helvetica Neue&quot;, Helvetica, tahoma, arial, &quot;WenQuanYi Micro Hei&quot;, Verdana, sans-serif, 宋体; font-size: 14px; background-color: rgb(255, 255, 255);\">典型<span style=\"font-family: &quot;Microsoft Yahei&quot;, &quot;Hiragino Sans GB&quot;, &quot;Helvetica Neue&quot;, Helvetica, tahoma, arial, &quot;WenQuanYi Micro Hei&quot;, Verdana, sans-serif, 宋体; background-color: rgb(255, 255, 255); font-size: 16px; color: rgb(255, 0, 0);\">案</span>例222244</span></p>', '1495511695');
INSERT INTO `product_rules` VALUES ('4', '28', '<p><span style=\"color: rgb(51, 51, 51); font-family: &quot;Microsoft YaHei&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif; font-size: 12px; background-color: rgb(255, 255, 255);\">1、如需报案或理赔协助服务,请拨打慧择网全国服务电话:4006-366-366。</span><br style=\"white-space: normal; color: rgb(51, 51, 51); font-family: &quot;Microsoft YaHei&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif; font-size: 12px; background-color: rgb(255, 255, 255);\"/><br style=\"white-space: normal; color: rgb(51, 51, 51); font-family: &quot;Microsoft YaHei&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif; font-size: 12px; background-color: rgb(255, 255, 255);\"/><span style=\"color: rgb(51, 51, 51); font-family: &quot;Microsoft YaHei&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif; font-size: 12px; background-color: rgb(255, 255, 255);\">2、报案时,请您提供保单号(或有效证件号码)、出险人姓名、出险时间、出险地点、出险原因、治疗就医情况等基本信息。</span><br style=\"white-space: normal; color: rgb(51, 51, 51); font-family: &quot;Microsoft YaHei&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif; font-size: 12px; background-color: rgb(255, 255, 255);\"/><br style=\"white-space: normal; color: rgb(51, 51, 51); font-family: &quot;Microsoft YaHei&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif; font-size: 12px; background-color: rgb(255, 255, 255);\"/><span style=\"color: rgb(51, 51, 51); font-family: &quot;Microsoft YaHei&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif; font-size: 12px; background-color: rgb(255, 255, 255);\">3、您向慧择报案后,我们将会给您发送索赔指引邮件,告知您资料要求和理赔流程。</span></p>', '<p><span style=\"color: rgb(51, 51, 51); font-family: &quot;Microsoft YaHei&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif; font-size: 12px; background-color: rgb(255, 255, 255);\">1、如需报案或理赔协助服务,请拨打慧择网全国服务电话:4006-366-366。</span><br style=\"color: rgb(51, 51, 51); font-family: &quot;Microsoft YaHei&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\"/><br style=\"color: rgb(51, 51, 51); font-family: &quot;Microsoft YaHei&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\"/><span style=\"color: rgb(51, 51, 51); font-family: &quot;Microsoft YaHei&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif; font-size: 12px; background-color: rgb(255, 255, 255);\">2、报案时,请您提供保单号(或有效证件号码)、出险人姓名、出险时间、出险地点、出险原因、治疗就医情况等基本信息。</span><br style=\"color: rgb(51, 51, 51); font-family: &quot;Microsoft YaHei&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\"/><br style=\"color: rgb(51, 51, 51); font-family: &quot;Microsoft YaHei&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\"/><span style=\"color: rgb(51, 51, 51); font-family: &quot;Microsoft YaHei&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif; font-size: 12px; background-color: rgb(255, 255, 255);\">3、您向慧择报案后,我们将会给您发送索赔指引邮件,告知您资料要求和理赔流程。</span><br style=\"color: rgb(51, 51, 51); font-family: &quot;Microsoft YaHei&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\"/><br style=\"color: rgb(51, 51, 51); font-family: &quot;Microsoft YaHei&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\"/><span style=\"color: rgb(51, 51, 51); font-family: &quot;Microsoft YaHei&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif; font-size: 12px; background-color: rgb(255, 255, 255);\">4、发生合同约定保险事故需要到医院接受治疗,请到合同约定的医院(境内一般是二级或二级以上公立医院)进行就诊治疗。并请提醒主治医生使用医保范围内用药、诊疗项目及服务设施。就诊的同时请妥善保存病历(包含首诊病历)、原始收费凭证、处方、诊断证明、检查化验报告、住院证明等就医相关材料,以便向保险公司办理索赔申请。</span><br style=\"color: rgb(51, 51, 51); font-family: &quot;Microsoft YaHei&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\"/><br style=\"color: rgb(51, 51, 51); font-family: &quot;Microsoft YaHei&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\"/><span style=\"color: rgb(51, 51, 51); font-family: &quot;Microsoft YaHei&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif; font-size: 12px; background-color: rgb(255, 255, 255);\">5、寄送理赔资料时,请在快递单上注明“慧择网客户理赔申请”字样,并请认真注明您的客户号及姓名,随信附上相应的事故证明材料原件。</span><br style=\"color: rgb(51, 51, 51); font-family: &quot;Microsoft YaHei&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\"/><br style=\"color: rgb(51, 51, 51); font-family: &quot;Microsoft YaHei&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\"/><span style=\"color: rgb(51, 51, 51); font-family: &quot;Microsoft YaHei&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif; font-size: 12px; background-color: rgb(255, 255, 255);\">6、若理赔金额超过直付限额,在资料审核无误后,保险公司将通过财务系统直接向您所指定的银行账户进行转账支付。需要您提供开户银行、户名、账号等信息,建议您选择工农中建交或邮储,以便保险公司快速处理。</span></p>', '<p><span style=\"color: rgb(51, 51, 51); font-family: &quot;Microsoft YaHei&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif; font-size: 12px; background-color: rgb(246, 249, 254);\">理赔款一般在结案后的1-2个工作日可以到账。为保障到账时效,建议在提交理赔资料时以工、农、中、建、交或邮储等银行卡作为收款账户。</span></p>', '<p><strong><span style=\"font-size: 20px;\">投保&nbsp;&nbsp;&nbsp;&nbsp;</span></strong></p><p>贝贝,今年刚好1周岁,贝贝父母出于对贝贝的呵护与关爱,在慧择保险网为贝贝投保了一份<strong>平安养老平安宝贝少儿综合医疗保险A款</strong>,保费480元,保障期限1年。</p><p><span style=\"color: rgb(255, 0, 0);\"><strong><span style=\"font-size: 20px;\">出险&nbsp;</span></strong>&nbsp;&nbsp;</span>&nbsp;&nbsp;&nbsp;&nbsp;</p><p>&nbsp;贝贝在投保60天之后因发生疾病导致住院治疗,住院治疗花费了17500元整。</p><p><strong><span style=\"font-size: 20px;\">理赔</span></strong></p><p><span style=\"color: rgb(51, 51, 51); font-family: &quot;Microsoft YaHei&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-serif; font-size: 12px; background-color: rgb(246, 249, 254);\">&nbsp;</span><strong class=\"f14\">保险公司经核实符合保险责任范围,作出如下赔付:</strong></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px;\">(17500-300)*60%=10320元(由于小贝贝没有参加深圳少儿医保,医疗费用超过人民币300元部分按60%赔付;)</p><p><br/></p>', '1495613732');
INSERT INTO `product_rules` VALUES ('5', '29', '<p><span style=\"color: rgb(255, 255, 255); font-family: Arial, Helvetica, sans-serif; font-size: 12px; background-color: rgb(0, 160, 102);\">本产品为“如E家庭财产保险计划”，产品报备文件编号为“(国寿产险)(备案)[2009]N25号、(国寿产险)(备案)[2009]N27号”，由“中国人寿财产保险股份有限公司”承保，“中国人寿财产保险股份有限公司”经营区域为全国。产品条款包括家庭财产保险条款、附加盗抢保险条款、附加家用电器用电安全保险条款、附加管道破裂及水渍保险条款、附加第三者责任保险条款、附加费用扩展条款、附加现金、首饰盗抢保险条款等。</span></p>', '<p><span style=\"color: rgb(255, 255, 255); font-family: Arial, Helvetica, sans-serif; font-size: 12px; background-color: rgb(0, 160, 102);\">本产品为“如E家庭财产保险计划”，产品报备文件编号为“(国寿产险)(备案)[2009]N25号、(国寿产险)(备案)[2009]N27号”，由“中国人寿财产保险股份有限公司”承保，“中国人寿财产保险股份有限公司”经营区域为全国。产品条款包括家庭财产保险条款、附加盗抢保险条款、附加家用电器用电安全保险条款、附加管道破裂及水渍保险条款、附加第三者责任保险条款、附加费用扩展条款、附加现金、首饰盗抢保险条款等。</span></p><p><img src=\"/ueditor/php/upload/image/20170526/1495782897581746.jpg\" style=\"\" title=\"1495782897581746.jpg\"/></p><p><img src=\"/ueditor/php/upload/image/20170526/1495782897764459.jpg\" style=\"\" title=\"1495782897764459.jpg\"/></p><p><br/></p>', '<p><span style=\"color: rgb(255, 255, 255); font-family: Arial, Helvetica, sans-serif; font-size: 12px; background-color: rgb(0, 160, 102);\">本产品为“如E家庭财产保险计划”，产品报备文件编号为“(国寿产险)(备案)[2009]N25号、(国寿产险)(备案)[2009]N27号”，由“中国人寿财产保险股份有限公司”承保，“中国人寿财产保险股份有限公司”经营区域为全国。产品条款包括家庭财产保险条款、附加盗抢保险条款、附加家用电器用电安全保险条款、附加管道破裂及水渍保险条款、附加第三者责任保险条款、附加费用扩展条款、附加现金、首饰盗抢保险条款等。</span></p>', '<h1 label=\"标题居中\" style=\"font-size: 32px; font-weight: bold; border-bottom: 2px solid rgb(204, 204, 204); padding: 0px 4px 0px 0px; text-align: center; margin: 0px 0px 20px;\"><strong>asdfasdasdfasdf asdfdfadsasdf&nbsp;<span style=\"color: rgb(255, 255, 255); font-family: Arial, Helvetica, sans-serif; font-size: 12px; background-color: rgb(0, 160, 102);\">本产品为“如E家庭财产保险计划”，产品报备文件编号为“(国寿产险)(备案)[2009]N25号、(国寿产险)(备案)[2009]N27号”，由“中国人寿财产保险股份有限公司”承保，“中国人寿财产保险股份有限公司”经营区域为全国。产品条款包括家庭财产保险条款、附加盗抢保险条款、附加家用电器用电安全保险条款、附加管道破裂及水渍保险条款、附加第三者责任保险条款、附加费用扩展条款、附加现金、首饰盗抢保险条款等。zxczxc<em>zxczx</em></span></strong><span style=\"color: rgb(255, 255, 255); font-family: Arial, Helvetica, sans-serif; font-size: 12px; background-color: rgb(0, 160, 102);\"><img src=\"/ueditor/php/upload/image/20170526/1495782662952379.jpg\" title=\"1495782662952379.jpg\" alt=\"欢迎扫描.jpg\"/></span><br/></h1>', '1495782905');
INSERT INTO `product_rules` VALUES ('6', '30', '<p><span style=\"color: rgb(145, 145, 145); font-family: Arial; font-size: 12px; background-color: rgb(255, 255, 255);\">如E公民出境保险计划适合因旅游、留学、探亲访友、外交、访问、考察、短期培训而出境的人员，提供最高30万的意外伤害保障。</span></p>', '<p><span style=\"color: rgb(145, 145, 145); font-family: Arial; font-size: 12px; background-color: rgb(255, 255, 255);\">如E公民出境保险计划适合因旅游、留学、探亲访友、外交、访问、考察、短期培训而出境的人员，提供最高30万的意外伤害保障。</span></p>', '<p><span style=\"color: rgb(145, 145, 145); font-family: Arial; font-size: 12px; background-color: rgb(255, 255, 255);\">如E公民出境保险计划适合因旅游、留学、探亲访友、外交、访问、考察、短期培训而出境的人员，提供最高30万的意外伤害保障。</span></p>', '<p><span style=\"color: rgb(145, 145, 145); font-family: Arial; font-size: 12px; background-color: rgb(255, 255, 255);\">如E公民出境保险计划适合因旅游、留学、探亲访友、外交、访问、考察、短期培训而出境的人员，提供最高30万的意外伤害保障。</span></p>', '1495852585');
INSERT INTO `product_rules` VALUES ('7', '31', '<p><span style=\"color: rgb(145, 145, 145); font-family: Arial; font-size: 12px; background-color: rgb(255, 255, 255);\">如E公民出境保险计划适合因旅游、留学、探亲访友、外交、访问、考察、短期培训而出境的人员，提供最高30万的意外伤害保障。</span></p>', '<p><span style=\"color: rgb(145, 145, 145); font-family: Arial; font-size: 12px; background-color: rgb(255, 255, 255);\">如E公民出境保险计划适合因旅游、留学、探亲访友、外交、访问、考察、短期培训而出境的人员，提供最高30万的意外伤害保障。</span></p>', '<p><span style=\"color: rgb(145, 145, 145); font-family: Arial; font-size: 12px; background-color: rgb(255, 255, 255);\">如E公民出境保险计划适合因旅游、留学、探亲访友、外交、访问、考察、短期培训而出境的人员，提供最高30万的意外伤害保障。</span></p>', '<p><span style=\"color: rgb(145, 145, 145); font-family: Arial; font-size: 12px; background-color: rgb(255, 255, 255);\">如E公民出境保险计划适合因旅游、留学、探亲访友、外交、访问、考察、短期培训而出境的人员，提供最高30万的意外伤害保障。</span></p>', '1495857428');
INSERT INTO `product_rules` VALUES ('8', '32', '<p><span style=\"color: rgb(145, 145, 145); font-family: Arial; font-size: 12px; background-color: rgb(255, 255, 255);\">如E公民出境保险计划适合因旅游、留学、探亲访友、外交、访问、考察、短期培训而出境的人员，提供最高30万的意外伤害保障。</span></p>', '<p><span style=\"color: rgb(145, 145, 145); font-family: Arial; font-size: 12px; background-color: rgb(255, 255, 255);\">如E公民出境保险计划适合因旅游、留学、探亲访友、外交、访问、考察、短期培训而出境的人员，提供最高30万的意外伤害保障。</span></p>', '<p><span style=\"color: rgb(145, 145, 145); font-family: Arial; font-size: 12px; background-color: rgb(255, 255, 255);\">如E公民出境保险计划适合因旅游、留学、探亲访友、外交、访问、考察、短期培训而出境的人员，提供最高30万的意外伤害保障。</span></p>', '<p><span style=\"color: rgb(145, 145, 145); font-family: Arial; font-size: 12px; background-color: rgb(255, 255, 255);\">如E公民出境保险计划适合因旅游、留学、探亲访友、外交、访问、考察、短期培训而出境的人员，提供最高30万的意外伤害保障。</span></p>', '1495852757');
INSERT INTO `product_rules` VALUES ('9', '33', '<p><span style=\"color: rgb(145, 145, 145); font-family: Arial; font-size: 12px; background-color: rgb(255, 255, 255);\">如E公民出境保险计划适合因旅游、留学、探亲访友、外交、访问、考察、短期培训而出境的人员，提供最高30万的意外伤害保障。</span></p>', '<p><span style=\"color: rgb(145, 145, 145); font-family: Arial; font-size: 12px; background-color: rgb(255, 255, 255);\">如E公民出境保险计划适合因旅游、留学、探亲访友、外交、访问、考察、短期培训而出境的人员，提供最高30万的意外伤害保障。</span></p>', '<p><span style=\"color: rgb(145, 145, 145); font-family: Arial; font-size: 12px; background-color: rgb(255, 255, 255);\">如E公民出境保险计划适合因旅游、留学、探亲访友、外交、访问、考察、短期培训而出境的人员，提供最高30万的意外伤害保障。</span></p>', '<p><span style=\"color: rgb(145, 145, 145); font-family: Arial; font-size: 12px; background-color: rgb(255, 255, 255);\">如E公民出境保险计划适合因旅游、留学、探亲访友、外交、访问、考察、短期培训而出境的人员，提供最高30万的意外伤害保障。</span></p>', '1495852758');
INSERT INTO `product_rules` VALUES ('10', '34', '<p>PHP是世界上最好的语言</p>', '<p>PHP是世界上最好的语言</p>', '<p>PHP是世界上最好的语言</p>', '<p>PHP是世界上最好的语言</p>', '1495856177');
INSERT INTO `product_rules` VALUES ('11', '35', '<p>1</p>', '<p>1</p>', '<p>1</p>', '<p>1</p>', '1495856545');
INSERT INTO `product_rules` VALUES ('12', '36', '<p>1</p>', '<p>1</p>', '<p>1</p>', '<p>1</p>', '1495856712');
INSERT INTO `product_rules` VALUES ('13', '37', '<p>1</p>', '<p>1</p>', '<p>1</p>', '<p>1</p>', '1495856713');
INSERT INTO `product_rules` VALUES ('14', '38', '<p>1</p>', '<p>1</p>', '<p>1</p>', '<p>1</p>', '1495856733');
INSERT INTO `product_rules` VALUES ('15', '39', '<p style=\"white-space: normal;\">PHP是</p><p style=\"white-space: normal;\">PHP是</p><p><br/></p>', '<p style=\"white-space: normal;\">PHP是</p><p style=\"white-space: normal;\">PHP是</p><p><br/></p>', '<p style=\"white-space: normal;\">PHP是</p><p><br/></p>', '<p style=\"white-space: normal;\">PHP是</p><p><br/></p>', '1495857304');
INSERT INTO `product_rules` VALUES ('16', '40', '<p>佣金比例(非寿)佣金比例(非寿)</p>', '<p>佣金比例(非寿)</p>', '<p>佣金比例(非寿)</p>', '<p>v佣金比例(非寿)</p>', '1495863963');
INSERT INTO `product_rules` VALUES ('17', '41', '<p class=\"ttit\" style=\"margin: 0px auto; padding: 5px; border-width: 2px; border-style: solid; border-color: rgb(255, 255, 255); background: rgb(0, 160, 102); color: rgb(255, 255, 255); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal;\">本产品为“商业机动车辆保险”，产品报备文件编号为“H2015102”，由“中国人寿财产保险股份有限公司”承保，“中国人寿财产保险股份有限公司”经营区域为全国，产品条款包括：机动车第三者责任保险条款、机动车损失保险条款、机动车车上人员责任保险条款、机动车盗抢保险条款、玻璃单独破碎险条款、车身划痕损失险条款、可选免赔额特约条款、不计免赔率特约条款、自燃损失险条款、新增加设备损失保险条款、发动机特别损失险条款、机动车停驶损失险条款、附加换件特约条款、随车行李物品损失保险条款、附加交通事故精神损害赔偿责任保险条款、异地出险住宿费特约条款、法律费用特约条款、多次事故免赔率特约条款、节假日行驶区域扩展特约条款等。</p><p style=\"margin: 0px auto; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">保险期间内，被保险人或其允许的合法驾驶人在使用被保险机动车过程中，因下列原因造成被保险机动车的损失，保险人依照本保险合同的约定负责赔偿：</p><p style=\"margin: 0px auto; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">（一） 碰撞、倾覆、坠落；</p><p style=\"margin: 0px auto; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">（二） 火灾、爆炸；</p><p style=\"margin: 0px auto; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">（三） 外界物体坠落、倒塌；</p><p style=\"margin: 0px auto; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">（四） 暴风、龙卷风；</p><p style=\"margin: 0px auto; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">（五） 雷击、雹灾、暴雨、洪水、海啸；</p><p style=\"margin: 0px auto; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">（六） 地陷、冰陷、崖崩、雪崩、泥石流、滑坡；</p><p style=\"margin: 0px auto; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">（七） 载运被保险机动车的渡船遭受自然灾害（只限于驾驶人随船的情形）。</p><p style=\"margin: 0px auto; padding: 0px; font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(250, 135, 0);\">*以上描述为简要介绍，最终均以条款为准！</p><table width=\"660\"><tbody style=\"margin: 0px auto; padding: 0px;\"><tr style=\"margin: 0px auto; padding: 0px;\" class=\"firstRow\"><td class=\"ttit\" style=\"margin: 0px auto; padding-right: 5px; padding-left: 5px; border-width: 2px; border-color: rgb(255, 255, 255); background: rgb(0, 160, 102); color: rgb(255, 255, 255);\" height=\"30\"><strong style=\"margin: 0px auto; padding: 0px;\">投诉渠道</strong></td></tr><tr style=\"margin: 0px auto; padding: 0px;\"><td class=\"ttit1\" style=\"margin: 0px auto; padding-right: 5px; padding-left: 5px; border-width: 2px; border-color: rgb(255, 255, 255);\" height=\"30\">如果您在购买产品的过程中，如发现本公司人员有违法违规行为，或认为自身权益受到侵犯，请您保留相关证据并向本公司投诉，投诉电话：95519</td></tr><tr style=\"margin: 0px auto; padding: 0px;\"><td class=\"ttit\" style=\"margin: 0px auto; padding-right: 5px; padding-left: 5px; border-width: 2px; border-color: rgb(255, 255, 255); background: rgb(0, 160, 102); color: rgb(255, 255, 255);\" height=\"30\"><strong style=\"margin: 0px auto; padding: 0px;\">如实告知义务</strong></td></tr><tr style=\"margin: 0px auto; padding: 0px;\"><td class=\"ttit1\" style=\"margin: 0px auto; padding-right: 5px; padding-left: 5px; border-width: 2px; border-color: rgb(255, 255, 255);\" height=\"30\">我们就您和被保人的有关情况提出询问，您应当如实告知。如果您因故意或者重大过失未履行规定的如实告知义务，足以影响我们决定是否同意承保或者提高保险费率，我们有权解除合同。</td></tr><tr style=\"margin: 0px auto; padding: 0px;\"><td class=\"ttit\" style=\"margin: 0px auto; padding-right: 5px; padding-left: 5px; border-width: 2px; border-color: rgb(255, 255, 255); background: rgb(0, 160, 102); color: rgb(255, 255, 255);\" height=\"30\"><strong style=\"margin: 0px auto; padding: 0px;\">信息安全承诺</strong></td></tr><tr style=\"margin: 0px auto; padding: 0px;\"><td class=\"ttit1\" style=\"margin: 0px auto; padding-right: 5px; padding-left: 5px; border-width: 2px; border-color: rgb(255, 255, 255);\" height=\"30\">我们严格遵守现行的关于个人信息、数据及隐私保护法律法规，采取充分的技术手段和制度管理，保护您提供给我们的个人信息、信息和隐私不受到非法的泄露或披露给未获授权的第三方。请您放心。</td></tr><tr style=\"margin: 0px auto; padding: 0px;\"><td class=\"ttit\" style=\"margin: 0px auto; padding-right: 5px; padding-left: 5px; border-width: 2px; border-color: rgb(255, 255, 255); background: rgb(0, 160, 102); color: rgb(255, 255, 255);\" height=\"30\"><strong style=\"margin: 0px auto; padding: 0px;\">保单形式</strong></td></tr><tr style=\"margin: 0px auto; padding: 0px;\"><td class=\"ttit1\" style=\"margin: 0px auto; padding-right: 5px; padding-left: 5px; border-width: 2px; border-color: rgb(255, 255, 255);\" height=\"30\">本合同采用电子保险单的形式承保，您可以通过95519查询保单。如您需要发票，请拨打客服热线：95519。<br/><br/></td></tr></tbody></table><p><br/></p>', '<p class=\"ttit\" style=\"margin: 0px auto; padding: 5px; border-width: 2px; border-style: solid; border-color: rgb(255, 255, 255); background: rgb(0, 160, 102); color: rgb(255, 255, 255); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal;\">本产品为“商业机动车辆保险”，产品报备文件编号为“H2015102”，由“中国人寿财产保险股份有限公司”承保，“中国人寿财产保险股份有限公司”经营区域为全国，产品条款包括：机动车第三者责任保险条款、机动车损失保险条款、机动车车上人员责任保险条款、机动车盗抢保险条款、玻璃单独破碎险条款、车身划痕损失险条款、可选免赔额特约条款、不计免赔率特约条款、自燃损失险条款、新增加设备损失保险条款、发动机特别损失险条款、机动车停驶损失险条款、附加换件特约条款、随车行李物品损失保险条款、附加交通事故精神损害赔偿责任保险条款、异地出险住宿费特约条款、法律费用特约条款、多次事故免赔率特约条款、节假日行驶区域扩展特约条款等。</p><p style=\"margin: 0px auto; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">保险期间内，被保险人或其允许的合法驾驶人在使用被保险机动车过程中，因下列原因造成被保险机动车的损失，保险人依照本保险合同的约定负责赔偿：</p><p style=\"margin: 0px auto; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">（一） 碰撞、倾覆、坠落；</p><p style=\"margin: 0px auto; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">（二） 火灾、爆炸；</p><p style=\"margin: 0px auto; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">（三） 外界物体坠落、倒塌；</p><p style=\"margin: 0px auto; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">（四） 暴风、龙卷风；</p><p style=\"margin: 0px auto; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">（五） 雷击、雹灾、暴雨、洪水、海啸；</p><p style=\"margin: 0px auto; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">（六） 地陷、冰陷、崖崩、雪崩、泥石流、滑坡；</p><p style=\"margin: 0px auto; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">（七） 载运被保险机动车的渡船遭受自然灾害（只限于驾驶人随船的情形）。</p><p style=\"margin: 0px auto; padding: 0px; font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(250, 135, 0);\">*以上描述为简要介绍，最终均以条款为准！</p><table width=\"660\"><tbody style=\"margin: 0px auto; padding: 0px;\"><tr style=\"margin: 0px auto; padding: 0px;\" class=\"firstRow\"><td class=\"ttit\" style=\"margin: 0px auto; padding-right: 5px; padding-left: 5px; border-width: 2px; border-color: rgb(255, 255, 255); background: rgb(0, 160, 102); color: rgb(255, 255, 255);\" height=\"30\"><strong style=\"margin: 0px auto; padding: 0px;\">投诉渠道</strong></td></tr><tr style=\"margin: 0px auto; padding: 0px;\"><td class=\"ttit1\" style=\"margin: 0px auto; padding-right: 5px; padding-left: 5px; border-width: 2px; border-color: rgb(255, 255, 255);\" height=\"30\">如果您在购买产品的过程中，如发现本公司人员有违法违规行为，或认为自身权益受到侵犯，请您保留相关证据并向本公司投诉，投诉电话：95519</td></tr><tr style=\"margin: 0px auto; padding: 0px;\"><td class=\"ttit\" style=\"margin: 0px auto; padding-right: 5px; padding-left: 5px; border-width: 2px; border-color: rgb(255, 255, 255); background: rgb(0, 160, 102); color: rgb(255, 255, 255);\" height=\"30\"><strong style=\"margin: 0px auto; padding: 0px;\">如实告知义务</strong></td></tr><tr style=\"margin: 0px auto; padding: 0px;\"><td class=\"ttit1\" style=\"margin: 0px auto; padding-right: 5px; padding-left: 5px; border-width: 2px; border-color: rgb(255, 255, 255);\" height=\"30\">我们就您和被保人的有关情况提出询问，您应当如实告知。如果您因故意或者重大过失未履行规定的如实告知义务，足以影响我们决定是否同意承保或者提高保险费率，我们有权解除合同。</td></tr><tr style=\"margin: 0px auto; padding: 0px;\"><td class=\"ttit\" style=\"margin: 0px auto; padding-right: 5px; padding-left: 5px; border-width: 2px; border-color: rgb(255, 255, 255); background: rgb(0, 160, 102); color: rgb(255, 255, 255);\" height=\"30\"><strong style=\"margin: 0px auto; padding: 0px;\">信息安全承诺</strong></td></tr><tr style=\"margin: 0px auto; padding: 0px;\"><td class=\"ttit1\" style=\"margin: 0px auto; padding-right: 5px; padding-left: 5px; border-width: 2px; border-color: rgb(255, 255, 255);\" height=\"30\">我们严格遵守现行的关于个人信息、数据及隐私保护法律法规，采取充分的技术手段和制度管理，保护您提供给我们的个人信息、信息和隐私不受到非法的泄露或披露给未获授权的第三方。请您放心。</td></tr><tr style=\"margin: 0px auto; padding: 0px;\"><td class=\"ttit\" style=\"margin: 0px auto; padding-right: 5px; padding-left: 5px; border-width: 2px; border-color: rgb(255, 255, 255); background: rgb(0, 160, 102); color: rgb(255, 255, 255);\" height=\"30\"><strong style=\"margin: 0px auto; padding: 0px;\">保单形式</strong></td></tr><tr style=\"margin: 0px auto; padding: 0px;\"><td class=\"ttit1\" style=\"margin: 0px auto; padding-right: 5px; padding-left: 5px; border-width: 2px; border-color: rgb(255, 255, 255);\" height=\"30\">本合同采用电子保险单的形式承保，您可以通过95519查询保单。如您需要发票，请拨打客服热线：95519。<br/><br/></td></tr></tbody></table><p><br/></p>', '<p class=\"ttit\" style=\"margin: 0px auto; padding: 5px; border-width: 2px; border-style: solid; border-color: rgb(255, 255, 255); background: rgb(0, 160, 102); color: rgb(255, 255, 255); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal;\">本产品为“商业机动车辆保险”，产品报备文件编号为“H2015102”，由“中国人寿财产保险股份有限公司”承保，“中国人寿财产保险股份有限公司”经营区域为全国，产品条款包括：机动车第三者责任保险条款、机动车损失保险条款、机动车车上人员责任保险条款、机动车盗抢保险条款、玻璃单独破碎险条款、车身划痕损失险条款、可选免赔额特约条款、不计免赔率特约条款、自燃损失险条款、新增加设备损失保险条款、发动机特别损失险条款、机动车停驶损失险条款、附加换件特约条款、随车行李物品损失保险条款、附加交通事故精神损害赔偿责任保险条款、异地出险住宿费特约条款、法律费用特约条款、多次事故免赔率特约条款、节假日行驶区域扩展特约条款等。</p><p style=\"margin: 0px auto; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">保险期间内，被保险人或其允许的合法驾驶人在使用被保险机动车过程中，因下列原因造成被保险机动车的损失，保险人依照本保险合同的约定负责赔偿：</p><p style=\"margin: 0px auto; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">（一） 碰撞、倾覆、坠落；</p><p style=\"margin: 0px auto; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">（二） 火灾、爆炸；</p><p style=\"margin: 0px auto; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">（三） 外界物体坠落、倒塌；</p><p style=\"margin: 0px auto; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">（四） 暴风、龙卷风；</p><p style=\"margin: 0px auto; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">（五） 雷击、雹灾、暴雨、洪水、海啸；</p><p style=\"margin: 0px auto; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">（六） 地陷、冰陷、崖崩、雪崩、泥石流、滑坡；</p><p style=\"margin: 0px auto; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">（七） 载运被保险机动车的渡船遭受自然灾害（只限于驾驶人随船的情形）。</p><p style=\"margin: 0px auto; padding: 0px; font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(250, 135, 0);\">*以上描述为简要介绍，最终均以条款为准！</p><table width=\"660\"><tbody style=\"margin: 0px auto; padding: 0px;\"><tr style=\"margin: 0px auto; padding: 0px;\" class=\"firstRow\"><td class=\"ttit\" style=\"margin: 0px auto; padding-right: 5px; padding-left: 5px; border-width: 2px; border-color: rgb(255, 255, 255); background: rgb(0, 160, 102); color: rgb(255, 255, 255);\" height=\"30\"><strong style=\"margin: 0px auto; padding: 0px;\">投诉渠道</strong></td></tr><tr style=\"margin: 0px auto; padding: 0px;\"><td class=\"ttit1\" style=\"margin: 0px auto; padding-right: 5px; padding-left: 5px; border-width: 2px; border-color: rgb(255, 255, 255);\" height=\"30\">如果您在购买产品的过程中，如发现本公司人员有违法违规行为，或认为自身权益受到侵犯，请您保留相关证据并向本公司投诉，投诉电话：95519</td></tr><tr style=\"margin: 0px auto; padding: 0px;\"><td class=\"ttit\" style=\"margin: 0px auto; padding-right: 5px; padding-left: 5px; border-width: 2px; border-color: rgb(255, 255, 255); background: rgb(0, 160, 102); color: rgb(255, 255, 255);\" height=\"30\"><strong style=\"margin: 0px auto; padding: 0px;\">如实告知义务</strong></td></tr><tr style=\"margin: 0px auto; padding: 0px;\"><td class=\"ttit1\" style=\"margin: 0px auto; padding-right: 5px; padding-left: 5px; border-width: 2px; border-color: rgb(255, 255, 255);\" height=\"30\">我们就您和被保人的有关情况提出询问，您应当如实告知。如果您因故意或者重大过失未履行规定的如实告知义务，足以影响我们决定是否同意承保或者提高保险费率，我们有权解除合同。</td></tr><tr style=\"margin: 0px auto; padding: 0px;\"><td class=\"ttit\" style=\"margin: 0px auto; padding-right: 5px; padding-left: 5px; border-width: 2px; border-color: rgb(255, 255, 255); background: rgb(0, 160, 102); color: rgb(255, 255, 255);\" height=\"30\"><strong style=\"margin: 0px auto; padding: 0px;\">信息安全承诺</strong></td></tr><tr style=\"margin: 0px auto; padding: 0px;\"><td class=\"ttit1\" style=\"margin: 0px auto; padding-right: 5px; padding-left: 5px; border-width: 2px; border-color: rgb(255, 255, 255);\" height=\"30\">我们严格遵守现行的关于个人信息、数据及隐私保护法律法规，采取充分的技术手段和制度管理，保护您提供给我们的个人信息、信息和隐私不受到非法的泄露或披露给未获授权的第三方。请您放心。</td></tr><tr style=\"margin: 0px auto; padding: 0px;\"><td class=\"ttit\" style=\"margin: 0px auto; padding-right: 5px; padding-left: 5px; border-width: 2px; border-color: rgb(255, 255, 255); background: rgb(0, 160, 102); color: rgb(255, 255, 255);\" height=\"30\"><strong style=\"margin: 0px auto; padding: 0px;\">保单形式</strong></td></tr><tr style=\"margin: 0px auto; padding: 0px;\"><td class=\"ttit1\" style=\"margin: 0px auto; padding-right: 5px; padding-left: 5px; border-width: 2px; border-color: rgb(255, 255, 255);\" height=\"30\">本合同采用电子保险单的形式承保，您可以通过95519查询保单。如您需要发票，请拨打客服热线：95519。<br/><br/></td></tr></tbody></table><p><br/></p>', '<p class=\"ttit\" style=\"margin: 0px auto; padding: 5px; border-width: 2px; border-style: solid; border-color: rgb(255, 255, 255); background: rgb(0, 160, 102); color: rgb(255, 255, 255); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal;\">本产品为“商业机动车辆保险”，产品报备文件编号为“H2015102”，由“中国人寿财产保险股份有限公司”承保，“中国人寿财产保险股份有限公司”经营区域为全国，产品条款包括：机动车第三者责任保险条款、机动车损失保险条款、机动车车上人员责任保险条款、机动车盗抢保险条款、玻璃单独破碎险条款、车身划痕损失险条款、可选免赔额特约条款、不计免赔率特约条款、自燃损失险条款、新增加设备损失保险条款、发动机特别损失险条款、机动车停驶损失险条款、附加换件特约条款、随车行李物品损失保险条款、附加交通事故精神损害赔偿责任保险条款、异地出险住宿费特约条款、法律费用特约条款、多次事故免赔率特约条款、节假日行驶区域扩展特约条款等。</p><p style=\"margin: 0px auto; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">保险期间内，被保险人或其允许的合法驾驶人在使用被保险机动车过程中，因下列原因造成被保险机动车的损失，保险人依照本保险合同的约定负责赔偿：</p><p style=\"margin: 0px auto; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">（一） 碰撞、倾覆、坠落；</p><p style=\"margin: 0px auto; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">（二） 火灾、爆炸；</p><p style=\"margin: 0px auto; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">（三） 外界物体坠落、倒塌；</p><p style=\"margin: 0px auto; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">（四） 暴风、龙卷风；</p><p style=\"margin: 0px auto; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">（五） 雷击、雹灾、暴雨、洪水、海啸；</p><p style=\"margin: 0px auto; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">（六） 地陷、冰陷、崖崩、雪崩、泥石流、滑坡；</p><p style=\"margin: 0px auto; padding: 0px; color: rgb(102, 102, 102); font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255);\">（七） 载运被保险机动车的渡船遭受自然灾害（只限于驾驶人随船的情形）。</p><p style=\"margin: 0px auto; padding: 0px; font-family: Arial, Helvetica, sans-serif; font-size: 12px; white-space: normal; background-color: rgb(255, 255, 255); color: rgb(250, 135, 0);\">*以上描述为简要介绍，最终均以条款为准！</p><table width=\"660\"><tbody style=\"margin: 0px auto; padding: 0px;\"><tr style=\"margin: 0px auto; padding: 0px;\" class=\"firstRow\"><td class=\"ttit\" style=\"margin: 0px auto; padding-right: 5px; padding-left: 5px; border-width: 2px; border-color: rgb(255, 255, 255); background: rgb(0, 160, 102); color: rgb(255, 255, 255);\" height=\"30\"><strong style=\"margin: 0px auto; padding: 0px;\">投诉渠道</strong></td></tr><tr style=\"margin: 0px auto; padding: 0px;\"><td class=\"ttit1\" style=\"margin: 0px auto; padding-right: 5px; padding-left: 5px; border-width: 2px; border-color: rgb(255, 255, 255);\" height=\"30\">如果您在购买产品的过程中，如发现本公司人员有违法违规行为，或认为自身权益受到侵犯，请您保留相关证据并向本公司投诉，投诉电话：95519</td></tr><tr style=\"margin: 0px auto; padding: 0px;\"><td class=\"ttit\" style=\"margin: 0px auto; padding-right: 5px; padding-left: 5px; border-width: 2px; border-color: rgb(255, 255, 255); background: rgb(0, 160, 102); color: rgb(255, 255, 255);\" height=\"30\"><strong style=\"margin: 0px auto; padding: 0px;\">如实告知义务</strong></td></tr><tr style=\"margin: 0px auto; padding: 0px;\"><td class=\"ttit1\" style=\"margin: 0px auto; padding-right: 5px; padding-left: 5px; border-width: 2px; border-color: rgb(255, 255, 255);\" height=\"30\">我们就您和被保人的有关情况提出询问，您应当如实告知。如果您因故意或者重大过失未履行规定的如实告知义务，足以影响我们决定是否同意承保或者提高保险费率，我们有权解除合同。</td></tr><tr style=\"margin: 0px auto; padding: 0px;\"><td class=\"ttit\" style=\"margin: 0px auto; padding-right: 5px; padding-left: 5px; border-width: 2px; border-color: rgb(255, 255, 255); background: rgb(0, 160, 102); color: rgb(255, 255, 255);\" height=\"30\"><strong style=\"margin: 0px auto; padding: 0px;\">信息安全承诺</strong></td></tr><tr style=\"margin: 0px auto; padding: 0px;\"><td class=\"ttit1\" style=\"margin: 0px auto; padding-right: 5px; padding-left: 5px; border-width: 2px; border-color: rgb(255, 255, 255);\" height=\"30\">我们严格遵守现行的关于个人信息、数据及隐私保护法律法规，采取充分的技术手段和制度管理，保护您提供给我们的个人信息、信息和隐私不受到非法的泄露或披露给未获授权的第三方。请您放心。</td></tr><tr style=\"margin: 0px auto; padding: 0px;\"><td class=\"ttit\" style=\"margin: 0px auto; padding-right: 5px; padding-left: 5px; border-width: 2px; border-color: rgb(255, 255, 255); background: rgb(0, 160, 102); color: rgb(255, 255, 255);\" height=\"30\"><strong style=\"margin: 0px auto; padding: 0px;\">保单形式</strong></td></tr><tr style=\"margin: 0px auto; padding: 0px;\"><td class=\"ttit1\" style=\"margin: 0px auto; padding-right: 5px; padding-left: 5px; border-width: 2px; border-color: rgb(255, 255, 255);\" height=\"30\">本合同采用电子保险单的形式承保，您可以通过95519查询保单。如您需要发票，请拨打客服热线：95519。<br/><br/></td></tr></tbody></table><p><br/></p>', '1495864989');
INSERT INTO `product_rules` VALUES ('18', '42', '<p>阿萨德ad 阿萨德</p>', '<p>按时大</p>', '<p>啊士大夫啊啊打发</p>', '<p>阿萨德按时阿萨德</p>', '1495867743');
INSERT INTO `product_rules` VALUES ('19', '43', '<p>阿萨德</p>', '<p>阿萨德</p>', '<p>啥地方</p>', '<p>阿斯顿发</p>', '1496201466');
INSERT INTO `product_rules` VALUES ('20', '44', '<p>1</p>', '<p>1</p>', '<p>1</p>', '<p>1</p>', '1496201597');
INSERT INTO `product_rules` VALUES ('21', '45', '<p>1</p>', '<p>1</p>', '<p>1</p>', '<p>1</p>', '1496201695');
INSERT INTO `product_rules` VALUES ('22', '46', null, null, null, null, '1496202015');
INSERT INTO `product_rules` VALUES ('23', '47', null, null, null, null, '1496205346');
INSERT INTO `product_rules` VALUES ('24', '48', '<p>1</p>', '<p>1</p>', '<p>1</p>', '<p>1</p>', '1496208988');
INSERT INTO `product_rules` VALUES ('25', '49', '<p>111111</p>', '<p>111111111</p>', '<p>111111</p>', '<p>11111<img src=\"/ueditor/php/upload/image/20170531/1496209047140894.jpg\" title=\"1496209047140894.jpg\" alt=\"u=4029251510,2225754550&amp;fm=23&amp;gp=0.jpg\"/></p>', '1496209053');
INSERT INTO `product_rules` VALUES ('26', '50', '<p>1</p>', '<p>1</p>', '<p>1</p>', '<p>1</p>', '1496209204');
INSERT INTO `product_rules` VALUES ('27', '51', null, null, null, null, '1496209461');
INSERT INTO `product_rules` VALUES ('28', '52', '<p>1</p>', '<p>1</p>', '<p>1<img src=\"/ueditor/php/upload/image/20170531/1496209630860162.jpg\" title=\"1496209630860162.jpg\" alt=\"u=4029251510,2225754550&amp;fm=23&amp;gp=0.jpg\"/></p>', '<p>1<img src=\"/ueditor/php/upload/image/20170531/1496209627219892.jpg\" title=\"1496209627219892.jpg\" alt=\"u=4029251510,2225754550&amp;fm=23&amp;gp=0.jpg\"/></p>', '1496209632');
INSERT INTO `product_rules` VALUES ('29', '53', '<p>111111</p>', '<p>11111</p>', '<p>11111</p>', '<p>111</p>', '1496210627');
INSERT INTO `product_rules` VALUES ('30', '54', null, null, null, null, '1496210780');

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
-- Records of product_safeguard
-- ----------------------------
INSERT INTO `product_safeguard` VALUES ('1', '21', '测试', '测试一下啊', '1', '10', null, null);

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
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8 COMMENT='产品销售分类---赵';

-- ----------------------------
-- Records of product_type
-- ----------------------------
INSERT INTO `product_type` VALUES ('48', '0', '意外保险', null, null, '1', '1', '0', null, '1495508117');
INSERT INTO `product_type` VALUES ('49', '0', '防癌保险', null, null, '1', '1', '0', null, '1495508157');
INSERT INTO `product_type` VALUES ('50', '49', '终生防癌保险', null, null, '1', '1', '0', null, '1495508190');
INSERT INTO `product_type` VALUES ('51', '0', '手机屏保显', null, '中国人寿保险股份有限公司中国人寿保险股份有限公司', '1', '1', '0', null, '1495785600');
INSERT INTO `product_type` VALUES ('52', '0', '中国人寿保险股份有限公司', null, '中国人寿保险股份有限公司中国人寿保险股份有限公司自行车', '1', '-1', '0', '1495785634', '1495785613');

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
-- Records of product_unsales_category
-- ----------------------------
INSERT INTO `product_unsales_category` VALUES ('5', '0', '少儿保险', null, '儿童保险', '1', '1', null, '1495508260');
INSERT INTO `product_unsales_category` VALUES ('6', '5', '少儿教育金', null, null, '1', '1', null, '1495508286');
INSERT INTO `product_unsales_category` VALUES ('7', '0', '手机屏保保险', null, '中国人寿保险股份有限公司', '1', '1', null, '1495785771');
INSERT INTO `product_unsales_category` VALUES ('8', '5', '孩子丢失保险', null, '11111111111', '1', '1', '1495785875', '1495785819');
INSERT INTO `product_unsales_category` VALUES ('9', '7', '阿萨德', null, '阿斯顿发阿萨德啊按时', '1', '-1', '1495788452', '1495788425');

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
-- Records of question
-- ----------------------------
INSERT INTO `question` VALUES ('1', '测试11', '0', '侧撒打算', '0', '1', null, '1494816457');
INSERT INTO `question` VALUES ('2', '阿萨德撒', '0', '12321321阿斯顿发阿萨德', '0', '1', '1494814495', '1495868518');
INSERT INTO `question` VALUES ('3', '大神', '0', '23213', '0', '1', '1494815001', '0');
INSERT INTO `question` VALUES ('4', '333123啊', '0', '222233333', '0', '1', '1494815018', '0');
INSERT INTO `question` VALUES ('5', '从萨斯', '0', '阿萨德撒', '0', '1', '1494816602', '1495857218');
INSERT INTO `question` VALUES ('6', '搜索', '0', '方法', '0', '1', '1494816645', '0');
INSERT INTO `question` VALUES ('7', 'w', '0', 'w', '0', '1', '1494816709', '0');
INSERT INTO `question` VALUES ('8', 'd', '0', 'd', '0', '1', '1494816739', '0');
INSERT INTO `question` VALUES ('9', '23', '0', '33', '0', '0', '1494816788', '0');
INSERT INTO `question` VALUES ('10', '333', '0', '222', '0', '-1', '1494816810', '0');
INSERT INTO `question` VALUES ('11', '22', '0', '22', '0', '0', '1494816834', '0');
INSERT INTO `question` VALUES ('12', '第三方111阿斯顿发', '0', '阿斯顿发阿萨德啊111111', '0', '-1', '1495789591', '1495869169');
INSERT INTO `question` VALUES ('13', 'nihao ', '0', 'fdfdf', '0', '1', '1495871371', '0');
INSERT INTO `question` VALUES ('14', 'uyuyu', '0', 'yuyuyu', '0', '1', '1495871410', '0');

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
-- Records of question_type
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8 COMMENT='邱位鹏  缴费时间表';

-- ----------------------------
-- Records of renew
-- ----------------------------
INSERT INTO `renew` VALUES ('1', '1324613215', '1492272000', '280', '1', null, null, null, null, null, null, null, null, null, '2', null);
INSERT INTO `renew` VALUES ('2', '461213435', '1431705600', '78', '1', '1463328000', '78', '1', '1494864000', '78', '1', null, null, null, '4', null);
INSERT INTO `renew` VALUES ('3', '2222222', '1494864000', '350', '1', null, null, null, null, null, null, null, null, null, '2', null);
INSERT INTO `renew` VALUES ('4', '123', '1494864000', '210', '1', null, null, null, null, null, null, null, null, null, '2', null);
INSERT INTO `renew` VALUES ('6', null, '4', '4456', null, '45', '456', '1', '456', '456', '1', '456', '456', '1', null, null);
INSERT INTO `renew` VALUES ('7', null, '4', '4456', null, '45', '456', '1', '456', '456', '1', '456', '456', '1', null, null);
INSERT INTO `renew` VALUES ('8', null, '2017', '4456', null, '45', '456', '1', '456', '456', '1', '456', '456', '1', null, null);
INSERT INTO `renew` VALUES ('17', '101010', '1492621261', null, '1', null, null, null, null, null, null, null, null, null, '2', null);
INSERT INTO `renew` VALUES ('18', '111111', '1492621261', null, '1', null, null, null, null, null, null, null, null, null, '2', null);
INSERT INTO `renew` VALUES ('19', '121212', '1492621261', null, '1', '1492621261', null, '1', null, null, null, null, null, null, '3', null);
INSERT INTO `renew` VALUES ('20', '131313', '1492621261', null, '1', '1492621261', null, '1', null, null, null, null, null, null, '3', null);
INSERT INTO `renew` VALUES ('21', '141414', '1492621261', null, '1', '1492621261', null, '1', null, null, null, null, null, null, '3', null);
INSERT INTO `renew` VALUES ('22', '151515', '1492621261', null, '1', '1492621261', null, '1', null, null, null, null, null, null, '3', null);
INSERT INTO `renew` VALUES ('23', '161616', '1492621261', null, '1', null, null, null, null, null, null, null, null, null, '2', null);
INSERT INTO `renew` VALUES ('24', '171717', '1492621261', null, '1', null, null, null, null, null, null, null, null, null, '2', null);
INSERT INTO `renew` VALUES ('25', '181818', '1492621261', null, '1', null, null, null, null, null, null, null, null, null, '2', null);
INSERT INTO `renew` VALUES ('26', '191919', '1492621261', null, '1', null, null, null, null, null, null, null, null, null, '2', null);
INSERT INTO `renew` VALUES ('27', '202020', '1492621261', null, '1', '1492621261', null, '1', null, null, null, null, null, null, '3', null);
INSERT INTO `renew` VALUES ('28', '222222', '1492621261', null, '1', '1492621261', null, '1', '1492621261', null, '1', null, null, null, '4', null);
INSERT INTO `renew` VALUES ('29', '232323', '1492621261', null, '1', '1492621261', null, '1', '1492621261', null, '1', null, null, null, '4', null);
INSERT INTO `renew` VALUES ('30', '242424', '1492621261', null, '1', '1492621261', null, '1', null, null, null, null, null, null, '3', null);
INSERT INTO `renew` VALUES ('31', '252525', '1492621261', null, '1', null, null, null, null, null, null, null, null, null, '2', null);
INSERT INTO `renew` VALUES ('32', '262626', '1492621261', null, '1', null, null, null, null, null, null, null, null, null, '2', null);
INSERT INTO `renew` VALUES ('33', '272727', '1492621261', null, '1', '1492621261', null, '1', '1492621261', null, '1', '1492621261', null, '1', '3', null);

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
-- Records of renewal_detail
-- ----------------------------

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
-- Records of service_fee_calculation
-- ----------------------------
INSERT INTO `service_fee_calculation` VALUES ('1', '2147483647', null, null, null, '8.00', '160.00', '2940.00', null, null, null, '-18.00', '0.00', '150.00', '2940.00', '3108.00', '150.00', null, '1', '1', '1490976000', '1496218239');
INSERT INTO `service_fee_calculation` VALUES ('2', '2147483647', null, null, null, '24.00', '155.00', '1950.00', null, null, null, '10.00', '0.00', '189.00', '1950.00', '2129.00', '189.00', null, '1', '1', '1490976000', '1496218239');
INSERT INTO `service_fee_calculation` VALUES ('3', '2147483647', null, null, null, '192.00', '200.40', '1950.00', null, null, null, '25.00', '0.00', '417.40', '1950.00', '2342.40', '417.40', null, '1', '1', '1490976000', '1496218239');
INSERT INTO `service_fee_calculation` VALUES ('4', '2147483647', null, null, null, '120.00', '185.50', '1950.00', null, null, null, '-30.00', '0.00', '275.50', '1950.00', '2255.50', '275.50', null, '1', '1', '1490976000', '1496218239');
INSERT INTO `service_fee_calculation` VALUES ('5', '2147483647', null, null, null, '8.00', '160.00', '2940.00', null, null, null, '-18.00', '0.00', '150.00', '2940.00', '3108.00', '150.00', null, '1', '1', '1493568000', '1496282318');
INSERT INTO `service_fee_calculation` VALUES ('6', '2147483647', null, null, null, '24.00', '155.00', '1950.00', null, null, null, '10.00', '0.00', '189.00', '1950.00', '2129.00', '189.00', null, '1', '1', '1493568000', '1496282318');
INSERT INTO `service_fee_calculation` VALUES ('7', '2147483647', null, null, null, '192.00', '200.40', '1950.00', null, null, null, '25.00', '0.00', '417.40', '1950.00', '2342.40', '417.40', null, '1', '1', '1493568000', '1496282318');
INSERT INTO `service_fee_calculation` VALUES ('8', '2147483647', null, null, null, '120.00', '185.50', '1950.00', null, null, null, '-30.00', '0.00', '275.50', '1950.00', '2255.50', '275.50', null, '1', '1', '1493568000', '1496282318');
INSERT INTO `service_fee_calculation` VALUES ('9', '1001', null, null, null, '500.25', '123.26', '78.56', '90.23', '123.60', '15.78', null, '215.00', '212.00', '8120.00', '8115.00', '121.00', '215.00', null, null, '1493568000', '1495209600');
INSERT INTO `service_fee_calculation` VALUES ('10', '1001', null, null, null, '1230.00', '364.52', '78.26', '99.18', '156.29', null, '-78.00', '52.00', '118.00', '2124.00', '125.00', '666.00', '78.00', null, null, '1490976000', '1492617600');
INSERT INTO `service_fee_calculation` VALUES ('11', '1001', null, null, null, '5151.00', '811.00', '1215.00', '15.00', '8121.00', '235.00', '585.00', '456.00', '4851.00', '845.00', '182.00', '156.00', '815.00', null, null, '1485878400', '1487520000');

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
-- Records of service_fee_config
-- ----------------------------
INSERT INTO `service_fee_config` VALUES ('0000000001', '7', '0.50', '0.58', '0.50', '0.40', '0.65', '0.60', '0.70');

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
-- Records of service_fee_policy
-- ----------------------------
INSERT INTO `service_fee_policy` VALUES ('1', '11', '11', '11', '11.00', '11', '11');
INSERT INTO `service_fee_policy` VALUES ('2', '5', '7519170512', '191919', '80.00', '1', '1496282748');
INSERT INTO `service_fee_policy` VALUES ('3', '6', '7521170516', '212121', '80.00', '1', '1496282748');
INSERT INTO `service_fee_policy` VALUES ('4', '7', '7523170516', '232323', '80.00', '1', '1496282748');
INSERT INTO `service_fee_policy` VALUES ('5', '7', '7523170516', '242424', '80.00', '1', '1496282748');
INSERT INTO `service_fee_policy` VALUES ('6', '7', '7523170516', '252525', '80.00', '1', '1496282748');
INSERT INTO `service_fee_policy` VALUES ('7', '7', '7523170516', '303030', '80.00', '1', '1496282748');
INSERT INTO `service_fee_policy` VALUES ('8', '7', '7523170516', '313131', '80.00', '1', '1496282748');
INSERT INTO `service_fee_policy` VALUES ('9', '7', '7523170516', '323232', '80.00', '1', '1496282748');
INSERT INTO `service_fee_policy` VALUES ('10', '8', '7526170516', '262626', '80.00', '1', '1496282748');
INSERT INTO `service_fee_policy` VALUES ('11', '8', '7526170516', '272727', '80.00', '1', '1496282748');
INSERT INTO `service_fee_policy` VALUES ('12', '8', '7526170516', '282828', '80.00', '1', '1496282748');
INSERT INTO `service_fee_policy` VALUES ('13', '5', '7519170512', '191919', '80.00', '1', '1496284254');
INSERT INTO `service_fee_policy` VALUES ('14', '6', '7521170516', '212121', '80.00', '1', '1496284254');
INSERT INTO `service_fee_policy` VALUES ('15', '7', '7523170516', '232323', '80.00', '1', '1496284254');
INSERT INTO `service_fee_policy` VALUES ('16', '7', '7523170516', '242424', '80.00', '1', '1496284254');
INSERT INTO `service_fee_policy` VALUES ('17', '7', '7523170516', '252525', '80.00', '1', '1496284254');
INSERT INTO `service_fee_policy` VALUES ('18', '7', '7523170516', '303030', '80.00', '1', '1496284254');
INSERT INTO `service_fee_policy` VALUES ('19', '7', '7523170516', '313131', '80.00', '1', '1496284254');
INSERT INTO `service_fee_policy` VALUES ('20', '7', '7523170516', '323232', '80.00', '1', '1496284254');
INSERT INTO `service_fee_policy` VALUES ('21', '8', '7526170516', '262626', '80.00', '1', '1496284254');
INSERT INTO `service_fee_policy` VALUES ('22', '8', '7526170516', '272727', '80.00', '1', '1496284254');
INSERT INTO `service_fee_policy` VALUES ('23', '8', '7526170516', '282828', '80.00', '1', '1496284254');
INSERT INTO `service_fee_policy` VALUES ('24', '5', '7519170512', '191919', '80.00', '1', '1496284618');
INSERT INTO `service_fee_policy` VALUES ('25', '6', '7521170516', '212121', '80.00', '1', '1496284618');
INSERT INTO `service_fee_policy` VALUES ('26', '7', '7523170516', '232323', '80.00', '1', '1496284618');
INSERT INTO `service_fee_policy` VALUES ('27', '7', '7523170516', '242424', '80.00', '1', '1496284618');
INSERT INTO `service_fee_policy` VALUES ('28', '7', '7523170516', '252525', '80.00', '1', '1496284618');
INSERT INTO `service_fee_policy` VALUES ('29', '7', '7523170516', '303030', '80.00', '1', '1496284618');
INSERT INTO `service_fee_policy` VALUES ('30', '7', '7523170516', '313131', '80.00', '1', '1496284618');
INSERT INTO `service_fee_policy` VALUES ('31', '7', '7523170516', '323232', '80.00', '1', '1496284618');
INSERT INTO `service_fee_policy` VALUES ('32', '8', '7526170516', '262626', '80.00', '1', '1496284618');
INSERT INTO `service_fee_policy` VALUES ('33', '8', '7526170516', '272727', '80.00', '1', '1496284618');
INSERT INTO `service_fee_policy` VALUES ('34', '8', '7526170516', '282828', '80.00', '1', '1496284618');
INSERT INTO `service_fee_policy` VALUES ('35', '5', '7519170512', '101010', '100.00', '1', '1496284618');
INSERT INTO `service_fee_policy` VALUES ('36', '5', '7519170512', '111111', '100.00', '1', '1496284618');
INSERT INTO `service_fee_policy` VALUES ('37', '5', '7519170512', '121212', '100.00', '1', '1496284618');
INSERT INTO `service_fee_policy` VALUES ('38', '5', '7519170512', '131313', '100.00', '1', '1496284618');
INSERT INTO `service_fee_policy` VALUES ('39', '6', '7521170516', '141414', '100.00', '1', '1496284618');
INSERT INTO `service_fee_policy` VALUES ('40', '6', '7521170516', '151515', '100.00', '1', '1496284618');
INSERT INTO `service_fee_policy` VALUES ('41', '6', '7521170516', '161616', '100.00', '1', '1496284618');
INSERT INTO `service_fee_policy` VALUES ('42', '6', '7521170516', '171717', '100.00', '1', '1496284618');
INSERT INTO `service_fee_policy` VALUES ('43', '7', '7523170516', '181818', '100.00', '1', '1496284618');
INSERT INTO `service_fee_policy` VALUES ('44', '7', '7523170516', '191919', '100.00', '1', '1496284618');
INSERT INTO `service_fee_policy` VALUES ('45', '7', '7523170516', '202020', '100.00', '1', '1496284618');
INSERT INTO `service_fee_policy` VALUES ('46', '7', '7523170516', '222222', '100.00', '1', '1496284618');
INSERT INTO `service_fee_policy` VALUES ('47', '8', '7526170516', '232323', '100.00', '1', '1496284618');
INSERT INTO `service_fee_policy` VALUES ('48', '8', '7526170516', '242424', '100.00', '1', '1496284618');
INSERT INTO `service_fee_policy` VALUES ('49', '8', '7526170516', '252525', '100.00', '1', '1496284618');
INSERT INTO `service_fee_policy` VALUES ('50', '8', '7526170516', '262626', '100.00', '1', '1496284618');
INSERT INTO `service_fee_policy` VALUES ('51', '8', '7526170516', '272727', '100.00', '1', '1496284618');
INSERT INTO `service_fee_policy` VALUES ('52', '7', '7523170516', '333333', '100.00', '1', '1496284618');
INSERT INTO `service_fee_policy` VALUES ('53', '7', '7523170516', '343434', '100.00', '1', '1496284618');
INSERT INTO `service_fee_policy` VALUES ('54', '8', '7526170516', '353535', '100.00', '1', '1496284618');
INSERT INTO `service_fee_policy` VALUES ('55', '8', '7526170516', '363636', '100.00', '1', '1496284618');
INSERT INTO `service_fee_policy` VALUES ('56', '6', '7521170516', '373737', '100.00', '1', '1496284618');
INSERT INTO `service_fee_policy` VALUES ('57', '6', '7521170516', '383838', '100.00', '1', '1496284618');
INSERT INTO `service_fee_policy` VALUES ('58', '5', '7519170512', '393939', '100.00', '1', '1496284618');
INSERT INTO `service_fee_policy` VALUES ('59', '5', '7519170512', '727272', '100.00', '1', '1496284618');
INSERT INTO `service_fee_policy` VALUES ('60', '5', '7519170512', '737373', '100.00', '1', '1496284618');
INSERT INTO `service_fee_policy` VALUES ('61', '5', '7519170512', '191919', '80.00', '1', '1496284677');
INSERT INTO `service_fee_policy` VALUES ('62', '6', '7521170516', '212121', '80.00', '1', '1496284677');
INSERT INTO `service_fee_policy` VALUES ('63', '7', '7523170516', '232323', '80.00', '1', '1496284677');
INSERT INTO `service_fee_policy` VALUES ('64', '7', '7523170516', '242424', '80.00', '1', '1496284677');
INSERT INTO `service_fee_policy` VALUES ('65', '7', '7523170516', '252525', '80.00', '1', '1496284677');
INSERT INTO `service_fee_policy` VALUES ('66', '7', '7523170516', '303030', '80.00', '1', '1496284677');
INSERT INTO `service_fee_policy` VALUES ('67', '7', '7523170516', '313131', '80.00', '1', '1496284677');
INSERT INTO `service_fee_policy` VALUES ('68', '7', '7523170516', '323232', '80.00', '1', '1496284677');
INSERT INTO `service_fee_policy` VALUES ('69', '8', '7526170516', '262626', '80.00', '1', '1496284677');
INSERT INTO `service_fee_policy` VALUES ('70', '8', '7526170516', '272727', '80.00', '1', '1496284677');
INSERT INTO `service_fee_policy` VALUES ('71', '8', '7526170516', '282828', '80.00', '1', '1496284677');
INSERT INTO `service_fee_policy` VALUES ('72', '5', '7519170512', '101010', '100.00', '1', '1496284677');
INSERT INTO `service_fee_policy` VALUES ('73', '5', '7519170512', '111111', '100.00', '1', '1496284677');
INSERT INTO `service_fee_policy` VALUES ('74', '5', '7519170512', '121212', '100.00', '1', '1496284677');
INSERT INTO `service_fee_policy` VALUES ('75', '5', '7519170512', '131313', '100.00', '1', '1496284677');
INSERT INTO `service_fee_policy` VALUES ('76', '6', '7521170516', '141414', '100.00', '1', '1496284677');
INSERT INTO `service_fee_policy` VALUES ('77', '6', '7521170516', '151515', '100.00', '1', '1496284677');
INSERT INTO `service_fee_policy` VALUES ('78', '6', '7521170516', '161616', '100.00', '1', '1496284677');
INSERT INTO `service_fee_policy` VALUES ('79', '6', '7521170516', '171717', '100.00', '1', '1496284677');
INSERT INTO `service_fee_policy` VALUES ('80', '7', '7523170516', '181818', '100.00', '1', '1496284677');
INSERT INTO `service_fee_policy` VALUES ('81', '7', '7523170516', '191919', '100.00', '1', '1496284677');
INSERT INTO `service_fee_policy` VALUES ('82', '7', '7523170516', '202020', '100.00', '1', '1496284677');
INSERT INTO `service_fee_policy` VALUES ('83', '7', '7523170516', '222222', '100.00', '1', '1496284677');
INSERT INTO `service_fee_policy` VALUES ('84', '8', '7526170516', '232323', '100.00', '1', '1496284677');
INSERT INTO `service_fee_policy` VALUES ('85', '8', '7526170516', '242424', '100.00', '1', '1496284677');
INSERT INTO `service_fee_policy` VALUES ('86', '8', '7526170516', '252525', '100.00', '1', '1496284677');
INSERT INTO `service_fee_policy` VALUES ('87', '8', '7526170516', '262626', '100.00', '1', '1496284677');
INSERT INTO `service_fee_policy` VALUES ('88', '8', '7526170516', '272727', '100.00', '1', '1496284677');
INSERT INTO `service_fee_policy` VALUES ('89', '7', '7523170516', '333333', '100.00', '1', '1496284677');
INSERT INTO `service_fee_policy` VALUES ('90', '7', '7523170516', '343434', '100.00', '1', '1496284677');
INSERT INTO `service_fee_policy` VALUES ('91', '8', '7526170516', '353535', '100.00', '1', '1496284677');
INSERT INTO `service_fee_policy` VALUES ('92', '8', '7526170516', '363636', '100.00', '1', '1496284677');
INSERT INTO `service_fee_policy` VALUES ('93', '6', '7521170516', '373737', '100.00', '1', '1496284677');
INSERT INTO `service_fee_policy` VALUES ('94', '6', '7521170516', '383838', '100.00', '1', '1496284677');
INSERT INTO `service_fee_policy` VALUES ('95', '5', '7519170512', '393939', '100.00', '1', '1496284677');
INSERT INTO `service_fee_policy` VALUES ('96', '5', '7519170512', '727272', '100.00', '1', '1496284677');
INSERT INTO `service_fee_policy` VALUES ('97', '5', '7519170512', '737373', '100.00', '1', '1496284677');
INSERT INTO `service_fee_policy` VALUES ('98', '5', '7519170512', '191919', '80.00', '1', '1496285204');
INSERT INTO `service_fee_policy` VALUES ('99', '6', '7521170516', '212121', '80.00', '1', '1496285204');
INSERT INTO `service_fee_policy` VALUES ('100', '7', '7523170516', '232323', '80.00', '1', '1496285204');
INSERT INTO `service_fee_policy` VALUES ('101', '7', '7523170516', '242424', '80.00', '1', '1496285204');
INSERT INTO `service_fee_policy` VALUES ('102', '7', '7523170516', '252525', '80.00', '1', '1496285204');
INSERT INTO `service_fee_policy` VALUES ('103', '7', '7523170516', '303030', '80.00', '1', '1496285204');
INSERT INTO `service_fee_policy` VALUES ('104', '7', '7523170516', '313131', '80.00', '1', '1496285204');
INSERT INTO `service_fee_policy` VALUES ('105', '7', '7523170516', '323232', '80.00', '1', '1496285204');
INSERT INTO `service_fee_policy` VALUES ('106', '8', '7526170516', '262626', '80.00', '1', '1496285204');
INSERT INTO `service_fee_policy` VALUES ('107', '8', '7526170516', '272727', '80.00', '1', '1496285204');
INSERT INTO `service_fee_policy` VALUES ('108', '8', '7526170516', '282828', '80.00', '1', '1496285204');
INSERT INTO `service_fee_policy` VALUES ('109', '5', '7519170512', '101010', '100.00', '1', '1496285204');
INSERT INTO `service_fee_policy` VALUES ('110', '5', '7519170512', '111111', '100.00', '1', '1496285204');
INSERT INTO `service_fee_policy` VALUES ('111', '5', '7519170512', '121212', '100.00', '1', '1496285204');
INSERT INTO `service_fee_policy` VALUES ('112', '5', '7519170512', '131313', '100.00', '1', '1496285204');
INSERT INTO `service_fee_policy` VALUES ('113', '6', '7521170516', '141414', '100.00', '1', '1496285204');
INSERT INTO `service_fee_policy` VALUES ('114', '6', '7521170516', '151515', '100.00', '1', '1496285204');
INSERT INTO `service_fee_policy` VALUES ('115', '6', '7521170516', '161616', '100.00', '1', '1496285204');
INSERT INTO `service_fee_policy` VALUES ('116', '6', '7521170516', '171717', '100.00', '1', '1496285204');
INSERT INTO `service_fee_policy` VALUES ('117', '7', '7523170516', '181818', '100.00', '1', '1496285204');
INSERT INTO `service_fee_policy` VALUES ('118', '7', '7523170516', '191919', '100.00', '1', '1496285204');
INSERT INTO `service_fee_policy` VALUES ('119', '7', '7523170516', '202020', '100.00', '1', '1496285204');
INSERT INTO `service_fee_policy` VALUES ('120', '7', '7523170516', '222222', '100.00', '1', '1496285204');
INSERT INTO `service_fee_policy` VALUES ('121', '8', '7526170516', '232323', '100.00', '1', '1496285204');
INSERT INTO `service_fee_policy` VALUES ('122', '8', '7526170516', '242424', '100.00', '1', '1496285204');
INSERT INTO `service_fee_policy` VALUES ('123', '8', '7526170516', '252525', '100.00', '1', '1496285204');
INSERT INTO `service_fee_policy` VALUES ('124', '8', '7526170516', '262626', '100.00', '1', '1496285204');
INSERT INTO `service_fee_policy` VALUES ('125', '8', '7526170516', '272727', '100.00', '1', '1496285204');
INSERT INTO `service_fee_policy` VALUES ('126', '7', '7523170516', '333333', '100.00', '1', '1496285204');
INSERT INTO `service_fee_policy` VALUES ('127', '7', '7523170516', '343434', '100.00', '1', '1496285204');
INSERT INTO `service_fee_policy` VALUES ('128', '8', '7526170516', '353535', '100.00', '1', '1496285204');
INSERT INTO `service_fee_policy` VALUES ('129', '8', '7526170516', '363636', '100.00', '1', '1496285204');
INSERT INTO `service_fee_policy` VALUES ('130', '6', '7521170516', '373737', '100.00', '1', '1496285204');
INSERT INTO `service_fee_policy` VALUES ('131', '6', '7521170516', '383838', '100.00', '1', '1496285204');
INSERT INTO `service_fee_policy` VALUES ('132', '5', '7519170512', '393939', '100.00', '1', '1496285204');
INSERT INTO `service_fee_policy` VALUES ('133', '5', '7519170512', '727272', '100.00', '1', '1496285204');
INSERT INTO `service_fee_policy` VALUES ('134', '5', '7519170512', '737373', '100.00', '1', '1496285204');
INSERT INTO `service_fee_policy` VALUES ('135', '5', '7519170512', '191919', '80.00', '1', '1496285427');
INSERT INTO `service_fee_policy` VALUES ('136', '6', '7521170516', '212121', '80.00', '1', '1496285427');
INSERT INTO `service_fee_policy` VALUES ('137', '7', '7523170516', '232323', '80.00', '1', '1496285427');
INSERT INTO `service_fee_policy` VALUES ('138', '7', '7523170516', '242424', '80.00', '1', '1496285427');
INSERT INTO `service_fee_policy` VALUES ('139', '7', '7523170516', '252525', '80.00', '1', '1496285427');
INSERT INTO `service_fee_policy` VALUES ('140', '7', '7523170516', '303030', '80.00', '1', '1496285427');
INSERT INTO `service_fee_policy` VALUES ('141', '7', '7523170516', '313131', '80.00', '1', '1496285427');
INSERT INTO `service_fee_policy` VALUES ('142', '7', '7523170516', '323232', '80.00', '1', '1496285427');
INSERT INTO `service_fee_policy` VALUES ('143', '8', '7526170516', '262626', '80.00', '1', '1496285427');
INSERT INTO `service_fee_policy` VALUES ('144', '8', '7526170516', '272727', '80.00', '1', '1496285427');
INSERT INTO `service_fee_policy` VALUES ('145', '8', '7526170516', '282828', '80.00', '1', '1496285427');
INSERT INTO `service_fee_policy` VALUES ('146', '5', '7519170512', '101010', '100.00', '1', '1496285427');
INSERT INTO `service_fee_policy` VALUES ('147', '5', '7519170512', '111111', '100.00', '1', '1496285427');
INSERT INTO `service_fee_policy` VALUES ('148', '5', '7519170512', '121212', '100.00', '1', '1496285427');
INSERT INTO `service_fee_policy` VALUES ('149', '5', '7519170512', '131313', '100.00', '1', '1496285427');
INSERT INTO `service_fee_policy` VALUES ('150', '6', '7521170516', '141414', '100.00', '1', '1496285427');
INSERT INTO `service_fee_policy` VALUES ('151', '6', '7521170516', '151515', '100.00', '1', '1496285427');
INSERT INTO `service_fee_policy` VALUES ('152', '6', '7521170516', '161616', '100.00', '1', '1496285427');
INSERT INTO `service_fee_policy` VALUES ('153', '6', '7521170516', '171717', '100.00', '1', '1496285427');
INSERT INTO `service_fee_policy` VALUES ('154', '7', '7523170516', '181818', '100.00', '1', '1496285427');
INSERT INTO `service_fee_policy` VALUES ('155', '7', '7523170516', '191919', '100.00', '1', '1496285427');
INSERT INTO `service_fee_policy` VALUES ('156', '7', '7523170516', '202020', '100.00', '1', '1496285427');
INSERT INTO `service_fee_policy` VALUES ('157', '7', '7523170516', '222222', '100.00', '1', '1496285427');
INSERT INTO `service_fee_policy` VALUES ('158', '8', '7526170516', '232323', '100.00', '1', '1496285427');
INSERT INTO `service_fee_policy` VALUES ('159', '8', '7526170516', '242424', '100.00', '1', '1496285427');
INSERT INTO `service_fee_policy` VALUES ('160', '8', '7526170516', '252525', '100.00', '1', '1496285427');
INSERT INTO `service_fee_policy` VALUES ('161', '8', '7526170516', '262626', '100.00', '1', '1496285427');
INSERT INTO `service_fee_policy` VALUES ('162', '8', '7526170516', '272727', '100.00', '1', '1496285427');
INSERT INTO `service_fee_policy` VALUES ('163', '7', '7523170516', '333333', '100.00', '1', '1496285427');
INSERT INTO `service_fee_policy` VALUES ('164', '7', '7523170516', '343434', '100.00', '1', '1496285427');
INSERT INTO `service_fee_policy` VALUES ('165', '8', '7526170516', '353535', '100.00', '1', '1496285427');
INSERT INTO `service_fee_policy` VALUES ('166', '8', '7526170516', '363636', '100.00', '1', '1496285427');
INSERT INTO `service_fee_policy` VALUES ('167', '6', '7521170516', '373737', '100.00', '1', '1496285427');
INSERT INTO `service_fee_policy` VALUES ('168', '6', '7521170516', '383838', '100.00', '1', '1496285427');
INSERT INTO `service_fee_policy` VALUES ('169', '5', '7519170512', '393939', '100.00', '1', '1496285427');
INSERT INTO `service_fee_policy` VALUES ('170', '5', '7519170512', '727272', '100.00', '1', '1496285427');
INSERT INTO `service_fee_policy` VALUES ('171', '5', '7519170512', '737373', '100.00', '1', '1496285427');

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
-- Records of settlement_initial_fee_industry_bonus_proportion
-- ----------------------------
INSERT INTO `settlement_initial_fee_industry_bonus_proportion` VALUES ('5', '20', '3000', '4000', '1000');

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
-- Records of settlement_management
-- ----------------------------

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='非寿险业务奖金表 \r\n规模保费对应奖金数\r\n李杨';

-- ----------------------------
-- Records of settlement_non_life_insurance_premium
-- ----------------------------

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
-- Records of settlement_renewal_contract
-- ----------------------------
INSERT INTO `settlement_renewal_contract` VALUES ('1', '6', '20', '2', '1', '0.80', '1', '1493600000');
INSERT INTO `settlement_renewal_contract` VALUES ('2', '6', '20', '2', '1', '0.79', '2', '1493600000');
INSERT INTO `settlement_renewal_contract` VALUES ('3', '6', '20', '2', '1', '0.78', '3', '1493600000');
INSERT INTO `settlement_renewal_contract` VALUES ('4', '6', '20', '2', '1', '0.75', '4', '1493600000');
INSERT INTO `settlement_renewal_contract` VALUES ('5', '6', '20', '2', '1', '0.70', '5', '1493600000');
INSERT INTO `settlement_renewal_contract` VALUES ('6', '6', '20', '2', '2', '0.85', '1', '1493600000');
INSERT INTO `settlement_renewal_contract` VALUES ('7', '6', '20', '2', '2', '0.84', '2', '1493600000');
INSERT INTO `settlement_renewal_contract` VALUES ('8', '6', '20', '2', '2', '0.83', '3', '1493600000');
INSERT INTO `settlement_renewal_contract` VALUES ('9', '6', '20', '2', '2', '0.82', '4', '1493600000');
INSERT INTO `settlement_renewal_contract` VALUES ('10', '6', '20', '2', '2', '0.81', '5', '1493600000');
INSERT INTO `settlement_renewal_contract` VALUES ('11', '6', '20', '2', '3', '0.90', '1', '1493600000');
INSERT INTO `settlement_renewal_contract` VALUES ('12', '6', '20', '2', '3', '0.89', '2', '1493600000');
INSERT INTO `settlement_renewal_contract` VALUES ('13', '6', '20', '2', '3', '0.88', '3', '1493600000');
INSERT INTO `settlement_renewal_contract` VALUES ('14', '6', '20', '2', '3', '0.87', '4', '1493600000');
INSERT INTO `settlement_renewal_contract` VALUES ('15', '6', '20', '2', '3', '0.86', '5', '1493600000');
INSERT INTO `settlement_renewal_contract` VALUES ('16', '27', '23', '1', '1', '0.50', '5', '1495872678');
INSERT INTO `settlement_renewal_contract` VALUES ('17', '27', '23', '1', '2', '0.30', '5', '1495872706');
INSERT INTO `settlement_renewal_contract` VALUES ('18', '27', '23', '1', '3', '0.20', '5', '1495872718');
INSERT INTO `settlement_renewal_contract` VALUES ('19', '27', '23', '1', '4', '0.10', '5', '1495872731');
INSERT INTO `settlement_renewal_contract` VALUES ('20', '27', '23', '1', '5', '0.10', '5', '1495873767');
INSERT INTO `settlement_renewal_contract` VALUES ('21', '27', '23', '1', '1', '0.50', '10', '1495874178');
INSERT INTO `settlement_renewal_contract` VALUES ('22', '27', '23', '1', '1', '0.80', '10', '1495874232');
INSERT INTO `settlement_renewal_contract` VALUES ('23', '27', '23', '1', '2', '0.60', '10', '1495874254');
INSERT INTO `settlement_renewal_contract` VALUES ('24', '27', '23', '1', '3', '0.50', '10', '1495874268');
INSERT INTO `settlement_renewal_contract` VALUES ('25', '27', '23', '1', '4', '0.40', '10', '1495874281');
INSERT INTO `settlement_renewal_contract` VALUES ('26', '27', '23', '1', '4', '0.50', '10', '1495874296');
INSERT INTO `settlement_renewal_contract` VALUES ('27', '28', '23', '1', '1', '0.50', '5', '1495874341');
INSERT INTO `settlement_renewal_contract` VALUES ('28', '28', '23', '1', '2', '0.45', '5', '1495874357');
INSERT INTO `settlement_renewal_contract` VALUES ('29', '28', '23', '1', '3', '0.40', '5', '1495874371');
INSERT INTO `settlement_renewal_contract` VALUES ('30', '28', '23', '1', '4', '0.33', '5', '1495874386');
INSERT INTO `settlement_renewal_contract` VALUES ('31', '28', '23', '1', '1', '0.50', '10', '1495874406');
INSERT INTO `settlement_renewal_contract` VALUES ('32', '28', '23', '1', '2', '0.48', '10', '1495874419');
INSERT INTO `settlement_renewal_contract` VALUES ('33', '28', '23', '1', '3', '0.45', '10', '1495874429');
INSERT INTO `settlement_renewal_contract` VALUES ('34', '28', '23', '1', '4', '0.40', '10', '1495874440');
INSERT INTO `settlement_renewal_contract` VALUES ('35', '29', '23', '1', '1', '0.50', '5', '1495874473');
INSERT INTO `settlement_renewal_contract` VALUES ('36', '29', '23', '1', '2', '0.30', '5', '1495874486');
INSERT INTO `settlement_renewal_contract` VALUES ('37', '29', '23', '1', '3', '0.28', '5', '1495874497');
INSERT INTO `settlement_renewal_contract` VALUES ('38', '29', '23', '1', '4', '0.26', '5', '1495874508');
INSERT INTO `settlement_renewal_contract` VALUES ('39', '29', '23', '1', '1', '0.66', '10', '1495874529');
INSERT INTO `settlement_renewal_contract` VALUES ('40', '29', '23', '1', '2', '0.60', '10', '1495874542');
INSERT INTO `settlement_renewal_contract` VALUES ('41', '29', '23', '1', '3', '0.50', '10', '1495874557');
INSERT INTO `settlement_renewal_contract` VALUES ('42', '29', '23', '1', '4', '0.40', '10', '1495874570');
INSERT INTO `settlement_renewal_contract` VALUES ('43', '30', '23', '1', '1', '0.40', '5', '1495874607');
INSERT INTO `settlement_renewal_contract` VALUES ('44', '30', '23', '1', '2', '0.38', '5', '1495874630');
INSERT INTO `settlement_renewal_contract` VALUES ('45', '30', '23', '1', '3', '0.36', '5', '1495874639');
INSERT INTO `settlement_renewal_contract` VALUES ('46', '30', '23', '1', '4', '0.30', '5', '1495874649');
INSERT INTO `settlement_renewal_contract` VALUES ('47', '30', '23', '1', '1', '0.89', '10', '1495874665');
INSERT INTO `settlement_renewal_contract` VALUES ('48', '30', '23', '1', '2', '0.80', '10', '1495874681');
INSERT INTO `settlement_renewal_contract` VALUES ('49', '30', '23', '1', '3', '0.69', '10', '1495874693');
INSERT INTO `settlement_renewal_contract` VALUES ('50', '30', '23', '1', '4', '0.50', '10', '1495874704');

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
-- Records of settlement_renewal_fee_rate
-- ----------------------------
INSERT INTO `settlement_renewal_fee_rate` VALUES ('1', '6', '1', '1', '0.10', '0.60', '0.50', '1493568000');
INSERT INTO `settlement_renewal_fee_rate` VALUES ('2', '6', '1', '1', '0.60', '1.00', '0.55', '1493568000');
INSERT INTO `settlement_renewal_fee_rate` VALUES ('3', '6', '1', '2', '0.10', '0.60', '0.60', '1493568000');
INSERT INTO `settlement_renewal_fee_rate` VALUES ('4', '6', '1', '2', '0.60', '1.00', '0.65', '1493568000');
INSERT INTO `settlement_renewal_fee_rate` VALUES ('5', '6', '1', '3', '0.10', '0.60', '0.70', '1493568000');
INSERT INTO `settlement_renewal_fee_rate` VALUES ('6', '6', '1', '3', '0.60', '1.00', '0.75', '1493568000');
INSERT INTO `settlement_renewal_fee_rate` VALUES ('7', '6', '1', '4', '0.10', '0.60', '0.80', '1493568000');
INSERT INTO `settlement_renewal_fee_rate` VALUES ('8', '6', '1', '4', '0.60', '1.00', '0.90', '1493568000');
INSERT INTO `settlement_renewal_fee_rate` VALUES ('9', '6', '1', '5', '0.10', '0.60', '0.95', '1493568000');
INSERT INTO `settlement_renewal_fee_rate` VALUES ('10', '6', '1', '5', '0.60', '1.00', '1.00', '1493568000');
INSERT INTO `settlement_renewal_fee_rate` VALUES ('11', '6', '2', '1', '0.10', '0.60', '0.30', '1493568000');
INSERT INTO `settlement_renewal_fee_rate` VALUES ('12', '6', '2', '1', '0.60', '1.00', '0.35', '1493568000');
INSERT INTO `settlement_renewal_fee_rate` VALUES ('13', '6', '2', '2', '0.10', '0.60', '0.40', '1493568000');
INSERT INTO `settlement_renewal_fee_rate` VALUES ('14', '6', '2', '2', '0.60', '1.00', '0.45', '1493568000');
INSERT INTO `settlement_renewal_fee_rate` VALUES ('15', '6', '2', '3', '0.10', '0.60', '0.50', '1493568000');
INSERT INTO `settlement_renewal_fee_rate` VALUES ('16', '6', '2', '3', '0.60', '1.00', '0.55', '1493568000');
INSERT INTO `settlement_renewal_fee_rate` VALUES ('17', '6', '2', '4', '0.10', '0.60', '0.60', '1493568000');
INSERT INTO `settlement_renewal_fee_rate` VALUES ('18', '6', '2', '4', '0.60', '1.00', '0.65', '1493568000');
INSERT INTO `settlement_renewal_fee_rate` VALUES ('19', '6', '2', '5', '0.10', '0.60', '0.70', '1493568000');
INSERT INTO `settlement_renewal_fee_rate` VALUES ('20', '6', '2', '5', '0.60', '1.00', '0.75', '1493568000');
INSERT INTO `settlement_renewal_fee_rate` VALUES ('21', '6', '3', '1', '0.10', '0.60', '0.25', '1493568000');
INSERT INTO `settlement_renewal_fee_rate` VALUES ('22', '6', '3', '1', '0.60', '1.00', '0.30', '1493568000');
INSERT INTO `settlement_renewal_fee_rate` VALUES ('23', '6', '3', '2', '0.10', '0.60', '0.35', '1493568000');
INSERT INTO `settlement_renewal_fee_rate` VALUES ('24', '6', '3', '2', '0.60', '1.00', '0.40', '1493568000');
INSERT INTO `settlement_renewal_fee_rate` VALUES ('25', '6', '3', '3', '0.10', '0.60', '0.45', '1493568000');
INSERT INTO `settlement_renewal_fee_rate` VALUES ('26', '6', '3', '3', '0.60', '1.00', '0.50', '1493568000');
INSERT INTO `settlement_renewal_fee_rate` VALUES ('27', '6', '3', '4', '0.10', '0.60', '0.55', '1493568000');
INSERT INTO `settlement_renewal_fee_rate` VALUES ('28', '6', '3', '4', '0.60', '1.00', '0.60', '1493568000');
INSERT INTO `settlement_renewal_fee_rate` VALUES ('29', '6', '3', '5', '0.10', '0.60', '0.65', '1493568000');
INSERT INTO `settlement_renewal_fee_rate` VALUES ('30', '6', '3', '5', '0.60', '1.00', '0.70', '1493568000');
INSERT INTO `settlement_renewal_fee_rate` VALUES ('31', '6', '4', '1', '0.10', '0.60', '0.20', '1493568000');
INSERT INTO `settlement_renewal_fee_rate` VALUES ('32', '6', '4', '1', '0.60', '1.00', '0.25', '1493568000');
INSERT INTO `settlement_renewal_fee_rate` VALUES ('33', '6', '4', '2', '0.10', '0.60', '0.30', '1493568000');
INSERT INTO `settlement_renewal_fee_rate` VALUES ('34', '6', '4', '2', '0.60', '1.00', '0.35', '1493568000');
INSERT INTO `settlement_renewal_fee_rate` VALUES ('35', '6', '4', '3', '0.10', '0.60', '0.40', '1493568000');
INSERT INTO `settlement_renewal_fee_rate` VALUES ('36', '6', '4', '3', '0.60', '1.00', '0.45', '1493568000');
INSERT INTO `settlement_renewal_fee_rate` VALUES ('37', '6', '4', '4', '0.10', '0.60', '0.50', '1493568000');
INSERT INTO `settlement_renewal_fee_rate` VALUES ('38', '6', '4', '4', '0.60', '1.00', '0.55', '1493568000');
INSERT INTO `settlement_renewal_fee_rate` VALUES ('39', '6', '4', '5', '0.10', '0.60', '0.60', '1493568000');
INSERT INTO `settlement_renewal_fee_rate` VALUES ('40', '6', '4', '5', '0.60', '1.00', '0.65', '1493568000');
INSERT INTO `settlement_renewal_fee_rate` VALUES ('41', '6', '5', '1', '0.10', '0.60', '0.10', '1493568000');
INSERT INTO `settlement_renewal_fee_rate` VALUES ('42', '6', '5', '1', '0.60', '1.00', '0.15', '1493568000');
INSERT INTO `settlement_renewal_fee_rate` VALUES ('43', '6', '5', '2', '0.10', '0.60', '0.20', '1493568000');
INSERT INTO `settlement_renewal_fee_rate` VALUES ('44', '6', '5', '2', '0.60', '1.00', '0.25', '1493568000');
INSERT INTO `settlement_renewal_fee_rate` VALUES ('45', '6', '5', '3', '0.10', '0.60', '0.30', '1493568000');
INSERT INTO `settlement_renewal_fee_rate` VALUES ('46', '6', '5', '3', '0.60', '1.00', '0.35', '1493568000');
INSERT INTO `settlement_renewal_fee_rate` VALUES ('47', '6', '5', '4', '0.10', '0.60', '0.40', '1493568000');
INSERT INTO `settlement_renewal_fee_rate` VALUES ('48', '6', '5', '4', '0.60', '1.00', '0.45', '1493568000');
INSERT INTO `settlement_renewal_fee_rate` VALUES ('49', '6', '5', '5', '0.10', '0.60', '0.50', '1493568000');
INSERT INTO `settlement_renewal_fee_rate` VALUES ('50', '6', '5', '5', '0.60', '1.00', '0.55', '1493568000');

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
-- Records of shop_apply
-- ----------------------------
INSERT INTO `shop_apply` VALUES ('1', '1004', '12335', '店铺1', '', '姓名1', '-28800', '1', '2', '2', '的减肥的快龙卷风', '听从分公司已经\n', '-28800', '-28800', '0');
INSERT INTO `shop_apply` VALUES ('2', '1002', '5465', '店铺2', '', '姓名2', '1494432000', '0', '1', '0', '分公司意见', '公公司意见', '1494432000', '1494432000', '0');
INSERT INTO `shop_apply` VALUES ('3', '1001', '132332', '店铺3', '', '姓名3', '1494432000', '1', '2', '2', '分公司意见', '总公司是ssddssqq啊啊所属', '1494432000', '1494432000', '0');

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
-- Records of shop_assess_standard
-- ----------------------------
INSERT INTO `shop_assess_standard` VALUES ('18', '1', '150000', null, null, '30', null, null, '0.80', '1', '1');
INSERT INTO `shop_assess_standard` VALUES ('19', '0', '90000', null, null, '30', null, null, '0.85', '1', '2');
INSERT INTO `shop_assess_standard` VALUES ('20', '0', '60000', null, null, '30', null, null, '0.85', '1', '3');
INSERT INTO `shop_assess_standard` VALUES ('21', '1', '300000', null, null, null, '180', null, '0.85', '2', '1');
INSERT INTO `shop_assess_standard` VALUES ('22', '1', '180000', null, null, null, '180', null, '0.85', '2', '2');
INSERT INTO `shop_assess_standard` VALUES ('23', '1', '120000', null, null, null, '180', null, '0.85', '2', '3');
INSERT INTO `shop_assess_standard` VALUES ('24', '0', '300000', null, null, '50', '500', '3', '0.85', '3', '1');
INSERT INTO `shop_assess_standard` VALUES ('25', '0', '180000', null, null, '50', '500', '3', '0.85', '3', '2');
INSERT INTO `shop_assess_standard` VALUES ('26', '0', '120000', null, null, '50', '500', '3', '0.85', '3', '3');
INSERT INTO `shop_assess_standard` VALUES ('27', '1', null, '90', '20', null, '500', '3', '0.85', '4', '1');
INSERT INTO `shop_assess_standard` VALUES ('28', '1', null, '48', '10', null, '500', '3', '0.85', '4', '2');
INSERT INTO `shop_assess_standard` VALUES ('29', '1', null, '30', '6', null, '500', '3', '0.85', '4', '3');

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
-- Records of study
-- ----------------------------
INSERT INTO `study` VALUES ('1', '测试', '123', '1', '1', '1', 'admin', '1', 'https://www.baidu.com', '0', '0', '1', 'admin', '1494902811', '1494922470', '1494916566');
INSERT INTO `study` VALUES ('2', '测试12', '但是苏打撒旦撒1', '2', '1', '1', 'admin', '1', 'https://www.baidu.com', '0', '', '1', 'admin', '1494899371', '1494922316', '1495788642');
INSERT INTO `study` VALUES ('3', '12321', '123', '1', '1', '1', 'admin', '1', 'http://www.baoxian.com', '0', '', '0', null, '1494902811', null, null);
INSERT INTO `study` VALUES ('4', '213123123', 'sdasdasd', '2', '1', '1', 'admin', '1', 'http://www.baoxian.com', '0', '', '0', null, '1494902886', null, null);
INSERT INTO `study` VALUES ('5', '小白测试', '为去问问企鹅我', '4', '1', '1', 'admin', '2', '', '0', 'UploadFile/20170516/591a921b09d11.docx', '0', null, '1494913563', null, null);
INSERT INTO `study` VALUES ('6', '123', '123', '1', '1', '1', 'admin', '2', '', '0', 'UploadFile/20170516/591a92cd31300.docx', '1', 'admin', '1494913741', '1495789546', null);
INSERT INTO `study` VALUES ('7', '123', '123啊实打实的法定', '1', '1', '1', 'admin', '2', '', '0', 'UploadFile/20170516/591a92fc282dc.docx', '1', 'admin', '1494913788', '1495789552', '1495868828');
INSERT INTO `study` VALUES ('8', '反反复复', '12312', '3', '1', '1', 'admin', '2', '', '0', 'UploadFile/20170516/591a931316468.docx', '1', null, '1494913811', null, null);
INSERT INTO `study` VALUES ('9', '测试(URL)', 'a啊大苏打岁的大手大脚海关监管', '3', '1', '1', 'admin', '1', 'http://www.baoxian.com', '0', null, '1', null, '1494914213', null, null);
INSERT INTO `study` VALUES ('10', '测试(文件)', '阿斯顿撒旦', '1', '1', '1', 'admin', '2', '', '0', 'UploadFile/20170516/591a95ec6c584.docx', '1', 'admin', '1494914540', '1495869603', null);
INSERT INTO `study` VALUES ('11', '测试(文件)1', '啊实打实的', '2', '1', '1', 'admin', '2', '', '0', 'UploadFile/20170516/591a9624db6f1.docx', '1', 'admin', '1494914596', '1495869220', null);
INSERT INTO `study` VALUES ('12', '测试22', '啊送达司法所', '4', '1', '1', 'admin', '1', 'http://www.baoxian.com', '0', null, '1', 'admin', '1494914679', '1495789558', '1495857343');
INSERT INTO `study` VALUES ('13', '测试(文件)3', '1啊实打实打算阿斯顿阿三', '2', '1', '1', 'admin', '2', '', '0', 'UploadFile/20170516/591a9677bd103.docx', '1', 'admin', '1494914803', '1494922781', '1495868300');
INSERT INTO `study` VALUES ('14', '大飞哥', '阿斯打死', '4', '1', '1', 'admin', '2', '', '0', 'UploadFile/20170516/591ab76247b3b.docx', '1', 'admin', '1494923106', '1495869211', null);
INSERT INTO `study` VALUES ('15', '哈哈岁的', '萨顶哈计算的话', '1', '1', '1', 'admin', '2', '', '0', 'UploadFile/20170516/591ab81f3e41e.docx', '1', 'admin', '1494923295', '1494923295', null);
INSERT INTO `study` VALUES ('16', '123', '123', '2', '1', '1', 'admin', '2', '', '0', 'Supplier/20170522/5922b401467c1.docx', '1', 'admin', '1495446529', '1495446529', null);
INSERT INTO `study` VALUES ('17', '实打实的', '撒旦', '2', '1', '1', 'admin', '2', '', '0', 'Supplier/20170522/5922b435744c0.docx', '1', 'admin', '1495446581', '1495446581', null);

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
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8 COMMENT='供应商表（景）';

-- ----------------------------
-- Records of supplier
-- ----------------------------
INSERT INTO `supplier` VALUES ('20', 'DAHUTQ', '人寿', '1', '中国人寿', '河北分公司', '3', '123456789', '/Upload\\Supplier/2017-06-01/592fb8366b748.jpg', '阿斯顿', '18231981027', 'https://www.baidu.com', '阿斯顿', '18231981027', '621700013000073757', '工商银行', '史蒂夫', 'where方法的用法是ThikPHP查询语言的精髓，也是ThinkPHP ORM的重要组成部分和亮点所在，可以完成包括普通查询、表达式查询、快捷查询、区间查询、组合查询在内的查询操作。where', '1494225095', '62', '63', '75');
INSERT INTO `supplier` VALUES ('21', 'MQKOYN', '的双方各', '1', '大飞哥', '河北分公司', '2', '123456789', '/Upload\\Supplier/2017-06-01/592fb86c80c3a.jpg', '大飞哥', '18231981027', 'https://www.baidu.com', '双方各', '18231981027', '62164616546321', '史蒂夫', '是大法官', '双方各双方公司股份', '1494318024', '1', '2', '7');
INSERT INTO `supplier` VALUES ('23', 'KLYPMU', '人寿', '1', '人寿', '河北分公司', '1', '123456789', '/Uploads\\Supplier/2017-05-09/5911ab80377a0.jpg', '东三省', '18231981027', 'https://www.baidu.com', '史蒂夫', '18231981027', '313246513215', '建行', '手动阀', '少时诵诗书所所所所所所所所所所所所', '1494330241', '21', '22', '26');
INSERT INTO `supplier` VALUES ('24', 'DBKLNW', '手动阀', '1', '手动阀', '河北分公司', '1', '123456789', '/Uploads\\Supplier/2017-05-10/5912665a18155.jpg', '爽肤水', '18231981027', 'https://www.baidu.com', '手动阀', '18231981027', '62176521632165', '手动阀', '手动阀', '所得到的多多多多多多', '1494377805', '62', '63', '70');
INSERT INTO `supplier` VALUES ('69', 'QRIYHL', '是是是', '1', '所属', '河北分公司', '1', '123456789', '/Uploads\\Supplier/2017-05-09/5911b5cfaa00e.jpg', '对对对', '18231981027', 'https://www.baidu.com', '是的是的', '18231981027', '6217000130566132', '时代大厦', '是多少', '的点点滴滴多多多多', '1494482891', '104', '125', '129');

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
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8 COMMENT='考试题库内容答案表---赵';

-- ----------------------------
-- Records of test_answer
-- ----------------------------
INSERT INTO `test_answer` VALUES ('64', '72', '82', 'A', '1495080187');
INSERT INTO `test_answer` VALUES ('65', '72', '80', 'B', '1495080187');
INSERT INTO `test_answer` VALUES ('66', '72', '81', 'C', '1495080187');
INSERT INTO `test_answer` VALUES ('67', '72', '83', 'D', '1495080187');
INSERT INTO `test_answer` VALUES ('68', '73', '1', 'A', '1495519943');
INSERT INTO `test_answer` VALUES ('69', '73', '4', 'B', '1495519943');
INSERT INTO `test_answer` VALUES ('70', '73', '5', 'C', '1495519943');
INSERT INTO `test_answer` VALUES ('71', '73', '3', 'D', '1495519943');
INSERT INTO `test_answer` VALUES ('72', '79', '1阿斯顿发生', 'A', '1495786083');
INSERT INTO `test_answer` VALUES ('73', '79', '1', 'B', '1495786083');
INSERT INTO `test_answer` VALUES ('74', '79', '1', 'C', '1495786083');
INSERT INTO `test_answer` VALUES ('75', '79', '1', 'D', '1495786083');
INSERT INTO `test_answer` VALUES ('76', '80', '阿萨德', 'A', '1495786096');
INSERT INTO `test_answer` VALUES ('77', '80', '阿斯顿发', 'B', '1495786096');
INSERT INTO `test_answer` VALUES ('78', '80', '阿萨德', 'C', '1495786096');
INSERT INTO `test_answer` VALUES ('79', '80', '啊水电费 ', 'D', '1495786096');
INSERT INTO `test_answer` VALUES ('80', '81', '72', 'A', '1496285867');
INSERT INTO `test_answer` VALUES ('81', '81', '70', 'B', '1496285867');
INSERT INTO `test_answer` VALUES ('82', '81', '71', 'C', '1496285867');
INSERT INTO `test_answer` VALUES ('83', '81', '73', 'D', '1496285867');
INSERT INTO `test_answer` VALUES ('84', '82', '32', 'A', '1496285900');
INSERT INTO `test_answer` VALUES ('85', '82', '36', 'B', '1496285900');
INSERT INTO `test_answer` VALUES ('86', '82', '30', 'C', '1496285900');
INSERT INTO `test_answer` VALUES ('87', '82', '33', 'D', '1496285900');
INSERT INTO `test_answer` VALUES ('88', '86', '2', 'A', '1496286031');
INSERT INTO `test_answer` VALUES ('89', '86', '3', 'B', '1496286031');
INSERT INTO `test_answer` VALUES ('90', '86', '1', 'C', '1496286031');
INSERT INTO `test_answer` VALUES ('91', '86', '4', 'D', '1496286031');
INSERT INTO `test_answer` VALUES ('92', '88', '3', 'A', '1496286049');
INSERT INTO `test_answer` VALUES ('93', '88', '4', 'B', '1496286049');
INSERT INTO `test_answer` VALUES ('94', '88', '2', 'C', '1496286049');
INSERT INTO `test_answer` VALUES ('95', '88', '1', 'D', '1496286049');
INSERT INTO `test_answer` VALUES ('96', '89', '1', 'A', '1496286049');
INSERT INTO `test_answer` VALUES ('97', '89', '2', 'B', '1496286049');
INSERT INTO `test_answer` VALUES ('98', '89', '3', 'C', '1496286049');
INSERT INTO `test_answer` VALUES ('99', '89', '4', 'D', '1496286049');
INSERT INTO `test_answer` VALUES ('100', '92', '4', 'A', '1496286266');
INSERT INTO `test_answer` VALUES ('101', '92', '3', 'B', '1496286266');
INSERT INTO `test_answer` VALUES ('102', '92', '2', 'C', '1496286266');
INSERT INTO `test_answer` VALUES ('103', '92', '1', 'D', '1496286266');

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
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8 COMMENT='考试题库表---赵';

-- ----------------------------
-- Records of test_cont
-- ----------------------------
INSERT INTO `test_cont` VALUES ('72', '9*9=？？？', 'C', '1495080187');
INSERT INTO `test_cont` VALUES ('73', '2*2=？', 'B', '1495519943');
INSERT INTO `test_cont` VALUES ('79', '11111', 'B', '1495786083');
INSERT INTO `test_cont` VALUES ('80', '阿斯顿发', 'B', '1495786096');
INSERT INTO `test_cont` VALUES ('81', '8*9=?', 'A', '1496285867');
INSERT INTO `test_cont` VALUES ('82', '6*6', 'B', '1496285900');
INSERT INTO `test_cont` VALUES ('86', '1+1', 'A', '1496286031');
INSERT INTO `test_cont` VALUES ('88', '1+2', 'A', '1496286049');
INSERT INTO `test_cont` VALUES ('89', '1+3', 'D', '1496286049');
INSERT INTO `test_cont` VALUES ('92', '2+2', 'A', '1496286266');
