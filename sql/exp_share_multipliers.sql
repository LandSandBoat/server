SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

DROP TABLE IF EXISTS `exp_share_multipliers`;
CREATE TABLE IF NOT EXISTS `exp_share_multipliers` (
  `num_members` TINYINT NOT NULL DEFAULT '0',
  `base_mult` FLOAT NOT NULL DEFAULT '0',
  `region_buff_mult` FLOAT NOT NULL DEFAULT '0',
  PRIMARY KEY (`num_members`)
) ENGINE=Aria DEFAULT CHARSET=utf8mb4;

INSERT INTO `exp_share_multipliers` VALUES(1,  1.000, 1.000);
INSERT INTO `exp_share_multipliers` VALUES(2,  0.600, 0.750);
INSERT INTO `exp_share_multipliers` VALUES(3,  0.450, 0.550);
INSERT INTO `exp_share_multipliers` VALUES(4,  0.400, 0.450);
INSERT INTO `exp_share_multipliers` VALUES(5,  0.370, 0.390);
INSERT INTO `exp_share_multipliers` VALUES(6,  0.350, 0.350);
INSERT INTO `exp_share_multipliers` VALUES(7,  0.250, 0.250);
INSERT INTO `exp_share_multipliers` VALUES(8,  0.225, 0.225);
INSERT INTO `exp_share_multipliers` VALUES(9,  0.200, 0.200);
INSERT INTO `exp_share_multipliers` VALUES(10, 0.180, 0.180);
INSERT INTO `exp_share_multipliers` VALUES(11, 0.164, 0.164);
INSERT INTO `exp_share_multipliers` VALUES(12, 0.150, 0.150);
INSERT INTO `exp_share_multipliers` VALUES(13, 0.138, 0.138);
INSERT INTO `exp_share_multipliers` VALUES(14, 0.129, 0.129);
INSERT INTO `exp_share_multipliers` VALUES(15, 0.120, 0.120);
INSERT INTO `exp_share_multipliers` VALUES(16, 0.113, 0.113);
INSERT INTO `exp_share_multipliers` VALUES(17, 0.106, 0.106);
INSERT INTO `exp_share_multipliers` VALUES(18, 0.100, 0.100);
