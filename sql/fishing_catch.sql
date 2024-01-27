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
-- Table structure for table `fishing_catch`
--

DROP TABLE IF EXISTS `fishing_catch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fishing_catch` (
  `zoneid` smallint(5) unsigned NOT NULL,
  `areaid` tinyint(3) unsigned NOT NULL,
  `groupid` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`zoneid`,`areaid`,`groupid`)
) ENGINE=Aria TRANSACTIONAL=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci AVG_ROW_LENGTH=27;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fishing_catch`
--

LOCK TABLES `fishing_catch` WRITE;
/*!40000 ALTER TABLE `fishing_catch` DISABLE KEYS */;
INSERT INTO `fishing_catch` VALUES (1,1,139);
INSERT INTO `fishing_catch` VALUES (2,1,28);
INSERT INTO `fishing_catch` VALUES (2,2,29);
INSERT INTO `fishing_catch` VALUES (2,3,29);
INSERT INTO `fishing_catch` VALUES (2,4,29);
INSERT INTO `fishing_catch` VALUES (2,5,30);
INSERT INTO `fishing_catch` VALUES (2,6,28);
INSERT INTO `fishing_catch` VALUES (3,1,68);
INSERT INTO `fishing_catch` VALUES (4,1,61);
INSERT INTO `fishing_catch` VALUES (4,2,62);
INSERT INTO `fishing_catch` VALUES (4,3,63);
INSERT INTO `fishing_catch` VALUES (4,4,63);
INSERT INTO `fishing_catch` VALUES (4,5,64);
INSERT INTO `fishing_catch` VALUES (4,6,65);
INSERT INTO `fishing_catch` VALUES (11,1,119);
INSERT INTO `fishing_catch` VALUES (24,1,120);
INSERT INTO `fishing_catch` VALUES (24,2,121);
INSERT INTO `fishing_catch` VALUES (24,3,122);
INSERT INTO `fishing_catch` VALUES (25,1,123);
INSERT INTO `fishing_catch` VALUES (25,2,121);
INSERT INTO `fishing_catch` VALUES (25,3,122);
INSERT INTO `fishing_catch` VALUES (26,1,40);
INSERT INTO `fishing_catch` VALUES (27,1,72);
INSERT INTO `fishing_catch` VALUES (46,1,135);
INSERT INTO `fishing_catch` VALUES (47,1,135);
INSERT INTO `fishing_catch` VALUES (48,1,125);
INSERT INTO `fishing_catch` VALUES (50,1,124);
INSERT INTO `fishing_catch` VALUES (51,1,129);
INSERT INTO `fishing_catch` VALUES (52,1,126);
INSERT INTO `fishing_catch` VALUES (53,1,133);
INSERT INTO `fishing_catch` VALUES (54,1,131);
INSERT INTO `fishing_catch` VALUES (57,1,134);
INSERT INTO `fishing_catch` VALUES (58,1,138);
INSERT INTO `fishing_catch` VALUES (59,1,138);
INSERT INTO `fishing_catch` VALUES (61,1,130);
INSERT INTO `fishing_catch` VALUES (65,1,128);
INSERT INTO `fishing_catch` VALUES (65,2,40);
INSERT INTO `fishing_catch` VALUES (68,1,127);
INSERT INTO `fishing_catch` VALUES (79,1,132);
INSERT INTO `fishing_catch` VALUES (100,1,17);
INSERT INTO `fishing_catch` VALUES (101,1,16);
INSERT INTO `fishing_catch` VALUES (102,1,23);
INSERT INTO `fishing_catch` VALUES (103,1,26);
INSERT INTO `fishing_catch` VALUES (104,1,35);
INSERT INTO `fishing_catch` VALUES (104,2,36);
INSERT INTO `fishing_catch` VALUES (104,3,37);
INSERT INTO `fishing_catch` VALUES (104,4,38);
INSERT INTO `fishing_catch` VALUES (104,5,39);
INSERT INTO `fishing_catch` VALUES (105,1,27);
INSERT INTO `fishing_catch` VALUES (105,2,27);
INSERT INTO `fishing_catch` VALUES (106,1,43);
INSERT INTO `fishing_catch` VALUES (106,2,44);
INSERT INTO `fishing_catch` VALUES (107,1,46);
INSERT INTO `fishing_catch` VALUES (107,2,47);
INSERT INTO `fishing_catch` VALUES (109,1,50);
INSERT INTO `fishing_catch` VALUES (110,1,51);
INSERT INTO `fishing_catch` VALUES (110,2,52);
INSERT INTO `fishing_catch` VALUES (110,3,53);
INSERT INTO `fishing_catch` VALUES (110,4,54);
INSERT INTO `fishing_catch` VALUES (111,1,74);
INSERT INTO `fishing_catch` VALUES (111,2,75);
INSERT INTO `fishing_catch` VALUES (113,1,92);
INSERT INTO `fishing_catch` VALUES (114,1,87);
INSERT INTO `fishing_catch` VALUES (115,1,59);
INSERT INTO `fishing_catch` VALUES (115,2,60);
INSERT INTO `fishing_catch` VALUES (116,1,2);
INSERT INTO `fishing_catch` VALUES (116,2,3);
INSERT INTO `fishing_catch` VALUES (116,3,3);
INSERT INTO `fishing_catch` VALUES (116,4,3);
INSERT INTO `fishing_catch` VALUES (116,5,1);
INSERT INTO `fishing_catch` VALUES (118,1,66);
INSERT INTO `fishing_catch` VALUES (120,1,73);
INSERT INTO `fishing_catch` VALUES (121,1,86);
INSERT INTO `fishing_catch` VALUES (122,1,85);
INSERT INTO `fishing_catch` VALUES (123,1,101);
INSERT INTO `fishing_catch` VALUES (123,2,102);
INSERT INTO `fishing_catch` VALUES (123,3,103);
INSERT INTO `fishing_catch` VALUES (123,4,104);
INSERT INTO `fishing_catch` VALUES (123,5,105);
INSERT INTO `fishing_catch` VALUES (123,6,106);
INSERT INTO `fishing_catch` VALUES (124,1,111);
INSERT INTO `fishing_catch` VALUES (124,2,112);
INSERT INTO `fishing_catch` VALUES (124,3,113);
INSERT INTO `fishing_catch` VALUES (124,4,114);
INSERT INTO `fishing_catch` VALUES (124,5,115);
INSERT INTO `fishing_catch` VALUES (124,6,116);
INSERT INTO `fishing_catch` VALUES (124,7,117);
INSERT INTO `fishing_catch` VALUES (125,1,90);
INSERT INTO `fishing_catch` VALUES (125,2,91);
INSERT INTO `fishing_catch` VALUES (126,1,78);
INSERT INTO `fishing_catch` VALUES (126,2,79);
INSERT INTO `fishing_catch` VALUES (126,3,80);
INSERT INTO `fishing_catch` VALUES (130,1,118);
INSERT INTO `fishing_catch` VALUES (140,1,18);
INSERT INTO `fishing_catch` VALUES (140,2,18);
INSERT INTO `fishing_catch` VALUES (140,3,19);
INSERT INTO `fishing_catch` VALUES (142,1,20);
INSERT INTO `fishing_catch` VALUES (143,1,45);
INSERT INTO `fishing_catch` VALUES (145,1,55);
INSERT INTO `fishing_catch` VALUES (145,2,56);
INSERT INTO `fishing_catch` VALUES (145,3,57);
INSERT INTO `fishing_catch` VALUES (145,4,58);
INSERT INTO `fishing_catch` VALUES (149,1,31);
INSERT INTO `fishing_catch` VALUES (149,2,32);
INSERT INTO `fishing_catch` VALUES (149,3,33);
INSERT INTO `fishing_catch` VALUES (149,4,34);
INSERT INTO `fishing_catch` VALUES (151,1,0);
INSERT INTO `fishing_catch` VALUES (151,2,72);
INSERT INTO `fishing_catch` VALUES (153,1,81);
INSERT INTO `fishing_catch` VALUES (153,2,82);
INSERT INTO `fishing_catch` VALUES (153,3,83);
INSERT INTO `fishing_catch` VALUES (154,1,84);
INSERT INTO `fishing_catch` VALUES (157,1,77);
INSERT INTO `fishing_catch` VALUES (158,1,77);
INSERT INTO `fishing_catch` VALUES (159,1,110);
INSERT INTO `fishing_catch` VALUES (160,1,107);
INSERT INTO `fishing_catch` VALUES (160,2,108);
INSERT INTO `fishing_catch` VALUES (160,3,109);
INSERT INTO `fishing_catch` VALUES (166,1,72);
INSERT INTO `fishing_catch` VALUES (167,1,15);
INSERT INTO `fishing_catch` VALUES (172,1,48);
INSERT INTO `fishing_catch` VALUES (172,2,49);
INSERT INTO `fishing_catch` VALUES (173,1,41);
INSERT INTO `fishing_catch` VALUES (173,2,42);
INSERT INTO `fishing_catch` VALUES (174,1,93);
INSERT INTO `fishing_catch` VALUES (176,1,96);
INSERT INTO `fishing_catch` VALUES (176,2,97);
INSERT INTO `fishing_catch` VALUES (176,3,98);
INSERT INTO `fishing_catch` VALUES (176,4,99);
INSERT INTO `fishing_catch` VALUES (176,5,100);
INSERT INTO `fishing_catch` VALUES (178,1,118);
INSERT INTO `fishing_catch` VALUES (184,1,77);
INSERT INTO `fishing_catch` VALUES (191,1,40);
INSERT INTO `fishing_catch` VALUES (193,1,24);
INSERT INTO `fishing_catch` VALUES (196,1,22);
INSERT INTO `fishing_catch` VALUES (196,2,22);
INSERT INTO `fishing_catch` VALUES (196,3,22);
INSERT INTO `fishing_catch` VALUES (196,4,21);
INSERT INTO `fishing_catch` VALUES (196,5,21);
INSERT INTO `fishing_catch` VALUES (196,6,21);
INSERT INTO `fishing_catch` VALUES (204,1,76);
INSERT INTO `fishing_catch` VALUES (208,1,88);
INSERT INTO `fishing_catch` VALUES (213,1,67);
INSERT INTO `fishing_catch` VALUES (220,1,136);
INSERT INTO `fishing_catch` VALUES (221,1,136);
INSERT INTO `fishing_catch` VALUES (227,1,137);
INSERT INTO `fishing_catch` VALUES (228,1,137);
INSERT INTO `fishing_catch` VALUES (231,1,9);
INSERT INTO `fishing_catch` VALUES (232,1,10);
INSERT INTO `fishing_catch` VALUES (234,1,8);
INSERT INTO `fishing_catch` VALUES (235,1,5);
INSERT INTO `fishing_catch` VALUES (235,2,6);
INSERT INTO `fishing_catch` VALUES (236,1,7);
INSERT INTO `fishing_catch` VALUES (238,1,11);
INSERT INTO `fishing_catch` VALUES (239,1,11);
INSERT INTO `fishing_catch` VALUES (240,1,4);
INSERT INTO `fishing_catch` VALUES (241,1,11);
INSERT INTO `fishing_catch` VALUES (242,1,12);
INSERT INTO `fishing_catch` VALUES (245,1,13);
INSERT INTO `fishing_catch` VALUES (246,1,14);
INSERT INTO `fishing_catch` VALUES (247,1,89);
INSERT INTO `fishing_catch` VALUES (248,1,25);
INSERT INTO `fishing_catch` VALUES (249,1,71);
INSERT INTO `fishing_catch` VALUES (250,1,94);
INSERT INTO `fishing_catch` VALUES (252,1,95);
/*!40000 ALTER TABLE `fishing_catch` ENABLE KEYS */;
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
