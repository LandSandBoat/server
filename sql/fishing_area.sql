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
-- Table structure for table `fishing_area`
--

DROP TABLE IF EXISTS `fishing_area`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fishing_area` (
  `zoneid` smallint(5) unsigned NOT NULL,
  `areaid` smallint(5) unsigned NOT NULL,
  `name` varchar(64) NOT NULL,
  `bound_type` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `bound_height` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `bound_radius` smallint(5) unsigned NOT NULL DEFAULT '0',
  `bounds` blob,
  `center_x` float(7,3) NOT NULL DEFAULT '0.000',
  `center_y` float(7,3) NOT NULL DEFAULT '0.000',
  `center_z` float(7,3) NOT NULL DEFAULT '0.000',
  PRIMARY KEY (`zoneid`,`areaid`)
) ENGINE=Aria TRANSACTIONAL=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fishing_area`
--

LOCK TABLES `fishing_area` WRITE;
/*!40000 ALTER TABLE `fishing_area` DISABLE KEYS */;
INSERT INTO `fishing_area` VALUES (1,1,'Whole Zone',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (2,1,'South Landing',1,20,150,'',172.250,-2.000,-475.286);
INSERT INTO `fishing_area` VALUES (2,2,'Other Waterside South',1,20,60,'',-101.576,0.000,-484.401);
INSERT INTO `fishing_area` VALUES (2,3,'Other Waterside Center',1,20,60,'',-221.249,0.000,-283.157);
INSERT INTO `fishing_area` VALUES (2,4,'Other Waterside North',1,20,20,'',-179.219,1.000,-131.611);
INSERT INTO `fishing_area` VALUES (2,5,'Central Landing',1,20,80,'',-164.099,0.000,59.123);
INSERT INTO `fishing_area` VALUES (2,6,'North Landing',1,20,150,'',-332.920,-2.000,564.747);
INSERT INTO `fishing_area` VALUES (3,1,'Dhalmel Rock',0,0,0,'',0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (3,2,'Maliyakaleya Reef',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (3,3,'Purgonorgo Isle',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (4,1,'PI - South Beach',2,20,0,0x0000DCC300000000000057C4000082C300000000000057C4000082C300000000000075C40000E1C300000000000075C4,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (4,2,'PI - North Beach',1,20,150,'',-360.000,0.000,-390.000);
INSERT INTO `fishing_area` VALUES (4,3,'PI - West Beach',1,20,150,'',-660.000,0.000,-680.000);
INSERT INTO `fishing_area` VALUES (4,4,'PI - East Beach',1,20,150,'',-110.000,0.000,-640.000);
INSERT INTO `fishing_area` VALUES (4,5,'BB - South Seaside',1,50,40,'',309.000,-10.000,186.000);
INSERT INTO `fishing_area` VALUES (4,6,'BB - Other Seaside',0,0,0,'',0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (11,1,'Whole Zone',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (24,1,'Leremieu Lagoon',1,20,50,'',96.000,-5.000,28.000);
INSERT INTO `fishing_area` VALUES (24,2,'Seaside',1,20,60,'',0.000,0.000,-320.000);
INSERT INTO `fishing_area` VALUES (24,3,'Rafeloux River',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (25,1,'Cascade Edellaine',1,20,62,'',-192.000,-15.000,640.000);
INSERT INTO `fishing_area` VALUES (25,2,'Seaside',1,20,100,'',700.000,0.000,-535.000);
INSERT INTO `fishing_area` VALUES (25,3,'Rafeloux River',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (26,1,'Whole Zone',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (27,1,'Whole Zone',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (46,1,'Whole Zone',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (47,1,'Whole Zone',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (48,1,'Whole Zone',0,0,0,'',0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (50,1,'Whole Zone',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (51,1,'Whole Zone',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (52,1,'Whole Zone',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (53,1,'Whole Zone',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (54,1,'Whole Zone',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (57,1,'Whole Zone',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (58,1,'Whole Zone',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (59,1,'Whole Zone',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (61,1,'Whole Zone',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (65,1,'Pond',1,20,60,'',-103.000,11.000,-65.000);
INSERT INTO `fishing_area` VALUES (65,2,'Other Waterside',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (68,1,'Whole Zone',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (79,1,'Whole Zone',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (100,1,'Knightwell',0,0,0,'',0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (101,1,'Whole Zone',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (102,1,'Whole Zone',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (103,1,'Whole Zone',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (104,1,'Crystalwater Spring',1,20,20,'',300.000,1.000,-179.833);
INSERT INTO `fishing_area` VALUES (104,2,'Lake Mechieume - Mouth',1,20,31,'',19.458,3.000,334.528);
INSERT INTO `fishing_area` VALUES (104,3,'Lake Mechieume - Main',2,20,0,0xC1CA2BC30000000010981544DF4F0B430000000064D3114477DE0D4300000000EC41A143235B30C3000000006871A343,0.000,5.000,0.000);
INSERT INTO `fishing_area` VALUES (104,4,'Maidens Spring',1,20,22,'',-496.682,9.000,298.057);
INSERT INTO `fishing_area` VALUES (104,5,'River',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (105,1,'North Seaside',1,20,200,'',291.891,7.000,198.639);
INSERT INTO `fishing_area` VALUES (105,2,'South Seaside',1,20,150,'',102.172,8.000,-489.808);
INSERT INTO `fishing_area` VALUES (106,1,'Basin of Waterfall',1,20,27,'',-230.433,96.000,462.000);
INSERT INTO `fishing_area` VALUES (106,2,'River',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (107,1,'Hot Springs',1,20,150,'',-485.042,44.000,-415.916);
INSERT INTO `fishing_area` VALUES (107,2,'Seaside',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (109,1,'Whole Zone',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (110,1,'Small Fountain 1',1,20,20,'',-538.750,-14.000,-179.103);
INSERT INTO `fishing_area` VALUES (110,2,'Fountain of Promises',1,20,70,'',-670.355,-21.000,-175.250);
INSERT INTO `fishing_area` VALUES (110,3,'Fountain of Partings',1,20,60,'',-721.715,-26.000,-423.003);
INSERT INTO `fishing_area` VALUES (110,4,'Small Fountain 2',1,20,20,'',257.238,-30.000,-258.576);
INSERT INTO `fishing_area` VALUES (111,1,'Seaside',1,20,150,'',435.000,-1.000,-92.000);
INSERT INTO `fishing_area` VALUES (111,2,'Ponds',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (113,1,'Whole Zone',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (114,1,'Whole Zone',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (115,1,'Pond',1,20,25,'',110.000,-1.000,-200.000);
INSERT INTO `fishing_area` VALUES (115,2,'Seaside',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (116,1,'Seaside',2,20,0,0x6666E2C1000000000A372AC49A9941C1000000005C3F32C43333BEC200000000D79333C4004006C300000000F6F825C4291C03C3000000009AA920C4,0.000,9.000,0.000);
INSERT INTO `fishing_area` VALUES (116,2,'Other Waterside (south)',1,20,25,'',-144.690,-5.000,-360.580);
INSERT INTO `fishing_area` VALUES (116,3,'Other Waterside (west)',1,20,25,'',-237.236,-1.000,-224.762);
INSERT INTO `fishing_area` VALUES (116,4,'Other Waterside (rivers)',2,50,0,0x7B146DC2000000007B1477C2D763A7C300000000CDCC78C2C355A3C300000000CD6C3644B89E054400000000F638364400800644000000009A597BC348E158C200000000AE074CC3,0.000,-12.000,0.000);
INSERT INTO `fishing_area` VALUES (116,5,'Lake Tepokalipuka',2,20,0,0x0000B4C30000000000004CC30000B4C300000000000096C2A4707FC300000000000096C233F36BC300000000EC51E6C2523894C200000000F628E7C266E6A2C2000000003D8A2AC37BD478C3000000007B1429C3CD8C83C3000000005CCF46C3,0.000,-1.000,0.000);
INSERT INTO `fishing_area` VALUES (118,1,'Whole Zone',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (120,1,'Whole Zone',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (121,1,'Whole Zone',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (122,1,'Whole Zone',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (123,1,'Northeast Pond',1,20,15,'',380.000,21.000,296.000);
INSERT INTO `fishing_area` VALUES (123,2,'Gremini Falls',1,20,32,'',428.000,20.000,278.000);
INSERT INTO `fishing_area` VALUES (123,3,'Southwest Pond',1,20,15,'',-340.000,16.000,-456.000);
INSERT INTO `fishing_area` VALUES (123,4,'Southwest Waterfall - South',1,20,28,'',-458.000,17.000,-446.000);
INSERT INTO `fishing_area` VALUES (123,5,'Southwest Waterfall - North',1,20,45,'',-446.000,17.000,-379.000);
INSERT INTO `fishing_area` VALUES (123,6,'Other Waterside',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (124,1,'Front of Temple - East Side',1,20,33,'',332.000,3.500,-514.000);
INSERT INTO `fishing_area` VALUES (124,2,'Front of Temple - West Side',1,20,32,'',275.000,3.500,-514.000);
INSERT INTO `fishing_area` VALUES (124,3,'Teardrop Spring',1,20,20,'',539.000,0.000,-420.000);
INSERT INTO `fishing_area` VALUES (124,4,'Underground Pool 1',1,10,10,'',106.000,9.000,-577.000);
INSERT INTO `fishing_area` VALUES (124,5,'Bloodlet Spring',1,20,20,'',219.000,-1.000,60.000);
INSERT INTO `fishing_area` VALUES (124,6,'Underground Pool 3',1,10,10,'',-496.000,9.000,-186.000);
INSERT INTO `fishing_area` VALUES (124,7,'Underground Pool 2',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (125,1,'Oasis of Hubol',1,20,50,'',-640.000,2.000,-313.000);
INSERT INTO `fishing_area` VALUES (125,2,'Central Spring',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (126,1,'Northwest Seaside',1,20,80,'',-100.000,-21.000,390.000);
INSERT INTO `fishing_area` VALUES (126,2,'Southwest Seaside',1,20,90,'',15.000,-19.000,-83.000);
INSERT INTO `fishing_area` VALUES (126,3,'Other Seaside',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (130,1,'Whole Zone',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (140,1,'Pond North',1,20,12,'',-174.165,-21.000,414.486);
INSERT INTO `fishing_area` VALUES (140,2,'Pond South',1,20,15,'',-215.293,-10.000,25.168);
INSERT INTO `fishing_area` VALUES (140,3,'River',0,0,0,'',0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (142,1,'Whole Zone',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (143,1,'Whole Zone',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (145,1,'Giddeus Spring',1,20,15,'',224.758,-2.000,-296.078);
INSERT INTO `fishing_area` VALUES (145,2,'Pond - West',1,20,15,'',-254.810,-2.000,-255.620);
INSERT INTO `fishing_area` VALUES (145,3,'Pond - North',1,20,20,'',-100.000,1.500,-140.000);
INSERT INTO `fishing_area` VALUES (145,4,'Misc Puddles',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (149,1,'Basin of a Waterfall',1,20,10,'',180.240,3.000,-384.460);
INSERT INTO `fishing_area` VALUES (149,2,'Wailing Pond',1,20,20,'',382.240,0.000,-180.410);
INSERT INTO `fishing_area` VALUES (149,3,'Pond',1,20,50,'',198.750,2.000,-107.220);
INSERT INTO `fishing_area` VALUES (149,4,'Other Waterside',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (151,1,'PLD AF Fishing Spot',1,10,15,'',-80.000,24.000,-40.000);
INSERT INTO `fishing_area` VALUES (151,2,'Whole Zone',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (153,1,'Waterfall Basin',1,20,27,'',45.000,-18.000,-173.000);
INSERT INTO `fishing_area` VALUES (153,2,'Waterfall Basin - Hidden',1,20,20,'',-244.000,10.000,-278.000);
INSERT INTO `fishing_area` VALUES (153,3,'Other Waterside',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (154,1,'Whole Zone',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (157,1,'Whole Zone',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (158,1,'Whole Zone',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (159,1,'Whole Zone',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (160,1,'Pool E-8',1,20,20,'',175.000,17.000,176.000);
INSERT INTO `fishing_area` VALUES (160,2,'Pool F-11',1,20,20,'',-24.000,17.000,-216.000);
INSERT INTO `fishing_area` VALUES (160,3,'Misc Water',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (166,1,'Whole Zone',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (167,1,'Whole Zone',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (172,1,'River',1,20,20,'',-100.310,-1.000,20.168);
INSERT INTO `fishing_area` VALUES (172,2,'Pool',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (173,1,'Salt Water',2,20,0,0x000090C20000000000001643000034C20000000000001643000034C200000000000050C2000090C200000000000050C2,0.000,-2.000,0.000);
INSERT INTO `fishing_area` VALUES (173,2,'Fresh Water',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (174,1,'Whole Zone',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (176,1,'Other Seaside',1,20,20,'',26.600,10.000,182.000);
INSERT INTO `fishing_area` VALUES (176,2,'Pond Under a Bridge',1,20,22,'',100.000,10.000,-19.000);
INSERT INTO `fishing_area` VALUES (176,3,'Interior of Hidden Door - Mythril',1,20,20,'',-306.000,21.000,-62.000);
INSERT INTO `fishing_area` VALUES (176,4,'Interior of Hidden Door - Gold',1,20,20,'',-256.000,51.000,-345.000);
INSERT INTO `fishing_area` VALUES (176,5,'Misc Puddles',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (178,1,'Whole Zone',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (184,1,'Whole Zone',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (191,1,'Whole Zone',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (193,1,'Whole Zone',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (196,1,'Pool Upper West',1,20,12,'',-136.705,-59.000,-99.459);
INSERT INTO `fishing_area` VALUES (196,2,'Pool Upper East',1,20,12,'',216.119,-59.000,-100.126);
INSERT INTO `fishing_area` VALUES (196,3,'Pool Lower East',1,20,12,'',176.517,-39.000,-19.909);
INSERT INTO `fishing_area` VALUES (196,4,'Interior Pool West',1,20,25,'',-80.224,-27.000,446.559);
INSERT INTO `fishing_area` VALUES (196,5,'Interior Pool Center',1,20,25,'',39.236,-11.000,446.130);
INSERT INTO `fishing_area` VALUES (196,6,'Interior Pool East',1,20,25,'',120.311,-19.000,446.192);
INSERT INTO `fishing_area` VALUES (204,1,'Whole Zone',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (208,1,'Whole Zone',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (212,1,'Whole Zone',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (213,1,'Whole Zone',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (220,1,'Whole Zone',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (221,1,'Whole Zone',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (227,1,'Whole Zone',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (228,1,'Whole Zone',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (231,1,'Whole Zone',0,0,0,'',0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (232,1,'Whole Zone',0,0,0,'',0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (234,1,'Whole Zone',0,0,0,'',0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (235,1,'North Side',2,20,0,0xE32E85C3000000008262F4C11CEB1CC1000000007446D4C1098AF1C000000000D22FEDC2DDA404C300000000D676EFC2219039C3000000001EB6BCC221D058C3000000007328C1C254A363C300000000FFB2E9C2DC5778C3000000001846EFC2DC8F86C3000000008FD3DBC2,0.000,-6.000,0.000);
INSERT INTO `fishing_area` VALUES (235,2,'South Side',0,0,0,'',0.000,-6.000,0.000);
INSERT INTO `fishing_area` VALUES (236,1,'Whole Zone',0,0,0,'',0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (237,1,'Whole Zone',0,0,0,'',0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (238,1,'Whole Zone',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (239,1,'Whole Zone',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (240,1,'Whole Zone',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (241,1,'Whole Zone',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (242,1,'Whole Zone',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (245,1,'Whole Zone',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (246,1,'Whole Zone',0,0,0,'',0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (247,1,'Whole Zone',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (248,1,'Whole Zone',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (249,1,'Whole Zone',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (250,1,'Whole Zone',0,0,0,NULL,0.000,0.000,0.000);
INSERT INTO `fishing_area` VALUES (252,1,'Whole Zone',0,0,0,NULL,0.000,0.000,0.000);
/*!40000 ALTER TABLE `fishing_area` ENABLE KEYS */;
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
