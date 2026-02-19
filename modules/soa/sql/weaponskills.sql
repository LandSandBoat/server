------------------------------------
-- Seekers of Adoulin Weaponskill SQL Adjustments
-- This module reverts relevant SQL tables for weaponskills to their pre-SoA values
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(05/15/2012)
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
