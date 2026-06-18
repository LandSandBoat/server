-- ToAU era adjustments
-- Adds animation times back to maneuvers.
-- https://wiki.ffo.jp/html/3764.html
-- Removes Access to Bone Crusher, Armor Piercer, and Magic Mortar. (WoTG Era)

UPDATE `abilities` SET `animation` = 83, `animationTime` = 2000 WHERE `name` = 'fire_maneuver';
UPDATE `abilities` SET `animation` = 83, `animationTime` = 2000 WHERE `name` = 'ice_maneuver';
UPDATE `abilities` SET `animation` = 83, `animationTime` = 2000 WHERE `name` = 'wind_maneuver';
UPDATE `abilities` SET `animation` = 83, `animationTime` = 2000 WHERE `name` = 'earth_maneuver';
UPDATE `abilities` SET `animation` = 83, `animationTime` = 2000 WHERE `name` = 'thunder_maneuver';
UPDATE `abilities` SET `animation` = 83, `animationTime` = 2000 WHERE `name` = 'water_maneuver';
UPDATE `abilities` SET `animation` = 83, `animationTime` = 2000 WHERE `name` = 'light_maneuver';
UPDATE `abilities` SET `animation` = 83, `animationTime` = 2000 WHERE `name` = 'dark_maneuver';

UPDATE `mob_skills` SET `mob_skill_param` = 999 WHERE `mob_skill_name` = 'bone_crusher';
UPDATE `mob_skills` SET `mob_skill_param` = 999 WHERE `mob_skill_name` = 'armor_piercer';
UPDATE `mob_skills` SET `mob_skill_param` = 999 WHERE `mob_skill_name` = 'magic_mortar';
