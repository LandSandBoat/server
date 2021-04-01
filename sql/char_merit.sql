-- MySQL dump 10.13  Distrib 5.6.17, for Win64 (x86_64)
--
-- Host: localhost    Database: xidb
-- ------------------------------------------------------
-- Server version	5.6.21-log

--
-- Table structure for table `char_merit`
--

DROP TABLE IF EXISTS `char_merit`;
CREATE TABLE `char_merit` (
  `charid` int(10) unsigned NOT NULL,
  `meritid` smallint(5) unsigned NOT NULL,
  `upgrades` smallint(5) unsigned NOT NULL,
  INDEX `char_merits_charid_index` (`charid`),
  UNIQUE KEY `idx_char_merit_meritid_charid` (`meritid`,`charid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dump completed on 2015-08-06 22:37:32
