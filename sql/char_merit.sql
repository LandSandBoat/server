--
-- Table structure for table `char_merit`
--

DROP TABLE IF EXISTS `char_merit`;
CREATE TABLE `char_merit` (
  `charid` int(10) unsigned NOT NULL,
  `meritid` smallint(5) unsigned NOT NULL,
  `upgrades` smallint(5) unsigned NOT NULL,
  INDEX `char_merits_charid_index` (`charid`),
  UNIQUE KEY `idx_char_merit_meritid_charid` (`meritid`,`charid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
