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

------------------------------------
-- White Mage
------------------------------------

-- Martyr: Revert recast from 10 to 20 minutes
UPDATE abilities SET recastTime = 1200 WHERE name = 'martyr';

-- Devotion: Revert recast from 10 to 20 minutes
UPDATE abilities SET recastTime = 1200 WHERE name = 'devotion';

------------------------------------
-- Thief
------------------------------------

-- Assassin's Charge: Revert cooldown to 15 minutes
UPDATE abilities SET recastTime = 900 WHERE name = 'assassins_charge';

-- Feint: Revert cooldown to 10 minutes
UPDATE abilities SET recastTime = 600 WHERE name = 'feint';

------------------------------------
-- Dark Knight
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(02/13/2012)
------------------------------------

-- Arcane Circle: Revert recast from 5 to 10 minutes
UPDATE abilities SET recastTime = 600 WHERE name = 'arcane_circle';

-- Weapon Bash: Revert recast from 3 to 5 minutes
UPDATE abilities SET recastTime = 300 WHERE name = 'weapon_bash';

-- Dark Seal: Revert recast from 5 to 15 minutes
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(03/26/2012)
UPDATE abilities SET recastTime = 900 WHERE name = 'dark_seal';

-- Diabolic Eye: Revert recast from 5 to 15 minutes
UPDATE abilities SET recastTime = 900 WHERE name = 'diabolic_eye';

------------------------------------
-- Paladin
------------------------------------

-- Holy Circle: Revert recast from 5 to 10 minutes
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(02/13/2012)
UPDATE abilities SET recastTime = 600 WHERE name = 'holy_circle';

-- Chivalry: Revert recast from 10 to 20 minutes
UPDATE abilities SET recastTime = 1200 WHERE name = 'chivalry';

-- Fealty: Revert recast from 10 to 20 minutes
UPDATE abilities SET recastTime = 1200 WHERE name = 'fealty';

-- Shield Bash: Revert recast from 3 to 5 minutes
UPDATE abilities SET recastTime = 300 WHERE name = 'shield_bash';

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

-- Killer Instinct: Revert recast from 5 to 15 minutes
UPDATE abilities SET recastTime = 900 WHERE name = 'killer_instinct';

------------------------------------
-- Bard
------------------------------------

-- Mazurka: Revert to town/field only
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(09/08/2010)
SET @TYPE_CITY     = 1;
SET @TYPE_OUTDOORS = 2;
SET @MISC_MAZURKA  = 8;

-- Remove mazurka from all zones
UPDATE zone_settings
SET misc = misc & ~@MISC_MAZURKA;

-- Reapply to cities and outdoor zones
UPDATE zone_settings
SET misc = misc | @MISC_MAZURKA
WHERE (zonetype & (@TYPE_CITY | @TYPE_OUTDOORS)) <> 0;

------------------------------------
-- Samurai
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(02/13/2012)
------------------------------------

-- Warding Circle: Revert recast from 5 to 10 minutes
UPDATE abilities SET recastTime = 600 WHERE name = 'warding_circle';

-- Sekkanoki: Adjust level requirement from 40 to 60
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(06/21/2010)
UPDATE abilities SET level = 60 WHERE name = 'sekkanoki';

-- Blade Bash: Revert recast from 5 to 15 minutes
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(05/15/2012)
UPDATE abilities SET recastTime = 900 WHERE name = 'blade_bash';

-- Shikikoyo: Revert recast from 5 to 15 minutes
UPDATE abilities SET recastTime = 900 WHERE name = 'shikikoyo';

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

-----------------------------------
-- Ninja
-----------------------------------

-- Yonin: Revert recast from 3 minutes to 5 minutes and add shared cooldown with Innin
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(07/11/2011)
UPDATE abilities SET recastTime = 300 WHERE name = 'yonin';

-- Innin: Revert recast from 3 minutes to 5 minutes and add shared cooldown with Yonin
UPDATE abilities SET recastTime = 300, recastId = 146 WHERE name = 'innin';

-----------------------------------
-- Dragoon
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(02/13/2012)
-----------------------------------

-- Jump: Revert recast from 1 minute to 1.5 minutes
UPDATE abilities SET recastTime = 90 WHERE name = 'jump';

-- High Jump: Revert recast from 2 minutes to 3 minutes
UPDATE abilities SET recastTime = 180 WHERE name = 'high_jump';

-- Super Jump: Revert range from 12.5 to 9.5 yalms
UPDATE abilities SET `range` = 9.5 WHERE name = 'super_jump';

-- Spirit Link: Revert recast from 1.5 minutes to 3 minutes
UPDATE abilities SET recastTime = 180 WHERE name = 'spirit_link';

-- Ancient Circle: Revert recast from 5 to 10 minutes
UPDATE abilities SET recastTime = 600 WHERE name = 'ancient_circle';

-- Deep Breathing: Revert recast from 5 to 15 minutes
UPDATE abilities SET recastTime = 900 WHERE name = 'deep_breathing';

-----------------------------------
-- Corsair
-----------------------------------

-- Double-Up: Revert recast from 5 to 7 seconds
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(09/19/2011)
UPDATE abilities SET recastTime = 7 WHERE name = 'double-up';

-- Snake Eye: Revert recast from 5 to 15 minutes
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(05/15/2012)
UPDATE abilities SET recastTime = 900 WHERE name = 'snake_eye';

-- Fold: Revert recast from 5 to 15 minutes
UPDATE abilities SET recastTime = 900 WHERE name = 'fold';

-- Quick Draw: Revert range from 22 to 15 yalms
UPDATE abilities SET `range` = 15 WHERE name = 'quick_draw';
