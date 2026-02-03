SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Table structure for table `pet_list`
--

DROP TABLE IF EXISTS `pet_list`;
CREATE TABLE IF NOT EXISTS `pet_list` (
  `petid` int(10) unsigned NOT NULL,
  `name` char(15) NOT NULL,
  `poolid` int(10) unsigned NOT NULL DEFAULT '0',
  `minLevel` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `maxLevel` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `time` int(10) unsigned NOT NULL DEFAULT '0',
  `element` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `damageType` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`petid`)
) ENGINE=Aria TRANSACTIONAL=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- damageType ENUMs

--    NONE      = 0,
--    PIERCING  = 1,
--    SLASHING  = 2,
--    IMPACT    = 3,
--    HTH       = 4,

INSERT INTO `pet_list` VALUES (0,'FireSpirit',5830,1,99,0,1,2);
INSERT INTO `pet_list` VALUES (1,'IceSpirit',5831,1,99,0,2,2);
INSERT INTO `pet_list` VALUES (2,'AirSpirit',5832,1,99,0,3,2);
INSERT INTO `pet_list` VALUES (3,'EarthSpirit',5833,1,99,0,4,2);
INSERT INTO `pet_list` VALUES (4,'ThunderSpirit',5834,1,99,0,5,2);
INSERT INTO `pet_list` VALUES (5,'WaterSpirit',5835,1,99,0,6,2);
INSERT INTO `pet_list` VALUES (6,'LightSpirit',5836,1,99,0,7,2);
INSERT INTO `pet_list` VALUES (7,'DarkSpirit',5837,1,99,0,8,2);
INSERT INTO `pet_list` VALUES (8,'Carbuncle',4588,1,99,0,7,2);
INSERT INTO `pet_list` VALUES (9,'Fenrir',4581,1,99,0,8,2);
INSERT INTO `pet_list` VALUES (10,'Ifrit',4582,1,99,0,1,2);
INSERT INTO `pet_list` VALUES (11,'Titan',4583,1,99,0,4,2);
INSERT INTO `pet_list` VALUES (12,'Leviathan',4584,1,99,0,6,2);
INSERT INTO `pet_list` VALUES (13,'Garuda',4585,1,99,0,3,2);
INSERT INTO `pet_list` VALUES (14,'Shiva',4586,1,99,0,2,2);
INSERT INTO `pet_list` VALUES (15,'Ramuh',4587,1,99,0,5,2);
INSERT INTO `pet_list` VALUES (16,'Diabolos',4590,1,99,0,8,2);
INSERT INTO `pet_list` VALUES (17,'Alexander',4589,1,99,0,7,2);
INSERT INTO `pet_list` VALUES (18,'Odin',4591,1,99,0,8,2);
INSERT INTO `pet_list` VALUES (19,'Atomos',7297,1,99,0,0,2);
INSERT INTO `pet_list` VALUES (20,'Cait Sith',5775,1,99,0,7,2);
INSERT INTO `pet_list` VALUES (21,'SheepFamiliar',4598,23,35,3600,0,3);
INSERT INTO `pet_list` VALUES (22,'HareFamiliar',4641,23,35,5400,0,3);
INSERT INTO `pet_list` VALUES (23,'CrabFamiliar',4610,23,55,1800,0,3);
INSERT INTO `pet_list` VALUES (24,'CourierCarrie',4611,23,75,1800,0,3);
INSERT INTO `pet_list` VALUES (25,'Homunculus',4616,23,75,3600,0,3);
INSERT INTO `pet_list` VALUES (26,'FlytrapFamiliar',4619,28,40,3600,0,3);
INSERT INTO `pet_list` VALUES (27,'TigerFamiliar',4604,28,40,3600,0,3);
INSERT INTO `pet_list` VALUES (28,'FlowerpotBill',4602,28,40,3600,0,3);
INSERT INTO `pet_list` VALUES (29,'EftFamiliar',4621,33,45,3600,0,3);
INSERT INTO `pet_list` VALUES (30,'LizardFamiliar',4600,33,45,3600,0,3);
INSERT INTO `pet_list` VALUES (31,'MayflyFamiliar',4596,33,45,3600,0,3);
INSERT INTO `pet_list` VALUES (32,'FunguarFamiliar',4614,33,65,3600,0,3);
INSERT INTO `pet_list` VALUES (33,'BeetleFamiliar',4606,38,45,3600,0,3);
INSERT INTO `pet_list` VALUES (34,'AntlionFamiliar',4625,38,50,3600,0,3);
INSERT INTO `pet_list` VALUES (35,'MiteFamiliar',4623,43,55,3600,0,3);
INSERT INTO `pet_list` VALUES (36,'LullabyMelodia',4599,43,55,3600,0,3);
INSERT INTO `pet_list` VALUES (37,'KeenearedSteffi',4595,43,55,5400,0,3);
INSERT INTO `pet_list` VALUES (38,'FlowerpotBen',4603,51,63,3600,0,3);
INSERT INTO `pet_list` VALUES (39,'SaberSiravarde',4605,51,63,3600,0,3);
INSERT INTO `pet_list` VALUES (40,'ColdbloodComo',4601,53,65,3600,0,3);
INSERT INTO `pet_list` VALUES (41,'ShellbusterOrob',4597,53,65,3600,0,3);
INSERT INTO `pet_list` VALUES (42,'VoraciousAudrey',4620,53,75,3600,0,3);
INSERT INTO `pet_list` VALUES (43,'AmbusherAllie',4622,58,75,3600,0,3);
INSERT INTO `pet_list` VALUES (44,'LifedrinkerLars',4624,63,75,3600,0,3);
INSERT INTO `pet_list` VALUES (45,'PanzerGalahad',4607,63,75,3600,0,3);
INSERT INTO `pet_list` VALUES (46,'ChopsueyChucky',4626,63,85,3600,0,3);
INSERT INTO `pet_list` VALUES (47,'AmigoSabotender',4618,75,85,1800,0,3);
INSERT INTO `pet_list` VALUES (48,'Wyvern',5551,1,99,0,0,2);
INSERT INTO `pet_list` VALUES (49,'Crafty Clyvonne',4608,76,90,7200,0,2);
INSERT INTO `pet_list` VALUES (50,'Bloodclaw Shasr',4609,90,99,7200,0,2);
INSERT INTO `pet_list` VALUES (51,'Lucky Lulush',4612,76,99,7200,0,2);
INSERT INTO `pet_list` VALUES (52,'Fatso Fargann',4613,81,99,7200,0,2);
INSERT INTO `pet_list` VALUES (53,'Discreet Louise',4615,79,99,7200,0,2);
INSERT INTO `pet_list` VALUES (54,'Swift Sieghard',4617,86,94,7200,0,2);
INSERT INTO `pet_list` VALUES (55,'Dipper Yuly',4627,76,99,7200,0,2);
INSERT INTO `pet_list` VALUES (56,'Flowerpot Merle',4628,76,99,10800,0,3);
INSERT INTO `pet_list` VALUES (57,'Nursery Nazuna',4629,76,86,7200,0,2);
INSERT INTO `pet_list` VALUES (58,'Mailbuster Ceta',4630,85,95,7200,0,2);
INSERT INTO `pet_list` VALUES (59,'Audacious Anna',4631,85,95,7200,0,2);
INSERT INTO `pet_list` VALUES (60,'Presto Julio',4632,83,93,7200,0,2);
INSERT INTO `pet_list` VALUES (61,'Bugeyed Broncha',4633,90,99,7200,0,2);
INSERT INTO `pet_list` VALUES (62,'Gooey Gerard',4634,95,99,5400,0,2);
INSERT INTO `pet_list` VALUES (63,'Gorefang Hobs',4635,93,99,7200,0,2);
INSERT INTO `pet_list` VALUES (64,'Faithful Falcor',4636,86,99,7200,0,2);
INSERT INTO `pet_list` VALUES (65,'Crude Raphie',4637,96,99,5400,0,2);
INSERT INTO `pet_list` VALUES (66,'Dapper Mac',4638,76,99,7200,0,3);
INSERT INTO `pet_list` VALUES (67,'Slippery Silas',4639,23,99,1800,0,2);
INSERT INTO `pet_list` VALUES (68,'Turbid Toloi',4640,75,99,7200,0,2);
INSERT INTO `pet_list` VALUES (69,'HarlequinFrame',5124,1,99,0,0,3);
INSERT INTO `pet_list` VALUES (70,'ValoredgeFrame',5125,1,99,0,0,2);
INSERT INTO `pet_list` VALUES (71,'SharpshotFrame',5126,1,99,0,0,3);
INSERT INTO `pet_list` VALUES (72,'StormwakerFrame',5127,1,99,0,0,3);
-- INSERT INTO `pet_list` VALUES (73, 'AdventuringFellow', 0, 1, 99, 0, 0);
-- 74 is Chocobo in the enum..
INSERT INTO `pet_list` VALUES (75,'Luopan',6040,1,99,0,0,0);
INSERT INTO `pet_list` VALUES (76,'Siren',7047,1,99,0,0,2);
INSERT INTO `pet_list` VALUES (77,'SweetCaroline',7500,99,119,7200,0,3);

-- TODO: Lv. 99 + Jug Pets not currently implemented.
-- Need to input values here as well as assign the petid to subskill of corresponding jug item in item_weapons.sql

-- INSERT INTO `pet_list` VALUES (78,'Amiable Roche',poolID,minLevel,maxLevel,time,element,damageType);
-- INSERT INTO `pet_list` VALUES (79,'Headbreaker Ken',poolID,minLevel,maxLevel,time,element,damageType);
-- INSERT INTO `pet_list` VALUES (80,'Anklebiter Jedd',poolID,minLevel,maxLevel,time,element,damageType);
-- INSERT INTO `pet_list` VALUES (81,'Cursed Annabelle',poolID,minLevel,maxLevel,time,element,damageType);
-- INSERT INTO `pet_list` VALUES (82,'Brainy Waluis',poolID,minLevel,maxLevel,time,element,damageType);
-- INSERT INTO `pet_list` VALUES (83,'Slime Familiar',poolID,minLevel,maxLevel,time,element,damageType);
-- INSERT INTO `pet_list` VALUES (84,'Sultry Patrice',poolID,minLevel,maxLevel,time,element,damageType);
-- INSERT INTO `pet_list` VALUES (85,'Generous Arthur',poolID,minLevel,maxLevel,time,element,damageType);
-- INSERT INTO `pet_list` VALUES (86,'Redolent Candi',poolID,minLevel,maxLevel,time,element,damageType);
-- INSERT INTO `pet_list` VALUES (87,'Alluring Honey',poolID,minLevel,maxLevel,time,element,damageType);
-- INSERT INTO `pet_list` VALUES (88,'Lynx Familiar',poolID,minLevel,maxLevel,time,element,damageType);
-- INSERT INTO `pet_list` VALUES (89,'Vivacious Gaston',poolID,minLevel,maxLevel,time,element,damageType);
-- INSERT INTO `pet_list` VALUES (90,'Caring Kiyomaro',poolID,minLevel,maxLevel,time,element,damageType);
-- INSERT INTO `pet_list` VALUES (91,'Vivacious Vickie',poolID,minLevel,maxLevel,time,element,damageType);
-- INSERT INTO `pet_list` VALUES (92,'Suspicious Alice',poolID,minLevel,maxLevel,time,element,damageType);
-- INSERT INTO `pet_list` VALUES (93,'Surging Storm',poolID,minLevel,maxLevel,time,element,damageType);
-- INSERT INTO `pet_list` VALUES (94,'Submerged Iyo',poolID,minLevel,maxLevel,time,element,damageType);
-- INSERT INTO `pet_list` VALUES (95,'Warlike Patrick',poolID,minLevel,maxLevel,time,element,damageType);
-- INSERT INTO `pet_list` VALUES (96,'Rhyming Shizuna',poolID,minLevel,maxLevel,time,element,damageType);
-- INSERT INTO `pet_list` VALUES (97,'Blackbeard Randy',poolID,minLevel,maxLevel,time,element,damageType);
-- INSERT INTO `pet_list` VALUES (98,'Threestar Lynn',poolID,minLevel,maxLevel,time,element,damageType);
-- INSERT INTO `pet_list` VALUES (99,'Hurler Percival',poolID,minLevel,maxLevel,time,element,damageType);
-- INSERT INTO `pet_list` VALUES (100,'Acuex Familiar',poolID,minLevel,maxLevel,time,element,damageType);
-- INSERT INTO `pet_list` VALUES (101,'Fluffy Bredo',poolID,minLevel,maxLevel,time,element,damageType);
-- INSERT INTO `pet_list` VALUES (102,'Weevil Familiar',poolID,minLevel,maxLevel,time,element,damageType);
-- INSERT INTO `pet_list` VALUES (103,'Stalwart Angelina',poolID,minLevel,maxLevel,time,element,damageType);
-- INSERT INTO `pet_list` VALUES (104,'Fleet Reinhard',poolID,minLevel,maxLevel,time,element,damageType);
-- INSERT INTO `pet_list` VALUES (105,'Sharpwit Hermes',poolID,minLevel,maxLevel,time,element,damageType);
-- INSERT INTO `pet_list` VALUES (106,'Porter Crab Familiar',poolID,minLevel,maxLevel,time,element,damageType);
-- INSERT INTO `pet_list` VALUES (107,'Jovial Edwin',poolID,minLevel,maxLevel,time,element,damageType);
-- INSERT INTO `pet_list` VALUES (108,'Attentive Ibuki',poolID,minLevel,maxLevel,time,element,damageType);
-- INSERT INTO `pet_list` VALUES (109,'Swooping Zhivago',poolID,minLevel,maxLevel,time,element,damageType);
-- INSERT INTO `pet_list` VALUES (110,'Sunburst Malfik',poolID,minLevel,maxLevel,time,element,damageType);
-- INSERT INTO `pet_list` VALUES (111,'Aged Angus',poolID,minLevel,maxLevel,time,element,damageType);
-- INSERT INTO `pet_list` VALUES (112,'Scissorleg Xerin',poolID,minLevel,maxLevel,time,element,damageType);
-- INSERT INTO `pet_list` VALUES (113,'Bouncing Bertha',poolID,minLevel,maxLevel,time,element,damageType);
-- INSERT INTO `pet_list` VALUES (114,'Spider Familiar',poolID,minLevel,maxLevel,time,element,damageType);
-- INSERT INTO `pet_list` VALUES (115,'Gussy Hachirobe',poolID,minLevel,maxLevel,time,element,damageType);
-- INSERT INTO `pet_list` VALUES (116,'Colibri Familiar',poolID,minLevel,maxLevel,time,element,damageType);
-- INSERT INTO `pet_list` VALUES (117,'Choral Leera',poolID,minLevel,maxLevel,time,element,damageType);
-- INSERT INTO `pet_list` VALUES (118,'Droopy Dortwin',poolID,minLevel,maxLevel,time,element,damageType);
-- INSERT INTO `pet_list` VALUES (119,'Pondering Peter',poolID,minLevel,maxLevel,time,element,damageType);
-- INSERT INTO `pet_list` VALUES (120,'Herald Henry',poolID,minLevel,maxLevel,time,element,damageType);
-- INSERT INTO `pet_list` VALUES (121,'Hippogryph Familiar',poolID,minLevel,maxLevel,time,element,damageType);
-- INSERT INTO `pet_list` VALUES (122,'Daring Roland',poolID,minLevel,maxLevel,time,element,damageType);
-- INSERT INTO `pet_list` VALUES (123,'Mosquito Familiar',poolID,minLevel,maxLevel,time,element,damageType);
-- INSERT INTO `pet_list` VALUES (124,'Left-Handed Yoko',poolID,minLevel,maxLevel,time,element,damageType);
-- INSERT INTO `pet_list` VALUES (125,'Brave Hero Glenn',poolID,minLevel,maxLevel,time,element,damageType);
-- INSERT INTO `pet_list` VALUES (126,'Yellow Beetle Familiar',poolID,minLevel,maxLevel,time,element,damageType);
-- INSERT INTO `pet_list` VALUES (127,'Energized Sefina',poolID,minLevel,maxLevel,time,element,damageType);
