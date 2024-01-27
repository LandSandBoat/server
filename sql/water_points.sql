SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Structure de la table `water_points`
--

DROP TABLE IF EXISTS `water_points`;
CREATE TABLE IF NOT EXISTS `water_points` (
  `waterid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `zoneid` smallint(3) unsigned NOT NULL,
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `pointid` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `pos_x` float(7,2) NOT NULL DEFAULT '0.00',
  `pos_y` float(7,2) NOT NULL DEFAULT '0.00',
  `pos_z` float(7,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`waterid`)
) ENGINE=Aria TRANSACTIONAL=0  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Contenu de la table `water_points`
--

INSERT INTO `water_points` VALUES (1,100,0,0,0.00,0.00,0.00);
