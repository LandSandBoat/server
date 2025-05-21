-- MySQL dump 10.16  Distrib 10.1.38-MariaDB, for Win32 (AMD64)
--
-- Host: localhost    Database: dspdb
-- ------------------------------------------------------
-- Server version    10.1.38-MariaDB

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
-- Table structure for table `fishing_bait`
--

DROP TABLE IF EXISTS `fishing_bait`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fishing_bait` (
  `baitid` int(10) unsigned NOT NULL,
  `name` varchar(64) NOT NULL,
  `type` tinyint(2) unsigned NOT NULL,
  `maxhook` tinyint(2) unsigned NOT NULL,
  `losable` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `flags` int(11) unsigned NOT NULL DEFAULT '0',
  `mmm` tinyint(2) unsigned NOT NULL,
  `rankmod` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`baitid`)
) ENGINE=Aria TRANSACTIONAL=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fishing_bait`
--

LOCK TABLES `fishing_bait` WRITE;
/*!40000 ALTER TABLE `fishing_bait` DISABLE KEYS */;
INSERT INTO `fishing_bait` VALUES (16992,'Slice of Bluetail',0,1,1,0,0,0);
INSERT INTO `fishing_bait` VALUES (16993,'Peeled Crayfish',0,1,1,0,0,0);
INSERT INTO `fishing_bait` VALUES (16994,'Slice of Moat Carp',0,1,1,0,0,0);
INSERT INTO `fishing_bait` VALUES (16995,'Rotten Meat',0,1,1,0,0,0);
INSERT INTO `fishing_bait` VALUES (16996,'Ball of Sardine Paste',0,1,1,0,0,0);
INSERT INTO `fishing_bait` VALUES (16997,'Ball of Crayfish Paste',0,1,1,0,0,0);
INSERT INTO `fishing_bait` VALUES (16998,'Ball of Insect Paste',0,1,1,0,0,0);
INSERT INTO `fishing_bait` VALUES (16999,'Ball of Trout Paste',0,1,1,0,0,0);
INSERT INTO `fishing_bait` VALUES (17000,'Meatball',0,1,1,0,0,0);
INSERT INTO `fishing_bait` VALUES (17001,'Giant Shell Bug',0,1,1,0,0,0);
INSERT INTO `fishing_bait` VALUES (17002,'Robber Rig',1,1,1,72,0,0);
INSERT INTO `fishing_bait` VALUES (17003,'Super Scoop',0,3,1,32,0,0);
INSERT INTO `fishing_bait` VALUES (17004,'Judge Minnow',1,1,1,0,0,0);
INSERT INTO `fishing_bait` VALUES (17005,'Lufaise Fly',0,1,1,0,0,0);
INSERT INTO `fishing_bait` VALUES (17006,'Drill Calamary',0,1,1,0,0,0);
INSERT INTO `fishing_bait` VALUES (17007,'Dwarf Pugil',0,1,1,0,0,0);
INSERT INTO `fishing_bait` VALUES (17008,'Regular Maze Monger Ball',1,1,1,0,1,0);
INSERT INTO `fishing_bait` VALUES (17009,'Large Maze Monger Ball',1,1,1,0,1,0);
INSERT INTO `fishing_bait` VALUES (17010,'Goliath Worm',0,1,1,0,0,0);
INSERT INTO `fishing_bait` VALUES (17392,'Slice of Sardine',0,1,1,0,0,0);
INSERT INTO `fishing_bait` VALUES (17393,'Slice of Cod',0,1,1,0,0,0);
INSERT INTO `fishing_bait` VALUES (17394,'Peeled Lobster',0,1,1,0,0,0);
INSERT INTO `fishing_bait` VALUES (17395,'Lugworm',0,1,1,0,0,0);
INSERT INTO `fishing_bait` VALUES (17396,'Little Worm',0,1,1,0,0,0);
INSERT INTO `fishing_bait` VALUES (17397,'Shell Bug',0,1,1,0,0,0);
INSERT INTO `fishing_bait` VALUES (17398,'Rogue Rig',1,1,1,72,0,0);
INSERT INTO `fishing_bait` VALUES (17399,'Sabiki Rig',1,3,1,0,0,0);
INSERT INTO `fishing_bait` VALUES (17400,'Sinking Minnow',1,1,1,1,0,0);
INSERT INTO `fishing_bait` VALUES (17401,'Lizard Lure',1,1,1,0,0,0);
INSERT INTO `fishing_bait` VALUES (17402,'Shrimp Lure',1,1,1,0,0,0);
INSERT INTO `fishing_bait` VALUES (17403,'Frog Lure',1,1,1,0,0,0);
INSERT INTO `fishing_bait` VALUES (17404,'Worm Lure',1,1,1,0,0,0);
INSERT INTO `fishing_bait` VALUES (17405,'Fly Lure',1,1,1,16,0,0);
INSERT INTO `fishing_bait` VALUES (17406,'Judges Lure',1,1,1,0,0,0);
INSERT INTO `fishing_bait` VALUES (17407,'Minnow',1,1,1,0,0,0);
INSERT INTO `fishing_bait` VALUES (19323,'Maze Monger Minnow',2,1,1,0,1,0);
INSERT INTO `fishing_bait` VALUES (19324,'Dried Squid',2,1,1,0,0,0);
INSERT INTO `fishing_bait` VALUES (19325,'Judge Fly',1,1,1,0,0,0);
INSERT INTO `fishing_bait` VALUES (19326,'Sea Dragon Liver',0,1,1,0,0,0);
/*!40000 ALTER TABLE `fishing_bait` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-01-01  5:11:33
