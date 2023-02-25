SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Table structure for `exemplar_levels`
--

DROP TABLE IF EXISTS `exemplar_levels`;
CREATE TABLE IF NOT EXISTS `exemplar_levels` (
  `level` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `exp` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`level`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 AVG_ROW_LENGTH=9;

--
-- Contents of table `exemplar_levels`
--

INSERT INTO `exemplar_levels` VALUES(1,2500);
INSERT INTO `exemplar_levels` VALUES(2,5550);
INSERT INTO `exemplar_levels` VALUES(3,8721);
INSERT INTO `exemplar_levels` VALUES(4,11919);
INSERT INTO `exemplar_levels` VALUES(5,15122);
INSERT INTO `exemplar_levels` VALUES(6,18327);
INSERT INTO `exemplar_levels` VALUES(7,21532);
INSERT INTO `exemplar_levels` VALUES(8,24737);
INSERT INTO `exemplar_levels` VALUES(9,27942);
INSERT INTO `exemplar_levels` VALUES(10,31147);
INSERT INTO `exemplar_levels` VALUES(11,41205);
INSERT INTO `exemplar_levels` VALUES(12,48130);
INSERT INTO `exemplar_levels` VALUES(13,53677);
INSERT INTO `exemplar_levels` VALUES(14,58618);
INSERT INTO `exemplar_levels` VALUES(15,63292);
INSERT INTO `exemplar_levels` VALUES(16,67848);
INSERT INTO `exemplar_levels` VALUES(17,72353);
INSERT INTO `exemplar_levels` VALUES(18,76835);
INSERT INTO `exemplar_levels` VALUES(19,81307);
INSERT INTO `exemplar_levels` VALUES(20,85775);
INSERT INTO `exemplar_levels` VALUES(21,109112);
INSERT INTO `exemplar_levels` VALUES(22,127014);
INSERT INTO `exemplar_levels` VALUES(23,141329);
INSERT INTO `exemplar_levels` VALUES(24,153277);
INSERT INTO `exemplar_levels` VALUES(25,163663);
INSERT INTO `exemplar_levels` VALUES(26,173018);
INSERT INTO `exemplar_levels` VALUES(27,181692);
INSERT INTO `exemplar_levels` VALUES(28,189917);
INSERT INTO `exemplar_levels` VALUES(29,197845);
INSERT INTO `exemplar_levels` VALUES(30,205578);
INSERT INTO `exemplar_levels` VALUES(31,258409);
INSERT INTO `exemplar_levels` VALUES(32,307400);
INSERT INTO `exemplar_levels` VALUES(33,353012);
INSERT INTO `exemplar_levels` VALUES(34,395691);
INSERT INTO `exemplar_levels` VALUES(35,435673);
INSERT INTO `exemplar_levels` VALUES(36,473392);
INSERT INTO `exemplar_levels` VALUES(37,509085);
INSERT INTO `exemplar_levels` VALUES(38,542995);
INSERT INTO `exemplar_levels` VALUES(39,575336);
INSERT INTO `exemplar_levels` VALUES(40,606296);
INSERT INTO `exemplar_levels` VALUES(41,769426);
INSERT INTO `exemplar_levels` VALUES(42,951369);
INSERT INTO `exemplar_levels` VALUES(43,1154006);
INSERT INTO `exemplar_levels` VALUES(44,1379407);
INSERT INTO `exemplar_levels` VALUES(45,1629848);
INSERT INTO `exemplar_levels` VALUES(46,1907833);
INSERT INTO `exemplar_levels` VALUES(47,2216116);
INSERT INTO `exemplar_levels` VALUES(48,2557728);
INSERT INTO `exemplar_levels` VALUES(49,2936001);
INSERT INTO `exemplar_levels` VALUES(50,3354601);
INSERT INTO `exemplar_levels` VALUES(51,3817561);
