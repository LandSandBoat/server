-- --------------------------------------------------------
-- AirSkyBoat Database Conversion File
-- Moves NPC locations back to era location.
-- --------------------------------------------------------

LOCK TABLES `npc_list` WRITE;

--Fei'yin WHM AF3 Fight. https://ffxiclopedia.fandom.com/wiki/Pieuje%27s_Decision?direction=next&oldid=23449
UPDATE npc_list SET pos_x = 173.143, pos_y = -24.016, pos_z = -81.385 WHERE npcid = "17613245";
