/*
Navicat MySQL Data Transfer

Source Server         : oo
Source Server Version : 50136
Source Host           : localhost:3306
Source Database       : tpzdb

Target Server Type    : MYSQL
Target Server Version : 50136
File Encoding         : 65001

Date: 2012-07-17 14:50:32
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `char_points`
-- ----------------------------
DROP TABLE IF EXISTS `char_points`;
CREATE TABLE `char_points` (
  `charid` int(10) unsigned NOT NULL,
  `sandoria_cp` int(10) unsigned NOT NULL DEFAULT '0',
  `bastok_cp` int(10) unsigned NOT NULL DEFAULT '0',
  `windurst_cp` int(10) unsigned NOT NULL DEFAULT '0',
  `beastman_seal` int(10) unsigned NOT NULL DEFAULT '0',
  `kindred_seal` smallint(5) unsigned NOT NULL DEFAULT '0',
  `kindred_crest` smallint(5) unsigned NOT NULL DEFAULT '0',
  `high_kindred_crest` smallint(5) unsigned NOT NULL DEFAULT '0',
  `sacred_kindred_crest` smallint(5) unsigned NOT NULL DEFAULT '0',
  `ancient_beastcoin` smallint(5) unsigned NOT NULL DEFAULT '0',
  `valor_point` smallint(5) unsigned NOT NULL DEFAULT '0',
  `scyld` smallint(5) unsigned NOT NULL DEFAULT '0',
  `guild_fishing` int(10) unsigned NOT NULL DEFAULT '0',
  `guild_woodworking` int(10) unsigned NOT NULL DEFAULT '0',
  `guild_smithing` int(10) unsigned NOT NULL DEFAULT '0',
  `guild_goldsmithing` int(10) unsigned NOT NULL DEFAULT '0',
  `guild_weaving` int(10) unsigned NOT NULL DEFAULT '0',
  `guild_leathercraft` int(10) unsigned NOT NULL DEFAULT '0',
  `guild_bonecraft` int(10) unsigned NOT NULL DEFAULT '0',
  `guild_alchemy` int(10) unsigned NOT NULL DEFAULT '0',
  `guild_cooking` int(10) unsigned NOT NULL DEFAULT '0',
  `cinder` int(10) unsigned NOT NULL DEFAULT '0',
  `fire_fewell` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `ice_fewell` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `wind_fewell` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `earth_fewell` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `lightning_fewell` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `water_fewell` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `light_fewell` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `dark_fewell` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `ballista_point` int(10) unsigned NOT NULL DEFAULT '0',
  `fellow_point` int(10) unsigned NOT NULL DEFAULT '0',
  `daily_tally` int(10) signed NOT NULL DEFAULT '-1',
  `chocobuck_sandoria` smallint(4) unsigned NOT NULL DEFAULT '0',
  `chocobuck_bastok` smallint(4) unsigned NOT NULL DEFAULT '0',
  `chocobuck_windurst` smallint(4) unsigned NOT NULL DEFAULT '0',
  `research_mark` int(10) unsigned NOT NULL DEFAULT '0',
  `tunnel_worm` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `morion_worm` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `phantom_worm` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `moblin_marble` int(10) unsigned NOT NULL DEFAULT '0',
  `infamy` smallint(5) unsigned NOT NULL DEFAULT '0',
  `prestige` smallint(5) unsigned NOT NULL DEFAULT '0',
  `legion_point` int(10) unsigned NOT NULL DEFAULT '0',
  `spark_of_eminence` int(10) unsigned NOT NULL DEFAULT '0',
  `shining_star` int(10) unsigned NOT NULL DEFAULT '0',
  `imperial_standing` int(10) unsigned NOT NULL DEFAULT '0',
  `leujaoam_assault_point` int(10) unsigned NOT NULL DEFAULT '0',
  `mamool_assault_point` int(10) unsigned NOT NULL DEFAULT '0',
  `lebros_assault_point` int(10) unsigned NOT NULL DEFAULT '0',
  `periqia_assault_point` int(10) unsigned NOT NULL DEFAULT '0',
  `ilrusi_assault_point` int(10) unsigned NOT NULL DEFAULT '0',
  `nyzul_isle_assault_point` int(10) unsigned NOT NULL DEFAULT '0',
  `zeni_point` int(10) unsigned NOT NULL DEFAULT '0',
  `jetton` int(10) unsigned NOT NULL DEFAULT '0',
  `therion_ichor` int(10) unsigned NOT NULL DEFAULT '0',
  `allied_notes` int(10) unsigned NOT NULL DEFAULT '0',
  `bayld` int(10) unsigned NOT NULL DEFAULT '0',
  `kinetic_unit` smallint(5) unsigned NOT NULL DEFAULT '0',
  `obsidian_fragment` int(10) unsigned NOT NULL DEFAULT '0',
  `lebondopt_wing` smallint(5) unsigned NOT NULL DEFAULT '0',
  `pulchridopt_wing` smallint(5) unsigned NOT NULL DEFAULT '0',
  `mweya_plasm` int(10) unsigned NOT NULL DEFAULT '0',
  `cruor` int(10) unsigned NOT NULL DEFAULT '0',
  `resistance_credit` int(10) unsigned NOT NULL DEFAULT '0',
  `dominion_note` int(10) unsigned NOT NULL DEFAULT '0',
  `fifth_echelon_trophy` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `fourth_echelon_trophy` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `third_echelon_trophy` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `second_echelon_trophy` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `first_echelon_trophy` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `cave_points` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `id_tags` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `op_credits` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `traverser_stones` int(10) unsigned NOT NULL DEFAULT '0',
  `voidstones` int(10) unsigned NOT NULL DEFAULT '0',
  `kupofried_corundums` int(10) unsigned NOT NULL DEFAULT '0',
  `imprimaturs` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `pheromone_sacks` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `fire_crystals` smallint(5) unsigned NOT NULL DEFAULT 0,
  `ice_crystals` smallint(5) unsigned NOT NULL DEFAULT 0,
  `wind_crystals` smallint(5) unsigned NOT NULL DEFAULT 0,
  `earth_crystals` smallint(5) unsigned NOT NULL DEFAULT 0,
  `lightning_crystals` smallint(5) unsigned NOT NULL DEFAULT 0,
  `water_crystals` smallint(5) unsigned NOT NULL DEFAULT 0,
  `light_crystals` smallint(5) unsigned NOT NULL DEFAULT 0,
  `dark_crystals` smallint(5) unsigned NOT NULL DEFAULT 0,

  PRIMARY KEY (`charid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of char_points
-- ----------------------------
