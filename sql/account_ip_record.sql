-- MySQL dump 10.13  Distrib 5.6.17, for Win64 (x86_64)
--
-- Host: localhost    Database: xidb
-- ------------------------------------------------------
-- Server version	5.6.21-log

--
-- Table structure for table `account_ip_record`
--

DROP TABLE IF EXISTS `account_ip_record`;
CREATE TABLE `account_ip_record` (
  `login_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `accid` int(10) NOT NULL,
  `charid` int(10) NOT NULL,
  `client_ip` tinytext NOT NULL,
  PRIMARY KEY (`login_time`,`accid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dump completed on 2016-04-03 15:35:56
