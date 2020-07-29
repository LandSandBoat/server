-- MySQL dump 10.13  Distrib 5.6.15, for Win64 (x86_64)
--
-- Host: localhost    Database: tpzdb
-- ------------------------------------------------------
-- Server version   5.6.15

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
  `instanceid` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `instance_name` varchar(35) NOT NULL DEFAULT '',
  `entrance_zone` tinyint(3) unsigned NOT NULL DEFAULT '0',
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instance_list`
--

LOCK TABLES `instance_list` WRITE;
/*!40000 ALTER TABLE `instance_list` DISABLE KEYS */;
INSERT INTO `instance_list` VALUES (0,'TEST',0,0,0.000,0.000,0.000,0,-1,-1,-1,-1);
INSERT INTO `instance_list` VALUES (1,'leujaoam_cleansing',79,30,280.000,-7.500,35.000,195,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (2,'orichalcum_survey',79,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (3,'escort_professor_chanoix',79,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (4,'shanarha_grass_conservation',79,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (5,'counting_sheep',79,15,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (6,'supplies_recovery',79,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (7,'azure_experiments',79,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (8,'imperial_code',79,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (9,'red_versus_blue',79,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (10,'bloody_rondo',79,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (11,'imperial_agent_rescue',52,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
INSERT INTO `instance_list` VALUES (12,'preemptive_strike',52,30,-60.35,-5.0,27.67,46,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (13,'sagelord_elimination',52,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (14,'breaking_morale',52,15,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (15,'the_double_agent',52,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (16,'imperial_treasure_retrieval',52,15,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (17,'blitzkrieg',52,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (18,'marids_in_the_mist',52,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (19,'azure_ailments',52,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (20,'the_susanoo_shuffle',52,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
INSERT INTO `instance_list` VALUES (21,'excavation_duty',61,30,124.999,-39.309,19.999,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (22,'lebros_supplies',61,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
INSERT INTO `instance_list` VALUES (23,'troll_fugitives',61,30,-459.912,-9.860,342.319,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (24,'evade_and_escape',61,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (25,'siegemaster_assassination',61,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (26,'apkallu_breeding',61,15,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (27,'wamoura_farm_raid',61,30,540.977,-39.976,220.919,128,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (28,'egg_conservation',61,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (29,'operation:black_pearl',61,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (30,'better_than_one',61,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (31,'seagull_grounded',79,30,-350,-15.245,380,0,-1,-1,-1,-1);
INSERT INTO `instance_list` VALUES (32,'requiem',79,30,-458.409,-10.000,-320.966,90,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (33,'saving_private_ryaaf',79,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (34,'shooting_down_the_baron',79,15,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (35,'building_bridges',79,15,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (36,'stop_the_bloodshed',79,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (37,'defuse_the_threat',79,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (38,'operation:snake_eyes',79,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (39,'wake_the_puppet',79,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (40,'the_price_is_right',79,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
INSERT INTO `instance_list` VALUES (41,'golden_salvage',54,30,386.000,-12.000,17.000,46,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (42,'lamia_no_13',54,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
INSERT INTO `instance_list` VALUES (43,'extermination',54,30,298.099,-3.943,135.234,149,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (44,'demolition_duty',54,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (45,'searat_salvation',54,15,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (46,'apkallu_seizure',54,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (47,'lost_and_found',54,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (48,'deserter',54,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (49,'desperately_seeking_cephalopods',54,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (50,'bellerophons_bliss',54,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (51,'nyzul_isle_investigation',72,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (52,'nyzul_isle_uncharted_survey',72,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
INSERT INTO `instance_list` VALUES (53,'the_black_coffin',54,30,0,-22,24,64,-1,-1,-1,-1);
INSERT INTO `instance_list` VALUES (54,'against_all_odds',54,30,-9.000,-22.000,17.000,252,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (55,'scouting_the_ashu_talif',54,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (56,'royal_painter_escort',54,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (57,'targeting_the_captain',54,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
INSERT INTO `instance_list` VALUES (58,'path_of_darkness',72,30,500,0,-572,192,143,143,143,143);
INSERT INTO `instance_list` VALUES (59,'nashmeiras_plea',72,45,-444,-4,420,127,143,143,143,143);
-- INSERT INTO `instance_list` VALUES (60,'forging_a_new_myth',72,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (61,'waking_the_colossus',72,30,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (62,'zhayolm_remnants',72,100,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (64,'zhayolm_remnants_ii',72,100,0.000,0.000,0.000,0,-1,-1,-1,-1);
INSERT INTO `instance_list` VALUES (65,'arrapago_remnants',72,100,340.000,0.000,-246.000,63,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (67,'arrapago_remnants_ii',72,100,340.000,0.000,-246.000,63,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (68,'bhaflau_remnants',72,100,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (70,'bhaflau_remnants_ii',72,100,0.000,0.000,0.000,0,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (71,'silver_sea_remnants',72,100,340.000,12.000,-165.500,63,-1,-1,-1,-1);
-- INSERT INTO `instance_list` VALUES (73,'silver_sea_remnants_ii',72,100,340.000,12.000,-165.500,63,-1,-1,-1,-1);
INSERT INTO `instance_list` VALUES (79,'shades_of_vengeance',79,30,127,-15,-303,0,-1,-1,-1,-1);
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

-- Dump completed on 2014-05-28 15:42:27
