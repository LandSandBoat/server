------------------------------------
-- Seekers of Adoulin Job SQL Adjustments
-- This module reverts relevant SQL tables for jobs to their pre-SoA values
------------------------------------

------------------------------------
-- Thief
-- Source : https://forum.square-enix.com/ffxi/threads/43706-Aug-12-2014-%28JST%29-Version-Update
------------------------------------

-- Mug: Revert cooldown from 5 minutes to 15 minutes
UPDATE abilities SET recastTime = 900 WHERE name = 'mug';

------------------------------------
-- Dark Knight
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(04/29/2013)
------------------------------------

-- Desperate Blows: Revert job trait to be merit unlocked
UPDATE traits SET meritid = 2502, level = 75 WHERE name = 'desperate blows';

------------------------------------
-- Beastmaster
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(04/29/2013)
------------------------------------

-- Sic: Revert recast from 1 1/2 min to 2 min
UPDATE abilities SET recastTime = 120 WHERE name = 'sic';

-- Ready: Revert charge recast from 30 to 60 seconds
UPDATE abilities SET recastTime = 60 WHERE name = 'ready';

-- Sic merit: Revert value from 2 to 4 seconds per level
UPDATE merits SET value = 4 WHERE name = 'sic_recast';

------------------------------------
-- Ranger
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(04/29/2013)
------------------------------------

-- Scavenge: Revert recast from 3 to 5 minutes
UPDATE abilities SET recastTime = 300 WHERE name = 'scavenge';

-- Scavenge merit: Revert value from increase effect per level to 10 seconds per level
UPDATE merits SET value = 10 WHERE name = 'scavenge';

-----------------------------------
-- Ninja
-- Source: https://forum.square-enix.com/ffxi/threads/44592-Oct-7-2014-%28JST%29-Version-Update
-----------------------------------

-- Sange: Revert recast from 5 to 15 minutes
UPDATE abilities SET recastTime = 900 WHERE name = 'sange';

-- Sange merit: Revert value from 25 ranged accuracy to 150 seconds recast reduction
UPDATE merits SET value = 150 WHERE name = 'sange';

------------------------------------
-- Dragoon
-- Source: https://forum.square-enix.com/ffxi/threads/44090-Sep-9-2014-%28JST%29-Version-Update
------------------------------------

-- Strafe: Revert from level based trait to merit unlocked at 75
UPDATE traits SET meritid = 2886, level = 75, value = 0 WHERE name = 'strafe';

-- Strafe merit: Revert value from 10 to 5 per upgrade
UPDATE merits SET value = 5 WHERE name = 'strafe_effect';

-- Wyvern Breath: Revert activation time from 1 second to 3 seconds
-- TODO: Revert skill prepare animation to display skill ready spikes
UPDATE pet_skills SET pet_prepare_time = 3000 WHERE pet_skill_name IN (
    'healing_breath',
    'healing_breath_ii',
    'healing_breath_iii',
    'healing_breath_iv',
    'remove_poison',
    'remove_blindness',
    'remove_paralysis',
    'remove_curse',
    'remove_disease',
    'flame_breath',
    'frost_breath',
    'gust_breath',
    'sand_breath',
    'lightning_breath',
    'hydro_breath'
);
