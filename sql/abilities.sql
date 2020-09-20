-- MySQL dump 10.13  Distrib 5.7.12, for Win64 (x86_64)
--
-- Host: localhost    Database: tpzdb
-- ------------------------------------------------------
-- Server version	5.5.5-10.0.20-MariaDB

--
-- Table structure for table `abilities`
--

DROP TABLE IF EXISTS `abilities`;
CREATE TABLE `abilities` (
  `abilityId` smallint(5) unsigned NOT NULL,
  `name` tinytext,
  `job` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `level` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `validTarget` smallint(3) unsigned NOT NULL DEFAULT '0',
  `recastTime` smallint(5) unsigned NOT NULL DEFAULT '0',
  `recastId` smallint(5) unsigned NOT NULL DEFAULT '0',
  `message1` smallint(5) unsigned NOT NULL DEFAULT '0',
  `message2` smallint(5) unsigned NOT NULL DEFAULT '0',
  `animation` smallint(5) unsigned NOT NULL DEFAULT '0',
  `animationTime` smallint(4) unsigned NOT NULL DEFAULT '0',
  `castTime` smallint(4) unsigned NOT NULL DEFAULT '0',
  `actionType` tinyint(2) unsigned NOT NULL DEFAULT '6',
  `range` float(3,1) unsigned NOT NULL DEFAULT '0.0',
  `isAOE` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `CE` smallint(5) NOT NULL DEFAULT '0',
  `VE` smallint(5) NOT NULL DEFAULT '0',
  `meritModID` smallint(4) NOT NULL DEFAULT '0',
  `addType` smallint(2) NOT NULL DEFAULT '0',
  `content_tag` varchar(7) DEFAULT NULL,
  PRIMARY KEY (`abilityId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=56;

--
-- Dumping data for table `abilities`
--
-- ORDER BY:  `abilityId`

INSERT INTO `abilities` VALUES (16,'mighty_strikes',1,0,1,3600,0,0,0,33,2000,0,6,20.0,0,1,300,0,0,NULL);
INSERT INTO `abilities` VALUES (17,'hundred_fists',2,0,1,3600,0,0,0,34,2000,0,6,20.0,0,1,300,0,0,NULL);
INSERT INTO `abilities` VALUES (18,'benediction',3,0,1,3600,0,102,0,35,2000,0,6,20.0,1,0,0,0,0,NULL);
INSERT INTO `abilities` VALUES (19,'manafont',4,0,1,3600,0,0,0,36,2000,0,6,20.0,0,1,0,0,0,NULL);
INSERT INTO `abilities` VALUES (20,'chainspell',5,0,1,3600,0,0,0,37,2000,0,6,20.0,0,1,0,0,0,NULL);
INSERT INTO `abilities` VALUES (21,'perfect_dodge',6,0,1,3600,0,0,0,38,2000,0,6,20.0,0,1,0,0,0,NULL);
INSERT INTO `abilities` VALUES (22,'invincible',7,0,1,3600,0,0,0,18,2000,0,6,20.0,0,1,7200,0,0,NULL);
INSERT INTO `abilities` VALUES (23,'blood_weapon',8,0,1,3600,0,0,0,19,2000,0,6,20.0,0,1,80,0,0,NULL);
INSERT INTO `abilities` VALUES (24,'familiar',9,0,1,3600,0,0,0,39,2000,0,6,20.0,0,0,0,0,0,NULL);
INSERT INTO `abilities` VALUES (25,'soul_voice',10,0,1,3600,0,0,0,40,2000,0,6,20.0,0,1,0,0,0,NULL);
INSERT INTO `abilities` VALUES (26,'eagle_eye_shot',11,0,4,3600,0,110,0,186,2000,0,3,20.0,0,0,0,0,0,NULL);
INSERT INTO `abilities` VALUES (27,'meikyo_shisui',12,0,1,3600,0,0,0,96,2000,0,6,20.0,0,1,300,0,0,NULL);
INSERT INTO `abilities` VALUES (28,'mijin_gakure',13,0,4,3600,0,110,0,93,2000,0,6,20.0,0,0,0,0,0,NULL);
INSERT INTO `abilities` VALUES (29,'spirit_surge',14,0,1,3600,0,0,0,97,2000,0,6,20.0,0,0,0,0,0,'COP');
INSERT INTO `abilities` VALUES (30,'astral_flow',15,0,1,3600,0,0,0,95,2000,0,6,20.0,0,0,0,0,0,NULL);
INSERT INTO `abilities` VALUES (31,'berserk',1,15,1,300,1,115,0,0,2000,0,6,20.0,0,1,80,384,0,NULL);
INSERT INTO `abilities` VALUES (32,'warcry',1,35,1,300,2,0,0,28,2000,0,6,20.0,1,1,300,388,0,NULL);
INSERT INTO `abilities` VALUES (33,'defender',1,25,1,180,3,117,0,1,2000,0,6,20.0,0,1,80,386,0,NULL);
INSERT INTO `abilities` VALUES (34,'aggressor',1,45,1,300,4,118,0,2,2000,0,6,20.0,0,1,80,390,0,NULL);
INSERT INTO `abilities` VALUES (35,'provoke',1,5,4,30,5,0,0,3,2000,0,6,18.0,0,1,1800,0,0,NULL);
INSERT INTO `abilities` VALUES (36,'focus',2,25,1,300,13,120,0,4,2000,0,6,20.0,0,1,300,448,0,NULL);
INSERT INTO `abilities` VALUES (37,'dodge',2,15,1,300,14,121,0,5,2000,0,6,20.0,0,1,300,450,0,NULL);
INSERT INTO `abilities` VALUES (38,'chakra',2,35,1,300,15,102,0,6,2000,0,6,20.0,0,1,300,452,0,NULL);
INSERT INTO `abilities` VALUES (39,'boost',2,5,1,15,16,116,0,7,2000,0,6,20.0,0,1,300,0,0,NULL);
INSERT INTO `abilities` VALUES (40,'counterstance',2,45,1,300,17,0,0,8,2000,0,6,20.0,0,1,900,0,0,NULL);
INSERT INTO `abilities` VALUES (41,'steal',6,5,4,300,60,125,0,181,2000,0,3,4.4,0,1,300,0,0,NULL);
INSERT INTO `abilities` VALUES (42,'flee',6,25,1,300,62,126,0,9,2000,0,6,20.0,0,1,80,704,0,NULL);
INSERT INTO `abilities` VALUES (43,'hide',6,45,1,300,63,0,0,10,2000,0,6,20.0,0,0,0,706,0,NULL);
INSERT INTO `abilities` VALUES (44,'sneak_attack',6,15,1,60,64,0,0,17,2000,0,6,20.0,0,1,0,708,0,NULL);
INSERT INTO `abilities` VALUES (45,'mug',6,35,4,300,65,129,0,183,2000,0,3,4.4,0,1,300,0,0,NULL);
INSERT INTO `abilities` VALUES (46,'shield_bash',7,15,4,60,73,0,0,185,2000,0,3,4.4,0,450,900,768,0,NULL);
INSERT INTO `abilities` VALUES (47,'holy_circle',7,5,1,600,74,0,0,29,2000,0,6,20.0,1,1,20,770,0,NULL);
INSERT INTO `abilities` VALUES (48,'sentinel',7,30,1,300,75,0,0,11,2000,0,6,20.0,0,1,900,772,0,NULL);
INSERT INTO `abilities` VALUES (49,'souleater',8,30,1,360,85,0,0,20,2000,0,6,20.0,0,1,1300,832,0,NULL);
INSERT INTO `abilities` VALUES (50,'arcane_circle',8,5,1,600,86,0,0,30,2000,0,6,20.0,1,1,20,834,0,NULL);
INSERT INTO `abilities` VALUES (51,'last_resort',8,15,1,300,87,0,0,12,2000,0,6,20.0,0,1,1300,836,0,NULL);
INSERT INTO `abilities` VALUES (52,'charm',9,1,4,15,97,0,0,13,2000,0,6,18.0,0,320,0,0,0,NULL);
INSERT INTO `abilities` VALUES (53,'gauge',9,10,4,30,98,0,0,14,2000,0,6,23.0,0,0,0,0,0,NULL);
INSERT INTO `abilities` VALUES (54,'tame',9,30,4,600,99,0,0,15,2000,0,6,18.0,0,0,0,904,0,NULL);
INSERT INTO `abilities` VALUES (55,'pet_commands',9,1,1,0,255,0,0,0,2000,0,6,18.0,0,0,0,0,0,NULL);
INSERT INTO `abilities` VALUES (56,'scavenge',11,10,1,180,121,0,0,21,2000,0,6,20.0,0,1,80,1024,0,NULL);
INSERT INTO `abilities` VALUES (57,'shadowbind',11,40,4,300,122,0,0,188,2000,0,3,18.0,0,1,800,0,0,NULL);
INSERT INTO `abilities` VALUES (58,'camouflage',11,20,1,300,123,0,0,10,2000,0,6,20.0,0,1,80,1026,0,NULL);
INSERT INTO `abilities` VALUES (59,'sharpshot',11,1,1,300,124,0,0,22,2000,0,6,20.0,0,1,600,1028,0,NULL);
INSERT INTO `abilities` VALUES (60,'barrage',11,30,1,300,125,0,0,23,2000,0,6,20.0,0,1,600,0,0,NULL);
INSERT INTO `abilities` VALUES (61,'call_wyvern',14,1,1,1200,163,0,0,94,2000,0,6,20.0,0,1,300,0,4,NULL);
INSERT INTO `abilities` VALUES (62,'third_eye',12,15,1,60,133,0,0,24,2000,0,6,20.0,0,1,0,1088,0,NULL);
INSERT INTO `abilities` VALUES (63,'meditate',12,30,1,180,134,0,0,25,2000,0,6,20.0,0,320,0,1094,0,NULL);
INSERT INTO `abilities` VALUES (64,'warding_circle',12,5,1,300,135,0,0,31,2000,0,6,20.0,1,1,20,1090,0,NULL);
INSERT INTO `abilities` VALUES (65,'ancient_circle',14,5,1,300,157,0,0,32,2000,0,6,20.0,1,1,20,1216,0,NULL);
INSERT INTO `abilities` VALUES (66,'jump',14,10,4,60,158,110,0,204,2000,0,3,9.5,0,0,0,1218,0,NULL);
INSERT INTO `abilities` VALUES (67,'high_jump',14,35,4,120,159,110,0,209,2000,0,3,11.5,0,0,0,1220,0,NULL);
INSERT INTO `abilities` VALUES (68,'super_jump',14,50,4,180,160,110,0,214,2000,0,3,12.5,0,0,0,1221,0,NULL);
INSERT INTO `abilities` VALUES (69,'fight',9,1,4,10,100,0,0,83,2000,0,6,18.0,0,0,0,0,192,NULL);
INSERT INTO `abilities` VALUES (70,'heel',9,10,1,5,101,0,0,83,2000,0,6,18.0,0,1,300,0,192,NULL);
INSERT INTO `abilities` VALUES (71,'leave',9,35,1,10,101,0,0,83,2000,0,6,18.0,0,1,300,0,192,NULL);
INSERT INTO `abilities` VALUES (72,'sic',9,25,1,120,102,0,0,83,2000,0,6,18.0,0,0,0,902,128,NULL);
INSERT INTO `abilities` VALUES (73,'stay',9,15,1,5,101,0,0,83,2000,0,6,18.0,0,1,300,0,192,NULL);
INSERT INTO `abilities` VALUES (74,'divine_seal',3,15,1,600,26,0,0,81,2000,0,6,20.0,0,0,80,512,0,NULL);
INSERT INTO `abilities` VALUES (75,'elemental_seal',4,15,1,600,38,0,0,80,2000,0,6,20.0,0,0,80,576,0,NULL);
INSERT INTO `abilities` VALUES (76,'trick_attack',6,30,1,60,66,0,0,82,2000,0,6,20.0,0,1,0,710,0,NULL);
INSERT INTO `abilities` VALUES (77,'weapon_bash',8,20,4,180,88,110,0,201,2000,0,3,4.4,0,1,900,0,0,NULL);
INSERT INTO `abilities` VALUES (78,'reward',9,12,257,90,103,102,0,84,2000,0,6,18.0,0,0,0,898,0,NULL);
INSERT INTO `abilities` VALUES (79,'cover',7,35,2,180,76,0,0,86,2000,0,6,20.0,0,1,300,0,0,NULL);
INSERT INTO `abilities` VALUES (80,'spirit_link',14,25,1,90,162,0,0,94,2000,0,6,20.0,0,0,0,1224,4,NULL);
-- INSERT INTO `abilities` VALUES (81,'enrage',0,0,0,0,6,0,0,0,0,0,6,0,0,0,0,0,0,NULL);
INSERT INTO `abilities` VALUES (82,'chi_blast',2,41,4,180,18,110,0,92,2000,0,6,20.0,0,0,0,0,0,NULL);
INSERT INTO `abilities` VALUES (83,'convert',5,40,1,600,49,0,0,88,2000,0,6,20.0,0,1,80,640,0,NULL);
INSERT INTO `abilities` VALUES (84,'accomplice',6,65,2,300,69,526,0,185,2000,0,6,12.6,0,0,0,0,0,'WOTG');
INSERT INTO `abilities` VALUES (85,'call_beast',9,23,1,300,104,0,0,83,2000,0,6,18.0,0,1,0,900,0,NULL);
INSERT INTO `abilities` VALUES (86,'unlimited_shot',11,51,1,180,126,0,0,90,2000,0,6,20.0,0,1,300,1030,0,NULL);
INSERT INTO `abilities` VALUES (87,'dismiss',14,1,1,300,161,0,0,94,2000,0,6,20.0,0,0,0,0,4,NULL);
INSERT INTO `abilities` VALUES (88,'assault',15,1,4,5,170,0,0,94,2000,0,6,20.0,0,0,0,0,256,NULL);
INSERT INTO `abilities` VALUES (89,'retreat',15,1,1,5,171,0,0,94,2000,0,6,20.0,0,-10,0,0,256,NULL);
INSERT INTO `abilities` VALUES (90,'release',15,1,1,5,172,0,0,94,2000,0,6,20.0,0,-10,0,0,256,NULL);
INSERT INTO `abilities` VALUES (91,'blood_pact_rage',15,1,1,60,173,0,0,0,2000,0,6,20.0,0,1,300,0,256,NULL);
INSERT INTO `abilities` VALUES (92,'rampart',7,62,1,300,77,0,0,91,2000,0,6,20.0,1,320,320,776,0,NULL);
INSERT INTO `abilities` VALUES (93,'azure_lore',16,0,1,3600,0,0,0,142,2000,0,6,20.0,0,1,300,0,0,'TOAU');
INSERT INTO `abilities` VALUES (94,'chain_affinity',16,40,1,120,181,0,0,140,2000,0,6,20.0,0,1,300,1344,0,'TOAU');
INSERT INTO `abilities` VALUES (95,'burst_affinity',16,25,1,120,182,0,0,141,2000,0,6,20.0,0,1,300,1346,0,'TOAU');
INSERT INTO `abilities` VALUES (96,'wild_card',17,0,1,3600,0,0,0,132,2000,0,6,20.0,1,1,300,0,0,'TOAU');
INSERT INTO `abilities` VALUES (97,'phantom_roll',17,5,1,60,193,0,0,0,2000,0,6,18.0,0,0,0,1408,0,'TOAU');
INSERT INTO `abilities` VALUES (98,'fighters_roll',17,49,1,60,193,420,0,98,2000,0,6,8.0,1,1,80,0,8,'TOAU');
INSERT INTO `abilities` VALUES (99,'monks_roll',17,31,1,60,193,420,0,99,2000,0,6,8.0,1,1,80,0,8,'TOAU');
INSERT INTO `abilities` VALUES (100,'healers_roll',17,20,1,60,193,420,0,100,2000,0,6,8.0,1,1,80,0,8,'TOAU');
INSERT INTO `abilities` VALUES (101,'wizards_roll',17,58,1,60,193,420,0,101,2000,0,6,8.0,1,1,80,0,8,'TOAU');
INSERT INTO `abilities` VALUES (102,'warlocks_roll',17,46,1,60,193,420,0,102,2000,0,6,8.0,1,1,80,0,8,'TOAU');
INSERT INTO `abilities` VALUES (103,'rogues_roll',17,43,1,60,193,420,0,103,2000,0,6,8.0,1,1,80,0,8,'TOAU');
INSERT INTO `abilities` VALUES (104,'gallants_roll',17,55,1,60,193,420,0,104,2000,0,6,8.0,1,1,80,0,8,'TOAU');
INSERT INTO `abilities` VALUES (105,'chaos_roll',17,14,1,60,193,420,0,105,2000,0,6,8.0,1,1,80,0,8,'TOAU');
INSERT INTO `abilities` VALUES (106,'beast_roll',17,34,1,60,193,420,0,106,2000,0,6,8.0,1,1,80,0,8,'TOAU');
INSERT INTO `abilities` VALUES (107,'choral_roll',17,26,1,60,193,420,0,107,2000,0,6,8.0,1,1,80,0,8,'TOAU');
INSERT INTO `abilities` VALUES (108,'hunters_roll',17,11,1,60,193,420,0,108,2000,0,6,8.0,1,1,80,0,8,'TOAU');
INSERT INTO `abilities` VALUES (109,'samurai_roll',17,34,1,60,193,420,0,109,2000,0,6,8.0,1,1,80,0,8,'TOAU');
INSERT INTO `abilities` VALUES (110,'ninja_roll',17,8,1,60,193,420,0,110,2000,0,6,8.0,1,1,80,0,8,'TOAU');
INSERT INTO `abilities` VALUES (111,'drachen_roll',17,23,1,60,193,420,0,111,2000,0,6,8.0,1,1,80,0,8,'TOAU');
INSERT INTO `abilities` VALUES (112,'evokers_roll',17,40,1,60,193,420,0,112,2000,0,6,8.0,1,1,80,0,8,'TOAU');
INSERT INTO `abilities` VALUES (113,'maguss_roll',17,17,1,60,193,420,0,113,2000,0,6,8.0,1,1,80,0,8,'TOAU');
INSERT INTO `abilities` VALUES (114,'corsairs_roll',17,5,1,60,193,420,0,114,2000,0,6,8.0,1,1,80,0,8,'TOAU');
INSERT INTO `abilities` VALUES (115,'puppet_roll',17,52,1,60,193,420,0,115,2000,0,6,8.0,1,1,80,0,8,'TOAU');
INSERT INTO `abilities` VALUES (116,'dancers_roll',17,61,1,60,193,420,0,116,2000,0,6,8.0,1,1,80,0,8,'WOTG');
INSERT INTO `abilities` VALUES (117,'scholars_roll',17,64,1,60,193,420,0,117,2000,0,6,8.0,1,1,80,0,8,'WOTG');
INSERT INTO `abilities` VALUES (118,'bolters_roll',17,76,1,60,193,420,0,118,2000,0,6,8.0,1,1,80,0,8,'ABYSSEA');
INSERT INTO `abilities` VALUES (119,'casters_roll',17,79,1,60,193,420,0,119,2000,0,6,8.0,1,1,80,0,8,'ABYSSEA');
INSERT INTO `abilities` VALUES (120,'coursers_roll',17,81,1,60,193,420,0,120,2000,0,6,8.0,1,1,80,0,8,'ABYSSEA');
INSERT INTO `abilities` VALUES (121,'blitzers_roll',17,83,1,60,193,420,0,121,2000,0,6,8.0,1,1,80,0,8,'ABYSSEA');
INSERT INTO `abilities` VALUES (122,'tacticians_roll',17,86,1,60,193,420,0,122,2000,0,6,8.0,1,1,80,0,8,'ABYSSEA');
INSERT INTO `abilities` VALUES (123,'double-up',17,5,1,5,194,424,0,116,2000,0,6,8.0,1,1,80,0,0,'TOAU');
INSERT INTO `abilities` VALUES (124,'quick_draw',17,40,1,1,199,0,0,0,2000,0,6,18.0,0,0,0,1410,0,'TOAU');
INSERT INTO `abilities` VALUES (125,'fire_shot',17,40,4,1,195,110,0,125,2000,0,6,18.0,0,0,0,1410,0,'TOAU');
INSERT INTO `abilities` VALUES (126,'ice_shot',17,40,4,1,195,110,0,126,2000,0,6,18.0,0,0,0,1410,0,'TOAU');
INSERT INTO `abilities` VALUES (127,'wind_shot',17,40,4,1,195,110,0,127,2000,0,6,18.0,0,0,0,1410,0,'TOAU');
INSERT INTO `abilities` VALUES (128,'earth_shot',17,40,4,1,195,110,0,128,2000,0,6,18.0,0,0,0,1410,0,'TOAU');
INSERT INTO `abilities` VALUES (129,'thunder_shot',17,40,4,1,195,110,0,129,2000,0,6,18.0,0,0,0,1410,0,'TOAU');
INSERT INTO `abilities` VALUES (130,'water_shot',17,40,4,1,195,110,0,130,2000,0,6,18.0,0,0,0,1410,0,'TOAU');
INSERT INTO `abilities` VALUES (131,'light_shot',17,40,4,1,195,0,0,123,2000,0,6,18.0,0,0,0,1410,0,'TOAU');
INSERT INTO `abilities` VALUES (132,'dark_shot',17,40,4,1,195,0,0,124,2000,0,6,18.0,0,0,0,1410,0,'TOAU');
INSERT INTO `abilities` VALUES (133,'random_deal',17,50,1,1200,196,0,0,131,2000,0,6,20.0,1,1,300,1414,0,'TOAU');
INSERT INTO `abilities` VALUES (135,'overdrive',18,0,1,3600,0,0,0,143,2000,0,6,20.0,0,0,0,0,0,'TOAU');
INSERT INTO `abilities` VALUES (136,'activate',18,1,1,1200,205,0,0,83,2000,0,6,20.0,0,1,80,1478,0,'TOAU');
INSERT INTO `abilities` VALUES (137,'repair',18,15,257,180,206,102,0,83,2000,0,6,18.0,0,0,0,1480,0,'TOAU'); -- FYI: Retail has this at 90s and its merit at 3s per upgrade due to a 99 cap Automaton HP increase (as well as reworked Auto-repair Kits and oil changes)
INSERT INTO `abilities` VALUES (138,'deploy',18,1,4,10,207,0,0,83,2000,0,6,18.0,0,0,0,0,512,'TOAU');
INSERT INTO `abilities` VALUES (139,'deactivate',18,1,1,60,208,0,0,83,2000,0,6,18.0,0,0,0,0,512,'TOAU');
INSERT INTO `abilities` VALUES (140,'retrieve',18,10,1,10,209,0,0,83,2000,0,6,18.0,0,0,0,0,512,'TOAU');
INSERT INTO `abilities` VALUES (141,'fire_maneuver',18,1,1,10,210,0,0,333,2000,0,6,18.0,0,1,0,0,512,'TOAU');
INSERT INTO `abilities` VALUES (142,'ice_maneuver',18,1,1,10,210,0,0,333,2000,0,6,18.0,0,1,0,0,512,'TOAU');
INSERT INTO `abilities` VALUES (143,'wind_maneuver',18,1,1,10,210,0,0,333,2000,0,6,18.0,0,1,0,0,512,'TOAU');
INSERT INTO `abilities` VALUES (144,'earth_maneuver',18,1,1,10,210,0,0,333,2000,0,6,18.0,0,1,0,0,512,'TOAU');
INSERT INTO `abilities` VALUES (145,'thunder_maneuver',18,1,1,10,210,0,0,333,2000,0,6,18.0,0,1,0,0,512,'TOAU');
INSERT INTO `abilities` VALUES (146,'water_maneuver',18,1,1,10,210,0,0,333,2000,0,6,18.0,0,1,0,0,512,'TOAU');
INSERT INTO `abilities` VALUES (147,'light_maneuver',18,1,1,10,210,0,0,333,2000,0,6,18.0,0,1,0,0,512,'TOAU');
INSERT INTO `abilities` VALUES (148,'dark_maneuver',18,1,1,10,210,0,0,333,2000,0,6,18.0,0,1,0,0,512,'TOAU');
INSERT INTO `abilities` VALUES (149,'warriors_charge',1,75,1,300,6,0,0,154,2000,0,6,20.0,0,1,300,2048,1,'TOAU');
INSERT INTO `abilities` VALUES (150,'tomahawk',1,75,4,180,7,0,0,244,2000,0,3,20.0,0,1,600,2050,1,'TOAU');
INSERT INTO `abilities` VALUES (151,'mantra',2,75,1,600,19,441,0,155,2000,0,6,20.0,1,1,60,2112,1,'TOAU');
INSERT INTO `abilities` VALUES (152,'formless_strikes',2,75,1,600,20,0,0,156,2000,0,6,20.0,0,1,300,2114,1,'TOAU');
INSERT INTO `abilities` VALUES (153,'martyr',3,75,2,600,27,102,0,157,2000,0,6,20.0,0,1,300,2176,1,'TOAU');
INSERT INTO `abilities` VALUES (154,'devotion',3,75,2,600,28,451,0,158,2000,0,6,10.0,0,1,300,2178,1,'TOAU');
INSERT INTO `abilities` VALUES (155,'assassins_charge',6,75,1,300,67,0,0,160,2000,0,6,20.0,0,1,300,2368,1,'TOAU');
INSERT INTO `abilities` VALUES (156,'feint',6,75,1,120,68,0,0,159,2000,0,6,20.0,0,1,300,2370,1,'TOAU');
INSERT INTO `abilities` VALUES (157,'fealty',7,75,1,600,78,0,0,148,2000,0,6,20.0,0,1,300,2432,1,'TOAU');
INSERT INTO `abilities` VALUES (158,'chivalry',7,75,1,600,79,451,0,149,2000,0,6,20.0,0,1,300,2434,1,'TOAU');
INSERT INTO `abilities` VALUES (159,'dark_seal',8,75,1,300,89,0,0,144,2000,0,6,20.0,0,1,300,2496,1,'TOAU');
INSERT INTO `abilities` VALUES (160,'diabolic_eye',8,75,1,300,90,0,0,145,2000,0,6,20.0,0,1,300,2498,1,'TOAU');
INSERT INTO `abilities` VALUES (161,'feral_howl',9,75,4,300,105,0,0,146,2000,0,6,20.0,0,1,600,2560,1,'TOAU');
INSERT INTO `abilities` VALUES (162,'killer_instinct',9,75,1,300,106,0,0,147,2000,0,6,20.0,1,1,80,2562,1,'TOAU');
INSERT INTO `abilities` VALUES (163,'nightingale',10,75,1,600,109,0,0,161,2000,0,6,20.0,0,1,300,2624,1,'TOAU');
INSERT INTO `abilities` VALUES (164,'troubadour',10,75,1,600,110,0,0,162,2000,0,6,20.0,0,1,300,2626,1,'TOAU');
INSERT INTO `abilities` VALUES (165,'stealth_shot',11,75,1,300,127,0,0,150,2000,0,6,20.0,0,1,300,2688,1,'TOAU');
INSERT INTO `abilities` VALUES (166,'flashy_shot',11,75,1,600,128,0,0,151,2000,0,6,20.0,0,1,300,2690,1,'TOAU');
INSERT INTO `abilities` VALUES (167,'shikikoyo',12,75,2,300,136,452,0,152,2000,0,6,20.0,0,1,300,2752,1,'TOAU');
INSERT INTO `abilities` VALUES (168,'blade_bash',12,75,4,180,137,110,0,202,2000,0,3,4.4,0,1,900,2754,1,'TOAU');
INSERT INTO `abilities` VALUES (169,'deep_breathing',14,75,1,300,164,0,0,153,2000,0,6,20.0,0,0,0,2880,1,'TOAU');
INSERT INTO `abilities` VALUES (170,'angon',14,75,4,180,165,127,0,245,2000,0,3,20.0,0,1,600,2882,1,'TOAU');
INSERT INTO `abilities` VALUES (171,'sange',13,75,1,300,145,0,0,200,2000,0,6,20.0,0,1,0,2816,1,'TOAU');
INSERT INTO `abilities` VALUES (172,'blood_pact_ward',15,1,1,60,174,0,0,0,2000,0,6,20.0,0,1,300,0,256,NULL); -- new windower states 969
INSERT INTO `abilities` VALUES (173,'hasso',12,25,1,60,138,0,0,163,2000,0,6,20.0,0,1,300,0,0,'TOAU');
INSERT INTO `abilities` VALUES (174,'seigan',12,35,1,60,139,0,0,164,2000,0,6,20.0,0,1,300,0,0,'TOAU');
INSERT INTO `abilities` VALUES (175,'convergence',16,75,1,600,183,0,0,165,2000,0,6,20.0,0,1,300,3008,1,'TOAU');
INSERT INTO `abilities` VALUES (176,'diffusion',16,75,1,600,184,0,0,166,2000,0,6,20.0,1,1,300,3010,1,'TOAU');
INSERT INTO `abilities` VALUES (177,'snake_eye',17,75,1,300,197,0,0,167,2000,0,6,20.0,0,1,300,3072,1,'TOAU');
INSERT INTO `abilities` VALUES (178,'fold',17,75,1,300,198,0,0,220,2000,0,6,20.0,0,1,300,3074,1,'TOAU');
INSERT INTO `abilities` VALUES (179,'role_reversal',18,75,1,120,211,0,0,169,2000,0,6,20.0,0,0,0,3136,1,'TOAU');
INSERT INTO `abilities` VALUES (180,'ventriloquy',18,75,4,60,212,0,0,170,2000,0,6,20.0,0,0,0,3138,1,'TOAU');
INSERT INTO `abilities` VALUES (181,'trance',19,0,1,3600,0,0,0,184,2000,0,6,20.0,0,1,300,0,0,'WOTG');
INSERT INTO `abilities` VALUES (182,'sambas',19,5,1,0,216,0,0,0,2000,0,14,20.0,0,0,0,0,0,'WOTG');
INSERT INTO `abilities` VALUES (183,'waltzes',19,15,1,0,217,0,0,0,2000,0,14,20.0,0,0,0,0,0,'WOTG');
INSERT INTO `abilities` VALUES (184,'drain_samba',19,5,1,60,216,100,0,0,2000,0,14,20.0,0,1,300,0,0,'WOTG');
INSERT INTO `abilities` VALUES (185,'drain_samba_ii',19,35,1,60,216,100,0,1,2000,0,14,20.0,0,1,300,0,0,'WOTG');
INSERT INTO `abilities` VALUES (186,'drain_samba_iii',19,65,1,60,216,100,0,2,2000,0,14,20.0,0,1,300,0,0,'WOTG');
INSERT INTO `abilities` VALUES (187,'aspir_samba',19,25,1,60,216,100,0,3,2000,0,14,20.0,0,1,300,0,0,'WOTG');
INSERT INTO `abilities` VALUES (188,'aspir_samba_ii',19,60,1,60,216,100,0,4,2000,0,14,20.0,0,1,300,0,0,'WOTG');
INSERT INTO `abilities` VALUES (189,'haste_samba',19,45,1,60,216,100,0,5,2000,0,14,20.0,0,1,300,0,0,'WOTG');
INSERT INTO `abilities` VALUES (190,'curing_waltz',19,15,27,6,217,102,0,6,2000,0,14,20.0,0,0,0,0,0,'WOTG');
INSERT INTO `abilities` VALUES (191,'curing_waltz_ii',19,30,27,8,186,102,0,7,2000,0,14,20.0,0,0,0,0,0,'WOTG');
INSERT INTO `abilities` VALUES (192,'curing_waltz_iii',19,45,27,10,187,102,0,8,2000,0,14,20.0,0,0,0,0,0,'WOTG');
INSERT INTO `abilities` VALUES (193,'curing_waltz_iv',19,70,27,12,188,102,0,9,2000,0,14,20.0,0,0,0,0,0,'WOTG');
INSERT INTO `abilities` VALUES (194,'healing_waltz',19,35,27,8,215,123,0,10,2000,0,14,20.0,0,1,300,0,0,'WOTG');
INSERT INTO `abilities` VALUES (195,'divine_waltz',19,25,27,13,225,102,0,11,2000,0,14,20.0,1,0,0,0,0,'WOTG');
INSERT INTO `abilities` VALUES (196,'spectral_jig',19,25,1,30,218,532,0,12,2000,0,14,20.0,0,1,300,0,0,'WOTG');
INSERT INTO `abilities` VALUES (197,'chocobo_jig',19,55,1,60,218,126,0,13,2000,0,14,20.0,0,1,300,0,0,'WOTG');
INSERT INTO `abilities` VALUES (198,'jigs',19,25,1,0,218,0,0,0,2000,0,14,20.0,0,0,0,0,0,'WOTG');
INSERT INTO `abilities` VALUES (199,'steps',19,20,1,0,220,0,0,0,2000,0,14,20.0,0,0,0,0,0,'WOTG');
INSERT INTO `abilities` VALUES (200,'flourishes_i',19,20,1,0,0,221,0,0,2000,0,14,20.0,0,0,0,0,0,'WOTG');
INSERT INTO `abilities` VALUES (201,'quickstep',19,20,4,5,220,519,0,17,2000,0,14,4.5,0,1,0,0,0,'WOTG');
INSERT INTO `abilities` VALUES (202,'box_step',19,30,4,5,220,520,0,16,2000,0,14,4.5,0,1,0,0,0,'WOTG');
INSERT INTO `abilities` VALUES (203,'stutter_step',19,40,4,5,220,521,0,16,2000,0,14,4.5,0,1,0,0,0,'WOTG');
INSERT INTO `abilities` VALUES (204,'animated_flourish',19,20,4,30,221,119,0,181,2000,0,14,17.6,0,1,1000,0,0,'WOTG');
INSERT INTO `abilities` VALUES (205,'desperate_flourish',19,30,4,20,221,127,0,26,2000,0,14,4.4,0,1,0,0,0,'WOTG');
INSERT INTO `abilities` VALUES (206,'reverse_flourish',19,40,1,30,222,452,0,182,2000,0,14,20.0,0,1,0,0,0,'WOTG');
INSERT INTO `abilities` VALUES (207,'violent_flourish',19,45,4,20,221,522,0,26,2000,0,14,4.4,0,1,0,0,0,'WOTG');
INSERT INTO `abilities` VALUES (208,'building_flourish',19,50,1,10,222,0,0,220,2000,0,14,20.0,0,1,0,0,0,'WOTG');
INSERT INTO `abilities` VALUES (209,'wild_flourish',19,60,4,20,222,529,0,26,2000,0,14,4.4,0,1,0,0,0,'WOTG');
INSERT INTO `abilities` VALUES (210,'tabula_rasa',20,0,1,3600,0,0,0,190,2000,0,6,20.0,0,1,300,0,0,'WOTG');
INSERT INTO `abilities` VALUES (211,'light_arts',20,10,1,60,228,0,0,171,2000,0,6,20.0,0,1,80,1600,0,'WOTG');
INSERT INTO `abilities` VALUES (212,'dark_arts',20,10,1,60,232,0,0,176,2000,0,6,20.0,0,1,80,1600,0,'WOTG');
INSERT INTO `abilities` VALUES (213,'flourishes_ii',19,40,1,0,222,0,0,0,2000,0,6,20.0,0,0,0,0,0,'WOTG');
INSERT INTO `abilities` VALUES (214,'modus_veritas',20,65,4,180,230,0,0,188,2000,0,6,20.0,0,1,80,0,0,'WOTG');
INSERT INTO `abilities` VALUES (215,'penury',20,10,1,1,231,0,0,172,2000,0,6,20.0,0,1,80,0,16,'WOTG');
INSERT INTO `abilities` VALUES (216,'celerity',20,25,1,1,231,0,0,173,2000,0,6,20.0,0,1,80,0,16,'WOTG');
INSERT INTO `abilities` VALUES (217,'rapture',20,55,1,1,231,0,0,174,2000,0,6,20.0,0,1,80,0,16,'WOTG');
INSERT INTO `abilities` VALUES (218,'accession',20,40,1,1,231,0,0,175,2000,0,6,20.0,0,1,80,0,16,'WOTG');
INSERT INTO `abilities` VALUES (219,'parsimony',20,10,1,1,231,0,0,177,2000,0,6,20.0,0,1,80,0,32,'WOTG');
INSERT INTO `abilities` VALUES (220,'alacrity',20,25,1,1,231,0,0,178,2000,0,6,20.0,0,1,80,0,32,'WOTG');
INSERT INTO `abilities` VALUES (221,'ebullience',20,55,1,1,231,0,0,179,2000,0,6,20.0,0,1,80,0,32,'WOTG');
INSERT INTO `abilities` VALUES (222,'manifestation',20,40,1,1,231,0,0,180,2000,0,6,20.0,0,1,80,0,32,'WOTG');
INSERT INTO `abilities` VALUES (223,'stratagems',20,10,1,0,233,0,0,0,2000,0,6,20.0,0,0,0,0,0,'WOTG');
INSERT INTO `abilities` VALUES (224,'velocity_shot',11,45,1,60,129,0,0,186,2000,0,6,20.0,0,1,300,0,0,'WOTG');
INSERT INTO `abilities` VALUES (225,'snarl',9,45,257,30,107,0,0,87,2000,0,6,20.0,0,0,0,0,192,'WOTG');
INSERT INTO `abilities` VALUES (226,'retaliation',1,60,1,180,8,0,0,185,2000,0,6,20.0,0,1,80,0,0,'WOTG');
INSERT INTO `abilities` VALUES (227,'footwork',2,65,1,300,21,0,0,197,2000,0,6,20.0,0,1,80,0,0,'WOTG');
INSERT INTO `abilities` VALUES (228,'despoil',6,77,4,300,61,125,0,181,2000,0,3,4.4,0,1,300,0,0,'ABYSSEA');
INSERT INTO `abilities` VALUES (229,'pianissimo',10,20,1,15,112,0,0,194,2000,0,6,20.0,0,1,60,0,0,'WOTG');
INSERT INTO `abilities` VALUES (230,'sekkanoki',12,40,1,300,140,0,0,199,2000,0,6,20.0,0,1,80,0,0,'WOTG');
INSERT INTO `abilities` VALUES (232,'elemental_siphon',15,50,1,300,175,451,0,201,2000,0,6,20.0,0,1,0,0,0,'WOTG');
INSERT INTO `abilities` VALUES (233,'sublimation',20,35,1,30,234,0,0,189,2000,0,6,20.0,0,1,80,0,0,'WOTG');
INSERT INTO `abilities` VALUES (234,'addendum_white',20,10,1,1,231,0,0,191,2000,0,6,20.0,0,1,80,0,16,'WOTG');
INSERT INTO `abilities` VALUES (235,'addendum_black',20,30,1,1,231,0,0,192,2000,0,6,20.0,0,1,80,0,32,'WOTG');
INSERT INTO `abilities` VALUES (236,'collaborator',6,65,2,60,69,526,0,185,2000,0,6,20.0,0,0,0,0,0,'WOTG');
INSERT INTO `abilities` VALUES (237,'saber_dance',19,75,1,180,219,0,0,207,2000,0,6,20.0,0,1,80,3200,1,'WOTG');
INSERT INTO `abilities` VALUES (238,'fan_dance',19,75,1,180,224,0,0,208,2000,0,6,20.0,0,1,80,3202,1,'WOTG');
INSERT INTO `abilities` VALUES (239,'no_foot_rise',19,75,1,180,223,560,560,209,2000,0,6,20.0,0,1,80,3204,1,'WOTG');
INSERT INTO `abilities` VALUES (240,'altruism',20,75,1,1,231,0,0,210,2000,0,6,20.0,0,1,80,3264,17,'WOTG');
INSERT INTO `abilities` VALUES (241,'focalization',20,75,1,1,231,0,0,212,2000,0,6,20.0,0,1,80,3266,33,'WOTG');
INSERT INTO `abilities` VALUES (242,'tranquility',20,75,1,1,231,0,0,211,2000,0,6,20.0,0,1,80,3268,17,'WOTG');
INSERT INTO `abilities` VALUES (243,'equanimity',20,75,1,1,231,0,0,213,2000,0,6,20.0,0,1,80,3270,33,'WOTG');
INSERT INTO `abilities` VALUES (244,'enlightenment',20,75,1,300,235,0,0,214,2000,0,6,20.0,0,1,80,3272,1,'WOTG');
INSERT INTO `abilities` VALUES (245,'afflatus_solace',3,40,1,60,29,0,0,216,2000,0,6,20.0,0,1,80,0,4,'WOTG');
INSERT INTO `abilities` VALUES (246,'afflatus_misery',3,40,1,60,30,0,0,217,2000,0,6,20.0,0,1,80,0,4,'WOTG');
INSERT INTO `abilities` VALUES (247,'composure',5,50,1,300,50,0,0,215,2000,0,6,20.0,0,1,80,0,0,'WOTG');
INSERT INTO `abilities` VALUES (248,'yonin',13,40,1,180,146,0,0,218,2000,0,6,20.0,0,1,600,0,4,'WOTG');
INSERT INTO `abilities` VALUES (249,'innin',13,40,1,180,147,0,0,219,2000,0,6,20.0,0,1,60,0,4,'WOTG');
-- INSERT INTO `abilities` VALUES (250,'avatars_favor',15,55,4,30,176,100,0,94,2000,0,6,10.0,1,1,80,0,0,NULL);
INSERT INTO `abilities` VALUES (251,'ready',9,25,1,0,255,0,0,83,2000,0,6,18.0,0,0,0,902,64,NULL);
-- INSERT INTO `abilities` VALUES (252,'restraint',1,77,1,600,9,100,0,220,2000,0,6,20.0,0,450,900,0,0,NULL);
INSERT INTO `abilities` VALUES (253,'perfect_counter',2,79,1,60,22,100,0,221,2000,0,6,20.0,0,1,80,0,0,NULL);
INSERT INTO `abilities` VALUES (254,'mana_wall',4,76,1,600,39,0,0,222,2000,0,6,20.0,0,1,0,0,0,NULL);
INSERT INTO `abilities` VALUES (255,'divine_emblem',7,78,1,180,80,100,0,222,2000,0,6,20.0,0,1,3600,0,0,NULL);
INSERT INTO `abilities` VALUES (256,'nether_void',8,78,1,300,91,100,0,224,2000,0,6,20.0,0,1,80,0,0,NULL);
INSERT INTO `abilities` VALUES (257,'double_shot',11,79,1,180,126,0,0,225,2000,0,6,20.0,0,1,80,0,0,'ABYSSEA');
INSERT INTO `abilities` VALUES (258,'sengikori',12,77,1,180,141,100,0,226,2000,0,6,20.0,0,1,80,0,0,NULL);
INSERT INTO `abilities` VALUES (259,'futae',13,77,1,180,148,0,0,227,2000,0,6,20.0,0,1,0,0,0,'ABYSSEA');
INSERT INTO `abilities` VALUES (260,'spirit_jump',14,77,4,60,166,100,0,228,2000,0,6,20.0,0,1,80,1218,0,NULL);
INSERT INTO `abilities` VALUES (261,'presto',19,77,1,15,236,100,0,229,2000,0,6,20.0,0,1,80,0,0,NULL);
INSERT INTO `abilities` VALUES (262,'divine_waltz_ii',19,78,27,20,190,102,0,34,2000,0,14,20.0,0,1,80,0,0,NULL);
INSERT INTO `abilities` VALUES (263,'flourishes_iii',19,80,1,0,226,0,0,0,2000,0,14,20.0,0,0,0,0,0,NULL);
INSERT INTO `abilities` VALUES (264,'climactic_flourish',19,80,1,90,226,529,0,222,2000,0,14,20.0,0,1,80,0,0,NULL);
INSERT INTO `abilities` VALUES (265,'libra',20,76,4,60,237,100,0,231,2000,0,6,11.2,0,0,0,0,0,NULL);
INSERT INTO `abilities` VALUES (266,'tactical_switch',18,79,1,180,213,100,0,232,2000,0,6,11.2,0,0,0,0,0,NULL);
INSERT INTO `abilities` VALUES (267,'blood_rage',1,87,1,300,11,100,0,239,2000,0,6,13.9,1,1,300,0,0,NULL);
INSERT INTO `abilities` VALUES (269,'impetus',2,88,1,360,31,100,0,240,2000,0,6,20.0,0,1,80,0,0,NULL);
INSERT INTO `abilities` VALUES (270,'divine_caress',3,83,1,60,32,100,0,254,2000,0,6,20.0,0,0,0,0,0,NULL);
INSERT INTO `abilities` VALUES (271,'sacrosanctity',3,95,1,600,33,100,0,268,2000,0,6,13.9,1,0,0,0,0,NULL);
INSERT INTO `abilities` VALUES (272,'enmity_douse',4,87,4,600,34,100,0,257,2000,0,6,18.0,0,1,0,0,0,NULL);	--check animation
INSERT INTO `abilities` VALUES (273,'manawell',4,95,1,600,35,100,0,252,2000,0,6,20.0,0,1,80,0,0,NULL);
INSERT INTO `abilities` VALUES (274,'saboteur',5,83,1,300,36,0,0,258,2000,0,6,20.0,0,1,80,0,0,'ABYSSEA');
INSERT INTO `abilities` VALUES (275,'spontaneity',5,95,3,600,37,0,0,259,2000,0,6,20.0,0,1,80,0,0,'ABYSSEA');
INSERT INTO `abilities` VALUES (276,'conspirator',6,87,1,300,40,0,0,237,2000,0,6,14.0,1,1,80,0,4,'ABYSSEA');
INSERT INTO `abilities` VALUES (277,'sepulcher',7,87,4,300,41,100,0,253,2000,0,6,12.0,0,1,80,0,0,NULL);		--needs animation
INSERT INTO `abilities` VALUES (278,'palisade',7,95,1,300,42,100,0,253,2000,0,6,20.0,0,900,1800,0,0,NULL);
INSERT INTO `abilities` VALUES (279,'arcane_crest',8,87,4,300,43,100,0,250,2000,0,6,20.0,0,1,80,0,0,NULL);	--needs animation
INSERT INTO `abilities` VALUES (280,'scarlet_delirium',8,95,1,90,44,100,0,250,2000,0,6,20.0,0,1,80,0,0,NULL);
-- INSERT INTO `abilities` VALUES (281,'spur',9,83,1,180,45,100,0,255,2000,0,6,20.0,0,0,0,0,0,NULL);
-- INSERT INTO `abilities` VALUES (282,'run_wild',9,93,1,900,46,100,0,255,2000,0,6,20.0,0,0,0,0,0,NULL); 		--needs animation
INSERT INTO `abilities` VALUES (283,'tenuto',10,83,1,5,47,0,0,257,2000,0,6,20.0,0,0,0,0,0,'ABYSSEA');
INSERT INTO `abilities` VALUES (284,'marcato',10,95,1,600,48,0,0,251,2000,0,6,20.0,0,0,0,0,0,'ABYSSEA');
INSERT INTO `abilities` VALUES (285,'bounty_shot',11,87,4,60,51,100,0,261,2000,0,6,20.0,0,0,0,0,0,NULL);
INSERT INTO `abilities` VALUES (286,'decoy_shot',11,95,4,300,52,100,0,261,2000,0,6,20.0,0,0,0,0,0,NULL);	--needs animation
INSERT INTO `abilities` VALUES (287,'hamanoha',12,87,4,300,53,100,0,249,2000,0,6,12.0,0,0,0,0,0,NULL);
INSERT INTO `abilities` VALUES (288,'hagakure',12,95,1,180,54,0,0,249,2000,0,6,20.0,0,1,80,0,0,'ABYSSEA');
INSERT INTO `abilities` VALUES (291,'issekigan',13,95,1,300,57,0,0,246,2000,0,6,20.0,0,1,0,0,0,'ABYSSEA');
INSERT INTO `abilities` VALUES (292,'dragon_breaker',14,87,4,300,58,320,0,236,2000,0,6,8.0,0,0,0,0,0,NULL);
INSERT INTO `abilities` VALUES (293,'soul_jump',14,85,4,120,167,100,0,209,2000,0,6,7.0,0,1,0,1220,0,NULL);	--check animation
-- INSERT INTO `abilities` VALUES (295,'steady_wing',14,95,1,300,70,100,0,262,2000,0,6,0.0,0,0,0,0,0,NULL);
INSERT INTO `abilities` VALUES (296,'mana_cede',15,87,1,300,71,100,0,241,2000,0,6,8.0,0,0,0,0,0,NULL);
INSERT INTO `abilities` VALUES (297,'efflux',16,83,1,180,185,100,0,256,2000,0,6,0.0,0,0,0,0,0,NULL);
INSERT INTO `abilities` VALUES (298,'unbridled_learning',16,95,1,300,81,100,0,263,2000,0,6,0.0,0,0,0,0,0,NULL);
INSERT INTO `abilities` VALUES (301,'triple_shot',17,87,1,300,467,100,0,242,2000,0,6,0.0,0,0,0,0,0,NULL);
INSERT INTO `abilities` VALUES (302,'allies_roll',17,89,1,60,193,420,0,138,2000,0,6,8.0,1,1,80,0,8,'ABYSSEA');
INSERT INTO `abilities` VALUES (303,'misers_roll',17,92,1,60,193,420,0,139,2000,0,6,8.0,1,1,80,0,8,'ABYSSEA');
INSERT INTO `abilities` VALUES (304,'companions_roll',17,95,1,60,193,420,0,265,2000,0,6,8.0,1,1,80,0,8,'ABYSSEA');
INSERT INTO `abilities` VALUES (305,'avengers_roll',17,97,1,60,193,420,0,266,2000,0,6,8.0,1,1,80,0,8,'ABYSSEA');
INSERT INTO `abilities` VALUES (309,'cooldown',18,95,1,300,114,0,0,232,2000,0,6,11.2,0,0,0,0,0,NULL);
INSERT INTO `abilities` VALUES (310,'deus_ex_automata',18,5,1,60,115,0,0,83,2000,0,6,20.0,0,1,80,0,0,'ABYSSEA');
INSERT INTO `abilities` VALUES (311,'curing_waltz_v',19,87,27,14,189,102,0,35,2000,0,14,20.0,0,0,0,0,0,'ABYSSEA');
INSERT INTO `abilities` VALUES (312,'feather_step',19,83,4,5,220,591,0,17,2000,0,14,4.5,0,1,0,0,0,NULL);
INSERT INTO `abilities` VALUES (313,'striking_flourish',19,89,1,30,226,0,0,222,2000,0,14,20.0,0,1,80,0,0,NULL);	--check animation/message1
INSERT INTO `abilities` VALUES (314,'ternary_flourish',19,93,1,30,226,0,0,222,2000,0,14,20.0,0,1,80,0,0,NULL);	--check animation/message1
-- INSERT INTO `abilities` VALUES (316,'perpetuance',20,87,1,1,231,100,0,224,2000,0,6,0.0,0,1,80,0,0,NULL);
-- INSERT INTO `abilities` VALUES (317,'immanence',20,87,1,1,231,100,0,245,2000,0,6,0.0,0,1,80,0,0,NULL);
-- INSERT INTO `abilities` VALUES (318,'smiting_breath',14,90,4,60,238,100,0,135,2000,0,6,8.0,0,1,80,0,0,NULL);	--check animation
-- INSERT INTO `abilities` VALUES (319,'restoring_breath',14,90,1,60,239,100,0,130,2000,0,6,0.0,0,1,80,0,0,NULL);	--check animation
INSERT INTO `abilities` VALUES (320,'konzen-ittai',12,65,4,180,132,529,0,39,2000,0,14,4.0,0,1,300,0,0,'ABYSSEA');
INSERT INTO `abilities` VALUES (321,'bully',6,93,4,180,240,127,0,248,2000,0,6,8.0,0,1,300,0,4,'ABYSSEA');
INSERT INTO `abilities` VALUES (322,'maintenance',18,30,1,90,214,0,0,83,2000,0,6,12.0,0,0,0,1474,0,'ABYSSEA'); --ta257
INSERT INTO `abilities` VALUES (323,'brazen_rush',1,96,1,3600,254,100,0,271,2000,0,6,0.0,0,1,300,0,0,NULL);
INSERT INTO `abilities` VALUES (324,'inner_strength',2,96,1,3600,254,100,0,272,2000,0,6,0.0,0,0,0,0,0,NULL);	--check animation
INSERT INTO `abilities` VALUES (325,'asylum',3,96,1,3600,254,100,0,273,2000,0,6,0.0,0,0,0,0,0,NULL);
INSERT INTO `abilities` VALUES (326,'subtle_sorcery',4,96,1,3600,254,0,0,274,2000,0,6,0.0,0,0,0,0,0,NULL);	--check animation
INSERT INTO `abilities` VALUES (327,'stymie',5,96,1,3600,254,100,0,275,2000,0,6,20.0,0,1,80,0,0,'SOA');
INSERT INTO `abilities` VALUES (328,'larceny',6,96,4,3600,254,100,0,276,2000,0,6,4.0,0,0,0,0,0,NULL);
INSERT INTO `abilities` VALUES (329,'intervene',7,96,4,3600,254,100,0,277,2000,0,6,4.0,1,0,340,0,0,NULL);
INSERT INTO `abilities` VALUES (330,'soul_enslavement',8,96,1,3600,254,100,0,278,2000,0,6,0.0,0,0,0,0,0,NULL);
INSERT INTO `abilities` VALUES (331,'unleash',9,96,1,3600,254,100,0,279,2000,0,6,0.0,0,0,0,0,0,NULL);	--check animation
INSERT INTO `abilities` VALUES (332,'clarion_call',10,96,1,3600,254,100,0,280,2000,0,6,0.0,0,0,0,0,0,NULL);	--check animation
INSERT INTO `abilities` VALUES (333,'overkill',11,96,1,3600,254,100,0,281,2000,0,6,0.0,0,0,0,0,0,NULL);
INSERT INTO `abilities` VALUES (334,'yaegasumi',12,96,1,3600,254,100,0,282,2000,0,6,0.0,0,0,0,0,0,NULL);	--check animation
INSERT INTO `abilities` VALUES (335,'mikage',13,96,1,3600,254,0,0,283,2000,0,6,0.0,0,1,80,0,0,'SOA');
INSERT INTO `abilities` VALUES (336,'fly_high',14,96,1,3600,254,0,0,284,2000,0,6,0.0,0,0,0,0,0,NULL);	--check animation
INSERT INTO `abilities` VALUES (337,'astral_conduit',15,96,1,3600,254,0,0,285,2000,0,6,0.0,0,0,0,0,0,NULL);	--check animation
INSERT INTO `abilities` VALUES (338,'unbridled_wisdom',16,96,1,3600,254,100,0,286,2000,0,6,0.0,0,0,0,0,0,NULL);	--check animation
INSERT INTO `abilities` VALUES (339,'cutting_cards',17,96,2,3600,254,0,0,287,2000,0,6,8.0,0,0,0,0,0,NULL);	--check animation
INSERT INTO `abilities` VALUES (340,'heady_artifice',18,96,1,3600,254,0,0,288,2000,0,6,0.0,0,0,0,0,0,NULL);	--check animation
INSERT INTO `abilities` VALUES (341,'gran_pas',19,96,1,3600,254,0,0,289,2000,0,6,0.0,0,0,0,0,0,NULL);	--check animation
INSERT INTO `abilities` VALUES (342,'caper_emissarius',20,96,2,3600,254,0,0,290,2000,0,6,8.0,0,0,0,0,0,NULL);	--check animation
INSERT INTO `abilities` VALUES (343,'bolster',21,1,1,3600,0,0,0,303,2000,0,6,0.0,0,1,300,0,0,'SOA');	--check animation
-- INSERT INTO `abilities` VALUES (344,'swipe',22,25,4,90,241,0,0,302,2000,0,6,4.0,0,80,320,0,0,'SOA');	--check animation 15 cat
INSERT INTO `abilities` VALUES (345,'full_circle',21,5,1,10,1,0,0,94,2000,0,6,0.0,0,1,300,0,0,'SOA');
INSERT INTO `abilities` VALUES (346,'lasting_emanation',21,25,1,300,244,663,0,306,2000,0,6,0.0,0,1,300,0,0,'SOA');
INSERT INTO `abilities` VALUES (347,'ecliptic_attrition',21,25,1,300,244,664,0,307,2000,0,6,0.0,0,1,300,0,0,'SOA');
INSERT INTO `abilities` VALUES (348,'collimated_fervor',21,40,1,300,245,100,0,304,2000,0,6,0.0,0,1,300,0,0,'SOA');
INSERT INTO `abilities` VALUES (349,'life_cycle',21,50,1,600,246,306,0,309,2000,0,6,0.0,0,1,300,0,0,'SOA');
INSERT INTO `abilities` VALUES (350,'blaze_of_glory',21,60,1,600,247,100,0,308,2000,0,6,0.0,0,1,300,0,0,'SOA');
INSERT INTO `abilities` VALUES (351,'dematerialize',21,70,1,600,248,100,0,310,2000,0,6,0.0,0,1,300,0,0,'SOA');
INSERT INTO `abilities` VALUES (352,'theurgic_focus',21,80,1,300,249,100,0,305,2000,0,6,0.0,0,1,300,0,0,'SOA');
INSERT INTO `abilities` VALUES (353,'concentric_pulse',21,90,4,300,250,0,0,311,2000,0,6,8.0,0,1,300,0,0,'SOA');
INSERT INTO `abilities` VALUES (354,'mending_halation',21,75,1,300,251,0,0,311,2000,0,6,10.0,0,1,0,3392,1,'SOA');
INSERT INTO `abilities` VALUES (355,'radial_arcana',21,75,1,300,252,0,0,311,2000,0,6,10.0,0,1,0,3394,1,'SOA');
INSERT INTO `abilities` VALUES (356,'elemental_sforzo',22,0,1,3600,0,0,0,302,2000,0,6,20.0,0,1800,7200,0,0,'SOA');
INSERT INTO `abilities` VALUES (357,'Rune_enchantment',22,5,1,0,92,0,0,0,2000,0,6,20.0,0,0,0,0,0,'SOA');
INSERT INTO `abilities` VALUES (358,'Ignis',22,5,1,5,10,100,0,291,2000,0,6,20.0,0,80,320,0,0,'SOA');
INSERT INTO `abilities` VALUES (359,'Gelus',22,5,1,5,10,100,0,292,2000,0,6,20.0,0,80,320,0,0,'SOA');
INSERT INTO `abilities` VALUES (360,'Flabra',22,5,1,5,10,100,0,293,2000,0,6,20.0,0,80,320,0,0,'SOA');
INSERT INTO `abilities` VALUES (361,'Tellus',22,5,1,5,10,100,0,294,2000,0,6,20.0,0,80,320,0,0,'SOA');
INSERT INTO `abilities` VALUES (362,'Sulpor',22,5,1,5,10,100,0,295,2000,0,6,20.0,0,80,320,0,0,'SOA');
INSERT INTO `abilities` VALUES (363,'Unda',22,5,1,5,10,100,0,296,2000,0,6,20.0,0,80,320,0,0,'SOA');
INSERT INTO `abilities` VALUES (364,'Lux',22,5,1,5,10,100,0,297,2000,0,6,20.0,0,80,320,0,0,'SOA');
INSERT INTO `abilities` VALUES (365,'Tenebrae',22,5,1,5,10,100,0,298,2000,0,6,20.0,0,80,320,0,0,'SOA');
-- INSERT INTO `abilities` VALUES (366,'Vallation',22,10,1,180,23,668,0,0,2000,0,15,0.0,0,450,900,1794,0,'SOA'); --check merit
INSERT INTO `abilities` VALUES (367,'Swordplay',22,20,1,300,24,667,0,299,2000,0,6,20.0,0,160,320,0,0,'SOA');
-- INSERT INTO `abilities` VALUES (368,'Lunge',22,25,4,180,25,110,0,8,2000,0,15,4.0,0,0,0,1796,0,'SOA'); --check merit
-- INSERT INTO `abilities` VALUES (369,'Pflug',22,40,1,180,59,671,0,1,2000,0,15,0.0,0,450,900,1798,0,'SOA'); --check merit
INSERT INTO `abilities` VALUES (370,'Embolden',22,60,1,600,72,100,0,300,2000,0,6,0.0,0,160,320,0,0,'SOA');
-- INSERT INTO `abilities` VALUES (371,'Valiance',22,50,1,300,113,668,0,2,2000,0,15,0.0,0,450,900,0,0,'SOA');
-- INSERT INTO `abilities` VALUES (372,'Gambit',22,70,4,300,116,0,0,4,2000,0,15,4.0,0,640,1280,1800,0,'SOA');	--check animation
-- INSERT INTO `abilities` VALUES (373,'Liement',22,85,1,180,117,0,0,4,2000,0,15,0.0,0,450,900,0,0,'SOA');	--check animation
INSERT INTO `abilities` VALUES (374,'One_for_all',22,95,1,300,118,100,0,301,2000,0,6,0.0,1,160,320,0,0,'SOA');
-- INSERT INTO `abilities` VALUES (375,'Rayke',22,75,4,300,119,0,0,4,2000,0,15,4.0,0,640,1260,0,0,'SOA');	--check animation
-- INSERT INTO `abilities` VALUES (376,'Battuta',22,75,1,300,120,100,0,4,2000,0,15,0.0,0,450,900,0,0,'SOA');
INSERT INTO `abilities` VALUES (377,'widened_compass',21,96,1,3600,130,100,0,276,2000,0,6,0.0,0,1,300,0,0,'SOA');
-- INSERT INTO `abilities` VALUES (378,'odyllic_subterfuge',22,96,4,3600,131,0,0,10,2000,0,15,8.0,15,1,318,0,0,NULL); --check 6 or 15 animation
INSERT INTO `abilities` VALUES (379,'Ward',22,1,1,0,142,0,0,0,2000,0,6,0.0,0,0,0,0,0,NULL);
INSERT INTO `abilities` VALUES (380,'Effusion',22,1,1,0,143,0,0,0,2000,0,6,0.0,0,0,0,0,0,NULL);
INSERT INTO `abilities` VALUES (381,'chocobo_jig_ii',19,70,1,60,218,126,0,13,2000,0,14,0.0,1,1,300,0,0,'SOA');
-- INSERT INTO `abilities` VALUES (382,'relinquish',23,1,1,60,253,0,0,0,0,0,6,0.0,0,0,0,0,0,NULL);
INSERT INTO `abilities` VALUES (383,'vivacious_pulse',22,65,1,60,242,102,0,327,2000,0,6,0.0,0,0,0,0,0,NULL);
INSERT INTO `abilities` VALUES (384,'contradance',19,50,1,300,229,0,0,329,2000,0,6,0.0,0,0,0,0,0,NULL);	--check animation
INSERT INTO `abilities` VALUES (385,'apogee',15,70,1,180,108,100,0,94,2000,0,6,0.0,0,1,80,0,0,'SOA');
INSERT INTO `abilities` VALUES (386,'entrust',21,75,1,600,93,100,0,332,2000,0,6,0.0,0,1,300,0,0,'SOA');
INSERT INTO `abilities` VALUES (387,'bestial_loyalty',9,23,1,1200,94,100,0,83,2000,0,6,18.0,0,1,0,900,0,'SOA');
INSERT INTO `abilities` VALUES (388,'cascade',4,85,1,60,12,100,0,333,2000,0,6,0.0,0,0,0,0,0,NULL);	--check animation
INSERT INTO `abilities` VALUES (389,'consume_mana',8,55,1,60,95,0,0,337,2000,0,6,0.0,0,1,1300,0,0,'SOA');
INSERT INTO `abilities` VALUES (390,'naturalists_roll',17,67,1,60,193,420,0,328,2000,0,6,8.0,1,1,80,0,8,'SOA'); -- No Enhancing Magic Duration MOD, Empty PH effect exists
INSERT INTO `abilities` VALUES (391,'runeists_roll',17,70,1,60,193,420,0,329,2000,0,6,8.0,1,1,80,0,8,'SOA');
INSERT INTO `abilities` VALUES (392,'crooked_cards',17,95,1,600,96,100,0,335,2000,0,6,0.0,0,0,0,0,0,NULL);
INSERT INTO `abilities` VALUES (393,'spirit_bond',14,65,1,60,149,100,0,86,2000,0,6,18.0,0,0,0,0,0,NULL);
INSERT INTO `abilities` VALUES (394,'majesty',7,70,1,60,150,100,0,338,2000,0,6,0.0,1,0,340,0,0,NULL);
INSERT INTO `abilities` VALUES (512,'healing_ruby',15,1,3,60,174,0,0,6,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (513,'poison_nails',15,5,4,60,173,0,0,11,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (514,'shining_ruby',15,24,1,60,174,0,0,44,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (515,'glittering_ruby',15,44,1,60,174,0,0,62,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (516,'meteorite',15,55,4,60,173,0,0,108,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (517,'healing_ruby_ii',15,65,1,60,174,0,0,124,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (518,'searing_light',15,1,4,60,173,0,0,0,2000,0,6,18.0,1,1,60,0,2,NULL);
-- INSERT INTO `abilities` VALUES (519,'holy_mist',job,level,target,recastime,recastid,m1,0,animation,2000,0,6,range,0,ce,ve,meritid,addtype,NULL);
-- INSERT INTO `abilities` VALUES (520,'soothing_ruby',job,level,target,recastime,recastid,m1,0,animation,2000,0,6,range,0,ce,ve,meritid,addtype,NULL);
-- INSERT INTO `abilities` VALUES (521,'regal_scratch',job,level,target,recastime,recastid,m1,0,animation,2000,0,6,range,0,ce,ve,meritid,addtype,NULL);
-- INSERT INTO `abilities` VALUES (522,'mewing_lullaby',job,level,target,recastime,recastid,m1,0,animation,2000,0,6,range,0,ce,ve,meritid,addtype,NULL);
-- INSERT INTO `abilities` VALUES (523,'earie_eye',job,level,target,recastime,recastid,m1,0,animation,2000,0,6,range,0,ce,ve,meritid,addtype,NULL);
-- INSERT INTO `abilities` VALUES (524,'level_qm_holy',job,level,target,recastime,recastid,m1,0,animation,2000,0,6,range,0,ce,ve,meritid,addtype,NULL);
-- INSERT INTO `abilities` VALUES (525,'raise_ii',job,level,target,recastime,recastid,m1,0,animation,2000,0,6,range,0,ce,ve,meritid,addtype,NULL);
-- INSERT INTO `abilities` VALUES (526,'reraise_ii',job,level,target,recastime,recastid,m1,0,animation,2000,0,6,range,0,ce,ve,meritid,addtype,NULL);
-- INSERT INTO `abilities` VALUES (527,'altana_s_favor',job,level,target,recastime,recastid,m1,0,animation,2000,0,6,range,0,ce,ve,meritid,addtype,NULL);
INSERT INTO `abilities` VALUES (528,'moonlit_charge',15,5,4,60,173,0,0,17,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (529,'crescent_fang',15,10,4,60,173,0,0,19,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (530,'lunar_cry',15,21,4,60,174,0,0,41,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (531,'lunar_roar',15,32,4,60,174,0,0,27,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (532,'ecliptic_growl',15,43,1,60,174,0,0,46,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (533,'ecliptic_howl',15,54,1,60,174,0,0,57,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (534,'eclipse_bite',15,65,4,60,173,0,0,109,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (536,'howling_moon',15,1,4,60,173,0,0,0,2000,0,6,18.0,1,1,60,0,2,NULL);
-- INSERT INTO `abilities` VALUES (537,'lunar_bay',job,level,target,recastime,recastid,m1,0,animation,2000,0,6,range,0,ce,ve,meritid,addtype,NULL);
-- INSERT INTO `abilities` VALUES (538,'heavenward_howl',job,level,target,recastime,recastid,m1,0,animation,2000,0,6,range,0,ce,ve,meritid,addtype,NULL);
-- INSERT INTO `abilities` VALUES (539,'impact',job,level,target,recastime,recastid,m1,0,animation,2000,0,6,range,0,ce,ve,meritid,addtype,NULL);
INSERT INTO `abilities` VALUES (544,'punch',15,1,4,60,173,0,0,9,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (545,'fire_ii',15,10,4,60,173,0,0,24,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (546,'burning_strike',15,23,4,60,173,0,0,48,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (547,'double_punch',15,30,4,60,173,0,0,56,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (548,'crimson_howl',15,38,1,60,174,0,0,84,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (549,'fire_iv',15,60,4,60,173,0,0,118,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (550,'flaming_crush',15,70,4,60,173,0,0,164,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (551,'meteor_strike',15,75,4,60,173,0,0,182,2000,0,6,18.0,0,1,60,2944,1,'TOAU');
INSERT INTO `abilities` VALUES (552,'inferno',15,1,4,60,173,0,0,0,2000,0,6,18.0,1,1,60,0,2,NULL);
-- INSERT INTO `abilities` VALUES (553,'inferno_howl',job,level,target,recastime,recastid,m1,0,animation,2000,0,6,range,0,ce,ve,meritid,addtype,NULL);
-- INSERT INTO `abilities` VALUES (554,'conflag_strike',job,level,target,recastime,recastid,m1,0,animation,2000,0,6,range,0,ce,ve,meritid,addtype,NULL);
INSERT INTO `abilities` VALUES (560,'rock_throw',15,1,4,60,173,0,0,10,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (561,'stone_ii',15,10,4,60,173,0,0,24,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (562,'rock_buster',15,21,4,60,173,0,0,39,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (563,'megalith_throw',15,35,4,60,173,0,0,62,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (564,'earthen_ward',15,46,1,60,174,0,0,92,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (565,'stone_iv',15,60,4,60,173,0,0,118,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (566,'mountain_buster',15,70,4,60,173,0,0,164,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (567,'geocrush',15,75,4,60,173,0,0,182,2000,0,6,18.0,0,1,60,2950,1,'TOAU');
INSERT INTO `abilities` VALUES (568,'earthen_fury',15,1,4,60,173,0,0,0,2000,0,6,18.0,1,1,60,0,2,NULL);
-- INSERT INTO `abilities` VALUES (569,'earthen_armor',job,level,target,recastime,recastid,m1,0,animation,2000,0,6,range,0,ce,ve,meritid,addtype,NULL);
-- INSERT INTO `abilities` VALUES (570,'crag_throw',job,level,target,recastime,recastid,m1,0,animation,2000,0,6,range,0,ce,ve,meritid,addtype,NULL);
INSERT INTO `abilities` VALUES (576,'barracuda_dive',15,1,4,60,173,0,0,8,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (577,'water_ii',15,10,4,60,173,0,0,24,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (578,'tail_whip',15,26,4,60,173,0,0,49,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (579,'spring_water',15,47,1,60,174,0,0,99,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (580,'slowga',15,33,4,60,174,0,0,48,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (581,'water_iv',15,60,4,60,173,0,0,118,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (582,'spinning_dive',15,70,4,60,173,0,0,164,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (583,'grand_fall',15,75,4,60,173,0,0,182,2000,0,6,18.0,0,1,60,2954,1,'TOAU');
INSERT INTO `abilities` VALUES (584,'tidal_wave',15,1,4,60,173,0,0,0,2000,0,6,18.0,1,1,60,0,2,NULL);
-- INSERT INTO `abilities` VALUES (585,'tidal_roar',job,level,target,recastime,recastid,m1,0,animation,2000,0,6,range,0,ce,ve,meritid,addtype,NULL);
-- INSERT INTO `abilities` VALUES (586,'soothing_current',job,level,target,recastime,recastid,m1,0,animation,2000,0,6,range,0,ce,ve,meritid,addtype,NULL);
INSERT INTO `abilities` VALUES (592,'claw',15,1,4,60,173,0,0,7,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (593,'aero_ii',15,10,4,60,173,0,0,24,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (594,'whispering_wind',15,36,1,60,174,0,0,119,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (595,'hastega',15,48,1,60,174,0,0,112,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (596,'aerial_armor',15,25,1,60,174,0,0,92,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (597,'aero_iv',15,60,4,60,173,0,0,118,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (598,'predator_claws',15,70,4,60,173,0,0,164,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (599,'wind_blade',15,75,4,60,173,0,0,182,2000,0,6,18.0,0,1,60,2948,1,'TOAU');
INSERT INTO `abilities` VALUES (600,'aerial_blast',15,1,4,60,173,0,0,0,2000,0,6,18.0,1,1,60,0,2,NULL);
-- INSERT INTO `abilities` VALUES (601,'fleet_wind',job,level,target,recastime,recastid,m1,0,animation,2000,0,6,range,0,ce,ve,meritid,addtype,NULL);
-- INSERT INTO `abilities` VALUES (602,'hastega_ii',job,level,target,recastime,recastid,m1,0,animation,2000,0,6,range,0,ce,ve,meritid,addtype,NULL);
INSERT INTO `abilities` VALUES (608,'axe_kick',15,1,4,60,173,0,0,10,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (609,'blizzard_ii',15,10,4,60,173,0,0,24,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (610,'frost_armor',15,28,1,60,174,0,0,63,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (611,'sleepga',15,39,4,60,174,0,0,56,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (612,'double_slap',15,50,4,60,173,0,0,96,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (613,'blizzard_iv',15,60,4,60,173,0,0,118,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (614,'rush',15,70,4,60,173,0,0,164,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (615,'heavenly_strike',15,75,4,60,173,0,0,182,2000,0,6,18.0,0,1,60,2946,1,'TOAU');
INSERT INTO `abilities` VALUES (616,'diamond_dust',15,1,4,60,173,0,0,0,2000,0,6,18.0,0,1,60,0,2,NULL);
-- INSERT INTO `abilities` VALUES (617,'diamond_storm',job,level,target,recastime,recastid,m1,0,animation,2000,0,6,range,0,ce,ve,meritid,addtype,NULL);
-- INSERT INTO `abilities` VALUES (618,'crystal_blessing',job,level,target,recastime,recastid,m1,0,animation,2000,0,6,range,0,ce,ve,meritid,addtype,NULL);
INSERT INTO `abilities` VALUES (624,'shock_strike',15,1,4,60,173,0,0,6,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (625,'thunder_ii',15,10,4,60,173,0,0,24,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (626,'rolling_thunder',15,31,1,60,174,0,0,52,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (627,'thunderspark',15,19,4,60,173,0,0,38,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (628,'lightning_armor',15,42,1,60,174,0,0,91,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (629,'thunder_iv',15,60,4,60,173,0,0,118,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (630,'chaotic_strike',15,70,4,60,173,0,0,164,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (631,'thunderstorm',15,75,4,60,173,0,0,182,2000,0,6,18.0,0,1,60,2952,1,'TOAU');
INSERT INTO `abilities` VALUES (632,'judgment_bolt',15,1,4,60,173,0,0,0,2000,0,6,18.0,0,1,60,0,2,NULL);
-- INSERT INTO `abilities` VALUES (633,'shock_squall',job,level,target,recastime,recastid,m1,0,animation,2000,0,6,range,0,ce,ve,meritid,addtype,NULL);
-- INSERT INTO `abilities` VALUES (634,'volt_strike',job,level,target,recastime,recastid,m1,0,animation,2000,0,6,range,0,ce,ve,meritid,addtype,NULL);
INSERT INTO `abilities` VALUES (639,'healing_breath_iv',0,80,2,0,0,0,0,156,2000,1500,13,13.0,0,0,0,0,0,NULL);
INSERT INTO `abilities` VALUES (640,'healing_breath',0,1,2,0,0,0,0,128,2000,1500,13,13.0,0,0,0,0,0,NULL);
INSERT INTO `abilities` VALUES (641,'healing_breath_ii',0,20,2,0,0,0,0,129,2000,1500,13,13.0,0,0,0,0,0,NULL);
INSERT INTO `abilities` VALUES (642,'healing_breath_iii',0,40,2,0,0,0,0,130,2000,1500,13,13.0,0,0,0,0,0,NULL);
INSERT INTO `abilities` VALUES (643,'remove_poison',0,1,2,0,0,0,0,131,2000,1500,13,13.0,0,0,0,0,0,NULL);
INSERT INTO `abilities` VALUES (644,'remove_blindness',0,20,2,0,0,0,0,132,2000,1500,13,13.0,0,0,0,0,0,NULL);
INSERT INTO `abilities` VALUES (645,'remove_paralysis',0,40,2,0,0,0,0,133,2000,1500,13,13.0,0,0,0,0,0,NULL);
INSERT INTO `abilities` VALUES (646,'flame_breath',0,1,4,0,0,0,0,134,2000,1500,13,13.0,0,0,0,0,0,NULL);
INSERT INTO `abilities` VALUES (647,'frost_breath',0,1,4,0,0,0,0,135,2000,1500,13,13.0,0,0,0,0,0,NULL);
INSERT INTO `abilities` VALUES (648,'gust_breath',0,1,4,0,0,0,0,136,2000,1500,13,13.0,0,0,0,0,0,NULL);
INSERT INTO `abilities` VALUES (649,'sand_breath',0,1,4,0,0,0,0,137,2000,1500,13,13.0,0,0,0,0,0,NULL);
INSERT INTO `abilities` VALUES (650,'lightning_breath',0,1,4,0,0,0,0,138,2000,1500,13,13.0,0,0,0,0,0,NULL);
INSERT INTO `abilities` VALUES (651,'hydro_breath',0,1,4,0,0,0,0,139,2000,1500,13,13.0,0,0,0,0,0,NULL);
INSERT INTO `abilities` VALUES (652,'super_climb',0,50,1,0,0,0,0,140,2000,0,13,18.0,0,0,0,0,0,NULL);
INSERT INTO `abilities` VALUES (653,'remove_curse',0,60,2,0,0,0,0,157,2000,1500,13,13.0,0,0,0,0,0,NULL);
INSERT INTO `abilities` VALUES (654,'remove_disease',0,80,2,0,0,0,0,158,2000,1500,13,13.0,0,0,0,0,0,NULL);
INSERT INTO `abilities` VALUES (656,'camisado',15,1,4,60,173,0,0,20,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (657,'somnolence',15,20,4,60,174,0,0,30,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (658,'nightmare',15,29,4,60,174,0,0,42,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (659,'ultimate_terror',15,37,4,60,174,0,0,27,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (660,'noctoshield',15,49,1,60,174,0,0,92,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (661,'dream_shroud',15,56,1,60,174,0,0,121,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (662,'nether_blast',15,65,4,60,173,0,0,109,2000,0,6,18.0,0,1,60,0,0,NULL);
-- INSERT INTO `abilities` VALUES (663,'cacodemonia',job,level,target,recastime,recastid,m1,0,animation,2000,0,6,range,0,ce,ve,meritid,addtype,NULL);
-- INSERT INTO `abilities` VALUES (664,'ruinous_omen',job,level,target,recastime,recastid,m1,0,animation,2000,0,6,range,0,ce,ve,meritid,addtype,NULL);
-- INSERT INTO `abilities` VALUES (665,'night_terror',job,level,target,recastime,recastid,m1,0,animation,2000,0,6,range,0,ce,ve,meritid,addtype,NULL);
-- INSERT INTO `abilities` VALUES (666,'pavor_nocturnus',job,level,target,recastime,recastid,m1,0,animation,2000,0,6,range,0,ce,ve,meritid,addtype,NULL);
-- INSERT INTO `abilities` VALUES (667,'blindside',job,level,target,recastime,recastid,m1,0,animation,2000,0,6,range,0,ce,ve,meritid,addtype,NULL);
-- INSERT INTO `abilities` VALUES (668,'deconstruction',job,level,target,recastime,recastid,m1,0,animation,2000,0,6,range,0,ce,ve,meritid,addtype,NULL);
-- INSERT INTO `abilities` VALUES (669,'chronoshift',job,level,target,recastime,recastid,m1,0,animation,2000,0,6,range,0,ce,ve,meritid,addtype,NULL);
-- INSERT INTO `abilities` VALUES (670,'zantetsuken',job,level,target,recastime,recastid,m1,0,animation,2000,0,6,range,0,ce,ve,meritid,addtype,NULL);
-- INSERT INTO `abilities` VALUES (671,'perfect Defense',job,level,target,recastime,recastid,m1,0,animation,2000,0,6,range,0,ce,ve,meritid,addtype,NULL);
INSERT INTO `abilities` VALUES (672,'foot_kick',9,25,257,1,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (673,'dust_cloud',9,25,257,1,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (674,'whirl_claws',9,25,257,1,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (675,'head_butt',9,25,257,1,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (676,'dream_flower',9,25,257,2,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (677,'wild_oats',9,25,257,1,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (678,'leaf_dagger',9,25,257,1,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (679,'scream',9,25,257,1,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (680,'roar',9,25,257,2,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (681,'razor_fang',9,25,257,1,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (682,'claw_cyclone',9,25,257,1,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (683,'tail_blow',9,25,257,1,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (684,'fireball',9,25,257,1,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (685,'blockhead',9,25,257,1,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (686,'brain_crush',9,25,257,1,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (687,'infrasonics',9,25,257,2,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (688,'secretion',9,25,257,1,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (689,'lamb_chop',9,25,257,1,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (690,'rage',9,25,257,2,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (691,'sheep_charge',9,25,257,1,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (692,'sheep_song',9,25,257,2,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (693,'bubble_shower',9,25,257,1,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (694,'bubble_curtain',9,25,257,3,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (695,'big_scissors',9,25,257,1,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (696,'scissor_guard',9,25,257,2,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (697,'metallic_body',9,25,257,1,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (698,'needleshot',9,25,257,1,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (699,'qmqmqm_needles',9,25,257,3,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (700,'frogkick',9,25,257,1,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (701,'spore',9,25,257,1,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (702,'queasyshroom',9,25,257,1,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (703,'numbshroom',9,25,257,2,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (704,'shakeshroom',9,25,257,2,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (705,'silence_gas',9,25,257,3,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (706,'dark_spore',9,25,257,3,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (707,'power_attack',9,25,257,1,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (708,'hi-freq_field',9,25,257,2,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (709,'rhino_attack',9,25,257,1,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (710,'rhino_guard',9,25,257,1,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (711,'spoil',9,25,257,1,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (712,'cursed_sphere',9,25,257,1,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (713,'venom',9,25,257,1,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (714,'sandblast',9,25,257,1,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (715,'sandpit',9,25,257,2,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (716,'venom_spray',9,25,257,2,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (717,'mandibular_bite',9,25,257,1,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (718,'soporific',9,25,257,1,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (719,'gloeosuccus',9,25,257,2,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (720,'palsy_pollen',9,25,257,1,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (721,'geist_wall',9,25,257,1,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (722,'numbing_noise',9,25,257,1,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (723,'nimble_snap',9,25,257,1,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (724,'cyclotail',9,25,257,1,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (725,'toxic_spit',9,25,257,2,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (726,'double_claw',9,25,257,1,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (727,'grapple',9,25,257,1,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (728,'spinning_top',9,25,257,1,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (729,'filamented_hold',9,25,257,2,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (730,'chaotic_eye',9,25,257,1,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (731,'blaster',9,25,257,2,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (732,'suction',9,25,257,1,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (733,'drainkiss',9,25,257,1,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (734,'snow_cloud',9,25,257,1,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (735,'wild_carrot',9,25,257,2,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (736,'sudden_lunge',9,25,257,2,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (737,'spiral_spin',9,25,257,2,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (738,'noisome_powder',9,25,257,2,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (740,'acid_mist',10,25,257,2,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (741,'tp_drainkiss',10,25,257,3,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (743,'scythe_tail',9,26,257,1,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (744,'ripper_fang',9,26,257,1,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (745,'chomp_rush',9,25,257,3,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (746,'charged_whisker',9,26,257,2,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (747,'purulent_ooze',9,25,257,2,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (748,'corrosive_ooze',9,25,257,3,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (749,'back_heel',9,25,257,2,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (750,'jettatura',9,25,257,4,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (751,'choke_breath',9,25,257,2,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (752,'fantod',9,25,257,2,103,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (753,'tortoise_stomp',9,25,257,3,102,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (754,'harden_shell',9,25,257,2,103,0,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (755,'aqua_breath',9,25,257,3,102,1,0,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (756,'wing_slap',9,25,257,2,102,0,1,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (757,'beak_lunge',9,25,257,1,102,0,1,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (758,'intimidate',9,25,257,2,102,0,1,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (759,'recoil_dive',9,25,257,1,102,0,1,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (760,'water_wall',9,25,257,3,102,0,0,1,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (761,'sensilla_blades',9,25,257,2,102,0,1,0,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (762,'tegmina_buffet',9,25,257,2,102,0,0,1,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (763,'molting_plumage',9,25,257,1,102,0,0,1,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (764,'swooping_frenzy',9,25,257,2,102,0,0,1,2000,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (765,'sweeping_gouge',9,25,257,1,102,0,0,0,2001,0,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (766,'zealous_snort',9,25,257,3,102,0,0,0,2000,1,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (767,'pentapeck',9,25,257,3,102,0,0,0,2000,0,7,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (768,'tickling_tendrils',9,25,257,1,102,0,0,0,2000,1,6,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (769,'stink_bomb',9,25,257,2,102,0,0,0,2000,0,6,19.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (770,'nectarous_deluge',9,25,257,2,102,0,0,0,2000,0,7,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (771,'nepenthic_plunge',9,25,257,3,102,0,0,0,2000,0,7,18.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (772,'somersault',9,25,257,1,102,0,0,0,2000,0,6,19.0,0,1,60,0,0,NULL);
-- INSERT INTO `abilities` VALUES (773,'pacifying_ruby',9,25,257,1,102,0,0,0,2000,0,6,19.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (774,'foul_waters',9,25,257,255,102,0,0,0,2000,0,6,19.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (775,'pestilent_plume',9,25,257,255,102,0,0,0,2000,0,6,19.0,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (776,'pecking_flurry',9,25,257,255,102,0,0,0,2000,0,6,18.1,0,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (777,'sickle_slash',9,25,257,255,102,0,0,0,2000,0,6,18.0,1,1,60,0,0,NULL);
INSERT INTO `abilities` VALUES (778,'acid_spray',9,25,257,255,102,0,0,0,2000,0,6,18.0,0,2,60,0,0,NULL);
INSERT INTO `abilities` VALUES (779,'spider_web',9,25,257,255,102,0,0,0,2000,0,6,18.0,0,2,60,0,0,NULL);
-- INSERT INTO `abilities` VALUES (780,'regal_gash',job,level,target,recastime,recastid,m1,0,animation,2000,0,6,range,0,ce,ve,meritid,addtype,NULL);
-- INSERT INTO `abilities` VALUES (781,'infected_leech',9,25,257,rec,102,0,0,0,2000,0,6,18.0,1,1,60,0,0,NULL); -- ROTZ
-- INSERT INTO `abilities` VALUES (782,'gloom_spray',9,25,257,rec,102,0,0,0,2000,0,6,18.0,0,2,60,0,0,NULL); -- ROTZ
-- INSERT INTO `abilities` VALUES (786,'disembowel',03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,19,NULL);
-- INSERT INTO `abilities` VALUES (787,'extirpating_salvo',job,level,target,recastime,recastid,m1,0,animation,2000,0,6,range,0,ce,ve,meritid,addtype,NULL);
-- INSERT INTO `abilities` VALUES (960,'clarsach_call',job,level,target,recastime,recastid,m1,0,animation,2000,0,6,range,0,ce,ve,meritid,addtype,NULL);
-- INSERT INTO `abilities` VALUES (961,'welt',job,level,target,recastime,recastid,m1,0,animation,2000,0,6,range,0,ce,ve,meritid,addtype,NULL);
-- INSERT INTO `abilities` VALUES (962,'katabatic_blades',job,level,target,recastime,recastid,m1,0,animation,2000,0,6,range,0,ce,ve,meritid,addtype,NULL);
-- INSERT INTO `abilities` VALUES (963,'lunatic_voice',job,level,target,recastime,recastid,m1,0,animation,2000,0,6,range,0,ce,ve,meritid,addtype,NULL);
-- INSERT INTO `abilities` VALUES (964,'roundhouse',job,level,target,recastime,recastid,m1,0,animation,2000,0,6,range,0,ce,ve,meritid,addtype,NULL);
-- INSERT INTO `abilities` VALUES (965,'chinook',job,level,target,recastime,recastid,m1,0,animation,2000,0,6,range,0,ce,ve,meritid,addtype,NULL);
-- INSERT INTO `abilities` VALUES (966,'bitter_elegy',job,level,target,recastime,recastid,m1,0,animation,2000,0,6,range,0,ce,ve,meritid,addtype,NULL);
-- INSERT INTO `abilities` VALUES (968,'tornado_ii',job,level,target,recastime,recastid,m1,0,animation,2000,0,6,range,0,ce,ve,meritid,addtype,NULL);
-- INSERT INTO `abilities` VALUES (969,'wind_s_blessing',job,level,target,recastime,recastid,m1,0,animation,2000,0,6,range,0,ce,ve,meritid,addtype,NULL);

-- Dump completed on 2017-01-31 10:57:44 updated on 2020-06-30 14:22:34
-- 
