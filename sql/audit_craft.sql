SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Table structure of `audit_craft`
--
-- start_time and end_time are UTC.
--

CREATE TABLE IF NOT EXISTS `audit_craft` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `charid` int(10) unsigned NOT NULL DEFAULT '0',
  `char_name` varchar(15) DEFAULT NULL,
  `recipeid` int(10) unsigned NOT NULL DEFAULT '0',
  `recipe_name` varchar(64) DEFAULT NULL,
  `result` enum('Fail','NQ','HQ1','HQ2','HQ3','Interrupted') NOT NULL DEFAULT 'Fail',
  `start_time` datetime(3) NOT NULL,
  `end_time` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `charid` (`charid`),
  KEY `recipeid` (`recipeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

--
-- Table contents of `audit_craft`
--
