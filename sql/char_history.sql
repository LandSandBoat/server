--
-- Table structure for table `char_history`
--

DROP TABLE IF EXISTS `char_history`;
CREATE TABLE `char_history` (
  `charid` int(10) unsigned NOT NULL,
  `enemies_defeated` int(10) unsigned NOT NULL DEFAULT '0',
  `times_knocked_out` int(10) unsigned NOT NULL DEFAULT '0',
  `mh_entrances` int(10) unsigned NOT NULL DEFAULT '0',
  `joined_parties` int(10) unsigned NOT NULL DEFAULT '0',
  `joined_alliances` int(10) unsigned NOT NULL DEFAULT '0',
  `spells_cast` int(10) unsigned NOT NULL DEFAULT '0',
  `abilities_used` int(10) unsigned NOT NULL DEFAULT '0',
  `ws_used` int(10) unsigned NOT NULL DEFAULT '0',
  `items_used` int(10) unsigned NOT NULL DEFAULT '0',
  `chats_sent` int(10) unsigned NOT NULL DEFAULT '0',
  `npc_interactions` int(10) unsigned NOT NULL DEFAULT '0',
  `battles_fought` int(10) unsigned NOT NULL DEFAULT '0',
  `gm_calls` int(10) unsigned NOT NULL DEFAULT '0',
  `distance_travelled` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`charid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
