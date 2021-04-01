-- MySQL dump 10.13  Distrib 5.6.17, for Win64 (x86_64)
--
-- Host: localhost    Database: xidb
-- ------------------------------------------------------
-- Server version	5.6.21-log

--
-- Table structure for table `char_spells`
--

DROP TABLE IF EXISTS `char_spells`;
CREATE TABLE `char_spells` (
  `charid` int(10) unsigned NOT NULL,
  `spellid` smallint(5) unsigned NOT NULL,
  INDEX `char_spells_charid_index` (`charid`),
  INDEX `char_spells_spellid_index` (`spellid`),
  UNIQUE KEY `idx_char_spells_spellid_charid` (`spellid`,`charid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

