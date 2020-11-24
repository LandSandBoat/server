/*
MySQL Data Transfer
Source Host: localhost
Source Database: tpzdb
Target Host: localhost
Target Database: tpzdb
Date: 2/11/2013 11:16:49 PM
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for chars
-- ----------------------------
DROP TABLE IF EXISTS `chars`;
CREATE TABLE `chars` (
  `charid` int(10) unsigned NOT NULL,
  `accid` int(10) unsigned NOT NULL,
  `charname` varchar(15) NOT NULL,
  `nation` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `pos_zone` smallint(3) unsigned NOT NULL,
  `pos_prevzone` smallint(3) unsigned NOT NULL DEFAULT '0',
  `pos_rot` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `pos_x` float(7,3) NOT NULL DEFAULT '0.000',
  `pos_y` float(7,3) NOT NULL DEFAULT '0.000',
  `pos_z` float(7,3) NOT NULL DEFAULT '0.000',
  `moghouse` int(10) unsigned NOT NULL DEFAULT '0',
  `boundary` smallint(5) unsigned NOT NULL DEFAULT '0',
  `home_zone` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `home_rot` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `home_x` float(7,3) NOT NULL DEFAULT '0.000',
  `home_y` float(7,3) NOT NULL DEFAULT '0.000',
  `home_z` float(7,3) NOT NULL DEFAULT '0.000',
  `missions` blob,
  `assault` blob,
  `campaign` blob,
  `eminence` blob,
  `quests` blob,
  `keyitems` blob,
  `set_blue_spells` blob,
  `abilities` blob,
  `weaponskills` blob,
  `titles` blob,
  `zones` blob,
  `playtime` int(10) unsigned NOT NULL DEFAULT '0',
  `unlocked_weapons` blob,
  `gmlevel` smallint(3) unsigned NOT NULL DEFAULT '0',
  `mentor` smallint(3) NOT NULL DEFAULT '0',
  `campaign_allegiance` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `isstylelocked` tinyint(1) NOT NULL DEFAULT '0',
  `nnameflags` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `moghancement` smallint(4) unsigned NOT NULL DEFAULT '0',
  `timecreated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lastupdate` timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`charid`),
  FULLTEXT KEY `charname` (`charname`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
