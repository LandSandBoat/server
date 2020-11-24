-- MySQL dump 10.13  Distrib 5.7.12, for Win64 (x86_64)
--
-- Host: localhost    Database: tpzdb
-- ------------------------------------------------------
-- Server version   5.5.5-10.0.20-MariaDB

--
-- Table structure for table `bcnm_battlefield`
--

DROP TABLE IF EXISTS `bcnm_battlefield`;
CREATE TABLE `bcnm_battlefield` (
  `bcnmId` smallint(5) unsigned NOT NULL,
  `battlefieldNumber` tinyint(3) DEFAULT NULL,
  `monsterId` int(10) NOT NULL,
  `conditions` tinyint(2) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=56;

--
-- Dumping data for table `bcnm_battlefield`
--

INSERT INTO `bcnm_battlefield` VALUES (0,1,17346561,3); -- rank_2_mission (Horlais Peak)
INSERT INTO `bcnm_battlefield` VALUES (0,1,17346562,3);
INSERT INTO `bcnm_battlefield` VALUES (0,2,17346563,3);
INSERT INTO `bcnm_battlefield` VALUES (0,2,17346564,3);
INSERT INTO `bcnm_battlefield` VALUES (0,3,17346565,3);
INSERT INTO `bcnm_battlefield` VALUES (0,3,17346566,3);
INSERT INTO `bcnm_battlefield` VALUES (1,1,17346645,3); -- tails_of_woe
INSERT INTO `bcnm_battlefield` VALUES (1,1,17346646,3);
INSERT INTO `bcnm_battlefield` VALUES (1,1,17346647,3);
INSERT INTO `bcnm_battlefield` VALUES (1,1,17346648,3);
INSERT INTO `bcnm_battlefield` VALUES (1,1,17346649,3);
INSERT INTO `bcnm_battlefield` VALUES (1,1,17346650,3);
INSERT INTO `bcnm_battlefield` VALUES (1,1,17346651,3);
INSERT INTO `bcnm_battlefield` VALUES (1,1,17346652,3);
INSERT INTO `bcnm_battlefield` VALUES (1,2,17346654,3);
INSERT INTO `bcnm_battlefield` VALUES (1,2,17346655,3);
INSERT INTO `bcnm_battlefield` VALUES (1,2,17346656,3);
INSERT INTO `bcnm_battlefield` VALUES (1,2,17346657,3);
INSERT INTO `bcnm_battlefield` VALUES (1,2,17346658,3);
INSERT INTO `bcnm_battlefield` VALUES (1,2,17346659,3);
INSERT INTO `bcnm_battlefield` VALUES (1,2,17346660,3);
INSERT INTO `bcnm_battlefield` VALUES (1,2,17346661,3);
INSERT INTO `bcnm_battlefield` VALUES (1,3,17346663,3);
INSERT INTO `bcnm_battlefield` VALUES (1,3,17346664,3);
INSERT INTO `bcnm_battlefield` VALUES (1,3,17346665,3);
INSERT INTO `bcnm_battlefield` VALUES (1,3,17346666,3);
INSERT INTO `bcnm_battlefield` VALUES (1,3,17346667,3);
INSERT INTO `bcnm_battlefield` VALUES (1,3,17346668,3);
INSERT INTO `bcnm_battlefield` VALUES (1,3,17346669,3);
INSERT INTO `bcnm_battlefield` VALUES (1,3,17346670,3);
INSERT INTO `bcnm_battlefield` VALUES (2,1,17346696,3); -- dismemberment_brigade
INSERT INTO `bcnm_battlefield` VALUES (2,1,17346697,3);
INSERT INTO `bcnm_battlefield` VALUES (2,1,17346698,3);
INSERT INTO `bcnm_battlefield` VALUES (2,1,17346699,3);
INSERT INTO `bcnm_battlefield` VALUES (2,1,17346700,3);
INSERT INTO `bcnm_battlefield` VALUES (2,1,17346701,3);
INSERT INTO `bcnm_battlefield` VALUES (2,2,17346703,3);
INSERT INTO `bcnm_battlefield` VALUES (2,2,17346704,3);
INSERT INTO `bcnm_battlefield` VALUES (2,2,17346705,3);
INSERT INTO `bcnm_battlefield` VALUES (2,2,17346706,3);
INSERT INTO `bcnm_battlefield` VALUES (2,2,17346707,3);
INSERT INTO `bcnm_battlefield` VALUES (2,2,17346708,3);
INSERT INTO `bcnm_battlefield` VALUES (2,3,17346710,3);
INSERT INTO `bcnm_battlefield` VALUES (2,3,17346711,3);
INSERT INTO `bcnm_battlefield` VALUES (2,3,17346712,3);
INSERT INTO `bcnm_battlefield` VALUES (2,3,17346713,3);
INSERT INTO `bcnm_battlefield` VALUES (2,3,17346714,3);
INSERT INTO `bcnm_battlefield` VALUES (2,3,17346715,3);
INSERT INTO `bcnm_battlefield` VALUES (3,1,17346567,3); -- the_secret_weapon
INSERT INTO `bcnm_battlefield` VALUES (3,1,17346568,3);
INSERT INTO `bcnm_battlefield` VALUES (3,1,17346569,3);
INSERT INTO `bcnm_battlefield` VALUES (3,1,17346570,3);
INSERT INTO `bcnm_battlefield` VALUES (3,1,17346571,3);
INSERT INTO `bcnm_battlefield` VALUES (3,1,17346572,3);
INSERT INTO `bcnm_battlefield` VALUES (3,2,17346573,3);
INSERT INTO `bcnm_battlefield` VALUES (3,2,17346574,3);
INSERT INTO `bcnm_battlefield` VALUES (3,2,17346575,3);
INSERT INTO `bcnm_battlefield` VALUES (3,2,17346576,3);
INSERT INTO `bcnm_battlefield` VALUES (3,2,17346577,3);
INSERT INTO `bcnm_battlefield` VALUES (3,2,17346578,3);
INSERT INTO `bcnm_battlefield` VALUES (3,3,17346579,3);
INSERT INTO `bcnm_battlefield` VALUES (3,3,17346580,3);
INSERT INTO `bcnm_battlefield` VALUES (3,3,17346581,3);
INSERT INTO `bcnm_battlefield` VALUES (3,3,17346582,3);
INSERT INTO `bcnm_battlefield` VALUES (3,3,17346583,3);
INSERT INTO `bcnm_battlefield` VALUES (3,3,17346584,3);
INSERT INTO `bcnm_battlefield` VALUES (4,1,17346684,3); -- hostile_herbivores
INSERT INTO `bcnm_battlefield` VALUES (4,1,17346685,3);
INSERT INTO `bcnm_battlefield` VALUES (4,1,17346686,3);
INSERT INTO `bcnm_battlefield` VALUES (4,2,17346688,3);
INSERT INTO `bcnm_battlefield` VALUES (4,2,17346689,3);
INSERT INTO `bcnm_battlefield` VALUES (4,2,17346690,3);
INSERT INTO `bcnm_battlefield` VALUES (4,3,17346692,3);
INSERT INTO `bcnm_battlefield` VALUES (4,3,17346693,3);
INSERT INTO `bcnm_battlefield` VALUES (4,3,17346694,3);
INSERT INTO `bcnm_battlefield` VALUES (5,1,17346585,3); -- shattering_stars WAR
INSERT INTO `bcnm_battlefield` VALUES (5,2,17346586,3);
INSERT INTO `bcnm_battlefield` VALUES (5,3,17346587,3);
INSERT INTO `bcnm_battlefield` VALUES (6,1,17346588,3); -- shattering_stars BLM
INSERT INTO `bcnm_battlefield` VALUES (6,2,17346589,3);
INSERT INTO `bcnm_battlefield` VALUES (6,3,17346590,3);
INSERT INTO `bcnm_battlefield` VALUES (7,1,17346591,3); -- shattering_stars RNG
INSERT INTO `bcnm_battlefield` VALUES (7,2,17346592,3);
INSERT INTO `bcnm_battlefield` VALUES (7,3,17346593,3);
INSERT INTO `bcnm_battlefield` VALUES (8,1,17346606,3); -- carapace_combatants
INSERT INTO `bcnm_battlefield` VALUES (8,1,17346607,3);
INSERT INTO `bcnm_battlefield` VALUES (8,2,17346609,3);
INSERT INTO `bcnm_battlefield` VALUES (8,2,17346610,3);
INSERT INTO `bcnm_battlefield` VALUES (8,3,17346612,3);
INSERT INTO `bcnm_battlefield` VALUES (8,3,17346613,3);
INSERT INTO `bcnm_battlefield` VALUES (9,1,17346594,3); -- shooting_fish
INSERT INTO `bcnm_battlefield` VALUES (9,1,17346595,3);
INSERT INTO `bcnm_battlefield` VALUES (9,1,17346596,3);
INSERT INTO `bcnm_battlefield` VALUES (9,2,17346598,3);
INSERT INTO `bcnm_battlefield` VALUES (9,2,17346599,3);
INSERT INTO `bcnm_battlefield` VALUES (9,2,17346600,3);
INSERT INTO `bcnm_battlefield` VALUES (9,3,17346602,3);
INSERT INTO `bcnm_battlefield` VALUES (9,3,17346603,3);
INSERT INTO `bcnm_battlefield` VALUES (9,3,17346604,3);
INSERT INTO `bcnm_battlefield` VALUES (10,1,17346615,3); -- dropping_like_flies
INSERT INTO `bcnm_battlefield` VALUES (10,1,17346616,3);
INSERT INTO `bcnm_battlefield` VALUES (10,1,17346617,3);
INSERT INTO `bcnm_battlefield` VALUES (10,1,17346618,3);
INSERT INTO `bcnm_battlefield` VALUES (10,1,17346619,3);
INSERT INTO `bcnm_battlefield` VALUES (10,1,17346620,3);
INSERT INTO `bcnm_battlefield` VALUES (10,1,17346621,3);
INSERT INTO `bcnm_battlefield` VALUES (10,1,17346622,3);
INSERT INTO `bcnm_battlefield` VALUES (10,1,17346623,3);
INSERT INTO `bcnm_battlefield` VALUES (10,2,17346625,3);
INSERT INTO `bcnm_battlefield` VALUES (10,2,17346626,3);
INSERT INTO `bcnm_battlefield` VALUES (10,2,17346627,3);
INSERT INTO `bcnm_battlefield` VALUES (10,2,17346628,3);
INSERT INTO `bcnm_battlefield` VALUES (10,2,17346629,3);
INSERT INTO `bcnm_battlefield` VALUES (10,2,17346630,3);
INSERT INTO `bcnm_battlefield` VALUES (10,2,17346631,3);
INSERT INTO `bcnm_battlefield` VALUES (10,2,17346632,3);
INSERT INTO `bcnm_battlefield` VALUES (10,2,17346633,3);
INSERT INTO `bcnm_battlefield` VALUES (10,3,17346635,3);
INSERT INTO `bcnm_battlefield` VALUES (10,3,17346636,3);
INSERT INTO `bcnm_battlefield` VALUES (10,3,17346637,3);
INSERT INTO `bcnm_battlefield` VALUES (10,3,17346638,3);
INSERT INTO `bcnm_battlefield` VALUES (10,3,17346639,3);
INSERT INTO `bcnm_battlefield` VALUES (10,3,17346640,3);
INSERT INTO `bcnm_battlefield` VALUES (10,3,17346641,3);
INSERT INTO `bcnm_battlefield` VALUES (10,3,17346642,3);
INSERT INTO `bcnm_battlefield` VALUES (10,3,17346643,3);
INSERT INTO `bcnm_battlefield` VALUES (11,1,17346717,3); -- horns_of_war
INSERT INTO `bcnm_battlefield` VALUES (11,2,17346719,3);
INSERT INTO `bcnm_battlefield` VALUES (11,3,17346721,3);
INSERT INTO `bcnm_battlefield` VALUES (12,1,17346672,3); -- under_observation
INSERT INTO `bcnm_battlefield` VALUES (12,1,17346673,3);
INSERT INTO `bcnm_battlefield` VALUES (12,1,17346674,3);
INSERT INTO `bcnm_battlefield` VALUES (12,2,17346676,3);
INSERT INTO `bcnm_battlefield` VALUES (12,2,17346677,3);
INSERT INTO `bcnm_battlefield` VALUES (12,2,17346678,3);
INSERT INTO `bcnm_battlefield` VALUES (12,3,17346680,3);
INSERT INTO `bcnm_battlefield` VALUES (12,3,17346681,3);
INSERT INTO `bcnm_battlefield` VALUES (12,3,17346682,3);
INSERT INTO `bcnm_battlefield` VALUES (13,1,17346723,3); -- eye_of_the_tiger
INSERT INTO `bcnm_battlefield` VALUES (13,2,17346725,3);
INSERT INTO `bcnm_battlefield` VALUES (13,3,17346727,3);
INSERT INTO `bcnm_battlefield` VALUES (14,1,17346729,3); -- shots_in_the_dark
INSERT INTO `bcnm_battlefield` VALUES (14,2,17346731,3);
INSERT INTO `bcnm_battlefield` VALUES (14,3,17346733,3);
INSERT INTO `bcnm_battlefield` VALUES (15,1,17346735,3); -- double_dragonian
INSERT INTO `bcnm_battlefield` VALUES (15,1,17346736,3);
INSERT INTO `bcnm_battlefield` VALUES (15,2,17346738,3);
INSERT INTO `bcnm_battlefield` VALUES (15,2,17346739,3);
INSERT INTO `bcnm_battlefield` VALUES (15,3,17346741,3);
INSERT INTO `bcnm_battlefield` VALUES (15,3,17346742,3);
INSERT INTO `bcnm_battlefield` VALUES (17,1,17346750,3); -- contaminated_colosseum
INSERT INTO `bcnm_battlefield` VALUES (17,2,17346752,3);
INSERT INTO `bcnm_battlefield` VALUES (17,3,17346754,3);
INSERT INTO `bcnm_battlefield` VALUES (20,1,17346789,3); -- beyond_infinity (Horlais Peek)
INSERT INTO `bcnm_battlefield` VALUES (20,2,17346790,3); -- beyond_infinity (Horlais Peek)
INSERT INTO `bcnm_battlefield` VALUES (20,3,17346791,3); -- beyond_infinity (Horlais Peek)
INSERT INTO `bcnm_battlefield` VALUES (32,1,17350662,3); -- save_the_children
INSERT INTO `bcnm_battlefield` VALUES (32,1,17350663,3);
INSERT INTO `bcnm_battlefield` VALUES (32,1,17350664,3);
INSERT INTO `bcnm_battlefield` VALUES (33,1,17350928,3); -- holy_crest
INSERT INTO `bcnm_battlefield` VALUES (34,1,17350929,3); -- wings_of_fury
INSERT INTO `bcnm_battlefield` VALUES (34,1,17350930,3);
INSERT INTO `bcnm_battlefield` VALUES (34,1,17350931,3);
INSERT INTO `bcnm_battlefield` VALUES (35,1,17350933,3); -- petrifying_pair
INSERT INTO `bcnm_battlefield` VALUES (35,1,17350934,3);
INSERT INTO `bcnm_battlefield` VALUES (36,1,17350936,3); -- toadal_recall
INSERT INTO `bcnm_battlefield` VALUES (36,1,17350937,3);
INSERT INTO `bcnm_battlefield` VALUES (36,1,17350938,3);
INSERT INTO `bcnm_battlefield` VALUES (36,1,17350939,3);
INSERT INTO `bcnm_battlefield` VALUES (64,1,17367041,3); -- rank_2_mission (Waughroon Shrine)
INSERT INTO `bcnm_battlefield` VALUES (64,1,17367042,3);
INSERT INTO `bcnm_battlefield` VALUES (64,2,17367043,3);
INSERT INTO `bcnm_battlefield` VALUES (64,2,17367044,3);
INSERT INTO `bcnm_battlefield` VALUES (64,3,17367045,3);
INSERT INTO `bcnm_battlefield` VALUES (64,3,17367046,3);
INSERT INTO `bcnm_battlefield` VALUES (65,1,17367122,3); -- worms_turn
INSERT INTO `bcnm_battlefield` VALUES (65,1,17367123,3);
INSERT INTO `bcnm_battlefield` VALUES (65,1,17367124,3);
INSERT INTO `bcnm_battlefield` VALUES (65,1,17367125,3);
INSERT INTO `bcnm_battlefield` VALUES (65,1,17367126,3);
INSERT INTO `bcnm_battlefield` VALUES (65,1,17367127,3);
INSERT INTO `bcnm_battlefield` VALUES (65,1,17367128,3);
INSERT INTO `bcnm_battlefield` VALUES (65,1,17367129,3);
INSERT INTO `bcnm_battlefield` VALUES (65,1,17367130,3);
INSERT INTO `bcnm_battlefield` VALUES (65,1,17367131,3);
INSERT INTO `bcnm_battlefield` VALUES (65,1,17367132,3);
INSERT INTO `bcnm_battlefield` VALUES (65,1,17367133,3);
INSERT INTO `bcnm_battlefield` VALUES (65,1,17367134,3);
INSERT INTO `bcnm_battlefield` VALUES (65,1,17367135,3);
INSERT INTO `bcnm_battlefield` VALUES (65,1,17367136,3);
INSERT INTO `bcnm_battlefield` VALUES (65,1,17367137,3);
INSERT INTO `bcnm_battlefield` VALUES (65,2,17367139,3);
INSERT INTO `bcnm_battlefield` VALUES (65,2,17367140,3);
INSERT INTO `bcnm_battlefield` VALUES (65,2,17367141,3);
INSERT INTO `bcnm_battlefield` VALUES (65,2,17367142,3);
INSERT INTO `bcnm_battlefield` VALUES (65,2,17367143,3);
INSERT INTO `bcnm_battlefield` VALUES (65,2,17367144,3);
INSERT INTO `bcnm_battlefield` VALUES (65,2,17367145,3);
INSERT INTO `bcnm_battlefield` VALUES (65,2,17367146,3);
INSERT INTO `bcnm_battlefield` VALUES (65,2,17367147,3);
INSERT INTO `bcnm_battlefield` VALUES (65,2,17367148,3);
INSERT INTO `bcnm_battlefield` VALUES (65,2,17367149,3);
INSERT INTO `bcnm_battlefield` VALUES (65,2,17367150,3);
INSERT INTO `bcnm_battlefield` VALUES (65,2,17367151,3);
INSERT INTO `bcnm_battlefield` VALUES (65,2,17367152,3);
INSERT INTO `bcnm_battlefield` VALUES (65,2,17367153,3);
INSERT INTO `bcnm_battlefield` VALUES (65,2,17367154,3);
INSERT INTO `bcnm_battlefield` VALUES (65,3,17367156,3);
INSERT INTO `bcnm_battlefield` VALUES (65,3,17367157,3);
INSERT INTO `bcnm_battlefield` VALUES (65,3,17367158,3);
INSERT INTO `bcnm_battlefield` VALUES (65,3,17367159,3);
INSERT INTO `bcnm_battlefield` VALUES (65,3,17367160,3);
INSERT INTO `bcnm_battlefield` VALUES (65,3,17367161,3);
INSERT INTO `bcnm_battlefield` VALUES (65,3,17367162,3);
INSERT INTO `bcnm_battlefield` VALUES (65,3,17367163,3);
INSERT INTO `bcnm_battlefield` VALUES (65,3,17367164,3);
INSERT INTO `bcnm_battlefield` VALUES (65,3,17367165,3);
INSERT INTO `bcnm_battlefield` VALUES (65,3,17367166,3);
INSERT INTO `bcnm_battlefield` VALUES (65,3,17367167,3);
INSERT INTO `bcnm_battlefield` VALUES (65,3,17367168,3);
INSERT INTO `bcnm_battlefield` VALUES (65,3,17367169,3);
INSERT INTO `bcnm_battlefield` VALUES (65,3,17367170,3);
INSERT INTO `bcnm_battlefield` VALUES (65,3,17367171,3);
INSERT INTO `bcnm_battlefield` VALUES (66,1,17367209,3); -- grimshell_shocktroopers
INSERT INTO `bcnm_battlefield` VALUES (66,1,17367210,3);
INSERT INTO `bcnm_battlefield` VALUES (66,1,17367211,3);
INSERT INTO `bcnm_battlefield` VALUES (66,1,17367212,3);
INSERT INTO `bcnm_battlefield` VALUES (66,1,17367213,3);
INSERT INTO `bcnm_battlefield` VALUES (66,1,17367214,3);
INSERT INTO `bcnm_battlefield` VALUES (66,2,17367216,3);
INSERT INTO `bcnm_battlefield` VALUES (66,2,17367217,3);
INSERT INTO `bcnm_battlefield` VALUES (66,2,17367218,3);
INSERT INTO `bcnm_battlefield` VALUES (66,2,17367219,3);
INSERT INTO `bcnm_battlefield` VALUES (66,2,17367220,3);
INSERT INTO `bcnm_battlefield` VALUES (66,2,17367221,3);
INSERT INTO `bcnm_battlefield` VALUES (66,3,17367223,3);
INSERT INTO `bcnm_battlefield` VALUES (66,3,17367224,3);
INSERT INTO `bcnm_battlefield` VALUES (66,3,17367225,3);
INSERT INTO `bcnm_battlefield` VALUES (66,3,17367226,3);
INSERT INTO `bcnm_battlefield` VALUES (66,3,17367227,3);
INSERT INTO `bcnm_battlefield` VALUES (66,3,17367228,3);
INSERT INTO `bcnm_battlefield` VALUES (67,1,17367047,3); -- on_my_way
INSERT INTO `bcnm_battlefield` VALUES (67,1,17367048,3);
INSERT INTO `bcnm_battlefield` VALUES (67,1,17367049,3);
INSERT INTO `bcnm_battlefield` VALUES (67,1,17367050,3);
INSERT INTO `bcnm_battlefield` VALUES (67,2,17367051,3);
INSERT INTO `bcnm_battlefield` VALUES (67,2,17367052,3);
INSERT INTO `bcnm_battlefield` VALUES (67,2,17367053,3);
INSERT INTO `bcnm_battlefield` VALUES (67,2,17367054,3);
INSERT INTO `bcnm_battlefield` VALUES (67,3,17367055,3);
INSERT INTO `bcnm_battlefield` VALUES (67,3,17367056,3);
INSERT INTO `bcnm_battlefield` VALUES (67,3,17367057,3);
INSERT INTO `bcnm_battlefield` VALUES (67,3,17367058,3);
INSERT INTO `bcnm_battlefield` VALUES (68,1,17367059,3); -- thief_in_norg
INSERT INTO `bcnm_battlefield` VALUES (68,1,17367060,3);
INSERT INTO `bcnm_battlefield` VALUES (68,1,17367061,3);
INSERT INTO `bcnm_battlefield` VALUES (68,1,17367062,0);
INSERT INTO `bcnm_battlefield` VALUES (68,2,17367064,3);
INSERT INTO `bcnm_battlefield` VALUES (68,2,17367065,3);
INSERT INTO `bcnm_battlefield` VALUES (68,2,17367066,3);
INSERT INTO `bcnm_battlefield` VALUES (68,2,17367067,0);
INSERT INTO `bcnm_battlefield` VALUES (68,3,17367069,3);
INSERT INTO `bcnm_battlefield` VALUES (68,3,17367070,3);
INSERT INTO `bcnm_battlefield` VALUES (68,3,17367071,3);
INSERT INTO `bcnm_battlefield` VALUES (68,3,17367072,0);
INSERT INTO `bcnm_battlefield` VALUES (69,1,17367203,3); -- 3_2_1
INSERT INTO `bcnm_battlefield` VALUES (69,2,17367205,3);
INSERT INTO `bcnm_battlefield` VALUES (69,3,17367207,3);
INSERT INTO `bcnm_battlefield` VALUES (70,1,17367074,3); -- shattering_stars RDM
INSERT INTO `bcnm_battlefield` VALUES (70,2,17367075,3);
INSERT INTO `bcnm_battlefield` VALUES (70,3,17367076,3);
INSERT INTO `bcnm_battlefield` VALUES (71,1,17367077,3); -- shattering_stars THF
INSERT INTO `bcnm_battlefield` VALUES (71,2,17367078,3);
INSERT INTO `bcnm_battlefield` VALUES (71,3,17367079,3);
INSERT INTO `bcnm_battlefield` VALUES (72,1,17367080,3); -- shattering_stars BST
INSERT INTO `bcnm_battlefield` VALUES (72,1,17367081,0);
INSERT INTO `bcnm_battlefield` VALUES (72,2,17367082,3);
INSERT INTO `bcnm_battlefield` VALUES (72,2,17367083,0);
INSERT INTO `bcnm_battlefield` VALUES (72,3,17367084,3);
INSERT INTO `bcnm_battlefield` VALUES (72,3,17367085,0);
INSERT INTO `bcnm_battlefield` VALUES (73,1,17367098,3); -- birds_of_a_feather
INSERT INTO `bcnm_battlefield` VALUES (73,1,17367099,3);
INSERT INTO `bcnm_battlefield` VALUES (73,1,17367100,3);
INSERT INTO `bcnm_battlefield` VALUES (73,2,17367102,3);
INSERT INTO `bcnm_battlefield` VALUES (73,2,17367103,3);
INSERT INTO `bcnm_battlefield` VALUES (73,2,17367104,3);
INSERT INTO `bcnm_battlefield` VALUES (73,3,17367106,3);
INSERT INTO `bcnm_battlefield` VALUES (73,3,17367107,3);
INSERT INTO `bcnm_battlefield` VALUES (73,3,17367108,3);
INSERT INTO `bcnm_battlefield` VALUES (74,1,17367086,3); -- crustacean_conundrum
INSERT INTO `bcnm_battlefield` VALUES (74,1,17367087,3);
INSERT INTO `bcnm_battlefield` VALUES (74,1,17367088,3);
INSERT INTO `bcnm_battlefield` VALUES (74,2,17367090,3);
INSERT INTO `bcnm_battlefield` VALUES (74,2,17367091,3);
INSERT INTO `bcnm_battlefield` VALUES (74,2,17367092,3);
INSERT INTO `bcnm_battlefield` VALUES (74,3,17367094,3);
INSERT INTO `bcnm_battlefield` VALUES (74,3,17367095,3);
INSERT INTO `bcnm_battlefield` VALUES (74,3,17367096,3);
INSERT INTO `bcnm_battlefield` VALUES (75,1,17367110,3); -- grove_guardians
INSERT INTO `bcnm_battlefield` VALUES (75,1,17367111,3);
INSERT INTO `bcnm_battlefield` VALUES (75,1,17367112,3);
INSERT INTO `bcnm_battlefield` VALUES (75,2,17367114,3);
INSERT INTO `bcnm_battlefield` VALUES (75,2,17367115,3);
INSERT INTO `bcnm_battlefield` VALUES (75,2,17367116,3);
INSERT INTO `bcnm_battlefield` VALUES (75,3,17367118,3);
INSERT INTO `bcnm_battlefield` VALUES (75,3,17367119,3);
INSERT INTO `bcnm_battlefield` VALUES (75,3,17367120,3);
INSERT INTO `bcnm_battlefield` VALUES (76,1,17367230,3); -- hills_are_alive
INSERT INTO `bcnm_battlefield` VALUES (76,2,17367232,3);
INSERT INTO `bcnm_battlefield` VALUES (76,3,17367234,3);
INSERT INTO `bcnm_battlefield` VALUES (77,1,17367173,3); -- royal_jelly
INSERT INTO `bcnm_battlefield` VALUES (77,1,17367174,3);
INSERT INTO `bcnm_battlefield` VALUES (77,1,17367175,3);
INSERT INTO `bcnm_battlefield` VALUES (77,1,17367176,3);
INSERT INTO `bcnm_battlefield` VALUES (77,1,17367177,3);
INSERT INTO `bcnm_battlefield` VALUES (77,1,17367178,3);
INSERT INTO `bcnm_battlefield` VALUES (77,1,17367179,3);
INSERT INTO `bcnm_battlefield` VALUES (77,1,17367180,3);
INSERT INTO `bcnm_battlefield` VALUES (77,1,17367181,3);
INSERT INTO `bcnm_battlefield` VALUES (77,2,17367183,3);
INSERT INTO `bcnm_battlefield` VALUES (77,2,17367184,3);
INSERT INTO `bcnm_battlefield` VALUES (77,2,17367185,3);
INSERT INTO `bcnm_battlefield` VALUES (77,2,17367186,3);
INSERT INTO `bcnm_battlefield` VALUES (77,2,17367187,3);
INSERT INTO `bcnm_battlefield` VALUES (77,2,17367188,3);
INSERT INTO `bcnm_battlefield` VALUES (77,2,17367189,3);
INSERT INTO `bcnm_battlefield` VALUES (77,2,17367190,3);
INSERT INTO `bcnm_battlefield` VALUES (77,2,17367191,3);
INSERT INTO `bcnm_battlefield` VALUES (77,3,17367193,3);
INSERT INTO `bcnm_battlefield` VALUES (77,3,17367194,3);
INSERT INTO `bcnm_battlefield` VALUES (77,3,17367195,3);
INSERT INTO `bcnm_battlefield` VALUES (77,3,17367196,3);
INSERT INTO `bcnm_battlefield` VALUES (77,3,17367197,3);
INSERT INTO `bcnm_battlefield` VALUES (77,3,17367198,3);
INSERT INTO `bcnm_battlefield` VALUES (77,3,17367199,3);
INSERT INTO `bcnm_battlefield` VALUES (77,3,17367200,3);
INSERT INTO `bcnm_battlefield` VALUES (77,3,17367201,3);
INSERT INTO `bcnm_battlefield` VALUES (78,1,17367236,3); -- final_bout
INSERT INTO `bcnm_battlefield` VALUES (78,2,17367238,3);
INSERT INTO `bcnm_battlefield` VALUES (78,3,17367240,3);
INSERT INTO `bcnm_battlefield` VALUES (79,1,17367242,3); -- up_in_arms
INSERT INTO `bcnm_battlefield` VALUES (79,2,17367244,3);
INSERT INTO `bcnm_battlefield` VALUES (79,3,17367246,3);
INSERT INTO `bcnm_battlefield` VALUES (81,1,17367266,3); -- operation_desert_swarm
INSERT INTO `bcnm_battlefield` VALUES (81,1,17367267,3);
INSERT INTO `bcnm_battlefield` VALUES (81,1,17367268,3);
INSERT INTO `bcnm_battlefield` VALUES (81,1,17367269,3);
INSERT INTO `bcnm_battlefield` VALUES (81,1,17367270,3);
INSERT INTO `bcnm_battlefield` VALUES (81,1,17367271,3);
INSERT INTO `bcnm_battlefield` VALUES (81,2,17367273,3);
INSERT INTO `bcnm_battlefield` VALUES (81,2,17367274,3);
INSERT INTO `bcnm_battlefield` VALUES (81,2,17367275,3);
INSERT INTO `bcnm_battlefield` VALUES (81,2,17367276,3);
INSERT INTO `bcnm_battlefield` VALUES (81,2,17367277,3);
INSERT INTO `bcnm_battlefield` VALUES (81,2,17367278,3);
INSERT INTO `bcnm_battlefield` VALUES (81,3,17367280,3);
INSERT INTO `bcnm_battlefield` VALUES (81,3,17367281,3);
INSERT INTO `bcnm_battlefield` VALUES (81,3,17367282,3);
INSERT INTO `bcnm_battlefield` VALUES (81,3,17367283,3);
INSERT INTO `bcnm_battlefield` VALUES (81,3,17367284,3);
INSERT INTO `bcnm_battlefield` VALUES (81,3,17367285,3);
INSERT INTO `bcnm_battlefield` VALUES (82,1,17367287,3); -- prehistoric_pigeons
INSERT INTO `bcnm_battlefield` VALUES (82,1,17367288,3);
INSERT INTO `bcnm_battlefield` VALUES (82,1,17367289,3);
INSERT INTO `bcnm_battlefield` VALUES (82,1,17367290,3);
INSERT INTO `bcnm_battlefield` VALUES (82,2,17367292,3);
INSERT INTO `bcnm_battlefield` VALUES (82,2,17367293,3);
INSERT INTO `bcnm_battlefield` VALUES (82,2,17367294,3);
INSERT INTO `bcnm_battlefield` VALUES (82,2,17367295,3);
INSERT INTO `bcnm_battlefield` VALUES (82,3,17367297,3);
INSERT INTO `bcnm_battlefield` VALUES (82,3,17367298,3);
INSERT INTO `bcnm_battlefield` VALUES (82,3,17367299,3);
INSERT INTO `bcnm_battlefield` VALUES (82,3,17367300,3);
INSERT INTO `bcnm_battlefield` VALUES (85,1,17367332,3); -- beyond_infinity (Waughroon Shrine)
INSERT INTO `bcnm_battlefield` VALUES (85,2,17367333,3); -- beyond_infinity (Waughroon Shrine)
INSERT INTO `bcnm_battlefield` VALUES (85,3,17367334,3); -- beyond_infinity (Waughroon Shrine)
INSERT INTO `bcnm_battlefield` VALUES (96,1,17375233,3); -- rank_2_mission (Balga's Dias)
INSERT INTO `bcnm_battlefield` VALUES (96,1,17375234,3);
INSERT INTO `bcnm_battlefield` VALUES (96,2,17375235,3);
INSERT INTO `bcnm_battlefield` VALUES (96,2,17375236,3);
INSERT INTO `bcnm_battlefield` VALUES (96,3,17375237,3);
INSERT INTO `bcnm_battlefield` VALUES (96,3,17375238,3);
INSERT INTO `bcnm_battlefield` VALUES (97,1,17375308,3); -- steamed_sprouts
INSERT INTO `bcnm_battlefield` VALUES (97,1,17375309,3);
INSERT INTO `bcnm_battlefield` VALUES (97,1,17375310,3);
INSERT INTO `bcnm_battlefield` VALUES (97,1,17375311,3);
INSERT INTO `bcnm_battlefield` VALUES (97,1,17375312,3);
INSERT INTO `bcnm_battlefield` VALUES (97,1,17375313,3);
INSERT INTO `bcnm_battlefield` VALUES (97,1,17375314,3);
INSERT INTO `bcnm_battlefield` VALUES (97,1,17375315,3);
INSERT INTO `bcnm_battlefield` VALUES (97,2,17375317,3);
INSERT INTO `bcnm_battlefield` VALUES (97,2,17375318,3);
INSERT INTO `bcnm_battlefield` VALUES (97,2,17375319,3);
INSERT INTO `bcnm_battlefield` VALUES (97,2,17375320,3);
INSERT INTO `bcnm_battlefield` VALUES (97,2,17375321,3);
INSERT INTO `bcnm_battlefield` VALUES (97,2,17375322,3);
INSERT INTO `bcnm_battlefield` VALUES (97,2,17375323,3);
INSERT INTO `bcnm_battlefield` VALUES (97,2,17375324,3);
INSERT INTO `bcnm_battlefield` VALUES (97,3,17375326,3);
INSERT INTO `bcnm_battlefield` VALUES (97,3,17375327,3);
INSERT INTO `bcnm_battlefield` VALUES (97,3,17375328,3);
INSERT INTO `bcnm_battlefield` VALUES (97,3,17375329,3);
INSERT INTO `bcnm_battlefield` VALUES (97,3,17375330,3);
INSERT INTO `bcnm_battlefield` VALUES (97,3,17375331,3);
INSERT INTO `bcnm_battlefield` VALUES (97,3,17375332,3);
INSERT INTO `bcnm_battlefield` VALUES (97,3,17375333,3);
INSERT INTO `bcnm_battlefield` VALUES (98,1,17375365,3); -- divine_punishers
INSERT INTO `bcnm_battlefield` VALUES (98,1,17375366,3);
INSERT INTO `bcnm_battlefield` VALUES (98,1,17375367,3);
INSERT INTO `bcnm_battlefield` VALUES (98,1,17375368,3);
INSERT INTO `bcnm_battlefield` VALUES (98,1,17375369,3);
INSERT INTO `bcnm_battlefield` VALUES (98,1,17375370,3);
INSERT INTO `bcnm_battlefield` VALUES (98,2,17375372,3);
INSERT INTO `bcnm_battlefield` VALUES (98,2,17375373,3);
INSERT INTO `bcnm_battlefield` VALUES (98,2,17375374,3);
INSERT INTO `bcnm_battlefield` VALUES (98,2,17375375,3);
INSERT INTO `bcnm_battlefield` VALUES (98,2,17375376,3);
INSERT INTO `bcnm_battlefield` VALUES (98,2,17375377,3);
INSERT INTO `bcnm_battlefield` VALUES (98,3,17375379,3);
INSERT INTO `bcnm_battlefield` VALUES (98,3,17375380,3);
INSERT INTO `bcnm_battlefield` VALUES (98,3,17375381,3);
INSERT INTO `bcnm_battlefield` VALUES (98,3,17375382,3);
INSERT INTO `bcnm_battlefield` VALUES (98,3,17375383,3);
INSERT INTO `bcnm_battlefield` VALUES (98,3,17375384,3);
INSERT INTO `bcnm_battlefield` VALUES (99,1,17375239,3); -- saintly_invitation
INSERT INTO `bcnm_battlefield` VALUES (99,1,17375240,3);
INSERT INTO `bcnm_battlefield` VALUES (99,1,17375241,3);
INSERT INTO `bcnm_battlefield` VALUES (99,1,17375242,3);
INSERT INTO `bcnm_battlefield` VALUES (99,1,17375243,0);
INSERT INTO `bcnm_battlefield` VALUES (99,2,17375245,3);
INSERT INTO `bcnm_battlefield` VALUES (99,2,17375246,3);
INSERT INTO `bcnm_battlefield` VALUES (99,2,17375247,3);
INSERT INTO `bcnm_battlefield` VALUES (99,2,17375248,3);
INSERT INTO `bcnm_battlefield` VALUES (99,2,17375249,3);
INSERT INTO `bcnm_battlefield` VALUES (99,3,17375251,3);
INSERT INTO `bcnm_battlefield` VALUES (99,3,17375252,3);
INSERT INTO `bcnm_battlefield` VALUES (99,3,17375253,3);
INSERT INTO `bcnm_battlefield` VALUES (99,3,17375254,3);
INSERT INTO `bcnm_battlefield` VALUES (99,3,17375255,3);
INSERT INTO `bcnm_battlefield` VALUES (100,1,17375353,3); -- treasures_and_tribulations
INSERT INTO `bcnm_battlefield` VALUES (100,1,17375354,3);
INSERT INTO `bcnm_battlefield` VALUES (100,1,17375355,3);
INSERT INTO `bcnm_battlefield` VALUES (100,2,17375357,3);
INSERT INTO `bcnm_battlefield` VALUES (100,2,17375358,3);
INSERT INTO `bcnm_battlefield` VALUES (100,2,17375359,3);
INSERT INTO `bcnm_battlefield` VALUES (100,3,17375361,3);
INSERT INTO `bcnm_battlefield` VALUES (100,3,17375362,3);
INSERT INTO `bcnm_battlefield` VALUES (100,3,17375363,3);
INSERT INTO `bcnm_battlefield` VALUES (101,1,17375257,3); -- shattering_stars MNK
INSERT INTO `bcnm_battlefield` VALUES (101,2,17375258,3);
INSERT INTO `bcnm_battlefield` VALUES (101,3,17375259,3);
INSERT INTO `bcnm_battlefield` VALUES (102,1,17375260,3);
INSERT INTO `bcnm_battlefield` VALUES (102,2,17375261,3); -- shattering_stars WHM
INSERT INTO `bcnm_battlefield` VALUES (102,3,17375262,3);
INSERT INTO `bcnm_battlefield` VALUES (103,1,17375263,3);
INSERT INTO `bcnm_battlefield` VALUES (103,1,17375264,0);
INSERT INTO `bcnm_battlefield` VALUES (103,2,17375265,3); -- shattering_stars SMN
INSERT INTO `bcnm_battlefield` VALUES (103,2,17375266,0);
INSERT INTO `bcnm_battlefield` VALUES (103,3,17375267,3);
INSERT INTO `bcnm_battlefield` VALUES (103,3,17375268,0);
INSERT INTO `bcnm_battlefield` VALUES (104,1,17375281,3); -- creeping_doom
INSERT INTO `bcnm_battlefield` VALUES (104,2,17375283,3);
INSERT INTO `bcnm_battlefield` VALUES (104,3,17375285,3);
INSERT INTO `bcnm_battlefield` VALUES (105,1,17375270,3); -- charming_trio
INSERT INTO `bcnm_battlefield` VALUES (105,2,17375274,3);
INSERT INTO `bcnm_battlefield` VALUES (105,3,17375278,3);
INSERT INTO `bcnm_battlefield` VALUES (105,1,17375271,3);
INSERT INTO `bcnm_battlefield` VALUES (105,2,17375275,3);
INSERT INTO `bcnm_battlefield` VALUES (105,3,17375279,3);
INSERT INTO `bcnm_battlefield` VALUES (105,1,17375269,3);
INSERT INTO `bcnm_battlefield` VALUES (105,2,17375273,3);
INSERT INTO `bcnm_battlefield` VALUES (105,3,17375277,3);
INSERT INTO `bcnm_battlefield` VALUES (106,1,17375287,3); -- harem_scarem
INSERT INTO `bcnm_battlefield` VALUES (106,1,17375288,3);
INSERT INTO `bcnm_battlefield` VALUES (106,1,17375289,3);
INSERT INTO `bcnm_battlefield` VALUES (106,1,17375290,3);
INSERT INTO `bcnm_battlefield` VALUES (106,1,17375291,3);
INSERT INTO `bcnm_battlefield` VALUES (106,1,17375292,3);
INSERT INTO `bcnm_battlefield` VALUES (106,2,17375294,3);
INSERT INTO `bcnm_battlefield` VALUES (106,2,17375295,3);
INSERT INTO `bcnm_battlefield` VALUES (106,2,17375296,3);
INSERT INTO `bcnm_battlefield` VALUES (106,2,17375297,3);
INSERT INTO `bcnm_battlefield` VALUES (106,2,17375298,3);
INSERT INTO `bcnm_battlefield` VALUES (106,2,17375299,3);
INSERT INTO `bcnm_battlefield` VALUES (106,3,17375301,3);
INSERT INTO `bcnm_battlefield` VALUES (106,3,17375302,3);
INSERT INTO `bcnm_battlefield` VALUES (106,3,17375303,3);
INSERT INTO `bcnm_battlefield` VALUES (106,3,17375304,3);
INSERT INTO `bcnm_battlefield` VALUES (106,3,17375305,3);
INSERT INTO `bcnm_battlefield` VALUES (106,3,17375306,3);
INSERT INTO `bcnm_battlefield` VALUES (107,1,17375386,3); -- early_bird_catches_the_wyrm
INSERT INTO `bcnm_battlefield` VALUES (107,2,17375388,3);
INSERT INTO `bcnm_battlefield` VALUES (107,3,17375390,3);
INSERT INTO `bcnm_battlefield` VALUES (108,1,17375335,3); -- royal_succession
INSERT INTO `bcnm_battlefield` VALUES (108,1,17375336,3);
INSERT INTO `bcnm_battlefield` VALUES (108,1,17375337,3);
INSERT INTO `bcnm_battlefield` VALUES (108,1,17375338,3);
INSERT INTO `bcnm_battlefield` VALUES (108,1,17375339,3);
INSERT INTO `bcnm_battlefield` VALUES (108,2,17375341,3);
INSERT INTO `bcnm_battlefield` VALUES (108,2,17375342,3);
INSERT INTO `bcnm_battlefield` VALUES (108,2,17375343,3);
INSERT INTO `bcnm_battlefield` VALUES (108,2,17375344,3);
INSERT INTO `bcnm_battlefield` VALUES (108,2,17375345,3);
INSERT INTO `bcnm_battlefield` VALUES (108,3,17375347,3);
INSERT INTO `bcnm_battlefield` VALUES (108,3,17375348,3);
INSERT INTO `bcnm_battlefield` VALUES (108,3,17375349,3);
INSERT INTO `bcnm_battlefield` VALUES (108,3,17375350,3);
INSERT INTO `bcnm_battlefield` VALUES (108,3,17375351,3);
INSERT INTO `bcnm_battlefield` VALUES (109,1,17375392,3); -- rapid_raptors
INSERT INTO `bcnm_battlefield` VALUES (109,1,17375393,3);
INSERT INTO `bcnm_battlefield` VALUES (109,2,17375395,3);
INSERT INTO `bcnm_battlefield` VALUES (109,2,17375396,3);
INSERT INTO `bcnm_battlefield` VALUES (109,3,17375398,3);
INSERT INTO `bcnm_battlefield` VALUES (109,3,17375399,3);
INSERT INTO `bcnm_battlefield` VALUES (110,1,17375401,3); -- wild_wild_whiskers
INSERT INTO `bcnm_battlefield` VALUES (110,2,17375403,3);
INSERT INTO `bcnm_battlefield` VALUES (110,3,17375405,3);
INSERT INTO `bcnm_battlefield` VALUES (116,1,17375491,3); -- beyond_infinity (Balgas Dais)
INSERT INTO `bcnm_battlefield` VALUES (116,2,17375492,3); -- beyond_infinity (Balgas Dais)
INSERT INTO `bcnm_battlefield` VALUES (116,3,17375493,3); -- beyond_infinity (Balgas Dais)
INSERT INTO `bcnm_battlefield` VALUES (128,1,17444865,3); -- temple_of_uggalepih
INSERT INTO `bcnm_battlefield` VALUES (128,1,17444866,3);
INSERT INTO `bcnm_battlefield` VALUES (128,1,17444867,3);
INSERT INTO `bcnm_battlefield` VALUES (128,1,17444868,0);
INSERT INTO `bcnm_battlefield` VALUES (128,1,17444869,0);
INSERT INTO `bcnm_battlefield` VALUES (128,2,17444870,3);
INSERT INTO `bcnm_battlefield` VALUES (128,2,17444871,3);
INSERT INTO `bcnm_battlefield` VALUES (128,2,17444872,3);
INSERT INTO `bcnm_battlefield` VALUES (128,2,17444873,0);
INSERT INTO `bcnm_battlefield` VALUES (128,2,17444874,0);
INSERT INTO `bcnm_battlefield` VALUES (128,3,17444875,3);
INSERT INTO `bcnm_battlefield` VALUES (128,3,17444876,3);
INSERT INTO `bcnm_battlefield` VALUES (128,3,17444877,3);
INSERT INTO `bcnm_battlefield` VALUES (128,3,17444878,0);
INSERT INTO `bcnm_battlefield` VALUES (128,3,17444879,0);
INSERT INTO `bcnm_battlefield` VALUES (129,1,17444880,3); -- jungle_boogymen
INSERT INTO `bcnm_battlefield` VALUES (129,1,17444881,3);
INSERT INTO `bcnm_battlefield` VALUES (129,1,17444882,3);
INSERT INTO `bcnm_battlefield` VALUES (129,1,17444883,3);
INSERT INTO `bcnm_battlefield` VALUES (129,1,17444885,1);
INSERT INTO `bcnm_battlefield` VALUES (129,1,17444886,0);
INSERT INTO `bcnm_battlefield` VALUES (129,2,17444887,3);
INSERT INTO `bcnm_battlefield` VALUES (129,2,17444888,3);
INSERT INTO `bcnm_battlefield` VALUES (129,2,17444889,3);
INSERT INTO `bcnm_battlefield` VALUES (129,2,17444890,3);
INSERT INTO `bcnm_battlefield` VALUES (129,2,17444892,1);
INSERT INTO `bcnm_battlefield` VALUES (129,2,17444893,0);
INSERT INTO `bcnm_battlefield` VALUES (129,3,17444894,3);
INSERT INTO `bcnm_battlefield` VALUES (129,3,17444895,3);
INSERT INTO `bcnm_battlefield` VALUES (129,3,17444896,3);
INSERT INTO `bcnm_battlefield` VALUES (129,3,17444897,3);
INSERT INTO `bcnm_battlefield` VALUES (129,3,17444899,1);
INSERT INTO `bcnm_battlefield` VALUES (129,3,17444900,0);
INSERT INTO `bcnm_battlefield` VALUES (130,1,17444901,3); -- amphibian_assault
INSERT INTO `bcnm_battlefield` VALUES (130,1,17444902,3);
INSERT INTO `bcnm_battlefield` VALUES (130,1,17444903,3);
INSERT INTO `bcnm_battlefield` VALUES (130,1,17444904,3);
INSERT INTO `bcnm_battlefield` VALUES (130,1,17444906,1);
INSERT INTO `bcnm_battlefield` VALUES (130,2,17444907,3);
INSERT INTO `bcnm_battlefield` VALUES (130,2,17444908,3);
INSERT INTO `bcnm_battlefield` VALUES (130,2,17444909,3);
INSERT INTO `bcnm_battlefield` VALUES (130,2,17444910,3);
INSERT INTO `bcnm_battlefield` VALUES (130,2,17444912,1);
INSERT INTO `bcnm_battlefield` VALUES (130,3,17444913,3);
INSERT INTO `bcnm_battlefield` VALUES (130,3,17444914,3);
INSERT INTO `bcnm_battlefield` VALUES (130,3,17444915,3);
INSERT INTO `bcnm_battlefield` VALUES (130,3,17444916,3);
INSERT INTO `bcnm_battlefield` VALUES (130,3,17444918,1);
INSERT INTO `bcnm_battlefield` VALUES (160,1,17453057,3); -- shadow_lord_battle
INSERT INTO `bcnm_battlefield` VALUES (160,1,17453060,2);
INSERT INTO `bcnm_battlefield` VALUES (160,2,17453058,3);
INSERT INTO `bcnm_battlefield` VALUES (160,2,17453061,2);
INSERT INTO `bcnm_battlefield` VALUES (160,3,17453059,3);
INSERT INTO `bcnm_battlefield` VALUES (160,3,17453062,2);
INSERT INTO `bcnm_battlefield` VALUES (161,1,17453063,3); -- where_two_paths_converge
INSERT INTO `bcnm_battlefield` VALUES (161,1,17453064,2);
INSERT INTO `bcnm_battlefield` VALUES (161,1,17453065,0); -- removing the requirement to kill shadow of rage from bastok mission 9-2
INSERT INTO `bcnm_battlefield` VALUES (161,1,17453066,0); -- zeid can be killed before they are unhidden, preventing them from spawning and make fight unwinable
INSERT INTO `bcnm_battlefield` VALUES (161,2,17453067,3);
INSERT INTO `bcnm_battlefield` VALUES (161,2,17453068,2);
INSERT INTO `bcnm_battlefield` VALUES (161,2,17453069,0);
INSERT INTO `bcnm_battlefield` VALUES (161,2,17453070,0);
INSERT INTO `bcnm_battlefield` VALUES (161,3,17453071,3);
INSERT INTO `bcnm_battlefield` VALUES (161,3,17453072,2);
INSERT INTO `bcnm_battlefield` VALUES (161,3,17453073,0);
INSERT INTO `bcnm_battlefield` VALUES (161,3,17453074,0);
INSERT INTO `bcnm_battlefield` VALUES (192,1,17465345,3); -- through_the_quicksand_caves
INSERT INTO `bcnm_battlefield` VALUES (192,1,17465346,3);
INSERT INTO `bcnm_battlefield` VALUES (192,1,17465347,3);
INSERT INTO `bcnm_battlefield` VALUES (192,2,17465348,3);
INSERT INTO `bcnm_battlefield` VALUES (192,2,17465349,3);
INSERT INTO `bcnm_battlefield` VALUES (192,2,17465350,3);
INSERT INTO `bcnm_battlefield` VALUES (192,3,17465351,3);
INSERT INTO `bcnm_battlefield` VALUES (192,3,17465352,3);
INSERT INTO `bcnm_battlefield` VALUES (192,3,17465353,3);
INSERT INTO `bcnm_battlefield` VALUES (193,1,17465366,3); -- legion_xi_comitatensis
INSERT INTO `bcnm_battlefield` VALUES (193,1,17465367,3);
INSERT INTO `bcnm_battlefield` VALUES (193,1,17465368,3);
INSERT INTO `bcnm_battlefield` VALUES (193,1,17465369,3);
INSERT INTO `bcnm_battlefield` VALUES (193,2,17465371,3);
INSERT INTO `bcnm_battlefield` VALUES (193,2,17465372,3);
INSERT INTO `bcnm_battlefield` VALUES (193,2,17465373,3);
INSERT INTO `bcnm_battlefield` VALUES (193,2,17465374,3);
INSERT INTO `bcnm_battlefield` VALUES (193,3,17465376,3);
INSERT INTO `bcnm_battlefield` VALUES (193,3,17465377,3);
INSERT INTO `bcnm_battlefield` VALUES (193,3,17465378,3);
INSERT INTO `bcnm_battlefield` VALUES (193,3,17465379,3);
INSERT INTO `bcnm_battlefield` VALUES (194,1,17465354,3); -- shattering_stars SAM
INSERT INTO `bcnm_battlefield` VALUES (194,2,17465355,3);
INSERT INTO `bcnm_battlefield` VALUES (194,3,17465356,3);
INSERT INTO `bcnm_battlefield` VALUES (195,1,17465357,3); -- shattering_stars NIN
INSERT INTO `bcnm_battlefield` VALUES (195,2,17465358,3);
INSERT INTO `bcnm_battlefield` VALUES (195,3,17465359,3);
INSERT INTO `bcnm_battlefield` VALUES (196,1,17465360,3); -- shattering_stars DRG
INSERT INTO `bcnm_battlefield` VALUES (196,1,17465361,0);
INSERT INTO `bcnm_battlefield` VALUES (196,2,17465362,3);
INSERT INTO `bcnm_battlefield` VALUES (196,2,17465363,0);
INSERT INTO `bcnm_battlefield` VALUES (196,3,17465364,3);
INSERT INTO `bcnm_battlefield` VALUES (196,3,17465365,0);
INSERT INTO `bcnm_battlefield` VALUES (198,1,17465393,3); -- eye of the storm
INSERT INTO `bcnm_battlefield` VALUES (198,1,17465394,3);
INSERT INTO `bcnm_battlefield` VALUES (198,1,17465395,3);
INSERT INTO `bcnm_battlefield` VALUES (198,1,17465396,3);
INSERT INTO `bcnm_battlefield` VALUES (198,2,17465399,3);
INSERT INTO `bcnm_battlefield` VALUES (198,2,17465398,3);
INSERT INTO `bcnm_battlefield` VALUES (198,2,17465400,3);
INSERT INTO `bcnm_battlefield` VALUES (198,2,17465401,3);
INSERT INTO `bcnm_battlefield` VALUES (198,3,17465403,3);
INSERT INTO `bcnm_battlefield` VALUES (198,3,17465404,3);
INSERT INTO `bcnm_battlefield` VALUES (198,3,17465405,3);
INSERT INTO `bcnm_battlefield` VALUES (198,3,17465406,3);
INSERT INTO `bcnm_battlefield` VALUES (224,1,17473537,3); -- moonlit_path
INSERT INTO `bcnm_battlefield` VALUES (224,2,17473538,3);
INSERT INTO `bcnm_battlefield` VALUES (224,3,17473539,3);
INSERT INTO `bcnm_battlefield` VALUES (225,1,17473540,3); -- moon_reading
INSERT INTO `bcnm_battlefield` VALUES (225,1,17473541,3);
INSERT INTO `bcnm_battlefield` VALUES (225,1,17473542,3);
INSERT INTO `bcnm_battlefield` VALUES (225,1,17473543,3);
INSERT INTO `bcnm_battlefield` VALUES (225,1,17473544,2);
INSERT INTO `bcnm_battlefield` VALUES (225,1,17473545,2);
INSERT INTO `bcnm_battlefield` VALUES (225,2,17473546,3);
INSERT INTO `bcnm_battlefield` VALUES (225,2,17473547,3);
INSERT INTO `bcnm_battlefield` VALUES (225,2,17473548,3);
INSERT INTO `bcnm_battlefield` VALUES (225,2,17473549,3);
INSERT INTO `bcnm_battlefield` VALUES (225,2,17473550,2);
INSERT INTO `bcnm_battlefield` VALUES (225,2,17473551,2);
INSERT INTO `bcnm_battlefield` VALUES (225,3,17473552,3);
INSERT INTO `bcnm_battlefield` VALUES (225,3,17473553,3);
INSERT INTO `bcnm_battlefield` VALUES (225,3,17473554,3);
INSERT INTO `bcnm_battlefield` VALUES (225,3,17473555,3);
INSERT INTO `bcnm_battlefield` VALUES (225,3,17473556,2);
INSERT INTO `bcnm_battlefield` VALUES (225,3,17473557,2);
INSERT INTO `bcnm_battlefield` VALUES (256,1,17510401,3); -- return_to_delkfutts_tower
INSERT INTO `bcnm_battlefield` VALUES (256,2,17510402,3);
INSERT INTO `bcnm_battlefield` VALUES (256,3,17510403,3);
INSERT INTO `bcnm_battlefield` VALUES (288,1,17514497,3); -- ark_angels_1
INSERT INTO `bcnm_battlefield` VALUES (288,2,17514498,3);
INSERT INTO `bcnm_battlefield` VALUES (288,3,17514499,3);
INSERT INTO `bcnm_battlefield` VALUES (289,1,17514512,3); -- ark_angels_2
INSERT INTO `bcnm_battlefield` VALUES (289,2,17514513,3);
INSERT INTO `bcnm_battlefield` VALUES (289,3,17514514,3);
INSERT INTO `bcnm_battlefield` VALUES (290,1,17514500,3); -- ark_angels_3
INSERT INTO `bcnm_battlefield` VALUES (290,2,17514501,3);
INSERT INTO `bcnm_battlefield` VALUES (290,3,17514502,3);
INSERT INTO `bcnm_battlefield` VALUES (290,1,17514503,0);
INSERT INTO `bcnm_battlefield` VALUES (290,2,17514504,0);
INSERT INTO `bcnm_battlefield` VALUES (290,3,17514505,0);
INSERT INTO `bcnm_battlefield` VALUES (290,1,17514506,0);
INSERT INTO `bcnm_battlefield` VALUES (290,2,17514507,0);
INSERT INTO `bcnm_battlefield` VALUES (290,3,17514508,0);
INSERT INTO `bcnm_battlefield` VALUES (291,1,17514509,3); -- ark_angels_4
INSERT INTO `bcnm_battlefield` VALUES (291,2,17514510,3);
INSERT INTO `bcnm_battlefield` VALUES (291,3,17514511,3);
INSERT INTO `bcnm_battlefield` VALUES (292,1,17514515,3); -- ark_angels_5
INSERT INTO `bcnm_battlefield` VALUES (292,2,17514516,3);
INSERT INTO `bcnm_battlefield` VALUES (292,3,17514517,3);
INSERT INTO `bcnm_battlefield` VALUES (292,1,17514518,0);
INSERT INTO `bcnm_battlefield` VALUES (292,2,17514519,0);
INSERT INTO `bcnm_battlefield` VALUES (292,3,17514520,0);
INSERT INTO `bcnm_battlefield` VALUES (293,1,17514521,3); -- divine_might
INSERT INTO `bcnm_battlefield` VALUES (293,1,17514522,3);
INSERT INTO `bcnm_battlefield` VALUES (293,1,17514523,0);
INSERT INTO `bcnm_battlefield` VALUES (293,1,17514524,0);
INSERT INTO `bcnm_battlefield` VALUES (293,1,17514525,3);
INSERT INTO `bcnm_battlefield` VALUES (293,1,17514526,3);
INSERT INTO `bcnm_battlefield` VALUES (293,1,17514527,3);
INSERT INTO `bcnm_battlefield` VALUES (293,1,17514528,0);
INSERT INTO `bcnm_battlefield` VALUES (293,2,17514529,3);
INSERT INTO `bcnm_battlefield` VALUES (293,2,17514530,3);
INSERT INTO `bcnm_battlefield` VALUES (293,2,17514531,0);
INSERT INTO `bcnm_battlefield` VALUES (293,2,17514532,0);
INSERT INTO `bcnm_battlefield` VALUES (293,2,17514533,3);
INSERT INTO `bcnm_battlefield` VALUES (293,2,17514534,3);
INSERT INTO `bcnm_battlefield` VALUES (293,2,17514535,3);
INSERT INTO `bcnm_battlefield` VALUES (293,2,17514536,0);
INSERT INTO `bcnm_battlefield` VALUES (293,3,17514537,3);
INSERT INTO `bcnm_battlefield` VALUES (293,3,17514538,3);
INSERT INTO `bcnm_battlefield` VALUES (293,3,17514539,3);
INSERT INTO `bcnm_battlefield` VALUES (293,3,17514540,0);
INSERT INTO `bcnm_battlefield` VALUES (293,3,17514541,3);
INSERT INTO `bcnm_battlefield` VALUES (293,3,17514542,3);
INSERT INTO `bcnm_battlefield` VALUES (293,3,17514543,3);
INSERT INTO `bcnm_battlefield` VALUES (293,3,17514544,3);
INSERT INTO `bcnm_battlefield` VALUES (320,1,17518595,3); -- celestial_nexus
INSERT INTO `bcnm_battlefield` VALUES (320,1,17518596,3);
INSERT INTO `bcnm_battlefield` VALUES (320,1,17518597,2);
INSERT INTO `bcnm_battlefield` VALUES (320,2,17518600,3);
INSERT INTO `bcnm_battlefield` VALUES (320,2,17518601,3);
INSERT INTO `bcnm_battlefield` VALUES (320,2,17518602,2);
INSERT INTO `bcnm_battlefield` VALUES (320,3,17518605,3);
INSERT INTO `bcnm_battlefield` VALUES (320,3,17518606,3);
INSERT INTO `bcnm_battlefield` VALUES (320,3,17518607,2);
INSERT INTO `bcnm_battlefield` VALUES (416,1,17600513,3); -- trial_by_wind
INSERT INTO `bcnm_battlefield` VALUES (416,2,17600514,3);
INSERT INTO `bcnm_battlefield` VALUES (416,3,17600515,3);
INSERT INTO `bcnm_battlefield` VALUES (417,1,17600516,3); -- carbuncle_debacle
INSERT INTO `bcnm_battlefield` VALUES (417,2,17600517,3);
INSERT INTO `bcnm_battlefield` VALUES (417,3,17600518,3);
INSERT INTO `bcnm_battlefield` VALUES (418,1,17600519,3); -- trial-size_trial_by_wind
INSERT INTO `bcnm_battlefield` VALUES (418,2,17600520,3);
INSERT INTO `bcnm_battlefield` VALUES (418,3,17600521,3);
INSERT INTO `bcnm_battlefield` VALUES (420,1,17600537,3); -- sugar-coated_directive
INSERT INTO `bcnm_battlefield` VALUES (420,2,17600538,3);
INSERT INTO `bcnm_battlefield` VALUES (420,3,17600539,3);
INSERT INTO `bcnm_battlefield` VALUES (448,1,17604609,3); -- trial_by_lightning
INSERT INTO `bcnm_battlefield` VALUES (448,2,17604610,3);
INSERT INTO `bcnm_battlefield` VALUES (448,3,17604611,3);
INSERT INTO `bcnm_battlefield` VALUES (449,1,17604612,3); -- sugar-coated_directive
INSERT INTO `bcnm_battlefield` VALUES (449,1,17604613,3);
INSERT INTO `bcnm_battlefield` VALUES (449,2,17604614,3);
INSERT INTO `bcnm_battlefield` VALUES (449,2,17604615,3);
INSERT INTO `bcnm_battlefield` VALUES (449,3,17604616,3);
INSERT INTO `bcnm_battlefield` VALUES (449,3,17604617,3);
INSERT INTO `bcnm_battlefield` VALUES (450,1,17604618,3); -- trial-size_trial_by_lightning
INSERT INTO `bcnm_battlefield` VALUES (450,2,17604619,3);
INSERT INTO `bcnm_battlefield` VALUES (450,3,17604620,3);
INSERT INTO `bcnm_battlefield` VALUES (452,1,17604636,3); -- sugar-coated_directive
INSERT INTO `bcnm_battlefield` VALUES (452,2,17604637,3);
INSERT INTO `bcnm_battlefield` VALUES (452,3,17604638,3);
INSERT INTO `bcnm_battlefield` VALUES (480,1,17608705,3); -- trial_by_ice
INSERT INTO `bcnm_battlefield` VALUES (480,2,17608706,3);
INSERT INTO `bcnm_battlefield` VALUES (480,3,17608707,3);
INSERT INTO `bcnm_battlefield` VALUES (481,1,17608708,3); -- class_reunion
INSERT INTO `bcnm_battlefield` VALUES (481,1,17608709,3);
INSERT INTO `bcnm_battlefield` VALUES (481,1,17608710,3);
INSERT INTO `bcnm_battlefield` VALUES (481,1,17608711,3);
INSERT INTO `bcnm_battlefield` VALUES (481,1,17608712,3);
INSERT INTO `bcnm_battlefield` VALUES (481,1,17608713,3);
INSERT INTO `bcnm_battlefield` VALUES (481,2,17608714,3);
INSERT INTO `bcnm_battlefield` VALUES (481,2,17608715,3);
INSERT INTO `bcnm_battlefield` VALUES (481,2,17608716,3);
INSERT INTO `bcnm_battlefield` VALUES (481,2,17608717,3);
INSERT INTO `bcnm_battlefield` VALUES (481,2,17608718,3);
INSERT INTO `bcnm_battlefield` VALUES (481,2,17608719,3);
INSERT INTO `bcnm_battlefield` VALUES (481,3,17608720,3);
INSERT INTO `bcnm_battlefield` VALUES (481,3,17608721,3);
INSERT INTO `bcnm_battlefield` VALUES (481,3,17608722,3);
INSERT INTO `bcnm_battlefield` VALUES (481,3,17608723,3);
INSERT INTO `bcnm_battlefield` VALUES (481,3,17608724,3);
INSERT INTO `bcnm_battlefield` VALUES (481,3,17608725,3);
INSERT INTO `bcnm_battlefield` VALUES (482,1,17608726,3); -- trial-size_trial_by_ice
INSERT INTO `bcnm_battlefield` VALUES (482,2,17608727,3);
INSERT INTO `bcnm_battlefield` VALUES (482,3,17608728,3);
INSERT INTO `bcnm_battlefield` VALUES (484,1,17608744,3); -- sugar-coated_directive
INSERT INTO `bcnm_battlefield` VALUES (484,2,17608745,3);
INSERT INTO `bcnm_battlefield` VALUES (484,3,17608746,3);
INSERT INTO `bcnm_battlefield` VALUES (512,1,17620993,3); -- rank_5_mission: Archlich Taber'quoan
INSERT INTO `bcnm_battlefield` VALUES (512,1,17620994,1); -- Ancient Sorcerer
INSERT INTO `bcnm_battlefield` VALUES (512,1,17620995,1); -- Ancient Sorcerer
INSERT INTO `bcnm_battlefield` VALUES (512,1,17620996,0); -- Ancient Warrior
INSERT INTO `bcnm_battlefield` VALUES (512,1,17620997,0); -- Ancient Warrior
INSERT INTO `bcnm_battlefield` VALUES (512,1,17620998,0); -- Ancient Warrior
INSERT INTO `bcnm_battlefield` VALUES (512,1,17620999,0); -- Ancient Warrior
INSERT INTO `bcnm_battlefield` VALUES (512,2,17621000,3); -- Archlich Taber'quoan
INSERT INTO `bcnm_battlefield` VALUES (512,2,17621001,1); -- Ancient Sorcerer
INSERT INTO `bcnm_battlefield` VALUES (512,2,17621002,1); -- Ancient Sorcerer
INSERT INTO `bcnm_battlefield` VALUES (512,2,17621003,0); -- Ancient Warrior
INSERT INTO `bcnm_battlefield` VALUES (512,2,17621004,0); -- Ancient Warrior
INSERT INTO `bcnm_battlefield` VALUES (512,2,17621005,0); -- Ancient Warrior
INSERT INTO `bcnm_battlefield` VALUES (512,2,17621006,0); -- Ancient Warrior
INSERT INTO `bcnm_battlefield` VALUES (512,3,17621007,3); -- Archlich Taber'quoan
INSERT INTO `bcnm_battlefield` VALUES (512,3,17621008,1); -- Ancient Sorcerer
INSERT INTO `bcnm_battlefield` VALUES (512,3,17621009,1); -- Ancient Sorcerer
INSERT INTO `bcnm_battlefield` VALUES (512,3,17621010,0); -- Ancient Warrior
INSERT INTO `bcnm_battlefield` VALUES (512,3,17621011,0); -- Ancient Warrior
INSERT INTO `bcnm_battlefield` VALUES (512,3,17621012,0); -- Ancient Warrior
INSERT INTO `bcnm_battlefield` VALUES (512,3,17621013,0); -- Ancient Warrior
INSERT INTO `bcnm_battlefield` VALUES (516,1,17621014,2); -- heir_to_the_light
INSERT INTO `bcnm_battlefield` VALUES (516,1,17621015,2);
INSERT INTO `bcnm_battlefield` VALUES (516,1,17621016,2);
INSERT INTO `bcnm_battlefield` VALUES (516,1,17621017,3);
INSERT INTO `bcnm_battlefield` VALUES (516,1,17621018,3);
INSERT INTO `bcnm_battlefield` VALUES (516,1,17621019,3);
INSERT INTO `bcnm_battlefield` VALUES (516,1,17621020,3);
INSERT INTO `bcnm_battlefield` VALUES (516,1,17621021,3);
INSERT INTO `bcnm_battlefield` VALUES (516,1,17621022,3);
INSERT INTO `bcnm_battlefield` VALUES (516,1,17621023,3);
INSERT INTO `bcnm_battlefield` VALUES (516,1,17621024,3);
INSERT INTO `bcnm_battlefield` VALUES (516,1,17621025,3);
INSERT INTO `bcnm_battlefield` VALUES (516,1,17621026,3);
INSERT INTO `bcnm_battlefield` VALUES (516,1,17621027,3);
INSERT INTO `bcnm_battlefield` VALUES (516,2,17621028,2);
INSERT INTO `bcnm_battlefield` VALUES (516,2,17621029,2);
INSERT INTO `bcnm_battlefield` VALUES (516,2,17621030,2);
INSERT INTO `bcnm_battlefield` VALUES (516,2,17621031,3);
INSERT INTO `bcnm_battlefield` VALUES (516,2,17621032,3);
INSERT INTO `bcnm_battlefield` VALUES (516,2,17621033,3);
INSERT INTO `bcnm_battlefield` VALUES (516,2,17621034,3);
INSERT INTO `bcnm_battlefield` VALUES (516,2,17621035,3);
INSERT INTO `bcnm_battlefield` VALUES (516,2,17621036,3);
INSERT INTO `bcnm_battlefield` VALUES (516,2,17621037,3);
INSERT INTO `bcnm_battlefield` VALUES (516,2,17621038,3);
INSERT INTO `bcnm_battlefield` VALUES (516,2,17621039,3);
INSERT INTO `bcnm_battlefield` VALUES (516,2,17621040,3);
INSERT INTO `bcnm_battlefield` VALUES (516,2,17621041,3);
INSERT INTO `bcnm_battlefield` VALUES (516,3,17621042,2);
INSERT INTO `bcnm_battlefield` VALUES (516,3,17621043,2);
INSERT INTO `bcnm_battlefield` VALUES (516,3,17621044,2);
INSERT INTO `bcnm_battlefield` VALUES (516,3,17621045,3);
INSERT INTO `bcnm_battlefield` VALUES (516,3,17621046,3);
INSERT INTO `bcnm_battlefield` VALUES (516,3,17621047,3);
INSERT INTO `bcnm_battlefield` VALUES (516,3,17621048,3);
INSERT INTO `bcnm_battlefield` VALUES (516,3,17621049,3);
INSERT INTO `bcnm_battlefield` VALUES (516,3,17621050,3);
INSERT INTO `bcnm_battlefield` VALUES (516,3,17621051,3);
INSERT INTO `bcnm_battlefield` VALUES (516,3,17621052,3);
INSERT INTO `bcnm_battlefield` VALUES (516,3,17621053,3);
INSERT INTO `bcnm_battlefield` VALUES (516,3,17621054,3);
INSERT INTO `bcnm_battlefield` VALUES (516,3,17621055,3);
INSERT INTO `bcnm_battlefield` VALUES (517,1,17621056,3); -- shattering_stars PLD
INSERT INTO `bcnm_battlefield` VALUES (517,2,17621057,3);
INSERT INTO `bcnm_battlefield` VALUES (517,3,17621058,3);
INSERT INTO `bcnm_battlefield` VALUES (518,1,17621059,3); -- shattering_stars DRK
INSERT INTO `bcnm_battlefield` VALUES (518,2,17621060,3);
INSERT INTO `bcnm_battlefield` VALUES (518,3,17621061,3);
INSERT INTO `bcnm_battlefield` VALUES (519,1,17621062,3); -- shattering_stars BRD
INSERT INTO `bcnm_battlefield` VALUES (519,2,17621063,3);
INSERT INTO `bcnm_battlefield` VALUES (519,3,17621064,3);
INSERT INTO `bcnm_battlefield` VALUES (520,1,17621137,3); -- demolition_squad
INSERT INTO `bcnm_battlefield` VALUES (520,1,17621138,3);
INSERT INTO `bcnm_battlefield` VALUES (520,1,17621139,3);
INSERT INTO `bcnm_battlefield` VALUES (520,1,17621140,3);
INSERT INTO `bcnm_battlefield` VALUES (520,2,17621142,3);
INSERT INTO `bcnm_battlefield` VALUES (520,2,17621143,3);
INSERT INTO `bcnm_battlefield` VALUES (520,2,17621144,3);
INSERT INTO `bcnm_battlefield` VALUES (520,2,17621145,3);
INSERT INTO `bcnm_battlefield` VALUES (520,3,17621147,3);
INSERT INTO `bcnm_battlefield` VALUES (520,3,17621148,3);
INSERT INTO `bcnm_battlefield` VALUES (520,3,17621149,3);
INSERT INTO `bcnm_battlefield` VALUES (520,3,17621150,3);
INSERT INTO `bcnm_battlefield` VALUES (521,1,17621065,3); -- die_by_the_sword
INSERT INTO `bcnm_battlefield` VALUES (521,1,17621066,3);
INSERT INTO `bcnm_battlefield` VALUES (521,1,17621067,3);
INSERT INTO `bcnm_battlefield` VALUES (521,2,17621069,3);
INSERT INTO `bcnm_battlefield` VALUES (521,2,17621070,3);
INSERT INTO `bcnm_battlefield` VALUES (521,2,17621071,3);
INSERT INTO `bcnm_battlefield` VALUES (521,3,17621073,3);
INSERT INTO `bcnm_battlefield` VALUES (521,3,17621074,3);
INSERT INTO `bcnm_battlefield` VALUES (521,3,17621075,3);
INSERT INTO `bcnm_battlefield` VALUES (522,1,17621077,3); -- let_sleeping_dogs_die
INSERT INTO `bcnm_battlefield` VALUES (522,1,17621078,3);
INSERT INTO `bcnm_battlefield` VALUES (522,1,17621079,3);
INSERT INTO `bcnm_battlefield` VALUES (522,1,17621080,3);
INSERT INTO `bcnm_battlefield` VALUES (522,2,17621082,3);
INSERT INTO `bcnm_battlefield` VALUES (522,2,17621083,3);
INSERT INTO `bcnm_battlefield` VALUES (522,2,17621084,3);
INSERT INTO `bcnm_battlefield` VALUES (522,2,17621085,3);
INSERT INTO `bcnm_battlefield` VALUES (522,3,17621087,3);
INSERT INTO `bcnm_battlefield` VALUES (522,3,17621088,3);
INSERT INTO `bcnm_battlefield` VALUES (522,3,17621089,3);
INSERT INTO `bcnm_battlefield` VALUES (522,3,17621090,3);
INSERT INTO `bcnm_battlefield` VALUES (523,1,17621152,3); -- brothers_d_aurphe
INSERT INTO `bcnm_battlefield` VALUES (523,1,17621153,3);
INSERT INTO `bcnm_battlefield` VALUES (523,1,17621154,3);
INSERT INTO `bcnm_battlefield` VALUES (523,1,17621155,3);
INSERT INTO `bcnm_battlefield` VALUES (523,2,17621157,3);
INSERT INTO `bcnm_battlefield` VALUES (523,2,17621158,3);
INSERT INTO `bcnm_battlefield` VALUES (523,2,17621159,3);
INSERT INTO `bcnm_battlefield` VALUES (523,2,17621160,3);
INSERT INTO `bcnm_battlefield` VALUES (523,3,17621162,3);
INSERT INTO `bcnm_battlefield` VALUES (523,3,17621163,3);
INSERT INTO `bcnm_battlefield` VALUES (523,3,17621164,3);
INSERT INTO `bcnm_battlefield` VALUES (523,3,17621165,3);
INSERT INTO `bcnm_battlefield` VALUES (524,1,17621113,3); -- undying_promise
INSERT INTO `bcnm_battlefield` VALUES (524,1,17621114,2);
INSERT INTO `bcnm_battlefield` VALUES (524,2,17621116,3);
INSERT INTO `bcnm_battlefield` VALUES (524,2,17621117,2);
INSERT INTO `bcnm_battlefield` VALUES (524,3,17621119,3);
INSERT INTO `bcnm_battlefield` VALUES (524,3,17621120,2);
INSERT INTO `bcnm_battlefield` VALUES (525,1,17621092,3); -- factory_rejects
INSERT INTO `bcnm_battlefield` VALUES (525,1,17621093,2);
INSERT INTO `bcnm_battlefield` VALUES (525,1,17621094,2);
INSERT INTO `bcnm_battlefield` VALUES (525,1,17621095,2);
INSERT INTO `bcnm_battlefield` VALUES (525,1,17621096,2);
INSERT INTO `bcnm_battlefield` VALUES (525,1,17621097,2);
INSERT INTO `bcnm_battlefield` VALUES (525,2,17621099,3);
INSERT INTO `bcnm_battlefield` VALUES (525,2,17621100,2);
INSERT INTO `bcnm_battlefield` VALUES (525,2,17621101,2);
INSERT INTO `bcnm_battlefield` VALUES (525,2,17621102,2);
INSERT INTO `bcnm_battlefield` VALUES (525,2,17621103,2);
INSERT INTO `bcnm_battlefield` VALUES (525,2,17621104,2);
INSERT INTO `bcnm_battlefield` VALUES (525,3,17621106,3);
INSERT INTO `bcnm_battlefield` VALUES (525,3,17621107,2);
INSERT INTO `bcnm_battlefield` VALUES (525,3,17621108,2);
INSERT INTO `bcnm_battlefield` VALUES (525,3,17621109,2);
INSERT INTO `bcnm_battlefield` VALUES (525,3,17621110,2);
INSERT INTO `bcnm_battlefield` VALUES (525,3,17621111,2);
INSERT INTO `bcnm_battlefield` VALUES (526,1,17621122,3); -- idol_thoughts
INSERT INTO `bcnm_battlefield` VALUES (526,1,17621123,3);
INSERT INTO `bcnm_battlefield` VALUES (526,1,17621124,3);
INSERT INTO `bcnm_battlefield` VALUES (526,1,17621125,3);
INSERT INTO `bcnm_battlefield` VALUES (526,2,17621127,3);
INSERT INTO `bcnm_battlefield` VALUES (526,2,17621128,3);
INSERT INTO `bcnm_battlefield` VALUES (526,2,17621129,3);
INSERT INTO `bcnm_battlefield` VALUES (526,2,17621130,3);
INSERT INTO `bcnm_battlefield` VALUES (526,3,17621132,3);
INSERT INTO `bcnm_battlefield` VALUES (526,3,17621133,3);
INSERT INTO `bcnm_battlefield` VALUES (526,3,17621134,3);
INSERT INTO `bcnm_battlefield` VALUES (526,3,17621135,3);
INSERT INTO `bcnm_battlefield` VALUES (527,1,17621167,3); -- awful_autopsy
INSERT INTO `bcnm_battlefield` VALUES (527,1,17621168,2);
INSERT INTO `bcnm_battlefield` VALUES (527,1,17621169,2);
INSERT INTO `bcnm_battlefield` VALUES (527,2,17621172,3);
INSERT INTO `bcnm_battlefield` VALUES (527,2,17621173,2);
INSERT INTO `bcnm_battlefield` VALUES (527,2,17621174,2);
INSERT INTO `bcnm_battlefield` VALUES (527,3,17621177,3);
INSERT INTO `bcnm_battlefield` VALUES (527,3,17621178,2);
INSERT INTO `bcnm_battlefield` VALUES (527,3,17621179,2);
INSERT INTO `bcnm_battlefield` VALUES (528,1,17621182,3); -- celery
INSERT INTO `bcnm_battlefield` VALUES (528,1,17621183,3);
INSERT INTO `bcnm_battlefield` VALUES (528,1,17621184,3);
INSERT INTO `bcnm_battlefield` VALUES (528,1,17621185,3);
INSERT INTO `bcnm_battlefield` VALUES (528,2,17621187,3);
INSERT INTO `bcnm_battlefield` VALUES (528,2,17621188,3);
INSERT INTO `bcnm_battlefield` VALUES (528,2,17621189,3);
INSERT INTO `bcnm_battlefield` VALUES (528,2,17621190,3);
INSERT INTO `bcnm_battlefield` VALUES (528,3,17621192,3);
INSERT INTO `bcnm_battlefield` VALUES (528,3,17621193,3);
INSERT INTO `bcnm_battlefield` VALUES (528,3,17621194,3);
INSERT INTO `bcnm_battlefield` VALUES (528,3,17621195,3);
INSERT INTO `bcnm_battlefield` VALUES (532,1,17621290,3); -- those_who_lurk_in_shadows
INSERT INTO `bcnm_battlefield` VALUES (532,1,17621291,3);
INSERT INTO `bcnm_battlefield` VALUES (532,1,17621292,3);
INSERT INTO `bcnm_battlefield` VALUES (532,1,17621293,3);
INSERT INTO `bcnm_battlefield` VALUES (532,2,17621294,3);
INSERT INTO `bcnm_battlefield` VALUES (532,2,17621295,3);
INSERT INTO `bcnm_battlefield` VALUES (532,2,17621296,3);
INSERT INTO `bcnm_battlefield` VALUES (532,2,17621297,3);
INSERT INTO `bcnm_battlefield` VALUES (532,3,17621298,3);
INSERT INTO `bcnm_battlefield` VALUES (532,3,17621299,3);
INSERT INTO `bcnm_battlefield` VALUES (532,3,17621300,3);
INSERT INTO `bcnm_battlefield` VALUES (532,3,17621301,3);
INSERT INTO `bcnm_battlefield` VALUES (533,1,17621302,3); -- beyond_infinity (Qu'Bia Arena)
INSERT INTO `bcnm_battlefield` VALUES (533,2,17621303,3); -- beyond_infinity (Qu'Bia Arena)
INSERT INTO `bcnm_battlefield` VALUES (533,3,17621304,3); -- beyond_infinity (Qu'Bia Arena)
INSERT INTO `bcnm_battlefield` VALUES (544,1,17625089,3); -- trial_by_fire
INSERT INTO `bcnm_battlefield` VALUES (544,2,17625090,3);
INSERT INTO `bcnm_battlefield` VALUES (544,3,17625091,3);
INSERT INTO `bcnm_battlefield` VALUES (545,1,17625092,3); -- trial-size_trial_by_fire
INSERT INTO `bcnm_battlefield` VALUES (545,2,17625093,3);
INSERT INTO `bcnm_battlefield` VALUES (545,3,17625094,3);
INSERT INTO `bcnm_battlefield` VALUES (547,1,17625110,3); -- sugar-coated_directive
INSERT INTO `bcnm_battlefield` VALUES (547,2,17625111,3);
INSERT INTO `bcnm_battlefield` VALUES (547,3,17625112,3);
INSERT INTO `bcnm_battlefield` VALUES (576,1,17633281,3); -- trial_by_earth
INSERT INTO `bcnm_battlefield` VALUES (576,2,17633282,3);
INSERT INTO `bcnm_battlefield` VALUES (576,3,17633283,3);
INSERT INTO `bcnm_battlefield` VALUES (577,1,17633284,3); -- puppet_master
INSERT INTO `bcnm_battlefield` VALUES (577,2,17633285,3);
INSERT INTO `bcnm_battlefield` VALUES (577,3,17633286,3);
INSERT INTO `bcnm_battlefield` VALUES (578,1,17633287,3); -- trial-size_trial_by_earth
INSERT INTO `bcnm_battlefield` VALUES (578,2,17633288,3);
INSERT INTO `bcnm_battlefield` VALUES (578,3,17633289,3);
INSERT INTO `bcnm_battlefield` VALUES (580,1,17633305,3); -- sugar-coated_directive
INSERT INTO `bcnm_battlefield` VALUES (580,2,17633306,3);
INSERT INTO `bcnm_battlefield` VALUES (580,3,17633307,3);
INSERT INTO `bcnm_battlefield` VALUES (608,1,17641473,3); -- trial_by_water
INSERT INTO `bcnm_battlefield` VALUES (608,2,17641474,3);
INSERT INTO `bcnm_battlefield` VALUES (608,3,17641475,3);
INSERT INTO `bcnm_battlefield` VALUES (609,1,17641476,3); -- trial-size_trial_by_water
INSERT INTO `bcnm_battlefield` VALUES (609,2,17641477,3);
INSERT INTO `bcnm_battlefield` VALUES (609,3,17641478,3);
INSERT INTO `bcnm_battlefield` VALUES (611,1,17641494,3); -- sugar-coated_directive
INSERT INTO `bcnm_battlefield` VALUES (611,2,17641495,3);
INSERT INTO `bcnm_battlefield` VALUES (611,3,17641496,3);
INSERT INTO `bcnm_battlefield` VALUES (640,1,16801793,3); -- flames_for_the_dead
INSERT INTO `bcnm_battlefield` VALUES (640,2,16801794,3);
INSERT INTO `bcnm_battlefield` VALUES (640,3,16801795,3);
INSERT INTO `bcnm_battlefield` VALUES (643,1,16801841,3); -- brothers
INSERT INTO `bcnm_battlefield` VALUES (643,1,16801842,3);
INSERT INTO `bcnm_battlefield` VALUES (643,2,16801844,3);
INSERT INTO `bcnm_battlefield` VALUES (643,2,16801845,3);
INSERT INTO `bcnm_battlefield` VALUES (643,3,16801847,3);
INSERT INTO `bcnm_battlefield` VALUES (643,3,16801848,3);
INSERT INTO `bcnm_battlefield` VALUES (672,1,16809987,3); -- head_wind
INSERT INTO `bcnm_battlefield` VALUES (672,1,16809986,3);
INSERT INTO `bcnm_battlefield` VALUES (672,1,16809985,3);
INSERT INTO `bcnm_battlefield` VALUES (672,1,16809989,0);
INSERT INTO `bcnm_battlefield` VALUES (672,1,16809988,0);
INSERT INTO `bcnm_battlefield` VALUES (672,2,16809992,3);
INSERT INTO `bcnm_battlefield` VALUES (672,2,16809991,3);
INSERT INTO `bcnm_battlefield` VALUES (672,2,16809990,3);
INSERT INTO `bcnm_battlefield` VALUES (672,2,16809994,0);
INSERT INTO `bcnm_battlefield` VALUES (672,2,16809993,0);
INSERT INTO `bcnm_battlefield` VALUES (672,3,16809997,3);
INSERT INTO `bcnm_battlefield` VALUES (672,3,16809996,3);
INSERT INTO `bcnm_battlefield` VALUES (672,3,16809995,3);
INSERT INTO `bcnm_battlefield` VALUES (672,3,16809999,0);
INSERT INTO `bcnm_battlefield` VALUES (672,3,16809998,0);
INSERT INTO `bcnm_battlefield` VALUES (673,1,16810018,3); -- like_the_wind: Race Runner
INSERT INTO `bcnm_battlefield` VALUES (673,2,16810020,3); -- Race Runner
INSERT INTO `bcnm_battlefield` VALUES (673,3,16810022,3); -- Race Runner
INSERT INTO `bcnm_battlefield` VALUES (674,1,16810001,3); -- sheep in antlions: Tuchulcha
INSERT INTO `bcnm_battlefield` VALUES (674,1,16810002,1); -- Swift Hunter
INSERT INTO `bcnm_battlefield` VALUES (674,1,16810003,1); -- Shrewd Hunter
INSERT INTO `bcnm_battlefield` VALUES (674,1,16810004,1); -- Armored Hunter
INSERT INTO `bcnm_battlefield` VALUES (674,2,16810007,3); -- Tuchulcha
INSERT INTO `bcnm_battlefield` VALUES (674,2,16810008,1); -- Swift Hunter
INSERT INTO `bcnm_battlefield` VALUES (674,2,16810009,1); -- Shrewd Hunter
INSERT INTO `bcnm_battlefield` VALUES (674,2,16810010,1); -- Armored Hunter
INSERT INTO `bcnm_battlefield` VALUES (674,3,16810013,3); -- Tuchulcha
INSERT INTO `bcnm_battlefield` VALUES (674,3,16810014,0); -- Swift Hunter
INSERT INTO `bcnm_battlefield` VALUES (674,3,16810015,0); -- Shrewd Hunter
INSERT INTO `bcnm_battlefield` VALUES (674,3,16810016,0); -- Armored Hunter
INSERT INTO `bcnm_battlefield` VALUES (675,1,16810024,3); -- Parata
INSERT INTO `bcnm_battlefield` VALUES (675,1,16810025,3); -- Bladmall
INSERT INTO `bcnm_battlefield` VALUES (675,1,16810026,0); -- Nepionic Parata
INSERT INTO `bcnm_battlefield` VALUES (675,1,16810027,0);
INSERT INTO `bcnm_battlefield` VALUES (675,1,16810028,0);
INSERT INTO `bcnm_battlefield` VALUES (675,1,16810029,0); -- Nepionic Bladmall
INSERT INTO `bcnm_battlefield` VALUES (675,1,16810030,0);
INSERT INTO `bcnm_battlefield` VALUES (675,1,16810031,0);
INSERT INTO `bcnm_battlefield` VALUES (675,2,16810033,3); -- Parata
INSERT INTO `bcnm_battlefield` VALUES (675,2,16810034,3); -- Bladmall
INSERT INTO `bcnm_battlefield` VALUES (675,2,16810035,0); -- Nepionic Parata
INSERT INTO `bcnm_battlefield` VALUES (675,2,16810036,0);
INSERT INTO `bcnm_battlefield` VALUES (675,2,16810037,0);
INSERT INTO `bcnm_battlefield` VALUES (675,2,16810038,0); -- Nepionic Bladmall
INSERT INTO `bcnm_battlefield` VALUES (675,2,16810039,0);
INSERT INTO `bcnm_battlefield` VALUES (675,2,16810040,0);
INSERT INTO `bcnm_battlefield` VALUES (675,3,16810042,3); -- Parata
INSERT INTO `bcnm_battlefield` VALUES (675,3,16810043,3); -- Bladmall
INSERT INTO `bcnm_battlefield` VALUES (675,3,16810044,0); -- Nepionic Parata
INSERT INTO `bcnm_battlefield` VALUES (675,3,16810045,0);
INSERT INTO `bcnm_battlefield` VALUES (675,3,16810046,0);
INSERT INTO `bcnm_battlefield` VALUES (675,3,16810047,0); -- Nepionic Bladmall
INSERT INTO `bcnm_battlefield` VALUES (675,3,16810048,0);
INSERT INTO `bcnm_battlefield` VALUES (675,3,16810049,0);
INSERT INTO `bcnm_battlefield` VALUES (704,1,16818177,3); -- darkness_named
INSERT INTO `bcnm_battlefield` VALUES (704,1,16818178,1);
INSERT INTO `bcnm_battlefield` VALUES (704,1,16818179,1);
INSERT INTO `bcnm_battlefield` VALUES (704,1,16818180,1);
INSERT INTO `bcnm_battlefield` VALUES (704,1,16818181,1);
INSERT INTO `bcnm_battlefield` VALUES (704,1,16818182,1);
INSERT INTO `bcnm_battlefield` VALUES (704,1,16818183,1);
INSERT INTO `bcnm_battlefield` VALUES (704,2,16818184,3);
INSERT INTO `bcnm_battlefield` VALUES (704,2,16818185,1);
INSERT INTO `bcnm_battlefield` VALUES (704,2,16818186,1);
INSERT INTO `bcnm_battlefield` VALUES (704,2,16818187,1);
INSERT INTO `bcnm_battlefield` VALUES (704,2,16818188,1);
INSERT INTO `bcnm_battlefield` VALUES (704,2,16818189,1);
INSERT INTO `bcnm_battlefield` VALUES (704,2,16818190,1);
INSERT INTO `bcnm_battlefield` VALUES (704,3,16818191,3);
INSERT INTO `bcnm_battlefield` VALUES (704,3,16818192,1);
INSERT INTO `bcnm_battlefield` VALUES (704,3,16818193,1);
INSERT INTO `bcnm_battlefield` VALUES (704,3,16818194,1);
INSERT INTO `bcnm_battlefield` VALUES (704,3,16818195,1);
INSERT INTO `bcnm_battlefield` VALUES (704,3,16818196,1);
INSERT INTO `bcnm_battlefield` VALUES (704,3,16818197,1);
INSERT INTO `bcnm_battlefield` VALUES (706,1,16818204,3); -- waking_dreams
INSERT INTO `bcnm_battlefield` VALUES (706,1,16818205,1);
INSERT INTO `bcnm_battlefield` VALUES (706,1,16818206,1);
INSERT INTO `bcnm_battlefield` VALUES (706,1,16818207,1);
INSERT INTO `bcnm_battlefield` VALUES (706,1,16818208,1);
INSERT INTO `bcnm_battlefield` VALUES (706,1,16818209,1);
INSERT INTO `bcnm_battlefield` VALUES (706,1,16818210,1);
INSERT INTO `bcnm_battlefield` VALUES (706,2,16818211,3);
INSERT INTO `bcnm_battlefield` VALUES (706,2,16818212,1);
INSERT INTO `bcnm_battlefield` VALUES (706,2,16818213,1);
INSERT INTO `bcnm_battlefield` VALUES (706,2,16818214,1);
INSERT INTO `bcnm_battlefield` VALUES (706,2,16818215,1);
INSERT INTO `bcnm_battlefield` VALUES (706,2,16818216,1);
INSERT INTO `bcnm_battlefield` VALUES (706,2,16818217,1);
INSERT INTO `bcnm_battlefield` VALUES (706,3,16818218,3);
INSERT INTO `bcnm_battlefield` VALUES (706,3,16818219,1);
INSERT INTO `bcnm_battlefield` VALUES (706,3,16818220,1);
INSERT INTO `bcnm_battlefield` VALUES (706,3,16818221,1);
INSERT INTO `bcnm_battlefield` VALUES (706,3,16818222,1);
INSERT INTO `bcnm_battlefield` VALUES (706,3,16818223,1);
INSERT INTO `bcnm_battlefield` VALUES (706,3,16818224,1);
INSERT INTO `bcnm_battlefield` VALUES (736,1,16830466,3); -- century_of_hardship
INSERT INTO `bcnm_battlefield` VALUES (736,1,16830465,3);
INSERT INTO `bcnm_battlefield` VALUES (736,1,16830468,3);
INSERT INTO `bcnm_battlefield` VALUES (736,1,16830467,3);
INSERT INTO `bcnm_battlefield` VALUES (736,1,16830469,3);
INSERT INTO `bcnm_battlefield` VALUES (736,2,16830471,3);
INSERT INTO `bcnm_battlefield` VALUES (736,2,16830470,3);
INSERT INTO `bcnm_battlefield` VALUES (736,2,16830473,3);
INSERT INTO `bcnm_battlefield` VALUES (736,2,16830472,3);
INSERT INTO `bcnm_battlefield` VALUES (736,2,16830474,3);
INSERT INTO `bcnm_battlefield` VALUES (736,3,16830476,3);
INSERT INTO `bcnm_battlefield` VALUES (736,3,16830475,3);
INSERT INTO `bcnm_battlefield` VALUES (736,3,16830478,3);
INSERT INTO `bcnm_battlefield` VALUES (736,3,16830477,3);
INSERT INTO `bcnm_battlefield` VALUES (736,3,16830479,3);
INSERT INTO `bcnm_battlefield` VALUES (768,1,16846849,3); -- ancient_flames_beckon
INSERT INTO `bcnm_battlefield` VALUES (768,2,16846850,3);
INSERT INTO `bcnm_battlefield` VALUES (768,3,16846851,3);
INSERT INTO `bcnm_battlefield` VALUES (800,1,16855041,3); -- ancient_flames_beckon (dem)
INSERT INTO `bcnm_battlefield` VALUES (800,1,16855042,0);
INSERT INTO `bcnm_battlefield` VALUES (800,1,16855043,0);
INSERT INTO `bcnm_battlefield` VALUES (800,1,16855044,0);
INSERT INTO `bcnm_battlefield` VALUES (800,1,16855045,0);
INSERT INTO `bcnm_battlefield` VALUES (800,2,16855046,3);
INSERT INTO `bcnm_battlefield` VALUES (800,2,16855047,0);
INSERT INTO `bcnm_battlefield` VALUES (800,2,16855048,0);
INSERT INTO `bcnm_battlefield` VALUES (800,2,16855049,0);
INSERT INTO `bcnm_battlefield` VALUES (800,2,16855050,0);
INSERT INTO `bcnm_battlefield` VALUES (800,3,16855051,3);
INSERT INTO `bcnm_battlefield` VALUES (800,3,16855052,0);
INSERT INTO `bcnm_battlefield` VALUES (800,3,16855053,0);
INSERT INTO `bcnm_battlefield` VALUES (800,3,16855054,0);
INSERT INTO `bcnm_battlefield` VALUES (800,3,16855055,0);
INSERT INTO `bcnm_battlefield` VALUES (832,1,16863233,3); -- ancient_flames_backon
INSERT INTO `bcnm_battlefield` VALUES (832,2,16863234,3);
INSERT INTO `bcnm_battlefield` VALUES (832,3,16863235,3);
INSERT INTO `bcnm_battlefield` VALUES (864,1,16871425,3); -- desires_of_emptiness
INSERT INTO `bcnm_battlefield` VALUES (864,1,16871426,3);
INSERT INTO `bcnm_battlefield` VALUES (864,1,16871427,0);
INSERT INTO `bcnm_battlefield` VALUES (864,1,16871428,0);
INSERT INTO `bcnm_battlefield` VALUES (864,1,16871429,0);
INSERT INTO `bcnm_battlefield` VALUES (864,1,16871430,0);
INSERT INTO `bcnm_battlefield` VALUES (864,1,16871431,3);
INSERT INTO `bcnm_battlefield` VALUES (864,2,16871432,3);
INSERT INTO `bcnm_battlefield` VALUES (864,2,16871433,3);
INSERT INTO `bcnm_battlefield` VALUES (864,2,16871434,0);
INSERT INTO `bcnm_battlefield` VALUES (864,2,16871435,0);
INSERT INTO `bcnm_battlefield` VALUES (864,2,16871436,0);
INSERT INTO `bcnm_battlefield` VALUES (864,2,16871437,0);
INSERT INTO `bcnm_battlefield` VALUES (864,2,16871438,3);
INSERT INTO `bcnm_battlefield` VALUES (864,3,16871439,3);
INSERT INTO `bcnm_battlefield` VALUES (864,3,16871440,3);
INSERT INTO `bcnm_battlefield` VALUES (864,3,16871441,0);
INSERT INTO `bcnm_battlefield` VALUES (864,3,16871442,0);
INSERT INTO `bcnm_battlefield` VALUES (864,3,16871443,0);
INSERT INTO `bcnm_battlefield` VALUES (864,3,16871444,0);
INSERT INTO `bcnm_battlefield` VALUES (864,3,16871445,3);
INSERT INTO `bcnm_battlefield` VALUES (896,1,16896156,3); -- storms_of_fate
INSERT INTO `bcnm_battlefield` VALUES (960,1,16904193,3); -- ancient_vows
INSERT INTO `bcnm_battlefield` VALUES (960,1,16904194,3);
INSERT INTO `bcnm_battlefield` VALUES (960,1,16904195,3);
INSERT INTO `bcnm_battlefield` VALUES (960,2,16904196,3);
INSERT INTO `bcnm_battlefield` VALUES (960,2,16904197,3);
INSERT INTO `bcnm_battlefield` VALUES (960,2,16904198,3);
INSERT INTO `bcnm_battlefield` VALUES (960,3,16904199,3);
INSERT INTO `bcnm_battlefield` VALUES (960,3,16904200,3);
INSERT INTO `bcnm_battlefield` VALUES (960,3,16904201,3);
INSERT INTO `bcnm_battlefield` VALUES (961,1,16904202,3); -- savage
INSERT INTO `bcnm_battlefield` VALUES (961,2,16904203,3);
INSERT INTO `bcnm_battlefield` VALUES (961,3,16904204,3);
INSERT INTO `bcnm_battlefield` VALUES (966,1,16904232,0); -- uninvited guests
INSERT INTO `bcnm_battlefield` VALUES (966,1,16904233,3);
INSERT INTO `bcnm_battlefield` VALUES (966,1,16904234,2);
INSERT INTO `bcnm_battlefield` VALUES (966,1,16904235,2);
INSERT INTO `bcnm_battlefield` VALUES (966,1,16904236,2);
INSERT INTO `bcnm_battlefield` VALUES (966,1,16904237,2);
INSERT INTO `bcnm_battlefield` VALUES (966,1,16904238,2);
INSERT INTO `bcnm_battlefield` VALUES (966,1,16904239,2);
INSERT INTO `bcnm_battlefield` VALUES (966,1,16904240,2);
INSERT INTO `bcnm_battlefield` VALUES (966,1,16904241,2);
INSERT INTO `bcnm_battlefield` VALUES (966,2,16904242,0);
INSERT INTO `bcnm_battlefield` VALUES (966,2,16904243,3);
INSERT INTO `bcnm_battlefield` VALUES (966,2,16904244,2);
INSERT INTO `bcnm_battlefield` VALUES (966,2,16904245,2);
INSERT INTO `bcnm_battlefield` VALUES (966,2,16904246,2);
INSERT INTO `bcnm_battlefield` VALUES (966,2,16904247,2);
INSERT INTO `bcnm_battlefield` VALUES (966,2,16904248,2);
INSERT INTO `bcnm_battlefield` VALUES (966,2,16904249,2);
INSERT INTO `bcnm_battlefield` VALUES (966,2,16904250,2);
INSERT INTO `bcnm_battlefield` VALUES (966,2,16904251,2);
INSERT INTO `bcnm_battlefield` VALUES (966,3,16904252,0);
INSERT INTO `bcnm_battlefield` VALUES (966,3,16904253,3);
INSERT INTO `bcnm_battlefield` VALUES (966,3,16904254,2);
INSERT INTO `bcnm_battlefield` VALUES (966,3,16904255,2);
INSERT INTO `bcnm_battlefield` VALUES (966,3,16904256,2);
INSERT INTO `bcnm_battlefield` VALUES (966,3,16904257,2);
INSERT INTO `bcnm_battlefield` VALUES (966,3,16904258,2);
INSERT INTO `bcnm_battlefield` VALUES (966,3,16904259,2);
INSERT INTO `bcnm_battlefield` VALUES (966,3,16904260,2);
INSERT INTO `bcnm_battlefield` VALUES (966,3,16904261,2);
INSERT INTO `bcnm_battlefield` VALUES (992,1,16908289,3); -- one_to_be_feared
INSERT INTO `bcnm_battlefield` VALUES (992,1,16908290,3);
INSERT INTO `bcnm_battlefield` VALUES (992,1,16908291,3);
INSERT INTO `bcnm_battlefield` VALUES (992,1,16908292,3);
INSERT INTO `bcnm_battlefield` VALUES (992,1,16908293,3);
INSERT INTO `bcnm_battlefield` VALUES (992,1,16908294,2);
INSERT INTO `bcnm_battlefield` VALUES (992,1,16908295,2);
INSERT INTO `bcnm_battlefield` VALUES (992,2,16908296,3);
INSERT INTO `bcnm_battlefield` VALUES (992,2,16908297,3);
INSERT INTO `bcnm_battlefield` VALUES (992,2,16908298,3);
INSERT INTO `bcnm_battlefield` VALUES (992,2,16908299,3);
INSERT INTO `bcnm_battlefield` VALUES (992,2,16908300,3);
INSERT INTO `bcnm_battlefield` VALUES (992,2,16908301,2);
INSERT INTO `bcnm_battlefield` VALUES (992,2,16908302,2);
INSERT INTO `bcnm_battlefield` VALUES (992,3,16908303,3);
INSERT INTO `bcnm_battlefield` VALUES (992,3,16908304,3);
INSERT INTO `bcnm_battlefield` VALUES (992,3,16908305,3);
INSERT INTO `bcnm_battlefield` VALUES (992,3,16908306,3);
INSERT INTO `bcnm_battlefield` VALUES (992,3,16908307,3);
INSERT INTO `bcnm_battlefield` VALUES (992,3,16908308,2);
INSERT INTO `bcnm_battlefield` VALUES (992,3,16908309,2);
INSERT INTO `bcnm_battlefield` VALUES (993,1,16908310,3); -- warriors_path
INSERT INTO `bcnm_battlefield` VALUES (993,1,16908311,0);
INSERT INTO `bcnm_battlefield` VALUES (993,1,16908312,0);
INSERT INTO `bcnm_battlefield` VALUES (993,1,16908313,0);
INSERT INTO `bcnm_battlefield` VALUES (993,2,16908314,3);
INSERT INTO `bcnm_battlefield` VALUES (993,2,16908315,0);
INSERT INTO `bcnm_battlefield` VALUES (993,2,16908316,0);
INSERT INTO `bcnm_battlefield` VALUES (993,2,16908317,0);
INSERT INTO `bcnm_battlefield` VALUES (993,3,16908318,3);
INSERT INTO `bcnm_battlefield` VALUES (993,3,16908319,0);
INSERT INTO `bcnm_battlefield` VALUES (993,3,16908320,0);
INSERT INTO `bcnm_battlefield` VALUES (993,3,16908321,0);
INSERT INTO `bcnm_battlefield` VALUES (1024,1,16921011,3); -- when_angels_fall
INSERT INTO `bcnm_battlefield` VALUES (1024,1,16921012,3);
INSERT INTO `bcnm_battlefield` VALUES (1024,1,16921013,3);
INSERT INTO `bcnm_battlefield` VALUES (1024,1,16921014,3);
INSERT INTO `bcnm_battlefield` VALUES (1056,1,16924673,3); -- dawn
INSERT INTO `bcnm_battlefield` VALUES (1056,1,16924674,2);
INSERT INTO `bcnm_battlefield` VALUES (1056,2,16924675,3);
INSERT INTO `bcnm_battlefield` VALUES (1056,2,16924676,2);
INSERT INTO `bcnm_battlefield` VALUES (1056,3,16924677,3);
INSERT INTO `bcnm_battlefield` VALUES (1056,3,16924678,2);
INSERT INTO `bcnm_battlefield` VALUES (1057,1,16924679,3); -- Apoc Nigh
INSERT INTO `bcnm_battlefield` VALUES (1057,1,16924680,3);
INSERT INTO `bcnm_battlefield` VALUES (1057,2,16924681,3); -- Apoc Nigh
INSERT INTO `bcnm_battlefield` VALUES (1057,2,16924682,3);
INSERT INTO `bcnm_battlefield` VALUES (1057,3,16924683,3); -- Apoc Nigh
INSERT INTO `bcnm_battlefield` VALUES (1057,3,16924684,3);
INSERT INTO `bcnm_battlefield` VALUES (1092,1,17010725,3); -- legacy_of_the_lost
INSERT INTO `bcnm_battlefield` VALUES (1092,1,17010726,0);
INSERT INTO `bcnm_battlefield` VALUES (1092,1,17010727,0);
INSERT INTO `bcnm_battlefield` VALUES (1092,1,17010728,0);
INSERT INTO `bcnm_battlefield` VALUES (1092,1,17010729,0);
INSERT INTO `bcnm_battlefield` VALUES (1092,1,17010730,0);
INSERT INTO `bcnm_battlefield` VALUES (1092,1,17010731,0);
INSERT INTO `bcnm_battlefield` VALUES (1122,1,17039374,3); -- omens
INSERT INTO `bcnm_battlefield` VALUES (1122,1,17039375,2);
INSERT INTO `bcnm_battlefield` VALUES (1122,1,17039376,2);
INSERT INTO `bcnm_battlefield` VALUES (1122,1,17039377,2);
INSERT INTO `bcnm_battlefield` VALUES (1122,1,17039378,2);
INSERT INTO `bcnm_battlefield` VALUES (1122,1,17039379,2);
INSERT INTO `bcnm_battlefield` VALUES (1122,2,17039381,3);
INSERT INTO `bcnm_battlefield` VALUES (1122,2,17039382,2);
INSERT INTO `bcnm_battlefield` VALUES (1122,2,17039383,2);
INSERT INTO `bcnm_battlefield` VALUES (1122,2,17039384,2);
INSERT INTO `bcnm_battlefield` VALUES (1122,2,17039385,2);
INSERT INTO `bcnm_battlefield` VALUES (1122,2,17039386,2);
INSERT INTO `bcnm_battlefield` VALUES (1122,3,17039388,3);
INSERT INTO `bcnm_battlefield` VALUES (1122,3,17039389,2);
INSERT INTO `bcnm_battlefield` VALUES (1122,3,17039390,2);
INSERT INTO `bcnm_battlefield` VALUES (1122,3,17039391,2);
INSERT INTO `bcnm_battlefield` VALUES (1122,3,17039392,2);
INSERT INTO `bcnm_battlefield` VALUES (1122,3,17039393,2);
INSERT INTO `bcnm_battlefield` VALUES (1124,1,17039400,3); -- shield_of_diplomacy
INSERT INTO `bcnm_battlefield` VALUES (1156,1,17051694,3); -- puppet_in_peril

-- //////////////////////////////////////////////////////////////
--               APPOLYON  SE
-- //////////////////////////////////////////////////////////////
-- FIRST FLOOR
INSERT INTO `bcnm_battlefield` VALUES (1293,3,16932993,1);-- 'Metalloid_Amoeba'
INSERT INTO `bcnm_battlefield` VALUES (1293,3,16932994,1);-- 'Metalloid_Amoeba'
INSERT INTO `bcnm_battlefield` VALUES (1293,3,16932995,1);-- 'Metalloid_Amoeba'
INSERT INTO `bcnm_battlefield` VALUES (1293,3,16932996,1);-- 'Metalloid_Amoeba'
INSERT INTO `bcnm_battlefield` VALUES (1293,3,16932997,1);-- 'Metalloid_Amoeba'
INSERT INTO `bcnm_battlefield` VALUES (1293,3,16932998,1);-- 'Metalloid_Amoeba'
INSERT INTO `bcnm_battlefield` VALUES (1293,3,16932999,1);-- 'Metalloid_Amoeba'
INSERT INTO `bcnm_battlefield` VALUES (1293,3,16933000,1);-- 'Metalloid_Amoeba'
INSERT INTO `bcnm_battlefield` VALUES (1293,3,16932992,1);-- 'Ghost_Clot'
-- Second Floor
INSERT INTO `bcnm_battlefield` VALUES (1293,3,16933007,1);-- 'Adamantshell'
INSERT INTO `bcnm_battlefield` VALUES (1293,3,16933008,1);-- 'Adamantshell'
INSERT INTO `bcnm_battlefield` VALUES (1293,3,16933009,1);-- 'Adamantshell'
INSERT INTO `bcnm_battlefield` VALUES (1293,3,16933010,1);-- 'Adamantshell'
INSERT INTO `bcnm_battlefield` VALUES (1293,3,16933011,1);-- 'Adamantshell'
INSERT INTO `bcnm_battlefield` VALUES (1293,3,16933012,1);-- 'Adamantshell'
INSERT INTO `bcnm_battlefield` VALUES (1293,3,16933013,1);-- 'Adamantshell'
INSERT INTO `bcnm_battlefield` VALUES (1293,3,16933014,1);-- 'Adamantshell'
INSERT INTO `bcnm_battlefield` VALUES (1293,3,16933006,1);-- 'Tieholtsodi'
-- Third Floor
INSERT INTO `bcnm_battlefield` VALUES (1293,3,16933021,1);-- 'Inhumer'
INSERT INTO `bcnm_battlefield` VALUES (1293,3,16933022,1);-- 'Inhumer'
INSERT INTO `bcnm_battlefield` VALUES (1293,3,16933023,1);-- 'Inhumer'
INSERT INTO `bcnm_battlefield` VALUES (1293,3,16933024,1);-- 'Inhumer'
INSERT INTO `bcnm_battlefield` VALUES (1293,3,16933025,1);-- 'Inhumer'
INSERT INTO `bcnm_battlefield` VALUES (1293,3,16933026,1);-- 'Inhumer'
INSERT INTO `bcnm_battlefield` VALUES (1293,3,16933027,1);-- 'Inhumer'
INSERT INTO `bcnm_battlefield` VALUES (1293,3,16933028,1);-- 'Inhumer'
INSERT INTO `bcnm_battlefield` VALUES (1293,3,16933020,1);-- 'Grave_Digger'
-- Fourth Floor
INSERT INTO `bcnm_battlefield` VALUES (1293,3,16933032,2);-- 'Evil_Armory'
INSERT INTO `bcnm_battlefield` VALUES (1293,3,16933033,3);-- 'Flying_Spear'
INSERT INTO `bcnm_battlefield` VALUES (1293,3,16933034,3);-- 'Flying_Spear'
INSERT INTO `bcnm_battlefield` VALUES (1293,3,16933035,3);-- 'Flying_Spear'
INSERT INTO `bcnm_battlefield` VALUES (1293,3,16933036,3);-- 'Flying_Spear'
INSERT INTO `bcnm_battlefield` VALUES (1293,3,16933037,3);-- 'Flying_Spear'
INSERT INTO `bcnm_battlefield` VALUES (1293,3,16933038,3);-- 'Flying_Spear'
INSERT INTO `bcnm_battlefield` VALUES (1293,3,16933039,3);-- 'Flying_Spear'
INSERT INTO `bcnm_battlefield` VALUES (1293,3,16933040,3);-- 'Flying_Spear'

-- ----------------------------------------------------------------
-- //////////////////////////////////////////////////////////////
--               APPOLYON  NE
-- //////////////////////////////////////////////////////////////
INSERT INTO `bcnm_battlefield` VALUES (1292,4,16933044,1);-- 'Goobbue_Harvester'
INSERT INTO `bcnm_battlefield` VALUES (1292,4,16933045,1);-- 'Barometz'
INSERT INTO `bcnm_battlefield` VALUES (1292,4,16933046,1);-- 'Borametz'
INSERT INTO `bcnm_battlefield` VALUES (1292,4,16933047,1);-- 'Barometz'
INSERT INTO `bcnm_battlefield` VALUES (1292,4,16933048,1);-- 'Borametz'
INSERT INTO `bcnm_battlefield` VALUES (1292,4,16933049,1);-- 'Barometz'
INSERT INTO `bcnm_battlefield` VALUES (1292,4,16933050,1);-- 'Borametz'
INSERT INTO `bcnm_battlefield` VALUES (1292,4,16933051,1);-- 'Barometz'
INSERT INTO `bcnm_battlefield` VALUES (1292,4,16933052,1);-- 'Borametz'
INSERT INTO `bcnm_battlefield` VALUES (1292,4,16933055,1);-- 'Barometz'
INSERT INTO `bcnm_battlefield` VALUES (1292,4,16933056,1);-- 'Borametz'
INSERT INTO `bcnm_battlefield` VALUES (1292,4,16933057,1);-- 'Barometz'
INSERT INTO `bcnm_battlefield` VALUES (1292,4,16933058,1);-- 'Borametz'

INSERT INTO `bcnm_battlefield` VALUES (1292,4,16933062,1);-- 'Thiazi'
INSERT INTO `bcnm_battlefield` VALUES (1292,4,16933063,1);-- 'Thiazi'
INSERT INTO `bcnm_battlefield` VALUES (1292,4,16933064,1);-- 'Bialozar'
INSERT INTO `bcnm_battlefield` VALUES (1292,4,16933065,1);-- 'Bialozar'
INSERT INTO `bcnm_battlefield` VALUES (1292,4,16933066,1);-- 'Cornu'
INSERT INTO `bcnm_battlefield` VALUES (1292,4,16933067,1);-- 'Cornu'
INSERT INTO `bcnm_battlefield` VALUES (1292,4,16933068,1);-- 'Cornu'
INSERT INTO `bcnm_battlefield` VALUES (1292,4,16933069,1);-- 'Cornu'
INSERT INTO `bcnm_battlefield` VALUES (1292,4,16933070,1);-- 'Sirin'
INSERT INTO `bcnm_battlefield` VALUES (1292,4,16933071,1);-- 'Sirin'
INSERT INTO `bcnm_battlefield` VALUES (1292,4,16933072,1);-- 'Sirin'
INSERT INTO `bcnm_battlefield` VALUES (1292,4,16933073,1);-- 'Sirin'

INSERT INTO `bcnm_battlefield` VALUES (1292,4,16933081,1);-- 'Apollyon_Sweeper'
INSERT INTO `bcnm_battlefield` VALUES (1292,4,16933082,1);-- 'Apollyon_Cleaner'
INSERT INTO `bcnm_battlefield` VALUES (1292,4,16933083,1);-- 'Apollyon_Cleaner'
INSERT INTO `bcnm_battlefield` VALUES (1292,4,16933084,1);-- 'Apollyon_Cleaner'
INSERT INTO `bcnm_battlefield` VALUES (1292,4,16933085,1);-- 'Apollyon_Cleaner'
INSERT INTO `bcnm_battlefield` VALUES (1292,4,16933086,0);-- 'Apollyon_Sweeper'
INSERT INTO `bcnm_battlefield` VALUES (1292,4,16933087,0);-- 'Apollyon_Cleaner'
INSERT INTO `bcnm_battlefield` VALUES (1292,4,16933088,0);-- 'Apollyon_Cleaner'
INSERT INTO `bcnm_battlefield` VALUES (1292,4,16933089,0);-- 'Apollyon_Cleaner'
INSERT INTO `bcnm_battlefield` VALUES (1292,4,16933090,0);-- 'Apollyon_Cleaner'
INSERT INTO `bcnm_battlefield` VALUES (1292,4,16933091,0);-- 'Apollyon_Sweeper'
INSERT INTO `bcnm_battlefield` VALUES (1292,4,16933092,0);-- 'Apollyon_Cleaner'
INSERT INTO `bcnm_battlefield` VALUES (1292,4,16933093,0);-- 'Apollyon_Cleaner'
INSERT INTO `bcnm_battlefield` VALUES (1292,4,16933094,0);-- 'Apollyon_Cleaner'
INSERT INTO `bcnm_battlefield` VALUES (1292,4,16933095,0);-- 'Apollyon_Cleaner'

INSERT INTO `bcnm_battlefield` VALUES (1292,4,16933099,1);-- 'Hyperion'
INSERT INTO `bcnm_battlefield` VALUES (1292,4,16933100,1);-- 'Okeanos'
INSERT INTO `bcnm_battlefield` VALUES (1292,4,16933101,1);-- 'Cronos'
INSERT INTO `bcnm_battlefield` VALUES (1292,4,16933102,1);-- 'Kerkopes'
INSERT INTO `bcnm_battlefield` VALUES (1292,4,16933103,1);-- 'Kerkopes'
INSERT INTO `bcnm_battlefield` VALUES (1292,4,16933104,1);-- 'Kerkopes'
INSERT INTO `bcnm_battlefield` VALUES (1292,4,16933105,1);-- 'Kerkopes'
INSERT INTO `bcnm_battlefield` VALUES (1292,4,16933106,1);-- 'Kerkopes'
INSERT INTO `bcnm_battlefield` VALUES (1292,4,16933107,1);-- 'Kerkopes'
INSERT INTO `bcnm_battlefield` VALUES (1292,4,16933108,1);-- 'Kerkopes'
INSERT INTO `bcnm_battlefield` VALUES (1292,4,16933109,1);-- 'Kerkopes'

INSERT INTO `bcnm_battlefield` VALUES (1292,4,16933113,1);-- 'Criosphinx'
INSERT INTO `bcnm_battlefield` VALUES (1292,4,16933114,1);-- 'Hieracosphinx'
INSERT INTO `bcnm_battlefield` VALUES (1292,4,16933115,3);-- 'Troglodyte_Dhalmel'
INSERT INTO `bcnm_battlefield` VALUES (1292,4,16933116,3);-- 'Troglodyte_Dhalmel'
INSERT INTO `bcnm_battlefield` VALUES (1292,4,16933117,3);-- 'Troglodyte_Dhalmel'
INSERT INTO `bcnm_battlefield` VALUES (1292,4,16933118,3);-- 'Troglodyte_Dhalmel'
INSERT INTO `bcnm_battlefield` VALUES (1292,4,16933119,3);-- 'Troglodyte_Dhalmel'
INSERT INTO `bcnm_battlefield` VALUES (1292,4,16933120,3);-- 'Troglodyte_Dhalmel'
INSERT INTO `bcnm_battlefield` VALUES (1292,4,16933121,3);-- 'Troglodyte_Dhalmel'
INSERT INTO `bcnm_battlefield` VALUES (1292,4,16933122,3);-- 'Troglodyte_Dhalmel'
-- //////////////////////////////////////////////////////////////
--               APPOLYON  SW
-- //////////////////////////////////////////////////////////////
INSERT INTO `bcnm_battlefield` VALUES (1291,1,16932868,1);-- 'FirBholg'
INSERT INTO `bcnm_battlefield` VALUES (1291,1,16932869,1);-- 'FirBholg'
INSERT INTO `bcnm_battlefield` VALUES (1291,1,16932870,1);-- 'FirBholg'
INSERT INTO `bcnm_battlefield` VALUES (1291,1,16932871,1);-- 'FirBholg'
INSERT INTO `bcnm_battlefield` VALUES (1291,1,16932872,1);-- 'FirBholg'
INSERT INTO `bcnm_battlefield` VALUES (1291,1,16932873,1);-- 'FirBholg'
INSERT INTO `bcnm_battlefield` VALUES (1291,1,16932874,1);-- 'FirBholg'
INSERT INTO `bcnm_battlefield` VALUES (1291,1,16932875,1);-- 'FirBholg'
INSERT INTO `bcnm_battlefield` VALUES (1291,1,16932876,1);-- 'FirBholg'
INSERT INTO `bcnm_battlefield` VALUES (1291,1,16932877,1);-- 'FirBholg'

INSERT INTO `bcnm_battlefield` VALUES (1291,1,16932881,1);-- 'Jidra'
INSERT INTO `bcnm_battlefield` VALUES (1291,1,16932882,1);-- 'Jidra'
INSERT INTO `bcnm_battlefield` VALUES (1291,1,16932883,1);-- 'Jidra'
INSERT INTO `bcnm_battlefield` VALUES (1291,1,16932884,1);-- 'Jidra'
INSERT INTO `bcnm_battlefield` VALUES (1291,1,16932885,1);-- 'Jidra'
INSERT INTO `bcnm_battlefield` VALUES (1291,1,16932886,1);-- 'Jidra'
INSERT INTO `bcnm_battlefield` VALUES (1291,1,16932887,1);-- 'Jidra'
INSERT INTO `bcnm_battlefield` VALUES (1291,1,16932888,1);-- 'Jidra'

INSERT INTO `bcnm_battlefield` VALUES (1291,1,16932889,0);-- 'Arboricole_Hornet'
INSERT INTO `bcnm_battlefield` VALUES (1291,1,16932890,0);-- 'Arboricole_Raven'
INSERT INTO `bcnm_battlefield` VALUES (1291,1,16932891,0);-- 'Arboricole_Opo-opo'
INSERT INTO `bcnm_battlefield` VALUES (1291,1,16932892,0);-- 'Arboricole_Spider'
INSERT INTO `bcnm_battlefield` VALUES (1291,1,16932893,0);-- 'Arboricole_Beetle'
INSERT INTO `bcnm_battlefield` VALUES (1291,1,16932894,0);-- 'Arboricole_Crawler'
INSERT INTO `bcnm_battlefield` VALUES (1291,1,16932895,0);-- 'Apollyon_Sapling'

INSERT INTO `bcnm_battlefield` VALUES (1291,1,16932896,0);-- 'Armoury_Crate'
INSERT INTO `bcnm_battlefield` VALUES (1291,1,16932897,0);-- 'Armoury_Crate'
INSERT INTO `bcnm_battlefield` VALUES (1291,1,16932898,0);-- 'Armoury_Crate'

INSERT INTO `bcnm_battlefield` VALUES (1291,1,16932910,1);-- 'Air_Elemental'
INSERT INTO `bcnm_battlefield` VALUES (1291,1,16932911,1);-- 'Dark_Elemental'
INSERT INTO `bcnm_battlefield` VALUES (1291,1,16932912,1);-- 'Earth_Elemental'
INSERT INTO `bcnm_battlefield` VALUES (1291,1,16932913,1);-- 'Fire_Elemental'
INSERT INTO `bcnm_battlefield` VALUES (1291,1,16932914,1);-- 'Ice_Elemental'
INSERT INTO `bcnm_battlefield` VALUES (1291,1,16932915,1);-- 'Light_Elemental'
INSERT INTO `bcnm_battlefield` VALUES (1291,1,16932916,1);-- 'Water_Elemental'
INSERT INTO `bcnm_battlefield` VALUES (1291,1,16932917,1);-- 'ThunderElement'
INSERT INTO `bcnm_battlefield` VALUES (1291,1,16932918,1);-- 'Air_Elemental'
INSERT INTO `bcnm_battlefield` VALUES (1291,1,16932919,1);-- 'Dark_Elemental'
INSERT INTO `bcnm_battlefield` VALUES (1291,1,16932920,1);-- 'Earth_Elemental'
INSERT INTO `bcnm_battlefield` VALUES (1291,1,16932921,1);-- 'Fire_Elemental'
INSERT INTO `bcnm_battlefield` VALUES (1291,1,16932922,1);-- 'Ice_Elemental'
INSERT INTO `bcnm_battlefield` VALUES (1291,1,16932923,1);-- 'Light_Elemental'
INSERT INTO `bcnm_battlefield` VALUES (1291,1,16932924,1);-- 'Water_Elemental'
INSERT INTO `bcnm_battlefield` VALUES (1291,1,16932925,1);-- 'ThunderElement'
INSERT INTO `bcnm_battlefield` VALUES (1291,1,16932926,1);-- 'Air_Elemental'
INSERT INTO `bcnm_battlefield` VALUES (1291,1,16932927,1);-- 'Dark_Elemental'
INSERT INTO `bcnm_battlefield` VALUES (1291,1,16932928,1);-- 'Earth_Elemental'
INSERT INTO `bcnm_battlefield` VALUES (1291,1,16932929,1);-- 'Fire_Elemental'
INSERT INTO `bcnm_battlefield` VALUES (1291,1,16932930,1);-- 'Ice_Elemental'
INSERT INTO `bcnm_battlefield` VALUES (1291,1,16932931,1);-- 'Light_Elemental'
INSERT INTO `bcnm_battlefield` VALUES (1291,1,16932932,1);-- 'Water_Elemental'
INSERT INTO `bcnm_battlefield` VALUES (1291,1,16932933,1);-- 'Thunder_Elemental'
-- //////////////////////////////////////////////////////////////
--               APPOLYON NW
-- //////////////////////////////////////////////////////////////
INSERT INTO `bcnm_battlefield` VALUES (1290,2,16932937,1);-- 'Pluto'
INSERT INTO `bcnm_battlefield` VALUES (1290,2,16932938,1);-- 'Bardha'
INSERT INTO `bcnm_battlefield` VALUES (1290,2,16932939,1);-- 'Bardha'
INSERT INTO `bcnm_battlefield` VALUES (1290,2,16932940,1);-- 'Bardha'
INSERT INTO `bcnm_battlefield` VALUES (1290,2,16932941,1);-- 'Bardha'
INSERT INTO `bcnm_battlefield` VALUES (1290,2,16932942,1);-- 'Bardha'
INSERT INTO `bcnm_battlefield` VALUES (1290,2,16932943,1);-- 'Bardha'
INSERT INTO `bcnm_battlefield` VALUES (1290,2,16932944,1);-- 'Bardha'
INSERT INTO `bcnm_battlefield` VALUES (1290,2,16932950,1);-- 'Zlatorog'
INSERT INTO `bcnm_battlefield` VALUES (1290,2,16932951,1);-- 'Mountain_Buffalo'
INSERT INTO `bcnm_battlefield` VALUES (1290,2,16932952,1);-- 'Mountain_Buffalo'
INSERT INTO `bcnm_battlefield` VALUES (1290,2,16932953,1);-- 'Mountain_Buffalo'
INSERT INTO `bcnm_battlefield` VALUES (1290,2,16932954,1);-- 'Mountain_Buffalo'
INSERT INTO `bcnm_battlefield` VALUES (1290,2,16932955,1);-- 'Mountain_Buffalo'
INSERT INTO `bcnm_battlefield` VALUES (1290,2,16932956,1);-- 'Mountain_Buffalo'
INSERT INTO `bcnm_battlefield` VALUES (1290,2,16932957,1);-- 'Mountain_Buffalo'
INSERT INTO `bcnm_battlefield` VALUES (1290,2,16932963,1);-- 'Millenary_Mossback'
INSERT INTO `bcnm_battlefield` VALUES (1290,2,16932964,1);-- 'Apollyon_Scavenger'
INSERT INTO `bcnm_battlefield` VALUES (1290,2,16932965,1);-- 'Apollyon_Scavenger'
INSERT INTO `bcnm_battlefield` VALUES (1290,2,16932966,1);-- 'Apollyon_Scavenger'
INSERT INTO `bcnm_battlefield` VALUES (1290,2,16932967,1);-- 'Apollyon_Scavenger'
INSERT INTO `bcnm_battlefield` VALUES (1290,2,16932968,1);-- 'Apollyon_Scavenger'
INSERT INTO `bcnm_battlefield` VALUES (1290,2,16932969,1);-- 'Apollyon_Scavenger'
INSERT INTO `bcnm_battlefield` VALUES (1290,2,16932970,1);-- 'Apollyon_Scavenger'
INSERT INTO `bcnm_battlefield` VALUES (1290,2,16932976,1);-- 'Cynoprosopi'
INSERT INTO `bcnm_battlefield` VALUES (1290,2,16932977,1);-- 'Gorynich'
INSERT INTO `bcnm_battlefield` VALUES (1290,2,16932978,1);-- 'Gorynich'
INSERT INTO `bcnm_battlefield` VALUES (1290,2,16932979,1);-- 'Gorynich'
INSERT INTO `bcnm_battlefield` VALUES (1290,2,16932980,1);-- 'Gorynich'
INSERT INTO `bcnm_battlefield` VALUES (1290,2,16932981,1);-- 'Gorynich'
INSERT INTO `bcnm_battlefield` VALUES (1290,2,16932985,3);-- 'Kaiser_Behemoth'
INSERT INTO `bcnm_battlefield` VALUES (1290,2,16932986,1);-- 'Kronprinz_Behemoth'
INSERT INTO `bcnm_battlefield` VALUES (1290,2,16932987,1);-- 'Kronprinz_Behemoth'
INSERT INTO `bcnm_battlefield` VALUES (1290,2,16932988,1);-- 'Kronprinz_Behemoth'
-- //////////////////////////////////////////////////////////////
--               APPOLYON CS
-- //////////////////////////////////////////////////////////////
INSERT INTO `bcnm_battlefield` VALUES (1294,6,16933129,3);-- 'Carnagechief_Jackbodokk'
INSERT INTO `bcnm_battlefield` VALUES (1294,6,16933130,0);-- 'Grognard Mesmerizer'
INSERT INTO `bcnm_battlefield` VALUES (1294,6,16933131,0);-- 'Grognard Neckchopper'
INSERT INTO `bcnm_battlefield` VALUES (1294,6,16933132,0);-- 'Grognard Footsoldier'
INSERT INTO `bcnm_battlefield` VALUES (1294,6,16933133,0);-- 'Grognard Grappler'
INSERT INTO `bcnm_battlefield` VALUES (1294,6,16933134,0);-- 'Grognard Predator'
INSERT INTO `bcnm_battlefield` VALUES (1294,6,16933135,0);-- 'Grognard Impaler'
INSERT INTO `bcnm_battlefield` VALUES (1294,6,16933136,0);-- 'Orc's Wyvern'
INSERT INTO `bcnm_battlefield` VALUES (1294,6,16933137,3);-- 'Na QbaChirurge'
INSERT INTO `bcnm_battlefield` VALUES (1294,6,16933138,0);-- 'Star Ruby Quadav'
INSERT INTO `bcnm_battlefield` VALUES (1294,6,16933139,0);-- 'Wootz Quadav'
INSERT INTO `bcnm_battlefield` VALUES (1294,6,16933140,0);-- 'Fossil Quadav'
INSERT INTO `bcnm_battlefield` VALUES (1294,6,16933141,0);-- 'Star Sapphire Quadav'
INSERT INTO `bcnm_battlefield` VALUES (1294,6,16933142,0);-- 'Whitegold Quadav'
INSERT INTO `bcnm_battlefield` VALUES (1294,6,16933143,0);-- 'Lightsteel Quadav'
INSERT INTO `bcnm_battlefield` VALUES (1294,6,16933144,3);-- 'DeeWapatheDe'
INSERT INTO `bcnm_battlefield` VALUES (1294,6,16933145,1);-- 'Yagudo's Elemental'
INSERT INTO `bcnm_battlefield` VALUES (1294,6,16933146,0);-- 'Yagudo's Avatar'
INSERT INTO `bcnm_battlefield` VALUES (1294,6,16933147,0);-- 'Yagudo Archpriest'
INSERT INTO `bcnm_battlefield` VALUES (1294,6,16933148,0);-- 'Yagudo Knight Templar'
INSERT INTO `bcnm_battlefield` VALUES (1294,6,16933149,0);-- 'Yagudo Disciplinant'
INSERT INTO `bcnm_battlefield` VALUES (1294,6,16933150,0);-- 'Yagudo Prelatess'
INSERT INTO `bcnm_battlefield` VALUES (1294,6,16933151,0);-- 'Yagudo Kapellmeister'
INSERT INTO `bcnm_battlefield` VALUES (1294,6,16933152,0);-- 'Yagudo Eradicator'
-- //////////////////////////////////////////////////////////////
--               APPOLYON CENTRAL
-- //////////////////////////////////////////////////////////////
INSERT INTO `bcnm_battlefield` VALUES (1296,5,16933124,3);-- 'Proto-Omega'
INSERT INTO `bcnm_battlefield` VALUES (1296,5,16933125,0);-- 'Gunpod'
-- ------------------------------------
-- ------Temenos - Northern Tower
-- ------------------------------------
INSERT INTO `bcnm_battlefield` VALUES (1299,1,16928772,1);-- Goblin Slaughterman
INSERT INTO `bcnm_battlefield` VALUES (1299,1,16928773,1);-- Goblin Slaughterman
INSERT INTO `bcnm_battlefield` VALUES (1299,1,16928774,1);-- Moblin Dustman
INSERT INTO `bcnm_battlefield` VALUES (1299,1,16928775,1);-- Moblin Dustman
INSERT INTO `bcnm_battlefield` VALUES (1299,1,16928776,1);-- Moblin Dustman
INSERT INTO `bcnm_battlefield` VALUES (1299,1,16928777,1);-- Moblin Dustman
INSERT INTO `bcnm_battlefield` VALUES (1299,1,16928781,1);-- Skadi
INSERT INTO `bcnm_battlefield` VALUES (1299,1,16928782,1);-- Thrym
INSERT INTO `bcnm_battlefield` VALUES (1299,1,16928783,1);-- Beli
INSERT INTO `bcnm_battlefield` VALUES (1299,1,16928784,1);-- Kari
INSERT INTO `bcnm_battlefield` VALUES (1299,1,16928788,1);-- Telchines Bard
INSERT INTO `bcnm_battlefield` VALUES (1299,1,16928789,1);-- Telchines White Mage
INSERT INTO `bcnm_battlefield` VALUES (1299,1,16928790,1);-- Telchines Dragoon
INSERT INTO `bcnm_battlefield` VALUES (1299,1,16928791,1);-- Telchines's Wyvern
INSERT INTO `bcnm_battlefield` VALUES (1299,1,16928792,1);-- Telchines Monk
INSERT INTO `bcnm_battlefield` VALUES (1299,1,16928793,1);-- Telchines Monk
INSERT INTO `bcnm_battlefield` VALUES (1299,1,16928797,1);-- Kindred Warrior
INSERT INTO `bcnm_battlefield` VALUES (1299,1,16928798,1);-- Kindred Dark Knight
INSERT INTO `bcnm_battlefield` VALUES (1299,1,16928799,1);-- Kindred Summoner
INSERT INTO `bcnm_battlefield` VALUES (1299,1,16928800,1);-- Kindred's Elemental
INSERT INTO `bcnm_battlefield` VALUES (1299,1,16928801,0);-- Kindred's Avatar
INSERT INTO `bcnm_battlefield` VALUES (1299,1,16928802,1);-- Kindred Black Mage
INSERT INTO `bcnm_battlefield` VALUES (1299,1,16928803,1);-- Kindred Black Mage
INSERT INTO `bcnm_battlefield` VALUES (1299,1,16928804,1);-- Kindred Black Mage
INSERT INTO `bcnm_battlefield` VALUES (1299,1,16928805,1);-- Kindred Black Mage
INSERT INTO `bcnm_battlefield` VALUES (1299,1,16928809,1);-- Praetorian Guard CCXX
INSERT INTO `bcnm_battlefield` VALUES (1299,1,16928810,1);-- Praetorian Guard LXXIII
INSERT INTO `bcnm_battlefield` VALUES (1299,1,16928811,1);-- Praetorian Guard CXLVIII
INSERT INTO `bcnm_battlefield` VALUES (1299,1,16928812,1);-- Praetorian Guard CCCXI
INSERT INTO `bcnm_battlefield` VALUES (1299,1,16928816,1);-- Cryptonberry Charmer
INSERT INTO `bcnm_battlefield` VALUES (1299,1,16928817,1);-- Cryptonberry Skulker
INSERT INTO `bcnm_battlefield` VALUES (1299,1,16928818,1);-- Cryptonberry Abductor
INSERT INTO `bcnm_battlefield` VALUES (1299,1,16928819,1);-- Cryptonberry Designator
INSERT INTO `bcnm_battlefield` VALUES (1299,1,16928820,1);-- Tonberry's Elemental
INSERT INTO `bcnm_battlefield` VALUES (1299,1,16928821,0);-- Tonberry's Avatar
INSERT INTO `bcnm_battlefield` VALUES (1299,1,16928822,1);-- Cryptonberry Abductor
INSERT INTO `bcnm_battlefield` VALUES (1299,1,16928823,1);-- Cryptonberry Designator
INSERT INTO `bcnm_battlefield` VALUES (1299,1,16928824,1);-- Tonberry's Elemental
INSERT INTO `bcnm_battlefield` VALUES (1299,1,16928825,0);-- Tonberry's Avatar
INSERT INTO `bcnm_battlefield` VALUES (1299,1,16928826,1);-- Cryptonberry Abductor
INSERT INTO `bcnm_battlefield` VALUES (1299,1,16928827,1);-- Cryptonberry Designator
INSERT INTO `bcnm_battlefield` VALUES (1299,1,16928828,1);-- Tonberry's Elemental
INSERT INTO `bcnm_battlefield` VALUES (1299,1,16928829,0);-- Tonberry's Avatar
INSERT INTO `bcnm_battlefield` VALUES (1299,1,16928831,3);-- Goblin Warlord
INSERT INTO `bcnm_battlefield` VALUES (1299,1,16928832,3);-- Goblin Fencer
INSERT INTO `bcnm_battlefield` VALUES (1299,1,16928833,3);-- Goblin Theurgist
INSERT INTO `bcnm_battlefield` VALUES (1299,1,16928834,3);-- Goblin Fencer
INSERT INTO `bcnm_battlefield` VALUES (1299,1,16928835,3);-- Goblin Theurgist
-- ------------------------
-- --Temenos - Eastern Tower
-- ------------------------
INSERT INTO `bcnm_battlefield` VALUES (1300,2,16928840,1);-- Fire Elemental
INSERT INTO `bcnm_battlefield` VALUES (1300,2,16928841,1);-- Fire Elemental
INSERT INTO `bcnm_battlefield` VALUES (1300,2,16928842,1);-- Fire Elemental
INSERT INTO `bcnm_battlefield` VALUES (1300,2,16928843,1);-- Fire Elemental
INSERT INTO `bcnm_battlefield` VALUES (1300,2,16928844,0);-- Mystic Avatar
INSERT INTO `bcnm_battlefield` VALUES (1300,2,16928849,1);-- Ice Elemental
INSERT INTO `bcnm_battlefield` VALUES (1300,2,16928850,1);-- Ice Elemental
INSERT INTO `bcnm_battlefield` VALUES (1300,2,16928851,1);-- Ice Elemental
INSERT INTO `bcnm_battlefield` VALUES (1300,2,16928852,1);-- Ice Elemental
INSERT INTO `bcnm_battlefield` VALUES (1300,2,16928853,0);-- Mystic Avatar
INSERT INTO `bcnm_battlefield` VALUES (1300,2,16928858,1);-- Air Elemental
INSERT INTO `bcnm_battlefield` VALUES (1300,2,16928859,1);-- Air Elemental
INSERT INTO `bcnm_battlefield` VALUES (1300,2,16928860,1);-- Air Elemental
INSERT INTO `bcnm_battlefield` VALUES (1300,2,16928861,1);-- Air Elemental
INSERT INTO `bcnm_battlefield` VALUES (1300,2,16928862,0);-- Mystic Avatar
INSERT INTO `bcnm_battlefield` VALUES (1300,2,16928867,1);-- Earth Elemental
INSERT INTO `bcnm_battlefield` VALUES (1300,2,16928868,1);-- Earth Elemental
INSERT INTO `bcnm_battlefield` VALUES (1300,2,16928869,1);-- Earth Elemental
INSERT INTO `bcnm_battlefield` VALUES (1300,2,16928870,1);-- Earth Elemental
INSERT INTO `bcnm_battlefield` VALUES (1300,2,16928871,0);-- Mystic Avatar
INSERT INTO `bcnm_battlefield` VALUES (1300,2,16928876,1);-- Thunder Elemental
INSERT INTO `bcnm_battlefield` VALUES (1300,2,16928877,1);-- Thunder Elemental
INSERT INTO `bcnm_battlefield` VALUES (1300,2,16928878,1);-- Thunder Elemental
INSERT INTO `bcnm_battlefield` VALUES (1300,2,16928879,1);-- Thunder Elemental
INSERT INTO `bcnm_battlefield` VALUES (1300,2,16928880,0);-- Mystic Avatar
INSERT INTO `bcnm_battlefield` VALUES (1300,2,16928885,1);-- Water Elemental
INSERT INTO `bcnm_battlefield` VALUES (1300,2,16928886,1);-- Water Elemental
INSERT INTO `bcnm_battlefield` VALUES (1300,2,16928887,1);-- Water Elemental
INSERT INTO `bcnm_battlefield` VALUES (1300,2,16928888,1);-- Water Elemental
INSERT INTO `bcnm_battlefield` VALUES (1300,2,16928889,0);-- Mystic Avatar
INSERT INTO `bcnm_battlefield` VALUES (1300,2,16928892,3);-- Dark Elemental
INSERT INTO `bcnm_battlefield` VALUES (1300,2,16928893,3);-- Dark Elemental
INSERT INTO `bcnm_battlefield` VALUES (1300,2,16928894,0);-- Mystic Avatar
-- ------------------------
-- Temenos - Western Tower
-- ------------------------
INSERT INTO `bcnm_battlefield` VALUES (1298,3,16928898,1);-- Enhanced Tiger
INSERT INTO `bcnm_battlefield` VALUES (1298,3,16928899,1);-- Enhanced Tiger
INSERT INTO `bcnm_battlefield` VALUES (1298,3,16928900,1);-- Enhanced Tiger
INSERT INTO `bcnm_battlefield` VALUES (1298,3,16928901,1);-- Enhanced Tiger
INSERT INTO `bcnm_battlefield` VALUES (1298,3,16928902,1);-- Enhanced Tiger
INSERT INTO `bcnm_battlefield` VALUES (1298,3,16928903,1);-- Enhanced Tiger
INSERT INTO `bcnm_battlefield` VALUES (1298,3,16928904,1);-- Enhanced Tiger
INSERT INTO `bcnm_battlefield` VALUES (1298,3,16928905,1);-- Enhanced Tiger
INSERT INTO `bcnm_battlefield` VALUES (1298,3,16928906,1);-- Enhanced Tiger
INSERT INTO `bcnm_battlefield` VALUES (1298,3,16928910,1);-- Enhanced Mandragora
INSERT INTO `bcnm_battlefield` VALUES (1298,3,16928911,1);-- Enhanced Mandragora
INSERT INTO `bcnm_battlefield` VALUES (1298,3,16928912,1);-- Enhanced Mandragora
INSERT INTO `bcnm_battlefield` VALUES (1298,3,16928913,1);-- Enhanced Mandragora
INSERT INTO `bcnm_battlefield` VALUES (1298,3,16928914,1);-- Enhanced Mandragora
INSERT INTO `bcnm_battlefield` VALUES (1298,3,16928915,1);-- Enhanced Mandragora
INSERT INTO `bcnm_battlefield` VALUES (1298,3,16928916,1);-- Enhanced Mandragora
INSERT INTO `bcnm_battlefield` VALUES (1298,3,16928917,1);-- Enhanced Mandragora
INSERT INTO `bcnm_battlefield` VALUES (1298,3,16928918,1);-- Enhanced Mandragora
INSERT INTO `bcnm_battlefield` VALUES (1298,3,16928922,1);-- Enhanced Beetle
INSERT INTO `bcnm_battlefield` VALUES (1298,3,16928923,1);-- Enhanced Beetle
INSERT INTO `bcnm_battlefield` VALUES (1298,3,16928924,1);-- Enhanced Beetle
INSERT INTO `bcnm_battlefield` VALUES (1298,3,16928925,1);-- Enhanced Beetle
INSERT INTO `bcnm_battlefield` VALUES (1298,3,16928926,1);-- Enhanced Beetle
INSERT INTO `bcnm_battlefield` VALUES (1298,3,16928927,1);-- Enhanced Beetle
INSERT INTO `bcnm_battlefield` VALUES (1298,3,16928931,1);-- Enhanced Lizard
INSERT INTO `bcnm_battlefield` VALUES (1298,3,16928932,1);-- Enhanced Lizard
INSERT INTO `bcnm_battlefield` VALUES (1298,3,16928933,1);-- Enhanced Lizard
INSERT INTO `bcnm_battlefield` VALUES (1298,3,16928934,1);-- Enhanced Lizard
INSERT INTO `bcnm_battlefield` VALUES (1298,3,16928935,1);-- Enhanced Lizard
INSERT INTO `bcnm_battlefield` VALUES (1298,3,16928936,1);-- Enhanced Lizard
INSERT INTO `bcnm_battlefield` VALUES (1298,3,16928937,1);-- Enhanced Lizard
INSERT INTO `bcnm_battlefield` VALUES (1298,3,16928938,1);-- Enhanced Lizard
INSERT INTO `bcnm_battlefield` VALUES (1298,3,16928939,1);-- Enhanced Lizard
INSERT INTO `bcnm_battlefield` VALUES (1298,3,16928943,1);-- Enhanced Slime
INSERT INTO `bcnm_battlefield` VALUES (1298,3,16928944,1);-- Enhanced Slime
INSERT INTO `bcnm_battlefield` VALUES (1298,3,16928945,1);-- Enhanced Slime
INSERT INTO `bcnm_battlefield` VALUES (1298,3,16928946,1);-- Enhanced Slime
INSERT INTO `bcnm_battlefield` VALUES (1298,3,16928947,1);-- Enhanced Slime
INSERT INTO `bcnm_battlefield` VALUES (1298,3,16928948,1);-- Enhanced Slime
INSERT INTO `bcnm_battlefield` VALUES (1298,3,16928952,1);-- Enhanced Pugil
INSERT INTO `bcnm_battlefield` VALUES (1298,3,16928953,1);-- Enhanced Pugil
INSERT INTO `bcnm_battlefield` VALUES (1298,3,16928954,1);-- Enhanced Pugil
INSERT INTO `bcnm_battlefield` VALUES (1298,3,16928955,1);-- Enhanced Pugil
INSERT INTO `bcnm_battlefield` VALUES (1298,3,16928956,1);-- Enhanced Pugil
INSERT INTO `bcnm_battlefield` VALUES (1298,3,16928957,1);-- Enhanced Pugil
INSERT INTO `bcnm_battlefield` VALUES (1298,3,16928959,3);-- Enhanced Vulture
INSERT INTO `bcnm_battlefield` VALUES (1298,3,16928960,3);-- Enhanced Vulture
INSERT INTO `bcnm_battlefield` VALUES (1298,3,16928961,3);-- Enhanced Vulture
INSERT INTO `bcnm_battlefield` VALUES (1298,3,16928962,3);-- Enhanced Vulture
INSERT INTO `bcnm_battlefield` VALUES (1298,3,16928963,3);-- Enhanced Vulture
INSERT INTO `bcnm_battlefield` VALUES (1298,3,16928964,3);-- Enhanced Vulture
-- ----------------------------
-- Central Temenos - 4th Floor
-- ----------------------------
INSERT INTO `bcnm_battlefield` VALUES (1306,4,16928966,3);-- Proto-Ultima
INSERT INTO `bcnm_battlefield` VALUES (1306,4,16928986,0);-- Kingslayer Doggvdegg
INSERT INTO `bcnm_battlefield` VALUES (1306,4,16928987,0);-- Ji'Gho Ageless
INSERT INTO `bcnm_battlefield` VALUES (1306,4,16928988,0);-- Koo Buzu the Theomanic
INSERT INTO `bcnm_battlefield` VALUES (1306,4,16928989,0);-- Yagudo's Elemental
INSERT INTO `bcnm_battlefield` VALUES (1306,4,16928990,0);-- Yagudo's Avatar
INSERT INTO `bcnm_battlefield` VALUES (1306,4,16928991,0);-- Mystic Avatar
INSERT INTO `bcnm_battlefield` VALUES (1306,4,16928992,0);-- Mystic Avatar
INSERT INTO `bcnm_battlefield` VALUES (1306,4,16928993,0);-- Mystic Avatar
INSERT INTO `bcnm_battlefield` VALUES (1306,4,16928994,0);-- Mystic Avatar
INSERT INTO `bcnm_battlefield` VALUES (1306,4,16928995,0);-- Mystic Avatar
INSERT INTO `bcnm_battlefield` VALUES (1306,4,16928996,0);-- Mystic Avatar
INSERT INTO `bcnm_battlefield` VALUES (1306,4,16928997,0);-- Enhanced Koenigstiger
INSERT INTO `bcnm_battlefield` VALUES (1306,4,16928998,0);-- Enhanced Pygmaioi
INSERT INTO `bcnm_battlefield` VALUES (1306,4,16928999,0);-- Enhanced Kettenkaefer
INSERT INTO `bcnm_battlefield` VALUES (1306,4,16929000,0);-- Enhanced Salamander
INSERT INTO `bcnm_battlefield` VALUES (1306,4,16929001,0);-- Enhanced Jelly
INSERT INTO `bcnm_battlefield` VALUES (1306,4,16929002,0);-- Enhanced Makara
INSERT INTO `bcnm_battlefield` VALUES (1306,4,16929003,0);-- Enhanced Akbaba
-- --------------------------------
-- Central Temenos - 3rd Floor
-- --------------------------------
INSERT INTO `bcnm_battlefield` VALUES (1305,5,16929005,3);-- Abyssdweller Jhabdebb
INSERT INTO `bcnm_battlefield` VALUES (1305,5,16929006,3);-- Orichalcum Quadav
INSERT INTO `bcnm_battlefield` VALUES (1305,5,16929007,3);-- Pee Qoho the Python
INSERT INTO `bcnm_battlefield` VALUES (1305,5,16929008,1);-- Yagudo's Elemental
INSERT INTO `bcnm_battlefield` VALUES (1305,5,16929009,0);-- Yagudo's Avatar
INSERT INTO `bcnm_battlefield` VALUES (1305,5,16929010,1);-- Grognard Mesmerizer
INSERT INTO `bcnm_battlefield` VALUES (1305,5,16929011,1);-- Grognard Footsoldier
INSERT INTO `bcnm_battlefield` VALUES (1305,5,16929012,1);-- Grognard Predator
INSERT INTO `bcnm_battlefield` VALUES (1305,5,16929013,1);-- Grognard Neckchopper
INSERT INTO `bcnm_battlefield` VALUES (1305,5,16929014,1);-- Grognard Grappler
INSERT INTO `bcnm_battlefield` VALUES (1305,5,16929015,1);-- Grognard Impaler
INSERT INTO `bcnm_battlefield` VALUES (1305,5,16929016,1);-- Orc's Wyvern
INSERT INTO `bcnm_battlefield` VALUES (1305,5,16929017,1);-- Star Ruby Quadav
INSERT INTO `bcnm_battlefield` VALUES (1305,5,16929018,1);-- Fossil Quadav
INSERT INTO `bcnm_battlefield` VALUES (1305,5,16929019,1);-- Whitegold Quadav
INSERT INTO `bcnm_battlefield` VALUES (1305,5,16929020,1);-- Wootz Quadav
INSERT INTO `bcnm_battlefield` VALUES (1305,5,16929021,1);-- Star Sapphire Quadav
INSERT INTO `bcnm_battlefield` VALUES (1305,5,16929022,1);-- Lightsteel Quadav
INSERT INTO `bcnm_battlefield` VALUES (1305,5,16929023,1);-- Yagudo Archpriest
INSERT INTO `bcnm_battlefield` VALUES (1305,5,16929024,1);-- Yagudo Disciplinant
INSERT INTO `bcnm_battlefield` VALUES (1305,5,16929025,1);-- Yagudo Kapellmeister
INSERT INTO `bcnm_battlefield` VALUES (1305,5,16929026,1);-- Yagudo Knight Templar
INSERT INTO `bcnm_battlefield` VALUES (1305,5,16929027,1);-- Yagudo Prelatess
INSERT INTO `bcnm_battlefield` VALUES (1305,5,16929028,1);-- Yagudo Eradicator
-- -----------------------------
-- Central Temenos - 2nd Floor
-- ------------------------------
INSERT INTO `bcnm_battlefield` VALUES (1304,6,16929030,3);-- Mystic Avatar
INSERT INTO `bcnm_battlefield` VALUES (1304,6,16929031,3);-- Light Elemental
INSERT INTO `bcnm_battlefield` VALUES (1304,6,16929032,3);-- Light Elemental
INSERT INTO `bcnm_battlefield` VALUES (1304,6,16929033,1);-- Fire Elemental
INSERT INTO `bcnm_battlefield` VALUES (1304,6,16929034,1);-- Ice Elemental
INSERT INTO `bcnm_battlefield` VALUES (1304,6,16929035,1);-- Air Elemental
INSERT INTO `bcnm_battlefield` VALUES (1304,6,16929036,1);-- Earth Elemental
INSERT INTO `bcnm_battlefield` VALUES (1304,6,16929037,1);-- Thunder Elemental
INSERT INTO `bcnm_battlefield` VALUES (1304,6,16929038,1);-- Water Elemental
INSERT INTO `bcnm_battlefield` VALUES (1304,6,16929039,0);-- Mystic Avatar
INSERT INTO `bcnm_battlefield` VALUES (1304,6,16929040,0);-- Mystic Avatar
INSERT INTO `bcnm_battlefield` VALUES (1304,6,16929041,0);-- Mystic Avatar
INSERT INTO `bcnm_battlefield` VALUES (1304,6,16929042,0);-- Mystic Avatar
INSERT INTO `bcnm_battlefield` VALUES (1304,6,16929043,0);-- Mystic Avatar
INSERT INTO `bcnm_battlefield` VALUES (1304,6,16929044,0);-- Mystic Avatar
-- -----------------------------
-- Central Temenos - 1st Floor
-- -----------------------------
INSERT INTO `bcnm_battlefield` VALUES (1303,7,16929046,3);-- Airi
INSERT INTO `bcnm_battlefield` VALUES (1303,7,16929047,3);-- Temenos Cleaner
INSERT INTO `bcnm_battlefield` VALUES (1303,7,16929048,3);-- Iruci
INSERT INTO `bcnm_battlefield` VALUES (1303,7,16929049,3);-- Temenos Weapon
INSERT INTO `bcnm_battlefield` VALUES (1303,7,16929050,3);-- Enhanced Dragon
INSERT INTO `bcnm_battlefield` VALUES (1303,7,16929051,3);-- Enhanced Ahriman
-- -------------------------------
-- Central Temenos - Basement 1
-- ------------------------------
INSERT INTO `bcnm_battlefield` VALUES (1301,8,16929053,3);-- Temenos Aern
INSERT INTO `bcnm_battlefield` VALUES (1301,8,16929054,3);-- Temenos Aern
INSERT INTO `bcnm_battlefield` VALUES (1301,8,16929055,3);-- Temenos Aern
INSERT INTO `bcnm_battlefield` VALUES (1301,8,16929056,1);-- Aern's Wynav
INSERT INTO `bcnm_battlefield` VALUES (1301,8,16929057,3);-- Temenos Aern
INSERT INTO `bcnm_battlefield` VALUES (1301,8,16929058,3);-- Temenos Aern
INSERT INTO `bcnm_battlefield` VALUES (1301,8,16929059,1);-- Aern's Euvhi
INSERT INTO `bcnm_battlefield` VALUES (1301,8,16929060,3);-- Temenos Aern
INSERT INTO `bcnm_battlefield` VALUES (1301,8,16929061,3);-- Temenos Aern
INSERT INTO `bcnm_battlefield` VALUES (1301,8,16929062,3);-- Temenos Aern
INSERT INTO `bcnm_battlefield` VALUES (1301,8,16929063,3);-- Temenos Aern
INSERT INTO `bcnm_battlefield` VALUES (1301,8,16929064,3);-- Temenos Aern
INSERT INTO `bcnm_battlefield` VALUES (1301,8,16929065,3);-- Temenos Aern
INSERT INTO `bcnm_battlefield` VALUES (1301,8,16929066,3);-- Temenos Aern
INSERT INTO `bcnm_battlefield` VALUES (1301,8,16929067,1);-- Aern's Elemental
INSERT INTO `bcnm_battlefield` VALUES (1301,8,16929068,0);-- Aern's Avatar
INSERT INTO `bcnm_battlefield` VALUES (1301,8,16929069,3);-- Temenos Aern
INSERT INTO `bcnm_battlefield` VALUES (1301,8,16929070,1);-- Aern's Wynav
INSERT INTO `bcnm_battlefield` VALUES (1301,8,16929071,3);-- Temenos Aern
INSERT INTO `bcnm_battlefield` VALUES (1301,8,16929072,3);-- Temenos Aern
INSERT INTO `bcnm_battlefield` VALUES (1301,8,16929073,3);-- Temenos Aern
INSERT INTO `bcnm_battlefield` VALUES (1301,8,16929074,1);-- Aern's Euvhi
INSERT INTO `bcnm_battlefield` VALUES (1301,8,16929075,3);-- Temenos Aern
INSERT INTO `bcnm_battlefield` VALUES (1301,8,16929076,3);-- Temenos Aern
INSERT INTO `bcnm_battlefield` VALUES (1301,8,16929077,3);-- Temenos Aern
INSERT INTO `bcnm_battlefield` VALUES (1301,8,16929078,3);-- Temenos Aern
INSERT INTO `bcnm_battlefield` VALUES (1301,8,16929079,3);-- Temenos Aern
INSERT INTO `bcnm_battlefield` VALUES (1301,8,16929080,1);-- Aern's Elemental
INSERT INTO `bcnm_battlefield` VALUES (1301,8,16929081,0);-- Aern's Avatar
INSERT INTO `bcnm_battlefield` VALUES (1301,8,16929082,3);-- Temenos Aern
INSERT INTO `bcnm_battlefield` VALUES (1301,8,16929083,3);-- Temenos Aern
INSERT INTO `bcnm_battlefield` VALUES (1301,8,16929084,3);-- Temenos Aern
INSERT INTO `bcnm_battlefield` VALUES (1301,8,16929085,3);-- Temenos Aern
INSERT INTO `bcnm_battlefield` VALUES (1301,8,16929086,3);-- Temenos Aern
INSERT INTO `bcnm_battlefield` VALUES (1301,8,16929087,3);-- Temenos Aern
INSERT INTO `bcnm_battlefield` VALUES (1301,8,16929088,2);-- Temenos Ghrah

-- Dump completed on 2017-01-31 10:38:38
