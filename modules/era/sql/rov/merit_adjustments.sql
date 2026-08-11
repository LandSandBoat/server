-----------------------------------
-- Rhapsodies of Vana'diel merit adjustments.
-- Reverts merits to their pre-RoV values.
-----------------------------------

-----------------------------------
-- Monk
-- Source: https://forum.square-enix.com/ffxi/threads/52969
-----------------------------------

-- Focus Recast merit: Revert value from 4 to 10 seconds per level
UPDATE `merits` SET `value` = 10 WHERE `name` = 'focus_recast';

-- Dodge Recast merit: Revert value from 4 to 10 seconds per level
UPDATE `merits` SET `value` = 10 WHERE `name` = 'dodge_recast';

-- Chakra Recast merit: Revert value from 6 to 10 seconds per level
UPDATE `merits` SET `value` = 10 WHERE `name` = 'chakra_recast';

-----------------------------------
-- Black Mage
-- Source: https://forum.square-enix.com/ffxi/threads/55525-June.-10-2019-%28JST%29-Version-Update
-----------------------------------

-- Disable OOE BLM Group 2 merits
UPDATE `merits` SET `upgrade` = 0 WHERE `name` = 'anc_magic_attack_bonus';
UPDATE `merits` SET `upgrade` = 0 WHERE `name` = 'anc_magic_burst_dmg';
UPDATE `merits` SET `upgrade` = 0 WHERE `name` = 'ele_magic_acc';
UPDATE `merits` SET `upgrade` = 0 WHERE `name` = 'ele_magic_debuff_duration';
UPDATE `merits` SET `upgrade` = 0 WHERE `name` = 'ele_magic_debuff_effect';
UPDATE `merits` SET `upgrade` = 0 WHERE `name` = 'aspir_absorption_amount';

-----------------------------------
-- Red Mage
-- Source: https://forum.square-enix.com/ffxi/threads/55751-August.-6-2019-%28JST%29-Version-Update
-----------------------------------

-- Disable OOE RDM Group 2 merits
UPDATE `merits` SET `upgrade` = 0 WHERE `name` = 'enfeebling_magic_duration';
UPDATE `merits` SET `upgrade` = 0 WHERE `name` = 'magic_accuracy';
UPDATE `merits` SET `upgrade` = 0 WHERE `name` = 'enhancing_magic_duration';
UPDATE `merits` SET `upgrade` = 0 WHERE `name` = 'immunobreak_chance';
UPDATE `merits` SET `upgrade` = 0 WHERE `name` = 'enspell_damage';
UPDATE `merits` SET `upgrade` = 0 WHERE `name` = 'melee_accuracy';

-----------------------------------
-- Paladin
-- Source: https://forum.square-enix.com/ffxi/threads/56444-February-12-2020-%28JST%29-Version-Update
-----------------------------------

-- Rampart merit: Revert value from 4 to 10 seconds per level
UPDATE `merits` SET `value` = 10 WHERE `name` = 'rampart_recast';

-----------------------------------
-- Bard
-- Source: https://forum.square-enix.com/ffxi/threads/55360-May.-10-2019-%28JST%29-Version-Update
-----------------------------------

-- Foe Sirvente/Adventurer's Dirge: Revert value value to 5 per rank.
UPDATE `merits` SET `value` = 5 WHERE `name` IN ('foe_sirvente', 'adventurers_dirge');

-- Disable OOE BRD Group 2 merits
UPDATE `merits` SET `upgrade` = 0 WHERE `name` IN ('con_anima', 'con_brio');

-----------------------------------
-- Ninja
-- Source: https://forum.square-enix.com/ffxi/threads/55525-June.-10-2019-%28JST%29-Version-Update
-----------------------------------

-- Disable OOE NIN Group 2 merits
UPDATE `merits` SET `upgrade` = 0 WHERE `name` = 'yonin_effect';
UPDATE `merits` SET `upgrade` = 0 WHERE `name` = 'innin_effect';
UPDATE `merits` SET `upgrade` = 0 WHERE `name` = 'nin_magic_accuracy';
UPDATE `merits` SET `upgrade` = 0 WHERE `name` = 'nin_magic_attack';
