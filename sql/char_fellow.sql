
SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

DROP TABLE IF EXISTS `char_fellow`;
CREATE TABLE `char_fellow` (
  `charid` int(10) unsigned NOT NULL,
  `fellowid` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `optionsMask` int(11) unsigned NOT NULL DEFAULT 18,
  `lvlcap` tinyint(2) unsigned NOT NULL DEFAULT 50,
  `level` tinyint(2) unsigned NOT NULL DEFAULT 30,
  `exp` smallint(5) unsigned NOT NULL DEFAULT 0,
  `job` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `bond` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `bondcap` tinyint(3) unsigned NOT NULL DEFAULT 30,
  `face` tinyint(2) unsigned NOT NULL DEFAULT 0,
  `size` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `personality` tinyint(2) unsigned NOT NULL DEFAULT 0,
  `armorLock` int(11) unsigned NOT NULL DEFAULT 0,
  `head` int(5) unsigned NOT NULL DEFAULT 0,
  `body` int(5) unsigned NOT NULL DEFAULT 0,
  `hands` int(5) unsigned NOT NULL DEFAULT 0,
  `legs` int(5) unsigned NOT NULL DEFAULT 0,
  `feet` int(5) unsigned NOT NULL DEFAULT 0,
  `main` int(5) unsigned NOT NULL DEFAULT 16530, -- xiphos
  `sub` int(5) unsigned NOT NULL DEFAULT 12289, -- lauan shield
  `kills` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `maxTime` int(5) unsigned NOT NULL DEFAULT 0,
  `spawnTime` int(10) unsigned NOT NULL DEFAULT 0,
  `pearlTime` int(10) unsigned NOT NULL DEFAULT 0,
  `tacticsTime` int(10) unsigned NOT NULL DEFAULT 0,
  `zone_hp` smallint(4) unsigned NOT NULL DEFAULT 0,
  `zone_mp` smallint(4) unsigned NOT NULL DEFAULT 0,
  `wotg_unlock` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `weaponlvl` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `formalwear` tinyint(1) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`charid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8; 
