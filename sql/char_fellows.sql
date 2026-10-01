/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

SET FOREIGN_KEY_CHECKS=0;

DROP TABLE IF EXISTS `char_fellows`;
CREATE TABLE `char_fellows` (
  `charid` int unsigned NOT NULL,
  `name` tinyint unsigned NOT NULL,
  `race` tinyint unsigned NOT NULL,
  `size` tinyint unsigned NOT NULL,
  `personality` tinyint unsigned NOT NULL,
  `face` tinyint unsigned NOT NULL,
  `level` tinyint unsigned NOT NULL DEFAULT '30',
  `level_cap` tinyint unsigned NOT NULL DEFAULT '50',
  `exp` int unsigned NOT NULL DEFAULT '0',
  `bond` tinyint unsigned NOT NULL DEFAULT '0',
  `bond_cap` tinyint unsigned NOT NULL DEFAULT '30',
  `job` tinyint unsigned NOT NULL DEFAULT '0',
  `signals` tinyint unsigned NOT NULL DEFAULT '18',
  `unlocked_jobs` tinyint unsigned NOT NULL DEFAULT '0',
  `weapon_model` tinyint unsigned NOT NULL DEFAULT '0',
  `weapon_tier` tinyint unsigned NOT NULL DEFAULT '0',
  `headwear_tier` tinyint unsigned NOT NULL DEFAULT '0',
  `armor_path` tinyint unsigned NOT NULL DEFAULT '0',
  `armor_tier` tinyint unsigned NOT NULL DEFAULT '0',
  `body_level` tinyint unsigned NOT NULL DEFAULT '0',
  `hands_level` tinyint unsigned NOT NULL DEFAULT '0',
  `legs_level` tinyint unsigned NOT NULL DEFAULT '0',
  `feet_level` tinyint unsigned NOT NULL DEFAULT '0',
  `gear_locks` tinyint unsigned NOT NULL DEFAULT '0',
  `active_time_upgrades` tinyint unsigned NOT NULL DEFAULT '0',
  `fashion_advice` tinyint unsigned NOT NULL DEFAULT '0',
  `kills` tinyint unsigned NOT NULL DEFAULT '0',
  `call_time` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`charid`),
  CONSTRAINT `fk_char_fellows_charid` FOREIGN KEY (`charid`) REFERENCES `chars` (`charid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
