-- Buarainech
INSERT INTO `mob_droplist` VALUES(3225, 0, 0, 1000, 2858, 250); -- Wolfram Steel Ingot
INSERT INTO `mob_droplist` VALUES(3225, 0, 1, 1000, 2858, 250); -- Wolfram Steel Ingot
INSERT INTO `mob_droplist` VALUES(3225, 0, 2, 1000, 2858, 250); -- Wolfram Steel Ingot
INSERT INTO `mob_droplist` VALUES(3225, 0, 3, 1000, 2859, 313); -- Chunk of Cobalt Ore
INSERT INTO `mob_droplist` VALUES(3225, 0, 4, 1000, 19307, 125); -- Blunt Lance
INSERT INTO `mob_droplist` VALUES(3225, 0, 5, 1000, 11411, 188); -- Shrewd Pumps
INSERT INTO `mob_droplist` VALUES(3225, 0, 6, 1000, 747, 150); -- Orichalcum Ingot
-- Elatha
INSERT INTO `mob_droplist` VALUES(3226, 0, 0, 1000, 2858, 260); -- Wolfram Steel Ingot
INSERT INTO `mob_droplist` VALUES(3226, 0, 1, 1000, 2858, 260); -- Wolfram Steel Ingot
INSERT INTO `mob_droplist` VALUES(3226, 0, 2, 1000, 2858, 260); -- Wolfram Steel Ingot
INSERT INTO `mob_droplist` VALUES(3226, 0, 3, 1000, 2859, 263); -- Chunk of Cobalt Ore
INSERT INTO `mob_droplist` VALUES(3226, 0, 4, 1000, 19162, 316); -- Dull Claymore
INSERT INTO `mob_droplist` VALUES(3226, 0, 5, 1000, 15057, 272); -- Bricta's Cuffs
INSERT INTO `mob_droplist` VALUES(3226, 0, 6, 1000, 747, 82); -- Orichalcum Ingot
-- Lugh
INSERT INTO `mob_droplist` VALUES(3227, 0, 0, 1000, 2858, 500); -- Wolfram Steel Ingot
INSERT INTO `mob_droplist` VALUES(3227, 0, 1, 1000, 2858, 500); -- Wolfram Steel Ingot
INSERT INTO `mob_droplist` VALUES(3227, 0, 2, 1000, 2858, 500); -- Wolfram Steel Ingot
INSERT INTO `mob_droplist` VALUES(3227, 0, 3, 1000, 2859, 154); -- Chunk of Cobalt Ore
INSERT INTO `mob_droplist` VALUES(3227, 0, 4, 1000, 17767, 154); -- Chipped Scimitar
INSERT INTO `mob_droplist` VALUES(3227, 0, 5, 1000, 11410, 77); -- Setanta's Ledelsens
INSERT INTO `mob_droplist` VALUES(3227, 0, 6, 1000, 747, 86); -- Orichalcum Ingot
-- Ethniu
INSERT INTO `mob_droplist` VALUES(3228, 0, 0, 1000, 2858, 520); -- Wolfram Steel Ingot
INSERT INTO `mob_droplist` VALUES(3228, 0, 1, 1000, 2858, 520); -- Wolfram Steel Ingot
INSERT INTO `mob_droplist` VALUES(3228, 0, 2, 1000, 2858, 520); -- Wolfram Steel Ingot
INSERT INTO `mob_droplist` VALUES(3228, 0, 3, 1000, 2859, 200); -- Chunk of Cobalt Ore
INSERT INTO `mob_droplist` VALUES(3228, 0, 4, 1000, 19128, 200); -- Edgeless Knife
INSERT INTO `mob_droplist` VALUES(3228, 0, 5, 1000, 16376, 200); -- Bahram Cuisses
INSERT INTO `mob_droplist` VALUES(3228, 0, 6, 1000, 15772, 200); -- Scintillant Ingot
INSERT INTO `mob_droplist` VALUES(3228, 0, 7, 1000, 747, 50); -- Orichalcum Ingot
-- Tethra
INSERT INTO `mob_droplist` VALUES(3229, 0, 0, 1000, 2858, 550); -- Wolfram Steel Ingot
INSERT INTO `mob_droplist` VALUES(3229, 0, 0, 1000, 2858, 550); -- Wolfram Steel Ingot
INSERT INTO `mob_droplist` VALUES(3229, 0, 0, 1000, 2858, 550); -- Wolfram Steel Ingot
INSERT INTO `mob_droplist` VALUES(3229, 0, 0, 1000, 2859, 430); -- Chunk of Cobalt Ore
INSERT INTO `mob_droplist` VALUES(3229, 0, 0, 1000, 18617, 233); -- Cracked Staff
INSERT INTO `mob_droplist` VALUES(3229, 0, 0, 1000, 16302, 167); -- Bloodbead Gorget
INSERT INTO `mob_droplist` VALUES(3229, 0, 0, 1000, 15772, 167); -- Scintillant Ingot
INSERT INTO `mob_droplist` VALUES(3229, 0, 0, 1000, 747, 100); -- Orichalcum Ingot

UPDATE `mob_groups` SET `respawntime`='14400', `spawntype`='0', `dropid`='3227', `HP`='34433', `MP`='20000', `maxLevel`='82' WHERE  `zoneid`=171 AND `groupid`=18;
UPDATE `mob_groups` SET `respawntime`='14400', `spawntype`='0', `dropid`='3229', `HP`='25291', `MP`='20000', `maxLevel`='82' WHERE  `zoneid`=175 AND `groupid`=23;
UPDATE `mob_groups` SET `respawntime`='14400', `spawntype`='0', `dropid`='3228', `HP`='25291', `MP`='20000', `maxLevel`='82' WHERE  `zoneid`=175 AND `groupid`=14;
UPDATE `mob_groups` SET `respawntime`='14400', `spawntype`='0', `dropid`='3225', `HP`='17214', `MP`='20000', `maxLevel`='82' WHERE  `zoneid`=164 AND `groupid`=18;
UPDATE `mob_groups` SET `respawntime`='14400', `spawntype`='0', `dropid`='3226', `HP`='49486', `MP`='20000', `maxLevel`='82' WHERE  `zoneid`=164 AND `groupid`=15;

UPDATE `mob_pools` SET `spellList`='464', `skill_list_id`='5016' WHERE  `poolid`=6886;
UPDATE `mob_pools` SET `spellList`='460', `skill_list_id`='5012' WHERE  `poolid`=5143;
UPDATE `mob_pools` SET `spellList`='461', `skill_list_id`='5013' WHERE  `poolid`=5144;
UPDATE `mob_pools` SET `spellList`='462', `skill_list_id`='5014' WHERE  `poolid`=4696;
UPDATE `mob_pools` SET `spellList`='463', `skill_list_id`='5015' WHERE  `poolid`=6885;

-- Buarainech
INSERT INTO `mob_skill_lists` VALUES('Buarainech', 5012, 248); -- Grim Halo
INSERT INTO `mob_skill_lists` VALUES('Buarainech', 5012, 116); -- Penta Thrust
INSERT INTO `mob_skill_lists` VALUES('Buarainech', 5012, 120); -- Impulse Drive
INSERT INTO `mob_skill_lists` VALUES('Buarainech', 5012, 114); -- Raiden Thrust
INSERT INTO `mob_skill_lists` VALUES('Buarainech', 5012, 249); -- Netherspikes
-- Elatha
INSERT INTO `mob_skill_lists` VALUES('Elatha', 5013, 248); -- Grim Halo
INSERT INTO `mob_skill_lists` VALUES('Elatha', 5013, 249); -- Netherspikes
INSERT INTO `mob_skill_lists` VALUES('Elatha', 5013, 242); -- Carnal Nightmare
INSERT INTO `mob_skill_lists` VALUES('Elatha', 5013, 52); -- Shockwave
INSERT INTO `mob_skill_lists` VALUES('Elatha', 5013, 56); -- Ground Strike
INSERT INTO `mob_skill_lists` VALUES('Elatha', 5013, 51); -- Freezebite
-- Lugh
INSERT INTO `mob_skill_lists` VALUES('Lugh', 5014, 247); -- Foxfire
INSERT INTO `mob_skill_lists` VALUES('Lugh', 5014, 249); -- Netherspikes
INSERT INTO `mob_skill_lists` VALUES('Lugh', 5014, 242); -- Carnal Nightmare
INSERT INTO `mob_skill_lists` VALUES('Lugh', 5014, 34); -- Red Lotus Blade
INSERT INTO `mob_skill_lists` VALUES('Lugh', 5014, 38); -- Circle Blade
INSERT INTO `mob_skill_lists` VALUES('Lugh', 5014, 42); -- Savage Blade
-- Ethniu
INSERT INTO `mob_skill_lists` VALUES('Ethniu', 5015, 247); -- Foxfire
INSERT INTO `mob_skill_lists` VALUES('Ethniu', 5015, 249); -- Netherspikes
INSERT INTO `mob_skill_lists` VALUES('Ethniu', 5015, 242); -- Carnal Nightmare
INSERT INTO `mob_skill_lists` VALUES('Ethniu', 5015, 19); -- Gust Slash
INSERT INTO `mob_skill_lists` VALUES('Ethniu', 5015, 20); -- Cyclone
INSERT INTO `mob_skill_lists` VALUES('Ethniu', 5015, 25); -- Evisceration
-- Tethra
INSERT INTO `mob_skill_lists` VALUES('Tethra', 5016, 248); -- Grim Halo
INSERT INTO `mob_skill_lists` VALUES('Tethra', 5016, 249); -- Netherspikes
INSERT INTO `mob_skill_lists` VALUES('Tethra', 5016, 242); -- Carnal Nightmare
INSERT INTO `mob_skill_lists` VALUES('Tethra', 5016, 177); -- Rock Crusher
INSERT INTO `mob_skill_lists` VALUES('Tethra', 5016, 178); -- Earth Crusher
INSERT INTO `mob_skill_lists` VALUES('Tethra', 5016, 184); -- Retribution

-- Buarainech
INSERT INTO `mob_spell_lists` VALUES('Buarainech', 460, 532, 1, 255); -- Blue Magic: Blitzstrahl
INSERT INTO `mob_spell_lists` VALUES('Buarainech', 460, 644, 1, 255); -- Blue Magic: Mind Blast
INSERT INTO `mob_spell_lists` VALUES('Buarainech', 460, 616, 1, 255); -- Blue Magic: Temporal Shift
INSERT INTO `mob_spell_lists` VALUES('Buarainech', 460, 615, 1, 255); -- Blue Magic: Plasma Charge
INSERT INTO `mob_spell_lists` VALUES('Buarainech', 460, 212, 1, 255); -- Black Magic: Burst
INSERT INTO `mob_spell_lists` VALUES('Buarainech', 460, 196, 1, 255); -- Black Magic: Thundaga III
INSERT INTO `mob_spell_lists` VALUES('Buarainech', 460, 167, 1, 255); -- Black Magic: Thunder IV
INSERT INTO `mob_spell_lists` VALUES('Buarainech', 460, 512, 1, 252); -- Stun
INSERT INTO `mob_spell_lists` VALUES('Buarainech', 460, 57, 1, 252); -- Haste
-- Elatha
INSERT INTO `mob_spell_lists` VALUES('Elatha', 461, 531, 1, 255); -- Blue Magic: Ice Break
INSERT INTO `mob_spell_lists` VALUES('Elatha', 461, 535, 1, 255); -- Blue Magic: Cold Wave
INSERT INTO `mob_spell_lists` VALUES('Elatha', 461, 608, 1, 255); -- Blue Magic: Frost Breath
INSERT INTO `mob_spell_lists` VALUES('Elatha', 461, 206, 1, 255); -- Black Magic: Freeze
INSERT INTO `mob_spell_lists` VALUES('Elatha', 461, 181, 1, 255); -- Black Magic: Blizzaga III
INSERT INTO `mob_spell_lists` VALUES('Elatha', 461, 152, 1, 255); -- Black Magic: Blizzard IV
-- Lugh
INSERT INTO `mob_spell_lists` VALUES('Lugh', 462, 588, 1, 255); -- Blue Magic: Lowing
INSERT INTO `mob_spell_lists` VALUES('Lugh', 462, 591, 1, 255); -- Blue Magic: Heat Breath
INSERT INTO `mob_spell_lists` VALUES('Lugh', 462, 645, 1, 255); -- Blue Magic: Exuviation
INSERT INTO `mob_spell_lists` VALUES('Lugh', 462, 204, 1, 255); -- Black Magic: Flare
INSERT INTO `mob_spell_lists` VALUES('Lugh', 462, 176, 1, 255); -- Black Magic: Firaga III
INSERT INTO `mob_spell_lists` VALUES('Lugh', 462, 147, 1, 255); -- Black Magic: Fire IV
-- Ethniu
INSERT INTO `mob_spell_lists` VALUES('Ethniu', 463, 563, 1, 255); -- Blue Magic: Hecatomb Wave
INSERT INTO `mob_spell_lists` VALUES('Ethniu', 463, 647, 1, 255); -- Blue Magic: Zephyr Mantle
INSERT INTO `mob_spell_lists` VALUES('Ethniu', 463, 561, 1, 255); -- Blue Magic: Frightful Roar
INSERT INTO `mob_spell_lists` VALUES('Ethniu', 463, 208, 1, 255); -- Black Magic: Tornado
INSERT INTO `mob_spell_lists` VALUES('Ethniu', 463, 186, 1, 255); -- Black Magic: Aeroga III
INSERT INTO `mob_spell_lists` VALUES('Ethniu', 463, 157, 1, 255); -- Black Magic: Aero IV
INSERT INTO `mob_spell_lists` VALUES('Ethniu', 463, 359, 1, 255); -- White Magic: Silencega
INSERT INTO `mob_spell_lists` VALUES('Ethniu', 463, 366, 1, 255); -- Black Magic: Graviga
-- Tethra
INSERT INTO `mob_spell_lists` VALUES('Tethra', 464, 524, 1, 255); -- Blue Magic: Sandspin
INSERT INTO `mob_spell_lists` VALUES('Tethra', 464, 548, 1, 255); -- Blue Magic: Filamented Hold
INSERT INTO `mob_spell_lists` VALUES('Tethra', 464, 555, 1, 255); -- Blue Magic: Magnetite Cloud
INSERT INTO `mob_spell_lists` VALUES('Tethra', 464, 210, 1, 255); -- Black Magic: Quake
INSERT INTO `mob_spell_lists` VALUES('Tethra', 464, 191, 1, 255); -- Black Magic: Stonega III
INSERT INTO `mob_spell_lists` VALUES('Tethra', 464, 162, 1, 255); -- Black Magic: Stone IV
INSERT INTO `mob_spell_lists` VALUES('Tethra', 464, 357, 1, 255); -- White Magic: Slowga
INSERT INTO `mob_spell_lists` VALUES('Tethra', 464, 365, 1, 255); -- Black Magic: Breakga