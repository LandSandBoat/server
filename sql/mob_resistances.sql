/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
DROP TABLE IF EXISTS `mob_resistances`;
CREATE TABLE `mob_resistances` (
  `resist_id` smallint(4) unsigned NOT NULL,
  `name` tinytext, -- Purely for human readability
  `slash_sdt` smallint(5) NOT NULL DEFAULT 0, -- sdt vs physical type
  `pierce_sdt` smallint(5) NOT NULL DEFAULT 0,
  `h2h_sdt` smallint(5) NOT NULL DEFAULT 0,
  `impact_sdt` smallint(5) NOT NULL DEFAULT 0,
  `magical_sdt` smallint(5) NOT NULL DEFAULT 0, -- General elemental SDT
  `fire_sdt` smallint(5) NOT NULL DEFAULT 0, -- sdt vs element
  `ice_sdt` smallint(5) NOT NULL DEFAULT 0,
  `wind_sdt` smallint(5) NOT NULL DEFAULT 0,
  `earth_sdt` smallint(5) NOT NULL DEFAULT 0,
  `lightning_sdt` smallint(5) NOT NULL DEFAULT 0,
  `water_sdt` smallint(5) NOT NULL DEFAULT 0,
  `light_sdt` smallint(5) NOT NULL DEFAULT 0,
  `dark_sdt` smallint(5) NOT NULL DEFAULT 0,
  `fire_res_rank` smallint(3) NOT NULL DEFAULT 0, -- Resistance rank vs magical element.
  `ice_res_rank` smallint(3) NOT NULL DEFAULT 0,
  `wind_res_rank` smallint(3) NOT NULL DEFAULT 0,
  `earth_res_rank` smallint(3) NOT NULL DEFAULT 0,
  `lightning_res_rank` smallint(3) NOT NULL DEFAULT 0,
  `water_res_rank` smallint(3) NOT NULL DEFAULT 0,
  `light_res_rank` smallint(3) NOT NULL DEFAULT 0,
  `dark_res_rank` smallint(3) NOT NULL DEFAULT 0,
  `paralyze_res_rank` smallint(3) NOT NULL DEFAULT 0, -- Resistance rank vs specific effect.
  `bind_res_rank` smallint(3) NOT NULL DEFAULT 0,
  `silence_res_rank` smallint(3) NOT NULL DEFAULT 0,
  `slow_res_rank` smallint(3) NOT NULL DEFAULT 0,
  `poison_res_rank` smallint(3) NOT NULL DEFAULT 0,
  `light_sleep_res_rank` smallint(3) NOT NULL DEFAULT 0,
  `dark_sleep_res_rank` smallint(3) NOT NULL DEFAULT 0,
  `blind_res_rank` smallint(3) NOT NULL DEFAULT 0,
  PRIMARY KEY (`resist_id`)
) ENGINE=Aria TRANSACTIONAL=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci AVG_ROW_LENGTH=128;

/*!40101 SET character_set_client = @saved_cs_client */;

INSERT INTO `mob_resistances` VALUES (0,'DEFAULT',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (1,'Acrolith',0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,3,3,2,0,6,11,3,3,3,3,0,6,11,11);
INSERT INTO `mob_resistances` VALUES (2,'Adamantoise',0,0,0,0,0,0,0,0,0,0,0,0,0,4,-2,4,11,11,11,4,4,-2,-2,4,11,11,4,4,4);
INSERT INTO `mob_resistances` VALUES (3,'Aern',0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,6,-2,-1,-1,-1,-1,-1,6,-2,-2);
INSERT INTO `mob_resistances` VALUES (4,'Ahriman',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,6,0,0,11,0,0,-2,4,6);
INSERT INTO `mob_resistances` VALUES (5,'Amoeban',0,0,0,0,0,0,0,0,0,0,0,0,0,2,2,0,4,2,2,0,4,2,2,0,4,2,0,4,4);
INSERT INTO `mob_resistances` VALUES (6,'Amphiptere',0,0,0,0,0,0,0,0,0,0,0,0,0,2,1,8,0,2,2,2,4,1,1,8,0,2,2,4,4);
INSERT INTO `mob_resistances` VALUES (7,'AnimatedWeapon-Archery',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,2,0,-1,0,-1,-2,0,2,2,0,-1,-1,-2,0,0);
INSERT INTO `mob_resistances` VALUES (8,'AnimatedWeapon-Axe',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,2,0,-1,0,-1,-2,0,2,2,0,-1,-1,-2,0,0);
INSERT INTO `mob_resistances` VALUES (9,'AnimatedWeapon-Club',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,2,0,-1,0,-1,-2,0,2,2,0,-1,-1,-2,0,0);
-- 10 free
INSERT INTO `mob_resistances` VALUES (11,'AnimatedWeapon-Dagger',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,2,0,-1,0,-1,-2,0,2,2,0,-1,-1,-2,0,0);
INSERT INTO `mob_resistances` VALUES (12,'AnimatedWeapon-Greataxe',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,2,0,-1,0,-1,-2,0,2,2,0,-1,-1,-2,0,0);
INSERT INTO `mob_resistances` VALUES (13,'AnimatedWeapon-Greatkatana',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,2,0,-1,0,-1,-2,0,2,2,0,-1,-1,-2,0,0);
INSERT INTO `mob_resistances` VALUES (14,'AnimatedWeapon-Greatsword',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,2,0,-1,0,-1,-2,0,2,2,0,-1,-1,-2,0,0);
INSERT INTO `mob_resistances` VALUES (15,'AnimatedWeapon-Handtohand',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,2,0,-1,0,-1,-2,0,2,2,0,-1,-1,-2,0,0);
INSERT INTO `mob_resistances` VALUES (16,'AnimatedWeapon-Instrument',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,2,0,-1,0,-1,-2,0,2,2,0,-1,-1,-2,0,0);
INSERT INTO `mob_resistances` VALUES (17,'AnimatedWeapon-Katana',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,2,0,-1,0,-1,-2,0,2,2,0,-1,-1,-2,0,0);
INSERT INTO `mob_resistances` VALUES (18,'AnimatedWeapon-Marksmanship',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,2,0,-1,0,-1,-2,0,2,2,0,-1,-1,-2,0,0);
INSERT INTO `mob_resistances` VALUES (19,'AnimatedWeapon-Polearm',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,2,0,-1,0,-1,-2,0,2,2,0,-1,-1,-2,0,0);
INSERT INTO `mob_resistances` VALUES (20,'AnimatedWeapon-Scythe',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,2,0,-1,0,-1,-2,0,2,2,0,-1,-1,-2,0,0);
INSERT INTO `mob_resistances` VALUES (21,'AnimatedWeapon-Shield',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,2,0,-1,0,-1,-2,0,2,2,0,-1,-1,-2,0,0);
-- 22 free
INSERT INTO `mob_resistances` VALUES (23,'AnimatedWeapon-Staff',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,2,0,-1,0,-1,-2,0,2,2,0,-1,-1,-2,0,0);
INSERT INTO `mob_resistances` VALUES (24,'AnimatedWeapon-Sword',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,2,0,-1,0,-1,-2,0,2,2,0,-1,-1,-2,0,0);
INSERT INTO `mob_resistances` VALUES (25,'Beastman-Antica_Regular',0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-2,-3,4,-1,-1,-2,4,-2,-2,-3,4,-1,-2,4,4);
INSERT INTO `mob_resistances` VALUES (26,'Antlion',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,3,0,0,-3,3,0,0,-2,3,0,-3,3,3);
INSERT INTO `mob_resistances` VALUES (27,'Apkallu',0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,-1,-1,-2,5,-1,-1,1,1,-1,-1,5,-1,-1,-1);
INSERT INTO `mob_resistances` VALUES (28,'Automaton-Harlequin',0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1);
INSERT INTO `mob_resistances` VALUES (29,'Automaton-Sharpshot',0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1);
INSERT INTO `mob_resistances` VALUES (30,'Automaton-Stormwaker',0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1);
INSERT INTO `mob_resistances` VALUES (31,'Automaton-Valoredge',0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1);
INSERT INTO `mob_resistances` VALUES (32,'Avatar-Atomos_Prime',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (33,'Avatar-Alexander_ToAU',0,0,0,0,0,0,0,0,0,0,0,0,0,5,5,5,5,5,5,11,5,5,5,5,5,5,11,5,5);
INSERT INTO `mob_resistances` VALUES (34,'Avatar-Carbuncle_Prime',0,0,0,0,0,0,0,0,0,0,0,0,0,6,6,6,6,6,6,11,0,6,6,6,6,6,11,0,0);
INSERT INTO `mob_resistances` VALUES (35,'Avatar-Diabolos_CoP',0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,0,4,1,1,1,1,1,0,4,4);
INSERT INTO `mob_resistances` VALUES (36,'Avatar-Fenrir_Prime',0,0,0,0,0,0,0,0,0,0,0,0,0,3,3,3,3,3,3,-2,11,3,3,3,3,3,-2,11,11);
INSERT INTO `mob_resistances` VALUES (37,'Avatar-Garuda_Prime_WTB',0,0,0,0,0,0,0,0,0,0,0,0,0,4,-3,-3,11,4,4,4,4,-3,-3,-3,11,4,4,4,4);
INSERT INTO `mob_resistances` VALUES (38,'Avatar-Ifrit_Prime_WTB',0,0,0,0,0,0,0,0,0,0,0,0,0,-3,11,4,4,4,-3,4,4,11,11,4,4,-3,4,4,4);
INSERT INTO `mob_resistances` VALUES (39,'Monoceros',0,0,0,0,0,0,0,0,0,0,0,0,0,2,2,2,-2,6,2,0,4,2,2,2,-2,2,0,4,4);-- Ixion not Alicorn.
INSERT INTO `mob_resistances` VALUES (40,'Avatar-Leviathan_Prime_WTB',0,0,0,0,0,0,0,0,0,0,0,0,0,11,4,4,4,-3,-3,4,4,4,4,4,4,-3,4,4,4);
INSERT INTO `mob_resistances` VALUES (41,'Avatar-Odin_Image',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,11,0,0,0,0,0,-3,11,11);
INSERT INTO `mob_resistances` VALUES (42,'Avatar-Odin_Prime',0,0,0,0,0,0,0,0,0,0,0,0,0,5,7,5,7,5,7,4,11,7,7,5,7,7,4,11,11);
INSERT INTO `mob_resistances` VALUES (43,'Avatar-Ramuh_Prime_WTB',0,0,0,0,0,0,0,0,0,0,0,0,0,4,4,4,-3,-3,11,4,4,4,4,4,-3,11,4,4,4);
INSERT INTO `mob_resistances` VALUES (44,'Avatar-Shiva_Prime_WTB',0,0,0,0,0,0,0,0,0,0,0,0,0,-3,-3,11,4,4,4,4,4,-3,-3,11,4,4,4,4,4);
INSERT INTO `mob_resistances` VALUES (45,'Avatar-Titan_Prime_WTB',0,0,0,0,0,0,0,0,0,0,0,0,0,4,4,-3,-3,11,4,4,4,4,4,-3,-3,4,4,4,4);
INSERT INTO `mob_resistances` VALUES (46,'Bat',0,2500,0,0,0,0,0,0,0,0,0,0,0,-2,-1,-3,-2,-2,-2,-3,6,-1,-1,-3,-2,-2,-3,6,6);
INSERT INTO `mob_resistances` VALUES (47,'Bat_Trio',0,2500,0,0,0,0,0,0,0,0,0,0,0,-2,-1,-3,-2,-2,-2,-3,6,-1,-1,-3,-2,-2,-3,6,6);
INSERT INTO `mob_resistances` VALUES (48,'Bee',0,2500,0,0,0,0,0,0,0,0,0,0,0,-2,-3,2,-2,-2,-2,-2,-2,-3,-3,2,-2,-2,-2,-2,-2);
INSERT INTO `mob_resistances` VALUES (49,'Beetle',0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,0,0,0,0,-3,0,-3,-3,0,0,0,-3,0,0);
-- 50 free
INSERT INTO `mob_resistances` VALUES (51,'Behemoth',0,0,0,0,0,0,0,0,0,0,0,0,0,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2);
INSERT INTO `mob_resistances` VALUES (52,'Bhoot',-2500,-2500,-5000,-5000,0,0,0,0,0,0,0,0,0,-2,5,-1,0,-2,-1,-2,5,5,5,-1,0,-1,-2,5,5);
INSERT INTO `mob_resistances` VALUES (53,'Grimoire',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (54,'Biotechnological',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (55,'Bird',0,2500,0,0,0,0,0,0,0,0,0,0,0,-2,-3,0,0,-2,-2,-2,-2,-3,-3,0,0,-2,-2,-2,-2);
INSERT INTO `mob_resistances` VALUES (56,'Bomb',0,0,0,0,0,0,0,0,0,0,0,0,0,-3,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4);
INSERT INTO `mob_resistances` VALUES (57,'Buffalo',0,0,0,0,0,0,0,0,0,0,0,0,0,-1,2,-1,-1,-1,-2,-1,-1,2,2,-1,-1,-2,-1,-1,-1);
INSERT INTO `mob_resistances` VALUES (58,'Bugard',0,0,0,0,0,0,0,0,0,0,0,0,0,2,-2,-1,-1,-1,-1,2,-1,-2,-2,-1,-1,-1,2,-1,-1);
INSERT INTO `mob_resistances` VALUES (59,'Goblin-Bugbear',0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,0,-1,-1,-3,2,-1,-1,-1,0,-1,-3,2,2);
INSERT INTO `mob_resistances` VALUES (60,'Cait_Sith',0,0,0,0,0,0,0,0,0,0,0,0,0,2,2,2,2,2,2,8,-1,2,2,2,2,2,8,-1,-1);
INSERT INTO `mob_resistances` VALUES (61,'Cardian',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,-2,-2,-2,-2,-2,-2,-2,-2,-2,-2,-2,-2,-2,-2,-2);
INSERT INTO `mob_resistances` VALUES (62,'Cerberus',0,0,0,0,0,0,0,0,0,0,0,0,0,11,0,0,0,0,0,10,10,0,0,0,0,0,10,10,10);
INSERT INTO `mob_resistances` VALUES (63,'Chariot',0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,5,-1,6,1,1,1,1,1,-1,6,1,1);
INSERT INTO `mob_resistances` VALUES (64,'Chigoe',0,0,0,0,0,0,0,0,0,0,0,0,0,-1,1,1,2,1,-1,1,1,1,1,1,2,-1,1,1,1);
INSERT INTO `mob_resistances` VALUES (65,'Clionid',0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,2,2,0,4,2,2,4,4,2,2,4,2,2,2);
INSERT INTO `mob_resistances` VALUES (66,'Slime-Clot',-5000,-5000,-7500,-7500,0,0,0,0,0,0,0,0,0,-3,-2,-2,-2,-2,-2,-2,-2,-2,-2,-2,-2,-2,-2,-2,-2);
INSERT INTO `mob_resistances` VALUES (67,'Slime-GlutinousClot',-7500,-7500,-8750,-8750,0,0,0,0,0,0,0,0,0,-1,-1,-2,-1,-1,-1,1,1,-1,-1,-2,-1,-1,1,1,1);
INSERT INTO `mob_resistances` VALUES (68,'Cluster',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3);
INSERT INTO `mob_resistances` VALUES (69,'Cluster - Razon',-1250,-1250,-1250,-1250,0,0,0,0,0,0,0,0,0,-2,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3);
INSERT INTO `mob_resistances` VALUES (70,'Cockatrice',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,-2,-3,2,2,-2,-2,-2,-2,-2,-3,2,-2,-2,-2,-2);
INSERT INTO `mob_resistances` VALUES (71,'Coeurl',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,-2,-2,-3,0,-2,-2,-2,-2,-2,-2,-3,-2,-2,-2,-2);
INSERT INTO `mob_resistances` VALUES (72,'Colibri',0,2500,0,0,0,0,0,0,0,0,0,0,0,-1,-2,6,0,-1,-1,0,-2,-2,-2,6,0,-1,0,-2,-2);
INSERT INTO `mob_resistances` VALUES (73,'Corpselights',0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,2,0,2,-1,6,2,2,0,2,2,-1,6,6);
INSERT INTO `mob_resistances` VALUES (74,'Corse',-1250,-5000,1250,2500,0,0,0,0,0,0,0,0,0,-2,2,-1,2,-1,-1,-3,3,2,2,-1,2,-1,-3,3,3);
INSERT INTO `mob_resistances` VALUES (75,'Crab - Blue_Bascinet',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,-3,-2,-2,-3,2,-2,-2,-3,-3,-2,-2,2,-2,-2,-2);
INSERT INTO `mob_resistances` VALUES (76,'Crab - Bloody_Coffin',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,-3,-2,-2,-3,2,-2,-2,-3,-3,-2,-2,2,-2,-2,-2);
INSERT INTO `mob_resistances` VALUES (77,'Crab',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,-3,-2,-2,-3,2,-2,-2,-3,-3,-2,-2,2,-2,-2,-2);
INSERT INTO `mob_resistances` VALUES (78,'Promyvion-Craver_Neutral',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);-- Varies. TODO: s
INSERT INTO `mob_resistances` VALUES (79,'Crawler',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,-3,-2,0,-3,-2,0,-3,-3,-3,-2,0,-2,0,-3,-3);
INSERT INTO `mob_resistances` VALUES (80,'Dhalmel',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,0,-3,0,-3,-2,-2,-2,0,0,-3,0,-2,-2,-2,-2);
INSERT INTO `mob_resistances` VALUES (81,'Diremite',0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-3,-2,3,-1,-1,-1,-1,-3,-2,3,3);
INSERT INTO `mob_resistances` VALUES (82,'Djinn',0,0,0,0,0,0,0,0,0,0,0,0,0,3,3,3,3,3,3,1,5,3,3,3,3,3,1,5,5);
INSERT INTO `mob_resistances` VALUES (83,'Unused',0,0,0,0,0,0,0,0,0,0,0,0,0,2,2,2,2,-3,2,2,2,2,2,2,2,2,2,2,2);
INSERT INTO `mob_resistances` VALUES (84,'Doll - Gargoyle',0,0,0,0,0,0,0,0,0,0,0,0,0,2,2,2,2,-3,2,2,2,2,2,2,2,2,2,2,2);-- NOT USED
INSERT INTO `mob_resistances` VALUES (85,'Doll',0,0,0,0,0,0,0,0,0,0,0,0,0,2,2,2,2,-3,2,2,2,2,2,2,2,2,2,2,2);
INSERT INTO `mob_resistances` VALUES (86,'Doomed',1250,0,-1250,-1250,0,0,0,0,0,0,0,0,0,-2,3,0,0,0,2,-2,8,3,3,0,0,2,-2,8,8);
INSERT INTO `mob_resistances` VALUES (87,'Dragon',0,0,0,0,0,0,0,0,0,0,0,0,0,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2);
INSERT INTO `mob_resistances` VALUES (88,'Draugar - Vanquished_Einherjar',-1250,-5000,1250,2500,0,0,0,0,0,0,0,0,0,-2,2,-1,-1,-1,-1,-2,4,2,2,-1,-1,-1,-2,4,4);
INSERT INTO `mob_resistances` VALUES (89,'Draugar',-1250,-5000,1250,2500,0,0,0,0,0,0,0,0,0,-2,2,-1,-1,-1,-1,-2,4,2,2,-1,-1,-1,-2,4,4);
INSERT INTO `mob_resistances` VALUES (90,'Dvergr',0,0,0,0,0,0,0,0,0,0,0,0,0,4,6,4,6,4,6,2,11,6,6,4,6,6,2,11,11);
INSERT INTO `mob_resistances` VALUES (91,'Dvergr_Skull',0,0,0,0,0,0,0,0,0,0,0,0,0,4,6,4,6,4,6,2,11,6,6,4,6,6,2,11,11);
INSERT INTO `mob_resistances` VALUES (92,'Dynamis-Statue_Goblin',-5000,-5000,-5000,-5000,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-2,1,-1,-1,-1,-1,-1,-2,1,1);
INSERT INTO `mob_resistances` VALUES (93,'Dynamis-Statue_Orc',-5000,-5000,-5000,-5000,0,0,0,0,0,0,0,0,0,1,1,-1,-1,-1,-2,-1,-1,1,1,-1,-1,-2,-1,-1,-1);
INSERT INTO `mob_resistances` VALUES (94,'Dynamis-Statue_Quadav',-5000,-5000,-5000,-5000,0,0,0,0,0,0,0,0,0,1,-1,-1,-1,-2,1,-1,-1,-1,-1,-1,-1,1,-1,-1,-1);
INSERT INTO `mob_resistances` VALUES (95,'Dynamis-Statue_Yagudo',-5000,-5000,-5000,-5000,0,0,0,0,0,0,0,0,0,-1,-2,1,1,-1,-1,-1,-1,-2,-2,1,1,-1,-1,-1,-1);
-- 96 free
INSERT INTO `mob_resistances` VALUES (97,'Lizard-Ice',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,2,-1,-1,-1,-1,-1,-1,2,2,-1,-1,-1,-1,-1,-1);
INSERT INTO `mob_resistances` VALUES (98,'Eft',0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-2,2,2,-1,2,-1,-1,-2,-2,2,2,2,-1,-1,-1);
INSERT INTO `mob_resistances` VALUES (99,'Elemental-Air',-7500,-7500,-7500,-7500,0,0,0,0,0,0,0,0,0,0,-3,11,11,0,0,0,0,-3,-3,11,11,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (100,'Elemental-Dark',-7500,-7500,-7500,-7500,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,11,0,0,0,0,0,-3,11,11);
INSERT INTO `mob_resistances` VALUES (101,'Elemental-Earth',-7500,-7500,-7500,-7500,0,0,0,0,0,0,0,0,0,0,0,-3,11,11,0,0,0,0,0,-3,11,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (102,'Elemental-Fire',-7500,-7500,-7500,-7500,0,0,0,0,0,0,0,0,0,11,11,0,0,0,-3,0,0,11,11,0,0,-3,0,0,0);
INSERT INTO `mob_resistances` VALUES (103,'Elemental-Ice',-7500,-7500,-7500,-7500,0,0,0,0,0,0,0,0,0,-3,11,11,0,0,0,0,0,11,11,11,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (104,'Elemental-Light',-7500,-7500,-7500,-7500,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,11,-3,0,0,0,0,0,11,-3,-3);
INSERT INTO `mob_resistances` VALUES (105,'Elemental-Lightning',-7500,-7500,-7500,-7500,0,0,0,0,0,0,0,0,0,0,0,0,-3,11,11,0,0,0,0,0,-3,11,0,0,0);
INSERT INTO `mob_resistances` VALUES (106,'Elemental-Water',-7500,-7500,-7500,-7500,0,0,0,0,0,0,0,0,0,11,0,0,0,-3,11,0,0,0,0,0,0,11,0,0,0);
INSERT INTO `mob_resistances` VALUES (107,'Eruca',0,0,0,0,0,0,0,0,0,0,0,0,0,1,-1,-1,0,-1,-2,0,-1,-1,-1,-1,0,-2,0,-1,-1);
INSERT INTO `mob_resistances` VALUES (108,'Eruca - Energetic_Eruca',-10000,0,0,-10000,0,0,0,0,0,0,0,0,0,1,-1,-1,0,-1,-2,0,-1,-1,-1,-1,0,-2,0,-1,-1);
INSERT INTO `mob_resistances` VALUES (109,'Euvhi',0,0,0,0,0,0,0,0,0,0,0,0,0,-3,-1,-1,-1,-1,3,3,-1,-1,-1,-1,-1,3,3,-1,-1);
INSERT INTO `mob_resistances` VALUES (110,'Evil_Weapon',0,0,0,0,0,0,0,0,0,0,0,0,0,-3,0,-2,-2,-2,-2,-3,0,0,0,-2,-2,-2,-3,0,0);
-- 111 free
INSERT INTO `mob_resistances` VALUES (112,'Flan',-1250,0,-2500,-2500,0,0,0,0,0,0,0,0,0,-1,1,1,1,-1,3,-1,2,1,1,1,1,3,-1,2,2);
INSERT INTO `mob_resistances` VALUES (113,'Fly',0,2500,0,0,0,0,0,0,0,0,0,0,0,-2,-3,0,0,-2,-2,-2,-2,-3,-3,0,0,-2,-2,-2,-2);
INSERT INTO `mob_resistances` VALUES (114,'Flytrap',0,0,0,0,0,0,0,0,0,0,0,0,0,-3,-1,3,0,0,3,3,-1,-1,-1,3,0,3,3,-1,-1);
INSERT INTO `mob_resistances` VALUES (115,'Fomor',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,4,0,0,0,0,-2,4,4,4,0,0,0,-2,4,4);
INSERT INTO `mob_resistances` VALUES (116,'Funguar',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,-2,-2,-2,-2,4,-3,4,-2,-2,-2,-2,4,-3,4,6);
INSERT INTO `mob_resistances` VALUES (117,'Gargouille - Benumbed_Vodoriga',0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,-1,4,1,0,-1,5,2,2,-1,4,0,-1,5,5);
INSERT INTO `mob_resistances` VALUES (118,'Gargouille',0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,-1,4,1,0,-1,5,2,2,-1,4,0,-1,5,5);
INSERT INTO `mob_resistances` VALUES (119,'Gear - Archaic_Gear',0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,4,-1,4,1,1,1,1,1,-1,4,1,1);
INSERT INTO `mob_resistances` VALUES (120,'Gear',0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,4,-1,4,1,1,1,1,1,-1,4,1,1);
INSERT INTO `mob_resistances` VALUES (121,'Ghost',-2500,-2500,-5000,-5000,0,0,0,0,0,0,0,0,0,-3,4,-2,0,-2,-2,-3,4,5,5,-2,0,-2,-3,4,5);
INSERT INTO `mob_resistances` VALUES (122,'Ghrah',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (123,'Ghrah',-2500,-2500,-2500,-2500,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,11,0,0,0,0,0,-3,11,11);
INSERT INTO `mob_resistances` VALUES (124,'Ghrah - Jailer_of_Fortitude',-1250,-1250,-1250,-1250,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,11,0,0,0,0,0,-3,11,11);
INSERT INTO `mob_resistances` VALUES (125,'Greater_Bird',-2500,2500,0,-2500,0,0,0,0,0,0,0,0,0,1,-3,4,1,1,1,1,1,-3,-3,4,1,1,1,1,1);
INSERT INTO `mob_resistances` VALUES (126,'Gigas',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,4,0,0,0,0,0,0,-2,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (127,'Gigas - Cronos',-10000,-10000,-10000,-10000,0,0,0,0,0,0,0,0,0,0,0,0,-2,4,0,0,0,0,0,0,-2,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (128,'Gigas - Agrios',-10000,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,4,0,0,0,0,0,0,-2,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (129,'Gigas - Okeanos',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,4,0,0,0,0,0,0,-2,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (130,'Gigas - Hyperion',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,4,0,0,0,0,0,0,-2,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (131,'Gnat',0,0,0,0,0,0,0,0,0,0,0,0,0,-1,0,3,0,0,0,-2,4,0,0,3,0,0,-2,4,4);
INSERT INTO `mob_resistances` VALUES (132,'Gnole',0,0,0,0,0,0,0,0,0,0,0,0,0,-1,1,0,0,0,0,-1,3,1,1,0,0,0,-1,3,3);
INSERT INTO `mob_resistances` VALUES (133,'Goblin',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,-2,-2,-2,-2,-2,-3,0,-2,-2,-2,-2,-2,-3,0,0);
INSERT INTO `mob_resistances` VALUES (134,'God - Promathia',-1000,-1000,-1000,-1000,0,0,0,0,0,0,0,0,0,2,2,2,2,2,2,0,11,2,2,2,2,2,0,11,11);
INSERT INTO `mob_resistances` VALUES (135,'Golem',0,0,0,0,0,0,0,0,0,0,0,0,0,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2);
INSERT INTO `mob_resistances` VALUES (136,'Goobbue',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,0,0,0,0,0,0,-2,0,0,0,0,0,0,-2,-2);
INSERT INTO `mob_resistances` VALUES (137,'Gorger - Offspring',0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,11,11,0,0,0,0,-3,-3,11,11,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (138,'Gorger',0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,11,11,0,0,0,0,-3,-3,11,11,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (139,'Hecteyes',0,0,-2500,-2500,0,0,0,0,0,0,0,0,0,-2,-2,-2,-2,-2,-2,-2,2,-2,-2,-2,-2,-2,-2,2,2);
INSERT INTO `mob_resistances` VALUES (140,'Hippogryph',0,2500,0,0,0,0,0,0,0,0,0,0,0,-1,-1,3,-2,3,-1,-1,-1,-1,-1,3,-2,-1,-1,-1,-1);
INSERT INTO `mob_resistances` VALUES (141,'Hippogryph-High_Res',0,2500,0,0,0,0,0,0,0,0,0,0,0,-1,-1,3,-2,3,-1,-1,-1,-1,-1,3,-2,-1,-1,-1,-1);
INSERT INTO `mob_resistances` VALUES (142,'Hound',5000,5000,5000,5000,0,0,0,0,0,0,0,0,0,-3,4,-2,0,-2,-2,-3,4,4,4,-2,0,-2,-3,4,4);
INSERT INTO `mob_resistances` VALUES (143,'Hound',1250,0,0,0,0,0,0,0,0,0,0,0,0,-3,4,-2,0,-2,-2,-3,4,4,4,-2,0,-2,-3,4,4);
INSERT INTO `mob_resistances` VALUES (144,'Hpemde',0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,-2,-2,-2,-2,1,-1,-2,-2,-2,-2,-2,1,-1,-1);
INSERT INTO `mob_resistances` VALUES (145,'Humanoid - Elvaan',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (146,'Humanoid - Galka',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (147,'Humanoid - Galka',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (148,'Humanoid - Galka',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (149,'Humanoid - Hume',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (150,'Humanoid - Hume',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (151,'Humanoid - Mithra',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (152,'Humanoid - Mithra',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (153,'Humanoid - Tarutaru',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (154,'Humanoid - Tarutaru',-2500,-2500,-2500,-2500,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (155,'HybridElemental - Air',0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,11,11,0,0,0,0,-3,-3,11,11,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (156,'HybridElemental - Dark',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,11,0,0,0,0,0,-3,11,11);
INSERT INTO `mob_resistances` VALUES (157,'HybridElemental - Earth',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,11,11,0,0,0,0,0,-3,11,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (158,'HybridElemental - Fire',0,0,0,0,0,0,0,0,0,0,0,0,0,11,11,0,0,0,-3,0,0,11,11,0,0,-3,0,0,0);
INSERT INTO `mob_resistances` VALUES (159,'HybridElemental - Ice',0,0,0,0,0,0,0,0,0,0,0,0,0,-3,11,11,0,0,0,0,0,11,11,11,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (160,'HybridElemental - Light',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,11,-3,0,0,0,0,0,11,-3,-3);
INSERT INTO `mob_resistances` VALUES (161,'HybridElemental - Lightning',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,11,11,0,0,0,0,0,-3,11,0,0,0);
INSERT INTO `mob_resistances` VALUES (162,'HybridElemental - Water',0,0,0,0,0,0,0,0,0,0,0,0,0,11,0,0,0,-3,11,0,0,0,0,0,0,11,0,0,0);
INSERT INTO `mob_resistances` VALUES (163,'Hydra',0,0,0,-1250,0,0,0,0,0,0,0,0,0,6,6,6,3,3,3,3,3,6,6,6,3,3,3,3,3);
INSERT INTO `mob_resistances` VALUES (164,'Hydra',0,0,0,-1250,0,0,0,0,0,0,0,0,0,6,6,6,3,3,3,3,3,6,6,6,3,3,3,3,3);
INSERT INTO `mob_resistances` VALUES (165,'Imp',0,2500,0,0,0,0,0,0,0,0,0,0,0,-1,-1,2,-1,-1,-1,-2,6,-1,-1,2,-1,-1,-2,6,6);
INSERT INTO `mob_resistances` VALUES (166,'Imp - Jakko',0,2500,0,0,0,0,0,0,0,0,0,0,0,-1,-1,2,-1,-1,-1,-2,6,-1,-1,2,-1,-1,-2,6,6);
INSERT INTO `mob_resistances` VALUES (167,'Karakul',0,0,0,0,0,0,0,0,0,0,0,0,0,-1,1,-1,1,-2,-2,-1,-1,1,1,-1,1,-2,-1,-1,-1);
INSERT INTO `mob_resistances` VALUES (168,'Khimaira',0,0,0,0,0,0,0,0,0,0,0,0,0,5,1,5,4,6,1,4,1,1,1,5,4,1,4,1,1);
INSERT INTO `mob_resistances` VALUES (169,'Kindred',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,0,0,0,0,0,0,-2,0,0);
INSERT INTO `mob_resistances` VALUES (170,'Ladybug',0,2500,0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,0,0,4,4,4,0,0,0,0,4,4);
INSERT INTO `mob_resistances` VALUES (171,'Lamiae',0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-2,-1,-1,-2,3,-2,2,-2,-2,-1,-1,3,-2,2,2);
INSERT INTO `mob_resistances` VALUES (172,'Leech',0,0,-2500,-2500,0,0,0,0,0,0,0,0,0,-2,-2,0,0,0,4,-3,2,-2,-2,0,0,4,-3,2,2);
INSERT INTO `mob_resistances` VALUES (173,'Limule',0,0,0,0,0,0,0,0,0,0,0,0,0,4,2,2,2,2,0,4,0,2,2,2,2,0,4,0,0);
INSERT INTO `mob_resistances` VALUES (174,'Lizard',0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,-3,0,0,-2,-2,-2,-3,-3,-3,0,-2,-2,-2,-2);
INSERT INTO `mob_resistances` VALUES (175,'Magic_Pot',0,0,2500,5000,0,0,0,0,0,0,0,0,0,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2);
INSERT INTO `mob_resistances` VALUES (176,'Mamool_Ja',0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,2,0,-1,0,0,-1,-2,-2,2,0,0,0,-1,-1);
INSERT INTO `mob_resistances` VALUES (177,'Mamool_Ja-Knight',0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,2,0,-1,0,0,-1,-2,-2,2,0,0,0,-1,-1);
INSERT INTO `mob_resistances` VALUES (178,'Mandragora',0,2500,0,0,0,0,0,0,0,0,0,0,0,-3,-3,-3,0,-3,0,0,-3,-3,-3,-3,0,0,0,-3,-3);
INSERT INTO `mob_resistances` VALUES (179,'Manticore',0,0,0,0,0,0,0,0,0,0,0,0,0,4,-2,4,-2,-2,-3,0,0,-2,-2,4,-2,-3,0,0,0);
INSERT INTO `mob_resistances` VALUES (180,'Marid',0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,2,-1,0,-1,-1,-1,-1,-1,2,0,-1,-1,-1);
INSERT INTO `mob_resistances` VALUES (181,'MemoryReceptacle',10000,10000,10000,10000,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (182,'Lamiae-Merrow',0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-2,-1,-1,-2,3,-2,2,-2,-2,-1,-1,3,-2,2,2);
INSERT INTO `mob_resistances` VALUES (183,'Mimic',-5000,-5000,-5000,-5000,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (184,'Moblin',0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,0,-1,-1,-3,2,-1,-1,-1,0,-1,-3,2,2);
INSERT INTO `mob_resistances` VALUES (185,'Henchman Moogle',0,0,0,0,0,0,0,0,0,0,0,0,0,11,11,11,-3,11,11,11,11,11,11,11,-3,11,11,11,11);
INSERT INTO `mob_resistances` VALUES (186,'Morbol',0,0,0,0,0,0,0,0,0,0,0,0,0,-3,-2,-2,-2,-2,4,-2,4,-2,-2,-2,-2,4,-2,4,4);
INSERT INTO `mob_resistances` VALUES (187,'Murex',0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,4,0,4,2,2,2,0,0,4,0,2,2,2,2);
INSERT INTO `mob_resistances` VALUES (188,'Opo-opo',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,-3,-1,0,0,-2,0,-2,-3,-3,-1,0,-2,0,-2,-2);
INSERT INTO `mob_resistances` VALUES (189,'Orc',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,-2,-2,-3,-2,-2,0,0,-2,-2,-3,-2,-2,-2);
INSERT INTO `mob_resistances` VALUES (190,'Orc-Warmachine',0,0,0,0,0,0,0,0,0,0,0,0,0,-3,-2,-2,-2,-2,-2,4,4,-2,-2,-2,-2,-2,4,4,4);
INSERT INTO `mob_resistances` VALUES (191,'Orobon',0,0,0,0,0,0,0,0,0,0,0,0,0,-1,1,-1,-1,-2,6,-2,3,1,1,-1,-1,6,-2,3,3);
INSERT INTO `mob_resistances` VALUES (192,'Peiste',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,3,0,0,0,0,0,2,3,0,0,0);
INSERT INTO `mob_resistances` VALUES (193,'Wyvern-Pet',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,-2,-2,-2,-2,-2,-2,-2,-2,-2,-2,-2,-2,-2,-2,-2);
INSERT INTO `mob_resistances` VALUES (194,'Phuabo',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,-2,-2,-2,-2,4,1,-2,-2,-2,-2,-2,4,1,-2,-2);
INSERT INTO `mob_resistances` VALUES (195,'Pixie',-6250,-6250,-6250,-6250,0,0,0,0,0,0,0,0,0,1,1,11,1,1,1,8,1,1,1,11,1,1,8,1,1);
INSERT INTO `mob_resistances` VALUES (196,'Poroggo',0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,1,-1,8,6,0,2,2,0,1,8,6,0,0);
INSERT INTO `mob_resistances` VALUES (197,'Pugil',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,-3,-2,-2,-3,6,-2,-2,-3,-3,-2,-2,4,-2,-2,-2);
INSERT INTO `mob_resistances` VALUES (198,'Puk',0,2500,0,0,0,0,0,0,0,0,0,0,0,-1,-2,11,-1,0,-1,-1,-1,-2,-2,11,-1,-1,-1,-1,-1);
INSERT INTO `mob_resistances` VALUES (199,'Qiqirn',0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-2,2,0,-1,-1,0,-1,-1,-2,2,-1,-1,0,0);
INSERT INTO `mob_resistances` VALUES (200,'Quadav',0,2500,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,-1,2,0,0,0,0,0,0,2,0,0,0);
INSERT INTO `mob_resistances` VALUES (201,'Quadav - BoWho_Warmonger',0,0,0,0,0,0,0,0,0,0,0,0,0,1,-1,-1,-1,-2,1,-1,-1,-1,-1,-1,-1,1,-1,-1,-1);
INSERT INTO `mob_resistances` VALUES (202,'Quadav',0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,-1,2,0,0,0,0,0,0,2,0,0,0);
INSERT INTO `mob_resistances` VALUES (203,'Qutrub',10000,10000,10000,10000,0,0,0,0,0,0,0,0,0,-2,4,-1,1,-1,-1,-2,4,4,4,-1,1,-1,-2,4,4);
INSERT INTO `mob_resistances` VALUES (204,'Unused',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (205,'Qutrub - Qutrub_Wastrel',8750,8750,8750,8750,0,0,0,0,0,0,0,0,0,-2,4,-1,1,-1,-1,-2,4,4,4,-1,1,-1,-2,4,4);
INSERT INTO `mob_resistances` VALUES (206,'Rabbit',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,-1,-2,-1,-3,-3,-1,-3,-1,-1,-2,-1,-3,-1,-3,-3);
INSERT INTO `mob_resistances` VALUES (207,'Rafflesia',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,0,-1,3,1,0,2,0,0,0,-1,3,0,2,0,0);
INSERT INTO `mob_resistances` VALUES (208,'Ram',0,0,0,0,0,0,0,0,0,0,0,0,0,-1,1,-1,-1,-2,-2,-1,-1,1,1,-1,-1,-2,-1,-1,-1);
INSERT INTO `mob_resistances` VALUES (209,'Rampart',0,0,0,0,0,0,0,0,0,0,0,0,0,-3,1,4,1,3,1,1,1,1,1,4,1,1,1,1,1);
INSERT INTO `mob_resistances` VALUES (210,'Raptor',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,-2,-2,-3,-2,-2,0,0,-2,-2,-3,-2,-2,-2);
INSERT INTO `mob_resistances` VALUES (211,'Ruszor',0,0,0,0,0,0,0,0,0,0,0,0,0,-1,4,1,0,-1,5,0,1,4,4,1,0,5,0,1,1);
INSERT INTO `mob_resistances` VALUES (212,'Sabotender',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,-3,0,0,-2,4,4,-3,-3,-3,0,0,4,4,-3,-3);
INSERT INTO `mob_resistances` VALUES (213,'Sahagin',0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,-1,-1,-3,4,0,0,-2,-2,-1,-1,4,0,0,0);
INSERT INTO `mob_resistances` VALUES (214,'Sandworm',0,0,0,0,0,0,0,0,0,0,0,0,0,4,4,1,11,4,4,4,4,4,4,1,11,4,4,4,4);
INSERT INTO `mob_resistances` VALUES (215,'Sandworm - Giga Worm',0,0,0,0,0,0,0,0,0,0,0,0,0,4,4,1,11,4,4,4,4,4,4,1,11,4,4,4,4);
INSERT INTO `mob_resistances` VALUES (216,'Sapling',0,0,0,0,0,0,0,0,0,0,0,0,0,-3,-2,-2,0,-2,0,0,-3,-2,-2,-2,0,0,0,-3,-3);
INSERT INTO `mob_resistances` VALUES (217,'Scorpion',0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,0,0,-2,-2,-3,0,-3,-3,0,0,-2,-3,0,0);
INSERT INTO `mob_resistances` VALUES (218,'Sea_Monk',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,-3,-2,-2,-3,4,-2,-2,-3,-3,-2,-2,4,-2,-2,-2);
INSERT INTO `mob_resistances` VALUES (219,'Sea Monk - Tieholtsodi',-10000,0,0,0,0,0,0,0,0,0,0,0,0,-2,-3,-2,-2,-3,4,-2,-2,-3,-3,-2,-2,4,-2,-2,-2);
INSERT INTO `mob_resistances` VALUES (220,'Seether',0,0,0,0,0,0,0,0,0,0,0,0,0,11,11,0,0,0,-3,0,0,11,11,0,0,-3,0,0,0);
INSERT INTO `mob_resistances` VALUES (221,'Shadow - COP',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,4,0,0,0,0,-2,4,4,4,0,0,0,-2,4,4);
INSERT INTO `mob_resistances` VALUES (222,'Shadow - Brothers DAurphe',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,4,0,0,0,0,-2,4,4,4,0,0,0,-2,4,4);
INSERT INTO `mob_resistances` VALUES (223,'Shadow - NM',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,4,0,0,0,0,-2,4,4,4,0,0,0,-2,4,4);
-- 224 free
-- 225 free
INSERT INTO `mob_resistances` VALUES (226,'Sheep',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,0,-2,-2,-3,-3,-2,-2,0,0,-2,-2,-3,-2,-2,-2);
INSERT INTO `mob_resistances` VALUES (227,'Skeleton',-1250,-5000,1250,2500,0,0,0,0,0,0,0,0,0,-3,0,-2,-2,-2,-2,-3,4,0,0,-2,-2,-2,-3,11,4);
INSERT INTO `mob_resistances` VALUES (228,'Slime - NM',-5000,-5000,-7500,-7500,0,0,0,0,0,0,0,0,0,-3,-2,-2,-2,-2,-2,-2,-2,-2,-2,-2,-2,-2,-2,-2,-2);
INSERT INTO `mob_resistances` VALUES (229,'Slime',-5000,-5000,-7500,-7500,0,0,0,0,0,0,0,0,0,-3,-2,-2,-2,-2,-2,-2,-2,-2,-2,-2,-2,-2,-2,-2,-2);
INSERT INTO `mob_resistances` VALUES (230,'Unused',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (231,'Slug',0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,0,0,-1,11,0,0,-1,-1,0,0,11,0,0,0);
INSERT INTO `mob_resistances` VALUES (232,'Snoll',0,0,0,0,0,0,0,0,0,0,0,0,0,-1,3,1,1,1,1,1,1,3,3,1,1,1,1,1,1);
INSERT INTO `mob_resistances` VALUES (233,'Soulflayer',0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,9,-1,11,2,2,0,0,9,-1,11,11);
INSERT INTO `mob_resistances` VALUES (234,'Spheroid',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (235,'Spider',0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,0,0,-1,-1,0,0,-3,-3,0,0,-1,0,0,0);
INSERT INTO `mob_resistances` VALUES (236,'Structure',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (237,'Structure',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (238,'Archaic_Mirror',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (239,'Structure',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (240,'Tauri',0,0,2500,5000,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-2,2,-1,-1,-1,-1,-1,-2,2,2);
INSERT INTO `mob_resistances` VALUES (241,'Thinker',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,11,11,0,0,0,0,0,-3,11,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (242,'Tiger',0,0,0,0,0,0,0,0,0,0,0,0,0,-3,0,0,0,-3,-2,0,0,0,0,0,0,-2,0,0,0);
INSERT INTO `mob_resistances` VALUES (243,'Tonberry',0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-3,-1,0,-2,1,4,0,-3,-3,-1,0,1,4,0,0);
INSERT INTO `mob_resistances` VALUES (244,'Tonberry - Golden-Tongued_Culberry',0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-3,-1,0,-2,1,4,0,-3,-3,-1,0,1,4,0,0);
INSERT INTO `mob_resistances` VALUES (245,'Treant',0,0,0,0,0,0,0,0,0,0,0,0,0,-3,-2,-2,0,-2,0,0,-3,-2,-2,-2,0,0,0,-3,-3);
INSERT INTO `mob_resistances` VALUES (246,'Troll',0,0,0,0,0,0,0,0,0,0,0,0,0,3,0,-1,0,0,-2,-1,-1,0,0,-1,0,-2,-1,-1,-1);
INSERT INTO `mob_resistances` VALUES (247,'Tubes',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (248,'Turret-Orc',0,0,0,0,0,0,0,0,0,0,0,0,0,4,4,2,2,2,0,2,2,4,4,2,2,0,2,2,2);
INSERT INTO `mob_resistances` VALUES (249,'Turret-Quadav',0,0,0,0,0,0,0,0,0,0,0,0,0,4,2,2,2,1,4,2,2,2,2,2,2,4,2,2,2);
INSERT INTO `mob_resistances` VALUES (250,'Turret-Yagudo',0,0,0,0,0,0,0,0,0,0,0,0,0,2,1,4,4,2,2,2,2,1,1,4,4,2,2,2,2);
INSERT INTO `mob_resistances` VALUES (251,'Uragnite',0,0,0,0,0,0,0,0,0,0,0,0,0,3,-1,-1,-1,-3,3,-1,-1,-1,-1,-1,-1,3,-1,-1,-1);
INSERT INTO `mob_resistances` VALUES (252,'Vampyr',0,0,0,0,0,0,0,0,0,0,0,0,0,1,4,3,3,1,1,-1,11,4,4,3,3,1,-1,11,11);
INSERT INTO `mob_resistances` VALUES (253,'Wamoura',0,0,0,0,0,0,0,0,0,0,0,0,0,11,-2,2,-1,0,-2,0,-1,-2,-2,2,-1,-2,0,-1,-1);
INSERT INTO `mob_resistances` VALUES (254,'Wamouracampa',0,0,0,0,0,0,0,0,0,0,0,0,0,11,-2,2,-1,0,-2,0,-1,-2,-2,2,-1,-2,0,-1,-1);
INSERT INTO `mob_resistances` VALUES (255,'Wanderer',0,0,0,0,0,0,0,0,0,0,0,0,0,-3,11,11,0,0,0,0,0,11,11,11,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (256,'Weeper',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,11,0,0,0,0,0,-3,11,11);
INSERT INTO `mob_resistances` VALUES (257,'Wivre',0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,-2,3,1,-1,-1,-1,-2,-2,-2,3,-1,-1,-1,-1);
INSERT INTO `mob_resistances` VALUES (258,'Worm',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,-2,-3,2,-2,-2,-3,0,-2,-2,-3,2,-2,-3,0,0);
INSERT INTO `mob_resistances` VALUES (259,'Wyrm-Ouryu',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,11,11,0,0,0,0,0,-2,11,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (260,'Wyrm-Fafnir',0,0,0,0,0,0,0,0,0,0,0,0,0,11,11,0,0,0,-2,-2,0,11,11,0,0,-2,6,6,0);
INSERT INTO `mob_resistances` VALUES (261,'Wyrm-Cynoprosopi',0,0,0,0,0,0,0,0,0,0,0,0,0,11,11,0,0,0,-2,-2,0,11,11,0,0,-2,-2,0,0);
INSERT INTO `mob_resistances` VALUES (262,'Wyrm',0,0,0,0,0,0,0,0,0,0,0,0,0,11,11,0,0,0,-2,0,0,11,11,0,0,-2,0,0,0);
INSERT INTO `mob_resistances` VALUES (263,'Wyrm-Nidhogg',0,0,0,0,0,0,0,0,0,0,0,0,0,11,11,0,0,0,-2,-2,0,11,11,0,0,-2,6,6,0);
INSERT INTO `mob_resistances` VALUES (264,'Unused',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (265,'Wyvern-Simorg',0,0,0,0,0,0,0,0,0,0,0,0,0,4,1,0,0,-2,-2,-2,-3,1,1,0,0,-2,-2,-3,-3);
INSERT INTO `mob_resistances` VALUES (266,'Wyvern',0,0,0,0,0,0,0,0,0,0,0,0,0,4,1,0,0,-2,-2,-2,-3,1,1,0,0,-2,-2,-3,-3);
INSERT INTO `mob_resistances` VALUES (267,'Wyvern-Guivre',0,0,0,0,0,0,0,0,0,0,0,0,0,4,1,0,0,-2,-2,-2,-3,1,1,0,0,-2,-2,-3,-3);
INSERT INTO `mob_resistances` VALUES (268,'Wyvern-Undead',0,0,0,0,0,0,0,0,0,0,0,0,0,4,1,0,0,-2,-2,-2,-3,1,1,0,0,-2,-2,-3,-3);
INSERT INTO `mob_resistances` VALUES (269,'Xzomit',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,-2,0,-2,-2,-2,0,0,-2,-2,0,-2,-2,0,0,0);
INSERT INTO `mob_resistances` VALUES (270,'Yagudo',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,-3,0,0,-2,-2,-2,-2,-3,-3,0,0,-2,-2,-2,-2);
INSERT INTO `mob_resistances` VALUES (271,'Yovra',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,6,0,2,-1,0,0,0,-2,0,2,-1,-1);
INSERT INTO `mob_resistances` VALUES (272,'Zdei',0,0,0,0,0,0,0,0,0,0,0,0,0,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2);
INSERT INTO `mob_resistances` VALUES (273,'Scorpion-Serket',0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,0,0,-2,4,0,0,-2,-2,0,0,4,0,0,0);
INSERT INTO `mob_resistances` VALUES (274,'Scorpion-KingV',0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,0,0,-2,4,0,0,-2,-2,0,0,4,0,0,0);
INSERT INTO `mob_resistances` VALUES (275,'Adamantoise-Mini',0,0,0,0,0,0,0,0,0,0,0,0,0,4,-2,4,11,11,11,4,4,-2,-2,4,11,11,4,4,4);
INSERT INTO `mob_resistances` VALUES (276,'Worm-BigWorm',0,0,0,0,0,0,0,0,0,0,0,0,0,4,4,1,11,4,4,4,4,4,4,1,11,4,4,4,4);
INSERT INTO `mob_resistances` VALUES (277,'Adamantoise-Genbu',0,0,0,0,0,0,0,0,0,0,0,0,0,10,4,4,4,-2,10,4,4,4,4,4,4,10,4,4,4);
INSERT INTO `mob_resistances` VALUES (278,'Wyvern-Seiryu',0,0,0,0,0,0,0,0,0,0,0,0,0,4,-2,10,10,4,4,4,4,-2,-2,10,10,4,4,4,4);
INSERT INTO `mob_resistances` VALUES (279,'Tiger-Byakko',0,0,0,0,0,0,0,0,0,0,0,0,0,4,4,4,4,4,4,10,-2,4,4,4,4,4,10,-2,-2);
INSERT INTO `mob_resistances` VALUES (280,'Greater_Bird-Suzaku',-2500,2500,0,-2500,0,0,0,0,0,0,0,0,0,10,10,4,4,4,-2,4,4,10,10,4,4,-2,4,4,4);
INSERT INTO `mob_resistances` VALUES (281,'Manticore-Kirin',0,0,0,0,0,0,0,0,0,0,0,0,0,4,4,-2,10,10,4,4,4,4,4,-2,10,4,4,4,4);
INSERT INTO `mob_resistances` VALUES (282,'Tonberry-Grav_iton',0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-3,-1,0,-2,1,4,0,-3,-3,-1,0,1,4,0,0);
-- 283 free
INSERT INTO `mob_resistances` VALUES (284,'Vampyr',0,0,0,0,0,0,0,0,0,0,0,0,0,1,4,3,3,1,1,-1,11,4,4,3,3,1,-1,11,11);
INSERT INTO `mob_resistances` VALUES (285,'Gulool Ja Ja',0,0,0,0,0,0,0,0,0,0,0,0,0,4,2,9,9,4,4,4,4,2,2,9,9,4,4,4,4);
INSERT INTO `mob_resistances` VALUES (286,'Puk - Vulpangue - ZMN Tier 1',20000,2500,0,0,0,0,0,0,0,0,0,0,0,-1,-2,11,-1,0,-1,-1,-1,-2,-2,11,-1,-1,-1,-1,-1);
INSERT INTO `mob_resistances` VALUES (287,'Colibri - Chamrosh - ZMN Tier 1',0,2500,0,0,0,0,0,0,0,0,0,0,0,-1,-2,6,0,-1,-1,0,-2,-2,-2,6,0,-1,0,-2,-2);
INSERT INTO `mob_resistances` VALUES (288,'Qiqirn - Cheese Hoarder - ZNM Tier 1',0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-2,2,0,-1,-1,0,-1,-1,-2,2,-1,-1,0,0);
INSERT INTO `mob_resistances` VALUES (289,'Wamouracampa - BrassBorer - ZNM Tier 1',0,0,0,0,0,0,0,0,0,0,0,0,0,11,-2,2,-1,0,-2,0,-1,-2,-2,2,-1,-2,0,-1,-1);
INSERT INTO `mob_resistances` VALUES (290,'Slime - Claret - ZMN Tier 1',-7500,-7500,-8750,-8750,0,0,0,0,0,0,0,0,0,-3,-2,-2,-2,-2,-2,-2,-2,-2,-2,-2,-2,-2,-2,-2,-2);
INSERT INTO `mob_resistances` VALUES (291,'Automation - Ob - ZMN Tier 1',0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1);
INSERT INTO `mob_resistances` VALUES (292,'Skeleton - Velionis - ZMN Tier 1',-1250,-5000,1250,2500,0,0,0,0,0,0,0,0,0,-3,0,-2,-2,-2,-2,-3,4,0,0,-2,-2,-2,-3,4,4);
INSERT INTO `mob_resistances` VALUES (293,'Chigoe - Chigre - ZMN Tier 1',0,0,0,0,0,0,0,0,0,0,0,0,0,-1,1,1,2,1,-1,1,1,1,1,1,2,-1,1,1,1);
INSERT INTO `mob_resistances` VALUES (294,'Apkallu - Lil_Apkallu - ZMN Tier 1',0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,-1,-1,-2,5,-1,-1,1,1,-1,-1,5,-1,-1,-1);
INSERT INTO `mob_resistances` VALUES (295,'Marid - IrizIma - ZNM Tier 2',0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,2,-1,0,-1,-1,-1,-1,-1,2,0,-1,-1,-1);
INSERT INTO `mob_resistances` VALUES (296,'Morbol - LividrootAmoo - ZNM Tier 2',0,0,0,0,0,0,0,0,0,0,0,0,0,-3,-2,-2,-2,-2,4,-2,4,-2,-2,-2,-2,4,-2,4,4);
INSERT INTO `mob_resistances` VALUES (297,'Poroggo - IririSamariri - ZNM Tier 2',0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,1,-1,8,6,0,2,2,0,1,8,6,0,0);
INSERT INTO `mob_resistances` VALUES (298,'Dragon - Anantaboga - ZNM Tier 2',0,0,0,0,0,0,0,0,0,0,0,0,0,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2);
INSERT INTO `mob_resistances` VALUES (299,'Botuli',-1250,0,-2500,-2500,0,0,0,0,0,0,0,0,0,1,6,6,6,1,9,3,4,6,6,6,6,9,3,4,4);
INSERT INTO `mob_resistances` VALUES (300,'Bomb - Reacton - ZNM Tier 2',0,0,0,0,0,0,0,0,0,0,0,0,0,-3,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4);
INSERT INTO `mob_resistances` VALUES (301,'Imp-Verdelet - ZNM Tier 2',0,2500,0,0,0,0,0,0,0,0,0,0,0,0,0,3,0,0,0,-1,8,0,0,3,0,0,-1,8,8);
INSERT INTO `mob_resistances` VALUES (302,'Acrolith-Wulgaru - ZNM Tier 2',0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,3,3,2,0,6,11,3,3,3,3,0,6,11,11);
INSERT INTO `mob_resistances` VALUES (303,'Qutrub - ZareehklTheJu - ZNM Tier 2',10000,10000,10000,10000,0,0,0,0,0,0,0,0,0,-2,4,-1,1,-1,-1,-2,4,4,4,-1,1,-1,-2,4,4);
INSERT INTO `mob_resistances` VALUES (304,'Gear-ArmedGears - ZNM Tier 3',0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,4,-1,4,1,1,1,1,1,-1,4,1,1);
INSERT INTO `mob_resistances` VALUES (305,'Mamool_Ja - GotohZhaTheRe - ZNM Tier 3',0,0,0,0,0,0,0,0,0,0,0,0,0,1,-1,4,1,0,1,1,0,-1,-1,4,1,1,1,0,0);
INSERT INTO `mob_resistances` VALUES (306,'Wivre-Dea - ZNM Tier 3',0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,-2,3,1,-1,-1,-1,-2,-2,-2,3,-1,-1,-1,-1);
INSERT INTO `mob_resistances` VALUES (307,'Wamoura - Achamoth - ZNM Tier 3',0,0,0,0,0,0,0,0,0,0,0,0,0,11,-2,2,-1,0,-2,0,-1,-2,-2,2,-1,-2,0,-1,-1);
INSERT INTO `mob_resistances` VALUES (308,'Troll-Khromasoul - ZNM Tier 3',0,0,0,0,0,0,0,0,0,0,0,0,0,5,2,1,2,2,0,1,1,2,2,1,2,0,1,1,1);
INSERT INTO `mob_resistances` VALUES (309,'Vampyre - Nosferatu - ZNM Tier 3',0,0,0,0,0,0,0,0,0,0,0,0,0,1,4,3,3,1,1,-1,11,4,4,3,3,1,-1,11,11);
INSERT INTO `mob_resistances` VALUES (310,'Lamia - ExperimentalLa - ZNM Tier 3',0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,1,0,5,0,4,0,0,1,1,5,0,4,4);
INSERT INTO `mob_resistances` VALUES (311,'Soulflayer - MahjlaefThePai - ZNM Tier 3',0,0,0,0,0,0,0,0,0,0,0,0,0,2,4,2,2,2,10,1,11,4,4,2,2,10,1,11,11);
INSERT INTO `mob_resistances` VALUES (312,'Orobon - Nuhn - ZNM Tier 3',0,0,0,0,0,0,0,0,0,0,0,0,0,-1,1,-1,-1,-2,6,-2,3,1,1,-1,-1,6,-2,3,3);
INSERT INTO `mob_resistances` VALUES (313,'Hydra - Tinnin - ZNM Tier 4',0,0,0,-1250,0,0,0,0,0,0,0,0,0,3,3,3,0,0,0,0,0,3,3,3,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (314,'Cerberus - Sarameya - ZNM Tier 4',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (315,'Khimaira - Tyger - ZNM Tier 4',0,0,0,0,0,0,0,0,0,0,0,0,0,8,5,8,7,9,5,7,5,5,5,8,7,5,7,5,5);
INSERT INTO `mob_resistances` VALUES (316,'Dvergr - Pandemonium - ZNM Tier 4',0,0,0,0,0,0,0,0,0,0,0,0,0,4,6,4,6,4,6,2,11,6,6,4,6,6,2,11,11);
-- 317 free
-- 318 free
INSERT INTO `mob_resistances` VALUES (319,'Avatar-Shiva',0,0,0,0,0,0,0,0,0,0,0,0,0,-3,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11);
INSERT INTO `mob_resistances` VALUES (320,'Avatar-Ramuh',0,0,0,0,0,0,0,0,0,0,0,0,0,11,11,11,-3,11,11,11,11,11,11,11,-3,11,11,11,11);
INSERT INTO `mob_resistances` VALUES (321,'Avatar-Titan',0,0,0,0,0,0,0,0,0,0,0,0,0,11,11,-3,11,11,11,11,11,11,11,-3,11,11,11,11,11);
INSERT INTO `mob_resistances` VALUES (322,'Avatar-Ifrit',0,0,0,0,0,0,0,0,0,0,0,0,0,11,11,11,11,11,-3,11,11,11,11,11,11,-3,11,11,11);
INSERT INTO `mob_resistances` VALUES (323,'Avatar-Leviathan',0,0,0,0,0,0,0,0,0,0,0,0,0,11,11,11,11,-3,11,11,11,11,11,11,11,11,11,11,11);
INSERT INTO `mob_resistances` VALUES (324,'Avatar-Garuda',0,0,0,0,0,0,0,0,0,0,0,0,0,6,0,11,11,6,6,6,6,0,0,11,11,6,6,6,6);
INSERT INTO `mob_resistances` VALUES (325,'Avatar-Fenrir',0,0,0,0,0,0,0,0,0,0,0,0,0,3,3,3,3,3,3,-2,11,3,3,3,3,3,-2,11,11);
INSERT INTO `mob_resistances` VALUES (326,'Troll-Gurfurlur',0,0,0,0,0,0,0,0,0,0,0,0,0,7,7,2,7,7,2,4,4,7,7,2,7,2,4,4,4);
INSERT INTO `mob_resistances` VALUES (327,'Goblin - Dynamis',0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-2,1,-1,-1,-1,-1,-1,-2,1,1);
INSERT INTO `mob_resistances` VALUES (328,'Gigas - Cottus',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (329,'AbsoluteVirtue',0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,6,-2,-1,-1,-1,-1,-1,6,-2,-2);
INSERT INTO `mob_resistances` VALUES (330,'Adamantoise-PetGenbu',0,0,0,0,0,0,0,0,0,0,0,0,0,10,4,4,4,-2,10,4,4,4,4,4,4,10,4,4,4);
INSERT INTO `mob_resistances` VALUES (331,'Wyvern-PetSeiryu',0,0,0,0,0,0,0,0,0,0,0,0,0,4,-2,10,10,4,4,4,4,-2,-2,10,10,4,4,4,4);
INSERT INTO `mob_resistances` VALUES (332,'Tiger-PetByakko',0,0,0,0,0,0,0,0,0,0,0,0,0,4,4,4,4,4,4,10,-2,4,4,4,4,4,10,-2,-2);
INSERT INTO `mob_resistances` VALUES (333,'Greater_Bird-PetSuzaku',-2500,2500,0,-2500,0,0,0,0,0,0,0,0,0,10,10,4,4,4,-2,4,4,10,10,4,4,-2,4,4,4);
INSERT INTO `mob_resistances` VALUES (334,'Orc-NM',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,-2,-2,-3,-2,-2,0,0,-2,-2,-3,-2,-2,-2);
INSERT INTO `mob_resistances` VALUES (335,'Maat',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (336,'Tonberry-ZM4',0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-3,-1,0,-2,1,4,0,-3,-3,-1,0,1,4,0,0);
INSERT INTO `mob_resistances` VALUES (337,'Quadav-NM',0,2500,0,0,0,0,0,0,0,0,0,0,0,1,-1,-1,-1,-2,1,-1,-1,-1,-1,-1,-1,1,-1,-1,-1);
INSERT INTO `mob_resistances` VALUES (338,'Twitherym',0,2500,0,0,0,0,0,0,0,0,0,0,0,0,-2,0,4,-2,-2,2,0,-2,-2,0,4,-2,2,0,0);
INSERT INTO `mob_resistances` VALUES (339,'Chapuli',0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,2,2,-2,-2,0,2,-2,-2,2,2,-2,0,2,2);
INSERT INTO `mob_resistances` VALUES (340,'Mantid',0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,4,4,0,-2,2,2,-1,-1,4,4,-2,2,2,2);
INSERT INTO `mob_resistances` VALUES (341,'Blossom',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (342,'Velkk',0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,0,0,-2,4,0,2,-2,-2,0,0,4,0,2,2);
INSERT INTO `mob_resistances` VALUES (343,'Heartwing',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10,10,0,0,0,0,0,10,10,10);
INSERT INTO `mob_resistances` VALUES (344,'Craklaw',-1000,-1000,-1000,-1000,0,0,0,0,0,0,0,0,0,-2,0,4,2,-2,4,0,0,0,0,4,2,4,0,0,0);
INSERT INTO `mob_resistances` VALUES (345,'Acuex',-5000,-5000,-7500,-7500,0,0,0,0,0,0,0,0,0,-3,0,0,3,0,5,-2,0,0,0,0,3,5,-2,0,0);
INSERT INTO `mob_resistances` VALUES (346,'Obstacle-Knotted_Root',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,-2,-2,-2,-2,-2,-2,-2,-2,-2,-2,-2,-2,-2,-2,-2);
INSERT INTO `mob_resistances` VALUES (347,'Marolith',0,0,0,0,0,0,0,0,0,0,0,0,0,2,2,2,3,-3,2,2,2,2,2,2,3,2,2,2,2);
INSERT INTO `mob_resistances` VALUES (348,'Matamata',0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,2,0,0,0,2,2,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (349,'Geyser',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (350,'Iron_Giant',0,0,0,0,0,0,0,0,0,0,0,0,0,4,6,4,4,0,2,4,4,6,6,4,4,2,4,4,4);
INSERT INTO `mob_resistances` VALUES (351,'Kamlanaut',0,0,0,0,0,0,0,0,0,0,0,0,0,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3);
INSERT INTO `mob_resistances` VALUES (352,'ArkAngel-EV',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (353,'ArkAngel-GK',0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,2,1,1,0,2,1,1,1,2,1,0,2,2);
INSERT INTO `mob_resistances` VALUES (354,'ArkAngel-HM',0,0,0,0,0,0,0,0,0,0,0,0,0,2,1,1,1,1,1,0,2,1,1,1,1,1,0,2,2);
INSERT INTO `mob_resistances` VALUES (355,'ArkAngel-MR',0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,2,1,1,1,0,2,1,1,2,1,1,0,2,2);
INSERT INTO `mob_resistances` VALUES (356,'ArkAngel-TT',0,0,0,0,0,0,0,0,0,0,0,0,0,1,2,1,1,1,2,0,2,2,2,1,1,2,0,2,2);
INSERT INTO `mob_resistances` VALUES (357,'Antlion-Ambush',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,3,0,0,-3,3,0,0,-2,3,0,-3,3,3);
INSERT INTO `mob_resistances` VALUES (358,'Kindred - Dynamis',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,0,0,0,0,0,0,-2,0,0);
INSERT INTO `mob_resistances` VALUES (359,'Fomor - Hydra',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,4,0,0,0,0,-2,4,4,4,0,0,0,-2,4,4);
INSERT INTO `mob_resistances` VALUES (360,'Yagudo-NM',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,-3,0,0,-2,-2,-2,-2,-3,-3,0,0,-2,-2,-2,-2);
INSERT INTO `mob_resistances` VALUES (361,'DynamisLord',0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1);
INSERT INTO `mob_resistances` VALUES (362,'Sabotender-Florido',0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,2,2,0,6,6,0,-2,-2,2,2,6,6,0,0);
INSERT INTO `mob_resistances` VALUES (363,'Automaton_Harlequin',0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1);
INSERT INTO `mob_resistances` VALUES (364,'Automaton_Valoredge',0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1);
INSERT INTO `mob_resistances` VALUES (365,'Automaton_Sharpshot',0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1);
INSERT INTO `mob_resistances` VALUES (366,'Automaton_Stormwaker',0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1);
INSERT INTO `mob_resistances` VALUES (367,'Doll-Faust',0,0,0,0,0,0,0,0,0,0,0,0,0,2,2,2,2,-3,2,2,2,2,2,2,2,2,2,2,2);
INSERT INTO `mob_resistances` VALUES (368,'Doll-Despot',0,0,0,0,0,0,0,0,0,0,0,0,0,2,2,2,2,-3,2,2,2,2,2,2,2,2,2,2,2);
INSERT INTO `mob_resistances` VALUES (369,'Leech',0,0,-2500,-2500,0,0,0,0,0,0,0,0,0,-2,-2,0,0,0,4,-3,2,-2,-2,0,0,4,-3,2,2);
-- 370 free
INSERT INTO `mob_resistances` VALUES (371,'Marid',0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,2,-1,0,-1,-1,-1,-1,-1,2,0,-1,-1,-1);
INSERT INTO `mob_resistances` VALUES (372,'Crab',-5000,-5000,-5000,-5000,0,0,0,0,0,0,0,0,0,-2,-3,-2,-2,-3,2,-2,-2,-3,-3,-2,-2,2,-2,-2,-2);
INSERT INTO `mob_resistances` VALUES (373,'Goblin - Dynamis NM',0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-2,1,-1,-1,-1,-1,-1,-2,1,1);
INSERT INTO `mob_resistances` VALUES (374,'Fly- Houndfly',0,2500,0,0,0,0,0,0,0,0,0,0,0,-2,-3,0,0,-2,-2,-2,-2,-3,-3,0,0,-2,-2,-2,-2);
INSERT INTO `mob_resistances` VALUES (375,'Fly - Huntfly',0,2500,0,0,0,0,0,0,0,0,0,0,0,-2,-3,0,0,-2,-2,-2,-2,-3,-3,0,0,-2,-2,-2,-2);
INSERT INTO `mob_resistances` VALUES (376,'Panopt',0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,4,2,1,2,3,5,2,2,4,2,2,3,5,5);
INSERT INTO `mob_resistances` VALUES (377,'Nival Raptor',0,0,0,0,0,0,0,0,0,0,0,0,0,-3,0,0,-2,-2,-2,-2,-2,0,0,0,-2,-2,-2,-2,-2);
INSERT INTO `mob_resistances` VALUES (378,'Avatar-Diabolos',0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,0,4,1,1,1,1,1,0,4,4);
INSERT INTO `mob_resistances` VALUES (379,'Pet-Carbuncle',0,0,0,0,0,0,0,0,0,0,0,0,0,6,6,6,6,6,6,11,0,6,6,6,6,6,11,0,0);
INSERT INTO `mob_resistances` VALUES (380,'Pet-Diabolos',0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,0,4,1,1,1,1,1,0,4,4);
INSERT INTO `mob_resistances` VALUES (381,'Pet-Fenrir',0,0,0,0,0,0,0,0,0,0,0,0,0,3,3,3,3,3,3,-2,11,3,3,3,3,3,-2,11,11);
INSERT INTO `mob_resistances` VALUES (382,'Pet-Garuda',0,0,0,0,0,0,0,0,0,0,0,0,0,6,0,11,11,6,6,6,6,0,0,11,11,6,6,6,6);
INSERT INTO `mob_resistances` VALUES (383,'Pet-Ifrit',0,0,0,0,0,0,0,0,0,0,0,0,0,11,11,11,11,11,-3,11,11,11,11,11,11,-3,11,11,11);
INSERT INTO `mob_resistances` VALUES (384,'Pet-Leviathan',0,0,0,0,0,0,0,0,0,0,0,0,0,11,11,11,11,-3,11,11,11,11,11,11,11,11,11,11,11);
INSERT INTO `mob_resistances` VALUES (385,'Pet-Odin',0,0,0,0,0,0,0,0,0,0,0,0,0,5,7,5,7,5,7,4,11,7,7,5,7,7,4,11,11);
INSERT INTO `mob_resistances` VALUES (386,'Pet-Ramuh',0,0,0,0,0,0,0,0,0,0,0,0,0,11,11,11,-3,11,11,11,11,11,11,11,-3,11,11,11,11);
INSERT INTO `mob_resistances` VALUES (387,'Pet-Shiva',0,0,0,0,0,0,0,0,0,0,0,0,0,-3,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11);
INSERT INTO `mob_resistances` VALUES (388,'Pet-Titan',0,0,0,0,0,0,0,0,0,0,0,0,0,11,11,-3,11,11,11,11,11,11,11,-3,11,11,11,11,11);
INSERT INTO `mob_resistances` VALUES (389,'Pet-Alexander',0,0,0,0,0,0,0,0,0,0,0,0,0,5,5,5,5,5,5,11,5,5,5,5,5,5,11,5,5);
INSERT INTO `mob_resistances` VALUES (390,'Ladybug-DUP',0,2500,0,0,0,0,0,0,0,0,0,0,0,0,-2,6,2,0,0,0,0,-2,-2,6,2,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (391,'Wyrm-Vrtra',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,11,0,0,0,0,0,-2,11,11);
INSERT INTO `mob_resistances` VALUES (392,'Wyrm-Jormungand',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,11,11,0,0,0,0,0,11,11,11,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (393,'Wyrm-Tiamat',0,0,0,0,0,0,0,0,0,0,0,0,0,11,11,0,0,0,-2,0,0,11,11,0,0,-2,0,0,0);
INSERT INTO `mob_resistances` VALUES (394,'Ealdnarche_2',0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1);
INSERT INTO `mob_resistances` VALUES (395,'Doll-Calcabrina',0,0,0,0,0,0,0,0,0,0,0,0,0,2,2,2,2,-3,2,2,2,2,2,2,2,2,2,2,2);
INSERT INTO `mob_resistances` VALUES (396,'Worm-Bedrock_Barry',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,-2,-3,2,-2,-2,-3,0,-2,-2,-3,2,-2,-3,0,0);
INSERT INTO `mob_resistances` VALUES (397,'Quadav-Qu_Vho_Deathhurler',0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,-2,-2,-3,0,-2,-2,-2,-2,-2,-2,0,-2,-2,-2);
INSERT INTO `mob_resistances` VALUES (398,'Sheep-Slumbering_Samwell',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,0,-2,-2,-3,-3,-2,-2,0,0,-2,-2,-3,-2,-2,-2);
-- 399 free
INSERT INTO `mob_resistances` VALUES (400,'Crab-Tegmine',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,-3,-2,-2,-3,2,-2,-2,-3,-3,-2,-2,2,-2,-2,-2);
INSERT INTO `mob_resistances` VALUES (401,'Doll-Martinet',0,0,0,0,0,0,0,0,0,0,0,0,0,2,2,2,2,-3,2,2,2,2,2,2,2,2,2,2,2);
INSERT INTO `mob_resistances` VALUES (402,'Scorpion -Aqrabuamelu',0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,0,0,-2,-2,-3,0,-3,-3,0,0,-2,-3,0,0);
INSERT INTO `mob_resistances` VALUES (403,'Doll-Autarch',0,0,0,0,0,0,0,0,0,0,0,0,0,2,2,2,2,-3,2,2,2,2,2,2,2,2,2,2,2);
INSERT INTO `mob_resistances` VALUES (404,'Rabbit-Cure',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,-1,-2,-1,-3,-3,-1,-3,-1,-1,-2,-1,-3,-1,-3,-3);
-- 405 free
INSERT INTO `mob_resistances` VALUES (406,'Mandragora-Seed_Mandra',0,2500,0,0,0,0,0,0,0,0,0,0,0,-3,-3,-3,0,-3,0,0,-3,-3,-3,-3,0,0,0,-3,-3);
INSERT INTO `mob_resistances` VALUES (407,'Orc-Seed',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-2,-2,-2,-3,-2,-2,0,0,-2,-2,-3,-2,-2,-2);
INSERT INTO `mob_resistances` VALUES (408,'Quadav-Seed',0,2500,0,0,0,0,0,0,0,0,0,0,0,0,-2,-2,-2,-3,0,-2,-2,-2,-2,-2,-2,0,-2,-2,-2);
INSERT INTO `mob_resistances` VALUES (409,'Yagudo-Seed',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,-3,0,0,-2,-2,-2,-2,-3,-3,0,0,-2,-2,-2,-2);
INSERT INTO `mob_resistances` VALUES (410,'Goblin-Seed',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,-2,-2,-2,-2,-2,-3,0,-2,-2,-2,-2,-2,-3,0,0);
INSERT INTO `mob_resistances` VALUES (411,'Pet-Siren',0,0,0,0,0,0,0,0,0,0,0,0,0,4,2,11,11,4,4,11,2,2,2,11,11,4,11,2,2);
-- 412 to 434 free
INSERT INTO `mob_resistances` VALUES (435,'Giant_Gnat',0,0,0,0,0,0,0,0,0,0,0,0,0,-1,0,3,0,0,0,-2,4,0,0,3,0,0,-2,4,4);
INSERT INTO `mob_resistances` VALUES (436,'Gnat-Bloodlapper',0,0,0,0,0,0,0,0,0,0,0,0,0,-1,0,3,0,0,0,-2,4,0,0,3,0,0,-2,4,4);
INSERT INTO `mob_resistances` VALUES (437,'Sapling-Ghillie_Dhu',0,0,0,0,0,0,0,0,0,0,0,0,0,-3,-2,-2,0,-2,0,0,-3,-2,-2,-2,0,0,0,-3,-3);
INSERT INTO `mob_resistances` VALUES (438,'Lizard-Highlander',0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,-3,0,0,-2,-2,-2,-3,-3,-3,0,-2,-2,-2,-2);
-- 439 to 443 free
INSERT INTO `mob_resistances` VALUES (444,'Larzos',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,4,0,0,0,0,-2,4,4,4,0,0,0,-2,4,4);
INSERT INTO `mob_resistances` VALUES (445,'Portia',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (446,'Ragelise',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (447,'Dullahan',-2500,-2500,-5000,-5000,0,0,0,0,0,0,0,0,0,-2,6,2,3,2,3,-2,9,6,6,2,3,3,-2,9,9);
INSERT INTO `mob_resistances` VALUES (448,'Fluturini',0,2500,0,0,0,0,0,0,0,0,0,0,0,0,-2,0,4,-2,-2,2,0,-2,-2,0,4,-2,2,0,0);
INSERT INTO `mob_resistances` VALUES (449,'Bahamut',0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,6,0,0,0,0,0,0,6,6);
INSERT INTO `mob_resistances` VALUES (450,'Caturae',0,0,0,0,0,0,0,0,0,0,0,0,0,2,4,2,4,2,4,0,8,4,4,2,4,4,0,8,8);
INSERT INTO `mob_resistances` VALUES (451,'Pteraketos',0,0,0,0,0,0,0,0,0,0,0,0,0,1,3,3,1,2,2,4,2,3,3,3,1,2,4,2,2);
INSERT INTO `mob_resistances` VALUES (452,'Rockfin',0,0,0,0,0,0,0,0,0,0,0,0,0,9,4,4,2,2,9,4,6,4,4,4,2,9,4,6,6);
INSERT INTO `mob_resistances` VALUES (453,'Rafflesia-Belladona',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,0,-1,3,1,0,2,0,0,0,-1,3,0,2,0,0);
INSERT INTO `mob_resistances` VALUES (454,'Tulfaire',0,2500,0,0,0,0,0,0,0,0,0,0,0,4,-2,4,-2,2,2,2,2,-2,-2,4,-2,2,2,2,2);
INSERT INTO `mob_resistances` VALUES (455,'Leafkin',0,0,0,0,0,0,0,0,0,0,0,0,0,-3,4,2,4,2,8,11,4,4,4,2,4,8,11,4,4);
INSERT INTO `mob_resistances` VALUES (456,'Bztavian-Colkhab',0,2500,0,0,0,0,0,0,0,0,0,0,0,2,2,9,9,4,4,6,4,2,2,9,9,4,6,4,4);
INSERT INTO `mob_resistances` VALUES (457,'Cehuetzi-Kumhau',0,0,0,0,0,0,0,0,0,0,0,0,0,2,9,9,4,4,4,6,2,9,9,9,4,4,6,2,2);
INSERT INTO `mob_resistances` VALUES (458,'Raaz',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,2,-1,-1,-1,-1,-1,2,2,2,-1,-1,-1,-1,2,2);
INSERT INTO `mob_resistances` VALUES (459,'Yztarg',0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,2,7,2,1,1,1,0,0,2,7,1,1,1,1);
INSERT INTO `mob_resistances` VALUES (460,'Waktza',0,2500,0,0,0,0,0,0,0,0,0,0,0,4,2,9,2,9,4,4,6,2,2,9,2,4,4,6,6);
INSERT INTO `mob_resistances` VALUES (461,'Gabbrath',0,0,0,0,0,0,0,0,0,0,0,0,0,9,9,4,4,2,2,6,4,9,9,4,4,2,6,4,4);
INSERT INTO `mob_resistances` VALUES (462,'Provenance_Watcher',0,0,0,0,0,0,0,0,0,0,0,0,0,3,3,3,3,3,3,6,3,3,3,3,3,3,6,3,3);
INSERT INTO `mob_resistances` VALUES (463,'Panopt',0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,4,2,1,2,3,5,2,2,4,2,2,3,5,5);
INSERT INTO `mob_resistances` VALUES (464,'Snapweed',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,-2,4,2,4,3,2,4,-2,-2,4,2,3,2,4,4);
INSERT INTO `mob_resistances` VALUES (465,'Yumcax',0,0,0,0,0,0,0,0,0,0,0,0,0,0,6,2,11,11,10,4,6,6,6,2,11,10,4,6,6);
INSERT INTO `mob_resistances` VALUES (467,'Gallu',0,0,0,0,0,0,0,0,0,0,0,0,0,3,4,3,4,3,4,-1,9,4,4,3,4,4,-1,9,9);
-- 466 free
INSERT INTO `mob_resistances` VALUES (468,'Umbril',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,0,0,0,0,0,-3,10,0,0,0,0,0,-3,10,10);
INSERT INTO `mob_resistances` VALUES (469,'Lamiae-Medusa',0,0,0,0,0,0,0,0,0,0,0,0,0,4,4,4,2,9,9,4,4,4,4,4,2,9,4,4,4);
INSERT INTO `mob_resistances` VALUES (470,'Zilant-Yilbegan',0,0,0,0,0,0,0,0,0,0,0,0,0,2,4,2,4,2,4,0,11,4,4,2,4,4,0,11,11);
INSERT INTO `mob_resistances` VALUES (471,'Harpeia',-2500,2500,0,-2500,0,0,0,0,0,0,0,0,0,1,0,9,5,1,1,1,1,0,0,9,5,1,1,1,1);
INSERT INTO `mob_resistances` VALUES (472,'Naraka',-2500,-2500,-5000,-5000,0,0,0,0,0,0,0,0,0,0,5,2,3,2,2,0,9,5,5,2,3,2,0,9,9);
INSERT INTO `mob_resistances` VALUES (473,'Lady_Lilith',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,4,0,0,0,0,0,2,4,4);
INSERT INTO `mob_resistances` VALUES (474,'Lilith_Ascendant',0,0,0,0,0,0,0,0,0,0,0,0,0,3,3,3,3,3,3,8,8,3,3,3,3,3,8,8,8);
INSERT INTO `mob_resistances` VALUES (475,'Wrong-Shinryu',0,0,0,0,0,0,0,0,0,0,0,0,0,3,3,3,3,3,3,6,6,3,3,3,3,3,6,6,6);
INSERT INTO `mob_resistances` VALUES (476,'Prishe',0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1);
INSERT INTO `mob_resistances` VALUES (477,'Selh\'teus',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (478,'God - Promathia_2',0,0,0,0,0,0,0,0,0,0,0,0,0,2,2,2,2,2,2,0,11,2,2,2,2,2,0,11,11);
INSERT INTO `mob_resistances` VALUES (479,'Behemoth-KB',0,0,0,0,0,0,0,0,0,0,0,0,0,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2);
INSERT INTO `mob_resistances` VALUES (480,'Zeid',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (481,'Ajido-Marujido',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (482,'Volker',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (483,'Trion',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (484,'Lilisette',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (485,'Hadesv1',0,0,0,0,0,0,0,0,0,0,0,0,0,3,9,6,8,3,6,3,11,9,9,6,8,6,3,11,11);
INSERT INTO `mob_resistances` VALUES (486,'Arciela',0,0,0,0,0,0,0,0,0,0,0,0,0,2,11,2,11,2,11,2,11,11,11,2,11,11,2,11,11);
INSERT INTO `mob_resistances` VALUES (487,'Hadesv2',0,0,0,0,0,0,0,0,0,0,0,0,0,3,9,6,8,3,6,3,11,9,9,6,8,6,3,11,11);
INSERT INTO `mob_resistances` VALUES (488,'Theodor',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (489,'Darrcuiln',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,1,1,1,-2,-1,1,1,1,1,1,1,-1,1,1,1);
INSERT INTO `mob_resistances` VALUES (490,'Plovid',0,0,0,0,0,0,0,0,0,0,0,0,0,2,4,2,1,2,9,2,11,4,4,2,1,9,2,11,11);
INSERT INTO `mob_resistances` VALUES (491,'Morimar',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-3,0,0,0,0,0,0,-3,-3);
INSERT INTO `mob_resistances` VALUES (492,'Defiant-Balamor',0,0,0,0,0,0,0,0,0,0,0,0,0,2,6,6,8,4,8,4,11,6,6,6,8,8,4,11,11);
INSERT INTO `mob_resistances` VALUES (493,'Macuil-Ashrakk',0,0,0,0,0,0,0,0,0,0,0,0,0,4,1,8,2,8,2,2,11,1,1,8,2,2,2,11,11);
INSERT INTO `mob_resistances` VALUES (494,'Coeurl-Sekhmet',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,-2,-2,-3,0,-2,-2,-2,-2,-2,-2,-3,-2,-2,-2,-2);
INSERT INTO `mob_resistances` VALUES (495,'Unused',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (496,'Mandragora-Chaneque',0,2500,0,0,0,0,0,0,0,0,0,0,0,-3,-3,-3,0,-3,0,0,-3,-3,-3,-3,0,0,0,-3,-3);
INSERT INTO `mob_resistances` VALUES (497,'Cloud_of_Darkness',0,0,0,0,0,0,0,0,0,0,0,0,0,3,9,3,9,3,9,2,11,9,9,3,9,9,2,11,11);
INSERT INTO `mob_resistances` VALUES (498,'Doll - Groundskeeper',0,0,0,0,0,0,0,0,0,0,0,0,0,2,2,2,2,-3,2,2,2,2,2,2,2,2,2,2,2);
INSERT INTO `mob_resistances` VALUES (499,'Wanderer-Stray',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (500,'Golem-Mokkurkalfi',0,0,0,0,0,0,0,0,0,0,0,0,0,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2);
INSERT INTO `mob_resistances` VALUES (501,'Doll-Nio_A-Nio_Hum',0,0,0,0,0,0,0,0,0,0,0,0,0,2,2,2,2,-3,2,2,2,2,2,2,2,2,2,2,2);
INSERT INTO `mob_resistances` VALUES (502,'Evil_Weapon-Shikigami',0,0,0,0,0,0,0,0,0,0,0,0,0,-3,0,-2,-2,-2,-2,-3,0,0,0,-2,-2,-2,-3,0,0);
INSERT INTO `mob_resistances` VALUES (503,'Mammet',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (504,'Luopan',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (505,'Fungi',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (506,'Meeble',0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,3,0,-1,-1,0,-1,-1,-1,3,-1,-1,0,0);
INSERT INTO `mob_resistances` VALUES (507,'Quasilumin',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (508,'Riko_Kupenreich',0,0,0,0,0,0,0,0,0,0,0,0,0,-3,-3,-3,-3,-3,-3,-3,-3,-3,-3,-3,-3,-3,-3,-3,-3);
INSERT INTO `mob_resistances` VALUES (509,'Botulus_Rex',0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,4,4,0,6,1,5,4,4,4,4,6,1,5,5);
INSERT INTO `mob_resistances` VALUES (510,'Bismarck',0,0,0,0,0,0,0,0,0,0,0,0,0,1,3,3,1,4,8,4,2,3,3,3,1,8,4,2,2);
INSERT INTO `mob_resistances` VALUES (511,'Shockmaw',0,0,0,0,0,0,0,0,0,0,0,0,0,1,3,3,1,2,2,4,2,3,3,3,1,2,4,2,2);
INSERT INTO `mob_resistances` VALUES (512,'Cetus',0,0,0,0,0,0,0,0,0,0,0,0,0,2,4,2,4,2,4,1,6,4,4,2,4,4,1,6,6);
INSERT INTO `mob_resistances` VALUES (513,'Pakecet',0,0,0,0,0,0,0,0,0,0,0,0,0,2,4,2,4,2,4,1,6,4,4,2,4,4,1,6,6);
INSERT INTO `mob_resistances` VALUES (514,'Metus',0,0,0,0,0,0,0,0,0,0,0,0,0,2,2,2,2,2,2,0,11,2,2,2,2,2,0,11,11);
INSERT INTO `mob_resistances` VALUES (515,'Wyvern - Ajattara',0,0,0,0,0,0,0,0,0,0,0,0,0,3,0,2,0,-1,-1,-1,-2,0,0,2,0,-1,-1,-2,-2);
INSERT INTO `mob_resistances` VALUES (516,'Gigas - Alkyoneus',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (517,'Gigas - Blizzard',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,4,0,0,0,0,0,0,4,4,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (518,'Proto - Omega',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,0,0,11,0,0,0,0,0,0,11,11);
INSERT INTO `mob_resistances` VALUES (519,'Avatar-Carbuncle_Prime_WTB',0,0,0,0,0,0,0,0,0,0,0,0,0,6,6,6,6,6,6,11,0,6,6,6,6,6,11,0,0);
INSERT INTO `mob_resistances` VALUES (520,'Bronzecap',0,0,0,0,0,0,0,0,0,0,0,0,0,-2,-2,-2,-2,-2,4,-3,4,-2,-2,-2,-2,4,-3,6,6);
INSERT INTO `mob_resistances` VALUES (521,'Ebony_Pudding',-1250,0,-2500,-2500,0,0,0,0,0,0,0,0,0,-1,1,1,1,-1,3,-1,2,1,1,7,1,3,-1,2,2);
INSERT INTO `mob_resistances` VALUES (522,'Jnun',1250,0,-1250,-1250,0,0,0,0,0,0,0,0,0,-2,3,0,0,0,2,-2,8,3,3,0,0,2,-2,4,4);
