SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

-- One row per race and pair.
-- pair is 0-27 in toteboard order 1-2 .. 7-8.
DROP TABLE IF EXISTS `chocobo_race_quills`;
CREATE TABLE IF NOT EXISTS `chocobo_race_quills` (
  `race_no` int(10) unsigned NOT NULL,
  `pair` tinyint(3) unsigned NOT NULL,
  `quills` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`race_no`, `pair`),
  CONSTRAINT `fk_chocobo_race_quills_race_no` FOREIGN KEY (`race_no`) REFERENCES `chocobo_race_results` (`race_no`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
