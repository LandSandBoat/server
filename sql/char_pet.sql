SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

DROP TABLE IF EXISTS `char_pet`;
CREATE TABLE IF NOT EXISTS `char_pet` (
  `charid` int(10) unsigned NOT NULL,
  `wyvernid` smallint(3) unsigned NOT NULL DEFAULT '0',
  `automatonid` smallint(3) unsigned NOT NULL DEFAULT '0',
  `unlocked_attachments` blob,
  `equipped_attachments` blob,
  `adventuringfellowid` smallint(3) unsigned NOT NULL DEFAULT '0',
  `chocoboid` int(11) unsigned NOT NULL DEFAULT '0',
  `field_chocobo` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`charid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
