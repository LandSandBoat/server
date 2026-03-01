------------------------------------
-- Abyssea Job SQL Adjustments
-- This module reverts relevant SQL tables for jobs to their pre-Abyssea values
------------------------------------
-- Unless otherwise noted, all changes here are sourced from: https://www.bg-wiki.com/ffxi/Version_Update_(03/26/2012)
------------------------------------

------------------------------------
-- Warrior
------------------------------------

-- Warrior's Charge: Revert recast from 5 to 15 minutes
UPDATE abilities SET recastTime = 900 WHERE name = 'warriors_charge';

-- Warrior's Charge merit: Revert value to 150 seconds per level
UPDATE merits SET value = 150 WHERE name = 'warriors_charge';

------------------------------------
-- White Mage
------------------------------------

-- Martyr: Revert recast from 10 to 20 minutes
UPDATE abilities SET recastTime = 1200 WHERE name = 'martyr';

-- Devotion: Revert recast from 10 to 20 minutes
UPDATE abilities SET recastTime = 1200 WHERE name = 'devotion';

-- Martyr merit: Revert value to 150 seconds per level
UPDATE merits SET value = 150 WHERE name = 'martyr';

-- Devotion merit: Revert value to 150 seconds per level
UPDATE merits SET value = 150 WHERE name = 'devotion';

-- Animus Solace: Disable merit upgrades
UPDATE merits SET upgrade = 0 WHERE name = 'animus_solace';

-- Animus Misery: Disable merit upgrades
UPDATE merits SET upgrade = 0 WHERE name = 'animus_misery';

------------------------------------
-- WHM Spell Cast Times
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(02/13/2012)
------------------------------------

-- Esuna: Revert cast time from 1 to 3 seconds
UPDATE spell_list SET castTime = 3000 WHERE name = 'esuna';

-- Sacrifice: Revert cast time from 1 to 1.5 seconds
UPDATE spell_list SET castTime = 1500 WHERE name = 'sacrifice';

-- Blindna: Revert cast time from 1 to 3 seconds
UPDATE spell_list SET castTime = 3000 WHERE name = 'blindna';

-- Cursna: Revert cast time from 1 to 3 seconds
UPDATE spell_list SET castTime = 3000 WHERE name = 'cursna';

------------------------------------
-- Thief
------------------------------------

-- Assassin's Charge: Revert cooldown to 15 minutes
UPDATE abilities SET recastTime = 900 WHERE name = 'assassins_charge';

-- Assassin's Charge: Change merit value to reduce cooldown by 150 seconds per merit
UPDATE merits SET value = 150 WHERE name = 'assassins_charge';

-- Feint: Revert cooldown to 10 minutes
UPDATE abilities SET recastTime = 600 WHERE name = 'feint';

-- Feint: Change merit value to reduce cooldown by 120 seconds per merit
UPDATE merits SET value = 120 WHERE name = 'feint';

------------------------------------
-- Dark Knight
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(02/13/2012)
------------------------------------

-- Arcane Circle: Revert recast from 5 to 10 minutes
UPDATE abilities SET recastTime = 600 WHERE name = 'arcane_circle';

-- Arcane Circle merit: Revert value to 20 seconds per level
UPDATE merits SET value = 20 WHERE name = 'arcane_circle_recast';

-- Weapon Bash: Revert recast from 3 to 5 minutes
UPDATE abilities SET recastTime = 300 WHERE name = 'weapon_bash';

-- Weapon Bash merit: Revert value to 10 seconds per level
UPDATE merits SET value = 10 WHERE name = 'weapon_bash_recast';

-- Dark Seal: Revert recast from 5 to 15 minutes
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(03/26/2012)
UPDATE abilities SET recastTime = 900 WHERE name = 'dark_seal';

-- Dark Seal merit: Revert value to 150 seconds per level
UPDATE merits SET value = 150 WHERE name = 'dark_seal';

-- Diabolic Eye: Revert recast from 5 to 15 minutes
UPDATE abilities SET recastTime = 900 WHERE name = 'diabolic_eye';

-- Diabolic Eye merit: Revert value to 150 seconds per level
UPDATE merits SET value = 150 WHERE name = 'diabolic_eye';

------------------------------------
-- Beastmaster
------------------------------------

-- Pet Food Biscuits: Remove level requirements
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(09/08/2010)
UPDATE item_equipment SET level = 0 WHERE name = 'pet_food_alpha';
UPDATE item_equipment SET level = 0 WHERE name = 'pet_food_beta';
UPDATE item_equipment SET level = 0 WHERE name = 'pet_fd._gamma';
UPDATE item_equipment SET level = 0 WHERE name = 'pet_food_delta';
UPDATE item_equipment SET level = 0 WHERE name = 'pet_fd._epsilon';
UPDATE item_equipment SET level = 0 WHERE name = 'pet_food_zeta';

-- Feral Howl: Revert recast from 5 to 15 minutes
UPDATE abilities SET recastTime = 900 WHERE name = 'feral_howl';

-- Feral Howl merit: Revert value to 150 seconds per level
UPDATE merits SET value = 150 WHERE name = 'feral_howl';

-- Killer Instinct: Revert recast from 5 to 15 minutes
UPDATE abilities SET recastTime = 900 WHERE name = 'killer_instinct';

-- Killer Instinct merit: Revert value to 150 seconds per level
UPDATE merits SET value = 150 WHERE name = 'killer_instinct';

------------------------------------
-- Samurai
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(02/13/2012)
------------------------------------

-- Warding Circle: Revert recast from 5 to 10 minutes
UPDATE abilities SET recastTime = 600 WHERE name = 'warding_circle';

-- Warding Circle merit: Revert value to 20 seconds per level
UPDATE merits SET value = 20 WHERE name = 'warding_circle_recast';

-- Sekkanoki: Adjust level requirement from 40 to 60
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(06/21/2010)
UPDATE abilities SET level = 60 WHERE name = 'sekkanoki';

-- Blade Bash: Revert recast from 5 to 15 minutes
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(05/15/2012)
UPDATE abilities SET recastTime = 900 WHERE name = 'blade_bash';

-- Blade Bash merit: Revert value to 150 seconds per level
UPDATE merits SET value = 150 WHERE name = 'blade_bash';

-- Shikikoyo: Revert recast from 5 to 15 minutes
UPDATE abilities SET recastTime = 900 WHERE name = 'shikikoyo';

-- Shikikoyo merit: Revert value to 150 seconds per level
UPDATE merits SET value = 150 WHERE name = 'shikikoyo';

------------------------------------
-- Ranger
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(05/15/2012)
------------------------------------

-- Eagle Eye Shot: Revert range from 20 to 15 yalms
UPDATE abilities SET `range` = 15 WHERE name = 'eagle_eye_shot';

-- Shadowbind: Revert range from 20 to 10 yalms
UPDATE abilities SET `range` = 10 WHERE name = 'shadowbind';

-- Flashy Shot: revert recast from 10 to 20 minutes
UPDATE abilities SET recastTime = 1200 WHERE name = 'flashy_shot';

-- Flashy Shot merit: Revert value to 150 seconds per level
UPDATE merits SET value = 150 WHERE name = 'flashy_shot';

-----------------------------------
-- Ninja
-----------------------------------

-- Yonin: Revert recast from 3 minutes to 5 minutes and add shared cooldown with Innin
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(07/11/2011)
UPDATE abilities SET recastTime = 300 WHERE name = 'yonin';

-- Innin: Revert recast from 3 minutes to 5 minutes and add shared cooldown with Yonin
UPDATE abilities SET recastTime = 300, recastId = 146 WHERE name = 'innin';

-- Tonko: Ichi: Revert cast time from 1.5 to 4 seconds
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(02/13/2012)
UPDATE spell_list SET castTime = 4000 WHERE name = 'tonko_ichi';

-- Monomi: Ichi: Revert cast time from 1.5 to 4 seconds
UPDATE spell_list SET castTime = 4000 WHERE name = 'monomi_ichi';

-----------------------------------
-- Dragoon
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(02/13/2012)
-----------------------------------

-- Jump: Revert recast from 1 minute to 1.5 minutes
UPDATE abilities SET recastTime = 90 WHERE name = 'jump';

-- Jump merit: Revert value from 2 seconds per level to 3 seconds per level
UPDATE merits SET value = 3 WHERE name = 'jump_recast';

-- High Jump: Revert recast from 2 minutes to 3 minutes
UPDATE abilities SET recastTime = 180 WHERE name = 'high_jump';

-- High Jump merit: Revert value from 4 seconds per level to 6 seconds per level
UPDATE merits SET value = 6 WHERE name = 'high_jump_recast';

-- Super Jump: Revert range from 12.5 to 9.5 yalms
UPDATE abilities SET `range` = 9.5 WHERE name = 'super_jump';

-- Spirit Link: Revert recast from 1.5 minutes to 3 minutes
UPDATE abilities SET recastTime = 180 WHERE name = 'spirit_link';

-- Spirit Link merit: Revert value from 4 seconds per level to 6 seconds per level
UPDATE merits SET value = 6 WHERE name = 'spirit_link_recast';

-- Ancient Circle: Revert recast from 5 to 10 minutes
UPDATE abilities SET recastTime = 600 WHERE name = 'ancient_circle';

-- Ancient Circle merit: Revert value from 10 to 20 seconds per level
UPDATE merits SET value = 20 WHERE name = 'ancient_circle_recast';

-- Deep Breathing: Revert recast from 5 to 15 minutes
UPDATE abilities SET recastTime = 900 WHERE name = 'deep_breathing';

-- Deep Breathing merit: Revert value to 150 seconds per level
UPDATE merits SET value = 150 WHERE name = 'deep_breathing';
