-- MySQL dump 10.13  Distrib 5.6.13, for Win64 (x86_64)
--
-- Host: localhost    Database: tpzdb
-- ------------------------------------------------------
-- Server version   5.6.13-log

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
-- Table structure for table `mob_family_mods`
--

DROP TABLE IF EXISTS `mob_family_mods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mob_family_mods` (
  `familyid` smallint(5) unsigned NOT NULL,
  `modid` smallint(5) unsigned NOT NULL,
  `value` smallint(5) NOT NULL DEFAULT '0',
  `is_mob_mod` boolean NOT NULL DEFAULT '0',
  PRIMARY KEY (`familyid`,`modid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=13 PACK_KEYS=1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mob_family_mods`
--

LOCK TABLES `mob_family_mods` WRITE;
/*!40000 ALTER TABLE `mob_family_mods` DISABLE KEYS */;
INSERT INTO `mob_family_mods` VALUES (175,29,50,0);
INSERT INTO `mob_family_mods` VALUES (4,29,20,0);
INSERT INTO `mob_family_mods` VALUES (4,7,60,1);
INSERT INTO `mob_family_mods` VALUES (74,29,25,0);
INSERT INTO `mob_family_mods` VALUES (61,29,25,0);
INSERT INTO `mob_family_mods` VALUES (169,29,25,0);
INSERT INTO `mob_family_mods` VALUES (110,29,13,0);
INSERT INTO `mob_family_mods` VALUES (111,29,13,0);
INSERT INTO `mob_family_mods` VALUES (171,29,13,0);
INSERT INTO `mob_family_mods` VALUES (4,244,20,0);
INSERT INTO `mob_family_mods` VALUES (193,3,40,1);
INSERT INTO `mob_family_mods` VALUES (34,3,100,1);
INSERT INTO `mob_family_mods` VALUES (267,4,20,1);
INSERT INTO `mob_family_mods` VALUES (87,4,18,1);
INSERT INTO `mob_family_mods` VALUES (87,5,10,1);
INSERT INTO `mob_family_mods` VALUES (87,3,10,1);

-- Define sublinks
INSERT INTO `mob_family_mods` VALUES (240,10,1,1);
INSERT INTO `mob_family_mods` VALUES (169,10,1,1);
INSERT INTO `mob_family_mods` VALUES (358,10,1,1);
INSERT INTO `mob_family_mods` VALUES (190,10,2,1);
INSERT INTO `mob_family_mods` VALUES (189,10,2,1);
INSERT INTO `mob_family_mods` VALUES (334,10,2,1);
INSERT INTO `mob_family_mods` VALUES (46,10,3,1);
INSERT INTO `mob_family_mods` VALUES (252,10,3,1);
INSERT INTO `mob_family_mods` VALUES (47,10,3,1);
INSERT INTO `mob_family_mods` VALUES (245,10,4,1);
INSERT INTO `mob_family_mods` VALUES (216,10,4,1);
INSERT INTO `mob_family_mods` VALUES (133,10,5,1);
INSERT INTO `mob_family_mods` VALUES (184,10,5,1);
INSERT INTO `mob_family_mods` VALUES (59,10,5,1);
INSERT INTO `mob_family_mods` VALUES (253,10,6,1);
INSERT INTO `mob_family_mods` VALUES (254,10,6,1);
INSERT INTO `mob_family_mods` VALUES (289,10,6,1);
INSERT INTO `mob_family_mods` VALUES (307,10,6,1);
INSERT INTO `mob_family_mods` VALUES (212,10,7,1);
INSERT INTO `mob_family_mods` VALUES (362,10,7,1);
INSERT INTO `mob_family_mods` VALUES (213,10,8,1);
INSERT INTO `mob_family_mods` VALUES (285,10,8,1);
INSERT INTO `mob_family_mods` VALUES (176,10,8,1);
INSERT INTO `mob_family_mods` VALUES (246,10,9,1);
INSERT INTO `mob_family_mods` VALUES (308,10,9,1);
INSERT INTO `mob_family_mods` VALUES (326,10,9,1);
INSERT INTO `mob_family_mods` VALUES (171,10,10,1);
INSERT INTO `mob_family_mods` VALUES (182,10,10,1);
INSERT INTO `mob_family_mods` VALUES (310,10,10,1);
INSERT INTO `mob_family_mods` VALUES (469,10,10,1);
INSERT INTO `mob_family_mods` VALUES (233,10,11,1);
INSERT INTO `mob_family_mods` VALUES (311,10,11,1);
INSERT INTO `mob_family_mods` VALUES (199,10,12,1);
INSERT INTO `mob_family_mods` VALUES (288,10,12,1);
INSERT INTO `mob_family_mods` VALUES (165,10,13,1);
INSERT INTO `mob_family_mods` VALUES (166,10,13,1);
INSERT INTO `mob_family_mods` VALUES (301,10,13,1);
INSERT INTO `mob_family_mods` VALUES (27,10,14,1);
INSERT INTO `mob_family_mods` VALUES (294,10,14,1);

INSERT INTO `mob_family_mods` VALUES (169,11,15,1);
INSERT INTO `mob_family_mods` VALUES (358,11,15,1);
INSERT INTO `mob_family_mods` VALUES (110,3,50,1);
INSERT INTO `mob_family_mods` VALUES (121,242,20,0);
INSERT INTO `mob_family_mods` VALUES (52,242,20,0);
INSERT INTO `mob_family_mods` VALUES (258,34,25,1);
INSERT INTO `mob_family_mods` VALUES (217,23,256,1);
INSERT INTO `mob_family_mods` VALUES (274,23,256,1);
INSERT INTO `mob_family_mods` VALUES (273,23,256,1);
INSERT INTO `mob_family_mods` VALUES (234,37,1,1);
INSERT INTO `mob_family_mods` VALUES (72,29,10,0);
INSERT INTO `mob_family_mods` VALUES (72,68,20,0);
INSERT INTO `mob_family_mods` VALUES (139,68,10,0);
INSERT INTO `mob_family_mods` VALUES (176,68,10,0);
INSERT INTO `mob_family_mods` VALUES (285,68,10,0);
INSERT INTO `mob_family_mods` VALUES (57,3,50,1);
INSERT INTO `mob_family_mods` VALUES (72,3,50,1);
INSERT INTO `mob_family_mods` VALUES (140,3,50,1);
INSERT INTO `mob_family_mods` VALUES (141,3,50,1);
INSERT INTO `mob_family_mods` VALUES (207,3,50,1);
INSERT INTO `mob_family_mods` VALUES (255,3,50,1);
INSERT INTO `mob_family_mods` VALUES (253,3,50,1);
INSERT INTO `mob_family_mods` VALUES (194,3,50,1);
INSERT INTO `mob_family_mods` VALUES (271,3,50,1);
INSERT INTO `mob_family_mods` VALUES (135,4,4,1);
INSERT INTO `mob_family_mods` VALUES (394,41,988,1);
INSERT INTO `mob_family_mods` VALUES (394,42,989,1);
INSERT INTO `mob_family_mods` VALUES (394,43,2,1);
INSERT INTO `mob_family_mods` VALUES (150,4,30,1);
INSERT INTO `mob_family_mods` VALUES (394,4,30,1);
INSERT INTO `mob_family_mods` VALUES (236,4,30,1);
INSERT INTO `mob_family_mods` VALUES (481,41,988,1);
INSERT INTO `mob_family_mods` VALUES (481,42,989,1);

-- Adjust magic damage taken
INSERT INTO `mob_family_mods` VALUES (112,389,25,0);
INSERT INTO `mob_family_mods` VALUES (61,389,-25,0);
INSERT INTO `mob_family_mods` VALUES (74,389,-25,0);
INSERT INTO `mob_family_mods` VALUES (358,389,-25,0);
INSERT INTO `mob_family_mods` VALUES (169,389,-25,0);
INSERT INTO `mob_family_mods` VALUES (110,389,-13,0);
INSERT INTO `mob_family_mods` VALUES (122,389,-13,0);
INSERT INTO `mob_family_mods` VALUES (123,389,-13,0);
INSERT INTO `mob_family_mods` VALUES (124,389,-13,0);
INSERT INTO `mob_family_mods` VALUES (175,389,-50,0);
INSERT INTO `mob_family_mods` VALUES (171,389,-13,0);

-- Demons and fomors are somewhat resistant to lullaby
INSERT INTO `mob_family_mods` VALUES (358,254,25,0);
INSERT INTO `mob_family_mods` VALUES (169,254,25,0);
INSERT INTO `mob_family_mods` VALUES (115,254,25,0);
INSERT INTO `mob_family_mods` VALUES (359,254,25,0);

-- Most undead, Rocs, and Hecteyes are highly resistant to sleep,
-- Kindred and bat(s) are fairly resistant
INSERT INTO `mob_family_mods` VALUES (47,240,50,0);
INSERT INTO `mob_family_mods` VALUES (48,240,50,0);
INSERT INTO `mob_family_mods` VALUES (52,240,100,0);
INSERT INTO `mob_family_mods` VALUES (74,240,100,0);
INSERT INTO `mob_family_mods` VALUES (86,240,100,0);
INSERT INTO `mob_family_mods` VALUES (88,240,100,0);
INSERT INTO `mob_family_mods` VALUES (89,240,100,0);
INSERT INTO `mob_family_mods` VALUES (115,240,100,0);
INSERT INTO `mob_family_mods` VALUES (121,240,100,0);
INSERT INTO `mob_family_mods` VALUES (125,240,100,0);
INSERT INTO `mob_family_mods` VALUES (139,240,100,0);
INSERT INTO `mob_family_mods` VALUES (142,240,100,0);
INSERT INTO `mob_family_mods` VALUES (143,240,100,0);
INSERT INTO `mob_family_mods` VALUES (169,240,50,0);
INSERT INTO `mob_family_mods` VALUES (203,240,100,0);
INSERT INTO `mob_family_mods` VALUES (204,240,100,0);
INSERT INTO `mob_family_mods` VALUES (205,240,100,0);
INSERT INTO `mob_family_mods` VALUES (221,240,100,0);
INSERT INTO `mob_family_mods` VALUES (222,240,100,0);
INSERT INTO `mob_family_mods` VALUES (223,240,100,0);
INSERT INTO `mob_family_mods` VALUES (227,240,100,0);
INSERT INTO `mob_family_mods` VALUES (358,240,50,0);
INSERT INTO `mob_family_mods` VALUES (359,240,100,0);

-- Immunities
INSERT INTO `mob_family_mods` VALUES (92,23,2047,1);
INSERT INTO `mob_family_mods` VALUES (93,23,2047,1);
INSERT INTO `mob_family_mods` VALUES (94,23,2047,1);
INSERT INTO `mob_family_mods` VALUES (95,23,2047,1);

INSERT INTO `mob_family_mods` VALUES (92,73,100,0);
INSERT INTO `mob_family_mods` VALUES (93,73,100,0);
INSERT INTO `mob_family_mods` VALUES (94,73,100,0);
INSERT INTO `mob_family_mods` VALUES (95,73,100,0);

-- Roaming mods
SET @roam_distance = 31, @roam_cool = 36, @roam_turns = 51, @roam_rate = 52;

-- Leech
INSERT INTO `mob_family_mods` VALUES (172,@roam_distance,15,1);
INSERT INTO `mob_family_mods` VALUES (369,@roam_distance,15,1);

-- Rabbit
INSERT INTO `mob_family_mods` VALUES (206,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (206,@roam_distance,15,1);
INSERT INTO `mob_family_mods` VALUES (206,@roam_cool,35,1);
INSERT INTO `mob_family_mods` VALUES (206,@roam_rate,30,1);

INSERT INTO `mob_family_mods` VALUES (404,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (404,@roam_distance,15,1);
INSERT INTO `mob_family_mods` VALUES (404,@roam_cool,35,1);
INSERT INTO `mob_family_mods` VALUES (404,@roam_rate,30,1);

-- Sheep
INSERT INTO `mob_family_mods` VALUES (226,@roam_turns,5,1);
INSERT INTO `mob_family_mods` VALUES (226,@roam_distance,15,1);
INSERT INTO `mob_family_mods` VALUES (226,@roam_cool,60,1);
INSERT INTO `mob_family_mods` VALUES (226,@roam_rate,30,1);

-- Tiger
INSERT INTO `mob_family_mods` VALUES (242,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (242,@roam_distance,15,1);
INSERT INTO `mob_family_mods` VALUES (242,@roam_cool,45,1);

-- Lizards
INSERT INTO `mob_family_mods` VALUES (97,@roam_turns,4,1);
INSERT INTO `mob_family_mods` VALUES (97,@roam_cool,60,1);
INSERT INTO `mob_family_mods` VALUES (97,@roam_rate,30,1);

INSERT INTO `mob_family_mods` VALUES (174,@roam_turns,4,1);
INSERT INTO `mob_family_mods` VALUES (174,@roam_cool,60,1);
INSERT INTO `mob_family_mods` VALUES (174,@roam_rate,30,1);

-- Bee
INSERT INTO `mob_family_mods` VALUES (48,@roam_cool,15,1);
INSERT INTO `mob_family_mods` VALUES (48,@roam_turns,2,1);

-- Beetle
INSERT INTO `mob_family_mods` VALUES (49,@roam_distance,15,1);
INSERT INTO `mob_family_mods` VALUES (49,@roam_cool,60,1);
INSERT INTO `mob_family_mods` VALUES (49,@roam_rate,30,1);

-- Funguar
INSERT INTO `mob_family_mods` VALUES (116,@roam_distance,15,1);
INSERT INTO `mob_family_mods` VALUES (116,@roam_cool,60,1);
INSERT INTO `mob_family_mods` VALUES (116,@roam_rate,30,1);

-- Sapling
INSERT INTO `mob_family_mods` VALUES (216,@roam_distance,20,1);

-- Treant
INSERT INTO `mob_family_mods` VALUES (245,@roam_cool,65,1);
INSERT INTO `mob_family_mods` VALUES (245,@roam_rate,30,1);

-- Crab
INSERT INTO `mob_family_mods` VALUES (372,@roam_cool,15,1);
INSERT INTO `mob_family_mods` VALUES (75,@roam_cool,15,1);
INSERT INTO `mob_family_mods` VALUES (76,@roam_cool,15,1);
INSERT INTO `mob_family_mods` VALUES (77,@roam_cool,15,1);

-- Bat Trio
INSERT INTO `mob_family_mods` VALUES (47,@roam_turns,2,1);
INSERT INTO `mob_family_mods` VALUES (47,@roam_cool,35,1);
INSERT INTO `mob_family_mods` VALUES (47,@roam_rate,30,1);

-- Giant Bat
INSERT INTO `mob_family_mods` VALUES (46,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (46,@roam_cool,35,1);
INSERT INTO `mob_family_mods` VALUES (46,@roam_rate,30,1);

INSERT INTO `mob_family_mods` VALUES (71,@roam_cool,55,1);
INSERT INTO `mob_family_mods` VALUES (71,@roam_distance,5,1);
INSERT INTO `mob_family_mods` VALUES (71,@roam_rate,30,1);

INSERT INTO `mob_family_mods` VALUES (188,@roam_cool,35,1);
INSERT INTO `mob_family_mods` VALUES (188,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (188,@roam_rate,20,1);

INSERT INTO `mob_family_mods` VALUES (139,@roam_cool,55,1);
INSERT INTO `mob_family_mods` VALUES (139,@roam_rate,30,1);

INSERT INTO `mob_family_mods` VALUES (258,@roam_cool,90,1);
INSERT INTO `mob_family_mods` VALUES (258,@roam_rate,30,1);

INSERT INTO `mob_family_mods` VALUES (227,@roam_cool,65,1);
INSERT INTO `mob_family_mods` VALUES (227,@roam_rate,30,1);
INSERT INTO `mob_family_mods` VALUES (227,@roam_turns,5,1);

INSERT INTO `mob_family_mods` VALUES (110,@roam_cool,45,1);
INSERT INTO `mob_family_mods` VALUES (110,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (110,@roam_rate,30,1);

-- Elementals
INSERT INTO `mob_family_mods` VALUES (99,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (100,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (101,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (102,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (103,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (104,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (105,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (106,@roam_turns,3,1);

INSERT INTO `mob_family_mods` VALUES (155,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (156,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (157,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (158,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (159,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (160,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (161,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (162,@roam_turns,3,1);

-- Gigas
INSERT INTO `mob_family_mods` VALUES (328,@roam_cool,25,1);
INSERT INTO `mob_family_mods` VALUES (328,@roam_distance,5,1);
INSERT INTO `mob_family_mods` VALUES (328,@roam_turns,2,1);
INSERT INTO `mob_family_mods` VALUES (328,@roam_rate,30,1);

INSERT INTO `mob_family_mods` VALUES (126,@roam_cool,25,1);
INSERT INTO `mob_family_mods` VALUES (126,@roam_distance,5,1);
INSERT INTO `mob_family_mods` VALUES (126,@roam_turns,2,1);
INSERT INTO `mob_family_mods` VALUES (126,@roam_rate,30,1);

INSERT INTO `mob_family_mods` VALUES (127,@roam_cool,25,1);
INSERT INTO `mob_family_mods` VALUES (127,@roam_distance,5,1);
INSERT INTO `mob_family_mods` VALUES (127,@roam_turns,2,1);
INSERT INTO `mob_family_mods` VALUES (127,@roam_rate,30,1);

INSERT INTO `mob_family_mods` VALUES (128,@roam_cool,25,1);
INSERT INTO `mob_family_mods` VALUES (128,@roam_distance,5,1);
INSERT INTO `mob_family_mods` VALUES (128,@roam_turns,2,1);
INSERT INTO `mob_family_mods` VALUES (128,@roam_rate,30,1);

INSERT INTO `mob_family_mods` VALUES (129,@roam_cool,25,1);
INSERT INTO `mob_family_mods` VALUES (129,@roam_distance,5,1);
INSERT INTO `mob_family_mods` VALUES (129,@roam_turns,2,1);
INSERT INTO `mob_family_mods` VALUES (129,@roam_rate,30,1);

INSERT INTO `mob_family_mods` VALUES (130,@roam_cool,25,1);
INSERT INTO `mob_family_mods` VALUES (130,@roam_distance,5,1);
INSERT INTO `mob_family_mods` VALUES (130,@roam_turns,2,1);
INSERT INTO `mob_family_mods` VALUES (130,@roam_rate,30,1);

-- Tonberry
INSERT INTO `mob_family_mods` VALUES (243,@roam_cool,25,1);
INSERT INTO `mob_family_mods` VALUES (243,@roam_turns,5,1);
INSERT INTO `mob_family_mods` VALUES (243,@roam_rate,30,1);

INSERT INTO `mob_family_mods` VALUES (244,@roam_cool,25,1);
INSERT INTO `mob_family_mods` VALUES (244,@roam_turns,5,1);
INSERT INTO `mob_family_mods` VALUES (244,@roam_rate,30,1);

INSERT INTO `mob_family_mods` VALUES (217,@roam_cool,55,1);
INSERT INTO `mob_family_mods` VALUES (217,@roam_rate,30,1);

-- Behe
INSERT INTO `mob_family_mods` VALUES (479,@roam_cool,50,1);
INSERT INTO `mob_family_mods` VALUES (51,@roam_cool,50,1);

INSERT INTO `mob_family_mods` VALUES (57,@roam_cool,50,1);
INSERT INTO `mob_family_mods` VALUES (57,@roam_turns,4,1);
INSERT INTO `mob_family_mods` VALUES (57,@roam_rate,30,1);

INSERT INTO `mob_family_mods` VALUES (62,@roam_cool,50,1);

INSERT INTO `mob_family_mods` VALUES (80,@roam_cool,30,1);
INSERT INTO `mob_family_mods` VALUES (80,@roam_turns,2,1);
INSERT INTO `mob_family_mods` VALUES (80,@roam_rate,30,1);

INSERT INTO `mob_family_mods` VALUES (180,@roam_cool,30,1);
INSERT INTO `mob_family_mods` VALUES (180,@roam_turns,2,1);
INSERT INTO `mob_family_mods` VALUES (180,@roam_rate,30,1);

INSERT INTO `mob_family_mods` VALUES (208,@roam_cool,60,1);
INSERT INTO `mob_family_mods` VALUES (208,@roam_rate,30,1);

INSERT INTO `mob_family_mods` VALUES (2,@roam_cool,50,1);
INSERT INTO `mob_family_mods` VALUES (2,@roam_rate,30,1);

INSERT INTO `mob_family_mods` VALUES (58,@roam_cool,45,1);
INSERT INTO `mob_family_mods` VALUES (58,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (58,@roam_rate,30,1);

INSERT INTO `mob_family_mods` VALUES (98,@roam_cool,50,1);
INSERT INTO `mob_family_mods` VALUES (98,@roam_turns,5,1);
INSERT INTO `mob_family_mods` VALUES (98,@roam_rate,30,1);

-- Raptors
INSERT INTO `mob_family_mods` VALUES (210,@roam_cool,40,1);
INSERT INTO `mob_family_mods` VALUES (210,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (210,@roam_distance,30,1);

INSERT INTO `mob_family_mods` VALUES (376,@roam_cool,40,1);
INSERT INTO `mob_family_mods` VALUES (376,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (376,@roam_distance,30,1);

INSERT INTO `mob_family_mods` VALUES (377,@roam_cool,40,1);
INSERT INTO `mob_family_mods` VALUES (377,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (377,@roam_distance,30,1);

INSERT INTO `mob_family_mods` VALUES (257,@roam_cool,50,1);
INSERT INTO `mob_family_mods` VALUES (257,@roam_rate,30,1);

-- Manticore
INSERT INTO `mob_family_mods` VALUES (179,@roam_cool,60,1);
INSERT INTO `mob_family_mods` VALUES (179,@roam_turns,4,1);
INSERT INTO `mob_family_mods` VALUES (179,@roam_distance,30,1);
INSERT INTO `mob_family_mods` VALUES (179,@roam_rate,30,1);

INSERT INTO `mob_family_mods` VALUES (26,@roam_cool,50,1);
INSERT INTO `mob_family_mods` VALUES (26,@roam_turns,2,1);
INSERT INTO `mob_family_mods` VALUES (26,@roam_rate,30,1);

-- Crawler
INSERT INTO `mob_family_mods` VALUES (79,@roam_cool,55,1);
INSERT INTO `mob_family_mods` VALUES (79,@roam_rate,30,1);

-- Diremite
INSERT INTO `mob_family_mods` VALUES (81,@roam_cool,50,1);
INSERT INTO `mob_family_mods` VALUES (81,@roam_turns,2,1);

INSERT INTO `mob_family_mods` VALUES (136,@roam_cool,60,1);
INSERT INTO `mob_family_mods` VALUES (136,@roam_distance,5,1);
INSERT INTO `mob_family_mods` VALUES (136,@roam_rate,30,1);

INSERT INTO `mob_family_mods` VALUES (186,@roam_cool,30,1);
INSERT INTO `mob_family_mods` VALUES (186,@roam_rate,30,1);

INSERT INTO `mob_family_mods` VALUES (212,@roam_cool,10,1);
INSERT INTO `mob_family_mods` VALUES (212,@roam_rate,20,1);

INSERT INTO `mob_family_mods` VALUES (218,@roam_cool,30,1);
INSERT INTO `mob_family_mods` VALUES (219,@roam_cool,30,1);

INSERT INTO `mob_family_mods` VALUES (251,@roam_cool,40,1);
INSERT INTO `mob_family_mods` VALUES (251,@roam_rate,30,1);

INSERT INTO `mob_family_mods` VALUES (112,@roam_rate,30,1);
INSERT INTO `mob_family_mods` VALUES (112,@roam_turns,2,1);

INSERT INTO `mob_family_mods` VALUES (70,@roam_cool,30,1);
INSERT INTO `mob_family_mods` VALUES (70,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (70,@roam_rate,30,1);

INSERT INTO `mob_family_mods` VALUES (72,@roam_turns,2,1);
INSERT INTO `mob_family_mods` VALUES (72,@roam_rate,30,1);

INSERT INTO `mob_family_mods` VALUES (140,@roam_turns,2,1);
INSERT INTO `mob_family_mods` VALUES (140,@roam_cool,55,1);
INSERT INTO `mob_family_mods` VALUES (141,@roam_turns,2,1);
INSERT INTO `mob_family_mods` VALUES (141,@roam_cool,55,1);

INSERT INTO `mob_family_mods` VALUES (125,@roam_rate,30,1);
INSERT INTO `mob_family_mods` VALUES (125,@roam_turns,2,1);
INSERT INTO `mob_family_mods` VALUES (125,@roam_cool,40,1);

INSERT INTO `mob_family_mods` VALUES (74,@roam_rate,30,1);
INSERT INTO `mob_family_mods` VALUES (74,@roam_turns,2,1);
INSERT INTO `mob_family_mods` VALUES (74,@roam_cool,50,1);

INSERT INTO `mob_family_mods` VALUES (86,@roam_rate,30,1);
INSERT INTO `mob_family_mods` VALUES (86,@roam_cool,55,1);

INSERT INTO `mob_family_mods` VALUES (115,@roam_rate,30,1);
INSERT INTO `mob_family_mods` VALUES (115,@roam_turns,2,1);
INSERT INTO `mob_family_mods` VALUES (115,@roam_cool,50,1);

INSERT INTO `mob_family_mods` VALUES (359,@roam_rate,30,1);
INSERT INTO `mob_family_mods` VALUES (359,@roam_turns,2,1);
INSERT INTO `mob_family_mods` VALUES (359,@roam_cool,50,1);

INSERT INTO `mob_family_mods` VALUES (121,@roam_rate,30,1);
INSERT INTO `mob_family_mods` VALUES (121,@roam_cool,50,1);

INSERT INTO `mob_family_mods` VALUES (142,@roam_rate,30,1);
INSERT INTO `mob_family_mods` VALUES (142,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (142,@roam_cool,50,1);

INSERT INTO `mob_family_mods` VALUES (143,@roam_rate,30,1);
INSERT INTO `mob_family_mods` VALUES (143,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (143,@roam_cool,50,1);

INSERT INTO `mob_family_mods` VALUES (203,@roam_rate,30,1);
INSERT INTO `mob_family_mods` VALUES (203,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (203,@roam_cool,50,1);

INSERT INTO `mob_family_mods` VALUES (204,@roam_rate,30,1);
INSERT INTO `mob_family_mods` VALUES (204,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (204,@roam_cool,50,1);

INSERT INTO `mob_family_mods` VALUES (205,@roam_rate,30,1);
INSERT INTO `mob_family_mods` VALUES (205,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (205,@roam_cool,50,1);

INSERT INTO `mob_family_mods` VALUES (221,@roam_rate,30,1);
INSERT INTO `mob_family_mods` VALUES (221,@roam_turns,2,1);
INSERT INTO `mob_family_mods` VALUES (221,@roam_cool,50,1);

INSERT INTO `mob_family_mods` VALUES (222,@roam_rate,30,1);
INSERT INTO `mob_family_mods` VALUES (222,@roam_turns,2,1);
INSERT INTO `mob_family_mods` VALUES (222,@roam_cool,50,1);

INSERT INTO `mob_family_mods` VALUES (223,@roam_rate,30,1);
INSERT INTO `mob_family_mods` VALUES (223,@roam_turns,2,1);
INSERT INTO `mob_family_mods` VALUES (223,@roam_cool,50,1);

INSERT INTO `mob_family_mods` VALUES (252,@roam_rate,30,1);
INSERT INTO `mob_family_mods` VALUES (252,@roam_turns,2,1);
INSERT INTO `mob_family_mods` VALUES (252,@roam_cool,50,1);

INSERT INTO `mob_family_mods` VALUES (56,@roam_rate,20,1);
INSERT INTO `mob_family_mods` VALUES (56,@roam_turns,5,1);
INSERT INTO `mob_family_mods` VALUES (56,@roam_cool,30,1);

INSERT INTO `mob_family_mods` VALUES (61,@roam_rate,20,1);
INSERT INTO `mob_family_mods` VALUES (61,@roam_turns,2,1);
INSERT INTO `mob_family_mods` VALUES (61,@roam_cool,40,1);

INSERT INTO `mob_family_mods` VALUES (68,@roam_rate,20,1);
INSERT INTO `mob_family_mods` VALUES (68,@roam_turns,2,1);
INSERT INTO `mob_family_mods` VALUES (68,@roam_cool,40,1);

INSERT INTO `mob_family_mods` VALUES (69,@roam_rate,20,1);
INSERT INTO `mob_family_mods` VALUES (69,@roam_turns,2,1);
INSERT INTO `mob_family_mods` VALUES (69,@roam_cool,40,1);

INSERT INTO `mob_family_mods` VALUES (83,@roam_rate,30,1);
INSERT INTO `mob_family_mods` VALUES (83,@roam_distance,5,1);
INSERT INTO `mob_family_mods` VALUES (83,@roam_cool,55,1);

INSERT INTO `mob_family_mods` VALUES (84,@roam_rate,30,1);
INSERT INTO `mob_family_mods` VALUES (84,@roam_distance,5,1);
INSERT INTO `mob_family_mods` VALUES (84,@roam_cool,55,1);

INSERT INTO `mob_family_mods` VALUES (85,@roam_rate,30,1);
INSERT INTO `mob_family_mods` VALUES (85,@roam_distance,5,1);
INSERT INTO `mob_family_mods` VALUES (85,@roam_cool,55,1);

INSERT INTO `mob_family_mods` VALUES (367,@roam_rate,30,1);
INSERT INTO `mob_family_mods` VALUES (367,@roam_distance,5,1);
INSERT INTO `mob_family_mods` VALUES (367,@roam_cool,55,1);

INSERT INTO `mob_family_mods` VALUES (368,@roam_rate,30,1);
INSERT INTO `mob_family_mods` VALUES (368,@roam_distance,5,1);
INSERT INTO `mob_family_mods` VALUES (368,@roam_cool,55,1);

INSERT INTO `mob_family_mods` VALUES (135,@roam_rate,30,1);
INSERT INTO `mob_family_mods` VALUES (135,@roam_distance,5,1);
INSERT INTO `mob_family_mods` VALUES (135,@roam_cool,55,1);

INSERT INTO `mob_family_mods` VALUES (175,@roam_rate,30,1);
INSERT INTO `mob_family_mods` VALUES (175,@roam_distance,5,1);
INSERT INTO `mob_family_mods` VALUES (175,@roam_cool,55,1);

INSERT INTO `mob_family_mods` VALUES (232,@roam_rate,20,1);
INSERT INTO `mob_family_mods` VALUES (232,@roam_turns,2,1);
INSERT INTO `mob_family_mods` VALUES (232,@roam_cool,40,1);

-- Dragons
INSERT INTO `mob_family_mods` VALUES (163,@roam_cool,55,1);
INSERT INTO `mob_family_mods` VALUES (163,@roam_distance,5,1);
INSERT INTO `mob_family_mods` VALUES (164,@roam_cool,55,1);
INSERT INTO `mob_family_mods` VALUES (164,@roam_distance,5,1);
INSERT INTO `mob_family_mods` VALUES (259,@roam_cool,55,1);
INSERT INTO `mob_family_mods` VALUES (260,@roam_cool,55,1);
INSERT INTO `mob_family_mods` VALUES (261,@roam_cool,55,1);
INSERT INTO `mob_family_mods` VALUES (262,@roam_cool,55,1);
INSERT INTO `mob_family_mods` VALUES (263,@roam_cool,55,1);
INSERT INTO `mob_family_mods` VALUES (264,@roam_cool,55,1);
INSERT INTO `mob_family_mods` VALUES (265,@roam_cool,55,1);
INSERT INTO `mob_family_mods` VALUES (266,@roam_cool,55,1);
INSERT INTO `mob_family_mods` VALUES (267,@roam_cool,55,1);
INSERT INTO `mob_family_mods` VALUES (268,@roam_cool,55,1);
INSERT INTO `mob_family_mods` VALUES (391,@roam_cool,55,1);
INSERT INTO `mob_family_mods` VALUES (391,@roam_distance,5,1);
INSERT INTO `mob_family_mods` VALUES (392,@roam_cool,55,1);
INSERT INTO `mob_family_mods` VALUES (392,@roam_distance,5,1);
INSERT INTO `mob_family_mods` VALUES (393,@roam_cool,55,1);
INSERT INTO `mob_family_mods` VALUES (393,@roam_distance,5,1);
INSERT INTO `mob_family_mods` VALUES (87,@roam_cool,55,1);

INSERT INTO `mob_family_mods` VALUES (4,@roam_turns,5,1);
INSERT INTO `mob_family_mods` VALUES (4,@roam_cool,40,1);

INSERT INTO `mob_family_mods` VALUES (169,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (169,@roam_cool,50,1);
INSERT INTO `mob_family_mods` VALUES (169,@roam_distance,15,1);

INSERT INTO `mob_family_mods` VALUES (358,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (358,@roam_cool,50,1);
INSERT INTO `mob_family_mods` VALUES (358,@roam_distance,15,1);

INSERT INTO `mob_family_mods` VALUES (165,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (165,@roam_cool,50,1);

INSERT INTO `mob_family_mods` VALUES (166,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (166,@roam_cool,50,1);

INSERT INTO `mob_family_mods` VALUES (233,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (233,@roam_cool,50,1);

INSERT INTO `mob_family_mods` VALUES (240,@roam_turns,3,1);
INSERT INTO `mob_family_mods` VALUES (240,@roam_cool,40,1);
INSERT INTO `mob_family_mods` VALUES (240,@roam_rate,30,1);

INSERT INTO `mob_family_mods` VALUES (190,@roam_cool,50,1);
INSERT INTO `mob_family_mods` VALUES (190,@roam_rate,30,1);

INSERT INTO `mob_family_mods` VALUES (59,@roam_cool,50,1);
INSERT INTO `mob_family_mods` VALUES (59,@roam_rate,30,1);
INSERT INTO `mob_family_mods` VALUES (59,@roam_turns,2,1);

INSERT INTO `mob_family_mods` VALUES (126,54,180,1);
INSERT INTO `mob_family_mods` VALUES (127,54,180,1);
INSERT INTO `mob_family_mods` VALUES (128,54,180,1);
INSERT INTO `mob_family_mods` VALUES (129,54,180,1);
INSERT INTO `mob_family_mods` VALUES (130,54,180,1);
INSERT INTO `mob_family_mods` VALUES (328,54,180,1);

INSERT INTO `mob_family_mods` VALUES (169,54,120,1);
INSERT INTO `mob_family_mods` VALUES (358,54,120,1);

INSERT INTO `mob_family_mods` VALUES (87,54,1000,1);
INSERT INTO `mob_family_mods` VALUES (115,54,100,1);
INSERT INTO `mob_family_mods` VALUES (359,54,100,1);

-- All animated weapons have MP
INSERT INTO `mob_family_mods` VALUES (7,3,50,1);
INSERT INTO `mob_family_mods` VALUES (8,3,50,1);
INSERT INTO `mob_family_mods` VALUES (9,3,50,1);
INSERT INTO `mob_family_mods` VALUES (11,3,50,1);
INSERT INTO `mob_family_mods` VALUES (12,3,50,1);
INSERT INTO `mob_family_mods` VALUES (13,3,50,1);
INSERT INTO `mob_family_mods` VALUES (14,3,50,1);
INSERT INTO `mob_family_mods` VALUES (15,3,50,1);
INSERT INTO `mob_family_mods` VALUES (16,3,50,1);
INSERT INTO `mob_family_mods` VALUES (17,3,50,1);
INSERT INTO `mob_family_mods` VALUES (18,3,50,1);
INSERT INTO `mob_family_mods` VALUES (19,3,50,1);
INSERT INTO `mob_family_mods` VALUES (20,3,50,1);
INSERT INTO `mob_family_mods` VALUES (21,3,50,1);
INSERT INTO `mob_family_mods` VALUES (23,3,50,1);
INSERT INTO `mob_family_mods` VALUES (24,3,50,1);

-- Family defense multiplier
INSERT INTO `mob_family_mods` VALUES (26,63,20,0);
INSERT INTO `mob_family_mods` VALUES (357,63,20,0);
INSERT INTO `mob_family_mods` VALUES (58,63,20,0);
INSERT INTO `mob_family_mods` VALUES (57,63,20,0);
INSERT INTO `mob_family_mods` VALUES (208,63,20,0);
INSERT INTO `mob_family_mods` VALUES (2,63,20,0);
INSERT INTO `mob_family_mods` VALUES (180,63,20,0);
INSERT INTO `mob_family_mods` VALUES (245,63,20,0);
INSERT INTO `mob_family_mods` VALUES (59,63,20,0);

-- Sahagins have 50% dmg reduction to water
INSERT INTO `mob_family_mods` VALUES (213,20,128,0);

-- Never standback
INSERT INTO `mob_family_mods` VALUES (32,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (33,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (34,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (35,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (36,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (37,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (38,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (39,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (40,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (41,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (42,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (43,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (44,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (45,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (495,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (92,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (93,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (94,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (95,56,-1,1);
-- elementals don't standback
INSERT INTO `mob_family_mods` VALUES (99,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (100,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (101,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (102,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (103,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (104,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (105,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (106,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (4,56,-1,1);
INSERT INTO `mob_family_mods` VALUES (139,56,-1,1);

-- Weapon bonus damage
INSERT INTO `mob_family_mods` VALUES (57,59,125,1);
INSERT INTO `mob_family_mods` VALUES (58,59,125,1);
INSERT INTO `mob_family_mods` VALUES (59,59,120,1);
INSERT INTO `mob_family_mods` VALUES (79,59,110,1);
INSERT INTO `mob_family_mods` VALUES (80,59,110,1);
INSERT INTO `mob_family_mods` VALUES (81,59,115,1);
INSERT INTO `mob_family_mods` VALUES (265,59,120,1);
INSERT INTO `mob_family_mods` VALUES (266,59,120,1);
INSERT INTO `mob_family_mods` VALUES (267,59,120,1);
INSERT INTO `mob_family_mods` VALUES (268,59,120,1);
INSERT INTO `mob_family_mods` VALUES (87,59,120,1);
INSERT INTO `mob_family_mods` VALUES (136,59,145,1);
INSERT INTO `mob_family_mods` VALUES (179,59,125,1);
INSERT INTO `mob_family_mods` VALUES (217,59,120,1);
INSERT INTO `mob_family_mods` VALUES (208,59,120,1);
INSERT INTO `mob_family_mods` VALUES (210,59,110,1);
INSERT INTO `mob_family_mods` VALUES (242,59,110,1);
INSERT INTO `mob_family_mods` VALUES (240,59,120,1);

INSERT INTO `mob_family_mods` VALUES (259,59,125,1);
INSERT INTO `mob_family_mods` VALUES (260,59,125,1);
INSERT INTO `mob_family_mods` VALUES (261,59,125,1);
INSERT INTO `mob_family_mods` VALUES (262,59,125,1);
INSERT INTO `mob_family_mods` VALUES (263,59,125,1);
INSERT INTO `mob_family_mods` VALUES (264,59,125,1);
INSERT INTO `mob_family_mods` VALUES (169,59,120,1);
INSERT INTO `mob_family_mods` VALUES (358,59,120,1);
INSERT INTO `mob_family_mods` VALUES (371,59,125,1);
INSERT INTO `mob_family_mods` VALUES (165,29,24,0); -- Imp MDEF 24

/*!40000 ALTER TABLE `mob_family_mods` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-10-09 17:42:22
