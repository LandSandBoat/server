------------------------------------
-- Wings of the Goddess Job SQL Adjustments
-- This module reverts relevant SQL tables for jobs to their pre-WotG values
------------------------------------
-- Source : https://www.bg-wiki.com/ffxi/Version_Update_(04/08/2009)
------------------------------------

------------------------------------
-- White Mage
------------------------------------

-- Banish II: Revert cast time from 2.5 to 3.75 seconds
UPDATE `spell_list` SET `castTime` = 3750 WHERE `name` = 'banish_ii';

-- Banish III: Revert cast time from 3 to 5.5 seconds
UPDATE `spell_list` SET `castTime` = 5500 WHERE `name` = 'banish_iii';

-- Raise II: Revert MP from 150 to 200, cast time from 14 to 20 seconds
UPDATE `spell_list` SET `mpCost` = 200, `castTime` = 20000 WHERE `name` = 'raise_ii';

-- Raise III: Revert MP from 150 to 250, cast time from 13 to 20 seconds
UPDATE `spell_list` SET `mpCost` = 250, `castTime` = 20000 WHERE `name` = 'raise_iii';

-- Reraise: Revert WHM level from 25 to 33
UPDATE `spell_list` SET `jobs` = 0x00002100000000000000000000000000000000230000 WHERE `name` = 'reraise';

-- Reraise II: Revert WHM level from 56 to 60, MP from 150 to 175, cast time from 7.5 to 8 seconds
UPDATE `spell_list` SET `jobs` = 0x00003C00000000000000000000000000000000460000, `mpCost` = 175, `castTime` = 8000 WHERE `name` = 'reraise_ii';

-- Reraise III: Revert WHM level from 70 to 75, MP from 150 to 200, cast time from 7 to 8 seconds
UPDATE `spell_list` SET `jobs` = 0x00004B000000000000000000000000000000005B0000, `mpCost` = 200, `castTime` = 8000 WHERE `name` = 'reraise_iii';

-- Martyr: Revert range from 20 to 6 yalms
UPDATE `abilities` SET `range` = 6.0 WHERE `name` = 'martyr';

------------------------------------
-- Beastmaster
------------------------------------

-- Reward: Revert recast from 1 1/2 min to 3 minutes
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(03/11/2008)
UPDATE `abilities` SET `recastTime` = 180 WHERE `name` = 'reward';

-- Reward merit: Revert value to 6 seconds per level
UPDATE `merits` SET `value` = 6 WHERE `name` = 'reward';

-- Heel: Revert recast from 5 seconds to 10 seconds
-- Source: http://www.playonline.com/pcd/update/ff11us/20071120wwnX41/detail.html
UPDATE `abilities` SET `recastTime` = 10 WHERE `name` = 'heel';

-- Stay: Revert recast from 5 seconds to 10 seconds
UPDATE `abilities` SET `recastTime` = 10 WHERE `name` = 'stay';

-- Leave: Revert recast from 5 seconds to 10 seconds
UPDATE `abilities` SET `recastTime` = 10 WHERE `name` = 'leave';

-- Heel/Stay/Leave: Remove shared recast
UPDATE `abilities` set `recastId` = 0 Where `name` = 'heel';
UPDATE `abilities` set `recastId` = 0 Where `name` = 'leave';
UPDATE `abilities` set `recastId` = 0 Where `name` = 'stay';
