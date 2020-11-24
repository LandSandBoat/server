-- MySQL dump 10.13  Distrib 5.6.13, for Win64 (x86_64)
--
-- Host: localhost    Database: tpzdb
-- ------------------------------------------------------
-- Server version   5.6.13-log

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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=13 PACK_KEYS=1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mob_pool_mods`
--

LOCK TABLES `mob_pool_mods` WRITE;
/*!40000 ALTER TABLE `mob_pool_mods` DISABLE KEYS */;

INSERT INTO `mob_pool_mods` VALUES (21,29,100,0);
INSERT INTO `mob_pool_mods` VALUES (44,368,150,0);
INSERT INTO `mob_pool_mods` VALUES (60,370,20,0);
INSERT INTO `mob_pool_mods` VALUES (70,48,434,1);
INSERT INTO `mob_pool_mods` VALUES (154,163,-70,0);
INSERT INTO `mob_pool_mods` VALUES (181,1,6000,1); -- (Antican_Praetor) GIL_MIN
INSERT INTO `mob_pool_mods` VALUES (181,2,9234,1); -- (Antican_Praetor) GIL_MAX
INSERT INTO `mob_pool_mods` VALUES (236,30,732,1);
INSERT INTO `mob_pool_mods` VALUES (236,33,60,1);
INSERT INTO `mob_pool_mods` VALUES (237,44,1,1);
INSERT INTO `mob_pool_mods` VALUES (242,40,30,1);
INSERT INTO `mob_pool_mods` VALUES (242,41,936,1);
INSERT INTO `mob_pool_mods` VALUES (242,42,962,1);
INSERT INTO `mob_pool_mods` VALUES (242,43,1,1);
INSERT INTO `mob_pool_mods` VALUES (242,47,22,1);
INSERT INTO `mob_pool_mods` VALUES (268,368,150,0);
INSERT INTO `mob_pool_mods` VALUES (268,370,50,0);
INSERT INTO `mob_pool_mods` VALUES (276,12,1,1);
INSERT INTO `mob_pool_mods` VALUES (289,4,4,1);
INSERT INTO `mob_pool_mods` VALUES (370,28,5,1);
INSERT INTO `mob_pool_mods` VALUES (410,236,20,0);
INSERT INTO `mob_pool_mods` VALUES (444,23,23,1); -- Bladmall immune to Sleep, Bind, Silence and Gravity.
INSERT INTO `mob_pool_mods` VALUES (459,23,50,0); -- (Bloodlapper) Attack
INSERT INTO `mob_pool_mods` VALUES (459,73,25,0); -- (Bloodlapper) Store TP
INSERT INTO `mob_pool_mods` VALUES (459,430,20,0); -- (Bloodlapper) Quad Attack
INSERT INTO `mob_pool_mods` VALUES (519,160,-50,0);
INSERT INTO `mob_pool_mods` VALUES (532,160,-50,0);
INSERT INTO `mob_pool_mods` VALUES (592,68,15,0);
INSERT INTO `mob_pool_mods` VALUES (592,302,45,0);
INSERT INTO `mob_pool_mods` VALUES (592,3,100,1);
INSERT INTO `mob_pool_mods` VALUES (639,63,25,0);
INSERT INTO `mob_pool_mods` VALUES (676,160,-50,0);
INSERT INTO `mob_pool_mods` VALUES (680,1,322,0); -- (Cerberus) 650 defense total
INSERT INTO `mob_pool_mods` VALUES (680,31,200,0); -- (Cerberus) 120 magic evasion boost recommended but 200 felt more retail
INSERT INTO `mob_pool_mods` VALUES (680,251,-50,0); -- (Cerberus) he shouldn't be so resistant to stun, tho this is a systemic stun problem, this is a hack
INSERT INTO `mob_pool_mods` VALUES (681,368,10,0);
INSERT INTO `mob_pool_mods` VALUES (733,302,5,0);
INSERT INTO `mob_pool_mods` VALUES (768,28,5,1);
INSERT INTO `mob_pool_mods` VALUES (770,4,4,1);
INSERT INTO `mob_pool_mods` VALUES (820,368,10,0);
INSERT INTO `mob_pool_mods` VALUES (906,4,4,1);
INSERT INTO `mob_pool_mods` VALUES (912,12,25,1);
INSERT INTO `mob_pool_mods` VALUES (930,370,15,0);
INSERT INTO `mob_pool_mods` VALUES (955,28,-100,1); -- Defender EXP_BONUS: don't give XP
INSERT INTO `mob_pool_mods` VALUES (958,28,5,1);
INSERT INTO `mob_pool_mods` VALUES (978,28,23,1);
INSERT INTO `mob_pool_mods` VALUES (979,8,60,1);
INSERT INTO `mob_pool_mods` VALUES (979,9,60,1);
INSERT INTO `mob_pool_mods` VALUES (1013,28,-100,1); -- Detector EXP_BONUS: don't give XP
INSERT INTO `mob_pool_mods` VALUES (1027,12,1,1);
INSERT INTO `mob_pool_mods` VALUES (1178,163,-100,0);
INSERT INTO `mob_pool_mods` VALUES (1234,4,4,1);
INSERT INTO `mob_pool_mods` VALUES (1270,39,-1,1);
INSERT INTO `mob_pool_mods` VALUES (1280,368,70,0);
INSERT INTO `mob_pool_mods` VALUES (1306,4,30,1);
INSERT INTO `mob_pool_mods` VALUES (1429,28,10,1);
INSERT INTO `mob_pool_mods` VALUES (1456,368,20,0);
INSERT INTO `mob_pool_mods` VALUES (1461,4,4,1);
INSERT INTO `mob_pool_mods` VALUES (1491,3,100,1);
INSERT INTO `mob_pool_mods` VALUES (1648,224,5,0);
INSERT INTO `mob_pool_mods` VALUES (1648,17,1,1);
INSERT INTO `mob_pool_mods` VALUES (1663,29,3,1);
INSERT INTO `mob_pool_mods` VALUES (1719,29,2,1);
INSERT INTO `mob_pool_mods` VALUES (1750,56,1,1);
INSERT INTO `mob_pool_mods` VALUES (1754,4,4,1);
INSERT INTO `mob_pool_mods` VALUES (1792,368,70,0);
INSERT INTO `mob_pool_mods` VALUES (1806,28,10,1);
INSERT INTO `mob_pool_mods` VALUES (1841,28,10,1);
INSERT INTO `mob_pool_mods` VALUES (2032,244,15,0);
INSERT INTO `mob_pool_mods` VALUES (2032,34,20,1);
INSERT INTO `mob_pool_mods` VALUES (2032,35,0,1);
INSERT INTO `mob_pool_mods` VALUES (2047,163,-100,0);
INSERT INTO `mob_pool_mods` VALUES (2083,29,25,0);
INSERT INTO `mob_pool_mods` VALUES (2105,48,434,1);
INSERT INTO `mob_pool_mods` VALUES (2156,370,25,0);
INSERT INTO `mob_pool_mods` VALUES (2180,3,100,1);
INSERT INTO `mob_pool_mods` VALUES (2254,407,100,0);
INSERT INTO `mob_pool_mods` VALUES (2255,368,70,0);
INSERT INTO `mob_pool_mods` VALUES (2255,3,100,1);
INSERT INTO `mob_pool_mods` VALUES (2255,34,60,1);
INSERT INTO `mob_pool_mods` VALUES (2262,370,125,0);
INSERT INTO `mob_pool_mods` VALUES (2265,368,150,0);
INSERT INTO `mob_pool_mods` VALUES (2265,370,50,0);
INSERT INTO `mob_pool_mods` VALUES (2271,64,15,0);
INSERT INTO `mob_pool_mods` VALUES (2271,65,15,0);
INSERT INTO `mob_pool_mods` VALUES (2271,165,15,0);
INSERT INTO `mob_pool_mods` VALUES (2314,28,23,1);
INSERT INTO `mob_pool_mods` VALUES (2420,302,10,0);
INSERT INTO `mob_pool_mods` VALUES (2461,61,25,1);
INSERT INTO `mob_pool_mods` VALUES (2462,61,25,1);
INSERT INTO `mob_pool_mods` VALUES (2463,61,20,1);
INSERT INTO `mob_pool_mods` VALUES (2614,368,100,0); -- Memory Receptacle regain 10%
INSERT INTO `mob_pool_mods` VALUES (2643,160,-50,0);
INSERT INTO `mob_pool_mods` VALUES (2647,160,-50,0);
INSERT INTO `mob_pool_mods` VALUES (2664,12,1,1);
INSERT INTO `mob_pool_mods` VALUES (2675,4,25,1);
INSERT INTO `mob_pool_mods` VALUES (2677,288,55,0);
INSERT INTO `mob_pool_mods` VALUES (2742,37,1,1);
INSERT INTO `mob_pool_mods` VALUES (2745,28,23,1);
INSERT INTO `mob_pool_mods` VALUES (2748,370,5,0);
INSERT INTO `mob_pool_mods` VALUES (2790,168,50,0);
INSERT INTO `mob_pool_mods` VALUES (2790,240,7,0);
INSERT INTO `mob_pool_mods` VALUES (2790,244,7,0);
INSERT INTO `mob_pool_mods` VALUES (2793,4,4,1);
INSERT INTO `mob_pool_mods` VALUES (2840,368,70,0);
INSERT INTO `mob_pool_mods` VALUES (2840,370,50,0);
INSERT INTO `mob_pool_mods` VALUES (2922,370,100,0);
INSERT INTO `mob_pool_mods` VALUES (2973,370,1,0);
INSERT INTO `mob_pool_mods` VALUES (3051,4,4,1);
INSERT INTO `mob_pool_mods` VALUES (3099,23,23,1); -- Parata immune to Sleep, Bind, Silence and Gravity.
INSERT INTO `mob_pool_mods` VALUES (3124,48,434,1);
INSERT INTO `mob_pool_mods` VALUES (3129,370,50,0);
INSERT INTO `mob_pool_mods` VALUES (3168,28,10,1);
INSERT INTO `mob_pool_mods` VALUES (3208,370,20,0);
INSERT INTO `mob_pool_mods` VALUES (3245,56,1,1);
INSERT INTO `mob_pool_mods` VALUES (3252,56,1,1);
INSERT INTO `mob_pool_mods` VALUES (3257,56,1,1);
INSERT INTO `mob_pool_mods` VALUES (3262,56,1,1);
INSERT INTO `mob_pool_mods` VALUES (3264,56,1,1);
INSERT INTO `mob_pool_mods` VALUES (3265,56,1,1);
INSERT INTO `mob_pool_mods` VALUES (3268,56,1,1);
INSERT INTO `mob_pool_mods` VALUES (3301,29,100,0); -- (Race Runner) MDEF
INSERT INTO `mob_pool_mods` VALUES (3379,4,4,1);
INSERT INTO `mob_pool_mods` VALUES (3540,3,100,1);
INSERT INTO `mob_pool_mods` VALUES (3549,370,50,0);
INSERT INTO `mob_pool_mods` VALUES (3598,368,70,0);
INSERT INTO `mob_pool_mods` VALUES (3600,368,70,0);
INSERT INTO `mob_pool_mods` VALUES (3601,368,70,0);
INSERT INTO `mob_pool_mods` VALUES (3667,28,-100,1);
INSERT INTO `mob_pool_mods` VALUES (3759,163,-100,0);
INSERT INTO `mob_pool_mods` VALUES (3781,4,4,1);
INSERT INTO `mob_pool_mods` VALUES (3784,2,-1,1); -- Stray GIL_MAX: don't drop gil
INSERT INTO `mob_pool_mods` VALUES (3784,28,-100,1); -- Stray EXP_BONUS: don't give XP
INSERT INTO `mob_pool_mods` VALUES (3796,21,97,1);
INSERT INTO `mob_pool_mods` VALUES (3816,3,100,1);
INSERT INTO `mob_pool_mods` VALUES (3824,29,2,1);
INSERT INTO `mob_pool_mods` VALUES (3853,28,23,1);
INSERT INTO `mob_pool_mods` VALUES (3916,29,50,0);
INSERT INTO `mob_pool_mods` VALUES (3916,164,-50,0);
INSERT INTO `mob_pool_mods` VALUES (3916,370,25,0);
INSERT INTO `mob_pool_mods` VALUES (3941,163,-100,0);
INSERT INTO `mob_pool_mods` VALUES (4046,23,6191,1);
INSERT INTO `mob_pool_mods` VALUES (4082,4,4,1);
INSERT INTO `mob_pool_mods` VALUES (4083,370,1,0);
INSERT INTO `mob_pool_mods` VALUES (4186,244,15,0);
INSERT INTO `mob_pool_mods` VALUES (4186,34,20,1);
INSERT INTO `mob_pool_mods` VALUES (4186,35,0,1);
INSERT INTO `mob_pool_mods` VALUES (4187,244,15,0);
INSERT INTO `mob_pool_mods` VALUES (4187,34,20,1);
INSERT INTO `mob_pool_mods` VALUES (4187,35,0,1);
INSERT INTO `mob_pool_mods` VALUES (4188,244,15,0);
INSERT INTO `mob_pool_mods` VALUES (4188,34,20,1);
INSERT INTO `mob_pool_mods` VALUES (4188,35,0,1);
INSERT INTO `mob_pool_mods` VALUES (4189,244,15,0);
INSERT INTO `mob_pool_mods` VALUES (4189,34,20,1);
INSERT INTO `mob_pool_mods` VALUES (4189,35,0,1);
INSERT INTO `mob_pool_mods` VALUES (4204,28,10,1); -- (Variable Hare) 10% XP bonus
INSERT INTO `mob_pool_mods` VALUES (4222,4,4,1);
INSERT INTO `mob_pool_mods` VALUES (4238,28,5,1); -- (Virulent Peiste) 5% XP bonus
INSERT INTO `mob_pool_mods` VALUES (4261,29,50,0);
INSERT INTO `mob_pool_mods` VALUES (4261,370,25,0);
INSERT INTO `mob_pool_mods` VALUES (4361,288,55,0);
INSERT INTO `mob_pool_mods` VALUES (4361,5,16,1);
INSERT INTO `mob_pool_mods` VALUES (4504,4,30,1);
INSERT INTO `mob_pool_mods` VALUES (4670,3,100,1);
INSERT INTO `mob_pool_mods` VALUES (4671,3,100,1);
INSERT INTO `mob_pool_mods` VALUES (4672,3,100,1);
INSERT INTO `mob_pool_mods` VALUES (4673,3,100,1);
INSERT INTO `mob_pool_mods` VALUES (4836,62,1,1); -- Maat (BLM) NO_STANDBACK
INSERT INTO `mob_pool_mods` VALUES (4837,62,1,1); -- Maat (RNG) NO_STANDBACK
INSERT INTO `mob_pool_mods` VALUES (4932,30,1017,1); -- Maat (BST) SPECIAL_SKILL: call_beast
INSERT INTO `mob_pool_mods` VALUES (4932,33,50,1); -- Maat (BST) SPECIAL_COOLDOWN: 50 sec
INSERT INTO `mob_pool_mods` VALUES (5403,62,1,1); -- Maat (NIN) NO_STANDBACK
INSERT INTO `mob_pool_mods` VALUES (5408,30,1036,1); -- Maat (PLD) SPECIAL_SKILL: maats_bash
INSERT INTO `mob_pool_mods` VALUES (5408,33,50,1); -- Maat (PLD) SPECIAL_COOLDOWN: 50 sec
INSERT INTO `mob_pool_mods` VALUES (5408,58,40,1); -- Maat (PLD) SPECIAL_DELAY: 40 sec
INSERT INTO `mob_pool_mods` VALUES (5409,30,1036,1); -- Maat (DRK) SPECIAL_SKILL: maats_bash
INSERT INTO `mob_pool_mods` VALUES (5409,33,50,1); -- Maat (DRK) SPECIAL_COOLDOWN: 50 sec
INSERT INTO `mob_pool_mods` VALUES (5409,58,40,1); -- Maat (DRK) SPECIAL_DELAY: 40 sec

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

-- Dump completed on 2013-09-20 13:54:52
