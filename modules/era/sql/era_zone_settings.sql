LOCK TABLES `zone_settings` WRITE;

ALTER TABLE `zone_settings`
    ADD COLUMN IF NOT EXISTS `updatedmesh` tinyint(1) unsigned NOT NULL DEFAULT '0' AFTER `misc`,
    ADD COLUMN IF NOT EXISTS `forcecarefulpathing` tinyint(1) unsigned NOT NULL DEFAULT '0' AFTER `updatedmesh`;

UPDATE `zone_settings` SET `updatedmesh` = 1, `forcecarefulpathing` = 1 WHERE `zoneid` = 146;
UPDATE `zone_settings` SET `updatedmesh` = 1, `forcecarefulpathing` = 1 WHERE `zoneid` = 149;
UPDATE `zone_settings` SET `updatedmesh` = 1, `forcecarefulpathing` = 1 WHERE `zoneid` = 185;
UPDATE `zone_settings` SET `updatedmesh` = 1, `forcecarefulpathing` = 1 WHERE `zoneid` = 188;
UPDATE `zone_settings` SET `updatedmesh` = 1, `forcecarefulpathing` = 1 WHERE `zoneid` = 100;
UPDATE `zone_settings` SET `updatedmesh` = 1, `forcecarefulpathing` = 1 WHERE `zoneid` = 101;
UPDATE `zone_settings` SET `updatedmesh` = 1, `forcecarefulpathing` = 1 WHERE `zoneid` = 106;
UPDATE `zone_settings` SET `updatedmesh` = 1, `forcecarefulpathing` = 1 WHERE `zoneid` = 107;
UPDATE `zone_settings` SET `updatedmesh` = 1, `forcecarefulpathing` = 1 WHERE `zoneid` = 115;
UPDATE `zone_settings` SET `updatedmesh` = 1, `forcecarefulpathing` = 1 WHERE `zoneid` = 116;
UPDATE `zone_settings` SET `updatedmesh` = 1, `forcecarefulpathing` = 1 WHERE `zoneid` = 10;
UPDATE `zone_settings` SET `updatedmesh` = 1, `forcecarefulpathing` = 1 WHERE `zoneid` = 139;
UPDATE `zone_settings` SET `updatedmesh` = 1, `forcecarefulpathing` = 1 WHERE `zoneid` = 128;

UNLOCK TABLES;
