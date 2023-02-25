--
-- Table structure for table `char_exemplar_points`
--

DROP TABLE IF EXISTS `char_exemplar_points`;
CREATE TABLE `char_exemplar_points` (
  `charid` int(10) unsigned NOT NULL,
  `war` int(10) unsigned NOT NULL DEFAULT '1',
  `mnk` int(10) unsigned NOT NULL DEFAULT '1',
  `whm` int(10) unsigned NOT NULL DEFAULT '1',
  `blm` int(10) unsigned NOT NULL DEFAULT '1',
  `rdm` int(10) unsigned NOT NULL DEFAULT '1',
  `thf` int(10) unsigned NOT NULL DEFAULT '1',
  `pld` int(10) unsigned NOT NULL DEFAULT '0',
  `drk` int(10) unsigned NOT NULL DEFAULT '0',
  `bst` int(10) unsigned NOT NULL DEFAULT '0',
  `brd` int(10) unsigned NOT NULL DEFAULT '0',
  `rng` int(10) unsigned NOT NULL DEFAULT '0',
  `sam` int(10) unsigned NOT NULL DEFAULT '0',
  `nin` int(10) unsigned NOT NULL DEFAULT '0',
  `drg` int(10) unsigned NOT NULL DEFAULT '0',
  `smn` int(10) unsigned NOT NULL DEFAULT '0',
  `blu` int(10) unsigned NOT NULL DEFAULT '0',
  `cor` int(10) unsigned NOT NULL DEFAULT '0',
  `pup` int(10) unsigned NOT NULL DEFAULT '0',
  `dnc` int(10) unsigned NOT NULL DEFAULT '0',
  `sch` int(10) unsigned NOT NULL DEFAULT '0',
  `geo` int(10) unsigned NOT NULL DEFAULT '0',
  `run` int(10) unsigned NOT NULL DEFAULT '0',
  INDEX `idx_char_exemplar_points_char_id` (`charid`),
  UNIQUE KEY `idx_char_exemplar_points_pk` (`charid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
