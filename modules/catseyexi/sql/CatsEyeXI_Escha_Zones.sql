-- Set Max HP/MP of Mobs in Sky 2.0
-- UPDATE mob_groups SET HP = "50000", MP = "50000", minLevel = "95", maxLevel = "95" WHERE name = "Byakko-Escha";
-- UPDATE mob_groups SET HP = "50000", MP = "50000", minLevel = "95", maxLevel = "95" WHERE name = "Genbu-Escha";
UPDATE mob_groups SET HP = "50000", MP = "50000", minLevel = "95", maxLevel = "95" WHERE name = "Seiryu-Escha";
UPDATE mob_groups SET HP = "50000", MP = "50000", minLevel = "95", maxLevel = "95" WHERE name = "Suzaku-Escha";
UPDATE mob_groups SET HP = "80000", MP = "50000", minLevel = "100", maxLevel = "100" WHERE name = "Kirin-Escha";

-- Byakko
INSERT INTO `mob_skills` VALUES (2207,1606,'disorienting_waul',1,20.0,2000,1500,4,0,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1680,984,'predatory_glare',4,10.0,2000,1500,4,0,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1681,17,'crossthrash',4,15.0,2000,1500,4,0,0,1,0,0,0);
INSERT INTO `mob_spell_lists` VALUES ('Byakko',999,5,1,255);   -- Cure_v
INSERT INTO `mob_spell_lists` VALUES ('Byakko',999,6,1,255);   -- Cure_vi
INSERT INTO `mob_spell_lists` VALUES ('Byakko',999,21,1,255);  -- Holy
INSERT INTO `mob_spell_lists` VALUES ('Byakko',999,22,1,255);  -- Holy_ii
INSERT INTO `mob_spell_lists` VALUES ('Byakko',999,25,1,255);  -- Dia_iii
INSERT INTO `mob_spell_lists` VALUES ('Byakko',999,31,1,255);  -- Banish_iv
INSERT INTO `mob_spell_lists` VALUES ('Byakko',999,35,1,255);  -- Diaga_iii
INSERT INTO `mob_spell_lists` VALUES ('Byakko',999,40,1,255);  -- Banishga_iii
INSERT INTO `mob_spell_lists` VALUES ('Byakko',999,227,1,255); -- Poisonga III
INSERT INTO `mob_spell_lists` VALUES ('Byakko',999,274,1,255); -- Sleepga II
INSERT INTO `mob_spell_lists` VALUES ('Byakko',999,357,1,255); -- Slowga
INSERT INTO `mob_spell_lists` VALUES ('Byakko',999,359,1,255); -- Silencega
INSERT INTO `mob_spell_lists` VALUES ('Byakko',999,360,1,255); -- Dispelga
INSERT INTO `mob_spell_lists` VALUES ('Byakko',999,361,1,255); -- Blindga
INSERT INTO `mob_spell_lists` VALUES ('Byakko',999,362,1,255); -- Bindga
INSERT INTO `mob_spell_lists` VALUES ('Byakko',999,365,1,255); -- Breakga
INSERT INTO `mob_spell_lists` VALUES ('Byakko',999,366,1,255); -- Graviga
INSERT INTO `mob_skill_lists` VALUES ('Byakko',5017,270);
INSERT INTO `mob_skill_lists` VALUES ('Byakko',5017,271);
INSERT INTO `mob_skill_lists` VALUES ('Byakko',5017,273);
INSERT INTO `mob_skill_lists` VALUES ('Byakko',5017,1680);     -- Predatory Glare
INSERT INTO `mob_skill_lists` VALUES ('Byakko',5017,1681);     -- Crossthrash
INSERT INTO `mob_skill_lists` VALUES ('Byakko',5017,2207);     -- Disorienting Waul
UPDATE `mob_groups` SET `dropid`='3990', `HP`='50000', `MP`='50000', `minLevel` = "95", `maxLevel`='95' WHERE  `groupid` = "78" AND `zoneid` = "289";
UPDATE `mob_pools` SET `spellList`='999', `skill_list_id`='5017' WHERE  `poolid`=5690;

-- Genbu-Escha
INSERT INTO `mob_spell_lists` VALUES ('Genbu',998,172,1,255);  -- Water 4
INSERT INTO `mob_spell_lists` VALUES ('Genbu',998,201,1,255);  -- Waterga III
INSERT INTO `mob_spell_lists` VALUES ('Genbu',998,214,1,255);  -- Flood
INSERT INTO `mob_spell_lists` VALUES ('Genbu',998,503,1,255);  -- Impact
INSERT INTO `mob_spell_lists` VALUES ('Genbu',998,61,1,255); -- Cure IV

INSERT INTO `mob_skill_lists` VALUES ('Genbu',5018,806);     -- Tortoise Stomp
INSERT INTO `mob_skill_lists` VALUES ('Genbu',5018,807);     -- Harden Shell
INSERT INTO `mob_skill_lists` VALUES ('Genbu',5018,809);     -- Aqua Breath
INSERT INTO `mob_skill_lists` VALUES ('Genbu',5018,2360);    -- Wind Shear (ZNM)
INSERT INTO `mob_skill_lists` VALUES ('Genbu',5018,1836);    -- Nerve Gas
INSERT INTO `mob_skill_lists` VALUES ('Genbu',5018,355);     -- Earth Pounder
UPDATE `mob_groups` SET `dropid`='3991', `HP`='50000', `MP`='50000', `minLevel` = "95", `maxLevel`='95' WHERE  `groupid` = "79" AND `zoneid` = "289";
UPDATE `mob_pools` SET `spellList`='998', `skill_list_id`='5018' WHERE  `poolid`=5695;

-- Reduce gil drops from Shadow Dragons in Escha Zi'Tah
UPDATE mob_family_mods SET value = "500" WHERE familyid = "87" and modid = "54";
