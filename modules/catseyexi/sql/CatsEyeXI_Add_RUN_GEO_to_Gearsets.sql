# RUN job code: 2097152

# Allow RUN to equip Homam gear
UPDATE item_equipment SET jobs = "2138336" WHERE name = "homam_corazza";
UPDATE item_equipment SET jobs = "2138336" WHERE name = "homam_manopolas";
UPDATE item_equipment SET jobs = "2138336" WHERE name = "homam_zucchetto";
UPDATE item_equipment SET jobs = "2138336" WHERE name = "homam_cosciales";
UPDATE item_equipment SET jobs = "2138336" WHERE name = "homam_gambieras";

# Allow RUN to equip Ares gear
UPDATE item_equipment SET jobs = "2105537" WHERE name = "ares_cuirass";
UPDATE item_equipment SET jobs = "2105537" WHERE name = "ares_gauntlets";
UPDATE item_equipment SET jobs = "2105537" WHERE name = "ares_flanchard";
UPDATE item_equipment SET jobs = "2105537" WHERE name = "ares_sollerets";
UPDATE item_equipment SET jobs = "2105537" WHERE name = "ares_mask";

# Allow GEO to equip Nashira gear
UPDATE item_equipment SET jobs = "1097756" WHERE name = "nashira_manteel";
UPDATE item_equipment SET jobs = "1097756" WHERE name = "nashira_gages";
UPDATE item_equipment SET jobs = "1097756" WHERE name = "nashira_turban";
UPDATE item_equipment SET jobs = "1097756" WHERE name = "nashira_seraweels";
UPDATE item_equipment SET jobs = "1097756" WHERE name = "nashira_crackows";

# Allow GEO to equip Morrigan gear
UPDATE item_equipment SET jobs = "1081368" WHERE name = "morrigans_robe";
UPDATE item_equipment SET jobs = "1081368" WHERE name = "morrigans_cuffs";
UPDATE item_equipment SET jobs = "1081368" WHERE name = "morrigans_slops";
UPDATE item_equipment SET jobs = "1081368" WHERE name = "morrigans_pgch.";
UPDATE item_equipment SET jobs = "1081368" WHERE name = "morrigans_coron.";

# Allow RUN to equip Ragnarok
UPDATE item_equipment SET jobs = "2097345" WHERE name = "ragnarok" and itemId = "18282";

# Remove existing item_mods on Geomancy Set (GEO Artifact)
DELETE from item_mods WHERE itemId = "27786";
DELETE from item_mods WHERE itemId = "27926";
DELETE from item_mods WHERE itemId = "28066";
DELETE from item_mods WHERE itemId = "28206";
DELETE from item_mods WHERE itemId = "28346";

# Remove existing item_mods on Bugua Set (GEO Relic)
DELETE from item_mods WHERE itemId = "26664";
DELETE from item_mods WHERE itemId = "26840";
DELETE from item_mods WHERE itemId = "27016";
DELETE from item_mods WHERE itemId = "27192";
DELETE from item_mods WHERE itemId = "27368";

# Remove existing item_mods on Runeist Set (RUN Artifact)
DELETE from item_mods WHERE itemId = "27787";
DELETE from item_mods WHERE itemId = "27927";
DELETE from item_mods WHERE itemId = "28067";
DELETE from item_mods WHERE itemId = "28207";
DELETE from item_mods WHERE itemId = "28347";

# Remove existing item_mods on Runeist Set (RUN Relic)
DELETE from item_mods WHERE itemId = "26666";
DELETE from item_mods WHERE itemId = "26842";
DELETE from item_mods WHERE itemId = "27018";
DELETE from item_mods WHERE itemId = "27194";
DELETE from item_mods WHERE itemId = "27370";

# Geomancy Galero
UPDATE item_equipment SET level = "75", ilevel = "0" WHERE itemId = "27786";
INSERT into item_mods VALUES (27786,1,22); -- DEF: 22
INSERT into item_mods VALUES (27786,5,25); -- MP+25
INSERT into item_mods VALUES (27786,12,5); -- INT+5
INSERT into item_mods VALUES (27786,115,15); -- Elemental Magic Skill +15
-- INSERT into item_mods VALUES (27786,959,22); -- Enhances "Cardinal Chant" Effect

# Geomancy Tunic
UPDATE item_equipment SET level = "75", ilevel = "0" WHERE itemId = "27926";
INSERT into item_mods VALUES (27926,1,40); -- DEF: 40
INSERT into item_mods VALUES (27926,5,35); -- MP+35
INSERT into item_mods VALUES (27926,116,12); -- Dark magic skill +12
INSERT into item_mods VALUES (27926,1029,10); -- Enhances "Life Cycle" effect
INSERT into item_mods VALUES (27926,71,5); -- MP recovered while healing +5

# Geomancy Mitaines
UPDATE item_equipment SET level = "75", ilevel = "0" WHERE itemId = "28066";
INSERT into item_mods VALUES (28066,1,15); -- DEF: 15
INSERT into item_mods VALUES (28066,5,16); -- MP+16
INSERT into item_mods VALUES (28066,12,3); -- INT+3
INSERT into item_mods VALUES (28066,13,4); -- MND+4
INSERT into item_mods VALUES (28066,123,15); -- Geomancy skill +15
INSERT into item_mods VALUES (28066,990,22); -- Luopan: (Physical) Damage taken -6% -- No specific mod currently exists for this.

# Geomancy Pants
UPDATE item_equipment SET level = "75", ilevel = "0" WHERE itemId = "28206";
INSERT into item_mods VALUES (28206,1,30); -- DEF: 30
INSERT into item_mods VALUES (28206,5,20); -- MP+20
INSERT into item_mods VALUES (28206,170,10); -- Enhances "Fast Cast" effect +10%
INSERT into item_mods VALUES (28206,168,15); -- Spell interruption rate down 15%

# Geomancy Sandals
UPDATE item_equipment SET level = "75", ilevel = "0" WHERE itemId = "28346";
INSERT into item_mods VALUES (28346,1,12); -- DEF: 12
INSERT into item_mods VALUES (28346,5,15); -- MP+15
INSERT into item_mods VALUES (28346,11,5); -- AGI+5
INSERT into item_mods VALUES (28346,14,5); -- CHR+5
INSERT into item_mods VALUES (28346,169,12); -- Movement speed +12%

# Bagua Galero
UPDATE item_equipment SET level = "75", ilevel = "0" WHERE itemId = "26664";
INSERT into item_mods VALUES (26664,1,25); -- DEF: 25
INSERT into item_mods VALUES (26664,5,25); -- MP+25
INSERT into item_mods VALUES (26664,12,3); -- INT+3
INSERT into item_mods VALUES (26664,13,3); -- MND+3
INSERT into item_mods VALUES (26664,315,10); -- “Drain” and “Aspir” potency +10

# Bagua Tunic
UPDATE item_equipment SET level = "75", ilevel = "0" WHERE itemId = "26840";
INSERT into item_mods VALUES (26840,1,43); -- DEF: 43
INSERT into item_mods VALUES (26840,2,15); -- HP+15
INSERT into item_mods VALUES (26840,5,15); -- MP+15
INSERT into item_mods VALUES (26840,28,5); -- “Magic Attack Bonus” +5
INSERT into item_mods VALUES (26840,123,10); -- Geomancy skill +10

# Bagua Mitaines
UPDATE item_equipment SET level = "75", ilevel = "0" WHERE itemId = "27016";
INSERT into item_mods VALUES (27016,1,17); -- DEF: 17
INSERT into item_mods VALUES (27016,5,21); -- MP+21
INSERT into item_mods VALUES (27016,369,1); -- “Refresh + 1”
INSERT into item_mods VALUES (27016,901,6); -- Elemental Magic casting time -6%

# Bagua Pants
UPDATE item_equipment SET level = "75", ilevel = "0" WHERE itemId = "27192";
INSERT into item_mods VALUES (27192,1,31); -- DEF: 31
INSERT into item_mods VALUES (27192,5,20); -- MP+20
INSERT into item_mods VALUES (27192,12,5); -- INT+5
INSERT into item_mods VALUES (27192,13,5); -- MND+5
INSERT into item_mods VALUES (27192,960,12); -- “Indicolure” spell duration + 12

# Bagua Sandals
UPDATE item_equipment SET level = "75", ilevel = "0" WHERE itemId = "27368";
INSERT into item_mods VALUES (27368,1,16); -- DEF: 16
INSERT into item_mods VALUES (27368,5,18); -- MP+18
INSERT into item_mods VALUES (27368,13,3); -- MND+3
INSERT into item_mods VALUES (27368,114,12); -- Enfeebling magic skill +12
-- INSERT into item_mods VALUES (27368,1,22); -- Luopan: “Regen”+2 (This doesn't exist)

# Runeist Bandeau
UPDATE item_equipment SET level = "75", ilevel = "0" WHERE itemId = "27787";
INSERT into item_mods VALUES (27787,1,27); -- DEF: 27
INSERT into item_mods VALUES (27787,2,21); -- HP+21
INSERT into item_mods VALUES (27787,9,5); -- DEX+5
INSERT into item_mods VALUES (27787,370,3); -- "Regen" +3
INSERT into item_mods VALUES (27787,161,3); -- Physical damage taken -3%

# Runeist Coat
UPDATE item_equipment SET level = "75", ilevel = "0" WHERE itemId = "27927";
INSERT into item_mods VALUES (27927,1,50); -- DEF: 50
INSERT into item_mods VALUES (27927,2,20); -- HP+20
INSERT into item_mods VALUES (27927,5,20); -- MP+20
INSERT into item_mods VALUES (27927,8,5); -- STR+5
INSERT into item_mods VALUES (27927,10,5); -- VIT+5
INSERT INTO item_mods VALUES (27927,15,20);  -- FIRE_RES: 20
INSERT INTO item_mods VALUES (27927,16,20);  -- ICE_RES: 20
INSERT INTO item_mods VALUES (27927,17,20);  -- WIND_RES: 20
INSERT INTO item_mods VALUES (27927,18,20);  -- EARTH_RES: 20
INSERT INTO item_mods VALUES (27927,19,20);  -- THUNDER_RES: 20
INSERT INTO item_mods VALUES (27927,20,20);  -- WATER_RES: 20
INSERT INTO item_mods VALUES (27927,21,20);  -- LIGHT_RES: 20
INSERT INTO item_mods VALUES (27927,22,20);  -- DARK_RES: 20
INSERT into item_mods VALUES (27927,1010,10); -- Enhances "Valiance" and "Vallation" effects

# Runeist Mitons
UPDATE item_equipment SET level = "75", ilevel = "0" WHERE itemId = "28067";
INSERT into item_mods VALUES (28067,1,21); -- DEF: 21
INSERT into item_mods VALUES (28067,5,22); -- MP+22
INSERT into item_mods VALUES (28067,10,3); -- VIT+3
INSERT into item_mods VALUES (28067,9,3); -- DEX+3
INSERT into item_mods VALUES (28067,369,1); -- "Refresh" +1
INSERT into item_mods VALUES (28067,1018,10); -- Ennhances "Gambit" Effect

# Runeist Trousers
UPDATE item_equipment SET level = "75", ilevel = "0" WHERE itemId = "28207";
INSERT into item_mods VALUES (28207,1,40); -- DEF: 40
INSERT into item_mods VALUES (28207,2,15); -- HP+15
INSERT into item_mods VALUES (28207,5,15); -- MP+15
INSERT into item_mods VALUES (28207,8,7); -- STR+7
INSERT into item_mods VALUES (28207,27,5); -- Enmity+5
INSERT into item_mods VALUES (28207,160,3); -- Damage taken -3%

# Runeist Bottes
UPDATE item_equipment SET level = "75", ilevel = "0" WHERE itemId = "28347";
INSERT into item_mods VALUES (28347,1,18); -- DEF: 18
INSERT into item_mods VALUES (28347,2,18); -- HP+18
INSERT into item_mods VALUES (28347,10,6); -- VIT+6
INSERT into item_mods VALUES (28347,29,2); -- Magic def. bonus +2
INSERT into item_mods VALUES (28347,1011,10); -- Enhances "Pflug" effect

# Futhark Bandeau
UPDATE item_equipment SET level = "75", ilevel = "0" WHERE itemId = "26666";
INSERT into item_mods VALUES (26666,1,28); -- DEF: 28
INSERT into item_mods VALUES (26666,2,11); -- HP+11
INSERT into item_mods VALUES (26666,5,11); -- MP+11
INSERT into item_mods VALUES (26666,8,6); -- STR+6
INSERT into item_mods VALUES (26666,384,3); -- Haste +3%
INSERT into item_mods VALUES (26666,1004,10); -- Enhances "Battuta" effect

# Futhark Coat
UPDATE item_equipment SET level = "75", ilevel = "0" WHERE itemId = "26842";
INSERT into item_mods VALUES (26842,1,52); -- DEF: 52
INSERT into item_mods VALUES (26842,2,15); -- HP+15
INSERT into item_mods VALUES (26842,5,15); -- MP+15
INSERT into item_mods VALUES (26842,8,7); -- STR+7
INSERT into item_mods VALUES (26842,10,7); -- VIT+7
INSERT into item_mods VALUES (26842,31,9); -- Magic Evasion +9
INSERT into item_mods VALUES (26842,516,5); -- Converts 5% of physical damage taken to MP

# Futhark Mitons
UPDATE item_equipment SET level = "75", ilevel = "0" WHERE itemId = "27018";
INSERT into item_mods VALUES (27018,1,20); -- DEF: 20
INSERT into item_mods VALUES (27018,2,17); -- HP+17
INSERT into item_mods VALUES (27018,9,7); -- DEX+7
INSERT into item_mods VALUES (27018,1008,3); -- "Swordplay" +3
INSERT into item_mods VALUES (27018,1006,10); -- Enhances "Sleight of Sword" effect

# Futhark Trousers
UPDATE item_equipment SET level = "75", ilevel = "0" WHERE itemId = "27194";
INSERT into item_mods VALUES (27194,1,41); -- DEF: 41
INSERT into item_mods VALUES (27194,2,20); -- HP+20
INSERT into item_mods VALUES (27194,5,20); -- MP+20
INSERT into item_mods VALUES (27194,10,7); -- VIT+7
INSERT into item_mods VALUES (27194,9,7); -- DEX+7
INSERT into item_mods VALUES (27194,890,10); -- Enhancing magic duration +10
INSERT into item_mods VALUES (27194,1007,10); -- Enhances "Inspiration" effect

# Futhark Bottes
UPDATE item_equipment SET level = "75", ilevel = "0" WHERE itemId = "27370";
INSERT into item_mods VALUES (27370,1,19); -- DEF: 19
INSERT into item_mods VALUES (27370,5,21); -- MP+21
INSERT into item_mods VALUES (27370,8,5); -- STR+5
INSERT into item_mods VALUES (27370,9,5); -- DEX+5
INSERT into item_mods VALUES (27370,384,4); -- Haste +4%
INSERT into item_mods VALUES (27370,110,15); -- Parrying skill +15