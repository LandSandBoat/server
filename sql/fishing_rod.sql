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
-- Table structure for table `fishing_rod`
--

DROP TABLE IF EXISTS `fishing_rod`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fishing_rod` (
  `rodid` int(10) unsigned NOT NULL,
  `name` varchar(64) NOT NULL,
  `material` tinyint(2) unsigned NOT NULL,
  `size_type` tinyint(3) unsigned NOT NULL,
  `flags` int(11) unsigned NOT NULL DEFAULT '0',
  `min_rank` smallint(5) unsigned NOT NULL DEFAULT '0',
  `max_rank` smallint(5) unsigned NOT NULL DEFAULT '0',
  `fish_attack` tinyint(3) unsigned NOT NULL,
  `lgd_bonus_attack` tinyint(3) unsigned NOT NULL,
  `fish_recovery` tinyint(3) unsigned NOT NULL,
  `fish_time` tinyint(3) unsigned NOT NULL,
  `lgd_bonus_time` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `sm_delay_bonus` tinyint(2) unsigned NOT NULL,
  `sm_move_bonus` tinyint(2) unsigned NOT NULL,
  `lg_delay_bonus` tinyint(2) unsigned NOT NULL,
  `lg_move_bonus` tinyint(2) unsigned NOT NULL,
  `multiplier` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `breakable` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `broken_rodid` int(10) unsigned NOT NULL,
  `mmm` tinyint(2) unsigned NOT NULL,
  `legendary` tinyint(2) unsigned NOT NULL,
  `rating` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`rodid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fishing_rod`
--

LOCK TABLES `fishing_rod` WRITE;
/*!40000 ALTER TABLE `fishing_rod` DISABLE KEYS */;
INSERT INTO `fishing_rod` VALUES (17011,'Ebisu Fishing Rod',1,0,4,1,30,100,50,50,30,10,2,1,1,0,3,0,0,0,1,15);
INSERT INTO `fishing_rod` VALUES (17012,'Judges Rod',1,0,0,1,40,200,100,100,60,30,2,1,1,0,5,0,0,0,1,16);
INSERT INTO `fishing_rod` VALUES (17013,'Goldfish Basket',0,0,8,1,5,100,0,50,20,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `fishing_rod` VALUES (17014,'Hume Fishing Rod',0,0,2,1,10,125,0,65,30,0,2,1,0,2,3,1,1832,0,0,6);
INSERT INTO `fishing_rod` VALUES (17015,'Halcyon Rod',1,0,2,1,18,100,0,70,41,0,2,1,0,2,3,1,1833,0,0,9);
INSERT INTO `fishing_rod` VALUES (17380,'Mithran Fishing Rod',0,1,1,8,18,130,0,65,30,0,0,0,1,0,3,1,483,0,0,12);
INSERT INTO `fishing_rod` VALUES (17381,'Composite Fishing Rod',1,1,1,11,24,100,0,70,43,0,0,0,1,0,2,1,473,0,0,13);
INSERT INTO `fishing_rod` VALUES (17382,'Single Hook Fishing Rod',1,1,1,14,22,100,0,80,45,0,0,0,1,0,3,1,472,0,0,11);
INSERT INTO `fishing_rod` VALUES (17383,'Clothespole',0,1,1,12,16,170,0,50,30,0,0,0,1,0,3,1,482,0,0,10);
INSERT INTO `fishing_rod` VALUES (17384,'Carbon Fishing Rod',1,0,0,1,13,100,0,75,43,0,2,1,1,0,4,1,490,0,0,7);
INSERT INTO `fishing_rod` VALUES (17385,'Glass Fiber Fishing Rod',1,0,0,1,12,100,0,80,45,0,2,1,1,0,4,1,491,0,0,8);
INSERT INTO `fishing_rod` VALUES (17386,'Lu Shang\'s Fishing Rod',0,0,0,1,28,110,20,100,40,10,2,1,1,0,2,1,489,0,1,14);
INSERT INTO `fishing_rod` VALUES (17387,'Tarutaru Fishing Rod',0,0,0,1,9,130,0,70,30,0,2,1,1,0,4,1,484,0,0,5);
INSERT INTO `fishing_rod` VALUES (17388,'Fastwater Fishing Rod',0,0,0,1,7,135,0,65,30,0,2,1,1,0,2,1,488,0,0,4);
INSERT INTO `fishing_rod` VALUES (17389,'Bamboo Fishing Rod',0,0,0,1,8,140,0,60,30,0,2,1,1,0,2,1,487,0,0,3);
INSERT INTO `fishing_rod` VALUES (17390,'Yew Fishing Rod',0,0,0,1,6,145,0,55,30,0,2,1,1,0,2,1,486,0,0,2);
INSERT INTO `fishing_rod` VALUES (17391,'Willow Fishing Rod',0,0,0,1,5,150,0,50,30,0,2,1,1,0,2,1,485,0,0,1);
INSERT INTO `fishing_rod` VALUES (19319,'Maze Monger Fishing Rod',1,0,0,1,25,100,0,100,30,0,2,1,1,10,2,1,2526,1,0,0);
INSERT INTO `fishing_rod` VALUES (19320,'Lu Shang\'s Fishing Rod +1',0,0,0,1,28,110,20,100,50,10,2,1,1,0,2,1,9091,0,1,14);
INSERT INTO `fishing_rod` VALUES (19321,'Ebisu Fishing Rod +1',1,0,4,1,30,100,50,50,40,10,2,1,1,0,3,0,0,0,1,15);
/*!40000 ALTER TABLE `fishing_rod` ENABLE KEYS */;
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
