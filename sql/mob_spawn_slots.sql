
DROP TABLE IF EXISTS `mob_spawn_slots`;
CREATE TABLE IF NOT EXISTS `mob_spawn_slots` (
    `zoneid`        SMALLINT(3) NOT NULL DEFAULT 0,
    `spawnslotid`    TINYINT(3)  NOT NULL DEFAULT 0,
    `chance`        TINYINT(4)  DEFAULT '0',
    PRIMARY KEY (`zoneid`, `spawnslotid`) USING BTREE
)
ENGINE=Aria TRANSACTIONAL=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `mob_spawn_slots` WRITE;

-- Ghelsba Outpost (Zone 140)
INSERT INTO `mob_spawn_slots` VALUES (140,1,0);
INSERT INTO `mob_spawn_slots` VALUES (140,2,0);
INSERT INTO `mob_spawn_slots` VALUES (140,3,0);
INSERT INTO `mob_spawn_slots` VALUES (140,4,0);
INSERT INTO `mob_spawn_slots` VALUES (140,5,0);
INSERT INTO `mob_spawn_slots` VALUES (140,6,0);
INSERT INTO `mob_spawn_slots` VALUES (140,7,0);
INSERT INTO `mob_spawn_slots` VALUES (140,8,0);
INSERT INTO `mob_spawn_slots` VALUES (140,9,0);
INSERT INTO `mob_spawn_slots` VALUES (140,10,0);
INSERT INTO `mob_spawn_slots` VALUES (140,11,0);
INSERT INTO `mob_spawn_slots` VALUES (140,12,0);
INSERT INTO `mob_spawn_slots` VALUES (140,13,0);
INSERT INTO `mob_spawn_slots` VALUES (140,14,0);
INSERT INTO `mob_spawn_slots` VALUES (140,15,0);
INSERT INTO `mob_spawn_slots` VALUES (140,16,0);
INSERT INTO `mob_spawn_slots` VALUES (140,17,0);
INSERT INTO `mob_spawn_slots` VALUES (140,18,0);
INSERT INTO `mob_spawn_slots` VALUES (140,19,0);
INSERT INTO `mob_spawn_slots` VALUES (140,20,0);
INSERT INTO `mob_spawn_slots` VALUES (140,21,0);
INSERT INTO `mob_spawn_slots` VALUES (140,22,0);
INSERT INTO `mob_spawn_slots` VALUES (140,23,0);
INSERT INTO `mob_spawn_slots` VALUES (140,24,0);
INSERT INTO `mob_spawn_slots` VALUES (140,25,0);
INSERT INTO `mob_spawn_slots` VALUES (140,26,0);
INSERT INTO `mob_spawn_slots` VALUES (140,27,0);
INSERT INTO `mob_spawn_slots` VALUES (140,28,0);
INSERT INTO `mob_spawn_slots` VALUES (140,29,0);
INSERT INTO `mob_spawn_slots` VALUES (140,30,0);
INSERT INTO `mob_spawn_slots` VALUES (140,31,0);
INSERT INTO `mob_spawn_slots` VALUES (140,32,0);
INSERT INTO `mob_spawn_slots` VALUES (140,33,0);
INSERT INTO `mob_spawn_slots` VALUES (140,34,0);
INSERT INTO `mob_spawn_slots` VALUES (140,35,0);
INSERT INTO `mob_spawn_slots` VALUES (140,36,0);
INSERT INTO `mob_spawn_slots` VALUES (140,37,0);
INSERT INTO `mob_spawn_slots` VALUES (140,38,0);
INSERT INTO `mob_spawn_slots` VALUES (140,39,0);
INSERT INTO `mob_spawn_slots` VALUES (140,40,0);
INSERT INTO `mob_spawn_slots` VALUES (140,41,0);
INSERT INTO `mob_spawn_slots` VALUES (140,42,0);
INSERT INTO `mob_spawn_slots` VALUES (140,43,0);
INSERT INTO `mob_spawn_slots` VALUES (140,44,0);
INSERT INTO `mob_spawn_slots` VALUES (140,45,0);
INSERT INTO `mob_spawn_slots` VALUES (140,46,0);
INSERT INTO `mob_spawn_slots` VALUES (140,47,0);
INSERT INTO `mob_spawn_slots` VALUES (140,48,0);
INSERT INTO `mob_spawn_slots` VALUES (140,49,0);
INSERT INTO `mob_spawn_slots` VALUES (140,50,0);
INSERT INTO `mob_spawn_slots` VALUES (140,51,0);
INSERT INTO `mob_spawn_slots` VALUES (140,52,0);
INSERT INTO `mob_spawn_slots` VALUES (140,53,0);
INSERT INTO `mob_spawn_slots` VALUES (140,54,0);
INSERT INTO `mob_spawn_slots` VALUES (140,55,0);
INSERT INTO `mob_spawn_slots` VALUES (140,56,0);
INSERT INTO `mob_spawn_slots` VALUES (140,57,0);
INSERT INTO `mob_spawn_slots` VALUES (140,58,0);
INSERT INTO `mob_spawn_slots` VALUES (140,59,0);
INSERT INTO `mob_spawn_slots` VALUES (140,60,0);
INSERT INTO `mob_spawn_slots` VALUES (140,61,0);
INSERT INTO `mob_spawn_slots` VALUES (140,62,0);
-- 
-- Fort Ghelsba (Zone 141)
-- INSERT INTO `mob_spawn_slots` VALUES (141,1,1);
-- INSERT INTO `mob_spawn_slots` VALUES (141,2,1);
-- INSERT INTO `mob_spawn_slots` VALUES (141,3,1);
-- INSERT INTO `mob_spawn_slots` VALUES (141,4,1);
-- INSERT INTO `mob_spawn_slots` VALUES (141,5,2);
-- INSERT INTO `mob_spawn_slots` VALUES (141,6,2);
-- INSERT INTO `mob_spawn_slots` VALUES (141,7,1);
-- INSERT INTO `mob_spawn_slots` VALUES (141,8,1);
-- INSERT INTO `mob_spawn_slots` VALUES (141,9,1);
-- INSERT INTO `mob_spawn_slots` VALUES (141,10,1);
-- INSERT INTO `mob_spawn_slots` VALUES (141,11,1);
-- INSERT INTO `mob_spawn_slots` VALUES (141,12,1);
-- INSERT INTO `mob_spawn_slots` VALUES (141,13,1);
-- INSERT INTO `mob_spawn_slots` VALUES (141,14,1);
-- INSERT INTO `mob_spawn_slots` VALUES (141,15,1);
-- INSERT INTO `mob_spawn_slots` VALUES (141,16,1);
-- INSERT INTO `mob_spawn_slots` VALUES (141,17,1);
-- INSERT INTO `mob_spawn_slots` VALUES (141,18,1);
-- INSERT INTO `mob_spawn_slots` VALUES (141,19,1);
-- INSERT INTO `mob_spawn_slots` VALUES (141,20,1);
-- INSERT INTO `mob_spawn_slots` VALUES (141,21,1);
-- INSERT INTO `mob_spawn_slots` VALUES (141,22,1);
-- INSERT INTO `mob_spawn_slots` VALUES (141,23,1);
-- INSERT INTO `mob_spawn_slots` VALUES (141,24,1);
-- INSERT INTO `mob_spawn_slots` VALUES (141,25,1);
-- INSERT INTO `mob_spawn_slots` VALUES (141,26,1);
-- INSERT INTO `mob_spawn_slots` VALUES (141,27,1);
-- INSERT INTO `mob_spawn_slots` VALUES (141,28,1);
-- INSERT INTO `mob_spawn_slots` VALUES (141,29,1);
-- INSERT INTO `mob_spawn_slots` VALUES (141,30,1);
-- INSERT INTO `mob_spawn_slots` VALUES (141,31,1);
-- INSERT INTO `mob_spawn_slots` VALUES (141,32,1);
-- INSERT INTO `mob_spawn_slots` VALUES (141,33,1);
-- INSERT INTO `mob_spawn_slots` VALUES (141,34,1);
-- INSERT INTO `mob_spawn_slots` VALUES (141,35,1);
-- INSERT INTO `mob_spawn_slots` VALUES (141,36,1);
-- INSERT INTO `mob_spawn_slots` VALUES (141,37,1);
-- INSERT INTO `mob_spawn_slots` VALUES (141,38,1);
-- INSERT INTO `mob_spawn_slots` VALUES (141,39,1);
-- INSERT INTO `mob_spawn_slots` VALUES (141,40,1);
-- INSERT INTO `mob_spawn_slots` VALUES (141,41,1);
-- INSERT INTO `mob_spawn_slots` VALUES (141,42,1);
-- INSERT INTO `mob_spawn_slots` VALUES (141,43,1);
-- INSERT INTO `mob_spawn_slots` VALUES (141,44,1);
-- INSERT INTO `mob_spawn_slots` VALUES (141,45,1);
-- INSERT INTO `mob_spawn_slots` VALUES (141,46,1);
-- INSERT INTO `mob_spawn_slots` VALUES (141,47,1);
-- INSERT INTO `mob_spawn_slots` VALUES (141,48,1);
-- INSERT INTO `mob_spawn_slots` VALUES (141,49,1);
-- INSERT INTO `mob_spawn_slots` VALUES (141,50,1);
-- INSERT INTO `mob_spawn_slots` VALUES (141,51,1);
-- INSERT INTO `mob_spawn_slots` VALUES (141,52,1);
-- INSERT INTO `mob_spawn_slots` VALUES (141,53,1);
-- INSERT INTO `mob_spawn_slots` VALUES (141,54,1);
-- INSERT INTO `mob_spawn_slots` VALUES (141,55,1);
-- INSERT INTO `mob_spawn_slots` VALUES (141,56,1);
-- INSERT INTO `mob_spawn_slots` VALUES (141,57,1);
-- INSERT INTO `mob_spawn_slots` VALUES (141,58,1);
-- INSERT INTO `mob_spawn_slots` VALUES (141,59,1);
-- INSERT INTO `mob_spawn_slots` VALUES (141,60,1);
-- INSERT INTO `mob_spawn_slots` VALUES (141,61,1);
-- INSERT INTO `mob_spawn_slots` VALUES (141,62,1);

-- Monastic Cavern
INSERT INTO `mob_spawn_slots` VALUES (150, 1, 0);
INSERT INTO `mob_spawn_slots` VALUES (150, 2, 0);

-- Korroloka Tunnel
INSERT INTO `mob_spawn_slots` VALUES (173, 1, 0);
INSERT INTO `mob_spawn_slots` VALUES (173, 2, 0);
INSERT INTO `mob_spawn_slots` VALUES (173, 3, 0);
INSERT INTO `mob_spawn_slots` VALUES (173, 4, 0);

UNLOCK TABLES;
