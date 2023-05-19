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
    (15070,163,-2500), -- Aegis DMGMAGIC: -2500
    (13888,521,10), -- Onyx Sallet AUGMENTS_ABSORB: 10
    (14011,521,10), -- Onyx Gadlings AUGMENTS_ABSORB: 10
    (15401,521,10), -- Onyx Cuisses AUGMENTS_ABSORB: 10
    (15340,521,10), -- Onyx Sollerets AUGMENTS_ABSORB: 10
    (13887,521,10), -- Black Sallet AUGMENTS_ABSORB: 10
    (14010,521,10), -- Black Gadlings AUGMENTS_ABSORB: 10
    (15400,521,10), -- Black Cuisses AUGMENTS_ABSORB: 10
    (15339,521,10); -- Black Sollerets AUGMENTS_ABSORB: 10

-- Set Critical hit rate bonus in main/sub slots to apply only to slot with CRITHITRATE_SLOT mod
UPDATE item_mods
SET modId = 1168
WHERE itemId IN (
    SELECT itemId
    FROM item_weapon
    WHERE skill < 25
    AND skill != 0
    )
AND modId = 165;

UNLOCK TABLES;
