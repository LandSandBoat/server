SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for blue_traits
-- ----------------------------
DROP TABLE IF EXISTS `blue_traits`;
CREATE TABLE `blue_traits` (
  `trait_category` smallint(2) unsigned NOT NULL,
  `trait_points_needed` smallint(2) unsigned NOT NULL,
  `traitid` tinyint(3) unsigned NOT NULL,
  `modifier` smallint(5) unsigned NOT NULL,
  `value` smallint(5) NOT NULL,
  PRIMARY KEY (`trait_category`,`trait_points_needed`,`modifier`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records 
-- ----------------------------
INSERT INTO `blue_traits` VALUES (1, 2, 32, 230, 8);
INSERT INTO `blue_traits` VALUES (2, 2, 9, 370, 1);
INSERT INTO `blue_traits` VALUES (3, 2, 35, 227, 8);
INSERT INTO `blue_traits` VALUES (4, 2, 24, 295, 1);
INSERT INTO `blue_traits` VALUES (4, 4, 24, 295, 2);
INSERT INTO `blue_traits` VALUES (4, 6, 24, 295, 3);
INSERT INTO `blue_traits` VALUES (4, 8, 24, 295, 4);
INSERT INTO `blue_traits` VALUES (5, 2, 48, 240, 2);
INSERT INTO `blue_traits` VALUES (6, 2, 5, 28, 20);
INSERT INTO `blue_traits` VALUES (7, 2, 39, 231, 8);
INSERT INTO `blue_traits` VALUES (8, 2, 3, 23, 10);
INSERT INTO `blue_traits` VALUES (8, 2, 3, 24, 10);
INSERT INTO `blue_traits` VALUES (9, 2, 11, 357, 10);
INSERT INTO `blue_traits` VALUES (10, 2, 8, 5, 10);
INSERT INTO `blue_traits` VALUES (10, 4, 8, 5, 30);
INSERT INTO `blue_traits` VALUES (11, 2, 4, 1, 10);
INSERT INTO `blue_traits` VALUES (12, 2, 33, 229, 8);
INSERT INTO `blue_traits` VALUES (13, 2, 6, 29, 10);
INSERT INTO `blue_traits` VALUES (14, 8, 10, 369, 1);
INSERT INTO `blue_traits` VALUES (15, 2, 7, 2, 30);
INSERT INTO `blue_traits` VALUES (15, 4, 7, 2, 90);
INSERT INTO `blue_traits` VALUES (16, 2, 1, 25, 10);
INSERT INTO `blue_traits` VALUES (16, 2, 1, 26, 10);
INSERT INTO `blue_traits` VALUES (17, 2, 13, 296, 25);
INSERT INTO `blue_traits` VALUES (18, 2, 2, 69, 10);
INSERT INTO `blue_traits` VALUES (19, 2, 58, 249, 2);
INSERT INTO `blue_traits` VALUES (20, 2, 14, 73, 10);
INSERT INTO `blue_traits` VALUES (20, 4, 14, 73, 25);
INSERT INTO `blue_traits` VALUES (21, 2, 17, 291, 10);
INSERT INTO `blue_traits` VALUES (22, 2, 12, 170, 5);
INSERT INTO `blue_traits` VALUES (22, 4, 12, 170, 15);
INSERT INTO `blue_traits` VALUES (23, 2, 106, 174, 8);
INSERT INTO `blue_traits` VALUES (24, 2, 15, 288, 7);
INSERT INTO `blue_traits` VALUES (24, 4, 16, 302, 5);
INSERT INTO `blue_traits` VALUES (25, 2, 18, 259, 10);
INSERT INTO `blue_traits` VALUES (25, 4, 18, 259, 15);
INSERT INTO `blue_traits` VALUES (25, 6, 18, 259, 25);
INSERT INTO `blue_traits` VALUES (26, 2, 70, 306, 15);
INSERT INTO `blue_traits` VALUES (27, 2, 110, 407, 5);
INSERT INTO `blue_traits` VALUES (28, 2, 20, 0, 0);
INSERT INTO `blue_traits` VALUES (28, 3, 19, 303, 1);
INSERT INTO `blue_traits` VALUES (29, 2, 117, 958, 5); -- tenacity
INSERT INTO `blue_traits` VALUES (30, 2, 118, 963, 5); -- inquartata
INSERT INTO `blue_traits` VALUES (31, 2, 125, 30, 10); -- MACC
INSERT INTO `blue_traits` VALUES (32, 2, 126, 31, 10); -- MEVA

-- REDO
INSERT INTO `blue_traits` VALUES (101,8,1,25,10); -- accuracy bonus(1)
INSERT INTO `blue_traits` VALUES (101,8,1,26,10); -- accuracy bonus(1)
INSERT INTO `blue_traits` VALUES (101,16,1,25,22); -- accuracy bonus(2)
INSERT INTO `blue_traits` VALUES (101,16,1,26,22); -- accuracy bonus(2)
INSERT INTO `blue_traits` VALUES (101,24,1,25,35); -- accuracy bonus(3)
INSERT INTO `blue_traits` VALUES (101,24,1,26,35); -- accuracy bonus(3)
INSERT INTO `blue_traits` VALUES (101,32,1,25,48); -- accuracy bonus(4)
INSERT INTO `blue_traits` VALUES (101,32,1,26,48); -- accuracy bonus(4)
INSERT INTO `blue_traits` VALUES (101,40,1,25,60); -- accuracy bonus(5)
INSERT INTO `blue_traits` VALUES (101,40,1,26,60); -- accuracy bonus(5)
INSERT INTO `blue_traits` VALUES (101,48,1,25,72); -- accuracy bonus(6)
INSERT INTO `blue_traits` VALUES (101,48,1,26,72); -- accuracy bonus(6)
INSERT INTO `blue_traits` VALUES (102,8,3,23,10); -- attack bonus(1)
INSERT INTO `blue_traits` VALUES (102,8,3,24,10); -- attack bonus(1)
INSERT INTO `blue_traits` VALUES (102,16,3,23,22); -- attack bonus(2)
INSERT INTO `blue_traits` VALUES (102,16,3,24,22); -- attack bonus(2)
INSERT INTO `blue_traits` VALUES (102,24,3,23,35); -- attack bonus(3)
INSERT INTO `blue_traits` VALUES (102,24,3,24,35); -- attack bonus(3)
INSERT INTO `blue_traits` VALUES (102,32,3,23,48); -- attack bonus(4)
INSERT INTO `blue_traits` VALUES (102,32,3,24,48); -- attack bonus(4)
INSERT INTO `blue_traits` VALUES (102,40,3,23,60); -- attack bonus(5)
INSERT INTO `blue_traits` VALUES (102,40,3,24,60); -- attack bonus(5)
INSERT INTO `blue_traits` VALUES (102,48,3,23,72); -- attack bonus(6)
INSERT INTO `blue_traits` VALUES (102,48,3,24,72); -- attack bonus(6)
INSERT INTO `blue_traits` VALUES (103,8,9,370,1); -- auto regen(1)
INSERT INTO `blue_traits` VALUES (103,16,9,370,2); -- auto regen(2)
INSERT INTO `blue_traits` VALUES (103,24,9,370,3); -- auto regen(3)
INSERT INTO `blue_traits` VALUES (104,8,10,369,1); -- auto refresh(1)
INSERT INTO `blue_traits` VALUES (105,8,24,295,3); -- clear mind(1)
INSERT INTO `blue_traits` VALUES (105,16,24,295,6); -- clear mind(2)
INSERT INTO `blue_traits` VALUES (105,24,24,295,9); -- clear mind(3)
INSERT INTO `blue_traits` VALUES (105,32,24,295,12); -- clear mind(4)
INSERT INTO `blue_traits` VALUES (105,40,24,295,15); -- clear mind(5)
INSERT INTO `blue_traits` VALUES (105,48,24,295,18); -- clear mind(6)
INSERT INTO `blue_traits` VALUES (106,8,13,296,25); -- conserve mp(1)
INSERT INTO `blue_traits` VALUES (106,16,13,296,28); -- conserve mp(2)
INSERT INTO `blue_traits` VALUES (106,24,13,296,31); -- conserve mp(3)
INSERT INTO `blue_traits` VALUES (106,32,13,296,34); -- conserve mp(4)
INSERT INTO `blue_traits` VALUES (106,40,13,296,37); -- conserve mp(5)
INSERT INTO `blue_traits` VALUES (107,8,17,291,8); -- counter(1)
INSERT INTO `blue_traits` VALUES (107,16,17,291,12); -- counter(2)
INSERT INTO `blue_traits` VALUES (108,8,98,421,5); -- critical attack bonus(1)
INSERT INTO `blue_traits` VALUES (108,16,98,421,8); -- critical attack bonus(2)
INSERT INTO `blue_traits` VALUES (108,24,98,421,11); -- critical attack bonus(3)
INSERT INTO `blue_traits` VALUES (109,8,4,1,10); -- defense bonus(1)
INSERT INTO `blue_traits` VALUES (109,16,4,1,22); -- defense bonus(2)
INSERT INTO `blue_traits` VALUES (109,24,4,1,35); -- defense bonus(3)
INSERT INTO `blue_traits` VALUES (109,32,4,1,48); -- defense bonus(4)
INSERT INTO `blue_traits` VALUES (109,40,4,1,60); -- defense bonus(5)
INSERT INTO `blue_traits` VALUES (109,48,4,1,72); -- defense bonus(6)
INSERT INTO `blue_traits` VALUES (110,8,15,288,7); -- Dbl/Tpl Attack(1)
INSERT INTO `blue_traits` VALUES (110,16,16,302,5); -- Dbl/Tpl Attack(2)
INSERT INTO `blue_traits` VALUES (111,8,18,259,10); -- dual wield(1)
INSERT INTO `blue_traits` VALUES (111,16,18,259,15); -- dual wield(2)
INSERT INTO `blue_traits` VALUES (111,24,18,259,25); -- dual wield(3)
INSERT INTO `blue_traits` VALUES (111,32,18,259,30); -- dual wield(4)
INSERT INTO `blue_traits` VALUES (111,40,18,259,35); -- dual wield(5)
INSERT INTO `blue_traits` VALUES (111,48,18,259,37); -- dual wield(6)
INSERT INTO `blue_traits` VALUES (112,8,2,68,10); -- evasion bonus(1)
INSERT INTO `blue_traits` VALUES (112,16,2,68,22); -- evasion bonus(2)
INSERT INTO `blue_traits` VALUES (112,24,2,68,35); -- evasion bonus(3)
INSERT INTO `blue_traits` VALUES (112,32,2,68,48); -- evasion bonus(4)
INSERT INTO `blue_traits` VALUES (112,40,2,68,60); -- evasion bonus(5)
INSERT INTO `blue_traits` VALUES (113,8,12,170,5); -- fast cast(1)
INSERT INTO `blue_traits` VALUES (113,16,12,170,10); -- fast cast(2)
INSERT INTO `blue_traits` VALUES (113,24,12,170,15); -- fast cast(3)
INSERT INTO `blue_traits` VALUES (113,32,12,170,20); -- fast cast(4)
INSERT INTO `blue_traits` VALUES (113,40,12,170,25); -- fast cast(5)
INSERT INTO `blue_traits` VALUES (114,8,20,897,1); -- Gilfinder/TH(1)
INSERT INTO `blue_traits` VALUES (114,16,19,303,1); -- Gilfinder/TH(2)
INSERT INTO `blue_traits` VALUES (115,8,118,963,5); -- Inquartata(1)
INSERT INTO `blue_traits` VALUES (115,16,19,963,7); -- Inquartata(2)
INSERT INTO `blue_traits` VALUES (115,24,19,963,9); -- Inquartata(3)
INSERT INTO `blue_traits` VALUES (116,8,32,230,8); -- Beast Killer(1)
INSERT INTO `blue_traits` VALUES (117,8,35,227,8); -- Lizard Killer(1)
INSERT INTO `blue_traits` VALUES (118,8,33,229,8); -- Plaintoid Killer(1)
INSERT INTO `blue_traits` VALUES (119,8,39,231,8); -- Undead Killer(1)
INSERT INTO `blue_traits` VALUES (120,8,125,30,10); -- Macc Bonus(1)
INSERT INTO `blue_traits` VALUES (120,16,125,30,22); -- Macc Bonus(2)
INSERT INTO `blue_traits` VALUES (120,24,125,30,35); -- Macc Bonus(3)
INSERT INTO `blue_traits` VALUES (121,8,5,28,20); -- matk bonus(1)
INSERT INTO `blue_traits` VALUES (121,16,5,28,24); -- matk bonus(2)
INSERT INTO `blue_traits` VALUES (121,24,5,28,28); -- matk bonus(3)
INSERT INTO `blue_traits` VALUES (121,32,5,28,32); -- matk bonus(4)
INSERT INTO `blue_traits` VALUES (121,40,5,28,36); -- matk bonus(5)
INSERT INTO `blue_traits` VALUES (121,48,5,28,40); -- matk bonus(6)
INSERT INTO `blue_traits` VALUES (122,8,110,487,5); -- mburst bonus(1)
INSERT INTO `blue_traits` VALUES (122,16,110,487,7); -- mburst bonus(2)
INSERT INTO `blue_traits` VALUES (122,24,110,487,9); -- mburst bonus(3)
INSERT INTO `blue_traits` VALUES (122,32,110,487,11); -- mburst bonus(4)
INSERT INTO `blue_traits` VALUES (122,40,110,487,13); -- mburst bonus(5)
INSERT INTO `blue_traits` VALUES (123,8,6,29,10); -- mdef bonus(1)
INSERT INTO `blue_traits` VALUES (123,16,6,29,12); -- mdef bonus(2)
INSERT INTO `blue_traits` VALUES (123,24,6,29,14); -- mdef bonus(3)
INSERT INTO `blue_traits` VALUES (123,32,6,29,16); -- mdef bonus(4)
INSERT INTO `blue_traits` VALUES (123,40,6,29,18); -- mdef bonus(5)
INSERT INTO `blue_traits` VALUES (124,8,126,31,10); -- meva bonus(1)
INSERT INTO `blue_traits` VALUES (124,16,126,31,22); -- meva bonus(2)
INSERT INTO `blue_traits` VALUES (124,24,126,31,35); -- meva bonus(3)
INSERT INTO `blue_traits` VALUES (125,8,7,2,30); -- max hp boost(1)
INSERT INTO `blue_traits` VALUES (125,16,7,2,60); -- max hp boost(2)
INSERT INTO `blue_traits` VALUES (125,24,7,2,120); -- max hp boost(3)
INSERT INTO `blue_traits` VALUES (125,32,7,2,180); -- max hp boost(4)
INSERT INTO `blue_traits` VALUES (125,40,7,2,240); -- max hp boost(5)
INSERT INTO `blue_traits` VALUES (125,48,7,2,300); -- max hp boost(6)
INSERT INTO `blue_traits` VALUES (126,8,8,5,10); -- max mp boost(1)
INSERT INTO `blue_traits` VALUES (126,16,8,5,20); -- max mp boost(2)
INSERT INTO `blue_traits` VALUES (126,24,8,5,40); -- max mp boost(3)
INSERT INTO `blue_traits` VALUES (126,32,8,5,60); -- max mp boost(4)
INSERT INTO `blue_traits` VALUES (127,8,11,359,25); -- rapid shot(1)
INSERT INTO `blue_traits` VALUES (128,8,58,249,10); -- resist gravity(1)
INSERT INTO `blue_traits` VALUES (129,8,52,244,10); -- resist silence(1)
INSERT INTO `blue_traits` VALUES (130,8,48,240,10); -- resist sleep(1)
INSERT INTO `blue_traits` VALUES (131,8,106,174,8); -- skillchain bonus(1)
INSERT INTO `blue_traits` VALUES (131,16,106,174,12); -- skillchain bonus(2)
INSERT INTO `blue_traits` VALUES (131,24,106,174,16); -- skillchain bonus(3)
INSERT INTO `blue_traits` VALUES (131,32,106,174,20); -- skillchain bonus(4)
INSERT INTO `blue_traits` VALUES (131,40,106,174,23); -- skillchain bonus(5)
INSERT INTO `blue_traits` VALUES (132,8,14,73,10); -- store tp(1)
INSERT INTO `blue_traits` VALUES (132,16,14,73,15); -- store tp(2)
INSERT INTO `blue_traits` VALUES (132,24,14,73,20); -- store tp(3)
INSERT INTO `blue_traits` VALUES (132,32,14,73,25); -- store tp(4)
INSERT INTO `blue_traits` VALUES (132,40,14,73,30); -- store tp(5)
INSERT INTO `blue_traits` VALUES (133,8,117,958,5); -- tenacity(1)
INSERT INTO `blue_traits` VALUES (133,16,117,958,7); -- tenacity(2)
INSERT INTO `blue_traits` VALUES (133,24,117,958,9); -- tenacity(3)
INSERT INTO `blue_traits` VALUES (134,8,70,306,15); -- zanshin(1)