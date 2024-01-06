DROP TABLE IF EXISTS `char_monstrosity`;
CREATE TABLE `char_monstrosity` (
    `charid` int(10) unsigned NOT NULL,
    `current_monstrosity_id` smallint(3) unsigned NOT NULL DEFAULT 0,
    `current_monstrosity_species` smallint(3) unsigned NOT NULL DEFAULT 0,
    `current_monstrosity_name_prefix_1` smallint(3) unsigned NOT NULL DEFAULT 0,
    `current_monstrosity_name_prefix_2` smallint(3) unsigned NOT NULL DEFAULT 0,
    `current_exp` int(3) unsigned NOT NULL DEFAULT 0,
    `equip` blob DEFAULT NULL,
    `levels` blob DEFAULT NULL,
    `instincts` blob DEFAULT NULL,
    `variants` blob DEFAULT NULL,
    `belligerency` tinyint(3) unsigned NOT NULL DEFAULT 0,
    `entry_x` float(7,3) NOT NULL DEFAULT '0.000',
    `entry_y` float(7,3) NOT NULL DEFAULT '0.000',
    `entry_z` float(7,3) NOT NULL DEFAULT '0.000',
    `entry_rot` tinyint(3) unsigned NOT NULL DEFAULT '0',
    `entry_zone_id` smallint(3) unsigned NOT NULL DEFAULT '0',
    `entry_mjob` tinyint(2) unsigned NOT NULL DEFAULT '0',
    `entry_sjob` tinyint(2) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`charid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
