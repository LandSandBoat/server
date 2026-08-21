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
-- Table structure for table `mob_groups`
--

DROP TABLE IF EXISTS `mob_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mob_groups` (
  `groupid` int(10) unsigned NOT NULL,
  `poolid` int(10) unsigned NOT NULL DEFAULT 0,
  `zoneid` smallint(3) unsigned NOT NULL DEFAULT 0,
  `name` varchar(24) DEFAULT NULL,
  `respawntime` int(10) unsigned NOT NULL DEFAULT 0,
  `spawntype` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `dropid` int(10) unsigned NOT NULL DEFAULT 0,
  `HP` mediumint(8) NOT NULL DEFAULT 0,
  `MP` mediumint(8) NOT NULL DEFAULT 0,
  `allegiance` tinyint(2) unsigned NOT NULL DEFAULT 0,
  `content_tag` varchar(14) DEFAULT NULL,
  PRIMARY KEY (`zoneid`,`groupid`)
) ENGINE=Aria TRANSACTIONAL=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci AVG_ROW_LENGTH=22;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mob_groups`
--
-- ORDER BY:  `zoneid`,`groupid`

LOCK TABLES `mob_groups` WRITE;
/*!40000 ALTER TABLE `mob_groups` DISABLE KEYS */;

-- ------------------------------------------------------------
-- Grand_Palace_of_HuXzoi (Zone 34)
-- ------------------------------------------------------------

INSERT INTO `mob_groups` VALUES (27,7057,34,'Quasilumin',0,128,0,1000,0,0,NULL);

-- ------------------------------------------------------------
-- Empyreal_Paradox (Zone 36)
-- ------------------------------------------------------------

INSERT INTO `mob_groups` VALUES (11,3199,36,'Prishe',0,128,0,2200,0,1,NULL); -- ally
INSERT INTO `mob_groups` VALUES (12,5417,36,'Selhteus',0,128,0,0,0,1,NULL); -- ally

-- ------------------------------------------------------------
-- Abdhaljs_Isle-Purgonorgo (Zone 44)
-- ------------------------------------------------------------

INSERT INTO `mob_groups` VALUES (1443,1361,44,'Flammen-Brenner',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (1444,3190,44,'Posten',0,128,0,0,0,0,NULL);

-- ------------------------------------------------------------
-- Ilrusi_Atoll (Zone 55)
-- ------------------------------------------------------------

INSERT INTO `mob_groups` VALUES (1,3117,55,'Percipient_Fish',0,128,0,10500,0,0,NULL);
INSERT INTO `mob_groups` VALUES (2,864,55,'Cursed_Chest',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (3,2340,55,'Lamia_No13',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4,1292,55,'Fallen_Volunteer',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (5,1286,55,'Fallen_Imperial_Wizard',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6,1285,55,'Fallen_Imperial_Trooper',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7,649,55,'Carrion_Crab',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (8,652,55,'Carrion_Leech',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (9,654,55,'Carrion_Slime',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (10,655,55,'Carrion_Toad',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (11,4093,55,'Undead_Crab',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (12,4094,55,'Undead_Leech',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (13,4095,55,'Undead_Slime',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (14,4096,55,'Undead_Toad',0,128,0,0,0,0,NULL);
-- 15 free
INSERT INTO `mob_groups` VALUES (16,2065,55,'Imp',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (17,2208,55,'Kelp_Pugil',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (18,2207,55,'Kelp_Kulshedra',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (19,2206,55,'Kelp_Crab',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (20,2172,55,'K22B6-LAMIA',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (21,2173,55,'K22H3-LAMIA',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (22,2174,55,'K22P2-LAMIA',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (23,886,55,'D5R3-MERROW',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (24,885,55,'D5J2-MERROW',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (25,887,55,'D5S1-MERROW',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (26,1110,55,'Draugar',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (27,5743,55,'Draugar2',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (28,5752,55,'Giant_Pugil_assault',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (29,3220,55,'Puffer_Pugil',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (30,5754,55,'Clipper_assault',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (31,5753,55,'Snipper_assault',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (32,5755,55,'Kraken_assault',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (33,3059,55,'Orobon_fished',0,128,0,8500,0,0,NULL);
INSERT INTO `mob_groups` VALUES (34,3262,55,'Qiqirn_Pecheur',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (35,2222,55,'Khimaira_14X',0,128,0,25000,0,0,NULL);
INSERT INTO `mob_groups` VALUES (36,2582,55,'Martial_Maestro_Megomak',0,128,0,8000,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (37,8167,55,'Clavauert_B_Chanoix',0,128,0,0,0,1,NULL);
INSERT INTO `mob_groups` VALUES (38,973,55,'Demolition_Automaton',0,128,0,0,0,1,NULL);

-- ------------------------------------------------------------
-- Periqia (Zone 56)
-- ------------------------------------------------------------

INSERT INTO `mob_groups` VALUES (1,7038,56,'Excaliace',0,128,0,0,0,1,NULL);
INSERT INTO `mob_groups` VALUES (2,254,56,'Arrapago_Crab',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (3,942,56,'Debaucher',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4,3119,56,'Periqia_Pugil',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (5,3236,56,'Putrid_Immortal_Guard',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6,360,56,'Batteilant_Bhoot',0,128,0,0,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (7,905,56,'Darkling_Draugar',0,128,0,0,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (8,1097,56,'Draconic_Draugar',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (9,1112,56,'Draugars_Wyvern',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (10,865,56,'Cursed_Chigoe',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (11,1274,56,'Experimental_Undead_thf',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (12,5468,56,'Experimental_Undead_brd',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (13,5469,56,'Experimental_Undead_blm',0,128,0,0,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (14,431,56,'Black_Baron',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (15,715,56,'Chigoe_Breeder',0,128,0,9000,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (16,285,56,'Augmented_Chigoe',0,128,0,500,0,0,NULL);
INSERT INTO `mob_groups` VALUES (17,3259,56,'Qiqirn_Miner',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (18,3294,56,'Qutrub_drk',0,128,0,0,0,0,NULL); -- TODO: capture level from retail
INSERT INTO `mob_groups` VALUES (19,2627,56,'Merrow_Shadowdancer',0,128,0,0,0,0,NULL); -- TODO: capture level from retail
INSERT INTO `mob_groups` VALUES (20,2624,56,'Merrow_No16',0,128,0,0,0,0,NULL); -- TODO: capture level from retail
INSERT INTO `mob_groups` VALUES (21,2192,56,'Karazahm',0,128,0,0,0,0,NULL); -- TODO: capture level from retail
INSERT INTO `mob_groups` VALUES (22,2341,56,'Lamia_No14',0,128,0,0,0,0,NULL); -- TODO: capture level from retail
INSERT INTO `mob_groups` VALUES (23,4090,56,'Umarid',0,128,0,0,0,0,NULL); -- TODO: capture level from retail
INSERT INTO `mob_groups` VALUES (24,2343,56,'Lamia_No17',0,128,0,0,0,0,NULL); -- TODO: capture level from retail
INSERT INTO `mob_groups` VALUES (25,2175,56,'K23H1-LAMIA',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (26,4337,56,'Wight_war',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (27,2257,56,'King_Goldemar',0,128,0,25000,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (28,467,56,'Bloody_Daggers',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (29,977,56,'Demonic_Rod',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (30,2425,56,'Living_Staves',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (31,863,56,'Cursed_Axe',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (32,2481,56,'Magic_Shields',0,128,0,0,0,0,NULL);

INSERT INTO `mob_groups` VALUES (1956,2591,56,'Maymun_09',0,128,0,0,0,1,NULL);
INSERT INTO `mob_groups` VALUES (1957,2592,56,'Maymun_21',0,128,0,0,0,1,NULL);
INSERT INTO `mob_groups` VALUES (1958,2593,56,'Maymun_27',0,128,0,0,0,1,NULL);
INSERT INTO `mob_groups` VALUES (1959,2594,56,'Maymun_33',0,128,0,0,0,1,NULL);
INSERT INTO `mob_groups` VALUES (1960,2595,56,'Maymun_53',0,128,0,0,0,1,NULL);
INSERT INTO `mob_groups` VALUES (1961,2596,56,'Maymun_74',0,128,0,0,0,1,NULL);

-- ------------------------------------------------------------
-- The_Ashu_Talif (Zone 60)
-- ------------------------------------------------------------

INSERT INTO `mob_groups` VALUES (1,1776,60,'Gowam',0,128,0,5750,3000,0,NULL);
INSERT INTO `mob_groups` VALUES (2,4468,60,'Yazquhl',0,128,0,6750,0,0,NULL);
INSERT INTO `mob_groups` VALUES (3,1506,60,'Gessho',0,128,0,1500,0,1,NULL); -- Ally
INSERT INTO `mob_groups` VALUES (4,5430,60,'Ashu_Talif_Crew_mnk',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (5,5431,60,'Ashu_Talif_Crew_rdm',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6,263,60,'Ashu_Talif_Crew_rng',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7,262,60,'Ashu_Talif_Captain',0,128,0,11800,0,0,NULL);

INSERT INTO `mob_groups` VALUES (2017,264,60,'Ashu_Talif_Marine',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (2018,432,60,'Black_Bartholomew',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (2019,550,60,'Bubbly',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (2020,873,60,'Cutthroat_Kabsalah',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (2021,1294,60,'Faluuya',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (2024,3826,60,'Swiftwinged_Gekko',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (2025,4305,60,'Watch_Imp',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (2026,4348,60,'Windjammer_Imp',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (2027,7498,60,'Flan_Princess',0,128,0,0,0,0,NULL);

-- ------------------------------------------------------------
-- Lebros_Cavern (Zone 63)
-- ------------------------------------------------------------

INSERT INTO `mob_groups` VALUES (1,4245,63,'Volcanic_Bomb',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (2,3248,63,'Qiqirn_Ceramist',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (3,3268,63,'Qiqirn_Volcanist',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4,534,63,'Brittle_Rock',0,128,0,2400,0,0,NULL);
INSERT INTO `mob_groups` VALUES (5,837,63,'Crimson_Eruca',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6,5470,63,'Broken_Troll_Soldier_pld',0,128,0,0,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (7,5471,63,'Broken_Troll_Soldier_war',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (8,5472,63,'Broken_Troll_Soldier_rdm',0,128,0,0,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (9,535,63,'Broken_Troll_Soldier_mnk',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (10,894,63,'Dahak',0,128,0,0,0,0,NULL); -- TODO: capture level from retail
INSERT INTO `mob_groups` VALUES (11,2967,63,'Old_Troll',0,128,0,4500,0,0,NULL); -- TODO: capture level from retail
INSERT INTO `mob_groups` VALUES (12,4263,63,'Vulcanian_Bomb',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (13,3319,63,'Ranch_Wamouracampa',0,128,0,4000,0,0,NULL);
INSERT INTO `mob_groups` VALUES (14,3318,63,'Ranch_Wamoura',0,128,0,5000,0,0,NULL);
INSERT INTO `mob_groups` VALUES (15,3251,63,'Qiqirn_Eggler',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (16,2157,63,'Jorporbor_the_Hellraker',0,128,0,0,0,0,NULL); -- TODO: capture level from retail
INSERT INTO `mob_groups` VALUES (17,4012,63,'Troll_Combatant',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (18,4281,63,'Wamouracampa',0,128,0,0,0,0,NULL); -- TODO: capture level from retail
-- 19 free
-- 20 free
INSERT INTO `mob_groups` VALUES (21,438,63,'Black_Shuck',0,128,0,25000,0,0,NULL);
INSERT INTO `mob_groups` VALUES (22,2903,63,'Nocuous_Inferno',0,128,0,0,0,0,NULL); -- TODO: capture level from retail
INSERT INTO `mob_groups` VALUES (100,5872,63,'Qiqirn_Mine',0,128,0,0,0,1,NULL); -- Qiqirn Mine
INSERT INTO `mob_groups` VALUES (101,2291,63,'Kudjreel',0,128,0,0,0,1,NULL);
INSERT INTO `mob_groups` VALUES (102,4465,63,'Yanshaal',0,128,0,0,0,1,NULL);
INSERT INTO `mob_groups` VALUES (103,1070,63,'Djahama',0,128,0,0,0,1,NULL);
INSERT INTO `mob_groups` VALUES (104,2177,63,'Kadjaya',0,128,0,0,0,1,NULL);

-- ------------------------------------------------------------
-- Navukgo_Execution_Chamber (Zone 64)
-- ------------------------------------------------------------

INSERT INTO `mob_groups` VALUES (8,2189,64,'Karababa',0,128,0,1000,1000,1,NULL); -- ally

-- ------------------------------------------------------------
-- Mamool_Ja_Training_Grounds (Zone 66)
-- ------------------------------------------------------------

INSERT INTO `mob_groups` VALUES (1,5466,66,'Mamool_Ja_Warder_whm',0,128,0,0,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (2,5465,66,'Mamool_Ja_Warder_bst',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (3,2539,66,'Mamool_Jas_Lizard',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4,2544,66,'Mamool_Ja_Warder_nin',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (5,1037,66,'Dilapidated_Gate',0,128,0,0,0,1,NULL);
INSERT INTO `mob_groups` VALUES (6,3225,66,'Puk_Executioner',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7,2515,66,'Mamool_Ja_Executioner_wh',0,128,0,0,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (8,5467,66,'Mamool_Ja_Executioner_bu',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (9,6501,66,'Mamool_Ja_Executioner_ni',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (10,3437,66,'Sagelord_Molaal_Ja',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (11,2542,66,'Mamool_Ja_Trainee_nin',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (12,6675,66,'Mamool_Ja_Trainee_bst',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (13,6676,66,'Mamool_Ja_Trainee_blu',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (14,2531,66,'Mamool_Ja_Recruit',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (15,4815,66,'Mamool_Ja_Trainer',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (16,3223,66,'Puk',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (17,3142,66,'Pit_Bugard',0,128,0,0,0,0,NULL); -- TODO: capture level from retail
INSERT INTO `mob_groups` VALUES (18,3144,66,'Pit_Lindwurm',0,128,0,0,0,0,NULL); -- TODO: capture level from retail
INSERT INTO `mob_groups` VALUES (19,3146,66,'Pit_Puk',0,128,0,0,0,0,NULL); -- TODO: capture level from retail
INSERT INTO `mob_groups` VALUES (20,3147,66,'Pit_Spider',0,128,0,0,0,0,NULL); -- TODO: capture level from retail
INSERT INTO `mob_groups` VALUES (21,714,66,'Chigoe',0,128,0,500,0,0,NULL);
INSERT INTO `mob_groups` VALUES (22,2726,66,'Molted_Puk',0,128,0,0,0,0,NULL); -- TODO: capture level from retail
INSERT INTO `mob_groups` VALUES (23,2724,66,'Molted_Lindwurm',0,128,0,0,0,0,NULL); -- TODO: capture level from retail
INSERT INTO `mob_groups` VALUES (24,2723,66,'Molted_Bugard',0,128,0,0,0,0,NULL); -- TODO: capture level from retail
INSERT INTO `mob_groups` VALUES (25,2727,66,'Molted_Ziz',0,128,0,0,0,0,NULL); -- TODO: capture level from retail
INSERT INTO `mob_groups` VALUES (26,2725,66,'Molted_Mamool_Ja',0,128,0,0,0,0,NULL); -- TODO: capture level from retail
INSERT INTO `mob_groups` VALUES (27,478,66,'Bluethunder_Kaqool_Ja',0,128,0,0,0,0,NULL); -- TODO: capture level from retail
INSERT INTO `mob_groups` VALUES (28,1327,66,'Festive_Firedrake',0,128,0,0,0,0,NULL); -- TODO: capture level from retail
INSERT INTO `mob_groups` VALUES (29,5742,66,'Marid',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (30,2509,66,'Mamool_Ja_Breeder',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (31,2524,66,'Mamool_Ja_Mahout',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (32,2516,66,'Mamool_Ja_Farrier',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (33,557,66,'Bugard',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (34,3177,66,'Poroggo',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (35,2002,66,'Huge_Spider',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (36,2385,66,'Leech',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (37,3666,66,'Slavering_Lizard',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (38,3255,66,'Qiqirn_Huckster',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (39,3060,66,'Orochi',0,128,0,25000,0,0,NULL);

-- ------------------------------------------------------------
-- Leujaoam_Sanctum (Zone 69)
-- ------------------------------------------------------------

INSERT INTO `mob_groups` VALUES (1,2401,69,'Leujaoam_Worm',0,128,0,0,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (2,3259,69,'Qiqirn_Miner',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (3,2671,69,'Mineral_Eater',0,128,0,0,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (4,739,69,'Clavauert_B_Chanoix',0,128,0,0,0,0,NULL); -- TODO: capture level from retail
INSERT INTO `mob_groups` VALUES (5,1433,69,'Frozen_Bones',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6,1489,69,'Gelid_Bhoot',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7,774,69,'Coney',0,128,0,0,0,0,NULL); -- TODO: capture level from retail
INSERT INTO `mob_groups` VALUES (8,2065,69,'Imp',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (9,1474,69,'Gasharyad',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (10,3445,69,'Salimuhl',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (11,2355,69,'Lamia_Prosector',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (12,2325,69,'Lamia_Bowyer',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (13,2357,69,'Lamia_Sharper',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (14,2301,69,'Kusa',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (15,3443,69,'Saizo',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (16,2960,69,'Oko',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (17,901,69,'Danzo',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (18,2290,69,'Kudagitsune',0,128,0,0,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (19,3581,69,'Shailham',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (20,1024,69,'Dhiadjhar',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (21,4500,69,'Zhadjaraf',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (22,1458,69,'Ganmuul',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (23,2140,69,'Jalyaat',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (24,3306,69,'Rahdjab',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (25,1510,69,'Ghahnis',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (26,3833,69,'Tahbmar',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (27,3361,69,'Rhushouf',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (28,5751,69,'Raubahn_redvsbl',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (29,1512,69,'Ghayaraan',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (30,2288,69,'Krinahal',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (31,4202,69,'Varajahl',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (32,2560,69,'Mareyamad',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (33,3590,69,'Shayaam',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (34,1866,69,'Habraheem',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (35,3279,69,'Qudeen',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (36,3447,69,'Salyhaar',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (37,3586,69,'Sharayaan',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (38,4073,69,'Ubdeen',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (39,353,69,'Bashdeel',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (40,4326,69,'Wharadi',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (41,1963,69,'Hkadouf',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (42,59,69,'Afrhaad',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (43,2810,69,'Nareema',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (44,4075,69,'Udhaaman',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (45,4469,69,'Yhalbin',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (46,813,69,'Count_Dracula',0,128,0,25000,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (47,866,69,'Cursed_Doppelganger',0,128,0,0,0,0,NULL);

-- ------------------------------------------------------------
-- Zhayolm_Remnants (Zone 73)
-- ------------------------------------------------------------

-- Zhayolm Remnants I
INSERT INTO `mob_groups` VALUES (1,3223,73,'Puk',0,128,2037,1380,0,0,NULL);
INSERT INTO `mob_groups` VALUES (2,3223,73,'Puk',0,128,2806,1380,0,0,NULL);
INSERT INTO `mob_groups` VALUES (3,3223,73,'Puk',0,128,0,1380,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4,3223,73,'Puk',0,128,3374,1380,0,0,NULL);
INSERT INTO `mob_groups` VALUES (5,4508,73,'Ziz',0,128,2806,1890,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6,4508,73,'Ziz',0,128,0,2037,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7,4508,73,'Ziz',0,128,0,1890,0,0,NULL);
INSERT INTO `mob_groups` VALUES (8,4508,73,'Ziz',0,128,3375,1890,0,0,NULL);
INSERT INTO `mob_groups` VALUES (9,4117,73,'Vagrant_Lindwurm',0,128,2806,1400,0,0,NULL);
INSERT INTO `mob_groups` VALUES (10,4117,73,'Vagrant_Lindwurm',0,128,2037,1400,0,0,NULL);
INSERT INTO `mob_groups` VALUES (11,4117,73,'Vagrant_Lindwurm',0,128,0,1400,0,0,NULL);
INSERT INTO `mob_groups` VALUES (12,4117,73,'Vagrant_Lindwurm',0,128,2532,1400,0,0,NULL);
INSERT INTO `mob_groups` VALUES (13,577,73,'Bull_Bugard',0,128,2037,2037,0,0,NULL);
INSERT INTO `mob_groups` VALUES (14,577,73,'Bull_Bugard',0,128,2806,1700,0,0,NULL);
INSERT INTO `mob_groups` VALUES (15,577,73,'Bull_Bugard',0,128,0,1700,0,0,NULL);
INSERT INTO `mob_groups` VALUES (16,577,73,'Bull_Bugard',0,128,384,1700,0,0,NULL);
INSERT INTO `mob_groups` VALUES (17,2545,73,'Mamool_Ja_Zenist',0,128,1595,3960,0,0,NULL);
INSERT INTO `mob_groups` VALUES (18,3181,73,'Poroggo_Gent_TD',0,128,2016,3166,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (19,3181,73,'Poroggo_Gent_TD',0,128,3376,3166,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (20,3181,73,'Poroggo_Gent_TD',0,128,3377,3166,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (21,3181,73,'Poroggo_Gent_TD',0,128,3378,3166,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (22,3183,73,'Poroggo_Madame',0,128,3379,13000,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (23,1098,73,'Draco_Lizard',0,128,696,2830,0,0,NULL);
INSERT INTO `mob_groups` VALUES (24,1098,73,'Draco_Lizard',0,128,0,2830,0,0,NULL);
INSERT INTO `mob_groups` VALUES (25,1098,73,'Draco_Lizard',0,128,3380,2830,0,0,NULL);
INSERT INTO `mob_groups` VALUES (26,4389,73,'Wyvern',0,128,3381,4700,0,0,NULL);
INSERT INTO `mob_groups` VALUES (27,4389,73,'Wyvern',0,128,0,4700,0,0,NULL);
INSERT INTO `mob_groups` VALUES (28,4389,73,'Wyvern',0,128,2678,4700,0,0,NULL);
INSERT INTO `mob_groups` VALUES (29,2545,73,'Mamool_Ja_Zenist',0,128,3382,4428,0,0,NULL);
INSERT INTO `mob_groups` VALUES (30,2533,73,'Mamool_Ja_Savant',0,128,3385,4165,0,0,NULL);
INSERT INTO `mob_groups` VALUES (31,2508,73,'Mamool_Ja_Bounder',0,128,1589,4227,0,0,NULL);
INSERT INTO `mob_groups` VALUES (32,2535,73,'Mamool_Ja_Spearman',0,128,3383,4573,0,0,NULL);
INSERT INTO `mob_groups` VALUES (33,2541,73,'Mamool_Jas_Wyvern',0,128,0,842,0,0,NULL);
INSERT INTO `mob_groups` VALUES (34,2138,73,'Jakko',0,128,1403,8254,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (35,3183,73,'Poroggo_Madame',0,128,0,6241,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (36,2545,73,'Mamool_Ja_Zenist',0,128,3384,2200,0,0,NULL);
INSERT INTO `mob_groups` VALUES (37,2545,73,'Mamool_Ja_Zenist',0,128,3386,2200,0,0,NULL);
INSERT INTO `mob_groups` VALUES (38,2545,73,'Mamool_Ja_Zenist',0,128,3387,2200,0,0,NULL);
INSERT INTO `mob_groups` VALUES (39,2545,73,'Mamool_Ja_Zenist',0,128,0,2200,0,0,NULL);
INSERT INTO `mob_groups` VALUES (40,2535,73,'Mamool_Ja_Spearman',0,128,3388,2280,0,0,NULL);
INSERT INTO `mob_groups` VALUES (41,2535,73,'Mamool_Ja_Spearman',0,128,3389,2280,0,0,NULL);
INSERT INTO `mob_groups` VALUES (42,2535,73,'Mamool_Ja_Spearman',0,128,3387,2280,0,0,NULL);
INSERT INTO `mob_groups` VALUES (43,2535,73,'Mamool_Ja_Spearman',0,128,3390,2280,0,0,NULL);
INSERT INTO `mob_groups` VALUES (44,2541,73,'Mamool_Jas_Wyvern',0,128,0,657,0,0,NULL);
INSERT INTO `mob_groups` VALUES (45,2538,73,'Mamool_Ja_Strapper',0,128,3388,2280,0,0,NULL);
INSERT INTO `mob_groups` VALUES (46,2538,73,'Mamool_Ja_Strapper',0,128,3391,2280,0,0,NULL);
INSERT INTO `mob_groups` VALUES (47,2538,73,'Mamool_Ja_Strapper',0,128,3392,2280,0,0,NULL);
INSERT INTO `mob_groups` VALUES (48,2538,73,'Mamool_Ja_Strapper',0,128,3390,2280,0,0,NULL);
INSERT INTO `mob_groups` VALUES (49,2539,73,'Mamool_Jas_Lizard',0,128,0,2370,0,0,NULL);
INSERT INTO `mob_groups` VALUES (50,2535,73,'Mamool_Ja_Spearman',0,128,3391,2280,0,0,NULL);
INSERT INTO `mob_groups` VALUES (51,2508,73,'Mamool_Ja_Bounder',0,128,3387,2300,0,0,NULL);
INSERT INTO `mob_groups` VALUES (52,2538,73,'Mamool_Ja_Strapper',0,128,0,2280,0,0,NULL);
INSERT INTO `mob_groups` VALUES (53,2508,73,'Mamool_Ja_Bounder',0,128,3392,2300,0,0,NULL);
INSERT INTO `mob_groups` VALUES (54,2545,73,'Mamool_Ja_Zenist',0,128,3388,2200,0,0,NULL);
INSERT INTO `mob_groups` VALUES (55,221,73,'Archaic_Rampart',0,128,3393,6670,0,0,NULL);
INSERT INTO `mob_groups` VALUES (56,4275,73,'Wajaom_Tiger',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (57,2533,73,'Mamool_Ja_Savant',0,128,0,2700,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (58,2534,73,'Mamool_Ja_Sophist',0,128,0,2700,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (59,2526,73,'Mamool_Ja_Mimicker',0,128,0,2800,0,0,NULL);
INSERT INTO `mob_groups` VALUES (60,221,73,'Archaic_Rampart',0,128,3393,7320,0,0,NULL);
INSERT INTO `mob_groups` VALUES (61,3183,73,'Poroggo_Madame',0,128,0,13500,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (62,2545,73,'Mamool_Ja_Zenist',0,128,3394,3100,0,0,NULL);
INSERT INTO `mob_groups` VALUES (63,2535,73,'Mamool_Ja_Spearman',0,128,3395,4000,0,0,NULL);
INSERT INTO `mob_groups` VALUES (64,2508,73,'Mamool_Ja_Bounder',0,128,3396,4000,0,0,NULL);
INSERT INTO `mob_groups` VALUES (65,2538,73,'Mamool_Ja_Strapper',0,128,3397,4000,0,0,NULL);
INSERT INTO `mob_groups` VALUES (66,1345,73,'First_Rampart',0,128,833,7000,0,0,NULL);
INSERT INTO `mob_groups` VALUES (67,3526,73,'Second_Rampart',0,128,833,7000,0,0,NULL);
INSERT INTO `mob_groups` VALUES (68,3898,73,'Third_Rampart',0,128,833,7000,0,0,NULL);
INSERT INTO `mob_groups` VALUES (69,1413,73,'Fourth_Rampart',0,128,157,7000,0,0,NULL);
INSERT INTO `mob_groups` VALUES (70,3383,73,'Rogue_Marid',0,128,0,10135,0,0,NULL);
INSERT INTO `mob_groups` VALUES (71,3181,73,'Poroggo_Gent_TD',0,128,0,9200,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (72,2533,73,'Mamool_Ja_Savant',0,128,3398,4132,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (73,2533,73,'Mamool_Ja_Savant',0,128,3399,4132,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (74,2534,73,'Mamool_Ja_Sophist',0,128,3400,4000,0,0,NULL);
INSERT INTO `mob_groups` VALUES (75,2534,73,'Mamool_Ja_Sophist',0,128,3401,4000,0,0,NULL);
INSERT INTO `mob_groups` VALUES (76,2526,73,'Mamool_Ja_Mimicker',0,128,0,4267,0,0,NULL);
INSERT INTO `mob_groups` VALUES (77,2533,73,'Mamool_Ja_Savant',0,128,0,4132,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (78,2534,73,'Mamool_Ja_Sophist',0,128,3398,4000,0,0,NULL);
INSERT INTO `mob_groups` VALUES (79,2534,73,'Mamool_Ja_Sophist',0,128,3399,4000,0,0,NULL);
INSERT INTO `mob_groups` VALUES (80,2526,73,'Mamool_Ja_Mimicker',0,128,3400,4267,0,0,NULL);
INSERT INTO `mob_groups` VALUES (81,2526,73,'Mamool_Ja_Mimicker',0,128,3401,4267,0,0,NULL);
INSERT INTO `mob_groups` VALUES (82,3181,73,'Poroggo_Gent_TD',0,128,0,4650,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (83,3181,73,'Poroggo_Gent_TD',0,128,3402,4650,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (84,3181,73,'Poroggo_Gent_TD',0,128,3406,4650,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (85,3181,73,'Poroggo_Gent_TD',0,128,3407,4650,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (86,3183,73,'Poroggo_Madame',0,128,0,17060,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (87,3183,73,'Poroggo_Madame',0,128,3403,17060,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (88,218,73,'Archaic_Gear',0,128,3393,4170,0,0,NULL);
INSERT INTO `mob_groups` VALUES (89,221,73,'Archaic_Rampart',0,128,3393,8810,0,0,NULL);
INSERT INTO `mob_groups` VALUES (90,3670,73,'Slime_Mold',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (91,216,73,'Archaic_Chariot',0,128,3393,22800,0,0,NULL);
INSERT INTO `mob_groups` VALUES (92,221,73,'Archaic_Rampart',0,128,3393,4870,0,0,NULL);
INSERT INTO `mob_groups` VALUES (93,219,73,'Archaic_Gears',0,128,3393,4175,0,0,NULL);
INSERT INTO `mob_groups` VALUES (94,221,73,'Archaic_Rampart',0,128,3393,9875,0,0,NULL);
INSERT INTO `mob_groups` VALUES (95,2669,73,'Mindgazer',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (96,219,73,'Archaic_Gears',0,128,3393,4500,0,0,NULL);
INSERT INTO `mob_groups` VALUES (97,3976,73,'Torama',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (98,3183,73,'Poroggo_Madame',0,128,0,20242,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (99,3183,73,'Poroggo_Madame',0,128,3404,17060,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (100,216,73,'Archaic_Chariot',0,128,3393,30500,0,0,NULL);
INSERT INTO `mob_groups` VALUES (101,218,73,'Archaic_Gear',0,128,3393,4560,0,0,NULL);
INSERT INTO `mob_groups` VALUES (102,221,73,'Archaic_Rampart',0,128,3393,9700,0,0,NULL);
INSERT INTO `mob_groups` VALUES (103,1806,73,'Greater_Manticore',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (104,3183,73,'Poroggo_Madame',0,128,3405,17060,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (105,364,73,'Battleclad_Chariot',0,128,238,50000,0,0,NULL);
INSERT INTO `mob_groups` VALUES (106,3181,73,'Poroggo_Gent',0,128,3402,9200,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (107,3181,73,'Poroggo_Gent',0,128,3406,9200,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (108,3181,73,'Poroggo_Gent',0,128,3407,9200,9999,0,NULL);

-- Zhayolm Remnants II
-- TODO: capture retail levels for all groups in this zone
INSERT INTO `mob_groups` VALUES (134,831,73,'Crawler',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (135,2545,73,'Mamool_Ja_Zenist',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (136,2538,73,'Mamool_Ja_Strapper',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (137,2539,73,'Mamool_Jas_Lizard',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (138,0,73,'Poroggo_Comtesse',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (139,3934,73,'Toad',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (140,2526,73,'Mamool_Ja_Mimicker',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (141,2508,73,'Mamool_Ja_Bounder',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (142,218,73,'Archaic_Gear',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (143,2534,73,'Mamool_Ja_Sophist',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (144,1040,73,'Diremite',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (145,221,73,'Archaic_Rampart',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (146,219,73,'Archaic_Gears',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (147,3221,73,'Pugil',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (148,2533,73,'Mamool_Ja_Savant',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (149,216,73,'Archaic_Chariot',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (150,0,73,'Mamool_Ja_Backstabber',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (151,364,73,'Battleclad_Chariot',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (152,0,73,'Mamool_Ja_Antiquary',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (153,39,73,'Acrolith',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (154,2018,73,'Hydra',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (155,0,73,'Enraged_Alfard',0,128,0,0,0,0,NULL);

-- ------------------------------------------------------------
-- Arrapago_Remnants (Zone 74)
-- ------------------------------------------------------------

-- Arrapago Remnants I
INSERT INTO `mob_groups` VALUES (1,221,74,'Archaic_Rampart',0,128,161,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (2,3431,74,'Sabotender_Maestro',0,128,2139,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (3,3294,74,'Qutrub_drk',0,128,2068,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4,2334,74,'Lamia_Graverobber',0,128,1488,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (5,2329,74,'Lamia_Dartist',0,128,1489,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6,2328,74,'Lamia_Dancer',0,128,1488,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7,2359,74,'Lamias_Elemental',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (8,2332,74,'Lamia_Fatedealer',0,128,1491,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (9,2627,74,'Merrow_Shadowdancer',0,128,1488,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (10,3355,74,'Reserve_Draugar_blm',0,128,2089,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (11,5193,74,'Reserve_Draugar_drk',0,128,2089,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (12,2621,74,'Merrow_Kabukidancer',0,128,1660,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (13,2620,74,'Merrow_Icedancer',0,128,1491,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (14,5194,74,'Reserve_Draugar_drg',0,128,2089,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (15,1112,74,'Draugars_Wyvern',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (16,2619,74,'Merrow_Chantress',0,128,1659,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (17,5192,74,'Reserve_Draugar_thf',0,128,2089,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (18,1505,74,'Gespenst',0,128,949,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (19,3246,74,'Qiqirn_Astrologer',0,128,2052,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (20,3215,74,'Psycheflayer',0,128,2029,14000,0,0,NULL);
INSERT INTO `mob_groups` VALUES (21,3267,74,'Qiqirn_Treasure_Hunter',0,128,2053,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (22,3258,74,'Qiqirn_Mine',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (23,1015,74,'Deviate_Bhoot',0,128,641,14000,0,0,NULL);
INSERT INTO `mob_groups` VALUES (24,218,74,'Archaic_Gear',0,128,155,0,0,0,NULL);
-- zone 74 group 25: free
INSERT INTO `mob_groups` VALUES (26,2890,74,'Nipper',0,128,1817,0,0,0,NULL);
-- zone 74 group 27: free
INSERT INTO `mob_groups` VALUES (28,2653,74,'Migrant_Russula',0,128,1671,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (29,978,74,'Demonic_Rose',0,128,608,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (30,1018,74,'Devil_Manta',0,128,643,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (31,219,74,'Archaic_Gears',0,128,158,0,0,0,NULL);
-- zone 74 group 32: free
INSERT INTO `mob_groups` VALUES (33,976,74,'Demonic_Pugil',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (34,6722,74,'Orobon',0,128,1595,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (35,216,74,'Archaic_Chariot',0,128,151,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (36,2762,74,'Mourioche',0,128,1745,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (37,1761,74,'Goobbue_Wanderer',0,128,1203,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (38,3517,74,'Seasonal_Treant',0,128,1203,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (39,3751,74,'Staggering_Sapling',0,128,2317,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (40,2282,74,'Korrigan',0,128,1463,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (41,246,74,'Armored_Chariot',0,128,171,50000,0,0,NULL);
INSERT INTO `mob_groups` VALUES (42,4233,74,'Vile_Wahzil',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (43,3197,74,'Princess_Pudding',0,128,2020,0,0,0,NULL);

-- Arrapago Remnants II
INSERT INTO `mob_groups` VALUES (44,0,74,'Vulture',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (45,0,74,'Merrow_Kabukidancer',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (46,0,74,'Chigoe_Stinger',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (47,0,74,'Leech',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (48,0,74,'Merrow_Shadowdancer',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (49,0,74,'Lamia_Dartist',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (50,0,74,'Lamia_Dancer',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (51,0,74,'Lamias_Elemental',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (52,0,74,'Merrow_Chantress',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (53,0,74,'Merrow_Icedancer',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (54,0,74,'Archaic_Gear',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (55,0,74,'Flytrap',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (56,0,74,'Qutrub',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (57,0,74,'Lamia_Graverobber',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (58,0,74,'Lamia_Fatedealer',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (59,0,74,'Acrolith',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (60,0,74,'Qutrub_Devourer',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (61,0,74,'Lamia_Spoliator',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (62,0,74,'Archaic_Rampart',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (63,0,74,'Archaic_Gears',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (64,0,74,'Armored_Chariot',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (65,0,74,'Archaic_Chariot',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (66,0,74,'Khimaira',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (67,0,74,'Khrysokhimaira_Elder',0,128,0,0,0,0,NULL);

-- ------------------------------------------------------------
-- Bhaflau_Remnants (Zone 75)
-- ------------------------------------------------------------

-- Bhaflau Remnants I
INSERT INTO `mob_groups` VALUES (10,3338,75,'Reactionary_Rampart',0,128,2081,5955,0,0,NULL);
-- 1st Floor
INSERT INTO `mob_groups` VALUES (100,642,75,'Carmine_Eruca',0,128,420,3600,0,0,NULL);
INSERT INTO `mob_groups` VALUES (101,412,75,'Bifrons',0,128,420,3000,0,0,NULL);
INSERT INTO `mob_groups` VALUES (102,4017,75,'Troll_Gemologist',0,128,420,4500,0,0,NULL);
INSERT INTO `mob_groups` VALUES (103,4281,75,'Wamouracampa',0,128,420,6150,0,0,NULL);
INSERT INTO `mob_groups` VALUES (104,4022,75,'Troll_Lapidarist',0,128,420,4800,0,0,NULL);
INSERT INTO `mob_groups` VALUES (105,4021,75,'Troll_Ironworker',0,128,420,4800,0,0,NULL);
INSERT INTO `mob_groups` VALUES (106,4286,75,'Wandering_Wamoura',0,128,765,4100,0,0,NULL);
INSERT INTO `mob_groups` VALUES (107,3808,75,'Sulfur_Scorpion',0,128,765,4400,0,0,NULL);
INSERT INTO `mob_groups` VALUES (108,2471,75,'Mad_Bomber',0,128,0,19000,0,0,NULL);
INSERT INTO `mob_groups` VALUES (109,714,75,'Chigoe',0,128,0,3200,0,0,NULL);
INSERT INTO `mob_groups` VALUES (110,1477,75,'Gate_Widow',0,128,939,4500,0,0,NULL);
-- 2nd Floor
INSERT INTO `mob_groups` VALUES (200,1209,75,'Empathic_Flan',0,128,765,9150,0,0,NULL);
INSERT INTO `mob_groups` VALUES (201,3808,75,'Sulfur_Scorpion',0,128,2360,5000,0,0,NULL);
INSERT INTO `mob_groups` VALUES (202,4030,75,'Troll_Smelter',0,128,152,5500,0,0,NULL);
INSERT INTO `mob_groups` VALUES (203,4021,75,'Troll_Ironworker',0,128,420,6250,0,0,NULL);
INSERT INTO `mob_groups` VALUES (204,4021,75,'Troll_Stoneworker',0,128,152,6600,0,0,NULL);
INSERT INTO `mob_groups` VALUES (205,4032,75,'Troll_Stoneworker',0,128,420,6600,0,0,NULL);
INSERT INTO `mob_groups` VALUES (206,4010,75,'Troll_Cameist',0,128,152,5500,0,0,NULL);
INSERT INTO `mob_groups` VALUES (207,4286,75,'Wandering_Wamoura',0,128,152,9800,0,0,NULL);
INSERT INTO `mob_groups` VALUES (208,4015,75,'Troll_Engraver',0,128,152,5900,0,0,NULL);
INSERT INTO `mob_groups` VALUES (209,4035,75,'Trolls_Automaton',0,128,0,4065,0,0,NULL);
INSERT INTO `mob_groups` VALUES (210,1372,75,'Flux_Flan',0,128,0,8900,0,0,NULL);
INSERT INTO `mob_groups` VALUES (211,2014,75,'Hunting_Wasp',0,128,0,3200,0,0,NULL);
INSERT INTO `mob_groups` VALUES (212,3651,75,'Skirmish_Pephredo',0,128,2267,5270,0,0,NULL);
-- 3rd Floor
INSERT INTO `mob_groups` VALUES (300,4010,75,'Troll_Cameist',0,128,152,7400,0,0,NULL);
INSERT INTO `mob_groups` VALUES (301,4017,75,'Troll_Gemologist',0,128,152,7700,0,0,NULL);
INSERT INTO `mob_groups` VALUES (302,4030,75,'Troll_Smelter',0,128,152,7300,0,0,NULL);
INSERT INTO `mob_groups` VALUES (303,4022,75,'Troll_Lapidarist',0,128,152,7900,0,0,NULL);
INSERT INTO `mob_groups` VALUES (304,4032,75,'Troll_Stoneworker',0,128,152,8650,0,0,NULL);
INSERT INTO `mob_groups` VALUES (305,4021,75,'Troll_Ironworker',0,128,152,7800,0,0,NULL);
INSERT INTO `mob_groups` VALUES (306,4015,75,'Troll_Engraver',0,128,152,76000,0,0,NULL);
INSERT INTO `mob_groups` VALUES (307,4035,75,'Trolls_Automaton',0,128,0,4840,0,0,NULL);
INSERT INTO `mob_groups` VALUES (308,437,75,'Black_Pudding',0,128,152,5400,0,0,NULL);
INSERT INTO `mob_groups` VALUES (309,219,75,'Archaic_Gears',0,128,159,6700,0,0,NULL);
INSERT INTO `mob_groups` VALUES (310,218,75,'Archaic_Gear',0,128,159,7500,0,0,NULL);
INSERT INTO `mob_groups` VALUES (311,765,75,'Colibri',0,128,0,4000,0,0,NULL);
INSERT INTO `mob_groups` VALUES (312,4497,75,'Zebra_Zachary',0,128,156,7450,0,0,NULL);
INSERT INTO `mob_groups` VALUES (313,967,75,'Demented_Jalaawa',0,128,604,8900,0,0,NULL);
-- 4th Floor
INSERT INTO `mob_groups` VALUES (400,218,75,'Archaic_Gear',0,128,269,6700,0,0,NULL);
INSERT INTO `mob_groups` VALUES (401,216,75,'Archaic_Chariot',0,128,2481,15250,0,0,NULL);
INSERT INTO `mob_groups` VALUES (402,219,75,'Archaic_Gears',0,128,159,7500,0,0,NULL);
INSERT INTO `mob_groups` VALUES (403,3984,75,'Tragopan',0,128,0,3940,0,0,NULL);
INSERT INTO `mob_groups` VALUES (404,3120,75,'Peryton',0,128,1989,0,0,0,NULL);
-- 5th Floor
INSERT INTO `mob_groups` VALUES (500,2433,75,'Long-Bowed_Chariot',0,128,1533,45600,0,0,NULL);

-- Bhaflau Remnants II
INSERT INTO `mob_groups` VALUES (33,0,75,'Fly',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (34,437,75,'Black_Pudding',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (35,0,75,'Moblin_Armsman',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (36,0,75,'Throat_Tearer_Tregotroq',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (37,4281,75,'Wamouracampa',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (38,4286,75,'Wandering_Wamoura',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (39,0,75,'Moblin_Poniardman',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (40,0,75,'Silent_Smotherer_Silak',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (41,894,75,'Dahak',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (42,0,75,'Smouldering_Dahak',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (43,4032,75,'Troll_Stoneworker',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (44,4010,75,'Troll_Cameist',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (45,4017,75,'Troll_Gemologist',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (46,4030,75,'Troll_Smelter',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (47,4022,75,'Troll_Lapidarist',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (48,4015,75,'Troll_Engraver',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (49,4035,75,'Trolls_Automaton',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (50,0,75,'Troll_Occultist',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (51,0,75,'Troll_Pugilist',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (52,0,75,'Troll_Spellbinder',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (53,0,75,'Troll_Guardian',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (54,0,75,'Troll_Huntsman',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (55,218,75,'Archaic_Gear',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (56,221,75,'Archaic_Rampart',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (57,219,75,'Archaic_Gears',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (58,2433,75,'Long-Bowed_Chariot',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (59,39,75,'Acrolith',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (60,680,75,'Cerberus',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (61,0,75,'Orthrus_Seether',0,128,0,0,0,0,NULL);

-- ------------------------------------------------------------
-- Silver_Sea_Remnants (Zone 76)
-- ------------------------------------------------------------

-- Silver Sea Remnants I
INSERT INTO `mob_groups` VALUES (1,5430,76,'Ashu_Talif_Crew_mnk',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (2,263,76,'Ashu_Talif_Crew_rng',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (3,5431,76,'Ashu_Talif_Crew_rdm',0,128,0,0,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (4,5728,76,'Ashu_Talif_Crew_cor',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (5,1887,76,'Hammerblow_Majanun',0,128,1272,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6,5430,76,'Ashu_Talif_Crew_mnk',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7,263,76,'Ashu_Talif_Crew_rng',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (8,5431,76,'Ashu_Talif_Crew_rdm',0,128,0,0,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (9,5728,76,'Ashu_Talif_Crew_cor',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (10,1933,76,'Heraldic_Imp',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (11,933,76,'Deadpan_Devilet',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (12,963,76,'Dekka',0,128,602,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (13,1448,76,'Gakke',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (14,1017,76,'Devilet',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (15,3191,76,'Powderkeg_Yanadahn',0,128,2019,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (17,221,76,'Archaic_Rampart',0,128,154,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (18,6507,76,'Haunt',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (19,1471,76,'Garm',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (20,6555,76,'Guard_Skeleton_blm',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (21,6533,76,'Doom_Mage',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (22,218,76,'Archaic_Gear',0,128,154,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (23,219,76,'Archaic_Gears',0,128,154,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (24,1862,76,'Gyroscopic_Gear',0,128,1262,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (25,1079,76,'Don_Poroggo',0,128,673,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (26,6556,76,'Guard_Skeleton_war',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (27,1863,76,'Gyroscopic_Gears',0,128,1263,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (28,216,76,'Archaic_Chariot',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (29,2878,76,'Night_Eft',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (30,3456,76,'Sand_Lizard',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (31,962,76,'Deinonychus',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (32,732,76,'Citadel_Chelonian',0,128,474,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (33,2431,76,'Long-Armed_Chariot',0,128,1531,0,0,0,NULL);

-- Silver Sea Remnants II
-- TODO: capture levels from retail
-- TODO: capture jobs of Ashu Talif Crew from retail, create pools for missing jobs, and assign
INSERT INTO `mob_groups` VALUES (34,221,76,'Archaic_Rampart',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (35,0,76,'Doomed',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (36,0,76,'Qiqirn',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (37,2065,76,'Imp',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (38,0,76,'Voracious_Carrion',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (39,197,76,'Apkallu',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (40,0,76,'Apkallu_Avenger',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (41,0,76,'Seafarer_Piliproon',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (42,5430,76,'Ashu_Talif_Crew_mnk',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (43,263,76,'Ashu_Talif_Crew_rng',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (44,5431,76,'Ashu_Talif_Crew_rdm',0,128,0,0,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (45,5728,76,'Ashu_Talif_Crew_cor',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (46,0,76,'Fomor_Windwalker',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (47,0,76,'Stoneplate_Ghalimad',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (48,0,76,'Quickdirk_Kahladijn',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (49,3215,76,'Psycheflayer',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (50,0,76,'Lunatic_Psycheflayer',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (51,6722,76,'Orobon',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (52,0,76,'Argent-eyed_Orobon',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (53,218,76,'Archaic_Gear',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (54,219,76,'Archaic_Gears',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (55,2431,76,'Long-Armed_Chariot',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (56,216,76,'Archaic_Chariot',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (57,39,76,'Acrolith',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (58,0,76,'Dvergr',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (59,0,76,'Bloodthirsty_Dweorg',0,128,0,0,0,0,NULL);

-- ------------------------------------------------------------
-- Nyzul_Isle (Zone 77)
-- ------------------------------------------------------------

INSERT INTO `mob_groups` VALUES (1,221,77,'Archaic_Rampart',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (2,1799,77,'Greatclaw',0,128,1222,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (3,3803,77,'Stygian_Pugil',0,128,37,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4,2296,77,'Kulshedra',0,128,290,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (5,6396,77,'Bouncing_Ball',0,128,79,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6,6392,77,'Thousand_Eyes',0,128,315,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7,6410,77,'Mousse',0,128,15,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (8,437,77,'Black_Pudding',0,128,390,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (9,6592,77,'Killing_Weapon',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (10,6594,77,'Ominous_Weapon',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (11,6599,77,'Magic_Flagon',0,128,607,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (12,1426,77,'Friars_Lantern',0,128,909,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (13,3825,77,'Sweeping_Cluster',0,128,2368,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (14,1471,77,'Garm',0,128,226,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (15,6485,77,'Tainted_Flesh',0,128,1528,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (16,1110,77,'Draugar',0,128,769,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (17,6514,77,'Bhoot',0,128,263,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (18,6320,77,'Carmine_Eruca',0,128,419,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (19,6337,77,'Spinner',0,128,228,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (20,4281,77,'Wamouracampa',0,128,2609,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (21,4280,77,'Wamoura',0,128,2606,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (22,2065,77,'Imp',0,128,1002,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (23,3215,77,'Psycheflayer',0,128,2030,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (24,3223,77,'Puk',0,128,2036,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (25,4389,77,'Wyvern',0,128,36,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (26,2580,77,'Marsh_Murre',0,128,1634,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (27,2396,77,'Lesser_Colibri',0,128,1510,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (28,4508,77,'Ziz',0,128,2805,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (29,3120,77,'Peryton',0,128,1990,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (30,4342,77,'Wild_Karakul',0,128,2656,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (31,4275,77,'Wajaom_Tiger',0,128,437,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (32,2554,77,'Manticore',0,128,1475,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (33,2562,77,'Marid',0,128,1618,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (34,937,77,'Death_Cap',0,128,581,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (35,6341,77,'Puktrap',0,128,852,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (36,2394,77,'Leshy',0,128,503,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (37,6349,77,'Ameretat',0,128,64,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (38,3456,77,'Sand_Lizard',0,128,103,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (39,962,77,'Deinonychus',0,128,600,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (40,577,77,'Bull_Bugard',0,128,242,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (41,4355,77,'Wivre',0,128,2664,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (42,894,77,'Dahak',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (43,374,77,'Bat_Eye',0,128,148,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (44,3576,77,'Shadow_Eye',0,128,148,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (45,495,77,'Bomb_King',0,128,332,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (46,2165,77,'Juggler_Hecatomb',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (47,3680,77,'Smothered_Schmidt',0,128,181,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (48,1920,77,'Hellion',0,128,1528,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (49,2384,77,'Leaping_Lizzy',0,128,103,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (50,3947,77,'Tom_Tit_Tat',0,128,2426,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (51,2125,77,'Jaggedy-Eared_Jack',0,128,104,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (52,597,77,'Cactuar_Cantautor',0,128,397,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (53,1461,77,'Gargantua',0,128,105,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (54,1861,77,'Gyre-Carlin',0,128,1261,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (55,267,77,'Asphyxiated_Amsel',0,128,181,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (56,1429,77,'Frostmane',0,128,911,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (57,5359,77,'Peallaidh',0,128,906,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (58,645,77,'Carnero',0,128,71,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (59,1282,77,'Falcatus_Aranei',0,128,807,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (60,1208,77,'Emergent_Elm',0,128,98,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (61,2968,77,'Old_Two-Wings',0,128,82,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (62,2083,77,'Intulo',0,128,106,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (63,3047,77,'Orctrap',0,128,243,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (64,4124,77,'Valkurm_Emperor',0,128,571,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (65,845,77,'Crushed_Krause',0,128,181,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (66,3774,77,'Stinging_Sophie',0,128,574,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (67,3550,77,'Serpopard_Ishtar',0,128,107,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (68,4323,77,'Western_Shadow',0,128,737,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (69,462,77,'Bloodtear_Baldurf',0,128,303,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (70,4509,77,'Zizzy_Zillah',0,128,2805,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (71,1201,77,'Ellyllon',0,128,758,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (72,2677,77,'Mischievous_Micholas',0,128,108,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (73,2386,77,'Leech_King',0,128,101,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (74,1164,77,'Eastern_Shadow',0,128,737,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (75,2921,77,'Nunyenunc',0,128,1634,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (76,1919,77,'Helldiver',0,128,1634,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (77,3839,77,'Taisaijin',0,128,315,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (78,1438,77,'Fungus_Beetle',0,128,670,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (79,1425,77,'Friar_Rush',0,128,332,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (80,3226,77,'Pulverized_Pfeffer',0,128,181,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (81,228,77,'Argus',0,128,164,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (82,460,77,'Bloodpool_Vorax',0,128,101,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (83,2873,77,'Nightmare_Vase',0,128,607,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (84,890,77,'Daggerclaw_Dracos',0,128,557,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (85,2907,77,'Northern_Shadow',0,128,737,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (86,1421,77,'Fraelissa',0,128,98,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (87,3376,77,'Roc',0,128,1990,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (88,3428,77,'Sabotender_Bailarin',0,128,397,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (89,206,77,'Aquarius',0,128,100,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (90,1215,77,'Energetic_Eruca',0,128,771,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (91,3734,77,'Spiny_Spipi',0,128,256,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (92,4004,77,'Trickster_Kinetix',0,128,0,1600,0,0,NULL);
INSERT INTO `mob_groups` VALUES (93,1124,77,'Drooling_Daisy',0,128,410,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (94,500,77,'Bonnacon',0,128,337,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (95,1751,77,'Golden_Bat',0,128,82,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (96,3766,77,'Steelfleece_Baldarich',0,128,303,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (97,3432,77,'Sabotender_Mariachi',0,128,397,9000,0,0,NULL);
INSERT INTO `mob_groups` VALUES (98,4100,77,'Ungur',0,128,36,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (99,3818,77,'Swamfisk',0,128,102,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (100,552,77,'Buburimboo',0,128,102,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (101,2203,77,'Keeper_of_Halidom',0,128,109,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (102,3549,77,'Serket',0,128,99,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (103,1138,77,'Dune_Widow',0,128,807,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (104,2945,77,'Odqan',0,128,2368,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (105,585,77,'Burned_Bergmann',0,128,181,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (106,4066,77,'Tyrannic_Tunnok',0,128,99,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (107,461,77,'Bloodsucker',0,128,101,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (108,3979,77,'Tottering_Toby',0,128,1577,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (109,3709,77,'Southern_Shadow',0,128,737,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (110,3587,77,'Sharp-Eared_Ropipi',0,128,104,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (111,3095,77,'Panzer_Percival',0,128,670,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (112,4258,77,'Vouivre',0,128,36,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (113,2155,77,'Jolly_Green',0,128,109,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (114,4049,77,'Tumbling_Truffle',0,128,906,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (115,630,77,'Capricious_Cassie',0,128,410,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (116,109,77,'Amikiri',0,128,99,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (117,3785,77,'Stray_Mary',0,128,71,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (118,3557,77,'Sewer_Syrup',0,128,1845,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (119,4103,77,'Unut',0,128,104,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (120,3630,77,'Simurgh',0,128,1990,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (121,3115,77,'Pelican',0,128,201,15400,0,0,NULL);
INSERT INTO `mob_groups` VALUES (122,639,77,'Cargo_Crab_Colin',0,128,100,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (123,4378,77,'Wounded_Wurfel',0,128,181,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (124,3113,77,'Peg_Powler',0,128,110,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (125,2123,77,'Jaded_Jody',0,128,64,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (126,2490,77,'Maighdean_Uaine',0,128,1577,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (127,218,77,'Archaic_Gear',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (128,219,77,'Archaic_Gears',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (129,2714,77,'Mokke',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (130,2713,77,'Mokka',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (131,2715,77,'Mokku',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (132,4232,77,'Vile_Wahdaha',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (133,4231,77,'Vile_Ineef',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (134,4234,77,'Vile_Yabeewa',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (135,4108,77,'Uriri_Samariri',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (136,1254,77,'Eriri_Samariri',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (137,3053,77,'Oriri_Samariri',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (138,1604,77,'Ginger_Custard',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (139,159,77,'Anise_Custard',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (140,860,77,'Cumin_Custard',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (141,2925,77,'Nutmeg_Custard',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (142,2676,77,'Mint_Custard',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (143,728,77,'Cinnamon_Custard',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (144,635,77,'Caraway_Custard',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (145,4200,77,'Vanilla_Custard',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (146,1490,77,'Gem_Heister_Roorooroon',0,128,945,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (147,3258,77,'Qiqirn_Mine',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (148,3762,77,'Stealth_Bomber_Gagaroon',0,128,945,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (149,3288,77,'Quick_Draw_Sasaroon',0,128,945,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (150,3595,77,'Shielded_Chariot',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (151,365,77,'Battledressed_Chariot',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (152,2434,77,'Long-Gunned_Chariot',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (153,2435,77,'Long-Horned_Chariot',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (154,1933,77,'Heraldic_Imp',0,128,1002,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (155,3181,77,'Poroggo_Gent',0,128,2014,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (156,1170,77,'Ebony_Pudding',0,128,390,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (157,3267,77,'Qiqirn_Treasure_Hunter',0,128,2051,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (158,3245,77,'Qiqirn_Archaeologist',0,128,2051,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (159,3302,77,'Racing_Chariot',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (160,0,77,'Adamantoise',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (161,387,77,'Behemoth',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (162,1280,77,'Fafnir',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (163,2220,77,'Khimaira',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (164,2018,77,'Hydra',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (165,680,77,'Cerberus',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (166,5421,77,'Amanita',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (167,5419,77,'Tococo',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (168,4529,77,'Duke_Decapod',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (169,5734,77,'Rambukk',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (170,5737,77,'Numbing_Norman',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (171,4466,77,'Yara_Ma_Yha_Who',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (172,4569,77,'Barbastelle',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (173,1090,77,'Doppelganger_Gog',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (174,4567,77,'Nocuous_Weapon',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (175,5544,77,'Ghillie_Dhu',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (176,5422,77,'Slumbering_Samwell',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (177,4570,77,'Habrok',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (178,4830,77,'Teporingo',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (179,1011,77,'Desmodont',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (180,2498,77,'Maltha',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (181,5741,77,'Wake_Warder_Wanda',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (182,724,77,'Chocoboleech',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (183,1089,77,'Doppelganger_Dio',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (184,0,77,'Gwyllgi',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (185,1934,77,'Hercules_Beetle',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (186,0,77,'Yal-un_Eke',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (187,3648,77,'Skewer_Sam',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (188,1174,77,'Edacious_Opo-opo',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (189,5735,77,'Hippomaritimus',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (190,2264,77,'Kirata',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (191,4574,77,'Mucoid_Mass',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (192,5537,77,'Sekhmet',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (193,4575,77,'Patripatan',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (194,1093,77,'Dosetsu_Tree',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (195,2784,77,'Mycophile',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (196,5736,77,'Koropokkur',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (197,3551,77,'Serra',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (198,2898,77,'Noble_Mold',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (199,2608,77,'Megalobugard',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (200,4287,77,'Waraxe_Beak',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (201,4571,77,'Herbage_Hunter',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (202,0,77,'Hazmat',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (203,939,77,'Death_from_Above',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (204,5841,77,'Hovering_Hotpot',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (205,3655,77,'Skull_of_Gluttony',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (206,3659,77,'Skull_of_Sloth',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (207,3658,77,'Skull_of_Pride',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (208,1033,77,'Diamond_Daig',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (209,2923,77,'Nussknacker',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (210,876,77,'Cwn_Cyrff',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (211,0,77,'Okyupete',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (212,513,77,'Boroka',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (213,1865,77,'Habetrot',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (214,3656,77,'Skull_of_Greed',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (215,3657,77,'Skull_of_Lust',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (216,3654,77,'Skull_of_Envy',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (217,3660,77,'Skull_of_Wrath',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (218,979,77,'Demonic_Tiphia',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (219,4361,77,'Woodland_Sage',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (220,0,77,'Picolaton',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (221,105,77,'Amemet',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (222,0,77,'Rogue_Receptacle',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (223,207,77,'Arachne',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (224,2982,77,'Oni_Carcass',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (225,0,77,'Splacknuck',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (226,3597,77,'Shii',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (227,4478,77,'Yowie',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (228,1118,77,'Drexerion_the_Condemned',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (229,5188,77,'Lizardtrap',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (230,3125,77,'Phanduron_the_Condemned',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (231,0,77,'Gloom_Eye',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (232,0,77,'Barbaric_Weapon',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (233,0,77,'Calchas',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (234,3063,77,'Ose',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (235,2450,77,'Lumber_Jack',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (236,1196,77,'Elel',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (237,2420,77,'Lindwurm',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (238,2809,77,'Narasimha',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (239,2439,77,'Lord_of_Onzozo',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (240,5140,77,'Nis_Puk',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (241,123,77,'Ancient_Goobbue',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (242,4253,77,'Voluptuous_Vivian',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (243,2287,77,'Kreutzet',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (244,2948,77,'Ogama',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (245,3844,77,'Tarasque',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (246,265,77,'Ash_Dragon',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (247,698,77,'Charybdis',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (248,0,77,'Copper_Borer',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (249,584,77,'Bune',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (250,5139,77,'Mahishasura',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (251,0,77,'Gharial',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (252,0,77,'Aynu-kaysey',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (253,0,77,'Killer_Jonny',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (254,0,77,'Ignamoth',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (255,2254,77,'King_Arthro',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (256,1491,77,'Genbu',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (257,3540,77,'Seiryu',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (258,3816,77,'Suzaku',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (259,592,77,'Byakko',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (260,44,77,'Adamantoise',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (261,0,77,'Scutum_Chariot',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (262,0,77,'Bellum_Chariot',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (263,0,77,'Pistolium_Chariot',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (264,0,77,'Cornum_Chariot',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (265,0,77,'Nukku',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (266,0,77,'Nokko',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (267,0,77,'Nekke',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (268,0,77,'Groaty_Custard',0,128,390,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (269,0,77,'Caramel_Custard',0,128,390,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (270,0,77,'Cardamom_Custard',0,128,390,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (271,0,77,'Abject_Awiija',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (272,0,77,'Abject_Farzahd',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (273,0,77,'Abject_Kharoub',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (274,0,77,'Uroro_Samaroro',0,128,2014,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (275,0,77,'Iroro_Samaroro',0,128,2014,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (276,0,77,'Aroro_Samaroro',0,128,2014,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (277,0,77,'Nerve_Render_Yiyiroon',0,128,3302,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (278,0,77,'Eye_Piercer_Fafaroon',0,128,3302,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (279,0,77,'Mad_Miner_Boboroon',0,128,3302,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (280,0,77,'Stealthlord_Haraal_Ja',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (281,0,77,'Dabargar_the_Stoic',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (282,0,77,'Stheno',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (283,0,77,'Lord_Vryko',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (284,0,77,'Dvali_Jonah',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (285,110,77,'Amnaf_blu',0,128,0,0,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (286,5310,77,'Amnaf_Psycheflayer',0,128,0,0,999,0,NULL);
INSERT INTO `mob_groups` VALUES (287,2066,77,'Imperial_Gear',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (288,2067,77,'Imperial_Gears',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (289,2800,77,'Naja_Salaheem',0,128,0,1000,0,1,NULL);
INSERT INTO `mob_groups` VALUES (290,3332,77,'Razfahd',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (291,82,77,'Alexander_NP',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (292,3327,77,'Raubahn',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (293,4489,77,'Zahak',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (294,334,77,'Balrahn',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (295,7087,77,'Alexander_WTC',0,128,0,30000,0,0,NULL);
INSERT INTO `mob_groups` VALUES (296,7088,77,'Alexander_Image',0,128,0,2050,0,0,NULL);
INSERT INTO `mob_groups` VALUES (297,0,77,'Moon_Rabbit',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (298,0,77,'Unlucky_Beak',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (299,0,77,'Fortune_Ram',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (300,0,77,'Papa_Monkey',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (301,0,77,'Bird_of_Wonder',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (302,0,77,'Fortuitous_Fenrir',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (303,0,77,'Wood_Bugard',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (304,0,77,'Lucky_Mouse',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (305,0,77,'Felicific_Buffalo',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (306,0,77,'Auspicious_Tiger',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (307,0,77,'Celebratory_Coney',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (308,0,77,'Wassailer_Whitby',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (309,0,77,'Lion',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (310,0,77,'Gigantoad',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (311,0,77,'Twinkling_Treant',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (312,0,77,'Prishe',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (313,0,77,'Toro',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (314,0,77,'Miura',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (315,0,77,'Nashmeira',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (316,0,77,'Ovjang',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (317,0,77,'Mnejing',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (318,0,77,'Warder_Footsoldier',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (319,0,77,'Warder_Neckchopper',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (320,0,77,'Warder_Depredator',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (321,0,77,'Warder_Vindicator',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (322,0,77,'Warder_Liberator',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (323,0,77,'Warder_Partisan',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (324,0,77,'Lilisette',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (325,0,77,'Pyracmon',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (326,4381,77,'Wraith_Bat',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (327,0,77,'Mumor',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (328,0,77,'Odin',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (329,0,77,'Brunhilde',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (330,0,77,'Siegrune',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (331,0,77,'Rossweisse',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (332,0,77,'Gerhilde',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (333,0,77,'Schwertleite',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (334,0,77,'Helmwige',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (335,0,77,'Ortlinde',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (336,0,77,'Grimgerde',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (337,0,77,'Waltraute',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (338,68,77,'Aiatar',0,128,36,0,0,0,NULL);

-- ------------------------------------------------------------
-- Everbloom_Hollow (Zone 86)
-- ------------------------------------------------------------

INSERT INTO `mob_groups` VALUES (3705,12,86,'7th_Cohors_Legionnaire',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (3706,208,86,'Aragoneu_Knight',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (3707,224,86,'Arch_Ahriman',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (3708,756,86,'Cobra_Mercenary',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (3709,1349,86,'Five_Moons',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (3710,1545,86,'Giddy_Bomb',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (3711,1706,86,'Goblin_Reaver',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (3712,2103,86,'Iron_Ram_Knight',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (3713,2254,86,'King_Arthro',0,128,1448,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (3714,2271,86,'Knight_Crab',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (3715,2322,86,'Lambton_Worm',0,128,1481,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (3716,2837,86,'Nickel_Quadav',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (3717,2839,86,'Nicolaus',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (3718,2909,86,'Norvallen_Knight',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (3719,6759,86,'One-eyed_Gwajboj',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (3720,2999,86,'Orcish_Carrier',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (3721,6282,86,'Orcish_Gladiator',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (3722,3017,86,'Orcish_Grunt',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (3723,3018,86,'Orcish_Guard',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (3724,5558,86,'Orcish_Hexspinner',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (3725,3025,86,'Orcish_Officer',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (3726,3032,86,'Orcish_Serjeant',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (3727,3035,86,'Orcish_Stormer',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (3728,6284,86,'Orcish_Trooper',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (3729,5154,86,'Orcish_Veteran',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (3730,3229,86,'Pupil_Palliator_II',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (3731,3387,86,'Romaa_Mihgo',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (3732,3389,86,'Rongelouts_N_Distaud',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (3733,3402,86,'Royal_Garrison',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (3734,3403,86,'Royal_Guard',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (3735,3404,86,'Royal_Infantry',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (3736,3405,86,'Royal_Knight',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (3737,3410,86,'Ruby_Quadav',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (3738,3486,86,'Savage_Hound_Condottiere',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (3739,3495,86,'Scarlet_Boar_Esquire',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (3740,3986,86,'Trained_Bat',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (3741,3987,86,'Trained_Crab',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (3742,3988,86,'Trained_Scorpion',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (3743,4249,86,'Volker',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (3744,6264,86,'Yagudo_Abbot',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (3745,4433,86,'Yagudo_Missionary',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (3746,4475,86,'Young_Behemoth',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (3747,4493,86,'Zazarg',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (11350,5785,86,'Fangmonger',0,128,0,12000,0,0,NULL);
INSERT INTO `mob_groups` VALUES (11351,5786,86,'Excenmille',0,128,0,0,0,1,NULL);
INSERT INTO `mob_groups` VALUES (11352,5787,86,'Maxcimille',0,128,0,0,0,1,NULL);
INSERT INTO `mob_groups` VALUES (11353,5788,86,'Bostillette',0,128,0,0,0,1,NULL);
INSERT INTO `mob_groups` VALUES (11354,3458,86,'Sand_Pugil',0,128,0,1000,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (11355,7608,86,'Antican_Curule_Aedilis',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (11357,7609,86,'Berserk_Bunny',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (11359,7610,86,'Cave_Kraken',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (11361,7611,86,'Cornucopieyes',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (11362,7612,86,'Daimoxinos',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (11364,7613,86,'Dendigger_Crab',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (11365,7614,86,'Elkopsikor',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (11366,7615,86,'Feathered_Foe',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (11367,7616,86,'Felsic_Marolith',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (11369,7617,86,'Floppy_Hare',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (11370,7618,86,'Forcer',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (11371,7619,86,'Fresh_Catch',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (11373,7620,86,'Garmatur_the_Merciless',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (11374,7621,86,'Goblin_Browbeater',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (11375,7622,86,'Grotto_Panopt',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (11376,7623,86,'Hirudinid',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (11377,7624,86,'Izyx',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (11378,7625,86,'Izyxs_Voyeur',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (11382,7626,86,'Limber_Lynx',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (11383,7627,86,'Mafic_Marolith',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (11384,7628,86,'Magisterial_Meeble',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (11385,7629,86,'Maze_Lurker',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (11386,7630,86,'Melisseus',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (11387,7631,86,'Melisseus_Zamzama',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (11388,7632,86,'Moblin_Commander',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (11389,7633,86,'Moblin_Rapscallion',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (11390,7634,86,'Moblin_Ruffian',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (11391,7635,86,'Moblin_Thaumaturge',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (11394,7643,86,'Pupil_Palliator_I',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (11395,7644,86,'Pupil_Palliator_III',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (11396,7636,86,'Rambunctious_Meeble',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (11397,7637,86,'Rapacious_Meeble',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (11400,7638,86,'Samursk',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (11401,7639,86,'Spikehelm_Argok',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (11402,7640,86,'Stagdella',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (11404,7641,86,'Tethys',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (11406,7642,86,'Tunnel_Crab',0,128,0,0,0,0,NULL);

-- ------------------------------------------------------------
-- Ruhotz_Silvermines (Zone 93)
-- ------------------------------------------------------------

INSERT INTO `mob_groups` VALUES (4624,1,93,'1st_Gold_Musketeer',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4625,2,93,'1st_Iron_Musketeer',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4626,3,93,'1st_Legionnaire',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4627,7,93,'2nd_Legionnaire',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4628,10,93,'3rd_Legionnaire',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4629,13,93,'8th_Iron_Musketeer',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4630,50,93,'Adelheid',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4631,6233,93,'Ancient_Quadav',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4632,278,93,'Atomos',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4633,6240,93,'Brass_Quadav',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4634,6243,93,'Bronze_Quadav',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4635,600,93,'Cadet_Woundpatcher_I',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4636,601,93,'Cadet_Woundpatcher_II',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4637,602,93,'Cadet_Woundpatcher_III',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4638,609,93,'Cait_Sith_Ceithir',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4639,907,93,'Darksteel_Quadav',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4640,1753,93,'Gold_Quadav',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4641,1841,93,'Guivre',0,128,1251,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4642,2102,93,'Iron_Quadav',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4643,2322,93,'Lambton_Worm',0,128,1481,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4644,2415,93,'Lilisette',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4645,2486,93,'Magnes_Quadav',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4646,3273,93,'Quadav_Carrier',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4647,3274,93,'Quadav_Guard',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4648,3275,93,'Quadav_Stormer',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4649,3277,93,'Quadav_Turret',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4650,3352,93,'Republican_Infantry',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4651,3353,93,'Republic_Garrison',0,128,0,0,0,1,NULL);
INSERT INTO `mob_groups` VALUES (4652,7037,93,'Sapphire_Quadav',0,128,0,2500,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4653,7036,93,'Sapphirine_Quadav',0,128,0,2100,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4654,3769,93,'Steel_Quadav',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4655,3823,93,'Swarmspawn',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4656,3986,93,'Trained_Bat',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4657,3987,93,'Trained_Crab',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4658,3988,93,'Trained_Scorpion',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4659,4078,93,'Ulbrecht',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4660,4249,93,'Volker',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4661,7645,93,'Alicanto',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4662,7646,93,'Baricos',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4663,7647,93,'Battlegorged_Wamoura',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4668,7648,93,'Chaperix',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4669,7649,93,'Chaperixs_Elemental',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4670,7650,93,'Chigoe_Surprise',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4671,7651,93,'Coalcruncher_Lizard',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4672,7652,93,'Craggy_Marolith',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4673,7653,93,'Dinky_Bat',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4674,7654,93,'Dinky_Beetle',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4675,7655,93,'Dinky_Funguar',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4676,7656,93,'Dinky_Spider',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4677,7657,93,'Dinky_Worm',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4678,7658,93,'Dreyruk',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4679,7659,93,'Faulty_Mine',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4682,7660,93,'Findaflok',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4683,7661,93,'Fodder_Beetle',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4684,7662,93,'Fodder_Funguar',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4685,7663,93,'Fodder_Spider',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4686,7664,93,'Fodder_Worm',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4687,7665,93,'Forcer',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4688,7666,93,'Gigas_Gaoler',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4689,7667,93,'Glibber',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4690,7668,93,'Goblin_Digger',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4691,7669,93,'Goblin_Sentry',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4692,7670,93,'Grannus',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4693,7671,93,'Grannuss_Firebug',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4694,7672,93,'Guardian_Behemoth',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4695,7673,93,'Haietlik',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4696,7674,93,'Harried_Meeble',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4697,7675,93,'Hulking_Marolith',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4698,7676,93,'Ignoble_Ghoisdos',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4700,7677,93,'Kobcha',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4701,7678,93,'Lacquered_Mimic',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4705,7679,93,'Maze_Keeper',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4706,7680,93,'Maze_Lurker',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4707,7681,93,'Meeble_Horticulturist',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4708,7682,93,'Mesetetef',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4712,7683,93,'Mudcaked_Crawler',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4714,7684,93,'Nefarious_Ghoisdos',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4716,7685,93,'Oregnasher_Lizard',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4717,7686,93,'Papeterie',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4718,7687,93,'Picayune_Bat',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4719,7688,93,'Picayune_Beetle',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4726,7689,93,'Possessed_Claymores',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4727,7690,93,'Possessed_Daggers',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4728,7691,93,'Possessed_Longswords',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4729,7692,93,'Predacious_Wamouracampa',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4730,7693,93,'Reinforced_Crate',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4731,7694,93,'Rowdy_Meeble',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4733,7695,93,'Sanguinary_Wamoura',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4734,7696,93,'Shambling_Marolith',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4735,7697,93,'Skeleton_Aggressor',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4736,7698,93,'Skeleton_Skirmisher',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4739,7699,93,'Sombre_Mimic',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4741,7700,93,'Subterranean_Leohtfaet',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4745,7701,93,'Terrormonger',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4746,7702,93,'Treasure_Gobbler',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4747,7703,93,'Twilight_Truffle',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4749,7704,93,'Vociferous_Meeble',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4750,7705,93,'Watcher',0,128,0,0,0,0,NULL);

-- ------------------------------------------------------------
-- Ghoyus_Reverie (Zone 129)
-- ------------------------------------------------------------

INSERT INTO `mob_groups` VALUES (1,3387,129,'Romaa_Mihgo',0,128,0,0,0,1,NULL);
INSERT INTO `mob_groups` VALUES (2,756,129,'Cobra_Mercenary',0,128,0,0,0,1,NULL);
INSERT INTO `mob_groups` VALUES (3,5817,129,'Cobra_Mercenary_1',0,128,0,0,0,1,NULL);
INSERT INTO `mob_groups` VALUES (4,5819,129,'Cobra_Mercenary_3',0,128,0,0,0,1,NULL);
INSERT INTO `mob_groups` VALUES (5,5820,129,'Cobra_Mercenary_4',0,128,0,0,0,1,NULL);
INSERT INTO `mob_groups` VALUES (6,5821,129,'Cobra_Mercenary_5',0,128,0,0,0,1,NULL);
INSERT INTO `mob_groups` VALUES (7,5822,129,'Cobra_Mercenary_6',0,128,0,0,0,1,NULL);
INSERT INTO `mob_groups` VALUES (8,5823,129,'Cobra_Mercenary_7',0,128,0,0,0,1,NULL);
INSERT INTO `mob_groups` VALUES (9,5818,129,'Cobra_Mercenary_2',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (10,5824,129,'Cobra_Mercenary_8',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (11,5825,129,'Zircon_Quadav',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (12,5826,129,'Silver_Quadav',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (13,2837,129,'Nickel_Quadav',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (14,5827,129,'BoDhos_Shieldwarrior_2',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (15,1596,129,'Gigas_Trebucket',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (16,1560,129,'Gigas_Flanker',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (17,775,129,'Confederate_Belfry',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (18,2252,129,'Kingslayer_Doggvdegg',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (19,5814,129,'Gherrmoga',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (20,5815,129,'Bloodwing_Maimer',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (21,5346,129,'Bloodwing_Deathrainer',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (22,5786,129,'Excenmille',0,128,0,0,0,1,NULL);

INSERT INTO `mob_groups` VALUES (6868,9,129,'2nd_Legion_Scout',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6869,205,129,'Aquarian_Caster',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6870,226,129,'Arch_Demon',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6872,631,129,'Capricornian_Caster',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6875,812,129,'Count_Bifrons',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6876,1180,129,'Effluvial_Grenade',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6877,1207,129,'Emerald_Quadav',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6878,1315,129,'Federation_Garrison',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6879,1316,129,'Federation_Infantry',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6882,1702,129,'Goblin_Poisoner',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6884,2309,129,'Laa_Yaku_the_Austere',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6885,2322,129,'Lambton_Worm',0,128,1481,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6886,2406,129,'Libran_Caster',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6888,6242,129,'Old_Quadav',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6889,2985,129,'Onyx_Mine',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6890,6272,129,'Orcish_Brawler',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6891,6280,129,'Orcish_Footsoldier',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6892,5558,129,'Orcish_Hexspinner',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6893,3020,129,'Orcish_Impaler',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6894,6284,129,'Orcish_Trooper',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6895,3040,129,'Orcish_Turret',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6896,3243,129,'Python_Mercenary',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6898,3464,129,'Sapphirine_Quadav',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6899,3504,129,'Scorpion_Caster',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6900,3549,129,'Serket',0,128,2202,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6902,3986,129,'Trained_Bat',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6903,3987,129,'Trained_Crab',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6904,3988,129,'Trained_Scorpion',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6905,4237,129,'Virulent_Flask',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6906,4339,129,'Wildcat_Volunteer',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6907,4409,129,'Yagudo_Carrier',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6908,4414,129,'Yagudo_Conversus',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6909,5490,129,'Yagudo_Drummer',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6910,4421,129,'Yagudo_Guard',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6911,4422,129,'Yagudo_Gyrovague',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6912,5486,129,'Yagudo_Herald',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6913,5483,129,'Yagudo_Interrogator',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6914,4435,129,'Yagudo_Neophyte',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6915,5484,129,'Yagudo_Priest',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6916,5491,129,'Yagudo_Prior',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6917,4449,129,'Yagudo_Seminarian',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6918,4451,129,'Yagudo_Stormer',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6919,4456,129,'Yagudo_Theologist',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6920,5489,129,'Yagudo_Votary',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6922,7706,129,'7th_Cohors_Engineer',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6923,7707,129,'Anapos',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6924,7708,129,'Antje',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6925,7709,129,'Aphotic_Crab',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6926,7710,129,'Atlas_Beetle',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6927,7711,129,'Babalu_Aye',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6928,7712,129,'Befouled_Slime',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6929,7713,129,'Befuddled_Meeble',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6930,7714,129,'Bellicose_Tarichuk',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6931,7715,129,'Burrows_Depthmarker',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6932,7716,129,'Caointeach',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6934,7717,129,'Centycore',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6935,7718,129,'Chichevache',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6936,7719,129,'Chuhaister',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6937,7720,129,'Clay_Krater',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6938,7721,129,'Cluster_Fly',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6939,7722,129,'Cluster_Scorpion',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6940,7723,129,'Cluster_Spider',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6941,7724,129,'Colony_Bat',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6942,7725,129,'Crab',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6943,7726,129,'Crawler',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6944,7727,129,'Crusted_Pincer',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6945,7728,129,'Curupira',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6946,7729,129,'Dicey_Dorcus',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6948,7730,129,'Dzoavits',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6949,7731,129,'Egungun',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6950,7732,129,'Entremet',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6951,7733,129,'Extirpating_Weapon',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6953,7734,129,'Falxfang_Tiger',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6954,7735,129,'Feeble_Eft',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6955,7736,129,'Fetid_Slime',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6956,7737,129,'Fiendish_Weapon',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6957,7738,129,'Flamma',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6958,7739,129,'Flytrap',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6959,7740,129,'Fulmen',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6960,7741,129,'Fungic_Koti',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6961,7742,129,'Glacies',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6962,7743,129,'Gnat',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6963,7744,129,'Gnole',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6964,7745,129,'Gnyan',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6966,7746,129,'Goblin_Scrounger',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6967,7747,129,'Goldwing',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6968,7748,129,'Gorib',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6969,7749,129,'Gumdrop',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6970,7750,129,'Haferbocks',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6972,7751,129,'Hippalectryon',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6973,7752,129,'Incited_Meeble',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6974,7753,129,'Iyamoopo',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6975,7754,129,'Kendi',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6976,7755,129,'Kerwan',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6977,7756,129,'Kimmerios',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6978,7757,129,'Kraken',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6979,7758,129,'Kuperan',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6980,7759,129,'Ladybug',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6981,7760,129,'Lair_Lizard',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6982,7761,129,'Leech',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6983,7762,129,'Lizard',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6985,7763,129,'Lubber_Lyle',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6986,7764,129,'Luminare',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6987,7765,129,'Maze_Demolisher',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6988,7766,129,'Maze_Lurker',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6989,7767,129,'Meeble_Augur',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6990,7768,129,'Meeble_Scribe',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6991,7769,129,'Metshaldjas',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6992,7770,129,'Metsik',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6994,7771,129,'Moblin_Arcanist',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6996,7772,129,'Moblin_Militant',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6997,7773,129,'Moblin_Miscreant',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6999,7774,129,'Mucid_Slime',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7000,7775,129,'Nhev_Befrathi',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7001,7776,129,'Nimble_Nelson',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7002,7777,129,'Niveus_Tages',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7003,7778,129,'Noxious_Nellie',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7004,7779,129,'Obin-Murt',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7005,7780,129,'Odious_Obdella',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7007,7781,129,'Opo-opo',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7008,7782,129,'Orcish_Mangler',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7009,7783,129,'Orcish_Muscle',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7010,7784,129,'Ore_Cruncher',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7011,7785,129,'Ore_Devourer',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7012,7786,129,'Osteoguard',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7013,7787,129,'Peckish_Cockatrice',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7014,7788,129,'Peiste',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7015,7789,129,'Pesoso',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7016,7790,129,'Piceous_Mimic',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7027,7791,129,'Pugnacious_Eft',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7028,7792,129,'Purushamriga',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7029,7793,129,'Rafflesia',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7030,7794,129,'Rahu',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7031,7795,129,'Rambunctious_Meeble',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7032,7796,129,'Red_Pillywiggin',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7041,7797,129,'Scultone',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7042,7798,129,'Seua_Peek',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7043,7799,129,'Shadhavar',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7044,7800,129,'Shadhavars_Avatar',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7046,7801,129,'Silagilith',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7047,7802,129,'Siltim',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7048,7803,129,'Skeleton',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7049,7804,129,'Skoll',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7050,7805,129,'Slug',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7051,7806,129,'Snarling_Meeble',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7052,7807,129,'Sparky_Sam',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7053,7808,129,'Spider',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7054,7809,129,'Stoic_Marolith',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7056,7810,129,'Student_Salvemixer_I',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7057,7811,129,'Student_Salvemixer_II',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7058,7812,129,'Student_Salvemixer_III',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7059,7813,129,'Subterranean_Safepoint',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7060,7814,129,'Sulphurous_Bomb',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7061,7815,129,'Sulphurous_Djinn',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7062,7816,129,'Surtr',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7064,7817,129,'Svaha',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7065,7818,129,'Syu_Befrathi',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7066,7819,129,'Tanihwa',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7067,7820,129,'Tatzelwurm',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7068,7821,129,'Tectochuk',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7069,7822,129,'Tellus',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7070,7823,129,'Tenebrous_Bat',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7071,7824,129,'Terror_Fly',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7072,7825,129,'Tumultuous_Worm',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7073,7826,129,'Tupilaq',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7074,7827,129,'Umagrhk',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7075,7828,129,'Varaneft',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7076,7829,129,'Ventus',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7077,7830,129,'Wicked_Weapon',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7078,7831,129,'Winged_Menace',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7079,7832,129,'Worm',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7080,7833,129,'Yagudo_Kamari',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7081,7834,129,'Yellow_Pillywiggin',0,128,0,0,0,0,NULL);

-- --------------------------------------------------------------
-- Outer Ra'Kaznar [U2] (Zone 133)
-- --------------------------------------------------------------

INSERT INTO `mob_groups` VALUES (1,8106,133,'Abject_Acuex',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (2,8107,133,'Abject_Hecteyes',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (3,8108,133,'Abject_Leech',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4,8109,133,'Abject_Obdella',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (5,8110,133,'Aita',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6,8111,133,'Aminon',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7,8112,133,'Biune_Air_Elemental',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (8,8113,133,'Biune_Dark_Elemental',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (9,8114,133,'Biune_Earth_Elemental',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (10,8115,133,'Biune_Fire_Elemental',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (11,8116,133,'Biune_Ice_Elemental',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (12,8117,133,'Biune_Light_Elemental',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (13,8118,133,'Biune_Porxie',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (14,8119,133,'Biune_Thunder_Elemental',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (15,8120,133,'Biune_Umbril',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (16,8121,133,'Biune_Water_Elemental',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (17,7654,133,'Bztavian',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (18,8122,133,'Cachaemic_Bhoot',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (19,8123,133,'Cachaemic_Corse',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (20,8124,133,'Cachaemic_Ghost',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (21,8125,133,'Cachaemic_Ghoul',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (22,8126,133,'Cachaemic_Skeleton',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (23,7659,133,'Cehuetzi',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (24,8127,133,'Degei',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (25,8128,133,'Demisang_Black_Mage',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (26,8129,133,'Demisang_Deleterious',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (27,8130,133,'Demisang_Monk',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (28,8131,133,'Demisang_Red_Mage',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (29,8132,133,'Demisang_Thief',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (30,8133,133,'Demisang_Warrior',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (31,8134,133,'Demisang_White_Mage',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (32,8135,133,'Dhartok',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (53,8136,133,'Esurient_Botulus',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (54,8137,133,'Esurient_Flan',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (55,8138,133,'Esurient_Slime',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (56,8139,133,'Esurient_Slug',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (57,8140,133,'Fetid_Baelfyr',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (58,8141,133,'Fetid_Byrgen',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (59,8142,133,'Fetid_Gefyrst',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (60,8143,133,'Fetid_Ixion',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (61,8144,133,'Fetid_Ungeweder',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (62,8145,133,'Fetid_Veela',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (63,7656,133,'Gabbrath',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (64,8146,133,'Gartell',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (65,8147,133,'Ghatjot',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (66,8148,133,'Gyvewrapped_Dullahan',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (67,8149,133,'Gyvewrapped_Hound',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (68,8150,133,'Gyvewrapped_Naraka',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (69,8151,133,'Gyvewrapped_Vampyr',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (70,8152,133,'Haughty_Bard',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (71,8153,133,'Haughty_Beastmaster',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (72,8154,133,'Haughty_Dark_Knight',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (73,8155,133,'Haughty_Dragoon',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (74,8156,133,'Haughty_Ninja',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (75,8157,133,'Haughty_Paladin',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (76,8158,133,'Haughty_Ranger',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (77,8159,133,'Haughty_Samurai',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (78,8160,133,'Haughty_Tulittia',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (79,8161,133,'Leshonn',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (80,8162,133,'Malicious_Spire',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (81,8163,133,'Poison_Mist',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (82,7655,133,'Rockfin',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (83,8164,133,'Skomora',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (84,8165,133,'Triboulex',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (85,7658,133,'Waktza',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (86,7657,133,'Yggdreant',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (87,8166,133,'Zisurru',0,128,0,0,0,0,NULL);

-- ------------------------------------------------------------
-- Dragons_Aery (Zone 154)
-- ------------------------------------------------------------

-- fished

INSERT INTO `mob_groups` VALUES (5,1280,154,'Fafnir',0,128,805,60000,0,0,NULL);

-- ------------------------------------------------------------
-- Throne_Room (Zone 165)
-- ------------------------------------------------------------

-- 4 free
-- 20 free
-- 21 free
-- 25 free
INSERT INTO `mob_groups` VALUES (28,4249,165,'Volker',0,128,0,1300,0,1,NULL); -- ally

-- ------------------------------------------------------------
-- Full_Moon_Fountain (Zone 170)
-- ------------------------------------------------------------

-- 18 free
-- 20 free
-- 22 free
-- 24 free
-- 26 free
-- 28 free
-- 30 free
INSERT INTO `mob_groups` VALUES (33,75,170,'Ajido-Marujido',0,128,0,600,10000,1,NULL); -- ally TODO: Verify HP

-- ------------------------------------------------------------
-- Maquette_Abdhaljs-Legion_A (Zone 183)
-- ------------------------------------------------------------

INSERT INTO `mob_groups` VALUES (1,5744,183,'Lofty_Behemoth',0,128,0,90000,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (2,5745,183,'Lofty_Wyrm',0,128,0,90000,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (3,5746,183,'Lofty_Adamantoise',0,128,0,90000,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (4,5747,183,'Lofty_Elasmoth',0,128,0,90000,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (5,5748,183,'Lofty_Zilant',0,128,0,90000,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (6,5749,183,'Lofty_Ferromantoise',0,128,0,90000,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (7,5750,183,'Lofty_Harpeia',0,128,0,90000,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (8,5791,183,'Mired_Cerberus',0,128,0,90000,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (9,5790,183,'Mired_Khimaira',0,128,0,90000,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (10,5789,183,'Mired_Hydra',0,128,0,90000,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (11,5794,183,'Mired_Orthrus',0,128,0,90000,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (12,5793,183,'Mired_Khrysokhimaira',0,128,0,90000,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (13,5792,183,'Mired_Alfard',0,128,0,90000,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (14,5783,183,'Mired_Mantis',0,128,0,90000,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (15,5797,183,'Soaring_Corse',0,128,0,90000,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (16,5796,183,'Soaring_Dvergr',0,128,0,90000,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (17,5795,183,'Soaring_Vampyr',0,128,0,90000,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (18,5800,183,'Soaring_Kumakatok',0,128,0,90000,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (19,5799,183,'Soaring_Dweorg',0,128,0,90000,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (20,5798,183,'Soaring_Strigoi',0,128,0,90000,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (21,5784,183,'Soaring_Naraka',0,128,0,90000,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (22,5805,183,'Veiled_Amphiptere',0,128,0,90000,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (23,5806,183,'Veiled_Ixion',0,128,0,90000,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (24,5801,183,'Veiled_Sandworm',0,128,0,90000,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (25,5802,183,'Veiled_Sanguiptere',0,128,0,90000,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (26,5803,183,'Veiled_Alicorn',0,128,0,90000,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (27,5804,183,'Veiled_Gigaworm',0,128,0,90000,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (28,5782,183,'Veiled_Ironclad',0,128,0,90000,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (29,5781,183,'Paramount_Naraka',0,128,0,90000,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (30,5780,183,'Paramount_Harpeia',0,128,0,90000,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (31,5779,183,'Paramount_Mantis',0,128,0,90000,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (32,5778,183,'Paramount_Ironclad',0,128,0,90000,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (33,5777,183,'Paramount_Gallu',0,128,0,90000,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (34,5776,183,'Paramount_Botulus',0,128,0,90000,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (35,0,183,'Paramount_Avatar',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (36,5810,183,'Auspicious_Entity_Dark',0,128,0,5000,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (37,5812,183,'Auspicious_Entity_ice3',0,128,0,5000,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (38,5807,183,'Auspicious_Entity_Ice',0,128,0,5000,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (39,5808,183,'Auspicious_Entity_Wind',0,128,0,5000,9999,0,NULL);
INSERT INTO `mob_groups` VALUES (40,5809,183,'Auspicious_Entity_ice2',0,128,0,5000,9999,0,NULL);

INSERT INTO `mob_groups` VALUES (11288,5811,183,'Auspicious_Entity_Earth',0,128,0,5000,9999,0,NULL);

-- --------------------------------------------------------------
-- Outer Ra'Kaznar [U3] (Zone 189)
-- --------------------------------------------------------------

INSERT INTO `mob_groups` VALUES (1,8106,189,'Abject_Acuex',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (2,8107,189,'Abject_Hecteyes',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (3,8108,189,'Abject_Leech',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4,8109,189,'Abject_Obdella',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (5,8110,189,'Aita',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6,8111,189,'Aminon',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7,8112,189,'Biune_Air_Elemental',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (8,8113,189,'Biune_Dark_Elemental',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (9,8114,189,'Biune_Earth_Elemental',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (10,8115,189,'Biune_Fire_Elemental',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (11,8116,189,'Biune_Ice_Elemental',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (12,8117,189,'Biune_Light_Elemental',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (13,8118,189,'Biune_Porxie',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (14,8119,189,'Biune_Thunder_Elemental',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (15,8120,189,'Biune_Umbril',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (16,8121,189,'Biune_Water_Elemental',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (17,7654,189,'Bztavian',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (18,8122,189,'Cachaemic_Bhoot',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (19,8123,189,'Cachaemic_Corse',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (20,8124,189,'Cachaemic_Ghost',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (21,8125,189,'Cachaemic_Ghoul',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (22,8126,189,'Cachaemic_Skeleton',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (23,7659,189,'Cehuetzi',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (24,8127,189,'Degei',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (25,8128,189,'Demisang_Black_Mage',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (26,8129,189,'Demisang_Deleterious',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (27,8130,189,'Demisang_Monk',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (28,8131,189,'Demisang_Red_Mage',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (29,8132,189,'Demisang_Thief',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (30,8133,189,'Demisang_Warrior',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (31,8134,189,'Demisang_White_Mage',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (32,8135,189,'Dhartok',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (53,8136,189,'Esurient_Botulus',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (54,8137,189,'Esurient_Flan',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (55,8138,189,'Esurient_Slime',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (56,8139,189,'Esurient_Slug',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (57,8140,189,'Fetid_Baelfyr',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (58,8141,189,'Fetid_Byrgen',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (59,8142,189,'Fetid_Gefyrst',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (60,8143,189,'Fetid_Ixion',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (61,8144,189,'Fetid_Ungeweder',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (62,8145,189,'Fetid_Veela',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (63,7656,189,'Gabbrath',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (64,8146,189,'Gartell',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (65,8147,189,'Ghatjot',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (66,8148,189,'Gyvewrapped_Dullahan',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (67,8149,189,'Gyvewrapped_Hound',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (68,8150,189,'Gyvewrapped_Naraka',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (69,8151,189,'Gyvewrapped_Vampyr',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (70,8152,189,'Haughty_Bard',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (71,8153,189,'Haughty_Beastmaster',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (72,8154,189,'Haughty_Dark_Knight',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (73,8155,189,'Haughty_Dragoon',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (74,8156,189,'Haughty_Ninja',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (75,8157,189,'Haughty_Paladin',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (76,8158,189,'Haughty_Ranger',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (77,8159,189,'Haughty_Samurai',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (78,8160,189,'Haughty_Tulittia',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (79,8161,189,'Leshonn',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (80,8162,189,'Malicious_Spire',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (81,8163,189,'Poison_Mist',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (82,7655,189,'Rockfin',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (83,8164,189,'Skomora',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (84,8165,189,'Triboulex',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (85,7658,189,'Waktza',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (86,7657,189,'Yggdreant',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (87,8166,189,'Zisurru',0,128,0,0,0,0,NULL);

-- ------------------------------------------------------------
-- QuBia_Arena (Zone 206)
-- ------------------------------------------------------------

-- 63 free
-- 64 free
INSERT INTO `mob_groups` VALUES (75,4006,206,'Trion',0,128,0,1400,0,1,NULL); -- ally

-- ------------------------------------------------------------
-- GM Zone (Zone 210)
-- ------------------------------------------------------------

-- Garrison NPCs (1 per level cap). These are inserted dynamically. Only min/max level matters.
-- Consider adding a dynamic entity spawn param for min / max level so we only need 1 base mob group.
INSERT INTO `mob_groups` VALUES (1,7071,210,'Garrison',0,128,0,0,0,1,NULL);

-- ------------------------------------------------------------
-- Rala_Waterways_[U] (Zone 259)
-- ------------------------------------------------------------

INSERT INTO `mob_groups` VALUES (1,0,259,'Aquifer_Leech',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (2,0,259,'Deft_Eft',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (3,0,259,'Coreborn_Spider',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4,0,259,'Anklebiter_Slug',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (5,0,259,'Ergoprowler',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6,0,259,'Bonesoaked_Bandit',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7,0,259,'Bufobrawler',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (8,0,259,'Batroika',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (9,0,259,'Bonesoaked_Warmonger',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (10,0,259,'Bonesoaked_Sorcerer',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (11,0,259,'Combustible_Gel',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (12,0,259,'Citrine_Slime',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (13,0,259,'Slashmaw_Pugil',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (14,0,259,'Diremite_Assailant',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (15,0,259,'Watermarked_Crab',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (16,0,259,'Woecroak_Toad',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (17,0,259,'Forsaken_Obdella',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (18,0,259,'Sewer_Tarichuk',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (19,0,259,'Skulking_Spider',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (20,0,259,'Photophobic_Bat',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (21,0,259,'Crustnibbler_Twitherym',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (22,0,259,'Sludgeslither_Slime',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (23,0,259,'Karst_Crab',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (24,5507,259,'Zurko-Bazurko',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (25,0,259,'Sverdhried_qm',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (26,5496,259,'Arciela',0,128,0,0,0,1,NULL);
INSERT INTO `mob_groups` VALUES (27,5513,259,'The_Keeper',0,128,0,24000,0,0,NULL);
INSERT INTO `mob_groups` VALUES (28,5514,259,'Mistdagger',0,128,0,9000,0,0,NULL);
INSERT INTO `mob_groups` VALUES (29,5515,259,'The_Briars_elv',0,128,0,17000,0,0,NULL);
INSERT INTO `mob_groups` VALUES (30,5516,259,'The_Briars_gal',0,128,0,22000,0,0,NULL);
INSERT INTO `mob_groups` VALUES (31,0,259,'Stormy_Autochthon',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (32,0,259,'Windrender',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (33,0,259,'Reaving_Craklaw',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (34,0,259,'Shambling_Matamata',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (35,0,259,'Krabukelevu',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (36,0,259,'Erratic_Twitherym',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (37,0,259,'Harmonious_Heartwing',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (38,0,259,'Balamors_Adumbration',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (39,0,259,'Mistmaw_Kroni',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (40,0,259,'Mistmaw_Guayota',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (41,0,259,'Mistmaw_Leraje',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (42,0,259,'Mistmaw_Tecciztecatl',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (43,5505,259,'Balamor',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (44,5503,259,'Balamors_Sycophant',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (45,5504,259,'Regicidal_Dullahan',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (46,0,259,'Teodor',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (47,0,259,'Pupadi_Dollmohr',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (48,0,259,'Celestin',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (49,0,259,'Fabioso',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (50,0,259,'Tuffle-Buffle',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (51,0,259,'Musto-Rusto',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (52,0,259,'Ygnas',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (53,5499,259,'Darrcuiln',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (54,5512,259,'Ingrid',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (55,5501,259,'Morimar',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (56,0,259,'Rosulatia',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (57,0,259,'Cirrus',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (58,4927,259,'Colkhab',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (59,4677,259,'Achuka',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (60,4925,259,'Tchakka',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (61,4678,259,'Hurkan',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (62,4926,259,'Yumcax',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (63,4799,259,'Kumhau',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (64,0,259,'Sajjaka',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (65,0,259,'August',0,128,0,0,0,0,NULL);

-- ------------------------------------------------------------
-- Yorcia_Weald_[U] (Zone 264)
-- ------------------------------------------------------------

INSERT INTO `mob_groups` VALUES (1,0,264,'Unblinking_Panopt',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (2,0,264,'Windblown_Treant',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (3,0,264,'Frothing_Snapweed',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4,0,264,'Thorny_Rafflesia',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (5,0,264,'Feverish_Ameretat',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6,0,264,'Engorged_Belladonna',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7,0,264,'Stumbling_Sapling',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (8,0,264,'Inflamed_Flytrap',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (9,0,264,'Flustered_Funguar',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (10,0,264,'Woodlot_Luckybug',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (11,0,264,'Mulcher_Beetle',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (12,0,264,'Sly_Opo-opo',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (13,0,264,'Highhop_Lapinion',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (14,0,264,'Sunburnt_Twitherym',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (15,0,264,'Weald_Wasp',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (16,0,264,'Dithering_Heartwing',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (17,0,264,'Bestial_Den',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (18,0,264,'Cantonment',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (19,0,264,'Stockade',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (20,0,264,'Broxa',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (21,0,264,'Plaguevein_Bats',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (22,0,264,'Hakawai',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (23,0,264,'Ironbeak_Inguza',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (24,0,264,'Podarge',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (25,0,264,'Cailimh',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (26,0,264,'Yowling_Cockatrice',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (27,0,264,'Grisly_Bat',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (28,0,264,'Waddling_Apkallu',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (29,0,264,'Breathless_Hippogryph',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (30,0,264,'Darkscreecher',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (31,0,264,'Fleshprickler_Bats',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (32,0,264,'Anguished_Roc',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (33,0,264,'XagNar',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (34,0,264,'Laevvid',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (35,0,264,'Morseiu',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (36,0,264,'Ircinraq',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (37,0,264,'Hyoscya',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (38,0,264,'Wopket',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (39,0,264,'Budding_Rafflesia',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (40,0,264,'Turgid_Flytrap',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (41,0,264,'Pitchslathered_Sapling',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (42,0,264,'Masticating_Ameretat',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (43,0,264,'Mossmouthed_Funguar',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (44,0,264,'Sabotender_Viajero',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (45,0,264,'Perennial_Pachypodium',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (46,0,264,'Calydontis',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (47,0,264,'Azeman',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (48,0,264,'Sinaa',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (49,0,264,'Cherti',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (50,0,264,'Mirka',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (51,0,264,'Utkux',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (52,0,264,'Coppice_Manticore',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (53,0,264,'Conniving_Lucerewe',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (54,0,264,'Grassglut_Rabbit',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (55,0,264,'Rambunctious_Ram',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (56,0,264,'Machinating_Opo-opo',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (57,0,264,'Frothing_Tiger',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (58,0,264,'Humpheave_Marid',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (59,0,264,'Bygone_Geomancer',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (60,0,264,'Luopan',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (62,0,264,'Ashrakk',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (63,0,264,'Morimar',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (64,0,264,'Hell-spawned_Orthrus',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (65,0,264,'Headless_Torturer',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (66,0,264,'Ingrid',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (67,0,264,'Escalent',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (68,0,264,'Malicious_Acuex',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (69,0,264,'Malicious_Craklaw',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (70,0,264,'Malicious_Tulfaire',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (71,0,264,'Malicious_Raaz',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (72,0,264,'Malicious_Snapweed',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (73,0,264,'Malicious_Chapuli',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (74,0,264,'Malicious_Matamata',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (75,0,264,'Malicious_Dullahan',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (76,0,264,'Malicious_Sirgallyx',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (77,0,264,'Valiant_Entozoon',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (78,0,264,'Valiant_Crab',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (79,0,264,'Valiant_Colibri',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (80,0,264,'Valiant_Coeurl',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (81,0,264,'Valiant_Mandragora',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (82,0,264,'Valiant_Scorpion',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (83,0,264,'Valiant_Adamantoise',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (84,0,264,'Valiant_Tome',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (85,0,264,'Valiant_Ajattara',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (86,0,264,'Valiant_Snoll',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (87,0,264,'Valiant_Byakko',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (88,0,264,'Valiant_Suzaku',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (89,0,264,'Valiant_Seiryu',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (90,0,264,'Valiant_Kirin',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (91,0,264,'Valiant_Genbu',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (92,0,264,'Balamors_Adumbration',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (93,0,264,'Stronghold',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (94,0,264,'Marchland',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (95,0,264,'Lorissa',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (96,0,264,'Gramk-Droog',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (97,0,264,'Ymmr-Ulvid_Gloomlight',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (98,0,264,'Ignor-Mnt_Stealthslayer',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (99,0,264,'Durs-Vike_Deathspell',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (100,0,264,'Tryl-Wuj_Wingrip',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (101,0,264,'Tryl-Wujs_Peapuk',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (102,0,264,'Liij-Vok_Waxwane',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (103,0,264,'Ygnas',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (104,0,264,'Nashu',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (105,0,264,'Siren_Prime',0,128,0,0,0,0,NULL);

-- ------------------------------------------------------------
-- Cirdas_Caverns_[U] (Zone 271) -- delve ceizak
-- ------------------------------------------------------------

INSERT INTO `mob_groups` VALUES (1,0,271,'Rufescent_Bat',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (2,0,271,'Doline_Bats',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (3,0,271,'Estavelle_Acuex',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4,0,271,'Funguar_Abrupta',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (5,0,271,'Abrupta_Spawn',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6,0,271,'Brumeblister_Obdella',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7,0,271,'Pustulous_Obdella',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (8,0,271,'Recalcitrant_Umbril',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (9,0,271,'Crustguzzler_Worm',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (10,0,271,'Pungent_Fungus',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (11,0,271,'Bloodcurdling_Acuex',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (12,0,271,'Sanguinary_Clot',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (13,0,271,'Alruna',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (14,0,271,'Shadeshawl_Obdella',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (15,0,271,'Nightmist_Umbril',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (16,0,271,'Emberblaze_Spider',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (17,0,271,'Sootscuttle_Spider',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (18,0,271,'Hornblende_Lizard',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (19,0,271,'Wrinkled_Toad',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (20,0,271,'Mistgorger_Lizard',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (21,0,271,'Flinthaze_Umbril',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (22,0,271,'Cinnabar_Spider',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (23,0,271,'Dappled_Spider',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (24,0,271,'Faultline_Acuex',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (25,0,271,'Cenote_Acuex',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (26,0,271,'Catacomb_Marolith',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (27,0,271,'Sepulchral_Lizard',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (28,0,271,'Wartless_Toad',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (29,0,271,'Ulcerous_Acuex',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (30,0,271,'Unfettered_Twitherym',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (31,0,271,'Supernal_Chapuli',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (32,0,271,'Transcendent_Scorpion',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (33,0,271,'Mastop',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (34,0,271,'Taxet',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (35,0,271,'Muyingwa',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (36,0,271,'Fugacious_Eruca',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (37,0,271,'Fugacious_Beetle',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (38,0,271,'Fugacious_Diremite',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (39,0,271,'Fugacious_Luckybug',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (40,0,271,'Faded_Craklaw',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (41,0,271,'Aberrant_Uragnite',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (42,0,271,'Divagating_Jagil',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (43,0,271,'Nerrivik',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (44,0,271,'Krabakarpo',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (45,0,271,'Dakuwaqa',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (46,0,271,'Fugacious_Crab',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (47,0,271,'Fugacious_Kraken',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (48,0,271,'Fugacious_Toad',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (49,0,271,'Volatile_Matamata',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (50,0,271,'Perdurable_Raptor',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (51,0,271,'Shimmering_Tarichuk',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (52,0,271,'Tutewehiwehi',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (53,0,271,'Kurma',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (54,0,271,'Tojil',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (55,0,271,'Fugacious_Lizard',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (56,0,271,'Fugacious_Eft',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (57,0,271,'Fugacious_Bugard',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (58,0,271,'Fugacious_Wivre',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (59,0,271,'Primogenial_Marolith',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (60,0,271,'Ingrid',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (61,0,271,'Olaviaud',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (62,0,271,'Pempoint',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (63,0,271,'Gargouille_Drudge',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (64,0,271,'Noble_Warrior',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (65,0,271,'Darrcuiln',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (66,0,271,'Arciela',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (67,0,271,'Resolute_Leafkin',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (68,0,271,'Pustulous_Umbril',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (69,0,271,'Stormy_Autochthon',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (70,0,271,'Windrender',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (71,0,271,'Aconite_Sibilus',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (72,0,271,'Leering_Akoman',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (73,0,271,'Weedwomp_Lapinion',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (74,0,271,'Partizan_Wasp',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (75,0,271,'Harmonious_Heartwing',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (76,0,271,'Balamors_Adumbration',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (77,0,271,'Mistmaw_Tawhiri',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (78,0,271,'Mistmaw_Xelhua',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (79,0,271,'Mistmaw_Cacus',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (80,0,271,'Mistmaw_Aatxe',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (81,0,271,'Velkk_Shadesifter',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (82,0,271,'Velkk_Factotum',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (83,0,271,'Velkk_Skullgrinder',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (84,0,271,'Mudmange_Lapinion',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (85,0,271,'Velkk_Prophet',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (86,0,271,'Velkk_Campaigner',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (87,0,271,'Trunktusk_Razz',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (88,0,271,'Velkk_Spellslinger',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (89,0,271,'Velkk_Serpentslasher',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (90,0,271,'Velkks_Puk',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (91,0,271,'Adit_Crab',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (92,0,271,'Bunkerback_Craklaw',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (93,0,271,'Bellicosiraptor',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (94,0,271,'Hulking_Matamata',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (95,0,271,'Wasptrap',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (96,0,271,'Burbling_Snapweed',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (97,0,271,'Garrulous_Colibri',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (98,0,271,'Ravenous_Tulfaire',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (99,0,271,'Stoneripper_Chapuli',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (100,0,271,'Prickly_Wasp',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (101,0,271,'Ymmr-Ulvid_Gloomlight',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (102,0,271,'Brawny_Adherent',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (103,0,271,'Steadfast_Adherent',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (104,0,271,'Occult_Adherent',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (105,0,271,'Furtive_Adherent',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (106,0,271,'Insidious_Adherent',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (107,0,271,'Fleet_Adherent',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (108,0,271,'Martial_Adherent',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (109,0,271,'Durs-Vike_Deathspell',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (110,0,271,'Hexbreaking_Adherent',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (111,0,271,'Honed_Adherent',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (112,0,271,'Ignor-Mnt_Stealthslayer',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (113,0,271,'Tryl-Wuj_Wingrip',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (114,0,271,'Tryl-Wujs_Peapuk',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (115,0,271,'Liij-Vok_Waxwane',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (116,0,271,'Brash_Gramk-Droog',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (117,0,271,'Gramk-Droog',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (118,0,271,'Vanquisher_Gramk-Droog',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (119,0,271,'Dhokmak',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (120,0,271,'Malignant_Acuex',0,128,0,0,0,0,NULL);

-- ------------------------------------------------------------
-- Maquette_Abdhaljs-Legion_B (Zone 287)
-- ------------------------------------------------------------

INSERT INTO `mob_groups` VALUES (1,5744,287,'Lofty_Behemoth',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (2,5745,287,'Lofty_Wyrm',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (3,5746,287,'Lofty_Adamantoise',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (4,5747,287,'Lofty_Elasmoth',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (5,5748,287,'Lofty_Zilant',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (6,5749,287,'Lofty_Ferromantoise',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (7,5750,287,'Lofty_Harpeia',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (8,4203,287,'Varanus',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (9,5791,287,'Mired_Cerberus',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (10,5790,287,'Mired_Khimaira',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (11,5789,287,'Mired_Hydra',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (12,5794,287,'Mired_Orthrus',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (13,5793,287,'Mired_Khrysokhimaira',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (14,5792,287,'Mired_Alfard',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (15,5783,287,'Mired_Mantis',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (16,5797,287,'Soaring_Corse',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (17,5796,287,'Soaring_Dvergr',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (18,5795,287,'Soaring_Vampyr',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (19,5800,287,'Soaring_Kumakatok',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (20,5799,287,'Soaring_Dweorg',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (21,5798,287,'Soaring_Strigoi',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (22,5784,287,'Soaring_Naraka',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (23,5805,287,'Veiled_Amphiptere',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (24,5806,287,'Veiled_Ixion',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (25,5801,287,'Veiled_Sandworm',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (26,5802,287,'Veiled_Sanguiptere',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (27,5803,287,'Veiled_Alicorn',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (28,5804,287,'Veiled_Gigaworm',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (29,5782,287,'Veiled_Ironclad',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (30,5781,287,'Paramount_Naraka',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (31,5780,287,'Paramount_Harpeia',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (32,5779,287,'Paramount_Mantis',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (33,5778,287,'Paramount_Ironclad',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (34,5777,287,'Paramount_Gallu',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (35,5776,287,'Paramount_Botulus',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (36,0,287,'Paramount_Avatar',0,128,0,0,0,0,NULL);
INSERT INTO `mob_groups` VALUES (37,0,287,'Auspicious_Entity',0,128,0,0,0,0,NULL);

-- ------------------------------------------------------------
-- Start of Ambuscade section
-- NOTE: The mobs are changed every update in the DATs, so using out-of-date
--       mob entries will result in the current update's names being shown.

-- April 2021 V1: Meebles
INSERT INTO `mob_groups` VALUES (38,30000,287,'Bozzetto_Breadwinner',0,0,0,280000,0,0,NULL);

-- End of Ambuscade section
