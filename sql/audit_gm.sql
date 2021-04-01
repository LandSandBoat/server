-- MySQL dump 10.13  Distrib 5.7.12, for Win64 (x86_64)
--
-- Host: localhost    Database: xidb
-- ------------------------------------------------------
-- Server version	5.5.5-10.0.20-MariaDB

--
-- Table structure for table `audit_gm`
--

DROP TABLE IF EXISTS `audit_gm`;
CREATE TABLE `audit_gm` (
  `date_time` datetime NOT NULL,
  `gm_name` varchar(16) NOT NULL,
  `command` varchar(40) NOT NULL,
  `full_string` varchar(200) NOT NULL,
  PRIMARY KEY (`date_time`,`gm_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dump completed on 2016-10-04  4:18:42
