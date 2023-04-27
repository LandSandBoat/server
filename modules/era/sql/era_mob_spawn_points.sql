-- --------------------------------------------------------
-- AirSkyBoat Database Conversion File
-- Moves Mob Spawn locations back to era location.
-- --------------------------------------------------------

LOCK TABLES `mob_spawn_points` WRITE;

--Fei'yin WHM AF3 Fight. https://ffxiclopedia.fandom.com/wiki/Pieuje%27s_Decision?direction=next&oldid=23449
UPDATE mob_spawn_points set pos_x = 173.143, pos_y = -24.016, pos_z = -81.385 WHERE mobid = "17612836";
