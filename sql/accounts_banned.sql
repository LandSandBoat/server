-- phpMyAdmin SQL Dump
-- version 3.3.8
-- http://www.phpmyadmin.net
--
-- Serveur: localhost
-- Généré le : Ven 24 Juin 2011 à 07:58
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
-- Structure de la table `accounts_banned`
--

DROP TABLE IF EXISTS `accounts_banned`;
CREATE TABLE IF NOT EXISTS `accounts_banned` (
  `accid` int(10) unsigned NOT NULL DEFAULT '0',
  `timebann` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `timeunbann` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `banncomment` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`accid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;