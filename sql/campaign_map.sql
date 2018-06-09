-- MySQL dump 10.16  Distrib 10.2.8-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: dspdb
-- ------------------------------------------------------
-- Server version	10.2.8-MariaDB

--
-- Table structure for table `campaign_map`
--

DROP TABLE IF EXISTS `campaign_map`;
CREATE TABLE `campaign_map` (
  `id` tinyint(2) unsigned NOT NULL,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `campaign_map`
--

INSERT INTO `campaign_map` VALUES (0,0,2,0,0,0,0,0,0,0,0,0);
INSERT INTO `campaign_map` VALUES (1,0,8,0,0,0,0,0,0,0,0,0);
INSERT INTO `campaign_map` VALUES (2,0,8,0,0,0,0,0,0,0,0,0);
INSERT INTO `campaign_map` VALUES (3,0,8,0,0,0,0,0,0,0,0,0);
INSERT INTO `campaign_map` VALUES (4,0,8,0,0,0,0,0,0,0,0,0);
INSERT INTO `campaign_map` VALUES (5,0,8,0,0,0,0,0,0,0,0,0);
INSERT INTO `campaign_map` VALUES (6,0,8,0,0,0,0,0,0,0,0,0);
INSERT INTO `campaign_map` VALUES (7,0,4,0,0,0,0,0,0,0,0,0);
INSERT INTO `campaign_map` VALUES (8,0,8,0,0,0,0,0,0,0,0,0);
INSERT INTO `campaign_map` VALUES (9,0,8,0,0,0,0,0,0,0,0,0);
INSERT INTO `campaign_map` VALUES (10,0,8,0,0,0,0,0,0,0,0,0);
INSERT INTO `campaign_map` VALUES (11,0,8,0,0,0,0,0,0,0,0,0);
INSERT INTO `campaign_map` VALUES (12,0,8,0,0,0,0,0,0,0,0,0);
INSERT INTO `campaign_map` VALUES (13,0,8,0,0,0,0,0,0,0,0,0);
INSERT INTO `campaign_map` VALUES (14,0,6,0,0,0,0,0,0,0,0,0);
INSERT INTO `campaign_map` VALUES (15,0,8,0,0,0,0,0,0,0,0,0);
INSERT INTO `campaign_map` VALUES (16,0,8,0,0,0,0,0,0,0,0,0);
INSERT INTO `campaign_map` VALUES (17,0,8,0,0,0,0,0,0,0,0,0);
INSERT INTO `campaign_map` VALUES (18,0,8,0,0,0,0,0,0,0,0,0);
INSERT INTO `campaign_map` VALUES (19,0,8,0,0,0,0,0,0,0,0,0);
INSERT INTO `campaign_map` VALUES (20,0,8,0,0,0,0,0,0,0,0,0);
INSERT INTO `campaign_map` VALUES (21,0,8,0,0,0,0,0,0,0,0,0);
INSERT INTO `campaign_map` VALUES (22,0,8,0,0,0,0,0,0,0,0,0);
INSERT INTO `campaign_map` VALUES (23,0,8,0,0,0,0,0,0,0,0,0);
INSERT INTO `campaign_map` VALUES (24,0,8,0,0,0,0,0,0,0,0,0);
INSERT INTO `campaign_map` VALUES (25,0,8,0,0,0,0,0,0,0,0,0);

-- Dump completed on 2018-06-09 16:59:58
