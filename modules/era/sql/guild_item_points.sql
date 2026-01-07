-- --------------------------------------------------------
-- Guild Item Points - Era Corrections
-- --------------------------------------------------------

-- Divide all max_points by 3 for LSB adjustment
UPDATE `guild_item_points`
SET `max_points` = `max_points` / 3;

-- ========================================================
-- FISHING (guildid=0)
-- ========================================================
-- Amateur (rank 0)
UPDATE `guild_item_points` SET `itemid`=5125, `points`=12, `max_points`=1120 WHERE `guildid`=0 AND `itemid`=4401 AND `pattern`=3; -- Moat Carp -> Phanauet Newt (12/1120)

-- Recruit (rank 1)
UPDATE `guild_item_points` SET `itemid`=4500, `points`=24, `max_points`=1520 WHERE `guildid`=0 AND `itemid`=5473 AND `pattern`=4; -- Bastore Sweeper -> Greedie (24/1520)
UPDATE `guild_item_points` SET `itemid`=4500, `points`=24, `max_points`=1520 WHERE `guildid`=0 AND `itemid`=5473 AND `pattern`=5; -- Bastore Sweeper -> Greedie (24/1520)

-- Novice (rank 3)
UPDATE `guild_item_points` SET `points`=78, `max_points`=6720 WHERE `guildid`=0 AND `itemid`=4354 AND `pattern`=0; -- Shining Trout (78/6720)
UPDATE `guild_item_points` SET `itemid`=4428, `points`=60, `max_points`=2160 WHERE `guildid`=0 AND `itemid`=5141 AND `pattern`=3; -- Veydal Wrasse -> Dark Bass (60/2160)
UPDATE `guild_item_points` SET `itemid`=4428, `points`=60, `max_points`=2160 WHERE `guildid`=0 AND `itemid`=4354 AND `pattern`=6; -- Shining Trout -> Dark Bass (60/2160)

-- Apprentice (rank 4)
UPDATE `guild_item_points` SET `itemid`=4291, `points`=78, `max_points`=2400 WHERE `guildid`=0 AND `itemid`=4429 AND `pattern`=6; -- Black Eel -> Sandfish (78/2400)

-- ========================================================
-- WOODWORKING (guildid=1)
-- ========================================================
-- Amateur (rank 0)
UPDATE `guild_item_points` SET `itemid`=17049, `points`=13, `max_points`=1200 WHERE `guildid`=1 AND `itemid`=17868 AND `pattern`=1; -- Humus -> Maple Wand (13/1200)
UPDATE `guild_item_points` SET `itemid`=17087, `points`=13, `max_points`=1200 WHERE `guildid`=1 AND `itemid`=17869 AND `pattern`=1; -- Rich Humus -> Maple Wand +1 (13/1200)
UPDATE `guild_item_points` SET `itemid`=17088, `points`=16, `max_points`=1200 WHERE `guildid`=1 AND `itemid`=22 AND `pattern`=3; -- Workbench -> Ash Staff (16/1200)
INSERT INTO `guild_item_points` VALUES (1,17123,0,24,1200,3); -- Ash Staff +1 - Amateur Pattern D
UPDATE `guild_item_points` SET `itemid`=17024, `points`=18, `max_points`=1200 WHERE `guildid`=1 AND `itemid`=12289 AND `pattern`=4; -- Lauan Shield -> Ash Club (18/1200)
UPDATE `guild_item_points` SET `itemid`=17137, `points`=26, `max_points`=1200 WHERE `guildid`=1 AND `itemid`=12333 AND `pattern`=4; -- Lauan Shield +1 -> Ash Club +1 (26/1200)
UPDATE `guild_item_points` SET `itemid`=17345, `points`=12, `max_points`=1120 WHERE `guildid`=1 AND `itemid`=17868 AND `pattern`=7; -- Humus -> Flute (12/1120)
UPDATE `guild_item_points` SET `itemid`=17372, `points`=14, `max_points`=1120 WHERE `guildid`=1 AND `itemid`=17869 AND `pattern`=7; -- Rich Humus -> Flute +1 (14/1120)

-- Recruit (rank 1)
UPDATE `guild_item_points` SET `itemid`=12984, `points`=31, `max_points`=1520 WHERE `guildid`=1 AND `itemid`=17389 AND `pattern`=2; -- Bamboo Fishing Rod -> Ash Clogs (31/1520)
INSERT INTO `guild_item_points` VALUES (1,12983,1,39,1520,2); -- Ash Clogs +1 - Recruit Pattern C

-- Initiate (rank 2)
UPDATE `guild_item_points` SET `itemid`=17353, `points`=12, `max_points`=1680 WHERE `guildid`=1 AND `itemid`=1179 AND `pattern`=1; -- Shihei -> Maple Harp (12/1680)
INSERT INTO `guild_item_points` VALUES (1,17373,2,14,1680,1); -- Maple Harp +1 - Initiate Pattern B

-- Journeyman (rank 5)
UPDATE `guild_item_points` SET `itemid`=21, `points`=158, `max_points`=2880 WHERE `guildid`=1 AND `itemid`=17156 AND `pattern`=7; -- Kaman -> Desk (158/2880)
DELETE FROM `guild_item_points` WHERE `guildid`=1 AND `itemid`=17182 AND `pattern`=7; -- Remove Kaman +1 (no HQ for Desk)

-- Craftsman (rank 6)
UPDATE `guild_item_points` SET `itemid`=17561, `points`=4375, `max_points`=6640 WHERE `guildid`=1 AND `itemid`=16839 AND `pattern`=3; -- Partisan -> Revenging Staff (4375/6640)
UPDATE `guild_item_points` SET `itemid`=17562, `points`=5031, `max_points`=6640 WHERE `guildid`=1 AND `itemid`=16874 AND `pattern`=3; -- Partisan +1 -> Revenging Staff +1 (5031/6640)
UPDATE `guild_item_points` SET `itemid`=17240, `points`=3300, `max_points`=6320 WHERE `guildid`=1 AND `itemid`=17099 AND `pattern`=7; -- Mahogany Pole -> Lightning Bow (3300/6320)
UPDATE `guild_item_points` SET `itemid`=17241, `points`=4125, `max_points`=6320 WHERE `guildid`=1 AND `itemid`=17521 AND `pattern`=7; -- Mahogany Pole +1 -> Lightning Bow +1 (4125/6320)

-- Artisan (rank 7)
UPDATE `guild_item_points` SET `itemid`=17357, `points`=2587, `max_points`=6080 WHERE `guildid`=1 AND `itemid`=18093 AND `pattern`=7; -- Couse -> Ebony Harp (2587/6080)
UPDATE `guild_item_points` SET `itemid`=17833, `points`=2700, `max_points`=6080 WHERE `guildid`=1 AND `itemid`=18094 AND `pattern`=7; -- Couse +1 -> Ebony Harp +1 (2700/6080)

-- Adept (rank 8)
UPDATE `guild_item_points` SET `itemid`=17441, `points`=600, `max_points`=4320 WHERE `guildid`=1 AND `itemid`=17359 AND `pattern`=1; -- Mythic Harp -> Eremite's Wand (600/4320)
UPDATE `guild_item_points` SET `itemid`=17442, `points`=690, `max_points`=4320 WHERE `guildid`=1 AND `itemid`=17834 AND `pattern`=1; -- Mythic Harp +1 -> Eremite's Wand +1 (690/4320)
UPDATE `guild_item_points` SET `itemid`=17236, `points`=6235, `max_points`=7040 WHERE `guildid`=1 AND `itemid`=358 AND `pattern`=3; -- Credenza -> Leo Crossbow (6235/7040)
INSERT INTO `guild_item_points` VALUES (1,17237,8,7040,7040,3); -- Leo Crossbow +1 - Adept Pattern D
UPDATE `guild_item_points` SET `itemid`=16890, `points`=1200, `max_points`=5120 WHERE `guildid`=1 AND `itemid`=61 AND `pattern`=6; -- Armoire -> Obelisk Lance (1200/5120)
INSERT INTO `guild_item_points` VALUES (1,16891,8,1300,5120,6); -- Obelisk Lance +1 - Adept Pattern G

-- ========================================================
-- BLACKSMITHING (guildid=2)
-- ========================================================
-- Amateur (rank 0)
UPDATE `guild_item_points` SET `itemid`=16448, `points`=39, `max_points`=1280 WHERE `guildid`=2 AND `itemid`=1021 AND `pattern`=3; -- Hatchet -> Bronze Dagger (39/1280)
INSERT INTO `guild_item_points` VALUES (2,16492,0,47,1280,3); -- Bronze Dagger +1 - Amateur Pattern D
UPDATE `guild_item_points` SET `itemid`=16465, `points`=41, `max_points`=1360 WHERE `guildid`=2 AND `itemid`=12432 AND `pattern`=5; -- Faceguard -> Bronze Knife (41/1360)
UPDATE `guild_item_points` SET `itemid`=16491, `points`=48, `max_points`=1360 WHERE `guildid`=2 AND `itemid`=12487 AND `pattern`=5; -- Faceguard +1 -> Bronze Knife +1 (48/1360)

-- Recruit (rank 1)
UPDATE `guild_item_points` SET `itemid`=17059, `points`=25, `max_points`=1520 WHERE `guildid`=2 AND `itemid`=16450 AND `pattern`=4; -- Dagger -> Bronze Rod (25/1520)
UPDATE `guild_item_points` SET `itemid`=17111, `points`=25, `max_points`=1520 WHERE `guildid`=2 AND `itemid`=16736 AND `pattern`=4; -- Dagger +1 -> Bronze Rod +1 (25/1520)

-- Adept (rank 8)
UPDATE `guild_item_points` SET `itemid`=16950, `points`=7520, `max_points`=7520 WHERE `guildid`=2 AND `itemid`=18858 AND `pattern`=5; -- Flanged Mace -> Mythril Heart (7520/7520)
UPDATE `guild_item_points` SET `itemid`=16951, `points`=7520, `max_points`=7520 WHERE `guildid`=2 AND `itemid`=18860 AND `pattern`=5; -- Flanged Mace +1 -> Mythril Heart +1 (7520/7520)

-- ========================================================
-- GOLDSMITHING (guildid=3)
-- ========================================================
-- Recruit (rank 1)
UPDATE `guild_item_points` SET `itemid`=13465, `points`=50, `max_points`=1600 WHERE `guildid`=3 AND `itemid`=12961 AND `pattern`=5; -- Brass Leggings -> Brass Ring (50/1600)
UPDATE `guild_item_points` SET `itemid`=13493, `points`=70, `max_points`=1600 WHERE `guildid`=3 AND `itemid`=13027 AND `pattern`=5; -- Brass Leggings +1 -> Brass Ring +1 (70/1600)

-- Journeyman (rank 5)
UPDATE `guild_item_points` SET `itemid`=14725, `points`=5250, `max_points`=6800 WHERE `guildid`=3 AND `itemid`=17512 AND `pattern`=3; -- Hydro Baghnakhs -> Melody Earring (5250/6800)
UPDATE `guild_item_points` SET `itemid`=14726, `points`=6000, `max_points`=6800 WHERE `guildid`=3 AND `itemid`=17513 AND `pattern`=3; -- Hydro Baghnakhs +1 -> Melody Earring +1 (6000/6800)

-- ========================================================
-- CLOTHCRAFT (guildid=4)
-- ========================================================
-- Recruit (rank 1)
UPDATE `guild_item_points` SET `itemid`=12600, `points`=60, `max_points`=1680 WHERE `guildid`=4 AND `itemid`=12968 AND `pattern`=3; -- Kyahan -> Robe (60/1680)
UPDATE `guild_item_points` SET `itemid`=12615, `points`=60, `max_points`=1680 WHERE `guildid`=4 AND `itemid`=13031 AND `pattern`=3; -- Kyahan +1 -> Robe +1 (60/1680)
UPDATE `guild_item_points` SET `itemid`=12728, `points`=33, `max_points`=1520 WHERE `guildid`=4 AND `itemid`=12864 AND `pattern`=5; -- Slacks -> Cuffs (33/1520)
UPDATE `guild_item_points` SET `itemid`=12744, `points`=41, `max_points`=1520 WHERE `guildid`=4 AND `itemid`=12898 AND `pattern`=5; -- Slacks +1 -> Cuffs +1 (41/1520)

-- ========================================================
-- LEATHERCRAFT (guildid=5)
-- ========================================================
-- Amateur (rank 0)
UPDATE `guild_item_points` SET `itemid`=13594, `points`=44, `max_points`=1360 WHERE `guildid`=5 AND `itemid`=12824 AND `pattern`=5; -- Leather Trousers -> Rabbit Mantle (44/1360)
UPDATE `guild_item_points` SET `itemid`=13599, `points`=56, `max_points`=1360 WHERE `guildid`=5 AND `itemid`=12908 AND `pattern`=5; -- Leather Trousers +1 -> Rabbit Mantle +1 (56/1360)

-- Novice (rank 3)
UPDATE `guild_item_points` SET `itemid`=13081, `points`=66, `max_points`=2160 WHERE `guildid`=5 AND `itemid`=14176 AND `pattern`=3; -- Field Boots -> Leather Gorget (66/2160)
UPDATE `guild_item_points` SET `itemid`=13069, `points`=86, `max_points`=2160 WHERE `guildid`=5 AND `itemid`=14177 AND `pattern`=3; -- Worker Boots -> Leather Gorget +1 (86/2160)

-- Journeyman (rank 5)
UPDATE `guild_item_points` SET `itemid`=14166, `points`=1000, `max_points`=4720 WHERE `guildid`=5 AND `itemid`=12995 AND `pattern`=6; -- Moccasins -> Desert Boots (1000/4720)
UPDATE `guild_item_points` SET `itemid`=14167, `points`=2000, `max_points`=4720 WHERE `guildid`=5 AND `itemid`=13050 AND `pattern`=6; -- Moccasins +1 -> Desert Boots +1 (2000/4720)

-- ========================================================
-- BONECRAFT (guildid=6)
-- ========================================================
-- Journeyman (rank 5)
UPDATE `guild_item_points` SET `itemid`=13199, `points`=26, `max_points`=2400 WHERE `guildid`=6 AND `itemid`=13458 AND `pattern`=1; -- Scorpion Ring -> Blood Stone (26/2400)
UPDATE `guild_item_points` SET `itemid`=13226, `points`=26, `max_points`=2400 WHERE `guildid`=6 AND `itemid`=13513 AND `pattern`=1; -- Scorpion Ring +1 -> Blood Stone +1 (26/2400)

-- ========================================================
-- ALCHEMY (guildid=7)
-- ========================================================
-- Amateur (rank 0)
UPDATE `guild_item_points` SET `itemid`=16600, `points`=67, `max_points`=1440 WHERE `guildid`=7 AND `itemid`=1164 AND `pattern`=3; -- Tsurara -> Wax Sword (67/1440)
INSERT INTO `guild_item_points` VALUES (7,16610,0,75,1440,3); -- Wax Sword +1 - Amateur Pattern D

-- Recruit (rank 1)
UPDATE `guild_item_points` SET `itemid`=4167, `points`=21, `max_points`=1520 WHERE `guildid`=7 AND `itemid`=2109 AND `pattern`=5; -- Bittern -> Cracker (21/1520)

-- Initiate (rank 2)
UPDATE `guild_item_points` SET `itemid`=4168, `points`=25, `max_points`=1760 WHERE `guildid`=7 AND `itemid`=4165 AND `pattern`=3; -- Silent Oil -> Twinkle Shower (25/1760)

-- Artisan (rank 7)
UPDATE `guild_item_points` SET `itemid`=12379, `points`=700, `max_points`=4400 WHERE `guildid`=7 AND `itemid`=16503 AND `pattern`=6; -- Stun Knife -> Holy Shield (700/4400)
UPDATE `guild_item_points` SET `itemid`=12380, `points`=770, `max_points`=4400 WHERE `guildid`=7 AND `itemid`=17600 AND `pattern`=6; -- Stun Knife +1 -> Divine Shield (770/4400)

-- ========================================================
-- COOKING (guildid=8)
-- ========================================================
-- Amateur (rank 0)
UPDATE `guild_item_points` SET `points`=3, `max_points`=1120 WHERE `guildid`=8 AND `itemid`=17016 AND `pattern`=0; -- Pet Food Alpha: 4/3360 -> 3/1120
UPDATE `guild_item_points` SET `points`=31, `max_points`=1280 WHERE `guildid`=8 AND `itemid`=4415 AND `pattern`=1; -- Roasted Corn: 46/4080 -> 31/1280
UPDATE `guild_item_points` SET `points`=37, `max_points`=1280 WHERE `guildid`=8 AND `itemid`=4334 AND `pattern`=1; -- Grilled Corn: 55/4080 -> 37/1280
UPDATE `guild_item_points` SET `itemid`=4455, `points`=50, `max_points`=1360 WHERE `guildid`=8 AND `itemid`=4422 AND `pattern`=2; -- Orange Juice -> Pebble Soup (50/1360)
INSERT INTO `guild_item_points` VALUES (8,4592,0,55,1360,2); -- Wisdom Soup (HQ of Pebble Soup) - Amateur Pattern C
UPDATE `guild_item_points` SET `points`=100, `max_points`=1600 WHERE `guildid`=8 AND `itemid`=4535 AND `pattern`=3; -- Boiled Crayfish: 150/5760 -> 100/1600
UPDATE `guild_item_points` SET `points`=120, `max_points`=1600 WHERE `guildid`=8 AND `itemid`=4338 AND `pattern`=3; -- Steamed Crayfish: 180/5760 -> 120/1600
UPDATE `guild_item_points` SET `itemid`=4455, `points`=50, `max_points`=1360 WHERE `guildid`=8 AND `itemid`=4422 AND `pattern`=4; -- Orange Juice -> Pebble Soup (50/1360)
INSERT INTO `guild_item_points` VALUES (8,4592,0,55,1360,4); -- Wisdom Soup (HQ of Pebble Soup) - Amateur Pattern E
UPDATE `guild_item_points` SET `points`=278, `max_points`=2400 WHERE `guildid`=8 AND `itemid`=4355 AND `pattern`=5; -- Salmon Sub: 417/8880 -> 278/2400
UPDATE `guild_item_points` SET `points`=288, `max_points`=2400 WHERE `guildid`=8 AND `itemid`=4266 AND `pattern`=5; -- Fulm-long Salmon Sub: 432/8880 -> 288/2400
UPDATE `guild_item_points` SET `points`=278, `max_points`=2400 WHERE `guildid`=8 AND `itemid`=4355 AND `pattern`=6; -- Salmon Sub: 417/8880 -> 278/2400
UPDATE `guild_item_points` SET `points`=288, `max_points`=2400 WHERE `guildid`=8 AND `itemid`=4266 AND `pattern`=6; -- Fulm-long Salmon Sub: 432/8880 -> 288/2400
UPDATE `guild_item_points` SET `points`=31, `max_points`=1280 WHERE `guildid`=8 AND `itemid`=4415 AND `pattern`=7; -- Roasted Corn: 46/4080 -> 31/1280
UPDATE `guild_item_points` SET `points`=37, `max_points`=1280 WHERE `guildid`=8 AND `itemid`=4334 AND `pattern`=7; -- Grilled Corn: 55/4080 -> 37/1280

-- Recruit (rank 1)
UPDATE `guild_item_points` SET `points`=180, `max_points`=2240 WHERE `guildid`=8 AND `itemid`=4437 AND `pattern`=0; -- Roast Mutton: 270/7680 -> 180/2240
UPDATE `guild_item_points` SET `points`=200, `max_points`=2240 WHERE `guildid`=8 AND `itemid`=4335 AND `pattern`=0; -- Juicy Mutton: 300/7680 -> 200/2240
UPDATE `guild_item_points` SET `points`=280, `max_points`=2640 WHERE `guildid`=8 AND `itemid`=4416 AND `pattern`=1; -- Pea Soup: 420/9360 -> 280/2640
UPDATE `guild_item_points` SET `points`=361, `max_points`=2640 WHERE `guildid`=8 AND `itemid`=4327 AND `pattern`=1; -- Emerald Soup: 541/9360 -> 361/2640
UPDATE `guild_item_points` SET `points`=180, `max_points`=2240 WHERE `guildid`=8 AND `itemid`=4437 AND `pattern`=2; -- Roast Mutton: 270/7680 -> 180/2240
UPDATE `guild_item_points` SET `points`=200, `max_points`=2240 WHERE `guildid`=8 AND `itemid`=4335 AND `pattern`=2; -- Juicy Mutton: 300/7680 -> 200/2240
UPDATE `guild_item_points` SET `points`=35, `max_points`=1600 WHERE `guildid`=8 AND `itemid`=4408 AND `pattern`=3; -- Tortilla: 52/5040 -> 35/1600
UPDATE `guild_item_points` SET `points`=52, `max_points`=1600 WHERE `guildid`=8 AND `itemid`=5181 AND `pattern`=3; -- Tortilla Buena: 78/5040 -> 52/1600
UPDATE `guild_item_points` SET `points`=280, `max_points`=2640 WHERE `guildid`=8 AND `itemid`=4416 AND `pattern`=4; -- Pea Soup: 420/9360 -> 280/2640
UPDATE `guild_item_points` SET `points`=361, `max_points`=2640 WHERE `guildid`=8 AND `itemid`=4327 AND `pattern`=4; -- Emerald Soup: 541/9360 -> 361/2640
UPDATE `guild_item_points` SET `points`=130, `max_points`=2000 WHERE `guildid`=8 AND `itemid`=4537 AND `pattern`=5; -- Roast Carp: 195/6960 -> 130/2000
UPDATE `guild_item_points` SET `points`=160, `max_points`=2000 WHERE `guildid`=8 AND `itemid`=4586 AND `pattern`=5; -- Broiled Carp: 240/6960 -> 160/2000
UPDATE `guild_item_points` SET `points`=130, `max_points`=2000 WHERE `guildid`=8 AND `itemid`=4537 AND `pattern`=6; -- Roast Carp: 195/6960 -> 130/2000
UPDATE `guild_item_points` SET `points`=160, `max_points`=2000 WHERE `guildid`=8 AND `itemid`=4586 AND `pattern`=6; -- Broiled Carp: 240/6960 -> 160/2000
UPDATE `guild_item_points` SET `points`=35, `max_points`=1600 WHERE `guildid`=8 AND `itemid`=4408 AND `pattern`=7; -- Tortilla: 52/5040 -> 35/1600
UPDATE `guild_item_points` SET `points`=52, `max_points`=1600 WHERE `guildid`=8 AND `itemid`=5181 AND `pattern`=7; -- Tortilla Buena: 78/5040 -> 52/1600

-- Initiate (rank 2)
UPDATE `guild_item_points` SET `points`=55, `max_points`=1920 WHERE `guildid`=8 AND `itemid`=4380 AND `pattern`=0; -- Smoked Salmon: 82/6000 -> 55/1920
UPDATE `guild_item_points` SET `points`=360, `max_points`=3040 WHERE `guildid`=8 AND `itemid`=4438 AND `pattern`=1; -- Dhalmel Steak: 540/10800 -> 360/3040
UPDATE `guild_item_points` SET `points`=390, `max_points`=3040 WHERE `guildid`=8 AND `itemid`=4519 AND `pattern`=1; -- Wild Steak: 585/10800 -> 390/3040
UPDATE `guild_item_points` SET `points`=150, `max_points`=2320 WHERE `guildid`=8 AND `itemid`=4492 AND `pattern`=2; -- Puls: 225/7920 -> 150/2320
UPDATE `guild_item_points` SET `points`=150, `max_points`=2320 WHERE `guildid`=8 AND `itemid`=4533 AND `pattern`=2; -- Delicious Puls: 450/7920 -> 150/2320
UPDATE `guild_item_points` SET `points`=110, `max_points`=2160 WHERE `guildid`=8 AND `itemid`=4406 AND `pattern`=3; -- Baked Apple: 165/7200 -> 110/2160
UPDATE `guild_item_points` SET `points`=130, `max_points`=2160 WHERE `guildid`=8 AND `itemid`=4336 AND `pattern`=3; -- Sweet Baked Apple: 195/7200 -> 130/2160
UPDATE `guild_item_points` SET `points`=251, `max_points`=2720 WHERE `guildid`=8 AND `itemid`=4560 AND `pattern`=4; -- Vegetable Soup: 376/9360 -> 251/2720
UPDATE `guild_item_points` SET `points`=443, `max_points`=2720 WHERE `guildid`=8 AND `itemid`=4323 AND `pattern`=4; -- Vegetable Broth: 664/9360 -> 443/2720
UPDATE `guild_item_points` SET `points`=30, `max_points`=1760 WHERE `guildid`=8 AND `itemid`=4376 AND `pattern`=5; -- Meat Jerky: 45/5520 -> 30/1760
UPDATE `guild_item_points` SET `points`=42, `max_points`=1760 WHERE `guildid`=8 AND `itemid`=4518 AND `pattern`=5; -- Sheep Jerky: 63/5520 -> 42/1760
UPDATE `guild_item_points` SET `points`=450, `max_points`=3360 WHERE `guildid`=8 AND `itemid`=4456 AND `pattern`=6; -- Boiled Crab: 675/11760 -> 450/3360
UPDATE `guild_item_points` SET `points`=550, `max_points`=3360 WHERE `guildid`=8 AND `itemid`=4342 AND `pattern`=6; -- Steamed Crab: 825/11760 -> 550/3360
UPDATE `guild_item_points` SET `points`=80, `max_points`=2000 WHERE `guildid`=8 AND `itemid`=4436 AND `pattern`=7; -- Baked Popoto: 120/6720 -> 80/2000
UPDATE `guild_item_points` SET `itemid`=619, `points`=85, `max_points`=2000 WHERE `guildid`=8 AND `itemid`=4282 AND `pattern`=7; -- Pipin' Hot Popoto -> Pipin' Hot Popoto (85/2000)

-- Novice (rank 3)
UPDATE `guild_item_points` SET `points`=1000, `max_points`=4560 WHERE `guildid`=8 AND `itemid`=4419 AND `pattern`=0; -- Mushroom Soup: 1500/15600 -> 1000/4560
UPDATE `guild_item_points` SET `points`=1160, `max_points`=4560 WHERE `guildid`=8 AND `itemid`=4333 AND `pattern`=0; -- Witch Soup: 1740/15600 -> 1160/4560
UPDATE `guild_item_points` SET `points`=372, `max_points`=3280 WHERE `guildid`=8 AND `itemid`=4555 AND `pattern`=1; -- Windurst Salad: 558/11280 -> 372/3280
UPDATE `guild_item_points` SET `points`=409, `max_points`=3280 WHERE `guildid`=8 AND `itemid`=4321 AND `pattern`=1; -- Timbre Timbers Salad: 613/11280 -> 409/3280
UPDATE `guild_item_points` SET `points`=6, `max_points`=1920 WHERE `guildid`=8 AND `itemid`=4510 AND `pattern`=2; -- Acorn Cookie: 9/5760 -> 6/1920
UPDATE `guild_item_points` SET `points`=7, `max_points`=1920 WHERE `guildid`=8 AND `itemid`=4577 AND `pattern`=2; -- Wild Cookie: 10/5760 -> 7/1920
UPDATE `guild_item_points` SET `points`=25, `max_points`=2000 WHERE `guildid`=8 AND `itemid`=4499 AND `pattern`=3; -- Iron Bread: 37/6240 -> 25/2000
UPDATE `guild_item_points` SET `points`=76, `max_points`=2000 WHERE `guildid`=8 AND `itemid`=4573 AND `pattern`=3; -- Steel Bread: 114/6240 -> 76/2000
UPDATE `guild_item_points` SET `points`=300, `max_points`=3040 WHERE `guildid`=8 AND `itemid`=4459 AND `pattern`=4; -- Nebimonite Bake: 450/10320 -> 300/3040
UPDATE `guild_item_points` SET `points`=450, `max_points`=3040 WHERE `guildid`=8 AND `itemid`=4267 AND `pattern`=4; -- Buttered Nebimonite: 675/10320 -> 450/3040
UPDATE `guild_item_points` SET `points`=30, `max_points`=2000 WHERE `guildid`=8 AND `itemid`=4364 AND `pattern`=5; -- Black Bread: 45/6240 -> 30/2000
UPDATE `guild_item_points` SET `points`=40, `max_points`=2000 WHERE `guildid`=8 AND `itemid`=4591 AND `pattern`=5; -- Pumpernickel: 60/6240 -> 40/2000
UPDATE `guild_item_points` SET `points`=168, `max_points`=2560 WHERE `guildid`=8 AND `itemid`=5196 AND `pattern`=6; -- Buffalo Jerky: 252/8640 -> 168/2560
UPDATE `guild_item_points` SET `points`=378, `max_points`=2560 WHERE `guildid`=8 AND `itemid`=5207 AND `pattern`=6; -- Bison Jerky: 567/8640 -> 378/2560
UPDATE `guild_item_points` SET `points`=150, `max_points`=2560 WHERE `guildid`=8 AND `itemid`=4404 AND `pattern`=7; -- Roast Trout: 225/8400 -> 150/2560
UPDATE `guild_item_points` SET `points`=165, `max_points`=2560 WHERE `guildid`=8 AND `itemid`=4587 AND `pattern`=7; -- Broiled Trout: 247/8400 -> 165/2560

-- Apprentice (rank 4)
UPDATE `guild_item_points` SET `points`=294, `max_points`=3200 WHERE `guildid`=8 AND `itemid`=4420 AND `pattern`=0; -- Tomato Soup: 441/10800 -> 294/3200
UPDATE `guild_item_points` SET `points`=894, `max_points`=3200 WHERE `guildid`=8 AND `itemid`=4341 AND `pattern`=0; -- Sunset Soup: 1341/10800 -> 894/3200
UPDATE `guild_item_points` SET `points`=80, `max_points`=2480 WHERE `guildid`=8 AND `itemid`=4413 AND `pattern`=1; -- Apple Pie: 120/7680 -> 80/2480
UPDATE `guild_item_points` SET `points`=88, `max_points`=2480 WHERE `guildid`=8 AND `itemid`=4320 AND `pattern`=1; -- Apple Pie +1: 132/7680 -> 88/2480
UPDATE `guild_item_points` SET `points`=80, `max_points`=2480 WHERE `guildid`=8 AND `itemid`=4413 AND `pattern`=2; -- Apple Pie: 120/7680 -> 80/2480
UPDATE `guild_item_points` SET `points`=88, `max_points`=2480 WHERE `guildid`=8 AND `itemid`=4320 AND `pattern`=2; -- Apple Pie +1: 132/7680 -> 88/2480
UPDATE `guild_item_points` SET `points`=180, `max_points`=2800 WHERE `guildid`=8 AND `itemid`=4398 AND `pattern`=3; -- Fish Mithkabob: 270/9360 -> 180/2800
UPDATE `guild_item_points` SET `points`=204, `max_points`=2800 WHERE `guildid`=8 AND `itemid`=4575 AND `pattern`=3; -- Fish Chiefkabob: 306/9360 -> 204/2800
UPDATE `guild_item_points` SET `points`=120, `max_points`=2560 WHERE `guildid`=8 AND `itemid`=4490 AND `pattern`=4; -- Pickled Herring: 180/8400 -> 120/2560
UPDATE `guild_item_points` SET `points`=180, `max_points`=2560 WHERE `guildid`=8 AND `itemid`=5183 AND `pattern`=4; -- Viking Herring: 270/8400 -> 180/2560
UPDATE `guild_item_points` SET `points`=120, `max_points`=2560 WHERE `guildid`=8 AND `itemid`=4490 AND `pattern`=5; -- Pickled Herring: 180/8400 -> 120/2560
UPDATE `guild_item_points` SET `points`=180, `max_points`=2560 WHERE `guildid`=8 AND `itemid`=5183 AND `pattern`=5; -- Viking Herring: 270/8400 -> 180/2560
UPDATE `guild_item_points` SET `points`=4, `max_points`=2160 WHERE `guildid`=8 AND `itemid`=4397 AND `pattern`=6; -- Cinna-cookie: 6/6480 -> 4/2160
UPDATE `guild_item_points` SET `points`=5, `max_points`=2160 WHERE `guildid`=8 AND `itemid`=4520 AND `pattern`=6; -- Coin Cookie: 7/6480 -> 5/2160
UPDATE `guild_item_points` SET `itemid`=4420, `points`=294, `max_points`=3200 WHERE `guildid`=8 AND `itemid`=5750 AND `pattern`=7; -- Goulash -> Tomato Soup (294/3200)
UPDATE `guild_item_points` SET `itemid`=4341, `points`=894, `max_points`=3200 WHERE `guildid`=8 AND `itemid`=5751 AND `pattern`=7; -- Goulash +1 -> Sunset Soup (894/3200)

-- Journeyman (rank 5)
UPDATE `guild_item_points` SET `points`=165, `max_points`=2960 WHERE `guildid`=8 AND `itemid`=4572 AND `pattern`=0; -- Beaugreen Saute: 247/9600 -> 165/2960
UPDATE `guild_item_points` SET `points`=577, `max_points`=2960 WHERE `guildid`=8 AND `itemid`=4293 AND `pattern`=0; -- Monastic Saute: 865/9600 -> 577/2960
UPDATE `guild_item_points` SET `points`=256, `max_points`=3200 WHERE `guildid`=8 AND `itemid`=4563 AND `pattern`=1; -- Pamama Tart: 384/10560 -> 256/3200
UPDATE `guild_item_points` SET `points`=612, `max_points`=3200 WHERE `guildid`=8 AND `itemid`=4287 AND `pattern`=1; -- Opo-opo Tart: 918/10560 -> 612/3200
UPDATE `guild_item_points` SET `points`=123, `max_points`=2800 WHERE `guildid`=8 AND `itemid`=5168 AND `pattern`=2; -- Bataquiche: 184/8880 -> 123/2800
UPDATE `guild_item_points` SET `points`=184, `max_points`=2800 WHERE `guildid`=8 AND `itemid`=5169 AND `pattern`=2; -- Bataquiche +1: 276/8880 -> 184/2800
UPDATE `guild_item_points` SET `points`=300, `max_points`=3360 WHERE `guildid`=8 AND `itemid`=4417 AND `pattern`=3; -- Egg Soup: 450/11040 -> 300/3360
UPDATE `guild_item_points` SET `points`=350, `max_points`=3360 WHERE `guildid`=8 AND `itemid`=4521 AND `pattern`=3; -- Humpty Soup: 525/11040 -> 350/3360
UPDATE `guild_item_points` SET `points`=400, `max_points`=3600 WHERE `guildid`=8 AND `itemid`=5598 AND `pattern`=4; -- Sis Kebabi: 600/12000 -> 400/3600
UPDATE `guild_item_points` SET `points`=500, `max_points`=3600 WHERE `guildid`=8 AND `itemid`=5599 AND `pattern`=4; -- Sis Kebabi +1: 750/12000 -> 500/3600
UPDATE `guild_item_points` SET `points`=500, `max_points`=3840 WHERE `guildid`=8 AND `itemid`=4457 AND `pattern`=5; -- Eel Kabob: 750/12960 -> 500/3840
UPDATE `guild_item_points` SET `points`=550, `max_points`=3840 WHERE `guildid`=8 AND `itemid`=4588 AND `pattern`=5; -- Broiled Eel: 825/12960 -> 550/3840
UPDATE `guild_item_points` SET `points`=400, `max_points`=3600 WHERE `guildid`=8 AND `itemid`=5598 AND `pattern`=6; -- Sis Kebabi: 600/12000 -> 400/3600
UPDATE `guild_item_points` SET `points`=500, `max_points`=3600 WHERE `guildid`=8 AND `itemid`=5599 AND `pattern`=6; -- Sis Kebabi +1: 750/12000 -> 500/3600
UPDATE `guild_item_points` SET `points`=6, `max_points`=2320 WHERE `guildid`=8 AND `itemid`=4391 AND `pattern`=7; -- Bretzel: 9/7200 -> 6/2320
UPDATE `guild_item_points` SET `points`=9, `max_points`=2320 WHERE `guildid`=8 AND `itemid`=5182 AND `pattern`=7; -- Salty Bretzel: 13/7200 -> 9/2320

-- Craftsman (rank 6)
UPDATE `guild_item_points` SET `points`=350, `max_points`=3600 WHERE `guildid`=8 AND `itemid`=4546 AND `pattern`=0; -- Raisin Bread: 525/12000 -> 350/3600
UPDATE `guild_item_points` SET `itemid`=19340, `points`=198, `max_points`=3200 WHERE `guildid`=8 AND `itemid`=5148 AND `pattern`=1; -- Squid Sushi -> San d'Orian Tea (198/3200)
UPDATE `guild_item_points` SET `itemid`=4524, `points`=240, `max_points`=3200 WHERE `guildid`=8 AND `itemid`=5162 AND `pattern`=1; -- Squid Sushi +1 -> Royal Tea (240/3200)
UPDATE `guild_item_points` SET `points`=415, `max_points`=3760 WHERE `guildid`=8 AND `itemid`=5572 AND `pattern`=2; -- Irmik Helvasi: 622/12480 -> 415/3760
UPDATE `guild_item_points` SET `points`=441, `max_points`=3760 WHERE `guildid`=8 AND `itemid`=5573 AND `pattern`=2; -- Irmik Helvasi +1: 661/12480 -> 441/3760
UPDATE `guild_item_points` SET `points`=356, `max_points`=3600 WHERE `guildid`=8 AND `itemid`=4559 AND `pattern`=3; -- Herb Quus: 534/12000 -> 356/3600
UPDATE `guild_item_points` SET `points`=586, `max_points`=3600 WHERE `guildid`=8 AND `itemid`=4294 AND `pattern`=3; -- Medicinal Quus: 879/12000 -> 586/3600
UPDATE `guild_item_points` SET `points`=519, `max_points`=4000 WHERE `guildid`=8 AND `itemid`=4433 AND `pattern`=4; -- Dhalmel Stew: 778/13440 -> 519/4000
UPDATE `guild_item_points` SET `points`=570, `max_points`=4000 WHERE `guildid`=8 AND `itemid`=4589 AND `pattern`=4; -- Wild Stew: 855/13440 -> 570/4000
UPDATE `guild_item_points` SET `points`=104, `max_points`=2880 WHERE `guildid`=8 AND `itemid`=4487 AND `pattern`=5; -- Colored Egg: 156/9120 -> 104/2880
UPDATE `guild_item_points` SET `points`=230, `max_points`=2880 WHERE `guildid`=8 AND `itemid`=4595 AND `pattern`=5; -- Party Egg: 345/9120 -> 230/2880
UPDATE `guild_item_points` SET `points`=405, `max_points`=3760 WHERE `guildid`=8 AND `itemid`=4506 AND `pattern`=6; -- Mutton Tortilla: 607/12480 -> 405/3760
UPDATE `guild_item_points` SET `points`=587, `max_points`=3760 WHERE `guildid`=8 AND `itemid`=4348 AND `pattern`=6; -- Mutton Enchilada: 880/12480 -> 587/3760
UPDATE `guild_item_points` SET `points`=600, `max_points`=4160 WHERE `guildid`=8 AND `itemid`=5600 AND `pattern`=7; -- Balik Sis: 900/13920 -> 600/4160
UPDATE `guild_item_points` SET `points`=650, `max_points`=4160 WHERE `guildid`=8 AND `itemid`=5601 AND `pattern`=7; -- Balik Sis +1: 975/13920 -> 650/4160

-- Artisan (rank 7)
UPDATE `guild_item_points` SET `points`=462, `max_points`=4000 WHERE `guildid`=8 AND `itemid`=4547 AND `pattern`=0; -- Boiled Cockatrice: 693/13200 -> 462/4000
UPDATE `guild_item_points` SET `points`=425, `max_points`=3920 WHERE `guildid`=8 AND `itemid`=4552 AND `pattern`=1; -- Herb Crawler Eggs: 637/12960 -> 425/3920
UPDATE `guild_item_points` SET `points`=255, `max_points`=3520 WHERE `guildid`=8 AND `itemid`=4583 AND `pattern`=2; -- Salmon Meuniere: 382/11280 -> 255/3520
UPDATE `guild_item_points` SET `points`=510, `max_points`=3520 WHERE `guildid`=8 AND `itemid`=4347 AND `pattern`=2; -- Salmon Meuniere +1: 382/11280 -> 510/3520
UPDATE `guild_item_points` SET `itemid`=4439, `points`=175, `max_points`=3280 WHERE `guildid`=8 AND `itemid`=4440 AND `pattern`=3; -- Whitefish Stew -> Navarin (175/3280)
INSERT INTO `guild_item_points` VALUES (8,4284,7,525,3280,3); -- Tender Navarin (HQ of Navarin) - Artisan Pattern D
UPDATE `guild_item_points` SET `itemid`=4411, `points`=120, `max_points`=3120 WHERE `guildid`=8 AND `itemid`=4498 AND `pattern`=4; -- Chocomilk -> Dhalmel Pie (120/3120)
UPDATE `guild_item_points` SET `itemid`=4322, `points`=160, `max_points`=3120 WHERE `guildid`=8 AND `itemid`=4283 AND `pattern`=4; -- Choco-delight -> Dhalmel Pie +1 (160/3120)
UPDATE `guild_item_points` SET `points`=320, `max_points`=3680 WHERE `guildid`=8 AND `itemid`=4507 AND `pattern`=5; -- Rarab Meatball: 480/12000 -> 320/3680
UPDATE `guild_item_points` SET `points`=540, `max_points`=3680 WHERE `guildid`=8 AND `itemid`=4349 AND `pattern`=5; -- Bunny Ball: 810/12000 -> 540/3680
UPDATE `guild_item_points` SET `points`=1404, `max_points`=5280 WHERE `guildid`=8 AND `itemid`=4554 AND `pattern`=6; -- Shallops Tropicale: 2106/17520 -> 1404/5280
UPDATE `guild_item_points` SET `points`=1200, `max_points`=5040 WHERE `guildid`=8 AND `itemid`=4418 AND `pattern`=7; -- Turtle Soup: 1800/16800 -> 1200/5040
UPDATE `guild_item_points` SET `points`=1400, `max_points`=5040 WHERE `guildid`=8 AND `itemid`=4337 AND `pattern`=7; -- Stamina Soup: 2100/16800 -> 1400/5040

-- Adept (rank 8)
UPDATE `guild_item_points` SET `itemid`=4544, `points`=1120, `max_points`=5040 WHERE `guildid`=8 AND `itemid`=5588 AND `pattern`=0; -- Karni Yarik -> Mushroom Stew (1120/5040)
UPDATE `guild_item_points` SET `itemid`=4344, `points`=1680, `max_points`=5040 WHERE `guildid`=8 AND `itemid`=5589 AND `pattern`=0; -- Karni Yarik +1 -> Witch Stew (1680/5040)
UPDATE `guild_item_points` SET `points`=1320, `max_points`=5280 WHERE `guildid`=8 AND `itemid`=4561 AND `pattern`=1; -- Seafood Stew: 1980/17280 -> 1320/5280
UPDATE `guild_item_points` SET `itemid`=4564, `points`=1836, `max_points`=5680 WHERE `guildid`=8 AND `itemid`=5660 AND `pattern`=2; -- Pepperoni -> Royal Omelette (1836/5680)
INSERT INTO `guild_item_points` VALUES (8,4331,8,2516,5680,2); -- Imperial Omelette (HQ of Royal Omelette) - Adept Pattern C
UPDATE `guild_item_points` SET `points`=1472, `max_points`=5360 WHERE `guildid`=8 AND `itemid`=4550 AND `pattern`=3; -- Bream Risotto: 2208/17760 -> 1472/5360
UPDATE `guild_item_points` SET `points`=1792, `max_points`=5360 WHERE `guildid`=8 AND `itemid`=4268 AND `pattern`=3; -- Sea Spray Risotto: 2688/17760 -> 1792/5360
UPDATE `guild_item_points` SET `points`=305, `max_points`=3760 WHERE `guildid`=8 AND `itemid`=4582 AND `pattern`=4; -- Bass Meuniere: 457/12240 -> 305/3760
UPDATE `guild_item_points` SET `points`=610, `max_points`=3760 WHERE `guildid`=8 AND `itemid`=4346 AND `pattern`=4; -- Bass Meuniere +1: 915/12240 -> 610/3760
UPDATE `guild_item_points` SET `points`=522, `max_points`=4160 WHERE `guildid`=8 AND `itemid`=4557 AND `pattern`=5; -- Steamed Catfish: 783/13920 -> 522/4160
UPDATE `guild_item_points` SET `points`=616, `max_points`=4320 WHERE `guildid`=8 AND `itemid`=4548 AND `pattern`=6; -- Coeurl Saute: 924/14400 -> 616/4320
DELETE FROM `guild_item_points` WHERE `guildid`=8 AND `itemid`=4295 AND `pattern`=6; -- Remove Royal Sautee (no wiki replacement)
UPDATE `guild_item_points` SET `points`=1150, `max_points`=5040 WHERE `guildid`=8 AND `itemid`=4452 AND `pattern`=7; -- Shark Fin Soup: 1725/16800 -> 1150/5040
UPDATE `guild_item_points` SET `points`=1400, `max_points`=5040 WHERE `guildid`=8 AND `itemid`=4285 AND `pattern`=7; -- Ocean Soup: 2100/16800 -> 1400/5040

-- Veteran (rank 9)
UPDATE `guild_item_points` SET `itemid`=4297, `points`=730, `max_points`=4640 WHERE `guildid`=8 AND `itemid`=5151 AND `pattern`=0; -- Urchin Sushi -> Black Curry (730/4640)
DELETE FROM `guild_item_points` WHERE `guildid`=8 AND `itemid`=5160 AND `pattern`=0; -- Remove Urchin Sushi +1 (no wiki replacement)
UPDATE `guild_item_points` SET `points`=140, `max_points`=3440 WHERE `guildid`=8 AND `itemid`=4271 AND `pattern`=1; -- Rice Dumpling: 210/10800 -> 140/3440
UPDATE `guild_item_points` SET `itemid`=4279, `points`=4375, `max_points`=6720 WHERE `guildid`=8 AND `itemid`=5178 AND `pattern`=2; -- Dorado Sushi -> Tavnazian Salad (4375/6720)
UPDATE `guild_item_points` SET `itemid`=5185, `points`=6475, `max_points`=6720 WHERE `guildid`=8 AND `itemid`=5179 AND `pattern`=2; -- Dorado Sushi +1 -> Leremieu Salad (6475/6720)
UPDATE `guild_item_points` SET `points`=1818, `max_points`=5680 WHERE `guildid`=8 AND `itemid`=4353 AND `pattern`=3; -- Sea Bass Croute: 2727/18480 -> 1818/5680
UPDATE `guild_item_points` SET `points`=1597, `max_points`=5520 WHERE `guildid`=8 AND `itemid`=4584 AND `pattern`=4; -- Flounder Meuniere: 2395/18000 -> 1597/5520
UPDATE `guild_item_points` SET `points`=2130, `max_points`=5520 WHERE `guildid`=8 AND `itemid`=4345 AND `pattern`=4; -- Flounder Meuniere +1: 3195/18000 -> 2130/5520
UPDATE `guild_item_points` SET `points`=2220, `max_points`=5920 WHERE `guildid`=8 AND `itemid`=4542 AND `pattern`=5; -- Brain Stew: 3330/19200 -> 2220/5920
UPDATE `guild_item_points` SET `points`=3330, `max_points`=5920 WHERE `guildid`=8 AND `itemid`=5180 AND `pattern`=5; -- Sophic Stew: 4995/19200 -> 3330/5920
UPDATE `guild_item_points` SET `points`=98, `max_points`=3360 WHERE `guildid`=8 AND `itemid`=4270 AND `pattern`=6; -- Sweet Rice Cake: 147/10320 -> 98/3360
UPDATE `guild_item_points` SET `points`=900, `max_points`=4800 WHERE `guildid`=8 AND `itemid`=4551 AND `pattern`=7; -- Salmon Croute: 1350/16080 -> 900/4800
