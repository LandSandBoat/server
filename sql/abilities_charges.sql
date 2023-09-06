SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for abilities_charges
-- ----------------------------
DROP TABLE IF EXISTS `abilities_charges`;
CREATE TABLE `abilities_charges` (
  `recastId` smallint(5) unsigned NOT NULL,
  `job` tinyint(2) unsigned NOT NULL,
  `level` tinyint(2) unsigned NOT NULL,
  `maxCharges` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `chargeTime` smallint(4) unsigned NOT NULL DEFAULT '0',
  `meritModID` smallint(4) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`recastId`,`job`,`level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AVG_ROW_LENGTH=56;

-- ----------------------------
-- Records 
-- ----------------------------
INSERT INTO `abilities_charges` VALUES (102,9,25,3,30,0);
INSERT INTO `abilities_charges` VALUES (195,17,40,2,60,1410);
INSERT INTO `abilities_charges` VALUES (231,20,10,1,240,0);
INSERT INTO `abilities_charges` VALUES (231,20,30,2,120,0);
INSERT INTO `abilities_charges` VALUES (231,20,50,3,80,0);
INSERT INTO `abilities_charges` VALUES (231,20,70,4,60,0);
INSERT INTO `abilities_charges` VALUES (231,20,90,5,48,0);
