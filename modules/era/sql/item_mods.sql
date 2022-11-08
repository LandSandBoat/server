-- --------------------------------------------------------
-- AirSkyBoat Database Conversion File
-- --------------------------------------------------------
-- Table Structure Definition
--
-- 
-- 
-- --------------------------------------------------------
LOCK TABLES `item_mods` WRITE,
            `item_weapon` WRITE;

REPLACE INTO `item_mods` (`itemid`, `modid`, `value`) VALUES
    (15070,163,-2500); -- Aegis DMGMAGIC: -2500

UPDATE item_mods
SET modId = 1168
WHERE itemId IN (
    SELECT itemId
    FROM item_weapon
    WHERE skill < 25
    )
AND modId = 165;

UPDATE item_mods
SET modId = 1169
WHERE itemId IN (
    SELECT itemId
    FROM item_weapon
    WHERE skill < 25
    )
AND modId = 23;

UNLOCK TABLES;