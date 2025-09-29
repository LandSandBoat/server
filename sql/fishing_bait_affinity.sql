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
-- Table structure for table `fishing_bait_affinity`
--

DROP TABLE IF EXISTS `fishing_bait_affinity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fishing_bait_affinity` (
  `baitid` smallint(5) unsigned NOT NULL,
  `fishid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `power` smallint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`baitid`,`fishid`)
) ENGINE=Aria TRANSACTIONAL=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci AVG_ROW_LENGTH=28;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fishing_bait_affinity`
--

LOCK TABLES `fishing_bait_affinity` WRITE;
/*!40000 ALTER TABLE `fishing_bait_affinity` DISABLE KEYS */;
INSERT INTO `fishing_bait_affinity` VALUES (16997,5455,2); -- Ball of Crayfish Paste, Ahtapot,          Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16997,4461,2); -- Ball of Crayfish Paste, Bastore Bream,    Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16997,5473,2); -- Ball of Crayfish Paste, Bastore Sweeper,  Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16997,4429,3); -- Ball of Crayfish Paste, Black Eel,        Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (16997,4384,2); -- Ball of Crayfish Paste, Black Sole,       Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16997,4443,2); -- Ball of Crayfish Paste, Cobalt Jellyfish, Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16997,5447,2); -- Ball of Crayfish Paste, Denizanasi,       Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16997,5457,2); -- Ball of Crayfish Paste, Dil,              Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16997,4501,2); -- Ball of Crayfish Paste, Fat Greedie,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16997,5475,2); -- Ball of Crayfish Paste, Gigant Octopus,   Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16997,4500,2); -- Ball of Crayfish Paste, Greedie,          Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16997,4304,2); -- Ball of Crayfish Paste, Grimmonite,       Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16997,5132,2); -- Ball of Crayfish Paste, Gurnard,          Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16997,5456,2); -- Ball of Crayfish Paste, Istiridye,        Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16997,5140,2); -- Ball of Crayfish Paste, Kalkanbaligi,     Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16997,5454,2); -- Ball of Crayfish Paste, Mercanbaligi,     Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16997,5121,2); -- Ball of Crayfish Paste, Moorish Idol,     Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16997,4361,3); -- Ball of Crayfish Paste, Nebimonite,       Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (16997,4484,2); -- Ball of Crayfish Paste, Shall Shell,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16997,5466,2); -- Ball of Crayfish Paste, Trumpet Shell,    Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16997,5131,2); -- Ball of Crayfish Paste, Vongola Clam,     Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16997,4403,3); -- Ball of Crayfish Paste, Yellow Globe,     Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (16997,4385,2); -- Ball of Crayfish Paste, Zafmlug Bass,     Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16998,4313,3); -- Ball of Insect Paste,   Blindfish,        Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (16998,4443,2); -- Ball of Insect Paste,   Cobalt Jellyfish, Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16998,4528,2); -- Ball of Insect Paste,   Crystal Bass,     Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16998,4428,2); -- Ball of Insect Paste,   Dark Bass,        Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16998,5447,2); -- Ball of Insect Paste,   Denizanasi,       Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16998,4289,3); -- Ball of Insect Paste,   Forest Carp,      Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (16998,4427,2); -- Ball of Insect Paste,   Gold Carp,        Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16998,4470,2); -- Ball of Insect Paste,   Icefish,          Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16998,4401,3); -- Ball of Insect Paste,   Moat Carp,        Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (16998,4291,2); -- Ball of Insect Paste,   Sandfish,         Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16998,5459,2); -- Ball of Insect Paste,   Sazanbaligi,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16998,4310,2); -- Ball of Insect Paste,   Tiny Goldfish,    Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16998,4426,2); -- Ball of Insect Paste,   Tricolored Carp,  Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16996,5476,3); -- Ball of Sardine Paste,  Abaia,            Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (16996,5461,2); -- Ball of Sardine Paste,  Alabaligi,        Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16996,4316,2); -- Ball of Sardine Paste,  Armored Pisces,   Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16996,4429,2); -- Ball of Sardine Paste,  Black Eel,        Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16996,4313,2); -- Ball of Sardine Paste,  Blindfish,        Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16996,4379,2); -- Ball of Sardine Paste,  Cheval Salmon,    Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16996,4443,2); -- Ball of Sardine Paste,  Cobalt Jellyfish, Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16996,4528,2); -- Ball of Sardine Paste,  Crystal Bass,     Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16996,4428,3); -- Ball of Sardine Paste,  Dark Bass,        Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (16996,5447,2); -- Ball of Sardine Paste,  Denizanasi,       Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16996,4454,3); -- Ball of Sardine Paste,  Emperor Fish,     Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (16996,4469,2); -- Ball of Sardine Paste,  Giant Catfish,    Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16996,4308,2); -- Ball of Sardine Paste,  Giant Chirai,     Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16996,4306,2); -- Ball of Sardine Paste,  Giant Donko,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16996,4307,3); -- Ball of Sardine Paste,  Jungle Catfish,   Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (16996,5462,3); -- Ball of Sardine Paste,  Morinabaligi,     Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (16996,4354,2); -- Ball of Sardine Paste,  Shining Trout,    Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16996,5458,2); -- Ball of Sardine Paste,  Yilanbaligi,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16996,4482,2); -- Ball of Sardine Paste,  Nosteau Herring   Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16999,5476,3); -- Ball of Trout Paste,    Abaia,            Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (16999,5461,2); -- Ball of Trout Paste,    Alabaligi,        Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16999,4316,2); -- Ball of Trout Paste,    Armored Pisces,   Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16999,4429,2); -- Ball of Trout Paste,    Black Eel,        Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16999,4313,2); -- Ball of Trout Paste,    Blindfish,        Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16999,4379,2); -- Ball of Trout Paste,    Cheval Salmon,    Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16999,4443,2); -- Ball of Trout Paste,    Cobalt Jellyfish, Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16999,4528,2); -- Ball of Trout Paste,    Crystal Bass,     Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16999,4428,3); -- Ball of Trout Paste,    Dark Bass,        Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (16999,5447,2); -- Ball of Trout Paste,    Denizanasi,       Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16999,4454,3); -- Ball of Trout Paste,    Emperor Fish,     Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (16999,4469,2); -- Ball of Trout Paste,    Giant Catfish,    Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16999,4308,2); -- Ball of Trout Paste,    Giant Chirai,     Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16999,4306,2); -- Ball of Trout Paste,    Giant Donko,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16999,4307,3); -- Ball of Trout Paste,    Jungle Catfish,   Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (16999,5462,3); -- Ball of Trout Paste,    Morinabaligi,     Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (16999,4354,2); -- Ball of Trout Paste,    Shining Trout,    Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16999,5458,2); -- Ball of Trout Paste,    Yilanbaligi,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17006,5127,2); -- Drill Calamary,         Gugrusaurus,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17006,5468,2); -- Drill Calamary,         Matsya,           Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17006,4475,2); -- Drill Calamary,         Sea Zombie,       Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17405,5461,2); -- Fly Lure,               Alabaligi,        Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17405,5139,3); -- Fly Lure,               Betta,            Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17405,4314,3); -- Fly Lure,               Bibikibo,         Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17405,5465,2); -- Fly Lure,               Caedarva Frog,    Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17405,4379,3); -- Fly Lure,               Cheval Salmon,    Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17405,4443,3); -- Fly Lure,               Cobalt Jellyfish, Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17405,4515,3); -- Fly Lure,               Copper Frog,      Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17405,4473,3); -- Fly Lure,               Crescent Fish,    Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17405,5447,3); -- Fly Lure,               Denizanasi,       Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17405,4290,3); -- Fly Lure,               Elshimo Frog,     Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17405,4579,2); -- Fly Lure,               Elshimo Newt,     Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17405,5471,2); -- Fly Lure,               Gerrothorax,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17405,4308,2); -- Fly Lure,               Giant Chirai,     Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17405,5464,2); -- Fly Lure,               Kaplumbaga,       Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17405,2216,2); -- Fly Lure,               Lamp Marimo,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17405,5126,2); -- Fly Lure,               Muddy Siredon,    Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17405,5125,3); -- Fly Lure,               Phanauet Newt,    Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17405,4354,3); -- Fly Lure,               Shining Trout,    Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17405,4463,3); -- Fly Lure,               Takitaro,         Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17405,4319,2); -- Fly Lure,               Tricorn,          Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17403,5476,2); -- Frog Lure,              Abaia,            Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17403,4316,3); -- Frog Lure,              Armored Pisces,   Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17403,4443,2); -- Frog Lure,              Cobalt Jellyfish, Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17403,4528,2); -- Frog Lure,              Crystal Bass,     Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17403,4428,2); -- Frog Lure,              Dark Bass,        Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17403,5447,2); -- Frog Lure,              Denizanasi,       Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17403,4579,3); -- Frog Lure,              Elshimo Newt,     Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17403,4477,2); -- Frog Lure,              Gavial Fish,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17403,4469,2); -- Frog Lure,              Giant Catfish,    Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17403,4306,2); -- Frog Lure,              Giant Donko,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17403,4307,2); -- Frog Lure,              Jungle Catfish,   Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17403,5464,3); -- Frog Lure,              Kaplumbaga,       Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17403,4315,2); -- Frog Lure,              Lungfish,         Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17403,5126,3); -- Frog Lure,              Muddy Siredon,    Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17403,5125,2); -- Frog Lure,              Phanauet Newt,    Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17403,4464,2); -- Frog Lure,              Pipira,           Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17403,4402,3); -- Frog Lure,              Red Terrapin,     Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17403,4305,2); -- Frog Lure,              Ryugu Titan,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17403,5463,2); -- Frog Lure,              Yayinbaligi,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17001,4515,2); -- Giant Shell Bug,        Copper Frog,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17001,4473,2); -- Giant Shell Bug,        Crescent Fish,    Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17001,4528,2); -- Giant Shell Bug,        Crystal Bass,     Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17001,4428,2); -- Giant Shell Bug,        Dark Bass,        Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17001,4454,2); -- Giant Shell Bug,        Emperor Fish,     Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17001,4402,2); -- Giant Shell Bug,        Red Terrapin,     Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17396,4316,2); -- Little Worm,            Armored Pisces,   Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17396,4429,2); -- Little Worm,            Black Eel,        Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17396,5138,2); -- Little Worm,            Black Ghost,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17396,4313,2); -- Little Worm,            Blindfish,        Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17396,5469,2); -- Little Worm,            Brass Loach,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17396,5474,2); -- Little Worm,            Ca Cuong,         Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17396,4443,3); -- Little Worm,            Cobalt Jellyfish, Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17396,4472,2); -- Little Worm,            Crayfish,         Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17396,4528,2); -- Little Worm,            Crystal Bass,     Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17396,5447,3); -- Little Worm,            Denizanasi,       Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17396,4469,2); -- Little Worm,            Giant Catfish,    Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17396,4306,2); -- Little Worm,            Giant Donko,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17396,4427,2); -- Little Worm,            Gold Carp,        Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17396,4470,2); -- Little Worm,            Icefish,          Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17396,5460,2); -- Little Worm,            Kayabaligi,       Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17396,4315,2); -- Little Worm,            Lungfish,         Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17396,4401,2); -- Little Worm,            Moat Carp,        Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17396,4462,2); -- Little Worm,            Monke-Onke,       Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17396,4291,2); -- Little Worm,            Sandfish,         Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17396,5459,2); -- Little Worm,            Sazanbaligi,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17396,4354,2); -- Little Worm,            Shining Trout,    Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17396,5130,2); -- Little Worm,            Tavnazian Goby,   Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17396,4310,2); -- Little Worm,            Tiny Goldfish,    Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17396,4426,2); -- Little Worm,            Tricolored Carp,  Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17396,5458,2); -- Little Worm,            Yilanbaligi,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17396,4289,2); -- Little Worm,            Forest Carp,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17401,4443,2); -- Lizard Lure,            Cobalt Jellyfish, Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17401,4528,2); -- Lizard Lure,            Crystal Bass,     Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17401,4428,2); -- Lizard Lure,            Dark Bass,        Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17401,5447,2); -- Lizard Lure,            Denizanasi,       Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17401,5472,2); -- Lizard Lure,            Garpike,          Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17401,4477,3); -- Lizard Lure,            Gavial Fish,      Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17401,4469,2); -- Lizard Lure,            Giant Catfish,    Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17401,4306,2); -- Lizard Lure,            Giant Donko,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17401,4307,2); -- Lizard Lure,            Jungle Catfish,   Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17401,4464,2); -- Lizard Lure,            Pipira,           Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17401,4305,2); -- Lizard Lure,            Ryugu Titan,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17005,4313,2); -- Lufaise Fly,            Blindfish,        Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17005,4379,2); -- Lufaise Fly,            Cheval Salmon,    Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17005,4443,2); -- Lufaise Fly,            Cobalt Jellyfish, Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17005,4515,2); -- Lufaise Fly,            Copper Frog,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17005,5447,2); -- Lufaise Fly,            Denizanasi,       Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17005,5471,2); -- Lufaise Fly,            Gerrothorax,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17005,4308,3); -- Lufaise Fly,            Giant Chirai,     Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17005,4315,2); -- Lufaise Fly,            Lungfish,         Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17005,5126,2); -- Lufaise Fly,            Muddy Siredon,    Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17005,5125,2); -- Lufaise Fly,            Phanauet Newt,    Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17005,4354,2); -- Lufaise Fly,            Shining Trout,    Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17005,4319,2); -- Lufaise Fly,            Tricorn,          Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17395,4360,2); -- Lugworm,                Bastore Sardine,  Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17395,4443,2); -- Lugworm,                Cobalt Jellyfish, Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17395,4580,2); -- Lugworm,                Coral Butterfly,  Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17395,5447,2); -- Lugworm,                Denizanasi,       Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17395,4501,2); -- Lugworm,                Fat Greedie,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17395,4500,2); -- Lugworm,                Greedie,          Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17395,5449,2); -- Lugworm,                Hamsi,            Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17395,5136,3); -- Lugworm,                Istavrit,         Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17395,2216,2); -- Lugworm,                Lamp Marimo,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17395,5121,2); -- Lugworm,                Moorish Idol,     Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17395,4482,2); -- Lugworm,                Nosteau Herring,  Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17395,5133,3); -- Lugworm,                Pterygotus,       Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17395,4514,3); -- Lugworm,                Quus,             Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17395,4483,2); -- Lugworm,                Tiger Cod,        Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17395,4317,2); -- Lugworm,                Trilobite,        Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17395,4403,2); -- Lugworm,                Yellow Globe,     Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17395,4385,2); -- Lugworm,                Zafmlug Bass,     Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17000,4316,3); -- Meatball,               Armored Pisces,   Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17000,5473,2); -- Meatball,               Bastore Sweeper,  Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17000,4314,2); -- Meatball,               Bibikibo,         Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17000,4471,3); -- Meatball,               Bladefish,        Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17000,4313,2); -- Meatball,               Blindfish,        Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17000,4309,3); -- Meatball,               Cave Cherax,      Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17000,4443,3); -- Meatball,               Cobalt Jellyfish, Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17000,4528,2); -- Meatball,               Crystal Bass,     Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17000,4428,2); -- Meatball,               Dark Bass,        Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17000,5447,3); -- Meatball,               Denizanasi,       Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17000,4579,2); -- Meatball,               Elshimo Newt,     Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17000,5472,2); -- Meatball,               Garpike,          Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17000,4477,3); -- Meatball,               Gavial Fish,      Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17000,5471,2); -- Meatball,               Gerrothorax,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17000,5127,3); -- Meatball,               Gugrusaurus,      Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17000,4307,2); -- Meatball,               Jungle Catfish,   Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17000,5467,3); -- Meatball,               Megalodon,        Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17000,4464,2); -- Meatball,               Pipira,           Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17000,5470,3); -- Meatball,               Pirarucu,         Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17000,4305,2); -- Meatball,               Ryugu Titan,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17000,4475,2); -- Meatball,               Sea Zombie,       Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17000,4451,3); -- Meatball,               Silver Shark,     Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17000,5120,2); -- Meatball,               Titanic Sawfish,  Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17000,4476,3); -- Meatball,               Titanictus,       Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17407,4309,2); -- Minnow,                 Cave Cherax,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17407,4379,2); -- Minnow,                 Cheval Salmon,    Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17407,4443,2); -- Minnow,                 Cobalt Jellyfish, Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17407,5128,3); -- Minnow,                 Cone Calamary,    Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17407,5476,3); -- Minnow,                 Abaia,            Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17407,5461,2); -- Minnow,                 Alabaligi,        Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17407,4316,3); -- Minnow,                 Armored Pisces,   Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17407,4461,2); -- Minnow,                 Bastore Bream,    Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17407,5138,3); -- Minnow,                 Black Ghost,      Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17407,4399,3); -- Minnow,                 Bluetail,         Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17407,4528,3); -- Minnow,                 Crystal Bass,     Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17407,4428,3); -- Minnow,                 Dark Bass,        Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17407,5447,2); -- Minnow,                 Denizanasi,       Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17407,4501,2); -- Minnow,                 Fat Greedie,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17407,5472,2); -- Minnow,                 Garpike,          Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17407,4477,2); -- Minnow,                 Gavial Fish,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17407,5471,2); -- Minnow,                 Gerrothorax,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17407,4469,3); -- Minnow,                 Giant Catfish,    Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17407,4308,2); -- Minnow,                 Giant Chirai,     Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17407,4474,3); -- Minnow,                 Gigant Squid,     Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17407,4500,3); -- Minnow,                 Greedie,          Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17407,4480,2); -- Minnow,                 Gugru Tuna,       Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17407,5453,2); -- Minnow,                 Istakoz,          Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17407,4307,3); -- Minnow,                 Jungle Catfish,   Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17407,5448,2); -- Minnow,                 Kalamar,          Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17407,5460,2); -- Minnow,                 Kayabaligi,       Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17407,5450,2); -- Minnow,                 Lakerda,          Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17407,5129,2); -- Minnow,                 Lik,              Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17407,4315,2); -- Minnow,                 Lungfish,         Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17407,5467,2); -- Minnow,                 Megalodon,        Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17407,5454,2); -- Minnow,                 Mercanbaligi,     Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17407,5134,2); -- Minnow,                 Mola Mola,        Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17407,4464,3); -- Minnow,                 Pipira,           Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17407,5470,2); -- Minnow,                 Pirarucu,         Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17407,4305,2); -- Minnow,                 Ryugu Titan,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17407,4354,3); -- Minnow,                 Shining Trout,    Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17407,4463,2); -- Minnow,                 Takitaro,         Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17407,5130,3); -- Minnow,                 Tavnazian Goby,   Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17407,4478,3); -- Minnow,                 Three-eyed Fish,  Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17407,5137,2); -- Minnow,                 Turnabaligi,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17407,5452,2); -- Minnow,                 Uskumru,          Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17407,5141,2); -- Minnow,                 Veydal Wrasse,    Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17407,5463,2); -- Minnow,                 Yayinbaligi,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17407,4385,2); -- Minnow,                 Zafmlug Bass,     Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16993,4314,2); -- Peeled Crayfish,        Bibikibo,         Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16993,4384,2); -- Peeled Crayfish,        Black Sole,       Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16993,4309,2); -- Peeled Crayfish,        Cave Cherax,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16993,4443,2); -- Peeled Crayfish,        Cobalt Jellyfish, Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16993,4472,2); -- Peeled Crayfish,        Crayfish,         Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16993,4528,2); -- Peeled Crayfish,        Crystal Bass,     Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16993,4428,2); -- Peeled Crayfish,        Dark Bass,        Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16993,5447,2); -- Peeled Crayfish,        Denizanasi,       Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16993,4454,3); -- Peeled Crayfish,        Emperor Fish,     Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (16993,4477,2); -- Peeled Crayfish,        Gavial Fish,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16993,4306,3); -- Peeled Crayfish,        Giant Donko,      Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (16993,4315,2); -- Peeled Crayfish,        Lungfish,         Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16993,4462,2); -- Peeled Crayfish,        Monke-Onke,       Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16993,5121,2); -- Peeled Crayfish,        Moorish Idol,     Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16993,5462,2); -- Peeled Crayfish,        Morinabaligi,     Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16993,4463,2); -- Peeled Crayfish,        Takitaro,         Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16993,4317,2); -- Peeled Crayfish,        Trilobite,        Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16993,5131,2); -- Peeled Crayfish,        Vongola Clam,     Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16993,5458,2); -- Peeled Crayfish,        Yilanbaligi,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17394,5455,2); -- Peeled Lobster,         Ahtapot,          Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17394,4461,2); -- Peeled Lobster,         Bastore Bream,    Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17394,4479,2); -- Peeled Lobster,         Bhefhel Marlin,   Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17394,4314,2); -- Peeled Lobster,         Bibikibo,         Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17394,4399,2); -- Peeled Lobster,         Bluetail,         Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17394,4309,2); -- Peeled Lobster,         Cave Cherax,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17394,4443,2); -- Peeled Lobster,         Cobalt Jellyfish, Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17394,5447,2); -- Peeled Lobster,         Denizanasi,       Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17394,5457,2); -- Peeled Lobster,         Dil,              Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17394,4304,2); -- Peeled Lobster,         Grimmonite,       Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17394,4480,2); -- Peeled Lobster,         Gugru Tuna,       Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17394,5451,2); -- Peeled Lobster,         Kilicbaligi,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17394,5454,2); -- Peeled Lobster,         Mercanbaligi,     Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17394,5121,2); -- Peeled Lobster,         Moorish Idol,     Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17394,4361,2); -- Peeled Lobster,         Nebimonite,       Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17394,4485,2); -- Peeled Lobster,         Noble Lady,       Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17394,4481,2); -- Peeled Lobster,         Ogre Eel,         Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17394,4305,2); -- Peeled Lobster,         Ryugu Titan,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17394,4476,2); -- Peeled Lobster,         Titanictus,       Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17002,5476,1); -- Robber Rig,             Abaia,            Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17002,4461,1); -- Robber Rig,             Bastore Bream,    Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17002,4360,1); -- Robber Rig,             Bastore Sardine,  Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17002,5473,1); -- Robber Rig,             Bastore Sweeper,  Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17002,4479,1); -- Robber Rig,             Bhefhel Marlin,   Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17002,4314,1); -- Robber Rig,             Bibikibo,         Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17002,4429,1); -- Robber Rig,             Black Eel,        Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17002,4471,1); -- Robber Rig,             Bladefish,        Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17002,4313,1); -- Robber Rig,             Blindfish,        Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17002,4399,1); -- Robber Rig,             Bluetail,         Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17002,4379,1); -- Robber Rig,             Cheval Salmon,    Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17002,4443,1); -- Robber Rig,             Cobalt Jellyfish, Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17002,4515,1); -- Robber Rig,             Copper Frog,      Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17002,4472,1); -- Robber Rig,             Crayfish,         Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17002,4428,1); -- Robber Rig,             Dark Bass,        Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17002,5447,1); -- Robber Rig,             Denizanasi,       Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17002,5457,1); -- Robber Rig,             Dil,              Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17002,4290,1); -- Robber Rig,             Elshimo Frog,     Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17002,4579,1); -- Robber Rig,             Elshimo Newt,     Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17002,4454,1); -- Robber Rig,             Emperor Fish,     Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17002,4501,1); -- Robber Rig,             Fat Greedie,      Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17002,4289,1); -- Robber Rig,             Forest Carp,      Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17002,5472,1); -- Robber Rig,             Garpike,          Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17002,4477,1); -- Robber Rig,             Gavial Fish,      Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17002,5471,1); -- Robber Rig,             Gerrothorax,      Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17002,4469,1); -- Robber Rig,             Giant Catfish,    Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17002,4306,1); -- Robber Rig,             Giant Donko,      Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17002,5475,1); -- Robber Rig,             Gigant Octopus,   Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17002,4427,1); -- Robber Rig,             Gold Carp,        Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17002,4500,1); -- Robber Rig,             Greedie,          Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17002,4304,1); -- Robber Rig,             Grimmonite,       Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17002,5449,1); -- Robber Rig,             Hamsi,            Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17002,5453,1); -- Robber Rig,             Istakoz,          Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17002,5456,1); -- Robber Rig,             Istiridye,        Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17002,5464,1); -- Robber Rig,             Kaplumbaga,       Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17002,5451,1); -- Robber Rig,             Kilicbaligi,      Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17002,5467,1); -- Robber Rig,             Megalodon,        Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17002,5454,1); -- Robber Rig,             Mercanbaligi,     Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17002,4401,1); -- Robber Rig,             Moat Carp,        Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17002,4485,1); -- Robber Rig,             Noble Lady,       Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17002,4481,1); -- Robber Rig,             Ogre Eel,         Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17002,4464,1); -- Robber Rig,             Pipira,           Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17002,5470,1); -- Robber Rig,             Pirarucu,         Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17002,4514,1); -- Robber Rig,             Quus,             Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17002,4291,1); -- Robber Rig,             Sandfish,         Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17002,4484,3); -- Robber Rig,             Shall Shell,      Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17002,4451,1); -- Robber Rig,             Silver Shark,     Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17002,4483,1); -- Robber Rig,             Tiger Cod,        Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17002,4426,1); -- Robber Rig,             Tricolored Carp,  Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17002,4317,1); -- Robber Rig,             Trilobite,        Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17002,5466,1); -- Robber Rig,             Trumpet Shell,    Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17002,5131,1); -- Robber Rig,             Vongola Clam,     Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17002,4403,1); -- Robber Rig,             Yellow Globe,     Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17002,4385,1); -- Robber Rig,             Zafmlug Bass,     Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,5476,1); -- Rogue Rig,              Abaia,            Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,4461,1); -- Rogue Rig,              Bastore Bream,    Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,4360,1); -- Rogue Rig,              Bastore Sardine,  Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,4479,1); -- Rogue Rig,              Bhefhel Marlin,   Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,4429,1); -- Rogue Rig,              Black Eel,        Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,4384,1); -- Rogue Rig,              Black Sole,       Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,4471,1); -- Rogue Rig,              Bladefish,        Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,4313,1); -- Rogue Rig,              Blindfish,        Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,4399,1); -- Rogue Rig,              Bluetail,         Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,4309,1); -- Rogue Rig,              Cave Cherax,      Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,4443,1); -- Rogue Rig,              Cobalt Jellyfish, Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,4515,1); -- Rogue Rig,              Copper Frog,      Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,4472,1); -- Rogue Rig,              Crayfish,         Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,4473,1); -- Rogue Rig,              Crescent Fish,    Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,4528,1); -- Rogue Rig,              Crystal Bass,     Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,4428,1); -- Rogue Rig,              Dark Bass,        Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,5447,1); -- Rogue Rig,              Denizanasi,       Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,5457,1); -- Rogue Rig,              Dil,              Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,4290,1); -- Rogue Rig,              Elshimo Frog,     Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,4579,1); -- Rogue Rig,              Elshimo Newt,     Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,4454,1); -- Rogue Rig,              Emperor Fish,     Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,4501,1); -- Rogue Rig,              Fat Greedie,      Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,4289,1); -- Rogue Rig,              Forest Carp,      Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,5472,1); -- Rogue Rig,              Garpike,          Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,4477,1); -- Rogue Rig,              Gavial Fish,      Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,5471,1); -- Rogue Rig,              Gerrothorax,      Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,4469,1); -- Rogue Rig,              Giant Catfish,    Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,4308,1); -- Rogue Rig,              Giant Chirai,     Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,4306,1); -- Rogue Rig,              Giant Donko,      Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,5475,1); -- Rogue Rig,              Gigant Octopus,   Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,4474,1); -- Rogue Rig,              Gigant Squid,     Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,4383,1); -- Rogue Rig,              Gold Lobster,     Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,4500,1); -- Rogue Rig,              Greedie,          Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,4304,1); -- Rogue Rig,              Grimmonite,       Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,4480,1); -- Rogue Rig,              Gugru Tuna,       Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,4470,1); -- Rogue Rig,              Icefish,          Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,5453,1); -- Rogue Rig,              Istakoz,          Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,5456,1); -- Rogue Rig,              Istiridye,        Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,4307,1); -- Rogue Rig,              Jungle Catfish,   Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,5464,1); -- Rogue Rig,              Kaplumbaga,       Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,5451,1); -- Rogue Rig,              Kilicbaligi,      Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,5467,1); -- Rogue Rig,              Megalodon,        Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,5454,1); -- Rogue Rig,              Mercanbaligi,     Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,4462,1); -- Rogue Rig,              Monke-Onke,       Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,4361,1); -- Rogue Rig,              Nebimonite,       Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,4485,1); -- Rogue Rig,              Noble Lady,       Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,4482,1); -- Rogue Rig,              Nosteau Herring,  Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,4481,1); -- Rogue Rig,              Ogre Eel,         Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,4464,1); -- Rogue Rig,              Pipira,           Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,5470,1); -- Rogue Rig,              Pirarucu,         Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,5133,1); -- Rogue Rig,              Pterygotus,       Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,4514,1); -- Rogue Rig,              Quus,             Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,4402,1); -- Rogue Rig,              Red Terrapin,     Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,4291,1); -- Rogue Rig,              Sandfish,         Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,4475,1); -- Rogue Rig,              Sea Zombie,       Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,4484,2); -- Rogue Rig,              Shall Shell,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17398,4354,1); -- Rogue Rig,              Shining Trout,    Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,4451,1); -- Rogue Rig,              Silver Shark,     Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,4463,1); -- Rogue Rig,              Takitaro,         Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,4478,1); -- Rogue Rig,              Three-eyed Fish,  Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,4483,1); -- Rogue Rig,              Tiger Cod,        Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,4476,1); -- Rogue Rig,              Titanictus,       Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,4426,1); -- Rogue Rig,              Tricolored Carp,  Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,5466,1); -- Rogue Rig,              Trumpet Shell,    Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,5131,1); -- Rogue Rig,              Vongola Clam,     Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,4403,1); -- Rogue Rig,              Yellow Globe,     Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,4385,1); -- Rogue Rig,              Zafmlug Bass,     Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17398,4288,1); -- Rogue Rig,              Zebra Eel,        Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (16995,4309,3); -- Piece of Rotten Meat,   Cave Cherax,      Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (16995,4579,2); -- Piece of Rotten Meat,   Elshimo Newt,     Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16995,4307,2); -- Piece of Rotten Meat,   Jungle Catfish,   Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16995,4475,1); -- Piece of Rotten Meat,   Sea Zombie,       Power : 1
INSERT INTO `fishing_bait_affinity` VALUES (17399,4360,3); -- Sabiki Rig,             Bastore Sardine,  Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17399,4443,3); -- Sabiki Rig,             Cobalt Jellyfish, Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17399,5128,2); -- Sabiki Rig,             Cone Calamary,    Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17399,5447,3); -- Sabiki Rig,             Denizanasi,       Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17399,5449,3); -- Sabiki Rig,             Hamsi,            Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17399,4470,3); -- Sabiki Rig,             Icefish,          Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17399,5448,2); -- Sabiki Rig,             Kalamar,          Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17399,2216,2); -- Sabiki Rig,             Lamp Marimo,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17399,4514,2); -- Sabiki Rig,             Quus,             Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17399,4291,2); -- Sabiki Rig,             Sandfish,         Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17399,4403,3); -- Sabiki Rig,             Yellow Globe,     Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17397,4429,3); -- Shell Bug,              Black Eel,        Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17397,5138,2); -- Shell Bug,              Black Ghost,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17397,4313,2); -- Shell Bug,              Blindfish,        Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17397,4443,2); -- Shell Bug,              Cobalt Jellyfish, Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17397,4428,2); -- Shell Bug,              Dark Bass,        Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17397,5447,2); -- Shell Bug,              Denizanasi,       Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17397,4290,2); -- Shell Bug,              Elshimo Frog,     Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17397,4579,2); -- Shell Bug,              Elshimo Newt,     Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17397,5136,2); -- Shell Bug,              Istavrit,         Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17397,4307,2); -- Shell Bug,              Jungle Catfish,   Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17397,5464,2); -- Shell Bug,              Kaplumbaga,       Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17397,5460,2); -- Shell Bug,              Kayabaligi,       Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17397,4315,2); -- Shell Bug,              Lungfish,         Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17397,5126,2); -- Shell Bug,              Muddy Siredon,    Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17397,5125,2); -- Shell Bug,              Phanauet Newt,    Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17397,5133,2); -- Shell Bug,              Pterygotus,       Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17397,4402,2); -- Shell Bug,              Red Terrapin,     Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17397,5130,2); -- Shell Bug,              Tavnazian Goby,   Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17397,5458,2); -- Shell Bug,              Yilanbaligi,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17402,5455,2); -- Shrimp Lure,            Ahtapot,          Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17402,4461,3); -- Shrimp Lure,            Bastore Bream,    Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17402,4314,2); -- Shrimp Lure,            Bibikibo,         Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17402,4384,2); -- Shrimp Lure,            Black Sole,       Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17402,4309,2); -- Shrimp Lure,            Cave Cherax,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17402,4443,2); -- Shrimp Lure,            Cobalt Jellyfish, Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17402,5447,2); -- Shrimp Lure,            Denizanasi,       Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17402,5457,2); -- Shrimp Lure,            Dil,              Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17402,5475,3); -- Shrimp Lure,            Gigant Octopus,   Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17402,4427,3); -- Shrimp Lure,            Gold Carp,        Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17402,4304,3); -- Shrimp Lure,            Grimmonite,       Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17402,4480,2); -- Shrimp Lure,            Gugru Tuna,       Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17402,5140,3); -- Shrimp Lure,            Kalkanbaligi,     Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17402,5450,2); -- Shrimp Lure,            Lakerda,          Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17402,4315,3); -- Shrimp Lure,            Lungfish,         Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17402,5454,3); -- Shrimp Lure,            Mercanbaligi,     Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17402,5134,3); -- Shrimp Lure,            Mola Mola,        Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17402,4462,3); -- Shrimp Lure,            Monke-Onke,       Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17402,5121,3); -- Shrimp Lure,            Moorish Idol,     Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17402,4361,2); -- Shrimp Lure,            Nebimonite,       Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17402,4485,2); -- Shrimp Lure,            Noble Lady,       Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17402,4482,2); -- Shrimp Lure,            Nosteau Herring,  Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17402,4481,3); -- Shrimp Lure,            Ogre Eel,         Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17402,4305,2); -- Shrimp Lure,            Ryugu Titan,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17402,5459,2); -- Shrimp Lure,            Sazanbaligi,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17402,4483,2); -- Shrimp Lure,            Tiger Cod,        Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17402,4426,3); -- Shrimp Lure,            Tricolored Carp,  Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17402,4317,2); -- Shrimp Lure,            Trilobite,        Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17402,5137,3); -- Shrimp Lure,            Turnabaligi,      Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17402,5452,2); -- Shrimp Lure,            Uskumru,          Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17402,5141,2); -- Shrimp Lure,            Veydal Wrasse,    Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17402,4288,3); -- Shrimp Lure,            Zebra Eel,        Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17400,5461,2); -- Sinking Minnow,         Alabaligi,        Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17400,4316,3); -- Sinking Minnow,         Armored Pisces,   Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17400,4461,2); -- Sinking Minnow,         Bastore Bream,    Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17400,5473,2); -- Sinking Minnow,         Bastore Sweeper,  Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17400,4314,2); -- Sinking Minnow,         Bibikibo,         Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17400,5138,2); -- Sinking Minnow,         Black Ghost,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17400,4384,3); -- Sinking Minnow,         Black Sole,       Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17400,4309,2); -- Sinking Minnow,         Cave Cherax,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17400,4379,2); -- Sinking Minnow,         Cheval Salmon,    Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17400,4443,2); -- Sinking Minnow,         Cobalt Jellyfish, Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17400,4528,3); -- Sinking Minnow,         Crystal Bass,     Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17400,4428,2); -- Sinking Minnow,         Dark Bass,        Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17400,5447,2); -- Sinking Minnow,         Denizanasi,       Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17400,5457,2); -- Sinking Minnow,         Dil,              Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17400,4501,2); -- Sinking Minnow,         Fat Greedie,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17400,5472,3); -- Sinking Minnow,         Garpike,          Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17400,4469,3); -- Sinking Minnow,         Giant Catfish,    Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17400,5475,2); -- Sinking Minnow,         Gigant Octopus,   Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17400,4383,3); -- Sinking Minnow,         Gold Lobster,     Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17400,4500,2); -- Sinking Minnow,         Greedie,          Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17400,4480,3); -- Sinking Minnow,         Gugru Tuna,       Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17400,5453,3); -- Sinking Minnow,         Istakoz,          Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17400,5136,2); -- Sinking Minnow,         Istavrit,         Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17400,4307,2); -- Sinking Minnow,         Jungle Catfish,   Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17400,5140,2); -- Sinking Minnow,         Kalkanbaligi,     Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17400,5460,3); -- Sinking Minnow,         Kayabaligi,       Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17400,5450,3); -- Sinking Minnow,         Lakerda,          Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17400,5129,2); -- Sinking Minnow,         Lik,              Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17400,4315,2); -- Sinking Minnow,         Lungfish,         Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17400,5454,2); -- Sinking Minnow,         Mercanbaligi,     Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17400,5462,2); -- Sinking Minnow,         Morinabaligi,     Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17400,4485,3); -- Sinking Minnow,         Noble Lady,       Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17400,4481,2); -- Sinking Minnow,         Ogre Eel,         Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17400,5133,2); -- Sinking Minnow,         Pterygotus,       Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17400,5135,3); -- Sinking Minnow,         Rhinochimera,     Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17400,4305,2); -- Sinking Minnow,         Ryugu Titan,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17400,4354,3); -- Sinking Minnow,         Shining Trout,    Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17400,4463,2); -- Sinking Minnow,         Takitaro,         Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17400,5130,2); -- Sinking Minnow,         Tavnazian Goby,   Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17400,5466,2); -- Sinking Minnow,         Trumpet Shell,    Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17400,5137,2); -- Sinking Minnow,         Turnabaligi,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17400,5463,2); -- Sinking Minnow,         Yayinbaligi,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17400,5458,2); -- Sinking Minnow,         Yilanbaligi,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17400,4385,2); -- Sinking Minnow,         Zafmlug Bass,     Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17400,4288,2); -- Sinking Minnow,         Zebra Eel,        Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16992,5473,3); -- Slice Of Bluetail,      Bastore Sweeper,  Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (16992,4479,3); -- Slice Of Bluetail,      Bhefhel Marlin,   Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (16992,4314,2); -- Slice Of Bluetail,      Bibikibo,         Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16992,4471,3); -- Slice Of Bluetail,      Bladefish,        Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (16992,4443,2); -- Slice Of Bluetail,      Cobalt Jellyfish, Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16992,5128,2); -- Slice Of Bluetail,      Cone Calamary,    Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16992,5447,2); -- Slice Of Bluetail,      Denizanasi,       Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16992,4474,2); -- Slice Of Bluetail,      Gigant Squid,     Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16992,5127,2); -- Slice Of Bluetail,      Gugrusaurus,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16992,5448,3); -- Slice Of Bluetail,      Kalamar,          Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (16992,5451,3); -- Slice Of Bluetail,      Kilicbaligi,      Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (16992,5134,2); -- Slice Of Bluetail,      Mola Mola,        Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16992,4305,2); -- Slice Of Bluetail,      Ryugu Titan,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16992,4475,2); -- Slice Of Bluetail,      Sea Zombie,       Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16992,4451,2); -- Slice Of Bluetail,      Silver Shark,     Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16992,5141,3); -- Slice Of Bluetail,      Veydal Wrasse,    Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17393,5473,2); -- Slice Of Cod,           Bastore Sweeper,  Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17393,4384,2); -- Slice Of Cod,           Black Sole,       Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17393,4443,2); -- Slice Of Cod,           Cobalt Jellyfish, Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17393,5128,2); -- Slice Of Cod,           Cone Calamary,    Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17393,5447,2); -- Slice Of Cod,           Denizanasi,       Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17393,5457,3); -- Slice Of Cod,           Dil,              Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17393,4474,3); -- Slice Of Cod,           Gigant Squid,     Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17393,5140,2); -- Slice Of Cod,           Kalkanbaligi,     Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17393,5450,2); -- Slice Of Cod,           Lakerda,          Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17393,5467,2); -- Slice Of Cod,           Megalodon,        Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17393,5134,2); -- Slice Of Cod,           Mola Mola,        Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17393,4305,3); -- Slice Of Cod,           Ryugu Titan,      Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17393,4478,3); -- Slice Of Cod,           Three-eyed Fish,  Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17393,5120,2); -- Slice Of Cod,           Titanic Sawfish,  Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17393,5141,2); -- Slice Of Cod,           Veydal Wrasse,    Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16994,5476,2); -- Slice Of Carp,          Abaia,            Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16994,5474,3); -- Slice Of Carp,          Ca Cuong,         Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (16994,4443,2); -- Slice Of Carp,          Cobalt Jellyfish, Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16994,4472,3); -- Slice Of Carp,          Crayfish,         Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (16994,4528,2); -- Slice Of Carp,          Crystal Bass,     Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16994,4428,2); -- Slice Of Carp,          Dark Bass,        Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16994,5447,2); -- Slice Of Carp,          Denizanasi,       Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16994,4454,2); -- Slice Of Carp,          Emperor Fish,     Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16994,4477,2); -- Slice Of Carp,          Gavial Fish,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16994,4306,2); -- Slice Of Carp,          Giant Donko,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (16994,4464,2); -- Slice Of Carp,          Pipira,           Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17392,4461,2); -- Slice of Sardine,       Bastore Bream,    Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17392,4471,2); -- Slice of Sardine,       Bladefish,        Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17392,4399,2); -- Slice of Sardine,       Bluetail,         Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17392,4443,2); -- Slice of Sardine,       Cobalt Jellyfish, Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17392,5447,2); -- Slice of Sardine,       Denizanasi,       Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17392,4501,2); -- Slice of Sardine,       Fat Greedie,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17392,4469,2); -- Slice of Sardine,       Giant Catfish,    Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17392,4383,2); -- Slice of Sardine,       Gold Lobster,     Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17392,4500,2); -- Slice of Sardine,       Greedie,          Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17392,4480,2); -- Slice of Sardine,       Gugru Tuna,       Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17392,5132,2); -- Slice of Sardine,       Gurnard,          Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17392,5453,2); -- Slice of Sardine,       Istakoz,          Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17392,5136,2); -- Slice of Sardine,       Istavrit,         Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17392,5454,2); -- Slice of Sardine,       Mercanbaligi,     Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17392,4485,2); -- Slice of Sardine,       Noble Lady,       Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17392,4481,2); -- Slice of Sardine,       Ogre Eel,         Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17392,4305,2); -- Slice of Sardine,       Ryugu Titan,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17392,5141,2); -- Slice of Sardine,       Veydal Wrasse,    Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17392,4385,2); -- Slice of Sardine,       Zafmlug Bass,     Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17392,4288,3); -- Slice of Sardine,       Zebra Eel,        Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17404,4316,2); -- Worm Lure,              Armored Pisces,   Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17404,4314,2); -- Worm Lure,              Bibikibo,         Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17404,4429,2); -- Worm Lure,              Black Eel,        Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17404,5138,2); -- Worm Lure,              Black Ghost,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17404,5469,2); -- Worm Lure,              Brass Loach,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17404,4443,2); -- Worm Lure,              Cobalt Jellyfish, Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17404,4580,3); -- Worm Lure,              Coral Butterfly,  Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17404,4528,2); -- Worm Lure,              Crystal Bass,     Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17404,4428,2); -- Worm Lure,              Dark Bass,        Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17404,5447,2); -- Worm Lure,              Denizanasi,       Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17404,4501,2); -- Worm Lure,              Fat Greedie,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17404,4306,2); -- Worm Lure,              Giant Donko,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17404,4500,2); -- Worm Lure,              Greedie,          Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17404,4307,2); -- Worm Lure,              Jungle Catfish,   Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17404,5460,2); -- Worm Lure,              Kayabaligi,       Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17404,4462,2); -- Worm Lure,              Monke-Onke,       Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17404,5121,3); -- Worm Lure,              Moorish Idol,     Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17404,4464,2); -- Worm Lure,              Pipira,           Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17404,5135,2); -- Worm Lure,              Rhinochimera,     Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17404,4291,3); -- Worm Lure,              Sandfish,         Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17404,5130,2); -- Worm Lure,              Tavnazian Goby,   Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17404,4310,2); -- Worm Lure,              Tiny Goldfish,    Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17404,4317,3); -- Worm Lure,              Trilobite,        Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17404,5137,2); -- Worm Lure,              Turnabaligi,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17404,5463,2); -- Worm Lure,              Yayinbaligi,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17404,4403,3); -- Worm Lure,              Yellow Globe,     Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17404,5458,2); -- Worm Lure,              Yilanbaligi,      Power : 2
INSERT INTO `fishing_bait_affinity` VALUES (17404,4385,3); -- Worm Lure,              Zafmlug Bass,     Power : 3
INSERT INTO `fishing_bait_affinity` VALUES (17007,5129,2); -- Dwarf Pugil,            Lik,              Power : 2
/*!40000 ALTER TABLE `fishing_bait_affinity` ENABLE KEYS */;
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
