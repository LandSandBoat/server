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
-- Table structure for table `instance_list`
--

DROP TABLE IF EXISTS `instance_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instance_list` (
  `instanceid` smallint(3) unsigned NOT NULL DEFAULT '0',
  `instance_name` varchar(35) NOT NULL DEFAULT '',
  `instance_zone` smallint(3) unsigned NOT NULL DEFAULT '0',
  `entrance_zone` smallint(3) unsigned NOT NULL DEFAULT '0',
  `time_limit` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `start_x` float(7,3) NOT NULL DEFAULT '0.000',
  `start_y` float(7,3) NOT NULL DEFAULT '0.000',
  `start_z` float(7,3) NOT NULL DEFAULT '0.000',
  `start_rot` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `music_day` smallint(3) NOT NULL DEFAULT '-1',
  `music_night` smallint(3) NOT NULL DEFAULT '-1',
  `battlesolo` smallint(3) NOT NULL DEFAULT '-1',
  `battlemulti` smallint(3) NOT NULL DEFAULT '-1',
  PRIMARY KEY (`instanceid`)
) ENGINE=Aria TRANSACTIONAL=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instance_list`
--

LOCK TABLES `instance_list` WRITE;
/*!40000 ALTER TABLE `instance_list` DISABLE KEYS */;

INSERT INTO `instance_list` VALUES (0,'TEST',0,0,0,0.000,0.000,0.000,0,-1,-1,-1,-1);

-- NOTE: instanceid is made up of: base(zoneID * 100) + offset. The offset is arbitrary.
-- NOTE: Since there is a growing number of Ambuscade entries, they start at 30000
-- NOTE: The order of instances in each zone should be as follows:
--       - Missions (by expansion and id)
--       - Quests (ordered by expansion and id)
--       - Battle content (ordered by expansion and/or release date)

-- ILRUSI_ATOLL (zoneID: 55, starting id: 5500)
INSERT INTO `instance_list` VALUES (5500,'golden_salvage',55,54,30,386.000,-12.000,17.000,46,-1,-1,-1,-1);
INSERT INTO `instance_list` VALUES (5501,'lamia_no_13',55,54,30,155.000,-7.000,-175.000,47,-1,-1,-1,-1);
INSERT INTO `instance_list` VALUES (5502,'extermination',55,54,30,298.099,-3.943,135.234,149,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (5503,'demolition_duty',55,54,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (5504,'searat_salvation',55,54,15,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (5505,'apkallu_seizure',55,54,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (5506,'lost_and_found',55,54,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (5507,'deserter',55,54,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (5508,'desperately_seeking_cephalopods',55,54,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (5509,'bellerophons_bliss',55,54,30,0.000,0.000,0.000,0,-1,-1,-1,-1);

-- PERIQIA (zoneID: 56, starting id: 5600)
INSERT INTO `instance_list` VALUES (5600,'shades_of_vengeance',56,79,30,127.000,-15.000,-303.000,0,-1,-1,-1,-1);
INSERT INTO `instance_list` VALUES (5601,'seagull_grounded',56,79,30,-350.000,-15.245,380.000,0,-1,-1,-1,-1);
INSERT INTO `instance_list` VALUES (5602,'requiem',56,79,30,-470.000,-9.964,-325.000,190,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (5603,'saving_private_ryaaf',56,79,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (5604,'shooting_down_the_baron',56,79,15,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (5605,'building_bridges',56,79,15,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (5606,'stop_the_bloodshed',56,79,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (5607,'defuse_the_threat',56,79,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (5608,'operation:snake_eyes',56,79,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (5609,'wake_the_puppet',56,79,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (5610,'the_price_is_right',56,79,30,0.000,0.000,0.000,0,-1,-1,-1,-1);

-- THE_ASHU_TALIF (zoneID: 60, starting id: 6000)
INSERT INTO `instance_list` VALUES (6000,'the_black_coffin',60,54,30,0.000,-22.000,24.000,64,-1,-1,-1,-1);
INSERT INTO `instance_list` VALUES (6001,'against_all_odds',60,54,30,-9.000,-22.000,17.000,252,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (6002,'scouting_the_ashu_talif',60,54,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (6003,'royal_painter_escort',60,54,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (6004,'targeting_the_captain',60,54,30,0.000,0.000,0.000,0,-1,-1,-1,-1);

-- LEBROS_CAVERN (zoneID: 63, starting id: 6300)
INSERT INTO `instance_list` VALUES (6300,'excavation_duty',63,61,30,124.999,-39.309,19.999,0,-1,-1,-1,-1);
INSERT INTO `instance_list` VALUES (6301,'lebros_supplies',63,61,30,-333.000,-9.921,-259.999,255,-1,-1,-1,-1);
INSERT INTO `instance_list` VALUES (6302,'troll_fugitives',63,61,30,-459.912,-9.860,342.319,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (6303,'evade_and_escape',63,61,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (6304,'siegemaster_assassination',63,61,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (6305,'apkallu_breeding',63,61,15,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (6306,'wamoura_farm_raid',63,61,30,540.977,-39.976,220.919,128,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (6307,'egg_conservation',63,61,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (6308,'operation:black_pearl',63,61,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (6309,'better_than_one',63,61,30,0.000,0.000,0.000,0,-1,-1,-1,-1);

-- MAMOOL_JA_TRAINING_GROUNDS (zoneID: 66, starting id: 6600)
INSERT INTO `instance_list` VALUES (6600,'imperial_agent_rescue',66,52,30,-20.000,2.276,-405.000,63,-1,-1,-1,-1);
INSERT INTO `instance_list` VALUES (6601,'preemptive_strike',66,52,30,-60.350,-5.000,27.670,46,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (6602,'sagelord_elimination',66,52,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (6603,'breaking_morale',66,52,15,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (6604,'the_double_agent',66,52,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (6605,'imperial_treasure_retrieval',66,52,15,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (6606,'blitzkrieg',66,52,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (6607,'marids_in_the_mist',66,52,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (6608,'azure_ailments',66,52,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (6609,'the_susanoo_shuffle',66,52,30,0.000,0.000,0.000,0,-1,-1,-1,-1);

-- LEUJAOAM_SANCTUM (zoneID: 69, starting id: 6900)
INSERT INTO `instance_list` VALUES (6900,'leujaoam_cleansing',69,79,30,280.000,-7.500,35.000,195,-1,-1,-1,-1);
INSERT INTO `instance_list` VALUES (6901,'orichalcum_survey',69,79,30,-432.000,-27.627,169.000,131,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (6902,'escort_professor_chanoix',69,79,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (6903,'shanarha_grass_conservation',69,79,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (6904,'counting_sheep',69,79,15,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (6905,'supplies_recovery',69,79,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (6906,'azure_experiments',69,79,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (6907,'imperial_code',69,79,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (6908,'red_versus_blue',69,79,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (6909,'bloody_rondo',69,79,30,0.000,0.000,0.000,0,-1,-1,-1,-1);

-- ZHAYOLM_REMNANTS (zoneID: 73, starting id: 7300)
INSERT INTO `instance_list` VALUES (7300,'zhayolm_remnants',73,72,100,340.000,0.000,-592.000,192,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (7301,'zhayolm_remnants_ii',73,72,100,0.000,0.000,0.000,0,-1,-1,-1,-1);

-- ARRAPAGO_REMNANTS (zoneID: 74, starting id: 7400)
INSERT INTO `instance_list` VALUES (7400,'arrapago_remnants',74,72,100,340.000,0.000,-246.000,63,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (7401,'arrapago_remnants_ii',74,72,100,340.000,0.000,-246.000,63,-1,-1,-1,-1);

-- BHAFLAU_REMNANTS (zoneID: 75, starting id: 7500)
INSERT INTO `instance_list` VALUES (7500,'bhaflau_remnants',75,72,100,340.000,19.000,-552.000,191,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (7501,'bhaflau_remnants_ii',75,72,100,0.000,0.000,0.000,0,-1,-1,-1,-1);

-- SILVER_SEA_REMNANTS (zoneID: 76, starting id: 7600)
INSERT INTO `instance_list` VALUES (7600,'silver_sea_remnants',76,72,100,340.000,12.000,-165.500,63,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (7601,'silver_sea_remnants_ii',76,72,100,340.000,12.000,-165.500,63,-1,-1,-1,-1);

-- NYZUL_ISLE (zoneID: 77, starting id: 7700)
INSERT INTO `instance_list` VALUES (7700,'path_of_darkness',77,72,30,500.000,0.000,-572.000,192,143,143,143,143);
INSERT INTO `instance_list` VALUES (7701,'nashmeiras_plea',77,72,45,-444.000,-4.000,420.000,127,143,143,143,143);
-- INSERT INTO `instance_list` VALUES (7702,'waking_the_colossus',77,72,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (7703,'forging_a_new_myth',77,72,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
INSERT INTO `instance_list` VALUES (7704,'nyzul_isle_investigation',77,72,30,-20.000,-4.000,-20.000,196,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (7705,'nyzul_isle_uncharted_survey',77,72,30,0.000,0.000,0.000,0,-1,-1,-1,-1);

-- EVERBLOOM_HOLLOW (zoneID: 86, starting id: 8600)
-- INSERT INTO `instance_list` VALUES (8600,'honor_under_fire',86,83,0,382,0,-191,74,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (8601,'what_price_loyalty',86,83,0,382,0,-191,74,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (8602,'doomvoid',86,84,0,382,0,-191,74,-1,-1,-1,-1);

-- RUHOTZ_SILVERMINES (zoneID: 93, starting id: 9300)
INSERT INTO `instance_list` VALUES (9300,'light_in_the_darkness',93,90,0,-22.500,1.600,40.000,192,-1,-1,-1,-1);
INSERT INTO `instance_list` VALUES (9301,'fire_in_the_hole',93,88,0,156.000,0.000,-60.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (9301,'doomvoid',93,84,0,382,0,-191,74,-1,-1,-1,-1);

-- GHOYUS_REVERIE (zoneID: 129, starting id: 12900)
INSERT INTO `instance_list` VALUES (12900,'doomvoid',129,84,0,382.000,0.000,-191.000,74,-1,-1,-1,-1);

-- MAQUETTE_ABDHALJS_LEGION_A (zoneID: 183, starting id: 18300)

-- RALA_WATERWAYS_U (zoneID: 259, starting id: 25900)
INSERT INTO `instance_list` VALUES (25900,'behind_the_sluices',259,258,0,-153.000,-5.700,-380.000,0,-1,-1,-1,-1);

-- YORCIA_WEALD_U (zoneID: 264, starting id: 26400)

-- CIRDAS_CAVERNS_U (zoneID: 271, starting id: 27100)

-- OUTER_RAKAZNAR_U (zoneID: 275, starting id: 27500)

-- MAQUETTE_ABDHALJS_LEGION_B (zoneID: 287, starting id: 28700)

-- DYNAMIS_SAN_DORIA_D (zoneID: 294, starting id: 29400)

-- DYNAMIS_BASTOK_D (zoneID: 295, starting id: 29500)

-- DYNAMIS_WINDURST_D (zoneID: 296, starting id: 29600)

-- DYNAMIS_JEUNO_D (zoneID: 297, starting id: 29700)

-- MAQUETTE_ABDHALJS_LEGION_B (zoneID: 287, starting id: 30000)
INSERT INTO `instance_list` VALUES (30000,'ambuscade',287,249,30,137.000,12.500,-137.000,32,-1,-1,-1,-1);

/*!40000 ALTER TABLE `instance_list` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
