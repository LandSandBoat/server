/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping structure for table xidbw.unity_system
DROP TABLE IF EXISTS `unity_system`;
CREATE TABLE `unity_system` (
  `leader` tinyint(4) NOT NULL,
  `members_current` int(11) NOT NULL DEFAULT 0,
  `points_current` double NOT NULL DEFAULT 0,
  `members_prev` int(11) NOT NULL DEFAULT 0,
  `points_prev` double NOT NULL DEFAULT 0,
  PRIMARY KEY (`leader`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table xidbw.unity_system: ~12 rows (approximately)
/*!40000 ALTER TABLE `unity_system` DISABLE KEYS */;
INSERT INTO `unity_system` (`leader`, `members_current`, `points_current`, `members_prev`, `points_prev`) VALUES
    (1, 0, 0, 0, 0),
    (2, 0, 0, 0, 0),
    (3, 0, 0, 0, 0),
    (4, 0, 0, 0, 0),
    (5, 0, 0, 0, 0),
    (6, 0, 0, 0, 0),
    (7, 0, 0, 0, 0),
    (8, 0, 0, 0, 0),
    (9, 0, 0, 0, 0),
    (10, 0, 0, 0, 0),
    (11, 0, 0, 0, 0);
/*!40000 ALTER TABLE `unity_system` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
