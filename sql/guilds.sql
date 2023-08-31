SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Structure de la table `item_mods_pet`
--

DROP TABLE IF EXISTS `guilds`;
CREATE TABLE IF NOT EXISTS `guilds` (
  `id` tinyint(1) unsigned NOT NULL,
  `points_name` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 AVG_ROW_LENGTH=13 PACK_KEYS=1;

LOCK TABLES `guilds` WRITE;

INSERT INTO `guilds` VALUES (0,'guild_fishing');
INSERT INTO `guilds` VALUES (1,'guild_woodworking');
INSERT INTO `guilds` VALUES (2,'guild_smithing');
INSERT INTO `guilds` VALUES (3,'guild_goldsmithing');
INSERT INTO `guilds` VALUES (4,'guild_weaving');
INSERT INTO `guilds` VALUES (5,'guild_leathercraft');
INSERT INTO `guilds` VALUES (6,'guild_bonecraft');
INSERT INTO `guilds` VALUES (7,'guild_alchemy');
INSERT INTO `guilds` VALUES (8,'guild_cooking');

UNLOCK TABLES;
