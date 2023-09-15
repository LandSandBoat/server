/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `besieged_mirrors`
--

DROP TABLE IF EXISTS `besieged_mirrors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `besieged_mirrors` (
  `mirror_index` int(11) unsigned NOT NULL,
  `stronghold_id` tinyint(2) NOT NULL DEFAULT 0,
  `destroyed` tinyint(1) NOT NULL,
  PRIMARY KEY (`mirror_index`,`stronghold_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `besieged_mirrors`
--

LOCK TABLES `besieged_mirrors` WRITE;
/*!40000 ALTER TABLE `besieged_mirrors` DISABLE KEYS */;
INSERT INTO `besieged_mirrors` VALUES (0,1,1);
INSERT INTO `besieged_mirrors` VALUES (0,2,1);
INSERT INTO `besieged_mirrors` VALUES (0,3,1);
INSERT INTO `besieged_mirrors` VALUES (1,1,0);
INSERT INTO `besieged_mirrors` VALUES (1,2,1);
INSERT INTO `besieged_mirrors` VALUES (1,3,1);
INSERT INTO `besieged_mirrors` VALUES (2,1,1);
INSERT INTO `besieged_mirrors` VALUES (2,2,0);
INSERT INTO `besieged_mirrors` VALUES (2,3,0);
INSERT INTO `besieged_mirrors` VALUES (3,1,0);
INSERT INTO `besieged_mirrors` VALUES (3,2,1);
INSERT INTO `besieged_mirrors` VALUES (3,3,1);
INSERT INTO `besieged_mirrors` VALUES (4,1,0);
INSERT INTO `besieged_mirrors` VALUES (4,2,1);
INSERT INTO `besieged_mirrors` VALUES (4,3,0);
INSERT INTO `besieged_mirrors` VALUES (5,1,1);
INSERT INTO `besieged_mirrors` VALUES (5,2,1);
INSERT INTO `besieged_mirrors` VALUES (5,3,1);
INSERT INTO `besieged_mirrors` VALUES (6,1,0);
INSERT INTO `besieged_mirrors` VALUES (6,2,1);
INSERT INTO `besieged_mirrors` VALUES (6,3,1);
INSERT INTO `besieged_mirrors` VALUES (7,1,1);
INSERT INTO `besieged_mirrors` VALUES (7,2,1);
INSERT INTO `besieged_mirrors` VALUES (7,3,1);
/*!40000 ALTER TABLE `besieged_mirrors` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
