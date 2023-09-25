SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `bcnm_treasure_chests`
-- ----------------------------
DROP TABLE IF EXISTS `bcnm_treasure_chests`;
CREATE TABLE `bcnm_treasure_chests` (
  `bcnmId` smallint(5) unsigned NOT NULL,
  `battlefieldNumber` tinyint(3),
  `npcId` int(10) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 AVG_ROW_LENGTH=56;

-- ----------------------------
-- Records of instance
-- ----------------------------

-- ----------------------------
-- Horlais Peak
-- ----------------------------

INSERT INTO bcnm_treasure_chests VALUES (1,1,17346653); -- tails_of_woe
INSERT INTO bcnm_treasure_chests VALUES (1,2,17346662);
INSERT INTO bcnm_treasure_chests VALUES (1,3,17346671);
INSERT INTO bcnm_treasure_chests VALUES (2,1,17346702); -- dismemberment_brigade
INSERT INTO bcnm_treasure_chests VALUES (2,2,17346709);
INSERT INTO bcnm_treasure_chests VALUES (2,3,17346716);
INSERT INTO bcnm_treasure_chests VALUES (4,1,17346687); -- hostile_herbivores
INSERT INTO bcnm_treasure_chests VALUES (4,2,17346691);
INSERT INTO bcnm_treasure_chests VALUES (4,3,17346695);
INSERT INTO bcnm_treasure_chests VALUES (8,1,17346608); -- carapace_combatants
INSERT INTO bcnm_treasure_chests VALUES (8,2,17346611);
INSERT INTO bcnm_treasure_chests VALUES (8,3,17346614);
INSERT INTO bcnm_treasure_chests VALUES (9,1,17346597); -- shooting_fish
INSERT INTO bcnm_treasure_chests VALUES (9,2,17346601);
INSERT INTO bcnm_treasure_chests VALUES (9,3,17346605);
INSERT INTO bcnm_treasure_chests VALUES (10,1,17346624); -- dropping_like_flies
INSERT INTO bcnm_treasure_chests VALUES (10,2,17346634);
INSERT INTO bcnm_treasure_chests VALUES (10,3,17346644);
INSERT INTO bcnm_treasure_chests VALUES (11,1,17346718); -- horns_of_war
INSERT INTO bcnm_treasure_chests VALUES (11,2,17346720);
INSERT INTO bcnm_treasure_chests VALUES (11,3,17346722);
INSERT INTO bcnm_treasure_chests VALUES (12,1,17346675); -- under_observation
INSERT INTO bcnm_treasure_chests VALUES (12,2,17346679);
INSERT INTO bcnm_treasure_chests VALUES (12,3,17346683);
INSERT INTO bcnm_treasure_chests VALUES (13,1,17346724); -- eye_of_the_tiger
INSERT INTO bcnm_treasure_chests VALUES (13,2,17346726);
INSERT INTO bcnm_treasure_chests VALUES (13,3,17346728);
INSERT INTO bcnm_treasure_chests VALUES (14,1,17346730); -- shots_in_the_dark
INSERT INTO bcnm_treasure_chests VALUES (14,2,17346732);
INSERT INTO bcnm_treasure_chests VALUES (14,3,17346734);
INSERT INTO bcnm_treasure_chests VALUES (15,1,17346737); -- double_dragonian
INSERT INTO bcnm_treasure_chests VALUES (15,2,17346740);
INSERT INTO bcnm_treasure_chests VALUES (15,3,17346743);
INSERT INTO bcnm_treasure_chests VALUES (16,1,17346745); -- todays_horoscope
INSERT INTO bcnm_treasure_chests VALUES (16,2,17346747);
INSERT INTO bcnm_treasure_chests VALUES (16,3,17346749);
INSERT INTO bcnm_treasure_chests VALUES (17,1,17346751); -- contaminated_colosseum
INSERT INTO bcnm_treasure_chests VALUES (17,2,17346753);
INSERT INTO bcnm_treasure_chests VALUES (17,3,17346755);
INSERT INTO bcnm_treasure_chests VALUES (18,1,17346760); -- kindergarten_cap
INSERT INTO bcnm_treasure_chests VALUES (18,2,17346765);
INSERT INTO bcnm_treasure_chests VALUES (18,3,17346770);
INSERT INTO bcnm_treasure_chests VALUES (19,1,17346776); -- last_orc-shunned_hero
INSERT INTO bcnm_treasure_chests VALUES (19,2,17346782);
INSERT INTO bcnm_treasure_chests VALUES (19,3,17346788);

-- ----------------------------
-- Ghelsba Outpost
-- ----------------------------

INSERT INTO bcnm_treasure_chests VALUES (34,1,17350932); -- wings_of_fury
INSERT INTO bcnm_treasure_chests VALUES (35,1,17350935); -- petrifying_pair
INSERT INTO bcnm_treasure_chests VALUES (36,1,17350940); -- toadal recall

-- ----------------------------
-- Waughroon Shrine
-- ----------------------------

INSERT INTO bcnm_treasure_chests VALUES (65,1,17367138); -- worms_turn
INSERT INTO bcnm_treasure_chests VALUES (65,2,17367155);
INSERT INTO bcnm_treasure_chests VALUES (65,3,17367172);
INSERT INTO bcnm_treasure_chests VALUES (66,1,17367215); -- grimshell_shocktroopers
INSERT INTO bcnm_treasure_chests VALUES (66,2,17367222);
INSERT INTO bcnm_treasure_chests VALUES (66,3,17367229);
INSERT INTO bcnm_treasure_chests VALUES (69,1,17367204); -- 3_2_1
INSERT INTO bcnm_treasure_chests VALUES (69,2,17367206);
INSERT INTO bcnm_treasure_chests VALUES (69,3,17367208);
INSERT INTO bcnm_treasure_chests VALUES (73,1,17367101); -- birds_of_a_feather
INSERT INTO bcnm_treasure_chests VALUES (73,2,17367105);
INSERT INTO bcnm_treasure_chests VALUES (73,3,17367109);
INSERT INTO bcnm_treasure_chests VALUES (74,1,17367089); -- crustacean_conundrum
INSERT INTO bcnm_treasure_chests VALUES (74,2,17367093);
INSERT INTO bcnm_treasure_chests VALUES (74,3,17367097);
INSERT INTO bcnm_treasure_chests VALUES (75,1,17367113); -- grove_guardians
INSERT INTO bcnm_treasure_chests VALUES (75,2,17367117);
INSERT INTO bcnm_treasure_chests VALUES (75,3,17367121);
INSERT INTO bcnm_treasure_chests VALUES (76,1,17367231); -- hills_are_alive
INSERT INTO bcnm_treasure_chests VALUES (76,2,17367233);
INSERT INTO bcnm_treasure_chests VALUES (76,3,17367235);
INSERT INTO bcnm_treasure_chests VALUES (77,1,17367182); -- royal_jelly
INSERT INTO bcnm_treasure_chests VALUES (77,2,17367192);
INSERT INTO bcnm_treasure_chests VALUES (77,3,17367202);
INSERT INTO bcnm_treasure_chests VALUES (78,1,17367237); -- final_bout
INSERT INTO bcnm_treasure_chests VALUES (78,2,17367239);
INSERT INTO bcnm_treasure_chests VALUES (78,3,17367241);
INSERT INTO bcnm_treasure_chests VALUES (79,1,17367243); -- up_in_arms
INSERT INTO bcnm_treasure_chests VALUES (79,2,17367245);
INSERT INTO bcnm_treasure_chests VALUES (79,3,17367247);
INSERT INTO bcnm_treasure_chests VALUES (80,1,17367249); -- copycat
INSERT INTO bcnm_treasure_chests VALUES (80,2,17367255);
INSERT INTO bcnm_treasure_chests VALUES (80,3,17367261);
INSERT INTO bcnm_treasure_chests VALUES (81,1,17367272); -- operation_desert_swarm
INSERT INTO bcnm_treasure_chests VALUES (81,2,17367279);
INSERT INTO bcnm_treasure_chests VALUES (81,3,17367286);
INSERT INTO bcnm_treasure_chests VALUES (82,1,17367291); -- prehistoric_pigeons
INSERT INTO bcnm_treasure_chests VALUES (82,2,17367296);
INSERT INTO bcnm_treasure_chests VALUES (82,3,17367301);
INSERT INTO bcnm_treasure_chests VALUES (83,1,17367306); -- palborough_project
INSERT INTO bcnm_treasure_chests VALUES (83,2,17367311);
INSERT INTO bcnm_treasure_chests VALUES (83,3,17367316);
INSERT INTO bcnm_treasure_chests VALUES (84,1,17367321); -- shell_shocked
INSERT INTO bcnm_treasure_chests VALUES (84,2,17367326);
INSERT INTO bcnm_treasure_chests VALUES (84,3,17367331);

-- ----------------------------
-- Balgas Dais
-- ----------------------------

INSERT INTO bcnm_treasure_chests VALUES (97,1,17375316); -- steamed_sprouts
INSERT INTO bcnm_treasure_chests VALUES (97,2,17375325);
INSERT INTO bcnm_treasure_chests VALUES (97,3,17375334);
INSERT INTO bcnm_treasure_chests VALUES (98,1,17375371); -- divine_punishers
INSERT INTO bcnm_treasure_chests VALUES (98,2,17375378);
INSERT INTO bcnm_treasure_chests VALUES (98,3,17375385);
INSERT INTO bcnm_treasure_chests VALUES (100,1,17375356); -- treasure_and_tribulations
INSERT INTO bcnm_treasure_chests VALUES (100,2,17375360);
INSERT INTO bcnm_treasure_chests VALUES (100,3,17375364);
INSERT INTO bcnm_treasure_chests VALUES (104,1,17375282); -- creeping_doom
INSERT INTO bcnm_treasure_chests VALUES (104,2,17375284);
INSERT INTO bcnm_treasure_chests VALUES (104,3,17375286);
INSERT INTO bcnm_treasure_chests VALUES (105,1,17375272); -- charming_trio
INSERT INTO bcnm_treasure_chests VALUES (105,2,17375276);
INSERT INTO bcnm_treasure_chests VALUES (105,3,17375280);
INSERT INTO bcnm_treasure_chests VALUES (106,1,17375293); -- harem_scarem
INSERT INTO bcnm_treasure_chests VALUES (106,2,17375300);
INSERT INTO bcnm_treasure_chests VALUES (106,3,17375307);
INSERT INTO bcnm_treasure_chests VALUES (107,1,17375387); -- early_bird_catches_the_wyrm
INSERT INTO bcnm_treasure_chests VALUES (107,2,17375389);
INSERT INTO bcnm_treasure_chests VALUES (107,3,17375391);
INSERT INTO bcnm_treasure_chests VALUES (108,1,17375340); -- royal_succession
INSERT INTO bcnm_treasure_chests VALUES (108,2,17375346);
INSERT INTO bcnm_treasure_chests VALUES (108,3,17375352);
INSERT INTO bcnm_treasure_chests VALUES (109,1,17375394); -- rapid_raptors
INSERT INTO bcnm_treasure_chests VALUES (109,2,17375397);
INSERT INTO bcnm_treasure_chests VALUES (109,3,17375400);
INSERT INTO bcnm_treasure_chests VALUES (110,1,17375402); -- wild_wild_whiskers
INSERT INTO bcnm_treasure_chests VALUES (110,2,17375404);
INSERT INTO bcnm_treasure_chests VALUES (110,3,17375406);
INSERT INTO bcnm_treasure_chests VALUES (111,1,17375411); -- seasons_greetings
INSERT INTO bcnm_treasure_chests VALUES (111,2,17375416);
INSERT INTO bcnm_treasure_chests VALUES (111,3,17375421);
INSERT INTO bcnm_treasure_chests VALUES (112,1,17375428); -- royale_ramble
INSERT INTO bcnm_treasure_chests VALUES (112,2,17375435);
INSERT INTO bcnm_treasure_chests VALUES (112,3,17375442);
INSERT INTO bcnm_treasure_chests VALUES (113,1,17375445); -- moa_constrictors
INSERT INTO bcnm_treasure_chests VALUES (113,2,17375448);
INSERT INTO bcnm_treasure_chests VALUES (113,3,17375451);
INSERT INTO bcnm_treasure_chests VALUES (114,1,17375459); -- v_formation
INSERT INTO bcnm_treasure_chests VALUES (114,2,17375467);
INSERT INTO bcnm_treasure_chests VALUES (114,3,17375475);
INSERT INTO bcnm_treasure_chests VALUES (115,1,17375480); -- avian_apostates
INSERT INTO bcnm_treasure_chests VALUES (115,2,17375485);
INSERT INTO bcnm_treasure_chests VALUES (115,3,17375490);

-- ----------------------------
-- Sacrificial Chamber
-- ----------------------------

INSERT INTO bcnm_treasure_chests VALUES (129,1,17444884); -- jungle_boogymen
INSERT INTO bcnm_treasure_chests VALUES (129,2,17444891);
INSERT INTO bcnm_treasure_chests VALUES (129,3,17444898);
INSERT INTO bcnm_treasure_chests VALUES (130,1,17444905); -- amphibian_assault
INSERT INTO bcnm_treasure_chests VALUES (130,2,17444911);
INSERT INTO bcnm_treasure_chests VALUES (130,3,17444917);
INSERT INTO bcnm_treasure_chests VALUES (132,1,17444929); -- whom_wilt_thou_call
INSERT INTO bcnm_treasure_chests VALUES (132,2,17444934);
INSERT INTO bcnm_treasure_chests VALUES (132,3,17444939);

-- ----------------------------
-- Throne Room
-- ----------------------------

INSERT INTO bcnm_treasure_chests VALUES (162,1,17453079); -- kindred_spirits
INSERT INTO bcnm_treasure_chests VALUES (162,2,17453086);
INSERT INTO bcnm_treasure_chests VALUES (162,3,17453093);

-- ----------------------------
-- Chamber of Oracles
-- ----------------------------

INSERT INTO bcnm_treasure_chests VALUES (193,1,17465370); -- legion_xi_comitatensis
INSERT INTO bcnm_treasure_chests VALUES (193,2,17465375);
INSERT INTO bcnm_treasure_chests VALUES (193,3,17465380);
INSERT INTO bcnm_treasure_chests VALUES (197,1,17465384); -- cactuar_suave
INSERT INTO bcnm_treasure_chests VALUES (197,2,17465388);
INSERT INTO bcnm_treasure_chests VALUES (197,3,17465392);
INSERT INTO bcnm_treasure_chests VALUES (198,1,17465397); -- eye_of_the_storm
INSERT INTO bcnm_treasure_chests VALUES (198,2,17465402);
INSERT INTO bcnm_treasure_chests VALUES (198,3,17465407);
INSERT INTO bcnm_treasure_chests VALUES (199,1,17465409); -- scarlet_king
INSERT INTO bcnm_treasure_chests VALUES (199,2,17465411);
INSERT INTO bcnm_treasure_chests VALUES (199,3,17465413);

-- ----------------------------
-- Throne Room [S]
-- ----------------------------

INSERT INTO bcnm_treasure_chests VALUES (352,1,17416196); -- fiat_lux
INSERT INTO bcnm_treasure_chests VALUES (352,2,17416200);
INSERT INTO bcnm_treasure_chests VALUES (352,3,17416204);

-- ----------------------------
-- Qu'Bia Arena
-- ----------------------------

INSERT INTO bcnm_treasure_chests VALUES (513,1,17621198); -- come_into_my_parlor
INSERT INTO bcnm_treasure_chests VALUES (513,2,17621208);
INSERT INTO bcnm_treasure_chests VALUES (513,3,17621218);
INSERT INTO bcnm_treasure_chests VALUES (514,1,17621233); -- e-vase-ive_action
INSERT INTO bcnm_treasure_chests VALUES (514,2,17621240);
INSERT INTO bcnm_treasure_chests VALUES (514,3,17621247);
INSERT INTO bcnm_treasure_chests VALUES (515,1,17621257); -- infernal_swarm
INSERT INTO bcnm_treasure_chests VALUES (515,2,17621267);
INSERT INTO bcnm_treasure_chests VALUES (515,3,17621277);
INSERT INTO bcnm_treasure_chests VALUES (520,1,17621141); -- demolition_squad
INSERT INTO bcnm_treasure_chests VALUES (520,2,17621146);
INSERT INTO bcnm_treasure_chests VALUES (520,3,17621151);
INSERT INTO bcnm_treasure_chests VALUES (521,1,17621068); -- die_by_the_sword
INSERT INTO bcnm_treasure_chests VALUES (521,2,17621072);
INSERT INTO bcnm_treasure_chests VALUES (521,3,17621076);
INSERT INTO bcnm_treasure_chests VALUES (522,1,17621081); -- let_sleeping_dogs_die
INSERT INTO bcnm_treasure_chests VALUES (522,2,17621086);
INSERT INTO bcnm_treasure_chests VALUES (522,3,17621091);
INSERT INTO bcnm_treasure_chests VALUES (523,1,17621156); -- brothers_d_aurphe
INSERT INTO bcnm_treasure_chests VALUES (523,2,17621161);
INSERT INTO bcnm_treasure_chests VALUES (523,3,17621166);
INSERT INTO bcnm_treasure_chests VALUES (524,1,17621115); -- undying_promise
INSERT INTO bcnm_treasure_chests VALUES (524,2,17621118);
INSERT INTO bcnm_treasure_chests VALUES (524,3,17621121);
INSERT INTO bcnm_treasure_chests VALUES (525,1,17621098); -- factory_rejects
INSERT INTO bcnm_treasure_chests VALUES (525,2,17621105);
INSERT INTO bcnm_treasure_chests VALUES (525,3,17621112);
INSERT INTO bcnm_treasure_chests VALUES (526,1,17621126); -- idol_thoughts
INSERT INTO bcnm_treasure_chests VALUES (526,2,17621131);
INSERT INTO bcnm_treasure_chests VALUES (526,3,17621136);
INSERT INTO bcnm_treasure_chests VALUES (527,1,17621171); -- awful_autopsy
INSERT INTO bcnm_treasure_chests VALUES (527,2,17621176);
INSERT INTO bcnm_treasure_chests VALUES (527,3,17621181);
INSERT INTO bcnm_treasure_chests VALUES (528,1,17621186); -- celery
INSERT INTO bcnm_treasure_chests VALUES (528,2,17621191);
INSERT INTO bcnm_treasure_chests VALUES (528,3,17621196);

-- ----------------------------
-- Bearclaw Pinnacle
-- ----------------------------

INSERT INTO bcnm_treasure_chests VALUES (641,1,16801802); -- follow_the_white_rabbit
INSERT INTO bcnm_treasure_chests VALUES (641,2,16801809);
INSERT INTO bcnm_treasure_chests VALUES (641,3,16801816);
INSERT INTO bcnm_treasure_chests VALUES (642,1,16801824); -- when_hell_freezes_over
INSERT INTO bcnm_treasure_chests VALUES (642,2,16801832);
INSERT INTO bcnm_treasure_chests VALUES (642,3,16801840);
INSERT INTO bcnm_treasure_chests VALUES (643,1,16801843); -- brothers
INSERT INTO bcnm_treasure_chests VALUES (643,2,16801846);
INSERT INTO bcnm_treasure_chests VALUES (643,3,16801849);
INSERT INTO bcnm_treasure_chests VALUES (644,1,16801851); -- holy_cow
INSERT INTO bcnm_treasure_chests VALUES (644,2,16801853);
INSERT INTO bcnm_treasure_chests VALUES (644,3,16801855);

-- ----------------------------
-- Boneyard Gully
-- ----------------------------

INSERT INTO bcnm_treasure_chests VALUES (673,1,16810019); -- like_the_wind
INSERT INTO bcnm_treasure_chests VALUES (673,2,16810021);
INSERT INTO bcnm_treasure_chests VALUES (673,3,16810023);
INSERT INTO bcnm_treasure_chests VALUES (674,1,16810005); -- sheep_in_antlions_clothing
INSERT INTO bcnm_treasure_chests VALUES (674,2,16810011);
INSERT INTO bcnm_treasure_chests VALUES (674,3,16810017);
INSERT INTO bcnm_treasure_chests VALUES (675,1,16810032); -- shell_we_dance
INSERT INTO bcnm_treasure_chests VALUES (675,2,16810041);
INSERT INTO bcnm_treasure_chests VALUES (675,3,16810050);
INSERT INTO bcnm_treasure_chests VALUES (676,1,16810061); -- totentanz
INSERT INTO bcnm_treasure_chests VALUES (676,2,16810072);
INSERT INTO bcnm_treasure_chests VALUES (676,3,16810083);
INSERT INTO bcnm_treasure_chests VALUES (678,1,16810089); -- Requiem of Sin
INSERT INTO bcnm_treasure_chests VALUES (678,2,16810095);
INSERT INTO bcnm_treasure_chests VALUES (678,3,16810101);
INSERT INTO bcnm_treasure_chests VALUES (679,1,16810107); -- antagonistic_ambuscade
INSERT INTO bcnm_treasure_chests VALUES (679,2,16810113);
INSERT INTO bcnm_treasure_chests VALUES (679,3,16810119);

-- ----------------------------
-- The Shrouded Maw
-- ----------------------------

INSERT INTO bcnm_treasure_chests VALUES (705,1,16818199); -- test_your_mite
INSERT INTO bcnm_treasure_chests VALUES (705,2,16818201);
INSERT INTO bcnm_treasure_chests VALUES (705,3,16818203);

-- ----------------------------
-- Mine Shaft #2716
-- ----------------------------

INSERT INTO bcnm_treasure_chests VALUES (738,1,16830502); -- bionic_bug
INSERT INTO bcnm_treasure_chests VALUES (738,2,16830504);
INSERT INTO bcnm_treasure_chests VALUES (738,3,16830506);
INSERT INTO bcnm_treasure_chests VALUES (739,1,16830508); -- pulling_the_strings
INSERT INTO bcnm_treasure_chests VALUES (739,2,16830515);
INSERT INTO bcnm_treasure_chests VALUES (739,3,16830522);
INSERT INTO bcnm_treasure_chests VALUES (740,1,16830528); -- automaton_assault
INSERT INTO bcnm_treasure_chests VALUES (740,2,16830534);
INSERT INTO bcnm_treasure_chests VALUES (740,3,16830540);
INSERT INTO bcnm_treasure_chests VALUES (741,1,16830555); -- mobline_comedy
INSERT INTO bcnm_treasure_chests VALUES (741,2,16830566);
INSERT INTO bcnm_treasure_chests VALUES (741,3,16830577);

-- ----------------------------
-- Spire of Holla
-- ----------------------------

INSERT INTO bcnm_treasure_chests VALUES (769,1,16846856); -- simulant
INSERT INTO bcnm_treasure_chests VALUES (769,2,16846861);
INSERT INTO bcnm_treasure_chests VALUES (769,3,16846866);

-- ----------------------------
-- Spire of Dem
-- ----------------------------

INSERT INTO bcnm_treasure_chests VALUES (801,1,16855061); -- you_are_what_you_eat
INSERT INTO bcnm_treasure_chests VALUES (801,2,16855067);
INSERT INTO bcnm_treasure_chests VALUES (801,3,16855073);

-- ----------------------------
-- Spire of Mea
-- ----------------------------

INSERT INTO bcnm_treasure_chests VALUES (833,1,16863240); -- playing_host
INSERT INTO bcnm_treasure_chests VALUES (833,2,16863245);
INSERT INTO bcnm_treasure_chests VALUES (833,3,16863250);

-- ----------------------------
-- Spire of Vahzl
-- ----------------------------

INSERT INTO bcnm_treasure_chests VALUES (865,1,16871455); -- pulling_the_plug
INSERT INTO bcnm_treasure_chests VALUES (865,2,16871465);
INSERT INTO bcnm_treasure_chests VALUES (865,3,16871475);

-- ----------------------------
-- Monarch Linn
-- ----------------------------

INSERT INTO bcnm_treasure_chests VALUES (962,1,16904212); -- fire_in_the_sky
INSERT INTO bcnm_treasure_chests VALUES (962,2,16904214);
INSERT INTO bcnm_treasure_chests VALUES (962,3,16904216);
INSERT INTO bcnm_treasure_chests VALUES (963,1,16904206); -- bad_seed
INSERT INTO bcnm_treasure_chests VALUES (963,2,16904208);
INSERT INTO bcnm_treasure_chests VALUES (963,3,16904210);
INSERT INTO bcnm_treasure_chests VALUES (964,1,16904227); -- bugard_in_the_clouds
INSERT INTO bcnm_treasure_chests VALUES (964,2,16904229);
INSERT INTO bcnm_treasure_chests VALUES (964,3,16904231);
INSERT INTO bcnm_treasure_chests VALUES (965,1,16904219); -- beloved_of_the_atlantes
INSERT INTO bcnm_treasure_chests VALUES (965,2,16904222);
INSERT INTO bcnm_treasure_chests VALUES (965,3,16904225);
INSERT INTO bcnm_treasure_chests VALUES (967,1,16904267); -- nest_of_nightmares
INSERT INTO bcnm_treasure_chests VALUES (967,2,16904273);
INSERT INTO bcnm_treasure_chests VALUES (967,3,16904279);

-- ----------------------------
-- Talacca Cove
-- ----------------------------

INSERT INTO bcnm_treasure_chests VALUES (1088,1,17010700); -- call_to_arms
INSERT INTO bcnm_treasure_chests VALUES (1088,2,17010706);
INSERT INTO bcnm_treasure_chests VALUES (1088,3,17010712);
INSERT INTO bcnm_treasure_chests VALUES (1089,1,17010714); -- compliments_to_the_chef
INSERT INTO bcnm_treasure_chests VALUES (1089,2,17010716);
INSERT INTO bcnm_treasure_chests VALUES (1089,3,17010718);

-- ----------------------------
-- Navukgo Execution Chamber
-- ----------------------------

INSERT INTO bcnm_treasure_chests VALUES (1120,1,17039362); -- tough_nut_to_crack
INSERT INTO bcnm_treasure_chests VALUES (1120,2,17039364);
INSERT INTO bcnm_treasure_chests VALUES (1120,3,17039366);
INSERT INTO bcnm_treasure_chests VALUES (1121,1,17039368); -- happy_caster
INSERT INTO bcnm_treasure_chests VALUES (1121,2,17039370);
INSERT INTO bcnm_treasure_chests VALUES (1121,3,17039372);

-- ----------------------------
-- Jade Sepulcher
-- ----------------------------

INSERT INTO bcnm_treasure_chests VALUES (1152,1,17051650); -- making_a_mockery
INSERT INTO bcnm_treasure_chests VALUES (1152,2,17051652);
INSERT INTO bcnm_treasure_chests VALUES (1152,3,17051654);
INSERT INTO bcnm_treasure_chests VALUES (1153,1,17051660); -- shadows_of_the_mind
INSERT INTO bcnm_treasure_chests VALUES (1153,2,17051666);
INSERT INTO bcnm_treasure_chests VALUES (1153,3,17051672);

-- ----------------------------
-- Apollyon
-- ----------------------------
INSERT INTO bcnm_treasure_chests VALUES (1290,2,16932984); -- NW_Apollyon
INSERT INTO bcnm_treasure_chests VALUES (1291,1,16932909); -- SW_Apollyon
INSERT INTO bcnm_treasure_chests VALUES (1292,4,16933112); -- NE_Apollyon
INSERT INTO bcnm_treasure_chests VALUES (1293,3,16933031); -- SE_Apollyon
INSERT INTO bcnm_treasure_chests VALUES (1294,6,16933126); -- CS_Apollyon
INSERT INTO bcnm_treasure_chests VALUES (1296,5,16933123); -- Central_Apollyon

-- ----------------------------
-- Temenos
-- ----------------------------
INSERT INTO bcnm_treasure_chests VALUES (1298,3,16928958); -- Temenos - Western Tower
INSERT INTO bcnm_treasure_chests VALUES (1299,1,16928830); -- Temenos - Northern Tower
INSERT INTO bcnm_treasure_chests VALUES (1300,2,16928890); -- Temenos - Eastern Tower
INSERT INTO bcnm_treasure_chests VALUES (1303,7,16929045); -- Central Temenos - 1st Floor
INSERT INTO bcnm_treasure_chests VALUES (1304,6,16929029); -- Central Temenos - 2nd Floor
INSERT INTO bcnm_treasure_chests VALUES (1305,5,16929004); -- Central Temenos - 3rd Floor
INSERT INTO bcnm_treasure_chests VALUES (1306,4,16928965); -- Central Temenos - 4th Floor
INSERT INTO bcnm_treasure_chests VALUES (1301,8,16929052); -- Central Temenos - Basement
