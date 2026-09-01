------------------------------------
-- Rhapsodies of Vana'diel Spell SQL Adjustments
-- This module reverts relevant spells to their pre-RoV values
------------------------------------

------------------------------------
-- Enhancing Magic
-- Source: https://forum.square-enix.com/ffxi/threads/46531
------------------------------------

-- Protectra: Revert cast time from 1 to 3 seconds
UPDATE spell_list SET castTime = 3000 WHERE name = 'protectra';

-- Protectra II: Revert cast time from 1.25 to 3.75 seconds
UPDATE spell_list SET castTime = 3750 WHERE name = 'protectra_ii';

-- Protectra III: Revert cast time from 1.5 to 4.5 seconds
UPDATE spell_list SET castTime = 4500 WHERE name = 'protectra_iii';

-- Protectra IV: Revert cast time from 1.75 to 5.25 seconds
UPDATE spell_list SET castTime = 5250 WHERE name = 'protectra_iv';

-- Protectra V: Revert cast time from 2 to 7 seconds
UPDATE spell_list SET castTime = 7000 WHERE name = 'protectra_v';

-- Shellra: Revert cast time from 1 to 3 seconds
UPDATE spell_list SET castTime = 3000 WHERE name = 'shellra';

-- Shellra II: Revert cast time from 1.25 to 3.75 seconds
UPDATE spell_list SET castTime = 3750 WHERE name = 'shellra_ii';

-- Shellra III: Revert cast time from 1.5 to 4.5 seconds
UPDATE spell_list SET castTime = 4500 WHERE name = 'shellra_iii';

-- Shellra IV: Revert cast time from 1.75 to 5.25 seconds
UPDATE spell_list SET castTime = 5250 WHERE name = 'shellra_iv';

-- Shellra V: Revert cast time from 2 to 6 seconds
UPDATE spell_list SET castTime = 6000 WHERE name = 'shellra_v';

------------------------------------
-- Divine Magic
------------------------------------

-- Remove PLD from Banishga
-- Source: https://forum.square-enix.com/ffxi/threads/56243
UPDATE spell_list SET jobs = 0x00000F00000000000000000000000000000000000000 WHERE name = 'banishga';

------------------------------------
-- Elemental Magic
------------------------------------

-- Set casting time to 12 seconds for all Ancient Magic spells
-- Source: https://forum.square-enix.com/ffxi/threads/55525-June.-10-2019-%28JST%29-Version-Update
UPDATE spell_list SET castTime = 12000 WHERE name = 'flare';
UPDATE spell_list SET castTime = 12000 WHERE name = 'freeze';
UPDATE spell_list SET castTime = 12000 WHERE name = 'tornado';
UPDATE spell_list SET castTime = 12000 WHERE name = 'quake';
UPDATE spell_list SET castTime = 12000 WHERE name = 'burst';
UPDATE spell_list SET castTime = 12000 WHERE name = 'flood';

-- Set casting time to 10 seconds for all Ancient Magic II spells
UPDATE spell_list SET castTime = 10000 WHERE name = 'flare_ii';
UPDATE spell_list SET castTime = 10000 WHERE name = 'freeze_ii';
UPDATE spell_list SET castTime = 10000 WHERE name = 'tornado_ii';
UPDATE spell_list SET castTime = 10000 WHERE name = 'quake_ii';
UPDATE spell_list SET castTime = 10000 WHERE name = 'burst_ii';
UPDATE spell_list SET castTime = 10000 WHERE name = 'flood_ii';
