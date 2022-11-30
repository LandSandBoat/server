-- ------------------------------------------------------------------------ --
--  Module to add Starlight Decorations to Jeuno, Additional Seasonal NPCs  --
-- ------------------------------------------------------------------------ --


-- ------------------------------------------------------------
-- Port Jeuno (Zone 246)
-- ------------------------------------------------------------

UPDATE zone_settings SET music_day=239 WHERE name='Port_Jeuno' AND zoneid='246';
UPDATE zone_settings SET music_night=239 WHERE name='Port_Jeuno' AND zoneid='246';

-- ------------------------------------------------------------
-- Lower Jeuno (Zone 245)
-- ------------------------------------------------------------

UPDATE zone_settings SET music_day=239 WHERE name='Lower_Jeuno' AND zoneid='245';
UPDATE zone_settings SET music_night=239 WHERE name='Lower_Jeuno' AND zoneid='245';

-- ------------------------------------------------------------
-- Upper Jeuno (Zone 244)
-- ------------------------------------------------------------

UPDATE zone_settings SET music_day=239 WHERE name='Upper_Jeuno' AND zoneid='244';
UPDATE zone_settings SET music_night=239 WHERE name='Upper_Jeuno' AND zoneid='244';
