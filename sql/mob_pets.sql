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
-- Table structure for table `mob_pets`
--

DROP TABLE IF EXISTS `mob_pets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mob_pets` (
  `mob_mobid` int(10) unsigned NOT NULL,
  `pet_offset` int(10) unsigned NOT NULL DEFAULT '1',
  `job` tinyint(4) DEFAULT '9',
  `mobname` varchar(24) DEFAULT NULL,
  `petname` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`mob_mobid`)
) ENGINE=Aria TRANSACTIONAL=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mob_pets`
--

LOCK TABLES `mob_pets` WRITE;
/*!40000 ALTER TABLE `mob_pets` DISABLE KEYS */;

-- ------------------------------------------------------------
-- AlTaieu (Zone 33)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (16912405,3,9,'Ulaern','Aerns_Xzomit');
INSERT INTO `mob_pets` VALUES (16912406,1,14,'Ulaern','Aerns_Wynav');
INSERT INTO `mob_pets` VALUES (16912418,3,15,'Ulaern','Aerns_Elemental');
INSERT INTO `mob_pets` VALUES (16912473,10,9,'Omaern','Aerns_Xzomit');
INSERT INTO `mob_pets` VALUES (16912474,7,14,'Omaern','Aerns_Wynav');
INSERT INTO `mob_pets` VALUES (16912475,7,15,'Omaern','Aerns_Elemental');
INSERT INTO `mob_pets` VALUES (16912519,1,14,'Omaern','Aerns_Wynav');
INSERT INTO `mob_pets` VALUES (16912528,3,9,'Omaern','Aerns_Xzomit');
INSERT INTO `mob_pets` VALUES (16912529,1,15,'Omaern','Aerns_Elemental');
INSERT INTO `mob_pets` VALUES (16912571,2,14,'Omaern','Aerns_Wynav');
INSERT INTO `mob_pets` VALUES (16912572,2,14,'Omaern','Aerns_Wynav');
INSERT INTO `mob_pets` VALUES (16912588,5,15,'Omaern','Aerns_Elemental');
INSERT INTO `mob_pets` VALUES (16912609,5,9,'Omaern','Aerns_Xzomit');
INSERT INTO `mob_pets` VALUES (16912666,1,9,'Omaern','Aerns_Xzomit');
INSERT INTO `mob_pets` VALUES (16912673,1,14,'Omaern','Aerns_Wynav');
INSERT INTO `mob_pets` VALUES (16912712,1,15,'Omaern','Aerns_Elemental');
INSERT INTO `mob_pets` VALUES (16912724,1,9,'Omaern','Aerns_Xzomit');
INSERT INTO `mob_pets` VALUES (16912726,1,14,'Omaern','Aerns_Wynav');
INSERT INTO `mob_pets` VALUES (16912747,1,14,'Omaern','Aerns_Wynav');
INSERT INTO `mob_pets` VALUES (16912762,1,15,'Omaern','Aerns_Elemental');
INSERT INTO `mob_pets` VALUES (16912839,1,9,'Jailer_of_Justice','Qnxzomit');

-- ------------------------------------------------------------
-- Grand_Palace_of_HuXzoi (Zone 34)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (16916568,1,15,'Eoaern','Aerns_Elemental');
INSERT INTO `mob_pets` VALUES (16916578,1,14,'Eoaern','Aerns_Wynav');
INSERT INTO `mob_pets` VALUES (16916586,4,9,'Eoaern','Aerns_Euvhi');
INSERT INTO `mob_pets` VALUES (16916598,1,14,'Eoaern','Aerns_Wynav');
INSERT INTO `mob_pets` VALUES (16916617,1,15,'Eoaern','Aerns_Elemental');
INSERT INTO `mob_pets` VALUES (16916625,2,9,'Eoaern','Aerns_Euvhi');
INSERT INTO `mob_pets` VALUES (16916626,2,15,'Eoaern','Aerns_Elemental');
INSERT INTO `mob_pets` VALUES (16916639,1,14,'Eoaern','Aerns_Wynav');
INSERT INTO `mob_pets` VALUES (16916644,3,9,'Eoaern','Aerns_Euvhi');
INSERT INTO `mob_pets` VALUES (16916736,1,15,'Eoaern','Aerns_Elemental');
INSERT INTO `mob_pets` VALUES (16916745,1,14,'Eoaern','Aerns_Wynav');
INSERT INTO `mob_pets` VALUES (16916760,2,14,'Eoaern','Aerns_Wynav');
INSERT INTO `mob_pets` VALUES (16916761,2,14,'Eoaern','Aerns_Wynav');
INSERT INTO `mob_pets` VALUES (16916793,2,15,'Eoaern','Aerns_Elemental');
INSERT INTO `mob_pets` VALUES (16916794,2,15,'Eoaern','Aerns_Elemental');
INSERT INTO `mob_pets` VALUES (16916805,1,14,'Eoaern','Aerns_Wynav');
INSERT INTO `mob_pets` VALUES (16916809,3,9,'Eoaern','Aerns_Euvhi');

-- ------------------------------------------------------------
-- The_Garden_of_RuHmet (Zone 35)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (16920596,1,14,'Awaern','Aerns_Wynav');
INSERT INTO `mob_pets` VALUES (16920606,1,9,'Awaern','Aerns_Euvhi');
INSERT INTO `mob_pets` VALUES (16920609,1,15,'Awaern','Aerns_Elemental');
INSERT INTO `mob_pets` VALUES (16920648,1,15,'Awaern','Aerns_Elemental');
INSERT INTO `mob_pets` VALUES (16920657,1,9,'Awaern','Aerns_Euvhi');
INSERT INTO `mob_pets` VALUES (16920662,1,14,'Awaern','Aerns_Wynav');
INSERT INTO `mob_pets` VALUES (16920779,1,9,'Awaern','Aerns_Euvhi');
INSERT INTO `mob_pets` VALUES (16920783,1,14,'Awaern','Aerns_Wynav');
INSERT INTO `mob_pets` VALUES (16920787,1,15,'Awaern','Aerns_Elemental');

-- ------------------------------------------------------------
-- Temenos (Zone 37)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (16928790,1,14,'Telchines_Dragoon','Telchiness_Wyvern');
INSERT INTO `mob_pets` VALUES (16928799,1,15,'Kindred_Summoner','Kindreds_Elemental');
INSERT INTO `mob_pets` VALUES (16928819,1,15,'Cryptonberry_Designator','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (16928823,1,15,'Cryptonberry_Designator','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (16928827,1,15,'Cryptonberry_Designator','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (16928988,1,15,'Koo_Buzu_the_Theomanic','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (16929007,1,15,'Pee_Qoho_the_Python','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (16929015,1,14,'Grognard_Impaler','Orcs_Wyvern');
INSERT INTO `mob_pets` VALUES (16929055,1,14,'Temenos_Aern','Aerns_Wynav');
INSERT INTO `mob_pets` VALUES (16929058,1,9,'Temenos_Aern','Aerns_Euvhi');
INSERT INTO `mob_pets` VALUES (16929066,1,15,'Temenos_Aern','Aerns_Elemental');
INSERT INTO `mob_pets` VALUES (16929069,1,14,'Temenos_Aern','Aerns_Wynav');
INSERT INTO `mob_pets` VALUES (16929073,1,9,'Temenos_Aern','Aerns_Euvhi');
INSERT INTO `mob_pets` VALUES (16929079,1,15,'Temenos_Aern','Aerns_Elemental');
INSERT INTO `mob_pets` VALUES (16929098,1,14,'Temenos_Aern','Aerns_Wynav');
INSERT INTO `mob_pets` VALUES (16929101,1,14,'Temenos_Aern','Aerns_Wynav');
INSERT INTO `mob_pets` VALUES (16929113,1,15,'Temenos_Aern','Aerns_Elemental');

-- ------------------------------------------------------------
-- Apollyon (Zone 38)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (16933135,1,14,'Grognard_Impaler','Orcs_Wyvern');
INSERT INTO `mob_pets` VALUES (16933144,1,15,'Dee_Wapa_the_Desolator','Yagudos_Elemental');

-- ------------------------------------------------------------
-- Dynamis-Beaucedine (Zone 134)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17326093,1,14,'Taquede','Taquedes_Wyvern');
INSERT INTO `mob_pets` VALUES (17326103,1,9,'Vanguard_Beasttender','Vanguards_Scorpion');
INSERT INTO `mob_pets` VALUES (17326111,1,14,'Vanguard_Drakekeeper','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17326124,1,15,'Vanguard_Undertaker','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17326143,1,9,'Vanguard_Beasttender','Vanguards_Scorpion');
INSERT INTO `mob_pets` VALUES (17326146,1,15,'Vanguard_Undertaker','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17326157,1,14,'Vanguard_Drakekeeper','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17326162,1,14,'GoTyo_Magenapper','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17326177,1,9,'Vanguard_Beasttender','Vanguards_Scorpion');
INSERT INTO `mob_pets` VALUES (17326179,1,9,'SoGho_Adderhandler','Vanguards_Scorpion');
INSERT INTO `mob_pets` VALUES (17326199,1,15,'Vanguard_Undertaker','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17326201,1,15,'BeZhe_Keeprazer','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17326225,1,14,'Vanguard_Impaler','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17326231,1,15,'Vanguard_Dollmaster','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17326233,1,15,'Deathcaller_Bidfbid','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17326239,1,9,'Vanguard_Hawker','Vanguards_Hecteyes');
INSERT INTO `mob_pets` VALUES (17326252,1,15,'Vanguard_Dollmaster','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17326263,1,9,'Vanguard_Hawker','Vanguards_Hecteyes');
INSERT INTO `mob_pets` VALUES (17326265,1,9,'Mithraslaver_Debhabob','Vanguards_Hecteyes');
INSERT INTO `mob_pets` VALUES (17326271,1,14,'Vanguard_Impaler','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17326273,1,14,'Drakefeast_Wubmfub','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17326291,1,9,'Vanguard_Ogresoother','Vanguards_Crow');
INSERT INTO `mob_pets` VALUES (17326305,1,14,'Vanguard_Partisan','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17326307,1,14,'Maa_Zaua_the_Wyrmkeeper','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17326315,1,15,'Vanguard_Oracle','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17326326,1,9,'Vanguard_Ogresoother','Vanguards_Crow');
INSERT INTO `mob_pets` VALUES (17326328,1,9,'Soo_Jopo_the_Fiendking','Vanguards_Crow');
INSERT INTO `mob_pets` VALUES (17326331,1,14,'Vanguard_Partisan','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17326345,1,15,'Vanguard_Oracle','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17326347,1,15,'Puu_Timu_the_Phantasmal','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17326358,1,9,'Vanguard_Pathfinder','Vanguards_Slime');
INSERT INTO `mob_pets` VALUES (17326368,1,15,'Vanguard_Necromancer','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17326383,1,14,'Vanguard_Dragontamer','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17326391,1,15,'Vanguard_Necromancer','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17326406,1,9,'Vanguard_Pathfinder','Vanguards_Slime');
INSERT INTO `mob_pets` VALUES (17326417,1,9,'Vanguard_Pathfinder','Vanguards_Slime');
INSERT INTO `mob_pets` VALUES (17326419,1,14,'Vanguard_Dragontamer','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17326421,1,14,'Draklix_Scalecrust','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17326435,1,14,'Vanguard_Dragontamer','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17326437,1,9,'Vanguard_Pathfinder','Vanguards_Slime');
INSERT INTO `mob_pets` VALUES (17326439,1,9,'Routsix_Rubbertendon','Vanguards_Slime');
INSERT INTO `mob_pets` VALUES (17326444,1,15,'Vanguard_Necromancer','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17326446,1,15,'Morblox_Chubbychin','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17326454,1,14,'Vanguard_Dragontamer','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17326482,1,9,'Hydra_Beastmaster','Hydras_Hound');
INSERT INTO `mob_pets` VALUES (17326492,1,14,'Hydra_Dragoon','Hydras_Wyvern');
INSERT INTO `mob_pets` VALUES (17326499,1,15,'Hydra_Summoner','Hydras_Avatar');
INSERT INTO `mob_pets` VALUES (17326503,1,14,'Hydra_Dragoon','Hydras_Wyvern');
INSERT INTO `mob_pets` VALUES (17326505,1,15,'Hydra_Summoner','Hydras_Avatar');
INSERT INTO `mob_pets` VALUES (17326509,1,9,'Hydra_Beastmaster','Hydras_Hound');
INSERT INTO `mob_pets` VALUES (17326531,1,14,'Hydra_Dragoon','Hydras_Wyvern');
INSERT INTO `mob_pets` VALUES (17326540,1,15,'Hydra_Summoner','Hydras_Avatar');
INSERT INTO `mob_pets` VALUES (17326549,1,14,'Hydra_Dragoon','Hydras_Wyvern');
INSERT INTO `mob_pets` VALUES (17326584,1,15,'Hydra_Summoner','Hydras_Avatar');
INSERT INTO `mob_pets` VALUES (17326587,1,9,'Hydra_Beastmaster','Hydras_Hound');
INSERT INTO `mob_pets` VALUES (17326594,1,14,'Hydra_Dragoon','Hydras_Wyvern');
INSERT INTO `mob_pets` VALUES (17326601,1,9,'Hydra_Beastmaster','Hydras_Hound');
INSERT INTO `mob_pets` VALUES (17326603,1,9,'Hydra_Beastmaster','Hydras_Hound');
INSERT INTO `mob_pets` VALUES (17326621,1,15,'Hydra_Summoner','Hydras_Avatar');
INSERT INTO `mob_pets` VALUES (17326627,1,14,'Hydra_Dragoon','Hydras_Wyvern');
INSERT INTO `mob_pets` VALUES (17326640,1,14,'Hydra_Dragoon','Hydras_Wyvern');
INSERT INTO `mob_pets` VALUES (17326642,1,14,'Hydra_Dragoon','Hydras_Wyvern');
INSERT INTO `mob_pets` VALUES (17326662,1,15,'Hydra_Summoner','Hydras_Avatar');
INSERT INTO `mob_pets` VALUES (17326664,1,15,'Hydra_Summoner','Hydras_Avatar');
INSERT INTO `mob_pets` VALUES (17326685,1,9,'Hydra_Beastmaster','Hydras_Hound');
INSERT INTO `mob_pets` VALUES (17326699,1,15,'Hydra_Summoner','Hydras_Avatar');
INSERT INTO `mob_pets` VALUES (17326704,1,14,'Hydra_Dragoon','Hydras_Wyvern');
INSERT INTO `mob_pets` VALUES (17326715,1,9,'Hydra_Beastmaster','Hydras_Hound');
INSERT INTO `mob_pets` VALUES (17326724,1,15,'Hydra_Summoner','Hydras_Avatar');
INSERT INTO `mob_pets` VALUES (17326734,1,14,'Hydra_Dragoon','Hydras_Wyvern');
INSERT INTO `mob_pets` VALUES (17326746,1,14,'Hydra_Dragoon','Hydras_Wyvern');
INSERT INTO `mob_pets` VALUES (17326752,1,15,'Hydra_Summoner','Hydras_Avatar');
INSERT INTO `mob_pets` VALUES (17326758,1,9,'Hydra_Beastmaster','Hydras_Hound');
INSERT INTO `mob_pets` VALUES (17326769,1,14,'Hydra_Dragoon','Hydras_Wyvern');
INSERT INTO `mob_pets` VALUES (17326775,1,15,'Hydra_Summoner','Hydras_Avatar');
INSERT INTO `mob_pets` VALUES (17326783,1,9,'Hydra_Beastmaster','Hydras_Hound');

-- ------------------------------------------------------------
-- Dynamis-Xarcabard (Zone 135)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17330186,1,9,'Marquis_Caim','Caims_Vouivre');
INSERT INTO `mob_pets` VALUES (17330189,1,15,'Count_Haagenti','Haagentis_Avatar');
INSERT INTO `mob_pets` VALUES (17330219,1,9,'Kindred_Beastmaster','Kindreds_Vouivre');
INSERT INTO `mob_pets` VALUES (17330228,1,15,'Kindred_Summoner','Kindreds_Avatar');
INSERT INTO `mob_pets` VALUES (17330232,1,14,'Kindred_Dragoon','Kindreds_Wyvern');
INSERT INTO `mob_pets` VALUES (17330234,1,14,'Kindred_Dragoon','Kindreds_Wyvern');
INSERT INTO `mob_pets` VALUES (17330246,1,9,'Kindred_Beastmaster','Kindreds_Vouivre');
INSERT INTO `mob_pets` VALUES (17330254,1,15,'Kindred_Summoner','Kindreds_Avatar');
INSERT INTO `mob_pets` VALUES (17330263,1,14,'Kindred_Dragoon','Kindreds_Wyvern');
INSERT INTO `mob_pets` VALUES (17330281,1,15,'Kindred_Summoner','Kindreds_Avatar');
INSERT INTO `mob_pets` VALUES (17330283,1,15,'Kindred_Summoner','Kindreds_Avatar');
INSERT INTO `mob_pets` VALUES (17330296,1,9,'Kindred_Beastmaster','Kindreds_Vouivre');
INSERT INTO `mob_pets` VALUES (17330329,1,14,'Kindred_Dragoon','Kindreds_Wyvern');
INSERT INTO `mob_pets` VALUES (17330378,1,9,'Kindred_Beastmaster','Kindreds_Vouivre');
INSERT INTO `mob_pets` VALUES (17330388,1,9,'Kindred_Beastmaster','Kindreds_Vouivre');
INSERT INTO `mob_pets` VALUES (17330390,1,9,'Marquis_Andras','Andrass_Vouivre');
INSERT INTO `mob_pets` VALUES (17330418,1,14,'Kindred_Dragoon','Kindreds_Wyvern');
INSERT INTO `mob_pets` VALUES (17330428,1,14,'Kindred_Dragoon','Kindreds_Wyvern');
INSERT INTO `mob_pets` VALUES (17330430,1,14,'King_Zagan','Zagans_Wyvern');
INSERT INTO `mob_pets` VALUES (17330452,1,15,'Kindred_Summoner','Kindreds_Avatar');
INSERT INTO `mob_pets` VALUES (17330469,1,9,'Kindred_Beastmaster','Kindreds_Vouivre');
INSERT INTO `mob_pets` VALUES (17330477,1,14,'Kindred_Dragoon','Kindreds_Wyvern');
INSERT INTO `mob_pets` VALUES (17330479,1,15,'Kindred_Summoner','Kindreds_Avatar');
INSERT INTO `mob_pets` VALUES (17330481,1,15,'Marquis_Nebiros','Nebiross_Avatar');
INSERT INTO `mob_pets` VALUES (17330493,1,15,'Kindred_Summoner','Kindreds_Avatar');
INSERT INTO `mob_pets` VALUES (17330501,1,15,'Kindred_Summoner','Kindreds_Avatar');
INSERT INTO `mob_pets` VALUES (17330554,1,9,'Kindred_Beastmaster','Kindreds_Vouivre');
INSERT INTO `mob_pets` VALUES (17330560,1,9,'Kindred_Beastmaster','Kindreds_Vouivre');
INSERT INTO `mob_pets` VALUES (17330572,1,14,'Kindred_Dragoon','Kindreds_Wyvern');
INSERT INTO `mob_pets` VALUES (17330574,1,15,'Kindred_Summoner','Kindreds_Avatar');
INSERT INTO `mob_pets` VALUES (17330596,1,15,'Kindred_Summoner','Kindreds_Avatar');
INSERT INTO `mob_pets` VALUES (17330599,1,9,'Kindred_Beastmaster','Kindreds_Vouivre');
INSERT INTO `mob_pets` VALUES (17330608,1,14,'Kindred_Dragoon','Kindreds_Wyvern');
INSERT INTO `mob_pets` VALUES (17330615,1,15,'Kindred_Summoner','Kindreds_Avatar');
INSERT INTO `mob_pets` VALUES (17330634,1,9,'Kindred_Beastmaster','Kindreds_Vouivre');
INSERT INTO `mob_pets` VALUES (17330639,1,14,'Kindred_Dragoon','Kindreds_Wyvern');
INSERT INTO `mob_pets` VALUES (17330643,1,14,'Kindred_Dragoon','Kindreds_Wyvern');
INSERT INTO `mob_pets` VALUES (17330645,1,15,'Kindred_Summoner','Kindreds_Avatar');
INSERT INTO `mob_pets` VALUES (17330653,1,14,'Kindred_Dragoon','Kindreds_Wyvern');
INSERT INTO `mob_pets` VALUES (17330670,1,9,'Kindred_Beastmaster','Kindreds_Vouivre');
INSERT INTO `mob_pets` VALUES (17330677,1,15,'Kindred_Summoner','Kindreds_Avatar');
INSERT INTO `mob_pets` VALUES (17330693,1,14,'Kindred_Dragoon','Kindreds_Wyvern');
INSERT INTO `mob_pets` VALUES (17330695,1,15,'Kindred_Summoner','Kindreds_Avatar');
INSERT INTO `mob_pets` VALUES (17330699,1,14,'Kindred_Dragoon','Kindreds_Wyvern');
INSERT INTO `mob_pets` VALUES (17330701,1,15,'Kindred_Summoner','Kindreds_Avatar');
INSERT INTO `mob_pets` VALUES (17330710,1,14,'Kindred_Dragoon','Kindreds_Wyvern');
INSERT INTO `mob_pets` VALUES (17330714,1,15,'Kindred_Summoner','Kindreds_Avatar');
INSERT INTO `mob_pets` VALUES (17330716,1,15,'Kindred_Summoner','Kindreds_Avatar');
INSERT INTO `mob_pets` VALUES (17330734,1,9,'Kindred_Beastmaster','Kindreds_Vouivre');
INSERT INTO `mob_pets` VALUES (17330736,1,9,'Kindred_Beastmaster','Kindreds_Vouivre');
INSERT INTO `mob_pets` VALUES (17330744,1,14,'Kindred_Dragoon','Kindreds_Wyvern');
INSERT INTO `mob_pets` VALUES (17330759,1,9,'Kindred_Beastmaster','Kindreds_Vouivre');
INSERT INTO `mob_pets` VALUES (17330766,1,14,'Kindred_Dragoon','Kindreds_Wyvern');
INSERT INTO `mob_pets` VALUES (17330768,1,15,'Kindred_Summoner','Kindreds_Avatar');

-- ------------------------------------------------------------
-- Beaucedine_Glacier_[S] (Zone 136)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17334338,1,9,'Gigas_Flesher','Gigass_Tiger');
INSERT INTO `mob_pets` VALUES (17334340,1,9,'Gigas_Flesher','Gigass_Tiger');
INSERT INTO `mob_pets` VALUES (17334346,1,9,'Gigas_Flesher','Gigass_Tiger');
INSERT INTO `mob_pets` VALUES (17334357,1,9,'Gigas_Flesher','Gigass_Tiger');
INSERT INTO `mob_pets` VALUES (17334362,1,9,'Gigas_Flesher','Gigass_Tiger');
INSERT INTO `mob_pets` VALUES (17334368,1,9,'Gigas_Flesher','Gigass_Tiger');
INSERT INTO `mob_pets` VALUES (17334377,1,9,'Gigas_Flesher','Gigass_Tiger');

-- ------------------------------------------------------------
-- Xarcabard_[S] (Zone 137)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17338381,1,9,'Gigas_Flogger','Gigass_Tiger');
INSERT INTO `mob_pets` VALUES (17338388,1,9,'Gigas_Flogger','Gigass_Tiger');
INSERT INTO `mob_pets` VALUES (17338390,1,9,'Gigas_Flogger','Gigass_Tiger');
INSERT INTO `mob_pets` VALUES (17338396,1,9,'Gigas_Flogger','Gigass_Tiger');
INSERT INTO `mob_pets` VALUES (17338402,1,9,'Gigas_Flogger','Gigass_Tiger');
INSERT INTO `mob_pets` VALUES (17338427,1,9,'Gigas_Flogger','Gigass_Tiger');
INSERT INTO `mob_pets` VALUES (17338438,1,15,'Demon_Justiciar','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17338447,1,15,'Adjudicator_Demon','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17338455,1,15,'Demon_Justiciar','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17338460,1,15,'Demon_Justiciar','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17338484,1,15,'Adjudicator_Demon','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17338496,1,15,'Demon_Justiciar','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17338500,1,15,'Demon_Justiciar','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17338504,1,15,'Demon_Justiciar','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17338512,1,15,'Demon_Justiciar','Demons_Elemental');

-- ------------------------------------------------------------
-- Castle_Zvahl_Baileys_[S] (Zone 138)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17342473,1,15,'Demon_Justiciar','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17342485,1,15,'Demon_Justiciar','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17342496,1,15,'Demon_Justiciar','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17342524,1,15,'Demon_Justiciar','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17342528,1,15,'Demon_Justiciar','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17342600,1,15,'Demon_Justiciar','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17342610,1,15,'Demon_Justiciar','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17342620,1,15,'Demon_Justiciar','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17342625,1,15,'Demon_Condemner','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17342630,1,15,'Demon_Condemner','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17342635,1,15,'Demon_Condemner','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17342637,1,15,'Foredoomer_Demon','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17342647,1,15,'Foredoomer_Demon','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17342651,1,15,'Foredoomer_Demon','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17342658,1,15,'Foredoomer_Demon','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17342662,1,15,'Foredoomer_Demon','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17342664,1,15,'Foredoomer_Demon','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17342668,1,15,'Foredoomer_Demon','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17342682,1,15,'Demon_Condemner','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17342689,1,15,'Demon_Condemner','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17342691,1,15,'Foredoomer_Demon','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17342711,1,15,'Foredoomer_Demon','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17342720,1,15,'Foredoomer_Demon','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17342723,1,15,'Foredoomer_Demon','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17342727,1,15,'Foredoomer_Demon','Demons_Elemental');

-- ------------------------------------------------------------
-- Horlais_Peak (Zone 139)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17346569,3,14,'Derakbak_of_Clan_Wolf','Orcs_Wyvern');
INSERT INTO `mob_pets` VALUES (17346575,3,14,'Derakbak_of_Clan_Wolf','Orcs_Wyvern');
INSERT INTO `mob_pets` VALUES (17346581,3,14,'Derakbak_of_Clan_Wolf','Orcs_Wyvern');

-- ------------------------------------------------------------
-- Waughroon_Shrine (Zone 144)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17367061,1,15,'Onki','Onibi');
INSERT INTO `mob_pets` VALUES (17367066,1,15,'Onki','Onibi');
INSERT INTO `mob_pets` VALUES (17367071,1,15,'Onki','Onibi');
INSERT INTO `mob_pets` VALUES (17367080,1,9,'Maat','Maats_Pet');
INSERT INTO `mob_pets` VALUES (17367082,1,9,'Maat','Maats_Pet');
INSERT INTO `mob_pets` VALUES (17367084,1,9,'Maat','Maats_Pet');

-- ------------------------------------------------------------
-- Giddeus (Zone 145)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17371277,1,15,'Yagudo_Mendicant','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17371284,1,15,'Yagudo_Mendicant','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17371288,1,15,'Yagudo_Mendicant','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17371293,1,15,'Yagudo_Mendicant','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17371302,1,15,'Yagudo_Mendicant','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17371306,1,15,'Yagudo_Mendicant','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17371311,1,15,'Yagudo_Mendicant','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17371315,1,15,'Yagudo_Mendicant','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17371323,1,15,'Yagudo_Mendicant','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17371333,1,15,'Yagudo_Mendicant','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17371337,1,15,'Yagudo_Mendicant','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17371350,1,15,'Yagudo_Mendicant','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17371360,1,15,'Yagudo_Mendicant','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17371364,1,15,'Yagudo_Mendicant','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17371370,1,15,'Yagudo_Mendicant','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17371374,1,15,'Yagudo_Mendicant','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17371380,1,15,'Yagudo_Mendicant','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17371384,1,15,'Yagudo_Mendicant','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17371390,1,15,'Yagudo_Mendicant','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17371394,1,15,'Yagudo_Mendicant','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17371400,1,15,'Yagudo_Mendicant','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17371404,1,15,'Yagudo_Mendicant','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17371409,1,15,'Yagudo_Mendicant','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17371416,1,15,'Yagudo_Mendicant','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17371420,1,15,'Yagudo_Mendicant','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17371424,1,15,'Yagudo_Mendicant','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17371430,1,15,'Yagudo_Mendicant','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17371434,1,15,'Yagudo_Mendicant','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17371440,1,15,'Yagudo_Mendicant','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17371447,1,15,'Yagudo_Mendicant','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17371453,1,15,'Yagudo_Mendicant','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17371457,1,15,'Yagudo_Mendicant','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17371461,1,15,'Yagudo_Mendicant','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17371465,1,15,'Yagudo_Mendicant','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17371469,1,15,'Yagudo_Mendicant','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17371475,1,15,'Yagudo_Mendicant','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17371482,1,15,'Yagudo_Mendicant','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17371486,1,15,'Yagudo_Mendicant','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17371490,1,15,'Yagudo_Mendicant','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17371498,1,15,'Yagudo_Mendicant','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17371504,1,15,'Yagudo_Mendicant','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17371508,1,15,'Yagudo_Mendicant','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17371513,1,15,'Yagudo_Mendicant','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17371516,1,15,'Yagudo_Mendicant','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17371522,1,15,'Yagudo_Mendicant','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17371526,1,15,'Yagudo_Mendicant','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17371530,1,15,'Yagudo_Mendicant','Yagudos_Elemental');

-- ------------------------------------------------------------
-- Balgas_Dais (Zone 146)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17375242,1,15,'Chaa_Paqa_the_Profound','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17375248,1,15,'Chaa_Paqa_the_Profound','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17375254,1,15,'Chaa_Paqa_the_Profound','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17375263,1,15,'Maat','Maats_Avatar');
INSERT INTO `mob_pets` VALUES (17375265,1,15,'Maat','Maats_Avatar');
INSERT INTO `mob_pets` VALUES (17375267,1,15,'Maat','Maats_Avatar');

-- ------------------------------------------------------------
-- Davoi (Zone 149)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17387585,1,14,'Steelbiter_Gudrud','Orcs_Wyvern');

-- ------------------------------------------------------------
-- Castle_Oztroja (Zone 151)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17395759,1,15,'Yagudo_Oracle','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17395767,1,15,'Yagudo_Oracle','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17395776,1,15,'Yagudo_Oracle','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17395796,1,15,'Yagudo_Oracle','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17395831,1,15,'Yagudo_Oracle','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17395845,1,15,'Yagudo_Oracle','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17395853,1,15,'Yagudo_Oracle','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17395868,1,15,'Yagudo_Oracle','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17395872,1,15,'Yagudo_Oracle','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17395883,1,15,'Yagudo_Oracle','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17395887,1,15,'Yagudo_Oracle','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17395897,1,15,'Yagudo_Oracle','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17395908,1,15,'Yagudo_Oracle','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17395915,1,15,'Yagudo_Oracle','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17395926,1,15,'Yagudo_Oracle','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17395930,1,15,'Yagudo_Oracle','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17395934,1,15,'Yagudo_Oracle','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17395958,1,15,'Yagudo_Oracle','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17395962,1,15,'Yagudo_Oracle','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17395968,1,15,'Yagudo_Oracle','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17395976,1,15,'Yagudo_Oracle','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17395983,1,15,'Yagudo_Oracle','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17395988,1,15,'Yagudo_Oracle','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17395997,1,15,'Yagudo_Oracle','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17396002,1,15,'Yagudo_Oracle','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17396006,1,15,'Yagudo_Oracle','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17396009,1,15,'Yagudo_Oracle','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17396017,1,15,'Yagudo_Oracle','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17396022,1,15,'Yagudo_Oracle','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17396026,1,15,'Yagudo_Oracle','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17396134,1,15,'Yagudo_Avatar','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17396137,1,15,'Tzee_Xicu_the_Manifest','Yagudos_Elemental');

-- ------------------------------------------------------------
-- Altar_Room (Zone 152)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17399809,1,15,'Yagudo_Avatar','Yagudos_Elemental');

-- ------------------------------------------------------------
-- Castle_Zvahl_Keep_[S] (Zone 155)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17412224,1,15,'Demon_Justiciar','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17412234,1,15,'Demon_Justiciar','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17412246,1,15,'Demon_Justiciar','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17412256,1,15,'Demon_Justiciar','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17412258,1,15,'Demon_Justiciar','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17412267,1,15,'Demon_Condemner','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17412274,1,15,'Demon_Condemner','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17412277,1,15,'Adjudicator_Demon','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17412286,1,15,'Adjudicator_Demon','Demons_Elemental');

-- ------------------------------------------------------------
-- Middle_Delkfutts_Tower (Zone 157)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17420294,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17420299,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17420304,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17420309,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17420316,1,9,'Giant_Sentry','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17420321,1,9,'Giant_Sentry','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17420327,1,9,'Giant_Sentry','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17420330,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17420335,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17420355,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17420360,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17420367,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17420372,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17420379,1,9,'Giant_Sentry','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17420385,1,9,'Giant_Sentry','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17420390,1,9,'Giant_Sentry','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17420395,1,9,'Giant_Sentry','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17420400,1,9,'Giant_Sentry','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17420405,1,9,'Giant_Sentry','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17420410,1,9,'Giant_Sentry','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17420420,1,9,'Giant_Sentry','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17420423,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17420428,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17420433,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17420440,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17420445,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17420450,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17420455,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17420460,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17420465,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17420472,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17420477,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17420487,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17420492,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17420499,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17420504,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17420513,1,9,'Gigas_Kettlemaster','Gigass_Bats');
INSERT INTO `mob_pets` VALUES (17420518,1,9,'Gigas_Kettlemaster','Gigass_Bats');
INSERT INTO `mob_pets` VALUES (17420527,1,9,'Gigas_Kettlemaster','Gigass_Bats');
INSERT INTO `mob_pets` VALUES (17420529,1,9,'Ophion','Gigass_Bats');
INSERT INTO `mob_pets` VALUES (17420535,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17420540,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17420547,1,9,'Gigas_Kettlemaster','Gigass_Bats');
INSERT INTO `mob_pets` VALUES (17420552,1,9,'Gigas_Kettlemaster','Gigass_Bats');
INSERT INTO `mob_pets` VALUES (17420559,1,9,'Gigas_Kettlemaster','Gigass_Bats');
INSERT INTO `mob_pets` VALUES (17420564,1,9,'Gigas_Kettlemaster','Gigass_Bats');
INSERT INTO `mob_pets` VALUES (17420597,1,9,'Gigas_Kettlemaster','Gigass_Bats');
INSERT INTO `mob_pets` VALUES (17420602,1,9,'Gigas_Kettlemaster','Gigass_Bats');
INSERT INTO `mob_pets` VALUES (17420607,1,9,'Gigas_Kettlemaster','Gigass_Bats');
INSERT INTO `mob_pets` VALUES (17420612,1,9,'Gigas_Kettlemaster','Gigass_Bats');
INSERT INTO `mob_pets` VALUES (17420615,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17420620,1,9,'Goblin_Pathfinder','Goblins_Bat');

-- ------------------------------------------------------------
-- Upper_Delkfutts_Tower (Zone 158)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17424385,1,9,'Enkelados','Gigass_Bats');
INSERT INTO `mob_pets` VALUES (17424388,1,9,'Gigas_Bonecutter','Gigass_Bats');
INSERT INTO `mob_pets` VALUES (17424393,1,9,'Gigas_Bonecutter','Gigass_Bats');
INSERT INTO `mob_pets` VALUES (17424400,1,9,'Gigas_Bonecutter','Gigass_Bats');
INSERT INTO `mob_pets` VALUES (17424407,1,9,'Gigas_Bonecutter','Gigass_Bats');
INSERT INTO `mob_pets` VALUES (17424414,1,9,'Gigas_Bonecutter','Gigass_Bats');
INSERT INTO `mob_pets` VALUES (17424423,1,9,'Enkelados','Gigass_Bats');
INSERT INTO `mob_pets` VALUES (17424426,1,9,'Gigas_Bonecutter','Gigass_Bats');
INSERT INTO `mob_pets` VALUES (17424434,1,9,'Gigas_Bonecutter','Gigass_Bats');
INSERT INTO `mob_pets` VALUES (17424439,1,9,'Gigas_Bonecutter','Gigass_Bats');
INSERT INTO `mob_pets` VALUES (17424444,1,9,'Pallas','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17424455,1,9,'Jotunn_Wildkeeper','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17424460,1,9,'Jotunn_Wildkeeper','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17424465,1,9,'Jotunn_Wildkeeper','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17424470,1,9,'Jotunn_Wildkeeper','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17424492,1,9,'Jotunn_Wildkeeper','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17424497,1,9,'Jotunn_Wildkeeper','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17424502,1,9,'Jotunn_Wildkeeper','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17424507,1,9,'Jotunn_Wildkeeper','Gigass_Bat');

-- ------------------------------------------------------------
-- Temple_of_Uggalepih (Zone 159)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17428505,1,15,'Tonberry_Harrier','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428515,1,15,'Tonberry_Harrier','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428528,1,15,'Tonberry_Harrier','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428543,1,15,'Tonberry_Harrier','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428552,1,15,'Tonberry_Harrier','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428556,1,15,'Tonberry_Harrier','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428559,1,15,'Tonberry_Harrier','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428562,1,15,'Tonberry_Harrier','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428570,1,15,'Tonberry_Harrier','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428589,1,15,'Tonberry_Harrier','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428596,1,15,'Tonberry_Harrier','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428601,1,15,'Tonberry_Harrier','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428608,1,15,'Tonberry_Harrier','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428611,1,15,'Sozu_Terberry','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428625,1,15,'Tonberry_Harrier','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428634,1,15,'Tonberry_Harrier','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428641,1,15,'Tonberry_Harrier','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428643,1,15,'Tonberry_Harrier','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428656,1,15,'Tonberry_Harrier','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428659,1,15,'Tonberry_Harrier','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428662,1,15,'Tonberry_Harrier','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428664,1,15,'Tonberry_Harrier','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428673,1,15,'Tonberry_Dismayer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428675,1,15,'Tonberry_Dismayer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428677,1,15,'Tonberry_Kinq','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428680,1,15,'Tonberry_Harrier','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428683,1,15,'Tonberry_Harrier','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428691,1,15,'Tonberry_Dismayer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428698,1,15,'Tonberry_Dismayer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428707,1,15,'Tonberry_Dismayer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428721,1,15,'Tonberry_Dismayer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428731,1,15,'Tonberry_Harrier','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428735,1,15,'Tonberry_Harrier','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428742,1,15,'Tonberry_Harrier','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428767,1,15,'Tonberry_Dismayer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428773,1,15,'Tonberry_Dismayer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428778,1,15,'Tonberry_Dismayer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428792,1,15,'Tonberry_Dismayer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428801,1,15,'Tonberry_Dismayer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17428813,1,15,'Crimson-toothed_Pawberry','Tonberrys_Elemental');

-- ------------------------------------------------------------
-- Den_of_Rancor (Zone 160)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17432632,1,15,'Tonberry_Beleaguerer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17432659,1,15,'Carmine-tailed_Janberry','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17432723,1,15,'Tonberry_Beleaguerer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17432789,1,15,'Tonberry_Beleaguerer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17432799,1,15,'Tonberry_Beleaguerer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17432802,1,15,'Tonberry_Beleaguerer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17432820,1,15,'Tonberry_Beleaguerer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17432822,1,15,'Tonberry_Beleaguerer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17432851,1,15,'Tonberry_Beleaguerer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17432857,1,15,'Tonberry_Beleaguerer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17432861,1,15,'Tonberry_Beleaguerer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17432868,1,15,'Tonberry_Beleaguerer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17432915,1,15,'Tonberry_Beleaguerer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17432924,1,15,'Tonberry_Beleaguerer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17432936,1,15,'Tonberry_Beleaguerer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17432957,1,15,'Tonberry_Beleaguerer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17432961,1,15,'Tonberry_Beleaguerer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17432965,1,15,'Tonberry_Beleaguerer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17432981,1,15,'Tonberry_Beleaguerer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17432985,1,15,'Tonberry_Beleaguerer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17432987,1,15,'Tonberry_Beleaguerer','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17432999,1,15,'Tonberry_Beleaguerer','Tonberrys_Elemental');

-- ------------------------------------------------------------
-- Castle_Zvahl_Baileys (Zone 161)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17436726,1,9,'Goblin_Trader','Goblins_Bats');
INSERT INTO `mob_pets` VALUES (17436735,1,9,'Goblin_Trader','Goblins_Bats');
INSERT INTO `mob_pets` VALUES (17436745,1,15,'Demon_Warlock','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17436749,1,15,'Demon_Warlock','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17436752,1,9,'Goblin_Trader','Goblins_Bats');
INSERT INTO `mob_pets` VALUES (17436761,1,9,'Goblin_Trader','Goblins_Bats');
INSERT INTO `mob_pets` VALUES (17436775,1,9,'Goblin_Trader','Goblins_Bats');
INSERT INTO `mob_pets` VALUES (17436837,1,15,'Demon_Warlock','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17436847,1,15,'Demon_Magistrate','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17436852,1,15,'Demon_Magistrate','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17436857,1,15,'Demon_Magistrate','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17436862,1,15,'Demon_Magistrate','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17436867,1,15,'Demon_Magistrate','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17436874,1,15,'Abyssal_Demon','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17436879,1,15,'Abyssal_Demon','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17436884,1,15,'Abyssal_Demon','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17436888,1,15,'Abyssal_Demon','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17436895,1,15,'Abyssal_Demon','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17436899,1,15,'Abyssal_Demon','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17436911,1,15,'Stygian_Demon','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17436916,1,15,'Stygian_Demon','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17436921,1,15,'Stygian_Demon','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17436927,1,15,'Grand_Duke_Batym','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17436946,1,15,'Stygian_Demon','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17436951,1,15,'Stygian_Demon','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17436956,1,15,'Stygian_Demon','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17436962,1,15,'Stygian_Demon','Demons_Elemental');

-- ------------------------------------------------------------
-- Castle_Zvahl_Keep (Zone 162)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17440777,1,15,'Demon_Warlock','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17440781,1,9,'Goblin_Trader','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17440786,1,9,'Goblin_Trader','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17440791,1,9,'Goblin_Trader','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17440796,1,9,'Goblin_Trader','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17440960,1,15,'Demon_Warlock','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17440966,1,15,'Demon_Warlock','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17440973,1,15,'Demon_Warlock','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17440975,1,15,'Viscount_Morax','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17440992,1,15,'Demon_Warlock','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17440997,1,15,'Demon_Warlock','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17441005,1,15,'Demon_Warlock','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17441008,1,15,'Demon_Warlock','Demons_Elemental');

-- ------------------------------------------------------------
-- Sacrificial_Chamber (Zone 163)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17444867,1,15,'Tungsiton','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17444872,1,15,'Tungsiton','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17444877,1,15,'Tungsiton','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17444883,2,15,'Vermilion-eared_Noberry','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17444890,2,15,'Vermilion-eared_Noberry','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17444897,2,15,'Vermilion-eared_Noberry','Tonberrys_Elemental');
INSERT INTO `mob_pets` VALUES (17444904,2,14,'Pevv_the_Riverleaper','Sahagins_Wyvern');
INSERT INTO `mob_pets` VALUES (17444910,2,14,'Pevv_the_Riverleaper','Sahagins_Wyvern');
INSERT INTO `mob_pets` VALUES (17444916,2,14,'Pevv_the_Riverleaper','Sahagins_Wyvern');

-- ------------------------------------------------------------
-- Garlaige_Citadel_[S] (Zone 164)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17449003,1,15,'Yagudo_Pythoness','Yagudos_Elemental');
INSERT INTO `mob_pets` VALUES (17449023,1,15,'Yagudo_Pythoness','Yagudos_Elemental');

-- ------------------------------------------------------------
-- Throne_Room (Zone 165)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17453078,2,15,'Duke_Dantalian','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17453085,2,15,'Duke_Dantalian','Demons_Elemental');
INSERT INTO `mob_pets` VALUES (17453092,2,15,'Duke_Dantalian','Demons_Elemental');

-- ------------------------------------------------------------
-- Ranguemont_Pass (Zone 166)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17457257,1,9,'Goblin_Chaser','Goblins_Bats');
INSERT INTO `mob_pets` VALUES (17457265,1,9,'Goblin_Chaser','Goblins_Bats');
INSERT INTO `mob_pets` VALUES (17457290,1,9,'Goblin_Chaser','Goblins_Bats');

-- ------------------------------------------------------------
-- Chamber_of_Oracles (Zone 168)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17465360,1,14,'Maat','Maats_Wyvern');
INSERT INTO `mob_pets` VALUES (17465362,1,14,'Maat','Maats_Wyvern');
INSERT INTO `mob_pets` VALUES (17465364,1,14,'Maat','Maats_Wyvern');

-- ------------------------------------------------------------
-- Korroloka_Tunnel (Zone 173)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17486169,1,9,'Gigas_Foreman','Gigass_Spider');
INSERT INTO `mob_pets` VALUES (17486175,1,9,'Gigas_Foreman','Gigass_Spider');
INSERT INTO `mob_pets` VALUES (17486180,1,9,'Gigas_Foreman','Gigass_Spider');
INSERT INTO `mob_pets` VALUES (17486185,1,9,'Gigas_Foreman','Gigass_Spider');

-- ------------------------------------------------------------
-- Kuftal_Tunnel (Zone 174)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17490151,1,9,'Goblin_Tamer','Goblins_Spider');
INSERT INTO `mob_pets` VALUES (17490156,1,9,'Goblin_Tamer','Goblins_Spider');
INSERT INTO `mob_pets` VALUES (17490164,1,9,'Goblin_Tamer','Goblins_Spider');
INSERT INTO `mob_pets` VALUES (17490171,1,9,'Goblin_Tamer','Goblins_Spider');
INSERT INTO `mob_pets` VALUES (17490180,1,9,'Goblin_Tamer','Goblins_Spider');

-- ------------------------------------------------------------
-- Sea_Serpent_Grotto (Zone 176)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17498356,1,14,'Mouu_the_Waverider','Sahagins_Wyvern');
INSERT INTO `mob_pets` VALUES (17498516,1,14,'Zuug_the_Shoreleaper','Sahagins_Wyvern');
INSERT INTO `mob_pets` VALUES (17498560,1,14,'Ocean_Sahagin','Sahagins_Wyvern');

-- ------------------------------------------------------------
-- The_Shrine_of_RuAvitau (Zone 178)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17506670,5,15,'Kirin','Kirins_Avatar');

-- ------------------------------------------------------------
-- LaLoff_Amphitheater (Zone 180)
-- ------------------------------------------------------------

-- ------------------------------------------------------------
-- Lower_Delkfutts_Tower (Zone 184)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17530884,1,9,'Giant_Sentry','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17530889,1,9,'Giant_Sentry','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17530898,1,9,'Giant_Sentry','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17530903,1,9,'Giant_Sentry','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17530935,1,9,'Giant_Sentry','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17530940,1,9,'Giant_Sentry','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17530952,1,9,'Giant_Sentry','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17530957,1,9,'Giant_Sentry','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17530965,1,9,'Gigas_Butcher','Gigass_Bats');
INSERT INTO `mob_pets` VALUES (17530970,1,9,'Gigas_Butcher','Gigass_Bats');
INSERT INTO `mob_pets` VALUES (17530989,1,9,'Giant_Sentry','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17530994,1,9,'Giant_Sentry','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17531002,1,9,'Giant_Sentry','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17531007,1,9,'Giant_Sentry','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17531022,1,9,'Giant_Sentry','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17531046,1,9,'Giant_Sentry','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17531062,1,9,'Giant_Sentry','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17531067,1,9,'Giant_Sentry','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17531082,1,9,'Giant_Sentry','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17531087,1,9,'Giant_Sentry','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17531101,1,9,'Giant_Sentry','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17531114,1,9,'Eurymedon','Gigass_Bat');
INSERT INTO `mob_pets` VALUES (17531118,1,9,'Giant_Sentry','Gigass_Bat');

-- ------------------------------------------------------------
-- Dynamis-San_dOria (Zone 185)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17534991,1,14,'Vanguard_Impaler','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17534994,1,9,'Vanguard_Hawker','Vanguards_Hecteyes');
INSERT INTO `mob_pets` VALUES (17534996,1,15,'Vanguard_Dollmaster','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17535006,1,15,'Reapertongue_Gadgquok','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17535010,1,15,'Vanguard_Dollmaster','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17535014,1,14,'Vanguard_Impaler','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17535028,1,9,'Vanguard_Hawker','Vanguards_Hecteyes');
INSERT INTO `mob_pets` VALUES (17535032,1,14,'Wyrmgnasher_Bjakdek','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17535042,1,14,'Vanguard_Impaler','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17535049,1,15,'Vanguard_Dollmaster','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17535066,1,9,'Vanguard_Hawker','Vanguards_Hecteyes');
INSERT INTO `mob_pets` VALUES (17535072,1,14,'Vanguard_Impaler','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17535074,1,15,'Vanguard_Dollmaster','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17535076,1,9,'Vanguard_Hawker','Vanguards_Hecteyes');
INSERT INTO `mob_pets` VALUES (17535094,1,9,'Vanguard_Hawker','Vanguards_Hecteyes');
INSERT INTO `mob_pets` VALUES (17535096,1,14,'Vanguard_Impaler','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17535110,1,15,'Vanguard_Dollmaster','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17535149,1,9,'Vanguard_Hawker','Vanguards_Hecteyes');
INSERT INTO `mob_pets` VALUES (17535152,1,14,'Vanguard_Impaler','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17535161,1,9,'Vanguard_Hawker','Vanguards_Hecteyes');
INSERT INTO `mob_pets` VALUES (17535164,1,14,'Vanguard_Impaler','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17535173,1,9,'Vanguard_Hawker','Vanguards_Hecteyes');
INSERT INTO `mob_pets` VALUES (17535179,1,14,'Vanguard_Impaler','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17535181,1,15,'Vanguard_Dollmaster','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17535191,1,15,'Vanguard_Dollmaster','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17535203,1,15,'Vanguard_Dollmaster','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17535208,1,9,'Steelshank_Kratzvatz','Kratzvatzs_Hecteyes');
INSERT INTO `mob_pets` VALUES (17535211,1,14,'Spellspear_Djokvukk','Djokvukks_Wyvern');

-- ------------------------------------------------------------
-- Dynamis-Bastok (Zone 186)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17539076,1,9,'Vanguard_Beasttender','Vanguards_Scorpion');
INSERT INTO `mob_pets` VALUES (17539088,1,14,'Vanguard_Drakekeeper','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17539098,1,15,'Vanguard_Undertaker','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17539105,1,14,'Vanguard_Drakekeeper','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17539110,1,9,'Vanguard_Beasttender','Vanguards_Scorpion');
INSERT INTO `mob_pets` VALUES (17539112,1,14,'Vanguard_Drakekeeper','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17539143,1,15,'GuNhi_Noondozer','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17539164,1,14,'Vanguard_Drakekeeper','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17539166,1,15,'Vanguard_Undertaker','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17539177,1,9,'Vanguard_Beasttender','Vanguards_Scorpion');
INSERT INTO `mob_pets` VALUES (17539197,1,9,'Vanguard_Beasttender','Vanguards_Scorpion');
INSERT INTO `mob_pets` VALUES (17539199,1,14,'Vanguard_Drakekeeper','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17539209,1,15,'Vanguard_Undertaker','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17539211,1,15,'Vanguard_Undertaker','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17539213,1,9,'Vanguard_Beasttender','Vanguards_Scorpion');
INSERT INTO `mob_pets` VALUES (17539222,1,15,'Vanguard_Undertaker','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17539237,1,9,'Vanguard_Beasttender','Vanguards_Scorpion');
INSERT INTO `mob_pets` VALUES (17539239,1,14,'Vanguard_Drakekeeper','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17539247,1,9,'Vanguard_Beasttender','Vanguards_Scorpion');
INSERT INTO `mob_pets` VALUES (17539249,1,14,'Vanguard_Drakekeeper','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17539272,1,15,'Vanguard_Undertaker','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17539284,1,9,'Vanguard_Beasttender','Vanguards_Scorpion');
INSERT INTO `mob_pets` VALUES (17539291,1,14,'Vanguard_Drakekeeper','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17539308,1,15,'RaGho_Darkfount','RaGhos_Avatar');

-- ------------------------------------------------------------
-- Dynamis-Windurst (Zone 187)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17543186,1,9,'Vanguard_Ogresoother','Vanguards_Crow');
INSERT INTO `mob_pets` VALUES (17543192,1,14,'Vanguard_Partisan','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17543196,1,15,'Vanguard_Oracle','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17543203,1,9,'Vanguard_Ogresoother','Vanguards_Crow');
INSERT INTO `mob_pets` VALUES (17543216,1,15,'Vanguard_Oracle','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17543229,1,14,'Vanguard_Partisan','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17543235,1,9,'Vanguard_Ogresoother','Vanguards_Crow');
INSERT INTO `mob_pets` VALUES (17543237,1,14,'Vanguard_Partisan','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17543239,1,9,'Vanguard_Ogresoother','Vanguards_Crow');
INSERT INTO `mob_pets` VALUES (17543241,1,14,'Vanguard_Partisan','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17543256,1,14,'Vanguard_Partisan','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17543266,1,14,'Vanguard_Partisan','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17543272,1,15,'Vanguard_Oracle','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17543274,1,9,'Vanguard_Ogresoother','Vanguards_Crow');
INSERT INTO `mob_pets` VALUES (17543286,1,15,'Vanguard_Oracle','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17543294,1,15,'Haa_Pevi_the_Stentorian','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17543299,1,15,'Vanguard_Oracle','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17543310,1,9,'Vanguard_Ogresoother','Vanguards_Crow');
INSERT INTO `mob_pets` VALUES (17543332,1,9,'Vanguard_Ogresoother','Vanguards_Crow');
INSERT INTO `mob_pets` VALUES (17543337,1,15,'Vanguard_Oracle','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17543339,1,14,'Vanguard_Partisan','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17543351,1,15,'Vanguard_Oracle','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17543360,1,14,'Vanguard_Partisan','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17543367,1,9,'Vanguard_Ogresoother','Vanguards_Crow');
INSERT INTO `mob_pets` VALUES (17543385,1,9,'Vanguard_Ogresoother','Vanguards_Crow');
INSERT INTO `mob_pets` VALUES (17543406,1,9,'Vanguard_Ogresoother','Vanguards_Crow');
INSERT INTO `mob_pets` VALUES (17543415,1,14,'Vanguard_Partisan','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17543424,1,15,'Vanguard_Oracle','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17543431,1,14,'Vanguard_Partisan','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17543442,1,15,'Vanguard_Oracle','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17543444,1,15,'Vanguard_Oracle','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17543459,1,15,'Vanguard_Oracle','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17543464,1,15,'Xuu_Bhoqa_the_Enigma','Xuu_Bhoqas_Avatar');

-- ------------------------------------------------------------
-- Dynamis-Jeuno (Zone 188)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17547268,1,9,'Vanguard_Pathfinder','Vanguards_Slime');
INSERT INTO `mob_pets` VALUES (17547272,1,9,'Vanguard_Pathfinder','Vanguards_Slime');
INSERT INTO `mob_pets` VALUES (17547282,1,14,'Vanguard_Dragontamer','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17547286,1,15,'Vanguard_Necromancer','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17547312,1,14,'Wyrmwix_Snakespecs','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17547317,1,15,'Vanguard_Necromancer','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17547322,1,15,'Morgmox_Moldnoggin','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17547327,1,15,'Vanguard_Necromancer','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17547332,1,14,'Vanguard_Dragontamer','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17547337,1,15,'Morgmox_Moldnoggin','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17547341,1,9,'Vanguard_Pathfinder','Vanguards_Slime');
INSERT INTO `mob_pets` VALUES (17547348,1,14,'Vanguard_Dragontamer','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17547365,1,9,'Vanguard_Pathfinder','Vanguards_Slime');
INSERT INTO `mob_pets` VALUES (17547369,1,9,'Vanguard_Pathfinder','Vanguards_Slime');
INSERT INTO `mob_pets` VALUES (17547373,1,15,'Vanguard_Necromancer','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17547396,1,9,'Trailblix_Goatmug','Vanguards_Slime');
INSERT INTO `mob_pets` VALUES (17547426,1,14,'Vanguard_Dragontamer','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17547428,1,9,'Vanguard_Pathfinder','Vanguards_Slime');
INSERT INTO `mob_pets` VALUES (17547436,1,15,'Vanguard_Necromancer','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17547438,1,15,'Mortilox_Wartpaws','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17547443,1,15,'Vanguard_Necromancer','Vanguards_Avatar');
INSERT INTO `mob_pets` VALUES (17547450,1,9,'Vanguard_Pathfinder','Vanguards_Slime');
INSERT INTO `mob_pets` VALUES (17547452,1,14,'Vanguard_Dragontamer','Vanguards_Wyvern');
INSERT INTO `mob_pets` VALUES (17547454,1,9,'Rutrix_Hamgams','Vanguards_Slime');
INSERT INTO `mob_pets` VALUES (17547483,1,9,'Vanguard_Pathfinder','Vanguards_Slime');
INSERT INTO `mob_pets` VALUES (17547487,1,9,'Blazox_Boneybod','Vanguards_Slime');
INSERT INTO `mob_pets` VALUES (17547494,1,9,'Feralox_Honeylips','Feraloxs_Slime');
INSERT INTO `mob_pets` VALUES (17547496,1,14,'Scourquix_Scaleskin','Scourquixs_Wyvern');

-- ------------------------------------------------------------
-- Ordelles_Caves (Zone 193)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17568091,1,9,'Goblin_Pathfinder','Goblins_Bats');
INSERT INTO `mob_pets` VALUES (17568096,1,9,'Goblin_Pathfinder','Goblins_Bats');
INSERT INTO `mob_pets` VALUES (17568111,1,9,'Goblin_Pathfinder','Goblins_Bats');
INSERT INTO `mob_pets` VALUES (17568116,1,9,'Goblin_Pathfinder','Goblins_Bats');

-- ------------------------------------------------------------
-- Maze_of_Shakhrami (Zone 198)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17588628,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17588633,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17588651,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17588656,1,9,'Goblin_Pathfinder','Goblins_Bat');
INSERT INTO `mob_pets` VALUES (17588666,1,9,'Goblin_Pathfinder','Goblins_Bat');

-- ------------------------------------------------------------
-- Ifrits_Cauldron (Zone 205)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17616975,1,9,'Goblin_Shepherd','Goblins_Bats');
INSERT INTO `mob_pets` VALUES (17617015,1,9,'Goblin_Shepherd','Goblins_Bats');
INSERT INTO `mob_pets` VALUES (17617020,1,9,'Goblin_Shepherd','Goblins_Bats');
INSERT INTO `mob_pets` VALUES (17617025,1,9,'Goblin_Shepherd','Goblins_Bats');
INSERT INTO `mob_pets` VALUES (17617053,1,9,'Goblin_Shepherd','Goblins_Bats');
INSERT INTO `mob_pets` VALUES (17617059,1,9,'Goblin_Shepherd','Goblins_Bats');
INSERT INTO `mob_pets` VALUES (17617064,1,9,'Goblin_Shepherd','Goblins_Bats');

-- ------------------------------------------------------------
-- Gustav_Tunnel (Zone 212)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17645636,1,9,'Goblin_Shepherd','Goblins_Leech');
INSERT INTO `mob_pets` VALUES (17645638,1,9,'Goblin_Shepherd','Goblins_Leech');
INSERT INTO `mob_pets` VALUES (17645646,1,9,'Goblin_Shepherd','Goblins_Leech');
INSERT INTO `mob_pets` VALUES (17645648,1,9,'Goblin_Shepherd','Goblins_Leech');
INSERT INTO `mob_pets` VALUES (17645651,1,9,'Goblin_Shepherd','Goblins_Leech');

-- ------------------------------------------------------------
-- Labyrinth_of_Onzozo (Zone 213)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17649677,1,9,'Goblin_Trader','Goblins_Leech');
INSERT INTO `mob_pets` VALUES (17649832,1,9,'Goblin_Shepherd','Goblins_Leech');
INSERT INTO `mob_pets` VALUES (17649838,1,9,'Goblin_Shepherd','Goblins_Leech');
INSERT INTO `mob_pets` VALUES (17649843,1,9,'Goblin_Shepherd','Goblins_Leech');

-- ------------------------------------------------------------
-- Escha_RuAun (Zone 289)
-- ------------------------------------------------------------

INSERT INTO `mob_pets` VALUES (17961000,1,14,'Eschan_Ilaern','Eschan_Ilaerns_Wynav');
INSERT INTO `mob_pets` VALUES (17961006,1,14,'Eschan_Ilaern','Eschan_Ilaerns_Wynav');
INSERT INTO `mob_pets` VALUES (17961008,1,14,'Eschan_Ilaern','Eschan_Ilaerns_Wynav');
INSERT INTO `mob_pets` VALUES (17961010,1,14,'Eschan_Ilaern','Eschan_Ilaerns_Wynav');
INSERT INTO `mob_pets` VALUES (17961021,1,14,'Eschan_Ilaern','Eschan_Ilaerns_Wynav');
INSERT INTO `mob_pets` VALUES (17961030,1,14,'Eschan_Ilaern','Eschan_Ilaerns_Wynav');
INSERT INTO `mob_pets` VALUES (17961032,1,14,'Eschan_Ilaern','Eschan_Ilaerns_Wynav');
INSERT INTO `mob_pets` VALUES (17961043,1,14,'Eschan_Ilaern','Eschan_Ilaerns_Wynav');
INSERT INTO `mob_pets` VALUES (17961057,1,9,'Eschan_Ilaern','Eschan_Ilaerns_Euvhi');
INSERT INTO `mob_pets` VALUES (17961068,1,9,'Eschan_Ilaern','Eschan_Ilaerns_Euvhi');
INSERT INTO `mob_pets` VALUES (17961078,1,9,'Eschan_Ilaern','Eschan_Ilaerns_Euvhi');
INSERT INTO `mob_pets` VALUES (17961082,1,9,'Eschan_Ilaern','Eschan_Ilaerns_Euvhi');
INSERT INTO `mob_pets` VALUES (17961092,1,9,'Eschan_Ilaern','Eschan_Ilaerns_Euvhi');
INSERT INTO `mob_pets` VALUES (17961102,1,9,'Eschan_Ilaern','Eschan_Ilaerns_Euvhi');
INSERT INTO `mob_pets` VALUES (17961232,1,15,'Eschan_Ilaern','Eschan_Ilaerns_Spirit');
INSERT INTO `mob_pets` VALUES (17961243,1,15,'Eschan_Ilaern','Eschan_Ilaerns_Spirit');
INSERT INTO `mob_pets` VALUES (17961253,1,15,'Eschan_Ilaern','Eschan_Ilaerns_Spirit');
INSERT INTO `mob_pets` VALUES (17961257,1,15,'Eschan_Ilaern','Eschan_Ilaerns_Spirit');
INSERT INTO `mob_pets` VALUES (17961267,1,15,'Eschan_Ilaern','Eschan_Ilaerns_Spirit');
INSERT INTO `mob_pets` VALUES (17961277,1,15,'Eschan_Ilaern','Eschan_Ilaerns_Spirit');

/*!40000 ALTER TABLE `mob_pets` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
