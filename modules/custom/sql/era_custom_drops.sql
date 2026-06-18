-- Implements custom drops

-- Variables
SET @ALWAYS = 1000;  -- Always, 100%
SET @VCOMMON = 240;  -- Very common, 24%
SET @COMMON = 150;   -- Common, 15%
SET @UNCOMMON = 100; -- Uncommon, 10%
SET @RARE = 50;      -- Rare, 5%
SET @VRARE = 10;     -- Very rare, 1%
SET @SRARE = 5;      -- Super Rare, 0.5%
SET @URARE = 1;      -- Ultra rare, 0.1%

-- ZoneID:  89 - Kotan-Kor Kamuy
REPLACE INTO `mob_droplist` VALUES (2950, 0, 0, 1000, 15057, @RARE); -- Brictas Cuffs (Rare, 5%)

-- ZoneID:  65 - Gulool Ja Ja
REPLACE INTO `mob_droplist` VALUES (1257, 0, 0, 1000, 16159, @RARE); -- Zha'Go's Barbut (Rare, 5%)
REPLACE INTO `mob_droplist` VALUES (1257, 0, 0, 1000, 14943, @UNCOMMON); -- Barbarossa's Moufles (Uncommon, 10%)
REPLACE INTO `mob_droplist` VALUES (1257, 0, 0, 1000, 2347, @VCOMMON); -- Reactive Shield (Very Common, 24%)
REPLACE INTO `mob_droplist` VALUES (1257, 0, 0, 1000, 2353, @VCOMMON); -- Optic Fiber (Very Common, 24%)
REPLACE INTO `mob_droplist` VALUES (1257, 0, 0, 1000, 4930, @UNCOMMON); -- Katon: San (Uncommon, 10%)

-- ZoneID:  62 - Gurfurlur The Menacing
REPLACE INTO `mob_droplist` VALUES (1259, 0, 0, 1000, 15928, @UNCOMMON); -- Lycopodium Sash (Uncommon, 10%)
REPLACE INTO `mob_droplist` VALUES (1259, 0, 0, 1000, 16158, @RARE); -- Gnadbhod's Helm (Rare, 5%)
REPLACE INTO `mob_droplist` VALUES (1259, 0, 0, 1000, 15617, @UNCOMMON); -- Barbarossa's Moufles (Uncommon, 10%)
REPLACE INTO `mob_droplist` VALUES (1259, 0, 0, 1000, 2349, @VCOMMON); -- Turbo Charger (Very Common, 24%)
REPLACE INTO `mob_droplist` VALUES (1259, 0, 0, 1000, 2348, @VCOMMON); -- Tranquilizer (Very Common, 24%)
REPLACE INTO `mob_droplist` VALUES (1259, 0, 0, 1000, 2350, @VCOMMON); -- Schurzen (Very Common, 24%)

-- ZoneID:  54 - Medusa
REPLACE INTO `mob_droplist` VALUES (1651, 0, 0, 1000, 16160, @RARE); -- Ree Habalo's Headgear (Rare, 5%)
REPLACE INTO `mob_droplist` VALUES (1651, 0, 0, 1000, 2352, @VCOMMON); -- Condenser (Very Common, 24%)
REPLACE INTO `mob_droplist` VALUES (1651, 0, 0, 1000, 2351, @VCOMMON); -- Dynamo (Very Common, 24%)
REPLACE INTO `mob_droplist` VALUES (1651, 0, 0, 1000, 2354, @VCOMMON); -- Economizer (Very Common, 24%)

-- ZoneID:  190 - Vrtra
REPLACE INTO `mob_droplist` VALUES (2592, 0, 0, 1000, 3446, @VCOMMON); -- Kholomodumo's Hide (Very Common, 24%)
REPLACE INTO `mob_droplist` VALUES (2592, 0, 0, 1000, 3446, @UNCOMMON); -- Kholomodumo's Hide (Uncommon, 10%)

-- ZoneID:  5 - Jormungand
REPLACE INTO `mob_droplist` VALUES (1410, 1, 4, 240, 3446, @ALWAYS); -- Kholomodumo's Hide (Very Common, 24%)
REPLACE INTO `mob_droplist` VALUES (1410, 1, 5, 100, 3446, @ALWAYS); -- Kholomodumo's Hide (Uncommon, 10%)

-- ZoneID:  178 - Kirin
REPLACE INTO `mob_droplist` VALUES (2819, 1, 2, 900, 3446, @ALWAYS); -- Mangled Cockatrice Skin (90%)
REPLACE INTO `mob_droplist` VALUES (2819, 1, 3, 100, 3446, @ALWAYS); -- Mangled Cockatrice Skin (Uncommon, 10%)

-- ZoneID:  85 - Ashmaker Gotblut
REPLACE INTO `mob_droplist` VALUES (177, 0, 0, 1000, 1489, 750); -- B. Egg (75%)
REPLACE INTO `mob_droplist` VALUES (177, 0, 0, 1000, 2359, 180); -- Star Sapphire (18%)

-- ZoneID:  85 - Hawkeyed Dnatbat
REPLACE INTO `mob_droplist` VALUES (1284, 0, 0, 1000, 1489, 750); -- B. Egg (75%)
REPLACE INTO `mob_droplist` VALUES (1284, 0, 0, 1000, 2359, 180); -- Star Sapphire (18%)

-- ZoneID:  54 - Soulflayer
-- ZoneID:  77 - Psycheflayer
-- ZoneID:  79 - Soulflayer
REPLACE INTO `mob_droplist` VALUES (2030, 0, 0, 1000, 2228, 400); -- Luminium Ore (40%)

-- ZoneID:  113 - Sand Cockatrice
REPLACE INTO `mob_droplist` VALUES (2147, 0, 0, 1000, 1414, @COMMON);  -- Wisteria Lumber (Common, 15%)

-- ZoneID:  120 - Roc
REPLACE INTO `mob_droplist` VALUES (2112, 0, 0, 1000, 11343, 210); -- Thrakon Breastplate (21%)

-- ZoneID:  174 - Ladon
-- ZoneID:  205 - Hurricane Wyvern
-- ZoneID:  213 - Wyvern
REPLACE INTO `mob_droplist` VALUES (1477, 0, 0, 1000, 1771, 200); -- Dragon Bones (20%)
REPLACE INTO `mob_droplist` VALUES (1477, 0, 0, 1000, 866, 300); -- Wyvern Scales (30%)
REPLACE INTO `mob_droplist` VALUES (1340, 0, 0, 1000, 1771, 200); -- Dragon Bones (20%)
REPLACE INTO `mob_droplist` VALUES (1340, 0, 0, 1000, 866, 300); -- Wyvern Scales (30%)
REPLACE INTO `mob_droplist` VALUES (2677, 0, 0, 1000, 1771, 200); -- Dragon Bones (20%)
REPLACE INTO `mob_droplist` VALUES (2677, 0, 0, 1000, 866, 300); -- Wyvern Scales (30%)

-- ZoneID:  61 - Sicklemoon Jagil
REPLACE INTO `mob_droplist` VALUES (4465, 0, 0, 1000, 16140, 30); -- Scholar's Mortarboard (3%)

-- ZoneID:  52 - Colibri
-- ZoneID:  65 - Colibri
REPLACE INTO `mob_droplist` VALUES (500, 0, 0, 1000, 842, 400); -- Giant Bird Feather (40%)

-- ZoneID:  51 - Defoliate Treant
-- ZoneID:  52 - Olden Treant
-- ZoneID:  79 - Mature Treant
REPLACE INTO `mob_droplist` VALUES (597, 0, 0, 1000, 1446, @ALWAYS); -- Lacquer Tree Log (Always, 100%)

-- ZoneID: 176 - Devil Manta
REPLACE INTO `mob_droplist` VALUES (645, 0, 0, 1000, 1312, 250); -- Angel Skin (25%)

-- ZoneID:  51 - Tinnin
REPLACE INTO `mob_droplist` VALUES (2418, 0, 0, 1000, 15918, @UNCOMMON); -- Witch Sash (Uncommon, 10%)

-- ZoneID:  79 - Tyger
REPLACE INTO `mob_droplist` VALUES (2508, 0 , 0, 1000, 16002, @UNCOMMON); -- Roundel Earring (Uncommon, 10%)

-- ZoneID:  72 - Armed Gears
REPLACE INTO `mob_droplist` VALUES (168, 0 , 0, 1000, 18020, @UNCOMMON); -- Mercurial Kris (Uncommon, 10%)

-- ZoneID: 160 - Tonberry Decapitator
REPLACE INTO `mob_droplist` VALUES (2433, 0, 0, 1000, 4945, 70); -- Suiton: San (7%)

-- ZoneID: 160 - Tonberry Slasher
REPLACE INTO `mob_droplist` VALUES (2446, 0, 0, 1000, 4945, 30); -- Suiton: San (3%)

-- ZoneID: 159 - Tonberry Stabber
REPLACE INTO `mob_droplist` VALUES (2447, 0, 0, 1000, 4945, 30); -- Suiton: San (3%)

-- ZoneID: 151 - Yagudo Assassin
REPLACE INTO `mob_droplist` VALUES (2695, 0, 0, 1000, 4942, 30); -- Raiton: San (3%)

-- ZoneID:  98 - Yagudo Inquisitor
-- ZoneID:  98 - Yagudo Missionary
-- ZoneID: 164 - Yagudo Missionary
REPLACE INTO `mob_droplist` VALUES (2719, 0, 0, 1000, 4939, 50); -- Doton: San (5%)

-- ZoneID: 155 - Yagudo Yojimbo
-- ZoneID: 155 - Yagudo Nokizaru
REPLACE INTO `mob_droplist` VALUES (95, 0, 0, 1000, 4933, 120); -- Hyoton: San (12%)

-- ZoneID: 138 - Yagudo Eradicator
-- ZoneID: 138 - Yagudo Knight Templar
REPLACE INTO `mob_droplist` VALUES (2725, 0, 0, 1000, 4933, 60); -- Hyoton: San (6%)

-- ZoneID:  97 - Yagudo Eradicator
-- ZoneID:  97 - Yagudo Knight Templar
-- ZoneID:  99 - Yagudo Knight Templar
-- ZoneID:  99 - Yagudo Eradicator
REPLACE INTO `mob_droplist` VALUES (2707, 0, 0, 1000, 4936, 30); -- Huton: San (3%)
