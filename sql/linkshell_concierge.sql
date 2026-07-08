SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

DROP TABLE IF EXISTS `linkshell_concierge`;
CREATE TABLE IF NOT EXISTS `linkshell_concierge` (
  `zone_id` smallint(5) unsigned NOT NULL,
  `slot_index` tinyint(3) unsigned NOT NULL,
  `linkshellid` int(10) unsigned NOT NULL,
  `owner_char_id` int(10) unsigned NOT NULL,
  `group_key` smallint(5) unsigned NOT NULL DEFAULT '0',
  `flag` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `lang` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `members_goal` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `active_tier` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `characteristics` smallint(5) unsigned NOT NULL DEFAULT '0',
  `tz` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `days` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `times` int(10) unsigned NOT NULL DEFAULT '0',
  `posted_date` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`zone_id`, `slot_index`),
  KEY `linkshellid` (`linkshellid`),
  KEY `owner_char_id` (`owner_char_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
