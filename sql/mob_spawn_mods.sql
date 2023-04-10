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
-- Table structure for table `mob_spawn_mods`
--

DROP TABLE IF EXISTS `mob_spawn_mods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mob_spawn_mods` (
  `mobid` int(10) unsigned NOT NULL,
  `modid` smallint(5) unsigned NOT NULL,
  `value` smallint(5) NOT NULL DEFAULT '0',
  `is_mob_mod` boolean NOT NULL DEFAULT '0',
  PRIMARY KEY (`mobid`,`modid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 AVG_ROW_LENGTH=13 PACK_KEYS=1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mob_spawn_mods`
--

LOCK TABLES `mob_spawn_mods` WRITE;
/*!40000 ALTER TABLE `mob_spawn_mods` DISABLE KEYS */;

-- Overgrown Ivy
INSERT INTO `mob_spawn_mods` VALUES (16785709,55,180,1); -- IDLE_DESPAWN: 180

-- Cryptonberry Executor
INSERT INTO `mob_spawn_mods` VALUES (16785710,55,180,1); -- IDLE_DESPAWN: 180

-- Cryptonberry Assassin
INSERT INTO `mob_spawn_mods` VALUES (16785711,55,420,1); -- IDLE_DESPAWN: 420

-- Cryptonberry Assassin
INSERT INTO `mob_spawn_mods` VALUES (16785712,55,420,1); -- IDLE_DESPAWN: 420

-- Cryptonberry Assassin
INSERT INTO `mob_spawn_mods` VALUES (16785713,55,420,1); -- IDLE_DESPAWN: 420

-- Mycophile
INSERT INTO `mob_spawn_mods` VALUES (16785722,55,300,1); -- IDLE_DESPAWN: 300

-- Dalham
INSERT INTO `mob_spawn_mods` VALUES (16793858,55,180,1); -- IDLE_DESPAWN: 180

-- Shen
INSERT INTO `mob_spawn_mods` VALUES (16793859,55,180,1); -- IDLE_DESPAWN: 180

-- Shen'S Filtrate
INSERT INTO `mob_spawn_mods` VALUES (16793860,55,180,1); -- IDLE_DESPAWN: 180

-- Shen'S Filtrate
INSERT INTO `mob_spawn_mods` VALUES (16793861,55,180,1); -- IDLE_DESPAWN: 180

-- Jormungand
INSERT INTO `mob_spawn_mods` VALUES (16797969,12,15,1); -- DRAW_IN: 15

-- Geush Urvan
INSERT INTO `mob_spawn_mods` VALUES (16798078,55,1800,1); -- IDLE_DESPAWN: 1800

-- Lioumere
INSERT INTO `mob_spawn_mods` VALUES (16806031,55,180,1); -- IDLE_DESPAWN: 180

-- Sargas
INSERT INTO `mob_spawn_mods` VALUES (16806117,288,40,0); -- DOUBLE_ATTACK: 40

-- Xolotl
INSERT INTO `mob_spawn_mods` VALUES (16806215,26,32,1); -- SUPERLINK: 32

-- Xolotl'S Hound Warrior
INSERT INTO `mob_spawn_mods` VALUES (16806216,26,32,1); -- SUPERLINK: 32

-- Xolotl'S Sacrifice
INSERT INTO `mob_spawn_mods` VALUES (16806217,26,32,1); -- SUPERLINK: 32

-- Tiamat
INSERT INTO `mob_spawn_mods` VALUES (16806227,12,8,1); -- DRAW_IN: 8

-- Feeler Antlion
INSERT INTO `mob_spawn_mods` VALUES (16806242,55,120,1); -- IDLE_DESPAWN: 120

-- Executioner Antlion
INSERT INTO `mob_spawn_mods` VALUES (16806243,55,120,1); -- IDLE_DESPAWN: 120

-- Executioner Antlion
INSERT INTO `mob_spawn_mods` VALUES (16806244,55,120,1); -- IDLE_DESPAWN: 120

-- Executioner Antlion
INSERT INTO `mob_spawn_mods` VALUES (16806245,55,120,1); -- IDLE_DESPAWN: 120

-- Executioner Antlion
INSERT INTO `mob_spawn_mods` VALUES (16806246,55,120,1); -- IDLE_DESPAWN: 120

-- Executioner Antlion
INSERT INTO `mob_spawn_mods` VALUES (16806247,55,120,1); -- IDLE_DESPAWN: 120

-- Gargoyle
INSERT INTO `mob_spawn_mods` VALUES (16814081,55,120,1); -- IDLE_DESPAWN: 120

-- Gargoyle
INSERT INTO `mob_spawn_mods` VALUES (16814082,55,120,1); -- IDLE_DESPAWN: 120

-- Gargoyle
INSERT INTO `mob_spawn_mods` VALUES (16814083,55,120,1); -- IDLE_DESPAWN: 120

-- Gargoyle
INSERT INTO `mob_spawn_mods` VALUES (16814084,55,120,1); -- IDLE_DESPAWN: 120

-- Gargoyle
INSERT INTO `mob_spawn_mods` VALUES (16814085,55,120,1); -- IDLE_DESPAWN: 120

-- Gargoyle
INSERT INTO `mob_spawn_mods` VALUES (16814086,55,120,1); -- IDLE_DESPAWN: 120

-- Gargoyle
INSERT INTO `mob_spawn_mods` VALUES (16814087,55,120,1); -- IDLE_DESPAWN: 120

-- Gargoyle
INSERT INTO `mob_spawn_mods` VALUES (16814088,55,120,1); -- IDLE_DESPAWN: 120

-- Gargoyle
INSERT INTO `mob_spawn_mods` VALUES (16814089,55,120,1); -- IDLE_DESPAWN: 120

-- Gargoyle
INSERT INTO `mob_spawn_mods` VALUES (16814090,55,120,1); -- IDLE_DESPAWN: 120

-- Gargoyle
INSERT INTO `mob_spawn_mods` VALUES (16814091,55,120,1); -- IDLE_DESPAWN: 120

-- Gargoyle
INSERT INTO `mob_spawn_mods` VALUES (16814092,55,120,1); -- IDLE_DESPAWN: 120

-- Gargoyle
INSERT INTO `mob_spawn_mods` VALUES (16814093,55,120,1); -- IDLE_DESPAWN: 120

-- Gargoyle
INSERT INTO `mob_spawn_mods` VALUES (16814094,55,120,1); -- IDLE_DESPAWN: 120

-- Gargoyle
INSERT INTO `mob_spawn_mods` VALUES (16814095,55,120,1); -- IDLE_DESPAWN: 120

-- Gargoyle
INSERT INTO `mob_spawn_mods` VALUES (16814096,55,120,1); -- IDLE_DESPAWN: 120

-- Nunyunuwi
INSERT INTO `mob_spawn_mods` VALUES (16814361,55,240,1); -- IDLE_DESPAWN: 240

-- Golden-Tongued Culberry
INSERT INTO `mob_spawn_mods` VALUES (16814432,1,18000,1); -- GIL_MIN: 18000
INSERT INTO `mob_spawn_mods` VALUES (16814432,2,19800,1); -- GIL_MAX: 19800
INSERT INTO `mob_spawn_mods` VALUES (16814432,9,80,1);    -- HP_HEAL_CHANCE: 80
INSERT INTO `mob_spawn_mods` VALUES (16814432,29,33,0);   -- MDEF: 33
INSERT INTO `mob_spawn_mods` VALUES (16814432,55,900,1);  -- IDLE_DESPAWN: 900
INSERT INTO `mob_spawn_mods` VALUES (16814432,168,2,0);   -- SPELLINTERRUPT: 2
INSERT INTO `mob_spawn_mods` VALUES (16814432,170,50,0);  -- FASTCAST: 50

-- Goblin Wolfman
INSERT INTO `mob_spawn_mods` VALUES (16822459,55,300,1); -- IDLE_DESPAWN: 300

-- Mimic
INSERT INTO `mob_spawn_mods` VALUES (16826564,55,120,1); -- IDLE_DESPAWN: 120

-- Bugbear Matman
INSERT INTO `mob_spawn_mods` VALUES (16826570,55,300,1); -- IDLE_DESPAWN: 300

-- Ponderer
INSERT INTO `mob_spawn_mods` VALUES (16867329,55,240,1); -- IDLE_DESPAWN: 240

-- Propagator
INSERT INTO `mob_spawn_mods` VALUES (16867330,55,240,1); -- IDLE_DESPAWN: 240

-- Solicitor
INSERT INTO `mob_spawn_mods` VALUES (16867333,55,240,1); -- IDLE_DESPAWN: 240

-- Wanderer
INSERT INTO `mob_spawn_mods` VALUES (16867455,55,180,1); -- IDLE_DESPAWN: 180

-- Weeper
INSERT INTO `mob_spawn_mods` VALUES (16867544,55,180,1); -- IDLE_DESPAWN: 180

-- Weeper
INSERT INTO `mob_spawn_mods` VALUES (16867642,55,180,1); -- IDLE_DESPAWN: 180

-- Splinterspine Grukjuk
INSERT INTO `mob_spawn_mods` VALUES (16875774,55,120,1); -- IDLE_DESPAWN: 120

-- Kurrea
INSERT INTO `mob_spawn_mods` VALUES (16875778,55,120,1); -- IDLE_DESPAWN: 120

-- Amaltheia
INSERT INTO `mob_spawn_mods` VALUES (16875779,55,120,1); -- IDLE_DESPAWN: 120

-- Warder Aglaia
INSERT INTO `mob_spawn_mods` VALUES (16879893,55,180,1); -- IDLE_DESPAWN: 180

-- Warder Euphrosyne
INSERT INTO `mob_spawn_mods` VALUES (16879894,55,180,1); -- IDLE_DESPAWN: 180

-- Warder Thalia
INSERT INTO `mob_spawn_mods` VALUES (16879895,55,180,1); -- IDLE_DESPAWN: 180

-- Boggelmann
INSERT INTO `mob_spawn_mods` VALUES (16879897,55,180,1); -- IDLE_DESPAWN: 180

-- Gration
INSERT INTO `mob_spawn_mods` VALUES (16879899,55,900,1); -- IDLE_DESPAWN: 900

-- Minotaur
INSERT INTO `mob_spawn_mods` VALUES (16887889,12,15,1); -- DRAW_IN: 15

-- Old Professor Mariselle
INSERT INTO `mob_spawn_mods` VALUES (16891970,55,300,1); -- IDLE_DESPAWN: 300

-- Balor
INSERT INTO `mob_spawn_mods` VALUES (16892068,55,180,1); -- IDLE_DESPAWN: 180

-- Luaith
INSERT INTO `mob_spawn_mods` VALUES (16892069,55,180,1); -- IDLE_DESPAWN: 180

-- Lobais
INSERT INTO `mob_spawn_mods` VALUES (16892070,55,180,1); -- IDLE_DESPAWN: 180

-- Caithleann
INSERT INTO `mob_spawn_mods` VALUES (16892073,55,180,1); -- IDLE_DESPAWN: 180

-- Indich
INSERT INTO `mob_spawn_mods` VALUES (16892074,55,180,1); -- IDLE_DESPAWN: 180

-- Vrtra
INSERT INTO `mob_spawn_mods` VALUES (16896161,12,15,1); -- DRAW_IN: 15

-- Ouryu
INSERT INTO `mob_spawn_mods` VALUES (16900314,12,15,1); -- DRAW_IN: 15

-- Ul'Xzomit
INSERT INTO `mob_spawn_mods` VALUES (16912394,31,25,1); -- ROAM_DISTANCE: 25
INSERT INTO `mob_spawn_mods` VALUES (16912394,71,2,1);  -- LEADER: 2

-- Ul'Xzomit
INSERT INTO `mob_spawn_mods` VALUES (16912409,31,25,1); -- ROAM_DISTANCE: 25
INSERT INTO `mob_spawn_mods` VALUES (16912409,71,2,1);  -- LEADER: 2

-- Ul'Xzomit
INSERT INTO `mob_spawn_mods` VALUES (16912422,31,25,1); -- ROAM_DISTANCE: 25
INSERT INTO `mob_spawn_mods` VALUES (16912422,71,2,1);  -- LEADER: 2

-- Ul'Xzomit
INSERT INTO `mob_spawn_mods` VALUES (16912426,31,25,1); -- ROAM_DISTANCE: 25
INSERT INTO `mob_spawn_mods` VALUES (16912426,71,2,1);  -- LEADER: 2

-- Ul'Xzomit
INSERT INTO `mob_spawn_mods` VALUES (16912429,31,25,1); -- ROAM_DISTANCE: 25
INSERT INTO `mob_spawn_mods` VALUES (16912429,71,2,1);  -- LEADER: 2

-- Ul'Xzomit
INSERT INTO `mob_spawn_mods` VALUES (16912432,31,25,1); -- ROAM_DISTANCE: 25
INSERT INTO `mob_spawn_mods` VALUES (16912432,71,2,1);  -- LEADER: 2

-- Ul'Xzomit
INSERT INTO `mob_spawn_mods` VALUES (16912435,31,25,1); -- ROAM_DISTANCE: 25
INSERT INTO `mob_spawn_mods` VALUES (16912435,71,2,1);  -- LEADER: 2

-- Ul'Xzomit
INSERT INTO `mob_spawn_mods` VALUES (16912443,31,25,1); -- ROAM_DISTANCE: 25
INSERT INTO `mob_spawn_mods` VALUES (16912443,71,2,1);  -- LEADER: 2

-- Ul'Xzomit
INSERT INTO `mob_spawn_mods` VALUES (16912446,31,25,1); -- ROAM_DISTANCE: 25
INSERT INTO `mob_spawn_mods` VALUES (16912446,71,2,1);  -- LEADER: 2

-- Ul'Xzomit
INSERT INTO `mob_spawn_mods` VALUES (16912449,31,25,1); -- ROAM_DISTANCE: 25
INSERT INTO `mob_spawn_mods` VALUES (16912449,71,2,1);  -- LEADER: 2

-- Ul'Xzomit
INSERT INTO `mob_spawn_mods` VALUES (16912452,31,25,1); -- ROAM_DISTANCE: 25
INSERT INTO `mob_spawn_mods` VALUES (16912452,71,2,1);  -- LEADER: 2

-- Ul'Xzomit
INSERT INTO `mob_spawn_mods` VALUES (16912455,31,25,1); -- ROAM_DISTANCE: 25
INSERT INTO `mob_spawn_mods` VALUES (16912455,71,2,1);  -- LEADER: 2

-- Ul'Xzomit
INSERT INTO `mob_spawn_mods` VALUES (16912468,31,25,1); -- ROAM_DISTANCE: 25
INSERT INTO `mob_spawn_mods` VALUES (16912468,71,2,1);  -- LEADER: 2

-- Ul'Xzomit
INSERT INTO `mob_spawn_mods` VALUES (16912545,31,25,1); -- ROAM_DISTANCE: 25
INSERT INTO `mob_spawn_mods` VALUES (16912545,71,2,1);  -- LEADER: 2

-- Ul'Xzomit
INSERT INTO `mob_spawn_mods` VALUES (16912548,31,25,1); -- ROAM_DISTANCE: 25
INSERT INTO `mob_spawn_mods` VALUES (16912548,71,2,1);  -- LEADER: 2

-- Ru'Aern
INSERT INTO `mob_spawn_mods` VALUES (16912829,55,180,1); -- IDLE_DESPAWN: 180

-- Ru'Aern
INSERT INTO `mob_spawn_mods` VALUES (16912830,55,180,1); -- IDLE_DESPAWN: 180

-- Ru'Aern
INSERT INTO `mob_spawn_mods` VALUES (16912831,55,180,1); -- IDLE_DESPAWN: 180

-- Ru'Aern
INSERT INTO `mob_spawn_mods` VALUES (16912832,55,180,1); -- IDLE_DESPAWN: 180

-- Ru'Aern
INSERT INTO `mob_spawn_mods` VALUES (16912833,55,180,1); -- IDLE_DESPAWN: 180

-- Ru'Aern
INSERT INTO `mob_spawn_mods` VALUES (16912834,55,180,1); -- IDLE_DESPAWN: 180

-- Ru'Aern
INSERT INTO `mob_spawn_mods` VALUES (16912835,55,180,1); -- IDLE_DESPAWN: 180

-- Ru'Aern
INSERT INTO `mob_spawn_mods` VALUES (16912836,55,180,1); -- IDLE_DESPAWN: 180

-- Ru'Aern
INSERT INTO `mob_spawn_mods` VALUES (16912837,55,180,1); -- IDLE_DESPAWN: 180

-- Jailer Of Hope
INSERT INTO `mob_spawn_mods` VALUES (16912838,7,60,1);    -- GA_CHANCE: 60
INSERT INTO `mob_spawn_mods` VALUES (16912838,55,300,1);  -- IDLE_DESPAWN: 300
INSERT INTO `mob_spawn_mods` VALUES (16912838,407,150,0); -- UFASTCAST: 150

-- Jailer Of Justice
INSERT INTO `mob_spawn_mods` VALUES (16912839,55,300,1); -- IDLE_DESPAWN: 300

-- Jailer Of Prudence
INSERT INTO `mob_spawn_mods` VALUES (16912846,55,300,1); -- IDLE_DESPAWN: 300

-- Jailer Of Prudence
INSERT INTO `mob_spawn_mods` VALUES (16912847,55,300,1); -- IDLE_DESPAWN: 300

-- Jailer Of Love
INSERT INTO `mob_spawn_mods` VALUES (16912848,55,300,1); -- IDLE_DESPAWN: 300

-- Ix'Ghrah
INSERT INTO `mob_spawn_mods` VALUES (16916813,55,180,1); -- IDLE_DESPAWN: 180

-- Jailer Of Temperance
INSERT INTO `mob_spawn_mods` VALUES (16916814,55,300,1); -- IDLE_DESPAWN: 300

-- Ix'Aern
INSERT INTO `mob_spawn_mods` VALUES (16916815,55,300,1); -- IDLE_DESPAWN: 300

-- Qn'Aern
INSERT INTO `mob_spawn_mods` VALUES (16916816,55,300,1); -- IDLE_DESPAWN: 300

-- Qn'Aern
INSERT INTO `mob_spawn_mods` VALUES (16916817,55,300,1); -- IDLE_DESPAWN: 300

-- Qn'Zdei
INSERT INTO `mob_spawn_mods` VALUES (16920577, 26, 1000, 1); -- SUBLINK: 1000
INSERT INTO `mob_spawn_mods` VALUES (16920578, 26, 1000, 1); -- SUBLINK: 1000
INSERT INTO `mob_spawn_mods` VALUES (16920579, 26, 1000, 1); -- SUBLINK: 1000
INSERT INTO `mob_spawn_mods` VALUES (16920580, 26, 1000, 1); -- SUBLINK: 1000
INSERT INTO `mob_spawn_mods` VALUES (16920581, 26, 1001, 1); -- SUBLINK: 1001
INSERT INTO `mob_spawn_mods` VALUES (16920582, 26, 1001, 1); -- SUBLINK: 1001
INSERT INTO `mob_spawn_mods` VALUES (16920583, 26, 1001, 1); -- SUBLINK: 1001
INSERT INTO `mob_spawn_mods` VALUES (16920584, 26, 1001, 1); -- SUBLINK: 1001
INSERT INTO `mob_spawn_mods` VALUES (16920585, 26, 1002, 1); -- SUBLINK: 1002
INSERT INTO `mob_spawn_mods` VALUES (16920586, 26, 1002, 1); -- SUBLINK: 1002
INSERT INTO `mob_spawn_mods` VALUES (16920587, 26, 1002, 1); -- SUBLINK: 1002
INSERT INTO `mob_spawn_mods` VALUES (16920588, 26, 1002, 1); -- SUBLINK: 1002
INSERT INTO `mob_spawn_mods` VALUES (16920764, 26, 1003, 1); -- SUBLINK: 1003
INSERT INTO `mob_spawn_mods` VALUES (16920765, 26, 1003, 1); -- SUBLINK: 1003
INSERT INTO `mob_spawn_mods` VALUES (16920766, 26, 1003, 1); -- SUBLINK: 1003
INSERT INTO `mob_spawn_mods` VALUES (16920767, 26, 1003, 1); -- SUBLINK: 1003

-- Jailer Of Fortitude
INSERT INTO `mob_spawn_mods` VALUES (16921015,55,180,1);  -- IDLE_DESPAWN: 180
INSERT INTO `mob_spawn_mods` VALUES (16921015,387,-95,0); -- UDMGPHYS: -95
INSERT INTO `mob_spawn_mods` VALUES (16921015,390,-95,0); -- UDMGRANGE: -95

-- Kf'Ghrah
INSERT INTO `mob_spawn_mods` VALUES (16921016,55,180,1); -- IDLE_DESPAWN: 180

-- Kf'Ghrah
INSERT INTO `mob_spawn_mods` VALUES (16921017,55,180,1); -- IDLE_DESPAWN: 180

-- Ix'Aern
INSERT INTO `mob_spawn_mods` VALUES (16921018,55,180,1); -- IDLE_DESPAWN: 180

-- Qn'Aern
INSERT INTO `mob_spawn_mods` VALUES (16921019,55,180,1); -- IDLE_DESPAWN: 180

-- Qn'Aern
INSERT INTO `mob_spawn_mods` VALUES (16921020,55,180,1); -- IDLE_DESPAWN: 180

-- Jailer Of Faith
INSERT INTO `mob_spawn_mods` VALUES (16921021,55,900,1); -- IDLE_DESPAWN: 900

-- Ix'Aern
INSERT INTO `mob_spawn_mods` VALUES (16921022,55,300,1); -- IDLE_DESPAWN: 300

-- Aern'S Wynav
INSERT INTO `mob_spawn_mods` VALUES (16921023,55,300,1); -- IDLE_DESPAWN: 300

-- Aern'S Wynav
INSERT INTO `mob_spawn_mods` VALUES (16921024,55,300,1); -- IDLE_DESPAWN: 300

-- Aern'S Wynav
INSERT INTO `mob_spawn_mods` VALUES (16921025,55,300,1); -- IDLE_DESPAWN: 300

-- Vulpangue
INSERT INTO `mob_spawn_mods` VALUES (16986428,55,180,1); -- IDLE_DESPAWN: 180

-- Iriz Ima
INSERT INTO `mob_spawn_mods` VALUES (16986429,55,180,1); -- IDLE_DESPAWN: 180

-- Gotoh Zha The Redolent
INSERT INTO `mob_spawn_mods` VALUES (16986430,55,180,1); -- IDLE_DESPAWN: 180

-- Tinnin
INSERT INTO `mob_spawn_mods` VALUES (16986431,55,180,1); -- IDLE_DESPAWN: 180

-- Lamia'S Skeleton
INSERT INTO `mob_spawn_mods` VALUES (16998869,55,180,1); -- IDLE_DESPAWN: 180

-- Lamia'S Skeleton
INSERT INTO `mob_spawn_mods` VALUES (16998870,55,180,1); -- IDLE_DESPAWN: 180

-- Lil' Apkallu
INSERT INTO `mob_spawn_mods` VALUES (16998871,55,180,1); -- IDLE_DESPAWN: 180

-- Velionis
INSERT INTO `mob_spawn_mods` VALUES (16998872,55,180,1); -- IDLE_DESPAWN: 180

-- Zareehkl The Jubilant
INSERT INTO `mob_spawn_mods` VALUES (16998873,55,180,1); -- IDLE_DESPAWN: 180

-- Nuhn
INSERT INTO `mob_spawn_mods` VALUES (16998874,55,180,1); -- IDLE_DESPAWN: 180

-- Brass Borer
INSERT INTO `mob_spawn_mods` VALUES (17027471,55,180,1); -- IDLE_DESPAWN: 180

-- Claret
INSERT INTO `mob_spawn_mods` VALUES (17027472,55,180,1); -- IDLE_DESPAWN: 180

-- Anantaboga
INSERT INTO `mob_spawn_mods` VALUES (17027473,55,180,1); -- IDLE_DESPAWN: 180

-- Khromasoul Bhurborlor
INSERT INTO `mob_spawn_mods` VALUES (17027474,55,180,1); -- IDLE_DESPAWN: 180

-- Sarameya
INSERT INTO `mob_spawn_mods` VALUES (17027485,55,180,1); -- IDLE_DESPAWN: 180

-- Big Bomb
INSERT INTO `mob_spawn_mods` VALUES (17031401,55,900,1); -- IDLE_DESPAWN: 900

-- Dextrose
INSERT INTO `mob_spawn_mods` VALUES (17031598,55,180,1); -- IDLE_DESPAWN: 180

-- Reacton
INSERT INTO `mob_spawn_mods` VALUES (17031599,55,180,1); -- IDLE_DESPAWN: 180

-- Achamoth
INSERT INTO `mob_spawn_mods` VALUES (17031600,55,180,1); -- IDLE_DESPAWN: 180

-- Mamool Ja Chamberlain
INSERT INTO `mob_spawn_mods` VALUES (17043876,55,180,1); -- IDLE_DESPAWN: 180

-- Mamool Ja Chamberlain
INSERT INTO `mob_spawn_mods` VALUES (17043877,55,180,1); -- IDLE_DESPAWN: 180

-- Mamool Ja Palatine
INSERT INTO `mob_spawn_mods` VALUES (17043878,55,180,1); -- IDLE_DESPAWN: 180

-- Mamool Ja Palatine
INSERT INTO `mob_spawn_mods` VALUES (17043879,55,180,1); -- IDLE_DESPAWN: 180

-- Chamrosh
INSERT INTO `mob_spawn_mods` VALUES (17043887,55,180,1); -- IDLE_DESPAWN: 180

-- Iriri Samariri
INSERT INTO `mob_spawn_mods` VALUES (17043888,55,180,1); -- IDLE_DESPAWN: 180

-- Nosferatu
INSERT INTO `mob_spawn_mods` VALUES (17056157,55,180,1); -- IDLE_DESPAWN: 180

-- Pandemonium Warden
INSERT INTO `mob_spawn_mods` VALUES (17056168,55,180,1); -- IDLE_DESPAWN: 180

-- Pandemonium Lamp
INSERT INTO `mob_spawn_mods` VALUES (17056170,55,180,1); -- IDLE_DESPAWN: 180

-- Pandemonium Lamp
INSERT INTO `mob_spawn_mods` VALUES (17056171,55,180,1); -- IDLE_DESPAWN: 180

-- Pandemonium Lamp
INSERT INTO `mob_spawn_mods` VALUES (17056172,55,180,1); -- IDLE_DESPAWN: 180

-- Pandemonium Lamp
INSERT INTO `mob_spawn_mods` VALUES (17056173,55,180,1); -- IDLE_DESPAWN: 180

-- Pandemonium Lamp
INSERT INTO `mob_spawn_mods` VALUES (17056174,55,180,1); -- IDLE_DESPAWN: 180

-- Pandemonium Lamp
INSERT INTO `mob_spawn_mods` VALUES (17056175,55,180,1); -- IDLE_DESPAWN: 180

-- Pandemonium Lamp
INSERT INTO `mob_spawn_mods` VALUES (17056176,55,180,1); -- IDLE_DESPAWN: 180

-- Pandemonium Lamp
INSERT INTO `mob_spawn_mods` VALUES (17056177,55,180,1); -- IDLE_DESPAWN: 180

-- Chigre
INSERT INTO `mob_spawn_mods` VALUES (17056186,55,180,1); -- IDLE_DESPAWN: 180

-- Ob
INSERT INTO `mob_spawn_mods` VALUES (17072171,55,180,1); -- IDLE_DESPAWN: 180

-- Cheese Hoarder Gigiroon
INSERT INTO `mob_spawn_mods` VALUES (17072172,55,180,1); -- IDLE_DESPAWN: 180

-- Armed Gears
INSERT INTO `mob_spawn_mods` VALUES (17072178,55,180,1); -- IDLE_DESPAWN: 180

-- Wulgaru
INSERT INTO `mob_spawn_mods` VALUES (17072179,55,180,1); -- IDLE_DESPAWN: 180

-- Verdelet
INSERT INTO `mob_spawn_mods` VALUES (17101202,55,180,1); -- IDLE_DESPAWN: 180

-- Tyger
INSERT INTO `mob_spawn_mods` VALUES (17101203,55,180,1); -- IDLE_DESPAWN: 180

-- Mahjlaef The Paintorn
INSERT INTO `mob_spawn_mods` VALUES (17101204,55,180,1); -- IDLE_DESPAWN: 180

-- Experimental Lamia
INSERT INTO `mob_spawn_mods` VALUES (17101205,55,180,1); -- IDLE_DESPAWN: 180

-- Fingerfilcher Dradzad
INSERT INTO `mob_spawn_mods` VALUES (17113462,55,180,1); -- IDLE_DESPAWN: 180

-- Cobraclaw Buchzvotch
INSERT INTO `mob_spawn_mods` VALUES (17113464,55,180,1); -- IDLE_DESPAWN: 180

-- Kinepikwa
INSERT INTO `mob_spawn_mods` VALUES (17146147,55,300,1); -- IDLE_DESPAWN: 300

-- War Lynx
INSERT INTO `mob_spawn_mods` VALUES (17170645,55,180,1); -- IDLE_DESPAWN: 180

-- Bloodlapper
INSERT INTO `mob_spawn_mods` VALUES (17174889,55,1800,1); -- IDLE_DESPAWN: 1800

-- Amanita
INSERT INTO `mob_spawn_mods` VALUES (17186927,368,33,0); -- REGAIN: 33

-- Slumbering Samwell
INSERT INTO `mob_spawn_mods` VALUES (17195221,368,33,0); -- REGAIN: 33

-- Marchelute
INSERT INTO `mob_spawn_mods` VALUES (17199566,55,300,1); -- IDLE_DESPAWN: 300

-- Doman
INSERT INTO `mob_spawn_mods` VALUES (17199567,55,300,1); -- IDLE_DESPAWN: 300

-- Onryo
INSERT INTO `mob_spawn_mods` VALUES (17199568,55,300,1); -- IDLE_DESPAWN: 300

-- King Arthro
INSERT INTO `mob_spawn_mods` VALUES (17203216,1,15000,1); -- GIL_MIN: 15000
INSERT INTO `mob_spawn_mods` VALUES (17203216,2,20000,1); -- GIL_MAX: 20000

-- Lumber Jack
INSERT INTO `mob_spawn_mods` VALUES (17207308,1,15000,1); -- GIL_MIN: 15000
INSERT INTO `mob_spawn_mods` VALUES (17207308,2,20000,1); -- GIL_MAX: 20000
INSERT INTO `mob_spawn_mods` VALUES (17207308,15,7500,1); -- MUG_GIL: 7500

-- Sturmtiger
INSERT INTO `mob_spawn_mods` VALUES (17207696,55,300,1); -- IDLE_DESPAWN: 300

-- Suparna
INSERT INTO `mob_spawn_mods` VALUES (17207697,55,600,1); -- IDLE_DESPAWN: 600

-- Suparna Fledgling
INSERT INTO `mob_spawn_mods` VALUES (17207698,55,600,1); -- IDLE_DESPAWN: 600

-- Vegnix Greenthumb
INSERT INTO `mob_spawn_mods` VALUES (17207710,55,180,1); -- IDLE_DESPAWN: 180

-- Gambilox Wanderling
INSERT INTO `mob_spawn_mods` VALUES (17211848,55,120,1); -- IDLE_DESPAWN: 120

-- Bubbly Bernie
INSERT INTO `mob_spawn_mods` VALUES (17215494,55,288,1); -- IDLE_DESPAWN: 288

-- Simurgh
INSERT INTO `mob_spawn_mods` VALUES (17228242,1,21000,1); -- GIL_MIN: 21000
INSERT INTO `mob_spawn_mods` VALUES (17228242,2,31300,1); -- GIL_MAX: 31300

-- Chuglix Berrypaws
INSERT INTO `mob_spawn_mods` VALUES (17228249,55,180,1); -- IDLE_DESPAWN: 180

-- Shadow Dragon
INSERT INTO `mob_spawn_mods` VALUES (17235987,1,1076,1); -- GIL_MIN: 1076
INSERT INTO `mob_spawn_mods` VALUES (17235987,2,2765,1); -- GIL_MAX: 2765

-- Chaos Elemental
INSERT INTO `mob_spawn_mods` VALUES (17236201,55,180,1); -- IDLE_DESPAWN: 180

-- Boreal Hound
INSERT INTO `mob_spawn_mods` VALUES (17236202,12,15,1);  -- DRAW_IN: 15
INSERT INTO `mob_spawn_mods` VALUES (17236202,160,50,0); -- DMG: 50
INSERT INTO `mob_spawn_mods` VALUES (17236202,169,10,0); -- MOVE: 10

-- Boreal Coeurl
INSERT INTO `mob_spawn_mods` VALUES (17236203,12,15,1);  -- DRAW_IN: 15
INSERT INTO `mob_spawn_mods` VALUES (17236203,23,8,1);   -- IMMUNITY: 8
INSERT INTO `mob_spawn_mods` VALUES (17236203,169,10,0); -- MOVE: 10

-- Boreal Tiger
INSERT INTO `mob_spawn_mods` VALUES (17236204,12,15,1);  -- DRAW_IN: 15
INSERT INTO `mob_spawn_mods` VALUES (17236204,169,10,0); -- MOVE: 10

-- Koenigstiger
INSERT INTO `mob_spawn_mods` VALUES (17236205,55,240,1); -- IDLE_DESPAWN: 240

-- Tegmine
INSERT INTO `mob_spawn_mods` VALUES (17240232,23,50,0);  -- ATT: 50
INSERT INTO `mob_spawn_mods` VALUES (17240232,288,40,0); -- DOUBLE_ATTACK: 40

-- Axesarion The Wanderer
INSERT INTO `mob_spawn_mods` VALUES (17240414,55,300,1); -- IDLE_DESPAWN: 300

-- Decurio I-Iii
INSERT INTO `mob_spawn_mods` VALUES (17244523,55,300,1); -- IDLE_DESPAWN: 300

-- Tsuchigumo
INSERT INTO `mob_spawn_mods` VALUES (17244524,55,300,1); -- IDLE_DESPAWN: 300

-- Tsuchigumo
INSERT INTO `mob_spawn_mods` VALUES (17244525,55,300,1); -- IDLE_DESPAWN: 300

-- Roc
INSERT INTO `mob_spawn_mods` VALUES (17269106,1,15000,1); -- GIL_MIN: 15000
INSERT INTO `mob_spawn_mods` VALUES (17269106,2,30545,1); -- GIL_MAX: 30545

-- Climbpix Highrise
INSERT INTO `mob_spawn_mods` VALUES (17269107,55,120,1); -- IDLE_DESPAWN: 120

-- Dribblix Greasemaw
INSERT INTO `mob_spawn_mods` VALUES (17269114,55,180,1); -- IDLE_DESPAWN: 180

-- Guardian Treant
INSERT INTO `mob_spawn_mods` VALUES (17272838,55,288,1); -- IDLE_DESPAWN: 288

-- Doomed Pilgrims
INSERT INTO `mob_spawn_mods` VALUES (17272839,55,300,1); -- IDLE_DESPAWN: 300

-- Isonade
INSERT INTO `mob_spawn_mods` VALUES (17273285,55,180,1); -- IDLE_DESPAWN: 180

-- Tipha
INSERT INTO `mob_spawn_mods` VALUES (17281030,55,300,1); -- IDLE_DESPAWN: 300

-- Carthi
INSERT INTO `mob_spawn_mods` VALUES (17281031,55,300,1); -- IDLE_DESPAWN: 300

-- Bisque-Heeled Sunberry
INSERT INTO `mob_spawn_mods` VALUES (17285460,1,379,1); -- GIL_MIN: 379
INSERT INTO `mob_spawn_mods` VALUES (17285460,2,900,1); -- GIL_MAX: 900

-- Kappa Akuso
INSERT INTO `mob_spawn_mods` VALUES (17285544,55,150,1); -- IDLE_DESPAWN: 150

-- Kappa Bonze
INSERT INTO `mob_spawn_mods` VALUES (17285545,55,300,1); -- IDLE_DESPAWN: 300

-- Kappa Biwa
INSERT INTO `mob_spawn_mods` VALUES (17285546,55,150,1); -- IDLE_DESPAWN: 150

-- King Vinegarroon
INSERT INTO `mob_spawn_mods` VALUES (17289575,12,15,1); -- DRAW_IN: 15

-- Eastern Sphinx
INSERT INTO `mob_spawn_mods` VALUES (17289654,55,168,1); -- IDLE_DESPAWN: 168

-- Western Sphinx
INSERT INTO `mob_spawn_mods` VALUES (17289655,55,168,1); -- IDLE_DESPAWN: 168

-- Kraken
INSERT INTO `mob_spawn_mods` VALUES (17293486,31,5,1); -- ROAM_DISTANCE: 5
INSERT INTO `mob_spawn_mods` VALUES (17293486,51,1,1); -- ROAM_TURNS: 1

-- King Behemoth
INSERT INTO `mob_spawn_mods` VALUES (17297441,12,25,1); -- DRAW_IN: 25

-- Picklix Longindex
INSERT INTO `mob_spawn_mods` VALUES (17297446,55,180,1); -- IDLE_DESPAWN: 180

-- Moxnix Nightgoggle
INSERT INTO `mob_spawn_mods` VALUES (17297447,55,180,1); -- IDLE_DESPAWN: 180

-- Doglix Muttsnout
INSERT INTO `mob_spawn_mods` VALUES (17297448,55,180,1); -- IDLE_DESPAWN: 180

-- Ancient Weapon
INSERT INTO `mob_spawn_mods` VALUES (17297449,55,300,1); -- IDLE_DESPAWN: 300

-- Legendary Weapon
INSERT INTO `mob_spawn_mods` VALUES (17297450,55,300,1); -- IDLE_DESPAWN: 300

-- Despot
INSERT INTO `mob_spawn_mods` VALUES (17309954,1,18000,1); -- GIL_MIN: 18000
INSERT INTO `mob_spawn_mods` VALUES (17309954,2,29250,1); -- GIL_MAX: 29250
INSERT INTO `mob_spawn_mods` VALUES (17309954,15,3250,1); -- MUG_GIL: 3250

-- Mimic
INSERT INTO `mob_spawn_mods` VALUES (17309979,55,120,1); -- IDLE_DESPAWN: 120

-- Genbu
INSERT INTO `mob_spawn_mods` VALUES (17309980,1,1500,1);  -- GIL_MIN: 1500
INSERT INTO `mob_spawn_mods` VALUES (17309980,2,29036,1); -- GIL_MAX: 29036
INSERT INTO `mob_spawn_mods` VALUES (17309980,55,300,1);  -- IDLE_DESPAWN: 300

-- Seiryu
INSERT INTO `mob_spawn_mods` VALUES (17309981,1,1500,1);  -- GIL_MIN: 1500
INSERT INTO `mob_spawn_mods` VALUES (17309981,2,28608,1); -- GIL_MAX: 28608
INSERT INTO `mob_spawn_mods` VALUES (17309981,55,300,1);  -- IDLE_DESPAWN: 300

-- Byakko
INSERT INTO `mob_spawn_mods` VALUES (17309982,1,1500,1);  -- GIL_MIN: 1500
INSERT INTO `mob_spawn_mods` VALUES (17309982,2,18000,1); -- GIL_MAX: 18000
INSERT INTO `mob_spawn_mods` VALUES (17309982,55,300,1);  -- IDLE_DESPAWN: 300

-- Suzaku
INSERT INTO `mob_spawn_mods` VALUES (17309983,1,1500,1);  -- GIL_MIN: 1500
INSERT INTO `mob_spawn_mods` VALUES (17309983,2,28886,1); -- GIL_MAX: 28886
INSERT INTO `mob_spawn_mods` VALUES (17309983,55,300,1);  -- IDLE_DESPAWN: 300

-- Satellite Shield
INSERT INTO `mob_spawn_mods` VALUES (17330290,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Shield
INSERT INTO `mob_spawn_mods` VALUES (17330291,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Shield
INSERT INTO `mob_spawn_mods` VALUES (17330292,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Shield
INSERT INTO `mob_spawn_mods` VALUES (17330299,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Shield
INSERT INTO `mob_spawn_mods` VALUES (17330300,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Shield
INSERT INTO `mob_spawn_mods` VALUES (17330301,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Daggers
INSERT INTO `mob_spawn_mods` VALUES (17330306,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Daggers
INSERT INTO `mob_spawn_mods` VALUES (17330307,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Daggers
INSERT INTO `mob_spawn_mods` VALUES (17330308,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Knuckles
INSERT INTO `mob_spawn_mods` VALUES (17330309,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Knuckles
INSERT INTO `mob_spawn_mods` VALUES (17330310,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Knuckles
INSERT INTO `mob_spawn_mods` VALUES (17330311,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Daggers
INSERT INTO `mob_spawn_mods` VALUES (17330316,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Daggers
INSERT INTO `mob_spawn_mods` VALUES (17330317,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Daggers
INSERT INTO `mob_spawn_mods` VALUES (17330318,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Knuckles
INSERT INTO `mob_spawn_mods` VALUES (17330319,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Knuckles
INSERT INTO `mob_spawn_mods` VALUES (17330320,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Knuckles
INSERT INTO `mob_spawn_mods` VALUES (17330321,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Hammers
INSERT INTO `mob_spawn_mods` VALUES (17330334,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Hammers
INSERT INTO `mob_spawn_mods` VALUES (17330335,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Hammers
INSERT INTO `mob_spawn_mods` VALUES (17330336,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Staves
INSERT INTO `mob_spawn_mods` VALUES (17330337,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Staves
INSERT INTO `mob_spawn_mods` VALUES (17330338,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Staves
INSERT INTO `mob_spawn_mods` VALUES (17330339,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Hammers
INSERT INTO `mob_spawn_mods` VALUES (17330344,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Hammers
INSERT INTO `mob_spawn_mods` VALUES (17330345,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Hammers
INSERT INTO `mob_spawn_mods` VALUES (17330346,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Staves
INSERT INTO `mob_spawn_mods` VALUES (17330347,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Staves
INSERT INTO `mob_spawn_mods` VALUES (17330348,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Staves
INSERT INTO `mob_spawn_mods` VALUES (17330349,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Longswords
INSERT INTO `mob_spawn_mods` VALUES (17330355,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Longswords
INSERT INTO `mob_spawn_mods` VALUES (17330356,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Longswords
INSERT INTO `mob_spawn_mods` VALUES (17330357,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Longswords
INSERT INTO `mob_spawn_mods` VALUES (17330362,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Longswords
INSERT INTO `mob_spawn_mods` VALUES (17330363,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Longswords
INSERT INTO `mob_spawn_mods` VALUES (17330364,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Claymores
INSERT INTO `mob_spawn_mods` VALUES (17330365,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Claymores
INSERT INTO `mob_spawn_mods` VALUES (17330366,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Claymores
INSERT INTO `mob_spawn_mods` VALUES (17330367,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Claymores
INSERT INTO `mob_spawn_mods` VALUES (17330372,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Claymores
INSERT INTO `mob_spawn_mods` VALUES (17330373,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Claymores
INSERT INTO `mob_spawn_mods` VALUES (17330374,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Tabars
INSERT INTO `mob_spawn_mods` VALUES (17330380,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Tabars
INSERT INTO `mob_spawn_mods` VALUES (17330381,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Tabars
INSERT INTO `mob_spawn_mods` VALUES (17330382,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Great Axes
INSERT INTO `mob_spawn_mods` VALUES (17330383,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Great Axes
INSERT INTO `mob_spawn_mods` VALUES (17330384,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Great Axes
INSERT INTO `mob_spawn_mods` VALUES (17330385,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Tabars
INSERT INTO `mob_spawn_mods` VALUES (17330392,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Tabars
INSERT INTO `mob_spawn_mods` VALUES (17330393,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Tabars
INSERT INTO `mob_spawn_mods` VALUES (17330394,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Great Axes
INSERT INTO `mob_spawn_mods` VALUES (17330395,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Great Axes
INSERT INTO `mob_spawn_mods` VALUES (17330396,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Great Axes
INSERT INTO `mob_spawn_mods` VALUES (17330397,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Scythes
INSERT INTO `mob_spawn_mods` VALUES (17330420,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Scythes
INSERT INTO `mob_spawn_mods` VALUES (17330421,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Scythes
INSERT INTO `mob_spawn_mods` VALUES (17330422,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Spears
INSERT INTO `mob_spawn_mods` VALUES (17330423,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Spears
INSERT INTO `mob_spawn_mods` VALUES (17330424,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Spears
INSERT INTO `mob_spawn_mods` VALUES (17330425,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Scythes
INSERT INTO `mob_spawn_mods` VALUES (17330432,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Scythes
INSERT INTO `mob_spawn_mods` VALUES (17330433,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Scythes
INSERT INTO `mob_spawn_mods` VALUES (17330434,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Spears
INSERT INTO `mob_spawn_mods` VALUES (17330435,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Spears
INSERT INTO `mob_spawn_mods` VALUES (17330436,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Spears
INSERT INTO `mob_spawn_mods` VALUES (17330437,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Kunai
INSERT INTO `mob_spawn_mods` VALUES (17330442,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Kunai
INSERT INTO `mob_spawn_mods` VALUES (17330443,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Kunai
INSERT INTO `mob_spawn_mods` VALUES (17330444,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Tachi
INSERT INTO `mob_spawn_mods` VALUES (17330445,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Tachi
INSERT INTO `mob_spawn_mods` VALUES (17330446,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Tachi
INSERT INTO `mob_spawn_mods` VALUES (17330447,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Kunai
INSERT INTO `mob_spawn_mods` VALUES (17330454,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Kunai
INSERT INTO `mob_spawn_mods` VALUES (17330455,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Kunai
INSERT INTO `mob_spawn_mods` VALUES (17330456,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Tachi
INSERT INTO `mob_spawn_mods` VALUES (17330457,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Tachi
INSERT INTO `mob_spawn_mods` VALUES (17330458,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Tachi
INSERT INTO `mob_spawn_mods` VALUES (17330459,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Horns
INSERT INTO `mob_spawn_mods` VALUES (17330495,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Horns
INSERT INTO `mob_spawn_mods` VALUES (17330496,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Horns
INSERT INTO `mob_spawn_mods` VALUES (17330497,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Horns
INSERT INTO `mob_spawn_mods` VALUES (17330503,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Horns
INSERT INTO `mob_spawn_mods` VALUES (17330504,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Horns
INSERT INTO `mob_spawn_mods` VALUES (17330505,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Guns
INSERT INTO `mob_spawn_mods` VALUES (17330513,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Guns
INSERT INTO `mob_spawn_mods` VALUES (17330514,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Guns
INSERT INTO `mob_spawn_mods` VALUES (17330515,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Guns
INSERT INTO `mob_spawn_mods` VALUES (17330516,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Guns
INSERT INTO `mob_spawn_mods` VALUES (17330517,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Guns
INSERT INTO `mob_spawn_mods` VALUES (17330518,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Longbows
INSERT INTO `mob_spawn_mods` VALUES (17330522,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Longbows
INSERT INTO `mob_spawn_mods` VALUES (17330523,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Longbows
INSERT INTO `mob_spawn_mods` VALUES (17330524,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Longbows
INSERT INTO `mob_spawn_mods` VALUES (17330525,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Longbows
INSERT INTO `mob_spawn_mods` VALUES (17330526,55,120,1); -- IDLE_DESPAWN: 120

-- Satellite Longbows
INSERT INTO `mob_spawn_mods` VALUES (17330527,55,120,1); -- IDLE_DESPAWN: 120

-- Orcish Fighter
INSERT INTO `mob_spawn_mods` VALUES (17354895,55,600,1); -- IDLE_DESPAWN: 600

-- Chariotbuster Byakzak
INSERT INTO `mob_spawn_mods` VALUES (17354896,55,600,1); -- IDLE_DESPAWN: 600

-- Qu'Vho Deathhurler
INSERT INTO `mob_spawn_mods` VALUES (17363080,368,33,0); -- REGAIN: 33

-- Ni'Ghu Nestfender
INSERT INTO `mob_spawn_mods` VALUES (17363318,55,180,1); -- IDLE_DESPAWN: 180

-- Maat
INSERT INTO `mob_spawn_mods` VALUES (17367080,33,30,1); -- SPECIAL_COOL: 30

-- Maat
INSERT INTO `mob_spawn_mods` VALUES (17367082,33,30,1); -- SPECIAL_COOL: 30

-- Maat'S Pet
INSERT INTO `mob_spawn_mods` VALUES (17367085,34,30,1); -- MAGIC_COOL: 30

-- Eyy Mon The Ironbreaker
INSERT INTO `mob_spawn_mods` VALUES (17371142,1,20,1); -- GIL_MIN: 20
INSERT INTO `mob_spawn_mods` VALUES (17371142,2,33,1); -- GIL_MAX: 33

-- Zhuu Buxu The Silent
INSERT INTO `mob_spawn_mods` VALUES (17371143,1,20,1); -- GIL_MIN: 20
INSERT INTO `mob_spawn_mods` VALUES (17371143,2,25,1); -- GIL_MAX: 25

-- Vaa Huja The Erudite
INSERT INTO `mob_spawn_mods` VALUES (17371579,55,180,1); -- IDLE_DESPAWN: 180

-- Maat
INSERT INTO `mob_spawn_mods` VALUES (17375263,34,30,1); -- MAGIC_COOL: 30

-- Maat
INSERT INTO `mob_spawn_mods` VALUES (17375267,34,30,1); -- MAGIC_COOL: 30

-- Mimic
INSERT INTO `mob_spawn_mods` VALUES (17379783,55,120,1); -- IDLE_DESPAWN: 120

-- Gavotvut
INSERT INTO `mob_spawn_mods` VALUES (17387965,55,300,1); -- IDLE_DESPAWN: 300

-- Barakbok
INSERT INTO `mob_spawn_mods` VALUES (17387966,55,300,1); -- IDLE_DESPAWN: 300

-- Bilopdop
INSERT INTO `mob_spawn_mods` VALUES (17387967,55,300,1); -- IDLE_DESPAWN: 300

-- Deloknok
INSERT INTO `mob_spawn_mods` VALUES (17387968,55,300,1); -- IDLE_DESPAWN: 300

-- One-Eyed Gwajboj
INSERT INTO `mob_spawn_mods` VALUES (17387970,55,180,1); -- IDLE_DESPAWN: 180

-- Three-Eyed Prozpuz
INSERT INTO `mob_spawn_mods` VALUES (17387971,55,180,1); -- IDLE_DESPAWN: 180

-- Bugaboo
INSERT INTO `mob_spawn_mods` VALUES (17391804,55,180,1); -- IDLE_DESPAWN: 180

-- Mimic
INSERT INTO `mob_spawn_mods` VALUES (17391805,55,120,1); -- IDLE_DESPAWN: 120

-- Huu Xalmo The Savage
INSERT INTO `mob_spawn_mods` VALUES (17396140,55,180,1); -- IDLE_DESPAWN: 180

-- Mimic
INSERT INTO `mob_spawn_mods` VALUES (17396144,55,120,1); -- IDLE_DESPAWN: 120

-- Voluptuous Vivian
INSERT INTO `mob_spawn_mods` VALUES (17404331,1,20000,1); -- GIL_MIN: 20000
INSERT INTO `mob_spawn_mods` VALUES (17404331,2,24000,1); -- GIL_MAX: 24000

-- Agas
INSERT INTO `mob_spawn_mods` VALUES (17404337,55,288,1); -- IDLE_DESPAWN: 288

-- Beet Leafhopper
INSERT INTO `mob_spawn_mods` VALUES (17404338,55,120,1); -- IDLE_DESPAWN: 120

-- Fafnir
INSERT INTO `mob_spawn_mods` VALUES (17408018,12,20,1); -- DRAW_IN: 20

-- Gerwitz'S Scythe
INSERT INTO `mob_spawn_mods` VALUES (17420629,55,300,1); -- IDLE_DESPAWN: 300

-- Scythe Victim
INSERT INTO `mob_spawn_mods` VALUES (17420630,55,180,1); -- IDLE_DESPAWN: 180

-- Scythe Victim
INSERT INTO `mob_spawn_mods` VALUES (17420631,55,180,1); -- IDLE_DESPAWN: 180

-- Pallas
INSERT INTO `mob_spawn_mods` VALUES (17424444,55,120,1); -- IDLE_DESPAWN: 120

-- Alkyoneus
INSERT INTO `mob_spawn_mods` VALUES (17424480,55,120,1); -- IDLE_DESPAWN: 120

-- Autarch
INSERT INTO `mob_spawn_mods` VALUES (17424488,23,60,0);  -- ATT: 60
INSERT INTO `mob_spawn_mods` VALUES (17424488,288,25,0); -- DOUBLE_ATTACK: 25
INSERT INTO `mob_spawn_mods` VALUES (17424488,302,25,0); -- TRIPLE_ATTACK: 25

-- Nio-A
INSERT INTO `mob_spawn_mods` VALUES (17428495,55,180,1); -- IDLE_DESPAWN: 180

-- Nio-Hum
INSERT INTO `mob_spawn_mods` VALUES (17428496,55,180,1); -- IDLE_DESPAWN: 180

-- Mimic
INSERT INTO `mob_spawn_mods` VALUES (17428497,55,120,1); -- IDLE_DESPAWN: 120

-- Tonberry Kinq
INSERT INTO `mob_spawn_mods` VALUES (17428677,1,18000,1); -- GIL_MIN: 18000
INSERT INTO `mob_spawn_mods` VALUES (17428677,2,30000,1); -- GIL_MAX: 30000

-- Sozu Rogberry
INSERT INTO `mob_spawn_mods` VALUES (17428751,55,300,1); -- IDLE_DESPAWN: 300

-- Cleuvarion M Resoaix
INSERT INTO `mob_spawn_mods` VALUES (17428807,55,180,1); -- IDLE_DESPAWN: 180

-- Rompaulion S Citalle
INSERT INTO `mob_spawn_mods` VALUES (17428808,55,180,1); -- IDLE_DESPAWN: 180

-- Beryl-Footed Molberry
INSERT INTO `mob_spawn_mods` VALUES (17428809,55,300,1); -- IDLE_DESPAWN: 300

-- Death From Above
INSERT INTO `mob_spawn_mods` VALUES (17428810,55,300,1); -- IDLE_DESPAWN: 300

-- Habetrot
INSERT INTO `mob_spawn_mods` VALUES (17428811,1,2000,1); -- GIL_MIN: 2000
INSERT INTO `mob_spawn_mods` VALUES (17428811,2,5625,1); -- GIL_MAX: 5625
INSERT INTO `mob_spawn_mods` VALUES (17428811,55,900,1); -- IDLE_DESPAWN: 900

-- Rumble Crawler
INSERT INTO `mob_spawn_mods` VALUES (17428812,17,1,1);   -- NO_DESPAWN: 1
INSERT INTO `mob_spawn_mods` VALUES (17428812,55,900,1); -- IDLE_DESPAWN: 900

-- Crimson-Toothed Pawberry
INSERT INTO `mob_spawn_mods` VALUES (17428813,55,300,1); -- IDLE_DESPAWN: 300

-- Tonberry'S Avatar
INSERT INTO `mob_spawn_mods` VALUES (17428815,55,300,1); -- IDLE_DESPAWN: 300

-- Sacrificial Goblet
INSERT INTO `mob_spawn_mods` VALUES (17428816,55,300,1); -- IDLE_DESPAWN: 300

-- Mimic
INSERT INTO `mob_spawn_mods` VALUES (17432583,55,120,1); -- IDLE_DESPAWN: 120

-- Hakutaku
INSERT INTO `mob_spawn_mods` VALUES (17433005,55,120,1); -- IDLE_DESPAWN: 120

-- Azrael
INSERT INTO `mob_spawn_mods` VALUES (17433009,1,15000,1); -- GIL_MIN: 15000
INSERT INTO `mob_spawn_mods` VALUES (17433009,2,18000,1); -- GIL_MAX: 18000
INSERT INTO `mob_spawn_mods` VALUES (17433009,302,15,0);  -- TRIPLE_ATTACK: 15

-- Dark Spark
INSERT INTO `mob_spawn_mods` VALUES (17436964,55,180,1); -- IDLE_DESPAWN: 180

-- Mimic
INSERT INTO `mob_spawn_mods` VALUES (17436965,55,120,1); -- IDLE_DESPAWN: 120

-- Tros
INSERT INTO `mob_spawn_mods` VALUES (17457309,55,180,1); -- IDLE_DESPAWN: 180

-- Bloodsucker
INSERT INTO `mob_spawn_mods` VALUES (17461478,1,3000,1); -- GIL_MIN: 3000
INSERT INTO `mob_spawn_mods` VALUES (17461478,2,9900,1); -- GIL_MAX: 9900

-- Maat
INSERT INTO `mob_spawn_mods` VALUES (17465360,33,30,1); -- SPECIAL_COOL: 30
INSERT INTO `mob_spawn_mods` VALUES (17465360,34,30,1); -- MAGIC_COOL: 30

-- Maat
INSERT INTO `mob_spawn_mods` VALUES (17465362,33,30,1); -- SPECIAL_COOL: 30

-- Maat
INSERT INTO `mob_spawn_mods` VALUES (17465364,33,30,1); -- SPECIAL_COOL: 30

-- Magic Sludge
INSERT INTO `mob_spawn_mods` VALUES (17469516,55,180,1); -- IDLE_DESPAWN: 180

-- Mimic
INSERT INTO `mob_spawn_mods` VALUES (17469761,55,120,1); -- IDLE_DESPAWN: 120

-- Cargo Crab Colin
INSERT INTO `mob_spawn_mods` VALUES (17485980,1,1200,1); -- GIL_MIN: 1200
INSERT INTO `mob_spawn_mods` VALUES (17485980,2,1950,1); -- GIL_MAX: 1950

-- Falcatus Aranei
INSERT INTO `mob_spawn_mods` VALUES (17486031,1,1200,1); -- GIL_MIN: 1200
INSERT INTO `mob_spawn_mods` VALUES (17486031,2,1903,1); -- GIL_MAX: 1903

-- Dame Blanche
INSERT INTO `mob_spawn_mods` VALUES (17486129,1,3600,1); -- GIL_MIN: 3600
INSERT INTO `mob_spawn_mods` VALUES (17486129,2,6079,1); -- GIL_MAX: 6079

-- Korroloka Leech
INSERT INTO `mob_spawn_mods` VALUES (17486187,55,168,1); -- IDLE_DESPAWN: 168

-- Korroloka Leech
INSERT INTO `mob_spawn_mods` VALUES (17486188,55,168,1); -- IDLE_DESPAWN: 168

-- Korroloka Leech
INSERT INTO `mob_spawn_mods` VALUES (17486189,55,168,1); -- IDLE_DESPAWN: 168

-- Morion Worm
INSERT INTO `mob_spawn_mods` VALUES (17486190,55,1800,1); -- IDLE_DESPAWN: 1800

-- Amemet
INSERT INTO `mob_spawn_mods` VALUES (17490016,1,6000,1); -- GIL_MIN: 6000
INSERT INTO `mob_spawn_mods` VALUES (17490016,2,9100,1); -- GIL_MAX: 9100

-- Mimic
INSERT INTO `mob_spawn_mods` VALUES (17490230,55,120,1); -- IDLE_DESPAWN: 120

-- Cancer
INSERT INTO `mob_spawn_mods` VALUES (17490231,1,6000,1); -- GIL_MIN: 6000
INSERT INTO `mob_spawn_mods` VALUES (17490231,2,9500,1); -- GIL_MAX: 9500
INSERT INTO `mob_spawn_mods` VALUES (17490231,55,180,1); -- IDLE_DESPAWN: 180

-- Robber Crab
INSERT INTO `mob_spawn_mods` VALUES (17490232,55,180,1); -- IDLE_DESPAWN: 180

-- Phantom Worm
INSERT INTO `mob_spawn_mods` VALUES (17490233,55,180,1); -- IDLE_DESPAWN: 180

-- Mimic
INSERT INTO `mob_spawn_mods` VALUES (17498564,55,120,1); -- IDLE_DESPAWN: 120

-- Mimic
INSERT INTO `mob_spawn_mods` VALUES (17502567,55,120,1); -- IDLE_DESPAWN: 120

-- Brigandish Blade
INSERT INTO `mob_spawn_mods` VALUES (17502568,1,18227,1); -- GIL_MIN: 18227
INSERT INTO `mob_spawn_mods` VALUES (17502568,2,18606,1); -- GIL_MAX: 18606
INSERT INTO `mob_spawn_mods` VALUES (17502568,55,180,1);  -- IDLE_DESPAWN: 180

-- Faust
INSERT INTO `mob_spawn_mods` VALUES (17506370,1,17986,1); -- GIL_MIN: 17986
INSERT INTO `mob_spawn_mods` VALUES (17506370,2,27482,1); -- GIL_MAX: 27482

-- Ullikummi
INSERT INTO `mob_spawn_mods` VALUES (17506418,55,180,1); -- IDLE_DESPAWN: 180

-- Olla Pequena
INSERT INTO `mob_spawn_mods` VALUES (17506667,55,180,1); -- IDLE_DESPAWN: 180

-- Olla Media
INSERT INTO `mob_spawn_mods` VALUES (17506668,55,180,1); -- IDLE_DESPAWN: 180

-- Olla Grande
INSERT INTO `mob_spawn_mods` VALUES (17506669,55,180,1); -- IDLE_DESPAWN: 180

-- Disaster Idol
INSERT INTO `mob_spawn_mods` VALUES (17531121,55,180,1); -- IDLE_DESPAWN: 180

-- Cemetery Cherry
INSERT INTO `mob_spawn_mods` VALUES (17555863,1,20000,1); -- GIL_MIN: 20000
INSERT INTO `mob_spawn_mods` VALUES (17555863,2,30000,1); -- GIL_MAX: 30000
INSERT INTO `mob_spawn_mods` VALUES (17555863,15,10000,1); -- MUG_GIL: 10000
INSERT INTO `mob_spawn_mods` VALUES (17555863,55,600,1);  -- IDLE_DESPAWN: 600

-- Fire Elemental
INSERT INTO `mob_spawn_mods` VALUES (17559870,55,300,1); -- IDLE_DESPAWN: 300

-- Polevik
INSERT INTO `mob_spawn_mods` VALUES (17568134,55,168,1); -- IDLE_DESPAWN: 168

-- Gerwitz'S Axe
INSERT INTO `mob_spawn_mods` VALUES (17568135,55,180,1); -- IDLE_DESPAWN: 180

-- Gerwitz'S Sword
INSERT INTO `mob_spawn_mods` VALUES (17568136,55,180,1); -- IDLE_DESPAWN: 180

-- Gerwitz'S Soul
INSERT INTO `mob_spawn_mods` VALUES (17568137,55,180,1); -- IDLE_DESPAWN: 180

-- Air Elemental
INSERT INTO `mob_spawn_mods` VALUES (17568139,55,300,1); -- IDLE_DESPAWN: 300

-- Thunder Elemental
INSERT INTO `mob_spawn_mods` VALUES (17572203,55,300,1); -- IDLE_DESPAWN: 300

-- Yum Kimil
INSERT INTO `mob_spawn_mods` VALUES (17576264,55,300,1); -- IDLE_DESPAWN: 300

-- Dog Guardian
INSERT INTO `mob_spawn_mods` VALUES (17576265,55,180,1); -- IDLE_DESPAWN: 180

-- Owl Guardian
INSERT INTO `mob_spawn_mods` VALUES (17576266,55,180,1); -- IDLE_DESPAWN: 180

-- Sturm
INSERT INTO `mob_spawn_mods` VALUES (17576267,55,180,1); -- IDLE_DESPAWN: 180

-- Taifun
INSERT INTO `mob_spawn_mods` VALUES (17576268,55,180,1); -- IDLE_DESPAWN: 180

-- Trombe
INSERT INTO `mob_spawn_mods` VALUES (17576269,55,180,1); -- IDLE_DESPAWN: 180

-- Ice Elemental
INSERT INTO `mob_spawn_mods` VALUES (17576271,55,120,1); -- IDLE_DESPAWN: 120

-- Blind Moby
INSERT INTO `mob_spawn_mods` VALUES (17580038,55,300,1); -- IDLE_DESPAWN: 300

-- Wandering Ghost
INSERT INTO `mob_spawn_mods` VALUES (17580337,55,300,1); -- IDLE_DESPAWN: 300

-- Earth Elemental
INSERT INTO `mob_spawn_mods` VALUES (17580340,55,300,1); -- IDLE_DESPAWN: 300

-- Guardian Crawler
INSERT INTO `mob_spawn_mods` VALUES (17584129,55,120,1); -- IDLE_DESPAWN: 120

-- Guardian Crawler
INSERT INTO `mob_spawn_mods` VALUES (17584130,55,120,1); -- IDLE_DESPAWN: 120

-- Drone Crawler
INSERT INTO `mob_spawn_mods` VALUES (17584131,55,120,1); -- IDLE_DESPAWN: 120

-- Drone Crawler
INSERT INTO `mob_spawn_mods` VALUES (17584132,55,120,1); -- IDLE_DESPAWN: 120

-- Queen Crawler
INSERT INTO `mob_spawn_mods` VALUES (17584133,55,120,1); -- IDLE_DESPAWN: 120

-- Matron Crawler
INSERT INTO `mob_spawn_mods` VALUES (17584134,55,120,1); -- IDLE_DESPAWN: 120

-- Awd Goggie
INSERT INTO `mob_spawn_mods` VALUES (17584135,55,120,1); -- IDLE_DESPAWN: 120

-- Dreadbug
INSERT INTO `mob_spawn_mods` VALUES (17584425,55,168,1); -- IDLE_DESPAWN: 168

-- Mimic
INSERT INTO `mob_spawn_mods` VALUES (17584426,55,120,1); -- IDLE_DESPAWN: 120

-- Water Elemental
INSERT INTO `mob_spawn_mods` VALUES (17584427,55,300,1); -- IDLE_DESPAWN: 300

-- Wyrmfly
INSERT INTO `mob_spawn_mods` VALUES (17588701,55,180,1); -- IDLE_DESPAWN: 180

-- Wyrmfly
INSERT INTO `mob_spawn_mods` VALUES (17588702,55,180,1); -- IDLE_DESPAWN: 180

-- Wyrmfly
INSERT INTO `mob_spawn_mods` VALUES (17588703,55,180,1); -- IDLE_DESPAWN: 180

-- Dark Elemental
INSERT INTO `mob_spawn_mods` VALUES (17588704,55,300,1); -- IDLE_DESPAWN: 300

-- Lost Soul
INSERT INTO `mob_spawn_mods` VALUES (17588706,55,180,1); -- IDLE_DESPAWN: 180

-- Chandelier
INSERT INTO `mob_spawn_mods` VALUES (17596533,55,120,1); -- IDLE_DESPAWN: 120

-- Guardian Statue
INSERT INTO `mob_spawn_mods` VALUES (17596643,55,180,1); -- IDLE_DESPAWN: 180

-- Serket
INSERT INTO `mob_spawn_mods` VALUES (17596720,1,19000,1); -- GIL_MIN: 19000
INSERT INTO `mob_spawn_mods` VALUES (17596720,2,32767,1); -- GIL_MAX: 32767

-- Mimic
INSERT INTO `mob_spawn_mods` VALUES (17596728,55,120,1); -- IDLE_DESPAWN: 120

-- Light Elemental
INSERT INTO `mob_spawn_mods` VALUES (17596729,55,300,1); -- IDLE_DESPAWN: 300

-- Altedour I Tavnazia
INSERT INTO `mob_spawn_mods` VALUES (17612836,55,180,1); -- IDLE_DESPAWN: 180

-- Mimic
INSERT INTO `mob_spawn_mods` VALUES (17617157,55,120,1); -- IDLE_DESPAWN: 120

-- Bomb Queen
INSERT INTO `mob_spawn_mods` VALUES (17617158,1,15000,1); -- GIL_MIN: 15000
INSERT INTO `mob_spawn_mods` VALUES (17617158,2,18000,1); -- GIL_MAX: 18000
INSERT INTO `mob_spawn_mods` VALUES (17617158,15,3370,1); -- MUG_GIL: 3370
INSERT INTO `mob_spawn_mods` VALUES (17617158,55,900,1);  -- IDLE_DESPAWN: 900

-- Tarasque
INSERT INTO `mob_spawn_mods` VALUES (17617164,55,900,1); -- IDLE_DESPAWN: 900

-- Valor
INSERT INTO `mob_spawn_mods` VALUES (17629185,55,180,1); -- IDLE_DESPAWN: 180

-- Honor
INSERT INTO `mob_spawn_mods` VALUES (17629186,55,180,1); -- IDLE_DESPAWN: 180

-- Mimic
INSERT INTO `mob_spawn_mods` VALUES (17629190,55,120,1); -- IDLE_DESPAWN: 120

-- Centurio X-I
INSERT INTO `mob_spawn_mods` VALUES (17629238,1,2000,1); -- GIL_MIN: 2000
INSERT INTO `mob_spawn_mods` VALUES (17629238,2,6000,1); -- GIL_MAX: 6000
INSERT INTO `mob_spawn_mods` VALUES (17629238,15,630,1); -- MUG_GIL: 630

-- Sabotender Bailarin
INSERT INTO `mob_spawn_mods` VALUES (17629264,1,10000,1); -- GIL_MIN: 10000
INSERT INTO `mob_spawn_mods` VALUES (17629264,2,13640,1); -- GIL_MAX: 13640

-- Antican Praefectus
INSERT INTO `mob_spawn_mods` VALUES (17629281,1,2100,1); -- GIL_MIN: 2100
INSERT INTO `mob_spawn_mods` VALUES (17629281,2,4500,1); -- GIL_MAX: 4500

-- Sagittarius X-Xiii
INSERT INTO `mob_spawn_mods` VALUES (17629301,1,1000,1); -- GIL_MIN: 1000
INSERT INTO `mob_spawn_mods` VALUES (17629301,2,3000,1); -- GIL_MAX: 3000

-- Nussknacker
INSERT INTO `mob_spawn_mods` VALUES (17629403,1,4800,1); -- GIL_MIN: 4800
INSERT INTO `mob_spawn_mods` VALUES (17629403,2,6000,1); -- GIL_MAX: 6000

-- Antican Magister
INSERT INTO `mob_spawn_mods` VALUES (17629412,1,2100,1); -- GIL_MIN: 2100
INSERT INTO `mob_spawn_mods` VALUES (17629412,2,4500,1); -- GIL_MAX: 4500

-- Antican Proconsul
INSERT INTO `mob_spawn_mods` VALUES (17629421,1,2100,1); -- GIL_MIN: 2100
INSERT INTO `mob_spawn_mods` VALUES (17629421,2,4500,1); -- GIL_MAX: 4500

-- Diamond Daig
INSERT INTO `mob_spawn_mods` VALUES (17629430,1,1200,1); -- GIL_MIN: 1200
INSERT INTO `mob_spawn_mods` VALUES (17629430,2,3000,1); -- GIL_MAX: 3000

-- Antican Tribunus
INSERT INTO `mob_spawn_mods` VALUES (17629483,1,6000,1); -- GIL_MIN: 6000
INSERT INTO `mob_spawn_mods` VALUES (17629483,2,9234,1); -- GIL_MAX: 9234

-- Triarius X-Xv
INSERT INTO `mob_spawn_mods` VALUES (17629524,1,6000,1); -- GIL_MIN: 6000
INSERT INTO `mob_spawn_mods` VALUES (17629524,2,9234,1); -- GIL_MAX: 9234

-- Hastatus Xi-Xii
INSERT INTO `mob_spawn_mods` VALUES (17629561,1,650,1);  -- GIL_MIN: 650
INSERT INTO `mob_spawn_mods` VALUES (17629561,2,1450,1); -- GIL_MAX: 1450

-- Antican Legatus
INSERT INTO `mob_spawn_mods` VALUES (17629640,1,6000,1); -- GIL_MIN: 6000
INSERT INTO `mob_spawn_mods` VALUES (17629640,2,9234,1); -- GIL_MAX: 9234

-- Antican Consul
INSERT INTO `mob_spawn_mods` VALUES (17629641,1,6000,1); -- GIL_MIN: 6000
INSERT INTO `mob_spawn_mods` VALUES (17629641,2,9234,1); -- GIL_MAX: 9234

-- Ancient Vessel
INSERT INTO `mob_spawn_mods` VALUES (17629642,55,600,1); -- IDLE_DESPAWN: 600

-- Tribunus Vii-I
INSERT INTO `mob_spawn_mods` VALUES (17629643,1,6000,1); -- GIL_MIN: 6000
INSERT INTO `mob_spawn_mods` VALUES (17629643,2,9234,1); -- GIL_MAX: 9234
INSERT INTO `mob_spawn_mods` VALUES (17629643,55,900,1); -- IDLE_DESPAWN: 900

-- Proconsul Xii
INSERT INTO `mob_spawn_mods` VALUES (17629644,1,6000,1); -- GIL_MIN: 6000
INSERT INTO `mob_spawn_mods` VALUES (17629644,2,9234,1); -- GIL_MAX: 9234

-- Ubume
INSERT INTO `mob_spawn_mods` VALUES (17649860,55,300,1); -- IDLE_DESPAWN: 300

-- Enagakure
INSERT INTO `mob_spawn_mods` VALUES (17678351,55,600,1); -- IDLE_DESPAWN: 600

-- [Narasimha]
-- Values taken from wiki on 04/23/2018 (http://ffxiclopedia.wikia.com/wiki/Narasimha)
INSERT INTO `mob_spawn_mods` VALUES (17649784,1,12000,1); -- min gil 12000
INSERT INTO `mob_spawn_mods` VALUES (17649784,2,20000,1); -- max gil 30000
INSERT INTO `mob_spawn_mods` VALUES (17649784,15,4800,1); -- mug gil 4800

-- Sewer Syrup
INSERT INTO `mob_spawn_mods` VALUES (17461307,1,4000,1);
INSERT INTO `mob_spawn_mods` VALUES (17461307,2,19000,1);
INSERT INTO `mob_spawn_mods` VALUES (17461307,15,3500,1);

/*!40000 ALTER TABLE `mob_spawn_mods` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
