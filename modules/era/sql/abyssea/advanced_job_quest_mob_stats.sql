-----------------------------------
-- NIN/DRG/SAM Quest Mobs Original Difficulty Module
-- Reverts the nerfs to the NIN/DRG/SAM quest mobs in the May 10, 2011 version update
-- Source: https://forum.square-enix.com/ffxi/threads/7257
-----------------------------------

-- Level: set all six spawns to level 32 (min == max => fixed level)
UPDATE mob_spawn_points SET minLevel = 32, maxLevel = 32 WHERE mobid = 17486187; -- Korroloka Leech (Korroloka Tunnel)
UPDATE mob_spawn_points SET minLevel = 32, maxLevel = 32 WHERE mobid = 17486188; -- Korroloka Leech (Korroloka Tunnel)
UPDATE mob_spawn_points SET minLevel = 32, maxLevel = 32 WHERE mobid = 17486189; -- Korroloka Leech (Korroloka Tunnel)
UPDATE mob_spawn_points SET minLevel = 32, maxLevel = 32 WHERE mobid = 17350928; -- Cyranuce M Cutauleon (Ghelsba Outpost)
UPDATE mob_spawn_points SET minLevel = 32, maxLevel = 32 WHERE mobid = 17219999; -- Forger (Konschtat Highlands)
UPDATE mob_spawn_points SET minLevel = 32, maxLevel = 32 WHERE mobid = 17272838; -- Guardian Treant (The Sanctuary of Zi'Tah)

-- HP: per-group override, keyed by (groupid, zoneid)
UPDATE mob_groups SET HP =  900 WHERE groupid = 28 AND zoneid = 173; -- Korroloka Leech x3 (Korroloka Tunnel)
UPDATE mob_groups SET HP = 2700 WHERE groupid = 26 AND zoneid = 140; -- Cyranuce M Cutauleon (Ghelsba Outpost)
UPDATE mob_groups SET HP = 2000 WHERE groupid = 33 AND zoneid = 108; -- Forger (Konschtat Highlands)
UPDATE mob_groups SET HP = 2000 WHERE groupid =  5 AND zoneid = 121; -- Guardian Treant (The Sanctuary of Zi'Tah)
