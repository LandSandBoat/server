LOCK TABLES `mob_family_mods` WRITE;

-- Fomor (remove SLEEPRES and LULLABYRES)
DELETE FROM `mob_family_mods` WHERE familyid = 115 and modid = 240;
DELETE FROM `mob_family_mods` WHERE familyid = 115 and modid = 254;

-- Fomor (remove SLEEPRES and LULLABYRES)
DELETE FROM `mob_family_mods` WHERE familyid = 359 and modid = 240;
DELETE FROM `mob_family_mods` WHERE familyid = 359 and modid = 254;

UNLOCK TABLES;
