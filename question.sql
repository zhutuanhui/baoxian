/*
Navicat MySQL Data Transfer

Source Server         : 保险
Source Server Version : 50718
Source Host           : 10.0.2.16:3306
Source Database       : insurance

Target Server Type    : MYSQL
Target Server Version : 50718
File Encoding         : 65001

Date: 2017-06-02 15:18:59
*/

SET FOREIGN_KEY_CHECKS=0;

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
