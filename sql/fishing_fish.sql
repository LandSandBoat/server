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
-- Table structure for table `fishing_fish`
--

DROP TABLE IF EXISTS `fishing_fish`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fishing_fish` (
  `fishid` int(10) unsigned NOT NULL,
  `name` varchar(64) NOT NULL,
  `skill_level` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `difficulty` tinyint(3) unsigned NOT NULL,
  `base_delay` tinyint(2) unsigned NOT NULL,
  `base_move` tinyint(2) unsigned NOT NULL,
  `min_length` smallint(5) unsigned NOT NULL DEFAULT '1',
  `max_length` smallint(5) unsigned NOT NULL DEFAULT '1',
  `ranking` smallint(5) unsigned NOT NULL,
  `size_type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `water_type` tinyint(2) unsigned NOT NULL,
  `log` tinyint(3) unsigned NOT NULL DEFAULT '255',
  `quest` tinyint(3) unsigned NOT NULL DEFAULT '255',
  `quest_status` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `flags` int(11) unsigned NOT NULL DEFAULT '0',
  `hour_pattern` tinyint(3) unsigned NOT NULL,
  `moon_pattern` tinyint(3) unsigned NOT NULL,
  `month_pattern` tinyint(3) unsigned NOT NULL,
  `legendary` int(2) unsigned NOT NULL DEFAULT '0',
  `legendary_flags` int(11) unsigned NOT NULL DEFAULT '0',
  `item` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `max_hook` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `rarity` smallint(5) unsigned NOT NULL DEFAULT '0',
  `required_keyitem` smallint(5) unsigned NOT NULL,
  `required_catches` blob NOT NULL,
  `family` int(11) unsigned NOT NULL,
  `quest_only` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `contest` tinyint(2) NOT NULL DEFAULT '0',
  `disabled` tinyint(2) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`fishid`)
) ENGINE=Aria TRANSACTIONAL=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci AVG_ROW_LENGTH=23;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fishing_fish`
--

LOCK TABLES `fishing_fish` WRITE;
/*!40000 ALTER TABLE `fishing_fish` DISABLE KEYS */;
INSERT INTO `fishing_fish` VALUES (5476,'Abaia',150,37,7,13,269,317,34,1,0,255,255,0,0,0,0,0,1,0,0,1,500,0,'',0,0,0,1);
INSERT INTO `fishing_fish` VALUES (5455,'Ahtapot',90,31,8,7,55,145,25,1,0,255,255,0,0,3,1,4,0,0,0,1,500,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (5461,'Alabaligi',37,16,5,11,1,1,15,0,0,255,255,0,0,3,1,10,0,0,0,1,1000,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (4316,'Armored Pisces',108,22,9,12,50,125,19,1,0,255,255,0,0,3,1,0,0,0,0,1,350,0,'',0,0,1,0);
INSERT INTO `fishing_fish` VALUES (688,'Arrowwood Log',4,18,13,2,1,3,18,1,0,255,255,0,0,2,2,0,0,0,1,1,500,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (4461,'Bastore Bream',86,31,7,9,1,1,22,0,0,255,255,0,0,3,1,0,0,0,0,1,250,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (4360,'Bastore Sardine',9,21,11,6,1,1,10,0,0,255,255,0,1,2,2,3,0,0,0,3,500,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (5473,'Bastore Sweeper',12,17,4,2,1,1,99,0,0,255,255,0,0,0,2,3,0,0,0,1,950,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (5139,'Betta',68,16,3,12,1,1,10,0,0,255,255,0,0,7,4,9,0,0,0,1,600,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (4479,'Bhefhel Marlin',61,20,10,11,60,140,23,1,0,255,255,0,0,7,1,8,0,0,0,1,700,0,'',0,0,1,0);
INSERT INTO `fishing_fish` VALUES (4318,'Bibiki Urchin',3,20,13,1,1,1,1,0,1,255,255,0,0,3,1,1,0,0,0,1,50,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (4314,'Bibikibo',8,22,12,3,1,1,1,0,1,255,255,0,0,5,2,2,0,0,0,1,100,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (4429,'Black Eel',47,24,5,8,1,1,15,0,0,255,255,0,0,4,4,3,0,0,0,1,800,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (5138,'Black Ghost',88,36,9,11,1,1,18,0,0,255,255,0,0,1,1,8,0,0,0,1,450,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (4384,'Black Sole',96,33,5,11,1,1,23,0,0,255,255,0,0,4,1,0,0,0,0,1,150,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (4471,'Bladefish',71,21,6,12,40,120,23,1,0,255,255,0,0,3,4,4,0,0,0,1,750,0,'',0,0,1,0);
INSERT INTO `fishing_fish` VALUES (4313,'Blindfish',28,18,6,8,1,1,18,0,0,255,255,0,0,7,2,8,0,0,0,1,750,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (4399,'Bluetail',55,24,4,12,1,1,14,0,0,255,255,0,0,3,1,3,0,0,0,1,650,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (5469,'Brass Loach',42,27,11,7,1,1,99,0,0,255,255,0,0,0,5,8,0,0,0,1,750,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (5474,'Ca Cuong',78,17,12,6,1,1,99,0,0,255,255,0,0,0,0,0,0,0,0,1,500,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (5465,'Caedarva Frog',30,17,6,13,1,1,5,0,0,255,255,0,0,4,2,0,0,0,0,1,1000,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (4309,'Cave Cherax',130,36,7,4,115,235,32,1,0,255,255,0,0,3,1,0,1,0,0,1,500,0,'',0,0,1,0);
INSERT INTO `fishing_fish` VALUES (4379,'Cheval Salmon',21,21,7,7,1,1,17,0,0,255,255,0,0,3,1,0,0,0,0,1,1000,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (4443,'Cobalt Jellyfish',5,28,13,0,1,1,14,0,0,255,255,0,0,1,1,0,0,0,1,1,700,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (5128,'Cone Calamary',48,40,10,5,1,1,10,0,0,255,255,0,1,3,1,3,0,0,0,3,850,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (4515,'Copper Frog',16,22,8,4,1,1,9,0,0,255,255,0,0,4,1,0,0,0,0,1,1000,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (13454,'Copper ring',24,40,13,2,1,1,5,0,0,255,255,0,1,0,0,0,0,0,1,1,800,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (4580,'Coral Butterfly',40,26,10,8,1,1,19,0,0,255,255,0,0,3,3,8,0,0,0,1,900,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (887,'Coral Fragment',74,47,13,2,1,1,5,0,0,255,255,0,1,7,1,0,0,0,1,1,200,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (4472,'Crayfish',7,24,13,6,1,1,8,0,0,255,255,0,0,2,2,0,0,0,0,1,1000,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (4473,'Crescent Fish',69,28,7,8,1,1,13,0,0,255,255,0,0,0,4,3,0,0,0,1,450,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (4528,'Crystal Bass',35,24,7,12,1,1,17,0,0,255,255,0,0,3,2,7,0,0,0,1,1000,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (1210,'Damp Scroll',20,35,13,2,1,1,1,0,0,255,255,0,0,1,2,0,0,0,1,1,1000,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (4428,'Dark Bass',33,23,7,8,1,1,13,0,0,255,255,0,0,3,1,9,0,0,0,1,1000,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (5447,'Denizanasi',5,28,13,0,1,1,14,0,0,255,255,0,0,1,1,0,0,0,1,1,700,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (5457,'Dil',96,33,5,11,1,1,23,0,0,255,255,0,0,4,1,0,0,0,0,1,150,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (4290,'Elshimo Frog',30,25,6,13,1,1,5,0,0,255,255,0,0,4,1,4,0,0,0,1,1000,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (4579,'Elshimo Newt',60,26,8,11,1,1,19,0,0,255,255,0,0,0,1,1,0,0,0,1,900,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (4454,'Emperor Fish',91,36,4,13,60,180,23,1,0,255,255,0,0,3,1,8,0,0,0,1,100,0,'',0,0,1,0);
INSERT INTO `fishing_fish` VALUES (4501,'Fat Greedie',24,30,10,8,1,1,11,0,1,255,255,0,0,1,4,4,0,0,0,1,1000,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (12316,'Fish Scale Shield',7,15,13,2,1,1,13,0,0,255,255,0,0,0,0,0,0,0,1,1,500,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (4289,'Forest Carp',20,11,9,11,1,1,14,0,0,255,255,0,0,3,2,1,0,0,0,1,1000,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (5472,'Garpike',83,24,3,10,1,1,99,0,0,255,255,0,0,0,4,4,0,0,0,1,1000,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (4477,'Gavial Fish',81,30,14,15,40,130,23,1,0,255,255,0,0,3,4,4,0,0,0,1,400,0,'',0,0,1,0);
INSERT INTO `fishing_fish` VALUES (5471,'Gerrothorax',134,29,7,8,210,250,30,1,0,255,255,0,0,0,2,9,1,0,0,1,500,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (4469,'Giant Catfish',31,13,6,12,40,130,19,1,0,255,255,0,0,4,1,6,0,0,0,1,900,0,'',0,0,1,0);
INSERT INTO `fishing_fish` VALUES (4308,'Giant Chirai',110,25,4,15,75,170,27,1,0,255,255,0,0,3,1,0,1,0,0,1,500,0,'',0,0,1,0);
INSERT INTO `fishing_fish` VALUES (4306,'Giant Donko',50,17,14,8,45,150,23,1,0,255,255,0,0,3,5,4,0,0,0,1,900,0,'',0,0,1,0);
INSERT INTO `fishing_fish` VALUES (5475,'Gigant Octopus',80,18,6,9,65,170,99,1,0,255,255,0,0,0,0,0,0,0,0,1,1000,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (4474,'Gigant Squid',91,43,7,13,80,170,23,1,0,255,255,0,0,3,1,4,0,0,0,1,100,0,'',0,0,1,0);
INSERT INTO `fishing_fish` VALUES (4427,'Gold Carp',56,18,10,14,1,1,14,0,0,255,255,0,0,3,1,8,0,0,0,1,750,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (4383,'Gold Lobster',46,35,4,3,1,1,14,0,0,255,255,0,1,3,1,0,0,0,0,1,800,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (4500,'Greedie',14,10,7,14,1,1,10,0,1,255,255,0,0,1,3,7,0,0,0,1,1000,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (4304,'Grimmonite',90,31,8,7,55,145,25,1,0,255,255,0,0,3,1,4,0,0,0,1,450,0,'',0,0,1,0);
INSERT INTO `fishing_fish` VALUES (4480,'Gugru Tuna',41,16,6,13,40,120,22,1,1,255,255,0,16,1,1,0,0,0,0,1,850,0,'',0,0,1,0);
INSERT INTO `fishing_fish` VALUES (5127,'Gugrusaurus',140,39,6,5,145,425,33,1,1,255,255,0,0,3,1,4,1,7,0,1,350,1977,'',0,0,1,0);
INSERT INTO `fishing_fish` VALUES (5132,'Gurnard',26,13,11,9,1,1,5,0,0,255,255,0,0,6,4,3,0,0,0,1,550,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (5449,'Hamsi',9,21,11,6,1,1,10,0,0,255,255,0,1,7,1,6,0,0,0,3,1000,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (2341,'Hydrogauge',7,25,13,2,1,1,1,0,0,6,25,0,0,0,0,0,0,0,1,1,1000,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (4470,'Icefish',49,38,11,7,1,1,14,0,0,255,255,0,0,3,1,3,0,0,0,3,900,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (5453,'Istakoz',46,35,4,3,1,1,14,0,0,255,255,0,0,3,1,3,0,0,0,1,1000,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (5136,'Istavrit',37,13,11,5,10,20,16,1,0,255,255,0,0,1,2,6,0,0,0,1,1000,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (5456,'Istiridye',53,27,13,2,1,1,14,0,0,255,255,0,1,3,2,4,0,0,0,1,850,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (4307,'Jungle Catfish',80,26,9,11,40,110,23,1,0,255,255,0,0,4,1,6,0,0,0,1,500,0,'',0,0,1,0);
INSERT INTO `fishing_fish` VALUES (5448,'Kalamar',48,40,10,5,1,1,10,0,0,255,255,0,1,3,1,3,0,0,0,3,850,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (5140,'Kalkanbaligi',105,19,6,12,60,120,27,1,1,255,255,0,16,3,5,8,1,0,0,1,500,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (5464,'Kaplumbaga',53,28,8,5,1,1,11,0,0,255,255,0,0,0,5,4,0,0,0,1,800,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (5460,'Kayabaligi',75,30,7,8,1,1,10,0,0,255,255,0,0,3,1,2,0,0,0,1,650,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (5451,'Kilicbaligi',62,18,10,11,1,1,23,1,0,255,255,0,0,7,1,8,0,0,0,1,800,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (5450,'Lakerda',41,16,6,13,55,100,22,1,0,255,255,0,0,1,4,0,0,0,0,1,900,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (2216,'Lamp Marimo',3,26,13,2,1,1,1,0,0,255,255,0,0,6,2,5,0,0,0,1,1000,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (5129,'Lik',140,48,2,14,185,465,33,1,0,255,255,0,0,3,1,6,1,8,0,1,850,1977,'',0,0,1,0);
INSERT INTO `fishing_fish` VALUES (4315,'Lungfish',32,16,4,8,1,1,10,0,0,255,255,0,0,1,1,8,0,0,0,1,1000,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (5468,'Matsya',150,31,5,12,163,331,99,1,0,255,255,0,0,0,1,0,1,0,0,1,500,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (5467,'Megalodon',87,33,10,11,446,625,99,1,0,255,255,0,0,0,0,0,0,0,0,1,1000,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (5454,'Mercanbaligi',86,31,7,9,1,1,22,0,0,255,255,0,0,3,1,0,0,0,0,1,400,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (4401,'Moat Carp',11,16,10,9,1,1,7,0,0,255,255,0,0,3,1,0,0,0,0,1,1000,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (1638,'Moblin Mask',54,44,13,2,1,1,5,0,0,255,255,0,0,0,0,0,0,0,1,1,800,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (5134,'Mola Mola',135,16,12,12,110,200,30,1,1,255,255,0,16,1,5,8,1,0,0,1,500,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (4462,'Monke-Onke',51,17,11,9,45,115,18,1,0,255,255,0,0,3,1,4,0,0,0,1,550,0,'',0,0,1,0);
INSERT INTO `fishing_fish` VALUES (5121,'Moorish Idol',26,18,6,11,1,1,9,0,1,255,255,0,0,3,2,4,0,0,0,1,700,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (5462,'Morinabaligi',94,36,4,13,1,1,23,0,0,255,255,0,0,3,1,8,0,0,0,1,450,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (5126,'Muddy Siredon',18,23,12,11,1,1,1,0,0,255,255,0,0,0,1,1,0,0,0,1,1000,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (16451,'Mythril Dagger',90,78,13,2,1,1,5,0,0,255,255,0,0,0,0,0,0,0,1,1,80,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (16537,'Mythril Sword',90,15,13,2,1,1,10,0,0,255,255,0,0,0,0,0,0,0,1,1,60,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (4361,'Nebimonite',27,30,9,5,1,1,10,0,1,255,255,0,0,3,1,2,0,0,0,1,1000,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (4485,'Noble Lady',66,30,7,10,1,1,13,0,1,255,255,0,0,3,1,0,0,0,0,1,700,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (1135,'Norg Shell',14,31,13,2,1,1,14,0,0,255,255,0,0,2,2,0,0,0,1,1,600,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (4482,'Nosteau Herring',39,21,7,8,1,1,10,0,0,255,255,0,0,3,1,3,0,0,0,1,950,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (4481,'Ogre Eel',35,29,13,11,1,1,14,0,0,255,255,0,0,4,2,3,0,0,0,1,1000,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (624,'Pamtam Kelp',3,24,13,2,1,1,13,0,0,255,255,0,0,2,4,0,0,0,1,1,1000,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (5125,'Phanauet Newt',4,13,10,11,1,1,1,0,0,255,255,0,0,0,2,1,0,0,0,1,1000,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (4464,'Pipira',29,11,6,14,1,1,10,0,0,255,255,0,0,3,1,5,0,0,0,1,1000,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (5470,'Pirarucu',89,24,13,11,161,210,99,1,0,255,255,0,0,0,1,3,0,0,0,1,1000,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (5133,'Pterygotus',99,28,8,7,25,260,24,1,0,255,255,0,0,3,1,9,0,0,0,1,400,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (4514,'Quus',19,12,7,11,1,1,5,0,0,255,255,0,0,3,2,3,0,0,0,3,1000,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (4402,'Red Terrapin',53,28,8,5,1,1,11,0,0,255,255,0,0,0,5,2,0,0,0,1,750,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (5135,'Rhinochimera',72,17,5,14,10,90,23,1,0,255,255,0,0,3,1,7,0,0,0,1,450,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (90,'Rusty Bucket',1,19,13,2,1,1,10,0,0,255,255,0,9,1,1,0,0,0,1,1,900,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (12522,'Rusty Cap',30,38,13,2,1,1,5,0,0,255,255,0,9,7,1,0,0,0,1,1,800,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (16606,'Rusty Greatsword',60,57,13,2,1,1,5,0,0,255,255,0,8,0,0,0,0,0,1,1,400,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (14117,'Rusty Leggings',7,26,13,2,1,1,18,0,0,255,255,0,9,2,0,0,0,0,1,1,500,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (16655,'Rusty Pick',40,47,13,2,1,1,5,0,0,255,255,0,8,2,1,0,0,0,1,1,400,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (14242,'Rusty Subligar',5,22,13,2,1,1,5,0,0,255,255,0,8,2,0,0,0,0,1,1,500,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (4305,'Ryugu Titan',150,48,1,15,200,490,34,1,1,255,255,0,0,0,1,8,1,0,0,1,700,0,'',0,0,1,0);
INSERT INTO `fishing_fish` VALUES (4291,'Sandfish',50,36,3,10,1,1,13,0,0,255,255,0,1,3,3,7,0,0,0,3,1000,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (5459,'Sazanbaligi',56,18,10,14,1,1,14,0,0,255,255,0,0,3,1,1,0,0,0,1,650,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (4475,'Sea Zombie',100,39,3,15,80,195,28,1,1,255,255,0,0,4,1,2,1,0,0,1,350,0,'',0,0,1,0);
INSERT INTO `fishing_fish` VALUES (4484,'Shall Shell',53,27,13,2,1,1,14,0,0,255,255,0,1,3,4,8,0,0,0,1,1000,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (4354,'Shining Trout',37,16,5,11,1,1,15,0,0,255,255,0,0,3,1,0,0,0,0,1,1000,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (13456,'Silver Ring',34,40,13,2,1,1,5,0,0,255,255,0,1,0,0,0,0,0,1,1,300,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (4451,'Silver Shark',76,35,3,9,1,1,14,0,0,255,255,0,0,3,1,0,0,0,0,1,500,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (4463,'Takitaro',101,18,3,14,55,130,28,1,0,255,255,0,16,3,5,2,1,0,0,1,500,0,'',0,0,1,0);
INSERT INTO `fishing_fish` VALUES (5130,'Tavnazian Goby',75,30,7,8,1,1,10,0,0,255,255,0,0,3,4,2,0,0,0,1,850,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (4478,'Three-Eyed Fish',79,22,10,10,50,120,25,1,0,255,255,0,0,3,4,8,0,0,0,1,500,0,'',0,0,1,0);
INSERT INTO `fishing_fish` VALUES (4483,'Tiger Cod',29,23,9,9,1,1,10,0,0,255,255,0,0,3,1,8,0,0,0,1,1000,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (4310,'Tiny Goldfish',20,22,0,14,1,1,5,0,0,255,255,0,0,5,1,7,0,0,0,3,1000,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (5120,'Titanic Sawfish',125,39,6,13,75,210,29,1,1,255,255,0,0,0,1,9,1,0,0,1,400,0,'',0,0,1,0);
INSERT INTO `fishing_fish` VALUES (4476,'Titanictus',101,28,3,12,75,210,28,1,1,255,255,0,0,3,5,8,1,0,0,1,350,0,'',0,0,1,0);
INSERT INTO `fishing_fish` VALUES (4426,'Tricolored Carp',27,19,12,12,1,1,13,0,0,255,255,0,0,3,1,8,0,0,0,1,1000,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (4319,'Tricorn',128,38,11,9,105,210,31,1,0,255,255,0,0,0,4,10,1,0,0,1,500,1976,'',0,0,1,0);
INSERT INTO `fishing_fish` VALUES (4317,'Trilobite',59,27,5,6,1,1,14,0,1,255,255,0,0,3,2,10,0,0,0,1,1000,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (5466,'Trumpet Shell',63,18,10,5,1,1,99,0,0,255,255,0,0,0,1,3,0,0,0,1,550,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (5137,'Turnabaligi',104,30,7,12,65,175,24,1,0,255,255,0,16,6,1,7,0,0,0,1,450,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (5452,'Uskumru',55,24,4,12,1,1,14,0,0,255,255,0,0,3,2,3,0,0,0,1,550,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (5141,'Veydal Wrasse',35,13,11,5,40,125,25,1,0,255,255,0,0,6,4,3,0,0,0,1,400,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (5131,'Vongola Clam',53,20,8,4,1,1,13,0,1,255,255,0,1,3,1,3,0,0,0,1,900,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (5463,'Yayinbaligi',31,13,6,12,40,130,19,1,0,255,255,0,0,4,1,6,0,0,0,1,900,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (4403,'Yellow Globe',17,17,8,8,1,1,10,0,0,255,255,0,0,3,2,1,0,0,0,3,1000,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (5458,'Yilanbaligi',47,24,5,8,1,1,15,0,0,255,255,0,0,4,4,3,0,0,0,1,800,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (4385,'Zafmlug Bass',43,27,6,7,1,1,15,0,0,255,255,0,0,3,1,10,0,0,0,1,1000,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (4288,'Zebra Eel',71,32,10,10,1,1,23,0,0,255,255,0,0,3,1,8,0,0,0,1,800,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (1624,'Bugbear Mask',54,42,13,2,1,1,5,0,0,255,255,0,0,2,1,0,0,0,1,1,700,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (3965,'Adoulinian Kelp',6,18,13,2,1,1,13,0,0,255,255,0,0,0,4,0,0,0,1,1,1000,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (591,'Ripped cap',20,36,13,2,1,1,13,0,0,2,23,0,0,1,3,0,0,0,1,1,400,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (65535,'Gil',1,22,13,2,1,1,1,0,0,255,255,0,0,0,0,0,0,0,1,1,100,0,'',0,0,0,0);
INSERT INTO `fishing_fish` VALUES (5329,'Tarutaru Snare',30,22,13,2,1,1,1,0,0,255,255,0,0,0,0,0,0,0,1,1,1000,0,'',0,1,0,0);
INSERT INTO `fishing_fish` VALUES (5330,'Mithra Snare',30,22,13,2,1,1,1,0,0,255,255,0,0,0,0,0,0,0,1,1,1000,0,'',0,1,0,0);
/*!40000 ALTER TABLE `fishing_fish` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-04-23  4:21:28
