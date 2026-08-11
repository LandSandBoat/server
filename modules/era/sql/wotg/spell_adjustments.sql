------------------------------------
-- Wings of the Goddess Spell SQL Adjustments
-- This module reverts relevant spells to their pre-WotG values
------------------------------------

------------------------------------
-- Divine Magic
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(04/08/2009)
------------------------------------

-- Banish II: Revert cast time from 2.5 to 3.75 seconds
UPDATE `spell_list` SET `castTime` = 3750 WHERE `name` = 'banish_ii';

-- Banish III: Revert cast time from 3 to 5.5 seconds
UPDATE `spell_list` SET `castTime` = 5500 WHERE `name` = 'banish_iii';

------------------------------------
-- Healing Magic
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(04/08/2009)
------------------------------------

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
