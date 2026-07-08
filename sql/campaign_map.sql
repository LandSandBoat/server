-- MySQL dump 10.16  Distrib 10.2.8-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: dspdb
-- ------------------------------------------------------
-- Server version    10.2.8-MariaDB

--
-- Table structure for table `campaign_map`
--

DROP TABLE IF EXISTS `campaign_map`;
CREATE TABLE `campaign_map` (
  `id` tinyint(2) unsigned NOT NULL,
  `zoneid` smallint(3) unsigned NOT NULL DEFAULT 0,
  `isbattle` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `nation` tinyint(2) unsigned NOT NULL DEFAULT 8,
  `heroism` tinyint(2) unsigned NOT NULL DEFAULT 0,
  `influence_sandoria` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `influence_bastok` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `influence_windurst` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `influence_beastman` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `current_fortifications` smallint(4) unsigned NOT NULL DEFAULT 0,
  `current_resources` smallint(4) unsigned NOT NULL DEFAULT 0,
  `max_fortifications` smallint(4) unsigned NOT NULL DEFAULT 0,
  `max_resources` smallint(4) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `campaign_map`
--

INSERT INTO `campaign_map` VALUES (0,80,0,2,0,0,0,0,0,0,0,0,0);
INSERT INTO `campaign_map` VALUES (1,81,0,8,0,0,0,0,0,0,0,0,0);
INSERT INTO `campaign_map` VALUES (2,82,0,8,0,0,0,0,0,0,0,0,0);
INSERT INTO `campaign_map` VALUES (3,83,0,8,0,0,0,0,0,0,0,0,0);
INSERT INTO `campaign_map` VALUES (4,84,0,8,0,0,0,0,0,0,0,0,0);
INSERT INTO `campaign_map` VALUES (5,85,0,8,0,0,0,0,0,0,0,0,0);
INSERT INTO `campaign_map` VALUES (6,175,0,8,0,0,0,0,0,0,0,0,0);
INSERT INTO `campaign_map` VALUES (7,87,0,4,0,0,0,0,0,0,0,0,0);
INSERT INTO `campaign_map` VALUES (8,88,0,8,0,0,0,0,0,0,0,0,0);
INSERT INTO `campaign_map` VALUES (9,89,0,8,0,0,0,0,0,0,0,0,0);
INSERT INTO `campaign_map` VALUES (10,90,0,8,0,0,0,0,0,0,0,0,0);
INSERT INTO `campaign_map` VALUES (11,91,0,8,0,0,0,0,0,0,0,0,0);
INSERT INTO `campaign_map` VALUES (12,92,0,8,0,0,0,0,0,0,0,0,0);
INSERT INTO `campaign_map` VALUES (13,171,0,8,0,0,0,0,0,0,0,0,0);
INSERT INTO `campaign_map` VALUES (14,94,0,6,0,0,0,0,0,0,0,0,0);
INSERT INTO `campaign_map` VALUES (15,95,0,8,0,0,0,0,0,0,0,0,0);
INSERT INTO `campaign_map` VALUES (16,96,0,8,0,0,0,0,0,0,0,0,0);
INSERT INTO `campaign_map` VALUES (17,97,0,8,0,0,0,0,0,0,0,0,0);
INSERT INTO `campaign_map` VALUES (18,98,0,8,0,0,0,0,0,0,0,0,0);
INSERT INTO `campaign_map` VALUES (19,99,0,8,0,0,0,0,0,0,0,0,0);
INSERT INTO `campaign_map` VALUES (20,164,0,8,0,0,0,0,0,0,0,0,0);
INSERT INTO `campaign_map` VALUES (21,136,0,8,0,0,0,0,0,0,0,0,0);
INSERT INTO `campaign_map` VALUES (22,137,0,8,0,0,0,0,0,0,0,0,0);
INSERT INTO `campaign_map` VALUES (23,138,0,8,0,0,0,0,0,0,0,0,0);
INSERT INTO `campaign_map` VALUES (24,155,0,8,0,0,0,0,0,0,0,0,0);
INSERT INTO `campaign_map` VALUES (25,156,0,8,0,0,0,0,0,0,0,0,0);

-- Dump completed on 2018-06-09 16:59:58
