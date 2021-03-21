-- MySQL dump 10.13  Distrib 5.6.17, for Win64 (x86_64)
--
-- Host: localhost    Database: dspdb
-- ------------------------------------------------------
-- Server version	5.6.21-log

--
-- Table structure for table `char_job_points`
--

DROP TABLE IF EXISTS `char_job_points`;
CREATE TABLE `char_job_points` (
  `charid` int(10) unsigned NOT NULL,
  `jobid` tinyint(2) unsigned NOT NULL,
  `capacity_points` smallint(5) unsigned NOT NULL DEFAULT '0',
  `job_points` smallint(3) unsigned NOT NULL DEFAULT '0',
  `job_points_spent` smallint(4) unsigned NOT NULL DEFAULT '0',
  `jptype0` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `jptype1` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `jptype2` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `jptype3` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `jptype4` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `jptype5` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `jptype6` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `jptype7` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `jptype8` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `jptype9` tinyint(2) unsigned NOT NULL DEFAULT '0',
  INDEX `char_job_points_charid_index` (`charid`),
  INDEX `char_job_points_charid_jobid_index` (`charid`, `jobid`),
  UNIQUE KEY `idx_char_job_points_charid_jobid` (`charid`,`jobid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dump completed on 2019-09-03 20:24:32
