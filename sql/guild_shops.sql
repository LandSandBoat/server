/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `guild_shops`
--

DROP TABLE IF EXISTS `guild_shops`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `guild_shops` (
  `guildid` smallint(5) unsigned NOT NULL,
  `itemid` smallint(5) unsigned NOT NULL,
  `min_price` int(10) unsigned NOT NULL DEFAULT '0',
  `max_price` int(10) unsigned NOT NULL DEFAULT '0',
  `max_quantity` smallint(5) unsigned NOT NULL DEFAULT '0',
  `daily_increase` smallint(5) unsigned NOT NULL DEFAULT '0',
  `initial_quantity` smallint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guildid`,`itemid`)
) ENGINE=Aria TRANSACTIONAL=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guild_shops`
--
-- ORDER BY:  `guildid`,`itemid`
--
-- Old commment:
-- To cope with the current 30 item limit, I have added in every single item entry according to Blue Gartyr Wiki
-- I then chose the 30 most important items I could think of for each vendor, and commented out the rest for now.
-- I did my best to put all the daily restocks on 1 vendor, and the non-restocks on the other.
-- This should leave ~60 items for each guild, for now. I think this will be enough to make most happy.
-- When the cap is lifted, all you will have to do is remove the comments and make the (S) vendors the same ID and it will display 100% of the item lists

-- The above 30 item limit no longer exists..


-- Shih Tayuun (Bonecraft Guild) Windurst Woods (S)
INSERT INTO `guild_shops` VALUES (514,881,3469,11306,240,0,0);     -- crab_shell
INSERT INTO `guild_shops` VALUES (514,882,150,760,240,48,36);      -- sheep_tooth
INSERT INTO `guild_shops` VALUES (514,884,3741,12177,180,0,0);     -- black_tiger_fang
INSERT INTO `guild_shops` VALUES (514,885,21840,74256,120,0,4);    -- turtle_shell
INSERT INTO `guild_shops` VALUES (514,888,90,90,240,48,180);       -- seashell
INSERT INTO `guild_shops` VALUES (514,889,380,510,60,0,0);         -- beetle_shell
INSERT INTO `guild_shops` VALUES (514,893,1766,4669,60,0,0);       -- giant_femur
INSERT INTO `guild_shops` VALUES (514,894,968,2952,60,0,0);        -- beetle_jaw
INSERT INTO `guild_shops` VALUES (514,895,3060,15560,60,0,0);      -- ram_horn
INSERT INTO `guild_shops` VALUES (514,896,2044,12166,60,0,0);      -- scorpion_shell
INSERT INTO `guild_shops` VALUES (514,897,1588,6683,60,0,0);       -- scorpion_claw
INSERT INTO `guild_shops` VALUES (514,898,163,163,60,0,7);         -- chicken_bone
INSERT INTO `guild_shops` VALUES (514,12582,11507,30011,60,0,0);   -- bone_harness
INSERT INTO `guild_shops` VALUES (514,12583,12246,49455,60,0,0);   -- beetle_harness
INSERT INTO `guild_shops` VALUES (514,13712,43312,96442,60,0,0);   -- carapace_harness
INSERT INTO `guild_shops` VALUES (514,13744,208550,208550,60,0,0); -- justaucorps
INSERT INTO `guild_shops` VALUES (514,12966,7722,14493,60,0,0);    -- bone_leggings
INSERT INTO `guild_shops` VALUES (514,12967,18447,27659,60,0,0);   -- beetle_leggings
INSERT INTO `guild_shops` VALUES (514,13715,37338,131712,60,0,0);  -- cpc._leggings
INSERT INTO `guild_shops` VALUES (514,13313,565,807,60,0,0);       -- shell_earring
INSERT INTO `guild_shops` VALUES (514,13321,1359,7900,60,0,0);     -- bone_earring
INSERT INTO `guild_shops` VALUES (514,13323,15408,15408,60,0,0);   -- beetle_earring
INSERT INTO `guild_shops` VALUES (514,13324,38565,38565,60,0,0);   -- tortoise_earring
INSERT INTO `guild_shops` VALUES (514,12710,2448,14231,60,0,0);    -- bone_mittens
INSERT INTO `guild_shops` VALUES (514,12711,4653,25312,60,0,0);    -- beetle_mittens
INSERT INTO `guild_shops` VALUES (514,13713,23625,57960,60,0,0);   -- carapace_mittens
INSERT INTO `guild_shops` VALUES (514,12454,3912,17525,60,0,0);    -- bone_mask
INSERT INTO `guild_shops` VALUES (514,12455,5728,32079,60,0,0);    -- beetle_mask
INSERT INTO `guild_shops` VALUES (514,13711,29925,146832,60,0,0);  -- carapace_mask
INSERT INTO `guild_shops` VALUES (514,12505,336,389,60,0,0);       -- bone_hairpin
INSERT INTO `guild_shops` VALUES (514,12507,12825,83448,60,0,0);   -- horn_hairpin
INSERT INTO `guild_shops` VALUES (514,12506,4500,16350,60,0,0);    -- shell_hairpin
INSERT INTO `guild_shops` VALUES (514,13076,2938,4464,60,0,0);     -- fang_necklace
INSERT INTO `guild_shops` VALUES (514,13090,7188,8869,60,0,0);     -- beetle_gorget
INSERT INTO `guild_shops` VALUES (514,13091,29568,106260,60,0,0);  -- carapace_gorget
INSERT INTO `guild_shops` VALUES (514,12834,6588,11106,60,0,0);    -- bone_subligar
INSERT INTO `guild_shops` VALUES (514,12835,16956,54265,60,0,0);   -- beetle_subligar
INSERT INTO `guild_shops` VALUES (514,12837,170016,225456,60,0,0); -- carapace_subligar
INSERT INTO `guild_shops` VALUES (514,12414,11377,37771,60,0,0);   -- turtle_shield
INSERT INTO `guild_shops` VALUES (514,13442,565,807,60,0,0);       -- shell_ring
INSERT INTO `guild_shops` VALUES (514,13441,1359,1395,60,0,0);     -- bone_ring
INSERT INTO `guild_shops` VALUES (514,13457,2650,2721,60,0,0);     -- beetle_ring
INSERT INTO `guild_shops` VALUES (514,13459,7200,8832,60,0,0);     -- horn_ring
INSERT INTO `guild_shops` VALUES (514,13461,11565,43599,60,0,0);   -- carapace_ring
INSERT INTO `guild_shops` VALUES (514,13458,14175,61992,60,0,0);   -- scorpion_ring
INSERT INTO `guild_shops` VALUES (514,13981,67439,72204,60,0,0);   -- turtle_bangles
INSERT INTO `guild_shops` VALUES (514,17610,22500,53100,60,0,0);   -- bone_knife
INSERT INTO `guild_shops` VALUES (514,17612,34440,39606,60,0,0);   -- beetle_knife
INSERT INTO `guild_shops` VALUES (514,16642,9050,19053,60,0,0);    -- bone_axe
INSERT INTO `guild_shops` VALUES (514,16649,4887,22154,60,0,0);    -- bone_pick
INSERT INTO `guild_shops` VALUES (514,16405,213,519,60,0,0);       -- cat_baghnakhs
INSERT INTO `guild_shops` VALUES (514,16406,14428,35251,60,0,0);   -- baghnakhs
INSERT INTO `guild_shops` VALUES (514,16407,1521,2859,60,0,0);     -- brass_baghnakhs
INSERT INTO `guild_shops` VALUES (514,17352,21645,47330,60,0,0);   -- horn
INSERT INTO `guild_shops` VALUES (514,17062,16493,19859,60,0,0);   -- bone_rod
INSERT INTO `guild_shops` VALUES (514,17026,4032,10590,60,0,0);    -- bone_cudgel
INSERT INTO `guild_shops` VALUES (514,17257,19859,39568,60,0,0);   -- bandits_gun
INSERT INTO `guild_shops` VALUES (514,17319,3,21,240,10,20);       -- bone_arrow
INSERT INTO `guild_shops` VALUES (514,17299,2419,2419,240,0,0);    -- astragalos

-- Kuzah Hpirohpon (Windurst Woods) Clothcraft Guild (S)
INSERT INTO `guild_shops` VALUES (5152,834,79,200,240,48,2);         -- ball_of_satura_cotton
INSERT INTO `guild_shops` VALUES (5152,835,187,1130,240,75,180);     -- flax_flower
INSERT INTO `guild_shops` VALUES (5152,832,675,4500,240,48,180);     -- clump_of_sheep_wool
INSERT INTO `guild_shops` VALUES (5152,839,137,907,240,48,60);       -- piece_of_crawler_cocoon
INSERT INTO `guild_shops` VALUES (5152,838,9438,34557,240,0,0);      -- spider_web
INSERT INTO `guild_shops` VALUES (5152,817,45,240,240,48,180);       -- spool_of_grass_thread
INSERT INTO `guild_shops` VALUES (5152,818,144,768,240,48,132);      -- spool_of_cotton_thread
INSERT INTO `guild_shops` VALUES (5152,819,750,4200,240,48,102);     -- spool_of_linen_thread
INSERT INTO `guild_shops` VALUES (5152,820,2700,12528,180,33,66);    -- spool_of_wool_thread
INSERT INTO `guild_shops` VALUES (5152,816,592,3865,30,1,8);         -- spool_of_silk_thread
INSERT INTO `guild_shops` VALUES (5152,822,585,4760,30,1,6);         -- spool_of_silver_thread
INSERT INTO `guild_shops` VALUES (5152,823,13338,109440,10,0,5);     -- spool_of_gold_thread
-- INSERT INTO `guild_shops` VALUES (5152,821,13338,109440,10,0,0);     -- spool_of_rainbow_thread TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5152,824,240,1344,240,16,36);      -- square_of_grass_cloth
INSERT INTO `guild_shops` VALUES (5152,825,480,2944,240,16,36);      -- square_of_cotton_cloth
INSERT INTO `guild_shops` VALUES (5152,826,5970,12840,120,0,0);      -- square_of_linen_cloth
INSERT INTO `guild_shops` VALUES (5152,827,9180,48384,120,0,0);      -- square_of_wool_cloth
INSERT INTO `guild_shops` VALUES (5152,828,21851,31710,60,0,0);      -- square_of_velvet_cloth
INSERT INTO `guild_shops` VALUES (5152,829,35070,102480,240,0,0);    -- square_of_silk_cloth
-- INSERT INTO `guild_shops` VALUES (5152,830,21851,31710,240,0,0);     -- square_of_rainbow_cloth TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5152,847,26,192,240,0,0);        -- bird_feather TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5152,841,26,192,240,0,0);           -- yagudo_feather
-- INSERT INTO `guild_shops` VALUES (5152,842,26,192,240,0,0);        -- giant_bird_feather TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5152,12608,26,192,60,0,0);         -- tunic TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5152,12609,26,192,60,0,0);         -- black_tunic TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5152,12592,26,192,60,0,0);         -- doublet TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5152,12593,66992,66992,60,0,0);     -- cotton_doublet
INSERT INTO `guild_shops` VALUES (5152,13750,87178,87178,60,0,0);     -- linen_doublet
-- INSERT INTO `guild_shops` VALUES (5152,12594,87178,87178,60,0,0);     -- gambison TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5152,12595,87178,87178,60,0,0);     -- wool_gambison TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5152,12600,424,1171,60,0,0);        -- robe
INSERT INTO `guild_shops` VALUES (5152,12601,14684,14684,60,0,0);     -- linen_robe
-- INSERT INTO `guild_shops` VALUES (5152,12602,14684,14684,60,0,0);     -- wool_robe TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5152,12603,14684,14684,60,0,0);     -- velvet_robe TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5152,12610,14684,14684,60,0,0);     -- cloak TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5152,12976,1339,6486,60,0,0);       -- gaiters
-- INSERT INTO `guild_shops` VALUES (5152,12977,1339,6486,60,0,0);       -- cotton_gaiters TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5152,12978,1339,6486,60,0,0);       -- socks TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5152,12979,171776,171776,60,0,0);   -- wool_socks
INSERT INTO `guild_shops` VALUES (5152,12720,2787,7393,60,0,0);       -- gloves
-- INSERT INTO `guild_shops` VALUES (5152,12721,2787,7393,60,0,0);       -- cotton_gloves TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5152,12722,2787,7393,60,0,0);       -- bracers TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5152,12723,2787,7393,60,0,0);       -- wool_bracers TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5152,12728,424,1171,60,0,0);        -- cuffs TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5152,12729,424,1171,60,0,0);        -- linen_cuffs TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5152,12730,424,1171,60,0,0);        -- wool_cuffs TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5152,12731,424,1171,60,0,0);        -- velvet_cuffs TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5152,12736,1290,3196,60,0,0);       -- mitts
-- INSERT INTO `guild_shops` VALUES (5152,12738,424,1171,60,0,0);        -- linen_mitts TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5152,12739,37862,172339,60,0,0);    -- black_mitts
INSERT INTO `guild_shops` VALUES (5152,12464,2710,7898,60,0,0);       -- headgear
INSERT INTO `guild_shops` VALUES (5152,12465,35315,38882,60,0,0);     -- cotton_headgear
-- INSERT INTO `guild_shops` VALUES (5152,12498,424,1171,60,0,0);        -- cotton_headband TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5152,12499,14160,78080,60,0,0);     -- flax_headband
-- INSERT INTO `guild_shops` VALUES (5152,13568,424,1171,60,0,0);        -- scarlet_ribbon TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5152,12466,23200,39400,60,0,0);     -- red_cap
-- INSERT INTO `guild_shops` VALUES (5152,12467,424,1171,60,0,0);        -- wool_cap TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5152,12474,424,1171,60,0,0);        -- wool_hat TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5152,12475,424,1171,60,0,0);        -- velvet_hat TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5152,12848,424,1171,60,0,0);        -- brais TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5152,12849,424,1171,60,0,0);        -- cotton_brais TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5152,12850,424,1171,60,0,0);        -- hose TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5152,12851,135936,228096,60,0,0);   -- wool_hose
INSERT INTO `guild_shops` VALUES (5152,12856,372,936,60,0,0);         -- slops
-- INSERT INTO `guild_shops` VALUES (5152,12857,424,1171,60,0,0);        -- linen_slops TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5152,12858,424,1171,60,0,0);        -- wool_slops TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5152,12859,424,1171,60,0,0);        -- velvet_slops TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5152,12864,424,1171,60,0,0);        -- slacks TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5152,12866,424,1171,60,0,0);        -- linen_slacks TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5152,12865,424,1171,60,0,0);        -- black_slacks TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5152,13583,318,1683,60,0,0);        -- cape
INSERT INTO `guild_shops` VALUES (5152,13584,10321,40322,60,0,0);     -- cotton_cape
INSERT INTO `guild_shops` VALUES (5152,13577,15190,42134,60,0,0);     -- black_cape
-- INSERT INTO `guild_shops` VALUES (5152,13586,15190,42134,60,0,0);     -- red_cape TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5152,13075,15190,42134,60,0,0);     -- feather_collar TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5152,13085,918,4838,60,0,0);           -- hemp_gorget
-- INSERT INTO `guild_shops` VALUES (5152,13322,15190,42134,60,0,0);     -- wing_earring TODO: missing min_price and max_price

-- Tilala (Clothcraft Guild) Selbina (S) -- TODO: Audit this vendor immediately after server maintenance. This is currently an unverified duplicate of the Windurst guild vendor.
INSERT INTO `guild_shops` VALUES (516,834,79,200,240,0,0);           -- ball_of_satura_cotton
INSERT INTO `guild_shops` VALUES (516,835,187,1130,240,75,180);      -- flax_flower
INSERT INTO `guild_shops` VALUES (516,832,675,4500,240,48,180);      -- clump_of_sheep_wool
INSERT INTO `guild_shops` VALUES (516,839,137,907,240,0,0);          -- piece_of_crawler_cocoon
INSERT INTO `guild_shops` VALUES (516,838,9438,34557,240,0,0);       -- spider_web
INSERT INTO `guild_shops` VALUES (516,817,45,240,240,48,180);        -- spool_of_grass_thread
INSERT INTO `guild_shops` VALUES (516,818,144,768,240,48,132);       -- spool_of_cotton_thread
INSERT INTO `guild_shops` VALUES (516,819,750,4200,240,48,102);      -- spool_of_linen_thread
INSERT INTO `guild_shops` VALUES (516,820,2700,12528,180,33,66);     -- spool_of_wool_thread
INSERT INTO `guild_shops` VALUES (516,816,592,3865,30,1,8);          -- spool_of_silk_thread
INSERT INTO `guild_shops` VALUES (516,822,585,4760,30,1,6);          -- spool_of_silver_thread
INSERT INTO `guild_shops` VALUES (516,823,13338,109440,10,0,5);      -- spool_of_gold_thread
-- INSERT INTO `guild_shops` VALUES (516,821,13338,109440,10,0,0);      -- spool_of_rainbow_thread TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (516,824,240,1344,240,16,36);       -- square_of_grass_cloth
INSERT INTO `guild_shops` VALUES (516,825,480,2944,240,16,36);       -- square_of_cotton_cloth
INSERT INTO `guild_shops` VALUES (516,826,12840,12840,120,0,0);      -- square_of_linen_cloth
INSERT INTO `guild_shops` VALUES (516,827,9180,48384,120,0,0);       -- square_of_wool_cloth
INSERT INTO `guild_shops` VALUES (516,828,21851,31710,60,0,0);       -- square_of_velvet_cloth
INSERT INTO `guild_shops` VALUES (516,829,35070,102480,240,0,0);     -- square_of_silk_cloth
-- INSERT INTO `guild_shops` VALUES (516,830,21851,31710,240,0,0);      -- square_of_rainbow_cloth TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (516,847,26,192,240,0,0);        -- bird_feather TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (516,841,26,192,240,0,0);           -- yagudo_feather
-- INSERT INTO `guild_shops` VALUES (516,842,26,192,240,0,0);        -- giant_bird_feather TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (516,12608,26,192,60,0,0);         -- tunic TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (516,12609,26,192,60,0,0);         -- black_tunic TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (516,12592,26,192,60,0,0);         -- doublet TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (516,12593,66992,66992,60,0,0);     -- cotton_doublet
INSERT INTO `guild_shops` VALUES (516,13750,87178,87178,60,0,0);     -- linen_doublet
-- INSERT INTO `guild_shops` VALUES (516,12594,87178,87178,60,0,0);     -- gambison TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (516,12595,87178,87178,60,0,0);     -- wool_gambison TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (516,12600,424,1171,60,0,0);        -- robe
INSERT INTO `guild_shops` VALUES (516,12601,14684,14684,60,0,0);     -- linen_robe
-- INSERT INTO `guild_shops` VALUES (516,12602,14684,14684,60,0,0);     -- wool_robe TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (516,12603,14684,14684,60,0,0);     -- velvet_robe TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (516,12610,14684,14684,60,0,0);     -- cloak TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (516,12976,1339,6486,60,0,0);       -- gaiters
-- INSERT INTO `guild_shops` VALUES (516,12977,1339,6486,60,0,0);       -- cotton_gaiters TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (516,12978,1339,6486,60,0,0);       -- socks TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (516,12979,171776,171776,60,0,0);   -- wool_socks
INSERT INTO `guild_shops` VALUES (516,12720,2787,7393,60,0,0);       -- gloves
-- INSERT INTO `guild_shops` VALUES (516,12721,2787,7393,60,0,0);       -- cotton_gloves TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (516,12722,2787,7393,60,0,0);       -- bracers TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (516,12723,2787,7393,60,0,0);       -- wool_bracers TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (516,12728,424,1171,60,0,0);        -- cuffs TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (516,12729,424,1171,60,0,0);        -- linen_cuffs TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (516,12730,424,1171,60,0,0);        -- wool_cuffs TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (516,12731,424,1171,60,0,0);        -- velvet_cuffs TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (516,12736,1290,3196,60,0,0);       -- mitts
-- INSERT INTO `guild_shops` VALUES (516,12738,424,1171,60,0,0);        -- linen_mitts TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (516,12739,37862,172339,60,0,0);    -- black_mitts
INSERT INTO `guild_shops` VALUES (516,12464,2710,7898,60,0,0);       -- headgear
INSERT INTO `guild_shops` VALUES (516,12465,35315,38882,60,0,0);     -- cotton_headgear
-- INSERT INTO `guild_shops` VALUES (516,12498,424,1171,60,0,0);        -- cotton_headband TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (516,12499,14160,78080,60,0,0);     -- flax_headband
-- INSERT INTO `guild_shops` VALUES (516,13568,424,1171,60,0,0);        -- scarlet_ribbon TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (516,12466,23200,39400,60,0,0);     -- red_cap
-- INSERT INTO `guild_shops` VALUES (516,12467,424,1171,60,0,0);        -- wool_cap TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (516,12474,424,1171,60,0,0);        -- wool_hat TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (516,12475,424,1171,60,0,0);        -- velvet_hat TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (516,12848,424,1171,60,0,0);        -- brais TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (516,12849,424,1171,60,0,0);        -- cotton_brais TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (516,12850,424,1171,60,0,0);        -- hose TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (516,12851,135936,228096,60,0,0);   -- wool_hose
INSERT INTO `guild_shops` VALUES (516,12856,372,936,60,0,0);         -- slops
-- INSERT INTO `guild_shops` VALUES (516,12857,424,1171,60,0,0);        -- linen_slops TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (516,12858,424,1171,60,0,0);        -- wool_slops TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (516,12859,424,1171,60,0,0);        -- velvet_slops TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (516,12864,424,1171,60,0,0);        -- slacks TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (516,12866,424,1171,60,0,0);        -- linen_slacks TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (516,12865,424,1171,60,0,0);        -- black_slacks TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (516,13583,318,1683,60,0,0);        -- cape
INSERT INTO `guild_shops` VALUES (516,13584,10321,40322,60,0,0);     -- cotton_cape
INSERT INTO `guild_shops` VALUES (516,13577,15190,42134,60,0,0);     -- black_cape
-- INSERT INTO `guild_shops` VALUES (516,13586,15190,42134,60,0,0);     -- red_cape TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (516,13075,15190,42134,60,0,0);     -- feather_collar TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (516,13085,918,4838,60,0,0);        -- hemp_gorget
-- INSERT INTO `guild_shops` VALUES (516,13322,15190,42134,60,0,0);     -- wing_earring TODO: missing min_price and max_price

-- Babubu (Port Windurst) Fishing Guild
INSERT INTO `guild_shops` VALUES (517,17396,3,8,240,48,180);       -- little_worm
INSERT INTO `guild_shops` VALUES (517,17395,9,13,240,48,180);      -- lugworm
INSERT INTO `guild_shops` VALUES (517,16996,52,322,240,48,144);    -- sardine_ball
INSERT INTO `guild_shops` VALUES (517,16997,52,322,240,48,144);    -- crayfish_ball
INSERT INTO `guild_shops` VALUES (517,16998,30,214,240,48,144);    -- insect_ball
INSERT INTO `guild_shops` VALUES (517,16999,52,322,240,48,144);    -- trout_ball
INSERT INTO `guild_shops` VALUES (517,17000,52,322,240,48,144);    -- meatball
INSERT INTO `guild_shops` VALUES (517,17392,213,283,240,48,144);   -- sliced_sardine
INSERT INTO `guild_shops` VALUES (517,17393,64,1083,240,48,144);   -- sliced_cod
INSERT INTO `guild_shops` VALUES (517,17394,220,300,240,48,144);   -- peeled_lobster
INSERT INTO `guild_shops` VALUES (517,16992,52,322,240,48,144);    -- slice_of_bluetail
INSERT INTO `guild_shops` VALUES (517,16993,52,322,240,48,144);    -- peeled_crayfish
INSERT INTO `guild_shops` VALUES (517,16994,52,322,240,48,144);    -- slice_of_carp
INSERT INTO `guild_shops` VALUES (517,17405,540,2480,240,6,144);   -- fly_lure
INSERT INTO `guild_shops` VALUES (517,17407,303,955,240,6,144);    -- minnow
INSERT INTO `guild_shops` VALUES (517,17400,691,5036,120,0,0);     -- sinking_minnow
INSERT INTO `guild_shops` VALUES (517,17404,540,2480,240,6,144);   -- worm_lure
INSERT INTO `guild_shops` VALUES (517,17403,540,2480,120,0,0);     -- frog_lure
-- INSERT INTO `guild_shops` VALUES (517,17402,5684,5684,120,0,0);    -- shrimp_lure TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (517,17401,4553,4553,120,0,0);    -- lizard_lure TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (517,17399,2394,11746,240,6,144); -- sabiki_rig
INSERT INTO `guild_shops` VALUES (517,17391,44,74,180,10,108);     -- willow_fishing_rod
INSERT INTO `guild_shops` VALUES (517,17390,145,245,180,10,108);   -- yew_fishing_rod
INSERT INTO `guild_shops` VALUES (517,17389,332,561,180,10,108);   -- bamboo_fishing_rod
INSERT INTO `guild_shops` VALUES (517,17388,766,1324,120,10,72);   -- fastwater_fishing_rod
INSERT INTO `guild_shops` VALUES (517,17387,4077,5001,60,5,36);    -- tarutaru_fishing_rod
INSERT INTO `guild_shops` VALUES (517,17380,25740,28657,60,5,40);  -- mithran_fishing_rod
-- INSERT INTO `guild_shops` VALUES (517,17385,42104,42104,60,0,0);   -- glass_fiber_fishing_rod TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (517,17383,1980,2376,60,10,36);   -- clothespole
INSERT INTO `guild_shops` VALUES (517,17382,7081,15398,60,5,36);   -- single_hook_fishing_rod
INSERT INTO `guild_shops` VALUES (517,4443,24,165,240,48,144);     -- cobalt_jellyfish
INSERT INTO `guild_shops` VALUES (517,4472,30,238,240,48,18);      -- crayfish
INSERT INTO `guild_shops` VALUES (517,624,24,172,120,0,0);         -- clump_of_pamtam_kelp
INSERT INTO `guild_shops` VALUES (517,4401,91,198,120,0,0);        -- moat_carp
-- INSERT INTO `guild_shops` VALUES (517,4289,297,297,120,0,0);       -- forest_carp TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (517,4360,24,160,120,0,0);        -- bastore_sardine
INSERT INTO `guild_shops` VALUES (517,4354,120,644,120,0,0);       -- shining_trout
INSERT INTO `guild_shops` VALUES (517,4484,1350,8784,120,0,0);     -- shall_shell
INSERT INTO `guild_shops` VALUES (517,4379,108,452,120,0,0);       -- cheval_salmon
INSERT INTO `guild_shops` VALUES (517,4403,71,1133,120,0,0);       -- yellow_globe
INSERT INTO `guild_shops` VALUES (517,4426,195,1848,120,0,0);      -- tricolored_carp
INSERT INTO `guild_shops` VALUES (517,4427,1350,6408,120,0,0);     -- gold_carp
INSERT INTO `guild_shops` VALUES (517,4482,300,2000,120,0,0);      -- nosteau_herring
INSERT INTO `guild_shops` VALUES (517,4464,172,1140,120,0,0);      -- pipira
INSERT INTO `guild_shops` VALUES (517,4483,195,1848,120,0,0);      -- tiger_cod
INSERT INTO `guild_shops` VALUES (517,4428,45,452,120,0,0);        -- dark_bass
INSERT INTO `guild_shops` VALUES (517,4361,195,1848,120,0,0);      -- nebimonite
INSERT INTO `guild_shops` VALUES (517,4304,5250,34720,120,0,0);    -- grimmonite
INSERT INTO `guild_shops` VALUES (517,4429,979,5068,120,0,0);      -- black_eel
INSERT INTO `guild_shops` VALUES (517,4481,120,800,120,0,0);       -- ogre_eel
INSERT INTO `guild_shops` VALUES (517,4288,2100,13888,120,0,0);    -- zebra_eel
INSERT INTO `guild_shops` VALUES (517,4470,688,4590,120,0,0);      -- icefish
INSERT INTO `guild_shops` VALUES (517,4291,348,634,120,0,0);       -- sandfish
INSERT INTO `guild_shops` VALUES (517,4385,115,775,120,0,0);       -- zafmlug_bass
INSERT INTO `guild_shops` VALUES (517,4402,1350,8784,120,0,0);     -- red_terrapin
INSERT INTO `guild_shops` VALUES (517,4383,864,5989,120,0,0);      -- gold_lobster
INSERT INTO `guild_shops` VALUES (517,4399,1350,8784,120,0,0);     -- bluetail
INSERT INTO `guild_shops` VALUES (517,4473,2310,15276,120,0,0);    -- crescent_fish
INSERT INTO `guild_shops` VALUES (517,4485,2100,13888,120,0,0);    -- noble_lady
INSERT INTO `guild_shops` VALUES (517,4515,132,396,120,0,0);       -- copper_frog
INSERT INTO `guild_shops` VALUES (517,4290,1008,1289,120,0,0);     -- elshimo_frog
INSERT INTO `guild_shops` VALUES (517,4579,1312,8680,120,0,0);     -- elshimo_newt
INSERT INTO `guild_shops` VALUES (517,4451,3000,19840,120,0,0);    -- silver_shark
INSERT INTO `guild_shops` VALUES (517,4461,4050,26784,120,0,0);    -- bastore_bream
INSERT INTO `guild_shops` VALUES (517,4384,5250,34720,120,0,0);    -- black_sole
INSERT INTO `guild_shops` VALUES (517,4500,24,208,120,0,0);        -- greedie
INSERT INTO `guild_shops` VALUES (517,4514,60,396,120,0,0);        -- quus
INSERT INTO `guild_shops` VALUES (517,4580,1940,4960,120,0,0);     -- coral_butterfly
INSERT INTO `guild_shops` VALUES (517,4469,375,2856,120,0,0);      -- giant_catfish
INSERT INTO `guild_shops` VALUES (517,4307,10746,24624,120,0,0);   -- jungle_catfish
INSERT INTO `guild_shops` VALUES (517,4462,1350,8784,120,0,0);     -- monke_onke
INSERT INTO `guild_shops` VALUES (517,4477,3540,19840,120,0,0);    -- gavial_fish
INSERT INTO `guild_shops` VALUES (517,4480,455,2800,120,0,0);      -- gugru_tuna
INSERT INTO `guild_shops` VALUES (517,4479,1350,8784,120,0,0);     -- bhefhel_marlin
INSERT INTO `guild_shops` VALUES (517,4471,2100,13888,120,0,0);    -- bladefish

-- Graegham / Mendoline (Selbina) Fishing Guild (S) -- TODO: Audit this vendor immediately after server maintenance.
INSERT INTO `guild_shops` VALUES (5182,17399,2394,11746,240,6,144); -- sabiki_rig
INSERT INTO `guild_shops` VALUES (5182,17388,766,1324,120,10,72);   -- fastwater_fishing_rod
INSERT INTO `guild_shops` VALUES (5182,17387,4077,5001,60,5,36);    -- tarutaru_fishing_rod
INSERT INTO `guild_shops` VALUES (5182,17383,1980,2376,60,10,36);   -- clothespole
INSERT INTO `guild_shops` VALUES (5182,17382,7081,15398,60,5,36);   -- single_hook_fishing_rod
INSERT INTO `guild_shops` VALUES (5182,4443,24,165,240,0,0);        -- cobalt_jellyfish
INSERT INTO `guild_shops` VALUES (5182,4472,30,238,240,0,0);        -- crayfish
INSERT INTO `guild_shops` VALUES (5182,624,24,172,120,0,0);         -- clump_of_pamtam_kelp
INSERT INTO `guild_shops` VALUES (5182,4360,24,160,120,0,0);        -- bastore_sardine
INSERT INTO `guild_shops` VALUES (5182,4354,120,644,120,0,0);       -- shining_trout
INSERT INTO `guild_shops` VALUES (5182,4484,1350,8784,120,0,0);     -- shall_shell
INSERT INTO `guild_shops` VALUES (5182,4379,108,452,120,0,0);       -- cheval_salmon
INSERT INTO `guild_shops` VALUES (5182,4403,71,1133,120,0,0);       -- yellow_globe
INSERT INTO `guild_shops` VALUES (5182,4426,195,1848,120,0,0);      -- tricolored_carp
INSERT INTO `guild_shops` VALUES (5182,4482,300,1984,120,0,0);      -- nosteau_herring
INSERT INTO `guild_shops` VALUES (5182,4483,195,1848,120,0,0);      -- tiger_cod
INSERT INTO `guild_shops` VALUES (5182,4428,45,452,120,0,0);        -- dark_bass
INSERT INTO `guild_shops` VALUES (5182,4481,120,800,120,0,0);       -- ogre_eel
INSERT INTO `guild_shops` VALUES (5182,4470,688,4590,120,0,0);      -- icefish
INSERT INTO `guild_shops` VALUES (5182,4385,115,775,120,0,0);       -- zafmlug_bass
INSERT INTO `guild_shops` VALUES (5182,4402,1350,8784,120,0,0);     -- red_terrapin
INSERT INTO `guild_shops` VALUES (5182,4383,864,5989,120,0,0);      -- gold_lobster
INSERT INTO `guild_shops` VALUES (5182,4399,1350,8784,120,0,0);     -- bluetail
INSERT INTO `guild_shops` VALUES (5182,4485,2100,13888,120,0,0);    -- noble_lady
INSERT INTO `guild_shops` VALUES (5182,4515,132,396,120,0,0);       -- copper_frog
INSERT INTO `guild_shops` VALUES (5182,4451,3000,19840,120,0,0);    -- silver_shark
INSERT INTO `guild_shops` VALUES (5182,4461,4050,26784,120,0,0);    -- bastore_bream
INSERT INTO `guild_shops` VALUES (5182,4384,5250,34720,120,0,0);    -- black_sole
INSERT INTO `guild_shops` VALUES (5182,4500,24,208,120,0,0);        -- greedie
INSERT INTO `guild_shops` VALUES (5182,4514,60,396,120,0,0);        -- quus
INSERT INTO `guild_shops` VALUES (5182,4469,375,2856,120,0,0);      -- giant_catfish
INSERT INTO `guild_shops` VALUES (5182,4477,3540,19840,120,0,0);    -- gavial_fish
INSERT INTO `guild_shops` VALUES (5182,4480,455,2800,120,0,0);      -- gugru_tuna
INSERT INTO `guild_shops` VALUES (5182,4479,1350,8784,120,0,0);     -- bhefhel_marlin

-- Rajmonda (Ship bound for Selbina) Fishing Guild -- TODO: Audit this vendor immediately after server maintenance.
INSERT INTO `guild_shops` VALUES (520,17395,9,13,240,48,180);     -- lugworm
INSERT INTO `guild_shops` VALUES (520,17407,303,955,60,6,20);     -- minnow
INSERT INTO `guild_shops` VALUES (520,17400,691,5036,60,6,16);    -- sinking_minnow
INSERT INTO `guild_shops` VALUES (520,17399,2394,11746,120,6,20); -- sabiki_rig
INSERT INTO `guild_shops` VALUES (520,17387,4077,5001,240,5,140); -- tarutaru_fishing_rod
INSERT INTO `guild_shops` VALUES (520,4443,24,165,200,0,0);       -- cobalt_jellyfish
INSERT INTO `guild_shops` VALUES (520,624,24,172,200,0,0);        -- clump_of_pamtam_kelp
INSERT INTO `guild_shops` VALUES (520,4360,24,160,200,0,0);       -- bastore_sardine
INSERT INTO `guild_shops` VALUES (520,4484,1350,8784,200,0,0);    -- shall_shell
INSERT INTO `guild_shops` VALUES (520,4403,71,1133,200,0,0);      -- yellow_globe
INSERT INTO `guild_shops` VALUES (520,4482,736,752,200,0,0);      -- nosteau_herring
INSERT INTO `guild_shops` VALUES (520,4483,509,1812,200,0,0);     -- tiger_cod
INSERT INTO `guild_shops` VALUES (520,4361,195,1848,200,0,0);     -- nebimonite
INSERT INTO `guild_shops` VALUES (520,4481,120,800,200,0,0);      -- ogre_eel
INSERT INTO `guild_shops` VALUES (520,4385,115,775,200,0,0);      -- zafmlug_bass
INSERT INTO `guild_shops` VALUES (520,4383,864,5989,120,0,0);     -- gold_lobster
INSERT INTO `guild_shops` VALUES (520,4399,1350,8784,200,0,0);    -- bluetail
INSERT INTO `guild_shops` VALUES (520,4485,2100,13888,120,0,0);   -- noble_lady
INSERT INTO `guild_shops` VALUES (520,4451,3000,19840,200,0,0);   -- silver_shark
INSERT INTO `guild_shops` VALUES (520,4461,4050,26784,120,0,0);   -- bastore_bream
INSERT INTO `guild_shops` VALUES (520,4384,5250,34720,120,0,0);   -- black_sole
INSERT INTO `guild_shops` VALUES (520,4500,24,208,200,0,0);       -- greedie
INSERT INTO `guild_shops` VALUES (520,4514,60,396,200,0,0);       -- quus
INSERT INTO `guild_shops` VALUES (520,4480,455,2800,120,0,0);     -- gugru_tuna
INSERT INTO `guild_shops` VALUES (520,4479,1350,8784,60,0,0);     -- bhefhel_marlin
INSERT INTO `guild_shops` VALUES (520,4471,2100,13888,40,0,0);    -- bladefish

-- Lokhong (Ship bound for Mhaura) Fishing Guild -- TODO: Audit this vendor immediately after server maintenance.
INSERT INTO `guild_shops` VALUES (521,17395,9,13,240,48,180);     -- lugworm
INSERT INTO `guild_shops` VALUES (521,17407,303,955,60,6,20);     -- minnow
INSERT INTO `guild_shops` VALUES (521,17400,691,5036,60,6,16);    -- sinking_minnow
INSERT INTO `guild_shops` VALUES (521,17399,2394,11746,120,6,20); -- sabiki_rig
INSERT INTO `guild_shops` VALUES (521,17387,4077,5001,240,5,140); -- tarutaru_fishing_rod
INSERT INTO `guild_shops` VALUES (521,4443,24,165,200,0,0);       -- cobalt_jellyfish
INSERT INTO `guild_shops` VALUES (521,624,24,172,200,0,0);        -- clump_of_pamtam_kelp
INSERT INTO `guild_shops` VALUES (521,4360,24,160,200,0,0);       -- bastore_sardine
INSERT INTO `guild_shops` VALUES (521,4484,1350,8784,200,0,0);    -- shall_shell
INSERT INTO `guild_shops` VALUES (521,4403,71,1133,200,0,0);      -- yellow_globe
INSERT INTO `guild_shops` VALUES (521,4482,300,2000,200,0,0);     -- nosteau_herring
INSERT INTO `guild_shops` VALUES (521,4483,195,1848,200,0,0);     -- tiger_cod
INSERT INTO `guild_shops` VALUES (521,4361,195,1848,200,0,0);     -- nebimonite
INSERT INTO `guild_shops` VALUES (521,4481,120,800,200,0,0);      -- ogre_eel
INSERT INTO `guild_shops` VALUES (521,4385,115,775,200,0,0);      -- zafmlug_bass
INSERT INTO `guild_shops` VALUES (521,4383,864,5989,120,0,0);     -- gold_lobster
INSERT INTO `guild_shops` VALUES (521,4399,1350,8784,200,0,0);    -- bluetail
INSERT INTO `guild_shops` VALUES (521,4485,2100,13888,120,0,0);   -- noble_lady
INSERT INTO `guild_shops` VALUES (521,4451,3000,19840,200,0,0);   -- silver_shark
INSERT INTO `guild_shops` VALUES (521,4461,4050,26784,120,0,0);   -- bastore_bream
INSERT INTO `guild_shops` VALUES (521,4384,5250,34720,120,0,0);   -- black_sole
INSERT INTO `guild_shops` VALUES (521,4500,24,208,200,0,0);       -- greedie
INSERT INTO `guild_shops` VALUES (521,4514,60,396,200,0,0);       -- quus
INSERT INTO `guild_shops` VALUES (521,4480,455,2800,120,0,0);     -- gugru_tuna
INSERT INTO `guild_shops` VALUES (521,4479,1350,8784,60,0,0);     -- bhefhel_marlin
INSERT INTO `guild_shops` VALUES (521,4471,2100,13888,40,0,0);    -- bladefish

-- Cehn Teyohngo (Open sea route to Al Zahbi) Fishing Guild -- TODO: Audit this vendor immediately after server maintenance.
INSERT INTO `guild_shops` VALUES (522,17395,9,13,240,48,180);     -- lugworm
INSERT INTO `guild_shops` VALUES (522,17407,303,955,60,6,20);     -- minnow
INSERT INTO `guild_shops` VALUES (522,17400,691,5036,60,6,16);    -- sinking_minnow
INSERT INTO `guild_shops` VALUES (522,17399,2394,11746,120,6,20); -- sabiki_rig
INSERT INTO `guild_shops` VALUES (522,17387,4077,5001,240,5,140); -- tarutaru_fishing_rod
INSERT INTO `guild_shops` VALUES (522,4443,24,165,200,0,0);       -- cobalt_jellyfish
INSERT INTO `guild_shops` VALUES (522,624,24,172,200,0,0);        -- clump_of_pamtam_kelp
INSERT INTO `guild_shops` VALUES (522,4360,24,160,200,0,0);       -- bastore_sardine
INSERT INTO `guild_shops` VALUES (522,4484,1350,8784,200,0,0);    -- shall_shell
INSERT INTO `guild_shops` VALUES (522,4403,71,1133,200,0,0);      -- yellow_globe
INSERT INTO `guild_shops` VALUES (522,4482,300,2000,200,0,0);     -- nosteau_herring
INSERT INTO `guild_shops` VALUES (522,4483,195,1848,200,0,0);     -- tiger_cod
INSERT INTO `guild_shops` VALUES (522,4361,195,1848,200,0,0);     -- nebimonite
INSERT INTO `guild_shops` VALUES (522,4481,120,800,200,0,0);      -- ogre_eel
INSERT INTO `guild_shops` VALUES (522,4385,115,775,200,0,0);      -- zafmlug_bass
INSERT INTO `guild_shops` VALUES (522,4383,864,5989,120,0,0);     -- gold_lobster
INSERT INTO `guild_shops` VALUES (522,4399,1350,8784,200,0,0);    -- bluetail
INSERT INTO `guild_shops` VALUES (522,4485,2100,13888,120,0,0);   -- noble_lady
INSERT INTO `guild_shops` VALUES (522,4451,3000,19840,200,0,0);   -- silver_shark
INSERT INTO `guild_shops` VALUES (522,4461,4050,26784,120,0,0);   -- bastore_bream
INSERT INTO `guild_shops` VALUES (522,4384,5250,34720,120,0,0);   -- black_sole
INSERT INTO `guild_shops` VALUES (522,4500,24,208,200,0,0);       -- greedie
INSERT INTO `guild_shops` VALUES (522,4514,60,396,200,0,0);       -- quus
INSERT INTO `guild_shops` VALUES (522,4480,455,2800,120,0,0);     -- gugru_tuna
INSERT INTO `guild_shops` VALUES (522,4479,1350,8784,60,0,0);     -- bhefhel_marlin
INSERT INTO `guild_shops` VALUES (522,4471,2100,13888,40,0,0);    -- bladefish

-- Pashi Maccaleh (Open sea route to Mhaura) Fishing Guild -- TODO: Audit this vendor immediately after server maintenance.
INSERT INTO `guild_shops` VALUES (523,17395,9,13,240,48,180);     -- lugworm
INSERT INTO `guild_shops` VALUES (523,17407,303,955,60,6,20);     -- minnow
INSERT INTO `guild_shops` VALUES (523,17400,691,5036,60,6,16);    -- sinking_minnow
INSERT INTO `guild_shops` VALUES (523,17399,2394,11746,120,6,20); -- sabiki_rig
INSERT INTO `guild_shops` VALUES (523,17387,4077,5001,240,5,140); -- tarutaru_fishing_rod
INSERT INTO `guild_shops` VALUES (523,4443,24,165,200,0,0);       -- cobalt_jellyfish
INSERT INTO `guild_shops` VALUES (523,624,24,172,200,0,0);        -- clump_of_pamtam_kelp
INSERT INTO `guild_shops` VALUES (523,4360,24,160,200,0,0);       -- bastore_sardine
INSERT INTO `guild_shops` VALUES (523,4484,1350,8784,200,0,0);    -- shall_shell
INSERT INTO `guild_shops` VALUES (523,4403,71,1133,200,0,0);      -- yellow_globe
INSERT INTO `guild_shops` VALUES (523,4482,300,2000,200,0,0);     -- nosteau_herring
INSERT INTO `guild_shops` VALUES (523,4483,195,1848,200,0,0);     -- tiger_cod
INSERT INTO `guild_shops` VALUES (523,4361,195,1848,200,0,0);     -- nebimonite
INSERT INTO `guild_shops` VALUES (523,4481,120,800,200,0,0);      -- ogre_eel
INSERT INTO `guild_shops` VALUES (523,4385,115,775,200,0,0);      -- zafmlug_bass
INSERT INTO `guild_shops` VALUES (523,4383,864,5989,120,0,0);     -- gold_lobster
INSERT INTO `guild_shops` VALUES (523,4399,1350,8784,200,0,0);    -- bluetail
INSERT INTO `guild_shops` VALUES (523,4485,2100,13888,120,0,0);   -- noble_lady
INSERT INTO `guild_shops` VALUES (523,4451,3000,19840,200,0,0);   -- silver_shark
INSERT INTO `guild_shops` VALUES (523,4461,4050,26784,120,0,0);   -- bastore_bream
INSERT INTO `guild_shops` VALUES (523,4384,5250,34720,120,0,0);   -- black_sole
INSERT INTO `guild_shops` VALUES (523,4500,24,208,200,0,0);       -- greedie
INSERT INTO `guild_shops` VALUES (523,4514,60,396,200,0,0);       -- quus
INSERT INTO `guild_shops` VALUES (523,4480,455,2800,120,0,0);     -- gugru_tuna
INSERT INTO `guild_shops` VALUES (523,4479,1350,8784,60,0,0);     -- bhefhel_marlin
INSERT INTO `guild_shops` VALUES (523,4471,2100,13888,40,0,0);    -- bladefish

-- Jidwahn (Silver Sea route to Nashmau) Fishing Guild
INSERT INTO `guild_shops` VALUES (524,17395,9,13,240,48,180);     -- lugworm
INSERT INTO `guild_shops` VALUES (524,17399,2394,11746,120,6,20); -- sabiki_rig
INSERT INTO `guild_shops` VALUES (524,17407,303,955,60,6,20);     -- minnow
INSERT INTO `guild_shops` VALUES (524,17400,691,5036,60,6,16);    -- sinking_minnow
INSERT INTO `guild_shops` VALUES (524,17387,5001,4077,240,5,140); -- tarutaru_fishing_rod
INSERT INTO `guild_shops` VALUES (524,4443,24,165,200,0,0);       -- cobalt_jellyfish
INSERT INTO `guild_shops` VALUES (524,624,24,172,200,0,0);        -- clump_of_pamtam_kelp
INSERT INTO `guild_shops` VALUES (524,4360,24,160,200,0,0);       -- bastore_sardine
INSERT INTO `guild_shops` VALUES (524,4484,1350,8784,200,0,0);    -- shall_shell
INSERT INTO `guild_shops` VALUES (524,4403,71,1133,200,0,0);      -- yellow_globe
INSERT INTO `guild_shops` VALUES (524,4482,300,2000,200,0,0);     -- nosteau_herring
INSERT INTO `guild_shops` VALUES (524,4483,195,1848,200,0,0);     -- tiger_cod
INSERT INTO `guild_shops` VALUES (524,4361,195,1848,200,0,0);     -- nebimonite
INSERT INTO `guild_shops` VALUES (524,4481,120,800,200,0,0);      -- ogre_eel
INSERT INTO `guild_shops` VALUES (524,4385,115,775,200,0,0);      -- zafmlug_bass
INSERT INTO `guild_shops` VALUES (524,4383,864,5989,120,0,0);     -- gold_lobster
INSERT INTO `guild_shops` VALUES (524,4399,1350,8784,200,0,0);    -- bluetail
INSERT INTO `guild_shops` VALUES (524,4485,2100,13888,120,0,0);   -- noble_lady
INSERT INTO `guild_shops` VALUES (524,4451,3000,19840,200,0,0);   -- silver_shark
INSERT INTO `guild_shops` VALUES (524,4461,4050,26784,120,0,0);   -- bastore_bream
INSERT INTO `guild_shops` VALUES (524,4384,5250,34720,120,0,0);   -- black_sole
INSERT INTO `guild_shops` VALUES (524,4500,24,208,200,0,0);       -- greedie
INSERT INTO `guild_shops` VALUES (524,4514,60,396,200,0,0);       -- quus
INSERT INTO `guild_shops` VALUES (524,4480,455,2800,120,0,0);     -- gugru_tuna
INSERT INTO `guild_shops` VALUES (524,4479,1350,8784,60,0,0);     -- bhefhel_marlin
INSERT INTO `guild_shops` VALUES (524,4471,2100,13888,40,0,0);    -- bladefish
INSERT INTO `guild_shops` VALUES (524,5140,69888,75504,200,0,0);  -- kalkanbaligi
INSERT INTO `guild_shops` VALUES (524,5448,1275,8432,200,0,0);    -- kalamar
INSERT INTO `guild_shops` VALUES (524,5449,24,160,200,0,0);       -- hamsi
INSERT INTO `guild_shops` VALUES (524,5450,455,2800,200,0,0);     -- lakerda
INSERT INTO `guild_shops` VALUES (524,5451,1350,8784,200,0,0);    -- kilicbaligi
INSERT INTO `guild_shops` VALUES (524,5452,1350,8784,55,0,0);     -- uskumru
INSERT INTO `guild_shops` VALUES (524,2177,36,224,240,10,140);    -- ice_card
INSERT INTO `guild_shops` VALUES (524,2180,36,224,240,10,140);    -- thunder_card
INSERT INTO `guild_shops` VALUES (524,2182,36,224,240,10,140);    -- light_card
INSERT INTO `guild_shops` VALUES (524,2183,36,224,240,10,140);    -- dark_card

-- Yahliq (Silver Sea route to Al Zahbi) Fishing Guild
INSERT INTO `guild_shops` VALUES (525,17395,9,13,240,48,180);     -- lugworm
INSERT INTO `guild_shops` VALUES (525,17399,2394,11746,120,6,20); -- sabiki_rig
INSERT INTO `guild_shops` VALUES (525,17407,303,955,60,6,20);     -- minnow
INSERT INTO `guild_shops` VALUES (525,17400,691,5036,60,6,16);    -- sinking_minnow
INSERT INTO `guild_shops` VALUES (525,17387,5001,4077,240,5,140); -- tarutaru_fishing_rod
INSERT INTO `guild_shops` VALUES (525,4443,24,165,200,0,0);       -- cobalt_jellyfish
INSERT INTO `guild_shops` VALUES (525,624,24,172,200,0,0);        -- clump_of_pamtam_kelp
INSERT INTO `guild_shops` VALUES (525,4360,24,160,200,0,0);       -- bastore_sardine
INSERT INTO `guild_shops` VALUES (525,4484,1350,8784,200,0,0);    -- shall_shell
INSERT INTO `guild_shops` VALUES (525,4403,71,1133,200,0,0);      -- yellow_globe
INSERT INTO `guild_shops` VALUES (525,4482,300,2000,200,0,0);     -- nosteau_herring
INSERT INTO `guild_shops` VALUES (525,4483,195,1848,200,0,0);     -- tiger_cod
INSERT INTO `guild_shops` VALUES (525,4361,195,1848,200,0,0);     -- nebimonite
INSERT INTO `guild_shops` VALUES (525,4481,120,800,200,0,0);      -- ogre_eel
INSERT INTO `guild_shops` VALUES (525,4385,115,775,200,0,0);      -- zafmlug_bass
INSERT INTO `guild_shops` VALUES (525,4383,864,5989,120,0,0);     -- gold_lobster
INSERT INTO `guild_shops` VALUES (525,4399,1350,8784,200,0,0);    -- bluetail
INSERT INTO `guild_shops` VALUES (525,4485,2100,13888,120,0,0);   -- noble_lady
INSERT INTO `guild_shops` VALUES (525,4451,3000,19840,200,0,0);   -- silver_shark
INSERT INTO `guild_shops` VALUES (525,4461,4050,26784,120,0,0);   -- bastore_bream
INSERT INTO `guild_shops` VALUES (525,4384,5250,34720,120,0,0);   -- black_sole
INSERT INTO `guild_shops` VALUES (525,4500,24,208,200,0,0);       -- greedie
INSERT INTO `guild_shops` VALUES (525,4514,60,396,200,0,0);       -- quus
INSERT INTO `guild_shops` VALUES (525,4480,455,2800,120,0,0);     -- gugru_tuna
INSERT INTO `guild_shops` VALUES (525,4479,1350,8784,60,0,0);     -- bhefhel_marlin
INSERT INTO `guild_shops` VALUES (525,4471,2100,13888,40,0,0);    -- bladefish
INSERT INTO `guild_shops` VALUES (525,5140,69888,75504,200,0,0);  -- kalkanbaligi
INSERT INTO `guild_shops` VALUES (525,5448,1275,8432,200,0,0);    -- kalamar
INSERT INTO `guild_shops` VALUES (525,5449,24,160,200,0,0);       -- hamsi
INSERT INTO `guild_shops` VALUES (525,5450,455,2800,200,0,0);     -- lakerda
INSERT INTO `guild_shops` VALUES (525,5451,1350,8784,200,0,0);    -- kilicbaligi
INSERT INTO `guild_shops` VALUES (525,5452,1350,8784,55,0,0);     -- uskumru
INSERT INTO `guild_shops` VALUES (525,2177,36,224,240,10,140);    -- ice_card
INSERT INTO `guild_shops` VALUES (525,2180,36,224,240,10,140);    -- thunder_card
INSERT INTO `guild_shops` VALUES (525,2182,36,224,240,10,140);    -- light_card
INSERT INTO `guild_shops` VALUES (525,2183,36,224,240,10,140);    -- dark_card

-- Visala (Goldsmith Guild) Bastok Markets (S)
INSERT INTO `guild_shops` VALUES (5272,736,315,1260,240,48,180);    -- chunk_of_silver_ore
INSERT INTO `guild_shops` VALUES (5272,644,1500,9800,120,33,12);    -- chunk_of_mythril_ore
-- INSERT INTO `guild_shops` VALUES (5272,737,1500,9200,120,0,0);      -- chunk_of_gold_ore TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5272,738,6000,58032,120,0,0);     -- chunk_of_platinum_ore TODO: verify min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5272,648,6000,58032,120,0,0);     -- copper_ingot TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5272,650,6000,58032,120,0,0);     -- brass_ingot TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5272,744,4095,9996,120,0,0);      -- silver_ingot
INSERT INTO `guild_shops` VALUES (5272,653,19900,36400,120,0,0);    -- mythril_ingot
-- INSERT INTO `guild_shops` VALUES (5272,745,6000,58032,120,0,0);     -- gold_ingot TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5272,746,6000,58032,120,0,0);     -- platinum_ingot TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5272,661,1171,1171,120,0,0);      -- brass_sheet
INSERT INTO `guild_shops` VALUES (5272,663,20240,45600,120,0,0);    -- mythril_sheet
-- INSERT INTO `guild_shops` VALUES (5272,752,20240,45600,120,0,0);    -- gold_sheet TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5272,754,20240,45600,120,0,0);    -- platinum_sheet TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5272,673,210,1388,121,48,3);      -- brass_scales
INSERT INTO `guild_shops` VALUES (5272,760,29172,74880,120,0,0);    -- silver_chain
INSERT INTO `guild_shops` VALUES (5272,681,10500,67760,121,6,3);    -- mythril_chain
-- INSERT INTO `guild_shops` VALUES (5272,761,10500,30800,120,0,0);    -- gold_chain TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5272,762,10500,30800,120,0,0);    -- platinum_chain TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5272,769,1288,7000,240,33,4);     -- red_rock
INSERT INTO `guild_shops` VALUES (5272,770,1288,7000,240,33,4);     -- blue_rock
INSERT INTO `guild_shops` VALUES (5272,771,1288,7000,240,33,4);     -- yellow_rock
INSERT INTO `guild_shops` VALUES (5272,772,1288,7000,240,33,4);     -- green_rock
INSERT INTO `guild_shops` VALUES (5272,773,1288,7000,240,33,4);     -- translucent_rock
INSERT INTO `guild_shops` VALUES (5272,774,1288,7000,240,33,4);     -- purple_rock
INSERT INTO `guild_shops` VALUES (5272,775,1288,7000,240,33,4);     -- black_rock
INSERT INTO `guild_shops` VALUES (5272,776,1288,7000,240,0,4);      -- white_rock
INSERT INTO `guild_shops` VALUES (5272,795,1396,8569,120,16,18);    -- lapis_lazuli
INSERT INTO `guild_shops` VALUES (5272,796,1396,8569,120,3,18);     -- light_opal
INSERT INTO `guild_shops` VALUES (5272,799,1396,8569,120,16,18);    -- onyx
INSERT INTO `guild_shops` VALUES (5272,800,1396,8569,120,3,18);     -- amethyst
INSERT INTO `guild_shops` VALUES (5272,806,1396,8569,120,16,18);    -- tourmaline
INSERT INTO `guild_shops` VALUES (5272,807,1396,8569,120,3,18);     -- sardonyx
INSERT INTO `guild_shops` VALUES (5272,809,1396,8569,120,3,18);     -- clear_topaz
INSERT INTO `guild_shops` VALUES (5272,814,1396,8569,120,3,18);     -- amber_stone
INSERT INTO `guild_shops` VALUES (5272,788,9000,56160,24,0,0);      -- peridot
INSERT INTO `guild_shops` VALUES (5272,790,9000,27000,24,0,0);      -- garnet
INSERT INTO `guild_shops` VALUES (5272,811,9000,27000,24,0,0);      -- ametrine
INSERT INTO `guild_shops` VALUES (5272,815,9000,27000,24,0,0);      -- sphene
INSERT INTO `guild_shops` VALUES (5272,798,9000,27000,24,0,0);      -- turquoise
INSERT INTO `guild_shops` VALUES (5272,808,9000,24000,24,0,0);      -- goshenite
INSERT INTO `guild_shops` VALUES (5272,784,23400,124800,24,0,0);    -- jadeite
INSERT INTO `guild_shops` VALUES (5272,803,23400,70200,24,0,0);     -- sunstone
INSERT INTO `guild_shops` VALUES (5272,810,23400,70200,24,0,0);     -- fluorite
INSERT INTO `guild_shops` VALUES (5272,801,23400,70200,24,0,0);     -- chrysoberyl
INSERT INTO `guild_shops` VALUES (5272,791,23400,49608,24,0,0);     -- aquamarine
INSERT INTO `guild_shops` VALUES (5272,805,23400,70200,24,0,0);     -- zircon
INSERT INTO `guild_shops` VALUES (5272,797,23400,49608,24,0,0);     -- painite
INSERT INTO `guild_shops` VALUES (5272,802,23400,70200,24,0,0);     -- moonstone
INSERT INTO `guild_shops` VALUES (5272,785,48366,284544,24,0,0);    -- emerald
INSERT INTO `guild_shops` VALUES (5272,786,48366,284544,24,0,0);    -- ruby
INSERT INTO `guild_shops` VALUES (5272,804,48366,284544,24,0,0);    -- spinel
INSERT INTO `guild_shops` VALUES (5272,789,48366,284544,24,0,0);    -- topaz
INSERT INTO `guild_shops` VALUES (5272,794,48366,284544,24,0,0);    -- sapphire
INSERT INTO `guild_shops` VALUES (5272,787,48366,284544,24,0,0);    -- diamond
INSERT INTO `guild_shops` VALUES (5272,812,48366,284544,24,0,0);    -- deathstone
INSERT INTO `guild_shops` VALUES (5272,813,48366,284544,24,0,0);    -- angelstone
INSERT INTO `guild_shops` VALUES (5272,13327,5850,5850,24,0,0);     -- silver_earring
-- INSERT INTO `guild_shops` VALUES (5272,13328,5850,5850,24,0,0);     -- mythril_earring TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5272,13315,5850,5850,24,0,0);     -- gold_earring TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5272,13316,5850,5850,24,0,0);     -- platinum_earring TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5272,13317,12800,12800,24,0,0);   -- pearl_earring
INSERT INTO `guild_shops` VALUES (5272,13319,12800,12800,24,0,0);   -- peridot_earring
INSERT INTO `guild_shops` VALUES (5272,13320,12800,12800,24,0,0);   -- black_earring
INSERT INTO `guild_shops` VALUES (5272,13330,1238,1238,24,0,0);     -- tourmaline_earring
INSERT INTO `guild_shops` VALUES (5272,13331,1522,1522,24,0,0);     -- sardonyx_earring
INSERT INTO `guild_shops` VALUES (5272,13332,1186,1238,24,0,0);     -- clear_earring
INSERT INTO `guild_shops` VALUES (5272,13333,1186,1238,24,0,0);     -- amethyst_earring
INSERT INTO `guild_shops` VALUES (5272,13334,1186,1238,24,0,0);     -- lapis_lazuli_earring
-- INSERT INTO `guild_shops` VALUES (5272,13335,12880,12880,24,0,0);   -- amber_earring TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5272,13336,12880,12880,24,0,0);   -- onyx_earring TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5272,13337,12880,12880,24,0,0);   -- opal_earring TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5272,13338,12880,12880,24,0,0);   -- blood_earring TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5272,13339,12880,12880,24,0,0);   -- goshenite_earring TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5272,13340,12880,12880,24,0,0);   -- ametrine_earring
-- INSERT INTO `guild_shops` VALUES (5272,13341,12880,12880,24,0,0);   -- turquoise_earring TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5272,13342,12250,12250,24,0,0);   -- sphene_earring
INSERT INTO `guild_shops` VALUES (5272,13454,72,179,24,0,0);        -- copper_ring
-- INSERT INTO `guild_shops` VALUES (5272,13465,72,179,24,0,0);        -- brass_ring TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5272,13456,1875,2400,24,0,0);     -- silver_ring TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5272,13446,21060,21060,24,0,0);   -- mythril_ring TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5272,13445,1875,2400,24,0,0);     -- gold_ring TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5272,13447,1875,2400,24,0,0);     -- platinum_ring TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5272,13443,1875,2400,24,0,0);     -- opal_ring
INSERT INTO `guild_shops` VALUES (5272,13444,1875,2400,24,0,0);     -- sardonyx_ring
INSERT INTO `guild_shops` VALUES (5272,13468,1875,2400,24,0,0);     -- tourmaline_ring
INSERT INTO `guild_shops` VALUES (5272,13470,1875,2400,24,0,0);     -- clear_ring
INSERT INTO `guild_shops` VALUES (5272,13471,1875,2400,24,0,0);     -- amethyst_ring
INSERT INTO `guild_shops` VALUES (5272,13472,1875,2400,24,0,0);     -- lapis_lazuli_ring
INSERT INTO `guild_shops` VALUES (5272,13473,1875,2400,24,0,0);     -- amber_ring
INSERT INTO `guild_shops` VALUES (5272,13474,1875,2400,24,0,0);     -- onyx_ring
INSERT INTO `guild_shops` VALUES (5272,13979,20088,20088,24,0,0);   -- silver_bangles
-- INSERT INTO `guild_shops` VALUES (5272,13983,20088,20088,24,0,0);   -- gold_bangles TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5272,12496,117,234,24,0,0);       -- copper_hairpin
INSERT INTO `guild_shops` VALUES (5272,12497,970,1190,24,0,0);      -- brass_hairpin
INSERT INTO `guild_shops` VALUES (5272,12495,4398,4398,24,0,0);     -- silver_hairpin
INSERT INTO `guild_shops` VALUES (5272,16391,2700,13989,24,0,0);    -- brass_knuckles
INSERT INTO `guild_shops` VALUES (5272,16407,2399,13554,24,0,0);    -- brass_baghnakhs
INSERT INTO `guild_shops` VALUES (5272,16449,3422,15656,24,0,0);    -- brass_dagger
INSERT INTO `guild_shops` VALUES (5272,16551,3631,15487,24,0,0);    -- sapara
-- INSERT INTO `guild_shops` VALUES (5272,16531,3631,15487,24,0,0);    -- brass_xiphos TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5272,16641,2870,13845,24,0,0);    -- brass_axe
INSERT INTO `guild_shops` VALUES (5272,16769,2245,13221,24,0,0);    -- brass_zaghnal
-- INSERT INTO `guild_shops` VALUES (5272,17081,3631,15487,24,0,0);    -- brass_rod TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5272,17043,1735,1839,24,0,0);     -- brass_hammer
INSERT INTO `guild_shops` VALUES (5272,12472,153,214,24,0,0);       -- circlet
-- INSERT INTO `guild_shops` VALUES (5272,12473,3631,15487,24,0,0);    -- poets_circlet TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5272,12449,1503,4300,24,0,0);     -- brass_cap
INSERT INTO `guild_shops` VALUES (5272,12433,18176,30208,24,0,0);   -- brass_mask
INSERT INTO `guild_shops` VALUES (5272,12425,17100,43776,24,0,0);   -- silver_mask
-- INSERT INTO `guild_shops` VALUES (5272,12577,3631,15487,24,0,0);    -- brass_harness TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5272,12561,14000,24000,24,0,0);   -- brass_scale_mail
INSERT INTO `guild_shops` VALUES (5272,12705,1023,2620,24,0,0);     -- brass_mittens
-- INSERT INTO `guild_shops` VALUES (5272,12681,3631,15487,24,0,0);    -- silver_mittens TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5272,12689,11000,22000,24,0,0);   -- brass_finger_gauntlets
INSERT INTO `guild_shops` VALUES (5272,12833,3840,7360,24,0,0);     -- brass_subligar
INSERT INTO `guild_shops` VALUES (5272,12961,2380,3720,24,0,0);     -- brass_leggings
-- INSERT INTO `guild_shops` VALUES (5272,12817,3631,15487,24,0,0);    -- brass_cuisses TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5272,12945,11440,11440,24,0,0);   -- brass_greaves
INSERT INTO `guild_shops` VALUES (5272,13196,52284,52284,24,0,0);   -- silver_belt
-- INSERT INTO `guild_shops` VALUES (5272,13209,3631,15487,24,0,0);    -- chain_belt TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5272,13083,3631,15487,24,0,0);    -- chain_choker TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5272,13082,3631,15487,24,0,0);    -- chain_gorget TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5272,1588,20400,20400,240,3,180); -- slab_of_tufa




-- Wahnid (Fishing Guild) Aht Urhgan Whitegate
INSERT INTO `guild_shops` VALUES (60426,17396,3,8,240,48,180);       -- little_worm
INSERT INTO `guild_shops` VALUES (60426,17395,9,13,240,48,180);      -- lugworm
INSERT INTO `guild_shops` VALUES (60426,16996,52,322,240,48,156);    -- sardine_ball
INSERT INTO `guild_shops` VALUES (60426,16997,52,322,240,48,156);    -- crayfish_ball
INSERT INTO `guild_shops` VALUES (60426,16998,30,184,240,48,156);    -- insect_ball
INSERT INTO `guild_shops` VALUES (60426,16999,52,322,240,48,156);    -- trout_ball
INSERT INTO `guild_shops` VALUES (60426,17000,52,322,240,48,156);    -- meatball
INSERT INTO `guild_shops` VALUES (60426,17392,213,283,240,48,156);   -- sliced_sardine
INSERT INTO `guild_shops` VALUES (60426,17393,64,1083,240,48,57);    -- sliced_cod
INSERT INTO `guild_shops` VALUES (60426,17394,220,300,240,48,156);   -- peeled_lobster
INSERT INTO `guild_shops` VALUES (60426,16992,52,322,240,48,156);    -- slice_of_bluetail
INSERT INTO `guild_shops` VALUES (60426,16993,52,322,240,48,156);    -- peeled_crayfish
INSERT INTO `guild_shops` VALUES (60426,16994,52,322,240,48,156);    -- slice_of_carp
INSERT INTO `guild_shops` VALUES (60426,17405,540,2480,240,6,156);   -- fly_lure
INSERT INTO `guild_shops` VALUES (60426,17407,303,303,240,6,156);    -- minnow
INSERT INTO `guild_shops` VALUES (60426,17400,691,5036,120,0,0);     -- sinking_minnow
INSERT INTO `guild_shops` VALUES (60426,17404,540,2480,240,6,156);   -- worm_lure
INSERT INTO `guild_shops` VALUES (60426,17403,540,2480,120,0,0);     -- frog_lure
-- INSERT INTO `guild_shops` VALUES (60426,17402,5684,5684,120,0,0);    -- shrimp_lure TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60426,17401,4553,4553,120,0,0);    -- lizard_lure TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60426,17399,2394,11746,240,6,156); -- sabiki_rig
INSERT INTO `guild_shops` VALUES (60426,17391,44,74,180,10,117);     -- willow_fishing_rod
INSERT INTO `guild_shops` VALUES (60426,17390,145,245,180,10,117);   -- yew_fishing_rod
INSERT INTO `guild_shops` VALUES (60426,17389,332,561,180,10,117);   -- bamboo_fishing_rod
INSERT INTO `guild_shops` VALUES (60426,17388,766,1324,120,10,78);   -- fastwater_fishing_rod
INSERT INTO `guild_shops` VALUES (60426,17387,4077,5001,60,5,39);    -- tarutaru_fishing_rod
INSERT INTO `guild_shops` VALUES (60426,17380,25740,28657,60,5,45);  -- mithran_fishing_rod
-- INSERT INTO `guild_shops` VALUES (60426,17385,42104,42104,60,0,0);   -- glass_fiber_fishing_rod TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60426,17383,1980,2376,60,10,39);   -- clothespole
INSERT INTO `guild_shops` VALUES (60426,17382,7081,15398,60,5,39);   -- single_hook_fishing_rod
INSERT INTO `guild_shops` VALUES (60426,5447,24,165,240,48,156);     -- denizanasi
INSERT INTO `guild_shops` VALUES (60426,4472,30,238,120,48,24);      -- crayfish
-- INSERT INTO `guild_shops` VALUES (60426,5132,21660,28272,120,0,0);   -- gurnard TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60426,4401,91,198,120,0,0);        -- moat_carp
-- INSERT INTO `guild_shops` VALUES (60426,4289,297,297,120,0,0);       -- forest_carp TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60426,5449,24,160,120,0,0);        -- hamsi
INSERT INTO `guild_shops` VALUES (60426,5461,120,644,120,0,0);       -- alabaligi TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60426,5456,1350,8784,120,0,0);     -- istiridye
-- INSERT INTO `guild_shops` VALUES (60426,5135,16848,16848,120,0,0);   -- rhinochimera TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60426,4403,71,1133,120,0,0);       -- yellow_globe
INSERT INTO `guild_shops` VALUES (60426,4426,364,728,120,0,0);       -- tricolored_carp
INSERT INTO `guild_shops` VALUES (60426,5459,1350,1350,120,0,0);     -- sazanbaligi
INSERT INTO `guild_shops` VALUES (60426,5136,600,3968,120,0,0);      -- istavrit
INSERT INTO `guild_shops` VALUES (60426,4464,172,1140,120,0,0);      -- pipira
INSERT INTO `guild_shops` VALUES (60426,4483,195,1848,120,0,0);      -- tiger_cod
INSERT INTO `guild_shops` VALUES (60426,4428,45,452,120,0,0);        -- dark_bass
INSERT INTO `guild_shops` VALUES (60426,4361,195,1848,120,0,0);      -- nebimonite
INSERT INTO `guild_shops` VALUES (60426,5455,5250,34720,120,0,0);    -- ahtapot
INSERT INTO `guild_shops` VALUES (60426,5458,900,900,120,0,0);       -- yilanbaligi
INSERT INTO `guild_shops` VALUES (60426,4481,120,800,120,0,0);       -- ogre_eel
INSERT INTO `guild_shops` VALUES (60426,4288,2100,13888,120,0,0);    -- zebra_eel
INSERT INTO `guild_shops` VALUES (60426,4470,688,4590,120,0,0);      -- icefish
INSERT INTO `guild_shops` VALUES (60426,4291,348,634,120,0,0);       -- sandfish
INSERT INTO `guild_shops` VALUES (60426,5133,11700,77376,120,0,0);   -- pterygotus
INSERT INTO `guild_shops` VALUES (60426,4402,1350,8784,120,0,0);     -- kaplumbaga
INSERT INTO `guild_shops` VALUES (60426,5453,864,5989,120,0,0);      -- istakoz
INSERT INTO `guild_shops` VALUES (60426,5452,1350,8784,120,0,0);     -- uskumru
INSERT INTO `guild_shops` VALUES (60426,4473,2310,15276,120,0,0);    -- crescent_fish
INSERT INTO `guild_shops` VALUES (60426,4485,2100,13888,120,0,0);    -- noble_lady
INSERT INTO `guild_shops` VALUES (60426,4515,132,396,120,0,0);       -- copper_frog
-- INSERT INTO `guild_shops` VALUES (60426,5465,1008,1289,120,0,0);     -- caedarva_frog TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60426,5140,69888,75504,120,0,0);   -- kalkanbaligi
INSERT INTO `guild_shops` VALUES (60426,4451,3000,19840,120,0,0);    -- silver_shark
INSERT INTO `guild_shops` VALUES (60426,5454,4050,26784,120,0,0);    -- mercanbaligi
INSERT INTO `guild_shops` VALUES (60426,5457,5250,34720,120,0,0);    -- dil
INSERT INTO `guild_shops` VALUES (60426,4500,24,208,120,0,0);        -- greedie
INSERT INTO `guild_shops` VALUES (60426,4514,60,396,120,0,0);        -- quus
INSERT INTO `guild_shops` VALUES (60426,4580,1940,4960,120,0,0);     -- coral_butterfly
INSERT INTO `guild_shops` VALUES (60426,4469,375,2856,120,0,0);      -- yayinbaligi
INSERT INTO `guild_shops` VALUES (60426,5137,9180,60710,120,0,0);    -- turnabaligi
INSERT INTO `guild_shops` VALUES (60426,4462,1350,8784,120,0,0);     -- monke_onke
INSERT INTO `guild_shops` VALUES (60426,4477,3540,19840,120,0,0);    -- gavial_fish
INSERT INTO `guild_shops` VALUES (60426,5450,455,2800,120,0,0);      -- lakerda
INSERT INTO `guild_shops` VALUES (60426,5451,1350,8784,120,0,0);     -- kilicbaligi
INSERT INTO `guild_shops` VALUES (60426,4471,2100,13888,120,0,0);    -- bladefish
INSERT INTO `guild_shops` VALUES (60426,5448,1275,8432,120,0,0);     -- kalamar
INSERT INTO `guild_shops` VALUES (60426,5134,89700,96720,120,0,0);   -- mola_mola
INSERT INTO `guild_shops` VALUES (60426,5460,3487,23064,120,0,0);    -- kayabaligi
INSERT INTO `guild_shops` VALUES (60426,5139,2100,13888,120,0,0);    -- betta
INSERT INTO `guild_shops` VALUES (60426,2216,307,1045,120,0,0);      -- lamp_marimo
-- INSERT INTO `guild_shops` VALUES (60426,5138,26784,26784,120,0,0);   -- black_ghost TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60426,5462,26784,26784,120,0,0);   -- morinabaligi TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60426,5141,2025,13392,120,0,0);    -- veydal_wrasse



-- Bornahn (Goldsmithing Guild) Al Zahbi
INSERT INTO `guild_shops` VALUES (60429,640,9,36,240,48,180);      -- chunk_of_copper_ore
INSERT INTO `guild_shops` VALUES (60429,642,93,620,120,0,0);       -- chunk_of_zinc_ore
INSERT INTO `guild_shops` VALUES (60429,736,315,1260,240,48,180);  -- chunk_of_silver_ore
INSERT INTO `guild_shops` VALUES (60429,644,1500,9800,120,33,12);  -- chunk_of_mythril_ore
-- INSERT INTO `guild_shops` VALUES (60429,737,1500,9200,120,0,0);    -- chunk_of_gold_ore TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60429,738,6000,58032,120,0,0);   -- chunk_of_platinum_ore TODO: verify min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60429,648,6000,58032,120,0,0);   -- copper_ingot TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60429,650,6000,58032,120,0,0);   -- brass_ingot TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60429,744,4095,9996,120,0,0);    -- silver_ingot
INSERT INTO `guild_shops` VALUES (60429,653,19900,36400,120,0,0);  -- mythril_ingot
-- INSERT INTO `guild_shops` VALUES (60429,745,6000,58032,120,0,0);   -- gold_ingot TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60429,746,6000,58032,120,0,0);   -- platinum_ingot TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60429,661,1171,1171,120,0,0);    -- brass_sheet
INSERT INTO `guild_shops` VALUES (60429,663,20240,45600,120,0,0);  -- mythril_sheet
-- INSERT INTO `guild_shops` VALUES (60429,752,20240,45600,120,0,0);  -- gold_sheet TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60429,754,20240,45600,120,0,0);  -- platinum_sheet TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60429,673,210,1388,121,48,3);    -- brass_scales
INSERT INTO `guild_shops` VALUES (60429,760,29172,74880,120,0,0);  -- silver_chain
INSERT INTO `guild_shops` VALUES (60429,681,10500,67760,121,6,3);  -- mythril_chain
-- INSERT INTO `guild_shops` VALUES (60429,761,10500,30800,120,0,0);  -- gold_chain TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60429,762,10500,30800,120,0,0);  -- platinum_chain TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60429,769,1288,7000,240,33,4);   -- red_rock
INSERT INTO `guild_shops` VALUES (60429,770,1288,7000,240,33,4);   -- blue_rock
INSERT INTO `guild_shops` VALUES (60429,771,1288,7000,240,33,4);   -- yellow_rock
INSERT INTO `guild_shops` VALUES (60429,772,1288,7000,240,33,4);   -- green_rock
INSERT INTO `guild_shops` VALUES (60429,773,1288,7000,240,33,4);   -- translucent_rock
INSERT INTO `guild_shops` VALUES (60429,774,1288,7000,240,33,4);   -- purple_rock
INSERT INTO `guild_shops` VALUES (60429,775,1288,7000,240,33,4);   -- black_rock
INSERT INTO `guild_shops` VALUES (60429,776,1288,7000,240,0,4);    -- white_rock
INSERT INTO `guild_shops` VALUES (60429,795,1396,8569,120,16,18);  -- lapis_lazuli
INSERT INTO `guild_shops` VALUES (60429,796,1396,8569,120,3,18);   -- light_opal
INSERT INTO `guild_shops` VALUES (60429,799,1396,8569,120,16,18);  -- onyx
INSERT INTO `guild_shops` VALUES (60429,800,1396,8569,120,3,18);   -- amethyst
INSERT INTO `guild_shops` VALUES (60429,806,1396,8569,120,16,18);  -- tourmaline
INSERT INTO `guild_shops` VALUES (60429,807,1396,8569,120,3,18);   -- sardonyx
INSERT INTO `guild_shops` VALUES (60429,809,1396,8569,120,3,18);   -- clear_topaz
INSERT INTO `guild_shops` VALUES (60429,814,1396,8569,120,3,18);   -- amber_stone
INSERT INTO `guild_shops` VALUES (60429,788,9000,56160,24,0,0);    -- peridot
INSERT INTO `guild_shops` VALUES (60429,790,9000,27000,24,0,0);    -- garnet
INSERT INTO `guild_shops` VALUES (60429,811,9000,27000,24,0,0);    -- ametrine
INSERT INTO `guild_shops` VALUES (60429,815,9000,27000,24,0,0);    -- sphene
INSERT INTO `guild_shops` VALUES (60429,798,9000,27000,24,0,0);    -- turquoise
INSERT INTO `guild_shops` VALUES (60429,808,9000,24000,24,0,0);    -- goshenite
INSERT INTO `guild_shops` VALUES (60429,784,23400,124800,24,0,0);  -- jadeite
INSERT INTO `guild_shops` VALUES (60429,803,23400,70200,24,0,0);   -- sunstone
INSERT INTO `guild_shops` VALUES (60429,810,23400,70200,24,0,0);   -- fluorite
INSERT INTO `guild_shops` VALUES (60429,801,23400,70200,24,0,0);   -- chrysoberyl
INSERT INTO `guild_shops` VALUES (60429,791,23400,49608,24,0,0);   -- aquamarine
INSERT INTO `guild_shops` VALUES (60429,805,23400,70200,24,0,0);   -- zircon
INSERT INTO `guild_shops` VALUES (60429,797,23400,49608,24,0,0);   -- painite
INSERT INTO `guild_shops` VALUES (60429,802,23400,70200,24,0,0);   -- moonstone
INSERT INTO `guild_shops` VALUES (60429,785,48366,284544,24,0,0);  -- emerald
INSERT INTO `guild_shops` VALUES (60429,786,48366,284544,24,0,0);  -- ruby
INSERT INTO `guild_shops` VALUES (60429,804,48366,284544,24,0,0);  -- spinel
INSERT INTO `guild_shops` VALUES (60429,789,48366,284544,24,0,0);  -- topaz
INSERT INTO `guild_shops` VALUES (60429,794,48366,284544,24,0,0);  -- sapphire
INSERT INTO `guild_shops` VALUES (60429,787,48366,284544,24,0,0);  -- diamond
INSERT INTO `guild_shops` VALUES (60429,812,48366,284544,24,0,0);  -- deathstone
INSERT INTO `guild_shops` VALUES (60429,813,48366,284544,24,0,0);  -- angelstone
INSERT INTO `guild_shops` VALUES (60429,13327,5850,5850,24,0,0);   -- silver_earring
-- INSERT INTO `guild_shops` VALUES (60429,13328,5850,5850,24,0,0);   -- mythril_earring TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60429,13315,5850,5850,24,0,0);   -- gold_earring TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60429,13316,5850,5850,24,0,0);   -- platinum_earring TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60429,13317,12800,12800,24,0,0); -- pearl_earring
INSERT INTO `guild_shops` VALUES (60429,13319,12800,12800,24,0,0); -- peridot_earring
INSERT INTO `guild_shops` VALUES (60429,13320,12800,12800,24,0,0); -- black_earring
INSERT INTO `guild_shops` VALUES (60429,13330,1238,1238,24,0,0);   -- tourmaline_earring
INSERT INTO `guild_shops` VALUES (60429,13331,1522,1522,24,0,0);   -- sardonyx_earring
INSERT INTO `guild_shops` VALUES (60429,13332,1186,1238,24,0,0);   -- clear_earring
INSERT INTO `guild_shops` VALUES (60429,13333,1186,1238,24,0,0);   -- amethyst_earring
INSERT INTO `guild_shops` VALUES (60429,13334,1186,1238,24,0,0);   -- lapis_lazuli_earring
-- INSERT INTO `guild_shops` VALUES (60429,13335,12880,12880,24,0,0); -- amber_earring TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60429,13336,12880,12880,24,0,0); -- onyx_earring TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60429,13337,12880,12880,24,0,0); -- opal_earring TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60429,13338,12880,12880,24,0,0); -- blood_earring TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60429,13339,12880,12880,24,0,0); -- goshenite_earring TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60429,13340,12880,12880,24,0,0); -- ametrine_earring
-- INSERT INTO `guild_shops` VALUES (60429,13341,12880,12880,24,0,0); -- turquoise_earring TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60429,13342,12250,12250,24,0,0); -- sphene_earring
INSERT INTO `guild_shops` VALUES (60429,13454,72,179,24,0,0);      -- copper_ring
-- INSERT INTO `guild_shops` VALUES (60429,13465,72,179,24,0,0);      -- brass_ring TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60429,13456,1875,2400,24,0,0);   -- silver_ring TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60429,13446,21060,21060,24,0,0); -- mythril_ring TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60429,13445,1875,2400,24,0,0);   -- gold_ring TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60429,13447,1875,2400,24,0,0);   -- platinum_ring TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60429,13443,1875,2400,24,0,0);   -- opal_ring
INSERT INTO `guild_shops` VALUES (60429,13444,1875,2400,24,0,0);   -- sardonyx_ring
INSERT INTO `guild_shops` VALUES (60429,13468,1875,2400,24,0,0);   -- tourmaline_ring
INSERT INTO `guild_shops` VALUES (60429,13470,1875,2400,24,0,0);   -- clear_ring
INSERT INTO `guild_shops` VALUES (60429,13471,1875,2400,24,0,0);   -- amethyst_ring
INSERT INTO `guild_shops` VALUES (60429,13472,1875,2400,24,0,0);   -- lapis_lazuli_ring
INSERT INTO `guild_shops` VALUES (60429,13473,1875,2400,24,0,0);   -- amber_ring
INSERT INTO `guild_shops` VALUES (60429,13474,1875,2400,24,0,0);   -- onyx_ring
INSERT INTO `guild_shops` VALUES (60429,13979,20088,20088,24,0,0); -- silver_bangles
-- INSERT INTO `guild_shops` VALUES (60429,13983,20088,20088,24,0,0); -- gold_bangles TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60429,12496,117,234,24,0,0);     -- copper_hairpin
INSERT INTO `guild_shops` VALUES (60429,12497,970,1190,24,0,0);    -- brass_hairpin
INSERT INTO `guild_shops` VALUES (60429,12495,4398,4398,24,0,0);   -- silver_hairpin
INSERT INTO `guild_shops` VALUES (60429,16391,2700,13989,24,0,0);  -- brass_knuckles
INSERT INTO `guild_shops` VALUES (60429,16407,2399,13554,24,0,0);  -- brass_baghnakhs
INSERT INTO `guild_shops` VALUES (60429,16449,3422,15656,24,0,0);  -- brass_dagger
INSERT INTO `guild_shops` VALUES (60429,16551,3631,15487,24,0,0);  -- sapara
-- INSERT INTO `guild_shops` VALUES (60429,16531,3631,15487,24,0,0);  -- brass_xiphos TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60429,16641,2870,13845,24,0,0);  -- brass_axe
INSERT INTO `guild_shops` VALUES (60429,16769,2245,13221,24,0,0);  -- brass_zaghnal
-- INSERT INTO `guild_shops` VALUES (60429,17081,3631,15487,24,0,0);  -- brass_rod TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60429,17043,1735,1839,24,0,0);   -- brass_hammer
INSERT INTO `guild_shops` VALUES (60429,12472,153,214,24,0,0);     -- circlet
-- INSERT INTO `guild_shops` VALUES (60429,12473,3631,15487,24,0,0);  -- poets_circlet TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60429,12449,1503,4300,24,0,0);   -- brass_cap
INSERT INTO `guild_shops` VALUES (60429,12433,18176,30208,24,0,0); -- brass_mask
INSERT INTO `guild_shops` VALUES (60429,12425,17100,43776,24,0,0); -- silver_mask
-- INSERT INTO `guild_shops` VALUES (60429,12577,3631,15487,24,0,0);  -- brass_harness TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60429,12561,14000,24000,24,0,0); -- brass_scale_mail
INSERT INTO `guild_shops` VALUES (60429,12705,1023,2620,24,0,0);   -- brass_mittens
-- INSERT INTO `guild_shops` VALUES (60429,12681,3631,15487,24,0,0);  -- silver_mittens TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60429,12689,11000,22000,24,0,0); -- brass_finger_gauntlets
INSERT INTO `guild_shops` VALUES (60429,12833,3840,7360,24,0,0);   -- brass_subligar
INSERT INTO `guild_shops` VALUES (60429,12961,2380,3720,24,0,0);   -- brass_leggings
-- INSERT INTO `guild_shops` VALUES (60429,12817,3631,15487,24,0,0);  -- brass_cuisses TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60429,12945,11440,11440,24,0,0); -- brass_greaves
INSERT INTO `guild_shops` VALUES (60429,13196,52284,52284,24,0,0); -- silver_belt
-- INSERT INTO `guild_shops` VALUES (60429,13209,3631,15487,24,0,0);  -- chain_belt TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60429,13083,3631,15487,24,0,0);  -- chain_choker TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60429,13082,3631,15487,24,0,0);  -- chain_gorget TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60429,2144,75,75,240,48,180);    -- workshop_anvil

-- Taten-Bilten (Clothcraft Guild) Al Zahbi
INSERT INTO `guild_shops` VALUES (60430,833,15,18,240,75,180);      -- clump_of_moko_grass
INSERT INTO `guild_shops` VALUES (60430,834,79,200,240,48,2);       -- ball_of_satura_cotton
INSERT INTO `guild_shops` VALUES (60430,835,187,1000,240,75,180);   -- flax_flower
INSERT INTO `guild_shops` VALUES (60430,832,675,4500,240,48,180);   -- clump_of_sheep_wool
INSERT INTO `guild_shops` VALUES (60430,839,173,870,240,48,60);     -- piece_of_crawler_cocoon
INSERT INTO `guild_shops` VALUES (60430,838,9438,34557,240,0,0);    -- spider_web
INSERT INTO `guild_shops` VALUES (60430,817,45,240,240,48,180);     -- spool_of_grass_thread
INSERT INTO `guild_shops` VALUES (60430,818,159,768,240,48,132);    -- spool_of_cotton_thread
INSERT INTO `guild_shops` VALUES (60430,819,750,790,240,48,102);    -- spool_of_linen_thread
INSERT INTO `guild_shops` VALUES (60430,2287,2700,17280,120,33,66); -- spool_of_karakul_thread
INSERT INTO `guild_shops` VALUES (60430,2173,405,748,120,48,66);    -- wamoura_cocoon
INSERT INTO `guild_shops` VALUES (60430,816,592,3865,30,1,8);       -- spool_of_silk_thread
INSERT INTO `guild_shops` VALUES (60430,822,1800,3400,30,1,6);      -- spool_of_silver_thread
INSERT INTO `guild_shops` VALUES (60430,823,13338,109440,10,0,5);   -- spool_of_gold_thread
-- INSERT INTO `guild_shops` VALUES (60430,821,13338,109440,10,0,0);   -- spool_of_rainbow_thread TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60430,824,240,1344,240,16,36);    -- square_of_grass_cloth
INSERT INTO `guild_shops` VALUES (60430,825,480,640,240,16,32);     -- sqaure_of_cotton_cloth
INSERT INTO `guild_shops` VALUES (60430,826,12840,12840,120,0,0);   -- square_of_linen_cloth
-- INSERT INTO `guild_shops` VALUES (60430,2288,12840,12840,120,0,0);  -- square_of_karakul_cloth TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60430,828,21851,31710,60,0,0);    -- square_of_velvet_cloth
INSERT INTO `guild_shops` VALUES (60430,829,35070,102480,240,0,0);  -- square_of_silk_cloth
-- INSERT INTO `guild_shops` VALUES (60430,830,21851,31710,240,0,0);   -- square_of_rainbow_cloth TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60430,2289,21851,31710,240,0,0);  -- square_of_wamoura_cloth TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60430,2148,815,989,240,0,0);      -- puk_wing
INSERT INTO `guild_shops` VALUES (60430,2149,815,989,240,0,0);      -- apkallu_feather
-- INSERT INTO `guild_shops` VALUES (60430,2150,815,989,240,0,0);      -- colibri_feather TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60430,842,815,989,240,0,0);       -- giant_bird_feather TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60430,12608,26,192,60,0,0);       -- tunic TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60430,12609,26,192,60,0,0);       -- black_tunic TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60430,12592,26,192,60,0,0);       -- doublet TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60430,12593,66992,66992,60,0,0);   -- cotton_doublet
INSERT INTO `guild_shops` VALUES (60430,13750,87178,87178,60,0,0);   -- linen_doublet
-- INSERT INTO `guild_shops` VALUES (60430,12594,87178,87178,60,0,0);   -- gambison TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60430,12595,87178,87178,60,0,0);   -- wool_gambison TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60430,12600,424,1171,60,0,0);      -- robe
INSERT INTO `guild_shops` VALUES (60430,12601,14684,14684,60,0,0);   -- linen_robe
-- INSERT INTO `guild_shops` VALUES (60430,12602,14684,14684,60,0,0);   -- wool_robe TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60430,12603,14684,14684,60,0,0);   -- velvet_robe TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60430,12610,14684,14684,60,0,0);   -- cloak TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60430,12976,1339,6486,60,0,0);     -- gaiters
-- INSERT INTO `guild_shops` VALUES (60430,12977,1339,6486,60,0,0);     -- cotton_gaiters TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60430,12978,1339,6486,60,0,0);     -- socks TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60430,12979,171776,171776,60,0,0); -- wool_socks
INSERT INTO `guild_shops` VALUES (60430,12720,2787,7393,60,0,0);     -- gloves
-- INSERT INTO `guild_shops` VALUES (60430,12721,2787,7393,60,0,0);     -- cotton_gloves TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60430,12722,2787,7393,60,0,0);     -- bracers TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60430,12723,2787,7393,60,0,0);     -- wool_bracers TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60430,12728,424,1171,60,0,0);      -- cuffs TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60430,12729,424,1171,60,0,0);      -- linen_cuffs TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60430,12730,424,1171,60,0,0);      -- wool_cuffs TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60430,12731,424,1171,60,0,0);      -- velvet_cuffs TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60430,12736,1290,3196,60,0,0);     -- mitts
-- INSERT INTO `guild_shops` VALUES (60430,12738,424,1171,60,0,0);      -- linen_mitts TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60430,12739,37862,172339,60,0,0);  -- black_mitts
INSERT INTO `guild_shops` VALUES (60430,12464,2710,7898,60,0,0);     -- headgear
INSERT INTO `guild_shops` VALUES (60430,12465,35315,38882,60,0,0);   -- cotton_headgear
-- INSERT INTO `guild_shops` VALUES (60430,12498,424,1171,60,0,0);      -- cotton_headband TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60430,12499,14160,78080,60,0,0);   -- flax_headband
-- INSERT INTO `guild_shops` VALUES (60430,13568,424,1171,60,0,0);      -- scarlet_ribbon TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60430,12466,23200,39400,60,0,0);   -- red_cap
-- INSERT INTO `guild_shops` VALUES (60430,12467,424,1171,60,0,0);      -- wool_cap TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60430,12474,424,1171,60,0,0);      -- wool_hat TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60430,12475,424,1171,60,0,0);      -- velvet_hat TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60430,12848,424,1171,60,0,0);      -- brais TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60430,12849,424,1171,60,0,0);      -- cotton_brais TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60430,12850,424,1171,60,0,0);      -- hose TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60430,12851,135936,228096,60,0,0); -- wool_hose
INSERT INTO `guild_shops` VALUES (60430,12856,372,936,60,0,0);       -- slops
-- INSERT INTO `guild_shops` VALUES (60430,12857,424,1171,60,0,0);      -- linen_slops TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60430,12858,424,1171,60,0,0);      -- wool_slops TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60430,12859,424,1171,60,0,0);      -- velvet_slops TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60430,12864,424,1171,60,0,0);      -- slacks TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60430,12866,424,1171,60,0,0);      -- linen_slacks TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60430,12865,424,1171,60,0,0);      -- black_slacks TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60430,13583,318,1683,60,0,0);      -- cape
INSERT INTO `guild_shops` VALUES (60430,13584,10321,40322,60,0,0);   -- cotton_cape
INSERT INTO `guild_shops` VALUES (60430,13577,15190,42134,60,0,0);   -- black_cape
-- INSERT INTO `guild_shops` VALUES (60430,13586,15190,42134,60,0,0);   -- red_cape TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60430,13075,15190,42134,60,0,0);   -- feather_collar TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60430,13085,918,4838,60,0,0);      -- hemp_gorget
-- INSERT INTO `guild_shops` VALUES (60430,13322,15190,42134,60,0,0);   -- wing_earring TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60430,2128,75,86,240,75,180);      -- spindle
INSERT INTO `guild_shops` VALUES (60430,2145,75,180,240,33,180);     -- spool_of_zephyr_thread

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
