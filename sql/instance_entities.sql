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
  `instanceid` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`instanceid`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instance_entities`
--

LOCK TABLES `instance_entities` WRITE;
/*!40000 ALTER TABLE `instance_entities` DISABLE KEYS */;
-- Leujaoam Cleansing
-- Mobs
INSERT INTO `instance_entities` VALUES (1,17059841);
INSERT INTO `instance_entities` VALUES (1,17059842);
INSERT INTO `instance_entities` VALUES (1,17059843);
INSERT INTO `instance_entities` VALUES (1,17059844);
INSERT INTO `instance_entities` VALUES (1,17059845);
INSERT INTO `instance_entities` VALUES (1,17059846);
INSERT INTO `instance_entities` VALUES (1,17059847);
INSERT INTO `instance_entities` VALUES (1,17059848);
INSERT INTO `instance_entities` VALUES (1,17059849);
INSERT INTO `instance_entities` VALUES (1,17059850);
INSERT INTO `instance_entities` VALUES (1,17059851);
INSERT INTO `instance_entities` VALUES (1,17059852);
INSERT INTO `instance_entities` VALUES (1,17059853);
INSERT INTO `instance_entities` VALUES (1,17059854);
INSERT INTO `instance_entities` VALUES (1,17059855);
-- Npcs
INSERT INTO `instance_entities` VALUES (1,17060014);
INSERT INTO `instance_entities` VALUES (1,17060015);
INSERT INTO `instance_entities` VALUES (1,17060138);
INSERT INTO `instance_entities` VALUES (1,17060146);
INSERT INTO `instance_entities` VALUES (1,17060147);

-- Preemtive Strike
-- Mobs
INSERT INTO `instance_entities` VALUES (12, 17047570);
INSERT INTO `instance_entities` VALUES (12, 17047571);
INSERT INTO `instance_entities` VALUES (12, 17047572);
INSERT INTO `instance_entities` VALUES (12, 17047573);
INSERT INTO `instance_entities` VALUES (12, 17047574);
INSERT INTO `instance_entities` VALUES (12, 17047575);
INSERT INTO `instance_entities` VALUES (12, 17047576);
INSERT INTO `instance_entities` VALUES (12, 17047577);
INSERT INTO `instance_entities` VALUES (12, 17047578);
INSERT INTO `instance_entities` VALUES (12, 17047579);
INSERT INTO `instance_entities` VALUES (12, 17047580);
INSERT INTO `instance_entities` VALUES (12, 17047581);
INSERT INTO `instance_entities` VALUES (12, 17047582);
INSERT INTO `instance_entities` VALUES (12, 17047583);
INSERT INTO `instance_entities` VALUES (12, 17047584);
INSERT INTO `instance_entities` VALUES (12, 17047585);
INSERT INTO `instance_entities` VALUES (12, 17047586);
INSERT INTO `instance_entities` VALUES (12, 17047587);
INSERT INTO `instance_entities` VALUES (12, 17047588);
INSERT INTO `instance_entities` VALUES (12, 17047589);
-- Npcs
INSERT INTO `instance_entities` VALUES (12, 17047808);
INSERT INTO `instance_entities` VALUES (12, 17047809);

-- Excavation Duty
-- Mobs
INSERT INTO `instance_entities` VALUES (21,17035265);
INSERT INTO `instance_entities` VALUES (21,17035266);
INSERT INTO `instance_entities` VALUES (21,17035267);
INSERT INTO `instance_entities` VALUES (21,17035268);
INSERT INTO `instance_entities` VALUES (21,17035269);
INSERT INTO `instance_entities` VALUES (21,17035270);
INSERT INTO `instance_entities` VALUES (21,17035271);
INSERT INTO `instance_entities` VALUES (21,17035272);
INSERT INTO `instance_entities` VALUES (21,17035273);
INSERT INTO `instance_entities` VALUES (21,17035274);
INSERT INTO `instance_entities` VALUES (21,17035275);
INSERT INTO `instance_entities` VALUES (21,17035276);
INSERT INTO `instance_entities` VALUES (21,17035277);
INSERT INTO `instance_entities` VALUES (21,17035278);
INSERT INTO `instance_entities` VALUES (21,17035279);
INSERT INTO `instance_entities` VALUES (21,17035280);
INSERT INTO `instance_entities` VALUES (21,17035281);
INSERT INTO `instance_entities` VALUES (21,17035282);
INSERT INTO `instance_entities` VALUES (21,17035283);
INSERT INTO `instance_entities` VALUES (21,17035284);
INSERT INTO `instance_entities` VALUES (21,17035285);
INSERT INTO `instance_entities` VALUES (21,17035286);
INSERT INTO `instance_entities` VALUES (21,17035287);
INSERT INTO `instance_entities` VALUES (21,17035288);
INSERT INTO `instance_entities` VALUES (21,17035289);
INSERT INTO `instance_entities` VALUES (21,17035290);
INSERT INTO `instance_entities` VALUES (21,17035291);
-- npcs
INSERT INTO `instance_entities` VALUES (21,17035478);
INSERT INTO `instance_entities` VALUES (21,17035479);
INSERT INTO `instance_entities` VALUES (21,17035512);
INSERT INTO `instance_entities` VALUES (21,17035517);
INSERT INTO `instance_entities` VALUES (21,17035520);
INSERT INTO `instance_entities` VALUES (21,17035526);
INSERT INTO `instance_entities` VALUES (21,17035527);
INSERT INTO `instance_entities` VALUES (21,17035537);
INSERT INTO `instance_entities` VALUES (21,17035538);
INSERT INTO `instance_entities` VALUES (21,17035539);
INSERT INTO `instance_entities` VALUES (21,17035540);
INSERT INTO `instance_entities` VALUES (21,17035541);
INSERT INTO `instance_entities` VALUES (21,17035552);
INSERT INTO `instance_entities` VALUES (21,17035554);

-- Troll Fugitives
-- Mobs
INSERT INTO `instance_entities` VALUES (23,17035310);
INSERT INTO `instance_entities` VALUES (23,17035311);
INSERT INTO `instance_entities` VALUES (23,17035312);
INSERT INTO `instance_entities` VALUES (23,17035313);
INSERT INTO `instance_entities` VALUES (23,17035314);
INSERT INTO `instance_entities` VALUES (23,17035315);
INSERT INTO `instance_entities` VALUES (23,17035316);
INSERT INTO `instance_entities` VALUES (23,17035317);
INSERT INTO `instance_entities` VALUES (23,17035318);
INSERT INTO `instance_entities` VALUES (23,17035319);
INSERT INTO `instance_entities` VALUES (23,17035320);
INSERT INTO `instance_entities` VALUES (23,17035321);
INSERT INTO `instance_entities` VALUES (23,17035322);
INSERT INTO `instance_entities` VALUES (23,17035323);
INSERT INTO `instance_entities` VALUES (23,17035324);
-- Npcs
INSERT INTO `instance_entities` VALUES (23,17035478);
INSERT INTO `instance_entities` VALUES (23,17035479);

-- Wamoura Farm Raid
INSERT INTO `instance_entities` VALUES (27,17035359);
INSERT INTO `instance_entities` VALUES (27,17035360);
INSERT INTO `instance_entities` VALUES (27,17035361);
INSERT INTO `instance_entities` VALUES (27,17035362);
INSERT INTO `instance_entities` VALUES (27,17035363);
INSERT INTO `instance_entities` VALUES (27,17035365);
INSERT INTO `instance_entities` VALUES (27,17035367);
INSERT INTO `instance_entities` VALUES (27,17035368);
INSERT INTO `instance_entities` VALUES (27,17035369);
INSERT INTO `instance_entities` VALUES (27,17035370);
INSERT INTO `instance_entities` VALUES (27,17035371);
INSERT INTO `instance_entities` VALUES (27,17035372);
INSERT INTO `instance_entities` VALUES (27,17035376);
INSERT INTO `instance_entities` VALUES (27,17035377);
INSERT INTO `instance_entities` VALUES (27,17035378);
INSERT INTO `instance_entities` VALUES (27,17035478);
INSERT INTO `instance_entities` VALUES (27,17035479);
INSERT INTO `instance_entities` VALUES (27,17035508);
INSERT INTO `instance_entities` VALUES (27,17035538);
INSERT INTO `instance_entities` VALUES (27,17035539);
INSERT INTO `instance_entities` VALUES (27,17035541);
INSERT INTO `instance_entities` VALUES (27,17035542);
INSERT INTO `instance_entities` VALUES (27,17035543);
INSERT INTO `instance_entities` VALUES (27,17035544);
INSERT INTO `instance_entities` VALUES (27,17035545);
INSERT INTO `instance_entities` VALUES (27,17035546);

-- Seagull Grounded
-- Mobs
INSERT INTO `instance_entities` VALUES (31,17006593);
INSERT INTO `instance_entities` VALUES (31,17006594);
INSERT INTO `instance_entities` VALUES (31,17006595);
INSERT INTO `instance_entities` VALUES (31,17006596);
INSERT INTO `instance_entities` VALUES (31,17006597);
INSERT INTO `instance_entities` VALUES (31,17006598);
INSERT INTO `instance_entities` VALUES (31,17006599);
INSERT INTO `instance_entities` VALUES (31,17006600);
INSERT INTO `instance_entities` VALUES (31,17006601);
INSERT INTO `instance_entities` VALUES (31,17006602);
INSERT INTO `instance_entities` VALUES (31,17006603);
INSERT INTO `instance_entities` VALUES (31,17006604);
INSERT INTO `instance_entities` VALUES (31,17006605);
INSERT INTO `instance_entities` VALUES (31,17006606);
INSERT INTO `instance_entities` VALUES (31,17006607);
INSERT INTO `instance_entities` VALUES (31,17006608);
INSERT INTO `instance_entities` VALUES (31,17006610);
INSERT INTO `instance_entities` VALUES (31,17006611);
-- Npcs
INSERT INTO `instance_entities` VALUES (31,17006809);
INSERT INTO `instance_entities` VALUES (31,17006810);
INSERT INTO `instance_entities` VALUES (31,17006836);
INSERT INTO `instance_entities` VALUES (31,17006841);
INSERT INTO `instance_entities` VALUES (31,17006842);
INSERT INTO `instance_entities` VALUES (31,17006843);
INSERT INTO `instance_entities` VALUES (31,17006848);
INSERT INTO `instance_entities` VALUES (31,17006852);
INSERT INTO `instance_entities` VALUES (31,17006868);
INSERT INTO `instance_entities` VALUES (31,17006870);
INSERT INTO `instance_entities` VALUES (31,17006872);
INSERT INTO `instance_entities` VALUES (31,17006874);

-- Requiem
-- mobs
INSERT INTO `instance_entities` VALUES (32,17006612);
INSERT INTO `instance_entities` VALUES (32,17006613);
INSERT INTO `instance_entities` VALUES (32,17006614);
INSERT INTO `instance_entities` VALUES (32,17006615);
INSERT INTO `instance_entities` VALUES (32,17006616);
INSERT INTO `instance_entities` VALUES (32,17006617);
INSERT INTO `instance_entities` VALUES (32,17006618);
INSERT INTO `instance_entities` VALUES (32,17006619);
INSERT INTO `instance_entities` VALUES (32,17006620);
INSERT INTO `instance_entities` VALUES (32,17006621);
INSERT INTO `instance_entities` VALUES (32,17006622);
INSERT INTO `instance_entities` VALUES (32,17006623);
INSERT INTO `instance_entities` VALUES (32,17006624);
INSERT INTO `instance_entities` VALUES (32,17006625);
INSERT INTO `instance_entities` VALUES (32,17006626);
INSERT INTO `instance_entities` VALUES (32,17006627);
INSERT INTO `instance_entities` VALUES (32,17006628);
INSERT INTO `instance_entities` VALUES (32,17006629);
INSERT INTO `instance_entities` VALUES (32,17006630);
INSERT INTO `instance_entities` VALUES (32,17006631);
INSERT INTO `instance_entities` VALUES (32,17006632);
INSERT INTO `instance_entities` VALUES (32,17006633);
INSERT INTO `instance_entities` VALUES (32,17006634);
-- npcs
INSERT INTO `instance_entities` VALUES (32,17006809);
INSERT INTO `instance_entities` VALUES (32,17006810);
-- Golden Salvage
-- mobs
INSERT INTO `instance_entities` VALUES (41,17002497);
INSERT INTO `instance_entities` VALUES (41,17002498);
INSERT INTO `instance_entities` VALUES (41,17002499);
INSERT INTO `instance_entities` VALUES (41,17002500);
INSERT INTO `instance_entities` VALUES (41,17002501);
INSERT INTO `instance_entities` VALUES (41,17002502);
INSERT INTO `instance_entities` VALUES (41,17002503);
INSERT INTO `instance_entities` VALUES (41,17002504);
INSERT INTO `instance_entities` VALUES (41,17002505);
INSERT INTO `instance_entities` VALUES (41,17002506);
INSERT INTO `instance_entities` VALUES (41,17002507);
INSERT INTO `instance_entities` VALUES (41,17002508);
INSERT INTO `instance_entities` VALUES (41,17002509);
INSERT INTO `instance_entities` VALUES (41,17002510);
INSERT INTO `instance_entities` VALUES (41,17002511);
INSERT INTO `instance_entities` VALUES (41,17002512);
INSERT INTO `instance_entities` VALUES (41,17002513);
INSERT INTO `instance_entities` VALUES (41,17002514);
INSERT INTO `instance_entities` VALUES (41,17002515);
INSERT INTO `instance_entities` VALUES (41,17002516);
-- npc
INSERT INTO `instance_entities` VALUES (41,17002654);
INSERT INTO `instance_entities` VALUES (41,17002655);
INSERT INTO `instance_entities` VALUES (41,17002731);
INSERT INTO `instance_entities` VALUES (41,17002752);
INSERT INTO `instance_entities` VALUES (41,17002753);

-- Extermination
-- mobs
INSERT INTO `instance_entities` VALUES (43,17002521);
INSERT INTO `instance_entities` VALUES (43,17002522);
INSERT INTO `instance_entities` VALUES (43,17002523);
INSERT INTO `instance_entities` VALUES (43,17002524);
INSERT INTO `instance_entities` VALUES (43,17002525);
INSERT INTO `instance_entities` VALUES (43,17002526);
INSERT INTO `instance_entities` VALUES (43,17002527);
INSERT INTO `instance_entities` VALUES (43,17002528);
INSERT INTO `instance_entities` VALUES (43,17002529);
INSERT INTO `instance_entities` VALUES (43,17002530);
INSERT INTO `instance_entities` VALUES (43,17002531);
INSERT INTO `instance_entities` VALUES (43,17002532);
INSERT INTO `instance_entities` VALUES (43,17002533);
INSERT INTO `instance_entities` VALUES (43,17002534);
INSERT INTO `instance_entities` VALUES (43,17002535);
INSERT INTO `instance_entities` VALUES (43,17002536);
INSERT INTO `instance_entities` VALUES (43,17002537);
INSERT INTO `instance_entities` VALUES (43,17002538);
INSERT INTO `instance_entities` VALUES (43,17002539);
INSERT INTO `instance_entities` VALUES (43,17002540);
INSERT INTO `instance_entities` VALUES (43,17002541);
INSERT INTO `instance_entities` VALUES (43,17002542);
INSERT INTO `instance_entities` VALUES (43,17002543);
INSERT INTO `instance_entities` VALUES (43,17002544);
-- npc
INSERT INTO `instance_entities` VALUES (43,17002730);
INSERT INTO `instance_entities` VALUES (43,17002745);
INSERT INTO `instance_entities` VALUES (43,17002747);
INSERT INTO `instance_entities` VALUES (43,17002754);
INSERT INTO `instance_entities` VALUES (43,17002654);
INSERT INTO `instance_entities` VALUES (43,17002655);

-- Ashu Talif
-- npc
INSERT INTO `instance_entities` VALUES (53,17022979);
-- mobs
INSERT INTO `instance_entities` VALUES (53,17022980);
INSERT INTO `instance_entities` VALUES (53,17022981);
INSERT INTO `instance_entities` VALUES (53,17022982);
INSERT INTO `instance_entities` VALUES (53,17022983);
INSERT INTO `instance_entities` VALUES (53,17022984);

INSERT INTO `instance_entities` VALUES (53,17022985);
INSERT INTO `instance_entities` VALUES (53,17022986);
INSERT INTO `instance_entities` VALUES (53,17022987);
INSERT INTO `instance_entities` VALUES (53,17022988);
INSERT INTO `instance_entities` VALUES (53,17022989);

-- Against All Odds COR AF2
INSERT INTO `instance_entities` VALUES (54,17022977);
INSERT INTO `instance_entities` VALUES (54,17022978);

-- Path of Darkness
-- mobs
INSERT INTO `instance_entities` VALUES (58,17093132);
INSERT INTO `instance_entities` VALUES (58,17093133);
INSERT INTO `instance_entities` VALUES (58,17093134);
INSERT INTO `instance_entities` VALUES (58,17093135);
INSERT INTO `instance_entities` VALUES (58,17093136);
INSERT INTO `instance_entities` VALUES (58,17093137);
INSERT INTO `instance_entities` VALUES (58,17093142);
-- npc
INSERT INTO `instance_entities` VALUES (58,17093359);
INSERT INTO `instance_entities` VALUES (58,17093361);
INSERT INTO `instance_entities` VALUES (58,17093423);

-- Nashmeira's Plea
-- mobs
INSERT INTO `instance_entities` VALUES (59,17093143);
INSERT INTO `instance_entities` VALUES (59,17093144);
INSERT INTO `instance_entities` VALUES (59,17093145);

-- npc
INSERT INTO `instance_entities` VALUES (59,17093423);
INSERT INTO `instance_entities` VALUES (59,17093472);
INSERT INTO `instance_entities` VALUES (59,17093473);
INSERT INTO `instance_entities` VALUES (59,17093474);
INSERT INTO `instance_entities` VALUES (59,17093475);
INSERT INTO `instance_entities` VALUES (59,17093476);
INSERT INTO `instance_entities` VALUES (59,17093477);
INSERT INTO `instance_entities` VALUES (59,17093478);
INSERT INTO `instance_entities` VALUES (59,17093479);
INSERT INTO `instance_entities` VALUES (59,17093480);
INSERT INTO `instance_entities` VALUES (59,17093481);
INSERT INTO `instance_entities` VALUES (59,17093482);

-- Arrapago Remnants
-- npc
INSERT INTO `instance_entities` VALUES (65,17080598);
INSERT INTO `instance_entities` VALUES (65,17080970);
INSERT INTO `instance_entities` VALUES (65,17080971);
INSERT INTO `instance_entities` VALUES (65,17080972);
INSERT INTO `instance_entities` VALUES (65,17080973);
INSERT INTO `instance_entities` VALUES (65,17080974);
INSERT INTO `instance_entities` VALUES (65,17080975);
INSERT INTO `instance_entities` VALUES (65,17080976);
INSERT INTO `instance_entities` VALUES (65,17080977);
INSERT INTO `instance_entities` VALUES (65,17080978);
INSERT INTO `instance_entities` VALUES (65,17080979);
INSERT INTO `instance_entities` VALUES (65,17080980);
INSERT INTO `instance_entities` VALUES (65,17080981);
INSERT INTO `instance_entities` VALUES (65,17080982);
INSERT INTO `instance_entities` VALUES (65,17080983);
INSERT INTO `instance_entities` VALUES (65,17080984);
INSERT INTO `instance_entities` VALUES (65,17080985);
INSERT INTO `instance_entities` VALUES (65,17080986);
INSERT INTO `instance_entities` VALUES (65,17080987);
INSERT INTO `instance_entities` VALUES (65,17080988);
INSERT INTO `instance_entities` VALUES (65,17080989);
INSERT INTO `instance_entities` VALUES (65,17080990);
INSERT INTO `instance_entities` VALUES (65,17080991);
INSERT INTO `instance_entities` VALUES (65,17080992);
INSERT INTO `instance_entities` VALUES (65,17080993);

-- mobs
INSERT INTO `instance_entities` VALUES (65,17080321);
INSERT INTO `instance_entities` VALUES (65,17080322);
INSERT INTO `instance_entities` VALUES (65,17080323);
INSERT INTO `instance_entities` VALUES (65,17080324);
INSERT INTO `instance_entities` VALUES (65,17080325);
INSERT INTO `instance_entities` VALUES (65,17080326);
INSERT INTO `instance_entities` VALUES (65,17080327);
INSERT INTO `instance_entities` VALUES (65,17080328);
INSERT INTO `instance_entities` VALUES (65,17080329);
INSERT INTO `instance_entities` VALUES (65,17080330);
INSERT INTO `instance_entities` VALUES (65,17080331);
INSERT INTO `instance_entities` VALUES (65,17080332);
INSERT INTO `instance_entities` VALUES (65,17080333);
INSERT INTO `instance_entities` VALUES (65,17080334);
INSERT INTO `instance_entities` VALUES (65,17080335);
INSERT INTO `instance_entities` VALUES (65,17080336);
INSERT INTO `instance_entities` VALUES (65,17080337);
INSERT INTO `instance_entities` VALUES (65,17080338);
INSERT INTO `instance_entities` VALUES (65,17080339);
INSERT INTO `instance_entities` VALUES (65,17080340);
INSERT INTO `instance_entities` VALUES (65,17080341);
INSERT INTO `instance_entities` VALUES (65,17080342);
INSERT INTO `instance_entities` VALUES (65,17080343);
INSERT INTO `instance_entities` VALUES (65,17080344);
INSERT INTO `instance_entities` VALUES (65,17080345);
INSERT INTO `instance_entities` VALUES (65,17080346);
INSERT INTO `instance_entities` VALUES (65,17080347);
INSERT INTO `instance_entities` VALUES (65,17080348);
INSERT INTO `instance_entities` VALUES (65,17080349);
INSERT INTO `instance_entities` VALUES (65,17080350);
INSERT INTO `instance_entities` VALUES (65,17080351);
INSERT INTO `instance_entities` VALUES (65,17080352);
INSERT INTO `instance_entities` VALUES (65,17080353);
INSERT INTO `instance_entities` VALUES (65,17080354);
INSERT INTO `instance_entities` VALUES (65,17080355);
INSERT INTO `instance_entities` VALUES (65,17080356);
INSERT INTO `instance_entities` VALUES (65,17080357);
INSERT INTO `instance_entities` VALUES (65,17080358);
INSERT INTO `instance_entities` VALUES (65,17080359);
INSERT INTO `instance_entities` VALUES (65,17080360);
INSERT INTO `instance_entities` VALUES (65,17080361);
INSERT INTO `instance_entities` VALUES (65,17080362);
INSERT INTO `instance_entities` VALUES (65,17080363);
INSERT INTO `instance_entities` VALUES (65,17080364);
INSERT INTO `instance_entities` VALUES (65,17080365);
INSERT INTO `instance_entities` VALUES (65,17080366);
INSERT INTO `instance_entities` VALUES (65,17080367);
INSERT INTO `instance_entities` VALUES (65,17080368);
INSERT INTO `instance_entities` VALUES (65,17080369);
INSERT INTO `instance_entities` VALUES (65,17080370);
INSERT INTO `instance_entities` VALUES (65,17080371);
INSERT INTO `instance_entities` VALUES (65,17080372);
INSERT INTO `instance_entities` VALUES (65,17080373);
INSERT INTO `instance_entities` VALUES (65,17080374);
INSERT INTO `instance_entities` VALUES (65,17080375);
INSERT INTO `instance_entities` VALUES (65,17080376);
INSERT INTO `instance_entities` VALUES (65,17080377);
INSERT INTO `instance_entities` VALUES (65,17080378);
INSERT INTO `instance_entities` VALUES (65,17080379);
INSERT INTO `instance_entities` VALUES (65,17080380);
INSERT INTO `instance_entities` VALUES (65,17080381);
INSERT INTO `instance_entities` VALUES (65,17080382);
INSERT INTO `instance_entities` VALUES (65,17080383);
INSERT INTO `instance_entities` VALUES (65,17080384);
INSERT INTO `instance_entities` VALUES (65,17080385);
INSERT INTO `instance_entities` VALUES (65,17080386);
INSERT INTO `instance_entities` VALUES (65,17080387);
INSERT INTO `instance_entities` VALUES (65,17080388);
INSERT INTO `instance_entities` VALUES (65,17080389);
INSERT INTO `instance_entities` VALUES (65,17080390);
INSERT INTO `instance_entities` VALUES (65,17080391);
INSERT INTO `instance_entities` VALUES (65,17080392);
INSERT INTO `instance_entities` VALUES (65,17080393);
INSERT INTO `instance_entities` VALUES (65,17080394);
INSERT INTO `instance_entities` VALUES (65,17080395);
INSERT INTO `instance_entities` VALUES (65,17080396);
INSERT INTO `instance_entities` VALUES (65,17080397);
INSERT INTO `instance_entities` VALUES (65,17080398);
INSERT INTO `instance_entities` VALUES (65,17080399);
INSERT INTO `instance_entities` VALUES (65,17080400);
INSERT INTO `instance_entities` VALUES (65,17080401);
INSERT INTO `instance_entities` VALUES (65,17080402);
INSERT INTO `instance_entities` VALUES (65,17080403);
INSERT INTO `instance_entities` VALUES (65,17080404);
INSERT INTO `instance_entities` VALUES (65,17080405);
INSERT INTO `instance_entities` VALUES (65,17080406);
INSERT INTO `instance_entities` VALUES (65,17080407);
INSERT INTO `instance_entities` VALUES (65,17080408);
INSERT INTO `instance_entities` VALUES (65,17080409);
INSERT INTO `instance_entities` VALUES (65,17080410);
INSERT INTO `instance_entities` VALUES (65,17080411);
INSERT INTO `instance_entities` VALUES (65,17080412);
INSERT INTO `instance_entities` VALUES (65,17080413);
INSERT INTO `instance_entities` VALUES (65,17080414);
INSERT INTO `instance_entities` VALUES (65,17080415);
INSERT INTO `instance_entities` VALUES (65,17080416);
INSERT INTO `instance_entities` VALUES (65,17080417);
INSERT INTO `instance_entities` VALUES (65,17080418);
INSERT INTO `instance_entities` VALUES (65,17080419);
INSERT INTO `instance_entities` VALUES (65,17080420);
INSERT INTO `instance_entities` VALUES (65,17080421);
INSERT INTO `instance_entities` VALUES (65,17080422);
INSERT INTO `instance_entities` VALUES (65,17080423);
INSERT INTO `instance_entities` VALUES (65,17080424);
INSERT INTO `instance_entities` VALUES (65,17080426);
INSERT INTO `instance_entities` VALUES (65,17080427);
INSERT INTO `instance_entities` VALUES (65,17080428);
INSERT INTO `instance_entities` VALUES (65,17080429);
INSERT INTO `instance_entities` VALUES (65,17080430);
INSERT INTO `instance_entities` VALUES (65,17080431);
INSERT INTO `instance_entities` VALUES (65,17080432);
INSERT INTO `instance_entities` VALUES (65,17080433);
INSERT INTO `instance_entities` VALUES (65,17080434);
INSERT INTO `instance_entities` VALUES (65,17080435);
INSERT INTO `instance_entities` VALUES (65,17080436);
INSERT INTO `instance_entities` VALUES (65,17080437);
INSERT INTO `instance_entities` VALUES (65,17080438);
INSERT INTO `instance_entities` VALUES (65,17080439);
INSERT INTO `instance_entities` VALUES (65,17080440);
INSERT INTO `instance_entities` VALUES (65,17080441);
INSERT INTO `instance_entities` VALUES (65,17080442);
INSERT INTO `instance_entities` VALUES (65,17080443);
INSERT INTO `instance_entities` VALUES (65,17080444);
INSERT INTO `instance_entities` VALUES (65,17080445);
INSERT INTO `instance_entities` VALUES (65,17080446);
INSERT INTO `instance_entities` VALUES (65,17080447);
INSERT INTO `instance_entities` VALUES (65,17080448);
INSERT INTO `instance_entities` VALUES (65,17080449);
INSERT INTO `instance_entities` VALUES (65,17080450);
INSERT INTO `instance_entities` VALUES (65,17080451);
INSERT INTO `instance_entities` VALUES (65,17080452);
INSERT INTO `instance_entities` VALUES (65,17080453);
INSERT INTO `instance_entities` VALUES (65,17080454);
INSERT INTO `instance_entities` VALUES (65,17080455);
INSERT INTO `instance_entities` VALUES (65,17080456);
INSERT INTO `instance_entities` VALUES (65,17080457);
INSERT INTO `instance_entities` VALUES (65,17080458);
INSERT INTO `instance_entities` VALUES (65,17080459);
INSERT INTO `instance_entities` VALUES (65,17080460);
INSERT INTO `instance_entities` VALUES (65,17080461);
INSERT INTO `instance_entities` VALUES (65,17080462);
INSERT INTO `instance_entities` VALUES (65,17080463);
INSERT INTO `instance_entities` VALUES (65,17080464);
INSERT INTO `instance_entities` VALUES (65,17080465);
INSERT INTO `instance_entities` VALUES (65,17080466);
INSERT INTO `instance_entities` VALUES (65,17080467);
INSERT INTO `instance_entities` VALUES (65,17080468);
INSERT INTO `instance_entities` VALUES (65,17080469);
INSERT INTO `instance_entities` VALUES (65,17080470);
INSERT INTO `instance_entities` VALUES (65,17080471);
INSERT INTO `instance_entities` VALUES (65,17080472);
INSERT INTO `instance_entities` VALUES (65,17080473);
INSERT INTO `instance_entities` VALUES (65,17080474);
INSERT INTO `instance_entities` VALUES (65,17080475);
INSERT INTO `instance_entities` VALUES (65,17080476);
INSERT INTO `instance_entities` VALUES (65,17080477);
INSERT INTO `instance_entities` VALUES (65,17080478);
INSERT INTO `instance_entities` VALUES (65,17080479);
INSERT INTO `instance_entities` VALUES (65,17080480);
INSERT INTO `instance_entities` VALUES (65,17080481);
INSERT INTO `instance_entities` VALUES (65,17080482);
INSERT INTO `instance_entities` VALUES (65,17080483);
INSERT INTO `instance_entities` VALUES (65,17080484);
INSERT INTO `instance_entities` VALUES (65,17080485);
INSERT INTO `instance_entities` VALUES (65,17080486);
INSERT INTO `instance_entities` VALUES (65,17080487);
INSERT INTO `instance_entities` VALUES (65,17080488);
INSERT INTO `instance_entities` VALUES (65,17080489);
INSERT INTO `instance_entities` VALUES (65,17080490);
INSERT INTO `instance_entities` VALUES (65,17080491);
INSERT INTO `instance_entities` VALUES (65,17080492);
INSERT INTO `instance_entities` VALUES (65,17080493);
INSERT INTO `instance_entities` VALUES (65,17080494);
INSERT INTO `instance_entities` VALUES (65,17080495);
INSERT INTO `instance_entities` VALUES (65,17080496);
INSERT INTO `instance_entities` VALUES (65,17080497);
INSERT INTO `instance_entities` VALUES (65,17080498);
INSERT INTO `instance_entities` VALUES (65,17080499);
INSERT INTO `instance_entities` VALUES (65,17080500);
INSERT INTO `instance_entities` VALUES (65,17080501);
INSERT INTO `instance_entities` VALUES (65,17080502);
INSERT INTO `instance_entities` VALUES (65,17080503);
INSERT INTO `instance_entities` VALUES (65,17080504);
INSERT INTO `instance_entities` VALUES (65,17080505);
INSERT INTO `instance_entities` VALUES (65,17080506);
INSERT INTO `instance_entities` VALUES (65,17080507);
INSERT INTO `instance_entities` VALUES (65,17080508);
INSERT INTO `instance_entities` VALUES (65,17080509);
INSERT INTO `instance_entities` VALUES (65,17080510);
INSERT INTO `instance_entities` VALUES (65,17080511);
INSERT INTO `instance_entities` VALUES (65,17080512);
INSERT INTO `instance_entities` VALUES (65,17080514);
INSERT INTO `instance_entities` VALUES (65,17080515);
INSERT INTO `instance_entities` VALUES (65,17080516);
INSERT INTO `instance_entities` VALUES (65,17080517);
INSERT INTO `instance_entities` VALUES (65,17080518);
INSERT INTO `instance_entities` VALUES (65,17080519);
INSERT INTO `instance_entities` VALUES (65,17080520);
INSERT INTO `instance_entities` VALUES (65,17080521);
INSERT INTO `instance_entities` VALUES (65,17080522);
INSERT INTO `instance_entities` VALUES (65,17080523);
INSERT INTO `instance_entities` VALUES (65,17080524);
INSERT INTO `instance_entities` VALUES (65,17080525);
INSERT INTO `instance_entities` VALUES (65,17080526);
INSERT INTO `instance_entities` VALUES (65,17080527);
INSERT INTO `instance_entities` VALUES (65,17080528);
INSERT INTO `instance_entities` VALUES (65,17080529);
INSERT INTO `instance_entities` VALUES (65,17080530);
INSERT INTO `instance_entities` VALUES (65,17080531);
INSERT INTO `instance_entities` VALUES (65,17080532);
INSERT INTO `instance_entities` VALUES (65,17080533);
INSERT INTO `instance_entities` VALUES (65,17080534);
INSERT INTO `instance_entities` VALUES (65,17080535);
INSERT INTO `instance_entities` VALUES (65,17080536);
INSERT INTO `instance_entities` VALUES (65,17080537);
INSERT INTO `instance_entities` VALUES (65,17080538);
INSERT INTO `instance_entities` VALUES (65,17080539);
INSERT INTO `instance_entities` VALUES (65,17080540);
INSERT INTO `instance_entities` VALUES (65,17080541);
INSERT INTO `instance_entities` VALUES (65,17080542);
INSERT INTO `instance_entities` VALUES (65,17080543);
INSERT INTO `instance_entities` VALUES (65,17080544);
INSERT INTO `instance_entities` VALUES (65,17080545);
INSERT INTO `instance_entities` VALUES (65,17080546);
INSERT INTO `instance_entities` VALUES (65,17080547);
INSERT INTO `instance_entities` VALUES (65,17080548);
INSERT INTO `instance_entities` VALUES (65,17080549);
INSERT INTO `instance_entities` VALUES (65,17080550);
INSERT INTO `instance_entities` VALUES (65,17080551);
INSERT INTO `instance_entities` VALUES (65,17080552);
INSERT INTO `instance_entities` VALUES (65,17080553);
INSERT INTO `instance_entities` VALUES (65,17080554);
INSERT INTO `instance_entities` VALUES (65,17080555);
INSERT INTO `instance_entities` VALUES (65,17080556);
INSERT INTO `instance_entities` VALUES (65,17080557);
INSERT INTO `instance_entities` VALUES (65,17080558);
INSERT INTO `instance_entities` VALUES (65,17080559);
INSERT INTO `instance_entities` VALUES (65,17080560);
INSERT INTO `instance_entities` VALUES (65,17080561);
INSERT INTO `instance_entities` VALUES (65,17080562);
INSERT INTO `instance_entities` VALUES (65,17080563);
INSERT INTO `instance_entities` VALUES (65,17080564);
INSERT INTO `instance_entities` VALUES (65,17080565);
INSERT INTO `instance_entities` VALUES (65,17080566);
INSERT INTO `instance_entities` VALUES (65,17080567);
INSERT INTO `instance_entities` VALUES (65,17080568);
INSERT INTO `instance_entities` VALUES (65,17080569);
INSERT INTO `instance_entities` VALUES (65,17080570);
INSERT INTO `instance_entities` VALUES (65,17080571);
INSERT INTO `instance_entities` VALUES (65,17080572);
INSERT INTO `instance_entities` VALUES (65,17080573);
INSERT INTO `instance_entities` VALUES (65,17080574);
INSERT INTO `instance_entities` VALUES (65,17080575);
INSERT INTO `instance_entities` VALUES (65,17080576);
INSERT INTO `instance_entities` VALUES (65,17080577);
INSERT INTO `instance_entities` VALUES (65,17080578);
INSERT INTO `instance_entities` VALUES (65,17080579);
INSERT INTO `instance_entities` VALUES (65,17080580);
INSERT INTO `instance_entities` VALUES (65,17080581);
INSERT INTO `instance_entities` VALUES (65,17080582);
INSERT INTO `instance_entities` VALUES (65,17080585);
INSERT INTO `instance_entities` VALUES (65,17080586);
INSERT INTO `instance_entities` VALUES (65,17080596);
INSERT INTO `instance_entities` VALUES (65,17080597);

-- Shades of Vengeance
INSERT INTO `instance_entities` VALUES (79,17006754);
INSERT INTO `instance_entities` VALUES (79,17006755);
INSERT INTO `instance_entities` VALUES (79,17006756);
INSERT INTO `instance_entities` VALUES (79,17006757);
INSERT INTO `instance_entities` VALUES (79,17006758);
INSERT INTO `instance_entities` VALUES (79,17006759);
INSERT INTO `instance_entities` VALUES (79,17006760);
INSERT INTO `instance_entities` VALUES (79,17006761);
INSERT INTO `instance_entities` VALUES (79,17006762);
INSERT INTO `instance_entities` VALUES (79,17006763);

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
