ALTER TABLE `mob_resistances`
    ADD COLUMN IF NOT EXISTS `fire_eem` smallint DEFAULT 100 AFTER `dark_res_rank`;

ALTER TABLE `mob_resistances`
    ADD COLUMN IF NOT EXISTS `ice_eem` smallint DEFAULT 100 AFTER `fire_eem`;

ALTER TABLE `mob_resistances`
    ADD COLUMN IF NOT EXISTS `wind_eem` smallint DEFAULT 100 AFTER `ice_eem`;

ALTER TABLE `mob_resistances`
    ADD COLUMN IF NOT EXISTS `earth_eem` smallint DEFAULT 100 AFTER `wind_eem`;

ALTER TABLE `mob_resistances`
    ADD COLUMN IF NOT EXISTS `lightning_eem` smallint DEFAULT 100 AFTER `earth_eem`;

ALTER TABLE `mob_resistances`
    ADD COLUMN IF NOT EXISTS `water_eem` smallint DEFAULT 100 AFTER `lightning_eem`;

ALTER TABLE `mob_resistances`
    ADD COLUMN IF NOT EXISTS `light_eem` smallint DEFAULT 100 AFTER `water_eem`;

ALTER TABLE `mob_resistances`
    ADD COLUMN IF NOT EXISTS `dark_eem` smallint DEFAULT 100 AFTER `light_eem`;