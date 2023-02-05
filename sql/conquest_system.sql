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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conquest_system`
--

LOCK TABLES `conquest_system` WRITE;
/*!40000 ALTER TABLE `conquest_system` DISABLE KEYS */;
INSERT INTO `conquest_system` VALUES (0,0,1,5000,0,0,0);
INSERT INTO `conquest_system` VALUES (1,0,1,1500,1500,0,1000);
INSERT INTO `conquest_system` VALUES (2,0,1,3000,0,0,2000);
INSERT INTO `conquest_system` VALUES (3,1,1,0,5000,0,0);
INSERT INTO `conquest_system` VALUES (4,1,0,0,3000,0,2000);
INSERT INTO `conquest_system` VALUES (5,2,0,0,0,5000,0);
INSERT INTO `conquest_system` VALUES (6,2,0,0,0,4000,1000);
INSERT INTO `conquest_system` VALUES (7,2,0,0,0,3000,2000);
INSERT INTO `conquest_system` VALUES (8,3,0,0,0,0,5000);
INSERT INTO `conquest_system` VALUES (9,3,3,0,0,0,5000);
INSERT INTO `conquest_system` VALUES (10,2,3,2000,750,750,1500);
INSERT INTO `conquest_system` VALUES (11,3,3,0,0,0,5000);
INSERT INTO `conquest_system` VALUES (12,3,3,0,0,0,5000);
INSERT INTO `conquest_system` VALUES (13,3,3,0,0,0,5000);
INSERT INTO `conquest_system` VALUES (14,3,3,0,0,0,5000);
INSERT INTO `conquest_system` VALUES (15,3,3,0,0,0,5000);
INSERT INTO `conquest_system` VALUES (16,3,3,0,0,0,5000);
INSERT INTO `conquest_system` VALUES (17,3,3,0,0,0,5000);
INSERT INTO `conquest_system` VALUES (18,3,3,0,0,0,5000);
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
