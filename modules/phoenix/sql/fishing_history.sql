--
-- Fishing History Module
--
-- Table structure for table `char_fishing_history`
-- One row per fish or item landed, written by the fishing_history cpp module
-- Note: This table preserves existing data during database updates.
--       The table structure will only be created if it doesn't exist.
--

CREATE TABLE IF NOT EXISTS `char_fishing_history` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `charid` int(10) unsigned NOT NULL,
  `itemid` smallint(5) unsigned NOT NULL,
  `count` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `zoneid` smallint(5) unsigned NOT NULL,
  `caught_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `charid_caught_at` (`charid`,`caught_at`),
  KEY `caught_at` (`caught_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Table structure for table `char_fishing_records`
-- Lifetime totals per angler, never pruned
-- longest_ilms and heaviest_ponzes come from big fish only, 0 until one is landed
--

CREATE TABLE IF NOT EXISTS `char_fishing_records` (
  `charid` int(10) unsigned NOT NULL,
  `lines_cast` int(10) unsigned NOT NULL DEFAULT 0,
  `longest_ilms` smallint(5) unsigned NOT NULL DEFAULT 0,
  `longest_itemid` smallint(5) unsigned NOT NULL DEFAULT 0,
  `heaviest_ponzes` smallint(5) unsigned NOT NULL DEFAULT 0,
  `heaviest_itemid` smallint(5) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`charid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

