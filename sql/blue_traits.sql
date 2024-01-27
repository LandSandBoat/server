SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for blue_traits
-- ----------------------------
DROP TABLE IF EXISTS `blue_traits`;
CREATE TABLE `blue_traits` (
  `trait_category` smallint(2) unsigned NOT NULL,
  `trait_points_needed` smallint(2) unsigned NOT NULL,
  `traitid` tinyint(3) unsigned NOT NULL,
  `modifier` smallint(5) unsigned NOT NULL,
  `value` smallint(5) NOT NULL,
  PRIMARY KEY (`trait_category`,`trait_points_needed`,`modifier`)
) ENGINE=Aria TRANSACTIONAL=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records
-- ----------------------------
INSERT INTO `blue_traits` VALUES (1,2,32,230,8);
INSERT INTO `blue_traits` VALUES (2,2,9,370,1);
INSERT INTO `blue_traits` VALUES (3,2,35,227,8);
INSERT INTO `blue_traits` VALUES (4,2,24,295,1);
INSERT INTO `blue_traits` VALUES (4,4,24,295,2);
INSERT INTO `blue_traits` VALUES (4,6,24,295,3);
INSERT INTO `blue_traits` VALUES (4,8,24,295,4);
INSERT INTO `blue_traits` VALUES (5,2,48,240,2);
INSERT INTO `blue_traits` VALUES (6,2,5,28,20);
INSERT INTO `blue_traits` VALUES (7,2,39,231,8);
INSERT INTO `blue_traits` VALUES (8,2,3,23,10);
INSERT INTO `blue_traits` VALUES (8,2,3,24,10);
INSERT INTO `blue_traits` VALUES (9,2,11,357,10);
INSERT INTO `blue_traits` VALUES (10,2,8,5,10);
INSERT INTO `blue_traits` VALUES (10,4,8,5,30);
INSERT INTO `blue_traits` VALUES (11,2,4,1,10);
INSERT INTO `blue_traits` VALUES (12,2,33,229,8);
INSERT INTO `blue_traits` VALUES (13,2,6,29,10);
INSERT INTO `blue_traits` VALUES (14,8,10,369,1);
INSERT INTO `blue_traits` VALUES (15,2,7,2,30);
INSERT INTO `blue_traits` VALUES (15,4,7,2,90);
INSERT INTO `blue_traits` VALUES (16,2,1,25,10);
INSERT INTO `blue_traits` VALUES (16,2,1,26,10);
INSERT INTO `blue_traits` VALUES (17,2,13,296,25);
INSERT INTO `blue_traits` VALUES (18,2,2,69,10);
INSERT INTO `blue_traits` VALUES (19,2,58,249,2);
INSERT INTO `blue_traits` VALUES (20,2,14,73,10);
INSERT INTO `blue_traits` VALUES (20,4,14,73,25);
INSERT INTO `blue_traits` VALUES (21,2,17,291,10);
INSERT INTO `blue_traits` VALUES (22,2,12,170,5);
INSERT INTO `blue_traits` VALUES (22,4,12,170,15);
INSERT INTO `blue_traits` VALUES (23,2,106,174,8);
INSERT INTO `blue_traits` VALUES (24,2,15,288,7);
INSERT INTO `blue_traits` VALUES (24,4,16,302,5);
INSERT INTO `blue_traits` VALUES (25,2,18,259,10);
INSERT INTO `blue_traits` VALUES (25,4,18,259,15);
INSERT INTO `blue_traits` VALUES (25,6,18,259,25);
INSERT INTO `blue_traits` VALUES (26,2,70,306,15);
INSERT INTO `blue_traits` VALUES (27,2,110,407,5);
INSERT INTO `blue_traits` VALUES (28,2,20,0,0);
INSERT INTO `blue_traits` VALUES (28,3,19,303,1);
