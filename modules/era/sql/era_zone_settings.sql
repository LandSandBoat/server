LOCK TABLES `zone_settings` WRITE;

ALTER TABLE `zone_settings`
    ADD COLUMN IF NOT EXISTS `updatedmesh` tinyint(1) unsigned NOT NULL DEFAULT '0' AFTER `misc`,
    ADD COLUMN IF NOT EXISTS `forcecarefulpathing` tinyint(1) unsigned NOT NULL DEFAULT '0' AFTER `updatedmesh`;

UPDATE `zone_settings` SET `updatedmesh` = 1, `forcecarefulpathing` = 1 WHERE `zoneid` = 146;
UPDATE `zone_settings` SET `updatedmesh` = 1, `forcecarefulpathing` = 1 WHERE `zoneid` = 147;
UPDATE `zone_settings` SET `updatedmesh` = 1, `forcecarefulpathing` = 1 WHERE `zoneid` = 149;
UPDATE `zone_settings` SET `updatedmesh` = 1, `forcecarefulpathing` = 1 WHERE `zoneid` = 185;
UPDATE `zone_settings` SET `updatedmesh` = 1, `forcecarefulpathing` = 1 WHERE `zoneid` = 188;
UPDATE `zone_settings` SET `updatedmesh` = 1, `forcecarefulpathing` = 1 WHERE `zoneid` = 100;
UPDATE `zone_settings` SET `updatedmesh` = 1, `forcecarefulpathing` = 1 WHERE `zoneid` = 101;
UPDATE `zone_settings` SET `updatedmesh` = 1, `forcecarefulpathing` = 1 WHERE `zoneid` = 105;
UPDATE `zone_settings` SET `updatedmesh` = 1, `forcecarefulpathing` = 1 WHERE `zoneid` = 106;
UPDATE `zone_settings` SET `updatedmesh` = 1, `forcecarefulpathing` = 1 WHERE `zoneid` = 107;
UPDATE `zone_settings` SET `updatedmesh` = 1, `forcecarefulpathing` = 1 WHERE `zoneid` = 108;
UPDATE `zone_settings` SET `updatedmesh` = 1, `forcecarefulpathing` = 1 WHERE `zoneid` = 109;
UPDATE `zone_settings` SET `updatedmesh` = 1, `forcecarefulpathing` = 1 WHERE `zoneid` = 115;
UPDATE `zone_settings` SET `updatedmesh` = 1, `forcecarefulpathing` = 1 WHERE `zoneid` = 116;
UPDATE `zone_settings` SET `updatedmesh` = 1, `forcecarefulpathing` = 1 WHERE `zoneid` = 117;
UPDATE `zone_settings` SET `updatedmesh` = 1, `forcecarefulpathing` = 1 WHERE `zoneid` = 120;
UPDATE `zone_settings` SET `updatedmesh` = 1, `forcecarefulpathing` = 1 WHERE `zoneid` = 10;
UPDATE `zone_settings` SET `updatedmesh` = 1, `forcecarefulpathing` = 1 WHERE `zoneid` = 139;
UPDATE `zone_settings` SET `updatedmesh` = 1, `forcecarefulpathing` = 1 WHERE `zoneid` = 128;

-- Remove mount flag from zones that cannot have Chocobos prior to mounts being added
-- This will subtract the bitwise 4 from the misc column only if the bitwise exists
UPDATE `zone_settings` SET `misc` = `misc` & ~4 WHERE `zoneid` IN (5, 7, 24, 25, 111, 112, 113, 122, 126, 127, 128) AND (`misc` & 4) <> 0;

-- Dynamis Zones
UPDATE `zone_settings` SET `misc` = `misc` | 256 WHERE `name` LIKE "Dynamis%" AND `name` NOT LIKE "Dynamis_%_[D]" AND ((`misc` & 256) = 0); -- Adds zonewide loot pool if it does not have it
UPDATE `zone_settings` SET `misc` = `misc` & ~8 WHERE (name = "Dynamis-San_dOria" OR name = "Dynamis-Windurst" OR name = "Dynamis-Bastok" OR name = "Dynamis-Jeuno" OR name = "Dynamis-Tavnazia") AND (`misc` & 8) = 8;

UNLOCK TABLES;
