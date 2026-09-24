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

-- Avatar Bloodpact Prepare Times
-- https://wiki.ffo.jp/html/32936.html

-- Carbuncle
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'healing_ruby';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'poison_nails';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'shining_ruby';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'glittering_ruby';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'meteorite';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'healing_ruby_ii';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'searing_light';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'soothing_ruby';

-- Fenrir
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'moonlit_charge';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'crescent_fang';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'lunar_cry';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'lunar_roar';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'ecliptic_growl';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'ecliptic_howl';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'eclipse_bite';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'howling_moon';

-- Ifrit
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'punch';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'fire_ii';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'burning_strike';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'double_punch';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'crimson_howl';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'fire_iv';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'flaming_crush';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'meteor_strike';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'inferno';

-- Titan
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'rock_throw';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'stone_ii';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'rock_buster';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'megalith_throw';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'earthen_ward';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'stone_iv';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'mountain_buster';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'geocrush';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'earthen_fury';

-- Leviathan
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'barracuda_dive';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'water_ii';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'tail_whip';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'spring_water';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'slowga';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'water_iv';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'spinning_dive';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'grand_fall';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'tidal_wave';

-- Garuda
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'claw';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'aero_ii';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'whispering_wind';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'hastega';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'aerial_armor';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'aero_iv';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'predator_claws';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'wind_blade';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'aerial_blast';

-- Shiva
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'axe_kick';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'blizzard_ii';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'frost_armor';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'sleepga';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'double_slap';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'blizzard_iv';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'rush';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'heavenly_strike';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'diamond_dust';

-- Ramuh
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'shock_strike';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'thunder_ii';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'rolling_thunder';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'thunderspark';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'lightning_armor';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'thunder_iv';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'chaotic_strike';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'thunderstorm';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'judgment_bolt';

-- Diabolos
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'camisado';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'somnolence';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'nightmare';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'ultimate_terror';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'noctoshield';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'dream_shroud';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'nether_blast';
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name = 'ruinous_omen';
