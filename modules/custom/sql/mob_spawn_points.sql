-- --------------------------------------------------------
-- Horizon Mob Spawn Points
-- --------------------------------------------------------
-- Overrides all default spawn sets to match current era config
-- Includes calculated ZoneID and a spawnset controller for internal groupings
-- --------------------------------------------------------

DROP TABLE IF EXISTS `mob_spawn_points`;
CREATE TABLE IF NOT EXISTS `mob_spawn_points` (
  `mobid` int(10) NOT NULL,
  `zoneid` int(10) GENERATED ALWAYS AS ((`mobid` - 4096 * 4096) / 4096) VIRTUAL,
  `spawnset` tinyint(3) DEFAULT 0,
  `mobname` varchar(24) DEFAULT NULL,
  `polutils_name` varchar(50) DEFAULT NULL,
  `groupid` int(10) unsigned NOT NULL DEFAULT 0,
  `pos_x` float(7,3) NOT NULL DEFAULT 0.000,
  `pos_y` float(7,3) NOT NULL DEFAULT 0.000,
  `pos_z` float(7,3) NOT NULL DEFAULT 0.000,
  `pos_rot` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`mobid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 AVG_ROW_LENGTH=33;
