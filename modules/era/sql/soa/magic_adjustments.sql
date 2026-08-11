------------------------------------
-- Seekers of Adoulin Job SQL Adjustments
-- This module reverts relevant SQL tables for jobs to their pre-Abyssea values
------------------------------------
-- Source : https://forum.square-enix.com/ffxi/threads/35228-July-9-2013-%28JST%29-Version-Update
------------------------------------

------------------------------------
-- Elemental Magic Adjustments (RDM / BLM / SCH related)
-- Reverts MP cost, cast time, and recast time for Tier I-IV elemental nukes, Tier I-III -ga nukes, and Ancient Magic I & II
------------------------------------

-- Earth
UPDATE spell_list SET mpCost = 9,   castTime = 1500,  recastTime = 6500  WHERE name = 'stone';
UPDATE spell_list SET mpCost = 43,  castTime = 3250,  recastTime = 14500 WHERE name = 'stone_ii';
UPDATE spell_list SET mpCost = 92,  castTime = 5250,  recastTime = 22500 WHERE name = 'stone_iii';
UPDATE spell_list SET mpCost = 138, castTime = 7000,  recastTime = 30750 WHERE name = 'stone_iv';
UPDATE spell_list SET mpCost = 37,  castTime = 2500,  recastTime = 11000 WHERE name = 'stonega';
UPDATE spell_list SET mpCost = 109, castTime = 4250,  recastTime = 19000 WHERE name = 'stonega_ii';
UPDATE spell_list SET mpCost = 211, castTime = 6250,  recastTime = 27250 WHERE name = 'stonega_iii';
UPDATE spell_list SET mpCost = 337, castTime = 18250, recastTime = 42750 WHERE name = 'quake';
UPDATE spell_list SET mpCost = 287, recastTime = 90000 WHERE name = 'quake_ii';

-- Water
UPDATE spell_list SET mpCost = 13,  castTime = 1750,  recastTime = 7750  WHERE name = 'water';
UPDATE spell_list SET mpCost = 51,  castTime = 3500,  recastTime = 15750 WHERE name = 'water_ii';
UPDATE spell_list SET mpCost = 98,  castTime = 5500,  recastTime = 24000 WHERE name = 'water_iii';
UPDATE spell_list SET mpCost = 144, castTime = 7250,  recastTime = 32000 WHERE name = 'water_iv';
UPDATE spell_list SET mpCost = 47,  castTime = 2750,  recastTime = 12250 WHERE name = 'waterga';
UPDATE spell_list SET mpCost = 123, castTime = 4500,  recastTime = 20250 WHERE name = 'waterga_ii';
UPDATE spell_list SET mpCost = 231, castTime = 6500,  recastTime = 28500 WHERE name = 'waterga_iii';
UPDATE spell_list SET mpCost = 368, castTime = 18750, recastTime = 43750 WHERE name = 'flood';
UPDATE spell_list SET mpCost = 287, recastTime = 90000 WHERE name = 'flood_ii';

-- Wind
UPDATE spell_list SET mpCost = 18,  castTime = 2000,  recastTime = 9000  WHERE name = 'aero';
UPDATE spell_list SET mpCost = 59,  castTime = 3750,  recastTime = 17000 WHERE name = 'aero_ii';
UPDATE spell_list SET mpCost = 106, castTime = 5750,  recastTime = 25250 WHERE name = 'aero_iii';
UPDATE spell_list SET mpCost = 150, castTime = 7500,  recastTime = 33250 WHERE name = 'aero_iv';
UPDATE spell_list SET mpCost = 57,  castTime = 3000,  recastTime = 13500 WHERE name = 'aeroga';
UPDATE spell_list SET mpCost = 138, castTime = 5000,  recastTime = 21750 WHERE name = 'aeroga_ii';
UPDATE spell_list SET mpCost = 252, castTime = 6750,  recastTime = 29750 WHERE name = 'aeroga_iii';
UPDATE spell_list SET mpCost = 322, castTime = 18000, recastTime = 42250 WHERE name = 'tornado';
UPDATE spell_list SET mpCost = 287, recastTime = 90000 WHERE name = 'tornado_ii';

-- Fire
UPDATE spell_list SET mpCost = 24,  castTime = 2250,  recastTime = 10250 WHERE name = 'fire';
UPDATE spell_list SET mpCost = 68,  castTime = 4250,  recastTime = 18500 WHERE name = 'fire_ii';
UPDATE spell_list SET mpCost = 113, castTime = 6000,  recastTime = 26500 WHERE name = 'fire_iii';
UPDATE spell_list SET mpCost = 157, castTime = 8000,  recastTime = 34750 WHERE name = 'fire_iv';
UPDATE spell_list SET mpCost = 71,  castTime = 3500,  recastTime = 15250 WHERE name = 'firaga';
UPDATE spell_list SET mpCost = 158, castTime = 5250,  recastTime = 23250 WHERE name = 'firaga_ii';
UPDATE spell_list SET mpCost = 277, castTime = 7250,  recastTime = 31500 WHERE name = 'firaga_iii';
UPDATE spell_list SET mpCost = 383, castTime = 19000, recastTime = 44500 WHERE name = 'flare';
UPDATE spell_list SET mpCost = 287, recastTime = 90000 WHERE name = 'flare_ii';

-- Ice
UPDATE spell_list SET mpCost = 30,  castTime = 2500,  recastTime = 11500 WHERE name = 'blizzard';
UPDATE spell_list SET mpCost = 77,  castTime = 4500,  recastTime = 19750 WHERE name = 'blizzard_ii';
UPDATE spell_list SET mpCost = 120, castTime = 6250,  recastTime = 27750 WHERE name = 'blizzard_iii';
UPDATE spell_list SET mpCost = 164, castTime = 8250,  recastTime = 36000 WHERE name = 'blizzard_iv';
UPDATE spell_list SET mpCost = 82,  castTime = 3750,  recastTime = 16500 WHERE name = 'blizzaga';
UPDATE spell_list SET mpCost = 175, castTime = 5500,  recastTime = 24500 WHERE name = 'blizzaga_ii';
UPDATE spell_list SET mpCost = 299, castTime = 7500,  recastTime = 32750 WHERE name = 'blizzaga_iii';
UPDATE spell_list SET mpCost = 307, castTime = 17750, recastTime = 41500 WHERE name = 'freeze';
UPDATE spell_list SET mpCost = 287, recastTime = 90000 WHERE name = 'freeze_ii';

-- Thunder
UPDATE spell_list SET mpCost = 37,  castTime = 3000,  recastTime = 13000 WHERE name = 'thunder';
UPDATE spell_list SET mpCost = 86,  castTime = 4750,  recastTime = 21000 WHERE name = 'thunder_ii';
UPDATE spell_list SET mpCost = 128, castTime = 6750,  recastTime = 29250 WHERE name = 'thunder_iii';
UPDATE spell_list SET mpCost = 171, castTime = 8500,  recastTime = 37250 WHERE name = 'thunder_iv';
UPDATE spell_list SET mpCost = 95,  castTime = 4000,  recastTime = 17750 WHERE name = 'thundaga';
UPDATE spell_list SET mpCost = 193, castTime = 6000,  recastTime = 26000 WHERE name = 'thundaga_ii';
UPDATE spell_list SET mpCost = 322, castTime = 7750,  recastTime = 34000 WHERE name = 'thundaga_iii';
UPDATE spell_list SET mpCost = 352, castTime = 18500, recastTime = 43250 WHERE name = 'burst';
UPDATE spell_list SET mpCost = 287, recastTime = 90000 WHERE name = 'burst_ii';
