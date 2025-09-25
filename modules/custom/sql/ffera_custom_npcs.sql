-- Moves around NPCs that ERA uses

-- Lower Jeuno
--Runga-Kuponga
UPDATE npc_list SET pos_rot = 91, pos_x = 13.000, pos_y = 0.000, pos_z = 7.000, status = 0, look = 0x0000580800000000000000000000000000000000 WHERE npcid = 17780772;

-- Raji
UPDATE npc_list SET pos_rot = 20, pos_x = -26.000, pos_y = 0.000, pos_z = -16.500, look = 0x00008D0100000000000000000000000000000000 WHERE npcid = 17780776;

-- Shomera
UPDATE npc_list SET pos_rot = 243, pos_x = -20.000, pos_y = 0.000, pos_z = -6.000, look = 0x0000BF0600000000000000000000000000000000 WHERE npcid = 17780777;

-- Honorine
UPDATE npc_list SET pos_rot = 133, pos_x = -3.000, pos_y = 0.000, pos_z = -10.000, look = 0x01000A070010E120E1305C415C51006000700000 WHERE npcid = 17780792;

-- Rakuru-Rakoru
UPDATE npc_list SET pos_rot = 22, pos_x = -17.100, pos_y = 0.000, pos_z = 1.500, look = 0x0000CD0700000000000000000000000000000000 WHERE npcid = 17780928;

-- Homepoint #2
UPDATE npc_list SET pos_x = -6.681, pos_y = 0.000, pos_z = -11.259 WHERE npcid = 17780874;

-- Provenance
-- Need to add Provenance Crystal/Protocrystal as well as Pil in here but there are different IDs...?
