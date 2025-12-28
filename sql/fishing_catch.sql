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
INSERT INTO `fishing_catch` VALUES (1,1,139);     -- Phanauet Channel, Whole Zone
INSERT INTO `fishing_catch` VALUES (2,1,28);      -- Carpenters' Landing, South Landing
INSERT INTO `fishing_catch` VALUES (2,2,29);      -- Carpenters' Landing, Other Waterside South
INSERT INTO `fishing_catch` VALUES (2,3,29);      -- Carpenters' Landing, Other Waterside Center
INSERT INTO `fishing_catch` VALUES (2,4,29);      -- Carpenters' Landing, Other Waterside North
INSERT INTO `fishing_catch` VALUES (2,5,30);      -- Carpenters' Landing, Central Landing
INSERT INTO `fishing_catch` VALUES (2,6,28);      -- Carpenters' Landing, North Landing
INSERT INTO `fishing_catch` VALUES (3,1,68);      -- Manaclipper, Dhalmel Rock
INSERT INTO `fishing_catch` VALUES (4,1,61);      -- Bibiki Bay, PI - South Beach
INSERT INTO `fishing_catch` VALUES (4,2,62);      -- Bibiki Bay, PI - North Beach
INSERT INTO `fishing_catch` VALUES (4,3,63);      -- Bibiki Bay, PI - West Beach
INSERT INTO `fishing_catch` VALUES (4,4,63);      -- Bibiki Bay, PI - East Beach
INSERT INTO `fishing_catch` VALUES (4,5,64);      -- Bibiki Bay, BB - South Seaside
INSERT INTO `fishing_catch` VALUES (4,6,65);      -- Bibiki Bay, BB - Other Seaside
INSERT INTO `fishing_catch` VALUES (11,1,119);    -- Oldton Movalpolos, Whole Zone
INSERT INTO `fishing_catch` VALUES (24,1,120);    -- Lufaise Meadows, Leremieu Lagoon
INSERT INTO `fishing_catch` VALUES (24,2,121);    -- Lufaise Meadows, Seaside
INSERT INTO `fishing_catch` VALUES (24,3,122);    -- Lufaise Meadows, Rafeloux River
INSERT INTO `fishing_catch` VALUES (25,1,123);    -- Misareaux Coast, Cascade Edellaine
INSERT INTO `fishing_catch` VALUES (25,2,121);    -- Misareaux Coast, Seaside
INSERT INTO `fishing_catch` VALUES (25,3,122);    -- Misareaux Coast, Rafeloux River
INSERT INTO `fishing_catch` VALUES (26,1,40);     -- Tavnazian Safehold, Whole Zone
INSERT INTO `fishing_catch` VALUES (27,1,72);     -- Phomiuna Aqueducts, Whole Zone
INSERT INTO `fishing_catch` VALUES (46,1,135);    -- Open sea route to Al Zahbi, Whole Zone
INSERT INTO `fishing_catch` VALUES (47,1,135);    -- Open sea route to Mhaura, Whole Zone
INSERT INTO `fishing_catch` VALUES (48,1,125);    -- Al Zahbi, Whole Zone
INSERT INTO `fishing_catch` VALUES (50,1,124);    -- Aht Urhgan Whitegate, Whole Zone
INSERT INTO `fishing_catch` VALUES (51,1,129);    -- Wajaom Woodlands, Whole Zone
INSERT INTO `fishing_catch` VALUES (52,1,126);    -- Bhaflau Thickets, Whole Zone
INSERT INTO `fishing_catch` VALUES (53,1,133);    -- Nashmau, Whole Zone
INSERT INTO `fishing_catch` VALUES (54,1,131);    -- Arrapago Reef, Whole Zone
INSERT INTO `fishing_catch` VALUES (57,1,134);    -- Talacca Cove, Whole Zone
INSERT INTO `fishing_catch` VALUES (58,1,138);    -- Silver Sea route to Nashmau, Whole Zone
INSERT INTO `fishing_catch` VALUES (59,1,138);    -- Silver Sea route to Al Zahbi, Whole Zone
INSERT INTO `fishing_catch` VALUES (61,1,130);    -- Mount Zhayolm, Whole Zone
INSERT INTO `fishing_catch` VALUES (65,1,128);    -- Mamook, Pond
INSERT INTO `fishing_catch` VALUES (65,2,40);     -- Mamook, Other Waterside
INSERT INTO `fishing_catch` VALUES (68,1,127);    -- Aydeewa Subterrane, Whole Zone
INSERT INTO `fishing_catch` VALUES (79,1,132);    -- Caedarva Mire, Whole Zone
INSERT INTO `fishing_catch` VALUES (100,1,17);    -- West Ronfaure, Knightwell
INSERT INTO `fishing_catch` VALUES (101,1,16);    -- East Ronfaure, Whole Zone
INSERT INTO `fishing_catch` VALUES (102,1,23);    -- La Theine Plateau, Whole Zone
INSERT INTO `fishing_catch` VALUES (103,1,26);    -- Valkurm Dunes, Whole Zone
INSERT INTO `fishing_catch` VALUES (104,1,35);    -- Jugner Forest, Crystalwater Spring
INSERT INTO `fishing_catch` VALUES (104,2,36);    -- Jugner Forest, Lake Mechieume - Mouth
INSERT INTO `fishing_catch` VALUES (104,3,37);    -- Jugner Forest, Lake Mechieume - Main
INSERT INTO `fishing_catch` VALUES (104,4,38);    -- Jugner Forest, Maidens Spring
INSERT INTO `fishing_catch` VALUES (104,5,39);    -- Jugner Forest, River
INSERT INTO `fishing_catch` VALUES (105,1,27);    -- Batallia Downs, North Seaside
INSERT INTO `fishing_catch` VALUES (105,2,27);    -- Batallia Downs, South Seaside
INSERT INTO `fishing_catch` VALUES (106,1,43);    -- North Gustaberg, Basin of Waterfall
INSERT INTO `fishing_catch` VALUES (106,2,44);    -- North Gustaberg, River
INSERT INTO `fishing_catch` VALUES (107,1,46);    -- South Gustaberg, Hot Springs
INSERT INTO `fishing_catch` VALUES (107,2,47);    -- South Gustaberg, Seaside
INSERT INTO `fishing_catch` VALUES (109,1,50);    -- Pashhow Marshlands, Whole Zone
INSERT INTO `fishing_catch` VALUES (110,1,51);    -- Rolanberry Fields, Small Fountain 1
INSERT INTO `fishing_catch` VALUES (110,2,52);    -- Rolanberry Fields, Fountain of Promises
INSERT INTO `fishing_catch` VALUES (110,3,53);    -- Rolanberry Fields, Fountain of Partings
INSERT INTO `fishing_catch` VALUES (110,4,54);    -- Rolanberry Fields, Small Fountain 2
INSERT INTO `fishing_catch` VALUES (111,1,74);    -- Beaucedine Glacier, Seaside
INSERT INTO `fishing_catch` VALUES (111,2,75);    -- Beaucedine Glacier, Ponds
INSERT INTO `fishing_catch` VALUES (113,1,92);    -- Cape Teriggan, Whole Zone
INSERT INTO `fishing_catch` VALUES (114,1,87);    -- Eastern Altepa Desert, Whole Zone
INSERT INTO `fishing_catch` VALUES (115,1,59);    -- West Sarutabaruta, Pond
INSERT INTO `fishing_catch` VALUES (115,2,60);    -- West Sarutabaruta, Seaside
INSERT INTO `fishing_catch` VALUES (116,1,2);     -- East Sarutabaruta, Seaside
INSERT INTO `fishing_catch` VALUES (116,2,3);     -- East Sarutabaruta, Other Waterside (south)
INSERT INTO `fishing_catch` VALUES (116,3,3);     -- East Sarutabaruta, Other Waterside (west)
INSERT INTO `fishing_catch` VALUES (116,4,3);     -- East Sarutabaruta, Other Waterside (rivers)
INSERT INTO `fishing_catch` VALUES (116,5,1);     -- East Sarutabaruta, Lake Tepokalipuka
INSERT INTO `fishing_catch` VALUES (118,1,66);    -- Buburimu Peninsula, Whole Zone
INSERT INTO `fishing_catch` VALUES (120,1,73);    -- Sauromugue Champaign, Whole Zone
INSERT INTO `fishing_catch` VALUES (121,1,86);    -- The Sanctuary of Zi'Tah, Whole Zone
INSERT INTO `fishing_catch` VALUES (122,1,85);    -- Ro'Maeve, Whole Zone
INSERT INTO `fishing_catch` VALUES (123,1,101);   -- Yuhtunga Jungle, Northeast Pond
INSERT INTO `fishing_catch` VALUES (123,2,102);   -- Yuhtunga Jungle, Gremini Falls
INSERT INTO `fishing_catch` VALUES (123,3,103);   -- Yuhtunga Jungle, Southwest Pond
INSERT INTO `fishing_catch` VALUES (123,4,104);   -- Yuhtunga Jungle, Southwest Waterfall - South
INSERT INTO `fishing_catch` VALUES (123,5,105);   -- Yuhtunga Jungle, Southwest Waterfall - North
INSERT INTO `fishing_catch` VALUES (123,6,106);   -- Yuhtunga Jungle, Other Waterside
INSERT INTO `fishing_catch` VALUES (124,1,111);   -- Yhoator Jungle, Front of Temple - East Side
INSERT INTO `fishing_catch` VALUES (124,2,112);   -- Yhoator Jungle, Front of Temple - West Side
INSERT INTO `fishing_catch` VALUES (124,3,113);   -- Yhoator Jungle, Teardrop Spring
INSERT INTO `fishing_catch` VALUES (124,4,114);   -- Yhoator Jungle, Underground Pool 1
INSERT INTO `fishing_catch` VALUES (124,5,115);   -- Yhoator Jungle, Bloodlet Spring
INSERT INTO `fishing_catch` VALUES (124,6,116);   -- Yhoator Jungle, Underground Pool 3
INSERT INTO `fishing_catch` VALUES (124,7,117);   -- Yhoator Jungle, Underground Pool 2
INSERT INTO `fishing_catch` VALUES (125,1,90);    -- Western Altepa Desert, Oasis of Hubol
INSERT INTO `fishing_catch` VALUES (125,2,91);    -- Western Altepa Desert, Central Spring
INSERT INTO `fishing_catch` VALUES (126,1,78);    -- Qufim Island, Northwest Seaside
INSERT INTO `fishing_catch` VALUES (126,2,79);    -- Qufim Island, Southwest Seaside
INSERT INTO `fishing_catch` VALUES (126,3,80);    -- Qufim Island, Other Seaside
INSERT INTO `fishing_catch` VALUES (130,1,118);   -- Ru'Aun Gardens, Whole Zone
INSERT INTO `fishing_catch` VALUES (140,1,18);    -- Ghelsba Outpost, Pond North
INSERT INTO `fishing_catch` VALUES (140,2,18);    -- Ghelsba Outpost, Pond South
INSERT INTO `fishing_catch` VALUES (140,3,19);    -- Ghelsba Outpost, River
INSERT INTO `fishing_catch` VALUES (142,1,20);    -- Yughott Grotto, Whole Zone
INSERT INTO `fishing_catch` VALUES (143,1,45);    -- Palborough Mines, Whole Zone
INSERT INTO `fishing_catch` VALUES (145,1,55);    -- Giddeus, Giddeus Spring
INSERT INTO `fishing_catch` VALUES (145,2,56);    -- Giddeus, Pond - West
INSERT INTO `fishing_catch` VALUES (145,3,57);    -- Giddeus, Pond - North
INSERT INTO `fishing_catch` VALUES (145,4,58);    -- Giddeus, Misc Puddles
INSERT INTO `fishing_catch` VALUES (149,1,31);    -- Davoi, Basin of a Waterfall
INSERT INTO `fishing_catch` VALUES (149,2,32);    -- Davoi, Wailing Pond
INSERT INTO `fishing_catch` VALUES (149,3,33);    -- Davoi, Pond
INSERT INTO `fishing_catch` VALUES (149,4,34);    -- Davoi, Other Waterside
INSERT INTO `fishing_catch` VALUES (151,1,0);     -- Castle Oztroja, PLD AF Fishing Spot
INSERT INTO `fishing_catch` VALUES (151,2,72);    -- Castle Oztroja, Whole Zone
INSERT INTO `fishing_catch` VALUES (153,1,81);    -- The Boyahda Tree, Waterfall Basin
INSERT INTO `fishing_catch` VALUES (153,2,82);    -- The Boyahda Tree, Waterfall Basin - Hidden
INSERT INTO `fishing_catch` VALUES (153,3,83);    -- The Boyahda Tree, Other Waterside
INSERT INTO `fishing_catch` VALUES (154,1,84);    -- Dragon's Aery, Whole Zone
INSERT INTO `fishing_catch` VALUES (157,1,77);    -- Middle Delkfutt's Tower, Whole Zone
INSERT INTO `fishing_catch` VALUES (158,1,77);    -- Upper Delkfutt's Tower, Whole Zone
INSERT INTO `fishing_catch` VALUES (159,1,110);   -- Temple of Uggalepih, Whole Zone
INSERT INTO `fishing_catch` VALUES (160,1,107);   -- Den of Rancor, Pool E-8
INSERT INTO `fishing_catch` VALUES (160,2,108);   -- Den of Rancor, Pool F-11
INSERT INTO `fishing_catch` VALUES (160,3,109);   -- Den of Rancor, Misc Water
INSERT INTO `fishing_catch` VALUES (166,1,72);    -- Ranguemont Pass, Whole Zone
INSERT INTO `fishing_catch` VALUES (167,1,15);    -- Bostaunieux Oubliette, Whole Zone
INSERT INTO `fishing_catch` VALUES (172,1,48);    -- Zeruhn Mines, River
INSERT INTO `fishing_catch` VALUES (172,2,49);    -- Zeruhn Mines, Pool
INSERT INTO `fishing_catch` VALUES (173,1,41);    -- Korroloka Tunnel, Salt Water
INSERT INTO `fishing_catch` VALUES (173,2,42);    -- Korroloka Tunnel, Fresh Water
INSERT INTO `fishing_catch` VALUES (174,1,93);    -- Kuftal Tunnel, Whole Zone
INSERT INTO `fishing_catch` VALUES (176,1,96);    -- Sea Serpent Grotto, Other Seaside
INSERT INTO `fishing_catch` VALUES (176,2,97);    -- Sea Serpent Grotto, Pond Under a Bridge
INSERT INTO `fishing_catch` VALUES (176,3,98);    -- Sea Serpent Grotto, Interior of Hidden Door - Mythril
INSERT INTO `fishing_catch` VALUES (176,4,99);    -- Sea Serpent Grotto, Interior of Hidden Door - Gold
INSERT INTO `fishing_catch` VALUES (176,5,100);   -- Sea Serpent Grotto, Misc Puddles
INSERT INTO `fishing_catch` VALUES (178,1,118);   -- The Shrine of Ru'Avitau, Whole Zone
INSERT INTO `fishing_catch` VALUES (184,1,77);    -- Lower Delkfutt's Tower, Whole Zone
INSERT INTO `fishing_catch` VALUES (191,1,40);    -- Dangruf Wadi, Whole Zone
INSERT INTO `fishing_catch` VALUES (193,1,24);    -- Ordelle's Caves, Whole Zone
INSERT INTO `fishing_catch` VALUES (196,1,22);    -- Gusgen Mines, Pool Upper West
INSERT INTO `fishing_catch` VALUES (196,2,22);    -- Gusgen Mines, Pool Upper East
INSERT INTO `fishing_catch` VALUES (196,3,22);    -- Gusgen Mines, Pool Lower East
INSERT INTO `fishing_catch` VALUES (196,4,21);    -- Gusgen Mines, Interior Pool West
INSERT INTO `fishing_catch` VALUES (196,5,21);    -- Gusgen Mines, Interior Pool Center
INSERT INTO `fishing_catch` VALUES (196,6,21);    -- Gusgen Mines, Interior Pool East
INSERT INTO `fishing_catch` VALUES (204,1,76);    -- Fei'Yin, Whole Zone
INSERT INTO `fishing_catch` VALUES (208,1,88);    -- Quicksand Caves, Whole Zone
INSERT INTO `fishing_catch` VALUES (213,1,67);    -- Labyrinth of Onzozo, Whole Zone
INSERT INTO `fishing_catch` VALUES (220,1,136);   -- Ship bound for Selbina, Whole Zone
INSERT INTO `fishing_catch` VALUES (221,1,136);   -- Ship bound for Mhaura, Whole Zone
INSERT INTO `fishing_catch` VALUES (227,1,137);   -- Ship bound for Selbina (with Pirates), Whole Zone
INSERT INTO `fishing_catch` VALUES (228,1,137);   -- Ship bound for Mhaura (with Pirates), Whole Zone
INSERT INTO `fishing_catch` VALUES (231,1,9);     -- Northern San d'Oria, Whole Zone
INSERT INTO `fishing_catch` VALUES (232,1,10);    -- Port San d'Oria, Whole Zone
INSERT INTO `fishing_catch` VALUES (234,1,8);     -- Bastok Mines, Whole Zone
INSERT INTO `fishing_catch` VALUES (235,1,5);     -- Bastok Markets, North Side
INSERT INTO `fishing_catch` VALUES (235,2,6);     -- Bastok Markets, South Side
INSERT INTO `fishing_catch` VALUES (236,1,7);     -- Port Bastok, Whole Zone
INSERT INTO `fishing_catch` VALUES (238,1,11);    -- Windurst Waters, Whole Zone
INSERT INTO `fishing_catch` VALUES (239,1,11);    -- Windurst Walls, Whole Zone
INSERT INTO `fishing_catch` VALUES (240,1,4);     -- Port Windurst, Whole Zone
INSERT INTO `fishing_catch` VALUES (241,1,11);    -- Windurst Woods, Whole Zone
INSERT INTO `fishing_catch` VALUES (242,1,12);    -- Heavens Tower, Whole Zone
INSERT INTO `fishing_catch` VALUES (245,1,13);    -- Lower Jeuno, Whole Zone
INSERT INTO `fishing_catch` VALUES (246,1,14);    -- Port Jeuno, Whole Zone
INSERT INTO `fishing_catch` VALUES (247,1,89);    -- Rabao, Whole Zone
INSERT INTO `fishing_catch` VALUES (248,1,25);    -- Selbina, Whole Zone
INSERT INTO `fishing_catch` VALUES (249,1,71);    -- Mhaura, Whole Zone
INSERT INTO `fishing_catch` VALUES (250,1,94);    -- Kazham, Whole Zone
INSERT INTO `fishing_catch` VALUES (252,1,95);    -- Norg, Whole Zone
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
