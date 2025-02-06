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
-- Table structure for table `mob_family_mods`
--

DROP TABLE IF EXISTS `mob_family_mods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mob_family_mods` (
  `familyid` smallint(5) unsigned NOT NULL,
  `modid` smallint(5) unsigned NOT NULL,
  `value` smallint(5) NOT NULL DEFAULT '0',
  `is_mob_mod` boolean NOT NULL DEFAULT '0',
  PRIMARY KEY (`familyid`,`modid`)
) ENGINE=Aria TRANSACTIONAL=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci AVG_ROW_LENGTH=13 PACK_KEYS=1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mob_family_mods`
--

LOCK TABLES `mob_family_mods` WRITE;
/*!40000 ALTER TABLE `mob_family_mods` DISABLE KEYS */;
-- Adamantoise
INSERT INTO `mob_family_mods` VALUES (2,36,50,1); -- ROAM_COOL: 50
INSERT INTO `mob_family_mods` VALUES (2,52,30,1); -- ROAM_RATE: 30
INSERT INTO `mob_family_mods` VALUES (2,63,20,0); -- DEFP: 20

-- Ahriman
INSERT INTO `mob_family_mods` VALUES (4,7,60,1);   -- GA_CHANCE: 60
INSERT INTO `mob_family_mods` VALUES (4,29,20,0);  -- MDEF: 20
INSERT INTO `mob_family_mods` VALUES (4,36,40,1);  -- ROAM_COOL: 40
INSERT INTO `mob_family_mods` VALUES (4,51,5,1);   -- ROAM_TURNS: 5
INSERT INTO `mob_family_mods` VALUES (4,56,-1,1);  -- HP_STANDBACK: -1
INSERT INTO `mob_family_mods` VALUES (4,244,20,0); -- SILENCERES: 20

-- Animatedweapon-Archery
INSERT INTO `mob_family_mods` VALUES (7,3,50,1); -- MP_BASE: 50

-- Animatedweapon-Axe
INSERT INTO `mob_family_mods` VALUES (8,3,50,1); -- MP_BASE: 50

-- Animatedweapon-Club
INSERT INTO `mob_family_mods` VALUES (9,3,50,1); -- MP_BASE: 50

-- Animatedweapon-Dagger
INSERT INTO `mob_family_mods` VALUES (11,3,50,1); -- MP_BASE: 50

-- Animatedweapon-Greataxe
INSERT INTO `mob_family_mods` VALUES (12,3,50,1); -- MP_BASE: 50

-- Animatedweapon-Greatkatana
INSERT INTO `mob_family_mods` VALUES (13,3,50,1); -- MP_BASE: 50

-- Animatedweapon-Greatsword
INSERT INTO `mob_family_mods` VALUES (14,3,50,1); -- MP_BASE: 50

-- Animatedweapon-Handtohand
INSERT INTO `mob_family_mods` VALUES (15,3,50,1); -- MP_BASE: 50

-- Animatedweapon-Instrument
INSERT INTO `mob_family_mods` VALUES (16,3,50,1); -- MP_BASE: 50

-- Animatedweapon-Katana
INSERT INTO `mob_family_mods` VALUES (17,3,50,1); -- MP_BASE: 50

-- Animatedweapon-Marksmanship
INSERT INTO `mob_family_mods` VALUES (18,3,50,1); -- MP_BASE: 50

-- Animatedweapon-Polearm
INSERT INTO `mob_family_mods` VALUES (19,3,50,1); -- MP_BASE: 50

-- Animatedweapon-Scythe
INSERT INTO `mob_family_mods` VALUES (20,3,50,1); -- MP_BASE: 50

-- Animatedweapon-Shield
INSERT INTO `mob_family_mods` VALUES (21,3,50,1); -- MP_BASE: 50

-- Animatedweapon-Staff
INSERT INTO `mob_family_mods` VALUES (23,3,50,1); -- MP_BASE: 50

-- Animatedweapon-Sword
INSERT INTO `mob_family_mods` VALUES (24,3,50,1); -- MP_BASE: 50

-- Antlion
INSERT INTO `mob_family_mods` VALUES (26,36,50,1); -- ROAM_COOL: 50
INSERT INTO `mob_family_mods` VALUES (26,51,2,1);  -- ROAM_TURNS: 2
INSERT INTO `mob_family_mods` VALUES (26,52,30,1); -- ROAM_RATE: 30
INSERT INTO `mob_family_mods` VALUES (26,63,20,0); -- DEFP: 20

-- Apkallu
INSERT INTO `mob_family_mods` VALUES (27,10,14,1); -- SUBLINK: 14

-- Avatar-Atomos
INSERT INTO `mob_family_mods` VALUES (32,56,-1,1); -- HP_STANDBACK: -1

-- Avatar-Alexander
INSERT INTO `mob_family_mods` VALUES (33,56,-1,1); -- HP_STANDBACK: -1

-- Avatar-Carbuncle
INSERT INTO `mob_family_mods` VALUES (34,3,100,1); -- MP_BASE: 100
INSERT INTO `mob_family_mods` VALUES (34,56,-1,1); -- HP_STANDBACK: -1

-- Avatar-Diabolos
INSERT INTO `mob_family_mods` VALUES (35,56,-1,1); -- HP_STANDBACK: -1

-- Avatar-Fenrir
INSERT INTO `mob_family_mods` VALUES (36,56,-1,1); -- HP_STANDBACK: -1

-- Avatar-Garuda
INSERT INTO `mob_family_mods` VALUES (37,56,-1,1); -- HP_STANDBACK: -1

-- Avatar-Ifrit
INSERT INTO `mob_family_mods` VALUES (38,56,-1,1); -- HP_STANDBACK: -1

-- Monoceros
INSERT INTO `mob_family_mods` VALUES (39,56,-1,1); -- HP_STANDBACK: -1

-- Avatar-Leviathan
INSERT INTO `mob_family_mods` VALUES (40,56,-1,1); -- HP_STANDBACK: -1

-- Avatar-Odin
INSERT INTO `mob_family_mods` VALUES (41,56,-1,1); -- HP_STANDBACK: -1

-- Avatar-Odin
INSERT INTO `mob_family_mods` VALUES (42,56,-1,1); -- HP_STANDBACK: -1

-- Avatar-Ramuh
INSERT INTO `mob_family_mods` VALUES (43,56,-1,1); -- HP_STANDBACK: -1

-- Avatar-Shiva
INSERT INTO `mob_family_mods` VALUES (44,56,-1,1); -- HP_STANDBACK: -1

-- Avatar-Titan
INSERT INTO `mob_family_mods` VALUES (45,56,-1,1); -- HP_STANDBACK: -1

-- Bat
INSERT INTO `mob_family_mods` VALUES (46,10,3,1);  -- SUBLINK: 3
INSERT INTO `mob_family_mods` VALUES (46,36,35,1); -- ROAM_COOL: 35
INSERT INTO `mob_family_mods` VALUES (46,51,3,1);  -- ROAM_TURNS: 3
INSERT INTO `mob_family_mods` VALUES (46,52,30,1); -- ROAM_RATE: 30

-- Bat Trio
INSERT INTO `mob_family_mods` VALUES (47,10,3,1);   -- SUBLINK: 3
INSERT INTO `mob_family_mods` VALUES (47,36,35,1);  -- ROAM_COOL: 35
INSERT INTO `mob_family_mods` VALUES (47,51,2,1);   -- ROAM_TURNS: 2
INSERT INTO `mob_family_mods` VALUES (47,52,30,1);  -- ROAM_RATE: 30

-- Bee
INSERT INTO `mob_family_mods` VALUES (48,36,15,1);  -- ROAM_COOL: 15
INSERT INTO `mob_family_mods` VALUES (48,51,2,1);   -- ROAM_TURNS: 2

-- Beetle
INSERT INTO `mob_family_mods` VALUES (49,31,15,1); -- ROAM_DISTANCE: 15
INSERT INTO `mob_family_mods` VALUES (49,36,60,1); -- ROAM_COOL: 60
INSERT INTO `mob_family_mods` VALUES (49,52,30,1); -- ROAM_RATE: 30

-- Behemoth
INSERT INTO `mob_family_mods` VALUES (51,36,50,1); -- ROAM_COOL: 50

-- Bhoot
INSERT INTO `mob_family_mods` VALUES (52,242,20,0);  -- PARALYZERES: 20

-- Bomb
INSERT INTO `mob_family_mods` VALUES (56,36,30,1); -- ROAM_COOL: 30
INSERT INTO `mob_family_mods` VALUES (56,51,5,1);  -- ROAM_TURNS: 5
INSERT INTO `mob_family_mods` VALUES (56,52,20,1); -- ROAM_RATE: 20

-- Buffalo
INSERT INTO `mob_family_mods` VALUES (57,3,50,1);   -- MP_BASE: 50
INSERT INTO `mob_family_mods` VALUES (57,36,50,1);  -- ROAM_COOL: 50
INSERT INTO `mob_family_mods` VALUES (57,51,4,1);   -- ROAM_TURNS: 4
INSERT INTO `mob_family_mods` VALUES (57,52,30,1);  -- ROAM_RATE: 30
INSERT INTO `mob_family_mods` VALUES (57,62,10,0);  -- ATTP: 10
INSERT INTO `mob_family_mods` VALUES (57,63,20,0);  -- DEFP: 20

-- Bugard
INSERT INTO `mob_family_mods` VALUES (58,36,45,1);  -- ROAM_COOL: 45
INSERT INTO `mob_family_mods` VALUES (58,51,3,1);   -- ROAM_TURNS: 3
INSERT INTO `mob_family_mods` VALUES (58,52,30,1);  -- ROAM_RATE: 30
INSERT INTO `mob_family_mods` VALUES (58,62,10,0);  -- ATTP: 10
INSERT INTO `mob_family_mods` VALUES (58,63,20,0);  -- DEFP: 20

-- Bugbear
INSERT INTO `mob_family_mods` VALUES (59,10,5,1);   -- SUBLINK: 5
INSERT INTO `mob_family_mods` VALUES (59,36,50,1);  -- ROAM_COOL: 50
INSERT INTO `mob_family_mods` VALUES (59,51,2,1);   -- ROAM_TURNS: 2
INSERT INTO `mob_family_mods` VALUES (59,52,30,1);  -- ROAM_RATE: 30
INSERT INTO `mob_family_mods` VALUES (59,63,20,0);  -- DEFP: 20

-- Cardian
INSERT INTO `mob_family_mods` VALUES (61,29,25,0);   -- MDEF: 25
INSERT INTO `mob_family_mods` VALUES (61,36,40,1);   -- ROAM_COOL: 40
INSERT INTO `mob_family_mods` VALUES (61,51,2,1);    -- ROAM_TURNS: 2
INSERT INTO `mob_family_mods` VALUES (61,52,20,1);   -- ROAM_RATE: 20
INSERT INTO `mob_family_mods` VALUES (61,389,-25,0); -- UDMGMAGIC: -25

-- Cerberus
INSERT INTO `mob_family_mods` VALUES (62,36,50,1); -- ROAM_COOL: 50

-- Cluster
INSERT INTO `mob_family_mods` VALUES (68,36,40,1); -- ROAM_COOL: 40
INSERT INTO `mob_family_mods` VALUES (68,51,2,1);  -- ROAM_TURNS: 2
INSERT INTO `mob_family_mods` VALUES (68,52,20,1); -- ROAM_RATE: 20

-- Cluster
INSERT INTO `mob_family_mods` VALUES (69,36,40,1); -- ROAM_COOL: 40
INSERT INTO `mob_family_mods` VALUES (69,51,2,1);  -- ROAM_TURNS: 2
INSERT INTO `mob_family_mods` VALUES (69,52,20,1); -- ROAM_RATE: 20

-- Cockatrice
INSERT INTO `mob_family_mods` VALUES (70,36,30,1); -- ROAM_COOL: 30
INSERT INTO `mob_family_mods` VALUES (70,51,3,1);  -- ROAM_TURNS: 3
INSERT INTO `mob_family_mods` VALUES (70,52,30,1); -- ROAM_RATE: 30

-- Coeurl
INSERT INTO `mob_family_mods` VALUES (71,31,5,1);  -- ROAM_DISTANCE: 5
INSERT INTO `mob_family_mods` VALUES (71,36,55,1); -- ROAM_COOL: 55
INSERT INTO `mob_family_mods` VALUES (71,52,30,1); -- ROAM_RATE: 30

-- Colibri
INSERT INTO `mob_family_mods` VALUES (72,3,50,1);  -- MP_BASE: 50
INSERT INTO `mob_family_mods` VALUES (72,29,10,0); -- MDEF: 10
INSERT INTO `mob_family_mods` VALUES (72,51,2,1);  -- ROAM_TURNS: 2
INSERT INTO `mob_family_mods` VALUES (72,52,30,1); -- ROAM_RATE: 30
INSERT INTO `mob_family_mods` VALUES (72,68,20,0); -- EVA: 20

-- Corse
INSERT INTO `mob_family_mods` VALUES (74,29,25,0);   -- MDEF: 25
INSERT INTO `mob_family_mods` VALUES (74,36,50,1);   -- ROAM_COOL: 50
INSERT INTO `mob_family_mods` VALUES (74,51,2,1);    -- ROAM_TURNS: 2
INSERT INTO `mob_family_mods` VALUES (74,52,30,1);   -- ROAM_RATE: 30
INSERT INTO `mob_family_mods` VALUES (74,389,-25,0); -- UDMGMAGIC: -25

-- Crab
INSERT INTO `mob_family_mods` VALUES (75,36,15,1); -- ROAM_COOL: 15

-- Crab
INSERT INTO `mob_family_mods` VALUES (76,36,15,1); -- ROAM_COOL: 15

-- Crab
INSERT INTO `mob_family_mods` VALUES (77,36,15,1); -- ROAM_COOL: 15

-- Crawler
INSERT INTO `mob_family_mods` VALUES (79,36,55,1);  -- ROAM_COOL: 55
INSERT INTO `mob_family_mods` VALUES (79,52,30,1);  -- ROAM_RATE: 30

-- Dhalmel
INSERT INTO `mob_family_mods` VALUES (80,36,30,1);  -- ROAM_COOL: 30
INSERT INTO `mob_family_mods` VALUES (80,51,2,1);   -- ROAM_TURNS: 2
INSERT INTO `mob_family_mods` VALUES (80,52,30,1);  -- ROAM_RATE: 30

-- Diremite
INSERT INTO `mob_family_mods` VALUES (81,36,50,1);  -- ROAM_COOL: 50
INSERT INTO `mob_family_mods` VALUES (81,51,2,1);   -- ROAM_TURNS: 2

-- Doll
INSERT INTO `mob_family_mods` VALUES (83,31,5,1);  -- ROAM_DISTANCE: 5
INSERT INTO `mob_family_mods` VALUES (83,36,55,1); -- ROAM_COOL: 55
INSERT INTO `mob_family_mods` VALUES (83,52,30,1); -- ROAM_RATE: 30

-- Doll
INSERT INTO `mob_family_mods` VALUES (84,31,5,1);  -- ROAM_DISTANCE: 5
INSERT INTO `mob_family_mods` VALUES (84,36,55,1); -- ROAM_COOL: 55
INSERT INTO `mob_family_mods` VALUES (84,52,30,1); -- ROAM_RATE: 30

-- Doll
INSERT INTO `mob_family_mods` VALUES (85,31,5,1);  -- ROAM_DISTANCE: 5
INSERT INTO `mob_family_mods` VALUES (85,36,55,1); -- ROAM_COOL: 55
INSERT INTO `mob_family_mods` VALUES (85,52,30,1); -- ROAM_RATE: 30

-- Doomed
INSERT INTO `mob_family_mods` VALUES (86,36,55,1);   -- ROAM_COOL: 55
INSERT INTO `mob_family_mods` VALUES (86,52,30,1);   -- ROAM_RATE: 30

-- Dragon
INSERT INTO `mob_family_mods` VALUES (87,3,10,1);    -- MP_BASE: 10
INSERT INTO `mob_family_mods` VALUES (87,4,18,1);    -- SIGHT_RANGE: 18
INSERT INTO `mob_family_mods` VALUES (87,5,10,1);    -- SOUND_RANGE: 10
INSERT INTO `mob_family_mods` VALUES (87,36,55,1);   -- ROAM_COOL: 55
INSERT INTO `mob_family_mods` VALUES (87,54,1000,1); -- GIL_BONUS: 1000
INSERT INTO `mob_family_mods` VALUES (87,62,20,0);   -- ATTP: 20

-- Dynamisstatue-Goblin
INSERT INTO `mob_family_mods` VALUES (92,23,2047,1); -- IMMUNITY: 2047
INSERT INTO `mob_family_mods` VALUES (92,56,-1,1);   -- HP_STANDBACK: -1
INSERT INTO `mob_family_mods` VALUES (92,73,100,0);  -- STORETP: 100

-- Dynamisstatue-Orc
INSERT INTO `mob_family_mods` VALUES (93,23,2047,1); -- IMMUNITY: 2047
INSERT INTO `mob_family_mods` VALUES (93,56,-1,1);   -- HP_STANDBACK: -1
INSERT INTO `mob_family_mods` VALUES (93,73,100,0);  -- STORETP: 100

-- Dynamisstatue-Quadav
INSERT INTO `mob_family_mods` VALUES (94,23,2047,1); -- IMMUNITY: 2047
INSERT INTO `mob_family_mods` VALUES (94,56,-1,1);   -- HP_STANDBACK: -1
INSERT INTO `mob_family_mods` VALUES (94,73,100,0);  -- STORETP: 100

-- Dynamisstatue-Yagudo
INSERT INTO `mob_family_mods` VALUES (95,23,2047,1); -- IMMUNITY: 2047
INSERT INTO `mob_family_mods` VALUES (95,56,-1,1);   -- HP_STANDBACK: -1
INSERT INTO `mob_family_mods` VALUES (95,73,100,0);  -- STORETP: 100

-- Lizard-Ice
INSERT INTO `mob_family_mods` VALUES (97,36,60,1); -- ROAM_COOL: 60
INSERT INTO `mob_family_mods` VALUES (97,51,4,1);  -- ROAM_TURNS: 4
INSERT INTO `mob_family_mods` VALUES (97,52,30,1); -- ROAM_RATE: 30

-- Eft
INSERT INTO `mob_family_mods` VALUES (98,36,50,1); -- ROAM_COOL: 50
INSERT INTO `mob_family_mods` VALUES (98,51,5,1);  -- ROAM_TURNS: 5
INSERT INTO `mob_family_mods` VALUES (98,52,30,1); -- ROAM_RATE: 30

-- Elemental-Air
INSERT INTO `mob_family_mods` VALUES (99,51,3,1);  -- ROAM_TURNS: 3
INSERT INTO `mob_family_mods` VALUES (99,56,-1,1); -- HP_STANDBACK: -1

-- Elemental-Dark
INSERT INTO `mob_family_mods` VALUES (100,51,3,1);  -- ROAM_TURNS: 3
INSERT INTO `mob_family_mods` VALUES (100,56,-1,1); -- HP_STANDBACK: -1

-- Elemental-Earth
INSERT INTO `mob_family_mods` VALUES (101,51,3,1);  -- ROAM_TURNS: 3
INSERT INTO `mob_family_mods` VALUES (101,56,-1,1); -- HP_STANDBACK: -1

-- Elemental-Fire
INSERT INTO `mob_family_mods` VALUES (102,51,3,1);  -- ROAM_TURNS: 3
INSERT INTO `mob_family_mods` VALUES (102,56,-1,1); -- HP_STANDBACK: -1

-- Elemental-Ice
INSERT INTO `mob_family_mods` VALUES (103,51,3,1);  -- ROAM_TURNS: 3
INSERT INTO `mob_family_mods` VALUES (103,56,-1,1); -- HP_STANDBACK: -1

-- Elemental-Light
INSERT INTO `mob_family_mods` VALUES (104,51,3,1);  -- ROAM_TURNS: 3
INSERT INTO `mob_family_mods` VALUES (104,56,-1,1); -- HP_STANDBACK: -1

-- Elemental-Lightning
INSERT INTO `mob_family_mods` VALUES (105,51,3,1);  -- ROAM_TURNS: 3
INSERT INTO `mob_family_mods` VALUES (105,56,-1,1); -- HP_STANDBACK: -1

-- Elemental-Water
INSERT INTO `mob_family_mods` VALUES (106,51,3,1);  -- ROAM_TURNS: 3
INSERT INTO `mob_family_mods` VALUES (106,56,-1,1); -- HP_STANDBACK: -1

-- Evil Weapon
INSERT INTO `mob_family_mods` VALUES (110,3,50,1);    -- MP_BASE: 50
INSERT INTO `mob_family_mods` VALUES (110,29,13,0);   -- MDEF: 13
INSERT INTO `mob_family_mods` VALUES (110,36,45,1);   -- ROAM_COOL: 45
INSERT INTO `mob_family_mods` VALUES (110,51,3,1);    -- ROAM_TURNS: 3
INSERT INTO `mob_family_mods` VALUES (110,52,30,1);   -- ROAM_RATE: 30
INSERT INTO `mob_family_mods` VALUES (110,389,-13,0); -- UDMGMAGIC: -13

-- Non-Beastmen regular frogs
INSERT INTO `mob_family_mods` VALUES (111,62,1,1); -- NO_STANDBACK: 1

-- Flan
INSERT INTO `mob_family_mods` VALUES (112,51,2,1);   -- ROAM_TURNS: 2
INSERT INTO `mob_family_mods` VALUES (112,52,30,1);  -- ROAM_RATE: 30
INSERT INTO `mob_family_mods` VALUES (112,389,25,0); -- UDMGMAGIC: 25

-- Fomor
INSERT INTO `mob_family_mods` VALUES (115,36,50,1);   -- ROAM_COOL: 50
INSERT INTO `mob_family_mods` VALUES (115,51,2,1);    -- ROAM_TURNS: 2
INSERT INTO `mob_family_mods` VALUES (115,52,30,1);   -- ROAM_RATE: 30
INSERT INTO `mob_family_mods` VALUES (115,54,100,1);  -- GIL_BONUS: 100

-- Funguar
INSERT INTO `mob_family_mods` VALUES (116,31,15,1); -- ROAM_DISTANCE: 15
INSERT INTO `mob_family_mods` VALUES (116,36,60,1); -- ROAM_COOL: 60
INSERT INTO `mob_family_mods` VALUES (116,52,30,1); -- ROAM_RATE: 30

-- Ghost
INSERT INTO `mob_family_mods` VALUES (121,36,50,1);   -- ROAM_COOL: 50
INSERT INTO `mob_family_mods` VALUES (121,52,30,1);   -- ROAM_RATE: 30

-- Ghrah
INSERT INTO `mob_family_mods` VALUES (122,389,-13,0); -- UDMGMAGIC: -13

-- Ghrah
INSERT INTO `mob_family_mods` VALUES (123,389,-13,0); -- UDMGMAGIC: -13

-- Ghrah
INSERT INTO `mob_family_mods` VALUES (124,389,-13,0); -- UDMGMAGIC: -13

-- Greater Bird
INSERT INTO `mob_family_mods` VALUES (125,36,40,1);   -- ROAM_COOL: 40
INSERT INTO `mob_family_mods` VALUES (125,51,2,1);    -- ROAM_TURNS: 2
INSERT INTO `mob_family_mods` VALUES (125,52,30,1);   -- ROAM_RATE: 30

-- Gigas
INSERT INTO `mob_family_mods` VALUES (126,31,5,1);   -- ROAM_DISTANCE: 5
INSERT INTO `mob_family_mods` VALUES (126,36,25,1);  -- ROAM_COOL: 25
INSERT INTO `mob_family_mods` VALUES (126,51,2,1);   -- ROAM_TURNS: 2
INSERT INTO `mob_family_mods` VALUES (126,52,30,1);  -- ROAM_RATE: 30
INSERT INTO `mob_family_mods` VALUES (126,54,180,1); -- GIL_BONUS: 180

-- Gigas
INSERT INTO `mob_family_mods` VALUES (127,31,5,1);   -- ROAM_DISTANCE: 5
INSERT INTO `mob_family_mods` VALUES (127,36,25,1);  -- ROAM_COOL: 25
INSERT INTO `mob_family_mods` VALUES (127,51,2,1);   -- ROAM_TURNS: 2
INSERT INTO `mob_family_mods` VALUES (127,52,30,1);  -- ROAM_RATE: 30
INSERT INTO `mob_family_mods` VALUES (127,54,180,1); -- GIL_BONUS: 180

-- Gigas
INSERT INTO `mob_family_mods` VALUES (128,31,5,1);   -- ROAM_DISTANCE: 5
INSERT INTO `mob_family_mods` VALUES (128,36,25,1);  -- ROAM_COOL: 25
INSERT INTO `mob_family_mods` VALUES (128,51,2,1);   -- ROAM_TURNS: 2
INSERT INTO `mob_family_mods` VALUES (128,52,30,1);  -- ROAM_RATE: 30
INSERT INTO `mob_family_mods` VALUES (128,54,180,1); -- GIL_BONUS: 180

-- Gigas
INSERT INTO `mob_family_mods` VALUES (129,31,5,1);   -- ROAM_DISTANCE: 5
INSERT INTO `mob_family_mods` VALUES (129,36,25,1);  -- ROAM_COOL: 25
INSERT INTO `mob_family_mods` VALUES (129,51,2,1);   -- ROAM_TURNS: 2
INSERT INTO `mob_family_mods` VALUES (129,52,30,1);  -- ROAM_RATE: 30
INSERT INTO `mob_family_mods` VALUES (129,54,180,1); -- GIL_BONUS: 180

-- Gigas
INSERT INTO `mob_family_mods` VALUES (130,31,5,1);   -- ROAM_DISTANCE: 5
INSERT INTO `mob_family_mods` VALUES (130,36,25,1);  -- ROAM_COOL: 25
INSERT INTO `mob_family_mods` VALUES (130,51,2,1);   -- ROAM_TURNS: 2
INSERT INTO `mob_family_mods` VALUES (130,52,30,1);  -- ROAM_RATE: 30
INSERT INTO `mob_family_mods` VALUES (130,54,180,1); -- GIL_BONUS: 180

-- Goblin
INSERT INTO `mob_family_mods` VALUES (133,10,5,1); -- SUBLINK: 5

-- Golem
INSERT INTO `mob_family_mods` VALUES (135,4,4,1);   -- SIGHT_RANGE: 4
INSERT INTO `mob_family_mods` VALUES (135,31,5,1);  -- ROAM_DISTANCE: 5
INSERT INTO `mob_family_mods` VALUES (135,36,55,1); -- ROAM_COOL: 55
INSERT INTO `mob_family_mods` VALUES (135,52,30,1); -- ROAM_RATE: 30

-- Goobbue
INSERT INTO `mob_family_mods` VALUES (136,31,5,1);   -- ROAM_DISTANCE: 5
INSERT INTO `mob_family_mods` VALUES (136,36,60,1);  -- ROAM_COOL: 60
INSERT INTO `mob_family_mods` VALUES (136,52,30,1);  -- ROAM_RATE: 30
INSERT INTO `mob_family_mods` VALUES (136,62,10,0);  -- ATTP: 10

-- Hecteyes
INSERT INTO `mob_family_mods` VALUES (139,36,55,1);   -- ROAM_COOL: 55
INSERT INTO `mob_family_mods` VALUES (139,52,30,1);   -- ROAM_RATE: 30
INSERT INTO `mob_family_mods` VALUES (139,56,-1,1);   -- HP_STANDBACK: -1
INSERT INTO `mob_family_mods` VALUES (139,68,10,0);   -- EVA: 10

-- Hippogryph
INSERT INTO `mob_family_mods` VALUES (140,3,50,1);  -- MP_BASE: 50
INSERT INTO `mob_family_mods` VALUES (140,36,55,1); -- ROAM_COOL: 55
INSERT INTO `mob_family_mods` VALUES (140,51,2,1);  -- ROAM_TURNS: 2

-- Hippogryph-High Res
INSERT INTO `mob_family_mods` VALUES (141,3,50,1);  -- MP_BASE: 50
INSERT INTO `mob_family_mods` VALUES (141,36,55,1); -- ROAM_COOL: 55
INSERT INTO `mob_family_mods` VALUES (141,51,2,1);  -- ROAM_TURNS: 2

-- Hound
INSERT INTO `mob_family_mods` VALUES (142,36,50,1);   -- ROAM_COOL: 50
INSERT INTO `mob_family_mods` VALUES (142,51,3,1);    -- ROAM_TURNS: 3
INSERT INTO `mob_family_mods` VALUES (142,52,30,1);   -- ROAM_RATE: 30

-- Hound
INSERT INTO `mob_family_mods` VALUES (143,36,50,1);   -- ROAM_COOL: 50
INSERT INTO `mob_family_mods` VALUES (143,51,3,1);    -- ROAM_TURNS: 3
INSERT INTO `mob_family_mods` VALUES (143,52,30,1);   -- ROAM_RATE: 30

-- Humanoid-Hume
INSERT INTO `mob_family_mods` VALUES (150,4,30,1); -- SIGHT_RANGE: 30

-- Hybridelemental-Air
INSERT INTO `mob_family_mods` VALUES (155,51,3,1); -- ROAM_TURNS: 3

-- Hybridelemental-Dark
INSERT INTO `mob_family_mods` VALUES (156,51,3,1); -- ROAM_TURNS: 3

-- Hybridelemental-Earth
INSERT INTO `mob_family_mods` VALUES (157,51,3,1); -- ROAM_TURNS: 3

-- Hybridelemental-Fire
INSERT INTO `mob_family_mods` VALUES (158,51,3,1); -- ROAM_TURNS: 3

-- Hybridelemental-Ice
INSERT INTO `mob_family_mods` VALUES (159,51,3,1); -- ROAM_TURNS: 3

-- Hybridelemental-Light
INSERT INTO `mob_family_mods` VALUES (160,51,3,1); -- ROAM_TURNS: 3

-- Hybridelemental-Lightning
INSERT INTO `mob_family_mods` VALUES (161,51,3,1); -- ROAM_TURNS: 3

-- Hybridelemental-Water
INSERT INTO `mob_family_mods` VALUES (162,51,3,1); -- ROAM_TURNS: 3

-- Hydra
INSERT INTO `mob_family_mods` VALUES (163,31,5,1);  -- ROAM_DISTANCE: 5
INSERT INTO `mob_family_mods` VALUES (163,36,55,1); -- ROAM_COOL: 55

-- Hydra
INSERT INTO `mob_family_mods` VALUES (164,31,5,1);  -- ROAM_DISTANCE: 5
INSERT INTO `mob_family_mods` VALUES (164,36,55,1); -- ROAM_COOL: 55

-- Imp
INSERT INTO `mob_family_mods` VALUES (165,10,13,1); -- SUBLINK: 13
INSERT INTO `mob_family_mods` VALUES (165,29,24,0); -- MDEF: 24
INSERT INTO `mob_family_mods` VALUES (165,36,50,1); -- ROAM_COOL: 50
INSERT INTO `mob_family_mods` VALUES (165,51,3,1);  -- ROAM_TURNS: 3
INSERT INTO `mob_family_mods` VALUES (165,56,-1,1); -- HP_STANDBACK: -1
INSERT INTO `mob_family_mods` VALUES (165,4,10,1);  -- SIGHT_RANGE: 10
INSERT INTO `mob_family_mods` VALUES (165,5,5,1);   -- SOUND_RANGE: 5

-- Imp
INSERT INTO `mob_family_mods` VALUES (166,10,13,1); -- SUBLINK: 13
INSERT INTO `mob_family_mods` VALUES (166,36,50,1); -- ROAM_COOL: 50
INSERT INTO `mob_family_mods` VALUES (166,51,3,1);  -- ROAM_TURNS: 3
INSERT INTO `mob_family_mods` VALUES (166,56,-1,1); -- HP_STANDBACK: -1
INSERT INTO `mob_family_mods` VALUES (166,4,10,1);  -- SIGHT_RANGE: 10
INSERT INTO `mob_family_mods` VALUES (166,5,5,1);   -- SOUND_RANGE: 5

-- Kindred
INSERT INTO `mob_family_mods` VALUES (169,10,1,1);    -- SUBLINK: 1
INSERT INTO `mob_family_mods` VALUES (169,11,15,1);   -- LINK_RADIUS: 15
INSERT INTO `mob_family_mods` VALUES (169,29,25,0);   -- MDEF: 25
INSERT INTO `mob_family_mods` VALUES (169,31,15,1);   -- ROAM_DISTANCE: 15
INSERT INTO `mob_family_mods` VALUES (169,36,50,1);   -- ROAM_COOL: 50
INSERT INTO `mob_family_mods` VALUES (169,51,3,1);    -- ROAM_TURNS: 3
INSERT INTO `mob_family_mods` VALUES (169,54,120,1);  -- GIL_BONUS: 120
INSERT INTO `mob_family_mods` VALUES (169,389,-25,0); -- UDMGMAGIC: -25

-- Lamiae
INSERT INTO `mob_family_mods` VALUES (171,10,10,1);   -- SUBLINK: 10
INSERT INTO `mob_family_mods` VALUES (171,29,13,0);   -- MDEF: 13
INSERT INTO `mob_family_mods` VALUES (171,389,-13,0); -- UDMGMAGIC: -13

-- Leech
INSERT INTO `mob_family_mods` VALUES (172,31,15,1); -- ROAM_DISTANCE: 15

-- Lizard
INSERT INTO `mob_family_mods` VALUES (174,36,60,1); -- ROAM_COOL: 60
INSERT INTO `mob_family_mods` VALUES (174,51,4,1);  -- ROAM_TURNS: 4
INSERT INTO `mob_family_mods` VALUES (174,52,30,1); -- ROAM_RATE: 30

-- Magic Pot
INSERT INTO `mob_family_mods` VALUES (175,29,50,0);   -- MDEF: 50
INSERT INTO `mob_family_mods` VALUES (175,31,5,1);    -- ROAM_DISTANCE: 5
INSERT INTO `mob_family_mods` VALUES (175,36,55,1);   -- ROAM_COOL: 55
INSERT INTO `mob_family_mods` VALUES (175,52,30,1);   -- ROAM_RATE: 30
INSERT INTO `mob_family_mods` VALUES (175,389,-50,0); -- UDMGMAGIC: -50

-- Mamool Ja
INSERT INTO `mob_family_mods` VALUES (176,10,8,1);  -- SUBLINK: 8
INSERT INTO `mob_family_mods` VALUES (176,68,10,0); -- EVA: 10

-- Manticore
INSERT INTO `mob_family_mods` VALUES (179,31,30,1);  -- ROAM_DISTANCE: 30
INSERT INTO `mob_family_mods` VALUES (179,36,60,1);  -- ROAM_COOL: 60
INSERT INTO `mob_family_mods` VALUES (179,51,4,1);   -- ROAM_TURNS: 4
INSERT INTO `mob_family_mods` VALUES (179,52,30,1);  -- ROAM_RATE: 30
INSERT INTO `mob_family_mods` VALUES (179,62,10,0);  -- ATTP: 10

-- Marid
INSERT INTO `mob_family_mods` VALUES (180,36,30,1); -- ROAM_COOL: 30
INSERT INTO `mob_family_mods` VALUES (180,51,2,1);  -- ROAM_TURNS: 2
INSERT INTO `mob_family_mods` VALUES (180,52,30,1); -- ROAM_RATE: 30
INSERT INTO `mob_family_mods` VALUES (180,63,20,0); -- DEFP: 20

-- Merrow
INSERT INTO `mob_family_mods` VALUES (182,10,10,1); -- SUBLINK: 10

-- Moblin
INSERT INTO `mob_family_mods` VALUES (184,10,5,1); -- SUBLINK: 5

-- Morbol
INSERT INTO `mob_family_mods` VALUES (186,36,30,1); -- ROAM_COOL: 30
INSERT INTO `mob_family_mods` VALUES (186,52,30,1); -- ROAM_RATE: 30

-- Opo-Opo
INSERT INTO `mob_family_mods` VALUES (188,36,35,1); -- ROAM_COOL: 35
INSERT INTO `mob_family_mods` VALUES (188,51,3,1);  -- ROAM_TURNS: 3
INSERT INTO `mob_family_mods` VALUES (188,52,20,1); -- ROAM_RATE: 20

-- Orc
INSERT INTO `mob_family_mods` VALUES (189,10,2,1); -- SUBLINK: 2

-- Orc-Warmachine
INSERT INTO `mob_family_mods` VALUES (190,10,2,1);  -- SUBLINK: 2
INSERT INTO `mob_family_mods` VALUES (190,36,50,1); -- ROAM_COOL: 50
INSERT INTO `mob_family_mods` VALUES (190,52,30,1); -- ROAM_RATE: 30

-- Wyvern-Pet
INSERT INTO `mob_family_mods` VALUES (193,3,40,1); -- MP_BASE: 40

-- Phuabo
INSERT INTO `mob_family_mods` VALUES (194,3,50,1); -- MP_BASE: 50

-- Qiqirn
INSERT INTO `mob_family_mods` VALUES (199,10,12,1); -- SUBLINK: 12

-- Qutrub
INSERT INTO `mob_family_mods` VALUES (203,36,50,1);   -- ROAM_COOL: 50
INSERT INTO `mob_family_mods` VALUES (203,51,3,1);    -- ROAM_TURNS: 3
INSERT INTO `mob_family_mods` VALUES (203,52,30,1);   -- ROAM_RATE: 30

-- Qutrub
INSERT INTO `mob_family_mods` VALUES (204,36,50,1);   -- ROAM_COOL: 50
INSERT INTO `mob_family_mods` VALUES (204,51,3,1);    -- ROAM_TURNS: 3
INSERT INTO `mob_family_mods` VALUES (204,52,30,1);   -- ROAM_RATE: 30

-- Qutrub
INSERT INTO `mob_family_mods` VALUES (205,36,50,1);   -- ROAM_COOL: 50
INSERT INTO `mob_family_mods` VALUES (205,51,3,1);    -- ROAM_TURNS: 3
INSERT INTO `mob_family_mods` VALUES (205,52,30,1);   -- ROAM_RATE: 30

-- Rabbit
INSERT INTO `mob_family_mods` VALUES (206,31,15,1); -- ROAM_DISTANCE: 15
INSERT INTO `mob_family_mods` VALUES (206,36,35,1); -- ROAM_COOL: 35
INSERT INTO `mob_family_mods` VALUES (206,51,3,1);  -- ROAM_TURNS: 3
INSERT INTO `mob_family_mods` VALUES (206,52,30,1); -- ROAM_RATE: 30

-- Rafflesia
INSERT INTO `mob_family_mods` VALUES (207,3,50,1); -- MP_BASE: 50

-- Ram
INSERT INTO `mob_family_mods` VALUES (208,36,60,1);  -- ROAM_COOL: 60
INSERT INTO `mob_family_mods` VALUES (208,52,30,1);  -- ROAM_RATE: 30
INSERT INTO `mob_family_mods` VALUES (208,62,10,0);  -- ATTP: 10
INSERT INTO `mob_family_mods` VALUES (208,63,20,0);  -- DEFP: 20

-- Raptor
INSERT INTO `mob_family_mods` VALUES (210,31,30,1);  -- ROAM_DISTANCE: 30
INSERT INTO `mob_family_mods` VALUES (210,36,40,1);  -- ROAM_COOL: 40
INSERT INTO `mob_family_mods` VALUES (210,51,3,1);   -- ROAM_TURNS: 3

-- Sabotender
INSERT INTO `mob_family_mods` VALUES (212,10,7,1);  -- SUBLINK: 7
INSERT INTO `mob_family_mods` VALUES (212,36,10,1); -- ROAM_COOL: 10
INSERT INTO `mob_family_mods` VALUES (212,52,20,1); -- ROAM_RATE: 20

-- Sahagin
INSERT INTO `mob_family_mods` VALUES (213,10,8,1);   -- SUBLINK: 8
INSERT INTO `mob_family_mods` VALUES (213,20,128,0); -- WATER_RES: 128

-- Sapling
INSERT INTO `mob_family_mods` VALUES (216,10,4,1);  -- SUBLINK: 4
INSERT INTO `mob_family_mods` VALUES (216,31,20,1); -- ROAM_DISTANCE: 20

-- Scorpion
INSERT INTO `mob_family_mods` VALUES (217,23,256,1); -- IMMUNITY: 256
INSERT INTO `mob_family_mods` VALUES (217,36,55,1);  -- ROAM_COOL: 55
INSERT INTO `mob_family_mods` VALUES (217,52,30,1);  -- ROAM_RATE: 30
INSERT INTO `mob_family_mods` VALUES (217,62,20,0);  -- ATTP: 20

-- Sea Monk
INSERT INTO `mob_family_mods` VALUES (218,36,30,1); -- ROAM_COOL: 30

-- Sea Monk
INSERT INTO `mob_family_mods` VALUES (219,36,30,1); -- ROAM_COOL: 30

-- Shadow
INSERT INTO `mob_family_mods` VALUES (221,36,50,1);   -- ROAM_COOL: 50
INSERT INTO `mob_family_mods` VALUES (221,51,2,1);    -- ROAM_TURNS: 2
INSERT INTO `mob_family_mods` VALUES (221,52,30,1);   -- ROAM_RATE: 30

-- Shadow
INSERT INTO `mob_family_mods` VALUES (222,36,50,1);   -- ROAM_COOL: 50
INSERT INTO `mob_family_mods` VALUES (222,51,2,1);    -- ROAM_TURNS: 2
INSERT INTO `mob_family_mods` VALUES (222,52,30,1);   -- ROAM_RATE: 30

-- Shadow
INSERT INTO `mob_family_mods` VALUES (223,36,50,1);   -- ROAM_COOL: 50
INSERT INTO `mob_family_mods` VALUES (223,51,2,1);    -- ROAM_TURNS: 2
INSERT INTO `mob_family_mods` VALUES (223,52,30,1);   -- ROAM_RATE: 30

-- Sheep
INSERT INTO `mob_family_mods` VALUES (226,31,15,1); -- ROAM_DISTANCE: 15
INSERT INTO `mob_family_mods` VALUES (226,36,60,1); -- ROAM_COOL: 60
INSERT INTO `mob_family_mods` VALUES (226,51,5,1);  -- ROAM_TURNS: 5
INSERT INTO `mob_family_mods` VALUES (226,52,30,1); -- ROAM_RATE: 30

-- Skeleton
INSERT INTO `mob_family_mods` VALUES (227,36,65,1);   -- ROAM_COOL: 65
INSERT INTO `mob_family_mods` VALUES (227,51,5,1);    -- ROAM_TURNS: 5
INSERT INTO `mob_family_mods` VALUES (227,52,30,1);   -- ROAM_RATE: 30

-- Snoll
INSERT INTO `mob_family_mods` VALUES (232,36,40,1); -- ROAM_COOL: 40
INSERT INTO `mob_family_mods` VALUES (232,51,2,1);  -- ROAM_TURNS: 2
INSERT INTO `mob_family_mods` VALUES (232,52,20,1); -- ROAM_RATE: 20

-- Soulflayer
INSERT INTO `mob_family_mods` VALUES (233,10,11,1); -- SUBLINK: 11
INSERT INTO `mob_family_mods` VALUES (233,36,50,1); -- ROAM_COOL: 50
INSERT INTO `mob_family_mods` VALUES (233,51,3,1);  -- ROAM_TURNS: 3

-- Spheroid
INSERT INTO `mob_family_mods` VALUES (234,37,1,1); -- ALWAYS_AGGRO: 1

-- Structure
INSERT INTO `mob_family_mods` VALUES (236,4,30,1); -- SIGHT_RANGE: 30

-- Tauri
INSERT INTO `mob_family_mods` VALUES (240,10,1,1);   -- SUBLINK: 1
INSERT INTO `mob_family_mods` VALUES (240,36,40,1);  -- ROAM_COOL: 40
INSERT INTO `mob_family_mods` VALUES (240,51,3,1);   -- ROAM_TURNS: 3
INSERT INTO `mob_family_mods` VALUES (240,52,30,1);  -- ROAM_RATE: 30

-- Tiger
INSERT INTO `mob_family_mods` VALUES (242,31,15,1);  -- ROAM_DISTANCE: 15
INSERT INTO `mob_family_mods` VALUES (242,36,45,1);  -- ROAM_COOL: 45
INSERT INTO `mob_family_mods` VALUES (242,51,3,1);   -- ROAM_TURNS: 3
INSERT INTO `mob_family_mods` VALUES (242,62,10,0);  -- ATTP: 10

-- Tonberry
INSERT INTO `mob_family_mods` VALUES (243,36,25,1); -- ROAM_COOL: 25
INSERT INTO `mob_family_mods` VALUES (243,51,5,1);  -- ROAM_TURNS: 5
INSERT INTO `mob_family_mods` VALUES (243,52,30,1); -- ROAM_RATE: 30

-- Tonberry
INSERT INTO `mob_family_mods` VALUES (244,36,25,1); -- ROAM_COOL: 25
INSERT INTO `mob_family_mods` VALUES (244,51,5,1);  -- ROAM_TURNS: 5
INSERT INTO `mob_family_mods` VALUES (244,52,30,1); -- ROAM_RATE: 30

-- Treant
INSERT INTO `mob_family_mods` VALUES (245,10,4,1);  -- SUBLINK: 4
INSERT INTO `mob_family_mods` VALUES (245,36,65,1); -- ROAM_COOL: 65
INSERT INTO `mob_family_mods` VALUES (245,52,30,1); -- ROAM_RATE: 30
INSERT INTO `mob_family_mods` VALUES (245,63,20,0); -- DEFP: 20

-- Troll
INSERT INTO `mob_family_mods` VALUES (246,10,9,1); -- SUBLINK: 9

-- Uragnite
INSERT INTO `mob_family_mods` VALUES (251,36,40,1); -- ROAM_COOL: 40
INSERT INTO `mob_family_mods` VALUES (251,52,30,1); -- ROAM_RATE: 30

-- Vampyr
INSERT INTO `mob_family_mods` VALUES (252,10,3,1);  -- SUBLINK: 3
INSERT INTO `mob_family_mods` VALUES (252,36,50,1); -- ROAM_COOL: 50
INSERT INTO `mob_family_mods` VALUES (252,51,2,1);  -- ROAM_TURNS: 2
INSERT INTO `mob_family_mods` VALUES (252,52,30,1); -- ROAM_RATE: 30

-- Wamoura
INSERT INTO `mob_family_mods` VALUES (253,3,50,1); -- MP_BASE: 50
INSERT INTO `mob_family_mods` VALUES (253,10,6,1); -- SUBLINK: 6

-- Wamouracampa
INSERT INTO `mob_family_mods` VALUES (254,10,6,1); -- SUBLINK: 6

-- Wanderer
INSERT INTO `mob_family_mods` VALUES (255,3,50,1); -- MP_BASE: 50

-- Wivre
INSERT INTO `mob_family_mods` VALUES (257,36,50,1); -- ROAM_COOL: 50
INSERT INTO `mob_family_mods` VALUES (257,52,30,1); -- ROAM_RATE: 30

-- Worm
INSERT INTO `mob_family_mods` VALUES (258,34,25,1); -- MAGIC_COOL: 25
INSERT INTO `mob_family_mods` VALUES (258,36,90,1); -- ROAM_COOL: 90
INSERT INTO `mob_family_mods` VALUES (258,52,30,1); -- ROAM_RATE: 30

-- Wyrm-Ouryu
INSERT INTO `mob_family_mods` VALUES (259,36,55,1);  -- ROAM_COOL: 55

-- Wyrm-Fafnir
INSERT INTO `mob_family_mods` VALUES (260,36,55,1);  -- ROAM_COOL: 55

-- Wyrm-Cynoprosopi
INSERT INTO `mob_family_mods` VALUES (261,36,55,1);  -- ROAM_COOL: 55

-- Wyrm
INSERT INTO `mob_family_mods` VALUES (262,36,55,1);  -- ROAM_COOL: 55

-- Wyrm-Nidhogg
INSERT INTO `mob_family_mods` VALUES (263,36,55,1);  -- ROAM_COOL: 55

-- Wyrm
INSERT INTO `mob_family_mods` VALUES (264,36,55,1);  -- ROAM_COOL: 55

-- Wyvern-Simorg
INSERT INTO `mob_family_mods` VALUES (265,36,55,1);  -- ROAM_COOL: 55

-- Wyvern
INSERT INTO `mob_family_mods` VALUES (266,36,55,1);  -- ROAM_COOL: 55

-- Wyvern-Guivre
INSERT INTO `mob_family_mods` VALUES (267,4,20,1);   -- SIGHT_RANGE: 20
INSERT INTO `mob_family_mods` VALUES (267,36,55,1);  -- ROAM_COOL: 55

-- Wyvern-Undead
INSERT INTO `mob_family_mods` VALUES (268,36,55,1);  -- ROAM_COOL: 55

-- Yovra
INSERT INTO `mob_family_mods` VALUES (271,3,50,1); -- MP_BASE: 50

-- Zdei
INSERT INTO `mob_family_mods` VALUES (272,4,10,1);    -- SIGHT_RANGE: 10
INSERT INTO `mob_family_mods` VALUES (272,102,60,1);  -- MOBMOD_SIGHT_ANGLE

-- Scorpion-Serket
INSERT INTO `mob_family_mods` VALUES (273,23,256,1); -- IMMUNITY: 256

-- Scorpion-Kingv
INSERT INTO `mob_family_mods` VALUES (274,23,256,1); -- IMMUNITY: 256

-- Mamool Ja
INSERT INTO `mob_family_mods` VALUES (285,10,8,1);  -- SUBLINK: 8
INSERT INTO `mob_family_mods` VALUES (285,68,10,0); -- EVA: 10

-- Qiqirn-Cheese Hoarder
INSERT INTO `mob_family_mods` VALUES (288,10,12,1); -- SUBLINK: 12

-- Wamouracampa-Brassborer
INSERT INTO `mob_family_mods` VALUES (289,10,6,1); -- SUBLINK: 6

-- Apkallu-Small
INSERT INTO `mob_family_mods` VALUES (294,10,14,1); -- SUBLINK: 14

-- Imp-Verdelet
INSERT INTO `mob_family_mods` VALUES (301,10,13,1); -- SUBLINK: 13

-- Wamoura-Achamoth
INSERT INTO `mob_family_mods` VALUES (307,10,6,1); -- SUBLINK: 6

-- Troll-Khromasoul
INSERT INTO `mob_family_mods` VALUES (308,10,9,1); -- SUBLINK: 9

-- Experimentalla
INSERT INTO `mob_family_mods` VALUES (310,10,10,1); -- SUBLINK: 10

-- Soulflayer-Mahjlaefthepai
INSERT INTO `mob_family_mods` VALUES (311,10,11,1); -- SUBLINK: 11

-- Troll-Gurfurlur
INSERT INTO `mob_family_mods` VALUES (326,10,9,1); -- SUBLINK: 9

-- Gigas
INSERT INTO `mob_family_mods` VALUES (328,31,5,1);   -- ROAM_DISTANCE: 5
INSERT INTO `mob_family_mods` VALUES (328,36,25,1);  -- ROAM_COOL: 25
INSERT INTO `mob_family_mods` VALUES (328,51,2,1);   -- ROAM_TURNS: 2
INSERT INTO `mob_family_mods` VALUES (328,52,30,1);  -- ROAM_RATE: 30
INSERT INTO `mob_family_mods` VALUES (328,54,180,1); -- GIL_BONUS: 180

-- Orc-Nm
INSERT INTO `mob_family_mods` VALUES (334,10,2,1); -- SUBLINK: 2

-- Antlion-Ambush
INSERT INTO `mob_family_mods` VALUES (357,63,20,0); -- DEFP: 20

-- Kindred
INSERT INTO `mob_family_mods` VALUES (358,10,1,1);    -- SUBLINK: 1
INSERT INTO `mob_family_mods` VALUES (358,11,15,1);   -- LINK_RADIUS: 15
INSERT INTO `mob_family_mods` VALUES (358,31,15,1);   -- ROAM_DISTANCE: 15
INSERT INTO `mob_family_mods` VALUES (358,36,50,1);   -- ROAM_COOL: 50
INSERT INTO `mob_family_mods` VALUES (358,51,3,1);    -- ROAM_TURNS: 3
INSERT INTO `mob_family_mods` VALUES (358,54,120,1);  -- GIL_BONUS: 120
INSERT INTO `mob_family_mods` VALUES (358,389,-25,0); -- UDMGMAGIC: -25

-- Fomor
INSERT INTO `mob_family_mods` VALUES (359,36,50,1);   -- ROAM_COOL: 50
INSERT INTO `mob_family_mods` VALUES (359,51,2,1);    -- ROAM_TURNS: 2
INSERT INTO `mob_family_mods` VALUES (359,52,30,1);   -- ROAM_RATE: 30
INSERT INTO `mob_family_mods` VALUES (359,54,100,1);  -- GIL_BONUS: 100

-- Sabotender-Florido
INSERT INTO `mob_family_mods` VALUES (362,10,7,1); -- SUBLINK: 7

-- Doll-Faust
INSERT INTO `mob_family_mods` VALUES (367,31,5,1);  -- ROAM_DISTANCE: 5
INSERT INTO `mob_family_mods` VALUES (367,36,55,1); -- ROAM_COOL: 55
INSERT INTO `mob_family_mods` VALUES (367,52,30,1); -- ROAM_RATE: 30

-- Doll-Despot
INSERT INTO `mob_family_mods` VALUES (368,31,5,1);  -- ROAM_DISTANCE: 5
INSERT INTO `mob_family_mods` VALUES (368,36,55,1); -- ROAM_COOL: 55
INSERT INTO `mob_family_mods` VALUES (368,52,30,1); -- ROAM_RATE: 30

-- Leech
INSERT INTO `mob_family_mods` VALUES (369,31,15,1); -- ROAM_DISTANCE: 15

-- Crab
INSERT INTO `mob_family_mods` VALUES (372,36,15,1); -- ROAM_COOL: 15

-- Raptor
INSERT INTO `mob_family_mods` VALUES (376,31,30,1); -- ROAM_DISTANCE: 30
INSERT INTO `mob_family_mods` VALUES (376,36,40,1); -- ROAM_COOL: 40
INSERT INTO `mob_family_mods` VALUES (376,51,3,1);  -- ROAM_TURNS: 3

-- Raptor
INSERT INTO `mob_family_mods` VALUES (377,31,30,1); -- ROAM_DISTANCE: 30
INSERT INTO `mob_family_mods` VALUES (377,36,40,1); -- ROAM_COOL: 40
INSERT INTO `mob_family_mods` VALUES (377,51,3,1);  -- ROAM_TURNS: 3

-- Humanoid-Hume
INSERT INTO `mob_family_mods` VALUES (394,4,30,1);   -- SIGHT_RANGE: 30
INSERT INTO `mob_family_mods` VALUES (394,41,988,1); -- TELEPORT_START: 988
INSERT INTO `mob_family_mods` VALUES (394,42,989,1); -- TELEPORT_END: 989
INSERT INTO `mob_family_mods` VALUES (394,43,2,1);   -- TELEPORT_TYPE: 2

-- Rabbit-Cure
INSERT INTO `mob_family_mods` VALUES (404,31,15,1); -- ROAM_DISTANCE: 15
INSERT INTO `mob_family_mods` VALUES (404,36,35,1); -- ROAM_COOL: 35
INSERT INTO `mob_family_mods` VALUES (404,51,3,1);  -- ROAM_TURNS: 3
INSERT INTO `mob_family_mods` VALUES (404,52,30,1); -- ROAM_RATE: 30

-- Lamiae-Medusa
INSERT INTO `mob_family_mods` VALUES (469,10,10,1); -- SUBLINK: 10

-- Behemoth-Kb
INSERT INTO `mob_family_mods` VALUES (479,36,50,1); -- ROAM_COOL: 50

-- Ajido-Marujido
INSERT INTO `mob_family_mods` VALUES (481,41,988,1); -- TELEPORT_START: 988
INSERT INTO `mob_family_mods` VALUES (481,42,989,1); -- TELEPORT_END: 989

-- Astral Flow Pet
INSERT INTO `mob_family_mods` VALUES (495,56,-1,1); -- HP_STANDBACK: -1

-- Apkallu
INSERT INTO `mob_family_mods` VALUES (27,4,5,1); -- SIGHT_RANGE: 5

-- Flan
INSERT INTO `mob_family_mods` VALUES (112,56,-1,1); -- HP_STANDBACK: -1
INSERT INTO `mob_family_mods` VALUES (112,69,1,1);  -- NO_LINK: 1

/*!40000 ALTER TABLE `mob_family_mods` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
