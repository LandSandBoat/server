
DROP TABLE IF EXISTS `mob_spawn_sets`;
CREATE TABLE IF NOT EXISTS `mob_spawn_sets` (
    `zoneid`        SMALLINT(3) NOT NULL DEFAULT 0,
    `spawnsetid`    TINYINT(3)  NOT NULL DEFAULT 0,
    `maxspawns`     TINYINT(4)  NOT NULL DEFAULT 0,
    PRIMARY KEY (`zoneid`, `spawnsetid`) USING BTREE
)
ENGINE=Aria TRANSACTIONAL=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Ghelsba Outpost
INSERT INTO `mob_spawn_sets` VALUES (140,1,2);
INSERT INTO `mob_spawn_sets` VALUES (140,2,2);
INSERT INTO `mob_spawn_sets` VALUES (140,3,1);
INSERT INTO `mob_spawn_sets` VALUES (140,4,2);
INSERT INTO `mob_spawn_sets` VALUES (140,5,1);
INSERT INTO `mob_spawn_sets` VALUES (140,6,1);
INSERT INTO `mob_spawn_sets` VALUES (140,7,1);
INSERT INTO `mob_spawn_sets` VALUES (140,8,1);
INSERT INTO `mob_spawn_sets` VALUES (140,9,1);
INSERT INTO `mob_spawn_sets` VALUES (140,10,2);
INSERT INTO `mob_spawn_sets` VALUES (140,11,2);
INSERT INTO `mob_spawn_sets` VALUES (140,12,1);
INSERT INTO `mob_spawn_sets` VALUES (140,13,3);
INSERT INTO `mob_spawn_sets` VALUES (140,14,3);
INSERT INTO `mob_spawn_sets` VALUES (140,15,1);
INSERT INTO `mob_spawn_sets` VALUES (140,16,1);
INSERT INTO `mob_spawn_sets` VALUES (140,17,1);
INSERT INTO `mob_spawn_sets` VALUES (140,18,1);
INSERT INTO `mob_spawn_sets` VALUES (140,19,1);
INSERT INTO `mob_spawn_sets` VALUES (140,20,2);
INSERT INTO `mob_spawn_sets` VALUES (140,21,1);
INSERT INTO `mob_spawn_sets` VALUES (140,22,1);
INSERT INTO `mob_spawn_sets` VALUES (140,23,1);
INSERT INTO `mob_spawn_sets` VALUES (140,24,1);
INSERT INTO `mob_spawn_sets` VALUES (140,25,1);
INSERT INTO `mob_spawn_sets` VALUES (140,26,1);
INSERT INTO `mob_spawn_sets` VALUES (140,27,1);
INSERT INTO `mob_spawn_sets` VALUES (140,28,1);
INSERT INTO `mob_spawn_sets` VALUES (140,29,1);
INSERT INTO `mob_spawn_sets` VALUES (140,30,1);
INSERT INTO `mob_spawn_sets` VALUES (140,31,1);
INSERT INTO `mob_spawn_sets` VALUES (140,32,1);
INSERT INTO `mob_spawn_sets` VALUES (140,33,1);
INSERT INTO `mob_spawn_sets` VALUES (140,34,1);
INSERT INTO `mob_spawn_sets` VALUES (140,35,1);
INSERT INTO `mob_spawn_sets` VALUES (140,36,1);
INSERT INTO `mob_spawn_sets` VALUES (140,37,1);
INSERT INTO `mob_spawn_sets` VALUES (140,38,1);
INSERT INTO `mob_spawn_sets` VALUES (140,39,1);
INSERT INTO `mob_spawn_sets` VALUES (140,40,1);
INSERT INTO `mob_spawn_sets` VALUES (140,41,1);
INSERT INTO `mob_spawn_sets` VALUES (140,42,1);
INSERT INTO `mob_spawn_sets` VALUES (140,43,1);
INSERT INTO `mob_spawn_sets` VALUES (140,44,1);
INSERT INTO `mob_spawn_sets` VALUES (140,45,1);
INSERT INTO `mob_spawn_sets` VALUES (140,46,1);
INSERT INTO `mob_spawn_sets` VALUES (140,47,1);
INSERT INTO `mob_spawn_sets` VALUES (140,48,1);
INSERT INTO `mob_spawn_sets` VALUES (140,49,1);
INSERT INTO `mob_spawn_sets` VALUES (140,50,1);
INSERT INTO `mob_spawn_sets` VALUES (140,51,1);
INSERT INTO `mob_spawn_sets` VALUES (140,52,1);
INSERT INTO `mob_spawn_sets` VALUES (140,53,1);
INSERT INTO `mob_spawn_sets` VALUES (140,54,1);
INSERT INTO `mob_spawn_sets` VALUES (140,55,1);
INSERT INTO `mob_spawn_sets` VALUES (140,56,1);
INSERT INTO `mob_spawn_sets` VALUES (140,57,1);
INSERT INTO `mob_spawn_sets` VALUES (140,58,4);
INSERT INTO `mob_spawn_sets` VALUES (140,59,1);
INSERT INTO `mob_spawn_sets` VALUES (140,60,1);
INSERT INTO `mob_spawn_sets` VALUES (140,61,1);
INSERT INTO `mob_spawn_sets` VALUES (140,62,1);

-- Monastic Cavern
INSERT INTO `mob_spawn_sets` VALUES (150, 1, 1);
INSERT INTO `mob_spawn_sets` VALUES (150, 2, 1);
INSERT INTO `mob_spawn_sets` VALUES (150, 3, 2);
INSERT INTO `mob_spawn_sets` VALUES (150, 4, 2);
INSERT INTO `mob_spawn_sets` VALUES (150, 5, 2);
INSERT INTO `mob_spawn_sets` VALUES (150, 6, 2);
INSERT INTO `mob_spawn_sets` VALUES (150, 7, 2);
INSERT INTO `mob_spawn_sets` VALUES (150, 8, 1);
INSERT INTO `mob_spawn_sets` VALUES (150, 9, 1);
INSERT INTO `mob_spawn_sets` VALUES (150, 10, 2);
INSERT INTO `mob_spawn_sets` VALUES (150, 11, 2);
INSERT INTO `mob_spawn_sets` VALUES (150, 12, 1);
INSERT INTO `mob_spawn_sets` VALUES (150, 13, 1);
INSERT INTO `mob_spawn_sets` VALUES (150, 14, 1);
INSERT INTO `mob_spawn_sets` VALUES (150, 15, 1);
INSERT INTO `mob_spawn_sets` VALUES (150, 16, 1);
INSERT INTO `mob_spawn_sets` VALUES (150, 17, 1);
INSERT INTO `mob_spawn_sets` VALUES (150, 18, 1);
INSERT INTO `mob_spawn_sets` VALUES (150, 19, 1);
INSERT INTO `mob_spawn_sets` VALUES (150, 20, 1);
INSERT INTO `mob_spawn_sets` VALUES (150, 21, 3);
INSERT INTO `mob_spawn_sets` VALUES (150, 22, 2);
INSERT INTO `mob_spawn_sets` VALUES (150, 23, 2);
INSERT INTO `mob_spawn_sets` VALUES (150, 24, 1);
INSERT INTO `mob_spawn_sets` VALUES (150, 25, 1);
INSERT INTO `mob_spawn_sets` VALUES (150, 26, 1);
INSERT INTO `mob_spawn_sets` VALUES (150, 27, 1);
INSERT INTO `mob_spawn_sets` VALUES (150, 28, 1);
INSERT INTO `mob_spawn_sets` VALUES (150, 29, 1);
INSERT INTO `mob_spawn_sets` VALUES (150, 30, 1);
INSERT INTO `mob_spawn_sets` VALUES (150, 31, 1);
INSERT INTO `mob_spawn_sets` VALUES (150, 32, 1);
INSERT INTO `mob_spawn_sets` VALUES (150, 33, 1);
INSERT INTO `mob_spawn_sets` VALUES (150, 34, 2);
INSERT INTO `mob_spawn_sets` VALUES (150, 35, 2);
INSERT INTO `mob_spawn_sets` VALUES (150, 36, 2);
INSERT INTO `mob_spawn_sets` VALUES (150, 37, 1);
INSERT INTO `mob_spawn_sets` VALUES (150, 38, 3);
INSERT INTO `mob_spawn_sets` VALUES (150, 39, 1);
INSERT INTO `mob_spawn_sets` VALUES (150, 40, 1);
INSERT INTO `mob_spawn_sets` VALUES (150, 41, 1);

-- Korroloka Tunnel
INSERT INTO `mob_spawn_sets` VALUES (173, 1, 10);
