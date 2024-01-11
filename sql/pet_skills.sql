SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Table structure for `pet_skills`
--

-- Skillflag Variables
SET @SKILLFLAG_NONE           = 0;   -- no skill flag
SET @SKILLFLAG_ASTRAL_FLOW    = 2;   -- Used to identify 2hrs (such as avatar 2hrs like Searing Light, Clarsach Call, etc.)
SET @SKILLFLAG_SPECIAL        = 4;   -- Used to identify abilities
SET @SKILLFLAG_BLOODPACT_RAGE = 64;  -- Used for identifying Bloodpact Rage abilities
SET @SKILLFLAG_BLOODPACT_WARD = 128; -- Used for identifying Bloodpact Ward abilities

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
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Table contents for `pet_skills`
--

-- Carbuncle
INSERT INTO `pet_skills` VALUES (512,0,'healing_ruby',0,18.0,2000,1000,3,318,@SKILLFLAG_SPECIAL | @SKILLFLAG_BLOODPACT_WARD,0,13,0,0,0,0);
INSERT INTO `pet_skills` VALUES (513,1,'poison_nails',0,5.0,2000,1000,4,317,@SKILLFLAG_SPECIAL | @SKILLFLAG_BLOODPACT_RAGE,0,13,0,0,0,0);
INSERT INTO `pet_skills` VALUES (514,2,'shining_ruby',1,18.0,2000,1000,3,319,@SKILLFLAG_SPECIAL | @SKILLFLAG_BLOODPACT_WARD,0,13,0,0,0,0);
INSERT INTO `pet_skills` VALUES (515,3,'glittering_ruby',1,18.0,2000,1000,3,319,@SKILLFLAG_SPECIAL | @SKILLFLAG_BLOODPACT_WARD,0,13,0,0,0,0);
INSERT INTO `pet_skills` VALUES (516,4,'meteorite',0,7.0,2000,1000,4,317,@SKILLFLAG_SPECIAL | @SKILLFLAG_BLOODPACT_RAGE,0,13,0,0,0,0);
INSERT INTO `pet_skills` VALUES (517,5,'healing_ruby_ii',1,18.0,2000,1000,3,318,@SKILLFLAG_SPECIAL | @SKILLFLAG_BLOODPACT_WARD,0,13,0,0,0,0);
INSERT INTO `pet_skills` VALUES (518,6,'searing_light',1,18.0,2000,1000,3,319,@SKILLFLAG_ASTRAL_FLOW | @SKILLFLAG_SPECIAL | @SKILLFLAG_BLOODPACT_WARD,0,13,0,0,0,0);
INSERT INTO `pet_skills` VALUES (519,7,'holy_mist',1,7.0,2000,1000,4,317,@SKILLFLAG_SPECIAL | @SKILLFLAG_BLOODPACT_RAGE,0,13,0,0,0,0);
INSERT INTO `pet_skills` VALUES (520,8,'soothing_ruby',1,18.0,2000,1000,3,317,@SKILLFLAG_SPECIAL | @SKILLFLAG_BLOODPACT_WARD,0,13,0,0,0,0);
INSERT INTO `pet_skills` VALUES (773,9,'pacifying_ruby',1,18.0,2000,1000,3,323,@SKILLFLAG_SPECIAL | @SKILLFLAG_BLOODPACT_WARD,0,13,0,0,0,0);

-- Cait Sith
INSERT INTO `pet_skills` VALUES (521,161,'regal_scratch',0,18.0,2000,1000,4,317,@SKILLFLAG_SPECIAL | @SKILLFLAG_BLOODPACT_RAGE,0,13,0,4,0,0); -- Scission (4)
INSERT INTO `pet_skills` VALUES (522,162,'mewing_lullaby',1,12.0,2000,1000,4,317,@SKILLFLAG_SPECIAL | @SKILLFLAG_BLOODPACT_WARD,0,13,0,0,0,0);
INSERT INTO `pet_skills` VALUES (523,163,'eerie_eye',4,18.0,2000,1000,4,317,@SKILLFLAG_SPECIAL | @SKILLFLAG_BLOODPACT_RAGE,0,13,0,0,0,0);
INSERT INTO `pet_skills` VALUES (524,164,'level_X_holy',1,12.0,2000,1000,4,317,@SKILLFLAG_SPECIAL | @SKILLFLAG_BLOODPACT_RAGE,0,13,0,0,0,0); -- Animation ID is for die roll of 1: 164-169
INSERT INTO `pet_skills` VALUES (525,159,'raise_ii',0,18.0,2000,1000,32,0,@SKILLFLAG_SPECIAL | @SKILLFLAG_BLOODPACT_WARD,0,13,0,0,0,0);
INSERT INTO `pet_skills` VALUES (526,160,'reraise_ii',0,18.0,2000,1000,16,316,@SKILLFLAG_SPECIAL | @SKILLFLAG_BLOODPACT_WARD,0,13,0,0,0,0);
INSERT INTO `pet_skills` VALUES (527,170,'altana_s_favor',1,18.0,2000,1000,35,316,@SKILLFLAG_ASTRAL_FLOW | @SKILLFLAG_SPECIAL | @SKILLFLAG_BLOODPACT_WARD,0,13,0,0,0,0);

-- Siren
INSERT INTO `pet_skills` VALUES (960,175,'clarsach_call',1,7.0,2000,1000,4,317,@SKILLFLAG_ASTRAL_FLOW | @SKILLFLAG_SPECIAL | @SKILLFLAG_BLOODPACT_RAGE,0,13,0,0,0,0);
INSERT INTO `pet_skills` VALUES (961,176,'welt',0,7.0,2000,1000,4,317,@SKILLFLAG_SPECIAL | @SKILLFLAG_BLOODPACT_RAGE,0,13,0,0,0,0);
INSERT INTO `pet_skills` VALUES (964,179,'roundhouse',0,7.0,2000,1000,4,317,@SKILLFLAG_SPECIAL | @SKILLFLAG_BLOODPACT_RAGE,0,13,0,0,0,0);
INSERT INTO `pet_skills` VALUES (967,182,'sonic_buffet',0,18.0,2000,1000,4,317,@SKILLFLAG_SPECIAL | @SKILLFLAG_BLOODPACT_RAGE,0,13,0,0,0,0);
INSERT INTO `pet_skills` VALUES (968,183,'tornado_ii',0,14.0,2000,1000,4,317,@SKILLFLAG_SPECIAL | @SKILLFLAG_BLOODPACT_RAGE,0,13,0,0,0,0);
INSERT INTO `pet_skills` VALUES (970,185,'hysteric_assault',0,7.0,2000,1000,4,802,@SKILLFLAG_SPECIAL | @SKILLFLAG_BLOODPACT_RAGE,0,13,0,0,0,0);
