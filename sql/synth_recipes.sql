-- MySQL dump 10.13  Distrib 5.6.13, for Win64 (x86_64)
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
-- Table structure for table `synth_recipes`
--

DROP TABLE IF EXISTS `synth_recipes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `synth_recipes` (
  `ID` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `Desynth` tinyint(3) unsigned NOT NULL,
  `KeyItem` int(10) unsigned NOT NULL,
  `Alchemy` tinyint(3) unsigned NOT NULL,
  `Bone` tinyint(3) unsigned NOT NULL,
  `Cloth` tinyint(3) unsigned NOT NULL,
  `Cook` tinyint(3) unsigned NOT NULL,
  `Gold` tinyint(3) unsigned NOT NULL,
  `Leather` tinyint(3) unsigned NOT NULL,
  `Smith` tinyint(3) unsigned NOT NULL,
  `Wood` tinyint(3) unsigned NOT NULL,
  `Crystal` smallint(5) unsigned NOT NULL,
  `HQCrystal` smallint(5) unsigned NOT NULL,
  `Ingredient1` smallint(5) unsigned NOT NULL,
  `Ingredient2` smallint(5) unsigned NOT NULL,
  `Ingredient3` smallint(5) unsigned NOT NULL,
  `Ingredient4` smallint(5) unsigned NOT NULL,
  `Ingredient5` smallint(5) unsigned NOT NULL,
  `Ingredient6` smallint(5) unsigned NOT NULL,
  `Ingredient7` smallint(5) unsigned NOT NULL,
  `Ingredient8` smallint(5) unsigned NOT NULL,
  `Result` smallint(5) unsigned NOT NULL,
  `ResultHQ1` smallint(5) unsigned NOT NULL,
  `ResultHQ2` smallint(5) unsigned NOT NULL,
  `ResultHQ3` smallint(5) unsigned NOT NULL,
  `ResultQty` tinyint(2) unsigned NOT NULL,
  `ResultHQ1Qty` tinyint(2) unsigned NOT NULL,
  `ResultHQ2Qty` tinyint(2) unsigned NOT NULL,
  `ResultHQ3Qty` tinyint(2) unsigned NOT NULL,
  `ResultName` tinytext NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=3500 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=79;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `synth_recipes`
--

DELIMITER $$
DROP TRIGGER IF EXISTS ensure_ingredients_are_ordered;
CREATE TRIGGER ensure_ingredients_are_ordered
     BEFORE INSERT ON synth_recipes FOR EACH ROW BEGIN
          IF NEW.Ingredient2 > 0 AND NEW.Ingredient1 > NEW.Ingredient2
          THEN
            SIGNAL SQLSTATE VALUE '45000'
            SET MESSAGE_TEXT = '[table:synth_recipes] - `Ingredient1` is larger than Ingredient2';
          END IF;

          IF NEW.Ingredient3 > 0 AND NEW.Ingredient2 > NEW.Ingredient3
          THEN
            SIGNAL SQLSTATE VALUE '45000'
            SET MESSAGE_TEXT = '[table:synth_recipes] - `Ingredient2` is larger than Ingredient3';
          END IF;

          IF NEW.Ingredient4 > 0 AND NEW.Ingredient3 > NEW.Ingredient4
          THEN
            SIGNAL SQLSTATE VALUE '45000'
            SET MESSAGE_TEXT = '[table:synth_recipes] - `Ingredient3` is larger than Ingredient4';
          END IF;

          IF NEW.Ingredient5 > 0 AND NEW.Ingredient4 > NEW.Ingredient5
          THEN
            SIGNAL SQLSTATE VALUE '45000'
            SET MESSAGE_TEXT = '[table:synth_recipes] - `Ingredient4` is larger than Ingredient5';
          END IF;

          IF NEW.Ingredient6 > 0 AND NEW.Ingredient5 > NEW.Ingredient6
          THEN
            SIGNAL SQLSTATE VALUE '45000'
            SET MESSAGE_TEXT = '[table:synth_recipes] - `Ingredient5` is larger than Ingredient6';
          END IF;

          IF NEW.Ingredient7 > 0 AND NEW.Ingredient6 > NEW.Ingredient7
          THEN
            SIGNAL SQLSTATE VALUE '45000'
            SET MESSAGE_TEXT = '[table:synth_recipes] - `Ingredient6` is larger than Ingredient7';
          END IF;

          IF NEW.Ingredient8 > 0 AND NEW.Ingredient7 > NEW.Ingredient8
          THEN
            SIGNAL SQLSTATE VALUE '45000'
            SET MESSAGE_TEXT = '[table:synth_recipes] - `Ingredient7` is larger than Ingredient8';
          END IF;
END$$

DELIMITER ;

LOCK TABLES `synth_recipes` WRITE;
/*!40000 ALTER TABLE `synth_recipes` DISABLE KEYS */;

INSERT INTO `synth_recipes` VALUES (1,0,0,0,0,4,0,0,0,0,20,4099,4241,706,706,714,714,817,824,824,824,2,2,2,2,1,1,1,1,'Simple Bed');
INSERT INTO `synth_recipes` VALUES (2,0,0,0,0,53,0,0,0,0,49,4099,4241,716,716,716,716,819,826,826,826,3,3,3,3,1,1,1,1,'Oak Bed');
INSERT INTO `synth_recipes` VALUES (3,0,0,0,0,53,0,0,0,0,60,4099,4241,717,717,717,717,820,827,827,827,4,4,4,4,1,1,1,1,'Mahogany Bed');
INSERT INTO `synth_recipes` VALUES (4,0,0,0,0,19,0,0,0,19,0,4096,4238,649,649,649,649,817,825,825,834,5,5,5,5,1,1,1,1,'Bronze Bed');
INSERT INTO `synth_recipes` VALUES (5,0,0,0,0,56,0,50,0,0,78,4099,4241,717,718,718,718,745,823,828,829,6,6,6,6,1,1,1,1,'Nobles Bed');
INSERT INTO `synth_recipes` VALUES (6,0,0,0,0,59,0,54,0,0,87,4099,4241,717,719,720,745,786,823,829,836,8,8,8,8,1,1,1,1,'Royal Bed');
INSERT INTO `synth_recipes` VALUES (7,0,0,0,0,26,0,0,0,0,51,4099,4241,706,707,826,0,0,0,0,0,21,21,21,21,1,1,1,1,'Desk');
INSERT INTO `synth_recipes` VALUES (8,0,0,0,0,0,0,0,0,0,7,4099,4241,706,706,706,706,0,0,0,0,22,22,22,22,1,1,1,1,'Workbench');
INSERT INTO `synth_recipes` VALUES (9,0,0,0,0,0,0,0,0,0,16,4099,4241,708,708,708,708,0,0,0,0,23,23,23,23,1,1,1,1,'Maple Table');
INSERT INTO `synth_recipes` VALUES (10,0,0,0,0,0,0,0,0,0,40,4099,4241,716,716,716,716,0,0,0,0,24,24,24,24,1,1,1,1,'Oak Table');
INSERT INTO `synth_recipes` VALUES (11,0,0,0,0,0,0,0,0,0,36,4099,4241,706,706,706,706,706,826,826,0,26,26,26,26,1,1,1,1,'Tarutaru Desk');
INSERT INTO `synth_recipes` VALUES (12,0,0,0,0,0,0,0,0,0,65,4099,4241,717,717,717,717,0,0,0,0,29,29,29,29,1,1,1,1,'Secretaire');
INSERT INTO `synth_recipes` VALUES (13,0,0,0,0,0,0,0,0,41,75,4099,4241,664,717,717,718,718,0,0,0,30,30,30,30,1,1,1,1,'Bureau');
INSERT INTO `synth_recipes` VALUES (14,0,0,0,0,35,0,49,0,0,85,4099,4241,663,718,718,718,718,745,823,828,32,32,32,32,1,1,1,1,'Dresser');
INSERT INTO `synth_recipes` VALUES (15,0,0,0,0,0,0,96,0,42,59,4099,4241,664,720,752,752,754,1465,1465,1465,33,33,33,33,1,1,1,1,'Millionaire Desk'); -- millionaire desk (gold 96 wood 59 smith 42) https://www.bg-wiki.com/bg/Millionaire_Desk
INSERT INTO `synth_recipes` VALUES (16,0,0,0,0,0,0,0,30,0,35,4099,4241,712,721,721,721,851,0,0,0,43,43,43,43,1,1,1,1,'Wicker Box');
INSERT INTO `synth_recipes` VALUES (17,0,0,0,0,0,0,11,0,0,63,4099,4241,661,713,713,713,713,713,718,0,49,49,49,49,1,1,1,1,'Coffer');
INSERT INTO `synth_recipes` VALUES (18,0,0,0,0,0,0,0,0,0,61,4099,4241,706,706,721,721,721,0,0,0,51,51,51,51,1,1,1,1,'Chest');
INSERT INTO `synth_recipes` VALUES (19,0,0,0,0,0,0,0,0,0,81,4099,4241,714,716,716,716,716,0,0,0,55,55,55,55,1,1,1,1,'Cabinet');
INSERT INTO `synth_recipes` VALUES (20,0,0,0,0,0,0,0,0,0,77,4099,4241,718,718,718,718,718,0,0,0,56,56,56,56,1,1,1,1,'Commode');
INSERT INTO `synth_recipes` VALUES (21,0,0,0,0,0,0,0,0,26,73,4099,4241,662,662,718,718,718,0,0,0,59,59,59,59,1,1,1,1,'Chiffonier');
INSERT INTO `synth_recipes` VALUES (22,0,0,0,0,0,0,49,0,0,90,4099,4241,719,719,719,719,719,719,719,745,61,61,61,61,1,1,1,1,'Armoire');
INSERT INTO `synth_recipes` VALUES (23,0,0,0,0,0,0,10,0,0,98,4099,4241,650,717,717,717,719,719,1447,1447,76,76,76,76,1,1,1,1,'Royal Bookshelf');
INSERT INTO `synth_recipes` VALUES (24,0,0,0,0,0,0,5,0,0,95,4099,4241,717,717,717,1588,1588,1588,0,0,77,77,77,77,1,1,1,1,'Bookshelf');
INSERT INTO `synth_recipes` VALUES (25,0,0,0,0,0,0,0,0,0,25,4099,4241,706,707,0,0,0,0,0,0,92,92,92,92,1,1,1,1,'Tarutaru Stool');
INSERT INTO `synth_recipes` VALUES (26,0,0,0,0,0,0,0,0,0,71,4099,4241,662,716,716,716,0,0,0,0,95,95,95,95,1,1,1,1,'Water Barrel');
INSERT INTO `synth_recipes` VALUES (27,0,0,0,0,0,32,0,0,0,67,4099,4241,95,716,716,4441,4441,4441,0,0,96,96,96,96,1,1,1,1,'Beverage Barrel');
INSERT INTO `synth_recipes` VALUES (28,0,0,0,0,0,0,0,0,0,31,4099,4241,706,714,0,0,0,0,0,0,97,97,97,97,1,1,1,1,'Book Holder');
INSERT INTO `synth_recipes` VALUES (29,0,0,0,0,0,0,0,0,20,79,4101,4243,662,1774,1817,17868,0,0,0,0,98,98,98,98,1,1,1,1,'Scimitar Cactus');
INSERT INTO `synth_recipes` VALUES (30,0,0,0,0,0,0,0,0,0,83,4101,4243,695,721,1774,5187,17868,0,0,0,99,99,99,99,1,1,1,1,'Elshimo Palm');
INSERT INTO `synth_recipes` VALUES (31,0,0,0,0,0,0,0,0,0,44,4099,4241,706,713,0,0,0,0,0,0,102,102,102,102,1,1,1,1,'Flower Stand');
INSERT INTO `synth_recipes` VALUES (32,0,0,7,0,0,0,0,0,4,10,4102,4244,649,706,1156,1886,1887,1894,4310,4311,103,103,103,103,1,1,1,1,'Goldfish Bowl');
INSERT INTO `synth_recipes` VALUES (33,0,0,0,0,0,0,0,0,0,72,4099,4241,721,721,721,917,917,917,0,0,104,104,104,104,1,1,1,1,'Taru F. Screen');
INSERT INTO `synth_recipes` VALUES (34,0,0,36,0,0,0,0,0,0,80,4102,4244,703,716,1886,1887,1895,4464,4464,4464,120,120,120,120,1,1,1,1,'F. Aquarium'); -- freshwater aquarium (wood 80, alch 36)
INSERT INTO `synth_recipes` VALUES (35,0,0,39,0,0,0,0,0,0,89,4102,4244,716,887,1886,1887,1896,5121,5121,5121,121,121,121,121,1,1,1,1,'S. Aquarium');
INSERT INTO `synth_recipes` VALUES (36,0,0,0,0,59,0,79,0,0,0,4096,4238,730,823,1999,2288,2418,2418,2418,2418,122,122,122,122,1,1,1,1,'Amir Bed');
INSERT INTO `synth_recipes` VALUES (37,0,0,0,0,0,0,26,0,27,9,4096,4238,651,662,708,2418,0,0,0,0,123,123,123,123,1,1,1,1,'Athenienne'); -- athenienne (smith 27 gold 26 wood 9) http://ffxiclopedia.wikia.com/wiki/Athenienne
INSERT INTO `synth_recipes` VALUES (38,0,0,0,0,0,0,54,0,0,98,4099,4241,711,711,711,711,1887,2418,2419,2419,124,124,124,124,1,1,1,1,'Wardrobe');
INSERT INTO `synth_recipes` VALUES (39,0,0,0,0,0,0,72,0,0,31,4099,4241,728,728,2340,2418,2419,2419,0,0,125,125,125,125,1,1,1,1,'Reliquary'); -- reliquary (gold 72 wood 31) https://www.bg-wiki.com/bg/Reliquary
INSERT INTO `synth_recipes` VALUES (40,0,0,0,0,0,0,0,0,71,0,4096,4238,653,654,659,0,0,0,0,0,126,126,126,126,1,1,1,1,'Falsiam Vase');
INSERT INTO `synth_recipes` VALUES (41,0,0,0,0,45,0,5,0,0,95,4098,4240,745,823,1462,1462,1462,1991,0,0,127,127,127,127,1,1,1,1,'Coffee Table');
INSERT INTO `synth_recipes` VALUES (42,0,0,0,0,0,0,0,0,40,69,4099,4241,662,662,728,728,728,0,0,0,128,128,128,128,1,1,1,1,'Console');
INSERT INTO `synth_recipes` VALUES (43,0,0,0,0,55,0,86,0,0,0,4098,4240,745,745,791,821,829,1280,1836,1836,130,130,130,130,1,1,1,1,'Marble Bed'); -- marble bed (gold 86 cloth 55) https://www.bg-wiki.com/bg/Marble_Bed
INSERT INTO `synth_recipes` VALUES (44,0,0,0,0,0,0,23,0,0,96,4098,4240,718,790,823,937,1134,1134,1414,1447,139,139,139,139,1,1,1,1,'Star Globe');
INSERT INTO `synth_recipes` VALUES (45,0,0,0,0,0,0,0,29,0,76,4098,4240,722,1629,0,0,0,0,0,0,143,143,143,143,1,1,1,1,'Ngoma');
INSERT INTO `synth_recipes` VALUES (46,0,0,0,0,0,0,0,0,30,38,4099,4241,660,660,710,710,0,0,0,0,144,144,144,144,1,1,1,1,'Caisson');
INSERT INTO `synth_recipes` VALUES (47,0,0,0,0,0,0,97,0,41,0,4096,4238,2275,2302,2419,2419,2419,0,0,0,145,145,145,145,1,1,1,1,'Thurible'); -- thurible (gold 97 smith 41) https://www.bg-wiki.com/bg/Thurible
INSERT INTO `synth_recipes` VALUES (48,0,0,0,0,0,0,93,0,0,52,4096,4238,668,720,745,752,752,0,0,0,146,146,146,146,1,1,1,1,'Walahra Burner'); -- walahra burner (gold 93 wood 52) https://www.bg-wiki.com/bg/Walahra_Burner
INSERT INTO `synth_recipes` VALUES (49,0,0,0,0,0,0,45,96,0,0,4099,4241,745,798,823,823,2166,2289,2340,2340,147,147,147,147,1,1,1,1,'Imperial Tapestry'); -- imperial tapestry (leath 96 gold 45) https://www.bg-wiki.com/bg/Imperial_Tapestry
INSERT INTO `synth_recipes` VALUES (50,0,0,0,0,0,0,0,0,35,96,4099,4241,662,662,717,717,717,730,1762,1762,148,148,148,148,1,1,1,1,'Cartonnier'); -- cartonnier (wood 96, smithing 35?)
INSERT INTO `synth_recipes` VALUES (51,0,0,89,0,0,0,0,0,0,0,4096,4238,651,917,1887,2131,2150,2418,2419,2460,149,149,149,149,1,1,1,1,'Alchemists Tools');
INSERT INTO `synth_recipes` VALUES (52,0,0,0,0,47,0,0,92,0,43,4099,4241,725,879,1768,2287,2475,2475,0,0,150,150,150,150,1,1,1,1,'Leather Pot'); -- leather pot (leather 92, cloth 47, wood 43)
INSERT INTO `synth_recipes` VALUES (53,0,0,0,0,92,0,51,31,0,0,4099,4241,728,823,823,829,830,1271,1409,0,185,185,185,185,1,1,1,1,'Rook Banner'); -- rook banner (cloth 92 gold 51 leath 31) https://www.bg-wiki.com/bg/Rook_Banner
INSERT INTO `synth_recipes` VALUES (54,0,0,0,0,32,0,84,0,0,41,4096,4238,650,663,718,745,752,798,1634,1699,186,186,186,186,1,1,1,1,'Shield Plaque'); -- shield plaque (gold 84 wood 41 cloth 32) https://www.bg-wiki.com/bg/Shield_Plaque
INSERT INTO `synth_recipes` VALUES (55,0,0,0,0,45,0,94,0,0,37,4096,4238,653,671,717,746,754,810,1996,0,187,187,187,187,1,1,1,1,'Buckler Plaque'); -- buckler plaque (gold 94 cloth 45 wood 37) https://www.bg-wiki.com/bg/Buckler_Plaque
INSERT INTO `synth_recipes` VALUES (56,0,0,52,0,0,0,41,0,0,94,4097,4239,717,719,752,834,913,937,1110,5120,195,195,195,195,1,1,1,1,'The Big One');
INSERT INTO `synth_recipes` VALUES (57,0,0,0,0,53,0,0,0,48,92,4098,4240,664,719,719,843,843,843,1163,1626,200,200,200,200,1,1,1,1,'Tsahyan Mask');
INSERT INTO `synth_recipes` VALUES (58,0,0,0,47,0,0,0,0,0,93,4098,4240,711,718,718,718,776,1163,1163,2426,201,201,201,201,1,1,1,1,'Totem Pole');
INSERT INTO `synth_recipes` VALUES (59,0,0,0,0,0,0,98,0,0,0,4096,4238,1255,2275,2418,0,0,0,0,0,207,207,207,207,1,1,1,1,'Fire Lamp');
INSERT INTO `synth_recipes` VALUES (60,0,0,0,0,0,0,98,0,0,0,4096,4238,1256,2275,2418,0,0,0,0,0,208,208,208,208,1,1,1,1,'Ice Lamp');
INSERT INTO `synth_recipes` VALUES (61,0,0,0,0,0,0,98,0,0,0,4096,4238,1257,2275,2418,0,0,0,0,0,209,209,209,209,1,1,1,1,'Wind Lamp');
INSERT INTO `synth_recipes` VALUES (62,0,0,0,0,0,0,98,0,0,0,4096,4238,1258,2275,2418,0,0,0,0,0,210,210,210,210,1,1,1,1,'Earth Lamp');
INSERT INTO `synth_recipes` VALUES (63,0,0,0,0,0,0,98,0,0,0,4096,4238,1259,2275,2418,0,0,0,0,0,211,211,211,211,1,1,1,1,'Lightning Lamp');
INSERT INTO `synth_recipes` VALUES (64,0,0,0,0,0,0,98,0,0,0,4096,4238,1260,2275,2418,0,0,0,0,0,212,212,212,212,1,1,1,1,'Water Lamp');
INSERT INTO `synth_recipes` VALUES (65,0,0,0,0,0,0,98,0,0,0,4096,4238,1261,2275,2418,0,0,0,0,0,213,213,213,213,1,1,1,1,'Light Lamp');
INSERT INTO `synth_recipes` VALUES (66,0,0,0,0,0,0,98,0,0,0,4096,4238,1262,2275,2418,0,0,0,0,0,214,214,214,214,1,1,1,1,'Dark Lamp');
INSERT INTO `synth_recipes` VALUES (67,0,0,61,0,0,0,0,0,0,0,4096,4238,931,0,0,0,0,0,0,0,216,216,216,216,1,1,1,1,'Porc. Flowerpot');
INSERT INTO `synth_recipes` VALUES (68,0,0,0,0,0,0,16,0,0,0,4096,4238,661,661,661,0,0,0,0,0,217,217,217,217,1,1,1,1,'Brass Flowerpot');
INSERT INTO `synth_recipes` VALUES (69,0,0,7,0,0,0,0,0,4,20,4102,4244,649,706,1156,1886,1887,1894,2216,5139,222,222,222,222,1,1,1,1,'Fighting Fish Tank');
INSERT INTO `synth_recipes` VALUES (70,0,0,36,0,0,0,0,0,0,80,4102,4244,703,716,1886,1887,1895,5460,5460,5460,223,223,223,223,1,1,1,1,'River Aquarium'); -- river aquarium (wood 80, alch 36)
INSERT INTO `synth_recipes` VALUES (71,0,0,39,0,0,0,0,0,0,89,4102,4244,716,887,1886,1887,1896,4314,4314,4314,224,224,224,224,1,1,1,1,'Bay Aquarium');
INSERT INTO `synth_recipes` VALUES (72,0,0,39,0,0,0,0,0,0,89,4102,4244,716,887,1886,1887,1896,4580,4580,4580,225,225,225,225,1,1,1,1,'Reef Aquarium');
INSERT INTO `synth_recipes` VALUES (73,0,0,0,0,45,0,0,0,0,91,4099,4241,717,717,717,717,719,720,823,829,314,314,314,314,1,1,1,1,'9-drawer Almirah'); -- 9-drawer almirah (wood 91, cloth 45) https://www.bg-wiki.com/bg/9-Drawer_Almirah
INSERT INTO `synth_recipes` VALUES (74,0,0,0,0,45,0,0,0,0,91,4099,4241,717,717,717,719,720,823,829,0,315,315,315,315,1,1,1,1,'6-drawer Almirah');
INSERT INTO `synth_recipes` VALUES (75,0,0,0,0,45,0,0,0,0,91,4099,4241,717,717,719,720,823,829,0,0,316,316,316,316,1,1,1,1,'3-drawer Almirah');
INSERT INTO `synth_recipes` VALUES (76,0,0,0,0,0,0,60,0,99,0,4096,4238,686,2001,2303,2418,0,0,0,0,317,317,317,317,1,1,1,1,'Bronze Rose');
INSERT INTO `synth_recipes` VALUES (77,0,0,100,0,0,0,60,0,0,0,4096,4238,2275,2460,2460,2460,0,0,0,0,318,318,318,318,1,1,1,1,'Crystal Rose'); -- Crystal Rose (alch 100, gold 60)
INSERT INTO `synth_recipes` VALUES (78,0,0,42,94,0,0,0,0,0,0,4098,4240,1618,2460,2475,2475,17316,0,0,0,319,319,319,319,1,1,1,1,'Shell Lamp'); -- shell lamp (bone 94, alch 42)
INSERT INTO `synth_recipes` VALUES (79,0,0,0,0,0,0,27,0,100,0,4096,4238,653,653,653,653,659,1163,1711,2275,321,321,321,321,1,1,1,1,'Mythril Bell');
INSERT INTO `synth_recipes` VALUES (80,0,0,0,79,0,0,0,0,0,50,4099,4241,820,1615,1615,1998,2533,0,0,0,322,322,322,322,1,1,1,1,'Horn Trophy'); -- horn trophy (bone 79, wood 50) https://www.bg-wiki.com/bg/Horn_Trophy
INSERT INTO `synth_recipes` VALUES (81,0,0,0,0,0,0,36,0,0,82,4099,4241,710,725,728,799,799,2379,0,0,326,326,326,326,1,1,1,1,'Yellow Hobby Bo');
INSERT INTO `synth_recipes` VALUES (82,0,0,0,0,0,0,27,0,0,82,4099,4241,710,725,728,799,799,2380,0,0,327,327,327,327,1,1,1,1,'Red Hobby Bo');
INSERT INTO `synth_recipes` VALUES (83,0,0,0,0,0,0,60,0,0,82,4099,4241,710,725,728,799,799,2383,0,0,328,328,328,328,1,1,1,1,'Black Hobby Bo');
INSERT INTO `synth_recipes` VALUES (84,0,0,0,0,0,0,19,0,0,82,4099,4241,710,725,728,799,799,2381,0,0,329,329,329,329,1,1,1,1,'Blue Hobby Bo');
INSERT INTO `synth_recipes` VALUES (85,0,0,0,0,0,0,33,0,0,82,4099,4241,710,725,728,799,799,2382,0,0,330,330,330,330,1,1,1,1,'Green Hobby Bo');
INSERT INTO `synth_recipes` VALUES (86,0,0,0,0,57,0,0,0,30,65,4099,4241,662,710,711,715,715,827,827,832,349,349,349,349,1,1,1,1,'Ryl. Sqr. Bunk');
INSERT INTO `synth_recipes` VALUES (87,0,0,0,0,34,0,0,0,48,0,4099,4241,651,652,662,662,710,826,826,834,350,350,350,350,1,1,1,1,'Rep. Lgn. Bedding');
INSERT INTO `synth_recipes` VALUES (88,0,0,0,0,0,0,0,0,0,59,4099,4241,704,706,714,714,721,721,721,1414,351,351,351,351,1,1,1,1,'Fed. Mrc. Hammock'); -- federal mercenary's hammock (wood 59) https://www.bg-wiki.com/bg/Fed._Mrc._Hammock
INSERT INTO `synth_recipes` VALUES (89,0,0,0,0,0,0,0,0,0,78,4099,4241,717,717,717,717,721,721,721,721,357,357,357,357,1,1,1,1,'Partition'); -- partition (wood 78) https://www.bg-wiki.com/bg/Partition
INSERT INTO `synth_recipes` VALUES (90,0,0,0,0,0,0,0,0,0,83,4099,4241,721,721,721,2533,2533,2533,2533,2535,358,358,358,358,1,1,1,1,'Credenza'); -- credenza (wood 83) https://www.bg-wiki.com/bg/Credenza
INSERT INTO `synth_recipes` VALUES (91,0,0,0,0,0,0,0,0,0,40,4099,4241,711,711,711,711,711,721,721,721,359,359,359,359,1,1,1,1,'Bahut');
INSERT INTO `synth_recipes` VALUES (92,0,0,18,0,0,0,0,0,0,0,4096,4238,2563,2563,2563,2563,2563,0,0,0,360,360,360,360,1,1,1,1,'Matka'); -- matka (alch 18)
INSERT INTO `synth_recipes` VALUES (93,0,0,81,0,0,0,0,0,0,33,4096,4238,693,704,1888,2549,2563,2563,2563,2563,361,361,361,361,1,1,1,1,'Gallipot'); -- gallipot (alch 81, wood 33)
INSERT INTO `synth_recipes` VALUES (94,0,0,80,0,0,0,41,0,0,0,4101,4243,1588,1774,2154,2235,4136,17868,0,0,362,362,362,362,1,1,1,1,'Fluoro-flora'); -- fluoro-flora (alch 80, gold 41)
INSERT INTO `synth_recipes` VALUES (95,0,0,52,0,0,0,0,0,0,54,4099,4241,769,1774,1817,2563,17868,0,0,0,364,364,364,364,1,1,1,1,'Amiga Cactus'); -- amiga cactus (earth crystal) https://www.bg-wiki.com/bg/Amiga_Cactus
INSERT INTO `synth_recipes` VALUES (96,0,0,99,0,0,0,0,0,0,0,4096,4238,744,813,2475,2475,0,0,0,0,368,368,368,368,1,1,1,1,'San. Tea Set');
INSERT INTO `synth_recipes` VALUES (97,0,0,0,0,0,0,79,0,0,0,4096,4238,653,655,744,0,0,0,0,0,369,369,369,369,1,1,1,1,'Bas. Tea Set');
INSERT INTO `synth_recipes` VALUES (98,0,0,0,0,0,0,0,0,0,79,4098,4240,1134,2535,0,0,0,0,0,0,370,370,370,370,1,1,1,1,'Win. Tea Set');
INSERT INTO `synth_recipes` VALUES (99,0,0,0,0,0,0,0,0,0,88,4099,4241,717,717,717,717,717,717,2533,2533,374,374,374,374,1,1,1,1,'Parclose'); -- parclose (wood 88) https://www.bg-wiki.com/bg/Parclose
INSERT INTO `synth_recipes` VALUES (100,0,0,34,0,71,0,0,0,0,0,4101,4243,314,823,2706,0,0,0,0,0,378,378,378,378,1,1,1,1,'Blue 9d Almirah'); -- recipes 100-111 are all level 71 https://www.bg-wiki.com/bg/Blue_9D_Almirah
INSERT INTO `synth_recipes` VALUES (101,0,0,34,0,71,0,0,0,0,0,4101,4243,315,823,2706,0,0,0,0,0,379,379,379,379,1,1,1,1,'Blue 6d Almirah');
INSERT INTO `synth_recipes` VALUES (102,0,0,34,0,71,0,0,0,0,0,4101,4243,316,823,2706,0,0,0,0,0,380,380,380,380,1,1,1,1,'Blue 3d Almirah');
INSERT INTO `synth_recipes` VALUES (103,0,0,34,0,71,0,0,0,0,0,4101,4243,314,823,2707,0,0,0,0,0,381,381,381,381,1,1,1,1,'Green 9d Almirah');
INSERT INTO `synth_recipes` VALUES (104,0,0,34,0,71,0,0,0,0,0,4101,4243,315,823,2707,0,0,0,0,0,382,382,382,382,1,1,1,1,'Green 6d Almirah');
INSERT INTO `synth_recipes` VALUES (105,0,0,34,0,71,0,0,0,0,0,4101,4243,316,823,2707,0,0,0,0,0,383,383,383,383,1,1,1,1,'Green 3d Almirah');
INSERT INTO `synth_recipes` VALUES (106,0,0,34,0,71,0,0,0,0,0,4101,4243,314,823,2708,0,0,0,0,0,384,384,384,384,1,1,1,1,'Yellow 9d Almirah');
INSERT INTO `synth_recipes` VALUES (107,0,0,34,0,71,0,0,0,0,0,4101,4243,315,823,2708,0,0,0,0,0,385,385,385,385,1,1,1,1,'Yellow 6d Almirah');
INSERT INTO `synth_recipes` VALUES (108,0,0,34,0,71,0,0,0,0,0,4101,4243,316,823,2708,0,0,0,0,0,386,386,386,386,1,1,1,1,'Yellow 3d Almirah');
INSERT INTO `synth_recipes` VALUES (109,0,0,34,0,71,0,0,0,0,0,4101,4243,314,823,2709,0,0,0,0,0,387,387,387,387,1,1,1,1,'White 9d Almirah');
INSERT INTO `synth_recipes` VALUES (110,0,0,34,0,71,0,0,0,0,0,4101,4243,315,823,2709,0,0,0,0,0,388,388,388,388,1,1,1,1,'White 6d Almirah');
INSERT INTO `synth_recipes` VALUES (111,0,0,34,0,71,0,0,0,0,0,4101,4243,316,823,2709,0,0,0,0,0,389,389,389,389,1,1,1,1,'White 3d Almirah');
INSERT INTO `synth_recipes` VALUES (112,1,0,0,91,0,0,0,0,0,0,4100,4242,15159,0,0,0,0,0,0,0,506,1163,887,887,1,1,1,2,'Coeurl Leather');
INSERT INTO `synth_recipes` VALUES (113,0,2018,0,0,0,0,0,71,0,0,4103,4245,635,635,635,863,863,863,2129,4509,506,506,506,506,3,3,3,3,'Coeurl Leather');
INSERT INTO `synth_recipes` VALUES (114,0,0,0,0,0,0,0,71,0,0,4103,4245,635,863,4509,0,0,0,0,0,506,506,506,506,1,1,1,1,'Coeurl Leather');
INSERT INTO `synth_recipes` VALUES (115,0,0,0,0,0,0,0,71,0,0,4103,4245,695,863,4509,0,0,0,0,0,506,506,506,506,1,1,1,1,'Coeurl Leather');
INSERT INTO `synth_recipes` VALUES (116,0,0,0,0,0,0,0,0,5,2,4096,4238,649,708,0,0,0,0,0,0,605,605,605,605,1,2,3,4,'Pickaxe');
INSERT INTO `synth_recipes` VALUES (117,0,0,0,0,0,20,0,0,0,0,4097,4239,936,4378,0,0,0,0,0,0,615,615,615,615,4,6,9,12,'Selbina Butter');
INSERT INTO `synth_recipes` VALUES (118,0,0,0,0,0,42,0,0,0,0,4101,4243,610,615,936,0,0,0,0,0,616,616,616,616,4,6,9,12,'Pie Dough');
INSERT INTO `synth_recipes` VALUES (119,0,0,5,0,0,13,0,0,0,0,4097,4239,1522,1522,1522,1522,1522,1522,1522,1522,622,622,622,622,9,12,12,12,'Dried Marjoram');
INSERT INTO `synth_recipes` VALUES (120,0,0,0,0,0,41,0,0,0,0,4103,4245,4363,4363,4363,4370,0,0,0,0,625,625,625,625,4,6,9,12,'Apple Vinegar');
INSERT INTO `synth_recipes` VALUES (121,0,0,0,0,0,0,0,0,0,21,4100,4242,691,0,0,0,0,0,0,0,627,627,627,627,3,6,9,12,'Maple Sugar');
INSERT INTO `synth_recipes` VALUES (122,1,0,24,0,0,0,0,0,0,0,4101,4243,1162,0,0,0,0,0,0,0,633,915,637,637,3,2,1,1,'Olive Oil');
INSERT INTO `synth_recipes` VALUES (123,0,0,0,0,0,0,3,0,0,0,4096,4238,640,640,640,640,0,0,0,0,648,648,648,648,1,1,1,1,'Copper Ingot');
INSERT INTO `synth_recipes` VALUES (124,0,0,0,0,0,0,4,0,0,0,4096,4238,640,1230,1230,1230,1230,1230,1230,0,648,648,648,648,1,1,1,1,'Copper Ingot');
INSERT INTO `synth_recipes` VALUES (125,1,0,0,0,0,0,1,0,0,0,4100,4242,498,0,0,0,0,0,0,0,648,648,648,648,1,1,1,1,'Copper Ingot'); -- yagudo necklace (desynth)
INSERT INTO `synth_recipes` VALUES (126,1,0,0,0,0,0,97,0,0,0,4100,4242,1374,0,0,0,0,0,0,0,648,931,745,746,1,1,1,1,'Copper Ingot');
INSERT INTO `synth_recipes` VALUES (127,1,0,0,0,0,0,62,0,0,0,4100,4242,12417,0,0,0,0,0,0,0,648,850,653,653,1,1,1,1,'Copper Ingot');
INSERT INTO `synth_recipes` VALUES (128,1,0,0,0,0,0,48,0,0,0,4100,4242,12426,0,0,0,0,0,0,0,648,850,850,850,1,1,1,1,'Copper Ingot');
INSERT INTO `synth_recipes` VALUES (129,1,0,0,0,0,0,9,0,0,0,4100,4242,12472,0,0,0,0,0,0,0,648,648,650,650,1,1,1,1,'Copper Ingot');
INSERT INTO `synth_recipes` VALUES (130,1,0,0,0,0,0,21,0,0,0,4100,4242,12473,0,0,0,0,0,0,0,648,648,653,653,1,1,1,1,'Copper Ingot');
INSERT INTO `synth_recipes` VALUES (131,1,0,0,0,0,0,7,0,0,0,4100,4242,12496,0,0,0,0,0,0,0,648,648,648,648,1,1,1,1,'Copper Ingot');
INSERT INTO `synth_recipes` VALUES (132,1,0,0,0,0,0,64,0,0,0,4100,4242,12502,0,0,0,0,0,0,0,648,648,939,653,1,1,1,1,'Copper Ingot');
INSERT INTO `synth_recipes` VALUES (133,1,0,0,0,0,0,5,0,0,0,4100,4242,13454,0,0,0,0,0,0,0,648,648,648,648,1,1,2,2,'Copper Ingot');
INSERT INTO `synth_recipes` VALUES (134,1,0,0,0,0,0,3,0,0,0,4100,4242,16482,0,0,0,0,0,0,0,648,648,648,648,1,2,2,2,'Copper Ingot');
INSERT INTO `synth_recipes` VALUES (135,1,0,0,0,0,0,0,0,53,0,4100,4242,16960,0,0,0,0,0,0,0,648,648,648,648,1,1,1,1,'Copper Ingot');
INSERT INTO `synth_recipes` VALUES (136,1,0,0,0,0,0,21,0,0,0,4100,4242,17399,0,0,0,0,0,0,0,648,648,648,818,1,2,3,2,'Copper Ingot');
INSERT INTO `synth_recipes` VALUES (137,1,0,31,0,0,0,0,0,0,0,4100,4242,17407,0,0,0,0,0,0,0,648,648,933,933,1,1,1,1,'Copper Ingot');
INSERT INTO `synth_recipes` VALUES (138,0,0,0,0,0,0,0,0,2,0,4096,4238,640,640,640,641,0,0,0,0,649,649,649,649,1,1,1,1,'Bronze Ingot');
INSERT INTO `synth_recipes` VALUES (139,0,0,0,0,0,0,0,0,3,0,4096,4238,641,1232,1232,1232,1232,1232,1232,0,649,649,649,649,1,1,1,1,'Bronze Ingot');
INSERT INTO `synth_recipes` VALUES (140,0,0,0,0,0,0,0,0,1,0,4096,4238,656,656,656,656,0,0,0,0,649,649,649,649,1,1,1,1,'Bronze Ingot');
INSERT INTO `synth_recipes` VALUES (141,1,0,0,0,0,0,0,0,49,0,4100,4242,501,0,0,0,0,0,0,0,649,651,652,654,1,1,1,1,'Bronze Ingot');
INSERT INTO `synth_recipes` VALUES (142,1,0,0,0,0,0,0,0,19,0,4100,4242,507,0,0,0,0,0,0,0,649,651,652,652,3,2,1,1,'Bronze Ingot');
INSERT INTO `synth_recipes` VALUES (143,1,0,0,0,0,0,0,0,19,0,4100,4242,508,0,0,0,0,0,0,0,649,651,652,652,1,1,1,1,'Bronze Ingot');
INSERT INTO `synth_recipes` VALUES (144,1,0,0,0,0,0,0,0,65,0,4100,4242,566,0,0,0,0,0,0,0,649,649,649,649,1,1,1,1,'Bronze Ingot');
INSERT INTO `synth_recipes` VALUES (145,1,0,0,0,0,0,0,0,51,0,4100,4242,596,0,0,0,0,0,0,0,649,651,651,654,1,1,1,1,'Bronze Ingot');
INSERT INTO `synth_recipes` VALUES (146,1,0,0,0,0,0,0,0,76,0,4100,4242,1118,0,0,0,0,0,0,0,649,654,654,654,2,1,1,1,'Bronze Ingot');
INSERT INTO `synth_recipes` VALUES (147,1,0,0,0,0,0,0,0,79,0,4100,4242,2160,0,0,0,0,0,0,0,649,2302,2302,2302,1,1,1,1,'Bronze Ingot');
INSERT INTO `synth_recipes` VALUES (148,1,0,0,0,0,0,0,0,79,0,4100,4242,2161,0,0,0,0,0,0,0,649,2302,2302,2302,2,1,2,2,'Bronze Ingot');
INSERT INTO `synth_recipes` VALUES (149,1,0,0,0,0,0,0,0,4,0,4100,4242,12448,0,0,0,0,0,0,0,649,850,649,850,1,1,1,2,'Bronze Ingot');
INSERT INTO `synth_recipes` VALUES (150,1,0,0,0,0,0,10,0,0,0,4100,4242,12449,0,0,0,0,0,0,0,649,650,850,850,1,1,1,2,'Bronze Ingot');
INSERT INTO `synth_recipes` VALUES (151,1,0,0,0,0,0,0,0,11,0,4100,4242,12576,0,0,0,0,0,0,0,649,649,850,850,2,3,1,2,'Bronze Ingot');
INSERT INTO `synth_recipes` VALUES (152,1,0,0,0,0,0,18,0,0,0,4100,4242,12577,0,0,0,0,0,0,0,649,850,650,650,3,1,2,2,'Bronze Ingot');
INSERT INTO `synth_recipes` VALUES (153,1,0,0,0,0,0,32,0,0,0,4100,4242,12629,0,0,0,0,0,0,0,649,850,850,850,1,2,2,2,'Bronze Ingot');
INSERT INTO `synth_recipes` VALUES (154,1,0,0,0,0,0,0,0,11,0,4100,4242,12688,0,0,0,0,0,0,0,649,818,817,817,2,1,3,3,'Bronze Ingot');
INSERT INTO `synth_recipes` VALUES (155,1,0,0,0,0,0,0,0,5,0,4100,4242,12704,0,0,0,0,0,0,0,649,649,850,850,1,1,1,1,'Bronze Ingot');
INSERT INTO `synth_recipes` VALUES (156,1,0,0,0,0,0,0,0,15,0,4100,4242,12816,0,0,0,0,0,0,0,649,817,818,850,2,6,1,2,'Bronze Ingot');
INSERT INTO `synth_recipes` VALUES (157,1,0,0,0,0,0,16,0,0,0,4100,4242,12832,0,0,0,0,0,0,0,817,850,649,650,3,1,1,1,'Grass Thread'); -- bronze subligar desynth http://ffxiclopedia.wikia.com/wiki/Bronze_Subligar
INSERT INTO `synth_recipes` VALUES (158,1,0,0,0,0,0,0,0,13,0,4100,4242,12944,0,0,0,0,0,0,0,649,818,850,850,3,1,2,3,'Bronze Ingot');
INSERT INTO `synth_recipes` VALUES (159,1,0,0,0,0,0,0,6,0,0,4100,4242,12952,0,0,0,0,0,0,0,649,850,850,850,1,1,2,3,'Bronze Ingot');
INSERT INTO `synth_recipes` VALUES (160,1,0,0,0,0,0,0,0,2,0,4100,4242,12960,0,0,0,0,0,0,0,649,649,850,850,1,2,1,2,'Bronze Ingot');
INSERT INTO `synth_recipes` VALUES (161,1,0,0,0,0,0,14,0,0,0,4100,4242,12961,0,0,0,0,0,0,0,649,650,850,850,1,1,1,2,'Bronze Ingot');
INSERT INTO `synth_recipes` VALUES (162,1,0,0,29,0,0,0,0,16,0,4100,4242,16409,0,0,0,0,0,0,0,649,880,880,855,1,2,3,1,'Bronze Ingot');
INSERT INTO `synth_recipes` VALUES (163,1,0,0,0,0,0,76,0,0,0,4100,4242,16421,0,0,0,0,0,0,0,649,649,745,745,1,2,1,1,'Bronze Ingot');
INSERT INTO `synth_recipes` VALUES (164,1,0,0,0,0,0,0,0,10,0,4100,4242,16433,0,0,0,0,0,0,0,649,649,649,649,1,1,1,1,'Bronze Ingot');
INSERT INTO `synth_recipes` VALUES (165,1,0,0,0,0,0,0,0,3,0,4100,4242,16448,0,0,0,0,0,0,0,649,649,648,648,1,1,1,1,'Bronze Ingot');
INSERT INTO `synth_recipes` VALUES (166,1,0,0,0,0,0,0,0,5,0,4100,4242,16465,0,0,0,0,0,0,0,649,649,715,715,1,1,1,1,'Bronze Ingot');
INSERT INTO `synth_recipes` VALUES (167,1,0,0,0,0,0,0,0,8,0,4100,4242,16530,0,0,0,0,0,0,0,649,649,893,893,1,1,1,1,'Bronze Ingot');
INSERT INTO `synth_recipes` VALUES (168,1,0,0,0,0,0,0,0,14,0,4100,4242,16533,0,0,0,0,0,0,0,649,649,893,797,1,2,1,1,'Bronze Ingot');
INSERT INTO `synth_recipes` VALUES (169,1,0,0,0,0,0,0,0,10,0,4100,4242,16534,0,0,0,0,0,0,0,649,648,850,850,1,1,1,2,'Bronze Ingot'); -- onion sword (desynth)
INSERT INTO `synth_recipes` VALUES (170,1,0,0,0,0,0,0,0,6,0,4100,4242,16535,0,0,0,0,0,0,0,649,649,850,850,1,2,1,1,'Bronze Ingot');
INSERT INTO `synth_recipes` VALUES (171,1,0,0,0,0,0,0,0,91,0,4100,4242,16544,0,0,0,0,0,0,0,649,649,649,649,1,1,1,1,'Bronze Ingot');
INSERT INTO `synth_recipes` VALUES (172,1,0,0,0,0,0,0,0,25,0,4100,4242,16565,0,0,0,0,0,0,0,649,649,649,852,1,2,3,1,'Bronze Ingot');
INSERT INTO `synth_recipes` VALUES (173,1,0,14,0,0,0,0,0,0,0,4100,4242,16572,0,0,0,0,0,0,0,649,649,913,852,2,3,2,2,'Bronze Ingot');
INSERT INTO `synth_recipes` VALUES (174,1,0,0,0,0,0,0,0,65,0,4100,4242,16702,0,0,0,0,0,0,0,649,649,649,649,1,1,1,1,'Bronze Ingot');
INSERT INTO `synth_recipes` VALUES (175,1,0,0,0,0,0,0,0,43,0,4100,4242,16719,0,0,0,0,0,0,0,649,649,649,649,2,2,2,2,'Bronze Ingot');
INSERT INTO `synth_recipes` VALUES (176,1,0,0,0,0,0,0,0,0,54,4100,4242,17030,0,0,0,0,0,0,0,649,649,717,717,1,1,1,1,'Bronze Ingot');
INSERT INTO `synth_recipes` VALUES (177,1,0,0,0,0,0,0,0,10,0,4100,4242,17034,0,0,0,0,0,0,0,649,649,649,649,1,1,2,3,'Bronze Ingot');
INSERT INTO `synth_recipes` VALUES (178,1,0,0,0,0,0,0,0,14,0,4100,4242,17042,0,0,0,0,0,0,0,649,649,710,710,1,2,1,1,'Bronze Ingot');
INSERT INTO `synth_recipes` VALUES (179,1,0,0,0,0,0,24,0,0,0,4100,4242,17043,0,0,0,0,0,0,0,649,649,649,649,1,2,2,2,'Bronze Ingot');
INSERT INTO `synth_recipes` VALUES (180,1,0,0,0,0,0,0,0,12,0,4100,4242,17059,0,0,0,0,0,0,0,649,649,649,648,1,1,2,1,'Bronze Ingot');
INSERT INTO `synth_recipes` VALUES (181,1,0,0,0,0,0,0,0,31,0,4100,4242,17060,0,0,0,0,0,0,0,649,649,651,651,1,2,1,2,'Bronze Ingot');
INSERT INTO `synth_recipes` VALUES (182,1,0,0,0,0,0,0,0,67,0,4100,4242,17068,0,0,0,0,0,0,0,649,649,648,648,1,1,1,1,'Bronze Ingot');
INSERT INTO `synth_recipes` VALUES (183,1,0,0,0,0,0,31,0,0,0,4100,4242,17071,0,0,0,0,0,0,0,649,651,651,800,1,1,2,1,'Bronze Ingot');
INSERT INTO `synth_recipes` VALUES (184,1,0,0,0,0,0,23,0,0,0,4100,4242,17081,0,0,0,0,0,0,0,649,649,648,650,1,2,1,1,'Bronze Ingot');
INSERT INTO `synth_recipes` VALUES (185,0,0,0,0,0,0,9,0,0,0,4096,4238,640,640,640,642,0,0,0,0,650,650,650,650,1,1,1,1,'Brass Ingot');
INSERT INTO `synth_recipes` VALUES (186,0,0,0,0,0,0,10,0,0,0,4096,4238,642,1231,1231,1231,1231,1231,1231,0,650,650,650,650,1,1,1,1,'Brass Ingot');
INSERT INTO `synth_recipes` VALUES (187,1,0,0,0,0,0,23,0,0,0,4100,4242,1625,0,0,0,0,0,0,0,650,650,650,745,1,1,1,1,'Brass Ingot');
INSERT INTO `synth_recipes` VALUES (188,1,0,0,0,0,0,24,0,0,0,4100,4242,1632,0,0,0,0,0,0,0,650,650,650,745,3,3,3,1,'Brass Ingot');
INSERT INTO `synth_recipes` VALUES (189,1,0,0,0,0,0,0,0,29,0,4100,4242,12424,0,0,0,0,0,0,0,650,650,651,651,1,1,1,1,'Brass Ingot');
INSERT INTO `synth_recipes` VALUES (190,1,0,0,0,0,0,29,0,0,0,4100,4242,12433,0,0,0,0,0,0,0,650,650,650,650,1,1,1,1,'Brass Ingot');
INSERT INTO `synth_recipes` VALUES (191,1,0,0,0,55,0,0,0,0,0,4100,4242,12475,0,0,0,0,0,0,0,650,816,816,820,1,2,3,6,'Brass Ingot'); -- velvet hat desynth (cloth 55) http://ffxiclopedia.wikia.com/wiki/Velvet_Hat
INSERT INTO `synth_recipes` VALUES (192,1,0,0,0,0,0,17,0,0,0,4100,4242,12497,0,0,0,0,0,0,0,650,650,650,650,1,1,1,1,'Brass Ingot');
INSERT INTO `synth_recipes` VALUES (193,1,0,0,0,0,0,12,0,0,0,4100,4242,12705,0,0,0,0,0,0,0,650,850,649,649,1,1,1,1,'Brass Ingot');
INSERT INTO `synth_recipes` VALUES (194,1,0,0,0,0,0,6,0,0,0,4100,4242,12750,0,0,0,0,0,0,0,650,744,815,815,1,1,1,1,'Brass Ingot');
INSERT INTO `synth_recipes` VALUES (195,1,0,0,0,0,0,60,0,0,0,4100,4242,13003,0,0,0,0,0,0,0,650,650,650,650,1,1,1,1,'Brass Ingot');
INSERT INTO `synth_recipes` VALUES (196,1,0,0,0,0,0,73,0,0,0,4100,4242,13093,0,0,0,0,0,0,0,650,744,744,744,1,1,1,1,'Brass Ingot');
INSERT INTO `synth_recipes` VALUES (197,1,0,0,0,0,0,92,0,0,0,4100,4242,13185,0,0,0,0,0,0,0,650,1117,745,745,1,1,1,1,'Brass Ingot');
INSERT INTO `synth_recipes` VALUES (198,1,0,0,0,0,0,15,0,0,0,4100,4242,13465,0,0,0,0,0,0,0,650,650,650,650,1,1,2,2,'Brass Ingot');
INSERT INTO `synth_recipes` VALUES (199,1,0,54,0,0,0,0,0,0,0,4100,4242,13682,0,0,0,0,0,0,0,650,937,937,937,1,1,1,1,'Brass Ingot');
INSERT INTO `synth_recipes` VALUES (200,1,0,6,0,0,0,0,0,0,0,4100,4242,13683,0,0,0,0,0,0,0,650,850,937,937,1,1,1,1,'Brass Ingot');
INSERT INTO `synth_recipes` VALUES (201,1,0,0,0,0,0,19,0,0,0,4100,4242,14139,0,0,0,0,0,0,0,650,650,650,650,1,1,1,1,'Brass Ingot');
INSERT INTO `synth_recipes` VALUES (202,1,0,0,0,0,0,19,0,0,0,4100,4242,16531,0,0,0,0,0,0,0,650,650,650,650,1,1,1,1,'Brass Ingot'); -- brass xiphos desynth (gold 19) http://ffxiclopedia.wikia.com/wiki/Brass_Xiphos
INSERT INTO `synth_recipes` VALUES (203,1,0,0,0,0,0,7,0,0,0,4100,4242,16551,0,0,0,0,0,0,0,650,650,744,744,1,2,1,1,'Brass Ingot'); -- sapara desynth (gold 7) https://www.bg-wiki.com/bg/Sapara
INSERT INTO `synth_recipes` VALUES (204,1,0,0,0,0,0,0,0,24,0,4100,4242,16552,0,0,0,0,0,0,0,650,650,652,652,1,1,1,2,'Brass Ingot');
INSERT INTO `synth_recipes` VALUES (205,1,0,0,0,0,0,0,0,89,0,4100,4242,17251,0,0,0,0,0,0,0,650,654,1225,719,1,1,6,1,'Brass Ingot');
INSERT INTO `synth_recipes` VALUES (206,1,0,0,14,0,0,0,0,0,0,4100,4242,17344,0,0,0,0,0,0,0,650,650,880,880,1,1,1,1,'Brass Ingot');
INSERT INTO `synth_recipes` VALUES (207,1,0,46,0,0,0,0,0,0,0,4100,4242,17403,0,0,0,0,0,0,0,650,650,933,933,1,1,1,1,'Brass Ingot');
INSERT INTO `synth_recipes` VALUES (208,1,0,0,0,0,0,20,0,0,0,4100,4242,19009,0,0,0,0,0,0,0,650,650,650,650,1,2,2,2,'Brass Ingot');
INSERT INTO `synth_recipes` VALUES (209,0,0,0,0,0,0,0,0,20,0,4096,4238,643,643,643,643,0,0,0,0,651,652,652,652,1,1,1,1,'Iron Ingot');
INSERT INTO `synth_recipes` VALUES (210,0,0,0,0,0,0,0,0,21,0,4096,4238,643,1234,1234,1234,1234,1234,1234,0,651,652,652,652,1,1,1,1,'Iron Ingot');
INSERT INTO `synth_recipes` VALUES (211,1,0,0,0,0,0,0,0,30,0,4100,4242,2162,0,0,0,0,0,0,0,651,652,652,652,1,1,1,1,'Iron Ingot');
INSERT INTO `synth_recipes` VALUES (212,1,0,0,0,0,0,0,0,0,74,4100,4242,12295,0,0,0,0,0,0,0,651,718,662,662,1,1,1,1,'Iron Ingot');
INSERT INTO `synth_recipes` VALUES (213,1,0,0,0,0,0,80,0,0,0,4100,4242,12303,0,0,0,0,0,0,0,651,714,914,745,1,1,1,1,'Iron Ingot');
INSERT INTO `synth_recipes` VALUES (214,1,0,0,0,0,0,0,0,59,0,4100,4242,14051,0,0,0,0,0,0,0,651,651,654,654,1,1,1,1,'Iron Ingot');
INSERT INTO `synth_recipes` VALUES (215,1,0,0,0,0,0,0,0,23,0,4100,4242,16406,0,0,0,0,0,0,0,651,651,651,651,1,1,1,1,'Iron Ingot');
INSERT INTO `synth_recipes` VALUES (216,1,0,0,0,0,0,52,0,0,0,4100,4242,16518,0,0,0,0,0,0,0,651,651,653,653,1,2,1,2,'Iron Ingot');
INSERT INTO `synth_recipes` VALUES (217,1,0,0,0,0,0,0,0,25,0,4100,4242,16536,0,0,0,0,0,0,0,651,852,651,651,1,1,2,2,'Iron Ingot');
INSERT INTO `synth_recipes` VALUES (218,1,0,0,0,0,0,0,0,27,0,4100,4242,16566,0,0,0,0,0,0,0,651,651,651,651,2,2,2,2,'Iron Ingot');
INSERT INTO `synth_recipes` VALUES (219,1,0,0,0,0,0,0,0,36,0,4100,4242,16745,0,0,0,0,0,0,0,651,651,651,651,1,1,1,1,'Iron Ingot');
INSERT INTO `synth_recipes` VALUES (220,1,0,0,0,0,0,0,0,3,0,4100,4242,17083,0,0,0,0,0,0,0,651,652,654,654,1,1,1,1,'Iron Ingot');
INSERT INTO `synth_recipes` VALUES (221,1,0,0,0,0,0,0,0,0,50,4100,4242,17523,0,0,0,0,0,0,0,651,711,711,711,1,1,1,1,'Iron Ingot');
INSERT INTO `synth_recipes` VALUES (222,0,0,0,0,0,0,0,0,55,0,4096,4238,643,1235,1235,1235,1235,1235,1235,0,652,657,657,657,1,1,1,1,'Steel Ingot');
INSERT INTO `synth_recipes` VALUES (223,0,0,0,0,0,0,0,0,54,0,4096,4238,928,928,928,928,1155,1155,1155,1155,652,657,657,657,1,1,1,1,'Steel Ingot');
INSERT INTO `synth_recipes` VALUES (224,0,0,0,0,0,0,0,0,55,0,4096,4238,928,1155,1155,1155,1155,1630,0,0,652,657,657,657,1,1,1,1,'Steel Ingot');
INSERT INTO `synth_recipes` VALUES (225,1,0,0,0,0,0,83,0,0,0,4100,4242,16521,0,0,0,0,0,0,0,652,652,745,810,1,2,1,1,'Steel Ingot');
INSERT INTO `synth_recipes` VALUES (226,1,0,0,0,0,0,0,0,45,0,4100,4242,17061,0,0,0,0,0,0,0,652,652,1226,653,1,2,6,2,'Steel Ingot');
INSERT INTO `synth_recipes` VALUES (227,1,0,0,0,0,0,0,0,50,0,4100,4242,17248,0,0,0,0,0,0,0,652,652,652,652,1,1,1,1,'Steel Ingot');
INSERT INTO `synth_recipes` VALUES (228,1,0,0,0,0,0,0,0,88,0,4100,4242,17818,0,0,0,0,0,0,0,652,715,852,657,1,1,1,1,'Steel Ingot');
INSERT INTO `synth_recipes` VALUES (229,0,0,0,0,0,0,40,0,0,0,4096,4238,644,644,644,644,0,0,0,0,653,653,653,653,1,1,1,1,'Mythril Ingot');
INSERT INTO `synth_recipes` VALUES (230,0,0,0,0,0,0,41,0,0,0,4096,4238,644,1226,1226,1226,1226,1226,1226,0,653,653,653,653,1,1,1,1,'Mythril Ingot');
INSERT INTO `synth_recipes` VALUES (231,0,0,0,0,0,0,38,0,0,0,4096,4238,749,749,749,749,0,0,0,0,653,653,653,653,1,1,1,1,'Mythril Ingot');
INSERT INTO `synth_recipes` VALUES (232,1,0,0,0,0,0,49,0,0,0,4100,4242,12301,0,0,0,0,0,0,0,653,653,653,653,1,1,1,1,'Mythril Ingot');
INSERT INTO `synth_recipes` VALUES (233,1,0,0,0,0,0,59,0,0,0,4100,4242,13144,0,0,0,0,0,0,0,653,653,653,653,1,1,1,1,'Mythril Ingot');
INSERT INTO `synth_recipes` VALUES (234,1,0,0,0,0,0,42,0,0,0,4100,4242,13328,0,0,0,0,0,0,0,653,653,653,653,1,1,2,2,'Mythril Ingot');
INSERT INTO `synth_recipes` VALUES (235,1,0,0,0,0,0,47,0,0,0,4100,4242,13446,0,0,0,0,0,0,0,653,653,653,653,1,1,2,2,'Mythril Ingot');
INSERT INTO `synth_recipes` VALUES (236,1,0,0,0,0,0,45,0,0,0,4100,4242,14790,0,0,0,0,0,0,0,653,653,653,653,1,1,1,1,'Mythril Ingot');
INSERT INTO `synth_recipes` VALUES (237,1,0,0,0,0,0,0,0,42,0,4100,4242,16475,0,0,0,0,0,0,0,653,653,653,653,1,1,1,1,'Mythril Ingot');
INSERT INTO `synth_recipes` VALUES (238,0,0,0,0,0,0,0,0,52,0,4096,4238,643,643,643,645,0,0,0,0,654,654,654,654,1,1,1,1,'Darksteel Ingot');
INSERT INTO `synth_recipes` VALUES (239,0,0,0,0,0,0,0,0,53,0,4096,4238,645,1228,1228,1228,1228,1228,1228,0,654,654,654,654,1,1,1,1,'Darksteel Ingot');
INSERT INTO `synth_recipes` VALUES (240,1,0,0,0,0,0,0,0,92,0,4100,4242,16452,0,0,0,0,0,0,0,654,654,654,654,1,1,1,1,'Darksteel Ingot');
INSERT INTO `synth_recipes` VALUES (241,1,0,0,0,0,0,0,0,70,0,4100,4242,18014,0,0,0,0,0,0,0,654,654,654,654,1,1,1,1,'Darksteel Ingot');
INSERT INTO `synth_recipes` VALUES (242,0,0,0,0,0,0,0,0,90,0,4096,4238,643,646,646,646,0,0,0,0,655,655,655,655,1,1,1,1,'Adaman Ingot');
INSERT INTO `synth_recipes` VALUES (243,0,0,0,0,0,0,0,0,91,0,4096,4238,646,1229,1229,1229,1229,1229,1229,0,655,655,655,655,1,1,1,1,'Adaman Ingot');
INSERT INTO `synth_recipes` VALUES (244,1,0,0,0,0,0,0,0,46,0,4100,4242,17776,0,0,0,0,0,0,0,657,657,852,852,1,1,1,1,'Tama-hagane');
INSERT INTO `synth_recipes` VALUES (245,0,0,0,0,0,0,0,0,15,0,4096,4238,641,641,641,641,0,0,0,0,659,659,659,659,1,1,1,1,'Tin Ingot');
INSERT INTO `synth_recipes` VALUES (246,1,0,0,0,0,0,0,0,58,0,4100,4242,17780,0,0,0,0,0,0,0,659,651,707,852,1,1,1,1,'Tin Ingot');
INSERT INTO `synth_recipes` VALUES (247,1,0,0,0,0,0,0,0,49,0,4100,4242,18366,0,0,0,0,0,0,0,659,715,852,652,1,1,1,5,'Tin Ingot');
INSERT INTO `synth_recipes` VALUES (248,0,1995,0,0,0,0,0,0,4,0,4096,4238,649,649,649,649,649,649,2144,0,660,660,660,660,6,6,6,6,'Bronze Sheet');
INSERT INTO `synth_recipes` VALUES (249,0,0,0,0,0,0,0,0,4,0,4096,4238,649,0,0,0,0,0,0,0,660,660,660,660,1,1,1,1,'Bronze Sheet');
INSERT INTO `synth_recipes` VALUES (250,1,0,0,0,0,0,0,0,51,0,4098,4240,501,0,0,0,0,0,0,0,660,662,666,664,1,1,1,1,'Bronze Sheet');
INSERT INTO `synth_recipes` VALUES (251,1,0,0,0,0,0,0,0,21,0,4098,4240,507,0,0,0,0,0,0,0,660,662,666,666,3,2,1,1,'Bronze Sheet');
INSERT INTO `synth_recipes` VALUES (252,1,0,0,0,0,0,0,0,20,0,4098,4240,508,0,0,0,0,0,0,0,660,662,652,652,1,1,1,1,'Bronze Sheet');
INSERT INTO `synth_recipes` VALUES (253,1,0,0,0,0,0,0,0,53,0,4098,4240,596,0,0,0,0,0,0,0,660,662,662,664,1,1,1,1,'Bronze Sheet');
INSERT INTO `synth_recipes` VALUES (254,1,0,0,0,0,0,0,0,78,0,4098,4240,1118,0,0,0,0,0,0,0,660,664,664,664,2,1,1,1,'Bronze Sheet');
INSERT INTO `synth_recipes` VALUES (255,1,0,0,0,0,0,0,0,81,0,4098,4240,1162,0,0,0,0,0,0,0,660,660,660,660,1,1,1,1,'Bronze Sheet');
INSERT INTO `synth_recipes` VALUES (256,1,0,0,0,0,0,0,50,0,0,4098,4240,2520,0,0,0,0,0,0,0,1629,2529,666,676,1,1,1,1,'Buffalo Leather');
INSERT INTO `synth_recipes` VALUES (257,0,1995,0,0,0,0,11,0,0,0,4096,4238,650,650,650,650,650,650,2144,0,661,661,661,661,6,6,6,6,'Brass Sheet');
INSERT INTO `synth_recipes` VALUES (258,0,0,0,0,0,0,11,0,0,0,4096,4238,650,0,0,0,0,0,0,0,661,661,661,661,1,1,1,1,'Brass Sheet');
INSERT INTO `synth_recipes` VALUES (259,1,0,0,0,0,0,25,0,0,0,4098,4240,1625,0,0,0,0,0,0,0,661,661,661,752,1,1,1,1,'Brass Sheet');
INSERT INTO `synth_recipes` VALUES (260,1,0,0,0,0,0,24,0,0,0,4098,4240,1632,0,0,0,0,0,0,0,661,661,661,661,2,2,2,2,'Brass Sheet');
INSERT INTO `synth_recipes` VALUES (261,0,1995,0,0,0,0,0,0,22,0,4096,4238,651,651,651,651,651,651,2144,0,662,662,662,662,6,6,6,6,'Iron Sheet');
INSERT INTO `synth_recipes` VALUES (262,0,0,0,0,0,0,0,0,22,0,4096,4238,651,0,0,0,0,0,0,0,662,662,662,662,1,1,1,1,'Iron Sheet');
INSERT INTO `synth_recipes` VALUES (263,0,1995,0,0,0,0,41,0,0,0,4096,4238,653,653,653,653,653,653,2144,0,663,663,663,663,6,6,6,6,'Mythril Sheet');
INSERT INTO `synth_recipes` VALUES (264,0,0,0,0,0,0,41,0,0,0,4096,4238,653,0,0,0,0,0,0,0,663,663,663,663,1,1,1,1,'Mythril Sheet');
INSERT INTO `synth_recipes` VALUES (265,0,1995,0,0,0,0,0,0,55,0,4096,4238,654,654,654,654,654,654,2144,0,664,664,664,664,6,6,6,6,'Darksteel Sheet');
INSERT INTO `synth_recipes` VALUES (266,0,0,0,0,0,0,0,0,55,0,4096,4238,654,0,0,0,0,0,0,0,664,664,664,664,1,1,1,1,'Darksteel Sheet');
INSERT INTO `synth_recipes` VALUES (267,0,1995,0,0,0,0,0,0,85,0,4096,4238,655,655,655,655,655,655,2144,0,665,665,665,665,6,6,6,6,'Adaman Sheet');
INSERT INTO `synth_recipes` VALUES (268,0,0,0,0,0,0,0,0,85,0,4096,4238,655,0,0,0,0,0,0,0,665,665,665,665,1,1,1,1,'Adaman Sheet');
INSERT INTO `synth_recipes` VALUES (269,0,1995,0,0,0,0,0,0,36,0,4096,4238,652,652,652,652,652,652,2144,0,666,666,666,666,6,6,6,6,'Steel Sheet');
INSERT INTO `synth_recipes` VALUES (270,0,0,0,0,0,0,0,0,36,0,4096,4238,652,0,0,0,0,0,0,0,666,666,666,666,1,1,1,1,'Steel Sheet');
INSERT INTO `synth_recipes` VALUES (271,0,0,52,0,0,0,0,0,0,0,4102,4244,663,4154,0,0,0,0,0,0,667,667,667,667,1,1,1,1,'Blsd. Mtl. Sheet');
INSERT INTO `synth_recipes` VALUES (272,0,1995,0,0,0,0,90,0,0,0,4096,4238,747,747,747,747,747,747,2144,0,668,668,668,668,6,6,6,6,'Ocl. Sheet'); -- orichalcum sheet (gold 90) https://www.bg-wiki.com/bg/Ocl._Sheet
INSERT INTO `synth_recipes` VALUES (273,0,0,0,0,0,0,90,0,0,0,4096,4238,747,0,0,0,0,0,0,0,668,668,668,668,1,1,1,1,'Ocl. Sheet'); -- orichalcum sheet (gold 90) https://www.bg-wiki.com/bg/Ocl._Sheet
INSERT INTO `synth_recipes` VALUES (274,0,1995,0,0,0,0,0,0,92,0,4096,4238,1711,1711,1711,1711,1711,1711,2144,0,669,669,669,669,6,6,6,6,'Mlbd. Sheet');
INSERT INTO `synth_recipes` VALUES (275,0,0,0,0,0,0,0,0,92,0,4096,4238,1711,0,0,0,0,0,0,0,669,669,669,669,1,1,1,1,'Mlbd. Sheet');
INSERT INTO `synth_recipes` VALUES (276,0,1995,0,0,0,0,50,0,0,0,4096,4238,679,679,679,679,679,679,2144,0,670,670,670,670,6,6,6,6,'Aluminum Sheet');
INSERT INTO `synth_recipes` VALUES (277,0,0,0,0,0,0,50,0,0,0,4096,4238,679,0,0,0,0,0,0,0,670,670,670,670,1,1,1,1,'Aluminum Sheet');
INSERT INTO `synth_recipes` VALUES (278,0,1995,0,0,0,0,22,0,0,0,4096,4238,744,744,744,744,744,744,2144,0,671,671,671,671,6,6,6,6,'Silver Sheet');
INSERT INTO `synth_recipes` VALUES (279,0,0,0,0,0,0,22,0,0,0,4096,4238,744,0,0,0,0,0,0,0,671,671,671,671,1,1,1,1,'Silver Sheet');
INSERT INTO `synth_recipes` VALUES (280,0,0,0,0,0,0,0,0,10,0,4098,4240,660,0,0,0,0,0,0,0,672,672,672,672,1,1,1,1,'Bronze Scales');
INSERT INTO `synth_recipes` VALUES (281,1,0,0,0,0,0,0,0,21,0,4100,4242,15288,0,0,0,0,0,0,0,672,850,850,850,1,4,4,4,'Bronze Scales');
INSERT INTO `synth_recipes` VALUES (282,0,0,0,0,0,0,13,0,0,0,4098,4240,661,0,0,0,0,0,0,0,673,673,673,673,1,1,1,1,'Brass Scales');
INSERT INTO `synth_recipes` VALUES (283,0,0,0,0,0,0,0,0,26,0,4098,4240,662,0,0,0,0,0,0,0,674,674,674,674,1,1,1,1,'Iron Scales');
INSERT INTO `synth_recipes` VALUES (284,0,0,0,0,0,0,0,0,92,0,4098,4240,665,0,0,0,0,0,0,0,675,675,675,675,1,1,1,1,'Adaman Scales');
INSERT INTO `synth_recipes` VALUES (285,0,0,0,0,0,0,0,0,40,0,4098,4240,666,0,0,0,0,0,0,0,676,676,676,676,1,1,1,1,'Steel Scales');
INSERT INTO `synth_recipes` VALUES (286,0,0,0,0,0,0,48,0,0,0,4096,4238,678,678,678,678,0,0,0,0,679,679,679,679,1,1,1,1,'Aluminum Ingot');
INSERT INTO `synth_recipes` VALUES (287,0,1994,0,0,0,0,0,0,30,0,4099,4241,651,651,651,651,651,651,2143,0,680,680,680,680,3,6,9,12,'Iron Chain');
INSERT INTO `synth_recipes` VALUES (288,0,0,0,0,0,0,0,0,30,0,4099,4241,651,651,0,0,0,0,0,0,680,680,680,680,1,2,3,4,'Iron Chain');
INSERT INTO `synth_recipes` VALUES (289,0,1994,0,0,0,0,43,0,0,0,4099,4241,653,653,653,653,653,653,2143,0,681,681,681,681,3,6,9,12,'Mythril Chain');
INSERT INTO `synth_recipes` VALUES (290,0,0,0,0,0,0,43,0,0,0,4099,4241,653,653,0,0,0,0,0,0,681,681,681,681,1,2,3,4,'Mythril Chain');
INSERT INTO `synth_recipes` VALUES (291,0,1994,0,0,0,0,0,0,63,0,4099,4241,654,654,654,654,654,654,2143,0,682,682,682,682,3,6,9,12,'Darksteel Chain');
INSERT INTO `synth_recipes` VALUES (292,0,0,0,0,0,0,0,0,63,0,4099,4241,654,654,0,0,0,0,0,0,682,682,682,682,1,2,3,4,'Darksteel Chain');
INSERT INTO `synth_recipes` VALUES (293,0,1994,0,0,0,0,0,0,94,0,4099,4238,655,655,655,655,655,655,2143,0,683,683,683,683,3,6,9,12,'Adaman Chain');
INSERT INTO `synth_recipes` VALUES (294,0,0,0,0,0,0,0,0,94,0,4099,4241,655,655,0,0,0,0,0,0,683,683,683,683,1,2,3,4,'Adaman Chain');
INSERT INTO `synth_recipes` VALUES (295,0,1994,0,0,0,0,58,0,0,0,4099,4241,679,679,679,679,679,679,2143,0,684,684,684,684,3,6,9,12,'Aluminum Chain');
INSERT INTO `synth_recipes` VALUES (296,0,0,0,0,0,0,58,0,0,0,4099,4241,679,679,0,0,0,0,0,0,684,684,684,684,1,2,3,4,'Aluminum Chain');
INSERT INTO `synth_recipes` VALUES (297,0,0,0,0,0,0,0,0,99,0,4096,4238,643,685,685,1469,0,0,0,0,686,686,686,686,1,1,1,1,'Im. Wootz Ingot');
INSERT INTO `synth_recipes` VALUES (298,0,1986,0,0,0,0,0,0,0,2,4098,4240,688,688,688,1657,0,0,0,0,705,705,705,705,3,6,9,12,'Arrowwood Lbr.');
INSERT INTO `synth_recipes` VALUES (299,0,0,0,0,0,0,0,0,0,2,4098,4240,688,0,0,0,0,0,0,0,705,705,705,705,1,2,3,4,'Arrowwood Lbr.');
INSERT INTO `synth_recipes` VALUES (300,0,1986,0,0,0,0,0,0,0,3,4098,4240,689,689,689,1657,0,0,0,0,706,706,706,706,3,6,9,12,'Lauan Lumber');
INSERT INTO `synth_recipes` VALUES (301,0,0,0,0,0,0,0,0,0,3,4098,4240,689,0,0,0,0,0,0,0,706,706,706,706,1,2,3,4,'Lauan Lumber');
INSERT INTO `synth_recipes` VALUES (302,1,0,0,0,0,0,0,0,0,7,4100,4242,12289,0,0,0,0,0,0,0,706,706,706,706,1,2,2,2,'Lauan Lumber');
INSERT INTO `synth_recipes` VALUES (303,1,0,0,0,12,0,0,0,0,0,4100,4242,12712,0,0,0,0,0,0,0,706,817,817,817,1,2,5,6,'Lauan Lumber');
INSERT INTO `synth_recipes` VALUES (304,1,0,0,0,22,0,0,0,0,0,4100,4242,12713,0,0,0,0,0,0,0,706,817,818,818,1,1,5,6,'Lauan Lumber');
INSERT INTO `synth_recipes` VALUES (305,1,0,0,0,0,0,0,0,17,0,4100,4242,16667,0,0,0,0,0,0,0,706,649,649,806,1,1,2,1,'Lauan Lumber');
INSERT INTO `synth_recipes` VALUES (306,0,1986,0,0,0,0,0,0,0,25,4098,4240,690,690,690,1657,0,0,0,0,707,707,707,707,3,6,9,12,'Elm Lumber');
INSERT INTO `synth_recipes` VALUES (307,0,0,0,0,0,0,0,0,0,25,4098,4240,690,0,0,0,0,0,0,0,707,707,707,707,1,2,3,4,'Elm Lumber');
INSERT INTO `synth_recipes` VALUES (308,1,0,0,0,0,0,0,0,21,0,4100,4242,16466,0,0,0,0,0,0,0,707,707,651,651,1,1,1,1,'Elm Lumber');
INSERT INTO `synth_recipes` VALUES (309,1,0,0,0,0,0,0,0,47,0,4100,4242,16651,0,0,0,0,0,0,0,707,707,1226,1226,1,1,4,6,'Elm Lumber');
INSERT INTO `synth_recipes` VALUES (310,1,0,0,0,0,0,0,0,34,0,4100,4242,17044,0,0,0,0,0,0,0,707,707,651,651,1,1,1,2,'Elm Lumber');
INSERT INTO `synth_recipes` VALUES (311,1,0,0,0,0,0,0,0,0,29,4100,4242,17090,0,0,0,0,0,0,0,707,707,707,895,1,1,1,1,'Elm Lumber');
INSERT INTO `synth_recipes` VALUES (312,1,0,0,0,0,0,0,0,0,46,4100,4242,17097,0,0,0,0,0,0,0,707,707,707,707,1,1,2,2,'Elm Lumber');
INSERT INTO `synth_recipes` VALUES (313,1,0,0,0,0,0,0,0,0,25,4100,4242,17116,0,0,0,0,0,0,0,707,707,637,793,1,1,1,1,'Elm Lumber');
INSERT INTO `synth_recipes` VALUES (314,1,0,0,0,0,0,0,0,0,56,4100,4242,17388,0,0,0,0,0,0,0,707,707,820,820,1,1,1,1,'Elm Lumber');
INSERT INTO `synth_recipes` VALUES (315,0,1986,0,0,0,0,0,0,0,5,4098,4240,691,691,691,1657,0,0,0,0,708,708,708,708,3,6,9,12,'Maple Lumber');
INSERT INTO `synth_recipes` VALUES (316,0,0,0,0,0,0,0,0,0,5,4098,4240,691,0,0,0,0,0,0,0,708,708,708,708,1,2,3,4,'Maple Lumber');
INSERT INTO `synth_recipes` VALUES (317,1,0,0,0,0,0,0,0,0,11,4100,4242,12290,0,0,0,0,0,0,0,708,650,708,708,1,1,2,2,'Maple Lumber');
INSERT INTO `synth_recipes` VALUES (318,1,0,0,0,0,0,0,0,0,5,4100,4242,12316,0,0,0,0,0,0,0,708,650,807,809,1,1,1,1,'Maple Lumber'); -- maple lumber desynth https://www.bg-wiki.com/bg/Maple_Lumber
INSERT INTO `synth_recipes` VALUES (319,1,0,0,0,0,0,0,0,23,0,4100,4242,16704,0,0,0,0,0,0,0,708,649,649,651,1,1,2,1,'Maple Lumber');
INSERT INTO `synth_recipes` VALUES (320,1,0,0,0,0,0,0,0,0,6,4100,4242,17049,0,0,0,0,0,0,0,708,708,840,840,1,1,1,1,'Maple Lumber');
INSERT INTO `synth_recipes` VALUES (321,1,0,0,0,0,0,0,0,0,23,4100,4242,17353,0,0,0,0,0,0,0,708,927,927,927,1,1,2,2,'Maple Lumber');
INSERT INTO `synth_recipes` VALUES (322,0,1986,0,0,0,0,0,0,0,28,4098,4240,694,694,694,1657,0,0,0,0,710,710,710,710,3,6,9,12,'Chestnut Lumber');
INSERT INTO `synth_recipes` VALUES (323,0,0,0,0,0,0,0,0,0,28,4098,4240,694,0,0,0,0,0,0,0,710,710,710,710,1,2,3,4,'Chestnut Lumber');
INSERT INTO `synth_recipes` VALUES (324,1,0,0,0,0,0,0,0,44,0,4100,4242,16393,0,0,0,0,0,0,0,710,652,1226,1226,1,1,6,6,'Chestnut Lumber');
INSERT INTO `synth_recipes` VALUES (325,1,0,0,0,0,0,0,0,0,27,4100,4242,17029,0,0,0,0,0,0,0,710,710,710,710,1,1,1,1,'Chestnut Lumber');
INSERT INTO `synth_recipes` VALUES (326,1,0,0,0,0,0,0,0,0,32,4100,4242,17052,0,0,0,0,0,0,0,710,710,847,847,1,1,1,1,'Chestnut Lumber');
INSERT INTO `synth_recipes` VALUES (327,0,1986,0,0,0,0,0,0,0,19,4098,4240,693,693,693,1657,0,0,0,0,711,711,711,711,3,6,9,12,'Walnut Lumber');
INSERT INTO `synth_recipes` VALUES (328,0,0,0,0,0,0,0,0,0,19,4098,4240,693,0,0,0,0,0,0,0,711,711,711,711,1,2,3,4,'Walnut Lumber');
INSERT INTO `synth_recipes` VALUES (329,1,0,0,0,0,0,0,0,0,94,4100,4242,17102,0,0,0,0,0,0,0,711,711,711,1226,1,1,2,6,'Walnut Lumber');
INSERT INTO `synth_recipes` VALUES (330,1,0,0,0,0,0,0,0,0,85,4100,4242,17543,0,0,0,0,0,0,0,711,711,711,1235,1,1,2,4,'Walnut Lumber');
INSERT INTO `synth_recipes` VALUES (331,1,0,0,0,0,0,0,0,0,100,4100,4242,17569,0,0,0,0,0,0,0,711,711,711,1229,1,1,2,6,'Walnut Lumber');
INSERT INTO `synth_recipes` VALUES (332,1,0,0,0,0,0,0,0,0,100,4100,4242,17596,0,0,0,0,0,0,0,711,711,711,1229,1,2,2,6,'Walnut Lumber');
INSERT INTO `synth_recipes` VALUES (333,0,1986,0,0,0,0,0,0,0,13,4098,4240,695,695,695,1657,0,0,0,0,712,712,712,712,3,6,9,12,'Willow Lumber');
INSERT INTO `synth_recipes` VALUES (334,0,0,0,0,0,0,0,0,0,13,4098,4240,695,0,0,0,0,0,0,0,712,712,712,712,1,2,3,4,'Willow Lumber');
INSERT INTO `synth_recipes` VALUES (335,1,0,0,0,0,0,0,0,0,14,4100,4242,17050,0,0,0,0,0,0,0,712,712,712,846,1,1,1,1,'Willow Lumber');
INSERT INTO `synth_recipes` VALUES (336,1,0,0,0,0,0,0,0,0,27,4100,4242,17076,0,0,0,0,0,0,0,712,712,712,712,1,1,1,1,'Willow Lumber');
INSERT INTO `synth_recipes` VALUES (337,1,0,0,0,0,0,0,0,0,16,4100,4242,17153,0,0,0,0,0,0,0,712,712,712,712,1,1,1,1,'Willow Lumber');
INSERT INTO `synth_recipes` VALUES (338,1,0,0,0,0,0,0,0,0,99,4100,4242,17170,0,0,0,0,0,0,0,712,816,816,816,1,3,3,3,'Willow Lumber');
INSERT INTO `synth_recipes` VALUES (339,0,1986,0,0,0,0,0,0,0,22,4098,4240,696,696,696,1657,0,0,0,0,713,713,713,713,3,6,9,12,'Yew Lumber');
INSERT INTO `synth_recipes` VALUES (340,0,0,0,0,0,0,0,0,0,22,4098,4240,696,0,0,0,0,0,0,0,713,713,713,713,1,2,3,4,'Yew Lumber');
INSERT INTO `synth_recipes` VALUES (341,1,0,0,0,0,0,0,0,93,0,4100,4242,16777,0,0,0,0,0,0,0,713,652,654,654,1,1,1,2,'Yew Lumber');
INSERT INTO `synth_recipes` VALUES (342,1,0,0,0,0,0,0,0,78,0,4100,4242,16789,0,0,0,0,0,0,0,713,817,654,654,1,1,1,1,'Yew Lumber');
INSERT INTO `synth_recipes` VALUES (343,1,0,0,0,0,0,0,0,0,17,4100,4242,17160,0,0,0,0,0,0,0,713,819,927,895,2,3,1,1,'Yew Lumber');
INSERT INTO `synth_recipes` VALUES (344,1,0,0,0,0,0,0,0,0,24,4100,4242,17390,0,0,0,0,0,0,0,713,713,819,819,1,1,1,1,'Yew Lumber');
INSERT INTO `synth_recipes` VALUES (345,0,1986,0,0,0,0,0,0,0,12,4098,4240,697,697,697,1657,0,0,0,0,714,714,714,714,3,6,9,12,'Holly Lumber');
INSERT INTO `synth_recipes` VALUES (346,0,0,0,0,0,0,0,0,0,12,4098,4240,697,0,0,0,0,0,0,0,714,714,714,714,1,2,3,4,'Holly Lumber');
INSERT INTO `synth_recipes` VALUES (347,1,0,0,0,0,0,0,0,35,0,4100,4242,12300,0,0,0,0,0,0,0,714,714,651,651,1,2,1,2,'Holly Lumber'); -- targe desynth (smith 35) https://www.bg-wiki.com/bg/Targe
INSERT INTO `synth_recipes` VALUES (348,1,0,0,0,0,0,0,0,21,0,4100,4242,16392,0,0,0,0,0,0,0,714,651,651,651,1,2,2,2,'Holly Lumber');
INSERT INTO `synth_recipes` VALUES (349,1,0,0,0,0,0,0,0,0,19,4100,4242,17089,0,0,0,0,0,0,0,714,714,714,882,1,1,2,1,'Holly Lumber');
INSERT INTO `synth_recipes` VALUES (350,1,0,0,0,0,0,0,0,0,89,4100,4242,17117,0,0,0,0,0,0,0,714,714,714,788,1,1,1,1,'Holly Lumber');
INSERT INTO `synth_recipes` VALUES (351,1,0,0,0,0,0,0,0,0,79,4100,4242,17293,0,0,0,0,0,0,0,714,714,714,714,1,1,1,1,'Holly Lumber');
INSERT INTO `synth_recipes` VALUES (352,0,1986,0,0,0,0,0,0,0,8,4098,4240,698,698,698,1657,0,0,0,0,715,715,715,715,3,6,9,12,'Ash Lumber');
INSERT INTO `synth_recipes` VALUES (353,0,0,0,0,0,0,0,0,0,8,4098,4240,698,0,0,0,0,0,0,0,715,715,715,715,1,2,3,4,'Ash Lumber');
INSERT INTO `synth_recipes` VALUES (354,1,0,0,0,0,0,0,0,18,0,4100,4242,12299,0,0,0,0,0,0,0,715,649,649,649,1,1,2,3,'Ash Lumber');
INSERT INTO `synth_recipes` VALUES (355,1,0,0,0,0,0,56,0,0,0,4100,4242,12307,0,0,0,0,0,0,0,715,651,1228,1228,2,2,6,6,'Ash Lumber');
INSERT INTO `synth_recipes` VALUES (356,1,0,0,0,0,0,0,0,0,11,4100,4242,12984,0,0,0,0,0,0,0,715,715,850,850,1,1,1,1,'Ash Lumber');
INSERT INTO `synth_recipes` VALUES (357,1,0,0,0,0,0,0,3,0,0,4100,4242,16385,0,0,0,0,0,0,0,715,850,850,850,1,1,2,2,'Ash Lumber');
INSERT INTO `synth_recipes` VALUES (358,1,0,0,0,0,0,0,17,0,0,4100,4242,16386,0,0,0,0,0,0,0,715,852,852,850,1,1,1,2,'Ash Lumber');
INSERT INTO `synth_recipes` VALUES (359,1,0,0,0,0,0,0,52,0,0,4100,4242,16388,0,0,0,0,0,0,0,715,850,852,853,1,2,1,1,'Ash Lumber');
INSERT INTO `synth_recipes` VALUES (360,1,0,34,0,0,0,0,0,0,0,4100,4242,16471,0,0,0,0,0,0,0,715,937,649,4163,1,1,1,1,'Ash Lumber');
INSERT INTO `synth_recipes` VALUES (361,1,0,0,0,0,0,0,0,32,0,4100,4242,16583,0,0,0,0,0,0,0,715,852,651,652,1,1,3,4,'Ash Lumber');
INSERT INTO `synth_recipes` VALUES (362,1,0,0,0,0,0,0,0,42,0,4100,4242,16589,0,0,0,0,0,0,0,715,852,651,651,1,1,4,5,'Ash Lumber');
INSERT INTO `synth_recipes` VALUES (363,1,0,0,0,0,0,0,0,7,0,4100,4242,16640,0,0,0,0,0,0,0,715,715,715,715,1,1,1,1,'Ash Lumber');
INSERT INTO `synth_recipes` VALUES (364,1,0,0,0,0,0,12,0,0,0,4100,4242,16641,0,0,0,0,0,0,0,715,649,649,650,1,1,2,1,'Ash Lumber');
INSERT INTO `synth_recipes` VALUES (365,1,0,0,23,0,0,0,0,0,0,4100,4242,16649,0,0,0,0,0,0,0,715,715,893,893,1,1,1,1,'Ash Lumber');
INSERT INTO `synth_recipes` VALUES (366,1,0,0,0,0,0,0,0,38,0,4100,4242,16650,0,0,0,0,0,0,0,715,715,652,652,1,1,1,1,'Ash Lumber');
INSERT INTO `synth_recipes` VALUES (367,1,0,0,0,0,0,0,0,0,18,4100,4242,16833,0,0,0,0,0,0,0,715,817,649,649,1,1,1,1,'Ash Lumber');
INSERT INTO `synth_recipes` VALUES (368,1,0,0,0,0,0,0,0,0,14,4100,4242,16837,0,0,0,0,0,0,0,715,811,1226,816,1,1,6,1,'Ash Lumber');
INSERT INTO `synth_recipes` VALUES (369,1,0,0,0,0,0,0,0,0,67,4100,4242,16839,0,0,0,0,0,0,0,715,822,1228,1228,1,1,4,6,'Ash Lumber');
INSERT INTO `synth_recipes` VALUES (370,1,0,0,0,0,0,82,0,0,0,4100,4242,16842,0,0,0,0,0,0,0,715,822,1228,745,1,1,6,1,'Ash Lumber');
INSERT INTO `synth_recipes` VALUES (371,1,0,0,0,0,0,0,0,0,45,4100,4242,16867,0,0,0,0,0,0,0,715,817,884,884,1,1,1,1,'Ash Lumber');
INSERT INTO `synth_recipes` VALUES (372,1,0,0,0,0,0,0,0,0,9,4100,4242,17024,0,0,0,0,0,0,0,715,715,715,715,1,1,1,1,'Ash Lumber');
INSERT INTO `synth_recipes` VALUES (373,1,0,0,0,0,0,0,0,0,10,4100,4242,17088,0,0,0,0,0,0,0,715,715,891,891,1,1,1,1,'Ash Lumber');
INSERT INTO `synth_recipes` VALUES (374,1,0,0,0,0,0,0,0,0,8,4100,4242,17095,0,0,0,0,0,0,0,715,715,715,715,1,1,2,2,'Ash Lumber');
INSERT INTO `synth_recipes` VALUES (375,1,0,0,0,0,0,0,0,0,8,4100,4242,17104,0,0,0,0,0,0,0,715,715,715,715,1,1,1,1,'Ash Lumber'); -- onion staff desynth to ash lumber (wood 8) http://ffxiclopedia.wikia.com/wiki/Ash_Lumber
INSERT INTO `synth_recipes` VALUES (376,1,0,0,0,0,0,0,0,0,51,4100,4242,17134,0,0,0,0,0,0,0,715,715,715,715,1,1,1,1,'Ash Lumber');
INSERT INTO `synth_recipes` VALUES (377,1,0,0,0,0,0,0,0,0,55,4100,4242,17292,0,0,0,0,0,0,0,715,718,819,819,1,1,1,1,'Ash Lumber');
INSERT INTO `synth_recipes` VALUES (378,0,1986,0,0,0,0,0,0,0,35,4098,4240,699,699,699,1657,0,0,0,0,716,716,716,716,3,6,9,12,'Oak Lumber');
INSERT INTO `synth_recipes` VALUES (379,0,0,0,0,0,0,0,0,0,35,4098,4240,699,0,0,0,0,0,0,0,716,716,716,716,1,2,3,4,'Oak Lumber');
INSERT INTO `synth_recipes` VALUES (380,1,0,0,0,0,0,0,0,0,50,4100,4242,12406,0,0,0,0,0,0,0,716,716,716,716,1,1,1,1,'Oak Lumber');
INSERT INTO `synth_recipes` VALUES (381,1,0,0,0,0,0,0,0,41,0,4100,4242,16706,0,0,0,0,0,0,0,716,652,652,652,1,2,2,2,'Oak Lumber');
INSERT INTO `synth_recipes` VALUES (382,1,0,0,0,0,0,0,0,0,41,4100,4242,17027,0,0,0,0,0,0,0,716,716,716,716,1,1,1,1,'Oak Lumber');
INSERT INTO `synth_recipes` VALUES (383,1,0,0,0,0,0,0,0,0,44,4100,4242,17040,0,0,0,0,0,0,0,716,716,716,716,1,1,1,1,'Oak Lumber');
INSERT INTO `synth_recipes` VALUES (384,1,0,0,0,0,0,0,0,46,0,4100,4242,17045,0,0,0,0,0,0,0,716,716,1226,653,1,1,6,2,'Oak Lumber');
INSERT INTO `synth_recipes` VALUES (385,0,1986,0,0,0,0,0,0,0,51,4098,4240,700,700,700,1657,0,0,0,0,717,717,717,717,3,6,9,12,'Mahogany Lbr.');
INSERT INTO `synth_recipes` VALUES (386,0,0,0,0,0,0,0,0,0,51,4098,4240,700,0,0,0,0,0,0,0,717,717,717,717,1,2,3,4,'Mahogany Lbr.');
INSERT INTO `synth_recipes` VALUES (387,1,0,0,0,0,0,0,0,0,34,4100,4242,12292,0,0,0,0,0,0,0,717,717,651,651,1,2,1,1,'Mahogany Lbr.');
INSERT INTO `synth_recipes` VALUES (388,1,0,0,0,0,0,0,0,91,0,4100,4242,16470,0,0,0,0,0,0,0,717,655,655,655,1,1,1,1,'Mahogany Lbr.');
INSERT INTO `synth_recipes` VALUES (389,1,0,0,0,0,0,0,0,53,0,4100,4242,16721,0,0,0,0,0,0,0,717,652,652,652,1,2,3,3,'Mahogany Lbr.');
INSERT INTO `synth_recipes` VALUES (390,1,0,0,0,0,0,0,0,0,68,4100,4242,17099,0,0,0,0,0,0,0,717,717,717,717,1,1,2,2,'Mahogany Lbr.');
INSERT INTO `synth_recipes` VALUES (391,1,0,0,0,0,0,0,0,0,80,4100,4242,17415,0,0,0,0,0,0,0,717,1226,1226,1226,1,4,6,6,'Mahogany Lbr.');
INSERT INTO `synth_recipes` VALUES (392,1,0,0,84,0,0,0,0,0,0,4100,4242,17628,0,0,0,0,0,0,0,717,717,717,883,1,1,1,1,'Mahogany Lbr.');
INSERT INTO `synth_recipes` VALUES (393,1,0,0,0,0,0,0,0,0,63,4100,4242,17378,0,0,0,0,0,0,0,917,917,718,718,1,1,1,1,'Parchment');
INSERT INTO `synth_recipes` VALUES (394,0,1986,0,0,0,0,0,0,0,45,4098,4240,701,701,701,1657,0,0,0,0,718,718,718,718,3,6,9,12,'Rosewood Lbr.');
INSERT INTO `synth_recipes` VALUES (395,0,0,0,0,0,0,0,0,0,45,4098,4240,701,0,0,0,0,0,0,0,718,718,718,718,1,2,3,4,'Rosewood Lbr.');
INSERT INTO `synth_recipes` VALUES (396,1,0,0,0,0,0,0,0,0,74,4100,4242,17014,0,0,0,0,0,0,0,718,822,822,822,1,1,1,1,'Rosewood Lbr.');
INSERT INTO `synth_recipes` VALUES (397,1,0,0,0,0,0,0,0,0,47,4100,4242,17053,0,0,0,0,0,0,0,718,845,845,845,1,1,1,1,'Rosewood Lbr.');
INSERT INTO `synth_recipes` VALUES (398,1,0,0,0,0,0,0,0,0,88,4100,4242,17221,0,0,0,0,0,0,0,718,927,927,654,1,1,1,1,'Rosewood Lbr.');
INSERT INTO `synth_recipes` VALUES (399,0,1986,0,0,0,0,0,0,0,61,4098,4240,702,702,702,1657,0,0,0,0,719,719,719,719,3,6,9,12,'Ebony Lumber');
INSERT INTO `synth_recipes` VALUES (400,0,0,0,0,0,0,0,0,0,61,4098,4240,702,0,0,0,0,0,0,0,719,719,719,719,1,2,3,4,'Ebony Lumber');
INSERT INTO `synth_recipes` VALUES (401,1,0,0,0,0,0,0,0,0,79,4100,4242,17100,0,0,0,0,0,0,0,719,719,719,719,1,1,2,2,'Ebony Lumber');
INSERT INTO `synth_recipes` VALUES (402,0,1986,0,0,0,0,0,0,0,72,4098,4240,703,703,703,1657,0,0,0,0,720,720,720,720,3,6,9,12,'Ancient Lumber');
INSERT INTO `synth_recipes` VALUES (403,0,0,0,0,0,0,0,0,0,72,4098,4240,703,0,0,0,0,0,0,0,720,720,720,720,1,2,3,4,'Ancient Lumber');
INSERT INTO `synth_recipes` VALUES (404,1,0,0,0,0,0,0,0,0,84,4100,4242,17056,0,0,0,0,0,0,0,720,720,844,844,1,1,1,1,'Ancient Lumber');
INSERT INTO `synth_recipes` VALUES (405,1,0,0,0,0,0,0,0,0,89,4100,4242,17101,0,0,0,0,0,0,0,720,720,720,720,1,2,2,2,'Ancient Lumber');
INSERT INTO `synth_recipes` VALUES (406,0,1986,0,0,0,0,0,0,0,92,4098,4240,722,722,722,1657,0,0,0,0,723,723,723,723,3,6,9,12,'Divine Lumber');
INSERT INTO `synth_recipes` VALUES (407,0,0,0,0,0,0,0,0,0,92,4098,4240,722,0,0,0,0,0,0,0,723,723,723,723,1,2,3,4,'Divine Lumber');
INSERT INTO `synth_recipes` VALUES (408,0,1985,0,0,0,0,0,0,0,19,4098,4240,693,1644,1644,1648,0,0,0,0,726,726,726,726,3,6,9,12,'Stl. Wal. Lumber');
INSERT INTO `synth_recipes` VALUES (409,0,1986,0,0,0,0,0,0,0,31,4098,4240,727,727,727,1657,0,0,0,0,728,728,728,728,3,6,9,12,'Dogwd. Lumber');
INSERT INTO `synth_recipes` VALUES (410,0,0,0,0,0,0,0,0,0,31,4098,4240,727,0,0,0,0,0,0,0,728,728,728,728,1,2,3,4,'Dogwd. Lumber');
INSERT INTO `synth_recipes` VALUES (411,0,1986,0,0,0,0,0,0,0,95,4098,4240,729,729,729,1657,0,0,0,0,730,730,730,730,3,6,9,12,'Bldwd. Lumber');
INSERT INTO `synth_recipes` VALUES (412,0,0,0,0,0,0,0,0,0,95,4098,4240,729,0,0,0,0,0,0,0,730,730,730,730,1,2,3,4,'Bldwd. Lumber');
INSERT INTO `synth_recipes` VALUES (413,1,0,0,0,0,0,0,0,0,75,4098,4240,2336,0,0,0,0,0,0,0,730,730,804,804,1,1,1,1,'Bldwd. Lumber');
INSERT INTO `synth_recipes` VALUES (414,0,0,0,0,0,0,20,0,0,0,4096,4238,736,736,736,736,0,0,0,0,744,744,744,744,1,1,1,1,'Silver Ingot');
INSERT INTO `synth_recipes` VALUES (415,0,0,0,0,0,0,21,0,0,0,4096,4238,736,1233,1233,1233,1233,1233,1233,0,744,744,744,744,1,1,1,1,'Silver Ingot');
INSERT INTO `synth_recipes` VALUES (416,0,0,0,0,0,0,18,0,0,0,4096,4238,750,750,750,750,0,0,0,0,744,744,744,744,1,1,1,1,'Silver Ingot');
INSERT INTO `synth_recipes` VALUES (417,1,0,0,0,0,0,27,0,0,0,4100,4242,12495,0,0,0,0,0,0,0,744,744,744,744,1,1,1,1,'Silver Ingot');
INSERT INTO `synth_recipes` VALUES (418,1,0,0,0,0,0,40,0,0,0,4100,4242,12681,0,0,0,0,0,0,0,744,651,651,651,1,3,3,3,'Silver Ingot');
INSERT INTO `synth_recipes` VALUES (419,1,0,0,0,0,0,44,0,0,0,4100,4242,12809,0,0,0,0,0,0,0,744,819,851,651,2,3,2,4,'Silver Ingot');
INSERT INTO `synth_recipes` VALUES (420,1,0,0,0,0,0,42,0,0,0,4100,4242,12937,0,0,0,0,0,0,0,744,914,851,651,1,1,1,3,'Silver Ingot');
INSERT INTO `synth_recipes` VALUES (421,1,0,0,0,0,0,37,0,0,0,4100,4242,13082,0,0,0,0,0,0,0,744,744,744,744,3,4,5,5,'Silver Ingot');
INSERT INTO `synth_recipes` VALUES (422,1,0,0,0,0,0,39,0,0,0,4100,4242,13083,0,0,0,0,0,0,0,744,744,744,744,2,4,4,4,'Silver Ingot');
INSERT INTO `synth_recipes` VALUES (423,1,0,0,0,0,0,34,0,0,0,4100,4242,13209,0,0,0,0,0,0,0,744,744,744,744,4,5,6,6,'Silver Ingot');
INSERT INTO `synth_recipes` VALUES (424,1,0,0,0,0,0,34,0,0,0,4100,4242,13213,0,0,0,0,0,0,0,744,744,744,744,4,5,6,6,'Silver Ingot');
INSERT INTO `synth_recipes` VALUES (425,1,0,0,83,0,0,0,0,0,0,4100,4242,13312,0,0,0,0,0,0,0,744,744,887,887,1,1,1,1,'Silver Ingot');
INSERT INTO `synth_recipes` VALUES (426,1,0,0,61,0,0,0,0,0,0,4100,4242,13325,0,0,0,0,0,0,0,744,744,884,884,1,2,1,2,'Silver Ingot');
INSERT INTO `synth_recipes` VALUES (427,1,0,0,0,0,0,22,0,0,0,4100,4242,13327,0,0,0,0,0,0,0,744,744,744,744,1,1,2,2,'Silver Ingot');
INSERT INTO `synth_recipes` VALUES (428,1,0,0,0,0,0,32,0,0,0,4100,4242,13456,0,0,0,0,0,0,0,744,744,744,744,1,1,2,2,'Silver Ingot');
INSERT INTO `synth_recipes` VALUES (429,1,0,0,0,0,0,68,0,0,0,4100,4242,13515,0,0,0,0,0,0,0,744,744,745,745,1,1,1,1,'Silver Ingot');
INSERT INTO `synth_recipes` VALUES (430,1,0,0,0,0,0,98,0,0,0,4100,4242,13840,0,0,0,0,0,0,0,744,744,744,744,1,1,1,1,'Silver Ingot');
INSERT INTO `synth_recipes` VALUES (431,1,0,0,0,0,0,49,0,0,0,4100,4242,13979,0,0,0,0,0,0,0,744,744,744,744,1,1,2,3,'Silver Ingot');
INSERT INTO `synth_recipes` VALUES (432,1,0,0,0,0,0,52,0,0,0,4100,4242,14864,0,0,0,0,0,0,0,744,744,744,744,1,1,2,3,'Silver Ingot');
INSERT INTO `synth_recipes` VALUES (433,1,0,0,0,0,0,0,0,28,0,4100,4242,16512,0,0,0,0,0,0,0,744,744,651,651,1,1,1,1,'Silver Ingot');
INSERT INTO `synth_recipes` VALUES (434,1,0,0,0,0,0,69,0,0,0,4100,4242,16514,0,0,0,0,0,0,0,744,744,651,745,1,1,1,1,'Silver Ingot');
INSERT INTO `synth_recipes` VALUES (435,1,0,0,0,0,0,0,0,39,0,4100,4242,16524,0,0,0,0,0,0,0,744,744,744,744,1,1,1,1,'Silver Ingot');
INSERT INTO `synth_recipes` VALUES (436,1,0,0,0,0,0,0,0,11,0,4100,4242,16575,0,0,0,0,0,0,0,744,1226,654,654,1,6,1,1,'Silver Ingot');
INSERT INTO `synth_recipes` VALUES (437,0,0,0,0,0,0,53,0,0,0,4096,4238,737,737,737,737,0,0,0,0,745,745,745,745,1,1,1,1,'Gold Ingot');
INSERT INTO `synth_recipes` VALUES (438,0,0,0,0,0,0,54,0,0,0,4096,4238,737,1225,1225,1225,1225,1225,1225,0,745,745,745,745,1,1,1,1,'Gold Ingot');
INSERT INTO `synth_recipes` VALUES (439,0,0,0,0,0,0,51,0,0,0,4096,4238,748,748,748,748,0,0,0,0,745,745,745,745,1,1,1,1,'Gold Ingot');
INSERT INTO `synth_recipes` VALUES (440,1,0,0,0,0,0,52,0,0,0,4100,4242,554,0,0,0,0,0,0,0,745,745,745,745,1,1,1,1,'Gold Ingot');
INSERT INTO `synth_recipes` VALUES (441,1,0,0,0,0,0,58,0,0,0,4100,4242,12494,0,0,0,0,0,0,0,745,745,745,745,1,1,1,1,'Gold Ingot');
INSERT INTO `synth_recipes` VALUES (442,0,0,0,0,0,0,0,0,0,1,4099,4241,3553,3554,3555,0,0,0,0,0,3653,3653,3653,3653,1,1,1,1,'Banquet Table'); -- banquet table
INSERT INTO `synth_recipes` VALUES (443,1,0,0,0,0,0,99,0,0,0,4100,4242,16520,0,0,0,0,0,0,0,745,746,804,804,1,1,1,1,'Gold Ingot');
INSERT INTO `synth_recipes` VALUES (444,0,0,0,0,0,0,63,0,0,0,4096,4238,738,738,738,738,0,0,0,0,746,746,746,746,1,1,1,1,'Platinum Ingot');
INSERT INTO `synth_recipes` VALUES (445,0,0,0,0,0,0,64,0,0,0,4096,4238,738,1227,1227,1227,1227,1227,1227,0,746,746,746,746,1,1,1,1,'Platinum Ingot');
INSERT INTO `synth_recipes` VALUES (446,0,0,0,0,0,0,61,0,0,0,4096,4238,751,751,751,751,0,0,0,0,746,746,746,746,1,1,1,1,'Platinum Ingot');
INSERT INTO `synth_recipes` VALUES (447,1,0,0,0,0,0,68,0,0,0,4100,4242,13316,0,0,0,0,0,0,0,746,746,746,746,1,1,1,1,'Platinum Ingot');
INSERT INTO `synth_recipes` VALUES (448,1,0,0,0,0,0,85,0,0,0,4100,4242,13352,0,0,0,0,0,0,0,746,786,786,786,1,1,1,2,'Platinum Ingot');
INSERT INTO `synth_recipes` VALUES (449,1,0,0,0,0,0,70,0,0,0,4100,4242,13447,0,0,0,0,0,0,0,746,746,746,746,1,1,1,2,'Platinum Ingot');
INSERT INTO `synth_recipes` VALUES (450,0,0,0,0,0,0,89,0,0,0,4096,4238,738,739,739,739,0,0,0,0,747,747,747,747,1,1,1,1,'Ocl. Ingot');
INSERT INTO `synth_recipes` VALUES (451,0,1995,0,0,0,0,54,0,0,0,4096,4238,745,745,745,745,745,745,2144,0,752,752,752,752,6,6,6,6,'Gold Sheet');
INSERT INTO `synth_recipes` VALUES (452,0,0,0,0,0,0,54,0,0,0,4096,4238,745,0,0,0,0,0,0,0,752,752,752,752,1,1,1,1,'Gold Sheet');
INSERT INTO `synth_recipes` VALUES (453,0,1995,0,0,0,0,64,0,0,0,4096,4238,746,746,746,746,746,746,2144,0,754,754,754,754,6,6,6,6,'Platinum Sheet');
INSERT INTO `synth_recipes` VALUES (454,0,0,0,0,0,0,64,0,0,0,4096,4238,746,0,0,0,0,0,0,0,754,754,754,754,1,1,1,1,'Platinum Sheet');
INSERT INTO `synth_recipes` VALUES (455,1,0,0,0,0,0,22,0,0,0,4098,4240,1614,0,0,0,0,0,0,0,760,814,815,801,1,1,1,1,'Silver Chain');
INSERT INTO `synth_recipes` VALUES (456,0,1994,0,0,0,0,33,0,0,0,4099,4241,744,744,744,744,744,744,2143,0,760,760,760,760,3,6,9,12,'Silver Chain');
INSERT INTO `synth_recipes` VALUES (457,0,0,0,0,0,0,33,0,0,0,4099,4241,744,744,0,0,0,0,0,0,760,760,760,760,1,2,3,4,'Silver Chain');
INSERT INTO `synth_recipes` VALUES (458,0,1994,0,0,0,0,55,0,0,0,4099,4241,745,745,745,745,745,745,2143,0,761,761,761,761,3,6,9,12,'Gold Chain');
INSERT INTO `synth_recipes` VALUES (459,0,0,0,0,0,0,55,0,0,0,4099,4241,745,745,0,0,0,0,0,0,761,761,761,761,1,2,3,4,'Gold Chain');
INSERT INTO `synth_recipes` VALUES (460,0,1994,0,0,0,0,65,0,0,0,4099,4241,746,746,746,746,746,746,2143,0,762,762,762,762,3,6,9,12,'Platinum Chain');
INSERT INTO `synth_recipes` VALUES (461,0,0,0,0,0,0,65,0,0,0,4099,4241,746,746,0,0,0,0,0,0,762,762,762,762,1,2,3,4,'Platinum Chain');
INSERT INTO `synth_recipes` VALUES (462,0,1994,0,0,0,0,91,0,0,0,4099,4241,747,747,747,747,747,747,2143,0,763,763,763,763,3,6,9,12,'Ocl. Chain');
INSERT INTO `synth_recipes` VALUES (463,0,0,0,0,0,0,91,0,0,0,4099,4241,747,747,0,0,0,0,0,0,763,763,763,763,1,2,3,4,'Ocl. Chain');
INSERT INTO `synth_recipes` VALUES (464,0,1994,0,0,0,0,19,0,0,0,4099,4241,650,650,650,650,650,650,2143,0,764,764,764,764,3,6,9,12,'Brass Chain');
INSERT INTO `synth_recipes` VALUES (465,0,0,0,0,0,0,19,0,0,0,4099,4241,650,650,0,0,0,0,0,0,764,764,764,764,1,2,3,4,'Brass Chain');
INSERT INTO `synth_recipes` VALUES (466,1,0,0,18,0,0,0,0,0,0,4100,4242,499,0,0,0,0,0,0,0,768,792,793,793,4,2,1,1,'Flint Stone');
INSERT INTO `synth_recipes` VALUES (467,1,0,0,0,0,0,0,0,0,99,4100,4242,17590,0,0,0,0,0,0,0,771,771,1228,1228,1,1,6,6,'Yellow Rock');
INSERT INTO `synth_recipes` VALUES (468,1,0,0,0,0,0,0,0,0,101,4100,4242,17592,0,0,0,0,0,0,0,771,771,1228,1225,1,1,4,4,'Yellow Rock');
INSERT INTO `synth_recipes` VALUES (469,1,0,0,0,0,0,55,0,0,0,4100,4242,13476,0,0,0,0,0,0,0,788,788,653,653,1,1,1,2,'Peridot');
INSERT INTO `synth_recipes` VALUES (470,1,0,0,0,0,0,55,0,0,0,4100,4242,13477,0,0,0,0,0,0,0,790,790,653,653,1,1,1,2,'Garnet');
INSERT INTO `synth_recipes` VALUES (471,1,0,0,0,0,0,45,0,0,0,4100,4242,13317,0,0,0,0,0,0,0,792,653,653,653,1,1,2,2,'Pearl');
INSERT INTO `synth_recipes` VALUES (472,1,0,0,0,0,0,55,0,0,0,4100,4242,13483,0,0,0,0,0,0,0,792,792,653,653,1,1,1,2,'Pearl');
INSERT INTO `synth_recipes` VALUES (473,1,0,0,0,0,0,55,0,0,0,4100,4242,13482,0,0,0,0,0,0,0,793,793,653,653,1,1,1,2,'Black Pearl');
INSERT INTO `synth_recipes` VALUES (474,1,0,0,0,0,0,85,0,0,0,4100,4242,13355,0,0,0,0,0,0,0,794,794,746,746,1,1,1,1,'Sapphire');
INSERT INTO `synth_recipes` VALUES (475,0,0,0,0,0,0,20,0,0,0,4098,4240,770,0,0,0,0,0,0,0,795,798,791,794,1,1,1,1,'Lapis Lazuli');
INSERT INTO `synth_recipes` VALUES (476,1,0,0,0,0,0,25,0,0,0,4100,4242,13334,0,0,0,0,0,0,0,795,795,744,744,1,1,1,2,'Lapis Lazuli');
INSERT INTO `synth_recipes` VALUES (477,1,0,0,0,0,0,35,0,0,0,4100,4242,13472,0,0,0,0,0,0,0,795,795,744,744,1,1,1,2,'Lapis Lazuli');
INSERT INTO `synth_recipes` VALUES (478,0,0,0,0,0,0,20,0,0,0,4098,4240,776,0,0,0,0,0,0,0,796,796,802,813,1,1,1,1,'Light Opal');
INSERT INTO `synth_recipes` VALUES (479,1,0,0,0,0,0,25,0,0,0,4100,4242,13337,0,0,0,0,0,0,0,796,796,744,744,1,1,1,2,'Light Opal');
INSERT INTO `synth_recipes` VALUES (480,1,0,0,0,0,0,35,0,0,0,4100,4242,13443,0,0,0,0,0,0,0,796,796,744,744,1,1,1,2,'Light Opal');
INSERT INTO `synth_recipes` VALUES (481,1,0,0,0,0,0,55,0,0,0,4100,4242,13480,0,0,0,0,0,0,0,798,798,653,653,1,1,1,2,'Turquoise');
INSERT INTO `synth_recipes` VALUES (482,0,0,0,0,0,0,20,0,0,0,4098,4240,775,0,0,0,0,0,0,0,799,799,797,812,1,1,1,1,'Onyx');
INSERT INTO `synth_recipes` VALUES (483,1,0,0,0,0,0,25,0,0,0,4100,4242,13336,0,0,0,0,0,0,0,799,799,744,744,1,1,1,2,'Onyx');
INSERT INTO `synth_recipes` VALUES (484,1,0,0,0,0,0,35,0,0,0,4100,4242,13474,0,0,0,0,0,0,0,799,799,744,744,1,1,1,2,'Onyx');
INSERT INTO `synth_recipes` VALUES (485,0,0,0,0,0,0,20,0,0,0,4098,4240,774,0,0,0,0,0,0,0,800,811,810,804,1,1,1,1,'Amethyst');
INSERT INTO `synth_recipes` VALUES (486,1,0,0,0,0,0,25,0,0,0,4100,4242,13333,0,0,0,0,0,0,0,800,800,744,744,1,1,1,2,'Amethyst');
INSERT INTO `synth_recipes` VALUES (487,1,0,0,0,0,0,35,0,0,0,4100,4242,13471,0,0,0,0,0,0,0,800,800,744,744,1,1,1,2,'Amethyst');
INSERT INTO `synth_recipes` VALUES (488,0,0,0,0,0,0,20,0,0,0,4098,4240,772,0,0,0,0,0,0,0,806,788,784,785,1,1,1,1,'Tourmaline');
INSERT INTO `synth_recipes` VALUES (489,1,0,0,0,0,0,25,0,0,0,4100,4242,13330,0,0,0,0,0,0,0,806,806,744,744,1,1,1,2,'Tourmaline');
INSERT INTO `synth_recipes` VALUES (490,1,0,0,0,0,0,35,0,0,0,4100,4242,13468,0,0,0,0,0,0,0,806,806,744,744,1,1,1,2,'Tourmaline');
INSERT INTO `synth_recipes` VALUES (491,0,0,0,0,0,0,20,0,0,0,4098,4240,769,0,0,0,0,0,0,0,807,790,803,786,1,1,1,1,'Sardonyx');
INSERT INTO `synth_recipes` VALUES (492,1,0,0,0,0,0,25,0,0,0,4100,4242,13331,0,0,0,0,0,0,0,807,807,744,744,1,1,1,2,'Sardonyx');
INSERT INTO `synth_recipes` VALUES (493,1,0,0,0,0,0,35,0,0,0,4100,4242,13444,0,0,0,0,0,0,0,807,807,744,744,1,1,1,2,'Sardonyx');
INSERT INTO `synth_recipes` VALUES (494,1,0,0,0,0,0,44,0,0,0,4100,4242,17291,0,0,0,0,0,0,0,807,744,653,790,1,1,1,1,'Sardonyx');
INSERT INTO `synth_recipes` VALUES (495,1,0,0,0,0,0,55,0,0,0,4100,4242,13478,0,0,0,0,0,0,0,808,808,653,653,1,1,1,2,'Goshenite');
INSERT INTO `synth_recipes` VALUES (496,0,0,0,0,0,0,20,0,0,0,4098,4240,773,0,0,0,0,0,0,0,809,808,805,787,1,1,1,1,'Clear Topaz');
INSERT INTO `synth_recipes` VALUES (497,0,0,0,0,0,0,22,0,0,0,4098,4240,1470,0,0,0,0,0,0,0,809,808,805,1460,1,1,1,1,'Clear Topaz');
INSERT INTO `synth_recipes` VALUES (498,1,0,0,0,0,0,0,0,0,63,4100,4242,12338,0,0,0,0,0,0,0,809,930,851,717,1,1,1,1,'Clear Topaz');
INSERT INTO `synth_recipes` VALUES (499,1,0,0,0,0,0,25,0,0,0,4100,4242,13332,0,0,0,0,0,0,0,809,809,744,744,1,1,1,2,'Clear Topaz');
INSERT INTO `synth_recipes` VALUES (500,1,0,0,0,0,0,35,0,0,0,4100,4242,13470,0,0,0,0,0,0,0,809,809,744,744,1,1,1,2,'Clear Topaz');
INSERT INTO `synth_recipes` VALUES (501,1,0,0,0,0,0,55,0,0,0,4100,4242,13479,0,0,0,0,0,0,0,811,811,653,653,1,1,1,2,'Ametrine');
INSERT INTO `synth_recipes` VALUES (502,0,0,0,0,0,0,20,0,0,0,4098,4240,771,0,0,0,0,0,0,0,814,815,801,789,1,1,1,1,'Amber');
INSERT INTO `synth_recipes` VALUES (503,1,0,0,0,0,0,25,0,0,0,4100,4242,13335,0,0,0,0,0,0,0,814,814,744,744,1,1,1,2,'Amber');
INSERT INTO `synth_recipes` VALUES (504,1,0,0,0,0,0,35,0,0,0,4100,4242,13473,0,0,0,0,0,0,0,814,814,744,744,1,1,1,2,'Amber');
INSERT INTO `synth_recipes` VALUES (505,1,0,0,0,0,0,55,0,0,0,4100,4242,13481,0,0,0,0,0,0,0,815,815,653,653,1,1,1,2,'Sphene');
INSERT INTO `synth_recipes` VALUES (506,0,2010,0,0,51,0,0,0,0,0,4100,4242,839,839,839,839,839,839,2128,0,816,816,816,816,3,3,3,3,'Silk Thread');
INSERT INTO `synth_recipes` VALUES (507,0,0,0,0,51,0,0,0,0,0,4100,4242,839,839,0,0,0,0,0,0,816,816,816,816,1,1,1,1,'Silk Thread');
INSERT INTO `synth_recipes` VALUES (508,1,0,0,0,76,0,0,0,0,0,4100,4242,12468,0,0,0,0,0,0,0,816,816,816,842,1,2,3,1,'Silk Thread');
INSERT INTO `synth_recipes` VALUES (509,1,0,0,0,69,0,0,0,0,0,4100,4242,12503,0,0,0,0,0,0,0,816,816,816,932,1,2,3,1,'Silk Thread');
INSERT INTO `synth_recipes` VALUES (510,1,0,0,0,80,0,0,0,0,0,4100,4242,12588,0,0,0,0,0,0,0,816,816,651,651,3,5,1,1,'Silk Thread');
INSERT INTO `synth_recipes` VALUES (511,1,0,0,0,87,0,0,0,0,0,4100,4242,12605,0,0,0,0,0,0,0,816,821,821,821,1,1,1,1,'Silk Thread');
INSERT INTO `synth_recipes` VALUES (512,1,0,0,0,60,0,0,0,0,0,4100,4242,12739,0,0,0,0,0,0,0,816,819,820,820,1,3,2,2,'Silk Thread');
INSERT INTO `synth_recipes` VALUES (513,1,0,0,96,0,0,0,0,0,0,4100,4242,12751,0,0,0,0,0,0,0,816,850,1473,1473,3,2,1,1,'Silk Thread');
INSERT INTO `synth_recipes` VALUES (514,1,0,0,0,96,0,0,0,0,0,4100,4242,12847,0,0,0,0,0,0,0,816,816,855,1228,1,1,1,4,'Silk Thread');
INSERT INTO `synth_recipes` VALUES (515,1,0,0,0,0,0,0,0,83,0,4100,4242,13088,0,0,0,0,0,0,0,816,816,654,654,1,1,1,1,'Silk Thread');
INSERT INTO `synth_recipes` VALUES (516,1,0,0,0,0,0,0,0,66,0,4100,4242,13111,0,0,0,0,0,0,0,816,816,651,651,1,1,1,1,'Silk Thread');
INSERT INTO `synth_recipes` VALUES (517,1,0,0,0,52,0,0,0,0,0,4100,4242,13568,0,0,0,0,0,0,0,816,816,820,820,1,1,1,2,'Silk Thread');
INSERT INTO `synth_recipes` VALUES (518,1,0,0,0,54,0,0,0,0,0,4100,4242,13577,0,0,0,0,0,0,0,816,822,820,820,2,1,3,4,'Silk Thread');
INSERT INTO `synth_recipes` VALUES (519,1,0,0,0,74,0,0,0,0,0,4100,4242,13579,0,0,0,0,0,0,0,816,816,850,850,4,5,1,2,'Silk Thread');
INSERT INTO `synth_recipes` VALUES (520,1,0,0,0,64,0,0,0,0,0,4100,4242,13585,0,0,0,0,0,0,0,816,816,816,820,4,5,6,1,'Silk Thread');
INSERT INTO `synth_recipes` VALUES (521,1,0,0,0,59,0,0,0,0,0,4100,4242,13586,0,0,0,0,0,0,0,816,816,820,823,1,2,4,1,'Silk Thread');
INSERT INTO `synth_recipes` VALUES (522,1,0,0,0,62,0,0,0,0,0,4100,4242,13590,0,0,0,0,0,0,0,816,816,816,816,1,1,2,3,'Silk Thread');
INSERT INTO `synth_recipes` VALUES (523,1,0,0,0,89,0,0,0,0,0,4100,4242,13795,0,0,0,0,0,0,0,816,652,821,821,3,2,3,4,'Silk Thread');
INSERT INTO `synth_recipes` VALUES (524,1,0,0,0,94,0,0,0,0,0,4100,4242,13910,0,0,0,0,0,0,0,816,1228,1228,1228,4,10,12,12,'Silk Thread');
INSERT INTO `synth_recipes` VALUES (525,1,0,0,0,86,0,0,0,0,0,4100,4242,14023,0,0,0,0,0,0,0,816,819,1228,1228,6,1,10,12,'Silk Thread'); -- desynth arhat's tekko (cloth 86) https://www.bg-wiki.com/bg/Arhat's_Tekko
INSERT INTO `synth_recipes` VALUES (526,1,0,0,0,98,0,0,0,0,0,4100,4242,14078,0,0,0,0,0,0,0,816,823,821,821,3,1,3,3,'Silk Thread');
INSERT INTO `synth_recipes` VALUES (527,1,0,0,0,92,0,0,0,0,0,4100,4242,14178,0,0,0,0,0,0,0,816,855,855,855,1,2,2,2,'Silk Thread');
INSERT INTO `synth_recipes` VALUES (528,1,0,0,0,0,0,0,91,0,0,4100,4242,14182,0,0,0,0,0,0,0,816,851,849,821,1,2,1,1,'Silk Thread');
INSERT INTO `synth_recipes` VALUES (529,1,0,0,0,68,0,0,0,0,0,4100,4242,14360,0,0,0,0,0,0,0,816,816,816,816,3,3,3,3,'Silk Thread');
INSERT INTO `synth_recipes` VALUES (530,1,0,0,0,96,0,0,0,0,0,4100,4242,14380,0,0,0,0,0,0,0,816,851,821,745,6,1,6,1,'Silk Thread');
INSERT INTO `synth_recipes` VALUES (531,1,0,0,42,0,0,0,0,0,0,4100,4242,14426,0,0,0,0,0,0,0,816,816,816,816,1,1,1,1,'Silk Thread');
INSERT INTO `synth_recipes` VALUES (532,1,0,0,0,102,0,0,0,0,0,4100,4242,14436,0,0,0,0,0,0,0,816,823,821,1769,1,1,3,1,'Silk Thread');
INSERT INTO `synth_recipes` VALUES (533,1,0,0,0,0,0,0,0,64,0,4100,4242,14444,0,0,0,0,0,0,0,816,816,654,654,3,3,7,7,'Silk Thread');
INSERT INTO `synth_recipes` VALUES (534,1,0,0,0,0,0,0,96,0,0,4100,4242,14846,0,0,0,0,0,0,0,816,855,1680,1680,1,1,1,1,'Silk Thread');
INSERT INTO `synth_recipes` VALUES (535,1,0,0,0,0,0,0,0,0,58,4100,4242,17164,0,0,0,0,0,0,0,816,933,932,932,3,1,1,1,'Silk Thread');
INSERT INTO `synth_recipes` VALUES (536,1,0,0,0,0,0,0,0,0,77,4100,4242,17383,0,0,0,0,0,0,0,816,816,717,717,1,1,1,1,'Silk Thread');
INSERT INTO `synth_recipes` VALUES (537,1,0,0,0,0,0,0,0,0,65,4100,4242,17387,0,0,0,0,0,0,0,816,816,711,711,1,1,1,1,'Silk Thread');
INSERT INTO `synth_recipes` VALUES (538,0,0,0,0,1,0,0,0,0,0,4098,4240,498,0,0,0,0,0,0,0,817,817,817,817,3,6,9,12,'Grass Thread');
INSERT INTO `synth_recipes` VALUES (539,0,2010,0,0,3,0,0,0,0,0,4100,4242,833,833,833,833,833,833,2128,0,817,817,817,817,3,3,3,3,'Grass Thread');
INSERT INTO `synth_recipes` VALUES (540,0,0,0,0,3,0,0,0,0,0,4100,4242,833,833,0,0,0,0,0,0,817,817,817,817,1,1,1,1,'Grass Thread');
INSERT INTO `synth_recipes` VALUES (541,1,0,0,0,11,0,0,0,0,0,4100,4242,12456,0,0,0,0,0,0,0,817,817,817,817,3,4,5,6,'Grass Thread');
INSERT INTO `synth_recipes` VALUES (542,1,0,0,0,5,0,0,0,0,0,4100,4242,12464,0,0,0,0,0,0,0,817,817,817,817,4,5,6,7,'Grass Thread');
INSERT INTO `synth_recipes` VALUES (543,1,0,0,0,18,0,0,0,0,0,4100,4242,12584,0,0,0,0,0,0,0,817,817,817,817,7,8,9,10,'Grass Thread');
INSERT INTO `synth_recipes` VALUES (544,1,0,0,0,28,0,0,0,0,0,4100,4242,12585,0,0,0,0,0,0,0,817,818,818,818,1,7,8,9,'Grass Thread');
INSERT INTO `synth_recipes` VALUES (545,1,0,0,0,38,0,0,0,0,0,4100,4242,12586,0,0,0,0,0,0,0,817,819,819,819,1,7,8,9,'Grass Thread');
INSERT INTO `synth_recipes` VALUES (546,1,0,0,0,10,0,0,0,0,0,4100,4242,12592,0,0,0,0,0,0,0,817,817,834,834,10,12,2,3,'Grass Thread');
INSERT INTO `synth_recipes` VALUES (547,1,0,0,0,16,0,0,0,0,0,4100,4242,12600,0,0,0,0,0,0,0,817,817,818,818,5,7,5,6,'Grass Thread');
INSERT INTO `synth_recipes` VALUES (548,1,0,0,0,0,0,0,0,57,0,4100,4242,12672,0,0,0,0,0,0,0,817,850,850,651,6,3,4,2,'Grass Thread');
INSERT INTO `synth_recipes` VALUES (549,1,0,0,0,0,0,66,0,0,0,4100,4242,12673,0,0,0,0,0,0,0,817,850,653,1228,6,4,1,6,'Grass Thread');
INSERT INTO `synth_recipes` VALUES (550,1,0,0,0,0,0,0,8,0,0,4100,4242,12696,0,0,0,0,0,0,0,817,817,850,850,2,3,2,3,'Grass Thread');
INSERT INTO `synth_recipes` VALUES (551,1,0,0,0,0,0,0,16,0,0,4100,4242,12697,0,0,0,0,0,0,0,817,850,850,852,3,1,2,1,'Grass Thread');
INSERT INTO `synth_recipes` VALUES (552,1,0,0,0,0,0,0,57,0,0,4100,4242,12700,0,0,0,0,0,0,0,817,850,853,853,3,2,1,1,'Grass Thread');
INSERT INTO `synth_recipes` VALUES (553,1,0,0,0,6,0,0,0,0,0,4100,4242,12720,0,0,0,0,0,0,0,817,817,834,834,6,7,1,2,'Grass Thread');
INSERT INTO `synth_recipes` VALUES (554,1,0,0,0,12,0,0,0,0,0,4100,4242,12728,0,0,0,0,0,0,0,817,768,818,818,3,2,3,4,'Grass Thread');
INSERT INTO `synth_recipes` VALUES (555,1,0,0,0,13,0,0,0,0,0,4100,4242,12736,0,0,0,0,0,0,0,817,817,834,834,2,3,1,1,'Grass Thread');
INSERT INTO `synth_recipes` VALUES (556,1,0,0,0,0,0,0,9,0,0,4100,4242,12824,0,0,0,0,0,0,0,817,817,850,850,5,6,1,2,'Grass Thread');
INSERT INTO `synth_recipes` VALUES (557,1,0,0,0,0,0,0,30,0,0,4100,4242,12826,0,0,0,0,0,0,0,817,817,817,817,6,6,6,6,'Grass Thread');
INSERT INTO `synth_recipes` VALUES (558,1,0,0,0,0,0,16,0,0,0,4100,4242,12833,0,0,0,0,0,0,0,817,850,649,650,3,1,1,1,'Grass Thread');
INSERT INTO `synth_recipes` VALUES (559,1,0,0,0,16,0,0,0,0,0,4100,4242,12840,0,0,0,0,0,0,0,817,817,818,818,6,7,2,3,'Grass Thread');
INSERT INTO `synth_recipes` VALUES (560,1,0,0,0,9,0,0,0,0,0,4100,4242,12848,0,0,0,0,0,0,0,817,817,817,817,8,8,8,8,'Grass Thread');
INSERT INTO `synth_recipes` VALUES (561,1,0,0,0,14,0,0,0,0,0,4100,4242,12856,0,0,0,0,0,0,0,817,817,818,818,2,3,3,4,'Grass Thread');
INSERT INTO `synth_recipes` VALUES (562,1,0,0,0,14,0,0,0,0,0,4100,4242,12968,0,0,0,0,0,0,0,817,817,817,850,7,8,9,1,'Grass Thread');
INSERT INTO `synth_recipes` VALUES (563,1,0,0,0,7,0,0,0,0,0,4100,4242,12976,0,0,0,0,0,0,0,817,817,818,818,8,9,1,1,'Grass Thread');
INSERT INTO `synth_recipes` VALUES (564,1,0,0,0,0,0,0,37,0,0,4100,4242,13081,0,0,0,0,0,0,0,817,817,851,851,1,1,1,1,'Grass Thread');
INSERT INTO `synth_recipes` VALUES (565,1,0,0,0,43,0,0,0,0,0,4100,4242,13085,0,0,0,0,0,0,0,817,817,817,817,5,6,7,8,'Grass Thread');
INSERT INTO `synth_recipes` VALUES (566,1,0,0,57,0,0,0,0,0,0,4100,4242,13199,0,0,0,0,0,0,0,817,924,893,893,1,1,1,1,'Grass Thread');
INSERT INTO `synth_recipes` VALUES (567,1,0,0,0,0,0,0,43,0,0,4100,4242,13200,0,0,0,0,0,0,0,817,851,851,851,1,1,2,2,'Grass Thread');
INSERT INTO `synth_recipes` VALUES (568,1,0,0,0,27,0,0,0,0,0,4100,4242,13204,0,0,0,0,0,0,0,817,818,818,818,1,4,5,6,'Grass Thread');
INSERT INTO `synth_recipes` VALUES (569,1,0,0,0,8,0,0,0,0,0,4100,4242,13583,0,0,0,0,0,0,0,817,817,817,817,4,5,6,7,'Grass Thread');
INSERT INTO `synth_recipes` VALUES (570,1,0,0,0,0,0,0,69,0,0,4100,4242,13592,0,0,0,0,0,0,0,817,852,869,869,1,1,1,1,'Grass Thread');
INSERT INTO `synth_recipes` VALUES (571,1,0,0,0,0,0,0,53,0,0,4100,4242,13593,0,0,0,0,0,0,0,817,853,853,853,1,1,2,2,'Grass Thread');
INSERT INTO `synth_recipes` VALUES (572,1,0,0,0,0,0,0,7,0,0,4100,4242,13594,0,0,0,0,0,0,0,817,856,856,856,1,3,4,5,'Grass Thread');
INSERT INTO `synth_recipes` VALUES (573,1,0,0,92,0,0,0,0,0,0,4100,4242,14008,0,0,0,0,0,0,0,817,1193,850,850,3,1,1,3,'Grass Thread');
INSERT INTO `synth_recipes` VALUES (574,1,0,0,0,0,0,0,0,8,0,4100,4242,16768,0,0,0,0,0,0,0,817,715,649,649,3,1,1,2,'Grass Thread');
INSERT INTO `synth_recipes` VALUES (575,1,0,0,0,0,0,0,0,75,0,4100,4242,16783,0,0,0,0,0,0,0,817,651,715,715,3,1,1,1,'Grass Thread');
INSERT INTO `synth_recipes` VALUES (576,1,0,0,57,0,0,0,0,0,0,4100,4242,16794,0,0,0,0,0,0,0,817,882,893,893,3,1,1,1,'Grass Thread');
INSERT INTO `synth_recipes` VALUES (577,1,0,0,0,0,0,0,0,61,0,4100,4242,16796,0,0,0,0,0,0,0,817,1226,717,717,3,10,1,1,'Grass Thread');
INSERT INTO `synth_recipes` VALUES (578,1,0,0,0,0,0,0,0,0,15,4100,4242,17152,0,0,0,0,0,0,0,817,712,712,712,4,1,1,1,'Grass Thread');
INSERT INTO `synth_recipes` VALUES (579,1,0,0,0,9,0,0,0,0,0,4100,4242,510,0,0,0,0,0,0,0,818,818,818,818,2,4,6,8,'Cotton Thread');
INSERT INTO `synth_recipes` VALUES (580,0,2010,0,0,11,0,0,0,0,0,4100,4242,834,834,834,834,834,834,2128,0,818,818,818,818,3,3,3,3,'Cotton Thread');
INSERT INTO `synth_recipes` VALUES (581,0,0,0,0,11,0,0,0,0,0,4100,4242,834,834,0,0,0,0,0,0,818,818,818,818,1,1,1,1,'Cotton Thread');
INSERT INTO `synth_recipes` VALUES (582,1,0,0,0,9,0,0,0,0,0,4100,4242,1121,0,0,0,0,0,0,0,818,818,818,818,2,4,6,8,'Cotton Thread');
INSERT INTO `synth_recipes` VALUES (583,1,0,0,0,7,0,0,0,0,0,4100,4242,1631,0,0,0,0,0,0,0,818,818,818,818,2,4,6,8,'Cotton Thread');
INSERT INTO `synth_recipes` VALUES (584,1,0,0,0,64,0,0,0,0,0,4100,4242,1639,0,0,0,0,0,0,0,818,818,816,823,4,6,1,1,'Cotton Thread');
INSERT INTO `synth_recipes` VALUES (585,1,0,0,0,21,0,0,0,0,0,4100,4242,12457,0,0,0,0,0,0,0,818,818,818,818,3,4,5,6,'Cotton Thread');
INSERT INTO `synth_recipes` VALUES (586,1,0,0,0,15,0,0,0,0,0,4100,4242,12465,0,0,0,0,0,0,0,818,818,818,818,4,5,6,7,'Cotton Thread');
INSERT INTO `synth_recipes` VALUES (587,1,0,0,0,20,0,0,0,0,0,4100,4242,12498,0,0,0,0,0,0,0,818,818,818,932,1,2,3,1,'Cotton Thread');
INSERT INTO `synth_recipes` VALUES (588,1,0,0,0,0,0,36,0,0,0,4100,4242,12561,0,0,0,0,0,0,0,818,852,850,850,1,1,3,3,'Cotton Thread');
INSERT INTO `synth_recipes` VALUES (589,1,0,0,0,27,0,0,0,0,0,4100,4242,12601,0,0,0,0,0,0,0,818,818,819,819,5,7,5,6,'Cotton Thread');
INSERT INTO `synth_recipes` VALUES (590,1,0,0,0,23,0,0,0,0,0,4100,4242,12729,0,0,0,0,0,0,0,818,819,807,807,3,4,1,2,'Cotton Thread');
INSERT INTO `synth_recipes` VALUES (591,1,0,0,0,25,0,0,0,0,0,4100,4242,12857,0,0,0,0,0,0,0,818,818,819,819,2,3,6,7,'Cotton Thread');
INSERT INTO `synth_recipes` VALUES (592,1,0,0,0,15,0,0,0,0,0,4100,4242,12864,0,0,0,0,0,0,0,818,818,818,818,7,8,8,8,'Cotton Thread');
INSERT INTO `synth_recipes` VALUES (593,1,0,0,0,24,0,0,0,0,0,4100,4242,12969,0,0,0,0,0,0,0,818,818,818,819,7,8,9,1,'Cotton Thread');
INSERT INTO `synth_recipes` VALUES (594,1,0,0,0,0,0,0,39,0,0,4100,4242,13089,0,0,0,0,0,0,0,818,818,858,858,1,1,1,1,'Cotton Thread');
INSERT INTO `synth_recipes` VALUES (595,1,0,0,0,0,0,0,79,0,0,4100,4242,13092,0,0,0,0,0,0,0,818,818,863,863,1,1,1,1,'Cotton Thread');
INSERT INTO `synth_recipes` VALUES (596,1,0,0,18,0,0,0,0,0,0,4100,4242,13110,0,0,0,0,0,0,0,818,893,893,893,1,1,1,1,'Cotton Thread');
INSERT INTO `synth_recipes` VALUES (597,1,0,0,0,18,0,0,0,0,0,4100,4242,13584,0,0,0,0,0,0,0,818,818,818,818,4,5,6,7,'Cotton Thread');
INSERT INTO `synth_recipes` VALUES (598,1,0,0,0,24,0,0,0,0,0,4100,4242,14856,0,0,0,0,0,0,0,818,818,834,850,6,10,1,1,'Cotton Thread');
INSERT INTO `synth_recipes` VALUES (599,1,0,0,0,0,0,51,0,0,0,4100,4242,17281,0,0,0,0,0,0,0,818,744,653,653,1,1,1,1,'Cotton Thread');
INSERT INTO `synth_recipes` VALUES (600,0,2010,0,0,19,0,0,0,0,0,4100,4242,835,835,835,835,835,835,2128,0,819,819,819,819,3,3,3,3,'Linen Thread');
INSERT INTO `synth_recipes` VALUES (601,0,0,0,0,19,0,0,0,0,0,4100,4242,835,835,0,0,0,0,0,0,819,819,819,819,1,1,1,1,'Linen Thread');
INSERT INTO `synth_recipes` VALUES (602,1,0,0,0,17,0,0,0,0,0,4100,4242,1119,0,0,0,0,0,0,0,819,819,819,819,2,4,6,8,'Linen Thread');
INSERT INTO `synth_recipes` VALUES (603,1,0,0,0,31,0,0,0,0,0,4100,4242,12458,0,0,0,0,0,0,0,819,819,819,819,3,4,5,6,'Linen Thread');
INSERT INTO `synth_recipes` VALUES (604,1,0,0,48,0,0,0,0,0,0,4100,4242,12837,0,0,0,0,0,0,0,819,819,881,848,2,3,1,1,'Linen Thread');
INSERT INTO `synth_recipes` VALUES (605,1,0,0,72,0,0,0,0,0,0,4100,4242,12878,0,0,0,0,0,0,0,819,506,887,887,2,1,1,1,'Linen Thread');
INSERT INTO `synth_recipes` VALUES (606,1,0,0,0,98,0,0,0,0,0,4100,4242,14196,0,0,0,0,0,0,0,819,848,853,821,3,1,1,4,'Linen Thread');
INSERT INTO `synth_recipes` VALUES (607,1,0,0,0,60,0,0,0,0,0,4100,4242,14297,0,0,0,0,0,0,0,819,820,820,820,3,4,6,6,'Linen Thread');
INSERT INTO `synth_recipes` VALUES (608,1,0,0,0,26,0,0,0,0,0,4100,4242,14422,0,0,0,0,0,0,0,819,819,834,834,6,10,3,3,'Linen Thread');
INSERT INTO `synth_recipes` VALUES (609,1,0,0,0,25,0,0,0,0,0,4100,4242,14854,0,0,0,0,0,0,0,819,850,850,850,5,1,1,1,'Linen Thread');
INSERT INTO `synth_recipes` VALUES (610,1,0,0,0,33,0,0,0,0,0,4098,4240,499,0,0,0,0,0,0,0,820,820,820,820,1,2,3,4,'Wool Thread');
INSERT INTO `synth_recipes` VALUES (611,1,0,0,0,35,0,0,0,0,0,4100,4242,497,0,0,0,0,0,0,0,820,820,820,820,2,4,6,8,'Wool Thread');
INSERT INTO `synth_recipes` VALUES (612,0,2010,0,0,35,0,0,0,0,0,4100,4242,832,832,832,832,832,832,2128,0,820,820,820,820,3,3,3,3,'Wool Thread');
INSERT INTO `synth_recipes` VALUES (613,0,0,0,0,35,0,0,0,0,0,4100,4242,832,832,0,0,0,0,0,0,820,820,820,820,1,1,1,1,'Wool Thread');
INSERT INTO `synth_recipes` VALUES (614,1,0,0,0,57,0,0,0,0,0,4100,4242,12859,0,0,0,0,0,0,0,820,650,822,816,7,1,1,2,'Wool Thread');
INSERT INTO `synth_recipes` VALUES (615,1,0,0,0,61,0,0,0,0,0,4100,4242,12867,0,0,0,0,0,0,0,820,820,820,820,3,3,3,3,'Wool Thread');
INSERT INTO `synth_recipes` VALUES (616,1,0,0,0,95,0,0,0,0,0,4100,4242,13212,0,0,0,0,0,0,0,820,822,823,821,1,1,1,1,'Wool Thread');
INSERT INTO `synth_recipes` VALUES (617,1,0,0,0,0,0,0,49,0,0,4100,4242,13570,0,0,0,0,0,0,0,820,820,859,859,1,1,1,1,'Wool Thread');
INSERT INTO `synth_recipes` VALUES (618,1,0,0,0,0,0,0,75,0,0,4100,4242,13589,0,0,0,0,0,0,0,820,820,820,820,1,1,1,1,'Wool Thread');
INSERT INTO `synth_recipes` VALUES (619,1,0,0,0,0,0,0,70,0,0,4100,4242,13591,0,0,0,0,0,0,0,820,820,820,820,1,1,1,1,'Wool Thread');
INSERT INTO `synth_recipes` VALUES (620,1,0,0,0,0,0,0,85,0,0,4100,4242,13595,0,0,0,0,0,0,0,820,820,863,863,1,1,1,1,'Wool Thread');
INSERT INTO `synth_recipes` VALUES (621,1,0,0,0,0,0,0,102,0,0,4100,4242,13942,0,0,0,0,0,0,0,820,851,1591,1122,1,1,1,1,'Wool Thread'); -- panther mask desynth (leath 102) https://www.bg-wiki.com/bg/Panther_Mask
INSERT INTO `synth_recipes` VALUES (622,1,0,0,0,25,0,0,0,0,0,4100,4242,14325,0,0,0,0,0,0,0,820,820,820,820,1,1,1,1,'Wool Thread');
INSERT INTO `synth_recipes` VALUES (623,0,2010,0,0,78,0,0,0,0,0,4100,4242,838,838,838,838,838,838,2128,0,821,821,821,821,3,3,3,3,'Rainbow Thread');
INSERT INTO `synth_recipes` VALUES (624,0,0,0,0,78,0,0,0,0,0,4100,4242,838,838,0,0,0,0,0,0,821,821,821,821,1,1,1,1,'Rainbow Thread');
INSERT INTO `synth_recipes` VALUES (625,1,0,0,0,94,0,0,0,0,0,4100,4242,13587,0,0,0,0,0,0,0,821,821,821,821,3,4,5,6,'Rainbow Thread');
INSERT INTO `synth_recipes` VALUES (626,1,0,0,0,0,0,0,0,0,93,4100,4242,17205,0,0,0,0,0,0,0,821,927,1620,720,1,1,1,2,'Rainbow Thread');
INSERT INTO `synth_recipes` VALUES (627,0,2010,0,0,47,0,12,0,0,0,4099,4241,744,744,744,816,816,816,2128,0,822,822,822,822,6,8,12,12,'Silver Thread');
INSERT INTO `synth_recipes` VALUES (628,0,0,0,0,47,0,12,0,0,0,4099,4241,744,816,0,0,0,0,0,0,822,822,822,822,2,4,6,8,'Silver Thread');
INSERT INTO `synth_recipes` VALUES (629,1,0,0,0,65,0,0,0,0,0,4100,4242,12476,0,0,0,0,0,0,0,822,816,816,816,1,6,6,6,'Silver Thread');
INSERT INTO `synth_recipes` VALUES (630,0,2010,0,0,58,0,41,0,0,0,4099,4241,745,745,745,816,816,816,2128,0,823,823,823,823,6,8,12,12,'Gold Thread');
INSERT INTO `synth_recipes` VALUES (631,0,0,0,0,58,0,41,0,0,0,4099,4241,745,816,0,0,0,0,0,0,823,823,823,823,2,4,6,8,'Gold Thread');
INSERT INTO `synth_recipes` VALUES (632,1,0,0,0,70,0,0,0,0,0,4100,4242,13206,0,0,0,0,0,0,0,823,823,823,823,1,1,1,1,'Gold Thread');
INSERT INTO `synth_recipes` VALUES (633,1,0,0,0,95,0,0,0,0,0,4100,4242,13950,0,0,0,0,0,0,0,823,855,855,844,1,1,2,1,'Gold Thread');
INSERT INTO `synth_recipes` VALUES (634,0,0,0,0,4,0,0,0,0,0,4099,4241,817,817,817,0,0,0,0,0,824,824,824,824,1,1,1,1,'Grass Cloth');
INSERT INTO `synth_recipes` VALUES (635,1,0,0,0,10,0,0,0,0,0,4098,4240,1121,0,0,0,0,0,0,0,825,825,825,825,1,2,3,4,'Cotton Cloth');
INSERT INTO `synth_recipes` VALUES (636,0,0,0,0,12,0,0,0,0,0,4099,4241,818,818,818,0,0,0,0,0,825,825,825,825,1,1,1,1,'Cotton Cloth');
INSERT INTO `synth_recipes` VALUES (637,1,0,0,0,22,0,0,0,0,0,4098,4240,1119,0,0,0,0,0,0,0,826,826,826,826,1,2,2,2,'Linen Cloth');
INSERT INTO `synth_recipes` VALUES (638,0,0,0,0,22,0,0,0,0,0,4099,4241,819,819,819,0,0,0,0,0,826,826,826,826,1,1,1,1,'Linen Cloth');
INSERT INTO `synth_recipes` VALUES (639,0,0,0,0,37,0,0,0,0,0,4099,4241,820,820,820,0,0,0,0,0,827,827,827,827,1,1,1,1,'Wool Cloth');
INSERT INTO `synth_recipes` VALUES (640,1,0,0,0,44,0,0,0,0,0,4098,4240,1639,0,0,0,0,0,0,0,828,828,828,828,2,3,3,3,'Velvet Cloth');
INSERT INTO `synth_recipes` VALUES (641,0,0,0,0,50,0,0,0,0,0,4099,4241,816,818,818,0,0,0,0,0,828,828,828,828,1,1,1,1,'Velvet Cloth'); -- velvet cloth (cloth 50) https://www.bg-wiki.com/bg/Velvet_Cloth
INSERT INTO `synth_recipes` VALUES (642,0,0,0,0,45,0,0,0,0,0,4099,4241,816,820,820,0,0,0,0,0,828,828,828,828,1,1,1,1,'Velvet Cloth');
INSERT INTO `synth_recipes` VALUES (643,0,0,0,0,53,0,0,0,0,0,4099,4241,816,816,816,0,0,0,0,0,829,829,829,829,1,1,1,1,'Silk Cloth');
INSERT INTO `synth_recipes` VALUES (644,0,0,0,0,80,0,0,0,0,0,4099,4241,821,821,821,0,0,0,0,0,830,830,830,830,1,1,1,1,'Rainbow Cloth');
INSERT INTO `synth_recipes` VALUES (645,0,0,0,0,0,0,0,4,0,0,4098,4240,505,505,0,0,0,0,0,0,832,832,832,832,1,1,1,1,'Sheep Wool');
INSERT INTO `synth_recipes` VALUES (646,1,0,0,0,81,0,0,0,0,0,4100,4242,12725,0,0,0,0,0,0,0,834,834,816,821,1,2,2,1,'Saruta Cotton');
INSERT INTO `synth_recipes` VALUES (647,1,0,0,0,64,0,0,0,0,0,4100,4242,12737,0,0,0,0,0,0,0,834,816,820,823,1,4,2,1,'Saruta Cotton');
INSERT INTO `synth_recipes` VALUES (648,1,0,0,0,0,0,0,0,0,23,4100,4242,17051,0,0,0,0,0,0,0,841,713,713,713,1,1,1,1,'Yagudo Feather');
INSERT INTO `synth_recipes` VALUES (649,1,0,0,0,0,0,0,28,0,0,4100,4242,12954,0,0,0,0,0,0,0,848,651,651,651,1,1,2,2,'Dhalmel Leather');
INSERT INTO `synth_recipes` VALUES (650,1,0,0,0,0,0,0,22,0,0,4100,4242,13469,0,0,0,0,0,0,0,848,848,848,848,1,1,1,1,'Dhalmel Leather');
INSERT INTO `synth_recipes` VALUES (651,1,0,0,0,0,0,0,0,40,0,4100,4242,16537,0,0,0,0,0,0,0,848,848,1226,1226,1,1,10,10,'Dhalmel Leather');
INSERT INTO `synth_recipes` VALUES (652,1,0,0,0,0,0,0,0,57,0,4100,4242,16576,0,0,0,0,0,0,0,848,1226,653,653,1,10,2,2,'Dhalmel Leather');
INSERT INTO `synth_recipes` VALUES (653,0,2018,0,0,0,0,0,21,0,0,4103,4245,635,635,635,857,857,857,2129,4509,848,848,848,848,3,3,3,3,'Dhalmel Leather');
INSERT INTO `synth_recipes` VALUES (654,0,0,0,0,0,0,0,21,0,0,4103,4245,635,857,4509,0,0,0,0,0,848,848,848,848,1,1,1,1,'Dhalmel Leather');
INSERT INTO `synth_recipes` VALUES (655,0,0,0,0,0,0,0,21,0,0,4103,4245,695,857,4509,0,0,0,0,0,848,848,848,848,1,1,1,1,'Dhalmel Leather');
INSERT INTO `synth_recipes` VALUES (656,1,0,0,0,0,0,0,36,0,0,4098,4240,510,0,0,0,0,0,0,0,850,850,851,851,1,1,1,1,'Sheep Leather');
INSERT INTO `synth_recipes` VALUES (657,1,0,0,0,0,0,0,2,0,0,4098,4240,511,0,0,0,0,0,0,0,850,850,850,850,1,1,1,1,'Sheep Leather');
INSERT INTO `synth_recipes` VALUES (658,1,0,0,0,0,0,0,33,0,0,4098,4240,1631,0,0,0,0,0,0,0,850,850,851,851,1,1,1,1,'Sheep Leather');
INSERT INTO `synth_recipes` VALUES (659,1,0,0,0,0,0,0,2,0,0,4098,4240,1638,0,0,0,0,0,0,0,850,850,850,850,1,1,1,1,'Sheep Leather');
INSERT INTO `synth_recipes` VALUES (660,1,0,93,0,0,0,0,0,0,0,4100,4242,1388,0,0,0,0,0,0,0,850,940,822,822,1,1,1,1,'Sheep Leather');
INSERT INTO `synth_recipes` VALUES (661,1,0,92,0,0,0,0,0,0,0,4100,4242,1390,0,0,0,0,0,0,0,850,940,822,866,2,1,1,2,'Sheep Leather');
INSERT INTO `synth_recipes` VALUES (662,1,0,8,0,0,0,0,0,0,0,4100,4242,12434,0,0,0,0,0,0,0,850,931,937,937,1,1,1,1,'Sheep Leather');
INSERT INTO `synth_recipes` VALUES (663,1,0,0,87,0,0,0,0,0,0,4100,4242,12436,0,0,0,0,0,0,0,850,850,866,866,1,1,1,2,'Sheep Leather');
INSERT INTO `synth_recipes` VALUES (664,1,0,0,100,0,0,0,0,0,0,4100,4242,12437,0,0,0,0,0,0,0,850,1587,1586,1586,1,1,1,1,'Sheep Leather');
INSERT INTO `synth_recipes` VALUES (665,1,0,0,0,0,0,0,5,0,0,4100,4242,12440,0,0,0,0,0,0,0,850,850,850,850,1,1,1,1,'Sheep Leather');
INSERT INTO `synth_recipes` VALUES (666,1,0,0,0,0,0,0,15,0,0,4100,4242,12441,0,0,0,0,0,0,0,850,852,850,852,1,1,2,2,'Sheep Leather');
INSERT INTO `synth_recipes` VALUES (667,1,0,0,0,0,0,0,24,0,0,4100,4242,12442,0,0,0,0,0,0,0,850,850,651,651,1,1,1,1,'Sheep Leather');
INSERT INTO `synth_recipes` VALUES (668,1,0,0,0,0,0,0,0,58,0,4100,4242,12544,0,0,0,0,0,0,0,850,651,651,651,2,2,3,4,'Sheep Leather');
INSERT INTO `synth_recipes` VALUES (669,1,0,0,0,0,0,0,10,0,0,4100,4242,12568,0,0,0,0,0,0,0,850,850,850,852,1,2,3,1,'Sheep Leather');
INSERT INTO `synth_recipes` VALUES (670,1,0,0,0,0,0,77,0,0,0,4100,4242,12674,0,0,0,0,0,0,0,850,931,931,745,2,2,3,1,'Sheep Leather');
INSERT INTO `synth_recipes` VALUES (671,1,0,0,0,0,0,0,0,84,0,4100,4242,12684,0,0,0,0,0,0,0,850,651,652,654,1,1,1,1,'Sheep Leather');
INSERT INTO `synth_recipes` VALUES (672,1,0,0,0,0,0,0,40,0,0,4100,4242,12699,0,0,0,0,0,0,0,850,851,851,851,2,2,2,2,'Sheep Leather');
INSERT INTO `synth_recipes` VALUES (673,1,0,0,0,0,0,0,88,0,0,4100,4242,12703,0,0,0,0,0,0,0,850,850,851,506,1,2,1,1,'Sheep Leather');
INSERT INTO `synth_recipes` VALUES (674,1,0,0,0,0,0,0,0,54,0,4100,4242,12800,0,0,0,0,0,0,0,850,651,651,651,1,1,1,1,'Sheep Leather');
INSERT INTO `synth_recipes` VALUES (675,1,0,0,0,0,0,0,42,0,0,4100,4242,12955,0,0,0,0,0,0,0,850,850,850,850,3,3,3,3,'Sheep Leather');
INSERT INTO `synth_recipes` VALUES (676,1,0,0,0,17,0,0,0,0,0,4100,4242,12977,0,0,0,0,0,0,0,850,818,818,818,1,7,9,9,'Sheep Leather');
INSERT INTO `synth_recipes` VALUES (677,1,0,0,0,0,0,0,0,0,18,4100,4242,12985,0,0,0,0,0,0,0,850,850,850,850,1,1,1,1,'Sheep Leather');
INSERT INTO `synth_recipes` VALUES (678,1,0,0,0,0,0,0,11,0,0,4100,4242,12992,0,0,0,0,0,0,0,850,850,850,850,1,1,2,2,'Sheep Leather');
INSERT INTO `synth_recipes` VALUES (679,1,0,0,0,0,0,0,29,0,0,4100,4242,12993,0,0,0,0,0,0,0,850,850,848,848,1,1,1,1,'Sheep Leather');
INSERT INTO `synth_recipes` VALUES (680,1,0,0,0,0,0,0,0,53,0,4100,4242,13080,0,0,0,0,0,0,0,850,850,651,651,1,1,1,1,'Sheep Leather');
INSERT INTO `synth_recipes` VALUES (681,1,0,0,79,0,0,0,0,0,0,4100,4242,13108,0,0,0,0,0,0,0,850,850,887,887,1,1,1,1,'Sheep Leather');
INSERT INTO `synth_recipes` VALUES (682,1,0,0,82,0,0,0,0,0,0,4100,4242,13171,0,0,0,0,0,0,0,850,850,850,850,1,1,1,1,'Sheep Leather');
INSERT INTO `synth_recipes` VALUES (683,1,0,0,0,0,0,0,13,0,0,4100,4242,13192,0,0,0,0,0,0,0,850,850,651,651,1,1,1,2,'Sheep Leather');
INSERT INTO `synth_recipes` VALUES (684,1,0,0,0,0,0,0,41,0,0,4100,4242,13203,0,0,0,0,0,0,0,850,924,924,924,1,1,1,1,'Sheep Leather');
INSERT INTO `synth_recipes` VALUES (685,1,0,0,0,0,0,0,57,0,0,4100,4242,13703,0,0,0,0,0,0,0,850,852,851,851,1,3,1,1,'Sheep Leather');
INSERT INTO `synth_recipes` VALUES (686,1,0,0,0,0,0,0,88,0,0,4100,4242,13704,0,0,0,0,0,0,0,850,506,1117,1117,1,1,1,1,'Sheep Leather');
INSERT INTO `synth_recipes` VALUES (687,1,0,0,0,0,0,0,90,0,0,4100,4242,13705,0,0,0,0,0,0,0,850,506,1117,849,1,2,1,1,'Sheep Leather');
INSERT INTO `synth_recipes` VALUES (688,1,0,0,97,0,0,0,0,0,0,4100,4242,13846,0,0,0,0,0,0,0,850,1230,1473,1473,1,6,1,1,'Sheep Leather');
INSERT INTO `synth_recipes` VALUES (689,1,0,0,0,0,0,0,0,29,0,4100,4242,13871,0,0,0,0,0,0,0,850,850,651,651,1,1,1,1,'Sheep Leather');
INSERT INTO `synth_recipes` VALUES (690,1,0,0,91,0,0,0,0,0,0,4100,4242,13922,0,0,0,0,0,0,0,850,886,902,902,1,1,1,1,'Sheep Leather');
INSERT INTO `synth_recipes` VALUES (691,1,0,0,0,0,0,0,93,0,0,4100,4242,13939,0,0,0,0,0,0,0,850,851,851,851,1,1,1,1,'Sheep Leather');
INSERT INTO `synth_recipes` VALUES (692,1,0,0,0,0,0,0,0,31,0,4100,4242,14001,0,0,0,0,0,0,0,850,850,818,651,1,1,1,1,'Sheep Leather');
INSERT INTO `synth_recipes` VALUES (693,1,0,0,0,0,0,0,0,51,0,4100,4242,14003,0,0,0,0,0,0,0,850,850,818,652,1,1,1,1,'Sheep Leather');
INSERT INTO `synth_recipes` VALUES (694,1,0,0,0,0,0,0,0,35,0,4100,4242,14243,0,0,0,0,0,0,0,850,850,850,850,1,1,1,1,'Sheep Leather');
INSERT INTO `synth_recipes` VALUES (695,1,0,0,0,0,0,0,0,55,0,4100,4242,14245,0,0,0,0,0,0,0,850,818,818,818,1,1,1,1,'Sheep Leather');
INSERT INTO `synth_recipes` VALUES (696,1,0,0,0,88,0,0,0,0,0,4100,4242,14253,0,0,0,0,0,0,0,850,816,816,816,1,4,6,8,'Sheep Leather');
INSERT INTO `synth_recipes` VALUES (697,1,0,0,0,97,0,0,0,0,0,4100,4242,14299,0,0,0,0,0,0,0,850,816,851,1228,1,4,1,4,'Sheep Leather');
INSERT INTO `synth_recipes` VALUES (698,1,0,0,0,0,0,0,28,0,0,4100,4242,14323,0,0,0,0,0,0,0,850,819,819,819,1,3,5,5,'Sheep Leather');
INSERT INTO `synth_recipes` VALUES (699,1,0,0,0,0,0,0,0,0,24,4100,4242,17154,0,0,0,0,0,0,0,850,820,820,820,1,1,1,1,'Sheep Leather');
INSERT INTO `synth_recipes` VALUES (700,0,2018,0,0,0,0,0,2,0,0,4103,4245,505,505,505,635,635,635,2129,4509,850,850,850,850,3,3,3,3,'Sheep Leather');
INSERT INTO `synth_recipes` VALUES (701,0,0,0,0,0,0,0,2,0,0,4103,4245,505,635,4509,0,0,0,0,0,850,850,850,850,1,1,1,1,'Sheep Leather');
INSERT INTO `synth_recipes` VALUES (702,0,0,0,0,0,0,0,2,0,0,4103,4245,505,695,4509,0,0,0,0,0,850,850,850,850,1,1,1,1,'Sheep Leather');
INSERT INTO `synth_recipes` VALUES (703,1,0,0,0,0,0,0,35,0,0,4098,4240,1624,0,0,0,0,0,0,0,851,851,851,823,3,3,3,2,'Ram Leather');
INSERT INTO `synth_recipes` VALUES (704,1,0,0,0,0,0,93,0,0,0,4100,4242,1380,0,0,0,0,0,0,0,851,931,745,745,1,2,1,1,'Ram Leather');
INSERT INTO `synth_recipes` VALUES (705,1,0,0,0,0,0,0,0,31,0,4100,4242,12680,0,0,0,0,0,0,0,851,851,651,651,1,2,3,3,'Ram Leather');
INSERT INTO `synth_recipes` VALUES (706,1,0,0,0,0,0,61,0,0,0,4100,4242,12801,0,0,0,0,0,0,0,851,851,653,653,1,1,1,2,'Ram Leather');
INSERT INTO `synth_recipes` VALUES (707,1,0,0,0,0,0,0,74,0,0,4100,4242,12830,0,0,0,0,0,0,0,851,851,855,855,2,3,1,2,'Ram Leather');
INSERT INTO `synth_recipes` VALUES (708,1,0,0,0,0,0,74,0,0,0,4100,4242,12930,0,0,0,0,0,0,0,851,931,931,931,2,3,3,3,'Ram Leather');
INSERT INTO `synth_recipes` VALUES (709,1,0,0,0,0,0,47,0,0,0,4100,4242,12938,0,0,0,0,0,0,0,851,651,651,651,1,1,2,3,'Ram Leather');
INSERT INTO `synth_recipes` VALUES (710,1,0,75,0,0,0,0,0,0,0,4100,4242,12946,0,0,0,0,0,0,0,851,933,937,937,1,1,1,1,'Ram Leather'); -- desynth suzaku's sune-ate (level 75)
INSERT INTO `synth_recipes` VALUES (711,1,0,0,0,0,0,0,0,81,0,4100,4242,13079,0,0,0,0,0,0,0,851,851,654,654,1,1,1,1,'Ram Leather');
INSERT INTO `synth_recipes` VALUES (712,1,0,0,0,0,0,0,70,0,0,4100,4242,13754,0,0,0,0,0,0,0,851,855,855,855,1,1,1,1,'Ram Leather');
INSERT INTO `synth_recipes` VALUES (713,1,0,0,0,94,0,0,0,0,0,4100,4242,14301,0,0,0,0,0,0,0,851,816,816,821,1,3,6,1,'Ram Leather');
INSERT INTO `synth_recipes` VALUES (714,1,0,0,0,0,0,0,94,0,0,4100,4242,14372,0,0,0,0,0,0,0,851,855,1117,823,1,1,1,1,'Ram Leather');
INSERT INTO `synth_recipes` VALUES (715,0,2018,0,0,0,0,0,35,0,0,4103,4245,635,635,635,859,859,859,2129,4509,851,851,851,851,3,3,3,3,'Ram Leather');
INSERT INTO `synth_recipes` VALUES (716,0,0,0,0,0,0,0,35,0,0,4103,4245,635,859,4509,0,0,0,0,0,851,851,851,851,1,1,1,1,'Ram Leather');
INSERT INTO `synth_recipes` VALUES (717,0,0,0,0,0,0,0,36,0,0,4103,4245,695,859,4509,0,0,0,0,0,851,851,851,851,1,1,1,1,'Ram Leather');
INSERT INTO `synth_recipes` VALUES (718,1,0,0,0,0,0,0,0,39,0,4100,4242,12450,0,0,0,0,0,0,0,852,852,651,651,1,2,1,1,'Lizard Skin');
INSERT INTO `synth_recipes` VALUES (719,1,0,0,28,0,0,0,0,0,0,4100,4242,12455,0,0,0,0,0,0,0,852,852,852,852,1,1,1,1,'Lizard Skin');
INSERT INTO `synth_recipes` VALUES (720,1,0,0,36,0,0,0,0,0,0,4100,4242,12583,0,0,0,0,0,0,0,852,889,852,852,1,1,2,3,'Lizard Skin');
INSERT INTO `synth_recipes` VALUES (721,1,0,0,0,0,0,0,0,41,0,4100,4242,12706,0,0,0,0,0,0,0,852,852,651,651,1,1,1,1,'Lizard Skin');
INSERT INTO `synth_recipes` VALUES (722,1,0,0,0,0,0,0,0,45,0,4100,4242,12836,0,0,0,0,0,0,0,852,651,818,818,1,1,3,3,'Lizard Skin');
INSERT INTO `synth_recipes` VALUES (723,1,0,33,0,0,0,0,0,0,0,4100,4242,16387,0,0,0,0,0,0,0,852,850,937,4157,1,2,1,1,'Lizard Skin');
INSERT INTO `synth_recipes` VALUES (724,1,0,0,0,0,0,0,0,51,0,4100,4242,16545,0,0,0,0,0,0,0,852,852,852,852,1,1,1,1,'Lizard Skin');
INSERT INTO `synth_recipes` VALUES (725,1,0,0,0,0,0,0,0,30,0,4100,4242,16896,0,0,0,0,0,0,0,852,852,652,652,1,1,1,1,'Lizard Skin');
INSERT INTO `synth_recipes` VALUES (726,1,0,0,0,0,0,0,0,36,0,4100,4242,16900,0,0,0,0,0,0,0,852,707,651,657,1,1,1,1,'Lizard Skin');
INSERT INTO `synth_recipes` VALUES (727,1,0,0,0,0,0,0,0,43,0,4100,4242,16919,0,0,0,0,0,0,0,852,651,707,657,1,1,1,1,'Lizard Skin');
INSERT INTO `synth_recipes` VALUES (728,1,0,0,0,0,0,75,0,0,0,4100,4242,16962,0,0,0,0,0,0,0,852,657,823,745,1,1,1,1,'Lizard Skin');
INSERT INTO `synth_recipes` VALUES (729,1,0,0,0,0,0,0,12,0,0,4100,4242,19011,0,0,0,0,0,0,0,852,852,852,852,1,1,1,1,'Lizard Skin');
INSERT INTO `synth_recipes` VALUES (730,1,0,0,0,0,0,0,83,0,0,4100,4242,12469,0,0,0,0,0,0,0,855,855,843,1225,1,2,1,4,'Tiger Leather');
INSERT INTO `synth_recipes` VALUES (731,1,0,0,0,0,0,0,0,73,0,4100,4242,12708,0,0,0,0,0,0,0,855,855,654,654,1,1,1,1,'Tiger Leather');
INSERT INTO `synth_recipes` VALUES (732,1,0,0,0,0,0,0,62,0,0,4100,4242,13546,0,0,0,0,0,0,0,855,855,855,855,1,1,1,1,'Tiger Leather');
INSERT INTO `synth_recipes` VALUES (733,1,0,0,0,99,0,0,0,0,0,4100,4242,14376,0,0,0,0,0,0,0,855,821,1235,1228,2,1,4,4,'Tiger Leather');
INSERT INTO `synth_recipes` VALUES (734,0,2018,0,0,0,0,0,61,0,0,4103,4245,635,635,635,861,861,861,2129,4509,855,855,855,855,3,3,3,3,'Tiger Leather');
INSERT INTO `synth_recipes` VALUES (735,0,0,0,0,0,0,0,61,0,0,4103,4245,635,861,4509,0,0,0,0,0,855,855,855,855,1,1,1,1,'Tiger Leather');
INSERT INTO `synth_recipes` VALUES (736,0,0,0,0,0,0,0,61,0,0,4103,4245,695,861,4509,0,0,0,0,0,855,855,855,855,1,1,1,1,'Tiger Leather');
INSERT INTO `synth_recipes` VALUES (737,1,0,0,0,0,0,0,0,0,25,4100,4242,15289,0,0,0,0,0,0,0,856,856,850,850,1,1,3,4,'Rabbit Hide');
INSERT INTO `synth_recipes` VALUES (738,1,0,0,9,0,0,0,0,0,0,4100,4242,16405,0,0,0,0,0,0,0,856,649,880,880,1,1,2,3,'Rabbit Hide');
INSERT INTO `synth_recipes` VALUES (739,1,0,0,0,0,0,0,27,0,0,4100,4242,13588,0,0,0,0,0,0,0,857,857,820,820,1,1,1,1,'Dhalmel Hide');
INSERT INTO `synth_recipes` VALUES (740,1,0,0,0,0,0,0,95,0,0,4100,4242,13918,0,0,0,0,0,0,0,861,820,851,1122,1,1,1,1,'Tiger Hide');
INSERT INTO `synth_recipes` VALUES (741,0,0,0,0,0,0,0,70,0,0,4103,4245,635,860,4509,0,0,0,0,0,862,862,862,862,1,1,1,1,'Behem. Leather');
INSERT INTO `synth_recipes` VALUES (742,0,0,0,0,0,0,0,70,0,0,4103,4245,695,860,4509,0,0,0,0,0,862,862,862,862,1,1,1,1,'Behem. Leather');
INSERT INTO `synth_recipes` VALUES (743,0,0,0,6,0,0,0,0,0,0,4100,4242,4477,0,0,0,0,0,0,0,864,1587,1587,1587,12,1,2,4,'Fish Scales'); -- fish scales (bone 6)
INSERT INTO `synth_recipes` VALUES (744,1,0,0,7,0,0,0,0,0,0,4100,4242,13442,0,0,0,0,0,0,0,864,888,888,888,1,1,1,1,'Fish Scales');
INSERT INTO `synth_recipes` VALUES (745,1,0,0,37,0,0,0,0,0,0,4100,4242,13459,0,0,0,0,0,0,0,864,895,895,895,1,1,1,1,'Fish Scales');
INSERT INTO `synth_recipes` VALUES (746,1,0,0,70,0,0,0,0,0,0,4100,4242,13464,0,0,0,0,0,0,0,864,864,902,902,1,1,1,1,'Fish Scales');
INSERT INTO `synth_recipes` VALUES (747,1,0,0,44,0,0,0,0,0,0,4100,4242,13713,0,0,0,0,0,0,0,864,864,864,864,1,1,1,1,'Fish Scales');
INSERT INTO `synth_recipes` VALUES (748,1,0,0,46,0,0,0,0,0,0,4100,4242,13715,0,0,0,0,0,0,0,864,848,881,881,1,2,1,1,'Fish Scales');
INSERT INTO `synth_recipes` VALUES (749,1,0,99,0,0,0,0,0,0,0,4100,4242,1386,0,0,0,0,0,0,0,866,866,937,937,1,2,1,1,'Wyvern Scales');
INSERT INTO `synth_recipes` VALUES (750,1,0,0,96,0,0,0,0,0,0,4100,4242,14186,0,0,0,0,0,0,0,866,866,1629,1629,1,1,1,2,'Wyvern Scales');
INSERT INTO `synth_recipes` VALUES (751,0,2016,0,0,0,0,0,2,0,0,4103,4245,505,635,1643,1643,1647,4509,0,0,870,870,870,870,1,1,1,1,'Smth. Shp. Lth.');
INSERT INTO `synth_recipes` VALUES (752,0,2016,0,0,0,0,0,2,0,0,4103,4245,505,695,1643,1643,1647,4509,0,0,870,870,870,870,1,1,1,1,'Smth. Shp. Lth.');
INSERT INTO `synth_recipes` VALUES (753,0,2016,0,0,0,0,0,30,0,0,4097,4239,858,1644,1646,1647,0,0,0,0,871,871,871,871,1,1,1,1,'Calig. Wolf Hide');
INSERT INTO `synth_recipes` VALUES (754,0,2017,0,0,0,0,0,21,0,0,4103,4245,635,857,1643,1643,1648,4509,0,0,872,872,872,872,1,1,1,1,'Tgh. Dhal. Lth.');
INSERT INTO `synth_recipes` VALUES (755,0,2017,0,0,0,0,0,21,0,0,4103,4245,695,857,1643,1643,1648,4509,0,0,872,872,872,872,1,1,1,1,'Tgh. Dhal. Lth.');
INSERT INTO `synth_recipes` VALUES (756,0,2016,0,0,0,0,0,35,0,0,4103,4245,635,859,1642,1645,1647,4509,0,0,873,873,873,873,1,1,1,1,'Light Ram Lth.');
INSERT INTO `synth_recipes` VALUES (757,0,2016,0,0,0,0,0,36,0,0,4103,4245,695,859,1642,1645,1647,4509,0,0,873,873,873,873,1,1,1,1,'Light Ram Lth.');
INSERT INTO `synth_recipes` VALUES (758,0,2018,0,0,0,0,0,98,0,0,4103,4245,635,635,635,874,874,874,2129,4509,875,875,875,875,3,3,3,3,'Amaltheia Lth.');
INSERT INTO `synth_recipes` VALUES (759,0,0,0,0,0,0,0,98,0,0,4103,4245,635,874,4509,0,0,0,0,0,875,875,875,875,1,1,1,1,'Amaltheia Lth.');
INSERT INTO `synth_recipes` VALUES (760,0,0,0,0,0,0,0,98,0,0,4103,4245,695,874,4509,0,0,0,0,0,875,875,875,875,1,1,1,1,'Amaltheia Lth.');
INSERT INTO `synth_recipes` VALUES (761,0,2018,0,0,0,0,0,73,0,0,4103,4245,635,635,635,876,876,876,2129,4509,877,877,877,877,3,3,3,3,'Manta Leather');
INSERT INTO `synth_recipes` VALUES (762,0,0,0,0,0,0,0,73,0,0,4103,4245,635,876,4509,0,0,0,0,0,877,877,877,877,1,1,1,1,'Manta Leather');
INSERT INTO `synth_recipes` VALUES (763,0,0,0,0,0,0,0,73,0,0,4103,4245,695,876,4509,0,0,0,0,0,877,877,877,877,1,1,1,1,'Manta Leather');
INSERT INTO `synth_recipes` VALUES (764,1,0,0,0,0,0,0,12,0,0,4098,4240,1196,0,0,0,0,0,0,0,879,879,879,879,1,1,1,1,'Karakul Leather');
INSERT INTO `synth_recipes` VALUES (765,0,2018,0,0,0,0,0,12,0,0,4103,4245,878,878,878,2129,2156,2156,2156,4509,879,879,879,879,3,3,3,3,'Karakul Leather');
INSERT INTO `synth_recipes` VALUES (766,0,0,0,0,0,0,0,12,0,0,4103,4245,878,2156,4509,0,0,0,0,0,879,879,879,879,1,1,1,1,'Karakul Leather');
INSERT INTO `synth_recipes` VALUES (767,1,0,0,18,0,0,0,0,0,0,4100,4242,12454,0,0,0,0,0,0,0,880,880,880,880,1,1,1,1,'Bone Chip');
INSERT INTO `synth_recipes` VALUES (768,1,0,0,4,0,0,0,0,0,0,4100,4242,12505,0,0,0,0,0,0,0,880,880,880,880,1,1,1,1,'Bone Chip');
INSERT INTO `synth_recipes` VALUES (769,1,0,0,20,0,0,0,0,0,0,4100,4242,12710,0,0,0,0,0,0,0,880,880,850,850,1,2,1,2,'Bone Chip');
INSERT INTO `synth_recipes` VALUES (770,1,0,0,12,0,0,0,0,0,0,4100,4242,13321,0,0,0,0,0,0,0,880,650,880,880,1,1,2,2,'Bone Chip');
INSERT INTO `synth_recipes` VALUES (771,1,0,0,17,0,0,0,0,0,0,4100,4242,13441,0,0,0,0,0,0,0,880,880,882,882,1,1,1,1,'Bone Chip');
INSERT INTO `synth_recipes` VALUES (772,1,0,0,40,0,0,0,0,0,0,4100,4242,17026,0,0,0,0,0,0,0,880,880,880,880,2,2,2,2,'Bone Chip'); -- desynth bone cudgel (bone 40)
INSERT INTO `synth_recipes` VALUES (773,1,0,0,73,0,0,0,0,0,0,4100,4242,17501,0,0,0,0,0,0,0,880,880,933,902,1,2,1,1,'Bone Chip');
INSERT INTO `synth_recipes` VALUES (774,1,0,0,42,0,0,0,0,0,0,4100,4242,13461,0,0,0,0,0,0,0,881,1226,653,653,1,4,1,1,'Crab Shell');
INSERT INTO `synth_recipes` VALUES (775,1,0,0,45,0,0,0,0,0,0,4100,4242,13711,0,0,0,0,0,0,0,881,881,848,848,1,1,1,1,'Crab Shell'); -- desynth carapace mask (bone 45) https://www.bg-wiki.com/bg/Carapace_Mask
INSERT INTO `synth_recipes` VALUES (776,1,0,0,50,0,0,0,0,0,0,4100,4242,13712,0,0,0,0,0,0,0,881,881,848,848,1,1,1,2,'Crab Shell');
INSERT INTO `synth_recipes` VALUES (777,1,0,0,68,0,0,0,0,0,0,4100,4242,16420,0,0,0,0,0,0,0,881,893,893,932,1,1,1,1,'Crab Shell');
INSERT INTO `synth_recipes` VALUES (778,1,0,0,53,0,0,0,0,0,0,4100,4242,12506,0,0,0,0,0,0,0,885,885,885,885,1,1,1,1,'Turtle Shell');
INSERT INTO `synth_recipes` VALUES (779,1,0,0,74,0,0,0,0,0,0,4100,4242,12709,0,0,0,0,0,0,0,887,887,506,506,1,1,1,1,'Coral Fragment');
INSERT INTO `synth_recipes` VALUES (780,1,0,0,80,0,0,0,0,0,0,4100,4242,13455,0,0,0,0,0,0,0,887,887,887,887,1,1,1,2,'Coral Fragment');
INSERT INTO `synth_recipes` VALUES (781,1,0,0,77,0,0,0,0,0,0,4100,4242,13850,0,0,0,0,0,0,0,887,887,887,887,1,1,1,1,'Coral Fragment');
INSERT INTO `synth_recipes` VALUES (782,1,0,0,80,0,0,0,0,0,0,4100,4242,15211,0,0,0,0,0,0,0,887,887,792,793,1,1,1,1,'Coral Fragment');
INSERT INTO `synth_recipes` VALUES (783,1,0,0,3,0,0,0,0,0,0,4100,4242,13313,0,0,0,0,0,0,0,888,888,888,888,1,2,2,2,'Seashell'); -- desynth shell earring (bone 3)
INSERT INTO `synth_recipes` VALUES (784,1,0,0,30,0,0,0,0,0,0,4100,4242,12711,0,0,0,0,0,0,0,889,852,852,852,1,1,2,2,'Beetle Shell');
INSERT INTO `synth_recipes` VALUES (785,1,0,0,56,0,0,0,0,0,0,4100,4242,13744,0,0,0,0,0,0,0,889,889,889,889,1,1,1,1,'Beetle Shell');
INSERT INTO `synth_recipes` VALUES (786,1,0,0,0,30,0,0,0,0,0,4100,4242,17405,0,0,0,0,0,0,0,891,840,937,937,1,1,1,1,'Bat Fang');
INSERT INTO `synth_recipes` VALUES (787,1,0,0,23,0,0,0,0,0,0,4100,4242,12415,0,0,0,0,0,0,0,893,893,893,885,1,1,1,1,'Giant Femur');
INSERT INTO `synth_recipes` VALUES (788,1,0,0,52,0,0,0,0,0,0,4100,4242,17257,0,0,0,0,0,0,0,893,893,893,893,1,1,1,1,'Giant Femur');
INSERT INTO `synth_recipes` VALUES (789,1,0,0,0,0,0,67,0,0,0,4100,4242,17516,0,0,0,0,0,0,0,893,932,881,653,1,1,1,1,'Giant Femur');
INSERT INTO `synth_recipes` VALUES (790,1,0,0,41,0,0,0,0,0,0,4100,4242,17610,0,0,0,0,0,0,0,893,893,893,711,1,1,1,1,'Giant Femur');
INSERT INTO `synth_recipes` VALUES (791,1,0,0,31,0,0,0,0,0,0,4100,4242,13090,0,0,0,0,0,0,0,894,894,894,889,1,1,2,1,'Beetle Jaw');
INSERT INTO `synth_recipes` VALUES (792,1,0,0,27,0,0,0,0,0,0,4100,4242,13323,0,0,0,0,0,0,0,894,744,744,744,1,1,2,2,'Beetle Jaw');
INSERT INTO `synth_recipes` VALUES (793,1,0,0,25,0,0,0,0,0,0,4100,4242,13457,0,0,0,0,0,0,0,894,894,894,894,1,1,1,1,'Beetle Jaw');
INSERT INTO `synth_recipes` VALUES (794,1,0,0,0,0,0,0,0,48,0,4100,4242,16412,0,0,0,0,0,0,0,894,894,1226,1226,1,1,4,6,'Beetle Jaw');
INSERT INTO `synth_recipes` VALUES (795,1,0,63,0,0,0,0,0,0,0,4100,4242,16414,0,0,0,0,0,0,0,894,894,894,894,1,1,1,1,'Beetle Jaw');
INSERT INTO `synth_recipes` VALUES (796,1,0,0,47,0,0,0,0,0,0,4100,4242,17352,0,0,0,0,0,0,0,894,895,895,895,1,1,1,1,'Beetle Jaw');
INSERT INTO `synth_recipes` VALUES (797,1,0,0,66,0,0,0,0,0,0,4100,4242,17361,0,0,0,0,0,0,0,894,894,902,902,1,1,1,1,'Beetle Jaw');
INSERT INTO `synth_recipes` VALUES (798,1,0,0,86,0,0,0,0,0,0,4100,4242,17362,0,0,0,0,0,0,0,894,883,883,883,1,1,1,1,'Beetle Jaw');
INSERT INTO `synth_recipes` VALUES (799,1,0,0,0,0,0,59,0,0,0,4100,4242,17514,0,0,0,0,0,0,0,894,894,1235,653,1,1,6,1,'Beetle Jaw');
INSERT INTO `synth_recipes` VALUES (800,1,0,0,59,0,0,0,0,0,0,4100,4242,17612,0,0,0,0,0,0,0,894,894,716,716,1,1,1,1,'Beetle Jaw');
INSERT INTO `synth_recipes` VALUES (801,1,0,0,29,0,0,0,0,0,0,4100,4242,12507,0,0,0,0,0,0,0,895,895,895,895,1,1,1,1,'Ram Horn');
INSERT INTO `synth_recipes` VALUES (802,1,0,0,0,0,0,0,0,78,0,4100,4242,16631,0,0,0,0,0,0,0,895,801,651,651,1,1,1,2,'Ram Horn');
INSERT INTO `synth_recipes` VALUES (803,1,0,0,0,0,0,64,0,0,0,4100,4242,17072,0,0,0,0,0,0,0,895,895,797,797,1,1,1,1,'Ram Horn');
INSERT INTO `synth_recipes` VALUES (804,1,0,0,64,0,0,0,0,0,0,4100,4242,12451,0,0,0,0,0,0,0,896,896,851,851,1,1,1,1,'Scorpion Shell');
INSERT INTO `synth_recipes` VALUES (805,1,0,0,60,0,0,0,0,0,0,4100,4242,13458,0,0,0,0,0,0,0,896,896,896,896,1,1,1,1,'Scorpion Shell');
INSERT INTO `synth_recipes` VALUES (806,1,0,0,88,0,0,0,0,0,0,4100,4242,17166,0,0,0,0,0,0,0,897,897,897,897,1,1,1,1,'Scorpion Claw');
INSERT INTO `synth_recipes` VALUES (807,0,2035,5,0,0,0,0,0,0,0,4096,4238,912,912,912,912,912,912,2131,4509,913,913,913,913,2,4,6,8,'Beeswax');
INSERT INTO `synth_recipes` VALUES (808,0,0,5,0,0,0,0,0,0,0,4096,4238,912,912,912,4509,0,0,0,0,913,913,913,913,1,2,3,4,'Beeswax');
INSERT INTO `synth_recipes` VALUES (809,0,2035,5,0,0,0,0,0,0,0,4096,4238,2131,2164,2164,2164,2164,4509,0,0,913,913,913,913,4,6,8,10,'Beeswax');
INSERT INTO `synth_recipes` VALUES (810,0,0,5,0,0,0,0,0,0,0,4096,4238,2164,2164,4509,0,0,0,0,0,913,913,913,913,2,3,4,5,'Beeswax');
INSERT INTO `synth_recipes` VALUES (811,1,0,0,0,0,0,0,38,0,0,4100,4242,12443,0,0,0,0,0,0,0,913,913,913,913,1,1,1,1,'Beeswax');
INSERT INTO `synth_recipes` VALUES (812,0,0,16,0,0,0,0,0,0,0,4100,4242,4443,4443,4443,4443,0,0,0,0,914,914,914,914,1,2,3,4,'Mercury');
INSERT INTO `synth_recipes` VALUES (813,0,0,17,0,0,0,0,0,0,0,4100,4242,5447,5447,5447,5447,0,0,0,0,914,914,914,914,1,2,3,4,'Mercury'); -- mercury (alch 17)
INSERT INTO `synth_recipes` VALUES (814,1,0,0,0,0,0,0,0,102,0,4100,4242,12676,0,0,0,0,0,0,0,914,1225,654,655,1,6,1,1,'Mercury');
INSERT INTO `synth_recipes` VALUES (815,1,0,0,0,0,0,78,0,0,0,4100,4242,12802,0,0,0,0,0,0,0,914,851,931,745,1,1,1,1,'Mercury');
INSERT INTO `synth_recipes` VALUES (816,1,0,0,0,0,0,59,0,0,0,4100,4242,17284,0,0,0,0,0,0,0,914,652,652,745,1,1,1,1,'Mercury');
INSERT INTO `synth_recipes` VALUES (817,1,0,0,0,0,0,73,0,0,0,4100,4242,17285,0,0,0,0,0,0,0,914,651,745,657,1,1,1,1,'Mercury');
INSERT INTO `synth_recipes` VALUES (818,1,0,0,0,0,0,0,0,0,2,4100,4242,17345,0,0,0,0,0,0,0,917,917,708,708,1,1,1,1,'Parchment');
INSERT INTO `synth_recipes` VALUES (819,1,0,0,0,0,0,0,0,0,20,4100,4242,17347,0,0,0,0,0,0,0,917,917,714,714,1,1,1,1,'Parchment');
INSERT INTO `synth_recipes` VALUES (820,1,0,0,0,0,0,0,0,0,37,4100,4242,17348,0,0,0,0,0,0,0,917,917,716,716,1,1,1,1,'Parchment');
INSERT INTO `synth_recipes` VALUES (821,1,0,0,0,0,0,0,0,0,29,4100,4242,17349,0,0,0,0,0,0,0,917,792,792,792,1,1,1,1,'Parchment');
INSERT INTO `synth_recipes` VALUES (822,0,0,0,0,0,0,0,31,0,0,4103,4245,850,4365,0,0,0,0,0,0,917,917,917,917,1,2,3,4,'Parchment');
INSERT INTO `synth_recipes` VALUES (823,0,0,0,0,0,0,0,31,0,0,4103,4245,879,4365,0,0,0,0,0,0,917,917,917,917,1,1,1,1,'Parchment');
INSERT INTO `synth_recipes` VALUES (824,1,0,0,0,0,0,0,0,0,43,4100,4242,17218,0,0,0,0,0,0,0,927,716,716,716,1,1,1,1,'Coeurl Whisker');
INSERT INTO `synth_recipes` VALUES (825,1,0,0,0,0,0,0,0,0,27,4100,4242,17354,0,0,0,0,0,0,0,927,927,927,927,2,2,2,2,'Coeurl Whisker');
INSERT INTO `synth_recipes` VALUES (826,1,0,0,0,0,0,0,0,0,30,4100,4242,17356,0,0,0,0,0,0,0,927,927,717,797,1,1,1,1,'Coeurl Whisker');
INSERT INTO `synth_recipes` VALUES (827,1,0,0,0,0,0,0,0,0,98,4100,4242,17364,0,0,0,0,0,0,0,927,719,720,720,1,1,1,1,'Coeurl Whisker');
INSERT INTO `synth_recipes` VALUES (828,1,0,0,0,47,0,0,0,0,0,4100,4242,13113,0,0,0,0,0,0,0,929,816,816,816,1,7,8,9,'Black Ink');
INSERT INTO `synth_recipes` VALUES (829,0,0,5,0,0,0,0,0,0,0,4103,4245,635,635,4304,4509,0,0,0,0,929,929,929,929,2,4,6,8,'Black Ink');
INSERT INTO `synth_recipes` VALUES (830,0,0,4,0,0,0,0,0,0,0,4103,4245,635,635,4361,4509,0,0,0,0,929,929,929,929,2,4,6,8,'Black Ink');
INSERT INTO `synth_recipes` VALUES (831,0,0,10,0,0,0,0,0,0,0,4103,4245,635,635,4474,4509,0,0,0,0,929,929,929,929,6,8,10,12,'Black Ink');
INSERT INTO `synth_recipes` VALUES (832,0,0,4,0,0,0,0,0,0,0,4103,4245,635,4509,5128,5128,0,0,0,0,929,929,929,929,2,4,6,8,'Black Ink');
INSERT INTO `synth_recipes` VALUES (833,0,0,4,0,0,0,0,0,0,0,4103,4245,695,4361,4509,0,0,0,0,0,929,929,929,929,2,4,6,8,'Black Ink'); -- Black ink resultQty 2, 4, 6, 8
INSERT INTO `synth_recipes` VALUES (834,0,0,4,0,0,0,0,0,0,0,4103,4245,695,4509,5128,5128,0,0,0,0,929,929,929,929,2,4,6,8,'Black Ink');
INSERT INTO `synth_recipes` VALUES (835,0,0,4,0,0,0,0,0,0,0,4103,4245,695,4509,5448,5448,0,0,0,0,929,929,929,929,2,4,6,8,'Black Ink');
INSERT INTO `synth_recipes` VALUES (836,0,0,4,0,0,0,0,0,0,0,4103,4245,695,4509,5455,0,0,0,0,0,929,929,929,929,2,4,6,8,'Black Ink');
INSERT INTO `synth_recipes` VALUES (837,0,0,5,0,0,0,0,0,0,0,4103,4245,2156,2156,4509,5455,0,0,0,0,929,929,929,929,2,4,6,8,'Black Ink');
INSERT INTO `synth_recipes` VALUES (838,0,0,4,0,0,0,0,0,0,0,4103,4245,2156,4509,5448,5448,0,0,0,0,929,929,929,929,2,4,6,8,'Black Ink');
INSERT INTO `synth_recipes` VALUES (839,0,0,56,0,0,0,0,0,0,0,4096,4238,954,954,954,954,0,0,0,0,931,931,931,931,1,2,3,4,'Cermet Chunk');
INSERT INTO `synth_recipes` VALUES (840,0,0,59,0,0,0,0,0,0,0,4096,4238,955,955,0,0,0,0,0,0,931,931,931,931,1,2,3,4,'Cermet Chunk');
INSERT INTO `synth_recipes` VALUES (841,0,0,60,0,0,0,0,0,0,0,4096,4238,1165,1165,0,0,0,0,0,0,931,931,931,931,1,2,3,4,'Cermet Chunk');
INSERT INTO `synth_recipes` VALUES (842,1,0,0,0,0,0,96,0,0,0,4100,4242,1378,0,0,0,0,0,0,0,931,931,931,931,1,1,1,1,'Cermet Chunk');
INSERT INTO `synth_recipes` VALUES (843,1,0,0,0,0,0,94,0,0,0,4100,4242,1382,0,0,0,0,0,0,0,931,931,931,931,1,2,2,2,'Cermet Chunk');
INSERT INTO `synth_recipes` VALUES (844,1,0,90,0,0,0,0,0,0,0,4100,4242,16578,0,0,0,0,0,0,0,931,931,506,506,2,3,1,1,'Cermet Chunk');
INSERT INTO `synth_recipes` VALUES (845,1,0,89,0,0,0,0,0,0,0,4100,4242,17381,0,0,0,0,0,0,0,931,931,933,932,1,2,1,1,'Cermet Chunk');
INSERT INTO `synth_recipes` VALUES (846,0,0,45,0,0,0,0,0,0,0,4100,4242,928,928,928,928,0,0,0,0,932,932,932,932,3,6,9,12,'Carbon Fiber');
INSERT INTO `synth_recipes` VALUES (847,0,0,46,0,0,0,0,0,0,0,4100,4242,928,1630,0,0,0,0,0,0,932,932,932,932,3,6,9,12,'Carbon Fiber');
INSERT INTO `synth_recipes` VALUES (848,0,0,47,0,0,0,0,0,0,0,4100,4242,2549,0,0,0,0,0,0,0,932,932,932,932,3,6,9,12,'Carbon Fiber');
INSERT INTO `synth_recipes` VALUES (849,1,0,0,0,84,0,0,0,0,0,4100,4242,12504,0,0,0,0,0,0,0,932,932,821,821,1,1,1,1,'Carbon Fiber'); -- desynth rainbow headband (cloth 84) https://www.bg-wiki.com/bg/Rainbow_Headband
INSERT INTO `synth_recipes` VALUES (850,1,0,0,0,0,0,0,0,0,59,4100,4242,17219,0,0,0,0,0,0,0,932,717,1226,1226,1,1,4,6,'Carbon Fiber');
INSERT INTO `synth_recipes` VALUES (851,0,0,62,0,0,0,0,0,0,0,4096,4238,582,0,0,0,0,0,0,0,933,933,933,933,3,6,9,12,'Glass Fiber');
INSERT INTO `synth_recipes` VALUES (852,0,0,61,0,0,0,0,0,0,0,4096,4238,768,768,768,768,768,768,768,768,933,933,933,933,1,2,3,4,'Glass Fiber');
INSERT INTO `synth_recipes` VALUES (853,1,0,21,0,0,0,0,0,0,0,4100,4242,511,0,0,0,0,0,0,0,933,933,933,933,2,4,6,8,'Glass Fiber');
INSERT INTO `synth_recipes` VALUES (854,1,0,23,0,0,0,0,0,0,0,4100,4242,1162,0,0,0,0,0,0,0,933,933,933,933,3,6,9,12,'Glass Fiber');
INSERT INTO `synth_recipes` VALUES (855,1,0,26,0,0,0,0,0,0,0,4100,4242,1624,0,0,0,0,0,0,0,933,933,933,933,4,6,8,10,'Glass Fiber');
INSERT INTO `synth_recipes` VALUES (856,1,0,29,0,0,0,0,0,0,0,4100,4242,1638,0,0,0,0,0,0,0,933,933,933,933,2,4,6,8,'Glass Fiber');
INSERT INTO `synth_recipes` VALUES (857,1,0,53,0,0,0,0,0,0,0,4100,4242,17384,0,0,0,0,0,0,0,933,932,932,932,1,2,3,4,'Glass Fiber');
INSERT INTO `synth_recipes` VALUES (858,1,0,93,0,0,0,0,0,0,0,4100,4242,16861,0,0,0,0,0,0,0,936,715,931,931,1,2,1,2,'Rock Salt');
INSERT INTO `synth_recipes` VALUES (859,0,2035,7,0,0,0,0,0,0,0,4096,4238,856,856,880,880,880,880,2131,4509,937,937,937,937,2,4,6,8,'Animal Glue');
INSERT INTO `synth_recipes` VALUES (860,0,0,7,0,0,0,0,0,0,0,4096,4238,856,880,880,4509,0,0,0,0,937,937,937,937,1,2,3,4,'Animal Glue');
INSERT INTO `synth_recipes` VALUES (861,1,0,51,0,0,0,0,0,0,0,4100,4242,16430,0,0,0,0,0,0,0,937,649,937,937,1,1,1,1,'Animal Glue');
INSERT INTO `synth_recipes` VALUES (862,1,0,13,0,0,0,0,0,0,0,4100,4242,16495,0,0,0,0,0,0,0,937,650,937,937,1,1,1,1,'Animal Glue');
INSERT INTO `synth_recipes` VALUES (863,1,0,46,0,0,0,0,0,0,0,4100,4242,17402,0,0,0,0,0,0,0,937,933,937,937,1,1,1,1,'Animal Glue');
INSERT INTO `synth_recipes` VALUES (864,1,0,0,0,0,0,0,0,51,0,4100,4242,17487,0,0,0,0,0,0,0,937,937,937,937,1,1,1,1,'Animal Glue');
INSERT INTO `synth_recipes` VALUES (865,1,0,45,0,0,0,0,0,0,0,4100,4242,17605,0,0,0,0,0,0,0,937,937,937,937,1,1,1,1,'Animal Glue');
INSERT INTO `synth_recipes` VALUES (866,1,0,15,0,0,0,0,0,0,0,4096,4238,497,0,0,0,0,0,0,0,943,943,943,943,2,4,6,8,'Poison Dust');
INSERT INTO `synth_recipes` VALUES (867,0,0,11,0,0,0,0,0,0,0,4100,4242,925,925,0,0,0,0,0,0,943,943,943,943,1,2,3,4,'Poison Dust');
INSERT INTO `synth_recipes` VALUES (868,0,0,12,0,0,0,0,0,0,0,4100,4242,4403,4403,0,0,0,0,0,0,943,943,943,943,1,2,3,4,'Poison Dust');
INSERT INTO `synth_recipes` VALUES (869,0,0,9,0,0,0,0,0,0,0,4100,4242,4566,4566,0,0,0,0,0,0,943,943,943,943,1,2,3,4,'Poison Dust');
INSERT INTO `synth_recipes` VALUES (870,0,0,61,0,0,0,0,0,0,0,4100,4242,897,897,0,0,0,0,0,0,944,944,944,944,1,2,3,4,'Venom Dust');
INSERT INTO `synth_recipes` VALUES (871,0,0,62,0,0,0,0,0,0,0,4100,4242,4462,0,0,0,0,0,0,0,944,944,944,944,2,4,6,8,'Venom Dust');
INSERT INTO `synth_recipes` VALUES (872,0,0,62,0,0,0,0,0,0,0,4100,4242,4481,4481,0,0,0,0,0,0,944,944,944,944,1,2,3,4,'Venom Dust');
INSERT INTO `synth_recipes` VALUES (873,0,0,62,0,0,0,0,0,0,0,4100,4242,5136,0,0,0,0,0,0,0,944,944,944,944,1,2,3,4,'Venom Dust');
INSERT INTO `synth_recipes` VALUES (874,0,0,72,0,0,0,0,0,0,0,4100,4242,4448,4448,0,0,0,0,0,0,945,945,945,945,1,2,3,4,'Paralysis Dust');
INSERT INTO `synth_recipes` VALUES (875,0,0,72,0,0,0,0,0,0,0,4100,4242,4478,0,0,0,0,0,0,0,945,945,945,945,2,4,6,8,'Paralysis Dust');
INSERT INTO `synth_recipes` VALUES (876,0,2035,40,0,0,0,0,0,0,0,4099,4241,928,928,928,928,1108,1108,2131,0,947,947,947,947,4,8,12,12,'Firesand');
INSERT INTO `synth_recipes` VALUES (877,0,0,39,0,0,0,0,0,0,0,4099,4241,928,928,934,0,0,0,0,0,947,947,947,947,3,6,9,12,'Firesand');
INSERT INTO `synth_recipes` VALUES (878,0,0,40,0,0,0,0,0,0,0,4099,4241,928,928,1108,0,0,0,0,0,947,947,947,947,2,4,6,8,'Firesand');
INSERT INTO `synth_recipes` VALUES (879,0,0,41,0,0,0,0,0,0,0,4099,4241,1108,1630,0,0,0,0,0,0,947,947,947,947,2,4,6,8,'Firesand');
INSERT INTO `synth_recipes` VALUES (880,0,0,42,0,0,0,0,0,0,0,4099,4241,1108,2549,0,0,0,0,0,0,947,947,947,947,4,8,10,12,'Firesand');
INSERT INTO `synth_recipes` VALUES (881,0,0,0,0,0,0,0,0,5,2,4096,4238,649,715,824,0,0,0,0,0,1020,1020,1020,1020,1,2,3,4,'Sickle');
INSERT INTO `synth_recipes` VALUES (882,0,0,0,0,0,0,0,0,8,3,4096,4238,649,649,708,0,0,0,0,0,1021,1021,1021,1021,1,2,3,4,'Hatchet');
INSERT INTO `synth_recipes` VALUES (883,0,0,0,0,0,0,28,0,19,13,4096,4238,648,651,713,0,0,0,0,0,1022,1022,1022,1022,4,4,4,4,'Thiefs Tools');
INSERT INTO `synth_recipes` VALUES (884,0,0,39,0,0,0,0,0,0,0,4101,4243,637,913,920,0,0,0,0,0,1023,1023,1023,1023,2,4,6,8,'Living Key');
INSERT INTO `synth_recipes` VALUES (885,0,0,34,0,0,0,0,0,0,0,4096,4238,933,933,0,0,0,0,0,0,1109,1109,1109,1109,1,1,1,1,'Artificial Lens');
INSERT INTO `synth_recipes` VALUES (886,0,0,0,16,0,0,0,0,0,0,4096,4238,880,880,880,880,4509,0,0,0,1111,1111,1111,1111,1,2,3,4,'Gelatin');
INSERT INTO `synth_recipes` VALUES (887,0,0,0,28,0,0,0,0,0,0,4096,4238,893,4509,0,0,0,0,0,0,1111,1111,1111,1111,4,6,8,10,'Gelatin');
INSERT INTO `synth_recipes` VALUES (888,0,0,0,13,0,0,0,0,0,0,4096,4238,898,898,4509,0,0,0,0,0,1111,1111,1111,1111,1,2,3,4,'Gelatin');
INSERT INTO `synth_recipes` VALUES (889,0,0,34,43,0,0,0,0,0,0,4099,4241,882,891,891,898,932,933,937,939,1115,1115,1115,1115,2,4,6,8,'Skeleton Key');
INSERT INTO `synth_recipes` VALUES (890,0,2018,0,0,0,0,0,80,0,0,4103,4245,635,635,635,1116,1116,1116,2129,4509,1117,1117,1117,1117,3,3,3,3,'Manticore Lth.');
INSERT INTO `synth_recipes` VALUES (891,0,0,0,0,0,0,0,80,0,0,4103,4245,635,1116,4509,0,0,0,0,0,1117,1117,1117,1117,1,1,1,1,'Manticore Lth.');
INSERT INTO `synth_recipes` VALUES (892,0,0,0,0,0,0,0,80,0,0,4103,4245,695,1116,4509,0,0,0,0,0,1117,1117,1117,1117,1,1,1,1,'Manticore Lth.');
INSERT INTO `synth_recipes` VALUES (893,0,0,84,0,0,0,0,0,0,0,4100,4242,4486,0,0,0,0,0,0,0,1133,1133,1133,1133,4,6,9,12,'Dragon Blood');
INSERT INTO `synth_recipes` VALUES (894,0,0,29,0,0,0,0,0,0,45,4100,4242,690,833,4509,0,0,0,0,0,1134,1134,1134,1134,12,12,12,12,'Bast Parchment');
INSERT INTO `synth_recipes` VALUES (895,0,0,0,0,0,0,0,0,0,26,4099,4241,704,824,915,0,0,0,0,0,1161,1161,1161,1161,33,66,99,99,'Uchitake');
INSERT INTO `synth_recipes` VALUES (896,1,0,0,93,0,0,0,0,0,0,4100,4242,14852,0,0,0,0,0,0,0,1163,1622,790,1618,1,1,1,1,'Manticore Hair');
INSERT INTO `synth_recipes` VALUES (897,0,0,6,0,0,0,0,0,0,0,4097,4239,936,4509,4509,0,0,0,0,0,1164,1164,1164,1164,10,20,50,99,'Tsurara');
INSERT INTO `synth_recipes` VALUES (898,0,0,0,0,0,0,0,0,0,39,4099,4241,704,937,1134,0,0,0,0,0,1167,1167,1167,1167,33,66,99,99,'Kawahori-ogi');
INSERT INTO `synth_recipes` VALUES (899,0,0,0,0,0,0,0,0,23,0,4098,4240,674,0,0,0,0,0,0,0,1170,1170,1170,1170,33,66,99,99,'Makibishi');
INSERT INTO `synth_recipes` VALUES (900,0,0,0,0,0,0,31,0,0,0,4096,4238,648,744,0,0,0,0,0,0,1173,1173,1173,1173,33,66,99,99,'Hiraishin');
INSERT INTO `synth_recipes` VALUES (901,0,0,0,0,0,0,0,0,7,34,4099,4241,660,710,4509,0,0,0,0,0,1176,1176,1176,1176,33,66,99,99,'Mizu-deppo');
INSERT INTO `synth_recipes` VALUES (902,0,0,0,0,0,0,0,0,0,29,4098,4240,929,1134,1134,0,0,0,0,0,1179,1179,1179,1179,33,66,99,99,'Shihei');
INSERT INTO `synth_recipes` VALUES (903,0,0,37,0,0,0,0,0,0,0,4103,4245,929,930,1134,0,0,0,0,0,1182,1182,1182,1182,33,66,99,99,'Jusatsu');
INSERT INTO `synth_recipes` VALUES (904,0,0,0,0,29,0,0,0,15,0,4099,4241,649,817,1163,0,0,0,0,0,1185,1185,1185,1185,33,66,99,99,'Kaginawa');
INSERT INTO `synth_recipes` VALUES (905,0,0,28,0,0,11,0,0,0,0,4099,4241,612,928,1134,4570,0,0,0,0,1188,1188,1188,1188,33,66,99,99,'Sairui-ran');
INSERT INTO `synth_recipes` VALUES (906,0,0,19,0,0,0,0,0,0,0,4103,4245,4290,17395,17397,0,0,0,0,0,1191,1191,1191,1191,33,66,99,99,'Kodoku');
INSERT INTO `synth_recipes` VALUES (907,0,0,0,0,34,0,0,0,0,0,4099,4241,817,825,825,834,0,0,0,0,1194,1194,1194,1194,33,66,99,99,'Shinobi-tabi');
INSERT INTO `synth_recipes` VALUES (908,0,0,0,0,0,0,0,0,14,0,4098,4240,649,0,0,0,0,0,0,0,1211,1211,1211,1211,6,8,10,12,'Brz. Bolt Heads');
INSERT INTO `synth_recipes` VALUES (909,0,0,0,0,0,0,0,0,44,0,4098,4240,653,0,0,0,0,0,0,0,1212,1212,1212,1212,6,8,10,12,'Mtl. Bolt Heads');
INSERT INTO `synth_recipes` VALUES (910,0,0,0,0,0,0,0,0,62,0,4098,4240,654,0,0,0,0,0,0,0,1213,1213,1213,1213,6,8,10,12,'Dst. Bolt Heads');
INSERT INTO `synth_recipes` VALUES (911,0,0,0,0,0,0,2,0,0,0,4098,4240,768,768,0,0,0,0,0,0,1214,1214,1214,1214,6,8,10,12,'Stone Arrowhd.');
INSERT INTO `synth_recipes` VALUES (912,0,2026,0,10,0,0,0,0,0,0,4098,4240,880,880,880,880,880,880,2130,0,1215,1215,1215,1215,18,24,30,36,'Bone Arrowhd.'); -- bone arrowhead (bone 10) https://www.bg-wiki.com/index.php?title=Bone_Arrowhd.
INSERT INTO `synth_recipes` VALUES (913,0,0,0,10,0,0,0,0,0,0,4098,4240,880,880,0,0,0,0,0,0,1215,1215,1215,1215,6,8,10,12,'Bone Arrowhd.'); -- bone arrowhead (bone 10) https://www.bg-wiki.com/index.php?title=Bone_Arrowhd.
INSERT INTO `synth_recipes` VALUES (914,0,0,0,0,0,0,0,0,20,0,4098,4240,648,651,0,0,0,0,0,0,1216,1216,1216,1216,6,8,10,12,'Iron Arrowheads');
INSERT INTO `synth_recipes` VALUES (915,0,0,0,0,0,0,27,0,0,0,4098,4240,648,744,0,0,0,0,0,0,1217,1217,1217,1217,6,8,10,12,'Slv. Arrowheads');
INSERT INTO `synth_recipes` VALUES (916,0,0,44,0,0,0,0,0,23,0,4096,4238,637,651,824,0,0,0,0,0,1218,1218,1218,1218,6,8,10,12,'Fire Arrowheads');
INSERT INTO `synth_recipes` VALUES (917,0,0,57,0,0,0,0,0,0,0,4097,4239,648,931,0,0,0,0,0,0,1219,1219,1219,1219,6,8,10,12,'Ice Arrowheads');
INSERT INTO `synth_recipes` VALUES (918,0,0,57,0,0,0,0,0,33,0,4100,4242,648,652,0,0,0,0,0,0,1220,1220,1220,1220,6,8,10,12,'Ltng. Arrowhd.');
INSERT INTO `synth_recipes` VALUES (919,0,2011,0,0,2,0,0,0,0,0,4098,4240,840,840,840,840,840,840,2145,0,1221,1221,1221,1221,18,24,30,36,'Chocobo Fltchg.');
INSERT INTO `synth_recipes` VALUES (920,0,0,0,0,2,0,0,0,0,0,4098,4240,840,840,0,0,0,0,0,0,1221,1221,1221,1221,6,8,10,12,'Chocobo Fltchg.');
INSERT INTO `synth_recipes` VALUES (921,0,2011,0,0,22,0,0,0,0,0,4098,4240,841,841,841,841,841,841,2145,0,1222,1222,1222,1222,18,24,30,36,'Yagudo Fltchg.');
INSERT INTO `synth_recipes` VALUES (922,0,0,0,0,22,0,0,0,0,0,4098,4240,841,841,0,0,0,0,0,0,1222,1222,1222,1222,6,8,10,12,'Yagudo Fltchg.');
INSERT INTO `synth_recipes` VALUES (923,0,2011,0,0,42,0,0,0,0,0,4098,4240,847,847,847,847,847,847,2145,0,1223,1223,1223,1223,18,24,30,36,'Bird Fletchings');
INSERT INTO `synth_recipes` VALUES (924,0,0,0,0,42,0,0,0,0,0,4098,4240,847,847,0,0,0,0,0,0,1223,1223,1223,1223,6,8,10,12,'Bird Fletchings');
INSERT INTO `synth_recipes` VALUES (925,0,2011,0,0,52,0,0,0,0,0,4098,4240,846,846,846,846,846,846,2145,0,1224,1224,1224,1224,18,24,30,36,'Insect Fltchg.');
INSERT INTO `synth_recipes` VALUES (926,0,0,0,0,52,0,0,0,0,0,4098,4240,846,846,0,0,0,0,0,0,1224,1224,1224,1224,6,8,10,12,'Insect Fltchg.');
INSERT INTO `synth_recipes` VALUES (927,0,0,88,0,0,0,0,0,0,0,4096,4238,1309,4149,0,0,0,0,0,0,1225,1225,1225,1225,9,12,12,12,'Gold Nugget');
INSERT INTO `synth_recipes` VALUES (928,0,0,0,0,0,0,54,0,0,0,4096,4238,2305,2305,2305,2305,0,0,0,0,1225,1225,1225,1225,1,1,1,1,'Gold Nugget');
INSERT INTO `synth_recipes` VALUES (929,1,0,0,0,0,0,72,0,0,0,4100,4242,2167,0,0,0,0,0,0,0,1225,1225,1225,2275,1,2,3,1,'Gold Nugget');
INSERT INTO `synth_recipes` VALUES (930,0,0,74,0,0,0,0,0,0,0,4096,4238,1308,4149,0,0,0,0,0,0,1226,1226,1226,1226,9,12,12,12,'Mythril Nugget'); -- mythril nugget (alch 74)
INSERT INTO `synth_recipes` VALUES (931,1,0,0,0,0,0,0,0,30,0,4100,4242,16451,0,0,0,0,0,0,0,1226,1226,1226,1226,6,6,6,6,'Mythril Nugget');
INSERT INTO `synth_recipes` VALUES (932,1,0,0,0,0,0,0,0,63,0,4100,4242,16457,0,0,0,0,0,0,0,1226,1226,1226,1226,4,4,4,4,'Mythril Nugget');
INSERT INTO `synth_recipes` VALUES (933,1,0,0,0,0,0,75,0,0,0,4100,4242,16771,0,0,0,0,0,0,0,1226,1226,1226,1226,1,10,10,10,'Mythril Nugget');
INSERT INTO `synth_recipes` VALUES (934,1,0,0,0,0,0,40,0,0,0,4100,4242,17036,0,0,0,0,0,0,0,1226,1226,653,653,8,10,2,2,'Mythril Nugget');
INSERT INTO `synth_recipes` VALUES (935,0,0,96,0,0,0,0,0,0,0,4096,4238,1310,4149,0,0,0,0,0,0,1227,1227,1227,1227,9,12,12,12,'Platinum Nugget');
INSERT INTO `synth_recipes` VALUES (936,1,0,0,0,0,0,97,0,0,0,4100,4242,12387,0,0,0,0,0,0,0,1228,1228,1229,1229,6,12,6,6,'Dst. Nugget');
INSERT INTO `synth_recipes` VALUES (937,1,0,0,0,94,0,0,0,0,0,4100,4242,13957,0,0,0,0,0,0,0,1228,1228,819,855,4,4,1,1,'Dst. Nugget');
INSERT INTO `synth_recipes` VALUES (938,0,0,11,0,0,0,0,0,0,0,4096,4238,582,4149,0,0,0,0,0,0,1230,1234,1233,1225,12,9,6,3,'Copper Nugget');
INSERT INTO `synth_recipes` VALUES (939,0,0,65,0,0,0,0,0,0,0,4096,4238,1307,4149,0,0,0,0,0,0,1233,1233,1233,1233,9,12,12,12,'Silver Nugget');
INSERT INTO `synth_recipes` VALUES (940,1,0,0,0,0,0,35,0,0,0,4100,4242,2165,0,0,0,0,0,0,0,1233,1225,790,786,1,1,1,1,'Silver Nugget');
INSERT INTO `synth_recipes` VALUES (941,1,0,0,0,0,0,0,0,0,70,4100,4242,12359,0,0,0,0,0,0,0,1234,1234,1234,1234,4,6,6,6,'Iron Nugget');
INSERT INTO `synth_recipes` VALUES (942,1,0,0,0,0,0,50,0,0,0,4100,4242,17986,0,0,0,0,0,0,0,1234,1235,744,744,6,6,1,1,'Iron Nugget');
INSERT INTO `synth_recipes` VALUES (943,1,0,0,0,0,0,0,0,95,0,4100,4242,16707,0,0,0,0,0,0,0,1235,719,1228,1228,6,6,6,8,'Steel Nugget');
INSERT INTO `synth_recipes` VALUES (944,1,0,0,0,0,0,49,0,0,0,4100,4242,17688,0,0,0,0,0,0,0,1235,1235,1235,1235,6,9,9,9,'Steel Nugget');
INSERT INTO `synth_recipes` VALUES (945,1,0,0,0,0,0,69,0,0,0,4100,4242,17701,0,0,0,0,0,0,0,1235,744,744,744,4,1,1,1,'Steel Nugget');
INSERT INTO `synth_recipes` VALUES (946,0,0,31,0,0,0,0,0,14,0,4098,4240,649,937,4163,0,0,0,0,0,1242,1242,1242,1242,6,8,10,12,'Bln. Bolt Heads');
INSERT INTO `synth_recipes` VALUES (947,0,0,45,0,0,0,0,0,14,0,4098,4240,649,937,4171,0,0,0,0,0,1243,1243,1243,1243,6,8,10,12,'Acid Bolt Heads');
INSERT INTO `synth_recipes` VALUES (948,0,0,53,0,0,0,0,0,14,0,4098,4240,649,4154,4154,0,0,0,0,0,1244,1244,1244,1244,6,8,10,12,'Holy Bolt Heads');
INSERT INTO `synth_recipes` VALUES (949,0,0,76,0,0,0,0,0,14,0,4098,4240,649,937,4158,0,0,0,0,0,1245,1245,1245,1245,6,8,10,12,'Vnm. Bolt Heads');
INSERT INTO `synth_recipes` VALUES (950,0,0,81,0,0,0,0,0,14,0,4098,4240,649,930,940,0,0,0,0,0,1246,1246,1246,1246,6,8,10,12,'Bld. Bolt Heads');
INSERT INTO `synth_recipes` VALUES (951,0,0,67,0,0,0,0,0,14,0,4098,4240,649,937,4161,0,0,0,0,0,1247,1247,1247,1247,6,8,10,12,'Slp. Bolt Heads');
INSERT INTO `synth_recipes` VALUES (952,0,2026,0,33,0,0,0,0,0,0,4098,4240,880,880,880,894,894,894,2130,0,1248,1248,1248,1248,18,24,30,36,'Beetle Arrowhd.');
INSERT INTO `synth_recipes` VALUES (953,0,0,0,33,0,0,0,0,0,0,4098,4240,880,894,0,0,0,0,0,0,1248,1248,1248,1248,6,8,10,12,'Beetle Arrowhd.');
INSERT INTO `synth_recipes` VALUES (954,0,2026,0,43,0,0,0,0,0,0,4098,4240,880,880,880,895,895,895,2130,0,1249,1249,1249,1249,18,24,30,36,'Horn Arrowheads');
INSERT INTO `synth_recipes` VALUES (955,0,0,0,43,0,0,0,0,0,0,4098,4240,880,895,0,0,0,0,0,0,1249,1249,1249,1249,6,8,10,12,'Horn Arrowheads');
INSERT INTO `synth_recipes` VALUES (956,0,2026,0,53,0,0,0,0,0,0,4098,4240,880,880,880,897,897,897,2130,0,1250,1250,1250,1250,18,24,30,36,'Scp. Arrowhd.');
INSERT INTO `synth_recipes` VALUES (957,0,0,0,53,0,0,0,0,0,0,4098,4240,880,897,0,0,0,0,0,0,1250,1250,1250,1250,6,8,10,12,'Scp. Arrowhd.');
INSERT INTO `synth_recipes` VALUES (958,0,2026,0,63,0,0,0,0,0,0,4098,4240,880,880,880,902,902,902,2130,0,1251,1251,1251,1251,18,24,30,36,'Demon Arrowhd.');
INSERT INTO `synth_recipes` VALUES (959,0,0,0,63,0,0,0,0,0,0,4098,4240,880,902,0,0,0,0,0,0,1251,1251,1251,1251,6,8,10,12,'Demon Arrowhd.');
INSERT INTO `synth_recipes` VALUES (960,0,0,21,0,0,0,0,0,20,0,4098,4240,648,651,937,4157,0,0,0,0,1252,1252,1252,1252,6,8,10,12,'Poison Arrowhd.');
INSERT INTO `synth_recipes` VALUES (961,0,0,64,43,0,0,0,0,0,0,4098,4240,880,895,937,4161,0,0,0,0,1253,1253,1253,1253,6,8,10,12,'Sleep Arrowhd.');
INSERT INTO `synth_recipes` VALUES (962,0,2011,0,0,72,0,0,0,0,0,4098,4240,845,845,845,845,845,845,2145,0,1254,1254,1254,1254,18,24,30,36,'Blk. Chc. Fltchg.');
INSERT INTO `synth_recipes` VALUES (963,0,0,0,0,72,0,0,0,0,0,4098,4240,845,845,0,0,0,0,0,0,1254,1254,1254,1254,6,8,10,12,'Blk. Chc. Fltchg.');
INSERT INTO `synth_recipes` VALUES (964,0,0,0,0,56,0,0,0,0,0,4100,4242,1295,1295,0,0,0,0,0,0,1278,1278,1278,1278,1,2,3,4,'Twinthread');
INSERT INTO `synth_recipes` VALUES (965,0,1993,0,0,0,0,0,0,90,0,4096,4238,643,646,646,646,1641,1641,1648,0,1284,1284,1284,1284,1,1,1,1,'Inferno Core');
INSERT INTO `synth_recipes` VALUES (966,0,1993,0,0,0,0,0,0,90,0,4096,4238,643,646,646,646,1645,1645,1648,0,1285,1285,1285,1285,1,1,1,1,'Luminous Core');
INSERT INTO `synth_recipes` VALUES (967,0,1993,0,0,0,0,0,0,90,0,4096,4238,643,646,646,646,1644,1644,1648,0,1286,1286,1286,1286,1,1,1,1,'Spirit Core');
INSERT INTO `synth_recipes` VALUES (968,0,1993,0,0,0,0,0,0,90,0,4096,4238,643,646,646,646,1642,1642,1648,0,1287,1287,1287,1287,1,1,1,1,'Frigid Core');
INSERT INTO `synth_recipes` VALUES (969,0,2010,0,0,82,0,0,0,0,0,4100,4242,1270,1270,1270,1270,1270,1270,2128,0,1294,1294,1294,1294,9,9,9,9,'Arachne Thread');
INSERT INTO `synth_recipes` VALUES (970,0,0,0,0,82,0,0,0,0,0,4100,4242,1270,1270,0,0,0,0,0,0,1294,1294,1294,1294,3,3,3,3,'Arachne Thread');
INSERT INTO `synth_recipes` VALUES (971,0,0,0,0,0,0,0,46,0,0,4103,4245,635,1293,4509,0,0,0,0,0,1297,1297,1297,1297,1,1,1,1,'Narasimha Lth.');
INSERT INTO `synth_recipes` VALUES (972,0,0,0,0,0,0,0,47,0,0,4103,4245,695,1293,4509,0,0,0,0,0,1297,1297,1297,1297,1,1,1,1,'Narasimha Lth.');
INSERT INTO `synth_recipes` VALUES (973,0,0,84,0,0,0,0,0,0,0,4102,4244,924,1288,1289,1290,1291,1292,0,0,1298,1298,1298,1298,1,1,1,1,'Hktk. Eye Cluster');
INSERT INTO `synth_recipes` VALUES (974,0,0,0,0,0,0,87,0,0,0,4098,4240,1255,0,0,0,0,0,0,0,1299,1299,1299,1299,1,1,1,1,'Fire Bead');
INSERT INTO `synth_recipes` VALUES (975,0,0,0,0,0,0,87,0,0,0,4098,4240,1256,0,0,0,0,0,0,0,1300,1300,1300,1300,1,1,1,1,'Ice Bead');
INSERT INTO `synth_recipes` VALUES (976,0,0,0,0,0,0,87,0,0,0,4098,4240,1257,0,0,0,0,0,0,0,1301,1301,1301,1301,1,1,1,1,'Wind Bead');
INSERT INTO `synth_recipes` VALUES (977,0,0,0,0,0,0,87,0,0,0,4098,4240,1258,0,0,0,0,0,0,0,1302,1302,1302,1302,1,1,1,1,'Earth Bead');
INSERT INTO `synth_recipes` VALUES (978,0,0,0,0,0,0,87,0,0,0,4098,4240,1259,0,0,0,0,0,0,0,1303,1303,1303,1303,1,1,1,1,'Lightning Bead');
INSERT INTO `synth_recipes` VALUES (979,0,0,0,0,0,0,87,0,0,0,4098,4240,1260,0,0,0,0,0,0,0,1304,1304,1304,1304,1,1,1,1,'Water Bead');
INSERT INTO `synth_recipes` VALUES (980,0,0,0,0,0,0,87,0,0,0,4098,4240,1261,0,0,0,0,0,0,0,1305,1305,1305,1305,1,1,1,1,'Light Bead');
INSERT INTO `synth_recipes` VALUES (981,0,0,0,0,0,0,87,0,0,0,4098,4240,1262,0,0,0,0,0,0,0,1306,1306,1306,1306,1,1,1,1,'Dark Bead');
INSERT INTO `synth_recipes` VALUES (982,0,0,0,0,0,0,0,0,0,97,4099,4241,720,723,937,1415,12459,0,0,0,1344,1345,1345,1345,1,1,1,1,'Cursed Kabuto');
INSERT INTO `synth_recipes` VALUES (983,0,0,0,0,0,0,0,41,0,99,4098,4240,720,720,723,723,855,937,1415,12587,1346,1347,1347,1347,1,1,1,1,'Cursed Togi');
INSERT INTO `synth_recipes` VALUES (984,0,0,0,0,0,0,0,0,0,96,4098,4240,720,723,937,1415,12715,0,0,0,1348,1349,1349,1349,1,1,1,1,'Cursed Kote');
INSERT INTO `synth_recipes` VALUES (985,0,0,0,0,0,0,0,0,0,93,4099,4241,723,937,1415,12843,0,0,0,0,1350,1351,1351,1351,1,1,1,1,'Cursed Haidate');
INSERT INTO `synth_recipes` VALUES (986,0,0,0,0,0,0,0,0,0,94,4098,4240,723,937,1415,12974,0,0,0,0,1352,1353,1353,1353,1,1,1,1,'Cursed Sune-ate');
INSERT INTO `synth_recipes` VALUES (987,0,0,0,0,0,0,26,0,95,0,4096,4238,648,661,665,683,850,0,0,0,1354,1355,1355,1355,1,1,1,1,'Cursed Celata'); -- cursed celata (smith 95 gold 26) https://www.bg-wiki.com/bg/Cursed_Celata
INSERT INTO `synth_recipes` VALUES (988,0,0,0,0,48,0,30,0,96,0,4099,4241,650,665,683,823,830,850,1274,12556,1356,1357,1357,1357,1,1,1,1,'Cursed Hauberk'); -- cursed hauberk (smith 96 cloth 48 gold 30) https://www.bg-wiki.com/bg/Cursed_Hauberk
INSERT INTO `synth_recipes` VALUES (989,0,0,0,0,0,0,23,0,94,0,4099,4241,650,665,12684,0,0,0,0,0,1358,1359,1359,1359,1,1,1,1,'Cursed Mufflers'); -- cursed mufflers (smith 94 gold 23) https://www.bg-wiki.com/bg/Cursed_Mufflers
INSERT INTO `synth_recipes` VALUES (990,0,0,0,0,0,0,0,44,92,0,4099,4241,682,683,826,855,855,0,0,0,1360,1361,1361,1361,1,1,1,1,'Cursed Breeches'); -- cursed breeches (smith 92 leath 44) https://www.bg-wiki.com/bg/Cursed_Breeches
INSERT INTO `synth_recipes` VALUES (991,0,0,0,0,0,0,23,0,93,0,4099,4241,650,665,683,12940,0,0,0,0,1362,1363,1363,1363,1,1,1,1,'Cursed Sollerets'); -- cursed sollerets (smith 93 gold 23) https://www.bg-wiki.com/bg/Cursed_Sollerets
INSERT INTO `synth_recipes` VALUES (992,0,0,0,0,0,0,91,0,0,0,4096,4238,648,745,1313,0,0,0,0,0,1364,1365,1365,1365,1,1,1,1,'Cursed Crown');
INSERT INTO `synth_recipes` VALUES (993,0,0,0,0,100,0,0,60,0,0,4099,4241,761,823,828,828,830,851,862,1409,1366,1367,1367,1367,1,1,1,1,'Cursed Dalmatica'); -- cursed dalmatics (cloth 100 leath 60) https://www.bg-wiki.com/bg/Cursed_Dalmatica
INSERT INTO `synth_recipes` VALUES (994,0,0,0,0,96,0,0,0,0,0,4099,4241,823,827,830,834,1313,0,0,0,1368,1369,1369,1369,1,1,1,1,'Cursed Mitts');
INSERT INTO `synth_recipes` VALUES (995,0,0,0,0,97,0,0,0,0,0,4099,4241,823,828,828,830,1409,0,0,0,1370,1371,1371,1371,1,1,1,1,'Cursed Slacks');
INSERT INTO `synth_recipes` VALUES (996,0,0,0,0,59,0,0,92,0,0,4099,4241,823,828,830,1117,1409,0,0,0,1372,1373,1373,1373,1,1,1,1,'Cursed Pumps'); -- cursed pumps (leath 92 cloth 59) https://www.bg-wiki.com/bg/Cursed_Pumps
INSERT INTO `synth_recipes` VALUES (997,0,0,41,0,0,0,97,0,51,0,4096,4238,648,664,745,754,762,850,931,0,1374,1375,1375,1375,1,1,1,1,'Cursed Schaller');
INSERT INTO `synth_recipes` VALUES (998,0,0,59,0,0,0,98,0,0,0,4096,4238,746,747,754,762,931,931,931,12547,1376,1377,1377,1377,1,1,1,1,'Cursed Cuirass'); -- cursed cuirass (gold 98, alch 59)
INSERT INTO `synth_recipes` VALUES (999,0,0,41,0,0,0,96,0,0,0,4096,4238,746,746,931,12675,0,0,0,0,1378,1379,1379,1379,1,1,1,1,'C. Handschuhs');
INSERT INTO `synth_recipes` VALUES (1000,0,0,41,0,0,0,93,0,0,0,4096,4238,746,754,931,12803,0,0,0,0,1380,1381,1381,1381,1,1,1,1,'Cursed Diechlings');
INSERT INTO `synth_recipes` VALUES (1001,0,0,41,0,0,0,94,0,0,0,4096,4238,746,746,931,931,12931,0,0,0,1382,1383,1383,1383,1,1,1,1,'Cursed Schuhs');
INSERT INTO `synth_recipes` VALUES (1002,0,0,96,0,0,0,0,0,0,0,4103,4245,940,1133,12436,0,0,0,0,0,1384,1385,1385,1385,1,1,1,1,'Cursed Mask');
INSERT INTO `synth_recipes` VALUES (1003,0,0,99,0,0,0,0,0,0,0,4103,4245,940,1133,1133,12564,0,0,0,0,1386,1387,1387,1387,1,1,1,1,'Cursed Mail');
INSERT INTO `synth_recipes` VALUES (1004,0,0,93,0,0,0,0,0,0,0,4103,4245,940,1133,12692,0,0,0,0,0,1388,1389,1389,1389,1,1,1,1,'Cursed Fng. Gnt.');
INSERT INTO `synth_recipes` VALUES (1005,0,0,92,0,0,0,0,0,0,0,4103,4245,940,1133,12820,0,0,0,0,0,1390,1391,1391,1391,1,1,1,1,'Cursed Cuisses');
INSERT INTO `synth_recipes` VALUES (1006,0,0,94,0,0,0,0,0,0,0,4103,4245,940,1133,12948,0,0,0,0,0,1392,1393,1393,1393,1,1,1,1,'Cursed Greaves');
INSERT INTO `synth_recipes` VALUES (1007,0,0,0,97,0,0,0,0,0,0,4099,4241,1312,12452,0,0,0,0,0,0,1394,1395,1395,1395,1,1,1,1,'Cursed Cap');
INSERT INTO `synth_recipes` VALUES (1008,0,0,0,100,0,0,0,41,0,0,4099,4241,855,855,887,1311,1312,0,0,0,1396,1397,1397,1397,1,1,1,1,'Cursed Harness');
INSERT INTO `synth_recipes` VALUES (1009,0,0,0,92,0,0,0,43,0,0,4099,4241,855,866,1312,0,0,0,0,0,1398,1399,1399,1399,1,1,1,1,'Cursed Gloves'); -- cursed gloves (bone 92 leath 43) https://www.bg-wiki.com/bg/Cursed_Gloves
INSERT INTO `synth_recipes` VALUES (1010,0,0,0,91,0,0,0,41,0,0,4099,4241,829,855,1312,0,0,0,0,0,1400,1401,1401,1401,1,1,1,1,'Cursed Subligar');
INSERT INTO `synth_recipes` VALUES (1011,0,0,0,94,0,0,0,44,0,0,4099,4241,855,855,866,1312,0,0,0,0,1402,1403,1403,1403,1,1,1,1,'Cursed Leggings'); -- cursed leggings (bone 94 leather 44) https://www.bg-wiki.com/bg/Cursed_Leggings
INSERT INTO `synth_recipes` VALUES (1012,0,0,0,0,91,0,0,0,0,0,4099,4241,821,821,823,823,1313,1313,0,0,1409,1409,1409,1409,1,1,1,1,'Sirens Macrame');
INSERT INTO `synth_recipes` VALUES (1013,0,0,91,0,0,0,0,0,21,59,4096,4238,643,1448,1448,1448,1448,4370,0,0,1415,1415,1415,1415,2,4,6,8,'Urushi');
INSERT INTO `synth_recipes` VALUES (1014,0,0,0,0,0,0,0,0,79,0,4098,4240,651,657,0,0,0,0,0,0,1416,1416,1416,1416,6,8,10,12,'Kari. Arrowhd.');
INSERT INTO `synth_recipes` VALUES (1015,0,2011,0,0,93,0,0,0,0,0,4098,4240,843,843,843,843,843,843,2145,0,1417,1417,1417,1417,18,24,30,36,'G. Bird Fltchg.');
INSERT INTO `synth_recipes` VALUES (1016,0,0,0,0,93,0,0,0,0,0,4098,4240,843,843,0,0,0,0,0,0,1417,1417,1417,1417,6,8,10,12,'G. Bird Fltchg.');
INSERT INTO `synth_recipes` VALUES (1017,0,0,40,0,0,59,0,0,0,0,4097,4239,1524,1524,1524,1524,1524,1524,1524,1524,1443,1443,1443,1443,1,2,3,4,'Dried Mugwort');
INSERT INTO `synth_recipes` VALUES (1018,0,0,0,0,0,0,0,0,0,97,4101,4243,722,0,0,0,0,0,0,0,1444,1444,1444,1444,4,8,8,8,'Divine Sap');
INSERT INTO `synth_recipes` VALUES (1019,0,1986,0,0,0,0,0,0,0,91,4098,4240,1446,1446,1446,1657,0,0,0,0,1447,1447,1447,1447,3,6,9,12,'Lqr. Tree Lbr.');
INSERT INTO `synth_recipes` VALUES (1020,0,0,0,0,0,0,0,0,0,91,4098,4240,1446,0,0,0,0,0,0,0,1447,1447,1447,1447,1,2,3,4,'Lqr. Tree Lbr.');
INSERT INTO `synth_recipes` VALUES (1021,0,0,0,0,0,0,0,0,0,96,4101,4243,1446,0,0,0,0,0,0,0,1448,1448,1448,1448,4,6,8,10,'Lqr. Tree Sap');
INSERT INTO `synth_recipes` VALUES (1022,0,0,0,94,0,0,0,0,0,0,4098,4240,1517,0,0,0,0,0,0,0,1458,1458,1458,1458,1,1,1,1,'Mammoth Tusk');
INSERT INTO `synth_recipes` VALUES (1023,0,2018,0,0,0,0,0,97,0,0,4103,4245,635,635,635,1516,1516,1516,2129,4509,1459,1459,1459,1459,3,3,3,3,'Griffon Leather');
INSERT INTO `synth_recipes` VALUES (1024,0,0,0,0,0,0,0,97,0,0,4103,4245,635,1516,4509,0,0,0,0,0,1459,1459,1459,1459,1,1,1,1,'Griffon Leather');
INSERT INTO `synth_recipes` VALUES (1025,0,0,0,0,0,0,0,97,0,0,4103,4245,695,1516,4509,0,0,0,0,0,1459,1459,1459,1459,1,1,1,1,'Griffon Leather');
INSERT INTO `synth_recipes` VALUES (1026,0,0,0,0,0,0,0,0,99,0,4096,4238,652,718,1469,0,0,0,0,0,1461,1461,1461,1461,1,1,1,1,'Wootz Ingot');
INSERT INTO `synth_recipes` VALUES (1027,0,1986,0,0,0,0,0,0,0,99,4098,4240,1464,1464,1464,1657,0,0,0,0,1462,1462,1462,1462,3,6,9,12,'Lancewood Lbr.');
INSERT INTO `synth_recipes` VALUES (1028,0,0,0,0,0,0,0,0,0,99,4098,4240,1464,0,0,0,0,0,0,0,1462,1462,1462,1462,1,2,3,4,'Lancewood Lbr.');
INSERT INTO `synth_recipes` VALUES (1029,0,0,0,100,0,0,0,0,0,0,4098,4240,1518,0,0,0,0,0,0,0,1463,1463,1463,1463,1,1,1,1,'Chronos Tooth');
INSERT INTO `synth_recipes` VALUES (1030,0,0,0,0,0,0,0,0,97,0,4096,4238,1466,1466,0,0,0,0,0,0,1467,1467,1467,1467,1,1,1,1,'Relic Steel');
INSERT INTO `synth_recipes` VALUES (1031,0,0,95,0,0,0,0,0,0,0,4101,4243,1520,1521,0,0,0,0,0,0,1468,1468,1468,1468,1,1,2,2,'Marksmans Oil');
INSERT INTO `synth_recipes` VALUES (1032,0,2026,0,38,0,0,0,0,0,0,4098,4240,880,880,880,884,884,884,2130,0,1515,1515,1515,1515,18,24,30,36,'Fang Arrowhd.');
INSERT INTO `synth_recipes` VALUES (1033,0,0,0,38,0,0,0,0,0,0,4098,4240,880,884,0,0,0,0,0,0,1515,1515,1515,1515,6,8,10,12,'Fang Arrowhd.');
INSERT INTO `synth_recipes` VALUES (1034,0,0,0,40,0,0,0,0,0,0,4100,4242,4316,0,0,0,0,0,0,0,1586,1586,1586,1586,1,1,1,1,'Titanictus Shell');
INSERT INTO `synth_recipes` VALUES (1035,0,0,0,40,0,0,0,0,0,0,4100,4242,4476,0,0,0,0,0,0,0,1586,1586,1586,1586,1,2,3,4,'Titanictus Shell');
INSERT INTO `synth_recipes` VALUES (1036,1,0,0,59,0,0,0,0,0,0,4100,4242,17713,0,0,0,0,0,0,0,1622,1622,5135,5135,1,1,1,1,'Bugard Tusk');
INSERT INTO `synth_recipes` VALUES (1037,1,0,0,59,0,0,0,0,0,0,4100,4242,17716,0,0,0,0,0,0,0,1622,1622,5135,5135,1,1,1,1,'Bugard Tusk');
INSERT INTO `synth_recipes` VALUES (1038,0,2026,0,58,0,0,0,0,55,0,4098,4240,652,652,652,1620,1620,1620,2130,0,1627,1627,1627,1627,18,24,30,36,'Arm. Arrowhd.');
INSERT INTO `synth_recipes` VALUES (1039,0,0,0,58,0,0,0,0,55,0,4098,4240,652,1620,0,0,0,0,0,0,1627,1627,1627,1627,6,8,10,12,'Arm. Arrowhd.');
INSERT INTO `synth_recipes` VALUES (1040,1,0,0,92,0,0,0,0,0,0,4100,4242,14305,0,0,0,0,0,0,0,1629,1629,1629,1629,1,1,1,1,'Buffalo Leather');
INSERT INTO `synth_recipes` VALUES (1041,0,2018,0,0,0,0,0,49,0,0,4103,4245,635,635,635,1628,1628,1628,2129,4509,1629,1629,1629,1629,3,3,3,3,'Buffalo Leather');
INSERT INTO `synth_recipes` VALUES (1042,0,0,0,0,0,0,0,49,0,0,4103,4245,635,1628,4509,0,0,0,0,0,1629,1629,1629,1629,1,1,1,1,'Buffalo Leather');
INSERT INTO `synth_recipes` VALUES (1043,0,0,0,0,0,0,0,49,0,0,4103,4245,695,1628,4509,0,0,0,0,0,1629,1629,1629,1629,1,1,1,1,'Buffalo Leather');
INSERT INTO `synth_recipes` VALUES (1044,0,0,0,0,0,0,20,0,0,0,4098,4240,1649,0,0,0,0,0,0,0,1634,1634,1634,1634,1,1,1,1,'Rhodonite');
INSERT INTO `synth_recipes` VALUES (1045,0,0,0,0,0,0,0,0,20,0,4096,4238,640,640,642,1650,0,0,0,0,1635,1635,1635,1635,1,1,1,1,'Paktong Ingot');
INSERT INTO `synth_recipes` VALUES (1046,0,0,0,0,23,0,0,0,0,0,4099,4241,1651,1651,1651,0,0,0,0,0,1636,1636,1636,1636,1,1,1,1,'Moblinweave');
INSERT INTO `synth_recipes` VALUES (1047,0,2018,0,0,0,0,0,24,0,0,4103,4245,635,635,635,1640,1640,1640,2129,4509,1637,1637,1637,1637,3,3,3,3,'Bugard Leather');
INSERT INTO `synth_recipes` VALUES (1048,0,0,0,0,0,0,0,24,0,0,4103,4245,635,1640,4509,0,0,0,0,0,1637,1637,1637,1637,1,1,1,1,'Bugard Leather');
INSERT INTO `synth_recipes` VALUES (1049,0,0,0,0,0,0,0,24,0,0,4103,4245,695,1640,4509,0,0,0,0,0,1637,1637,1637,1637,1,1,1,1,'Bugard Leather');
INSERT INTO `synth_recipes` VALUES (1050,0,2032,75,0,0,0,0,0,0,0,4096,4238,914,936,1108,1606,1606,1606,1606,0,1641,1641,1641,1641,10,20,30,40,'Fire Anima');
INSERT INTO `synth_recipes` VALUES (1051,0,2032,75,0,0,0,0,0,0,0,4097,4239,914,936,1108,1607,1607,1607,1607,0,1642,1642,1642,1642,10,20,30,40,'Ice Anima');
INSERT INTO `synth_recipes` VALUES (1052,0,2032,75,0,0,0,0,0,0,0,4098,4240,914,936,1108,1608,1608,1608,1608,0,1643,1643,1643,1643,10,20,30,40,'Wind Anima');
INSERT INTO `synth_recipes` VALUES (1053,0,2032,75,0,0,0,0,0,0,0,4099,4241,914,936,1108,1609,1609,1609,1609,0,1644,1644,1644,1644,10,20,30,40,'Earth Anima');
INSERT INTO `synth_recipes` VALUES (1054,0,2032,75,0,0,0,0,0,0,0,4100,4242,914,936,1108,1610,1610,1610,1610,0,1645,1645,1645,1645,10,20,30,40,'Lightning Anima');
INSERT INTO `synth_recipes` VALUES (1055,0,2032,75,0,0,0,0,0,0,0,4101,4243,914,936,1108,1611,1611,1611,1611,0,1646,1646,1646,1646,10,20,30,40,'Water Anima');
INSERT INTO `synth_recipes` VALUES (1056,0,2032,75,0,0,0,0,0,0,0,4102,4244,914,936,1108,1612,1612,1612,1612,0,1647,1647,1647,1647,10,20,30,40,'Light Anima');
INSERT INTO `synth_recipes` VALUES (1057,0,2032,75,0,0,0,0,0,0,0,4103,4245,914,936,1108,1613,1613,1613,1613,0,1648,1648,1648,1648,10,20,30,40,'Dark Anima');
INSERT INTO `synth_recipes` VALUES (1058,0,0,0,0,0,0,0,11,4,0,4099,4241,672,850,850,856,0,0,0,0,1655,1655,1655,1655,1,1,1,1,'Leather Pouch');
INSERT INTO `synth_recipes` VALUES (1059,0,0,0,0,0,0,20,0,0,0,4099,4241,661,661,661,937,0,0,0,0,1656,1656,1656,1656,1,1,1,1,'Brass Tank');
INSERT INTO `synth_recipes` VALUES (1060,0,0,0,0,0,65,0,0,0,0,4096,4238,614,623,633,4387,4388,4390,5726,5740,5731,5732,5732,5732,1,1,1,1,'Ratatouille'); -- ratatouille (fixed results) https://www.bg-wiki.com/bg/Ratatouille
INSERT INTO `synth_recipes` VALUES (1061,0,2001,0,0,0,0,89,0,0,0,4096,4238,738,739,739,739,1644,1644,1648,0,1670,1670,1670,1670,1,1,1,1,'Sprt. Orichalcum'); -- spirit orichalcum ingot (gold 89) https://www.bg-wiki.com/bg/Sprt._Orichalcum
INSERT INTO `synth_recipes` VALUES (1062,0,1984,0,0,0,0,0,0,0,8,4098,4240,715,1641,1642,1647,0,0,0,0,1671,1671,1671,1671,1,1,1,1,'Bwtch. Ash Lbr.');
INSERT INTO `synth_recipes` VALUES (1063,0,1984,0,0,0,0,0,0,0,35,4098,4240,716,1642,1644,1647,0,0,0,0,1672,1672,1672,1672,1,1,1,1,'Exor. Oak Lbr.');
INSERT INTO `synth_recipes` VALUES (1064,0,1985,0,0,0,0,0,0,0,35,4098,4240,699,1642,1643,1648,0,0,0,0,1673,1673,1673,1673,1,1,1,1,'Ether. Oak Lbr.');
INSERT INTO `synth_recipes` VALUES (1065,0,2000,0,0,0,0,53,0,0,0,4096,4238,737,737,737,737,1644,1644,1647,0,1674,1674,1674,1674,1,1,1,1,'Indurated Gold');
INSERT INTO `synth_recipes` VALUES (1066,0,2000,0,0,0,0,20,0,0,0,4096,4238,736,736,736,736,1641,1646,1647,0,1675,1675,1675,1675,1,1,1,1,'Neutralizing Slv.');
INSERT INTO `synth_recipes` VALUES (1067,0,2001,0,0,0,0,89,0,0,0,4096,4238,738,739,739,739,1642,1642,1648,0,1676,1676,1676,1676,1,1,1,1,'Frgd. Orichalcum'); -- frigid orichalcum ingot (gold 89) https://www.bg-wiki.com/bg/Frgd._Orichalcum
INSERT INTO `synth_recipes` VALUES (1068,0,2001,0,0,0,0,88,0,0,0,4096,4238,738,739,739,739,1645,1646,1648,0,1677,1677,1677,1677,1,1,1,1,'Aqueous Ocl.'); -- aqueous orichalcum ingot (gold 88) https://www.bg-wiki.com/bg/Aqueous_Ocl.
INSERT INTO `synth_recipes` VALUES (1069,0,2001,0,0,0,0,20,0,0,0,4096,4238,736,736,736,736,1642,1645,1648,0,1678,1678,1678,1678,1,1,1,1,'Rogues Silver');
INSERT INTO `synth_recipes` VALUES (1070,0,2000,0,0,0,0,53,0,0,0,4096,4238,737,737,737,737,1641,1642,1647,0,1679,1679,1679,1679,1,1,1,1,'Bewitched Gold');
INSERT INTO `synth_recipes` VALUES (1071,1,0,0,0,0,0,0,90,0,0,4100,4242,14317,0,0,0,0,0,0,0,1680,816,1629,1629,1,3,1,2,'H.q. Bugard Skin');
INSERT INTO `synth_recipes` VALUES (1072,0,1992,0,0,0,0,0,0,20,0,4096,4238,643,643,643,643,1642,1645,1647,0,1681,1681,1681,1681,1,1,1,1,'Light Steel');
INSERT INTO `synth_recipes` VALUES (1073,0,0,0,0,54,0,0,0,0,0,4099,4241,819,819,1700,0,0,0,0,0,1699,1699,1699,1699,1,1,1,1,'Scarlet Linen');
INSERT INTO `synth_recipes` VALUES (1074,0,2008,0,0,22,0,0,0,0,0,4099,4241,819,819,819,1643,1644,1647,0,0,1701,1701,1701,1701,1,1,1,1,'Fine Linen Cloth');
INSERT INTO `synth_recipes` VALUES (1075,0,2008,0,0,50,0,0,0,0,0,4099,4241,816,818,818,1643,1643,1647,0,0,1702,1702,1702,1702,1,1,1,1,'Smooth Velvet'); -- smooth velvet (cloth 50) https://www.bg-wiki.com/bg/Smooth_Velvet
INSERT INTO `synth_recipes` VALUES (1076,0,2008,0,0,45,0,0,0,0,0,4099,4241,816,820,820,1643,1643,1647,0,0,1702,1702,1702,1702,1,1,1,1,'Smooth Velvet');
INSERT INTO `synth_recipes` VALUES (1077,0,0,0,0,0,0,0,0,90,0,4096,4238,645,1703,1703,1703,0,0,0,0,1704,1704,1704,1704,1,1,1,1,'Kunwu Iron'); -- kunwu iron (smith 90) https://www.bg-wiki.com/bg/Kunwu_Iron
INSERT INTO `synth_recipes` VALUES (1078,0,1995,0,0,0,0,0,0,93,0,4096,4238,1704,1704,1704,1704,1704,1704,2144,0,1705,1705,1705,1705,6,6,6,6,'Kunwu Sheet'); -- kunwu iron sheet
INSERT INTO `synth_recipes` VALUES (1079,0,0,0,0,0,0,0,0,93,0,4096,4238,1704,0,0,0,0,0,0,0,1705,1705,1705,1705,1,1,1,1,'Kunwu Sheet'); -- kunwu iron sheet desynth https://www.bg-wiki.com/bg/Kunwu_Sheet
INSERT INTO `synth_recipes` VALUES (1080,0,0,0,0,0,0,0,0,91,0,4096,4238,643,643,643,647,0,0,0,0,1711,1711,1711,1711,1,1,1,1,'Molybden. Ingot');
INSERT INTO `synth_recipes` VALUES (1081,0,2010,0,0,92,0,0,0,0,0,4100,4242,1712,1712,1712,1712,1712,1712,2128,0,1713,1713,1713,1713,3,3,3,3,'Cashmere Thrd.');
INSERT INTO `synth_recipes` VALUES (1082,0,0,0,0,92,0,0,0,0,0,4100,4242,1712,1712,0,0,0,0,0,0,1713,1713,1713,1713,1,1,1,1,'Cashmere Thrd.');
INSERT INTO `synth_recipes` VALUES (1083,1,0,0,0,65,0,0,0,0,0,4100,4242,15389,0,0,0,0,0,0,0,1713,831,831,831,3,1,1,1,'Cashmere Thrd.');
INSERT INTO `synth_recipes` VALUES (1084,1,0,0,0,43,0,0,0,0,0,4100,4242,15390,0,0,0,0,0,0,0,1713,831,831,831,3,1,1,1,'Cashmere Thrd.');
INSERT INTO `synth_recipes` VALUES (1085,0,0,0,0,95,0,0,0,0,0,4099,4241,1713,1713,1713,0,0,0,0,0,1714,1714,1714,1714,1,1,1,1,'Cashmere Cloth');
INSERT INTO `synth_recipes` VALUES (1086,0,2024,0,71,0,0,0,0,0,0,4098,4240,887,1645,1646,1647,0,0,0,0,1715,1715,1715,1715,1,1,1,1,'Vivified Coral');
INSERT INTO `synth_recipes` VALUES (1087,0,2024,0,25,0,0,0,0,0,0,4098,4240,894,1643,1643,1647,0,0,0,0,1716,1716,1716,1716,1,1,1,1,'Smth. Btl. Jaw');
INSERT INTO `synth_recipes` VALUES (1088,0,2032,85,0,0,0,0,0,0,0,4096,4238,1641,1642,1643,1644,1645,1646,1647,1648,1717,1717,1717,1717,1,1,1,1,'Photoanima');
INSERT INTO `synth_recipes` VALUES (1089,0,0,85,0,0,0,0,0,40,48,4096,4238,647,1448,1448,1448,1448,4370,0,0,1763,1763,1763,1763,1,1,1,1,'Viridian Urushi');
INSERT INTO `synth_recipes` VALUES (1090,0,0,0,0,0,0,0,0,59,0,4098,4240,664,0,0,0,0,0,0,0,1773,1773,1773,1773,1,1,1,1,'Dark Scales');
INSERT INTO `synth_recipes` VALUES (1091,0,2034,40,0,0,0,0,0,0,0,4099,4241,928,928,1108,1641,1646,1648,0,0,1775,1775,1775,1775,2,4,6,8,'Brimsand');
INSERT INTO `synth_recipes` VALUES (1092,0,2034,41,0,0,0,0,0,0,0,4099,4241,1108,1630,1641,1646,1648,0,0,0,1775,1775,1775,1775,2,4,6,8,'Brimsand');
INSERT INTO `synth_recipes` VALUES (1093,0,2041,0,0,0,44,0,0,0,0,4101,4243,936,1840,0,0,0,0,0,0,1776,1776,1776,1776,1,2,3,4,'Spaghetti');
INSERT INTO `synth_recipes` VALUES (1094,0,0,24,0,0,0,0,0,0,0,4096,4238,914,1108,0,0,0,0,0,0,1813,1813,1813,1813,1,1,1,1,'Vrml. Lacquer');
INSERT INTO `synth_recipes` VALUES (1095,0,2034,25,0,0,0,0,0,0,0,4096,4238,914,1108,1645,1646,1647,0,0,0,1814,1814,1814,1814,1,1,1,1,'Ethrl. Vermilion');
INSERT INTO `synth_recipes` VALUES (1096,0,1984,0,0,0,0,0,0,0,72,4098,4240,703,1642,1646,1647,0,0,0,0,1815,1815,1815,1815,1,2,3,4,'Sanctified Lbr.'); -- sanctified lumber (wood 72) https://www.bg-wiki.com/bg/Sanctified_Lbr.
INSERT INTO `synth_recipes` VALUES (1097,0,0,45,0,0,0,73,0,31,0,4096,4238,659,913,1859,1860,0,0,0,0,1823,1823,1823,1823,1,1,1,1,'Shrimp Lantern');
INSERT INTO `synth_recipes` VALUES (1098,0,0,0,0,78,0,0,0,0,18,4098,4240,713,1843,1844,0,0,0,0,0,1824,1824,1824,1824,1,1,1,1,'Haunted Muleta'); -- haunted muleta (cloth 78 wood 18) https://www.bg-wiki.com/bg/Haunted_Muleta
INSERT INTO `synth_recipes` VALUES (1099,0,0,0,70,0,0,0,0,0,0,4099,4241,927,937,1118,1121,1864,1864,0,0,1825,1825,1825,1825,1,1,1,1,'Antlion Trap');
INSERT INTO `synth_recipes` VALUES (1100,0,0,0,0,54,0,57,62,0,0,4099,4241,746,821,823,830,1637,1862,1863,0,1827,1827,1827,1827,1,1,1,1,'Premium Bag'); -- premium bag (leath 62 gold 57 cloth 54) https://www.bg-wiki.com/bg/Premium_Bag
INSERT INTO `synth_recipes` VALUES (1101,0,2010,0,0,15,0,0,0,0,0,4100,4242,1845,1845,1845,1845,1845,1845,2128,0,1828,1828,1828,1828,3,3,3,3,'Red Grs. Thread');
INSERT INTO `synth_recipes` VALUES (1102,0,0,0,0,15,0,0,0,0,0,4100,4242,1845,1845,0,0,0,0,0,0,1828,1828,1828,1828,1,1,1,1,'Red Grs. Thread');
INSERT INTO `synth_recipes` VALUES (1103,1,0,0,0,23,0,0,0,0,0,4100,4242,14053,0,0,0,0,0,0,0,1828,1828,1828,1828,3,3,3,3,'Red Grs. Thread');
INSERT INTO `synth_recipes` VALUES (1104,1,0,0,0,25,0,0,0,0,0,4100,4242,14446,0,0,0,0,0,0,0,1828,1828,851,851,3,7,1,1,'Red Grs. Thread');
INSERT INTO `synth_recipes` VALUES (1105,1,0,0,0,24,0,0,0,0,0,4100,4242,15404,0,0,0,0,0,0,0,1828,1828,818,818,3,4,3,6,'Red Grs. Thread');
INSERT INTO `synth_recipes` VALUES (1106,1,0,0,0,59,0,0,0,0,0,4100,4242,15907,0,0,0,0,0,0,0,1828,1828,1828,1828,2,2,3,3,'Red Grs. Thread'); -- qiqirn sash desynth (cloth 59) http://ffxiclopedia.wikia.com/wiki/Qiqirn_Sash
INSERT INTO `synth_recipes` VALUES (1107,0,0,0,0,16,0,0,0,0,0,4099,4241,1828,1828,1828,0,0,0,0,0,1829,1829,1829,1829,1,1,1,1,'Red Grass Cloth');
INSERT INTO `synth_recipes` VALUES (1108,0,2001,0,0,0,0,20,0,0,0,4098,4240,784,1641,1646,1648,0,0,0,0,1834,1834,1834,1834,1,1,1,1,'Ardent Jadeite');
INSERT INTO `synth_recipes` VALUES (1109,0,2000,0,0,0,0,40,0,0,0,4096,4238,644,644,644,644,1645,1646,1647,0,1835,1835,1835,1835,1,1,1,1,'Vivified Mythril');
INSERT INTO `synth_recipes` VALUES (1110,0,0,0,0,0,0,69,0,0,0,4096,4238,1858,0,0,0,0,0,0,0,1859,1859,1859,1859,1,1,1,1,'Moblumin Sheet');
INSERT INTO `synth_recipes` VALUES (1111,0,0,33,0,0,0,0,0,0,0,4099,4241,1882,1882,1883,1883,1885,1885,1885,0,1860,1860,1860,1860,1,1,1,1,'Moblin Putty');
INSERT INTO `synth_recipes` VALUES (1112,0,2018,0,0,0,0,0,52,0,0,4103,4245,635,635,635,1861,1861,1861,2129,4509,1862,1862,1862,1862,3,3,3,3,'M. Sheep Lth.');
INSERT INTO `synth_recipes` VALUES (1113,0,0,0,0,0,0,0,52,0,0,4103,4245,635,1861,4509,0,0,0,0,0,1862,1862,1862,1862,1,1,1,1,'M. Sheep Lth.');
INSERT INTO `synth_recipes` VALUES (1114,0,0,0,0,0,0,0,52,0,0,4103,4245,695,1861,4509,0,0,0,0,0,1862,1862,1862,1862,1,1,1,1,'M. Sheep Lth.');
INSERT INTO `synth_recipes` VALUES (1115,0,0,0,0,0,0,0,54,0,0,4098,4240,1861,1861,0,0,0,0,0,0,1863,1863,1863,1863,1,1,1,1,'M. Sheep Wool');
INSERT INTO `synth_recipes` VALUES (1116,0,2000,0,0,0,0,63,0,0,0,4096,4238,738,738,738,738,1643,1646,1647,0,1879,1879,1879,1879,1,1,1,1,'Vivio Platinum'); -- vivio platinum ingot (gold 63) https://www.bg-wiki.com/bg/Vivio_Platinum
INSERT INTO `synth_recipes` VALUES (1117,0,0,0,0,0,0,0,0,0,5,4099,4241,8805,0,0,0,0,0,0,0,2775,2775,2775,2775,1,1,1,1,'Padded Box'); -- padded box (kit)
INSERT INTO `synth_recipes` VALUES (1118,0,0,0,0,19,0,0,0,0,0,4101,4243,835,835,0,0,0,0,0,0,1882,1882,1882,1882,1,2,3,4,'Flaxseed Oil');
INSERT INTO `synth_recipes` VALUES (1119,0,0,0,1,0,0,0,0,0,0,4098,4240,888,888,888,0,0,0,0,0,1883,1883,1883,1883,1,2,3,4,'Shell Powder');
INSERT INTO `synth_recipes` VALUES (1120,0,0,0,5,0,0,0,0,0,0,4098,4240,5131,5131,0,0,0,0,0,0,1883,1883,1883,1883,1,2,3,4,'Shell Powder'); -- shell powder (bone 5) https://www.bg-wiki.com/bg/Shell_Powder
INSERT INTO `synth_recipes` VALUES (1121,0,0,0,0,0,0,1,0,0,0,4096,4238,642,642,642,0,0,0,0,0,1884,1884,1884,1884,1,1,1,1,'Zinc Oxide');
INSERT INTO `synth_recipes` VALUES (1122,0,0,30,0,0,0,0,0,0,0,4099,4241,1882,1882,1883,1883,1884,0,0,0,1886,1886,1886,1886,1,1,1,1,'Sieglinde Putty');
INSERT INTO `synth_recipes` VALUES (1123,0,0,56,0,0,0,0,0,0,0,4096,4238,936,1883,1888,1888,1888,1888,1888,1888,1887,1887,1887,1887,1,2,3,4,'Glass Sheet');
INSERT INTO `synth_recipes` VALUES (1124,0,0,77,0,0,0,0,0,0,0,4101,4243,1888,1890,1892,4154,0,0,0,0,1895,1895,1895,1895,1,1,1,1,'Freshwater Set');
INSERT INTO `synth_recipes` VALUES (1125,0,0,82,0,0,0,0,0,0,0,4101,4243,1889,1891,1893,4154,0,0,0,0,1896,1896,1896,1896,1,1,1,1,'Saltwater Set');
INSERT INTO `synth_recipes` VALUES (1126,0,0,0,0,0,0,60,0,0,0,4098,4240,648,745,0,0,0,0,0,0,1961,1961,1961,1961,6,8,10,12,'Gold Arrowheads');
INSERT INTO `synth_recipes` VALUES (1127,0,0,0,0,0,0,70,0,0,0,4098,4240,648,746,0,0,0,0,0,0,1962,1962,1962,1962,6,8,10,12,'Plt. Arrowheads');
INSERT INTO `synth_recipes` VALUES (1128,0,2008,0,0,12,0,0,0,0,0,4099,4241,818,818,818,1644,1646,1647,0,0,1963,1963,1963,1963,1,1,1,1,'Mag. Ctn. Cloth');
INSERT INTO `synth_recipes` VALUES (1129,0,2008,0,0,22,0,0,0,0,0,4099,4241,819,819,819,1644,1646,1647,0,0,1964,1964,1964,1964,1,1,1,1,'Mag. Lin. Cloth');
INSERT INTO `synth_recipes` VALUES (1130,0,2008,0,0,53,0,0,0,0,0,4099,4241,816,816,816,1644,1646,1647,0,0,1965,1965,1965,1965,1,1,1,1,'Mag. Silk Cloth');
INSERT INTO `synth_recipes` VALUES (1131,0,2008,0,0,58,0,41,0,0,0,4099,4241,745,816,1646,1646,1647,0,0,0,1966,1966,1966,1966,2,4,6,8,'Brl. Gold Thread');
INSERT INTO `synth_recipes` VALUES (1132,0,2008,0,0,58,0,41,0,0,0,4099,4241,745,816,1642,1642,1647,0,0,0,1967,1967,1967,1967,2,4,6,8,'Dull Gold Thread');
INSERT INTO `synth_recipes` VALUES (1133,0,2008,0,0,58,0,41,0,0,0,4099,4241,745,816,1647,1647,1647,0,0,0,1968,1968,1968,1968,2,4,6,8,'Sh. Gold Thread');
INSERT INTO `synth_recipes` VALUES (1134,0,2016,0,0,0,0,0,24,0,0,4103,4245,635,1640,1641,1641,1647,4509,0,0,1969,1969,1969,1969,1,1,1,1,'R. Bgd. Leather');
INSERT INTO `synth_recipes` VALUES (1135,0,2016,0,0,0,0,0,24,0,0,4103,4245,695,1640,1641,1641,1647,4509,0,0,1969,1969,1969,1969,1,1,1,1,'R. Bgd. Leather');
INSERT INTO `synth_recipes` VALUES (1136,0,2016,0,0,0,0,0,24,0,0,4103,4245,635,1640,1644,1644,1647,4509,0,0,1970,1970,1970,1970,1,1,1,1,'T. Bgd. Leather');
INSERT INTO `synth_recipes` VALUES (1137,0,2016,0,0,0,0,0,24,0,0,4103,4245,695,1640,1644,1644,1647,4509,0,0,1970,1970,1970,1970,1,1,1,1,'T. Bgd. Leather');
INSERT INTO `synth_recipes` VALUES (1138,0,2016,0,0,0,0,0,24,0,0,4103,4245,635,1640,1645,1645,1647,4509,0,0,1971,1971,1971,1971,1,1,1,1,'S. Bgd. Leather');
INSERT INTO `synth_recipes` VALUES (1139,0,2016,0,0,0,0,0,24,0,0,4103,4245,635,1640,1643,1643,1647,4509,0,0,1972,1972,1972,1972,1,1,1,1,'G. Bgd. Leather');
INSERT INTO `synth_recipes` VALUES (1140,0,2016,0,0,0,0,0,24,0,0,4103,4245,695,1640,1643,1643,1647,4509,0,0,1972,1972,1972,1972,1,1,1,1,'G. Bgd. Leather');
INSERT INTO `synth_recipes` VALUES (1141,0,2024,0,16,0,0,0,0,0,0,4098,4240,893,1643,1646,1647,0,0,0,0,1973,1973,1973,1973,1,1,1,1,'Vivio Femur'); -- vivio femur (bone 16) https://www.bg-wiki.com/bg/Vivio_Femur
INSERT INTO `synth_recipes` VALUES (1142,0,2024,0,41,0,0,0,0,0,0,4098,4240,881,1643,1646,1647,0,0,0,0,1974,1974,1974,1974,1,1,1,1,'Vivio Crab Shell');
INSERT INTO `synth_recipes` VALUES (1143,0,2024,0,50,0,0,0,0,0,0,4098,4240,897,1643,1646,1647,0,0,0,0,1975,1975,1975,1975,1,1,1,1,'Vi. Scorpion Claw');
INSERT INTO `synth_recipes` VALUES (1144,0,2024,0,73,0,0,0,0,0,0,4098,4240,866,1643,1646,1647,0,0,0,0,1976,1976,1976,1976,1,1,1,1,'Vi. Wyv. Scale');
INSERT INTO `synth_recipes` VALUES (1145,0,2016,0,0,0,0,0,2,0,0,4103,4245,505,635,1643,1646,1647,4509,0,0,1977,1977,1977,1977,1,1,1,1,'Vi. Sh. Leather');
INSERT INTO `synth_recipes` VALUES (1146,0,2016,0,0,0,0,0,2,0,0,4103,4245,505,695,1643,1646,1647,4509,0,0,1977,1977,1977,1977,1,1,1,1,'Vi. Sh. Leather');
INSERT INTO `synth_recipes` VALUES (1147,0,2016,0,0,0,0,0,35,0,0,4103,4245,635,859,1644,1645,1647,4509,0,0,1978,1978,1978,1978,1,1,1,1,'Bld. Ram Lthr.');
INSERT INTO `synth_recipes` VALUES (1148,0,2016,0,0,0,0,0,36,0,0,4103,4245,695,859,1644,1645,1647,4509,0,0,1978,1978,1978,1978,1,1,1,1,'Bld. Ram Lthr.');
INSERT INTO `synth_recipes` VALUES (1149,0,0,0,0,0,0,0,0,74,0,4096,4238,640,640,641,645,0,0,0,0,1989,1989,1989,1989,1,1,1,1,'Dark Bronze');
INSERT INTO `synth_recipes` VALUES (1150,0,1995,0,0,0,0,0,0,75,0,4096,4238,1989,1989,1989,1989,1989,1989,2144,0,1990,1990,1990,1990,6,6,6,6,'Drk. Brz. Sheet');
INSERT INTO `synth_recipes` VALUES (1151,0,0,0,0,0,0,0,0,75,0,4096,4238,1989,0,0,0,0,0,0,0,1990,1990,1990,1990,1,1,1,1,'Drk. Brz. Sheet');
INSERT INTO `synth_recipes` VALUES (1152,0,0,0,0,76,0,0,0,0,0,4099,4241,816,816,821,821,822,822,0,0,1991,1991,1991,1991,1,1,1,1,'Silver Brocade');
INSERT INTO `synth_recipes` VALUES (1153,0,0,87,0,0,0,0,0,0,0,4102,4244,851,4154,0,0,0,0,0,0,1992,1992,1992,1992,1,1,1,1,'Holy Leather');
INSERT INTO `synth_recipes` VALUES (1154,0,0,91,0,0,0,0,0,0,0,4101,4243,622,622,622,851,935,953,4509,0,1993,1993,1993,1993,1,1,1,1,'Ether Leather');
INSERT INTO `synth_recipes` VALUES (1155,0,0,91,0,0,0,0,0,0,0,4101,4243,622,622,622,825,935,953,4509,0,1994,1994,1994,1994,1,1,1,1,'Ether Cotton');
INSERT INTO `synth_recipes` VALUES (1156,0,0,91,0,0,0,0,0,0,0,4101,4243,622,622,622,714,935,953,4509,0,1995,1995,1995,1995,1,1,1,1,'Ether Holly');
INSERT INTO `synth_recipes` VALUES (1157,0,0,0,0,79,0,0,0,0,0,4099,4241,816,821,821,0,0,0,0,0,1996,1996,1996,1996,1,1,1,1,'Rainbow Velvet');
INSERT INTO `synth_recipes` VALUES (1158,0,0,0,0,69,0,0,0,0,0,4099,4241,817,817,817,817,817,821,0,0,1997,1997,1997,1997,1,1,1,1,'Sailcloth');
INSERT INTO `synth_recipes` VALUES (1159,0,0,43,0,0,0,0,65,0,0,4103,4245,505,635,1633,4509,0,0,0,0,1998,1998,1998,1998,1,1,1,1,'Sheep Chammy');
INSERT INTO `synth_recipes` VALUES (1160,0,0,43,0,0,0,0,65,0,0,4103,4245,505,695,1633,4509,0,0,0,0,1998,1998,1998,1998,1,1,1,1,'Sheep Chammy'); -- sheep chammy (leather 65, alch 43)
INSERT INTO `synth_recipes` VALUES (1161,0,0,0,0,86,0,0,0,0,0,4099,4241,816,816,821,821,823,823,0,0,1999,1999,1999,1999,1,1,1,1,'Gold Brocade');
INSERT INTO `synth_recipes` VALUES (1162,0,0,0,0,0,0,0,0,86,0,4096,4238,643,645,645,646,0,0,0,0,2000,2000,2000,2000,1,1,1,1,'Dark Adaman');
INSERT INTO `synth_recipes` VALUES (1163,0,1995,0,0,0,0,0,0,89,0,4096,4238,2000,2000,2000,2000,2000,2000,2144,0,2001,2001,2001,2001,6,6,6,6,'Drk. Adm. Sheet');
INSERT INTO `synth_recipes` VALUES (1164,0,0,0,0,0,0,0,0,89,0,4096,4238,2000,0,0,0,0,0,0,0,2001,2001,2001,2001,1,1,1,1,'Drk. Adm. Sheet');
INSERT INTO `synth_recipes` VALUES (1165,0,0,0,69,0,0,0,0,0,0,4098,4240,895,895,0,0,0,0,0,0,2002,2002,2002,2002,1,1,1,1,'Beast Horn');
INSERT INTO `synth_recipes` VALUES (1166,0,0,0,0,0,0,0,67,0,0,4103,4245,635,859,1883,1883,4509,0,0,0,2003,2003,2003,2003,1,1,1,1,'White Mouton');
INSERT INTO `synth_recipes` VALUES (1167,0,0,0,0,0,0,0,67,0,0,4103,4245,695,859,1883,1883,4509,0,0,0,2003,2003,2003,2003,1,1,1,1,'White Mouton');
INSERT INTO `synth_recipes` VALUES (1168,0,0,0,21,0,0,0,0,0,0,4098,4240,889,889,0,0,0,0,0,0,2004,2004,2004,2004,1,1,1,1,'Carap. Powder');
INSERT INTO `synth_recipes` VALUES (1169,0,0,0,0,63,0,0,0,0,0,4099,4241,818,818,818,2004,4509,0,0,0,2005,2005,2005,2005,1,1,1,1,'Hunters Cotton');
INSERT INTO `synth_recipes` VALUES (1170,0,0,0,0,0,0,0,0,60,0,4098,4240,664,664,0,0,0,0,0,0,2006,2006,2006,2006,1,1,1,1,'Iyo Scale');
INSERT INTO `synth_recipes` VALUES (1171,0,0,9,0,0,0,0,53,0,0,4099,4241,937,1629,4509,0,0,0,0,0,2007,2007,2007,2007,1,1,1,1,'Lm. Bf. Leather');
INSERT INTO `synth_recipes` VALUES (1172,0,0,0,0,0,0,0,0,36,0,4096,4238,1681,0,0,0,0,0,0,0,2008,2008,2008,2008,1,1,1,1,'Lt. Steel Sheet');
INSERT INTO `synth_recipes` VALUES (1173,0,0,0,62,0,0,0,0,0,0,4098,4240,1311,0,0,0,0,0,0,0,2009,2009,2009,2009,1,1,1,1,'Coral Horn'); -- coral horn (bone 62) https://www.bg-wiki.com/bg/Coral_Horn
INSERT INTO `synth_recipes` VALUES (1174,0,0,0,0,75,0,0,0,0,0,4096,4238,832,832,832,1163,2011,2011,2011,4509,2010,2010,2010,2010,1,1,1,1,'Wolf Felt');
INSERT INTO `synth_recipes` VALUES (1175,0,0,0,0,0,0,0,19,0,0,4098,4240,858,858,858,0,0,0,0,0,2011,2011,2011,2011,1,1,1,1,'Wolf Fur');
INSERT INTO `synth_recipes` VALUES (1176,0,0,10,0,0,0,0,39,0,0,4099,4241,851,937,4509,0,0,0,0,0,2012,2012,2012,2012,1,1,1,1,'Lm. Rm. Leather');
INSERT INTO `synth_recipes` VALUES (1177,0,0,20,0,0,0,0,0,0,0,4096,4238,1893,4509,0,0,0,0,0,0,2109,2109,2109,2109,6,8,10,12,'Bittern');
INSERT INTO `synth_recipes` VALUES (1178,0,0,22,0,0,0,0,0,0,0,4100,4242,936,5165,0,0,0,0,0,0,2113,2113,2113,2113,6,8,10,12,'Baking Soda');
INSERT INTO `synth_recipes` VALUES (1179,0,0,0,0,0,0,0,72,0,0,4103,4245,635,2121,4509,0,0,0,0,0,2122,2122,2122,2122,1,1,1,1,'Ovinnik Leather');
INSERT INTO `synth_recipes` VALUES (1180,0,0,0,0,0,0,0,72,0,0,4103,4245,695,2121,4509,0,0,0,0,0,2122,2122,2122,2122,1,1,1,1,'Ovinnik Leather');
INSERT INTO `synth_recipes` VALUES (1181,0,2018,0,0,0,0,0,58,0,0,4103,4245,635,635,635,2123,2123,2123,2129,4509,2124,2124,2124,2124,3,3,3,3,'Catobl. Leather');
INSERT INTO `synth_recipes` VALUES (1182,0,0,0,0,0,0,0,58,0,0,4103,4245,635,2123,4509,0,0,0,0,0,2124,2124,2124,2124,1,1,1,1,'Catobl. Leather');
INSERT INTO `synth_recipes` VALUES (1183,0,0,0,0,0,0,0,58,0,0,4103,4245,695,2123,4509,0,0,0,0,0,2124,2124,2124,2124,1,1,1,1,'Catobl. Leather');
INSERT INTO `synth_recipes` VALUES (1184,0,0,34,0,0,0,0,78,0,0,4103,4245,635,859,2126,2126,4509,0,0,0,2125,2125,2125,2125,1,1,1,1,'Yellow Mouton'); -- yellow mouton (leather 78, alchemy ~34) http://ffxiclopedia.wikia.com/wiki/Yellow_Mouton
INSERT INTO `synth_recipes` VALUES (1185,0,0,34,0,0,0,0,78,0,0,4103,4245,695,859,2126,2126,4509,0,0,0,2125,2125,2125,2125,1,1,1,1,'Yellow Mouton'); -- yellow mouton (leather 78, alchemy ~34) http://ffxiclopedia.wikia.com/wiki/Yellow_Mouton
INSERT INTO `synth_recipes` VALUES (1186,0,1984,0,0,0,0,0,0,0,13,4098,4240,695,1644,1646,1647,0,0,0,0,2132,2132,2132,2132,1,1,1,1,'M. Will. Lumber');
INSERT INTO `synth_recipes` VALUES (1187,0,1984,0,0,0,0,0,0,0,28,4098,4240,694,1644,1646,1647,0,0,0,0,2133,2133,2133,2133,1,1,1,1,'M. Ches. Lumber');
INSERT INTO `synth_recipes` VALUES (1188,0,1992,0,0,0,0,0,0,20,0,4096,4238,643,643,643,643,1644,1645,1647,0,2134,2135,2135,2135,1,1,1,1,'Lucent Iron');
INSERT INTO `synth_recipes` VALUES (1189,0,2001,0,0,0,0,20,0,0,0,4098,4240,807,1641,1644,1648,0,0,0,0,2136,2136,2136,2136,1,1,1,1,'Mighty Sardonyx');
INSERT INTO `synth_recipes` VALUES (1190,0,2001,0,0,0,0,20,0,0,0,4098,4240,800,1644,1645,1648,0,0,0,0,2137,2137,2137,2137,1,1,1,1,'Vision Amethyst');
INSERT INTO `synth_recipes` VALUES (1191,0,2009,0,0,12,0,0,0,0,0,4099,4241,818,818,818,1644,1646,1648,0,0,2138,2138,2138,2138,1,1,1,1,'Al. Cotton Cloth');
INSERT INTO `synth_recipes` VALUES (1192,0,2017,0,0,0,0,0,21,0,0,4101,4243,857,1643,1644,1648,0,0,0,0,2139,2139,2139,2139,1,1,1,1,'Fr. Dhalmel Hide');
INSERT INTO `synth_recipes` VALUES (1193,0,2017,0,0,0,0,0,36,0,0,4101,4243,859,1643,1644,1648,0,0,0,0,2140,2140,2140,2140,1,1,1,1,'Fragrant Ram Skin');
INSERT INTO `synth_recipes` VALUES (1194,0,2025,0,1,0,0,0,0,0,0,4098,4240,880,1642,1644,1648,0,0,0,0,2141,2141,2141,2141,1,1,1,1,'Wail. Bone Chip');
INSERT INTO `synth_recipes` VALUES (1195,0,2025,0,27,0,0,0,0,0,0,4098,4240,895,1642,1644,1648,0,0,0,0,2142,2142,2142,2142,1,1,1,1,'Wailing Ram Horn');
INSERT INTO `synth_recipes` VALUES (1196,1,0,0,0,0,0,0,86,0,0,4100,4242,16167,0,0,0,0,0,0,0,2152,2152,2152,2152,1,1,1,1,'Marid Leather');
INSERT INTO `synth_recipes` VALUES (1197,0,2018,0,0,0,0,0,76,0,0,4103,4245,2129,2151,2151,2151,2156,2156,2156,4509,2152,2152,2152,2152,3,3,3,3,'Marid Leather');
INSERT INTO `synth_recipes` VALUES (1198,0,0,0,0,0,0,0,76,0,0,4103,4245,2151,2156,4509,0,0,0,0,0,2152,2152,2152,2152,1,1,1,1,'Marid Leather');
INSERT INTO `synth_recipes` VALUES (1199,1,0,0,85,0,0,0,0,0,0,4100,4242,17849,0,0,0,0,0,0,0,2157,2157,2171,2171,1,1,1,1,'Imp Horn');
INSERT INTO `synth_recipes` VALUES (1200,0,0,0,0,0,0,0,81,0,0,4103,4245,2156,2169,4509,0,0,0,0,0,2170,2170,2170,2170,1,1,1,1,'Cerber. Leather'); -- cerberus leather (leath 81) https://www.bg-wiki.com/bg/Cerber._Leather
INSERT INTO `synth_recipes` VALUES (1201,0,0,17,0,0,0,0,0,0,0,4102,4244,914,2316,4104,0,0,0,0,0,2176,2176,2176,2176,33,66,99,99,'Fire Card');
INSERT INTO `synth_recipes` VALUES (1202,0,0,17,0,0,0,0,0,0,0,4102,4244,914,2316,4105,0,0,0,0,0,2177,2177,2177,2177,33,66,99,99,'Ice Card');
INSERT INTO `synth_recipes` VALUES (1203,0,0,17,0,0,0,0,0,0,0,4102,4244,914,2316,4106,0,0,0,0,0,2178,2178,2178,2178,33,66,99,99,'Wind Card');
INSERT INTO `synth_recipes` VALUES (1204,0,0,17,0,0,0,0,0,0,0,4102,4244,914,2316,4107,0,0,0,0,0,2179,2179,2179,2179,33,66,99,99,'Earth Card');
INSERT INTO `synth_recipes` VALUES (1205,0,0,17,0,0,0,0,0,0,0,4102,4244,914,2316,4108,0,0,0,0,0,2180,2180,2180,2180,33,66,99,99,'Thunder Card');
INSERT INTO `synth_recipes` VALUES (1206,0,0,17,0,0,0,0,0,0,0,4102,4244,914,2316,4109,0,0,0,0,0,2181,2181,2181,2181,33,66,99,99,'Water Card');
INSERT INTO `synth_recipes` VALUES (1207,0,0,17,0,0,0,0,0,0,0,4102,4244,914,2316,4110,0,0,0,0,0,2182,2182,2182,2182,33,66,99,99,'Light Card');
INSERT INTO `synth_recipes` VALUES (1208,0,0,17,0,0,0,0,0,0,0,4102,4244,914,2316,4111,0,0,0,0,0,2183,2183,2183,2183,33,66,99,99,'Dark Card');
INSERT INTO `synth_recipes` VALUES (1209,0,0,15,0,0,0,0,0,0,0,4101,4243,1683,4509,4545,0,0,0,0,0,2197,2197,2197,2197,3,6,9,12,'Chocotonic');
INSERT INTO `synth_recipes` VALUES (1210,0,0,65,0,0,0,0,0,0,0,4101,4243,2364,4509,4545,0,0,0,0,0,2197,2197,2197,2197,3,6,9,12,'Chocotonic');
INSERT INTO `synth_recipes` VALUES (1211,0,0,82,0,0,0,0,0,0,0,4102,4244,918,940,1309,4508,4509,0,0,0,2206,2345,2345,2345,1,1,1,1,'Chocolixir');
INSERT INTO `synth_recipes` VALUES (1212,0,0,0,0,0,75,0,0,0,0,4098,4240,534,618,2203,2343,4366,4386,4484,5607,2207,2346,2346,2346,1,1,1,1,'Celerity Salad');
INSERT INTO `synth_recipes` VALUES (1213,0,0,0,0,0,75,0,0,0,0,4098,4240,534,618,2203,2343,4366,4386,5456,5607,2207,2346,2346,2346,1,1,1,1,'Celerity Salad');
INSERT INTO `synth_recipes` VALUES (1214,0,0,0,0,0,11,0,0,0,0,4101,4243,2201,2201,2343,4362,4509,0,0,0,2208,2208,2208,2208,2,4,6,8,'Herb Paste');
INSERT INTO `synth_recipes` VALUES (1215,0,0,0,0,0,1,0,0,0,0,4101,4243,2203,2203,2343,4362,4509,0,0,0,2209,2209,2209,2209,2,4,6,8,'Worm Paste'); -- worm paste (cook 1) https://www.bg-wiki.com/bg/Worm_Paste
INSERT INTO `synth_recipes` VALUES (1216,0,0,0,0,0,21,0,0,0,0,4101,4243,2343,4362,4509,4545,4545,0,0,0,2210,2210,2210,2210,2,4,6,8,'Vegetable Paste');
INSERT INTO `synth_recipes` VALUES (1217,0,0,0,0,0,31,0,0,0,0,4101,4243,2343,4362,4509,5607,5607,0,0,0,2211,2211,2211,2211,2,4,6,8,'Carrot Paste');
INSERT INTO `synth_recipes` VALUES (1218,0,0,9,0,0,0,0,0,0,0,4100,4242,629,629,0,0,0,0,0,0,2215,2215,2215,2215,1,2,3,4,'Cornstarch');
INSERT INTO `synth_recipes` VALUES (1219,0,2035,38,0,0,0,0,0,0,0,4100,4242,2131,2155,2155,2155,0,0,0,0,2229,2229,2229,2229,3,6,9,12,'Chimera Blood');
INSERT INTO `synth_recipes` VALUES (1220,0,0,38,0,0,0,0,0,0,0,4100,4242,2155,0,0,0,0,0,0,0,2229,2229,2229,2229,1,2,3,4,'Chimera Blood');
INSERT INTO `synth_recipes` VALUES (1221,0,2025,0,8,0,0,0,0,0,0,4098,4240,888,1642,1644,1648,0,0,0,0,2234,2234,2234,2234,1,1,1,1,'Wailing Shell');
INSERT INTO `synth_recipes` VALUES (1222,0,2037,44,0,0,0,4,0,0,0,4096,4238,671,1887,2154,2301,2310,0,0,0,2238,2238,2238,2238,12,12,12,12,'Strobe');
INSERT INTO `synth_recipes` VALUES (1223,0,2002,0,0,0,0,51,0,0,0,4099,4241,637,654,2308,2308,2311,0,0,0,2239,2239,2239,2239,12,12,12,12,'Tension Spring');
INSERT INTO `synth_recipes` VALUES (1224,0,2037,55,0,0,0,0,0,0,0,4096,4238,939,1641,1887,2309,2310,0,0,0,2240,2240,2240,2240,12,12,12,12,'Inhibitor');
INSERT INTO `synth_recipes` VALUES (1225,0,2002,0,0,0,0,61,0,0,0,4099,4241,637,654,2308,2308,2360,0,0,0,2241,2241,2241,2241,12,12,12,12,'Ten. Spring Ii');
INSERT INTO `synth_recipes` VALUES (1226,0,2037,49,0,0,0,3,0,0,0,4099,4241,914,924,1656,2290,18402,0,0,0,2242,2242,2242,2242,12,12,12,12,'Mana Booster'); -- mana booster (alch 49, gold 3)
INSERT INTO `synth_recipes` VALUES (1227,0,2037,48,22,0,0,0,0,0,0,4096,4238,953,1887,2113,2171,13683,0,0,0,2243,2243,2243,2243,12,12,12,12,'Loudspeaker'); -- loudspeaker (alch 48, bone 22) https://www.bg-wiki.com/bg/Loudspeaker
INSERT INTO `synth_recipes` VALUES (1228,0,2037,55,0,0,0,0,0,0,0,4096,4238,939,1642,1887,2309,2310,0,0,0,2244,2244,2244,2244,12,12,12,12,'Scanner');
INSERT INTO `synth_recipes` VALUES (1229,0,2037,59,39,0,0,0,0,0,0,4096,4238,953,953,1887,2113,2113,2171,13683,0,2245,2245,2245,2245,12,12,12,12,'Loudspeaker Ii'); -- loudspeaker II (alch 59)
INSERT INTO `synth_recipes` VALUES (1230,0,2002,29,0,0,0,58,0,0,0,4096,4238,927,1520,2290,2311,18236,0,0,0,2246,2246,2246,2246,12,12,12,12,'Accelerator');
INSERT INTO `synth_recipes` VALUES (1231,0,2002,11,0,0,0,47,0,0,0,4099,4241,661,933,1109,1109,2311,0,0,0,2247,2247,2247,2247,12,12,12,12,'Scope'); -- scope: alchemy(11)
INSERT INTO `synth_recipes` VALUES (1232,0,2037,55,0,0,0,0,0,0,0,4096,4238,939,1643,1887,2309,2310,0,0,0,2248,2248,2248,2248,12,12,12,12,'Pattern Reader');
INSERT INTO `synth_recipes` VALUES (1233,0,2002,29,0,0,0,68,0,0,0,4096,4238,927,1520,2290,2360,18237,0,0,0,2249,2249,2249,2249,12,12,12,12,'Accelerator Ii'); -- accelerator II (gold 68, alch 29)
INSERT INTO `synth_recipes` VALUES (1234,0,2002,19,0,0,0,52,0,30,0,4096,4238,662,664,928,932,2290,0,0,0,2250,2250,2250,2250,12,12,12,12,'Shock Absorber'); -- shock absorber (gold 52, smith 30, alch 19)
INSERT INTO `synth_recipes` VALUES (1235,0,0,14,0,0,0,0,0,58,0,4096,4238,662,664,666,932,2290,0,0,0,2251,2251,2251,2251,12,12,12,12,'Armor Plate');
INSERT INTO `synth_recipes` VALUES (1236,0,0,0,0,0,0,0,0,0,10,4098,4240,8806,0,0,0,0,0,0,0,17088,17088,17088,17088,1,1,1,1,'Ash Staff'); -- ash staff (kit)
INSERT INTO `synth_recipes` VALUES (1237,0,2037,55,0,0,0,0,0,0,0,4096,4238,939,1644,1887,2309,2310,0,0,0,2252,2252,2252,2252,12,12,12,12,'Analyzer');
INSERT INTO `synth_recipes` VALUES (1238,0,0,23,0,0,0,0,0,68,0,4096,4238,664,664,666,932,2290,0,0,0,2253,2253,2253,2253,12,12,12,12,'Armor Plate Ii');
INSERT INTO `synth_recipes` VALUES (1239,0,2037,46,0,0,0,25,0,0,0,4096,4238,663,1886,2300,5138,13683,0,0,0,2254,2254,2254,2254,12,12,12,12,'Stabilizer'); -- stabilizer (alch 46, gold 25)
INSERT INTO `synth_recipes` VALUES (1240,0,2002,27,0,0,0,54,0,0,0,4096,4238,752,1173,2300,2311,18228,0,0,0,2255,2255,2255,2255,12,12,12,12,'Volt Gun');
INSERT INTO `synth_recipes` VALUES (1241,0,2037,55,0,0,0,0,0,0,0,4096,4238,939,1645,1887,2309,2310,0,0,0,2256,2256,2256,2256,12,12,12,12,'Heat Seeker');
INSERT INTO `synth_recipes` VALUES (1242,0,2037,56,0,0,0,23,0,0,0,4096,4238,663,1886,2362,5138,13683,0,0,0,2257,2257,2257,2257,12,12,12,12,'Stabilizer Ii'); -- stabilizer II (alch 56, gold 23)
INSERT INTO `synth_recipes` VALUES (1243,0,2002,12,0,0,0,59,0,0,0,4096,4238,667,1109,1886,13683,18232,0,0,0,2258,2258,2258,2258,12,12,12,12,'Mana Jammer'); -- mana jammer (gold 59, alch 12)
INSERT INTO `synth_recipes` VALUES (1244,0,2002,0,0,0,0,49,0,0,0,4099,4241,663,1886,2311,13683,18232,0,0,0,2259,2259,2259,2259,12,12,12,12,'Heatsink');
INSERT INTO `synth_recipes` VALUES (1245,0,2037,55,0,0,0,0,0,0,0,4096,4238,939,1646,1887,2309,2310,0,0,0,2260,2260,2260,2260,12,12,12,12,'Stealth Screen');
INSERT INTO `synth_recipes` VALUES (1246,0,2002,12,0,0,0,69,0,0,0,4096,4238,667,1109,1886,13683,18233,0,0,0,2261,2261,2261,2261,12,12,12,12,'Mana Jammer Ii'); -- mana jammer II (gold 69, alch 12)
INSERT INTO `synth_recipes` VALUES (1247,0,2002,29,0,0,0,51,0,0,0,4096,4238,663,933,1887,13688,18232,0,0,0,2262,2262,2262,2262,12,12,12,12,'Auto-repair Kit'); -- auto-repair kit (gold 51, alch 29)
INSERT INTO `synth_recipes` VALUES (1248,0,2037,48,0,0,0,10,0,0,0,4096,4238,933,1886,1887,2216,13683,0,0,0,2263,2263,2263,2263,12,12,12,12,'Flashbulb');
INSERT INTO `synth_recipes` VALUES (1249,0,2037,55,0,0,0,0,0,0,0,4096,4238,939,1647,1887,2309,2310,0,0,0,2264,2264,2264,2264,12,12,12,12,'Damage Gauge');
INSERT INTO `synth_recipes` VALUES (1250,0,2002,29,0,0,0,61,0,0,0,4096,4238,752,933,1887,13688,18233,0,0,0,2265,2265,2265,2265,12,12,12,12,'Auto-rep. Kit Ii'); -- auto-repait kit II (gold 61, alch 29)
INSERT INTO `synth_recipes` VALUES (1251,0,2002,29,0,0,0,56,0,0,0,4096,4238,914,1886,1887,13689,18232,0,0,0,2266,2266,2266,2266,12,12,12,12,'Mana Tank'); -- mana tank (gold 56, alch 29)
INSERT INTO `synth_recipes` VALUES (1252,0,2037,49,0,0,0,6,0,0,0,4096,4238,914,927,1656,1656,2290,0,0,0,2267,2267,2267,2267,12,12,12,12,'Mana Converter'); -- mana converter (alch 49, gold 6)
INSERT INTO `synth_recipes` VALUES (1253,0,2037,55,0,0,0,0,0,0,0,4096,4238,939,1648,1887,2309,2310,0,0,0,2268,2268,2268,2268,12,12,12,12,'Mana Conserver');
INSERT INTO `synth_recipes` VALUES (1254,0,2002,29,0,0,0,66,0,0,0,4096,4238,914,1886,1887,13689,18233,0,0,0,2269,2269,2269,2269,12,12,12,12,'Mana Tank Ii'); -- mana tank II (gold 66, alch 29)
INSERT INTO `synth_recipes` VALUES (1255,0,0,11,0,0,0,0,0,0,0,4098,4240,2270,0,0,0,0,0,0,0,2271,2271,2271,2271,1,1,1,1,'Coffee Beans');
INSERT INTO `synth_recipes` VALUES (1256,0,0,0,0,0,25,0,0,0,0,4096,4238,2271,0,0,0,0,0,0,0,2272,2272,2272,2272,2,4,6,8,'Rst. Coff. Beans');
INSERT INTO `synth_recipes` VALUES (1257,0,0,19,0,0,0,0,0,0,0,4098,4240,2272,0,0,0,0,0,0,0,2273,2273,2273,2273,1,2,3,4,'Coffee Powder');
INSERT INTO `synth_recipes` VALUES (1258,0,0,0,0,42,0,0,0,0,0,4099,4241,2296,2296,2296,0,0,0,0,0,2274,2274,2274,2274,1,1,1,1,'Mohbwa Cloth'); -- mohbwa cloth (cloth 42) http://ffxiclopedia.wikia.com/wiki/Mohbwa_Cloth
INSERT INTO `synth_recipes` VALUES (1259,0,0,0,0,0,0,98,0,0,0,4096,4238,739,2228,2228,2228,0,0,0,0,2275,2275,2275,2275,1,1,1,1,'Scintillant Ingot');
INSERT INTO `synth_recipes` VALUES (1260,0,2010,0,0,55,0,0,0,0,0,4100,4242,2128,2315,2315,2315,2315,2315,2315,0,2287,2287,2287,2287,3,3,3,3,'Karakul Thread');
INSERT INTO `synth_recipes` VALUES (1261,0,0,0,0,55,0,0,0,0,0,4100,4242,2315,2315,0,0,0,0,0,0,2287,2287,2287,2287,1,1,1,1,'Karakul Thread');
INSERT INTO `synth_recipes` VALUES (1262,1,0,0,0,57,0,0,0,0,0,4098,4240,2153,0,0,0,0,0,0,0,2288,1155,1888,2305,1,1,1,1,'Karakul Cloth'); -- Synth level guessed
INSERT INTO `synth_recipes` VALUES (1263,0,0,0,0,57,0,0,0,0,0,4099,4241,2287,2287,2287,0,0,0,0,0,2288,2288,2288,2288,1,1,1,1,'Karakul Cloth');
INSERT INTO `synth_recipes` VALUES (1264,1,0,0,0,90,0,0,0,0,0,4098,4240,2334,0,0,0,0,0,0,0,2289,2289,2289,2289,1,2,3,4,'Wamoura Cloth');
INSERT INTO `synth_recipes` VALUES (1265,0,0,0,0,90,0,0,0,0,0,4099,4241,2304,2304,2304,0,0,0,0,0,2289,2289,2289,2289,1,1,1,1,'Wamoura Cloth');
INSERT INTO `synth_recipes` VALUES (1266,0,0,71,0,0,0,0,0,0,0,4096,4238,931,931,1888,0,0,0,0,0,2290,2290,2290,2290,1,2,3,4,'Imperial Cermet');
INSERT INTO `synth_recipes` VALUES (1267,0,2011,0,0,82,0,0,0,0,0,4098,4240,2145,2148,2148,2148,2148,2148,2148,0,2291,2291,2291,2291,18,24,30,36,'Puk Fletching');
INSERT INTO `synth_recipes` VALUES (1268,0,0,0,0,82,0,0,0,0,0,4098,4240,2148,2148,0,0,0,0,0,0,2291,2291,2291,2291,6,8,10,12,'Puk Fletching');
INSERT INTO `synth_recipes` VALUES (1269,0,2011,0,0,67,0,0,0,0,0,4098,4240,2145,2149,2149,2149,2149,2149,2149,0,2292,2292,2292,2292,18,24,30,36,'Apkal. Fletching'); -- Apkallu Fletchings (cloth 67) https://www.bg-wiki.com/bg/Apkal._Fletching
INSERT INTO `synth_recipes` VALUES (1270,0,0,0,0,67,0,0,0,0,0,4098,4240,2149,2149,0,0,0,0,0,0,2292,2292,2292,2292,6,8,10,12,'Apkal. Fletching'); -- Apkallu Fletchings (cloth 67) https://www.bg-wiki.com/bg/Apkal._Fletching
INSERT INTO `synth_recipes` VALUES (1271,0,2026,0,78,0,0,0,0,0,0,4098,4240,880,880,880,2130,2147,2147,2147,0,2293,2293,2293,2293,18,24,30,36,'M. Tusk Arwhds.');
INSERT INTO `synth_recipes` VALUES (1272,0,0,0,78,0,0,0,0,0,0,4098,4240,880,2147,0,0,0,0,0,0,2293,2293,2293,2293,6,8,10,12,'M. Tusk Arwhds.');
INSERT INTO `synth_recipes` VALUES (1273,0,0,77,0,0,0,0,0,0,0,4098,4240,648,937,2290,4159,0,0,0,0,2294,2294,2294,2294,6,8,10,12,'Par. Arrowheads');
INSERT INTO `synth_recipes` VALUES (1274,0,2010,0,0,41,0,0,0,0,0,4100,4242,2128,2295,2295,2295,2295,2295,2295,0,2296,2296,2296,2296,3,3,3,3,'Mohbwa Thread');
INSERT INTO `synth_recipes` VALUES (1275,0,0,0,0,41,0,0,0,0,0,4100,4242,2295,2295,0,0,0,0,0,0,2296,2296,2296,2296,1,1,1,1,'Mohbwa Thread');
INSERT INTO `synth_recipes` VALUES (1276,0,0,57,33,0,0,0,0,0,0,4101,4243,648,2146,0,0,0,0,0,0,2297,2297,2297,2297,6,8,10,12,'Water Arrowhds.'); -- water arrowheads (alch 57, bone 33) https://www.bg-wiki.com/bg/Water_Arrowhds.
INSERT INTO `synth_recipes` VALUES (1277,0,0,57,35,0,0,0,0,0,0,4098,4240,648,2171,0,0,0,0,0,0,2298,2298,2298,2298,6,8,10,12,'Wind Arrowhds.');
INSERT INTO `synth_recipes` VALUES (1278,0,0,57,44,0,0,0,0,0,0,4099,4241,648,2147,0,0,0,0,0,0,2299,2299,2299,2299,6,8,10,12,'Earth Arrowhds.');
INSERT INTO `synth_recipes` VALUES (1279,0,0,63,0,0,0,0,0,0,0,4100,4242,1108,2175,2175,0,0,0,0,0,2300,2300,2300,2300,2,2,2,2,'Ebonite');
INSERT INTO `synth_recipes` VALUES (1280,0,0,83,0,0,0,0,0,0,0,4100,4242,2175,2229,0,0,0,0,0,0,2301,2301,2301,2301,2,4,6,6,'Polyflan');
INSERT INTO `synth_recipes` VALUES (1281,1,0,0,0,0,0,0,0,91,0,4100,4242,18409,0,0,0,0,0,0,0,2302,2302,2302,2302,1,1,2,2,'Tr. Brz. Ingot');
INSERT INTO `synth_recipes` VALUES (1282,0,0,0,0,0,0,0,0,82,0,4096,4238,2302,0,0,0,0,0,0,0,2303,2303,2303,2303,1,1,1,1,'Tr. Brz. Sheet');
INSERT INTO `synth_recipes` VALUES (1283,1,0,0,0,0,0,0,0,96,0,4100,4242,16161,0,0,0,0,0,0,0,2303,2303,2303,2303,1,1,2,2,'Tr. Brz. Sheet');
INSERT INTO `synth_recipes` VALUES (1284,0,2010,0,0,88,0,0,0,0,0,4100,4242,2128,2173,2173,2173,2173,2173,2173,0,2304,2304,2304,2304,3,3,3,3,'Wamoura Silk');
INSERT INTO `synth_recipes` VALUES (1285,0,0,0,0,88,0,0,0,0,0,4100,4242,2173,2173,0,0,0,0,0,0,2304,2304,2304,2304,1,1,1,1,'Wamoura Silk');
INSERT INTO `synth_recipes` VALUES (1286,1,0,0,0,87,0,0,0,0,0,4100,4242,2227,0,0,0,0,0,0,0,2304,2304,2304,2304,1,2,3,4,'Wamoura Silk');
INSERT INTO `synth_recipes` VALUES (1287,1,0,0,0,88,0,0,0,0,0,4100,4242,2334,0,0,0,0,0,0,0,2304,2304,2304,787,2,2,2,1,'Wamoura Silk');
INSERT INTO `synth_recipes` VALUES (1288,0,0,0,0,89,0,0,0,0,0,4100,4242,2337,2337,0,0,0,0,0,0,2304,2304,2304,2304,1,1,1,1,'Wamoura Silk'); -- wamoura silk (cloth 89) http://ffxiclopedia.wikia.com/wiki/Wamoura_Silk
INSERT INTO `synth_recipes` VALUES (1289,0,1994,0,0,0,0,43,0,0,0,4098,4240,653,653,2143,0,0,0,0,0,2308,2308,2308,2308,3,6,9,12,'Mythril Coil');
INSERT INTO `synth_recipes` VALUES (1290,0,2037,39,0,0,0,0,0,0,0,4101,4243,914,2175,2175,0,0,0,0,0,2310,2310,2310,2310,33,66,99,99,'Plasma Oil');
INSERT INTO `synth_recipes` VALUES (1291,0,2002,0,0,0,0,44,0,0,0,4096,4238,653,663,0,0,0,0,0,0,2311,2311,2311,2311,1,2,3,4,'Myth.gear Mach.');
INSERT INTO `synth_recipes` VALUES (1292,0,0,0,0,0,0,0,14,0,0,4098,4240,878,878,0,0,0,0,0,0,2315,2315,2315,2315,1,1,1,1,'Karakul Wool');
INSERT INTO `synth_recipes` VALUES (1293,0,0,36,0,0,0,0,0,0,0,4099,4241,2301,0,0,0,0,0,0,0,2316,2316,2316,2316,33,66,99,99,'Polyflan Paper');
INSERT INTO `synth_recipes` VALUES (1294,1,0,0,0,74,0,0,0,0,0,4098,4240,1724,0,0,0,0,0,0,0,2340,2340,2340,2340,2,4,6,8,'Imp. Silk Cloth');
INSERT INTO `synth_recipes` VALUES (1295,0,0,0,0,59,0,0,0,0,0,4099,4241,816,823,2304,0,0,0,0,0,2340,2340,2340,2340,1,1,1,1,'Imp. Silk Cloth');
INSERT INTO `synth_recipes` VALUES (1296,0,2024,0,73,0,0,0,0,0,0,4098,4240,866,1644,1644,1647,0,0,0,0,2358,2358,2358,2358,1,1,1,1,'Lithic W. Scale');
INSERT INTO `synth_recipes` VALUES (1297,0,2002,0,0,0,0,54,0,0,0,4096,4238,653,752,0,0,0,0,0,0,2360,2360,2360,2360,1,2,3,4,'Golden Gear');
INSERT INTO `synth_recipes` VALUES (1298,0,0,73,0,0,0,0,0,0,0,4100,4242,1108,2175,2175,2175,0,0,0,0,2362,2362,2362,2362,2,4,6,8,'High Ebonite');
INSERT INTO `synth_recipes` VALUES (1299,0,0,82,0,0,0,0,0,0,0,4100,4242,2373,0,0,0,0,0,0,0,2374,2374,2374,2374,1,1,1,1,'Viper Dust'); -- viper dust (alch 82)
INSERT INTO `synth_recipes` VALUES (1300,0,0,0,0,0,8,0,0,0,0,4101,4243,4363,5575,0,0,0,0,0,0,2390,2390,2390,2390,1,1,1,1,'Stamina Apple'); -- stamina apple (requires yogurt) https://www.bg-wiki.com/bg/Stamina_Apple
INSERT INTO `synth_recipes` VALUES (1301,0,0,0,0,28,0,0,0,0,0,4098,4240,825,826,826,826,0,0,0,0,2398,2398,2398,2398,3,6,9,12,'Chocobo Taping');
INSERT INTO `synth_recipes` VALUES (1302,0,0,0,0,17,0,0,22,0,0,4099,4241,826,829,879,0,0,0,0,0,2399,2399,2399,2399,1,1,1,1,'Chocobo Blnk.');
INSERT INTO `synth_recipes` VALUES (1303,0,0,0,0,56,0,0,0,0,0,4099,4241,816,826,828,828,0,0,0,0,2401,2401,2401,2401,3,3,3,3,'Chocobo Hood'); -- chocobo hood (cloth 56) https://www.bg-wiki.com/bg/Chocobo_Hood
INSERT INTO `synth_recipes` VALUES (1304,0,2037,64,0,0,0,0,37,0,0,4096,4238,637,818,913,1122,1772,17305,0,0,2409,2409,2409,2409,12,12,12,12,'Flame Holder'); -- flame holder (alch 64, leather 37)
INSERT INTO `synth_recipes` VALUES (1305,0,2037,64,0,23,0,0,0,0,0,4096,4238,663,1772,2175,2315,17306,18230,0,0,2410,2410,2410,2410,12,12,12,12,'Ice Maker');
INSERT INTO `synth_recipes` VALUES (1306,0,2037,72,0,0,0,42,0,0,0,4096,4238,663,1886,2316,2316,18236,0,0,0,2411,2411,2411,2411,12,12,12,12,'Replicator');
INSERT INTO `synth_recipes` VALUES (1307,0,2002,0,0,0,0,74,0,23,0,4096,4238,652,927,1520,2311,17044,17044,18236,0,2412,2412,2412,2412,12,12,12,12,'Hammermill'); -- hammermill (gold 74 smith 23) https://www.bg-wiki.com/bg/Hammermill
INSERT INTO `synth_recipes` VALUES (1308,0,0,0,0,0,0,8,0,0,0,4096,4238,2417,2417,2417,2417,0,0,0,0,2418,2418,2418,2418,1,1,1,1,'A.u. Brass Ingot');
INSERT INTO `synth_recipes` VALUES (1309,0,1995,0,0,0,0,10,0,0,0,4096,4238,2144,2418,2418,2418,2418,2418,2418,0,2419,2419,2419,2419,6,6,6,6,'A.u Brass Sheet');
INSERT INTO `synth_recipes` VALUES (1310,0,0,0,0,0,0,10,0,0,0,4096,4238,2418,0,0,0,0,0,0,0,2419,2419,2419,2419,1,1,1,1,'A.u Brass Sheet');
INSERT INTO `synth_recipes` VALUES (1311,0,2025,0,41,0,0,0,0,0,0,4098,4240,881,1645,1645,1648,0,0,0,0,2420,2420,2420,2420,1,1,1,1,'Luminous Shell');
INSERT INTO `synth_recipes` VALUES (1312,0,2025,0,52,0,0,0,0,0,0,4098,4240,885,1644,1644,1648,0,0,0,0,2421,2421,2421,2421,1,1,1,1,'Spirit Shell');
INSERT INTO `synth_recipes` VALUES (1313,0,2000,0,0,0,0,41,0,0,0,4096,4238,653,1643,1643,1647,0,0,0,0,2422,2422,2422,2422,1,1,1,1,'Mtl. Mesh Sheet');
INSERT INTO `synth_recipes` VALUES (1314,0,2017,0,0,0,0,0,51,0,0,4103,4245,853,1642,1642,1648,0,0,0,0,2423,2423,2423,2423,1,1,1,1,'Frigid Skin');
INSERT INTO `synth_recipes` VALUES (1315,0,2009,0,0,37,0,0,0,0,0,4099,4241,820,820,820,1641,1642,1648,0,0,2424,2424,2424,2424,1,1,1,1,'Incomb. Wool');
INSERT INTO `synth_recipes` VALUES (1316,0,2009,0,0,45,0,0,0,0,0,4099,4241,816,820,820,1644,1646,1648,0,0,2425,2425,2425,2425,1,1,1,1,'Humid. Velvet');
INSERT INTO `synth_recipes` VALUES (1317,0,0,0,0,0,0,1,0,99,0,4096,4238,648,668,879,2001,2275,2465,0,0,2439,2440,2440,2440,1,1,1,1,'Cursed Helm');
INSERT INTO `synth_recipes` VALUES (1318,0,0,0,0,0,0,29,59,104,0,4096,4238,668,668,2001,2001,2170,2170,2275,2466,2441,2442,2442,2442,1,1,1,1,'C. Breastplate'); -- cursed breastplate (smith 104 leath 59 gold ??) https://www.bg-wiki.com/bg/C._Breastplate
INSERT INTO `synth_recipes` VALUES (1319,0,0,0,0,0,0,52,0,103,0,4096,4238,668,2001,2275,2467,12696,12696,0,0,2443,2444,2444,2444,1,1,1,1,'Cursed Gauntlets'); -- cursed gauntlets (smith 103 gold ??) https://www.bg-wiki.com/bg/Cursed_Gauntlets
INSERT INTO `synth_recipes` VALUES (1320,0,0,0,0,0,0,14,0,98,0,4096,4238,668,2001,2152,2275,2468,0,0,0,2445,2446,2446,2446,1,1,1,1,'Cursed Cuishes');
INSERT INTO `synth_recipes` VALUES (1321,0,0,0,0,0,0,13,0,101,0,4096,4238,668,2001,2001,2152,2152,2275,2469,0,2447,2448,2448,2448,1,1,1,1,'Cursed Sabatons'); -- cursed sabatons (smith 101 gold ?) https://www.bg-wiki.com/bg/Cursed_Sabatons
INSERT INTO `synth_recipes` VALUES (1322,0,0,0,0,93,0,50,50,0,0,4099,4241,828,828,855,2152,2340,2470,2476,0,2449,2450,2450,2450,1,1,1,1,'Cursed Hat'); -- cursed hat (cloth 93 gold 50 leath 50) https://www.bg-wiki.com/bg/Cursed_Hat
INSERT INTO `synth_recipes` VALUES (1323,0,0,0,0,97,0,51,51,0,0,4099,4241,828,828,828,2152,2340,2340,2471,2476,2451,2452,2452,2452,1,1,1,1,'Cursed Coat'); -- cursed coat (cloth 97 gold 51 leath 51) https://www.bg-wiki.com/bg/Cursed_Coat
INSERT INTO `synth_recipes` VALUES (1324,0,0,0,0,99,0,54,54,0,0,4099,4241,813,813,828,879,2340,2472,2476,0,2453,2454,2454,2454,1,1,1,1,'Cursed Cuffs'); -- cursed cuffs (cloth 99 gold 54 leath 54) https://www.bg-wiki.com/bg/Cursed_Cuffs
INSERT INTO `synth_recipes` VALUES (1325,0,0,0,0,95,0,50,50,0,0,4099,4241,828,828,2152,2340,2340,2473,2476,0,2455,2456,2456,2456,1,1,1,1,'Cursed Trews'); -- cursed trews (cloth 95 gold 50 leath 50) https://www.bg-wiki.com/bg/Cursed_Trews
INSERT INTO `synth_recipes` VALUES (1326,0,0,0,0,59,0,48,92,0,0,4099,4241,828,849,2152,2152,2474,2476,0,0,2457,2458,2458,2458,1,1,1,1,'Cursed Clogs'); -- cursed clogs (leath 92 cloth 59 gold 48) https://www.bg-wiki.com/bg/Cursed_Clogs
INSERT INTO `synth_recipes` VALUES (1327,0,0,86,0,0,0,0,0,0,0,4096,4238,936,1883,1888,1888,1888,1888,2459,2459,2460,2460,2460,2460,1,2,3,4,'F. Glass Sheet');
INSERT INTO `synth_recipes` VALUES (1328,1,0,83,0,0,0,0,0,0,0,4100,4242,16132,0,0,0,0,0,0,0,2460,2460,2460,2460,1,1,1,1,'F. Glass Sheet'); -- desynth dandy spectacles (alch 83)
INSERT INTO `synth_recipes` VALUES (1329,0,0,21,0,0,0,0,0,0,0,4096,4238,5466,0,0,0,0,0,0,0,2464,2464,2464,2464,6,8,10,12,'Carbon Dioxide');
INSERT INTO `synth_recipes` VALUES (1330,0,2010,0,0,69,0,0,0,0,0,4099,4241,746,746,746,823,823,823,2128,0,2476,2476,2476,2476,6,6,6,6,'Platinum Silk');
INSERT INTO `synth_recipes` VALUES (1331,0,0,0,0,69,0,53,0,0,0,4099,4241,746,816,0,0,0,0,0,0,2476,2476,2476,2476,2,4,6,8,'Platinum Silk'); -- platinum silk (cloth 69 gold 53) https://www.bg-wiki.com/index.php?title=Platinum_Silk&redirect=no
INSERT INTO `synth_recipes` VALUES (1332,0,0,0,0,70,0,0,0,0,0,4099,4241,822,825,828,0,0,0,0,0,2501,2501,2501,2501,1,1,1,1,'B. Puppet Turban');
INSERT INTO `synth_recipes` VALUES (1333,0,0,0,0,70,0,0,0,0,0,4099,4241,822,825,829,0,0,0,0,0,2502,2502,2502,2502,1,1,1,1,'W. Puppet Turban');
INSERT INTO `synth_recipes` VALUES (1334,0,0,0,0,0,0,47,0,0,0,4098,4240,648,650,0,0,0,0,0,0,2508,2508,2508,2508,12,12,12,12,'Gold Dust');
INSERT INTO `synth_recipes` VALUES (1335,0,0,0,0,30,0,0,75,28,0,4099,4241,662,793,793,819,820,1163,1163,1865,15200,15200,15200,15200,1,1,1,1,'Orc Helm'); -- orc helm (leather 75 cloth 30 smith 28) http://ffxiclopedia.wikia.com/wiki/Orc_Helm
INSERT INTO `synth_recipes` VALUES (1336,0,2018,0,0,0,0,0,61,0,0,4103,4245,635,635,635,2129,2518,2518,2518,4509,2529,2529,2529,2529,3,3,3,3,'Smildn. Leather');
INSERT INTO `synth_recipes` VALUES (1337,0,0,0,0,0,0,0,0,0,15,4098,4240,8807,0,0,0,0,0,0,0,17389,17389,17389,17389,1,1,1,1,'Bamboo Fish. Rod'); -- bamboo fishing rod (kit)
INSERT INTO `synth_recipes` VALUES (1338,0,0,0,0,0,0,0,61,0,0,4103,4245,635,2518,4509,0,0,0,0,0,2529,2529,2529,2529,1,1,1,1,'Smildn. Leather');
INSERT INTO `synth_recipes` VALUES (1339,0,0,0,0,0,0,0,61,0,0,4103,4245,695,2518,4509,0,0,0,0,0,2529,2529,2529,2529,1,1,1,1,'Smildn. Leather');
INSERT INTO `synth_recipes` VALUES (1340,0,0,0,0,0,0,0,0,0,20,4098,4240,8808,0,0,0,0,0,0,0,17347,17347,17347,17347,1,1,1,1,'Piccolo'); -- piccolo (kit)
INSERT INTO `synth_recipes` VALUES (1341,0,2018,0,0,0,0,0,71,0,0,4103,4245,635,635,635,2129,2512,2512,2512,4509,2530,2530,2530,2530,3,3,3,3,'Lynx Leather');
INSERT INTO `synth_recipes` VALUES (1342,0,0,0,0,0,0,0,0,0,25,4099,4241,8809,0,0,0,0,0,0,0,92,92,92,92,1,1,1,1,'Tarutaru Stool'); -- tarutaru stool (kit)
INSERT INTO `synth_recipes` VALUES (1343,0,0,0,0,0,0,0,0,0,30,4099,4241,8810,0,0,0,0,0,0,0,17321,17321,17321,17321,33,33,33,33,'Silver Arrow'); -- silver arrow (kit)
INSERT INTO `synth_recipes` VALUES (1344,0,0,0,0,0,0,0,71,0,0,4103,4245,635,2512,4509,0,0,0,0,0,2530,2530,2530,2530,1,1,1,1,'Lynx Leather');
INSERT INTO `synth_recipes` VALUES (1345,0,0,0,0,0,0,0,71,0,0,4103,4245,695,2512,4509,0,0,0,0,0,2530,2530,2530,2530,1,1,1,1,'Lynx Leather');
INSERT INTO `synth_recipes` VALUES (1346,0,1986,0,0,0,0,0,0,0,85,4098,4240,1657,2532,2532,2532,0,0,0,0,2533,2533,2533,2533,3,6,9,12,'Teak Lumber');
INSERT INTO `synth_recipes` VALUES (1347,0,0,0,0,0,0,0,0,0,85,4098,4240,2532,0,0,0,0,0,0,0,2533,2533,2533,2533,1,2,3,4,'Teak Lumber');
INSERT INTO `synth_recipes` VALUES (1348,0,0,0,0,0,0,0,0,0,35,4099,4241,8811,0,0,0,0,0,0,0,19200,19200,19200,19200,33,33,33,33,'Black Bolt'); -- black bolt (kit)
INSERT INTO `synth_recipes` VALUES (1349,0,0,0,0,0,0,0,0,0,40,4099,4241,8812,0,0,0,0,0,0,0,359,359,359,359,1,1,1,1,'Bahut'); -- bahut (kit)
INSERT INTO `synth_recipes` VALUES (1350,0,0,0,0,0,0,42,0,0,0,4096,4238,736,737,737,737,0,0,0,0,2536,2536,2536,2536,1,1,1,1,'Electrum Ingot');
INSERT INTO `synth_recipes` VALUES (1351,0,0,0,0,85,0,0,0,0,0,4099,4241,820,2539,2539,0,0,0,0,0,2537,2537,2537,2537,1,1,1,1,'Cilice'); -- cilice (cloth 85) https://www.bg-wiki.com/bg/Cilice
INSERT INTO `synth_recipes` VALUES (1352,0,2018,0,0,0,0,0,81,0,0,4103,4245,635,635,635,2129,2523,2523,2523,4509,2538,2538,2538,2538,3,3,3,3,'Peiste Leather'); -- peiste leather (requires 3x leaves) https://www.bg-wiki.com/bg/Peiste_Leather
INSERT INTO `synth_recipes` VALUES (1353,0,0,0,0,0,0,0,81,0,0,4103,4245,695,2523,4509,0,0,0,0,0,2538,2538,2538,2538,1,1,1,1,'Peiste Leather');
INSERT INTO `synth_recipes` VALUES (1354,0,0,0,0,0,0,0,29,0,0,4098,4240,857,857,857,0,0,0,0,0,2539,2539,2539,2539,1,2,3,4,'Dhalmel Hair');
INSERT INTO `synth_recipes` VALUES (1355,0,0,0,0,0,0,6,0,0,0,4098,4240,2531,0,0,0,0,0,0,0,2546,2546,2546,2546,6,8,10,12,'Blk. Bolt Heads');
INSERT INTO `synth_recipes` VALUES (1356,0,0,0,0,0,0,14,0,0,0,4098,4240,2531,2531,0,0,0,0,0,0,2547,2547,2547,2547,6,8,10,12,'Obsid. Arrowhd.');
INSERT INTO `synth_recipes` VALUES (1357,0,2011,0,0,62,0,0,0,0,0,4098,4240,2145,2522,2522,2522,2522,2522,2522,0,2548,2548,2548,2548,18,24,30,36,'Gnat Fletchings');
INSERT INTO `synth_recipes` VALUES (1358,0,0,0,0,62,0,0,0,0,0,4098,4240,2522,2522,0,0,0,0,0,0,2548,2548,2548,2548,6,8,10,12,'Gnat Fletchings');
INSERT INTO `synth_recipes` VALUES (1359,0,0,0,0,0,0,0,31,0,0,4103,4245,850,2508,4365,0,0,0,0,0,2550,2550,2550,2550,1,2,3,4,'Vellum');
INSERT INTO `synth_recipes` VALUES (1360,0,2017,0,0,0,0,45,0,0,0,4099,4241,2143,2536,2536,2536,2536,2536,2536,0,2551,2551,2551,2551,3,6,9,12,'Electrum Chain');
INSERT INTO `synth_recipes` VALUES (1361,0,0,0,0,0,0,45,0,0,0,4099,4241,2536,2536,0,0,0,0,0,0,2551,2551,2551,2551,1,2,3,4,'Electrum Chain');
INSERT INTO `synth_recipes` VALUES (1362,0,0,0,0,41,0,0,0,0,0,4099,4241,818,818,825,825,0,0,0,0,2553,2553,2553,2553,33,66,99,99,'Sanjaku-tenugui');
INSERT INTO `synth_recipes` VALUES (1363,0,0,0,0,0,42,0,0,0,0,4101,4243,615,633,936,1840,0,0,0,0,2561,2561,2561,2561,4,6,9,12,'Pizza Dough');
INSERT INTO `synth_recipes` VALUES (1364,0,0,29,0,0,0,0,0,0,0,4101,4243,2713,0,0,0,0,0,0,0,2706,2706,2706,2706,12,12,12,12,'Blue Text. Dye');
INSERT INTO `synth_recipes` VALUES (1365,0,0,29,0,0,0,0,0,0,0,4101,4243,2156,0,0,0,0,0,0,0,2707,2707,2707,2707,12,12,12,12,'Green Text. Dye');
INSERT INTO `synth_recipes` VALUES (1366,0,0,29,0,0,0,0,0,0,0,4101,4243,1554,0,0,0,0,0,0,0,2708,2708,2708,2708,12,12,12,12,'Yellow Txt. Dye');
INSERT INTO `synth_recipes` VALUES (1367,0,0,29,0,0,0,0,0,0,0,4101,4243,2113,0,0,0,0,0,0,0,2709,2709,2709,2709,12,12,12,12,'White Text. Dye');
INSERT INTO `synth_recipes` VALUES (1368,0,2041,0,0,0,45,0,0,0,0,4101,4243,2702,0,0,0,0,0,0,0,2710,2710,2710,2710,1,2,3,4,'Soba Noodles');
INSERT INTO `synth_recipes` VALUES (1369,0,0,40,0,0,0,0,0,0,0,4101,4243,638,926,4509,0,0,0,0,0,4112,4113,4114,4115,1,1,1,1,'Potion');
INSERT INTO `synth_recipes` VALUES (1370,0,0,60,0,0,0,0,0,0,0,4101,4243,638,638,920,4509,0,0,0,0,4116,4117,4118,4119,1,1,1,1,'Hi-potion');
INSERT INTO `synth_recipes` VALUES (1371,0,0,60,0,0,0,0,0,0,0,4101,4243,638,638,2513,4509,0,0,0,0,4116,4117,4118,4119,1,1,1,1,'Hi-potion');
INSERT INTO `synth_recipes` VALUES (1372,0,0,77,0,0,0,0,0,0,0,4101,4243,638,638,939,4449,4509,0,0,0,4120,4121,4122,4123,1,1,1,1,'X-potion');
INSERT INTO `synth_recipes` VALUES (1373,0,0,95,0,0,0,0,0,0,0,4101,4243,638,638,638,638,1133,4449,4509,0,4124,4125,4126,4127,1,1,1,1,'Max-potion');
INSERT INTO `synth_recipes` VALUES (1374,0,0,50,0,0,0,0,0,0,0,4101,4243,622,922,922,923,4509,0,0,0,4128,4129,4130,4131,1,1,1,1,'Ether');
INSERT INTO `synth_recipes` VALUES (1375,0,0,69,0,0,0,0,0,0,0,4101,4243,622,622,922,922,922,922,923,4509,4132,4133,4134,4135,1,1,1,1,'Hi-ether');
INSERT INTO `synth_recipes` VALUES (1376,0,0,69,0,0,0,0,0,0,0,4101,4243,622,622,923,2335,4509,0,0,0,4132,4133,4134,4135,1,1,1,1,'Hi-ether');
INSERT INTO `synth_recipes` VALUES (1377,0,0,89,0,0,0,0,0,0,0,4101,4243,622,622,622,935,953,4509,0,0,4136,4137,4138,4139,1,1,1,1,'Super Ether');
INSERT INTO `synth_recipes` VALUES (1378,0,0,100,0,0,0,0,0,0,0,4101,4243,622,622,622,935,935,953,1124,4509,4140,4141,4142,4143,1,1,1,1,'Pro-ether');
INSERT INTO `synth_recipes` VALUES (1379,0,0,90,0,0,0,0,0,0,0,4102,4244,918,940,1133,4508,4509,0,0,0,4145,4144,4144,4144,1,1,1,1,'Elixir');
INSERT INTO `synth_recipes` VALUES (1380,0,2035,3,0,0,0,0,0,0,0,4101,4243,951,951,951,2131,4431,4431,4431,4509,4148,4148,4148,4148,3,6,9,12,'Antidote');
INSERT INTO `synth_recipes` VALUES (1381,0,0,3,0,0,0,0,0,0,0,4101,4243,951,4431,4509,0,0,0,0,0,4148,4148,4148,4148,1,2,3,4,'Antidote');
INSERT INTO `synth_recipes` VALUES (1382,0,0,98,0,0,0,0,0,0,0,4102,4244,914,936,942,1108,0,0,0,0,4149,4149,4149,4149,1,2,3,4,'Panacea');
INSERT INTO `synth_recipes` VALUES (1383,0,2035,30,0,0,0,0,0,0,0,4101,4243,636,636,921,921,2131,4509,0,0,4150,4150,4150,4150,4,8,12,12,'Eye Drops');
INSERT INTO `synth_recipes` VALUES (1384,0,0,30,0,0,0,0,0,0,0,4101,4243,636,921,4509,0,0,0,0,0,4150,4150,4150,4150,2,4,6,8,'Eye Drops');
INSERT INTO `synth_recipes` VALUES (1385,0,2035,20,0,0,0,0,0,0,0,4101,4243,638,638,638,2131,4370,4370,4370,4509,4151,4151,4151,4151,3,6,9,12,'Echo Drops');
INSERT INTO `synth_recipes` VALUES (1386,0,0,20,0,0,0,0,0,0,0,4101,4243,638,4370,4509,0,0,0,0,0,4151,4151,4151,4151,1,2,3,4,'Echo Drops');
INSERT INTO `synth_recipes` VALUES (1387,0,0,93,0,0,43,0,0,0,0,4099,4241,622,627,636,1443,4509,0,0,0,4153,4153,4153,4153,1,1,1,1,'Antacid');
INSERT INTO `synth_recipes` VALUES (1388,1,0,54,0,0,0,0,0,0,0,4100,4242,16581,0,0,0,0,0,0,0,4154,1226,937,937,1,10,1,1,'Holy Water');
INSERT INTO `synth_recipes` VALUES (1389,1,0,83,0,0,0,0,0,0,0,4100,4242,16860,0,0,0,0,0,0,0,4154,1226,715,715,1,10,2,2,'Holy Water');
INSERT INTO `synth_recipes` VALUES (1390,1,0,55,0,0,0,0,0,0,0,4100,4242,17041,0,0,0,0,0,0,0,4154,716,1226,653,1,1,10,3,'Holy Water');
INSERT INTO `synth_recipes` VALUES (1391,1,0,71,0,0,0,0,0,0,0,4100,4242,17080,0,0,0,0,0,0,0,4154,716,1226,653,1,1,10,2,'Holy Water');
INSERT INTO `synth_recipes` VALUES (1392,0,0,51,0,0,0,0,0,0,0,4102,4244,4509,0,0,0,0,0,0,0,4154,4154,4154,4154,1,2,3,4,'Holy Water');
INSERT INTO `synth_recipes` VALUES (1393,0,0,69,0,0,0,0,0,0,0,4101,4243,622,636,638,918,919,951,4370,4509,4155,4155,4155,4155,2,4,6,8,'Remedy');
INSERT INTO `synth_recipes` VALUES (1394,0,0,0,0,0,56,0,0,0,0,4097,4239,4370,4441,4509,0,0,0,0,0,4156,4156,4156,4156,1,1,1,1,'Mulsum');
INSERT INTO `synth_recipes` VALUES (1395,0,2035,18,0,0,0,0,0,0,0,4101,4243,914,914,914,943,943,943,2131,0,4157,4157,4157,4157,3,3,3,3,'Poison Potion');
INSERT INTO `synth_recipes` VALUES (1396,0,0,18,0,0,0,0,0,0,0,4101,4243,914,943,0,0,0,0,0,0,4157,4157,4157,4157,1,1,1,1,'Poison Potion');
INSERT INTO `synth_recipes` VALUES (1397,1,0,80,0,0,0,0,0,0,0,4100,4242,16909,0,0,0,0,0,0,0,4158,707,651,657,1,1,1,1,'Venom Potion');
INSERT INTO `synth_recipes` VALUES (1398,0,2035,68,0,0,0,0,0,0,0,4101,4243,914,914,914,944,944,944,2131,0,4158,4158,4158,4158,3,3,3,3,'Venom Potion');
INSERT INTO `synth_recipes` VALUES (1399,0,0,68,0,0,0,0,0,0,0,4101,4243,914,944,0,0,0,0,0,0,4158,4158,4158,4158,1,1,1,1,'Venom Potion');
INSERT INTO `synth_recipes` VALUES (1400,1,0,91,0,0,0,0,0,0,0,4100,4242,16910,0,0,0,0,0,0,0,4159,707,1234,657,1,1,6,1,'Paralyze Potion');
INSERT INTO `synth_recipes` VALUES (1401,0,2035,78,0,0,0,0,0,0,0,4101,4243,914,914,914,945,945,945,2131,0,4159,4159,4159,4159,3,3,3,3,'Paralyze Potion');
INSERT INTO `synth_recipes` VALUES (1402,0,0,78,0,0,0,0,0,0,0,4101,4243,914,945,0,0,0,0,0,0,4159,4159,4159,4159,1,1,1,1,'Paralyze Potion');
INSERT INTO `synth_recipes` VALUES (1403,0,2035,56,0,0,0,0,0,0,0,4101,4243,636,636,952,952,2131,4374,4374,0,4161,4161,4161,4161,2,4,6,8,'Sleeping Potion');
INSERT INTO `synth_recipes` VALUES (1404,0,0,56,0,0,0,0,0,0,0,4101,4243,636,952,4374,0,0,0,0,0,4161,4161,4161,4161,1,2,3,4,'Sleeping Potion');
INSERT INTO `synth_recipes` VALUES (1405,0,0,8,0,0,0,0,0,0,0,4100,4242,914,4443,0,0,0,0,0,0,4162,4162,4162,4162,2,4,6,8,'Silencing Potion');
INSERT INTO `synth_recipes` VALUES (1406,0,0,8,0,0,0,0,0,0,0,4100,4242,914,5447,0,0,0,0,0,0,4162,4162,4162,4162,2,4,6,8,'Silencing Potion');
INSERT INTO `synth_recipes` VALUES (1407,0,0,8,0,0,0,0,0,0,0,4100,4242,4509,4565,4565,0,0,0,0,0,4162,4162,4162,4162,1,2,3,4,'Silencing Potion');
INSERT INTO `synth_recipes` VALUES (1408,0,0,7,0,0,0,0,0,0,0,4101,4243,612,4368,4447,0,0,0,0,0,4162,4162,4162,4162,1,2,3,4,'Silencing Potion');
INSERT INTO `synth_recipes` VALUES (1409,0,0,28,0,0,0,0,0,0,0,4100,4242,914,4361,0,0,0,0,0,0,4163,4163,4163,4163,2,4,6,8,'Blinding Potion');
INSERT INTO `synth_recipes` VALUES (1410,0,2035,27,0,0,0,0,0,0,0,4101,4243,621,621,952,952,2131,4374,4374,0,4163,4163,4163,4163,2,4,6,8,'Blinding Potion');
INSERT INTO `synth_recipes` VALUES (1411,0,0,27,0,0,0,0,0,0,0,4101,4243,621,952,4374,0,0,0,0,0,4163,4163,4163,4163,1,2,3,4,'Blinding Potion');
INSERT INTO `synth_recipes` VALUES (1412,0,0,36,0,0,0,0,0,0,0,4102,4244,557,933,933,0,0,0,0,0,4164,4164,4164,4164,8,10,11,12,'Prism Powder');
INSERT INTO `synth_recipes` VALUES (1413,0,2035,41,0,0,0,0,0,0,0,4102,4244,933,933,933,933,1109,1109,2131,0,4164,4164,4164,4164,12,12,12,12,'Prism Powder');
INSERT INTO `synth_recipes` VALUES (1414,0,0,41,0,0,0,0,0,0,0,4102,4244,933,933,1109,0,0,0,0,0,4164,4164,4164,4164,6,8,10,12,'Prism Powder');
INSERT INTO `synth_recipes` VALUES (1415,0,0,29,0,0,0,0,0,0,0,4101,4243,633,913,913,0,0,0,0,0,4165,4165,4165,4165,2,4,6,8,'Silent Oil');
INSERT INTO `synth_recipes` VALUES (1416,0,0,24,0,0,0,0,0,0,0,4101,4243,637,913,913,0,0,0,0,0,4165,4165,4165,4165,4,8,10,12,'Silent Oil');
INSERT INTO `synth_recipes` VALUES (1417,0,2035,10,0,0,0,0,0,0,0,4098,4240,633,633,636,636,638,638,2131,0,4166,4166,4166,4166,2,4,6,8,'Deodorizer');
INSERT INTO `synth_recipes` VALUES (1418,0,0,10,0,0,0,0,0,0,0,4098,4240,633,636,638,0,0,0,0,0,4166,4166,4166,4166,1,2,3,4,'Deodorizer');
INSERT INTO `synth_recipes` VALUES (1419,0,0,15,0,0,0,0,0,0,0,4099,4241,947,1134,1134,0,0,0,0,0,4167,4167,4167,4167,33,66,99,99,'Cracker');
INSERT INTO `synth_recipes` VALUES (1420,0,0,25,0,0,0,0,0,0,0,4099,4241,947,1134,1241,0,0,0,0,0,4168,4168,4168,4168,33,66,99,99,'Twinkle Shower');
INSERT INTO `synth_recipes` VALUES (1421,0,0,35,0,0,0,0,0,0,0,4099,4241,947,949,1134,1134,0,0,0,0,4169,4169,4169,4169,33,66,99,99,'Little Comet');
INSERT INTO `synth_recipes` VALUES (1422,0,0,42,0,0,0,0,0,0,0,4101,4243,541,0,0,0,0,0,0,0,4171,4171,4171,4171,1,2,3,4,'Vitriol');
INSERT INTO `synth_recipes` VALUES (1423,0,2035,43,0,0,0,0,0,0,0,4101,4243,953,953,953,953,953,953,2131,0,4171,4171,4171,4171,3,6,9,12,'Vitriol');
INSERT INTO `synth_recipes` VALUES (1424,0,0,43,0,0,0,0,0,0,0,4101,4243,953,953,0,0,0,0,0,0,4171,4171,4171,4171,1,2,3,4,'Vitriol');
INSERT INTO `synth_recipes` VALUES (1425,0,0,65,0,0,0,0,0,0,28,4099,4241,928,947,1134,1230,0,0,0,0,4183,4183,4183,4183,33,66,99,99,'Konron Hassen');
INSERT INTO `synth_recipes` VALUES (1426,0,0,38,0,0,0,0,0,0,31,4099,4241,704,947,1230,0,0,0,0,0,4184,4184,4184,4184,33,66,99,99,'Kongou Inaho');
INSERT INTO `synth_recipes` VALUES (1427,0,0,46,0,11,0,0,0,0,53,4099,4241,705,818,947,1240,0,0,0,0,4185,4185,4185,4185,33,66,99,99,'Meifu Goma');
INSERT INTO `synth_recipes` VALUES (1428,0,0,73,0,41,0,0,0,0,26,4099,4241,829,928,947,947,1134,1239,0,0,4186,4186,4186,4186,33,66,99,99,'Airborne');
INSERT INTO `synth_recipes` VALUES (1429,0,0,92,0,0,0,0,0,0,0,4101,4243,919,941,1443,4370,4509,0,0,0,4199,4199,4199,4199,1,1,1,1,'Strength Potion');
INSERT INTO `synth_recipes` VALUES (1430,0,0,92,0,0,0,0,0,0,0,4101,4243,920,1410,1443,4370,4509,0,0,0,4201,4201,4201,4201,1,1,1,1,'Dexterity Potion');
INSERT INTO `synth_recipes` VALUES (1431,0,0,92,0,0,0,0,0,0,0,4101,4243,636,926,1443,4370,4509,0,0,0,4203,4203,4203,4203,1,1,1,1,'Vitality Potion');
INSERT INTO `synth_recipes` VALUES (1432,0,0,92,0,0,0,0,0,0,0,4101,4243,939,1411,1443,4370,4509,0,0,0,4205,4205,4205,4205,1,1,1,1,'Agility Potion');
INSERT INTO `synth_recipes` VALUES (1433,0,0,92,0,0,0,0,0,0,0,4101,4243,927,1412,1443,4370,4509,0,0,0,4207,4207,4207,4207,1,1,1,1,'Int. Potion');
INSERT INTO `synth_recipes` VALUES (1434,0,0,92,0,0,0,0,0,0,0,4101,4243,922,1120,1443,4370,4509,0,0,0,4209,4209,4209,4209,1,1,1,1,'Mind Potion');
INSERT INTO `synth_recipes` VALUES (1435,0,0,92,0,0,0,0,0,0,0,4101,4243,1413,1443,4368,4370,4509,0,0,0,4211,4211,4211,4211,1,1,1,1,'Charisma Potion');
INSERT INTO `synth_recipes` VALUES (1436,0,0,93,0,0,0,0,0,0,0,4098,4240,842,842,842,842,842,842,913,913,4213,4213,4213,4213,1,1,1,1,'Icarus Wing');
INSERT INTO `synth_recipes` VALUES (1437,0,0,54,0,0,0,0,0,0,0,4102,4244,947,1134,1241,1241,4164,0,0,0,4215,4215,4215,4215,33,66,99,99,'Popstar');
INSERT INTO `synth_recipes` VALUES (1438,0,0,70,0,0,0,0,10,0,0,4097,4239,850,933,936,4154,4509,0,0,0,4216,4216,4216,4216,33,66,99,99,'Brilliant Snow');
INSERT INTO `synth_recipes` VALUES (1439,0,0,43,0,0,0,19,0,0,0,4102,4244,744,917,1241,4164,0,0,0,0,4217,4217,4217,4217,33,66,99,99,'Sparkling Hand'); -- sparkling hand (alch 43, gold 19)
INSERT INTO `synth_recipes` VALUES (1440,0,0,78,0,0,0,0,0,0,45,4099,4241,706,947,947,1134,1239,1241,0,0,4218,4218,4218,4218,33,66,99,99,'Air Rider');
INSERT INTO `synth_recipes` VALUES (1441,0,0,0,0,0,99,0,0,0,0,4103,4245,920,1444,4273,4378,4509,0,0,0,4234,4234,4234,4234,1,1,1,1,'Cursed Beverage');
INSERT INTO `synth_recipes` VALUES (1442,0,0,0,0,0,100,0,0,0,0,4101,4243,4273,4274,4370,4508,4509,0,0,0,4235,4235,4235,4235,1,1,1,1,'Cursed Soup');
INSERT INTO `synth_recipes` VALUES (1443,0,0,99,0,0,0,0,0,0,0,4103,4245,914,944,945,1519,4509,0,0,0,4246,4246,4246,4246,1,1,1,1,'Cantarella');
INSERT INTO `synth_recipes` VALUES (1444,0,0,84,0,0,0,0,0,0,23,4099,4241,947,957,1134,1134,0,0,0,0,4256,4256,4256,4256,33,66,99,99,'Ouka Ranman');
INSERT INTO `synth_recipes` VALUES (1445,0,0,97,0,0,0,0,0,0,0,4102,4244,821,846,846,1109,4164,0,0,0,4257,4257,4257,4257,33,66,99,99,'Papillion');
INSERT INTO `synth_recipes` VALUES (1446,0,0,0,0,0,99,0,0,0,0,4096,4238,627,628,1471,1472,1524,4509,0,0,4270,4270,4270,4270,9,12,12,12,'Swt. Rice Cake');
INSERT INTO `synth_recipes` VALUES (1447,0,0,0,0,0,95,0,0,0,15,4096,4238,627,704,936,1471,4359,4450,4509,0,4271,4271,4271,4271,3,6,9,12,'Rice Dumpling');
INSERT INTO `synth_recipes` VALUES (1448,0,0,0,0,0,82,0,0,0,0,4100,4242,4454,0,0,0,0,0,0,0,4275,4275,4275,4275,4,6,8,10,'Emperor Roe');
INSERT INTO `synth_recipes` VALUES (1449,0,0,0,0,0,82,0,0,0,0,4100,4242,5462,0,0,0,0,0,0,0,4275,4275,4275,4275,4,6,8,10,'Emperor Roe');
INSERT INTO `synth_recipes` VALUES (1450,0,0,0,0,0,92,0,0,0,0,4103,4245,936,4275,0,0,0,0,0,0,4276,4276,4276,4276,3,3,3,3,'Flint Caviar');
INSERT INTO `synth_recipes` VALUES (1451,0,0,0,0,0,94,0,0,0,0,4096,4238,620,624,936,4276,4509,0,0,0,4277,4278,4278,4278,2,1,2,2,'Tonosama R.ball');
INSERT INTO `synth_recipes` VALUES (1452,0,0,0,0,0,92,0,0,0,0,4098,4240,625,4276,4304,4382,4389,4461,4485,4571,4279,5185,5185,5185,1,1,1,1,'Tavnazian Salad');
INSERT INTO `synth_recipes` VALUES (1453,0,0,0,0,0,76,0,0,0,0,4096,4238,618,623,1475,1590,4472,4509,4571,0,4296,4296,4296,4296,1,1,1,1,'Green Curry');
INSERT INTO `synth_recipes` VALUES (1454,0,0,0,0,0,94,0,0,0,0,4096,4238,626,1475,4361,4373,4388,4480,4509,0,4297,4297,4297,4297,1,1,1,1,'Black Curry');
INSERT INTO `synth_recipes` VALUES (1455,0,0,0,0,0,94,0,0,0,0,4096,4238,626,1475,4373,4388,4509,5450,5455,0,4297,4297,4297,4297,1,1,1,1,'Black Curry');
INSERT INTO `synth_recipes` VALUES (1456,0,0,0,0,0,101,0,0,0,0,4096,4238,612,1475,1555,4272,4389,4390,4509,0,4298,4298,4298,4298,1,1,1,1,'Red Curry'); -- red curry (cook 101) https://www.bg-wiki.com/bg/Red_Curry
INSERT INTO `synth_recipes` VALUES (1457,0,0,0,0,0,51,0,0,0,0,4101,4243,4370,4378,4392,4392,0,0,0,0,4299,4299,4299,4299,1,1,1,1,'Orange Au Lait');
INSERT INTO `synth_recipes` VALUES (1458,0,0,0,0,0,62,0,0,0,0,4101,4243,4363,4363,4370,4378,0,0,0,0,4300,4300,4300,4300,1,1,1,1,'Apple Au Lait');
INSERT INTO `synth_recipes` VALUES (1459,0,0,0,0,0,72,0,0,0,0,4101,4243,4352,4352,4370,4378,0,0,0,0,4301,4301,4301,4301,1,1,1,1,'Pear Au Lait');
INSERT INTO `synth_recipes` VALUES (1460,0,0,0,0,0,81,0,0,0,0,4101,4243,4370,4378,4468,4468,0,0,0,0,4302,4302,4302,4302,1,1,1,1,'Pamama Au Lait');
INSERT INTO `synth_recipes` VALUES (1461,0,0,0,0,0,91,0,0,0,0,4101,4243,4274,4274,4370,4378,0,0,0,0,4303,4303,4303,4303,1,1,1,1,'Persikos Au Lait');
INSERT INTO `synth_recipes` VALUES (1462,0,0,0,0,0,95,0,0,0,0,4096,4238,619,623,626,633,936,4272,4389,4444,4350,4350,4350,4350,1,1,1,1,'Dragon Steak');
INSERT INTO `synth_recipes` VALUES (1463,0,0,0,0,0,97,0,0,0,0,4096,4238,614,616,638,936,4362,4385,4386,4441,4353,4353,4353,4353,1,2,3,4,'Sea Bass Croute');
INSERT INTO `synth_recipes` VALUES (1464,0,0,0,0,0,8,0,0,0,0,4099,4241,621,625,4364,4366,4380,4390,0,0,4355,4266,4266,4266,1,1,1,1,'Salmon Sub');
INSERT INTO `synth_recipes` VALUES (1465,0,0,0,0,0,44,0,0,0,0,4096,4238,610,615,936,4370,4509,0,0,0,4356,4292,4292,4292,4,4,4,4,'White Bread');
INSERT INTO `synth_recipes` VALUES (1466,0,0,0,0,0,34,0,0,0,0,4096,4238,611,936,4509,0,0,0,0,0,4364,4591,4591,4591,4,4,4,4,'Black Bread');
INSERT INTO `synth_recipes` VALUES (1467,0,0,0,0,0,12,0,0,0,0,4098,4240,912,912,912,912,0,0,0,0,4370,4370,4370,4370,4,6,9,12,'Honey');
INSERT INTO `synth_recipes` VALUES (1468,0,0,0,0,0,6,0,0,0,0,4096,4238,622,4358,0,0,0,0,0,0,4371,4516,4516,4516,1,1,1,1,'Grilled Hare');
INSERT INTO `synth_recipes` VALUES (1469,0,0,0,0,0,26,0,0,0,0,4097,4239,622,936,4372,0,0,0,0,0,4376,4518,4518,4518,2,2,2,2,'Meat Jerky');
INSERT INTO `synth_recipes` VALUES (1470,0,0,0,0,0,29,0,0,0,9,4096,4238,693,936,4379,0,0,0,0,0,4380,4380,4380,4380,4,4,4,4,'Smoked Salmon');
INSERT INTO `synth_recipes` VALUES (1471,0,0,0,0,0,38,0,0,0,0,4096,4238,612,614,4387,4435,0,0,0,0,4381,4381,4574,4574,6,12,6,12,'Meat Mithkabob');
INSERT INTO `synth_recipes` VALUES (1472,0,0,0,0,0,38,0,0,0,0,4096,4238,612,614,4387,5581,0,0,0,0,4381,4381,4574,4574,6,12,6,12,'Meat Mithkabob');
INSERT INTO `synth_recipes` VALUES (1473,0,0,0,0,0,51,0,0,0,0,4096,4238,610,615,936,4362,4509,0,0,0,4391,4391,5182,5182,33,99,33,99,'Bretzel');
INSERT INTO `synth_recipes` VALUES (1474,0,0,0,0,0,53,0,0,0,0,4096,4238,610,615,936,4509,4570,0,0,0,4391,4391,5182,5182,33,99,33,99,'Bretzel');
INSERT INTO `synth_recipes` VALUES (1475,0,0,0,0,0,80,0,0,0,0,4096,4238,610,615,627,4392,4392,4570,0,0,4393,4332,4332,4332,1,1,1,1,'Orange Kuchen');
INSERT INTO `synth_recipes` VALUES (1476,0,0,0,0,0,58,0,0,0,0,4096,4238,610,615,617,627,4362,4509,0,0,4394,4576,4576,4576,33,33,33,99,'Ginger Cookie');
INSERT INTO `synth_recipes` VALUES (1477,0,0,0,0,0,60,0,0,0,0,4096,4238,610,615,617,627,4509,4570,0,0,4394,4576,4576,4576,33,33,33,99,'Ginger Cookie');
INSERT INTO `synth_recipes` VALUES (1478,0,0,0,0,0,66,0,0,0,0,4096,4238,610,615,936,4370,4509,4578,0,0,4396,4396,4396,4396,4,4,4,4,'Sausage Roll');
INSERT INTO `synth_recipes` VALUES (1479,0,0,0,0,0,47,0,0,0,0,4096,4238,610,615,627,628,4362,4509,0,0,4397,4520,4520,4520,33,33,33,99,'Cinna-cookie');
INSERT INTO `synth_recipes` VALUES (1480,0,0,0,0,0,49,0,0,0,0,4096,4238,610,615,627,628,4509,4570,0,0,4397,4520,4520,4520,33,33,33,99,'Cinna-cookie');
INSERT INTO `synth_recipes` VALUES (1481,0,0,0,0,0,49,0,0,0,0,4096,4238,4360,4361,4399,4484,4484,0,0,0,4398,4398,4575,4575,6,12,6,12,'Fish Mithkabob');
INSERT INTO `synth_recipes` VALUES (1482,0,0,0,0,0,49,0,0,0,0,4096,4238,5449,5452,5455,5456,5456,0,0,0,4398,4398,4398,4398,1,1,1,1,'Fish Mithkabob');
INSERT INTO `synth_recipes` VALUES (1483,0,0,0,0,0,32,0,0,0,0,4096,4238,936,4354,0,0,0,0,0,0,4404,4587,4587,4587,1,1,1,1,'Roast Trout');
INSERT INTO `synth_recipes` VALUES (1484,0,0,0,0,0,32,0,0,0,0,4096,4238,936,5461,0,0,0,0,0,0,4404,4587,4587,4587,1,1,1,1,'Roast Trout');
INSERT INTO `synth_recipes` VALUES (1485,0,0,0,0,0,31,0,0,0,0,4096,4238,620,624,936,4509,0,0,0,0,4405,4604,4604,4604,4,2,3,4,'Rice Ball');
INSERT INTO `synth_recipes` VALUES (1486,0,0,0,0,0,23,0,0,0,0,4096,4238,615,627,628,4363,0,0,0,0,4406,4336,4336,4336,1,1,1,1,'Baked Apple');
INSERT INTO `synth_recipes` VALUES (1487,0,0,0,0,0,54,0,0,0,0,4103,4245,620,936,4289,0,0,0,0,0,4407,5186,5186,5186,1,1,1,1,'Carp Sushi');
INSERT INTO `synth_recipes` VALUES (1488,0,0,0,0,0,54,0,0,0,0,4103,4245,620,936,4401,0,0,0,0,0,4407,5186,5186,5186,1,1,1,1,'Carp Sushi');
INSERT INTO `synth_recipes` VALUES (1489,0,0,0,0,0,14,0,0,0,0,4096,4238,610,629,633,936,0,0,0,0,4408,5181,5181,5181,4,6,9,12,'Tortilla');
INSERT INTO `synth_recipes` VALUES (1490,0,0,0,0,0,4,0,0,0,0,4096,4238,4362,4509,0,0,0,0,0,0,4409,4532,4532,4532,1,1,1,1,'Hard-boiled Egg');
INSERT INTO `synth_recipes` VALUES (1491,0,0,0,0,0,6,0,0,0,0,4096,4238,4509,4570,0,0,0,0,0,0,4409,4532,4532,4532,1,1,1,1,'Hard-boiled Egg');
INSERT INTO `synth_recipes` VALUES (1492,0,0,0,0,0,16,0,0,0,0,4096,4238,936,4373,4373,0,0,0,0,0,4410,4343,4343,4343,1,1,1,1,'Roast Mushroom');
INSERT INTO `synth_recipes` VALUES (1493,0,0,0,0,0,16,0,0,0,0,4096,4238,936,4374,4374,0,0,0,0,0,4410,4343,4343,4343,1,1,1,1,'Roast Mushroom');
INSERT INTO `synth_recipes` VALUES (1494,0,0,0,0,0,16,0,0,0,0,4096,4238,936,4375,4375,0,0,0,0,0,4410,4343,4343,4343,1,1,1,1,'Roast Mushroom');
INSERT INTO `synth_recipes` VALUES (1495,0,0,0,0,0,75,0,0,0,0,4096,4238,615,616,626,936,4359,4387,4389,4450,4411,4322,4322,4322,4,4,4,4,'Dhalmel Pie');
INSERT INTO `synth_recipes` VALUES (1496,0,0,0,0,0,48,0,0,0,0,4096,4238,616,627,628,4362,4363,0,0,0,4413,4320,4320,4320,4,4,4,4,'Apple Pie');
INSERT INTO `synth_recipes` VALUES (1497,0,0,0,0,0,50,0,0,0,0,4096,4238,616,627,628,4363,4570,0,0,0,4413,4320,4320,4320,4,4,4,4,'Apple Pie');
INSERT INTO `synth_recipes` VALUES (1498,0,0,0,0,0,90,0,0,0,0,4096,4238,610,616,627,1111,4365,4378,4570,0,4414,4339,4339,4339,4,4,4,4,'Rolanberry Pie');
INSERT INTO `synth_recipes` VALUES (1499,0,0,0,0,0,2,0,0,0,0,4096,4238,629,0,0,0,0,0,0,0,4415,4334,4334,4334,1,1,1,1,'Roasted Corn');
INSERT INTO `synth_recipes` VALUES (1500,0,0,0,0,0,18,0,0,0,0,4096,4238,618,618,618,622,4387,4509,0,0,4416,4327,4327,4327,1,1,1,1,'Pea Soup');
INSERT INTO `synth_recipes` VALUES (1501,0,0,0,0,0,55,0,0,0,0,4096,4238,626,936,4362,4509,0,0,0,0,4417,4521,4521,4521,1,1,1,1,'Egg Soup');
INSERT INTO `synth_recipes` VALUES (1502,0,0,0,0,0,57,0,0,0,0,4096,4238,626,936,4509,4570,0,0,0,0,4417,4521,4521,4521,1,1,1,1,'Egg Soup');
INSERT INTO `synth_recipes` VALUES (1503,0,0,0,0,0,71,0,0,0,0,4096,4238,617,898,936,4375,4389,4402,4504,4509,4418,4337,4337,4337,1,1,1,1,'Turtle Soup');
INSERT INTO `synth_recipes` VALUES (1504,0,0,0,0,0,35,0,0,0,0,4096,4238,936,4375,4447,4450,4509,0,0,0,4419,4333,4333,4333,1,1,1,1,'Mushroom Soup');
INSERT INTO `synth_recipes` VALUES (1505,0,0,0,0,0,48,0,0,0,0,4096,4238,622,623,4387,4425,4509,0,0,0,4420,4341,4341,4341,1,1,1,1,'Tomato Soup');
INSERT INTO `synth_recipes` VALUES (1506,0,0,0,0,0,45,0,0,0,0,4096,4238,622,4368,4387,4425,4509,0,0,0,4420,4341,4341,4341,1,1,1,1,'Tomato Soup');
INSERT INTO `synth_recipes` VALUES (1507,0,0,0,0,0,62,0,0,0,0,4096,4238,616,627,628,4362,4412,0,0,0,4421,4523,4523,4523,4,4,4,4,'Melon Pie');
INSERT INTO `synth_recipes` VALUES (1508,0,0,0,0,0,64,0,0,0,0,4096,4238,616,627,628,4412,4570,0,0,0,4421,4523,4523,4523,4,4,4,4,'Melon Pie');
INSERT INTO `synth_recipes` VALUES (1509,0,0,0,0,0,10,0,0,0,0,4101,4243,4392,4392,4392,4392,0,0,0,0,4422,4422,4422,4422,1,1,1,1,'Orange Juice');
INSERT INTO `synth_recipes` VALUES (1510,0,0,0,0,0,20,0,0,0,0,4101,4243,4363,4363,4363,4363,0,0,0,0,4423,4423,4423,4423,1,1,1,1,'Apple Juice');
INSERT INTO `synth_recipes` VALUES (1511,0,0,0,0,0,40,0,0,0,0,4101,4243,4412,4491,0,0,0,0,0,0,4424,4424,4424,4424,1,1,1,1,'Melon Juice');
INSERT INTO `synth_recipes` VALUES (1512,0,0,0,0,0,43,0,0,0,0,4101,4243,936,4390,4390,4390,0,0,0,0,4425,4425,4425,4425,1,1,1,1,'Tomato Juice');
INSERT INTO `synth_recipes` VALUES (1513,0,0,0,0,0,65,0,0,0,0,4096,4238,630,638,936,4378,4509,0,0,0,4430,4522,4522,4522,1,1,1,1,'Pumpkin Soup');
INSERT INTO `synth_recipes` VALUES (1514,0,0,0,0,0,70,0,0,0,0,4096,4238,610,619,628,936,4359,4387,4390,4509,4433,4589,4589,4589,1,1,1,1,'Dhalmel Stew');
INSERT INTO `synth_recipes` VALUES (1515,0,0,0,0,0,74,0,0,0,0,4096,4238,614,615,620,626,633,4375,4448,4509,4434,4330,4330,4330,1,1,1,1,'Mushroom Risotto');
INSERT INTO `synth_recipes` VALUES (1516,0,0,0,0,0,22,0,0,0,0,4096,4238,615,619,0,0,0,0,0,0,4436,4282,4282,4282,1,1,1,1,'Baked Popoto');
INSERT INTO `synth_recipes` VALUES (1517,0,0,0,0,0,17,0,0,0,0,4096,4238,614,622,4372,0,0,0,0,0,4437,4335,4335,4335,1,1,1,1,'Roast Mutton');
INSERT INTO `synth_recipes` VALUES (1518,0,0,0,0,0,29,0,0,0,0,4096,4238,626,633,4359,0,0,0,0,0,4438,4519,4519,4519,1,1,1,1,'Dhalmel Steak');
INSERT INTO `synth_recipes` VALUES (1519,0,0,0,0,0,77,0,0,0,0,4096,4238,619,626,633,936,4372,4387,4390,4509,4439,4284,4284,4284,1,1,1,1,'Navarin');
INSERT INTO `synth_recipes` VALUES (1520,0,0,0,0,0,77,0,0,0,0,4096,4238,619,626,936,4378,4387,4389,4461,4509,4440,4440,4440,4440,1,1,1,1,'Whitefish Stew');
INSERT INTO `synth_recipes` VALUES (1521,0,0,0,0,0,77,0,0,0,0,4096,4238,619,626,936,4378,4387,4389,4509,5454,4440,4440,4440,4440,1,1,1,1,'Whitefish Stew');
INSERT INTO `synth_recipes` VALUES (1522,0,0,0,0,0,50,0,0,0,0,4103,4245,4431,4431,4431,4431,0,0,0,0,4441,4441,4441,4441,1,1,1,1,'Grape Juice');
INSERT INTO `synth_recipes` VALUES (1523,0,0,0,0,0,30,0,0,0,0,4101,4243,4432,4432,0,0,0,0,0,0,4442,4442,4442,4442,1,1,1,1,'Pineapple Juice');
INSERT INTO `synth_recipes` VALUES (1524,0,0,0,0,0,85,0,0,0,0,4096,4238,615,616,627,628,630,4378,4509,4570,4446,4525,4525,4525,4,4,4,4,'Pumpkin Pie');
INSERT INTO `synth_recipes` VALUES (1525,0,0,0,0,0,81,0,0,0,0,4096,4238,617,619,898,936,4374,4451,4509,4570,4452,4285,4285,4285,1,1,1,1,'Shark Fin Soup');
INSERT INTO `synth_recipes` VALUES (1526,0,0,0,0,0,71,0,0,0,0,4096,4238,625,930,939,939,939,1111,4382,4509,4453,4340,4340,4340,1,1,1,1,'Eyeball Soup');
INSERT INTO `synth_recipes` VALUES (1527,0,0,0,0,0,5,0,0,0,0,4096,4238,768,768,768,4509,0,0,0,0,4455,4592,4592,4592,1,1,1,1,'Pebble Soup');
INSERT INTO `synth_recipes` VALUES (1528,0,0,0,0,0,27,0,0,0,0,4096,4238,623,936,4400,4509,0,0,0,0,4456,4342,4342,4342,1,1,1,1,'Boiled Crab');
INSERT INTO `synth_recipes` VALUES (1529,0,0,0,0,0,53,0,0,0,0,4096,4238,633,4429,0,0,0,0,0,0,4457,4588,4588,4588,1,1,1,1,'Eel Kabob');
INSERT INTO `synth_recipes` VALUES (1530,0,0,0,0,0,53,0,0,0,0,4096,4238,633,5458,0,0,0,0,0,0,4457,4457,4457,4457,1,1,1,1,'Eel Kabob');
INSERT INTO `synth_recipes` VALUES (1531,0,0,0,0,0,61,0,0,0,0,4096,4238,631,880,936,952,4357,4448,4509,0,4458,4328,4328,4328,4,4,4,4,'Goblin Bread');
INSERT INTO `synth_recipes` VALUES (1532,0,0,0,0,0,33,0,0,0,0,4096,4238,614,615,4361,0,0,0,0,0,4459,4267,4267,4267,1,1,1,1,'Nebimonite Bake');
INSERT INTO `synth_recipes` VALUES (1533,0,0,0,0,0,61,0,0,0,0,4103,4245,936,4378,0,0,0,0,0,0,4460,4593,4593,4593,4,4,4,4,'Stone Cheese');
INSERT INTO `synth_recipes` VALUES (1534,0,0,0,0,0,59,0,0,0,0,4096,4238,612,620,936,4509,0,0,0,0,4466,4281,4281,4281,33,33,33,99,'Spicy Cracker');
INSERT INTO `synth_recipes` VALUES (1535,0,0,0,0,0,49,0,0,0,0,4096,4238,614,620,936,4509,0,0,0,0,4467,4467,4280,4280,33,99,33,99,'Garlic Cracker');
INSERT INTO `synth_recipes` VALUES (1536,0,0,0,0,0,66,0,0,0,0,4096,4238,4362,4366,4389,4509,0,0,0,0,4487,4595,4595,4595,1,1,1,1,'Colored Egg');
INSERT INTO `synth_recipes` VALUES (1537,0,0,0,0,0,68,0,0,0,0,4096,4238,4366,4389,4509,4570,0,0,0,0,4487,4595,4595,4595,1,1,1,1,'Colored Egg');
INSERT INTO `synth_recipes` VALUES (1538,0,0,0,0,0,38,0,0,0,0,4096,4238,630,913,0,0,0,0,0,0,4488,4488,4488,4488,1,1,1,1,'Jack-o-lantern');
INSERT INTO `synth_recipes` VALUES (1539,0,0,0,0,0,26,0,0,0,0,4096,4238,610,636,4382,4444,4509,4571,0,0,4489,4534,4534,4534,1,1,1,1,'Vegetable Gruel');
INSERT INTO `synth_recipes` VALUES (1540,0,0,0,0,0,28,0,0,0,0,4096,4238,620,636,4367,4382,4444,4509,0,0,4489,4534,4534,4534,1,1,1,1,'Vegetable Gruel');
INSERT INTO `synth_recipes` VALUES (1541,0,0,0,0,0,46,0,0,0,0,4097,4239,622,936,4482,0,0,0,0,0,4490,5183,5183,5183,4,4,4,4,'Pickled Herring'); -- pickled_herring
INSERT INTO `synth_recipes` VALUES (1542,0,0,0,0,0,24,0,0,0,0,4096,4238,611,631,4370,4509,0,0,0,0,4492,4533,4533,4533,1,1,1,1,'Puls');
INSERT INTO `synth_recipes` VALUES (1543,0,0,0,0,0,70,0,0,0,0,4096,4238,627,635,638,4378,4509,0,0,0,4494,4524,4524,4524,1,1,1,1,'San Dorian Tea');
INSERT INTO `synth_recipes` VALUES (1544,0,0,0,0,0,23,0,0,0,0,4103,4245,632,632,632,951,4370,4378,4443,4505,4495,4324,4324,4324,33,33,66,99,'Gob. Chocolate');
INSERT INTO `synth_recipes` VALUES (1545,0,0,0,0,0,37,0,0,0,0,4096,4238,627,632,632,632,632,4378,0,0,4496,4497,4497,4497,12,1,1,1,'Bbl. Chocolate');
INSERT INTO `synth_recipes` VALUES (1546,0,0,0,0,0,79,0,0,0,0,4096,4238,627,632,632,632,632,4370,4378,4509,4498,4283,4283,4283,1,1,1,1,'Chocomilk');
INSERT INTO `synth_recipes` VALUES (1547,0,0,0,0,0,34,0,0,0,0,4096,4238,610,936,4509,0,0,0,0,0,4499,4573,4573,4573,4,4,4,4,'Iron Bread');
INSERT INTO `synth_recipes` VALUES (1548,0,2042,0,0,0,86,0,0,0,0,4103,4245,627,639,639,2113,4441,0,0,0,4502,5554,5554,5554,1,1,1,1,'Marron Glace');
INSERT INTO `synth_recipes` VALUES (1549,0,0,0,0,0,86,0,0,0,0,4103,4245,627,639,639,4441,0,0,0,0,4502,4269,4269,4269,1,1,1,1,'Marron Glace');
INSERT INTO `synth_recipes` VALUES (1550,0,0,0,0,0,69,0,0,0,0,4096,4238,612,4366,4372,4390,4408,4425,4460,0,4506,4348,4348,4348,1,1,1,1,'Mutton Tortilla');
INSERT INTO `synth_recipes` VALUES (1551,0,0,0,0,0,76,0,0,0,0,4096,4238,610,614,626,936,4358,4460,4509,4570,4507,4349,4349,4349,1,1,1,1,'Rarab Meatball');
INSERT INTO `synth_recipes` VALUES (1552,1,0,2,0,0,0,0,0,0,0,4100,4242,950,0,0,0,0,0,0,0,4509,4509,4509,4509,3,6,9,12,'Distilled Water');
INSERT INTO `synth_recipes` VALUES (1553,0,0,0,0,0,32,0,0,0,0,4096,4238,610,615,4357,4370,4504,4504,4504,4504,4510,4577,4577,4577,33,33,33,99,'Acorn Cookie');
INSERT INTO `synth_recipes` VALUES (1554,0,0,0,0,0,90,0,0,0,0,4101,4243,4363,4365,4390,4402,0,0,0,0,4512,4512,4512,4512,1,1,1,1,'Vampire Juice');
INSERT INTO `synth_recipes` VALUES (1555,0,0,0,0,0,90,0,0,0,0,4101,4243,4363,4365,4390,5464,0,0,0,0,4512,4512,4512,4512,1,1,1,1,'Vampire Juice');
INSERT INTO `synth_recipes` VALUES (1556,0,0,0,0,0,85,0,0,0,0,4096,4238,619,1475,1554,4377,4378,4387,4509,0,4517,4517,4517,4517,1,1,1,1,'Yellow Curry');
INSERT INTO `synth_recipes` VALUES (1557,0,0,0,0,0,9,0,0,0,0,4096,4238,936,4472,4509,0,0,0,0,0,4535,4338,4338,4338,1,1,1,1,'Boiled Crayfish');
INSERT INTO `synth_recipes` VALUES (1558,0,0,0,0,0,64,0,0,0,0,4096,4238,622,936,4515,0,0,0,0,0,4536,4326,4326,4326,1,1,1,1,'Blackened Frog');
INSERT INTO `synth_recipes` VALUES (1559,0,0,0,0,0,19,0,0,0,0,4096,4238,936,4289,0,0,0,0,0,0,4537,4586,4586,4586,1,1,1,1,'Roast Carp');
INSERT INTO `synth_recipes` VALUES (1560,0,0,0,0,0,19,0,0,0,0,4096,4238,936,4401,0,0,0,0,0,0,4537,4586,4586,4586,1,1,1,1,'Roast Carp');
INSERT INTO `synth_recipes` VALUES (1561,0,0,0,0,0,21,0,0,0,0,4096,4238,936,4464,0,0,0,0,0,0,4538,4585,4585,4585,1,1,1,1,'Roast Pipira');
INSERT INTO `synth_recipes` VALUES (1562,0,0,0,0,0,78,0,0,0,0,4096,4238,616,617,626,4357,4370,4388,4472,4505,4539,4325,4325,4325,4,4,4,4,'Goblin Pie');
INSERT INTO `synth_recipes` VALUES (1563,0,0,0,0,0,82,0,0,0,0,4096,4238,617,627,936,953,4441,4480,4509,4571,4540,4540,4540,4540,1,1,1,1,'Boiled Tuna Head');
INSERT INTO `synth_recipes` VALUES (1564,0,0,0,0,0,80,0,0,0,0,4101,4243,4366,4382,4387,4389,4491,4509,4545,4579,4541,4541,4541,4541,1,1,1,1,'Goblin Drink');
INSERT INTO `synth_recipes` VALUES (1565,0,0,0,0,0,82,0,0,0,0,4101,4243,4366,4382,4387,4389,4491,4509,4545,5125,4541,4541,4541,4541,1,1,1,1,'Goblin Drink');
INSERT INTO `synth_recipes` VALUES (1566,0,0,0,0,0,96,0,0,0,0,4096,4238,610,621,625,1111,4370,4386,4403,4509,4542,5180,5180,5180,1,1,1,1,'Brain Stew');
INSERT INTO `synth_recipes` VALUES (1567,0,0,0,0,0,59,0,0,0,0,4096,4238,612,936,4374,4375,4447,4509,4565,4566,4543,4543,4543,4543,1,1,1,1,'Goblin Mushpot');
INSERT INTO `synth_recipes` VALUES (1568,0,0,0,0,0,86,0,0,0,0,4096,4238,615,619,626,936,4375,4448,4450,4509,4544,4344,4344,4344,1,1,1,1,'Mushroom Stew');
INSERT INTO `synth_recipes` VALUES (1569,0,0,0,0,0,67,0,0,0,0,4096,4238,610,615,627,936,4431,4509,0,0,4546,4546,4546,4546,1,1,1,1,'Raisin Bread');
INSERT INTO `synth_recipes` VALUES (1570,0,0,0,0,0,72,0,0,0,0,4096,4238,614,617,936,4389,4390,4435,4450,4509,4547,4547,4547,4547,1,1,1,1,'Boiled Cockatrice');
INSERT INTO `synth_recipes` VALUES (1571,0,0,0,0,0,88,0,0,0,0,4096,4238,615,626,633,936,4370,4377,4387,4441,4548,4295,4295,4295,1,1,1,1,'Coeurl Saute');
INSERT INTO `synth_recipes` VALUES (1572,0,0,0,0,0,88,0,0,0,0,4096,4238,615,626,633,936,4370,4387,4441,5667,4548,4548,4548,4548,1,1,1,1,'Coeurl Saute');
INSERT INTO `synth_recipes` VALUES (1573,0,0,0,0,0,98,0,0,0,0,4096,4238,614,617,619,626,4272,4382,4387,4509,4549,4549,4549,4549,1,1,1,1,'Dragon Soup'); -- dragon soup (cook 98) https://www.bg-wiki.com/bg/Dragon_Soup
INSERT INTO `synth_recipes` VALUES (1574,0,0,0,0,0,84,0,0,0,0,4096,4238,614,615,620,626,633,638,4461,4509,4550,4268,4268,4268,1,1,1,1,'Bream Risotto');
INSERT INTO `synth_recipes` VALUES (1575,0,0,0,0,0,91,0,0,0,0,4096,4238,614,616,638,936,4357,4379,4441,0,4551,4551,4551,4551,1,2,3,4,'Salmon Croute');
INSERT INTO `synth_recipes` VALUES (1576,0,0,0,0,0,79,0,0,0,0,4096,4238,614,617,627,633,4357,4387,4389,4509,4552,4552,4552,4552,1,1,1,1,'Herb Crawler Eggs');
INSERT INTO `synth_recipes` VALUES (1577,0,0,0,0,0,52,0,0,0,0,4096,4238,615,4367,0,0,0,0,0,0,4553,5184,5184,5184,1,1,1,1,'Batagreen Saute');
INSERT INTO `synth_recipes` VALUES (1578,0,0,0,0,0,80,0,0,0,0,4096,4238,615,623,936,4432,4484,4484,4509,0,4554,4554,4554,4554,1,1,1,1,'Shallops Tropicale');
INSERT INTO `synth_recipes` VALUES (1579,0,0,0,0,0,36,0,0,0,0,4098,4240,625,4365,4366,4389,4390,4432,4445,4468,4555,4321,4321,4321,1,1,1,1,'Windurst Salad');
INSERT INTO `synth_recipes` VALUES (1580,0,2042,0,0,0,54,0,0,0,0,4096,4238,615,627,1111,2112,4357,4365,4378,4509,4556,5555,5555,5555,1,1,1,1,'Icecap Rolanberry');
INSERT INTO `synth_recipes` VALUES (1581,0,0,0,0,0,54,0,0,0,0,4096,4238,615,627,1111,4357,4365,4378,4509,0,4556,4594,4594,4594,1,1,1,1,'Icecap Rolanberry');
INSERT INTO `synth_recipes` VALUES (1582,0,0,0,0,0,84,0,0,0,0,4096,4238,619,622,627,4441,4469,4509,4545,0,4557,4557,4557,4557,1,1,1,1,'Steamed Catfish');
INSERT INTO `synth_recipes` VALUES (1583,0,0,0,0,0,60,0,0,0,0,4103,4245,4445,4503,4503,4503,0,0,0,0,4558,4558,4558,4558,1,1,1,1,'Yagudo Drink');
INSERT INTO `synth_recipes` VALUES (1584,0,0,0,0,0,68,0,0,0,0,4096,4238,615,622,623,626,936,4514,4514,4514,4559,4294,4294,4294,1,1,1,1,'Herb Quus');
INSERT INTO `synth_recipes` VALUES (1585,0,0,0,0,0,25,0,0,0,0,4096,4238,623,936,4366,4382,4387,4388,4389,4509,4560,4323,4323,4323,1,1,1,1,'Vegetable Soup');
INSERT INTO `synth_recipes` VALUES (1586,0,0,0,0,0,87,0,0,0,0,4096,4238,619,626,936,4361,4383,4484,4509,4545,4561,4561,4561,4561,1,1,1,1,'Seafood Stew');
INSERT INTO `synth_recipes` VALUES (1587,0,0,0,0,0,87,0,0,0,0,4096,4238,619,626,936,4509,4545,5453,5455,5456,4561,4561,4561,4561,1,1,1,1,'Seafood Stew');
INSERT INTO `synth_recipes` VALUES (1588,0,0,0,0,0,56,0,0,0,0,4096,4238,610,615,627,4468,4496,4496,4509,4570,4563,4287,4287,4287,1,1,1,1,'Pamama Tart');
INSERT INTO `synth_recipes` VALUES (1589,0,0,0,0,0,89,0,0,0,0,4096,4238,615,626,633,936,4386,4387,4435,4570,4564,4331,4331,4331,1,1,1,1,'Royal Omelette');
INSERT INTO `synth_recipes` VALUES (1590,0,0,0,0,0,55,0,0,0,0,4096,4238,615,4571,0,0,0,0,0,0,4572,4293,4293,4293,1,1,1,1,'Beaugr. Saute');
INSERT INTO `synth_recipes` VALUES (1591,0,0,0,0,0,63,0,0,0,9,4096,4238,626,638,691,936,4372,0,0,0,4578,4578,4578,4578,12,12,12,12,'Sausage');
INSERT INTO `synth_recipes` VALUES (1592,0,0,0,0,0,78,0,0,0,0,4096,4238,622,623,936,4579,0,0,0,0,4581,4329,4329,4329,1,1,1,1,'Blackened Newt');
INSERT INTO `synth_recipes` VALUES (1593,0,0,0,0,0,79,0,0,0,0,4096,4238,622,623,936,5125,0,0,0,0,4581,4329,4329,4329,1,1,1,1,'Blackened Newt');
INSERT INTO `synth_recipes` VALUES (1594,0,0,0,0,0,83,0,0,0,0,4096,4238,610,615,626,633,936,4392,4428,0,4582,4346,4346,4346,1,1,1,1,'Bass Meuniere');
INSERT INTO `synth_recipes` VALUES (1595,0,0,0,0,0,73,0,0,0,0,4096,4238,610,615,626,633,936,4379,0,0,4583,4347,4347,4347,1,1,1,1,'Salmon Meuniere');
INSERT INTO `synth_recipes` VALUES (1596,0,0,0,0,0,93,0,0,0,0,4096,4238,610,615,626,633,936,4378,4384,0,4584,4345,4345,4345,1,1,1,1,'Flounder Meuniere');
INSERT INTO `synth_recipes` VALUES (1597,0,0,0,0,0,93,0,0,0,0,4096,4238,610,615,626,633,936,4378,5457,0,4584,4345,4345,4345,1,1,1,1,'Flounder Meuniere');
INSERT INTO `synth_recipes` VALUES (1598,0,0,0,0,0,41,0,0,0,0,4096,4238,620,624,936,4380,4509,0,0,0,4590,4605,4605,4605,4,2,2,2,'Salmon Rice Ball');
INSERT INTO `synth_recipes` VALUES (1599,0,0,0,0,0,77,0,0,0,0,4096,4238,619,626,936,4378,4384,4387,4389,4509,4601,4601,4601,4601,1,1,1,1,'Sopa Pez Blanco');
INSERT INTO `synth_recipes` VALUES (1600,0,0,0,0,0,77,0,0,0,0,4096,4238,619,626,936,4378,4387,4389,4509,5457,4601,4601,4601,4601,1,1,1,1,'Sopa Pez Blanco');
INSERT INTO `synth_recipes` VALUES (1601,0,0,0,0,0,83,0,0,0,0,4096,4238,636,636,4370,4509,0,0,0,0,4603,4286,4286,4286,1,1,1,1,'Chamomile Tea');
INSERT INTO `synth_recipes` VALUES (1602,0,0,0,0,0,65,0,0,0,0,4096,4238,623,626,633,936,4444,5152,0,0,5142,5157,5157,5157,1,1,1,1,'Bison Steak');
INSERT INTO `synth_recipes` VALUES (1603,0,0,0,0,0,88,0,0,0,0,4099,4241,627,1111,1523,1633,4431,4509,0,0,5144,5158,5158,5158,1,1,1,1,'Crimson Jelly');
INSERT INTO `synth_recipes` VALUES (1604,0,0,0,0,0,74,0,0,0,0,4096,4238,610,619,625,633,4313,4570,5165,0,5145,5159,5159,5159,1,1,1,1,'Fish & Chips'); -- fish and chips (cook 74) https://www.bg-wiki.com/bg/Fish_and_Chips
INSERT INTO `synth_recipes` VALUES (1605,0,0,0,0,0,74,0,0,0,0,4096,4238,610,619,625,633,4483,4483,4570,5165,5145,5159,5159,5159,1,1,1,1,'Fish & Chips');
INSERT INTO `synth_recipes` VALUES (1606,0,0,0,0,0,94,0,0,0,0,4096,4238,615,616,618,936,4362,4386,4389,5152,5146,5156,5156,5156,1,1,1,1,'Hedgehog Pie');
INSERT INTO `synth_recipes` VALUES (1607,0,2042,11,0,0,62,0,0,0,0,4097,4239,610,615,627,633,2112,4378,4570,17306,5147,5556,5556,5556,4,4,6,8,'Snoll Gelato');
INSERT INTO `synth_recipes` VALUES (1608,0,0,11,0,0,62,0,0,0,0,4097,4239,610,615,627,633,4378,4570,17306,0,5147,5155,5155,5155,4,4,6,8,'Snoll Gelato');
INSERT INTO `synth_recipes` VALUES (1609,0,2040,0,0,0,70,0,0,0,0,4099,4241,620,1652,4474,4509,5164,0,0,0,5148,5162,5162,5162,6,6,8,10,'Squid Sushi');
INSERT INTO `synth_recipes` VALUES (1610,0,2040,0,0,0,84,0,0,0,0,4099,4241,620,1652,4384,4509,5164,0,0,0,5149,5163,5163,5163,2,2,3,4,'Sole Sushi');
INSERT INTO `synth_recipes` VALUES (1611,0,2040,0,0,0,84,0,0,0,0,4099,4241,620,1652,4509,5164,5457,0,0,0,5149,5163,5163,5163,2,2,3,4,'Sole Sushi');
INSERT INTO `synth_recipes` VALUES (1612,0,2040,0,0,0,77,0,0,0,0,4099,4241,620,1652,4480,4509,5164,0,0,0,5150,5150,5153,5153,4,6,1,2,'Tuna Sushi');
INSERT INTO `synth_recipes` VALUES (1613,0,2040,0,0,0,77,0,0,0,0,4099,4241,620,1652,4509,5164,5450,0,0,0,5150,5150,5153,5153,4,6,1,2,'Tuna Sushi');
INSERT INTO `synth_recipes` VALUES (1614,0,2040,0,0,0,93,0,0,0,0,4099,4241,620,624,1652,4318,4509,0,0,0,5151,5160,5160,5160,1,1,1,1,'Urchin Sushi');
INSERT INTO `synth_recipes` VALUES (1615,0,0,14,0,0,0,0,0,0,0,4098,4240,2464,4509,4509,4509,4509,0,0,0,5165,5165,5165,5165,1,2,3,4,'Moval. Water');
INSERT INTO `synth_recipes` VALUES (1616,0,0,0,0,0,93,0,0,0,0,4099,4241,615,621,4356,4366,4390,4548,0,0,5166,5166,5167,5167,6,12,6,12,'Coeurl Sub');
INSERT INTO `synth_recipes` VALUES (1617,0,0,0,0,0,57,0,0,0,0,4096,4238,616,626,936,4375,4378,4460,4553,4570,5168,5168,5169,5169,6,12,6,12,'Bataquiche');
INSERT INTO `synth_recipes` VALUES (1618,0,0,0,0,0,60,0,0,0,0,4096,4238,616,936,4375,4378,4460,4570,4572,0,5170,5170,5171,5171,6,12,6,12,'Green Quiche');
INSERT INTO `synth_recipes` VALUES (1619,0,0,0,0,0,41,0,0,0,0,4096,4238,4358,4387,4408,4408,4460,4555,5299,0,5172,5172,5173,5173,6,12,6,12,'Windurst Taco');
INSERT INTO `synth_recipes` VALUES (1620,0,0,0,0,0,81,0,0,0,0,4099,4241,4279,4408,4408,5299,0,0,0,0,5174,5174,5175,5175,6,12,6,12,'Tavnazian Taco');
INSERT INTO `synth_recipes` VALUES (1621,0,2040,0,0,0,72,0,0,0,0,4099,4241,620,1652,4461,4509,5164,0,0,0,5176,5176,5177,5177,4,6,2,4,'Bream Sushi');
INSERT INTO `synth_recipes` VALUES (1622,0,2040,0,0,0,72,0,0,0,0,4099,4241,620,1652,4509,5164,5454,0,0,0,5176,5176,5177,5177,4,6,2,4,'Bream Sushi');
INSERT INTO `synth_recipes` VALUES (1623,0,2040,0,0,0,93,0,0,0,0,4099,4241,620,1652,4485,4509,5164,0,0,0,5178,5179,5179,5179,2,2,3,4,'Dorado Sushi');
INSERT INTO `synth_recipes` VALUES (1624,0,2041,0,0,0,23,0,0,0,0,4096,4238,612,614,633,936,1776,5195,0,0,5188,5188,5197,5197,2,4,2,4,'Peperoncino');
INSERT INTO `synth_recipes` VALUES (1625,0,2041,0,0,0,46,0,0,0,0,4096,4238,612,614,626,633,1776,4387,5131,5194,5189,5189,5198,5198,2,4,2,4,'Vongole Rosso');
INSERT INTO `synth_recipes` VALUES (1626,0,2041,0,0,0,56,0,0,0,0,4096,4238,614,626,1590,1776,4378,4460,4570,5196,5190,5190,5199,5199,2,4,2,4,'Carbonara');
INSERT INTO `synth_recipes` VALUES (1627,0,2041,0,0,0,83,0,0,0,0,4096,4238,614,1776,4291,4304,4383,4484,5194,0,5191,5191,5200,5200,2,4,2,4,'Pescatora');
INSERT INTO `synth_recipes` VALUES (1628,0,2041,0,0,0,83,0,0,0,0,4096,4238,614,1776,4291,5194,5453,5455,5456,0,5191,5191,5200,5200,2,4,2,4,'Pescatora');
INSERT INTO `synth_recipes` VALUES (1629,0,2041,0,0,0,86,0,0,0,0,4096,4238,614,633,1776,4375,4386,4387,4447,5194,5192,5192,5201,5201,2,4,2,4,'Boscaiola');
INSERT INTO `synth_recipes` VALUES (1630,0,2041,0,0,0,66,0,0,0,0,4096,4238,614,626,633,1590,1776,4387,4390,5128,5193,5193,5202,5202,2,4,2,4,'Nero Di Seppia');
INSERT INTO `synth_recipes` VALUES (1631,0,2041,0,0,0,66,0,0,0,0,4096,4238,614,626,633,1590,1776,4387,4390,5448,5193,5193,5202,5202,2,4,2,4,'Nero Di Seppia');
INSERT INTO `synth_recipes` VALUES (1632,0,0,0,0,0,28,0,0,0,0,4101,4243,623,626,633,936,1590,4387,4390,5195,5194,5194,5194,5194,4,4,4,4,'Pomodoro Sauce');
INSERT INTO `synth_recipes` VALUES (1633,0,0,0,0,0,36,0,0,0,0,4097,4239,622,936,5152,0,0,0,0,0,5196,5207,5207,5207,2,2,2,2,'Buffalo Jerky');
INSERT INTO `synth_recipes` VALUES (1634,0,0,0,0,0,69,0,0,0,0,4103,4245,610,898,924,936,4387,4509,5208,5209,5210,5210,5210,5210,1,1,1,1,'Adamantoise Soup');
INSERT INTO `synth_recipes` VALUES (1635,0,2041,0,0,0,96,0,0,0,0,4096,4238,612,614,633,936,1590,1776,4272,5194,5211,5211,5212,5212,2,4,2,4,'Arrabbiata');
INSERT INTO `synth_recipes` VALUES (1636,0,2041,0,0,0,40,0,0,0,0,4096,4238,612,614,633,936,1776,4387,4388,5194,5213,5213,5213,5214,2,4,6,2,'Melanzane');
INSERT INTO `synth_recipes` VALUES (1637,0,2040,0,0,0,58,0,0,0,0,4099,4241,617,620,1652,4509,5128,0,0,0,5215,5215,5216,5216,1,2,1,2,'Tentacle Sushi');
INSERT INTO `synth_recipes` VALUES (1638,0,2040,0,0,0,58,0,0,0,0,4099,4241,617,620,1652,4509,5448,0,0,0,5215,5215,5216,5216,1,2,1,2,'Tentacle Sushi');
INSERT INTO `synth_recipes` VALUES (1639,0,0,0,0,0,31,0,0,0,0,4100,4242,4379,0,0,0,0,0,0,0,5217,5217,5217,5217,3,6,9,12,'Salmon Eggs');
INSERT INTO `synth_recipes` VALUES (1640,0,0,0,0,0,41,0,0,0,0,4103,4245,936,5217,0,0,0,0,0,0,5218,5218,5218,5218,3,3,6,9,'Salmon Roe');
INSERT INTO `synth_recipes` VALUES (1641,0,2040,0,0,0,67,0,0,0,0,4099,4241,620,624,1652,4509,5218,0,0,0,5219,5219,5220,5220,1,2,1,1,'Ikra Gunkan');
INSERT INTO `synth_recipes` VALUES (1642,0,0,0,0,1,1,0,1,0,0,4099,4241,917,4497,13568,0,0,0,0,0,5230,5231,5231,5231,1,1,1,1,'Love Chocolate');
INSERT INTO `synth_recipes` VALUES (1643,0,0,0,0,0,21,0,0,0,0,4096,4238,618,618,4509,0,0,0,0,0,5232,5232,5232,5232,1,2,3,4,'Soy Milk');
INSERT INTO `synth_recipes` VALUES (1644,0,0,0,0,2,39,0,0,0,0,4099,4241,825,2109,5232,0,0,0,0,0,5233,5233,5233,5233,4,6,9,12,'Cotton Tofu');
INSERT INTO `synth_recipes` VALUES (1645,0,2043,0,0,0,61,0,0,0,0,4096,4238,2110,4375,4383,4461,4509,5233,5234,5235,5238,5239,5240,5240,1,1,1,1,'Seafood Stewpot');
INSERT INTO `synth_recipes` VALUES (1646,0,0,93,0,0,0,0,0,0,0,4101,4243,1443,1617,4370,5123,5165,0,0,0,5253,5253,5253,5253,1,1,1,1,'Hermes Quencher');
INSERT INTO `synth_recipes` VALUES (1647,0,0,68,0,0,0,0,0,0,0,4101,4243,638,638,939,1617,5165,0,0,0,5254,5254,5254,5254,1,1,1,1,'Hyper Potion');
INSERT INTO `synth_recipes` VALUES (1648,0,0,79,0,0,0,0,0,0,0,4101,4243,622,622,953,1621,1621,5165,0,0,5255,5255,5255,5255,1,1,1,1,'Hyper Ether');
INSERT INTO `synth_recipes` VALUES (1649,0,2034,8,0,0,0,0,0,0,0,4100,4242,1643,1646,1648,4509,4565,4565,0,0,5298,5298,5298,5298,1,2,3,4,'Muting Potion');
INSERT INTO `synth_recipes` VALUES (1650,0,2034,7,0,0,0,0,0,0,0,4101,4243,612,1643,1646,1648,4368,4447,0,0,5298,5298,5298,5298,1,2,3,4,'Muting Potion'); -- muting potion (alch 7)
INSERT INTO `synth_recipes` VALUES (1651,0,0,0,0,0,24,0,0,0,0,4101,4243,612,936,4387,4390,4545,0,0,0,5299,5299,5299,5299,12,12,12,12,'Salsa');
INSERT INTO `synth_recipes` VALUES (1652,1,0,86,0,0,0,0,0,0,0,4100,4242,16858,0,0,0,0,0,0,0,5306,1226,937,937,1,10,1,1,'Hallowed Water');
INSERT INTO `synth_recipes` VALUES (1653,0,2033,51,0,0,0,0,0,0,0,4102,4244,1641,1642,1647,4509,0,0,0,0,5306,5306,5306,5306,1,2,3,4,'Hallowed Water');
INSERT INTO `synth_recipes` VALUES (1654,0,2034,43,0,0,0,0,0,0,0,4101,4243,953,953,1641,1646,1648,0,0,0,5307,5307,5307,5307,1,1,1,1,'Invitriol');
INSERT INTO `synth_recipes` VALUES (1655,0,2036,40,0,0,0,0,0,0,0,4096,4238,638,926,4509,0,0,0,0,0,5327,5327,5327,5327,1,2,3,4,'Potion Drop');
INSERT INTO `synth_recipes` VALUES (1656,0,2036,60,0,0,0,0,0,0,0,4096,4238,638,638,920,4509,0,0,0,0,5328,5328,5328,5328,1,2,3,4,'Hi-potion Drop');
INSERT INTO `synth_recipes` VALUES (1657,0,0,88,0,0,0,0,0,0,0,4102,4244,918,940,2163,2229,4509,0,0,0,5355,5355,5355,5355,1,1,1,1,'Elixir Vitae');
INSERT INTO `synth_recipes` VALUES (1658,0,0,66,0,0,0,0,0,0,0,4096,4238,622,2159,4509,5562,0,0,0,0,5356,5356,5356,5356,3,6,9,12,'Rmdy. Ointment');
INSERT INTO `synth_recipes` VALUES (1659,0,2036,50,0,0,0,0,0,0,0,4096,4238,622,922,922,923,4509,0,0,0,5357,5357,5357,5357,1,2,3,4,'Ether Drop');
INSERT INTO `synth_recipes` VALUES (1660,0,2036,69,0,0,0,0,0,0,0,4096,4238,622,622,922,922,922,922,923,4509,5358,5358,5358,5358,1,2,3,4,'Hi-ether Drop');
INSERT INTO `synth_recipes` VALUES (1661,0,2036,69,0,0,0,0,0,0,0,4096,4238,622,622,923,2335,4509,0,0,0,5358,5358,5358,5358,1,2,3,4,'Hi-ether Drop');
INSERT INTO `synth_recipes` VALUES (1662,0,2035,71,0,0,0,0,0,0,0,4102,4244,933,933,933,933,2131,2338,2338,0,5362,5362,5362,5362,12,12,12,12,'Rainbow Powder');
INSERT INTO `synth_recipes` VALUES (1663,0,0,71,0,0,0,0,0,0,0,4102,4244,933,933,2338,0,0,0,0,0,5362,5362,5362,5362,6,8,10,12,'Rainbow Powder');
INSERT INTO `synth_recipes` VALUES (1664,0,0,0,65,0,0,0,0,0,0,4098,4240,844,2147,0,0,0,0,0,0,5412,5412,5412,5412,1,1,1,1,'Scapegoat');
INSERT INTO `synth_recipes` VALUES (1665,0,2035,88,0,0,0,0,0,0,0,4101,4243,914,914,914,2131,2374,2374,2374,0,5430,5430,5430,5430,3,3,3,3,'Viper Potion'); -- viper potion (alch 88, triturator)
INSERT INTO `synth_recipes` VALUES (1666,0,0,88,0,0,0,0,0,0,0,4101,4243,914,2374,0,0,0,0,0,0,5430,5430,5430,5430,1,1,1,1,'Viper Potion'); -- viper potion (alch 88)
INSERT INTO `synth_recipes` VALUES (1667,0,2042,0,0,0,69,0,0,0,0,4096,4238,610,615,627,4365,4365,4378,4509,4570,5542,5543,5543,5543,1,1,1,1,'Gat. Aux Fraises');
INSERT INTO `synth_recipes` VALUES (1668,0,2043,0,0,0,71,0,0,0,0,4096,4238,2110,4373,4400,4450,4509,5233,5234,5236,5544,5545,5546,5546,1,1,1,1,'Crab Stewpot');
INSERT INTO `synth_recipes` VALUES (1669,0,2043,0,0,0,82,0,0,0,0,4096,4238,2111,4509,4570,5152,5233,5234,5236,5237,5547,5548,5549,5549,1,1,1,1,'Beef Stewpot');
INSERT INTO `synth_recipes` VALUES (1670,0,2042,0,0,0,78,0,0,0,3,4096,4238,610,615,623,627,632,4378,4496,4570,5550,5551,5551,5551,1,1,1,1,'Buche Au Choco.');
INSERT INTO `synth_recipes` VALUES (1671,0,2042,0,0,0,89,0,0,0,0,4096,4238,610,615,628,4273,4392,4503,4570,5541,5552,5553,5553,5553,1,1,1,1,'Black Pudding');
INSERT INTO `synth_recipes` VALUES (1672,0,2042,0,0,0,47,0,0,0,0,4096,4238,610,615,627,639,639,4378,4509,4570,5557,5558,5558,5558,1,1,1,1,'Mont Blanc');
INSERT INTO `synth_recipes` VALUES (1673,0,2042,0,0,0,52,0,0,0,0,4096,4238,616,616,616,627,4365,4378,4509,4570,5559,5560,5560,5560,1,1,1,1,'Mille-feuille');
INSERT INTO `synth_recipes` VALUES (1674,0,0,0,0,0,22,0,0,0,0,4098,4240,2164,2164,2164,2164,0,0,0,0,5562,5562,5562,5562,4,6,9,12,'White Honey');
INSERT INTO `synth_recipes` VALUES (1675,0,0,0,0,0,11,0,0,0,0,4097,4239,5566,0,0,0,0,0,0,0,5567,5574,5574,5574,1,1,1,1,'Dried Date');
INSERT INTO `synth_recipes` VALUES (1676,0,0,0,0,0,57,0,0,0,0,4096,4238,627,2156,4509,0,0,0,0,0,5570,5594,5594,5594,1,1,1,1,'Chai');
INSERT INTO `synth_recipes` VALUES (1677,0,2042,0,0,0,65,0,0,0,0,4096,4238,615,1840,2213,4378,5562,5562,5562,0,5572,5573,5573,5573,1,1,1,1,'Irmik Helvasi');
INSERT INTO `synth_recipes` VALUES (1678,0,0,0,0,0,8,0,0,0,0,4103,4245,727,4378,0,0,0,0,0,0,5575,5575,5575,5575,4,6,9,12,'Yogurt');
INSERT INTO `synth_recipes` VALUES (1679,0,0,0,0,0,10,0,0,0,0,4097,4239,612,936,4509,5575,0,0,0,0,5576,5576,5576,5576,1,1,1,1,'Ayran'); -- ayran (cook 10) https://www.bg-wiki.com/bg/Ayran
INSERT INTO `synth_recipes` VALUES (1680,0,2042,0,0,0,40,0,0,0,0,4096,4238,627,936,2214,2215,4378,5568,0,0,5577,5578,5578,5578,1,1,1,1,'Sutlac');
INSERT INTO `synth_recipes` VALUES (1681,0,0,0,0,0,30,0,0,0,0,4096,4238,615,936,1523,2214,2237,4509,5568,5575,5579,5580,5580,5580,1,1,1,1,'Yayla Corbasi'); -- yayla corbasi (cook 30) https://www.bg-wiki.com/bg/Yayla_Corbasi
INSERT INTO `synth_recipes` VALUES (1682,0,0,0,0,0,75,0,0,0,0,4096,4238,614,615,626,633,936,4388,4388,5575,5582,5583,5583,5583,1,1,1,1,'Patlican Salata'); -- patlican salata (cook 75) https://www.bg-wiki.com/bg/Patlican_Salata
INSERT INTO `synth_recipes` VALUES (1683,0,0,0,0,0,58,0,0,0,0,4096,4238,615,626,936,2213,2214,4503,4509,5581,5584,5585,5585,5585,1,1,1,1,'Ic Pilav');
INSERT INTO `synth_recipes` VALUES (1684,0,0,0,0,0,45,0,0,0,0,4096,4238,612,615,626,936,4387,4390,5569,5569,5586,5587,5587,5587,1,1,1,1,'Menemen'); -- menemen (cook 45) https://www.bg-wiki.com/bg/Menemen
INSERT INTO `synth_recipes` VALUES (1685,0,0,0,0,0,81,0,0,0,0,4096,4238,612,626,633,936,4387,4388,4390,5571,5588,5589,5589,5589,1,1,1,1,'Karni Yarik');
INSERT INTO `synth_recipes` VALUES (1686,0,0,0,0,0,39,0,0,0,0,4096,4238,633,936,4273,4356,4387,4390,5452,0,5590,5591,5591,5591,1,1,1,1,'Balik Sandvici');
INSERT INTO `synth_recipes` VALUES (1687,0,0,0,0,0,68,0,0,0,0,4096,4238,627,2273,4509,0,0,0,0,0,5592,5593,5593,5593,1,1,1,1,'Imperial Coffee');
INSERT INTO `synth_recipes` VALUES (1688,0,0,0,0,0,42,0,0,0,0,4096,4238,627,936,2236,2237,4378,4503,4509,5562,5596,5597,5597,5597,4,4,4,4,'Simit'); -- simit (cook 42) https://www.bg-wiki.com/bg/Simit
INSERT INTO `synth_recipes` VALUES (1689,0,0,0,0,0,60,0,0,0,0,4096,4238,614,626,936,4387,4390,5571,0,0,5598,5599,5599,5599,1,1,1,1,'Sis Kebabi');
INSERT INTO `synth_recipes` VALUES (1690,0,0,0,0,0,63,0,0,0,0,4096,4238,612,614,626,936,4390,5451,0,0,5600,5601,5601,5601,1,1,1,1,'Balik Sis'); -- balik sis (cook 63) https://www.bg-wiki.com/bg/Balik_Sis
INSERT INTO `synth_recipes` VALUES (1691,0,0,0,0,0,95,0,0,0,0,4096,4238,626,633,936,2214,2237,4387,5564,5568,5602,5603,5603,5603,1,1,1,1,'Hydra Kofte');
INSERT INTO `synth_recipes` VALUES (1692,0,0,0,0,0,85,0,0,0,0,4096,4238,619,623,626,633,936,4387,4389,5565,5609,5610,5610,5610,1,1,1,1,'Hellsteak');
INSERT INTO `synth_recipes` VALUES (1693,0,2043,0,0,0,91,0,0,0,0,4096,4238,2110,4375,4509,5233,5234,5236,5237,5563,5611,5612,5613,5613,1,1,1,1,'Angler Stewpot');
INSERT INTO `synth_recipes` VALUES (1694,0,2042,0,0,0,65,0,0,0,0,4096,4238,610,616,627,4378,4431,4445,4509,4570,5614,5615,5615,5615,1,1,1,1,'Konigskuchen');
INSERT INTO `synth_recipes` VALUES (1695,0,2042,0,0,0,90,0,0,0,0,4096,4238,610,615,2113,4370,4397,4496,4509,4570,5616,5617,5617,5617,1,1,1,1,'Lebkuchen House');
INSERT INTO `synth_recipes` VALUES (1696,0,0,0,0,0,27,0,0,0,0,4096,4238,936,1471,2201,4389,4483,4509,5450,5581,5618,5619,5619,5619,1,1,1,1,'Zoni');
INSERT INTO `synth_recipes` VALUES (1697,0,2041,0,0,0,76,0,0,0,0,4096,4238,614,633,936,1590,1776,4387,4480,5194,5623,5623,5624,5624,2,4,2,4,'Tonno Rosso');
INSERT INTO `synth_recipes` VALUES (1698,0,2041,0,0,0,76,0,0,0,0,4096,4238,614,633,936,1590,1776,4387,5194,5450,5623,5623,5624,5624,2,4,2,4,'Tonno Rosso');
INSERT INTO `synth_recipes` VALUES (1699,0,2042,0,0,0,35,0,0,0,0,4096,4238,610,627,633,4378,4570,5568,0,0,5625,5626,5626,5626,1,1,1,1,'Maple Cake'); -- maple cake (cook 35) https://www.bg-wiki.com/bg/Maple_Cake
INSERT INTO `synth_recipes` VALUES (1700,0,2042,0,0,0,75,0,0,0,0,4096,4238,610,627,633,4273,4378,4570,5568,5575,5627,5628,5628,5628,1,1,1,1,'Yogurt Cake');
INSERT INTO `synth_recipes` VALUES (1701,0,2042,0,0,0,45,0,0,0,0,4096,4238,610,627,633,4378,4392,4570,5568,0,5629,5630,5630,5630,1,1,1,1,'Orange Cake'); -- orange cake (cook 45) https://www.bg-wiki.com/bg/Orange_Cake
INSERT INTO `synth_recipes` VALUES (1702,0,2042,0,0,0,55,0,0,0,0,4096,4238,610,627,630,633,4378,4570,5568,0,5631,5632,5632,5632,1,1,1,1,'Pumpkin Cake'); -- pumpkin cake (cook 55) https://www.bg-wiki.com/bg/Pumpkin_Cake
INSERT INTO `synth_recipes` VALUES (1703,0,2042,0,0,0,85,0,0,0,0,4096,4238,610,627,633,4378,4497,4570,5568,0,5633,5634,5634,5634,1,1,1,1,'Chocolate Cake'); -- chocolate cake (cook 85) https://www.bg-wiki.com/bg/Chocolate_Cake
INSERT INTO `synth_recipes` VALUES (1704,0,0,0,0,0,68,0,0,0,0,4096,4238,620,936,4383,4509,0,0,0,0,5635,5636,5636,5636,33,33,33,99,'Shrimp Cracker');
INSERT INTO `synth_recipes` VALUES (1705,0,0,0,0,0,68,0,0,0,0,4096,4238,620,936,4509,5453,0,0,0,0,5635,5636,5636,5636,33,33,33,99,'Shrimp Cracker');
INSERT INTO `synth_recipes` VALUES (1706,0,0,0,0,0,59,0,0,0,0,4096,4238,610,615,627,936,4460,4509,5568,5575,5637,5638,5638,5638,33,33,33,99,'Pogaca'); -- pogaca (cook 59) https://www.bg-wiki.com/bg/Pogaca
INSERT INTO `synth_recipes` VALUES (1707,0,0,0,0,0,61,0,0,0,0,4096,4238,612,614,615,936,5568,5568,5575,0,5642,5643,5643,5643,1,1,1,1,'Cilbir'); -- cilbir (cook 61) https://www.bg-wiki.com/bg/Cilbir
INSERT INTO `synth_recipes` VALUES (1708,0,2042,0,0,0,85,0,0,0,0,4096,4238,615,616,627,628,630,4378,4509,5568,5644,5644,5644,5644,3,6,9,12,'Jack-o-pie'); -- jack-o-pie (patissier, cook 85) https://www.bg-wiki.com/bg/Jack-o%27-Pie
INSERT INTO `synth_recipes` VALUES (1709,0,0,0,0,0,0,0,0,0,45,4098,4240,8813,0,0,0,0,0,0,0,718,718,718,718,1,1,1,1,'Rosewood Lbr.'); -- rosewood lumber (kit)
INSERT INTO `synth_recipes` VALUES (1710,0,2042,0,0,0,80,0,0,0,0,4096,4238,615,627,4362,4445,5562,5649,0,0,5645,5645,5645,5645,3,6,9,9,'Witch Nougat');
INSERT INTO `synth_recipes` VALUES (1711,0,2042,0,0,0,37,0,0,0,0,4096,4238,627,632,632,632,632,1617,4378,0,5646,5646,5646,5646,3,6,9,12,'Bld. Chocolate'); -- bloody chocolate (requires patissier) http://ffxiclopedia.wikia.com/wiki/Patissier
INSERT INTO `synth_recipes` VALUES (1712,0,0,0,0,0,18,0,0,0,0,4096,4238,5129,17316,0,0,0,0,0,0,5647,5648,5648,5648,1,1,1,1,'Lik Kabob');
INSERT INTO `synth_recipes` VALUES (1713,0,0,0,0,0,25,0,0,0,0,4096,4238,2503,0,0,0,0,0,0,0,5649,5649,5649,5649,2,4,6,8,'Roasted Almond');
INSERT INTO `synth_recipes` VALUES (1714,0,0,0,0,0,30,0,0,0,0,4103,4245,623,633,936,4291,4291,4291,4291,0,5652,5652,5652,5652,4,6,8,12,'Anchovy');
INSERT INTO `synth_recipes` VALUES (1715,0,0,0,0,0,30,0,0,0,0,4103,4245,623,633,936,4470,4470,4470,4470,0,5652,5652,5652,5652,4,6,8,12,'Anchovy');
INSERT INTO `synth_recipes` VALUES (1716,0,2042,0,0,0,43,0,0,0,0,4096,4238,610,615,627,4378,4445,4570,0,0,5653,5654,5654,5654,4,4,4,4,'Cherry Muffin');
INSERT INTO `synth_recipes` VALUES (1717,0,2042,0,0,0,53,0,0,0,0,4096,4238,610,615,627,2273,4378,4570,0,0,5655,5656,5656,5656,4,4,4,4,'Coffee Muffin');
INSERT INTO `synth_recipes` VALUES (1718,0,0,0,0,0,0,0,0,0,50,4099,4241,8814,0,0,0,0,0,0,0,18158,18158,18158,18158,33,33,33,33,'Sleep Arrow'); -- sleep arrow (kit)
INSERT INTO `synth_recipes` VALUES (1719,0,0,0,0,0,14,0,0,0,0,4096,4238,610,611,615,936,2236,4370,5575,0,5657,5657,5657,5657,33,66,99,99,'Army Biscuit');
INSERT INTO `synth_recipes` VALUES (1720,0,2041,0,0,0,33,0,0,0,0,4096,4238,612,614,633,936,1776,4382,4388,5650,5658,5658,5659,5659,2,4,2,4,'Ortolana');
INSERT INTO `synth_recipes` VALUES (1721,0,0,0,0,0,83,0,0,0,0,4098,4240,612,626,638,699,936,4372,5152,0,5660,5660,5660,5660,12,12,12,12,'Pepperoni'); -- pepperoni (cook 83) https://www.bg-wiki.com/bg/Pepperoni
INSERT INTO `synth_recipes` VALUES (1722,0,2040,0,0,0,63,0,0,0,0,4099,4241,620,1652,4379,4509,5164,0,0,0,5663,5663,5664,5664,4,6,2,4,'Salmon Sushi'); -- salmon sushi
INSERT INTO `synth_recipes` VALUES (1723,0,2040,0,0,0,89,0,0,0,0,4099,4241,620,1652,4509,5140,5164,0,0,0,5665,5665,5666,5666,4,6,4,6,'Fin Sushi');
INSERT INTO `synth_recipes` VALUES (1724,0,0,0,0,0,51,0,0,0,0,4096,4238,2111,4368,4509,4570,5234,5469,5469,5651,5669,5670,5670,5671,1,1,1,1,'Loach Slop');
INSERT INTO `synth_recipes` VALUES (1725,0,0,0,0,0,2,0,0,0,0,4097,4239,4365,4365,4365,0,0,0,0,0,5672,5673,5673,5673,3,3,3,3,'Dried Berry');
INSERT INTO `synth_recipes` VALUES (1726,0,0,0,0,0,92,0,0,0,0,4096,4238,612,614,615,4375,4449,5195,5661,5680,5676,5677,5677,5677,1,1,1,1,'Mushroom Saute');
INSERT INTO `synth_recipes` VALUES (1727,0,0,0,0,0,82,0,0,0,0,4098,4240,633,4367,4373,4386,5650,5651,5661,5680,5678,5679,5679,5679,1,1,1,1,'Mushroom Salad');
INSERT INTO `synth_recipes` VALUES (1728,0,0,0,0,50,97,0,0,0,0,4096,4238,829,936,2213,2236,2554,4432,5568,5651,5683,5683,5683,5683,1,1,1,1,'Humpty Dumpty');
INSERT INTO `synth_recipes` VALUES (1729,0,0,0,0,0,73,0,0,0,0,4103,4245,936,2464,5703,5703,0,0,0,0,5684,5684,5684,5684,4,6,8,10,'Chalaimbille');
INSERT INTO `synth_recipes` VALUES (1730,0,0,0,0,0,94,0,0,0,0,4096,4238,615,616,626,936,4387,4389,5667,5680,5685,5685,5685,5685,2,4,6,8,'Rabbit Pie');
INSERT INTO `synth_recipes` VALUES (1731,0,0,0,0,0,7,0,0,0,0,4096,4238,621,626,4356,4390,5684,5688,0,0,5686,5687,5687,5687,1,1,1,1,'Cheese Sandwich'); -- cheese sandwich (cook 7) https://www.bg-wiki.com/bg/Cheese_Sandwich
INSERT INTO `synth_recipes` VALUES (1732,0,0,0,0,0,91,0,0,0,0,4096,4238,610,618,626,936,4387,4570,5152,5667,5689,5690,5690,5690,1,1,1,1,'Meatloaf');
INSERT INTO `synth_recipes` VALUES (1733,0,2040,0,0,0,54,0,0,0,0,4099,4241,620,1652,4509,5164,5473,0,0,0,5691,5692,5692,5692,1,1,1,1,'Shrimp Sushi'); -- shrimp sushi (cook 54) https://www.bg-wiki.com/bg/Shrimp_Sushi
INSERT INTO `synth_recipes` VALUES (1734,0,2040,0,0,0,64,0,0,0,0,4099,4241,620,1652,4509,5164,5475,0,0,0,5693,5694,5694,5694,4,6,2,4,'Octopus Sushi');
INSERT INTO `synth_recipes` VALUES (1735,0,0,0,0,0,50,0,0,0,0,4096,4238,1590,2561,4390,5194,5684,0,0,0,5695,5696,5696,5696,1,1,1,1,'Margherita Pizza');
INSERT INTO `synth_recipes` VALUES (1736,0,0,0,0,0,59,0,0,0,0,4096,4238,2561,5194,5195,5660,5680,5684,0,0,5697,5698,5698,5698,1,1,1,1,'Pepperoni Pizza'); -- pepperoni pizza (cook 59) https://www.bg-wiki.com/bg/Pepperoni_Pizza
INSERT INTO `synth_recipes` VALUES (1737,0,0,0,0,0,68,0,0,0,0,4096,4238,622,1590,2561,5194,5652,5684,0,0,5699,5700,5700,5700,1,1,1,1,'Anchovy Pizza');
INSERT INTO `synth_recipes` VALUES (1738,0,0,0,0,0,98,0,0,0,0,4098,4240,612,633,936,1555,4273,4387,4390,5650,5701,5702,5702,5702,1,1,1,1,'Nopales Salad');
INSERT INTO `synth_recipes` VALUES (1739,0,2042,0,0,0,81,0,0,0,0,4096,4238,610,615,627,936,2112,4509,4570,5703,5718,5718,5718,5718,4,6,8,10,'Cream Puff'); -- cream puff (requires patissier) http://ffxiclopedia.wikia.com/wiki/Patissier
INSERT INTO `synth_recipes` VALUES (1740,0,2040,0,0,0,50,0,0,0,0,4099,4241,620,1652,4400,4509,0,0,0,0,5721,5721,5722,5722,4,6,2,4,'Crab Sushi'); -- crab sushi
INSERT INTO `synth_recipes` VALUES (1741,0,2041,0,0,0,56,0,0,0,0,4096,4238,624,2110,2710,4509,5164,5234,5569,0,5727,5727,5728,5728,2,4,2,4,'Zaru Soba'); -- zaru soba (cook 56) https://www.bg-wiki.com/bg/Zaru_Soba
INSERT INTO `synth_recipes` VALUES (1742,0,2042,0,0,0,44,0,0,0,0,4097,4239,627,1111,1523,2112,4570,5703,0,0,5729,5730,5730,5730,1,1,1,1,'Bavarois');
INSERT INTO `synth_recipes` VALUES (1743,0,0,0,0,0,3,0,0,0,0,4096,4238,936,4358,0,0,0,0,0,0,5737,5737,5737,5737,1,1,1,1,'Salted Hare'); -- salted hare (cook 3) https://www.bg-wiki.com/bg/Salted_Hare
INSERT INTO `synth_recipes` VALUES (1744,0,0,0,0,0,3,0,0,0,0,4096,4238,926,4370,0,0,0,0,0,0,5738,5738,5738,5738,1,1,1,1,'Sweet Lizard'); -- sweet lizard (cook 3) https://www.bg-wiki.com/bg/Sweet_Lizard
INSERT INTO `synth_recipes` VALUES (1745,0,0,0,0,0,3,0,0,0,0,4101,4243,4370,4570,0,0,0,0,0,0,5739,5739,5739,5739,1,1,1,1,'Honeyed Egg'); -- honeyed egg (cook 3) https://www.bg-wiki.com/bg/Honeyed_Egg
INSERT INTO `synth_recipes` VALUES (1746,0,0,0,0,49,0,0,0,0,0,4098,4240,821,825,825,825,877,0,0,0,11370,11371,11371,11371,1,1,1,1,'Junkenshi Habaki'); -- junkenshi habaki (cloth 49) https://www.bg-wiki.com/bg/Junkenshi_Habaki
INSERT INTO `synth_recipes` VALUES (1747,0,0,0,0,63,0,0,0,0,0,4098,4240,821,826,826,826,877,0,0,0,11372,11373,11373,11373,1,1,1,1,'Junrenshi Habaki'); -- junrenshi habaki (cloth 63) https://www.bg-wiki.com/bg/Junrenshi_Habaki
INSERT INTO `synth_recipes` VALUES (1748,0,0,0,0,77,0,0,0,0,0,4098,4240,821,830,830,830,877,0,0,0,11374,11375,11375,11375,1,1,1,1,'Junhanshi Habaki'); -- junhanshi habaki (cloth 77) https://www.bg-wiki.com/bg/Junhanshi_Habaki
INSERT INTO `synth_recipes` VALUES (1749,0,0,0,0,0,0,0,103,0,0,4098,4240,879,2530,2655,0,0,0,0,0,11379,11380,11380,11380,1,1,1,1,'Hermes Sandals'); -- hermes' sandals (leath 103) https://www.bg-wiki.com/bg/Hermes'_Sandals
INSERT INTO `synth_recipes` VALUES (1750,0,0,0,0,0,0,0,0,2,7,4099,4241,660,706,706,0,0,0,0,0,12289,12333,12333,12333,1,1,1,1,'Lauan Shield');
INSERT INTO `synth_recipes` VALUES (1751,0,0,0,0,0,0,2,0,0,11,4099,4241,661,708,708,0,0,0,0,0,12290,12330,12330,12330,1,1,1,1,'Maple Shield');
INSERT INTO `synth_recipes` VALUES (1752,0,0,0,0,0,0,0,0,22,26,4099,4241,662,707,707,0,0,0,0,0,12291,12319,12319,12319,1,1,1,1,'Elm Shield');
INSERT INTO `synth_recipes` VALUES (1753,0,0,0,0,0,0,0,0,8,34,4099,4241,662,717,717,0,0,0,0,0,12292,12334,12334,12334,1,1,1,1,'Mahogany Shield'); -- mahogany shield (wood 34 smith 8+) https://www.bg-wiki.com/bg/Mahogany_Shield
INSERT INTO `synth_recipes` VALUES (1754,0,0,0,0,0,0,0,0,11,48,4099,4241,662,716,716,0,0,0,0,0,12293,12331,12331,12331,1,1,1,1,'Oak Shield');
INSERT INTO `synth_recipes` VALUES (1755,0,0,0,0,0,0,0,50,0,0,4099,4241,851,853,12289,0,0,0,0,0,12294,12329,12329,12329,1,1,1,1,'Leather Shield'); -- leather shield (leath 50) https://www.bg-wiki.com/bg/Leather_Shield
INSERT INTO `synth_recipes` VALUES (1756,0,0,0,0,0,0,0,0,19,74,4099,4241,662,716,717,0,0,0,0,0,12295,12352,12352,12352,1,1,1,1,'Round Shield');
INSERT INTO `synth_recipes` VALUES (1757,0,0,0,0,0,0,0,0,18,0,4096,4238,660,660,715,0,0,0,0,0,12299,12325,12325,12325,1,1,1,1,'Aspis');
INSERT INTO `synth_recipes` VALUES (1758,0,0,0,0,0,0,0,0,35,0,4096,4238,662,662,714,0,0,0,0,0,12300,12335,12335,12335,1,1,1,1,'Targe'); -- targe (smith 35) https://www.bg-wiki.com/bg/Targe
INSERT INTO `synth_recipes` VALUES (1759,0,0,0,0,0,0,49,0,0,0,4099,4241,663,663,12300,0,0,0,0,0,12301,12327,12327,12327,1,1,1,1,'Buckler');
INSERT INTO `synth_recipes` VALUES (1760,0,0,0,0,0,0,0,0,70,0,4096,4238,652,664,664,711,0,0,0,0,12302,12347,12347,12347,1,1,1,1,'Darksteel Buckler');
INSERT INTO `synth_recipes` VALUES (1761,0,0,0,0,0,0,80,0,0,0,4096,4238,745,914,12300,0,0,0,0,0,12303,12353,12353,12353,1,1,1,1,'Gold Buckler');
INSERT INTO `synth_recipes` VALUES (1762,0,0,97,0,0,0,0,0,0,0,4097,4239,936,4509,12310,0,0,0,0,0,12305,12357,12357,12357,1,1,1,1,'Ice Shield');
INSERT INTO `synth_recipes` VALUES (1763,0,0,0,0,0,0,0,0,50,0,4099,4241,662,662,664,715,0,0,0,0,12306,12326,12326,12326,1,1,1,1,'Kite Shield');
INSERT INTO `synth_recipes` VALUES (1764,0,0,0,0,0,0,56,0,0,0,4099,4241,663,663,12306,0,0,0,0,0,12307,12328,12328,12328,1,1,1,1,'Heater Shield');
INSERT INTO `synth_recipes` VALUES (1765,0,0,0,81,0,0,0,0,58,0,4099,4241,664,664,664,715,866,866,866,866,12308,12346,12346,12346,1,1,1,1,'Darksteel Shield');
INSERT INTO `synth_recipes` VALUES (1766,0,0,0,0,0,0,16,0,95,0,4099,4241,661,665,665,715,850,0,0,0,12309,12358,12358,12358,1,1,1,1,'Ritter Shield');
INSERT INTO `synth_recipes` VALUES (1767,0,0,0,0,0,0,90,0,0,0,4099,4241,754,754,787,787,787,787,12306,0,12310,12355,12355,12355,1,1,1,1,'Diamond Shield');
INSERT INTO `synth_recipes` VALUES (1768,0,0,0,0,0,0,0,68,9,53,4099,4241,660,710,711,851,0,0,0,0,12311,12412,12412,12412,1,1,1,1,'Hoplon'); -- hoplon (leath 68 wood 53 smith 9) https://www.bg-wiki.com/bg/Hoplon
INSERT INTO `synth_recipes` VALUES (1769,0,0,0,0,0,0,0,0,59,0,4099,4241,662,662,664,664,716,0,0,0,12323,12339,12339,12339,1,1,1,1,'Scutum');
INSERT INTO `synth_recipes` VALUES (1770,0,0,0,0,0,0,11,0,0,80,4099,4241,650,661,716,716,717,719,0,0,12324,12354,12354,12354,1,1,1,1,'Tower Shield');
INSERT INTO `synth_recipes` VALUES (1771,0,0,0,0,0,0,0,0,0,55,4098,4240,8815,0,0,0,0,0,0,0,17388,17388,17388,17388,1,1,1,1,'Fastwater F. Rod'); -- fastwater fishing rod (kit)
INSERT INTO `synth_recipes` VALUES (1772,0,0,0,0,0,0,0,0,18,70,4099,4241,662,725,725,0,0,0,0,0,12359,12370,12370,12370,1,1,1,1,'Hickory Shield');
INSERT INTO `synth_recipes` VALUES (1773,0,0,0,0,0,0,0,0,0,82,4099,4241,716,12343,0,0,0,0,0,0,12364,12365,12365,12365,1,1,1,1,'Nymph Shield');
INSERT INTO `synth_recipes` VALUES (1774,0,0,0,0,0,0,0,56,0,0,4099,4241,851,12336,0,0,0,0,0,0,12366,12367,12367,12367,1,1,1,1,'Ryl.sqr. Shield +1');
INSERT INTO `synth_recipes` VALUES (1775,0,0,0,0,0,0,85,0,0,0,4096,4238,745,914,12312,0,0,0,0,0,12368,12369,12369,12369,1,1,1,1,'R.k. Shield +1');
INSERT INTO `synth_recipes` VALUES (1776,0,0,0,0,0,0,0,0,41,0,4099,4241,662,12337,0,0,0,0,0,0,12372,12373,12373,12373,1,1,1,1,'Bastokan Targe');
INSERT INTO `synth_recipes` VALUES (1777,0,0,0,0,0,0,85,0,0,0,4096,4238,745,914,12313,0,0,0,0,0,12376,12377,12377,12377,1,1,1,1,'T.k. Shield +1');
INSERT INTO `synth_recipes` VALUES (1778,0,0,79,0,0,0,0,0,0,0,4102,4244,1269,4154,4154,12378,0,0,0,0,12379,12380,12380,12380,1,1,1,1,'Holy Shield');
INSERT INTO `synth_recipes` VALUES (1779,0,0,0,0,0,0,60,5,90,0,4096,4238,663,664,664,664,745,754,850,914,12383,12384,12384,12384,1,1,1,1,'Generals Shield');
INSERT INTO `synth_recipes` VALUES (1780,0,0,0,96,0,0,0,0,0,0,4099,4241,851,908,908,0,0,0,0,0,12385,12386,12386,12386,1,1,1,1,'Acheron Shield');
INSERT INTO `synth_recipes` VALUES (1781,0,0,0,0,0,0,97,0,58,0,4099,4241,665,745,752,12383,0,0,0,0,12387,12388,12388,12388,1,1,1,1,'Koenig Shield');
INSERT INTO `synth_recipes` VALUES (1782,0,0,0,0,0,0,0,0,0,50,4099,4241,1672,12293,0,0,0,0,0,0,12406,12406,12406,12406,1,1,1,1,'Coated Shield');
INSERT INTO `synth_recipes` VALUES (1783,0,0,0,0,0,0,0,0,0,85,4099,4241,720,720,12295,0,0,0,0,0,12409,12410,12410,12410,1,1,1,1,'Numinous Shield');
INSERT INTO `synth_recipes` VALUES (1784,0,0,0,0,0,0,0,0,0,87,4099,4241,1815,12409,0,0,0,0,0,0,12411,12411,12411,12411,1,1,1,1,'Dominus Shield');
INSERT INTO `synth_recipes` VALUES (1785,0,0,0,35,0,0,0,0,0,0,4099,4241,885,889,0,0,0,0,0,0,12414,12413,12413,12413,1,1,1,1,'Turtle Shield');
INSERT INTO `synth_recipes` VALUES (1786,0,0,0,0,0,0,0,0,55,0,4096,4238,648,662,662,850,0,0,0,0,12416,13831,13831,13831,1,1,1,1,'Sallet');
INSERT INTO `synth_recipes` VALUES (1787,0,0,0,0,0,0,62,0,0,0,4096,4238,648,663,664,850,0,0,0,0,12417,13847,13847,13847,1,1,1,1,'Mythril Sallet');
INSERT INTO `synth_recipes` VALUES (1788,0,0,54,0,0,0,72,0,0,0,4096,4238,648,745,850,914,931,931,0,0,12418,13848,13848,13848,1,1,1,1,'Gold Armet');
INSERT INTO `synth_recipes` VALUES (1789,0,0,0,0,0,0,51,0,82,0,4096,4238,648,664,664,745,850,914,0,0,12419,12423,12423,12423,1,1,1,1,'Darksteel Armet');
INSERT INTO `synth_recipes` VALUES (1790,0,0,0,0,0,0,60,0,98,0,4096,4238,648,664,665,745,850,914,0,0,12420,13941,13941,13941,1,1,1,1,'Adaman Barbuta');
INSERT INTO `synth_recipes` VALUES (1791,0,0,0,0,0,0,0,0,29,0,4099,4241,661,662,0,0,0,0,0,0,12424,12524,12524,12524,1,1,1,1,'Iron Mask');
INSERT INTO `synth_recipes` VALUES (1792,0,0,0,0,0,0,39,0,0,0,4096,4238,744,914,12424,0,0,0,0,0,12425,12533,12533,12533,1,1,1,1,'Silver Mask');
INSERT INTO `synth_recipes` VALUES (1793,0,0,0,0,0,0,48,0,14,0,4096,4238,648,662,663,681,850,0,0,0,12426,13832,13832,13832,1,1,1,1,'Banded Helm'); -- banded helm (gold 48 smith 14) https://www.bg-wiki.com/bg/Banded_Helm
INSERT INTO `synth_recipes` VALUES (1794,0,0,0,0,0,0,0,0,67,0,4096,4238,648,662,664,682,850,0,0,0,12427,12439,12439,12439,1,1,1,1,'Bascinet');
INSERT INTO `synth_recipes` VALUES (1795,0,0,0,0,0,0,0,0,87,0,4096,4238,648,664,666,682,850,0,0,0,12428,13845,13845,13845,1,1,1,1,'Celata');
INSERT INTO `synth_recipes` VALUES (1796,0,0,0,0,0,0,0,0,9,0,4098,4240,660,850,0,0,0,0,0,0,12432,12487,12487,12487,1,1,1,1,'Faceguard');
INSERT INTO `synth_recipes` VALUES (1797,0,0,0,0,0,0,29,0,0,0,4099,4241,661,848,12432,0,0,0,0,0,12433,12532,12532,12532,1,1,1,1,'Brass Mask');
INSERT INTO `synth_recipes` VALUES (1798,0,0,0,77,0,0,0,0,0,0,4098,4240,850,887,887,0,0,0,0,0,12435,13859,13859,13859,1,1,1,1,'Coral Visor');
INSERT INTO `synth_recipes` VALUES (1799,0,0,0,87,0,0,0,0,0,0,4098,4240,850,866,866,0,0,0,0,0,12436,13860,13860,13860,1,1,1,1,'Dragon Mask');
INSERT INTO `synth_recipes` VALUES (1800,0,0,0,100,0,0,0,0,0,0,4098,4240,850,1586,1587,0,0,0,0,0,12437,13944,13944,13944,1,1,1,1,'Gavial Mask');
INSERT INTO `synth_recipes` VALUES (1801,0,0,0,0,0,0,0,5,0,0,4098,4240,850,0,0,0,0,0,0,0,12440,12542,12542,12542,1,1,1,1,'Leather Bandana');
INSERT INTO `synth_recipes` VALUES (1802,0,0,0,0,0,0,0,15,0,0,4099,4241,850,852,852,0,0,0,0,0,12441,12480,12480,12480,1,1,1,1,'Lizard Helm');
INSERT INTO `synth_recipes` VALUES (1803,0,0,0,0,0,0,0,24,0,0,4099,4241,680,12440,0,0,0,0,0,0,12442,13824,13824,13824,1,1,1,1,'Studded Bandana');
INSERT INTO `synth_recipes` VALUES (1804,0,0,0,0,0,0,0,38,0,0,4101,4243,851,913,12440,0,0,0,0,0,12443,12481,12481,12481,1,1,1,1,'Cuir Bandana');
INSERT INTO `synth_recipes` VALUES (1805,0,0,0,0,0,0,0,56,28,0,4099,4241,662,850,853,853,0,0,0,0,12444,13835,13835,13835,1,1,1,1,'Raptor Helm');
INSERT INTO `synth_recipes` VALUES (1806,0,0,0,0,0,0,0,97,0,0,4099,4241,862,12447,0,0,0,0,0,0,12445,13938,13938,13938,1,1,1,1,'Dusk Mask');
INSERT INTO `synth_recipes` VALUES (1807,0,0,0,0,0,0,0,78,41,0,4099,4241,664,850,855,855,0,0,0,0,12446,13861,13861,13861,1,1,1,1,'Tiger Helm'); -- tiger helm (leath 78 smith 41) https://www.bg-wiki.com/bg/Tiger_Helm
INSERT INTO `synth_recipes` VALUES (1808,0,0,0,0,0,0,0,87,0,0,4099,4241,506,506,12432,0,0,0,0,0,12447,13862,13862,13862,1,1,1,1,'Coeurl Mask');
INSERT INTO `synth_recipes` VALUES (1809,0,0,0,0,0,0,0,3,4,0,4099,4241,660,850,850,0,0,0,0,0,12448,12463,12463,12463,1,1,1,1,'Bronze Cap');
INSERT INTO `synth_recipes` VALUES (1810,0,0,0,0,0,0,10,0,0,0,4099,4241,650,12448,0,0,0,0,0,0,12449,12528,12528,12528,1,1,1,1,'Brass Cap');
INSERT INTO `synth_recipes` VALUES (1811,0,0,0,0,0,0,0,9,39,0,4099,4241,662,852,852,0,0,0,0,0,12450,12525,12525,12525,1,1,1,1,'Padded Cap');
INSERT INTO `synth_recipes` VALUES (1812,0,0,0,64,0,0,0,0,0,0,4099,4241,851,896,0,0,0,0,0,0,12451,12482,12482,12482,1,1,1,1,'Scorpion Mask');
INSERT INTO `synth_recipes` VALUES (1813,0,0,0,0,0,0,0,38,72,0,4099,4241,664,855,855,0,0,0,0,0,12452,13863,13863,13863,1,1,1,1,'Darksteel Cap');
INSERT INTO `synth_recipes` VALUES (1814,0,0,0,78,0,0,0,0,0,0,4099,4241,887,12452,0,0,0,0,0,0,12453,13864,13864,13864,1,1,1,1,'Coral Cap');
INSERT INTO `synth_recipes` VALUES (1815,0,0,0,18,0,0,0,0,0,0,4099,4241,850,880,893,0,0,0,0,0,12454,13826,13826,13826,1,1,1,1,'Bone Mask');
INSERT INTO `synth_recipes` VALUES (1816,0,0,0,30,0,0,0,0,0,0,4099,4241,852,894,0,0,0,0,0,0,12455,13827,13827,13827,1,1,1,1,'Beetle Mask'); -- beetle mask (bone 30) https://www.bg-wiki.com/bg/Beetle_Mask
INSERT INTO `synth_recipes` VALUES (1817,0,0,0,0,11,0,0,0,0,0,4098,4240,824,824,0,0,0,0,0,0,12456,12534,12534,12534,1,1,1,1,'Hachimaki');
INSERT INTO `synth_recipes` VALUES (1818,0,0,0,0,21,0,0,0,0,0,4098,4240,825,825,0,0,0,0,0,0,12457,12537,12537,12537,1,1,1,1,'Cotton Hachimaki');
INSERT INTO `synth_recipes` VALUES (1819,0,0,0,0,31,0,0,0,0,0,4098,4240,826,826,0,0,0,0,0,0,12458,12539,12539,12539,1,1,1,1,'Soil Hachimaki');
INSERT INTO `synth_recipes` VALUES (1820,0,0,0,0,34,0,0,0,69,0,4096,4238,648,662,662,816,829,0,0,0,12459,13865,13865,13865,1,1,1,1,'Zunari Kabuto');
INSERT INTO `synth_recipes` VALUES (1821,0,0,0,0,71,0,0,0,40,0,4098,4240,664,680,829,829,0,0,0,0,12460,13844,13844,13844,1,1,1,1,'Shinobi Hachigane');
INSERT INTO `synth_recipes` VALUES (1822,0,0,0,0,5,0,0,0,0,0,4098,4240,817,824,824,0,0,0,0,0,12464,12471,12471,12471,1,1,1,1,'Headgear');
INSERT INTO `synth_recipes` VALUES (1823,0,0,0,0,15,0,0,0,0,0,4098,4240,818,825,825,0,0,0,0,0,12465,12535,12535,12535,1,1,1,1,'Cotton Headgear');
INSERT INTO `synth_recipes` VALUES (1824,0,0,0,0,24,0,0,0,0,0,4099,4241,819,826,826,840,0,0,0,0,12466,12538,12538,12538,1,1,1,1,'Red Cap');
INSERT INTO `synth_recipes` VALUES (1825,0,0,0,0,45,0,0,0,0,0,4099,4241,820,827,827,840,0,0,0,0,12467,12541,12541,12541,1,1,1,1,'Wool Cap');
INSERT INTO `synth_recipes` VALUES (1826,0,0,0,0,76,0,0,0,0,0,4099,4241,816,829,829,840,842,0,0,0,12468,13866,13866,13866,1,1,1,1,'Green Beret');
INSERT INTO `synth_recipes` VALUES (1827,0,0,0,0,55,0,0,83,0,0,4099,4241,823,843,855,855,0,0,0,0,12469,13867,13867,13867,1,1,1,1,'War Beret');
INSERT INTO `synth_recipes` VALUES (1828,0,0,0,0,0,0,9,0,0,0,4096,4238,648,650,0,0,0,0,0,0,12472,12527,12527,12527,1,1,1,1,'Circlet');
INSERT INTO `synth_recipes` VALUES (1829,0,0,0,0,0,0,21,0,0,0,4096,4238,648,653,0,0,0,0,0,0,12473,12530,12530,12530,1,1,1,1,'Poets Circlet');
INSERT INTO `synth_recipes` VALUES (1830,0,0,0,0,40,0,2,0,0,0,4099,4241,661,819,826,827,827,0,0,0,12474,12479,12479,12479,1,1,1,1,'Wool Hat');
INSERT INTO `synth_recipes` VALUES (1831,0,0,0,0,55,0,8,0,0,0,4099,4241,661,816,827,828,828,0,0,0,12475,13834,13834,13834,1,1,1,1,'Velvet Hat');
INSERT INTO `synth_recipes` VALUES (1832,0,0,0,0,65,0,52,0,0,0,4099,4241,752,822,828,0,0,0,0,0,12476,13843,13843,13843,1,1,1,1,'Silk Hat');
INSERT INTO `synth_recipes` VALUES (1833,0,0,0,0,0,0,71,0,0,0,4096,4238,648,745,789,0,0,0,0,0,12477,12483,12483,12483,1,1,1,1,'Nobles Crown');
INSERT INTO `synth_recipes` VALUES (1834,0,0,0,0,51,0,0,0,93,0,4098,4240,664,682,1764,1764,0,0,0,0,12490,15192,15192,15192,1,1,1,1,'Yasha Jinpachi');
INSERT INTO `synth_recipes` VALUES (1835,0,0,0,0,0,0,58,0,0,0,4098,4240,745,0,0,0,0,0,0,0,12494,13849,13849,13849,1,1,1,1,'Gold Hairpin');
INSERT INTO `synth_recipes` VALUES (1836,0,0,0,0,0,0,27,0,0,0,4098,4240,744,0,0,0,0,0,0,0,12495,12531,12531,12531,1,1,1,1,'Silver Hairpin');
INSERT INTO `synth_recipes` VALUES (1837,0,0,0,0,0,0,7,0,0,0,4098,4240,648,0,0,0,0,0,0,0,12496,12526,12526,12526,1,1,1,1,'Copper Hairpin');
INSERT INTO `synth_recipes` VALUES (1838,0,0,0,0,0,0,17,0,0,0,4098,4240,650,0,0,0,0,0,0,0,12497,12529,12529,12529,1,1,1,1,'Brass Hairpin');
INSERT INTO `synth_recipes` VALUES (1839,0,0,0,0,20,0,0,0,0,0,4099,4241,825,932,0,0,0,0,0,0,12498,12536,12536,12536,1,1,1,1,'Cotton Headband');
INSERT INTO `synth_recipes` VALUES (1840,0,0,0,0,39,0,0,0,0,0,4099,4241,826,932,0,0,0,0,0,0,12499,12540,12540,12540,1,1,1,1,'Flax Headband');
INSERT INTO `synth_recipes` VALUES (1841,0,0,0,0,69,0,0,0,0,0,4099,4241,829,932,0,0,0,0,0,0,12503,13851,13851,13851,1,1,1,1,'Silk Headband');
INSERT INTO `synth_recipes` VALUES (1842,0,0,0,0,84,0,0,0,0,0,4099,4241,830,932,0,0,0,0,0,0,12504,13858,13858,13858,1,1,1,1,'Rainbow Headband'); -- rainbow headband (cloth 84) https://www.bg-wiki.com/bg/Rainbow_Headband
INSERT INTO `synth_recipes` VALUES (1843,0,0,0,4,0,0,0,0,0,0,4098,4240,880,0,0,0,0,0,0,0,12505,13825,13825,13825,1,1,1,1,'Bone Hairpin');
INSERT INTO `synth_recipes` VALUES (1844,0,0,0,53,0,0,0,0,0,0,4098,4240,885,0,0,0,0,0,0,0,12506,13836,13836,13836,1,1,1,1,'Shell Hairpin');
INSERT INTO `synth_recipes` VALUES (1845,0,0,0,29,0,0,0,0,0,0,4098,4240,895,0,0,0,0,0,0,0,12507,13828,13828,13828,1,1,1,1,'Horn Hairpin');
INSERT INTO `synth_recipes` VALUES (1846,0,0,0,77,0,0,0,0,0,0,4098,4240,792,793,887,0,0,0,0,0,12508,13850,13850,13850,1,1,1,1,'Coral Hairpin');
INSERT INTO `synth_recipes` VALUES (1847,0,0,0,0,0,0,0,0,58,0,4096,4238,662,662,662,662,850,850,0,0,12544,13724,13724,13724,1,1,1,1,'Breastplate');
INSERT INTO `synth_recipes` VALUES (1848,0,0,0,0,0,0,67,0,0,0,4096,4238,663,663,664,664,851,851,0,0,12545,13737,13737,13737,1,1,1,1,'Mtl. Breastplate');
INSERT INTO `synth_recipes` VALUES (1849,0,0,54,0,0,0,78,0,0,0,4096,4238,745,851,851,914,931,931,931,931,12546,13738,13738,13738,1,1,1,1,'Gold Cuirass'); -- gold cuirass (gold 78, alch 54)
INSERT INTO `synth_recipes` VALUES (1850,0,0,0,0,0,0,49,0,87,0,4096,4238,664,664,664,664,745,851,851,914,12547,13756,13756,13756,1,1,1,1,'Darksteel Cuirass');
INSERT INTO `synth_recipes` VALUES (1851,0,0,0,0,0,0,60,0,103,0,4096,4238,664,664,665,665,745,855,855,914,12548,13746,13746,13746,1,1,1,1,'Adaman Cuirass');
INSERT INTO `synth_recipes` VALUES (1852,0,0,0,0,0,0,0,2,37,0,4099,4241,662,680,680,680,680,851,0,0,12552,12662,12662,12662,1,1,1,1,'Chainmail');
INSERT INTO `synth_recipes` VALUES (1853,0,0,0,0,0,0,46,0,0,0,4099,4241,760,760,12552,0,0,0,0,0,12553,12666,12666,12666,1,1,1,1,'Silver Mail');
INSERT INTO `synth_recipes` VALUES (1854,0,0,0,0,13,0,50,0,0,0,4099,4241,663,663,681,681,681,681,826,0,12554,12667,12667,12667,1,1,1,1,'Banded Mail'); -- banded mail (gold 50 cloth 13) https://www.bg-wiki.com/bg/Banded_Mail
INSERT INTO `synth_recipes` VALUES (1855,0,0,0,0,38,0,0,0,69,0,4099,4241,658,664,664,682,682,682,828,829,12555,13735,13735,13735,1,1,1,1,'Haubergeon');
INSERT INTO `synth_recipes` VALUES (1856,0,0,0,0,38,0,0,0,89,0,4099,4241,666,682,828,829,12555,0,0,0,12556,13793,13793,13793,1,1,1,1,'Hauberk'); -- hauberk (smith 89 cloth 38) https://www.bg-wiki.com/bg/Hauberk
INSERT INTO `synth_recipes` VALUES (1857,0,0,0,0,0,0,0,0,17,0,4099,4241,672,672,672,672,818,850,12568,0,12560,12661,12661,12661,1,1,1,1,'Scale Mail');
INSERT INTO `synth_recipes` VALUES (1858,0,0,0,0,0,0,36,0,0,0,4099,4241,673,673,673,673,818,848,12568,0,12561,12665,12665,12665,1,1,1,1,'Brass Scale Mail');
INSERT INTO `synth_recipes` VALUES (1859,0,0,0,80,0,0,0,0,0,0,4099,4241,821,850,887,887,887,887,12568,0,12563,13761,13761,13761,1,1,1,1,'Coral Scale Mail');
INSERT INTO `synth_recipes` VALUES (1860,0,0,0,90,0,0,0,0,42,0,4099,4241,664,682,822,866,866,866,867,12568,12564,13762,13762,13762,1,1,1,1,'Dragon Mail'); -- dragon mail (bone 90 smith 42) https://www.bg-wiki.com/bg/Dragon_Mail
INSERT INTO `synth_recipes` VALUES (1861,0,0,0,103,0,0,0,26,0,0,4099,4241,821,850,1586,1586,1587,1587,12568,0,12565,13747,13747,13747,1,1,1,1,'Gavial Mail');
INSERT INTO `synth_recipes` VALUES (1862,0,0,0,0,0,0,0,10,0,0,4099,4241,850,850,850,852,0,0,0,0,12568,12599,12599,12599,1,1,1,1,'Leather Vest');
INSERT INTO `synth_recipes` VALUES (1863,0,0,0,0,0,0,0,19,0,0,4099,4241,850,852,852,852,0,0,0,0,12569,13697,13697,13697,1,1,1,1,'Lizard Jerkin');
INSERT INTO `synth_recipes` VALUES (1864,0,0,0,0,0,0,0,32,0,0,4099,4241,680,848,851,12568,0,0,0,0,12570,13707,13707,13707,1,1,1,1,'Studded Vest');
INSERT INTO `synth_recipes` VALUES (1865,0,0,0,0,0,0,0,46,0,0,4101,4243,851,851,913,12568,0,0,0,0,12571,13709,13709,13709,1,1,1,1,'Cuir Bouilli');
INSERT INTO `synth_recipes` VALUES (1866,0,0,0,0,0,0,0,58,0,0,4099,4241,850,853,853,0,0,0,0,0,12572,13727,13727,13727,1,1,1,1,'Raptor Jerkin');
INSERT INTO `synth_recipes` VALUES (1867,0,0,0,0,0,0,41,100,0,0,4099,4241,745,862,1122,14284,0,0,0,0,12573,14391,14391,14391,1,1,1,1,'Dusk Jerkin');
INSERT INTO `synth_recipes` VALUES (1868,0,0,0,0,0,0,0,79,0,0,4099,4241,850,855,855,0,0,0,0,0,12574,13763,13763,13763,1,1,1,1,'Tiger Jerkin');
INSERT INTO `synth_recipes` VALUES (1869,0,0,0,0,0,0,0,89,0,0,4099,4241,506,506,850,0,0,0,0,0,12575,13764,13764,13764,1,1,1,1,'Coeurl Jerkin');
INSERT INTO `synth_recipes` VALUES (1870,0,0,0,0,0,0,0,3,11,0,4099,4241,660,660,660,850,850,0,0,0,12576,12607,12607,12607,1,1,1,1,'Bronze Harness');
INSERT INTO `synth_recipes` VALUES (1871,0,0,0,0,0,0,18,0,0,0,4099,4241,650,661,12576,0,0,0,0,0,12577,12664,12664,12664,1,1,1,1,'Brass Harness');
INSERT INTO `synth_recipes` VALUES (1872,0,0,0,0,0,0,0,13,47,0,4099,4241,662,662,662,852,852,0,0,0,12578,12663,12663,12663,1,1,1,1,'Padded Armor');
INSERT INTO `synth_recipes` VALUES (1873,0,0,0,69,0,0,0,33,0,0,4099,4241,851,851,896,896,901,0,0,0,12579,13734,13734,13734,1,1,1,1,'Scorpion Harness');
INSERT INTO `synth_recipes` VALUES (1874,0,0,0,0,0,0,0,44,78,0,4099,4241,664,664,664,855,855,0,0,0,12580,13765,13765,13765,1,1,1,1,'Darksteel Harness');
INSERT INTO `synth_recipes` VALUES (1875,0,0,0,80,0,0,0,50,0,0,4099,4241,506,506,887,887,0,0,0,0,12581,13766,13766,13766,1,1,1,1,'Coral Harness'); -- coral harness (bone 80 leath 50) https://www.bg-wiki.com/bg/Coral_Harness
INSERT INTO `synth_recipes` VALUES (1876,0,0,0,26,0,0,0,7,0,0,4099,4241,850,850,868,880,893,0,0,0,12582,13716,13716,13716,1,1,1,1,'Bone Harness');
INSERT INTO `synth_recipes` VALUES (1877,0,0,0,36,0,0,0,9,0,0,4099,4241,852,852,852,889,889,0,0,0,12583,13717,13717,13717,1,1,1,1,'Beetle Harness');
INSERT INTO `synth_recipes` VALUES (1878,0,0,0,0,18,0,0,0,0,0,4099,4241,817,824,824,824,0,0,0,0,12584,12668,12668,12668,1,1,1,1,'Kenpogi');
INSERT INTO `synth_recipes` VALUES (1879,0,0,0,0,28,0,0,0,0,0,4099,4241,817,825,825,825,0,0,0,0,12585,12624,12624,12624,1,1,1,1,'Cotton Dogi');
INSERT INTO `synth_recipes` VALUES (1880,0,0,0,0,38,0,0,0,0,0,4099,4241,817,826,826,826,0,0,0,0,12586,12671,12671,12671,1,1,1,1,'Soil Gi');
INSERT INTO `synth_recipes` VALUES (1881,0,0,0,0,49,0,0,0,68,0,4096,4238,662,662,662,680,680,816,829,850,12587,13769,13769,13769,1,1,1,1,'Hara-ate');
INSERT INTO `synth_recipes` VALUES (1882,0,0,0,0,80,0,0,0,0,0,4099,4241,680,680,819,829,829,829,0,0,12588,13733,13733,13733,1,1,1,1,'Shinobi Gi');
INSERT INTO `synth_recipes` VALUES (1883,0,0,0,0,10,0,0,0,0,0,4099,4241,817,824,824,824,824,834,834,834,12592,12591,12591,12591,1,1,1,1,'Doublet');
INSERT INTO `synth_recipes` VALUES (1884,0,0,0,0,20,0,0,0,0,0,4099,4241,818,825,825,825,825,834,834,834,12593,12669,12669,12669,1,1,1,1,'Cotton Doublet');
INSERT INTO `synth_recipes` VALUES (1885,0,0,0,0,29,0,13,0,0,0,4099,4241,673,819,826,826,826,826,834,834,12594,12625,12625,12625,1,1,1,1,'Gambison');
INSERT INTO `synth_recipes` VALUES (1886,0,0,0,0,50,0,15,0,0,0,4099,4241,673,820,827,827,827,827,834,834,12595,13696,13696,13696,1,1,1,1,'Wool Gambison');
INSERT INTO `synth_recipes` VALUES (1887,0,0,0,0,78,0,42,0,0,0,4099,4241,752,823,828,828,828,828,834,834,12596,12628,12628,12628,1,1,1,1,'Battle Jupon');
INSERT INTO `synth_recipes` VALUES (1888,0,0,0,0,86,0,51,41,0,0,4099,4241,745,823,828,828,834,834,855,855,12597,13771,13771,13771,1,1,1,1,'War Aketon');
INSERT INTO `synth_recipes` VALUES (1889,0,0,0,0,16,0,0,0,0,0,4099,4241,817,824,824,825,825,0,0,0,12600,12615,12615,12615,1,1,1,1,'Robe');
INSERT INTO `synth_recipes` VALUES (1890,0,0,0,0,27,0,0,0,0,0,4099,4241,818,825,825,826,826,0,0,0,12601,12626,12626,12626,1,1,1,1,'Linen Robe');
INSERT INTO `synth_recipes` VALUES (1891,0,0,0,0,43,0,12,0,0,0,4099,4241,673,819,826,826,827,827,0,0,12602,12627,12627,12627,1,1,1,1,'Wool Robe');
INSERT INTO `synth_recipes` VALUES (1892,0,0,0,0,58,0,8,0,0,0,4099,4241,673,822,827,827,828,828,0,0,12603,13726,13726,13726,1,1,1,1,'Velvet Robe');
INSERT INTO `synth_recipes` VALUES (1893,0,0,0,0,68,0,0,0,0,0,4099,4241,822,823,828,828,829,829,0,0,12604,12652,12652,12652,1,1,1,1,'Silk Coat');
INSERT INTO `synth_recipes` VALUES (1894,0,0,0,0,87,0,0,0,0,0,4099,4241,822,823,823,828,828,829,830,831,12605,13774,13774,13774,1,1,1,1,'Nobles Tunic');
INSERT INTO `synth_recipes` VALUES (1895,0,0,0,0,17,0,0,0,0,0,4099,4241,818,824,824,824,825,825,0,0,12608,12616,12616,12616,1,1,1,1,'Tunic');
INSERT INTO `synth_recipes` VALUES (1896,0,0,0,0,53,0,0,0,0,0,4099,4241,822,826,826,826,828,828,0,0,12609,13725,13725,13725,1,1,1,1,'Black Tunic');
INSERT INTO `synth_recipes` VALUES (1897,0,0,0,0,33,0,0,0,0,0,4099,4241,819,825,825,825,826,826,0,0,12610,12670,12670,12670,1,1,1,1,'Cloak');
INSERT INTO `synth_recipes` VALUES (1898,0,0,0,0,63,0,0,0,0,0,4099,4241,823,828,828,828,829,829,0,0,12611,12651,12651,12651,1,1,1,1,'White Cloak');
INSERT INTO `synth_recipes` VALUES (1899,0,0,0,0,77,0,0,0,0,0,4099,4241,823,829,829,829,829,829,0,0,12612,13777,13777,13777,1,1,1,1,'Silk Cloak');
INSERT INTO `synth_recipes` VALUES (1900,0,0,0,0,90,0,0,0,60,0,4099,4241,664,664,682,682,821,1132,1132,1132,12617,13770,13770,13770,1,1,1,1,'War Shinobi Gi');
INSERT INTO `synth_recipes` VALUES (1901,0,0,0,0,97,0,0,46,51,0,4099,4241,664,666,821,828,855,855,1764,1764,12618,14442,14442,14442,1,1,1,1,'Yasha Samue');
INSERT INTO `synth_recipes` VALUES (1902,0,0,0,99,0,0,0,0,0,0,4099,4241,850,851,851,1473,1473,1473,1473,0,12621,12589,12589,12589,1,1,1,1,'Scp. Breastplate');
INSERT INTO `synth_recipes` VALUES (1903,0,0,0,0,0,0,0,0,57,0,4096,4238,662,662,12696,12696,0,0,0,0,12672,12791,12791,12791,1,1,1,1,'Gauntlets');
INSERT INTO `synth_recipes` VALUES (1904,0,0,0,0,0,0,66,0,0,0,4096,4238,663,664,12696,12696,0,0,0,0,12673,13958,13958,13958,1,1,1,1,'Mythril Gauntlets');
INSERT INTO `synth_recipes` VALUES (1905,0,0,54,0,0,0,77,0,0,0,4096,4238,745,914,931,931,12696,12696,0,0,12674,13959,13959,13959,1,1,1,1,'Gold Gauntlets');
INSERT INTO `synth_recipes` VALUES (1906,0,0,0,0,0,0,45,0,86,0,4096,4238,664,664,745,914,12696,12696,0,0,12675,13989,13989,13989,1,1,1,1,'Dst. Gauntlets');
INSERT INTO `synth_recipes` VALUES (1907,0,0,0,0,0,0,60,0,102,0,4096,4238,664,665,745,914,12696,12696,0,0,12676,14828,14828,14828,1,1,1,1,'Adaman Gauntlets');
INSERT INTO `synth_recipes` VALUES (1908,0,0,0,0,0,0,0,5,31,0,4099,4241,680,680,851,0,0,0,0,0,12680,12769,12769,12769,1,1,1,1,'Chain Mittens');
INSERT INTO `synth_recipes` VALUES (1909,0,0,0,0,0,0,40,0,0,0,4099,4241,760,12680,0,0,0,0,0,0,12681,12772,12772,12772,1,1,1,1,'Silver Mittens');
INSERT INTO `synth_recipes` VALUES (1910,0,0,0,0,0,0,47,0,0,0,4099,4241,663,663,12680,0,0,0,0,0,12682,12792,12792,12792,1,1,1,1,'Mufflers');
INSERT INTO `synth_recipes` VALUES (1911,0,0,0,0,0,0,0,0,64,0,4099,4241,664,664,12680,0,0,0,0,0,12683,13976,13976,13976,1,1,1,1,'Darksteel Mufflers');
INSERT INTO `synth_recipes` VALUES (1912,0,0,0,0,0,0,0,0,84,0,4099,4241,666,12683,0,0,0,0,0,0,12684,14012,14012,14012,1,1,1,1,'Thick Mufflers');
INSERT INTO `synth_recipes` VALUES (1913,0,0,0,0,0,0,0,0,11,0,4099,4241,672,672,818,12696,0,0,0,0,12688,12768,12768,12768,1,1,1,1,'Scale Fng. Gnt.');
INSERT INTO `synth_recipes` VALUES (1914,0,0,0,0,0,0,30,0,0,0,4099,4241,673,673,818,848,12696,0,0,0,12689,12771,12771,12771,1,1,1,1,'Brass Fng. Gnt.');
INSERT INTO `synth_recipes` VALUES (1915,0,0,0,74,0,0,0,0,0,0,4099,4241,821,887,887,12696,0,0,0,0,12691,13990,13990,13990,1,1,1,1,'Coral Fng. Gnt.');
INSERT INTO `synth_recipes` VALUES (1916,0,0,0,84,0,0,0,0,0,0,4099,4241,822,866,866,12696,0,0,0,0,12692,13991,13991,13991,1,1,1,1,'Dragon Fng. Gnt.');
INSERT INTO `synth_recipes` VALUES (1917,0,0,0,97,0,0,0,0,0,0,4099,4241,821,1586,1587,12696,0,0,0,0,12693,14829,14829,14829,1,1,1,1,'Gavial Fng. Gnt.');
INSERT INTO `synth_recipes` VALUES (1918,0,0,0,0,0,0,0,8,0,0,4099,4241,824,850,850,0,0,0,0,0,12696,12784,12784,12784,1,1,1,1,'Leather Gloves');
INSERT INTO `synth_recipes` VALUES (1919,0,0,0,0,0,0,0,16,0,0,4099,4241,852,12696,0,0,0,0,0,0,12697,12785,12785,12785,1,1,1,1,'Lizard Gloves');
INSERT INTO `synth_recipes` VALUES (1920,0,0,0,0,0,0,0,26,0,0,4099,4241,680,848,12696,0,0,0,0,0,12698,12786,12786,12786,1,1,1,1,'Studded Gloves');
INSERT INTO `synth_recipes` VALUES (1921,0,0,0,0,0,0,0,40,0,0,4101,4243,851,851,913,12696,0,0,0,0,12699,12787,12787,12787,1,1,1,1,'Cuir Gloves');
INSERT INTO `synth_recipes` VALUES (1922,0,0,0,0,0,0,0,57,0,0,4099,4241,853,12699,0,0,0,0,0,0,12700,12795,12795,12795,1,1,1,1,'Raptor Gloves');
INSERT INTO `synth_recipes` VALUES (1923,0,0,0,0,0,0,0,99,0,0,4099,4241,862,12702,0,0,0,0,0,0,12701,14825,14825,14825,1,1,1,1,'Dusk Gloves');
INSERT INTO `synth_recipes` VALUES (1924,0,0,0,0,0,0,0,77,0,0,4099,4241,855,12699,0,0,0,0,0,0,12702,13992,13992,13992,1,1,1,1,'Tiger Gloves');
INSERT INTO `synth_recipes` VALUES (1925,0,0,0,0,0,0,0,88,0,0,4099,4241,506,12699,0,0,0,0,0,0,12703,13993,13993,13993,1,1,1,1,'Coeurl Gloves');
INSERT INTO `synth_recipes` VALUES (1926,0,0,0,0,0,0,0,3,5,0,4099,4241,660,850,0,0,0,0,0,0,12704,12695,12695,12695,1,1,1,1,'Bronze Mittens');
INSERT INTO `synth_recipes` VALUES (1927,0,0,0,0,0,0,12,0,0,0,4099,4241,650,12704,0,0,0,0,0,0,12705,12770,12770,12770,1,1,1,1,'Brass Mittens');
INSERT INTO `synth_recipes` VALUES (1928,0,0,0,0,0,0,0,10,41,0,4099,4241,662,852,0,0,0,0,0,0,12706,12718,12718,12718,1,1,1,1,'Iron Mittens');
INSERT INTO `synth_recipes` VALUES (1929,0,0,0,63,0,0,0,31,0,0,4099,4241,851,868,896,0,0,0,0,0,12707,13956,13956,13956,1,1,1,1,'Scorpion Mittens');
INSERT INTO `synth_recipes` VALUES (1930,0,0,0,0,0,0,0,41,73,0,4099,4241,664,855,0,0,0,0,0,0,12708,13994,13994,13994,1,1,1,1,'Darksteel Mittens');
INSERT INTO `synth_recipes` VALUES (1931,0,0,0,74,0,0,0,48,0,0,4099,4241,506,866,887,0,0,0,0,0,12709,13995,13995,13995,1,1,1,1,'Coral Mittens');
INSERT INTO `synth_recipes` VALUES (1932,0,0,0,20,0,0,0,5,0,0,4099,4241,850,850,880,880,0,0,0,0,12710,12788,12788,12788,1,1,1,1,'Bone Mittens');
INSERT INTO `synth_recipes` VALUES (1933,0,0,0,30,0,0,0,8,0,0,4099,4241,852,852,889,0,0,0,0,0,12711,12789,12789,12789,1,1,1,1,'Beetle Mittens');
INSERT INTO `synth_recipes` VALUES (1934,0,0,0,0,12,0,0,0,0,3,4099,4241,706,817,824,824,0,0,0,0,12712,12774,12774,12774,1,1,1,1,'Tekko');
INSERT INTO `synth_recipes` VALUES (1935,0,0,0,0,22,0,0,0,0,6,4099,4241,706,817,825,825,0,0,0,0,12713,12777,12777,12777,1,1,1,1,'Cotton Tekko');
INSERT INTO `synth_recipes` VALUES (1936,0,0,0,0,32,0,0,0,0,7,4099,4241,706,817,826,826,0,0,0,0,12714,12781,12781,12781,1,1,1,1,'Soil Tekko');
INSERT INTO `synth_recipes` VALUES (1937,0,0,0,0,49,0,0,0,67,0,4096,4238,662,662,680,680,816,829,0,0,12715,13996,13996,13996,1,1,1,1,'Kote');
INSERT INTO `synth_recipes` VALUES (1938,0,0,0,0,75,0,0,0,30,0,4099,4241,663,663,680,819,829,829,0,0,12716,13955,13955,13955,1,1,1,1,'Shinobi Tekko');
INSERT INTO `synth_recipes` VALUES (1939,0,0,0,0,6,0,0,0,0,0,4099,4241,817,824,824,834,834,0,0,0,12720,12773,12773,12773,1,1,1,1,'Gloves');
INSERT INTO `synth_recipes` VALUES (1940,0,0,0,0,16,0,0,0,0,0,4099,4241,818,825,825,834,834,0,0,0,12721,12776,12776,12776,1,1,1,1,'Cotton Gloves');
INSERT INTO `synth_recipes` VALUES (1941,0,0,0,0,25,0,0,0,0,0,4099,4241,819,826,826,834,834,0,0,0,12722,12779,12779,12779,1,1,1,1,'Bracers');
INSERT INTO `synth_recipes` VALUES (1942,0,0,0,0,46,0,0,0,0,0,4099,4241,820,827,827,834,834,0,0,0,12723,12783,12783,12783,1,1,1,1,'Wool Bracers');
INSERT INTO `synth_recipes` VALUES (1943,0,0,0,0,72,0,0,0,0,0,4099,4241,816,828,828,834,834,0,0,0,12724,13997,13997,13997,1,1,1,1,'Battle Bracers');
INSERT INTO `synth_recipes` VALUES (1944,0,0,0,0,81,0,0,0,0,0,4099,4241,821,828,828,834,834,0,0,0,12725,13998,13998,13998,1,1,1,1,'War Gloves');
INSERT INTO `synth_recipes` VALUES (1945,0,0,0,0,12,0,0,0,0,0,4099,4241,768,768,818,824,825,0,0,0,12728,12744,12744,12744,1,1,1,1,'Cuffs');
INSERT INTO `synth_recipes` VALUES (1946,0,0,0,0,23,0,9,0,0,0,4099,4241,807,807,819,825,826,0,0,0,12729,12778,12778,12778,1,1,1,1,'Linen Cuffs'); -- linen cuffs (cloth 23 gold 9) https://www.bg-wiki.com/bg/Linen_Cuffs
INSERT INTO `synth_recipes` VALUES (1947,0,0,0,0,41,0,18,0,0,0,4099,4241,806,806,820,826,827,0,0,0,12730,12782,12782,12782,1,1,1,1,'Wool Cuffs');
INSERT INTO `synth_recipes` VALUES (1948,0,0,0,0,58,0,8,0,0,0,4099,4241,788,788,822,827,828,0,0,0,12731,12793,12793,12793,1,1,1,1,'Velvet Cuffs');
INSERT INTO `synth_recipes` VALUES (1949,0,0,0,0,61,0,9,0,0,0,4099,4241,806,806,822,827,828,0,0,0,12731,12793,12793,12793,1,1,1,1,'Velvet Cuffs');
INSERT INTO `synth_recipes` VALUES (1950,0,0,0,0,66,0,17,0,0,0,4099,4241,791,791,823,828,829,0,0,0,12732,13954,13954,13954,1,1,1,1,'Silk Cuffs');
INSERT INTO `synth_recipes` VALUES (1951,0,0,0,0,71,0,11,0,0,0,4099,4241,795,795,823,828,829,0,0,0,12732,13954,13954,13954,1,1,1,1,'Silk Cuffs');
INSERT INTO `synth_recipes` VALUES (1952,0,0,0,0,83,0,0,0,0,0,4099,4241,823,823,825,830,834,0,0,0,12733,13999,13999,13999,1,1,1,1,'Nobles Mitts');
INSERT INTO `synth_recipes` VALUES (1953,0,0,0,0,13,0,0,0,0,0,4099,4241,818,824,825,834,0,0,0,0,12736,12775,12775,12775,1,1,1,1,'Mitts');
INSERT INTO `synth_recipes` VALUES (1954,0,0,0,0,64,0,0,0,0,0,4099,4241,823,828,829,834,0,0,0,0,12737,13953,13953,13953,1,1,1,1,'White Mitts');
INSERT INTO `synth_recipes` VALUES (1955,0,0,0,0,31,0,0,0,0,0,4099,4241,819,825,826,834,0,0,0,0,12738,12780,12780,12780,1,1,1,1,'Linen Mitts');
INSERT INTO `synth_recipes` VALUES (1956,0,0,0,0,60,0,0,0,0,0,4099,4241,822,826,828,834,0,0,0,0,12739,12794,12794,12794,1,1,1,1,'Black Mitts');
INSERT INTO `synth_recipes` VALUES (1957,0,0,0,0,74,0,0,0,0,0,4099,4241,823,823,829,829,834,0,0,0,12740,14000,14000,14000,1,1,1,1,'Silk Mitts');
INSERT INTO `synth_recipes` VALUES (1958,0,0,0,96,0,0,0,0,0,0,4099,4241,1473,1473,12696,12696,0,0,0,0,12751,12717,12717,12717,1,1,1,1,'Scp. Gauntlets');
INSERT INTO `synth_recipes` VALUES (1959,0,0,0,0,0,0,0,0,54,0,4096,4238,662,662,850,0,0,0,0,0,12800,12916,12916,12916,1,1,1,1,'Cuisses');
INSERT INTO `synth_recipes` VALUES (1960,0,0,0,0,0,0,61,0,0,0,4096,4238,663,663,851,0,0,0,0,0,12801,14211,14211,14211,1,1,1,1,'Mythril Cuisses');
INSERT INTO `synth_recipes` VALUES (1961,0,0,51,0,0,0,71,0,0,0,4096,4238,745,851,914,931,931,0,0,0,12802,14212,14212,14212,1,1,1,1,'Gold Cuisses');
INSERT INTO `synth_recipes` VALUES (1962,0,0,0,0,0,0,0,0,81,0,4096,4238,664,664,851,0,0,0,0,0,12803,14229,14229,14229,1,1,1,1,'Darksteel Cuisses');
INSERT INTO `synth_recipes` VALUES (1963,0,0,0,0,0,0,58,0,97,0,4096,4238,664,665,745,855,914,0,0,0,12804,14312,14312,14312,1,1,1,1,'Adaman Cuisses');
INSERT INTO `synth_recipes` VALUES (1964,0,0,0,0,0,0,0,7,35,0,4099,4241,680,680,826,851,851,0,0,0,12808,12890,12890,12890,1,1,1,1,'Chain Hose');
INSERT INTO `synth_recipes` VALUES (1965,0,0,0,0,0,0,44,0,0,0,4099,4241,760,12808,0,0,0,0,0,0,12809,12894,12894,12894,1,1,1,1,'Silver Hose');
INSERT INTO `synth_recipes` VALUES (1966,0,0,0,0,0,0,48,9,0,0,4099,4241,681,681,826,851,851,0,0,0,12810,12895,12895,12895,1,1,1,1,'Breeches');
INSERT INTO `synth_recipes` VALUES (1967,0,0,0,0,0,0,0,27,66,0,4099,4241,682,682,826,851,851,0,0,0,12811,14209,14209,14209,1,1,1,1,'Dst. Breeches');
INSERT INTO `synth_recipes` VALUES (1968,0,0,0,0,0,0,0,0,86,0,4099,4241,681,12811,0,0,0,0,0,0,12812,14252,14252,14252,1,1,1,1,'Thick Breeches');
INSERT INTO `synth_recipes` VALUES (1969,0,0,0,0,0,0,0,5,15,0,4099,4241,672,672,818,12824,0,0,0,0,12816,12863,12863,12863,1,1,1,1,'Scale Cuisses');
INSERT INTO `synth_recipes` VALUES (1970,0,0,0,0,0,0,34,0,0,0,4099,4241,673,673,818,848,12824,0,0,0,12817,12893,12893,12893,1,1,1,1,'Brass Cuisses');
INSERT INTO `synth_recipes` VALUES (1971,0,0,0,72,0,0,0,5,0,0,4099,4241,821,887,887,12824,0,0,0,0,12819,14230,14230,14230,1,1,1,1,'Coral Cuisses'); -- coral cuisses (bone 72, leath 5) https://www.bg-wiki.com/bg/Coral_Cuisses
INSERT INTO `synth_recipes` VALUES (1972,0,0,0,82,0,0,0,5,0,0,4099,4241,822,866,866,12824,0,0,0,0,12820,14231,14231,14231,1,1,1,1,'Dragon Cuisses'); -- dragon cuisses (bone 82, leather 5) https://www.bg-wiki.com/bg/Dragon_Cuisses
INSERT INTO `synth_recipes` VALUES (1973,0,0,0,95,0,0,0,1,0,0,4099,4241,821,1586,1587,12824,0,0,0,0,12821,14313,14313,14313,1,1,1,1,'Gavial Cuisses');
INSERT INTO `synth_recipes` VALUES (1974,0,0,0,0,0,0,0,9,0,0,4099,4241,824,824,850,850,0,0,0,0,12824,12908,12908,12908,1,1,1,1,'Leather Trousers');
INSERT INTO `synth_recipes` VALUES (1975,0,0,0,0,0,0,0,18,0,0,4099,4241,852,852,12824,0,0,0,0,0,12825,12909,12909,12909,1,1,1,1,'Lizard Trousers');
INSERT INTO `synth_recipes` VALUES (1976,0,0,0,0,0,0,0,30,0,0,4099,4241,680,848,12824,0,0,0,0,0,12826,12910,12910,12910,1,1,1,1,'Studded Trousers');
INSERT INTO `synth_recipes` VALUES (1977,0,0,0,0,0,0,0,45,0,0,4101,4243,851,851,913,12824,0,0,0,0,12827,12911,12911,12911,1,1,1,1,'Cuir Trousers'); -- cuir trousers (leath 45) https://www.bg-wiki.com/bg/Cuir_Trousers
INSERT INTO `synth_recipes` VALUES (1978,0,0,0,0,0,0,0,54,0,0,4099,4241,853,853,12827,0,0,0,0,0,12828,12919,12919,12919,1,1,1,1,'Raptor Trousers');
INSERT INTO `synth_recipes` VALUES (1979,0,0,0,0,0,0,0,64,0,0,4099,4241,854,854,12827,0,0,0,0,0,12829,14213,14213,14213,1,1,1,1,'Beak Trousers');
INSERT INTO `synth_recipes` VALUES (1980,0,0,0,0,0,0,0,74,0,0,4099,4241,855,855,12827,0,0,0,0,0,12830,14232,14232,14232,1,1,1,1,'Tiger Trousers');
INSERT INTO `synth_recipes` VALUES (1981,0,0,0,0,0,0,0,83,0,0,4099,4241,506,506,12827,0,0,0,0,0,12831,14233,14233,14233,1,1,1,1,'Coeurl Trousers');
INSERT INTO `synth_recipes` VALUES (1982,0,0,0,0,0,0,0,3,9,0,4099,4241,660,824,850,0,0,0,0,0,12832,12823,12823,12823,1,1,1,1,'Bronze Subligar');
INSERT INTO `synth_recipes` VALUES (1983,0,0,0,0,0,0,0,0,5,0,4102,4244,14242,0,0,0,0,0,0,0,12832,12823,12823,12823,1,1,1,1,'Bronze Subligar'); -- bronze subligar (smith 5) https://www.bg-wiki.com/bg/Bronze_Subligar
INSERT INTO `synth_recipes` VALUES (1984,0,0,0,0,0,0,16,0,0,0,4099,4241,661,12832,0,0,0,0,0,0,12833,12892,12892,12892,1,1,1,1,'Brass Subligar');
INSERT INTO `synth_recipes` VALUES (1985,0,0,0,24,0,0,0,6,0,0,4099,4241,824,850,850,880,0,0,0,0,12834,12912,12912,12912,1,1,1,1,'Bone Subligar');
INSERT INTO `synth_recipes` VALUES (1986,0,0,0,34,0,0,0,9,0,0,4099,4241,825,852,894,0,0,0,0,0,12835,12913,12913,12913,1,1,1,1,'Beetle Subligar');
INSERT INTO `synth_recipes` VALUES (1987,0,0,0,0,0,0,0,12,45,0,4099,4241,662,825,852,0,0,0,0,0,12836,12891,12891,12891,1,1,1,1,'Iron Subligar');
INSERT INTO `synth_recipes` VALUES (1988,0,0,0,48,0,0,0,12,0,0,4099,4241,826,848,881,0,0,0,0,0,12837,12914,12914,12914,1,1,1,1,'Carapace Subligar');
INSERT INTO `synth_recipes` VALUES (1989,0,0,0,67,0,0,0,32,0,0,4099,4241,826,851,896,0,0,0,0,0,12838,14208,14208,14208,1,1,1,1,'Scorpion Subligar');
INSERT INTO `synth_recipes` VALUES (1990,0,0,0,0,0,0,0,42,74,0,4099,4241,664,826,855,0,0,0,0,0,12839,14234,14234,14234,1,1,1,1,'Darksteel Subligar');
INSERT INTO `synth_recipes` VALUES (1991,0,0,0,0,16,0,0,0,0,0,4099,4241,817,824,824,825,0,0,0,0,12840,12899,12899,12899,1,1,1,1,'Sitabaki');
INSERT INTO `synth_recipes` VALUES (1992,0,0,0,0,26,0,0,0,0,0,4099,4241,817,825,825,826,0,0,0,0,12841,12902,12902,12902,1,1,1,1,'Cotton Sitabaki');
INSERT INTO `synth_recipes` VALUES (1993,0,0,0,0,36,0,0,0,0,0,4099,4241,817,826,826,827,0,0,0,0,12842,12905,12905,12905,1,1,1,1,'Soil Sitabaki');
INSERT INTO `synth_recipes` VALUES (1994,0,0,0,0,42,0,0,0,62,0,4099,4241,662,662,816,829,850,0,0,0,12843,14236,14236,14236,1,1,1,1,'Haidate');
INSERT INTO `synth_recipes` VALUES (1995,0,0,0,0,78,0,0,0,0,0,4099,4241,819,826,826,829,850,850,0,0,12844,12925,12925,12925,1,1,1,1,'Shinobi Hakama'); -- shinobi hakama (cloth 78) https://www.bg-wiki.com/bg/Shinobi_Hakama
INSERT INTO `synth_recipes` VALUES (1996,0,0,0,0,96,0,0,35,41,0,4099,4241,664,816,828,828,850,855,1764,0,12847,15398,15398,15398,1,1,1,1,'Yasha Hakama');
INSERT INTO `synth_recipes` VALUES (1997,0,0,0,0,9,0,0,0,0,0,4099,4241,817,824,824,850,0,0,0,0,12848,12896,12896,12896,1,1,1,1,'Brais');
INSERT INTO `synth_recipes` VALUES (1998,0,0,0,0,19,0,0,0,0,0,4099,4241,818,825,825,850,0,0,0,0,12849,12900,12900,12900,1,1,1,1,'Cotton Brais');
INSERT INTO `synth_recipes` VALUES (1999,0,0,0,0,28,0,0,0,0,0,4099,4241,819,826,826,848,0,0,0,0,12850,12903,12903,12903,1,1,1,1,'Hose');
INSERT INTO `synth_recipes` VALUES (2000,0,0,0,0,49,0,0,0,0,0,4099,4241,820,827,827,851,0,0,0,0,12851,12907,12907,12907,1,1,1,1,'Wool Hose');
INSERT INTO `synth_recipes` VALUES (2001,0,0,0,0,41,0,0,73,0,0,4099,4241,823,828,855,855,0,0,0,0,12852,14237,14237,14237,1,1,1,1,'Battle Hose'); -- battle hose (leath 73 cloth 41) https://www.bg-wiki.com/bg/Battle_Hose
INSERT INTO `synth_recipes` VALUES (2002,0,0,0,0,83,0,0,0,0,0,4099,4241,823,826,826,855,0,0,0,0,12853,14238,14238,14238,1,1,1,1,'War Brais');
INSERT INTO `synth_recipes` VALUES (2003,0,0,0,0,14,0,0,0,0,0,4099,4241,818,824,825,825,0,0,0,0,12856,12897,12897,12897,1,1,1,1,'Slops');
INSERT INTO `synth_recipes` VALUES (2004,0,0,0,0,25,0,0,0,0,0,4099,4241,819,825,826,826,0,0,0,0,12857,12901,12901,12901,1,1,1,1,'Linen Slops');
INSERT INTO `synth_recipes` VALUES (2005,0,0,0,0,42,0,28,0,0,0,4099,4241,661,820,826,827,827,0,0,0,12858,12906,12906,12906,1,1,1,1,'Wool Slops');
INSERT INTO `synth_recipes` VALUES (2006,0,0,0,0,57,0,8,0,0,0,4099,4241,661,822,827,828,828,0,0,0,12859,12918,12918,12918,1,1,1,1,'Velvet Slops');
INSERT INTO `synth_recipes` VALUES (2007,0,0,0,0,67,0,37,0,0,0,4099,4241,752,823,828,829,829,0,0,0,12860,12927,12927,12927,1,1,1,1,'Silk Slops');
INSERT INTO `synth_recipes` VALUES (2008,0,0,0,0,84,0,0,0,0,0,4099,4241,823,823,828,830,830,0,0,0,12861,14239,14239,14239,1,1,1,1,'Nobles Slacks');
INSERT INTO `synth_recipes` VALUES (2009,0,0,0,0,15,0,0,0,0,0,4099,4241,818,825,825,825,0,0,0,0,12864,12898,12898,12898,1,1,1,1,'Slacks');
INSERT INTO `synth_recipes` VALUES (2010,0,0,0,0,52,0,0,0,0,0,4099,4241,822,826,826,828,0,0,0,0,12865,12917,12917,12917,1,1,1,1,'Black Slacks');
INSERT INTO `synth_recipes` VALUES (2011,0,0,0,0,32,0,0,0,0,0,4099,4241,819,826,826,826,0,0,0,0,12866,12904,12904,12904,1,1,1,1,'Linen Slacks');
INSERT INTO `synth_recipes` VALUES (2012,0,0,0,0,61,0,0,0,0,0,4099,4241,823,828,828,829,0,0,0,0,12867,12926,12926,12926,1,1,1,1,'White Slacks');
INSERT INTO `synth_recipes` VALUES (2013,0,0,0,0,73,0,0,0,0,0,4099,4241,823,823,829,829,829,0,0,0,12868,14240,14240,14240,1,1,1,1,'Silk Slacks');
INSERT INTO `synth_recipes` VALUES (2014,0,0,0,72,0,0,0,46,0,0,4099,4241,506,826,887,0,0,0,0,0,12878,14235,14235,14235,1,1,1,1,'Coral Subligar');
INSERT INTO `synth_recipes` VALUES (2015,0,0,0,0,0,0,0,93,0,0,4099,4241,862,12830,0,0,0,0,0,0,12879,14307,14307,14307,1,1,1,1,'Dusk Trousers');
INSERT INTO `synth_recipes` VALUES (2016,0,0,0,0,0,0,0,84,0,0,4099,4241,1117,12831,0,0,0,0,0,0,12880,14279,14279,14279,1,1,1,1,'Ogre Trousers');
INSERT INTO `synth_recipes` VALUES (2017,0,0,0,0,0,0,0,0,56,0,4096,4238,662,662,662,850,850,0,0,0,12928,13046,13046,13046,1,1,1,1,'Plate Leggings');
INSERT INTO `synth_recipes` VALUES (2018,0,0,0,0,0,0,64,0,0,0,4096,4238,663,663,664,851,851,0,0,0,12929,14086,14086,14086,1,1,1,1,'Mythril Leggings');
INSERT INTO `synth_recipes` VALUES (2019,0,0,54,0,0,0,74,0,0,0,4096,4238,745,851,851,914,931,931,931,0,12930,14087,14087,14087,1,1,1,1,'Gold Sabatons');
INSERT INTO `synth_recipes` VALUES (2020,0,0,0,0,0,0,54,0,84,0,4096,4238,664,664,664,745,851,851,914,0,12931,14105,14105,14105,1,1,1,1,'Dst. Sabatons');
INSERT INTO `synth_recipes` VALUES (2021,0,0,0,0,0,0,60,0,100,0,4096,4238,664,664,665,745,855,855,914,0,12932,14193,14193,14193,1,1,1,1,'Adaman Sabatons');
INSERT INTO `synth_recipes` VALUES (2022,0,0,0,0,0,0,0,6,33,0,4099,4241,662,680,851,0,0,0,0,0,12936,13025,13025,13025,1,1,1,1,'Greaves');
INSERT INTO `synth_recipes` VALUES (2023,0,0,0,0,0,0,42,0,0,0,4096,4238,744,914,12936,0,0,0,0,0,12937,13029,13029,13029,1,1,1,1,'Silver Greaves');
INSERT INTO `synth_recipes` VALUES (2024,0,0,0,0,0,0,46,0,0,0,4099,4241,663,663,12936,0,0,0,0,0,12938,13047,13047,13047,1,1,1,1,'Sollerets');
INSERT INTO `synth_recipes` VALUES (2025,0,0,0,0,0,0,0,0,62,0,4099,4241,664,664,12936,0,0,0,0,0,12939,14084,14084,14084,1,1,1,1,'Dst. Sollerets');
INSERT INTO `synth_recipes` VALUES (2026,0,0,0,0,0,0,0,0,83,0,4099,4241,666,12939,0,0,0,0,0,0,12940,14127,14127,14127,1,1,1,1,'Thick Sollerets');
INSERT INTO `synth_recipes` VALUES (2027,0,0,0,0,0,0,0,0,13,0,4099,4241,672,672,818,12952,0,0,0,0,12944,13024,13024,13024,1,1,1,1,'Scale Greaves');
INSERT INTO `synth_recipes` VALUES (2028,0,0,0,0,0,0,32,0,0,0,4099,4241,673,673,818,848,12952,0,0,0,12945,13028,13028,13028,1,1,1,1,'Brass Greaves');
INSERT INTO `synth_recipes` VALUES (2029,0,0,0,76,0,0,0,0,0,0,4099,4241,821,887,887,12952,0,0,0,0,12947,14106,14106,14106,1,1,1,1,'Coral Greaves'); -- coral greaves (bone 76) https://www.bg-wiki.com/bg/Coral_Greaves
INSERT INTO `synth_recipes` VALUES (2030,0,0,0,86,0,0,0,0,0,0,4099,4241,822,866,866,12952,0,0,0,0,12948,14107,14107,14107,1,1,1,1,'Dragon Greaves'); -- dragon greaves (bone 86) https://www.bg-wiki.com/bg/Dragon_Greaves
INSERT INTO `synth_recipes` VALUES (2031,0,0,0,99,0,0,0,0,0,0,4099,4241,821,1586,1587,12952,0,0,0,0,12949,14194,14194,14194,1,1,1,1,'Gavial Greaves');
INSERT INTO `synth_recipes` VALUES (2032,0,0,0,0,0,0,0,6,0,0,4099,4241,672,850,850,850,0,0,0,0,12952,12971,12971,12971,1,1,1,1,'Leather Highboots');
INSERT INTO `synth_recipes` VALUES (2033,0,0,0,0,0,0,5,18,0,0,4099,4241,661,852,12952,0,0,0,0,0,12953,13038,13038,13038,1,1,1,1,'Lizard Ledelsens');
INSERT INTO `synth_recipes` VALUES (2034,0,0,0,0,0,0,0,28,0,0,4099,4241,680,848,12952,0,0,0,0,0,12954,13039,13039,13039,1,1,1,1,'Studded Boots');
INSERT INTO `synth_recipes` VALUES (2035,0,0,0,0,0,0,0,42,0,0,4101,4243,851,851,913,12952,0,0,0,0,12955,13041,13041,13041,1,1,1,1,'Cuir Highboots');
INSERT INTO `synth_recipes` VALUES (2036,0,0,0,0,0,0,28,55,0,0,4099,4241,663,853,12955,0,0,0,0,0,12956,13049,13049,13049,1,1,1,1,'Raptor Ledelsens'); -- raptor ledelsens (leath 55 gold 28) https://www.bg-wiki.com/bg/Raptor_Ledelsens
INSERT INTO `synth_recipes` VALUES (2037,0,0,0,0,0,0,0,94,0,0,4099,4241,862,12958,0,0,0,0,0,0,12957,14188,14188,14188,1,1,1,1,'Dusk Ledelsens');
INSERT INTO `synth_recipes` VALUES (2038,0,0,0,0,0,0,28,75,0,0,4099,4241,663,855,12955,0,0,0,0,0,12958,14108,14108,14108,1,1,1,1,'Tiger Ledelsens'); -- tiger ledelsens (leath 75 gold 28) https://www.bg-wiki.com/bg/Tiger_Ledelsens
INSERT INTO `synth_recipes` VALUES (2039,0,0,0,0,0,0,23,84,0,0,4099,4241,506,663,12955,0,0,0,0,0,12959,14109,14109,14109,1,1,1,1,'Coeurl Ledelsens');
INSERT INTO `synth_recipes` VALUES (2040,0,0,0,0,0,0,0,3,7,0,4099,4241,660,660,850,850,0,0,0,0,12960,12951,12951,12951,1,1,1,1,'Bronze Leggings');
INSERT INTO `synth_recipes` VALUES (2041,0,0,0,0,0,0,0,0,2,0,4102,4244,14117,0,0,0,0,0,0,0,12960,12951,12951,12951,1,1,1,1,'Bronze Leggings');
INSERT INTO `synth_recipes` VALUES (2042,0,0,0,0,0,0,14,0,0,0,4099,4241,661,12960,0,0,0,0,0,0,12961,13027,13027,13027,1,1,1,1,'Brass Leggings');
INSERT INTO `synth_recipes` VALUES (2043,0,0,0,0,0,0,0,11,43,0,4099,4241,662,662,852,852,0,0,0,0,12962,13026,13026,13026,1,1,1,1,'Leggings');
INSERT INTO `synth_recipes` VALUES (2044,0,0,0,65,0,0,0,32,0,0,4099,4241,851,851,868,896,0,0,0,0,12963,14083,14083,14083,1,1,1,1,'Scorpion Leggings');
INSERT INTO `synth_recipes` VALUES (2045,0,0,0,0,0,0,0,48,75,0,4099,4241,664,664,855,855,0,0,0,0,12964,14110,14110,14110,1,1,1,1,'Dst. Leggings');
INSERT INTO `synth_recipes` VALUES (2046,0,0,0,76,0,0,0,41,0,0,4099,4241,506,506,866,887,0,0,0,0,12965,14111,14111,14111,1,1,1,1,'Coral Leggings');
INSERT INTO `synth_recipes` VALUES (2047,0,0,0,22,0,0,0,5,0,0,4099,4241,850,850,880,893,0,0,0,0,12966,13042,13042,13042,1,1,1,1,'Bone Leggings');
INSERT INTO `synth_recipes` VALUES (2048,0,0,0,32,0,0,0,8,0,0,4099,4241,852,852,889,894,0,0,0,0,12967,13043,13043,13043,1,1,1,1,'Beetle Leggings');
INSERT INTO `synth_recipes` VALUES (2049,0,0,0,0,14,0,0,0,0,0,4098,4240,824,824,824,850,0,0,0,0,12968,13031,13031,13031,1,1,1,1,'Kyahan');
INSERT INTO `synth_recipes` VALUES (2050,0,0,0,0,24,0,0,0,0,0,4098,4240,819,825,825,825,0,0,0,0,12969,13033,13033,13033,1,1,1,1,'Cotton Kyahan');
INSERT INTO `synth_recipes` VALUES (2051,0,0,0,0,34,0,0,0,0,0,4098,4240,818,826,826,826,0,0,0,0,12970,13035,13035,13035,1,1,1,1,'Soil Kyahan');
INSERT INTO `synth_recipes` VALUES (2052,0,0,0,0,73,0,0,0,0,0,4098,4240,663,819,829,829,829,0,0,0,12972,14082,14082,14082,1,1,1,1,'Shinobi Kyahan');
INSERT INTO `synth_recipes` VALUES (2053,0,0,0,0,49,0,0,0,64,0,4096,4238,662,662,816,829,850,0,0,0,12974,14112,14112,14112,1,1,1,1,'Sune-ate');
INSERT INTO `synth_recipes` VALUES (2054,0,0,0,0,7,0,0,0,0,0,4099,4241,818,824,824,824,0,0,0,0,12976,13030,13030,13030,1,1,1,1,'Gaiters');
INSERT INTO `synth_recipes` VALUES (2055,0,0,0,0,17,0,0,0,0,0,4099,4241,825,825,825,850,0,0,0,0,12977,13032,13032,13032,1,1,1,1,'Cotton Gaiters');
INSERT INTO `synth_recipes` VALUES (2056,0,0,0,0,26,0,0,0,0,0,4099,4241,819,826,826,826,848,0,0,0,12978,13034,13034,13034,1,1,1,1,'Socks');
INSERT INTO `synth_recipes` VALUES (2057,0,0,0,0,48,0,0,0,0,0,4099,4241,820,827,827,827,851,0,0,0,12979,13036,13036,13036,1,1,1,1,'Wool Socks');
INSERT INTO `synth_recipes` VALUES (2058,0,0,0,0,0,0,0,66,0,0,4099,4241,674,851,851,855,0,0,0,0,12980,14104,14104,14104,1,1,1,1,'Battle Boots');
INSERT INTO `synth_recipes` VALUES (2059,0,0,0,0,0,0,0,85,0,0,4099,4241,506,761,855,855,0,0,0,0,12981,14113,14113,14113,1,1,1,1,'War Boots');
INSERT INTO `synth_recipes` VALUES (2060,0,0,0,0,0,0,0,0,0,11,4098,4240,715,850,0,0,0,0,0,0,12984,12983,12983,12983,1,1,1,1,'Ash Clogs');
INSERT INTO `synth_recipes` VALUES (2061,0,0,0,0,0,0,0,0,0,18,4098,4240,714,850,0,0,0,0,0,0,12985,12991,12991,12991,1,1,1,1,'Holly Clogs');
INSERT INTO `synth_recipes` VALUES (2062,0,0,0,0,0,0,0,0,0,32,4098,4240,710,850,0,0,0,0,0,0,12986,13022,13022,13022,1,1,1,1,'Chestnut Sabots');
INSERT INTO `synth_recipes` VALUES (2063,0,0,0,0,0,0,0,0,0,43,4098,4240,719,850,0,0,0,0,0,0,12987,13023,13023,13023,1,1,1,1,'Ebony Sabots');
INSERT INTO `synth_recipes` VALUES (2064,0,0,0,0,45,0,0,71,0,0,4099,4241,823,829,853,855,855,0,0,0,12988,14081,14081,14081,1,1,1,1,'Pigaches'); -- pigaches (leather 71 cloth 45) https://www.bg-wiki.com/bg/Pigaches
INSERT INTO `synth_recipes` VALUES (2065,0,0,0,0,57,0,0,81,0,0,4099,4241,823,823,828,830,855,0,0,0,12989,14114,14114,14114,1,1,1,1,'Nobles Pumps');
INSERT INTO `synth_recipes` VALUES (2066,0,0,0,0,0,0,0,11,0,0,4098,4240,850,850,0,0,0,0,0,0,12992,13037,13037,13037,1,1,1,1,'Solea');
INSERT INTO `synth_recipes` VALUES (2067,0,0,0,0,0,0,0,29,0,0,4098,4240,848,850,0,0,0,0,0,0,12993,13048,13048,13048,1,1,1,1,'Sandals');
INSERT INTO `synth_recipes` VALUES (2068,0,0,0,0,8,0,0,34,0,0,4099,4241,825,848,848,0,0,0,0,0,12994,13040,13040,13040,1,1,1,1,'Shoes');
INSERT INTO `synth_recipes` VALUES (2069,0,0,0,0,8,0,0,59,0,0,4099,4241,826,848,853,0,0,0,0,0,12995,13050,13050,13050,1,1,1,1,'Moccasins');
INSERT INTO `synth_recipes` VALUES (2070,0,0,0,0,47,0,0,76,0,0,4099,4241,823,823,829,829,850,0,0,0,12996,14115,14115,14115,1,1,1,1,'Silk Pumps');
INSERT INTO `synth_recipes` VALUES (2071,0,0,0,0,92,0,0,41,44,0,4098,4240,664,816,855,855,1764,0,0,0,13002,15336,15336,15336,1,1,1,1,'Yasha Sune-ate');
INSERT INTO `synth_recipes` VALUES (2072,0,0,0,0,38,0,0,0,0,0,4099,4241,827,847,847,847,847,847,847,847,13075,13060,13060,13060,1,1,1,1,'Feather Collar');
INSERT INTO `synth_recipes` VALUES (2073,0,0,0,15,0,0,0,0,0,0,4099,4241,817,880,880,884,891,891,891,891,13076,13061,13061,13061,1,1,1,1,'Fang Necklace');
INSERT INTO `synth_recipes` VALUES (2074,0,0,0,0,0,0,0,0,81,0,4096,4238,664,851,0,0,0,0,0,0,13079,13131,13131,13131,1,1,1,1,'Darksteel Gorget');
INSERT INTO `synth_recipes` VALUES (2075,0,0,0,0,0,0,0,0,53,0,4096,4238,662,850,0,0,0,0,0,0,13080,13065,13065,13065,1,1,1,1,'Gorget');
INSERT INTO `synth_recipes` VALUES (2076,0,0,0,0,0,0,0,37,0,0,4099,4241,817,851,0,0,0,0,0,0,13081,13069,13069,13069,1,1,1,1,'Leather Gorget');
INSERT INTO `synth_recipes` VALUES (2077,0,0,0,0,0,0,37,0,0,0,4099,4241,760,760,760,0,0,0,0,0,13082,13059,13059,13059,1,1,1,1,'Chain Gorget');
INSERT INTO `synth_recipes` VALUES (2078,0,0,0,0,0,0,39,0,0,0,4099,4241,760,760,790,0,0,0,0,0,13083,13066,13066,13066,1,1,1,1,'Chain Choker');
INSERT INTO `synth_recipes` VALUES (2079,0,0,0,0,0,0,56,0,0,0,4096,4238,663,681,745,784,914,0,0,0,13084,13067,13067,13067,1,1,1,1,'Mythril Gorget');
INSERT INTO `synth_recipes` VALUES (2080,0,0,0,0,43,0,0,0,0,0,4099,4241,817,817,817,817,817,817,817,817,13085,13068,13068,13068,1,1,1,1,'Hemp Gorget');
INSERT INTO `synth_recipes` VALUES (2081,0,0,0,0,0,0,90,0,0,0,4099,4241,752,785,786,787,789,794,804,13125,13087,13130,13130,13130,1,1,1,1,'Jeweled Collar');
INSERT INTO `synth_recipes` VALUES (2082,0,0,0,0,0,0,0,0,83,0,4099,4241,664,816,0,0,0,0,0,0,13088,13133,13133,13133,1,1,1,1,'Darksteel Nodowa');
INSERT INTO `synth_recipes` VALUES (2083,0,0,0,0,0,0,0,39,0,0,4099,4241,818,858,0,0,0,0,0,0,13089,13070,13070,13070,1,1,1,1,'Wolf Gorget');
INSERT INTO `synth_recipes` VALUES (2084,0,0,0,31,0,0,0,0,0,0,4099,4241,889,894,894,0,0,0,0,0,13090,13062,13062,13062,1,1,1,1,'Beetle Gorget');
INSERT INTO `synth_recipes` VALUES (2085,0,0,0,49,0,0,0,0,0,0,4099,4241,680,881,881,0,0,0,0,0,13091,13063,13063,13063,1,1,1,1,'Carapace Gorget');
INSERT INTO `synth_recipes` VALUES (2086,0,0,0,0,0,0,0,79,0,0,4099,4241,818,863,0,0,0,0,0,0,13092,13132,13132,13132,1,1,1,1,'Coeurl Gorget');
INSERT INTO `synth_recipes` VALUES (2087,0,0,0,0,0,0,100,0,0,0,4096,4238,745,745,745,761,762,762,1445,13087,13097,13162,13162,13162,1,1,1,1,'Brisingamen');
INSERT INTO `synth_recipes` VALUES (2088,0,0,0,79,0,0,0,0,0,0,4098,4240,850,887,0,0,0,0,0,0,13108,13123,13123,13123,1,1,1,1,'Coral Gorget');
INSERT INTO `synth_recipes` VALUES (2089,0,0,0,0,0,0,0,0,66,0,4099,4241,662,816,0,0,0,0,0,0,13111,13124,13124,13124,1,1,1,1,'Nodowa');
INSERT INTO `synth_recipes` VALUES (2090,0,0,0,0,0,0,77,0,0,0,4096,4238,745,745,745,745,0,0,0,0,13125,13126,13126,13126,1,1,1,1,'Torque');
INSERT INTO `synth_recipes` VALUES (2091,0,0,0,0,0,0,59,0,0,0,4099,4241,1834,13084,0,0,0,0,0,0,13144,13144,13144,13144,1,1,1,1,'Wing Gorget');
INSERT INTO `synth_recipes` VALUES (2092,0,0,0,0,0,0,80,0,0,0,4096,4238,1674,13125,0,0,0,0,0,0,13170,13170,13170,13170,1,1,1,1,'Stoneskin Torque');
INSERT INTO `synth_recipes` VALUES (2093,0,0,0,82,0,0,0,0,0,0,4098,4240,1715,13108,0,0,0,0,0,0,13171,13171,13171,13171,1,1,1,1,'Reraise Gorget');
INSERT INTO `synth_recipes` VALUES (2094,0,0,0,0,0,0,92,0,0,0,4096,4238,650,745,1117,0,0,0,0,0,13185,13279,13279,13279,1,1,1,1,'Muscle Belt');
INSERT INTO `synth_recipes` VALUES (2095,0,0,0,0,0,0,0,13,0,0,4098,4240,680,850,0,0,0,0,0,0,13192,13210,13210,13210,1,1,1,1,'Leather Belt');
INSERT INTO `synth_recipes` VALUES (2096,0,0,0,0,0,0,0,12,0,0,4098,4240,680,852,0,0,0,0,0,0,13193,13191,13191,13191,1,1,1,1,'Lizard Belt');
INSERT INTO `synth_recipes` VALUES (2097,0,0,0,0,0,0,0,25,0,0,4098,4240,680,848,0,0,0,0,0,0,13194,13240,13240,13240,1,1,1,1,'Warriors Belt');
INSERT INTO `synth_recipes` VALUES (2098,0,0,0,0,0,0,0,37,0,0,4098,4240,851,914,915,0,0,0,0,0,13195,13219,13219,13219,1,1,1,1,'Magic Belt');
INSERT INTO `synth_recipes` VALUES (2099,0,0,0,0,0,0,25,0,0,0,4099,4241,744,13193,0,0,0,0,0,0,13196,13223,13223,13223,1,1,1,1,'Silver Belt'); -- silver belt (gold 25) https://www.bg-wiki.com/bg/Silver_Belt
INSERT INTO `synth_recipes` VALUES (2100,0,0,0,0,0,0,0,90,0,0,4099,4241,761,1117,1117,0,0,0,0,0,13197,13239,13239,13239,1,1,1,1,'Koenigs Belt');
INSERT INTO `synth_recipes` VALUES (2101,0,0,0,0,0,0,0,71,0,0,4099,4241,680,855,855,0,0,0,0,0,13198,13232,13232,13232,1,1,1,1,'Swordbelt');
INSERT INTO `synth_recipes` VALUES (2102,0,0,0,57,0,0,0,0,0,0,4098,4240,817,893,924,0,0,0,0,0,13199,13226,13226,13226,1,1,1,1,'Blood Stone');
INSERT INTO `synth_recipes` VALUES (2103,0,0,0,0,0,0,0,43,0,0,4098,4240,817,851,851,0,0,0,0,0,13200,13214,13214,13214,1,1,1,1,'Waistbelt');
INSERT INTO `synth_recipes` VALUES (2104,0,0,0,0,0,0,0,41,0,0,4101,4243,924,930,13192,0,0,0,0,0,13203,13225,13225,13225,1,1,1,1,'Barbarians Belt');
INSERT INTO `synth_recipes` VALUES (2105,0,0,0,0,27,0,0,0,0,0,4099,4241,817,825,825,0,0,0,0,0,13204,13190,13190,13190,1,1,1,1,'Heko Obi');
INSERT INTO `synth_recipes` VALUES (2106,0,0,0,0,51,0,0,0,0,0,4099,4241,822,822,822,0,0,0,0,0,13205,13224,13224,13224,1,1,1,1,'Silver Obi');
INSERT INTO `synth_recipes` VALUES (2107,0,0,0,0,70,0,0,0,0,0,4099,4241,823,823,823,0,0,0,0,0,13206,13233,13233,13233,1,1,1,1,'Gold Obi');
INSERT INTO `synth_recipes` VALUES (2108,0,0,0,0,80,0,0,0,0,0,4099,4241,821,821,822,822,823,823,0,0,13207,13234,13234,13234,1,1,1,1,'Brocade Obi');
INSERT INTO `synth_recipes` VALUES (2109,0,0,0,0,90,0,0,0,0,0,4099,4241,821,821,821,821,822,823,0,0,13208,13235,13235,13235,1,1,1,1,'Rainbow Obi');
INSERT INTO `synth_recipes` VALUES (2110,0,0,0,0,0,0,34,0,0,0,4099,4241,744,760,760,760,0,0,0,0,13209,13213,13213,13213,1,1,1,1,'Chain Belt');
INSERT INTO `synth_recipes` VALUES (2111,0,0,0,0,95,0,0,0,0,0,4099,4241,820,821,822,823,1163,1163,0,0,13212,13188,13188,13188,1,1,1,1,'Tarutaru Sash');
INSERT INTO `synth_recipes` VALUES (2112,0,0,0,0,0,0,0,85,0,0,4099,4241,851,13189,0,0,0,0,0,0,13249,13250,13250,13250,1,1,1,1,'Sonic Belt');
INSERT INTO `synth_recipes` VALUES (2113,0,0,0,0,0,0,0,48,0,0,4099,4241,829,848,927,13200,13568,0,0,0,13271,13272,13272,13272,1,1,1,1,'Corsette');
INSERT INTO `synth_recipes` VALUES (2114,0,0,0,0,58,0,0,0,0,0,4099,4241,1278,1278,1278,0,0,0,0,0,13273,13274,13274,13274,1,1,1,1,'Twinthread Obi');
INSERT INTO `synth_recipes` VALUES (2115,0,0,0,0,84,0,0,0,0,0,4099,4241,821,821,821,822,823,1294,0,0,13275,13276,13276,13276,1,1,1,1,'Arachne Obi');
INSERT INTO `synth_recipes` VALUES (2116,0,0,0,0,0,0,0,46,0,0,4099,4241,851,13220,0,0,0,0,0,0,13277,13278,13278,13278,1,1,1,1,'R.k. Belt +1');
INSERT INTO `synth_recipes` VALUES (2117,0,0,0,0,0,0,0,90,0,0,4099,4241,855,13514,0,0,0,0,0,0,13280,13281,13281,13281,1,1,1,1,'Snipers Ring');
INSERT INTO `synth_recipes` VALUES (2118,0,0,0,81,0,0,0,0,0,0,4099,4241,864,13440,0,0,0,0,0,0,13282,13283,13283,13283,1,1,1,1,'Saintly Ring');
INSERT INTO `synth_recipes` VALUES (2119,0,0,0,82,0,0,0,0,0,0,4099,4241,882,13475,0,0,0,0,0,0,13284,13285,13285,13285,1,1,1,1,'Eremites Ring');
INSERT INTO `synth_recipes` VALUES (2120,0,0,0,83,0,0,0,0,0,0,4098,4240,760,887,887,0,0,0,0,0,13312,13406,13406,13406,1,1,1,1,'Coral Earring');
INSERT INTO `synth_recipes` VALUES (2121,0,0,0,3,0,0,0,0,0,0,4098,4240,888,888,0,0,0,0,0,0,13313,13314,13314,13314,1,1,1,1,'Shell Earring');
INSERT INTO `synth_recipes` VALUES (2122,0,0,0,0,0,0,57,0,0,0,4098,4240,745,745,0,0,0,0,0,0,13315,13372,13372,13372,1,1,1,1,'Gold Earring');
INSERT INTO `synth_recipes` VALUES (2123,0,0,0,0,0,0,68,0,0,0,4098,4240,746,746,0,0,0,0,0,0,13316,13397,13397,13397,1,1,1,1,'Platinum Earring');
INSERT INTO `synth_recipes` VALUES (2124,0,0,0,0,0,0,45,0,0,0,4099,4241,792,13328,0,0,0,0,0,0,13317,13388,13388,13388,1,1,1,1,'Pearl Earring');
INSERT INTO `synth_recipes` VALUES (2125,0,0,0,0,0,0,50,0,0,0,4099,4241,792,13371,0,0,0,0,0,0,13317,14703,14703,14703,1,1,1,1,'Pearl Earring');
INSERT INTO `synth_recipes` VALUES (2126,0,0,0,0,0,0,85,0,0,0,4099,4241,789,13316,0,0,0,0,0,0,13318,13412,13412,13412,1,1,1,1,'Topaz Earring');
INSERT INTO `synth_recipes` VALUES (2127,0,0,0,0,0,0,90,0,0,0,4099,4241,789,13397,0,0,0,0,0,0,13318,14717,14717,14717,1,1,1,1,'Topaz Earring');
INSERT INTO `synth_recipes` VALUES (2128,0,0,0,0,0,0,50,0,0,0,4096,4238,788,13371,0,0,0,0,0,0,13319,14696,14696,14696,1,1,1,1,'Peridot Earring');
INSERT INTO `synth_recipes` VALUES (2129,0,0,0,0,0,0,45,0,0,0,4099,4241,788,13328,0,0,0,0,0,0,13319,13381,13381,13381,1,1,1,1,'Peridot Earring');
INSERT INTO `synth_recipes` VALUES (2130,0,0,0,0,0,0,45,0,0,0,4099,4241,793,13328,0,0,0,0,0,0,13320,13387,13387,13387,1,1,1,1,'Black Earring');
INSERT INTO `synth_recipes` VALUES (2131,0,0,0,0,0,0,50,0,0,0,4099,4241,793,13371,0,0,0,0,0,0,13320,14702,14702,14702,1,1,1,1,'Black Earring');
INSERT INTO `synth_recipes` VALUES (2132,0,0,0,12,0,0,3,0,0,0,4098,4240,650,880,880,0,0,0,0,0,13321,13362,13362,13362,1,1,1,1,'Bone Earring');
INSERT INTO `synth_recipes` VALUES (2133,0,0,0,0,44,0,11,0,0,0,4099,4241,744,846,846,0,0,0,0,0,13322,13361,13361,13361,1,1,1,1,'Wing Earring'); -- wing earring (cloth 44 gold 11) https://www.bg-wiki.com/bg/Wing_Earring
INSERT INTO `synth_recipes` VALUES (2134,0,0,0,27,0,0,0,0,0,0,4099,4241,894,13327,0,0,0,0,0,0,13323,13326,13326,13326,1,1,1,1,'Beetle Earring');
INSERT INTO `synth_recipes` VALUES (2135,0,0,0,55,0,0,0,0,0,0,4098,4240,761,885,0,0,0,0,0,0,13324,13363,13363,13363,1,1,1,1,'Tortoise Earring');
INSERT INTO `synth_recipes` VALUES (2136,0,0,0,61,0,0,0,0,0,0,4098,4240,760,884,884,0,0,0,0,0,13325,13369,13369,13369,1,1,1,1,'Fang Earring');
INSERT INTO `synth_recipes` VALUES (2137,0,0,0,0,0,0,22,0,0,0,4098,4240,744,744,0,0,0,0,0,0,13327,13370,13370,13370,1,1,1,1,'Silver Earring');
INSERT INTO `synth_recipes` VALUES (2138,0,0,0,0,0,0,42,0,0,0,4098,4240,653,653,0,0,0,0,0,0,13328,13371,13371,13371,1,1,1,1,'Mythril Earring');
INSERT INTO `synth_recipes` VALUES (2139,0,0,0,0,0,0,91,0,0,0,4098,4240,747,747,0,0,0,0,0,0,13329,13434,13434,13434,1,1,1,1,'Ocl. Earring');
INSERT INTO `synth_recipes` VALUES (2140,0,0,0,0,0,0,25,0,0,0,4099,4241,806,13327,0,0,0,0,0,0,13330,13373,13373,13373,1,1,1,1,'Tml. Earring');
INSERT INTO `synth_recipes` VALUES (2141,0,0,0,0,0,0,30,0,0,0,4099,4241,806,13370,0,0,0,0,0,0,13330,14688,14688,14688,1,1,1,1,'Tml. Earring');
INSERT INTO `synth_recipes` VALUES (2142,0,0,0,0,0,0,25,0,0,0,4099,4241,807,13327,0,0,0,0,0,0,13331,13374,13374,13374,1,1,1,1,'Sardonyx Earring');
INSERT INTO `synth_recipes` VALUES (2143,0,0,0,0,0,0,30,0,0,0,4099,4241,807,13370,0,0,0,0,0,0,13331,14689,14689,14689,1,1,1,1,'Sardonyx Earring');
INSERT INTO `synth_recipes` VALUES (2144,0,0,0,0,0,0,25,0,0,0,4099,4241,809,13327,0,0,0,0,0,0,13332,13375,13375,13375,1,1,1,1,'Clear Earring');
INSERT INTO `synth_recipes` VALUES (2145,0,0,0,0,0,0,30,0,0,0,4099,4241,809,13370,0,0,0,0,0,0,13332,14690,14690,14690,1,1,1,1,'Clear Earring');
INSERT INTO `synth_recipes` VALUES (2146,0,0,0,0,0,0,25,0,0,0,4099,4241,800,13327,0,0,0,0,0,0,13333,13376,13376,13376,1,1,1,1,'Amethyst Earring');
INSERT INTO `synth_recipes` VALUES (2147,0,0,0,0,0,0,30,0,0,0,4099,4241,800,13370,0,0,0,0,0,0,13333,14691,14691,14691,1,1,1,1,'Amethyst Earring');
INSERT INTO `synth_recipes` VALUES (2148,0,0,0,0,0,0,25,0,0,0,4099,4241,795,13327,0,0,0,0,0,0,13334,13377,13377,13377,1,1,1,1,'Lapis Laz. Earring');
INSERT INTO `synth_recipes` VALUES (2149,0,0,0,0,0,0,30,0,0,0,4099,4241,795,13370,0,0,0,0,0,0,13334,14692,14692,14692,1,1,1,1,'Lapis Laz. Earring');
INSERT INTO `synth_recipes` VALUES (2150,0,0,0,0,0,0,25,0,0,0,4099,4241,814,13327,0,0,0,0,0,0,13335,13378,13378,13378,1,1,1,1,'Amber Earring');
INSERT INTO `synth_recipes` VALUES (2151,0,0,0,0,0,0,30,0,0,0,4099,4241,814,13370,0,0,0,0,0,0,13335,14693,14693,14693,1,1,1,1,'Amber Earring');
INSERT INTO `synth_recipes` VALUES (2152,0,0,0,0,0,0,25,0,0,0,4099,4241,799,13327,0,0,0,0,0,0,13336,13379,13379,13379,1,1,1,1,'Onyx Earring');
INSERT INTO `synth_recipes` VALUES (2153,0,0,0,0,0,0,30,0,0,0,4099,4241,799,13370,0,0,0,0,0,0,13336,14694,14694,14694,1,1,1,1,'Onyx Earring');
INSERT INTO `synth_recipes` VALUES (2154,0,0,0,0,0,0,25,0,0,0,4099,4241,796,13327,0,0,0,0,0,0,13337,13380,13380,13380,1,1,1,1,'Opal Earring');
INSERT INTO `synth_recipes` VALUES (2155,0,0,0,0,0,0,30,0,0,0,4099,4241,796,13370,0,0,0,0,0,0,13337,14695,14695,14695,1,1,1,1,'Opal Earring');
INSERT INTO `synth_recipes` VALUES (2156,0,0,0,0,0,0,45,0,0,0,4099,4241,790,13328,0,0,0,0,0,0,13338,13382,13382,13382,1,1,1,1,'Blood Earring');
INSERT INTO `synth_recipes` VALUES (2157,0,0,0,0,0,0,50,0,0,0,4099,4241,790,13371,0,0,0,0,0,0,13338,14697,14697,14697,1,1,1,1,'Blood Earring');
INSERT INTO `synth_recipes` VALUES (2158,0,0,0,0,0,0,45,0,0,0,4099,4241,808,13328,0,0,0,0,0,0,13339,13383,13383,13383,1,1,1,1,'Goshenite Earring');
INSERT INTO `synth_recipes` VALUES (2159,0,0,0,0,0,0,50,0,0,0,4099,4241,808,13371,0,0,0,0,0,0,13339,14698,14698,14698,1,1,1,1,'Goshenite Earring');
INSERT INTO `synth_recipes` VALUES (2160,0,0,0,0,0,0,45,0,0,0,4099,4241,811,13328,0,0,0,0,0,0,13340,13384,13384,13384,1,1,1,1,'Ametrine Earring');
INSERT INTO `synth_recipes` VALUES (2161,0,0,0,0,0,0,50,0,0,0,4099,4241,811,13371,0,0,0,0,0,0,13340,14699,14699,14699,1,1,1,1,'Ametrine Earring');
INSERT INTO `synth_recipes` VALUES (2162,0,0,0,0,0,0,45,0,0,0,4099,4241,798,13328,0,0,0,0,0,0,13341,13385,13385,13385,1,1,1,1,'Turquoise Earring');
INSERT INTO `synth_recipes` VALUES (2163,0,0,0,0,0,0,50,0,0,0,4099,4241,798,13371,0,0,0,0,0,0,13341,14700,14700,14700,1,1,1,1,'Turquoise Earring');
INSERT INTO `synth_recipes` VALUES (2164,0,0,0,0,0,0,45,0,0,0,4099,4241,815,13328,0,0,0,0,0,0,13342,13386,13386,13386,1,1,1,1,'Sphene Earring');
INSERT INTO `synth_recipes` VALUES (2165,0,0,0,0,0,0,50,0,0,0,4099,4241,815,13371,0,0,0,0,0,0,13342,14701,14701,14701,1,1,1,1,'Sphene Earring');
INSERT INTO `synth_recipes` VALUES (2166,0,0,0,0,0,0,65,0,0,0,4099,4241,784,13315,0,0,0,0,0,0,13343,13389,13389,13389,1,1,1,1,'Green Earring');
INSERT INTO `synth_recipes` VALUES (2167,0,0,0,0,0,0,70,0,0,0,4099,4241,784,13372,0,0,0,0,0,0,13343,14704,14704,14704,1,1,1,1,'Green Earring');
INSERT INTO `synth_recipes` VALUES (2168,0,0,0,0,0,0,65,0,0,0,4099,4241,803,13315,0,0,0,0,0,0,13344,13390,13390,13390,1,1,1,1,'Sun Earring');
INSERT INTO `synth_recipes` VALUES (2169,0,0,0,0,0,0,70,0,0,0,4099,4241,803,13372,0,0,0,0,0,0,13344,14705,14705,14705,1,1,1,1,'Sun Earring');
INSERT INTO `synth_recipes` VALUES (2170,0,0,0,0,0,0,65,0,0,0,4099,4241,805,13315,0,0,0,0,0,0,13345,13391,13391,13391,1,1,1,1,'Zircon Earring');
INSERT INTO `synth_recipes` VALUES (2171,0,0,0,0,0,0,70,0,0,0,4099,4241,805,13372,0,0,0,0,0,0,13345,14706,14706,14706,1,1,1,1,'Zircon Earring');
INSERT INTO `synth_recipes` VALUES (2172,0,0,0,0,0,0,65,0,0,0,4099,4241,810,13315,0,0,0,0,0,0,13346,13392,13392,13392,1,1,1,1,'Purple Earring');
INSERT INTO `synth_recipes` VALUES (2173,0,0,0,0,0,0,70,0,0,0,4099,4241,810,13372,0,0,0,0,0,0,13346,14707,14707,14707,1,1,1,1,'Purple Earring');
INSERT INTO `synth_recipes` VALUES (2174,0,0,0,0,0,0,65,0,0,0,4099,4241,791,13315,0,0,0,0,0,0,13347,13393,13393,13393,1,1,1,1,'Aquamrne. Earring');
INSERT INTO `synth_recipes` VALUES (2175,0,0,0,0,0,0,70,0,0,0,4099,4241,791,13372,0,0,0,0,0,0,13347,14708,14708,14708,1,1,1,1,'Aquamrne. Earring');
INSERT INTO `synth_recipes` VALUES (2176,0,0,0,0,0,0,65,0,0,0,4099,4241,801,13315,0,0,0,0,0,0,13348,13394,13394,13394,1,1,1,1,'Yellow Earring');
INSERT INTO `synth_recipes` VALUES (2177,0,0,0,0,0,0,70,0,0,0,4099,4241,801,13372,0,0,0,0,0,0,13348,14709,14709,14709,1,1,1,1,'Yellow Earring');
INSERT INTO `synth_recipes` VALUES (2178,0,0,0,0,0,0,65,0,0,0,4099,4241,797,13315,0,0,0,0,0,0,13349,13395,13395,13395,1,1,1,1,'Night Earring');
INSERT INTO `synth_recipes` VALUES (2179,0,0,0,0,0,0,70,0,0,0,4099,4241,797,13372,0,0,0,0,0,0,13349,14710,14710,14710,1,1,1,1,'Night Earring');
INSERT INTO `synth_recipes` VALUES (2180,0,0,0,0,0,0,65,0,0,0,4099,4241,802,13315,0,0,0,0,0,0,13350,13396,13396,13396,1,1,1,1,'Moon Earring');
INSERT INTO `synth_recipes` VALUES (2181,0,0,0,0,0,0,70,0,0,0,4099,4241,802,13372,0,0,0,0,0,0,13350,14711,14711,14711,1,1,1,1,'Moon Earring');
INSERT INTO `synth_recipes` VALUES (2182,0,0,0,0,0,0,85,0,0,0,4099,4241,785,13316,0,0,0,0,0,0,13351,13407,13407,13407,1,1,1,1,'Emerald Earring');
INSERT INTO `synth_recipes` VALUES (2183,0,0,0,0,0,0,90,0,0,0,4099,4241,785,13397,0,0,0,0,0,0,13351,14712,14712,14712,1,1,1,1,'Emerald Earring');
INSERT INTO `synth_recipes` VALUES (2184,0,0,0,0,0,0,85,0,0,0,4099,4241,786,13316,0,0,0,0,0,0,13352,13408,13408,13408,1,1,1,1,'Ruby Earring');
INSERT INTO `synth_recipes` VALUES (2185,0,0,0,0,0,0,90,0,0,0,4099,4241,786,13397,0,0,0,0,0,0,13352,14713,14713,14713,1,1,1,1,'Ruby Earring');
INSERT INTO `synth_recipes` VALUES (2186,0,0,0,0,0,0,85,0,0,0,4099,4241,787,13316,0,0,0,0,0,0,13353,13409,13409,13409,1,1,1,1,'Diamond Earring');
INSERT INTO `synth_recipes` VALUES (2187,0,0,0,0,0,0,90,0,0,0,4099,4241,787,13397,0,0,0,0,0,0,13353,14714,14714,14714,1,1,1,1,'Diamond Earring');
INSERT INTO `synth_recipes` VALUES (2188,0,0,0,0,0,0,85,0,0,0,4099,4241,804,13316,0,0,0,0,0,0,13354,13410,13410,13410,1,1,1,1,'Spinel Earring');
INSERT INTO `synth_recipes` VALUES (2189,0,0,0,0,0,0,90,0,0,0,4099,4241,804,13397,0,0,0,0,0,0,13354,14715,14715,14715,1,1,1,1,'Spinel Earring');
INSERT INTO `synth_recipes` VALUES (2190,0,0,0,0,0,0,85,0,0,0,4099,4241,794,13316,0,0,0,0,0,0,13355,13411,13411,13411,1,1,1,1,'Sapphire Earring');
INSERT INTO `synth_recipes` VALUES (2191,0,0,0,0,0,0,90,0,0,0,4099,4241,794,13397,0,0,0,0,0,0,13355,14716,14716,14716,1,1,1,1,'Sapphire Earring');
INSERT INTO `synth_recipes` VALUES (2192,0,0,0,0,0,0,85,0,0,0,4099,4241,812,13316,0,0,0,0,0,0,13356,13413,13413,13413,1,1,1,1,'Death Earring');
INSERT INTO `synth_recipes` VALUES (2193,0,0,0,0,0,0,90,0,0,0,4099,4241,812,13397,0,0,0,0,0,0,13356,14718,14718,14718,1,1,1,1,'Death Earring');
INSERT INTO `synth_recipes` VALUES (2194,0,0,0,0,0,0,85,0,0,0,4099,4241,813,13316,0,0,0,0,0,0,13357,13414,13414,13414,1,1,1,1,'Angels Earring');
INSERT INTO `synth_recipes` VALUES (2195,0,0,0,0,0,0,90,0,0,0,4099,4241,813,13397,0,0,0,0,0,0,13357,14719,14719,14719,1,1,1,1,'Angels Earring');
INSERT INTO `synth_recipes` VALUES (2196,0,0,0,85,0,0,0,0,0,0,4099,4241,888,13404,0,0,0,0,0,0,13417,13418,13418,13418,1,1,1,1,'Eris Earring');
INSERT INTO `synth_recipes` VALUES (2197,0,0,0,17,0,0,0,0,0,0,4098,4240,880,882,0,0,0,0,0,0,13441,13500,13500,13500,1,1,1,1,'Bone Ring');
INSERT INTO `synth_recipes` VALUES (2198,0,0,0,7,0,0,0,0,0,0,4098,4240,864,888,0,0,0,0,0,0,13442,13494,13494,13494,1,1,1,1,'Shell Ring');
INSERT INTO `synth_recipes` VALUES (2199,0,0,0,0,0,0,35,0,0,0,4099,4241,796,13456,0,0,0,0,0,0,13443,13528,13528,13528,1,1,1,1,'Opal Ring');
INSERT INTO `synth_recipes` VALUES (2200,0,0,0,0,0,0,40,0,0,0,4099,4241,796,13518,0,0,0,0,0,0,13443,14599,14599,14599,1,1,1,1,'Opal Ring');
INSERT INTO `synth_recipes` VALUES (2201,0,0,0,0,0,0,35,0,0,0,4099,4241,807,13456,0,0,0,0,0,0,13444,13522,13522,13522,1,1,1,1,'Sardonyx Ring');
INSERT INTO `synth_recipes` VALUES (2202,0,0,0,0,0,0,40,0,0,0,4099,4241,807,13518,0,0,0,0,0,0,13444,14593,14593,14593,1,1,1,1,'Sardonyx Ring');
INSERT INTO `synth_recipes` VALUES (2203,0,0,0,0,0,0,60,0,0,0,4096,4238,745,745,0,0,0,0,0,0,13445,13520,13520,13520,1,1,1,1,'Gold Ring');
INSERT INTO `synth_recipes` VALUES (2204,0,0,0,0,0,0,47,0,0,0,4096,4238,653,653,0,0,0,0,0,0,13446,13519,13519,13519,1,1,1,1,'Mythril Ring');
INSERT INTO `synth_recipes` VALUES (2205,0,0,0,0,0,0,70,0,0,0,4096,4238,746,746,0,0,0,0,0,0,13447,13498,13498,13498,1,1,1,1,'Platinum Ring');
INSERT INTO `synth_recipes` VALUES (2206,0,0,0,0,0,0,95,0,0,0,4099,4241,785,13447,0,0,0,0,0,0,13448,13304,13304,13304,1,1,1,1,'Emerald Ring');
INSERT INTO `synth_recipes` VALUES (2207,0,0,0,0,0,0,99,0,0,0,4099,4241,785,13498,0,0,0,0,0,0,13448,14617,14617,14617,1,1,1,1,'Emerald Ring');
INSERT INTO `synth_recipes` VALUES (2208,0,0,0,0,0,0,95,0,0,0,4099,4241,786,13447,0,0,0,0,0,0,13449,13305,13305,13305,1,1,1,1,'Ruby Ring');
INSERT INTO `synth_recipes` VALUES (2209,0,0,0,0,0,0,99,0,0,0,4099,4241,786,13498,0,0,0,0,0,0,13449,14618,14618,14618,1,1,1,1,'Ruby Ring');
INSERT INTO `synth_recipes` VALUES (2210,0,0,0,0,0,0,95,0,0,0,4099,4241,787,13447,0,0,0,0,0,0,13450,13306,13306,13306,1,1,1,1,'Diamond Ring');
INSERT INTO `synth_recipes` VALUES (2211,0,0,0,0,0,0,99,0,0,0,4099,4241,787,13498,0,0,0,0,0,0,13450,14619,14619,14619,1,1,1,1,'Diamond Ring');
INSERT INTO `synth_recipes` VALUES (2212,0,0,0,0,0,0,95,0,0,0,4099,4241,804,13447,0,0,0,0,0,0,13451,13307,13307,13307,1,1,1,1,'Spinel Ring');
INSERT INTO `synth_recipes` VALUES (2213,0,0,0,0,0,0,99,0,0,0,4099,4241,804,13498,0,0,0,0,0,0,13451,14620,14620,14620,1,1,1,1,'Spinel Ring');
INSERT INTO `synth_recipes` VALUES (2214,0,0,0,0,0,0,95,0,0,0,4099,4241,794,13447,0,0,0,0,0,0,13452,13308,13308,13308,1,1,1,1,'Sapphire Ring');
INSERT INTO `synth_recipes` VALUES (2215,0,0,0,0,0,0,99,0,0,0,4099,4241,794,13498,0,0,0,0,0,0,13452,14621,14621,14621,1,1,1,1,'Sapphire Ring');
INSERT INTO `synth_recipes` VALUES (2216,0,0,0,0,0,0,95,0,0,0,4099,4241,789,13447,0,0,0,0,0,0,13453,13309,13309,13309,1,1,1,1,'Topaz Ring');
INSERT INTO `synth_recipes` VALUES (2217,0,0,0,0,0,0,99,0,0,0,4099,4241,789,13498,0,0,0,0,0,0,13453,14622,14622,14622,1,1,1,1,'Topaz Ring');
INSERT INTO `synth_recipes` VALUES (2218,0,0,0,0,0,0,5,0,0,0,4096,4238,648,648,0,0,0,0,0,0,13454,13492,13492,13492,1,1,1,1,'Copper Ring');
INSERT INTO `synth_recipes` VALUES (2219,0,0,0,80,0,0,0,0,0,0,4098,4240,887,887,0,0,0,0,0,0,13455,13504,13504,13504,1,1,1,1,'Coral Ring');
INSERT INTO `synth_recipes` VALUES (2220,0,0,0,0,0,0,32,0,0,0,4096,4238,744,744,0,0,0,0,0,0,13456,13518,13518,13518,1,1,1,1,'Silver Ring');
INSERT INTO `synth_recipes` VALUES (2221,0,0,0,25,0,0,0,0,0,0,4098,4240,894,0,0,0,0,0,0,0,13457,13501,13501,13501,1,1,1,1,'Beetle Ring');
INSERT INTO `synth_recipes` VALUES (2222,0,0,0,60,0,0,0,0,0,0,4098,4240,896,0,0,0,0,0,0,0,13458,13513,13513,13513,1,1,1,1,'Scorpion Ring');
INSERT INTO `synth_recipes` VALUES (2223,0,0,0,37,0,0,0,0,0,0,4098,4240,864,895,0,0,0,0,0,0,13459,13502,13502,13502,1,1,1,1,'Horn Ring');
INSERT INTO `synth_recipes` VALUES (2224,0,0,0,89,0,0,0,0,0,0,4098,4240,883,883,0,0,0,0,0,0,13460,13556,13556,13556,1,1,1,1,'Behemoth Ring');
INSERT INTO `synth_recipes` VALUES (2225,0,0,0,42,0,0,11,0,0,0,4098,4240,653,881,0,0,0,0,0,0,13461,13503,13503,13503,1,1,1,1,'Carapace Ring');
INSERT INTO `synth_recipes` VALUES (2226,0,0,0,0,0,0,95,0,0,0,4099,4241,812,13447,0,0,0,0,0,0,13462,13310,13310,13310,1,1,1,1,'Death Ring');
INSERT INTO `synth_recipes` VALUES (2227,0,0,0,0,0,0,99,0,0,0,4099,4241,812,13498,0,0,0,0,0,0,13462,14623,14623,14623,1,1,1,1,'Death Ring');
INSERT INTO `synth_recipes` VALUES (2228,0,0,0,0,0,0,95,0,0,0,4099,4241,813,13447,0,0,0,0,0,0,13463,13311,13311,13311,1,1,1,1,'Angels Ring');
INSERT INTO `synth_recipes` VALUES (2229,0,0,0,0,0,0,99,0,0,0,4099,4241,813,13498,0,0,0,0,0,0,13463,14624,14624,14624,1,1,1,1,'Angels Ring');
INSERT INTO `synth_recipes` VALUES (2230,0,0,0,70,0,0,0,0,0,0,4098,4240,864,902,0,0,0,0,0,0,13464,13545,13545,13545,1,1,1,1,'Demons Ring');
INSERT INTO `synth_recipes` VALUES (2231,0,0,0,0,0,0,15,0,0,0,4096,4238,650,650,0,0,0,0,0,0,13465,13493,13493,13493,1,1,1,1,'Brass Ring');
INSERT INTO `synth_recipes` VALUES (2232,0,0,0,0,0,0,93,0,0,0,4096,4238,747,747,0,0,0,0,0,0,13466,14616,14616,14616,1,1,1,1,'Orichalcum Ring');
INSERT INTO `synth_recipes` VALUES (2233,0,0,0,99,0,0,0,0,0,0,4098,4240,903,903,0,0,0,0,0,0,13467,14627,14627,14627,1,1,1,1,'Dragon Ring');
INSERT INTO `synth_recipes` VALUES (2234,0,0,0,0,0,0,35,0,0,0,4099,4241,806,13456,0,0,0,0,0,0,13468,13521,13521,13521,1,1,1,1,'Tourmaline Ring');
INSERT INTO `synth_recipes` VALUES (2235,0,0,0,0,0,0,40,0,0,0,4099,4241,806,13518,0,0,0,0,0,0,13468,14592,14592,14592,1,1,1,1,'Tourmaline Ring');
INSERT INTO `synth_recipes` VALUES (2236,0,0,0,0,0,0,0,22,0,0,4098,4240,848,0,0,0,0,0,0,0,13469,13499,13499,13499,1,1,1,1,'Leather Ring');
INSERT INTO `synth_recipes` VALUES (2237,0,0,0,0,0,0,35,0,0,0,4099,4241,809,13456,0,0,0,0,0,0,13470,13523,13523,13523,1,1,1,1,'Clear Ring');
INSERT INTO `synth_recipes` VALUES (2238,0,0,0,0,0,0,40,0,0,0,4099,4241,809,13518,0,0,0,0,0,0,13470,14594,14594,14594,1,1,1,1,'Clear Ring');
INSERT INTO `synth_recipes` VALUES (2239,0,0,0,0,0,0,35,0,0,0,4099,4241,800,13456,0,0,0,0,0,0,13471,13524,13524,13524,1,1,1,1,'Amethyst Ring');
INSERT INTO `synth_recipes` VALUES (2240,0,0,0,0,0,0,40,0,0,0,4099,4241,800,13518,0,0,0,0,0,0,13471,14595,14595,14595,1,1,1,1,'Amethyst Ring');
INSERT INTO `synth_recipes` VALUES (2241,0,0,0,0,0,0,35,0,0,0,4099,4241,795,13456,0,0,0,0,0,0,13472,13525,13525,13525,1,1,1,1,'Lapis Lazuli Ring');
INSERT INTO `synth_recipes` VALUES (2242,0,0,0,0,0,0,40,0,0,0,4099,4241,795,13518,0,0,0,0,0,0,13472,14596,14596,14596,1,1,1,1,'Lapis Lazuli Ring');
INSERT INTO `synth_recipes` VALUES (2243,0,0,0,0,0,0,35,0,0,0,4099,4241,814,13456,0,0,0,0,0,0,13473,13526,13526,13526,1,1,1,1,'Amber Ring');
INSERT INTO `synth_recipes` VALUES (2244,0,0,0,0,0,0,40,0,0,0,4099,4241,814,13518,0,0,0,0,0,0,13473,14597,14597,14597,1,1,1,1,'Amber Ring');
INSERT INTO `synth_recipes` VALUES (2245,0,0,0,0,0,0,35,0,0,0,4099,4241,799,13456,0,0,0,0,0,0,13474,13527,13527,13527,1,1,1,1,'Onyx Ring');
INSERT INTO `synth_recipes` VALUES (2246,0,0,0,0,0,0,40,0,0,0,4099,4241,799,13518,0,0,0,0,0,0,13474,14598,14598,14598,1,1,1,1,'Onyx Ring');
INSERT INTO `synth_recipes` VALUES (2247,0,0,0,0,0,0,55,0,0,0,4099,4241,788,13446,0,0,0,0,0,0,13476,13529,13529,13529,1,1,1,1,'Peridot Ring');
INSERT INTO `synth_recipes` VALUES (2248,0,0,0,0,0,0,60,0,0,0,4099,4241,788,13519,0,0,0,0,0,0,13476,14600,14600,14600,1,1,1,1,'Peridot Ring');
INSERT INTO `synth_recipes` VALUES (2249,0,0,0,0,0,0,55,0,0,0,4099,4241,790,13446,0,0,0,0,0,0,13477,13530,13530,13530,1,1,1,1,'Garnet Ring');
INSERT INTO `synth_recipes` VALUES (2250,0,0,0,0,0,0,60,0,0,0,4099,4241,790,13519,0,0,0,0,0,0,13477,14601,14601,14601,1,1,1,1,'Garnet Ring');
INSERT INTO `synth_recipes` VALUES (2251,0,0,0,0,0,0,55,0,0,0,4099,4241,808,13446,0,0,0,0,0,0,13478,13531,13531,13531,1,1,1,1,'Goshenite Ring');
INSERT INTO `synth_recipes` VALUES (2252,0,0,0,0,0,0,60,0,0,0,4099,4241,808,13519,0,0,0,0,0,0,13478,14602,14602,14602,1,1,1,1,'Goshenite Ring');
INSERT INTO `synth_recipes` VALUES (2253,0,0,0,0,0,0,55,0,0,0,4099,4241,811,13446,0,0,0,0,0,0,13479,13532,13532,13532,1,1,1,1,'Ametrine Ring');
INSERT INTO `synth_recipes` VALUES (2254,0,0,0,0,0,0,60,0,0,0,4099,4241,811,13519,0,0,0,0,0,0,13479,14603,14603,14603,1,1,1,1,'Ametrine Ring');
INSERT INTO `synth_recipes` VALUES (2255,0,0,0,0,0,0,55,0,0,0,4099,4241,798,13446,0,0,0,0,0,0,13480,13533,13533,13533,1,1,1,1,'Turquoise Ring');
INSERT INTO `synth_recipes` VALUES (2256,0,0,0,0,0,0,60,0,0,0,4099,4241,798,13519,0,0,0,0,0,0,13480,14604,14604,14604,1,1,1,1,'Turquoise Ring');
INSERT INTO `synth_recipes` VALUES (2257,0,0,0,0,0,0,55,0,0,0,4099,4241,815,13446,0,0,0,0,0,0,13481,13534,13534,13534,1,1,1,1,'Sphene Ring');
INSERT INTO `synth_recipes` VALUES (2258,0,0,0,0,0,0,60,0,0,0,4099,4241,815,13519,0,0,0,0,0,0,13481,14605,14605,14605,1,1,1,1,'Sphene Ring');
INSERT INTO `synth_recipes` VALUES (2259,0,0,0,0,0,0,55,0,0,0,4099,4241,793,13446,0,0,0,0,0,0,13482,13535,13535,13535,1,1,1,1,'Black Ring');
INSERT INTO `synth_recipes` VALUES (2260,0,0,0,0,0,0,60,0,0,0,4099,4241,793,13519,0,0,0,0,0,0,13482,14606,14606,14606,1,1,1,1,'Black Ring');
INSERT INTO `synth_recipes` VALUES (2261,0,0,0,0,0,0,55,0,0,0,4099,4241,792,13446,0,0,0,0,0,0,13483,13536,13536,13536,1,1,1,1,'Pearl Ring');
INSERT INTO `synth_recipes` VALUES (2262,0,0,0,0,0,0,60,0,0,0,4099,4241,792,13519,0,0,0,0,0,0,13483,14607,14607,14607,1,1,1,1,'Pearl Ring');
INSERT INTO `synth_recipes` VALUES (2263,0,0,0,0,0,0,75,0,0,0,4099,4241,784,13445,0,0,0,0,0,0,13484,13537,13537,13537,1,1,1,1,'Jadeite Ring');
INSERT INTO `synth_recipes` VALUES (2264,0,0,0,0,0,0,80,0,0,0,4099,4241,784,13520,0,0,0,0,0,0,13484,14608,14608,14608,1,1,1,1,'Jadeite Ring');
INSERT INTO `synth_recipes` VALUES (2265,0,0,0,0,0,0,75,0,0,0,4099,4241,803,13445,0,0,0,0,0,0,13485,13538,13538,13538,1,1,1,1,'Sun Ring');
INSERT INTO `synth_recipes` VALUES (2266,0,0,0,0,0,0,80,0,0,0,4099,4241,803,13520,0,0,0,0,0,0,13485,14609,14609,14609,1,1,1,1,'Sun Ring');
INSERT INTO `synth_recipes` VALUES (2267,0,0,0,0,0,0,75,0,0,0,4099,4241,805,13445,0,0,0,0,0,0,13486,13539,13539,13539,1,1,1,1,'Zircon Ring');
INSERT INTO `synth_recipes` VALUES (2268,0,0,0,0,0,0,80,0,0,0,4099,4241,805,13520,0,0,0,0,0,0,13486,14610,14610,14610,1,1,1,1,'Zircon Ring');
INSERT INTO `synth_recipes` VALUES (2269,0,0,0,0,0,0,75,0,0,0,4099,4241,810,13445,0,0,0,0,0,0,13487,13540,13540,13540,1,1,1,1,'Fluorite Ring');
INSERT INTO `synth_recipes` VALUES (2270,0,0,0,0,0,0,80,0,0,0,4099,4241,810,13520,0,0,0,0,0,0,13487,14611,14611,14611,1,1,1,1,'Fluorite Ring');
INSERT INTO `synth_recipes` VALUES (2271,0,0,0,0,0,0,75,0,0,0,4099,4241,791,13445,0,0,0,0,0,0,13488,13541,13541,13541,1,1,1,1,'Aquamarine Ring');
INSERT INTO `synth_recipes` VALUES (2272,0,0,0,0,0,0,80,0,0,0,4099,4241,791,13520,0,0,0,0,0,0,13488,14612,14612,14612,1,1,1,1,'Aquamarine Ring');
INSERT INTO `synth_recipes` VALUES (2273,0,0,0,0,0,0,75,0,0,0,4099,4241,801,13445,0,0,0,0,0,0,13489,13542,13542,13542,1,1,1,1,'Chrysoberyl Ring');
INSERT INTO `synth_recipes` VALUES (2274,0,0,0,0,0,0,80,0,0,0,4099,4241,801,13520,0,0,0,0,0,0,13489,14613,14613,14613,1,1,1,1,'Chrysoberyl Ring');
INSERT INTO `synth_recipes` VALUES (2275,0,0,0,0,0,0,75,0,0,0,4099,4241,797,13445,0,0,0,0,0,0,13490,13543,13543,13543,1,1,1,1,'Painite Ring');
INSERT INTO `synth_recipes` VALUES (2276,0,0,0,0,0,0,80,0,0,0,4099,4241,797,13520,0,0,0,0,0,0,13490,14614,14614,14614,1,1,1,1,'Painite Ring');
INSERT INTO `synth_recipes` VALUES (2277,0,0,0,0,0,0,75,0,0,0,4099,4241,802,13445,0,0,0,0,0,0,13491,13544,13544,13544,1,1,1,1,'Moon Ring');
INSERT INTO `synth_recipes` VALUES (2278,0,0,0,0,0,0,80,0,0,0,4099,4241,802,13520,0,0,0,0,0,0,13491,14615,14615,14615,1,1,1,1,'Moon Ring');
INSERT INTO `synth_recipes` VALUES (2279,0,0,0,0,0,0,0,62,0,0,4098,4240,855,0,0,0,0,0,0,0,13546,13547,13547,13547,1,1,1,1,'Hard Leather Ring');
INSERT INTO `synth_recipes` VALUES (2280,0,0,0,0,52,0,0,0,0,0,4098,4240,828,0,0,0,0,0,0,0,13568,13833,13833,13833,1,1,1,1,'Scarlet Ribbon');
INSERT INTO `synth_recipes` VALUES (2281,0,0,0,0,0,0,0,49,0,0,4097,4239,820,859,0,0,0,0,0,0,13570,13575,13575,13575,1,1,1,1,'Ram Mantle');
INSERT INTO `synth_recipes` VALUES (2282,0,0,0,0,0,0,0,33,0,0,4097,4239,820,858,0,0,0,0,0,0,13571,13609,13609,13609,1,1,1,1,'Wolf Mantle');
INSERT INTO `synth_recipes` VALUES (2283,0,0,0,0,54,0,0,0,0,0,4099,4241,822,828,828,0,0,0,0,0,13577,13610,13610,13610,1,1,1,1,'Black Cape');
INSERT INTO `synth_recipes` VALUES (2284,0,0,0,0,81,0,0,0,0,0,4099,4241,816,829,829,1110,0,0,0,0,13578,13626,13626,13626,1,1,1,1,'Blue Cape');
INSERT INTO `synth_recipes` VALUES (2285,0,0,0,0,74,0,0,20,0,0,4099,4241,816,829,829,850,850,0,0,0,13579,13620,13620,13620,1,1,1,1,'Jesters Cape');
INSERT INTO `synth_recipes` VALUES (2286,0,0,0,0,8,0,0,0,0,0,4099,4241,817,824,824,0,0,0,0,0,13583,13605,13605,13605,1,1,1,1,'Cape');
INSERT INTO `synth_recipes` VALUES (2287,0,0,0,0,18,0,0,0,0,0,4099,4241,818,825,825,0,0,0,0,0,13584,13601,13601,13601,1,1,1,1,'Cotton Cape');
INSERT INTO `synth_recipes` VALUES (2288,0,0,0,0,64,0,0,0,0,0,4099,4241,820,829,829,0,0,0,0,0,13585,13618,13618,13618,1,1,1,1,'White Cape');
INSERT INTO `synth_recipes` VALUES (2289,0,0,0,0,59,0,0,0,0,0,4099,4241,823,828,828,0,0,0,0,0,13586,13611,13611,13611,1,1,1,1,'Red Cape');
INSERT INTO `synth_recipes` VALUES (2290,0,0,0,0,94,0,0,0,0,0,4099,4241,816,830,830,0,0,0,0,0,13587,13627,13627,13627,1,1,1,1,'Rainbow Cape');
INSERT INTO `synth_recipes` VALUES (2291,0,0,0,0,0,0,0,27,0,0,4097,4239,820,857,0,0,0,0,0,0,13588,13600,13600,13600,1,1,1,1,'Dhalmel Mantle');
INSERT INTO `synth_recipes` VALUES (2292,0,0,0,0,0,0,0,75,0,0,4097,4239,820,861,0,0,0,0,0,0,13589,13602,13602,13602,1,1,1,1,'Tiger Mantle');
INSERT INTO `synth_recipes` VALUES (2293,0,0,0,0,62,0,0,0,0,0,4098,4240,829,0,0,0,0,0,0,0,13590,13854,13854,13854,1,1,1,1,'Green Ribbon');
INSERT INTO `synth_recipes` VALUES (2294,0,0,0,0,0,0,0,70,0,0,4097,4239,820,860,0,0,0,0,0,0,13591,13604,13604,13604,1,1,1,1,'Behemoth Mantle');
INSERT INTO `synth_recipes` VALUES (2295,0,0,0,0,0,0,0,14,0,0,4099,4241,817,852,869,0,0,0,0,0,13592,13608,13608,13608,1,1,1,1,'Lizard Mantle');
INSERT INTO `synth_recipes` VALUES (2296,0,0,0,0,0,0,0,53,0,0,4099,4241,817,853,853,0,0,0,0,0,13593,13612,13612,13612,1,1,1,1,'Raptor Mantle');
INSERT INTO `synth_recipes` VALUES (2297,0,0,0,0,0,0,0,7,0,0,4099,4241,817,856,856,856,856,856,0,0,13594,13599,13599,13599,1,1,1,1,'Rabbit Mantle');
INSERT INTO `synth_recipes` VALUES (2298,0,0,0,0,0,0,0,85,0,0,4097,4239,820,863,0,0,0,0,0,0,13595,13603,13603,13603,1,1,1,1,'Coeurl Mantle');
INSERT INTO `synth_recipes` VALUES (2299,0,0,0,0,0,0,0,63,0,0,4099,4241,817,854,854,0,0,0,0,0,13597,13621,13621,13621,1,1,1,1,'Beak Mantle');
INSERT INTO `synth_recipes` VALUES (2300,0,0,0,0,87,0,0,0,0,0,4099,4241,819,829,13622,0,0,0,0,0,13629,13630,13630,13630,1,1,1,1,'Peace Cape');
INSERT INTO `synth_recipes` VALUES (2301,0,0,0,0,0,0,0,82,0,0,4099,4241,856,13613,0,0,0,0,0,0,13631,13632,13632,13632,1,1,1,1,'Nomads Mantle');
INSERT INTO `synth_recipes` VALUES (2302,0,0,0,0,0,0,0,84,0,0,4099,4241,852,13624,0,0,0,0,0,0,13633,13634,13634,13634,1,1,1,1,'Empwr. Mantle');
INSERT INTO `synth_recipes` VALUES (2303,0,0,0,0,0,0,0,86,0,0,4097,4239,858,13615,0,0,0,0,0,0,13635,13636,13636,13636,1,1,1,1,'Cvl. Mantle');
INSERT INTO `synth_recipes` VALUES (2304,0,0,0,0,0,0,0,87,0,0,4099,4241,854,13623,0,0,0,0,0,0,13637,13638,13638,13638,1,1,1,1,'Gaia Mantle');
INSERT INTO `synth_recipes` VALUES (2305,0,0,0,0,0,0,0,88,0,0,4097,4239,861,13625,0,0,0,0,0,0,13639,13640,13640,13640,1,1,1,1,'Aurora Mantle');
INSERT INTO `synth_recipes` VALUES (2306,0,0,0,0,0,0,0,78,0,0,4099,4241,820,855,13589,0,0,0,0,0,13641,13642,13642,13642,1,1,1,1,'Black Mantle');
INSERT INTO `synth_recipes` VALUES (2307,0,0,0,0,66,0,0,0,0,0,4099,4241,820,1280,1280,0,0,0,0,0,13643,13644,13644,13644,1,1,1,1,'Sarcenet Cape');
INSERT INTO `synth_recipes` VALUES (2308,0,0,0,0,0,0,0,60,0,0,4099,4241,817,869,1275,0,0,0,0,0,13645,13646,13646,13646,1,1,1,1,'Amemet Mantle');
INSERT INTO `synth_recipes` VALUES (2309,0,0,0,0,87,0,0,0,0,0,4099,4241,820,1279,1279,0,0,0,0,0,13649,13650,13650,13650,1,1,1,1,'Taffeta Cape');
INSERT INTO `synth_recipes` VALUES (2310,0,0,0,0,74,0,0,0,0,0,4099,4241,820,1281,1281,0,0,0,0,0,13651,13652,13652,13652,1,1,1,1,'Cheviot Cape');
INSERT INTO `synth_recipes` VALUES (2311,0,0,0,0,0,0,0,92,0,0,4099,4241,817,1296,1296,0,0,0,0,0,13653,13654,13654,13654,1,1,1,1,'Desert Mantle');
INSERT INTO `synth_recipes` VALUES (2312,0,0,0,0,101,0,0,0,0,0,4099,4241,821,1132,13629,0,0,0,0,0,13656,13657,13657,13657,1,1,1,1,'Errant Cape'); -- errant cape (cloth 101) https://www.bg-wiki.com/bg/Errant_Cape
INSERT INTO `synth_recipes` VALUES (2313,0,0,54,0,0,0,0,34,0,0,4099,4241,850,1656,4128,4128,4128,4128,0,0,13682,13682,13682,13682,1,1,1,1,'Ether Tank');
INSERT INTO `synth_recipes` VALUES (2314,0,0,6,0,0,0,0,1,0,0,4099,4241,850,1656,4109,0,0,0,0,0,13683,13683,13683,13683,1,1,1,1,'Water Tank');
INSERT INTO `synth_recipes` VALUES (2315,0,0,6,0,0,0,0,1,0,0,4099,4241,879,1656,4109,0,0,0,0,0,13683,13683,13683,13683,1,1,1,1,'Water Tank');
INSERT INTO `synth_recipes` VALUES (2316,0,0,44,0,0,0,0,1,0,0,4099,4241,850,1656,4112,4112,4112,4112,0,0,13684,13684,13684,13684,1,1,1,1,'Potion Tank');
INSERT INTO `synth_recipes` VALUES (2317,0,0,0,0,0,0,0,36,0,0,4097,4239,871,13571,0,0,0,0,0,0,13685,13685,13685,13685,1,1,1,1,'Invisible Mantle');
INSERT INTO `synth_recipes` VALUES (2318,0,0,0,0,0,0,0,67,28,0,4099,4241,662,850,854,854,0,0,0,0,13698,13701,13701,13701,1,1,1,1,'Beak Helm');
INSERT INTO `synth_recipes` VALUES (2319,0,0,0,0,0,0,0,69,0,0,4099,4241,850,854,854,0,0,0,0,0,13699,13739,13739,13739,1,1,1,1,'Beak Jerkin');
INSERT INTO `synth_recipes` VALUES (2320,0,0,0,0,0,0,0,68,0,0,4099,4241,854,12699,0,0,0,0,0,0,13700,13960,13960,13960,1,1,1,1,'Beak Gloves');
INSERT INTO `synth_recipes` VALUES (2321,0,0,0,0,0,0,28,65,0,0,4099,4241,663,854,12955,0,0,0,0,0,13702,14088,14088,14088,1,1,1,1,'Beak Ledelsens');
INSERT INTO `synth_recipes` VALUES (2322,0,0,0,0,48,0,50,57,0,0,4099,4241,663,673,752,828,828,851,12569,0,13703,13710,13710,13710,1,1,1,1,'Brigandine');
INSERT INTO `synth_recipes` VALUES (2323,0,0,0,0,38,0,0,59,50,0,4099,4241,664,664,680,820,826,828,850,855,13703,13710,13710,13710,1,1,1,1,'Brigandine');
INSERT INTO `synth_recipes` VALUES (2324,0,0,0,0,0,0,0,88,0,0,4099,4241,1117,12447,0,0,0,0,0,0,13704,13907,13907,13907,1,1,1,1,'Ogre Mask');
INSERT INTO `synth_recipes` VALUES (2325,0,0,0,0,0,0,0,90,0,0,4099,4241,849,1117,12575,0,0,0,0,0,13705,14366,14366,14366,1,1,1,1,'Ogre Jerkin');
INSERT INTO `synth_recipes` VALUES (2326,0,0,0,0,0,0,0,89,0,0,4099,4241,1117,12703,0,0,0,0,0,0,13706,14057,14057,14057,1,1,1,1,'Ogre Gloves');
INSERT INTO `synth_recipes` VALUES (2327,0,0,0,0,0,0,0,85,0,0,4099,4241,1117,12959,0,0,0,0,0,0,13708,14159,14159,14159,1,1,1,1,'Ogre Ledelsens');
INSERT INTO `synth_recipes` VALUES (2328,0,0,0,45,0,0,0,0,0,0,4099,4241,848,881,0,0,0,0,0,0,13711,13829,13829,13829,1,1,1,1,'Carapace Mask');
INSERT INTO `synth_recipes` VALUES (2329,0,0,0,50,0,0,0,13,0,0,4099,4241,848,848,881,881,0,0,0,0,13712,13714,13714,13714,1,1,1,1,'Carapace Harness');
INSERT INTO `synth_recipes` VALUES (2330,0,0,0,44,0,0,0,11,0,0,4099,4241,848,864,881,0,0,0,0,0,13713,12790,12790,12790,1,1,1,1,'Carapace Mittens');
INSERT INTO `synth_recipes` VALUES (2331,0,0,0,46,0,0,0,12,0,0,4099,4241,848,848,864,881,0,0,0,0,13715,13044,13044,13044,1,1,1,1,'Cpc. Leggings');
INSERT INTO `synth_recipes` VALUES (2332,0,0,0,0,0,0,0,69,34,0,4099,4241,664,848,851,855,862,12553,0,0,13740,13741,13741,13741,1,1,1,1,'Byrnie');
INSERT INTO `synth_recipes` VALUES (2333,0,0,28,0,65,0,24,0,0,0,4099,4241,746,823,823,828,829,834,834,1110,13742,13743,13743,13743,1,1,1,1,'Aketon');
INSERT INTO `synth_recipes` VALUES (2334,0,0,0,56,26,0,0,0,0,0,4099,4241,823,889,897,897,12602,0,0,0,13744,13745,13745,13745,1,1,1,1,'Justaucorps');
INSERT INTO `synth_recipes` VALUES (2335,0,0,0,0,70,0,0,0,0,0,4099,4241,823,823,828,828,829,836,836,836,13748,13749,13749,13749,1,1,1,1,'Vermillion Cloak');
INSERT INTO `synth_recipes` VALUES (2336,0,0,0,0,58,0,0,0,0,0,4099,4241,819,826,826,826,826,834,834,834,13750,13751,13751,13751,1,1,1,1,'Linen Doublet');
INSERT INTO `synth_recipes` VALUES (2337,0,0,0,0,67,0,0,0,0,0,4099,4241,820,827,827,827,827,834,834,834,13752,13753,13753,13753,1,1,1,1,'Wool Doublet');
INSERT INTO `synth_recipes` VALUES (2338,0,0,46,0,32,0,0,70,0,0,4099,4241,837,851,855,918,924,929,12603,13699,13754,13755,13755,13755,1,1,1,1,'Black Cotehardie'); -- black cotehardie (leather 70, alch 46, cloth 32)
INSERT INTO `synth_recipes` VALUES (2339,0,0,0,0,0,0,89,0,0,0,4096,4238,745,745,746,752,752,752,914,12547,13757,13758,13758,13758,1,1,1,1,'Lords Cuirass');
INSERT INTO `synth_recipes` VALUES (2340,0,0,0,90,0,0,0,59,0,0,4099,4241,862,862,886,886,0,0,0,0,13767,13768,13768,13768,1,1,1,1,'Demons Harness');
INSERT INTO `synth_recipes` VALUES (2341,0,0,59,0,88,0,21,0,0,0,4099,4241,746,823,823,829,834,834,1133,0,13772,13773,13773,13773,1,1,1,1,'Bloody Aketon');
INSERT INTO `synth_recipes` VALUES (2342,0,0,46,0,32,0,0,80,0,0,4099,4241,837,851,855,918,924,1110,12603,13699,13775,13776,13776,13776,1,1,1,1,'Blue Cotehardie'); -- blue cotehardie (leather 80, alch 46, cloth 32)
INSERT INTO `synth_recipes` VALUES (2343,0,0,0,0,89,0,0,0,0,0,4099,4241,822,823,829,829,830,1132,1132,1132,13779,13780,13780,13780,1,1,1,1,'Black Cloak');
INSERT INTO `synth_recipes` VALUES (2344,0,0,0,0,0,0,0,0,37,0,4099,4241,674,674,674,674,818,850,12568,0,13783,13784,13784,13784,1,1,1,1,'Iron Scale Mail');
INSERT INTO `synth_recipes` VALUES (2345,0,0,0,0,0,0,0,0,57,0,4099,4241,676,676,676,676,818,850,12568,0,13785,13786,13786,13786,1,1,1,1,'Steel Scale Mail');
INSERT INTO `synth_recipes` VALUES (2346,0,0,0,95,0,0,0,0,0,0,4099,4241,850,851,851,1193,1193,1193,1193,0,13789,13790,13790,13790,1,1,1,1,'Cpc. Breastplate');
INSERT INTO `synth_recipes` VALUES (2347,0,0,0,0,89,0,0,0,21,0,4099,4241,666,666,821,828,829,830,0,0,13795,13802,13802,13802,1,1,1,1,'Arhats Gi');
INSERT INTO `synth_recipes` VALUES (2348,0,0,0,0,90,0,0,0,0,0,4099,4241,818,826,13729,0,0,0,0,0,13796,13797,13797,13797,1,1,1,1,'Bishops Robe');
INSERT INTO `synth_recipes` VALUES (2349,0,0,0,0,88,0,0,0,0,0,4099,4241,817,825,13732,0,0,0,0,0,13798,13799,13799,13799,1,1,1,1,'Gaia Doublet');
INSERT INTO `synth_recipes` VALUES (2350,0,0,0,0,85,0,0,0,0,0,4099,4241,817,825,13728,0,0,0,0,0,13800,13801,13801,13801,1,1,1,1,'Masters Gi');
INSERT INTO `synth_recipes` VALUES (2351,0,0,0,0,14,0,0,0,0,0,4099,4241,818,824,824,824,825,850,0,0,13806,13807,13807,13807,1,1,1,1,'Vgd. Tunica');
INSERT INTO `synth_recipes` VALUES (2352,0,0,0,0,30,0,0,0,0,0,4099,4241,819,825,825,825,826,850,0,0,13808,13809,13809,13809,1,1,1,1,'Fsh. Tunica');
INSERT INTO `synth_recipes` VALUES (2353,0,0,0,0,27,0,0,45,0,0,4099,4241,820,826,827,850,851,851,0,0,13810,13811,13811,13811,1,1,1,1,'Choc. Jack Coat');
INSERT INTO `synth_recipes` VALUES (2354,0,0,0,0,0,0,36,34,80,0,4099,4241,664,667,667,667,744,850,851,851,13812,13813,13813,13813,1,1,1,1,'Holy Breastplate');
INSERT INTO `synth_recipes` VALUES (2355,0,0,0,0,31,0,0,100,0,0,4099,4241,821,827,830,849,851,1276,1296,12603,13814,13815,13815,13815,1,1,1,1,'Austere Robe');
INSERT INTO `synth_recipes` VALUES (2356,0,0,0,0,0,0,0,99,0,0,4101,4243,913,1117,1297,14372,0,0,0,0,13816,13817,13817,13817,1,1,1,1,'Narasimhas Vest');
INSERT INTO `synth_recipes` VALUES (2357,0,0,0,0,0,0,92,0,0,0,4096,4238,1879,13757,0,0,0,0,0,0,13823,13823,13823,13823,1,1,1,1,'Regen Cuirass');
INSERT INTO `synth_recipes` VALUES (2358,0,0,0,97,0,0,0,0,0,0,4099,4241,648,850,851,1473,1473,0,0,0,13846,12461,12461,12461,1,1,1,1,'Scorpion Helm');
INSERT INTO `synth_recipes` VALUES (2359,0,0,0,0,0,0,0,0,29,0,4098,4240,662,674,850,0,0,0,0,0,13871,13872,13872,13872,1,1,1,1,'Iron Visor');
INSERT INTO `synth_recipes` VALUES (2360,0,0,0,0,0,0,0,0,49,0,4098,4240,666,674,850,0,0,0,0,0,13873,13874,13874,13874,1,1,1,1,'Steel Visor');
INSERT INTO `synth_recipes` VALUES (2361,0,0,0,93,0,0,0,0,0,0,4099,4241,648,850,851,1193,1193,0,0,0,13878,13879,13879,13879,1,1,1,1,'Carapace Helm');
INSERT INTO `synth_recipes` VALUES (2362,0,0,0,0,81,0,0,0,48,0,4098,4240,664,682,829,829,0,0,0,0,13881,13886,13886,13886,1,1,1,1,'Arhats Jinpachi'); -- arhat's jinpachi (cloth 81 smith 48) https://www.bg-wiki.com/bg/Arhat%27s_Jinpachi
INSERT INTO `synth_recipes` VALUES (2363,0,0,0,0,89,0,0,0,0,0,4099,4241,820,827,13839,0,0,0,0,0,13882,13883,13883,13883,1,1,1,1,'Corsairs Hat');
INSERT INTO `synth_recipes` VALUES (2364,0,0,0,0,81,0,0,0,0,0,4099,4241,818,826,13838,0,0,0,0,0,13884,13885,13885,13885,1,1,1,1,'Jesters Headband');
INSERT INTO `synth_recipes` VALUES (2365,0,0,0,0,0,0,35,0,96,0,4096,4238,648,664,747,850,1705,0,0,0,13887,13888,13888,13888,1,1,1,1,'Black Sallet');
INSERT INTO `synth_recipes` VALUES (2366,0,0,0,0,0,0,15,0,0,0,4096,4238,650,12509,0,0,0,0,0,0,13889,13890,13890,13890,1,1,1,1,'Bastokan Cap');
INSERT INTO `synth_recipes` VALUES (2367,0,0,0,0,0,0,53,0,0,0,4099,4241,663,12431,0,0,0,0,0,0,13891,13892,13892,13892,1,1,1,1,'San Dorian Helm');
INSERT INTO `synth_recipes` VALUES (2368,0,0,0,0,0,0,77,0,0,0,4096,4238,745,914,12422,0,0,0,0,0,13893,13894,13894,13894,1,1,1,1,'Irn.msk. Armet +1');
INSERT INTO `synth_recipes` VALUES (2369,0,0,0,0,0,0,0,29,0,0,4099,4241,850,12510,0,0,0,0,0,0,13895,13896,13896,13896,1,1,1,1,'San. Bandana');
INSERT INTO `synth_recipes` VALUES (2370,0,0,59,0,0,0,0,0,0,0,4096,4238,931,12438,0,0,0,0,0,0,13897,13898,13898,13898,1,1,1,1,'Bastokan Visor');
INSERT INTO `synth_recipes` VALUES (2371,0,0,0,0,0,0,28,0,0,0,4096,4238,653,13830,0,0,0,0,0,0,13899,13900,13900,13900,1,1,1,1,'Bastokan Circlet');
INSERT INTO `synth_recipes` VALUES (2372,0,0,0,0,16,0,0,0,0,0,4099,4241,817,824,12484,0,0,0,0,0,13901,13902,13902,13902,1,1,1,1,'Win. Hachimaki');
INSERT INTO `synth_recipes` VALUES (2373,0,0,0,0,20,0,0,0,0,0,4099,4241,818,825,12470,0,0,0,0,0,13903,13904,13904,13904,1,1,1,1,'Win. Headgear');
INSERT INTO `synth_recipes` VALUES (2374,0,0,0,0,70,0,0,0,0,0,4099,4241,822,828,12478,0,0,0,0,0,13905,13906,13906,13906,1,1,1,1,'T.m. Hat +1');
INSERT INTO `synth_recipes` VALUES (2375,0,0,0,0,94,0,0,0,0,0,4099,4241,821,13881,0,0,0,0,0,0,13910,13949,13949,13949,1,1,1,1,'Roshi Jinpachi');
INSERT INTO `synth_recipes` VALUES (2376,0,0,0,0,0,0,0,95,0,0,4097,4239,820,851,861,861,1122,0,0,0,13918,13919,13919,13919,1,1,1,1,'Tiger Mask');
INSERT INTO `synth_recipes` VALUES (2377,0,0,0,99,0,0,0,41,0,0,4103,4245,850,855,905,913,0,0,0,0,13920,13921,13921,13921,1,1,1,1,'Wyvern Helm'); -- wyvern helm (bone 99 leather 41) https://www.bg-wiki.com/bg/Wyvern_Helm
INSERT INTO `synth_recipes` VALUES (2378,0,0,0,98,0,0,0,41,0,0,4103,4245,850,855,909,913,0,0,0,0,13920,13921,13921,13921,1,1,1,1,'Wyvern Helm'); -- wyvern helm (bone 98 leather 41) https://www.bg-wiki.com/bg/Wyvern_Helm
INSERT INTO `synth_recipes` VALUES (2379,0,0,0,91,0,0,0,0,0,0,4103,4245,850,886,902,902,0,0,0,0,13922,13923,13923,13923,1,1,1,1,'Demon Helm');
INSERT INTO `synth_recipes` VALUES (2380,0,0,0,0,91,0,0,41,42,0,4098,4240,664,682,855,1132,0,0,0,0,13925,13926,13926,13926,1,1,1,1,'Rst. Jinpachi');
INSERT INTO `synth_recipes` VALUES (2381,0,0,0,0,92,0,21,34,0,0,4099,4241,792,821,828,828,829,851,851,0,13929,13930,13930,13930,1,1,1,1,'Errant Hat');
INSERT INTO `synth_recipes` VALUES (2382,0,0,0,0,44,0,0,0,0,0,4098,4240,829,838,956,1278,0,0,0,0,13931,13932,13932,13932,1,1,1,1,'Lilac Corsage');
INSERT INTO `synth_recipes` VALUES (2383,0,0,0,98,0,0,0,0,0,0,4099,4241,1771,12452,0,0,0,0,0,0,13936,13937,13937,13937,1,1,1,1,'Dragon Cap');
INSERT INTO `synth_recipes` VALUES (2384,0,0,0,0,11,0,0,93,0,0,4099,4241,821,850,851,1296,12475,0,0,0,13939,13940,13940,13940,1,1,1,1,'Austere Hat'); -- austere hat (leather 93 cloth 11) https://www.bg-wiki.com/bg/Austere_Hat
INSERT INTO `synth_recipes` VALUES (2385,0,0,0,0,0,0,0,102,0,0,4097,4239,820,851,1122,1591,1591,0,0,0,13942,13943,13943,13943,1,1,1,1,'Panther Mask'); -- panther mask (leath 102) https://www.bg-wiki.com/bg/Panther_Mask
INSERT INTO `synth_recipes` VALUES (2386,0,0,0,0,95,0,0,0,0,0,4099,4241,844,12469,0,0,0,0,0,0,13950,13951,13951,13951,1,1,1,1,'Elite Beret');
INSERT INTO `synth_recipes` VALUES (2387,0,0,0,0,94,0,0,41,41,0,4099,4241,664,664,682,819,855,1764,0,0,13957,14882,14882,14882,1,1,1,1,'Yasha Tekko');
INSERT INTO `synth_recipes` VALUES (2388,0,0,0,0,0,0,49,0,0,0,4096,4238,744,744,744,0,0,0,0,0,13979,13980,13980,13980,1,1,1,1,'Silver Bangles');
INSERT INTO `synth_recipes` VALUES (2389,0,0,0,54,0,0,0,0,0,0,4098,4240,885,885,893,0,0,0,0,0,13981,13982,13982,13982,1,1,1,1,'Turtle Bangles');
INSERT INTO `synth_recipes` VALUES (2390,0,0,0,0,0,0,70,0,0,0,4096,4238,745,745,745,0,0,0,0,0,13983,13984,13984,13984,1,1,1,1,'Gold Bangles');
INSERT INTO `synth_recipes` VALUES (2391,0,0,0,0,0,0,85,0,0,0,4096,4238,746,746,746,746,0,0,0,0,13985,13986,13986,13986,1,1,1,1,'Platinum Bangles');
INSERT INTO `synth_recipes` VALUES (2392,0,0,0,87,0,0,0,0,0,0,4098,4240,887,887,893,0,0,0,0,0,13987,13988,13988,13988,1,1,1,1,'Coral Bangles');
INSERT INTO `synth_recipes` VALUES (2393,0,0,0,0,0,0,0,0,31,0,4099,4241,674,674,818,12696,0,0,0,0,14001,14002,14002,14002,1,1,1,1,'Iron Fng. Gnt.');
INSERT INTO `synth_recipes` VALUES (2394,0,0,0,0,0,0,0,0,51,0,4099,4241,676,676,818,12696,0,0,0,0,14003,14004,14004,14004,1,1,1,1,'Steel Fng. Gnt.');
INSERT INTO `synth_recipes` VALUES (2395,0,0,0,92,0,0,0,0,0,0,4099,4241,1193,1193,12696,12696,0,0,0,0,14008,14009,14009,14009,1,1,1,1,'Cpc. Gauntlets');
INSERT INTO `synth_recipes` VALUES (2396,0,0,0,0,0,0,0,0,95,0,4096,4238,664,1705,12702,0,0,0,0,0,14010,14011,14011,14011,1,1,1,1,'Black Gadlings');
INSERT INTO `synth_recipes` VALUES (2397,0,0,0,0,86,0,0,0,49,0,4099,4241,664,664,680,819,829,829,0,0,14023,14028,14028,14028,1,1,1,1,'Arhats Tekko'); -- arhat's tekko (cloth 86 smith 49) https://www.bg-wiki.com/bg/Arhat's_Tekko
INSERT INTO `synth_recipes` VALUES (2398,0,0,0,0,84,0,0,0,0,0,4099,4241,819,829,12798,0,0,0,0,0,14024,14025,14025,14025,1,1,1,1,'Devotees Mitts');
INSERT INTO `synth_recipes` VALUES (2399,0,0,0,0,86,0,0,0,0,0,4099,4241,817,825,14005,0,0,0,0,0,14026,14027,14027,14027,1,1,1,1,'Hailstorm Tekko');
INSERT INTO `synth_recipes` VALUES (2400,0,0,0,0,0,0,0,0,69,0,4099,4241,682,12686,0,0,0,0,0,0,14029,14030,14030,14030,1,1,1,1,'R.k. Mufflers +1');
INSERT INTO `synth_recipes` VALUES (2401,0,0,0,0,0,0,17,0,0,0,4096,4238,650,12752,0,0,0,0,0,0,14031,14032,14032,14032,1,1,1,1,'Bastokan Mittens');
INSERT INTO `synth_recipes` VALUES (2402,0,0,0,0,0,0,52,0,0,0,4099,4241,681,12687,0,0,0,0,0,0,14033,14034,14034,14034,1,1,1,1,'San. Mufflers');
INSERT INTO `synth_recipes` VALUES (2403,0,0,0,0,0,0,82,0,0,0,4096,4238,745,914,12678,0,0,0,0,0,14035,14036,14036,14036,1,1,1,1,'Irn.msk. Gnt. +1');
INSERT INTO `synth_recipes` VALUES (2404,0,0,0,0,0,0,0,31,0,0,4099,4241,850,12753,0,0,0,0,0,0,14037,14038,14038,14038,1,1,1,1,'San. Gloves');
INSERT INTO `synth_recipes` VALUES (2405,0,0,61,0,0,0,0,0,0,0,4096,4238,931,12694,0,0,0,0,0,0,14039,14040,14040,14040,1,1,1,1,'Bas. F. Gauntlets');
INSERT INTO `synth_recipes` VALUES (2406,0,0,0,0,17,0,0,0,0,0,4099,4241,817,824,12719,0,0,0,0,0,14043,14044,14044,14044,1,1,1,1,'Windurstian Tekko');
INSERT INTO `synth_recipes` VALUES (2407,0,0,0,0,21,0,0,0,0,0,4099,4241,818,825,12726,0,0,0,0,0,14045,14046,14046,14046,1,1,1,1,'Win. Gloves');
INSERT INTO `synth_recipes` VALUES (2408,0,0,0,0,36,0,0,0,0,0,4099,4241,819,826,12743,0,0,0,0,0,14047,14048,14048,14048,1,1,1,1,'C.c. Mitts +1');
INSERT INTO `synth_recipes` VALUES (2409,0,0,0,0,72,0,0,0,0,0,4099,4241,822,828,12734,0,0,0,0,0,14049,14050,14050,14050,1,1,1,1,'T.m. Cuffs +1');
INSERT INTO `synth_recipes` VALUES (2410,0,0,0,0,0,0,0,0,59,0,4099,4241,664,670,12680,0,0,0,0,0,14051,14052,14052,14052,1,1,1,1,'Alumine Moufles');
INSERT INTO `synth_recipes` VALUES (2411,0,0,0,0,23,0,0,9,0,0,4099,4241,825,850,850,1828,1829,0,0,0,14053,14054,14054,14054,1,1,1,1,'Traders Cuffs');
INSERT INTO `synth_recipes` VALUES (2412,0,0,0,95,0,0,0,54,0,0,4099,4241,823,862,866,1841,0,0,0,0,14055,14056,14056,14056,1,1,1,1,'Unicorn Mittens'); -- unicorn mittens (bone 95 leather 54) https://www.bg-wiki.com/bg/Unicorn_Mittens
INSERT INTO `synth_recipes` VALUES (2413,0,0,87,0,0,0,0,0,0,57,4103,4245,914,923,924,1264,1265,0,0,0,14065,14066,14066,14066,1,1,1,1,'Garden Bangles');
INSERT INTO `synth_recipes` VALUES (2414,0,0,0,0,4,0,0,45,0,0,4099,4241,817,817,834,1276,1276,0,0,0,14067,14074,14074,14074,1,1,1,1,'Tarasque Mitts'); -- tarasque mitts (leather 45 cloth 4) https://www.bg-wiki.com/bg/Tarasque_Mitts
INSERT INTO `synth_recipes` VALUES (2415,0,0,0,0,0,0,0,3,0,0,4099,4241,825,850,850,0,0,0,0,0,14068,14069,14069,14069,1,1,1,1,'Vgd. Gloves');
INSERT INTO `synth_recipes` VALUES (2416,0,0,0,0,0,0,0,14,0,0,4099,4241,825,852,852,0,0,0,0,0,14070,14071,14071,14071,1,1,1,1,'Fsh. Gloves');
INSERT INTO `synth_recipes` VALUES (2417,0,0,0,0,0,0,0,23,0,0,4099,4241,825,848,852,0,0,0,0,0,14072,14073,14073,14073,1,1,1,1,'Chocobo Gloves');
INSERT INTO `synth_recipes` VALUES (2418,0,0,0,0,98,0,24,26,0,0,4099,4241,798,798,823,829,830,850,0,0,14078,14079,14079,14079,1,1,1,1,'Errant Cuffs');
INSERT INTO `synth_recipes` VALUES (2419,0,0,0,0,42,0,0,96,0,0,4102,4244,821,829,830,850,850,1117,1278,0,14116,14125,14125,14125,1,1,1,1,'Opaline Boots'); -- opaline boots (leath 96 cloth 42) https://www.bg-wiki.com/bg/Opaline_Boots
INSERT INTO `synth_recipes` VALUES (2420,0,0,0,0,0,0,0,6,36,0,4099,4241,674,674,818,12952,0,0,0,0,14118,14119,14119,14119,1,1,1,1,'Iron Greaves');
INSERT INTO `synth_recipes` VALUES (2421,0,0,0,0,0,0,0,0,56,0,4099,4241,676,676,818,12952,0,0,0,0,14120,14121,14121,14121,1,1,1,1,'Steel Greaves');
INSERT INTO `synth_recipes` VALUES (2422,0,0,0,0,82,0,0,0,45,0,4098,4240,664,816,829,829,829,0,0,0,14129,14136,14136,14136,1,1,1,1,'Arhats Sune-ate');
INSERT INTO `synth_recipes` VALUES (2423,0,0,0,0,82,0,0,0,0,0,4099,4241,817,825,14128,0,0,0,0,0,14130,14131,14131,14131,1,1,1,1,'Wulong Shoes');
INSERT INTO `synth_recipes` VALUES (2424,0,0,0,0,0,0,0,89,0,0,4099,4241,852,13014,0,0,0,0,0,0,14132,14133,14133,14133,1,1,1,1,'Winged Boots');
INSERT INTO `synth_recipes` VALUES (2425,0,0,0,0,0,0,0,83,0,0,4098,4240,869,13052,0,0,0,0,0,0,14134,14135,14135,14135,1,1,1,1,'Air Solea');
INSERT INTO `synth_recipes` VALUES (2426,0,0,0,0,0,0,0,0,67,0,4099,4241,682,12942,0,0,0,0,0,0,14137,14138,14138,14138,1,1,1,1,'R.k. Sollerets +1');
INSERT INTO `synth_recipes` VALUES (2427,0,0,0,0,0,0,19,0,0,0,4099,4241,661,13003,0,0,0,0,0,0,14139,14140,14140,14140,1,1,1,1,'Bas. Leggings');
INSERT INTO `synth_recipes` VALUES (2428,0,0,0,0,0,0,51,0,0,0,4099,4241,681,12943,0,0,0,0,0,0,14141,14142,14142,14142,1,1,1,1,'San. Sollerets');
INSERT INTO `synth_recipes` VALUES (2429,0,0,0,0,0,0,78,0,0,0,4096,4238,745,914,12934,0,0,0,0,0,14143,14144,14144,14144,1,1,1,1,'Irn.msk. Sbtn. +1');
INSERT INTO `synth_recipes` VALUES (2430,0,0,0,0,0,0,0,33,0,0,4099,4241,850,13004,0,0,0,0,0,0,14145,14146,14146,14146,1,1,1,1,'San Dorian Boots');
INSERT INTO `synth_recipes` VALUES (2431,0,0,66,0,0,0,0,0,0,0,4096,4238,931,12950,0,0,0,0,0,0,14147,14148,14148,14148,1,1,1,1,'Bastokan Greaves');
INSERT INTO `synth_recipes` VALUES (2432,0,0,0,0,0,0,0,0,0,23,4098,4240,714,13045,0,0,0,0,0,0,14149,14150,14150,14150,1,1,1,1,'San Dorian Clogs');
INSERT INTO `synth_recipes` VALUES (2433,0,0,0,0,19,0,0,0,0,0,4099,4241,817,824,12975,0,0,0,0,0,14151,14152,14152,14152,1,1,1,1,'Win. Kyahan');
INSERT INTO `synth_recipes` VALUES (2434,0,0,0,0,22,0,0,0,0,0,4099,4241,818,825,12982,0,0,0,0,0,14153,14154,14154,14154,1,1,1,1,'Win. Gaiters');
INSERT INTO `synth_recipes` VALUES (2435,0,0,0,0,0,0,0,39,0,0,4099,4241,848,12998,0,0,0,0,0,0,14155,14156,14156,14156,1,1,1,1,'C.c. Shoes +1');
INSERT INTO `synth_recipes` VALUES (2436,0,0,0,0,0,0,0,76,0,0,4099,4241,855,12990,0,0,0,0,0,0,14157,14158,14158,14158,1,1,1,1,'T.m. Pigaches +1');
INSERT INTO `synth_recipes` VALUES (2437,0,0,0,89,0,0,0,0,0,0,4099,4241,1273,12987,0,0,0,0,0,0,14164,14165,14165,14165,1,1,1,1,'Inferno Sabots');
INSERT INTO `synth_recipes` VALUES (2438,0,0,0,0,0,0,0,57,0,0,4099,4241,672,850,850,1296,0,0,0,0,14166,14167,14167,14167,1,1,1,1,'Desert Boots');
INSERT INTO `synth_recipes` VALUES (2439,0,0,0,0,0,0,0,5,0,0,4099,4241,672,824,850,850,0,0,0,0,14169,14170,14170,14170,1,1,1,1,'Vagabonds Boots');
INSERT INTO `synth_recipes` VALUES (2440,0,0,0,0,0,0,0,20,0,0,4099,4241,672,824,852,852,0,0,0,0,14171,14172,14172,14172,1,1,1,1,'Fishermans Boots');
INSERT INTO `synth_recipes` VALUES (2441,0,0,0,0,0,0,0,30,0,0,4099,4241,672,824,848,848,0,0,0,0,14173,14174,14174,14174,1,1,1,1,'Chocobo Boots');
INSERT INTO `synth_recipes` VALUES (2442,0,0,0,0,0,0,0,40,0,0,4099,4241,672,824,851,851,0,0,0,0,14176,14177,14177,14177,1,1,1,1,'Field Boots');
INSERT INTO `synth_recipes` VALUES (2443,0,0,0,0,92,0,0,43,43,0,4098,4240,664,816,855,855,1132,0,0,0,14178,14179,14179,14179,1,1,1,1,'Rasetsu Sune-ate'); -- rasetsu sune-ate (cloth 92 leath 43 smith 43) https://www.bg-wiki.com/bg/Rasetsu_Sune-Ate
INSERT INTO `synth_recipes` VALUES (2444,0,0,0,0,52,0,0,91,0,0,4099,4241,821,828,849,851,851,0,0,0,14182,14183,14183,14183,1,1,1,1,'Errant Pigaches');
INSERT INTO `synth_recipes` VALUES (2445,0,0,0,96,0,0,0,53,0,0,4099,4241,866,1629,1629,1771,0,0,0,0,14186,14187,14187,14187,1,1,1,1,'Dragon Leggings'); -- dragon leggings (bone 96 leather 53) https://www.bg-wiki.com/bg/Dragon_Leggings
INSERT INTO `synth_recipes` VALUES (2446,0,0,0,0,11,0,0,94,0,0,4099,4241,821,850,851,1277,12987,0,0,0,14189,14190,14190,14190,1,1,1,1,'Austere Sabots'); -- austere sabots (leather 94 cloth 11) https://www.bg-wiki.com/bg/Austere_Sabots
INSERT INTO `synth_recipes` VALUES (2447,0,0,0,0,0,0,0,98,0,0,4099,4241,674,851,851,1277,0,0,0,0,14191,14192,14192,14192,1,1,1,1,'Heroic Boots');
INSERT INTO `synth_recipes` VALUES (2448,0,0,0,0,98,0,0,0,0,0,4099,4241,821,830,12995,0,0,0,0,0,14196,14197,14197,14197,1,1,1,1,'Dance Shoes');
INSERT INTO `synth_recipes` VALUES (2449,0,0,0,0,0,0,0,5,35,0,4099,4241,674,674,818,12824,0,0,0,0,14243,14244,14244,14244,1,1,1,1,'Iron Cuisses');
INSERT INTO `synth_recipes` VALUES (2450,0,0,0,0,0,0,0,5,55,0,4099,4241,676,676,818,12824,0,0,0,0,14245,14246,14246,14246,1,1,1,1,'Steel Cuisses');
INSERT INTO `synth_recipes` VALUES (2451,0,0,0,0,66,0,0,0,0,0,4102,4244,816,816,816,828,828,1278,1278,0,14249,14250,14250,14250,1,1,1,1,'Opaline Hose');
INSERT INTO `synth_recipes` VALUES (2452,0,0,0,0,88,0,0,0,0,0,4099,4241,816,828,828,829,850,850,0,0,14253,14256,14256,14256,1,1,1,1,'Arhats Hakama');
INSERT INTO `synth_recipes` VALUES (2453,0,0,0,0,83,0,0,0,0,0,4099,4241,818,826,12923,0,0,0,0,0,14254,14255,14255,14255,1,1,1,1,'Masters Sitabaki');
INSERT INTO `synth_recipes` VALUES (2454,0,0,0,0,0,0,21,0,0,0,4099,4241,661,12881,0,0,0,0,0,0,14259,14260,14260,14260,1,1,1,1,'Bastokan Subligar');
INSERT INTO `synth_recipes` VALUES (2455,0,0,0,0,0,0,53,0,0,0,4099,4241,681,12815,0,0,0,0,0,0,14261,14262,14262,14262,1,1,1,1,'Ryl.sqr. Brch. +1');
INSERT INTO `synth_recipes` VALUES (2456,0,0,0,0,0,0,76,0,0,0,4096,4238,745,914,12806,0,0,0,0,0,14263,14264,14264,14264,1,1,1,1,'I.m. Cuisses +1');
INSERT INTO `synth_recipes` VALUES (2457,0,0,0,0,0,0,0,35,0,0,4099,4241,850,12882,0,0,0,0,0,0,14265,14266,14266,14266,1,1,1,1,'San. Trousers');
INSERT INTO `synth_recipes` VALUES (2458,0,0,65,0,0,0,0,0,0,0,4096,4238,931,12822,0,0,0,0,0,0,14267,14268,14268,14268,1,1,1,1,'Bastokan Cuisses');
INSERT INTO `synth_recipes` VALUES (2459,0,0,0,0,21,0,0,0,0,0,4099,4241,817,824,12855,0,0,0,0,0,14269,14270,14270,14270,1,1,1,1,'Win. Sitabaki');
INSERT INTO `synth_recipes` VALUES (2460,0,0,0,0,24,0,0,0,0,0,4099,4241,818,825,12854,0,0,0,0,0,14271,14272,14272,14272,1,1,1,1,'Windurstian Brais');
INSERT INTO `synth_recipes` VALUES (2461,0,0,0,0,30,0,0,0,0,0,4099,4241,819,826,12915,0,0,0,0,0,14273,14274,14274,14274,1,1,1,1,'Windurstian Slops');
INSERT INTO `synth_recipes` VALUES (2462,0,0,0,0,36,0,0,0,0,0,4099,4241,819,826,12870,0,0,0,0,0,14275,14276,14276,14276,1,1,1,1,'C.c. Slacks +1'); -- combat caster's slacks +1 (cloth 36) https://www.bg-wiki.com/bg/C.C._Slacks_%2B1
INSERT INTO `synth_recipes` VALUES (2463,0,0,0,0,72,0,0,0,0,0,4099,4241,822,828,12862,0,0,0,0,0,14277,14278,14278,14278,1,1,1,1,'T.m. Slops +1');
INSERT INTO `synth_recipes` VALUES (2464,0,0,0,0,0,0,0,85,0,0,4099,4241,849,12574,0,0,0,0,0,0,14284,14285,14285,14285,1,1,1,1,'Northern Jerkin');
INSERT INTO `synth_recipes` VALUES (2465,0,0,0,75,0,0,0,35,0,0,4099,4241,826,887,1277,0,0,0,0,0,14288,14289,14289,14289,1,1,1,1,'Clowns Subligar'); -- clown's subligar (bone 75, leather 35) https://www.bg-wiki.com/bg/Clown's_Subligar
INSERT INTO `synth_recipes` VALUES (2466,0,0,0,0,10,0,0,0,0,0,4099,4241,817,824,825,825,0,0,0,0,14290,14291,14291,14291,1,1,1,1,'Vagabonds Hose');
INSERT INTO `synth_recipes` VALUES (2467,0,0,0,0,23,0,0,0,0,0,4099,4241,818,825,826,826,0,0,0,0,14292,14293,14293,14293,1,1,1,1,'Fishermans Hose');
INSERT INTO `synth_recipes` VALUES (2468,0,0,0,0,50,0,0,0,0,0,4099,4241,819,826,827,850,0,0,0,0,14294,14295,14295,14295,1,1,1,1,'Chocobo Hose');
INSERT INTO `synth_recipes` VALUES (2469,0,0,0,0,60,0,0,0,0,0,4099,4241,820,826,827,827,0,0,0,0,14297,14298,14298,14298,1,1,1,1,'Field Hose');
INSERT INTO `synth_recipes` VALUES (2470,0,0,0,0,97,0,0,35,41,0,4099,4241,664,816,828,828,850,855,1132,0,14299,14300,14300,14300,1,1,1,1,'Rst. Hakama');
INSERT INTO `synth_recipes` VALUES (2471,0,0,0,0,94,0,0,26,0,0,4099,4241,821,828,828,829,829,851,0,0,14301,14302,14302,14302,1,1,1,1,'Errant Slops');
INSERT INTO `synth_recipes` VALUES (2472,0,0,0,92,0,0,0,53,0,0,4099,4241,1280,1629,1771,0,0,0,0,0,14305,14306,14306,14306,1,1,1,1,'Dragon Subligar');
INSERT INTO `synth_recipes` VALUES (2473,0,0,0,0,11,0,0,98,0,0,4099,4241,821,849,858,1277,12859,0,0,0,14310,14311,14311,14311,1,1,1,1,'Austere Slops');
INSERT INTO `synth_recipes` VALUES (2474,0,0,0,0,93,0,0,56,0,0,4099,4241,823,828,828,828,855,1279,0,0,14315,14316,14316,14316,1,1,1,1,'Shair Seraweels');
INSERT INTO `synth_recipes` VALUES (2475,0,0,0,0,54,0,0,90,0,0,4099,4241,829,1280,1629,1629,1680,0,0,0,14317,14318,14318,14318,1,1,1,1,'Barone Cosciales'); -- barone cosciales (leath 90 cloth 54) https://www.bg-wiki.com/bg/Barone_Cosciales
INSERT INTO `synth_recipes` VALUES (2476,0,0,0,0,54,0,0,97,0,0,4099,4241,855,1117,1163,1163,1163,1163,1629,1629,14319,14320,14320,14320,1,1,1,1,'Bison Kecks');
INSERT INTO `synth_recipes` VALUES (2477,0,0,0,97,0,0,0,46,0,0,4099,4241,506,927,1117,1618,1680,1718,0,0,14321,14322,14322,14322,1,1,1,1,'Igqira Lappas'); -- igqira lappa (bone 97 leather 46) https://www.bg-wiki.com/bg/Igqira_Lappa
INSERT INTO `synth_recipes` VALUES (2478,0,0,0,0,27,0,0,28,0,0,4099,4241,819,826,826,850,0,0,0,0,14323,14333,14333,14333,1,1,1,1,'Noct Brais');
INSERT INTO `synth_recipes` VALUES (2479,0,0,0,0,38,0,0,0,0,0,4099,4241,1702,14326,0,0,0,0,0,0,14324,14324,14324,14324,1,1,1,1,'Mist Slacks');
INSERT INTO `synth_recipes` VALUES (2480,0,0,0,0,25,0,0,20,0,0,4099,4241,820,825,825,826,850,0,0,0,14325,14328,14328,14328,1,1,1,1,'Seers Slacks');
INSERT INTO `synth_recipes` VALUES (2481,0,0,0,0,35,0,0,21,0,0,4099,4241,826,828,828,850,1700,0,0,0,14326,14330,14330,14330,1,1,1,1,'Garish Slacks');
INSERT INTO `synth_recipes` VALUES (2482,0,0,0,39,22,0,0,24,0,0,4099,4241,529,828,855,1618,1623,1717,0,0,14327,14331,14331,14331,1,1,1,1,'Shade Tights'); -- shade tights (bone 39 leath 24 cloth 22) https://www.bg-wiki.com/bg/Shade_Tights
INSERT INTO `synth_recipes` VALUES (2483,0,0,0,0,0,0,0,13,37,0,4096,4238,660,662,848,850,0,0,0,0,14329,14332,14332,14332,1,1,1,1,'Eisendiechlings');
INSERT INTO `synth_recipes` VALUES (2484,0,0,0,0,0,0,23,0,0,0,4099,4241,661,12629,0,0,0,0,0,0,14338,14339,14339,14339,1,1,1,1,'Bastokan Harness');
INSERT INTO `synth_recipes` VALUES (2485,0,0,0,0,0,0,55,0,0,0,4099,4241,681,12559,0,0,0,0,0,0,14340,14341,14341,14341,1,1,1,1,'Ryl.sqr. Chnml. +1');
INSERT INTO `synth_recipes` VALUES (2486,0,0,0,0,0,0,83,0,0,0,4096,4238,745,914,12550,0,0,0,0,0,14342,14343,14343,14343,1,1,1,1,'I.m. Cuirass +1');
INSERT INTO `synth_recipes` VALUES (2487,0,0,0,0,0,0,0,37,0,0,4099,4241,850,12630,0,0,0,0,0,0,14344,14345,14345,14345,1,1,1,1,'San Dorian Vest');
INSERT INTO `synth_recipes` VALUES (2488,0,0,67,0,0,0,0,0,0,0,4096,4238,931,12566,0,0,0,0,0,0,14346,14347,14347,14347,1,1,1,1,'Bas. Scale Mail');
INSERT INTO `synth_recipes` VALUES (2489,0,0,0,0,22,0,0,0,0,0,4099,4241,818,824,13718,0,0,0,0,0,14348,14349,14349,14349,1,1,1,1,'San Dorian Tunic');
INSERT INTO `synth_recipes` VALUES (2490,0,0,0,0,23,0,0,0,0,0,4099,4241,817,824,12653,0,0,0,0,0,14350,14351,14351,14351,1,1,1,1,'Windurstian Gi');
INSERT INTO `synth_recipes` VALUES (2491,0,0,0,0,25,0,0,0,0,0,4099,4241,818,825,12598,0,0,0,0,0,14352,14353,14353,14353,1,1,1,1,'Win. Doublet');
INSERT INTO `synth_recipes` VALUES (2492,0,0,0,0,38,0,0,0,0,0,4099,4241,819,826,12614,0,0,0,0,0,14354,14355,14355,14355,1,1,1,1,'C.c. Cloak +1');
INSERT INTO `synth_recipes` VALUES (2493,0,0,0,0,55,0,0,0,0,0,4099,4241,820,827,13721,0,0,0,0,0,14356,14357,14357,14357,1,1,1,1,'Irn.msk.gmbsn. +1');
INSERT INTO `synth_recipes` VALUES (2494,0,0,0,0,50,0,0,0,0,0,4099,4241,822,827,13719,0,0,0,0,0,14358,14359,14359,14359,1,1,1,1,'Ryl.sqr. Robe +1');
INSERT INTO `synth_recipes` VALUES (2495,0,0,0,0,68,0,0,0,0,0,4099,4241,823,829,13720,0,0,0,0,0,14360,14361,14361,14361,1,1,1,1,'R.k. Cloak +1');
INSERT INTO `synth_recipes` VALUES (2496,0,0,0,0,73,0,0,0,0,0,4099,4241,822,828,12606,0,0,0,0,0,14362,14363,14363,14363,1,1,1,1,'T.m. Coat +1');
INSERT INTO `synth_recipes` VALUES (2497,0,0,0,0,21,0,0,94,31,0,4101,4243,666,823,851,855,855,913,1117,1117,14372,14373,14373,14373,1,1,1,1,'Cardinal Vest');
INSERT INTO `synth_recipes` VALUES (2498,0,0,0,0,69,0,0,36,0,0,4099,4241,820,826,827,827,850,851,0,0,14374,14375,14375,14375,1,1,1,1,'Field Tunica');
INSERT INTO `synth_recipes` VALUES (2499,0,0,0,0,99,0,0,48,52,0,4099,4241,664,666,821,828,855,855,1132,1132,14376,14377,14377,14377,1,1,1,1,'Rasetsu Samue');
INSERT INTO `synth_recipes` VALUES (2500,0,0,0,0,96,0,50,30,0,0,4099,4241,761,821,828,829,829,830,830,851,14380,14381,14381,14381,1,1,1,1,'Errant Hpl.');
INSERT INTO `synth_recipes` VALUES (2501,0,0,0,0,0,0,54,34,97,0,4096,4238,664,664,682,747,855,855,1704,1705,14382,14383,14383,14383,1,1,1,1,'Plastron');
INSERT INTO `synth_recipes` VALUES (2502,0,0,0,0,95,0,0,0,0,0,4102,4244,821,828,829,829,829,830,1278,1278,14384,14385,14385,14385,1,1,1,1,'Opaline Dress');
INSERT INTO `synth_recipes` VALUES (2503,0,0,0,100,0,0,0,58,0,0,4099,4241,1629,1629,1771,1816,0,0,0,0,14389,14390,14390,14390,1,1,1,1,'Dragon Harness'); -- dragon harness (bone 100 leather 58) https://www.bg-wiki.com/bg/Dragon_Harness
INSERT INTO `synth_recipes` VALUES (2504,0,0,0,0,60,0,95,0,0,0,4099,4241,752,786,794,823,823,828,828,1714,14414,14415,14415,14415,1,1,1,1,'Shair Manteel');
INSERT INTO `synth_recipes` VALUES (2505,0,0,0,0,0,0,59,9,95,0,4099,4241,664,669,745,763,914,1304,1629,1699,14416,14417,14417,14417,1,1,1,1,'Barone Corazza');
INSERT INTO `synth_recipes` VALUES (2506,0,0,0,60,51,0,0,99,0,0,4099,4241,1117,1117,1163,1163,1615,1623,1629,1629,14418,14419,14419,14419,1,1,1,1,'Bison Jacket');
INSERT INTO `synth_recipes` VALUES (2507,0,0,44,99,0,0,0,55,0,0,4099,4241,506,795,848,903,1163,1622,1626,1680,14420,14421,14421,14421,1,1,1,1,'Igqira Weskit'); -- igqira weskit (bone 99, leather 55, alch 44)
INSERT INTO `synth_recipes` VALUES (2508,0,0,0,0,26,0,0,20,0,0,4099,4241,819,826,826,826,834,834,834,850,14422,14434,14434,14434,1,1,1,1,'Noct Doublet');
INSERT INTO `synth_recipes` VALUES (2509,0,0,0,0,39,0,0,0,0,0,4099,4241,1702,14425,0,0,0,0,0,0,14423,14423,14423,14423,1,1,1,1,'Mist Tunic');
INSERT INTO `synth_recipes` VALUES (2510,0,0,0,0,26,0,0,20,0,0,4099,4241,820,825,825,825,826,826,850,0,14424,14427,14427,14427,1,1,1,1,'Seers Tunic');
INSERT INTO `synth_recipes` VALUES (2511,0,0,0,0,36,0,0,20,0,0,4099,4241,828,828,850,1699,1699,1699,1700,0,14425,14432,14432,14432,1,1,1,1,'Garish Tunic');
INSERT INTO `synth_recipes` VALUES (2512,0,0,0,42,24,0,0,25,0,0,4099,4241,529,828,855,1618,1618,1623,1623,1717,14426,14433,14433,14433,1,1,1,1,'Shade Harness');
INSERT INTO `synth_recipes` VALUES (2513,0,0,0,0,0,0,11,10,43,0,4096,4238,660,660,662,662,744,850,914,0,14431,14435,14435,14435,1,1,1,1,'Eisenbrust');
INSERT INTO `synth_recipes` VALUES (2514,0,0,0,0,100,0,0,0,0,0,4099,4241,822,823,823,828,828,830,1769,1769,14436,14438,14438,14438,1,1,1,1,'Blessed Briault'); -- blessed briault (cloth 100) https://www.bg-wiki.com/bg/Blessed_Briault
INSERT INTO `synth_recipes` VALUES (2515,0,0,0,0,0,0,0,31,96,0,4096,4238,665,682,682,823,855,1763,1773,1773,14437,14439,14439,14439,1,1,1,1,'Hachiman Domaru');
INSERT INTO `synth_recipes` VALUES (2516,0,0,0,0,40,0,44,90,0,0,4099,4241,746,822,828,828,1117,1623,1767,1767,14440,14441,14441,14441,1,1,1,1,'Chasuble'); -- chasuble (leath 90 gold 44 cloth 40) https://www.bg-wiki.com/bg/Chasuble
INSERT INTO `synth_recipes` VALUES (2517,0,0,0,0,1,0,51,0,64,0,4099,4241,664,670,679,682,682,682,828,829,14444,14445,14445,14445,1,1,1,1,'Alumine Haubert');
INSERT INTO `synth_recipes` VALUES (2518,0,0,0,0,25,0,0,9,0,0,4099,4241,764,825,850,851,913,1828,1829,1829,14446,14447,14447,14447,1,1,1,1,'Traders Saio');
INSERT INTO `synth_recipes` VALUES (2519,0,0,0,103,0,0,0,60,0,0,4099,4241,823,855,862,1841,1841,0,0,0,14448,14449,14449,14449,1,1,1,1,'Unicorn Harness'); -- unicorn harness (bone 103 leather 60) https://www.bg-wiki.com/bg/Unicorn_Harness
INSERT INTO `synth_recipes` VALUES (2520,0,0,0,0,20,0,0,0,0,0,4099,4241,1963,12608,0,0,0,0,0,0,14490,14490,14490,14490,1,1,1,1,'Mana Tunic');
INSERT INTO `synth_recipes` VALUES (2521,0,0,0,0,36,0,0,0,0,0,4099,4241,1964,12610,0,0,0,0,0,0,14491,14491,14491,14491,1,1,1,1,'Mana Cloak');
INSERT INTO `synth_recipes` VALUES (2522,0,0,0,0,66,0,0,0,0,0,4099,4241,1965,12611,0,0,0,0,0,0,14492,14492,14492,14492,1,1,1,1,'High Mana Cloak');
INSERT INTO `synth_recipes` VALUES (2523,0,0,0,0,0,0,0,35,0,0,4099,4241,1977,12570,0,0,0,0,0,0,14493,14493,14493,14493,1,1,1,1,'Healing Vest');
INSERT INTO `synth_recipes` VALUES (2524,0,0,0,93,0,0,0,0,0,0,4099,4241,1976,12564,0,0,0,0,0,0,14494,14494,14494,14494,1,1,1,1,'Healing Mail'); -- healing mail (bone 93) https://www.bg-wiki.com/bg/Healing_Mail
INSERT INTO `synth_recipes` VALUES (2525,0,0,0,29,0,0,0,0,0,0,4099,4241,1973,12582,0,0,0,0,0,0,14495,14495,14495,14495,1,1,1,1,'Healing Harness');
INSERT INTO `synth_recipes` VALUES (2526,0,0,0,59,0,0,0,0,0,0,4099,4241,1975,13744,0,0,0,0,0,0,14496,14496,14496,14496,1,1,1,1,'Healing Jstcorps');
INSERT INTO `synth_recipes` VALUES (2527,0,0,0,53,0,0,0,0,0,0,4099,4241,1974,13712,0,0,0,0,0,0,14497,14497,14497,14497,1,1,1,1,'High Heal. Harness');
INSERT INTO `synth_recipes` VALUES (2528,0,0,0,0,68,0,21,16,0,0,4099,4241,744,823,828,828,828,834,834,850,14498,14499,14499,14499,1,1,1,1,'Crow Jupon');
INSERT INTO `synth_recipes` VALUES (2529,0,0,0,0,49,0,51,91,0,0,4099,4241,663,666,761,829,879,2152,2152,2289,14524,14528,14528,14528,1,1,1,1,'Sipahi Jawshan'); -- sipahi jawshan (leath 91 gold 51 cloth 49) https://www.bg-wiki.com/bg/Sipahi_Jawshan
INSERT INTO `synth_recipes` VALUES (2530,0,0,0,0,39,0,0,66,43,0,4099,4241,652,666,682,764,828,879,2152,2288,14526,14529,14529,14529,1,1,1,1,'Jaridah Peti'); -- jaridah peti (leath 66 smith 43 cloth 39) https://www.bg-wiki.com/bg/Jaridah_Peti
INSERT INTO `synth_recipes` VALUES (2531,0,1993,0,0,0,0,0,0,40,0,4099,4241,2230,2233,12552,0,0,0,0,0,14531,14531,14531,14531,1,1,1,1,'Bannaret Mail');
INSERT INTO `synth_recipes` VALUES (2532,0,0,0,104,0,0,0,27,0,0,4099,4241,821,879,1586,1586,2172,2172,12568,0,14537,14538,14538,14538,1,1,1,1,'Hydra Mail'); -- hydra mail (bone 104, leather 27) https://www.bg-wiki.com/bg/Hydra_Mail
INSERT INTO `synth_recipes` VALUES (2533,0,0,0,0,100,0,22,26,0,0,4099,4241,821,1764,1997,1998,2170,2275,2330,2340,14539,14540,14540,14540,1,1,1,1,'Kyudogi');
INSERT INTO `synth_recipes` VALUES (2534,0,2009,0,0,21,0,0,0,0,0,4099,4241,2232,2233,12584,0,0,0,0,0,14541,14541,14541,14541,1,1,1,1,'Taikyoku Kenpogi');
INSERT INTO `synth_recipes` VALUES (2535,0,0,0,0,68,0,0,0,0,0,4099,4241,822,823,828,828,2340,2340,0,0,14542,14543,14543,14543,1,1,1,1,'Silken Coat');
INSERT INTO `synth_recipes` VALUES (2536,0,0,0,0,0,0,60,101,60,0,4099,4241,665,914,2007,2122,2152,2166,2275,2359,14544,14545,14545,14545,1,1,1,1,'Corselet'); -- corselet (leath 101 gold 60 smith 60) https://www.bg-wiki.com/bg/Corselet
INSERT INTO `synth_recipes` VALUES (2537,0,0,0,60,54,0,0,99,0,0,4099,4241,1117,1117,1615,1623,1629,1629,2372,2372,14566,14567,14567,14567,1,1,1,1,'Khimaira Jacket'); -- khimaira jacket (leather 99, bone 60, cloth 54) https://www.bg-wiki.com/bg/Khimaira_Jacket
INSERT INTO `synth_recipes` VALUES (2538,0,0,0,0,81,0,0,0,0,0,4099,4241,2340,12596,0,0,0,0,0,0,14571,14572,14572,14572,1,1,1,1,'Tabin Jupon');
INSERT INTO `synth_recipes` VALUES (2539,0,0,0,0,0,0,102,0,0,0,4099,4241,1299,13466,0,0,0,0,0,0,14630,14630,14630,14630,1,1,1,1,'Flame Ring');
INSERT INTO `synth_recipes` VALUES (2540,0,0,0,0,0,0,102,0,0,0,4099,4241,1304,13466,0,0,0,0,0,0,14632,14632,14632,14632,1,1,1,1,'Aqua Ring');
INSERT INTO `synth_recipes` VALUES (2541,0,0,0,0,0,0,102,0,0,0,4099,4241,1302,13466,0,0,0,0,0,0,14634,14634,14634,14634,1,1,1,1,'Soil Ring');
INSERT INTO `synth_recipes` VALUES (2542,0,0,0,0,0,0,102,0,0,0,4099,4241,1301,13466,0,0,0,0,0,0,14636,14636,14636,14636,1,1,1,1,'Breeze Ring');
INSERT INTO `synth_recipes` VALUES (2543,0,0,0,0,0,0,102,0,0,0,4099,4241,1303,13466,0,0,0,0,0,0,14638,14638,14638,14638,1,1,1,1,'Thunder Ring');
INSERT INTO `synth_recipes` VALUES (2544,0,0,0,0,0,0,102,0,0,0,4099,4241,1300,13466,0,0,0,0,0,0,14640,14640,14640,14640,1,1,1,1,'Snow Ring');
INSERT INTO `synth_recipes` VALUES (2545,0,0,0,0,0,0,102,0,0,0,4099,4241,1305,13466,0,0,0,0,0,0,14642,14642,14642,14642,1,1,1,1,'Light Ring');
INSERT INTO `synth_recipes` VALUES (2546,0,0,0,0,0,0,102,0,0,0,4099,4241,1306,13466,0,0,0,0,0,0,14644,14644,14644,14644,1,1,1,1,'Dark Ring');
INSERT INTO `synth_recipes` VALUES (2547,0,0,0,0,0,0,0,0,0,0,4098,4240,14628,0,0,0,0,0,0,0,14647,14647,14647,14647,1,1,1,1,'Castors Ring');
INSERT INTO `synth_recipes` VALUES (2548,0,0,0,0,0,0,0,0,0,0,4098,4240,14629,0,0,0,0,0,0,0,14648,14648,14648,14648,1,1,1,1,'Polluxs Ring');
INSERT INTO `synth_recipes` VALUES (2549,0,0,0,0,0,0,35,0,0,0,4096,4238,1675,13456,0,0,0,0,0,0,14654,14654,14654,14654,1,1,1,1,'Poisona Ring');
INSERT INTO `synth_recipes` VALUES (2550,0,0,0,0,0,0,96,0,0,0,4096,4238,1677,13466,0,0,0,0,0,0,14656,14656,14656,14656,1,1,1,1,'Poseidons Ring');
INSERT INTO `synth_recipes` VALUES (2551,0,0,0,0,0,0,78,0,0,0,4099,4241,13315,18136,0,0,0,0,0,0,14720,14721,14721,14721,1,1,1,1,'Morion Earring');
INSERT INTO `synth_recipes` VALUES (2552,0,0,0,0,0,0,88,0,0,0,4099,4241,1271,13316,0,0,0,0,0,0,14722,14723,14723,14723,1,1,1,1,'Pigeon Earring');
INSERT INTO `synth_recipes` VALUES (2553,0,0,0,0,0,0,57,0,0,0,4099,4241,1274,13328,0,0,0,0,0,0,14725,14726,14726,14726,1,1,1,1,'Melody Earring');
INSERT INTO `synth_recipes` VALUES (2554,0,0,0,0,0,0,78,0,0,0,4099,4241,13315,18140,0,0,0,0,0,0,14727,14728,14728,14728,1,1,1,1,'Phantom Earring');
INSERT INTO `synth_recipes` VALUES (2555,0,0,0,0,0,0,45,0,0,0,4098,4240,1835,13328,0,0,0,0,0,0,14790,14790,14790,14790,1,1,1,1,'Reraise Earring');
INSERT INTO `synth_recipes` VALUES (2556,0,0,0,0,0,0,0,33,0,0,4099,4241,825,848,851,0,0,0,0,0,14817,14818,14818,14818,1,1,1,1,'Field Gloves');
INSERT INTO `synth_recipes` VALUES (2557,0,0,0,0,95,0,0,41,41,0,4099,4241,664,664,680,819,855,1132,0,0,14819,14820,14820,14820,1,1,1,1,'Rasetsu Tekko');
INSERT INTO `synth_recipes` VALUES (2558,0,0,0,94,0,0,0,52,0,0,4099,4241,866,1629,1771,0,0,0,0,0,14823,14824,14824,14824,1,1,1,1,'Dragon Mittens'); -- dragon mittens (bone 94 leath 52) https://www.bg-wiki.com/bg/Dragon_Mittens
INSERT INTO `synth_recipes` VALUES (2559,0,0,0,0,11,0,0,97,0,0,4099,4241,821,1276,1296,12731,0,0,0,0,14826,14827,14827,14827,1,1,1,1,'Austere Cuffs');
INSERT INTO `synth_recipes` VALUES (2560,0,0,0,0,41,0,46,96,0,0,4099,4241,745,790,823,828,855,1680,0,0,14846,14847,14847,14847,1,1,1,1,'Shair Gages');
INSERT INTO `synth_recipes` VALUES (2561,0,0,0,0,0,0,8,52,94,0,4099,4241,665,665,745,914,1629,1699,1699,0,14848,14849,14849,14849,1,1,1,1,'Barone Manopolas');
INSERT INTO `synth_recipes` VALUES (2562,0,0,0,0,25,0,0,91,0,0,4099,4241,1117,1117,1163,1163,1629,0,0,0,14850,14851,14851,14851,1,1,1,1,'Bison Wristbands'); -- bison wristbands (leath 91 cloth 25) https://www.bg-wiki.com/bg/Bison_Wristbands
INSERT INTO `synth_recipes` VALUES (2563,0,0,41,93,0,0,0,46,0,0,4099,4241,790,1163,1618,1622,1626,0,0,0,14852,14853,14853,14853,1,1,1,1,'Igqira Manillas');
INSERT INTO `synth_recipes` VALUES (2564,0,0,0,0,25,0,0,20,0,0,4099,4241,819,826,826,834,834,850,0,0,14854,14865,14865,14865,1,1,1,1,'Noct Gloves');
INSERT INTO `synth_recipes` VALUES (2565,0,0,0,0,37,0,0,0,0,0,4099,4241,1702,14857,0,0,0,0,0,0,14855,14855,14855,14855,1,1,1,1,'Mist Mitts');
INSERT INTO `synth_recipes` VALUES (2566,0,0,0,0,24,0,0,20,0,0,4099,4241,820,825,825,834,850,0,0,0,14856,14859,14859,14859,1,1,1,1,'Seers Mitts');
INSERT INTO `synth_recipes` VALUES (2567,0,0,0,0,34,0,0,12,0,0,4099,4241,825,834,850,1699,1700,0,0,0,14857,14861,14861,14861,1,1,1,1,'Garish Mitts');
INSERT INTO `synth_recipes` VALUES (2568,0,0,0,38,21,0,0,24,0,0,4099,4241,529,850,855,1618,1623,1717,0,0,14858,14862,14862,14862,1,1,1,1,'Shade Mittens'); -- shade mittens (bone 38, leather 24, cloth 21) https://www.bg-wiki.com/bg/Shade_Mittens
INSERT INTO `synth_recipes` VALUES (2569,0,0,0,0,0,0,12,0,42,0,4096,4238,660,662,744,914,12696,12696,0,0,14860,14863,14863,14863,1,1,1,1,'Eisenhentzes');
INSERT INTO `synth_recipes` VALUES (2570,0,0,0,0,0,0,52,0,0,0,4096,4238,1678,13979,0,0,0,0,0,0,14864,14864,14864,14864,1,1,1,1,'Palmers Bangles');
INSERT INTO `synth_recipes` VALUES (2571,0,0,0,0,96,0,0,0,0,0,4099,4241,823,823,828,834,1769,0,0,0,14875,14877,14877,14877,1,1,1,1,'Blessed Mitts');
INSERT INTO `synth_recipes` VALUES (2572,0,0,0,0,0,0,0,47,93,0,4096,4238,664,664,682,682,745,855,1763,0,14876,14878,14878,14878,1,1,1,1,'Hachiman Kote');
INSERT INTO `synth_recipes` VALUES (2573,0,0,0,0,0,0,88,0,0,0,4096,4238,745,745,914,12675,0,0,0,0,14879,14883,14883,14883,1,1,1,1,'Lords Gauntlets');
INSERT INTO `synth_recipes` VALUES (2574,0,0,0,0,32,0,0,89,0,0,4099,4241,822,828,834,834,1767,12696,0,0,14880,14881,14881,14881,1,1,1,1,'Wise Gloves'); -- wise gloves (leath 89 cloth 32) https://www.bg-wiki.com/bg/Wise_Gloves
INSERT INTO `synth_recipes` VALUES (2575,0,0,0,0,62,0,0,1,0,0,4099,4241,823,828,828,834,834,850,0,0,14907,14908,14908,14908,1,1,1,1,'Crow Bracers');
INSERT INTO `synth_recipes` VALUES (2576,0,0,0,0,19,0,44,87,0,0,4099,4241,663,879,2152,2166,2288,0,0,0,14932,14938,14938,14938,1,1,1,1,'Sipahi Dastanas'); -- sipahi dastanas (leather 87 gold 44 cloth 19) https://www.bg-wiki.com/bg/Sipahi_Dastanas
INSERT INTO `synth_recipes` VALUES (2577,0,0,0,0,11,0,0,27,68,0,4099,4241,666,666,879,2166,2274,0,0,0,14934,14939,14939,14939,1,1,1,1,'Jaridah Bazubands');
INSERT INTO `synth_recipes` VALUES (2578,0,0,0,64,0,0,0,21,0,0,4099,4241,879,2146,2147,0,0,0,0,0,14941,14942,14942,14942,1,1,1,1,'Marid Mittens'); -- marid mittens (bone 64 leath 21) https://www.bg-wiki.com/bg/Marid_Mittens
INSERT INTO `synth_recipes` VALUES (2579,0,0,0,98,0,0,0,0,0,0,4099,4241,821,1586,2172,12696,0,0,0,0,14949,14950,14950,14950,1,1,1,1,'Hydra Fng. Gnt.'); -- hydra finger gauntlets (bone 98) https://www.bg-wiki.com/bg/Hydra_Finger_Gauntlets
INSERT INTO `synth_recipes` VALUES (2580,0,0,0,0,71,0,32,0,0,0,4099,4241,795,795,823,828,2340,0,0,0,14955,14956,14956,14956,1,1,1,1,'Silken Cuffs');
INSERT INTO `synth_recipes` VALUES (2581,0,2017,0,0,0,0,0,29,0,0,4099,4241,2231,2233,12698,0,0,0,0,0,14957,14957,14957,14957,1,1,1,1,'Aiming Gloves');
INSERT INTO `synth_recipes` VALUES (2582,0,0,0,0,0,0,0,91,0,0,4099,4241,1117,1117,1629,2372,2372,0,0,0,14981,14982,14982,14982,1,1,1,1,'Khimaira Wrist.');
INSERT INTO `synth_recipes` VALUES (2583,0,0,0,47,0,0,0,0,0,0,4099,4241,2420,13713,0,0,0,0,0,0,14987,14987,14987,14987,1,1,1,1,'Thunder Mittens');
INSERT INTO `synth_recipes` VALUES (2584,0,0,0,57,0,0,0,0,0,0,4099,4241,2421,13981,0,0,0,0,0,0,14988,14988,14988,14988,1,1,1,1,'Stone Bangles');
INSERT INTO `synth_recipes` VALUES (2585,0,0,0,0,0,0,50,0,0,0,4099,4241,2422,12682,0,0,0,0,0,0,14989,14989,14989,14989,1,1,1,1,'Aero Mufflers');
INSERT INTO `synth_recipes` VALUES (2586,0,0,0,0,0,0,0,60,0,0,4099,4241,2423,12700,0,0,0,0,0,0,14990,14990,14990,14990,1,1,1,1,'Blizzard Gloves');
INSERT INTO `synth_recipes` VALUES (2587,0,0,0,0,49,0,0,0,0,0,4099,4241,2424,12723,0,0,0,0,0,0,14991,14991,14991,14991,1,1,1,1,'Fire Bracers');
INSERT INTO `synth_recipes` VALUES (2588,0,0,0,0,63,0,0,0,0,0,4099,4241,2425,12739,0,0,0,0,0,0,14992,14992,14992,14992,1,1,1,1,'Water Mitts');
INSERT INTO `synth_recipes` VALUES (2589,0,0,0,0,75,0,0,0,0,0,4099,4241,2340,12724,0,0,0,0,0,0,14993,14994,14994,14994,1,1,1,1,'Tabin Bracers');
INSERT INTO `synth_recipes` VALUES (2590,0,0,0,0,0,0,0,71,0,0,4099,4241,1978,12311,0,0,0,0,0,0,15071,15071,15071,15071,1,1,1,1,'Spartan Hoplon');
INSERT INTO `synth_recipes` VALUES (2591,0,0,0,0,91,0,51,0,0,0,4099,4241,823,828,828,828,1271,1619,0,0,15153,15154,15154,15154,1,1,1,1,'Shair Turban');
INSERT INTO `synth_recipes` VALUES (2592,0,0,0,0,0,0,91,0,41,0,4096,4238,648,664,668,745,794,850,914,0,15155,15156,15156,15156,1,1,1,1,'Barone Zucchetto');
INSERT INTO `synth_recipes` VALUES (2593,0,0,0,0,33,0,0,95,0,0,4099,4241,1117,1163,1163,1619,1619,1623,1629,0,15157,15158,15158,15158,1,1,1,1,'Bison Warbonnet'); -- bison warbonnet (leather 95 cloth 33) https://www.bg-wiki.com/bg/Bison_Warbonnet
INSERT INTO `synth_recipes` VALUES (2594,0,0,0,91,0,0,0,38,0,0,4099,4241,506,790,887,887,887,1163,0,0,15159,15160,15160,15160,1,1,1,1,'Igqira Tiara');
INSERT INTO `synth_recipes` VALUES (2595,0,0,0,0,24,0,0,20,0,0,4099,4241,819,826,840,840,850,0,0,0,15161,15172,15172,15172,1,1,1,1,'Noct Beret');
INSERT INTO `synth_recipes` VALUES (2596,0,0,0,44,0,0,0,0,0,0,4099,4241,1716,15164,0,0,0,0,0,0,15162,15162,15162,15162,1,1,1,1,'Mist Crown');
INSERT INTO `synth_recipes` VALUES (2597,0,0,0,29,0,0,0,20,0,0,4099,4241,819,869,880,927,0,0,0,0,15163,15166,15166,15166,1,1,1,1,'Seers Crown');
INSERT INTO `synth_recipes` VALUES (2598,0,0,0,41,0,0,0,13,0,0,4099,4241,869,894,927,1700,0,0,0,0,15164,15168,15168,15168,1,1,1,1,'Garish Crown');
INSERT INTO `synth_recipes` VALUES (2599,0,0,0,37,0,0,0,24,0,0,4099,4241,1618,1623,1717,0,0,0,0,0,15165,15169,15169,15169,1,1,1,1,'Shade Tiara');
INSERT INTO `synth_recipes` VALUES (2600,0,0,0,0,0,0,13,0,38,0,4096,4238,648,662,662,744,850,914,0,0,15167,15171,15171,15171,1,1,1,1,'Eisenschaller');
INSERT INTO `synth_recipes` VALUES (2601,0,0,0,0,46,0,0,0,0,0,4099,4241,1701,12499,0,0,0,0,0,0,15170,15170,15170,15170,1,1,1,1,'Blink Band');
INSERT INTO `synth_recipes` VALUES (2602,0,0,0,0,51,0,0,0,92,0,4098,4240,666,683,829,1415,1764,0,0,0,15188,15187,15187,15187,1,1,1,1,'Hachiman Jinpachi');
INSERT INTO `synth_recipes` VALUES (2603,0,0,0,0,0,0,83,0,0,0,4096,4238,745,745,914,12419,0,0,0,0,15189,15193,15193,15193,1,1,1,1,'Lords Armet');
INSERT INTO `synth_recipes` VALUES (2604,0,0,0,0,40,0,0,88,0,0,4099,4241,822,828,829,1117,1767,0,0,0,15190,15191,15191,15191,1,1,1,1,'Wise Cap');
INSERT INTO `synth_recipes` VALUES (2605,0,0,0,78,43,0,0,33,0,0,4099,4241,793,793,820,855,869,1622,1829,1866,15201,15201,15201,15201,1,1,1,1,'Quadav Barbut'); -- quadav barbut (bone 78, cloth 43, leather 33) https://www.bg-wiki.com/bg/Quadav_Barbut
INSERT INTO `synth_recipes` VALUES (2606,0,0,0,55,80,0,0,50,0,0,4099,4241,793,793,820,841,841,854,1622,1867,15202,15202,15202,15202,1,1,1,1,'Yagudo Headgear');
INSERT INTO `synth_recipes` VALUES (2607,0,0,0,0,27,0,0,75,38,0,4099,4241,666,826,849,850,1109,1109,1651,1868,15203,15203,15203,15203,1,1,1,1,'Goblin Coif');
INSERT INTO `synth_recipes` VALUES (2608,0,0,0,0,0,0,55,0,62,0,4096,4238,648,664,670,682,850,0,0,0,15205,15206,15206,15206,1,1,1,1,'Alumine Salade');
INSERT INTO `synth_recipes` VALUES (2609,0,0,0,0,22,0,0,9,0,0,4099,4241,825,850,913,1828,1829,1829,0,0,15207,15208,15208,15208,1,1,1,1,'Traders Chapeau');
INSERT INTO `synth_recipes` VALUES (2610,0,0,0,99,0,0,0,52,47,0,4099,4241,664,823,855,862,1841,0,0,0,15209,15210,15210,15210,1,1,1,1,'Unicorn Cap'); -- unicorn cap (bone 99 leather 52 smith 47) https://www.bg-wiki.com/bg/Unicorn_Cap
INSERT INTO `synth_recipes` VALUES (2611,0,0,0,80,0,0,0,0,0,0,4098,4240,1715,12508,0,0,0,0,0,0,15211,15211,15211,15211,1,1,1,1,'Reraise Hairpin');
INSERT INTO `synth_recipes` VALUES (2612,0,0,0,0,66,0,0,57,0,0,4099,4241,823,828,828,845,847,850,0,0,15242,15243,15243,15243,1,1,1,1,'Crow Beret');
INSERT INTO `synth_recipes` VALUES (2613,0,0,0,7,0,0,0,0,0,0,4098,4240,2141,12505,0,0,0,0,0,0,15268,15268,15268,15268,1,1,1,1,'Eld. Bone Hairpin');
INSERT INTO `synth_recipes` VALUES (2614,0,0,0,32,0,0,0,0,0,0,4098,4240,2142,12507,0,0,0,0,0,0,15269,15269,15269,15269,1,1,1,1,'Eld. Horn Hairpin');
INSERT INTO `synth_recipes` VALUES (2615,0,0,0,0,0,0,0,10,21,0,4099,4241,850,1654,1654,1655,0,0,0,0,15288,15288,15288,15288,1,1,1,1,'Pellet Belt');
INSERT INTO `synth_recipes` VALUES (2616,0,0,0,0,0,0,0,10,0,25,4099,4241,715,715,850,1211,1211,1655,0,0,15289,15289,15289,15289,1,1,1,1,'Bolt Belt');
INSERT INTO `synth_recipes` VALUES (2617,0,0,0,0,0,0,0,46,0,0,4099,4241,873,13200,0,0,0,0,0,0,15290,15290,15290,15290,1,1,1,1,'Haste Belt');
INSERT INTO `synth_recipes` VALUES (2618,0,0,0,0,38,0,60,92,0,0,4099,4241,747,823,828,855,855,1629,0,0,15303,15304,15304,15304,1,1,1,1,'Shair Crackows'); -- sha'ir crackows (leath 92 gold 60 cloth 38) https://www.bg-wiki.com/bg/Sha%27ir_Crackows
INSERT INTO `synth_recipes` VALUES (2619,0,0,0,0,0,0,89,38,45,0,4096,4238,668,668,745,754,914,1629,1629,0,15305,15306,15306,15306,1,1,1,1,'Barone Gambieras');
INSERT INTO `synth_recipes` VALUES (2620,0,0,0,0,29,0,0,93,0,0,4099,4241,1117,1163,1163,1619,1629,1629,0,0,15307,15308,15308,15308,1,1,1,1,'Bison Gamashes'); -- bison gamashes (leather 93 cloth 29) https://www.bg-wiki.com/bg/Bison_Gamashes
INSERT INTO `synth_recipes` VALUES (2621,0,0,0,95,0,0,0,50,0,0,4099,4241,506,927,1622,1680,1719,0,0,0,15309,15310,15310,15310,1,1,1,1,'Igqira Huaraches'); -- igqira huaraches (bone 95 leather 50) https://www.bg-wiki.com/bg/Igqira_Huaraches
INSERT INTO `synth_recipes` VALUES (2622,0,0,0,0,27,0,0,20,0,0,4099,4241,826,826,826,850,850,0,0,0,15311,14207,14207,14207,1,1,1,1,'Noct Gaiters');
INSERT INTO `synth_recipes` VALUES (2623,0,0,0,0,0,0,0,40,0,0,4099,4241,870,15314,0,0,0,0,0,0,15312,15312,15312,15312,1,1,1,1,'Mist Pumps');
INSERT INTO `synth_recipes` VALUES (2624,0,0,0,0,20,0,0,25,0,0,4099,4241,820,820,825,825,850,0,0,0,15313,15316,15316,15316,1,1,1,1,'Seers Pumps');
INSERT INTO `synth_recipes` VALUES (2625,0,0,0,0,28,0,0,37,0,0,4099,4241,850,1699,1699,1700,1700,0,0,0,15314,15318,15318,15318,1,1,1,1,'Garish Pumps');
INSERT INTO `synth_recipes` VALUES (2626,0,0,0,40,23,0,0,24,0,0,4099,4241,529,852,855,855,1618,1623,1717,0,15315,15319,15319,15319,1,1,1,1,'Shade Leggings'); -- shade leggings (bone 40, leather 24, cloth 23) https://www.bg-wiki.com/bg/Shade_Leggings
INSERT INTO `synth_recipes` VALUES (2627,0,0,0,0,0,0,2,14,41,0,4096,4238,662,662,744,848,850,914,0,0,15317,15321,15321,15321,1,1,1,1,'Eisenschuhs'); -- eisenschuhs (smith 41 leath 14 gold ??) https://www.bg-wiki.com/bg/Eisenschuhs
INSERT INTO `synth_recipes` VALUES (2628,0,0,0,0,0,0,0,45,0,0,4099,4241,872,12955,0,0,0,0,0,0,15320,15320,15320,15320,1,1,1,1,'Powder Boots');
INSERT INTO `synth_recipes` VALUES (2629,0,0,0,0,56,0,0,99,0,0,4099,4241,823,828,855,1163,1767,0,0,0,15329,15331,15331,15331,1,1,1,1,'Blessed Pumps'); -- blessed pumps (leath 99 cloth 56) https://www.bg-wiki.com/bg/Blessed_Pumps
INSERT INTO `synth_recipes` VALUES (2630,0,0,0,0,47,0,51,0,95,0,4096,4238,655,664,664,745,821,828,855,914,15330,15332,15332,15332,1,1,1,1,'Hmn. Sune-ate');
INSERT INTO `synth_recipes` VALUES (2631,0,0,0,0,0,0,85,0,0,0,4096,4238,745,914,12931,0,0,0,0,0,15333,15337,15337,15337,1,1,1,1,'Lords Sabatons');
INSERT INTO `synth_recipes` VALUES (2632,0,0,0,0,34,0,0,85,0,0,4099,4241,823,828,850,855,1767,0,0,0,15334,15335,15335,15335,1,1,1,1,'Wise Pigaches'); -- wise pigaches (leath 85 cloth 34) https://www.bg-wiki.com/bg/Wise_Pigaches
INSERT INTO `synth_recipes` VALUES (2633,0,0,0,0,0,0,0,0,94,0,4096,4238,664,664,1705,12958,0,0,0,0,15339,15340,15340,15340,1,1,1,1,'Black Sollerets');
INSERT INTO `synth_recipes` VALUES (2634,0,0,0,0,0,0,0,0,57,0,4099,4241,664,670,12936,0,0,0,0,0,15341,15342,15342,15342,1,1,1,1,'Alumine Sollerets');
INSERT INTO `synth_recipes` VALUES (2635,0,0,0,0,21,0,0,26,0,0,4099,4241,848,850,1828,1829,1829,0,0,0,15343,15344,15344,15344,1,1,1,1,'Traders Pigaches'); -- trader's pigaches (leather 26 cloth 21) https://www.bg-wiki.com/bg/Trader's_Pigaches
INSERT INTO `synth_recipes` VALUES (2636,0,0,0,97,0,0,0,55,0,0,4099,4241,823,862,862,866,1841,0,0,0,15345,15346,15346,15346,1,1,1,1,'Unicorn Leggings'); -- unicorn leggings (bone 97 leather 55) https://www.bg-wiki.com/bg/Unicorn_Leggings
INSERT INTO `synth_recipes` VALUES (2637,0,0,0,0,97,0,0,0,0,0,4099,4241,823,823,828,830,1769,0,0,0,15391,15393,15393,15393,1,1,1,1,'Blessed Trousers');
INSERT INTO `synth_recipes` VALUES (2638,0,0,0,0,93,0,0,0,48,0,4099,4241,682,682,823,828,1699,1764,0,0,15392,15394,15394,15394,1,1,1,1,'Hachiman Hakama');
INSERT INTO `synth_recipes` VALUES (2639,0,0,0,0,0,0,81,0,0,0,4096,4238,745,745,914,12803,0,0,0,0,15395,15399,15399,15399,1,1,1,1,'Lords Cuisses');
INSERT INTO `synth_recipes` VALUES (2640,0,0,0,0,37,0,0,84,0,0,4099,4241,822,822,828,828,1623,1767,0,0,15396,15397,15397,15397,1,1,1,1,'Wise Braconi'); -- wise braconi (leath 84 cloth 37) https://www.bg-wiki.com/bg/Wise_Braconi
INSERT INTO `synth_recipes` VALUES (2641,0,0,0,0,0,0,0,15,93,0,4096,4238,664,855,855,1705,0,0,0,0,15400,15401,15401,15401,1,1,1,1,'Black Cuisses');
INSERT INTO `synth_recipes` VALUES (2642,0,0,0,0,0,0,0,48,61,0,4099,4241,682,684,826,851,851,0,0,0,15402,15403,15403,15403,1,1,1,1,'Alumine Brayettes');
INSERT INTO `synth_recipes` VALUES (2643,0,0,0,0,24,0,0,9,0,0,4099,4241,825,825,850,1828,1829,0,0,0,15404,15405,15405,15405,1,1,1,1,'Traders Slops');
INSERT INTO `synth_recipes` VALUES (2644,0,0,0,92,0,0,0,58,0,0,4099,4241,862,1279,1841,0,0,0,0,0,15406,15407,15407,15407,1,1,1,1,'Unicorn Subligar'); -- unicorn subligar (bone 92 leath 58) https://www.bg-wiki.com/bg/Unicorn_Subligar
INSERT INTO `synth_recipes` VALUES (2645,0,0,0,0,0,0,0,20,0,0,4099,4241,850,937,1655,1830,0,0,0,0,15453,15453,15453,15453,1,1,1,1,'Lugworm Belt');
INSERT INTO `synth_recipes` VALUES (2646,0,0,0,0,0,0,0,20,0,0,4099,4241,850,937,1655,1831,0,0,0,0,15454,15454,15454,15454,1,1,1,1,'Little Worm Belt');
INSERT INTO `synth_recipes` VALUES (2647,0,0,0,0,73,0,0,0,0,0,4099,4241,1967,13206,0,0,0,0,0,0,15459,15459,15459,15459,1,1,1,1,'Sagac. Gold Obi');
INSERT INTO `synth_recipes` VALUES (2648,0,0,0,0,73,0,0,0,0,0,4099,4241,1966,13206,0,0,0,0,0,0,15460,15460,15460,15460,1,1,1,1,'Deduct. Gold Obi');
INSERT INTO `synth_recipes` VALUES (2649,0,0,0,0,73,0,0,0,0,0,4099,4241,1968,13206,0,0,0,0,0,0,15461,15461,15461,15461,1,1,1,1,'Enthrall. Gold Obi');
INSERT INTO `synth_recipes` VALUES (2650,0,0,0,0,83,0,0,0,0,0,4099,4241,1967,13207,0,0,0,0,0,0,15462,15462,15462,15462,1,1,1,1,'Sagac. Broc. Obi');
INSERT INTO `synth_recipes` VALUES (2651,0,0,0,0,21,0,0,0,0,0,4099,4241,2138,13584,0,0,0,0,0,0,15485,15485,15485,15485,1,1,1,1,'Talisman Cape');
INSERT INTO `synth_recipes` VALUES (2652,0,0,0,0,0,0,0,30,0,0,4097,4239,2139,13588,0,0,0,0,0,0,15486,15486,15486,15486,1,1,1,1,'Breath Mantle');
INSERT INTO `synth_recipes` VALUES (2653,0,0,0,0,0,0,0,52,0,0,4097,4239,2140,13570,0,0,0,0,0,0,15487,15487,15487,15487,1,1,1,1,'High Brth. Mantle');
INSERT INTO `synth_recipes` VALUES (2654,0,2008,0,0,41,0,0,0,0,0,4099,4241,2231,2232,13075,0,0,0,0,0,15526,15526,15526,15526,1,1,1,1,'Regen Collar');
INSERT INTO `synth_recipes` VALUES (2655,0,0,0,98,0,0,0,0,0,0,4099,4241,2172,2304,0,0,0,0,0,0,15539,15540,15540,15540,1,1,1,1,'Orochi Nodowa');
INSERT INTO `synth_recipes` VALUES (2656,0,0,0,0,0,0,38,0,0,0,4099,4241,2136,13444,0,0,0,0,0,0,15558,15558,15558,15558,1,1,1,1,'Mighty Ring');
INSERT INTO `synth_recipes` VALUES (2657,0,0,0,0,0,0,38,0,0,0,4099,4241,2137,13471,0,0,0,0,0,0,15559,15559,15559,15559,1,1,1,1,'Vision Ring');
INSERT INTO `synth_recipes` VALUES (2658,0,0,0,0,46,0,0,63,0,0,4099,4241,823,828,850,855,855,0,0,0,15578,15579,15579,15579,1,1,1,1,'Crow Hose'); -- crow hose (leath 63 cloth 46) https://www.bg-wiki.com/bg/Crow_Hose
INSERT INTO `synth_recipes` VALUES (2659,0,0,0,0,82,0,41,53,0,0,4099,4241,681,2152,2166,2288,2288,2289,0,0,15603,15607,15607,15607,1,1,1,1,'Sipahi Zerehs');
INSERT INTO `synth_recipes` VALUES (2660,0,0,0,0,61,0,0,53,35,0,4099,4241,666,879,2166,2288,2288,0,0,0,15605,15608,15608,15608,1,1,1,1,'Jaridah Salvars'); -- jaridah salvars (cloth 61 smith 35, leath ??) https://www.bg-wiki.com/bg/Jaridah_Salvars
INSERT INTO `synth_recipes` VALUES (2661,0,2016,0,0,0,0,0,12,0,0,4099,4241,2230,2232,12824,0,0,0,0,0,15610,15610,15610,15610,1,1,1,1,'Sturdy Trousers');
INSERT INTO `synth_recipes` VALUES (2662,0,2009,0,0,18,0,0,0,0,0,4099,4241,2230,2231,12864,0,0,0,0,0,15611,15611,15611,15611,1,1,1,1,'Sturdy Slacks');
INSERT INTO `synth_recipes` VALUES (2663,0,0,0,96,0,0,0,15,0,0,4099,4241,821,1586,2172,12824,0,0,0,0,15615,15616,15616,15616,1,1,1,1,'Hydra Cuisses'); -- hydra cuisses (bone 96 leather 15) https://www.bg-wiki.com/bg/Hydra_Cuisses
INSERT INTO `synth_recipes` VALUES (2664,0,0,0,0,74,0,0,6,0,0,4099,4241,879,1699,1700,2340,2340,0,0,0,15618,15619,15619,15619,1,1,1,1,'Vendors Slops');
INSERT INTO `synth_recipes` VALUES (2665,0,0,0,0,67,0,43,0,0,0,4099,4241,752,823,828,2340,2340,0,0,0,15620,15621,15621,15621,1,1,1,1,'Silken Slops');
INSERT INTO `synth_recipes` VALUES (2666,0,0,0,0,54,0,0,97,0,0,4099,4241,855,1117,1629,1629,2372,2372,2372,2372,15645,15646,15646,15646,1,1,1,1,'Khimaira Kecks'); -- khimaira kecks (leather 97 cloth 54) https://www.bg-wiki.com/bg/Khimaira_Kecks
INSERT INTO `synth_recipes` VALUES (2667,0,0,0,51,0,0,0,0,0,0,4099,4241,2420,12837,0,0,0,0,0,0,15650,15650,15650,15650,1,1,1,1,'Shock Subligar');
INSERT INTO `synth_recipes` VALUES (2668,0,0,0,0,0,0,0,57,0,0,4099,4241,2423,12828,0,0,0,0,0,0,15651,15651,15651,15651,1,1,1,1,'Ice Trousers');
INSERT INTO `synth_recipes` VALUES (2669,0,0,0,0,52,0,0,0,0,0,4099,4241,2424,12851,0,0,0,0,0,0,15652,15652,15652,15652,1,1,1,1,'Blaze Hose');
INSERT INTO `synth_recipes` VALUES (2670,0,0,0,0,0,0,0,76,0,0,4099,4241,2152,12852,0,0,0,0,0,0,15653,15654,15654,15654,1,1,1,1,'Tabin Hose');
INSERT INTO `synth_recipes` VALUES (2671,0,0,0,0,49,0,0,56,0,0,4099,4241,823,828,828,828,850,851,855,0,15663,15664,15664,15664,1,1,1,1,'Crow Gaiters'); -- crow gaiters (leath 56 cloth 49) https://www.bg-wiki.com/bg/Crow_Gaiters
INSERT INTO `synth_recipes` VALUES (2672,0,0,0,0,31,0,76,48,0,0,4099,4241,663,663,663,879,2152,2152,2289,0,15687,15693,15693,15693,1,1,1,1,'Sipahi Boots'); -- sipahi boots (gold 76 leather 48 cloth 31) https://www.bg-wiki.com/bg/Sipahi_Boots
INSERT INTO `synth_recipes` VALUES (2673,0,0,0,0,54,0,0,32,66,0,4099,4241,666,879,2152,2166,2288,0,0,0,15689,15694,15694,15694,1,1,1,1,'Jaridah Nails'); -- jaridah nails (smith 66 cloth ?? leath ??) https://www.bg-wiki.com/bg/Jaridah_Nails
INSERT INTO `synth_recipes` VALUES (2674,0,0,0,66,0,0,0,22,0,0,4099,4241,879,879,2146,2147,0,0,0,0,15696,15697,15697,15697,1,1,1,1,'Marid Leggings'); -- marid leggings (bone 66 leath 22) https://www.bg-wiki.com/bg/Marid_Leggings
INSERT INTO `synth_recipes` VALUES (2675,0,0,0,100,0,0,0,0,0,0,4099,4241,821,1586,2172,12952,0,0,0,0,15703,15704,15704,15704,1,1,1,1,'Hydra Greaves'); -- hydra greaves (bone 100) https://www.bg-wiki.com/bg/Hydra_Greaves
INSERT INTO `synth_recipes` VALUES (2676,0,0,0,0,45,0,0,71,0,0,4099,4241,823,853,855,855,2340,0,0,0,15706,15707,15707,15707,1,1,1,1,'Silken Pigaches'); -- silken pigaches (leath 71 cloth 45) https://www.bg-wiki.com/bg/Silken_Pigaches
INSERT INTO `synth_recipes` VALUES (2677,0,0,0,89,0,0,0,0,0,0,4099,4241,2358,12948,0,0,0,0,0,0,15708,15708,15708,15708,1,1,1,1,'Earth Greaves');
INSERT INTO `synth_recipes` VALUES (2678,0,0,0,0,29,0,0,93,0,0,4099,4241,1117,1619,1629,1629,2372,2372,0,0,15731,15732,15732,15732,1,1,1,1,'Khimaira Gamash.'); -- khimaira gamashes (leath 93 cloth 29) https://www.bg-wiki.com/bg/Khimaira_Gamash.
INSERT INTO `synth_recipes` VALUES (2679,0,0,0,0,0,0,0,69,0,0,4099,4241,2152,12980,0,0,0,0,0,0,15738,15739,15739,15739,1,1,1,1,'Tabin Boots');
INSERT INTO `synth_recipes` VALUES (2680,0,0,0,0,0,0,99,0,0,0,4096,4238,747,2275,0,0,0,0,0,0,15771,15772,15772,15772,1,1,1,1,'Shining Ring');
INSERT INTO `synth_recipes` VALUES (2681,0,0,0,98,0,0,0,0,0,0,4098,4240,2168,2168,0,0,0,0,0,0,15780,15781,15781,15781,1,1,1,1,'Cerberus Ring');
INSERT INTO `synth_recipes` VALUES (2682,0,0,0,10,0,0,0,0,0,0,4098,4240,2234,13442,0,0,0,0,0,0,15782,15782,15782,15782,1,1,1,1,'Manashell Ring');
INSERT INTO `synth_recipes` VALUES (2683,0,0,0,0,0,0,0,25,0,0,4098,4240,872,13469,0,0,0,0,0,0,15783,15783,15783,15783,1,1,1,1,'Armored Ring');
INSERT INTO `synth_recipes` VALUES (2684,0,0,0,81,0,0,0,0,0,0,4098,4240,2147,2147,0,0,0,0,0,0,15788,15789,15789,15789,1,1,1,1,'Marid Ring');
INSERT INTO `synth_recipes` VALUES (2685,0,0,0,0,0,0,35,0,0,0,4099,4241,1766,13327,0,0,0,0,0,0,15801,15802,15802,15802,1,1,1,1,'Tigereye Ring');
INSERT INTO `synth_recipes` VALUES (2686,0,0,0,0,0,0,100,0,0,0,4099,4241,1271,13466,0,0,0,0,0,0,15803,15804,15804,15804,1,1,1,1,'Crimson Ring');
INSERT INTO `synth_recipes` VALUES (2687,0,0,0,0,0,0,100,0,0,0,4099,4241,2359,13466,0,0,0,0,0,0,15805,15806,15806,15806,1,1,1,1,'Star Ring');
INSERT INTO `synth_recipes` VALUES (2688,0,0,0,92,0,0,0,0,0,0,4098,4240,2418,2426,2426,0,0,0,0,0,15811,15812,15812,15812,1,1,1,1,'Wivre Ring');
INSERT INTO `synth_recipes` VALUES (2689,1,0,0,96,0,0,0,0,0,0,4100,4242,15813,0,0,0,0,0,0,0,5466,5466,5466,5466,1,1,1,1,'Trumpet Shell'); -- desynth trumpet ring (bone 96) http://ffxiclopedia.wikia.com/wiki/Trumpet_Ring
INSERT INTO `synth_recipes` VALUES (2690,0,0,0,96,0,0,0,0,0,0,4098,4240,5466,5466,0,0,0,0,0,0,15813,15814,15814,15814,1,1,1,1,'Trumpet Ring'); -- trumpet ring (bone 96) https://www.bg-wiki.com/bg/Trumpet_Ring
INSERT INTO `synth_recipes` VALUES (2691,0,0,0,65,0,0,0,0,0,0,4098,4240,2506,2506,0,0,0,0,0,0,15815,15816,15816,15816,1,1,1,1,'Ladybug Ring');
INSERT INTO `synth_recipes` VALUES (2692,0,0,0,0,83,0,0,0,0,0,4099,4241,1966,13207,0,0,0,0,0,0,15861,15861,15861,15861,1,1,1,1,'Deduct. Broc. Obi');
INSERT INTO `synth_recipes` VALUES (2693,0,0,0,0,83,0,0,0,0,0,4099,4241,1968,13207,0,0,0,0,0,0,15862,15862,15862,15862,1,1,1,1,'Enthrall. Broc. Obi');
INSERT INTO `synth_recipes` VALUES (2694,0,0,0,0,0,0,0,44,0,0,4099,4241,1969,13203,0,0,0,0,0,0,15863,15863,15863,15863,1,1,1,1,'Samsonian Belt');
INSERT INTO `synth_recipes` VALUES (2695,0,0,0,0,0,0,0,44,0,0,4099,4241,1970,13203,0,0,0,0,0,0,15864,15864,15864,15864,1,1,1,1,'Tough Belt');
INSERT INTO `synth_recipes` VALUES (2696,0,0,0,0,0,0,0,44,0,0,4099,4241,1971,13203,0,0,0,0,0,0,15865,15865,15865,15865,1,1,1,1,'Runners Belt');
INSERT INTO `synth_recipes` VALUES (2697,0,0,0,0,0,0,0,44,0,0,4099,4241,1972,13203,0,0,0,0,0,0,15866,15866,15866,15866,1,1,1,1,'Acrobats Belt');
INSERT INTO `synth_recipes` VALUES (2698,0,0,0,0,0,0,0,93,0,0,4099,4241,1969,13197,0,0,0,0,0,0,15867,15867,15867,15867,1,1,1,1,'Sultans Belt'); -- sultan's belt (leath 93) https://www.bg-wiki.com/bg/Sultan%27s_Belt
INSERT INTO `synth_recipes` VALUES (2699,0,0,0,0,0,0,0,93,0,0,4099,4241,1970,13197,0,0,0,0,0,0,15868,15868,15868,15868,1,1,1,1,'Czars Belt'); -- czar's belt (leath 93) https://www.bg-wiki.com/bg/Czar%27s_Belt
INSERT INTO `synth_recipes` VALUES (2700,0,0,0,0,0,0,0,93,0,0,4099,4241,1971,13197,0,0,0,0,0,0,15869,15869,15869,15869,1,1,1,1,'Pendragons Belt'); -- pendragon's belt (leath 93) https://www.bg-wiki.com/bg/Pendragon%27s_Belt
INSERT INTO `synth_recipes` VALUES (2701,0,0,0,0,0,0,0,93,0,0,4099,4241,1972,13197,0,0,0,0,0,0,15870,15870,15870,15870,1,1,1,1,'Maharajas Belt'); -- maharaja's belt (leath 93) https://www.bg-wiki.com/bg/Maharaja%27s_Belt
INSERT INTO `synth_recipes` VALUES (2702,0,0,0,0,30,0,0,0,0,0,4099,4241,2138,13204,0,0,0,0,0,0,15881,15881,15881,15881,1,1,1,1,'Talisman Obi');
INSERT INTO `synth_recipes` VALUES (2703,0,2016,0,0,0,0,0,16,0,0,4098,4240,2230,2232,13192,0,0,0,0,0,15889,15889,15889,15889,1,1,1,1,'Augmenting Belt');
INSERT INTO `synth_recipes` VALUES (2704,0,0,0,0,0,0,0,81,0,0,4099,4241,682,2152,2152,0,0,0,0,0,15890,15893,15893,15893,1,1,1,1,'Marid Belt');
INSERT INTO `synth_recipes` VALUES (2705,0,0,0,0,99,0,0,0,0,0,4099,4241,821,823,2166,2166,2287,2304,0,0,15891,15892,15892,15892,1,1,1,1,'Al Zahbi Sash');
INSERT INTO `synth_recipes` VALUES (2706,0,0,0,0,39,0,0,0,0,0,4099,4241,1828,1829,2274,0,0,0,0,0,15905,15906,15906,15906,1,1,1,1,'Mohbwa Sash');
INSERT INTO `synth_recipes` VALUES (2707,0,0,0,0,59,0,0,0,0,0,4099,4241,1699,1828,2288,0,0,0,0,0,15907,15908,15908,15908,1,1,1,1,'Qiqirn Sash');
INSERT INTO `synth_recipes` VALUES (2708,0,0,0,0,0,0,0,83,0,0,4098,4240,680,2538,0,0,0,0,0,0,15913,15914,15914,15914,1,1,1,1,'Peiste Belt');
INSERT INTO `synth_recipes` VALUES (2709,0,0,0,0,0,0,0,95,0,0,4099,4241,817,2523,2523,0,0,0,0,0,16233,16234,16234,16234,1,1,1,1,'Peiste Mantle'); -- Peiste Mantle (leather 95) https://www.bg-wiki.com/bg/Peiste_Mantle
INSERT INTO `synth_recipes` VALUES (2710,0,0,0,0,0,0,0,85,0,0,4097,4239,820,2512,0,0,0,0,0,0,16235,16236,16236,16236,1,1,1,1,'Lynx Mantle');
INSERT INTO `synth_recipes` VALUES (2711,0,0,0,0,0,0,90,0,0,0,4099,4241,2359,13329,0,0,0,0,0,0,15991,15992,15992,15992,1,1,1,1,'Star Earring');
INSERT INTO `synth_recipes` VALUES (2712,0,0,0,0,0,0,90,0,0,0,4099,4241,1271,13329,0,0,0,0,0,0,15993,15994,15994,15994,1,1,1,1,'Crimson Earring');
INSERT INTO `synth_recipes` VALUES (2713,0,0,0,75,0,0,0,0,0,0,4098,4240,2506,2551,0,0,0,0,0,0,15996,15997,15997,15997,1,1,1,1,'Ladybug Earring'); -- ladybug earring (bone 75) https://www.bg-wiki.com/bg/Ladybug_Earring
INSERT INTO `synth_recipes` VALUES (2714,0,0,0,0,85,0,45,0,0,0,4099,4241,761,2166,2289,2289,0,0,0,0,16061,16067,16067,16067,1,1,1,1,'Sipahi Turban');
INSERT INTO `synth_recipes` VALUES (2715,0,0,0,0,25,0,0,64,0,0,4099,4241,879,2152,2166,2288,0,0,0,0,16063,16068,16068,16068,1,1,1,1,'Jaridah Khud'); -- jaridah khud (leath 64 cloth 25) https://www.bg-wiki.com/bg/Jaridah_Khud
INSERT INTO `synth_recipes` VALUES (2716,0,2008,0,0,25,0,0,0,0,0,4099,4241,2231,2232,15207,0,0,0,0,0,16078,16078,16078,16078,1,1,1,1,'Blissful Chapeau');
INSERT INTO `synth_recipes` VALUES (2717,0,0,0,0,65,0,38,0,0,0,4099,4241,752,822,828,2340,2340,0,0,0,16079,16080,16080,16080,1,1,1,1,'Silken Hat');
INSERT INTO `synth_recipes` VALUES (2718,0,0,0,0,33,0,0,95,0,0,4099,4241,1117,1619,1619,1623,1629,2372,2372,0,16104,16105,16105,16105,1,1,1,1,'Khimaira Bonnet'); -- khimaira bonnet (leather 95 cloth 33) https://www.bg-wiki.com/bg/Khimaira_Bonnet
INSERT INTO `synth_recipes` VALUES (2719,0,0,0,0,0,0,0,0,34,0,4102,4244,12522,0,0,0,0,0,0,0,16110,16110,16110,16110,1,1,1,1,'Plain Cap');
INSERT INTO `synth_recipes` VALUES (2720,0,0,0,0,79,0,0,0,0,0,4099,4241,2340,12468,0,0,0,0,0,0,16111,16112,16112,16112,1,1,1,1,'Tabin Beret');
INSERT INTO `synth_recipes` VALUES (2721,0,0,0,0,0,0,0,87,0,0,4099,4241,852,879,884,884,927,2162,2166,0,16121,16121,16121,16121,1,1,1,1,'Mamool Ja Helm');
INSERT INTO `synth_recipes` VALUES (2722,0,0,0,0,0,0,0,82,0,0,4099,4241,879,879,1163,2152,2166,2274,0,0,16122,16122,16122,16122,1,1,1,1,'Troll Coif');
INSERT INTO `synth_recipes` VALUES (2723,0,0,0,83,0,0,49,31,0,0,4098,4240,764,790,877,1618,2418,0,0,0,16123,16123,16123,16123,1,1,1,1,'Lamia Garland'); -- lamia garland (bone 83 gold 49 leath 31) https://www.bg-wiki.com/bg/Lamia_Garland
INSERT INTO `synth_recipes` VALUES (2724,0,0,0,0,76,0,0,0,0,0,4099,4241,648,795,795,827,827,927,1196,0,16124,16124,16124,16124,1,1,1,1,'Qiqirn Hood');
INSERT INTO `synth_recipes` VALUES (2725,0,0,0,85,0,0,0,0,0,0,4098,4240,2427,0,0,0,0,0,0,0,16128,16129,16129,16129,1,1,1,1,'Wivre Hairpin');
INSERT INTO `synth_recipes` VALUES (2726,0,0,0,0,0,0,0,87,0,0,4098,4240,879,2428,0,0,0,0,0,0,16130,16131,16131,16131,1,1,1,1,'Wivre Mask');
INSERT INTO `synth_recipes` VALUES (2727,0,0,0,0,0,0,0,0,96,0,4099,4241,2303,2303,16166,0,0,0,0,0,16161,16163,16163,16163,1,1,1,1,'Januwiyah');
INSERT INTO `synth_recipes` VALUES (2728,0,0,0,0,0,0,0,86,0,0,4099,4241,2152,2166,16167,0,0,0,0,0,16162,16164,16164,16164,1,1,1,1,'Tariqah');
INSERT INTO `synth_recipes` VALUES (2729,0,0,0,0,0,0,0,81,56,0,4099,4241,664,664,664,715,2428,2428,0,0,16170,16171,16171,16171,1,1,1,1,'Wivre Shield'); -- wivre shield (leath 81 smith ~56) https://www.bg-wiki.com/bg/Wivre_Shield
INSERT INTO `synth_recipes` VALUES (2730,0,0,0,0,0,0,0,79,0,0,4097,4239,2151,2287,0,0,0,0,0,0,16211,16215,16215,16215,1,1,1,1,'Marid Mantle');
INSERT INTO `synth_recipes` VALUES (2731,0,0,0,0,0,0,0,95,0,0,4097,4239,2169,2287,0,0,0,0,0,0,16212,16216,16216,16216,1,1,1,1,'Cerberus Mantle');
INSERT INTO `synth_recipes` VALUES (2732,0,0,0,0,0,0,0,74,0,0,4099,4241,876,1869,2296,0,0,0,0,0,16213,16214,16214,16214,1,1,1,1,'Lamia Mantle');
INSERT INTO `synth_recipes` VALUES (2733,0,0,0,0,0,55,0,1,0,0,4099,4241,879,1656,4299,4299,4299,4299,0,0,16223,16223,16223,16223,1,1,1,1,'Orange Tank'); -- orange tank (cook 55, leath 1) https://www.bg-wiki.com/bg/Orange_Tank
INSERT INTO `synth_recipes` VALUES (2734,0,0,0,0,0,66,0,24,0,0,4099,4241,879,1656,4300,4300,4300,4300,0,0,16224,16224,16224,16224,1,1,1,1,'Apple Tank');
INSERT INTO `synth_recipes` VALUES (2735,0,0,0,0,0,76,0,49,0,0,4099,4241,879,1656,4301,4301,4301,4301,0,0,16225,16225,16225,16225,1,1,1,1,'Pear Tank');
INSERT INTO `synth_recipes` VALUES (2736,0,0,0,0,0,85,0,37,0,0,4099,4241,879,1656,4302,4302,4302,4302,0,0,16226,16226,16226,16226,1,1,1,1,'Pamama Tank');
INSERT INTO `synth_recipes` VALUES (2737,0,0,0,0,0,95,0,12,0,0,4099,4241,879,1656,4303,4303,4303,4303,0,0,16227,16227,16227,16227,1,1,1,1,'Persikos Tank'); -- persikos tank (cook 95, leath ~12) http://ffxi.gamerescape.com/wiki/Talk:Persikos_Tank
INSERT INTO `synth_recipes` VALUES (2738,0,0,0,0,0,0,0,75,0,0,4097,4239,820,2518,0,0,0,0,0,0,16231,16232,16232,16232,1,1,1,1,'Smilodon Mantle');
INSERT INTO `synth_recipes` VALUES (2739,0,0,0,0,0,0,0,0,0,60,4101,4243,8816,0,0,0,0,0,0,0,3589,3589,3589,3589,1,1,1,1,'White Viola Pot'); -- white viola (kit)
INSERT INTO `synth_recipes` VALUES (2740,0,0,0,0,55,0,0,0,0,0,4099,4241,826,2274,2296,0,0,0,0,0,16261,16262,16262,16262,1,1,1,1,'Mohbwa Scarf');
INSERT INTO `synth_recipes` VALUES (2741,0,0,0,60,0,0,0,0,0,0,4099,4241,1193,1311,2171,2171,2171,2171,2296,2427,16263,16264,16264,16264,1,1,1,1,'Beak Necklace');
INSERT INTO `synth_recipes` VALUES (2742,0,0,0,86,0,0,0,0,0,0,4098,4240,879,2426,0,0,0,0,0,0,16265,16266,16266,16266,1,1,1,1,'Wivre Gorget');
INSERT INTO `synth_recipes` VALUES (2743,0,0,0,0,0,0,0,3,0,1,4099,4241,715,850,850,0,0,0,0,0,16385,16690,16690,16690,1,1,1,1,'Cesti');
INSERT INTO `synth_recipes` VALUES (2744,0,0,0,0,0,0,0,17,0,0,4099,4241,852,16385,0,0,0,0,0,0,16386,16398,16398,16398,1,1,1,1,'Lizard Cesti');
INSERT INTO `synth_recipes` VALUES (2745,0,0,33,0,0,0,0,0,0,0,4101,4243,937,4157,16386,0,0,0,0,0,16387,16700,16700,16700,1,1,1,1,'Poison Cesti');
INSERT INTO `synth_recipes` VALUES (2746,0,0,0,0,0,0,0,52,0,0,4099,4241,853,16386,0,0,0,0,0,0,16388,16699,16699,16699,1,1,1,1,'Himantes');
INSERT INTO `synth_recipes` VALUES (2747,0,0,0,0,0,0,0,72,0,0,4099,4241,506,16385,0,0,0,0,0,0,16389,17473,17473,17473,1,1,1,1,'Coeurl Cesti');
INSERT INTO `synth_recipes` VALUES (2748,0,0,0,0,0,0,0,0,6,2,4096,4238,649,660,715,0,0,0,0,0,16390,16440,16440,16440,1,1,1,1,'Bronze Knuckles');
INSERT INTO `synth_recipes` VALUES (2749,0,0,0,0,0,0,14,0,0,0,4096,4238,650,16390,0,0,0,0,0,0,16391,16689,16689,16689,1,1,1,1,'Brass Knuckles');
INSERT INTO `synth_recipes` VALUES (2750,0,0,0,0,0,0,0,0,21,1,4096,4238,651,662,714,0,0,0,0,0,16392,16437,16437,16437,1,1,1,1,'Metal Knuckles');
INSERT INTO `synth_recipes` VALUES (2751,0,0,0,0,0,0,0,0,44,12,4096,4238,652,663,710,0,0,0,0,0,16393,16446,16446,16446,1,1,1,1,'Mythril Knuckles');
INSERT INTO `synth_recipes` VALUES (2752,0,0,0,0,0,0,0,0,60,23,4096,4238,654,664,716,0,0,0,0,0,16394,16698,16698,16698,1,1,1,1,'Dst. Knuckles');
INSERT INTO `synth_recipes` VALUES (2753,0,0,0,0,0,0,79,0,51,31,4096,4238,664,717,754,787,787,0,0,0,16395,17480,17480,17480,1,1,1,1,'Diamond Knuckles');
INSERT INTO `synth_recipes` VALUES (2754,0,0,0,0,0,0,36,0,91,0,4096,4238,664,745,914,16395,0,0,0,0,16396,17481,17481,17481,1,1,1,1,'Koenigs Knuckles');
INSERT INTO `synth_recipes` VALUES (2755,0,0,0,0,0,0,0,82,0,0,4099,4241,862,16385,0,0,0,0,0,0,16397,17479,17479,17479,1,1,1,1,'Behemoth Cesti');
INSERT INTO `synth_recipes` VALUES (2756,0,0,0,0,0,0,0,0,37,0,4096,4238,652,652,660,851,0,0,0,0,16399,16695,16695,16695,1,1,1,1,'Katars');
INSERT INTO `synth_recipes` VALUES (2757,0,0,0,0,0,0,0,0,68,0,4096,4238,654,654,662,855,0,0,0,0,16400,17475,17475,17475,1,1,1,1,'Darksteel Katars');
INSERT INTO `synth_recipes` VALUES (2758,0,0,78,0,0,0,0,0,29,0,4096,4238,506,662,931,931,0,0,0,0,16401,17482,17482,17482,1,1,1,1,'Jamadhars');
INSERT INTO `synth_recipes` VALUES (2759,0,0,43,0,0,0,0,0,0,0,4101,4243,937,4157,16399,0,0,0,0,0,16403,16693,16693,16693,1,1,1,1,'Poison Katars');
INSERT INTO `synth_recipes` VALUES (2760,0,0,79,0,0,0,0,0,0,0,4101,4243,937,4158,16400,0,0,0,0,0,16404,17483,17483,17483,1,1,1,1,'Venom Katars');
INSERT INTO `synth_recipes` VALUES (2761,0,0,0,9,0,0,0,0,3,0,4099,4241,660,856,880,880,880,0,0,0,16405,17476,17476,17476,1,1,1,1,'Cat Baghnakhs');
INSERT INTO `synth_recipes` VALUES (2762,0,0,0,0,0,0,0,0,23,0,4096,4238,651,662,0,0,0,0,0,0,16406,16444,16444,16444,1,1,1,1,'Baghnakhs');
INSERT INTO `synth_recipes` VALUES (2763,0,0,0,0,0,0,17,0,0,0,4096,4238,650,16405,0,0,0,0,0,0,16407,16441,16441,16441,1,1,1,1,'Brass Baghnakhs');
INSERT INTO `synth_recipes` VALUES (2764,0,0,35,0,0,0,0,0,0,0,4101,4243,937,4157,16406,0,0,0,0,0,16410,16692,16692,16692,1,1,1,1,'Psn. Baghnakhs');
INSERT INTO `synth_recipes` VALUES (2765,0,0,0,8,0,0,0,0,32,0,4096,4238,652,894,0,0,0,0,0,0,16411,16445,16445,16445,1,1,1,1,'Claws');
INSERT INTO `synth_recipes` VALUES (2766,0,0,0,13,0,0,0,0,48,0,4096,4238,653,894,0,0,0,0,0,0,16412,16688,16688,16688,1,1,1,1,'Mythril Claws');
INSERT INTO `synth_recipes` VALUES (2767,0,0,0,14,0,0,0,0,56,0,4096,4238,654,894,0,0,0,0,0,0,16413,16697,16697,16697,1,1,1,1,'Darksteel Claws');
INSERT INTO `synth_recipes` VALUES (2768,0,0,63,16,0,0,0,0,0,0,4096,4238,894,931,0,0,0,0,0,0,16414,17488,17488,17488,1,1,1,1,'Cermet Claws');
INSERT INTO `synth_recipes` VALUES (2769,0,0,0,90,0,0,0,0,0,0,4099,4241,894,903,903,0,0,0,0,0,16416,17485,17485,17485,1,1,1,1,'Dragon Claws');
INSERT INTO `synth_recipes` VALUES (2770,0,0,38,0,0,0,0,0,0,0,4101,4243,937,4157,16411,0,0,0,0,0,16417,16439,16439,16439,1,1,1,1,'Poison Claws');
INSERT INTO `synth_recipes` VALUES (2771,0,0,72,0,0,0,0,0,0,0,4101,4243,937,4158,16413,0,0,0,0,0,16418,16425,16425,16425,1,1,1,1,'Venom Claws');
INSERT INTO `synth_recipes` VALUES (2772,0,0,0,0,0,0,0,0,51,0,4096,4238,652,652,662,932,0,0,0,0,16419,16696,16696,16696,1,1,1,1,'Patas');
INSERT INTO `synth_recipes` VALUES (2773,0,0,0,68,0,0,0,0,0,0,4096,4238,881,893,893,932,0,0,0,0,16420,17477,17477,17477,1,1,1,1,'Bone Patas');
INSERT INTO `synth_recipes` VALUES (2774,0,0,0,0,0,0,76,0,0,0,4096,4238,745,914,16419,0,0,0,0,0,16421,17489,17489,17489,1,1,1,1,'Gold Patas');
INSERT INTO `synth_recipes` VALUES (2775,0,0,0,79,0,0,0,0,0,0,4096,4238,884,884,896,932,0,0,0,0,16422,17490,17490,17490,1,1,1,1,'Tigerfangs');
INSERT INTO `synth_recipes` VALUES (2776,0,0,0,0,0,0,0,0,98,0,4096,4238,655,655,664,932,0,0,0,0,16423,17518,17518,17518,1,1,1,1,'Manoples');
INSERT INTO `synth_recipes` VALUES (2777,0,0,17,0,0,0,0,0,0,0,4101,4243,937,4162,16407,0,0,0,0,0,16429,16438,16438,16438,1,1,1,1,'Slc. Baghnakhs');
INSERT INTO `synth_recipes` VALUES (2778,0,0,51,0,0,0,0,0,0,0,4101,4243,937,4171,16412,0,0,0,0,0,16430,17487,17487,17487,1,1,1,1,'Acid Claws');
INSERT INTO `synth_recipes` VALUES (2779,0,0,82,0,0,0,0,0,0,0,4101,4243,937,4159,16414,0,0,0,0,0,16431,17486,17486,17486,1,1,1,1,'Stun Claws');
INSERT INTO `synth_recipes` VALUES (2780,0,0,89,0,0,0,0,0,0,0,4101,4243,937,4159,16401,0,0,0,0,0,16432,17484,17484,17484,1,1,1,1,'Stun Jamadhars');
INSERT INTO `synth_recipes` VALUES (2781,0,0,0,0,0,0,0,0,3,0,4096,4238,648,649,0,0,0,0,0,0,16448,16492,16492,16492,1,1,1,1,'Bronze Dagger');
INSERT INTO `synth_recipes` VALUES (2782,0,0,0,0,0,0,13,0,0,0,4096,4238,650,16448,0,0,0,0,0,0,16449,16740,16740,16740,1,1,1,1,'Brass Dagger');
INSERT INTO `synth_recipes` VALUES (2783,0,0,0,0,0,0,0,0,20,0,4096,4238,649,651,0,0,0,0,0,0,16450,16736,16736,16736,1,1,1,1,'Dagger');
INSERT INTO `synth_recipes` VALUES (2784,0,0,0,0,0,0,0,0,15,0,4102,4244,16447,0,0,0,0,0,0,0,16450,16736,16736,16736,1,1,1,1,'Dagger');
INSERT INTO `synth_recipes` VALUES (2785,0,0,0,0,0,0,0,0,30,0,4096,4238,651,653,0,0,0,0,0,0,16451,16738,16738,16738,1,1,1,1,'Mythril Dagger');
INSERT INTO `synth_recipes` VALUES (2786,0,0,0,0,0,0,0,0,92,0,4096,4238,654,655,0,0,0,0,0,0,16452,17620,17620,17620,1,1,1,1,'Misericorde');
INSERT INTO `synth_recipes` VALUES (2787,0,0,0,0,0,0,92,0,41,0,4096,4238,654,747,786,0,0,0,0,0,16453,17992,17992,17992,1,1,1,1,'Orichalcum Dagger');
INSERT INTO `synth_recipes` VALUES (2788,0,0,32,0,0,0,0,0,0,0,4101,4243,937,4163,16448,0,0,0,0,0,16454,16493,16493,16493,1,1,1,1,'Blind Dagger');
INSERT INTO `synth_recipes` VALUES (2789,0,0,0,0,0,0,0,0,25,0,4096,4238,651,652,0,0,0,0,0,0,16455,16737,16737,16737,1,1,1,1,'Baselard');
INSERT INTO `synth_recipes` VALUES (2790,0,0,0,0,0,0,44,0,0,0,4096,4238,652,653,0,0,0,0,0,0,16456,16752,16752,16752,1,1,1,1,'Mythril Baselard');
INSERT INTO `synth_recipes` VALUES (2791,0,0,0,0,0,0,0,0,63,0,4096,4238,653,654,0,0,0,0,0,0,16457,16758,16758,16758,1,1,1,1,'Dst. Baselard');
INSERT INTO `synth_recipes` VALUES (2792,0,0,25,0,0,0,0,0,0,0,4101,4243,937,4157,16455,0,0,0,0,0,16458,16743,16743,16743,1,1,1,1,'Poison Baselard');
INSERT INTO `synth_recipes` VALUES (2793,0,0,62,0,0,0,0,0,0,0,4101,4243,937,4171,16456,0,0,0,0,0,16459,17607,17607,17607,1,1,1,1,'Acid Baselard');
INSERT INTO `synth_recipes` VALUES (2794,0,0,0,0,0,0,11,0,38,0,4096,4238,651,652,793,0,0,0,0,0,16460,16749,16749,16749,1,1,1,1,'Kris');
INSERT INTO `synth_recipes` VALUES (2795,0,0,0,0,0,0,0,0,100,0,4096,4238,655,745,812,0,0,0,0,0,16461,18022,18022,18022,1,1,1,1,'Adaman Kris');
INSERT INTO `synth_recipes` VALUES (2796,0,0,0,0,0,0,0,0,5,0,4096,4238,649,715,0,0,0,0,0,0,16465,16491,16491,16491,1,1,1,1,'Bronze Knife');
INSERT INTO `synth_recipes` VALUES (2797,0,0,0,0,0,0,0,0,21,0,4096,4238,651,707,0,0,0,0,0,0,16466,16614,16614,16614,1,1,1,1,'Knife');
INSERT INTO `synth_recipes` VALUES (2798,0,0,0,0,0,0,0,0,34,0,4096,4238,653,710,0,0,0,0,0,0,16467,16739,16739,16739,1,1,1,1,'Mythril Knife');
INSERT INTO `synth_recipes` VALUES (2799,0,0,0,0,0,0,0,0,53,0,4096,4238,654,716,0,0,0,0,0,0,16468,16751,16751,16751,1,1,1,1,'Darksteel Knife');
INSERT INTO `synth_recipes` VALUES (2800,0,0,62,0,0,0,0,0,0,0,4096,4238,716,931,0,0,0,0,0,0,16469,17609,17609,17609,1,1,1,1,'Cermet Knife');
INSERT INTO `synth_recipes` VALUES (2801,0,0,0,0,0,0,0,0,91,0,4096,4238,655,717,0,0,0,0,0,0,16470,17621,17621,17621,1,1,1,1,'Gully');
INSERT INTO `synth_recipes` VALUES (2802,0,0,34,0,0,0,0,0,0,0,4101,4243,937,4163,16465,0,0,0,0,0,16471,16490,16490,16490,1,1,1,1,'Blind Knife');
INSERT INTO `synth_recipes` VALUES (2803,0,0,23,0,0,0,0,0,0,0,4101,4243,937,4157,16466,0,0,0,0,0,16472,16742,16742,16742,1,1,1,1,'Poison Knife');
INSERT INTO `synth_recipes` VALUES (2804,0,0,0,0,0,0,0,0,33,0,4096,4238,652,710,852,0,0,0,0,0,16473,16748,16748,16748,1,1,1,1,'Kukri');
INSERT INTO `synth_recipes` VALUES (2805,0,0,0,0,0,0,0,0,42,0,4096,4238,653,716,853,0,0,0,0,0,16475,16750,16750,16750,1,1,1,1,'Mythril Kukri');
INSERT INTO `synth_recipes` VALUES (2806,0,0,0,0,0,0,0,0,65,0,4096,4238,654,717,854,0,0,0,0,0,16476,16763,16763,16763,1,1,1,1,'Darksteel Kukri');
INSERT INTO `synth_recipes` VALUES (2807,0,0,76,0,0,0,0,0,0,0,4096,4238,719,931,1122,0,0,0,0,0,16477,17603,17603,17603,1,1,1,1,'Cermet Kukri');
INSERT INTO `synth_recipes` VALUES (2808,0,0,31,0,0,0,0,0,0,0,4101,4243,937,4157,16473,0,0,0,0,0,16478,16489,16489,16489,1,1,1,1,'Poison Kukri');
INSERT INTO `synth_recipes` VALUES (2809,0,0,67,0,0,0,0,0,0,0,4101,4243,937,4171,16475,0,0,0,0,0,16479,16494,16494,16494,1,1,1,1,'Acid Kukri');
INSERT INTO `synth_recipes` VALUES (2810,0,0,13,0,0,0,0,0,0,0,4101,4243,937,4162,16449,0,0,0,0,0,16495,16508,16508,16508,1,1,1,1,'Silence Dagger');
INSERT INTO `synth_recipes` VALUES (2811,0,0,22,0,0,0,0,0,0,0,4101,4243,937,4157,16450,0,0,0,0,0,16496,16741,16741,16741,1,1,1,1,'Poison Dagger');
INSERT INTO `synth_recipes` VALUES (2812,0,0,87,0,0,0,0,0,0,0,4101,4243,937,4158,16759,0,0,0,0,0,16499,16761,16761,16761,1,1,1,1,'Venom Kris');
INSERT INTO `synth_recipes` VALUES (2813,0,0,47,0,0,0,0,0,0,0,4101,4243,937,4171,16467,0,0,0,0,0,16501,17608,17608,17608,1,1,1,1,'Acid Knife');
INSERT INTO `synth_recipes` VALUES (2814,0,0,70,0,0,0,0,0,0,0,4101,4243,937,4158,16468,0,0,0,0,0,16502,16762,16762,16762,1,1,1,1,'Venom Knife');
INSERT INTO `synth_recipes` VALUES (2815,0,0,80,0,0,0,0,0,0,0,4101,4243,937,4159,16469,0,0,0,0,0,16503,17600,17600,17600,1,1,1,1,'Stun Knife');
INSERT INTO `synth_recipes` VALUES (2816,0,0,75,0,0,0,0,0,0,0,4101,4243,937,4158,16476,0,0,0,0,0,16505,17604,17604,17604,1,1,1,1,'Venom Kukri'); -- venom kukri (alch 75)
INSERT INTO `synth_recipes` VALUES (2817,0,0,86,0,0,0,0,0,0,0,4101,4243,937,4159,16477,0,0,0,0,0,16506,17614,17614,17614,1,1,1,1,'Stun Kukri');
INSERT INTO `synth_recipes` VALUES (2818,0,0,74,0,0,0,0,0,0,0,4101,4243,937,4158,16457,0,0,0,0,0,16507,16510,16510,16510,1,1,1,1,'Venom Baselard'); -- venom baselard (alch 74)
INSERT INTO `synth_recipes` VALUES (2819,0,0,0,0,0,0,7,0,28,0,4096,4238,651,744,0,0,0,0,0,0,16512,16632,16632,16632,1,1,1,1,'Bilbo');
INSERT INTO `synth_recipes` VALUES (2820,0,0,0,0,0,0,8,0,31,0,4096,4238,653,744,0,0,0,0,0,0,16513,16617,16617,16617,1,1,1,1,'Tuck');
INSERT INTO `synth_recipes` VALUES (2821,0,0,0,0,0,0,69,0,0,0,4096,4238,745,914,16512,0,0,0,0,0,16514,16618,16618,16618,1,1,1,1,'Mailbreaker');
INSERT INTO `synth_recipes` VALUES (2822,0,0,0,0,0,0,88,0,0,0,4096,4238,745,812,16514,0,0,0,0,0,16515,17632,17632,17632,1,1,1,1,'Colichemarde');
INSERT INTO `synth_recipes` VALUES (2823,0,0,0,0,0,0,0,0,28,0,4096,4238,652,652,744,0,0,0,0,0,16517,16633,16633,16633,1,1,1,1,'Degen');
INSERT INTO `synth_recipes` VALUES (2824,0,0,0,0,0,0,52,0,21,0,4096,4238,651,653,653,0,0,0,0,0,16518,16815,16815,16815,1,1,1,1,'Mythril Degen');
INSERT INTO `synth_recipes` VALUES (2825,0,0,0,0,0,0,14,0,59,0,4096,4238,654,654,744,0,0,0,0,0,16519,16813,16813,16813,1,1,1,1,'Schlaeger'); -- schlaeger (smith 59 gold 14) https://www.bg-wiki.com/bg/Schlaeger
INSERT INTO `synth_recipes` VALUES (2826,0,0,0,0,0,0,99,0,53,0,4096,4238,655,655,745,746,804,914,0,0,16520,17656,17656,17656,1,1,1,1,'Verdun');
INSERT INTO `synth_recipes` VALUES (2827,0,0,0,0,0,0,83,0,28,0,4096,4238,652,652,745,810,914,0,0,0,16521,17633,17633,17633,1,1,1,1,'Rapier');
INSERT INTO `synth_recipes` VALUES (2828,0,0,47,0,0,0,0,0,0,0,4099,4241,637,947,16517,0,0,0,0,0,16522,16823,16823,16823,1,1,1,1,'Flame Degen');
INSERT INTO `synth_recipes` VALUES (2829,0,0,58,0,0,0,0,0,0,0,4102,4244,4154,16518,0,0,0,0,0,0,16523,16817,16817,16817,1,1,1,1,'Holy Degen');
INSERT INTO `synth_recipes` VALUES (2830,0,0,0,0,0,0,19,0,39,0,4096,4238,652,652,744,796,0,0,0,0,16524,16803,16803,16803,1,1,1,1,'Fleuret');
INSERT INTO `synth_recipes` VALUES (2831,0,0,0,71,0,0,52,0,0,0,4096,4238,650,792,802,893,925,0,0,0,16525,17634,17634,17634,1,1,1,1,'Hornet Fleuret');
INSERT INTO `synth_recipes` VALUES (2832,0,0,56,0,0,0,38,0,71,0,4096,4238,652,652,653,802,931,0,0,0,16526,17635,17635,17635,1,1,1,1,'Schwert');
INSERT INTO `synth_recipes` VALUES (2833,0,0,0,0,0,0,85,0,0,0,4096,4238,652,653,745,746,813,914,0,0,16527,16619,16619,16619,1,1,1,1,'Epee');
INSERT INTO `synth_recipes` VALUES (2834,0,0,85,0,0,0,0,0,0,0,4103,4245,930,940,16519,0,0,0,0,0,16528,16824,16824,16824,1,1,1,1,'Bloody Rapier');
INSERT INTO `synth_recipes` VALUES (2835,0,0,0,2,0,0,0,0,8,0,4096,4238,649,649,893,0,0,0,0,0,16530,16624,16624,16624,1,1,1,1,'Xiphos');
INSERT INTO `synth_recipes` VALUES (2836,0,0,0,0,0,0,19,0,0,0,4096,4238,650,16530,0,0,0,0,0,0,16531,16802,16802,16802,1,1,1,1,'Brass Xiphos');
INSERT INTO `synth_recipes` VALUES (2837,0,0,0,6,0,0,0,0,29,0,4096,4238,651,651,895,0,0,0,0,0,16532,16608,16608,16608,1,1,1,1,'Gladius');
INSERT INTO `synth_recipes` VALUES (2838,0,0,0,0,0,0,0,0,6,0,4096,4238,649,649,850,0,0,0,0,0,16535,16623,16623,16623,1,1,1,1,'Bronze Sword');
INSERT INTO `synth_recipes` VALUES (2839,0,0,0,0,0,0,0,0,25,0,4096,4238,651,651,852,0,0,0,0,0,16536,16626,16626,16626,1,1,1,1,'Iron Sword');
INSERT INTO `synth_recipes` VALUES (2840,0,0,0,0,0,0,0,0,40,0,4096,4238,653,653,848,0,0,0,0,0,16537,16635,16635,16635,1,1,1,1,'Mythril Sword');
INSERT INTO `synth_recipes` VALUES (2841,0,0,0,0,0,0,0,0,55,0,4096,4238,654,654,853,0,0,0,0,0,16538,16811,16811,16811,1,1,1,1,'Darksteel Sword');
INSERT INTO `synth_recipes` VALUES (2842,0,0,68,0,0,0,0,0,0,0,4096,4238,855,931,931,0,0,0,0,0,16539,16825,16825,16825,1,1,1,1,'Cermet Sword');
INSERT INTO `synth_recipes` VALUES (2843,0,0,0,58,0,0,81,0,0,0,4096,4238,745,746,785,786,789,914,1123,16538,16541,17636,17636,17636,1,1,1,1,'Jagdplaute');
INSERT INTO `synth_recipes` VALUES (2844,0,0,0,0,0,0,90,0,0,0,4096,4238,653,745,746,786,16541,0,0,0,16542,17637,17637,17637,1,1,1,1,'Wing Sword');
INSERT INTO `synth_recipes` VALUES (2845,0,0,46,0,0,0,0,0,0,0,4099,4241,637,947,16536,0,0,0,0,0,16543,16621,16621,16621,1,1,1,1,'Fire Sword');
INSERT INTO `synth_recipes` VALUES (2846,0,0,0,0,0,0,0,0,51,0,4096,4238,653,653,852,0,0,0,0,0,16545,16634,16634,16634,1,1,1,1,'Broadsword');
INSERT INTO `synth_recipes` VALUES (2847,0,0,0,0,0,0,0,0,80,0,4096,4238,654,853,16545,0,0,0,0,0,16546,17638,17638,17638,1,1,1,1,'Katzbalger');
INSERT INTO `synth_recipes` VALUES (2848,0,0,0,0,0,0,0,0,94,0,4096,4238,655,655,745,854,914,0,0,0,16547,17657,17657,17657,1,1,1,1,'Anelace');
INSERT INTO `synth_recipes` VALUES (2849,0,0,0,88,0,0,0,0,0,0,4099,4241,887,887,887,887,16546,0,0,0,16548,16620,16620,16620,1,1,1,1,'Coral Sword');
INSERT INTO `synth_recipes` VALUES (2850,0,0,64,0,0,0,0,0,0,0,4102,4244,4154,4154,16545,0,0,0,0,0,16549,16826,16826,16826,1,1,1,1,'Divine Sword');
INSERT INTO `synth_recipes` VALUES (2851,0,0,66,0,0,0,0,0,0,0,4102,4244,5306,16549,0,0,0,0,0,0,16550,16550,16550,16550,1,1,1,1,'Hallowed Sword'); -- hallowed sword (alch 66)
INSERT INTO `synth_recipes` VALUES (2852,0,0,0,0,0,0,7,0,0,0,4096,4238,650,650,744,0,0,0,0,0,16551,16801,16801,16801,1,1,1,1,'Sapara'); -- sapara (gold 7) https://www.bg-wiki.com/bg/Sapara
INSERT INTO `synth_recipes` VALUES (2853,0,0,0,0,0,0,6,0,24,0,4096,4238,650,652,652,0,0,0,0,0,16552,16625,16625,16625,1,1,1,1,'Scimitar');
INSERT INTO `synth_recipes` VALUES (2854,0,0,0,0,0,0,14,0,41,0,4096,4238,653,653,744,0,0,0,0,0,16553,16636,16636,16636,1,1,1,1,'Tulwar');
INSERT INTO `synth_recipes` VALUES (2855,0,0,66,0,0,0,39,0,0,0,4096,4238,745,931,931,0,0,0,0,0,16554,17642,17642,17642,1,1,1,1,'Hanger');
INSERT INTO `synth_recipes` VALUES (2856,0,0,83,0,0,0,0,0,0,0,4103,4245,930,940,16559,0,0,0,0,0,16556,16827,16827,16827,1,1,1,1,'Bloody Blade');
INSERT INTO `synth_recipes` VALUES (2857,0,0,0,0,0,0,0,0,43,0,4096,4238,651,652,652,652,0,0,0,0,16558,16615,16615,16615,1,1,1,1,'Falchion');
INSERT INTO `synth_recipes` VALUES (2858,0,0,0,0,0,0,0,0,60,0,4096,4238,652,654,654,654,0,0,0,0,16559,16814,16814,16814,1,1,1,1,'Darksteel Falchion');
INSERT INTO `synth_recipes` VALUES (2859,0,0,73,0,0,0,0,0,45,0,4096,4238,654,931,931,931,0,0,0,0,16560,17639,17639,17639,1,1,1,1,'Cutlass');
INSERT INTO `synth_recipes` VALUES (2860,0,0,0,0,0,0,84,0,0,0,4096,4238,745,746,914,16560,0,0,0,0,16562,17640,17640,17640,1,1,1,1,'Platinum Cutlass');
INSERT INTO `synth_recipes` VALUES (2861,0,0,49,0,0,0,0,0,0,0,4099,4241,637,947,16558,0,0,0,0,0,16564,16804,16804,16804,1,1,1,1,'Flame Blade');
INSERT INTO `synth_recipes` VALUES (2862,0,0,0,0,0,0,0,0,25,0,4096,4238,649,649,649,852,0,0,0,0,16565,16627,16627,16627,1,1,1,1,'Spatha');
INSERT INTO `synth_recipes` VALUES (2863,0,0,0,0,0,0,0,0,27,0,4096,4238,651,651,651,848,0,0,0,0,16566,16628,16628,16628,1,1,1,1,'Longsword');
INSERT INTO `synth_recipes` VALUES (2864,0,0,0,0,0,0,0,0,49,0,4096,4238,653,653,653,851,0,0,0,0,16567,16800,16800,16800,1,1,1,1,'Knights Sword');
INSERT INTO `synth_recipes` VALUES (2865,0,0,70,0,0,0,0,0,0,0,4096,4238,855,931,931,931,0,0,0,0,16568,16612,16612,16612,1,1,1,1,'Saber');
INSERT INTO `synth_recipes` VALUES (2866,0,0,0,0,0,0,72,0,0,0,4096,4238,745,745,914,16568,0,0,0,0,16569,17641,17641,17641,1,1,1,1,'Gold Sword');
INSERT INTO `synth_recipes` VALUES (2867,0,0,14,0,0,0,0,0,0,0,4101,4243,913,913,16565,0,0,0,0,0,16572,16611,16611,16611,1,1,1,1,'Bee Spatha');
INSERT INTO `synth_recipes` VALUES (2868,0,0,0,0,0,0,0,0,57,0,4096,4238,653,653,653,848,0,0,0,0,16576,16812,16812,16812,1,1,1,1,'Hunting Sword');
INSERT INTO `synth_recipes` VALUES (2869,0,0,0,0,0,0,0,0,77,0,4096,4238,654,654,654,851,0,0,0,0,16577,16828,16828,16828,1,1,1,1,'Bastard Sword');
INSERT INTO `synth_recipes` VALUES (2870,0,0,90,0,0,0,0,0,0,0,4096,4238,506,931,931,931,0,0,0,0,16578,17645,17645,17645,1,1,1,1,'Espadon');
INSERT INTO `synth_recipes` VALUES (2871,0,0,0,0,0,0,0,0,98,0,4096,4238,655,655,655,1637,0,0,0,0,16579,17712,17712,17712,1,1,1,1,'Kaskara');
INSERT INTO `synth_recipes` VALUES (2872,0,0,54,0,0,0,0,0,0,0,4102,4244,4154,16537,0,0,0,0,0,0,16581,16816,16816,16816,1,1,1,1,'Holy Sword');
INSERT INTO `synth_recipes` VALUES (2873,0,0,0,0,0,0,0,2,32,16,4096,4238,652,652,652,652,715,852,0,0,16583,16638,16638,16638,1,1,1,1,'Claymore');
INSERT INTO `synth_recipes` VALUES (2874,0,0,0,0,0,0,0,13,41,5,4096,4238,653,653,653,653,714,848,0,0,16584,16639,16639,16639,1,1,1,1,'Mythril Claymore');
INSERT INTO `synth_recipes` VALUES (2875,0,0,0,0,0,0,0,16,60,18,4096,4238,654,654,654,654,710,851,0,0,16585,16933,16933,16933,1,1,1,1,'Dst. Claymore');
INSERT INTO `synth_recipes` VALUES (2876,0,0,101,0,0,0,60,0,0,0,4096,4238,723,745,745,1772,1772,1772,1772,2275,16587,16598,16598,16598,1,1,1,1,'Gold Algol'); -- Gold Algol (alch 101, gold 60)
INSERT INTO `synth_recipes` VALUES (2877,0,0,44,0,0,0,0,0,0,0,4099,4241,637,947,16583,0,0,0,0,0,16588,16929,16929,16929,1,1,1,1,'Flame Claymore');
INSERT INTO `synth_recipes` VALUES (2878,0,0,0,0,0,0,0,2,42,10,4096,4238,652,652,652,652,652,715,852,0,16589,16931,16931,16931,1,1,1,1,'Two-hand. Sword');
INSERT INTO `synth_recipes` VALUES (2879,0,0,0,0,0,0,0,18,52,9,4096,4238,653,653,653,653,653,714,848,0,16590,16932,16932,16932,1,1,1,1,'Greatsword');
INSERT INTO `synth_recipes` VALUES (2880,0,0,0,0,0,0,0,23,81,14,4096,4238,653,654,654,654,654,710,851,0,16591,16616,16616,16616,1,1,1,1,'Zweihander');
INSERT INTO `synth_recipes` VALUES (2881,0,0,0,0,0,0,0,0,31,0,4102,4244,16606,0,0,0,0,0,0,0,16593,16593,16593,16593,1,1,1,1,'Plain Sword');
INSERT INTO `synth_recipes` VALUES (2882,0,0,39,0,0,0,0,0,0,0,4099,4241,637,947,16589,0,0,0,0,0,16594,16928,16928,16928,1,1,1,1,'Inferno Sword');
INSERT INTO `synth_recipes` VALUES (2883,0,0,0,0,0,0,0,21,71,47,4096,4238,653,653,653,653,653,653,717,853,16595,16939,16939,16939,1,1,1,1,'Ram-dao');
INSERT INTO `synth_recipes` VALUES (2884,0,0,0,0,0,0,0,27,90,50,4096,4238,654,654,654,654,654,654,717,854,16596,16941,16941,16941,1,1,1,1,'Flamberge');
INSERT INTO `synth_recipes` VALUES (2885,0,0,0,0,0,0,0,48,96,46,4096,4238,655,655,655,655,655,655,717,1122,16597,16955,16955,16955,1,1,1,1,'Nagan'); -- nagan (smith 96 wood ?? leath ??) https://www.bg-wiki.com/bg/Nagan
INSERT INTO `synth_recipes` VALUES (2886,0,0,9,0,0,0,0,0,0,0,4101,4243,913,16535,0,0,0,0,0,0,16600,16610,16610,16610,1,1,1,1,'Wax Sword');
INSERT INTO `synth_recipes` VALUES (2887,0,1993,0,0,0,0,0,0,44,0,4099,4241,2230,2233,16584,0,0,0,0,0,16603,16603,16603,16603,1,1,1,1,'Halo Claymore');
INSERT INTO `synth_recipes` VALUES (2888,0,0,88,0,0,0,0,0,0,0,4103,4245,930,940,16577,0,0,0,0,0,16609,17646,17646,17646,1,1,1,1,'Bloody Sword');
INSERT INTO `synth_recipes` VALUES (2889,0,2034,57,0,0,0,0,0,0,0,4102,4244,2230,2233,16581,0,0,0,0,0,16613,16613,16613,16613,1,1,1,1,'Spirit Sword'); -- spirit sword (Alchemic Ensorcellment)
INSERT INTO `synth_recipes` VALUES (2890,0,0,0,0,0,0,0,0,7,2,4096,4238,649,649,715,0,0,0,0,0,16640,16646,16646,16646,1,1,1,1,'Bronze Axe');
INSERT INTO `synth_recipes` VALUES (2891,0,0,0,0,0,0,12,0,0,0,4096,4238,650,16640,0,0,0,0,0,0,16641,16661,16661,16661,1,1,1,1,'Brass Axe');
INSERT INTO `synth_recipes` VALUES (2892,0,0,0,20,0,0,0,0,0,0,4098,4240,893,895,895,0,0,0,0,0,16642,16666,16666,16666,1,1,1,1,'Bone Axe'); -- bone axe (bone 20) https://www.bg-wiki.com/bg/Bone_Axe
INSERT INTO `synth_recipes` VALUES (2893,0,0,0,0,0,0,0,0,26,4,4096,4238,651,651,714,0,0,0,0,0,16643,16663,16663,16663,1,1,1,1,'Battleaxe');
INSERT INTO `synth_recipes` VALUES (2894,0,0,0,0,0,0,0,0,42,11,4096,4238,653,653,710,0,0,0,0,0,16644,16665,16665,16665,1,1,1,1,'Mythril Axe');
INSERT INTO `synth_recipes` VALUES (2895,0,0,0,0,0,0,0,0,62,22,4096,4238,654,654,716,0,0,0,0,0,16645,16677,16677,16677,1,1,1,1,'Darksteel Axe');
INSERT INTO `synth_recipes` VALUES (2896,0,0,0,23,0,0,0,0,0,6,4098,4240,715,893,0,0,0,0,0,0,16649,16668,16668,16668,1,1,1,1,'Bone Pick');
INSERT INTO `synth_recipes` VALUES (2897,0,0,0,0,0,0,0,0,38,6,4096,4238,652,715,0,0,0,0,0,0,16650,16664,16664,16664,1,1,1,1,'War Pick');
INSERT INTO `synth_recipes` VALUES (2898,0,0,0,0,0,0,0,0,47,8,4096,4238,653,707,0,0,0,0,0,0,16651,16670,16670,16670,1,1,1,1,'Mythril Pick');
INSERT INTO `synth_recipes` VALUES (2899,0,0,0,0,0,0,0,0,73,8,4096,4238,654,707,0,0,0,0,0,0,16652,16682,16682,16682,1,1,1,1,'Darksteel Pick');
INSERT INTO `synth_recipes` VALUES (2900,0,0,0,0,0,0,50,0,93,20,4096,4238,655,716,745,914,0,0,0,0,16653,16685,16685,16685,1,1,1,1,'Nadziak');
INSERT INTO `synth_recipes` VALUES (2901,0,0,0,0,0,0,0,0,51,15,4096,4238,653,653,653,710,0,0,0,0,16657,16671,16671,16671,1,1,1,1,'Tabar');
INSERT INTO `synth_recipes` VALUES (2902,0,0,0,0,0,0,0,0,83,22,4096,4238,654,654,654,716,0,0,0,0,16658,16683,16683,16683,1,1,1,1,'Darksteel Tabar');
INSERT INTO `synth_recipes` VALUES (2903,0,0,0,0,0,0,57,0,99,33,4096,4238,654,655,655,717,745,914,0,0,16659,17935,17935,17935,1,1,1,1,'Tabarzin');
INSERT INTO `synth_recipes` VALUES (2904,0,0,0,0,0,0,0,0,23,5,4096,4238,649,649,651,708,0,0,0,0,16704,16716,16716,16716,1,1,1,1,'Butterfly Axe');
INSERT INTO `synth_recipes` VALUES (2905,0,0,0,0,0,0,0,0,31,16,4096,4238,651,651,653,714,0,0,0,0,16705,16717,16717,16717,1,1,1,1,'Greataxe');
INSERT INTO `synth_recipes` VALUES (2906,0,0,0,0,0,0,0,0,41,15,4096,4238,652,652,652,716,0,0,0,0,16706,16718,16718,16718,1,1,1,1,'Heavy Axe');
INSERT INTO `synth_recipes` VALUES (2907,0,0,0,0,0,0,44,0,95,42,4096,4238,652,654,654,719,745,914,0,0,16707,18197,18197,18197,1,1,1,1,'Bhuj');
INSERT INTO `synth_recipes` VALUES (2908,0,0,42,0,0,0,0,0,0,0,4099,4241,637,947,16704,0,0,0,0,0,16709,16713,16713,16713,1,1,1,1,'Inferno Axe');
INSERT INTO `synth_recipes` VALUES (2909,0,0,0,0,0,0,0,0,88,31,4096,4238,654,654,654,717,0,0,0,0,16724,16725,16725,16725,1,1,1,1,'Heavy Dst. Axe');
INSERT INTO `synth_recipes` VALUES (2910,0,0,0,0,0,0,0,0,88,0,4096,4238,652,16710,0,0,0,0,0,0,16730,16731,16731,16731,1,1,1,1,'Colossal Axe');
INSERT INTO `synth_recipes` VALUES (2911,0,0,0,0,0,0,0,0,46,0,4096,4238,652,16712,0,0,0,0,0,0,16732,16733,16733,16733,1,1,1,1,'Bas. Greataxe');
INSERT INTO `synth_recipes` VALUES (2912,0,0,0,0,0,0,24,0,72,0,4096,4238,652,654,797,0,0,0,0,0,16759,16760,16760,16760,1,1,1,1,'Darksteel Kris');
INSERT INTO `synth_recipes` VALUES (2913,0,0,0,0,0,0,0,0,8,6,4096,4238,649,649,715,824,0,0,0,0,16768,16778,16778,16778,1,1,1,1,'Bronze Zaghnal');
INSERT INTO `synth_recipes` VALUES (2914,0,0,0,0,0,0,15,0,0,0,4096,4238,650,16768,0,0,0,0,0,0,16769,16772,16772,16772,1,1,1,1,'Brass Zaghnal');
INSERT INTO `synth_recipes` VALUES (2915,0,0,0,0,0,0,0,0,28,7,4096,4238,651,651,714,824,0,0,0,0,16770,16779,16779,16779,1,1,1,1,'Zaghnal');
INSERT INTO `synth_recipes` VALUES (2916,0,0,0,0,0,0,0,0,32,2,4096,4238,651,651,651,714,824,0,0,0,16774,16781,16781,16781,1,1,1,1,'Scythe');
INSERT INTO `synth_recipes` VALUES (2917,0,0,0,0,0,0,0,0,48,20,4096,4238,653,653,653,713,824,0,0,0,16775,16782,16782,16782,1,1,1,1,'Mythril Scythe');
INSERT INTO `synth_recipes` VALUES (2918,0,0,59,0,0,0,0,0,93,14,4096,4238,652,654,654,654,713,824,924,0,16777,16791,16791,16791,1,1,1,1,'Death Scythe');
INSERT INTO `synth_recipes` VALUES (2919,0,0,0,0,0,0,0,0,78,14,4096,4238,654,654,654,713,824,0,0,0,16789,16790,16790,16790,1,1,1,1,'Darksteel Scythe');
INSERT INTO `synth_recipes` VALUES (2920,0,0,0,57,0,0,0,0,0,19,4098,4240,713,824,882,893,893,0,0,0,16794,16795,16795,16795,1,1,1,1,'Bone Scythe');
INSERT INTO `synth_recipes` VALUES (2921,0,0,0,0,0,0,0,0,61,19,4096,4238,653,653,711,824,0,0,0,0,16796,16797,16797,16797,1,1,1,1,'Mythril Zaghnal');
INSERT INTO `synth_recipes` VALUES (2922,0,0,0,2,0,0,0,0,0,10,4098,4240,715,817,882,0,0,0,0,0,16832,16862,16862,16862,1,1,1,1,'Harpoon');
INSERT INTO `synth_recipes` VALUES (2923,0,0,0,0,0,0,0,0,9,18,4098,4240,649,715,817,0,0,0,0,0,16833,16859,16859,16859,1,1,1,1,'Bronze Spear');
INSERT INTO `synth_recipes` VALUES (2924,0,0,0,0,0,0,5,0,0,22,4098,4240,650,715,819,0,0,0,0,0,16834,16864,16864,16864,1,1,1,1,'Brass Spear');
INSERT INTO `synth_recipes` VALUES (2925,0,0,0,0,0,0,0,0,6,31,4098,4240,651,715,819,0,0,0,0,0,16835,16865,16865,16865,1,1,1,1,'Spear');
INSERT INTO `synth_recipes` VALUES (2926,0,0,0,0,0,0,0,0,11,42,4099,4241,652,715,820,0,0,0,0,0,16836,16866,16866,16866,1,1,1,1,'Halberd');
INSERT INTO `synth_recipes` VALUES (2927,0,0,0,0,0,0,0,0,37,67,4098,4240,654,715,822,0,0,0,0,0,16839,16874,16874,16874,1,1,1,1,'Partisan');
INSERT INTO `synth_recipes` VALUES (2928,0,0,0,0,0,0,57,0,60,100,4098,4240,655,715,745,791,823,0,0,0,16840,16894,16894,16894,1,1,1,1,'Ox Tongue');
INSERT INTO `synth_recipes` VALUES (2929,0,0,0,0,0,0,0,0,46,93,4099,4241,651,657,717,823,1122,0,0,0,16841,16873,16873,16873,1,1,1,1,'Wyvern Spear');
INSERT INTO `synth_recipes` VALUES (2930,0,0,0,0,0,0,82,0,0,0,4096,4238,745,914,16839,0,0,0,0,0,16842,16875,16875,16875,1,1,1,1,'Golden Spear');
INSERT INTO `synth_recipes` VALUES (2931,0,0,0,0,0,0,0,0,38,41,4096,4238,652,652,715,715,0,0,0,0,16845,16876,16876,16876,1,1,1,1,'Lance');
INSERT INTO `synth_recipes` VALUES (2932,0,0,90,0,0,0,0,0,0,0,4103,4245,930,930,940,16848,0,0,0,0,16846,16881,16881,16881,1,1,1,1,'Bloody Lance');
INSERT INTO `synth_recipes` VALUES (2933,0,0,0,0,0,0,0,0,42,60,4096,4238,653,653,715,715,0,0,0,0,16847,16877,16877,16877,1,1,1,1,'Mythril Lance');
INSERT INTO `synth_recipes` VALUES (2934,0,0,0,0,0,0,0,0,51,76,4096,4238,654,654,715,715,0,0,0,0,16848,16878,16878,16878,1,1,1,1,'Darksteel Lance');
INSERT INTO `synth_recipes` VALUES (2935,0,0,57,0,0,0,0,0,0,86,4096,4238,715,715,931,931,0,0,0,0,16849,16879,16879,16879,1,1,1,1,'Cermet Lance');
INSERT INTO `synth_recipes` VALUES (2936,0,0,86,0,0,0,0,0,0,0,4102,4244,5306,16860,0,0,0,0,0,0,16858,16858,16858,16858,1,1,1,1,'Sacred Lance');
INSERT INTO `synth_recipes` VALUES (2937,0,0,83,0,0,0,0,0,0,0,4102,4244,4154,4154,16847,0,0,0,0,0,16860,16880,16880,16880,1,1,1,1,'Holy Lance');
INSERT INTO `synth_recipes` VALUES (2938,0,0,93,0,0,0,0,0,0,0,4097,4239,936,4509,16849,0,0,0,0,0,16861,16895,16895,16895,1,1,1,1,'Ice Lance');
INSERT INTO `synth_recipes` VALUES (2939,0,0,0,0,0,0,0,0,41,52,4099,4241,651,657,716,816,0,0,0,0,16871,16872,16872,16872,1,1,1,1,'Kamayari'); -- kamayari (wood 52 smith 41) https://www.bg-wiki.com/bg/Kamayari
INSERT INTO `synth_recipes` VALUES (2940,0,0,0,0,0,0,0,0,0,81,4099,4241,715,16837,0,0,0,0,0,0,16888,16889,16889,16889,1,1,1,1,'Battle Fork');
INSERT INTO `synth_recipes` VALUES (2941,0,0,0,0,0,0,0,0,0,83,4099,4241,712,16845,16856,0,0,0,0,0,16890,16891,16891,16891,1,1,1,1,'Obelisk Lance');
INSERT INTO `synth_recipes` VALUES (2942,0,0,0,0,0,0,0,0,30,0,4096,4238,652,852,0,0,0,0,0,0,16896,16914,16914,16914,1,1,1,1,'Kunai');
INSERT INTO `synth_recipes` VALUES (2943,0,0,0,0,0,0,0,5,36,16,4096,4238,648,651,657,707,816,852,0,0,16900,16918,16918,16918,1,1,1,1,'Wakizashi');
INSERT INTO `synth_recipes` VALUES (2944,0,0,0,0,0,0,0,2,53,1,4096,4238,648,653,657,715,818,852,0,0,16901,16921,16921,16921,1,1,1,1,'Kodachi');
INSERT INTO `synth_recipes` VALUES (2945,0,0,51,0,0,0,0,0,62,11,4096,4238,648,657,707,816,853,931,0,0,16902,16922,16922,16922,1,1,1,1,'Sakurafubuki'); -- sakurafubuki (smith 62 alch 51 wood ?) https://www.bg-wiki.com/bg/Sakurafubuki
INSERT INTO `synth_recipes` VALUES (2946,0,0,0,0,0,0,0,40,74,13,4096,4238,648,654,657,707,818,853,0,0,16903,16923,16923,16923,1,1,1,1,'Kabutowari');
INSERT INTO `synth_recipes` VALUES (2947,0,0,42,0,0,0,0,0,0,0,4101,4243,937,4163,16919,0,0,0,0,0,16905,16926,16926,16926,1,1,1,1,'Bokuto');
INSERT INTO `synth_recipes` VALUES (2948,0,0,23,0,0,0,0,0,0,0,4101,4243,937,4162,16919,0,0,0,0,0,16906,16925,16925,16925,1,1,1,1,'Mokuto');
INSERT INTO `synth_recipes` VALUES (2949,0,0,33,0,0,0,0,0,0,0,4101,4243,937,4157,16919,0,0,0,0,0,16907,16927,16927,16927,1,1,1,1,'Busuto');
INSERT INTO `synth_recipes` VALUES (2950,0,0,55,0,0,0,0,0,0,0,4101,4243,937,4171,16919,0,0,0,0,0,16908,17768,17768,17768,1,1,1,1,'Yoto');
INSERT INTO `synth_recipes` VALUES (2951,0,0,80,0,0,0,0,0,0,0,4101,4243,937,4158,16919,0,0,0,0,0,16909,17769,17769,17769,1,1,1,1,'Kororito');
INSERT INTO `synth_recipes` VALUES (2952,0,0,91,0,0,0,0,0,0,0,4101,4243,937,4159,16919,0,0,0,0,0,16910,17770,17770,17770,1,1,1,1,'Mamushito');
INSERT INTO `synth_recipes` VALUES (2953,0,0,0,0,0,0,0,0,70,0,4096,4238,654,852,0,0,0,0,0,0,16915,16916,16916,16916,1,1,1,1,'Hien');
INSERT INTO `synth_recipes` VALUES (2954,0,0,0,0,0,0,0,2,43,13,4096,4238,648,651,657,707,818,852,0,0,16919,16920,16920,16920,1,1,1,1,'Shinobi-gatana');
INSERT INTO `synth_recipes` VALUES (2955,0,0,0,0,0,0,0,0,37,0,4096,4238,651,16930,0,0,0,0,0,0,16946,16947,16947,16947,1,1,1,1,'Windurstian Sword');
INSERT INTO `synth_recipes` VALUES (2956,0,0,0,0,0,0,0,0,57,0,4096,4238,653,16601,0,0,0,0,0,0,16948,16949,16949,16949,1,1,1,1,'Ryl.swd. Blade +1');
INSERT INTO `synth_recipes` VALUES (2957,0,0,0,0,0,0,0,0,83,0,4096,4238,653,16944,0,0,0,0,0,0,16950,16951,16951,16951,1,1,1,1,'Mythril Heart');
INSERT INTO `synth_recipes` VALUES (2958,0,0,0,0,0,0,0,0,100,0,4096,4238,1285,16597,0,0,0,0,0,0,16954,16954,16954,16954,1,1,1,1,'Pealing Nagan');
INSERT INTO `synth_recipes` VALUES (2959,0,0,0,0,0,0,0,12,50,40,4096,4238,652,652,652,652,653,653,717,852,16957,16958,16958,16958,1,1,1,1,'Faussar');
INSERT INTO `synth_recipes` VALUES (2960,0,0,0,0,0,0,0,4,53,18,4096,4238,648,651,651,657,707,816,852,0,16960,16978,16978,16978,1,1,1,1,'Uchigatana');
INSERT INTO `synth_recipes` VALUES (2961,0,0,0,0,0,0,75,0,0,0,4096,4238,745,823,16960,0,0,0,0,0,16962,16979,16979,16979,1,1,1,1,'Ashura');
INSERT INTO `synth_recipes` VALUES (2962,0,0,0,0,0,0,0,40,89,10,4096,4238,648,651,654,654,657,715,818,853,16964,17803,17803,17803,1,1,1,1,'Zanbato');
INSERT INTO `synth_recipes` VALUES (2963,0,0,0,0,0,0,0,6,33,20,4096,4238,648,651,651,651,657,715,818,852,16966,16981,16981,16981,1,1,1,1,'Tachi');
INSERT INTO `synth_recipes` VALUES (2964,0,0,0,0,0,0,0,10,76,6,4096,4238,648,653,653,653,657,715,818,852,16967,16989,16989,16989,1,1,1,1,'Mikazuki');
INSERT INTO `synth_recipes` VALUES (2965,0,0,57,0,0,0,63,40,0,0,4096,4238,651,651,657,715,744,822,853,931,16970,17800,17800,17800,1,1,1,1,'Hosodachi'); -- hosodachi (gold 63 alch 57 leath 40) https://www.bg-wiki.com/bg/Hosodachi
INSERT INTO `synth_recipes` VALUES (2966,0,0,0,0,0,0,87,0,46,54,4096,4238,651,651,651,657,720,745,823,1122,16972,17805,17805,17805,1,1,1,1,'Kazaridachi'); -- Kazaridachi (gold 87 wood 54 smith 46) https://www.bg-wiki.com/bg/Kazaridachi
INSERT INTO `synth_recipes` VALUES (2967,0,0,59,0,0,0,0,0,0,0,4099,4241,637,915,947,16982,0,0,0,0,16973,16986,16986,16986,1,1,1,1,'Homura');
INSERT INTO `synth_recipes` VALUES (2968,0,0,0,0,0,0,0,5,48,1,4096,4238,648,651,651,657,657,715,818,852,16982,16983,16983,16983,1,1,1,1,'Nodachi');
INSERT INTO `synth_recipes` VALUES (2969,0,0,0,0,0,0,0,27,58,10,4096,4238,648,651,651,657,657,715,818,853,16984,16985,16985,16985,1,1,1,1,'Jindachi');
INSERT INTO `synth_recipes` VALUES (2970,0,0,0,0,0,15,0,0,0,0,4098,4240,4399,0,0,0,0,0,0,0,16992,16992,16992,16992,4,4,4,4,'Slice Of Bluetail');
INSERT INTO `synth_recipes` VALUES (2971,0,0,0,0,0,3,0,0,0,0,4098,4240,4472,0,0,0,0,0,0,0,16993,16993,16993,16993,1,1,1,1,'Peeled Crayfish');
INSERT INTO `synth_recipes` VALUES (2972,0,0,0,0,0,17,0,0,0,0,4098,4240,4289,0,0,0,0,0,0,0,16994,16994,16994,16994,2,2,2,2,'Slice Of Carp');
INSERT INTO `synth_recipes` VALUES (2973,0,0,0,0,0,17,0,0,0,0,4098,4240,4401,0,0,0,0,0,0,0,16994,16994,16994,16994,2,2,2,2,'Slice Of Carp');
INSERT INTO `synth_recipes` VALUES (2974,0,0,0,0,0,31,0,0,0,0,4099,4241,631,4360,4509,0,0,0,0,0,16996,16996,16996,16996,12,12,12,12,'Sardine Ball');
INSERT INTO `synth_recipes` VALUES (2975,0,0,0,0,0,52,0,0,0,0,4099,4241,610,4383,4509,0,0,0,0,0,16997,16997,16997,16997,12,12,12,12,'Crayfish Ball');
INSERT INTO `synth_recipes` VALUES (2976,0,0,0,0,0,52,0,0,0,0,4099,4241,610,4472,4472,4472,4509,0,0,0,16997,16997,16997,16997,12,12,12,12,'Crayfish Ball');
INSERT INTO `synth_recipes` VALUES (2977,0,0,0,0,0,29,0,0,0,0,4099,4241,629,4509,17396,0,0,0,0,0,16998,16998,16998,16998,12,12,12,12,'Insect Ball');
INSERT INTO `synth_recipes` VALUES (2978,0,0,0,0,0,33,0,0,0,0,4099,4241,611,4354,4509,0,0,0,0,0,16999,16999,16999,16999,12,12,12,12,'Trout Ball');
INSERT INTO `synth_recipes` VALUES (2979,0,0,0,0,0,35,0,0,0,0,4099,4241,610,4358,4509,0,0,0,0,0,17000,17000,17000,17000,12,12,12,12,'Meatball');
INSERT INTO `synth_recipes` VALUES (2980,0,0,0,0,0,0,0,0,0,74,4098,4240,718,822,0,0,0,0,0,0,17014,17014,17014,17014,1,1,1,1,'Hume Fishing Rod');
INSERT INTO `synth_recipes` VALUES (2981,0,0,0,0,0,0,0,0,0,72,4102,4244,1832,0,0,0,0,0,0,0,17014,17014,17014,17014,1,1,1,1,'Hume Fishing Rod');
INSERT INTO `synth_recipes` VALUES (2982,0,0,76,0,0,0,0,0,0,0,4096,4238,931,932,932,932,932,933,933,0,17015,17015,17015,17015,1,1,1,1,'Halcyon Rod');
INSERT INTO `synth_recipes` VALUES (2983,0,0,72,0,0,0,0,0,0,0,4102,4244,1833,0,0,0,0,0,0,0,17015,17015,17015,17015,1,1,1,1,'Halcyon Rod');
INSERT INTO `synth_recipes` VALUES (2984,0,0,0,0,0,9,0,0,0,0,4099,4241,631,4358,4509,4570,0,0,0,0,17016,17016,17016,17016,12,12,12,12,'Pet Food Alpha');
INSERT INTO `synth_recipes` VALUES (2985,0,0,0,0,0,19,0,0,0,0,4099,4241,631,4372,4509,4570,0,0,0,0,17017,17017,17017,17017,12,12,12,12,'Pet Food Beta');
INSERT INTO `synth_recipes` VALUES (2986,0,0,0,0,0,19,0,0,0,0,4099,4241,631,4509,5568,5571,0,0,0,0,17017,17017,17017,17017,6,12,12,12,'Pet Food Beta');
INSERT INTO `synth_recipes` VALUES (2987,0,0,0,0,0,29,0,0,0,0,4099,4241,631,4359,4509,4570,0,0,0,0,17018,17018,17018,17018,6,8,10,12,'Pet Fd. Gamma');
INSERT INTO `synth_recipes` VALUES (2988,0,0,0,0,0,39,0,0,0,0,4099,4241,611,4400,4509,4570,0,0,0,0,17019,17019,17019,17019,6,8,10,12,'Pet Food Delta');
INSERT INTO `synth_recipes` VALUES (2989,0,0,0,0,0,49,0,0,0,0,4099,4241,611,4362,4435,4509,0,0,0,0,17020,17020,17020,17020,4,6,8,10,'Pet Fd. Epsilon');
INSERT INTO `synth_recipes` VALUES (2990,0,0,0,0,0,49,0,0,0,0,4099,4241,611,4362,4509,5581,0,0,0,0,17020,17020,17020,17020,4,6,8,10,'Pet Fd. Epsilon');
INSERT INTO `synth_recipes` VALUES (2991,0,0,0,0,0,59,0,0,0,0,4099,4241,610,4362,4377,4509,0,0,0,0,17021,17021,17021,17021,4,6,8,10,'Pet Food Zeta');
INSERT INTO `synth_recipes` VALUES (2992,0,0,0,0,0,0,0,0,0,9,4098,4240,715,0,0,0,0,0,0,0,17024,17137,17137,17137,1,1,1,1,'Ash Club');
INSERT INTO `synth_recipes` VALUES (2993,0,0,0,0,0,0,0,0,0,21,4098,4240,710,0,0,0,0,0,0,0,17025,17139,17139,17139,1,1,1,1,'Chestnut Club');
INSERT INTO `synth_recipes` VALUES (2994,0,0,0,40,0,0,0,0,0,0,4098,4240,824,880,880,880,880,880,880,893,17026,17033,17033,17033,1,1,1,1,'Bone Cudgel'); -- bone cudgel (bone 40) https://www.bg-wiki.com/bg/Bone_Cudgel
INSERT INTO `synth_recipes` VALUES (2995,0,0,0,0,0,0,0,0,0,41,4098,4240,716,0,0,0,0,0,0,0,17027,17142,17142,17142,1,1,1,1,'Oak Cudgel');
INSERT INTO `synth_recipes` VALUES (2996,0,0,0,0,0,0,0,0,14,54,4098,4240,649,717,0,0,0,0,0,0,17030,17408,17408,17408,1,1,1,1,'Great Club');
INSERT INTO `synth_recipes` VALUES (2997,0,0,0,0,0,0,0,0,10,0,4096,4238,649,649,649,0,0,0,0,0,17034,17086,17086,17086,1,1,1,1,'Bronze Mace');
INSERT INTO `synth_recipes` VALUES (2998,0,0,0,0,0,0,0,0,24,0,4096,4238,651,651,651,0,0,0,0,0,17035,17145,17145,17145,1,1,1,1,'Mace');
INSERT INTO `synth_recipes` VALUES (2999,0,0,0,0,0,0,0,0,40,0,4096,4238,653,653,653,0,0,0,0,0,17036,17147,17147,17147,1,1,1,1,'Mythril Mace');
INSERT INTO `synth_recipes` VALUES (3000,0,0,0,0,0,0,0,0,61,0,4096,4238,654,654,654,0,0,0,0,0,17037,17428,17428,17428,1,1,1,1,'Darksteel Mace');
INSERT INTO `synth_recipes` VALUES (3001,0,0,0,0,0,0,49,0,98,0,4096,4238,655,655,655,745,914,0,0,0,17038,17460,17460,17460,1,1,1,1,'Buzdygan');
INSERT INTO `synth_recipes` VALUES (3002,0,0,0,0,0,0,82,0,0,0,4096,4238,745,746,914,17037,0,0,0,0,17039,17431,17431,17431,1,1,1,1,'Platinum Mace');
INSERT INTO `synth_recipes` VALUES (3003,0,0,0,0,0,0,0,0,0,44,4098,4240,1673,17027,0,0,0,0,0,0,17040,17040,17040,17040,1,1,1,1,'Warp Cudgel');
INSERT INTO `synth_recipes` VALUES (3004,0,0,55,0,0,0,0,0,0,0,4102,4244,4154,17036,0,0,0,0,0,0,17041,17411,17411,17411,1,1,1,1,'Holy Mace');
INSERT INTO `synth_recipes` VALUES (3005,0,0,0,0,0,0,0,0,14,0,4096,4238,649,649,710,0,0,0,0,0,17042,17144,17144,17144,1,1,1,1,'Bronze Hammer');
INSERT INTO `synth_recipes` VALUES (3006,0,0,0,0,0,0,24,0,0,0,4096,4238,650,17042,0,0,0,0,0,0,17043,17149,17149,17149,1,1,1,1,'Brass Hammer');
INSERT INTO `synth_recipes` VALUES (3007,0,0,0,0,0,0,0,0,34,33,4096,4238,651,651,707,0,0,0,0,0,17044,17115,17115,17115,1,1,1,1,'Warhammer');
INSERT INTO `synth_recipes` VALUES (3008,0,0,0,0,0,0,0,0,46,0,4096,4238,653,653,716,0,0,0,0,0,17045,17121,17121,17121,1,1,1,1,'Maul');
INSERT INTO `synth_recipes` VALUES (3009,0,0,0,0,0,0,0,0,82,0,4096,4238,654,654,717,0,0,0,0,0,17046,17432,17432,17432,1,1,1,1,'Darksteel Maul');
INSERT INTO `synth_recipes` VALUES (3010,0,0,0,0,0,0,0,0,0,6,4098,4240,708,840,0,0,0,0,0,0,17049,17087,17087,17087,1,1,1,1,'Maple Wand');
INSERT INTO `synth_recipes` VALUES (3011,0,0,0,0,0,0,0,0,0,14,4098,4240,712,846,0,0,0,0,0,0,17050,17138,17138,17138,1,1,1,1,'Willow Wand');
INSERT INTO `synth_recipes` VALUES (3012,0,0,0,0,0,0,0,0,0,23,4098,4240,713,841,0,0,0,0,0,0,17051,17140,17140,17140,1,1,1,1,'Yew Wand');
INSERT INTO `synth_recipes` VALUES (3013,0,0,0,0,0,0,0,0,0,32,4098,4240,710,847,0,0,0,0,0,0,17052,17141,17141,17141,1,1,1,1,'Chestnut Wand');
INSERT INTO `synth_recipes` VALUES (3014,0,0,0,0,0,0,0,0,0,47,4098,4240,718,845,0,0,0,0,0,0,17053,17143,17143,17143,1,1,1,1,'Rose Wand');
INSERT INTO `synth_recipes` VALUES (3015,0,0,0,0,0,0,0,0,0,66,4098,4240,719,842,0,0,0,0,0,0,17054,17427,17427,17427,1,1,1,1,'Ebony Wand');
INSERT INTO `synth_recipes` VALUES (3016,0,0,0,0,0,0,0,0,0,84,4098,4240,720,844,0,0,0,0,0,0,17056,17433,17433,17433,1,1,1,1,'Mythic Wand');
INSERT INTO `synth_recipes` VALUES (3017,0,0,0,0,0,0,0,0,12,0,4096,4238,648,649,649,0,0,0,0,0,17059,17111,17111,17111,1,1,1,1,'Bronze Rod');
INSERT INTO `synth_recipes` VALUES (3018,0,0,0,0,0,0,0,0,31,0,4096,4238,649,651,651,0,0,0,0,0,17060,17146,17146,17146,1,1,1,1,'Rod');
INSERT INTO `synth_recipes` VALUES (3019,0,0,0,0,0,0,0,0,45,0,4096,4238,652,653,653,0,0,0,0,0,17061,17409,17409,17409,1,1,1,1,'Mythril Rod');
INSERT INTO `synth_recipes` VALUES (3020,0,0,0,50,0,0,0,0,0,0,4096,4238,893,895,895,0,0,0,0,0,17062,17410,17410,17410,1,1,1,1,'Bone Rod'); -- bone rod (bone 50) https://www.bg-wiki.com/bg/Bone_Rod
INSERT INTO `synth_recipes` VALUES (3021,0,0,0,0,0,0,0,0,77,0,4096,4238,652,654,654,0,0,0,0,0,17063,17435,17435,17435,1,1,1,1,'Darksteel Rod');
INSERT INTO `synth_recipes` VALUES (3022,0,0,0,0,0,0,39,0,96,0,4096,4238,654,655,655,745,914,0,0,0,17064,17459,17459,17459,1,1,1,1,'Scepter');
INSERT INTO `synth_recipes` VALUES (3023,0,0,0,0,0,0,86,0,0,0,4096,4238,652,745,746,0,0,0,0,0,17065,17436,17436,17436,1,1,1,1,'Platinum Rod');
INSERT INTO `synth_recipes` VALUES (3024,0,0,71,0,0,0,0,0,0,0,4102,4244,4154,17045,0,0,0,0,0,0,17080,17114,17114,17114,1,1,1,1,'Holy Maul');
INSERT INTO `synth_recipes` VALUES (3025,0,0,0,0,0,0,23,0,0,0,4096,4238,650,17059,0,0,0,0,0,0,17081,17148,17148,17148,1,1,1,1,'Brass Rod');
INSERT INTO `synth_recipes` VALUES (3026,0,0,81,0,0,0,0,0,0,0,4102,4244,4154,17056,0,0,0,0,0,0,17085,17434,17434,17434,1,1,1,1,'Holy Wand');
INSERT INTO `synth_recipes` VALUES (3027,0,0,0,0,0,0,0,0,0,10,4098,4240,715,891,0,0,0,0,0,0,17088,17123,17123,17123,1,1,1,1,'Ash Staff');
INSERT INTO `synth_recipes` VALUES (3028,0,0,0,0,0,0,0,0,0,19,4098,4240,714,882,0,0,0,0,0,0,17089,17125,17125,17125,1,1,1,1,'Holly Staff');
INSERT INTO `synth_recipes` VALUES (3029,0,0,0,0,0,0,0,0,0,29,4098,4240,707,895,0,0,0,0,0,0,17090,17126,17126,17126,1,1,1,1,'Elm Staff');
INSERT INTO `synth_recipes` VALUES (3030,0,0,0,0,0,0,0,0,0,44,4098,4240,716,884,0,0,0,0,0,0,17091,17127,17127,17127,1,1,1,1,'Oak Staff');
INSERT INTO `synth_recipes` VALUES (3031,0,0,0,0,0,0,0,0,0,62,4098,4240,717,798,902,0,0,0,0,0,17092,17520,17520,17520,1,1,1,1,'Mahogany Staff');
INSERT INTO `synth_recipes` VALUES (3032,0,0,0,0,0,0,0,0,0,8,4098,4240,715,715,0,0,0,0,0,0,17095,17122,17122,17122,1,1,1,1,'Ash Pole');
INSERT INTO `synth_recipes` VALUES (3033,0,0,0,0,0,0,0,0,0,13,4098,4240,714,714,0,0,0,0,0,0,17096,17124,17124,17124,1,1,1,1,'Holly Pole');
INSERT INTO `synth_recipes` VALUES (3034,0,0,0,0,0,0,0,0,0,46,4098,4240,707,707,0,0,0,0,0,0,17097,17119,17119,17119,1,1,1,1,'Elm Pole');
INSERT INTO `synth_recipes` VALUES (3035,0,0,0,0,0,0,0,0,0,55,4098,4240,716,716,0,0,0,0,0,0,17098,17120,17120,17120,1,1,1,1,'Oak Pole');
INSERT INTO `synth_recipes` VALUES (3036,0,0,0,0,0,0,0,0,0,68,4098,4240,717,717,0,0,0,0,0,0,17099,17521,17521,17521,1,1,1,1,'Mahogany Pole');
INSERT INTO `synth_recipes` VALUES (3037,0,0,0,0,0,0,0,0,0,79,4098,4240,719,719,0,0,0,0,0,0,17100,17525,17525,17525,1,1,1,1,'Ebony Pole');
INSERT INTO `synth_recipes` VALUES (3038,0,0,0,0,0,0,0,0,0,89,4098,4240,720,720,0,0,0,0,0,0,17101,17526,17526,17526,1,1,1,1,'Mythic Pole');
INSERT INTO `synth_recipes` VALUES (3039,0,0,0,0,0,0,0,0,31,94,4098,4240,653,711,711,0,0,0,0,0,17102,17568,17568,17568,1,1,1,1,'Eight-sided Pole');
INSERT INTO `synth_recipes` VALUES (3040,0,0,0,0,0,0,0,0,0,15,4098,4240,712,817,824,0,0,0,0,0,17152,17175,17175,17175,1,1,1,1,'Shortbow');
INSERT INTO `synth_recipes` VALUES (3041,0,0,0,5,0,0,0,0,0,16,4098,4240,712,817,825,893,0,0,0,0,17153,17176,17176,17176,1,1,1,1,'Self Bow');
INSERT INTO `synth_recipes` VALUES (3042,0,0,0,0,0,0,0,6,0,24,4098,4240,713,820,850,0,0,0,0,0,17154,17172,17172,17172,1,1,1,1,'Wrapped Bow');
INSERT INTO `synth_recipes` VALUES (3043,0,0,0,0,0,0,0,0,0,39,4098,4240,712,715,820,826,0,0,0,0,17155,17179,17179,17179,1,1,1,1,'Composite Bow');
INSERT INTO `synth_recipes` VALUES (3044,0,0,0,0,0,0,0,0,0,57,4098,4240,704,707,816,827,0,0,0,0,17156,17182,17182,17182,1,1,1,1,'Kaman');
INSERT INTO `synth_recipes` VALUES (3045,0,0,0,0,0,0,0,0,0,69,4098,4240,711,719,822,829,0,0,0,0,17157,17189,17189,17189,1,1,1,1,'Rapid Bow');
INSERT INTO `synth_recipes` VALUES (3046,0,0,0,1,0,0,0,0,0,17,4098,4240,713,713,826,895,927,0,0,0,17160,17177,17177,17177,1,1,1,1,'Longbow');
INSERT INTO `synth_recipes` VALUES (3047,0,0,0,8,0,0,0,0,0,28,4098,4240,707,707,827,897,927,0,0,0,17161,17178,17178,17178,1,1,1,1,'Power Bow');
INSERT INTO `synth_recipes` VALUES (3048,0,0,0,15,0,0,0,0,0,38,4098,4240,710,710,828,897,927,0,0,0,17162,17180,17180,17180,1,1,1,1,'Great Bow');
INSERT INTO `synth_recipes` VALUES (3049,0,0,0,15,0,0,0,0,0,48,4098,4240,710,710,829,897,927,0,0,0,17163,17181,17181,17181,1,1,1,1,'Battle Bow');
INSERT INTO `synth_recipes` VALUES (3050,0,0,25,0,0,0,0,0,0,58,4098,4240,716,716,829,932,933,0,0,0,17164,17173,17173,17173,1,1,1,1,'War Bow');
INSERT INTO `synth_recipes` VALUES (3051,0,0,0,88,0,0,0,0,0,0,4099,4241,897,2147,18688,0,0,0,0,0,17166,18682,18682,18682,1,1,1,1,'Lamian Kaman');
INSERT INTO `synth_recipes` VALUES (3052,0,0,0,0,0,0,0,86,0,0,4099,4241,851,17184,0,0,0,0,0,0,17193,17194,17194,17194,1,1,1,1,'Shadow Bow');
INSERT INTO `synth_recipes` VALUES (3053,0,0,0,0,0,0,0,0,0,20,4099,4241,712,17159,0,0,0,0,0,0,17195,17196,17196,17196,1,1,1,1,'Windurstian Bow');
INSERT INTO `synth_recipes` VALUES (3054,0,0,0,0,0,0,0,0,0,22,4099,4241,713,17167,0,0,0,0,0,0,17197,17198,17198,17198,1,1,1,1,'San Dorian Bow');
INSERT INTO `synth_recipes` VALUES (3055,0,0,59,0,0,0,0,0,0,88,4103,4245,914,923,924,941,1263,17157,0,0,17200,17201,17201,17201,1,1,1,1,'Rosenbogen');
INSERT INTO `synth_recipes` VALUES (3056,0,0,0,41,0,0,0,0,0,93,4098,4240,720,720,830,927,1620,0,0,0,17205,17206,17206,17206,1,1,1,1,'Gendawa');
INSERT INTO `synth_recipes` VALUES (3057,0,0,0,59,0,0,0,0,33,100,4098,4240,654,717,719,721,932,1282,1841,0,17213,17214,17214,17214,1,1,1,1,'Staurobow');
INSERT INTO `synth_recipes` VALUES (3058,0,0,0,0,0,0,0,0,3,12,4099,4241,649,715,817,0,0,0,0,0,17216,17228,17228,17228,1,1,1,1,'Light Crossbow');
INSERT INTO `synth_recipes` VALUES (3059,0,0,0,0,0,0,0,0,8,33,4098,4240,651,710,933,0,0,0,0,0,17217,17225,17225,17225,1,1,1,1,'Crossbow');
INSERT INTO `synth_recipes` VALUES (3060,0,0,0,0,0,0,0,0,19,43,4098,4240,652,716,927,0,0,0,0,0,17218,17229,17229,17229,1,1,1,1,'Zamburak');
INSERT INTO `synth_recipes` VALUES (3061,0,0,0,0,0,0,0,0,28,59,4098,4240,653,717,932,0,0,0,0,0,17219,17226,17226,17226,1,1,1,1,'Arbalest');
INSERT INTO `synth_recipes` VALUES (3062,0,0,0,19,0,0,0,0,37,70,4098,4240,654,717,719,893,932,0,0,0,17220,17227,17227,17227,1,1,1,1,'Heavy Crossbow'); -- heavy crossbow (wood 70, smith 37, bone 19) http://ffxiclopedia.wikia.com/wiki/Heavy_Crossbow
INSERT INTO `synth_recipes` VALUES (3063,0,0,0,46,0,0,0,0,59,88,4098,4240,654,717,718,897,927,932,0,0,17221,17233,17233,17233,1,1,1,1,'Rpt. Crossbow');
INSERT INTO `synth_recipes` VALUES (3064,0,0,0,0,0,0,60,0,77,37,4096,4238,652,654,711,730,745,914,0,0,17222,18687,18687,18687,1,1,1,1,'Hexagun');
INSERT INTO `synth_recipes` VALUES (3065,0,0,0,0,0,0,0,0,0,82,4099,4241,717,17232,0,0,0,0,0,0,17236,17237,17237,17237,1,1,1,1,'Leo Crossbow');
INSERT INTO `synth_recipes` VALUES (3066,0,0,0,0,0,0,0,0,0,17,4099,4241,715,17223,0,0,0,0,0,0,17238,17239,17239,17239,1,1,1,1,'Bas. Crossbow');
INSERT INTO `synth_recipes` VALUES (3067,0,0,0,0,0,0,0,0,0,64,4099,4241,1283,17156,0,0,0,0,0,0,17240,17241,17241,17241,1,1,1,1,'Lightning Bow');
INSERT INTO `synth_recipes` VALUES (3068,0,0,0,0,0,0,0,0,0,78,4099,4241,1282,17220,0,0,0,0,0,0,17242,17243,17243,17243,1,1,1,1,'Velocity Bow');
INSERT INTO `synth_recipes` VALUES (3069,0,0,0,0,0,0,13,0,50,40,4096,4238,650,652,652,717,0,0,0,0,17248,17254,17254,17254,1,1,1,1,'Arquebus');
INSERT INTO `synth_recipes` VALUES (3070,0,0,0,0,0,0,27,0,79,42,4096,4238,650,652,654,711,0,0,0,0,17250,17261,17261,17261,1,1,1,1,'Matchlock Gun');
INSERT INTO `synth_recipes` VALUES (3071,0,0,0,0,0,0,54,0,89,50,4096,4238,650,654,654,711,745,0,0,0,17251,17264,17264,17264,1,1,1,1,'Hellfire');
INSERT INTO `synth_recipes` VALUES (3072,0,0,0,0,0,0,23,0,100,54,4096,4238,650,654,654,655,717,0,0,0,17252,18147,18147,18147,1,1,1,1,'Culverin');
INSERT INTO `synth_recipes` VALUES (3073,0,0,0,52,0,0,0,0,47,0,4096,4238,652,652,893,0,0,0,0,0,17257,17258,17258,17258,1,1,1,1,'Bandits Gun');
INSERT INTO `synth_recipes` VALUES (3074,0,0,0,62,0,0,0,0,49,0,4096,4238,652,654,885,0,0,0,0,0,17259,17260,17260,17260,1,1,1,1,'Pirates Gun');
INSERT INTO `synth_recipes` VALUES (3075,0,0,0,75,0,0,0,0,53,0,4096,4238,654,654,902,0,0,0,0,0,17262,17263,17263,17263,1,1,1,1,'Corsairs Gun');
INSERT INTO `synth_recipes` VALUES (3076,0,0,0,0,0,0,36,0,54,30,4096,4238,648,652,652,716,0,0,0,0,17265,17266,17266,17266,1,1,1,1,'Tanegashima');
INSERT INTO `synth_recipes` VALUES (3077,0,0,0,0,0,0,34,0,66,29,4096,4238,648,652,654,716,0,0,0,0,17267,17268,17268,17268,1,1,1,1,'Negoroshiki');
INSERT INTO `synth_recipes` VALUES (3078,0,0,0,0,0,0,0,0,85,0,4096,4238,654,17253,0,0,0,0,0,0,17269,17270,17270,17270,1,1,1,1,'Musketeer Gun +1');
INSERT INTO `synth_recipes` VALUES (3079,0,0,85,0,0,0,38,0,0,0,4096,4238,745,947,0,0,0,0,0,0,17278,17278,17278,17278,33,66,99,99,'Gold Bullet'); -- gold bullet (alch 85, gold 38)
INSERT INTO `synth_recipes` VALUES (3080,0,0,0,0,0,0,0,0,0,17,4098,4240,708,818,0,0,0,0,0,0,17280,17287,17287,17287,1,1,1,1,'Boomerang');
INSERT INTO `synth_recipes` VALUES (3081,0,0,0,0,0,0,51,0,0,0,4098,4240,653,744,818,0,0,0,0,0,17281,17288,17288,17288,1,1,1,1,'Wingedge');
INSERT INTO `synth_recipes` VALUES (3082,0,0,0,0,0,0,59,0,31,0,4098,4240,652,745,914,0,0,0,0,0,17284,17289,17289,17289,1,1,1,1,'Chakram');
INSERT INTO `synth_recipes` VALUES (3083,0,0,0,0,0,0,73,0,53,0,4098,4240,651,657,745,914,0,0,0,0,17285,17279,17279,17279,1,1,1,1,'Moonring Blade');
INSERT INTO `synth_recipes` VALUES (3084,0,0,0,0,0,0,51,0,87,0,4098,4240,657,745,914,0,0,0,0,0,17286,17295,17295,17295,1,1,1,1,'Rising Sun');
INSERT INTO `synth_recipes` VALUES (3085,0,0,0,19,0,0,0,0,0,0,4098,4240,4484,0,0,0,0,0,0,0,792,793,793,793,1,1,1,1,'Pearl'); -- pearl (not pebble) http://ffxiclopedia.wikia.com/wiki/Black_Pearl
INSERT INTO `synth_recipes` VALUES (3086,0,0,0,19,0,0,0,0,0,0,4098,4240,5456,0,0,0,0,0,0,0,792,793,793,793,1,1,1,1,'Pearl'); -- pearl (not pebble) http://ffxiclopedia.wikia.com/wiki/Black_Pearl
INSERT INTO `synth_recipes` VALUES (3087,0,0,0,0,0,0,0,0,30,0,4098,4240,652,0,0,0,0,0,0,0,17298,17298,17298,17298,8,12,16,20,'Tathlum');
INSERT INTO `synth_recipes` VALUES (3088,0,0,0,58,0,0,0,0,0,0,4098,4240,893,929,930,0,0,0,0,0,17299,17299,17299,17299,8,12,16,20,'Astragalos');
INSERT INTO `synth_recipes` VALUES (3089,0,0,95,0,0,0,48,0,0,0,4096,4238,746,947,0,0,0,0,0,0,17300,17300,17300,17300,33,66,99,99,'Platinum Bullet'); -- Platinum Bullet (alch 95, gold 48)
INSERT INTO `synth_recipes` VALUES (3090,0,0,0,0,0,0,0,0,22,0,4098,4240,652,818,0,0,0,0,0,0,17301,17301,17301,17301,33,66,99,99,'Shuriken');
INSERT INTO `synth_recipes` VALUES (3091,0,0,0,0,0,0,0,0,44,0,4098,4240,652,662,0,0,0,0,0,0,17302,17302,17302,17302,33,66,99,99,'Juji Shuriken');
INSERT INTO `synth_recipes` VALUES (3092,0,0,0,0,0,0,0,0,65,0,4098,4240,657,664,0,0,0,0,0,0,17303,17303,17303,17303,33,66,99,99,'Manji Shuriken');
INSERT INTO `synth_recipes` VALUES (3093,0,0,0,0,0,0,53,0,84,0,4098,4240,657,663,745,914,0,0,0,0,17304,17304,17304,17304,33,66,99,99,'Fuma Shuriken'); -- fuma shuriken (smith 84 gold ??) https://www.bg-wiki.com/bg/Fuma_Shuriken
INSERT INTO `synth_recipes` VALUES (3094,0,0,0,0,13,0,0,0,0,0,4098,4240,840,840,891,937,0,0,0,0,17307,17307,17307,17307,8,16,20,24,'Dart');
INSERT INTO `synth_recipes` VALUES (3095,0,0,0,0,35,0,1,0,0,0,4098,4240,744,841,841,937,0,0,0,0,17308,17308,17308,17308,8,12,16,20,'Hawkeye');
INSERT INTO `synth_recipes` VALUES (3096,0,0,0,0,77,0,0,0,37,0,4098,4240,652,937,1134,1134,0,0,0,0,17309,17309,17309,17309,8,12,16,20,'Pinwheel');
INSERT INTO `synth_recipes` VALUES (3097,0,0,0,0,65,0,0,0,19,0,4098,4240,651,818,828,0,0,0,0,0,17310,17310,17310,17310,8,12,16,20,'Hyo');
INSERT INTO `synth_recipes` VALUES (3098,0,0,45,0,0,0,0,0,22,0,4096,4238,651,947,0,0,0,0,0,0,17312,17312,17312,17312,33,99,99,99,'Iron Bullet');
INSERT INTO `synth_recipes` VALUES (3099,0,0,53,0,0,0,0,0,24,3,4099,4241,651,715,928,934,947,0,0,0,17313,17313,17313,17313,4,6,9,12,'Grenade'); -- grenade (alch 53 smith 24 wood 3) https://www.bg-wiki.com/bg/Grenade
INSERT INTO `synth_recipes` VALUES (3100,0,0,53,0,0,0,0,0,24,3,4099,4241,651,715,928,947,1108,0,0,0,17313,17313,17313,17313,4,6,9,12,'Grenade'); -- grenade (alch 53 smith 24 wood 3) https://www.bg-wiki.com/bg/Grenade
INSERT INTO `synth_recipes` VALUES (3101,0,0,54,0,0,0,0,0,24,3,4099,4241,651,715,947,947,1630,0,0,0,17313,17313,17313,17313,4,6,9,12,'Grenade'); -- grenade (alch 54 smith 24 wood 3) https://www.bg-wiki.com/bg/Grenade
INSERT INTO `synth_recipes` VALUES (3102,0,0,58,0,0,0,0,0,29,0,4099,4241,651,651,928,928,928,947,947,1108,17314,17314,17314,17314,4,6,9,12,'Quake Grenade');
INSERT INTO `synth_recipes` VALUES (3103,0,0,58,0,0,0,0,0,29,0,4099,4241,651,651,947,947,1108,1630,0,0,17314,17314,17314,17314,4,6,9,12,'Quake Grenade'); -- quake grenade (alch 58, smith 29)
INSERT INTO `synth_recipes` VALUES (3104,0,0,60,0,0,0,0,0,11,0,4099,4241,660,928,928,928,934,945,947,947,17315,17315,17315,17315,4,6,9,12,'Riot Grenade');
INSERT INTO `synth_recipes` VALUES (3105,0,0,63,0,0,0,0,0,11,0,4099,4241,660,928,928,928,945,947,947,1108,17315,17315,17315,17315,4,4,4,4,'Riot Grenade');
INSERT INTO `synth_recipes` VALUES (3106,0,0,64,0,0,0,0,0,11,0,4099,4241,660,945,947,947,1108,1630,0,0,17315,17315,17315,17315,4,4,4,4,'Riot Grenade');
INSERT INTO `synth_recipes` VALUES (3107,0,0,0,0,0,0,0,0,0,65,4099,4241,715,1222,1961,0,0,0,0,0,17317,17317,17317,17317,33,66,99,99,'Gold Arrow');
INSERT INTO `synth_recipes` VALUES (3108,0,0,0,0,0,0,0,0,0,4,4098,4240,705,768,840,840,0,0,0,0,17318,17318,17318,17318,33,66,99,99,'Wooden Arrow');
INSERT INTO `synth_recipes` VALUES (3109,0,0,0,10,0,0,0,0,0,2,4098,4240,705,841,841,880,880,880,0,0,17319,17319,17319,17319,33,66,99,99,'Bone Arrow');
INSERT INTO `synth_recipes` VALUES (3110,0,0,0,0,0,0,0,0,0,9,4099,4241,705,1215,1222,0,0,0,0,0,17319,17319,17319,17319,33,66,99,99,'Bone Arrow');
INSERT INTO `synth_recipes` VALUES (3111,0,0,0,0,0,0,0,0,15,27,4098,4240,651,715,840,840,0,0,0,0,17320,17320,17320,17320,33,66,99,99,'Iron Arrow');
INSERT INTO `synth_recipes` VALUES (3112,0,0,0,0,0,0,0,0,0,27,4099,4241,705,1216,1221,0,0,0,0,0,17320,17320,17320,17320,33,66,99,99,'Iron Arrow');
INSERT INTO `synth_recipes` VALUES (3113,0,0,0,0,0,0,7,0,0,30,4098,4240,705,744,841,841,0,0,0,0,17321,17321,17321,17321,33,66,99,99,'Silver Arrow');
INSERT INTO `synth_recipes` VALUES (3114,0,0,0,0,0,0,0,0,0,30,4099,4241,715,1217,1222,0,0,0,0,0,17321,17321,17321,17321,33,66,99,99,'Silver Arrow');
INSERT INTO `synth_recipes` VALUES (3115,0,0,48,0,0,0,0,0,12,8,4098,4240,637,651,715,824,847,847,0,0,17322,17322,17322,17322,33,66,99,99,'Fire Arrow'); -- fire arrow (alch 48 smith 12 wood 8) https://www.bg-wiki.com/bg/Fire_Arrow
INSERT INTO `synth_recipes` VALUES (3116,0,0,0,0,0,0,0,0,0,47,4099,4241,715,1218,1223,0,0,0,0,0,17322,17322,17322,17322,33,66,99,99,'Fire Arrow');
INSERT INTO `synth_recipes` VALUES (3117,0,0,65,0,0,0,0,0,0,8,4097,4239,708,846,846,931,0,0,0,0,17323,17323,17323,17323,33,66,99,99,'Ice Arrow');
INSERT INTO `synth_recipes` VALUES (3118,0,0,0,0,0,0,0,0,0,57,4099,4241,705,1219,1224,0,0,0,0,0,17323,17323,17323,17323,33,66,99,99,'Ice Arrow');
INSERT INTO `synth_recipes` VALUES (3119,0,0,0,0,0,0,0,0,0,57,4099,4241,705,1220,1224,0,0,0,0,0,17324,17324,17324,17324,33,66,99,99,'Lightning Arrow');
INSERT INTO `synth_recipes` VALUES (3120,0,0,65,0,0,0,0,0,0,8,4100,4242,652,705,846,846,0,0,0,0,17324,17324,17324,17324,33,66,99,99,'Lightning Arrow');
INSERT INTO `synth_recipes` VALUES (3121,0,0,65,0,0,0,0,0,0,8,4100,4242,652,708,846,846,0,0,0,0,17324,17324,17324,17324,33,66,99,99,'Lightning Arrow');
INSERT INTO `synth_recipes` VALUES (3122,0,0,0,53,0,0,0,0,0,91,4099,4241,704,895,1416,1417,0,0,0,0,17325,17325,17325,17325,33,66,99,99,'Kabura Arrow');
INSERT INTO `synth_recipes` VALUES (3123,0,0,0,0,0,0,0,0,0,3,4099,4241,705,1214,1221,0,0,0,0,0,17330,17330,17330,17330,33,66,99,99,'Stone Arrow');
INSERT INTO `synth_recipes` VALUES (3124,0,0,0,0,0,0,0,0,0,42,4099,4241,705,1222,1515,0,0,0,0,0,17332,17332,17332,17332,33,66,99,99,'Fang Arrow');
INSERT INTO `synth_recipes` VALUES (3125,0,0,0,0,0,0,0,0,0,73,4099,4241,715,1222,1962,0,0,0,0,0,17334,17334,17334,17334,33,66,99,99,'Platinum Arrow');
INSERT INTO `synth_recipes` VALUES (3126,0,0,0,0,0,0,0,0,16,4,4098,4240,649,715,0,0,0,0,0,0,17336,17336,17336,17336,33,66,99,99,'Crossbow Bolt');
INSERT INTO `synth_recipes` VALUES (3127,0,0,0,0,0,0,0,0,46,35,4098,4240,653,710,0,0,0,0,0,0,17337,17337,17337,17337,33,66,99,99,'Mythril Bolt');
INSERT INTO `synth_recipes` VALUES (3128,0,1987,0,0,0,0,0,0,0,46,4099,4241,711,711,711,1212,1212,1212,1657,0,17337,17337,17337,17337,99,99,99,99,'Mythril Bolt');
INSERT INTO `synth_recipes` VALUES (3129,0,0,0,0,0,0,0,0,0,46,4099,4241,711,1212,0,0,0,0,0,0,17337,17337,17337,17337,33,66,99,99,'Mythril Bolt');
INSERT INTO `synth_recipes` VALUES (3130,0,0,0,0,0,0,0,0,64,7,4096,4238,654,718,0,0,0,0,0,0,17338,17338,17338,17338,33,66,99,99,'Darksteel Bolt');
INSERT INTO `synth_recipes` VALUES (3131,0,1987,0,0,0,0,0,0,0,62,4099,4241,713,713,713,1213,1213,1213,1657,0,17338,17338,17338,17338,99,99,99,99,'Darksteel Bolt');
INSERT INTO `synth_recipes` VALUES (3132,0,0,0,0,0,0,0,0,0,62,4099,4241,713,1213,0,0,0,0,0,0,17338,17338,17338,17338,33,66,99,99,'Darksteel Bolt');
INSERT INTO `synth_recipes` VALUES (3133,0,1987,0,0,0,0,0,0,0,15,4099,4241,715,715,715,1211,1211,1211,1657,0,17339,17339,17339,17339,99,99,99,99,'Bronze Bolt');
INSERT INTO `synth_recipes` VALUES (3134,0,0,0,0,0,0,0,0,0,15,4099,4241,715,1211,0,0,0,0,0,0,17339,17339,17339,17339,33,66,99,99,'Bronze Bolt');
INSERT INTO `synth_recipes` VALUES (3135,0,0,41,0,0,0,18,0,0,0,4096,4238,650,947,0,0,0,0,0,0,17340,17340,17340,17340,33,99,99,99,'Bullet'); -- Bullet - wiki + ffxiah list HQ1 is 99
INSERT INTO `synth_recipes` VALUES (3136,0,0,52,0,0,0,24,0,0,0,4096,4238,744,947,0,0,0,0,0,0,17341,17341,17341,17341,33,99,99,99,'Silver Bullet'); -- Silver Bullet - wiki + ffxiah list HQ1 as 99
INSERT INTO `synth_recipes` VALUES (3137,0,0,94,0,0,0,18,0,34,0,4096,4238,650,651,947,947,17316,0,0,0,17342,17342,17342,17342,6,8,10,12,'Cannon Shell');
INSERT INTO `synth_recipes` VALUES (3138,0,0,38,0,0,0,0,0,13,0,4096,4238,649,947,0,0,0,0,0,0,17343,17343,17343,17343,33,66,99,99,'Bronze Bullet');
INSERT INTO `synth_recipes` VALUES (3139,0,0,0,14,0,0,14,0,0,0,4098,4240,650,880,0,0,0,0,0,0,17344,17369,17369,17846,1,1,1,1,'Cornette');
INSERT INTO `synth_recipes` VALUES (3140,0,0,0,0,0,0,0,0,0,2,4098,4240,708,917,0,0,0,0,0,0,17345,17372,17844,17844,1,1,1,1,'Flute');
INSERT INTO `synth_recipes` VALUES (3141,0,0,0,0,0,0,0,0,0,20,4098,4240,714,917,0,0,0,0,0,0,17347,17368,17368,17368,1,1,1,1,'Piccolo');
INSERT INTO `synth_recipes` VALUES (3142,0,0,0,0,0,0,0,0,0,37,4098,4240,716,917,0,0,0,0,0,0,17348,17375,17845,17845,1,1,1,1,'Traversiere');
INSERT INTO `synth_recipes` VALUES (3143,0,0,0,0,0,0,0,0,0,64,4098,4240,718,917,0,0,0,0,0,0,17350,17378,17378,17378,1,1,1,1,'Angels Flute');
INSERT INTO `synth_recipes` VALUES (3144,0,0,0,24,0,0,0,0,0,0,4098,4240,893,894,0,0,0,0,0,0,17351,17370,17370,17370,1,1,1,1,'Gemshorn');
INSERT INTO `synth_recipes` VALUES (3145,0,0,0,47,0,0,0,0,0,0,4098,4240,894,895,0,0,0,0,0,0,17352,17371,17371,17371,1,1,1,1,'Horn');
INSERT INTO `synth_recipes` VALUES (3146,0,0,0,0,0,0,0,0,0,23,4099,4241,708,708,927,0,0,0,0,0,17353,17373,17373,17373,1,1,1,1,'Maple Harp');
INSERT INTO `synth_recipes` VALUES (3147,0,0,0,0,0,0,0,0,0,27,4099,4241,710,710,927,0,0,0,0,0,17354,17374,17374,17374,1,1,1,1,'Harp');
INSERT INTO `synth_recipes` VALUES (3148,0,0,0,0,0,0,0,0,0,53,4099,4241,718,718,927,0,0,0,0,0,17355,17376,17376,17376,1,1,1,1,'Rose Harp');
INSERT INTO `synth_recipes` VALUES (3149,0,0,0,0,0,0,0,0,0,71,4099,4241,719,719,927,0,0,0,0,0,17357,17833,17848,17848,1,1,1,1,'Ebony Harp');
INSERT INTO `synth_recipes` VALUES (3150,0,0,0,0,0,0,0,0,0,90,4099,4241,720,720,927,0,0,0,0,0,17359,17834,17834,17834,1,1,1,1,'Mythic Harp');
INSERT INTO `synth_recipes` VALUES (3151,0,0,0,66,0,0,0,0,0,0,4098,4240,894,902,0,0,0,0,0,0,17361,17377,17377,17847,1,1,1,1,'Crumhorn');
INSERT INTO `synth_recipes` VALUES (3152,0,0,0,86,0,0,0,0,0,0,4098,4240,883,894,0,0,0,0,0,0,17362,17832,17832,17832,1,1,1,1,'Shofar');
INSERT INTO `synth_recipes` VALUES (3153,0,0,0,0,0,0,0,0,0,98,4099,4241,719,719,720,720,927,0,0,0,17364,17837,17837,17837,1,1,1,1,'Cythara Anglica');
INSERT INTO `synth_recipes` VALUES (3154,0,0,0,0,0,0,0,0,0,87,4098,4240,721,821,0,0,0,0,0,0,17380,17380,17380,17380,1,1,1,1,'Mithran Fish. Rod');
INSERT INTO `synth_recipes` VALUES (3155,0,0,0,0,0,0,0,0,0,83,4102,4244,483,0,0,0,0,0,0,0,17380,17380,17380,17380,1,1,1,1,'Mithran Fish. Rod');
INSERT INTO `synth_recipes` VALUES (3156,0,0,89,0,0,0,0,0,0,0,4096,4238,931,931,932,932,932,933,933,0,17381,17381,17381,17381,1,1,1,1,'Comp. Fishing Rod');
INSERT INTO `synth_recipes` VALUES (3157,0,0,85,0,0,0,0,0,0,0,4102,4244,473,0,0,0,0,0,0,0,17381,17381,17381,17381,1,1,1,1,'Comp. Fishing Rod');
INSERT INTO `synth_recipes` VALUES (3158,0,0,69,0,0,0,0,0,0,0,4096,4238,932,932,932,932,932,933,933,0,17382,17382,17382,17382,1,1,1,1,'S.h. Fishing Rod');
INSERT INTO `synth_recipes` VALUES (3159,0,0,65,0,0,0,0,0,0,0,4102,4244,472,0,0,0,0,0,0,0,17382,17382,17382,17382,1,1,1,1,'S.h. Fishing Rod');
INSERT INTO `synth_recipes` VALUES (3160,0,0,0,0,0,0,0,0,0,77,4098,4240,717,816,0,0,0,0,0,0,17383,17383,17383,17383,1,1,1,1,'Clothespole');
INSERT INTO `synth_recipes` VALUES (3161,0,0,0,0,0,0,0,0,0,73,4102,4244,482,0,0,0,0,0,0,0,17383,17383,17383,17383,1,1,1,1,'Clothespole');
INSERT INTO `synth_recipes` VALUES (3162,0,0,53,0,0,0,0,0,0,0,4096,4238,932,932,932,932,933,0,0,0,17384,17384,17384,17384,1,1,1,1,'Carbon Fish. Rod');
INSERT INTO `synth_recipes` VALUES (3163,0,0,49,0,0,0,0,0,0,0,4102,4244,490,0,0,0,0,0,0,0,17384,17384,17384,17384,1,1,1,1,'Carbon Fish. Rod');
INSERT INTO `synth_recipes` VALUES (3164,0,0,29,0,0,0,0,0,0,0,4096,4238,818,933,933,933,933,0,0,0,17385,17385,17385,17385,1,1,1,1,'Glass Fiber F. Rod');
INSERT INTO `synth_recipes` VALUES (3165,0,0,25,0,0,0,0,0,0,0,4102,4244,491,0,0,0,0,0,0,0,17385,17385,17385,17385,1,1,1,1,'Glass Fiber F. Rod');
INSERT INTO `synth_recipes` VALUES (3166,0,0,0,0,0,0,0,0,0,70,4102,4244,489,0,0,0,0,0,0,0,17386,17386,17386,17386,1,1,1,1,'Lu Shangs F. Rod'); -- lu shang's fishing rod (wood 70) https://www.bg-wiki.com/bg/Lu_Shang%27s_F._Rod
INSERT INTO `synth_recipes` VALUES (3167,0,0,0,0,0,0,0,0,0,65,4098,4240,711,816,0,0,0,0,0,0,17387,17387,17387,17387,1,1,1,1,'Tarutaru F. Rod');
INSERT INTO `synth_recipes` VALUES (3168,0,0,0,0,0,0,0,0,0,63,4102,4244,484,0,0,0,0,0,0,0,17387,17387,17387,17387,1,1,1,1,'Tarutaru F. Rod');
INSERT INTO `synth_recipes` VALUES (3169,0,0,0,0,0,0,0,0,0,56,4098,4240,707,820,0,0,0,0,0,0,17388,17388,17388,17388,1,1,1,1,'Fastwater F. Rod');
INSERT INTO `synth_recipes` VALUES (3170,0,0,0,0,0,0,0,0,0,51,4102,4244,488,0,0,0,0,0,0,0,17388,17388,17388,17388,1,1,1,1,'Fastwater F. Rod');
INSERT INTO `synth_recipes` VALUES (3171,0,0,0,0,0,0,0,0,0,15,4098,4240,704,817,0,0,0,0,0,0,17389,17389,17389,17389,1,1,1,1,'Bamboo Fish. Rod');
INSERT INTO `synth_recipes` VALUES (3172,0,0,0,0,0,0,0,0,0,11,4102,4244,487,0,0,0,0,0,0,0,17389,17389,17389,17389,1,1,1,1,'Bamboo Fish. Rod');
INSERT INTO `synth_recipes` VALUES (3173,0,0,0,0,0,0,0,0,0,24,4098,4240,713,819,0,0,0,0,0,0,17390,17390,17390,17390,1,1,1,1,'Yew Fishing Rod');
INSERT INTO `synth_recipes` VALUES (3174,0,0,0,0,0,0,0,0,0,20,4102,4244,486,0,0,0,0,0,0,0,17390,17390,17390,17390,1,1,1,1,'Yew Fishing Rod');
INSERT INTO `synth_recipes` VALUES (3175,0,0,0,0,0,0,0,0,0,14,4098,4240,712,817,0,0,0,0,0,0,17391,17391,17391,17391,1,1,1,1,'Willow Fish. Rod');
INSERT INTO `synth_recipes` VALUES (3176,0,0,0,0,0,0,0,0,0,10,4102,4244,485,0,0,0,0,0,0,0,17391,17391,17391,17391,1,1,1,1,'Willow Fish. Rod');
INSERT INTO `synth_recipes` VALUES (3177,0,0,0,0,0,11,0,0,0,0,4098,4240,4360,0,0,0,0,0,0,0,17392,17392,17392,17392,2,2,2,2,'Sliced Sardine');
INSERT INTO `synth_recipes` VALUES (3178,0,0,0,0,0,11,0,0,0,0,4098,4240,5449,0,0,0,0,0,0,0,17392,17392,17392,17392,2,2,2,2,'Sliced Sardine'); -- sliced sardine (cook 11) https://www.bg-wiki.com/bg/Sliced_Sardine
INSERT INTO `synth_recipes` VALUES (3179,0,0,0,0,0,13,0,0,0,0,4098,4240,4483,0,0,0,0,0,0,0,17393,17393,17393,17393,6,6,6,6,'Sliced Cod');
INSERT INTO `synth_recipes` VALUES (3180,0,0,0,0,0,7,0,0,0,0,4098,4240,4383,0,0,0,0,0,0,0,17394,17394,17394,17394,1,1,1,1,'Peeled Lobster');
INSERT INTO `synth_recipes` VALUES (3181,0,0,0,0,6,0,21,0,0,0,4099,4241,648,648,818,818,818,0,0,0,17399,17398,17398,17398,1,1,1,1,'Sabiki Rig');
INSERT INTO `synth_recipes` VALUES (3182,0,0,48,0,0,0,21,0,0,0,4096,4238,744,933,4472,0,0,0,0,0,17402,17402,17402,17402,1,1,1,1,'Shrimp Lure');
INSERT INTO `synth_recipes` VALUES (3183,0,0,47,0,0,0,12,0,0,0,4096,4238,650,933,4515,0,0,0,0,0,17403,17403,17403,17403,1,1,1,1,'Frog Lure');
INSERT INTO `synth_recipes` VALUES (3184,0,0,46,0,0,0,12,0,0,0,4096,4238,650,933,17396,0,0,0,0,0,17404,17404,17404,17404,1,1,1,1,'Worm Lure');
INSERT INTO `synth_recipes` VALUES (3185,0,0,46,0,0,0,0,0,9,0,4096,4238,651,933,937,0,0,0,0,0,17404,17403,17402,17401,1,1,1,1,'Worm Lure');
INSERT INTO `synth_recipes` VALUES (3186,0,0,0,8,30,0,0,0,0,0,4099,4241,840,891,937,0,0,0,0,0,17405,17405,17405,17405,1,1,1,1,'Fly Lure');
INSERT INTO `synth_recipes` VALUES (3187,0,0,31,0,0,0,14,0,0,0,4096,4238,648,933,0,0,0,0,0,0,17407,17400,17400,17400,1,1,1,1,'Minnow'); -- minnow (alch 31, gold 14)
INSERT INTO `synth_recipes` VALUES (3188,0,0,26,0,0,0,10,0,0,0,4096,4238,650,933,0,0,0,0,0,0,17407,17400,17400,17400,1,1,1,1,'Minnow');
INSERT INTO `synth_recipes` VALUES (3189,0,0,0,0,0,0,0,0,5,33,4098,4240,649,711,711,0,0,0,0,0,17424,17425,17425,17425,1,1,1,1,'Spiked Club');
INSERT INTO `synth_recipes` VALUES (3190,0,0,0,0,0,0,0,0,0,86,4099,4241,712,17413,0,0,0,0,0,0,17441,17442,17442,17442,1,1,1,1,'Eremites Wand');
INSERT INTO `synth_recipes` VALUES (3191,0,0,0,0,0,0,0,0,0,14,4098,4240,715,17028,0,0,0,0,0,0,17444,17445,17445,17445,1,1,1,1,'Windurstian Club');
INSERT INTO `synth_recipes` VALUES (3192,0,0,0,0,0,0,0,0,0,37,4098,4240,710,17082,0,0,0,0,0,0,17446,17447,17447,17447,1,1,1,1,'T.m. Wand +1');
INSERT INTO `synth_recipes` VALUES (3193,0,0,0,0,0,0,0,0,45,0,4096,4238,653,17150,0,0,0,0,0,0,17448,17449,17449,17449,1,1,1,1,'San Dorian Mace');
INSERT INTO `synth_recipes` VALUES (3194,0,0,0,0,0,0,0,0,51,0,4096,4238,654,17048,0,0,0,0,0,0,17452,17453,17453,17453,1,1,1,1,'Bastokan Hammer');
INSERT INTO `synth_recipes` VALUES (3195,0,0,0,0,0,0,0,0,97,0,4096,4238,1285,17038,0,0,0,0,0,0,17470,17470,17470,17470,1,1,1,1,'Pealing Buzdygan');
INSERT INTO `synth_recipes` VALUES (3196,0,0,0,0,0,0,0,81,0,0,4099,4241,850,16443,0,0,0,0,0,0,17493,17494,17494,17494,1,1,1,1,'Tropical Punches');
INSERT INTO `synth_recipes` VALUES (3197,0,0,0,0,0,0,0,8,0,0,4099,4241,850,16691,0,0,0,0,0,0,17495,17496,17496,17496,1,1,1,1,'San Dorian Cesti');
INSERT INTO `synth_recipes` VALUES (3198,0,0,0,14,0,0,0,0,0,0,4099,4241,880,16442,0,0,0,0,0,0,17497,17498,17498,17498,1,1,1,1,'Win. Baghnakhs');
INSERT INTO `synth_recipes` VALUES (3199,0,0,0,0,0,0,19,0,0,0,4096,4238,650,16433,0,0,0,0,0,0,17499,17500,17500,17500,1,1,1,1,'Bas. Knuckles');
INSERT INTO `synth_recipes` VALUES (3200,0,0,0,73,0,0,0,0,0,0,4099,4241,902,16694,0,0,0,0,0,0,17501,17502,17502,17502,1,1,1,1,'T.m. Hooks +1');
INSERT INTO `synth_recipes` VALUES (3201,0,0,0,0,0,0,0,50,0,0,4099,4241,1297,16385,0,0,0,0,0,0,17505,17506,17506,17506,1,1,1,1,'Narasimhas Cesti');
INSERT INTO `synth_recipes` VALUES (3202,0,0,0,0,0,0,51,0,0,0,4096,4238,663,937,16407,0,0,0,0,0,17512,17513,17513,17513,1,1,1,1,'Hydro Baghnakhs');
INSERT INTO `synth_recipes` VALUES (3203,0,0,0,0,0,0,59,0,0,0,4096,4238,663,937,16411,0,0,0,0,0,17514,17515,17515,17515,1,1,1,1,'Hydro Claws');
INSERT INTO `synth_recipes` VALUES (3204,0,0,0,0,0,0,67,0,0,0,4096,4238,663,937,16420,0,0,0,0,0,17516,17517,17517,17517,1,1,1,1,'Hydro Patas');
INSERT INTO `synth_recipes` VALUES (3205,0,0,0,0,0,0,0,0,11,50,4098,4240,651,711,711,0,0,0,0,0,17523,17524,17524,17524,1,1,1,1,'Quarterstaff');
INSERT INTO `synth_recipes` VALUES (3206,0,0,0,0,0,0,0,0,0,87,4098,4240,715,17134,0,0,0,0,0,0,17533,17534,17534,17534,1,1,1,1,'Whale Staff');
INSERT INTO `synth_recipes` VALUES (3207,0,0,0,0,0,0,0,0,0,13,4099,4241,715,17103,0,0,0,0,0,0,17535,17536,17536,17536,1,1,1,1,'Windurstian Pole');
INSERT INTO `synth_recipes` VALUES (3208,0,0,0,0,0,0,0,0,0,24,4099,4241,714,17130,0,0,0,0,0,0,17537,17538,17538,17538,1,1,1,1,'Windurstian Staff');
INSERT INTO `synth_recipes` VALUES (3209,0,0,0,0,0,0,0,0,0,73,4099,4241,717,17129,0,0,0,0,0,0,17539,17540,17540,17540,1,1,1,1,'Msk. Pole +1');
INSERT INTO `synth_recipes` VALUES (3210,0,0,0,0,0,0,0,0,0,74,4099,4241,719,17128,0,0,0,0,0,0,17541,17542,17542,17542,1,1,1,1,'Bastokan Staff');
INSERT INTO `synth_recipes` VALUES (3211,0,0,0,0,0,0,0,0,21,85,4098,4240,652,711,711,0,0,0,0,0,17543,17544,17544,17544,1,1,1,1,'Battle Staff');
INSERT INTO `synth_recipes` VALUES (3212,0,0,0,0,0,0,0,0,0,75,4098,4240,719,1299,0,0,0,0,0,0,17545,17546,17546,17546,1,1,1,1,'Fire Staff');
INSERT INTO `synth_recipes` VALUES (3213,0,0,0,0,0,0,0,0,0,75,4098,4240,719,1300,0,0,0,0,0,0,17547,17548,17548,17548,1,1,1,1,'Ice Staff');
INSERT INTO `synth_recipes` VALUES (3214,0,0,0,0,0,0,0,0,0,75,4098,4240,719,1301,0,0,0,0,0,0,17549,17550,17550,17550,1,1,1,1,'Wind Staff');
INSERT INTO `synth_recipes` VALUES (3215,0,0,0,0,0,0,0,0,0,75,4098,4240,719,1302,0,0,0,0,0,0,17551,17552,17552,17552,1,1,1,1,'Earth Staff');
INSERT INTO `synth_recipes` VALUES (3216,0,0,0,0,0,0,0,0,0,75,4098,4240,719,1303,0,0,0,0,0,0,17553,17554,17554,17554,1,1,1,1,'Thunder Staff');
INSERT INTO `synth_recipes` VALUES (3217,0,0,0,0,0,0,0,0,0,75,4098,4240,719,1304,0,0,0,0,0,0,17555,17556,17556,17556,1,1,1,1,'Water Staff');
INSERT INTO `synth_recipes` VALUES (3218,0,0,0,0,0,0,0,0,0,75,4098,4240,719,1305,0,0,0,0,0,0,17557,17558,17558,17558,1,1,1,1,'Light Staff');
INSERT INTO `synth_recipes` VALUES (3219,0,0,0,0,0,0,0,0,0,75,4098,4240,719,1306,0,0,0,0,0,0,17559,17560,17560,17560,1,1,1,1,'Dark Staff');
INSERT INTO `synth_recipes` VALUES (3220,0,0,0,0,0,0,0,0,0,66,4098,4240,716,1272,0,0,0,0,0,0,17561,17562,17562,17562,1,1,1,1,'Revenging Staff');
INSERT INTO `synth_recipes` VALUES (3221,0,0,0,0,0,0,0,0,61,100,4098,4240,655,711,711,0,0,0,0,0,17569,17570,17570,17570,1,1,1,1,'Iron-splitter'); -- iron splitter (wood 100 smith 61) https://www.bg-wiki.com/bg/Iron-splitter
INSERT INTO `synth_recipes` VALUES (3222,0,0,0,0,0,0,53,0,47,99,4098,4240,654,745,771,771,914,1762,1762,1813,17590,17591,17591,17591,1,1,1,1,'Primate Staff');
INSERT INTO `synth_recipes` VALUES (3223,0,0,21,0,0,0,0,0,0,102,4098,4240,1814,17590,0,0,0,0,0,0,17592,17592,17592,17592,1,1,1,1,'Kinkobo'); -- kinkobo (wood 102, alch ???)
INSERT INTO `synth_recipes` VALUES (3224,0,0,0,0,0,0,0,0,33,100,4098,4240,726,17569,0,0,0,0,0,0,17596,17596,17596,17596,1,1,1,1,'Steel-splitter');
INSERT INTO `synth_recipes` VALUES (3225,0,0,0,73,0,0,0,0,0,0,4098,4240,719,902,0,0,0,0,0,0,17601,17602,17602,17602,1,1,1,1,'Demons Knife');
INSERT INTO `synth_recipes` VALUES (3226,0,0,45,0,0,0,0,0,0,0,4101,4243,937,4171,16451,0,0,0,0,0,17605,17606,17606,17606,1,1,1,1,'Acid Dagger');
INSERT INTO `synth_recipes` VALUES (3227,0,0,0,41,0,0,0,0,0,0,4098,4240,711,893,0,0,0,0,0,0,17610,17611,17611,17611,1,1,1,1,'Bone Knife');
INSERT INTO `synth_recipes` VALUES (3228,0,0,0,59,0,0,0,0,0,0,4098,4240,716,894,0,0,0,0,0,0,17612,17613,17613,17613,1,1,1,1,'Beetle Knife');
INSERT INTO `synth_recipes` VALUES (3229,0,0,0,0,0,0,0,0,94,0,4096,4238,1286,16470,0,0,0,0,0,0,17625,17625,17625,17625,1,1,1,1,'Ponderous Gully'); -- ponderous gully (smith 94) https://www.bg-wiki.com/bg/Ponderous_Gully
INSERT INTO `synth_recipes` VALUES (3230,0,0,0,84,0,0,0,0,0,0,4098,4240,717,883,0,0,0,0,0,0,17628,17629,17629,17629,1,1,1,1,'Behemoth Knife');
INSERT INTO `synth_recipes` VALUES (3231,0,0,81,0,0,0,0,0,0,0,4098,4240,924,930,1133,16755,0,0,0,0,17630,17631,17631,17631,1,1,1,1,'Hawkers Knife');
INSERT INTO `synth_recipes` VALUES (3232,0,0,0,0,0,0,47,0,72,16,4096,4238,653,653,719,745,745,795,798,2152,17660,17663,17663,17663,1,1,1,1,'Kilij');
INSERT INTO `synth_recipes` VALUES (3233,0,0,0,0,0,0,0,0,33,0,4096,4238,651,16516,0,0,0,0,0,0,17666,17667,17667,17667,1,1,1,1,'Jr.msk. Tuck +1');
INSERT INTO `synth_recipes` VALUES (3234,0,0,0,0,0,0,0,0,32,0,4096,4238,651,16571,0,0,0,0,0,0,17670,17671,17671,17671,1,1,1,1,'T.k. Sword +1');
INSERT INTO `synth_recipes` VALUES (3235,0,0,0,0,0,0,0,0,45,0,4096,4238,653,16806,0,0,0,0,0,0,17672,17673,17673,17673,1,1,1,1,'Bastokan Sword');
INSERT INTO `synth_recipes` VALUES (3236,0,0,0,0,0,0,0,0,46,0,4096,4238,653,16807,0,0,0,0,0,0,17674,17675,17675,17675,1,1,1,1,'Cmb.cst.scmtr. +1');
INSERT INTO `synth_recipes` VALUES (3237,0,0,0,0,0,0,0,0,62,0,4096,4238,653,16810,0,0,0,0,0,0,17676,17677,17677,17677,1,1,1,1,'T.m. Espadon +1');
INSERT INTO `synth_recipes` VALUES (3238,0,0,0,0,0,0,24,0,0,0,4096,4238,650,16544,0,0,0,0,0,0,17678,17679,17679,17679,1,1,1,1,'San Dorian Sword');
INSERT INTO `synth_recipes` VALUES (3239,0,0,0,0,0,0,88,0,0,0,4096,4238,745,914,16529,0,0,0,0,0,17680,17681,17681,17681,1,1,1,1,'Msk. Sword +1');
INSERT INTO `synth_recipes` VALUES (3240,0,0,57,0,0,0,0,0,0,0,4102,4244,5306,16581,0,0,0,0,0,0,17682,17682,17682,17682,1,1,1,1,'Sacred Sword');
INSERT INTO `synth_recipes` VALUES (3241,0,0,61,0,0,0,0,0,0,0,4102,4244,5306,16523,0,0,0,0,0,0,17683,17683,17683,17683,1,1,1,1,'Sacred Degen');
INSERT INTO `synth_recipes` VALUES (3242,0,0,0,0,0,0,36,0,0,0,4099,4241,648,16512,0,0,0,0,0,0,17686,17687,17687,17687,1,1,1,1,'Spark Bilbo'); -- spark bilbo (gold 36) https://www.bg-wiki.com/bg/Spark_Bilbo
INSERT INTO `synth_recipes` VALUES (3243,0,0,0,0,0,0,49,0,0,0,4099,4241,744,16518,0,0,0,0,0,0,17688,17689,17689,17689,1,1,1,1,'Spark Degen');
INSERT INTO `synth_recipes` VALUES (3244,0,0,0,0,0,0,58,0,0,0,4099,4241,653,16521,0,0,0,0,0,0,17690,17691,17691,17691,1,1,1,1,'Spark Rapier');
INSERT INTO `synth_recipes` VALUES (3245,0,0,0,50,0,0,69,0,34,0,4096,4238,652,744,1622,1766,0,0,0,0,17701,17702,17702,17702,1,1,1,1,'Shotel'); -- shotel (gold 69, bone 50, smith 34) https://www.bg-wiki.com/bg/Shotel
INSERT INTO `synth_recipes` VALUES (3246,0,0,0,0,0,0,0,0,97,0,4096,4238,1285,16547,0,0,0,0,0,0,17703,17703,17703,17703,1,1,1,1,'Pealing Anelace');
INSERT INTO `synth_recipes` VALUES (3247,0,0,49,0,0,0,0,0,0,0,4099,4241,637,1775,16543,0,0,0,0,0,17704,17704,17704,17704,1,1,1,1,'Vulcan Sword');
INSERT INTO `synth_recipes` VALUES (3248,0,0,50,0,0,0,0,0,0,0,4099,4241,637,1775,16522,0,0,0,0,0,17705,17705,17705,17705,1,1,1,1,'Vulcan Degen');
INSERT INTO `synth_recipes` VALUES (3249,0,0,52,0,0,0,0,0,0,0,4099,4241,637,1775,16564,0,0,0,0,0,17706,17706,17706,17706,1,1,1,1,'Vulcan Blade');
INSERT INTO `synth_recipes` VALUES (3250,0,0,0,59,0,0,0,0,0,0,4098,4240,1622,5135,17716,0,0,0,0,0,17713,17714,17714,17714,1,1,1,1,'Macuahuitl');
INSERT INTO `synth_recipes` VALUES (3251,0,0,0,0,0,0,45,0,82,12,4096,4238,654,654,719,746,746,786,790,2152,17724,17725,17725,17725,1,1,1,1,'Darksteel Kilij');
INSERT INTO `synth_recipes` VALUES (3252,0,0,0,0,0,0,60,0,95,41,4096,4238,655,655,719,791,812,2152,2275,2275,17727,17728,17728,17728,1,1,1,1,'Adaman Kilij'); -- adaman kilij (smith 95 gold 60 wood 41) https://www.bg-wiki.com/bg/Adaman_Kilij
INSERT INTO `synth_recipes` VALUES (3253,0,0,73,0,0,0,0,0,0,0,4103,4245,2013,2361,17724,0,0,0,0,0,17729,17730,17730,17730,1,1,1,1,'Vermin Slayer');
INSERT INTO `synth_recipes` VALUES (3254,0,0,73,0,0,0,0,0,0,0,4103,4245,2014,2361,17724,0,0,0,0,0,17731,17732,17732,17732,1,1,1,1,'Aquan Slayer');
INSERT INTO `synth_recipes` VALUES (3255,0,0,98,0,0,0,0,0,0,0,4103,4245,2361,2365,17727,0,0,0,0,0,17733,17734,17734,17734,1,1,1,1,'Dragon Slayer');
INSERT INTO `synth_recipes` VALUES (3256,0,0,98,0,0,0,0,0,0,0,4103,4245,1133,2361,17727,0,0,0,0,0,17735,17736,17736,17736,1,1,1,1,'Demon Slayer');
INSERT INTO `synth_recipes` VALUES (3257,0,0,0,0,0,0,18,0,62,29,4096,4238,652,652,679,679,718,800,811,879,17739,17740,17740,17740,1,1,1,1,'Steel Kilij');
INSERT INTO `synth_recipes` VALUES (3258,0,0,84,0,0,0,47,0,0,45,4096,4238,653,663,790,803,931,931,2152,2533,17746,17747,17747,17747,1,1,1,1,'Cermet Kilij'); -- cermet kilij (alch 84, gold 47, wood 45)
INSERT INTO `synth_recipes` VALUES (3259,0,0,0,0,0,0,0,0,46,0,4096,4238,657,852,0,0,0,0,0,0,17776,17777,17777,17777,1,1,1,1,'Hibari');
INSERT INTO `synth_recipes` VALUES (3260,0,0,0,0,0,0,0,0,73,0,4096,4238,652,16902,0,0,0,0,0,0,17778,17779,17779,17779,1,1,1,1,'Muketsu');
INSERT INTO `synth_recipes` VALUES (3261,0,0,0,0,0,0,0,0,58,0,4099,4241,659,662,16919,0,0,0,0,0,17780,17781,17781,17781,1,1,1,1,'Kyofu');
INSERT INTO `synth_recipes` VALUES (3262,0,0,0,0,0,0,0,0,65,0,4099,4241,659,666,16901,0,0,0,0,0,17782,17783,17783,17783,1,1,1,1,'Reppu'); -- reppu (smith 65) https://www.bg-wiki.com/bg/Reppu
INSERT INTO `synth_recipes` VALUES (3263,0,0,0,0,0,0,0,0,76,0,4096,4238,659,664,17778,0,0,0,0,0,17784,17785,17785,17785,1,1,1,1,'Keppu');
INSERT INTO `synth_recipes` VALUES (3264,0,0,0,0,0,0,0,37,61,0,4096,4238,652,652,822,1765,0,0,0,0,17795,17796,17796,17796,1,1,1,1,'Sai');
INSERT INTO `synth_recipes` VALUES (3265,0,0,26,0,0,0,0,0,0,0,4101,4243,937,5298,16906,0,0,0,0,0,17797,17797,17797,17797,1,1,1,1,'Seito');
INSERT INTO `synth_recipes` VALUES (3266,0,0,0,0,0,0,0,0,84,52,4096,4238,651,718,822,16988,0,0,0,0,17816,17817,17817,17817,1,1,1,1,'Kotetsu +1');
INSERT INTO `synth_recipes` VALUES (3267,0,0,0,0,0,0,0,0,88,15,4096,4238,652,718,822,16975,0,0,0,0,17818,17819,17819,17819,1,1,1,1,'Kanesada +1');
INSERT INTO `synth_recipes` VALUES (3268,0,0,0,0,0,0,90,0,0,0,4096,4238,1679,16972,0,0,0,0,0,0,17826,17826,17826,17826,1,1,1,1,'Messhikimaru');
INSERT INTO `synth_recipes` VALUES (3269,0,0,62,0,0,0,0,0,0,0,4099,4241,637,915,1775,16973,0,0,0,0,17828,17828,17828,17828,1,1,1,1,'Koen');
INSERT INTO `synth_recipes` VALUES (3270,0,0,0,29,0,0,0,0,0,0,4098,4240,893,17367,0,0,0,0,0,0,17835,17836,17836,17836,1,1,1,1,'San Dorian Horn');
INSERT INTO `synth_recipes` VALUES (3271,0,0,0,85,0,0,0,0,0,0,4099,4241,2157,2171,0,0,0,0,0,0,17849,17850,17850,17850,1,1,1,1,'Hellish Bugle');
INSERT INTO `synth_recipes` VALUES (3272,0,0,0,0,0,3,0,0,0,0,4101,4243,4389,4389,4389,4389,0,0,0,0,17860,17861,17861,17861,4,2,4,8,'Carrot Broth');
INSERT INTO `synth_recipes` VALUES (3273,0,0,0,0,0,15,0,0,0,0,4101,4243,17395,17395,17397,17397,0,0,0,0,17862,17863,17863,17863,4,2,4,8,'Bug Broth');
INSERT INTO `synth_recipes` VALUES (3274,0,0,0,0,0,7,0,0,0,0,4101,4243,4382,4382,4571,4571,0,0,0,0,17864,17865,17865,17865,4,2,4,8,'Herbal Broth');
INSERT INTO `synth_recipes` VALUES (3275,0,0,0,0,0,11,0,0,0,0,4101,4243,1111,4358,4358,16995,0,0,0,0,17866,17867,17867,17867,4,2,4,8,'Carrion Broth');
INSERT INTO `synth_recipes` VALUES (3276,0,0,0,0,0,0,0,0,0,9,4103,4245,623,690,0,0,0,0,0,0,17868,17869,17869,17869,2,1,1,1,'Humus');
INSERT INTO `synth_recipes` VALUES (3277,0,0,0,0,0,28,0,0,0,0,4101,4243,1111,4358,4359,4372,0,0,0,0,17870,17871,17871,17871,4,2,4,8,'Meat Broth');
INSERT INTO `synth_recipes` VALUES (3278,0,0,0,0,0,0,0,0,0,12,4100,4242,627,694,0,0,0,0,0,0,17872,17873,17873,17873,2,1,1,1,'Tree Sap');
INSERT INTO `synth_recipes` VALUES (3279,0,0,0,0,0,37,0,0,0,0,4101,4243,4360,4360,4360,4360,0,0,0,0,17876,17877,17877,17877,2,1,2,3,'Fish Broth');
INSERT INTO `synth_recipes` VALUES (3280,0,0,0,0,0,45,0,0,0,0,4101,4243,4399,4399,0,0,0,0,0,0,17876,17877,17877,17877,12,4,8,12,'Fish Broth');
INSERT INTO `synth_recipes` VALUES (3281,0,0,0,0,0,45,0,0,0,0,4101,4243,4480,0,0,0,0,0,0,0,17876,17877,17877,17877,4,2,4,6,'Fish Broth');
INSERT INTO `synth_recipes` VALUES (3282,0,0,0,0,0,37,0,0,0,0,4101,4243,5449,5449,5449,5449,0,0,0,0,17876,17877,17877,17877,2,1,2,3,'Fish Broth');
INSERT INTO `synth_recipes` VALUES (3283,0,0,0,0,0,45,0,0,0,0,4101,4243,5450,0,0,0,0,0,0,0,17876,17877,17877,17877,4,2,4,4,'Fish Broth');
INSERT INTO `synth_recipes` VALUES (3284,0,0,0,0,0,45,0,0,0,0,4101,4243,5452,5452,0,0,0,0,0,0,17876,17877,17877,17877,12,4,8,12,'Fish Broth'); -- fish broth (cook 45) https://www.bg-wiki.com/bg/Fish_Broth
INSERT INTO `synth_recipes` VALUES (3285,0,0,86,0,0,0,0,0,0,0,4103,4245,914,923,930,942,0,0,0,0,17882,17882,17882,17882,9,12,12,12,'Alchemist Water');
INSERT INTO `synth_recipes` VALUES (3286,0,0,102,0,0,0,0,0,0,0,4102,4244,914,930,942,1592,0,0,0,0,17884,17884,17884,17884,1,2,3,4,'Sun Water'); -- sun water (alch 102)
INSERT INTO `synth_recipes` VALUES (3287,0,0,0,0,0,52,0,0,0,0,4101,4243,1981,1981,1982,1983,4366,4545,0,0,17885,17886,17886,17886,4,2,4,6,'Grass. Broth');
INSERT INTO `synth_recipes` VALUES (3288,0,0,0,0,0,57,0,0,0,0,4101,4243,1984,1984,1985,2016,17395,17397,0,0,17887,17888,17888,17888,4,2,4,8,'Mole Broth'); -- mole broth (cook 57) https://www.bg-wiki.com/bg/Mole_Broth
INSERT INTO `synth_recipes` VALUES (3289,0,0,0,0,0,63,0,0,0,0,4101,4243,1984,1984,1985,2016,17396,17397,0,0,17887,17888,17888,17888,4,2,4,6,'Mole Broth');
INSERT INTO `synth_recipes` VALUES (3290,0,0,0,0,0,62,0,0,0,0,4101,4243,924,1979,2013,2014,2015,0,0,0,17889,17890,17890,17890,4,2,4,8,'Blood Broth');
INSERT INTO `synth_recipes` VALUES (3291,0,0,0,0,0,73,0,0,0,0,4101,4243,930,1979,2013,2014,2015,0,0,0,17889,17890,17890,17890,4,2,4,6,'Blood Broth');
INSERT INTO `synth_recipes` VALUES (3292,0,0,0,0,0,67,0,0,0,0,4101,4243,1111,1118,1121,1980,1980,0,0,0,17891,17892,17892,17892,4,2,4,6,'Antica Broth');
INSERT INTO `synth_recipes` VALUES (3293,0,0,0,0,0,87,0,0,0,0,4101,4243,1111,1121,1121,1980,1980,0,0,0,17891,17892,17892,17892,4,2,4,6,'Antica Broth');
INSERT INTO `synth_recipes` VALUES (3294,0,0,0,0,0,0,0,0,47,0,4096,4238,653,16648,0,0,0,0,0,0,17929,17930,17930,17930,1,1,1,1,'Bastokan Axe');
INSERT INTO `synth_recipes` VALUES (3295,0,0,0,0,0,0,0,0,56,0,4096,4238,653,16669,0,0,0,0,0,0,17931,17932,17932,17932,1,1,1,1,'Cmb.cst. Axe +1');
INSERT INTO `synth_recipes` VALUES (3296,0,0,0,0,0,0,4,0,32,10,4096,4238,650,652,715,0,0,0,0,0,17942,17943,17943,17943,1,1,1,1,'Tomahawk');
INSERT INTO `synth_recipes` VALUES (3297,0,0,0,0,0,0,0,0,97,0,4096,4238,1284,16659,0,0,0,0,0,0,17949,17949,17949,17949,1,1,1,1,'Furnace Tabarzin');
INSERT INTO `synth_recipes` VALUES (3298,0,2025,0,24,0,0,0,0,0,0,4098,4240,2230,2233,16642,0,0,0,0,0,17954,17954,17954,17954,1,1,1,1,'Jolt Axe');
INSERT INTO `synth_recipes` VALUES (3299,0,0,0,0,0,0,0,0,33,0,4102,4244,16655,0,0,0,0,0,0,0,17955,17955,17955,17955,1,1,1,1,'Plain Pick');
INSERT INTO `synth_recipes` VALUES (3300,0,1993,0,0,0,0,0,0,45,0,4096,4238,2230,2233,16644,0,0,0,0,0,17957,17957,17957,17957,1,1,1,1,'Navy Axe');
INSERT INTO `synth_recipes` VALUES (3301,0,0,0,0,0,0,49,0,0,0,4096,4238,653,16744,0,0,0,0,0,0,17972,17973,17973,17973,1,1,1,1,'San. Dagger');
INSERT INTO `synth_recipes` VALUES (3302,0,0,0,0,0,0,0,0,35,0,4096,4238,653,16745,0,0,0,0,0,0,17974,17975,17975,17975,1,1,1,1,'Bastokan Dagger');
INSERT INTO `synth_recipes` VALUES (3303,0,0,0,0,0,0,0,0,26,0,4096,4238,651,16746,0,0,0,0,0,0,17976,17977,17977,17977,1,1,1,1,'Windurstian Knife');
INSERT INTO `synth_recipes` VALUES (3304,0,0,0,0,0,0,0,0,38,0,4096,4238,652,16747,0,0,0,0,0,0,17978,17979,17979,17979,1,1,1,1,'Windurstian Kukri');
INSERT INTO `synth_recipes` VALUES (3305,0,0,0,0,0,0,38,0,0,0,4099,4241,648,16450,0,0,0,0,0,0,17984,17985,17985,17985,1,1,1,1,'Spark Dagger');
INSERT INTO `synth_recipes` VALUES (3306,0,0,0,0,0,0,50,0,0,0,4099,4241,744,16456,0,0,0,0,0,0,17986,17987,17987,17987,1,1,1,1,'Spark Baselard');
INSERT INTO `synth_recipes` VALUES (3307,0,0,0,0,0,0,60,0,0,0,4099,4241,653,16759,0,0,0,0,0,0,17988,17989,17989,17989,1,1,1,1,'Spark Kris');
INSERT INTO `synth_recipes` VALUES (3308,0,0,0,0,0,0,0,0,42,0,4096,4238,653,16463,0,0,0,0,0,0,17990,17991,17991,17991,1,1,1,1,'Cmb.cst.dagger +1');
INSERT INTO `synth_recipes` VALUES (3309,0,0,17,0,0,0,0,0,0,0,4101,4243,937,5298,16495,0,0,0,0,0,18008,18008,18008,18008,1,1,1,1,'Hushed Dagger');
INSERT INTO `synth_recipes` VALUES (3310,0,0,48,0,0,0,0,0,0,0,4101,4243,5307,17605,0,0,0,0,0,0,18010,18010,18010,18010,1,1,1,1,'Melt Dagger'); -- melt dagger (alch 48)
INSERT INTO `synth_recipes` VALUES (3311,0,0,50,0,0,0,0,0,0,0,4101,4243,5307,16501,0,0,0,0,0,0,18011,18011,18011,18011,1,1,1,1,'Melt Knife'); -- melt knife (alch 50)
INSERT INTO `synth_recipes` VALUES (3312,0,0,65,0,0,0,0,0,0,0,4101,4243,5307,16459,0,0,0,0,0,0,18012,18012,18012,18012,1,1,1,1,'Melt Baselard');
INSERT INTO `synth_recipes` VALUES (3313,0,0,69,0,0,0,0,0,0,0,4101,4243,5307,16479,0,0,0,0,0,0,18013,18013,18013,18013,1,1,1,1,'Melt Kukri');
INSERT INTO `synth_recipes` VALUES (3314,0,0,0,0,0,0,0,0,70,25,4096,4238,654,677,724,0,0,0,0,0,18014,18016,18016,18016,1,1,1,1,'Odorous Knife');
INSERT INTO `synth_recipes` VALUES (3315,0,0,0,91,0,0,60,0,39,0,4096,4238,652,914,1271,2147,2275,0,0,0,18023,18024,18024,18024,1,1,1,1,'Jambiya');
INSERT INTO `synth_recipes` VALUES (3316,0,2001,0,0,0,0,16,0,0,0,4096,4238,2231,2233,16449,0,0,0,0,0,18029,18029,18029,18029,1,1,1,1,'Piercing Dagger');
INSERT INTO `synth_recipes` VALUES (3317,0,0,0,99,0,0,40,0,39,0,4096,4238,652,745,914,2359,2371,0,0,0,18030,18031,18031,18031,1,1,1,1,'Khimaira Jambiya'); -- khimaira jambiya (bone 99 gold 40 smith 39) https://www.bg-wiki.com/bg/Khimaira_Jambiya
INSERT INTO `synth_recipes` VALUES (3318,0,0,90,0,0,0,0,0,0,0,4101,4243,937,5430,18030,0,0,0,0,0,18032,18033,18033,18033,1,1,1,1,'Adder Jambiya');
INSERT INTO `synth_recipes` VALUES (3319,0,2025,0,44,0,0,0,0,0,0,4098,4240,2230,2233,17610,0,0,0,0,0,18035,18035,18035,18035,1,1,1,1,'Deathbone Knife');
INSERT INTO `synth_recipes` VALUES (3320,0,0,0,0,0,0,0,0,83,0,4096,4238,654,16776,0,0,0,0,0,0,18036,18037,18037,18037,1,1,1,1,'Win. Scythe');
INSERT INTO `synth_recipes` VALUES (3321,0,0,0,0,0,0,20,0,0,0,4096,4238,650,16780,0,0,0,0,0,0,18038,18039,18039,18039,1,1,1,1,'Bastokan Scythe');
INSERT INTO `synth_recipes` VALUES (3322,0,0,0,47,0,0,0,0,45,33,4098,4240,654,719,851,1616,0,0,0,0,18050,18051,18051,18051,1,1,1,1,'Mandibular Sickle'); -- mandibular mace (bone 47 smith 45 wood 33) https://www.bg-wiki.com/bg/Mandibular_Sickle
INSERT INTO `synth_recipes` VALUES (3323,0,0,0,67,0,0,53,0,0,31,4098,4240,717,746,851,1770,0,0,0,0,18054,18055,18055,18055,1,1,1,1,'Ivory Sickle'); -- ivory sickle (bone 67 gold 53 wood 31) https://www.bg-wiki.com/bg/Ivory_Sickle
INSERT INTO `synth_recipes` VALUES (3324,0,0,0,0,0,0,94,0,51,19,4096,4238,654,654,713,747,786,824,0,0,18058,18059,18059,18059,1,1,1,1,'Orichalcum Scythe'); -- orichalcum scythe (gold 94 smith 51 wood 19) https://www.bg-wiki.com/bg/Orichalcum_Scythe
INSERT INTO `synth_recipes` VALUES (3325,0,0,0,0,0,0,97,0,0,0,4096,4238,1676,18058,0,0,0,0,0,0,18060,18060,18060,18060,1,1,1,1,'Blizzard Scythe');
INSERT INTO `synth_recipes` VALUES (3326,0,0,0,0,0,0,0,0,35,0,4096,4238,2134,16774,0,0,0,0,0,0,18062,18062,18062,18062,1,1,1,1,'Lucent Scythe');
INSERT INTO `synth_recipes` VALUES (3327,0,2009,0,0,0,0,18,0,0,0,4096,4238,2230,2232,16769,0,0,0,0,0,18067,18067,18067,18067,1,1,1,1,'Keen Zaghnal');
INSERT INTO `synth_recipes` VALUES (3328,0,0,0,0,0,0,0,0,0,23,4099,4241,715,16852,0,0,0,0,0,0,18068,18069,18069,18069,1,1,1,1,'San Dorian Spear');
INSERT INTO `synth_recipes` VALUES (3329,0,0,0,0,0,0,0,0,0,47,4099,4241,715,16844,0,0,0,0,0,0,18070,18071,18071,18071,1,1,1,1,'San. Halberd');
INSERT INTO `synth_recipes` VALUES (3330,0,0,0,0,0,0,0,0,0,46,4099,4241,715,16851,0,0,0,0,0,0,18072,18073,18073,18073,1,1,1,1,'R.k. Lance +1');
INSERT INTO `synth_recipes` VALUES (3331,0,0,0,0,0,0,33,0,0,0,4099,4241,648,16834,0,0,0,0,0,0,18076,18077,18077,18077,1,1,1,1,'Spark Spear'); -- spark spear (gold 33) https://www.bg-wiki.com/bg/Spark_Spear
INSERT INTO `synth_recipes` VALUES (3332,0,0,0,0,0,0,44,0,0,0,4099,4241,744,16845,0,0,0,0,0,0,18078,18079,18079,18079,1,1,1,1,'Spark Lance');
INSERT INTO `synth_recipes` VALUES (3333,0,0,0,0,0,0,53,0,0,0,4099,4241,653,16888,0,0,0,0,0,0,18080,18081,18081,18081,1,1,1,1,'Spark Fork');
INSERT INTO `synth_recipes` VALUES (3334,0,0,0,0,0,0,39,0,50,92,4096,4238,654,654,715,715,745,0,0,0,18082,18083,18083,18083,1,1,1,1,'Barchha');
INSERT INTO `synth_recipes` VALUES (3335,0,0,0,0,0,0,5,0,42,74,4096,4238,650,654,654,715,0,0,0,0,18093,18094,18094,18094,1,1,1,1,'Couse');
INSERT INTO `synth_recipes` VALUES (3336,0,0,0,0,0,0,0,0,0,77,4098,4240,1671,18093,0,0,0,0,0,0,18095,18095,18095,18095,1,1,1,1,'Dispel Couse');
INSERT INTO `synth_recipes` VALUES (3337,0,0,0,0,0,0,60,0,60,100,4096,4238,654,715,715,747,786,0,0,0,18105,18106,18106,18106,1,1,1,1,'Orichalcum Lance');
INSERT INTO `synth_recipes` VALUES (3338,0,0,0,0,0,0,92,0,0,0,4096,4238,1670,18105,0,0,0,0,0,0,18107,18107,18107,18107,1,1,1,1,'Ponderous Lance');
INSERT INTO `synth_recipes` VALUES (3339,0,0,0,0,0,0,0,0,41,0,4096,4238,2135,16845,0,0,0,0,0,0,18108,18108,18108,18108,1,1,1,1,'Lucent Lance');
INSERT INTO `synth_recipes` VALUES (3340,0,0,0,0,0,0,52,0,15,102,4098,4240,686,686,730,746,2304,0,0,0,18110,18111,18111,18111,1,1,1,1,'Mezraq'); -- mezraq (wood 102 gold 52 smith ??) https://www.bg-wiki.com/bg/Mezraq
INSERT INTO `synth_recipes` VALUES (3341,0,0,0,0,0,0,50,0,8,90,4096,4238,652,654,728,2275,0,0,0,0,18115,18116,18116,18116,1,1,1,1,'Engetsuto');
INSERT INTO `synth_recipes` VALUES (3342,0,1985,0,0,0,0,0,0,0,21,4098,4240,2230,2233,16833,0,0,0,0,0,18117,18117,18117,18117,1,1,1,1,'Gimlet Spear');
INSERT INTO `synth_recipes` VALUES (3343,0,0,0,0,0,0,48,0,32,82,4098,4240,654,654,719,746,2304,0,0,0,18118,18119,18119,18119,1,1,1,1,'Dark Mezraq');
INSERT INTO `synth_recipes` VALUES (3344,0,0,0,0,0,0,0,0,0,86,4099,4241,2230,2233,16890,0,0,0,0,0,18122,18122,18122,18122,1,1,1,1,'Broach Lance');
INSERT INTO `synth_recipes` VALUES (3345,0,0,0,0,0,0,60,0,40,106,4098,4240,655,655,2275,2304,2535,0,0,0,18123,18124,18124,18124,1,1,1,1,'Thalassocrat'); -- thalassocrat (wood 106 gold 60 smith ??) https://www.bg-wiki.com/bg/Thalassocrat
INSERT INTO `synth_recipes` VALUES (3346,0,0,0,0,0,0,56,0,0,0,4096,4238,653,17282,0,0,0,0,0,0,18132,18133,18133,18133,1,1,1,1,'Cmb.cst.bmrng +1');
INSERT INTO `synth_recipes` VALUES (3347,0,0,0,0,0,0,65,0,0,0,4096,4238,745,914,17283,0,0,0,0,0,18134,18135,18135,18135,1,1,1,1,'Jr.msk.chakram +1');
INSERT INTO `synth_recipes` VALUES (3348,0,0,0,0,0,0,39,0,0,95,4098,4240,704,752,1414,1414,1415,17152,0,0,18142,18143,18143,18143,1,1,1,1,'Shigeto Bow');
INSERT INTO `synth_recipes` VALUES (3349,0,1987,0,0,0,0,0,0,0,16,4099,4241,715,715,715,1243,1243,1243,1657,0,18148,18148,18148,18148,99,99,99,99,'Acid Bolt');
INSERT INTO `synth_recipes` VALUES (3350,0,0,0,0,0,0,0,0,0,16,4099,4241,715,1243,0,0,0,0,0,0,18148,18148,18148,18148,33,66,99,99,'Acid Bolt');
INSERT INTO `synth_recipes` VALUES (3351,0,1987,0,0,0,0,0,0,0,16,4099,4241,715,715,715,1247,1247,1247,1657,0,18149,18149,18149,18149,99,99,99,99,'Sleep Bolt');
INSERT INTO `synth_recipes` VALUES (3352,0,0,0,0,0,0,0,0,0,16,4099,4241,715,1247,0,0,0,0,0,0,18149,18149,18149,18149,33,66,99,99,'Sleep Bolt');
INSERT INTO `synth_recipes` VALUES (3353,0,1987,0,0,0,0,0,0,0,16,4099,4241,715,715,715,1242,1242,1242,1657,0,18150,18150,18150,18150,99,99,99,99,'Blind Bolt');
INSERT INTO `synth_recipes` VALUES (3354,0,0,0,0,0,0,0,0,0,16,4099,4241,715,1242,0,0,0,0,0,0,18150,18150,18150,18150,33,66,99,99,'Blind Bolt');
INSERT INTO `synth_recipes` VALUES (3355,0,1987,0,0,0,0,0,0,0,16,4099,4241,715,715,715,1246,1246,1246,1657,0,18151,18151,18151,18151,99,99,99,99,'Bloody Bolt');
INSERT INTO `synth_recipes` VALUES (3356,0,0,0,0,0,0,0,0,0,16,4099,4241,715,1246,0,0,0,0,0,0,18151,18151,18151,18151,33,66,99,99,'Bloody Bolt');
INSERT INTO `synth_recipes` VALUES (3357,0,1987,0,0,0,0,0,0,0,16,4099,4241,715,715,715,1245,1245,1245,1657,0,18152,18152,18152,18152,99,99,99,99,'Venom Bolt');
INSERT INTO `synth_recipes` VALUES (3358,0,0,0,0,0,0,0,0,0,16,4099,4241,715,1245,0,0,0,0,0,0,18152,18152,18152,18152,33,66,99,99,'Venom Bolt');
INSERT INTO `synth_recipes` VALUES (3359,0,1987,0,0,0,0,0,0,0,16,4099,4241,715,715,715,1244,1244,1244,1657,0,18153,18153,18153,18153,99,99,99,99,'Holy Bolt');
INSERT INTO `synth_recipes` VALUES (3360,0,0,0,0,0,0,0,0,0,16,4099,4241,715,1244,0,0,0,0,0,0,18153,18153,18153,18153,33,66,99,99,'Holy Bolt');
INSERT INTO `synth_recipes` VALUES (3361,0,0,0,0,0,0,0,0,0,39,4099,4241,705,1221,1248,0,0,0,0,0,18154,18154,18154,18154,33,66,99,99,'Beetle Arrow');
INSERT INTO `synth_recipes` VALUES (3362,0,0,0,0,0,0,0,0,0,59,4099,4241,705,1224,1250,0,0,0,0,0,18155,18155,18155,18155,33,66,99,99,'Scorpion Arrow');
INSERT INTO `synth_recipes` VALUES (3363,0,0,0,0,0,0,0,0,0,49,4099,4241,705,1223,1249,0,0,0,0,0,18156,18156,18156,18156,33,66,99,99,'Horn Arrow');
INSERT INTO `synth_recipes` VALUES (3364,0,0,0,0,0,0,0,0,0,28,4099,4241,705,1221,1252,0,0,0,0,0,18157,18157,18157,18157,33,66,99,99,'Poison Arrow');
INSERT INTO `synth_recipes` VALUES (3365,0,0,0,0,0,0,0,0,0,50,4099,4241,705,1223,1253,0,0,0,0,0,18158,18158,18158,18158,33,66,99,99,'Sleep Arrow');
INSERT INTO `synth_recipes` VALUES (3366,0,0,0,0,0,0,0,0,0,69,4099,4241,705,1251,1254,0,0,0,0,0,18159,18159,18159,18159,33,66,99,99,'Demon Arrow');
INSERT INTO `synth_recipes` VALUES (3367,0,0,71,0,0,0,0,0,13,0,4096,4238,648,649,947,1241,0,0,0,0,18160,18160,18160,18160,33,66,99,99,'Spartan Bullet');
INSERT INTO `synth_recipes` VALUES (3368,0,0,0,0,0,0,100,0,0,0,4096,4238,745,746,747,812,813,914,1271,4570,18168,18169,18169,18169,1,1,1,1,'Imperial Egg');
INSERT INTO `synth_recipes` VALUES (3369,0,0,0,0,0,0,0,0,0,68,4099,4241,705,1254,1627,0,0,0,0,0,18178,18178,18178,18178,33,66,99,99,'Bodkin Arrow');
INSERT INTO `synth_recipes` VALUES (3370,0,0,0,0,0,0,46,0,0,0,4096,4238,663,937,16705,0,0,0,0,0,18200,18201,18201,18201,1,1,1,1,'Hydro Axe');
INSERT INTO `synth_recipes` VALUES (3371,0,0,0,0,0,0,52,0,0,0,4096,4238,663,937,16706,0,0,0,0,0,18202,18203,18203,18203,1,1,1,1,'Hydro Cutter');
INSERT INTO `synth_recipes` VALUES (3372,0,0,0,0,0,0,62,0,0,0,4096,4238,663,937,16724,0,0,0,0,0,18204,18205,18205,18205,1,1,1,1,'Hydro Chopper');
INSERT INTO `synth_recipes` VALUES (3373,0,0,0,0,0,0,0,0,75,23,4096,4238,652,652,654,718,0,0,0,0,18207,18208,18208,18208,1,1,1,1,'Kheten'); -- kheten (smith 75 wood ?) https://www.bg-wiki.com/bg/Kheten
INSERT INTO `synth_recipes` VALUES (3374,0,0,0,0,0,0,21,0,36,5,4096,4238,650,652,652,653,714,0,0,0,18214,18215,18215,18215,1,1,1,1,'Voulge');
INSERT INTO `synth_recipes` VALUES (3375,0,0,0,0,0,0,0,0,39,0,4096,4238,1681,18214,0,0,0,0,0,0,18216,18216,18216,18216,1,1,1,1,'Twicer');
INSERT INTO `synth_recipes` VALUES (3376,0,0,59,0,0,0,48,0,0,9,4096,4238,714,746,931,1772,1772,0,0,0,18218,18219,18219,18219,1,1,1,1,'Leucous Voulge');
INSERT INTO `synth_recipes` VALUES (3377,0,0,45,0,0,0,0,0,0,0,4099,4241,637,1775,16709,0,0,0,0,0,18220,18220,18220,18220,1,1,1,1,'Prominence Axe');
INSERT INTO `synth_recipes` VALUES (3378,0,0,0,0,0,0,26,0,99,51,4096,4238,655,655,655,719,745,797,797,914,18223,18224,18224,18224,1,1,1,1,'Toporok');
INSERT INTO `synth_recipes` VALUES (3379,0,0,0,0,0,0,0,0,99,0,4096,4238,1287,18223,0,0,0,0,0,0,18225,18225,18225,18225,1,1,1,1,'Blizzard Toporok');
INSERT INTO `synth_recipes` VALUES (3380,0,0,0,0,0,0,3,0,76,7,4096,4238,650,654,654,719,745,0,0,0,18226,18227,18227,18227,1,1,1,1,'Darksteel Voulge'); -- darksteel voulge (smith 76 gold ?? wood ??) https://www.bg-wiki.com/bg/Darksteel_Voulge
INSERT INTO `synth_recipes` VALUES (3381,0,0,66,0,0,0,0,0,6,0,4101,4243,648,659,931,936,4108,4509,0,0,18228,18228,18228,18228,99,99,99,99,'Battery');
INSERT INTO `synth_recipes` VALUES (3382,0,0,76,0,0,0,18,0,0,0,4101,4243,659,744,931,936,4108,4509,0,0,18229,18229,18229,18229,99,99,99,99,'Kilo Battery');
INSERT INTO `synth_recipes` VALUES (3383,0,0,86,0,0,0,16,0,31,0,4101,4243,651,744,931,936,4108,4509,0,0,18230,18230,18230,18230,99,99,99,99,'Mega Battery');
INSERT INTO `synth_recipes` VALUES (3384,0,0,54,0,0,0,0,0,0,63,4099,4241,704,710,927,932,937,4109,0,0,18232,18232,18232,18232,66,99,99,99,'Hydro Pump');
INSERT INTO `synth_recipes` VALUES (3385,0,0,54,0,0,0,0,0,0,76,4099,4241,704,710,927,927,932,937,4109,0,18233,18233,18233,18233,66,99,99,99,'Kilo Pump');
INSERT INTO `synth_recipes` VALUES (3386,0,0,54,0,0,0,0,0,0,84,4099,4241,704,710,927,927,927,932,937,4109,18234,18234,18234,18234,66,99,99,99,'Mega Pump');
INSERT INTO `synth_recipes` VALUES (3387,0,0,0,61,0,0,0,0,0,0,4099,4241,889,893,913,922,4106,0,0,0,18236,18236,18236,18236,66,99,99,99,'Wind Fan');
INSERT INTO `synth_recipes` VALUES (3388,0,0,0,71,0,0,0,0,0,0,4099,4241,881,893,913,922,4106,0,0,0,18237,18237,18237,18237,66,99,99,99,'Kilo Fan');
INSERT INTO `synth_recipes` VALUES (3389,0,0,0,83,0,0,0,0,0,0,4099,4241,893,896,913,922,4106,0,0,0,18238,18238,18238,18238,66,99,99,99,'Mega Fan');
INSERT INTO `synth_recipes` VALUES (3390,0,0,0,0,0,0,0,0,42,0,4096,4238,652,652,710,710,0,0,0,0,18258,18258,18258,18258,33,66,99,99,'Thr. Tomahawk');
INSERT INTO `synth_recipes` VALUES (3391,0,0,0,0,0,0,0,0,18,69,4098,4240,651,651,713,713,713,820,0,0,18259,18259,18259,18259,33,66,99,99,'Angon');
INSERT INTO `synth_recipes` VALUES (3392,0,0,0,0,0,0,46,77,25,0,4096,4238,652,652,716,745,1768,0,0,0,18353,18354,18354,18354,1,1,1,1,'Adargas'); -- adargas (leath 77 gold 46 smith 25) https://www.bg-wiki.com/bg/Adargas
INSERT INTO `synth_recipes` VALUES (3393,0,0,20,0,0,0,0,0,0,0,4101,4243,937,5298,16429,0,0,0,0,0,18355,18355,18355,18355,1,1,1,1,'Hushed Baghnakhs');
INSERT INTO `synth_recipes` VALUES (3394,0,0,54,0,0,0,0,0,0,0,4101,4243,5307,16430,0,0,0,0,0,0,18357,18357,18357,18357,1,1,1,1,'Melt Claws');
INSERT INTO `synth_recipes` VALUES (3395,0,0,0,0,0,0,0,0,97,0,4096,4238,1286,16423,0,0,0,0,0,0,18361,18361,18361,18361,1,1,1,1,'Ponder. Manoples');
INSERT INTO `synth_recipes` VALUES (3396,0,0,0,0,0,0,66,0,0,32,4096,4238,650,652,718,745,745,914,0,0,18362,18363,18363,18363,1,1,1,1,'Sainti'); -- sainti (gold 66 wood 32) https://www.bg-wiki.com/bg/Sainti
INSERT INTO `synth_recipes` VALUES (3397,0,0,0,0,0,0,0,0,49,0,4099,4241,659,662,16583,0,0,0,0,0,18366,18367,18367,18367,1,1,1,1,'Gust Claymore');
INSERT INTO `synth_recipes` VALUES (3398,0,0,0,0,0,0,0,0,59,0,4099,4241,659,666,16590,0,0,0,0,0,18368,18369,18369,18369,1,1,1,1,'Gust Sword');
INSERT INTO `synth_recipes` VALUES (3399,0,0,0,0,0,0,0,0,70,0,4099,4241,659,664,16596,0,0,0,0,0,18370,18371,18371,18371,1,1,1,1,'Gust Tongue');
INSERT INTO `synth_recipes` VALUES (3400,0,0,0,0,0,0,22,13,39,0,4096,4238,652,652,652,653,714,792,848,0,18375,18376,18376,18376,1,1,1,1,'Falx');
INSERT INTO `synth_recipes` VALUES (3401,0,0,47,0,0,0,0,0,0,0,4099,4241,637,1775,16588,0,0,0,0,0,18379,18379,18379,18379,1,1,1,1,'Vulcan Claymore');
INSERT INTO `synth_recipes` VALUES (3402,0,0,42,0,0,0,0,0,0,0,4099,4241,637,1775,16594,0,0,0,0,0,18381,18381,18381,18381,1,1,1,1,'Prominence Sword');
INSERT INTO `synth_recipes` VALUES (3403,0,0,0,0,0,0,23,0,79,40,4096,4238,653,654,654,654,719,793,1629,0,18382,18383,18383,18383,1,1,1,1,'Darksteel Falx');
INSERT INTO `synth_recipes` VALUES (3404,0,0,0,0,0,0,0,0,45,0,4096,4238,2134,16589,0,0,0,0,0,0,18384,18384,18384,18384,1,1,1,1,'Lucent Sword');
INSERT INTO `synth_recipes` VALUES (3405,0,0,58,0,0,0,0,0,0,0,4102,4244,5306,17041,0,0,0,0,0,0,18391,18391,18391,18391,1,1,1,1,'Sacred Mace');
INSERT INTO `synth_recipes` VALUES (3406,0,0,74,0,0,0,0,0,0,0,4102,4244,5306,17080,0,0,0,0,0,0,18392,18392,18392,18392,1,1,1,1,'Sacred Maul');
INSERT INTO `synth_recipes` VALUES (3407,0,0,84,0,0,0,0,0,0,0,4102,4244,5306,17085,0,0,0,0,0,0,18393,18393,18393,18393,1,1,1,1,'Sacred Wand');
INSERT INTO `synth_recipes` VALUES (3408,0,0,0,0,0,0,0,0,0,17,4098,4240,2132,17050,0,0,0,0,0,0,18402,18402,18402,18402,1,1,1,1,'Mana Wand');
INSERT INTO `synth_recipes` VALUES (3409,0,0,0,0,0,0,0,0,0,35,4098,4240,2133,17052,0,0,0,0,0,0,18403,18403,18403,18403,1,1,1,1,'High Mana Wand');
INSERT INTO `synth_recipes` VALUES (3410,0,0,0,0,0,0,0,0,91,0,4096,4238,2302,2302,18409,0,0,0,0,0,18405,18406,18406,18406,1,1,1,1,'Jadagna');
INSERT INTO `synth_recipes` VALUES (3411,0,0,58,0,0,0,0,0,0,0,4101,4243,5307,16908,0,0,0,0,0,0,18410,18410,18410,18410,1,1,1,1,'Melt Katana');
INSERT INTO `synth_recipes` VALUES (3412,0,0,0,0,0,0,93,41,0,11,4096,4238,648,657,707,747,786,816,877,0,18413,18414,18414,18414,1,1,1,1,'Hirenjaku'); -- hirenjaku (gold 93 leath 41 wood 11) https://www.bg-wiki.com/bg/Hirenjaku
INSERT INTO `synth_recipes` VALUES (3413,0,0,0,0,0,0,95,0,0,0,4096,4238,1670,18413,0,0,0,0,0,0,18415,18415,18415,18415,1,1,1,1,'Tojaku'); -- tojaku (gold 95) https://www.bg-wiki.com/bg/Tojaku
INSERT INTO `synth_recipes` VALUES (3414,0,0,0,0,0,0,27,0,88,0,4096,4238,686,877,2275,0,0,0,0,0,18420,18421,18421,18421,1,1,1,1,'Hayabusa');
INSERT INTO `synth_recipes` VALUES (3415,0,0,0,0,0,0,13,0,87,42,4096,4238,648,686,707,821,877,2418,0,0,18423,18424,18424,18424,1,1,1,1,'Izayoi');
INSERT INTO `synth_recipes` VALUES (3416,0,1993,0,0,0,0,0,0,66,0,4096,4238,2230,2233,16902,0,0,0,0,0,18427,18427,18427,18427,1,1,1,1,'Hanafubuki');
INSERT INTO `synth_recipes` VALUES (3417,0,0,0,0,0,0,0,46,100,9,4096,4238,650,654,655,655,657,720,818,877,18431,18432,18432,18432,1,1,1,1,'Butachi');
INSERT INTO `synth_recipes` VALUES (3418,0,0,0,0,0,0,0,0,100,0,4096,4238,1284,18431,0,0,0,0,0,0,18433,18433,18433,18433,1,1,1,1,'Kagiroi'); -- kagiroi (smith 100) https://www.bg-wiki.com/bg/Kagiroi
INSERT INTO `synth_recipes` VALUES (3419,0,0,0,0,0,0,94,0,60,54,4096,4238,651,651,657,720,744,877,2275,2304,18439,18440,18440,18440,1,1,1,1,'Shirogatana'); -- shirogatana (gold 94 smith 60 wood 54) https://www.bg-wiki.com/bg/Shirogatana
INSERT INTO `synth_recipes` VALUES (3420,0,2001,0,0,0,0,67,0,0,0,4096,4238,2230,2233,16970,0,0,0,0,0,18444,18444,18444,18444,1,1,1,1,'Tsurugitachi');
INSERT INTO `synth_recipes` VALUES (3421,0,0,0,0,0,0,0,0,44,0,4096,4238,2135,16706,0,0,0,0,0,0,18481,18481,18481,18481,1,1,1,1,'Lucent Axe');
INSERT INTO `synth_recipes` VALUES (3422,0,0,0,0,0,0,101,0,43,41,4096,4238,653,653,654,719,745,798,2275,2275,18482,18483,18483,18483,1,1,1,1,'Amood'); -- amood (gold 101 smith 43 wood 41) https://www.bg-wiki.com/bg/Amood
INSERT INTO `synth_recipes` VALUES (3423,0,1993,0,0,0,0,0,0,26,0,4096,4238,2231,2233,16704,0,0,0,0,0,18488,18488,18488,18488,1,1,1,1,'Assailants Axe');
INSERT INTO `synth_recipes` VALUES (3424,0,0,0,0,0,0,1,0,80,41,4096,4238,652,652,654,654,719,744,790,1858,18489,18490,18490,18490,1,1,1,1,'Dark Amood');
INSERT INTO `synth_recipes` VALUES (3425,0,1993,0,0,0,0,0,0,78,0,4096,4238,2230,2233,18207,0,0,0,0,0,18493,18493,18493,18493,1,1,1,1,'Regiment Kheten'); -- regiment kheten (smith 78) https://www.bg-wiki.com/bg/Regiment%20Kheten
INSERT INTO `synth_recipes` VALUES (3426,0,0,0,0,0,0,0,0,0,65,4098,4240,8817,0,0,0,0,0,0,0,17387,17387,17387,17387,1,1,1,1,'Tarutaru F. Rod'); -- tarutaru fishing rod (kit)
INSERT INTO `synth_recipes` VALUES (3427,0,1985,0,0,0,0,0,0,0,16,4098,4240,2231,2232,17096,0,0,0,0,0,18586,18586,18586,18586,1,1,1,1,'Flexible Pole');
INSERT INTO `synth_recipes` VALUES (3428,0,1985,0,0,0,0,0,0,0,53,4098,4240,2230,2233,17523,0,0,0,0,0,18591,18591,18591,18591,1,1,1,1,'Pastoral Staff');
INSERT INTO `synth_recipes` VALUES (3429,0,0,0,14,33,0,0,0,0,0,4098,4240,937,2150,2150,2171,0,0,0,0,18681,18681,18681,18681,8,16,20,24,'Aht Urhgan Dart');
INSERT INTO `synth_recipes` VALUES (3430,0,0,0,55,0,0,0,0,0,96,4098,4240,730,730,927,2168,2288,0,0,0,18695,18701,18701,18701,1,1,1,1,'Cerberus Bow'); -- cerberus bow (wood 96, bone 55) http://ffxiclopedia.wikia.com/wiki/Cerberus_Bow
INSERT INTO `synth_recipes` VALUES (3431,0,0,0,0,0,0,0,0,0,52,4099,4241,728,2292,2294,0,0,0,0,0,18696,18696,18696,18696,33,66,99,99,'Paralysis Arrow'); -- paralysis arrow (wood 52) https://www.bg-wiki.com/bg/Paralysis_Arrow
INSERT INTO `synth_recipes` VALUES (3432,0,0,0,0,0,0,0,0,0,81,4099,4241,728,2292,2293,0,0,0,0,0,18697,18697,18697,18697,33,66,99,99,'Marid Arrow');
INSERT INTO `synth_recipes` VALUES (3433,0,0,0,0,0,0,0,0,0,57,4099,4241,728,2291,2297,0,0,0,0,0,18698,18698,18698,18698,33,66,99,99,'Water Arrow');
INSERT INTO `synth_recipes` VALUES (3434,0,0,0,0,0,0,0,0,0,57,4099,4241,728,2291,2299,0,0,0,0,0,18699,18699,18699,18699,33,66,99,99,'Earth Arrow');
INSERT INTO `synth_recipes` VALUES (3435,0,0,0,0,0,0,0,0,0,57,4099,4241,728,2291,2298,0,0,0,0,0,18700,18700,18700,18700,33,66,99,99,'Wind Arrow');
INSERT INTO `synth_recipes` VALUES (3436,0,0,0,0,0,0,16,0,67,37,4096,4238,652,654,719,719,744,0,0,0,18704,18705,18705,18705,1,1,1,1,'Darksteel Hexagun'); -- darksteel hexagun (smith 67 wood 37 gold 16) https://www.bg-wiki.com/bg/Darksteel_Hexagun
INSERT INTO `synth_recipes` VALUES (3437,0,0,0,87,0,0,0,0,0,0,4098,4240,2158,2158,2304,0,0,0,0,0,18708,18709,18709,18709,1,1,1,1,'Snakeeye');
INSERT INTO `synth_recipes` VALUES (3438,0,0,0,68,0,0,0,0,43,0,4096,4238,652,652,887,887,0,0,0,0,18710,18711,18711,18711,1,1,1,1,'Seadog Gun'); -- seadog gun (bone 68 smith 43) https://www.bg-wiki.com/bg/Seadog_Gun
INSERT INTO `synth_recipes` VALUES (3439,0,0,26,0,0,0,6,0,0,0,4096,4238,648,947,0,0,0,0,0,0,18713,18713,18713,18713,33,66,99,99,'Copper Bullet'); -- copper bullet (alch 26, gold 6)
INSERT INTO `synth_recipes` VALUES (3440,0,0,0,0,0,0,33,0,57,47,4096,4238,652,652,718,718,744,0,0,0,18715,18716,18716,18716,1,1,1,1,'Marss Hexagun');
INSERT INTO `synth_recipes` VALUES (3441,0,0,48,0,0,0,0,0,30,0,4096,4238,652,947,0,0,0,0,0,0,18723,18723,18723,18723,33,66,99,99,'Steel Bullet'); -- steel bullet (alch 48, smith 30)
INSERT INTO `synth_recipes` VALUES (3442,0,0,0,0,53,0,0,0,0,0,4098,4240,937,2522,2522,2524,0,0,0,0,18726,18726,18726,18726,8,12,16,20,'Peiste Dart');
INSERT INTO `synth_recipes` VALUES (3443,0,0,0,0,0,0,0,0,0,55,4099,4241,2533,2547,2548,0,0,0,0,0,18730,18730,18730,18730,33,66,99,99,'Obsidian Arrow'); -- obsidian arrow (smoth 55) https://www.bg-wiki.com/bg/Obsidian_Arrow
INSERT INTO `synth_recipes` VALUES (3444,0,0,28,0,0,0,0,0,0,0,4101,4243,633,2310,2316,0,0,0,0,0,18731,18732,18732,18733,3,3,3,3,'Automaton Oil');
INSERT INTO `synth_recipes` VALUES (3445,0,0,0,0,0,0,86,0,45,42,4096,4238,652,654,719,746,746,914,0,0,18743,18744,18744,18744,1,1,1,1,'Darksteel Sainti'); -- darksteel sainti (gold 86 smith 45 wood 42) https://www.bg-wiki.com/bg/Darksteel_Sainti
INSERT INTO `synth_recipes` VALUES (3446,0,0,0,0,0,0,54,0,91,43,4096,4238,650,655,719,745,745,914,0,0,18745,18746,18746,18746,1,1,1,1,'Adaman Sainti');
INSERT INTO `synth_recipes` VALUES (3447,0,2017,0,0,0,0,0,20,0,0,4099,4241,2232,2233,16386,0,0,0,0,0,18747,18747,18747,18747,1,1,1,1,'Smash Cesti');
INSERT INTO `synth_recipes` VALUES (3448,0,0,0,101,0,0,0,0,37,49,4098,4240,651,651,730,2168,2168,0,0,0,18748,18749,18749,18749,1,1,1,1,'Hades Sainti'); -- hades sainti (bone 101 wood 49 smith 37) https://www.bg-wiki.com/bg/Hades_Sainti
INSERT INTO `synth_recipes` VALUES (3449,0,0,0,0,0,0,44,76,41,0,4096,4238,654,654,716,745,2122,0,0,0,18750,18751,18751,18751,1,1,1,1,'Black Adargas'); -- black adargas (leath 76 gold 44 smith 41) https://www.bg-wiki.com/bg/Black_Adargas
INSERT INTO `synth_recipes` VALUES (3450,0,2017,0,0,0,0,0,55,0,0,4099,4241,2230,2233,16388,0,0,0,0,0,18755,18755,18755,18755,1,1,1,1,'Noble Himantes');
INSERT INTO `synth_recipes` VALUES (3451,0,0,0,72,0,0,0,0,55,0,4098,4240,650,652,2521,2521,2533,0,0,0,18757,18758,18758,18758,1,1,1,1,'Gnole Sainti'); -- gnole sainti (bone 72, smith 55) https://www.bg-wiki.com/bg/Gnole_Sainti
INSERT INTO `synth_recipes` VALUES (3452,0,0,0,0,0,0,82,46,0,0,4096,4238,879,2418,18405,0,0,0,0,0,18848,18849,18849,18849,1,1,1,1,'Brass Jadagna');
INSERT INTO `synth_recipes` VALUES (3453,0,0,74,0,0,0,0,0,0,0,4102,4244,2230,2233,17080,0,0,0,0,0,18853,18853,18853,18853,1,1,1,1,'Spirit Maul');
INSERT INTO `synth_recipes` VALUES (3454,0,0,0,0,0,0,10,0,85,10,4096,4238,651,651,654,717,745,2529,0,0,18858,18860,18860,18860,1,1,1,1,'Flanged Mace'); -- flanged mage (smith 85, gold ?, wood ?) https://www.bg-wiki.com/bg/Flanged_Mace
INSERT INTO `synth_recipes` VALUES (3455,0,0,0,88,0,0,60,0,55,0,4098,4240,730,879,1467,2147,2275,0,0,0,18941,18942,18942,18942,1,1,1,1,'Naigama'); -- naigama (bone 88, gold 60, smith 55) https://www.bg-wiki.com/bg/Naigama
INSERT INTO `synth_recipes` VALUES (3456,0,2025,0,50,0,0,0,0,0,0,4098,4240,2230,2233,18050,0,0,0,0,0,18945,18945,18945,18945,1,1,1,1,'Jet Sickle');
INSERT INTO `synth_recipes` VALUES (3457,0,1994,0,0,0,0,16,0,0,0,4096,4238,650,650,2143,0,0,0,0,0,19009,19010,19010,19010,1,1,1,1,'Brass Grip'); -- brass grip (gold 16) https://www.bg-wiki.com/bg/Brass_Grip
INSERT INTO `synth_recipes` VALUES (3458,0,0,0,0,0,0,0,12,0,0,4098,4240,852,852,0,0,0,0,0,0,19011,19012,19012,19012,1,1,1,1,'Lizard Strap');
INSERT INTO `synth_recipes` VALUES (3459,0,1994,0,0,0,0,39,0,0,0,4096,4238,653,653,2143,0,0,0,0,0,19013,19014,19014,19014,1,1,1,1,'Mythril Grip');
INSERT INTO `synth_recipes` VALUES (3460,0,0,0,0,0,0,0,53,0,0,4098,4240,853,853,0,0,0,0,0,0,19015,19016,19016,19016,1,1,1,1,'Raptor Strap');
INSERT INTO `synth_recipes` VALUES (3461,0,0,0,0,0,0,0,63,0,0,4098,4240,1637,1637,0,0,0,0,0,0,19017,19018,19018,19018,1,1,1,1,'Bugard Strap'); -- bugard strap (leath 63) https://www.bg-wiki.com/bg/Bugard_Strap
INSERT INTO `synth_recipes` VALUES (3462,0,1994,0,0,0,0,62,0,0,0,4096,4238,746,746,2143,0,0,0,0,0,19019,19020,19020,19020,1,1,1,1,'Platinum Grip');
INSERT INTO `synth_recipes` VALUES (3463,0,0,0,62,0,0,33,0,0,50,4096,4238,654,744,803,914,2506,0,0,0,19103,19104,19104,19104,1,1,1,1,'Darksteel Jambiya'); -- darksteel jambiya (bone 62, smith 50, gold 33) https://www.bg-wiki.com/bg/Darksteel_Jambiya
INSERT INTO `synth_recipes` VALUES (3464,0,0,0,49,0,0,28,0,42,0,4096,4238,650,653,798,2426,0,0,0,0,19105,19106,19106,19106,1,1,1,1,'Thugs Jambiya'); -- thug's jambiya (bone 49, smith 42, gold 28) https://www.bg-wiki.com/bg/Thug's_Jambiya
INSERT INTO `synth_recipes` VALUES (3465,0,0,0,0,0,0,19,0,104,0,4096,4238,655,655,655,655,745,745,745,2535,19151,19152,19152,19152,1,1,1,1,'Bahadur'); -- bahadur (smith 104 gold ??) https://www.bg-wiki.com/bg/Bahadur
INSERT INTO `synth_recipes` VALUES (3466,0,0,0,0,0,0,0,0,0,35,4099,4241,2533,2546,0,0,0,0,0,0,19200,19200,19200,19200,33,66,99,99,'Black Bolt');
INSERT INTO `synth_recipes` VALUES (3467,0,0,75,0,0,0,31,0,0,0,4096,4238,947,2536,0,0,0,0,0,0,19201,19201,19201,19201,33,99,99,99,'Electrum Bullet'); -- electrum bullet (alch 75, gold 31)
INSERT INTO `synth_recipes` VALUES (3468,0,0,0,0,0,0,104,39,0,0,4096,4238,744,747,747,914,2529,18704,0,0,19206,19207,19207,19207,1,1,1,1,'Silver Cassandra'); -- silver cassandra (gold 104 leath 39) https://www.bg-wiki.com/bg/Silver_Cassandra
INSERT INTO `synth_recipes` VALUES (3469,0,0,28,0,0,0,0,0,0,0,4101,4243,919,939,2015,4447,5474,0,0,0,19251,19251,19251,19251,33,66,99,99,'Pet Roborant'); -- pet roborant (alch 28)
INSERT INTO `synth_recipes` VALUES (3470,0,0,36,0,40,0,0,0,0,0,4101,4243,825,826,1882,2507,4154,0,0,0,19252,19252,19252,19252,33,66,99,99,'Pet Poultice');
INSERT INTO `synth_recipes` VALUES (3471,0,0,0,0,0,0,0,0,0,71,4099,4241,8818,0,0,0,0,0,0,0,17357,17357,17357,17357,1,1,1,1,'Ebony Harp'); -- ebony harp (kit)
INSERT INTO `synth_recipes` VALUES (3472,0,0,0,0,0,0,0,0,0,74,4098,4240,9484,0,0,0,0,0,0,0,17014,17014,17014,17014,1,1,1,1,'Hume Fishing Rod'); -- hume fishing rod (kit)
INSERT INTO `synth_recipes` VALUES (3473,0,0,0,0,0,0,0,0,0,81,4099,4241,9485,0,0,0,0,0,0,0,55,55,55,55,1,1,1,1,'Cabinet'); -- cabinet (kit)
INSERT INTO `synth_recipes` VALUES (3474,0,0,0,0,0,0,0,0,0,84,4099,4241,9486,0,0,0,0,0,0,0,12409,12409,12409,12409,1,1,1,1,'Numinous Shield'); -- numinous shield (kit)
INSERT INTO `synth_recipes` VALUES (3475,0,0,0,0,0,0,0,0,0,90,4099,4241,9487,0,0,0,0,0,0,0,17359,17359,17359,17359,1,1,1,1,'Mythic Harp'); -- mythic harp (kit)
INSERT INTO `synth_recipes` VALUES (3476,0,0,0,0,0,72,0,0,0,0,4096,4238,610,633,4298,4570,0,0,0,0,5759,5759,5765,5765,6,8,6,8,'Red Curry Bun'); -- red curry bun (cook 72) https://www.bg-wiki.com/bg/Red_Curry_Bun
INSERT INTO `synth_recipes` VALUES (3477,0,0,0,0,0,98,0,0,0,0,4097,4239,4154,4441,5562,0,0,0,0,0,5411,5411,5411,5411,1,1,1,1,'Dawn Mulsum'); -- dawn mulsum
INSERT INTO `synth_recipes` VALUES (3478,1,0,0,0,0,0,0,0,17,0,4100,4242,12560,0,0,0,0,0,0,0,649,850,852,852,4,4,1,1,'Bronze Ingot');
INSERT INTO `synth_recipes` VALUES (3479,0,0,0,0,77,0,0,0,0,0,4098,4240,2150,2150,0,0,0,0,0,0,2649,2649,2649,2649,6,8,10,12,'Colibri Fltchg.');
INSERT INTO `synth_recipes` VALUES (3480,0,2011,0,0,77,0,0,0,0,0,4098,4240,2145,2150,2150,2150,2150,2150,2150,0,2649,2649,2649,2649,18,24,30,36,'Colibri Fltchg.');
INSERT INTO `synth_recipes` VALUES (3481,0,0,0,0,0,0,0,0,70,0,4096,4238,654,2538,2764,0,0,0,0,0,17762,17762,17762,17762,1,1,1,1,'Erlkings Sword'); -- erlking's sword (smith 70) https://www.bg-wiki.com/bg/Erlking%27s_Sword
INSERT INTO `synth_recipes` VALUES (3482,0,0,43,0,0,0,0,0,16,0,4096,4238,659,947,0,0,0,0,0,0,19229,19229,19229,19229,33,99,99,99,'Tin Bullet');
INSERT INTO `synth_recipes` VALUES (3483,0,0,0,0,0,0,0,0,0,94,4098,4240,9488,0,0,0,0,0,0,0,21134,21134,21134,21134,1,1,1,1,'Sasah Wand'); -- sasah wand (kit)
INSERT INTO `synth_recipes` VALUES (3484,0,0,0,0,0,56,0,0,0,0,4096,4238,619,893,4358,4382,4389,0,0,0,5752,5752,5753,5753,2,4,2,4,'Pot-au-feu');
INSERT INTO `synth_recipes` VALUES (3485,0,0,0,0,0,54,0,0,0,0,4096,4238,610,633,4517,4570,0,0,0,0,5757,5757,5763,5763,6,8,6,8,'Ylw. Curry Bun');
INSERT INTO `synth_recipes` VALUES (3486,0,0,0,0,0,45,0,0,0,0,4096,4238,619,4377,4390,4509,5740,0,0,0,5750,5751,5751,5751,1,1,1,1,'Goulash');
INSERT INTO `synth_recipes` VALUES (3487,0,0,0,0,0,45,0,0,0,0,4096,4238,619,4390,4509,5667,5740,0,0,0,5750,5751,5751,5751,1,1,1,1,'Goulash');
INSERT INTO `synth_recipes` VALUES (3488,1,0,0,0,96,0,0,0,0,0,4100,4242,14875,0,0,0,0,0,0,0,834,834,823,823,1,1,1,1,'Saruta Cotton');
INSERT INTO `synth_recipes` VALUES (3489,1,0,0,0,0,0,0,0,34,0,4100,4242,16467,0,0,0,0,0,0,0,710,710,1226,1226,1,1,4,6,'Chestnut Lumber');
INSERT INTO `synth_recipes` VALUES (3490,1,0,0,0,0,0,0,58,0,0,4100,4242,12572,0,0,0,0,0,0,0,850,850,853,853,1,1,1,2,'Sheep Leather');
INSERT INTO `synth_recipes` VALUES (3491,1,0,0,0,0,0,60,0,0,0,4100,4242,13445,0,0,0,0,0,0,0,745,745,745,745,1,1,2,2,'Gold Ingot');
INSERT INTO `synth_recipes` VALUES (3492,1,0,0,0,0,0,0,0,0,55,4100,4242,17098,0,0,0,0,0,0,0,716,716,716,716,1,2,2,2,'Oak Lumber');
INSERT INTO `synth_recipes` VALUES (3493,1,0,0,0,0,0,0,0,0,64,4100,4242,17350,0,0,0,0,0,0,0,917,917,718,813,1,1,1,1,'Parchment');
INSERT INTO `synth_recipes` VALUES (3494,1,0,0,65,0,0,0,0,0,0,4100,4242,15815,0,0,0,0,0,0,0,2506,2506,2506,2506,1,1,1,1,'Ladybug Wing');
INSERT INTO `synth_recipes` VALUES (3495,1,0,0,0,26,0,0,0,0,0,4100,4242,12841,0,0,0,0,0,0,0,817,818,818,818,1,3,5,6,'Grass Thread');
INSERT INTO `synth_recipes` VALUES (3496,1,0,0,0,0,0,0,0,9,0,4100,4242,12432,0,0,0,0,0,0,0,649,850,850,850,1,1,1,1,'Bronze Ingot');
INSERT INTO `synth_recipes` VALUES (3497,1,0,0,0,0,0,0,19,0,0,4100,4242,12569,0,0,0,0,0,0,0,850,852,852,852,1,1,2,3,'Sheep Leather');
INSERT INTO `synth_recipes` VALUES (3498,1,0,0,0,0,0,34,0,0,0,4100,4242,12817,0,0,0,0,0,0,0,817,818,650,650,6,1,2,2,'Grass Thread');
INSERT INTO `synth_recipes` VALUES (3499,1,0,0,0,0,0,57,0,0,0,4100,4242,13315,0,0,0,0,0,0,0,745,745,745,745,1,1,2,2,'Gold Ingot');
INSERT INTO `synth_recipes` VALUES (3500,1,0,0,0,0,0,0,0,0,87,4100,4242,17380,0,0,0,0,0,0,0,821,821,721,721,1,1,1,1,'Rainbow Thread');
INSERT INTO `synth_recipes` VALUES (3501,1,0,57,0,0,0,0,0,0,86,4100,4242,16849,0,0,0,0,0,0,0,715,715,931,931,1,2,1,2,'Ash Lumber');
INSERT INTO `synth_recipes` VALUES (3502,0,0,0,0,0,1,0,0,0,11,4098,4240,704,4392,4392,4392,4392,0,0,0,3697,3697,3697,3697,1,1,1,1,'Mandarin'); -- mandarin
INSERT INTO `synth_recipes` VALUES (3503,1,0,0,0,0,0,75,0,0,0,4100,4242,13488,0,0,0,0,0,0,0,745,745,745,791,1,1,2,1,'Gold Ingot');
INSERT INTO `synth_recipes` VALUES (3504,1,0,0,0,0,0,75,0,0,0,4100,4242,13489,0,0,0,0,0,0,0,745,745,745,801,1,1,2,1,'Gold Ingot');
INSERT INTO `synth_recipes` VALUES (3505,1,0,0,0,0,0,75,0,0,0,4100,4242,13487,0,0,0,0,0,0,0,745,745,745,810,1,1,2,1,'Gold Ingot');
INSERT INTO `synth_recipes` VALUES (3506,1,0,0,0,0,0,75,0,0,0,4100,4242,13484,0,0,0,0,0,0,0,745,745,745,784,1,1,2,1,'Gold Ingot');
INSERT INTO `synth_recipes` VALUES (3507,1,0,0,0,0,0,75,0,0,0,4100,4242,13491,0,0,0,0,0,0,0,745,745,745,802,1,1,2,1,'Gold Ingot');
INSERT INTO `synth_recipes` VALUES (3508,1,0,0,0,0,0,75,0,0,0,4100,4242,13485,0,0,0,0,0,0,0,745,745,745,803,1,1,2,1,'Gold Ingot');
INSERT INTO `synth_recipes` VALUES (3509,1,0,0,0,0,0,75,0,0,0,4100,4242,13486,0,0,0,0,0,0,0,745,745,745,805,1,1,2,1,'Gold Ingot');
INSERT INTO `synth_recipes` VALUES (3510,1,0,0,0,0,0,75,0,0,0,4100,4242,13490,0,0,0,0,0,0,0,745,745,745,797,1,1,2,1,'Gold Ingot');
INSERT INTO `synth_recipes` VALUES (3511,1,0,0,0,0,0,58,0,0,0,4100,4242,13849,0,0,0,0,0,0,0,745,745,745,745,1,1,1,1,'Gold Ingot');
INSERT INTO `synth_recipes` VALUES (3512,1,0,0,0,0,0,0,0,65,0,4100,4242,2652,0,0,0,0,0,0,0,651,651,1615,653,2,2,1,1,'Iron Ingot');
INSERT INTO `synth_recipes` VALUES (3513,1,0,0,0,0,0,0,0,76,0,4100,4242,2653,0,0,0,0,0,0,0,651,651,654,1629,1,1,1,1,'Iron Ingot');
INSERT INTO `synth_recipes` VALUES (3514,1,0,0,0,0,0,0,0,94,0,4100,4242,2505,0,0,0,0,0,0,0,652,659,653,654,2,2,2,2,'Steel Ingot');
INSERT INTO `synth_recipes` VALUES (3515,1,0,0,0,0,0,0,0,94,0,4100,4242,2504,0,0,0,0,0,0,0,652,653,654,1711,1,1,1,1,'Steel Ingot');
INSERT INTO `synth_recipes` VALUES (3516,1,0,0,0,0,0,0,0,47,0,4100,4242,2510,0,0,0,0,0,0,0,651,652,652,1629,2,2,2,1,'Iron Ingot');
INSERT INTO `synth_recipes` VALUES (3517,1,0,0,0,0,0,0,0,47,0,4100,4242,2511,0,0,0,0,0,0,0,651,652,652,1629,1,1,1,1,'Iron Ingot');
INSERT INTO `synth_recipes` VALUES (3518,1,0,0,0,0,0,0,50,0,0,4098,4240,2519,0,0,0,0,0,0,0,1629,2529,666,676,1,1,1,1,'Buffalo Leather');
INSERT INTO `synth_recipes` VALUES (3519,1,0,0,0,0,0,0,0,95,0,4100,4242,2356,0,0,0,0,0,0,0,2275,2275,2275,2275,1,2,2,2,'Scintillant Ingot'); -- Synth level estimated
INSERT INTO `synth_recipes` VALUES (3520,1,0,0,0,0,0,0,0,95,0,4100,4242,2355,0,0,0,0,0,0,0,812,686,686,686,1,1,2,2,'Deathstone'); -- Synth level estimated, Possible sub?
INSERT INTO `synth_recipes` VALUES (3521,0,0,0,0,0,0,0,86,0,0,4103,4245,878,2711,4509,0,0,0,0,0,2703,2703,2703,2703,1,1,1,1,'Khrom. Leather'); -- khromated leather (leather 86)
INSERT INTO `synth_recipes` VALUES (3522,0,2018,0,0,0,0,0,86,0,0,4103,4245,878,878,878,2129,2711,2711,2711,4509,2703,2703,2703,2703,3,3,3,3,'Khrom. Leather'); -- khromated leather (leather 86)
INSERT INTO `synth_recipes` VALUES (3523,1,0,0,87,0,0,0,0,0,0,4100,4242,13987,0,0,0,0,0,0,0,893,893,887,887,1,1,1,2,'Giant Femur');
INSERT INTO `synth_recipes` VALUES (3524,1,0,0,0,0,0,86,0,0,0,4100,4242,17065,0,0,0,0,0,0,0,652,652,745,746,1,1,1,1,'Steel Ingot');
INSERT INTO `synth_recipes` VALUES (3525,1,0,0,0,0,0,0,89,0,0,4100,4242,12575,0,0,0,0,0,0,0,850,506,506,506,1,1,2,2,'Sheep Leather');
INSERT INTO `synth_recipes` VALUES (3526,0,0,0,0,0,0,33,0,67,33,4096,4238,654,719,719,744,2764,0,0,0,18737,18737,18737,18737,1,1,1,1,'Fane Hexagun'); -- fane hexagun (smith 67 wood ? gold ?) https://www.bg-wiki.com/bg/Fane_Hexagun
INSERT INTO `synth_recipes` VALUES (3527,0,0,0,0,0,0,18,0,59,25,4096,4238,650,652,652,707,744,0,0,0,19226,19227,19227,19227,1,1,1,1,'Blunderbuss');
INSERT INTO `synth_recipes` VALUES (3528,1,0,0,0,0,0,0,0,57,0,4100,4242,18715,0,0,0,0,0,0,0,652,718,652,718,1,1,2,2,'Steel Ingot');
INSERT INTO `synth_recipes` VALUES (3529,0,0,0,0,0,0,19,0,43,21,4096,4238,649,649,650,712,0,0,0,0,19224,19225,19225,19225,1,1,1,1,'Musketoon');
INSERT INTO `synth_recipes` VALUES (3530,1,0,0,0,0,0,0,0,43,0,4100,4242,19224,0,0,0,0,0,0,0,649,649,650,650,1,1,1,1,'Bronze Ingot');
INSERT INTO `synth_recipes` VALUES (3531,0,0,72,0,0,0,0,0,19,0,4096,4238,947,1635,0,0,0,0,0,0,19228,19228,19228,19228,33,99,99,99,'Paktong Bullet'); -- paktong bullet (alch 72, smith 19)
INSERT INTO `synth_recipes` VALUES (3532,1,0,0,73,0,0,0,0,0,0,4100,4242,17601,0,0,0,0,0,0,0,719,719,902,902,1,1,1,1,'Ebony Lumber');
INSERT INTO `synth_recipes` VALUES (3533,0,0,10,0,0,0,0,0,0,0,4099,4241,2773,2773,2774,2774,2775,4162,0,0,2782,2782,2782,2782,1,1,1,1,'Enfeeb. Kit Silence');
INSERT INTO `synth_recipes` VALUES (3534,0,0,0,0,0,0,0,0,0,5,4099,4241,1134,1134,2778,0,0,0,0,0,2775,2775,2775,2775,1,1,1,1,'Padded Box'); -- padded box (wood 5) https://www.bg-wiki.com/bg/Padded_Box
INSERT INTO `synth_recipes` VALUES (3535,0,0,0,0,0,0,0,6,0,0,4103,4245,917,2776,0,0,0,0,0,0,2773,2773,2773,2773,1,1,1,1,'Fine Parchment');
INSERT INTO `synth_recipes` VALUES (3536,0,0,6,0,0,0,0,0,0,0,4103,4245,929,2777,0,0,0,0,0,0,2774,2774,2774,2774,1,1,1,1,'Enchanted Ink');
INSERT INTO `synth_recipes` VALUES (3537,0,0,10,0,0,0,0,0,0,0,4099,4241,2773,2773,2774,2774,2775,4157,0,0,2779,2779,2779,2779,1,1,1,1,'Enfeeb. Kit Poison');
INSERT INTO `synth_recipes` VALUES (3538,0,0,10,0,0,0,0,0,0,0,4099,4241,2773,2773,2774,2774,2775,4163,0,0,2780,2780,2780,2780,1,1,1,1,'Enfeeb. Kit Blind');
INSERT INTO `synth_recipes` VALUES (3539,0,0,10,0,0,0,0,0,0,0,4099,4241,2773,2773,2774,2774,2775,4161,0,0,2781,2781,2781,2781,1,1,1,1,'Enfeeb. Kit Sleep');
INSERT INTO `synth_recipes` VALUES (3540,1,0,0,0,0,0,70,0,0,0,4100,4242,13983,0,0,0,0,0,0,0,745,745,745,775,1,1,2,2,'Gold Ingot');
INSERT INTO `synth_recipes` VALUES (3541,1,0,0,0,0,0,70,0,0,0,4100,4242,13984,0,0,0,0,0,0,0,745,745,745,775,1,1,2,2,'Gold Ingot');
INSERT INTO `synth_recipes` VALUES (3542,1,0,0,0,0,0,0,99,0,0,4100,4242,12701,0,0,0,0,0,0,0,850,851,855,862,2,1,1,1,'Sheep Leather');
INSERT INTO `synth_recipes` VALUES (3543,1,0,0,0,0,0,0,40,0,0,4100,4242,12787,0,0,0,0,0,0,0,850,851,851,851,2,2,2,2,'Sheep Leather');
INSERT INTO `synth_recipes` VALUES (3544,0,2042,0,0,0,85,0,0,0,0,4098,4240,627,1523,4363,4392,4432,4445,4468,5703,6063,6064,6064,6064,1,1,1,1,'Fruit Parfait');
INSERT INTO `synth_recipes` VALUES (3545,0,0,0,0,0,81,0,0,0,0,4096,4238,1471,1524,2215,4509,0,0,0,0,6262,6263,6263,6263,2,2,3,4,'Kusamochi');
INSERT INTO `synth_recipes` VALUES (3546,0,0,0,0,0,81,0,0,0,0,4096,4238,627,1471,2215,4509,8800,0,0,0,6260,6261,6261,6261,2,2,3,4,'Akamochi');
INSERT INTO `synth_recipes` VALUES (3547,0,0,0,0,0,81,0,0,0,0,4096,4238,627,1471,2215,4509,5541,5541,8800,0,6343,6344,6344,6344,2,2,3,4,'Grape Daifuku');
INSERT INTO `synth_recipes` VALUES (3548,0,0,0,0,0,105,0,0,0,0,4101,4243,4370,4378,5662,5662,0,0,0,0,5933,5933,5933,5933,1,1,1,1,'D. Fruit Au Lait'); -- Dragon Fruit au Lait
INSERT INTO `synth_recipes` VALUES (3549,0,0,0,0,0,100,0,0,0,0,4101,4243,4273,4273,4273,4273,0,0,0,0,5932,5932,5932,5932,1,1,1,1,'Kitron Juice'); -- synth level estimated
INSERT INTO `synth_recipes` VALUES (3550,0,0,99,0,0,0,0,0,0,0,4102,4244,4154,4154,5306,13446,0,0,0,0,10790,10791,10791,10791,1,1,1,1,'Ephedra Ring'); -- Ephedra Ring
INSERT INTO `synth_recipes` VALUES (3551,0,0,99,0,0,0,0,0,0,0,4102,4244,4154,4154,5306,13466,0,0,0,0,10792,10793,10793,10793,1,1,1,1,'Saida Ring'); -- Saida Ring
INSERT INTO `synth_recipes` VALUES (3552,0,0,104,0,0,0,0,0,0,0,4103,4245,914,930,942,8710,0,0,0,0,17913,17913,17913,17913,4,6,8,10,'Saline Broth'); -- Saline Broth
INSERT INTO `synth_recipes` VALUES (3553,0,0,104,0,0,0,0,0,60,0,4098,4240,914,937,3549,3936,8748,0,0,0,8927,8927,8927,8927,6,8,10,12,'Abr. Bolt Heads'); -- Abrasion Bolt Heads
INSERT INTO `synth_recipes` VALUES (3554,0,0,0,0,0,0,0,0,3,14,4099,4241,649,721,721,728,2770,0,0,0,371,371,371,371,1,1,1,1,'Butterfly Cage'); -- butterfly cage
INSERT INTO `synth_recipes` VALUES (3555,0,0,110,0,0,0,0,0,0,0,4103,4245,924,1133,1626,2015,2229,2361,2365,17727,18914,18915,18915,18915,1,1,1,1,'Killers Kilij'); -- Killer's Kilij
INSERT INTO `synth_recipes` VALUES (3556,0,0,113,0,0,0,0,0,0,0,4103,4245,1133,4015,16577,0,0,0,0,0,20723,20724,20724,20724,1,1,1,1,'Dija Sword'); -- Dija Sword (alch 113)
INSERT INTO `synth_recipes` VALUES (3557,0,0,0,0,0,0,81,0,0,0,4098,4240,3520,0,0,0,0,0,0,0,803,786,767,8919,1,1,1,1,'Sunstone'); -- Ifritite
INSERT INTO `synth_recipes` VALUES (3558,0,0,0,0,0,0,81,0,0,0,4098,4240,3521,0,0,0,0,0,0,0,805,787,808,8924,1,1,1,1,'Zircon'); -- Shivite
INSERT INTO `synth_recipes` VALUES (3559,0,0,0,0,0,0,81,0,0,0,4098,4240,3522,0,0,0,0,0,0,0,784,785,779,8922,1,1,1,1,'Jadeite'); -- Garudite
INSERT INTO `synth_recipes` VALUES (3560,0,0,0,0,0,0,81,0,0,0,4098,4240,3523,0,0,0,0,0,0,0,801,789,778,8923,1,1,1,1,'Chrysoberyl'); -- Titanite
INSERT INTO `synth_recipes` VALUES (3561,0,0,0,0,0,0,81,0,0,0,4098,4240,3524,0,0,0,0,0,0,0,810,804,777,8921,1,1,1,1,'Fluorite'); -- Ramuite
INSERT INTO `synth_recipes` VALUES (3562,0,0,0,0,0,0,81,0,0,0,4098,4240,3525,0,0,0,0,0,0,0,791,794,781,8920,1,1,1,1,'Aquamarine'); -- Leviatite
INSERT INTO `synth_recipes` VALUES (3563,0,0,0,0,0,0,81,0,0,0,4098,4240,3526,0,0,0,0,0,0,0,802,813,782,8925,1,1,1,1,'Moonstone'); -- Carbite
INSERT INTO `synth_recipes` VALUES (3564,0,0,0,0,0,0,81,0,0,0,4098,4240,3527,0,0,0,0,0,0,0,797,812,783,8926,1,1,1,1,'Painite'); -- Fenrite
INSERT INTO `synth_recipes` VALUES (3565,0,0,0,0,0,0,51,0,0,0,4098,4240,3297,0,0,0,0,0,0,0,807,790,803,3316,1,1,1,1,'Sardonyx'); -- Flame Gem
INSERT INTO `synth_recipes` VALUES (3566,0,0,0,0,0,0,51,0,0,0,4098,4240,3298,0,0,0,0,0,0,0,809,808,805,3317,1,1,1,1,'Clear Topaz'); -- Snow Gem
INSERT INTO `synth_recipes` VALUES (3567,0,0,0,0,0,0,51,0,0,0,4098,4240,3299,0,0,0,0,0,0,0,806,788,784,3318,1,1,1,1,'Tourmaline'); -- Breeze Gem
INSERT INTO `synth_recipes` VALUES (3568,0,0,0,0,0,0,51,0,0,0,4098,4240,3300,0,0,0,0,0,0,0,814,815,801,3319,1,1,1,1,'Amber'); -- Soil Gem
INSERT INTO `synth_recipes` VALUES (3569,0,0,0,0,0,0,51,0,0,0,4098,4240,3301,0,0,0,0,0,0,0,800,811,810,3320,1,1,1,1,'Amethyst'); -- Thunder Gem
INSERT INTO `synth_recipes` VALUES (3570,0,0,0,0,0,0,51,0,0,0,4098,4240,3302,0,0,0,0,0,0,0,795,798,791,3321,1,1,1,1,'Lapis Lazuli'); -- Aqua Gem
INSERT INTO `synth_recipes` VALUES (3571,0,0,0,0,0,0,51,0,0,0,4098,4240,3303,0,0,0,0,0,0,0,796,796,802,3322,1,1,1,1,'Light Opal'); -- Light Gem
INSERT INTO `synth_recipes` VALUES (3572,0,0,0,0,0,0,51,0,0,0,4098,4240,3304,0,0,0,0,0,0,0,799,799,797,3323,1,1,1,1,'Onyx'); -- Shadow Gem
INSERT INTO `synth_recipes` VALUES (3573,0,0,0,0,0,0,93,0,0,0,4096,4238,3922,3922,3922,3922,0,0,0,0,3923,3923,3923,3923,1,1,1,1,'Rhodium Ingot'); -- Rhodium ingot
INSERT INTO `synth_recipes` VALUES (3574,0,0,0,0,0,0,98,0,0,0,4096,4238,741,741,741,741,0,0,0,0,742,742,742,742,1,1,1,1,'P. Brass Ingot'); -- Palladian Brass Ingot
INSERT INTO `synth_recipes` VALUES (3575,0,0,0,0,0,0,100,0,0,0,4096,4238,742,0,0,0,0,0,0,0,755,755,755,755,1,1,1,1,'P. Brass Sheet'); -- Palladian Brass Sheet
INSERT INTO `synth_recipes` VALUES (3576,0,0,0,0,0,0,100,0,30,0,4096,4238,755,758,12680,0,0,0,0,0,10544,10545,10545,10545,1,1,1,1,'Ugol Moufles'); -- Ugol Moufles (gold 100 smith 30) https://www.bg-wiki.com/bg/Ugol_Moufles
INSERT INTO `synth_recipes` VALUES (3577,0,0,0,0,0,0,102,0,0,0,4099,4241,742,742,0,0,0,0,0,0,765,765,765,765,1,2,3,4,'P. Brass Chain'); -- Palladian Brass Chain
INSERT INTO `synth_recipes` VALUES (3578,0,0,0,0,0,0,102,0,33,0,4096,4238,755,758,12936,0,0,0,0,0,10641,10642,10642,10642,1,1,1,1,'Ugol Sollerets'); -- Ugol Solerets (gold 102 smith 33) https://www.bg-wiki.com/bg/Ugol_Solerets
INSERT INTO `synth_recipes` VALUES (3579,0,0,0,0,22,0,103,35,0,0,4096,4238,759,765,826,873,873,0,0,0,10575,10576,10576,10576,1,1,1,1,'Ugol Brayettes'); -- Ugol Bryettes (gold 103 leath 35 cloth 22) https://www.bg-wiki.com/bg/Ugol_Brayettes
INSERT INTO `synth_recipes` VALUES (3580,0,0,0,0,0,0,103,0,0,0,4096,4238,755,757,765,1977,2275,2275,0,0,10410,10411,10411,10411,1,1,1,1,'Ugol Salade'); -- Ugol Salade
INSERT INTO `synth_recipes` VALUES (3581,0,0,0,0,33,0,105,0,0,0,4096,4238,755,757,758,765,765,765,828,829,10494,10495,10495,10495,1,1,1,1,'Ugol Haubert'); -- Ugol Haubert (gold 105 cloth 33) https://www.bg-wiki.com/bg/Ugol_Haubert
INSERT INTO `synth_recipes` VALUES (3582,0,0,60,0,0,0,113,0,0,0,4096,4238,766,914,3927,3980,0,0,0,0,21129,21130,21130,21130,1,1,1,1,'Sharur'); -- Sharur
INSERT INTO `synth_recipes` VALUES (3583,0,0,0,0,60,0,115,60,0,0,4096,4238,766,823,3548,3923,9004,9004,0,0,26875,26876,26876,26876,1,1,1,1,'Rav. Breastplate'); -- Ravenous Breastplate
INSERT INTO `synth_recipes` VALUES (3584,0,0,0,100,0,0,0,0,0,0,4098,4240,2371,2371,0,0,0,0,0,0,11058,11058,11059,11059,1,1,1,1,'Hajduk Ring'); -- Hajduk Ring
INSERT INTO `synth_recipes` VALUES (3585,0,0,0,100,0,0,0,0,0,0,4099,4241,823,867,885,3552,12952,0,0,0,10363,10364,10364,10364,1,1,1,1,'Dux Greaves'); -- Dux Cussies
INSERT INTO `synth_recipes` VALUES (3586,0,0,0,100,60,0,0,60,0,0,4099,4241,836,860,8708,8708,8982,8983,0,0,27398,27399,27399,27399,1,1,1,1,'Sombra Leggings'); -- Sombra Leggings (behemoth hide) https://www.bg-wiki.com/bg/Sombra_Leggings
INSERT INTO `synth_recipes` VALUES (3587,0,0,50,102,0,0,0,0,0,0,4098,4240,1311,1715,4154,4154,5306,0,0,0,10794,10795,10795,10795,1,1,1,1,'Blenmots Ring'); -- Blenmot's Ring (bone 102, alch 50)
INSERT INTO `synth_recipes` VALUES (3588,0,0,0,102,60,0,0,60,0,0,4099,4241,830,836,8708,8982,8982,8983,8983,0,26883,26884,26884,26884,1,1,1,1,'Sombra Harness'); -- Sombra Harness
INSERT INTO `synth_recipes` VALUES (3589,0,0,0,103,0,0,0,0,0,0,4099,4241,823,850,867,885,3445,3552,0,0,10346,10347,10347,10347,1,1,1,1,'Dux Cuisses'); -- Dux Cussies
INSERT INTO `synth_recipes` VALUES (3590,0,0,0,104,0,0,0,0,0,0,4098,4240,867,885,3445,3552,0,0,0,0,10434,10435,10435,10435,1,1,1,1,'Dux Visor'); -- Dux Visor
INSERT INTO `synth_recipes` VALUES (3591,0,0,0,104,0,0,0,60,0,0,4099,4241,819,869,8977,8981,0,0,0,0,26726,26727,26727,26727,1,1,1,1,'Revealers Crown'); -- Revealers Crown
INSERT INTO `synth_recipes` VALUES (3592,0,0,0,105,0,0,0,0,0,0,4099,4241,823,867,885,3552,12696,0,0,0,10316,10317,10317,10317,1,1,1,1,'Dux Fng. Gnt.'); -- Dux Finger Gauntlets
INSERT INTO `synth_recipes` VALUES (3593,0,0,60,106,0,0,0,0,0,0,4098,4240,4015,8719,8719,0,0,0,0,0,28544,28545,28545,28545,1,1,1,1,'Yacuruna Ring'); -- Yacuruna Ring
INSERT INTO `synth_recipes` VALUES (3594,0,0,0,107,0,0,0,0,0,0,4099,4241,823,867,885,885,885,3445,3552,12568,10272,10273,10273,10273,1,1,1,1,'Dux Scale Mail'); -- Dux Scale Mail
INSERT INTO `synth_recipes` VALUES (3595,0,0,0,108,0,0,0,0,0,0,4098,4240,877,1762,3869,0,0,0,0,0,18827,18828,18828,18828,1,1,1,1,'Oxossi Facon'); -- Oxossi Facon
INSERT INTO `synth_recipes` VALUES (3596,0,0,0,111,0,0,0,0,0,0,4099,4241,1311,1409,2427,3940,3979,3979,0,0,28404,28405,28405,28405,1,1,1,1,'Ej Necklace'); -- Ej Necklace
INSERT INTO `synth_recipes` VALUES (3597,0,0,0,111,0,0,0,0,0,0,4098,4240,760,3977,3977,0,0,0,0,0,28526,28527,28527,28527,1,1,1,1,'Tati Earring'); -- Tati Earring
INSERT INTO `synth_recipes` VALUES (3598,0,0,0,114,0,0,60,0,0,60,4098,4240,4019,4021,8704,8752,8752,0,0,0,20537,20538,20538,20538,1,1,1,1,'Bhakazi Sainti'); -- Bhakazi Sainti
INSERT INTO `synth_recipes` VALUES (3599,0,0,0,114,0,0,0,0,0,0,4098,4240,4012,4019,0,0,0,0,0,0,20621,20622,20622,20622,1,1,1,1,'Nanti Knife'); -- Nanti Knife
INSERT INTO `synth_recipes` VALUES (3600,0,0,0,114,0,0,0,0,0,60,4098,4240,4012,4019,8704,0,0,0,0,0,20814,20815,20815,20815,1,1,1,1,'Budliqa'); -- Budliqa
INSERT INTO `synth_recipes` VALUES (3601,0,0,0,113,0,0,0,0,0,0,4099,4241,908,1767,3977,0,0,0,0,0,28664,28665,28665,28665,1,1,1,1,'Killedar Shield'); -- Killedar Shield
INSERT INTO `synth_recipes` VALUES (3602,0,0,0,113,0,0,60,0,0,60,4098,4240,766,851,3927,3979,0,0,0,0,20919,20920,20920,20920,1,1,1,1,'Lacryma Sickle'); -- Lacryma Sickle
INSERT INTO `synth_recipes` VALUES (3603,0,0,0,113,0,0,0,0,60,0,4096,4238,658,766,3979,0,0,0,0,0,21289,21290,21290,21290,1,1,1,1,'Donderbuss'); -- Donderbuss
INSERT INTO `synth_recipes` VALUES (3604,0,0,0,0,96,0,0,0,0,0,4100,4242,4026,4026,0,0,0,0,0,0,4027,4027,4027,4027,1,1,1,1,'Akaso Thread'); -- Akaso Thread
INSERT INTO `synth_recipes` VALUES (3605,0,2010,0,0,96,0,0,0,0,0,4100,4242,2128,4026,4026,4026,4026,4026,4026,0,4027,4027,4027,4027,3,3,3,3,'Akaso Thread'); -- Akaso Thread -- Spinning KI
INSERT INTO `synth_recipes` VALUES (3606,0,0,0,0,97,0,0,0,0,0,4099,4241,4027,4027,4027,0,0,0,0,0,4028,4028,4028,4028,1,1,1,1,'Akaso Cloth'); -- Akaso Cloth (cloth 97)
INSERT INTO `synth_recipes` VALUES (3607,0,0,0,0,98,0,0,0,0,0,4099,4241,3550,3550,3550,0,0,0,0,0,3551,3551,3551,3551,1,1,1,1,'Wyrdweave'); -- Wyrdweave
INSERT INTO `synth_recipes` VALUES (3608,0,0,0,0,101,0,0,60,0,0,4099,4241,826,826,8751,8751,8751,8976,8988,0,26885,26886,26886,26886,1,1,1,1,'Revealers Tunic'); -- Revealers Tunic
INSERT INTO `synth_recipes` VALUES (3609,0,0,0,0,102,0,0,0,0,0,4099,4241,820,2010,2010,2340,2476,2751,0,0,10348,10349,10349,10349,1,1,1,1,'Chelona Trousers'); -- Chelona Trousers
INSERT INTO `synth_recipes` VALUES (3610,0,0,0,0,103,0,0,60,0,0,4099,4241,913,1963,1998,3551,3551,3551,0,0,10414,10415,10415,10415,1,1,1,1,'Spolia Chapeau'); -- Spolia Chapeau
INSERT INTO `synth_recipes` VALUES (3611,0,0,0,0,103,0,0,60,0,0,4099,4241,1963,1963,1998,3550,3551,0,0,0,10579,10580,10580,10580,1,1,1,1,'Spolia Trews'); -- Spolia Trews
INSERT INTO `synth_recipes` VALUES (3612,0,0,0,0,103,0,0,60,0,0,4099,4241,1963,1998,3551,3551,3551,0,0,0,10548,10549,10549,10549,1,1,1,1,'Spolia Cuffs'); -- Spolia Cuffs
INSERT INTO `synth_recipes` VALUES (3613,0,0,0,0,103,0,0,0,0,0,4099,4241,744,2288,2288,2304,2476,2751,0,0,10318,10319,10319,10319,1,1,1,1,'Chelona Gloves'); -- Chelona Gloves
INSERT INTO `synth_recipes` VALUES (3614,0,0,0,0,103,0,0,0,0,0,4099,4241,823,829,2359,2359,4028,8708,0,0,28040,28041,28041,28041,1,1,1,1,'Haruspex Cuffs'); -- Haruspex Cuffs
INSERT INTO `synth_recipes` VALUES (3615,0,0,0,0,104,0,0,0,0,0,4099,4241,767,1110,1991,2010,2304,2476,2751,3550,10436,10437,10437,10437,1,1,1,1,'Chelona Hat'); -- Chelona Hat
INSERT INTO `synth_recipes` VALUES (3616,0,0,0,0,105,0,0,0,0,0,4099,4241,3545,14080,0,0,0,0,0,0,10647,10648,10648,10648,1,1,1,1,'Areion Boots'); -- Areion Boots
INSERT INTO `synth_recipes` VALUES (3617,0,0,0,0,105,0,0,0,0,0,4099,4241,821,821,823,823,1313,8727,0,0,8728,8728,8728,8728,1,1,1,1,'Sifs Macrame'); -- Sif Macrame
INSERT INTO `synth_recipes` VALUES (3618,0,0,0,0,105,0,0,60,0,0,4099,4241,764,913,1629,1963,1998,3550,3551,3551,10498,10499,10499,10499,1,1,1,1,'Spolia Saio'); -- Spolia Saio
INSERT INTO `synth_recipes` VALUES (3619,0,0,0,0,106,0,0,0,0,0,4099,4241,767,878,1110,1991,2288,2304,2751,3550,10274,10275,10275,10275,1,1,1,1,'Chelona Blazer'); -- Chelona Blazer
INSERT INTO `synth_recipes` VALUES (3620,0,0,0,0,106,0,0,0,0,0,4099,4241,752,822,823,1132,4028,8708,0,0,27750,27751,27751,27751,1,1,1,1,'Haruspex Hat'); -- Haruspex Hat
INSERT INTO `synth_recipes` VALUES (3621,0,0,0,0,107,0,0,0,0,0,4099,4241,752,823,1132,1132,4028,8708,0,0,28180,28181,28181,28181,1,1,1,1,'Haruspex Slops'); -- Haruspex Slops
INSERT INTO `synth_recipes` VALUES (3622,0,0,0,0,107,0,0,60,0,0,4099,4241,816,8728,8751,8754,0,0,0,0,28601,28602,28602,28602,1,1,1,1,'Seshaw Cape'); -- Seshaw Cape
INSERT INTO `synth_recipes` VALUES (3623,0,0,0,0,109,0,0,0,0,0,4099,4241,761,823,828,829,829,829,4028,8708,27893,27894,27894,27894,1,1,1,1,'Haruspex Coat'); -- Haruspex Coat
INSERT INTO `synth_recipes` VALUES (3624,0,0,0,0,111,0,0,60,0,0,4099,4241,816,1998,1998,3981,3981,0,0,0,28644,28645,28645,28645,1,1,1,1,'Ogapepo Cape'); -- Ogapepo Cape
INSERT INTO `synth_recipes` VALUES (3625,0,0,0,60,113,0,0,0,0,0,4098,4240,937,4012,4013,0,0,0,0,0,21378,21379,21379,21379,1,1,1,1,'Yetshila'); -- Yetshila (fixed itemIds)
INSERT INTO `synth_recipes` VALUES (3626,0,0,0,0,115,0,60,0,0,0,4098,4240,745,823,829,3449,3544,9006,9006,0,26877,26878,26878,26878,1,1,1,1,'Foppish Tunica'); -- Foppish Tunica
INSERT INTO `synth_recipes` VALUES (3627,0,0,0,0,0,0,0,84,0,0,4103,4245,695,4509,8707,0,0,0,0,0,8708,8708,8708,8708,1,1,1,1,'Raaz Leather'); -- Raaz Leather
INSERT INTO `synth_recipes` VALUES (3628,0,2018,0,0,0,0,0,84,0,0,4103,4245,635,635,635,2129,4509,8707,8707,8707,8708,8708,8708,8708,3,3,3,3,'Raaz Leather'); -- Raaz Leather (fixed ingredients) https://www.bg-wiki.com/bg/Raaz_Leather
INSERT INTO `synth_recipes` VALUES (3629,0,0,0,0,0,0,0,90,0,0,4103,4245,695,2750,4509,0,0,0,0,0,2751,2751,2751,2751,1,1,1,1,'Amph. Leather'); -- Amphiptere Leather (fixed results)
INSERT INTO `synth_recipes` VALUES (3630,0,2018,0,0,0,0,0,90,0,0,4103,4245,635,635,635,695,2129,2750,2750,2750,2751,2751,2751,2751,3,3,3,3,'Amph. Leather'); -- Amphiptere Leather -- KI Tanning (fixed results)
INSERT INTO `synth_recipes` VALUES (3631,0,0,0,0,0,0,0,101,0,0,4099,4241,823,1132,4028,8707,8708,0,0,0,28318,28319,28319,28319,1,1,1,1,'Haru. Pigaches'); -- Haruspex Pigaches
INSERT INTO `synth_recipes` VALUES (3632,0,0,0,0,0,0,0,101,0,0,4099,4241,3552,8708,12696,0,0,0,0,0,28036,28037,28037,28037,1,1,1,1,'Aetosaur Gloves'); -- Aetosaur Gloves
INSERT INTO `synth_recipes` VALUES (3633,0,0,0,0,0,0,0,102,55,0,4099,4241,1989,2152,3552,3552,0,0,0,0,10412,10413,10413,10413,1,1,1,1,'Urja Helm'); -- Urja Helm (leath 102 smith 55) https://www.bg-wiki.com/bg/Urja_Helm
INSERT INTO `synth_recipes` VALUES (3634,0,0,0,0,0,0,0,102,0,0,4099,4241,862,1163,2828,0,0,0,0,0,10996,10997,10997,10997,1,1,1,1,'Testudo Mantle'); -- Testudo Mantle
INSERT INTO `synth_recipes` VALUES (3635,0,0,0,0,50,0,0,103,0,0,4099,4241,869,2304,3445,3552,0,0,0,0,10998,10999,10999,10999,1,1,1,1,'Attackers Mantle'); -- Attacker's Mantle (leath 103 cloth 50) https://www.bg-wiki.com/bg/Attacker's_Mantle
INSERT INTO `synth_recipes` VALUES (3636,0,0,0,0,0,0,0,103,0,0,4099,4241,3552,3964,8708,12952,0,0,0,0,28314,28315,28315,28315,1,1,1,1,'Aeto. Ledelsens'); -- Aetosaur Ledeelsens
INSERT INTO `synth_recipes` VALUES (3637,0,0,0,0,0,0,0,104,0,0,4103,4245,635,3547,4509,0,0,0,0,0,3548,3548,3548,3548,1,1,1,1,'Sealord Leather'); -- Sealord Leather
INSERT INTO `synth_recipes` VALUES (3638,0,0,0,0,0,0,0,104,0,0,4099,4241,1629,3552,3552,0,0,0,0,0,10546,10547,10547,10547,1,1,1,1,'Urja Gloves'); -- Urja Helm
INSERT INTO `synth_recipes` VALUES (3639,0,0,0,0,0,0,60,104,60,0,4099,4241,665,862,862,914,1409,2189,2275,3925,27920,27921,27921,27921,1,1,1,1,'Pak Corselet'); -- Pak Corselet
INSERT INTO `synth_recipes` VALUES (3640,0,0,0,0,0,0,0,105,54,0,4099,4241,1629,1990,3552,3552,0,0,0,0,10643,10644,10644,10644,1,1,1,1,'Urja Ledelsens'); -- Urja Ledelsens (leath 105, smith 54) https://www.bg-wiki.com/bg/Urja_Ledelsens
INSERT INTO `synth_recipes` VALUES (3641,0,0,0,0,0,0,0,105,0,0,4099,4241,2878,3548,13249,0,0,0,0,0,10836,10837,10837,10837,1,1,1,1,'Phos Belt'); -- Phos Belt
INSERT INTO `synth_recipes` VALUES (3642,0,0,0,0,0,0,0,105,54,0,4099,4241,1629,1989,3552,3552,13705,0,0,0,10496,10497,10497,10497,1,1,1,1,'Urja Jerkin'); -- Urja Jerkin (leath 105, smith 54) https://www.bg-wiki.com/bg/Urja_Jerkin
INSERT INTO `synth_recipes` VALUES (3643,0,0,0,0,0,0,0,106,0,0,4099,4241,3552,3552,8708,0,0,0,0,0,27746,27747,27747,27747,1,1,1,1,'Aetosaur Helm'); -- Aetosaur Helm
INSERT INTO `synth_recipes` VALUES (3644,0,0,0,0,0,0,0,107,0,0,4099,4241,3552,3552,8708,12824,0,0,0,0,28176,28177,28177,28177,1,1,1,1,'Aeto. Trousers'); -- Aetosaur Trousers
INSERT INTO `synth_recipes` VALUES (3645,0,0,0,0,0,0,0,109,0,0,4099,4241,3552,3552,8708,8708,0,0,0,0,27889,27890,27890,27890,1,1,1,1,'Aetosaur Jerkin'); -- Aetosaur Jerkin
INSERT INTO `synth_recipes` VALUES (3646,0,0,0,0,0,0,57,109,0,0,4099,4241,765,3548,8754,0,0,0,0,0,28446,28447,28447,28447,1,1,1,1,'Sweordfaetels'); -- Sweordfaetels (leath 109 gold 57) https://www.bg-wiki.com/bg/Sweordfaetels
INSERT INTO `synth_recipes` VALUES (3647,0,0,0,0,0,0,0,110,0,0,4099,4241,862,3981,10836,0,0,0,0,0,28464,28465,28465,28465,1,1,1,1,'Pyaekue Belt'); -- Pya'ekue Belt
INSERT INTO `synth_recipes` VALUES (3648,0,0,0,0,0,0,0,112,0,0,4097,4239,4027,8754,0,0,0,0,0,0,28606,28607,28607,28607,1,1,1,1,'Aput Mantle'); -- Aput Mantle
INSERT INTO `synth_recipes` VALUES (3649,0,0,0,0,60,0,0,115,0,0,4098,4240,837,1767,3544,3549,9003,9003,0,0,26879,26880,26880,26880,1,1,1,1,'Wretched Coat'); -- Wretched Coat
INSERT INTO `synth_recipes` VALUES (3650,0,0,0,0,0,0,0,0,98,0,4096,4238,734,734,734,734,0,0,0,0,735,735,735,735,1,1,1,1,'Thokcha Ingot'); -- Thokcha Ingot
INSERT INTO `synth_recipes` VALUES (3651,0,0,0,0,0,0,0,0,100,30,4096,4238,710,742,757,757,757,757,1629,4159,19177,19178,19178,19178,1,1,1,1,'Etourdissante'); -- Etourdissante
INSERT INTO `synth_recipes` VALUES (3652,0,0,0,0,0,0,0,0,100,0,4096,4238,648,657,707,735,862,2372,0,0,19299,19300,19300,19300,1,1,1,1,'Aisa'); -- Aisa
INSERT INTO `synth_recipes` VALUES (3653,0,0,0,0,0,0,0,0,100,0,4096,4238,4020,4020,4020,4020,0,0,0,0,4021,4021,4021,4021,1,1,1,1,'Titanium Ingot'); -- Titanium Ingot
INSERT INTO `synth_recipes` VALUES (3654,0,0,0,60,0,0,0,0,101,0,4096,4238,735,735,1615,0,0,0,0,0,18910,18911,18911,18911,1,1,1,1,'Apaisante'); -- Apaisante
INSERT INTO `synth_recipes` VALUES (3655,0,0,0,0,0,0,0,0,101,0,4096,4238,654,735,16724,0,0,0,0,0,18522,18523,18523,18523,1,1,1,1,'Firnaxe'); -- Firnaxe
INSERT INTO `synth_recipes` VALUES (3656,0,0,0,0,0,0,0,0,101,0,4096,4238,641,642,4058,4058,0,0,0,0,8704,8704,8704,8704,1,1,1,1,'Bismuth Ingot'); -- Bismuth Ingot
INSERT INTO `synth_recipes` VALUES (3657,0,0,0,0,0,0,0,0,101,0,4096,4238,745,851,4095,4095,0,0,0,0,28178,28179,28179,28179,1,1,1,1,'Shabti Cuisses'); -- Shabti Cuisses
INSERT INTO `synth_recipes` VALUES (3658,0,0,0,0,0,0,60,60,101,0,4096,4238,747,914,1629,2170,8990,8992,0,0,27396,27397,27397,27397,1,1,1,1,'Gefechtschuhs'); -- Gefechtschuhs
INSERT INTO `synth_recipes` VALUES (3659,0,0,0,0,0,0,0,60,102,60,4096,4238,657,720,735,735,745,821,2275,2529,18462,18463,18463,18463,1,1,1,1,'Sasanuki'); -- Sasanuki
INSERT INTO `synth_recipes` VALUES (3660,0,0,0,0,0,0,0,0,102,0,4096,4238,8704,0,0,0,0,0,0,0,4095,4095,4095,4095,1,1,1,1,'Bismuth Sheet'); -- Bismuth Sheet
INSERT INTO `synth_recipes` VALUES (3661,0,1995,0,0,0,0,0,0,102,0,4096,4238,2144,8704,8704,8704,8704,8704,8704,0,4095,4095,4095,4095,6,6,6,6,'Bismuth Sheet'); -- Bismuth Sheet -- KI Sheeting
INSERT INTO `synth_recipes` VALUES (3662,0,0,0,0,0,0,0,0,102,0,4096,4238,645,645,645,8747,0,0,0,0,8748,8748,8748,8748,1,1,1,1,'Rakaznar Ingot'); -- Ra'Kaznar Ingot
INSERT INTO `synth_recipes` VALUES (3663,0,0,0,0,0,0,60,0,102,0,4096,4238,747,914,8990,8992,12696,12696,0,0,27987,27988,27988,27988,1,1,1,1,'Gefechthentzes'); -- Gefechthentzes (smith 102 gold ??) https://www.bg-wiki.com/bg/Gefechthentzes
INSERT INTO `synth_recipes` VALUES (3664,0,0,0,0,0,0,0,0,103,45,4096,4238,718,735,735,2000,0,0,0,0,18543,18544,18544,18544,1,1,1,1,'Breidox'); -- Breidox
INSERT INTO `synth_recipes` VALUES (3665,0,0,0,0,0,0,0,0,103,0,4098,4240,8704,0,0,0,0,0,0,0,8705,8705,8705,8705,6,8,10,12,'Bsm. Bolt Heads'); --  Bismuth Bolt Heads
INSERT INTO `synth_recipes` VALUES (3666,0,0,0,0,0,0,0,0,103,0,4096,4238,745,914,4095,4095,12696,12696,0,0,28038,28039,28039,28039,1,1,1,1,'Shabti Gauntlets'); -- Shabti Gauntlets
INSERT INTO `synth_recipes` VALUES (3667,0,0,0,0,0,0,60,60,103,0,4096,4238,747,914,2170,8990,8990,8992,8992,0,26881,26882,26882,26882,1,1,1,1,'Gefechtbrust'); -- Gefechtbrust
INSERT INTO `synth_recipes` VALUES (3668,0,0,0,0,0,0,0,0,104,60,4096,4238,723,735,735,735,826,0,0,0,18561,18562,18562,18562,1,1,1,1,'Yhatdhara'); -- Yhatdhara
INSERT INTO `synth_recipes` VALUES (3669,0,0,0,0,0,0,60,0,104,0,4096,4238,655,655,655,745,745,745,2535,0,19151,19152,19152,19152,1,1,1,1,'Bahadur'); -- Bahadur
INSERT INTO `synth_recipes` VALUES (3670,0,0,0,0,0,0,60,0,104,60,4096,4238,650,711,718,735,735,742,0,0,19743,19744,19744,19744,1,1,1,1,'Opprimo'); -- Opprimo
INSERT INTO `synth_recipes` VALUES (3671,0,0,0,0,0,0,0,0,104,60,4096,4238,4019,4023,21191,0,0,0,0,0,21192,21193,21193,21193,1,1,1,1,'Voay Staff'); -- Voay Staff
INSERT INTO `synth_recipes` VALUES (3672,0,0,0,0,0,0,0,0,104,0,4098,4240,8748,0,0,0,0,0,0,0,8749,8749,8749,8749,6,8,10,12,'Ra. Bolt Heads'); --  Ra'Kaznar Bolt Heads
INSERT INTO `synth_recipes` VALUES (3673,0,0,0,0,0,0,60,0,105,60,4096,4238,650,652,652,686,686,2275,2275,2535,18495,18496,18496,18496,1,1,1,1,'Wootz Amood'); -- Wootz Amood
INSERT INTO `synth_recipes` VALUES (3674,0,0,0,0,0,0,0,0,105,42,4096,4238,4019,4020,20772,0,0,0,0,0,20773,20774,20774,20774,1,1,1,1,'Voay Sword'); -- Voay Sword
INSERT INTO `synth_recipes` VALUES (3675,0,0,0,0,0,0,0,0,105,0,4096,4238,643,643,643,8723,0,0,0,0,8724,8724,8724,8724,1,1,1,1,'Beryllium Ingot'); -- Beryllium Ingot
INSERT INTO `synth_recipes` VALUES (3676,0,0,0,0,0,0,60,0,105,0,4096,4238,9062,9075,9075,16659,0,0,0,0,20802,20803,20803,20803,1,1,1,1,'Blurred Axe'); -- Blurred Axe
INSERT INTO `synth_recipes` VALUES (3677,0,0,0,0,0,0,60,0,105,0,4096,4238,9062,9075,9075,19263,0,0,0,0,21217,21218,21218,21218,1,1,1,1,'Blurred Bow'); -- Blurred Bow
INSERT INTO `synth_recipes` VALUES (3678,0,0,0,0,0,0,60,0,105,0,4096,4238,9062,9075,9075,16416,0,0,0,0,20525,20526,20526,20526,1,1,1,1,'Blurred Claws'); -- Blurred Claws
INSERT INTO `synth_recipes` VALUES (3679,0,0,0,0,0,0,60,0,105,0,4096,4238,9062,9075,9075,16597,0,0,0,0,21700,21701,21701,21701,1,1,1,1,'Blurred Claymore'); -- Blurred Claymore
INSERT INTO `synth_recipes` VALUES (3680,0,0,0,0,0,0,60,0,105,0,4096,4238,9062,9075,9075,18223,0,0,0,0,20849,20850,20850,20850,1,1,1,1,'Blurred Cleaver'); -- Blurred Cleaver
INSERT INTO `synth_recipes` VALUES (3681,0,0,0,0,0,0,60,0,105,0,4096,4238,9062,9075,9075,17221,0,0,0,0,21480,21481,21481,21481,1,1,1,1,'Blurred Crossbow'); -- Blurred Crossbow
INSERT INTO `synth_recipes` VALUES (3682,0,0,0,0,0,0,60,0,105,0,4096,4238,9062,9075,9075,17364,0,0,0,0,21400,21401,21401,21401,1,1,1,1,'Blurred Harp'); -- Blurred Harp
INSERT INTO `synth_recipes` VALUES (3683,0,0,0,0,0,0,60,0,105,0,4096,4238,9062,9075,9075,16452,0,0,0,0,20601,20602,20602,20602,1,1,1,1,'Blurred Knife'); -- Blurred Knife
INSERT INTO `synth_recipes` VALUES (3684,0,0,0,0,0,0,60,0,105,0,4096,4238,9062,9075,9075,18129,0,0,0,0,20940,20941,20941,20941,1,1,1,1,'Blurred Lance'); -- Blurred Lance
INSERT INTO `synth_recipes` VALUES (3685,0,0,0,0,0,0,60,0,105,0,4096,4238,9062,9075,9075,17064,0,0,0,0,21093,21094,21094,21094,1,1,1,1,'Blurred Rod'); -- Blurred Rod
INSERT INTO `synth_recipes` VALUES (3686,0,0,0,0,0,0,60,0,105,0,4096,4238,9062,9075,9075,16777,0,0,0,0,20896,20897,20897,20897,1,1,1,1,'Blurred Scythe'); -- Blurred Scythe
INSERT INTO `synth_recipes` VALUES (3687,0,0,0,0,0,0,60,0,105,0,4096,4238,9062,9075,9075,12387,0,0,0,0,27643,27644,27644,27644,1,1,1,1,'Blurred Shield'); -- Blurred Shield
INSERT INTO `synth_recipes` VALUES (3688,0,0,0,0,0,0,60,0,105,0,4096,4238,9062,9075,9075,17101,0,0,0,0,21157,21158,21158,21158,1,1,1,1,'Blurred Staff'); -- Blurred Staff
INSERT INTO `synth_recipes` VALUES (3689,0,0,0,0,0,0,60,0,105,0,4096,4238,9062,9075,9075,17727,0,0,0,0,20711,20712,20712,20712,1,1,1,1,'Blurred Sword'); -- Blurred Sword
INSERT INTO `synth_recipes` VALUES (3690,0,0,0,0,0,0,60,0,105,0,4096,4238,9062,9075,9075,18413,0,0,0,0,20984,20985,20985,20985,1,1,1,1,'Kujaku'); -- Kujaku
INSERT INTO `synth_recipes` VALUES (3691,0,0,0,0,0,0,60,0,105,0,4096,4238,9062,9075,9075,18431,0,0,0,0,21032,21033,21033,21033,1,1,1,1,'Kunitsuna'); -- Kunitsuna
INSERT INTO `synth_recipes` VALUES (3692,0,0,0,60,0,0,0,0,107,0,4098,4240,657,914,4012,4095,0,0,0,0,21353,21353,21353,21353,33,66,99,99,'Happo Shuriken'); -- Happo Shuriken
INSERT INTO `synth_recipes` VALUES (3693,0,0,0,0,0,0,0,0,106,0,4096,4238,648,745,850,914,4095,4095,0,0,27748,27749,27749,27749,1,1,1,1,'Shabti Armet'); -- Shabti Armet
INSERT INTO `synth_recipes` VALUES (3694,0,0,0,0,0,0,0,0,107,0,4096,4238,745,851,851,914,4095,4095,4095,0,28316,28317,28317,28317,1,1,1,1,'Shabti Sabatons'); -- Shabti Sabatons
INSERT INTO `synth_recipes` VALUES (3695,0,0,0,0,0,0,0,0,107,0,4096,4238,816,8724,8739,0,0,0,0,0,28374,28375,28375,28375,1,1,1,1,'Dakatsu Nodowa'); -- Dakatsu-No-Nodowa
INSERT INTO `synth_recipes` VALUES (3696,0,0,0,0,0,0,0,0,109,0,4096,4238,745,851,851,914,4095,4095,4095,4095,27891,27892,27892,27892,1,1,1,1,'Shabti Cuirass'); -- Shabti Cuirass
INSERT INTO `synth_recipes` VALUES (3697,0,0,0,0,0,0,60,0,110,60,4096,4238,650,655,655,655,818,877,1704,4014,21041,21042,21042,21042,1,1,1,1,'Sukezane'); -- Sukezane
INSERT INTO `synth_recipes` VALUES (3698,0,0,0,0,0,0,60,0,113,60,4096,4238,658,658,658,658,687,1122,3927,3977,20779,20780,20780,20780,1,1,1,1,'Senbaak Nagan'); -- Senbaak Nagan
INSERT INTO `synth_recipes` VALUES (3699,0,0,0,60,0,0,60,0,113,0,4096,4238,653,658,658,766,3927,3979,0,0,20874,20875,20875,20875,1,1,1,1,'Razorfury'); -- Razorfury
INSERT INTO `synth_recipes` VALUES (3700,0,0,0,0,0,0,60,0,113,0,4096,4238,658,766,1765,3981,0,0,0,0,21006,21007,21007,21007,1,1,1,1,'Pamun'); -- Pamun
INSERT INTO `synth_recipes` VALUES (3701,0,0,60,0,0,0,0,0,115,60,4096,4238,658,658,658,766,3552,4014,9061,9063,20754,20755,20755,20755,1,1,1,1,'Malfeasance'); -- Malfeasance
INSERT INTO `synth_recipes` VALUES (3702,0,0,0,0,0,0,0,0,0,92,4098,4240,3926,0,0,0,0,0,0,0,3927,3927,3927,3927,1,2,3,4,'Urunday Lumber'); --  Urunday Lumber
INSERT INTO `synth_recipes` VALUES (3703,0,1986,0,0,0,0,0,0,0,92,4098,4240,1657,3926,3926,3926,0,0,0,0,3927,3927,3927,3927,3,6,9,12,'Urunday Lumber'); --  Urunday Lumber -- KI Lumberjack
INSERT INTO `synth_recipes` VALUES (3704,0,0,0,0,0,0,60,0,60,102,4096,4238,654,715,2275,2655,2735,0,0,0,18129,18130,18130,18130,1,1,1,1,'Dabo'); -- Dabo
INSERT INTO `synth_recipes` VALUES (3705,0,0,0,0,0,0,60,0,60,103,4099,4241,655,715,735,781,3550,4159,0,0,19796,19797,19797,19797,1,1,1,1,'Rosschinder'); -- Rosschinder
INSERT INTO `synth_recipes` VALUES (3706,0,0,0,0,0,0,0,0,0,103,4098,4240,2534,0,0,0,0,0,0,0,2535,2535,2535,2535,1,2,3,4,'Jacaranda Lbr.'); -- Jacaranda Lumber
INSERT INTO `synth_recipes` VALUES (3707,0,1986,0,0,0,0,0,0,0,103,4098,4240,1657,2534,2534,2534,0,0,0,0,2535,2535,2535,2535,3,6,9,12,'Jacaranda Lbr.'); -- Jacaranda Lumber -- KI Lumberjack
INSERT INTO `synth_recipes` VALUES (3708,0,0,0,0,0,0,0,0,0,104,4098,4240,4018,0,0,0,0,0,0,0,4019,4019,4019,4019,1,2,3,4,'Gua. Lumber'); -- Guatambu Lumber
INSERT INTO `synth_recipes` VALUES (3709,0,1986,0,0,0,0,0,0,0,104,4098,4240,1657,4018,4018,4018,0,0,0,0,4019,4019,4019,4019,3,6,9,12,'Gua. Lumber'); -- Guatambu Lumber -- KI Lumberjack
INSERT INTO `synth_recipes` VALUES (3710,0,0,0,0,0,0,60,0,0,105,4099,4241,704,755,1414,1414,1415,17205,0,0,19786,19787,19787,19787,1,1,1,1,'Nurigomeyumi'); -- Nurigomeyumi
INSERT INTO `synth_recipes` VALUES (3711,0,0,0,0,0,0,0,0,0,105,4098,4240,8725,0,0,0,0,0,0,0,8726,8726,8726,8726,1,2,3,4,'Exalted Lumber'); -- Exalted Lumber
INSERT INTO `synth_recipes` VALUES (3712,0,1986,0,0,0,0,0,0,0,105,4098,4240,1657,8725,8725,8725,0,0,0,0,8726,8726,8726,8726,3,6,9,12,'Exalted Lumber'); -- Exalted Lumber -- KI Lumberjack
INSERT INTO `synth_recipes` VALUES (3713,0,0,0,0,0,0,0,0,0,106,4098,4240,4027,4028,8726,8726,0,0,0,0,22125,22126,22126,22126,1,1,1,1,'Exalted Bow'); -- exalted bow (former recipe for thalassocrat was a dupe of recipe 3345)
INSERT INTO `synth_recipes` VALUES (3714,0,0,0,0,0,0,50,0,0,108,4098,4240,733,733,2275,0,0,0,0,0,18628,18629,18629,18629,1,1,1,1,'Flete Pole'); -- Flete Pole
INSERT INTO `synth_recipes` VALUES (3715,0,0,0,0,0,0,0,0,0,109,4098,4240,786,2535,2535,3893,0,0,0,0,18634,18635,18635,18635,1,1,1,1,'Zamzummim Staff'); -- Zamzummim Staff
INSERT INTO `synth_recipes` VALUES (3716,0,0,0,0,0,0,0,0,0,110,4098,4240,2880,3549,17108,0,0,0,0,0,18630,18631,18631,18631,1,1,1,1,'Nathushne'); --  Nathushne
INSERT INTO `synth_recipes` VALUES (3717,0,0,0,60,0,0,0,0,60,110,4096,4238,658,658,745,914,4014,0,0,0,20950,20951,20951,20951,1,1,1,1,'Terebrokath'); -- Terebrokath
INSERT INTO `synth_recipes` VALUES (3718,0,0,0,60,0,0,0,0,60,113,4098,4240,658,719,932,3933,4014,0,0,0,21249,21250,21250,21250,1,1,1,1,'Iqonde Crossbow'); --  Iqonde Crossbow
INSERT INTO `synth_recipes` VALUES (3719,0,0,0,60,0,0,0,0,0,113,4098,4240,3925,3927,3979,0,0,0,0,0,21202,21203,21203,21203,1,1,1,1,'Balsam Staff'); -- Balsam Staff
INSERT INTO `synth_recipes` VALUES (3720,0,0,0,60,60,0,0,0,0,113,4098,4240,730,730,836,3870,3977,0,0,0,21239,21239,21239,21239,1,1,1,1,'Echidnas Bow'); -- Echidna's Bow
INSERT INTO `synth_recipes` VALUES (3721,0,0,60,0,0,0,0,0,0,113,4098,4240,3549,3927,3977,0,0,0,0,0,21200,21201,21201,21201,1,1,1,1,'Atinian Staff'); -- Atinian Staff
INSERT INTO `synth_recipes` VALUES (3722,0,0,0,0,0,0,0,0,0,100,4098,4240,733,845,0,0,0,0,0,0,18884,18885,18885,18885,1,1,1,1,'Vejovis Wand'); -- Vejovis Wand
INSERT INTO `synth_recipes` VALUES (3723,0,0,0,0,0,0,0,0,100,0,4096,4238,720,735,1459,0,0,0,0,0,19788,19789,19789,19789,1,1,1,1,'Gorkhali Kukri'); -- Gorkhali Kukri
INSERT INTO `synth_recipes` VALUES (3724,0,0,0,0,0,0,0,100,0,0,4099,4241,1629,1629,3552,3552,0,0,0,0,10577,10578,10578,10578,1,1,1,1,'Urja Trousers'); -- Urja Trousers
INSERT INTO `synth_recipes` VALUES (3725,0,0,0,0,0,0,100,0,0,0,4096,4238,742,742,0,0,0,0,0,0,11060,11061,11061,11061,1,1,1,1,'Evader Earring'); -- Evader Earring
INSERT INTO `synth_recipes` VALUES (3726,0,0,0,0,100,0,0,0,0,0,4099,4241,2199,3551,3551,0,0,0,0,0,11000,11001,11001,11001,1,1,1,1,'Swith Cape'); -- Swith Cape
INSERT INTO `synth_recipes` VALUES (3727,0,0,0,0,0,0,96,0,0,0,4096,4238,3923,0,0,0,0,0,0,0,3964,3964,3964,3964,1,1,1,1,'Rhodium Sheet'); -- Rhodium Sheet
INSERT INTO `synth_recipes` VALUES (3728,0,1995,0,0,0,0,96,0,0,0,4096,4238,3923,3923,3923,3923,3923,3923,0,0,3964,3964,3964,3964,6,6,6,6,'Rhodium Sheet'); -- Rhodium Sheet
INSERT INTO `synth_recipes` VALUES (3729,0,0,0,0,0,0,96,0,0,0,4096,4238,3923,3923,0,0,0,0,0,0,28542,28543,28543,28543,1,1,1,1,'Rhodium Ring'); -- Rhodium Ring
INSERT INTO `synth_recipes` VALUES (3730,0,0,0,0,0,0,0,0,3,14,4099,4241,649,721,721,728,2771,0,0,0,372,372,372,372,1,1,1,1,'Cricket Cage'); -- cricket cage
INSERT INTO `synth_recipes` VALUES (3731,0,0,0,0,0,0,0,0,3,14,4099,4241,649,721,721,728,2772,0,0,0,373,373,373,373,1,1,1,1,'Glowfly Cage'); -- glowfly cage
INSERT INTO `synth_recipes` VALUES (3732,0,0,0,0,0,0,0,83,0,0,4103,4245,695,2755,4509,0,0,0,0,0,2756,2756,2756,2756,1,1,1,1,'Ruszor Leather'); -- Ruszor Leather
INSERT INTO `synth_recipes` VALUES (3733,0,0,0,0,0,0,0,83,0,0,4103,4245,635,2755,4509,0,0,0,0,0,2756,2756,2756,2756,1,1,1,1,'Ruszor Leather'); -- Ruszor Leather
INSERT INTO `synth_recipes` VALUES (3734,0,2018,0,0,0,0,0,83,0,0,4103,4245,635,635,635,2129,2755,2755,2755,4509,2756,2756,2756,2756,3,3,3,3,'Ruszor Leather'); -- Ruszor Leather - KI Tanning
INSERT INTO `synth_recipes` VALUES (3735,0,0,0,0,74,0,0,0,0,0,4100,4242,2198,2198,0,0,0,0,0,0,2199,2199,2199,2199,1,1,1,1,'Sparkstrand'); -- Sparkstrand Thread Thread
INSERT INTO `synth_recipes` VALUES (3736,0,2010,0,0,74,0,0,0,0,0,4100,4242,2128,2198,2198,2198,2198,2198,2198,0,2199,2199,2199,2199,3,3,3,3,'Sparkstrand'); -- Sparkstrand Thread -- Spinning KI
INSERT INTO `synth_recipes` VALUES (3737,0,0,0,0,98,0,0,0,0,0,4099,4241,816,816,816,821,821,1294,0,0,2705,2705,2705,2705,1,1,1,1,'Foulard'); -- Foulard
INSERT INTO `synth_recipes` VALUES (3738,1,0,0,103,0,0,0,0,0,0,4100,4242,12565,0,0,0,0,0,0,0,850,1587,821,1586,1,2,1,2,'Sheep Leather'); -- Gavial Mail -- Desynth
INSERT INTO `synth_recipes` VALUES (3739,1,0,0,89,0,0,0,0,0,0,4100,4242,13460,0,0,0,0,0,0,0,883,883,883,883,1,1,1,1,'Behemoth Horn'); -- Behemoth Ring -- Desynth
INSERT INTO `synth_recipes` VALUES (3740,1,0,0,85,0,0,0,0,0,0,4100,4242,16128,0,0,0,0,0,0,0,2427,2427,2427,2427,1,1,1,1,'Wivre Maul'); -- Wivre Hairpin -- Desynth
INSERT INTO `synth_recipes` VALUES (3741,1,0,0,0,0,0,60,0,103,0,4100,4242,12548,0,0,0,0,0,0,0,855,1225,654,655,1,6,2,2,'Tiger Leather'); -- Adaman Cuirass -- Desynth
INSERT INTO `synth_recipes` VALUES (3742,0,0,0,0,0,93,0,0,0,0,4101,4243,610,4509,5818,0,0,0,0,0,17906,17906,17906,17906,4,4,4,4,'Auroral Broth'); -- Auroral Broth (cook 93) https://www.bg-wiki.com/bg/Auroral_Broth
INSERT INTO `synth_recipes` VALUES (3743,0,0,0,0,0,61,0,0,0,0,4101,4243,612,626,633,936,4390,5652,0,0,5747,5747,5747,5747,4,4,4,4,'Marinara Sauce'); -- Marinara Sauce
INSERT INTO `synth_recipes` VALUES (3744,0,0,0,0,0,40,0,0,0,0,4096,4238,614,622,1590,2561,5684,5747,0,0,5743,5744,5744,5744,1,1,1,1,'Marinara Pizza'); -- Marinara Pizza
INSERT INTO `synth_recipes` VALUES (3745,1,0,0,0,0,0,0,0,70,0,4100,4242,16915,0,0,0,0,0,0,0,852,852,654,654,1,1,1,1,'Lizard Skin'); -- Hien -- Desynth
INSERT INTO `synth_recipes` VALUES (3746,1,0,0,0,0,0,0,70,0,0,4100,4242,16389,0,0,0,0,0,0,0,715,850,506,506,1,1,1,1,'Ash Lumber'); -- Coeurl Cesti -- Desynth
INSERT INTO `synth_recipes` VALUES (3747,1,0,0,0,54,0,0,97,0,0,4100,4242,14319,0,0,0,0,0,0,0,855,1163,1117,1629,1,1,1,2,'Tiger Leather'); -- Bison Kecks -- Desynth
INSERT INTO `synth_recipes` VALUES (3748,0,0,0,0,0,0,0,0,0,97,4098,4240,732,0,0,0,0,0,0,0,733,733,733,733,1,2,3,4,'Kapor Lumber'); -- Kapor Lumber
INSERT INTO `synth_recipes` VALUES (3749,0,1986,0,0,0,0,0,0,0,97,4098,4240,732,732,732,1657,0,0,0,0,733,733,733,733,3,6,9,12,'Kapor Lumber'); -- Kapor Lumber -- KI Lumberjack
INSERT INTO `synth_recipes` VALUES (3750,0,0,41,0,78,0,0,0,0,0,4099,4241,816,823,1882,1882,1882,2304,0,0,2704,2704,2704,2704,1,1,1,1,'Oil-soaked Clth.'); -- Oil-Soaked Cloth
INSERT INTO `synth_recipes` VALUES (3751,0,0,0,74,0,0,0,0,0,0,4098,4240,760,1311,0,0,0,0,0,0,2743,2743,2743,2743,6,8,10,12,'Oxblood Orb'); -- Oxblood Orb
INSERT INTO `synth_recipes` VALUES (3752,0,0,0,74,0,0,0,0,0,0,4098,4240,760,1312,0,0,0,0,0,0,2744,2744,2744,2744,6,8,10,12,'Angel Skin Orb'); -- Angel Skin Orb (bone 74) https://www.bg-wiki.com/bg/Angel_Skin_Orb
INSERT INTO `synth_recipes` VALUES (3753,0,2042,0,0,0,35,0,0,0,0,4096,4238,627,2503,4362,4445,0,0,0,0,5779,5779,5779,5779,2,4,6,8,'Cherry Macaron'); -- Cherry Macaron
INSERT INTO `synth_recipes` VALUES (3754,0,2042,0,0,0,55,0,0,0,0,4096,4238,627,2271,2503,4362,0,0,0,0,5780,5780,5780,5780,2,4,6,8,'Coffee Macaron'); -- Coffee Macaron
INSERT INTO `synth_recipes` VALUES (3755,0,2042,0,0,0,75,0,0,0,0,4096,4238,627,2503,4273,4362,0,0,0,0,5781,5781,5781,5781,2,4,6,8,'Kitron Macaron'); -- Kitron Macaron
INSERT INTO `synth_recipes` VALUES (3756,0,2042,0,0,0,45,0,0,0,0,4096,4238,615,627,4499,4570,0,0,0,0,5782,5782,5782,5782,2,4,6,8,'Sugar Rusk'); -- Sugar Rusk
INSERT INTO `synth_recipes` VALUES (3757,0,2042,0,0,0,65,0,0,0,0,4096,4238,615,4496,4496,4499,4570,0,0,0,5783,5783,5783,5783,2,4,6,8,'Chocolate Rusk'); -- Chocolate Rusk
INSERT INTO `synth_recipes` VALUES (3758,0,2042,0,0,0,85,0,0,0,0,4096,4238,615,4499,4570,5187,0,0,0,0,5784,5784,5784,5784,2,4,6,8,'Coconut Rusk'); -- Coconut Rusk
INSERT INTO `synth_recipes` VALUES (3759,1,0,0,0,0,0,85,0,0,0,4100,4242,13353,0,0,0,0,0,0,0,787,787,746,746,1,1,1,2,'Diamond'); -- diamond earring desynth
INSERT INTO `synth_recipes` VALUES (3760,0,0,93,0,0,0,0,0,0,0,4103,4245,1391,9130,0,0,0,0,0,0,27218,27219,27219,27219,1,1,1,1,'Bewitched Cuisses'); -- bewitched cuisses
INSERT INTO `synth_recipes` VALUES (3761,0,0,113,70,0,0,0,0,0,0,4103,4245,1390,8983,9002,9130,0,0,0,0,27218,27219,27219,27219,1,1,1,1,'Bewitched Cuisses'); -- bewitched cuisses
INSERT INTO `synth_recipes` VALUES (3762,0,0,93,0,0,0,0,0,0,0,4103,4245,9130,10591,0,0,0,0,0,0,27314,27315,27315,27315,1,1,1,1,'Vexed Slops'); -- vexed slops
INSERT INTO `synth_recipes` VALUES (3763,0,0,113,0,70,0,0,0,0,0,4103,4245,8728,9007,9130,10586,0,0,0,0,27314,27315,27315,27315,1,1,1,1,'Vexed Slops'); -- vexed slops
INSERT INTO `synth_recipes` VALUES (3764,0,0,94,0,0,0,0,1,0,0,4096,4238,850,1656,4145,4145,4145,4145,0,0,16249,16249,16249,16249,1,1,1,1,'Elixir Tank'); -- elixir tank
INSERT INTO `synth_recipes` VALUES (3765,0,0,94,0,0,0,0,0,0,0,4103,4245,1385,9130,0,0,0,0,0,0,26690,26691,26691,26691,1,1,1,1,'Bewitched Mask'); -- bewitched mask
INSERT INTO `synth_recipes` VALUES (3766,0,0,114,70,0,0,0,0,0,0,4103,4245,1384,8983,9002,9130,0,0,0,0,26690,26691,26691,26691,1,1,1,1,'Bewitched Mask'); -- bewitched mask
INSERT INTO `synth_recipes` VALUES (3767,0,0,94,0,0,0,0,0,0,0,4103,4245,9130,10427,0,0,0,0,0,0,25625,25626,25626,25626,1,1,1,1,'Vexed Coif'); -- vexed coif
INSERT INTO `synth_recipes` VALUES (3768,0,0,114,0,70,0,0,0,0,0,4103,4245,8728,9007,9130,10422,0,0,0,0,25625,25626,25626,25626,1,1,1,1,'Vexed Coif'); -- vexed coif
INSERT INTO `synth_recipes` VALUES (3769,0,0,95,0,0,0,0,0,0,0,4103,4245,1387,9130,0,0,0,0,0,0,26866,26867,26867,26867,1,1,1,1,'Bewitched Mail'); -- bewitched mail
INSERT INTO `synth_recipes` VALUES (3770,0,0,115,70,0,0,0,0,0,0,4103,4245,1386,8983,9002,9130,0,0,0,0,26866,26867,26867,26867,1,1,1,1,'Bewitched Mail'); -- bewitched mail
INSERT INTO `synth_recipes` VALUES (3771,0,0,95,0,0,0,0,0,0,0,4103,4245,9130,10248,0,0,0,0,0,0,25698,25699,25699,25699,1,1,1,1,'Vexed Doublet'); -- vexed doublet
INSERT INTO `synth_recipes` VALUES (3772,0,0,115,0,70,0,0,0,0,0,4103,4245,8728,9007,9130,10243,0,0,0,0,25698,25699,25699,25699,1,1,1,1,'Vexed Doublet'); -- vexed doublet
INSERT INTO `synth_recipes` VALUES (3773,0,2037,103,0,0,0,0,0,0,0,4096,4238,663,933,1887,4665,18238,21380,0,0,2415,2415,2415,2415,3,3,3,3,'Turbo Charger Ii'); -- turbo charger II
INSERT INTO `synth_recipes` VALUES (3774,0,2037,103,0,0,0,0,0,0,0,4096,4238,663,933,1305,21380,0,0,0,0,2416,2416,2416,2416,3,3,3,3,'Vivi-valve Ii'); -- vivi-valve II
INSERT INTO `synth_recipes` VALUES (3775,0,0,104,0,0,0,0,0,60,0,4098,4240,937,1626,5306,5306,8748,0,0,0,8928,8928,8928,8928,6,8,10,12,'Rig. Bolt Heads'); -- righteous bolt heads
INSERT INTO `synth_recipes` VALUES (3776,0,0,105,0,0,0,0,0,0,0,4103,4245,940,2875,3549,12987,0,0,0,0,10356,10361,10361,10361,1,1,1,1,'Hexed Nails'); -- hexed nails
INSERT INTO `synth_recipes` VALUES (3777,0,0,106,0,0,0,0,0,0,0,4103,4245,940,2875,3549,12859,0,0,0,0,10586,10591,10591,10591,1,1,1,1,'Hexed Slops'); -- hexed slops
INSERT INTO `synth_recipes` VALUES (3778,0,0,106,0,0,0,25,0,0,0,4099,4241,760,760,778,1675,4154,4154,5306,0,10392,10393,10393,10393,1,1,1,1,'Malison Medallion'); -- malison medallion
INSERT INTO `synth_recipes` VALUES (3779,0,0,107,0,0,0,0,0,0,0,4103,4245,940,2875,3549,12475,0,0,0,0,10422,10427,10427,10427,1,1,1,1,'Hexed Coif'); -- hexed coif
INSERT INTO `synth_recipes` VALUES (3780,0,0,108,0,0,0,0,0,0,0,4103,4245,940,2875,3549,12731,0,0,0,0,10306,10311,10311,10311,1,1,1,1,'Hexed Gages'); -- hexed gages
INSERT INTO `synth_recipes` VALUES (3781,0,0,110,0,0,0,0,0,0,0,4103,4245,940,2875,3549,3549,12603,0,0,0,10243,10248,10248,10248,1,1,1,1,'Hexed Doublet'); -- hexed doublet
INSERT INTO `synth_recipes` VALUES (3782,0,0,91,0,0,0,0,0,0,0,4103,4245,1393,9130,0,0,0,0,0,0,27394,27395,27395,27395,1,1,1,1,'Bewitched Greaves'); -- bewitched greaves
INSERT INTO `synth_recipes` VALUES (3783,0,0,111,70,0,0,0,0,0,0,4103,4245,1392,8983,9002,9130,0,0,0,0,27394,27395,27395,27395,1,1,1,1,'Bewitched Greaves'); -- bewitched greaves
INSERT INTO `synth_recipes` VALUES (3784,0,0,91,0,0,0,0,0,0,0,4103,4245,9130,10361,0,0,0,0,0,0,27485,27486,27486,27486,1,1,1,1,'Vexed Nails'); -- vexed nails
INSERT INTO `synth_recipes` VALUES (3785,0,0,111,0,70,0,0,0,0,0,4103,4245,8728,9007,9130,10356,0,0,0,0,27485,27486,27486,27486,1,1,1,1,'Vexed Nails'); -- vexed nails
INSERT INTO `synth_recipes` VALUES (3786,0,0,92,0,0,0,0,0,0,0,4103,4245,1389,9130,0,0,0,0,0,0,27042,27043,27043,27043,1,1,1,1,'Bewitch. Fin. Ga.'); -- bewitched finger gauntlets
INSERT INTO `synth_recipes` VALUES (3787,0,0,112,70,0,0,0,0,0,0,4103,4245,1388,8983,9002,9130,0,0,0,0,27042,27043,27043,27043,1,1,1,1,'Bewitch. Fin. Ga.'); -- bewitched finger gauntlets
INSERT INTO `synth_recipes` VALUES (3788,0,0,118,0,0,0,0,0,0,0,4096,4238,9002,9004,9007,9062,0,0,0,0,26181,26182,26182,26182,1,1,1,1,'Chirich Ring'); -- chirich ring
INSERT INTO `synth_recipes` VALUES (3789,0,0,92,0,0,0,0,0,0,0,4103,4245,9130,10311,0,0,0,0,0,0,27129,27130,27130,27130,1,1,1,1,'Vexed Gages'); -- vexed gages
INSERT INTO `synth_recipes` VALUES (3790,0,0,112,0,70,0,0,0,0,0,4103,4245,8728,9007,9130,10306,0,0,0,0,27129,27130,27130,27130,1,1,1,1,'Vexed Gages'); -- vexed gages
INSERT INTO `synth_recipes` VALUES (3791,0,0,90,0,0,0,0,0,0,0,4101,4243,937,3923,3935,3936,16919,0,0,0,21009,21010,21010,21010,1,1,1,1,'Nakajimarai'); -- nakajimarai
INSERT INTO `synth_recipes` VALUES (3792,0,0,90,0,0,0,0,0,0,0,4101,4243,937,3923,3935,3936,16456,0,0,0,20639,20640,20640,20640,1,1,1,1,'Oxidant Baselard'); -- oxidant baselard
INSERT INTO `synth_recipes` VALUES (3793,0,0,83,0,0,0,0,0,0,0,4098,4240,2460,0,0,0,0,0,0,0,16132,16133,16133,16133,1,1,1,1,'Dandy Spectacles'); -- dandy spectacles
INSERT INTO `synth_recipes` VALUES (3794,0,0,79,0,47,0,19,0,0,0,4096,4238,633,650,744,829,1887,1997,2712,0,429,429,429,429,1,1,1,1,'R. Storm Lantern'); -- red storm lantern
INSERT INTO `synth_recipes` VALUES (3795,0,0,79,0,47,0,19,0,0,0,4096,4238,633,650,744,829,1887,1997,2706,0,430,430,430,430,1,1,1,1,'B. Storm Lantern'); -- blue storm lantern
INSERT INTO `synth_recipes` VALUES (3796,0,0,79,0,47,0,19,0,0,0,4096,4238,633,650,744,829,1887,1997,2707,0,431,431,431,431,1,1,1,1,'G. Storm Lantern'); -- green storm lantern
INSERT INTO `synth_recipes` VALUES (3797,0,0,79,0,47,0,19,0,0,0,4096,4238,633,650,744,829,1887,1997,2708,0,432,432,432,432,1,1,1,1,'Y. Storm Lantern'); -- yellow storm lantern
INSERT INTO `synth_recipes` VALUES (3798,0,0,79,0,47,0,19,0,0,0,4096,4238,633,650,744,829,1887,1997,2709,0,433,433,433,433,1,1,1,1,'W. Storm Lantern'); -- white storm lantern
INSERT INTO `synth_recipes` VALUES (3799,0,0,77,0,0,0,23,0,0,0,4096,4238,784,817,817,2475,2475,0,0,0,355,355,355,355,1,1,1,1,'Bread Crock'); -- bread crock
INSERT INTO `synth_recipes` VALUES (3800,0,2037,76,0,0,0,0,0,0,0,4096,4238,1656,1844,2229,2290,3935,0,0,0,9074,9074,9074,9074,12,12,12,12,'Regulator'); -- regulator
INSERT INTO `synth_recipes` VALUES (3801,0,2033,74,0,0,0,0,0,0,0,4102,4244,924,1133,1626,2013,2014,2229,2365,13447,28568,28568,28568,28568,1,1,1,1,'Resolution Ring'); -- resolution ring
INSERT INTO `synth_recipes` VALUES (3802,0,0,72,0,0,0,0,0,14,0,4098,4240,649,940,2163,0,0,0,0,0,2650,2650,2650,2650,6,8,10,12,'Drk. Bolt Heads'); -- darkling bolt heads
INSERT INTO `synth_recipes` VALUES (3803,0,2037,70,0,0,0,0,0,0,0,4096,4238,933,1886,1887,2309,2362,0,0,0,9067,9067,9067,9067,12,12,12,12,'Repeater'); -- repeater
INSERT INTO `synth_recipes` VALUES (3804,0,2037,70,0,0,0,0,0,0,0,4096,4238,754,1886,2309,2310,2460,0,0,0,9134,9134,9134,9134,12,12,12,12,'Tranquilizer Iii'); -- tranquilizer III
INSERT INTO `synth_recipes` VALUES (3805,0,2037,68,0,0,0,0,0,0,0,4096,4238,932,1772,2290,2310,2362,0,0,0,9041,9041,9041,9041,12,12,12,12,'Coiler Ii'); -- coiler II
INSERT INTO `synth_recipes` VALUES (3806,0,2037,67,0,0,0,0,0,0,0,4096,4238,939,1642,2310,2460,2460,0,0,0,9135,9135,9135,9135,12,12,12,12,'Amplifier Ii'); -- amplifier II
INSERT INTO `synth_recipes` VALUES (3807,0,2037,65,0,0,0,0,0,0,0,4096,4238,752,1886,2309,2310,2460,0,0,0,9035,9035,9035,9035,12,12,12,12,'Tranquilizer Ii'); -- tranquilizer II
INSERT INTO `synth_recipes` VALUES (3808,0,0,64,0,0,0,0,0,0,0,4100,4242,3930,3930,0,0,0,0,0,0,3931,3931,3931,3931,1,2,3,4,'Twitherym Scale'); -- twitherym scale
INSERT INTO `synth_recipes` VALUES (3809,0,2037,62,0,0,0,0,0,0,0,4096,4238,939,1642,1887,2310,2460,0,0,0,9066,9066,9066,9066,12,12,12,12,'Amplifier'); -- amplifier
INSERT INTO `synth_recipes` VALUES (3810,0,2037,60,0,0,0,0,0,0,0,4096,4238,939,1646,2309,2310,2460,0,0,0,9043,9043,9043,9043,12,12,12,12,'Stealth Screen Ii'); -- stealth screen II
INSERT INTO `synth_recipes` VALUES (3811,0,0,60,0,0,0,0,0,0,0,4101,4243,638,638,2361,4509,0,0,0,0,4116,4117,4118,4119,1,1,1,1,'Hi-potion'); -- hi-potion
INSERT INTO `synth_recipes` VALUES (3812,0,2037,60,0,0,0,0,0,0,0,4096,4238,939,1641,1887,2310,2460,0,0,0,9065,9065,9065,9065,12,12,12,12,'Inhibitor Ii'); -- inhibitor II
INSERT INTO `synth_recipes` VALUES (3813,0,2036,60,0,0,0,0,0,0,0,4096,4238,638,638,2361,4509,0,0,0,0,5328,5328,5328,5328,1,2,3,4,'Hi-potion Drop'); -- hi-potion drop
INSERT INTO `synth_recipes` VALUES (3814,0,2036,60,0,0,0,0,0,0,0,4096,4238,638,638,2513,4509,0,0,0,0,5328,5328,5328,5328,1,2,3,4,'Hi-potion Drop'); -- hi-potion drop
INSERT INTO `synth_recipes` VALUES (3815,0,0,58,0,0,0,0,0,29,0,4099,4241,651,651,928,928,928,934,947,947,17314,17314,17314,17314,4,6,9,12,'Quake Grenade'); -- quake grenade
INSERT INTO `synth_recipes` VALUES (3816,0,0,52,0,0,0,0,0,0,0,4099,4241,8917,8917,0,0,0,0,0,0,8803,8803,8803,8803,33,66,66,99,'Ranka'); -- ranka
INSERT INTO `synth_recipes` VALUES (3817,0,2035,51,0,0,0,0,0,0,0,4102,4244,2131,4509,4509,4509,0,0,0,0,4154,4154,4154,4154,3,6,9,12,'Holy Water'); -- holy water
INSERT INTO `synth_recipes` VALUES (3818,0,0,50,0,0,0,0,0,0,0,4099,4241,913,2960,2960,0,0,0,0,0,2642,2642,2642,2642,33,66,66,99,'Kabenro'); -- kabenro
INSERT INTO `synth_recipes` VALUES (3819,0,0,50,0,0,0,0,0,0,0,4101,4243,8898,0,0,0,0,0,0,0,4128,4128,4128,4128,1,1,1,1,'Ether'); -- ether
INSERT INTO `synth_recipes` VALUES (3820,0,0,43,27,0,0,0,0,0,0,4101,4243,880,880,880,880,914,0,0,0,5351,5351,5351,5351,3,6,9,9,'Osseous Serum'); -- osseous serum
INSERT INTO `synth_recipes` VALUES (3821,0,0,43,0,0,0,0,0,0,0,4096,4238,714,2475,2475,0,0,0,0,0,3608,3608,3608,3608,1,1,1,1,'Fictile Pot'); -- fictile pot
INSERT INTO `synth_recipes` VALUES (3822,0,0,40,0,0,0,0,0,0,0,4099,4241,8896,0,0,0,0,0,0,0,947,947,947,947,2,2,2,2,'Firesand'); -- firesand
INSERT INTO `synth_recipes` VALUES (3823,0,0,35,0,0,0,0,0,0,0,4101,4243,8895,0,0,0,0,0,0,0,16410,16410,16410,16410,1,1,1,1,'Psn. Baghnakhs'); -- poison baghnakhs
INSERT INTO `synth_recipes` VALUES (3824,0,0,35,0,0,0,0,0,0,0,4096,4238,637,769,2792,0,0,0,0,0,2784,2784,2784,2784,3,6,9,12,'Fire Fewell'); -- fire fewell
INSERT INTO `synth_recipes` VALUES (3825,0,0,35,0,0,0,0,0,0,0,4097,4239,637,773,2792,0,0,0,0,0,2785,2785,2785,2785,3,6,9,12,'Ice Fewell'); -- ice fewell
INSERT INTO `synth_recipes` VALUES (3826,0,0,35,0,0,0,0,0,0,0,4098,4240,637,772,2792,0,0,0,0,0,2786,2786,2786,2786,3,6,9,12,'Wind Fewell'); -- wind fewell
INSERT INTO `synth_recipes` VALUES (3827,0,0,35,0,0,0,0,0,0,0,4099,4241,637,771,2792,0,0,0,0,0,2787,2787,2787,2787,3,6,9,12,'Earth Fewell'); -- earth fewell
INSERT INTO `synth_recipes` VALUES (3828,0,0,35,0,0,0,0,0,0,0,4100,4242,637,774,2792,0,0,0,0,0,2788,2788,2788,2788,3,6,9,12,'Lightning Fewell'); -- lightning fewell
INSERT INTO `synth_recipes` VALUES (3829,0,0,35,0,0,0,0,0,0,0,4101,4243,637,770,2792,0,0,0,0,0,2789,2789,2789,2789,3,6,9,12,'Water Fewell'); -- water fewell
INSERT INTO `synth_recipes` VALUES (3830,0,0,35,0,0,0,0,0,0,0,4102,4244,637,776,2792,0,0,0,0,0,2790,2790,2790,2790,3,6,9,12,'Light Fewell'); -- light fewell
INSERT INTO `synth_recipes` VALUES (3831,0,0,35,0,0,0,0,0,0,0,4103,4245,637,775,2792,0,0,0,0,0,2791,2791,2791,2791,3,6,9,12,'Dark Fewell'); -- dark fewell
INSERT INTO `synth_recipes` VALUES (3832,0,0,33,27,0,0,0,0,0,0,4101,4243,891,891,914,0,0,0,0,0,5350,5350,5350,5350,3,6,9,12,'Volant Serum'); -- volant serum
INSERT INTO `synth_recipes` VALUES (3833,0,0,30,0,0,0,0,0,0,0,4099,4241,8894,0,0,0,0,0,0,0,1886,1886,1886,1886,1,1,1,1,'Sieglinde Putty'); -- sieglinde putty
INSERT INTO `synth_recipes` VALUES (3834,0,0,29,0,0,11,0,0,0,0,4099,4241,612,1134,2549,4570,0,0,0,0,1188,1188,1188,1188,33,66,99,99,'Sairui-ran'); -- sairui-ran
INSERT INTO `synth_recipes` VALUES (3835,0,0,29,0,0,0,0,0,0,0,4101,4243,5650,0,0,0,0,0,0,0,2712,2712,2712,2712,12,12,12,12,'Red Textile Dye'); -- red textile dye
INSERT INTO `synth_recipes` VALUES (3836,0,0,25,0,0,0,0,0,0,0,4101,4243,8893,0,0,0,0,0,0,0,16458,16458,16458,16458,1,1,1,1,'Poison Baselard'); -- poison baselard
INSERT INTO `synth_recipes` VALUES (3837,0,0,20,0,0,0,0,0,0,0,4101,4243,8892,0,0,0,0,0,0,0,18355,18355,18355,18355,1,1,1,1,'Hushed Baghnakhs'); -- hushed baghnakhs
INSERT INTO `synth_recipes` VALUES (3838,0,0,19,0,0,0,0,0,0,0,4103,4245,5465,17395,17397,0,0,0,0,0,1191,1191,1191,1191,33,66,99,99,'Kodoku'); -- kodoku
INSERT INTO `synth_recipes` VALUES (3839,0,0,15,0,0,0,0,0,0,0,4099,4241,947,1134,4375,0,0,0,0,0,2395,2395,2395,2395,3,6,9,12,'Spore Bomb'); -- spore bomb
INSERT INTO `synth_recipes` VALUES (3840,0,0,15,0,0,0,0,0,0,0,4099,4241,947,1134,4545,0,0,0,0,0,2394,2394,2394,2394,3,6,9,12,'Gysahl Bomb'); -- gysahl bomb
INSERT INTO `synth_recipes` VALUES (3841,0,0,10,0,0,0,0,0,0,0,4098,4240,8890,0,0,0,0,0,0,0,4166,4166,4166,4166,1,1,1,1,'Deodorizer'); -- deodorizer
INSERT INTO `synth_recipes` VALUES (3842,0,0,8,0,0,0,0,0,0,0,4101,4243,612,2507,4447,0,0,0,0,0,4162,4162,4162,4162,1,2,3,4,'Silencing Potion'); -- silencing potion
INSERT INTO `synth_recipes` VALUES (3843,0,0,0,5,0,0,0,0,0,0,4098,4240,8875,0,0,0,0,0,0,0,1883,1883,1883,1883,1,1,1,1,'Shell Powder'); -- shell powder
INSERT INTO `synth_recipes` VALUES (3844,0,0,0,10,0,0,0,0,0,0,4098,4240,8876,0,0,0,0,0,0,0,1215,1215,1215,1215,6,6,6,6,'Bone Arrowhd.'); -- bone arrowheads
INSERT INTO `synth_recipes` VALUES (3845,0,0,0,15,0,0,0,0,0,0,4099,4241,8877,0,0,0,0,0,0,0,13076,13076,13076,13076,1,1,1,1,'Fang Necklace'); -- fang necklace
INSERT INTO `synth_recipes` VALUES (3846,0,0,0,20,0,0,0,0,0,0,4098,4240,8878,0,0,0,0,0,0,0,16642,16642,16642,16642,1,1,1,1,'Bone Axe'); -- bone axe
INSERT INTO `synth_recipes` VALUES (3847,0,0,0,25,0,0,0,0,0,0,4098,4240,8879,0,0,0,0,0,0,0,13457,13457,13457,13457,1,1,1,1,'Beetle Ring'); -- beetle ring
INSERT INTO `synth_recipes` VALUES (3848,0,0,0,26,0,0,0,11,0,0,4099,4241,850,850,880,2832,0,0,0,0,11407,11412,11412,11412,1,1,1,1,'Mettle Leggings'); -- mettle leggings
INSERT INTO `synth_recipes` VALUES (3849,0,0,0,30,0,0,0,0,0,0,4099,4241,8880,0,0,0,0,0,0,0,12455,12455,12455,12455,1,1,1,1,'Beetle Mask'); -- beetle mask
INSERT INTO `synth_recipes` VALUES (3850,0,0,0,35,0,0,0,0,0,0,4099,4241,8881,0,0,0,0,0,0,0,12414,12414,12414,12414,1,1,1,1,'Turtle Shield'); -- turtle shield
INSERT INTO `synth_recipes` VALUES (3851,0,0,0,40,0,0,0,0,0,0,4098,4240,8882,0,0,0,0,0,0,0,17026,17026,17026,17026,1,1,1,1,'Bone Cudgel'); -- bone cudgel
INSERT INTO `synth_recipes` VALUES (3852,0,0,0,45,0,0,0,0,0,0,4099,4241,8883,0,0,0,0,0,0,0,13711,13711,13711,13711,1,1,1,1,'Carapace Mask'); -- carapace mask
INSERT INTO `synth_recipes` VALUES (3853,0,0,0,45,0,0,0,0,0,6,4098,4240,715,824,893,893,2851,0,0,0,18956,18959,18959,18959,1,1,1,1,'Serpette'); -- serpette
INSERT INTO `synth_recipes` VALUES (3854,0,0,0,50,0,0,0,0,0,0,4096,4238,8884,0,0,0,0,0,0,0,17062,17062,17062,17062,1,1,1,1,'Bone Rod'); -- bone rod
INSERT INTO `synth_recipes` VALUES (3855,0,0,0,60,0,0,0,0,0,0,4098,4240,711,2854,0,0,0,0,0,0,19119,19127,19127,19127,1,1,1,1,'Ranging Knife'); -- ranging knife
INSERT INTO `synth_recipes` VALUES (3856,0,0,0,60,0,0,0,0,0,0,4100,4242,3940,0,0,0,0,0,0,0,5954,5954,5954,5954,1,2,3,4,'Barnacle'); -- barnacle
INSERT INTO `synth_recipes` VALUES (3857,0,0,0,62,0,0,33,0,50,0,4096,4238,654,744,803,914,2769,0,0,0,19117,19117,19117,19117,1,1,1,1,'Ogre Jambiya'); -- ogre jambiya
INSERT INTO `synth_recipes` VALUES (3858,0,0,0,66,0,0,0,0,45,33,4098,4240,654,719,2756,2769,0,0,0,0,18954,18954,18954,18954,1,1,1,1,'Ogre Sickle'); -- ogre sickle
INSERT INTO `synth_recipes` VALUES (3859,0,0,0,78,0,0,0,0,0,0,4099,4241,2833,12452,0,0,0,0,0,0,11495,11498,11498,11498,1,1,1,1,'Zeal Cap'); -- zeal cap
INSERT INTO `synth_recipes` VALUES (3860,0,0,0,79,0,0,0,0,0,0,4098,4240,850,3933,0,0,0,0,0,0,28406,28407,28407,28407,1,1,1,1,'Nuna Gorget'); -- nuna gorget
INSERT INTO `synth_recipes` VALUES (3861,0,0,0,80,0,0,0,0,0,0,4099,4241,823,889,2830,2830,12602,0,0,0,11346,11352,11352,11352,1,1,1,1,'Vela Justaucorps'); -- vela justaucorps
INSERT INTO `synth_recipes` VALUES (3862,0,0,0,82,0,0,0,0,0,0,4098,4240,880,1616,0,0,0,0,0,0,2648,2648,2648,2648,6,8,10,12,'Ant. Arrowhd.'); -- antlion arrowheads
INSERT INTO `synth_recipes` VALUES (3863,0,2026,0,82,0,0,0,0,0,0,4098,4240,880,880,880,1616,1616,1616,2130,0,2648,2648,2648,2648,18,24,30,36,'Ant. Arrowhd.'); -- antlion arrowheads
INSERT INTO `synth_recipes` VALUES (3864,0,0,0,84,0,0,0,0,0,0,4098,4240,880,3932,0,0,0,0,0,0,3944,3944,3944,3944,6,8,10,12,'Chapuli Arrowhd.'); -- chapuli arrowheads
INSERT INTO `synth_recipes` VALUES (3865,0,2026,0,84,0,0,0,0,0,0,4098,4240,880,880,880,2130,3932,3932,3932,0,3944,3944,3944,3944,18,24,30,36,'Chapuli Arrowhd.'); -- chapuli arrowheads
INSERT INTO `synth_recipes` VALUES (3866,0,0,0,85,0,0,0,0,0,0,4098,4240,880,2754,0,0,0,0,0,0,3305,3305,3305,3305,6,8,10,12,'Ruszor Arrowhd.'); -- ruszor arrowheads
INSERT INTO `synth_recipes` VALUES (3867,0,2026,0,85,0,0,0,0,0,0,4098,4240,880,880,880,2130,2754,2754,2754,0,3305,3305,3305,3305,18,24,30,36,'Ruszor Arrowhd.'); -- ruszor arrowheads
INSERT INTO `synth_recipes` VALUES (3868,0,0,0,88,0,0,33,0,0,0,4098,4240,760,2754,2754,0,0,0,0,0,11056,11057,11057,11057,1,1,1,1,'Ghillie Earring'); -- ghillie earring
INSERT INTO `synth_recipes` VALUES (3869,0,0,0,88,0,0,0,0,0,0,4098,4240,880,2747,0,0,0,0,0,0,3505,3505,3505,3505,6,8,10,12,'Gar. Arrowhd.'); -- gargouille arrowheads
INSERT INTO `synth_recipes` VALUES (3870,0,2026,0,88,0,0,0,0,0,0,4098,4240,880,880,880,2130,2747,2747,2747,0,3505,3505,3505,3505,18,24,30,36,'Gar. Arrowhd.'); -- gargouille arrowheads
INSERT INTO `synth_recipes` VALUES (3871,0,0,0,90,0,0,0,0,0,0,4098,4240,880,3938,0,0,0,0,0,0,3946,3946,3946,3946,6,8,10,12,'Mantid Arrowhd.'); -- mantid arrowheads
INSERT INTO `synth_recipes` VALUES (3872,0,2026,0,90,0,0,0,0,0,0,4098,4240,880,880,880,2130,3938,3938,3938,0,3946,3946,3946,3946,18,24,30,36,'Mantid Arrowhd.'); -- mantid arrowheads
INSERT INTO `synth_recipes` VALUES (3873,0,0,0,90,0,0,40,0,0,0,4099,4241,760,760,1715,1835,0,0,0,0,10963,10963,10963,10963,1,1,1,1,'Airmids Gorget'); -- airmid's gorget
INSERT INTO `synth_recipes` VALUES (3874,0,0,45,90,0,0,0,0,0,0,4098,4240,887,887,3931,3934,0,0,0,0,28583,28584,28584,28584,1,1,1,1,'Vexer Ring'); -- vexer ring
INSERT INTO `synth_recipes` VALUES (3875,0,0,0,91,0,0,0,0,0,0,4099,4241,3933,3934,0,0,0,0,0,0,28667,28668,28668,28668,1,1,1,1,'Matamata Shield'); -- matamata shield
INSERT INTO `synth_recipes` VALUES (3876,0,0,0,91,0,0,0,0,0,0,4099,4241,1403,9130,0,0,0,0,0,0,27384,27385,27385,27385,1,1,1,1,'Bewitched Leggings'); -- bewitched leggings
INSERT INTO `synth_recipes` VALUES (3877,0,0,0,91,0,0,0,0,0,0,4099,4241,9130,10360,0,0,0,0,0,0,27483,27484,27484,27484,1,1,1,1,'Vexed Gamashes'); -- vexed gamashes
INSERT INTO `synth_recipes` VALUES (3878,0,0,0,92,0,0,0,0,0,0,4098,4240,880,8709,0,0,0,0,0,0,8706,8706,8706,8706,6,8,10,12,'Raaz Arrowhd.'); -- raaz arrowheads
INSERT INTO `synth_recipes` VALUES (3879,0,2026,0,92,0,0,0,0,0,0,4098,4240,880,880,880,2130,8709,8709,8709,0,8706,8706,8706,8706,18,24,30,36,'Raaz Arrowhd.'); -- raaz arrowheads
INSERT INTO `synth_recipes` VALUES (3880,0,0,0,92,0,0,0,0,0,0,4099,4241,1399,9130,0,0,0,0,0,0,27032,27033,27033,27033,1,1,1,1,'Bewitched Gloves'); -- bewitched gloves
INSERT INTO `synth_recipes` VALUES (3881,0,0,0,92,0,0,0,0,0,0,4099,4241,9130,10310,0,0,0,0,0,0,27127,27128,27128,27128,1,1,1,1,'Vexed Wristbands'); -- vexed wristbands
INSERT INTO `synth_recipes` VALUES (3882,0,0,0,93,0,0,0,0,60,0,4099,4241,669,2152,2747,2747,2747,0,0,0,18789,18790,18790,18790,1,1,1,1,'Marath Baghnakhs'); -- marath baghnakhs
INSERT INTO `synth_recipes` VALUES (3883,0,0,0,93,0,0,0,0,0,0,4099,4241,1401,9130,0,0,0,0,0,0,27208,27209,27209,27209,1,1,1,1,'Bewitched Subligar'); -- bewitched subligar
INSERT INTO `synth_recipes` VALUES (3884,0,0,45,93,0,0,0,0,0,0,4103,4245,886,893,893,902,902,924,1589,2365,6410,6410,6410,6410,1,1,1,1,'Shadow Throne'); -- shadow throne
INSERT INTO `synth_recipes` VALUES (3885,0,0,0,94,0,0,0,0,0,0,4099,4241,1395,9130,0,0,0,0,0,0,26680,26681,26681,26681,1,1,1,1,'Bewitched Cap'); -- bewitched cap
INSERT INTO `synth_recipes` VALUES (3886,0,0,0,95,0,0,30,0,0,48,4098,4240,716,1681,1681,2754,2754,0,0,0,18791,18792,18792,18792,1,1,1,1,'Buzbaz Sainti'); -- buzbaz sainti
INSERT INTO `synth_recipes` VALUES (3887,0,0,0,95,0,0,0,0,0,0,4099,4241,1397,9130,0,0,0,0,0,0,26856,26857,26857,26857,1,1,1,1,'Bewitched Harness'); -- bewitched harness
INSERT INTO `synth_recipes` VALUES (3888,0,0,0,95,0,0,0,0,0,0,4099,4241,9130,10247,0,0,0,0,0,0,25696,25697,25697,25697,1,1,1,1,'Vexed Jacket'); -- vexed jacket
INSERT INTO `synth_recipes` VALUES (3889,0,0,0,97,0,0,0,52,0,0,4099,4241,8982,8983,0,0,0,0,0,0,26724,26725,26725,26725,1,1,1,1,'Sombra Tiara'); -- sombra tiara
INSERT INTO `synth_recipes` VALUES (3890,0,0,0,98,49,0,0,49,0,0,4099,4241,836,1629,8708,8982,8983,0,0,0,27989,27990,27990,27990,1,1,1,1,'Sombra Mittens'); -- sombra mittens
INSERT INTO `synth_recipes` VALUES (3891,0,0,0,99,49,0,0,49,0,0,4099,4241,830,836,8708,8982,8983,0,0,0,27226,27227,27227,27227,1,1,1,1,'Sombra Tights'); -- sombra tights
INSERT INTO `synth_recipes` VALUES (3892,0,0,0,100,0,0,0,0,60,0,4099,4241,654,735,1816,0,0,0,0,0,19741,19742,19742,19742,1,1,1,1,'Handgonne'); -- handgonne
INSERT INTO `synth_recipes` VALUES (3893,0,0,0,101,0,0,0,0,0,0,4098,4240,879,1586,2172,0,0,0,0,0,16073,16074,16074,16074,1,1,1,1,'Hydra Mask'); -- hydra mask
INSERT INTO `synth_recipes` VALUES (3894,0,0,0,104,0,0,0,0,0,0,4098,4240,2654,0,0,0,0,0,0,0,2735,2735,2735,2735,1,2,3,4,'Dk. Ixion Ferrule'); -- dark ixion ferrule
INSERT INTO `synth_recipes` VALUES (3895,0,0,0,105,0,0,0,0,0,0,4098,4240,763,792,865,1274,1312,2147,2426,5466,333,333,333,333,1,1,1,1,'Winged Balance'); -- winged balance
INSERT INTO `synth_recipes` VALUES (3896,0,0,0,105,0,0,0,0,0,0,4099,4241,651,730,819,2275,3872,3872,3872,0,18793,18794,18794,18794,1,1,1,1,'Blutkrallen'); -- blutkrallen
INSERT INTO `synth_recipes` VALUES (3897,0,0,0,105,0,0,0,0,0,0,4098,4240,760,8719,0,0,0,0,0,0,8720,8720,8720,8720,6,8,10,12,'Maliya. Coral Orb'); -- maliyakaleya orb
INSERT INTO `synth_recipes` VALUES (3898,0,0,0,106,0,0,30,56,0,0,4099,4241,837,2152,2877,3546,3546,0,0,0,10355,10360,10360,10360,1,1,1,1,'Hexed Gamashes'); -- hexed gamashes
INSERT INTO `synth_recipes` VALUES (3899,0,0,0,106,0,0,30,56,0,0,4099,4241,828,2152,2877,3546,3548,0,0,0,10305,10310,10310,10310,1,1,1,1,'Hexed Wristbands'); -- hexed wristbands
INSERT INTO `synth_recipes` VALUES (3900,0,0,0,110,0,0,30,60,0,0,4099,4241,823,828,828,837,2877,3544,3546,3548,10242,10247,10247,10247,1,1,1,1,'Hexed Jacket'); -- hexed jacket
INSERT INTO `synth_recipes` VALUES (3901,0,0,0,111,0,0,0,70,0,0,4099,4241,1402,8719,9047,9130,0,0,0,0,27384,27385,27385,27385,1,1,1,1,'Bewitched Leggings'); -- bewitched leggings
INSERT INTO `synth_recipes` VALUES (3902,0,0,70,111,0,0,0,0,0,0,4099,4241,9005,9027,9130,10355,0,0,0,0,27483,27484,27484,27484,1,1,1,1,'Vexed Gamashes'); -- vexed gamashes
INSERT INTO `synth_recipes` VALUES (3903,0,0,0,112,0,0,0,70,0,0,4099,4241,1398,8719,9047,9130,0,0,0,0,27032,27033,27033,27033,1,1,1,1,'Bewitched Gloves'); -- bewitched gloves
INSERT INTO `synth_recipes` VALUES (3904,0,0,0,112,0,0,0,70,0,0,4099,4241,8988,9005,9130,10305,0,0,0,0,27127,27128,27128,27128,1,1,1,1,'Vexed Wristbands'); -- vexed wristbands
INSERT INTO `synth_recipes` VALUES (3905,0,0,0,113,0,0,0,70,0,0,4099,4241,1400,8719,9047,9130,0,0,0,0,27208,27209,27209,27209,1,1,1,1,'Bewitched Subligar'); -- bewitched subligar
INSERT INTO `synth_recipes` VALUES (3906,0,0,0,114,0,0,0,0,70,0,4099,4241,1394,8719,8990,9130,0,0,0,0,26680,26681,26681,26681,1,1,1,1,'Bewitched Cap'); -- bewitched cap
INSERT INTO `synth_recipes` VALUES (3907,0,0,0,115,0,0,0,70,0,0,4099,4241,1396,8719,9047,9130,0,0,0,0,26856,26857,26857,26857,1,1,1,1,'Bewitched Harness'); -- bewitched harness
INSERT INTO `synth_recipes` VALUES (3908,0,0,0,115,0,0,0,70,0,0,4099,4241,8988,9005,9130,10242,0,0,0,0,25696,25697,25697,25697,1,1,1,1,'Vexed Jacket'); -- vexed jacket
INSERT INTO `synth_recipes` VALUES (3909,0,0,0,118,0,0,0,0,0,0,4099,4241,9003,9005,9006,9061,0,0,0,0,22278,22279,22279,22279,1,1,1,1,'Staunch Tathlum'); -- staunch tathlum
INSERT INTO `synth_recipes` VALUES (3910,0,0,1,0,0,0,0,0,0,20,4099,4241,707,1886,1887,0,0,0,0,0,3701,3701,3701,3701,1,1,1,1,'Awning'); -- awning
INSERT INTO `synth_recipes` VALUES (3911,0,0,1,0,0,0,0,0,0,20,4099,4241,711,1886,1887,0,0,0,0,0,3702,3702,3702,3702,1,1,1,1,'Triangular Jalousie'); -- triangular jalousie
INSERT INTO `synth_recipes` VALUES (3912,0,0,1,0,0,0,0,0,0,20,4099,4241,718,1886,1887,0,0,0,0,0,3703,3703,3703,3703,1,1,1,1,'Square Jalousie'); -- square jalousie
INSERT INTO `synth_recipes` VALUES (3913,0,0,1,0,0,0,0,0,0,30,4099,4241,717,1886,1887,1888,17296,0,0,0,3704,3704,3704,3704,1,1,1,1,'Transom'); -- transom
INSERT INTO `synth_recipes` VALUES (3914,0,0,0,0,0,0,0,0,0,32,4099,4241,817,929,1134,1134,0,0,0,0,2555,2555,2555,2555,33,66,99,99,'Soshi'); -- soshi
INSERT INTO `synth_recipes` VALUES (3915,0,0,0,0,0,0,0,0,0,35,4099,4241,1657,2533,2533,2533,2546,2546,2546,0,19200,19200,19200,19200,99,99,99,99,'Black Bolt'); -- black bolt
INSERT INTO `synth_recipes` VALUES (3916,0,0,1,0,0,0,0,0,0,35,4099,4241,710,1886,1887,0,0,0,0,0,3709,3709,3709,3709,1,1,1,1,'Valance'); -- valance
INSERT INTO `synth_recipes` VALUES (3917,0,0,0,0,0,0,0,0,0,36,4099,4241,834,1134,0,0,0,0,0,0,2396,2396,2396,2396,1,1,1,1,'Fairwth. Fetish'); -- fairweather fetish
INSERT INTO `synth_recipes` VALUES (3918,0,0,0,0,0,0,0,0,1,36,4098,4240,2855,17217,0,0,0,0,0,0,19231,19241,19241,19241,1,1,1,1,'Trackers Bow'); -- tracker's bow
INSERT INTO `synth_recipes` VALUES (3919,0,0,1,0,0,0,0,0,0,40,4099,4241,717,1886,1887,0,0,0,0,0,3711,3711,3711,3711,1,1,1,1,'San Dorian Sill'); -- san d'orian sill
INSERT INTO `synth_recipes` VALUES (3920,0,0,1,0,0,0,0,0,0,40,4099,4241,728,1886,1887,0,0,0,0,0,3710,3710,3710,3710,1,1,1,1,'Windurstian Sill'); -- windurstian sill
INSERT INTO `synth_recipes` VALUES (3921,0,0,1,0,0,0,0,0,0,40,4099,4241,719,1886,1887,0,0,0,0,0,3712,3712,3712,3712,1,1,1,1,'Bastokan Sill'); -- bastokan sill
INSERT INTO `synth_recipes` VALUES (3922,0,0,0,0,0,0,0,0,103,0,4096,4238,1466,1469,3920,3920,0,0,0,0,658,658,658,658,1,1,1,1,'Damascus Ingot'); -- Damascus Ingot
INSERT INTO `synth_recipes` VALUES (3923,0,0,0,0,0,80,0,0,0,0,4101,4243,1111,4471,5152,0,0,0,0,0,17902,17902,17902,17902,4,6,8,10,'Lucky Broth'); -- Lucky Broth
INSERT INTO `synth_recipes` VALUES (3924,0,0,0,0,0,91,0,0,0,0,4101,4243,4272,5650,5680,0,0,0,0,0,17903,17903,17903,17903,4,6,8,10,'Shadowy Broth'); -- Shadowy Broth
INSERT INTO `synth_recipes` VALUES (3925,0,0,0,0,0,0,0,0,0,66,4103,4245,692,4373,4374,4375,0,0,0,0,17881,17881,17881,17881,4,6,8,10,'Deepbed Soil'); -- Deepbed Soil
INSERT INTO `synth_recipes` VALUES (3926,0,0,0,0,0,63,0,0,0,0,4101,4243,5135,5449,5454,0,0,0,0,0,17904,17904,17904,17904,4,6,8,10,'Briny Broth'); -- Briny Broth
INSERT INTO `synth_recipes` VALUES (3927,0,0,0,0,0,0,0,0,0,39,4103,4245,17868,17868,0,0,0,0,0,0,17894,17894,17894,17894,4,6,8,10,'Vermihumus'); -- Vermihumus
INSERT INTO `synth_recipes` VALUES (3928,0,0,0,0,0,0,0,0,0,39,4103,4245,533,533,0,0,0,0,0,0,17894,17894,17894,17894,4,6,8,10,'Vermihumus'); -- Vermihumus
INSERT INTO `synth_recipes` VALUES (3929,0,0,0,0,0,0,0,0,0,39,4103,4245,17869,17869,0,0,0,0,0,0,17894,17894,17894,17894,6,8,10,12,'Vermihumus'); -- Vermihumus
INSERT INTO `synth_recipes` VALUES (3930,0,0,0,0,0,45,0,0,0,0,4098,4240,2155,2155,17397,0,0,0,0,0,17893,17893,17893,17893,4,6,8,10,'Wool Grease'); -- Wool Grease
INSERT INTO `synth_recipes` VALUES (3931,0,0,0,0,0,0,0,0,0,66,4098,4240,2761,0,0,0,0,0,0,0,2762,2762,2762,2762,1,2,3,4,'Feywld. Lumber'); -- Feyweald Lumber
INSERT INTO `synth_recipes` VALUES (3932,0,0,0,0,0,0,100,0,0,0,4096,4238,4023,4023,4023,4023,0,0,0,0,4024,4024,4024,4024,1,1,1,1,'Snowsteel'); -- Snowsteel
INSERT INTO `synth_recipes` VALUES (3933,0,0,0,0,0,100,0,0,0,0,4096,4238,936,4375,4387,4449,4509,5680,0,0,5930,5931,5931,5931,1,1,1,1,'Sprightly Soup'); -- Sprightly Soup
INSERT INTO `synth_recipes` VALUES (3934,0,0,0,0,0,0,78,0,0,0,4098,4240,679,0,0,0,0,0,0,0,2651,2651,2651,2651,6,8,10,12,'Fsn. Bolt Heads'); -- Fusion Bolt Heads
INSERT INTO `synth_recipes` VALUES (3935,0,0,0,0,0,0,0,0,0,65,4099,4241,1243,3927,0,0,0,0,0,0,21323,21323,21323,21323,33,66,99,99,'Oxidant Bolt'); -- Oxidant bolt
INSERT INTO `synth_recipes` VALUES (3936,0,1987,0,0,0,0,0,0,0,65,4099,4241,1243,1243,1243,1657,3927,3927,3927,0,21323,21323,21323,21323,99,99,99,99,'Oxidant Bolt'); -- Oxidant bolt - KI Boltmaker
INSERT INTO `synth_recipes` VALUES (3937,0,0,0,0,0,102,0,0,0,0,4103,4245,95,583,612,614,936,1891,4273,0,5909,5909,5909,5909,1,1,1,1,'Pickled R. Tail'); -- Pickled Rarab Tail
INSERT INTO `synth_recipes` VALUES (3938,0,0,0,0,0,103,0,0,0,0,4096,4238,615,627,2237,4509,5568,5661,0,0,5922,5923,5923,5923,33,33,66,99,'Walnut Cookie'); -- Walnut Cookie
INSERT INTO `synth_recipes` VALUES (3939,0,0,0,0,0,104,0,0,0,0,4101,4243,5534,5536,5963,0,0,0,0,0,21492,21493,21493,21493,6,4,8,12,'Insipid Broth'); -- Insipid Broth
INSERT INTO `synth_recipes` VALUES (3940,0,0,0,0,0,104,0,0,0,0,4103,4245,703,2016,4031,4509,0,0,0,0,21494,21495,21495,21495,4,2,4,8,'Wetlands Broth'); -- Wetlands Broth
INSERT INTO `synth_recipes` VALUES (3941,0,0,0,0,0,104,0,0,0,0,4096,4238,898,898,4387,4435,4509,5234,9194,0,9197,9197,9197,9197,6,6,10,10,'Soy Ramen Soup'); -- Soy Ramen Soup
INSERT INTO `synth_recipes` VALUES (3942,0,0,0,0,0,104,0,0,0,0,4096,4238,614,617,898,898,4509,9193,9194,0,9198,9198,9198,9198,6,6,8,10,'Miso Ramen Soup'); -- Miso Ramen Soup
INSERT INTO `synth_recipes` VALUES (3943,0,0,0,0,0,104,0,0,0,0,4096,4238,936,1019,4379,4399,4461,4509,5131,0,9199,9199,9199,9199,6,6,6,6,'Salt Ramen Soup'); -- Salt Ramen Soup
INSERT INTO `synth_recipes` VALUES (3944,0,0,0,0,0,105,0,0,0,0,4096,4238,627,2156,4509,5566,0,0,0,0,5926,5927,5927,5927,1,1,1,1,'Date Tea'); -- Date Tea
INSERT INTO `synth_recipes` VALUES (3945,0,0,0,0,0,107,0,0,0,0,4096,4238,620,629,936,4509,5152,5651,0,0,5928,5929,5929,5929,4,1,1,1,'Himesama R. Ball'); -- Himesama R. Ball
INSERT INTO `synth_recipes` VALUES (3946,0,0,0,0,0,109,0,1,0,0,4099,4241,879,1656,5933,5933,5933,5933,0,0,11002,11002,11002,11002,1,1,1,1,'Dragon Tank'); -- Dragon Tank
INSERT INTO `synth_recipes` VALUES (3947,0,0,0,0,0,110,0,0,0,0,4096,4238,626,638,936,4356,4387,4435,4570,5152,5924,5925,5925,5925,1,1,1,1,'S. Salis. Steak'); -- Smoldering Salisbury Steak
INSERT INTO `synth_recipes` VALUES (3948,0,0,0,0,0,111,0,0,0,0,4096,4238,615,619,4273,4389,6416,0,0,0,6464,6465,6465,6465,1,1,1,1,'Behemoth Steak'); -- Behemoth Steak
INSERT INTO `synth_recipes` VALUES (3949,0,0,0,0,0,112,0,0,0,0,4096,4238,617,898,936,3978,4509,5234,5965,0,6069,6070,6070,6070,1,1,1,1,'Riverfin Soup'); -- Riverfin Soup
INSERT INTO `synth_recipes` VALUES (3950,0,0,0,0,0,112,0,0,0,0,4096,4238,619,623,626,629,633,936,4389,6068,6071,6072,6072,6072,1,1,1,1,'Magma Steak'); -- Magma Steak
INSERT INTO `synth_recipes` VALUES (3951,0,2042,0,0,0,112,0,0,0,0,4098,4240,627,4365,4370,4412,4412,8753,0,0,6223,6223,6224,6225,6,12,6,6,'C. Snow Cone'); -- Cehuetzi Snow Cone -- KI: Patissier
INSERT INTO `synth_recipes` VALUES (3952,0,2043,0,0,0,100,0,0,0,0,4096,4238,2111,4375,4509,4570,5233,5235,5236,6222,6219,6220,6221,6221,1,1,1,1,'Warthog Stewpot'); -- Warthog Stewpot -- KI Stewpot Mastery
INSERT INTO `synth_recipes` VALUES (3953,0,0,0,0,0,100,0,0,0,0,4101,4243,2506,2522,3937,4031,0,0,0,0,21450,21451,21451,21451,4,2,4,8,'Electrified Broth'); -- Electrified Broth
INSERT INTO `synth_recipes` VALUES (3954,0,0,0,0,0,100,0,0,0,0,4101,4243,620,629,2213,5531,0,0,0,0,17912,17919,17919,17919,4,2,4,8,'Fizzy Broth'); -- Fizzy Broth
INSERT INTO `synth_recipes` VALUES (3955,0,0,0,0,0,99,0,0,0,0,4096,4238,626,633,936,4356,4570,6393,0,0,6394,6395,6395,6395,1,1,2,3,'Pork Cutlet'); -- Pork Cutlet
INSERT INTO `synth_recipes` VALUES (3956,0,0,0,0,0,98,0,0,0,0,4101,4243,1111,4026,5152,5534,0,0,0,0,17911,17918,17918,17918,4,2,4,8,'Salubrious Broth'); -- Salubrious Broth
INSERT INTO `synth_recipes` VALUES (3957,0,0,0,0,0,97,0,0,0,0,4101,4243,4017,4017,4372,5965,0,0,0,0,17909,17917,17917,17917,4,2,4,8,'Spicy Broth'); -- Spicy Broth
INSERT INTO `synth_recipes` VALUES (3958,1,0,0,55,0,0,0,0,0,0,4100,4242,13324,0,0,0,0,0,0,0,885,885,1225,745,1,1,8,2,'Turtle Shell'); -- desynth tortoise earring
INSERT INTO `synth_recipes` VALUES (3959,0,0,0,0,5,0,0,0,0,0,4098,4240,8847,0,0,0,0,0,0,0,12464,12464,12464,12464,1,1,1,1,'Headgear'); -- headgear (kit)
INSERT INTO `synth_recipes` VALUES (3960,0,0,0,0,10,0,0,0,0,0,4099,4241,8848,0,0,0,0,0,0,0,12592,12592,12592,12592,1,1,1,1,'Doublet'); -- doublet (kit)
INSERT INTO `synth_recipes` VALUES (3961,0,0,0,0,15,0,0,0,0,0,4100,4242,8849,0,0,0,0,0,0,0,1828,1828,1828,1828,1,1,1,1,'Red Grs. Thread'); -- red grass thread (kit)
INSERT INTO `synth_recipes` VALUES (3962,0,0,0,0,20,0,0,0,0,0,4099,4241,8850,0,0,0,0,0,0,0,12498,12498,12498,12498,1,1,1,1,'Cotton Headband'); -- cotton headband (kit)
INSERT INTO `synth_recipes` VALUES (3963,0,0,0,0,25,0,0,0,0,0,4099,4241,8851,0,0,0,0,0,0,0,12722,12722,12722,12722,1,1,1,1,'Bracers'); -- bracers (kit)
INSERT INTO `synth_recipes` VALUES (3964,0,0,0,0,30,0,0,0,0,0,4099,4241,8852,0,0,0,0,0,0,0,13808,13808,13808,13808,1,1,1,1,'Fsh. Tunica'); -- fisherman's tunica (kit)
INSERT INTO `synth_recipes` VALUES (3965,0,0,0,0,32,0,0,0,0,0,4099,4241,819,826,834,2838,0,0,0,0,15053,15058,15058,15058,1,1,1,1,'Combat Mittens'); -- combat mittens
INSERT INTO `synth_recipes` VALUES (3966,0,0,0,0,35,0,0,0,0,0,4100,4242,8853,0,0,0,0,0,0,0,820,820,820,820,1,1,1,1,'Wool Thread'); -- wool thread (kit)
INSERT INTO `synth_recipes` VALUES (3967,0,0,0,0,38,0,0,0,0,0,4099,4241,2150,2150,2150,2150,2150,2150,2150,2288,16281,16282,16282,16282,1,1,1,1,'Buffoons Collar'); -- buffoon's collar
INSERT INTO `synth_recipes` VALUES (3968,0,0,0,0,40,0,0,0,0,0,4099,4241,8854,0,0,0,0,0,0,0,2400,2400,2400,2400,3,3,3,3,'Shadow Roll'); -- shadow roll (kit)
INSERT INTO `synth_recipes` VALUES (3969,0,0,0,0,40,0,0,0,0,0,4099,4241,820,820,827,850,0,0,0,0,2400,2400,2400,2400,3,3,3,3,'Shadow Roll'); -- shadow roll
INSERT INTO `synth_recipes` VALUES (3970,0,0,0,0,45,0,0,0,0,0,4099,4241,8855,0,0,0,0,0,0,0,12467,12467,12467,12467,1,1,1,1,'Wool Cap'); -- wool cap (kit)
INSERT INTO `synth_recipes` VALUES (3971,0,0,0,0,47,0,0,0,0,0,4101,4243,26,2706,0,0,0,0,0,0,394,394,394,394,1,1,1,1,'B. Tarutaru Desk'); -- blue tarutaru desk
INSERT INTO `synth_recipes` VALUES (3972,0,0,0,0,47,0,0,0,0,0,4101,4243,26,2707,0,0,0,0,0,0,395,395,395,395,1,1,1,1,'G. Tarutaru Desk'); -- green tarutaru desk
INSERT INTO `synth_recipes` VALUES (3973,0,0,0,0,47,0,0,0,0,0,4101,4243,26,2708,0,0,0,0,0,0,396,396,396,396,1,1,1,1,'Y. Tarutaru Desk'); -- yellow tarutaru desk
INSERT INTO `synth_recipes` VALUES (3974,0,0,0,0,47,0,0,0,0,0,4101,4243,26,2709,0,0,0,0,0,0,397,397,397,397,1,1,1,1,'W. Tarutaru Desk'); -- white tarutaru desk
INSERT INTO `synth_recipes` VALUES (3975,0,0,0,0,50,0,0,0,0,0,4099,4241,8856,0,0,0,0,0,0,0,828,828,828,828,1,1,1,1,'Velvet Cloth'); -- velvet cloth (kit)
INSERT INTO `synth_recipes` VALUES (3976,0,2009,0,0,51,0,0,0,0,0,4099,4241,816,818,818,1644,1646,1648,0,0,2425,2425,2425,2425,1,1,1,1,'Humid. Velvet'); -- humidified velvet
INSERT INTO `synth_recipes` VALUES (3977,0,0,0,0,54,0,27,0,0,0,4099,4241,2522,2522,2536,0,0,0,0,0,16009,16010,16010,16010,1,1,1,1,'Pennon Earring'); -- pennon earring
INSERT INTO `synth_recipes` VALUES (3978,0,0,0,0,54,0,0,0,0,0,4099,4241,817,825,825,2843,0,0,0,0,16373,16377,16377,16377,1,1,1,1,'Kyoshu Sitabaki'); -- kyoshu sitabaki
INSERT INTO `synth_recipes` VALUES (3979,0,0,0,0,60,0,0,0,0,0,4101,4243,104,2706,0,0,0,0,0,0,406,406,406,406,1,1,1,1,'B. Tarutaru Screen'); -- blue tarutaru standing screen
INSERT INTO `synth_recipes` VALUES (3980,0,0,0,0,60,0,0,0,0,0,4101,4243,104,2707,0,0,0,0,0,0,407,407,407,407,1,1,1,1,'G. Tarutaru Screen'); -- green tarutaru standing screen
INSERT INTO `synth_recipes` VALUES (3981,0,0,0,0,60,0,0,0,0,0,4101,4243,104,2708,0,0,0,0,0,0,408,408,408,408,1,1,1,1,'Y. Tarutaru Screen'); -- yellow tarutaru standing screen
INSERT INTO `synth_recipes` VALUES (3982,0,0,0,0,60,0,0,0,0,0,4101,4243,104,2709,0,0,0,0,0,0,409,409,409,409,1,1,1,1,'W. Tarutaru Screen'); -- white tarutaru standing screen
INSERT INTO `synth_recipes` VALUES (3983,0,0,32,0,64,0,0,0,0,0,4101,4243,21,2712,0,0,0,0,0,0,390,390,390,390,1,1,1,1,'Carmine Desk'); -- carmine desk
INSERT INTO `synth_recipes` VALUES (3984,0,0,32,0,64,0,0,0,0,0,4101,4243,21,2706,0,0,0,0,0,0,391,391,391,391,1,1,1,1,'Cerulean Desk'); -- cerulean desk
INSERT INTO `synth_recipes` VALUES (3985,0,0,32,0,64,0,0,0,0,0,4101,4243,21,2707,0,0,0,0,0,0,392,392,392,392,1,1,1,1,'Myrtle Desk'); -- myrtle desk
INSERT INTO `synth_recipes` VALUES (3986,0,0,32,0,64,0,0,0,0,0,4101,4243,21,2709,0,0,0,0,0,0,393,393,393,393,1,1,1,1,'Ecru Desk'); -- ecru desk
INSERT INTO `synth_recipes` VALUES (3987,0,0,0,0,64,0,0,32,0,0,4099,4241,825,850,851,913,1828,1829,1829,2831,11347,11353,11353,11353,1,1,1,1,'Menetriers Alb'); -- menetrier's alb
INSERT INTO `synth_recipes` VALUES (3988,0,0,0,0,65,0,32,0,0,0,4099,4241,673,819,826,826,827,827,5351,0,11320,11320,11320,11320,1,1,1,1,'Skeleton Robe'); -- skeleton robe
INSERT INTO `synth_recipes` VALUES (3989,0,0,33,0,66,0,0,33,0,0,4102,4244,760,828,828,850,850,1767,2113,2476,16365,16366,16366,16366,1,1,1,1,'Argent Hose'); -- argent hose
INSERT INTO `synth_recipes` VALUES (3990,0,0,0,0,67,0,0,0,0,0,4099,4241,828,828,2835,0,0,0,0,0,11532,11540,11540,11540,1,1,1,1,'Accura Cape'); -- accura cape
INSERT INTO `synth_recipes` VALUES (3991,0,0,0,0,68,0,0,0,0,0,4099,4241,822,828,828,5352,0,0,0,0,16257,16257,16257,16257,1,1,1,1,'Ghost Cape'); -- ghost cape
INSERT INTO `synth_recipes` VALUES (3992,0,0,0,0,69,0,0,0,0,0,4099,4241,822,828,828,829,829,2827,0,0,11341,11349,11349,11349,1,1,1,1,'Vivacity Coat'); -- vivacity coat
INSERT INTO `synth_recipes` VALUES (3993,0,0,37,0,75,0,0,0,0,0,4101,4243,4,820,2712,0,0,0,0,0,398,398,398,398,1,1,1,1,'Red Mahogany Bed'); -- red mahogany bed
INSERT INTO `synth_recipes` VALUES (3994,0,0,37,0,75,0,0,0,0,0,4101,4243,4,820,2706,0,0,0,0,0,399,399,399,399,1,1,1,1,'Blue Mahogany Bed'); -- blue mahogany bed
INSERT INTO `synth_recipes` VALUES (3995,0,0,37,0,75,0,0,0,0,0,4101,4243,4,820,2707,0,0,0,0,0,400,400,400,400,1,1,1,1,'Gr. Mahogany Bed'); -- green mahogany bed
INSERT INTO `synth_recipes` VALUES (3996,0,0,37,0,75,0,0,0,0,0,4101,4243,4,820,2708,0,0,0,0,0,401,401,401,401,1,1,1,1,'Yell. Mahogany Bed'); -- yellow mahogany bed
INSERT INTO `synth_recipes` VALUES (3997,0,0,0,0,76,0,0,0,0,0,4099,4241,821,2199,2199,0,0,0,0,0,2200,2200,2200,2200,1,1,1,1,'Twill Damask'); -- twill damask
INSERT INTO `synth_recipes` VALUES (3998,0,0,40,0,80,0,0,40,0,0,4099,4241,746,823,823,829,834,834,1110,2829,11345,11351,11351,11351,1,1,1,1,'Alacer Aketon'); -- alacer aketon
INSERT INTO `synth_recipes` VALUES (3999,0,0,0,0,81,0,0,0,0,0,4101,4243,6,823,2706,0,0,0,0,0,402,402,402,402,1,1,1,1,'Blue Nobles Bed'); -- blue noble's bed
INSERT INTO `synth_recipes` VALUES (4000,0,0,0,0,81,0,0,0,0,0,4101,4243,6,823,2707,0,0,0,0,0,403,403,403,403,1,1,1,1,'Green Nobles Bed'); -- green noble's bed
INSERT INTO `synth_recipes` VALUES (4001,0,0,0,0,81,0,0,0,0,0,4101,4243,6,823,2708,0,0,0,0,0,404,404,404,404,1,1,1,1,'Yel. Nobles Bed'); -- yellow noble's bed
INSERT INTO `synth_recipes` VALUES (4002,0,0,0,0,81,0,0,0,0,0,4101,4243,6,823,2709,0,0,0,0,0,405,405,405,405,1,1,1,1,'White Nobles Bed'); -- white noble's bed
INSERT INTO `synth_recipes` VALUES (4003,0,0,0,0,81,0,0,0,0,0,4098,4240,3504,3504,0,0,0,0,0,0,3506,3506,3506,3506,6,8,10,12,'Peapuk Fltchg.'); -- peapuk fletchings
INSERT INTO `synth_recipes` VALUES (4004,0,2011,0,0,81,0,0,0,0,0,4098,4240,2145,3504,3504,3504,3504,3504,3504,0,3506,3506,3506,3506,18,24,30,36,'Peapuk Fltchg.'); -- peapuk fletchings
INSERT INTO `synth_recipes` VALUES (4005,0,0,0,0,87,0,0,0,0,0,4098,4240,3941,3941,0,0,0,0,0,0,3943,3943,3943,3943,6,8,10,12,'Chapuli Fltchg.'); -- chapuli fletchings
INSERT INTO `synth_recipes` VALUES (4006,0,2011,0,0,87,0,0,0,0,0,4098,4240,2145,3941,3941,3941,3941,3941,3941,0,3943,3943,3943,3943,18,24,30,36,'Chapuli Fltchg.'); -- chapuli fletchings
INSERT INTO `synth_recipes` VALUES (4007,0,0,0,0,92,0,54,0,0,0,4099,4241,2275,2748,2756,2825,2825,0,0,0,12213,12213,12213,12213,1,1,1,1,'Ebon Mitts'); -- ebon mitts
INSERT INTO `synth_recipes` VALUES (4008,0,0,0,0,92,0,0,0,0,0,4099,4241,1369,9130,0,0,0,0,0,0,27040,27041,27041,27041,1,1,1,1,'Bewitched Mitts'); -- bewitched mitts
INSERT INTO `synth_recipes` VALUES (4009,0,0,0,0,92,0,0,0,0,0,4099,4241,9130,10312,0,0,0,0,0,0,27131,27132,27132,27132,1,1,1,1,'Vexed Cuffs'); -- vexed cuffs
INSERT INTO `synth_recipes` VALUES (4010,0,0,0,0,93,0,0,60,0,0,4099,4241,817,855,855,1711,2825,2825,0,0,12285,12285,12285,12285,1,1,1,1,'Ebon Clogs'); -- ebon clogs
INSERT INTO `synth_recipes` VALUES (4011,0,0,0,0,93,0,0,0,0,0,4099,4241,1371,9130,0,0,0,0,0,0,27216,27217,27217,27217,1,1,1,1,'Bewitched Slacks'); -- bewitched slacks
INSERT INTO `synth_recipes` VALUES (4012,0,0,0,0,93,0,0,0,0,0,4099,4241,9130,10592,0,0,0,0,0,0,27316,27317,27317,27317,1,1,1,1,'Vexed Tights'); -- vexed tights
INSERT INTO `synth_recipes` VALUES (4013,0,0,0,0,93,0,0,0,0,0,4099,4241,9130,10590,0,0,0,0,0,0,27312,27313,27313,27313,1,1,1,1,'Vexed Kecks'); -- vexed kecks
INSERT INTO `synth_recipes` VALUES (4014,0,0,0,0,94,0,0,0,0,0,4099,4241,9130,10428,0,0,0,0,0,0,25627,25628,25628,25628,1,1,1,1,'Vexed Mitra'); -- vexed mitra
INSERT INTO `synth_recipes` VALUES (4015,0,0,0,0,94,0,0,0,0,0,4099,4241,9130,10426,0,0,0,0,0,0,25623,25624,25624,25624,1,1,1,1,'Vexed Bonnet'); -- vexed bonnet
INSERT INTO `synth_recipes` VALUES (4016,0,0,0,0,95,0,0,50,60,0,4099,4241,664,664,2275,2825,2825,0,0,0,12249,12249,12249,12249,1,1,1,1,'Ebon Slops'); -- ebon slops
INSERT INTO `synth_recipes` VALUES (4017,0,0,0,0,95,0,0,0,0,0,4099,4241,1367,9130,0,0,0,0,0,0,26864,26865,26865,26865,1,1,1,1,'Bewitch. Dalmatica'); -- bewitched dalmatica
INSERT INTO `synth_recipes` VALUES (4018,0,0,0,0,95,0,0,0,0,0,4099,4241,9130,10249,0,0,0,0,0,0,25700,25701,25701,25701,1,1,1,1,'Vexed Bliaut'); -- vexed bliaut
INSERT INTO `synth_recipes` VALUES (4019,0,0,0,0,95,0,0,0,0,0,4098,4240,4016,4016,0,0,0,0,0,0,3948,3948,3948,3948,6,8,10,12,'Tulfaire Fltchg.'); -- tulfaire fletchings
INSERT INTO `synth_recipes` VALUES (4020,0,2011,0,0,95,0,0,0,0,0,4098,4240,2145,4016,4016,4016,4016,4016,4016,0,3948,3948,3948,3948,18,24,30,36,'Tulfaire Fltchg.'); -- tulfaire fletchings
INSERT INTO `synth_recipes` VALUES (4021,0,0,0,0,96,0,0,0,0,0,4099,4241,821,957,2856,13568,0,0,0,0,19240,19242,19242,19242,1,1,1,1,'Aumoniere'); -- aumoniere
INSERT INTO `synth_recipes` VALUES (4022,0,0,0,0,97,0,0,60,0,0,4099,4241,2275,2756,2825,2825,0,0,0,0,12141,12141,12141,12141,1,1,1,1,'Ebon Beret'); -- ebon beret
INSERT INTO `synth_recipes` VALUES (4023,0,0,0,0,99,0,0,60,0,0,4099,4241,821,8751,8751,8976,8988,0,0,0,27991,27992,27992,27992,1,1,1,1,'Revealers Mitts'); -- revealer's mitts
INSERT INTO `synth_recipes` VALUES (4024,0,0,60,0,100,0,0,60,0,0,4102,4244,760,822,829,1767,1769,2113,2476,0,11310,11311,11311,11311,1,1,1,1,'Argent Coat'); -- argent coat
INSERT INTO `synth_recipes` VALUES (4025,0,0,0,0,100,0,60,60,0,0,4099,4241,744,760,862,1279,2275,2756,2825,2825,12177,12177,12177,12177,1,1,1,1,'Ebon Frock'); -- ebon frock
INSERT INTO `synth_recipes` VALUES (4026,0,0,0,0,100,0,0,60,0,0,4099,4241,826,8751,8751,8976,8988,0,0,0,27228,27229,27229,27229,1,1,1,1,'Revealers Pants'); -- revealer's pants
INSERT INTO `synth_recipes` VALUES (4027,0,0,0,0,100,0,0,0,0,0,4098,4240,9147,9147,0,0,0,0,0,0,9172,9172,9172,9172,6,8,10,12,'Porxie Fletchings'); -- porxie fletchings
INSERT INTO `synth_recipes` VALUES (4028,0,2011,0,0,100,0,0,0,0,0,4098,4240,2145,9147,9147,9147,9147,9147,9147,0,9172,9172,9172,9172,18,24,30,36,'Porxie Fletchings'); -- porxie fletchings
INSERT INTO `synth_recipes` VALUES (4029,0,0,0,0,103,0,30,52,0,0,4099,4241,1828,2530,2876,3545,0,0,0,0,10307,10312,10312,10312,1,1,1,1,'Hexed Cuffs'); -- hexed cuffs
INSERT INTO `synth_recipes` VALUES (4030,0,0,0,0,105,0,49,0,0,0,4099,4241,828,837,2876,3544,0,0,0,0,10421,10426,10426,10426,1,1,1,1,'Hexed Bonnet'); -- hexed bonnet
INSERT INTO `synth_recipes` VALUES (4031,0,0,0,0,105,0,0,0,0,0,4099,4241,1409,8728,8728,9075,21393,0,0,0,21394,21395,21395,21395,1,1,1,1,'Sancus Sachet'); -- sancus sachet
INSERT INTO `synth_recipes` VALUES (4032,0,0,0,0,107,0,0,60,0,0,4099,4241,822,822,1828,2824,2875,3545,0,0,10587,10592,10592,10592,1,1,1,1,'Hexed Tights'); -- hexed tights
INSERT INTO `synth_recipes` VALUES (4033,0,0,0,0,108,0,30,50,0,0,4099,4241,823,2497,2876,3545,0,0,0,0,10423,10428,10428,10428,1,1,1,1,'Hexed Mitra'); -- hexed mitra
INSERT INTO `synth_recipes` VALUES (4034,0,0,0,0,109,0,0,60,0,0,4099,4241,823,828,837,1279,3544,3546,3548,0,10585,10590,10590,10590,1,1,1,1,'Hexed Kecks'); -- hexed kecks
INSERT INTO `synth_recipes` VALUES (4035,0,0,0,0,110,0,30,60,0,0,4099,4241,822,823,828,2497,2876,3545,3545,0,10244,10249,10249,10249,1,1,1,1,'Hexed Bliaut'); -- hexed bliaut
INSERT INTO `synth_recipes` VALUES (4036,0,0,0,0,112,0,70,0,0,0,4099,4241,1368,8722,8728,9130,0,0,0,0,27040,27041,27041,27041,1,1,1,1,'Bewitched Mitts'); -- bewitched mitts
INSERT INTO `synth_recipes` VALUES (4037,0,0,0,0,112,0,70,0,0,0,4099,4241,3981,8722,9130,10307,0,0,0,0,27131,27132,27132,27132,1,1,1,1,'Vexed Cuffs'); -- vexed cuffs
INSERT INTO `synth_recipes` VALUES (4038,0,0,0,0,113,0,70,0,0,0,4099,4241,1370,8722,8728,9130,0,0,0,0,27216,27217,27217,27217,1,1,1,1,'Bewitched Slacks'); -- bewitched slacks
INSERT INTO `synth_recipes` VALUES (4039,0,0,70,0,113,0,0,0,0,0,4099,4241,3981,8985,9130,10587,0,0,0,0,27316,27317,27317,27317,1,1,1,1,'Vexed Tights'); -- vexed tights
INSERT INTO `synth_recipes` VALUES (4040,0,0,0,0,113,0,0,70,0,0,4099,4241,4013,8988,9130,10585,0,0,0,0,27312,27313,27313,27313,1,1,1,1,'Vexed Kecks'); -- vexed kecks
INSERT INTO `synth_recipes` VALUES (4041,0,0,0,0,114,0,0,70,0,0,4099,4241,3981,8982,9130,10423,0,0,0,0,25627,25628,25628,25628,1,1,1,1,'Vexed Mitra'); -- vexed mitra
INSERT INTO `synth_recipes` VALUES (4042,0,0,0,0,114,0,70,0,0,0,4099,4241,4013,8722,9130,10421,0,0,0,0,25623,25624,25624,25624,1,1,1,1,'Vexed Bonnet'); -- vexed bonnet
INSERT INTO `synth_recipes` VALUES (4043,0,0,0,0,115,0,70,0,0,0,4099,4241,1366,8722,8728,9130,0,0,0,0,26864,26865,26865,26865,1,1,1,1,'Bewitch. Dalmatica'); -- bewitched dalmatica
INSERT INTO `synth_recipes` VALUES (4044,0,0,0,0,115,0,0,70,0,0,4099,4241,3981,8982,9130,10244,0,0,0,0,25700,25701,25701,25701,1,1,1,1,'Vexed Bliaut'); -- vexed bliaut
INSERT INTO `synth_recipes` VALUES (4045,0,0,0,0,118,0,0,0,0,0,4099,4241,1712,3544,9006,0,0,0,0,0,26335,26336,26336,26336,1,1,1,1,'Klouskap Sash'); -- klouskap sash
INSERT INTO `synth_recipes` VALUES (4046,0,0,0,0,0,2,0,0,0,0,4101,4243,4290,0,0,0,0,0,0,0,2397,2397,2397,2397,1,1,1,1,'Foulwth. Frog'); -- foulweather frog
INSERT INTO `synth_recipes` VALUES (4047,0,0,0,0,0,2,0,0,0,0,4101,4243,5465,0,0,0,0,0,0,0,2397,2397,2397,2397,1,1,1,1,'Foulwth. Frog'); -- foulweather frog
INSERT INTO `synth_recipes` VALUES (4048,0,0,0,0,0,5,0,0,0,0,4096,4238,8903,0,0,0,0,0,0,0,4455,4455,4455,4455,1,1,1,1,'Pebble Soup'); -- pebble soup (kit)
INSERT INTO `synth_recipes` VALUES (4049,0,0,0,0,0,8,0,0,0,0,4101,4243,4363,4370,0,0,0,0,0,0,2389,2389,2389,2389,1,1,1,1,'Speed Apple'); -- speed apple
INSERT INTO `synth_recipes` VALUES (4050,0,0,0,0,0,8,0,0,0,0,4101,4243,2273,4363,0,0,0,0,0,0,2391,2391,2391,2391,1,1,1,1,'Shadow Apple'); -- shadow apple
INSERT INTO `synth_recipes` VALUES (4051,0,0,0,0,0,10,0,0,0,0,4101,4243,8904,0,0,0,0,0,0,0,4422,4422,4422,4422,1,1,1,1,'Orange Juice'); -- orange juice (kit)
INSERT INTO `synth_recipes` VALUES (4052,0,0,0,0,0,10,0,0,0,0,4101,4243,17396,17397,0,0,0,0,0,0,17905,17905,17905,17905,4,6,8,10,'Wormy Broth'); -- wormy broth
INSERT INTO `synth_recipes` VALUES (4053,0,0,0,0,0,15,0,0,0,0,4098,4240,8905,0,0,0,0,0,0,0,16992,16992,16992,16992,1,1,1,1,'Slice Of Bluetail'); -- sliced bluetail (kit)
INSERT INTO `synth_recipes` VALUES (4054,0,0,0,0,0,15,0,0,0,0,4096,4238,619,627,633,2237,4387,4435,4570,5740,5885,5885,5885,5885,2,4,6,8,'Saltena'); -- saltena
INSERT INTO `synth_recipes` VALUES (4055,0,0,0,0,0,15,0,0,0,0,4096,4238,627,936,2237,4372,4390,4509,5688,5740,5889,5889,5889,5889,2,4,6,8,'Stuffed Pitaru'); -- stuffed pitaru
INSERT INTO `synth_recipes` VALUES (4056,0,0,0,0,0,16,0,0,0,0,4101,4243,3942,17397,0,0,0,0,0,0,17914,17914,17914,17914,4,6,8,12,'Wispy Broth'); -- wispy broth
INSERT INTO `synth_recipes` VALUES (4057,0,0,0,0,0,20,0,0,0,0,4101,4243,8906,0,0,0,0,0,0,0,4423,4423,4423,4423,1,1,1,1,'Apple Juice'); -- apple juice (kit)
INSERT INTO `synth_recipes` VALUES (4058,0,0,0,0,0,25,0,0,0,0,4096,4238,8907,0,0,0,0,0,0,0,4560,4560,4560,4560,1,1,1,1,'Vegetable Soup'); -- vegetable soup (kit)
INSERT INTO `synth_recipes` VALUES (4059,0,0,0,0,0,30,0,0,0,0,4101,4243,8908,0,0,0,0,0,0,0,4442,4442,4442,4442,1,1,1,1,'Pineapple Juice'); -- pineapple juice (kit)
INSERT INTO `synth_recipes` VALUES (4060,0,0,0,0,0,30,0,0,0,0,4096,4238,615,627,633,2237,4373,4447,4448,4570,5886,5886,5886,5886,2,4,6,8,'Elshena'); -- elshena
INSERT INTO `synth_recipes` VALUES (4061,0,0,0,0,0,30,0,0,0,0,4096,4238,627,633,936,2237,4435,4509,5568,5688,5890,5890,5890,5890,2,4,6,8,'Poultry Pitaru'); -- poultry pitaru
INSERT INTO `synth_recipes` VALUES (4062,0,0,0,0,0,32,0,0,0,0,4096,4238,610,615,626,4357,4370,4504,4504,4504,2392,2392,2392,2392,3,6,9,12,'Pepper Biscuit'); -- pepper biscuit
INSERT INTO `synth_recipes` VALUES (4063,0,0,0,0,0,32,0,0,0,0,4096,4238,610,612,615,4357,4370,4504,4504,4504,2393,2393,2393,2393,3,6,9,12,'Fire Biscuit'); -- fire biscuit
INSERT INTO `synth_recipes` VALUES (4064,0,0,0,0,0,33,0,0,0,0,4099,4241,611,4509,5461,0,0,0,0,0,16999,16999,16999,16999,12,12,12,12,'Trout Ball'); -- trout paste
INSERT INTO `synth_recipes` VALUES (4065,0,0,0,0,0,33,0,0,0,0,4101,4243,4389,4389,4389,17306,0,0,0,0,17878,17878,17878,17878,4,6,8,10,'L. Carrot Broth'); -- carrot broth
INSERT INTO `synth_recipes` VALUES (4066,0,0,0,0,0,35,0,0,0,0,4099,4241,8909,0,0,0,0,0,0,0,17000,17000,17000,17000,1,1,1,1,'Meatball'); -- meatball (kit)
INSERT INTO `synth_recipes` VALUES (4067,0,0,0,0,0,35,0,0,0,0,4096,4238,610,615,627,4570,5703,0,0,0,5766,5766,5767,5767,2,4,2,4,'Butter Crepe'); -- butter crepe
INSERT INTO `synth_recipes` VALUES (4068,0,0,0,0,0,37,0,0,0,0,4101,4243,4382,4571,4571,5235,0,0,0,0,17895,17895,17895,17895,4,6,8,10,'D. Herbal Broth'); -- dancing herbal broth
INSERT INTO `synth_recipes` VALUES (4069,0,0,0,0,0,38,0,0,0,0,4096,4238,3965,5233,5234,9193,9195,0,0,0,6466,6467,6467,6467,1,1,1,1,'Miso Soup'); -- miso soup
INSERT INTO `synth_recipes` VALUES (4070,0,0,0,0,0,40,0,0,0,0,4101,4243,8910,0,0,0,0,0,0,0,4424,4424,4424,4424,1,1,1,1,'Melon Juice'); -- melon juice (kit)
INSERT INTO `synth_recipes` VALUES (4071,0,0,0,0,0,40,0,0,0,0,4096,4238,614,622,1590,2561,5684,5747,8740,0,6211,6212,6212,6212,1,1,1,1,'Marinara Slice'); -- marinara slice
INSERT INTO `synth_recipes` VALUES (4072,0,0,0,0,0,40,0,0,0,0,4098,4240,5187,0,0,0,0,0,0,0,5976,5977,5977,5977,1,1,1,1,'Ulbuconut Milk'); -- ulbuconut milk
INSERT INTO `synth_recipes` VALUES (4073,0,0,0,0,0,40,0,0,0,0,4098,4240,5966,0,0,0,0,0,0,0,5976,5977,5977,5977,1,1,1,1,'Ulbuconut Milk'); -- ulbuconut milk
INSERT INTO `synth_recipes` VALUES (4074,0,0,0,0,0,41,0,0,0,0,4096,4238,612,1111,4358,4509,16995,0,0,0,17897,17897,17897,17897,4,6,8,10,'B. Carrion Broth'); -- bubbling carrion broth
INSERT INTO `synth_recipes` VALUES (4075,0,0,0,0,0,43,0,0,0,0,4098,4240,3915,3915,3915,0,0,0,0,0,3916,3916,3916,3916,1,2,3,4,'Saffron'); -- saffron
INSERT INTO `synth_recipes` VALUES (4076,0,0,0,0,0,45,0,0,0,0,4101,4243,16995,17395,17397,17397,0,0,0,0,17896,17896,17896,17896,4,6,8,10,'Gob. Bug Broth'); -- goblin bug broth
INSERT INTO `synth_recipes` VALUES (4077,0,0,0,0,0,45,0,0,0,0,4096,4238,8911,0,0,0,0,0,0,0,5586,5586,5586,5586,1,1,1,1,'Menemen'); -- menemen (kit)
INSERT INTO `synth_recipes` VALUES (4078,0,0,0,0,0,45,0,0,0,0,4099,4241,9099,9100,9101,9102,0,0,0,0,19326,19326,19326,19326,3,6,9,12,'Sea Dragon Liver'); -- sea dragon liver
INSERT INTO `synth_recipes` VALUES (4079,0,0,0,0,0,46,0,0,0,0,4096,4238,610,633,4296,4570,0,0,0,0,5756,5756,5762,5762,6,12,6,12,'Green Curry Bun'); -- green curry bun
INSERT INTO `synth_recipes` VALUES (4080,0,2041,0,0,0,46,0,0,0,0,4101,4243,610,936,2113,4509,0,0,0,0,9196,9196,9196,9196,1,1,1,1,'Ramen Noodles'); -- ramen noodles
INSERT INTO `synth_recipes` VALUES (4081,0,0,0,0,0,47,0,0,0,0,4096,4238,610,2503,4370,4468,4496,4570,5703,0,5775,5775,5776,5776,2,4,2,4,'Chocolate Crepe'); -- chocolate crepe
INSERT INTO `synth_recipes` VALUES (4082,0,0,0,0,0,49,0,0,0,0,4096,4238,612,617,633,4317,4358,4366,4388,4444,5143,5143,5143,5143,1,1,1,1,'Goblin Stir-fry'); -- goblin stir-fry
INSERT INTO `synth_recipes` VALUES (4083,0,0,0,0,0,50,0,0,0,0,4096,4238,8912,0,0,0,0,0,0,0,4413,4413,4413,4413,1,1,1,1,'Apple Pie'); -- apple pie (kit)
INSERT INTO `synth_recipes` VALUES (4084,0,0,0,0,0,50,0,0,0,0,4096,4238,1590,2561,4390,5194,5684,8740,0,0,6213,6213,6214,6214,6,8,6,8,'Margherita Slice'); -- slice of margherita pizza
INSERT INTO `synth_recipes` VALUES (4085,0,0,0,0,0,50,0,0,0,0,4096,4238,614,627,633,1695,2237,4570,5152,5651,5887,5887,5887,5887,2,4,6,8,'Montagna'); -- montagna
INSERT INTO `synth_recipes` VALUES (4086,0,0,0,0,0,50,0,0,0,0,4096,4238,627,936,2237,4387,4509,5688,5908,17394,5891,5891,5891,5891,2,4,6,8,'Seafood Pitaru'); -- seafood pitaru
INSERT INTO `synth_recipes` VALUES (4087,0,0,0,0,0,52,0,0,0,0,4101,4243,2645,4389,4483,4509,0,0,0,0,2568,2568,2568,2568,4,6,8,10,'Lthe. Consomme'); -- lethe consomme
INSERT INTO `synth_recipes` VALUES (4088,0,2042,0,0,0,54,0,0,0,0,4097,4239,627,1111,2112,4445,4570,5703,0,0,5745,5746,5746,5746,1,1,1,1,'Cherry Bavarois'); -- cherry bavarois
INSERT INTO `synth_recipes` VALUES (4089,0,0,0,0,0,57,0,0,0,0,4101,4243,924,930,2014,0,0,0,0,0,17879,17879,17879,17879,4,6,8,10,'C. Plasma Broth'); -- curdled plasma broth
INSERT INTO `synth_recipes` VALUES (4090,0,0,0,0,0,58,0,0,0,0,4101,4243,1111,4358,4372,4435,0,0,0,0,17874,17874,17874,17874,4,6,8,10,'Cng. Brain Broth'); -- cunning brain broth
INSERT INTO `synth_recipes` VALUES (4091,0,0,0,0,0,59,0,0,0,0,4096,4238,2561,5194,5195,5660,5680,5684,8740,0,6215,6215,6216,6216,6,8,6,8,'Pepperoni Slice'); -- slice of pepperoni pizza
INSERT INTO `synth_recipes` VALUES (4092,0,0,0,0,0,59,0,0,0,0,4096,4238,610,614,4390,4570,4578,5684,5703,0,5771,5771,5772,5772,2,4,2,4,'Ham & Ch. Crepe'); -- ham and cheese crepe
INSERT INTO `synth_recipes` VALUES (4093,0,0,0,0,0,60,0,0,0,0,4096,4238,626,3965,3965,4387,4509,5948,0,0,5998,5999,5999,5999,1,1,1,1,'Adoulinian Soup'); -- adoulinian soup
INSERT INTO `synth_recipes` VALUES (4094,0,0,0,0,0,60,0,0,0,0,4096,4238,610,615,936,4509,6394,0,0,0,6396,6396,6397,6397,3,6,3,6,'Cutlet Sandwich'); -- cutlet sandwich
INSERT INTO `synth_recipes` VALUES (4095,0,0,0,0,0,62,0,0,0,0,4101,4243,1981,1981,4366,4545,17396,17397,0,0,17898,17898,17898,17898,4,6,8,10,'C. Grass. Broth'); -- chirping grasshopper broth
INSERT INTO `synth_recipes` VALUES (4096,0,0,0,0,0,63,0,0,0,0,4101,4243,619,2645,4461,4509,0,0,0,0,2569,2569,2569,2569,4,6,8,10,'Lethe Potage'); -- lethe potage
INSERT INTO `synth_recipes` VALUES (4097,0,0,0,0,0,63,0,0,0,0,4101,4243,1111,4358,4372,5581,0,0,0,0,17875,17875,17875,17875,4,6,8,10,'Rzr. Brain Broth'); -- razor brain broth
INSERT INTO `synth_recipes` VALUES (4098,0,0,0,0,0,64,0,0,0,0,4096,4238,622,936,5993,0,0,0,0,0,4536,4326,4326,4326,1,1,1,1,'Blackened Frog'); -- blackened frog
INSERT INTO `synth_recipes` VALUES (4099,0,2040,0,0,0,64,0,0,0,0,4099,4241,620,1652,4509,5164,5961,5961,0,0,5693,5694,5694,5694,4,6,2,4,'Octopus Sushi'); -- octupus sushi
INSERT INTO `synth_recipes` VALUES (4100,0,2040,0,0,0,64,0,0,0,0,4099,4241,620,1652,4509,5164,5962,5962,5962,0,5693,5694,5694,5694,4,6,2,4,'Octopus Sushi'); -- octopus sushi
INSERT INTO `synth_recipes` VALUES (4101,0,0,0,0,0,64,0,0,0,0,4096,4238,610,633,4297,4570,0,0,0,0,5758,5758,5764,5764,6,8,6,8,'Black Curry Bun'); -- black curry bun
INSERT INTO `synth_recipes` VALUES (4102,0,0,0,0,0,65,0,0,0,0,4101,4243,1774,1984,1985,2016,17396,17396,0,0,17899,17899,17899,17899,4,6,8,10,'Svg. Mole Broth'); -- savage mole broth
INSERT INTO `synth_recipes` VALUES (4103,0,0,0,0,0,65,0,0,0,0,4096,4238,936,4509,5954,0,0,0,0,0,5980,5981,5981,5981,2,2,4,6,'Boiled Barnacles'); -- boiled barnacles
INSERT INTO `synth_recipes` VALUES (4104,0,0,0,0,0,67,0,0,0,0,4096,4238,631,898,900,924,936,4448,4509,16995,4465,4465,4465,4465,1,1,1,1,'Goblin Stew'); -- goblin stew
INSERT INTO `synth_recipes` VALUES (4105,0,0,0,0,0,68,0,0,0,0,4096,4238,622,1590,2561,5194,5652,5684,8740,0,6217,6217,6218,6218,6,8,6,8,'Anchovy Slice'); -- slice of anchovy pizza
INSERT INTO `synth_recipes` VALUES (4106,0,0,0,0,0,68,0,0,0,0,4101,4243,1111,4358,4372,5755,0,0,0,0,17901,17901,17901,17901,4,6,8,10,'B. Carrion Broth'); -- burning carrion broth
INSERT INTO `synth_recipes` VALUES (4107,0,0,0,0,0,69,0,0,0,0,4099,4241,610,4509,5152,5568,0,0,0,0,17022,17022,17022,17022,4,6,8,10,'Pet Food Eta'); -- pet food eta biscuit
INSERT INTO `synth_recipes` VALUES (4108,0,0,0,0,0,70,0,0,0,0,4101,4243,1111,4359,4362,4435,4570,0,0,0,17883,17883,17883,17883,4,6,8,10,'Mlw. Bird Broth'); -- mellow bird broth
INSERT INTO `synth_recipes` VALUES (4109,0,2041,0,0,0,71,0,0,0,0,4096,4238,614,633,936,1776,5123,5194,5448,5473,5719,5719,5720,5720,2,4,2,4,'Marinara'); -- spaghetti marinara
INSERT INTO `synth_recipes` VALUES (4110,0,2042,0,0,0,72,0,0,0,0,4096,4238,610,628,4352,4363,4370,4570,5703,0,5777,5777,5778,5778,2,4,2,4,'Pear Crepe'); -- pear crepe (requires patissier) http://ffxiclopedia.wikia.com/wiki/Patissier
INSERT INTO `synth_recipes` VALUES (4111,0,0,0,0,0,74,0,0,0,0,4096,4238,610,626,936,4366,4378,5755,0,0,5760,5761,5761,5761,1,1,1,1,'Kohlrouladen'); -- kohlrouladen
INSERT INTO `synth_recipes` VALUES (4112,0,0,0,0,0,75,0,0,0,0,4096,4238,627,633,2237,4570,5131,5473,5475,5703,5888,5888,5888,5888,2,4,6,8,'Maringna'); -- maringna
INSERT INTO `synth_recipes` VALUES (4113,0,0,0,0,0,75,0,0,0,0,4096,4238,627,936,2237,4409,4509,5196,5684,5907,5892,5892,5892,5892,2,4,6,8,'B.e.w. Pitaru'); -- b.e.w. pitaru
INSERT INTO `synth_recipes` VALUES (4114,0,0,0,0,0,78,0,0,0,0,4096,4238,610,1555,2237,4509,0,0,0,0,17900,17900,17900,17900,4,6,8,10,'Cl. Wheat Broth'); -- cloudy wheat broth
INSERT INTO `synth_recipes` VALUES (4115,0,0,0,0,0,79,0,0,0,0,4099,4241,610,4509,5569,5755,0,0,0,0,17023,17023,17023,17023,4,6,8,10,'Pet Food Theta'); -- pet food theta biscuit
INSERT INTO `synth_recipes` VALUES (4116,0,0,0,0,0,79,0,0,0,0,4096,4238,4399,4484,4484,5961,5963,0,0,0,5982,5982,5983,5983,6,12,6,12,'Senroh Skewer'); -- senroh skewer
INSERT INTO `synth_recipes` VALUES (4117,0,0,0,0,0,79,0,0,0,0,4096,4238,4399,4484,4484,5962,5962,5962,5963,0,5982,5982,5983,5983,6,12,6,12,'Senroh Skewer'); -- senroh skewer
INSERT INTO `synth_recipes` VALUES (4118,0,0,0,0,0,80,0,0,0,0,4096,4238,620,2111,4368,4387,4570,6394,0,0,6406,6407,6407,6407,1,1,1,1,'Pork Cutlet Bowl'); -- pork cutlet rice bowl
INSERT INTO `synth_recipes` VALUES (4119,0,0,0,0,0,81,0,0,0,0,4096,4238,627,1471,2215,4365,4365,4509,8800,0,6339,6340,6340,6340,2,2,3,4,'Rolan. Daifuku'); -- rolanberry daifuku
INSERT INTO `synth_recipes` VALUES (4120,0,0,0,0,0,81,0,0,0,0,4096,4238,618,627,1471,2215,4509,8800,0,0,6341,6342,6342,6342,2,2,3,4,'Bean Daifuku'); -- bean daifuku
INSERT INTO `synth_recipes` VALUES (4121,0,0,0,0,0,81,0,0,0,0,4096,4238,1471,2215,4509,0,0,0,0,0,6258,6259,6259,6259,2,2,3,4,'Shiromochi'); -- shiromochi
INSERT INTO `synth_recipes` VALUES (4122,0,0,0,0,0,83,0,0,0,0,4096,4238,610,626,4375,4448,4570,4571,5703,0,5773,5773,5774,5774,2,4,2,4,'Mushroom Crepe'); -- mushroom crepe
INSERT INTO `synth_recipes` VALUES (4123,0,0,0,0,0,90,0,0,0,0,4096,4238,633,4356,4570,5948,5948,0,0,0,6276,6276,6277,6277,6,8,6,8,'D.-fried Shrimp'); -- deep-fried shrimp
INSERT INTO `synth_recipes` VALUES (4124,0,0,0,0,0,90,0,0,0,0,4096,4238,633,4356,4435,4570,5569,0,0,0,6274,6274,6275,6275,6,8,6,8,'Pukatrice Egg'); -- pukatrice egg
INSERT INTO `synth_recipes` VALUES (4125,0,0,0,0,0,90,0,0,0,0,4096,4238,619,633,4356,4570,0,0,0,0,6272,6272,6273,6273,6,8,6,8,'Fried Popoto'); -- fried popoto
INSERT INTO `synth_recipes` VALUES (4126,0,2040,0,0,0,90,0,0,0,0,4099,4241,620,1652,4318,4379,4384,4480,4570,5164,6468,6468,6469,6469,4,6,2,4,'Sublime Sushi'); -- sublime sushi
INSERT INTO `synth_recipes` VALUES (4127,0,2040,0,0,0,90,0,0,0,0,4099,4241,620,1652,4318,4379,4384,4480,4570,9200,6468,6468,6469,6469,4,6,2,4,'Sublime Sushi'); -- sublime sushi
INSERT INTO `synth_recipes` VALUES (4128,0,2041,0,0,0,90,0,0,0,0,4096,4238,624,4483,4570,5234,6393,9196,9197,9201,6458,6459,6459,6459,4,4,6,8,'Soy Ramen'); -- soy ramen
INSERT INTO `synth_recipes` VALUES (4129,0,2041,0,0,0,90,0,0,0,0,4096,4238,615,629,4444,6393,9196,9198,9201,0,6460,6461,6461,6461,4,4,6,8,'Miso Ramen'); -- miso ramen
INSERT INTO `synth_recipes` VALUES (4130,0,2041,0,0,0,90,0,0,0,0,4096,4238,612,4360,4367,5948,9196,9199,9201,0,6462,6463,6463,6463,4,4,6,8,'Salt Ramen'); -- salt ramen
INSERT INTO `synth_recipes` VALUES (4131,0,0,0,0,0,92,0,0,0,0,4096,4238,614,620,3916,4387,4474,4509,5948,5949,5968,5969,5969,5969,1,1,1,1,'Seafood Paella'); -- seafood paella
INSERT INTO `synth_recipes` VALUES (4132,0,0,0,0,0,92,0,0,0,0,4096,4238,614,620,3916,4373,4375,4387,4450,4509,5970,5971,5971,5971,1,1,1,1,'Mushroom Paella'); -- mushroom paella
INSERT INTO `synth_recipes` VALUES (4133,0,0,0,0,0,92,0,0,0,0,4096,4238,614,620,3916,4387,4474,4509,5152,5949,5972,5973,5973,5973,1,1,1,1,'Beef Paella'); -- beef paella
INSERT INTO `synth_recipes` VALUES (4134,0,0,0,0,0,92,0,0,0,0,4096,4238,614,620,3916,4387,4509,5949,5954,5954,5974,5975,5975,5975,1,1,1,1,'Barnacle Paella'); -- barnacle paella
INSERT INTO `synth_recipes` VALUES (4135,0,0,0,0,0,94,0,0,0,0,4096,4238,627,627,1111,4431,4509,5964,5964,0,5978,5979,5979,5979,1,1,1,1,'Felicifruit Gelatin'); -- felicifruit gelatin
INSERT INTO `synth_recipes` VALUES (4136,0,0,0,0,0,95,0,0,0,0,4101,4243,4389,4389,4389,5967,0,0,0,0,17907,17915,17915,17915,4,2,4,8,'Swirling Broth'); -- swirling broth
INSERT INTO `synth_recipes` VALUES (4137,0,0,0,0,0,96,0,0,0,0,4101,4243,5952,5952,5952,5952,0,0,0,0,17908,17916,17916,17916,4,2,4,8,'Shimmering Broth'); -- shimmering broth
INSERT INTO `synth_recipes` VALUES (4138,0,0,0,0,0,0,5,0,0,0,4096,4238,8833,0,0,0,0,0,0,0,13454,13454,13454,13454,1,1,1,1,'Copper Ring'); -- copper ring (kit)
INSERT INTO `synth_recipes` VALUES (4139,0,0,0,0,0,0,10,0,0,0,4096,4238,8834,0,0,0,0,0,0,0,650,650,650,650,1,1,1,1,'Brass Ingot'); -- brass ingot (kit)
INSERT INTO `synth_recipes` VALUES (4140,0,0,0,0,0,0,15,0,0,0,4096,4238,8835,0,0,0,0,0,0,0,16769,16769,16769,16769,1,1,1,1,'Brass Zaghnal'); -- brass zaghnal (kit)
INSERT INTO `synth_recipes` VALUES (4141,0,0,0,0,0,0,20,0,0,0,4096,4238,8836,0,0,0,0,0,0,0,744,744,744,744,1,1,1,1,'Silver Ingot'); -- silver ingot (kit)
INSERT INTO `synth_recipes` VALUES (4142,0,0,0,0,0,0,20,0,0,0,4096,4238,651,651,745,1886,0,0,0,0,3700,3700,3700,3700,1,1,1,1,'Shower Stand'); -- shower stand
INSERT INTO `synth_recipes` VALUES (4143,0,0,0,0,0,0,25,0,0,0,4099,4241,8837,0,0,0,0,0,0,0,13196,13196,13196,13196,1,1,1,1,'Silver Belt'); -- silver belt (kit)
INSERT INTO `synth_recipes` VALUES (4144,0,0,0,0,0,0,30,0,0,0,4099,4241,8838,0,0,0,0,0,0,0,12689,12689,12689,12689,1,1,1,1,'Brass Fng. Gnt.'); -- brass finger gauntlets (kit)
INSERT INTO `synth_recipes` VALUES (4145,0,0,0,0,0,0,31,0,0,6,4096,4238,650,706,0,0,0,0,0,0,18868,18869,18869,18869,1,1,1,1,'Lady Bell'); -- lady bell
INSERT INTO `synth_recipes` VALUES (4146,0,0,0,0,0,0,35,0,0,0,4099,4241,8839,0,0,0,0,0,0,0,15801,15801,15801,15801,1,1,1,1,'Tigereye Ring'); -- tigereye ring (kit)
INSERT INTO `synth_recipes` VALUES (4147,0,0,0,0,0,0,36,0,0,0,4099,4241,760,760,760,2841,0,0,0,0,15939,15947,15947,15947,1,1,1,1,'Griot Belt'); -- griot belt
INSERT INTO `synth_recipes` VALUES (4148,0,0,0,0,0,0,39,0,0,0,4099,4241,760,760,2842,0,0,0,0,0,16301,16304,16304,16304,1,1,1,1,'Focus Collar'); -- focus collar
INSERT INTO `synth_recipes` VALUES (4149,0,0,0,0,0,0,40,0,0,0,4096,4238,8840,0,0,0,0,0,0,0,653,653,653,653,1,1,1,1,'Mythril Ingot'); -- mythril ingot (kit)
INSERT INTO `synth_recipes` VALUES (4150,0,0,0,0,0,0,43,0,0,0,4096,4238,2844,16641,0,0,0,0,0,0,17968,18531,18531,18531,1,1,1,1,'Veldt Axe'); -- veldt axe
INSERT INTO `synth_recipes` VALUES (4151,0,0,0,0,0,0,45,0,0,0,4099,4241,8841,0,0,0,0,0,0,0,13319,13319,13319,13319,1,1,1,1,'Peridot Earring'); -- peridot earring (kit)
INSERT INTO `synth_recipes` VALUES (4152,0,0,0,0,0,0,50,0,0,0,4096,4238,8842,0,0,0,0,0,0,0,670,670,670,670,1,1,1,1,'Aluminum Sheet'); -- aluminum sheet (kit)
INSERT INTO `synth_recipes` VALUES (4153,0,2002,11,0,0,0,52,0,0,0,4099,4241,933,1109,1109,2360,2419,0,0,0,9036,9036,9036,9036,12,12,12,12,'Scope Ii'); -- scope ii
INSERT INTO `synth_recipes` VALUES (4154,0,1994,0,0,0,0,53,0,0,0,4098,4240,745,745,2143,0,0,0,0,0,9052,9052,9052,9052,3,6,9,12,'Golden Coil'); -- golden coil
INSERT INTO `synth_recipes` VALUES (4155,0,2002,26,0,0,0,53,0,0,0,4096,4238,667,1520,2300,13683,18232,0,0,0,9070,9070,9070,9070,12,12,12,12,'Resister'); -- resister
INSERT INTO `synth_recipes` VALUES (4156,0,0,5,0,0,0,54,0,0,0,4096,4238,650,650,650,745,913,0,0,0,459,459,459,459,1,1,1,1,'Candle Holder'); -- candle holder
INSERT INTO `synth_recipes` VALUES (4157,0,2002,27,0,0,0,55,0,0,0,4096,4238,637,933,2308,2311,0,0,0,0,9068,9068,9068,9068,12,12,12,12,'Barrier Module'); -- barrier module
INSERT INTO `synth_recipes` VALUES (4158,0,0,0,0,0,0,55,0,0,0,4099,4241,8843,0,0,0,0,0,0,0,12307,12307,12307,12307,1,1,1,1,'Heater Shield'); -- heater shield (kit)
INSERT INTO `synth_recipes` VALUES (4159,0,1994,0,0,0,0,57,0,0,0,4099,4241,653,653,2853,0,0,0,0,0,19046,19047,19047,19047,1,1,1,1,'Reaver Grip'); -- reaver grip
INSERT INTO `synth_recipes` VALUES (4160,0,2002,28,0,0,0,57,0,28,0,4096,4238,665,932,1630,2000,2290,0,0,0,9038,9038,9038,9038,12,12,12,12,'Shock Absorber Ii'); -- shock absorber ii
INSERT INTO `synth_recipes` VALUES (4161,0,2002,28,0,0,0,57,0,0,0,4099,4241,933,1109,1109,2419,9053,0,0,0,9137,9137,9137,9137,12,12,12,12,'Scope Iii'); -- scope iii
INSERT INTO `synth_recipes` VALUES (4162,0,2002,29,0,0,0,58,0,0,0,4096,4238,667,1520,2300,13683,18233,0,0,0,9071,9071,9071,9071,12,12,12,12,'Resister Ii'); -- resister_ii
INSERT INTO `synth_recipes` VALUES (4163,0,0,0,0,0,0,60,0,0,0,4098,4240,3924,0,0,0,0,0,0,0,791,794,794,3925,1,1,1,1,'Aquamarine'); -- aquamarine
INSERT INTO `synth_recipes` VALUES (4164,0,0,0,0,0,0,60,0,0,0,4096,4238,8844,0,0,0,0,0,0,0,12801,12801,12801,12801,1,1,1,1,'Mythril Cuisses'); -- mythril cuisses (kit)
INSERT INTO `synth_recipes` VALUES (4165,0,0,0,0,0,0,63,0,45,31,4096,4238,652,654,719,746,914,2766,0,0,18765,18765,18765,18765,1,1,1,1,'Oberons Sainti'); -- oberon's sainti
INSERT INTO `synth_recipes` VALUES (4166,0,0,0,0,0,0,63,0,53,31,4096,4238,654,717,2749,2749,2766,0,0,0,18764,18764,18764,18764,1,1,1,1,'Oberons Knuckles'); -- oberon's knuckles
INSERT INTO `synth_recipes` VALUES (4167,1,0,0,0,0,0,63,0,0,0,4098,4240,4057,0,0,0,0,0,0,0,809,808,805,780,1,1,1,1,'Clear Topaz'); -- gellid aggregate desynth
INSERT INTO `synth_recipes` VALUES (4168,0,1994,0,0,0,0,64,0,0,0,4096,4238,746,754,0,0,0,0,0,0,9053,9053,9053,9053,1,2,3,4,'Platinum Gear'); -- platinum gear
INSERT INTO `synth_recipes` VALUES (4169,0,0,0,0,0,0,65,0,0,0,4096,4238,8845,0,0,0,0,0,0,0,13350,13350,13350,13350,1,1,1,1,'Moon Earring'); -- moon earring (kit)
INSERT INTO `synth_recipes` VALUES (4170,0,0,10,0,0,0,66,0,0,0,4096,4238,745,745,913,913,0,0,0,0,425,425,425,425,1,1,1,1,'Girandola'); -- girandola
INSERT INTO `synth_recipes` VALUES (4171,0,2002,33,0,0,0,66,0,0,0,4096,4238,754,933,1887,13688,18234,0,0,0,9044,9044,9044,9044,12,12,12,12,'Auto-rep. Kit Iii'); -- auto-repair kit iii
INSERT INTO `synth_recipes` VALUES (4172,0,2002,0,0,0,0,66,0,0,0,4099,4241,637,654,2308,2308,9053,0,0,0,9033,9033,9033,9033,12,12,12,12,'Ten. Spring Iii'); -- tension spring iii
INSERT INTO `synth_recipes` VALUES (4173,0,0,0,0,0,0,68,0,28,0,4096,4238,652,652,810,914,2766,0,0,0,17761,17761,17761,17761,1,1,1,1,'Oberons Rapier'); -- oberon's rapier
INSERT INTO `synth_recipes` VALUES (4174,0,0,0,0,0,0,69,0,0,0,4096,4238,737,737,737,2765,0,0,0,0,2766,2766,2766,2766,1,1,1,1,'Oberons Gold'); -- oberon's gold ingot
INSERT INTO `synth_recipes` VALUES (4175,0,2002,0,0,0,0,69,0,0,0,4096,4238,668,747,0,0,0,0,0,0,9145,9145,9145,9145,1,2,3,4,'Ocl. Gearbox'); -- orichalcum gearbox
INSERT INTO `synth_recipes` VALUES (4176,0,0,0,0,0,0,70,0,0,0,4096,4238,2766,0,0,0,0,0,0,0,2767,2767,2767,2767,1,1,1,1,'Ob. Gold Sheet'); -- oberon's gold sheet
INSERT INTO `synth_recipes` VALUES (4177,0,2002,0,0,0,0,70,0,0,0,4096,4238,754,1641,9052,9052,9145,0,0,0,9132,9132,9132,9132,12,12,12,12,'Heat Capacitor Ii'); -- heat capacitor ii
INSERT INTO `synth_recipes` VALUES (4178,0,0,0,0,0,0,70,0,0,0,4096,4238,8846,0,0,0,0,0,0,0,13983,13983,13983,13983,1,1,1,1,'Gold Bangles'); -- gold bangles (kit)
INSERT INTO `synth_recipes` VALUES (4179,0,0,0,0,0,0,71,0,0,0,4099,4241,2840,13447,0,0,0,0,0,0,15849,15855,15855,15855,1,1,1,1,'Krousis Ring'); -- krousis ring
INSERT INTO `synth_recipes` VALUES (4180,0,2002,35,0,0,0,71,0,0,0,4096,4238,914,1886,1887,13689,18234,0,0,0,9045,9045,9045,9045,12,12,12,12,'Mana Tank Iii'); -- mana tank iii
INSERT INTO `synth_recipes` VALUES (4181,0,2002,0,0,0,0,71,0,0,0,4099,4241,637,654,2308,2308,9145,0,0,0,8460,8460,8460,8460,12,12,12,12,'Tension Spring Iv'); -- tension spring iv
INSERT INTO `synth_recipes` VALUES (4182,0,2002,35,0,0,0,71,0,0,0,4096,4238,668,933,1887,13688,18233,18234,0,0,8653,8653,8653,8653,12,12,12,12,'Auto-repair Kit Iv'); -- auto-repair kit iv
INSERT INTO `synth_recipes` VALUES (4183,0,0,0,0,0,0,72,0,0,0,4098,4240,3921,0,0,0,0,0,0,0,773,773,773,1836,1,1,1,1,'Translucent Rock'); -- translucent rock
INSERT INTO `synth_recipes` VALUES (4184,0,2002,37,0,0,0,73,0,0,0,4096,4238,927,1520,2290,9053,18238,0,0,0,8522,8522,8522,8522,12,12,12,12,'Accelerator Iii'); -- accelerator iii
INSERT INTO `synth_recipes` VALUES (4185,0,2002,37,0,0,0,74,0,0,0,4096,4238,667,1109,1886,13683,18234,0,0,0,8617,8617,8617,8617,12,12,12,12,'Mana Jammer Iii'); -- mana jammer iii
INSERT INTO `synth_recipes` VALUES (4186,0,0,0,0,0,0,75,0,0,0,4096,4238,9494,0,0,0,0,0,0,0,16962,16962,16962,16962,1,1,1,1,'Ashura'); -- ashura (kit)
INSERT INTO `synth_recipes` VALUES (4187,0,2002,38,0,0,0,76,0,0,0,4096,4238,914,1886,1887,13689,18233,18234,0,0,8683,8683,8683,8683,12,12,12,12,'Mana Tank Iv'); -- mana tank iv
INSERT INTO `synth_recipes` VALUES (4188,0,2002,39,0,0,0,78,0,0,0,4096,4238,927,1520,2290,9145,18237,18238,0,0,8525,8525,8525,8525,12,12,12,12,'Accelerator Iv'); -- accelerator iv
INSERT INTO `synth_recipes` VALUES (4189,0,2002,39,0,0,0,79,0,0,0,4096,4238,667,1109,1886,13683,18233,18234,0,0,8621,8621,8621,8621,12,12,12,12,'Mana Jammer Iv'); -- mana jammer iv
INSERT INTO `synth_recipes` VALUES (4190,0,0,0,0,0,0,80,0,0,0,4096,4238,9495,0,0,0,0,0,0,0,12303,12303,12303,12303,1,1,1,1,'Gold Buckler'); -- gold buckler (kit)
INSERT INTO `synth_recipes` VALUES (4191,0,0,0,0,0,0,81,0,0,0,4096,4238,740,740,740,740,0,0,0,0,743,743,743,743,1,1,1,1,'Ph. Gold Ingot'); -- phrygian gold ingot
INSERT INTO `synth_recipes` VALUES (4192,0,0,15,0,0,0,82,0,0,0,4096,4238,650,745,745,745,913,913,913,0,450,450,450,450,1,1,1,1,'Candelabrum'); -- candelabrum
INSERT INTO `synth_recipes` VALUES (4193,0,0,0,0,0,0,82,0,0,0,4096,4238,743,0,0,0,0,0,0,0,753,753,753,753,1,1,1,1,'Ph. Gold Sheet'); -- phrygian gold sheet
INSERT INTO `synth_recipes` VALUES (4194,0,1995,0,0,0,0,82,0,0,0,4096,4238,743,743,743,743,743,743,2144,0,753,753,753,753,6,6,6,6,'Ph. Gold Sheet'); -- phrygian gold sheet (sheeting)
INSERT INTO `synth_recipes` VALUES (4195,0,0,0,0,0,0,85,0,0,0,4098,4240,800,929,1134,1836,0,0,0,0,348,348,348,348,1,1,1,1,'Marble Plaque'); -- marble plaque
INSERT INTO `synth_recipes` VALUES (4196,0,0,0,0,0,0,85,0,0,0,4096,4238,9496,0,0,0,0,0,0,0,13985,13985,13985,13985,1,1,1,1,'Platinum Bangles'); -- platinum bangles (kit)
INSERT INTO `synth_recipes` VALUES (4197,0,0,0,0,0,0,90,0,0,0,4096,4238,9497,0,0,0,0,0,0,0,13087,13087,13087,13087,1,1,1,1,'Jeweled Collar'); -- jeweled collar (kit)
INSERT INTO `synth_recipes` VALUES (4198,0,0,0,0,0,0,91,0,0,0,4096,4238,1383,9130,0,0,0,0,0,0,27386,27387,27387,27387,1,1,1,1,'Bewitched Schuhs'); -- bewitched schuhs
INSERT INTO `synth_recipes` VALUES (4199,0,0,0,0,0,0,91,0,0,0,4099,4241,9130,10358,0,0,0,0,0,0,27479,27480,27480,27480,1,1,1,1,'Vexed Gambieras'); -- vexed gambieras
INSERT INTO `synth_recipes` VALUES (4200,0,0,0,0,0,0,92,0,0,0,4098,4240,743,743,0,0,0,0,0,0,11725,11726,11726,11726,1,1,1,1,'Phrygian Earring'); -- phrygian earring
INSERT INTO `synth_recipes` VALUES (4201,0,0,0,0,0,0,92,0,0,0,4096,4238,1379,9130,0,0,0,0,0,0,27034,27035,27035,27035,1,1,1,1,'Bewit. Handschuhs'); -- bewitched handschuhs
INSERT INTO `synth_recipes` VALUES (4202,0,0,0,0,0,0,92,0,0,0,4099,4241,9130,10308,0,0,0,0,0,0,27123,27124,27124,27124,1,1,1,1,'Vexed Gauntlets'); -- vexed gauntlets
INSERT INTO `synth_recipes` VALUES (4203,0,0,0,0,0,0,93,0,0,0,4096,4238,1381,9130,0,0,0,0,0,0,27210,27211,27211,27211,1,1,1,1,'Bewitch. Diechlings'); -- bewitched diechlings
INSERT INTO `synth_recipes` VALUES (4204,0,0,0,0,0,0,94,46,0,0,4096,4238,879,2850,18405,0,0,0,0,0,18873,18874,18874,18874,1,1,1,1,'Brise-os'); -- brise-os
INSERT INTO `synth_recipes` VALUES (4205,0,0,0,0,0,0,94,0,0,0,4096,4238,743,743,0,0,0,0,0,0,11664,11665,11665,11665,1,1,1,1,'Phrygian Ring'); -- phrygian ring
INSERT INTO `synth_recipes` VALUES (4206,0,0,0,0,0,0,94,0,0,0,4096,4238,1365,9130,0,0,0,0,0,0,26688,26689,26689,26689,1,1,1,1,'Bewitched Crown'); -- bewitched crown
INSERT INTO `synth_recipes` VALUES (4207,0,0,0,0,0,0,94,0,0,0,4096,4238,1375,9130,0,0,0,0,0,0,26682,26683,26683,26683,1,1,1,1,'Bewitched Schaller'); -- bewitched schaller
INSERT INTO `synth_recipes` VALUES (4208,0,0,0,0,0,0,94,0,0,0,4099,4241,9130,10424,0,0,0,0,0,0,25619,25620,25620,25620,1,1,1,1,'Vexed Coronet'); -- vexed coronet
INSERT INTO `synth_recipes` VALUES (4209,0,0,0,0,0,0,94,0,0,0,4096,4238,9498,0,0,0,0,0,0,0,11664,11664,11664,11664,1,1,1,1,'Phrygian Ring'); -- phrygian ring (kit)
INSERT INTO `synth_recipes` VALUES (4210,0,0,0,0,0,0,95,0,0,0,4096,4238,4024,0,0,0,0,0,0,0,4025,4025,4025,4025,1,1,1,1,'Snowsteel Sheet'); -- snowsteel sheet
INSERT INTO `synth_recipes` VALUES (4211,0,1995,0,0,0,0,95,0,0,0,4096,4238,2144,4024,4024,4024,4024,4024,4024,0,4025,4025,4025,4025,6,6,6,6,'Snowsteel Sheet'); -- snowsteel sheet (sheeting)
INSERT INTO `synth_recipes` VALUES (4212,0,0,0,0,0,0,95,0,0,0,4096,4238,1377,9130,0,0,0,0,0,0,26858,26859,26859,26859,1,1,1,1,'Bewitched Cuirass'); -- bewitched cuirass
INSERT INTO `synth_recipes` VALUES (4213,0,0,0,0,0,0,95,0,0,0,4099,4241,9130,10245,0,0,0,0,0,0,25692,25693,25693,25693,1,1,1,1,'Vexed Haubert'); -- vexed haubert
INSERT INTO `synth_recipes` VALUES (4214,0,0,0,0,0,0,96,0,48,48,4096,4238,652,654,914,3923,3923,3927,0,0,20551,20552,20552,20552,1,1,1,1,'Akua Sainti'); -- akua sainti
INSERT INTO `synth_recipes` VALUES (4215,0,0,0,0,0,0,105,0,60,0,4096,4238,655,786,3923,4028,0,0,0,0,21812,21813,21813,21813,1,1,1,1,'Arasy Scythe'); -- arasy scythe
INSERT INTO `synth_recipes` VALUES (4216,0,0,0,0,0,0,105,0,0,0,4096,4238,644,644,644,8721,0,0,0,0,8722,8722,8722,8722,1,1,1,1,'Hepatizon Ingot'); -- hepatizon ingot
INSERT INTO `synth_recipes` VALUES (4217,0,1994,0,0,0,0,105,0,0,0,4096,4238,2143,3923,3977,0,0,0,0,0,22204,22205,22205,22205,1,1,1,1,'Nepenthe Grip'); -- nepenthe grip
INSERT INTO `synth_recipes` VALUES (4218,0,1994,0,0,0,0,105,0,0,0,4096,4238,2143,3923,4013,0,0,0,0,0,22206,22207,22207,22207,1,1,1,1,'Gracile Grip'); -- gracile grip
INSERT INTO `synth_recipes` VALUES (4219,0,0,0,0,0,0,107,40,0,0,4096,4238,766,1445,2170,2418,2419,0,0,0,10419,10424,10424,10424,1,1,1,1,'Hexed Coronet'); -- hexed coronet
INSERT INTO `synth_recipes` VALUES (4220,0,0,0,0,0,0,108,39,0,0,4096,4238,766,2418,2570,14010,0,0,0,0,10303,10308,10308,10308,1,1,1,1,'Hexed Gauntlets'); -- hexed gauntlets
INSERT INTO `synth_recipes` VALUES (4221,0,0,0,0,30,0,110,0,0,0,4096,4238,766,766,766,1445,1700,2418,14382,0,10240,10245,10245,10245,1,1,1,1,'Hexed Haubert'); -- hexed haubert (110 gold 30 cloth) https://www.bg-wiki.com/bg/Hexed_Haubert
INSERT INTO `synth_recipes` VALUES (4222,0,0,70,0,0,0,111,0,0,0,4096,4238,1382,9004,9029,9130,0,0,0,0,27386,27387,27387,27387,1,1,1,1,'Bewitched Schuhs'); -- bewitched schuhs
INSERT INTO `synth_recipes` VALUES (4223,0,0,0,0,0,0,111,70,0,0,4099,4241,8722,9047,9130,10353,0,0,0,0,27479,27480,27480,27480,1,1,1,1,'Vexed Gambieras'); -- vexed gambieras
INSERT INTO `synth_recipes` VALUES (4224,0,0,70,0,0,0,112,0,0,0,4096,4238,1378,9004,9029,9130,0,0,0,0,27034,27035,27035,27035,1,1,1,1,'Bewit. Handschuhs'); -- bewitched handschuhs
INSERT INTO `synth_recipes` VALUES (4225,0,0,0,0,0,0,112,70,0,0,4099,4241,8722,9047,9130,10303,0,0,0,0,27123,27124,27124,27124,1,1,1,1,'Vexed Gauntlets'); -- vexed gauntlets
INSERT INTO `synth_recipes` VALUES (4226,0,0,70,0,0,0,113,0,0,0,4096,4238,1380,9004,9029,9130,0,0,0,0,27210,27211,27211,27211,1,1,1,1,'Bewitch. Diechlings'); -- bewitched diechlings
INSERT INTO `synth_recipes` VALUES (4227,0,0,70,0,0,0,114,0,0,0,4096,4238,1364,8722,8728,9130,0,0,0,0,26688,26689,26689,26689,1,1,1,1,'Bewitched Crown'); -- bewitched crown
INSERT INTO `synth_recipes` VALUES (4228,0,0,70,0,0,0,114,0,0,0,4096,4238,1374,9004,9029,9130,0,0,0,0,26682,26683,26683,26683,1,1,1,1,'Bewitched Schaller'); -- bewitched schaller
INSERT INTO `synth_recipes` VALUES (4229,0,0,0,0,0,0,114,70,0,0,4099,4241,8722,9047,9130,10419,0,0,0,0,25619,25620,25620,25620,1,1,1,1,'Vexed Coronet'); -- vexed coronet
INSERT INTO `synth_recipes` VALUES (4230,0,0,0,0,0,0,115,0,0,0,4096,4238,1460,9062,9062,9064,9064,0,0,0,26183,26184,26184,26184,1,1,1,1,'Stikini Ring'); -- stikini ring
INSERT INTO `synth_recipes` VALUES (4231,0,0,70,0,0,0,115,0,0,0,4096,4238,1376,9004,9029,9130,0,0,0,0,26858,26859,26859,26859,1,1,1,1,'Bewitched Cuirass'); -- bewitched cuirass
INSERT INTO `synth_recipes` VALUES (4232,0,0,0,0,0,0,115,70,0,0,4099,4241,8722,9047,9130,10240,0,0,0,0,25692,25693,25693,25693,1,1,1,1,'Vexed Haubert'); -- vexed haubert
INSERT INTO `synth_recipes` VALUES (4233,0,0,0,0,0,0,118,0,0,0,4096,4238,3323,8722,9063,0,0,0,0,0,26080,26081,26081,26081,1,1,1,1,'Mache Earring'); -- mache earring
INSERT INTO `synth_recipes` VALUES (4234,0,0,0,0,0,0,0,5,0,0,4098,4240,8861,0,0,0,0,0,0,0,12440,12440,12440,12440,1,1,1,1,'Leather Bandana'); -- leather bandana (kit)
INSERT INTO `synth_recipes` VALUES (4235,0,0,0,0,0,0,0,10,0,0,4099,4241,8862,0,0,0,0,0,0,0,12568,12568,12568,12568,1,1,1,1,'Leather Vest'); -- leather vest (kit)
INSERT INTO `synth_recipes` VALUES (4236,0,0,0,0,0,0,0,15,0,0,4099,4241,8863,0,0,0,0,0,0,0,12441,12441,12441,12441,1,1,1,1,'Lizard Helm'); -- lizard helm (kit)
INSERT INTO `synth_recipes` VALUES (4237,0,0,0,0,0,0,0,20,0,0,4099,4241,8864,0,0,0,0,0,0,0,14171,14171,14171,14171,1,1,1,1,'Fishermans Boots'); -- fisherman's boots (kit)
INSERT INTO `synth_recipes` VALUES (4238,0,0,0,0,0,0,0,25,0,0,4098,4240,8865,0,0,0,0,0,0,0,13194,13194,13194,13194,1,1,1,1,'Warriors Belt'); -- warrior's belt (kit)
INSERT INTO `synth_recipes` VALUES (4239,0,0,0,0,0,0,0,30,0,0,4099,4241,8866,0,0,0,0,0,0,0,12826,12826,12826,12826,1,1,1,1,'Studded Trousers'); -- studded trousers (kit)
INSERT INTO `synth_recipes` VALUES (4240,0,0,0,0,0,0,0,35,0,0,4103,4245,8867,0,0,0,0,0,0,0,851,851,851,851,1,1,1,1,'Ram Leather'); -- ram leather (kit)
INSERT INTO `synth_recipes` VALUES (4241,0,0,0,0,0,0,0,40,0,0,4099,4241,8868,0,0,0,0,0,0,0,14176,14176,14176,14176,1,1,1,1,'Field Boots'); -- field boots (kit)
INSERT INTO `synth_recipes` VALUES (4242,0,0,0,0,0,0,0,45,0,0,4101,4243,8869,0,0,0,0,0,0,0,12827,12827,12827,12827,1,1,1,1,'Cuir Trousers'); -- cuir trousers (kit)
INSERT INTO `synth_recipes` VALUES (4243,0,0,0,0,0,0,0,50,0,0,4099,4241,8870,0,0,0,0,0,0,0,12294,12294,12294,12294,1,1,1,1,'Leather Shield'); -- leather shield (kit)
INSERT INTO `synth_recipes` VALUES (4244,0,0,0,0,0,0,0,17,0,0,4099,4241,817,852,2834,0,0,0,0,0,11530,11539,11539,11539,1,1,1,1,'Exactitude Mantle'); -- exactitude mantle
INSERT INTO `synth_recipes` VALUES (4245,0,2016,0,0,0,0,0,24,0,0,4103,4245,695,1640,1645,1645,1647,4509,0,0,1971,1971,1971,1971,1,1,1,1,'S. Bgd. Leather'); -- soft bugard leather
INSERT INTO `synth_recipes` VALUES (4246,0,2016,0,0,0,0,0,61,0,0,4103,4245,635,1644,1644,1648,2518,4509,0,0,2733,2733,2733,2733,1,1,1,1,'S. Smil. Leather'); -- spirit smilodon leather
INSERT INTO `synth_recipes` VALUES (4247,0,2016,0,0,0,0,0,61,0,0,4103,4245,695,1644,1644,1648,2518,4509,0,0,2733,2733,2733,2733,1,1,1,1,'S. Smil. Leather'); -- spirit smilodon leather
INSERT INTO `synth_recipes` VALUES (4248,0,0,0,0,0,0,0,62,0,0,4098,4240,2529,0,0,0,0,0,0,0,15836,15837,15837,15837,1,1,1,1,'Smilodon Ring'); -- smilodon ring
INSERT INTO `synth_recipes` VALUES (4249,0,0,0,0,0,0,0,64,0,0,4098,4240,851,914,915,5350,0,0,0,0,15933,15933,15933,15933,1,1,1,1,'Stirge Belt'); -- stirge belt
INSERT INTO `synth_recipes` VALUES (4250,0,0,0,0,0,0,0,65,0,0,4099,4241,2733,15836,0,0,0,0,0,0,15838,15838,15838,15838,1,1,1,1,'Protect Ring'); -- protect ring
INSERT INTO `synth_recipes` VALUES (4251,0,0,0,0,0,0,0,69,0,0,4098,4240,790,1629,0,0,0,0,0,0,2737,2737,2737,2737,1,1,1,1,'Silky Suede'); -- silky suede
INSERT INTO `synth_recipes` VALUES (4252,0,0,0,0,0,0,0,78,0,0,4099,4241,862,1163,0,0,0,0,0,0,10961,10962,10962,10962,1,1,1,1,'Lavalier'); -- lavalier
INSERT INTO `synth_recipes` VALUES (4253,0,0,0,0,0,0,0,79,0,0,4099,4241,2839,13700,0,0,0,0,0,0,15055,15059,15059,15059,1,1,1,1,'Finesse Gloves'); -- finesse gloves
INSERT INTO `synth_recipes` VALUES (4254,0,0,0,0,0,0,0,80,34,0,4099,4241,664,848,855,862,2828,12553,0,0,11344,11350,11350,11350,1,1,1,1,'Styrne Byrnie'); -- styrne byrnie
INSERT INTO `synth_recipes` VALUES (4255,0,0,0,0,0,0,0,81,0,0,4103,4245,635,2523,4509,0,0,0,0,0,2538,2538,2538,2538,1,1,1,1,'Peiste Leather'); -- peiste leather
INSERT INTO `synth_recipes` VALUES (4256,0,0,0,0,0,0,0,83,0,0,4097,4239,820,2836,0,0,0,0,0,0,11535,11541,11541,11541,1,1,1,1,'Fowlers Mantle'); -- fowler's mantle
INSERT INTO `synth_recipes` VALUES (4257,0,0,0,0,0,0,0,84,0,0,4099,4241,2837,13631,0,0,0,0,0,0,11537,11542,11542,11542,1,1,1,1,'Kinesis Mantle'); -- kinesis mantle
INSERT INTO `synth_recipes` VALUES (4258,0,0,0,0,0,0,0,84,0,0,4103,4245,635,4509,8707,0,0,0,0,0,8708,8708,8708,8708,1,1,1,1,'Raaz Leather'); -- raaz leather
INSERT INTO `synth_recipes` VALUES (4259,0,0,0,0,0,0,0,87,0,0,4099,4241,3917,3941,3941,13593,0,0,0,0,28646,28647,28647,28647,1,1,1,1,'Radical Mantle'); -- radical mantle
INSERT INTO `synth_recipes` VALUES (4260,0,0,0,0,0,0,0,90,0,0,4103,4245,635,2750,4509,0,0,0,0,0,2751,2751,2751,2751,1,1,1,1,'Amph. Leather'); -- amphiptere leather
INSERT INTO `synth_recipes` VALUES (4261,0,0,0,0,0,0,0,91,0,0,4099,4241,2751,2824,12826,0,0,0,0,0,12228,12228,12228,12228,1,1,1,1,'Ebon Brais'); -- ebon brais
INSERT INTO `synth_recipes` VALUES (4262,0,0,0,0,0,0,0,91,0,0,4099,4241,1373,9130,0,0,0,0,0,0,27392,27393,27393,27393,1,1,1,1,'Bewitched Pumps'); -- bewitched pumps
INSERT INTO `synth_recipes` VALUES (4263,0,0,0,0,0,0,0,91,0,0,4099,4241,9130,10362,0,0,0,0,0,0,27487,27488,27488,27488,1,1,1,1,'Vexed Boots'); -- vexed boots
INSERT INTO `synth_recipes` VALUES (4264,0,0,0,0,0,0,0,92,0,0,4096,4238,9130,10309,0,0,0,0,0,0,27125,27126,27126,27126,1,1,1,1,'Vexed Kote'); -- vexed kote
INSERT INTO `synth_recipes` VALUES (4265,0,0,0,0,0,0,53,93,0,0,4099,4241,746,2751,2751,2824,0,0,0,0,12192,12192,12192,12192,1,1,1,1,'Ebon Gloves'); -- ebon gloves
INSERT INTO `synth_recipes` VALUES (4266,0,0,0,0,0,0,0,93,0,0,4096,4238,9130,10589,0,0,0,0,0,0,27310,27311,27311,27311,1,1,1,1,'Vexed Hakama'); -- vexed hakama
INSERT INTO `synth_recipes` VALUES (4267,0,0,0,0,0,0,0,93,0,0,4099,4241,9130,10588,0,0,0,0,0,0,27308,27309,27309,27309,1,1,1,1,'Vexed Hose'); -- vexed hose
INSERT INTO `synth_recipes` VALUES (4268,0,0,0,0,0,0,57,95,0,0,4099,4241,669,746,2751,2824,0,0,0,0,12264,12264,12264,12264,1,1,1,1,'Ebon Boots'); -- ebon boots
INSERT INTO `synth_recipes` VALUES (4269,0,0,0,0,0,0,0,97,60,0,4099,4241,669,2751,2824,0,0,0,0,0,12120,12120,12120,12120,1,1,1,1,'Ebon Mask'); -- ebon mask
INSERT INTO `synth_recipes` VALUES (4270,0,0,0,0,0,0,0,99,0,0,4098,4240,862,914,3935,0,0,0,0,0,28466,28467,28467,28467,1,1,1,1,'Dynamic Belt'); -- dynamic belt
INSERT INTO `synth_recipes` VALUES (4271,0,0,0,0,50,0,0,99,0,0,4099,4241,2287,2288,2288,2288,2476,2751,0,0,10365,10366,10366,10366,1,1,1,1,'Chelona Boots'); -- chelona boots
INSERT INTO `synth_recipes` VALUES (4272,0,0,0,0,60,0,0,100,0,0,4099,4241,1998,2124,3550,3551,3551,0,0,0,10645,10646,10646,10646,1,1,1,1,'Spolia Pigaches'); -- spolia pigaches
INSERT INTO `synth_recipes` VALUES (4273,0,0,0,40,0,0,0,100,60,0,4099,4241,669,754,1312,2712,2751,2751,2824,0,12156,12156,12156,12156,1,1,1,1,'Ebon Harness'); -- ebon harness
INSERT INTO `synth_recipes` VALUES (4274,0,0,0,0,60,0,0,100,0,0,4099,4241,8751,8751,8976,8976,8988,0,0,0,27400,27401,27401,27401,1,1,1,1,'Revealers Pumps'); -- revealer's pumps
INSERT INTO `synth_recipes` VALUES (4275,0,0,0,0,0,0,0,100,0,0,4099,4241,820,869,8707,8975,0,0,0,0,27603,27604,27604,27604,1,1,1,1,'Aptitude Mantle'); -- aptitude mantle
INSERT INTO `synth_recipes` VALUES (4276,0,0,0,0,0,0,0,104,0,0,4103,4245,695,3547,4509,0,0,0,0,0,3548,3548,3548,3548,1,1,1,1,'Sealord Leather'); -- sealord leather
INSERT INTO `synth_recipes` VALUES (4277,0,0,0,0,0,0,0,105,0,0,4098,4240,860,3981,0,0,0,0,0,0,22200,22201,22201,22201,1,1,1,1,'Clerisy Strap'); -- clerisy strap
INSERT INTO `synth_recipes` VALUES (4278,0,0,0,0,0,0,0,105,0,0,4098,4240,2169,8754,0,0,0,0,0,0,22210,22211,22211,22211,1,1,1,1,'Elan Strap'); -- elan strap
INSERT INTO `synth_recipes` VALUES (4279,0,0,0,0,0,0,0,105,0,0,4098,4240,860,3978,0,0,0,0,0,0,22202,22203,22203,22203,1,1,1,1,'Irenic Strap'); -- irenic strap
INSERT INTO `synth_recipes` VALUES (4280,0,0,0,0,0,0,0,105,0,0,4098,4240,2169,4015,0,0,0,0,0,0,22208,22209,22209,22209,1,1,1,1,'Mensch Strap'); -- mensch strap
INSERT INTO `synth_recipes` VALUES (4281,0,0,0,0,50,0,0,107,0,0,4099,4241,822,2497,2530,3545,0,0,0,0,10357,10362,10362,10362,1,1,1,1,'Hexed Boots'); -- hexed boots
INSERT INTO `synth_recipes` VALUES (4282,0,0,0,0,0,0,30,108,60,0,4096,4238,687,752,759,1279,1415,3548,0,0,10304,10309,10309,10309,1,1,1,1,'Hexed Tekko'); -- hexed tekko
INSERT INTO `synth_recipes` VALUES (4283,0,0,0,0,0,0,60,110,0,0,4099,4241,766,862,2570,3548,3548,0,0,0,10583,10588,10588,10588,1,1,1,1,'Hexed Hose'); -- hexed hose
INSERT INTO `synth_recipes` VALUES (4284,0,0,0,0,38,0,0,110,0,0,4096,4238,687,745,823,1279,1828,3548,3548,0,10584,10589,10589,10589,1,1,1,1,'Hexed Hakama'); -- hexed hakama
INSERT INTO `synth_recipes` VALUES (4285,0,0,0,0,70,0,0,111,0,0,4099,4241,1372,8728,8754,9130,0,0,0,0,27392,27393,27393,27393,1,1,1,1,'Bewitched Pumps'); -- bewitched pumps
INSERT INTO `synth_recipes` VALUES (4286,0,0,0,0,70,0,0,111,0,0,4099,4241,8728,8754,9130,10357,0,0,0,0,27487,27488,27488,27488,1,1,1,1,'Vexed Boots'); -- vexed boots
INSERT INTO `synth_recipes` VALUES (4287,0,0,0,0,0,0,0,111,0,0,4099,4241,9003,9006,28464,0,0,0,0,0,26331,26332,26332,26332,1,1,1,1,'Tempus Fugit'); -- tempus fugit
INSERT INTO `synth_recipes` VALUES (4288,0,0,0,0,70,0,0,112,0,0,4096,4238,8754,9048,9130,10304,0,0,0,0,27125,27126,27126,27126,1,1,1,1,'Vexed Kote'); -- vexed kote
INSERT INTO `synth_recipes` VALUES (4289,0,0,0,0,70,0,0,113,0,0,4096,4238,8754,9048,9130,10584,0,0,0,0,27310,27311,27311,27311,1,1,1,1,'Vexed Hakama'); -- vexed hakama
INSERT INTO `synth_recipes` VALUES (4290,0,0,0,0,0,0,70,113,0,0,4099,4241,8722,9003,9130,10583,0,0,0,0,27308,27309,27309,27309,1,1,1,1,'Vexed Hose'); -- vexed hose
INSERT INTO `synth_recipes` VALUES (4291,0,0,0,0,0,0,0,118,0,0,4099,4241,765,8739,9003,0,0,0,0,0,26333,26334,26334,26334,1,1,1,1,'Ioskeha Belt'); -- ioskeha belt
INSERT INTO `synth_recipes` VALUES (4292,0,0,0,0,0,0,0,0,0,105,4098,4240,9245,0,0,0,0,0,0,0,9246,9246,9246,9246,1,2,3,4,'Cypress Lumber'); -- Cypress Lumber
INSERT INTO `synth_recipes` VALUES (4293,0,0,0,0,0,0,0,0,0,105,4098,4240,1657,9245,9245,9245,0,0,0,0,9246,9246,9246,9246,3,6,9,12,'Cypress Lumber'); -- Cypress Lumber
INSERT INTO `synth_recipes` VALUES (4294,0,0,0,0,0,0,0,0,105,0,4096,4238,9247,9247,9247,9247,0,0,0,0,9248,9248,9248,9248,1,1,1,1,'Niobium Ingot'); -- niobium ingot
INSERT INTO `synth_recipes` VALUES (4295,0,0,0,0,0,0,105,0,0,0,4096,4238,9249,9249,9249,9249,0,0,0,0,9250,9250,9250,9250,1,1,1,1,'Ruthenium Ingot'); -- ruthenium ingot
INSERT INTO `synth_recipes` VALUES (4296,0,0,0,0,105,0,0,0,0,0,4099,4241,9251,9251,9251,0,0,0,0,0,9252,9252,9252,9252,1,1,1,1,'Khoma Cloth'); -- khoma cloth
INSERT INTO `synth_recipes` VALUES (4297,0,0,0,0,0,0,0,105,0,0,4103,4245,635,4509,9253,0,0,0,0,0,9254,9254,9254,9254,1,1,1,1,'Faulpie Leather'); -- faulpie leather
INSERT INTO `synth_recipes` VALUES (4298,0,0,0,0,0,0,0,105,0,0,4103,4245,695,4509,9253,0,0,0,0,0,9254,9254,9254,9254,1,1,1,1,'Faulpie Leather'); -- faulpie leather
INSERT INTO `synth_recipes` VALUES (4299,0,0,0,105,0,0,0,0,0,0,4098,4240,760,9255,0,0,0,0,0,0,9256,9256,9256,9256,6,8,10,12,'Cyan Orb'); -- cyan orb
INSERT INTO `synth_recipes` VALUES (4300,0,0,105,0,0,0,0,0,0,0,4096,4238,931,4149,9257,0,0,0,0,0,9258,9258,9258,9258,1,2,3,4,'Azure Cermet'); -- Azure Cermet
INSERT INTO `synth_recipes` VALUES (4301,0,0,0,0,91,0,0,0,0,0,4099,4241,1372,9130,0,0,0,0,0,0,27392,27393,27393,27393,1,1,1,1,'Bewitched Pumps'); -- Bewitched Pumps/Voodoo Pumps
INSERT INTO `synth_recipes` VALUES (4302,0,0,0,0,111,0,70,0,0,0,4099,4241,1361,8728,8754,9130,0,0,0,0,27392,27393,27393,27393,1,1,1,1,'Bewitched Pumps'); -- Bewitched Pumps/Voodoo Pumps
INSERT INTO `synth_recipes` VALUES (4303,0,0,0,0,0,0,0,0,94,0,4096,4238,9130,10421,0,0,0,0,0,0,25621,25622,25622,25622,1,1,1,1,'Vexed Somen'); -- Vexed Somen/Jinxed Somen
INSERT INTO `synth_recipes` VALUES (4304,0,0,0,0,70,0,0,0,114,0,4096,4238,8724,9048,9130,10420,0,0,0,0,25621,25622,25622,25622,1,1,1,1,'Vexed Somen'); -- Vexed Somen/Jinxed Somen
INSERT INTO `synth_recipes` VALUES (4305,0,0,0,0,0,0,0,0,95,0,4096,4238,9130,10246,0,0,0,0,0,0,25694,25695,25695,25695,1,1,1,1,'Vexed Domaru'); -- Vexed Domaru/Jinxed Domaru
INSERT INTO `synth_recipes` VALUES (4306,0,0,0,0,70,0,0,0,115,0,4096,4238,8724,9048,9130,10241,0,0,0,0,25694,25695,25695,25695,1,1,1,1,'Vexed Domaru'); -- Vexed Domaru/Jinxed Domaru
INSERT INTO `synth_recipes` VALUES (4307,0,0,0,0,0,0,0,92,0,0,4096,4238,9130,10309,0,0,0,0,0,0,27125,27126,27126,27126,1,1,1,1,'Vexed Kote'); -- Vexed Kote/Jinxed Kote
INSERT INTO `synth_recipes` VALUES (4308,0,0,0,0,70,0,0,0,112,0,4096,4238,8754,9048,9130,10304,0,0,0,0,27125,27126,27126,27126,1,1,1,1,'Vexed Kote'); -- Vexed Kote/Jinxed Kote
INSERT INTO `synth_recipes` VALUES (4309,0,0,0,0,0,0,0,93,0,0,4099,4241,9130,10589,0,0,0,0,0,0,27310,27311,27311,27311,1,1,1,1,'Vexed Hakama'); -- Vexed Hakama/Jinxed Hakama
INSERT INTO `synth_recipes` VALUES (4310,0,0,0,0,70,0,0,113,0,0,4096,4241,8754,9048,9130,10584,0,0,0,0,27310,27311,27311,27311,1,1,1,1,'Vexed Hakama'); -- Vexed Hakama/Jinxed Hakama
INSERT INTO `synth_recipes` VALUES (4311,0,0,0,0,0,0,0,0,91,0,4096,4238,9130,10359,0,0,0,0,0,0,27481,27482,27482,27482,1,1,1,1,'Vexed Sune-ate'); -- Vexed Sune-ate/Jinxed Sune-ate
INSERT INTO `synth_recipes` VALUES (4312,0,0,0,0,70,0,0,0,111,0,4096,4238,8754,9048,9130,10354,0,0,0,0,27481,27482,27482,27482,1,1,1,1,'Vexed Sune-ate'); -- Vexed Sune-ate/Jinxed Sune-ate
INSERT INTO `synth_recipes` VALUES (4313,0,0,0,0,0,0,0,93,0,0,4099,4251,9130,10588,0,0,0,0,0,0,27308,27309,27309,27309,1,1,1,1,'Vexed Hose'); -- Vexed Hose/Jinxed Hose
INSERT INTO `synth_recipes` VALUES (4314,0,0,0,0,0,0,0,70,113,0,4099,4251,8722,9003,9130,10583,0,0,0,0,27308,27309,27309,27309,1,1,1,1,'Vexed Hose'); -- Vexed Hose/Jinxed Hose
INSERT INTO `synth_recipes` VALUES (4315,0,0,0,0,0,0,0,0,94,0,4096,4238,1355,9130,0,0,0,0,0,0,26684,26685,26685,26685,1,1,1,1,'Bewitched Celata'); -- Bewitched Celata/Voodoo Celta
INSERT INTO `synth_recipes` VALUES (4316,0,0,0,0,0,0,0,70,114,0,4096,4238,1354,8988,9064,9130,0,0,0,0,26684,26685,26685,26685,1,1,1,1,'Bewitched Celata'); -- Bewitched Celata/Voodoo Celta
INSERT INTO `synth_recipes` VALUES (4317,0,0,0,0,0,0,0,0,95,0,4099,4241,1357,9130,0,0,0,0,0,0,26860,26861,26861,26861,1,1,1,1,'Bewitched Hauberk'); -- Bewitched Hauberk/Voodoo Hauberk
INSERT INTO `synth_recipes` VALUES (4318,0,0,0,0,70,0,0,0,115,0,4099,4241,1356,8728,9064,9130,0,0,0,0,26860,26861,26861,26861,1,1,1,1,'Bewitched Hauberk'); -- Bewitched Hauberk/Voodoo Hauberk
INSERT INTO `synth_recipes` VALUES (4319,0,0,0,0,0,0,0,0,92,0,4099,4241,1359,9130,0,0,0,0,0,0,27036,27037,27037,27037,1,1,1,1,'Bewitched Mufflers'); -- Bewitched Mufflers/Voodoo Mufflers
INSERT INTO `synth_recipes` VALUES (4320,0,0,0,0,0,0,70,0,112,0,4099,4241,1358,8992,9064,9130,0,0,0,0,27036,27037,27037,27037,1,1,1,1,'Bewitched Mufflers'); -- Bewitched Mufflers/Voodoo Mufflers
INSERT INTO `synth_recipes` VALUES (4321,0,0,0,0,0,0,0,0,93,0,4099,4241,1361,9130,0,0,0,0,0,0,27212,27213,27213,27213,1,1,1,1,'Bewitched Breeches'); -- Bewitched Breeches/Voodoo Breeches
INSERT INTO `synth_recipes` VALUES (4322,0,0,0,0,0,0,0,70,113,0,4099,4241,1360,8988,9064,9130,0,0,0,0,27212,27213,27213,27213,1,1,1,1,'Bewitched Breeches'); -- Bewitched Breeches/Voodoo Breeches
INSERT INTO `synth_recipes` VALUES (4323,0,0,0,0,0,0,0,0,91,0,4099,4241,1363,9130,0,0,0,0,0,0,27388,27389,27389,27389,1,1,1,1,'Bewitched Sollerets'); -- Bewitched Sollerets/Voodoo Sollerets
INSERT INTO `synth_recipes` VALUES (4324,0,0,0,0,0,0,70,0,111,0,4099,4241,1362,8992,9064,9130,0,0,0,0,27388,27389,27389,27389,1,1,1,1,'Bewitched Sollerets'); -- Bewitched Sollerets/Voodoo Sollerets
INSERT INTO `synth_recipes` VALUES (4325,0,0,0,0,0,0,0,0,0,94,4099,4241,1345,9130,0,0,0,0,0,0,26686,26687,26687,26687,1,1,1,1,'Bewitched Kabuto'); -- Bewitched Kabuto/Voodoo Kabuto
INSERT INTO `synth_recipes` VALUES (4326,0,0,0,0,0,0,0,0,70,114,4099,4241,1344,4014,9058,9130,0,0,0,0,26686,26687,26687,26687,1,1,1,1,'Bewitched Kabuto'); -- Bewitched Kabuto/Voodoo Kabuto
INSERT INTO `synth_recipes` VALUES (4327,0,0,0,0,0,0,0,0,0,95,4098,4240,1347,9130,0,0,0,0,0,0,26862,26863,26863,26863,1,1,1,1,'Bewitched Togi'); -- Bewitched Togi/Voodoo Togi
INSERT INTO `synth_recipes` VALUES (4328,0,0,0,0,0,0,0,0,70,115,4098,4240,1346,4014,9058,9130,0,0,0,0,26862,26863,26863,26863,1,1,1,1,'Bewitched Togi'); -- Bewitched Togi/Voodoo Togi
INSERT INTO `synth_recipes` VALUES (4329,0,0,0,0,0,0,0,0,0,92,4098,4240,1349,9130,0,0,0,0,0,0,27038,27039,27039,27039,1,1,1,1,'Bewitched Kote'); -- Bewitched Kote/Voodoo Kote
INSERT INTO `synth_recipes` VALUES (4330,0,0,0,0,0,0,0,0,70,112,4098,4240,1348,4014,9058,9130,0,0,0,0,27038,27039,27039,27039,1,1,1,1,'Bewitched Kote'); -- Bewitched Kote/Voodoo Kote
INSERT INTO `synth_recipes` VALUES (4331,0,0,0,0,0,0,0,0,0,93,4099,4241,1351,9130,0,0,0,0,0,0,27214,27215,27215,27215,1,1,1,1,'Bewitched Haidate'); -- Bewitched Haidate/Voodoo Haidate
INSERT INTO `synth_recipes` VALUES (4332,0,0,0,0,0,0,0,0,70,113,4099,4241,1350,4014,9058,9130,0,0,0,0,27214,27215,27215,27215,1,1,1,1,'Bewitched Haidate'); -- Bewitched Haidate/Voodoo Haidate
INSERT INTO `synth_recipes` VALUES (4333,0,0,0,0,0,0,0,0,0,91,4098,4240,1353,9130,0,0,0,0,0,0,27390,27391,27391,27391,1,1,1,1,'Bewitched Sune-ate'); -- Bewitched Sune-ate/Voodoo Sune-ate
INSERT INTO `synth_recipes` VALUES (4334,0,0,0,0,0,0,0,0,70,111,4098,4240,1352,4014,9058,9130,0,0,0,0,27390,27391,27391,27391,1,1,1,1,'Bewitched Sune-ate'); -- Bewitched Sune-ate/Voodoo Sune-ate
INSERT INTO `synth_recipes` VALUES (4335,0,0,0,0,0,0,0,0,89,0,4098,4240,2000,0,0,0,0,0,0,0,3306,3306,3306,3306,6,8,10,12,'D. A. Bolt Heads'); -- Dark Adaman Bolt Heads
INSERT INTO `synth_recipes` VALUES (4336,0,0,0,0,0,0,0,0,67,0,4096,4238,643,643,643,2763,0,0,0,0,2764,2764,2764,2764,1,1,1,1,'Dweomer Steel'); -- Dweomer Steel Ingot
INSERT INTO `synth_recipes` VALUES (4337,1,0,0,0,99,0,0,0,0,0,4100,4242,15891,0,0,0,0,0,0,0,2287,823,2304,2304,1,1,1,1,'Karakul Thread'); -- Al Zahbi Sash (desynth)
INSERT INTO `synth_recipes` VALUES (4338,0,0,0,0,0,0,32,0,0,106,4099,4241,745,2535,2535,2535,2535,2535,0,0,434,434,434,434,1,1,1,1,'Isula Sideboard'); -- Isula Sideboard
INSERT INTO `synth_recipes` VALUES (4339,0,0,0,0,54,0,0,0,0,110,4099,4241,745,829,829,1409,1462,1462,1462,1700,439,439,439,439,1,1,1,1,'Planus Table'); -- Planus Table
INSERT INTO `synth_recipes` VALUES (4340,0,0,0,0,0,0,0,0,5,0,4096,4238,8819,0,0,0,0,0,0,0,16465,16465,16465,16465,1,1,1,1,'Bronze Knife'); -- bronze knife (kit)
INSERT INTO `synth_recipes` VALUES (4341,0,0,0,0,0,0,0,0,10,0,4096,4238,8820,0,0,0,0,0,0,0,17034,17034,17034,17034,1,1,1,1,'Bronze Mace'); -- bronze mace (kit)
INSERT INTO `synth_recipes` VALUES (4342,0,0,0,0,0,0,0,0,15,0,4096,4238,8821,0,0,0,0,0,0,0,659,659,659,659,1,1,1,1,'Tin Ingot'); -- tin ingot (kit)
INSERT INTO `synth_recipes` VALUES (4343,0,0,0,0,0,0,0,0,20,0,4098,4240,8822,0,0,0,0,0,0,0,1216,1216,1216,1216,6,6,6,6,'Iron Arrowheads'); -- iron arrowheads (kit)
INSERT INTO `synth_recipes` VALUES (4344,0,0,0,0,0,0,0,0,25,0,4096,4238,8823,0,0,0,0,0,0,0,16565,16565,16565,16565,1,1,1,1,'Spatha'); -- spatha (kit)
INSERT INTO `synth_recipes` VALUES (4345,0,0,0,0,0,0,0,0,30,0,4098,4240,8824,0,0,0,0,0,0,0,17298,17298,17298,17298,8,8,8,8,'Tathlum'); -- tathlum (kit)
INSERT INTO `synth_recipes` VALUES (4346,0,0,0,0,0,0,0,0,35,0,4096,4238,8825,0,0,0,0,0,0,0,12300,12300,12300,12300,1,1,1,1,'Targe'); -- targe (kit)
INSERT INTO `synth_recipes` VALUES (4347,0,0,0,0,0,0,0,0,40,0,4098,4240,8826,0,0,0,0,0,0,0,676,676,676,676,1,1,1,1,'Steel Scales'); -- steel scales (kit)
INSERT INTO `synth_recipes` VALUES (4348,0,0,0,0,0,0,0,0,45,0,4096,4238,8827,0,0,0,0,0,0,0,17061,17061,17061,17061,1,1,1,1,'Mythril Rod'); -- mythril rod (kit)
INSERT INTO `synth_recipes` VALUES (4349,0,0,0,0,0,0,0,0,50,0,4099,4241,8828,0,0,0,0,0,0,0,12306,12306,12306,12306,1,1,1,1,'Kite Shield'); -- kite shield (kit)
INSERT INTO `synth_recipes` VALUES (4350,0,0,0,0,0,0,0,0,55,0,4096,4238,8829,0,0,0,0,0,0,0,12416,12416,12416,12416,1,1,1,1,'Sallet'); -- sallet (kit)
INSERT INTO `synth_recipes` VALUES (4351,0,0,0,0,0,0,0,0,60,0,4096,4238,8830,0,0,0,0,0,0,0,17037,17037,17037,17037,1,1,1,1,'Darksteel Mace'); -- darksteel mace (kit)
INSERT INTO `synth_recipes` VALUES (4352,0,0,0,0,0,0,0,0,65,0,4096,4238,8831,0,0,0,0,0,0,0,16476,16476,16476,16476,1,1,1,1,'Darksteel Kukri'); -- darksteel kukri (kit)
INSERT INTO `synth_recipes` VALUES (4353,0,0,0,0,0,0,0,0,70,0,4096,4238,8832,0,0,0,0,0,0,0,16915,16915,16915,16915,1,1,1,1,'Hien'); -- hien (kit)
INSERT INTO `synth_recipes` VALUES (4354,0,0,0,0,0,0,0,0,76,0,4099,4241,9489,0,0,0,0,0,0,0,17784,17784,17784,17784,1,1,1,1,'Keppu'); -- keppu (kit)
INSERT INTO `synth_recipes` VALUES (4355,0,0,0,0,0,0,0,0,80,0,4096,4238,9490,0,0,0,0,0,0,0,16546,16546,16546,16546,1,1,1,1,'Katzbalger'); -- katzbalger (kit)
INSERT INTO `synth_recipes` VALUES (4356,0,0,0,0,0,0,0,0,84,0,4099,4241,9491,0,0,0,0,0,0,0,12684,12684,12684,12684,1,1,1,1,'Thick Mufflers'); -- thick mufflers (kit)
INSERT INTO `synth_recipes` VALUES (4357,0,0,0,0,0,0,0,0,91,0,4096,4238,9492,0,0,0,0,0,0,0,16470,16470,16470,16470,1,1,1,1,'Gully'); -- gully (kit)
INSERT INTO `synth_recipes` VALUES (4358,0,0,0,0,0,0,0,0,94,0,4096,4238,9493,0,0,0,0,0,0,0,16547,16547,16547,16547,1,1,1,1,'Anelace'); -- anelace (kit)
INSERT INTO `synth_recipes` VALUES (4359,0,0,0,0,0,0,0,0,15,0,4096,4238,651,714,0,0,0,0,0,0,8740,8740,8740,8740,6,8,10,12,'Pizza Cutter'); -- pizza cutter
INSERT INTO `synth_recipes` VALUES (4360,0,0,0,0,0,0,0,0,37,0,4096,4238,652,652,851,2848,0,0,0,0,18766,18772,18772,18772,1,1,1,1,'Tyro Katars'); -- tyro katars
INSERT INTO `synth_recipes` VALUES (4361,0,0,0,0,0,0,0,20,39,20,4096,4238,648,653,715,818,852,2857,0,0,19276,19281,19281,19281,1,1,1,1,'Midare'); -- midare
INSERT INTO `synth_recipes` VALUES (4362,0,0,0,0,0,0,0,0,52,26,4096,4238,2852,16775,0,0,0,0,0,0,18957,18960,18960,18960,1,1,1,1,'Smiting Scythe'); -- smiting scythe
INSERT INTO `synth_recipes` VALUES (4363,0,0,0,0,0,0,0,0,56,0,4096,4238,1155,1155,1155,1155,2549,0,0,0,652,657,657,657,1,1,1,1,'Steel Ingot'); -- steel ingot
INSERT INTO `synth_recipes` VALUES (4364,0,0,0,28,0,0,0,0,57,0,4096,4238,654,2849,0,0,0,0,0,0,18769,18773,18773,18773,1,1,1,1,'Severus Claws'); -- severus claws
INSERT INTO `synth_recipes` VALUES (4365,0,0,0,0,0,0,0,0,60,0,4096,4238,652,654,654,2764,0,0,0,0,17763,17763,17763,17763,1,1,1,1,'Erlkings Blade'); -- elking's blade
INSERT INTO `synth_recipes` VALUES (4366,0,0,0,0,0,0,30,0,60,30,4096,4238,651,652,652,714,2845,0,0,0,18506,18509,18509,18509,1,1,1,1,'Tewhatewha'); -- tewhatewha
INSERT INTO `synth_recipes` VALUES (4367,0,0,0,0,0,0,54,0,61,0,4096,4238,2748,2756,2764,0,0,0,0,0,19275,19275,19275,19275,1,1,1,1,'Tsukumo'); -- tsukumo
INSERT INTO `synth_recipes` VALUES (4368,0,0,52,0,0,0,0,0,61,30,4096,4238,652,654,654,713,824,924,2764,0,18955,18955,18955,18955,1,1,1,1,'Dweomer Scythe'); -- dweomer scythe
INSERT INTO `synth_recipes` VALUES (4369,0,0,0,0,0,0,0,0,63,0,4096,4238,2535,2764,0,0,0,0,0,0,19116,19116,19116,19116,1,1,1,1,'Dweomer Knife'); -- dweomer knife
INSERT INTO `synth_recipes` VALUES (4370,0,0,0,0,0,0,0,0,64,0,4096,4238,654,717,2764,0,0,0,0,0,18870,18870,18870,18870,1,1,1,1,'Dweomer Maul'); -- dweomer maul
INSERT INTO `synth_recipes` VALUES (4371,0,0,0,0,0,0,0,0,65,31,4096,4238,654,654,716,2764,0,0,0,0,17966,17966,17966,17966,1,1,1,1,'Erlkings Tabar'); -- erlking's tabar
INSERT INTO `synth_recipes` VALUES (4372,0,0,0,0,0,0,0,0,65,0,4096,4238,2000,2764,0,0,0,0,0,0,19115,19115,19115,19115,1,1,1,1,'Fane Baselard'); -- fane baselard
INSERT INTO `synth_recipes` VALUES (4373,0,0,0,0,0,0,0,0,69,23,4096,4238,652,654,718,2764,0,0,0,0,18505,18505,18505,18505,1,1,1,1,'Erlkings Kheten'); -- erlking's kheten
INSERT INTO `synth_recipes` VALUES (4374,0,0,0,0,0,0,0,52,69,34,4096,4238,648,651,654,657,715,818,853,2764,18452,18452,18452,18452,1,1,1,1,'Rindomaru'); -- rindomaru
INSERT INTO `synth_recipes` VALUES (4375,0,0,36,0,0,0,0,0,73,0,4096,4238,665,665,932,2001,2290,0,0,0,8554,8554,8554,8554,12,12,12,12,'Armor Plate Iii'); -- armor plate iii
INSERT INTO `synth_recipes` VALUES (4376,0,0,0,0,0,0,0,0,76,0,4096,4238,645,756,756,756,0,0,0,0,757,757,757,757,1,1,1,1,'Durium Ingot'); -- durium ingot
INSERT INTO `synth_recipes` VALUES (4377,0,0,0,0,0,0,0,0,77,0,4096,4238,757,0,0,0,0,0,0,0,758,758,758,758,1,1,1,1,'Durium Sheet'); -- durium sheet
INSERT INTO `synth_recipes` VALUES (4378,0,1995,0,0,0,0,0,0,77,0,4096,4238,757,757,757,757,757,757,2144,0,758,758,758,758,6,6,6,6,'Durium Sheet'); -- durium sheet
INSERT INTO `synth_recipes` VALUES (4379,0,0,39,0,0,0,0,0,78,0,4096,4238,665,932,2001,2290,4022,0,0,0,8556,8556,8556,8556,12,12,12,12,'Armor Plate Iv'); -- armor plate iv
INSERT INTO `synth_recipes` VALUES (4380,0,0,0,0,0,0,0,0,80,0,4096,4238,757,757,0,0,0,0,0,0,759,759,759,759,1,2,3,4,'Durium Chain'); -- durium chain
INSERT INTO `synth_recipes` VALUES (4381,0,1994,0,0,0,0,0,0,80,0,4096,4238,757,757,757,757,757,757,2143,0,759,759,759,759,3,6,9,12,'Durium Chain'); -- durium chain
INSERT INTO `synth_recipes` VALUES (4382,0,0,0,0,0,0,0,0,90,0,4098,4240,3919,0,0,0,0,0,0,0,3945,3945,3945,3945,6,8,10,12,'Mdr. Bolt Heads'); -- midrium bolt heads
INSERT INTO `synth_recipes` VALUES (4383,0,0,0,0,0,0,45,45,91,0,4096,4238,820,851,2001,2001,2275,2823,0,0,12261,12261,12261,12261,1,1,1,1,'Ebon Leggings'); -- ebon leggings
INSERT INTO `synth_recipes` VALUES (4384,0,0,0,0,0,0,0,0,92,0,4098,4240,655,0,0,0,0,0,0,0,3507,3507,3507,3507,6,8,10,12,'Adm. Bolt Heads'); -- adaman bolt heads
INSERT INTO `synth_recipes` VALUES (4385,0,0,0,0,0,0,46,46,93,0,4096,4238,2001,2001,2275,2823,12698,0,0,0,12189,12189,12189,12189,1,1,1,1,'Ebon Gauntlets'); -- ebon gauntlets
INSERT INTO `synth_recipes` VALUES (4386,0,0,0,0,0,0,0,0,93,0,4096,4238,3918,3918,3918,3918,0,0,0,0,3919,3919,3919,3919,1,1,1,1,'Midrium Ingot'); -- midrium ingot
INSERT INTO `synth_recipes` VALUES (4387,0,0,0,0,0,0,0,0,93,0,4098,4240,652,8748,0,0,0,0,0,0,8750,8750,8750,8750,6,8,10,12,'Ra. Arrwhd.'); -- ra'kaznar arrowheads
INSERT INTO `synth_recipes` VALUES (4388,0,0,0,0,0,0,0,0,94,0,4096,4238,3919,3927,0,0,0,0,0,0,20644,20642,20642,20642,1,1,1,1,'Tzustes Knife'); -- tzustes knife
INSERT INTO `synth_recipes` VALUES (4389,0,0,0,0,0,0,47,0,95,0,4096,4238,2001,2001,2275,2275,2823,0,0,0,12117,12117,12117,12117,1,1,1,1,'Ebon Armet'); -- ebon armet
INSERT INTO `synth_recipes` VALUES (4390,0,0,0,0,0,0,0,0,95,0,4096,4238,4021,0,0,0,0,0,0,0,4022,4022,4022,4022,1,1,1,1,'Titanium Sheet'); -- titanium sheet
INSERT INTO `synth_recipes` VALUES (4391,0,1995,0,0,0,0,0,0,95,0,4096,4238,2144,4021,4021,4021,4021,4021,4021,0,4022,4022,4022,4022,6,6,6,6,'Titanium Sheet'); -- titanium sheet
INSERT INTO `synth_recipes` VALUES (4392,0,0,0,0,0,0,0,0,95,0,4096,4238,664,3927,3963,3963,0,0,0,0,28671,28669,28669,28669,1,1,1,1,'Butznar Shield'); -- butznar shield
INSERT INTO `synth_recipes` VALUES (4393,0,0,0,0,0,0,0,0,95,0,4096,4238,2538,3963,3963,0,0,0,0,0,20744,20743,20743,20743,1,1,1,1,'Bihkah Sword'); -- bihkah sword
INSERT INTO `synth_recipes` VALUES (4394,0,0,48,0,0,0,0,0,96,0,4096,4238,852,3919,3919,3919,3919,3927,3931,0,20783,20784,20784,20784,1,1,1,1,'Uruz Blade'); -- uruz blade
INSERT INTO `synth_recipes` VALUES (4395,0,0,0,0,0,0,0,0,96,48,4096,4238,3919,3919,3923,3927,0,0,0,0,20878,20879,20879,20879,1,1,1,1,'Nohkux Axe'); -- nohkux axe
INSERT INTO `synth_recipes` VALUES (4396,0,0,0,0,0,0,0,0,96,0,4096,4238,3919,0,0,0,0,0,0,0,3963,3963,3963,3963,1,1,1,1,'Midrium Sheet'); -- midrium sheet
INSERT INTO `synth_recipes` VALUES (4397,0,1995,0,0,0,0,0,0,96,0,4096,4238,2144,3919,3919,3919,3919,3919,3919,0,3963,3963,3963,3963,6,6,6,6,'Midrium Sheet'); -- midrium sheet
INSERT INTO `synth_recipes` VALUES (4398,0,0,0,0,0,0,0,48,96,48,4096,4238,657,720,818,853,3919,3939,0,0,21011,21012,21012,21012,1,1,1,1,'Enju'); -- enju
INSERT INTO `synth_recipes` VALUES (4399,0,0,0,0,0,0,0,0,96,0,4096,4238,657,720,877,2275,2304,3919,3919,3939,21056,21057,21057,21057,1,1,1,1,'Tomonari'); -- tomonari
INSERT INTO `synth_recipes` VALUES (4400,0,0,0,0,0,0,0,0,96,48,4096,4238,654,654,3919,3927,0,0,0,0,20831,20832,20832,20832,1,1,1,1,'Aalak Axe'); -- aalak's axe
INSERT INTO `synth_recipes` VALUES (4401,0,0,0,0,0,0,48,48,97,0,4096,4238,851,851,2001,2001,2275,2823,0,0,12225,12225,12225,12225,1,1,1,1,'Ebon Hose'); -- ebon hose
INSERT INTO `synth_recipes` VALUES (4402,0,0,0,0,0,0,48,0,97,48,4096,4238,650,711,3919,3923,0,0,0,0,21292,21293,21293,21293,1,1,1,1,'Bandeiras Gun'); -- bandeiras gun
INSERT INTO `synth_recipes` VALUES (4403,0,0,0,0,0,0,0,0,97,0,4096,4238,2538,3919,3919,3919,3919,3927,0,0,20789,20788,20788,20788,1,1,1,1,'Hatzoaar Sword'); -- hatzoaar sword
INSERT INTO `synth_recipes` VALUES (4404,0,0,0,0,0,0,0,0,97,0,4098,4240,658,0,0,0,0,0,0,0,3947,3947,3947,3947,6,8,10,12,'Dmc. Bolt Heads'); -- damascus bolt heads
INSERT INTO `synth_recipes` VALUES (4405,0,0,0,0,0,0,0,48,97,0,4096,4238,1629,2170,8990,8992,0,0,0,0,27224,27225,27225,27225,1,1,1,1,'Gefechtdiechlings'); -- gefechtdiechlings
INSERT INTO `synth_recipes` VALUES (4406,0,0,0,0,0,0,0,0,98,0,4098,4240,657,745,755,914,0,0,0,0,19783,19783,19783,19783,33,66,99,99,'Iga Shuriken'); -- iga shuriken
INSERT INTO `synth_recipes` VALUES (4407,0,0,0,0,0,0,0,0,98,0,4096,4238,654,654,2274,3923,3923,3927,3935,0,20922,20923,20923,20923,1,1,1,1,'Aakab Scythe'); -- aak'ab scythe
INSERT INTO `synth_recipes` VALUES (4408,0,0,0,0,0,0,49,0,98,0,4096,4238,747,914,2170,2275,3935,8990,8992,0,26722,26723,26723,26723,1,1,1,1,'Gefechtschaller'); -- gefechtschaller
INSERT INTO `synth_recipes` VALUES (4409,0,0,0,0,0,0,0,0,98,0,4102,4244,25864,0,0,0,0,0,0,0,25849,25849,25849,25849,1,1,1,1,'Dashing Subligar'); -- dashing subligar
INSERT INTO `synth_recipes` VALUES (4410,0,0,0,0,0,0,60,0,100,0,4096,4238,668,668,2001,2001,2275,2275,2823,0,12153,12153,12153,12153,1,1,1,1,'Ebon Breastplate'); -- ebon breastplate
INSERT INTO `synth_recipes` VALUES (4411,0,0,50,0,0,0,50,0,100,0,4096,4238,852,3923,3923,3923,3923,3927,3931,0,20785,20786,20786,20786,1,1,1,1,'Thurisaz Blade'); -- thurisaz blade
INSERT INTO `synth_recipes` VALUES (4412,0,0,0,0,0,0,0,0,100,0,4098,4240,657,914,4022,0,0,0,0,0,21351,21351,21351,21352,33,66,99,99,'Roppo Shuriken'); -- roppo shuriken
INSERT INTO `synth_recipes` VALUES (4413,0,0,0,0,0,0,50,0,101,0,4096,4238,666,666,667,667,668,754,794,2275,332,332,332,332,1,1,1,1,'Winged Plaque'); -- winged plaque
INSERT INTO `synth_recipes` VALUES (4414,0,0,0,0,0,0,0,0,102,0,4098,4240,4021,0,0,0,0,0,0,0,3949,3949,3949,3949,6,8,10,12,'Tit. Bolt Heads'); -- titanium bolt heads
INSERT INTO `synth_recipes` VALUES (4415,0,0,0,0,0,0,0,0,102,51,4096,4238,730,8704,0,0,0,0,0,0,21554,21555,21555,21555,1,1,1,1,'Arasy Knife'); -- arasy knife
INSERT INTO `synth_recipes` VALUES (4416,0,0,0,0,0,0,0,0,102,51,4096,4238,655,719,8704,0,0,0,0,0,21504,21505,21505,21505,1,1,1,1,'Arasy Sainti'); -- arasy sainti
INSERT INTO `synth_recipes` VALUES (4417,0,0,0,0,0,0,51,0,102,0,4096,4238,655,1122,2536,8704,0,0,0,0,21604,21605,21605,21605,1,1,1,1,'Arasy Sword'); -- arasy sword
INSERT INTO `synth_recipes` VALUES (4418,0,0,0,0,0,0,0,51,102,0,4096,4238,655,655,719,1122,8704,0,0,0,21654,21655,21655,21655,1,1,1,1,'Arasy Claymore'); -- arasy claymore
INSERT INTO `synth_recipes` VALUES (4419,0,0,0,0,0,0,51,0,102,0,4096,4238,655,719,2536,8704,0,0,0,0,21704,21705,21705,21705,1,1,1,1,'Arasy Tabar'); -- arasy tabar
INSERT INTO `synth_recipes` VALUES (4420,0,0,0,0,0,0,51,0,102,0,4096,4238,655,719,812,2536,8704,0,0,0,21762,21763,21763,21763,1,1,1,1,'Arasy Axe'); -- arasy axe
INSERT INTO `synth_recipes` VALUES (4421,0,0,0,0,0,0,0,51,102,0,4096,4238,657,719,821,1122,8704,0,0,0,21909,21910,21910,21910,1,1,1,1,'Yoshikiri'); -- yoshikiri
INSERT INTO `synth_recipes` VALUES (4422,0,0,0,0,0,0,51,0,102,0,4096,4238,655,657,719,821,1122,8704,0,0,21960,21961,21961,21961,1,1,1,1,'Ashijiro No Tachi'); -- ashijiro no tachi
INSERT INTO `synth_recipes` VALUES (4423,0,0,0,0,0,0,51,0,102,0,4096,4238,655,2536,8704,0,0,0,0,0,22015,22016,22016,22016,1,1,1,1,'Arasy Rod'); -- arasy rod
INSERT INTO `synth_recipes` VALUES (4424,0,0,0,0,0,0,51,0,102,0,4096,4238,654,655,2536,8704,0,0,0,0,22135,22136,22136,22136,1,1,1,1,'Arasy Gun'); -- arasy gun
INSERT INTO `synth_recipes` VALUES (4425,0,0,0,0,0,0,30,60,106,0,4096,4238,687,752,1279,2751,3548,0,0,0,10354,10359,10359,10359,1,1,1,1,'Hexed Sune-ate'); -- hexed sune-ate
INSERT INTO `synth_recipes` VALUES (4426,0,0,0,0,0,0,0,0,106,0,4096,4238,793,8724,8748,0,0,0,0,0,21556,21557,21557,21557,1,1,1,1,'Beryllium Kris'); -- beryllium kris
INSERT INTO `synth_recipes` VALUES (4427,0,0,0,0,0,0,0,0,106,0,4096,4238,8724,8724,8724,0,0,0,0,0,22023,22024,22024,22024,1,1,1,1,'Beryllium Mace'); -- beryllium mace
INSERT INTO `synth_recipes` VALUES (4428,0,0,0,0,0,0,0,0,106,0,4096,4238,3927,8724,0,0,0,0,0,0,21708,21709,21709,21709,1,1,1,1,'Beryllium Pick'); -- beryllium pick
INSERT INTO `synth_recipes` VALUES (4429,0,0,0,0,0,0,0,0,106,0,4096,4238,3927,8708,8724,8724,8724,0,0,0,21659,21660,21660,21660,1,1,1,1,'Beryllium Sword'); -- beryllium sword
INSERT INTO `synth_recipes` VALUES (4430,0,0,0,0,0,0,0,0,106,0,4096,4238,657,3927,4027,8708,8724,8724,8748,0,21963,21964,21964,21964,1,1,1,1,'Beryllium Tachi'); -- beryllium tachi
INSERT INTO `synth_recipes` VALUES (4431,0,0,0,0,0,0,0,0,106,0,4098,4240,652,8724,0,0,0,0,0,0,4083,4083,4083,4083,6,8,10,12,'Ber. Arrowheads'); -- beryllium arrowheads
INSERT INTO `synth_recipes` VALUES (4432,0,0,0,0,0,0,0,0,106,0,4098,4240,8724,0,0,0,0,0,0,0,4085,4085,4085,4085,6,8,10,12,'Ber. Bolt Heads'); -- beryllium bolt heads
INSERT INTO `synth_recipes` VALUES (4433,0,0,0,0,30,0,0,60,107,0,4096,4238,687,745,851,851,1279,1415,3548,0,10420,10425,10425,10425,1,1,1,1,'Hexed Somen'); -- hexed somen
INSERT INTO `synth_recipes` VALUES (4434,0,0,0,0,0,0,60,0,107,0,4098,4240,657,914,4095,0,0,0,0,0,22276,22276,22276,22277,33,66,99,99,'Sasuke Shuriken'); -- sasuke shuriken
INSERT INTO `synth_recipes` VALUES (4435,0,0,0,0,0,0,0,60,110,0,4096,4238,687,687,745,1279,1415,3548,0,0,10241,10246,10246,10246,1,1,1,1,'Hexed Domaru'); -- hexed domaru
INSERT INTO `synth_recipes` VALUES (4436,0,0,0,0,0,0,0,0,115,60,4096,4238,4077,4080,9246,16942,0,0,0,0,21656,21657,21657,21657,1,1,1,1,'Dyrnwyn'); -- dyrnwyn
INSERT INTO `synth_recipes` VALUES (4437,0,0,0,0,0,0,0,60,115,0,4096,4238,4077,4079,9254,17928,0,0,0,0,21706,21707,21707,21707,1,1,1,1,'Barbarity'); -- barbarity
INSERT INTO `synth_recipes` VALUES (4438,0,0,0,0,0,0,60,0,115,0,4099,4241,4077,4081,9250,17472,0,0,0,0,21506,21507,21507,21507,1,1,1,1,'Jolt Counter'); -- jolt counter
INSERT INTO `synth_recipes` VALUES (4439,0,0,0,0,60,0,0,0,115,0,4099,4241,4077,4082,9251,0,0,0,0,0,26034,26035,26035,26035,1,1,1,1,'Moonbeam Nodowa'); -- moonbeam nodata
INSERT INTO `synth_recipes` VALUES (4440,0,1997,0,0,60,0,0,0,115,0,4096,4238,752,3980,9006,9247,9247,9247,0,0,25960,25961,25961,25961,1,1,1,1,'Ea Pigaches'); -- ea pigaches
INSERT INTO `synth_recipes` VALUES (4441,0,1997,0,0,60,0,0,0,115,0,4096,4238,752,752,3980,9006,9247,9247,9247,0,25980,25981,25981,25981,1,1,1,1,'Ea Cuffs'); -- ea cuffs
INSERT INTO `synth_recipes` VALUES (4442,0,1997,0,0,60,0,0,0,115,0,4096,4238,752,761,3980,9006,9247,9247,9247,0,25553,25554,25554,25554,1,1,1,1,'Ea Hat'); -- ea hat
INSERT INTO `synth_recipes` VALUES (4443,0,1997,0,0,60,0,0,0,115,0,4096,4238,752,761,3980,9006,9247,9248,0,0,25893,25894,25894,25894,1,1,1,1,'Ea Slops'); -- ea slops
INSERT INTO `synth_recipes` VALUES (4444,0,1997,0,0,60,0,0,0,115,0,4096,4238,752,761,3980,9006,9006,9247,9248,0,26529,26530,26530,26530,1,1,1,1,'Ea Houppelande'); -- ea houppelande
INSERT INTO `synth_recipes` VALUES (4445,0,1997,0,0,0,0,0,0,115,0,4096,4238,4075,9248,16647,0,0,0,0,0,21710,21711,21711,21711,1,1,1,1,'Raetic Axe'); -- raetic axe
INSERT INTO `synth_recipes` VALUES (4446,0,1997,0,0,0,0,0,0,115,0,4096,4238,4076,9248,18206,0,0,0,0,0,21767,21768,21768,21768,1,1,1,1,'Raetic Chopper'); -- raetic chopper
INSERT INTO `synth_recipes` VALUES (4447,0,1997,0,0,0,0,0,0,115,0,4096,4238,4074,9248,17461,0,0,0,0,0,22025,22026,22026,22026,1,1,1,1,'Raetic Rod'); -- raetic rod
INSERT INTO `synth_recipes` VALUES (4448,0,0,0,0,0,0,0,0,116,0,4099,4241,3548,8748,9004,0,0,0,0,0,26337,26338,26338,26338,1,1,1,1,'Kwahu Kachina Belt'); -- kwahu kachina belt
INSERT INTO `synth_recipes` VALUES (4449,0,0,0,0,0,0,0,0,116,0,4096,4238,687,8724,9064,0,0,0,0,0,26179,26180,26180,26180,1,1,1,1,'Varar Ring'); -- varar ring
INSERT INTO `synth_recipes` VALUES (4450,0,0,0,0,0,0,0,0,0,41,4099,4241,819,829,2761,0,0,0,0,0,2970,2970,2970,2970,33,66,99,99,'Mokujin'); -- mokujin
INSERT INTO `synth_recipes` VALUES (4451,0,0,0,0,0,0,1,0,0,43,4099,4241,737,3729,0,0,0,0,0,0,3730,3730,3730,3730,1,1,1,1,'Bulky Coffer'); -- bulky coffer
INSERT INTO `synth_recipes` VALUES (4452,0,0,0,0,0,0,0,0,1,45,4099,4241,651,1022,2707,2708,4019,0,0,0,3590,3590,3590,3590,1,1,1,1,'Puce Chest'); -- puce chest
INSERT INTO `synth_recipes` VALUES (4453,0,0,0,0,0,0,0,0,0,48,4098,4240,884,2846,0,0,0,0,0,0,18606,18615,18615,18615,1,1,1,1,'Passaddhi Staff'); -- passaddhi staff
INSERT INTO `synth_recipes` VALUES (4454,0,0,0,0,1,0,0,0,0,50,4098,4240,649,718,825,825,834,834,17316,0,3696,3696,3696,3696,1,1,1,1,'Kotatsu Table'); -- kotatsu table
INSERT INTO `synth_recipes` VALUES (4455,0,0,1,0,0,0,0,0,0,52,4099,4241,732,937,4509,8918,0,0,0,0,8804,8804,8804,8804,33,66,99,99,'Furusumi'); -- furusumi
INSERT INTO `synth_recipes` VALUES (4456,0,0,1,0,0,0,1,0,0,53,4099,4241,737,2706,3729,0,0,0,0,0,3731,3731,3731,3731,1,1,1,1,'Azure Chest'); -- azure chest
INSERT INTO `synth_recipes` VALUES (4457,0,0,0,0,0,0,0,0,0,53,4099,4241,717,717,718,718,0,0,0,0,423,423,423,423,1,1,1,1,'Tavern Bench'); -- tavern bench
INSERT INTO `synth_recipes` VALUES (4458,0,0,52,0,0,0,0,0,0,54,4099,4241,771,1774,1817,2563,17868,0,0,0,363,363,363,363,1,1,1,1,'Amigo Cactus'); -- amigo cactus
INSERT INTO `synth_recipes` VALUES (4459,0,0,0,0,0,0,0,0,0,55,4098,4240,731,0,0,0,0,0,0,0,2643,2643,2643,2643,33,66,99,99,'Jinko'); -- jinko
INSERT INTO `synth_recipes` VALUES (4460,0,0,0,0,0,0,0,0,0,56,4099,4241,716,716,716,719,719,0,0,0,3609,3609,3609,3609,1,1,1,1,'Stepping Stool'); -- stepping stool
INSERT INTO `synth_recipes` VALUES (4461,0,0,0,0,0,0,0,0,0,60,4101,4243,769,1465,1774,2235,17868,0,0,0,3586,3586,3586,3586,1,1,1,1,'Red Viola Pot'); -- red viola
INSERT INTO `synth_recipes` VALUES (4462,0,0,0,0,0,0,0,0,0,60,4101,4243,770,1465,1774,2235,17868,0,0,0,3587,3587,3587,3587,1,1,1,1,'Blue Viola Pot'); -- blue viola
INSERT INTO `synth_recipes` VALUES (4463,0,0,0,0,0,0,0,0,0,60,4101,4243,771,1465,1774,2235,17868,0,0,0,3588,3588,3588,3588,1,1,1,1,'Yellow Viola Pot'); -- yellow viola
INSERT INTO `synth_recipes` VALUES (4464,0,0,0,0,0,0,0,0,0,60,4101,4243,776,1465,1774,2235,17868,0,0,0,3589,3589,3589,3589,1,1,1,1,'White Viola Pot'); -- white viola
INSERT INTO `synth_recipes` VALUES (4465,0,0,0,0,0,0,1,0,0,60,4099,4241,711,718,745,0,0,0,0,0,449,449,449,449,1,1,1,1,'Personal Table'); -- personal table
INSERT INTO `synth_recipes` VALUES (4466,0,0,0,0,0,0,1,0,0,61,4099,4241,711,711,718,745,0,0,0,0,448,448,448,448,1,1,1,1,'Gueridon'); -- gueridon
INSERT INTO `synth_recipes` VALUES (4467,0,0,0,0,0,0,0,0,0,62,4098,4240,798,2747,2762,0,0,0,0,0,18602,18602,18602,18602,1,1,1,1,'Fay Staff'); -- fay staff
INSERT INTO `synth_recipes` VALUES (4468,0,0,0,0,0,0,1,0,0,62,4099,4241,711,711,717,745,0,0,0,0,443,443,443,443,1,1,1,1,'Aureous Chest'); -- aureuous chest
INSERT INTO `synth_recipes` VALUES (4469,0,0,0,0,0,0,0,0,0,63,4098,4240,2749,2762,0,0,0,0,0,0,18601,18601,18601,18601,1,1,1,1,'Fay Crozier'); -- fay crozier
INSERT INTO `synth_recipes` VALUES (4470,0,0,0,0,0,0,0,0,0,64,4098,4240,717,902,2847,0,0,0,0,0,18611,18616,18616,18616,1,1,1,1,'Qi Staff'); -- qi staff
INSERT INTO `synth_recipes` VALUES (4471,0,0,0,0,0,0,1,0,0,64,4099,4241,718,719,745,0,0,0,0,0,437,437,437,437,1,1,1,1,'Floral Nightstand'); -- floral nightstand
INSERT INTO `synth_recipes` VALUES (4472,0,0,0,0,0,0,1,0,0,65,4099,4241,711,717,717,745,0,0,0,0,442,442,442,442,1,1,1,1,'Gilded Chest'); -- gilded chest
INSERT INTO `synth_recipes` VALUES (4473,0,0,0,0,0,0,0,0,0,66,4096,4238,654,654,715,2762,0,0,0,0,19303,19303,19303,19303,1,1,1,1,'Fay Lance'); -- fay lance
INSERT INTO `synth_recipes` VALUES (4474,0,0,0,0,0,0,1,0,0,66,4099,4241,711,711,711,718,745,0,0,0,447,447,447,447,1,1,1,1,'Mensa Lunata'); -- mensa lunata
INSERT INTO `synth_recipes` VALUES (4475,0,0,1,0,1,0,0,0,0,67,4099,4241,706,826,826,828,828,2476,2533,2712,410,410,410,410,1,1,1,1,'Red Round Table'); -- red round table
INSERT INTO `synth_recipes` VALUES (4476,0,0,1,0,1,0,0,0,0,67,4099,4241,706,826,826,828,828,2476,2533,2706,411,411,411,411,1,1,1,1,'Blue Round Table'); -- blue round table
INSERT INTO `synth_recipes` VALUES (4477,0,0,1,0,1,0,0,0,0,67,4099,4241,706,826,826,828,828,2476,2533,2707,412,412,412,412,1,1,1,1,'Green Rnd. Table'); -- green round table
INSERT INTO `synth_recipes` VALUES (4478,0,0,1,0,1,0,0,0,0,67,4099,4241,706,826,826,828,828,2476,2533,2708,413,413,413,413,1,1,1,1,'Yellow Rnd. Table'); -- yellow round table
INSERT INTO `synth_recipes` VALUES (4479,0,0,1,0,1,0,0,0,0,67,4099,4241,706,826,826,828,828,2476,2533,2709,414,414,414,414,1,1,1,1,'White Rnd. Table'); -- white round table
INSERT INTO `synth_recipes` VALUES (4480,0,0,0,0,0,0,0,0,0,67,4099,4241,719,719,719,719,0,0,0,0,427,427,427,427,1,1,1,1,'Rococo Table'); -- rococo table
INSERT INTO `synth_recipes` VALUES (4481,0,0,0,1,0,0,0,0,0,70,4098,4240,720,830,2513,2747,2762,0,0,0,18736,18736,18736,18736,1,1,1,1,'Fay Gendawa'); -- fay gendawa
INSERT INTO `synth_recipes` VALUES (4482,0,0,0,0,0,0,1,0,0,70,4099,4241,711,711,711,711,717,717,745,0,444,444,444,444,1,1,1,1,'Luxurious Chest'); -- luxurious chest
INSERT INTO `synth_recipes` VALUES (4483,0,0,0,0,0,0,1,0,0,96,4099,4241,711,711,711,745,1588,1588,1588,0,3591,3591,3591,3591,1,1,1,1,'Marbled Drawers'); -- marbled drawers
INSERT INTO `synth_recipes` VALUES (4484,0,0,0,0,0,0,1,0,0,73,4099,4241,711,711,711,711,717,717,745,745,446,446,446,446,1,1,1,1,'Gilded Shelf'); -- gilded shelf
INSERT INTO `synth_recipes` VALUES (4485,0,0,0,0,0,0,1,0,0,74,4099,4241,711,718,719,719,745,0,0,0,436,436,436,436,1,1,1,1,'Jeunoan Armoire'); -- jeunoan armoire
INSERT INTO `synth_recipes` VALUES (4486,0,0,0,0,0,0,1,0,0,74,4099,4241,711,711,718,719,719,719,719,745,435,435,435,435,1,1,1,1,'Jeunoan Dresser'); -- jeunoan dresser
INSERT INTO `synth_recipes` VALUES (4487,0,0,0,0,0,0,0,0,1,78,4099,4241,654,711,711,711,725,725,2533,2533,353,353,353,353,1,1,1,1,'Spence'); -- spence
INSERT INTO `synth_recipes` VALUES (4488,0,1986,0,0,0,0,0,0,0,80,4098,4240,692,692,692,1657,0,0,0,0,709,709,709,709,3,6,9,12,'Beech Lumber'); -- beech lumber
INSERT INTO `synth_recipes` VALUES (4489,0,0,0,0,0,0,0,0,0,80,4098,4240,692,0,0,0,0,0,0,0,709,709,709,709,1,2,3,4,'Beech Lumber'); -- beech lumber
INSERT INTO `synth_recipes` VALUES (4490,0,0,0,0,0,0,1,0,0,80,4099,4241,718,719,719,719,719,719,745,745,428,428,428,428,1,1,1,1,'Semainier'); -- semainier
INSERT INTO `synth_recipes` VALUES (4491,0,0,0,0,0,0,9,0,0,85,4099,4241,711,711,711,1836,1836,1836,0,0,354,354,354,354,1,1,1,1,'Bookstack'); -- bookstack
INSERT INTO `synth_recipes` VALUES (4492,0,0,0,0,0,0,29,0,0,87,4099,4241,745,2533,2533,2535,0,0,0,0,424,424,424,424,1,1,1,1,'Feasting Table'); -- feasting table
INSERT INTO `synth_recipes` VALUES (4493,0,0,0,0,40,0,0,0,0,88,4099,4241,711,717,2010,0,0,0,0,0,343,343,343,343,1,1,1,1,'Harp Stool'); -- harp stool
INSERT INTO `synth_recipes` VALUES (4494,0,0,0,0,0,0,0,0,0,88,4099,4241,717,717,717,717,717,717,0,0,352,352,352,352,1,1,1,1,'Half Partition'); -- half partition
INSERT INTO `synth_recipes` VALUES (4495,0,0,1,0,0,0,0,0,0,90,4096,4238,709,709,947,2533,0,0,0,0,295,295,295,295,1,1,1,1,'Bonfire'); -- bonfire
INSERT INTO `synth_recipes` VALUES (4496,0,0,0,0,60,0,0,0,0,90,4099,4241,720,725,2010,0,0,0,0,0,3678,3678,3678,3678,1,1,1,1,'Recital Bench'); -- recital bench
INSERT INTO `synth_recipes` VALUES (4497,0,0,0,0,0,0,0,0,0,95,4098,4240,3927,3932,0,0,0,0,0,0,21206,21207,21207,21207,1,1,1,1,'Hemolele Staff'); -- hemolele staff
INSERT INTO `synth_recipes` VALUES (4498,0,0,0,0,0,0,0,0,0,96,4096,4238,3919,3919,3927,3927,0,0,0,0,20969,20968,20968,20968,1,1,1,1,'Chanar Xyston'); -- chanar xyston
INSERT INTO `synth_recipes` VALUES (4499,0,0,0,1,0,0,0,0,0,96,4098,4240,824,927,3927,3927,3932,0,0,0,21243,21244,21244,21244,1,1,1,1,'Ahkormaar Bow'); -- ahkormaar bow
INSERT INTO `synth_recipes` VALUES (4500,0,0,0,1,0,0,0,0,1,96,4099,4241,757,893,932,3927,3927,0,0,0,21258,21259,21259,21259,1,1,1,1,'Malayo Crossbow'); -- malayo crossbow
INSERT INTO `synth_recipes` VALUES (4501,0,0,0,0,60,0,0,0,0,100,4098,4240,720,1462,2288,3550,0,0,0,0,19784,19785,19785,19785,1,1,1,1,'Lanner Bow'); -- lanner bow
INSERT INTO `synth_recipes` VALUES (4502,0,0,0,0,0,0,60,0,0,102,4096,4238,786,3923,4019,0,0,0,0,0,21865,21866,21866,21866,1,1,1,1,'Arasy Lance'); -- arasy lance
INSERT INTO `synth_recipes` VALUES (4503,0,0,60,0,0,0,0,0,0,102,4098,4240,932,933,4019,4028,0,0,0,0,22122,22123,22123,22123,1,1,1,1,'Arasy Bow'); -- arasy bow
INSERT INTO `synth_recipes` VALUES (4504,0,0,0,60,0,0,0,0,0,102,4098,4240,4019,8709,0,0,0,0,0,0,22074,22075,22075,22075,1,1,1,1,'Arasy Staff'); -- arasy staff
INSERT INTO `synth_recipes` VALUES (4505,0,0,0,0,60,0,60,0,0,104,4096,4238,653,746,747,786,1999,2533,2535,2535,331,331,331,331,1,1,1,1,'Winged Altar'); -- winged altar
INSERT INTO `synth_recipes` VALUES (4506,0,0,0,0,0,0,0,0,0,105,4099,4241,723,8726,8726,9075,21392,0,0,0,21456,21457,21457,21457,1,1,1,1,'Animator P'); -- animator p
INSERT INTO `synth_recipes` VALUES (4507,0,0,0,0,0,0,0,0,0,105,4099,4241,723,933,8726,8726,9075,21392,0,0,21458,21459,21459,21459,1,1,1,1,'Animator P Ii'); -- animator p ii
INSERT INTO `synth_recipes` VALUES (4508,0,0,0,0,0,0,0,0,0,106,4098,4240,4027,8704,8726,0,0,0,0,0,22137,22138,22138,22138,1,1,1,1,'Exalted C.bow'); -- exalted crossbow
INSERT INTO `synth_recipes` VALUES (4509,0,0,0,0,0,0,0,0,0,106,4098,4240,4027,8726,8748,0,0,0,0,0,21869,21870,21870,21870,1,1,1,1,'Exalted Spear'); -- exalted spear
INSERT INTO `synth_recipes` VALUES (4510,0,0,0,0,0,0,0,0,0,106,4098,4240,8726,8726,0,0,0,0,0,0,22078,22079,22079,22079,1,1,1,1,'Exalted Staff'); -- exalted staff
INSERT INTO `synth_recipes` VALUES (4511,0,0,0,0,60,0,0,0,0,115,4099,4241,4078,4080,9252,17528,0,0,0,0,22076,22077,22077,22077,1,1,1,1,'Was'); -- was
INSERT INTO `synth_recipes` VALUES (4512,0,0,0,0,60,0,0,0,0,115,4099,4241,4080,4081,9250,17073,0,0,0,0,22021,22022,22022,22022,1,1,1,1,'Ames'); -- ames
INSERT INTO `synth_recipes` VALUES (4513,0,1989,60,0,0,0,0,0,0,115,4099,4241,821,8754,9007,9246,9246,0,0,0,25958,25959,25959,25959,1,1,1,1,'Ken. Sune-ate'); -- kendatsuba sune-ate
INSERT INTO `synth_recipes` VALUES (4514,0,1989,60,0,0,0,0,0,0,115,4099,4241,821,821,8754,9007,9246,9246,0,0,25978,25979,25979,25979,1,1,1,1,'Ken. Tekko'); -- kendatsuba tekko
INSERT INTO `synth_recipes` VALUES (4515,0,1989,60,0,0,0,0,0,0,115,4099,4241,821,830,8754,9007,9246,9246,0,0,25551,25552,25552,25552,1,1,1,1,'Ken. Jinpachi'); -- kendatsuba jinpachi
INSERT INTO `synth_recipes` VALUES (4516,0,1989,60,0,0,0,0,0,0,115,4099,4241,821,830,8754,9007,9246,9246,9246,0,25891,25892,25892,25892,1,1,1,1,'Ken. Hakama'); -- kendatsuba hakama
INSERT INTO `synth_recipes` VALUES (4517,0,1989,60,0,0,0,0,0,0,115,4099,4241,821,830,8754,9007,9007,9246,9246,9246,26527,26528,26528,26528,1,1,1,1,'Ken. Samue'); -- kendatsuba samue
INSERT INTO `synth_recipes` VALUES (4518,0,1989,0,0,0,0,0,60,0,115,4099,4241,752,4013,9003,9246,9246,0,0,0,25956,25957,25957,25957,1,1,1,1,'Oshosi Leggings'); -- oshosi leggings
INSERT INTO `synth_recipes` VALUES (4519,0,1989,0,0,0,0,0,60,0,115,4099,4241,752,752,4013,9003,9246,9246,0,0,25976,25977,25977,25977,1,1,1,1,'Oshosi Gloves'); -- oshosi gloves
INSERT INTO `synth_recipes` VALUES (4520,0,1989,0,0,0,0,0,60,0,115,4099,4241,752,761,4013,9003,9246,9246,0,0,25549,25550,25550,25550,1,1,1,1,'Oshosi Mask'); -- oshosi mask
INSERT INTO `synth_recipes` VALUES (4521,0,1989,0,0,0,0,0,60,0,115,4099,4241,752,761,4013,9003,9246,9246,9246,0,25889,25890,25890,25890,1,1,1,1,'Oshosi Trousers'); -- oshosi trousers
INSERT INTO `synth_recipes` VALUES (4522,0,1989,0,0,0,0,0,60,0,115,4099,4241,752,761,4013,9003,9003,9246,9246,9246,26525,26526,26526,26526,1,1,1,1,'Oshosi Vest'); -- oshosi vest
INSERT INTO `synth_recipes` VALUES (4523,0,1989,0,0,0,0,0,0,0,115,4096,4238,4074,9246,9246,9246,17158,0,0,0,22127,22128,22128,22128,1,1,1,1,'Raetic Bow'); -- raetic bow
INSERT INTO `synth_recipes` VALUES (4524,0,1989,0,0,0,0,0,0,0,115,4096,4238,4075,9246,9246,9246,18084,0,0,0,21871,21872,21872,21872,1,1,1,1,'Raetic Halberd'); -- raetic halberd
INSERT INTO `synth_recipes` VALUES (4525,0,1989,0,0,0,0,0,0,0,115,4096,4238,4076,9246,9246,9246,17093,0,0,0,22080,22081,22081,22081,1,1,1,1,'Raetic Staff'); -- raetic staff
INSERT INTO `synth_recipes` VALUES (4526,0,1989,0,0,0,0,0,0,0,115,4096,4238,4074,9246,9246,9246,9247,17333,17333,17333,21310,21310,21310,21310,33,66,99,99,'Raetic Arrow'); -- raetic arrow
INSERT INTO `synth_recipes` VALUES (4527,0,0,5,0,0,0,0,0,0,0,4103,4245,8889,0,0,0,0,0,0,0,929,929,929,929,2,2,2,2,'Black Ink'); -- black ink
INSERT INTO `synth_recipes` VALUES (4528,0,0,15,0,0,0,0,0,0,0,4099,4241,8891,0,0,0,0,0,0,0,4167,4167,4167,4167,33,33,33,33,'Cracker'); -- cracker
INSERT INTO `synth_recipes` VALUES (4529,0,0,45,0,0,0,0,0,0,0,4100,4242,8897,0,0,0,0,0,0,0,932,932,932,932,3,3,3,3,'Carbon Fiber'); -- carbon fiber
INSERT INTO `synth_recipes` VALUES (4530,1,0,0,0,0,0,0,0,73,0,4100,4242,16652,0,0,0,0,0,0,0,707,707,654,654,1,1,1,1,'Elm Lumber'); -- Darksteel Pick (desynth)
INSERT INTO `synth_recipes` VALUES (4531,1,0,0,0,90,0,0,0,0,0,4100,4242,13208,0,0,0,0,0,0,0,823,821,821,821,1,1,2,3,'Gold Thread'); -- Rainbow Obi (desynth)
INSERT INTO `synth_recipes` VALUES (4532,1,0,0,0,0,0,0,33,0,0,4100,4242,13571,0,0,0,0,0,0,0,858,858,820,820,1,1,1,1,'Wolf Hide'); -- Wolf Mantle (desynth)
INSERT INTO `synth_recipes` VALUES (4533,1,0,0,0,46,0,0,0,0,0,4100,4242,12723,0,0,0,0,0,0,0,834,820,820,820,2,5,6,7,'Saruta Cotton'); -- Wool Bracers (desynth)
INSERT INTO `synth_recipes` VALUES (4534,1,0,0,0,0,0,31,0,0,0,4100,4242,18868,0,0,0,0,0,0,0,650,650,650,650,1,1,1,1,'Brass Ingot'); -- Lady Bell (desynth)
INSERT INTO `synth_recipes` VALUES (4535,1,0,0,0,0,0,85,0,0,0,4100,4242,13356,0,0,0,0,0,0,0,746,812,812,812,1,1,1,1,'Platinum Ingot'); -- Death Earring (desynth)
INSERT INTO `synth_recipes` VALUES (4536,1,0,0,0,19,0,0,0,0,0,4100,4242,12849,0,0,0,0,0,0,0,850,818,818,818,1,5,6,7,'Sheep Leather'); -- Cotton Brais (desynth)
INSERT INTO `synth_recipes` VALUES (4537,1,0,0,0,0,0,0,0,100,0,4100,4242,17252,0,0,0,0,0,0,0,1231,717,654,655,1,1,1,1,'Brass Nugget'); -- Culverin (desynth)
INSERT INTO `synth_recipes` VALUES (4538,1,0,0,67,0,0,0,0,0,0,4100,4242,12838,0,0,0,0,0,0,0,826,851,896,896,1,1,1,1,'Linen Cloth'); -- Scorpion Subligar (desynth)
INSERT INTO `synth_recipes` VALUES (4539,1,0,0,0,0,0,99,0,0,0,4100,4242,15771,0,0,0,0,0,0,0,747,747,2275,2275,1,1,1,1,'Ocl. Ingot'); -- Shining Ring (desynth)
INSERT INTO `synth_recipes` VALUES (4540,0,2045,0,0,0,117,0,0,0,0,4096,4238,2110,4509,5134,5233,5234,5236,5237,5680,5893,5894,5894,5894,1,1,1,1,'Marine Stewpot'); -- Marine Stewpot (117 cooking) https://www.bg-wiki.com/bg/Marine_Stewpot
INSERT INTO `synth_recipes` VALUES (4541,1,0,0,0,0,0,85,0,0,0,4100,4242,13354,0,0,0,0,0,0,0,804,804,746,746,1,1,1,2,'Spinel'); -- Spinel Earring (desynth)
INSERT INTO `synth_recipes` VALUES (4542,1,0,0,0,0,0,0,0,0,41,4100,4242,17142,0,0,0,0,0,0,0,716,716,716,716,1,1,1,1,'Oak Lumber'); -- Oak Cudgel +1 (desynth)
INSERT INTO `synth_recipes` VALUES (4543,1,0,0,0,0,0,93,0,0,0,4100,4242,13466,0,0,0,0,0,0,0,747,747,747,747,1,1,2,2,'Ocl. Ingot'); -- Orichalcum Ring (desynth)
INSERT INTO `synth_recipes` VALUES (4544,1,0,0,0,0,0,93,0,0,0,4100,4242,14616,0,0,0,0,0,0,0,747,747,747,747,1,1,2,2,'Ocl. Ingot'); -- Triton Ring (desynth)
INSERT INTO `synth_recipes` VALUES (4545,1,0,0,99,0,0,0,0,0,0,4100,4242,13467,0,0,0,0,0,0,0,903,903,903,903,1,1,1,1,'Dragon Talon'); -- Dragon Ring (desynth)
INSERT INTO `synth_recipes` VALUES (4546,1,0,0,0,0,0,0,63,0,0,4100,4242,19017,0,0,0,0,0,0,0,1637,1637,1637,1637,1,1,1,1,'Bugard Leather'); -- Bugard Strap (desynth)
INSERT INTO `synth_recipes` VALUES (4547,1,0,0,0,0,0,0,63,0,0,4100,4242,19018,0,0,0,0,0,0,0,1637,1637,1637,1637,1,1,1,1,'Bugard Leather'); -- Bugard Strap +1 (desynth)
INSERT INTO `synth_recipes` VALUES (4548,0,0,0,0,0,0,0,0,24,0,4096,4238,651,712,0,0,0,0,0,0,21923,21924,21924,21924,1,1,1,1,'Debahocho'); -- Debahocho https://www.bg-wiki.com/bg/Debahocho
INSERT INTO `synth_recipes` VALUES (4549,0,2038,1,0,0,0,0,0,0,0,4101,4243,888,1893,4509,4509,0,0,0,0,2952,2952,2952,2952,2,3,4,5, 'Miasmal Counteragent');
INSERT INTO `synth_recipes` VALUES (4550,0,0,25,0,0,0,0,0,10,0,4096,4238,813,1836,1886,2475,2475,2709,0,0,3699,3699,3699,3699,1,1,1,1, 'Bathtub');
INSERT INTO `synth_recipes` VALUES (4551,0,0,0,0,58,0,9,0,0,0,4099,4241,822,827,827,828,828,2826,0,0,11340,11348,11348,11348,1,1,1,1, 'Salutary Robe');
INSERT INTO `synth_recipes` VALUES (4552,0,0,0,0,97,0,0,60,0,0,4099,4241,2275,2756,2825,2825,0,0,0,0,12141,12141,12141,12141,1,1,1,1, 'Ebon Beret');
INSERT INTO `synth_recipes` VALUES (4553,0,2002,25,0,0,0,55,0,0,0,4096,4238,637,663,933,2308,2311,0,0,0,9229,9229,9229,9229,12,12,12,12, 'Speedloader');
INSERT INTO `synth_recipes` VALUES (4554,0,2002,25,0,0,0,60,0,0,0,4096,4238,637,752,933,2308,2311,0,0,0,9230,9230,9230,9230,12,12,12,12, 'Speedloader II');
INSERT INTO `synth_recipes` VALUES (4555,0,2037,49,0,0,0,14,0,0,0,4096,4238,752,2154,2301,2310,2460,0,0,0,9032,9032,9032,9032,12,12,12,12,'Strobe II');
INSERT INTO `synth_recipes` VALUES (4556,0,2037,73,0,0,0,55,0,0,0,4096,4238,754,1886,2309,2310,2362,0,0,0,9069,9069,9069,9069,12,12,12,12,'Dynamo II');
INSERT INTO `synth_recipes` VALUES (4557,0,2037,54,0,0,0,15,0,0,0,4096,4238,914,932,1647,1887,2310,0,0,0,9072,9072,9072,9072,12,12,12,12,'Arcanic Cell');
INSERT INTO `synth_recipes` VALUES (4558,0,2037,59,0,0,0,25,0,0,0,4096,4238,914,932,1647,2310,2460,0,0,0,9073,9073,9073,9073,12,12,12,12,'Arcanic Cell II');
INSERT INTO `synth_recipes` VALUES (4559,1,0,0,0,0,0,15,0,0,0,4100,4242,16769,0,0,0,0,0,0,0,817,715,650,649,3,1,1,2,'Grass Thread'); -- Brass Zaghnal (desynth)
INSERT INTO `synth_recipes` VALUES (4560,1,0,0,0,45,0,0,0,0,0,4100,4242,12467,0,0,0,0,0,0,0,840,820,820,820,1,5,6,7,'Chocobo Feather'); -- Wool Cap (desynth)
INSERT INTO `synth_recipes` VALUES (4561,1,0,0,0,0,0,0,0,0,66,4100,4242,17054,0,0,0,0,0,0,0,719,842,842,842,1,1,1,1,'Ebony Lumber'); -- Ebony Wand (desynth)
INSERT INTO `synth_recipes` VALUES (4562,1,0,0,0,0,0,0,0,87,0,4100,4242,17286,0,0,0,0,0,0,0,914,1225,1225,657,1,4,6,1,'Mercury'); -- Rising Sun (desynth)
INSERT INTO `synth_recipes` VALUES (4563,1,0,0,0,0,0,0,53,0,0,4100,4242,19015,0,0,0,0,0,0,0,853,853,853,853,1,1,2,2,'Raptor Skin'); -- Raptor Strap (desynth)
INSERT INTO `synth_recipes` VALUES (4564,1,0,0,0,0,0,0,53,0,0,4100,4242,19016,0,0,0,0,0,0,0,853,853,853,853,1,1,2,2,'Raptor Skin'); -- Raptor Strap +1 (desynth)
INSERT INTO `synth_recipes` VALUES (4565,1,0,0,0,0,0,0,0,33,0,4100,4242,16966,0,0,0,0,0,0,0,852,818,651,657,1,1,1,1,'Lizard Skin'); -- Tachi (desynth)
INSERT INTO `synth_recipes` VALUES (4566,1,0,0,0,0,0,0,0,33,0,4100,4242,16981,0,0,0,0,0,0,0,852,818,651,657,1,1,1,1,'Lizard Skin'); -- Tachi +1 (desynth)
INSERT INTO `synth_recipes` VALUES (4567,0,0,0,0,93,0,0,0,0,0,4098,4240,843,843,0,0,0,0,0,0,1417,1417,1417,1417,6,8,10,12,'Giant Bird Fletchings'); -- giant bird fletchings
INSERT INTO `synth_recipes` VALUES (4568,0,2011,0,0,93,0,0,0,0,0,4098,4240,843,843,843,843,843,843,2145,0,1417,1417,1417,1417,18,24,30,36,'Giant Bird Fletchings'); -- giant bird fletchings
INSERT INTO `synth_recipes` VALUES (4569,1,0,0,0,0,0,95,0,0,0,4100,4242,13448,0,0,0,0,0,0,0,746,746,746,785,1,1,2,1,'Platinum Ingot'); -- Emerald Ring (desynth)
INSERT INTO `synth_recipes` VALUES (4570,1,0,0,0,0,0,95,0,0,0,4100,4242,13449,0,0,0,0,0,0,0,746,746,746,786,1,1,2,1,'Platinum Ingot'); -- Ruby Ring (desynth)
INSERT INTO `synth_recipes` VALUES (4571,1,0,0,0,0,0,95,0,0,0,4100,4242,13450,0,0,0,0,0,0,0,746,746,746,787,1,1,2,1,'Platinum Ingot'); -- Diamond Ring (desynth)
INSERT INTO `synth_recipes` VALUES (4572,1,0,0,0,0,0,95,0,0,0,4100,4242,13451,0,0,0,0,0,0,0,746,746,746,804,1,1,2,1,'Platinum Ingot'); -- Spinel Ring (desynth)
INSERT INTO `synth_recipes` VALUES (4573,1,0,0,0,0,0,95,0,0,0,4100,4242,13452,0,0,0,0,0,0,0,746,746,746,794,1,1,2,1,'Platinum Ingot'); -- Sapphire Ring (desynth)
INSERT INTO `synth_recipes` VALUES (4574,1,0,0,0,0,0,95,0,0,0,4100,4242,13453,0,0,0,0,0,0,0,746,746,746,789,1,1,2,1,'Platinum Ingot'); -- Topaz Ring (desynth)
INSERT INTO `synth_recipes` VALUES (4575,1,0,0,0,0,0,95,0,0,0,4100,4242,13462,0,0,0,0,0,0,0,746,746,746,812,1,1,2,1,'Platinum Ingot'); -- Death Ring (desynth)
INSERT INTO `synth_recipes` VALUES (4576,1,0,0,0,0,0,95,0,0,0,4100,4242,13463,0,0,0,0,0,0,0,746,746,746,813,1,1,2,1,'Platinum Ingot'); -- Angels Ring (desynth)

-- INSERT INTO `synth_recipes` VALUES (ID,Desynth,KeyItem,AL,BO,CL,CK,GO,LE,SM,WD,Crystal,HQCrystal,I1,I2,I3,I4,I5,I6,I7,I8,R1,R2,R3,R4,Q1,Q2,Q3,Q4,ResultName); -- template
-- crystals = fire(4096,4238) ice(4097,4239) wind(4098,4240) earth(4099,4241) lightning(4100,4242) water(4101,4243) light(4102,4244) dark(4103,4245)

/*!40000 ALTER TABLE `synth_recipes` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-09-05 12:20:09
