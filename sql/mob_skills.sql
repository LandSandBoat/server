SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Table structure for `mob_skills`
--

DROP TABLE IF EXISTS `mob_skills`;
CREATE TABLE IF NOT EXISTS `mob_skills` (
  `mob_skill_id` smallint(4) unsigned NOT NULL,
  `mob_anim_id` smallint(4) unsigned NOT NULL,
  `mob_skill_name` varchar(40) CHARACTER SET latin1 NOT NULL,
  `mob_skill_aoe` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `mob_skill_aoe_radius` float(3,1) NOT NULL DEFAULT '0.0',
  `mob_skill_distance` float(3,1) NOT NULL DEFAULT '6.0',
  `mob_anim_time` smallint(4) unsigned NOT NULL DEFAULT '2000',
  `mob_prepare_time` smallint(4) unsigned NOT NULL DEFAULT '1000',
  `mob_valid_targets` smallint(4) unsigned NOT NULL DEFAULT '4',
  `mob_skill_flag` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `mob_skill_param` smallint(5) NOT NULL DEFAULT '0',
  `knockback` tinyint(1) NOT NULL DEFAULT '0',
  `primary_sc` tinyint(4) NOT NULL DEFAULT '0',
  `secondary_sc` tinyint(4) NOT NULL DEFAULT '0',
  `tertiary_sc` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`mob_skill_id`)
) ENGINE=Aria TRANSACTIONAL=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Variables
-- mob_skill_aoe
-- Keep synced with mobskill.h
SET @SINGLE    = 0;
SET @AOE       = 1;
SET @AOETARGET = 2;
SET @CONE      = 4;
SET @REARCONE  = 8;

-- mob_valid_targets
-- Keep synced with battleentity.h
SET @NONE              = 0;
SET @SELF              = 1;
SET @PARTY             = 2;
SET @ENEMY             = 4;
SET @ALLIANCE          = 8;
SET @PLAYER            = 16;
SET @PLAYER_DEAD       = 32;
SET @NPC               = 64;
SET @PARTY_PIANISSIMO  = 128;
SET @PET               = 256;
SET @PARTY_ENTRUST     = 512;
SET @IGNORE_BATTLEID   = 1024;

-- mob_skill_flag
-- Keep synced with mobskill.h
SET @ASTRAL_FLOW     = 2;
SET @NO_TP_COST      = 4;
SET @HIT_ALL         = 8;
SET @BLOOD_PACT_RAGE = 64;
SET @BLOOD_PACT_WARD = 128;

--
-- Table contents for `mob_skills`
--

INSERT INTO `mob_skills` VALUES (1,16,'combo',@SINGLE,0.0,5.0,2000,0,@ENEMY,@NONE,0,0,8,0,0);
-- INSERT INTO `mob_skills` VALUES (2,??,'shoulder_tackle'
-- INSERT INTO `mob_skills` VALUES (3,??,'one_inch_punch'
INSERT INTO `mob_skills` VALUES (4,19,'backhand_blow',@SINGLE,0.0,5.0,2000,0,@ENEMY,@NONE,0,0,6,0,0);
-- INSERT INTO `mob_skills` VALUES (5,??,'raging_fists'
-- INSERT INTO `mob_skills` VALUES (6,??,'spinning_attack'
INSERT INTO `mob_skills` VALUES (7,22,'howling_fist',@SINGLE,0.0,5.0,2000,0,@ENEMY,@NONE,0,0,1,8,0);
INSERT INTO `mob_skills` VALUES (9,24,'asuran_fists',@SINGLE,0.0,5.0,2000,0,@ENEMY,@NONE,0,0,9,3,0);
INSERT INTO `mob_skills` VALUES (10,25,'final_heaven',@SINGLE,0.0,5.0,2000,0,@ENEMY,@NONE,0,0,13,11,0);
INSERT INTO `mob_skills` VALUES (11,26,'ascetics_fury',@SINGLE,0.0,5.0,2000,0,@ENEMY,@NONE,0,0,11,1,0);
INSERT INTO `mob_skills` VALUES (14,29,'victory_smite',@SINGLE,0.0,5.0,2000,0,@ENEMY,@NONE,0,0,13,12,0);
-- INSERT INTO `mob_skills` VALUES (15,??,'shijin_spiral'
-- INSERT INTO `mob_skills` VALUES (16,??,'wasp_sting'
-- INSERT INTO `mob_skills` VALUES (17,??,'viper_bite'
INSERT INTO `mob_skills` VALUES (18,33,'shadowstitch',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,5,0,0);
INSERT INTO `mob_skills` VALUES (19,34,'gust_slash',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,9,0,0);
-- INSERT INTO `mob_skills` VALUES (20,??,'cyclone'
-- INSERT INTO `mob_skills` VALUES (21,??,'energy_steal'
-- INSERT INTO `mob_skills` VALUES (22,??,'energy_drain'
INSERT INTO `mob_skills` VALUES (23,38,'dancing_edge',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,4,6,0);
-- INSERT INTO `mob_skills` VALUES (24,??,'shark_bite'
INSERT INTO `mob_skills` VALUES (25,40,'evisceration',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,9,1,0);
-- INSERT INTO `mob_skills` VALUES (26,??,'mercy_stroke'
-- INSERT INTO `mob_skills` VALUES (27,??,'mandalic_stab'
-- INSERT INTO `mob_skills` VALUES (28,??,'mordant_rime'
-- INSERT INTO `mob_skills` VALUES (29,??,'pyrrhic_kleos'
INSERT INTO `mob_skills` VALUES (30,45,'aeolian_edge',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,9,0,0);
-- INSERT INTO `mob_skills` VALUES (31,??,'rudras_storm'
INSERT INTO `mob_skills` VALUES (32,1,'fast_blade',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (33,2,'burning_blade',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,3,0,0);
INSERT INTO `mob_skills` VALUES (34,3,'red_lotus_blade',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,3,6,0);
INSERT INTO `mob_skills` VALUES (35,6,'flat_blade',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,8,0,0);
INSERT INTO `mob_skills` VALUES (36,4,'shining_blade',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,4,0,0);
INSERT INTO `mob_skills` VALUES (37,5,'seraph_blade',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,4,0,0);
INSERT INTO `mob_skills` VALUES (38,7,'circle_blade',@AOE,0.0,5.0,2000,0,@ENEMY,@NONE,0,0,5,8,0);
-- INSERT INTO `mob_skills` VALUES (39,??,'spirits_within'
INSERT INTO `mob_skills` VALUES (40,9,'vorpal_blade',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,5,8,0);
INSERT INTO `mob_skills` VALUES (41,10,'swift_blade',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,9,0,0);
INSERT INTO `mob_skills` VALUES (42,11,'savage_blade',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,9,0,0);
-- INSERT INTO `mob_skills` VALUES (43,??,'knights_of_round'
-- INSERT INTO `mob_skills` VALUES (44,??,'death_blossom'
-- INSERT INTO `mob_skills` VALUES (45,??,'atonement'
-- INSERT INTO `mob_skills` VALUES (46,??,'expiacion'
-- INSERT INTO `mob_skills` VALUES (47,??,'sanguine_blade'
-- INSERT INTO `mob_skills` VALUES (48,??,'hard_slash'
INSERT INTO `mob_skills` VALUES (49,107,'power_slash',@SINGLE,0.0,10.0,2000,500,@ENEMY,@NONE,0,0,1,0,0);
-- INSERT INTO `mob_skills` VALUES (50,??,'frostbite'
-- INSERT INTO `mob_skills` VALUES (51,??,'freezebite'
-- INSERT INTO `mob_skills` VALUES (52,??,'shockwave'
-- INSERT INTO `mob_skills` VALUES (53,??,'crescent_moon'
INSERT INTO `mob_skills` VALUES (54,112,'sickle_moon',@SINGLE,0.0,10.0,2000,500,@ENEMY,@NONE,0,0,4,8,0);
-- INSERT INTO `mob_skills` VALUES (55,??,'spinning_slash'
INSERT INTO `mob_skills` VALUES (56,114,'ground_strike',@SINGLE,0.0,10.0,2000,500,@ENEMY,@NONE,0,0,12,10,0);
-- INSERT INTO `mob_skills` VALUES (57,??,'scourge'
-- INSERT INTO `mob_skills` VALUES (58,??,'herculean_slash'
-- INSERT INTO `mob_skills` VALUES (59,??,'torcleaver'
-- INSERT INTO `mob_skills` VALUES (60,??,'resolution'
-- INSERT INTO `mob_skills` VALUES (61,??,'dimidiation'
-- INSERT INTO `mob_skills` VALUES (62,??,'fimbulvetr'
-- INSERT INTO `mob_skills` VALUES (64,??,'raging_axe'
-- INSERT INTO `mob_skills` VALUES (65,??,'smash_axe'
-- INSERT INTO `mob_skills` VALUES (66,??,'gale_axe'
-- INSERT INTO `mob_skills` VALUES (67,??,'avalanche_axe'
-- INSERT INTO `mob_skills` VALUES (68,??,'spinning_axe'
-- INSERT INTO `mob_skills` VALUES (69,??,'rampage'
-- INSERT INTO `mob_skills` VALUES (70,??,'calamity'
-- INSERT INTO `mob_skills` VALUES (71,??,'mistral_axe'
-- INSERT INTO `mob_skills` VALUES (72,??,'decimation'
-- INSERT INTO `mob_skills` VALUES (73,??,'onslaught'
-- INSERT INTO `mob_skills` VALUES (74,??,'primal_rend'
-- INSERT INTO `mob_skills` VALUES (75,??,'bora_axe'
-- INSERT INTO `mob_skills` VALUES (76,??,'cloudsplitter'
-- INSERT INTO `mob_skills` VALUES (77,??,'ruinator'
-- INSERT INTO `mob_skills` VALUES (78,??,'blitz'
-- INSERT INTO `mob_skills` VALUES (80,??,'shield_break'
-- INSERT INTO `mob_skills` VALUES (81,??,'iron_tempest'
-- INSERT INTO `mob_skills` VALUES (82,??,'sturmwind'
-- INSERT INTO `mob_skills` VALUES (83,??,'armor_break'
-- INSERT INTO `mob_skills` VALUES (84,??,'keen_edge'
-- INSERT INTO `mob_skills` VALUES (85,??,'weapon_break'
INSERT INTO `mob_skills` VALUES (86,97,'raging_rush',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,9,0,0);
-- INSERT INTO `mob_skills` VALUES (87,??,'full_break'
-- INSERT INTO `mob_skills` VALUES (88,??,'steel_cyclone'
-- INSERT INTO `mob_skills` VALUES (89,??,'metatron_torment'
-- INSERT INTO `mob_skills` VALUES (90,??,'kings_justice'
INSERT INTO `mob_skills` VALUES (91,102,'fell_cleave',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,9,0,0);
-- INSERT INTO `mob_skills` VALUES (92,??,'ukkos_fury'
-- INSERT INTO `mob_skills` VALUES (93,??,'upheaval'
-- INSERT INTO `mob_skills` VALUES (94,??,'disaster'
-- INSERT INTO `mob_skills` VALUES (96,??,'slice'
-- INSERT INTO `mob_skills` VALUES (97,??,'dark_harvest'
-- INSERT INTO `mob_skills` VALUES (98,??,'shadow_of_death'
-- INSERT INTO `mob_skills` VALUES (99,??,'nightmare_scythe'
-- INSERT INTO `mob_skills` VALUES (100,??,'spinning_scythe'
INSERT INTO `mob_skills` VALUES (101,66,'vorpal_scythe',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,1,4,0);
INSERT INTO `mob_skills` VALUES (102,67,'guillotine',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,7,0,0);
INSERT INTO `mob_skills` VALUES (104,69,'spiral_hell',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,10,4,0);
-- INSERT INTO `mob_skills` VALUES (105,??,'catastrophe'
-- INSERT INTO `mob_skills` VALUES (106,??,'insurgency'
-- INSERT INTO `mob_skills` VALUES (107,??,'infernal_scythe'
-- INSERT INTO `mob_skills` VALUES (108,??,'quietus'
-- INSERT INTO `mob_skills` VALUES (109,??,'entropy'
-- INSERT INTO `mob_skills` VALUES (110,??,'origin'
-- INSERT INTO `mob_skills` VALUES (112,??,'double_thrust'
-- INSERT INTO `mob_skills` VALUES (113,??,'thunder_thrust'
INSERT INTO `mob_skills` VALUES (114,123,'raiden_thrust',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,1,8,0);
-- INSERT INTO `mob_skills` VALUES (115,??,'leg_sweep'
INSERT INTO `mob_skills` VALUES (116,125,'penta_thrust',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,2,0,0);
-- INSERT INTO `mob_skills` VALUES (117,??,'vorpal_thrust'
INSERT INTO `mob_skills` VALUES (118,127,'skewer',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,1,8,0);
INSERT INTO `mob_skills` VALUES (119,128,'wheeling_thrust',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,11,0,0);
INSERT INTO `mob_skills` VALUES (120,129,'impulse_drive',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,9,7,0);
-- INSERT INTO `mob_skills` VALUES (121,??,'geirskogul'
-- INSERT INTO `mob_skills` VALUES (122,??,'drakesbane'
-- INSERT INTO `mob_skills` VALUES (123,??,'sonic_thrust'
-- INSERT INTO `mob_skills` VALUES (124,??,'camlanns_torment'
-- INSERT INTO `mob_skills` VALUES (125,??,'stardiver'
-- INSERT INTO `mob_skills` VALUES (126,??,'diarmuid'
-- INSERT INTO `mob_skills` VALUES (128,??,'blade_rin'
-- INSERT INTO `mob_skills` VALUES (129,??,'blade_retsu'
-- INSERT INTO `mob_skills` VALUES (130,??,'blade_teki'
INSERT INTO `mob_skills` VALUES (131,154,'blade_to',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,9,0,0);
-- INSERT INTO `mob_skills` VALUES (132,??,'blade_chi'
-- INSERT INTO `mob_skills` VALUES (133,??,'blade_ei'
INSERT INTO `mob_skills` VALUES (134,157,'blade_jin',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,9,0,0);
-- INSERT INTO `mob_skills` VALUES (135,??,'blade_ten'
INSERT INTO `mob_skills` VALUES (136,159,'blade_ku',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,9,0,0);
-- INSERT INTO `mob_skills` VALUES (137,??,'blade_metsu'
-- INSERT INTO `mob_skills` VALUES (138,??,'blade_kamu'
-- INSERT INTO `mob_skills` VALUES (139,??,'blade_yu'
-- INSERT INTO `mob_skills` VALUES (140,??,'blade_hi'
-- INSERT INTO `mob_skills` VALUES (141,??,'blade_shun'
-- INSERT INTO `mob_skills` VALUES (142,??,'jijin_kaimetsu'
-- INSERT INTO `mob_skills` VALUES (144,??,'tachi_enpi'
-- INSERT INTO `mob_skills` VALUES (145,??,'tachi_hobaku'
-- INSERT INTO `mob_skills` VALUES (146,??,'tachi_goten'
-- INSERT INTO `mob_skills` VALUES (147,??,'tachi_kagero'
-- INSERT INTO `mob_skills` VALUES (148,??,'tachi_jinpu'
-- INSERT INTO `mob_skills` VALUES (149,??,'tachi_koki'
-- INSERT INTO `mob_skills` VALUES (150,??,'tachi_yukikaze'
-- INSERT INTO `mob_skills` VALUES (151,??,'tachi_gekko'
-- INSERT INTO `mob_skills` VALUES (152,??,'tachi_kasha'
-- INSERT INTO `mob_skills` VALUES (153,??,'tachi_kaiten'
-- INSERT INTO `mob_skills` VALUES (154,??,'tachi_rana'
-- INSERT INTO `mob_skills` VALUES (155,??,'tachi_ageha'
-- INSERT INTO `mob_skills` VALUES (156,??,'tachi_fudo'
-- INSERT INTO `mob_skills` VALUES (157,??,'tachi_shoha'
-- INSERT INTO `mob_skills` VALUES (158,??,'tachi_suikawari'
-- INSERT INTO `mob_skills` VALUES (159,??,'tachi_mumei'
-- INSERT INTO `mob_skills` VALUES (160,??,'shining_strike'
-- INSERT INTO `mob_skills` VALUES (161,??,'seraph_strike'
-- INSERT INTO `mob_skills` VALUES (162,??,'brainshaker'
-- INSERT INTO `mob_skills` VALUES (163,??,'starlight'
-- INSERT INTO `mob_skills` VALUES (164,??,'moonlight'
INSERT INTO `mob_skills` VALUES (165,81,'skullbreaker',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,7,5,0);
INSERT INTO `mob_skills` VALUES (166,82,'true_strike',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,6,8,0);
INSERT INTO `mob_skills` VALUES (167,83,'judgment',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,6,8,0);
INSERT INTO `mob_skills` VALUES (168,84,'hexa_strike',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,11,0,0);
INSERT INTO `mob_skills` VALUES (169,85,'black_halo',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,12,2,0);
INSERT INTO `mob_skills` VALUES (170,86,'randgrith',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,13,12,0);
-- INSERT INTO `mob_skills` VALUES (171,??,'mystic_boon'
-- INSERT INTO `mob_skills` VALUES (172,??,'flash_nova'
-- INSERT INTO `mob_skills` VALUES (173,??,'dagan'
-- INSERT INTO `mob_skills` VALUES (174,??,'realmrazer'
-- INSERT INTO `mob_skills` VALUES (175,??,'exudation'
-- INSERT INTO `mob_skills` VALUES (176,??,'heavy_swing'
-- INSERT INTO `mob_skills` VALUES (177,??,'rock_crusher'
-- INSERT INTO `mob_skills` VALUES (178,??,'earth_crusher'
-- INSERT INTO `mob_skills` VALUES (179,??,'starburst'
-- INSERT INTO `mob_skills` VALUES (180,??,'sunburst'
-- INSERT INTO `mob_skills` VALUES (181,??,'shell_crusher'
-- INSERT INTO `mob_skills` VALUES (182,??,'full_swing'
-- INSERT INTO `mob_skills` VALUES (183,??,'spirit_taker'
-- INSERT INTO `mob_skills` VALUES (184,??,'retribution'
-- INSERT INTO `mob_skills` VALUES (185,??,'gate_of_tartarus'
-- INSERT INTO `mob_skills` VALUES (186,??,'vidohunir'
-- INSERT INTO `mob_skills` VALUES (187,??,'garland_of_bliss'
-- INSERT INTO `mob_skills` VALUES (188,??,'omniscience'
-- INSERT INTO `mob_skills` VALUES (189,??,'cataclysm'
-- INSERT INTO `mob_skills` VALUES (190,??,'myrkr'
-- INSERT INTO `mob_skills` VALUES (191,??,'shattersoul'
-- INSERT INTO `mob_skills` VALUES (192,??,'flaming_arrow'
-- INSERT INTO `mob_skills` VALUES (193,??,'piercing_arrow'
-- INSERT INTO `mob_skills` VALUES (194,??,'dulling_arrow'
-- INSERT INTO `mob_skills` VALUES (196,??,'sidewinder'
-- INSERT INTO `mob_skills` VALUES (197,??,'blast_arrow'
-- INSERT INTO `mob_skills` VALUES (198,??,'arching_arrow'
-- INSERT INTO `mob_skills` VALUES (199,??,'empyreal_arrow'
-- INSERT INTO `mob_skills` VALUES (200,??,'namas_arrow'
-- INSERT INTO `mob_skills` VALUES (201,??,'refulgent_arrow'
-- INSERT INTO `mob_skills` VALUES (202,??,'jishnus_radiance'
-- INSERT INTO `mob_skills` VALUES (203,??,'apex_arrow'
-- INSERT INTO `mob_skills` VALUES (204,??,'sarv'
-- INSERT INTO `mob_skills` VALUES (208,??,'hot_shot'
-- INSERT INTO `mob_skills` VALUES (209,??,'split_shot'
-- INSERT INTO `mob_skills` VALUES (210,??,'sniper_shot'
-- INSERT INTO `mob_skills` VALUES (212,??,'slug_shot'
-- INSERT INTO `mob_skills` VALUES (213,??,'blast_shot'
-- INSERT INTO `mob_skills` VALUES (214,??,'heavy_shot'
-- INSERT INTO `mob_skills` VALUES (215,??,'detonator'
-- INSERT INTO `mob_skills` VALUES (216,??,'coronach'
-- INSERT INTO `mob_skills` VALUES (217,??,'trueflight'
-- INSERT INTO `mob_skills` VALUES (218,??,'leaden_salute'
-- INSERT INTO `mob_skills` VALUES (219,??,'numbing_shot'
-- INSERT INTO `mob_skills` VALUES (220,??,'wildfire'
-- INSERT INTO `mob_skills` VALUES (221,??,'last_stand'
-- INSERT INTO `mob_skills` VALUES (222,??,'terminus'
-- INSERT INTO `mob_skills` VALUES (224,??,'exenterator'
-- INSERT INTO `mob_skills` VALUES (225,??,'chant_du_cygne'
-- INSERT INTO `mob_skills` VALUES (226,??,'requiescat'
-- INSERT INTO `mob_skills` VALUES (227,??,'knights_of_rotund'
-- INSERT INTO `mob_skills` VALUES (228,??,'final_paradise'
-- INSERT INTO `mob_skills` VALUES (229,??,'fast_blade_ii'
-- INSERT INTO `mob_skills` VALUES (230,??,'dragon_blow'
-- INSERT INTO `mob_skills` VALUES (231,??,'maru_kala'
-- INSERT INTO `mob_skills` VALUES (232,??,'merciless_strike'
-- INSERT INTO `mob_skills` VALUES (233,??,'imperator'
-- INSERT INTO `mob_skills` VALUES (234,??,'dagda'
-- INSERT INTO `mob_skills` VALUES (235,??,'oshala'
-- INSERT INTO `mob_skills` VALUES (238,??,'uriel_blade'
-- INSERT INTO `mob_skills` VALUES (239,??,'glory_slash'
-- INSERT INTO `mob_skills` VALUES (240,??,'tartarus_torpor'
INSERT INTO `mob_skills` VALUES (241,241,'netherspikes',@CONE,0.0,10.0,2000,0,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (242,242,'carnal_nightmare',@AOE,0.0,10.0,2000,0,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (243,243,'aegis_schism',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (244,244,'dancing_chains',@AOE,0.0,10.0,2000,0,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (245,245,'barbed_crescent',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (246,246,'shackled_fists',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (247,247,'foxfire',@CONE,0.0,10.0,2000,0,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (248,248,'grim_halo',@AOE,0.0,10.0,2000,0,@ENEMY,@NONE,0,2,0,0,0);
INSERT INTO `mob_skills` VALUES (249,249,'netherspikes',@CONE,0.0,10.0,2000,0,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (250,250,'carnal_nightmare',@AOE,0.0,10.0,2000,0,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (251,251,'aegis_schism',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (252,252,'dancing_chains',@AOE,0.0,10.0,2000,0,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (253,253,'barbed_crescent',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (254,254,'vulcan_shot',@AOE,0.0,14.0,2000,0,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (255,190,'dimensional_death',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (256,253,'self-destruct_321',@AOETARGET,0.0,50.0,2000,500,(@PARTY | @ENEMY),0,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (257,1,'foot_kick',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (258,2,'dust_cloud',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (259,3,'whirl_claws',@AOE,0.0,5.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (260,4,'lamb_chop',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (261,5,'rage',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (262,6,'sheep_charge',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,1,0,0,0);
-- INSERT INTO `mob_skills` VALUES (263,7,'sheep_bleat',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (264,8,'sheep_song',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (265,9,'rage',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (266,10,'ram_charge',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,2,0,0,0);
INSERT INTO `mob_skills` VALUES (267,11,'rumble',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (268,12,'great_bleat',@AOE,0.0,12.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (269,13,'petribreath',@CONE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (270,14,'roar',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (271,15,'razor_fang',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (272,16,'ranged_attack',@SINGLE,0.0,25.0,2000,0,@ENEMY,@NO_TP_COST,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (273,17,'claw_cyclone',@CONE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (274,6,'sheep_charge_melee',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NONE,0,1,0,0,0); -- Hostile Herbivores BCNM melee specials
INSERT INTO `mob_skills` VALUES (275,809,'sand_blast',@AOE,0.0,8.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (276,810,'sand_pit',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (277,811,'venom_spray',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (278,812,'pit_ambush',@SINGLE,0.0,9.0,2000,0,@ENEMY,@NO_TP_COST,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (279,813,'mandibular_bite',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (280,24,'sonic_wave',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (281,25,'stomping',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (282,26,'back_kick',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (283,27,'spinning_tail',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (284,28,'cold_stare',@CONE,0.0,15.0,2000,2000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (285,29,'whistle',@AOE,0.0,20.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (286,30,'berserk',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (287,31,'healing_breeze',@AOE,0.0,15.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (288,32,'vicious_claw',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (289,33,'stone_throw',@SINGLE,0.0,25.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (290,34,'spinning_claw',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (291,35,'claw_storm',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (292,36,'blank_gaze_dispel',@SINGLE,0.0,16.0,2000,2000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (293,37,'whistle_call',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (294,38,'eye_scratch',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (295,39,'magic_fruit',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (296,72,'drill_branch',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (297,41,'pinecone_bomb',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (298,42,'leafstorm',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (299,76,'entangle',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (300,44,'head_butt',@SINGLE,0.0,7.0,1500,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (301,45,'dream_flower',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (302,46,'wild_oats',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (303,47,'hundred_fists',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (304,48,'photosynthesis',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (305,49,'leaf_dagger',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (306,50,'scream',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (307,439,'substitute',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (308,52,'frogkick',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (309,53,'spore',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (310,54,'queasyshroom',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (311,55,'numbshroom',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (312,56,'shakeshroom',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (313,57,'counterspore',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (314,58,'silence_gas',@CONE,0.0,13.5,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (315,59,'dark_spore',@CONE,0.0,13.5,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (316,60,'impale',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (317,61,'vampiric_lash',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (318,401,'somersault',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (319,63,'bad_breath',@CONE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (320,64,'sweet_breath',@CONE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (321,65,'needleshot',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (322,66,'1000_needles',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (323,37,'wild_carrot',@SINGLE,0.0,20.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (324,68,'photosynthesis',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (325,161,'random_kiss',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (326,164,'absorbing_kiss',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (327,165,'deep_kiss',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (328,72,'drill_branch',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (329,73,'pinecone_bomb',@SINGLE,0.0,23.5,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (330,74,'shuffle',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (331,75,'leafstorm',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (332,76,'entangle',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (333,77,'double_down',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (334,78,'sharp_sting',@SINGLE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (335,79,'pollen',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (336,80,'final_sting',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (337,81,'noisy_buzz',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (338,82,'power_attack_beetle',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (339,83,'hi-freq_field',@CONE,0.0,16.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (340,84,'rhino_attack',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,1,0,0,0);
INSERT INTO `mob_skills` VALUES (341,85,'rhino_guard',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (342,86,'vulcanian_impact',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (343,87,'spoil',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (344,88,'sticky_thread',@CONE,0.0,12.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (345,89,'poison_breath',@CONE,0.0,12.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (346,90,'cocoon',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (347,889,'velocious_blade',@SINGLE,0.0,3.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0); -- sword form only
INSERT INTO `mob_skills` VALUES (348,92,'numbing_breath',@CONE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (349,93,'cold_breath',@CONE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (350,94,'mandible_bite',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,2,0,0,0);
INSERT INTO `mob_skills` VALUES (351,95,'poison_sting',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (352,96,'stunning_tail',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (353,97,'death_scissors',@SINGLE,0.0,9.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (354,98,'wild_rage',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (355,99,'earth_pounder',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (356,100,'sharp_strike',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (357,825,'heavy_blow',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (358,826,'heavy_whisk',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,2,0,0,0);
INSERT INTO `mob_skills` VALUES (359,827,'bionic_boost',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (360,828,'flying_hip_press',@AOE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (361,829,'earth_shock',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (362,830,'double_claw',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (363,831,'grapple',@CONE,0.0,12.5,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (364,832,'filamented_hold',@CONE,0.0,12.5,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (365,833,'spinning_top',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (366,110,'tail_blow',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (367,111,'fireball',@AOETARGET,0.0,11.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (368,112,'blockhead',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,1,0,0,0);
INSERT INTO `mob_skills` VALUES (369,113,'brain_crush',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (370,114,'baleful_gaze',@SINGLE,0.0,10.0,2000,2000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (371,115,'plague_breath',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (372,116,'infrasonics',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (373,117,'secretion',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (374,118,'ripper_fang',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (375,119,'backlash_tail',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (376,120,'foul_breath',@CONE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0); -- Only used in dry desert/mountainous areas
INSERT INTO `mob_skills` VALUES (377,121,'frost_breath',@CONE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0); -- Only the raptors in uleguerand range will use this move
INSERT INTO `mob_skills` VALUES (378,122,'thunderbolt_breath',@CONE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0); -- Only used by raptors in stormy areas (s. champagn,???)
INSERT INTO `mob_skills` VALUES (379,123,'chomp_rush',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (380,124,'scythe_tail',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,1,0,0,0);
-- INSERT INTO `mob_skills` VALUES (381,125,'chameleon_skin',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (382,819,'tail_roll',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (383,820,'tusk',@SINGLE,0.0,7.0,2000,2000,@ENEMY,@NONE,0,2,0,0,0);
INSERT INTO `mob_skills` VALUES (384,821,'scutum',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (385,822,'bone_crunch',@SINGLE,0.0,7.0,2000,2000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (386,823,'awful_eye',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (387,824,'heavy_bellow',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (388,857,'vanity_dive',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (389,858,'empty_beleaguer',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (390,859,'mirage',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (391,860,'aura_of_persistence',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (392,136,'ultrasonics',@AOE,0.0,16.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (393,137,'sonic_boom',@AOE,0.0,12.5,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (394,138,'blood_drain',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (395,139,'jet_stream',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (396,140,'smite_of_fury',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (397,276,'flurry_of_rage',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (398,142,'whispers_of_ire',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (399,143,'scratch',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (400,144,'triple_attack',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (401,145,'gliding_spike',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,1,0,0,0);
INSERT INTO `mob_skills` VALUES (402,146,'feather_barrier',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (403,147,'stormwind',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (404,435,'smite_of_rage',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (405,791,'dire_whorl',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (406,150,'hammer_beak',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (407,151,'poison_pick',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (408,152,'sound_vacuum',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (409,153,'tail_rod',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (410,154,'sound_blast',@AOE,0.0,16.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (411,155,'baleful_gaze',@SINGLE,0.0,10.0,2000,2000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (412,156,'ranged_attack',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NO_TP_COST,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (413,157,'eagle_eye_shot',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@ASTRAL_FLOW,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (414,158,'suction',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (415,159,'acid_mist',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (416,160,'sand_breath',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (417,161,'drainkiss',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (418,162,'regeneration',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (419,890,'scission_thrust',@CONE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0); -- sword form only
INSERT INTO `mob_skills` VALUES (420,164,'tp_drainkiss',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (421,165,'mp_drainkiss',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (422,891,'sonic_blade',@AOE,0.0,5.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0); -- sword form only
INSERT INTO `mob_skills` VALUES (423,167,'brain_drain',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (424,168,'full-force_blow',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,1,0,0,0);
INSERT INTO `mob_skills` VALUES (425,169,'gastric_bomb',@SINGLE,0.0,18.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (426,170,'sandspin',@AOE,0.0,12.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (427,171,'tremors',@AOE,0.0,12.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (428,172,'mp_absorption',@SINGLE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (429,173,'sound_vacuum',@SINGLE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (430,174,'buff_drain',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (431,175,'fluid_spread',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (432,176,'fluid_toss',@SINGLE,0.0,15.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (433,177,'digest',@SINGLE,0.0,7.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (434,806,'soporific',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (435,807,'palsy_pollen',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (436,808,'gloeosuccus',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (437,181,'death_ray',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (438,182,'hex_eye',@CONE,0.0,10.0,2000,500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (439,183,'petro_gaze',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (440,184,'catharsis',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (441,892,'microquake',@SINGLE,0.0,3.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0); -- polearm form only
INSERT INTO `mob_skills` VALUES (442,186,'bubble_shower',@AOE,0.0,12.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (443,187,'bubble_curtain',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (444,188,'big_scissors',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (445,189,'scissor_guard',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (446,190,'intimidate',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (447,893,'percussive_foin',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0); -- polearm form only
INSERT INTO `mob_skills` VALUES (448,192,'metallic_body',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (449,193,'intimidate',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (450,194,'aqua_ball',@AOETARGET,0.0,12.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (451,195,'splash_breath',@CONE,0.0,12.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (452,196,'screwdriver',@SINGLE,0.0,9.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (453,197,'water_wall',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (454,198,'water_shield',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (455,199,'aqua_lens',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (456,200,'tentacle',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (457,894,'gravity_wheel',@AOE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0); -- polearm form only
INSERT INTO `mob_skills` VALUES (458,202,'ink_jet',@CONE,0.0,12.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (459,203,'hard_membrane',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (460,204,'cross_attack',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (461,205,'regeneration',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (462,206,'maelstrom',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (463,207,'whirlwind',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (464,895,'psychomancy',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0); -- staff form only
INSERT INTO `mob_skills` VALUES (465,209,'howling',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (466,210,'poison_breath',@CONE,0.0,12.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (467,211,'rot_gas',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (468,212,'dirty_claw',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (469,213,'shadow_claw',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (470,214,'methane_breath',@CONE,0.0,12.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (471,896,'mind_wall',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0); -- staff form only
INSERT INTO `mob_skills` VALUES (472,216,'grave_reel',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (473,217,'ectosmash',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (474,218,'fear_touch',@SINGLE,0.0,7.0,3000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (475,219,'terror_touch',@SINGLE,0.0,7.0,3000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (476,220,'curse',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (477,221,'dark_sphere',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (478,222,'hell_slash',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (479,223,'horror_cloud',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (480,288,'petrifactive_breath',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (481,225,'frenzied_rage',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (482,290,'pounce',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (483,291,'charged_whisker',@AOE,0.0,12.5,2000,2000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (484,228,'black_cloud',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (485,229,'blood_saber',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (486,230,'whip_tongue',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,1,0,0,0);
INSERT INTO `mob_skills` VALUES (487,897,'transmogrification',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0); -- hand form only
INSERT INTO `mob_skills` VALUES (488,232,'acid_breath',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (489,233,'stinking_gas',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (490,234,'undead_mold',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (491,235,'call_of_the_grave',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (492,236,'abyss_blast',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (493,846,'rampant_gnaw',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (494,847,'big_horn',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,1,0,0,0);
INSERT INTO `mob_skills` VALUES (495,848,'snort',@CONE,0.0,12.5,2000,1500,@ENEMY,@NONE,0,3,0,0,0);
INSERT INTO `mob_skills` VALUES (496,849,'rabid_dance',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (497,850,'lowing',@AOE,0.0,15.0,2000,2500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (498,851,'triclip',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (499,852,'back_swish',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,1,0,0,0);
INSERT INTO `mob_skills` VALUES (500,853,'mow',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (501,854,'frightful_roar',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (502,855,'mortal_ray',@SINGLE,0.0,10.0,2000,2000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (503,856,'unblessed_armor',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (504,861,'gas_shell',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (505,862,'venom_shell',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (506,863,'palsynyxis',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (507,864,'painful_whip',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (508,865,'suctorial_tentacle',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (509,253,'self-destruct',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (510,254,'berserk',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (511,253,'self-destruct',@AOE,0.0,20.0,2000,3000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (512,256,'heat_wave',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (513,257,'smite_of_rage',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (514,258,'whirl_of_rage',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (515,814,'toxic_spit',@SINGLE,0.0,9.5,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (516,815,'geist_wall',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (517,816,'numbing_noise',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (518,817,'nimble_snap',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (519,818,'cyclotail',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (520,264,'double_ray',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (521,265,'spinning_attack',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,1,0,0,0);
INSERT INTO `mob_skills` VALUES (522,266,'spectral_barrier',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (523,267,'mysterious_light',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (524,268,'mind_drain',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (525,269,'battery_charge',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (526,875,'berserk',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (527,876,'freeze_rush',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (528,877,'cold_wave',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (529,878,'hypothermal_combustion',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (530,900,'memento_mori',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (531,901,'silence_seal',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (532,902,'envoutement',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (533,903,'danse_macabre',@SINGLE,0.0,10.0,2000,2000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (534,278,'kartstrahl',@SINGLE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (535,279,'blitzstrahl',@SINGLE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (536,280,'panzerfaust',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,2,0,0,0);
INSERT INTO `mob_skills` VALUES (537,281,'berserk',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (538,282,'panzerschreck',@SINGLE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (539,283,'typhoon',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,1,0,0,0);
INSERT INTO `mob_skills` VALUES (540,898,'tremorous_tread',@AOE,0.0,5.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (541,285,'gravity_field',@AOETARGET,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (542,899,'empty_seed',@AOE,0.0,20.0,2000,2000,@ENEMY,@NONE,0,7,0,0,0);
INSERT INTO `mob_skills` VALUES (543,287,'meltdown',@AOE,0.0,15.0,2000,5000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (544,288,'camisado',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (545,289,'somnolence',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (546,290,'noctoshield',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (547,291,'ultimate_terror',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (548,292,'blindeye',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (549,293,'eyes_on_me',@SINGLE,0.0,13.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (550,294,'hypnosis',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (551,295,'mind_break',@CONE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (552,296,'binding_wave',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (553,297,'airy_shield',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (554,298,'pet_charm',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (555,299,'magic_barrier',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (556,300,'dream_shroud',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (557,301,'level_5_petrify',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (558,302,'nightmare',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (559,303,'soul_drain',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (560,304,'hecatomb_wave',@CONE,0.0,10.0,2000,2000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (561,971,'electromagnetic_field',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,1,0,0,0);
INSERT INTO `mob_skills` VALUES (562,972,'reactive_armor',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (563,307,'demonic_howl',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (564,311,'condemnation',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (565,309,'quadrastrike',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (566,310,'quadrastrike',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (567,866,'sling_bomb',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (568,867,'formation_attack',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (569,868,'refueling',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (570,869,'circle_of_flames',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (571,870,'self-destruct',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (572,871,'self-destruct',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (573,317,'self-destruct',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (574,318,'self-destruct',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (575,319,'self-destruct',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (576,910,'back_heel',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,2,0,0,0);
-- INSERT INTO `mob_skills` VALUES (577,321,'jettatura',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (578,912,'nihility_song',@AOE,0.0,12.5,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (579,323,'choke_breath',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (580,324,'fantod',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (581,325,'blow',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (582,326,'cacodemonia',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (583,327,'beatdown',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (584,328,'uppercut',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,2,0,0,0);
-- INSERT INTO `mob_skills` VALUES (585,329,'hekaton_punch',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (586,330,'blank_gaze',@SINGLE,0.0,7.0,2000,2000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (587,331,'antiphase',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (588,398,'death_trap',@AOE,0.0,30.0,2000,2000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (589,333,'mortal_ray',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (590,334,'goblin_rush',@SINGLE,0.0,6.0,2000,1500,@ENEMY,@NONE,0,1,0,0,0);
INSERT INTO `mob_skills` VALUES (591,335,'bomb_toss',@AOETARGET,0.0,13.5,2000,2000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (592,336,'bomb_toss_suicide',@AOE,0.0,13.5,2000,2000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (593,337,'berserk',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (594,880,'pl_vulcanian_impact',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (595,881,'heat_wave',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (596,882,'pl_hellstorm',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (597,883,'self-destruct',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (598,1598,'berserk',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (599,885,'arctic_impact',@AOE,0.0,15.0,2000,2000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (600,886,'cold_wave',@AOE,0.0,15.0,2000,2000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (601,887,'hiemal_storm',@AOE,0.0,15.0,2000,2000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (602,346,'hypothermal_combustion',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (603,432,'lateral_slash',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (604,433,'throat_stab',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (605,349,'aerial_wheel',@SINGLE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (606,350,'shoulder_attack',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,1,0,0,0);
INSERT INTO `mob_skills` VALUES (607,351,'slam_dunk',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (608,352,'arm_block',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (609,353,'battle_dance',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (610,354,'nether_blast',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (611,355,'ore_toss',@SINGLE,0.0,10.0,2000,2000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (612,356,'head_butt',@SINGLE,0.0,7.0,2000,2000,@ENEMY,@NONE,0,1,0,0,0);
INSERT INTO `mob_skills` VALUES (613,357,'shell_bash',@SINGLE,0.0,7.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (614,358,'shell_guard',@SINGLE,0.0,7.0,2000,3000,@SELF,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (615,359,'hellspin',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (616,360,'ruinous_omen',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (617,361,'feather_storm',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (618,362,'double_kick',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,1,0,0,0);
INSERT INTO `mob_skills` VALUES (619,363,'parry',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (620,364,'sweep',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (621,969,'snowball',@AOETARGET,0.0,11.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (622,366,'helldive',@SINGLE,0.0,9.0,2000,1500,@ENEMY,@NONE,0,2,0,0,0);
INSERT INTO `mob_skills` VALUES (623,367,'wing_cutter',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (624,432,'vulture_1',@SINGLE,0.0,7.0,2000,0,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (625,433,'vulture_2',@SINGLE,0.0,7.0,2000,0,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (626,437,'vulture_3',@SINGLE,0.0,7.0,2000,0,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (627,438,'vulture_4',@SINGLE,0.0,7.0,2000,0,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (628,372,'wild_horn',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (629,373,'thunderbolt',@AOE,0.0,30.0,2000,1500,@ENEMY,@HIT_ALL,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (630,374,'kick_out',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (631,375,'shock_wave',@CONE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,2,0,0,0);
INSERT INTO `mob_skills` VALUES (632,376,'flame_armor',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (633,377,'howl',@AOE,0.0,20.0,2000,1500,@SELF,@NONE,0,0,0,0,0); -- Behemoth family Howl
-- INSERT INTO `mob_skills` VALUES (634,378,'meteor',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0); -- chlevnik's death meteor (not a normal meteor attack animation)
INSERT INTO `mob_skills` VALUES (635,379,'burst',@SINGLE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (636,380,'flame_arrow',@SINGLE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (637,381,'firebomb',@CONE,0.0,9.5,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (638,382,'blastbomb',@AOETARGET,0.0,13.5,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (639,383,'fountain',@CONE,0.0,9.5,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (640,384,'touchdown',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (641,973,'recoil_dive',@CONE,0.0,9.5,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (642,386,'flame_breath',@CONE,0.0,12.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (643,387,'poison_breath',@CONE,0.0,12.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (644,388,'wind_breath',@CONE,0.0,12.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (645,389,'body_slam',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (646,390,'heavy_stomp',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (647,391,'chaos_blade',@CONE,0.0,9.5,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (648,392,'petro_eyes',@CONE,0.0,9.5,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (649,393,'voidsong',@AOE,0.0,20.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (650,394,'thornsong',@SINGLE,0.0,15.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (651,395,'lodesong',@AOE,0.0,20.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (652,396,'blaster',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (653,397,'chaotic_eye',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (654,980,'double_whammy',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (655,399,'scurvy',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (656,982,'gilded_torpor',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (657,401,'calamitous_collapse',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (658,402,'catapult',@SINGLE,0.0,25.0,2000,0,@ENEMY,@NO_TP_COST,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (659,403,'cursed_sphere',@AOETARGET,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (660,404,'venom',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (661,970,'snow_cloud',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (662,406,'lightning_roar',@CONE,0.0,9.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (663,407,'ice_roar',@CONE,0.0,9.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (664,408,'impact_roar',@CONE,0.0,9.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (665,409,'grand_slam',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (666,410,'power_attack',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (667,411,'power_attack_weapon',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (668,412,'kick_back',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (669,413,'implosion',@AOE,0.0,60.0,2000,0,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (670,414,'implosion',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (671,415,'umbra_smash',@AOE,0.0,12.0,3000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (672,416,'giga_slash',@AOE,0.0,12.0,3000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (673,417,'dark_nova',@AOE,0.0,12.0,3000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (674,418,'crystal_shield',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (675,419,'heavy_strike',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (676,420,'ice_break',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (677,421,'thunder_break',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (678,422,'crystal_rain',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (679,423,'crystal_weapon_fire',@SINGLE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (680,424,'crystal_weapon_stone',@SINGLE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (681,425,'crystal_weapon_water',@SINGLE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (682,426,'crystal_weapon_wind',@SINGLE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (683,427,'bludgeon',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (684,428,'deal_out',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (685,429,'sprout_spin',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (686,430,'slumber_powder',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (687,431,'sprout_smack',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (688,432,'mighty_strikes',@SINGLE,0.0,7.0,2000,0,@SELF,@ASTRAL_FLOW,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (689,438,'benediction',@AOE,0.0,20.0,2000,0,@SELF,@ASTRAL_FLOW,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (690,436,'hundred_fists',@SINGLE,0.0,7.0,2000,0,@SELF,@ASTRAL_FLOW,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (691,433,'manafont',@SINGLE,0.0,7.0,2000,0,@SELF,@ASTRAL_FLOW,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (692,436,'chainspell',@SINGLE,0.0,7.0,2000,0,@SELF,@ASTRAL_FLOW,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (693,434,'perfect_dodge',@SINGLE,0.0,7.0,2000,0,@SELF,@ASTRAL_FLOW,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (694,438,'invincible',@SINGLE,0.0,7.0,2000,0,@SELF,@ASTRAL_FLOW,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (695,439,'blood_weapon',@SINGLE,0.0,7.0,2000,0,@SELF,@ASTRAL_FLOW,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (696,438,'soul_voice',@SINGLE,0.0,7.0,2000,0,@SELF,@ASTRAL_FLOW,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (697,441,'berserk',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (698,442,'defender',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (699,443,'aggressor',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (700,444,'boost',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (701,445,'focus',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (702,446,'dodge',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (703,447,'chakra',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (704,448,'counterstance',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (705,449,'hide',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (706,450,'bash',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (707,451,'sentinel',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (708,452,'last_resort',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (709,439,'souleater',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (710,438,'charm',@SINGLE,0.0,18.0,2000,0,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (711,455,'eagle_eye_shot',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@ASTRAL_FLOW,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (712,456,'eagle_eye_shot',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@ASTRAL_FLOW,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (713,457,'sharpshot',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (714,458,'camouflage',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (715,459,'barrage',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (716,460,'shadowbind',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (717,92,'venom_breath',@CONE,0.0,20.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0); -- hnm only
-- INSERT INTO `mob_skills` VALUES (718,440,'jump',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (719,94,'critical_bite',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (720,95,'venom_sting',@SINGLE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (721,97,'stasis',@SINGLE,0.0,9.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0); -- hnm only
INSERT INTO `mob_skills` VALUES (722,98,'venom_storm',@AOE,0.0,40.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (723,99,'earthbreaker',@AOE,0.0,40.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (724,100,'evasion',@SINGLE,0.0,9.0,2000,1500,@SELF,@NONE,0,0,0,0,0); -- hnm only
INSERT INTO `mob_skills` VALUES (725,60,'impale',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (726,61,'drain_whip',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (727,63,'bad_breath',@AOE,0.0,40.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (728,64,'sweet_breath',@AOE,0.0,40.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (729,473,'death_trap',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (730,438,'meikyo_shisui',@SINGLE,0.0,7.0,2000,0,@SELF,@ASTRAL_FLOW,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (731,18,'mijin_gakure',@AOE,0.0,20.0,2000,0,@ENEMY,@ASTRAL_FLOW,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (732,438,'call_wyvern',@SINGLE,0.0,7.0,2000,0,@SELF,@ASTRAL_FLOW,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (733,351,'jump',@SINGLE,0.0,9.5,2000,0,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (734,438,'astral_flow',@SINGLE,0.0,7.0,2000,0,@SELF,@ASTRAL_FLOW,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (735,19,'eagle_eye_shot',@SINGLE,0.0,25.0,2000,0,@ENEMY,@ASTRAL_FLOW,0,0,0,0,0); -- goblin
INSERT INTO `mob_skills` VALUES (736,20,'eagle_eye_shot',@SINGLE,0.0,25.0,2000,0,@ENEMY,@ASTRAL_FLOW,0,0,0,0,0); -- antica
INSERT INTO `mob_skills` VALUES (737,21,'eagle_eye_shot',@SINGLE,0.0,25.0,2000,0,@ENEMY,@ASTRAL_FLOW,0,0,0,0,0); -- Orc
INSERT INTO `mob_skills` VALUES (738,22,'eagle_eye_shot',@SINGLE,0.0,25.0,2000,0,@ENEMY,@ASTRAL_FLOW,0,0,0,0,0); -- formor / shadow
INSERT INTO `mob_skills` VALUES (739,23,'eagle_eye_shot',@SINGLE,0.0,25.0,2000,0,@ENEMY,@ASTRAL_FLOW,0,0,0,0,0); -- giga
INSERT INTO `mob_skills` VALUES (740,432,'familiar',@SINGLE,0.0,7.0,2000,0,@SELF,@ASTRAL_FLOW,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (741,904,'quadratic_continuum',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (742,904,'quadratic_continuum',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (743,487,'quadratic_continuum',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (744,905,'spirit_absorption',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,150,0,0,0,0);
INSERT INTO `mob_skills` VALUES (745,905,'spirit_absorption',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,150,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (746,490,'spirit_absorption',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (747,906,'vanity_drive',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,1,0,0,0);
INSERT INTO `mob_skills` VALUES (748,906,'vanity_drive',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,1,0,0,0);
-- INSERT INTO `mob_skills` VALUES (749,493,'vanity_drive',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (750,907,'stygian_flatus',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (751,495,'stygian_flatus',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (752,908,'promyvion_barrier',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (753,908,'promyvion_barrier',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (754,498,'promyvion_barrier',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (755,909,'fission',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (756,500,'level_5_petrify',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (757,501,'howl',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (758,502,'howl',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (759,503,'howl',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (760,504,'howl',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (761,505,'howl',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (762,354,'howl',@AOE,0.0,20.0,2000,1500,@SELF,@NONE,0,0,0,0,0);-- Quadav
-- INSERT INTO `mob_skills` VALUES (763,507,'howl',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (764,354,'howl',@AOE,0.0,20.0,2000,1500,@SELF,@NONE,0,0,0,0,0); -- Yagudo
-- INSERT INTO `mob_skills` VALUES (765,509,'howl',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (766,354,'howl',@AOE,0.0,20.0,2000,1500,@SELF,@NONE,0,0,0,0,0); -- Orc
-- INSERT INTO `mob_skills` VALUES (767,511,'bow',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (768,512,'jumping_strike',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (769,513,'flying_punch',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (770,442,'jumping_thrust',@SINGLE,0.0,9.5,2000,0,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (771,443,'hydro_ball',@CONE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (772,516,'hydroball',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (773,517,'hydroball',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (774,446,'bubble_armor',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (775,519,'bubble_armor',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (776,520,'bubble_armor',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (777,449,'hydro_shot',@SINGLE,0.0,10.0,2000,3000,@ENEMY,@NONE,0,1,0,0,0);
-- INSERT INTO `mob_skills` VALUES (778,522,'hydro_shot',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (779,523,'hydro_shot',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (780,452,'spinning_fin',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (781,525,'spinning_fin',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (782,526,'spinning_fin',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (783,455,'words_of_bane',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (784,456,'sigh',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (785,457,'light_of_penance',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (786,458,'lateral_slash',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (787,459,'vertical_slash',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (788,460,'throat_stab',@SINGLE,0.0,3.4,2000,3500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (789,461,'spikeball',@SINGLE,0.0,13.5,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (790,462,'shoulder_slam',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,1,0,0,0);
INSERT INTO `mob_skills` VALUES (791,463,'magnetite_cloud',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (792,464,'sandstorm',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (793,465,'sand_veil',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (794,466,'sand_shield',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (795,467,'sand_trap',@AOE,0.0,12.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (796,468,'jamming_wave',@AOE,0.0,16.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (797,469,'deadly_hold',@SINGLE,0.0,7.0,2000,1800,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (798,470,'tail_swing',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (799,471,'tail_smash',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (800,472,'heat_breath',@CONE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (801,473,'riddle',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (802,474,'great_sandstorm',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (803,475,'great_whirlwind',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (804,476,'tortoise_song',@AOE,0.0,20.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (805,477,'head_butt_turtle',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,2,0,0,0);
INSERT INTO `mob_skills` VALUES (806,478,'tortoise_stomp',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (807,479,'harden_shell',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (808,480,'earth_breath',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (809,481,'aqua_breath',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (810,482,'sickle_slash',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (811,483,'acid_spray',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (812,484,'spider_web',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (813,485,'dispelling_wind',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (814,486,'deadly_drive',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (815,487,'wind_wall',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (816,488,'fang_rush',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (817,489,'dread_shriek',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (818,490,'tail_crush',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (819,491,'blizzard_breath',@CONE,0.0,18.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (820,492,'thunder_breath',@CONE,0.0,18.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (821,493,'radiant_breath',@CONE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (822,494,'chaos_breath',@CONE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (823,495,'fire_blade',@SINGLE,0.0,7.0,2000,0,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (824,496,'frost_blade',@SINGLE,0.0,7.0,2000,0,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (825,497,'wind_blade2',@SINGLE,0.0,7.0,2000,0,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (826,498,'earth_blade',@SINGLE,0.0,7.0,2000,0,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (827,499,'lightning_blade',@SINGLE,0.0,7.0,2000,0,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (828,500,'water_blade',@SINGLE,0.0,7.0,2000,0,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (829,501,'great_wheel',@AOE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (830,502,'light_blade',@SINGLE,0.0,30.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (831,513,'moonlit_charge',@SINGLE,0.0,10.0,512,3000,@ENEMY,@BLOOD_PACT_RAGE,0,7,2,0,0); -- Compression (2)
INSERT INTO `mob_skills` VALUES (832,514,'crescent_fang',@SINGLE,0.0,10.0,513,3000,@ENEMY,@BLOOD_PACT_RAGE,0,0,1,0,0); -- Transfixion (1)
INSERT INTO `mob_skills` VALUES (833,515,'lunar_cry',@SINGLE,0.0,10.0,514,3000,@ENEMY,@BLOOD_PACT_WARD,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (834,516,'ecliptic_growl',@AOE,0.0,10.0,516,3000,@SELF,@BLOOD_PACT_WARD,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (835,517,'lunar_roar',@AOE,0.0,10.0,515,3000,@ENEMY,@BLOOD_PACT_WARD,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (836,518,'eclipse_bite',@SINGLE,0.0,10.0,518,3000,@ENEMY,@BLOOD_PACT_RAGE,0,0,9,4,0); -- Gravitation (9) / Scission (4)
INSERT INTO `mob_skills` VALUES (837,519,'ecliptic_howl',@AOE,0.0,10.0,517,3000,@SELF,@BLOOD_PACT_WARD,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (838,521,'howling_moon',@AOE,0.0,30.0,520,3000,@ENEMY,@BLOOD_PACT_RAGE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (839,521,'howling_moon',@AOE,0.0,30.0,520,3000,@ENEMY,@BLOOD_PACT_RAGE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (840,526,'punch',@SINGLE,0.0,10.0,528,3000,@ENEMY,@BLOOD_PACT_RAGE,0,0,3,0,0); -- Liquefication (3)
INSERT INTO `mob_skills` VALUES (841,527,'fire_ii',@SINGLE,0.0,10.0,529,3000,@ENEMY,@BLOOD_PACT_RAGE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (842,528,'burning_strike',@SINGLE,0.0,10.0,530,3000,@ENEMY,@BLOOD_PACT_RAGE,0,0,8,0,0); -- Impaction (8)
INSERT INTO `mob_skills` VALUES (843,529,'double_punch',@SINGLE,0.0,10.0,531,3000,@ENEMY,@BLOOD_PACT_RAGE,0,0,2,0,0); -- Compression (2)
INSERT INTO `mob_skills` VALUES (844,530,'crimson_howl',@AOE,0.0,10.0,532,3000,@SELF,@BLOOD_PACT_WARD,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (845,531,'fire_iv',@SINGLE,0.0,10.0,533,3000,@ENEMY,@BLOOD_PACT_RAGE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (846,532,'flaming_crush',@SINGLE,0.0,10.0,534,3000,@ENEMY,@BLOOD_PACT_RAGE,0,0,11,5,0); -- Fusion (11) / Reverberation (5)
INSERT INTO `mob_skills` VALUES (847,533,'meteor_strike',@SINGLE,0.0,10.0,535,3000,@ENEMY,@BLOOD_PACT_RAGE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (848,534,'inferno',@AOE,0.0,30.0,536,3000,@ENEMY,@BLOOD_PACT_RAGE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (849,539,'rock_throw',@SINGLE,0.0,12.0,544,3000,@ENEMY,@BLOOD_PACT_RAGE,0,0,4,0,0); -- Scission (4)
INSERT INTO `mob_skills` VALUES (850,540,'stone_ii',@SINGLE,0.0,10.0,545,3000,@ENEMY,@BLOOD_PACT_RAGE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (851,541,'rock_buster',@SINGLE,0.0,10.0,546,3000,@ENEMY,@BLOOD_PACT_RAGE,0,0,5,0,0); -- Reverberation (5)
INSERT INTO `mob_skills` VALUES (852,542,'megalith_throw',@SINGLE,0.0,17.0,547,3000,@ENEMY,@BLOOD_PACT_RAGE,0,0,7,0,0); -- Induration (7)
INSERT INTO `mob_skills` VALUES (853,543,'earthen_ward',@AOE,0.0,10.0,548,3000,@SELF,@BLOOD_PACT_WARD,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (854,544,'stone_iv',@SINGLE,0.0,10.0,549,3000,@ENEMY,@BLOOD_PACT_RAGE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (855,545,'mountain_buster',@SINGLE,0.0,10.0,550,3000,@ENEMY,@BLOOD_PACT_RAGE,0,0,9,7,0); -- Gravitation (9) / Induration (7)
INSERT INTO `mob_skills` VALUES (856,546,'geocrush',@SINGLE,0.0,10.0,551,3000,@ENEMY,@BLOOD_PACT_RAGE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (857,547,'earthen_fury',@AOE,0.0,30.0,552,3000,@ENEMY,@BLOOD_PACT_RAGE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (858,552,'barracuda_dive',@SINGLE,0.0,10.0,560,3000,@ENEMY,@BLOOD_PACT_RAGE,0,0,5,0,0); -- Reverberation (5)
INSERT INTO `mob_skills` VALUES (859,553,'water_ii',@SINGLE,0.0,10.0,561,3000,@ENEMY,@BLOOD_PACT_RAGE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (860,554,'tail_whip',@SINGLE,0.0,10.0,562,3000,@ENEMY,@BLOOD_PACT_RAGE,0,0,6,0,0); -- Detonation (6)
INSERT INTO `mob_skills` VALUES (861,555,'spring_water',@AOE,0.0,10.0,563,3000,@SELF,@BLOOD_PACT_WARD,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (862,556,'slowga',@AOE,0.0,10.0,564,3000,@ENEMY,@BLOOD_PACT_WARD,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (863,557,'water_iv',@SINGLE,0.0,20.0,565,3000,@ENEMY,@BLOOD_PACT_RAGE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (864,558,'spinning_dive',@SINGLE,0.0,10.0,566,3000,@ENEMY,@BLOOD_PACT_RAGE,0,0,10,6,0); -- Distortion (10) / Detonation (6)
INSERT INTO `mob_skills` VALUES (865,559,'grand_fall',@SINGLE,0.0,10.0,567,3000,@ENEMY,@BLOOD_PACT_RAGE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (866,560,'tidal_wave',@AOE,0.0,30.0,568,3000,@ENEMY,@BLOOD_PACT_RAGE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (867,565,'claw',@SINGLE,0.0,10.0,576,3000,@ENEMY,@BLOOD_PACT_RAGE,0,0,6,0,0); -- Detonation (6)
INSERT INTO `mob_skills` VALUES (868,566,'aero_ii',@SINGLE,0.0,10.0,577,3000,@ENEMY,@BLOOD_PACT_RAGE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (869,569,'whispering_wind',@AOE,0.0,10.0,578,3000,@SELF,@BLOOD_PACT_WARD,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (870,568,'hastega',@AOE,0.0,10.0,579,3000,@SELF,@BLOOD_PACT_WARD,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (871,567,'aerial_armor',@AOE,0.0,10.0,580,3000,@SELF,@BLOOD_PACT_WARD,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (872,570,'aero_iv',@SINGLE,0.0,10.0,581,3000,@ENEMY,@BLOOD_PACT_RAGE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (873,571,'predator_claws',@SINGLE,0.0,10.0,582,3000,@ENEMY,@BLOOD_PACT_RAGE,0,0,12,4,0); -- Fragmentation (12) / Scission (4)
INSERT INTO `mob_skills` VALUES (874,572,'wind_blade',@SINGLE,0.0,10.0,583,3000,@ENEMY,@BLOOD_PACT_RAGE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (875,573,'aerial_blast',@AOE,0.0,30.0,584,3000,@ENEMY,@BLOOD_PACT_RAGE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (876,578,'axe_kick',@SINGLE,0.0,10.0,592,3000,@ENEMY,@BLOOD_PACT_RAGE,0,0,7,0,0); -- Induration (7)
INSERT INTO `mob_skills` VALUES (877,579,'blizzard_ii',@SINGLE,0.0,10.0,593,3000,@ENEMY,@BLOOD_PACT_RAGE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (878,580,'frost_armor',@AOE,0.0,10.0,594,3000,@SELF,@BLOOD_PACT_WARD,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (879,581,'sleepga',@AOE,0.0,10.0,595,3000,@ENEMY,@BLOOD_PACT_WARD,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (880,582,'double_slap',@SINGLE,0.0,10.0,596,3000,@ENEMY,@BLOOD_PACT_RAGE,0,0,4,0,0); -- Scission (4)
INSERT INTO `mob_skills` VALUES (881,583,'blizzard_iv',@SINGLE,0.0,10.0,597,3000,@ENEMY,@BLOOD_PACT_RAGE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (882,584,'rush',@SINGLE,0.0,10.0,598,3000,@ENEMY,@BLOOD_PACT_RAGE,0,0,10,4,0); -- Distortion (10) / Scission (4)
INSERT INTO `mob_skills` VALUES (883,585,'heavenly_strike',@SINGLE,0.0,10.0,599,3000,@ENEMY,@BLOOD_PACT_RAGE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (884,586,'diamond_dust',@AOE,0.0,30.0,600,3000,@ENEMY,@BLOOD_PACT_RAGE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (885,591,'shock_strike',@SINGLE,0.0,10.0,608,3000,@ENEMY,@BLOOD_PACT_RAGE,0,0,8,0,0); -- Impaction (8)
INSERT INTO `mob_skills` VALUES (886,592,'thunder_ii',@SINGLE,0.0,10.0,609,3000,@ENEMY,@BLOOD_PACT_RAGE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (887,593,'rolling_thunder',@AOE,0.0,10.0,610,3000,@SELF,@BLOOD_PACT_WARD,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (888,594,'thunderspark',@AOE,0.0,10.0,611,3000,@ENEMY,@BLOOD_PACT_RAGE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (889,595,'lightning_armor',@AOE,0.0,10.0,612,3000,@SELF,@BLOOD_PACT_WARD,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (890,596,'thunder_iv',@SINGLE,0.0,10.0,613,3000,@ENEMY,@BLOOD_PACT_RAGE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (891,597,'chaotic_strike',@SINGLE,0.0,10.0,614,3000,@ENEMY,@BLOOD_PACT_RAGE,0,0,12,1,0); -- Fragmentation (12) / Transfixion (1)
INSERT INTO `mob_skills` VALUES (892,598,'thunderstorm',@SINGLE,0.0,10.0,615,3000,@ENEMY,@BLOOD_PACT_RAGE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (893,599,'judgment_bolt',@AOE,0.0,30.0,616,3000,@ENEMY,@BLOOD_PACT_RAGE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (894,621,'healing_breath_i',@SINGLE,0.0,10.0,2000,2000,@PARTY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (895,622,'healing_breath_ii',@SINGLE,0.0,10.0,2000,2000,@PARTY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (896,623,'healing_breath_iii',@SINGLE,0.0,10.0,2000,2000,@PARTY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (897,624,'remove_poison',@SINGLE,0.0,10.0,2000,1500,@PARTY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (898,625,'remove_blindness',@SINGLE,0.0,10.0,2000,1500,@PARTY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (899,626,'remove_paralysis',@SINGLE,0.0,10.0,2000,1500,@PARTY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (900,627,'pet_flame_breath',@SINGLE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (901,628,'pet_frost_breath',@SINGLE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (902,629,'pet_gust_breath',@SINGLE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (903,630,'pet_sand_breath',@SINGLE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (904,631,'pet_lightning_breath',@SINGLE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (905,632,'pet_hydro_breath',@SINGLE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (906,605,'healing_ruby',@SINGLE,0.0,10.0,496,3000,@PARTY,@BLOOD_PACT_WARD,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (907,606,'poison_nails',@SINGLE,0.0,10.0,497,3000,@ENEMY,@BLOOD_PACT_RAGE,0,0,1,0,0); -- Transfixion (1)
INSERT INTO `mob_skills` VALUES (908,607,'shining_ruby',@AOE,0.0,10.0,498,3000,@SELF,@BLOOD_PACT_WARD,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (909,608,'glittering_ruby',@AOE,0.0,10.0,499,3000,@SELF,@BLOOD_PACT_WARD,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (910,609,'meteorite',@SINGLE,0.0,10.0,500,3000,@ENEMY,@BLOOD_PACT_RAGE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (911,610,'healing_ruby_ii',@AOE,0.0,10.0,501,3000,@SELF,@BLOOD_PACT_WARD,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (912,611,'searing_light',@AOE,0.0,30.0,502,3000,@ENEMY,@BLOOD_PACT_RAGE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (913,534,'inferno',@AOE,0.0,30.0,2000,0,@ENEMY,@BLOOD_PACT_RAGE,0,0,0,0,0); -- mob avatar skills
INSERT INTO `mob_skills` VALUES (914,547,'earthen_fury',@AOE,0.0,30.0,2000,0,@ENEMY,@BLOOD_PACT_RAGE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (915,560,'tidal_wave',@AOE,0.0,30.0,2000,0,@ENEMY,@BLOOD_PACT_RAGE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (916,573,'aerial_blast',@AOE,0.0,30.0,2000,0,@ENEMY,@BLOOD_PACT_RAGE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (917,586,'diamond_dust',@AOE,0.0,30.0,2000,0,@ENEMY,@BLOOD_PACT_RAGE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (918,599,'judgment_bolt',@AOE,0.0,30.0,2000,0,@ENEMY,@BLOOD_PACT_RAGE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (919,611,'searing_light',@AOE,0.0,30.0,2000,0,@ENEMY,@BLOOD_PACT_RAGE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (920,503,'everyones_grudge',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (921,504,'everyones_rancor',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (922,143,'blind_vortex',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (923,144,'giga_scream',@SINGLE,0.0,7.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (924,145,'dread_dive',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,2,0,0,0);
-- INSERT INTO `mob_skills` VALUES (925,669,'feather_barrier',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (926,147,'stormwind',@AOE,0.0,15.0,6000,1500,@ENEMY,@NONE,0,0,0,0,0); -- animation times may very.
-- INSERT INTO `mob_skills` VALUES (927,671,'drill_branch',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (928,672,'pinecone_bomb',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (929,75,'leafstorm',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (930,674,'entangle',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (931,633,'cross_reaver',@CONE,0.0,7.0,2000,500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (932,634,'havoc_spiral',@AOE,0.0,7.0,2000,500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (933,635,'dominion_slash',@AOETARGET,0.0,10.0,2000,500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (934,638,'shield_strike',@CONE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (935,636,'amon_drive',@AOETARGET,0.0,15.0,2000,500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (936,639,'ark_guardian_tarutaru',@SINGLE,0.0,22.0,500,0,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (937,637,'dragonfall',@AOE,0.0,7.0,2000,500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (938,640,'circle_blade',@AOE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,5,8,0);
INSERT INTO `mob_skills` VALUES (939,641,'swift_blade',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,9,0,0);
INSERT INTO `mob_skills` VALUES (940,644,'rampage',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,4,0,0);
INSERT INTO `mob_skills` VALUES (941,645,'calamity',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,4,8,0);
INSERT INTO `mob_skills` VALUES (942,642,'spirits_within',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (943,643,'vorpal_blade',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,4,8,0);
INSERT INTO `mob_skills` VALUES (944,646,'spinning_scythe',@AOE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,5,4,0);
INSERT INTO `mob_skills` VALUES (945,647,'guillotine',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,7,0,0);
INSERT INTO `mob_skills` VALUES (946,648,'tachi_yukikaze',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,7,6,0);
INSERT INTO `mob_skills` VALUES (947,649,'tachi_gekko',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,10,5,0);
INSERT INTO `mob_skills` VALUES (948,650,'tachi_kasha',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,11,2,0);
-- INSERT INTO `mob_skills` VALUES (949,693,'flame_blast',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (950,652,'flame_blast_alt',@SINGLE,0.0,18.0,2000,0,@ENEMY,@NO_TP_COST,0,0,0,0,0); -- KS99_Wyrm regular airborne attack
INSERT INTO `mob_skills` VALUES (951,653,'hurricane_wing',@AOE,0.0,30.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (952,654,'spike_flail',@AOE,0.0,23.0,2000,2000,@ENEMY,@NONE,0,0,0,0,0); -- Alliance only targeting version of spike flail
INSERT INTO `mob_skills` VALUES (953,655,'dragon_breath',@CONE,0.0,18.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (954,656,'touchdown',@AOE,0.0,30.0,2000,0,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (955,657,'flame_blast',@AOE,0.0,30.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0); -- KS99_Wyrm airborne fire AoE
INSERT INTO `mob_skills` VALUES (956,658,'hurricane_wing_flying',@AOE,0.0,30.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0); -- KS99_Wyrm airborne Hurricane Wing
INSERT INTO `mob_skills` VALUES (957,659,'absolute_terror',@SINGLE,0.0,18.0,4000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (958,660,'horrid_roar_1',@SINGLE,0.0,18.0,4000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (959,703,'sickle_slash',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (960,704,'acid_spray',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (961,705,'spider_web',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (962,663,'tarutaru_warp_ii',@SINGLE,0.0,22.0,500,0,@SELF,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (963,707,'eald1',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (964,708,'eald1',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (965,709,'eald1',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (966,710,'eald1',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (967,711,'eald1',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (968,676,'red_lotus_blade',@SINGLE,0.0,7.0,2500,1500,@ENEMY,@NONE,0,0,3,6,0);
INSERT INTO `mob_skills` VALUES (969,677,'flat_blade',@SINGLE,0.0,7.0,2500,1500,@ENEMY,@NONE,0,0,8,0,0);
INSERT INTO `mob_skills` VALUES (970,678,'savage_blade',@SINGLE,0.0,7.0,2500,1500,@ENEMY,@NONE,0,0,12,4,0);
INSERT INTO `mob_skills` VALUES (971,669,'royal_bash',@AOETARGET,0.0,10.0,2000,500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (972,670,'royal_savior',@AOE,0.0,15.0,2000,200,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (973,679,'red_lotus_blade',@SINGLE,0.0,7.0,2500,1500,@ENEMY,@NONE,0,0,3,6,0);
INSERT INTO `mob_skills` VALUES (974,680,'spirits_within',@SINGLE,0.0,7.0,2500,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (975,681,'vorpal_blade',@SINGLE,0.0,7.0,2500,1500,@ENEMY,@NONE,0,0,4,8,0);
INSERT INTO `mob_skills` VALUES (976,673,'berserk-ruf',@AOE,0.0,15.0,2000,200,@SELF,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (977,721,'warp',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (978,722,'warp',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (979,682,'power_slash',@SINGLE,0.0,10.0,2000,500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (980,683,'freeze_bite',@SINGLE,0.0,10.0,2000,500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (981,684,'ground_strike',@SINGLE,0.0,10.0,2000,500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (982,671,'abyssal_drain',@SINGLE,0.0,10.0,2000,500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (983,672,'abyssal_strike',@SINGLE,0.0,10.0,2000,500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (984,685,'electrocharge',@SINGLE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (985,686,'stellar_burst',@AOETARGET,0.0,7.0,5000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (986,687,'vortex',@AOETARGET,0.0,20.0,5000,1000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (987,731,'shockwave',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (988,689,'eald2_warp_in',@SINGLE,0.0,22.0,500,0,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (989,690,'eald2_warp_out',@SINGLE,0.0,22.0,500,0,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (990,691,'gaea_stream_eta',@SINGLE,0.0,15.0,4000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (991,692,'uranos_cascade_eta',@AOETARGET,0.0,15.0,4000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (992,693,'cronos_sling_eta',@CONE,0.0,15.0,4000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (993,694,'phase_shift_1',@AOE,0.0,30.0,5000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (994,695,'gaea_stream_theta',@SINGLE,0.0,15.0,4000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (995,696,'uranos_cascade_theta',@AOETARGET,0.0,15.0,4000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (996,697,'cronos_sling_theta',@CONE,0.0,15.0,4000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (997,698,'phase_shift_2',@AOE,0.0,30.0,5000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (998,699,'gaea_stream_lambda',@SINGLE,0.0,15.0,4000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (999,700,'uranos_cascade_lambda',@AOETARGET,0.0,15.0,4000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1000,701,'cronos_sling_lambda',@CONE,0.0,15.0,4000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1001,702,'phase_shift_3',@AOE,0.0,30.0,5000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1002,708,'summonshadows',@SINGLE,0.0,10.0,3000,0,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1003,747,'#747',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1004,748,'#748',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1005,749,'#749',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1006,707,'omega_javelin',@SINGLE,0.0,15.0,4000,1000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1007,751,'#751',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1008,709,'mighty_strikes',@SINGLE,0.0,7.0,2000,0,@SELF,@ASTRAL_FLOW,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1009,710,'hundred_fists',@SINGLE,0.0,7.0,2000,0,@SELF,@ASTRAL_FLOW,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1010,711,'benediction',@AOE,0.0,7.0,2000,0,@SELF,@ASTRAL_FLOW,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1011,712,'manafont',@SINGLE,0.0,7.0,2000,0,@SELF,@ASTRAL_FLOW,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1012,713,'chainspell',@SINGLE,0.0,7.0,2000,0,@SELF,@ASTRAL_FLOW,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1013,714,'perfect_dodge',@SINGLE,0.0,7.0,2000,0,@SELF,@ASTRAL_FLOW,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1014,715,'invincible',@SINGLE,0.0,7.0,2000,0,@SELF,@ASTRAL_FLOW,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1015,716,'blood_weapon',@SINGLE,0.0,7.0,2000,0,@SELF,@ASTRAL_FLOW,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1016,717,'familiar',@SINGLE,0.0,7.0,2000,0,@SELF,@ASTRAL_FLOW,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1017,718,'call_beast',@SINGLE,0.0,7.0,2000,0,@SELF,@NO_TP_COST,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1018,719,'soul_voice',@SINGLE,0.0,7.0,2000,0,@SELF,@ASTRAL_FLOW,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1019,720,'eagle_eye_shot',@SINGLE,0.0,25.0,2000,0,@ENEMY,@ASTRAL_FLOW,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1020,721,'meikyo_shisui',@SINGLE,0.0,7.0,2000,0,@SELF,@ASTRAL_FLOW,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1021,722,'mijin_gakure',@AOE,0.0,20.0,2000,0,@ENEMY,@ASTRAL_FLOW,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1022,723,'call_wyvern',@SINGLE,0.0,7.0,2000,0,@SELF,@NO_TP_COST,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1023,438,'astral_flow_pet',@SINGLE,0.0,7.0,2000,0,@SELF,@ASTRAL_FLOW,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1024,725,'warp_out',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1025,726,'warp_in',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1026,727,'arbor_storm',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1027,728,'combo',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1028,729,'tackle',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1029,730,'one-ilm_punch',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1030,731,'backhand_blow',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1031,732,'spinning_attack',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1032,733,'howling_fist',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1033,734,'dragon_kick',@SINGLE,0.0,10.0,2000,0,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1034,735,'asuran_fists',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1035,736,'heavy_strike',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1036,737,'maats_bash',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NO_TP_COST,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1037,781,'fireball_1',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1038,782,'fireball_2',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1039,653,'hurricane_wing',@AOE,0.0,30.0,2000,1500,@ENEMY,@HIT_ALL,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1040,654,'spike_flail',@AOE,0.0,40.0,2000,2000,@ENEMY,@HIT_ALL,0,0,0,0,0); -- (nidhogg) outside alliance targeting version of spike flail
INSERT INTO `mob_skills` VALUES (1041,655,'dragon_breath',@CONE,0.0,18.0,2000,1500,@ENEMY,@HIT_ALL,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1042,786,'landing_to_the_surface',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1043,787,'giant_fireball_flying',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1044,788,'great_wing_gust_flying',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1045,659,'absolute_terror',@SINGLE,0.0,18.0,4000,1500,@ENEMY,@HIT_ALL,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1046,660,'horrid_roar_2',@SINGLE,0.0,18.0,4000,1500,@ENEMY,@HIT_ALL,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1047,476,'tortoise_song',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1048,477,'head_butt',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1049,478,'tortoise_stomp',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1050,479,'harden_shell',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1051,795,'earth_breath',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1052,796,'aqua_breath',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1053,432,'super_buff',@SINGLE,0.0,1.0,2000,0,@SELF,@NONE,0,0,0,0,0); -- Nidhogg self buff
-- INSERT INTO `mob_skills` VALUES (1054,798,'sabotender_dustdevil',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1055,799,'sabotender_duststop',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1056,800,'fanatic_dance',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1057,349,'aerial_wheel',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1058,350,'shoulder_attack',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1059,351,'slam_dunk',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1060,352,'arm_block',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1061,353,'battle_dance',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1062,354,'howl',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1063,807,'bow',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1064,351,'jump',@SINGLE,0.0,9.5,4000,0,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1065,21,'eagle_eye_shot',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@ASTRAL_FLOW,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1066,740,'fanatic_dance',@AOE,0.0,10.0,2000,2000,@ENEMY,@NONE,0,0,0,0,0); -- Only nm's in dynamis and falsespinner bhudbrodd
INSERT INTO `mob_skills` VALUES (1067,741,'doom',@SINGLE,0.0,9.0,2000,2000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1068,361,'feather_storm',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1069,362,'double_kick',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1070,363,'parry',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1071,364,'sweep',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1072,354,'howl',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1073,741,'doom',@SINGLE,0.0,9.0,2000,2000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1074,742,'the_wrath_of_gudha',@AOE,0.0,15.0,2000,2000,@ENEMY,@NONE,0,7,0,0,0);
INSERT INTO `mob_skills` VALUES (1075,355,'ore_toss',@SINGLE,0.0,7.0,2000,2000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1076,356,'head_butt',@SINGLE,0.0,7.0,2000,2000,@ENEMY,@NONE,0,1,0,0,0);
INSERT INTO `mob_skills` VALUES (1077,357,'shell_bash',@SINGLE,0.0,7.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1078,358,'shell_guard',@SINGLE,0.0,7.0,2000,3000,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1079,354,'howl',@AOE,0.0,20.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1080,742,'the_wrath_of_gudha',@AOE,0.0,15.0,2000,2000,@ENEMY,@NONE,0,7,0,0,0);
INSERT INTO `mob_skills` VALUES (1081,743,'frypan',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1082,744,'smokebomb',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1083,745,'smokebomb',@SINGLE,0.0,10.0,2000,1500,@SELF,@NONE,0,0,0,0,0); -- fail
INSERT INTO `mob_skills` VALUES (1084,746,'crispy_candle',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1085,747,'crispy_candle',@SINGLE,0.0,10.0,2000,1500,@SELF,@NONE,0,0,0,0,0); -- fail
INSERT INTO `mob_skills` VALUES (1086,748,'paralysis_shower',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1087,749,'paralysis_shower',@SINGLE,0.0,10.0,2000,1500,@SELF,@NONE,0,0,0,0,0); -- fail
INSERT INTO `mob_skills` VALUES (1088,334,'goblin_rush',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,1,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1089,335,'bomb_toss',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1090,834,'bomb_toss',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1091,19,'eagle_eye_shot',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@ASTRAL_FLOW,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1092,743,'frypan',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1093,744,'smokebomb',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1094,838,'smokebomb',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1095,746,'crispy_candle',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1096,747,'crispy_candle',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1097,748,'paralysis_shower',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1098,842,'paralysis_shower',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1099,750,'dice_heal',@AOE,0.0,10.0,3000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1100,751,'dice_curse',@AOE,0.0,10.0,3000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1101,752,'dice_damage',@AOE,0.0,10.0,3000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1102,753,'dice_stun',@AOE,0.0,10.0,3000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1103,754,'dice_poison',@AOE,0.0,10.0,3000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1104,755,'dice_disease',@AOE,0.0,10.0,3000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1105,756,'dice_sleep',@AOE,0.0,10.0,3000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1106,757,'dice_slow',@AOE,0.0,10.0,3000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1107,758,'dice_tp_loss',@AOE,0.0,10.0,3000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1108,759,'dice_dispel',@AOE,0.0,10.0,3000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1109,760,'dice_reset',@AOE,0.0,10.0,3000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1110,761,'seismostomp',@AOE,0.0,15.0,3000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1111,762,'numbing_glare',@CONE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1112,763,'seismostomp',@AOE,0.0,15.0,3000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1113,764,'tormentful_glare',@CONE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1114,765,'seismostomp',@AOE,0.0,15.0,3000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1115,766,'torpid_glare',@CONE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1116,767,'seismostomp',@AOE,0.0,15.0,3000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1117,768,'lead_breath',@CONE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1118,769,'lead_breath',@CONE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1119,863,'frag_bomb',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1120,69,'10000_needles',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1121,771,'eagle_eye_shot',@SINGLE,0.0,25.0,2000,0,@ENEMY,@ASTRAL_FLOW,0,0,0,0,0); -- yagudo move
INSERT INTO `mob_skills` VALUES (1122,770,'eagle_eye_shot',@SINGLE,0.0,25.0,2000,0,@ENEMY,@ASTRAL_FLOW,0,0,0,0,0); -- quadav move
-- INSERT INTO `mob_skills` VALUES (1123,355,'ore_toss',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1124,772,'regain_hp',@AOE,0.0,25.0,2000,0,@ENEMY,@NONE,0,0,0,0,0); -- Dyna Statues
INSERT INTO `mob_skills` VALUES (1125,773,'regain_mp',@AOE,0.0,25.0,2000,0,@ENEMY,@NONE,0,0,0,0,0); -- Dyna Statues
-- INSERT INTO `mob_skills` VALUES (1126,870,'#870',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1127,316,'dynamic_implosion',@AOE,0.0,18.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1128,817,'transfusion',@AOE,0.0,18.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1129,318,'mana_storm',@AOE,0.0,18.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1130,320,'dynamic_assault',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1131,324,'violent_rupture',@AOE,0.0,18.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1132,876,'oblivion_smash',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1133,322,'oblivion_smash',@AOE,0.0,18.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1134,321,'tera_slash',@CONE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1135,879,'tera_slash',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1136,292,'blindeye',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1137,293,'eyes_on_me',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1138,294,'hypnosis',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1139,295,'mind_break',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1140,296,'binding_wave',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1141,885,'airy_shield',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1142,886,'pet_charm',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1143,299,'magic_barrier',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1144,888,'level_5_petrify',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1145,889,'soul_drain',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1146,304,'hecatomb_wave',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1147,307,'demonic_howl',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1148,311,'condemnation',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1149,313,'quadrastrike',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1150,894,'quadrastrike',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1151,314,'eagle_eye_shot',@SINGLE,0.0,25.0,2000,0,@ENEMY,@ASTRAL_FLOW,0,0,0,0,0); -- kindred
-- INSERT INTO `mob_skills` VALUES (1152,304,'hecatomb_wave',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1153,897,'eagle_eye_shot',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@ASTRAL_FLOW,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1154,898,'ranged_attack',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NO_TP_COST,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1155,337,'subsonics',@AOE,0.0,16.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1156,338,'marrow_drain',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1157,339,'slipstream',@AOE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1158,340,'turbulence',@AOE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1159,903,'broadside_barrage',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1160,904,'blind_side_barrage',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1161,343,'damnation_dive',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,1,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1162,906,'inferno',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1163,907,'earthen_fury',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1164,908,'tidal_wave',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1165,909,'aerial_blast',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1166,910,'diamond_dust',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1167,911,'judgment_bolt',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1168,386,'flame_breath',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1169,913,'poison_breath',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1170,388,'wind_breath',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1171,389,'pl_body_slam',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1172,390,'pl_heavy_stomp',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1173,391,'pl_chaos_blade',@CONE,0.0,9.5,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1174,392,'pl_petro_eyes',@CONE,0.0,9.5,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1175,393,'voidsong',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1176,920,'thornsong',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1177,921,'lodesong',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1178,922,'flame_breath',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1179,923,'poison_breath',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1180,924,'wind_breath',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1181,925,'body_slam',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1182,926,'heavy_stomp',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1183,927,'chaos_blade',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1184,928,'petro_eyes',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1185,929,'voidsong',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1186,930,'thornsong',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1187,931,'lodesong',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1188,793,'final_heaven',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);         -- animated_knuckles
INSERT INTO `mob_skills` VALUES (1189,794,'mercy_stroke',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);         -- animated_dagger
INSERT INTO `mob_skills` VALUES (1190,792,'knights_of_round',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);     -- animated_longsword
INSERT INTO `mob_skills` VALUES (1191,799,'scourge',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);              -- animated_claymore
INSERT INTO `mob_skills` VALUES (1192,795,'onslaught',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);             -- animated_tabar
INSERT INTO `mob_skills` VALUES (1193,798,'metatron_torment',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);     -- animated_great_axe
INSERT INTO `mob_skills` VALUES (1194,796,'catastrophe',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);          -- animated_scythe
INSERT INTO `mob_skills` VALUES (1195,800,'geirskogul',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);           -- animated_spear
INSERT INTO `mob_skills` VALUES (1196,802,'blade_metsu',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);          -- animated_kunai
INSERT INTO `mob_skills` VALUES (1197,803,'tachi_kaiten',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);         -- animated_tachi
INSERT INTO `mob_skills` VALUES (1198,797,'randgrith',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);             -- animated_hammer
INSERT INTO `mob_skills` VALUES (1199,801,'gate_of_tartarus',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);     -- animated_staff
INSERT INTO `mob_skills` VALUES (1200,804,'namas_arrow',@SINGLE,0.0,18.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);          -- animated_longbow
INSERT INTO `mob_skills` VALUES (1201,805,'coronach',@SINGLE,0.0,18.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);            -- animated_gun
-- INSERT INTO `mob_skills` VALUES (1202,946,'ranged_attack',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NO_TP_COST,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1203,947,'ranged_attack',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NO_TP_COST,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1204,948,'ranged_attack',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NO_TP_COST,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1205,949,'ranged_attack',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NO_TP_COST,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1206,950,'ranged_attack',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NO_TP_COST,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1207,951,'arrow_squall',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1208,952,'arrow_squall',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1209,953,'ranged_attack',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NO_TP_COST,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1210,954,'ranged_attack',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NO_TP_COST,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1211,955,'ranged_attack',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NO_TP_COST,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1212,956,'ranged_attack',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NO_TP_COST,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1213,957,'ranged_attack',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NO_TP_COST,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1214,958,'ranged_attack',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NO_TP_COST,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1215,959,'infernal_roulette',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1216,960,'infernal_roulette',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1217,834,'empty_cutter',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1218,835,'vacuous_osculation',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1219,836,'hexagon_belt',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1220,837,'auroral_drape',@AOE,0.0,13.7,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1221,965,'memory_of_fire',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1222,966,'memory_of_ice',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1223,967,'memory_of_wind',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1224,968,'memory_of_light',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1225,969,'memory_of_earth',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1226,970,'memory_of_lightning',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1227,971,'memory_of_water',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1228,845,'memory_of_dark',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1229,919,'brain_spike',@SINGLE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1230,920,'empty_thrash',@SINGLE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1231,921,'promyvion_brume',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1232,922,'murk',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1233,923,'material_fend',@SINGLE,0.0,10.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1234,924,'carousel',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,4,0,0,0);
INSERT INTO `mob_skills` VALUES (1235,925,'pile_pitch',@SINGLE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1236,926,'guided_missile',@AOETARGET,0.0,5.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1237,927,'hyper_pulse',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1238,928,'target_analysis',@AOE,0.0,20.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1239,929,'discharger',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1240,930,'ion_efflux',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1241,931,'rear_lasers',@REARCONE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1242,933,'empty_cutter',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1243,934,'negative_whirl',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1244,935,'stygian_vapor',@AOE,0.0,8.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1245,936,'winds_of_promyvion',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1246,937,'spirit_absorption',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1247,938,'binary_absorption',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1248,939,'trinary_absorption',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1249,940,'spirit_tap',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1250,941,'binary_tap',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1251,942,'trinary_tap',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1252,943,'shadow_spread',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1253,956,'vanity_strike',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1254,957,'wanion',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1255,958,'occultation',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1256,959,'empty_crush',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,2,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1257,1001,'special_attack',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1258,961,'lamentation',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1259,944,'wire_cutter',@SINGLE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1260,945,'antimatter',@SINGLE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1261,946,'equalizer',@AOETARGET,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1262,947,'flame_thrower',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1263,948,'cryo_jet',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1264,949,'turbofan',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1265,950,'smoke_discharger',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1266,951,'high-tension_discharger',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1267,952,'hydro_canon',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1268,953,'nuclear_waste',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1269,954,'chemical_bomb',@SINGLE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1270,955,'particle_shield',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1271,933,'empty_cutter',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1272,1016,'negative_whirl',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1273,936,'winds_of_promyvion',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1274,919,'impalement',@SINGLE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1275,920,'empty_thrash',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1276,921,'promyvion_brume',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1277,1021,'inferno_blast',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1278,652,'inferno_blast_alt',@SINGLE,0.0,18.0,2000,0,@ENEMY,@NO_TP_COST,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1279,653,'tebbad_wing',@AOE,0.0,30.0,2000,1500,@ENEMY,@HIT_ALL,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1280,654,'spike_flail',@AOE,0.0,23.0,2000,2000,@ENEMY,@HIT_ALL,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1281,655,'fiery_breath',@CONE,0.0,18.0,2000,1500,@ENEMY,@HIT_ALL,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1282,656,'touchdown',@AOE,0.0,6.0,2000,0,@ENEMY,@HIT_ALL,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1283,657,'inferno_blast',@AOE,0.0,23.0,2000,2000,@ENEMY,@HIT_ALL,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1284,658,'tebbad_wing_air',@AOE,0.0,30.0,2000,1500,@ENEMY,@HIT_ALL,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1285,659,'absolute_terror',@SINGLE,0.0,18.0,2000,1500,@ENEMY,@HIT_ALL,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1286,660,'horrid_roar_3',@SINGLE,0.0,18.0,2000,1500,@ENEMY,@HIT_ALL,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1287,964,'sleet_blast',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1288,963,'sleet_blast_alt',@SINGLE,0.0,18.0,2000,0,@ENEMY,@NO_TP_COST,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1289,653,'gregale_wing',@AOE,0.0,30.0,2000,1500,@ENEMY,@HIT_ALL,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1290,654,'spike_flail',@AOE,0.0,23.0,2000,2000,@ENEMY,@HIT_ALL,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1291,962,'glacial_breath',@CONE,0.0,18.0,2000,1500,@ENEMY,@HIT_ALL,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1292,656,'touchdown',@AOE,0.0,6.0,2000,0,@ENEMY,@HIT_ALL,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1293,964,'sleet_blast',@AOE,0.0,23.0,2000,2000,@ENEMY,@HIT_ALL,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1294,658,'gregale_wing_air',@AOE,0.0,30.0,2000,1500,@ENEMY,@HIT_ALL,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1295,659,'absolute_terror',@SINGLE,0.0,18.0,4000,1500,@ENEMY,@HIT_ALL,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1296,660,'horrid_roar_3',@SINGLE,0.0,18.0,4000,1500,@ENEMY,@HIT_ALL,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1297,1041,'ocher_blast',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1298,966,'ochre_blast_alt',@SINGLE,0.0,18.0,2000,0,@ENEMY,@NO_TP_COST,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1299,653,'typhoon_wing',@AOE,0.0,30.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1300,654,'spike_flail',@AOE,0.0,23.0,2000,2000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1301,965,'geotic_breath',@CONE,0.0,18.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1302,656,'touchdown',@AOE,0.0,6.0,2000,0,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1303,967,'ochre_blast',@AOE,0.0,23.0,2000,2000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1304,658,'bai_wing',@AOE,0.0,30.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1305,659,'absolute_terror',@AOE,0.0,18.0,4000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1306,660,'horrid_roar_3',@SINGLE,0.0,18.0,4000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1307,1051,'dark_matter_blast',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1308,1052,'dark_matter_blast',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1309,653,'cyclone_wing',@AOE,0.0,30.0,2000,1500,@ENEMY,@HIT_ALL,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1310,654,'spike_flail',@AOE,0.0,23.0,2000,2000,@ENEMY,@HIT_ALL,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1311,968,'sable_breath',@CONE,0.0,18.0,2000,1500,@ENEMY,@HIT_ALL,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1312,1056,'touchdown',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1313,1057,'dark_matter_blast',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1314,1058,'cyclone_wing',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1315,659,'absolute_terror',@SINGLE,0.0,18.0,4000,1500,@ENEMY,@HIT_ALL,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1316,660,'horrid_roar_3',@SINGLE,0.0,18.0,4000,1500,@ENEMY,@HIT_ALL,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1317,975,'mucus_spread',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1318,1062,'wz_slime_04',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1319,977,'epoxy_spread',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1320,1064,'wz_eyes_04',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1321,1065,'wz_crawl_03',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1322,14,'gerjis_grip',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1323,1067,'wz_bees_04',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1324,1068,'debilitating_drone',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1325,1069,'wz_trsap_03',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1326,988,'final_retribution',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1327,1071,'eagle_eye_shot',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@ASTRAL_FLOW,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1328,1072,'ink_jet',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1329,990,'gala_macabre',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1330,1074,'hoof_volley',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,2,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1331,1075,'counterstance',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1332,63,'extremely_bad_breath',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1333,152,'contagion_transfer',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1334,154,'contamination',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1335,151,'toxic_pick',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1336,289,'frenzied_rage',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1337,1081,'charm',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1338,234,'infernal_pestilence',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1339,1083,'bane',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1340,17,'crossthrash',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1341,1085,'knife_edge_circle',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1342,1086,'train_fall',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1343,1087,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1344,1088,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1345,1089,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1346,1090,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1347,998,'dual_strike',@SINGLE,0.0,7.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1348,999,'syphon_discharge',@AOE,0.0,15.0,2000,1000,@ENEMY,@NONE,0,1,0,0,0);
INSERT INTO `mob_skills` VALUES (1349,1000,'mantle_pierce',@SINGLE,0.0,7.0,2000,1000,@ENEMY,@NONE,0,3,0,0,0);
INSERT INTO `mob_skills` VALUES (1350,1001,'ink_cloud',@AOE,0.0,15.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1351,1002,'molluscous_mutation',@SINGLE,0.0,7.0,2000,1000,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1352,1003,'saline_coat',@CONE,0.0,10.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1353,1004,'aerial_collision',@CONE,0.0,10.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1354,1005,'vapor_spray',@CONE,0.0,12.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1355,1006,'spine_lash',@CONE,0.0,12.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1356,1007,'voiceless_storm',@AOE,0.0,15.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1357,1008,'tidal_dive',@AOE,0.0,15.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1358,1009,'plasma_charge',@SINGLE,0.0,7.0,2000,1000,@SELF,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1359,855,'chthonian_ray',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1360,855,'apocalyptic_ray',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1361,1105,'viscid_secretion',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1362,1106,'wild_ginseng',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1363,1107,'hungry_crunch',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1364,848,'mighty_snort',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1365,1043,'tail_thrust',@SINGLE,0.0,7.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1366,1044,'temporal_shift',@AOE,0.0,15.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1367,1031,'sinuate_rush',@AOE,0.0,15.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1368,1030,'rapid_molt',@SINGLE,0.0,7.0,2000,1000,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1369,1045,'ichor_stream',@CONE,0.0,10.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1370,1022,'vitriolic_barrage',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1371,1023,'primal_drill',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1372,1024,'concussive_oscillation',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,7,0,0,0);
INSERT INTO `mob_skills` VALUES (1373,1025,'ion_shower',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1374,1026,'torrential_torment',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1375,1027,'asthenic_fog',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1376,1028,'luminous_drape',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1377,1029,'fluorescence',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1378,1010,'wing_thrust',@SINGLE,0.0,7.0,2000,2000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1379,1011,'auroral_wind',@CONE,0.0,10.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1380,1012,'impact_stream',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1381,1013,'depuration',@SINGLE,0.0,7.0,2000,1000,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1382,1014,'crystaline_cocoon',@SINGLE,0.0,7.0,2000,1000,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1383,1018,'glacier_splitter',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1384,1019,'disseverment',@SINGLE,0.0,7.0,2000,2000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1385,1020,'biotic_boomerang',@AOE,0.0,15.0,2000,2000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1386,1021,'medusa_javelin',@SINGLE,0.0,7.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1387,1017,'sideswipe',@SINGLE,0.0,7.0,2000,2000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1388,1015,'ranged_attack',@SINGLE,0.0,25.0,2000,0,@ENEMY,@NO_TP_COST,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1389,1016,'eagle_eye_shot',@SINGLE,0.0,25.0,2000,0,@ENEMY,@ASTRAL_FLOW,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1390,1037,'amatsu_torimai',@SINGLE,0.0,15.0,2000,1000,@ENEMY,@NONE,0,0,1,4,0);
INSERT INTO `mob_skills` VALUES (1391,1038,'amatsu_kazakiri',@SINGLE,0.0,15.0,2000,1000,@ENEMY,@NONE,0,0,4,6,0);
INSERT INTO `mob_skills` VALUES (1392,1039,'amatsu_yukiarashi',@SINGLE,0.0,15.0,2000,1000,@ENEMY,@NONE,0,0,7,6,0);
INSERT INTO `mob_skills` VALUES (1393,1040,'amatsu_tsukioboro',@SINGLE,0.0,15.0,2000,1000,@ENEMY,@NONE,0,0,10,5,0);
INSERT INTO `mob_skills` VALUES (1394,1041,'amatsu_hanaikusa',@SINGLE,0.0,15.0,2000,1000,@ENEMY,@NONE,0,0,11,2,0);
INSERT INTO `mob_skills` VALUES (1395,1036,'amatsu_tsukikage',@SINGLE,0.0,15.0,2000,1000,@ENEMY,@NONE,0,0,12,6,0);
INSERT INTO `mob_skills` VALUES (1396,1034,'tenzen_ranged_alt',@SINGLE,0.0,25.0,2000,0,@ENEMY,@NO_TP_COST,0,0,0,0,0); -- tenzen ranged attack
INSERT INTO `mob_skills` VALUES (1397,1042,'oisoya',@SINGLE,0.0,15.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1398,1032,'riceball',@SINGLE,0.0,15.0,2000,1500,@SELF,@NONE,0,0,0,0,0); -- riceball eating
INSERT INTO `mob_skills` VALUES (1399,1035,'cosmic_elucidation',@SINGLE,0.0,15.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0); -- cosmic elucidation
-- INSERT INTO `mob_skills` VALUES (1400,1144,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1401,1145,'soul_accretion',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1402,1146,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1403,1056,'explosive_impulse',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1404,1148,'ocher_blast',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1405,966,'ocher_blast',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1406,653,'typhoon_wing',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1407,654,'spike_flail',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1408,965,'geotic_breath',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1409,656,'touchdown',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1410,967,'ocher_blast',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1411,658,'bai_wing',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1412,1156,'absolute_terror',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1413,660,'horrid_roar',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1414,1158,'marionette_dice',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1415,1159,'marionette_dice',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1416,1160,'marionette_dice',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1417,1161,'marionette_dice',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1418,1162,'marionette_dice',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1419,1163,'marionette_dice',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1420,1164,'marionette_dice',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1421,1165,'marionette_dice',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1422,1166,'marionette_dice',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1423,1167,'marionette_dice',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1424,1168,'marionette_dice',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1425,1169,'marionette_dice',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1426,1170,'marionette_dice',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1427,1171,'marionette_dice',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1428,1172,'warcry',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1429,1173,'counterstance',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1430,1174,'steal',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1431,803,'shield_bash',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NO_TP_COST,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1432,1176,'weapon_bash',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1433,1177,'sic',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1434,1178,'barrage',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1435,1179,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1436,1180,'meditate',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1437,1181,'jump',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1438,1182,'blood_pact',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1439,1057,'aetheral_toxin',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1440,1058,'edge_of_death',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1441,1065,'actinic_burst',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1442,1066,'core_meltdown',@AOE,0.0,15.0,2000,4000,@ENEMY,@NONE,0,0,0,0,0); -- Occurs very rarely. lets say a 5% chance.
INSERT INTO `mob_skills` VALUES (1443,1061,'hexidiscs',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1444,1062,'vorpal_blade',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0); -- Only used in human form
INSERT INTO `mob_skills` VALUES (1445,1063,'damnation_dive',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,1,0,0,0); -- Only used in bird form.  logged on eo'ghrah. theres a version that supposedly has knockback?
INSERT INTO `mob_skills` VALUES (1446,1064,'sickle_slash',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0); -- Only used in spider form.
INSERT INTO `mob_skills` VALUES (1447,1070,'vertical_cleave',@SINGLE,0.0,7.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1448,1071,'efflorescent_foetor',@CONE,0.0,10.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1449,1072,'stupor_spores',@AOE,0.0,15.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1450,1067,'viscid_nectar',@CONE,0.0,10.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1451,1073,'morning_glory',@AOE,0.0,15.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1452,1068,'axial_bloom',@AOE,0.0,15.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1453,1069,'nutrient_aborption',@SINGLE,0.0,7.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1454,1198,'palsy_pollen',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1455,1199,'toxic_spit',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1456,1200,'filamented_hold',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1457,1201,'marionette_dice',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1458,1202,'self-destruct',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1459,1203,'self-destruct',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1460,1204,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1461,1059,'shield_bash',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1462,1060,'shield_bash',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1463,1074,'reactor_cool',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1464,1075,'optic_induration_charge',@SINGLE,0.0,7.0,2000,0,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1465,1076,'optic_induration',@CONE,0.0,15.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1466,1077,'static_filament',@CONE,0.0,10.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0); -- bar form only
INSERT INTO `mob_skills` VALUES (1467,1078,'decayed_filament',@CONE,0.0,8.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0); -- bar form only
INSERT INTO `mob_skills` VALUES (1468,1079,'reactor_overheat',@CONE,0.0,10.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0); -- ring form only
INSERT INTO `mob_skills` VALUES (1469,1080,'reactor_overload',@AOE,0.0,8.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0); -- ring form only
-- INSERT INTO `mob_skills` VALUES (1470,1214,'self-destruct',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1471,1215,'cattlepult',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1472,1216,'cattlepult',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1473,1217,'cattlepult',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1474,1218,'#1218',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1475,1219,'bull_rush',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1476,1220,'red_lotus_blade',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,3,6,0);
-- INSERT INTO `mob_skills` VALUES (1477,1221,'flat_blade',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,8,0,0);
-- INSERT INTO `mob_skills` VALUES (1478,1222,'savage_blade',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,12,4,0);
-- INSERT INTO `mob_skills` VALUES (1479,1223,'royal_bash',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1480,1224,'royal_savior',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1481,679,'red_lotus_blade',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,3,6,0);
-- INSERT INTO `mob_skills` VALUES (1482,1226,'spirits_within',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1483,1227,'vorpal_blade',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,4,8,0);
-- INSERT INTO `mob_skills` VALUES (1484,1228,'berserk-ruf',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1485,1091,'hundred_fists',@SINGLE,0.0,7.0,2000,0,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1486,1092,'benediction',@AOE,0.0,7.0,2000,0,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1487,1093,'prishe_item_1',@SINGLE,0.0,7.0,2000,0,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1488,1094,'prishe_item_2',@SINGLE,0.0,7.0,2000,0,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1489,1095,'nullifying_dropkick',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1490,1096,'auroral_uppercut',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1491,1100,'chains_of_apathy',@AOE,0.0,30.0,2000,1500,@ENEMY,@HIT_ALL,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1492,1101,'chains_of_arrogance',@AOE,0.0,30.0,2000,1500,@ENEMY,@HIT_ALL,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1493,1102,'chains_of_cowardice',@AOE,0.0,30.0,2000,1500,@ENEMY,@HIT_ALL,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1494,1103,'chains_of_rage',@AOE,0.0,30.0,2000,1500,@ENEMY,@HIT_ALL,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1495,1104,'chains_of_envy',@AOE,0.0,30.0,2000,1500,@ENEMY,@HIT_ALL,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1496,1105,'malevolent_blessing',@CONE,0.0,10.0,2000,1500,@ENEMY,@HIT_ALL,0,7,0,0,0);
INSERT INTO `mob_skills` VALUES (1497,1106,'pestilent_penance',@CONE,0.0,10.0,2000,1500,@ENEMY,@HIT_ALL,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1498,1107,'empty_salvation',@AOE,0.0,25.0,2000,1500,@ENEMY,@HIT_ALL,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1499,1108,'infernal_deliverance',@AOE,0.0,15.0,2000,1500,@ENEMY,@HIT_ALL,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1500,1109,'malevolent_blessing',@CONE,0.0,10.0,2000,1500,@ENEMY,@HIT_ALL,0,7,0,0,0);
INSERT INTO `mob_skills` VALUES (1501,1110,'pestilent_penance',@CONE,0.0,10.0,2000,1500,@ENEMY,@HIT_ALL,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1502,1111,'empty_salvation',@AOE,0.0,25.0,2000,1500,@ENEMY,@HIT_ALL,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1503,1112,'infernal_deliverance',@AOE,0.0,15.0,2000,1500,@ENEMY,@HIT_ALL,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1504,1113,'wheel_of_impregnability',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1505,1114,'bastion_of_twilight',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1506,1115,'winds_of_oblivion',@AOE,0.0,15.0,2000,1500,@ENEMY,@HIT_ALL,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1507,1116,'seal_of_quiescence',@AOE,0.0,15.0,2000,1500,@ENEMY,@HIT_ALL,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1508,1099,'luminous_lance',@SINGLE,0.0,20.0,2000,0,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1509,1097,'rejuvenation',@AOE,0.0,10.0,2000,0,@SELF,@HIT_ALL,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1510,1098,'revelation',@SINGLE,0.0,20.0,2000,0,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1511,1255,'slam_dunk',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1512,1256,'howl',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1513,1257,'ore_toss',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1514,1258,'howl',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1515,1259,'double_kick',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1516,1260,'howl',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1517,1261,'goblin_rush',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1518,1262,'goblin_dice',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1519,1263,'provoke',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1520,1264,'howling_moon',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1521,1081,'armor_buster',@AOETARGET,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1522,1082,'energy_screen',@SINGLE,0.0,10.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1523,1083,'mana_screen',@SINGLE,0.0,10.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1524,1084,'dissipation',@AOETARGET,0.0,20.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1525,1090,'guided_missile_ii',@AOETARGET,0.0,5.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1526,1085,'colossal_blow',@SINGLE,0.0,10.0,2000,3000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1527,1086,'laser_shower',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1528,1087,'floodlight',@AOETARGET,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1529,1089,'hyper_pulse',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0); -- Proto-Omega
INSERT INTO `mob_skills` VALUES (1530,1088,'stun_cannon',@CONE,0.0,20.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1531,772,'wz_recover_all',@AOE,0.0,20.0,0,0,1028,0,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1532,1124,'pod_ejection',@SINGLE,0.0,7.0,4500,1,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1533,1117,'pile_pitch',@SINGLE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1534,1118,'guided_missile',@AOETARGET,0.0,5.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1535,1119,'hyper_pulse',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0); -- Omega
INSERT INTO `mob_skills` VALUES (1536,1120,'target_analysis',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1537,1121,'discharger',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1538,1122,'ion_efflux',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1539,1123,'rear_lasers',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1540,1081,'citadel_buster',@AOETARGET,0.0,20.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1541,1285,'blighted_gloom',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1542,1133,'trample',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1543,1134,'tempest_wing',@CONE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1544,1139,'touchdown_bahamut',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1545,1135,'sweeping_flail',@AOE,0.0,20.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1546,1140,'prodigious_spike',@SINGLE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1547,1141,'impulsion',@SINGLE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1548,1143,'absolute_terror',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1549,1142,'horrible_roar',@SINGLE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1550,1294,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1551,1136,'megaflare',@CONE,0.0,15.0,6000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1552,1137,'gigaflare',@AOE,0.0,15.0,6000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1553,1138,'teraflare',@SINGLE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1554,1298,'camisado',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1555,1299,'blessed_radiance',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1556,1300,'regeneration',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1557,1146,'eagle_eye_shot',@SINGLE,0.0,25.0,2000,0,@ENEMY,@ASTRAL_FLOW,0,0,0,0,0); -- ees breath
-- INSERT INTO `mob_skills` VALUES (1558,1302,'smite_of_fury',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1559,1303,'flurry_of_rage',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1560,1304,'whispers_of_ire',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1561,1305,'sonic_wave',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1562,1306,'stomping',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1563,1307,'cold_stare',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1564,1308,'whistle',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1565,1309,'berserk',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1566,1310,'healing_breeze',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1567,1311,'foot_kick',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1568,1312,'dust_cloud',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1569,1313,'whirl_claws',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1570,1314,'wild_carrot',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1571,861,'gas_shell',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1572,862,'venom_shell',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1573,863,'palsynyxis',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1574,864,'painful_whip',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1575,865,'suctorial_tentacle',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1576,1320,'helldive',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1577,1321,'wing_cutter',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1578,1322,'broadside_barrage',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1579,1323,'blind_side_barrage',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1580,1324,'damnation_dive',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,1,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1581,1325,'sticky_thread',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1582,1326,'poison_breath',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1583,1327,'cocoon',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1584,44,'head_butt',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1585,45,'dream_flower',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1586,1330,'wild_oats',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1587,49,'leaf_dagger',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1588,50,'scream',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1589,186,'bubble_shower',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1590,1334,'bubble_curtain',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1591,188,'big_scissors',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1592,1336,'scissor_guard',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1593,1337,'metallic_body',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1594,1338,'toxic_spit',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1595,1339,'geist_wall',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1596,1340,'numbing_noise',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1597,1341,'nimble_snap',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1598,1342,'cyclotail',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1599,1343,'hammer_beak',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1600,1344,'poison_pick',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1601,1345,'sound_vacuum',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1602,1346,'sound_blast',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1603,1347,'baleful_gaze',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1604,63,'miasmic_breath',@CONE,0.0,11.5,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1605,63,'miasmic_breath',@CONE,0.0,15.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1606,63,'fragrant_breath',@CONE,0.0,12.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1607,63,'fragrant_breath',@CONE,0.0,20.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1608,63,'putrid_breath',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1609,63,'putrid_breath',@CONE,0.0,20.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1610,63,'extremely_bad_breath',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1611,61,'vampiric_lash',@SINGLE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1612,72,'gouging_branch',@CONE,0.0,13.0,2000,0,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1613,1357,'gloeosuccus',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1614,1358,'gloeosuccus',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1615,1359,'soporific',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1616,1360,'palsy_pollen',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1617,325,'blow',@SINGLE,0.0,12.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1618,328,'uppercut',@SINGLE,0.0,12.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1619,331,'attractant',@AOE,0.0,12.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1620,59,'mephitic_spore',@CONE,0.0,12.5,2000,0,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1621,52,'frogkick',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1622,1366,'cursed_sphere',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1623,1367,'venom',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1624,1368,'debilitating_drone',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1625,1369,'2000_needles',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1626,1370,'4000_needles',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1627,1371,'needleshot',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1628,1372,'heat_breath',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1629,1373,'riddle',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1630,1374,'great_sandstorm',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1631,1375,'great_whirlwind',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1632,913,'choke_breath',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1633,1377,'sheep_bleat',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1634,1378,'sheep_song',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1635,1379,'sheep_charge',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1636,1132,'trebuchet',@AOE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1637,410,'power_attack',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1638,406,'lightning_roar',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1639,408,'impact_roar',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1640,409,'grand_slam',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1641,23,'eagle_eye_shot',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@ASTRAL_FLOW,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1642,1386,'whirl_of_rage',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1643,1387,'smite_of_rage',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1644,878,'hypothermal_combustion',@AOE,0.0,20.0,2000,2000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1645,876,'freeze_rush',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1646,877,'cold_wave',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1647,1598,'berserk',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1648,418,'crystal_shield',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1649,419,'heavy_strike',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1650,420,'ice_break',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1651,1395,'thunder_break',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1652,422,'crystal_rain',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1653,423,'crystal_weapon_fire',@SINGLE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1654,424,'crystal_weapon_stone',@SINGLE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1655,425,'crystal_weapon_water',@SINGLE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1656,426,'crystal_weapon_wind',@SINGLE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1657,1401,'blind_vortex',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1658,1402,'giga_scream',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1659,1403,'dread_dive',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1660,1404,'feather_barrier',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1661,1405,'stormwind',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1662,136,'ultrasonics',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1663,1407,'blood_drain',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1664,1408,'subsonics',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1665,338,'marrow_drain',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1666,1410,'sonic_boom',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1667,1411,'jet_stream',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1668,1412,'slipstream',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1669,1413,'turbulence',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1670,200,'tentacle',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1671,202,'ink_jet_alt',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NO_TP_COST,0,3,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1672,1416,'hard_membrane',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1673,1417,'cross_attack',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1674,1418,'regeneration',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1675,1419,'maelstrom',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1676,1420,'whirlwind',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1677,14,'roar',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1678,15,'razor_fang',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1679,17,'claw_cyclone',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1680,1424,'predatory_glare',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1681,17,'crossthrash',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1682,118,'ripper_fang',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1683,1427,'#1427',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1684,120,'foul_breath',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1685,1429,'frost_breath',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1686,1430,'thunderbolt',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1687,123,'chomp_rush',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1688,124,'scythe_tail',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1689,1433,'double_claw',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1690,1434,'grapple',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1691,1435,'filamented_hold',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1692,1436,'spinning_top',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1693,1164,'gnash',@SINGLE,0.0,7.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1694,1165,'vile_belch',@AOE,0.0,16.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1695,1166,'hypnic_lamp',@AOE,0.0,16.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1696,1167,'seismic_tail',@AOE,0.0,15.0,2000,1000,@ENEMY,@NONE,0,6,0,0,0);
INSERT INTO `mob_skills` VALUES (1697,1168,'seaspray',@CONE,0.0,12.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1698,1169,'leeching_current',@AOE,0.0,12.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1699,1176,'pecking_flurry',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1700,1177,'snatch_morsel',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1701,1178,'feather_tickle',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1702,1179,'wisecrack',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1703,1170,'barrier_tusk',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1704,1171,'onrush',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1705,1172,'stampede',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1706,1173,'flailing_trunk',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1707,1174,'voracious_trunk',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1708,1175,'proboscis_shower',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1709,1181,'abrasive_tantara',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1710,1182,'deafening_tantara',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1711,1180,'frenetic_rip',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1712,1183,'bugle_call',@SINGLE,0.0,7.0,2000,3000,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1713,1159,'yawn',@AOE,0.0,18.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1714,1160,'wing_slap',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1715,1161,'beak_lunge',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,5,0,0,0);
INSERT INTO `mob_skills` VALUES (1716,1162,'frigid_shuffle',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1717,1163,'wing_whirl',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1718,1194,'crosswind',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,3,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1719,1463,'#1463',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1720,1195,'wind_shear',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,7,0,0,0);
INSERT INTO `mob_skills` VALUES (1721,1196,'obfuscate',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1722,1197,'zephyr_mantle',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1723,1198,'ill_wind',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1724,1199,'white_wind',@AOE,0.0,15.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1725,1200,'kibosh',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1726,1201,'cutpurse',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1727,1202,'sandspray',@CONE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1728,1203,'faze',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1729,1473,'bowshot',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1730,1204,'deadeye',@AOE,0.0,18.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1731,1149,'forceful_blow',@SINGLE,0.0,7.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1732,1150,'somersault_kick',@SINGLE,0.0,7.0,2000,1000,@ENEMY,@NONE,0,4,0,0,0);
INSERT INTO `mob_skills` VALUES (1733,1151,'firespit',@SINGLE,0.0,25.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1734,1152,'warm-up',@SINGLE,0.0,7.0,2000,1000,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1735,1153,'javelin_throw',@SINGLE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1736,1154,'axe_throw',@SINGLE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1737,1155,'vorpal_blade',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,4,8,0);
INSERT INTO `mob_skills` VALUES (1738,1156,'pw_groundburst',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1739,1483,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1740,1484,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1741,1230,'potent_lunge',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,3,0,0,0);
INSERT INTO `mob_skills` VALUES (1742,1231,'overthrow',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,6,0,0,0);
INSERT INTO `mob_skills` VALUES (1743,1232,'rock_smash',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1744,1233,'diamondhide',@AOE,0.0,16.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1745,1234,'enervation',@AOE,0.0,18.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1746,1235,'quake_stomp',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1747,1236,'zarraqa',@SINGLE,0.0,25.0,2000,0,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1748,1237,'zarbzan',@AOETARGET,0.0,25.0,5000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1749,1238,'healing_stomp',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1750,1494,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1751,1495,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1752,1184,'gusting_gouge',@CONE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1753,1185,'hysteric_barrage',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1754,1186,'dukkeripen_heal',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1755,1187,'dukkeripen_shadow',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1756,1188,'dukkeripen_para',@AOE,0.0,12.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1757,1189,'dukkeripen_heal',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1758,1190,'tail_slap',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,3,0,0,0);
INSERT INTO `mob_skills` VALUES (1759,1191,'hypnotic_sway',@CONE,0.0,10.0,2000,2000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1760,1192,'swift_shot',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1761,1192,'arrow_deluge',@SINGLE,0.0,14.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1762,1193,'belly_dance',@AOE,0.0,12.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1763,1507,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1764,1508,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1765,1252,'gusting_gouge',@CONE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,3,0,0,0);
INSERT INTO `mob_skills` VALUES (1766,1253,'hysteric_barrage',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1767,1554,'dukkeripen_heal',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1768,1555,'dukkeripen_shadow',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1769,1256,'dukkeripen_para',@AOE,0.0,12.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1770,1257,'dukkeripen_heal',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1771,1258,'tail_slap',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,3,0,0,0);
INSERT INTO `mob_skills` VALUES (1772,1259,'torrent',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1773,1517,'swift_shot',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1774,1518,'arrow_deluge',@SINGLE,0.0,14.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1775,1261,'rising_swell',@AOE,0.0,12.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1776,1253,'hysteric_barrage',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1777,1521,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1778,1205,'spinal_cleave',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1779,1206,'mangle',@CONE,0.0,16.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1780,1207,'leaping_cleave',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1781,1208,'hex_palm',@CONE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1782,1209,'animating_wail',@AOE,0.0,15.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1783,1210,'fortifying_wail',@AOE,0.0,15.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1784,1211,'unblest_jambiya',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1785,1223,'lava_spit',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1786,1224,'sulfurous_breath',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1787,1225,'scorching_lash',@AOE,0.0,20.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1788,1226,'ululation',@AOE,0.0,20.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1789,1227,'magma_hoplon',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1790,1228,'gates_of_hades',@AOE,0.0,20.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1791,1217,'incinerate',@CONE,0.0,12.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1792,1212,'nullsong',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1793,1213,'vampiric_root',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1794,1214,'perdition',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1795,1215,'malediction',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1796,1540,'piercing_shriek',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1797,1320,'rushing_slash',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1798,1321,'decussate',@AOE,0.0,16.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1799,1322,'tyranic_blare',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1800,1323,'miasma',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1801,1324,'vorpal_wheel',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1802,1351,'sledgehammer',@CONE,0.0,12.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1803,1352,'head_snatch',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1804,1353,'haymaker',@CONE,0.0,12.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1805,1354,'incessant_fists',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1806,1355,'arcane_stomp',@AOE,0.0,25.0,2000,1500,@SELF,@NONE,0,0,0,0,0); -- corected ? to 1
INSERT INTO `mob_skills` VALUES (1807,1356,'pleiades_ray',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1808,1334,'petrifaction',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1809,1335,'pw_shadow_thrust',@SINGLE,0.0,10.0,2000,2000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1810,1336,'tail_slap',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1811,1555,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1812,1337,'pw_pinning_shot',@AOETARGET,0.0,15.0,2000,2000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1813,1338,'pw_calcifying_deluge',@AOETARGET,0.0,15.0,2000,2000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1814,1339,'pw_gorgon_dance',@AOE,0.0,15.0,2000,2000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1815,1290,'amber_scutum',@SINGLE,0.0,10.0,2000,1000,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1816,1291,'vitriolic_spray',@CONE,0.0,10.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1817,1292,'thermal_pulse',@AOE,0.0,12.5,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1818,1293,'cannonball',@SINGLE,0.0,20.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1819,1294,'heat_barrier',@SINGLE,0.0,7.0,2000,1000,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1820,1295,'vitriolic_shower',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1821,1283,'amplification',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1822,1284,'boiling_point',@CONE,0.0,16.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1823,1285,'xenoglossia',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1824,1286,'amorphic_spikes',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1825,1287,'amorphic_scythe',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1826,1288,'synergism',@AOE,0.0,15.0,2500,3000,@SELF,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1827,1571,'metastasis',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1828,1308,'pyric_blast',@CONE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1829,1319,'pyric_bulwark',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1830,1309,'polar_blast',@CONE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1831,1318,'polar_bulwark',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1832,1313,'barofield',@CONE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1833,1577,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1834,1310,'trembling',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1835,1311,'serpentine_tail',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1836,1312,'nerve_gas',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1837,1314,'feeble_bleat',@AOE,0.0,18.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1838,1221,'mine_blast',@AOE,0.0,10.0,2000,1500,@ENEMY,24,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1839,1147,'rushing_slash',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1840,1148,'rushing_stab',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1841,1585,'sandblast',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1842,1586,'sandpit',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1843,1587,'venom_spray',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1844,1588,'pit_ambush',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1845,1589,'mandibular_bite',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1846,78,'sharp_sting',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1847,79,'frenzy_pollen',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1848,1592,'final_sting',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1849,1593,'sling_bomb',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1850,1594,'formation_attack',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1851,1595,'refueling',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1852,1596,'circle_of_flames',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1853,870,'self-destruct',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1854,1598,'stellar_burst',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1855,1599,'self-destruct',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1856,1600,'omega_javelin',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1857,1601,'self-destruct',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1858,1602,'tail_roll',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1859,1603,'tusk',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1860,1604,'scutum',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1861,1605,'bone_crunch',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1862,1606,'awful_eye',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1863,1607,'heavy_bellow',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1864,1608,'intimidate',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1865,194,'aqua_ball',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1866,1610,'splash_breath',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1867,1611,'screwdriver',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1868,1612,'water_wall',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1869,198,'water_shield',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1870,1614,'recoil_dive',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1871,1615,'suction',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1872,1616,'acid_mist',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1873,1617,'sand_breath',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1874,1618,'drainkiss',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1875,1619,'regeneration',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1876,1620,'tp_drainkiss',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1877,1621,'mp_drainkiss',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1878,1622,'brain_drain',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1879,1623,'triclip',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1880,852,'back_swish',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1881,853,'mow',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1882,854,'frightful_roar',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1883,855,'mortal_ray',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1884,856,'unblest_armor',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1885,1629,'full-force_blow',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1886,1630,'gastric_bomb',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1887,1631,'sandspin',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1888,1632,'tremors',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1889,1633,'spirit_vacuum',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1890,1634,'sound_vacuum',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1891,1218,'provoke',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1892,1229,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0); -- This is a unnamed skill for the Cerberus "Howl" Animation
-- INSERT INTO `mob_skills` VALUES (1893,438,'spirit_surge',@SINGLE,0.0,7.0,2000,0,@SELF,@ASTRAL_FLOW,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1894,1241,'potent_lunge',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,3,0,0,0);
INSERT INTO `mob_skills` VALUES (1895,1242,'overthrow',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,6,0,0,0);
INSERT INTO `mob_skills` VALUES (1896,1243,'rock_smash',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1897,1244,'diamondhide',@AOE,0.0,16.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1898,1245,'enervation',@AOE,0.0,18.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1899,1246,'quake_stomp',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1900,1247,'healing_stomp',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1901,505,'activate',@SINGLE,0.0,7.0,2000,0,@SELF,@NO_TP_COST,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1902,1646,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1903,141,'camisado',@SINGLE,0.0,10.0,640,3000,@ENEMY,@BLOOD_PACT_RAGE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1904,142,'somnolence',@SINGLE,0.0,10.0,641,3000,@ENEMY,@BLOOD_PACT_WARD,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1905,916,'noctoshield',@AOE,0.0,10.0,644,1500,@SELF,@BLOOD_PACT_WARD,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1906,144,'ultimate_terror',@AOE,0.0,10.0,643,3000,@ENEMY,@BLOOD_PACT_WARD,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1907,145,'dream_shroud',@AOE,0.0,10.0,645,3000,@SELF,@BLOOD_PACT_WARD,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1908,146,'nightmare',@AOE,0.0,10.0,642,3000,@ENEMY,@BLOOD_PACT_WARD,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1909,1653,'cacodemonia',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1910,148,'nether_blast',@SINGLE,0.0,10.0,646,3000,@ENEMY,@BLOOD_PACT_RAGE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1911,1125,'ruinous_omen',@AOE,0.0,30.0,2000,3000,@ENEMY,@BLOOD_PACT_RAGE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1912,1656,'hypnogenesis',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1913,1657,'stunbolt',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1914,1658,'great_wheel',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1915,1659,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1916,1660,'blessed_radiance',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1917,1661,'sweeping_somnolence',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1918,1662,'nether_tempest',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1919,1663,'daydream',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1920,1264,'rushing_drub',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1921,1265,'forceful_blow',@SINGLE,0.0,7.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1922,1266,'somersault_kick',@SINGLE,0.0,7.0,2000,1000,@ENEMY,@NONE,0,4,0,0,0);
INSERT INTO `mob_skills` VALUES (1923,1267,'firespit',@SINGLE,0.0,30.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1924,1268,'warm-up',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1925,1269,'stave_toss',@SINGLE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1926,1270,'groundburst',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1927,1671,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1928,1672,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1929,1278,'pole_swing',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1930,1279,'tidal_slash',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1931,1280,'eagle_eye_shot',@SINGLE,0.0,25.0,2000,0,@ENEMY,@ASTRAL_FLOW,0,0,0,0,0); -- lamiae
INSERT INTO `mob_skills` VALUES (1932,16,'eagle_eye_shot',@SINGLE,0.0,25.0,2000,0,@ENEMY,@ASTRAL_FLOW,0,0,0,0,0); -- swift shot ??
INSERT INTO `mob_skills` VALUES (1933,432,'azure_lore',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1934,432,'wild_card',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1935,1679,'overdrive',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1936,1299,'shibaraku',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);  -- need correct animation & timings
-- INSERT INTO `mob_skills` VALUES (1937,1681,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0); -- gessho's teleport is probably here, one skill in one out.
-- INSERT INTO `mob_skills` VALUES (1938,1301,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0); -- gessho's teleport is probably here, one skill in one out.
-- INSERT INTO `mob_skills` VALUES (1939,1302,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1940,1304,'chimera_ripper',@SINGLE,0.0,7.0,2000,1,@ENEMY,@NONE,0,0,6,7,0);
INSERT INTO `mob_skills` VALUES (1941,1305,'string_clipper',@SINGLE,0.0,7.0,2000,1,@ENEMY,@NONE,0,0,4,0,0);
INSERT INTO `mob_skills` VALUES (1942,1303,'arcuballista',@SINGLE,0.0,15.0,2000,1,@ENEMY,@NONE,0,0,3,1,0);
INSERT INTO `mob_skills` VALUES (1943,1306,'slapstick',@SINGLE,0.0,7.0,2000,1,@ENEMY,@NONE,0,0,5,8,0);
INSERT INTO `mob_skills` VALUES (1944,1307,'shield_bash',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NO_TP_COST,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1945,1219,'provoke',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NO_TP_COST,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1946,435,'shock_absorber',@SINGLE,0.0,7.0,2000,0,16,4,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1947,438,'flashbulb',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NO_TP_COST,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1948,439,'mana_converter',@SINGLE,0.0,7.0,2000,0,16,4,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1949,16,'ranged_attack',@SINGLE,0.0,25.0,2000,0,@ENEMY,@NO_TP_COST,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1950,1694,'belly_dance',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1951,1345,'magma_fan',@CONE,0.0,10.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1952,1346,'erratic_flutter',@AOE,0.0,15.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1953,1347,'proboscis',@CONE,0.0,10.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1954,1348,'erosion_dust',@AOE,0.0,15.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1955,1349,'exuviation',@SINGLE,0.0,7.0,2000,1000,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1956,1350,'fire_break',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1957,1359,'frog_song',@AOE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1958,1360,'magic_hammer',@SINGLE,0.0,16.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1959,1361,'water_bomb',@AOETARGET,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1960,1362,'frog_cheer',@AOE,0.0,15.0,2000,1500,@PARTY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1961,1363,'providence',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1962,1364,'frog_chorus',@AOE,0.0,20.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1963,1327,'mind_blast',@CONE,0.0,10.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1964,1328,'immortal_mind',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1965,1329,'immortal_shield',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1966,1330,'mind_purge',@SINGLE,0.0,7.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1967,1331,'tribulation',@AOE,0.0,15.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1968,1332,'immortal_anathema',@AOE,0.0,15.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1969,1333,'reprobation',@AOE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1970,1344,'eclosion',@SINGLE,0.0,7.0,4000,0,@SELF,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1971,1715,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1972,1716,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1973,1717,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1974,1718,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1975,1719,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1976,1720,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1977,1164,'deathgnash',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1978,1165,'abominable_belch',@AOE,0.0,16.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1979,1723,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1980,1197,'boreas_mantle',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1981,1725,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1982,1726,'nullifying_dropkick',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1983,1727,'auroral_uppercut',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1984,1728,'wisecrack',@SINGLE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1985,1729,'fighter's_roll',@SINGLE,0.0,7.0,2000,1500,4,0,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1986,1730,'rogue's_roll',@SINGLE,0.0,7.0,2000,1500,4,0,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1987,1731,'gallant's_roll',@SINGLE,0.0,7.0,2000,1500,4,0,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1988,1732,'chaos_roll',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1989,1733,'hunter's_roll',@SINGLE,0.0,7.0,2000,1500,4,0,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1990,1734,'ninja_roll',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1991,1735,'double-up',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1992,1736,'fire_maneuver',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1993,1737,'ice_maneuver',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1994,1738,'wind_maneuver',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1995,1739,'earth_maneuver',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1996,1740,'thunder_maneuver',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (1997,1741,'water_maneuver',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (1998,361,'hane_fubuki',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);     -- need correct animation & timings
INSERT INTO `mob_skills` VALUES (1999,362,'hiden_sokyaku',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);   -- need correct animation & timings
INSERT INTO `mob_skills` VALUES (2000,363,'shiko_no_mitate',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0); -- need correct animation & timings
INSERT INTO `mob_skills` VALUES (2001,364,'happobarai',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);      -- need correct animation & timings
INSERT INTO `mob_skills` VALUES (2002,354,'rinpyotosha',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);     -- need correct animation & timings
INSERT INTO `mob_skills` VALUES (2003,1181,'grating_tantara',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2004,1182,'stifling_tantara',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2005,1157,'reward',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2006,1750,'azure_lore',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2007,1751,'wild_card',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2008,1752,'overdrive',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2009,1753,'fire_shot',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2010,1754,'ice_shot',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2011,1755,'wind_shot',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2012,1756,'earth_shot',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2013,1757,'thunder_shot',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2014,1758,'water_shot',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2015,1759,'light_shot',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2016,1760,'dark_shot',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2017,1761,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2018,1762,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2019,1763,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2020,436,'hundred_fists',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2021,438,'eraser',@SINGLE,0.0,7.0,2000,0,16,4,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2022,1367,'tenebrous_mist',@AOE,0.0,13.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2023,1368,'thunderstrike',@AOE,0.0,13.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2024,1371,'tourbillion',@AOE,0.0,18.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2025,1369,'dreadstorm',@AOE,0.0,13.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2026,1381,'fossilizing_breath',@CONE,0.0,12.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2027,1382,'plague_swipe',@CONE,0.0,12.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2028,1386,'fulmination',@AOE,0.0,32.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2029,1773,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2030,1774,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2031,433,'reactive_shield',@SINGLE,0.0,7.0,2000,0,16,4,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2032,1383,'roller_chain',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2033,1384,'choke_chain',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2034,1385,'reinforcements',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2035,1396,'biomagnet',@SINGLE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2036,1397,'astral_gate',@CONE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,7,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2037,1781,'warp',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2038,1387,'artificial_gravity',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2039,1388,'antigravity',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,2,0,0,0);
INSERT INTO `mob_skills` VALUES (2040,1373,'rail_cannon',@CONE,0.0,20.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2041,1374,'restoral',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2042,1786,'armature',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2043,1392,'artificial_gravity_3',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2044,1395,'antigravity_3',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,7,0,0,0);
INSERT INTO `mob_skills` VALUES (2045,1379,'rail_cannon_3',@AOE,0.0,20.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2046,1391,'artificial_gravity_2',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2047,1394,'antigravity_2',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,5,0,0,0);
INSERT INTO `mob_skills` VALUES (2048,1377,'rail_cannon_2',@CONE,0.0,20.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2049,1390,'artificial_gravity_1',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2050,1393,'antigravity_1',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,2,0,0,0);
INSERT INTO `mob_skills` VALUES (2051,1375,'rail_cannon_1',@SINGLE,0.0,20.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2052,1380,'restoral',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2053,1797,'heavy_armature',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2054,1407,'diffusion_ray',@CONE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2055,1408,'intertia_stream',@AOE,0.0,10.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2056,1399,'discharge',@AOE,0.0,10.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2057,1409,'mortal_revolution',@AOE,0.0,15.0,2000,1000,@ENEMY,@NONE,0,1,0,0,0);
INSERT INTO `mob_skills` VALUES (2058,1400,'homing_missile',@AOETARGET,0.0,20.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2059,1401,'discoid',@CONE,0.0,10.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2060,1403,'brainjack',@SINGLE,0.0,10.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0); -- for long armed chariot charm brainjack right one is 1410 (probably 1407-1409 for his other moves)
INSERT INTO `mob_skills` VALUES (2061,1378,'restoral',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2062,1376,'restoral',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2063,1807,'heavy_armature',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2064,1808,'heavy_armature',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2065,1404,'cannibal_blade',@SINGLE,0.0,15.0,2000,1,@ENEMY,@NONE,150,0,2,5,0);
INSERT INTO `mob_skills` VALUES (2066,1405,'daze',@SINGLE,0.0,15.0,2000,1,@ENEMY,@NONE,150,0,8,1,0);
INSERT INTO `mob_skills` VALUES (2067,1406,'knockout',@SINGLE,0.0,7.0,2000,1,@ENEMY,@NONE,145,0,4,6,0);
INSERT INTO `mob_skills` VALUES (2068,439,'economizer',@SINGLE,0.0,7.0,2000,0,16,4,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2069,1813,'tribulation',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2070,1411,'dismemberment',@SINGLE,0.0,7.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2071,1412,'dire_straight',@SINGLE,0.0,7.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2072,1413,'earth_shatter',@AOE,0.0,15.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2073,1414,'sinker_drill',@SINGLE,0.0,7.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2074,1415,'detonating_grip',@SINGLE,0.0,7.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2075,1819,'overthrow',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2076,1820,'rock_smash',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2077,1821,'diamondhide',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2078,1419,'enervation',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2079,1823,'quake_stomp',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2080,1421,'potent_lunge',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2081,1422,'hammer-go-round',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,3,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2082,1423,'hammerblow',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2083,1424,'drop_hammer',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2084,1425,'seismohammer',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2085,1829,'venomous_tail',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2086,1830,'grim_reaper',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2087,1831,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2088,1427,'victory_beacon',@AOETARGET,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);  -- Rughadjeen
INSERT INTO `mob_skills` VALUES (2089,1428,'salamander_flame',@AOETARGET,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);  -- Gadalar
INSERT INTO `mob_skills` VALUES (2090,1429,'typhonic_arrow',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);  -- Najelith
INSERT INTO `mob_skills` VALUES (2091,1430,'meteoric_impact',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);  -- Zazarg
INSERT INTO `mob_skills` VALUES (2092,1431,'scouring_bubbles',@AOE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,14,10,0);  -- Mihli
-- INSERT INTO `mob_skills` VALUES (2093,1837,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2094,1432,'fire_angon',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2095,1437,'batterhorn',@CONE,0.0,16.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2096,1438,'clobber',@REARCONE,0.0,16.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2097,1439,'granite_skin',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2098,1433,'blazing_angon',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2099,1437,'batterhorn',@CONE,0.0,16.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2100,1436,'clobber',@REARCONE,0.0,16.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2101,1434,'demoralizing_roar',@AOE,0.0,16.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2102,1435,'boiling_blood',@SINGLE,0.0,7.0,2000,1000,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2103,1439,'granite_skin',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2104,1436,'crippling_slam',@CONE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2105,1440,'mijin_gakure',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2106,1449,'bloodrake',@SINGLE,0.0,7.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2107,1450,'decollation',@CONE,0.0,7.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2108,1451,'nosferatus_kiss',@AOE,0.0,20.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2109,1452,'heliovoid',@AOE,0.0,20.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2110,1454,'wings_of_gehenna',@AOE,0.0,20.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2111,1453,'eternal_damnation',@CONE,0.0,15.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2112,1455,'nocturnal_servitude',@CONE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2113,1456,'hellsnap',@AOE,0.0,30.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2114,1460,'hellclap',@CONE,0.0,10.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2115,1457,'cackle',@AOE,0.0,30.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2116,1462,'necrobane',@AOE,0.0,15.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2117,1461,'necropurge',@AOE,0.0,15.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2118,1458,'bilgestorm',@AOE,0.0,15.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2119,1459,'thundris_shriek',@AOE,0.0,15.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2120,1441,'ofnir',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2121,1446,'valfodr',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2122,1444,'yggr',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2123,1442,'gagnrath',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2124,1445,'sanngetall',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2125,1443,'geirrothr',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2126,1447,'zantetsuken',@CONE,0.0,10.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2127,848,'snort_2127',@CONE,0.0,12.5,2000,0,@ENEMY,@NONE,0,3,0,0,0);
INSERT INTO `mob_skills` VALUES (2128,420,'ice_break_2128',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2129,421,'thunder_break_2129',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2130,1175,'proboscis_shower',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2131,1875,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2132,434,'replicator',@SINGLE,0.0,7.0,2000,0,16,4,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2133,1877,'liar's_dice',@SINGLE,0.0,7.0,2000,1500,4,0,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2134,1878,'victory_beacon',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2135,1879,'salamander_flame',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2136,1880,'typhonic_arrow',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2137,1881,'meteoric_impact',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2138,1431,'scouring_bubbles',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2139,1883,'doom',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2140,1884,'peacebreaker',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2141,1465,'radiant_sacrament',@SINGLE,0.0,20.0,2000,1000,@ENEMY,@NO_TP_COST,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2142,1471,'mega_holy',@AOE,0.0,18.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2143,1467,'perfect_defense',@AOE,0.0,10.0,2000,1000,@SELF,@NONE,30,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2144,1470,'divine_spear',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2145,1466,'gospel_of_the_lost',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2146,1469,'void_of_repentance',@SINGLE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2147,1468,'divine_judgement',@AOE,0.0,10.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2148,1464,'eagle_eye_shot',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@ASTRAL_FLOW,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2149,1463,'chi_blast',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2150,1894,'snatch_morsel',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2151,1895,'1000_needles',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2152,1543,'aqua_fortis',@AOE,0.0,15.0,2000,2000,@ENEMY,@NONE,0,3,0,0,0);
INSERT INTO `mob_skills` VALUES (2153,1544,'regurgitation',@SINGLE,0.0,7.0,2000,1000,@ENEMY,@NONE,0,3,0,0,0);
INSERT INTO `mob_skills` VALUES (2154,1545,'delta_thrust',@SINGLE,0.0,7.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2155,1546,'torpefying_charge',@AOE,0.0,10.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2156,1547,'grim_glower',@SINGLE,0.0,10.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2157,1901,'calcifying_mist',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2158,1567,'insipid_nip',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2159,1568,'pandemic_nip',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2160,1569,'bombilation',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2161,1570,'cimicine_discharge',@SINGLE,0.0,10.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2162,1571,'emetic_discharge',@SINGLE,0.0,7.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2163,1549,'seedspray',@SINGLE,0.0,11.5,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2164,1550,'viscid_emission',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2165,1551,'rotten_stench',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2166,1552,'floral_bouquet',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2167,1553,'bloody_caress',@SINGLE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2169,1554,'soothing_aroma',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2170,1589,'fevered_pitch',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2171,1590,'call_of_the_moon_up',@AOE,0.0,25.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0); -- standing up
INSERT INTO `mob_skills` VALUES (2172,1591,'call_of_the_moon_down',@AOE,0.0,25.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0); -- On 4 legs
INSERT INTO `mob_skills` VALUES (2173,1592,'plenilune_embrace_up',@SINGLE,0.0,15.0,2000,1500,@SELF,@NONE,0,0,0,0,0); -- standing up
INSERT INTO `mob_skills` VALUES (2174,1593,'plenilune_embrace_down',@SINGLE,0.0,15.0,2000,1500,@SELF,@NONE,0,0,0,0,0); -- 4 legs
INSERT INTO `mob_skills` VALUES (2175,1594,'nox_blast',@SINGLE,0.0,7.0,2000,1000,@ENEMY,@NONE,0,3,0,0,0); -- standing only
INSERT INTO `mob_skills` VALUES (2176,1595,'asuran_claws',@SINGLE,0.0,7.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0); -- standing only
-- INSERT INTO `mob_skills` VALUES (2177,1921,'cacophony',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2178,1576,'sudden_lunge',@SINGLE,0.0,10.0,2000,1800,@ENEMY,@NONE,0,3,0,0,0);
INSERT INTO `mob_skills` VALUES (2179,1577,'noisome_powder',@AOE,0.0,10.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0); -- daytime only
INSERT INTO `mob_skills` VALUES (2180,1578,'nepenthean_hum',@AOE,0.0,10.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0); -- daytime only
INSERT INTO `mob_skills` VALUES (2181,1579,'spiral_spin',@CONE,0.0,10.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2182,1580,'spiral_burst',@SINGLE,0.0,7.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2183,1572,'fuscous_ooze',@CONE,0.0,10.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2184,1573,'purulent_ooze',@CONE,0.0,10.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2185,1574,'corrosive_ooze',@AOE,0.0,15.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2186,1930,'mucilaginous_ooze',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2187,1537,'dustvoid',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2188,1538,'slaverous_gale',@AOE,0.0,15.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2189,1539,'aeolian_void',@CONE,0.0,15.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2190,1540,'extreme_purgation',@AOE,0.0,20.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2191,1541,'desiccation',@SINGLE,0.0,10.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2192,1542,'doomvoid',@AOE,0.0,30.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2193,1581,'zephyr_arrow',@SINGLE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,3,0,0,0);
INSERT INTO `mob_skills` VALUES (2194,1582,'lethe_arrows',@SINGLE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,3,0,0,0);
INSERT INTO `mob_skills` VALUES (2195,1583,'spring_breeze',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2196,1584,'summer_breeze',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2197,1585,'autumn_breeze',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2198,1586,'winter_breeze',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2199,1587,'cyclonic_turmoil',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,5,0,0,0);
INSERT INTO `mob_skills` VALUES (2200,1588,'cyclonic_torrent',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2201,1555,'orcish_counterstance',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2202,1946,'berserker_dance',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2203,1563,'diamond_shell',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2204,1948,'ore_lob',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2205,1565,'feathered_furore',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2206,1950,'dark_invocation',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2207,1951,'disorienting_waul',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2208,1952,'microspores',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2209,1607,'blink_of_peril',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2210,1603,'petal_pirouette',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2211,1955,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2212,1956,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2213,1957,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2214,1958,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2215,1959,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2216,1597,'nocturnal_combustion',@AOE,0.0,20.0,2000,500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2217,1598,'berserk',@SINGLE,0.0,7.0,2000,1000,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2218,1599,'penumbral_impact',@SINGLE,0.0,7.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2219,1600,'dark_wave',@AOE,0.0,10.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2220,1964,'tartarean_storm',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2221,1965,'hell_scissors',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2222,1602,'hurricane_breath',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2223,1557,'ore_toss',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2224,1558,'head_butt',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2225,1559,'shell_bash',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2226,1560,'shell_guard',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2227,354,'howl',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2228,1972,'the_wrath_of_gu'dha',@SINGLE,0.0,7.0,2000,1500,4,0,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2229,1973,'poison_breath',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2230,1974,'poison_sting',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2231,1975,'venom',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2232,1976,'queasyshroom',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2233,1608,'diamond_shell',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2234,1978,'ore_lob',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2235,1979,'paralyzing_blast',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2236,1980,'silencing_blast',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2237,1981,'binding_blast',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2238,1982,'bloody_tomahawk',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2239,1983,'volant_angon',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2240,1984,'warden_of_terror',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2241,1985,'call_to_arms',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2242,432,'mighty_strikes',@SINGLE,0.0,18.0,2000,0,@SELF,@NONE,30,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2243,1987,'hundred_fists',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2244,1988,'benediction',@AOE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2245,1989,'manafont',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2246,1990,'chainspell',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2247,1991,'perfect_dodge',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2248,432,'invincible',@SINGLE,0.0,18.0,2000,0,@SELF,@NONE,30,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2249,432,'blood_weapon',@SINGLE,0.0,18.0,2000,0,@SELF,@NONE,30,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2250,1994,'familiar',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2251,1995,'soul_voice',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2252,1298,'eagle_eye_shot',@SINGLE,0.0,25.0,2000,0,@ENEMY,@ASTRAL_FLOW,0,0,0,0,0); -- troll
-- INSERT INTO `mob_skills` VALUES (2253,1997,'meikyo_shisui',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2254,1998,'mijin_gakure',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2255,1999,'spirit_surge',@SINGLE,0.0,7.0,2000,0,@SELF,@ASTRAL_FLOW,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2256,432,'astral_flow_pet',@SINGLE,0.0,7.0,2000,0,@SELF,@ASTRAL_FLOW,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2257,432,'azure_lore',@SINGLE,0.0,18.0,2000,0,@SELF,@NONE,30,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2258,2002,'wild_card',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2259,2003,'overdrive',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2260,2004,'trance',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2261,2005,'tabula_rasa',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2262,1617,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2263,2007,'tornado_edge',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2264,2008,'shoulder_charge',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2265,2009,'skull_smash',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2266,2010,'shell_charge',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2267,2011,'skull_smash',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2268,2012,'shell_charge',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2269,1300,'kamaitachi',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0); -- need id verification & correct animation
-- INSERT INTO `mob_skills` VALUES (2270,2014,'shirahadori',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2271,2015,'rising_dragon',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2272,2016,'bear_killer',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2273,2017,'uriel_blade',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2274,2018,'spine_chiller',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2275,2019,'prominence',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2276,2020,'arrow_of_apathy',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2277,2021,'cruel_riposte',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2278,2022,'glory_slash',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2279,2023,'napalm_tomahawk',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2280,2024,'iainuki',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2281,2025,'oppressive_embrace',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2282,2026,'reverie_frolic',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2283,2027,'tartarus_torpor',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2284,2028,'death_knell',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2285,2029,'bloody_quarrel',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2286,2030,'leonine_legflail',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2287,2031,'soulfetter_arrow',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2288,2032,'heavy_artillery',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2289,2033,'immortal_shield',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2290,2034,'restoral',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2291,2035,'restoral',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2292,2036,'restoral',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2293,2037,'restoral',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2294,2038,'basilisk_cannon',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2295,2039,'beaked_bomber',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2296,2040,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2297,2041,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2298,2042,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2299,1486,'bone_crusher',@SINGLE,0.0,7.0,2000,1,@ENEMY,@NONE,245,0,12,0,0);
INSERT INTO `mob_skills` VALUES (2300,1487,'armor_piercer',@SINGLE,0.0,15.0,2000,1,@ENEMY,@NONE,245,0,9,0,0);
INSERT INTO `mob_skills` VALUES (2301,1488,'magic_mortar',@SINGLE,0.0,10.0,2000,1,@ENEMY,@NONE,225,0,11,3,0);
-- INSERT INTO `mob_skills` VALUES (2302,2046,'light_arts',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2303,2047,'dark_arts',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2304,2048,'curing_waltz',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2305,2049,'healing_waltz',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2306,2050,'drain_samba',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2307,2051,'haste_samba',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2308,2052,'quickstep',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2309,2053,'box_step',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2310,2054,'stutter_step',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2311,2055,'building_flourish',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2312,2056,'desperate_flourish',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2313,2057,'reverse_flourish',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2314,2058,'parsimony',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2315,2059,'alacrity',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2316,2060,'manifestation',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2317,2061,'ebullience',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2318,2062,'curing_waltz_ii',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2319,2063,'curing_waltz_iii',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2320,2064,'curing_waltz_iv',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2321,2065,'drain_samba_ii',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2322,2066,'drain_samba_iii',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2323,2067,'animated_flourish',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2324,2068,'violent_flourish',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2325,2069,'wild_flourish',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2326,2070,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2327,1221,'mine_blast',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2328,2072,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2329,2073,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2330,2074,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2331,2075,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2332,2076,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2333,2077,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2334,1640,'wrath_of_zeus',@AOE,0.0,35.0,4000,2000,@ENEMY,@HIT_ALL,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2335,1639,'lightning_spear',@CONE,0.0,35.0,4000,2000,@ENEMY,@HIT_ALL,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2336,1642,'acheron_kick',@REARCONE,0.0,35.0,2000,1000,@ENEMY,@HIT_ALL,0,7,0,0,0);
INSERT INTO `mob_skills` VALUES (2337,1653,'damsel_memento',@SINGLE,0.0,7.0,2000,1000,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2338,1641,'rampant_stance',@AOE,0.0,35.0,2000,3000,@ENEMY,@HIT_ALL,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2339,1643,'di_trample',@SINGLE,0.0,35.0,0,0,@ENEMY,@HIT_ALL,0,2,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2340,2084,'extreme_purgation',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2341,1647,'di_kick_attack',@SINGLE,0.0,35.0,1000,0,@ENEMY,@HIT_ALL,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2342,1645,'di_horn_attack',@SINGLE,0.0,35.0,1000,0,@ENEMY,@HIT_ALL,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2343,1638,'di_glow',@SINGLE,0.0,30.0,4000,0,@ENEMY,@HIT_ALL,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2344,2088,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2345,2089,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2346,2090,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2347,2091,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2348,2092,'glacial_bellow',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2349,2093,'daunting_hurl',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2350,2094,'scatter_shell',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2351,2095,'tear_grenade',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2352,2096,'sticky_grenade',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2353,2097,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2354,2098,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2355,2099,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2356,2100,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2357,2101,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2359,1201,'strap_cutter',@SINGLE,0.0,20.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2360,1195,'wind_shear_znm',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,7,0,0,0);
INSERT INTO `mob_skills` VALUES (2361,1269,'stave_toss',@SINGLE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2362,2106,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2363,2107,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2364,2108,'unblest_jambiya',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2365,2109,'goddesss_shield',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2366,1221,'mine_blast',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2367,2111,'moribund_hack',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2368,2112,'damsel_memento',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2369,1652,'scintillant_lance',@CONE,0.0,10.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2370,2114,'grace_of_hera',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2371,2115,'noxious_spray',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2372,2116,'hellborn_yawp',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2373,2117,'veil_of_chaos',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2374,2118,'torment_of_gu'dha',@SINGLE,0.0,7.0,2000,1500,4,0,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2375,2119,'vorticose_sands',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2376,2120,'paroxysm',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2377,2121,'reviviscence',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2378,2122,'diamond_shell',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2379,2123,'invincible',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2380,2124,'monocular_scowl',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2381,2125,'double_kick',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2382,2126,'mijin_gakure',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2383,2127,'charm',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2384,2128,'orbital_earthrend',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2385,2129,'tongue_lash',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2386,2130,'cobra_clamp',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2387,1660,'fatal_scream',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2388,2132,'dirty_breath',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2389,1662,'lethal_triclip',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2390,2134,'accursed_armor',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2391,2135,'amnesic_blast',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2392,1665,'oppressive_glare',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2393,2137,'ritual_bind',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2394,2138,'moribund_hack',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2395,2139,'mine_blast',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2396,2140,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2397,2141,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2398,2142,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2399,2143,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2400,2144,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2401,2145,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2402,2146,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2403,2147,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2404,2148,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2405,2149,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2406,2150,'roar',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2407,2151,'charged_whisker',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2408,2152,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2409,2153,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2410,2410,'demonic_flower',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2411,2411,'phantasmal_dance',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,15,0,0,0);
INSERT INTO `mob_skills` VALUES (2412,2412,'thunderous_yowl',@AOE,0.0,20.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2413,2413,'feather_maelstrom',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2414,2414,'saucepan',@CONE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2415,2159,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2416,2160,'seed_of_deception',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2417,2161,'seed_of_deference',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2418,2162,'seed_of_nihility',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2419,2163,'seed_of_judgment',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2420,2164,'shackling_clout',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2421,1682,'dark_orb',@AOE,0.0,15.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0); -- flying only.
INSERT INTO `mob_skills` VALUES (2422,1678,'dark_mist',@AOE,0.0,14.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0); -- flying only.
INSERT INTO `mob_skills` VALUES (2423,1680,'triumphant_roar',@SINGLE,0.0,7.0,2000,1000,@SELF,@NONE,0,0,0,0,0); -- standing only.
INSERT INTO `mob_skills` VALUES (2424,1681,'terror_eye',@CONE,0.0,10.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0); -- standing only.
INSERT INTO `mob_skills` VALUES (2425,1679,'bloody_claw',@SINGLE,0.0,7.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2426,1704,'reaving_wind_kb',@AOE,0.0,10.0,2000,0,@ENEMY,@NO_TP_COST,0,7,0,0,0);
INSERT INTO `mob_skills` VALUES (2427,1705,'tail_lash',@CONE,0.0,10.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2428,1706,'bloody_beak',@AOE,0.0,15.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2429,1707,'feral_peck',@SINGLE,0.0,9.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2430,1708,'warped_wail',@AOE,0.0,20.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2431,1709,'reaving_wind',@AOE,0.0,15.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2432,1710,'storm_wing',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2433,1711,'calamitous_wind',@AOE,0.0,15.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2434,2178,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2435,1697,'severing_fang',@CONE,0.0,7.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2436,1698,'sub-zero_smash',@CONE,0.0,5.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2437,1699,'aqua_blast',@CONE,0.0,7.0,2000,1000,@ENEMY,@NONE,0,2,0,0,0);  -- TODO: Verify knockback value.
INSERT INTO `mob_skills` VALUES (2438,1700,'frozen_mist',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2439,1701,'hydro_wave',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2440,2184,'ice_guillotine',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2441,2185,'aqua_cannon',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2442,1714,'thorned_stance',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2443,1715,'sensual_dance',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2444,1712,'dancers_fury',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2445,1713,'whirling_edge',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2446,1716,'rousing_samba',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2447,1717,'vivifying_waltz',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2448,1686,'regal_scratch',@AOE,0.0,18.0,2000,1000,@ENEMY,@BLOOD_PACT_RAGE,0,0,4,0,0); -- Scission (4)
INSERT INTO `mob_skills` VALUES (2449,1687,'mewing_lullaby',@AOE,0.0,18.0,2000,1000,@ENEMY,@BLOOD_PACT_WARD,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2450,1688,'eerie_eye',@AOE,0.0,18.0,2000,1000,@ENEMY,@BLOOD_PACT_WARD,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2451,1689,'divine_favor',@AOE,0.0,18.0,2000,1000,@SELF,@BLOOD_PACT_WARD,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2452,1690,'level-1-holy',@AOE,0.0,18.0,2000,1000,@ENEMY,@BLOOD_PACT_RAGE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2453,1691,'level-2-holy',@AOE,0.0,18.0,2000,1000,@ENEMY,@BLOOD_PACT_RAGE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2454,1692,'level-3-holy',@AOE,0.0,18.0,2000,1000,@ENEMY,@BLOOD_PACT_RAGE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2455,1693,'level-4-holy',@AOE,0.0,18.0,2000,1000,@ENEMY,@BLOOD_PACT_RAGE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2456,1694,'level-5-holy',@AOE,0.0,18.0,2000,1000,@ENEMY,@BLOOD_PACT_RAGE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2457,1695,'level-6-holy',@AOE,0.0,18.0,2000,1000,@ENEMY,@BLOOD_PACT_RAGE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2458,2202,'soul_vacuum',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2459,2203,'soul_infusion',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2460,1696,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2461,2205,'mog_bomb',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2462,2206,'mog_shrapnel',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2463,2207,'flowerpot',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2464,2208,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2465,2209,'bill_toss',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2466,2210,'washtub',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2467,2211,'crystalline_flare',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2468,2212,'king_cobra_clamp',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2469,2213,'wasp_sting',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2470,2214,'dancing_edge',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2471,2215,'bistillot_blast',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2472,2216,'songbird_swoop',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2473,2217,'vunkerl_herb_tonic',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2474,2218,'stag's_cry',@SINGLE,0.0,7.0,2000,1500,4,0,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2475,2219,'stag's_call',@SINGLE,0.0,7.0,2000,1500,4,0,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2476,2220,'gyre_strike',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2477,2221,'stag's_charge',@SINGLE,0.0,7.0,2000,1500,4,0,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2478,2222,'orcsbane',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2479,2223,'temblor_blade',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2480,2224,'inferno',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2481,2225,'tidal_wave',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2482,2226,'earthen_fury',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2483,2227,'diamond_dust',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2484,2228,'judgment_bolt',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2485,2229,'aerial_blast',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2486,2230,'salvation_scythe',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2487,2231,'salvation_scythe',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2488,2232,'divine_malison',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2489,2233,'divine_malison',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2490,1728,'fire_overload',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2491,1729,'ice_overload',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2492,1730,'wind_overload',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2493,1731,'earth_overload',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2494,1732,'lightning_overload',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2495,1733,'water_overload',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2496,1734,'light_overload',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2497,1735,'dark_overload',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2498,2242,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2499,1737,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2500,1738,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2501,2245,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2502,2246,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2503,1741,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2504,2248,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2505,1743,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2506,2250,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2507,2251,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2508,2252,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2509,2253,'hypothermal_combustion',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2510,2254,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2511,2255,'corpse_breath',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2512,1778,'venom_shower',@AOE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2513,1781,'mega_scissors',@AOETARGET,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2514,1773,'cytokinesis',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2515,2072,'phason_beam',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2516,2260,'gravitic_horn',@AOE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2517,2261,'quake_blast',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2518,2262,'norn_arrows',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2519,1756,'dexter_wing',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,2,0,0,0);
INSERT INTO `mob_skills` VALUES (2520,1757,'sinister_wing',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,2,0,0,0);
INSERT INTO `mob_skills` VALUES (2521,1758,'chaos_blast',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2522,1759,'abyssic_buster',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2523,1760,'dancing_tail',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2524,1761,'dancing_tailv2',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2525,1762,'chilling_roar',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2526,1763,'chilling_roarv2',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2527,1764,'soul_douse',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2528,1765,'soul_dousev2',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2529,1766,'dark_star',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2530,1767,'dark_starv2',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2531,2275,'altair_bullet',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2532,2276,'savage_swordhand',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2533,1776,'lithic_ray',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2534,1774,'minax_glare',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2535,2279,'vicious_kick',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2536,1746,'boon_void',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2537,1747,'cruel_slash',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2538,1748,'spell_wall',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2539,1749,'implosion',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2540,1750,'umbral_orb',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2541,1751,'cross_smash',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2542,1752,'blighting_blitz',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2543,1753,'spawn_shadow',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2544,1754,'soma_wall',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2545,1755,'doom_arc',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2546,2290,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2547,2291,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2548,2292,'fluid_spread',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2549,176,'fluid_toss_claret',@SINGLE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2550,1770,'dissolve',@AOETARGET,0.0,7.0,2000,1500,18,0,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2551,2295,'mucus_spread',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2552,2296,'epoxy_spread',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2553,2297,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2554,2298,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2555,2299,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2556,2300,'ofnir',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2557,2301,'valfodr',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2558,2302,'yggr',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2559,1442,'gagnrath',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2560,2304,'sanngetall',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2561,2305,'geirrothr',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2562,1794,'acrid_stream',@CONE,0.0,8.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2563,1795,'rime_spray',@CONE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2564,1796,'blazing_bound',@AOE,0.0,21.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2565,1797,'molting_burst',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2566,1786,'diabolic_claw',@SINGLE,0.0,7.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2567,1787,'stygian_cyclone',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2568,1788,'deathly_diminuendo',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2569,1789,'hellish_crescendo',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2570,1790,'afflicting_gaze',@CONE,0.0,12.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2571,1791,'stygian_sphere',@SINGLE,0.0,9.0,2000,1000,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2572,1792,'malign_invocation',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2573,1793,'shadow_wreck',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2574,2318,'thousand_spears',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2575,63,'tainting_breath',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2576,1803,'mercurial_strike',@AOE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2577,1804,'mercurial_strike',@AOE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2578,1805,'colossal_slam',@AOE,0.0,15.0,2000,3000,@ENEMY,@NONE,0,1,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2579,2323,'phaeosynthesis',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2580,2324,'pandoras_curse',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2581,2325,'pandoras_gift',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2582,2326,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2583,2327,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2584,2328,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2585,1658,'testudo_tremor',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2586,2256,'ecliptic_meteor',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2587,2331,'inspirit',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2588,2332,'debonair_rush',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2589,2333,'iridal_pierce',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2590,2334,'lunar_revolution',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2591,2335,'great_divide',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2592,2336,'darkling_blade',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2593,2337,'demonic_shear',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2594,2338,'quietus_sphere',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2595,2339,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2596,2340,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2597,2341,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2598,2342,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2599,2343,'tepal_twist',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2600,2344,'bloom_fouette',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2601,2345,'petalback_spin',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2602,2346,'mortal_blast',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2603,2347,'heat_breath',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2604,2348,'gorge',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2605,2349,'disgorge',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2606,2350,'carousel',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2607,2351,'agaricus',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2608,2352,'terminal_sting',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2609,2353,'booming_bleat',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2610,2354,'vacant_gaze',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2611,2355,'blaster',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2612,2356,'wild_carrot',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2613,2357,'spiral_spin',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2614,2358,'noisome_powder',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2615,2359,'stag's_cry',@SINGLE,0.0,7.0,2000,1500,4,0,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2616,1814,'iron_giant_melee_vertical',@AOE,0.0,12.0,2000,0,@ENEMY,@NO_TP_COST,0,0,0,0,0); -- iron giant melee specials
-- INSERT INTO `mob_skills` VALUES (2617,1815,'iron_giant_melee_stomp',@AOE,0.0,12.0,2000,0,@ENEMY,@NO_TP_COST,0,0,0,0,0);    -- iron giant melee specials
-- INSERT INTO `mob_skills` VALUES (2618,1816,'iron_giant_melee_lateral',@AOE,0.0,12.0,2000,0,@ENEMY,@NO_TP_COST,0,0,0,0,0);  -- iron giant melee specials
INSERT INTO `mob_skills` VALUES (2619,1817,'turbine_cyclone',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2620,1818,'seismic_impact',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2621,1819,'incinerator',@CONE,0.0,12.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2622,1820,'arm_cannon',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2623,1821,'ballistic_kick',@CONE,0.0,12.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2624,1822,'scapula_beam',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2625,1823,'eradicator',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2626,1824,'auger_smash',@SINGLE,0.0,9.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2627,1825,'area_bombardment',@CONE,0.0,12.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2628,2372,'cauterizing_field',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2629,1829,'benthic_typhoon',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2630,2374,'pelagic_tempest',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2631,1831,'osmosis',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2632,1832,'vacuole_discharge',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2633,2377,'nucleic_implosion',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2634,1810,'interference',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2635,1811,'dark_arrivisme',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2636,2380,'banneret_charge',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2637,1813,'besiegers_bane',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2638,2382,'hadal_summons',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2639,1835,'mayhem_lantern',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2640,2384,'ruinous_scythe',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2641,2385,'psyche_suction',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2642,2386,'vermilion_wind',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2643,2387,'tyrant_tusk',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2644,2388,'somnial_durance',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2645,2389,'mud_stream',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2646,2390,'rancor_smash',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2647,2391,'melancholy_jig',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2648,2392,'forlorn_impact',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2649,2393,'essence_jack',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2650,1861,'shinryu_attack_right',@SINGLE,0.0,7.0,3000,2000,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2651,1862,'shinryu_attack_left',@SINGLE,0.0,7.0,3000,2000,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2652,1863,'shinryu_attack_right_2',@SINGLE,0.0,7.0,3000,2000,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2653,1864,'shinryu_attack_left_2',@SINGLE,0.0,7.0,3000,2000,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2654,1865,'shinryu_attack_tail_1',@SINGLE,0.0,7.0,3000,2000,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2655,1866,'shinryu_attack_tail_2',@SINGLE,0.0,7.0,3000,2000,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2656,1867,'shinryu_attack_tail_stun',@SINGLE,0.0,7.0,3000,2000,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2657,1873,'shinryu_attack_right',@SINGLE,0.0,7.0,3000,2000,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2658,1874,'shinryu_attack_left',@SINGLE,0.0,7.0,3000,2000,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2659,1875,'shinryu_attack_right_2',@SINGLE,0.0,7.0,3000,2000,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2660,1876,'shinryu_attack_left_2',@SINGLE,0.0,7.0,3000,2000,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2661,1877,'shinryu_attack_tail_1',@SINGLE,0.0,7.0,3000,2000,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2662,1878,'shinryu_attack_tail_2',@SINGLE,0.0,7.0,3000,2000,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2663,1879,'shinryu_attack_tail_stun',@SINGLE,0.0,7.0,3000,2000,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2664,1868,'cosmic_breath',@CONE,0.0,15.0,4000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2665,1869,'cataclysmic_vortex',@AOE,0.0,15.0,4000,5000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2666,1882,'gyre_charge',@AOE,0.0,15.0,4000,2000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2667,1870,'mighty_guard',@SINGLE,0.0,7.0,3000,2000,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2668,1871,'atomic_ray',@AOE,0.0,20.0,4000,1500,@ENEMY,@NONE,0,0,0,0,0); -- 66% and below
INSERT INTO `mob_skills` VALUES (2669,1883,'darkmatter',@AOE,0.0,20.0,4000,1500,@ENEMY,@NONE,0,0,0,0,0); -- 66% and below
INSERT INTO `mob_skills` VALUES (2670,1872,'protostar',@AOE,0.0,20.0,5000,3500,@ENEMY,@NONE,0,0,0,0,0); -- 33% and below
INSERT INTO `mob_skills` VALUES (2671,1884,'supernova',@AOE,0.0,20.0,5000,3500,@ENEMY,@NONE,0,0,0,0,0); -- 33% and below
-- INSERT INTO `mob_skills` VALUES (2672,2416,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2673,2417,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2674,2418,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2675,1843,'dark_thorn',@AOE,0.0,18.0,2000,1000,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2676,1844,'petaline_tempest',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2677,1845,'durance_whip',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2678,1846,'subjugating_slash',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2679,1847,'fatal_allure',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2680,1848,'moonlight_veil',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2681,2425,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2682,2426,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2683,2427,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2684,1850,'dark_flare',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2685,1851,'dark_freeze',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2686,1852,'dark_tornado',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2687,1853,'dark_quake',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2688,1854,'dark_burst',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2689,1855,'dark_flood',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2690,1856,'dark_moon',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2691,1857,'dark_sun',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2692,1812,'royal_decree',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2693,2437,'virulent_haze',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2694,2438,'cyclonic_blight',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2695,2439,'torment_tusk',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2696,2440,'baleful_roar',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2697,2441,'infinite_terror',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2698,1381,'lithic_breath',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2699,2443,'tarsal_slam',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2700,2444,'enthrall',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2701,2445,'acheron_flame',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2702,2446,'terra_wing',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2703,2447,'dread_wind',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2704,2448,'questionmarks_needles',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2705,2449,'white_wind',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2706,745,'smokebomb',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2707,749,'paralysis_shower',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2708,1880,'cosmic_breath',@CONE,0.0,15.0,4000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2709,1881,'cataclysmic_vortex',@AOE,0.0,15.0,4000,5000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2710,2454,'trance',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2711,1897,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2712,1898,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2713,1899,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2714,1900,'yaksha_stance',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2715,1901,'yaksha_damnation',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2716,1902,'yaksha_bliss',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2717,1903,'yaksha_oblivion',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2718,1904,'raksha_stance',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2719,1905,'raksha_judgement',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2720,1906,'raksha_illusion',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2721,1907,'raksha_vengeance',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2722,1909,'harpeia_melee_stomp',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NO_TP_COST,0,0,0,0,0); -- harpeia melee specials
-- INSERT INTO `mob_skills` VALUES (2723,1910,'harpeia_melee_slash',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NO_TP_COST,0,0,0,0,0); -- harpeia melee specials
-- INSERT INTO `mob_skills` VALUES (2724,1911,'harpeia_melee_fly',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NO_TP_COST,0,0,0,0,0);   -- harpeia melee specials
INSERT INTO `mob_skills` VALUES (2725,1912,'rending_talons',@SINGLE,0.0,7.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2726,1913,'shrieking_gale',@AOE,0.0,15.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2727,1914,'wings_of_woe',@AOE,0.0,15.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2728,1915,'wings_of_agony',@AOE,0.0,15.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2729,1916,'typhoean_rage',@AOE,0.0,15.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2730,1917,'ravenous_wail',@AOE,0.0,15.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2731,2475,'incinerator',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2732,2476,'arm_cannon',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2733,2477,'ballistic_kick',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2734,2478,'cauterizing_field',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2735,2479,'searing_tempest',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2736,2480,'blinding_fulgor',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2737,1887,'spectral_floe',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2738,1888,'scouring_spate',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2739,1889,'anvil_lightning',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2740,1890,'silent_storm',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2741,2485,'entomb',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2742,2486,'tenebral_crush',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2743,1509,'string_shredder',@SINGLE,0.0,7.0,2000,1,@ENEMY,@NONE,324,0,10,4,0);
INSERT INTO `mob_skills` VALUES (2744,1510,'armor_shatterer',@SINGLE,0.0,7.0,2000,1,@ENEMY,@NONE,324,0,11,8,0);
INSERT INTO `mob_skills` VALUES (2745,433,'heat_capacitor',@SINGLE,0.0,7.0,2000,0,16,4,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2746,16,'barrage_turbine',@SINGLE,0.0,25.0,2000,0,@ENEMY,@NO_TP_COST,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2747,439,'disruptor',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NO_TP_COST,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2748,1922,'mantid_melee_double',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NO_TP_COST,0,0,0,0,0); -- kaggan melee specials
-- INSERT INTO `mob_skills` VALUES (2749,1923,'mantid_melee_slice',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NO_TP_COST,0,0,0,0,0);  -- kaggan melee specials
-- INSERT INTO `mob_skills` VALUES (2750,1924,'mantid_melee_jump',@AOE,0.0,7.0,2000,0,@ENEMY,@NO_TP_COST,0,0,0,0,0);   -- kaggan melee specials
INSERT INTO `mob_skills` VALUES (2751,1925,'slicing_sickle',@CONE,0.0,12.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2752,1926,'raptorial_claw',@AOE,0.0,15.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2753,1927,'phlegm_expulsion',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2754,1928,'macerating_bile',@AOE,0.0,15.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2755,1929,'preying_posture',@SINGLE,0.0,7.0,2000,1000,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2756,1930,'dead_prophet',@CONE,0.0,10.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2757,1931,'sakra_storm',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2758,1932,'kaleidoscopic_fury',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2759,2503,'telsonic_tempest',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2760,1934,'preternatural_gleam',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2761,2505,'chupa_blossom',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2762,2506,'hell_slash',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2763,2507,'horror_cloud',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2764,2508,'black_cloud',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2765,2509,'blood_saber',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2766,2510,'malediction',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2767,2511,'crepuscule_blade',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2768,2512,'deathly_glare',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2769,1943,'blighted_bouquet',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2770,1944,'booming_bombination',@AOE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2771,2515,'gush_o_goo',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2772,2516,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2773,2517,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2774,1951,'flank_opening',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2775,1950,'tabbiyaa_gambit',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2776,1949,'shah_mat',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2777,438,'benediction',@AOE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2778,2522,'reactive_shield',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2779,2523,'shock_absorber',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2780,2524,'replicator',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2781,1953,'gallu_melee_triple',@SINGLE,0.0,10.0,2000,0,@ENEMY,@NO_TP_COST,0,3,0,0,0);  -- gallu melee specials
-- INSERT INTO `mob_skills` VALUES (2782,1954,'gallu_melee_frontal',@CONE,0.0,10.0,2000,0,@ENEMY,@NO_TP_COST,0,0,0,0,0); -- gallu melee specials
-- INSERT INTO `mob_skills` VALUES (2783,1955,'gallu_melee_radial',@AOE,0.0,10.0,2000,0,@ENEMY,@NO_TP_COST,0,0,0,0,0);  -- gallu melee specials
INSERT INTO `mob_skills` VALUES (2784,1956,'diluvial_wakes',@CONE,0.0,10.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2785,1957,'kurugi_collapse',@AOE,0.0,15.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2786,1958,'searing_halitus',@AOE,0.0,15.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2787,1959,'divesting_gale',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2788,1960,'bolt_of_perdition',@AOE,0.0,15.0,2000,1000,@ENEMY,@NONE,0,3,0,0,0);
INSERT INTO `mob_skills` VALUES (2789,1961,'crippling_rime',@CONE,0.0,10.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2790,1962,'oblivions_mantle',@AOE,0.0,15.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2791,2535,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2792,2536,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2793,1963,'botulus_melee_bite',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NO_TP_COST,0,0,0,0,0);  -- botulus melee specials
-- INSERT INTO `mob_skills` VALUES (2794,1964,'botulus_melee_front',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NO_TP_COST,0,0,0,0,0); -- botulus melee specials
-- INSERT INTO `mob_skills` VALUES (2795,1965,'botulus_melee_left',@AOE,0.0,7.0,2000,0,@ENEMY,@NO_TP_COST,0,0,0,0,0);  -- botulus melee specials (left/right are technically same attack, diff animation)
-- INSERT INTO `mob_skills` VALUES (2796,1966,'botulus_melee_right',@AOE,0.0,7.0,2000,0,@ENEMY,@NO_TP_COST,0,0,0,0,0); -- botulus melee specials (which is why we have 1 more attack type here than is discussed on wiki)
-- INSERT INTO `mob_skills` VALUES (2797,1967,'botulus_melee_back',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NO_TP_COST,0,0,0,0,0);  -- botulus melee specials
-- INSERT INTO `mob_skills` VALUES (2798,1968,'gnash_n_guttle',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,3,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2799,1969,'sloughy_sputum',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2800,1970,'chymous_reek',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2801,1971,'rancid_reflux',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2802,1972,'crowning_flatus',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2803,1973,'slimy_proposal',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2804,1974,'just_desserts',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2805,2549,'pawn's_penumbra',@SINGLE,0.0,7.0,2000,1500,4,0,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2806,2550,'beleaguerment',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2807,2551,'unchivalrous_stab',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2808,2552,'discordant_gambit',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2809,2553,'immolating_claw',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2810,2554,'yamas_judgment',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2811,1991,'keraunos_quill',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2812,2556,'bilrost_squall',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2813,2557,'dunur_strike',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2814,2558,'yawn',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2815,2559,'wing_slap',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2816,2560,'beak_lunge',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2817,2561,'frigid_shuffle',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2818,2562,'wing_whirl',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2819,2563,'whiteout',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2820,2564,'keratinous_crush',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2821,2565,'accurst_spear',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2822,2566,'eldritch_wind',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2823,1986,'rhinowrecker',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2824,2568,'cloudscourge',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2825,2569,'louring_skies',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2826,1992,'exponential_burst',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2827,2571,'sudden_lunge',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2828,911,'jettatura',@CONE,0.0,10.0,2000,3000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2829,2573,'aqua_breath',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2830,2574,'royal_decree',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2831,2575,'grace_of_hera',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2832,2576,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2833,2577,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2834,2578,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2835,2579,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2836,2580,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2837,2581,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2838,2582,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2839,2056,'prismatic_breath',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2840,2057,'acicular_brand',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2841,2058,'orogenesis',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2842,2059,'phason_beam',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2843,2060,'diffractive_break',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2844,2061,'euhedral_swat',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2845,2589,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2846,2590,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2847,2591,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2848,2592,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2849,2593,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2850,2594,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2851,2595,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2852,2069,'prismatic_breath',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2853,2070,'acicular_brand',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2854,2071,'orogenesis',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2855,2599,'phason_beam',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2856,2073,'diffractive_break',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2857,2074,'euhedral_swat',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2858,2075,'crystallite_shower',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2859,2076,'graviton_crux',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2860,2077,'crystal_bolide',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2861,2078,'fragor_maximus',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2862,1998,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2863,1999,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2864,2000,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2865,2001,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2866,2002,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2867,2003,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2868,2004,'echolocation',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2869,2005,'deep_sea_dirge',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2870,2006,'caudal_capacitor',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2871,2007,'baleen_gurge',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2872,2008,'depht_charge',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2873,2009,'blowhole_blast',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2874,2011,'angry_seas',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2875,2010,'waterspout',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2876,2012,'thar_she_blows',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2877,2621,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2878,2622,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2879,2623,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2880,2016,'night_stalker',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2881,2017,'atropine_spore',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2882,2018,'frond_fatale',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2883,2019,'full_bloom',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2884,2020,'deracinator',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2885,2021,'beautiful_death',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2886,2630,'exorender',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2887,2631,'tropic_tenor',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2888,2632,'dark_recital',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2889,2633,'usurping_scepter',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2890,2634,'genei_ryodan',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2891,2029,'grapeshot',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,3,2,0);
INSERT INTO `mob_skills` VALUES (2892,2030,'pirate_pummel',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,9,0,0);
INSERT INTO `mob_skills` VALUES (2893,2031,'powder_keg',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,5,1,0);
INSERT INTO `mob_skills` VALUES (2894,2032,'walk_the_plank',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,11,0,0);
INSERT INTO `mob_skills` VALUES (2895,2639,'knuckle_sandwich',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2896,2640,'imperial_authority',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2897,2641,'sixth_element',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2898,2642,'shield_subverter',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2899,2643,'shining_summer_samba',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2900,2644,'lovely_miracle_waltz',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2901,2645,'neo_crystal_jig',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2902,2646,'super_crusher_jig',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2903,2647,'eternal_vana_illusion',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2904,2648,'final_eternal_heart',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2905,2649,'shah's_decree',@SINGLE,0.0,7.0,2000,1500,4,0,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2906,2650,'false_promises',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2907,2651,'frog_song',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2908,2652,'frog_chorus',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2909,2653,'level_3_petrify',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2910,2654,'citadel_siege',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2911,2655,'catastrophic_malfunction',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2912,1447,'zantetsuken_kai',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2913,2657,'electrocharge',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2914,2658,'rear_lasers',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2915,2659,'meeble_warble',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2916,2660,'thrashing_assault',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2917,2661,'drill_claw',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2918,2662,'puncturing_frenzy',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2919,43,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2920,44,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2921,45,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2922,46,'soulshattering_roar',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2923,47,'calcifying_claw',@SINGLE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,1,0,0,0);
INSERT INTO `mob_skills` VALUES (2924,48,'divesting_stampede',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,1,0,0,0);
INSERT INTO `mob_skills` VALUES (2925,49,'bonebreaking_barrage',@SINGLE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2926,2098,'beastruction',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2927,38,'metamorphic_blast',@CONE,0.0,12.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2928,39,'enervating_grasp',@AOE,0.0,15.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2929,40,'orogenic_storm',@AOE,0.0,14.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2930,41,'subduction',@AOE,0.0,15.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2931,2675,'tectonic_shift',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2932,2676,'unrelenting_brand',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2933,2677,'searing_effulgence',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2934,2045,'blazing_shriek',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2935,2079,'volcanic_wrath',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2936,2680,'tarichutoxin',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2937,2681,'caliginosity',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2938,2682,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2939,2683,'mighty_strikes',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2940,2684,'invincible',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2941,2685,'eagle_eye_shot',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@ASTRAL_FLOW,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2942,2686,'chainspell',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2943,2687,'benediction',@AOE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2944,2688,'manafont',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2945,119,'natures_meditation',@AOE,0.0,18.0,2000,1000,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2946,120,'sensilla_blades',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2947,121,'tegmina_buffet',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2948,122,'sanguinary_slash',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2949,123,'orthopterror',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2950,2129,'tempestuous_upheaval',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,7,0,0,0);
INSERT INTO `mob_skills` VALUES (2951,82,'slice_n_dice',@SINGLE,0.0,25.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2952,2131,'blackout',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2953,2132,'smouldering_swarm',@AOE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,7,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2954,2698,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2955,2699,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2956,2700,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2957,132,'impenetrable_carapace',@AOE,0.0,18.0,2000,1000,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2958,133,'rending_deluge',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2959,134,'sundering_snip',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2960,135,'viscid_spindrift',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2961,2184,'riptide_eupnea',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2962,73,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2963,74,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2964,75,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2965,76,'cranial_thrust',@CONE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2966,2125,'tail_thwack',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2967,2126,'embalming_earth',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2968,2127,'scalding_breath',@CONE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2969,2128,'debilitating_spout',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2970,137,'paralyzing_triad',@SINGLE,0.0,7.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2971,138,'crepuscular_grasp',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2972,139,'necrotic_brume',@CONE,0.0,15.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2973,2717,'terminal_bloom',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2974,141,'foul_waters',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2975,142,'pestilent_plume',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2976,143,'deadening_haze',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2977,2721,'venomous_vapor',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2978,2162,'consecration',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2979,2163,'sacred_caper',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2980,2164,'phototrophic_blessing',@SINGLE,0.0,7.0,2000,1000,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2981,2165,'phototrophic_wrath',@SINGLE,0.0,7.0,2000,1000,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2982,2166,'deific_gambol',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2983,69,'ancestral_banishment',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2984,70,'heartfelt_aura',@SINGLE,0.0,7.0,2000,1000,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2985,71,'impairing_glister',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2986,2120,'crippling_gleam',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2987,2731,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2988,107,'glutinous_dart',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2989,108,'death_spin',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2990,109,'velkkan_pygmachia',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2991,110,'saurian_slide',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (2992,2159,'jungle_wallop',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2993,2737,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2994,107,'glutinous_dart',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2995,108,'death_spin',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2996,2740,'velkkan_pygmachia',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2997,112,'saurian_swamp',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2998,2742,'jungle_hoodoo',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (2999,2133,'bztavian_melee_bite',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NO_TP_COST,0,0,0,0,0);    -- colkhab and muyingwa melee specials
-- INSERT INTO `mob_skills` VALUES (3000,2134,'bztavian_melee_slash',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NO_TP_COST,0,0,0,0,0);   -- colkhab and muyingwa melee specials
-- INSERT INTO `mob_skills` VALUES (3001,2135,'bztavian_melee_stinger',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NO_TP_COST,0,0,0,0,0); -- colkhab and muyingwa melee specials
INSERT INTO `mob_skills` VALUES (3002,88,'mandibular_lashing',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3003,89,'vespine_hurricane',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3004,90,'stinger_volley',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3005,91,'droning_whirlwind',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3006,92,'incisive_denouement',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3007,93,'incisive_apotheosis',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3008,2193,'rockfin_melee_bite',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NO_TP_COST,0,0,0,0,0); -- tchakka and dakuwaqa melee specials
-- INSERT INTO `mob_skills` VALUES (3009,2194,'rockfin_melee_ram',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NO_TP_COST,0,0,0,0,0);  -- tchakka and dakuwaqa melee specials
-- INSERT INTO `mob_skills` VALUES (3010,2195,'rockfin_melee_spin',@AOE,0.0,7.0,2000,0,@ENEMY,@NO_TP_COST,0,0,0,0,0); -- tchakka and dakuwaqa melee specials
INSERT INTO `mob_skills` VALUES (3011,2196,'protolithic_puncture',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3012,2197,'aquatic_lance',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3013,2198,'pelagic_cleaver',@AOE,0.0,18.0,2000,1000,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3014,2199,'carcharian_verve',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3015,2200,'tidal_guillotine',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3016,2201,'marine_mayhem',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3017,2761,'gabbrath_melee_bite',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NO_TP_COST,0,0,0,0,0);   -- achuka and tojil melee specials
-- INSERT INTO `mob_skills` VALUES (3018,2762,'gabbrath_melee_charge',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NO_TP_COST,0,0,0,0,0); -- achuka and tojil melee specials
-- INSERT INTO `mob_skills` VALUES (3019,2763,'gabbrath_melee_spin',@AOE,0.0,7.0,2000,0,@ENEMY,@NO_TP_COST,0,0,0,0,0);   -- achuka and tojil melee specials
INSERT INTO `mob_skills` VALUES (3020,2145,'blistering_roar',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3021,2146,'searing_serration',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3022,2147,'volcanic_stasis',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3023,2148,'tyrannical_blow',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3024,2149,'batholithic_shell',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3025,2150,'pyroclastic_surge',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3026,2151,'incinerating_lahar',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3027,104,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3028,105,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3029,106,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3030,51,'retinal_glare',@CONE,0.0,10.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3031,52,'sylvan_slumber',@AOE,0.0,15.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3032,53,'crushing_gaze',@AOE,0.0,15.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3033,2102,'vaskania',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3034,2778,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3035,2779,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3036,2780,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3037,2781,'flesh_syphon',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3038,2782,'umbral_expunction',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3039,2783,'sticky_situation',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3040,2784,'abdominal_assault',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3041,2785,'mandibular_massacre',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3042,2786,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3043,2787,'whirling_inferno',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3044,2788,'benumbing_blaze',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3045,2213,'concentric_pulse',@AOE,0.0,10.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3046,2790,'foul_waters',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3047,2791,'pestilent_plume',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3048,2792,'deadening_haze',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3049,2793,'sensilla_blades',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3050,2794,'tegmina_buffet',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3051,2211,'mending_halation',@AOE,0.0,10.0,2000,1000,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3052,2212,'radial_arcana',@AOE,0.0,10.0,2000,1000,@SELF,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3053,184,'dynastic_gravitas',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3054,2798,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3055,2799,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3056,2800,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3057,157,'root_of_the_problem',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3058,158,'potted_plant',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3059,159,'uproot',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3060,2208,'canopierce',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3061,161,'firefly_fandango',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3062,2210,'tiiimbeeer',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3063,2233,'molting_plumage',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3064,2234,'pentapeck',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3065,2235,'swooping_frenzy',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3066,2236,'from_the_skies',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3067,2811,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3068,2812,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3069,166,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3070,167,'',@CONE,0.0,7.0,2000,0,@ENEMY,@NO_TP_COST,0,0,0,0,0); -- hurkan and cailimh melee specials
-- INSERT INTO `mob_skills` VALUES (3071,168,'',@AOE,0.0,7.0,2000,0,@ENEMY,@NO_TP_COST,0,0,0,0,0); -- hurkan and cailimh melee specials
-- INSERT INTO `mob_skills` VALUES (3072,169,'crashing_thunder',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NO_TP_COST,0,0,0,0,0); -- hurkan and cailimh melee specials
INSERT INTO `mob_skills` VALUES (3073,170,'reverberating_cry',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3074,171,'brownout',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3075,172,'reverse_current',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3076,173,'sparkstorm',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3077,174,'static_prison',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3078,2222,'static_prison',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3079,2823,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3080,2824,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3081,2825,'velkkan_ambush',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3082,2826,'galumph',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3083,2827,'coming_through',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3084,2828,'merciless_mauling',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3085,2829,'croctastrophy',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3086,2830,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3087,2831,'battle_trance',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3088,2832,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3089,2833,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3090,2834,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3091,2835,'baneful_blades',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3092,2836,'wildwood_indignation',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3093,2837,'dryad's_kiss',@SINGLE,0.0,7.0,2000,1500,4,0,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3094,2838,'infected_illusion',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3095,2839,'depraved_dandia',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3096,2840,'matriarchal_fiat',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3097,124,'tickling_tendrils',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3098,125,'stink_bomb',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3099,126,'nectarous_deluge',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3100,127,'nepenthic_plunge',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3101,128,'infaunal_flop',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3102,189,'',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3103,2847,'ignis',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3104,2848,'gelus',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3105,2849,'flabra',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3106,2850,'tellus',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3107,2851,'sulpor',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3108,2852,'unda',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3109,2853,'lux',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3110,2854,'tenebrae',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3111,2855,'vallation',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3112,2856,'pflug',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3113,2857,'lunge',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3114,2858,'gambit',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3115,205,'bellatrix_of_light',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0); -- Arciela
INSERT INTO `mob_skills` VALUES (3116,206,'bellatrix_of_shadows',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3117,199,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3118,200,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3119,201,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3120,202,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3121,203,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3122,204,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3123,2867,'fighting_stance_a',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3124,2868,'fighting_stance_b',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3125,2869,'fighting_stance_g',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3126,2870,'fighting_stance_d',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3127,2267,'frizz',@SINGLE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0); -- basically a spell
-- INSERT INTO `mob_skills` VALUES (3128,2268,'astoltian_slime_hit',@SINGLE,0.0,5.0,2000,0,@ENEMY,@NONE,0,0,0,0,0); -- not a melee sub exactly, rather a mobskill with no message
-- INSERT INTO `mob_skills` VALUES (3129,2269,'astoltian_slime_run',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,0,0,0); -- depops mob
-- INSERT INTO `mob_skills` VALUES (3130,2874,'barreling_smash',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3131,227,'sweeping_gouge',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3132,228,'zealous_snort',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3133,2877,'terrifying_snap',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3134,2258,'cehuetzi_melee_left',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NO_TP_COST,0,0,0,0,0);  -- kumhau and utkux melee specials
-- INSERT INTO `mob_skills` VALUES (3135,2259,'cehuetzi_melee_right',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NO_TP_COST,0,0,0,0,0); -- kumhau and utkux melee specials
-- INSERT INTO `mob_skills` VALUES (3136,2260,'cehuetzi_melee_bite',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NO_TP_COST,0,0,0,0,0);  -- kumhau and utkux melee specials
INSERT INTO `mob_skills` VALUES (3137,2261,'polar_roar',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3138,2262,'brain_freeze',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3139,2263,'biting_abrogation',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3140,2264,'permafrost_requiem',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3141,2265,'glacial_tomb',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3142,2266,'glassy_nova',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3143,2887,'#1351',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3144,2888,'jittering_jig',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3145,2889,'romp',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3146,2890,'frenetic_flurry',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3147,2891,'#1355',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3148,2274,'noname',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3149,2275,'dazing_discord',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3150,2276,'steaming_rage',@AOE,0.0,18.0,2000,1000,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3151,2277,'noname',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3152,2289,'shining_salvo',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3153,2290,'palling_salvo',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3154,2291,'cathartic_caper',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3155,2292,'bewailing_wake',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3156,2293,'flight_of_the_fluttyries',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3157,2901,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3158,2902,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3159,2903,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3160,287,'vehement_resolution',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3161,288,'camaraderie_of_the_crevasse',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3162,289,'into_the_light',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3163,290,'arduous_decision',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3164,291,'12_blades_of_remorse',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3165,2320,'darrcuiln_charge',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NO_TP_COST,0,0,0,0,0); -- darrcuiln melee special
-- INSERT INTO `mob_skills` VALUES (3166,2321,'darrcuiln_claw',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NO_TP_COST,0,0,0,0,0);   -- darrcuiln melee special
-- INSERT INTO `mob_skills` VALUES (3167,2323,'darrcuiln_howl',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NO_TP_COST,0,0,0,0,0);   -- darrcuiln melee special
INSERT INTO `mob_skills` VALUES (3168,275,'aurous_charge',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3169,276,'howling_gust',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3170,277,'righteous_rasp',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3171,2326,'starward_yowl',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3172,279,'stalking_prey',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3173,432,'brazen_rush',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3174,2918,'cross_reaver',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3175,438,'meikyo_shisui',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3176,2920,'chant_du_cygne',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3177,238,'intervene',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3178,237,'arrogance_incarnate',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3179,236,'chant_du_cygne',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3180,2924,'soul_enslavement',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3181,2925,'amon_drive',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3182,2926,'larceny',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3183,438,'charm',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3184,634,'havoc_spiral',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3185,234,'cloudsplitter',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3186,434,'yaegasumi',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3187,2931,'dragonfall',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3188,2932,'tachi_fudo',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3189,1508,'king_cobra_clamp',@AOE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,12,10,0); -- Nanaa Mihgo
-- INSERT INTO `mob_skills` VALUES (3190,2934,'red_lotus_blade',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,3,6,0);
-- INSERT INTO `mob_skills` VALUES (3191,2935,'spirits_within',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3192,681,'vorpal_blade',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,4,8,0); -- Trion
INSERT INTO `mob_skills` VALUES (3193,669,'royal_bash',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3194,670,'royal_savior',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3195,671,'abyssal_drain',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0); -- Zied
INSERT INTO `mob_skills` VALUES (3196,672,'abyssal_strike',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3197,684,'ground_strike',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3198,2029,'grapeshot',@CONE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,3,2,0); -- Lion
INSERT INTO `mob_skills` VALUES (3199,2030,'pirate_pummel',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,9,0,0);
INSERT INTO `mob_skills` VALUES (3200,2031,'powder_keg',@CONE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,5,1,0);
INSERT INTO `mob_skills` VALUES (3201,2032,'walk_the_plank',@AOE,0.0,7.0,2000,1500,@ENEMY,@NONE,2,0,11,0,0);
INSERT INTO `mob_skills` VALUES (3202,257,'uriel_blade',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3203,1431,'scouring_bubbles',@AOE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,14,10,0);  -- Mihli
INSERT INTO `mob_skills` VALUES (3204,1036,'amatsu_tsukikage',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3205,673,'berserk-ruf',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3206,2950,'astral_distortion',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3207,2951,'ignition',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3208,496,'glacification',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3209,497,'vaporization',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3210,498,'terrafication',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3211,2955,'electrification',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3212,500,'liquification',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3213,2957,'vortex',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3214,502,'light_blade',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3215,1483,'peacebreaker',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3216,676,'red_lotus_blade',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,3,6,0);
INSERT INTO `mob_skills` VALUES (3217,678,'savage_blade',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,12,4,0);
INSERT INTO `mob_skills` VALUES (3218,251,'villainous_rebuke',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3219,252,'stygian_release',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3220,2301,'infernal_bulwark',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3221,254,'atramentous_libations',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3222,2966,'noahionto',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3223,2967,'shockiavona',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3224,2968,'hemorrhaze',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3225,2969,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3226,2970,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3227,2971,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3228,2972,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3229,2973,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3230,1782,'inspirit',@AOE,0.0,7.0,2000,1500,@PARTY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3231,1783,'debonair_rush',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3232,1784,'iridal_pierce',@AOE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3233,1785,'lunar_revolution',@CONE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3234,1095,'nullifying_dropkick',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,7,6,8);
INSERT INTO `mob_skills` VALUES (3235,1343,'auroral_uppercut',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,13,12,0);
INSERT INTO `mob_skills` VALUES (3236,2033,'knuckle_sandwich',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,11,2,8);
INSERT INTO `mob_skills` VALUES (3237,1427,'victory_beacon',@CONE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,13,10,0); -- Rughadjeen
-- INSERT INTO `mob_skills` VALUES (3238,2982,'salamander_flame',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3239,1429,'typhonic_arrow',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3240,1430,'meteoric_impact',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3241,2985,'shining_salvo',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3242,2986,'palling_salvo',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3243,2034,'imperial_authority',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,12,10,0);
INSERT INTO `mob_skills` VALUES (3244,2035,'sixth_element',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3245,2036,'shield_subverter',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3246,659,'absolute_terror',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3247,2991,'terric_breath',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3248,1037,'amatsu_kagamikaeshi',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3249,2993,'amatsu_mizumari',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3250,2994,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3251,438,'amatsu_shirahadori',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3252,2310,'bisection',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3253,263,'leaden_salute',@SINGLE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3254,2312,'akimbo_shot',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3255,2313,'grisly_horizon',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3256,361,'hane_fubuki',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,1,0,0); -- Gessho
INSERT INTO `mob_skills` VALUES (3257,1299,'shibaraku',@AOE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,1,14,9,0);
INSERT INTO `mob_skills` VALUES (3258,363,'shiko_no_mitate',@SINGLE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3259,364,'happobarai',@AOE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,5,8,0);
INSERT INTO `mob_skills` VALUES (3260,354,'rinpyotosha',@AOE,0.0,7.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3261,335,'bomb_toss',@AOETARGET,0.0,13.5,2000,1500,@ENEMY,@NONE,0,0,3,6,0);
INSERT INTO `mob_skills` VALUES (3262,334,'goblin_rush',@SINGLE,0.0,6.0,2000,1500,@ENEMY,@NONE,0,1,11,8,0);
INSERT INTO `mob_skills` VALUES (3263,1625,'bear_killer',@CONE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0); -- TODO: Skillchain properties
INSERT INTO `mob_skills` VALUES (3264,259,'salvation_scythe',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3265,3009,'elemental_sforzo',@SINGLE,0.0,7.0,2000,0,@SELF,@ASTRAL_FLOW,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3266,3010,'liement',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3267,3011,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3268,3012,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3269,3013,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3270,3014,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3271,3015,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3272,3016,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3273,3017,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3274,3018,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3275,1433,'burning_memories',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3276,1301,'kagedourou',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0); -- need verification of animation
INSERT INTO `mob_skills` VALUES (3277,1301,'karakuridourou',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0); -- need verification of animation
INSERT INTO `mob_skills` VALUES (3278,1302,'tsujikaze',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);  -- need verification of animation
-- INSERT INTO `mob_skills` VALUES (3279,3023,'sleepytime_boomboom',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3280,3024,'smelled_it_and_dealt_it',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3281,3025,'somnic_shell',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3282,3026,'contaminating_concoction',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3283,280,'iniquitous_stab',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3284,281,'shockstorm_edge',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3285,282,'choreographed_carnage',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3286,283,'lock_and_load',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3287,3031,'lunge',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3288,3032,'swath_of_silence',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3289,3033,'damning_edict',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3290,3034,'bowels_of_agony',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3291,1724,'stags_call',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0); -- Excenmille (S)
INSERT INTO `mob_skills` VALUES (3292,1725,'gyre_strike',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3293,1727,'stags_charge',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3294,1726,'orcsbane',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3295,1721,'songbird_swoop',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3296,259,'temblor_blade',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0); -- Ingrid
INSERT INTO `mob_skills` VALUES (3297,260,'cobra_clamp',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0); -- RomaaMihgo
-- INSERT INTO `mob_skills` VALUES (3298,304,'illustrious_aid',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3299,295,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3300,296,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3301,297,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3302,298,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3303,299,'feast_of_arrows',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3304,2348,'cruel_joke',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3305,2349,'regurgitated_swarm',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3306,302,'setting_the_stage',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3307,303,'last_laugh',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3308,1714,'thorned_dance',@SINGLE,0.0,18.0,2000,1000,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3309,1715,'sensual_dance',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3310,1712,'dancers_fury',@SINGLE,0.0,7.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3311,1713,'whirling_edge',@SINGLE,0.0,7.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3312,1716,'rousing_samba',@AOE,0.0,18.0,2000,1000,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3313,1717,'vivifying_waltz',@AOE,0.0,18.0,2000,1000,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3314,2353,'true_strike',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,6,8,0);
INSERT INTO `mob_skills` VALUES (3315,2354,'hexa_strike',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,11,0,0);
-- INSERT INTO `mob_skills` VALUES (3316,3060,'glutinous_dart',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3317,3061,'death_spin',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3318,3062,'velkkan_pygmachia',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3319,3063,'saurian_slide',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3320,3064,'jungle_wallop',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3321,3065,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3322,2356,'critical_mass',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3323,2355,'fiery_tailings',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3324,3068,'meteor_strike',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3325,3069,'inferno',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3326,3070,'wind_blade',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3327,3071,'aerial_blast',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3328,3072,'heavenly_strike',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3329,3073,'diamond_dust',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3330,3074,'thunderstorm',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3331,3075,'judgment_bolt',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3332,374,'geocrush',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3333,547,'earthen_fury',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3334,3078,'grand_fall',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3335,3079,'tidal_wave',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3336,314,'howling_moon',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3337,313,'lunar_bay',@SINGLE,0.0,10.0,519,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3338,3082,'chaos_blast',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3339,3083,'oblivion's_mantle',@SINGLE,0.0,7.0,2000,1500,4,0,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3340,3084,'dark_moon',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3341,3085,'dark_sun',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3342,3086,'dark_thorn',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3343,3087,'durance_whip',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3344,3088,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3345,3089,'dark_flare',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3346,3090,'dark_freeze',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3347,3091,'dark_tornado',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3348,3092,'dark_quake',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3349,3093,'dark_burst',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3350,3094,'dark_flood',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3351,46,'wild_oats',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0); -- BabbanMheillea
-- INSERT INTO `mob_skills` VALUES (3352,3096,'photosynthesis',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3353,1603,'petal_pirouette',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3354,44,'head_butt',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3355,325,'blow',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3356,328,'uppercut',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3357,331,'antiphase',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3358,330,'blank_gaze',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3359,3103,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3360,3104,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3361,3105,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3362,3106,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3363,325,'tearing_gust',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3364,326,'concussive_shock',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3365,327,'chokehold',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3366,328,'zap',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3367,329,'shrieking_gale',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3368,330,'undulating_shockwave',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3369,3113,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3370,3114,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3371,3115,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3372,334,'cesspool',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3373,335,'fetid_eddies',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3374,336,'nullifying_rain',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3375,337,'noyade',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3376,2386,'clobering_wave',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3377,3121,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3378,3122,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3379,3123,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3380,342,'start_from_scratch',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3381,343,'frenzied_thrust',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3382,344,'sinners_cross',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3383,345,'open_coffin',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3384,346,'ravenous_assault',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3385,347,'hemocladis',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3386,3130,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3387,3131,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3388,3132,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3389,2399,'fulminous_smash',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3390,2400,'flaming_kick',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3391,2401,'icy_grasp',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3392,2402,'flash_flood',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3393,2403,'eroding_flesh',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3394,2404,'vivisection',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3395,3139,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3396,3140,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3397,3141,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3398,3142,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3399,2409,'impudence',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3400,2410,'incessant_void',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3401,2411,'tenbrous_grip',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3402,2412,'demon_fire',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3403,2413,'frozen_blood',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3404,2414,'blast_of_reticence',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3405,2415,'ensepulcher',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3406,2416,'ceaseless_surge',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3407,2417,'torrential_pain',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3408,2418,'eternal_misery',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3409,2419,'crippling_agony',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3410,2420,'bane_of_tartarus',@AOE,0.0,18.0,2000,1000,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3411,434,'',@SINGLE,0.0,7.0,2000,0,@SELF,@ASTRAL_FLOW,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3412,683,'freezebite',@SINGLE,0.0,7.0,2000,0,@SELF,@ASTRAL_FLOW,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3413,728,'combo',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,8,0,0);
INSERT INTO `mob_skills` VALUES (3414,730,'one-ilm_punch',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,2,0,0);
INSERT INTO `mob_skills` VALUES (3415,733,'howling_fist',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,1,8,0);
INSERT INTO `mob_skills` VALUES (3416,734,'dragon_kick',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,12,0,0);
INSERT INTO `mob_skills` VALUES (3417,735,'asuran_fists',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,9,3,0);
INSERT INTO `mob_skills` VALUES (3418,1037,'amatsu_torimai',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3419,1038,'amatsu_kazakiri',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3420,1039,'amatsu_yukiarashi',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3421,1040,'amatsu_tsukioboro',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3422,1041,'amatsu_hanaikusa',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3423,1506,'wasp_sting',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3424,1507,'dancing_edge',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3425,3169,'flat_blade',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,8,0,0);
-- INSERT INTO `mob_skills` VALUES (3426,3170,'stink_bomb',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3427,3171,'nectarous_deluge',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3428,3172,'nepenthic_plunge',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3429,3173,'guiding_light',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3430,3174,'upgrowth',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3431,379,'fast_blade',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3432,380,'savage_blade',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,12,4,0);
-- INSERT INTO `mob_skills` VALUES (3433,3177,'sheep_song',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3434,385,'tachi_kamai',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3435,386,'iainuki',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3436,383,'tachi_goten',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3437,384,'tachi_kasha',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,11,2,0);
INSERT INTO `mob_skills` VALUES (3438,2430,'dragon_breath',@AOETARGET,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,13,11,0);
INSERT INTO `mob_skills` VALUES (3439,2429,'hurricane_wing',@AOE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,4,6,0);
INSERT INTO `mob_skills` VALUES (3440,2317,'pocket_sand',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3441,2316,'tripe_gripe',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3442,2319,'sharp_eye',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3443,3187,'gloeosuccus',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3444,3188,'afflatus_misery',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3445,3189,'merciless_strike',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3446,3190,'villainous_rebuke',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3447,3191,'stygian_release',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3448,3192,'uppercut',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3449,3193,'infernal_bulwark',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3450,3194,'earthbreaker',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3451,184,'dynastic_gravitas',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0); -- Arciela
INSERT INTO `mob_skills` VALUES (3452,304,'illustrious_aid',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3453,304,'guiding_light',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3454,420,'coming_up_roses',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3455,199,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3456,200,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3457,201,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3458,202,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3459,203,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3460,204,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3461,3205,'bloody_breath',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3462,3206,'excessively_bad_breath',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3463,3207,'#1671',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3464,3208,'#1672',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3465,3209,'#1673',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3466,2472,'paralyzing_microtube',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,7,5,0); -- Adelheid
INSERT INTO `mob_skills` VALUES (3467,2473,'silencing_microtube',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,3,6,0);
INSERT INTO `mob_skills` VALUES (3468,2474,'binding_microtube',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,9,7,0);
INSERT INTO `mob_skills` VALUES (3469,2475,'twirling_dervish',@AOE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,13,11,0);
INSERT INTO `mob_skills` VALUES (3470,2493,'great_wheel',@AOE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,1,12,4,0); -- Mildaurion
INSERT INTO `mob_skills` VALUES (3471,2495,'light_blade',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,13,11,0);
INSERT INTO `mob_skills` VALUES (3472,2492,'vortex',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,10,5,0);
INSERT INTO `mob_skills` VALUES (3473,2494,'stellar_burst',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,14,9,0);
-- INSERT INTO `mob_skills` VALUES (3474,187,'bubble_curtain',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3475,192,'metallic_body',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3476,3220,'venom_storm',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3477,3221,'venom_sting',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3478,3222,'venom_breath',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3479,432,'elemental_sforzo',@SINGLE,0.0,7.0,2000,0,@SELF,@ASTRAL_FLOW,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3480,3224,'mikage',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3481,3225,'azure_lore',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3482,3226,'bolster',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3483,189,'scissor_guard',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3484,3228,'hemorrhaze',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3485,3229,'regulator',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NO_TP_COST,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3486,260,'tongue_lash',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3487,2477,'sidewinder',@SINGLE,0.0,16.0,2000,1500,@ENEMY,@NONE,0,0,5,1,6); -- Semih Lafihna
INSERT INTO `mob_skills` VALUES (3488,2476,'arching_arrow',@SINGLE,0.0,16.0,2000,1500,@ENEMY,@NONE,0,0,11,0,0);
INSERT INTO `mob_skills` VALUES (3489,2478,'stellar_arrow',@AOE,0.0,16.0,2000,1500,@ENEMY,@NONE,0,0,14,9,0);
INSERT INTO `mob_skills` VALUES (3490,2479,'lux_arrow',@SINGLE,0.0,16.0,2000,1500,@ENEMY,@NONE,0,0,12,10,0);
INSERT INTO `mob_skills` VALUES (3491,2029,'grapeshot',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,3,2,0);
INSERT INTO `mob_skills` VALUES (3492,2030,'pirate_pummel',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,9,0,0);
INSERT INTO `mob_skills` VALUES (3493,2031,'powder_keg',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,5,1,0);
INSERT INTO `mob_skills` VALUES (3494,2032,'walk_the_plank',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,2,0,11,0,0);
INSERT INTO `mob_skills` VALUES (3495,684,'ground_strike',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3496,2505,'hollow_smite',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,13,12,0);
-- INSERT INTO `mob_skills` VALUES (3497,3241,'sarva's_storm',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3498,3242,'sarva's_storm',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3499,3243,'soturi's_fury',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3500,3244,'celidon's_torment',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3501,3245,'tachi_mudo',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3502,89,'nott',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3503,3247,'justicebreaker',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3504,3248,'rancid_breath',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3505,3249,'geotic_spin',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3506,3250,'hellfire_arrow',@CONE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,1,0,0,0);
INSERT INTO `mob_skills` VALUES (3507,3251,'incensed_pummel',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3508,3252,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3509,3253,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3510,3254,'.',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3511,451,'lunatic_voice',@CONE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3512,452,'sonic_buffet',@AOE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3513,453,'entice',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3514,455,'hysteric_assault',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3515,454,'clarsach_call',@AOE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3516,461,'infected_leech',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3517,462,'gloom_spray',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3518,3262,'bloody_mist',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3519,3263,'tendril_curse',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3520,3264,'frigid_pulse',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3521,3265,'gates_of_hades',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3522,3266,'magma_hoplon',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3523,3267,'bad_breath',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3524,2256,'meteor',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3525,2256,'meteor',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3526,3270,'thunderbolt',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3527,3271,'#1735',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3528,3272,'#1736',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3529,3273,'#1737',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3530,3274,'beastruction',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3531,63,'bad_breath',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3532,3276,'wings_of_agony',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3533,3277,'wings_of_woe',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3534,3278,'#1742',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3535,3279,'#1743',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3536,3280,'#1744',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3537,3281,'#1745',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3538,474,'null_blast',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3539,1093,'hysteroanima',@SINGLE,0.0,7.0,2000,0,@SELF,@NO_TP_COST,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3540,1094,'psychoanima',@SINGLE,0.0,7.0,2000,0,@SELF,@NO_TP_COST,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3541,2528,'salaheem_spirit',@AOE,0.0,15.0,2000,1500,@SELF,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3542,1042,'oisoya',@SINGLE,0.0,15.0,2000,1500,@ENEMY,@NONE,0,0,13,10,0); -- Light/Distortion. Todo: verify Animation ID, this is copied from BCNM Tenzen.
INSERT INTO `mob_skills` VALUES (3543,2033,'knuckle_sandwich',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3544,1713,'whirling_edge',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3545,3289,'#1753',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3546,3290,'#1754',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3547,203,'hard_membrane',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3548,205,'regeneration',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3549,3293,'#1757',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3550,465,'sand_veil',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3551,3295,'#1759',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3552,3296,'#1760',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3553,3297,'#1761',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3554,3298,'#1762',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3555,3299,'#1763',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3556,488,'amatsu_fuga',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3557,492,'amatsu_kyori',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3558,489,'amatsu_hanadoki',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3559,490,'amatsu_choun',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3560,491,'amatsu_gachirin',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3561,3305,'#1769',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3562,3306,'#1770',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3563,3307,'#1771',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3564,468,'aetheric_pull',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3565,469,'necrotic_wave',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3566,475,'shearing_gale',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3567,476,'beclouding_dust',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3568,3312,'#1776',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3569,3313,'#1777',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3570,3314,'#1778',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3571,3315,'#1779',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3572,3316,'#1780',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3573,3317,'#1781',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3574,3318,'#1782',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3575,3319,'#1783',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3576,3320,'#1784',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3577,3321,'#1785',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3578,3322,'#1786',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3579,3323,'#1787',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3580,3324,'#1788',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3581,3325,'#1789',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3582,3326,'#1790',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3583,3327,'#1791',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3584,3328,'#1792',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3585,3329,'#1793',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3586,3330,'#1794',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3587,3331,'#1795',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3588,3332,'#1796',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3589,3333,'#1797',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3590,3334,'#1798',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3591,3335,'#1799',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3592,3336,'#1800',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3593,3337,'#1801',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3594,3338,'#1802',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3595,3339,'#1803',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3596,3340,'#1804',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3597,3341,'#1805',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3598,3342,'#1806',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3599,3343,'#1807',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3600,3344,'#1808',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3601,3345,'#1809',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3602,3346,'#1810',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3603,3347,'#1811',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3604,3348,'#1812',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3605,3349,'#1813',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3606,3350,'#1814',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3607,3351,'#1815',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3608,3352,'#1816',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3609,3353,'#1817',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3610,3354,'#1818',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3611,3355,'#1819',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3612,3356,'#1820',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3613,295,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3614,296,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3615,297,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3616,298,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3617,2347,'feast_of_arrows',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);    -- Capture shows 299. Adding 2048 for it to work properly.
INSERT INTO `mob_skills` VALUES (3618,2349,'regurgitated_swarm',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0); -- Capture shows 301. Adding 2048 for it to work properly.
INSERT INTO `mob_skills` VALUES (3619,2350,'setting_the_stage',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);  -- Capture shows 302. Adding 2048 for it to work properly.
INSERT INTO `mob_skills` VALUES (3620,2351,'last_laugh',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);         -- Capture shows 303. Adding 2048 for it to work properly.
INSERT INTO `mob_skills` VALUES (3621,2531,'luminous_lance',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);     -- Capture shows 483. Adding 2048 for it to work properly.
INSERT INTO `mob_skills` VALUES (3622,2529,'rejuvenation',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);       -- Capture shows 481. Adding 2048 for it to work properly.
INSERT INTO `mob_skills` VALUES (3623,2530,'revelation',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);         -- Capture shows 482. Adding 2048 for it to work properly.
INSERT INTO `mob_skills` VALUES (3624,900,'memento_mori',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3625,901,'silence_seal',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3626,902,'envoutement',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3627,903,'bored_to_tears',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3628,339,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3629,340,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3630,341,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3631,342,'start_from_scratch',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3632,343,'frenzied_thrust',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3633,2392,'sinners_cross',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0); -- Capture shows 344. Adding 2048 for it to work properly.
INSERT INTO `mob_skills` VALUES (3634,345,'open_coffin',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3635,346,'ravenous_assault',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3636,347,'hemocladis',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3637,2037,'shining_summer_samba',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3638,3382,'#1846',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3639,2039,'neo_crystal_jig',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3640,3384,'#1848',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3641,3385,'#1849',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3642,3386,'#1850',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3643,3387,'#1851',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3644,266,'ruthlessness',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0); -- Ingrid
INSERT INTO `mob_skills` VALUES (3645,268,'inexorable_strike',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3646,267,'self-aggrandizement',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3647,82,'merciless_strike',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- Trust: August
INSERT INTO `mob_skills` VALUES (3648,2457,'august_melee_sword',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NO_TP_COST,0,0,0,0,0); -- Capture shows 409. Adding 2048 for it to work properly.
INSERT INTO `mob_skills` VALUES (3649,2458,'august_melee_axe',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NO_TP_COST,0,0,0,0,0);   -- Capture shows 410. Adding 2048 for it to work properly.
INSERT INTO `mob_skills` VALUES (3650,2459,'august_melee_h2h',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NO_TP_COST,0,0,0,0,0);   -- Capture shows 411. Adding 2048 for it to work properly.
INSERT INTO `mob_skills` VALUES (3651,2460,'august_melee_bow',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NO_TP_COST,0,0,0,0,0);   -- Capture shows 412. Adding 2048 for it to work properly.
INSERT INTO `mob_skills` VALUES (3652,413,'daybreak',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3653,414,'tartaric_sigil',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3654,415,'null_field"',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3655,416,'alabaster_burst',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3656,417,'noble_frenzy',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3657,418,'fulminous_fury',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3658,419,'no_quarter"',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3659,387,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3660,388,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3661,389,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3662,390,'baneful_blades',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0); -- Rosulatia
INSERT INTO `mob_skills` VALUES (3663,391,'wildwood_indignation',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3664,392,'dryads_kiss',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3665,394,'sepraved_dandia',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3666,395,'matriarchal_fiat',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3667,3411,'#1875',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3668,3412,'#1876',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3669,3413,'#1877',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3670,3414,'#1878',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3671,2005,'deep_sea_dirge',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3672,3416,'#1880',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3673,284,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3674,285,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3675,286,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3676,287,'vehement_resolution',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3677,288,'camaraderie_of_the_crevasse',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3678,289,'into_the_light',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3679,290,'arduous_decision',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3680,291,'12_blades_of_remorse',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3681,272,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3682,273,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3683,274,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3684,2323,'aurous_charge',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);  -- Capture shows 275. Adding 2048 for it to work properly.
INSERT INTO `mob_skills` VALUES (3685,2324,'howling_gust',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);   -- Capture shows 276. Adding 2048 for it to work properly.
INSERT INTO `mob_skills` VALUES (3686,2325,'righteous_rasp',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0); -- Capture shows 277. Adding 2048 for it to work properly.
INSERT INTO `mob_skills` VALUES (3687,2326,'starward_yowl',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);  -- Capture shows 278. Adding 2048 for it to work properly.
INSERT INTO `mob_skills` VALUES (3688,2327,'stalking_prey',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);  -- Capture shows 279. Adding 2048 for it to work properly.
INSERT INTO `mob_skills` VALUES (3689,344,'shuffle',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3690,345,'double_down',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3691,427,'bludgeon',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3692,428,'deal_out',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3693,396,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3694,397,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3695,398,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3696,399,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3697,400,'ascension',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3698,401,'descension',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3699,402,'expunge_magic',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3700,403,'harmonic_displacement',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3701,404,'sight_unseen',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3702,405,'darkest_hour',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3703,406,'unceasing_dread',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3704,407,'dignified_awe',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3705,408,'naakuals_vengeance',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- Trust: AAHM
INSERT INTO `mob_skills` VALUES (3706,633,'cross_reaver',@CONE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3707,3451,'#1915',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3708,641,'swift_blade',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,9,0,0);
INSERT INTO `mob_skills` VALUES (3709,2283,'chant_du_cygne',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,13,10,0); -- Capture shows 235. Adding 2048 for it to work properly.
-- Trust: AAEV
INSERT INTO `mob_skills` VALUES (3710,2285,'arrogance_incarnate',@AOE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0); -- Capture shows 237. Adding 2048 for it to work properly.
INSERT INTO `mob_skills` VALUES (3711,643,'vorpal_blade',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,4,8,0);
INSERT INTO `mob_skills` VALUES (3712,635,'dominion_slash',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3713,2284,'chant_du_cygne',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,13,10,0); -- Capture shows 236. Adding 2048 for it to work properly.
INSERT INTO `mob_skills` VALUES (3714,638,'shield_strike',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3715,644,'rampage',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,4,0,0);              -- AAMR
INSERT INTO `mob_skills` VALUES (3716,3460,'calamity',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,4,8,0);            -- AAMR
INSERT INTO `mob_skills` VALUES (3717,634,'havoc_spiral',@AOE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);         -- AAMR
INSERT INTO `mob_skills` VALUES (3718,2282,'cloudsplitter',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,14,12,0);     -- AAMR
-- INSERT INTO `mob_skills` VALUES (3719,3463,'#1927',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3720,636,'amon_drive',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);           -- AATT
INSERT INTO `mob_skills` VALUES (3721,647,'guillotine',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,7,0,0);           -- AATT
-- Trust: AAGK
INSERT INTO `mob_skills` VALUES (3722,648,'tachi_yukikaze',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,7,6,0);
INSERT INTO `mob_skills` VALUES (3723,649,'tachi_gekko',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,10,5,0);
INSERT INTO `mob_skills` VALUES (3724,637,'dragonfall',@AOE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3725,650,'tachi_kasha',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,11,2,0);
INSERT INTO `mob_skills` VALUES (3726,2281,'tachi_fudo',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,13,10,0); -- Capture shows 233. Adding 2048 for it to work properly.
-- INSERT INTO `mob_skills` VALUES (3727,3471,'#1935',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3728,3472,'#1936',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3729,3473,'#1937',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3730,3474,'#1938',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3731,3475,'#1939',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3732,488,'amatsu_fuga',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3733,492,'amatsu_kyori',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3734,489,'amatsu_hanadoki',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3735,490,'amatsu_choun',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3736,491,'amatsu_gachirin',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3737,493,'amatsu_suien',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3738,516,'rise_from_ashes',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- Trust: Shantotto II
INSERT INTO `mob_skills` VALUES (3739,2546,'shantotto_ii_melee',@SINGLE,0.0,7.0,2000,0,@ENEMY,@NO_TP_COST,0,0,0,0,0);     -- Capture shows 498. Adding 2048 for it to work properly.
INSERT INTO `mob_skills` VALUES (3740,2547,'final_exam',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,13,11,0);        -- Capture shows 499. Adding 2048 for it to work properly.
INSERT INTO `mob_skills` VALUES (3741,2548,'doctors_orders',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,14,9,0);     -- Capture shows 500. Adding 2048 for it to work properly.
INSERT INTO `mob_skills` VALUES (3742,2549,'empirical_research',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,12,1,0); -- Capture shows 501. Adding 2048 for it to work properly.
INSERT INTO `mob_skills` VALUES (3743,2550,'lesson_in_pain',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,10,4,0);     -- Capture shows 502. Adding 2048 for it to work properly.
-- INSERT INTO `mob_skills` VALUES (3744,503,'peccant_typhoon',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3745,504,'censure',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3746,505,'osmotic_wave',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3747,506,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3748,507,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3749,508,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3750,509,'shearing_undulation',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3751,510,'celling_rupture',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3752,511,'destitution',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3753,512,'essence_devour',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3754,513,'primordial_surge',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3755,514,'waning_vigor',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3756,515,'expunge',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3757,3501,'#1965',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3758,3502,'#1966',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3759,3503,'#1967',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3760,3504,'#1968',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3761,3505,'#1969',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3762,3506,'#1970',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3763,3507,'#1971',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3764,3508,'#1972',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3765,3509,'#1973',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3766,3510,'#1974',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3767,3511,'#1975',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3768,3512,'#1976',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3769,3513,'#1977',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3770,3514,'#1978',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3771,3515,'#1979',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3772,3516,'#1980',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3773,3517,'#1981',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3774,3518,'#1982',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3775,3519,'#1983',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3776,3520,'#1984',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3777,3521,'#1985',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3778,3522,'#1986',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3779,3523,'#1987',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3780,3524,'#1988',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3781,3525,'#1989',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3782,3526,'#1990',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3783,3527,'#1991',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3784,3528,'#1992',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3785,3529,'#1993',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3786,3530,'#1994',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3787,3531,'#1995',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3788,3532,'#1996',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3789,438,'charm',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3790,3534,'#1998',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3791,3535,'#1999',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3792,3536,'#2000',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3793,3537,'#2001',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3794,3538,'#2002',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3795,3539,'#2003',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3796,3540,'#2004',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3797,3541,'#2005',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3798,63,'bad_breath',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3799,64,'sweet_breath',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3800,3544,'#2008',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3801,3545,'#2009',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3802,3546,'#2010',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3803,3547,'#2011',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3804,3548,'#2012',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3805,3549,'#2013',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3806,3550,'#2014',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3807,3551,'#2015',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3808,3552,'#2016',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3809,3553,'#2017',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3810,3554,'#2018',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3811,3555,'#2019',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3812,115,'sacred_caper',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3813,116,'phototrophic_blessing',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0); -- Ygnas
INSERT INTO `mob_skills` VALUES (3814,117,'phototrophic_wrath',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3815,118,'deific_gambol',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3816,3560,'#2024',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3817,3561,'#2025',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3818,3562,'#2026',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3819,3563,'#2027',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3820,3564,'#2028',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3821,3565,'#2029',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3822,3566,'#2030',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3823,3567,'#2031',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3824,3568,'#2032',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3825,3569,'#2033',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3826,3570,'#2034',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3827,3571,'#2035',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3828,3572,'#2036',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3829,3573,'#2037',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3830,3574,'#2038',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3831,3575,'#2039',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3832,3576,'#2040',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3833,3577,'#2041',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3834,3578,'#2042',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3835,3579,'#2043',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3836,3580,'#2044',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3837,3581,'#2045',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3838,3582,'#2046',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3839,3583,'#2047',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3840,3584,'foot_kick',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3841,3585,'dust_cloud',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3842,3586,'whirl_claws',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3843,3587,'head_butt',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3844,3588,'dream_flower',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3845,3589,'wild_oats',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3846,3590,'leaf_dagger',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3847,3591,'scream',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3848,3592,'roar',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3849,15,'razor_fang',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3850,3594,'claw_cyclone',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3851,3595,'tail_blow',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3852,3596,'fireball',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3853,3597,'blockhead',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3854,3598,'brain_crush',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3855,3599,'infrasonics',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3856,3600,'secretion',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3857,4,'lamb_chop',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3858,5,'rage',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3859,6,'sheep_charge',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3860,3604,'sheep_song',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3861,3605,'bubble_shower',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3862,3606,'bubble_curtain',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3863,3607,'big_scissors',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3864,3608,'scissor_guard',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3865,3609,'metallic_body',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3866,3610,'needleshot',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3867,3611,'random_needles',@AOE,0.0,10.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0); -- ???_needles.lua isn't a valid filename
-- INSERT INTO `mob_skills` VALUES (3868,3612,'frogkick',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3869,3613,'spore',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3870,3614,'queasyshroom',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3871,3615,'numbshroom',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3872,3616,'shakeshroom',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3873,3617,'silence_gas',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3874,3618,'dark_spore',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3875,3619,'power_attack',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3876,3620,'hi-freq_field',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3877,3621,'rhino_attack',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3878,3622,'rhino_guard',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3879,3623,'spoil',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3880,3624,'cursed_sphere',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3881,3625,'venom',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3882,3626,'sandblast',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3883,3627,'sandpit',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3884,3628,'venom_spray',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3885,3629,'mandibular_bite',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3886,3630,'soporific',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3887,3631,'gloeosuccus',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3888,3632,'palsy_pollen',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3889,3633,'geist_wall',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3890,3634,'numbing_noise',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3891,3635,'nimble_snap',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3892,3636,'cyclotail',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3893,3637,'toxic_spit',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3894,3638,'double_claw',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3895,3639,'grapple',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3896,3640,'filamented_hold',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3897,3641,'spinning_top',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3898,3642,'chaotic_eye',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3899,3643,'blaster',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3900,3644,'suction',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3901,3645,'drainkiss',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3902,3646,'snow_cloud',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3903,3647,'wild_carrot',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3904,3648,'sudden_lunge',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3905,3649,'spiral_spin',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3906,3650,'noisome_powder',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3907,3651,'acid_mist',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3908,3652,'tp_drainkiss',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3909,3653,'scythe_tail',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3910,3654,'ripper_fang',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3911,123,'chomp_rush',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3912,3656,'charged_whisker',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3913,3657,'purulent_ooze',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3914,1574,'corrosive_ooze',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3915,3659,'back_heel',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3916,3660,'jettatura',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3917,3661,'choke_breath',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3918,3662,'fantod',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3919,3663,'tortoise_stomp',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3920,3664,'harden_shell',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3921,3665,'aqua_breath',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3922,3666,'wing_slap',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3923,3667,'beak_lunge',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3924,3668,'intimidate',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3925,3669,'recoil_dive',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3926,3670,'water_wall',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3927,120,'sensilla_blades',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3928,121,'tegmina_buffet',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3929,3673,'molting_plumage',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3930,3674,'swooping_frenzy',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3931,3675,'sweeping_gouge',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3932,3676,'zealous_snort',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3933,3677,'pentapeck',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3934,3678,'tickling_tendrils',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3935,3679,'stink_bomb',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3936,3680,'nectarous_deluge',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3937,3681,'nepenthic_plunge',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3938,3682,'somersault',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3939,3683,'foul_waters',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3940,3684,'pestilent_plume',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3941,3685,'pecking_flurry',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3942,3686,'sickle_slash',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3943,3687,'acid_spray',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3944,3688,'spider_web',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3945,3689,'#2153',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3946,3690,'#2154',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3947,3691,'#2155',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3948,3692,'#2156',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3949,3693,'#2157',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3950,3694,'#2158',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3951,3695,'#2159',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3952,3696,'#2160',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3953,3697,'#2161',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3954,3698,'#2162',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3955,3699,'#2163',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3956,3700,'#2164',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3957,3701,'#2165',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3958,3702,'#2166',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3959,3703,'#2167',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3960,3704,'#2168',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3961,3705,'#2169',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3962,3706,'#2170',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3963,3707,'#2171',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3964,3708,'#2172',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3965,3709,'#2173',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3966,3710,'#2174',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3967,3711,'#2175',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3968,34,'fire_meeble_warble',@AOE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3969,34,'blizzard_meeble_warble',@AOE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3970,34,'thunder_meeble_warble',@AOE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3971,34,'stone_meeble_warble',@AOE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3972,34,'water_meeble_warble',@AOE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3973,34,'aero_meeble_warble',@AOE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3974,35,'thrashing_assault',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (3975,36,'drill_claw',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3976,1156,'groundburst',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3977,462,'shoulder_slam',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3978,463,'magnetite_cloud',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3979,464,'sandstorm',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3980,465,'sand_veil',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3981,466,'sand_shield',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3982,468,'jamming_wave',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3983,1268,'warm-up',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3984,1270,'groundburst',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3985,335,'dirty_bomb',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3986,3730,'#2194',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3987,335,'goblin_bomb',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3988,3732,'#2196',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3989,1438,'clobber',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3990,1439,'granite_skin',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3991,1433,'blazing_angon',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3992,3736,'#2200',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3993,441,'sucker_punch',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3994,3738,'#2202',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3995,3739,'#2203',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3996,3740,'#2204',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3997,3741,'#2205',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3998,3742,'#2206',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (3999,3743,'#2207',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4000,3744,'#2208',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4001,3745,'#2209',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4002,3746,'#2210',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4003,3747,'#2211',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4004,3748,'#2212',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4005,3749,'#2213',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4006,3750,'#2214',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4007,3751,'#2215',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4008,3752,'#2216',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4009,3753,'#2217',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4010,3754,'#2218',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4011,3755,'#2219',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4012,3756,'#2220',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4013,3757,'#2221',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4014,3758,'#2222',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4015,3759,'#2223',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4016,3760,'#2224',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4017,3761,'#2225',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4018,3762,'#2226',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4019,3763,'#2227',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4020,3764,'#2228',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4021,3765,'#2229',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4022,3766,'#2230',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4023,3767,'#2231',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4024,3768,'#2232',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4025,3769,'#2233',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4026,3770,'#2234',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4027,3771,'#2235',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4028,3772,'#2236',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4029,3773,'#2237',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4030,3774,'#2238',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4031,3775,'#2239',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4032,72,'drill_branch',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4033,73,'pinecone_bomb',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4034,727,'pollenstorm',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4035,76,'chelate',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4036,2002,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4037,2003,'',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4038,2004,'echolocation',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4039,2005,'deep_sea_dirge',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4040,2006,'caudal_capacitor',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4041,203,'hard_membrane',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4042,2008,'depth_charge',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4043,2009,'blowhole_blast',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4044,3788,'#2252',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4045,3789,'#2253',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4046,3790,'#2254',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4047,3791,'#2255',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4048,3792,'#2256',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4049,3793,'#2257',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4050,3794,'hypnosis',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0); -- Capture shows 294. Adding 2048 for it to work properly.
-- INSERT INTO `mob_skills` VALUES (4051,3795,'#2259',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4052,3796,'#2260',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4053,3797,'#2261',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4054,3798,'#2262',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4055,3799,'magic_barrier',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0); -- Capture shows 299. Adding 2048 for it to work properly.
-- INSERT INTO `mob_skills` VALUES (4056,3800,'#2264',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4057,3801,'#2265',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4058,3802,'#2266',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4059,3803,'#2267',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4060,3804,'#2268',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4061,3805,'#2269',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4062,3806,'#2270',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4063,3807,'#2271',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4064,3808,'#2272',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4065,3809,'#2273',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4066,3810,'#2274',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4067,3811,'#2275',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4068,3812,'#2276',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4069,3813,'#2277',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4070,3814,'#2278',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4071,3815,'#2279',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4072,3816,'#2280',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4073,3817,'#2281',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4074,3818,'#2282',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4075,3819,'#2283',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4076,3820,'#2284',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4077,3821,'#2285',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4078,3822,'#2286',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4079,3823,'#2287',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
-- INSERT INTO `mob_skills` VALUES (4080,3824,'#2288',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);

-- INSERT INTO `mob_skills` VALUES (4124,335,'bomb_toss',@SINGLE,0.0,14.0,2000,1000,(@SELF | @PARTY),@NO_TP_COST,0,0,0,0,0); -- ?
-- INSERT INTO `mob_skills` VALUES (4125,743,'frypan',@SINGLE,0.0,14.0,2000,1000,(@SELF | @PARTY),@NO_TP_COST,0,0,0,0,0); -- ?
-- INSERT INTO `mob_skills` VALUES (4126,438,'charm',@SINGLE,0.0,14.0,2000,1000,(@SELF | @PARTY),@NO_TP_COST,0,0,0,0,0); -- ?

-- INSERT INTO `mob_skills` VALUES (4167,1798,'ka-thwack',@SINGLE,0.0,14.0,2000,1000,(@SELF | @PARTY),@NO_TP_COST,0,0,0,0,0); -- ?

-- INSERT INTO `mob_skills` VALUES (4170,1441,'ofnir',@SINGLE,0.0,14.0,2000,1000,(@SELF | @PARTY),@NO_TP_COST,0,0,0,0,0); -- ?
-- INSERT INTO `mob_skills` VALUES (4171,1446,'valfodr',@SINGLE,0.0,14.0,2000,1000,(@SELF | @PARTY),@NO_TP_COST,0,0,0,0,0); -- ?
-- INSERT INTO `mob_skills` VALUES (4172,1444,'yggr',@SINGLE,0.0,14.0,2000,1000,(@SELF | @PARTY),@NO_TP_COST,0,0,0,0,0); -- ?
-- INSERT INTO `mob_skills` VALUES (4173,1445,'sanngetall',@SINGLE,0.0,14.0,2000,1000,(@SELF | @PARTY),@NO_TP_COST,0,0,0,0,0); -- ?
-- INSERT INTO `mob_skills` VALUES (4174,1443,'geirrothr',@SINGLE,0.0,14.0,2000,1000,(@SELF | @PARTY),@NO_TP_COST,0,0,0,0,0); -- ?
-- INSERT INTO `mob_skills` VALUES (4175,1447,'zantetsuken_x',@SINGLE,0.0,14.0,2000,1000,(@SELF | @PARTY),@NO_TP_COST,0,0,0,0,0); -- ?

-- INSERT INTO `mob_skills` VALUES (4182,1466,'gospel_of_the_lost',@SINGLE,0.0,14.0,2000,1000,(@SELF | @PARTY),@NO_TP_COST,0,0,0,0,0); -- ?
-- INSERT INTO `mob_skills` VALUES (4183,1469,'void_of_repentance',@SINGLE,0.0,14.0,2000,1000,(@SELF | @PARTY),@NO_TP_COST,0,0,0,0,0); -- ?
-- INSERT INTO `mob_skills` VALUES (4184,1470,'divine_spear',@SINGLE,0.0,14.0,2000,1000,(@SELF | @PARTY),@NO_TP_COST,0,0,0,0,0); -- ?
-- INSERT INTO `mob_skills` VALUES (4185,1471,'mega_holy',@SINGLE,0.0,14.0,2000,1000,(@SELF | @PARTY),@NO_TP_COST,0,0,0,0,0); -- ?
-- INSERT INTO `mob_skills` VALUES (4186,1465,'radiant_sacrament',@SINGLE,0.0,14.0,2000,1000,(@SELF | @PARTY),@NO_TP_COST,0,0,0,0,0); -- ?
-- INSERT INTO `mob_skills` VALUES (4187,1468,'divine_judgement',@SINGLE,0.0,14.0,2000,1000,(@SELF | @PARTY),@NO_TP_COST,0,0,0,0,0); -- ?

-- INSERT INTO `mob_skills` VALUES (4218,655,'fiery_breath',@SINGLE,0.0,14.0,2000,1000,(@SELF | @PARTY),@NO_TP_COST,0,0,0,0,0); -- ?
-- INSERT INTO `mob_skills` VALUES (4219,962,'glacial_breath',@SINGLE,0.0,14.0,2000,1000,(@SELF | @PARTY),@NO_TP_COST,0,0,0,0,0); -- ?
-- INSERT INTO `mob_skills` VALUES (4220,968,'sable_breath',@SINGLE,0.0,14.0,2000,1000,(@SELF | @PARTY),@NO_TP_COST,0,0,0,0,0); -- ?

-- Trust: Monberaux
INSERT INTO `mob_skills` VALUES (4231,2613,'mix_final_elixir',@SINGLE,0.0,14.0,2000,1000,(@SELF | @PARTY),@NO_TP_COST,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (4232,2597,'potion',@SINGLE,0.0,14.0,2000,1000,(@SELF | @PARTY),@NO_TP_COST,0,0,0,0,0);          -- Capture shows 549. Adding 2048 for it to work properly.
INSERT INTO `mob_skills` VALUES (4233,2597,'hi_potion',@SINGLE,0.0,14.0,2000,1000,(@SELF | @PARTY),@NO_TP_COST,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (4234,2598,'x-potion',@SINGLE,0.0,14.0,2000,1000,(@SELF | @PARTY),@NO_TP_COST,0,0,0,0,0);        -- Capture shows 550. Adding 2048 for it to work properly.
INSERT INTO `mob_skills` VALUES (4235,2598,'hyper-potion',@SINGLE,0.0,14.0,2000,1000,(@SELF | @PARTY),@NO_TP_COST,0,0,0,0,0);    -- Capture shows 550. Adding 2048 for it to work properly.
INSERT INTO `mob_skills` VALUES (4236,2598,'max_potion',@SINGLE,0.0,14.0,2000,1000,(@SELF | @PARTY),@NO_TP_COST,0,0,0,0,0);      -- Capture shows 550. Adding 2048 for it to work properly.
INSERT INTO `mob_skills` VALUES (4237,2598,'mix_max_potion',@SINGLE,0.0,14.0,2000,1000,(@SELF | @PARTY),@NO_TP_COST,0,0,0,0,0);  -- Capture shows 550. Adding 2048 for it to work properly.
INSERT INTO `mob_skills` VALUES (4238,2600,'mix_antidote',@AOE,0.0,14.0,2000,1000,(@SELF | @PARTY),@NO_TP_COST,0,0,0,0,0);       -- Capture shows 552. Adding 2048 for it to work properly.
INSERT INTO `mob_skills` VALUES (4239,2601,'mix_para-b-gone',@AOE,0.0,14.0,2000,1000,(@SELF | @PARTY),@NO_TP_COST,0,0,0,0,0);    -- Capture shows 553. Adding 2048 for it to work properly.
INSERT INTO `mob_skills` VALUES (4240,2602,'mix_eye_drops',@AOE,0.0,14.0,2000,1000,(@SELF | @PARTY),@NO_TP_COST,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (4241,2603,'mix_echo_drops',@AOE,0.0,14.0,2000,1000,(@SELF | @PARTY),@NO_TP_COST,0,0,0,0,0);     -- Capture shows 555. Adding 2048 for it to work properly.
INSERT INTO `mob_skills` VALUES (4242,2604,'mix_holy_water',@AOE,0.0,14.0,2000,1000,(@SELF | @PARTY),@NO_TP_COST,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (4243,2605,'mix_vaccine',@AOE,0.0,14.0,2000,1000,(@SELF | @PARTY),@NO_TP_COST,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (4244,2606,'mix_gold_needle',@AOE,0.0,14.0,2000,1000,(@SELF | @PARTY),@NO_TP_COST,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (4245,2604,'mix_panacea-1',@AOE,0.0,14.0,2000,1000,(@SELF | @PARTY),@NO_TP_COST,0,0,0,0,0);      -- Capture shows 556. Adding 2048 for it to work properly.
INSERT INTO `mob_skills` VALUES (4246,2600,'mix_antidote',@SINGLE,0.0,14.0,2000,1000,(@SELF | @PARTY),@NO_TP_COST,0,0,0,0,0);    -- Capture shows 552. Adding 2048 for it to work properly.
INSERT INTO `mob_skills` VALUES (4247,2601,'mix_para-b-gone',@SINGLE,0.0,14.0,2000,1000,(@SELF | @PARTY),@NO_TP_COST,0,0,0,0,0); -- Capture shows 553. Adding 2048 for it to work properly.
INSERT INTO `mob_skills` VALUES (4248,2602,'mix_eye_drops',@SINGLE,0.0,14.0,2000,1000,(@SELF | @PARTY),@NO_TP_COST,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (4249,2603,'mix_echo_drops',@SINGLE,0.0,14.0,2000,1000,(@SELF | @PARTY),@NO_TP_COST,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (4250,2604,'mix_holy_water',@SINGLE,0.0,14.0,2000,1000,(@SELF | @PARTY),@NO_TP_COST,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (4251,2605,'mix_vaccine',@SINGLE,0.0,14.0,2000,1000,(@SELF | @PARTY),@NO_TP_COST,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (4252,2606,'mix_gold_needle',@SINGLE,0.0,14.0,2000,1000,(@SELF | @PARTY),@NO_TP_COST,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (4253,2604,'mix_panacea-1',@SINGLE,0.0,14.0,2000,1000,(@SELF | @PARTY),@NO_TP_COST,0,0,0,0,0); -- Capture shows 556. Adding 2048 for it to work properly.
INSERT INTO `mob_skills` VALUES (4254,2599,'mix_dry_ether_concoction',@SINGLE,0.0,14.0,2000,1000,(@SELF | @PARTY),@NO_TP_COST,0,0,0,0,0);
INSERT INTO `mob_skills` VALUES (4255,2607,'mix_guard_drink',@AOE,0.0,14.0,2000,1000,(@SELF | @PARTY),@NO_TP_COST,0,0,0,0,0);      -- Capture shows 559. Adding 2048 for it to work properly.
INSERT INTO `mob_skills` VALUES (4256,2608,'mix_insomniant',@SINGLE,0.0,14.0,2000,1000,(@SELF | @PARTY),@NO_TP_COST,0,0,0,0,0);    -- Capture shows 560. Adding 2048 for it to work properly.
INSERT INTO `mob_skills` VALUES (4257,2609,'mix_life_water',@AOE,0.0,14.0,2000,1000,(@SELF | @PARTY),@NO_TP_COST,0,0,0,0,0);       -- Capture shows 561. Adding 2048 for it to work properly.
INSERT INTO `mob_skills` VALUES (4258,2610,'mix_elemental_power',@AOE,0.0,14.0,2000,1000,(@SELF | @PARTY),@NO_TP_COST,0,0,0,0,0);  -- Capture shows 562. Adding 2048 for it to work properly.
INSERT INTO `mob_skills` VALUES (4259,2610,'mix_dragon_shield',@AOE,0.0,14.0,2000,1000,(@SELF | @PARTY),@NO_TP_COST,0,0,0,0,0);    -- Capture shows 562. Adding 2048 for it to work properly.
INSERT INTO `mob_skills` VALUES (4260,2611,'mix_dark_potion',@SINGLE,0.0,14.0,2000,1000,@ENEMY,@NO_TP_COST,0,0,0,0,0);             -- Capture shows 563. Adding 2048 for it to work properly.
INSERT INTO `mob_skills` VALUES (4261,2612,'mix_samsons_strength',@AOE,0.0,14.0,2000,1000,(@SELF | @PARTY),@NO_TP_COST,0,0,0,0,0); -- Capture shows 564. Adding 2048 for it to work properly.
-- INSERT INTO `mob_skills` VALUES (4262,2170,'shadow_burst',@SINGLE,0.0,7.0,2000,1500,@ENEMY,@NONE,0,0,0,0,0);
