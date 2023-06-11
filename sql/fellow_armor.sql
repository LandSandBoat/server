SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

DROP TABLE IF EXISTS `fellow_armor`;
CREATE TABLE IF NOT EXISTS `fellow_armor` (
  `rank` int(3) unsigned NOT NULL,
  `body` int(3) unsigned NOT NULL,
  `hands` int(3) unsigned NOT NULL,
  `legs` int(3) unsigned NOT NULL,
  `feet` int(3) unsigned NOT NULL,
  PRIMARY KEY (`rank`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

-- heavy armor
INSERT INTO `fellow_armor` VALUES (  0,  28,  28,  28,  28); -- scale mail, scale f.gauntlets, scale cuisses, scale greaves                      body=12560, hands=12688, legs=12816, feet=12944
INSERT INTO `fellow_armor` VALUES (  1,   2,   2,   2,   2); -- breastplate, gauntlets, cuisses, plate leggings                                  body=12544, hands=12672, legs=12800, feet=12928
INSERT INTO `fellow_armor` VALUES (  2,  29,  29,  29,  29); -- mythril breastplate, mythril gauntlets, mythril cuisses, mythril leggings        body=12545, hands=12673, legs=12801, feet=12929
INSERT INTO `fellow_armor` VALUES (  3, 138, 138, 138, 138); -- eisenbrust, eisenhentzes, eisendiechlings, eisenschuhs                           body=14431, hands=14860, legs=14329, feet=15317
INSERT INTO `fellow_armor` VALUES (  4, 108, 108,  52,  52); -- carap. breastplate, carap. gauntlets, iron cuisses, iron greaves                 body=13789, hands=14008, legs=14243, feet=14118
INSERT INTO `fellow_armor` VALUES (  5,  25,  25,  25,  25); -- i.m. cuirass, i.m. gauntlets, i.m. cuisses, i.m. sabatons                        body=12550, hands=12678, legs=12806, feet=12934
INSERT INTO `fellow_armor` VALUES (  6,   9,   9,   9,   9); -- hara-ate, kote, haidate, sune-ate                                                body=12587, hands=12715, legs=12843, feet=12974
INSERT INTO `fellow_armor` VALUES (  7, 114, 114,  53,  53); -- scorp. breastplate, scorp. gauntlets, steel cuisses, steel greaves               body=12621, hands=12751, legs=14245, feet=14120
INSERT INTO `fellow_armor` VALUES (  8,  22,  22,  22,  22); -- darksteel cuirass, darksteel gauntlets, darksteel cuisses, darksteel sabatons    body=12547, hands=12675, legs=12803, feet=12931
INSERT INTO `fellow_armor` VALUES (  9,  55,  55,  55,  55); -- adaman cuirass, adaman gauntlets, adaman cuisses, adaman sabatons                body=12548, hands=12676, legs=12804, feet=12932
INSERT INTO `fellow_armor` VALUES ( 10, 139, 139, 139, 139); -- lords cuirass, lords gauntlets, lords cuisses, lords sabatons                    body=13757, hands=14879, legs=15395, feet=15333
INSERT INTO `fellow_armor` VALUES ( 11, 141, 141, 141, 141); -- hachiman domaru, hachiman kote, hachiman hakama, hachiman sune-ate               body=14437, hands=14876, legs=15392, feet=15330
-- light armor
INSERT INTO `fellow_armor` VALUES (100,   6,   6,   6,   6); -- lizard jerkin, lizard gloves, lizard trousers, lizard ledelsens                  body=12569, hands=12697, legs=12825, feet=12953
INSERT INTO `fellow_armor` VALUES (101,   5,   5,   5,   5); -- chainmail, chain mittens, chain hose, greaves                                    body=12552, hands=12680, legs=12808, feet=12936
INSERT INTO `fellow_armor` VALUES (102,  26,  26,  27,  26); -- coral scale mail, coral f.gauntlets, coral cuisses, coral greaves                body=12563, hands=12691, legs=12819, feet=12947
INSERT INTO `fellow_armor` VALUES (103,  17,  17,  17,  17); -- kenpogi, tekko, sitabaki, kyahan                                                 body=12584, hands=12712, legs=12840, feet=12968
INSERT INTO `fellow_armor` VALUES (104, 129, 129, 129, 129); -- shade harness, shade mittens, shade tights, shade leggings                       body=14426, hands=14858, legs=14327, feet=15315
INSERT INTO `fellow_armor` VALUES (105,  12,  12,  12,  12); -- banded mail, mufflers, breeches, sollerets                                       body=12554, hands=12682, legs=12810, feet=12938
INSERT INTO `fellow_armor` VALUES (106,   7,   7,   7,   7); -- raptor jerkin, raptor gloves, raptor trousers, raptor ledelsens                  body=12572, hands=12700, legs=12828, feet=12956
INSERT INTO `fellow_armor` VALUES (107,   4,   4,   4,   4); -- shinobi gi, shinobi tekko, shinobi hakama, shinobi kyahan                        body=12588, hands=12716, legs=12844, feet=12972
INSERT INTO `fellow_armor` VALUES (108,  13,  13,  13,  13); -- r.k. chainmail, r.k. mufflers, r.k. breeches, r.k. sollerets                     body=12558, hands=12686, legs=12814, feet=12942
INSERT INTO `fellow_armor` VALUES (109,  27,  27,  27,  27); -- gavial mail, gavial f.gauntlets, gavial cuisses, gavial greaves                  body=12565, hands=12693, legs=12821, feet=12949
INSERT INTO `fellow_armor` VALUES (110, 150, 150, 150, 150); -- alumine haubert, alumine moufles, alumine brayettes, alumine sollerets           body=14444, hands=14051, legs=15402, feet=15341
INSERT INTO `fellow_armor` VALUES (111,  98,  98,  98,  98); -- yasha samue, yasha tekko, yasha hakama, yasha sune-ate                           body=12618, hands=13957, legs=12847, feet=13002
-- mage armor
INSERT INTO `fellow_armor` VALUES (200,  21,  21,  21,  21); -- doublet, gloves, brais, gaiters                                                  body=12592, hands=12720, legs=12848, feet=12976
INSERT INTO `fellow_armor` VALUES (201, 149, 149, 149, 149); -- trader saio, trader cuffs, trader slops, trader pigaches                         body=14446, hands=14053, legs=15404, feet=15343
INSERT INTO `fellow_armor` VALUES (202, 131, 131, 131, 131); -- seer tunic, seer mitts, seer slacks, seer pumps                                  body=14424, hands=14856, legs=14325, feet=15313
INSERT INTO `fellow_armor` VALUES (203,  23,  23,  23,  23); -- gambison, bracers, hose, socks                                                   body=12594, hands=12722, legs=12850, feet=12978
INSERT INTO `fellow_armor` VALUES (204,  18,  18,  18,  18); -- wool robe, wool cuffs, wool slops, chestnut sabots                               body=12602, hands=12730, legs=12858, feet=12986
INSERT INTO `fellow_armor` VALUES (205,  97,  20,  20,  20); -- holy breastplate, cuffs, slops, ash clogs                                        body=13812, hands=12728, legs=12856, feet=12984
INSERT INTO `fellow_armor` VALUES (206,  19,  19,  19,  19); -- t.m. coat, t.m. cuffs, t.m. slops, t.m. pigaches                                 body=12606, hands=12734, legs=12862, feet=12990
INSERT INTO `fellow_armor` VALUES (207,  43,  10,  11,  11); -- earth doublet, silk mitts, silk slacks, silk pumps                               body=13732, hands=12740, legs=12868, feet=12996
INSERT INTO `fellow_armor` VALUES (208, 115, 115, 115, 115); -- austere robe, austere cuffs, austere slops, austere sabots                       body=13814, hands=14826, legs=14310, feet=14189
INSERT INTO `fellow_armor` VALUES (209,  57,  57,  57,  57); -- noble tunic, noble mitts, moble slacks, noble pumps                              body=12605, hands=12733, legs=12861, feet=12989
INSERT INTO `fellow_armor` VALUES (210, 101, 101, 101, 101); -- errant houppelande, errant cuffs, errant slops, errant pigaches                  body=14380, hands=14078, legs=14301, feet=14182
INSERT INTO `fellow_armor` VALUES (211, 142, 142, 142, 142); -- blessed briault, blessed mitts, blessed trousers, blessed pumps                  body=14436, hands=14875, legs=15391, feet=15329
-- freestyle armor
INSERT INTO `fellow_armor` VALUES (300,   8,   8,   8,   8); -- lvl 1 rse, lvl 1 rse, lvl 1 rse, lvl 1 rse                                       body=12631, hands=12754, legs=12883, feet=13005
INSERT INTO `fellow_armor` VALUES (301, 103, 102, 104, 105); -- chocobo j.coat, fish gloves, vagabond hose, field boots                          body=13810, hands=14070, legs=14290, feet=14176
INSERT INTO `fellow_armor` VALUES (302,  15,   0,  15,   3); -- bronze harness, no armor, bronze subligar, solea                                 body=12576, hands=    0, legs=12832, feet=12992
INSERT INTO `fellow_armor` VALUES (303,  31,  31,  31,  31); -- lvl 30 rse, lvl 30 rse, lvl 30 rse, lvl 30 rse                                   body=12654, hands=12761, legs=12871, feet=13015
INSERT INTO `fellow_armor` VALUES (304,  48, 103, 102, 104); -- blue cotehardie, chocobo gloves, fish hose, vagabond hose                        body=13775, hands=14072, legs=14292, feet=14169
INSERT INTO `fellow_armor` VALUES (305,  34, 117,  32,   0); -- scorpion harness, carpenter gloves, zodiac subligar, no armor                    body=12579, hands=14830, legs=15375, feet=    0
INSERT INTO `fellow_armor` VALUES (306,  45,  24,  24,  24); -- justaucorps, battle bracers, battle hose, battle boots                           body=13744, hands=12724, legs=12852, feet=12980
INSERT INTO `fellow_armor` VALUES (307,  56,  56,  56,  56); -- coral harness, coral mittens, coral subligar, coral leggings                     body=12581, hands=12709, legs=12878, feet=12965
INSERT INTO `fellow_armor` VALUES (308,  33,   3,   3,  10); -- cardinal vest, mitts, slacks, shoes                                              body=14372, hands=12736, legs=12864, feet=12994
INSERT INTO `fellow_armor` VALUES (309,  35,  15,  33,  15); -- demon harness, bronze mittens, femina subligar, bronze leggings                  body=13767, hands=12704, legs=15390, feet=12960
INSERT INTO `fellow_armor` VALUES (310, 134, 134, 134, 134); -- bison jacket, bison wristbands, bison kecks, bison gamashes                      body=14418, hands=14850, legs=14319, feet=15307
INSERT INTO `fellow_armor` VALUES (311, 161, 161, 161, 161); -- black trader saio, black trader cuffs, black trader slops, black trader pigaches body=14436, hands=14875, legs=15391, feet=15329
