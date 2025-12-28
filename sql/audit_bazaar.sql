SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Table structure of `audit_bazaar`
--

CREATE TABLE IF NOT EXISTS `audit_bazaar` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `itemid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `quantity` int(10) unsigned NOT NULL DEFAULT '0',
  `seller` int(10) unsigned NOT NULL DEFAULT '0',
  `seller_name` varchar(15) DEFAULT NULL,
  `purchaser` int(10) unsigned NOT NULL DEFAULT '0',
  `purchaser_name` varchar(15) DEFAULT NULL,
  `price` int(10) unsigned NOT NULL DEFAULT '0',
  `date` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `itemid` (`itemid`),
  KEY `charid` (`seller`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

--
-- Table contents of `audit_bazaar`
--
