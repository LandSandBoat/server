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
) ENGINE=Aria TRANSACTIONAL=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci AVG_ROW_LENGTH=13 PACK_KEYS=1;
/*!40101 SET character_set_client = @saved_cs_client */;

-- Variables
SET @NONE                   =  0;
SET @GIL_MIN                =  1;
SET @GIL_MAX                =  2;
SET @MP_BASE                =  3;
SET @SIGHT_RANGE            =  4;
SET @SOUND_RANGE            =  5;
SET @BUFF_CHANCE            =  6;
SET @GA_CHANCE              =  7;
SET @HEAL_CHANCE            =  8;
SET @HP_HEAL_CHANCE         =  9;
SET @SUBLINK                = 10;
SET @LINK_RADIUS            = 11;
SET @DRAW_IN                = 12;
SET @SEVERE_SPELL_CHANCE    = 13;
SET @SKILL_LIST             = 14;
SET @MUG_GIL                = 15;
SET @DETECTION              = 16;
SET @NO_DESPAWN             = 17;
SET @VAR                    = 18;
SET @CAN_SHIELD_BLOCK       = 19;
SET @TP_USE_CHANCE          = 20;
SET @PET_SPELL_LIST         = 21;
SET @NA_CHANCE              = 22;
SET @IMMUNITY               = 23;
SET @GRADUAL_RAGE           = 24;
SET @BUILD_RESIST           = 25;
SET @SUPERLINK              = 26;
SET @SPELL_LIST             = 27;
SET @EXP_BONUS              = 28;
SET @ASSIST                 = 29;
SET @SPECIAL_SKILL          = 30;
SET @ROAM_DISTANCE          = 31;
SET @DONT_ROAM_HOME         = 32;
SET @SPECIAL_COOL           = 33;
SET @MAGIC_COOL             = 34;
SET @STANDBACK_COOL         = 35;
SET @ROAM_COOL              = 36;
SET @ALWAYS_AGGRO           = 37;
SET @NO_DROPS               = 38;
SET @SHARE_POS              = 39;
SET @TELEPORT_CD            = 40;
SET @TELEPORT_START         = 41;
SET @TELEPORT_END           = 42;
SET @TELEPORT_TYPE          = 43;
SET @DUAL_WIELD             = 44;
SET @ADD_EFFECT             = 45;
SET @AUTO_SPIKES            = 46;
SET @SPAWN_LEASH            = 47;
SET @SHARE_TARGET           = 48;
SET @CHECK_AS_NM            = 49;
SET @ROAM_RESET_FACING      = 50;
SET @ROAM_TURNS             = 51;
SET @ROAM_RATE              = 52;
SET @BEHAVIOR               = 53;
SET @GIL_BONUS              = 54;
SET @IDLE_DESPAWN           = 55;
SET @HP_STANDBACK           = 56;
SET @MAGIC_DELAY            = 57;
SET @SPECIAL_DELAY          = 58;
SET @WEAPON_BONUS           = 59;
SET @SPAWN_ANIMATIONSUB     = 60;
SET @HP_SCALE               = 61;
SET @NO_STANDBACK           = 62;
SET @ATTACK_SKILL_LIST      = 63;
SET @CHARMABLE              = 64;
SET @NO_MOVE                = 65;
SET @MULTI_HIT              = 66;
SET @NO_AGGRO               = 67;
SET @ALLI_HATE              = 68;
SET @NO_LINK                = 69;
SET @NO_REST                = 70;
SET @LEADER                 = 71;
SET @MAGIC_RANGE            = 72;
SET @TARGET_DISTANCE_OFFSET = 73;
SET @ONE_WAY_LINKING        = 74;
SET @CAN_PARRY              = 75;
SET @NO_WIDESCAN            = 76;
SET @TRUST_DISTANCE         = 77;

--
-- Dumping data for table `mob_spawn_mods`
--

LOCK TABLES `mob_spawn_mods` WRITE;
/*!40000 ALTER TABLE `mob_spawn_mods` DISABLE KEYS */;

-- Overgrown Ivy
INSERT INTO `mob_spawn_mods` VALUES (16785709,@IDLE_DESPAWN,180,1);

-- Cryptonberry Executor
INSERT INTO `mob_spawn_mods` VALUES (16785710,@IDLE_DESPAWN,180,1);

-- Cryptonberry Assassin
INSERT INTO `mob_spawn_mods` VALUES (16785711,@IDLE_DESPAWN,420,1);

-- Cryptonberry Assassin
INSERT INTO `mob_spawn_mods` VALUES (16785712,@IDLE_DESPAWN,420,1);

-- Cryptonberry Assassin
INSERT INTO `mob_spawn_mods` VALUES (16785713,@IDLE_DESPAWN,420,1);

-- Mycophile
INSERT INTO `mob_spawn_mods` VALUES (16785722,@IDLE_DESPAWN,300,1);

-- Dalham
INSERT INTO `mob_spawn_mods` VALUES (16793858,@IDLE_DESPAWN,180,1);

-- Shen
INSERT INTO `mob_spawn_mods` VALUES (16793859,@IDLE_DESPAWN,180,1);

-- Shen'S Filtrate
INSERT INTO `mob_spawn_mods` VALUES (16793860,@IDLE_DESPAWN,180,1);

-- Shen'S Filtrate
INSERT INTO `mob_spawn_mods` VALUES (16793861,@IDLE_DESPAWN,180,1);

-- Jormungand
INSERT INTO `mob_spawn_mods` VALUES (16797969,@DRAW_IN,15,1);

-- Geush Urvan
INSERT INTO `mob_spawn_mods` VALUES (16798078,@IDLE_DESPAWN,1800,1);

-- Lioumere
INSERT INTO `mob_spawn_mods` VALUES (16806031,@IDLE_DESPAWN,180,1);

-- Sargas
INSERT INTO `mob_spawn_mods` VALUES (16806117,288,40,0);

-- Xolotl
INSERT INTO `mob_spawn_mods` VALUES (16806215,@SUPERLINK,32,1);

-- Xolotl'S Hound Warrior
INSERT INTO `mob_spawn_mods` VALUES (16806216,@SUPERLINK,32,1);

-- Xolotl'S Sacrifice
INSERT INTO `mob_spawn_mods` VALUES (16806217,@SUPERLINK,32,1);

-- Tiamat
INSERT INTO `mob_spawn_mods` VALUES (16806227,@DRAW_IN,8,1);

-- Feeler Antlion
INSERT INTO `mob_spawn_mods` VALUES (16806242,@IDLE_DESPAWN,120,1);

-- Executioner Antlion
INSERT INTO `mob_spawn_mods` VALUES (16806243,@IDLE_DESPAWN,120,1);

-- Executioner Antlion
INSERT INTO `mob_spawn_mods` VALUES (16806244,@IDLE_DESPAWN,120,1);

-- Executioner Antlion
INSERT INTO `mob_spawn_mods` VALUES (16806245,@IDLE_DESPAWN,120,1);

-- Executioner Antlion
INSERT INTO `mob_spawn_mods` VALUES (16806246,@IDLE_DESPAWN,120,1);

-- Executioner Antlion
INSERT INTO `mob_spawn_mods` VALUES (16806247,@IDLE_DESPAWN,120,1);

-- Gargoyle
INSERT INTO `mob_spawn_mods` VALUES (16814081,@IDLE_DESPAWN,120,1);

-- Gargoyle
INSERT INTO `mob_spawn_mods` VALUES (16814082,@IDLE_DESPAWN,120,1);

-- Gargoyle
INSERT INTO `mob_spawn_mods` VALUES (16814083,@IDLE_DESPAWN,120,1);

-- Gargoyle
INSERT INTO `mob_spawn_mods` VALUES (16814084,@IDLE_DESPAWN,120,1);

-- Gargoyle
INSERT INTO `mob_spawn_mods` VALUES (16814085,@IDLE_DESPAWN,120,1);

-- Gargoyle
INSERT INTO `mob_spawn_mods` VALUES (16814086,@IDLE_DESPAWN,120,1);

-- Gargoyle
INSERT INTO `mob_spawn_mods` VALUES (16814087,@IDLE_DESPAWN,120,1);

-- Gargoyle
INSERT INTO `mob_spawn_mods` VALUES (16814088,@IDLE_DESPAWN,120,1);

-- Gargoyle
INSERT INTO `mob_spawn_mods` VALUES (16814089,@IDLE_DESPAWN,120,1);

-- Gargoyle
INSERT INTO `mob_spawn_mods` VALUES (16814090,@IDLE_DESPAWN,120,1);

-- Gargoyle
INSERT INTO `mob_spawn_mods` VALUES (16814091,@IDLE_DESPAWN,120,1);

-- Gargoyle
INSERT INTO `mob_spawn_mods` VALUES (16814092,@IDLE_DESPAWN,120,1);

-- Gargoyle
INSERT INTO `mob_spawn_mods` VALUES (16814093,@IDLE_DESPAWN,120,1);

-- Gargoyle
INSERT INTO `mob_spawn_mods` VALUES (16814094,@IDLE_DESPAWN,120,1);

-- Gargoyle
INSERT INTO `mob_spawn_mods` VALUES (16814095,@IDLE_DESPAWN,120,1);

-- Gargoyle
INSERT INTO `mob_spawn_mods` VALUES (16814096,@IDLE_DESPAWN,120,1);

-- Nunyunuwi
INSERT INTO `mob_spawn_mods` VALUES (16814361,@IDLE_DESPAWN,240,1);

-- Golden-Tongued Culberry
INSERT INTO `mob_spawn_mods` VALUES (16814432,@GIL_MIN,18000,1);
INSERT INTO `mob_spawn_mods` VALUES (16814432,@GIL_MAX,19800,1);
INSERT INTO `mob_spawn_mods` VALUES (16814432,@HP_HEAL_CHANCE,80,1);
INSERT INTO `mob_spawn_mods` VALUES (16814432,@ASSIST,33,0);
INSERT INTO `mob_spawn_mods` VALUES (16814432,@IDLE_DESPAWN,900,1);
INSERT INTO `mob_spawn_mods` VALUES (16814432,168,2,0);
INSERT INTO `mob_spawn_mods` VALUES (16814432,170,50,0);

-- Goblin Wolfman
INSERT INTO `mob_spawn_mods` VALUES (16822459,@IDLE_DESPAWN,300,1);

-- Mimic
INSERT INTO `mob_spawn_mods` VALUES (16826564,@IDLE_DESPAWN,120,1);

-- Bugbear Matman
INSERT INTO `mob_spawn_mods` VALUES (16826570,@IDLE_DESPAWN,300,1);

-- Ponderer
INSERT INTO `mob_spawn_mods` VALUES (16867329,@IDLE_DESPAWN,240,1);

-- Propagator
INSERT INTO `mob_spawn_mods` VALUES (16867330,@IDLE_DESPAWN,240,1);

-- Solicitor
INSERT INTO `mob_spawn_mods` VALUES (16867333,@IDLE_DESPAWN,240,1);

-- Wanderer
INSERT INTO `mob_spawn_mods` VALUES (16867455,@IDLE_DESPAWN,180,1);

-- Weeper
INSERT INTO `mob_spawn_mods` VALUES (16867544,@IDLE_DESPAWN,180,1);

-- Weeper
INSERT INTO `mob_spawn_mods` VALUES (16867642,@IDLE_DESPAWN,180,1);

-- Splinterspine Grukjuk
INSERT INTO `mob_spawn_mods` VALUES (16875774,@IDLE_DESPAWN,120,1);

-- Kurrea
INSERT INTO `mob_spawn_mods` VALUES (16875778,@IDLE_DESPAWN,120,1);

-- Amaltheia
INSERT INTO `mob_spawn_mods` VALUES (16875779,@IDLE_DESPAWN,120,1);

-- Warder Aglaia
INSERT INTO `mob_spawn_mods` VALUES (16879893,@IDLE_DESPAWN,180,1);

-- Warder Euphrosyne
INSERT INTO `mob_spawn_mods` VALUES (16879894,@IDLE_DESPAWN,180,1);

-- Warder Thalia
INSERT INTO `mob_spawn_mods` VALUES (16879895,@IDLE_DESPAWN,180,1);

-- Boggelmann
INSERT INTO `mob_spawn_mods` VALUES (16879897,@IDLE_DESPAWN,180,1);

-- Gration
INSERT INTO `mob_spawn_mods` VALUES (16879899,@IDLE_DESPAWN,900,1);

-- Minotaur
INSERT INTO `mob_spawn_mods` VALUES (16887889,@DRAW_IN,15,1);

-- Old Professor Mariselle
INSERT INTO `mob_spawn_mods` VALUES (16891970,@IDLE_DESPAWN,300,1);

-- Balor
INSERT INTO `mob_spawn_mods` VALUES (16892068,@IDLE_DESPAWN,180,1);

-- Luaith
INSERT INTO `mob_spawn_mods` VALUES (16892069,@IDLE_DESPAWN,180,1);

-- Lobais
INSERT INTO `mob_spawn_mods` VALUES (16892070,@IDLE_DESPAWN,180,1);

-- Caithleann
INSERT INTO `mob_spawn_mods` VALUES (16892073,@IDLE_DESPAWN,180,1);

-- Indich
INSERT INTO `mob_spawn_mods` VALUES (16892074,@IDLE_DESPAWN,180,1);

-- Vrtra
INSERT INTO `mob_spawn_mods` VALUES (16896161,@DRAW_IN,15,1);

-- Ouryu
INSERT INTO `mob_spawn_mods` VALUES (16900314,@DRAW_IN,15,1);

-- Ul'Xzomit
INSERT INTO `mob_spawn_mods` VALUES (16912394,@LEADER,2,1);

-- Ul'Xzomit
INSERT INTO `mob_spawn_mods` VALUES (16912409,@LEADER,2,1);

-- Ul'Xzomit
INSERT INTO `mob_spawn_mods` VALUES (16912422,@LEADER,2,1);

-- Ul'Xzomit
INSERT INTO `mob_spawn_mods` VALUES (16912426,@LEADER,2,1);

-- Ul'Xzomit
INSERT INTO `mob_spawn_mods` VALUES (16912429,@LEADER,2,1);

-- Ul'Xzomit
INSERT INTO `mob_spawn_mods` VALUES (16912432,@LEADER,2,1);

-- Ul'Xzomit
INSERT INTO `mob_spawn_mods` VALUES (16912435,@LEADER,2,1);

-- Ul'Xzomit
INSERT INTO `mob_spawn_mods` VALUES (16912443,@LEADER,2,1);

-- Ul'Xzomit
INSERT INTO `mob_spawn_mods` VALUES (16912446,@LEADER,2,1);

-- Ul'Xzomit
INSERT INTO `mob_spawn_mods` VALUES (16912449,@LEADER,2,1);

-- Ul'Xzomit
INSERT INTO `mob_spawn_mods` VALUES (16912452,@LEADER,2,1);

-- Ul'Xzomit
INSERT INTO `mob_spawn_mods` VALUES (16912455,@LEADER,2,1);

-- Ul'Xzomit
INSERT INTO `mob_spawn_mods` VALUES (16912468,@LEADER,2,1);

-- Ul'Xzomit
INSERT INTO `mob_spawn_mods` VALUES (16912545,@LEADER,2,1);

-- Ul'Xzomit
INSERT INTO `mob_spawn_mods` VALUES (16912548,@LEADER,2,1);

-- Ru'Aern
INSERT INTO `mob_spawn_mods` VALUES (16912829,@IDLE_DESPAWN,180,1);

-- Ru'Aern
INSERT INTO `mob_spawn_mods` VALUES (16912830,@IDLE_DESPAWN,180,1);

-- Ru'Aern
INSERT INTO `mob_spawn_mods` VALUES (16912831,@IDLE_DESPAWN,180,1);

-- Ru'Aern
INSERT INTO `mob_spawn_mods` VALUES (16912832,@IDLE_DESPAWN,180,1);

-- Ru'Aern
INSERT INTO `mob_spawn_mods` VALUES (16912833,@IDLE_DESPAWN,180,1);

-- Ru'Aern
INSERT INTO `mob_spawn_mods` VALUES (16912834,@IDLE_DESPAWN,180,1);

-- Ru'Aern
INSERT INTO `mob_spawn_mods` VALUES (16912835,@IDLE_DESPAWN,180,1);

-- Ru'Aern
INSERT INTO `mob_spawn_mods` VALUES (16912836,@IDLE_DESPAWN,180,1);

-- Ru'Aern
INSERT INTO `mob_spawn_mods` VALUES (16912837,@IDLE_DESPAWN,180,1);

-- Jailer Of Hope
INSERT INTO `mob_spawn_mods` VALUES (16912838,@GA_CHANCE,60,1);
INSERT INTO `mob_spawn_mods` VALUES (16912838,@IDLE_DESPAWN,300,1);
INSERT INTO `mob_spawn_mods` VALUES (16912838,407,150,0);

-- Jailer Of Justice
INSERT INTO `mob_spawn_mods` VALUES (16912839,@IDLE_DESPAWN,300,1);

-- Jailer Of Prudence
INSERT INTO `mob_spawn_mods` VALUES (16912846,@IDLE_DESPAWN,300,1);

-- Jailer Of Prudence
INSERT INTO `mob_spawn_mods` VALUES (16912847,@IDLE_DESPAWN,300,1);

-- Jailer Of Love
INSERT INTO `mob_spawn_mods` VALUES (16912848,@IDLE_DESPAWN,300,1);

-- Ix'Ghrah
INSERT INTO `mob_spawn_mods` VALUES (16916813,@IDLE_DESPAWN,180,1);

-- Jailer Of Temperance
INSERT INTO `mob_spawn_mods` VALUES (16916814,@IDLE_DESPAWN,300,1);

-- Ix'Aern
INSERT INTO `mob_spawn_mods` VALUES (16916815,@IDLE_DESPAWN,300,1);

-- Qn'Aern
INSERT INTO `mob_spawn_mods` VALUES (16916816,@IDLE_DESPAWN,300,1);

-- Qn'Aern
INSERT INTO `mob_spawn_mods` VALUES (16916817,@IDLE_DESPAWN,300,1);

-- Qn'Zdei
INSERT INTO `mob_spawn_mods` VALUES (16920577,@SUPERLINK,1000,1);
INSERT INTO `mob_spawn_mods` VALUES (16920578,@SUPERLINK,1000,1);
INSERT INTO `mob_spawn_mods` VALUES (16920579,@SUPERLINK,1000,1);
INSERT INTO `mob_spawn_mods` VALUES (16920580,@SUPERLINK,1000,1);
INSERT INTO `mob_spawn_mods` VALUES (16920581,@SUPERLINK,1001,1);
INSERT INTO `mob_spawn_mods` VALUES (16920582,@SUPERLINK,1001,1);
INSERT INTO `mob_spawn_mods` VALUES (16920583,@SUPERLINK,1001,1);
INSERT INTO `mob_spawn_mods` VALUES (16920584,@SUPERLINK,1001,1);
INSERT INTO `mob_spawn_mods` VALUES (16920585,@SUPERLINK,1002,1);
INSERT INTO `mob_spawn_mods` VALUES (16920586,@SUPERLINK,1002,1);
INSERT INTO `mob_spawn_mods` VALUES (16920587,@SUPERLINK,1002,1);
INSERT INTO `mob_spawn_mods` VALUES (16920588,@SUPERLINK,1002,1);
INSERT INTO `mob_spawn_mods` VALUES (16920764,@SUPERLINK,1003,1);
INSERT INTO `mob_spawn_mods` VALUES (16920765,@SUPERLINK,1003,1);
INSERT INTO `mob_spawn_mods` VALUES (16920766,@SUPERLINK,1003,1);
INSERT INTO `mob_spawn_mods` VALUES (16920767,@SUPERLINK,1003,1);

-- Jailer Of Fortitude
INSERT INTO `mob_spawn_mods` VALUES (16921015,@IDLE_DESPAWN,180,1);
INSERT INTO `mob_spawn_mods` VALUES (16921015,387,-95,0);
INSERT INTO `mob_spawn_mods` VALUES (16921015,390,-95,0);

-- Kf'Ghrah
INSERT INTO `mob_spawn_mods` VALUES (16921016,@IDLE_DESPAWN,180,1);

-- Kf'Ghrah
INSERT INTO `mob_spawn_mods` VALUES (16921017,@IDLE_DESPAWN,180,1);

-- Ix'Aern
INSERT INTO `mob_spawn_mods` VALUES (16921018,@IDLE_DESPAWN,180,1);

-- Qn'Aern
INSERT INTO `mob_spawn_mods` VALUES (16921019,@IDLE_DESPAWN,180,1);

-- Qn'Aern
INSERT INTO `mob_spawn_mods` VALUES (16921020,@IDLE_DESPAWN,180,1);

-- Jailer Of Faith
INSERT INTO `mob_spawn_mods` VALUES (16921021,@IDLE_DESPAWN,900,1);

-- Ix'Aern
INSERT INTO `mob_spawn_mods` VALUES (16921022,@IDLE_DESPAWN,300,1);

-- Aern'S Wynav
INSERT INTO `mob_spawn_mods` VALUES (16921023,@IDLE_DESPAWN,300,1);

-- Aern'S Wynav
INSERT INTO `mob_spawn_mods` VALUES (16921024,@IDLE_DESPAWN,300,1);

-- Aern'S Wynav
INSERT INTO `mob_spawn_mods` VALUES (16921025,@IDLE_DESPAWN,300,1);

-- Vulpangue
INSERT INTO `mob_spawn_mods` VALUES (16986428,@IDLE_DESPAWN,180,1);

-- Iriz Ima
INSERT INTO `mob_spawn_mods` VALUES (16986429,@IDLE_DESPAWN,180,1);

-- Gotoh Zha The Redolent
INSERT INTO `mob_spawn_mods` VALUES (16986430,@IDLE_DESPAWN,180,1);

-- Tinnin
INSERT INTO `mob_spawn_mods` VALUES (16986431,@IDLE_DESPAWN,180,1);

-- Lamia'S Skeleton
INSERT INTO `mob_spawn_mods` VALUES (16998869,@IDLE_DESPAWN,180,1);

-- Lamia'S Skeleton
INSERT INTO `mob_spawn_mods` VALUES (16998870,@IDLE_DESPAWN,180,1);

-- Lil' Apkallu
INSERT INTO `mob_spawn_mods` VALUES (16998871,@IDLE_DESPAWN,180,1);

-- Velionis
INSERT INTO `mob_spawn_mods` VALUES (16998872,@IDLE_DESPAWN,180,1);

-- Zareehkl The Jubilant
INSERT INTO `mob_spawn_mods` VALUES (16998873,@IDLE_DESPAWN,180,1);

-- Nuhn
INSERT INTO `mob_spawn_mods` VALUES (16998874,@IDLE_DESPAWN,180,1);

-- Brass Borer
INSERT INTO `mob_spawn_mods` VALUES (17027471,@IDLE_DESPAWN,180,1);

-- Claret
INSERT INTO `mob_spawn_mods` VALUES (17027472,@IDLE_DESPAWN,180,1);

-- Anantaboga
INSERT INTO `mob_spawn_mods` VALUES (17027473,@IDLE_DESPAWN,180,1);

-- Khromasoul Bhurborlor
INSERT INTO `mob_spawn_mods` VALUES (17027474,@IDLE_DESPAWN,180,1);

-- Sarameya
INSERT INTO `mob_spawn_mods` VALUES (17027485,@IDLE_DESPAWN,180,1);

-- Big Bomb
INSERT INTO `mob_spawn_mods` VALUES (17031401,@IDLE_DESPAWN,900,1);

-- Dextrose
INSERT INTO `mob_spawn_mods` VALUES (17031598,@IDLE_DESPAWN,180,1);

-- Reacton
INSERT INTO `mob_spawn_mods` VALUES (17031599,@IDLE_DESPAWN,180,1);

-- Achamoth
INSERT INTO `mob_spawn_mods` VALUES (17031600,@IDLE_DESPAWN,180,1);

-- Mamool Ja Chamberlain
INSERT INTO `mob_spawn_mods` VALUES (17043876,@IDLE_DESPAWN,180,1);

-- Mamool Ja Chamberlain
INSERT INTO `mob_spawn_mods` VALUES (17043877,@IDLE_DESPAWN,180,1);

-- Mamool Ja Palatine
INSERT INTO `mob_spawn_mods` VALUES (17043878,@IDLE_DESPAWN,180,1);

-- Mamool Ja Palatine
INSERT INTO `mob_spawn_mods` VALUES (17043879,@IDLE_DESPAWN,180,1);

-- Chamrosh
INSERT INTO `mob_spawn_mods` VALUES (17043887,@IDLE_DESPAWN,180,1);

-- Iriri Samariri
INSERT INTO `mob_spawn_mods` VALUES (17043888,@IDLE_DESPAWN,180,1);

-- Nosferatu
INSERT INTO `mob_spawn_mods` VALUES (17056157,@IDLE_DESPAWN,180,1);

-- Pandemonium Warden
INSERT INTO `mob_spawn_mods` VALUES (17056168,@IDLE_DESPAWN,180,1);

-- Pandemonium Lamp
INSERT INTO `mob_spawn_mods` VALUES (17056170,@IDLE_DESPAWN,180,1);

-- Pandemonium Lamp
INSERT INTO `mob_spawn_mods` VALUES (17056171,@IDLE_DESPAWN,180,1);

-- Pandemonium Lamp
INSERT INTO `mob_spawn_mods` VALUES (17056172,@IDLE_DESPAWN,180,1);

-- Pandemonium Lamp
INSERT INTO `mob_spawn_mods` VALUES (17056173,@IDLE_DESPAWN,180,1);

-- Pandemonium Lamp
INSERT INTO `mob_spawn_mods` VALUES (17056174,@IDLE_DESPAWN,180,1);

-- Pandemonium Lamp
INSERT INTO `mob_spawn_mods` VALUES (17056175,@IDLE_DESPAWN,180,1);

-- Pandemonium Lamp
INSERT INTO `mob_spawn_mods` VALUES (17056176,@IDLE_DESPAWN,180,1);

-- Pandemonium Lamp
INSERT INTO `mob_spawn_mods` VALUES (17056177,@IDLE_DESPAWN,180,1);

-- Chigre
INSERT INTO `mob_spawn_mods` VALUES (17056186,@IDLE_DESPAWN,180,1);

-- Ob
INSERT INTO `mob_spawn_mods` VALUES (17072171,@IDLE_DESPAWN,180,1);

-- Cheese Hoarder Gigiroon
INSERT INTO `mob_spawn_mods` VALUES (17072172,@IDLE_DESPAWN,180,1);

-- Armed Gears
INSERT INTO `mob_spawn_mods` VALUES (17072178,@IDLE_DESPAWN,180,1);

-- Wulgaru
INSERT INTO `mob_spawn_mods` VALUES (17072179,@IDLE_DESPAWN,180,1);

-- Verdelet
INSERT INTO `mob_spawn_mods` VALUES (17101202,@IDLE_DESPAWN,180,1);

-- Tyger
INSERT INTO `mob_spawn_mods` VALUES (17101203,@IDLE_DESPAWN,180,1);

-- Mahjlaef The Paintorn
INSERT INTO `mob_spawn_mods` VALUES (17101204,@IDLE_DESPAWN,180,1);

-- Experimental Lamia
INSERT INTO `mob_spawn_mods` VALUES (17101205,@IDLE_DESPAWN,180,1);

-- Fingerfilcher Dradzad
INSERT INTO `mob_spawn_mods` VALUES (17113462,@IDLE_DESPAWN,180,1);

-- Cobraclaw Buchzvotch
INSERT INTO `mob_spawn_mods` VALUES (17113464,@IDLE_DESPAWN,180,1);

-- Kinepikwa
INSERT INTO `mob_spawn_mods` VALUES (17146147,@IDLE_DESPAWN,300,1);

-- War Lynx
INSERT INTO `mob_spawn_mods` VALUES (17170645,@IDLE_DESPAWN,180,1);

-- Bloodlapper
INSERT INTO `mob_spawn_mods` VALUES (17174889,@IDLE_DESPAWN,1800,1);

-- Amanita
INSERT INTO `mob_spawn_mods` VALUES (17186927,368,33,0);

-- Slumbering Samwell
INSERT INTO `mob_spawn_mods` VALUES (17195221,368,33,0);

-- Marchelute
INSERT INTO `mob_spawn_mods` VALUES (17199566,@IDLE_DESPAWN,300,1);

-- Doman
INSERT INTO `mob_spawn_mods` VALUES (17199567,@IDLE_DESPAWN,300,1);

-- Onryo
INSERT INTO `mob_spawn_mods` VALUES (17199568,@IDLE_DESPAWN,300,1);

-- King Arthro
INSERT INTO `mob_spawn_mods` VALUES (17203216,@GIL_MIN,15000,1);
INSERT INTO `mob_spawn_mods` VALUES (17203216,@GIL_MAX,20000,1);

-- Lumber Jack
INSERT INTO `mob_spawn_mods` VALUES (17207308,@GIL_MIN,15000,1);
INSERT INTO `mob_spawn_mods` VALUES (17207308,@GIL_MAX,20000,1);
INSERT INTO `mob_spawn_mods` VALUES (17207308,@MUG_GIL,7500,1);

-- Sturmtiger
INSERT INTO `mob_spawn_mods` VALUES (17207696,@IDLE_DESPAWN,300,1);

-- Suparna
INSERT INTO `mob_spawn_mods` VALUES (17207697,@IDLE_DESPAWN,600,1);

-- Suparna Fledgling
INSERT INTO `mob_spawn_mods` VALUES (17207698,@IDLE_DESPAWN,600,1);

-- Vegnix Greenthumb
INSERT INTO `mob_spawn_mods` VALUES (17207710,@IDLE_DESPAWN,180,1);

-- Gambilox Wanderling
INSERT INTO `mob_spawn_mods` VALUES (17211848,@IDLE_DESPAWN,120,1);

-- Bubbly Bernie
INSERT INTO `mob_spawn_mods` VALUES (17215494,@IDLE_DESPAWN,288,1);

-- Simurgh
INSERT INTO `mob_spawn_mods` VALUES (17228242,@GIL_MIN,21000,1);
INSERT INTO `mob_spawn_mods` VALUES (17228242,@GIL_MAX,31300,1);

-- Chuglix Berrypaws
INSERT INTO `mob_spawn_mods` VALUES (17228249,@IDLE_DESPAWN,180,1);

-- Shadow Dragon
INSERT INTO `mob_spawn_mods` VALUES (17235987,@GIL_MIN,1076,1);
INSERT INTO `mob_spawn_mods` VALUES (17235987,@GIL_MAX,2765,1);

-- Chaos Elemental
INSERT INTO `mob_spawn_mods` VALUES (17236201,@IDLE_DESPAWN,180,1);

-- Boreal Hound
INSERT INTO `mob_spawn_mods` VALUES (17236202,@DRAW_IN,15,1);
INSERT INTO `mob_spawn_mods` VALUES (17236202,160,50,0);

-- Boreal Coeurl
INSERT INTO `mob_spawn_mods` VALUES (17236203,@DRAW_IN,15,1);
INSERT INTO `mob_spawn_mods` VALUES (17236203,@IMMUNITY,8,1);

-- Boreal Tiger
INSERT INTO `mob_spawn_mods` VALUES (17236204,@DRAW_IN,15,1);

-- Koenigstiger
INSERT INTO `mob_spawn_mods` VALUES (17236205,@IDLE_DESPAWN,240,1);

-- Tegmine
INSERT INTO `mob_spawn_mods` VALUES (17240232,@IMMUNITY,50,0);
INSERT INTO `mob_spawn_mods` VALUES (17240232,288,40,0);

-- Axesarion The Wanderer
INSERT INTO `mob_spawn_mods` VALUES (17240414,@IDLE_DESPAWN,300,1);

-- Decurio I-Iii
INSERT INTO `mob_spawn_mods` VALUES (17244523,@IDLE_DESPAWN,300,1);

-- Tsuchigumo
INSERT INTO `mob_spawn_mods` VALUES (17244524,@IDLE_DESPAWN,300,1);

-- Tsuchigumo
INSERT INTO `mob_spawn_mods` VALUES (17244525,@IDLE_DESPAWN,300,1);

-- Roc
INSERT INTO `mob_spawn_mods` VALUES (17269106,@GIL_MIN,15000,1);
INSERT INTO `mob_spawn_mods` VALUES (17269106,@GIL_MAX,30545,1);

-- Climbpix Highrise
INSERT INTO `mob_spawn_mods` VALUES (17269107,@IDLE_DESPAWN,120,1);

-- Dribblix Greasemaw
INSERT INTO `mob_spawn_mods` VALUES (17269114,@IDLE_DESPAWN,180,1);

-- Guardian Treant
INSERT INTO `mob_spawn_mods` VALUES (17272838,@IDLE_DESPAWN,288,1);

-- Doomed Pilgrims
INSERT INTO `mob_spawn_mods` VALUES (17272839,@IDLE_DESPAWN,300,1);

-- Isonade
INSERT INTO `mob_spawn_mods` VALUES (17273285,@IDLE_DESPAWN,180,1);

-- Tipha
INSERT INTO `mob_spawn_mods` VALUES (17281030,@IDLE_DESPAWN,300,1);

-- Carthi
INSERT INTO `mob_spawn_mods` VALUES (17281031,@IDLE_DESPAWN,300,1);

-- Bisque-Heeled Sunberry
INSERT INTO `mob_spawn_mods` VALUES (17285460,@GIL_MIN,379,1);
INSERT INTO `mob_spawn_mods` VALUES (17285460,@GIL_MAX,900,1);

-- Kappa Akuso
INSERT INTO `mob_spawn_mods` VALUES (17285544,@IDLE_DESPAWN,150,1);

-- Kappa Bonze
INSERT INTO `mob_spawn_mods` VALUES (17285545,@IDLE_DESPAWN,300,1);

-- Kappa Biwa
INSERT INTO `mob_spawn_mods` VALUES (17285546,@IDLE_DESPAWN,150,1);

-- King Vinegarroon
INSERT INTO `mob_spawn_mods` VALUES (17289575,@DRAW_IN,15,1);

-- Eastern Sphinx
INSERT INTO `mob_spawn_mods` VALUES (17289654,@IDLE_DESPAWN,168,1);

-- Western Sphinx
INSERT INTO `mob_spawn_mods` VALUES (17289655,@IDLE_DESPAWN,168,1);

-- Kraken
INSERT INTO `mob_spawn_mods` VALUES (17293486,@ROAM_DISTANCE,5,1);
INSERT INTO `mob_spawn_mods` VALUES (17293486,@ROAM_TURNS,1,1);

-- King Behemoth
INSERT INTO `mob_spawn_mods` VALUES (17297441,@DRAW_IN,25,1);

-- Picklix Longindex
INSERT INTO `mob_spawn_mods` VALUES (17297446,@IDLE_DESPAWN,180,1);

-- Moxnix Nightgoggle
INSERT INTO `mob_spawn_mods` VALUES (17297447,@IDLE_DESPAWN,180,1);

-- Doglix Muttsnout
INSERT INTO `mob_spawn_mods` VALUES (17297448,@IDLE_DESPAWN,180,1);

-- Ancient Weapon
INSERT INTO `mob_spawn_mods` VALUES (17297449,@IDLE_DESPAWN,300,1);

-- Legendary Weapon
INSERT INTO `mob_spawn_mods` VALUES (17297450,@IDLE_DESPAWN,300,1);

-- Despot
INSERT INTO `mob_spawn_mods` VALUES (17309954,@GIL_MIN,18000,1);
INSERT INTO `mob_spawn_mods` VALUES (17309954,@GIL_MAX,29250,1);
INSERT INTO `mob_spawn_mods` VALUES (17309954,@MUG_GIL,3250,1);

-- Mimic
INSERT INTO `mob_spawn_mods` VALUES (17309979,@IDLE_DESPAWN,120,1);

-- Genbu
INSERT INTO `mob_spawn_mods` VALUES (17309980,@GIL_MIN,1500,1);
INSERT INTO `mob_spawn_mods` VALUES (17309980,@GIL_MAX,29036,1);
INSERT INTO `mob_spawn_mods` VALUES (17309980,@IDLE_DESPAWN,300,1);

-- Seiryu
INSERT INTO `mob_spawn_mods` VALUES (17309981,@GIL_MIN,1500,1);
INSERT INTO `mob_spawn_mods` VALUES (17309981,@GIL_MAX,28608,1);
INSERT INTO `mob_spawn_mods` VALUES (17309981,@IDLE_DESPAWN,300,1);

-- Byakko
INSERT INTO `mob_spawn_mods` VALUES (17309982,@GIL_MIN,1500,1);
INSERT INTO `mob_spawn_mods` VALUES (17309982,@GIL_MAX,18000,1);
INSERT INTO `mob_spawn_mods` VALUES (17309982,@IDLE_DESPAWN,300,1);

-- Suzaku
INSERT INTO `mob_spawn_mods` VALUES (17309983,@GIL_MIN,1500,1);
INSERT INTO `mob_spawn_mods` VALUES (17309983,@GIL_MAX,28886,1);
INSERT INTO `mob_spawn_mods` VALUES (17309983,@IDLE_DESPAWN,300,1);

-- Satellite Shield
INSERT INTO `mob_spawn_mods` VALUES (17330290,@IDLE_DESPAWN,120,1);

-- Satellite Shield
INSERT INTO `mob_spawn_mods` VALUES (17330291,@IDLE_DESPAWN,120,1);

-- Satellite Shield
INSERT INTO `mob_spawn_mods` VALUES (17330292,@IDLE_DESPAWN,120,1);

-- Satellite Shield
INSERT INTO `mob_spawn_mods` VALUES (17330299,@IDLE_DESPAWN,120,1);

-- Satellite Shield
INSERT INTO `mob_spawn_mods` VALUES (17330300,@IDLE_DESPAWN,120,1);

-- Satellite Shield
INSERT INTO `mob_spawn_mods` VALUES (17330301,@IDLE_DESPAWN,120,1);

-- Satellite Daggers
INSERT INTO `mob_spawn_mods` VALUES (17330306,@IDLE_DESPAWN,120,1);

-- Satellite Daggers
INSERT INTO `mob_spawn_mods` VALUES (17330307,@IDLE_DESPAWN,120,1);

-- Satellite Daggers
INSERT INTO `mob_spawn_mods` VALUES (17330308,@IDLE_DESPAWN,120,1);

-- Satellite Knuckles
INSERT INTO `mob_spawn_mods` VALUES (17330309,@IDLE_DESPAWN,120,1);

-- Satellite Knuckles
INSERT INTO `mob_spawn_mods` VALUES (17330310,@IDLE_DESPAWN,120,1);

-- Satellite Knuckles
INSERT INTO `mob_spawn_mods` VALUES (17330311,@IDLE_DESPAWN,120,1);

-- Satellite Daggers
INSERT INTO `mob_spawn_mods` VALUES (17330316,@IDLE_DESPAWN,120,1);

-- Satellite Daggers
INSERT INTO `mob_spawn_mods` VALUES (17330317,@IDLE_DESPAWN,120,1);

-- Satellite Daggers
INSERT INTO `mob_spawn_mods` VALUES (17330318,@IDLE_DESPAWN,120,1);

-- Satellite Knuckles
INSERT INTO `mob_spawn_mods` VALUES (17330319,@IDLE_DESPAWN,120,1);

-- Satellite Knuckles
INSERT INTO `mob_spawn_mods` VALUES (17330320,@IDLE_DESPAWN,120,1);

-- Satellite Knuckles
INSERT INTO `mob_spawn_mods` VALUES (17330321,@IDLE_DESPAWN,120,1);

-- Satellite Hammers
INSERT INTO `mob_spawn_mods` VALUES (17330334,@IDLE_DESPAWN,120,1);

-- Satellite Hammers
INSERT INTO `mob_spawn_mods` VALUES (17330335,@IDLE_DESPAWN,120,1);

-- Satellite Hammers
INSERT INTO `mob_spawn_mods` VALUES (17330336,@IDLE_DESPAWN,120,1);

-- Satellite Staves
INSERT INTO `mob_spawn_mods` VALUES (17330337,@IDLE_DESPAWN,120,1);

-- Satellite Staves
INSERT INTO `mob_spawn_mods` VALUES (17330338,@IDLE_DESPAWN,120,1);

-- Satellite Staves
INSERT INTO `mob_spawn_mods` VALUES (17330339,@IDLE_DESPAWN,120,1);

-- Satellite Hammers
INSERT INTO `mob_spawn_mods` VALUES (17330344,@IDLE_DESPAWN,120,1);

-- Satellite Hammers
INSERT INTO `mob_spawn_mods` VALUES (17330345,@IDLE_DESPAWN,120,1);

-- Satellite Hammers
INSERT INTO `mob_spawn_mods` VALUES (17330346,@IDLE_DESPAWN,120,1);

-- Satellite Staves
INSERT INTO `mob_spawn_mods` VALUES (17330347,@IDLE_DESPAWN,120,1);

-- Satellite Staves
INSERT INTO `mob_spawn_mods` VALUES (17330348,@IDLE_DESPAWN,120,1);

-- Satellite Staves
INSERT INTO `mob_spawn_mods` VALUES (17330349,@IDLE_DESPAWN,120,1);

-- Satellite Longswords
INSERT INTO `mob_spawn_mods` VALUES (17330355,@IDLE_DESPAWN,120,1);

-- Satellite Longswords
INSERT INTO `mob_spawn_mods` VALUES (17330356,@IDLE_DESPAWN,120,1);

-- Satellite Longswords
INSERT INTO `mob_spawn_mods` VALUES (17330357,@IDLE_DESPAWN,120,1);

-- Satellite Longswords
INSERT INTO `mob_spawn_mods` VALUES (17330362,@IDLE_DESPAWN,120,1);

-- Satellite Longswords
INSERT INTO `mob_spawn_mods` VALUES (17330363,@IDLE_DESPAWN,120,1);

-- Satellite Longswords
INSERT INTO `mob_spawn_mods` VALUES (17330364,@IDLE_DESPAWN,120,1);

-- Satellite Claymores
INSERT INTO `mob_spawn_mods` VALUES (17330365,@IDLE_DESPAWN,120,1);

-- Satellite Claymores
INSERT INTO `mob_spawn_mods` VALUES (17330366,@IDLE_DESPAWN,120,1);

-- Satellite Claymores
INSERT INTO `mob_spawn_mods` VALUES (17330367,@IDLE_DESPAWN,120,1);

-- Satellite Claymores
INSERT INTO `mob_spawn_mods` VALUES (17330372,@IDLE_DESPAWN,120,1);

-- Satellite Claymores
INSERT INTO `mob_spawn_mods` VALUES (17330373,@IDLE_DESPAWN,120,1);

-- Satellite Claymores
INSERT INTO `mob_spawn_mods` VALUES (17330374,@IDLE_DESPAWN,120,1);

-- Satellite Tabars
INSERT INTO `mob_spawn_mods` VALUES (17330380,@IDLE_DESPAWN,120,1);

-- Satellite Tabars
INSERT INTO `mob_spawn_mods` VALUES (17330381,@IDLE_DESPAWN,120,1);

-- Satellite Tabars
INSERT INTO `mob_spawn_mods` VALUES (17330382,@IDLE_DESPAWN,120,1);

-- Satellite Great Axes
INSERT INTO `mob_spawn_mods` VALUES (17330383,@IDLE_DESPAWN,120,1);

-- Satellite Great Axes
INSERT INTO `mob_spawn_mods` VALUES (17330384,@IDLE_DESPAWN,120,1);

-- Satellite Great Axes
INSERT INTO `mob_spawn_mods` VALUES (17330385,@IDLE_DESPAWN,120,1);

-- Satellite Tabars
INSERT INTO `mob_spawn_mods` VALUES (17330392,@IDLE_DESPAWN,120,1);

-- Satellite Tabars
INSERT INTO `mob_spawn_mods` VALUES (17330393,@IDLE_DESPAWN,120,1);

-- Satellite Tabars
INSERT INTO `mob_spawn_mods` VALUES (17330394,@IDLE_DESPAWN,120,1);

-- Satellite Great Axes
INSERT INTO `mob_spawn_mods` VALUES (17330395,@IDLE_DESPAWN,120,1);

-- Satellite Great Axes
INSERT INTO `mob_spawn_mods` VALUES (17330396,@IDLE_DESPAWN,120,1);

-- Satellite Great Axes
INSERT INTO `mob_spawn_mods` VALUES (17330397,@IDLE_DESPAWN,120,1);

-- Satellite Scythes
INSERT INTO `mob_spawn_mods` VALUES (17330420,@IDLE_DESPAWN,120,1);

-- Satellite Scythes
INSERT INTO `mob_spawn_mods` VALUES (17330421,@IDLE_DESPAWN,120,1);

-- Satellite Scythes
INSERT INTO `mob_spawn_mods` VALUES (17330422,@IDLE_DESPAWN,120,1);

-- Satellite Spears
INSERT INTO `mob_spawn_mods` VALUES (17330423,@IDLE_DESPAWN,120,1);

-- Satellite Spears
INSERT INTO `mob_spawn_mods` VALUES (17330424,@IDLE_DESPAWN,120,1);

-- Satellite Spears
INSERT INTO `mob_spawn_mods` VALUES (17330425,@IDLE_DESPAWN,120,1);

-- Satellite Scythes
INSERT INTO `mob_spawn_mods` VALUES (17330432,@IDLE_DESPAWN,120,1);

-- Satellite Scythes
INSERT INTO `mob_spawn_mods` VALUES (17330433,@IDLE_DESPAWN,120,1);

-- Satellite Scythes
INSERT INTO `mob_spawn_mods` VALUES (17330434,@IDLE_DESPAWN,120,1);

-- Satellite Spears
INSERT INTO `mob_spawn_mods` VALUES (17330435,@IDLE_DESPAWN,120,1);

-- Satellite Spears
INSERT INTO `mob_spawn_mods` VALUES (17330436,@IDLE_DESPAWN,120,1);

-- Satellite Spears
INSERT INTO `mob_spawn_mods` VALUES (17330437,@IDLE_DESPAWN,120,1);

-- Satellite Kunai
INSERT INTO `mob_spawn_mods` VALUES (17330442,@IDLE_DESPAWN,120,1);

-- Satellite Kunai
INSERT INTO `mob_spawn_mods` VALUES (17330443,@IDLE_DESPAWN,120,1);

-- Satellite Kunai
INSERT INTO `mob_spawn_mods` VALUES (17330444,@IDLE_DESPAWN,120,1);

-- Satellite Tachi
INSERT INTO `mob_spawn_mods` VALUES (17330445,@IDLE_DESPAWN,120,1);

-- Satellite Tachi
INSERT INTO `mob_spawn_mods` VALUES (17330446,@IDLE_DESPAWN,120,1);

-- Satellite Tachi
INSERT INTO `mob_spawn_mods` VALUES (17330447,@IDLE_DESPAWN,120,1);

-- Satellite Kunai
INSERT INTO `mob_spawn_mods` VALUES (17330454,@IDLE_DESPAWN,120,1);

-- Satellite Kunai
INSERT INTO `mob_spawn_mods` VALUES (17330455,@IDLE_DESPAWN,120,1);

-- Satellite Kunai
INSERT INTO `mob_spawn_mods` VALUES (17330456,@IDLE_DESPAWN,120,1);

-- Satellite Tachi
INSERT INTO `mob_spawn_mods` VALUES (17330457,@IDLE_DESPAWN,120,1);

-- Satellite Tachi
INSERT INTO `mob_spawn_mods` VALUES (17330458,@IDLE_DESPAWN,120,1);

-- Satellite Tachi
INSERT INTO `mob_spawn_mods` VALUES (17330459,@IDLE_DESPAWN,120,1);

-- Satellite Horns
INSERT INTO `mob_spawn_mods` VALUES (17330495,@IDLE_DESPAWN,120,1);

-- Satellite Horns
INSERT INTO `mob_spawn_mods` VALUES (17330496,@IDLE_DESPAWN,120,1);

-- Satellite Horns
INSERT INTO `mob_spawn_mods` VALUES (17330497,@IDLE_DESPAWN,120,1);

-- Satellite Horns
INSERT INTO `mob_spawn_mods` VALUES (17330503,@IDLE_DESPAWN,120,1);

-- Satellite Horns
INSERT INTO `mob_spawn_mods` VALUES (17330504,@IDLE_DESPAWN,120,1);

-- Satellite Horns
INSERT INTO `mob_spawn_mods` VALUES (17330505,@IDLE_DESPAWN,120,1);

-- Satellite Guns
INSERT INTO `mob_spawn_mods` VALUES (17330513,@IDLE_DESPAWN,120,1);

-- Satellite Guns
INSERT INTO `mob_spawn_mods` VALUES (17330514,@IDLE_DESPAWN,120,1);

-- Satellite Guns
INSERT INTO `mob_spawn_mods` VALUES (17330515,@IDLE_DESPAWN,120,1);

-- Satellite Guns
INSERT INTO `mob_spawn_mods` VALUES (17330516,@IDLE_DESPAWN,120,1);

-- Satellite Guns
INSERT INTO `mob_spawn_mods` VALUES (17330517,@IDLE_DESPAWN,120,1);

-- Satellite Guns
INSERT INTO `mob_spawn_mods` VALUES (17330518,@IDLE_DESPAWN,120,1);

-- Satellite Longbows
INSERT INTO `mob_spawn_mods` VALUES (17330522,@IDLE_DESPAWN,120,1);

-- Satellite Longbows
INSERT INTO `mob_spawn_mods` VALUES (17330523,@IDLE_DESPAWN,120,1);

-- Satellite Longbows
INSERT INTO `mob_spawn_mods` VALUES (17330524,@IDLE_DESPAWN,120,1);

-- Satellite Longbows
INSERT INTO `mob_spawn_mods` VALUES (17330525,@IDLE_DESPAWN,120,1);

-- Satellite Longbows
INSERT INTO `mob_spawn_mods` VALUES (17330526,@IDLE_DESPAWN,120,1);

-- Satellite Longbows
INSERT INTO `mob_spawn_mods` VALUES (17330527,@IDLE_DESPAWN,120,1);

-- Orcish Fighter
INSERT INTO `mob_spawn_mods` VALUES (17354895,@IDLE_DESPAWN,600,1);

-- Chariotbuster Byakzak
INSERT INTO `mob_spawn_mods` VALUES (17354896,@IDLE_DESPAWN,600,1);

-- Qu'Vho Deathhurler
INSERT INTO `mob_spawn_mods` VALUES (17363080,368,33,0);

-- Ni'Ghu Nestfender
INSERT INTO `mob_spawn_mods` VALUES (17363318,@IDLE_DESPAWN,180,1);

-- Maat
INSERT INTO `mob_spawn_mods` VALUES (17367080,@SPECIAL_COOL,30,1);

-- Maat
INSERT INTO `mob_spawn_mods` VALUES (17367082,@SPECIAL_COOL,30,1);

-- Maat'S Pet
INSERT INTO `mob_spawn_mods` VALUES (17367085,@MAGIC_COOL,30,1);

-- Eyy Mon The Ironbreaker
INSERT INTO `mob_spawn_mods` VALUES (17371142,@GIL_MIN,20,1);
INSERT INTO `mob_spawn_mods` VALUES (17371142,@GIL_MAX,33,1);

-- Zhuu Buxu The Silent
INSERT INTO `mob_spawn_mods` VALUES (17371143,@GIL_MIN,20,1);
INSERT INTO `mob_spawn_mods` VALUES (17371143,@GIL_MAX,25,1);

-- Vaa Huja The Erudite
INSERT INTO `mob_spawn_mods` VALUES (17371579,@IDLE_DESPAWN,180,1);

-- Maat
INSERT INTO `mob_spawn_mods` VALUES (17375263,@MAGIC_COOL,30,1);

-- Maat
INSERT INTO `mob_spawn_mods` VALUES (17375267,@MAGIC_COOL,30,1);

-- Mimic
INSERT INTO `mob_spawn_mods` VALUES (17379783,@IDLE_DESPAWN,120,1);

-- Gavotvut
INSERT INTO `mob_spawn_mods` VALUES (17387965,@IDLE_DESPAWN,300,1);

-- Barakbok
INSERT INTO `mob_spawn_mods` VALUES (17387966,@IDLE_DESPAWN,300,1);

-- Bilopdop
INSERT INTO `mob_spawn_mods` VALUES (17387967,@IDLE_DESPAWN,300,1);

-- Deloknok
INSERT INTO `mob_spawn_mods` VALUES (17387968,@IDLE_DESPAWN,300,1);

-- One-Eyed Gwajboj
INSERT INTO `mob_spawn_mods` VALUES (17387970,@IDLE_DESPAWN,180,1);

-- Three-Eyed Prozpuz
INSERT INTO `mob_spawn_mods` VALUES (17387971,@IDLE_DESPAWN,180,1);

-- Bugaboo
INSERT INTO `mob_spawn_mods` VALUES (17391804,@IDLE_DESPAWN,180,1);

-- Mimic
INSERT INTO `mob_spawn_mods` VALUES (17391805,@IDLE_DESPAWN,120,1);

-- Huu Xalmo The Savage
INSERT INTO `mob_spawn_mods` VALUES (17396140,@IDLE_DESPAWN,180,1);

-- Mimic
INSERT INTO `mob_spawn_mods` VALUES (17396144,@IDLE_DESPAWN,120,1);

-- Voluptuous Vivian
INSERT INTO `mob_spawn_mods` VALUES (17404331,@GIL_MIN,20000,1);
INSERT INTO `mob_spawn_mods` VALUES (17404331,@GIL_MAX,24000,1);

-- Agas
INSERT INTO `mob_spawn_mods` VALUES (17404337,@IDLE_DESPAWN,288,1);

-- Beet Leafhopper
INSERT INTO `mob_spawn_mods` VALUES (17404338,@IDLE_DESPAWN,120,1);

-- Fafnir
INSERT INTO `mob_spawn_mods` VALUES (17408018,@DRAW_IN,20,1);

-- Gerwitz'S Scythe
INSERT INTO `mob_spawn_mods` VALUES (17420629,@IDLE_DESPAWN,300,1);

-- Scythe Victim
INSERT INTO `mob_spawn_mods` VALUES (17420630,@IDLE_DESPAWN,180,1);

-- Scythe Victim
INSERT INTO `mob_spawn_mods` VALUES (17420631,@IDLE_DESPAWN,180,1);

-- Pallas
INSERT INTO `mob_spawn_mods` VALUES (17424444,@IDLE_DESPAWN,120,1);

-- Alkyoneus
INSERT INTO `mob_spawn_mods` VALUES (17424480,@IDLE_DESPAWN,120,1);

-- Autarch
INSERT INTO `mob_spawn_mods` VALUES (17424488,@IMMUNITY,60,0);
INSERT INTO `mob_spawn_mods` VALUES (17424488,288,25,0);
INSERT INTO `mob_spawn_mods` VALUES (17424488,302,25,0);

-- Nio-A
INSERT INTO `mob_spawn_mods` VALUES (17428495,@IDLE_DESPAWN,180,1);

-- Nio-Hum
INSERT INTO `mob_spawn_mods` VALUES (17428496,@IDLE_DESPAWN,180,1);

-- Mimic
INSERT INTO `mob_spawn_mods` VALUES (17428497,@IDLE_DESPAWN,120,1);

-- Tonberry Kinq
INSERT INTO `mob_spawn_mods` VALUES (17428677,@GIL_MIN,18000,1);
INSERT INTO `mob_spawn_mods` VALUES (17428677,@GIL_MAX,30000,1);

-- Sozu Rogberry
INSERT INTO `mob_spawn_mods` VALUES (17428751,@IDLE_DESPAWN,300,1);

-- Cleuvarion M Resoaix
INSERT INTO `mob_spawn_mods` VALUES (17428807,@IDLE_DESPAWN,180,1);

-- Rompaulion S Citalle
INSERT INTO `mob_spawn_mods` VALUES (17428808,@IDLE_DESPAWN,180,1);

-- Beryl-Footed Molberry
INSERT INTO `mob_spawn_mods` VALUES (17428809,@IDLE_DESPAWN,300,1);

-- Death From Above
INSERT INTO `mob_spawn_mods` VALUES (17428810,@IDLE_DESPAWN,300,1);

-- Habetrot
INSERT INTO `mob_spawn_mods` VALUES (17428811,@GIL_MIN,2000,1);
INSERT INTO `mob_spawn_mods` VALUES (17428811,@GIL_MAX,5625,1);
INSERT INTO `mob_spawn_mods` VALUES (17428811,@IDLE_DESPAWN,900,1);

-- Rumble Crawler
INSERT INTO `mob_spawn_mods` VALUES (17428812,@NO_DESPAWN,1,1);
INSERT INTO `mob_spawn_mods` VALUES (17428812,@IDLE_DESPAWN,900,1);

-- Crimson-Toothed Pawberry
INSERT INTO `mob_spawn_mods` VALUES (17428813,@IDLE_DESPAWN,300,1);

-- Tonberry'S Avatar
INSERT INTO `mob_spawn_mods` VALUES (17428815,@IDLE_DESPAWN,300,1);

-- Sacrificial Goblet
INSERT INTO `mob_spawn_mods` VALUES (17428816,@IDLE_DESPAWN,300,1);

-- Mimic
INSERT INTO `mob_spawn_mods` VALUES (17432583,@IDLE_DESPAWN,120,1);

-- Hakutaku
INSERT INTO `mob_spawn_mods` VALUES (17433005,@IDLE_DESPAWN,120,1);

-- Azrael
INSERT INTO `mob_spawn_mods` VALUES (17433009,@GIL_MIN,15000,1);
INSERT INTO `mob_spawn_mods` VALUES (17433009,@GIL_MAX,18000,1);
INSERT INTO `mob_spawn_mods` VALUES (17433009,302,15,0);

-- Dark Spark
INSERT INTO `mob_spawn_mods` VALUES (17436964,@IDLE_DESPAWN,180,1);

-- Mimic
INSERT INTO `mob_spawn_mods` VALUES (17436965,@IDLE_DESPAWN,120,1);

-- Tros
INSERT INTO `mob_spawn_mods` VALUES (17457309,@IDLE_DESPAWN,180,1);

-- Bloodsucker
INSERT INTO `mob_spawn_mods` VALUES (17461478,@GIL_MIN,3000,1);
INSERT INTO `mob_spawn_mods` VALUES (17461478,@GIL_MAX,9900,1);

-- Maat
INSERT INTO `mob_spawn_mods` VALUES (17465360,@SPECIAL_COOL,30,1);
INSERT INTO `mob_spawn_mods` VALUES (17465360,@MAGIC_COOL,30,1);

-- Maat
INSERT INTO `mob_spawn_mods` VALUES (17465362,@SPECIAL_COOL,30,1);

-- Maat
INSERT INTO `mob_spawn_mods` VALUES (17465364,@SPECIAL_COOL,30,1);

-- Magic Sludge
INSERT INTO `mob_spawn_mods` VALUES (17469516,@IDLE_DESPAWN,180,1);

-- Mimic
INSERT INTO `mob_spawn_mods` VALUES (17469761,@IDLE_DESPAWN,120,1);

-- Cargo Crab Colin
INSERT INTO `mob_spawn_mods` VALUES (17485980,@GIL_MIN,1200,1);
INSERT INTO `mob_spawn_mods` VALUES (17485980,@GIL_MAX,1950,1);

-- Falcatus Aranei
INSERT INTO `mob_spawn_mods` VALUES (17486031,@GIL_MIN,1200,1);
INSERT INTO `mob_spawn_mods` VALUES (17486031,@GIL_MAX,1903,1);

-- Dame Blanche
INSERT INTO `mob_spawn_mods` VALUES (17486129,@GIL_MIN,3600,1);
INSERT INTO `mob_spawn_mods` VALUES (17486129,@GIL_MAX,6079,1);

-- Korroloka Leech
INSERT INTO `mob_spawn_mods` VALUES (17486187,@IDLE_DESPAWN,168,1);

-- Korroloka Leech
INSERT INTO `mob_spawn_mods` VALUES (17486188,@IDLE_DESPAWN,168,1);

-- Korroloka Leech
INSERT INTO `mob_spawn_mods` VALUES (17486189,@IDLE_DESPAWN,168,1);

-- Morion Worm
INSERT INTO `mob_spawn_mods` VALUES (17486190,@IDLE_DESPAWN,1800,1);

-- Amemet
INSERT INTO `mob_spawn_mods` VALUES (17490016,@GIL_MIN,6000,1);
INSERT INTO `mob_spawn_mods` VALUES (17490016,@GIL_MAX,9100,1);

-- Mimic
INSERT INTO `mob_spawn_mods` VALUES (17490230,@IDLE_DESPAWN,120,1);

-- Cancer
INSERT INTO `mob_spawn_mods` VALUES (17490231,@GIL_MIN,6000,1);
INSERT INTO `mob_spawn_mods` VALUES (17490231,@GIL_MAX,9500,1);
INSERT INTO `mob_spawn_mods` VALUES (17490231,@IDLE_DESPAWN,180,1);

-- Robber Crab
INSERT INTO `mob_spawn_mods` VALUES (17490232,@IDLE_DESPAWN,180,1);

-- Phantom Worm
INSERT INTO `mob_spawn_mods` VALUES (17490233,@IDLE_DESPAWN,180,1);

-- Mimic
INSERT INTO `mob_spawn_mods` VALUES (17498564,@IDLE_DESPAWN,120,1);

-- Mimic
INSERT INTO `mob_spawn_mods` VALUES (17502567,@IDLE_DESPAWN,120,1);

-- Brigandish Blade
INSERT INTO `mob_spawn_mods` VALUES (17502568,@GIL_MIN,18227,1);
INSERT INTO `mob_spawn_mods` VALUES (17502568,@GIL_MAX,18606,1);
INSERT INTO `mob_spawn_mods` VALUES (17502568,@IDLE_DESPAWN,180,1);

-- Faust
INSERT INTO `mob_spawn_mods` VALUES (17506370,@GIL_MIN,17986,1);
INSERT INTO `mob_spawn_mods` VALUES (17506370,@GIL_MAX,27482,1);

-- Ullikummi
INSERT INTO `mob_spawn_mods` VALUES (17506418,@IDLE_DESPAWN,180,1);

-- Olla Pequena
INSERT INTO `mob_spawn_mods` VALUES (17506667,@IDLE_DESPAWN,180,1);

-- Olla Media
INSERT INTO `mob_spawn_mods` VALUES (17506668,@IDLE_DESPAWN,180,1);

-- Olla Grande
INSERT INTO `mob_spawn_mods` VALUES (17506669,@IDLE_DESPAWN,180,1);

-- Disaster Idol
INSERT INTO `mob_spawn_mods` VALUES (17531121,@IDLE_DESPAWN,180,1);

-- Cemetery Cherry
INSERT INTO `mob_spawn_mods` VALUES (17555754,@GIL_MIN,20000,1);
INSERT INTO `mob_spawn_mods` VALUES (17555754,@GIL_MAX,30000,1);
INSERT INTO `mob_spawn_mods` VALUES (17555754,@MUG_GIL,10000,1);
INSERT INTO `mob_spawn_mods` VALUES (17555754,@IDLE_DESPAWN,600,1);

-- Fire Elemental
INSERT INTO `mob_spawn_mods` VALUES (17559870,@IDLE_DESPAWN,300,1);

-- Polevik
INSERT INTO `mob_spawn_mods` VALUES (17568134,@IDLE_DESPAWN,168,1);

-- Gerwitz'S Axe
INSERT INTO `mob_spawn_mods` VALUES (17568135,@IDLE_DESPAWN,180,1);

-- Gerwitz'S Sword
INSERT INTO `mob_spawn_mods` VALUES (17568136,@IDLE_DESPAWN,180,1);

-- Gerwitz'S Soul
INSERT INTO `mob_spawn_mods` VALUES (17568137,@IDLE_DESPAWN,180,1);

-- Air Elemental
INSERT INTO `mob_spawn_mods` VALUES (17568139,@IDLE_DESPAWN,300,1);

-- Thunder Elemental
INSERT INTO `mob_spawn_mods` VALUES (17572203,@IDLE_DESPAWN,300,1);

-- Yum Kimil
INSERT INTO `mob_spawn_mods` VALUES (17576264,@IDLE_DESPAWN,300,1);

-- Dog Guardian
INSERT INTO `mob_spawn_mods` VALUES (17576265,@IDLE_DESPAWN,180,1);

-- Owl Guardian
INSERT INTO `mob_spawn_mods` VALUES (17576266,@IDLE_DESPAWN,180,1);

-- Sturm
INSERT INTO `mob_spawn_mods` VALUES (17576267,@IDLE_DESPAWN,180,1);

-- Taifun
INSERT INTO `mob_spawn_mods` VALUES (17576268,@IDLE_DESPAWN,180,1);

-- Trombe
INSERT INTO `mob_spawn_mods` VALUES (17576269,@IDLE_DESPAWN,180,1);

-- Ice Elemental
INSERT INTO `mob_spawn_mods` VALUES (17576271,@IDLE_DESPAWN,120,1);

-- Blind Moby
INSERT INTO `mob_spawn_mods` VALUES (17580038,@IDLE_DESPAWN,300,1);

-- Wandering Ghost
INSERT INTO `mob_spawn_mods` VALUES (17580337,@IDLE_DESPAWN,300,1);

-- Earth Elemental
INSERT INTO `mob_spawn_mods` VALUES (17580340,@IDLE_DESPAWN,300,1);

-- Guardian Crawler
INSERT INTO `mob_spawn_mods` VALUES (17584129,@IDLE_DESPAWN,120,1);

-- Guardian Crawler
INSERT INTO `mob_spawn_mods` VALUES (17584130,@IDLE_DESPAWN,120,1);

-- Drone Crawler
INSERT INTO `mob_spawn_mods` VALUES (17584131,@IDLE_DESPAWN,120,1);

-- Drone Crawler
INSERT INTO `mob_spawn_mods` VALUES (17584132,@IDLE_DESPAWN,120,1);

-- Queen Crawler
INSERT INTO `mob_spawn_mods` VALUES (17584133,@IDLE_DESPAWN,120,1);

-- Matron Crawler
INSERT INTO `mob_spawn_mods` VALUES (17584134,@IDLE_DESPAWN,120,1);

-- Awd Goggie
INSERT INTO `mob_spawn_mods` VALUES (17584135,@IDLE_DESPAWN,120,1);

-- Dreadbug
INSERT INTO `mob_spawn_mods` VALUES (17584425,@IDLE_DESPAWN,168,1);

-- Mimic
INSERT INTO `mob_spawn_mods` VALUES (17584426,@IDLE_DESPAWN,120,1);

-- Water Elemental
INSERT INTO `mob_spawn_mods` VALUES (17584427,@IDLE_DESPAWN,300,1);

-- Wyrmfly
INSERT INTO `mob_spawn_mods` VALUES (17588701,@IDLE_DESPAWN,180,1);

-- Wyrmfly
INSERT INTO `mob_spawn_mods` VALUES (17588702,@IDLE_DESPAWN,180,1);

-- Wyrmfly
INSERT INTO `mob_spawn_mods` VALUES (17588703,@IDLE_DESPAWN,180,1);

-- Dark Elemental
INSERT INTO `mob_spawn_mods` VALUES (17588704,@IDLE_DESPAWN,300,1);

-- Lost Soul
INSERT INTO `mob_spawn_mods` VALUES (17588706,@IDLE_DESPAWN,180,1);

-- Chandelier
INSERT INTO `mob_spawn_mods` VALUES (17596533,@IDLE_DESPAWN,120,1);

-- Guardian Statue
INSERT INTO `mob_spawn_mods` VALUES (17596643,@IDLE_DESPAWN,180,1);

-- Serket
INSERT INTO `mob_spawn_mods` VALUES (17596720,@GIL_MIN,19000,1);
INSERT INTO `mob_spawn_mods` VALUES (17596720,@GIL_MAX,32767,1);

-- Mimic
INSERT INTO `mob_spawn_mods` VALUES (17596728,@IDLE_DESPAWN,120,1);

-- Light Elemental
INSERT INTO `mob_spawn_mods` VALUES (17596729,@IDLE_DESPAWN,300,1);

-- Altedour I Tavnazia
INSERT INTO `mob_spawn_mods` VALUES (17612836,@IDLE_DESPAWN,180,1);

-- Mimic
INSERT INTO `mob_spawn_mods` VALUES (17617157,@IDLE_DESPAWN,120,1);

-- Bomb Queen
INSERT INTO `mob_spawn_mods` VALUES (17617158,@GIL_MIN,15000,1);
INSERT INTO `mob_spawn_mods` VALUES (17617158,@GIL_MAX,18000,1);
INSERT INTO `mob_spawn_mods` VALUES (17617158,@MUG_GIL,3370,1);
INSERT INTO `mob_spawn_mods` VALUES (17617158,@IDLE_DESPAWN,900,1);

-- Tarasque
INSERT INTO `mob_spawn_mods` VALUES (17617164,@IDLE_DESPAWN,900,1);

-- Valor
INSERT INTO `mob_spawn_mods` VALUES (17629185,@IDLE_DESPAWN,180,1);

-- Honor
INSERT INTO `mob_spawn_mods` VALUES (17629186,@IDLE_DESPAWN,180,1);

-- Mimic
INSERT INTO `mob_spawn_mods` VALUES (17629190,@IDLE_DESPAWN,120,1);

-- Centurio X-I
INSERT INTO `mob_spawn_mods` VALUES (17629238,@GIL_MIN,2000,1);
INSERT INTO `mob_spawn_mods` VALUES (17629238,@GIL_MAX,6000,1);
INSERT INTO `mob_spawn_mods` VALUES (17629238,@MUG_GIL,630,1);

-- Sabotender Bailarin
INSERT INTO `mob_spawn_mods` VALUES (17629264,@GIL_MIN,10000,1);
INSERT INTO `mob_spawn_mods` VALUES (17629264,@GIL_MAX,13640,1);

-- Antican Praefectus
INSERT INTO `mob_spawn_mods` VALUES (17629281,@GIL_MIN,2100,1);
INSERT INTO `mob_spawn_mods` VALUES (17629281,@GIL_MAX,4500,1);

-- Sagittarius X-Xiii
INSERT INTO `mob_spawn_mods` VALUES (17629301,@GIL_MIN,1000,1);
INSERT INTO `mob_spawn_mods` VALUES (17629301,@GIL_MAX,3000,1);

-- Nussknacker
INSERT INTO `mob_spawn_mods` VALUES (17629403,@GIL_MIN,4800,1);
INSERT INTO `mob_spawn_mods` VALUES (17629403,@GIL_MAX,6000,1);

-- Antican Magister
INSERT INTO `mob_spawn_mods` VALUES (17629412,@GIL_MIN,2100,1);
INSERT INTO `mob_spawn_mods` VALUES (17629412,@GIL_MAX,4500,1);

-- Antican Proconsul
INSERT INTO `mob_spawn_mods` VALUES (17629421,@GIL_MIN,2100,1);
INSERT INTO `mob_spawn_mods` VALUES (17629421,@GIL_MAX,4500,1);

-- Diamond Daig
INSERT INTO `mob_spawn_mods` VALUES (17629430,@GIL_MIN,1200,1);
INSERT INTO `mob_spawn_mods` VALUES (17629430,@GIL_MAX,3000,1);

-- Antican Tribunus
INSERT INTO `mob_spawn_mods` VALUES (17629483,@GIL_MIN,6000,1);
INSERT INTO `mob_spawn_mods` VALUES (17629483,@GIL_MAX,9234,1);

-- Triarius X-Xv
INSERT INTO `mob_spawn_mods` VALUES (17629524,@GIL_MIN,6000,1);
INSERT INTO `mob_spawn_mods` VALUES (17629524,@GIL_MAX,9234,1);

-- Hastatus Xi-Xii
INSERT INTO `mob_spawn_mods` VALUES (17629561,@GIL_MIN,650,1);
INSERT INTO `mob_spawn_mods` VALUES (17629561,@GIL_MAX,1450,1);

-- Antican Legatus
INSERT INTO `mob_spawn_mods` VALUES (17629640,@GIL_MIN,6000,1);
INSERT INTO `mob_spawn_mods` VALUES (17629640,@GIL_MAX,9234,1);

-- Antican Consul
INSERT INTO `mob_spawn_mods` VALUES (17629641,@GIL_MIN,6000,1);
INSERT INTO `mob_spawn_mods` VALUES (17629641,@GIL_MAX,9234,1);

-- Ancient Vessel
INSERT INTO `mob_spawn_mods` VALUES (17629642,@IDLE_DESPAWN,600,1);

-- Tribunus Vii-I
INSERT INTO `mob_spawn_mods` VALUES (17629643,@GIL_MIN,6000,1);
INSERT INTO `mob_spawn_mods` VALUES (17629643,@GIL_MAX,9234,1);
INSERT INTO `mob_spawn_mods` VALUES (17629643,@IDLE_DESPAWN,900,1);

-- Proconsul Xii
INSERT INTO `mob_spawn_mods` VALUES (17629644,@GIL_MIN,6000,1);
INSERT INTO `mob_spawn_mods` VALUES (17629644,@GIL_MAX,9234,1);

-- Ubume
INSERT INTO `mob_spawn_mods` VALUES (17649860,@IDLE_DESPAWN,300,1);

-- Enagakure
INSERT INTO `mob_spawn_mods` VALUES (17678351,@IDLE_DESPAWN,600,1);

-- [Narasimha]
-- Values taken from wiki on 04/23/2018 (http://ffxiclopedia.wikia.com/wiki/Narasimha)
INSERT INTO `mob_spawn_mods` VALUES (17649784,@GIL_MIN,12000,1);
INSERT INTO `mob_spawn_mods` VALUES (17649784,@GIL_MAX,20000,1);
INSERT INTO `mob_spawn_mods` VALUES (17649784,@MUG_GIL,4800,1);

-- Sewer Syrup
INSERT INTO `mob_spawn_mods` VALUES (17461307,@GIL_MIN,4000,1);
INSERT INTO `mob_spawn_mods` VALUES (17461307,@GIL_MAX,19000,1);
INSERT INTO `mob_spawn_mods` VALUES (17461307,@MUG_GIL,3500,1);

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
