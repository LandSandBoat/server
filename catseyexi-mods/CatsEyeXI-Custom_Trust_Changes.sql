# Change Elviras default jobs
UPDATE mob_pools SET mJob = 17 WHERE poolid =1198 AND `name` = 'Elivira';
UPDATE mob_pools SET mJob = 17 WHERE poolid = 5941 AND `name` = 'elivira';

# Add our custom mobskills to trusts
INSERT INTO `mob_skills` VALUES (3710,642,'arrogance_incarnate',1,7.0,2000,1500,4,0,0,0,0,0,0); --ArkEV
INSERT INTO `mob_skills` VALUES (3711,236,'vorpal_blade',0,7.0,2000,1500,4,0,0,0,0,0,0); -- ArkEV
INSERT INTO `mob_skills` VALUES (3712,635,'dominion_slash',0,7.0,2000,1500,4,0,0,0,0,0,0); --ArkEV
INSERT INTO `mob_skills` VALUES (3713,2920,'chant_du_cygne',0,7.0,2000,1500,4,0,0,0,0,0,0); --ArkEV
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Elivira',1056,1201); -- Coronach (Elivira)
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Halver',1087,114); -- Raiden Thrust
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Halver',1087,116); -- Penta Thrust
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Halver',1087,120); -- Impulse Drive
INSERT INTO `mob_skill_lists` VALUES ('TRUST_AAEV',1108,3711);      -- Vorpal Blade
INSERT INTO `mob_skill_lists` VALUES ('TRUST_AAEV',1108,3713);      -- Chant du Cygne
INSERT INTO `mob_skill_lists` VALUES ('TRUST_AAEV',1108,3712);      -- Dominion Slash
INSERT INTO `mob_skill_lists` VALUES ('TRUST_AAEV',1108,3710);      -- Arrogance Incarnate