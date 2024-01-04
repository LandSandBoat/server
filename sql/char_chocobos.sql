/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

SET FOREIGN_KEY_CHECKS=0;

DROP TABLE IF EXISTS `char_chocobos`;
CREATE TABLE `char_chocobos` (
  `charid` int unsigned NOT NULL,
  `first_name` varchar(15) NOT NULL,
  `last_name` varchar(15) NOT NULL,
  `sex` boolean NOT NULL,
  `created` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `last_update_age` tinyint unsigned NOT NULL,
  `stage` tinyint unsigned NOT NULL,
  `location` tinyint unsigned NOT NULL,
  `colour` tinyint unsigned NOT NULL,
  `dominant_gene` tinyint unsigned NOT NULL,
  `recessive_gene` tinyint unsigned NOT NULL,
  `strength` tinyint unsigned NOT NULL,
  `endurance` tinyint unsigned NOT NULL,
  `discernment` tinyint unsigned NOT NULL,
  `receptivity` tinyint unsigned NOT NULL,
  `affection` tinyint unsigned NOT NULL,
  `energy` tinyint unsigned NOT NULL,
  `satisfaction` tinyint unsigned NOT NULL,
  `conditions` int unsigned NOT NULL,
  `ability1` tinyint unsigned NOT NULL,
  `ability2` tinyint unsigned NOT NULL,
  `personality` tinyint unsigned NOT NULL,
  `weather_preference` tinyint unsigned NOT NULL,
  `hunger` tinyint unsigned NOT NULL,
  `care_plan` int unsigned NOT NULL,
  `held_item` int unsigned NOT NULL,
  PRIMARY KEY (`charid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
