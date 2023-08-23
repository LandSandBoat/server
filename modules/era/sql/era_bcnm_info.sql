-- --------------------------------------------------------
-- AirSkyBoat Database Conversion File
-- Replace BCNM data where required
-- --------------------------------------------------------

LOCK TABLES `bcnm_info` WRITE,
    `bcnm_battlefield` WRITE,
    `mob_pools` WRITE;

-- Update the header info for the BCNMs
UPDATE `bcnm_info` SET `levelCap`=40 WHERE `bcnmId`=737; -- Changed to level 40 cap

-- Update BCNM Mob data
DELETE FROM `bcnm_battlefield` WHERE `bcnmid`=737;
INSERT INTO `bcnm_battlefield` VALUES

    -- Return to the Depths (737)
    (737, 1, 16830480, 3), -- Twilotak
    (737, 1, 16830481, 1), -- Moblin Wisewoman
    (737, 1, 16830483, 1),
    (737, 1, 16830485, 1),
    (737, 1, 16830482, 1), -- Moblin Clergyman
    (737, 1, 16830484, 1),
    (737, 1, 16830486, 1),

    (737, 2, 16830487, 3),
    (737, 2, 16830488, 1),
    (737, 2, 16830490, 1),
    (737, 2, 16830492, 1),
    (737, 2, 16830489, 1),
    (737, 2, 16830491, 1),
    (737, 2, 16830493, 1),

    (737, 3, 16830494, 3),
    (737, 3, 16830495, 1),
    (737, 3, 16830497, 1),
    (737, 3, 16830499, 1),
    (737, 3, 16830496, 1),
    (737, 3, 16830498, 1),
    (737, 3, 16830500, 1);

-- Update Mob Pool data
UPDATE `mob_pools` SET `mobType`=18,`spellList`=5060 WHERE `name`='Twilotak'; -- Twilotak
UPDATE `mob_pools` SET `mobType`=18,`spellList`=5058 WHERE `name`='Moblin_Wisewoman'; -- Moblin Wisewoman
UPDATE `mob_pools` SET `mobType`=18,`spellList`=5059 WHERE `name`='Moblin_Clergyman'; -- Moblin Clergyman

UNLOCK TABLES;
