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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
