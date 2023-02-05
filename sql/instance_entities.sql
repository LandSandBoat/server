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
-- Table structure for table `instance_entities`
--

DROP TABLE IF EXISTS `instance_entities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instance_entities` (
  `instanceid` smallint(3) unsigned NOT NULL DEFAULT '0',
  `id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`instanceid`, `id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instance_entities`
--

LOCK TABLES `instance_entities` WRITE;
/*!40000 ALTER TABLE `instance_entities` DISABLE KEYS */;

-- Golden Salvage
-- mobs
INSERT INTO `instance_entities` VALUES (5500,17002497);
INSERT INTO `instance_entities` VALUES (5500,17002498);
INSERT INTO `instance_entities` VALUES (5500,17002499);
INSERT INTO `instance_entities` VALUES (5500,17002500);
INSERT INTO `instance_entities` VALUES (5500,17002501);
INSERT INTO `instance_entities` VALUES (5500,17002502);
INSERT INTO `instance_entities` VALUES (5500,17002503);
INSERT INTO `instance_entities` VALUES (5500,17002504);
INSERT INTO `instance_entities` VALUES (5500,17002505);
INSERT INTO `instance_entities` VALUES (5500,17002506);
INSERT INTO `instance_entities` VALUES (5500,17002507);
INSERT INTO `instance_entities` VALUES (5500,17002508);
INSERT INTO `instance_entities` VALUES (5500,17002509);
INSERT INTO `instance_entities` VALUES (5500,17002510);
INSERT INTO `instance_entities` VALUES (5500,17002511);
INSERT INTO `instance_entities` VALUES (5500,17002512);
INSERT INTO `instance_entities` VALUES (5500,17002513);
INSERT INTO `instance_entities` VALUES (5500,17002514);
INSERT INTO `instance_entities` VALUES (5500,17002515);
INSERT INTO `instance_entities` VALUES (5500,17002516);
-- npcs
INSERT INTO `instance_entities` VALUES (5500,17002654);
INSERT INTO `instance_entities` VALUES (5500,17002655);
INSERT INTO `instance_entities` VALUES (5500,17002720);
INSERT INTO `instance_entities` VALUES (5500,17002724);
INSERT INTO `instance_entities` VALUES (5500,17002725);
INSERT INTO `instance_entities` VALUES (5500,17002731);
INSERT INTO `instance_entities` VALUES (5500,17002732);
INSERT INTO `instance_entities` VALUES (5500,17002752);
INSERT INTO `instance_entities` VALUES (5500,17002753);

-- Lamia No. 13
-- mobs
INSERT INTO `instance_entities` VALUES (5501,17002517);
INSERT INTO `instance_entities` VALUES (5501,17002518);
INSERT INTO `instance_entities` VALUES (5501,17002519);
INSERT INTO `instance_entities` VALUES (5501,17002520);
-- npc
INSERT INTO `instance_entities` VALUES (5501,17002654);
INSERT INTO `instance_entities` VALUES (5501,17002655);
INSERT INTO `instance_entities` VALUES (5501,17002718);
INSERT INTO `instance_entities` VALUES (5501,17002719);
INSERT INTO `instance_entities` VALUES (5501,17002743);
INSERT INTO `instance_entities` VALUES (5501,17002744);

-- Extermination
-- mobs
INSERT INTO `instance_entities` VALUES (5502,17002521);
INSERT INTO `instance_entities` VALUES (5502,17002522);
INSERT INTO `instance_entities` VALUES (5502,17002523);
INSERT INTO `instance_entities` VALUES (5502,17002524);
INSERT INTO `instance_entities` VALUES (5502,17002525);
INSERT INTO `instance_entities` VALUES (5502,17002526);
INSERT INTO `instance_entities` VALUES (5502,17002527);
INSERT INTO `instance_entities` VALUES (5502,17002528);
INSERT INTO `instance_entities` VALUES (5502,17002529);
INSERT INTO `instance_entities` VALUES (5502,17002530);
INSERT INTO `instance_entities` VALUES (5502,17002531);
INSERT INTO `instance_entities` VALUES (5502,17002532);
INSERT INTO `instance_entities` VALUES (5502,17002533);
INSERT INTO `instance_entities` VALUES (5502,17002534);
INSERT INTO `instance_entities` VALUES (5502,17002535);
INSERT INTO `instance_entities` VALUES (5502,17002536);
INSERT INTO `instance_entities` VALUES (5502,17002537);
INSERT INTO `instance_entities` VALUES (5502,17002538);
INSERT INTO `instance_entities` VALUES (5502,17002539);
INSERT INTO `instance_entities` VALUES (5502,17002540);
INSERT INTO `instance_entities` VALUES (5502,17002541);
INSERT INTO `instance_entities` VALUES (5502,17002542);
INSERT INTO `instance_entities` VALUES (5502,17002543);
INSERT INTO `instance_entities` VALUES (5502,17002544);
-- npcs
INSERT INTO `instance_entities` VALUES (5502,17002654);
INSERT INTO `instance_entities` VALUES (5502,17002655);
INSERT INTO `instance_entities` VALUES (5502,17002718);
INSERT INTO `instance_entities` VALUES (5502,17002725);
INSERT INTO `instance_entities` VALUES (5502,17002730);
INSERT INTO `instance_entities` VALUES (5502,17002732);
INSERT INTO `instance_entities` VALUES (5502,17002733);
INSERT INTO `instance_entities` VALUES (5502,17002745);
INSERT INTO `instance_entities` VALUES (5502,17002747);
INSERT INTO `instance_entities` VALUES (5502,17002754);

-- Shades of Vengeance
-- mobs
INSERT INTO `instance_entities` VALUES (5600,17006754);
INSERT INTO `instance_entities` VALUES (5600,17006755);
INSERT INTO `instance_entities` VALUES (5600,17006756);
INSERT INTO `instance_entities` VALUES (5600,17006757);
INSERT INTO `instance_entities` VALUES (5600,17006758);
INSERT INTO `instance_entities` VALUES (5600,17006759);
INSERT INTO `instance_entities` VALUES (5600,17006760);
INSERT INTO `instance_entities` VALUES (5600,17006761);
INSERT INTO `instance_entities` VALUES (5600,17006762);
INSERT INTO `instance_entities` VALUES (5600,17006763);

-- Seagull Grounded
-- mobs
INSERT INTO `instance_entities` VALUES (5601,17006593);
INSERT INTO `instance_entities` VALUES (5601,17006594);
INSERT INTO `instance_entities` VALUES (5601,17006595);
INSERT INTO `instance_entities` VALUES (5601,17006596);
INSERT INTO `instance_entities` VALUES (5601,17006597);
INSERT INTO `instance_entities` VALUES (5601,17006598);
INSERT INTO `instance_entities` VALUES (5601,17006599);
INSERT INTO `instance_entities` VALUES (5601,17006600);
INSERT INTO `instance_entities` VALUES (5601,17006601);
INSERT INTO `instance_entities` VALUES (5601,17006602);
INSERT INTO `instance_entities` VALUES (5601,17006603);
INSERT INTO `instance_entities` VALUES (5601,17006604);
INSERT INTO `instance_entities` VALUES (5601,17006605);
INSERT INTO `instance_entities` VALUES (5601,17006606);
INSERT INTO `instance_entities` VALUES (5601,17006607);
INSERT INTO `instance_entities` VALUES (5601,17006608);
INSERT INTO `instance_entities` VALUES (5601,17006610);
INSERT INTO `instance_entities` VALUES (5601,17006611);
-- npcs
INSERT INTO `instance_entities` VALUES (5601,17006809);
INSERT INTO `instance_entities` VALUES (5601,17006810);
INSERT INTO `instance_entities` VALUES (5601,17006836);
INSERT INTO `instance_entities` VALUES (5601,17006841);
INSERT INTO `instance_entities` VALUES (5601,17006842);
INSERT INTO `instance_entities` VALUES (5601,17006843);
INSERT INTO `instance_entities` VALUES (5601,17006845);
INSERT INTO `instance_entities` VALUES (5601,17006846);
INSERT INTO `instance_entities` VALUES (5601,17006848);
INSERT INTO `instance_entities` VALUES (5601,17006852);
INSERT INTO `instance_entities` VALUES (5601,17006868);
INSERT INTO `instance_entities` VALUES (5601,17006870);
INSERT INTO `instance_entities` VALUES (5601,17006872);
INSERT INTO `instance_entities` VALUES (5601,17006874);
INSERT INTO `instance_entities` VALUES (5601,17006876);
INSERT INTO `instance_entities` VALUES (5601,17006878);

-- Requiem
-- mobs
INSERT INTO `instance_entities` VALUES (5602,17006612);
INSERT INTO `instance_entities` VALUES (5602,17006613);
INSERT INTO `instance_entities` VALUES (5602,17006614);
INSERT INTO `instance_entities` VALUES (5602,17006615);
INSERT INTO `instance_entities` VALUES (5602,17006616);
INSERT INTO `instance_entities` VALUES (5602,17006617);
INSERT INTO `instance_entities` VALUES (5602,17006618);
INSERT INTO `instance_entities` VALUES (5602,17006619);
INSERT INTO `instance_entities` VALUES (5602,17006620);
INSERT INTO `instance_entities` VALUES (5602,17006621);
INSERT INTO `instance_entities` VALUES (5602,17006622);
INSERT INTO `instance_entities` VALUES (5602,17006623);
INSERT INTO `instance_entities` VALUES (5602,17006624);
INSERT INTO `instance_entities` VALUES (5602,17006625);
INSERT INTO `instance_entities` VALUES (5602,17006626);
INSERT INTO `instance_entities` VALUES (5602,17006627);
INSERT INTO `instance_entities` VALUES (5602,17006628);
INSERT INTO `instance_entities` VALUES (5602,17006629);
INSERT INTO `instance_entities` VALUES (5602,17006630);
INSERT INTO `instance_entities` VALUES (5602,17006631);
INSERT INTO `instance_entities` VALUES (5602,17006632);
INSERT INTO `instance_entities` VALUES (5602,17006633);
INSERT INTO `instance_entities` VALUES (5602,17006634);
-- npcs
INSERT INTO `instance_entities` VALUES (5602,17006809);
INSERT INTO `instance_entities` VALUES (5602,17006810);
INSERT INTO `instance_entities` VALUES (5602,17006856);
INSERT INTO `instance_entities` VALUES (5602,17006868);
INSERT INTO `instance_entities` VALUES (5602,17006880);
INSERT INTO `instance_entities` VALUES (5602,17006881);
INSERT INTO `instance_entities` VALUES (5602,17006882);
INSERT INTO `instance_entities` VALUES (5602,17006892);
-- The Black Coffin
-- mobs
INSERT INTO `instance_entities` VALUES (6000,17022980);
INSERT INTO `instance_entities` VALUES (6000,17022981);
INSERT INTO `instance_entities` VALUES (6000,17022982);
INSERT INTO `instance_entities` VALUES (6000,17022983);
INSERT INTO `instance_entities` VALUES (6000,17022984);
INSERT INTO `instance_entities` VALUES (6000,17022985);
INSERT INTO `instance_entities` VALUES (6000,17022986);
INSERT INTO `instance_entities` VALUES (6000,17022987);
INSERT INTO `instance_entities` VALUES (6000,17022988);
INSERT INTO `instance_entities` VALUES (6000,17022989);
-- npcs
INSERT INTO `instance_entities` VALUES (6000,17022979);

-- Against All Odds COR AF2
INSERT INTO `instance_entities` VALUES (6001,17022977);
INSERT INTO `instance_entities` VALUES (6001,17022978);

-- Excavation Duty
-- mobs
INSERT INTO `instance_entities` VALUES (6300,17035265);
INSERT INTO `instance_entities` VALUES (6300,17035266);
INSERT INTO `instance_entities` VALUES (6300,17035267);
INSERT INTO `instance_entities` VALUES (6300,17035268);
INSERT INTO `instance_entities` VALUES (6300,17035269);
INSERT INTO `instance_entities` VALUES (6300,17035270);
INSERT INTO `instance_entities` VALUES (6300,17035271);
INSERT INTO `instance_entities` VALUES (6300,17035272);
INSERT INTO `instance_entities` VALUES (6300,17035273);
INSERT INTO `instance_entities` VALUES (6300,17035274);
INSERT INTO `instance_entities` VALUES (6300,17035275);
INSERT INTO `instance_entities` VALUES (6300,17035276);
INSERT INTO `instance_entities` VALUES (6300,17035277);
INSERT INTO `instance_entities` VALUES (6300,17035278);
INSERT INTO `instance_entities` VALUES (6300,17035279);
INSERT INTO `instance_entities` VALUES (6300,17035280);
INSERT INTO `instance_entities` VALUES (6300,17035281);
INSERT INTO `instance_entities` VALUES (6300,17035282);
INSERT INTO `instance_entities` VALUES (6300,17035283);
INSERT INTO `instance_entities` VALUES (6300,17035284);
INSERT INTO `instance_entities` VALUES (6300,17035285);
INSERT INTO `instance_entities` VALUES (6300,17035286);
INSERT INTO `instance_entities` VALUES (6300,17035287);
INSERT INTO `instance_entities` VALUES (6300,17035288);
INSERT INTO `instance_entities` VALUES (6300,17035289);
INSERT INTO `instance_entities` VALUES (6300,17035290);
INSERT INTO `instance_entities` VALUES (6300,17035291);
-- npcs
INSERT INTO `instance_entities` VALUES (6300,17035478);
INSERT INTO `instance_entities` VALUES (6300,17035479);
INSERT INTO `instance_entities` VALUES (6300,17035537);
INSERT INTO `instance_entities` VALUES (6300,17035538);
INSERT INTO `instance_entities` VALUES (6300,17035539);
INSERT INTO `instance_entities` VALUES (6300,17035540);
INSERT INTO `instance_entities` VALUES (6300,17035541);

-- Lebros Supplies
-- mobs
INSERT INTO `instance_entities` VALUES (6301,17035292);
INSERT INTO `instance_entities` VALUES (6301,17035293);
INSERT INTO `instance_entities` VALUES (6301,17035294);
INSERT INTO `instance_entities` VALUES (6301,17035295);
INSERT INTO `instance_entities` VALUES (6301,17035296);
INSERT INTO `instance_entities` VALUES (6301,17035297);
INSERT INTO `instance_entities` VALUES (6301,17035298);
INSERT INTO `instance_entities` VALUES (6301,17035299);
INSERT INTO `instance_entities` VALUES (6301,17035300);
INSERT INTO `instance_entities` VALUES (6301,17035301);
INSERT INTO `instance_entities` VALUES (6301,17035302);
INSERT INTO `instance_entities` VALUES (6301,17035303);
INSERT INTO `instance_entities` VALUES (6301,17035304);
INSERT INTO `instance_entities` VALUES (6301,17035305);
INSERT INTO `instance_entities` VALUES (6301,17035306);
INSERT INTO `instance_entities` VALUES (6301,17035307);
INSERT INTO `instance_entities` VALUES (6301,17035308);
INSERT INTO `instance_entities` VALUES (6301,17035309);
-- npcs
INSERT INTO `instance_entities` VALUES (6301,17035478);
INSERT INTO `instance_entities` VALUES (6301,17035479);
INSERT INTO `instance_entities` VALUES (6301,17035480);
INSERT INTO `instance_entities` VALUES (6301,17035522);
INSERT INTO `instance_entities` VALUES (6301,17035529);

-- Troll Fugitives
-- mobs
INSERT INTO `instance_entities` VALUES (6302,17035310);
INSERT INTO `instance_entities` VALUES (6302,17035311);
INSERT INTO `instance_entities` VALUES (6302,17035312);
INSERT INTO `instance_entities` VALUES (6302,17035313);
INSERT INTO `instance_entities` VALUES (6302,17035314);
INSERT INTO `instance_entities` VALUES (6302,17035315);
INSERT INTO `instance_entities` VALUES (6302,17035316);
INSERT INTO `instance_entities` VALUES (6302,17035317);
INSERT INTO `instance_entities` VALUES (6302,17035318);
INSERT INTO `instance_entities` VALUES (6302,17035319);
INSERT INTO `instance_entities` VALUES (6302,17035320);
INSERT INTO `instance_entities` VALUES (6302,17035321);
INSERT INTO `instance_entities` VALUES (6302,17035322);
INSERT INTO `instance_entities` VALUES (6302,17035323);
INSERT INTO `instance_entities` VALUES (6302,17035324);
-- npcs
INSERT INTO `instance_entities` VALUES (6302,17035478);
INSERT INTO `instance_entities` VALUES (6302,17035479);
INSERT INTO `instance_entities` VALUES (6302,17035508);
INSERT INTO `instance_entities` VALUES (6302,17035513);
INSERT INTO `instance_entities` VALUES (6302,17035518);
INSERT INTO `instance_entities` VALUES (6302,17035521);

-- Wamoura Farm Raid
-- mobs
INSERT INTO `instance_entities` VALUES (6306,17035359);
INSERT INTO `instance_entities` VALUES (6306,17035360);
INSERT INTO `instance_entities` VALUES (6306,17035361);
INSERT INTO `instance_entities` VALUES (6306,17035362);
INSERT INTO `instance_entities` VALUES (6306,17035363);
INSERT INTO `instance_entities` VALUES (6306,17035365);
INSERT INTO `instance_entities` VALUES (6306,17035367);
INSERT INTO `instance_entities` VALUES (6306,17035368);
INSERT INTO `instance_entities` VALUES (6306,17035369);
INSERT INTO `instance_entities` VALUES (6306,17035370);
INSERT INTO `instance_entities` VALUES (6306,17035371);
INSERT INTO `instance_entities` VALUES (6306,17035372);
INSERT INTO `instance_entities` VALUES (6306,17035376);
INSERT INTO `instance_entities` VALUES (6306,17035377);
INSERT INTO `instance_entities` VALUES (6306,17035378);
INSERT INTO `instance_entities` VALUES (6306,17035478);
INSERT INTO `instance_entities` VALUES (6306,17035479);
INSERT INTO `instance_entities` VALUES (6306,17035508);
INSERT INTO `instance_entities` VALUES (6306,17035538);
INSERT INTO `instance_entities` VALUES (6306,17035539);
INSERT INTO `instance_entities` VALUES (6306,17035541);
INSERT INTO `instance_entities` VALUES (6306,17035542);
INSERT INTO `instance_entities` VALUES (6306,17035543);
INSERT INTO `instance_entities` VALUES (6306,17035544);
INSERT INTO `instance_entities` VALUES (6306,17035545);
INSERT INTO `instance_entities` VALUES (6306,17035546);

-- Imperial Agent Rescue
-- mobs
INSERT INTO `instance_entities` VALUES (6600, 17047553);
INSERT INTO `instance_entities` VALUES (6600, 17047554);
INSERT INTO `instance_entities` VALUES (6600, 17047555);
INSERT INTO `instance_entities` VALUES (6600, 17047556);
INSERT INTO `instance_entities` VALUES (6600, 17047557);
INSERT INTO `instance_entities` VALUES (6600, 17047558);
INSERT INTO `instance_entities` VALUES (6600, 17047559);
INSERT INTO `instance_entities` VALUES (6600, 17047560);
INSERT INTO `instance_entities` VALUES (6600, 17047561);
INSERT INTO `instance_entities` VALUES (6600, 17047562);
INSERT INTO `instance_entities` VALUES (6600, 17047563);
INSERT INTO `instance_entities` VALUES (6600, 17047564);
INSERT INTO `instance_entities` VALUES (6600, 17047565);
INSERT INTO `instance_entities` VALUES (6600, 17047566);
INSERT INTO `instance_entities` VALUES (6600, 17047567);
INSERT INTO `instance_entities` VALUES (6600, 17047568);
INSERT INTO `instance_entities` VALUES (6600, 17047569);
-- npcs
INSERT INTO `instance_entities` VALUES (6600, 17047808);
INSERT INTO `instance_entities` VALUES (6600, 17047809);
INSERT INTO `instance_entities` VALUES (6600, 17047810);
INSERT INTO `instance_entities` VALUES (6600, 17047815);
INSERT INTO `instance_entities` VALUES (6600, 17047832);
INSERT INTO `instance_entities` VALUES (6600, 17047863);
INSERT INTO `instance_entities` VALUES (6600, 17047864);
INSERT INTO `instance_entities` VALUES (6600, 17047865);
INSERT INTO `instance_entities` VALUES (6600, 17047866);
INSERT INTO `instance_entities` VALUES (6600, 17047895);
INSERT INTO `instance_entities` VALUES (6600, 17047896);
INSERT INTO `instance_entities` VALUES (6600, 17047897);
INSERT INTO `instance_entities` VALUES (6600, 17047898);
INSERT INTO `instance_entities` VALUES (6600, 17047899);
INSERT INTO `instance_entities` VALUES (6600, 17047900);
INSERT INTO `instance_entities` VALUES (6600, 17047901);
INSERT INTO `instance_entities` VALUES (6600, 17047902);
INSERT INTO `instance_entities` VALUES (6600, 17047916);
INSERT INTO `instance_entities` VALUES (6600, 17047917);
INSERT INTO `instance_entities` VALUES (6600, 17047918);

-- Preemtive Strike
-- mobs
INSERT INTO `instance_entities` VALUES (6601, 17047570);
INSERT INTO `instance_entities` VALUES (6601, 17047571);
INSERT INTO `instance_entities` VALUES (6601, 17047572);
INSERT INTO `instance_entities` VALUES (6601, 17047573);
INSERT INTO `instance_entities` VALUES (6601, 17047574);
INSERT INTO `instance_entities` VALUES (6601, 17047575);
INSERT INTO `instance_entities` VALUES (6601, 17047576);
INSERT INTO `instance_entities` VALUES (6601, 17047577);
INSERT INTO `instance_entities` VALUES (6601, 17047578);
INSERT INTO `instance_entities` VALUES (6601, 17047579);
INSERT INTO `instance_entities` VALUES (6601, 17047580);
INSERT INTO `instance_entities` VALUES (6601, 17047581);
INSERT INTO `instance_entities` VALUES (6601, 17047582);
INSERT INTO `instance_entities` VALUES (6601, 17047583);
INSERT INTO `instance_entities` VALUES (6601, 17047584);
INSERT INTO `instance_entities` VALUES (6601, 17047585);
INSERT INTO `instance_entities` VALUES (6601, 17047586);
INSERT INTO `instance_entities` VALUES (6601, 17047587);
INSERT INTO `instance_entities` VALUES (6601, 17047588);
INSERT INTO `instance_entities` VALUES (6601, 17047589);
-- npcs
INSERT INTO `instance_entities` VALUES (6601, 17047808);
INSERT INTO `instance_entities` VALUES (6601, 17047809);
INSERT INTO `instance_entities` VALUES (6601, 17047836);
INSERT INTO `instance_entities` VALUES (6601, 17047868);
INSERT INTO `instance_entities` VALUES (6601, 17047869);
INSERT INTO `instance_entities` VALUES (6601, 17047870);
INSERT INTO `instance_entities` VALUES (6601, 17047874);
INSERT INTO `instance_entities` VALUES (6601, 17047875);

-- Leujaoam Cleansing
-- mobs
INSERT INTO `instance_entities` VALUES (6900,17059841);
INSERT INTO `instance_entities` VALUES (6900,17059842);
INSERT INTO `instance_entities` VALUES (6900,17059843);
INSERT INTO `instance_entities` VALUES (6900,17059844);
INSERT INTO `instance_entities` VALUES (6900,17059845);
INSERT INTO `instance_entities` VALUES (6900,17059846);
INSERT INTO `instance_entities` VALUES (6900,17059847);
INSERT INTO `instance_entities` VALUES (6900,17059848);
INSERT INTO `instance_entities` VALUES (6900,17059849);
INSERT INTO `instance_entities` VALUES (6900,17059850);
INSERT INTO `instance_entities` VALUES (6900,17059851);
INSERT INTO `instance_entities` VALUES (6900,17059852);
INSERT INTO `instance_entities` VALUES (6900,17059853);
INSERT INTO `instance_entities` VALUES (6900,17059854);
INSERT INTO `instance_entities` VALUES (6900,17059855);
-- npcs
INSERT INTO `instance_entities` VALUES (6900,17060014);
INSERT INTO `instance_entities` VALUES (6900,17060015);
INSERT INTO `instance_entities` VALUES (6900,17060138);
INSERT INTO `instance_entities` VALUES (6900,17060142);
INSERT INTO `instance_entities` VALUES (6900,17060146);
INSERT INTO `instance_entities` VALUES (6900,17060147);

-- Orichalcum Survey
-- mobs
INSERT INTO `instance_entities` VALUES (6901,17059856);
INSERT INTO `instance_entities` VALUES (6901,17059857);
INSERT INTO `instance_entities` VALUES (6901,17059858);
INSERT INTO `instance_entities` VALUES (6901,17059859);
INSERT INTO `instance_entities` VALUES (6901,17059860);
INSERT INTO `instance_entities` VALUES (6901,17059861);
INSERT INTO `instance_entities` VALUES (6901,17059862);
INSERT INTO `instance_entities` VALUES (6901,17059863);
INSERT INTO `instance_entities` VALUES (6901,17059864);
INSERT INTO `instance_entities` VALUES (6901,17059865);
INSERT INTO `instance_entities` VALUES (6901,17059866);
INSERT INTO `instance_entities` VALUES (6901,17059867);
INSERT INTO `instance_entities` VALUES (6901,17059868);
INSERT INTO `instance_entities` VALUES (6901,17059869);
INSERT INTO `instance_entities` VALUES (6901,17059870);
INSERT INTO `instance_entities` VALUES (6901,17059871);
INSERT INTO `instance_entities` VALUES (6901,17059872);
INSERT INTO `instance_entities` VALUES (6901,17059873);
-- npcs
INSERT INTO `instance_entities` VALUES (6901,17060014);
INSERT INTO `instance_entities` VALUES (6901,17060015);
INSERT INTO `instance_entities` VALUES (6901,17060016);
INSERT INTO `instance_entities` VALUES (6901,17060017);
INSERT INTO `instance_entities` VALUES (6901,17060018);
INSERT INTO `instance_entities` VALUES (6901,17060019);
INSERT INTO `instance_entities` VALUES (6901,17060020);
INSERT INTO `instance_entities` VALUES (6901,17060021);
INSERT INTO `instance_entities` VALUES (6901,17060022);
INSERT INTO `instance_entities` VALUES (6901,17060023);
INSERT INTO `instance_entities` VALUES (6901,17060024);
INSERT INTO `instance_entities` VALUES (6901,17060025);
INSERT INTO `instance_entities` VALUES (6901,17060026);
INSERT INTO `instance_entities` VALUES (6901,17060129);
INSERT INTO `instance_entities` VALUES (6901,17060139);

-- Arrapago Remnants
-- mobs
INSERT INTO `instance_entities` VALUES (7400,17080321);
INSERT INTO `instance_entities` VALUES (7400,17080322);
INSERT INTO `instance_entities` VALUES (7400,17080323);
INSERT INTO `instance_entities` VALUES (7400,17080324);
INSERT INTO `instance_entities` VALUES (7400,17080325);
INSERT INTO `instance_entities` VALUES (7400,17080326);
INSERT INTO `instance_entities` VALUES (7400,17080327);
INSERT INTO `instance_entities` VALUES (7400,17080328);
INSERT INTO `instance_entities` VALUES (7400,17080329);
INSERT INTO `instance_entities` VALUES (7400,17080330);
INSERT INTO `instance_entities` VALUES (7400,17080331);
INSERT INTO `instance_entities` VALUES (7400,17080332);
INSERT INTO `instance_entities` VALUES (7400,17080333);
INSERT INTO `instance_entities` VALUES (7400,17080334);
INSERT INTO `instance_entities` VALUES (7400,17080335);
INSERT INTO `instance_entities` VALUES (7400,17080336);
INSERT INTO `instance_entities` VALUES (7400,17080337);
INSERT INTO `instance_entities` VALUES (7400,17080338);
INSERT INTO `instance_entities` VALUES (7400,17080339);
INSERT INTO `instance_entities` VALUES (7400,17080340);
INSERT INTO `instance_entities` VALUES (7400,17080341);
INSERT INTO `instance_entities` VALUES (7400,17080342);
INSERT INTO `instance_entities` VALUES (7400,17080343);
INSERT INTO `instance_entities` VALUES (7400,17080344);
INSERT INTO `instance_entities` VALUES (7400,17080345);
INSERT INTO `instance_entities` VALUES (7400,17080346);
INSERT INTO `instance_entities` VALUES (7400,17080347);
INSERT INTO `instance_entities` VALUES (7400,17080348);
INSERT INTO `instance_entities` VALUES (7400,17080349);
INSERT INTO `instance_entities` VALUES (7400,17080350);
INSERT INTO `instance_entities` VALUES (7400,17080351);
INSERT INTO `instance_entities` VALUES (7400,17080352);
INSERT INTO `instance_entities` VALUES (7400,17080353);
INSERT INTO `instance_entities` VALUES (7400,17080354);
INSERT INTO `instance_entities` VALUES (7400,17080355);
INSERT INTO `instance_entities` VALUES (7400,17080356);
INSERT INTO `instance_entities` VALUES (7400,17080357);
INSERT INTO `instance_entities` VALUES (7400,17080358);
INSERT INTO `instance_entities` VALUES (7400,17080359);
INSERT INTO `instance_entities` VALUES (7400,17080360);
INSERT INTO `instance_entities` VALUES (7400,17080361);
INSERT INTO `instance_entities` VALUES (7400,17080362);
INSERT INTO `instance_entities` VALUES (7400,17080363);
INSERT INTO `instance_entities` VALUES (7400,17080364);
INSERT INTO `instance_entities` VALUES (7400,17080365);
INSERT INTO `instance_entities` VALUES (7400,17080366);
INSERT INTO `instance_entities` VALUES (7400,17080367);
INSERT INTO `instance_entities` VALUES (7400,17080368);
INSERT INTO `instance_entities` VALUES (7400,17080369);
INSERT INTO `instance_entities` VALUES (7400,17080370);
INSERT INTO `instance_entities` VALUES (7400,17080371);
INSERT INTO `instance_entities` VALUES (7400,17080372);
INSERT INTO `instance_entities` VALUES (7400,17080373);
INSERT INTO `instance_entities` VALUES (7400,17080374);
INSERT INTO `instance_entities` VALUES (7400,17080375);
INSERT INTO `instance_entities` VALUES (7400,17080376);
INSERT INTO `instance_entities` VALUES (7400,17080377);
INSERT INTO `instance_entities` VALUES (7400,17080378);
INSERT INTO `instance_entities` VALUES (7400,17080379);
INSERT INTO `instance_entities` VALUES (7400,17080380);
INSERT INTO `instance_entities` VALUES (7400,17080381);
INSERT INTO `instance_entities` VALUES (7400,17080382);
INSERT INTO `instance_entities` VALUES (7400,17080383);
INSERT INTO `instance_entities` VALUES (7400,17080384);
INSERT INTO `instance_entities` VALUES (7400,17080385);
INSERT INTO `instance_entities` VALUES (7400,17080386);
INSERT INTO `instance_entities` VALUES (7400,17080387);
INSERT INTO `instance_entities` VALUES (7400,17080388);
INSERT INTO `instance_entities` VALUES (7400,17080389);
INSERT INTO `instance_entities` VALUES (7400,17080390);
INSERT INTO `instance_entities` VALUES (7400,17080391);
INSERT INTO `instance_entities` VALUES (7400,17080392);
INSERT INTO `instance_entities` VALUES (7400,17080393);
INSERT INTO `instance_entities` VALUES (7400,17080394);
INSERT INTO `instance_entities` VALUES (7400,17080395);
INSERT INTO `instance_entities` VALUES (7400,17080396);
INSERT INTO `instance_entities` VALUES (7400,17080397);
INSERT INTO `instance_entities` VALUES (7400,17080398);
INSERT INTO `instance_entities` VALUES (7400,17080399);
INSERT INTO `instance_entities` VALUES (7400,17080400);
INSERT INTO `instance_entities` VALUES (7400,17080401);
INSERT INTO `instance_entities` VALUES (7400,17080402);
INSERT INTO `instance_entities` VALUES (7400,17080403);
INSERT INTO `instance_entities` VALUES (7400,17080404);
INSERT INTO `instance_entities` VALUES (7400,17080405);
INSERT INTO `instance_entities` VALUES (7400,17080406);
INSERT INTO `instance_entities` VALUES (7400,17080407);
INSERT INTO `instance_entities` VALUES (7400,17080408);
INSERT INTO `instance_entities` VALUES (7400,17080409);
INSERT INTO `instance_entities` VALUES (7400,17080410);
INSERT INTO `instance_entities` VALUES (7400,17080411);
INSERT INTO `instance_entities` VALUES (7400,17080412);
INSERT INTO `instance_entities` VALUES (7400,17080413);
INSERT INTO `instance_entities` VALUES (7400,17080414);
INSERT INTO `instance_entities` VALUES (7400,17080415);
INSERT INTO `instance_entities` VALUES (7400,17080416);
INSERT INTO `instance_entities` VALUES (7400,17080417);
INSERT INTO `instance_entities` VALUES (7400,17080418);
INSERT INTO `instance_entities` VALUES (7400,17080419);
INSERT INTO `instance_entities` VALUES (7400,17080420);
INSERT INTO `instance_entities` VALUES (7400,17080421);
INSERT INTO `instance_entities` VALUES (7400,17080422);
INSERT INTO `instance_entities` VALUES (7400,17080423);
INSERT INTO `instance_entities` VALUES (7400,17080424);
INSERT INTO `instance_entities` VALUES (7400,17080426);
INSERT INTO `instance_entities` VALUES (7400,17080427);
INSERT INTO `instance_entities` VALUES (7400,17080428);
INSERT INTO `instance_entities` VALUES (7400,17080429);
INSERT INTO `instance_entities` VALUES (7400,17080430);
INSERT INTO `instance_entities` VALUES (7400,17080431);
INSERT INTO `instance_entities` VALUES (7400,17080432);
INSERT INTO `instance_entities` VALUES (7400,17080433);
INSERT INTO `instance_entities` VALUES (7400,17080434);
INSERT INTO `instance_entities` VALUES (7400,17080435);
INSERT INTO `instance_entities` VALUES (7400,17080436);
INSERT INTO `instance_entities` VALUES (7400,17080437);
INSERT INTO `instance_entities` VALUES (7400,17080438);
INSERT INTO `instance_entities` VALUES (7400,17080439);
INSERT INTO `instance_entities` VALUES (7400,17080440);
INSERT INTO `instance_entities` VALUES (7400,17080441);
INSERT INTO `instance_entities` VALUES (7400,17080442);
INSERT INTO `instance_entities` VALUES (7400,17080443);
INSERT INTO `instance_entities` VALUES (7400,17080444);
INSERT INTO `instance_entities` VALUES (7400,17080445);
INSERT INTO `instance_entities` VALUES (7400,17080446);
INSERT INTO `instance_entities` VALUES (7400,17080447);
INSERT INTO `instance_entities` VALUES (7400,17080448);
INSERT INTO `instance_entities` VALUES (7400,17080449);
INSERT INTO `instance_entities` VALUES (7400,17080450);
INSERT INTO `instance_entities` VALUES (7400,17080451);
INSERT INTO `instance_entities` VALUES (7400,17080452);
INSERT INTO `instance_entities` VALUES (7400,17080453);
INSERT INTO `instance_entities` VALUES (7400,17080454);
INSERT INTO `instance_entities` VALUES (7400,17080455);
INSERT INTO `instance_entities` VALUES (7400,17080456);
INSERT INTO `instance_entities` VALUES (7400,17080457);
INSERT INTO `instance_entities` VALUES (7400,17080458);
INSERT INTO `instance_entities` VALUES (7400,17080459);
INSERT INTO `instance_entities` VALUES (7400,17080460);
INSERT INTO `instance_entities` VALUES (7400,17080461);
INSERT INTO `instance_entities` VALUES (7400,17080462);
INSERT INTO `instance_entities` VALUES (7400,17080463);
INSERT INTO `instance_entities` VALUES (7400,17080464);
INSERT INTO `instance_entities` VALUES (7400,17080465);
INSERT INTO `instance_entities` VALUES (7400,17080466);
INSERT INTO `instance_entities` VALUES (7400,17080467);
INSERT INTO `instance_entities` VALUES (7400,17080468);
INSERT INTO `instance_entities` VALUES (7400,17080469);
INSERT INTO `instance_entities` VALUES (7400,17080470);
INSERT INTO `instance_entities` VALUES (7400,17080471);
INSERT INTO `instance_entities` VALUES (7400,17080472);
INSERT INTO `instance_entities` VALUES (7400,17080473);
INSERT INTO `instance_entities` VALUES (7400,17080474);
INSERT INTO `instance_entities` VALUES (7400,17080475);
INSERT INTO `instance_entities` VALUES (7400,17080476);
INSERT INTO `instance_entities` VALUES (7400,17080477);
INSERT INTO `instance_entities` VALUES (7400,17080478);
INSERT INTO `instance_entities` VALUES (7400,17080479);
INSERT INTO `instance_entities` VALUES (7400,17080480);
INSERT INTO `instance_entities` VALUES (7400,17080481);
INSERT INTO `instance_entities` VALUES (7400,17080482);
INSERT INTO `instance_entities` VALUES (7400,17080483);
INSERT INTO `instance_entities` VALUES (7400,17080484);
INSERT INTO `instance_entities` VALUES (7400,17080485);
INSERT INTO `instance_entities` VALUES (7400,17080486);
INSERT INTO `instance_entities` VALUES (7400,17080487);
INSERT INTO `instance_entities` VALUES (7400,17080488);
INSERT INTO `instance_entities` VALUES (7400,17080489);
INSERT INTO `instance_entities` VALUES (7400,17080490);
INSERT INTO `instance_entities` VALUES (7400,17080491);
INSERT INTO `instance_entities` VALUES (7400,17080492);
INSERT INTO `instance_entities` VALUES (7400,17080493);
INSERT INTO `instance_entities` VALUES (7400,17080494);
INSERT INTO `instance_entities` VALUES (7400,17080495);
INSERT INTO `instance_entities` VALUES (7400,17080496);
INSERT INTO `instance_entities` VALUES (7400,17080497);
INSERT INTO `instance_entities` VALUES (7400,17080498);
INSERT INTO `instance_entities` VALUES (7400,17080499);
INSERT INTO `instance_entities` VALUES (7400,17080500);
INSERT INTO `instance_entities` VALUES (7400,17080501);
INSERT INTO `instance_entities` VALUES (7400,17080502);
INSERT INTO `instance_entities` VALUES (7400,17080503);
INSERT INTO `instance_entities` VALUES (7400,17080504);
INSERT INTO `instance_entities` VALUES (7400,17080505);
INSERT INTO `instance_entities` VALUES (7400,17080506);
INSERT INTO `instance_entities` VALUES (7400,17080507);
INSERT INTO `instance_entities` VALUES (7400,17080508);
INSERT INTO `instance_entities` VALUES (7400,17080509);
INSERT INTO `instance_entities` VALUES (7400,17080510);
INSERT INTO `instance_entities` VALUES (7400,17080511);
INSERT INTO `instance_entities` VALUES (7400,17080512);
INSERT INTO `instance_entities` VALUES (7400,17080514);
INSERT INTO `instance_entities` VALUES (7400,17080515);
INSERT INTO `instance_entities` VALUES (7400,17080516);
INSERT INTO `instance_entities` VALUES (7400,17080517);
INSERT INTO `instance_entities` VALUES (7400,17080518);
INSERT INTO `instance_entities` VALUES (7400,17080519);
INSERT INTO `instance_entities` VALUES (7400,17080520);
INSERT INTO `instance_entities` VALUES (7400,17080521);
INSERT INTO `instance_entities` VALUES (7400,17080522);
INSERT INTO `instance_entities` VALUES (7400,17080523);
INSERT INTO `instance_entities` VALUES (7400,17080524);
INSERT INTO `instance_entities` VALUES (7400,17080525);
INSERT INTO `instance_entities` VALUES (7400,17080526);
INSERT INTO `instance_entities` VALUES (7400,17080527);
INSERT INTO `instance_entities` VALUES (7400,17080528);
INSERT INTO `instance_entities` VALUES (7400,17080529);
INSERT INTO `instance_entities` VALUES (7400,17080530);
INSERT INTO `instance_entities` VALUES (7400,17080531);
INSERT INTO `instance_entities` VALUES (7400,17080532);
INSERT INTO `instance_entities` VALUES (7400,17080533);
INSERT INTO `instance_entities` VALUES (7400,17080534);
INSERT INTO `instance_entities` VALUES (7400,17080535);
INSERT INTO `instance_entities` VALUES (7400,17080536);
INSERT INTO `instance_entities` VALUES (7400,17080537);
INSERT INTO `instance_entities` VALUES (7400,17080538);
INSERT INTO `instance_entities` VALUES (7400,17080539);
INSERT INTO `instance_entities` VALUES (7400,17080540);
INSERT INTO `instance_entities` VALUES (7400,17080541);
INSERT INTO `instance_entities` VALUES (7400,17080542);
INSERT INTO `instance_entities` VALUES (7400,17080543);
INSERT INTO `instance_entities` VALUES (7400,17080544);
INSERT INTO `instance_entities` VALUES (7400,17080545);
INSERT INTO `instance_entities` VALUES (7400,17080546);
INSERT INTO `instance_entities` VALUES (7400,17080547);
INSERT INTO `instance_entities` VALUES (7400,17080548);
INSERT INTO `instance_entities` VALUES (7400,17080549);
INSERT INTO `instance_entities` VALUES (7400,17080550);
INSERT INTO `instance_entities` VALUES (7400,17080551);
INSERT INTO `instance_entities` VALUES (7400,17080552);
INSERT INTO `instance_entities` VALUES (7400,17080553);
INSERT INTO `instance_entities` VALUES (7400,17080554);
INSERT INTO `instance_entities` VALUES (7400,17080555);
INSERT INTO `instance_entities` VALUES (7400,17080556);
INSERT INTO `instance_entities` VALUES (7400,17080557);
INSERT INTO `instance_entities` VALUES (7400,17080558);
INSERT INTO `instance_entities` VALUES (7400,17080559);
INSERT INTO `instance_entities` VALUES (7400,17080560);
INSERT INTO `instance_entities` VALUES (7400,17080561);
INSERT INTO `instance_entities` VALUES (7400,17080562);
INSERT INTO `instance_entities` VALUES (7400,17080563);
INSERT INTO `instance_entities` VALUES (7400,17080564);
INSERT INTO `instance_entities` VALUES (7400,17080565);
INSERT INTO `instance_entities` VALUES (7400,17080566);
INSERT INTO `instance_entities` VALUES (7400,17080567);
INSERT INTO `instance_entities` VALUES (7400,17080568);
INSERT INTO `instance_entities` VALUES (7400,17080569);
INSERT INTO `instance_entities` VALUES (7400,17080570);
INSERT INTO `instance_entities` VALUES (7400,17080571);
INSERT INTO `instance_entities` VALUES (7400,17080572);
INSERT INTO `instance_entities` VALUES (7400,17080573);
INSERT INTO `instance_entities` VALUES (7400,17080574);
INSERT INTO `instance_entities` VALUES (7400,17080575);
INSERT INTO `instance_entities` VALUES (7400,17080576);
INSERT INTO `instance_entities` VALUES (7400,17080577);
INSERT INTO `instance_entities` VALUES (7400,17080578);
INSERT INTO `instance_entities` VALUES (7400,17080579);
INSERT INTO `instance_entities` VALUES (7400,17080580);
INSERT INTO `instance_entities` VALUES (7400,17080581);
INSERT INTO `instance_entities` VALUES (7400,17080582);
INSERT INTO `instance_entities` VALUES (7400,17080585);
INSERT INTO `instance_entities` VALUES (7400,17080586);
INSERT INTO `instance_entities` VALUES (7400,17080596);
INSERT INTO `instance_entities` VALUES (7400,17080597);
-- npcs
INSERT INTO `instance_entities` VALUES (7400,17080598);
INSERT INTO `instance_entities` VALUES (7400,17080970);
INSERT INTO `instance_entities` VALUES (7400,17080971);
INSERT INTO `instance_entities` VALUES (7400,17080972);
INSERT INTO `instance_entities` VALUES (7400,17080973);
INSERT INTO `instance_entities` VALUES (7400,17080974);
INSERT INTO `instance_entities` VALUES (7400,17080975);
INSERT INTO `instance_entities` VALUES (7400,17080976);
INSERT INTO `instance_entities` VALUES (7400,17080977);
INSERT INTO `instance_entities` VALUES (7400,17080978);
INSERT INTO `instance_entities` VALUES (7400,17080979);
INSERT INTO `instance_entities` VALUES (7400,17080980);
INSERT INTO `instance_entities` VALUES (7400,17080981);
INSERT INTO `instance_entities` VALUES (7400,17080982);
INSERT INTO `instance_entities` VALUES (7400,17080983);
INSERT INTO `instance_entities` VALUES (7400,17080984);
INSERT INTO `instance_entities` VALUES (7400,17080985);
INSERT INTO `instance_entities` VALUES (7400,17080986);
INSERT INTO `instance_entities` VALUES (7400,17080987);
INSERT INTO `instance_entities` VALUES (7400,17080988);
INSERT INTO `instance_entities` VALUES (7400,17080989);
INSERT INTO `instance_entities` VALUES (7400,17080990);
INSERT INTO `instance_entities` VALUES (7400,17080991);
INSERT INTO `instance_entities` VALUES (7400,17080992);
INSERT INTO `instance_entities` VALUES (7400,17080993);

-- Path of Darkness
-- mobs
INSERT INTO `instance_entities` VALUES (7700,17093132);
INSERT INTO `instance_entities` VALUES (7700,17093133);
INSERT INTO `instance_entities` VALUES (7700,17093134);
INSERT INTO `instance_entities` VALUES (7700,17093135);
INSERT INTO `instance_entities` VALUES (7700,17093136);
INSERT INTO `instance_entities` VALUES (7700,17093137);
INSERT INTO `instance_entities` VALUES (7700,17093142);
-- npcs
INSERT INTO `instance_entities` VALUES (7700,17093359);
INSERT INTO `instance_entities` VALUES (7700,17093361);
INSERT INTO `instance_entities` VALUES (7700,17093423);

-- Nashmeira's Plea
-- mobs
INSERT INTO `instance_entities` VALUES (7701,17093143);
INSERT INTO `instance_entities` VALUES (7701,17093144);
INSERT INTO `instance_entities` VALUES (7701,17093145);
-- npcs
INSERT INTO `instance_entities` VALUES (7701,17093423);
INSERT INTO `instance_entities` VALUES (7701,17093472);
INSERT INTO `instance_entities` VALUES (7701,17093473);
INSERT INTO `instance_entities` VALUES (7701,17093474);
INSERT INTO `instance_entities` VALUES (7701,17093475);
INSERT INTO `instance_entities` VALUES (7701,17093476);
INSERT INTO `instance_entities` VALUES (7701,17093477);
INSERT INTO `instance_entities` VALUES (7701,17093478);
INSERT INTO `instance_entities` VALUES (7701,17093479);
INSERT INTO `instance_entities` VALUES (7701,17093480);
INSERT INTO `instance_entities` VALUES (7701,17093481);
INSERT INTO `instance_entities` VALUES (7701,17093482);

-- Nyzul Isle Investigation
-- npcs
INSERT INTO `instance_entities` VALUES (7704,17092609); -- Chests
INSERT INTO `instance_entities` VALUES (7704,17092610);
INSERT INTO `instance_entities` VALUES (7704,17092611);
INSERT INTO `instance_entities` VALUES (7704,17092612);
INSERT INTO `instance_entities` VALUES (7704,17092613);
INSERT INTO `instance_entities` VALUES (7704,17092614);
INSERT INTO `instance_entities` VALUES (7704,17092615);
INSERT INTO `instance_entities` VALUES (7704,17092616);
INSERT INTO `instance_entities` VALUES (7704,17092617);
INSERT INTO `instance_entities` VALUES (7704,17092618);
INSERT INTO `instance_entities` VALUES (7704,17092619);
INSERT INTO `instance_entities` VALUES (7704,17092620);
INSERT INTO `instance_entities` VALUES (7704,17093330); -- Rune of Transfer
INSERT INTO `instance_entities` VALUES (7704,17093331); -- Rune of Transfer
INSERT INTO `instance_entities` VALUES (7704,17093332); -- Runic Lamp 1
INSERT INTO `instance_entities` VALUES (7704,17093333); -- Runic Lamp 2
INSERT INTO `instance_entities` VALUES (7704,17093334); -- Runic Lamp 3
INSERT INTO `instance_entities` VALUES (7704,17093335); -- Runic Lamp 4
INSERT INTO `instance_entities` VALUES (7704,17093336); -- Runic Lamp 5
INSERT INTO `instance_entities` VALUES (7704,17093353);
INSERT INTO `instance_entities` VALUES (7704,17093354);
INSERT INTO `instance_entities` VALUES (7704,17093429); -- Rune of Transfer
INSERT INTO `instance_entities` VALUES (7704,17093430); -- Vending box
-- mobs
INSERT INTO `instance_entities` VALUES (7704,17092629);
INSERT INTO `instance_entities` VALUES (7704,17092630);
INSERT INTO `instance_entities` VALUES (7704,17092631);
INSERT INTO `instance_entities` VALUES (7704,17092632);
INSERT INTO `instance_entities` VALUES (7704,17092633);
INSERT INTO `instance_entities` VALUES (7704,17092634);
INSERT INTO `instance_entities` VALUES (7704,17092635);
INSERT INTO `instance_entities` VALUES (7704,17092636);
INSERT INTO `instance_entities` VALUES (7704,17092637);
INSERT INTO `instance_entities` VALUES (7704,17092638);
INSERT INTO `instance_entities` VALUES (7704,17092639);
INSERT INTO `instance_entities` VALUES (7704,17092640);
INSERT INTO `instance_entities` VALUES (7704,17092641);
INSERT INTO `instance_entities` VALUES (7704,17092642);
INSERT INTO `instance_entities` VALUES (7704,17092643);
INSERT INTO `instance_entities` VALUES (7704,17092644);
INSERT INTO `instance_entities` VALUES (7704,17092645);
INSERT INTO `instance_entities` VALUES (7704,17092646);
INSERT INTO `instance_entities` VALUES (7704,17092647);
INSERT INTO `instance_entities` VALUES (7704,17092648);
INSERT INTO `instance_entities` VALUES (7704,17092649);
INSERT INTO `instance_entities` VALUES (7704,17092650);
INSERT INTO `instance_entities` VALUES (7704,17092651);
INSERT INTO `instance_entities` VALUES (7704,17092652);
INSERT INTO `instance_entities` VALUES (7704,17092653);
INSERT INTO `instance_entities` VALUES (7704,17092654);
INSERT INTO `instance_entities` VALUES (7704,17092655);
INSERT INTO `instance_entities` VALUES (7704,17092656);
INSERT INTO `instance_entities` VALUES (7704,17092657);
INSERT INTO `instance_entities` VALUES (7704,17092658);
INSERT INTO `instance_entities` VALUES (7704,17092659);
INSERT INTO `instance_entities` VALUES (7704,17092660);
INSERT INTO `instance_entities` VALUES (7704,17092661);
INSERT INTO `instance_entities` VALUES (7704,17092662);
INSERT INTO `instance_entities` VALUES (7704,17092663);
INSERT INTO `instance_entities` VALUES (7704,17092664);
INSERT INTO `instance_entities` VALUES (7704,17092665);
INSERT INTO `instance_entities` VALUES (7704,17092666);
INSERT INTO `instance_entities` VALUES (7704,17092667);
INSERT INTO `instance_entities` VALUES (7704,17092668);
INSERT INTO `instance_entities` VALUES (7704,17092669);
INSERT INTO `instance_entities` VALUES (7704,17092670);
INSERT INTO `instance_entities` VALUES (7704,17092671);
INSERT INTO `instance_entities` VALUES (7704,17092672);
INSERT INTO `instance_entities` VALUES (7704,17092673);
INSERT INTO `instance_entities` VALUES (7704,17092674);
INSERT INTO `instance_entities` VALUES (7704,17092675);
INSERT INTO `instance_entities` VALUES (7704,17092676);
INSERT INTO `instance_entities` VALUES (7704,17092677);
INSERT INTO `instance_entities` VALUES (7704,17092678);
INSERT INTO `instance_entities` VALUES (7704,17092679);
INSERT INTO `instance_entities` VALUES (7704,17092680);
INSERT INTO `instance_entities` VALUES (7704,17092681);
INSERT INTO `instance_entities` VALUES (7704,17092682);
INSERT INTO `instance_entities` VALUES (7704,17092683);
INSERT INTO `instance_entities` VALUES (7704,17092684);
INSERT INTO `instance_entities` VALUES (7704,17092685);
INSERT INTO `instance_entities` VALUES (7704,17092686);
INSERT INTO `instance_entities` VALUES (7704,17092687);
INSERT INTO `instance_entities` VALUES (7704,17092688);
INSERT INTO `instance_entities` VALUES (7704,17092689);
INSERT INTO `instance_entities` VALUES (7704,17092690);
INSERT INTO `instance_entities` VALUES (7704,17092691);
INSERT INTO `instance_entities` VALUES (7704,17092692);
INSERT INTO `instance_entities` VALUES (7704,17092693);
INSERT INTO `instance_entities` VALUES (7704,17092694);
INSERT INTO `instance_entities` VALUES (7704,17092695);
INSERT INTO `instance_entities` VALUES (7704,17092696);
INSERT INTO `instance_entities` VALUES (7704,17092697);
INSERT INTO `instance_entities` VALUES (7704,17092698);
INSERT INTO `instance_entities` VALUES (7704,17092699);
INSERT INTO `instance_entities` VALUES (7704,17092700);
INSERT INTO `instance_entities` VALUES (7704,17092701);
INSERT INTO `instance_entities` VALUES (7704,17092702);
INSERT INTO `instance_entities` VALUES (7704,17092703);
INSERT INTO `instance_entities` VALUES (7704,17092704);
INSERT INTO `instance_entities` VALUES (7704,17092705);
INSERT INTO `instance_entities` VALUES (7704,17092706);
INSERT INTO `instance_entities` VALUES (7704,17092707);
INSERT INTO `instance_entities` VALUES (7704,17092708);
INSERT INTO `instance_entities` VALUES (7704,17092709);
INSERT INTO `instance_entities` VALUES (7704,17092710);
INSERT INTO `instance_entities` VALUES (7704,17092711);
INSERT INTO `instance_entities` VALUES (7704,17092712);
INSERT INTO `instance_entities` VALUES (7704,17092713);
INSERT INTO `instance_entities` VALUES (7704,17092714);
INSERT INTO `instance_entities` VALUES (7704,17092715);
INSERT INTO `instance_entities` VALUES (7704,17092716);
INSERT INTO `instance_entities` VALUES (7704,17092717);
INSERT INTO `instance_entities` VALUES (7704,17092718);
INSERT INTO `instance_entities` VALUES (7704,17092719);
INSERT INTO `instance_entities` VALUES (7704,17092720);
INSERT INTO `instance_entities` VALUES (7704,17092721);
INSERT INTO `instance_entities` VALUES (7704,17092722);
INSERT INTO `instance_entities` VALUES (7704,17092723);
INSERT INTO `instance_entities` VALUES (7704,17092724);
INSERT INTO `instance_entities` VALUES (7704,17092725);
INSERT INTO `instance_entities` VALUES (7704,17092726);
INSERT INTO `instance_entities` VALUES (7704,17092727);
INSERT INTO `instance_entities` VALUES (7704,17092728);
INSERT INTO `instance_entities` VALUES (7704,17092729);
INSERT INTO `instance_entities` VALUES (7704,17092730);
INSERT INTO `instance_entities` VALUES (7704,17092731);
INSERT INTO `instance_entities` VALUES (7704,17092732);
INSERT INTO `instance_entities` VALUES (7704,17092733);
INSERT INTO `instance_entities` VALUES (7704,17092734);
INSERT INTO `instance_entities` VALUES (7704,17092735);
INSERT INTO `instance_entities` VALUES (7704,17092736);
INSERT INTO `instance_entities` VALUES (7704,17092737);
INSERT INTO `instance_entities` VALUES (7704,17092738);
INSERT INTO `instance_entities` VALUES (7704,17092739);
INSERT INTO `instance_entities` VALUES (7704,17092740);
INSERT INTO `instance_entities` VALUES (7704,17092741);
INSERT INTO `instance_entities` VALUES (7704,17092742);
INSERT INTO `instance_entities` VALUES (7704,17092743);
INSERT INTO `instance_entities` VALUES (7704,17092744);
INSERT INTO `instance_entities` VALUES (7704,17092745);
INSERT INTO `instance_entities` VALUES (7704,17092746);
INSERT INTO `instance_entities` VALUES (7704,17092747);
INSERT INTO `instance_entities` VALUES (7704,17092748);
INSERT INTO `instance_entities` VALUES (7704,17092749);
INSERT INTO `instance_entities` VALUES (7704,17092750);
INSERT INTO `instance_entities` VALUES (7704,17092751);
INSERT INTO `instance_entities` VALUES (7704,17092752);
INSERT INTO `instance_entities` VALUES (7704,17092753);
INSERT INTO `instance_entities` VALUES (7704,17092754);
INSERT INTO `instance_entities` VALUES (7704,17092755);
INSERT INTO `instance_entities` VALUES (7704,17092756);
INSERT INTO `instance_entities` VALUES (7704,17092757);
INSERT INTO `instance_entities` VALUES (7704,17092758);
INSERT INTO `instance_entities` VALUES (7704,17092759);
INSERT INTO `instance_entities` VALUES (7704,17092760);
INSERT INTO `instance_entities` VALUES (7704,17092761);
INSERT INTO `instance_entities` VALUES (7704,17092762);
INSERT INTO `instance_entities` VALUES (7704,17092763);
INSERT INTO `instance_entities` VALUES (7704,17092764);
INSERT INTO `instance_entities` VALUES (7704,17092765);
INSERT INTO `instance_entities` VALUES (7704,17092766);
INSERT INTO `instance_entities` VALUES (7704,17092767);
INSERT INTO `instance_entities` VALUES (7704,17092768);
INSERT INTO `instance_entities` VALUES (7704,17092769);
INSERT INTO `instance_entities` VALUES (7704,17092770);
INSERT INTO `instance_entities` VALUES (7704,17092771);
INSERT INTO `instance_entities` VALUES (7704,17092772);
INSERT INTO `instance_entities` VALUES (7704,17092773);
INSERT INTO `instance_entities` VALUES (7704,17092774);
INSERT INTO `instance_entities` VALUES (7704,17092775);
INSERT INTO `instance_entities` VALUES (7704,17092776);
INSERT INTO `instance_entities` VALUES (7704,17092777);
INSERT INTO `instance_entities` VALUES (7704,17092778);
INSERT INTO `instance_entities` VALUES (7704,17092779);
INSERT INTO `instance_entities` VALUES (7704,17092780);
INSERT INTO `instance_entities` VALUES (7704,17092781);
INSERT INTO `instance_entities` VALUES (7704,17092782);
INSERT INTO `instance_entities` VALUES (7704,17092783);
INSERT INTO `instance_entities` VALUES (7704,17092784);
INSERT INTO `instance_entities` VALUES (7704,17092785);
INSERT INTO `instance_entities` VALUES (7704,17092786);
INSERT INTO `instance_entities` VALUES (7704,17092787);
INSERT INTO `instance_entities` VALUES (7704,17092788);
INSERT INTO `instance_entities` VALUES (7704,17092789);
INSERT INTO `instance_entities` VALUES (7704,17092790);
INSERT INTO `instance_entities` VALUES (7704,17092791);
INSERT INTO `instance_entities` VALUES (7704,17092792);
INSERT INTO `instance_entities` VALUES (7704,17092793);
INSERT INTO `instance_entities` VALUES (7704,17092794);
INSERT INTO `instance_entities` VALUES (7704,17092795);
INSERT INTO `instance_entities` VALUES (7704,17092796);
INSERT INTO `instance_entities` VALUES (7704,17092797);
INSERT INTO `instance_entities` VALUES (7704,17092798);
INSERT INTO `instance_entities` VALUES (7704,17092799);
INSERT INTO `instance_entities` VALUES (7704,17092800);
INSERT INTO `instance_entities` VALUES (7704,17092801);
INSERT INTO `instance_entities` VALUES (7704,17092802);
INSERT INTO `instance_entities` VALUES (7704,17092803);
INSERT INTO `instance_entities` VALUES (7704,17092804);
INSERT INTO `instance_entities` VALUES (7704,17092805);
INSERT INTO `instance_entities` VALUES (7704,17092806);
INSERT INTO `instance_entities` VALUES (7704,17092807);
INSERT INTO `instance_entities` VALUES (7704,17092808);
INSERT INTO `instance_entities` VALUES (7704,17092809);
INSERT INTO `instance_entities` VALUES (7704,17092810);
INSERT INTO `instance_entities` VALUES (7704,17092811);
INSERT INTO `instance_entities` VALUES (7704,17092812);
INSERT INTO `instance_entities` VALUES (7704,17092813);
INSERT INTO `instance_entities` VALUES (7704,17092814);
INSERT INTO `instance_entities` VALUES (7704,17092815);
INSERT INTO `instance_entities` VALUES (7704,17092816);
INSERT INTO `instance_entities` VALUES (7704,17092817);
INSERT INTO `instance_entities` VALUES (7704,17092818);
INSERT INTO `instance_entities` VALUES (7704,17092819);
INSERT INTO `instance_entities` VALUES (7704,17092820);
INSERT INTO `instance_entities` VALUES (7704,17092821);
INSERT INTO `instance_entities` VALUES (7704,17092822);
INSERT INTO `instance_entities` VALUES (7704,17092823);
INSERT INTO `instance_entities` VALUES (7704,17092824);
INSERT INTO `instance_entities` VALUES (7704,17092825);
INSERT INTO `instance_entities` VALUES (7704,17092826);
INSERT INTO `instance_entities` VALUES (7704,17092827);
INSERT INTO `instance_entities` VALUES (7704,17092828);
INSERT INTO `instance_entities` VALUES (7704,17092829);
INSERT INTO `instance_entities` VALUES (7704,17092830);
INSERT INTO `instance_entities` VALUES (7704,17092831);
INSERT INTO `instance_entities` VALUES (7704,17092832);
INSERT INTO `instance_entities` VALUES (7704,17092833);
INSERT INTO `instance_entities` VALUES (7704,17092834);
INSERT INTO `instance_entities` VALUES (7704,17092835);
INSERT INTO `instance_entities` VALUES (7704,17092836);
INSERT INTO `instance_entities` VALUES (7704,17092837);
INSERT INTO `instance_entities` VALUES (7704,17092838);
INSERT INTO `instance_entities` VALUES (7704,17092839);
INSERT INTO `instance_entities` VALUES (7704,17092840);
INSERT INTO `instance_entities` VALUES (7704,17092841);
INSERT INTO `instance_entities` VALUES (7704,17092842);
INSERT INTO `instance_entities` VALUES (7704,17092843);
INSERT INTO `instance_entities` VALUES (7704,17092844);
INSERT INTO `instance_entities` VALUES (7704,17092845);
INSERT INTO `instance_entities` VALUES (7704,17092846);
INSERT INTO `instance_entities` VALUES (7704,17092847);
INSERT INTO `instance_entities` VALUES (7704,17092848);
INSERT INTO `instance_entities` VALUES (7704,17092849);
INSERT INTO `instance_entities` VALUES (7704,17092850);
INSERT INTO `instance_entities` VALUES (7704,17092851);
INSERT INTO `instance_entities` VALUES (7704,17092852);
INSERT INTO `instance_entities` VALUES (7704,17092853);
INSERT INTO `instance_entities` VALUES (7704,17092854);
INSERT INTO `instance_entities` VALUES (7704,17092855);
INSERT INTO `instance_entities` VALUES (7704,17092856);
INSERT INTO `instance_entities` VALUES (7704,17092857);
INSERT INTO `instance_entities` VALUES (7704,17092858);
INSERT INTO `instance_entities` VALUES (7704,17092859);
INSERT INTO `instance_entities` VALUES (7704,17092860);
INSERT INTO `instance_entities` VALUES (7704,17092861);
INSERT INTO `instance_entities` VALUES (7704,17092862);
INSERT INTO `instance_entities` VALUES (7704,17092863);
INSERT INTO `instance_entities` VALUES (7704,17092864);
INSERT INTO `instance_entities` VALUES (7704,17092865);
INSERT INTO `instance_entities` VALUES (7704,17092866);
INSERT INTO `instance_entities` VALUES (7704,17092867);
INSERT INTO `instance_entities` VALUES (7704,17092868);
INSERT INTO `instance_entities` VALUES (7704,17092869);
INSERT INTO `instance_entities` VALUES (7704,17092870);
INSERT INTO `instance_entities` VALUES (7704,17092871);
INSERT INTO `instance_entities` VALUES (7704,17092872);
INSERT INTO `instance_entities` VALUES (7704,17092873);
INSERT INTO `instance_entities` VALUES (7704,17092874);
INSERT INTO `instance_entities` VALUES (7704,17092875);
INSERT INTO `instance_entities` VALUES (7704,17092876);
INSERT INTO `instance_entities` VALUES (7704,17092877);
INSERT INTO `instance_entities` VALUES (7704,17092878);
INSERT INTO `instance_entities` VALUES (7704,17092879);
INSERT INTO `instance_entities` VALUES (7704,17092880);
INSERT INTO `instance_entities` VALUES (7704,17092881);
INSERT INTO `instance_entities` VALUES (7704,17092882);
INSERT INTO `instance_entities` VALUES (7704,17092883);
INSERT INTO `instance_entities` VALUES (7704,17092884);
INSERT INTO `instance_entities` VALUES (7704,17092885);
INSERT INTO `instance_entities` VALUES (7704,17092886);
INSERT INTO `instance_entities` VALUES (7704,17092887);
INSERT INTO `instance_entities` VALUES (7704,17092888);
INSERT INTO `instance_entities` VALUES (7704,17092889);
INSERT INTO `instance_entities` VALUES (7704,17092890);
INSERT INTO `instance_entities` VALUES (7704,17092891);
INSERT INTO `instance_entities` VALUES (7704,17092892);
INSERT INTO `instance_entities` VALUES (7704,17092893);
INSERT INTO `instance_entities` VALUES (7704,17092894);
INSERT INTO `instance_entities` VALUES (7704,17092895);
INSERT INTO `instance_entities` VALUES (7704,17092896);
INSERT INTO `instance_entities` VALUES (7704,17092897);
INSERT INTO `instance_entities` VALUES (7704,17092898);
INSERT INTO `instance_entities` VALUES (7704,17092899);
INSERT INTO `instance_entities` VALUES (7704,17092901);
INSERT INTO `instance_entities` VALUES (7704,17092902);
INSERT INTO `instance_entities` VALUES (7704,17092903);
INSERT INTO `instance_entities` VALUES (7704,17092904);
INSERT INTO `instance_entities` VALUES (7704,17092905);
INSERT INTO `instance_entities` VALUES (7704,17092906);
INSERT INTO `instance_entities` VALUES (7704,17092907);
INSERT INTO `instance_entities` VALUES (7704,17092908);
INSERT INTO `instance_entities` VALUES (7704,17092909);
INSERT INTO `instance_entities` VALUES (7704,17092910);
INSERT INTO `instance_entities` VALUES (7704,17092911);
INSERT INTO `instance_entities` VALUES (7704,17092912);
INSERT INTO `instance_entities` VALUES (7704,17092913);
INSERT INTO `instance_entities` VALUES (7704,17092914);
INSERT INTO `instance_entities` VALUES (7704,17092915);
INSERT INTO `instance_entities` VALUES (7704,17092916);
INSERT INTO `instance_entities` VALUES (7704,17092917);
INSERT INTO `instance_entities` VALUES (7704,17092918);
INSERT INTO `instance_entities` VALUES (7704,17092919);
INSERT INTO `instance_entities` VALUES (7704,17092920);
INSERT INTO `instance_entities` VALUES (7704,17092921);
INSERT INTO `instance_entities` VALUES (7704,17092922);
INSERT INTO `instance_entities` VALUES (7704,17092923);
INSERT INTO `instance_entities` VALUES (7704,17092924);
INSERT INTO `instance_entities` VALUES (7704,17092925);
INSERT INTO `instance_entities` VALUES (7704,17092926);
INSERT INTO `instance_entities` VALUES (7704,17092927);
INSERT INTO `instance_entities` VALUES (7704,17092928);
INSERT INTO `instance_entities` VALUES (7704,17092929);
INSERT INTO `instance_entities` VALUES (7704,17092930);
INSERT INTO `instance_entities` VALUES (7704,17092931);
INSERT INTO `instance_entities` VALUES (7704,17092932);
INSERT INTO `instance_entities` VALUES (7704,17092933);
INSERT INTO `instance_entities` VALUES (7704,17092934);
INSERT INTO `instance_entities` VALUES (7704,17092935);
INSERT INTO `instance_entities` VALUES (7704,17092936);
INSERT INTO `instance_entities` VALUES (7704,17092937);
INSERT INTO `instance_entities` VALUES (7704,17092938);
INSERT INTO `instance_entities` VALUES (7704,17092939);
INSERT INTO `instance_entities` VALUES (7704,17092940);
INSERT INTO `instance_entities` VALUES (7704,17092941);
INSERT INTO `instance_entities` VALUES (7704,17092942);
INSERT INTO `instance_entities` VALUES (7704,17092943);
INSERT INTO `instance_entities` VALUES (7704,17092944);
INSERT INTO `instance_entities` VALUES (7704,17092945);
INSERT INTO `instance_entities` VALUES (7704,17092946);
INSERT INTO `instance_entities` VALUES (7704,17092947);
INSERT INTO `instance_entities` VALUES (7704,17092948);
INSERT INTO `instance_entities` VALUES (7704,17092949);
INSERT INTO `instance_entities` VALUES (7704,17092950);
INSERT INTO `instance_entities` VALUES (7704,17092951);
INSERT INTO `instance_entities` VALUES (7704,17092952);
INSERT INTO `instance_entities` VALUES (7704,17092953);
INSERT INTO `instance_entities` VALUES (7704,17092954);
INSERT INTO `instance_entities` VALUES (7704,17092955);
INSERT INTO `instance_entities` VALUES (7704,17092956);
INSERT INTO `instance_entities` VALUES (7704,17092957);
INSERT INTO `instance_entities` VALUES (7704,17092958);
INSERT INTO `instance_entities` VALUES (7704,17092959);
INSERT INTO `instance_entities` VALUES (7704,17092960);
INSERT INTO `instance_entities` VALUES (7704,17092961);
INSERT INTO `instance_entities` VALUES (7704,17092962);
INSERT INTO `instance_entities` VALUES (7704,17092963);
INSERT INTO `instance_entities` VALUES (7704,17092964);
INSERT INTO `instance_entities` VALUES (7704,17092965);
INSERT INTO `instance_entities` VALUES (7704,17092966);
INSERT INTO `instance_entities` VALUES (7704,17092967);
INSERT INTO `instance_entities` VALUES (7704,17092968);
INSERT INTO `instance_entities` VALUES (7704,17092969);
INSERT INTO `instance_entities` VALUES (7704,17092970);
INSERT INTO `instance_entities` VALUES (7704,17092971);
INSERT INTO `instance_entities` VALUES (7704,17092972);
INSERT INTO `instance_entities` VALUES (7704,17092973);
INSERT INTO `instance_entities` VALUES (7704,17092974);
INSERT INTO `instance_entities` VALUES (7704,17092975);
INSERT INTO `instance_entities` VALUES (7704,17092976);
INSERT INTO `instance_entities` VALUES (7704,17092977);
INSERT INTO `instance_entities` VALUES (7704,17092978);
INSERT INTO `instance_entities` VALUES (7704,17092979);
INSERT INTO `instance_entities` VALUES (7704,17092980);
INSERT INTO `instance_entities` VALUES (7704,17092981);
INSERT INTO `instance_entities` VALUES (7704,17092982);
INSERT INTO `instance_entities` VALUES (7704,17092983);
INSERT INTO `instance_entities` VALUES (7704,17092984);
INSERT INTO `instance_entities` VALUES (7704,17092985);
INSERT INTO `instance_entities` VALUES (7704,17092986);
INSERT INTO `instance_entities` VALUES (7704,17092987);
INSERT INTO `instance_entities` VALUES (7704,17092988);
INSERT INTO `instance_entities` VALUES (7704,17092989);
INSERT INTO `instance_entities` VALUES (7704,17092990);
INSERT INTO `instance_entities` VALUES (7704,17092991);
INSERT INTO `instance_entities` VALUES (7704,17092992);
INSERT INTO `instance_entities` VALUES (7704,17092993);
INSERT INTO `instance_entities` VALUES (7704,17092994);
INSERT INTO `instance_entities` VALUES (7704,17092995);
INSERT INTO `instance_entities` VALUES (7704,17092996);
INSERT INTO `instance_entities` VALUES (7704,17092997);
INSERT INTO `instance_entities` VALUES (7704,17092998);
INSERT INTO `instance_entities` VALUES (7704,17092999);
INSERT INTO `instance_entities` VALUES (7704,17093000);
INSERT INTO `instance_entities` VALUES (7704,17093001);
INSERT INTO `instance_entities` VALUES (7704,17093002);
INSERT INTO `instance_entities` VALUES (7704,17093003);
INSERT INTO `instance_entities` VALUES (7704,17093004);
INSERT INTO `instance_entities` VALUES (7704,17093005);
INSERT INTO `instance_entities` VALUES (7704,17093006);
INSERT INTO `instance_entities` VALUES (7704,17093007);
INSERT INTO `instance_entities` VALUES (7704,17093008);
INSERT INTO `instance_entities` VALUES (7704,17093009);
INSERT INTO `instance_entities` VALUES (7704,17093010);
INSERT INTO `instance_entities` VALUES (7704,17093011);
INSERT INTO `instance_entities` VALUES (7704,17093012);
INSERT INTO `instance_entities` VALUES (7704,17093013);
INSERT INTO `instance_entities` VALUES (7704,17093014);
INSERT INTO `instance_entities` VALUES (7704,17093015);
INSERT INTO `instance_entities` VALUES (7704,17093016);
INSERT INTO `instance_entities` VALUES (7704,17093017);
INSERT INTO `instance_entities` VALUES (7704,17093018);
INSERT INTO `instance_entities` VALUES (7704,17093019);
INSERT INTO `instance_entities` VALUES (7704,17093020);
INSERT INTO `instance_entities` VALUES (7704,17093021);
INSERT INTO `instance_entities` VALUES (7704,17093022);
INSERT INTO `instance_entities` VALUES (7704,17093023);
INSERT INTO `instance_entities` VALUES (7704,17093024);
INSERT INTO `instance_entities` VALUES (7704,17093025);
INSERT INTO `instance_entities` VALUES (7704,17093026);
INSERT INTO `instance_entities` VALUES (7704,17093027);
INSERT INTO `instance_entities` VALUES (7704,17093028);
INSERT INTO `instance_entities` VALUES (7704,17093029);
INSERT INTO `instance_entities` VALUES (7704,17093030);
INSERT INTO `instance_entities` VALUES (7704,17093031);
INSERT INTO `instance_entities` VALUES (7704,17093032);
INSERT INTO `instance_entities` VALUES (7704,17093034);
INSERT INTO `instance_entities` VALUES (7704,17093035);
INSERT INTO `instance_entities` VALUES (7704,17093036);
INSERT INTO `instance_entities` VALUES (7704,17093037);
INSERT INTO `instance_entities` VALUES (7704,17093038);
INSERT INTO `instance_entities` VALUES (7704,17093039);
INSERT INTO `instance_entities` VALUES (7704,17093040);
INSERT INTO `instance_entities` VALUES (7704,17093041);
INSERT INTO `instance_entities` VALUES (7704,17093042);
INSERT INTO `instance_entities` VALUES (7704,17093043);
INSERT INTO `instance_entities` VALUES (7704,17093044);
INSERT INTO `instance_entities` VALUES (7704,17093045);
INSERT INTO `instance_entities` VALUES (7704,17093046);
INSERT INTO `instance_entities` VALUES (7704,17093047);
INSERT INTO `instance_entities` VALUES (7704,17093048);
INSERT INTO `instance_entities` VALUES (7704,17093049);
INSERT INTO `instance_entities` VALUES (7704,17093050);
INSERT INTO `instance_entities` VALUES (7704,17093051);
INSERT INTO `instance_entities` VALUES (7704,17093052);
INSERT INTO `instance_entities` VALUES (7704,17093053);
INSERT INTO `instance_entities` VALUES (7704,17093054);
INSERT INTO `instance_entities` VALUES (7704,17093055);
INSERT INTO `instance_entities` VALUES (7704,17093056);
INSERT INTO `instance_entities` VALUES (7704,17093057);
INSERT INTO `instance_entities` VALUES (7704,17093058);
INSERT INTO `instance_entities` VALUES (7704,17093059);
INSERT INTO `instance_entities` VALUES (7704,17093060);
INSERT INTO `instance_entities` VALUES (7704,17093061);
INSERT INTO `instance_entities` VALUES (7704,17093062);
INSERT INTO `instance_entities` VALUES (7704,17093063);
INSERT INTO `instance_entities` VALUES (7704,17093064);
INSERT INTO `instance_entities` VALUES (7704,17093065);
INSERT INTO `instance_entities` VALUES (7704,17093066);
INSERT INTO `instance_entities` VALUES (7704,17093067);
INSERT INTO `instance_entities` VALUES (7704,17093068);
INSERT INTO `instance_entities` VALUES (7704,17093069);
INSERT INTO `instance_entities` VALUES (7704,17093070);
INSERT INTO `instance_entities` VALUES (7704,17093071);
INSERT INTO `instance_entities` VALUES (7704,17093072);
INSERT INTO `instance_entities` VALUES (7704,17093073);
INSERT INTO `instance_entities` VALUES (7704,17093074);
INSERT INTO `instance_entities` VALUES (7704,17093075);
INSERT INTO `instance_entities` VALUES (7704,17093076);
INSERT INTO `instance_entities` VALUES (7704,17093077);
INSERT INTO `instance_entities` VALUES (7704,17093078);
INSERT INTO `instance_entities` VALUES (7704,17093079);
INSERT INTO `instance_entities` VALUES (7704,17093080);
INSERT INTO `instance_entities` VALUES (7704,17093081);
INSERT INTO `instance_entities` VALUES (7704,17093082);
INSERT INTO `instance_entities` VALUES (7704,17093083);
INSERT INTO `instance_entities` VALUES (7704,17093084);
INSERT INTO `instance_entities` VALUES (7704,17093085);
INSERT INTO `instance_entities` VALUES (7704,17093086);
INSERT INTO `instance_entities` VALUES (7704,17093087);
INSERT INTO `instance_entities` VALUES (7704,17093088);
INSERT INTO `instance_entities` VALUES (7704,17093089);
INSERT INTO `instance_entities` VALUES (7704,17093090);
INSERT INTO `instance_entities` VALUES (7704,17093091);
INSERT INTO `instance_entities` VALUES (7704,17093092);
INSERT INTO `instance_entities` VALUES (7704,17093093);
INSERT INTO `instance_entities` VALUES (7704,17093094);
INSERT INTO `instance_entities` VALUES (7704,17093095);
INSERT INTO `instance_entities` VALUES (7704,17093096);
INSERT INTO `instance_entities` VALUES (7704,17093097);
INSERT INTO `instance_entities` VALUES (7704,17093098);
INSERT INTO `instance_entities` VALUES (7704,17093099);
INSERT INTO `instance_entities` VALUES (7704,17093100);
INSERT INTO `instance_entities` VALUES (7704,17093101);
INSERT INTO `instance_entities` VALUES (7704,17093102);
INSERT INTO `instance_entities` VALUES (7704,17093103);
INSERT INTO `instance_entities` VALUES (7704,17093104);

-- Light in the Darkness (9300)
-- mobs
INSERT INTO `instance_entities` VALUES (9300,17158192); -- Sapphirine Quadav
INSERT INTO `instance_entities` VALUES (9300,17158193); -- Sapphirine Quadav
INSERT INTO `instance_entities` VALUES (9300,17158194); -- Sapphirine Quadav
INSERT INTO `instance_entities` VALUES (9300,17158195); -- Sapphirine Quadav
INSERT INTO `instance_entities` VALUES (9300,17158196); -- Sapphirine Quadav
INSERT INTO `instance_entities` VALUES (9300,17158197); -- Sapphirine Quadav
INSERT INTO `instance_entities` VALUES (9300,17158198); -- Sapphirine Quadav
INSERT INTO `instance_entities` VALUES (9300,17158199); -- Sapphirine Quadav
INSERT INTO `instance_entities` VALUES (9300,17158200); -- Sapphirine Quadav
INSERT INTO `instance_entities` VALUES (9300,17158201); -- Sapphire Quadav
-- npcs
INSERT INTO `instance_entities` VALUES (9300,17158387); -- Volker
INSERT INTO `instance_entities` VALUES (9300,17158388); -- csnpc
INSERT INTO `instance_entities` VALUES (9300,17158389); -- csnpc
INSERT INTO `instance_entities` VALUES (9300,17158390); -- csnpc
INSERT INTO `instance_entities` VALUES (9300,17158391); -- csnpc
INSERT INTO `instance_entities` VALUES (9300,17158392); -- csnpc
INSERT INTO `instance_entities` VALUES (9300,17158393); -- csnpc
INSERT INTO `instance_entities` VALUES (9300,17158394); -- csnpc
INSERT INTO `instance_entities` VALUES (9300,17158395); -- csnpc
INSERT INTO `instance_entities` VALUES (9300,17158396); -- csnpc
INSERT INTO `instance_entities` VALUES (9300,17158397); -- csnpc

-- Behind the Sluices (25900)
INSERT INTO `instance_entities` VALUES (25900, 17838146); -- Arciela
INSERT INTO `instance_entities` VALUES (25900, 17838147); -- The Keeper
INSERT INTO `instance_entities` VALUES (25900, 17838148); -- Mistdagger
INSERT INTO `instance_entities` VALUES (25900, 17838149); -- The Briars (elv)
INSERT INTO `instance_entities` VALUES (25900, 17838150); -- The Briars (gal)

-- Ambuscade
-- mobs
INSERT INTO `instance_entities` VALUES (30000,17952867);

/*!40000 ALTER TABLE `instance_entities` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
