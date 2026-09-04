-- ToAU era adjustments
-- Adds animation times back to maneuvers.
-- https://wiki.ffo.jp/html/3764.html
-- Removes Access to Bone Crusher, Armor Piercer, and Magic Mortar. (WoTG Era)

-- Automaton Spell Adjustments
-- https://wiki.ffo.jp/html/8523.html
-- https://forum.square-enix.com/ffxi/threads/18132

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

UPDATE `automaton_spells` SET `skilllevel` = 999 WHERE `spellid` =   6; -- Cure VI
UPDATE `automaton_spells` SET `skilllevel` = 999 WHERE `spellid` =  43; -- Protect
UPDATE `automaton_spells` SET `skilllevel` = 999 WHERE `spellid` =  44; -- Protect II
UPDATE `automaton_spells` SET `skilllevel` = 999 WHERE `spellid` =  45; -- Protect III
UPDATE `automaton_spells` SET `skilllevel` = 999 WHERE `spellid` =  46; -- Protect IV
UPDATE `automaton_spells` SET `skilllevel` = 999 WHERE `spellid` =  47; -- Protect V
UPDATE `automaton_spells` SET `skilllevel` = 999 WHERE `spellid` =  48; -- Shell
UPDATE `automaton_spells` SET `skilllevel` = 999 WHERE `spellid` =  49; -- Shell II
UPDATE `automaton_spells` SET `skilllevel` = 999 WHERE `spellid` =  50; -- Shell III
UPDATE `automaton_spells` SET `skilllevel` = 999 WHERE `spellid` =  51; -- Shell IV
UPDATE `automaton_spells` SET `skilllevel` = 999 WHERE `spellid` =  52; -- Shell V
UPDATE `automaton_spells` SET `skilllevel` = 999 WHERE `spellid` =  54; -- Stoneskin
UPDATE `automaton_spells` SET `skilllevel` = 999 WHERE `spellid` =  57; -- Haste
UPDATE `automaton_spells` SET `skilllevel` = 999 WHERE `spellid` = 106; -- Phalanx
UPDATE `automaton_spells` SET `skilllevel` = 999 WHERE `spellid` = 129; -- Protectra V
UPDATE `automaton_spells` SET `skilllevel` = 999 WHERE `spellid` = 134; -- Shellra V
UPDATE `automaton_spells` SET `skilllevel` = 999 WHERE `spellid` = 143; -- Erase
UPDATE `automaton_spells` SET `skilllevel` = 999 WHERE `spellid` = 148; -- Fire V
UPDATE `automaton_spells` SET `skilllevel` = 999 WHERE `spellid` = 153; -- Blizzard V
UPDATE `automaton_spells` SET `skilllevel` = 999 WHERE `spellid` = 158; -- Aero V
UPDATE `automaton_spells` SET `skilllevel` = 999 WHERE `spellid` = 163; -- Stone V
UPDATE `automaton_spells` SET `skilllevel` = 999 WHERE `spellid` = 168; -- Thunder V
UPDATE `automaton_spells` SET `skilllevel` = 999 WHERE `spellid` = 173; -- Water V
UPDATE `automaton_spells` SET `skilllevel` = 999 WHERE `spellid` = 221; -- Poison II
UPDATE `automaton_spells` SET `skilllevel` = 999 WHERE `spellid` = 248; -- Aspir II
UPDATE `automaton_spells` SET `skilllevel` = 999 WHERE `spellid` = 260; -- Dispel
UPDATE `automaton_spells` SET `skilllevel` = 999 WHERE `spellid` = 277; -- Dread Spikes
UPDATE `automaton_spells` SET `skilllevel` = 999 WHERE `spellid` = 286; -- Addle
UPDATE `automaton_spells` SET `skilllevel` = 999 WHERE `spellid` = 477; -- Regen IV
UPDATE `automaton_spells` SET `skilllevel` = 999 WHERE `spellid` = 511; -- Haste II
UPDATE `automaton_spells` SET `skilllevel` = 999 WHERE `spellid` = 847; -- Absorb-Attri

UPDATE `automaton_spells` SET `heads` = 32 WHERE `spellid` = 147; -- Fire IV
UPDATE `automaton_spells` SET `heads` = 32 WHERE `spellid` = 152; -- Blizzard IV
UPDATE `automaton_spells` SET `heads` = 32 WHERE `spellid` = 157; -- Aero IV
UPDATE `automaton_spells` SET `heads` = 32 WHERE `spellid` = 162; -- Stone IV
UPDATE `automaton_spells` SET `heads` = 32 WHERE `spellid` = 167; -- Thunder IV
UPDATE `automaton_spells` SET `heads` = 32 WHERE `spellid` = 172; -- Water IV
