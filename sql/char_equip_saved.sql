SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
-- ----------------------------
-- Table structure for char_equip_saved
-- ----------------------------
DROP TABLE IF EXISTS `char_equip_saved`;
CREATE TABLE IF NOT EXISTS `char_equip_saved` (
    `charid` int(10) unsigned NOT NULL,
    `jobid` tinyint(2) unsigned NOT NULL,
    `main` smallint(5) unsigned NOT NULL DEFAULT '0',
    `sub` smallint(5) unsigned NOT NULL DEFAULT '0',
    `ranged` smallint(5) unsigned NOT NULL DEFAULT '0',
    `ammo` smallint(5) unsigned NOT NULL DEFAULT '0',
    `head` smallint(5) unsigned NOT NULL DEFAULT '0',
    `body` smallint(5) unsigned NOT NULL DEFAULT '0',
    `hands` smallint(5) unsigned NOT NULL DEFAULT '0',
    `legs` smallint(5) unsigned NOT NULL DEFAULT '0',
    `feet` smallint(5) unsigned NOT NULL DEFAULT '0',
    `neck` smallint(5) unsigned NOT NULL DEFAULT '0',
    `waist` smallint(5) unsigned NOT NULL DEFAULT '0',
    `ear1` smallint(5) unsigned NOT NULL DEFAULT '0',
    `ear2` smallint(5) unsigned NOT NULL DEFAULT '0',
    `ring1` smallint(5) unsigned NOT NULL DEFAULT '0',
    `ring2` smallint(5) unsigned NOT NULL DEFAULT '0',
    `back` smallint(5) unsigned NOT NULL DEFAULT '0',
    PRIMARY KEY (`charid`, `jobid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AVG_ROW_LENGTH=20;
