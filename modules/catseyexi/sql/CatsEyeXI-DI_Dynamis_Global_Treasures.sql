# Delete all mobs from Escha_RuAun
DELETE FROM mob_groups WHERE zoneid = "289";

# Remove NPC's from entrance (just in case)
DELETE FROM npc_list WHERE npcid = "17961710";
DELETE FROM npc_list WHERE npcid = "17961711";
DELETE FROM npc_list WHERE npcid = "17961697";
DELETE FROM npc_list WHERE npcid = "17961712";

# Allow trusts & set global treasure pool
UPDATE zone_settings SET misc = '2520' WHERE name = 'Escha_RuAun';
UPDATE zone_settings SET misc = '2520' WHERE name = 'Reisenjima_Henge';
UPDATE zone_settings SET misc = '2520' WHERE name = 'Provenance';
UPDATE zone_settings SET misc = '2520' WHERE name = 'Dynamis-Valkurm';
UPDATE zone_settings SET misc = '2520' WHERE name = 'Dynamis-Buburimu';
UPDATE zone_settings SET misc = '2520' WHERE name = 'Dynamis-Qufim';
UPDATE zone_settings SET misc = '2520' WHERE name = 'Dynamis-Tavnazia';
UPDATE zone_settings SET misc = '2520' WHERE name = 'Dynamis-Beaucedine';
UPDATE zone_settings SET misc = '2520' WHERE name = 'Dynamis-Xarcabard';
UPDATE zone_settings SET misc = '2520' WHERE name = 'Dynamis-San_dOria';
UPDATE zone_settings SET misc = '2520' WHERE name = 'Dynamis-Bastok';
UPDATE zone_settings SET misc = '2520' WHERE name = 'Dynamis-Windurst';
UPDATE zone_settings SET misc = '2520' WHERE name = 'Dynamis-Jeuno';

-- Amphisbaena -- Skill_List_ID 817
REPLACE INTO `mob_groups` (`groupid`, `poolid`, `zoneid`, `name`, `respawntime`, `spawntype`, `dropid`, `HP`, `MP`, `minLevel`, `maxLevel`, `allegiance`) VALUES (43, 1872, 132, 'Hadhayosh', 0, 128, 1268, 20000, 9999, 150, 150, 0);

-- Tortuga Use Skill_List_ID 277 Spell_list_ID 24
REPLACE INTO `mob_groups` (`groupid`, `poolid`, `zoneid`, `name`, `respawntime`, `spawntype`, `dropid`, `HP`, `MP`, `minLevel`, `maxLevel`, `allegiance`) VALUES (79, 5695, 289, 'Genbu-Escha', 0, 128, 0, 22500, 25000, 150, 150, 0);

-- Battosai Use Skill_List_ID 313
REPLACE INTO `mob_groups` (`groupid`, `poolid`, `zoneid`, `name`, `respawntime`, `spawntype`, `dropid`, `HP`, `MP`, `minLevel`, `maxLevel`, `allegiance`) VALUES (54, 2018, 73, 'Hydra', 0, 128, 0, 25000, 25000, 150, 150, 0);

-- Bahamut
REPLACE INTO mob_groups (groupid, poolid, zoneid, name, respawntime, spawntype, dropid, HP, MP, minLevel, maxLevel, allegiance) VALUES (17, 325, 29, 'Bahamut', 0, 128, 0, 35000, 15000, 100, 100, 0);