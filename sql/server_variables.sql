/*
Navicat MySQL Data Transfer

Source Server         : Topaz
Source Server Version : 50516
Source Host           : localhost:3306
Source Database       : tpzdb

Target Server Type    : MYSQL
Target Server Version : 50516
File Encoding         : 65001

Date: 2012-05-19 17:40:04
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `server_variables`
-- ----------------------------
DROP TABLE IF EXISTS `server_variables`;
CREATE TABLE `server_variables` (
  `name` varchar(50) NOT NULL,
  `value` int(11) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of server_variables
-- ----------------------------
