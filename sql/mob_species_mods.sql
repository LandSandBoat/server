/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `mob_species_mods`
--

DROP TABLE IF EXISTS `mob_species_mods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mob_species_mods` (
  `speciesid` smallint(5) unsigned NOT NULL,
  `modid` smallint(5) unsigned NOT NULL,
  `value` smallint(5) NOT NULL DEFAULT '0',
  `is_mob_mod` boolean NOT NULL DEFAULT '0',
  PRIMARY KEY (`speciesid`,`modid`)
) ENGINE=Aria TRANSACTIONAL=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci AVG_ROW_LENGTH=13 PACK_KEYS=1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mob_species_mods`
--

LOCK TABLES `mob_species_mods` WRITE;
/*!40000 ALTER TABLE `mob_species_mods` DISABLE KEYS */;
-- Adamantoise
INSERT INTO `mob_species_mods` VALUES (298,36,50,1); -- ROAM_COOL: 50
INSERT INTO `mob_species_mods` VALUES (298,52,30,1); -- ROAM_RATE: 30
INSERT INTO `mob_species_mods` VALUES (298,63,20,0); -- DEFP: 20

-- Ahriman
INSERT INTO `mob_species_mods` VALUES (195,7,60,1);   -- GA_CHANCE: 60
INSERT INTO `mob_species_mods` VALUES (195,29,20,0);  -- MDEF: 20
INSERT INTO `mob_species_mods` VALUES (195,36,40,1);  -- ROAM_COOL: 40
INSERT INTO `mob_species_mods` VALUES (195,51,5,1);   -- ROAM_TURNS: 5
INSERT INTO `mob_species_mods` VALUES (195,56,-1,1);  -- HP_STANDBACK: -1
INSERT INTO `mob_species_mods` VALUES (195,244,20,0); -- SILENCERES: 20

-- Animated Weapon
INSERT INTO `mob_species_mods` VALUES (476,3,50,1); -- MP_BASE: 50

-- Antlion
INSERT INTO `mob_species_mods` VALUES (422,36,50,1); -- ROAM_COOL: 50
INSERT INTO `mob_species_mods` VALUES (422,51,2,1);  -- ROAM_TURNS: 2
INSERT INTO `mob_species_mods` VALUES (422,52,30,1); -- ROAM_RATE: 30
INSERT INTO `mob_species_mods` VALUES (422,63,20,0); -- DEFP: 20

-- Apkallu
INSERT INTO `mob_species_mods` VALUES (171,10,14,1); -- SUBLINK: 14 (Apkallu)

-- Avatar-Atomos
INSERT INTO `mob_species_mods` VALUES (240,56,-1,1); -- HP_STANDBACK: -1

-- Avatar-Alexander
INSERT INTO `mob_species_mods` VALUES (239,56,-1,1); -- HP_STANDBACK: -1

-- Avatar-Carbuncle
INSERT INTO `mob_species_mods` VALUES (243,3,100,1); -- MP_BASE: 100
INSERT INTO `mob_species_mods` VALUES (243,56,-1,1); -- HP_STANDBACK: -1

-- Avatar-Diabolos
INSERT INTO `mob_species_mods` VALUES (245,56,-1,1); -- HP_STANDBACK: -1

-- Avatar-Fenrir
INSERT INTO `mob_species_mods` VALUES (246,56,-1,1); -- HP_STANDBACK: -1

-- Avatar-Garuda
INSERT INTO `mob_species_mods` VALUES (247,56,-1,1); -- HP_STANDBACK: -1

-- Avatar-Ifrit
INSERT INTO `mob_species_mods` VALUES (248,56,-1,1); -- HP_STANDBACK: -1

-- Monoceros
INSERT INTO `mob_species_mods` VALUES (272,56,-1,1); -- HP_STANDBACK: -1

-- Avatar-Leviathan
INSERT INTO `mob_species_mods` VALUES (249,56,-1,1); -- HP_STANDBACK: -1

-- Avatar-Odin
INSERT INTO `mob_species_mods` VALUES (250,56,-1,1); -- HP_STANDBACK: -1

-- Avatar-Odin

-- Avatar-Ramuh
INSERT INTO `mob_species_mods` VALUES (252,56,-1,1); -- HP_STANDBACK: -1

-- Avatar-Shiva
INSERT INTO `mob_species_mods` VALUES (253,56,-1,1); -- HP_STANDBACK: -1

-- Avatar-Titan
INSERT INTO `mob_species_mods` VALUES (255,56,-1,1); -- HP_STANDBACK: -1

-- Bat
INSERT INTO `mob_species_mods` VALUES (173,10,3,1);  -- SUBLINK: 3 (Single Bat, Bat Trio, Vampyr)
INSERT INTO `mob_species_mods` VALUES (173,36,35,1); -- ROAM_COOL: 35
INSERT INTO `mob_species_mods` VALUES (173,51,3,1);  -- ROAM_TURNS: 3
INSERT INTO `mob_species_mods` VALUES (173,52,30,1); -- ROAM_RATE: 30

-- Bat Trio
INSERT INTO `mob_species_mods` VALUES (181,10,3,1);  -- SUBLINK: 3 (Single Bat, Bat Trio, Vampyr)
INSERT INTO `mob_species_mods` VALUES (181,36,35,1); -- ROAM_COOL: 35
INSERT INTO `mob_species_mods` VALUES (181,51,2,1);  -- ROAM_TURNS: 2
INSERT INTO `mob_species_mods` VALUES (181,52,30,1); -- ROAM_RATE: 30

-- Bee
INSERT INTO `mob_species_mods` VALUES (425,36,15,1); -- ROAM_COOL: 15
INSERT INTO `mob_species_mods` VALUES (425,51,2,1);  -- ROAM_TURNS: 2

-- Beetle
INSERT INTO `mob_species_mods` VALUES (429,31,15,1); -- ROAM_DISTANCE: 15
INSERT INTO `mob_species_mods` VALUES (429,36,60,1); -- ROAM_COOL: 60
INSERT INTO `mob_species_mods` VALUES (429,52,30,1); -- ROAM_RATE: 30

-- Behemoth
INSERT INTO `mob_species_mods` VALUES (85,36,50,1); -- ROAM_COOL: 50

-- Bhoot
INSERT INTO `mob_species_mods` VALUES (407,242,20,0); -- PARALYZERES: 20

-- Bomb
INSERT INTO `mob_species_mods` VALUES (46,36,30,1); -- ROAM_COOL: 30
INSERT INTO `mob_species_mods` VALUES (46,51,5,1);  -- ROAM_TURNS: 5
INSERT INTO `mob_species_mods` VALUES (46,52,20,1); -- ROAM_RATE: 20

-- Buffalo
INSERT INTO `mob_species_mods` VALUES (88,3,50,1);  -- MP_BASE: 50
INSERT INTO `mob_species_mods` VALUES (88,36,50,1); -- ROAM_COOL: 50
INSERT INTO `mob_species_mods` VALUES (88,51,4,1);  -- ROAM_TURNS: 4
INSERT INTO `mob_species_mods` VALUES (88,52,30,1); -- ROAM_RATE: 30
INSERT INTO `mob_species_mods` VALUES (88,62,10,0); -- ATTP: 10
INSERT INTO `mob_species_mods` VALUES (88,63,20,0); -- DEFP: 20

-- Bugard
INSERT INTO `mob_species_mods` VALUES (302,36,45,1); -- ROAM_COOL: 45
INSERT INTO `mob_species_mods` VALUES (302,51,3,1);  -- ROAM_TURNS: 3
INSERT INTO `mob_species_mods` VALUES (302,52,30,1); -- ROAM_RATE: 30
INSERT INTO `mob_species_mods` VALUES (302,62,10,0); -- ATTP: 10
INSERT INTO `mob_species_mods` VALUES (302,63,20,0); -- DEFP: 20

-- Bugbear
INSERT INTO `mob_species_mods` VALUES (118,10,5,1);  -- SUBLINK: 5 (Bugbear, Goblin, Moblin)
INSERT INTO `mob_species_mods` VALUES (118,36,50,1); -- ROAM_COOL: 50
INSERT INTO `mob_species_mods` VALUES (118,51,2,1);  -- ROAM_TURNS: 2
INSERT INTO `mob_species_mods` VALUES (118,52,30,1); -- ROAM_RATE: 30
INSERT INTO `mob_species_mods` VALUES (118,63,20,0); -- DEFP: 20

-- Cardian: https://www.bg-wiki.com/ffxi/Category:Cardian
INSERT INTO `mob_species_mods` VALUES (49,29,25,0);     -- MDEF: 25
INSERT INTO `mob_species_mods` VALUES (49,36,40,1);     -- ROAM_COOL: 40
INSERT INTO `mob_species_mods` VALUES (49,51,2,1);      -- ROAM_TURNS: 2
INSERT INTO `mob_species_mods` VALUES (49,52,20,1);     -- ROAM_RATE: 20
INSERT INTO `mob_species_mods` VALUES (49,389,-2500,0); -- UDMGMAGIC: -2500

-- Cerberus
INSERT INTO `mob_species_mods` VALUES (90,36,50,1); -- ROAM_COOL: 50

-- Chariot
INSERT INTO `mob_species_mods` VALUES (75,10,15,1); -- SUBLINK: 15 (Chariot, Gear, Rampart)

-- Bomb-Cluster
INSERT INTO `mob_species_mods` VALUES (59,36,40,1); -- ROAM_COOL: 40
INSERT INTO `mob_species_mods` VALUES (59,51,2,1);  -- ROAM_TURNS: 2
INSERT INTO `mob_species_mods` VALUES (59,52,20,1); -- ROAM_RATE: 20

-- Cockatrice
INSERT INTO `mob_species_mods` VALUES (177,36,30,1); -- ROAM_COOL: 30
INSERT INTO `mob_species_mods` VALUES (177,51,3,1);  -- ROAM_TURNS: 3
INSERT INTO `mob_species_mods` VALUES (177,52,30,1); -- ROAM_RATE: 30

-- Coeurl
INSERT INTO `mob_species_mods` VALUES (92,31,5,1);  -- ROAM_DISTANCE: 5
INSERT INTO `mob_species_mods` VALUES (92,36,55,1); -- ROAM_COOL: 55
INSERT INTO `mob_species_mods` VALUES (92,52,30,1); -- ROAM_RATE: 30

-- Colibri
INSERT INTO `mob_species_mods` VALUES (179,3,50,1);  -- MP_BASE: 50
INSERT INTO `mob_species_mods` VALUES (179,29,10,0); -- MDEF: 10
INSERT INTO `mob_species_mods` VALUES (179,51,2,1);  -- ROAM_TURNS: 2
INSERT INTO `mob_species_mods` VALUES (179,52,30,1); -- ROAM_RATE: 30
INSERT INTO `mob_species_mods` VALUES (179,68,20,0); -- EVA: 20

-- Corse: https://www.bg-wiki.com/ffxi/Category:Corse
INSERT INTO `mob_species_mods` VALUES (394,29,25,0);     -- MDEF: 25
INSERT INTO `mob_species_mods` VALUES (394,36,50,1);     -- ROAM_COOL: 50
INSERT INTO `mob_species_mods` VALUES (394,51,2,1);      -- ROAM_TURNS: 2
INSERT INTO `mob_species_mods` VALUES (394,52,30,1);     -- ROAM_RATE: 30
INSERT INTO `mob_species_mods` VALUES (394,388,-5000,0); -- UDMGBREATH: -5000
INSERT INTO `mob_species_mods` VALUES (394,389,-2500,0); -- UDMGMAGIC: -2500

-- Crab
INSERT INTO `mob_species_mods` VALUES (25,36,15,1); -- ROAM_COOL: 15

-- Crawler
INSERT INTO `mob_species_mods` VALUES (437,36,55,1); -- ROAM_COOL: 55
INSERT INTO `mob_species_mods` VALUES (437,52,30,1); -- ROAM_RATE: 30

-- Dhalmel
INSERT INTO `mob_species_mods` VALUES (95,36,30,1); -- ROAM_COOL: 30
INSERT INTO `mob_species_mods` VALUES (95,51,2,1);  -- ROAM_TURNS: 2
INSERT INTO `mob_species_mods` VALUES (95,52,30,1); -- ROAM_RATE: 30

-- Diremite
INSERT INTO `mob_species_mods` VALUES (442,36,50,1); -- ROAM_COOL: 50
INSERT INTO `mob_species_mods` VALUES (442,51,2,1);  -- ROAM_TURNS: 2

-- Doll
INSERT INTO `mob_species_mods` VALUES (60,31,5,1);  -- ROAM_DISTANCE: 5
INSERT INTO `mob_species_mods` VALUES (60,36,55,1); -- ROAM_COOL: 55
INSERT INTO `mob_species_mods` VALUES (60,52,30,1); -- ROAM_RATE: 30

-- Doll

-- Doomed
INSERT INTO `mob_species_mods` VALUES (398,36,55,1); -- ROAM_COOL: 55
INSERT INTO `mob_species_mods` VALUES (398,52,30,1); -- ROAM_RATE: 30

-- Dragon
INSERT INTO `mob_species_mods` VALUES (219,3,10,1);    -- MP_BASE: 10
INSERT INTO `mob_species_mods` VALUES (219,4,18,1);    -- SIGHT_RANGE: 18
INSERT INTO `mob_species_mods` VALUES (219,5,10,1);    -- SOUND_RANGE: 10
INSERT INTO `mob_species_mods` VALUES (219,36,55,1);   -- ROAM_COOL: 55
INSERT INTO `mob_species_mods` VALUES (219,54,1000,1); -- GIL_BONUS: 1000
INSERT INTO `mob_species_mods` VALUES (219,62,20,0);   -- ATTP: 20

-- Dynamisstatue-Goblin
INSERT INTO `mob_species_mods` VALUES (126,23,2047,1); -- IMMUNITY: 2047
INSERT INTO `mob_species_mods` VALUES (126,56,-1,1);   -- HP_STANDBACK: -1
INSERT INTO `mob_species_mods` VALUES (126,73,100,0);  -- STORETP: 100

-- Dynamisstatue-Orc
INSERT INTO `mob_species_mods` VALUES (139,23,2047,1); -- IMMUNITY: 2047
INSERT INTO `mob_species_mods` VALUES (139,56,-1,1);   -- HP_STANDBACK: -1
INSERT INTO `mob_species_mods` VALUES (139,73,100,0);  -- STORETP: 100

-- Dynamisstatue-Quadav
INSERT INTO `mob_species_mods` VALUES (150,23,2047,1); -- IMMUNITY: 2047
INSERT INTO `mob_species_mods` VALUES (150,56,-1,1);   -- HP_STANDBACK: -1
INSERT INTO `mob_species_mods` VALUES (150,73,100,0);  -- STORETP: 100

-- Dynamisstatue-Yagudo
INSERT INTO `mob_species_mods` VALUES (168,23,2047,1); -- IMMUNITY: 2047
INSERT INTO `mob_species_mods` VALUES (168,56,-1,1);   -- HP_STANDBACK: -1
INSERT INTO `mob_species_mods` VALUES (168,73,100,0);  -- STORETP: 100

-- Lizard-Ice
INSERT INTO `mob_species_mods` VALUES (308,36,60,1); -- ROAM_COOL: 60
INSERT INTO `mob_species_mods` VALUES (308,51,4,1);  -- ROAM_TURNS: 4
INSERT INTO `mob_species_mods` VALUES (308,52,30,1); -- ROAM_RATE: 30

-- Eft
INSERT INTO `mob_species_mods` VALUES (303,36,50,1); -- ROAM_COOL: 50
INSERT INTO `mob_species_mods` VALUES (303,51,5,1);  -- ROAM_TURNS: 5
INSERT INTO `mob_species_mods` VALUES (303,52,30,1); -- ROAM_RATE: 30

-- Elemental-Air
INSERT INTO `mob_species_mods` VALUES (256,51,3,1);  -- ROAM_TURNS: 3
INSERT INTO `mob_species_mods` VALUES (256,56,-1,1); -- HP_STANDBACK: -1

-- Elemental-Dark
INSERT INTO `mob_species_mods` VALUES (259,51,3,1);  -- ROAM_TURNS: 3
INSERT INTO `mob_species_mods` VALUES (259,56,-1,1); -- HP_STANDBACK: -1

-- Elemental-Earth
INSERT INTO `mob_species_mods` VALUES (260,51,3,1);  -- ROAM_TURNS: 3
INSERT INTO `mob_species_mods` VALUES (260,56,-1,1); -- HP_STANDBACK: -1

-- Elemental-Fire
INSERT INTO `mob_species_mods` VALUES (261,51,3,1);  -- ROAM_TURNS: 3
INSERT INTO `mob_species_mods` VALUES (261,56,-1,1); -- HP_STANDBACK: -1

-- Elemental-Ice
INSERT INTO `mob_species_mods` VALUES (263,51,3,1);  -- ROAM_TURNS: 3
INSERT INTO `mob_species_mods` VALUES (263,56,-1,1); -- HP_STANDBACK: -1

-- Elemental-Light
INSERT INTO `mob_species_mods` VALUES (264,51,3,1);  -- ROAM_TURNS: 3
INSERT INTO `mob_species_mods` VALUES (264,56,-1,1); -- HP_STANDBACK: -1

-- Elemental-Lightning
INSERT INTO `mob_species_mods` VALUES (265,51,3,1);  -- ROAM_TURNS: 3
INSERT INTO `mob_species_mods` VALUES (265,56,-1,1); -- HP_STANDBACK: -1

-- Elemental-Water
INSERT INTO `mob_species_mods` VALUES (267,51,3,1);  -- ROAM_TURNS: 3
INSERT INTO `mob_species_mods` VALUES (267,56,-1,1); -- HP_STANDBACK: -1

-- Evil Weapon: https://www.bg-wiki.com/ffxi/Category:Evil_Weapon
INSERT INTO `mob_species_mods` VALUES (62,3,50,1);      -- MP_BASE: 50
INSERT INTO `mob_species_mods` VALUES (62,36,45,1);     -- ROAM_COOL: 45
INSERT INTO `mob_species_mods` VALUES (62,51,3,1);      -- ROAM_TURNS: 3
INSERT INTO `mob_species_mods` VALUES (62,52,30,1);     -- ROAM_RATE: 30
INSERT INTO `mob_species_mods` VALUES (62,389,-1250,0); -- UDMGMAGIC: -1250

-- Non-Beastmen regular frogs
INSERT INTO `mob_species_mods` VALUES (32,62,1,1); -- NO_STANDBACK: 1

-- Flan: https://www.bg-wiki.com/ffxi/Category:Flan
INSERT INTO `mob_species_mods` VALUES (5,51,2,1);     -- ROAM_TURNS: 2
INSERT INTO `mob_species_mods` VALUES (5,52,30,1);    -- ROAM_RATE: 30
INSERT INTO `mob_species_mods` VALUES (5,388,2500,0); -- UDMGBREATH: 2500
INSERT INTO `mob_species_mods` VALUES (5,389,2500,0); -- UDMGMAGIC: 2500

-- Fomor
INSERT INTO `mob_species_mods` VALUES (403,36,50,1);  -- ROAM_COOL: 50
INSERT INTO `mob_species_mods` VALUES (403,51,2,1);   -- ROAM_TURNS: 2
INSERT INTO `mob_species_mods` VALUES (403,52,30,1);  -- ROAM_RATE: 30
INSERT INTO `mob_species_mods` VALUES (403,54,100,1); -- GIL_BONUS: 100

-- Funguar
INSERT INTO `mob_species_mods` VALUES (338,31,15,1); -- ROAM_DISTANCE: 15
INSERT INTO `mob_species_mods` VALUES (338,36,60,1); -- ROAM_COOL: 60
INSERT INTO `mob_species_mods` VALUES (338,52,30,1); -- ROAM_RATE: 30

-- Gear
INSERT INTO `mob_species_mods` VALUES (79,10,15,1); -- SUBLINK: 15 (Chariot, Gear, Rampart)

-- Ghost
INSERT INTO `mob_species_mods` VALUES (408,36,50,1); -- ROAM_COOL: 50
INSERT INTO `mob_species_mods` VALUES (408,52,30,1); -- ROAM_RATE: 30

-- Ghrah: https://www.bg-wiki.com/ffxi/Category:Ghrah
INSERT INTO `mob_species_mods` VALUES (328,389,-1250,0); -- UDMGMAGIC: -1250

-- Greater Bird
INSERT INTO `mob_species_mods` VALUES (188,36,40,1); -- ROAM_COOL: 40
INSERT INTO `mob_species_mods` VALUES (188,51,2,1);  -- ROAM_TURNS: 2
INSERT INTO `mob_species_mods` VALUES (188,52,30,1); -- ROAM_RATE: 30

-- Gigas
INSERT INTO `mob_species_mods` VALUES (121,31,5,1);   -- ROAM_DISTANCE: 5
INSERT INTO `mob_species_mods` VALUES (121,36,25,1);  -- ROAM_COOL: 25
INSERT INTO `mob_species_mods` VALUES (121,51,2,1);   -- ROAM_TURNS: 2
INSERT INTO `mob_species_mods` VALUES (121,52,30,1);  -- ROAM_RATE: 30
INSERT INTO `mob_species_mods` VALUES (121,54,180,1); -- GIL_BONUS: 180

-- Goblin
INSERT INTO `mob_species_mods` VALUES (126,10,5,1); -- SUBLINK: 5 (Bugbear, Goblin, Moblin)

-- Golem
INSERT INTO `mob_species_mods` VALUES (63,4,4,1);   -- SIGHT_RANGE: 4
INSERT INTO `mob_species_mods` VALUES (63,31,5,1);  -- ROAM_DISTANCE: 5
INSERT INTO `mob_species_mods` VALUES (63,36,55,1); -- ROAM_COOL: 55
INSERT INTO `mob_species_mods` VALUES (63,52,30,1); -- ROAM_RATE: 30

-- Goobbue
INSERT INTO `mob_species_mods` VALUES (340,31,5,1);  -- ROAM_DISTANCE: 5
INSERT INTO `mob_species_mods` VALUES (340,36,60,1); -- ROAM_COOL: 60
INSERT INTO `mob_species_mods` VALUES (340,52,30,1); -- ROAM_RATE: 30
INSERT INTO `mob_species_mods` VALUES (340,62,10,0); -- ATTP: 10

-- Hecteyes
INSERT INTO `mob_species_mods` VALUES (7,36,55,1); -- ROAM_COOL: 55
INSERT INTO `mob_species_mods` VALUES (7,52,30,1); -- ROAM_RATE: 30
INSERT INTO `mob_species_mods` VALUES (7,56,-1,1); -- HP_STANDBACK: -1
INSERT INTO `mob_species_mods` VALUES (7,68,10,0); -- EVA: 10

-- Hippogryph
INSERT INTO `mob_species_mods` VALUES (187,3,50,1);  -- MP_BASE: 50
INSERT INTO `mob_species_mods` VALUES (187,36,55,1); -- ROAM_COOL: 55
INSERT INTO `mob_species_mods` VALUES (187,51,2,1);  -- ROAM_TURNS: 2

-- Hound
INSERT INTO `mob_species_mods` VALUES (409,36,50,1); -- ROAM_COOL: 50
INSERT INTO `mob_species_mods` VALUES (409,51,3,1);  -- ROAM_TURNS: 3
INSERT INTO `mob_species_mods` VALUES (409,52,30,1); -- ROAM_RATE: 30

-- Hound

-- Humanoid-Hume
INSERT INTO `mob_species_mods` VALUES (295,4,30,1); -- SIGHT_RANGE: 30

-- Hybridelemental-Air
INSERT INTO `mob_species_mods` VALUES (257,51,3,1); -- ROAM_TURNS: 3

-- Hybridelemental-Dark
INSERT INTO `mob_species_mods` VALUES (258,51,3,1); -- ROAM_TURNS: 3

-- Hybridelemental-Earth
INSERT INTO `mob_species_mods` VALUES (262,51,3,1); -- ROAM_TURNS: 3

-- Hybridelemental-Fire
INSERT INTO `mob_species_mods` VALUES (266,51,3,1); -- ROAM_TURNS: 3

-- Hybridelemental-Ice

-- Hybridelemental-Light

-- Hybridelemental-Lightning

-- Hybridelemental-Water

-- Hydra
INSERT INTO `mob_species_mods` VALUES (222,31,5,1);  -- ROAM_DISTANCE: 5
INSERT INTO `mob_species_mods` VALUES (222,36,55,1); -- ROAM_COOL: 55

-- Hydra

-- Imp
INSERT INTO `mob_species_mods` VALUES (212,10,13,1); -- SUBLINK: 13 (Imps)
INSERT INTO `mob_species_mods` VALUES (212,29,24,0); -- MDEF: 24
INSERT INTO `mob_species_mods` VALUES (212,36,50,1); -- ROAM_COOL: 50
INSERT INTO `mob_species_mods` VALUES (212,51,3,1);  -- ROAM_TURNS: 3
INSERT INTO `mob_species_mods` VALUES (212,56,-1,1); -- HP_STANDBACK: -1
INSERT INTO `mob_species_mods` VALUES (212,4,10,1);  -- SIGHT_RANGE: 10
INSERT INTO `mob_species_mods` VALUES (212,5,5,1);   -- SOUND_RANGE: 5

-- Imp

-- Kindred: https://www.bg-wiki.com/ffxi/Category:Demon
INSERT INTO `mob_species_mods` VALUES (201,10,1,1);      -- SUBLINK: 1 (Kindred, Tauri)
INSERT INTO `mob_species_mods` VALUES (201,11,15,1);     -- LINK_RADIUS: 15
INSERT INTO `mob_species_mods` VALUES (201,29,25,0);     -- MDEF: 25
INSERT INTO `mob_species_mods` VALUES (201,31,15,1);     -- ROAM_DISTANCE: 15
INSERT INTO `mob_species_mods` VALUES (201,36,50,1);     -- ROAM_COOL: 50
INSERT INTO `mob_species_mods` VALUES (201,51,3,1);      -- ROAM_TURNS: 3
INSERT INTO `mob_species_mods` VALUES (201,54,120,1);    -- GIL_BONUS: 120
INSERT INTO `mob_species_mods` VALUES (201,389,-2500,0); -- UDMGMAGIC: -2500

-- Lamiae: https://www.bg-wiki.com/ffxi/Category:Lamiae
INSERT INTO `mob_species_mods` VALUES (129,10,10,1);     -- SUBLINK: 10 (Lamiae)
INSERT INTO `mob_species_mods` VALUES (129,29,13,0);     -- MDEF: 13
INSERT INTO `mob_species_mods` VALUES (129,389,-1250,0); -- UDMGMAGIC: -1250

-- Leech
INSERT INTO `mob_species_mods` VALUES (8,31,15,1); -- ROAM_DISTANCE: 15

-- Lizard
INSERT INTO `mob_species_mods` VALUES (306,36,60,1); -- ROAM_COOL: 60
INSERT INTO `mob_species_mods` VALUES (306,51,4,1);  -- ROAM_TURNS: 4
INSERT INTO `mob_species_mods` VALUES (306,52,30,1); -- ROAM_RATE: 30

-- Magic Pot: https://www.bg-wiki.com/ffxi/Category:Magic_Pot
INSERT INTO `mob_species_mods` VALUES (69,31,5,1);      -- ROAM_DISTANCE: 5
INSERT INTO `mob_species_mods` VALUES (69,36,55,1);     -- ROAM_COOL: 55
INSERT INTO `mob_species_mods` VALUES (69,52,30,1);     -- ROAM_RATE: 30
INSERT INTO `mob_species_mods` VALUES (69,389,-5000,0); -- UDMGMAGIC: -5000

-- Mamool Ja
INSERT INTO `mob_species_mods` VALUES (132,10,8,1);  -- SUBLINK: 8 (Mamool Ja, Sahagin)
INSERT INTO `mob_species_mods` VALUES (132,68,10,0); -- EVA: 10

-- Manticore
INSERT INTO `mob_species_mods` VALUES (98,31,30,1); -- ROAM_DISTANCE: 30
INSERT INTO `mob_species_mods` VALUES (98,36,60,1); -- ROAM_COOL: 60
INSERT INTO `mob_species_mods` VALUES (98,51,4,1);  -- ROAM_TURNS: 4
INSERT INTO `mob_species_mods` VALUES (98,52,30,1); -- ROAM_RATE: 30
INSERT INTO `mob_species_mods` VALUES (98,62,10,0); -- ATTP: 10
INSERT INTO `mob_species_mods` VALUES (98,3,50,0);  -- HPP: 50

-- Marid
INSERT INTO `mob_species_mods` VALUES (99,36,30,1); -- ROAM_COOL: 30
INSERT INTO `mob_species_mods` VALUES (99,51,2,1);  -- ROAM_TURNS: 2
INSERT INTO `mob_species_mods` VALUES (99,52,30,1); -- ROAM_RATE: 30
INSERT INTO `mob_species_mods` VALUES (99,63,20,0); -- DEFP: 20

-- Merrow
INSERT INTO `mob_species_mods` VALUES (131,10,10,1); -- SUBLINK: 10 (Lamiae)

-- Moblin
INSERT INTO `mob_species_mods` VALUES (127,10,5,1); -- SUBLINK: 5 (Bugbear, Goblin, Moblin)

-- Morbol
INSERT INTO `mob_species_mods` VALUES (353,36,30,1); -- ROAM_COOL: 30
INSERT INTO `mob_species_mods` VALUES (353,52,30,1); -- ROAM_RATE: 30

-- Opo-Opo
INSERT INTO `mob_species_mods` VALUES (100,36,35,1); -- ROAM_COOL: 35
INSERT INTO `mob_species_mods` VALUES (100,51,3,1);  -- ROAM_TURNS: 3
INSERT INTO `mob_species_mods` VALUES (100,52,20,1); -- ROAM_RATE: 20

-- Orc
INSERT INTO `mob_species_mods` VALUES (139,10,2,1); -- SUBLINK: 2 (Orc, Orc Warmachine)
INSERT INTO `mob_species_mods` VALUES (139,3,5,0);  -- HPP: 5

-- Orc-Warmachine
INSERT INTO `mob_species_mods` VALUES (143,10,2,1);  -- SUBLINK: 2 (Orc, Orc Warmachine)
INSERT INTO `mob_species_mods` VALUES (143,36,50,1); -- ROAM_COOL: 50
INSERT INTO `mob_species_mods` VALUES (143,52,30,1); -- ROAM_RATE: 30
INSERT INTO `mob_species_mods` VALUES (143,3,5,0);   -- HPP: 5

-- Wyvern-Pet
INSERT INTO `mob_species_mods` VALUES (236,3,40,1); -- MP_BASE: 40

-- Phuabo
INSERT INTO `mob_species_mods` VALUES (323,3,50,1); -- MP_BASE: 50

-- Qiqirn
INSERT INTO `mob_species_mods` VALUES (147,10,12,1); -- SUBLINK: 12 (Qiqirn)

-- Quadav
INSERT INTO `mob_species_mods` VALUES (150,3,-5,0); -- HPP: -5

-- Qutrub
INSERT INTO `mob_species_mods` VALUES (414,36,50,1); -- ROAM_COOL: 50
INSERT INTO `mob_species_mods` VALUES (414,51,3,1);  -- ROAM_TURNS: 3
INSERT INTO `mob_species_mods` VALUES (414,52,30,1); -- ROAM_RATE: 30

-- Rabbit
INSERT INTO `mob_species_mods` VALUES (106,31,15,1); -- ROAM_DISTANCE: 15
INSERT INTO `mob_species_mods` VALUES (106,36,35,1); -- ROAM_COOL: 35
INSERT INTO `mob_species_mods` VALUES (106,51,3,1);  -- ROAM_TURNS: 3
INSERT INTO `mob_species_mods` VALUES (106,52,30,1); -- ROAM_RATE: 30

-- Rafflesia
INSERT INTO `mob_species_mods` VALUES (359,3,50,1); -- MP_BASE: 50

-- Ram
INSERT INTO `mob_species_mods` VALUES (108,36,60,1); -- ROAM_COOL: 60
INSERT INTO `mob_species_mods` VALUES (108,52,30,1); -- ROAM_RATE: 30
INSERT INTO `mob_species_mods` VALUES (108,62,10,0); -- ATTP: 10
INSERT INTO `mob_species_mods` VALUES (108,63,20,0); -- DEFP: 20

-- Rampart
INSERT INTO `mob_species_mods` VALUES (84,10,15,1); -- SUBLINK: 15 (Chariot, Gear, Rampart)

-- Raptor
INSERT INTO `mob_species_mods` VALUES (315,31,30,1); -- ROAM_DISTANCE: 30
INSERT INTO `mob_species_mods` VALUES (315,36,40,1); -- ROAM_COOL: 40
INSERT INTO `mob_species_mods` VALUES (315,51,3,1);  -- ROAM_TURNS: 3

-- Sabotender
INSERT INTO `mob_species_mods` VALUES (334,10,7,1);  -- SUBLINK: 7 (Sabotender)
INSERT INTO `mob_species_mods` VALUES (334,36,10,1); -- ROAM_COOL: 10
INSERT INTO `mob_species_mods` VALUES (334,52,20,1); -- ROAM_RATE: 20

-- Sahagin
INSERT INTO `mob_species_mods` VALUES (151,10,8,1);   -- SUBLINK: 8 (Mamool Ja, Sahagin)
INSERT INTO `mob_species_mods` VALUES (151,20,128,0); -- WATER_MEVA: 128

-- Sapling
INSERT INTO `mob_species_mods` VALUES (360,10,4,1);  -- SUBLINK: 4 (Sapling, Treant)
INSERT INTO `mob_species_mods` VALUES (360,31,20,1); -- ROAM_DISTANCE: 20

-- Scorpion
INSERT INTO `mob_species_mods` VALUES (460,23,256,1); -- IMMUNITY: 256
INSERT INTO `mob_species_mods` VALUES (460,36,55,1);  -- ROAM_COOL: 55
INSERT INTO `mob_species_mods` VALUES (460,52,30,1);  -- ROAM_RATE: 30
INSERT INTO `mob_species_mods` VALUES (460,62,20,0);  -- ATTP: 20

-- Sea Monk
INSERT INTO `mob_species_mods` VALUES (42,36,30,1); -- ROAM_COOL: 30

-- Sea Monk

-- Shadow
INSERT INTO `mob_species_mods` VALUES (415,36,50,1); -- ROAM_COOL: 50
INSERT INTO `mob_species_mods` VALUES (415,51,2,1);  -- ROAM_TURNS: 2
INSERT INTO `mob_species_mods` VALUES (415,52,30,1); -- ROAM_RATE: 30

-- Sheep
INSERT INTO `mob_species_mods` VALUES (111,31,15,1); -- ROAM_DISTANCE: 15
INSERT INTO `mob_species_mods` VALUES (111,36,60,1); -- ROAM_COOL: 60
INSERT INTO `mob_species_mods` VALUES (111,51,5,1);  -- ROAM_TURNS: 5
INSERT INTO `mob_species_mods` VALUES (111,52,30,1); -- ROAM_RATE: 30

-- Skeleton
INSERT INTO `mob_species_mods` VALUES (419,36,65,1); -- ROAM_COOL: 65
INSERT INTO `mob_species_mods` VALUES (419,51,5,1);  -- ROAM_TURNS: 5
INSERT INTO `mob_species_mods` VALUES (419,52,30,1); -- ROAM_RATE: 30

-- Snoll
INSERT INTO `mob_species_mods` VALUES (48,36,40,1); -- ROAM_COOL: 40
INSERT INTO `mob_species_mods` VALUES (48,51,2,1);  -- ROAM_TURNS: 2
INSERT INTO `mob_species_mods` VALUES (48,52,20,1); -- ROAM_RATE: 20

-- Soulflayer
INSERT INTO `mob_species_mods` VALUES (215,10,11,1); -- SUBLINK: 11 (Soulflayers)
INSERT INTO `mob_species_mods` VALUES (215,36,50,1); -- ROAM_COOL: 50
INSERT INTO `mob_species_mods` VALUES (215,51,3,1);  -- ROAM_TURNS: 3

-- Spheroid
INSERT INTO `mob_species_mods` VALUES (74,37,1,1); -- ALWAYS_AGGRO: 1

-- Structure
INSERT INTO `mob_species_mods` VALUES (370,4,30,1); -- SIGHT_RANGE: 30

-- Tauri
INSERT INTO `mob_species_mods` VALUES (217,10,1,1);  -- SUBLINK: 1 (Kindred, Tauri)
INSERT INTO `mob_species_mods` VALUES (217,36,40,1); -- ROAM_COOL: 40
INSERT INTO `mob_species_mods` VALUES (217,51,3,1);  -- ROAM_TURNS: 3
INSERT INTO `mob_species_mods` VALUES (217,52,30,1); -- ROAM_RATE: 30

-- Tiger
INSERT INTO `mob_species_mods` VALUES (114,31,15,1); -- ROAM_DISTANCE: 15
INSERT INTO `mob_species_mods` VALUES (114,36,45,1); -- ROAM_COOL: 45
INSERT INTO `mob_species_mods` VALUES (114,51,3,1);  -- ROAM_TURNS: 3
INSERT INTO `mob_species_mods` VALUES (114,62,10,0); -- ATTP: 10

-- Tonberry
INSERT INTO `mob_species_mods` VALUES (159,36,25,1); -- ROAM_COOL: 25
INSERT INTO `mob_species_mods` VALUES (159,51,5,1);  -- ROAM_TURNS: 5
INSERT INTO `mob_species_mods` VALUES (159,52,30,1); -- ROAM_RATE: 30

-- Treant
INSERT INTO `mob_species_mods` VALUES (366,10,4,1);  -- SUBLINK: 4 (Sapling, Treant)
INSERT INTO `mob_species_mods` VALUES (366,36,65,1); -- ROAM_COOL: 65
INSERT INTO `mob_species_mods` VALUES (366,52,30,1); -- ROAM_RATE: 30
INSERT INTO `mob_species_mods` VALUES (366,63,20,0); -- DEFP: 20

-- Troll
INSERT INTO `mob_species_mods` VALUES (163,10,9,1); -- SUBLINK: 9 (Trolls)
INSERT INTO `mob_species_mods` VALUES (163,3,50,0); -- HPP: 50

-- Uragnite
INSERT INTO `mob_species_mods` VALUES (44,36,40,1); -- ROAM_COOL: 40
INSERT INTO `mob_species_mods` VALUES (44,52,30,1); -- ROAM_RATE: 30

-- Wamoura
INSERT INTO `mob_species_mods` VALUES (470,3,50,1); -- MP_BASE: 50
INSERT INTO `mob_species_mods` VALUES (470,10,6,1); -- SUBLINK: 6 (Wamoura, Wamouracampa)

-- Wamouracampa
INSERT INTO `mob_species_mods` VALUES (471,10,6,1); -- SUBLINK: 6 (Wamouracampa, Brassborer)

-- Wanderer
INSERT INTO `mob_species_mods` VALUES (290,3,50,1); -- MP_BASE: 50

-- Wivre
INSERT INTO `mob_species_mods` VALUES (319,36,50,1); -- ROAM_COOL: 50
INSERT INTO `mob_species_mods` VALUES (319,52,30,1); -- ROAM_RATE: 30

-- Worm
INSERT INTO `mob_species_mods` VALUES (23,34,25,1); -- MAGIC_COOL: 25
INSERT INTO `mob_species_mods` VALUES (23,36,90,1); -- ROAM_COOL: 90
INSERT INTO `mob_species_mods` VALUES (23,52,30,1); -- ROAM_RATE: 30

-- Wyrm-Ouryu
INSERT INTO `mob_species_mods` VALUES (225,36,55,1); -- ROAM_COOL: 55

-- Wyvern-Simorg
INSERT INTO `mob_species_mods` VALUES (235,36,55,1); -- ROAM_COOL: 55

-- Yovra
INSERT INTO `mob_species_mods` VALUES (327,3,50,1); -- MP_BASE: 50

-- Zdei
INSERT INTO `mob_species_mods` VALUES (331,4,10,1);   -- SIGHT_RANGE: 10
INSERT INTO `mob_species_mods` VALUES (331,102,60,1); -- MOBMOD_SIGHT_ANGLE

-- Vampyr
INSERT INTO `mob_species_mods` VALUES (421,10,3,1);  -- SUBLINK: 3 (Single Bat, Bat Trio, Vampyr)
INSERT INTO `mob_species_mods` VALUES (421,36,50,1); -- ROAM_COOL: 50
INSERT INTO `mob_species_mods` VALUES (421,51,2,1);  -- ROAM_TURNS: 2
INSERT INTO `mob_species_mods` VALUES (421,52,30,1); -- ROAM_RATE: 30

-- Sabotender-Florido
INSERT INTO `mob_species_mods` VALUES (335,10,7,1); -- SUBLINK: 7 (Sabotender)

-- Lamiae
INSERT INTO `mob_species_mods` VALUES (130,10,10,1); -- SUBLINK: 10 (Lamiae)

-- Apkallu
INSERT INTO `mob_species_mods` VALUES (171,4,5,1); -- SIGHT_RANGE: 5

-- Flan
INSERT INTO `mob_species_mods` VALUES (5,56,-1,1); -- HP_STANDBACK: -1
INSERT INTO `mob_species_mods` VALUES (5,69,1,1);  -- NO_LINK: 1

/*!40000 ALTER TABLE `mob_species_mods` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
