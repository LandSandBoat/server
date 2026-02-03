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

-- Focus Recast merit: Revert value from 4 to 10 seconds per level
UPDATE merits SET value = 10 WHERE name = 'focus_recast';

-- Dodge Recast merit: Revert value from 4 to 10 seconds per level
UPDATE merits SET value = 10 WHERE name = 'dodge_recast';

-- Chakra Recast merit: Revert value from 6 to 10 seconds per level
UPDATE merits SET value = 10 WHERE name = 'chakra_recast';

-- Max HP Boost: Revert trait levels to 35/55/70
UPDATE traits SET level = 35 WHERE name = 'max hp boost' AND job = 2 AND rank = 2;
UPDATE traits SET level = 55 WHERE name = 'max hp boost' AND job = 2 AND rank = 3;
UPDATE traits SET level = 70 WHERE name = 'max hp boost' AND job = 2 AND rank = 4;

------------------------------------
-- Black Mage
-- Source: https://forum.square-enix.com/ffxi/threads/55525-June.-10-2019-%28JST%29-Version-Update
------------------------------------

-- Disable OOE BLM Group 2 merits
UPDATE merits SET upgrade = 0 WHERE name = 'anc_magic_attack_bonus';
UPDATE merits SET upgrade = 0 WHERE name = 'anc_magic_burst_dmg';
UPDATE merits SET upgrade = 0 WHERE name = 'ele_magic_acc';
UPDATE merits SET upgrade = 0 WHERE name = 'ele_magic_debuff_duration';
UPDATE merits SET upgrade = 0 WHERE name = 'ele_magic_debuff_effect';
UPDATE merits SET upgrade = 0 WHERE name = 'aspir_absorption_amount';
