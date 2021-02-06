/*
MySQL Data Transfer
Source Host: 192.168.0.140
Source Database: tpzdb
Target Host: 192.168.0.140
Target Database: tpzdb
Date: 1/21/2015 1:06:39 PM
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for char_recast
-- ----------------------------
DROP TABLE IF EXISTS `char_recast`;
CREATE TABLE `char_recast` (
  `charid` int(10) unsigned NOT NULL,
  `id` smallint(5) NOT NULL DEFAULT '0',
  `time` int(10) NOT NULL DEFAULT '0',
  `recast` smallint(5) NOT NULL DEFAULT '0',
  PRIMARY KEY (`charid`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records 
-- ----------------------------
