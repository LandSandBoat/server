-- phpMyAdmin SQL Dump
-- version 3.3.8
-- http://www.phpmyadmin.net
--
-- Serveur: localhost
-- Généré le : Dim 21 Octobre 2012 à 13:34
-- Version du serveur: 6.0.0
-- Version de PHP: 5.2.9-2

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données: `xidb`
--

-- --------------------------------------------------------

--
-- Structure de la table `char_storage`
--

DROP TABLE IF EXISTS `char_storage`;
CREATE TABLE IF NOT EXISTS `char_storage` (
  `charid` int(10) unsigned NOT NULL,
  `inventory` tinyint(2) unsigned NOT NULL DEFAULT '30',
  `safe` tinyint(2) unsigned NOT NULL DEFAULT '50',
  `locker` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `satchel` tinyint(2) unsigned NOT NULL DEFAULT '30',
  `sack` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `case` tinyint(2) unsigned NOT NULL DEFAULT '80',
  `wardrobe` tinyint(2) unsigned NOT NULL DEFAULT '80',
  `wardrobe2` tinyint(2) unsigned NOT NULL DEFAULT '80',
  `wardrobe3` tinyint(2) unsigned NOT NULL DEFAULT '80',
  `wardrobe4` tinyint(2) unsigned NOT NULL DEFAULT '80',

  PRIMARY KEY (`charid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
