------------------------------------
-- Seekers of Adoulin Weaponskill SQL Adjustments
-- This module reverts relevant SQL tables for weaponskills to their pre-SoA values
-- https://www.bg-wiki.com/ffxi/Version_Update_(05/15/2012) - May 15th, 2012 (Ranged WS Adjustments)
-- https://forum.square-enix.com/ffxi/threads/31310 - March 27th, 2013 (PUP added to Asuran Fists)
-- https://forum.square-enix.com/ffxi/archive/index.php/t-46531.html - March 26th, 2015 (RDM added to Red Lotus Blade, Seraph Blade, Vorpal Blade)
------------------------------------

-- Archery Weaponskills: Revert range from 20 to 15 yalms
UPDATE weapon_skills SET `range` = 15 WHERE `name` IN (
    'flaming_arrow',
    'piercing_arrow',
    'dulling_arrow',
    'sidewinder',
    'arching_arrow',
    'empyreal_arrow',
    'namas_arrow',
    'refulgent_arrow',
    'jishnus_radiance',
    'apex_arrow'
);

-- Marksmanship Weaponskills: Revert range from 20 to 15 yalms
UPDATE weapon_skills SET `range` = 15 WHERE `name` IN (
    'hot_shot',
    'split_shot',
    'sniper_shot',
    'slug_shot',
    'heavy_shot',
    'detonator',
    'coronach',
    'trueflight',
    'leaden_salute',
    'wildfire',
    'last_stand'
);

-- Remove Asuran Fists for PUP
UPDATE `weapon_skills` SET `jobs` = INSERT(`jobs`, 18, 1, 0x00) WHERE `name` = 'asuran_fists';

-- Remove Red Lotus Blade, Seraph Blade, Vorpal Blade for RDM
UPDATE `weapon_skills` SET `jobs` = INSERT(`jobs`, 5, 1, 0x00) WHERE `name` = 'red_lotus_blade';
UPDATE `weapon_skills` SET `jobs` = INSERT(`jobs`, 5, 1, 0x00) WHERE `name` = 'seraph_blade';
UPDATE `weapon_skills` SET `jobs` = INSERT(`jobs`, 5, 1, 0x00) WHERE `name` = 'vorpal_blade';
