
SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
-- ----------------------------
-- Table structure for char_style
-- ----------------------------
DROP TABLE IF EXISTS `char_style`;
CREATE TABLE IF NOT EXISTS `char_style` (
  `charid` int(10) unsigned NOT NULL,
  `head` smallint(5) unsigned NOT NULL DEFAULT '0',
  `body` smallint(5) unsigned NOT NULL DEFAULT '0',
  `hands` smallint(5) unsigned NOT NULL DEFAULT '0',
  `legs` smallint(5) unsigned NOT NULL DEFAULT '0',
  `feet` smallint(5) unsigned NOT NULL DEFAULT '0',
  `main` smallint(5) unsigned NOT NULL DEFAULT '0',
  `sub` smallint(5) unsigned NOT NULL DEFAULT '0',
  `ranged` smallint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`charid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci AVG_ROW_LENGTH=20;
