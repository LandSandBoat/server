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
-- Table structure for table `mob_pool_mods`
--

DROP TABLE IF EXISTS `mob_pool_mods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mob_pool_mods` (
  `poolid` smallint(5) unsigned NOT NULL,
  `modid` smallint(5) unsigned NOT NULL,
  `value` smallint(5) NOT NULL DEFAULT '0',
  `is_mob_mod` boolean NOT NULL DEFAULT '0',
  PRIMARY KEY (`poolid`,`modid`)
) ENGINE=Aria TRANSACTIONAL=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci AVG_ROW_LENGTH=13 PACK_KEYS=1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mob_pool_mods`
--

LOCK TABLES `mob_pool_mods` WRITE;
/*!40000 ALTER TABLE `mob_pool_mods` DISABLE KEYS */;

-- Absolute Virtue
INSERT INTO `mob_pool_mods` VALUES (21,29,100,0); -- MDEF: 100

-- Adamantoise
INSERT INTO `mob_pool_mods` VALUES (44,368,150,0); -- REGAIN: 150

-- Agas
INSERT INTO `mob_pool_mods` VALUES (60,370,20,0); -- REGEN: 20

-- Animated Shield
INSERT INTO `mob_pool_mods` VALUES (154,163,-70,0); -- DMGMAGIC: -70

-- Antican Praetor
INSERT INTO `mob_pool_mods` VALUES (181,1,6000,1); -- GIL_MIN: 6000
INSERT INTO `mob_pool_mods` VALUES (181,2,9234,1); -- GIL_MAX: 9234

-- Ark Angel Gk
INSERT INTO `mob_pool_mods` VALUES (236,30,732,1); -- SPECIAL_SKILL: 732
INSERT INTO `mob_pool_mods` VALUES (236,33,60,1);  -- SPECIAL_COOL: 60

-- Ark Angel Hm
INSERT INTO `mob_pool_mods` VALUES (237,44,1,1); -- DUAL_WIELD: 1

-- Ark Angel Tt
INSERT INTO `mob_pool_mods` VALUES (242,40,30,1);  -- TELEPORT_CD: 30
INSERT INTO `mob_pool_mods` VALUES (242,41,936,1); -- TELEPORT_START: 936
INSERT INTO `mob_pool_mods` VALUES (242,42,962,1); -- TELEPORT_END: 962
INSERT INTO `mob_pool_mods` VALUES (242,43,1,1);   -- TELEPORT_TYPE: 1
INSERT INTO `mob_pool_mods` VALUES (242,47,22,1);  -- SPAWN_LEASH: 22

-- Aspidochelone
INSERT INTO `mob_pool_mods` VALUES (268,368,150,0); -- REGAIN: 150
INSERT INTO `mob_pool_mods` VALUES (268,370,50,0);  -- REGEN: 50

-- Aura Statue
INSERT INTO `mob_pool_mods` VALUES (289,4,4,1); -- SIGHT_RANGE: 4

-- Battle Bugard
INSERT INTO `mob_pool_mods` VALUES (370,28,5,1); -- EXP_BONUS: 5

-- Biast
INSERT INTO `mob_pool_mods` VALUES (410,236,20,0); -- HUMANOID_KILLER: 20

-- Bladmall
INSERT INTO `mob_pool_mods` VALUES (444,23,23,1); -- IMMUNITY: 23

-- Bloodlapper
INSERT INTO `mob_pool_mods` VALUES (459,23,50,0);  -- ATT: 50
INSERT INTO `mob_pool_mods` VALUES (459,73,25,0);  -- STORETP: 25
INSERT INTO `mob_pool_mods` VALUES (459,430,20,0); -- QUAD_ATTACK: 20

-- Bugbby
INSERT INTO `mob_pool_mods` VALUES (559,62,-50,0);   -- ATTP: -50
-- Byakko
INSERT INTO `mob_pool_mods` VALUES (592,3,100,1);  -- MP_BASE: 100
INSERT INTO `mob_pool_mods` VALUES (592,68,15,0);  -- EVA: 15
INSERT INTO `mob_pool_mods` VALUES (592,302,45,0); -- TRIPLE_ATTACK: 45

-- Cargo Crab Colin
INSERT INTO `mob_pool_mods` VALUES (639,63,25,0); -- DEFP: 25

-- Cerberus
INSERT INTO `mob_pool_mods` VALUES (680,1,322,0);   -- DEF: 322
INSERT INTO `mob_pool_mods` VALUES (680,31,200,0);  -- MEVA: 200
INSERT INTO `mob_pool_mods` VALUES (680,251,-50,0); -- STUNRES: -50

-- Cerebrator
INSERT INTO `mob_pool_mods` VALUES (681,368,10,0); -- REGAIN: 10

-- Citipati
INSERT INTO `mob_pool_mods` VALUES (733,302,5,0); -- TRIPLE_ATTACK: 5

-- Colorful Treant
INSERT INTO `mob_pool_mods` VALUES (768,28,5,1); -- EXP_BONUS: 5

-- Colossus
INSERT INTO `mob_pool_mods` VALUES (770,4,4,1); -- SIGHT_RANGE: 4

-- Coveter
INSERT INTO `mob_pool_mods` VALUES (820,368,10,0); -- REGAIN: 10

-- Darksteel Golem
INSERT INTO `mob_pool_mods` VALUES (906,4,4,1); -- SIGHT_RANGE: 4

-- Dea
INSERT INTO `mob_pool_mods` VALUES (930,370,15,0); -- REGEN: 15

-- Defender
INSERT INTO `mob_pool_mods` VALUES (955,28,-100,1); -- EXP_BONUS: -100

-- Defoliate Treant
INSERT INTO `mob_pool_mods` VALUES (958,28,5,1); -- EXP_BONUS: 5

-- Demonic Rose
INSERT INTO `mob_pool_mods` VALUES (978,28,23,1); -- EXP_BONUS: 23

-- Demonic Tiphia
INSERT INTO `mob_pool_mods` VALUES (979,8,60,1); -- HEAL_CHANCE: 60
INSERT INTO `mob_pool_mods` VALUES (979,9,60,1); -- HP_HEAL_CHANCE: 60

-- Detector
INSERT INTO `mob_pool_mods` VALUES (1013,28,-100,1); -- EXP_BONUS: -100

-- Effigy Prototype
INSERT INTO `mob_pool_mods` VALUES (1178,163,-100,0); -- DMGMAGIC: -100

-- Enkidu
INSERT INTO `mob_pool_mods` VALUES (1234,4,4,1); -- SIGHT_RANGE: 4

-- Exoplates
INSERT INTO `mob_pool_mods` VALUES (1270,39,-1,1); -- SHARE_POS: -1

-- Fafnir
INSERT INTO `mob_pool_mods` VALUES (1280,368,70,0); -- REGAIN: 70

-- Faust
INSERT INTO `mob_pool_mods` VALUES (1306,4,30,1); -- SIGHT_RANGE: 30

-- Frostmane
INSERT INTO `mob_pool_mods` VALUES (1429,28,10,1); -- EXP_BONUS: 10

-- Gambilox Wanderling
INSERT INTO `mob_pool_mods` VALUES (1456,368,20,0); -- REGAIN: 20

-- Gargantua
INSERT INTO `mob_pool_mods` VALUES (1461,4,4,1); -- SIGHT_RANGE: 4

-- Genbu
INSERT INTO `mob_pool_mods` VALUES (1491,3,100,1); -- MP_BASE: 100

-- Goblin Digger Near
INSERT INTO `mob_pool_mods` VALUES (1648,17,1,1);  -- NO_DESPAWN: 1
INSERT INTO `mob_pool_mods` VALUES (1648,224,5,0); -- VERMIN_KILLER: 5

-- Goblin Freelance
INSERT INTO `mob_pool_mods` VALUES (1663,29,3,1); -- ASSIST: 3

-- Goblin Swordsman
INSERT INTO `mob_pool_mods` VALUES (1719,29,2,1); -- ASSIST: 2

-- Golden-Tongued Culberry
INSERT INTO `mob_pool_mods` VALUES (1750,56,1,1); -- HP_STANDBACK: 1

-- Goliath
INSERT INTO `mob_pool_mods` VALUES (1754,4,4,1); -- SIGHT_RANGE: 4

-- Gration
INSERT INTO `mob_pool_mods` VALUES (1792,368,70,0); -- REGAIN: 70

-- Greater Manticore
INSERT INTO `mob_pool_mods` VALUES (1806,28,10,1); -- EXP_BONUS: 10

-- Guivre
INSERT INTO `mob_pool_mods` VALUES (1841,28,10,1); -- EXP_BONUS: 10

-- Hydras Hound
INSERT INTO `mob_pool_mods` VALUES (2032,34,20,1);  -- MAGIC_COOL: 20
INSERT INTO `mob_pool_mods` VALUES (2032,35,0,1);   -- STANDBACK_COOL: 0
INSERT INTO `mob_pool_mods` VALUES (2032,244,15,0); -- SILENCERES: 15

-- Icon Prototype
INSERT INTO `mob_pool_mods` VALUES (2047,163,-100,0); -- DMGMAGIC: -100

-- Intulo
INSERT INTO `mob_pool_mods` VALUES (2083,29,25,0); -- MDEF: 25

-- Ixzdei Blm
INSERT INTO `mob_pool_mods` VALUES (2114,4,15,1);  -- SIGHT_RANGE: 15
INSERT INTO `mob_pool_mods` VALUES (2114,5,15,1);  -- SOUND_RANGE: 15
INSERT INTO `mob_pool_mods` VALUES (2114,11,30,1); -- LINK_RADIUS: 30
INSERT INTO `mob_pool_mods` VALUES (2114,34,60,1); -- MAGIC_COOL: 60

-- Kaiser Behemoth S
INSERT INTO `mob_pool_mods` VALUES (2180,3,100,1); -- MP_BASE: 100

-- King Arthro
INSERT INTO `mob_pool_mods` VALUES (2254,407,100,0); -- UFASTCAST: 100

-- King Behemoth
INSERT INTO `mob_pool_mods` VALUES (2255,3,100,1);  -- MP_BASE: 100
INSERT INTO `mob_pool_mods` VALUES (2255,34,60,1);  -- MAGIC_COOL: 60
INSERT INTO `mob_pool_mods` VALUES (2255,368,70,0); -- REGAIN: 70

-- King Vinegarroon
INSERT INTO `mob_pool_mods` VALUES (2262,370,125,0); -- REGEN: 125

-- Kirin
INSERT INTO `mob_pool_mods` VALUES (2265,368,150,0); -- REGAIN: 150
INSERT INTO `mob_pool_mods` VALUES (2265,370,50,0);  -- REGEN: 50

-- Knight Crab
INSERT INTO `mob_pool_mods` VALUES (2271,64,15,0);  -- COMBAT_SKILLUP_RATE: 15
INSERT INTO `mob_pool_mods` VALUES (2271,65,15,0);  -- MAGIC_SKILLUP_RATE: 15
INSERT INTO `mob_pool_mods` VALUES (2271,165,15,0); -- CRITHITRATE: 15

-- Ladon
INSERT INTO `mob_pool_mods` VALUES (2314,28,23,1); -- EXP_BONUS: 23

-- Lindwurm
INSERT INTO `mob_pool_mods` VALUES (2420,302,10,0); -- TRIPLE_ATTACK: 10

-- Maats Avatar
INSERT INTO `mob_pool_mods` VALUES (2461,61,25,1); -- HP_SCALE: 25

-- Maats Pet
INSERT INTO `mob_pool_mods` VALUES (2462,61,25,1); -- HP_SCALE: 25

-- Maats Wyvern
INSERT INTO `mob_pool_mods` VALUES (2463,61,20,1); -- HP_SCALE: 20

-- Mammet-19 Epsilon
INSERT INTO `mob_pool_mods` VALUES (2499,240,90,0); -- SLEEPRES: 90

-- Mammet-22 Zeta
INSERT INTO `mob_pool_mods` VALUES (2500,240,90,0); -- SLEEPRES: 90

-- Minotaur
INSERT INTO `mob_pool_mods` VALUES (2675,4,25,1); -- SIGHT_RANGE: 25

-- Mischievous Micholas
INSERT INTO `mob_pool_mods` VALUES (2677,288,55,0); -- DOUBLE_ATTACK: 55

-- Morbolger
INSERT INTO `mob_pool_mods` VALUES (2742,37,1,1); -- ALWAYS_AGGRO: 1

-- Morbol Menace
INSERT INTO `mob_pool_mods` VALUES (2745,28,23,1); -- EXP_BONUS: 23

-- Morion Worm
INSERT INTO `mob_pool_mods` VALUES (2748,370,5,0); -- REGEN: 5

-- Mysticmaker Profblix
INSERT INTO `mob_pool_mods` VALUES (2790,168,50,0); -- SPELLINTERRUPT: 50
INSERT INTO `mob_pool_mods` VALUES (2790,240,7,0);  -- SLEEPRES: 7
INSERT INTO `mob_pool_mods` VALUES (2790,244,7,0);  -- SILENCERES: 7

-- Mythril Golem
INSERT INTO `mob_pool_mods` VALUES (2793,4,4,1); -- SIGHT_RANGE: 4

-- Nepionic Soulflayer
INSERT INTO `mob_pool_mods` VALUES (2834,368,250,0); -- REGAIN: 250
INSERT INTO `mob_pool_mods` VALUES (2834,574,100,0); -- WSD+% (Backhand Blow): 100

-- Nidhogg
INSERT INTO `mob_pool_mods` VALUES (2840,368,70,0); -- REGAIN: 70
INSERT INTO `mob_pool_mods` VALUES (2840,370,50,0); -- REGEN: 50

-- Nunyunuwi
INSERT INTO `mob_pool_mods` VALUES (2922,370,100,0); -- REGEN: 100

-- Omega
INSERT INTO `mob_pool_mods` VALUES (2973,291,25,0); -- COUNTER: 25
INSERT INTO `mob_pool_mods` VALUES (2973,370,1,0);  -- REGEN: 1

-- Ore Golem
INSERT INTO `mob_pool_mods` VALUES (3051,4,4,1); -- SIGHT_RANGE: 4

-- Parata
INSERT INTO `mob_pool_mods` VALUES (3099,23,23,1); -- IMMUNITY: 23

-- Phantom Worm
INSERT INTO `mob_pool_mods` VALUES (3129,370,50,0); -- REGEN: 50

-- Polar Hare
INSERT INTO `mob_pool_mods` VALUES (3168,28,10,1); -- EXP_BONUS: 10

-- Promathia
INSERT INTO `mob_pool_mods` VALUES (3205,1,250,0);  -- DEF: 250
INSERT INTO `mob_pool_mods` VALUES (3205,29,30,0);  -- MDEF: 30
INSERT INTO `mob_pool_mods` VALUES (3205,288,25,0); -- DOUBLE_ATTACK: 25
INSERT INTO `mob_pool_mods` VALUES (3205,366,25,0); -- MAIN_DMG_RATING: 25

-- Proto-Omega
INSERT INTO `mob_pool_mods` VALUES (3208,370,20,0); -- REGEN: 20

-- Qiqirn Archaeologist
INSERT INTO `mob_pool_mods` VALUES (3245,56,1,1); -- HP_STANDBACK: 1

-- Qiqirn Enterpriser
INSERT INTO `mob_pool_mods` VALUES (3252,56,1,1); -- HP_STANDBACK: 1

-- Qiqirn Mercenary
INSERT INTO `mob_pool_mods` VALUES (3257,56,1,1); -- HP_STANDBACK: 1

-- Qiqirn Pecheur
INSERT INTO `mob_pool_mods` VALUES (3262,56,1,1); -- HP_STANDBACK: 1

-- Qiqirn Rock Hound
INSERT INTO `mob_pool_mods` VALUES (3264,56,1,1); -- HP_STANDBACK: 1

-- Qiqirn Trailer
INSERT INTO `mob_pool_mods` VALUES (3265,56,1,1); -- HP_STANDBACK: 1

-- Qiqirn Volcanist
INSERT INTO `mob_pool_mods` VALUES (3268,56,1,1); -- HP_STANDBACK: 1

-- Race Runner
INSERT INTO `mob_pool_mods` VALUES (3301,29,100,0); -- MDEF: 100

-- Rock Golem
INSERT INTO `mob_pool_mods` VALUES (3379,4,4,1); -- SIGHT_RANGE: 4

-- Seiryu
INSERT INTO `mob_pool_mods` VALUES (3540,3,100,1); -- MP_BASE: 100

-- Serket
INSERT INTO `mob_pool_mods` VALUES (3549,370,50,0); -- REGEN: 50

-- Shikaree X
INSERT INTO `mob_pool_mods` VALUES (3598,161,30,0); -- DMGPHYS: 30
INSERT INTO `mob_pool_mods` VALUES (3598,368,70,0); -- REGAIN: 70

-- Shikaree Y
INSERT INTO `mob_pool_mods` VALUES (3600,161,30,0); -- DMGPHYS: 30
INSERT INTO `mob_pool_mods` VALUES (3600,368,70,0); -- REGAIN: 70

-- Shikaree Z
INSERT INTO `mob_pool_mods` VALUES (3601,168,30,0); -- SPELLINTERRUPT: 30
INSERT INTO `mob_pool_mods` VALUES (3601,368,70,0); -- REGAIN: 70

-- Slave Globe
INSERT INTO `mob_pool_mods` VALUES (3667,28,-100,1); -- EXP_BONUS: -100

-- Snoll Tzar
INSERT INTO `mob_pool_mods` VALUES (3684,3,30,1); -- MP_BASE: 30

-- Statue Prototype
INSERT INTO `mob_pool_mods` VALUES (3759,163,-100,0); -- DMGMAGIC: -100

-- Stone Golem
INSERT INTO `mob_pool_mods` VALUES (3781,4,4,1); -- SIGHT_RANGE: 4

-- Stray
INSERT INTO `mob_pool_mods` VALUES (3784,2,-1,1);    -- GIL_MAX: -1
INSERT INTO `mob_pool_mods` VALUES (3784,28,-100,1); -- EXP_BONUS: -100

-- Stubborn Dredvodd
INSERT INTO `mob_pool_mods` VALUES (3796,21,97,1); -- PET_SPELL_LIST: 97

-- Suzaku
INSERT INTO `mob_pool_mods` VALUES (3816,3,100,1); -- MP_BASE: 100

-- Swashstox Beadblinker
INSERT INTO `mob_pool_mods` VALUES (3824,29,2,1); -- ASSIST: 2

-- Tavnazian Ram
INSERT INTO `mob_pool_mods` VALUES (3853,28,23,1); -- EXP_BONUS: 23

-- Tombstone Prototype
INSERT INTO `mob_pool_mods` VALUES (3941,163,-100,0); -- DMGMAGIC: -100

-- Tuchulcha
INSERT INTO `mob_pool_mods` VALUES (4046,23,6191,1); -- IMMUNITY: 6191

-- Ullikummi
INSERT INTO `mob_pool_mods` VALUES (4082,4,4,1); -- SIGHT_RANGE: 4

-- Ultima
INSERT INTO `mob_pool_mods` VALUES (4083,368,30,0); -- REGAIN: 30
INSERT INTO `mob_pool_mods` VALUES (4083,370,1,0);  -- REGEN: 1

-- Vanguard_Armorer
INSERT INTO `mob_pool_mods` VALUES (4136,75,3,1); -- CAN_PARRY: 3

-- Vanguard_Assassin
INSERT INTO `mob_pool_mods` VALUES (4137,75,3,1); -- CAN_PARRY: 3

-- Vanguard_Backstabber
INSERT INTO `mob_pool_mods` VALUES (4138,75,3,1); -- CAN_PARRY: 3

-- Vanguard_Beasttender
INSERT INTO `mob_pool_mods` VALUES (4139,75,3,1); -- CAN_PARRY: 3

-- Vanguard_Bugler
INSERT INTO `mob_pool_mods` VALUES (4140,75,3,1); -- CAN_PARRY: 3

-- Vanguard_Chanter
INSERT INTO `mob_pool_mods` VALUES (4141,75,3,1); -- CAN_PARRY: 3

-- Vanguard_Defender
INSERT INTO `mob_pool_mods` VALUES (4143,75,3,1); -- CAN_PARRY: 3

-- Vanguard_Drakekeeper
INSERT INTO `mob_pool_mods` VALUES (4146,75,3,1); -- CAN_PARRY: 3

-- Vanguard_Enchanter
INSERT INTO `mob_pool_mods` VALUES (4147,75,3,1); -- CAN_PARRY: 3

-- Vanguard_Exemplar
INSERT INTO `mob_pool_mods` VALUES (4148,75,3,1); -- CAN_PARRY: 3

-- Vanguard_Footsoldier
INSERT INTO `mob_pool_mods` VALUES (4150,75,3,1); -- CAN_PARRY: 3

-- Vanguard_Gutslasher
INSERT INTO `mob_pool_mods` VALUES (4152,75,3,1); -- CAN_PARRY: 3

-- Vanguard_Hatamoto
INSERT INTO `mob_pool_mods` VALUES (4153,75,3,1); -- CAN_PARRY: 3

-- Vanguard_Hawker
INSERT INTO `mob_pool_mods` VALUES (4154,75,3,1); -- CAN_PARRY: 3

-- Vanguard_Hitman
INSERT INTO `mob_pool_mods` VALUES (4155,75,3,1); -- CAN_PARRY: 3

-- Vanguard_Impaler
INSERT INTO `mob_pool_mods` VALUES (4156,75,3,1); -- CAN_PARRY: 3

-- Vanguard_Inciter
INSERT INTO `mob_pool_mods` VALUES (4157,75,3,1); -- CAN_PARRY: 3

-- Vanguard_Kusa
INSERT INTO `mob_pool_mods` VALUES (4158,75,3,1); -- CAN_PARRY: 3

-- Vanguard_Liberator
INSERT INTO `mob_pool_mods` VALUES (4159,75,3,1); -- CAN_PARRY: 3

-- Vanguard_Maestro
INSERT INTO `mob_pool_mods` VALUES (4160,75,3,1); -- CAN_PARRY: 3

-- Vanguard_Minstrel
INSERT INTO `mob_pool_mods` VALUES (4164,75,3,1); -- CAN_PARRY: 3

-- Vanguard_Neckchopper
INSERT INTO `mob_pool_mods` VALUES (4165,75,3,1); -- CAN_PARRY: 3

-- Vanguard_Ogresoother
INSERT INTO `mob_pool_mods` VALUES (4167,75,3,1); -- CAN_PARRY: 3

-- Vanguard_Partisan
INSERT INTO `mob_pool_mods` VALUES (4169,75,3,1); -- CAN_PARRY: 3

-- Vanguard_Pathfinder
INSERT INTO `mob_pool_mods` VALUES (4170,75,3,1); -- CAN_PARRY: 3

-- Vanguard_Persecutor
INSERT INTO `mob_pool_mods` VALUES (4171,75,3,1); -- CAN_PARRY: 3

-- Vanguard_Pillager
INSERT INTO `mob_pool_mods` VALUES (4172,75,3,1); -- CAN_PARRY: 3

-- Vanguard_Protector
INSERT INTO `mob_pool_mods` VALUES (4177,75,3,1); -- CAN_PARRY: 3

-- Vanguard_Purloiner
INSERT INTO `mob_pool_mods` VALUES (4178,75,3,1); -- CAN_PARRY: 3

-- Vanguard_Ronin
INSERT INTO `mob_pool_mods` VALUES (4179,75,3,1); -- CAN_PARRY: 3

-- Vanguard_Skirmisher
INSERT INTO `mob_pool_mods` VALUES (4183,75,3,1); -- CAN_PARRY: 3

-- Vanguard_Smithy
INSERT INTO `mob_pool_mods` VALUES (4184,75,3,1); -- CAN_PARRY: 3

-- Vanguards Crow
INSERT INTO `mob_pool_mods` VALUES (4186,34,20,1);  -- MAGIC_COOL: 20
INSERT INTO `mob_pool_mods` VALUES (4186,35,0,1);   -- STANDBACK_COOL: 0
INSERT INTO `mob_pool_mods` VALUES (4186,244,15,0); -- SILENCERES: 15

-- Vanguards Hecteyes
INSERT INTO `mob_pool_mods` VALUES (4187,34,20,1);  -- MAGIC_COOL: 20
INSERT INTO `mob_pool_mods` VALUES (4187,35,0,1);   -- STANDBACK_COOL: 0
INSERT INTO `mob_pool_mods` VALUES (4187,244,15,0); -- SILENCERES: 15

-- Vanguards Scorpion
INSERT INTO `mob_pool_mods` VALUES (4188,34,20,1);  -- MAGIC_COOL: 20
INSERT INTO `mob_pool_mods` VALUES (4188,35,0,1);   -- STANDBACK_COOL: 0
INSERT INTO `mob_pool_mods` VALUES (4188,244,15,0); -- SILENCERES: 15

-- Vanguards Slime
INSERT INTO `mob_pool_mods` VALUES (4189,34,20,1);  -- MAGIC_COOL: 20
INSERT INTO `mob_pool_mods` VALUES (4189,35,0,1);   -- STANDBACK_COOL: 0
INSERT INTO `mob_pool_mods` VALUES (4189,244,15,0); -- SILENCERES: 15

-- Vanguard_Tinkerer
INSERT INTO `mob_pool_mods` VALUES (4192,75,3,1); -- CAN_PARRY: 3

-- Vanguard_Trooper
INSERT INTO `mob_pool_mods` VALUES (4193,75,3,1); -- CAN_PARRY: 3

-- Vanguard_Vexer
INSERT INTO `mob_pool_mods` VALUES (4195,75,3,1); -- CAN_PARRY: 3

-- Vanguard_Vigilante
INSERT INTO `mob_pool_mods` VALUES (4196,75,3,1); -- CAN_PARRY: 3

-- Vanguard_Vindicator
INSERT INTO `mob_pool_mods` VALUES (4197,75,3,1); -- CAN_PARRY: 3

-- Vanguard_Visionary
INSERT INTO `mob_pool_mods` VALUES (4198,75,3,1); -- CAN_PARRY: 3

-- Vanguard_Welldigger
INSERT INTO `mob_pool_mods` VALUES (4199,75,3,1); -- CAN_PARRY: 3

-- Vanguard_Dragontamer
INSERT INTO `mob_pool_mods` VALUES (4649,75,3,1); -- CAN_PARRY: 3

-- Variable Hare
INSERT INTO `mob_pool_mods` VALUES (4204,28,10,1); -- EXP_BONUS: 10

-- Verglas Golem
INSERT INTO `mob_pool_mods` VALUES (4222,4,4,1); -- SIGHT_RANGE: 4

-- Virulent Peiste
INSERT INTO `mob_pool_mods` VALUES (4238,28,5,1); -- EXP_BONUS: 5

-- Woodland Sage
INSERT INTO `mob_pool_mods` VALUES (4361,5,16,1);   -- SOUND_RANGE: 16
INSERT INTO `mob_pool_mods` VALUES (4361,288,55,0); -- DOUBLE_ATTACK: 55

-- Zipacna
INSERT INTO `mob_pool_mods` VALUES (4504,4,30,1); -- SIGHT_RANGE: 30

-- Genbu Pet
INSERT INTO `mob_pool_mods` VALUES (4670,3,100,1); -- MP_BASE: 100

-- Seiryu Pet
INSERT INTO `mob_pool_mods` VALUES (4671,3,100,1); -- MP_BASE: 100

-- Byakko Pet
INSERT INTO `mob_pool_mods` VALUES (4672,3,100,1); -- MP_BASE: 100

-- Suzaku Pet
INSERT INTO `mob_pool_mods` VALUES (4673,3,100,1); -- MP_BASE: 100

-- Maat Blm
INSERT INTO `mob_pool_mods` VALUES (4836,62,1,1); -- NO_STANDBACK: 1

-- Maat Rng
INSERT INTO `mob_pool_mods` VALUES (4837,62,1,1); -- NO_STANDBACK: 1

-- Maat Bst
INSERT INTO `mob_pool_mods` VALUES (4932,30,1017,1); -- SPECIAL_SKILL: 1017
INSERT INTO `mob_pool_mods` VALUES (4932,33,50,1);   -- SPECIAL_COOL: 50

-- Promathia
INSERT INTO `mob_pool_mods` VALUES (5106,1,250,0);  -- DEF: 250
INSERT INTO `mob_pool_mods` VALUES (5106,29,30,0);  -- MDEF: 30
INSERT INTO `mob_pool_mods` VALUES (5106,288,25,0); -- DOUBLE_ATTACK: 25
INSERT INTO `mob_pool_mods` VALUES (5106,366,10,0); -- MAIN_DMG_RATING: 10

-- Maat Nin
INSERT INTO `mob_pool_mods` VALUES (5403,62,1,1); -- NO_STANDBACK: 1

-- Maat Pld
INSERT INTO `mob_pool_mods` VALUES (5408,30,1036,1); -- SPECIAL_SKILL: 1036
INSERT INTO `mob_pool_mods` VALUES (5408,33,50,1);   -- SPECIAL_COOL: 50
INSERT INTO `mob_pool_mods` VALUES (5408,58,40,1);   -- SPECIAL_DELAY: 40

-- Maat Drk
INSERT INTO `mob_pool_mods` VALUES (5409,30,1036,1); -- SPECIAL_SKILL: 1036
INSERT INTO `mob_pool_mods` VALUES (5409,33,50,1);   -- SPECIAL_COOL: 50
INSERT INTO `mob_pool_mods` VALUES (5409,58,40,1);   -- SPECIAL_DELAY: 40

-- Trust: Shikaree Z
INSERT INTO `mob_pool_mods` VALUES (5915,6,100,0);      -- MPP: 100

-- Trust: Lehko
INSERT INTO `mob_pool_mods` VALUES (5922,6,150,0);      -- MPP: 150

-- Trust: Fablinix
INSERT INTO `mob_pool_mods` VALUES (5932,6,250,0);    -- MPP: 250

-- Trust: Ferreous Coffin
INSERT INTO `mob_pool_mods` VALUES (5944,3,-10,0);      -- HPP: -10
INSERT INTO `mob_pool_mods` VALUES (5944,6,35,0);       -- MPP: 35

-- Trust: Prishe II
INSERT INTO `mob_pool_mods` VALUES (6011,165,25,0);     -- CRITHITRATE: 25

-- Trust: Shantotto II
INSERT INTO `mob_pool_mods` VALUES (6019,3,-10,0);      -- HPP: -10

-- Ixzdei Rdm
INSERT INTO `mob_pool_mods` VALUES (7039,34,60,1); -- MAGIC_COOL: 60
INSERT INTO `mob_pool_mods` VALUES (7039,4,15,1);  -- SIGHT_RANGE: 15
INSERT INTO `mob_pool_mods` VALUES (7039,5,15,1);  -- SOUND_RANGE: 15
INSERT INTO `mob_pool_mods` VALUES (7039,11,30,1); -- LINK_RADIUS: 30

-- Kaiser Behemoth (Apollyon NW)
INSERT INTO `mob_pool_mods` VALUES (6732,3,100,1); -- MP_BASE: 100

/*!40000 ALTER TABLE `mob_pool_mods` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
