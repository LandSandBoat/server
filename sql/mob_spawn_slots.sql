--
-- Table structure for table `mob_spawn_slots`
--

/* mob spawn slots */
DROP TABLE IF EXISTS `mob_spawn_slots`;
CREATE TABLE `mob_spawn_slots` (
  `spawnslotid` int(10) unsigned NOT NULL,
  `zoneid` smallint(3) unsigned NOT NULL DEFAULT 0,
  `chance` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`spawnslotid`, `zoneid`)
) ENGINE=Aria TRANSACTIONAL=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `mob_spawn_slots` WRITE;

-- Carpenter's Landing (Zone 2)
INSERT INTO `mob_spawn_slots` VALUES (1,2,100);
INSERT INTO `mob_spawn_slots` VALUES (2,2,100);
INSERT INTO `mob_spawn_slots` VALUES (3,2,100);

UNLOCK TABLES;
