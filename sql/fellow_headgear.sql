SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

DROP TABLE IF EXISTS `fellow_headgear`;
CREATE TABLE IF NOT EXISTS `fellow_headgear` (
  `rank` int(3) unsigned NOT NULL,
 -- columns arranged by personality
  `4` int(3) unsigned NOT NULL,  -- Sullen M
  `8` int(3) unsigned NOT NULL,  -- Passionate M
  `12` int(3) unsigned NOT NULL, -- Calm and collected M
  `16` int(3) unsigned NOT NULL, -- Serious M
  `40` int(3) unsigned NOT NULL, -- Childish M
  `44` int(3) unsigned NOT NULL, -- Suave M
  `20` int(3) unsigned NOT NULL, -- Sisterly F
  `24` int(3) unsigned NOT NULL, -- Lively F
  `28` int(3) unsigned NOT NULL, -- Agreeable F
  `32` int(3) unsigned NOT NULL, -- Naive F
  `36` int(3) unsigned NOT NULL, -- Serious F
  `48` int(3) unsigned NOT NULL, -- Domineering F
  PRIMARY KEY (`rank`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;
                                         -- SuM PasM ClmM SerM ChiM SuaM SisF LivF AgrF NaiF SerF DomF
INSERT INTO `fellow_headgear` VALUES (  0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0);
INSERT INTO `fellow_headgear` VALUES (  1,   1,  17,   5,  28,   6, 149,  20,  32, 131,  34,  15,  14);
INSERT INTO `fellow_headgear` VALUES (  2,  26,   2,  16,  18,  32, 129, 149,  21,  19,  15,  28,  12);
INSERT INTO `fellow_headgear` VALUES (  3, 149,   9,  27, 133, 133,   5, 130,  36,  20,  18, 129,  16);
INSERT INTO `fellow_headgear` VALUES (  4,   5,  36, 108, 129, 149, 150,  19,  56, 133, 149,  18,   4);
INSERT INTO `fellow_headgear` VALUES (  5,  29, 149, 114,  12,   4, 130,  23, 130,  13,  20, 133,  58);
INSERT INTO `fellow_headgear` VALUES (  6,   7,  23,  58,  35,  18, 162,   5,  54, 149, 133,  33,  24);
INSERT INTO `fellow_headgear` VALUES (  7,  96,  94, 150,   5,  56,  27,  13,  18,  21,   7,  12, 141);
INSERT INTO `fellow_headgear` VALUES (  8, 115, 114,  22,  24, 134,  59,  57,   4, 162,  19, 101,  55);
INSERT INTO `fellow_headgear` VALUES (  9,  52,  49,  53,  51,  49,  52,  53,  51,  53,  49,  51,  52);
