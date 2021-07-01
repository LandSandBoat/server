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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
INSERT INTO `instance_entities` VALUES (5500,17002731);
INSERT INTO `instance_entities` VALUES (5500,17002752);
INSERT INTO `instance_entities` VALUES (5500,17002753);

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
INSERT INTO `instance_entities` VALUES (5502,17002730);
INSERT INTO `instance_entities` VALUES (5502,17002745);
INSERT INTO `instance_entities` VALUES (5502,17002747);
INSERT INTO `instance_entities` VALUES (5502,17002754);
INSERT INTO `instance_entities` VALUES (5502,17002654);
INSERT INTO `instance_entities` VALUES (5502,17002655);

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
INSERT INTO `instance_entities` VALUES (5601,17006848);
INSERT INTO `instance_entities` VALUES (5601,17006852);
INSERT INTO `instance_entities` VALUES (5601,17006868);
INSERT INTO `instance_entities` VALUES (5601,17006870);
INSERT INTO `instance_entities` VALUES (5601,17006872);
INSERT INTO `instance_entities` VALUES (5601,17006874);

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
INSERT INTO `instance_entities` VALUES (6300,17035512);
INSERT INTO `instance_entities` VALUES (6300,17035517);
INSERT INTO `instance_entities` VALUES (6300,17035520);
INSERT INTO `instance_entities` VALUES (6300,17035526);
INSERT INTO `instance_entities` VALUES (6300,17035527);
INSERT INTO `instance_entities` VALUES (6300,17035537);
INSERT INTO `instance_entities` VALUES (6300,17035538);
INSERT INTO `instance_entities` VALUES (6300,17035539);
INSERT INTO `instance_entities` VALUES (6300,17035540);
INSERT INTO `instance_entities` VALUES (6300,17035541);
INSERT INTO `instance_entities` VALUES (6300,17035552);
INSERT INTO `instance_entities` VALUES (6300,17035554);

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
INSERT INTO `instance_entities` VALUES (6900,17060146);
INSERT INTO `instance_entities` VALUES (6900,17060147);

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
