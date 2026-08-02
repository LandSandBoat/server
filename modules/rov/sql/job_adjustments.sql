------------------------------------
-- Rhapsodies of Vana'diel Job SQL Adjustments
-- This module reverts relevant SQL tables for jobs to their pre-RoV values
------------------------------------

------------------------------------
-- Monk
-- Source: https://forum.square-enix.com/ffxi/threads/52969
------------------------------------

-- Boost: Revert recast from 60 to 15 seconds
UPDATE abilities SET recastTime = 15 WHERE name = 'boost';

-- Focus: Revert recast from 2 to 5 minutes
UPDATE abilities SET recastTime = 300 WHERE name = 'focus';

-- Dodge: Revert recast from 2 to 5 minutes
UPDATE abilities SET recastTime = 300 WHERE name = 'dodge';

-- Chakra: Revert recast from 3 to 5 minutes
UPDATE abilities SET recastTime = 300 WHERE name = 'chakra';

-- Max HP Boost: Revert trait levels to 35/55/70
UPDATE traits SET level = 35 WHERE name = 'max hp boost' AND job = 2 AND rank = 2;
UPDATE traits SET level = 55 WHERE name = 'max hp boost' AND job = 2 AND rank = 3;
UPDATE traits SET level = 70 WHERE name = 'max hp boost' AND job = 2 AND rank = 4;

------------------------------------
-- White Mage
-- Source: https://forum.square-enix.com/ffxi/threads/46531-Mar-26-2015-%28JST%29-Version-Update
------------------------------------

------------------------------------
-- Paladin
------------------------------------

-- Rampart: Revert recast from 3 to 5 minutes
-- Source: https://forum.square-enix.com/ffxi/threads/56444-February-12-2020-%28JST%29-Version-Update
UPDATE abilities SET recastTime = 300 WHERE name = 'rampart';

------------------------------------
-- Ranger
------------------------------------

-- Velocity Shot: Revert recast from 1 minute to 5 minutes
-- Source: https://forum.square-enix.com/ffxi/threads/55263-April.-3-2019-%28JST%29-Version-Update
UPDATE abilities SET recastTime = 300 WHERE name = 'velocity_shot';

-- Archery and Marksmanship: Revert skill rank increase from A+ to A.
-- Source: https://forum.square-enix.com/ffxi/threads/47481-Jun-25-2015-%28JST%29-Version-Update
UPDATE skill_ranks SET rng = 2 WHERE name = 'archery';
UPDATE skill_ranks SET rng = 2 WHERE name = 'marksmanship';

------------------------------------
-- Dragoon
-- Source: https://forum.square-enix.com/ffxi/threads/54901-January.-10-2019-%28JST%29-Version-Update
------------------------------------

-- Jump / Spirit Jump: Revert to share a cooldown
UPDATE abilities SET recastId = 158 WHERE name = 'jump';
UPDATE abilities SET recastId = 158 WHERE name = 'spirit_jump';

-- High Jump / Soul Jump: Revert to share a cooldown
UPDATE abilities SET recastId = 159 WHERE name = 'high_jump';
UPDATE abilities SET recastId = 159 WHERE name = 'soul_jump';

------------------------------------
-- Summoner
------------------------------------

-- Bloodpact: Ward AoE skills: Revert radius from 14 to 10
-- TODO: Could use more verification on exact range value
-- Source: https://forum.square-enix.com/ffxi/threads/46531-Mar-26-2015-%28JST%29-Version-Update
UPDATE pet_skills SET pet_skill_radius = 10 WHERE pet_skill_name IN (
    'shining_ruby',
    'glittering_ruby',
    'healing_ruby_ii',
    'soothing_ruby',
    'ecliptic_growl',
    'ecliptic_howl',
    'heavenward_howl',
    'crimson_howl',
    'inferno_howl',
    'earthen_ward',
    'spring_water',
    'soothing_current',
    'whispering_wind',
    'hastega',
    'aerial_armor',
    'fleet_wind',
    'hastega_ii',
    'frost_armor',
    'crystal_blessing',
    'rolling_thunder',
    'lightning_armor',
    'noctoshield',
    'dream_shroud'
);
