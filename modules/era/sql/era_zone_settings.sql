LOCK TABLES `zone_settings` WRITE;

ALTER TABLE `zone_settings`
    ADD COLUMN IF NOT EXISTS `updatedmesh` tinyint(1) unsigned NOT NULL DEFAULT '0' AFTER `misc`,
    ADD COLUMN IF NOT EXISTS `forcecarefulpathing` tinyint(1) unsigned NOT NULL DEFAULT '0' AFTER `updatedmesh`;

UNLOCK TABLES;
