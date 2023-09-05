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
-- Table structure for table `despoil_effects`
--

DROP TABLE IF EXISTS `despoil_effects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `despoil_effects` (
  `itemId` smallint(5) unsigned NOT NULL,
  `effectId` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`itemId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `despoil_effects`
--

LOCK TABLES `despoil_effects` WRITE;
/*!40000 ALTER TABLE `despoil_effects` DISABLE KEYS */;
INSERT INTO `despoil_effects` VALUES (644,149);        -- Mythril Ore, Defense Down
INSERT INTO `despoil_effects` VALUES (842,146);     -- Giant Bird Feather, Accuracy Down
INSERT INTO `despoil_effects` VALUES (881,149);     -- Crab Shell, Defense Down
INSERT INTO `despoil_effects` VALUES (955,167);        -- Golem Shard, Magic Defense Down
INSERT INTO `despoil_effects` VALUES (2334,175);    -- Poroggo Hat, Magic Attack Down
INSERT INTO `despoil_effects` VALUES (4376,147);    -- Meat Jerky, Attack Down
INSERT INTO `despoil_effects` VALUES (4400,13);        -- Land Crab Meat, Slow
/*!40000 ALTER TABLE `despoil_effects` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
