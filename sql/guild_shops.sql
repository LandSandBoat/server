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

-- Chaupire (Northern San d'Oria) Woodworking Guild (S)
INSERT INTO `guild_shops` VALUES (5132,698,72,441,240,48,144);     -- ash_log
INSERT INTO `guild_shops` VALUES (5132,695,120,736,240,48,144);    -- willow_log
INSERT INTO `guild_shops` VALUES (5132,697,528,3243,180,48,108);   -- holly_log
INSERT INTO `guild_shops` VALUES (5132,696,330,2024,180,48,108);   -- yew_log
INSERT INTO `guild_shops` VALUES (5132,690,1378,10938,255,48,84);  -- elm_log
INSERT INTO `guild_shops` VALUES (5132,693,640,3928,60,48,36);     -- walnut_log
INSERT INTO `guild_shops` VALUES (5132,694,2119,12999,120,33,72);  -- chestnut_log
INSERT INTO `guild_shops` VALUES (5132,699,4740,29072,60,33,36);   -- oak_log
INSERT INTO `guild_shops` VALUES (5132,701,6615,40572,60,33,36);   -- rosewood_log
INSERT INTO `guild_shops` VALUES (5132,700,9075,34848,60,33,36);   -- mahogany_log
INSERT INTO `guild_shops` VALUES (5132,702,9600,45568,60,33,36);   -- ebony_log
INSERT INTO `guild_shops` VALUES (5132,704,96,673,240,100,36);     -- bamboo_stick
INSERT INTO `guild_shops` VALUES (5132,721,704,2465,240,0,0);      -- rattan_lumber
INSERT INTO `guild_shops` VALUES (5132,705,3,18,240,48,36);        -- arrowwood_lumber
INSERT INTO `guild_shops` VALUES (5132,706,27,165,240,48,36);      -- lauan_lumber
INSERT INTO `guild_shops` VALUES (5132,708,45,276,240,48,36);      -- maple_lumber
INSERT INTO `guild_shops` VALUES (5132,715,72,441,240,48,36);      -- ash_lumber
INSERT INTO `guild_shops` VALUES (5132,712,120,736,240,48,36);     -- willow_lumber
INSERT INTO `guild_shops` VALUES (5132,714,607,3726,180,48,27);    -- holly_lumber
INSERT INTO `guild_shops` VALUES (5132,713,330,2024,180,48,27);    -- yew_lumber
INSERT INTO `guild_shops` VALUES (5132,707,1723,10570,120,48,18);  -- elm_lumber
INSERT INTO `guild_shops` VALUES (5132,710,2119,12999,120,33,18);  -- chestnut_lumber
INSERT INTO `guild_shops` VALUES (5132,716,4740,26544,60,33,15);   -- oak_lumber
INSERT INTO `guild_shops` VALUES (5132,711,1015,3982,60,0,0);      -- walnut_lumber
-- INSERT INTO `guild_shops` VALUES (5132,718,41983,41983,60,0,0);    -- rosewood_lumber TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5132,717,41140,41140,60,0,0);    -- mahogany_lumber TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5132,719,23552,62464,60,0,0);    -- ebony_lumber
-- INSERT INTO `guild_shops` VALUES (5132,720,41140,41140,60,0,0);    -- ancient_lumber TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5132,12984,176,280,24,0,0);      -- ash_clogs
INSERT INTO `guild_shops` VALUES (5132,12985,1625,7605,24,0,0);    -- holly_clogs
INSERT INTO `guild_shops` VALUES (5132,12986,6885,40024,24,0,0);   -- chestnut_sabots
INSERT INTO `guild_shops` VALUES (5132,12987,38707,38707,24,0,0);  -- ebony_sabots
INSERT INTO `guild_shops` VALUES (5132,12289,88,537,30,0,0);       -- lauaun_shield
INSERT INTO `guild_shops` VALUES (5132,12290,847,1173,30,0,0);     -- maple_shield
-- INSERT INTO `guild_shops` VALUES (5132,12291,847,1173,30,0,0);     -- elm_shield TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5132,12292,847,1173,30,0,0);     -- mahogany_shield TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5132,12293,847,1173,30,0,0);     -- oak_shield TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5132,2,847,1173,12,0,0);         -- simple_bed TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5132,22,282,1639,12,0,0);        -- workbench
INSERT INTO `guild_shops` VALUES (5132,97,5508,13512,12,0,0);      -- book_holder
INSERT INTO `guild_shops` VALUES (5132,102,291,713,12,0,0);        -- flower_stand
-- INSERT INTO `guild_shops` VALUES (5132,21,847,1173,12,0,0);        -- desk TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5132,26,31500,137340,12,0,0);    -- tarutaru_desk
INSERT INTO `guild_shops` VALUES (5132,23,829,2035,12,0,0);        -- maple_table
INSERT INTO `guild_shops` VALUES (5132,92,738,3621,12,0,0);        -- tarutaru_stool
INSERT INTO `guild_shops` VALUES (5132,24,70200,408096,12,0,0);    -- oak_table
INSERT INTO `guild_shops` VALUES (5132,17348,11256,32592,60,0,0);  -- traversiere
INSERT INTO `guild_shops` VALUES (5132,3,295500,295500,60,0,0);    -- oak_bed
INSERT INTO `guild_shops` VALUES (5132,17345,69,163,60,0,0);       -- flute
INSERT INTO `guild_shops` VALUES (5132,17347,1028,5368,60,0,0);    -- piccolo
INSERT INTO `guild_shops` VALUES (5132,17353,37,94,60,0,0);        -- maple_harp
INSERT INTO `guild_shops` VALUES (5132,17354,1675,12200,60,0,0);   -- harp
INSERT INTO `guild_shops` VALUES (5132,17355,13400,79200,60,0,0);  -- rose_harp
INSERT INTO `guild_shops` VALUES (5132,17024,48,351,60,0,0);       -- ash_club
INSERT INTO `guild_shops` VALUES (5132,17025,1165,8282,60,0,0);    -- chestnut_club
INSERT INTO `guild_shops` VALUES (5132,17027,7525,22127,60,0,0);   -- oak_cudgel
INSERT INTO `guild_shops` VALUES (5132,17030,14766,81107,60,0,0);  -- great_club
INSERT INTO `guild_shops` VALUES (5132,17049,34,102,60,0,0);       -- maple_wand
INSERT INTO `guild_shops` VALUES (5132,17050,247,1406,60,0,0);     -- willow_wand
INSERT INTO `guild_shops` VALUES (5132,17051,1049,3038,60,0,0);    -- yew_wand
INSERT INTO `guild_shops` VALUES (5132,17052,3827,27189,60,0,0);   -- chestnut_wand
INSERT INTO `guild_shops` VALUES (5132,17053,20944,41289,60,0,0);  -- rose_wand
INSERT INTO `guild_shops` VALUES (5132,17152,41,214,60,0,0);       -- shortbow
INSERT INTO `guild_shops` VALUES (5132,17153,1039,2615,60,0,0);    -- self_bow
INSERT INTO `guild_shops` VALUES (5132,17155,5625,16875,60,0,0);   -- composite_bow
INSERT INTO `guild_shops` VALUES (5132,17156,82971,82971,60,0,0);  -- kaman
INSERT INTO `guild_shops` VALUES (5132,17160,870,969,60,0,0);      -- longbow
INSERT INTO `guild_shops` VALUES (5132,17154,15602,38649,60,0,0);  -- wrapped_bow
-- INSERT INTO `guild_shops` VALUES (5132,17161,15602,38649,60,0,0);  -- power_bow TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5132,17162,14614,42969,60,0,0);  -- great_bow
INSERT INTO `guild_shops` VALUES (5132,17163,28944,82080,60,0,0);  -- battle_bow
INSERT INTO `guild_shops` VALUES (5132,17164,57405,166219,60,0,0); -- war_bow
INSERT INTO `guild_shops` VALUES (5132,17088,46,261,60,0,0);       -- ash_staff
INSERT INTO `guild_shops` VALUES (5132,17089,424,1066,60,0,0);     -- holly_staff
INSERT INTO `guild_shops` VALUES (5132,17090,3371,7103,60,0,0);    -- elm_staff
INSERT INTO `guild_shops` VALUES (5132,17091,3371,7103,60,0,0);    -- oak_staff
INSERT INTO `guild_shops` VALUES (5132,17095,281,1932,60,0,0);     -- ash_pole
INSERT INTO `guild_shops` VALUES (5132,17096,3400,24161,60,0,0);   -- holly_pole
INSERT INTO `guild_shops` VALUES (5132,17097,22617,35932,60,0,0);  -- elm_pole
INSERT INTO `guild_shops` VALUES (5132,17098,29390,72633,60,0,0);  -- oak_pole
INSERT INTO `guild_shops` VALUES (5132,17424,7717,49980,60,0,0);   -- spiked_club
-- INSERT INTO `guild_shops` VALUES (5132,17523,7717,49980,60,0,0);   -- quarterstaff TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5132,16832,194,267,60,0,0);      -- harpoon
INSERT INTO `guild_shops` VALUES (5132,16833,809,4294,60,0,0);     -- bronze_spear
INSERT INTO `guild_shops` VALUES (5132,16834,6448,25376,60,0,0);   -- brass_spear
INSERT INTO `guild_shops` VALUES (5132,16835,27165,34750,60,0,0);  -- spear
-- INSERT INTO `guild_shops` VALUES (5132,16836,7717,49980,60,0,0);   -- halberd TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5132,16845,31314,34445,60,0,0);  -- lance
INSERT INTO `guild_shops` VALUES (5132,17216,187,354,60,0,0);      -- light_crossbow
-- INSERT INTO `guild_shops` VALUES (5132,17217,7717,49980,60,0,0);   -- crossbow TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5132,17218,10311,67100,60,0,0);  -- zamburak
INSERT INTO `guild_shops` VALUES (5132,17280,1172,5250,60,0,0);    -- boomerang
INSERT INTO `guild_shops` VALUES (5132,17318,6,18,240,48,50);      -- wooden_arrow
INSERT INTO `guild_shops` VALUES (5132,17320,7,26,240,0,0);        -- iron_arrow
INSERT INTO `guild_shops` VALUES (5132,17321,28,60,240,0,0);       -- silver_arrow

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

-- Mep Nhapopoluko (Bibiki Bay) Fishing Guild
INSERT INTO `guild_shops` VALUES (519,17388,766,1324,200,10,110);  -- fastwater_fishing_rod
INSERT INTO `guild_shops` VALUES (519,17382,7081,15398,200,5,110); -- single_hook_fishing_rod
INSERT INTO `guild_shops` VALUES (519,4399,1350,8784,200,33,150);  -- bluetail
INSERT INTO `guild_shops` VALUES (519,4485,2100,13888,200,6,150);  -- noble_lady
INSERT INTO `guild_shops` VALUES (519,4317,120,237,200,48,150);    -- trilobite
INSERT INTO `guild_shops` VALUES (519,4484,1350,8784,200,11,150);  -- shall_shell
INSERT INTO `guild_shops` VALUES (519,4385,115,775,200,48,150);    -- zafmlug_bass
INSERT INTO `guild_shops` VALUES (519,5121,2142,2856,200,48,150);  -- moorish_idol
INSERT INTO `guild_shops` VALUES (519,4314,300,600,200,48,150);    -- bibikibo
INSERT INTO `guild_shops` VALUES (519,4318,3375,4500,200,16,150);  -- bibiki_urchin
INSERT INTO `guild_shops` VALUES (519,624,24,172,200,48,150);      -- clump_of_pamtam_kelp
INSERT INTO `guild_shops` VALUES (519,4443,24,165,20,48,150);      -- cobalt_jellyfish

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

-- Maymunah (Bastok Mines) Alchemy Guild (S)
-- TODO: All items purchasable from Curio Moogle commented out pending research on price changes
-- INSERT INTO `guild_shops` VALUES (5262,913,192,360,240,0,0);        -- lump_of_beeswax TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5262,920,1084,5899,60,0,10);      -- malboro_vine
INSERT INTO `guild_shops` VALUES (5262,922,300,300,240,0,0);        -- bat_wing
INSERT INTO `guild_shops` VALUES (5262,925,1312,3952,240,0,0);      -- giant_stinger
INSERT INTO `guild_shops` VALUES (5262,928,1014,2554,120,0,0);      -- pinch_of_bomb_ash
INSERT INTO `guild_shops` VALUES (5262,1108,573,3213,120,48,52);    -- pinch_of_sulfur
-- INSERT INTO `guild_shops` VALUES (5262,937,573,3213,120,0,0);       -- block_of_animal_glue TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5262,951,90,350,240,48,68);       -- wijnruit
INSERT INTO `guild_shops` VALUES (5262,621,21,77,240,0,68);         -- pot_of_crying_mustard
INSERT INTO `guild_shops` VALUES (5262,622,36,220,240,48,68);       -- pinch_of_dried_marjoram
INSERT INTO `guild_shops` VALUES (5262,636,97,528,240,48,68);       -- sprig_of_chamomile
INSERT INTO `guild_shops` VALUES (5262,637,1640,4880,60,0,0);       -- vial_of_slime_oil
-- INSERT INTO `guild_shops` VALUES (5262,4165,900,5712,60,0,0);       -- pot_of_silent_oil
INSERT INTO `guild_shops` VALUES (5262,638,138,851,240,48,144);     -- sprig_of_sage
INSERT INTO `guild_shops` VALUES (5262,931,19520,19520,60,0,0);     -- cermet_chunk
INSERT INTO `guild_shops` VALUES (5262,4443,24,154,240,48,24);      -- cobalt_jellyfish
INSERT INTO `guild_shops` VALUES (5262,933,660,3168,240,33,42);     -- loop_of_glass_fiber
INSERT INTO `guild_shops` VALUES (5262,932,1020,1080,60,0,0);       -- loop_of_carbon_fiber
INSERT INTO `guild_shops` VALUES (5262,4509,9,58,60,0,0);           -- flask_of_distilled_water
-- INSERT INTO `guild_shops` VALUES (5262,4154,5250,13300,60,0,0);     -- flask_of_holy_water
INSERT INTO `guild_shops` VALUES (5262,943,534,1305,60,0,0);        -- pinch_of_poison_dust
-- INSERT INTO `guild_shops` VALUES (5262,4157,534,1177,60,0,0);       -- flask_of_poison_potion TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5262,4148,1200,1377,60,0,0);      -- antidote
-- INSERT INTO `guild_shops` VALUES (5262,4150,1945,9549,60,0,0);      -- flask_of_eye_drops
INSERT INTO `guild_shops` VALUES (5262,4162,5250,13300,60,0,0);     -- flask_of_silencing_potion
-- INSERT INTO `guild_shops` VALUES (5262,4151,880,2944,60,0,0);       -- flask_of_echo_drops
INSERT INTO `guild_shops` VALUES (5262,947,3360,21862,60,0,0);      -- jar_of_firesand
INSERT INTO `guild_shops` VALUES (5262,4171,750,2080,60,0,0);       -- flask_of_vitriol
INSERT INTO `guild_shops` VALUES (5262,929,1875,6900,60,0,0);       -- jar_of_black_ink
-- INSERT INTO `guild_shops` VALUES (5262,4166,750,2080,60,0,0);       -- flash of deoderizer
-- INSERT INTO `guild_shops` VALUES (5262,4112,682,728,60,0,0);        -- potion
-- INSERT INTO `guild_shops` VALUES (5262,4116,3375,7560,60,0,0);      -- hi-potion
-- INSERT INTO `guild_shops` VALUES (5262,4128,3624,17201,60,0,0);     -- ether
-- INSERT INTO `guild_shops` VALUES (5262,4164,1050,6832,60,0,0);      -- pinch_of_prism_powder
INSERT INTO `guild_shops` VALUES (5262,1109,930,4563,60,0,0);       -- artificial_lens
-- INSERT INTO `guild_shops` VALUES (5262,16600,930,4563,60,0,0);      -- wax_sword TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5262,16572,930,4563,60,0,0);      -- bee_spatha TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5262,16495,9906,9906,60,0,0);     -- silence_dagger
-- INSERT INTO `guild_shops` VALUES (5262,16429,9906,9906,60,0,0);     -- silence_baghnakhs TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5262,16588,9906,9906,60,0,0);     -- flame_claymore TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5262,16454,1904,1904,60,0,0);     -- blind_dagger
INSERT INTO `guild_shops` VALUES (5262,16471,519,3024,60,0,0);      -- blind_knife
-- INSERT INTO `guild_shops` VALUES (5262,16458,19148,19148,60,0,0);   -- poison_baselard TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5262,16472,19148,19148,60,0,0);   -- poison_knife TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5262,16496,19148,19148,60,0,0);   -- poison_dagger TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5262,16478,19148,19148,60,0,0);   -- poison_kukri
INSERT INTO `guild_shops` VALUES (5262,16387,10902,33886,60,0,0);   -- poison_cesti
-- INSERT INTO `guild_shops` VALUES (5262,16410,19148,19148,60,0,0);   -- poison_baghnakhs TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5262,16417,19148,19148,60,0,0);   -- poison_claws TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5262,16403,102009,102009,60,0,0); -- poison_katars
-- INSERT INTO `guild_shops` VALUES (5262,16543,19148,19148,60,0,0);   -- fire_sword TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5262,16564,19148,19148,60,0,0);   -- flame_blade TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5262,16522,19148,19148,60,0,0);   -- flame_degen TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5262,16709,19148,19148,60,0,0);   -- inferno_axe TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5262,16594,19148,19148,60,0,0);   -- inferno_sword TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5262,17605,19148,19148,60,0,0);   -- acid_dagger TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5262,16501,19148,19148,60,0,0);   -- acid_knife TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5262,16430,19148,19148,60,0,0);   -- acid_claws TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5262,16581,33368,167872,60,0,0);  -- holy_sword
-- INSERT INTO `guild_shops` VALUES (5262,16523,19148,19148,60,0,0);   -- holy_degen TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5262,17041,18000,24000,60,0,0);      -- holy_mace TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5262,17322,81,330,240,0,0);          -- fire_arrow
INSERT INTO `guild_shops` VALUES (5262,17323,81,330,240,0,0);          -- ice_arrow
INSERT INTO `guild_shops` VALUES (5262,17324,81,330,240,0,0);          -- lightning_arrow
-- INSERT INTO `guild_shops` VALUES (5262,17343,392,392,240,0,0);      -- bronze_bullet TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5262,17340,58,436,240,0,0);       -- bullet
INSERT INTO `guild_shops` VALUES (5262,17341,1745,2480,240,0,0);    -- silver_bullet
-- INSERT INTO `guild_shops` VALUES (5262,17313,392,392,240,0,0);      -- grenade TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5262,17315,392,392,240,0,0);      -- riot_grenade TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5262,18228,114,114,240,60,180);   -- battery
INSERT INTO `guild_shops` VALUES (5262,18232,114,114,240,60,180);   -- hydro_pump
INSERT INTO `guild_shops` VALUES (5262,18236,21,21,240,60,180);     -- wind_fan

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

-- Yabby Tanmikey (Goldsmith Guild) Mhaura (S)
INSERT INTO `guild_shops` VALUES (528,736,315,1260,200,48,100);  -- chunk_of_silver_ore
INSERT INTO `guild_shops` VALUES (528,644,1500,9800,200,0,0);    -- chunk_of_mythril_ore
-- INSERT INTO `guild_shops` VALUES (528,737,1500,9200,200,0,0);    -- chunk_of_gold_ore TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (528,738,6000,58032,200,0,0);   -- chunk_of_platinum_ore TODO: verify min_price and max_price
-- INSERT INTO `guild_shops` VALUES (528,648,6000,58032,200,0,0);   -- copper_ingot TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (528,650,6000,58032,200,0,0);   -- brass_ingot TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (528,744,4095,9996,200,0,0);    -- silver_ingot
INSERT INTO `guild_shops` VALUES (528,653,19900,36400,200,0,0);  -- mythril_ingot
-- INSERT INTO `guild_shops` VALUES (528,745,6000,58032,200,0,0);   -- gold_ingot TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (528,746,6000,58032,200,0,0);   -- platinum_ingot TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (528,661,1171,1171,200,0,0);    -- brass_sheet
INSERT INTO `guild_shops` VALUES (528,663,20240,45600,200,0,0);  -- mythril_sheet
-- INSERT INTO `guild_shops` VALUES (528,752,20240,45600,200,0,0);  -- gold_sheet TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (528,754,20240,45600,200,0,0);  -- platinum_sheet TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (528,673,210,1388,200,0,0);     -- brass_scales
INSERT INTO `guild_shops` VALUES (528,760,29172,74880,200,0,0);  -- silver_chain
INSERT INTO `guild_shops` VALUES (528,681,10500,67760,200,0,0);  -- mythril_chain
-- INSERT INTO `guild_shops` VALUES (528,761,10500,30800,200,0,0);  -- gold_chain TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (528,762,10500,30800,200,0,0);  -- platinum_chain TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (528,769,1400,4200,60,33,5);    -- red_rock
INSERT INTO `guild_shops` VALUES (528,770,1400,4200,60,33,5);    -- blue_rock
INSERT INTO `guild_shops` VALUES (528,771,1400,4200,60,33,5);    -- yellow_rock
INSERT INTO `guild_shops` VALUES (528,772,1400,4200,60,33,5);    -- green_rock
INSERT INTO `guild_shops` VALUES (528,773,1400,4200,60,33,5);    -- translucent_rock
INSERT INTO `guild_shops` VALUES (528,774,1400,4200,60,33,5);    -- purple_rock
INSERT INTO `guild_shops` VALUES (528,775,1400,4200,60,33,5);    -- black_rock
INSERT INTO `guild_shops` VALUES (528,776,1400,4200,60,33,5);    -- white_rock

-- Kueh Igunahmori (Leathercraft Guild) Southern San d'Oria (S)
INSERT INTO `guild_shops` VALUES (529,857,1290,4760,120,0,0);     -- dhalmel_hide
INSERT INTO `guild_shops` VALUES (529,858,483,2967,120,33,18);    -- wolf_hide
INSERT INTO `guild_shops` VALUES (529,859,937,4750,120,33,18);    -- ram_skin
INSERT INTO `guild_shops` VALUES (529,861,1312,6650,120,11,18);   -- black_tiger_hide
INSERT INTO `guild_shops` VALUES (529,863,2700,16560,120,11,18);  -- coeurl_hide
INSERT INTO `guild_shops` VALUES (529,1116,5000,44505,120,0,0);   -- manticore_hide
INSERT INTO `guild_shops` VALUES (529,850,390,736,120,0,0);       -- square_of_sheep_leather
INSERT INTO `guild_shops` VALUES (529,848,2912,4636,120,0,0);     -- square_of_dhalmel_leather
INSERT INTO `guild_shops` VALUES (529,851,2718,16235,60,0,0);     -- square_of_ram_leather
INSERT INTO `guild_shops` VALUES (529,855,3087,22855,120,0,0);    -- square_of_black_tiger_leather
INSERT INTO `guild_shops` VALUES (529,506,9600,11333,120,0,0);    -- square_of_coeurl_leather
INSERT INTO `guild_shops` VALUES (529,1117,8385,51428,60,0,0);    -- square_of_manticore_leather
INSERT INTO `guild_shops` VALUES (529,852,630,1586,60,0,0);       -- lizard_skin
INSERT INTO `guild_shops` VALUES (529,853,2155,13680,60,36,36);   -- raptor_skin
INSERT INTO `guild_shops` VALUES (529,854,2650,3304,60,33,36);    -- cockatrice_skin
INSERT INTO `guild_shops` VALUES (529,832,675,4500,240,0,0);      -- clump_of_sheep_wool
INSERT INTO `guild_shops` VALUES (529,695,120,736,240,48,180);    -- willow_log
INSERT INTO `guild_shops` VALUES (529,4509,9,58,240,75,180);      -- flask_of_distilled_water
INSERT INTO `guild_shops` VALUES (529,917,481,2039,60,0,0);       -- sheet_of_parchment
INSERT INTO `guild_shops` VALUES (529,13594,132,316,60,0,0);      -- rabbit_mantle
INSERT INTO `guild_shops` VALUES (529,13588,2484,14440,60,0,0);   -- dhalmel_mantle
INSERT INTO `guild_shops` VALUES (529,13571,6426,31530,60,0,0);   -- wolf_mantle
INSERT INTO `guild_shops` VALUES (529,13570,10800,25488,60,0,0);  -- ram_mantle
INSERT INTO `guild_shops` VALUES (529,13592,2065,9804,60,0,0);    -- lizard_mantle
INSERT INTO `guild_shops` VALUES (529,13593,24000,62080,60,0,0);  -- raptor_mantle
INSERT INTO `guild_shops` VALUES (529,13193,4590,12420,60,0,0);   -- lizard_belt
INSERT INTO `guild_shops` VALUES (529,13192,837,1224,60,0,0);     -- leather_belt
INSERT INTO `guild_shops` VALUES (529,13194,16896,20803,60,0,0);  -- warriors_belt
INSERT INTO `guild_shops` VALUES (529,13195,2277,5980,60,0,0);    -- magic_belt
INSERT INTO `guild_shops` VALUES (529,13203,2277,5980,60,0,0);    -- barbarians_belt
INSERT INTO `guild_shops` VALUES (529,13200,13860,35112,60,0,0);  -- waistbelt
INSERT INTO `guild_shops` VALUES (529,13081,211,1003,60,0,0);     -- leather_gorget
INSERT INTO `guild_shops` VALUES (529,13089,6384,15662,60,0,0);   -- wolf_gorget
INSERT INTO `guild_shops` VALUES (529,12568,987,1323,60,0,0);     -- leather_vest
INSERT INTO `guild_shops` VALUES (529,12569,5145,16189,60,0,0);   -- lizard_jerkin
INSERT INTO `guild_shops` VALUES (529,12570,44232,44916,60,0,0);  -- studded_vest
INSERT INTO `guild_shops` VALUES (529,13703,44100,108192,60,0,0); -- brigandine
INSERT INTO `guild_shops` VALUES (529,12571,32340,84946,60,0,0);  -- cuir_bouilli
INSERT INTO `guild_shops` VALUES (529,12572,44460,116781,60,0,0); -- raptor_jerkin
INSERT INTO `guild_shops` VALUES (529,12952,504,1639,60,0,0);     -- leather_highboots
-- INSERT INTO `guild_shops` VALUES (529,12954,15624,41039,60,0,0);  -- studded_boots TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (529,12955,15624,41039,60,0,0);  -- cuir_highboots
INSERT INTO `guild_shops` VALUES (529,12993,3366,8841,60,0,0);    -- sandals
INSERT INTO `guild_shops` VALUES (529,12994,11481,28273,60,0,0);  -- shoes
INSERT INTO `guild_shops` VALUES (529,12995,48960,76296,60,0,0);  -- moccasins
INSERT INTO `guild_shops` VALUES (529,12696,318,1612,60,0,0);     -- leather_gloves
INSERT INTO `guild_shops` VALUES (529,12697,2700,7092,60,0,0);    -- lizard_gloves
INSERT INTO `guild_shops` VALUES (529,12698,11610,53625,60,0,0);  -- studded_gloves
INSERT INTO `guild_shops` VALUES (529,12699,17052,44789,60,0,0);  -- cuir_gloves
INSERT INTO `guild_shops` VALUES (529,12700,29700,150480,60,0,0); -- raptor_gloves
INSERT INTO `guild_shops` VALUES (529,12440,330,880,60,0,0);      -- leather_bandana
INSERT INTO `guild_shops` VALUES (529,12441,3318,8407,60,0,0);    -- lizard_helm
INSERT INTO `guild_shops` VALUES (529,12442,8000,9000,60,0,0);    -- studded_bandana
INSERT INTO `guild_shops` VALUES (529,12443,8500,9300,60,0,0);    -- cuir_bandana
INSERT INTO `guild_shops` VALUES (529,12444,9200,10000,60,0,0);   -- raptor_helm
INSERT INTO `guild_shops` VALUES (529,12824,589,1639,60,0,0);     -- leather_trousers
INSERT INTO `guild_shops` VALUES (529,12825,5819,10714,60,0,0);   -- lizard_trousers
INSERT INTO `guild_shops` VALUES (529,12826,32002,36232,60,0,0);  -- studded_trousers
INSERT INTO `guild_shops` VALUES (529,12827,25200,66192,60,0,0);  -- cuir_trousers
INSERT INTO `guild_shops` VALUES (529,12828,42900,112684,60,0,0); -- raptor_trousers
INSERT INTO `guild_shops` VALUES (529,12992,453,1815,60,0,0);     -- solea
INSERT INTO `guild_shops` VALUES (529,12953,2578,16777,60,0,0);   -- lizard_ledelsens
INSERT INTO `guild_shops` VALUES (529,12956,58027,72811,60,0,0);  -- raptor_ledelsens
INSERT INTO `guild_shops` VALUES (529,16385,279,283,60,0,0);      -- cesti
INSERT INTO `guild_shops` VALUES (529,16386,945,5997,60,0,0);     -- lizard_cesti
INSERT INTO `guild_shops` VALUES (529,16388,11970,27700,60,0,0);  -- himantes
INSERT INTO `guild_shops` VALUES (529,13469,937,2087,60,0,0);     -- leather_ring
INSERT INTO `guild_shops` VALUES (529,12294,13500,14000,60,0,0);  -- leather_shield

-- Kopopo (Windurst Waters) Cooking Guild (S)
-- INSERT INTO `guild_shops` VALUES (530,631,200,200,240,0,0);        -- bag_of_horo_flour TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (530,611,30,60,240,48,144);       -- bag_of_rye_flour
INSERT INTO `guild_shops` VALUES (530,610,45,252,240,48,144);      -- bag_of_san_dorian_flour
INSERT INTO `guild_shops` VALUES (530,612,45,194,240,48,144);      -- bunch_of_kazham_peppers
INSERT INTO `guild_shops` VALUES (530,614,60,361,240,48,144);      -- bulb_of_mhaura_garlic
INSERT INTO `guild_shops` VALUES (530,4378,45,268,240,48,144);     -- selbina_milk
INSERT INTO `guild_shops` VALUES (530,615,45,292,120,0,0);         -- stick_of_selbina_butter
INSERT INTO `guild_shops` VALUES (530,616,60,368,240,48,18);       -- piece_of_pie_dough
INSERT INTO `guild_shops` VALUES (530,618,21,50,240,48,144);       -- pod_of_blue_peas
INSERT INTO `guild_shops` VALUES (530,619,36,42,240,48,144);       -- popoto
INSERT INTO `guild_shops` VALUES (530,620,45,276,240,48,144);      -- box_of_tarutaru_rice
INSERT INTO `guild_shops` VALUES (530,621,21,77,240,48,144);       -- pot_of_crying_mustard
INSERT INTO `guild_shops` VALUES (530,622,36,220,240,48,144);      -- pinch_of_dried_marjoram
INSERT INTO `guild_shops` VALUES (530,625,66,334,240,48,10);       -- bottle_of_apple_vinegar
INSERT INTO `guild_shops` VALUES (530,627,40,200,240,0,0);         -- pot_of_maple_sugar
INSERT INTO `guild_shops` VALUES (530,1111,450,2832,240,0,0);      -- block_of_gelatin
INSERT INTO `guild_shops` VALUES (530,628,195,572,240,48,108);     -- stick_of_cinnamon
INSERT INTO `guild_shops` VALUES (530,629,36,220,240,48,144);      -- ear_of_millioncorn
INSERT INTO `guild_shops` VALUES (530,4358,61,163,240,0,0);        -- slice_of_hare_meat
INSERT INTO `guild_shops` VALUES (530,4372,83,236,240,0,0);        -- slice_of_giant_sheep_meat
INSERT INTO `guild_shops` VALUES (530,4359,180,1200,240,0,0);      -- slice_of_dhalmel_meat
INSERT INTO `guild_shops` VALUES (530,4354,120,644,240,0,0);       -- shining_trout
INSERT INTO `guild_shops` VALUES (530,4360,24,160,240,0,0);        -- bastore_sardine
INSERT INTO `guild_shops` VALUES (530,4570,47,245,240,48,44);      -- bird_egg
INSERT INTO `guild_shops` VALUES (530,4363,33,200,240,48,48);      -- faerie_apple
INSERT INTO `guild_shops` VALUES (530,4365,192,600,240,0,0);       -- rolanberry
INSERT INTO `guild_shops` VALUES (530,4366,18,100,240,48,84);      -- la_theine_cabbage
INSERT INTO `guild_shops` VALUES (530,4571,75,460,240,48,84);      -- clump_of_beaugreens
INSERT INTO `guild_shops` VALUES (530,4367,36,238,240,48,4);       -- clump_of_batagreens
INSERT INTO `guild_shops` VALUES (530,4370,163,590,240,0,0);       -- pot_of_honey
INSERT INTO `guild_shops` VALUES (530,4380,437,1091,240,33,4);     -- smoked_salmon
INSERT INTO `guild_shops` VALUES (530,4382,58,160,240,0,0);        -- frost_turnip
INSERT INTO `guild_shops` VALUES (530,4383,864,5989,240,0,0);      -- gold_lobster
INSERT INTO `guild_shops` VALUES (530,4387,709,1934,240,0,0);      -- wild_onion
INSERT INTO `guild_shops` VALUES (530,4389,43,157,240,0,64);       -- san_dorian_carrot
INSERT INTO `guild_shops` VALUES (530,4390,51,198,240,48,64);      -- mithran_tomato
INSERT INTO `guild_shops` VALUES (530,4399,1350,8784,240,0,0);     -- bluetail
INSERT INTO `guild_shops` VALUES (530,4401,91,191,240,0,0);        -- moat carp
INSERT INTO `guild_shops` VALUES (530,4412,287,1547,240,33,16);    -- thundermelon
INSERT INTO `guild_shops` VALUES (530,4432,87,261,240,0,16);       -- kazham_pineaple
INSERT INTO `guild_shops` VALUES (530,4435,3520,3968,240,0,0);     -- slice_of_cockatrice_meat
INSERT INTO `guild_shops` VALUES (530,4444,18,45,240,0,0);         -- rarab_tail
INSERT INTO `guild_shops` VALUES (530,4445,41,88,240,0,0);         -- yagudo_cherry
INSERT INTO `guild_shops` VALUES (530,4468,60,384,240,33,16);      -- bunch_of_pamamas
INSERT INTO `guild_shops` VALUES (530,4472,30,238,240,0,0);        -- crayfish
INSERT INTO `guild_shops` VALUES (530,4482,300,1984,240,0,0);      -- nosteau_herring
INSERT INTO `guild_shops` VALUES (530,4483,195,1848,240,0,0);      -- tiger_cod
INSERT INTO `guild_shops` VALUES (530,4491,150,1040,240,33,16);    -- watermelon
INSERT INTO `guild_shops` VALUES (530,4356,154,992,240,0,4);       -- loaf_of_white_bread
INSERT INTO `guild_shops` VALUES (530,4364,102,576,240,0,8);       -- loaf_of_black_bread
INSERT INTO `guild_shops` VALUES (530,4499,75,320,241,0,0);        -- loaf_of_iron_bread
INSERT INTO `guild_shops` VALUES (530,4391,18,274,240,0,0);        -- bretzel
-- INSERT INTO `guild_shops` VALUES (530,4510,9,55,255,0,0);          -- acorn_cookie TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (530,4397,9,55,255,0,0);          -- cinna_cookie TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (530,4394,9,55,255,0,0);          -- ginger_cookie
INSERT INTO `guild_shops` VALUES (530,4413,240,1420,240,0,0);      -- apple_pie
INSERT INTO `guild_shops` VALUES (530,4563,6113,15360,240,0,0);    -- pamama_tart
INSERT INTO `guild_shops` VALUES (530,4556,10644,10644,240,0,0);   -- serving_of_icecap_rolanberry
INSERT INTO `guild_shops` VALUES (530,4371,252,853,240,0,0);       -- slice_of_grilled_hare
INSERT INTO `guild_shops` VALUES (530,4437,240,3024,240,0,0);      -- slice_of_roast_mutton
INSERT INTO `guild_shops` VALUES (530,4438,2750,7084,240,0,0);     -- slice_of_dhalmel_steak
INSERT INTO `guild_shops` VALUES (530,4376,90,288,240,0,0);        -- strip_of_meat_jerky
INSERT INTO `guild_shops` VALUES (530,4537,967,2600,240,0,0);      -- roast_carp
-- INSERT INTO `guild_shops` VALUES (530,4404,918,2600,240,0,0);      -- roast_trout TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (530,4538,1628,4232,240,0,0);     -- roast_pipira
-- INSERT INTO `guild_shops` VALUES (530,4459,918,8568,240,0,0);      -- nebimonite_bake TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (530,4457,4800,13920,240,0,0);    -- eel_kabob
INSERT INTO `guild_shops` VALUES (530,4408,105,560,240,0,0);       -- tortilla
INSERT INTO `guild_shops` VALUES (530,4456,1856,10620,240,0,0);    -- boiled_crab
INSERT INTO `guild_shops` VALUES (530,4409,72,371,240,0,0);        -- hard-boiled_egg
INSERT INTO `guild_shops` VALUES (530,4410,626,1962,240,0,0);      -- roast_mushroom
INSERT INTO `guild_shops` VALUES (530,4381,1382,3600,240,0,0);     -- meat_mithkabob
INSERT INTO `guild_shops` VALUES (530,4398,2149,3256,240,0,0);     -- fish_mithkabob
INSERT INTO `guild_shops` VALUES (530,4422,150,328,240,0,0);       -- bottle_of_orange_juice
INSERT INTO `guild_shops` VALUES (530,4423,225,876,240,0,1);       -- bottle_of_apple_juice
INSERT INTO `guild_shops` VALUES (530,4424,825,4488,240,0,0);      -- bottle_of_melon_juice
INSERT INTO `guild_shops` VALUES (530,4441,697,4650,240,0,0);      -- bottle_of_grape_juice
INSERT INTO `guild_shops` VALUES (530,4442,300,1504,240,0,0);      -- bottle_of_pineapple_juice
INSERT INTO `guild_shops` VALUES (530,4425,240,1446,240,0,0);      -- bottle_of_tomato_juice
INSERT INTO `guild_shops` VALUES (530,4156,3872,3936,240,0,0);     -- bottle_of_mulsum
INSERT INTO `guild_shops` VALUES (530,4406,734,1988,240,0,0);      -- baked_apple
INSERT INTO `guild_shops` VALUES (530,4415,93,565,240,0,0);        -- ear_of_roasted_corn
INSERT INTO `guild_shops` VALUES (530,4436,240,1113,240,0,0);      -- baked_popoto
INSERT INTO `guild_shops` VALUES (530,4490,955,2284,240,0,0);      -- pickled_herring
INSERT INTO `guild_shops` VALUES (530,4572,1360,7260,240,0,0);     -- serving_of_beaugreen_saute
INSERT INTO `guild_shops` VALUES (530,4492,1182,2845,240,0,0);     -- bowl_of_puls
-- INSERT INTO `guild_shops` VALUES (530,4489,1950,2845,240,0,0);     -- bowl_of_vegetable_gruel TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (530,4555,3701,3701,240,0,0);     -- windurst_salad TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (530,4455,968,984,240,0,0);       -- bowl_of_pebble_soup
INSERT INTO `guild_shops` VALUES (530,4416,2716,6944,240,0,0);     -- bowl_of_pea_soup
INSERT INTO `guild_shops` VALUES (530,4560,2861,2861,240,0,0);     -- bowl_of_vegetable_soup
INSERT INTO `guild_shops` VALUES (530,4419,12390,14000,240,0,0);   -- bowl_of_mushroom_soup
INSERT INTO `guild_shops` VALUES (530,4420,13124,13230,240,0,0);   -- bowl_of_tomato_soup
INSERT INTO `guild_shops` VALUES (530,4417,2475,15972,240,0,0);    -- bowl_of_egg_soup
INSERT INTO `guild_shops` VALUES (530,4355,1946,5515,240,0,0);     -- salmon_sub_sandwich
INSERT INTO `guild_shops` VALUES (530,1554,431,1522,120,48,40);    -- onz_of_turmeric
INSERT INTO `guild_shops` VALUES (530,1555,1061,5325,120,48,40);   -- onz_of_coriander
INSERT INTO `guild_shops` VALUES (530,1590,536,5836,60,48,19);     -- sprig_of_holy_basil
INSERT INTO `guild_shops` VALUES (530,1475,411,4985,240,0,0);      -- onz_of_curry_powder
INSERT INTO `guild_shops` VALUES (530,1840,1500,9200,240,48,84);   -- bag_of_semolina
INSERT INTO `guild_shops` VALUES (530,2110,457,610,200,48,150);    -- jar_of_fish_stock
INSERT INTO `guild_shops` VALUES (530,2111,525,700,200,48,150);    -- saucer_of_soy_stock
INSERT INTO `guild_shops` VALUES (530,2112,530,540,200,48,155);    -- stick_of_vanilla
INSERT INTO `guild_shops` VALUES (530,5684,1900,11661,240,12,144); -- wedge_of_chalaimbille

-- Doggomehr (Northern San d'Oria) Smithing Guild (S)
INSERT INTO `guild_shops` VALUES (531,641,30,66,240,48,180);       -- chunk_of_tin_ore
INSERT INTO `guild_shops` VALUES (531,643,675,3825,240,33,144);    -- chunk_of_iron_ore
INSERT INTO `guild_shops` VALUES (531,644,1500,9800,240,0,0);      -- chunk_of_mythril_ore
INSERT INTO `guild_shops` VALUES (531,1155,436,2400,240,0,0);      -- handful_of_iron_sand
INSERT INTO `guild_shops` VALUES (531,649,115,349,240,33,36);      -- bronze_ingot
INSERT INTO `guild_shops` VALUES (531,651,2700,13680,240,33,36);   -- iron_ingot
INSERT INTO `guild_shops` VALUES (531,652,3517,25620,60,0,0);      -- steel_ingot
INSERT INTO `guild_shops` VALUES (531,653,19900,36400,60,0,0);     -- mythril_ingot
INSERT INTO `guild_shops` VALUES (531,657,4690,30520,60,0,0);      -- lump_of_tama_hagane
INSERT INTO `guild_shops` VALUES (531,660,61,423,240,33,36);       -- bronze_sheet
INSERT INTO `guild_shops` VALUES (531,662,4050,20520,240,33,36);   -- iron_sheet
INSERT INTO `guild_shops` VALUES (531,666,14868,39984,60,0,0);     -- steel_sheet
INSERT INTO `guild_shops` VALUES (531,663,20240,45600,60,0,0);     -- mythril_sheet
-- INSERT INTO `guild_shops` VALUES (531,664,20240,45600,60,0,0);     -- darksteel_sheet TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (531,672,81,254,60,0,0);          -- handful_of_bronze_scales
INSERT INTO `guild_shops` VALUES (531,674,4945,30744,60,0,0);      -- handful_of_iron_scales
INSERT INTO `guild_shops` VALUES (531,676,7350,13720,60,0,0);      -- handful_of_steel_scales
INSERT INTO `guild_shops` VALUES (531,680,11781,12411,60,0,0);     -- iron_chain
-- INSERT INTO `guild_shops` VALUES (531,682,20240,45600,60,0,0);     -- darksteel_chain TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (531,16411,11746,21322,60,0,0);   -- claws
INSERT INTO `guild_shops` VALUES (531,16412,56544,56544,60,0,0);   -- mythril_claws
-- INSERT INTO `guild_shops` VALUES (531,16413,20240,45600,60,0,0);   -- darksteel_claws TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (531,16399,20240,45600,60,0,0);   -- katars TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (531,16448,240,761,60,0,0);       -- bronze_dagger
-- INSERT INTO `guild_shops` VALUES (531,16450,20240,45600,60,0,0);   -- dagger TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (531,16451,20240,45600,60,0,0);   -- mythril_dagger TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (531,16455,20240,45600,60,0,0);   -- baselard TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (531,16460,20240,45600,60,0,0);   -- kris TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (531,16530,1323,8853,60,0,0);     -- xiphos TODO: verify min_price and max_price
INSERT INTO `guild_shops` VALUES (531,16532,36503,36503,60,0,0);   -- gladius
INSERT INTO `guild_shops` VALUES (531,16535,509,1056,60,0,0);      -- bronze_sword
-- INSERT INTO `guild_shops` VALUES (531,16536,20240,45600,60,0,0);   -- iron_sword TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (531,16537,25800,32680,60,0,0);   -- mythril_sword
-- INSERT INTO `guild_shops` VALUES (531,16538,20240,45600,60,0,0);   -- darksteel_sword TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (531,16545,20240,45600,60,0,0);   -- broadsword TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (531,16565,1395,8853,60,0,0);     -- spatha
-- INSERT INTO `guild_shops` VALUES (531,16566,20240,45600,60,0,0);   -- longsword TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (531,16567,20240,45600,60,0,0);   -- knights_sword TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (531,16576,20240,45600,60,0,0);   -- hunting_sword TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (531,16524,20240,45600,60,0,0);   -- fleuret TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (531,16583,20240,45600,60,0,0);   -- claymore TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (531,16584,20240,45600,60,0,0);   -- mythril_claymore TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (531,16585,20240,45600,60,0,0);   -- darksteel_claymore TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (531,16589,10444,67958,60,0,0);   -- two_handed_sword
-- INSERT INTO `guild_shops` VALUES (531,16590,20240,45600,60,0,0);   -- greatsword TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (531,17059,20240,45600,60,0,0);   -- bronze_rod TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (531,17060,20240,45600,60,0,0);   -- rod TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (531,17061,20240,45600,60,0,0);   -- mythril_rod TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (531,16650,18270,36987,60,0,0);   -- war_pick
INSERT INTO `guild_shops` VALUES (531,16651,66555,168606,60,0,0);  -- mythril_pick
INSERT INTO `guild_shops` VALUES (531,17034,313,917,60,0,0);       -- bronze_mace
-- INSERT INTO `guild_shops` VALUES (531,17035,20240,45600,60,0,0);   -- mace TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (531,17036,20240,45600,60,0,0);   -- mythril_mace TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (531,16768,643,677,60,0,0);       -- bronze_zaghnal
INSERT INTO `guild_shops` VALUES (531,16770,16803,24703,60,0,0);   -- zaghnal
-- INSERT INTO `guild_shops` VALUES (531,16774,20240,45600,60,0,0);   -- scythe TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (531,16775,20240,45600,60,0,0);   -- mythril_scythe TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (531,12432,2711,2856,60,0,0);     -- faceguard
INSERT INTO `guild_shops` VALUES (531,12424,7695,26676,60,0,0);    -- iron_mask
INSERT INTO `guild_shops` VALUES (531,13871,27216,47355,60,0,0);   -- iron_visor
INSERT INTO `guild_shops` VALUES (531,13873,61107,70963,60,0,0);   -- steel_visor
INSERT INTO `guild_shops` VALUES (531,12688,1666,5664,60,0,0);     -- scale_finger_gauntlets
-- INSERT INTO `guild_shops` VALUES (531,12680,20240,45600,60,0,0);   -- chain_mittens TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (531,14001,42476,88529,60,0,0);   -- iron_finger_gauntlets
INSERT INTO `guild_shops` VALUES (531,14003,79745,84198,60,0,0);   -- steel_finger_gauntlets
INSERT INTO `guild_shops` VALUES (531,12944,1519,5294,60,0,0);     -- scale_greaves
-- INSERT INTO `guild_shops` VALUES (531,12936,20240,45600,60,0,0);   -- greaves TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (531,14118,20240,45600,60,0,0);   -- iron_greaves TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (531,14120,20240,45600,60,0,0);   -- steel_greaves TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (531,12816,2810,8735,60,0,0);     -- scale_cuisses TODO: verify min_price and max_price
-- INSERT INTO `guild_shops` VALUES (531,12808,20240,45600,60,0,0);   -- chain_hose TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (531,14243,20240,45600,60,0,0);   -- iron_cuisses TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (531,14245,52785,166096,60,0,0);  -- steel_cuisses
-- INSERT INTO `guild_shops` VALUES (531,12560,20240,45600,60,0,0);   -- scale_mail TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (531,12552,20240,45600,60,0,0);   -- chainmail TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (531,13783,81084,162345,60,0,0);  -- iron_scale_mail
-- INSERT INTO `guild_shops` VALUES (531,13785,20240,45600,60,0,0);   -- steel_scale_mail TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (531,12306,20240,45600,60,0,0);   -- kite_shield TODO: missing min_price and max_price

-- Kamilah (Mhaura) Smithing Guild (S)
INSERT INTO `guild_shops` VALUES (532,641,30,66,240,48,110);       -- chunk_of_tin_ore
INSERT INTO `guild_shops` VALUES (532,643,675,3825,240,33,110);    -- chunk_of_iron_ore
INSERT INTO `guild_shops` VALUES (532,649,115,349,120,0,0);        -- bronze_ingot
INSERT INTO `guild_shops` VALUES (532,651,2700,13680,120,0,0);     -- iron_ingot
INSERT INTO `guild_shops` VALUES (532,652,3517,25620,120,16,90);   -- steel_ingot
INSERT INTO `guild_shops` VALUES (532,660,61,423,120,33,36);       -- bronze_sheet
INSERT INTO `guild_shops` VALUES (532,662,4050,20520,120,0,0);     -- iron_sheet
INSERT INTO `guild_shops` VALUES (532,672,81,254,60,0,0);          -- handful_of_bronze_scales
INSERT INTO `guild_shops` VALUES (532,674,4945,30744,60,0,0);      -- handful_of_iron_scales
INSERT INTO `guild_shops` VALUES (532,680,11781,12411,60,0,0);     -- iron_chain
-- INSERT INTO `guild_shops` VALUES (532,12552,20240,45600,60,0,0);   -- chainmail TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (532,12560,20240,45600,60,0,0);   -- scale_mail TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (532,12578,61086,81086,60,0,0);   -- padded_armor
-- INSERT INTO `guild_shops` VALUES (532,12936,20240,45600,60,0,0);   -- greaves TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (532,12944,1519,5294,60,0,0);     -- scale_greaves
INSERT INTO `guild_shops` VALUES (532,12962,27866,76830,60,0,0);   -- leggings
-- INSERT INTO `guild_shops` VALUES (532,12680,20240,45600,60,0,0);   -- chain_mittens TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (532,12688,1666,5664,60,0,0);     -- scale_finger_gauntlets
INSERT INTO `guild_shops` VALUES (532,12706,21945,21945,60,0,0);  -- iron_mittens

-- Amulya (Metalworks) Smithing Guild (S)
INSERT INTO `guild_shops` VALUES (5332,641,30,66,240,48,180);       -- chunk_of_tin_ore
INSERT INTO `guild_shops` VALUES (5332,643,675,3825,240,33,180);    -- chunk_of_iron_ore
INSERT INTO `guild_shops` VALUES (5332,644,1500,9800,240,0,0);      -- chunk_of_mythril_ore
-- INSERT INTO `guild_shops` VALUES (5332,645,28272,28272,240,0,0);    -- chunk_of_darksteel_ore TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5332,649,115,349,240,33,36);      -- bronze_ingot
INSERT INTO `guild_shops` VALUES (5332,651,2700,13680,240,33,36);   -- iron_ingot
INSERT INTO `guild_shops` VALUES (5332,652,3517,25620,60,0,0);      -- steel_ingot
INSERT INTO `guild_shops` VALUES (5332,653,19900,36400,60,0,0);     -- mythril_ingot
-- INSERT INTO `guild_shops` VALUES (5332,654,19900,36400,60,0,0);     -- darksteel_ingot TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5332,660,61,423,240,33,36);       -- bronze_sheet
INSERT INTO `guild_shops` VALUES (5332,662,4050,20520,240,33,36);   -- iron_sheet
INSERT INTO `guild_shops` VALUES (5332,666,14868,39984,240,0,0);    -- steel_sheet
INSERT INTO `guild_shops` VALUES (5332,663,20240,45600,240,0,0);    -- mythril_sheet
INSERT INTO `guild_shops` VALUES (5332,664,66690,66690,240,0,0);    -- darksteel_sheet TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5332,672,81,254,60,0,0);          -- handful_of_bronze_scales
INSERT INTO `guild_shops` VALUES (5332,674,4945,30744,60,0,0);      -- handful_of_iron_scales
INSERT INTO `guild_shops` VALUES (5332,676,7350,13720,60,0,0);      -- handful_of_steel_scales
INSERT INTO `guild_shops` VALUES (5332,680,11781,12411,60,0,0);     -- iron_chain
-- INSERT INTO `guild_shops` VALUES (5332,682,20240,45600,60,0,0);     -- darksteel_chain TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5332,16390,439,1161,60,0,0);      -- bronze_knuckles
-- INSERT INTO `guild_shops` VALUES (5332,16392,439,1161,60,0,0);      -- metal_knuckles TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5332,16393,439,1161,60,0,0);      -- mythril_knuckles TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5332,16394,439,1161,60,0,0);      -- darksteel_knuckles TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5332,16406,10713,17020,60,0,0);   -- baghnakhs
INSERT INTO `guild_shops` VALUES (5332,16419,34320,76416,60,0,0);   -- patas
INSERT INTO `guild_shops` VALUES (5332,16465,229,754,60,0,0);       -- bronze_knife
-- INSERT INTO `guild_shops` VALUES (5332,16466,439,1161,60,0,0);      -- knife TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5332,16467,22422,22422,60,0,0);   -- mythril_knife
-- INSERT INTO `guild_shops` VALUES (5332,16468,439,1161,60,0,0);      -- darksteel_knife TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5332,16473,439,1161,60,0,0);      -- kukri TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5332,16475,439,1161,60,0,0);      -- mythril_kukri TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5332,16552,8914,8914,60,0,0);     -- scimitar
-- INSERT INTO `guild_shops` VALUES (5332,16553,439,1161,60,0,0);      -- tulwar TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5332,16558,51000,81600,60,0,0);   -- falchion
-- INSERT INTO `guild_shops` VALUES (5332,16559,439,1161,60,0,0);      -- darksteel_falchion TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5332,16512,439,1161,60,0,0);      -- bilbo TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5332,16513,62834,62834,60,0,0);   -- tuck TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5332,16517,62834,62834,60,0,0);   -- degen TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5332,16519,62834,62834,60,0,0);   -- schlaeger TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5332,16640,290,2898,60,0,0);      -- bronze_axe
-- INSERT INTO `guild_shops` VALUES (5332,16643,62834,62834,60,0,0);   -- battleaxe TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5332,16644,62834,62834,60,0,0);   -- mythril_axe TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5332,16657,95040,314160,60,0,0);  -- tabar
INSERT INTO `guild_shops` VALUES (5332,16704,1323,3565,60,0,0);     -- butterfly_axe
-- INSERT INTO `guild_shops` VALUES (5332,16705,62834,62834,60,0,0);   -- greataxe TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5332,16706,30912,90783,60,0,0);   -- heavy_axe
-- INSERT INTO `guild_shops` VALUES (5332,17042,290,2898,60,0,0);      -- bronze_hammer TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (5332,17044,290,2898,60,0,0);      -- war_hammer TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5332,17045,11970,29366,60,0,0);   -- maul
-- INSERT INTO `guild_shops` VALUES (5332,17248,62834,62834,60,0,0);   -- arquebus TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5332,12960,222,573,60,0,0);       -- bronze_leggings
INSERT INTO `guild_shops` VALUES (5332,12962,27866,76830,60,0,0);   -- leggings
INSERT INTO `guild_shops` VALUES (5332,12928,34927,45144,60,0,0);   -- plate_leggings
-- INSERT INTO `guild_shops` VALUES (5332,12448,290,705,60,0,0);       -- bronze_cap TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5332,12450,15300,15300,60,0,0);   -- padded_cap
INSERT INTO `guild_shops` VALUES (5332,12832,409,818,60,0,0);       -- bronze_subligar
INSERT INTO `guild_shops` VALUES (5332,12836,19008,38565,60,0,0);   -- iron_subligar
INSERT INTO `guild_shops` VALUES (5332,12800,34020,69552,60,0,0);   -- cuisses
INSERT INTO `guild_shops` VALUES (5332,12704,191,394,60,0,0);       -- bronze_mittens
INSERT INTO `guild_shops` VALUES (5332,12706,12960,12960,60,0,0);   -- iron_mittens
INSERT INTO `guild_shops` VALUES (5332,12672,19440,23328,60,0,0);   -- gauntlets
-- INSERT INTO `guild_shops` VALUES (5332,12576,290,1249,60,0,0);      -- bronze_harness TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5332,12578,61086,81086,60,0,0);   -- padded_armor
INSERT INTO `guild_shops` VALUES (5332,12544,36855,83538,60,0,0);   -- breastplate
INSERT INTO `guild_shops` VALUES (5332,13080,13770,14412,60,0,0);   -- gorget
INSERT INTO `guild_shops` VALUES (5332,12299,708,2835,60,0,0);      -- aspis
INSERT INTO `guild_shops` VALUES (5332,11872,59731,62834,60,0,0);   -- targe
-- INSERT INTO `guild_shops` VALUES (5332,12323,62834,62834,60,0,0);   -- scutum TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (5332,17336,4,11,240,0,0);         -- crossbow_bolt
INSERT INTO `guild_shops` VALUES (5332,17337,4,11,240,0,0);         -- mythril_bolt
INSERT INTO `guild_shops` VALUES (5332,17298,38,38,240,0,0);      -- tathlum TODO: missing min_price and max_price

-- Beugungel (Carpenter's Landing) Woodworking Guild
INSERT INTO `guild_shops` VALUES (534,1657,75,255,240,48,180);  -- bundling_twine
INSERT INTO `guild_shops` VALUES (534,1021,312,500,200,48,180); -- hatchet
INSERT INTO `guild_shops` VALUES (534,688,15,30,200,48,180);    -- arrowwood_log
INSERT INTO `guild_shops` VALUES (534,698,72,441,200,48,180);   -- ash_log
INSERT INTO `guild_shops` VALUES (534,696,330,2024,200,48,150); -- yew_log
INSERT INTO `guild_shops` VALUES (534,695,120,736,200,48,150);  -- willow_log
INSERT INTO `guild_shops` VALUES (534,693,640,3928,240,48,180); -- walnut_log

-- Akamafula (Lower Jeuno) Tenshodo Merchent -- TODO: Audit and update Akamafula.lua. Converted from a guild merchant to a standard shop as of April 2018.
INSERT INTO `guild_shops` VALUES (60417,16896,517,884,20,10,20);     -- kunai
INSERT INTO `guild_shops` VALUES (60417,16900,1404,2160,20,7,15);    -- wakizashi
INSERT INTO `guild_shops` VALUES (60417,16960,3121,3575,20,5,10);    -- uchigatana
-- INSERT INTO `guild_shops` VALUES (60417,16974,224510,697840,60,0,0); -- dotanuki TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60417,16975,11583,19800,20,5,10);  -- kanesada
INSERT INTO `guild_shops` VALUES (60417,16966,1836,2103,20,10,20);   -- tachi
INSERT INTO `guild_shops` VALUES (60417,16982,4752,15760,20,0,10);   -- nodachi
INSERT INTO `guild_shops` VALUES (60417,16987,12253,14033,20,5,10);  -- okanehira
INSERT INTO `guild_shops` VALUES (60417,17265,14428,35251,20,5,10);  -- tanegashima
INSERT INTO `guild_shops` VALUES (60417,17301,29,87,2970,594,1188);  -- shuriken
INSERT INTO `guild_shops` VALUES (60417,12456,552,858,20,10,20);     -- hachimaki
INSERT INTO `guild_shops` VALUES (60417,12457,3272,5079,20,7,15);    -- cotton_hachimaki
INSERT INTO `guild_shops` VALUES (60417,12458,8972,13927,20,5,10);   -- soil_hachimaki
INSERT INTO `guild_shops` VALUES (60417,13111,20061,29942,20,5,10);  -- nodowa
INSERT INTO `guild_shops` VALUES (60417,12584,833,1294,20,10,20);    -- kenpogi
INSERT INTO `guild_shops` VALUES (60417,12585,4931,7654,20,7,15);    -- cotton_dogi
INSERT INTO `guild_shops` VALUES (60417,12586,13266,17820,20,5,10);  -- soil_gi
INSERT INTO `guild_shops` VALUES (60417,12712,458,712,20,10,20);     -- tekko
INSERT INTO `guild_shops` VALUES (60417,12713,2713,4212,20,7,15);    -- cotton_tekko
INSERT INTO `guild_shops` VALUES (60417,12714,2713,9979,20,5,10);    -- soil_tekko
INSERT INTO `guild_shops` VALUES (60417,12840,666,1034,20,10,20);    -- sitabaki
INSERT INTO `guild_shops` VALUES (60417,12841,2713,6133,20,7,15);    -- cotton_sitabaki
INSERT INTO `guild_shops` VALUES (60417,12842,10805,14515,20,5,10);  -- soil_sitabaki
INSERT INTO `guild_shops` VALUES (60417,12968,424,660,20,10,20);     -- kyahan
INSERT INTO `guild_shops` VALUES (60417,12969,2528,3924,20,7,15);    -- cotton_kyahan
INSERT INTO `guild_shops` VALUES (60417,12970,11071,12393,20,5,10);  -- soil_kyahan

-- Blabbivix (Port Bastok) / Gaudylox (Northern San dOria) / Scavnix (Windurst Walls) (Chip Vendors pseudo guild shop)
INSERT INTO `guild_shops` VALUES (60418,474,21000,84000,200,50,150); -- Red Chip
INSERT INTO `guild_shops` VALUES (60418,475,21000,84000,200,50,150); -- Blue Chip
INSERT INTO `guild_shops` VALUES (60418,476,21000,84000,200,50,150); -- Yellow Chip
INSERT INTO `guild_shops` VALUES (60418,477,21000,84000,200,50,150); -- Green Chip
INSERT INTO `guild_shops` VALUES (60418,478,21000,84000,200,50,150); -- Clear Chip
INSERT INTO `guild_shops` VALUES (60418,479,21000,84000,200,50,150); -- Purple Chip
INSERT INTO `guild_shops` VALUES (60418,480,21000,84000,200,50,150); -- White Chip
INSERT INTO `guild_shops` VALUES (60418,481,21000,84000,200,50,150); -- Black Chip

-- Jabbar (Port Bastok) Tenshodo Merchant
INSERT INTO `guild_shops` VALUES (60419,704,96,673,60,48,50);        -- bamboo_stick
INSERT INTO `guild_shops` VALUES (60419,915,2700,16120,60,0,0);      -- jar_of_toad_oil
INSERT INTO `guild_shops` VALUES (60419,1134,810,5140,60,0,0);       -- sheet_of_bast_parchment
INSERT INTO `guild_shops` VALUES (60419,829,35070,102480,60,0,0);    -- square_of_silk_cloth
INSERT INTO `guild_shops` VALUES (60419,657,4690,30520,60,33,15);    -- lump_of_tama_hagane
INSERT INTO `guild_shops` VALUES (60419,1161,30,187,60,0,0);         -- uchitake
INSERT INTO `guild_shops` VALUES (60419,1164,30,187,60,0,0);         -- tsurara
INSERT INTO `guild_shops` VALUES (60419,1167,30,187,60,0,0);         -- kawahori_ogi
INSERT INTO `guild_shops` VALUES (60419,1170,30,187,60,0,0);         -- makibishi
INSERT INTO `guild_shops` VALUES (60419,1173,30,187,60,0,0);         -- hiraishin
INSERT INTO `guild_shops` VALUES (60419,1176,30,187,60,0,0);         -- mizu_deppo
-- INSERT INTO `guild_shops` VALUES (60419,1179,66,174,60,0,0);         -- shihei TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60419,1182,66,174,60,0,0);         -- jusatsu TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60419,1185,66,174,60,0,0);         -- kaginawa TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60419,1188,66,174,60,0,0);         -- sairui_ran TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60419,1191,66,174,60,0,0);         -- kodoku TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60419,1194,66,174,60,0,0);         -- shinobi_tabi TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60419,4928,1561,6713,60,5,19);     -- scroll_of_katon_ichi
INSERT INTO `guild_shops` VALUES (60419,4931,1561,6713,60,0,0);      -- scroll_of_hyoton_ichi
INSERT INTO `guild_shops` VALUES (60419,4934,1561,6713,60,5,19);     -- scroll_of_huton_ichi
INSERT INTO `guild_shops` VALUES (60419,4937,1561,6713,60,5,19);     -- scroll_of_doton_ichi
INSERT INTO `guild_shops` VALUES (60419,4940,1561,6713,60,0,0);      -- scroll_of_raiton_ichi
INSERT INTO `guild_shops` VALUES (60419,4943,1561,6713,60,5,19);     -- scroll_of_suiton_ichi
-- INSERT INTO `guild_shops` VALUES (60419,4946,8972,13927,60,0,0);     -- scroll_of_utsusemi_ichi TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60419,4949,8972,13927,60,0,0);     -- scroll_of_jubaku_ichi TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60419,4952,8972,13927,60,0,0);     -- scroll_of_hojo_ichi TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60419,4955,8972,13927,60,0,0);     -- scroll_of_kurayami_ichi TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60419,4958,8972,13927,60,0,0);     -- scroll_of_dokumori_ichi TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60419,4961,8972,13927,60,0,0);     -- scroll_of_tonko_ichi TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60419,4874,14070,102480,60,0,0);   -- scroll_of_absorb_str
INSERT INTO `guild_shops` VALUES (60419,4875,14070,102480,60,0,0);   -- scroll_of_absorb_dex
INSERT INTO `guild_shops` VALUES (60419,4876,14070,102480,60,0,0);   -- scroll_of_absorb_vit
INSERT INTO `guild_shops` VALUES (60419,4877,14070,102480,60,0,0);   -- scroll_of_absorb_agi
INSERT INTO `guild_shops` VALUES (60419,4878,14070,102480,60,0,0);   -- scroll_of_absorb_int
INSERT INTO `guild_shops` VALUES (60419,4879,14070,102480,60,5,18);  -- scroll_of_absorb_mnd
INSERT INTO `guild_shops` VALUES (60419,4880,14070,102480,60,5,18);  -- scroll_of_absorb_chr
INSERT INTO `guild_shops` VALUES (60419,1554,431,1522,60,48,50);     -- onz_of_turmeric
INSERT INTO `guild_shops` VALUES (60419,1555,1061,5325,60,48,50);    -- onz_of_coriander
INSERT INTO `guild_shops` VALUES (60419,1590,536,5836,60,48,50);     -- sprig_of_holy_basil
INSERT INTO `guild_shops` VALUES (60419,1475,411,4985,30,7,25);      -- onz_of_curry_powder
INSERT INTO `guild_shops` VALUES (60419,5164,1945,10899,150,20,110); -- jar_of_ground_wasabi
INSERT INTO `guild_shops` VALUES (60419,1652,150,704,150,48,110);    -- bottle_of_rice_vinegar
INSERT INTO `guild_shops` VALUES (60419,5236,198,525,150,48,120);    -- clump_of_shungiku
-- INSERT INTO `guild_shops` VALUES (60419,4964,8972,13927,60,0,0);     -- scroll_of_monomi_ichi TODO: missing min_price and max_price

-- Silver Owl (Port Bastok) Tenshodo Merchant
-- INSERT INTO `guild_shops` VALUES (60420,16405,104,225,30,0,0);       -- cat_baghnakhs TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60420,16407,14428,35251,30,0,0);   -- brass_baghnakhs TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60420,16406,14428,35251,30,0,0);   -- baghnakhs
INSERT INTO `guild_shops` VALUES (60420,16411,11746,46986,30,0,0);   -- claws
-- INSERT INTO `guild_shops` VALUES (60420,16412,14428,35251,30,0,0);   -- mythril_claws TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60420,16413,14428,35251,30,0,0);   -- darksteel_claws TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60420,16419,45760,168396,30,0,0);  -- patas
-- INSERT INTO `guild_shops` VALUES (60420,16420,14428,35251,30,0,0);   -- bone_patas TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60420,16421,14428,35251,30,0,0);   -- gold_patas TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60420,16896,517,884,30,10,25);     -- kunai
INSERT INTO `guild_shops` VALUES (60420,16917,4226,4840,30,0,0);     -- suzume
-- INSERT INTO `guild_shops` VALUES (60420,16915,14428,35251,30,0,0);     -- hien TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60420,16897,14428,35251,30,0,0);     -- kageboshi TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60420,16900,1404,2160,30,0,0);     -- wakizashi
INSERT INTO `guild_shops` VALUES (60420,16919,2728,17167,30,7,25);   -- shinobi_gatana
-- INSERT INTO `guild_shops` VALUES (60420,16901,14428,35251,30,0,0);   -- kodachi TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60420,16913,14428,35251,30,0,0);   -- shinogi TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60420,16902,14428,35251,30,0,0);   -- sakurafubuki TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60420,16924,14428,35251,30,0,0);   -- hocho TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60420,16903,14428,35251,30,0,0);   -- kabutowari TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60420,16960,3121,3575,30,0,0);     -- uchigatana
-- INSERT INTO `guild_shops` VALUES (60420,16974,224510,697840,30,0,0); -- dotanuki TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60420,16975,11583,19800,30,5,25);  -- kanesada
-- INSERT INTO `guild_shops` VALUES (60420,16962,14428,35251,30,0,0);   -- ashura TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60420,16966,1836,2103,30,5,25);    -- tachi
INSERT INTO `guild_shops` VALUES (60420,16982,4752,15760,30,0,0);    -- nodachi
-- INSERT INTO `guild_shops` VALUES (60420,16984,14428,35251,30,0,0);    -- jindachi TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60420,16987,12253,14033,30,0,0);   -- okanehira
INSERT INTO `guild_shops` VALUES (60420,16988,14676,62218,30,7,15);  -- kotetsu
-- INSERT INTO `guild_shops` VALUES (60420,16973,14428,35251,30,0,0);   -- homura TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60420,16967,14428,35251,30,0,0);   -- mikazuki TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60420,16990,14428,35251,30,0,0);   -- daihannya TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60420,16991,14428,35251,30,0,0);   -- odenta TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60420,16970,14428,35251,30,0,0);   -- hosodachi TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60420,17802,189945,464059,30,0,0); -- kiku_ichimonji
-- INSERT INTO `guild_shops` VALUES (60420,16964,14428,35251,30,0,0);   -- zanbato TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60420,16972,14428,35251,30,0,0);   -- kazaridachi TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60420,16871,183516,404395,30,0,0); -- kamayari
-- INSERT INTO `guild_shops` VALUES (60420,16841,14428,35251,30,0,0);   -- wyvern_spear TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60420,17259,72144,158976,30,0,0);  -- pirates_gun
INSERT INTO `guild_shops` VALUES (60420,17265,14428,35251,30,0,0);   -- tanegashima
-- INSERT INTO `guild_shops` VALUES (60420,17267,14428,35251,30,0,0);   -- negoroshiki TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60420,17301,29,184,30,0,0);        -- shuriken
INSERT INTO `guild_shops` VALUES (60420,17302,90,1190,30,0,0);       -- juji_shuriken
INSERT INTO `guild_shops` VALUES (60420,17303,7333,10120,30,0,0);    -- manji_shuriken
INSERT INTO `guild_shops` VALUES (60420,17304,1472,57960,30,0,0);    -- fuma_shuriken TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60420,17309,14428,35251,30,0,0);   -- pinwheel TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60420,17284,14428,35251,30,0,0);   -- chakram TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60420,17285,101745,220248,30,0,0); -- moonring_blade
INSERT INTO `guild_shops` VALUES (60420,17314,3926,7446,30,0,0);     -- quake_grenade
INSERT INTO `guild_shops` VALUES (60420,17320,7,26,30,0,0);          -- iron_arrow
INSERT INTO `guild_shops` VALUES (60420,17322,81,330,30,0,0);        -- fire_arrow
INSERT INTO `guild_shops` VALUES (60420,17340,58,436,30,0,0);        -- bullet
INSERT INTO `guild_shops` VALUES (60420,12456,552,858,30,10,19);     -- hachimaki
INSERT INTO `guild_shops` VALUES (60420,12457,3272,5079,30,7,19);    -- cotton_hachimaki
INSERT INTO `guild_shops` VALUES (60420,12458,8972,13927,30,0,0);    -- soil_hachimaki
-- INSERT INTO `guild_shops` VALUES (60420,12460,8972,13927,30,0,0);    -- shinobi_hachigane TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60420,12459,8972,13927,30,0,0);    -- zunari_kabuto TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60420,13111,20061,29942,30,0,0);   -- nodowa
INSERT INTO `guild_shops` VALUES (60420,13088,43890,52440,30,0,0);   -- darksteel_nodowa
INSERT INTO `guild_shops` VALUES (60420,12584,833,1294,30,10,19);    -- kenpogi
INSERT INTO `guild_shops` VALUES (60420,12585,4931,7654,30,7,19);    -- cotton_dogi
-- INSERT INTO `guild_shops` VALUES (60420,13728,8972,13927,30,0,0);    -- jujitsu_gi TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60420,12586,13266,17820,30,0,0);   -- soil_gi
-- INSERT INTO `guild_shops` VALUES (60420,12588,8972,13927,30,0,0);    -- shinobi_gi TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60420,12587,8972,13927,30,0,0);    -- hara_ate TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60420,12712,458,712,30,10,19);     -- tekko
INSERT INTO `guild_shops` VALUES (60420,12713,2713,4212,30,7,19);    -- cotton_tekko
INSERT INTO `guild_shops` VALUES (60420,12714,2713,9979,30,0,0);     -- soil_tekko
-- INSERT INTO `guild_shops` VALUES (60420,12716,8972,13927,30,0,0);    -- shinobi_tekko TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60420,12715,8972,13927,30,0,0);    -- kote TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60420,12840,666,1034,30,10,19);    -- sitabaki
INSERT INTO `guild_shops` VALUES (60420,12841,3951,6133,30,10,19);   -- cotton_sitabaki
INSERT INTO `guild_shops` VALUES (60420,12842,10805,14515,30,0,0);   -- soil_sitabaki
-- INSERT INTO `guild_shops` VALUES (60420,12844,8972,13927,30,0,0);    -- shinobi_hakama TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60420,12843,8972,13927,30,0,0);    -- haidate TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60420,12968,424,660,30,10,19);     -- kyahan
INSERT INTO `guild_shops` VALUES (60420,12969,2528,3924,30,7,19);    -- cotton_kyahan
INSERT INTO `guild_shops` VALUES (60420,12970,11071,14871,30,0,0);   -- soil_kyahan
-- INSERT INTO `guild_shops` VALUES (60420,13204,8972,13927,30,0,0);    -- heko_obi TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60420,13205,8972,13927,30,0,0);    -- silver_obi TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60420,13206,8972,13927,30,0,0);    -- gold_obi TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60420,13207,8972,13927,30,0,0);    -- brocade_obi TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60420,13208,8972,13927,30,0,0);    -- rainbow_obi TODO: missing min_price and max_price

-- Achika (Norg) Tenshodo Merchant
INSERT INTO `guild_shops` VALUES (60421,12456,552,858,60,10,36);    -- hachimaki
INSERT INTO `guild_shops` VALUES (60421,12457,3272,5079,60,7,36);   -- cotton_hachimaki
INSERT INTO `guild_shops` VALUES (60421,12458,8972,13927,60,5,36);  -- soil_hachimaki
-- INSERT INTO `guild_shops` VALUES (60421,12460,8972,13927,60,0,0);   -- shinobi_hachigane TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60421,12459,8972,13927,60,0,0);   -- zunari_kabuto TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60421,13111,20061,29942,60,5,36); -- nodowa
INSERT INTO `guild_shops` VALUES (60421,13088,43890,52440,60,0,0);  -- darksteel_nodowa
INSERT INTO `guild_shops` VALUES (60421,12584,833,1294,60,10,36);   -- kenpogi
INSERT INTO `guild_shops` VALUES (60421,12585,4931,7654,60,7,36);   -- cotton_dogi
-- INSERT INTO `guild_shops` VALUES (60421,13728,8972,13927,60,0,0);   -- jujitsu_gi TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60421,12586,13266,17820,60,5,36); -- soil_gi
-- INSERT INTO `guild_shops` VALUES (60421,12588,8972,13927,60,0,0);   -- shinobi_gi TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60421,12587,8972,13927,60,0,0);   -- hara_ate TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60421,12712,458,712,60,10,36);    -- tekko
INSERT INTO `guild_shops` VALUES (60421,12713,2713,4212,60,7,36);   -- cotton_tekko
INSERT INTO `guild_shops` VALUES (60421,12714,2713,9979,60,5,36);   -- soil_tekko
-- INSERT INTO `guild_shops` VALUES (60421,12716,8972,13927,60,0,0);   -- shinobi_tekko TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60421,12715,8972,13927,60,0,0);   -- kote TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60421,12840,666,1034,60,10,36);   -- sitabaki
INSERT INTO `guild_shops` VALUES (60421,12841,3951,6133,60,7,36);   -- cotton_sitabaki
INSERT INTO `guild_shops` VALUES (60421,12842,10805,14515,60,5,36); -- soil_sitabaki
-- INSERT INTO `guild_shops` VALUES (60421,12844,8972,13927,60,0,0);   -- shinobi_hakama TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60421,12843,8972,13927,60,0,0);   -- haidate TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60421,12968,424,660,60,10,36);    -- kyahan
INSERT INTO `guild_shops` VALUES (60421,12969,2528,3924,60,7,36);   -- cotton_kyahan
INSERT INTO `guild_shops` VALUES (60421,12970,11071,14871,60,5,36); -- soil_kyahan
-- INSERT INTO `guild_shops` VALUES (60421,13204,8972,13927,60,0,0);   -- heko_obi TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60421,13205,8972,13927,60,0,0);   -- silver_obi TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60421,13206,8972,13927,60,0,0);   -- gold_obi TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60421,13207,8972,13927,60,0,0);   -- brocade_obi TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60421,13208,8972,13927,60,0,0);   -- rainbow_obi TODO: missing min_price and max_price

-- Chiyo (Norg) Tenshodo Merchant
INSERT INTO `guild_shops` VALUES (60422,4874,14070,102480,60,0,0);  -- scroll_of_absorb_str
INSERT INTO `guild_shops` VALUES (60422,4875,14070,102480,60,0,0);  -- scroll_of_absorb_dex
INSERT INTO `guild_shops` VALUES (60422,4876,14070,102480,60,0,0);  -- scroll_of_absorb_vit
INSERT INTO `guild_shops` VALUES (60422,4877,14070,102480,60,0,0);  -- scroll_of_absorb_agi
INSERT INTO `guild_shops` VALUES (60422,4878,14070,102480,60,0,0);  -- scroll_of_absorb_int
INSERT INTO `guild_shops` VALUES (60422,4879,14070,102480,60,5,30); -- scroll_of_absorb_mnd
INSERT INTO `guild_shops` VALUES (60422,4880,14070,102480,60,5,30); -- scroll_of_absorb_chr
INSERT INTO `guild_shops` VALUES (60422,4928,1561,6713,60,5,30);    -- scroll_of_katon_ichi
INSERT INTO `guild_shops` VALUES (60422,4931,1561,6713,60,5,30);    -- scroll_of_hyoton_ichi
INSERT INTO `guild_shops` VALUES (60422,4934,1561,6713,60,5,30);    -- scroll_of_huton_ichi
INSERT INTO `guild_shops` VALUES (60422,4937,1561,6713,60,5,30);    -- scroll_of_doton_ichi
INSERT INTO `guild_shops` VALUES (60422,4940,1561,6713,60,5,30);    -- scroll_of_raiton_ichi
INSERT INTO `guild_shops` VALUES (60422,4943,1561,6713,60,5,30);    -- scroll_of_suiton_ichi
-- INSERT INTO `guild_shops` VALUES (60422,4946,8972,13927,60,0,0);    -- scroll_of_utsusemi_ichi TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60422,4949,8972,13927,60,0,0);    -- scroll_of_jubaku_ichi TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60422,4952,8972,13927,60,0,0);    -- scroll_of_hojo_ichi TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60422,4955,8972,13927,60,0,0);    -- scroll_of_kurayami_ichi TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60422,4958,8972,13927,60,0,0);    -- scroll_of_dokumori_ichi TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60422,4961,8972,13927,60,0,0);    -- scroll_of_tonko_ichi TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60422,4964,8972,13927,60,0,0);    -- scroll_of_monomi_ichi TODO: missing min_price and max_price

-- Jirokichi (Norg) Tenshodo Merchant
-- INSERT INTO `guild_shops` VALUES (60423,16405,104,225,60,0,0);        -- cat_baghnakhs TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60423,16407,14428,35251,60,0,0);    -- brass_baghnakhs TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60423,16406,14428,35251,60,5,10);   -- baghnakhs
INSERT INTO `guild_shops` VALUES (60423,16411,11746,46986,60,5,10);   -- claws
-- INSERT INTO `guild_shops` VALUES (60423,16412,14428,35251,60,0,0);    -- mythril_claws TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60423,16413,14428,35251,60,0,0);    -- darksteel_claws TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60423,16419,45760,168396,60,5,10);  -- patas
-- INSERT INTO `guild_shops` VALUES (60423,16420,14428,35251,60,0,0);    -- bone_patas TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60423,16421,14428,35251,60,0,0);    -- gold_patas TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60423,16896,517,884,60,10,50);      -- kunai
INSERT INTO `guild_shops` VALUES (60423,16917,4226,4840,60,7,50);     -- suzume
-- INSERT INTO `guild_shops` VALUES (60423,16915,14428,35251,60,0,0);    -- hien TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60423,16897,14428,35251,60,0,0);    -- kageboshi TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60423,16900,1404,2160,60,7,50);     -- wakizashi
INSERT INTO `guild_shops` VALUES (60423,16919,2728,17167,60,7,50);    -- shinobi_gatana
-- INSERT INTO `guild_shops` VALUES (60423,16901,14428,35251,60,0,0);    -- kodachi TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60423,16913,14428,35251,60,0,0);    -- shinogi TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60423,16902,14428,35251,60,0,0);    -- sakurafubuki TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60423,16924,14428,35251,60,0,0);    -- hocho TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60423,16903,14428,35251,60,0,0);    -- kabutowari TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60423,16960,3121,3575,60,7,50);     -- uchigatana
-- INSERT INTO `guild_shops` VALUES (60423,16974,224510,697840,60,0,0);  -- dotanuki TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60423,16975,11583,19800,60,5,30);   -- kanesada
-- INSERT INTO `guild_shops` VALUES (60423,16962,14428,35251,60,0,0);    -- ashura TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60423,16966,1836,2103,60,10,50);    -- tachi
INSERT INTO `guild_shops` VALUES (60423,16982,4752,15760,60,5,20);    -- nodachi
-- INSERT INTO `guild_shops` VALUES (60423,16984,14428,35251,60,0,0);    -- jindachi TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60423,16987,12253,14033,60,5,19);   -- okanehira
INSERT INTO `guild_shops` VALUES (60423,16988,14676,62218,60,5,19);   -- kotetsu
-- INSERT INTO `guild_shops` VALUES (60423,16973,14428,35251,60,0,0);    -- homura TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60423,16967,14428,35251,60,0,0);    -- mikazuki TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60423,16990,14428,35251,60,0,0);    -- daihannya TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60423,16991,14428,35251,60,0,0);    -- odenta TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60423,16970,14428,35251,60,0,0);    -- hosodachi TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60423,17802,189945,464059,60,2,10); -- kiku_ichimonji
-- INSERT INTO `guild_shops` VALUES (60423,16964,14428,35251,60,0,0);    -- zanbato TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60423,16972,14428,35251,60,0,0);    -- kazaridachi TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60423,16871,183516,404395,60,2,10); -- kamayari
-- INSERT INTO `guild_shops` VALUES (60423,16841,14428,35251,60,0,0);    -- wyvern_spear TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60423,17259,72144,158976,60,5,10);  -- pirates_gun
INSERT INTO `guild_shops` VALUES (60423,17265,14428,35251,60,0,0);    -- tanegashima
-- INSERT INTO `guild_shops` VALUES (60423,17267,14428,35251,60,0,0);    -- negoroshiki TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60423,17301,29,184,60,10,40);       -- shuriken
INSERT INTO `guild_shops` VALUES (60423,17302,52,1190,60,10,30);      -- juji_shuriken
INSERT INTO `guild_shops` VALUES (60423,17303,7333,10120,60,0,0);     -- manji_shuriken
INSERT INTO `guild_shops` VALUES (60423,17304,1472,57960,60,0,0);     -- fuma_shuriken TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60423,17309,14428,35251,60,0,0);    -- pinwheel TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60423,17284,14428,35251,60,0,0);    -- chakram TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60423,17285,101745,220248,60,0,0);  -- moonring_blade
INSERT INTO `guild_shops` VALUES (60423,17314,3926,7446,60,0,0);      -- quake_grenade
INSERT INTO `guild_shops` VALUES (60423,17320,7,26,60,10,20);         -- iron_arrow
INSERT INTO `guild_shops` VALUES (60423,17322,81,330,60,10,20);       -- fire_arrow
INSERT INTO `guild_shops` VALUES (60423,17340,58,436,60,10,10);       -- bullet

-- Vuliaie (Norg) Tenshodo Merchant
INSERT INTO `guild_shops` VALUES (60424,704,96,673,240,75,50);       -- bamboo_stick
INSERT INTO `guild_shops` VALUES (60424,915,2700,16120,60,33,18);    -- jar_of_toad_oil
INSERT INTO `guild_shops` VALUES (60424,1134,810,5140,60,48,10);     -- sheet_of_bast_parchment
INSERT INTO `guild_shops` VALUES (60424,829,35070,102480,60,0,0);    -- square_of_silk_cloth
INSERT INTO `guild_shops` VALUES (60424,1155,436,2400,240,33,190);   -- handful_of_iron_sand
INSERT INTO `guild_shops` VALUES (60424,657,4690,30520,120,33,80);   -- lump_of_tama_hagane
INSERT INTO `guild_shops` VALUES (60424,1415,55147,232354,60,33,16); -- pot_of_urushi
INSERT INTO `guild_shops` VALUES (60424,1161,30,187,240,10,80);      -- uchitake
INSERT INTO `guild_shops` VALUES (60424,1164,30,187,240,10,80);      -- tsurara
INSERT INTO `guild_shops` VALUES (60424,1167,30,187,240,10,80);      -- kawahori_ogi
INSERT INTO `guild_shops` VALUES (60424,1170,30,187,240,10,80);      -- makibishi
INSERT INTO `guild_shops` VALUES (60424,1173,30,187,240,10,80);      -- hiraishin
INSERT INTO `guild_shops` VALUES (60424,1176,30,187,240,10,80);      -- mizu_deppo
-- INSERT INTO `guild_shops` VALUES (60424,1179,66,174,60,0,0);      -- shihei TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60424,1182,66,174,60,0,0);      -- jusatsu TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60424,1185,66,174,60,0,0);      -- kaginawa TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60424,1188,66,174,60,0,0);      -- sairui_ran TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60424,1191,66,174,60,0,0);      -- kodoku TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60424,1194,66,174,60,0,0);      -- shinobi_tabi TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60424,1472,369,1476,200,48,150);   -- gardenia_seed
INSERT INTO `guild_shops` VALUES (60424,1554,431,1522,240,48,170);   -- onz_of_turmeric
INSERT INTO `guild_shops` VALUES (60424,1555,1061,5325,240,48,170);  -- onz_of_coriander
INSERT INTO `guild_shops` VALUES (60424,1590,536,5836,240,48,170);   -- sprig_of_holy_basil
INSERT INTO `guild_shops` VALUES (60424,1475,411,4985,120,48,110);   -- onz_of_curry_powder
INSERT INTO `guild_shops` VALUES (60424,5164,1945,10899,200,48,150); -- jar_of_ground_wasabi
INSERT INTO `guild_shops` VALUES (60424,1652,150,704,200,48,150);    -- bottle_of_rice_vinegar
INSERT INTO `guild_shops` VALUES (60424,5235,187,1350,200,48,150);   -- head_of_napa

-- Wahraga / Gathweeda (Alchemy Guild) Aht Urhgan Whitegate
INSERT INTO `guild_shops` VALUES (60425,912,192,360,240,0,0);        -- beehive_chip
-- INSERT INTO `guild_shops` VALUES (60425,913,192,360,240,0,0);        -- lump_of_beeswax TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60425,914,1125,7295,60,33,10);     -- vial_of_mercury
INSERT INTO `guild_shops` VALUES (60425,920,1084,5899,60,35,10);     -- malboro_vine
INSERT INTO `guild_shops` VALUES (60425,922,300,300,240,0,0);        -- bat_wing
INSERT INTO `guild_shops` VALUES (60425,925,1312,3952,240,0,0);      -- giant_stinger
INSERT INTO `guild_shops` VALUES (60425,928,1014,2554,120,0,0);      -- pinch_of_bomb_ash
INSERT INTO `guild_shops` VALUES (60425,1108,573,3213,120,48,52);    -- pinch_of_sulfur
-- INSERT INTO `guild_shops` VALUES (60425,937,573,3213,120,0,0);       -- block_of_animal_glue TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60425,951,90,350,240,48,68);       -- wijnruit
INSERT INTO `guild_shops` VALUES (60425,621,21,77,240,48,68);        -- pot_of_crying_mustard
INSERT INTO `guild_shops` VALUES (60425,622,36,220,240,48,68);       -- pinch_of_dried_marjoram
INSERT INTO `guild_shops` VALUES (60425,636,97,528,240,48,68);       -- sprig_of_chamomile
INSERT INTO `guild_shops` VALUES (60425,637,1640,4880,60,0,0);       -- vial_of_slime_oil
-- INSERT INTO `guild_shops` VALUES (60425,4165,900,5712,60,0,0);       -- pot_of_silent_oil TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60425,638,138,851,240,48,68);      -- sprig_of_sage
INSERT INTO `guild_shops` VALUES (60425,931,19520,19520,60,0,0);     -- cermet_chunk
INSERT INTO `guild_shops` VALUES (60425,4443,24,154,240,48,24);      -- cobalt_jellyfish
INSERT INTO `guild_shops` VALUES (60425,933,660,3168,240,33,42);     -- loop_of_glass_fiber
INSERT INTO `guild_shops` VALUES (60425,932,1020,1080,60,0,0);       -- loop_of_carbon_fiber
INSERT INTO `guild_shops` VALUES (60425,4509,9,58,60,0,0);           -- flask_of_distilled_water
-- INSERT INTO `guild_shops` VALUES (60425,4154,5250,13300,60,0,0);     -- flask_of_holy_water TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60425,943,534,1305,60,0,0);        -- pinch_of_poison_dust
-- INSERT INTO `guild_shops` VALUES (60425,4157,534,1177,60,0,0);       -- flask_of_poison_potion TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60425,4148,1200,1377,60,0,0);      -- antidote TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60425,4150,1945,9549,60,0,0);      -- flask_of_eye_drops TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60425,4162,5250,13300,60,0,0);     -- flask_of_silencing_potion
-- INSERT INTO `guild_shops` VALUES (60425,4151,880,2944,60,0,0);       -- flask_of_echo_drops TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60425,947,3360,21862,60,0,0);      -- jar_of_firesand
INSERT INTO `guild_shops` VALUES (60425,4171,750,2080,60,0,0);       -- flask_of_vitriol
INSERT INTO `guild_shops` VALUES (60425,929,1875,6900,60,0,0);       -- jar_of_black_ink
-- INSERT INTO `guild_shops` VALUES (60425,4166,750,2080,60,0,0);       -- flash of deoderizer TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60425,4112,682,728,60,0,0);        -- potion TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60425,4116,3375,7560,60,0,0);      -- hi-potion TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60425,4128,3624,17201,60,0,0);     -- ether TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60425,4164,1050,6832,60,0,0);      -- pinch_of_prism_powder TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60425,1109,930,4563,60,0,0);       -- artificial_lens
-- INSERT INTO `guild_shops` VALUES (60425,2163,75,242,60,0,0);         -- imp_wing TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60425,2164,75,242,60,0,0);         -- pephredo_hive_chip TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60425,2171,937,4250,60,0,0);       -- colibri_beak
INSERT INTO `guild_shops` VALUES (60425,2175,532,683,60,0,0);        -- chunk_of_flan_meat
INSERT INTO `guild_shops` VALUES (60425,2229,1080,3744,60,0,0);      -- vial_of_chimera_blood
-- INSERT INTO `guild_shops` VALUES (60425,16600,930,4563,60,0,0);      -- wax_sword TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60425,16572,930,4563,60,0,0);      -- bee_spatha TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60425,16495,9906,9906,60,0,0);     -- silence_dagger
-- INSERT INTO `guild_shops` VALUES (60425,16429,9906,9906,60,0,0);     -- silence_baghnakhs TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60425,16588,9906,9906,60,0,0);     -- flame_claymore TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60425,16454,1904,1904,60,0,0);     -- blind_dagger
INSERT INTO `guild_shops` VALUES (60425,16471,519,3024,60,0,0);      -- blind_knife
-- INSERT INTO `guild_shops` VALUES (60425,16458,19148,19148,60,0,0);   -- poison_baselard TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60425,16472,19148,19148,60,0,0);   -- poison_knife TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60425,16496,19148,19148,60,0,0);   -- poison_dagger TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60425,16478,19148,19148,60,0,0);   -- poison_kukri
INSERT INTO `guild_shops` VALUES (60425,16387,10902,33886,60,0,0);   -- poison_cesti
-- INSERT INTO `guild_shops` VALUES (60425,16410,19148,19148,60,0,0);   -- poison_baghnakhs TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60425,16417,19148,19148,60,0,0);   -- poison_claws TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60425,16403,102009,102009,60,0,0); -- poison_katars
-- INSERT INTO `guild_shops` VALUES (60425,16543,19148,19148,60,0,0);   -- fire_sword TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60425,16564,19148,19148,60,0,0);   -- flame_blade TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60425,16522,19148,19148,60,0,0);   -- flame_degen TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60425,16709,19148,19148,60,0,0);   -- inferno_axe TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60425,16594,19148,19148,60,0,0);   -- inferno_sword TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60425,17605,19148,19148,60,0,0);   -- acid_dagger TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60425,16501,19148,19148,60,0,0);   -- acid_knife TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60425,16430,19148,19148,60,0,0);   -- acid_claws TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60425,16581,33368,167872,60,0,0);  -- holy_sword
-- INSERT INTO `guild_shops` VALUES (60425,16523,19148,19148,60,0,0);   -- holy_degen TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60425,17041,18000,24000,60,0,0);      -- holy_mace TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60425,17322,81,330,240,0,0);          -- fire_arrow
INSERT INTO `guild_shops` VALUES (60425,17323,81,330,240,0,0);          -- ice_arrow
INSERT INTO `guild_shops` VALUES (60425,17324,81,330,240,0,0);          -- lightning_arrow
-- INSERT INTO `guild_shops` VALUES (60425,17343,392,392,240,0,0);      -- bronze_bullet TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60425,17340,58,436,240,0,0);       -- bullet
INSERT INTO `guild_shops` VALUES (60425,17341,1745,2480,240,0,0);    -- silver_bullet
-- INSERT INTO `guild_shops` VALUES (60425,17313,392,392,240,0,0);      -- grenade TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60425,17315,392,392,240,0,0);      -- riot_grenade TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60425,2131,75,242,240,48,180);     -- triturator
INSERT INTO `guild_shops` VALUES (60425,2309,963,963,240,16,180);    -- bundle_of_homunculus_nerves
INSERT INTO `guild_shops` VALUES (60425,2316,6,9,240,48,180);        -- sheet_of_polyflan paper
INSERT INTO `guild_shops` VALUES (60425,18228,114,114,240,60,180);   -- battery
INSERT INTO `guild_shops` VALUES (60425,18232,114,114,240,60,180);   -- hydro_pump
INSERT INTO `guild_shops` VALUES (60425,18236,21,21,240,60,180);     -- wind_fan
-- INSERT INTO `guild_shops` VALUES (60425,2459,68062,435600,240,6,24); -- pinch_of_minium TODO: verify that min_price and max_price is correct

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

-- Ndego (Smithing Guild) Al Zahbi
INSERT INTO `guild_shops` VALUES (60427,640,9,36,240,48,180);        -- chunk_of_copper_ore
INSERT INTO `guild_shops` VALUES (60427,641,30,66,240,48,180);       -- chunk_of_tin_ore
INSERT INTO `guild_shops` VALUES (60427,643,675,3825,240,33,180);    -- chunk_of_iron_ore
INSERT INTO `guild_shops` VALUES (60427,644,1500,9800,240,0,0);      -- chunk_of_mythril_ore
INSERT INTO `guild_shops` VALUES (60427,1155,436,2400,240,0,0);      -- handful_of_iron_sand
INSERT INTO `guild_shops` VALUES (60427,649,115,349,240,33,36);      -- bronze_ingot
INSERT INTO `guild_shops` VALUES (60427,651,2700,13680,240,33,36);   -- iron_ingot
INSERT INTO `guild_shops` VALUES (60427,652,3517,25620,60,0,0);      -- steel_ingot
INSERT INTO `guild_shops` VALUES (60427,653,19900,36400,60,0,0);     -- mythril_ingot
INSERT INTO `guild_shops` VALUES (60427,657,4690,30520,60,0,0);      -- lump_of_tama_hagane
INSERT INTO `guild_shops` VALUES (60427,660,61,423,240,33,36);       -- bronze_sheet
INSERT INTO `guild_shops` VALUES (60427,662,4050,20520,240,33,36);   -- iron_sheet
INSERT INTO `guild_shops` VALUES (60427,666,14868,39984,60,0,0);     -- steel_sheet
INSERT INTO `guild_shops` VALUES (60427,663,20240,45600,60,0,0);     -- mythril_sheet
-- INSERT INTO `guild_shops` VALUES (60427,664,20240,45600,60,0,0);     -- darksteel_sheet TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60427,672,81,254,60,0,0);          -- handful_of_bronze_scales
INSERT INTO `guild_shops` VALUES (60427,674,4945,30744,60,0,0);      -- handful_of_iron_scales
INSERT INTO `guild_shops` VALUES (60427,676,7350,13720,60,0,0);      -- handful_of_steel_scales
INSERT INTO `guild_shops` VALUES (60427,680,11781,12411,60,0,0);     -- iron_chain
-- INSERT INTO `guild_shops` VALUES (60427,682,20240,45600,60,0,0);     -- darksteel_chain TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60427,16411,11746,21322,60,0,0);   -- claws
INSERT INTO `guild_shops` VALUES (60427,16412,56544,56544,60,0,0);   -- mythril_claws
-- INSERT INTO `guild_shops` VALUES (60427,16413,20240,45600,60,0,0);   -- darksteel_claws TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60427,16399,20240,45600,60,0,0);   -- katars TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60427,16448,240,761,60,0,0);       -- bronze_dagger
-- INSERT INTO `guild_shops` VALUES (60427,16450,20240,45600,60,0,0);   -- dagger TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60427,16451,20240,45600,60,0,0);   -- mythril_dagger TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60427,16455,20240,45600,60,0,0);   -- baselard TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60427,16460,20240,45600,60,0,0);   -- kris TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60427,16530,1323,8853,60,0,0);     -- xiphos TODO: verify min_price and max_price
INSERT INTO `guild_shops` VALUES (60427,16532,36503,36503,60,0,0);   -- gladius
INSERT INTO `guild_shops` VALUES (60427,16535,509,1056,60,0,0);      -- bronze_sword
-- INSERT INTO `guild_shops` VALUES (60427,16536,20240,45600,60,0,0);   -- iron_sword TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60427,16537,25800,32680,60,0,0);   -- mythril_sword
-- INSERT INTO `guild_shops` VALUES (60427,16538,20240,45600,60,0,0);   -- darksteel_sword TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60427,16545,20240,45600,60,0,0);   -- broadsword TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60427,16565,1395,8853,60,0,0);     -- spatha
-- INSERT INTO `guild_shops` VALUES (60427,16566,20240,45600,60,0,0);   -- longsword TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60427,16567,20240,45600,60,0,0);   -- knights_sword TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60427,16576,20240,45600,60,0,0);   -- hunting_sword TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60427,16524,20240,45600,60,0,0);   -- fleuret TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60427,16583,20240,45600,60,0,0);   -- claymore TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60427,16584,20240,45600,60,0,0);   -- mythril_claymore TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60427,16585,20240,45600,60,0,0);   -- darksteel_claymore TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60427,16589,10444,67958,60,0,0);   -- two_handed_sword
-- INSERT INTO `guild_shops` VALUES (60427,16590,20240,45600,60,0,0);   -- greatsword TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60427,17059,20240,45600,60,0,0);   -- bronze_rod TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60427,17060,20240,45600,60,0,0);   -- rod TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60427,17061,20240,45600,60,0,0);   -- mythril_rod TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60427,16650,18270,36987,60,0,0);   -- war_pick
INSERT INTO `guild_shops` VALUES (60427,16651,66555,168606,60,0,0);  -- mythril_pick
INSERT INTO `guild_shops` VALUES (60427,17034,313,917,60,0,0);       -- bronze_mace
-- INSERT INTO `guild_shops` VALUES (60427,17035,20240,45600,60,0,0);   -- mace TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60427,17036,20240,45600,60,0,0);   -- mythril_mace TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60427,16768,643,677,60,0,0);       -- bronze_zaghnal
INSERT INTO `guild_shops` VALUES (60427,16770,16803,24703,60,0,0);   -- zaghnal
-- INSERT INTO `guild_shops` VALUES (60427,16774,20240,45600,60,0,0);   -- scythe TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60427,16775,20240,45600,60,0,0);   -- mythril_scythe TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60427,12432,2711,2856,60,0,0);     -- faceguard
INSERT INTO `guild_shops` VALUES (60427,12424,7695,26676,60,0,0);    -- iron_mask
INSERT INTO `guild_shops` VALUES (60427,13871,27216,47355,60,0,0);   -- iron_visor
INSERT INTO `guild_shops` VALUES (60427,13873,61107,70963,60,0,0);   -- steel_visor
INSERT INTO `guild_shops` VALUES (60427,12688,1666,5664,60,0,0);     -- scale_finger_gauntlets
-- INSERT INTO `guild_shops` VALUES (60427,12680,20240,45600,60,0,0);   -- chain_mittens TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60427,14001,42476,88529,60,0,0);   -- iron_finger_gauntlets
INSERT INTO `guild_shops` VALUES (60427,14003,79745,84198,60,0,0);   -- steel_finger_gauntlets
INSERT INTO `guild_shops` VALUES (60427,12944,1519,5294,60,0,0);     -- scale_greaves
-- INSERT INTO `guild_shops` VALUES (60427,12936,20240,45600,60,0,0);   -- greaves TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60427,14118,20240,45600,60,0,0);   -- iron_greaves TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60427,14120,20240,45600,60,0,0);   -- steel_greaves TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60427,12816,2810,8735,60,0,0);     -- scale_cuisses TODO: verify min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60427,12808,20240,45600,60,0,0);   -- chain_hose TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60427,14243,20240,45600,60,0,0);   -- iron_cuisses TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60427,14245,52785,166096,60,0,0);  -- steel_cuisses
-- INSERT INTO `guild_shops` VALUES (60427,12560,20240,45600,60,0,0);   -- scale_mail TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60427,12552,20240,45600,60,0,0);   -- chainmail TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60427,13783,81084,162345,60,0,0);  -- iron_scale_mail
-- INSERT INTO `guild_shops` VALUES (60427,13785,20240,45600,60,0,0);   -- steel_scale_mail TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60427,12306,20240,45600,60,0,0);   -- kite_shield TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60427,2143,320,320,240,48,180);    -- mandrel
INSERT INTO `guild_shops` VALUES (60427,2144,75,75,240,48,180);      -- workshop_anvil

-- Dehbi Moshal (Woodworking Guild) Al Zahbi
INSERT INTO `guild_shops` VALUES (60428,688,15,30,240,48,180);      -- arrowwood_log
INSERT INTO `guild_shops` VALUES (60428,689,27,59,240,48,144);      -- lauan_log
INSERT INTO `guild_shops` VALUES (60428,691,45,192,240,48,144);     -- maple_log
INSERT INTO `guild_shops` VALUES (60428,698,72,441,240,48,144);     -- ash_log
INSERT INTO `guild_shops` VALUES (60428,695,120,736,240,48,144);    -- willow_log
INSERT INTO `guild_shops` VALUES (60428,697,528,3243,180,48,108);   -- holly_log
INSERT INTO `guild_shops` VALUES (60428,696,330,2024,180,48,108);   -- yew_log
INSERT INTO `guild_shops` VALUES (60428,690,1378,10938,255,48,84);  -- elm_log
INSERT INTO `guild_shops` VALUES (60428,693,640,3928,60,48,36);     -- walnut_log
INSERT INTO `guild_shops` VALUES (60428,694,2119,12999,120,33,72);  -- chestnut_log
INSERT INTO `guild_shops` VALUES (60428,699,4740,29072,60,33,36);   -- oak_log
INSERT INTO `guild_shops` VALUES (60428,701,6615,40572,60,33,36);   -- rosewood_log
INSERT INTO `guild_shops` VALUES (60428,700,9075,34848,60,33,36);   -- mahogany_log
INSERT INTO `guild_shops` VALUES (60428,702,9600,45568,60,33,36);   -- ebony_log
-- INSERT INTO `guild_shops` VALUES (60428,727,704,2465,240,0,0);      -- dogwood_log TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60428,729,9600,45568,240,0,0);    -- bloodwood_log TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60428,704,96,673,240,100,36);     -- bamboo_stick
INSERT INTO `guild_shops` VALUES (60428,721,704,2465,240,0,0);      -- rattan_lumber
INSERT INTO `guild_shops` VALUES (60428,705,3,18,240,48,36);        -- arrowwood_lumber
INSERT INTO `guild_shops` VALUES (60428,706,27,165,240,48,36);      -- lauan_lumber
INSERT INTO `guild_shops` VALUES (60428,708,45,276,240,48,36);      -- maple_lumber
INSERT INTO `guild_shops` VALUES (60428,715,72,441,240,48,36);      -- ash_lumber
INSERT INTO `guild_shops` VALUES (60428,712,120,736,240,48,36);     -- willow_lumber
INSERT INTO `guild_shops` VALUES (60428,714,607,3726,180,48,27);    -- holly_lumber
INSERT INTO `guild_shops` VALUES (60428,713,330,2024,180,48,27);    -- yew_lumber
INSERT INTO `guild_shops` VALUES (60428,707,1723,10570,120,48,18);  -- elm_lumber
INSERT INTO `guild_shops` VALUES (60428,710,2119,12999,120,33,18);  -- chestnut_lumber
INSERT INTO `guild_shops` VALUES (60428,716,4740,26544,60,33,15);   -- oak_lumber
INSERT INTO `guild_shops` VALUES (60428,711,1015,3982,60,0,0);      -- walnut_lumber
-- INSERT INTO `guild_shops` VALUES (60428,718,41983,41983,60,0,0);    -- rosewood_lumber TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60428,717,41140,41140,60,0,0);    -- mahogany_lumber TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60428,719,23552,62464,60,0,0);    -- ebony_lumber
-- INSERT INTO `guild_shops` VALUES (60428,720,41140,41140,60,0,0);    -- ancient_lumber TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60428,728,41140,41140,60,0,0);    -- dogwood_lumber TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60428,730,41140,41140,60,0,0);    -- bloodwood_lumber TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60428,12984,176,280,24,0,0);      -- ash_clogs
INSERT INTO `guild_shops` VALUES (60428,12985,1625,7605,24,0,0);    -- holly_clogs
INSERT INTO `guild_shops` VALUES (60428,12986,6885,40024,24,0,0);   -- chestnut_sabots
INSERT INTO `guild_shops` VALUES (60428,12987,38707,38707,24,0,0);  -- ebony_sabots
INSERT INTO `guild_shops` VALUES (60428,12289,88,537,30,0,0);       -- lauaun_shield
INSERT INTO `guild_shops` VALUES (60428,12290,847,1173,30,0,0);     -- maple_shield
-- INSERT INTO `guild_shops` VALUES (60428,12291,847,1173,30,0,0);     -- elm_shield TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60428,12292,847,1173,30,0,0);     -- mahogany_shield TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60428,12293,847,1173,30,0,0);     -- oak_shield TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60428,2,847,1173,12,0,0);         -- simple_bed TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60428,22,282,1639,12,0,0);        -- workbench
INSERT INTO `guild_shops` VALUES (60428,97,5508,13512,12,0,0);      -- book_holder
INSERT INTO `guild_shops` VALUES (60428,102,291,713,12,0,0);        -- flower_stand
-- INSERT INTO `guild_shops` VALUES (60428,21,847,1173,12,0,0);        -- desk TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60428,26,31500,137340,12,0,0);    -- tarutaru_desk
INSERT INTO `guild_shops` VALUES (60428,23,829,2035,12,0,0);        -- maple_table
INSERT INTO `guild_shops` VALUES (60428,92,738,3621,12,0,0);        -- tarutaru_stool
INSERT INTO `guild_shops` VALUES (60428,24,70200,408096,12,0,0);    -- oak_table
INSERT INTO `guild_shops` VALUES (60428,17348,11256,32592,60,0,0);  -- traversiere
INSERT INTO `guild_shops` VALUES (60428,3,295500,295500,60,0,0);    -- oak_bed
INSERT INTO `guild_shops` VALUES (60428,17345,69,163,60,0,0);       -- flute
INSERT INTO `guild_shops` VALUES (60428,17347,1028,5368,60,0,0);    -- piccolo
INSERT INTO `guild_shops` VALUES (60428,17353,37,94,60,0,0);        -- maple_harp
INSERT INTO `guild_shops` VALUES (60428,17354,1675,12200,60,0,0);   -- harp
INSERT INTO `guild_shops` VALUES (60428,17355,13400,79200,60,0,0);  -- rose_harp
INSERT INTO `guild_shops` VALUES (60428,17024,48,351,60,0,0);       -- ash_club
INSERT INTO `guild_shops` VALUES (60428,17025,1165,8282,60,0,0);    -- chestnut_club
INSERT INTO `guild_shops` VALUES (60428,17027,7525,22127,60,0,0);   -- oak_cudgel
INSERT INTO `guild_shops` VALUES (60428,17030,14766,81107,60,0,0);  -- great_club
INSERT INTO `guild_shops` VALUES (60428,17049,34,102,60,0,0);       -- maple_wand
INSERT INTO `guild_shops` VALUES (60428,17050,247,1406,60,0,0);     -- willow_wand
INSERT INTO `guild_shops` VALUES (60428,17051,1049,3038,60,0,0);    -- yew_wand
INSERT INTO `guild_shops` VALUES (60428,17052,3827,27189,60,0,0);   -- chestnut_wand
INSERT INTO `guild_shops` VALUES (60428,17053,20944,41289,60,0,0);  -- rose_wand
INSERT INTO `guild_shops` VALUES (60428,17152,41,214,60,0,0);       -- shortbow
INSERT INTO `guild_shops` VALUES (60428,17153,1039,2615,60,0,0);    -- self_bow
INSERT INTO `guild_shops` VALUES (60428,17155,5625,16875,60,0,0);   -- composite_bow
INSERT INTO `guild_shops` VALUES (60428,17156,82971,82971,60,0,0);  -- kaman
INSERT INTO `guild_shops` VALUES (60428,17160,870,969,60,0,0);      -- longbow
INSERT INTO `guild_shops` VALUES (60428,17154,15602,38649,60,0,0);  -- wrapped_bow
-- INSERT INTO `guild_shops` VALUES (60428,17161,15602,38649,60,0,0);  -- power_bow TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60428,17162,14614,42969,60,0,0);  -- great_bow
INSERT INTO `guild_shops` VALUES (60428,17163,28944,82080,60,0,0);  -- battle_bow
INSERT INTO `guild_shops` VALUES (60428,17164,57405,166219,60,0,0); -- war_bow
INSERT INTO `guild_shops` VALUES (60428,17088,46,261,60,0,0);       -- ash_staff
INSERT INTO `guild_shops` VALUES (60428,17089,424,1066,60,0,0);     -- holly_staff
INSERT INTO `guild_shops` VALUES (60428,17090,3371,7103,60,0,0);    -- elm_staff
INSERT INTO `guild_shops` VALUES (60428,17091,3371,7103,60,0,0);    -- oak_staff
INSERT INTO `guild_shops` VALUES (60428,17095,281,1932,60,0,0);     -- ash_pole
INSERT INTO `guild_shops` VALUES (60428,17096,3400,24161,60,0,0);   -- holly_pole
INSERT INTO `guild_shops` VALUES (60428,17097,22617,35932,60,0,0);  -- elm_pole
INSERT INTO `guild_shops` VALUES (60428,17098,29390,72633,60,0,0);  -- oak_pole
INSERT INTO `guild_shops` VALUES (60428,17424,7717,49980,60,0,0);   -- spiked_club
-- INSERT INTO `guild_shops` VALUES (60428,17523,7717,49980,60,0,0);   -- quarterstaff TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60428,16832,194,267,60,0,0);      -- harpoon
INSERT INTO `guild_shops` VALUES (60428,16833,809,4294,60,0,0);     -- bronze_spear
INSERT INTO `guild_shops` VALUES (60428,16834,6448,25376,60,0,0);   -- brass_spear
INSERT INTO `guild_shops` VALUES (60428,16835,27165,34750,60,0,0);  -- spear
-- INSERT INTO `guild_shops` VALUES (60428,16836,7717,49980,60,0,0);   -- halberd TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60428,16845,31314,34445,60,0,0);  -- lance
INSERT INTO `guild_shops` VALUES (60428,17216,187,354,60,0,0);      -- light_crossbow
-- INSERT INTO `guild_shops` VALUES (60428,17217,7717,49980,60,0,0);   -- crossbow TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60428,17218,10311,67100,60,0,0);  -- zamburak
INSERT INTO `guild_shops` VALUES (60428,17280,1172,5250,60,0,0);    -- boomerang
INSERT INTO `guild_shops` VALUES (60428,17318,6,18,240,48,50);      -- wooden_arrow
INSERT INTO `guild_shops` VALUES (60428,17320,7,26,240,10,50);      -- iron_arrow
INSERT INTO `guild_shops` VALUES (60428,17321,28,60,240,10,50);     -- silver_arrow

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

-- Tsutsuroon (Tenshodo Merchant) Nashmau
INSERT INTO `guild_shops` VALUES (60431,16896,517,884,60,10,50);      -- kunai
INSERT INTO `guild_shops` VALUES (60431,16917,4226,4840,60,7,50);     -- suzume
-- INSERT INTO `guild_shops` VALUES (60431,16915,14428,35251,60,0,0);    -- hien TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60431,16897,14428,35251,60,0,0);    -- kageboshi TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60431,16900,1404,2160,60,7,50);     -- wakizashi
INSERT INTO `guild_shops` VALUES (60431,16919,2728,17167,60,7,50);    -- shinobi_gatana
-- INSERT INTO `guild_shops` VALUES (60431,16901,14428,35251,60,0,0);    -- kodachi TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60431,16913,14428,35251,60,0,0);    -- shinogi TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60431,16902,14428,35251,60,0,0);    -- sakurafubuki TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60431,16924,14428,35251,60,0,0);    -- hocho TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60431,16903,14428,35251,60,0,0);    -- kabutowari TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60431,16960,3121,3575,60,5,50);     -- uchigatana
-- INSERT INTO `guild_shops` VALUES (60431,16974,224510,697840,60,0,0);  -- dotanuki TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60431,16975,11583,19800,60,5,30);   -- kanesada
-- INSERT INTO `guild_shops` VALUES (60431,16962,14428,35251,60,0,0);    -- ashura TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60431,16966,1836,2103,60,10,50);    -- tachi
INSERT INTO `guild_shops` VALUES (60431,16982,4752,19172,60,0,20);    -- nodachi
-- INSERT INTO `guild_shops` VALUES (60431,16984,14428,35251,60,0,0);    -- jindachi TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60431,16987,12253,51946,60,5,19);   -- okanehira
INSERT INTO `guild_shops` VALUES (60431,16988,14676,62218,60,7,19);   -- kotetsu
-- INSERT INTO `guild_shops` VALUES (60431,16973,14428,35251,60,0,0);    -- homura TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60431,16967,14428,35251,60,0,0);    -- mikazuki TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60431,16990,14428,35251,60,0,0);    -- daihannya TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60431,16991,14428,35251,60,0,0);    -- odenta TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60431,16970,14428,35251,60,0,0);    -- hosodachi TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60431,17802,189945,464059,60,2,10); -- kiku_ichimonji
-- INSERT INTO `guild_shops` VALUES (60431,16964,14428,35251,60,0,0);    -- zanbato TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60431,16972,14428,35251,60,0,0);    -- kazaridachi TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60431,16871,183516,404395,60,2,10); -- kamayari
-- INSERT INTO `guild_shops` VALUES (60431,16841,14428,35251,60,0,0);    -- wyvern_spear TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60431,17259,72144,158976,60,5,10);  -- pirates_gun
INSERT INTO `guild_shops` VALUES (60431,17265,14428,35251,60,0,0);    -- tanegashima
-- INSERT INTO `guild_shops` VALUES (60431,17267,14428,35251,60,0,0);    -- negoroshiki TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60431,17301,29,87,60,10,40);        -- shuriken
INSERT INTO `guild_shops` VALUES (60431,17302,90,1190,60,10,30);      -- juji_shuriken
INSERT INTO `guild_shops` VALUES (60431,17303,7333,10120,60,0,0);     -- manji_shuriken
INSERT INTO `guild_shops` VALUES (60431,17304,1472,57960,60,5,10);    -- fuma_shuriken
-- INSERT INTO `guild_shops` VALUES (60431,17309,14428,35251,60,0,0);    -- pinwheel TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60431,17284,14428,35251,60,0,0);    -- chakram TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60431,17285,101745,220248,60,0,10); -- moonring_blade
INSERT INTO `guild_shops` VALUES (60431,17314,3926,7446,60,0,0);      -- quake_grenade
INSERT INTO `guild_shops` VALUES (60431,17320,7,26,60,0,0);           -- iron_arrow
INSERT INTO `guild_shops` VALUES (60431,17322,81,330,60,10,40);       -- fire_arrow
INSERT INTO `guild_shops` VALUES (60431,17340,58,436,60,10,30);       -- bullet
INSERT INTO `guild_shops` VALUES (60431,12456,552,858,60,10,36);      -- hachimaki
INSERT INTO `guild_shops` VALUES (60431,12457,3272,5079,60,7,36);     -- cotton_hachimaki
INSERT INTO `guild_shops` VALUES (60431,12458,8972,13927,60,5,36);    -- soil_hachimaki
-- INSERT INTO `guild_shops` VALUES (60431,12460,8972,13927,60,0,0);     -- shinobi_hachigane TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60431,12459,8972,13927,60,0,0);     -- zunari_kabuto TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60431,13111,20061,29942,60,5,30);   -- nodowa
INSERT INTO `guild_shops` VALUES (60431,13088,43890,52440,60,0,0);    -- darksteel_nodowa
INSERT INTO `guild_shops` VALUES (60431,12584,833,1294,60,10,36);     -- kenpogi
INSERT INTO `guild_shops` VALUES (60431,12585,4931,7654,60,7,36);     -- cotton_dogi
-- INSERT INTO `guild_shops` VALUES (60431,13728,8972,13927,60,0,0);     -- jujitsu_gi TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60431,12586,13266,17820,60,5,36);   -- soil_gi
-- INSERT INTO `guild_shops` VALUES (60431,12588,8972,13927,60,0,0);     -- shinobi_gi TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60431,12587,8972,13927,60,0,0);     -- hara_ate TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60431,12712,458,712,60,10,36);      -- tekko
INSERT INTO `guild_shops` VALUES (60431,12713,2713,4212,60,7,36);     -- cotton_tekko
INSERT INTO `guild_shops` VALUES (60431,12714,2713,9979,60,5,36);     -- soil_tekko
-- INSERT INTO `guild_shops` VALUES (60431,12716,8972,13927,60,0,0);     -- shinobi_tekko TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60431,12715,8972,13927,60,0,0);     -- kote TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60431,12840,666,1034,60,10,36);     -- sitabaki
INSERT INTO `guild_shops` VALUES (60431,12841,2713,6133,60,7,36);     -- cotton_sitabaki
INSERT INTO `guild_shops` VALUES (60431,12842,10805,14515,60,5,36);   -- soil_sitabaki
-- INSERT INTO `guild_shops` VALUES (60431,12844,8972,13927,60,0,0);     -- shinobi_hakama TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60431,12843,8972,13927,60,0,0);     -- haidate TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60431,12968,424,660,60,10,36);      -- kyahan
INSERT INTO `guild_shops` VALUES (60431,12969,2528,3924,60,7,36);     -- cotton_kyahan
INSERT INTO `guild_shops` VALUES (60431,12970,11071,14871,60,5,36);   -- soil_kyahan
-- INSERT INTO `guild_shops` VALUES (60431,13204,8972,13927,60,0,0);     -- heko_obi TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60431,13205,8972,13927,60,0,0);     -- silver_obi TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60431,13206,8972,13927,60,0,0);     -- gold_obi TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60431,13207,8972,13927,60,0,0);     -- brocade_obi TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60431,13208,8972,13927,60,0,0);     -- rainbow_obi TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60431,704,96,673,240,75,50);        -- bamboo_stick
INSERT INTO `guild_shops` VALUES (60431,915,2700,16120,60,33,18);     -- jar_of_toad_oil
INSERT INTO `guild_shops` VALUES (60431,1134,810,5140,60,48,10);      -- sheet_of_bast_parchment
INSERT INTO `guild_shops` VALUES (60431,829,35070,102480,60,0,0);     -- square_of_silk_cloth
INSERT INTO `guild_shops` VALUES (60431,1155,436,2400,240,33,190);    -- handful_of_iron_sand
INSERT INTO `guild_shops` VALUES (60431,657,4690,30520,120,33,80);    -- lump_of_tama_hagane
INSERT INTO `guild_shops` VALUES (60431,1415,55147,232354,60,33,14);  -- pot_of_urushi
INSERT INTO `guild_shops` VALUES (60431,1161,30,187,240,10,80);       -- uchitake
INSERT INTO `guild_shops` VALUES (60431,1164,30,187,240,10,80);       -- tsurara
INSERT INTO `guild_shops` VALUES (60431,1167,30,187,240,10,80);       -- kawahori_ogi
INSERT INTO `guild_shops` VALUES (60431,1170,30,187,240,10,80);       -- makibishi
INSERT INTO `guild_shops` VALUES (60431,1173,30,187,240,10,80);       -- hiraishin
INSERT INTO `guild_shops` VALUES (60431,1176,30,187,240,10,80);       -- mizu_deppo
-- INSERT INTO `guild_shops` VALUES (60431,1179,66,174,60,0,0);          -- shihei TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60431,1182,66,174,60,0,0);          -- jusatsu TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60431,1185,66,174,60,0,0);          -- kaginawa TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60431,1188,66,174,60,0,0);          -- sairui_ran TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60431,1191,66,174,60,0,0);          -- kodoku TODO: missing min_price and max_price
-- INSERT INTO `guild_shops` VALUES (60431,1194,66,174,60,0,0);          -- shinobi_tabi TODO: missing min_price and max_price
INSERT INTO `guild_shops` VALUES (60431,1472,369,1476,200,48,150);    -- gardenia_seed
INSERT INTO `guild_shops` VALUES (60431,1554,431,1522,240,48,170);    -- onz_of_turmeric
INSERT INTO `guild_shops` VALUES (60431,1555,1061,5325,240,48,170);   -- onz_of_coriander
INSERT INTO `guild_shops` VALUES (60431,1590,536,5836,240,48,170);    -- sprig_of_holy_basil
INSERT INTO `guild_shops` VALUES (60431,1475,411,4985,120,48,110);    -- onz_of_curry_powder
INSERT INTO `guild_shops` VALUES (60431,5164,1945,10899,200,48,150);  -- jar_of_ground_wasabi
INSERT INTO `guild_shops` VALUES (60431,1652,150,704,200,48,150);     -- bottle_of_rice_vinegar
INSERT INTO `guild_shops` VALUES (60431,5235,187,1350,200,48,150);    -- head_of_napa

-- Ilita (Port Bastok) / Paunelie (Southern San dOria) / Khel Pahlhama (Port Windurst) (Linkshells pseudo guild shop)
INSERT INTO `guild_shops` VALUES (60432,512,6000,14400,100,10,75); -- New Linkshell
INSERT INTO `guild_shops` VALUES (60432,16285,375,375,200,50,150); -- Pendant Compass

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
