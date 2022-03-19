-- Change Elviras default jobs
UPDATE mob_pools SET mJob = 17 WHERE poolid =1198 AND `name` = 'Elivira';
UPDATE mob_pools SET mJob = 17 WHERE poolid = 5941 AND `name` = 'elivira';

-- Add WS to Elivira
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Elivira',1056,1201); -- Coronach (Elivira)

-- Add WS to Halver
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Halver',1087,114); -- Raiden Thrust
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Halver',1087,116); -- Penta Thrust
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Halver',1087,120); -- Impulse Drive

-- Add WS to ArkEv
DELETE FROM mob_skill_lists WHERE skill_list_id = "1108"
INSERT INTO `mob_skill_lists` VALUES ('TRUST_AAEV',1108,3711);      -- Vorpal Blade
INSERT INTO `mob_skill_lists` VALUES ('TRUST_AAEV',1108,3713);      -- Chant du Cygne
INSERT INTO `mob_skill_lists` VALUES ('TRUST_AAEV',1108,3712);      -- Dominion Slash
INSERT INTO `mob_skill_lists` VALUES ('TRUST_AAEV',1108,3710);      -- Arrogance Incarnate
UPDATE mob_skills SET mob_skill_aoe = '1', mob_anim_id = '642' WHERE mob_skill_id = '3710'; -- ArkEv Arrogance_Incarnate
UPDATE mob_skills SET mob_anim_id = '236' WHERE mob_skill_id = '3711'; -- ArkEv Vorpal_Blade
INSERT INTO `mob_skills` VALUES (3712,635,'dominion_slash',0,7.0,2000,1500,4,0,0,0,0,0,0); -- ArkEV Dominion_Slash
UPDATE mob_skills SET mob_anim_id = '2920' WHERE mob_skill_id = '3713'; -- ArkEv Chant_du_Cygne

-- Iroha II
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Iroha_II',1133,3733); -- Amatsu Kyori
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Iroha_II',1133,3734); -- Amatsu Hanadoki
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Iroha_II',1133,3736); -- Amatsu Gachirin
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Iroha_II',1133,3737); -- Amatsu Suien
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Iroha_II',1133,3738); -- Rise from Ashes