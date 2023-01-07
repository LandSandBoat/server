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
UPDATE `zone_settings` SET `misc` = 2200 WHERE `zoneid` = 5;   -- Uleguerand Range
UPDATE `zone_settings` SET `misc` = 2200 WHERE `zoneid` = 7;   -- Attohwa Chasm
UPDATE `zone_settings` SET `misc` = 2200 WHERE `zoneid` = 24;  -- Lufaise Meadows
UPDATE `zone_settings` SET `misc` = 2200 WHERE `zoneid` = 25;  -- Misareaux Coast
UPDATE `zone_settings` SET `misc` = 2200 WHERE `zoneid` = 111; -- Beaucedine Glacier
UPDATE `zone_settings` SET `misc` = 2200 WHERE `zoneid` = 112; -- Xarcabard
UPDATE `zone_settings` SET `misc` = 2200 WHERE `zoneid` = 113; -- Cape Teriggan
UPDATE `zone_settings` SET `misc` = 2200 WHERE `zoneid` = 122; -- Ro'Maeve
UPDATE `zone_settings` SET `misc` = 2200 WHERE `zoneid` = 126; -- Qufim Island
UPDATE `zone_settings` SET `misc` = 2200 WHERE `zoneid` = 127; -- Behemoth's Dominion
UPDATE `zone_settings` SET `misc` = 2200 WHERE `zoneid` = 128; -- Valley of Sorrows

UNLOCK TABLES;
