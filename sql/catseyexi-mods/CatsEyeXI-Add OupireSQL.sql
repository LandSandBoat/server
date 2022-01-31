
-- Delete OLD Oupire Spell List
DELETE FROM `mob_spell_lists` WHERE  `spell_list_id`=150 AND `spell_id`=176;
DELETE FROM `mob_spell_lists` WHERE  `spell_list_id`=150 AND `spell_id`=181;
DELETE FROM `mob_spell_lists` WHERE  `spell_list_id`=150 AND `spell_id`=186;
DELETE FROM `mob_spell_lists` WHERE  `spell_list_id`=150 AND `spell_id`=191;
DELETE FROM `mob_spell_lists` WHERE  `spell_list_id`=150 AND `spell_id`=196;
DELETE FROM `mob_spell_lists` WHERE  `spell_list_id`=150 AND `spell_id`=201;
DELETE FROM `mob_spell_lists` WHERE  `spell_list_id`=150 AND `spell_id`=152;
DELETE FROM `mob_spell_lists` WHERE  `spell_list_id`=150 AND `spell_id`=147;
DELETE FROM `mob_spell_lists` WHERE  `spell_list_id`=150 AND `spell_id`=157;
DELETE FROM `mob_spell_lists` WHERE  `spell_list_id`=150 AND `spell_id`=162;
DELETE FROM `mob_spell_lists` WHERE  `spell_list_id`=150 AND `spell_id`=167;
DELETE FROM `mob_spell_lists` WHERE  `spell_list_id`=150 AND `spell_id`=172;
DELETE FROM `mob_spell_lists` WHERE  `spell_list_id`=150 AND `spell_id`=227;
DELETE FROM `mob_spell_lists` WHERE  `spell_list_id`=150 AND `spell_id`=360;
DELETE FROM `mob_spell_lists` WHERE  `spell_list_id`=150 AND `spell_id`=365;
DELETE FROM `mob_spell_lists` WHERE  `spell_list_id`=150 AND `spell_id`=362;
DELETE FROM `mob_spell_lists` WHERE  `spell_list_id`=150 AND `spell_id`=361;
DELETE FROM `mob_spell_lists` WHERE  `spell_list_id`=150 AND `spell_id`=366;
DELETE FROM `mob_spell_lists` WHERE  `spell_list_id`=150 AND `spell_id`=274;
-- Update Ouire Animation sub from 8 to 0
UPDATE `mob_pools` SET `animationsub`='0' WHERE  `poolid`=3069;


-- Update Oupire's HP/MP Max level
UPDATE `mob_groups` SET `HP`='38000', `MP`='9999', `maxLevel`='88' WHERE  `zoneid`=72 AND `groupid`=7;

-- Oupire Spell List (Ice)
INSERT INTO `mob_spell_lists` VALUES ('Oupire_Ice', 461, 181, 1, 255); -- Blizzaga III
INSERT INTO `mob_spell_lists` VALUES ('Oupire_Ice', 461, 152, 1, 255); -- Blizzard IV
INSERT INTO `mob_spell_lists` VALUES ('Oupire_Ice', 461, 227, 1, 255); -- Poisonga III
INSERT INTO `mob_spell_lists` VALUES ('Oupire_Ice', 461, 360, 1, 255); -- Dispelga
INSERT INTO `mob_spell_lists` VALUES ('Oupire_Ice', 461, 365, 1, 255); -- Breakga
INSERT INTO `mob_spell_lists` VALUES ('Oupire_Ice', 461, 362, 1, 255); -- Bindga
INSERT INTO `mob_spell_lists` VALUES ('Oupire_Ice', 461, 361, 1, 255); -- Blindga
INSERT INTO `mob_spell_lists` VALUES ('Oupire_Ice', 461, 366, 1, 255); -- Graviga
INSERT INTO `mob_spell_lists` VALUES ('Oupire_Ice', 461, 274, 1, 255); -- Sleepga II
-- Oupire Spell List (Wind)
INSERT INTO `mob_spell_lists` VALUES ('Oupire_Wind', 462, 186, 1, 255); -- Aeroga III
INSERT INTO `mob_spell_lists` VALUES ('Oupire_Wind', 462, 157, 1, 255); -- Aero IV
INSERT INTO `mob_spell_lists` VALUES ('Oupire_Wind', 462, 227, 1, 255); -- Poisonga III
INSERT INTO `mob_spell_lists` VALUES ('Oupire_Wind', 462, 360, 1, 255); -- Dispelga
INSERT INTO `mob_spell_lists` VALUES ('Oupire_Wind', 462, 365, 1, 255); -- Breakga
INSERT INTO `mob_spell_lists` VALUES ('Oupire_Wind', 462, 362, 1, 255); -- Bindga
INSERT INTO `mob_spell_lists` VALUES ('Oupire_Wind', 462, 361, 1, 255); -- Blindga
INSERT INTO `mob_spell_lists` VALUES ('Oupire_Wind', 462, 366, 1, 255); -- Graviga
INSERT INTO `mob_spell_lists` VALUES ('Oupire_Wind', 462, 274, 1, 255); -- Sleepga II
-- Oupire Spell List (Earth)
INSERT INTO `mob_spell_lists` VALUES ('Oupire_Earth', 463, 191, 1, 255); -- Stonega III
INSERT INTO `mob_spell_lists` VALUES ('Oupire_Earth', 463, 162, 1, 255); -- Stone IV
INSERT INTO `mob_spell_lists` VALUES ('Oupire_Earth', 463, 227, 1, 255); -- Poisonga III
INSERT INTO `mob_spell_lists` VALUES ('Oupire_Earth', 463, 360, 1, 255); -- Dispelga
INSERT INTO `mob_spell_lists` VALUES ('Oupire_Earth', 463, 365, 1, 255); -- Breakga
INSERT INTO `mob_spell_lists` VALUES ('Oupire_Earth', 463, 362, 1, 255); -- Bindga
INSERT INTO `mob_spell_lists` VALUES ('Oupire_Earth', 463, 361, 1, 255); -- Blindga
INSERT INTO `mob_spell_lists` VALUES ('Oupire_Earth', 463, 366, 1, 255); -- Graviga
INSERT INTO `mob_spell_lists` VALUES ('Oupire_Earth', 463, 274, 1, 255); -- Sleepga II
-- Oupire Spell List (Thunder)
INSERT INTO `mob_spell_lists` VALUES ('Oupire_Thunder', 464, 196, 1, 255); -- Thundaga III
INSERT INTO `mob_spell_lists` VALUES ('Oupire_Thunder', 464, 167, 1, 255); -- Thunder IV
INSERT INTO `mob_spell_lists` VALUES ('Oupire_Thunder', 464, 227, 1, 255); -- Poisonga III
INSERT INTO `mob_spell_lists` VALUES ('Oupire_Thunder', 464, 360, 1, 255); -- Dispelga
INSERT INTO `mob_spell_lists` VALUES ('Oupire_Thunder', 464, 365, 1, 255); -- Breakga
INSERT INTO `mob_spell_lists` VALUES ('Oupire_Thunder', 464, 362, 1, 255); -- Bindga
INSERT INTO `mob_spell_lists` VALUES ('Oupire_Thunder', 464, 361, 1, 255); -- Blindga
INSERT INTO `mob_spell_lists` VALUES ('Oupire_Thunder', 464, 366, 1, 255); -- Graviga
INSERT INTO `mob_spell_lists` VALUES ('Oupire_Thunder', 464, 274, 1, 255); -- Sleepga II
-- Oupire Spell List (Water)
INSERT INTO `mob_spell_lists` VALUES ('Oupire_Water', 465, 201, 1, 255); -- Waterga III
INSERT INTO `mob_spell_lists` VALUES ('Oupire_Water', 465, 172, 1, 255); -- Water IV
INSERT INTO `mob_spell_lists` VALUES ('Oupire_Water', 465, 227, 1, 255); -- Poisonga III
INSERT INTO `mob_spell_lists` VALUES ('Oupire_Water', 465, 360, 1, 255); -- Dispelga
INSERT INTO `mob_spell_lists` VALUES ('Oupire_Water', 465, 365, 1, 255); -- Breakga
INSERT INTO `mob_spell_lists` VALUES ('Oupire_Water', 465, 362, 1, 255); -- Bindga
INSERT INTO `mob_spell_lists` VALUES ('Oupire_Water', 465, 361, 1, 255); -- Blindga
INSERT INTO `mob_spell_lists` VALUES ('Oupire_Water', 465, 366, 1, 255); -- Graviga
INSERT INTO `mob_spell_lists` VALUES ('Oupire_Water', 465, 274, 1, 255); -- Sleepga II
-- Oupire Spell List (Fire)
INSERT INTO `mob_spell_lists` VALUES ('Oupire_Fire', 460, 176, 1, 255); -- Firaga III
INSERT INTO `mob_spell_lists` VALUES ('Oupire_Fire', 460, 147, 1, 255); -- Fire IV
INSERT INTO `mob_spell_lists` VALUES ('Oupire_Fire', 460, 227, 1, 255); -- Poisonga III
INSERT INTO `mob_spell_lists` VALUES ('Oupire_Fire', 460, 360, 1, 255); -- Dispelga
INSERT INTO `mob_spell_lists` VALUES ('Oupire_Fire', 460, 365, 1, 255); -- Breakga
INSERT INTO `mob_spell_lists` VALUES ('Oupire_Fire', 460, 362, 1, 255); -- Bindga
INSERT INTO `mob_spell_lists` VALUES ('Oupire_Fire', 460, 361, 1, 255); -- Blindga
INSERT INTO `mob_spell_lists` VALUES ('Oupire_Fire', 460, 366, 1, 255); -- Graviga
INSERT INTO `mob_spell_lists` VALUES ('Oupire_Fire', 460, 274, 1, 255); -- Sleepga II
-- Oupire Spell List (Non-Elemental)
INSERT INTO `mob_spell_lists` VALUES ('Oupire', 150, 227, 1, 255); -- Poisonga III
INSERT INTO `mob_spell_lists` VALUES ('Oupire', 150, 360, 1, 255); -- Dispelga
INSERT INTO `mob_spell_lists` VALUES ('Oupire', 150, 365, 1, 255); -- Breakga
INSERT INTO `mob_spell_lists` VALUES ('Oupire', 150, 362, 1, 255); -- Bindga
INSERT INTO `mob_spell_lists` VALUES ('Oupire', 150, 361, 1, 255); -- Blindga
INSERT INTO `mob_spell_lists` VALUES ('Oupire', 150, 366, 1, 255); -- Graviga
INSERT INTO `mob_spell_lists` VALUES ('Oupire', 150, 274, 1, 255); -- Sleepga II

-- Oupire Mob_Skill_Lists
INSERT INTO `mob_skill_lists` VALUES('Oupire', 284, 2106);
INSERT INTO `mob_skill_lists` VALUES('Oupire', 284, 2107);
INSERT INTO `mob_skill_lists` VALUES('Oupire', 284, 2108);
INSERT INTO `mob_skill_lists` VALUES('Oupire', 284, 2109);
INSERT INTO `mob_skill_lists` VALUES('Oupire', 284, 2110);
INSERT INTO `mob_skill_lists` VALUES('Oupire', 284, 2111);