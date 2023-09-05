SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Structure de la table `transport`
--

DROP TABLE IF EXISTS `transport`;
CREATE TABLE IF NOT EXISTS `transport` (
  `id` tinyint(3) unsigned NOT NULL,
  `name` tinytext NOT NULL,
  `transport` int(10) unsigned NOT NULL DEFAULT '0',
  `door` int(10) unsigned NOT NULL DEFAULT '0',
  `dock_x` float(7,3) NOT NULL DEFAULT '0.000',
  `dock_y` float(7,3) NOT NULL DEFAULT '0.000',
  `dock_z` float(7,3) NOT NULL DEFAULT '0.000',
  `dock_rot` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `boundary` smallint(5) unsigned NOT NULL DEFAULT '0',
  `anim_arrive` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `anim_depart` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `time_offset` smallint(5) unsigned NOT NULL DEFAULT '0',
  `time_interval` smallint(5) unsigned NOT NULL DEFAULT '0',
  `time_anim_arrive` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `time_waiting` smallint(5) unsigned NOT NULL DEFAULT '0',
  `time_anim_depart` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `zone` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `anim_path` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- `transport` Table of Contents:
--

-- Airships
INSERT INTO `transport` VALUES(1, 'Kazham-Jeuno_Airship',   17801320, 17801319, -4.000,  -3.497, 32.125,   128, 512, 18, 19, 90,  360, 20, 50, 20, 226, 5); -- 2 hours
INSERT INTO `transport` VALUES(2, 'Jeuno-Kazham_Airship',   17784936, 17784935, -4.000,  10.450, 117.000,  64,  477, 24, 25, 270, 360, 20, 50, 20, 226, 6); -- 2 hours
INSERT INTO `transport` VALUES(3, 'Jeuno-Sandoria_Airship', 17784936, 17784932, -68.000, 10.450, 117.000,  64,  474, 18, 19, 0,   360, 12, 60, 12, 223, 6); -- 2 hours
INSERT INTO `transport` VALUES(4, 'Jeuno-Windurst_Airship', 17784936, 17784934, -6.000,  10.450, -117.000, 192, 476, 22, 23, 90,  360, 12, 60, 12, 225, 6); -- 2 hours
INSERT INTO `transport` VALUES(5, 'Jeuno-Bastok_Airship',   17784936, 17784933, -70.000, 10.450, -117.000, 192, 475, 20, 21, 180, 360, 12, 60, 16, 224, 6); -- 2 hours
INSERT INTO `transport` VALUES(6, 'Sandoria-Jeuno_Airship', 17727598, 17727595, 20.000,  -2.000, 44.000,   64,  369, 18, 19, 180, 360, 12, 60, 16, 223, 2); -- 2 hours
INSERT INTO `transport` VALUES(7, 'Windurst-Jeuno_Airship', 17760420, 17760419, 242.281, -3.522, 61.994,   96,  416, 18, 19, 270, 360, 18, 60, 14, 225, 1); -- 2 hours
INSERT INTO `transport` VALUES(8, 'Bastok-Jeuno_Airship',   17743971, 17743965, -36.458, 6.365,  -77.322,  128, 315, 18, 19, 0,   360, 14, 60, 16, 224, 0); -- 2 hours

-- Selbina - Mhaura
INSERT INTO `transport` VALUES(9,  'Selbina-Mhaura_Boat',         17793088, 17793087, 9.294,  0.000, -69.775, 0, 485, 18, 19, 382, 480, 18, 80, 17, 220, 4); -- 22 hours 40 min
INSERT INTO `transport` VALUES(10, 'Mhaura-Selbina_Boat',         17797182, 17797181, -0.516, 0.026, -8.409,  0, 493, 18, 19, 382, 480, 18, 80, 17, 221, 3); -- 22 hours 40 min
INSERT INTO `transport` VALUES(18, 'Selbina-Mhaura_Boat_Pirates', 17793088, 17793087, 9.294,  0.000, -69.775, 0, 485, 18, 19, 382, 480, 18, 80, 17, 227, 4); -- 22 hours 40 min
INSERT INTO `transport` VALUES(19, 'Mhaura-Selbina_Boat_Pirates', 17797182, 17797181, -0.516, 0.026, -8.409,  0, 493, 18, 19, 382, 480, 18, 80, 17, 228, 3); -- 22 hours 40 min

-- ToAU Boats
INSERT INTO `transport` VALUES(11, 'Mhaura-Whitegate_Boat',  17797182, 17797181, -0.516,  0.026, -8.409,   0,   493, 18, 19, 142, 480, 18, 80,  17, 46, 3);  -- 6 hours 40 min
INSERT INTO `transport` VALUES(12, 'Whitegate-Mhaura_Boat',  16982046, 16982044, -20.726, 3.389, -154.231, 0,   569, 18, 19, 142, 480, 18, 80,  16, 47, 20); -- 6 hours 40 min
INSERT INTO `transport` VALUES(13, 'Whitegate-Nashmau_Boat', 16982046, 16982045, 20.726,  3.389, 154.231,  128, 570, 20, 21, 282, 480, 18, 180, 17, 58, 20); -- 5 hours
INSERT INTO `transport` VALUES(14, 'Nashmau-Whitegate_Boat', 16994327, 16994326, 3.24,    3.389, -114.221, 0,   571, 22, 23, 282, 480, 18, 180, 16, 59, 20); -- 5 hours

-- Bibiki Bay
INSERT INTO `transport` VALUES(15, 'Manaclip_Bibiki-Tours',      16793983, 16793984, 491.500,  0.000, 687.400,  128, 0, 18, 19, 710, 720, 20, 40, 20, 3, 17);
INSERT INTO `transport` VALUES(16, 'Manaclip_Bibiki-Purgonorgo', 16793983, 16793984, 491.500,  0.000, 687.400,  128, 0, 18, 19, 270, 720, 20, 40, 20, 3, 17);
INSERT INTO `transport` VALUES(17, 'Manaclip_Purgonorgo-Bibiki', 16793983, 16793985, -392.000, 0.000, -364.000, 128, 0, 20, 21, 500, 720, 20, 40, 20, 3, 17);

-- Phanauet Channel Barge
INSERT INTO `transport` VALUES (20, 'Barge_South-Central-Emfea',      16785747, 16785755, 246.377,  0.000, -529.793, 192, 0, 18, 19,     5, 1440, 15, 35, 15, 1, 16); -- 3 hours 45 min (225)
INSERT INTO `transport` VALUES (21, 'Barge_Central-South-Newtpool',   16785747, 16785756, -125.040, 0.000, 72.790,   160, 0, 20, 21,   267, 1440, 12, 30, 15, 1, 16); -- 3 hours 45 min (225)
INSERT INTO `transport` VALUES (22, 'Barge_South-OOS',                16785747, 16785755,  246.377, 0.000, -529.793,  64, 0, 23, 0,   1402, 1440, 33,  0,  0, 1, 16);
INSERT INTO `transport` VALUES (23, 'Barge_South-North',              16785747, 16785755, 246.377,  0.000, -529.793, 192, 0, 18, 19,   560, 1440, 15, 35, 15, 1, 16); -- 5 hours 50 min (350)
INSERT INTO `transport` VALUES (24, 'Barge_North-OOS',                16785747, 16785757, -291.355, 0.000,  516.868, 160, 0, 22, 0,    925, 1440, 40,  0,  0, 1, 16);
INSERT INTO `transport` VALUES (25, 'Barge_North-Central',            16785747, 16785757, -291.355, 0.000, 516.868,   32, 0, 24, 25,   993, 1440, 12, 40, 15, 1, 16); -- 1 hour  50 min (110)
INSERT INTO `transport` VALUES (26, 'Barge_Central-South-Newtpool-2', 16785747, 16785756, -125.040, 0.000, 72.790,   160, 0, 20, 21,  1148, 1440, 12, 30, 15, 1, 16); -- 3 hours 45 min (225)
INSERT INTO `transport` VALUES (27, 'Barge_South-OOS-2',              16785747, 16785755,  246.377, 0.000, -529.793,  64, 0, 23, 0,    512, 1440, 33,  0,  0, 1, 16);
