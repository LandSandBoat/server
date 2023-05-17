-- --------------------------------------------------------
-- Mob Spawn Sets
-- --------------------------------------------------------
-- This module is used to control spawn sets within a zone
-- Spawnsetid is defined in the mob_spawn_points table, and is unique per zone
-- --------------------------------------------------------

-- Add the spawn set table

DROP TABLE IF EXISTS `mob_spawn_sets`;
CREATE TABLE IF NOT EXISTS `mob_spawn_sets` (
    `zoneid`        SMALLINT(3) NOT NULL DEFAULT '0',
    `spawnsetid`    TINYINT(3)  NOT NULL DEFAULT '0',
    `maxspawns`     TINYINT(4)  NOT NULL DEFAULT '0',
    PRIMARY KEY (`zoneid`, `spawnsetid`) USING BTREE
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
;

-- AlTaieu
INSERT INTO `mob_spawn_sets` VALUES (33, 1, 7);
INSERT INTO `mob_spawn_sets` VALUES (33, 2, 1);
INSERT INTO `mob_spawn_sets` VALUES (33, 3, 3);
INSERT INTO `mob_spawn_sets` VALUES (33, 4, 7);
INSERT INTO `mob_spawn_sets` VALUES (33, 5, 3);
INSERT INTO `mob_spawn_sets` VALUES (33, 6, 4);
INSERT INTO `mob_spawn_sets` VALUES (33, 7, 9);
INSERT INTO `mob_spawn_sets` VALUES (33, 8, 3);
INSERT INTO `mob_spawn_sets` VALUES (33, 9, 2);
INSERT INTO `mob_spawn_sets` VALUES (33, 10, 3);
INSERT INTO `mob_spawn_sets` VALUES (33, 11, 2);
INSERT INTO `mob_spawn_sets` VALUES (33, 12, 1);
INSERT INTO `mob_spawn_sets` VALUES (33, 13, 1);

-- Attowha Chasm
INSERT INTO `mob_spawn_sets` VALUES (7, 1, 1);
INSERT INTO `mob_spawn_sets` VALUES (7, 2, 1);
INSERT INTO `mob_spawn_sets` VALUES (7, 3, 1);
INSERT INTO `mob_spawn_sets` VALUES (7, 4, 1);

-- Batallia Downs
INSERT INTO `mob_spawn_sets` VALUES (105, 1, 3);
INSERT INTO `mob_spawn_sets` VALUES (105, 2, 3);
INSERT INTO `mob_spawn_sets` VALUES (105, 3, 3);
INSERT INTO `mob_spawn_sets` VALUES (105, 4, 7);
INSERT INTO `mob_spawn_sets` VALUES (105, 5, 3);
INSERT INTO `mob_spawn_sets` VALUES (105, 6, 2);
INSERT INTO `mob_spawn_sets` VALUES (105, 7, 2);
INSERT INTO `mob_spawn_sets` VALUES (105, 8, 6);
INSERT INTO `mob_spawn_sets` VALUES (105, 9, 2);
INSERT INTO `mob_spawn_sets` VALUES (105, 10, 2);
INSERT INTO `mob_spawn_sets` VALUES (105, 11, 2);
INSERT INTO `mob_spawn_sets` VALUES (105, 12, 6);
INSERT INTO `mob_spawn_sets` VALUES (105, 13, 2);
INSERT INTO `mob_spawn_sets` VALUES (105, 14, 3);
INSERT INTO `mob_spawn_sets` VALUES (105, 15, 6);
INSERT INTO `mob_spawn_sets` VALUES (105, 16, 2);
INSERT INTO `mob_spawn_sets` VALUES (105, 17, 2);
INSERT INTO `mob_spawn_sets` VALUES (105, 18, 2);
INSERT INTO `mob_spawn_sets` VALUES (105, 19, 6);
INSERT INTO `mob_spawn_sets` VALUES (105, 20, 3);
INSERT INTO `mob_spawn_sets` VALUES (105, 21, 3);
INSERT INTO `mob_spawn_sets` VALUES (105, 22, 2);
INSERT INTO `mob_spawn_sets` VALUES (105, 23, 4);
INSERT INTO `mob_spawn_sets` VALUES (105, 24, 3);
INSERT INTO `mob_spawn_sets` VALUES (105, 25, 3);
INSERT INTO `mob_spawn_sets` VALUES (105, 26, 7);
INSERT INTO `mob_spawn_sets` VALUES (105, 27, 2);
INSERT INTO `mob_spawn_sets` VALUES (105, 28, 4);
INSERT INTO `mob_spawn_sets` VALUES (105, 29, 8);
INSERT INTO `mob_spawn_sets` VALUES (105, 30, 7);
INSERT INTO `mob_spawn_sets` VALUES (105, 31, 9);

-- Beadeaux
INSERT INTO `mob_spawn_sets` VALUES (147, 1, 1);
INSERT INTO `mob_spawn_sets` VALUES (147, 2, 1);
INSERT INTO `mob_spawn_sets` VALUES (147, 3, 1);
INSERT INTO `mob_spawn_sets` VALUES (147, 4, 1);
INSERT INTO `mob_spawn_sets` VALUES (147, 5, 1);
INSERT INTO `mob_spawn_sets` VALUES (147, 6, 1);
INSERT INTO `mob_spawn_sets` VALUES (147, 7, 2);
INSERT INTO `mob_spawn_sets` VALUES (147, 8, 2);
INSERT INTO `mob_spawn_sets` VALUES (147, 9, 1);
INSERT INTO `mob_spawn_sets` VALUES (147, 10, 1);
INSERT INTO `mob_spawn_sets` VALUES (147, 11, 1);
INSERT INTO `mob_spawn_sets` VALUES (147, 12, 2);
INSERT INTO `mob_spawn_sets` VALUES (147, 13, 2);
INSERT INTO `mob_spawn_sets` VALUES (147, 14, 2);
INSERT INTO `mob_spawn_sets` VALUES (147, 15, 2);
INSERT INTO `mob_spawn_sets` VALUES (147, 16, 2);
INSERT INTO `mob_spawn_sets` VALUES (147, 17, 2);
INSERT INTO `mob_spawn_sets` VALUES (147, 18, 3);
INSERT INTO `mob_spawn_sets` VALUES (147, 19, 3);
INSERT INTO `mob_spawn_sets` VALUES (147, 20, 2);
INSERT INTO `mob_spawn_sets` VALUES (147, 21, 2);
INSERT INTO `mob_spawn_sets` VALUES (147, 22, 2);
INSERT INTO `mob_spawn_sets` VALUES (147, 23, 2);
INSERT INTO `mob_spawn_sets` VALUES (147, 24, 2);
INSERT INTO `mob_spawn_sets` VALUES (147, 25, 2);
INSERT INTO `mob_spawn_sets` VALUES (147, 26, 2);
INSERT INTO `mob_spawn_sets` VALUES (147, 27, 2);
INSERT INTO `mob_spawn_sets` VALUES (147, 28, 2);

-- Beaucedine Glacier
INSERT INTO `mob_spawn_sets` VALUES (111, 1, 1);
INSERT INTO `mob_spawn_sets` VALUES (111, 2, 1);
INSERT INTO `mob_spawn_sets` VALUES (111, 3, 1);
INSERT INTO `mob_spawn_sets` VALUES (111, 4, 1);
INSERT INTO `mob_spawn_sets` VALUES (111, 5, 1);
INSERT INTO `mob_spawn_sets` VALUES (111, 6, 1);
INSERT INTO `mob_spawn_sets` VALUES (111, 7, 1);
INSERT INTO `mob_spawn_sets` VALUES (111, 8, 1);

-- Behemoths_Dominion (NONE)

-- Bibiki Bay
INSERT INTO `mob_spawn_sets` VALUES (4, 1, 5);
INSERT INTO `mob_spawn_sets` VALUES (4, 2, 1);
INSERT INTO `mob_spawn_sets` VALUES (4, 3, 2);
INSERT INTO `mob_spawn_sets` VALUES (4, 4, 2);
INSERT INTO `mob_spawn_sets` VALUES (4, 5, 2);
INSERT INTO `mob_spawn_sets` VALUES (4, 6, 1);
INSERT INTO `mob_spawn_sets` VALUES (4, 7, 1);

-- Buburimu_Peninsula
INSERT INTO `mob_spawn_sets` VALUES (118, 1, 3);
INSERT INTO `mob_spawn_sets` VALUES (118, 2, 3);
INSERT INTO `mob_spawn_sets` VALUES (118, 3, 2);
INSERT INTO `mob_spawn_sets` VALUES (118, 4, 3);
INSERT INTO `mob_spawn_sets` VALUES (118, 5, 2);
INSERT INTO `mob_spawn_sets` VALUES (118, 6, 3);
INSERT INTO `mob_spawn_sets` VALUES (118, 7, 3);
INSERT INTO `mob_spawn_sets` VALUES (118, 8, 3);
INSERT INTO `mob_spawn_sets` VALUES (118, 9, 3);
INSERT INTO `mob_spawn_sets` VALUES (118, 10, 6);
INSERT INTO `mob_spawn_sets` VALUES (118, 11, 6);
INSERT INTO `mob_spawn_sets` VALUES (118, 12, 6);
INSERT INTO `mob_spawn_sets` VALUES (118, 13, 3);
INSERT INTO `mob_spawn_sets` VALUES (118, 14, 3);
INSERT INTO `mob_spawn_sets` VALUES (118, 15, 3);
INSERT INTO `mob_spawn_sets` VALUES (118, 16, 3);
INSERT INTO `mob_spawn_sets` VALUES (118, 17, 3);
INSERT INTO `mob_spawn_sets` VALUES (118, 18, 3);
INSERT INTO `mob_spawn_sets` VALUES (118, 19, 3);
INSERT INTO `mob_spawn_sets` VALUES (118, 20, 3);
INSERT INTO `mob_spawn_sets` VALUES (118, 21, 8);

-- Cape Terrigan
INSERT INTO `mob_spawn_sets` VALUES (113, 1, 3);
INSERT INTO `mob_spawn_sets` VALUES (113, 2, 4);
INSERT INTO `mob_spawn_sets` VALUES (113, 3, 5);
INSERT INTO `mob_spawn_sets` VALUES (113, 4, 1);
INSERT INTO `mob_spawn_sets` VALUES (113, 5, 5);
INSERT INTO `mob_spawn_sets` VALUES (113, 6, 1);
INSERT INTO `mob_spawn_sets` VALUES (113, 7, 1);
INSERT INTO `mob_spawn_sets` VALUES (113, 8, 1);
INSERT INTO `mob_spawn_sets` VALUES (113, 9, 5);
INSERT INTO `mob_spawn_sets` VALUES (113, 10, 2);
INSERT INTO `mob_spawn_sets` VALUES (113, 11, 4);
INSERT INTO `mob_spawn_sets` VALUES (113, 12, 1);
INSERT INTO `mob_spawn_sets` VALUES (113, 13, 2);
INSERT INTO `mob_spawn_sets` VALUES (113, 14, 5);
INSERT INTO `mob_spawn_sets` VALUES (113, 15, 1);
INSERT INTO `mob_spawn_sets` VALUES (113, 16, 5);
INSERT INTO `mob_spawn_sets` VALUES (113, 17, 5);
INSERT INTO `mob_spawn_sets` VALUES (113, 18, 4);
INSERT INTO `mob_spawn_sets` VALUES (113, 19, 3);
INSERT INTO `mob_spawn_sets` VALUES (113, 20, 7);
INSERT INTO `mob_spawn_sets` VALUES (113, 21, 3);
INSERT INTO `mob_spawn_sets` VALUES (113, 22, 3);
INSERT INTO `mob_spawn_sets` VALUES (113, 23, 4);
INSERT INTO `mob_spawn_sets` VALUES (113, 24, 2);
INSERT INTO `mob_spawn_sets` VALUES (113, 25, 3);
INSERT INTO `mob_spawn_sets` VALUES (113, 26, 4);
INSERT INTO `mob_spawn_sets` VALUES (113, 27, 2);
INSERT INTO `mob_spawn_sets` VALUES (113, 28, 1);
INSERT INTO `mob_spawn_sets` VALUES (113, 29, 9);
INSERT INTO `mob_spawn_sets` VALUES (113, 30, 6);
INSERT INTO `mob_spawn_sets` VALUES (113, 31, 2);
INSERT INTO `mob_spawn_sets` VALUES (113, 32, 3);
INSERT INTO `mob_spawn_sets` VALUES (113, 33, 4);
INSERT INTO `mob_spawn_sets` VALUES (113, 34, 3);
INSERT INTO `mob_spawn_sets` VALUES (113, 35, 2);
INSERT INTO `mob_spawn_sets` VALUES (113, 36, 2);
INSERT INTO `mob_spawn_sets` VALUES (113, 37, 1);
INSERT INTO `mob_spawn_sets` VALUES (113, 38, 2);
INSERT INTO `mob_spawn_sets` VALUES (113, 39, 1);
INSERT INTO `mob_spawn_sets` VALUES (113, 40, 1);
INSERT INTO `mob_spawn_sets` VALUES (113, 41, 4);
INSERT INTO `mob_spawn_sets` VALUES (113, 42, 1);
INSERT INTO `mob_spawn_sets` VALUES (113, 43, 6);
INSERT INTO `mob_spawn_sets` VALUES (113, 44, 3);
INSERT INTO `mob_spawn_sets` VALUES (113, 45, 3);
INSERT INTO `mob_spawn_sets` VALUES (113, 46, 2);
INSERT INTO `mob_spawn_sets` VALUES (113, 47, 3);
INSERT INTO `mob_spawn_sets` VALUES (113, 48, 5);
INSERT INTO `mob_spawn_sets` VALUES (113, 49, 2);
INSERT INTO `mob_spawn_sets` VALUES (113, 50, 3);
INSERT INTO `mob_spawn_sets` VALUES (113, 51, 2);
INSERT INTO `mob_spawn_sets` VALUES (113, 52, 2);
INSERT INTO `mob_spawn_sets` VALUES (113, 53, 2);
INSERT INTO `mob_spawn_sets` VALUES (113, 54, 2);
INSERT INTO `mob_spawn_sets` VALUES (113, 55, 3);

-- Carpenters Landing
INSERT INTO `mob_spawn_sets` VALUES (2, 1, 1);
INSERT INTO `mob_spawn_sets` VALUES (2, 2, 2);
INSERT INTO `mob_spawn_sets` VALUES (2, 3, 2);
INSERT INTO `mob_spawn_sets` VALUES (2, 4, 1);
INSERT INTO `mob_spawn_sets` VALUES (2, 5, 2);
INSERT INTO `mob_spawn_sets` VALUES (2, 6, 2);

-- Castle Oztroja
INSERT INTO `mob_spawn_sets` VALUES (151, 1, 2);
INSERT INTO `mob_spawn_sets` VALUES (151, 2, 3);
INSERT INTO `mob_spawn_sets` VALUES (151, 3, 1);
INSERT INTO `mob_spawn_sets` VALUES (151, 4, 1);
INSERT INTO `mob_spawn_sets` VALUES (151, 5, 1);
INSERT INTO `mob_spawn_sets` VALUES (151, 6, 1);
INSERT INTO `mob_spawn_sets` VALUES (151, 7, 1);
INSERT INTO `mob_spawn_sets` VALUES (151, 8, 1);
INSERT INTO `mob_spawn_sets` VALUES (151, 9, 1);
INSERT INTO `mob_spawn_sets` VALUES (151, 10, 1);
INSERT INTO `mob_spawn_sets` VALUES (151, 11, 1);
INSERT INTO `mob_spawn_sets` VALUES (151, 12, 3);
INSERT INTO `mob_spawn_sets` VALUES (151, 13, 2);
INSERT INTO `mob_spawn_sets` VALUES (151, 14, 4);
INSERT INTO `mob_spawn_sets` VALUES (151, 15, 4);
INSERT INTO `mob_spawn_sets` VALUES (151, 16, 4);
INSERT INTO `mob_spawn_sets` VALUES (151, 17, 4);
INSERT INTO `mob_spawn_sets` VALUES (151, 18, 1);
INSERT INTO `mob_spawn_sets` VALUES (151, 19, 5);
INSERT INTO `mob_spawn_sets` VALUES (151, 20, 1);
INSERT INTO `mob_spawn_sets` VALUES (151, 21, 4);
INSERT INTO `mob_spawn_sets` VALUES (151, 22, 2);
INSERT INTO `mob_spawn_sets` VALUES (151, 23, 2);
INSERT INTO `mob_spawn_sets` VALUES (151, 24, 2);
INSERT INTO `mob_spawn_sets` VALUES (151, 25, 1);
INSERT INTO `mob_spawn_sets` VALUES (151, 26, 5);
INSERT INTO `mob_spawn_sets` VALUES (151, 27, 2);
INSERT INTO `mob_spawn_sets` VALUES (151, 28, 2);
INSERT INTO `mob_spawn_sets` VALUES (151, 29, 6);
INSERT INTO `mob_spawn_sets` VALUES (151, 30, 2);

-- Castle Zvahl Baileys
INSERT INTO `mob_spawn_sets` VALUES (161, 1, 2);
INSERT INTO `mob_spawn_sets` VALUES (161, 2, 3);
INSERT INTO `mob_spawn_sets` VALUES (161, 3, 2);
INSERT INTO `mob_spawn_sets` VALUES (161, 4, 2);
INSERT INTO `mob_spawn_sets` VALUES (161, 5, 2);
INSERT INTO `mob_spawn_sets` VALUES (161, 6, 2);
INSERT INTO `mob_spawn_sets` VALUES (161, 7, 2);
INSERT INTO `mob_spawn_sets` VALUES (161, 8, 2);
INSERT INTO `mob_spawn_sets` VALUES (161, 9, 4);
INSERT INTO `mob_spawn_sets` VALUES (161, 10, 4);
INSERT INTO `mob_spawn_sets` VALUES (161, 11, 4);
INSERT INTO `mob_spawn_sets` VALUES (161, 12, 4);

-- Castle Zvahl Keep
INSERT INTO `mob_spawn_sets` VALUES (162, 1, 1);
INSERT INTO `mob_spawn_sets` VALUES (162, 2, 1);
INSERT INTO `mob_spawn_sets` VALUES (162, 3, 1);
INSERT INTO `mob_spawn_sets` VALUES (162, 4, 1);
INSERT INTO `mob_spawn_sets` VALUES (162, 5, 1);
INSERT INTO `mob_spawn_sets` VALUES (162, 6, 1);
INSERT INTO `mob_spawn_sets` VALUES (162, 7, 1);
INSERT INTO `mob_spawn_sets` VALUES (162, 8, 1);
INSERT INTO `mob_spawn_sets` VALUES (162, 9, 1);
INSERT INTO `mob_spawn_sets` VALUES (162, 10, 1);
INSERT INTO `mob_spawn_sets` VALUES (162, 11, 1);
INSERT INTO `mob_spawn_sets` VALUES (162, 12, 1);
INSERT INTO `mob_spawn_sets` VALUES (162, 13, 1);
INSERT INTO `mob_spawn_sets` VALUES (162, 14, 1);
INSERT INTO `mob_spawn_sets` VALUES (162, 15, 2);
INSERT INTO `mob_spawn_sets` VALUES (162, 16, 1);
INSERT INTO `mob_spawn_sets` VALUES (162, 17, 4);
INSERT INTO `mob_spawn_sets` VALUES (162, 18, 1);
INSERT INTO `mob_spawn_sets` VALUES (162, 19, 1);
INSERT INTO `mob_spawn_sets` VALUES (162, 20, 1);
INSERT INTO `mob_spawn_sets` VALUES (162, 21, 1);

-- Davoi
INSERT INTO `mob_spawn_sets` VALUES (149, 1, 1);
INSERT INTO `mob_spawn_sets` VALUES (149, 2, 3);
INSERT INTO `mob_spawn_sets` VALUES (149, 3, 4);
INSERT INTO `mob_spawn_sets` VALUES (149, 4, 2);
INSERT INTO `mob_spawn_sets` VALUES (149, 5, 2);
INSERT INTO `mob_spawn_sets` VALUES (149, 6, 2);
INSERT INTO `mob_spawn_sets` VALUES (149, 7, 5);
INSERT INTO `mob_spawn_sets` VALUES (149, 8, 5);
INSERT INTO `mob_spawn_sets` VALUES (149, 9, 4);
INSERT INTO `mob_spawn_sets` VALUES (149, 10, 4);
INSERT INTO `mob_spawn_sets` VALUES (149, 11, 2);
INSERT INTO `mob_spawn_sets` VALUES (149, 12, 4);
INSERT INTO `mob_spawn_sets` VALUES (149, 13, 2);
INSERT INTO `mob_spawn_sets` VALUES (149, 14, 2);
INSERT INTO `mob_spawn_sets` VALUES (149, 15, 2);
INSERT INTO `mob_spawn_sets` VALUES (149, 16, 1);
INSERT INTO `mob_spawn_sets` VALUES (149, 17, 4);
INSERT INTO `mob_spawn_sets` VALUES (149, 18, 1);
INSERT INTO `mob_spawn_sets` VALUES (149, 19, 2);
INSERT INTO `mob_spawn_sets` VALUES (149, 20, 2);
INSERT INTO `mob_spawn_sets` VALUES (149, 21, 6);
INSERT INTO `mob_spawn_sets` VALUES (149, 22, 6);
INSERT INTO `mob_spawn_sets` VALUES (149, 23, 2);
INSERT INTO `mob_spawn_sets` VALUES (149, 24, 1);
INSERT INTO `mob_spawn_sets` VALUES (149, 25, 3);
INSERT INTO `mob_spawn_sets` VALUES (149, 26, 2);
INSERT INTO `mob_spawn_sets` VALUES (149, 27, 2);
INSERT INTO `mob_spawn_sets` VALUES (149, 28, 2);
INSERT INTO `mob_spawn_sets` VALUES (149, 29, 2);
INSERT INTO `mob_spawn_sets` VALUES (149, 30, 2);
INSERT INTO `mob_spawn_sets` VALUES (149, 31, 1);
INSERT INTO `mob_spawn_sets` VALUES (149, 32, 2);
INSERT INTO `mob_spawn_sets` VALUES (149, 33, 2);
INSERT INTO `mob_spawn_sets` VALUES (149, 34, 4);
INSERT INTO `mob_spawn_sets` VALUES (149, 35, 1);
INSERT INTO `mob_spawn_sets` VALUES (149, 36, 4);
INSERT INTO `mob_spawn_sets` VALUES (149, 37, 2);
INSERT INTO `mob_spawn_sets` VALUES (149, 38, 1);
INSERT INTO `mob_spawn_sets` VALUES (149, 39, 2);
INSERT INTO `mob_spawn_sets` VALUES (149, 40, 1);
INSERT INTO `mob_spawn_sets` VALUES (149, 41, 2);
INSERT INTO `mob_spawn_sets` VALUES (149, 42, 1);

-- Dragons Aery
INSERT INTO `mob_spawn_sets` VALUES (154, 1, 4);

-- Eastern Altepa Desert
INSERT INTO `mob_spawn_sets` VALUES (114, 1, 4);
INSERT INTO `mob_spawn_sets` VALUES (114, 2, 2);

-- East Ronfaure
INSERT INTO `mob_spawn_sets` VALUES (101, 1, 2);
INSERT INTO `mob_spawn_sets` VALUES (101, 2, 3);
INSERT INTO `mob_spawn_sets` VALUES (101, 3, 3);
INSERT INTO `mob_spawn_sets` VALUES (101, 4, 5);
INSERT INTO `mob_spawn_sets` VALUES (101, 5, 3);
INSERT INTO `mob_spawn_sets` VALUES (101, 6, 5);
INSERT INTO `mob_spawn_sets` VALUES (101, 7, 3);
INSERT INTO `mob_spawn_sets` VALUES (101, 8, 3);
INSERT INTO `mob_spawn_sets` VALUES (101, 9, 3);
INSERT INTO `mob_spawn_sets` VALUES (101, 10, 3);
INSERT INTO `mob_spawn_sets` VALUES (101, 11, 3);
INSERT INTO `mob_spawn_sets` VALUES (101, 12, 3);
INSERT INTO `mob_spawn_sets` VALUES (101, 13, 3);
INSERT INTO `mob_spawn_sets` VALUES (101, 14, 3);
INSERT INTO `mob_spawn_sets` VALUES (101, 15, 3);
INSERT INTO `mob_spawn_sets` VALUES (101, 16, 2);
INSERT INTO `mob_spawn_sets` VALUES (101, 17, 3);
INSERT INTO `mob_spawn_sets` VALUES (101, 18, 3);
INSERT INTO `mob_spawn_sets` VALUES (101, 19, 3);
INSERT INTO `mob_spawn_sets` VALUES (101, 20, 3);
INSERT INTO `mob_spawn_sets` VALUES (101, 21, 12);

-- East Sarutabaruta
INSERT INTO `mob_spawn_sets` VALUES (116, 1, 3);
INSERT INTO `mob_spawn_sets` VALUES (116, 2, 3);
INSERT INTO `mob_spawn_sets` VALUES (116, 3, 3);
INSERT INTO `mob_spawn_sets` VALUES (116, 4, 3);
INSERT INTO `mob_spawn_sets` VALUES (116, 5, 2);
INSERT INTO `mob_spawn_sets` VALUES (116, 6, 2);
INSERT INTO `mob_spawn_sets` VALUES (116, 7, 6);
INSERT INTO `mob_spawn_sets` VALUES (116, 8, 3);
INSERT INTO `mob_spawn_sets` VALUES (116, 9, 4);
INSERT INTO `mob_spawn_sets` VALUES (116, 10, 6);
INSERT INTO `mob_spawn_sets` VALUES (116, 11, 5);
INSERT INTO `mob_spawn_sets` VALUES (116, 12, 2);
INSERT INTO `mob_spawn_sets` VALUES (116, 13, 2);
INSERT INTO `mob_spawn_sets` VALUES (116, 14, 5);
INSERT INTO `mob_spawn_sets` VALUES (116, 15, 5);
INSERT INTO `mob_spawn_sets` VALUES (116, 16, 3);
INSERT INTO `mob_spawn_sets` VALUES (116, 17, 3);
INSERT INTO `mob_spawn_sets` VALUES (116, 18, 3);
INSERT INTO `mob_spawn_sets` VALUES (116, 19, 2);
INSERT INTO `mob_spawn_sets` VALUES (116, 20, 3);
INSERT INTO `mob_spawn_sets` VALUES (116, 21, 3);
INSERT INTO `mob_spawn_sets` VALUES (116, 22, 3);
INSERT INTO `mob_spawn_sets` VALUES (116, 23, 3);

-- Fort Ghelsba
INSERT INTO `mob_spawn_sets` VALUES (141, 1, 3);
INSERT INTO `mob_spawn_sets` VALUES (141, 2, 1);
INSERT INTO `mob_spawn_sets` VALUES (141, 3, 4);
INSERT INTO `mob_spawn_sets` VALUES (141, 4, 3);
INSERT INTO `mob_spawn_sets` VALUES (141, 5, 2);
INSERT INTO `mob_spawn_sets` VALUES (141, 6, 3);
INSERT INTO `mob_spawn_sets` VALUES (141, 7, 2);
INSERT INTO `mob_spawn_sets` VALUES (141, 8, 2);
INSERT INTO `mob_spawn_sets` VALUES (141, 9, 2);
INSERT INTO `mob_spawn_sets` VALUES (141, 10, 2);
INSERT INTO `mob_spawn_sets` VALUES (141, 11, 3);
INSERT INTO `mob_spawn_sets` VALUES (141, 12, 3);
INSERT INTO `mob_spawn_sets` VALUES (141, 13, 4);
INSERT INTO `mob_spawn_sets` VALUES (141, 14, 4);
INSERT INTO `mob_spawn_sets` VALUES (141, 15, 2);
INSERT INTO `mob_spawn_sets` VALUES (141, 16, 4);
INSERT INTO `mob_spawn_sets` VALUES (141, 17, 3);
INSERT INTO `mob_spawn_sets` VALUES (141, 18, 3);
INSERT INTO `mob_spawn_sets` VALUES (141, 19, 4);
INSERT INTO `mob_spawn_sets` VALUES (141, 20, 3);
INSERT INTO `mob_spawn_sets` VALUES (141, 21, 5);
INSERT INTO `mob_spawn_sets` VALUES (141, 22, 4);
INSERT INTO `mob_spawn_sets` VALUES (141, 23, 3);
INSERT INTO `mob_spawn_sets` VALUES (141, 24, 3);
INSERT INTO `mob_spawn_sets` VALUES (141, 25, 3);
INSERT INTO `mob_spawn_sets` VALUES (141, 26, 2);
INSERT INTO `mob_spawn_sets` VALUES (141, 27, 7);

-- Ghelsba Outpost
INSERT INTO `mob_spawn_sets` VALUES (140, 1, 3);
INSERT INTO `mob_spawn_sets` VALUES (140, 2, 2);
INSERT INTO `mob_spawn_sets` VALUES (140, 3, 1);
INSERT INTO `mob_spawn_sets` VALUES (140, 4, 5);
INSERT INTO `mob_spawn_sets` VALUES (140, 5, 5);
INSERT INTO `mob_spawn_sets` VALUES (140, 6, 5);
INSERT INTO `mob_spawn_sets` VALUES (140, 7, 1);
INSERT INTO `mob_spawn_sets` VALUES (140, 8, 3);
INSERT INTO `mob_spawn_sets` VALUES (140, 9, 3);
INSERT INTO `mob_spawn_sets` VALUES (140, 10, 1);
INSERT INTO `mob_spawn_sets` VALUES (140, 11, 2);
INSERT INTO `mob_spawn_sets` VALUES (140, 12, 1);
INSERT INTO `mob_spawn_sets` VALUES (140, 13, 4);
INSERT INTO `mob_spawn_sets` VALUES (140, 14, 1);
INSERT INTO `mob_spawn_sets` VALUES (140, 15, 1);
INSERT INTO `mob_spawn_sets` VALUES (140, 16, 3);
INSERT INTO `mob_spawn_sets` VALUES (140, 17, 3);
INSERT INTO `mob_spawn_sets` VALUES (140, 18, 3);
INSERT INTO `mob_spawn_sets` VALUES (140, 19, 1);
INSERT INTO `mob_spawn_sets` VALUES (140, 20, 3);
INSERT INTO `mob_spawn_sets` VALUES (140, 21, 3);
INSERT INTO `mob_spawn_sets` VALUES (140, 22, 3);
INSERT INTO `mob_spawn_sets` VALUES (140, 23, 3);
INSERT INTO `mob_spawn_sets` VALUES (140, 24, 3);
INSERT INTO `mob_spawn_sets` VALUES (140, 25, 3);
INSERT INTO `mob_spawn_sets` VALUES (140, 26, 3);
INSERT INTO `mob_spawn_sets` VALUES (140, 27, 3);
INSERT INTO `mob_spawn_sets` VALUES (140, 28, 3);
INSERT INTO `mob_spawn_sets` VALUES (140, 29, 2);
INSERT INTO `mob_spawn_sets` VALUES (140, 30, 2);
INSERT INTO `mob_spawn_sets` VALUES (140, 31, 4);

-- Giddeus
INSERT INTO `mob_spawn_sets` VALUES (145, 1, 2);
INSERT INTO `mob_spawn_sets` VALUES (145, 2, 2);
INSERT INTO `mob_spawn_sets` VALUES (145, 3, 2);
INSERT INTO `mob_spawn_sets` VALUES (145, 4, 2);
INSERT INTO `mob_spawn_sets` VALUES (145, 5, 2);
INSERT INTO `mob_spawn_sets` VALUES (145, 6, 2);
INSERT INTO `mob_spawn_sets` VALUES (145, 7, 2);
INSERT INTO `mob_spawn_sets` VALUES (145, 8, 2);
INSERT INTO `mob_spawn_sets` VALUES (145, 9, 2);
INSERT INTO `mob_spawn_sets` VALUES (145, 10, 2);
INSERT INTO `mob_spawn_sets` VALUES (145, 11, 1);
INSERT INTO `mob_spawn_sets` VALUES (145, 12, 1);
INSERT INTO `mob_spawn_sets` VALUES (145, 13, 1);
INSERT INTO `mob_spawn_sets` VALUES (145, 14, 2);
INSERT INTO `mob_spawn_sets` VALUES (145, 15, 1);
INSERT INTO `mob_spawn_sets` VALUES (145, 16, 1);
INSERT INTO `mob_spawn_sets` VALUES (145, 17, 1);
INSERT INTO `mob_spawn_sets` VALUES (145, 18, 3);
INSERT INTO `mob_spawn_sets` VALUES (145, 19, 2);
INSERT INTO `mob_spawn_sets` VALUES (145, 20, 1);
INSERT INTO `mob_spawn_sets` VALUES (145, 21, 1);
INSERT INTO `mob_spawn_sets` VALUES (145, 22, 2);
INSERT INTO `mob_spawn_sets` VALUES (145, 23, 1);
INSERT INTO `mob_spawn_sets` VALUES (145, 24, 1);
INSERT INTO `mob_spawn_sets` VALUES (145, 25, 2);
INSERT INTO `mob_spawn_sets` VALUES (145, 26, 2);
INSERT INTO `mob_spawn_sets` VALUES (145, 27, 1);
INSERT INTO `mob_spawn_sets` VALUES (145, 28, 1);
INSERT INTO `mob_spawn_sets` VALUES (145, 29, 2);
INSERT INTO `mob_spawn_sets` VALUES (145, 30, 2);
INSERT INTO `mob_spawn_sets` VALUES (145, 31, 1);
INSERT INTO `mob_spawn_sets` VALUES (145, 32, 2);
INSERT INTO `mob_spawn_sets` VALUES (145, 33, 2);
INSERT INTO `mob_spawn_sets` VALUES (145, 34, 1);
INSERT INTO `mob_spawn_sets` VALUES (145, 35, 1);
INSERT INTO `mob_spawn_sets` VALUES (145, 36, 2);
INSERT INTO `mob_spawn_sets` VALUES (145, 37, 1);
INSERT INTO `mob_spawn_sets` VALUES (145, 38, 2);
INSERT INTO `mob_spawn_sets` VALUES (145, 39, 1);
INSERT INTO `mob_spawn_sets` VALUES (145, 40, 2);
INSERT INTO `mob_spawn_sets` VALUES (145, 41, 1);
INSERT INTO `mob_spawn_sets` VALUES (145, 42, 1);
INSERT INTO `mob_spawn_sets` VALUES (145, 43, 1);
INSERT INTO `mob_spawn_sets` VALUES (145, 44, 2);
INSERT INTO `mob_spawn_sets` VALUES (145, 45, 1);
INSERT INTO `mob_spawn_sets` VALUES (145, 46, 2);
INSERT INTO `mob_spawn_sets` VALUES (145, 47, 1);
INSERT INTO `mob_spawn_sets` VALUES (145, 48, 2);
INSERT INTO `mob_spawn_sets` VALUES (145, 49, 1);
INSERT INTO `mob_spawn_sets` VALUES (145, 50, 1);
INSERT INTO `mob_spawn_sets` VALUES (145, 51, 2);
INSERT INTO `mob_spawn_sets` VALUES (145, 52, 1);
INSERT INTO `mob_spawn_sets` VALUES (145, 53, 1);
INSERT INTO `mob_spawn_sets` VALUES (145, 54, 1);
INSERT INTO `mob_spawn_sets` VALUES (145, 55, 1);
INSERT INTO `mob_spawn_sets` VALUES (145, 56, 2);
INSERT INTO `mob_spawn_sets` VALUES (145, 57, 2);
INSERT INTO `mob_spawn_sets` VALUES (145, 58, 1);
INSERT INTO `mob_spawn_sets` VALUES (145, 59, 2);
INSERT INTO `mob_spawn_sets` VALUES (145, 60, 2);
INSERT INTO `mob_spawn_sets` VALUES (145, 61, 1);
INSERT INTO `mob_spawn_sets` VALUES (145, 62, 1);
INSERT INTO `mob_spawn_sets` VALUES (145, 63, 2);
INSERT INTO `mob_spawn_sets` VALUES (145, 64, 1);
INSERT INTO `mob_spawn_sets` VALUES (145, 65, 1);
INSERT INTO `mob_spawn_sets` VALUES (145, 66, 1);
INSERT INTO `mob_spawn_sets` VALUES (145, 67, 2);
INSERT INTO `mob_spawn_sets` VALUES (145, 68, 1);
INSERT INTO `mob_spawn_sets` VALUES (145, 69, 1);
INSERT INTO `mob_spawn_sets` VALUES (145, 70, 1);
INSERT INTO `mob_spawn_sets` VALUES (145, 71, 1);
INSERT INTO `mob_spawn_sets` VALUES (145, 72, 1);
INSERT INTO `mob_spawn_sets` VALUES (145, 73, 2);
INSERT INTO `mob_spawn_sets` VALUES (145, 74, 1);
INSERT INTO `mob_spawn_sets` VALUES (145, 75, 2);
INSERT INTO `mob_spawn_sets` VALUES (145, 76, 2);
INSERT INTO `mob_spawn_sets` VALUES (145, 77, 2);
INSERT INTO `mob_spawn_sets` VALUES (145, 78, 1);
INSERT INTO `mob_spawn_sets` VALUES (145, 79, 2);
INSERT INTO `mob_spawn_sets` VALUES (145, 80, 1);
INSERT INTO `mob_spawn_sets` VALUES (145, 81, 2);
INSERT INTO `mob_spawn_sets` VALUES (145, 82, 2);
INSERT INTO `mob_spawn_sets` VALUES (145, 83, 1);
INSERT INTO `mob_spawn_sets` VALUES (145, 84, 1);
INSERT INTO `mob_spawn_sets` VALUES (145, 85, 2);

-- Grand Palace of HuXzoi
INSERT INTO `mob_spawn_sets` VALUES (34, 1, 2);
INSERT INTO `mob_spawn_sets` VALUES (34, 2, 4);
INSERT INTO `mob_spawn_sets` VALUES (34, 3, 3);
INSERT INTO `mob_spawn_sets` VALUES (34, 4, 1);
INSERT INTO `mob_spawn_sets` VALUES (34, 5, 4);
INSERT INTO `mob_spawn_sets` VALUES (34, 6, 4);
INSERT INTO `mob_spawn_sets` VALUES (34, 7, 4);
INSERT INTO `mob_spawn_sets` VALUES (34, 8, 2);
INSERT INTO `mob_spawn_sets` VALUES (34, 9, 4);
INSERT INTO `mob_spawn_sets` VALUES (34, 10, 4);
INSERT INTO `mob_spawn_sets` VALUES (34, 11, 1);
INSERT INTO `mob_spawn_sets` VALUES (34, 12, 1);
INSERT INTO `mob_spawn_sets` VALUES (34, 13, 4);
INSERT INTO `mob_spawn_sets` VALUES (34, 14, 4);
INSERT INTO `mob_spawn_sets` VALUES (34, 15, 1);
INSERT INTO `mob_spawn_sets` VALUES (34, 16, 4);
INSERT INTO `mob_spawn_sets` VALUES (34, 17, 4);
INSERT INTO `mob_spawn_sets` VALUES (34, 18, 4);
INSERT INTO `mob_spawn_sets` VALUES (34, 19, 2);
INSERT INTO `mob_spawn_sets` VALUES (34, 20, 4);
INSERT INTO `mob_spawn_sets` VALUES (34, 21, 4);
INSERT INTO `mob_spawn_sets` VALUES (34, 22, 1);
INSERT INTO `mob_spawn_sets` VALUES (34, 23, 4);
INSERT INTO `mob_spawn_sets` VALUES (34, 24, 1);
INSERT INTO `mob_spawn_sets` VALUES (34, 25, 3);

-- Gusgen Mines
INSERT INTO `mob_spawn_sets` VALUES (196, 1, 2);
INSERT INTO `mob_spawn_sets` VALUES (196, 2, 2);
INSERT INTO `mob_spawn_sets` VALUES (196, 3, 2);
INSERT INTO `mob_spawn_sets` VALUES (196, 4, 3);
INSERT INTO `mob_spawn_sets` VALUES (196, 5, 3);
INSERT INTO `mob_spawn_sets` VALUES (196, 6, 2);
INSERT INTO `mob_spawn_sets` VALUES (196, 7, 1);
INSERT INTO `mob_spawn_sets` VALUES (196, 8, 1);
INSERT INTO `mob_spawn_sets` VALUES (196, 9, 1);
INSERT INTO `mob_spawn_sets` VALUES (196, 10, 1);
INSERT INTO `mob_spawn_sets` VALUES (196, 11, 1);
INSERT INTO `mob_spawn_sets` VALUES (196, 12, 1);

-- Ifrits Cauldron
-- INSERT INTO `mob_spawn_sets` VALUES (205, 1, 2); -- Removed for Era+
-- INSERT INTO `mob_spawn_sets` VALUES (205, 2, 3); -- Removed for Era+
INSERT INTO `mob_spawn_sets` VALUES (205, 3, 1);
INSERT INTO `mob_spawn_sets` VALUES (205, 4, 1);
INSERT INTO `mob_spawn_sets` VALUES (205, 5, 1);
INSERT INTO `mob_spawn_sets` VALUES (205, 6, 1);
INSERT INTO `mob_spawn_sets` VALUES (205, 7, 1);
INSERT INTO `mob_spawn_sets` VALUES (205, 8, 1);
INSERT INTO `mob_spawn_sets` VALUES (205, 9, 1);
INSERT INTO `mob_spawn_sets` VALUES (205, 10, 1);
INSERT INTO `mob_spawn_sets` VALUES (205, 11, 1);
INSERT INTO `mob_spawn_sets` VALUES (205, 12, 1);
INSERT INTO `mob_spawn_sets` VALUES (205, 13, 1);
INSERT INTO `mob_spawn_sets` VALUES (205, 14, 1);
INSERT INTO `mob_spawn_sets` VALUES (205, 15, 4);
INSERT INTO `mob_spawn_sets` VALUES (205, 16, 1);
INSERT INTO `mob_spawn_sets` VALUES (205, 17, 2);
INSERT INTO `mob_spawn_sets` VALUES (205, 18, 4);
INSERT INTO `mob_spawn_sets` VALUES (205, 19, 4);
INSERT INTO `mob_spawn_sets` VALUES (205, 20, 3);
INSERT INTO `mob_spawn_sets` VALUES (205, 21, 1);
INSERT INTO `mob_spawn_sets` VALUES (205, 22, 1);
INSERT INTO `mob_spawn_sets` VALUES (205, 23, 1);
INSERT INTO `mob_spawn_sets` VALUES (205, 24, 3);

-- Inner Horutoto Ruins
INSERT INTO `mob_spawn_sets` VALUES (192, 1, 1);
INSERT INTO `mob_spawn_sets` VALUES (192, 2, 2);
INSERT INTO `mob_spawn_sets` VALUES (192, 3, 1);
INSERT INTO `mob_spawn_sets` VALUES (192, 4, 2);
INSERT INTO `mob_spawn_sets` VALUES (192, 5, 2);
INSERT INTO `mob_spawn_sets` VALUES (192, 6, 2);
INSERT INTO `mob_spawn_sets` VALUES (192, 7, 2);
INSERT INTO `mob_spawn_sets` VALUES (192, 8, 2);
INSERT INTO `mob_spawn_sets` VALUES (192, 9, 2);
INSERT INTO `mob_spawn_sets` VALUES (192, 10, 2);
INSERT INTO `mob_spawn_sets` VALUES (192, 11, 3);
INSERT INTO `mob_spawn_sets` VALUES (192, 12, 3);

-- Jugner Forest
INSERT INTO `mob_spawn_sets` VALUES (104, 1, 2);
INSERT INTO `mob_spawn_sets` VALUES (104, 2, 3);
INSERT INTO `mob_spawn_sets` VALUES (104, 3, 2);
INSERT INTO `mob_spawn_sets` VALUES (104, 4, 2);
INSERT INTO `mob_spawn_sets` VALUES (104, 5, 6);
INSERT INTO `mob_spawn_sets` VALUES (104, 6, 2);
INSERT INTO `mob_spawn_sets` VALUES (104, 7, 2);
INSERT INTO `mob_spawn_sets` VALUES (104, 8, 6);
INSERT INTO `mob_spawn_sets` VALUES (104, 9, 6);
INSERT INTO `mob_spawn_sets` VALUES (104, 10, 4);
INSERT INTO `mob_spawn_sets` VALUES (104, 11, 1);
INSERT INTO `mob_spawn_sets` VALUES (104, 12, 3);
INSERT INTO `mob_spawn_sets` VALUES (104, 13, 2);
INSERT INTO `mob_spawn_sets` VALUES (104, 14, 2);
INSERT INTO `mob_spawn_sets` VALUES (104, 15, 2);
INSERT INTO `mob_spawn_sets` VALUES (104, 16, 6);
INSERT INTO `mob_spawn_sets` VALUES (104, 17, 2);
INSERT INTO `mob_spawn_sets` VALUES (104, 18, 2);
INSERT INTO `mob_spawn_sets` VALUES (104, 19, 2);
INSERT INTO `mob_spawn_sets` VALUES (104, 20, 6);
INSERT INTO `mob_spawn_sets` VALUES (104, 21, 2);
INSERT INTO `mob_spawn_sets` VALUES (104, 22, 2);
INSERT INTO `mob_spawn_sets` VALUES (104, 23, 2);
INSERT INTO `mob_spawn_sets` VALUES (104, 24, 2);
INSERT INTO `mob_spawn_sets` VALUES (104, 25, 6);

-- King Ranperres Tomb
INSERT INTO `mob_spawn_sets` VALUES (190, 1, 3);
INSERT INTO `mob_spawn_sets` VALUES (190, 2, 3);
INSERT INTO `mob_spawn_sets` VALUES (190, 3, 6);
INSERT INTO `mob_spawn_sets` VALUES (190, 4, 6);
INSERT INTO `mob_spawn_sets` VALUES (190, 5, 1);
INSERT INTO `mob_spawn_sets` VALUES (190, 6, 1);
INSERT INTO `mob_spawn_sets` VALUES (190, 7, 1);
INSERT INTO `mob_spawn_sets` VALUES (190, 8, 1);
INSERT INTO `mob_spawn_sets` VALUES (190, 9, 1);
INSERT INTO `mob_spawn_sets` VALUES (190, 10, 2);
INSERT INTO `mob_spawn_sets` VALUES (190, 11, 2);
INSERT INTO `mob_spawn_sets` VALUES (190, 12, 1);
INSERT INTO `mob_spawn_sets` VALUES (190, 13, 2);
INSERT INTO `mob_spawn_sets` VALUES (190, 14, 2);
INSERT INTO `mob_spawn_sets` VALUES (190, 15, 1);
INSERT INTO `mob_spawn_sets` VALUES (190, 16, 1);
INSERT INTO `mob_spawn_sets` VALUES (190, 17, 2);
INSERT INTO `mob_spawn_sets` VALUES (190, 18, 1);
INSERT INTO `mob_spawn_sets` VALUES (190, 19, 3);
INSERT INTO `mob_spawn_sets` VALUES (190, 20, 3);
INSERT INTO `mob_spawn_sets` VALUES (190, 21, 3);
INSERT INTO `mob_spawn_sets` VALUES (190, 22, 3);
INSERT INTO `mob_spawn_sets` VALUES (190, 23, 1);
INSERT INTO `mob_spawn_sets` VALUES (190, 24, 1);
INSERT INTO `mob_spawn_sets` VALUES (190, 25, 1);

-- Konschtat Highlands
INSERT INTO `mob_spawn_sets` VALUES (108, 1, 4);
INSERT INTO `mob_spawn_sets` VALUES (108, 2, 3);
INSERT INTO `mob_spawn_sets` VALUES (108, 3, 3);
INSERT INTO `mob_spawn_sets` VALUES (108, 4, 4);
INSERT INTO `mob_spawn_sets` VALUES (108, 5, 5);
INSERT INTO `mob_spawn_sets` VALUES (108, 6, 2);
INSERT INTO `mob_spawn_sets` VALUES (108, 7, 5);
INSERT INTO `mob_spawn_sets` VALUES (108, 8, 5);
INSERT INTO `mob_spawn_sets` VALUES (108, 9, 4);
INSERT INTO `mob_spawn_sets` VALUES (108, 10, 5);
INSERT INTO `mob_spawn_sets` VALUES (108, 11, 5);
INSERT INTO `mob_spawn_sets` VALUES (108, 12, 9);
INSERT INTO `mob_spawn_sets` VALUES (108, 13, 2);
INSERT INTO `mob_spawn_sets` VALUES (108, 14, 4);
INSERT INTO `mob_spawn_sets` VALUES (108, 15, 6);
INSERT INTO `mob_spawn_sets` VALUES (108, 16, 4);
INSERT INTO `mob_spawn_sets` VALUES (108, 17, 4);
INSERT INTO `mob_spawn_sets` VALUES (108, 18, 4);
INSERT INTO `mob_spawn_sets` VALUES (108, 19, 7);
INSERT INTO `mob_spawn_sets` VALUES (108, 20, 3);
INSERT INTO `mob_spawn_sets` VALUES (108, 21, 2);
INSERT INTO `mob_spawn_sets` VALUES (108, 22, 2);

-- Korroloka Tunnel
INSERT INTO `mob_spawn_sets` VALUES (173, 1, 1);
INSERT INTO `mob_spawn_sets` VALUES (173, 2, 1);
INSERT INTO `mob_spawn_sets` VALUES (173, 3, 1);
INSERT INTO `mob_spawn_sets` VALUES (173, 4, 1);
INSERT INTO `mob_spawn_sets` VALUES (173, 5, 8);
INSERT INTO `mob_spawn_sets` VALUES (173, 6, 10);

-- Kuftal Tunnel
INSERT INTO `mob_spawn_sets` VALUES (174, 1, 2);
INSERT INTO `mob_spawn_sets` VALUES (174, 2, 2);
INSERT INTO `mob_spawn_sets` VALUES (174, 3, 1);
INSERT INTO `mob_spawn_sets` VALUES (174, 4, 2);
INSERT INTO `mob_spawn_sets` VALUES (174, 5, 2);
INSERT INTO `mob_spawn_sets` VALUES (174, 6, 2);
INSERT INTO `mob_spawn_sets` VALUES (174, 7, 1);

-- La Theine Plateau
INSERT INTO `mob_spawn_sets` VALUES (102, 1, 6);
INSERT INTO `mob_spawn_sets` VALUES (102, 2, 3);
INSERT INTO `mob_spawn_sets` VALUES (102, 3, 2);
INSERT INTO `mob_spawn_sets` VALUES (102, 4, 6);
INSERT INTO `mob_spawn_sets` VALUES (102, 5, 3);
INSERT INTO `mob_spawn_sets` VALUES (102, 6, 3);
INSERT INTO `mob_spawn_sets` VALUES (102, 7, 5);
INSERT INTO `mob_spawn_sets` VALUES (102, 8, 3);
INSERT INTO `mob_spawn_sets` VALUES (102, 9, 4);
INSERT INTO `mob_spawn_sets` VALUES (102, 10, 2);
INSERT INTO `mob_spawn_sets` VALUES (102, 11, 3);
INSERT INTO `mob_spawn_sets` VALUES (102, 12, 2);
INSERT INTO `mob_spawn_sets` VALUES (102, 13, 5);
INSERT INTO `mob_spawn_sets` VALUES (102, 14, 4);
INSERT INTO `mob_spawn_sets` VALUES (102, 15, 4);
INSERT INTO `mob_spawn_sets` VALUES (102, 16, 2);
INSERT INTO `mob_spawn_sets` VALUES (102, 17, 6);
INSERT INTO `mob_spawn_sets` VALUES (102, 18, 6);
INSERT INTO `mob_spawn_sets` VALUES (102, 19, 3);
INSERT INTO `mob_spawn_sets` VALUES (102, 20, 3);
INSERT INTO `mob_spawn_sets` VALUES (102, 21, 5);
INSERT INTO `mob_spawn_sets` VALUES (102, 22, 6);
INSERT INTO `mob_spawn_sets` VALUES (102, 23, 6);
INSERT INTO `mob_spawn_sets` VALUES (102, 24, 5);

-- Lufaise Meadows
INSERT INTO `mob_spawn_sets` VALUES (24, 1, 3);
INSERT INTO `mob_spawn_sets` VALUES (24, 2, 3);
INSERT INTO `mob_spawn_sets` VALUES (24, 3, 2);
INSERT INTO `mob_spawn_sets` VALUES (24, 4, 2);
INSERT INTO `mob_spawn_sets` VALUES (24, 5, 1);
INSERT INTO `mob_spawn_sets` VALUES (24, 6, 1);
INSERT INTO `mob_spawn_sets` VALUES (24, 7, 2);
INSERT INTO `mob_spawn_sets` VALUES (24, 8, 1);
INSERT INTO `mob_spawn_sets` VALUES (24, 9, 2);
INSERT INTO `mob_spawn_sets` VALUES (24, 10, 4);
INSERT INTO `mob_spawn_sets` VALUES (24, 11, 2);
INSERT INTO `mob_spawn_sets` VALUES (24, 12, 2);
INSERT INTO `mob_spawn_sets` VALUES (24, 13, 1);
INSERT INTO `mob_spawn_sets` VALUES (24, 14, 1);
INSERT INTO `mob_spawn_sets` VALUES (24, 15, 1);
INSERT INTO `mob_spawn_sets` VALUES (24, 16, 1);
INSERT INTO `mob_spawn_sets` VALUES (24, 17, 1);
INSERT INTO `mob_spawn_sets` VALUES (24, 18, 1);
INSERT INTO `mob_spawn_sets` VALUES (24, 19, 1);
INSERT INTO `mob_spawn_sets` VALUES (24, 20, 2);

-- Lower Delkfutts Tower
INSERT INTO `mob_spawn_sets` VALUES (184, 1, 2);
INSERT INTO `mob_spawn_sets` VALUES (184, 2, 1);
INSERT INTO `mob_spawn_sets` VALUES (184, 3, 1);
INSERT INTO `mob_spawn_sets` VALUES (184, 4, 2);
INSERT INTO `mob_spawn_sets` VALUES (184, 5, 3);
INSERT INTO `mob_spawn_sets` VALUES (184, 6, 3);
INSERT INTO `mob_spawn_sets` VALUES (184, 7, 1);
INSERT INTO `mob_spawn_sets` VALUES (184, 8, 2);
INSERT INTO `mob_spawn_sets` VALUES (184, 9, 2);
INSERT INTO `mob_spawn_sets` VALUES (184, 10, 1);
INSERT INTO `mob_spawn_sets` VALUES (184, 11, 4);
INSERT INTO `mob_spawn_sets` VALUES (184, 12, 2);
INSERT INTO `mob_spawn_sets` VALUES (184, 13, 1);
INSERT INTO `mob_spawn_sets` VALUES (184, 14, 3);
INSERT INTO `mob_spawn_sets` VALUES (184, 15, 2);
INSERT INTO `mob_spawn_sets` VALUES (184, 16, 3);
INSERT INTO `mob_spawn_sets` VALUES (184, 17, 2);
INSERT INTO `mob_spawn_sets` VALUES (184, 18, 3);
INSERT INTO `mob_spawn_sets` VALUES (184, 19, 2);
INSERT INTO `mob_spawn_sets` VALUES (184, 20, 2);
INSERT INTO `mob_spawn_sets` VALUES (184, 21, 3);
INSERT INTO `mob_spawn_sets` VALUES (184, 22, 2);
INSERT INTO `mob_spawn_sets` VALUES (184, 23, 3);
INSERT INTO `mob_spawn_sets` VALUES (184, 24, 2);
INSERT INTO `mob_spawn_sets` VALUES (184, 25, 2);
INSERT INTO `mob_spawn_sets` VALUES (184, 26, 2);
INSERT INTO `mob_spawn_sets` VALUES (184, 27, 1);
INSERT INTO `mob_spawn_sets` VALUES (184, 28, 2);

-- Maze of Shakhrami
INSERT INTO `mob_spawn_sets` VALUES (198, 1, 3);
INSERT INTO `mob_spawn_sets` VALUES (198, 2, 3);
INSERT INTO `mob_spawn_sets` VALUES (198, 3, 3);
INSERT INTO `mob_spawn_sets` VALUES (198, 4, 3);
INSERT INTO `mob_spawn_sets` VALUES (198, 5, 3);
INSERT INTO `mob_spawn_sets` VALUES (198, 6, 4);
INSERT INTO `mob_spawn_sets` VALUES (198, 7, 2);
INSERT INTO `mob_spawn_sets` VALUES (198, 8, 2);
INSERT INTO `mob_spawn_sets` VALUES (198, 9, 2);
INSERT INTO `mob_spawn_sets` VALUES (198, 10, 2);
INSERT INTO `mob_spawn_sets` VALUES (198, 11, 1);
INSERT INTO `mob_spawn_sets` VALUES (198, 12, 1);
INSERT INTO `mob_spawn_sets` VALUES (198, 13, 1);
INSERT INTO `mob_spawn_sets` VALUES (198, 14, 3);
INSERT INTO `mob_spawn_sets` VALUES (198, 15, 1);
INSERT INTO `mob_spawn_sets` VALUES (198, 16, 2);
INSERT INTO `mob_spawn_sets` VALUES (198, 17, 1);
INSERT INTO `mob_spawn_sets` VALUES (198, 18, 2);
INSERT INTO `mob_spawn_sets` VALUES (198, 19, 2);
INSERT INTO `mob_spawn_sets` VALUES (198, 20, 3);
INSERT INTO `mob_spawn_sets` VALUES (198, 21, 5);
INSERT INTO `mob_spawn_sets` VALUES (198, 22, 3);
INSERT INTO `mob_spawn_sets` VALUES (198, 23, 3);
INSERT INTO `mob_spawn_sets` VALUES (198, 24, 1);
INSERT INTO `mob_spawn_sets` VALUES (198, 25, 1);
INSERT INTO `mob_spawn_sets` VALUES (198, 26, 1);
INSERT INTO `mob_spawn_sets` VALUES (198, 27, 3);
INSERT INTO `mob_spawn_sets` VALUES (198, 28, 4);
INSERT INTO `mob_spawn_sets` VALUES (198, 29, 3);
INSERT INTO `mob_spawn_sets` VALUES (198, 30, 3);
INSERT INTO `mob_spawn_sets` VALUES (198, 31, 3);
INSERT INTO `mob_spawn_sets` VALUES (198, 32, 2);
INSERT INTO `mob_spawn_sets` VALUES (198, 33, 1);

-- Meriphataud Mountains
INSERT INTO `mob_spawn_sets` VALUES (119, 1, 5);
INSERT INTO `mob_spawn_sets` VALUES (119, 2, 2);
INSERT INTO `mob_spawn_sets` VALUES (119, 3, 2);
INSERT INTO `mob_spawn_sets` VALUES (119, 4, 6);
INSERT INTO `mob_spawn_sets` VALUES (119, 5, 4);
INSERT INTO `mob_spawn_sets` VALUES (119, 6, 1);
INSERT INTO `mob_spawn_sets` VALUES (119, 7, 3);
INSERT INTO `mob_spawn_sets` VALUES (119, 8, 3);
INSERT INTO `mob_spawn_sets` VALUES (119, 9, 3);
INSERT INTO `mob_spawn_sets` VALUES (119, 10, 2);
INSERT INTO `mob_spawn_sets` VALUES (119, 11, 5);
INSERT INTO `mob_spawn_sets` VALUES (119, 12, 2);
INSERT INTO `mob_spawn_sets` VALUES (119, 13, 6);
INSERT INTO `mob_spawn_sets` VALUES (119, 14, 2);
INSERT INTO `mob_spawn_sets` VALUES (119, 15, 3);
INSERT INTO `mob_spawn_sets` VALUES (119, 16, 6);

-- Middle Delkfutts Towerr
INSERT INTO `mob_spawn_sets` VALUES (157, 1, 3);
INSERT INTO `mob_spawn_sets` VALUES (157, 2, 2);
INSERT INTO `mob_spawn_sets` VALUES (157, 3, 2);
INSERT INTO `mob_spawn_sets` VALUES (157, 4, 1);
INSERT INTO `mob_spawn_sets` VALUES (157, 5, 2);
INSERT INTO `mob_spawn_sets` VALUES (157, 6, 2);
INSERT INTO `mob_spawn_sets` VALUES (157, 7, 1);
INSERT INTO `mob_spawn_sets` VALUES (157, 8, 1);
INSERT INTO `mob_spawn_sets` VALUES (157, 9, 1);
INSERT INTO `mob_spawn_sets` VALUES (157, 10, 2);
INSERT INTO `mob_spawn_sets` VALUES (157, 11, 2);
INSERT INTO `mob_spawn_sets` VALUES (157, 12, 2);
INSERT INTO `mob_spawn_sets` VALUES (157, 13, 1);
INSERT INTO `mob_spawn_sets` VALUES (157, 14, 2);
INSERT INTO `mob_spawn_sets` VALUES (157, 15, 2);
INSERT INTO `mob_spawn_sets` VALUES (157, 16, 2);
INSERT INTO `mob_spawn_sets` VALUES (157, 17, 2);
INSERT INTO `mob_spawn_sets` VALUES (157, 18, 2);
INSERT INTO `mob_spawn_sets` VALUES (157, 19, 2);
INSERT INTO `mob_spawn_sets` VALUES (157, 20, 2);
INSERT INTO `mob_spawn_sets` VALUES (157, 21, 2);
INSERT INTO `mob_spawn_sets` VALUES (157, 22, 2);
INSERT INTO `mob_spawn_sets` VALUES (157, 23, 3);
INSERT INTO `mob_spawn_sets` VALUES (157, 24, 2);
INSERT INTO `mob_spawn_sets` VALUES (157, 25, 1);
INSERT INTO `mob_spawn_sets` VALUES (157, 26, 2);
INSERT INTO `mob_spawn_sets` VALUES (157, 27, 2);
INSERT INTO `mob_spawn_sets` VALUES (157, 28, 2);
INSERT INTO `mob_spawn_sets` VALUES (157, 29, 2);
INSERT INTO `mob_spawn_sets` VALUES (157, 30, 2);
INSERT INTO `mob_spawn_sets` VALUES (157, 31, 2);
INSERT INTO `mob_spawn_sets` VALUES (157, 32, 2);
INSERT INTO `mob_spawn_sets` VALUES (157, 33, 2);
INSERT INTO `mob_spawn_sets` VALUES (157, 34, 2);
INSERT INTO `mob_spawn_sets` VALUES (157, 35, 2);
INSERT INTO `mob_spawn_sets` VALUES (157, 36, 1);
INSERT INTO `mob_spawn_sets` VALUES (157, 37, 2);
INSERT INTO `mob_spawn_sets` VALUES (157, 38, 2);
INSERT INTO `mob_spawn_sets` VALUES (157, 39, 5);
INSERT INTO `mob_spawn_sets` VALUES (157, 40, 1);
INSERT INTO `mob_spawn_sets` VALUES (157, 41, 1);
INSERT INTO `mob_spawn_sets` VALUES (157, 42, 1);
INSERT INTO `mob_spawn_sets` VALUES (157, 43, 2);
INSERT INTO `mob_spawn_sets` VALUES (157, 44, 2);
INSERT INTO `mob_spawn_sets` VALUES (157, 45, 2);
INSERT INTO `mob_spawn_sets` VALUES (157, 46, 1);
INSERT INTO `mob_spawn_sets` VALUES (157, 47, 2);
INSERT INTO `mob_spawn_sets` VALUES (157, 48, 1);

-- Misareaux Coast
INSERT INTO `mob_spawn_sets` VALUES (25, 1, 2);
INSERT INTO `mob_spawn_sets` VALUES (25, 2, 1);
INSERT INTO `mob_spawn_sets` VALUES (25, 3, 1);
INSERT INTO `mob_spawn_sets` VALUES (25, 4, 3);
INSERT INTO `mob_spawn_sets` VALUES (25, 5, 1);
INSERT INTO `mob_spawn_sets` VALUES (25, 6, 4);
INSERT INTO `mob_spawn_sets` VALUES (25, 7, 1);
INSERT INTO `mob_spawn_sets` VALUES (25, 8, 2);
INSERT INTO `mob_spawn_sets` VALUES (25, 9, 1);
INSERT INTO `mob_spawn_sets` VALUES (25, 10, 1);

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
INSERT INTO `mob_spawn_sets` VALUES (150, 42, 1);

-- Newton Movalpolos
INSERT INTO `mob_spawn_sets` VALUES (12, 1, 1);
INSERT INTO `mob_spawn_sets` VALUES (12, 2, 1);
INSERT INTO `mob_spawn_sets` VALUES (12, 3, 1);
INSERT INTO `mob_spawn_sets` VALUES (12, 4, 1);
INSERT INTO `mob_spawn_sets` VALUES (12, 5, 1);
INSERT INTO `mob_spawn_sets` VALUES (12, 6, 2);
INSERT INTO `mob_spawn_sets` VALUES (12, 7, 1);
INSERT INTO `mob_spawn_sets` VALUES (12, 8, 3);

-- North Gustaberg
INSERT INTO `mob_spawn_sets` VALUES (106, 1, 2);
INSERT INTO `mob_spawn_sets` VALUES (106, 2, 2);
INSERT INTO `mob_spawn_sets` VALUES (106, 3, 2);
INSERT INTO `mob_spawn_sets` VALUES (106, 4, 2);
INSERT INTO `mob_spawn_sets` VALUES (106, 5, 2);
INSERT INTO `mob_spawn_sets` VALUES (106, 6, 2);
INSERT INTO `mob_spawn_sets` VALUES (106, 7, 4);
INSERT INTO `mob_spawn_sets` VALUES (106, 8, 3);
INSERT INTO `mob_spawn_sets` VALUES (106, 9, 4);
INSERT INTO `mob_spawn_sets` VALUES (106, 10, 3);
INSERT INTO `mob_spawn_sets` VALUES (106, 11, 3);
INSERT INTO `mob_spawn_sets` VALUES (106, 12, 2);
INSERT INTO `mob_spawn_sets` VALUES (106, 13, 2);
INSERT INTO `mob_spawn_sets` VALUES (106, 14, 2);
INSERT INTO `mob_spawn_sets` VALUES (106, 15, 1);
INSERT INTO `mob_spawn_sets` VALUES (106, 16, 2);
INSERT INTO `mob_spawn_sets` VALUES (106, 17, 2);
INSERT INTO `mob_spawn_sets` VALUES (106, 18, 3);
INSERT INTO `mob_spawn_sets` VALUES (106, 19, 6);
INSERT INTO `mob_spawn_sets` VALUES (106, 20, 3);
INSERT INTO `mob_spawn_sets` VALUES (106, 21, 2);
INSERT INTO `mob_spawn_sets` VALUES (106, 22, 2);
INSERT INTO `mob_spawn_sets` VALUES (106, 23, 3);
INSERT INTO `mob_spawn_sets` VALUES (106, 24, 3);
INSERT INTO `mob_spawn_sets` VALUES (106, 25, 3);

-- Oldton Movalpolos
INSERT INTO `mob_spawn_sets` VALUES (11, 1, 2);
INSERT INTO `mob_spawn_sets` VALUES (11, 2, 9);
INSERT INTO `mob_spawn_sets` VALUES (11, 3, 1);
INSERT INTO `mob_spawn_sets` VALUES (11, 4, 1);
INSERT INTO `mob_spawn_sets` VALUES (11, 5, 1);

-- Ordelle Caves
INSERT INTO `mob_spawn_sets` VALUES (193, 1, 1);
INSERT INTO `mob_spawn_sets` VALUES (193, 2, 1);
INSERT INTO `mob_spawn_sets` VALUES (193, 3, 3);
INSERT INTO `mob_spawn_sets` VALUES (193, 4, 3);
INSERT INTO `mob_spawn_sets` VALUES (193, 5, 3);
INSERT INTO `mob_spawn_sets` VALUES (193, 6, 1);
INSERT INTO `mob_spawn_sets` VALUES (193, 7, 1);
INSERT INTO `mob_spawn_sets` VALUES (193, 8, 1);
INSERT INTO `mob_spawn_sets` VALUES (193, 9, 1);
INSERT INTO `mob_spawn_sets` VALUES (193, 10, 3);
INSERT INTO `mob_spawn_sets` VALUES (193, 11, 4);
INSERT INTO `mob_spawn_sets` VALUES (193, 12, 4);
INSERT INTO `mob_spawn_sets` VALUES (193, 13, 4);
INSERT INTO `mob_spawn_sets` VALUES (193, 14, 1);

-- Outer Horutoto Ruins
INSERT INTO `mob_spawn_sets` VALUES (194, 1, 1);
INSERT INTO `mob_spawn_sets` VALUES (194, 2, 1);
INSERT INTO `mob_spawn_sets` VALUES (194, 3, 1);
INSERT INTO `mob_spawn_sets` VALUES (194, 4, 1);
INSERT INTO `mob_spawn_sets` VALUES (194, 5, 1);
INSERT INTO `mob_spawn_sets` VALUES (194, 6, 1);
INSERT INTO `mob_spawn_sets` VALUES (194, 7, 1);
INSERT INTO `mob_spawn_sets` VALUES (194, 8, 1);
INSERT INTO `mob_spawn_sets` VALUES (194, 9, 1);
INSERT INTO `mob_spawn_sets` VALUES (194, 10, 1);
INSERT INTO `mob_spawn_sets` VALUES (194, 11, 1);
INSERT INTO `mob_spawn_sets` VALUES (194, 12, 1);
INSERT INTO `mob_spawn_sets` VALUES (194, 13, 1);

-- Phomiuna Aqueducts
INSERT INTO `mob_spawn_sets` VALUES (27, 1, 5);
INSERT INTO `mob_spawn_sets` VALUES (27, 2, 1);
INSERT INTO `mob_spawn_sets` VALUES (27, 3, 6);
INSERT INTO `mob_spawn_sets` VALUES (27, 4, 3);
INSERT INTO `mob_spawn_sets` VALUES (27, 5, 6);
INSERT INTO `mob_spawn_sets` VALUES (27, 6, 6);
INSERT INTO `mob_spawn_sets` VALUES (27, 7, 6);
INSERT INTO `mob_spawn_sets` VALUES (27, 8, 6);
INSERT INTO `mob_spawn_sets` VALUES (27, 9, 1);

-- Palborough Mines
INSERT INTO `mob_spawn_sets` VALUES (143, 1, 2);
INSERT INTO `mob_spawn_sets` VALUES (143, 2, 2);
INSERT INTO `mob_spawn_sets` VALUES (143, 3, 2);
INSERT INTO `mob_spawn_sets` VALUES (143, 4, 1);
INSERT INTO `mob_spawn_sets` VALUES (143, 5, 1);
INSERT INTO `mob_spawn_sets` VALUES (143, 6, 5);
INSERT INTO `mob_spawn_sets` VALUES (143, 7, 2);
INSERT INTO `mob_spawn_sets` VALUES (143, 8, 1);
INSERT INTO `mob_spawn_sets` VALUES (143, 9, 1);
INSERT INTO `mob_spawn_sets` VALUES (143, 10, 2);
INSERT INTO `mob_spawn_sets` VALUES (143, 11, 2);
INSERT INTO `mob_spawn_sets` VALUES (143, 12, 1);
INSERT INTO `mob_spawn_sets` VALUES (143, 13, 1);
INSERT INTO `mob_spawn_sets` VALUES (143, 14, 1);
INSERT INTO `mob_spawn_sets` VALUES (143, 15, 2);
INSERT INTO `mob_spawn_sets` VALUES (143, 16, 1);
INSERT INTO `mob_spawn_sets` VALUES (143, 17, 1);
INSERT INTO `mob_spawn_sets` VALUES (143, 18, 1);
INSERT INTO `mob_spawn_sets` VALUES (143, 19, 1);
INSERT INTO `mob_spawn_sets` VALUES (143, 20, 1);
INSERT INTO `mob_spawn_sets` VALUES (143, 21, 2);
INSERT INTO `mob_spawn_sets` VALUES (143, 22, 1);
INSERT INTO `mob_spawn_sets` VALUES (143, 23, 2);
INSERT INTO `mob_spawn_sets` VALUES (143, 24, 2);
INSERT INTO `mob_spawn_sets` VALUES (143, 25, 2);
INSERT INTO `mob_spawn_sets` VALUES (143, 26, 1);
INSERT INTO `mob_spawn_sets` VALUES (143, 27, 1);
INSERT INTO `mob_spawn_sets` VALUES (143, 28, 1);
INSERT INTO `mob_spawn_sets` VALUES (143, 29, 1);
INSERT INTO `mob_spawn_sets` VALUES (143, 30, 1);
INSERT INTO `mob_spawn_sets` VALUES (143, 31, 1);
INSERT INTO `mob_spawn_sets` VALUES (143, 32, 2);
INSERT INTO `mob_spawn_sets` VALUES (143, 33, 2);
INSERT INTO `mob_spawn_sets` VALUES (143, 34, 1);
INSERT INTO `mob_spawn_sets` VALUES (143, 35, 1);
INSERT INTO `mob_spawn_sets` VALUES (143, 36, 1);
INSERT INTO `mob_spawn_sets` VALUES (143, 37, 1);
INSERT INTO `mob_spawn_sets` VALUES (143, 38, 1);
INSERT INTO `mob_spawn_sets` VALUES (143, 39, 1);
INSERT INTO `mob_spawn_sets` VALUES (143, 40, 1);
INSERT INTO `mob_spawn_sets` VALUES (143, 41, 1);
INSERT INTO `mob_spawn_sets` VALUES (143, 42, 1);
INSERT INTO `mob_spawn_sets` VALUES (143, 43, 1);
INSERT INTO `mob_spawn_sets` VALUES (143, 44, 1);
INSERT INTO `mob_spawn_sets` VALUES (143, 45, 2);
INSERT INTO `mob_spawn_sets` VALUES (143, 46, 2);
INSERT INTO `mob_spawn_sets` VALUES (143, 47, 1);
INSERT INTO `mob_spawn_sets` VALUES (143, 48, 1);
INSERT INTO `mob_spawn_sets` VALUES (143, 49, 1);
INSERT INTO `mob_spawn_sets` VALUES (143, 50, 1);
INSERT INTO `mob_spawn_sets` VALUES (143, 51, 1);
INSERT INTO `mob_spawn_sets` VALUES (143, 52, 1);
INSERT INTO `mob_spawn_sets` VALUES (143, 53, 2);
INSERT INTO `mob_spawn_sets` VALUES (143, 54, 2);
INSERT INTO `mob_spawn_sets` VALUES (143, 55, 2);
INSERT INTO `mob_spawn_sets` VALUES (143, 56, 1);
INSERT INTO `mob_spawn_sets` VALUES (143, 57, 2);
INSERT INTO `mob_spawn_sets` VALUES (143, 58, 2);
INSERT INTO `mob_spawn_sets` VALUES (143, 59, 1);
INSERT INTO `mob_spawn_sets` VALUES (143, 60, 1);
INSERT INTO `mob_spawn_sets` VALUES (143, 61, 1);
INSERT INTO `mob_spawn_sets` VALUES (143, 62, 2);
INSERT INTO `mob_spawn_sets` VALUES (143, 63, 1);
INSERT INTO `mob_spawn_sets` VALUES (143, 64, 2);
INSERT INTO `mob_spawn_sets` VALUES (143, 65, 1);
INSERT INTO `mob_spawn_sets` VALUES (143, 66, 2);
INSERT INTO `mob_spawn_sets` VALUES (143, 67, 2);
INSERT INTO `mob_spawn_sets` VALUES (143, 68, 2);
INSERT INTO `mob_spawn_sets` VALUES (143, 69, 2);
INSERT INTO `mob_spawn_sets` VALUES (143, 70, 2);
INSERT INTO `mob_spawn_sets` VALUES (143, 71, 1);
INSERT INTO `mob_spawn_sets` VALUES (143, 72, 2);
INSERT INTO `mob_spawn_sets` VALUES (143, 73, 2);
INSERT INTO `mob_spawn_sets` VALUES (143, 74, 2);
INSERT INTO `mob_spawn_sets` VALUES (143, 75, 2);
INSERT INTO `mob_spawn_sets` VALUES (143, 76, 2);
INSERT INTO `mob_spawn_sets` VALUES (143, 77, 1);
INSERT INTO `mob_spawn_sets` VALUES (143, 78, 1);
INSERT INTO `mob_spawn_sets` VALUES (143, 79, 1);
INSERT INTO `mob_spawn_sets` VALUES (143, 80, 1);
INSERT INTO `mob_spawn_sets` VALUES (143, 81, 1);
INSERT INTO `mob_spawn_sets` VALUES (143, 82, 1);

-- Pashhow Marshlands
INSERT INTO `mob_spawn_sets` VALUES (109, 1, 5);
INSERT INTO `mob_spawn_sets` VALUES (109, 2, 6);
INSERT INTO `mob_spawn_sets` VALUES (109, 3, 5);
INSERT INTO `mob_spawn_sets` VALUES (109, 4, 6);
INSERT INTO `mob_spawn_sets` VALUES (109, 5, 3);
INSERT INTO `mob_spawn_sets` VALUES (109, 6, 6);
INSERT INTO `mob_spawn_sets` VALUES (109, 7, 1);
INSERT INTO `mob_spawn_sets` VALUES (109, 8, 3);
INSERT INTO `mob_spawn_sets` VALUES (109, 9, 1);
INSERT INTO `mob_spawn_sets` VALUES (109, 10, 1);
INSERT INTO `mob_spawn_sets` VALUES (109, 11, 4);
INSERT INTO `mob_spawn_sets` VALUES (109, 12, 9);
INSERT INTO `mob_spawn_sets` VALUES (109, 13, 3);

-- PsoXja
INSERT INTO `mob_spawn_sets` VALUES (9, 1, 4);
INSERT INTO `mob_spawn_sets` VALUES (9, 2, 2);
INSERT INTO `mob_spawn_sets` VALUES (9, 3, 1);
INSERT INTO `mob_spawn_sets` VALUES (9, 4, 1);
INSERT INTO `mob_spawn_sets` VALUES (9, 5, 4);
INSERT INTO `mob_spawn_sets` VALUES (9, 6, 3);
INSERT INTO `mob_spawn_sets` VALUES (9, 7, 3);
INSERT INTO `mob_spawn_sets` VALUES (9, 8, 3);

-- Qufim Island
INSERT INTO `mob_spawn_sets` VALUES (126, 1, 1);
INSERT INTO `mob_spawn_sets` VALUES (126, 2, 1);
INSERT INTO `mob_spawn_sets` VALUES (126, 3, 1);
INSERT INTO `mob_spawn_sets` VALUES (126, 4, 1);
INSERT INTO `mob_spawn_sets` VALUES (126, 5, 1);
INSERT INTO `mob_spawn_sets` VALUES (126, 6, 1);
INSERT INTO `mob_spawn_sets` VALUES (126, 7, 1);
INSERT INTO `mob_spawn_sets` VALUES (126, 8, 1);
INSERT INTO `mob_spawn_sets` VALUES (126, 9, 1);
INSERT INTO `mob_spawn_sets` VALUES (126, 10, 1);

-- Riverne-Site A01
INSERT INTO `mob_spawn_sets` VALUES (30, 1, 1);
INSERT INTO `mob_spawn_sets` VALUES (30, 2, 2);
INSERT INTO `mob_spawn_sets` VALUES (30, 3, 1);
INSERT INTO `mob_spawn_sets` VALUES (30, 4, 2);
INSERT INTO `mob_spawn_sets` VALUES (30, 5, 2);
INSERT INTO `mob_spawn_sets` VALUES (30, 6, 8);

-- Riverne-Site B01
INSERT INTO `mob_spawn_sets` VALUES (29, 1, 1);
INSERT INTO `mob_spawn_sets` VALUES (29, 2, 3);
INSERT INTO `mob_spawn_sets` VALUES (29, 3, 1);
INSERT INTO `mob_spawn_sets` VALUES (29, 4, 1);
INSERT INTO `mob_spawn_sets` VALUES (29, 5, 1);
INSERT INTO `mob_spawn_sets` VALUES (29, 6, 3);
INSERT INTO `mob_spawn_sets` VALUES (29, 7, 5);
INSERT INTO `mob_spawn_sets` VALUES (29, 8, 1);

-- The Shrine of Ru Avitau
INSERT INTO `mob_spawn_sets` VALUES (178, 1, 9);
INSERT INTO `mob_spawn_sets` VALUES (178, 2, 9);
INSERT INTO `mob_spawn_sets` VALUES (178, 3, 7);
INSERT INTO `mob_spawn_sets` VALUES (178, 4, 7);
INSERT INTO `mob_spawn_sets` VALUES (178, 5, 6);
INSERT INTO `mob_spawn_sets` VALUES (178, 6, 8);
INSERT INTO `mob_spawn_sets` VALUES (178, 7, 11);
INSERT INTO `mob_spawn_sets` VALUES (178, 8, 15);
INSERT INTO `mob_spawn_sets` VALUES (178, 9, 6);
INSERT INTO `mob_spawn_sets` VALUES (178, 10, 4);
INSERT INTO `mob_spawn_sets` VALUES (178, 11, 3);
INSERT INTO `mob_spawn_sets` VALUES (178, 12, 1);
INSERT INTO `mob_spawn_sets` VALUES (178, 13, 6);
INSERT INTO `mob_spawn_sets` VALUES (178, 14, 1);
INSERT INTO `mob_spawn_sets` VALUES (178, 15, 7);
INSERT INTO `mob_spawn_sets` VALUES (178, 16, 3);
INSERT INTO `mob_spawn_sets` VALUES (178, 17, 1);
INSERT INTO `mob_spawn_sets` VALUES (178, 18, 3);
INSERT INTO `mob_spawn_sets` VALUES (178, 19, 1);
INSERT INTO `mob_spawn_sets` VALUES (178, 20, 3);
INSERT INTO `mob_spawn_sets` VALUES (178, 21, 18);
INSERT INTO `mob_spawn_sets` VALUES (178, 22, 1);
INSERT INTO `mob_spawn_sets` VALUES (178, 23, 1);
INSERT INTO `mob_spawn_sets` VALUES (178, 24, 1);

-- Toramori Canal
INSERT INTO `mob_spawn_sets` VALUES (169, 1, 11);
INSERT INTO `mob_spawn_sets` VALUES (169, 2, 1);
INSERT INTO `mob_spawn_sets` VALUES (169, 3, 1);
INSERT INTO `mob_spawn_sets` VALUES (169, 4, 1);
INSERT INTO `mob_spawn_sets` VALUES (169, 5, 8);
INSERT INTO `mob_spawn_sets` VALUES (169, 6, 23);
INSERT INTO `mob_spawn_sets` VALUES (169, 7, 1);
INSERT INTO `mob_spawn_sets` VALUES (169, 8, 1);
INSERT INTO `mob_spawn_sets` VALUES (169, 9, 3);
INSERT INTO `mob_spawn_sets` VALUES (169, 10, 3);
INSERT INTO `mob_spawn_sets` VALUES (169, 11, 3);

-- Upper Delkfutts Tower
INSERT INTO `mob_spawn_sets` VALUES (158, 1, 1);
INSERT INTO `mob_spawn_sets` VALUES (158, 2, 1);
INSERT INTO `mob_spawn_sets` VALUES (158, 3, 2);
INSERT INTO `mob_spawn_sets` VALUES (158, 4, 1);
INSERT INTO `mob_spawn_sets` VALUES (158, 5, 1);
INSERT INTO `mob_spawn_sets` VALUES (158, 6, 3);
INSERT INTO `mob_spawn_sets` VALUES (158, 7, 3);
INSERT INTO `mob_spawn_sets` VALUES (158, 8, 2);
INSERT INTO `mob_spawn_sets` VALUES (158, 9, 2);
INSERT INTO `mob_spawn_sets` VALUES (158, 10, 2);
INSERT INTO `mob_spawn_sets` VALUES (158, 11, 2);
INSERT INTO `mob_spawn_sets` VALUES (158, 12, 2);
INSERT INTO `mob_spawn_sets` VALUES (158, 13, 2);
INSERT INTO `mob_spawn_sets` VALUES (158, 14, 2);
INSERT INTO `mob_spawn_sets` VALUES (158, 15, 2);

-- Rolanberry Fields
INSERT INTO `mob_spawn_sets` VALUES (110, 1, 7);
INSERT INTO `mob_spawn_sets` VALUES (110, 2, 7);
INSERT INTO `mob_spawn_sets` VALUES (110, 3, 7);
INSERT INTO `mob_spawn_sets` VALUES (110, 4, 7);
INSERT INTO `mob_spawn_sets` VALUES (110, 5, 7);
INSERT INTO `mob_spawn_sets` VALUES (110, 6, 6);
INSERT INTO `mob_spawn_sets` VALUES (110, 7, 7);
INSERT INTO `mob_spawn_sets` VALUES (110, 8, 7);
INSERT INTO `mob_spawn_sets` VALUES (110, 9, 6);

-- RoMaeve
INSERT INTO `mob_spawn_sets` VALUES (122, 1, 1);
INSERT INTO `mob_spawn_sets` VALUES (122, 2, 1);
INSERT INTO `mob_spawn_sets` VALUES (122, 3, 4);
INSERT INTO `mob_spawn_sets` VALUES (122, 4, 4);
INSERT INTO `mob_spawn_sets` VALUES (122, 5, 4);
INSERT INTO `mob_spawn_sets` VALUES (122, 6, 4);

-- RuAun Gardens
INSERT INTO `mob_spawn_sets` VALUES (130, 1, 3);
INSERT INTO `mob_spawn_sets` VALUES (130, 2, 1);
INSERT INTO `mob_spawn_sets` VALUES (130, 3, 3);
INSERT INTO `mob_spawn_sets` VALUES (130, 4, 1);
INSERT INTO `mob_spawn_sets` VALUES (130, 5, 1);
INSERT INTO `mob_spawn_sets` VALUES (130, 6, 3);

-- Sacrarium
INSERT INTO `mob_spawn_sets` VALUES (28, 1, 1);
INSERT INTO `mob_spawn_sets` VALUES (28, 2, 20);
INSERT INTO `mob_spawn_sets` VALUES (28, 3, 3);
INSERT INTO `mob_spawn_sets` VALUES (28, 4, 1);

-- Sauromugue Champaign
INSERT INTO `mob_spawn_sets` VALUES (120, 1, 7);
INSERT INTO `mob_spawn_sets` VALUES (120, 2, 7);
INSERT INTO `mob_spawn_sets` VALUES (120, 3, 7);
INSERT INTO `mob_spawn_sets` VALUES (120, 4, 7);
INSERT INTO `mob_spawn_sets` VALUES (120, 5, 7);
INSERT INTO `mob_spawn_sets` VALUES (120, 6, 6);
INSERT INTO `mob_spawn_sets` VALUES (120, 7, 7);
INSERT INTO `mob_spawn_sets` VALUES (120, 8, 7);
INSERT INTO `mob_spawn_sets` VALUES (120, 9, 2);
INSERT INTO `mob_spawn_sets` VALUES (120, 10, 7);

-- South Gustaberg
INSERT INTO `mob_spawn_sets` VALUES (107, 1, 1);
INSERT INTO `mob_spawn_sets` VALUES (107, 2, 2);
INSERT INTO `mob_spawn_sets` VALUES (107, 3, 2);
INSERT INTO `mob_spawn_sets` VALUES (107, 4, 1);
INSERT INTO `mob_spawn_sets` VALUES (107, 5, 2);
INSERT INTO `mob_spawn_sets` VALUES (107, 6, 2);
INSERT INTO `mob_spawn_sets` VALUES (107, 7, 1);
INSERT INTO `mob_spawn_sets` VALUES (107, 8, 3);
INSERT INTO `mob_spawn_sets` VALUES (107, 9, 3);
INSERT INTO `mob_spawn_sets` VALUES (107, 10, 4);
INSERT INTO `mob_spawn_sets` VALUES (107, 11, 3);
INSERT INTO `mob_spawn_sets` VALUES (107, 12, 3);
INSERT INTO `mob_spawn_sets` VALUES (107, 13, 3);
INSERT INTO `mob_spawn_sets` VALUES (107, 14, 3);
INSERT INTO `mob_spawn_sets` VALUES (107, 15, 3);
INSERT INTO `mob_spawn_sets` VALUES (107, 16, 3);
INSERT INTO `mob_spawn_sets` VALUES (107, 17, 3);

-- Tahrongi Canyon
INSERT INTO `mob_spawn_sets` VALUES (117, 1, 3);
INSERT INTO `mob_spawn_sets` VALUES (117, 2, 2);
INSERT INTO `mob_spawn_sets` VALUES (117, 3, 2);
INSERT INTO `mob_spawn_sets` VALUES (117, 4, 5);
INSERT INTO `mob_spawn_sets` VALUES (117, 5, 2);
INSERT INTO `mob_spawn_sets` VALUES (117, 6, 6);
INSERT INTO `mob_spawn_sets` VALUES (117, 7, 5);
INSERT INTO `mob_spawn_sets` VALUES (117, 8, 2);
INSERT INTO `mob_spawn_sets` VALUES (117, 9, 3);
INSERT INTO `mob_spawn_sets` VALUES (117, 10, 3);
INSERT INTO `mob_spawn_sets` VALUES (117, 11, 6);
INSERT INTO `mob_spawn_sets` VALUES (117, 12, 5);
INSERT INTO `mob_spawn_sets` VALUES (117, 13, 4);
INSERT INTO `mob_spawn_sets` VALUES (117, 14, 2);
INSERT INTO `mob_spawn_sets` VALUES (117, 15, 6);
INSERT INTO `mob_spawn_sets` VALUES (117, 16, 6);
INSERT INTO `mob_spawn_sets` VALUES (117, 17, 4);
INSERT INTO `mob_spawn_sets` VALUES (117, 18, 3);
INSERT INTO `mob_spawn_sets` VALUES (117, 19, 8);

-- The Sanctuary of ZiTah
INSERT INTO `mob_spawn_sets` VALUES (121, 1, 1);
INSERT INTO `mob_spawn_sets` VALUES (121, 2, 1);
INSERT INTO `mob_spawn_sets` VALUES (121, 3, 4);
INSERT INTO `mob_spawn_sets` VALUES (121, 4, 2);
INSERT INTO `mob_spawn_sets` VALUES (121, 5, 1);
INSERT INTO `mob_spawn_sets` VALUES (121, 6, 2);
INSERT INTO `mob_spawn_sets` VALUES (121, 7, 1);
INSERT INTO `mob_spawn_sets` VALUES (121, 8, 1);
INSERT INTO `mob_spawn_sets` VALUES (121, 9, 1);
INSERT INTO `mob_spawn_sets` VALUES (121, 10, 3);
INSERT INTO `mob_spawn_sets` VALUES (121, 11, 1);
INSERT INTO `mob_spawn_sets` VALUES (121, 12, 1);
INSERT INTO `mob_spawn_sets` VALUES (121, 13, 2);
INSERT INTO `mob_spawn_sets` VALUES (121, 14, 2);
INSERT INTO `mob_spawn_sets` VALUES (121, 15, 2);
INSERT INTO `mob_spawn_sets` VALUES (121, 16, 2);
INSERT INTO `mob_spawn_sets` VALUES (121, 17, 2);
INSERT INTO `mob_spawn_sets` VALUES (121, 18, 2);
INSERT INTO `mob_spawn_sets` VALUES (121, 19, 1);
INSERT INTO `mob_spawn_sets` VALUES (121, 20, 1);
INSERT INTO `mob_spawn_sets` VALUES (121, 21, 1);
INSERT INTO `mob_spawn_sets` VALUES (121, 22, 1);
INSERT INTO `mob_spawn_sets` VALUES (121, 23, 1);
INSERT INTO `mob_spawn_sets` VALUES (121, 24, 1);
INSERT INTO `mob_spawn_sets` VALUES (121, 25, 1);
INSERT INTO `mob_spawn_sets` VALUES (121, 26, 1);
INSERT INTO `mob_spawn_sets` VALUES (121, 27, 2);
INSERT INTO `mob_spawn_sets` VALUES (121, 28, 2);
INSERT INTO `mob_spawn_sets` VALUES (121, 29, 2);
INSERT INTO `mob_spawn_sets` VALUES (121, 30, 1);
INSERT INTO `mob_spawn_sets` VALUES (121, 31, 18);
INSERT INTO `mob_spawn_sets` VALUES (121, 32, 1);

-- Uleguerand Range
INSERT INTO `mob_spawn_sets` VALUES (5, 1, 3);
INSERT INTO `mob_spawn_sets` VALUES (5, 2, 3);
INSERT INTO `mob_spawn_sets` VALUES (5, 3, 3);
INSERT INTO `mob_spawn_sets` VALUES (5, 4, 4);
INSERT INTO `mob_spawn_sets` VALUES (5, 5, 3);
INSERT INTO `mob_spawn_sets` VALUES (5, 6, 1);
INSERT INTO `mob_spawn_sets` VALUES (5, 7, 1);
INSERT INTO `mob_spawn_sets` VALUES (5, 8, 1);
INSERT INTO `mob_spawn_sets` VALUES (5, 9, 1);
INSERT INTO `mob_spawn_sets` VALUES (5, 10, 1);
INSERT INTO `mob_spawn_sets` VALUES (5, 11, 2);
INSERT INTO `mob_spawn_sets` VALUES (5, 12, 2);
INSERT INTO `mob_spawn_sets` VALUES (5, 13, 3);
INSERT INTO `mob_spawn_sets` VALUES (5, 14, 2);
INSERT INTO `mob_spawn_sets` VALUES (5, 15, 2);
INSERT INTO `mob_spawn_sets` VALUES (5, 16, 3);
INSERT INTO `mob_spawn_sets` VALUES (5, 17, 6);

-- Valkurum Dunes
INSERT INTO `mob_spawn_sets` VALUES (103, 1, 19);
INSERT INTO `mob_spawn_sets` VALUES (103, 2, 3);
INSERT INTO `mob_spawn_sets` VALUES (103, 3, 3);
INSERT INTO `mob_spawn_sets` VALUES (103, 5, 3);
INSERT INTO `mob_spawn_sets` VALUES (103, 6, 1);
INSERT INTO `mob_spawn_sets` VALUES (103, 7, 6);
INSERT INTO `mob_spawn_sets` VALUES (103, 8, 3);
INSERT INTO `mob_spawn_sets` VALUES (103, 9, 2);
INSERT INTO `mob_spawn_sets` VALUES (103, 10, 1);
INSERT INTO `mob_spawn_sets` VALUES (103, 11, 1);
INSERT INTO `mob_spawn_sets` VALUES (103, 12, 1);
INSERT INTO `mob_spawn_sets` VALUES (103, 13, 1);
INSERT INTO `mob_spawn_sets` VALUES (103, 14, 5);
INSERT INTO `mob_spawn_sets` VALUES (103, 15, 3);
INSERT INTO `mob_spawn_sets` VALUES (103, 16, 5);
INSERT INTO `mob_spawn_sets` VALUES (103, 17, 3);
INSERT INTO `mob_spawn_sets` VALUES (103, 18, 3);
INSERT INTO `mob_spawn_sets` VALUES (103, 19, 1);
INSERT INTO `mob_spawn_sets` VALUES (103, 20, 3);
INSERT INTO `mob_spawn_sets` VALUES (103, 21, 3);
INSERT INTO `mob_spawn_sets` VALUES (103, 22, 3);
INSERT INTO `mob_spawn_sets` VALUES (103, 23, 1);
INSERT INTO `mob_spawn_sets` VALUES (103, 24, 3);
INSERT INTO `mob_spawn_sets` VALUES (103, 25, 2);

-- West Sarutabaruta
INSERT INTO `mob_spawn_sets` VALUES (115, 1, 3);
INSERT INTO `mob_spawn_sets` VALUES (115, 2, 3);
INSERT INTO `mob_spawn_sets` VALUES (115, 3, 3);
INSERT INTO `mob_spawn_sets` VALUES (115, 4, 6);
INSERT INTO `mob_spawn_sets` VALUES (115, 5, 3);
INSERT INTO `mob_spawn_sets` VALUES (115, 6, 3);
INSERT INTO `mob_spawn_sets` VALUES (115, 7, 3);
INSERT INTO `mob_spawn_sets` VALUES (115, 8, 1);
INSERT INTO `mob_spawn_sets` VALUES (115, 9, 3);
INSERT INTO `mob_spawn_sets` VALUES (115, 10, 3);

-- VeLugannon Palace
INSERT INTO `mob_spawn_sets` VALUES (177, 1, 1);
INSERT INTO `mob_spawn_sets` VALUES (177, 2, 3);
INSERT INTO `mob_spawn_sets` VALUES (177, 3, 5);
INSERT INTO `mob_spawn_sets` VALUES (177, 4, 4);
INSERT INTO `mob_spawn_sets` VALUES (177, 5, 3);
INSERT INTO `mob_spawn_sets` VALUES (177, 6, 4);
INSERT INTO `mob_spawn_sets` VALUES (177, 7, 5);
INSERT INTO `mob_spawn_sets` VALUES (177, 8, 3);
INSERT INTO `mob_spawn_sets` VALUES (177, 9, 5);
INSERT INTO `mob_spawn_sets` VALUES (177, 10, 2);
INSERT INTO `mob_spawn_sets` VALUES (177, 12, 2);
INSERT INTO `mob_spawn_sets` VALUES (177, 13, 5);
INSERT INTO `mob_spawn_sets` VALUES (177, 14, 3);
INSERT INTO `mob_spawn_sets` VALUES (177, 15, 5);
INSERT INTO `mob_spawn_sets` VALUES (177, 16, 2);
INSERT INTO `mob_spawn_sets` VALUES (177, 17, 5);
INSERT INTO `mob_spawn_sets` VALUES (177, 18, 5);
INSERT INTO `mob_spawn_sets` VALUES (177, 19, 5);
INSERT INTO `mob_spawn_sets` VALUES (177, 20, 4);
INSERT INTO `mob_spawn_sets` VALUES (177, 21, 5);
INSERT INTO `mob_spawn_sets` VALUES (177, 22, 2);
INSERT INTO `mob_spawn_sets` VALUES (177, 23, 5);

-- West Ronfaure
INSERT INTO `mob_spawn_sets` VALUES (100, 1, 20);
INSERT INTO `mob_spawn_sets` VALUES (100, 2, 3);
INSERT INTO `mob_spawn_sets` VALUES (100, 3, 14);
INSERT INTO `mob_spawn_sets` VALUES (100, 4, 3);
INSERT INTO `mob_spawn_sets` VALUES (100, 5, 5);
INSERT INTO `mob_spawn_sets` VALUES (100, 6, 3);
INSERT INTO `mob_spawn_sets` VALUES (100, 7, 3);
INSERT INTO `mob_spawn_sets` VALUES (100, 8, 3);
INSERT INTO `mob_spawn_sets` VALUES (100, 9, 5);
INSERT INTO `mob_spawn_sets` VALUES (100, 10, 3);
INSERT INTO `mob_spawn_sets` VALUES (100, 11, 4);
INSERT INTO `mob_spawn_sets` VALUES (100, 12, 3);
INSERT INTO `mob_spawn_sets` VALUES (100, 13, 3);
INSERT INTO `mob_spawn_sets` VALUES (100, 14, 3);
INSERT INTO `mob_spawn_sets` VALUES (100, 15, 3);
INSERT INTO `mob_spawn_sets` VALUES (100, 16, 2);
INSERT INTO `mob_spawn_sets` VALUES (100, 17, 3);
INSERT INTO `mob_spawn_sets` VALUES (100, 18, 3);
INSERT INTO `mob_spawn_sets` VALUES (100, 19, 2);
INSERT INTO `mob_spawn_sets` VALUES (100, 20, 2);
INSERT INTO `mob_spawn_sets` VALUES (100, 21, 3);
INSERT INTO `mob_spawn_sets` VALUES (100, 22, 2);
INSERT INTO `mob_spawn_sets` VALUES (100, 23, 2);

-- Western Altepa Desert
INSERT INTO `mob_spawn_sets` VALUES (125, 1, 2);
INSERT INTO `mob_spawn_sets` VALUES (125, 2, 1);
INSERT INTO `mob_spawn_sets` VALUES (125, 3, 2);
INSERT INTO `mob_spawn_sets` VALUES (125, 4, 3);
INSERT INTO `mob_spawn_sets` VALUES (125, 5, 2);

-- Xarcabard
INSERT INTO `mob_spawn_sets` VALUES (112, 1, 4);
INSERT INTO `mob_spawn_sets` VALUES (112, 2, 2);
INSERT INTO `mob_spawn_sets` VALUES (112, 3, 2);
INSERT INTO `mob_spawn_sets` VALUES (112, 4, 2);
INSERT INTO `mob_spawn_sets` VALUES (112, 5, 2);
INSERT INTO `mob_spawn_sets` VALUES (112, 6, 1);
INSERT INTO `mob_spawn_sets` VALUES (112, 7, 5);
INSERT INTO `mob_spawn_sets` VALUES (112, 8, 5);
INSERT INTO `mob_spawn_sets` VALUES (112, 9, 8);

-- Yughott Grotto
INSERT INTO `mob_spawn_sets` VALUES (142, 1, 3);
INSERT INTO `mob_spawn_sets` VALUES (142, 2, 3);
INSERT INTO `mob_spawn_sets` VALUES (142, 3, 1);
INSERT INTO `mob_spawn_sets` VALUES (142, 4, 2);
INSERT INTO `mob_spawn_sets` VALUES (142, 5, 2);
INSERT INTO `mob_spawn_sets` VALUES (142, 6, 2);
INSERT INTO `mob_spawn_sets` VALUES (142, 7, 3);
INSERT INTO `mob_spawn_sets` VALUES (142, 8, 1);
INSERT INTO `mob_spawn_sets` VALUES (142, 9, 9);
INSERT INTO `mob_spawn_sets` VALUES (142, 10, 3);
INSERT INTO `mob_spawn_sets` VALUES (142, 11, 2);
INSERT INTO `mob_spawn_sets` VALUES (142, 12, 4);
INSERT INTO `mob_spawn_sets` VALUES (142, 13, 3);
INSERT INTO `mob_spawn_sets` VALUES (142, 14, 4);
INSERT INTO `mob_spawn_sets` VALUES (142, 15, 1);
INSERT INTO `mob_spawn_sets` VALUES (142, 16, 3);
INSERT INTO `mob_spawn_sets` VALUES (142, 17, 3);
INSERT INTO `mob_spawn_sets` VALUES (142, 18, 2);
INSERT INTO `mob_spawn_sets` VALUES (142, 19, 2);
INSERT INTO `mob_spawn_sets` VALUES (142, 20, 2);
INSERT INTO `mob_spawn_sets` VALUES (142, 21, 2);
INSERT INTO `mob_spawn_sets` VALUES (142, 22, 3);
INSERT INTO `mob_spawn_sets` VALUES (142, 23, 4);
