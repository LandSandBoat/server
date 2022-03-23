-- Change Elviras default jobs
UPDATE mob_pools SET mJob = 17 WHERE poolid = "1198" AND `name` = 'Elivira';
UPDATE mob_pools SET mJob = 17 WHERE poolid = "5941" AND `name` = 'Elivira';

-- Mob Skill List Elivira
DELETE FROM mob_skill_lists WHERE skill_list_id = "1056";
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Elivira',1056,1201);  -- Coronach (Elivira)
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Elivira',1056,212);   -- Slug Shot (Elivira)
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Elivira',1056,214);   -- Heavy Shot (Elivira)
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Elivira',1056,209);   -- Split Shot (Elivira)

-- Mob Skill List Halver
DELETE FROM mob_skill_lists WHERE skill_list_id = "1087";
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Halver',1087,114);  -- Raiden Thrust
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Halver',1087,116);  -- Penta Thrust
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Halver',1087,120);  -- Impulse Drive

-- Add WS to ArkEv
DELETE FROM mob_skill_lists WHERE skill_list_id = "1108";
INSERT INTO `mob_skill_lists` VALUES ('TRUST_AAEV',1108,3711);      -- Vorpal Blade
INSERT INTO `mob_skill_lists` VALUES ('TRUST_AAEV',1108,3713);      -- Chant du Cygne
INSERT INTO `mob_skill_lists` VALUES ('TRUST_AAEV',1108,3712);      -- Dominion Slash
INSERT INTO `mob_skill_lists` VALUES ('TRUST_AAEV',1108,3710);      -- Arrogance Incarnate
INSERT INTO `mob_skills` VALUES (3712,635,'dominion_slash',0,7.0,2000,1500,4,0,0,0,0,0,0); -- ArkEV Dominion_Slash
UPDATE mob_skills SET mob_anim_id = '2920' WHERE mob_skill_id = '3713'; -- ArkEv Chant_du_Cygne
UPDATE mob_skills SET mob_skill_aoe = '1', mob_anim_id = '642' WHERE mob_skill_id = '3710'; -- ArkEv Arrogance_Incarnate
UPDATE mob_skills SET mob_anim_id = '236' WHERE mob_skill_id = '3711'; -- ArkEv Vorpal_Blade

-- Maximilian job change
UPDATE mob_pools SET sJob = "13" WHERE poolid = "5975" AND `name` = 'maximilian';

-- Mob Skill List Iroha II
DELETE FROM mob_skill_lists WHERE skill_list_id = "1133";
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Iroha_II',1133,125);  -- Stardriver
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Iroha_II',1133,124);  -- Camlanns Torment
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Iroha_II',1133,122);  -- Drakesbane
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Iroha_II',1133,116);  -- Penta Thrust
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Iroha_II',1133,120);  -- Impulse Drive
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Iroha_II',1133,112);  -- Double Thrust

-- Mob Skill List for Maximilian
DELETE FROM mob_skill_lists WHERE skill_list_id = "1090";
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Maximilian',1090,32);  -- Fast Blade
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Maximilian',1090,40);  -- Vorpal Blade
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Maximilian',1090,41);  -- Swift Blade

-- Mob Spell List for Maximilian
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Maximilian',388,338,12,255);       -- Utsusemi: Ichi
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Maximilian',388,339,37,255);       -- Utsusemi: Ni