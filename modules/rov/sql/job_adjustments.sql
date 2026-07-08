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
-- White Mage
-- Source: https://forum.square-enix.com/ffxi/threads/46531-Mar-26-2015-%28JST%29-Version-Update
------------------------------------

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

------------------------------------
-- Red Mage
-- https://forum.square-enix.com/ffxi/threads/55751-August.-6-2019-%28JST%29-Version-Update
------------------------------------

-- Disable OOE RDM Group 2 merits
UPDATE merits SET upgrade = 0 WHERE name = 'enfeebling_magic_duration';
UPDATE merits SET upgrade = 0 WHERE name = 'magic_accuracy';
UPDATE merits SET upgrade = 0 WHERE name = 'enhancing_magic_duration';
UPDATE merits SET upgrade = 0 WHERE name = 'immunobreak_chance';
UPDATE merits SET upgrade = 0 WHERE name = 'enspell_damage';
UPDATE merits SET upgrade = 0 WHERE name = 'melee_accuracy';

------------------------------------
-- Paladin
------------------------------------

-- Rampart: Revert recast from 3 to 5 minutes
-- Source: https://forum.square-enix.com/ffxi/threads/56444-February-12-2020-%28JST%29-Version-Update
UPDATE abilities SET recastTime = 300 WHERE name = 'rampart';

-- Rampart merit: Revert value from 4 to 10 seconds per level
UPDATE merits SET value = 10 WHERE name = 'rampart_recast';

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
-- Bard
-- Source: https://forum.square-enix.com/ffxi/threads/55360-May.-10-2019-%28JST%29-Version-Update
------------------------------------

-- Foe Sirvente/Adventurer's Dirge: Set merit ranks to 5 and merit value to 5 per rank.
UPDATE merits SET upgrade = 5, value = 5 WHERE name IN ('foe_sirvente', 'adventurers_dirge');

-- Disable OOE BRD Group 2 merits
UPDATE merits SET upgrade = 0 WHERE name IN ('con_anima', 'con_brio');

-----------------------------------
-- Ninja
-- Source: https://forum.square-enix.com/ffxi/threads/55525-June.-10-2019-%28JST%29-Version-Update
------------------------------------

-- Disable OOE NIN Group 2 merits
UPDATE merits SET upgrade = 0 WHERE name = 'yonin_effect';
UPDATE merits SET upgrade = 0 WHERE name = 'innin_effect';
UPDATE merits SET upgrade = 0 WHERE name = 'nin_magic_accuracy';
UPDATE merits SET upgrade = 0 WHERE name = 'nin_magic_attack';

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
