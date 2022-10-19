

LOCK TABLES `mob_spell_lists` WRITE;

-- Fire V
DELETE FROM `mob_spell_lists` WHERE spell_id = 148 AND spell_list_name = "Beastmen_BLM";
DELETE FROM `mob_spell_lists` WHERE spell_id = 148 AND spell_list_name = "Hecteyes";
DELETE FROM `mob_spell_lists` WHERE spell_id = 148 AND spell_list_name = "Ahriman";
DELETE FROM `mob_spell_lists` WHERE spell_id = 148 AND spell_list_name = "Elemental_Fire";
DELETE FROM `mob_spell_lists` WHERE spell_id = 148 AND spell_list_name = "Undead";
DELETE FROM `mob_spell_lists` WHERE spell_id = 148 AND spell_list_name = "MagicPot";
DELETE FROM `mob_spell_lists` WHERE spell_id = 148 AND spell_list_name = "Disaster_Idol_Firesday";

-- Blizzard V
DELETE FROM `mob_spell_lists` WHERE spell_id = 153 AND spell_list_name = "Beastmen_BLM";
DELETE FROM `mob_spell_lists` WHERE spell_id = 153 AND spell_list_name = "Elemental_Ice";
DELETE FROM `mob_spell_lists` WHERE spell_id = 153 AND spell_list_name = "Undead";
DELETE FROM `mob_spell_lists` WHERE spell_id = 153 AND spell_list_name = "MagicPot";
DELETE FROM `mob_spell_lists` WHERE spell_id = 153 AND spell_list_name = "Disaster_Idol_Iceday";

-- Aero V
DELETE FROM `mob_spell_lists` WHERE spell_id = 158 AND spell_list_name = "Beastmen_BLM";
DELETE FROM `mob_spell_lists` WHERE spell_id = 158 AND spell_list_name = "Hecteyes";
DELETE FROM `mob_spell_lists` WHERE spell_id = 158 AND spell_list_name = "Ahriman";
DELETE FROM `mob_spell_lists` WHERE spell_id = 158 AND spell_list_name = "Elemental_Air";
DELETE FROM `mob_spell_lists` WHERE spell_id = 158 AND spell_list_name = "Undead";
DELETE FROM `mob_spell_lists` WHERE spell_id = 158 AND spell_list_name = "MagicPot";
DELETE FROM `mob_spell_lists` WHERE spell_id = 158 AND spell_list_name = "Disaster_Idol_Windsday";

-- Stone V
DELETE FROM `mob_spell_lists` WHERE spell_id = 163 AND spell_list_name = "Beastmen_BLM";
DELETE FROM `mob_spell_lists` WHERE spell_id = 163 AND spell_list_name = "Worm";
DELETE FROM `mob_spell_lists` WHERE spell_id = 163 AND spell_list_name = "Elemental_Earth";
DELETE FROM `mob_spell_lists` WHERE spell_id = 163 AND spell_list_name = "Undead";
DELETE FROM `mob_spell_lists` WHERE spell_id = 163 AND spell_list_name = "MagicPot";
DELETE FROM `mob_spell_lists` WHERE spell_id = 163 AND spell_list_name = "Tzee_Xicu_Idol";
DELETE FROM `mob_spell_lists` WHERE spell_id = 163 AND spell_list_name = "Disaster_Idol_Earthsday";
DELETE FROM `mob_spell_lists` WHERE spell_id = 163 AND spell_list_name = "Ghrah_Earth";

-- Thunder V
DELETE FROM `mob_spell_lists` WHERE spell_id = 168 AND spell_list_name = "Beastmen_BLM";
DELETE FROM `mob_spell_lists` WHERE spell_id = 168 AND spell_list_name = "Hecteyes";
DELETE FROM `mob_spell_lists` WHERE spell_id = 168 AND spell_list_name = "Ahriman";
DELETE FROM `mob_spell_lists` WHERE spell_id = 168 AND spell_list_name = "Elemental_Thunder";
DELETE FROM `mob_spell_lists` WHERE spell_id = 168 AND spell_list_name = "Undead";
DELETE FROM `mob_spell_lists` WHERE spell_id = 168 AND spell_list_name = "MagicPot";
DELETE FROM `mob_spell_lists` WHERE spell_id = 168 AND spell_list_name = "Disaster_Idol_Lightningsday";

-- Water V
DELETE FROM `mob_spell_lists` WHERE spell_id = 173 AND spell_list_name = "Beastmen_BLM";
DELETE FROM `mob_spell_lists` WHERE spell_id = 173 AND spell_list_name = "Hecteyes";
DELETE FROM `mob_spell_lists` WHERE spell_id = 173 AND spell_list_name = "Elemental_Water";
DELETE FROM `mob_spell_lists` WHERE spell_id = 173 AND spell_list_name = "Undead";
DELETE FROM `mob_spell_lists` WHERE spell_id = 173 AND spell_list_name = "MagicPot";
DELETE FROM `mob_spell_lists` WHERE spell_id = 173 AND spell_list_name = "Disaster_Idol_Watersday";
DELETE FROM `mob_spell_lists` WHERE spell_id = 173 AND spell_list_name = "Ghrah_Water";

-- Stonega IV
DELETE FROM `mob_spell_lists` WHERE spell_id = 192 AND spell_list_name = "Animated_Staff";

-- Regen IV
DELETE FROM `mob_spell_lists` WHERE spell_id = 477 AND spell_list_name = "Beastmen_WHM";
DELETE FROM `mob_spell_lists` WHERE spell_id = 477 AND spell_list_name = "Elemental_Light";

-- Cure VI
DELETE FROM `mob_spell_lists` WHERE spell_id = 6 AND spell_list_name = "Beastmen_WHM";
DELETE FROM `mob_spell_lists` WHERE spell_id = 6 AND spell_list_name = "Elemental_Light";

-- Aspir II -- TODO (Look into Dyna Casting)
DELETE FROM `mob_spell_lists` WHERE spell_id = 248 AND spell_list_name = "Beastmen_BLM";
DELETE FROM `mob_spell_lists` WHERE spell_id = 248 AND spell_list_name = "Undead";
DELETE FROM `mob_spell_lists` WHERE spell_id = 248 AND spell_list_name = "MagicPot";

-- Foe Requiem VII
DELETE FROM `mob_spell_lists` WHERE spell_id = 374 AND spell_list_name = "Beastmen_BRD";

-- Horde Lullby II
DELETE FROM `mob_spell_lists` WHERE spell_id = 377 AND spell_list_name = "Beastmen_BRD";

-- Army's Paeon VI
DELETE FROM `mob_spell_lists` WHERE spell_id = 383 AND spell_list_name = "Beastmen_BRD";

UNLOCK TABLES;

