
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

SET FOREIGN_KEY_CHECKS=0;

--
-- Structure of table `char_blacklist`
--

DROP TABLE IF EXISTS `char_blacklist`;
CREATE TABLE `char_blacklist` (
  `charid_owner` int(10) unsigned NOT NULL,
  `charid_target` int(10) unsigned NOT NULL,
  PRIMARY KEY (`charid_target`,`charid_owner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
