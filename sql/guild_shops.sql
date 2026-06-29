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




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
