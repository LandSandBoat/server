-- phpMyAdmin SQL Dump
SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Structure de la table `delivery_box`
--

DROP TABLE IF EXISTS `delivery_box`;
CREATE TABLE IF NOT EXISTS `delivery_box` (
  `charid` int(10) unsigned NOT NULL,
  `charname` varchar(15) DEFAULT NULL,
  `box` tinyint(1) unsigned NOT NULL,
  `slot` smallint(3) unsigned NOT NULL DEFAULT '0',
  `itemid` smallint(5) unsigned NOT NULL,
  `itemsubid` smallint(5) unsigned NOT NULL DEFAULT '0',
  `quantity` int(10) unsigned NOT NULL,
  `extra` blob(24) DEFAULT NULL,
  `senderid` int(10) unsigned NOT NULL DEFAULT '0',
  `sender` varchar(15) DEFAULT NULL,
  `received` tinyint(1) NOT NULL DEFAULT 0,
  `sent` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`charid`,`box`,`slot`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
