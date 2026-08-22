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

-- Adamantoise
INSERT INTO `mob_pool_mods` VALUES (44,368,150,0); -- REGAIN: 150

-- Agas

-- Animated Shield

-- Aspidochelone

-- Aura Statue

-- Battle Bugard

-- Biast

-- Bloodlapper

-- Bugbby

-- Citipati

-- Colorful Treant

-- Colossus

-- Darksteel Golem

-- Dea

-- Defender

-- Defoliate Treant

-- Demonic Rose
INSERT INTO `mob_pool_mods` VALUES (978,28,23,1); -- EXP_BONUS: 23

-- Demonic Tiphia
INSERT INTO `mob_pool_mods` VALUES (979,8,60,1); -- HEAL_CHANCE: 60
INSERT INTO `mob_pool_mods` VALUES (979,9,60,1); -- HP_HEAL_CHANCE: 60

-- Detector

-- Effigy Prototype

-- Enkidu

-- Exoplates

-- Faust

-- Frostmane
INSERT INTO `mob_pool_mods` VALUES (1429,28,10,1); -- EXP_BONUS: 10

-- Gargantua
INSERT INTO `mob_pool_mods` VALUES (1461,4,4,1); -- SIGHT_RANGE: 4

-- Genbu
INSERT INTO `mob_pool_mods` VALUES (1491,3,100,1); -- MP_BASE: 100

-- Gladiatorial Weapon

-- Goblin Digger Near

-- Goblin Freelance

-- Goblin Swordsman

-- Golden-Tongued Culberry

-- Goliath

-- Greater Manticore
INSERT INTO `mob_pool_mods` VALUES (1806,28,10,1); -- EXP_BONUS: 10

-- Hydras Hound

-- Icon Prototype

-- Intulo
INSERT INTO `mob_pool_mods` VALUES (2083,29,25,0); -- MDEF: 25

-- Kaiser Behemoth S

-- King Arthro
INSERT INTO `mob_pool_mods` VALUES (2254,407,100,0); -- UFASTCAST: 100

-- King Behemoth

-- King Vinegarroon

-- Kirin

-- Knight Crab
INSERT INTO `mob_pool_mods` VALUES (2271,64,15,0);  -- COMBAT_SKILLUP_RATE: 15
INSERT INTO `mob_pool_mods` VALUES (2271,65,15,0);  -- MAGIC_SKILLUP_RATE: 15
INSERT INTO `mob_pool_mods` VALUES (2271,165,15,0); -- CRITHITRATE: 15

-- Ladon

-- Minotaur

-- Morbolger

-- Morbol Menace

-- Morion Worm

-- Mythril Golem

-- Nidhogg

-- Nunyunuwi

-- Ore Golem

-- Parata

-- Polar Hare

-- Proto-Omega

-- Qiqirn Archaeologist
INSERT INTO `mob_pool_mods` VALUES (3245,56,1,1); -- HP_STANDBACK: 1

-- Qiqirn Enterpriser

-- Qiqirn Mercenary

-- Qiqirn Pecheur
INSERT INTO `mob_pool_mods` VALUES (3262,56,1,1); -- HP_STANDBACK: 1

-- Qiqirn Rock Hound

-- Qiqirn Trailer

-- Qiqirn Volcanist
INSERT INTO `mob_pool_mods` VALUES (3268,56,1,1); -- HP_STANDBACK: 1

-- Race Runner

-- Rock Golem

-- Seiryu
INSERT INTO `mob_pool_mods` VALUES (3540,3,100,1); -- MP_BASE: 100

-- Serket
INSERT INTO `mob_pool_mods` VALUES (3549,370,50,0); -- REGEN: 50

-- Slave Globe

-- Snoll Tzar

-- Statue Prototype

-- Stone Golem

-- Stray

-- Stubborn Dredvodd

-- Suzaku
INSERT INTO `mob_pool_mods` VALUES (3816,3,100,1); -- MP_BASE: 100

-- Swashstox Beadblinker

-- Tavnazian Ram

-- Tiny Mandragora

-- Tombstone Prototype

-- Tuchulcha

-- Ullikummi

-- Vanguard_Armorer

-- Vanguard_Assassin

-- Vanguard_Backstabber

-- Vanguard_Beasttender

-- Vanguard_Bugler

-- Vanguard_Chanter

-- Vanguard_Defender

-- Vanguard_Drakekeeper

-- Vanguard_Enchanter

-- Vanguard_Exemplar

-- Vanguard_Footsoldier

-- Vanguard_Gutslasher

-- Vanguard_Hatamoto

-- Vanguard_Hawker

-- Vanguard_Hitman

-- Vanguard_Impaler

-- Vanguard_Inciter

-- Vanguard_Kusa

-- Vanguard_Liberator

-- Vanguard_Maestro

-- Vanguard_Minstrel

-- Vanguard_Neckchopper

-- Vanguard_Ogresoother

-- Vanguard_Partisan

-- Vanguard_Pathfinder

-- Vanguard_Persecutor

-- Vanguard_Pillager

-- Vanguard_Protector

-- Vanguard_Purloiner

-- Vanguard_Ronin

-- Vanguard_Skirmisher

-- Vanguard_Smithy

-- Vanguards Crow

-- Vanguards Hecteyes

-- Vanguards Scorpion

-- Vanguards Slime

-- Vanguard_Tinkerer

-- Vanguard_Trooper

-- Vanguard_Vexer

-- Vanguard_Vigilante

-- Vanguard_Vindicator

-- Vanguard_Visionary

-- Vanguard_Welldigger

-- Vanguard_Dragontamer

-- Variable Hare

-- Verglas Golem

-- Virulent Peiste

-- Woodland Sage
INSERT INTO `mob_pool_mods` VALUES (4361,5,16,1);   -- SOUND_RANGE: 16
INSERT INTO `mob_pool_mods` VALUES (4361,288,55,0); -- DOUBLE_ATTACK: 55

-- Zipacna

-- Genbu Pet

-- Seiryu Pet

-- Byakko Pet

-- Suzaku Pet

-- Trust: Shikaree Z
INSERT INTO `mob_pool_mods` VALUES (5915,6,100,0);      -- MPP: 100

-- Trust: Lehko
INSERT INTO `mob_pool_mods` VALUES (5922,6,150,0);      -- MPP: 150

-- Trust: Fablinix
INSERT INTO `mob_pool_mods` VALUES (5932,6,250,0);    -- MPP: 250

-- Trust: Karaha-Baruha
INSERT INTO `mob_pool_mods` VALUES (5936,3,-10,0); -- HPP: -10
INSERT INTO `mob_pool_mods` VALUES (5936,6,20,0); -- MPP: 20

-- Trust: Areuhat
INSERT INTO `mob_pool_mods` VALUES (5939,1046,30,0); -- ENHANCES_BLOOD_RAGE: 30
INSERT INTO `mob_pool_mods` VALUES (5939,234,8,0);  -- DEMON_KILLER: 8

-- Trust: Ferreous Coffin
INSERT INTO `mob_pool_mods` VALUES (5944,3,-10,0);      -- HPP: -10
INSERT INTO `mob_pool_mods` VALUES (5944,6,35,0);       -- MPP: 35

-- Trust: Rahal
INSERT INTO `mob_pool_mods` VALUES (5951,233,8,0); -- DRAGON_KILLER: 8

-- Trust: Prishe II
INSERT INTO `mob_pool_mods` VALUES (6011,165,25,0);     -- CRITHITRATE: 25

-- Trust: Shantotto II
INSERT INTO `mob_pool_mods` VALUES (6019,3,-10,0);      -- HPP: -10

-- Kaiser Behemoth (Apollyon NW)

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
