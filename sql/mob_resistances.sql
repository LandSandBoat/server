/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
DROP TABLE IF EXISTS `mob_resistances`;
CREATE TABLE `mob_resistances` (
  `resist_id` smallint(4) unsigned NOT NULL,
  `name` tinytext, -- Purely for human readability
  `slash_sdt` float NOT NULL DEFAULT 1, -- Physical categories SDT (Too specific. Study removal)
  `pierce_sdt` float NOT NULL DEFAULT 1,
  `h2h_sdt` float NOT NULL DEFAULT 1,
  `impact_sdt` float NOT NULL DEFAULT 1,
  `physical_sdt` smallint(5) NOT NULL DEFAULT 0, -- Global, generic and uncapped damage-type SDT
  `ranged_sdt` smallint(5) NOT NULL DEFAULT 0,
  `magical_sdt` smallint(5) NOT NULL DEFAULT 0,
  `breath_sdt` smallint(5) NOT NULL DEFAULT 0,
  `fire_res_rank` smallint(3) NOT NULL DEFAULT 0, -- Elemental Resistance Ranks (Used for Magic evasion)
  `ice_res_rank` smallint(3) NOT NULL DEFAULT 0,
  `wind_res_rank` smallint(3) NOT NULL DEFAULT 0,
  `earth_res_rank` smallint(3) NOT NULL DEFAULT 0,
  `lightning_res_rank` smallint(3) NOT NULL DEFAULT 0,
  `water_res_rank` smallint(3) NOT NULL DEFAULT 0,
  `light_res_rank` smallint(3) NOT NULL DEFAULT 0,
  `dark_res_rank` smallint(3) NOT NULL DEFAULT 0,
  PRIMARY KEY (`resist_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 AVG_ROW_LENGTH=128;
/*!40101 SET character_set_client = @saved_cs_client */;
INSERT INTO `mob_resistances` VALUES (1,'DEFAULT',0,0,0,0,10000,10000,10000,10000,11,11,11,11,11,11,11,11);
INSERT INTO `mob_resistances` VALUES (2,'Ark Angel - HM (ZM14)',1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (3,'Ark Angel - HM (HTB)',1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (4,'Ark Angel - HM (Escha)',1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (5,'Ark Angel - TT (ZM14)',1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (6,'Ark Angel - TT (HTB)',1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (7,'Ark Angel - TT (Escha)',1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (8,'Ark Angel - MR (ZM14)',1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (9,'Ark Angel - MR (HTB)',1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (10,'Ark Angel - MR (Escha)',1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (11,'Ark Angel - EV (ZM14)',1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (12,'Ark Angel - EV (HTB)',1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (13,'Ark Angel - EV (Escha)',1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (14,'Ark Angel - GK (ZM14)',1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (15,'Ark Angel - GK (HTB)',1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (16,'Ark Angel - GK (Escha)',1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (17,'Avatar - Carbuncle (Pet/Trial)',1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (18,'Avatar - Carbuncle (HTB)',1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (19,'Avatar - Ifrit (Pet/Trial)',1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (20,'Avatar - Ifrit (HTB)',1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (21,'Avatar - Shiva (Pet/Trial)',1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (22,'Avatar - Shiva (HTB)',1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (23,'Avatar - Garuda (Pet/Trial)',1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (24,'Avatar - Garuda (HTB)',1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (25,'Avatar - Titan (Pet/Trial)',1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (26,'Avatar - Titan (HTB)',1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (27,'Avatar - Ramuh (Pet/Trial)',1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (28,'Avatar - Ramuh (HTB)',1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (29,'Avatar - Leviathan (Pet/Trial)',1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (30,'Avatar - Leviathan (HTBl)',1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (31,'Avatar - Fenrir (Pet/Trial)',1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (32,'Avatar - Fenrir (HTB)',1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (33,'Avatar - Diabolos (Pet/CoP)',1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (34,'Avatar - Diabolos (HTB)',1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (35,'Avatar - Alexander (Pet/ToAU)',1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (36,'Avatar - Alexander (HTB)',1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (37,'Avatar - Odin (Pet/ToAU)',1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (38,'Avatar - Odin (HTB)',1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (39,'Avatar - Cait Sith (Pet)',1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (40,'Avatar - Cait Sith (HTB)',1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (41,'Avatar - Siren (Pet/RoV)',1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (42,'Avatar - Bahamut (CoP)',1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (43,'Adamantoise - Regular',1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (44,'Adamantoise - Mossy Shell (HNM)',1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (45,'Adamantoise - Genbu (Sky)',1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (46,'Behemoth - Regular',1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (47,'Behemoth - King Behemoth (HNM)',1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (48,'Behemoth - Elasmoth',1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (49,'Behemoth - Skormoth',1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_resistances` VALUES (50,'NEXT',1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0);
