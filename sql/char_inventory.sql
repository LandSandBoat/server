SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `char_inventory`
-- ----------------------------
DROP TABLE IF EXISTS `char_inventory`;
CREATE TABLE `char_inventory` (
  `charid` int(10) unsigned NOT NULL,
  `location` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `slot` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `itemId` smallint(5) unsigned NOT NULL DEFAULT '65535',
  `quantity` int(10) unsigned NOT NULL DEFAULT '0',
  `bazaar` int(8) unsigned NOT NULL DEFAULT '0',
  `signature` varchar(20) NOT NULL DEFAULT '',
  `extra` blob(24) DEFAULT NULL,
  PRIMARY KEY (`charid`,`location`,`slot`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AVG_ROW_LENGTH=28;
