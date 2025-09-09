
DROP TABLE IF EXISTS `mob_spawn_sets`;
CREATE TABLE IF NOT EXISTS `mob_spawn_sets` (
    `zoneid`        SMALLINT(3) NOT NULL DEFAULT 0,
    `spawnsetid`    TINYINT(3)  NOT NULL DEFAULT 0,
    `maxspawns`     TINYINT(4)  NOT NULL DEFAULT 0,
    PRIMARY KEY (`zoneid`, `spawnsetid`) USING BTREE
)
ENGINE=Aria TRANSACTIONAL=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- AlTaieu
-- INSERT INTO `mob_spawn_sets` VALUES (33, 1, 7);
-- INSERT INTO `mob_spawn_sets` VALUES (33, 2, 1);
-- INSERT INTO `mob_spawn_sets` VALUES (33, 3, 3);
-- INSERT INTO `mob_spawn_sets` VALUES (33, 4, 7);
-- INSERT INTO `mob_spawn_sets` VALUES (33, 5, 3);
-- INSERT INTO `mob_spawn_sets` VALUES (33, 6, 4);
-- INSERT INTO `mob_spawn_sets` VALUES (33, 7, 9);
-- INSERT INTO `mob_spawn_sets` VALUES (33, 8, 3);
-- INSERT INTO `mob_spawn_sets` VALUES (33, 9, 2);
-- INSERT INTO `mob_spawn_sets` VALUES (33, 10, 3);
-- INSERT INTO `mob_spawn_sets` VALUES (33, 11, 2);
-- INSERT INTO `mob_spawn_sets` VALUES (33, 12, 1);
-- INSERT INTO `mob_spawn_sets` VALUES (33, 13, 1);

INSERT INTO `mob_spawn_sets` VALUES (173, 1, 10);
