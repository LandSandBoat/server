-----------------------------------
-- Abyssea merit adjustments.
-- Reverts merits to their pre-Abyssea values.
-----------------------------------

-----------------------------------
-- Non Job Specific Merits
-- Reverts several categories that had their total merit point upgrades increased along with adding new categories
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_Supplemental_(05/09/2011)
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(12/14/2011)
-----------------------------------

-- HP-MP
UPDATE `merits` SET `upgrade` = 8 WHERE `name` = 'max_hp';
UPDATE `merits` SET `upgrade` = 8 WHERE `name` = 'max_mp';

-- Disable max merits
UPDATE `merits` SET `upgrade` = 0 WHERE `name` = 'max_merits';

-- Attributes
UPDATE `merits` SET `upgrade` = 5 WHERE `name` = 'str';
UPDATE `merits` SET `upgrade` = 5 WHERE `name` = 'dex';
UPDATE `merits` SET `upgrade` = 5 WHERE `name` = 'vit';
UPDATE `merits` SET `upgrade` = 5 WHERE `name` = 'agi';
UPDATE `merits` SET `upgrade` = 5 WHERE `name` = 'int';
UPDATE `merits` SET `upgrade` = 5 WHERE `name` = 'mnd';
UPDATE `merits` SET `upgrade` = 5 WHERE `name` = 'chr';

-- Combat Skills
UPDATE `merits` SET `upgrade` = 8 WHERE `name` = 'h2h';
UPDATE `merits` SET `upgrade` = 8 WHERE `name` = 'dagger';
UPDATE `merits` SET `upgrade` = 8 WHERE `name` = 'sword';
UPDATE `merits` SET `upgrade` = 8 WHERE `name` = 'gsword';
UPDATE `merits` SET `upgrade` = 8 WHERE `name` = 'axe';
UPDATE `merits` SET `upgrade` = 8 WHERE `name` = 'gaxe';
UPDATE `merits` SET `upgrade` = 8 WHERE `name` = 'scythe';
UPDATE `merits` SET `upgrade` = 8 WHERE `name` = 'polearm';
UPDATE `merits` SET `upgrade` = 8 WHERE `name` = 'katana';
UPDATE `merits` SET `upgrade` = 8 WHERE `name` = 'gkatana';
UPDATE `merits` SET `upgrade` = 8 WHERE `name` = 'club';
UPDATE `merits` SET `upgrade` = 8 WHERE `name` = 'staff';
UPDATE `merits` SET `upgrade` = 8 WHERE `name` = 'archery';
UPDATE `merits` SET `upgrade` = 8 WHERE `name` = 'marksmanship';
UPDATE `merits` SET `upgrade` = 8 WHERE `name` = 'throwing';
UPDATE `merits` SET `upgrade` = 4 WHERE `name` = 'guarding_skill';
UPDATE `merits` SET `upgrade` = 4 WHERE `name` = 'evasion_skill';
UPDATE `merits` SET `upgrade` = 4 WHERE `name` = 'shield_skill';
UPDATE `merits` SET `upgrade` = 4 WHERE `name` = 'parrying_skill';

-- Others
UPDATE `merits` SET `upgrade` = 4 WHERE `name` = 'enmity_increase';
UPDATE `merits` SET `upgrade` = 4 WHERE `name` = 'enmity_decrease';
UPDATE `merits` SET `upgrade` = 4 WHERE `name` = 'crit_hit_rate';
UPDATE `merits` SET `upgrade` = 4 WHERE `name` = 'enemy_crit_rate';
UPDATE `merits` SET `upgrade` = 4 WHERE `name` = 'spell_interuption_rate';

-- Weapon Skills
-- Disable out of era merit weaponskills
UPDATE `merits` SET `upgrade` = 0 WHERE `name` = 'shijin_spiral';
UPDATE `merits` SET `upgrade` = 0 WHERE `name` = 'exenterator';
UPDATE `merits` SET `upgrade` = 0 WHERE `name` = 'requiescat';
UPDATE `merits` SET `upgrade` = 0 WHERE `name` = 'resolution';
UPDATE `merits` SET `upgrade` = 0 WHERE `name` = 'ruinator';
UPDATE `merits` SET `upgrade` = 0 WHERE `name` = 'upheaval';
UPDATE `merits` SET `upgrade` = 0 WHERE `name` = 'entropy';
UPDATE `merits` SET `upgrade` = 0 WHERE `name` = 'stardiver';
UPDATE `merits` SET `upgrade` = 0 WHERE `name` = 'blade_shun';
UPDATE `merits` SET `upgrade` = 0 WHERE `name` = 'tachi_shoha';
UPDATE `merits` SET `upgrade` = 0 WHERE `name` = 'realmrazer';
UPDATE `merits` SET `upgrade` = 0 WHERE `name` = 'shattersoul';
UPDATE `merits` SET `upgrade` = 0 WHERE `name` = 'apex_arrow';
UPDATE `merits` SET `upgrade` = 0 WHERE `name` = 'last_stand';

-----------------------------------
-- Job ability merit value reverts
-- Unless otherwise noted, sourced from: https://www.bg-wiki.com/ffxi/Version_Update_(03/26/2012)
-----------------------------------

-----------------------------------
-- Warrior
-----------------------------------

-- Warrior's Charge merit: Revert value to 150 seconds per level
UPDATE `merits` SET `value` = 150 WHERE `name` = 'warriors_charge';

-----------------------------------
-- White Mage
-----------------------------------

-- Martyr merit: Revert value to 150 seconds per level
UPDATE `merits` SET `value` = 150 WHERE `name` = 'martyr';

-- Devotion merit: Revert value to 150 seconds per level
UPDATE `merits` SET `value` = 150 WHERE `name` = 'devotion';

-- Animus Solace/Animus Misery: Disable merit upgrades
-- Source: https://forum.square-enix.com/ffxi/threads/55360?_ga=2.195400239.203489549.1557463710-808700183.1440009048
UPDATE `merits` SET `upgrade` = 0 WHERE `name` = 'animus_solace';
UPDATE `merits` SET `upgrade` = 0 WHERE `name` = 'animus_misery';

-----------------------------------
-- Thief
-----------------------------------

-- Assassin's Charge merit: Reduce cooldown by 150 seconds per merit
UPDATE `merits` SET `value` = 150 WHERE `name` = 'assassins_charge';

-- Feint merit: Reduce cooldown by 120 seconds per merit
UPDATE `merits` SET `value` = 120 WHERE `name` = 'feint';

-----------------------------------
-- Dark Knight
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(02/13/2012)
-----------------------------------

-- Arcane Circle merit: Revert value to 20 seconds per level
UPDATE `merits` SET `value` = 20 WHERE `name` = 'arcane_circle_recast';

-- Weapon Bash merit: Revert value to 10 seconds per level
-- Note: merit is named weapon_bash_effect (provides both recast reduction and effect)
UPDATE `merits` SET `value` = 10 WHERE `name` = 'weapon_bash_effect';

-- Dark Seal merit: Revert value to 150 seconds per level
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(03/26/2012)
UPDATE `merits` SET `value` = 150 WHERE `name` = 'dark_seal';

-- Diabolic Eye merit: Revert value to 150 seconds per level
UPDATE `merits` SET `value` = 150 WHERE `name` = 'diabolic_eye';

-----------------------------------
-- Paladin
-----------------------------------

-- Holy Circle merit: Revert value to 20 seconds per level
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(02/13/2012)
UPDATE `merits` SET `value` = 20 WHERE `name` = 'holy_circle_recast';

-- Chivalry merit: Revert value to 150 seconds per level
UPDATE `merits` SET `value` = 150 WHERE `name` = 'chivalry';

-- Fealty merit: Revert value to 150 seconds per level
UPDATE `merits` SET `value` = 150 WHERE `name` = 'fealty';

-- Shield Bash merit: Revert value to 10 seconds per level
UPDATE `merits` SET `value` = 10 WHERE `name` = 'shield_bash_recast';

-----------------------------------
-- Beastmaster
-----------------------------------

-- Feral Howl merit: Revert value to 150 seconds per level
UPDATE `merits` SET `value` = 150 WHERE `name` = 'feral_howl';

-- Killer Instinct merit: Revert value to 150 seconds per level
UPDATE `merits` SET `value` = 150 WHERE `name` = 'killer_instinct';

-----------------------------------
-- Samurai
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(02/13/2012)
-----------------------------------

-- Warding Circle merit: Revert value to 20 seconds per level
UPDATE `merits` SET `value` = 20 WHERE `name` = 'warding_circle_recast';

-- Blade Bash merit: Revert value to 150 seconds per level
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(05/15/2012)
UPDATE `merits` SET `value` = 150 WHERE `name` = 'blade_bash';

-- Shikikoyo merit: Revert value to 150 seconds per level
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(05/15/2012)
UPDATE `merits` SET `value` = 150 WHERE `name` = 'shikikoyo';

-----------------------------------
-- Ranger
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(05/15/2012)
-----------------------------------

-- Flashy Shot merit: Revert value to 150 seconds per level
UPDATE `merits` SET `value` = 150 WHERE `name` = 'flashy_shot';

-----------------------------------
-- Dragoon
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(02/13/2012)
-----------------------------------

-- Jump merit: Revert value from 2 seconds per level to 3 seconds per level
UPDATE `merits` SET `value` = 3 WHERE `name` = 'jump_recast';

-- High Jump merit: Revert value from 4 seconds per level to 6 seconds per level
UPDATE `merits` SET `value` = 6 WHERE `name` = 'high_jump_recast';

-- Spirit Link merit: Revert value from 4 seconds per level to 6 seconds per level
UPDATE `merits` SET `value` = 6 WHERE `name` = 'spirit_link_recast';

-- Ancient Circle merit: Revert value from 10 to 20 seconds per level
UPDATE `merits` SET `value` = 20 WHERE `name` = 'ancient_circle_recast';

-- Deep Breathing merit: Revert value to 150 seconds per level
UPDATE `merits` SET `value` = 150 WHERE `name` = 'deep_breathing';

-----------------------------------
-- Summoner
-----------------------------------

-- Summoning Magic Casting Time merit: Repurposed to Spirit MP cost merit. Revert merit value from 5 to 1 per level.
-- Source: https://forum.square-enix.com/ffxi/threads/22099-March-27-2012-%28JST%29-Version-Update
UPDATE `merits` SET `value` = 1 WHERE `name` = 'summoning_magic_cast_time';

-----------------------------------
-- Corsair
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(05/15/2012)
-----------------------------------

-- Snake Eye merit: Revert value to 150 seconds per level
UPDATE `merits` SET `value` = 150 WHERE `name` = 'snake_eye';

-- Fold merit: Revert value to 150 seconds per level
UPDATE `merits` SET `value` = 150 WHERE `name` = 'fold';
