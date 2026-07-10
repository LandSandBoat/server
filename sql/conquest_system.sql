/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `conquest_system`
--

DROP TABLE IF EXISTS `conquest_system`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `conquest_system` (
  `region_id` tinyint(2) NOT NULL DEFAULT '0',
  `region_control` tinyint(2) NOT NULL DEFAULT '0',
  `region_control_prev` tinyint(2) NOT NULL DEFAULT '0',
  `sandoria_influence` int(10) NOT NULL DEFAULT '0',
  `bastok_influence` int(10) NOT NULL DEFAULT '0',
  `windurst_influence` int(10) NOT NULL DEFAULT '0',
  `beastmen_influence` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`region_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conquest_system`
--

LOCK TABLES `conquest_system` WRITE;
/*!40000 ALTER TABLE `conquest_system` DISABLE KEYS */;
INSERT INTO `conquest_system` VALUES (0,5,5,0,0,0,0);
INSERT INTO `conquest_system` VALUES (1,5,5,0,0,0,0);
INSERT INTO `conquest_system` VALUES (2,5,5,0,0,0,0);
INSERT INTO `conquest_system` VALUES (3,5,5,0,0,0,0);
INSERT INTO `conquest_system` VALUES (4,5,5,0,0,0,0);
INSERT INTO `conquest_system` VALUES (5,5,5,0,0,0,0);
INSERT INTO `conquest_system` VALUES (6,5,5,0,0,0,0);
INSERT INTO `conquest_system` VALUES (7,5,5,0,0,0,0);
INSERT INTO `conquest_system` VALUES (8,5,5,0,0,0,0);
INSERT INTO `conquest_system` VALUES (9,5,5,0,0,0,0);
INSERT INTO `conquest_system` VALUES (10,5,5,0,0,0,0);
INSERT INTO `conquest_system` VALUES (11,5,5,0,0,0,0);
INSERT INTO `conquest_system` VALUES (12,5,5,0,0,0,0);
INSERT INTO `conquest_system` VALUES (13,5,5,0,0,0,0);
INSERT INTO `conquest_system` VALUES (14,5,5,0,0,0,0);
INSERT INTO `conquest_system` VALUES (15,5,5,0,0,0,0);
INSERT INTO `conquest_system` VALUES (16,5,5,0,0,0,0);
INSERT INTO `conquest_system` VALUES (17,5,5,0,0,0,0);
INSERT INTO `conquest_system` VALUES (18,5,5,0,0,0,0);
/*!40000 ALTER TABLE `conquest_system` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
