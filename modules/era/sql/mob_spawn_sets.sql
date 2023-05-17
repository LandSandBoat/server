-- --------------------------------------------------------
-- AirSkyBoat Database Conversion File
-- --------------------------------------------------------
-- Adds spawnsets columns to mob_spawn_sets so that
-- server can launch properly if not using the custom
-- mob spawn points in custom/sql/mob_zones
-- 
-- --------------------------------------------------------

ALTER TABLE `mob_spawn_points`
    ADD COLUMN IF NOT EXISTS `spawnset` tinyint(3) DEFAULT 0 AFTER `mobid`;
