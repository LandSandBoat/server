SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

DROP TABLE IF EXISTS `chocobo_race_results`;
CREATE TABLE IF NOT EXISTS `chocobo_race_results` (
  `race_no` int(10) unsigned NOT NULL,
  `weather` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `places` int(10) unsigned NOT NULL DEFAULT '0',
  `run_at` int(10) unsigned NOT NULL DEFAULT '0',
  `intro_first` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `intro_second` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `chocobos` blob DEFAULT NULL,
  `names` blob DEFAULT NULL,
  `sections` blob DEFAULT NULL,
  PRIMARY KEY (`race_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
