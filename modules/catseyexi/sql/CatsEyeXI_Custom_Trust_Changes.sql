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

-- Mob Skills Mayakov
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Mayakov',1081,41); -- Swift Blade
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Mayakov',1081,40);  -- Vorpal Blade
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Mayakov',1081,42);  -- Savage Blade

-- Mob Skills Leonoyne
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Leonoyne',1089,60); -- Resolution
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Leonoyne',1089,56); -- Ground Strike
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Leonoyne',1089,55); -- Spinning Slash
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Leonoyne',1089,58); -- Herculean Strike

-- Mob Skills Gilgamesh
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Gilgamesh',1053,3434); -- Tachi Kamai
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Gilgamesh',1053,3435); -- Iainuki
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Gilgamesh',1053,3436); -- Tachi Gotem
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Gilgamesh',1053,3437); -- Tachi Kasha

-- Mob Spells Leonoyne
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Leonoyne',387,149,20,255); -- Blizzard
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Leonoyne',387,150,46,255); -- Blizzard II
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Leonoyne',387,151,66,255); -- Blizzard III
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Leonoyne',387,164,21,255); -- Thunder
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Leonoyne',387,165,46,255); -- Thunder II
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Leonoyne',387,166,66,255); -- Thunder III

-- Mob Skills Matsui-P
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Matsui-P',1148,128); -- Blade: Rin
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Matsui-P',1148,129); -- Blade: Retsu
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Matsui-P',1148,133); -- Blade: Ei
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Matsui-P',1148,134); -- Blade: Jin
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Matsui-P',1148,135); -- Blade: Ten
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Matsui-P',1148,136); -- Blade: Ku
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Matsui-P',1148,141); -- Blade: Shun
INSERT INTO `mob_skill_lists` VALUES ('TRUST_Matsui-P',1148,138); -- Blade: Kamu

-- Mob Spell List Matsui-P
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Matsui-P',435,144,26,255); -- Fire
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Matsui-P',435,149,34,255); -- Blizzard
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Matsui-P',435,154,18,255); -- Aero
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Matsui-P',435,159,1,255);  -- Stone
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Matsui-P',435,164,42,255); -- Thunder
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Matsui-P',435,169,10,255); -- Water
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Matsui-P',435,245,24,255); -- Drain
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Matsui-P',435,247,50,255); -- Aspir
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Matsui-P',435,252,90,255); -- Stun
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Matsui-P',435,149,15,255); -- Katon: Ichi
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Matsui-P',435,149,40,255); -- Katon: Ni
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Matsui-P',435,149,75,255); -- Katon: San
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Matsui-P',435,149,15,255); -- Hyoton: Ichi
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Matsui-P',435,149,40,255); -- Hyoton: Ni
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Matsui-P',435,149,75,255); -- Hyoton: San
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Matsui-P',435,149,15,255); -- Huton: Ichi
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Matsui-P',435,149,40,255); -- Huton: Ni
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Matsui-P',435,149,75,255); -- Huton: San
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Matsui-P',435,149,15,255); -- Doton: Ichi
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Matsui-P',435,149,40,255); -- Doton: Ni
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Matsui-P',435,149,75,255); -- Doton: San
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Matsui-P',435,149,15,255); -- Raiton: Ichi
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Matsui-P',435,149,40,255); -- Raiton: Ni
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Matsui-P',435,149,75,255); -- Raiton: San
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Matsui-P',435,149,15,255); -- Suiton: Ichi
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Matsui-P',435,149,40,255); -- Suiton: Ni
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Matsui-P',435,149,75,255); -- Suiton: San
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Matsui-P',435,149,12,255); -- Utsusemi: Ichi
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Matsui-P',435,149,37,255); -- Utsusemi: Ni
INSERT INTO `mob_spell_lists` VALUES ('TRUST_Matsui-P',435,149,99,255); -- Utsusemi: San

UPDATE mob_pools SET sJob = "4" WHERE poolid = "5931" AND name = 'moogle';
UPDATE mob_pools SET mJob = "13" WHERE poolid = "5931" AND name = 'moogle';
UPDATE mob_pools SET skill_list_id = "1148" WHERE poolid = "5931" AND name = 'moogle';
UPDATE mob_pools SET spellList = "435" WHERE poolid = "5931" AND name = 'moogle';