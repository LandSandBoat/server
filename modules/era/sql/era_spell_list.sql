LOCK TABLES `spell_list`       WRITE;

ALTER TABLE `spell_List`
    ADD COLUMN IF NOT EXISTS `spell_radius_type` tinyint(1) unsigned NOT NULL DEFAULT 0 AFTER `spell_radius`;

UNLOCK TABLES;