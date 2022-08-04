SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Table structure for `pet_skills`
--

-- pet_skill_id is intended to map 1:1 with a real player id, i.e. "Welt" on this table would have the same id as "Welt" on abilities.sql
DROP TABLE IF EXISTS `pet_skills`;
CREATE TABLE `pet_skills` (
  `pet_skill_id` smallint(4) unsigned NOT NULL,
  `pet_anim_id` smallint(4) unsigned NOT NULL,
  `pet_skill_name` varchar(40) CHARACTER SET latin1 NOT NULL,
  `pet_skill_aoe` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `pet_skill_distance` float(3,1) NOT NULL DEFAULT 6.0,
  `pet_anim_time` smallint(4) unsigned NOT NULL DEFAULT 2000,
  `pet_prepare_time` smallint(4) unsigned NOT NULL DEFAULT 1000,
  `pet_valid_targets` smallint(4) unsigned NOT NULL DEFAULT 4,
  `pet_message` smallint(5) unsigned NOT NULL DEFAULT 0,
  `pet_skill_flag` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `pet_skill_param` smallint(5) NOT NULL DEFAULT 0,
  `pet_skill_finish_category` smallint(5) NOT NULL DEFAULT 11,
  `knockback` tinyint(1) NOT NULL DEFAULT 0,
  `primary_sc` tinyint(4) NOT NULL DEFAULT 0,
  `secondary_sc` tinyint(4) NOT NULL DEFAULT 0,
  `tertiary_sc` tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`pet_skill_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Table contents for `pet_skills`
--

-- Siren
INSERT INTO `pet_skills` VALUES (961,176,'welt',0,6.0,2000,1000,4,317,68,0,13,0,0,0,0);
