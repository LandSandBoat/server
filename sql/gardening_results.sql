DROP TABLE IF EXISTS `gardening_results`;
CREATE TABLE IF NOT EXISTS `gardening_results` (
  `resultId` smallint(4) unsigned NOT NULL,
  `seed` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `element1` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `element2` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `result` smallint(5) unsigned NOT NULL DEFAULT 0,
  `min_quantity` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `max_quantity` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `weight` smallint(4) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`resultId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=23;

INSERT INTO `gardening_results` VALUES (1, 1, 0, 0, 936, 12, 24, 30); -- Rock Salt
INSERT INTO `gardening_results` VALUES (2, 1, 0, 0, 4449, 1, 2, 30); -- Reishi Mushroom
INSERT INTO `gardening_results` VALUES (3, 1, 0, 0, 4468, 6, 12, 20); -- Pamamas
INSERT INTO `gardening_results` VALUES (4, 1, 0, 0, 770, 1, 2, 20); -- Blue Rock
INSERT INTO `gardening_results` VALUES (5, 1, 0, 1, 936, 12, 24, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (6, 1, 0, 1, 4097, 6, 12, 15); -- Ice Crystal
INSERT INTO `gardening_results` VALUES (7, 1, 0, 1, 4449, 1, 2, 15); -- Reishi Mushroom
INSERT INTO `gardening_results` VALUES (8, 1, 0, 1, 4392, 6, 12, 15); -- Saruta Orange
INSERT INTO `gardening_results` VALUES (9, 1, 0, 1, 4468, 6, 12, 10); -- Pamamas
INSERT INTO `gardening_results` VALUES (10, 1, 0, 1, 4445, 8, 16, 10); -- Yagudo Cherry
INSERT INTO `gardening_results` VALUES (11, 1, 0, 1, 770, 1, 2, 10); -- Blue Rock
INSERT INTO `gardening_results` VALUES (12, 1, 0, 1, 769, 1, 2, 10); -- Red Rock
INSERT INTO `gardening_results` VALUES (13, 1, 0, 2, 936, 12, 24, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (14, 1, 0, 2, 4098, 6, 12, 15); -- Wind Crystal
INSERT INTO `gardening_results` VALUES (15, 1, 0, 2, 4449, 1, 2, 15); -- Reishi Mushroom
INSERT INTO `gardening_results` VALUES (16, 1, 0, 2, 4390, 6, 12, 15); -- Mithran Tomato
INSERT INTO `gardening_results` VALUES (17, 1, 0, 2, 4468, 6, 12, 10); -- Pamamas
INSERT INTO `gardening_results` VALUES (18, 1, 0, 2, 4503, 6, 12, 10); -- Buburimu Grape
INSERT INTO `gardening_results` VALUES (19, 1, 0, 2, 770, 1, 2, 10); -- Blue Rock
INSERT INTO `gardening_results` VALUES (20, 1, 0, 2, 773, 1, 2, 10); -- Translucent Rock
INSERT INTO `gardening_results` VALUES (21, 1, 0, 3, 936, 12, 24, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (22, 1, 0, 3, 4099, 6, 12, 15); -- Earth Crystal
INSERT INTO `gardening_results` VALUES (23, 1, 0, 3, 4449, 1, 2, 15); -- Reishi Mushroom
INSERT INTO `gardening_results` VALUES (24, 1, 0, 3, 4431, 6, 12, 15); -- Bunch Of San dOrian Grapes
INSERT INTO `gardening_results` VALUES (25, 1, 0, 3, 4468, 6, 12, 10); -- Pamamas
INSERT INTO `gardening_results` VALUES (26, 1, 0, 3, 4365, 6, 12, 10); -- Rolanberry
INSERT INTO `gardening_results` VALUES (27, 1, 0, 3, 770, 1, 2, 10); -- Blue Rock
INSERT INTO `gardening_results` VALUES (28, 1, 0, 3, 772, 1, 2, 10); -- Green Rock
INSERT INTO `gardening_results` VALUES (29, 1, 0, 4, 936, 12, 24, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (30, 1, 0, 4, 4100, 6, 12, 15); -- Lightning Crystal
INSERT INTO `gardening_results` VALUES (31, 1, 0, 4, 4449, 1, 2, 15); -- Reishi Mushroom
INSERT INTO `gardening_results` VALUES (32, 1, 0, 4, 4389, 8, 16, 15); -- San dOrian Carrot
INSERT INTO `gardening_results` VALUES (33, 1, 0, 4, 4468, 6, 12, 10); -- Pamamas
INSERT INTO `gardening_results` VALUES (34, 1, 0, 4, 4388, 8, 16, 10); -- Eggplant
INSERT INTO `gardening_results` VALUES (35, 1, 0, 4, 770, 1, 2, 10); -- Blue Rock
INSERT INTO `gardening_results` VALUES (36, 1, 0, 4, 771, 1, 2, 10); -- Yellow Rock
INSERT INTO `gardening_results` VALUES (37, 1, 0, 5, 936, 12, 24, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (38, 1, 0, 5, 4101, 6, 12, 10); -- Water Crystal
INSERT INTO `gardening_results` VALUES (39, 1, 0, 5, 4449, 1, 2, 15); -- Reishi Mushroom
INSERT INTO `gardening_results` VALUES (40, 1, 0, 5, 4412, 6, 12, 10); -- Thundermelon
INSERT INTO `gardening_results` VALUES (41, 1, 0, 5, 4468, 6, 12, 10); -- Pamamas
INSERT INTO `gardening_results` VALUES (42, 1, 0, 5, 4352, 6, 12, 10); -- Derfland Pear
INSERT INTO `gardening_results` VALUES (43, 1, 0, 5, 770, 1, 2, 10); -- Blue Rock
INSERT INTO `gardening_results` VALUES (44, 1, 0, 5, 4450, 6, 12, 10); -- Coral Fungus
INSERT INTO `gardening_results` VALUES (45, 1, 0, 5, 774, 1, 2, 10); -- Purple Rock
INSERT INTO `gardening_results` VALUES (46, 1, 0, 6, 936, 12, 24, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (47, 1, 0, 6, 17396, 12, 24, 10); -- Little Worm
INSERT INTO `gardening_results` VALUES (48, 1, 0, 6, 4449, 1, 2, 15); -- Reishi Mushroom
INSERT INTO `gardening_results` VALUES (49, 1, 0, 6, 4096, 6, 12, 10); -- Fire Crystal
INSERT INTO `gardening_results` VALUES (50, 1, 0, 6, 4468, 6, 12, 10); -- Pamamas
INSERT INTO `gardening_results` VALUES (51, 1, 0, 6, 4491, 6, 12, 10); -- Watermelon
INSERT INTO `gardening_results` VALUES (52, 1, 0, 6, 770, 1, 2, 20); -- Blue Rock
INSERT INTO `gardening_results` VALUES (53, 1, 0, 6, 4432, 6, 12, 10); -- Kazham Pineapple
INSERT INTO `gardening_results` VALUES (54, 1, 0, 7, 936, 12, 24, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (55, 1, 0, 7, 4103, 6, 12, 15); -- Dark Crystal
INSERT INTO `gardening_results` VALUES (56, 1, 0, 7, 4449, 1, 2, 30); -- Reishi Mushroom
INSERT INTO `gardening_results` VALUES (57, 1, 0, 7, 4363, 6, 12, 10); -- Faerie Apple
INSERT INTO `gardening_results` VALUES (58, 1, 0, 7, 4468, 6, 12, 10); -- Pamamas
INSERT INTO `gardening_results` VALUES (59, 1, 0, 7, 770, 1, 2, 10); -- Blue Rock
INSERT INTO `gardening_results` VALUES (60, 1, 0, 7, 776, 1, 2, 10); -- White Rock
INSERT INTO `gardening_results` VALUES (61, 1, 0, 8, 936, 12, 24, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (62, 1, 0, 8, 4102, 6, 12, 15); -- Light Crystal
INSERT INTO `gardening_results` VALUES (63, 1, 0, 8, 4449, 1, 2, 15); -- Reishi Mushroom
INSERT INTO `gardening_results` VALUES (64, 1, 0, 8, 4392, 6, 12, 15); -- Saruta Orange
INSERT INTO `gardening_results` VALUES (65, 1, 0, 8, 4468, 6, 12, 10); -- Pamamas
INSERT INTO `gardening_results` VALUES (66, 1, 0, 8, 4375, 6, 12, 10); -- Danceshroom
INSERT INTO `gardening_results` VALUES (67, 1, 0, 8, 770, 1, 2, 10); -- Blue Rock
INSERT INTO `gardening_results` VALUES (68, 1, 0, 8, 775, 1, 2, 10); -- Black Rock
INSERT INTO `gardening_results` VALUES (69, 1, 1, 0, 936, 12, 24, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (70, 1, 1, 0, 4097, 6, 12, 15); -- Ice Crystal
INSERT INTO `gardening_results` VALUES (71, 1, 1, 0, 4449, 1, 2, 15); -- Reishi Mushroom
INSERT INTO `gardening_results` VALUES (72, 1, 1, 0, 4392, 6, 12, 15); -- Saruta Orange
INSERT INTO `gardening_results` VALUES (73, 1, 1, 0, 4468, 6, 12, 10); -- Pamamas
INSERT INTO `gardening_results` VALUES (74, 1, 1, 0, 4445, 8, 16, 10); -- Yagudo Cherry
INSERT INTO `gardening_results` VALUES (75, 1, 1, 0, 770, 1, 2, 10); -- Blue Rock
INSERT INTO `gardening_results` VALUES (76, 1, 1, 0, 769, 1, 2, 10); -- Red Rock
INSERT INTO `gardening_results` VALUES (77, 1, 1, 1, 4097, 6, 12, 30); -- Ice Crystal
INSERT INTO `gardening_results` VALUES (78, 1, 1, 1, 4392, 6, 12, 30); -- Saruta Orange
INSERT INTO `gardening_results` VALUES (79, 1, 1, 1, 4445, 8, 16, 20); -- Yagudo Cherry
INSERT INTO `gardening_results` VALUES (80, 1, 1, 1, 769, 1, 2, 20); -- Red Rock
INSERT INTO `gardening_results` VALUES (81, 1, 1, 2, 4097, 6, 12, 15); -- Ice Crystal
INSERT INTO `gardening_results` VALUES (82, 1, 1, 2, 4098, 6, 12, 15); -- Wind Crystal
INSERT INTO `gardening_results` VALUES (83, 1, 1, 2, 4392, 6, 12, 15); -- Saruta Orange
INSERT INTO `gardening_results` VALUES (84, 1, 1, 2, 4390, 6, 12, 15); -- Mithran Tomato
INSERT INTO `gardening_results` VALUES (85, 1, 1, 2, 4445, 8, 16, 10); -- Yagudo Cherry
INSERT INTO `gardening_results` VALUES (86, 1, 1, 2, 4503, 6, 12, 10); -- Buburimu Grape
INSERT INTO `gardening_results` VALUES (87, 1, 1, 2, 769, 1, 2, 10); -- Red Rock
INSERT INTO `gardening_results` VALUES (88, 1, 1, 2, 773, 1, 2, 10); -- Translucent Rock
INSERT INTO `gardening_results` VALUES (89, 1, 1, 3, 4097, 6, 12, 15); -- Ice Crystal
INSERT INTO `gardening_results` VALUES (90, 1, 1, 3, 4099, 6, 12, 15); -- Earth Crystal
INSERT INTO `gardening_results` VALUES (91, 1, 1, 3, 4392, 6, 12, 15); -- Saruta Orange
INSERT INTO `gardening_results` VALUES (92, 1, 1, 3, 4431, 6, 12, 15); -- Bunch Of San dOrian Grapes
INSERT INTO `gardening_results` VALUES (93, 1, 1, 3, 4445, 8, 16, 10); -- Yagudo Cherry
INSERT INTO `gardening_results` VALUES (94, 1, 1, 3, 4365, 6, 12, 10); -- Rolanberry
INSERT INTO `gardening_results` VALUES (95, 1, 1, 3, 769, 1, 2, 10); -- Red Rock
INSERT INTO `gardening_results` VALUES (96, 1, 1, 3, 772, 1, 2, 10); -- Green Rock
INSERT INTO `gardening_results` VALUES (97, 1, 1, 4, 4097, 6, 12, 15); -- Ice Crystal
INSERT INTO `gardening_results` VALUES (98, 1, 1, 4, 4100, 6, 12, 15); -- Lightning Crystal
INSERT INTO `gardening_results` VALUES (99, 1, 1, 4, 4392, 6, 12, 15); -- Saruta Orange
INSERT INTO `gardening_results` VALUES (100, 1, 1, 4, 4389, 8, 16, 15); -- San dOrian Carrot
INSERT INTO `gardening_results` VALUES (101, 1, 1, 4, 4445, 8, 16, 10); -- Yagudo Cherry
INSERT INTO `gardening_results` VALUES (102, 1, 1, 4, 4388, 8, 16, 10); -- Eggplant
INSERT INTO `gardening_results` VALUES (103, 1, 1, 4, 769, 1, 2, 10); -- Red Rock
INSERT INTO `gardening_results` VALUES (104, 1, 1, 4, 771, 1, 2, 10); -- Yellow Rock
INSERT INTO `gardening_results` VALUES (105, 1, 1, 5, 4097, 6, 12, 15); -- Ice Crystal
INSERT INTO `gardening_results` VALUES (106, 1, 1, 5, 4101, 6, 12, 10); -- Water Crystal
INSERT INTO `gardening_results` VALUES (107, 1, 1, 5, 4392, 6, 12, 15); -- Saruta Orange
INSERT INTO `gardening_results` VALUES (108, 1, 1, 5, 4412, 6, 12, 10); -- Thundermelon
INSERT INTO `gardening_results` VALUES (109, 1, 1, 5, 4445, 8, 16, 10); -- Yagudo Cherry
INSERT INTO `gardening_results` VALUES (110, 1, 1, 5, 4352, 6, 12, 10); -- Derfland Pear
INSERT INTO `gardening_results` VALUES (111, 1, 1, 5, 769, 1, 2, 10); -- Red Rock
INSERT INTO `gardening_results` VALUES (112, 1, 1, 5, 4450, 6, 12, 10); -- Coral Fungus
INSERT INTO `gardening_results` VALUES (113, 1, 1, 5, 774, 1, 2, 10); -- Purple Rock
INSERT INTO `gardening_results` VALUES (114, 1, 1, 6, 4097, 6, 12, 15); -- Ice Crystal
INSERT INTO `gardening_results` VALUES (115, 1, 1, 6, 17396, 12, 24, 10); -- Little Worm
INSERT INTO `gardening_results` VALUES (116, 1, 1, 6, 4392, 6, 12, 15); -- Saruta Orange
INSERT INTO `gardening_results` VALUES (117, 1, 1, 6, 4096, 6, 12, 10); -- Fire Crystal
INSERT INTO `gardening_results` VALUES (118, 1, 1, 6, 4445, 8, 16, 10); -- Yagudo Cherry
INSERT INTO `gardening_results` VALUES (119, 1, 1, 6, 4491, 6, 12, 10); -- Watermelon
INSERT INTO `gardening_results` VALUES (120, 1, 1, 6, 769, 1, 2, 10); -- Red Rock
INSERT INTO `gardening_results` VALUES (121, 1, 1, 6, 4432, 6, 12, 10); -- Kazham Pineapple
INSERT INTO `gardening_results` VALUES (122, 1, 1, 6, 770, 1, 2, 10); -- Blue Rock
INSERT INTO `gardening_results` VALUES (123, 1, 1, 7, 4097, 6, 12, 15); -- Ice Crystal
INSERT INTO `gardening_results` VALUES (124, 1, 1, 7, 4103, 6, 12, 15); -- Dark Crystal
INSERT INTO `gardening_results` VALUES (125, 1, 1, 7, 4392, 6, 12, 15); -- Saruta Orange
INSERT INTO `gardening_results` VALUES (126, 1, 1, 7, 4363, 6, 12, 10); -- Faerie Apple
INSERT INTO `gardening_results` VALUES (127, 1, 1, 7, 4445, 8, 16, 10); -- Yagudo Cherry
INSERT INTO `gardening_results` VALUES (128, 1, 1, 7, 4449, 1, 2, 15); -- Reishi Mushroom
INSERT INTO `gardening_results` VALUES (129, 1, 1, 7, 769, 1, 2, 10); -- Red Rock
INSERT INTO `gardening_results` VALUES (130, 1, 1, 7, 776, 1, 2, 10); -- White Rock
INSERT INTO `gardening_results` VALUES (131, 1, 1, 8, 4097, 6, 12, 15); -- Ice Crystal
INSERT INTO `gardening_results` VALUES (132, 1, 1, 8, 4102, 6, 12, 15); -- Light Crystal
INSERT INTO `gardening_results` VALUES (133, 1, 1, 8, 4392, 6, 12, 30); -- Saruta Orange
INSERT INTO `gardening_results` VALUES (134, 1, 1, 8, 4445, 8, 16, 10); -- Yagudo Cherry
INSERT INTO `gardening_results` VALUES (135, 1, 1, 8, 4375, 6, 12, 10); -- Danceshroom
INSERT INTO `gardening_results` VALUES (136, 1, 1, 8, 769, 1, 2, 10); -- Red Rock
INSERT INTO `gardening_results` VALUES (137, 1, 1, 8, 775, 1, 2, 10); -- Black Rock
INSERT INTO `gardening_results` VALUES (138, 1, 2, 0, 936, 12, 24, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (139, 1, 2, 0, 4098, 6, 12, 15); -- Wind Crystal
INSERT INTO `gardening_results` VALUES (140, 1, 2, 0, 4449, 1, 2, 15); -- Reishi Mushroom
INSERT INTO `gardening_results` VALUES (141, 1, 2, 0, 4390, 6, 12, 15); -- Mithran Tomato
INSERT INTO `gardening_results` VALUES (142, 1, 2, 0, 4468, 6, 12, 10); -- Pamamas
INSERT INTO `gardening_results` VALUES (143, 1, 2, 0, 4503, 6, 12, 10); -- Buburimu Grape
INSERT INTO `gardening_results` VALUES (144, 1, 2, 0, 770, 1, 2, 10); -- Blue Rock
INSERT INTO `gardening_results` VALUES (145, 1, 2, 0, 773, 1, 2, 10); -- Translucent Rock
INSERT INTO `gardening_results` VALUES (146, 1, 2, 1, 4097, 6, 12, 15); -- Ice Crystal
INSERT INTO `gardening_results` VALUES (147, 1, 2, 1, 4098, 6, 12, 15); -- Wind Crystal
INSERT INTO `gardening_results` VALUES (148, 1, 2, 1, 4392, 6, 12, 15); -- Saruta Orange
INSERT INTO `gardening_results` VALUES (149, 1, 2, 1, 4390, 6, 12, 15); -- Mithran Tomato
INSERT INTO `gardening_results` VALUES (150, 1, 2, 1, 4445, 8, 16, 10); -- Yagudo Cherry
INSERT INTO `gardening_results` VALUES (151, 1, 2, 1, 4503, 6, 12, 10); -- Buburimu Grape
INSERT INTO `gardening_results` VALUES (152, 1, 2, 1, 769, 1, 2, 10); -- Red Rock
INSERT INTO `gardening_results` VALUES (153, 1, 2, 1, 773, 1, 2, 10); -- Translucent Rock
INSERT INTO `gardening_results` VALUES (154, 1, 2, 2, 4098, 6, 12, 30); -- Wind Crystal
INSERT INTO `gardening_results` VALUES (155, 1, 2, 2, 4390, 6, 12, 30); -- Mithran Tomato
INSERT INTO `gardening_results` VALUES (156, 1, 2, 2, 4503, 6, 12, 20); -- Buburimu Grape
INSERT INTO `gardening_results` VALUES (157, 1, 2, 2, 773, 1, 2, 20); -- Translucent Rock
INSERT INTO `gardening_results` VALUES (158, 1, 2, 3, 4098, 6, 12, 15); -- Wind Crystal
INSERT INTO `gardening_results` VALUES (159, 1, 2, 3, 4099, 6, 12, 15); -- Earth Crystal
INSERT INTO `gardening_results` VALUES (160, 1, 2, 3, 4390, 6, 12, 15); -- Mithran Tomato
INSERT INTO `gardening_results` VALUES (161, 1, 2, 3, 4431, 6, 12, 15); -- Bunch Of San dOrian Grapes
INSERT INTO `gardening_results` VALUES (162, 1, 2, 3, 4503, 6, 12, 10); -- Buburimu Grape
INSERT INTO `gardening_results` VALUES (163, 1, 2, 3, 4365, 6, 12, 10); -- Rolanberry
INSERT INTO `gardening_results` VALUES (164, 1, 2, 3, 773, 1, 2, 10); -- Translucent Rock
INSERT INTO `gardening_results` VALUES (165, 1, 2, 3, 772, 1, 2, 10); -- Green Rock
INSERT INTO `gardening_results` VALUES (166, 1, 2, 4, 4098, 6, 12, 15); -- Wind Crystal
INSERT INTO `gardening_results` VALUES (167, 1, 2, 4, 4100, 6, 12, 15); -- Lightning Crystal
INSERT INTO `gardening_results` VALUES (168, 1, 2, 4, 4390, 6, 12, 15); -- Mithran Tomato
INSERT INTO `gardening_results` VALUES (169, 1, 2, 4, 4389, 8, 16, 15); -- San dOrian Carrot
INSERT INTO `gardening_results` VALUES (170, 1, 2, 4, 4503, 6, 12, 10); -- Buburimu Grape
INSERT INTO `gardening_results` VALUES (171, 1, 2, 4, 4388, 8, 16, 10); -- Eggplant
INSERT INTO `gardening_results` VALUES (172, 1, 2, 4, 773, 1, 2, 10); -- Translucent Rock
INSERT INTO `gardening_results` VALUES (173, 1, 2, 4, 771, 1, 2, 10); -- Yellow Rock
INSERT INTO `gardening_results` VALUES (174, 1, 2, 5, 4098, 6, 12, 15); -- Wind Crystal
INSERT INTO `gardening_results` VALUES (175, 1, 2, 5, 4101, 6, 12, 10); -- Water Crystal
INSERT INTO `gardening_results` VALUES (176, 1, 2, 5, 4390, 6, 12, 15); -- Mithran Tomato
INSERT INTO `gardening_results` VALUES (177, 1, 2, 5, 4412, 6, 12, 10); -- Thundermelon
INSERT INTO `gardening_results` VALUES (178, 1, 2, 5, 4503, 6, 12, 10); -- Buburimu Grape
INSERT INTO `gardening_results` VALUES (179, 1, 2, 5, 4352, 6, 12, 10); -- Derfland Pear
INSERT INTO `gardening_results` VALUES (180, 1, 2, 5, 773, 1, 2, 10); -- Translucent Rock
INSERT INTO `gardening_results` VALUES (181, 1, 2, 5, 4450, 6, 12, 10); -- Coral Fungus
INSERT INTO `gardening_results` VALUES (182, 1, 2, 5, 774, 1, 2, 10); -- Purple Rock
INSERT INTO `gardening_results` VALUES (183, 1, 2, 6, 4098, 6, 12, 15); -- Wind Crystal
INSERT INTO `gardening_results` VALUES (184, 1, 2, 6, 17396, 12, 24, 10); -- Little Worm
INSERT INTO `gardening_results` VALUES (185, 1, 2, 6, 4390, 6, 12, 15); -- Mithran Tomato
INSERT INTO `gardening_results` VALUES (186, 1, 2, 6, 4096, 6, 12, 10); -- Fire Crystal
INSERT INTO `gardening_results` VALUES (187, 1, 2, 6, 4503, 6, 12, 10); -- Buburimu Grape
INSERT INTO `gardening_results` VALUES (188, 1, 2, 6, 4491, 6, 12, 10); -- Watermelon
INSERT INTO `gardening_results` VALUES (189, 1, 2, 6, 773, 1, 2, 10); -- Translucent Rock
INSERT INTO `gardening_results` VALUES (190, 1, 2, 6, 4432, 6, 12, 10); -- Kazham Pineapple
INSERT INTO `gardening_results` VALUES (191, 1, 2, 6, 770, 1, 2, 10); -- Blue Rock
INSERT INTO `gardening_results` VALUES (192, 1, 2, 7, 4098, 6, 12, 15); -- Wind Crystal
INSERT INTO `gardening_results` VALUES (193, 1, 2, 7, 4103, 6, 12, 15); -- Dark Crystal
INSERT INTO `gardening_results` VALUES (194, 1, 2, 7, 4390, 6, 12, 15); -- Mithran Tomato
INSERT INTO `gardening_results` VALUES (195, 1, 2, 7, 4363, 6, 12, 10); -- Faerie Apple
INSERT INTO `gardening_results` VALUES (196, 1, 2, 7, 4503, 6, 12, 10); -- Buburimu Grape
INSERT INTO `gardening_results` VALUES (197, 1, 2, 7, 4449, 1, 2, 15); -- Reishi Mushroom
INSERT INTO `gardening_results` VALUES (198, 1, 2, 7, 773, 1, 2, 10); -- Translucent Rock
INSERT INTO `gardening_results` VALUES (199, 1, 2, 7, 776, 1, 2, 10); -- White Rock
INSERT INTO `gardening_results` VALUES (200, 1, 2, 8, 4098, 6, 12, 15); -- Wind Crystal
INSERT INTO `gardening_results` VALUES (201, 1, 2, 8, 4102, 6, 12, 15); -- Light Crystal
INSERT INTO `gardening_results` VALUES (202, 1, 2, 8, 4390, 6, 12, 15); -- Mithran Tomato
INSERT INTO `gardening_results` VALUES (203, 1, 2, 8, 4392, 6, 12, 15); -- Saruta Orange
INSERT INTO `gardening_results` VALUES (204, 1, 2, 8, 4503, 6, 12, 10); -- Buburimu Grape
INSERT INTO `gardening_results` VALUES (205, 1, 2, 8, 4375, 6, 12, 10); -- Danceshroom
INSERT INTO `gardening_results` VALUES (206, 1, 2, 8, 773, 1, 2, 10); -- Translucent Rock
INSERT INTO `gardening_results` VALUES (207, 1, 2, 8, 775, 1, 2, 10); -- Black Rock
INSERT INTO `gardening_results` VALUES (208, 1, 3, 0, 936, 12, 24, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (209, 1, 3, 0, 4099, 6, 12, 15); -- Earth Crystal
INSERT INTO `gardening_results` VALUES (210, 1, 3, 0, 4449, 1, 2, 15); -- Reishi Mushroom
INSERT INTO `gardening_results` VALUES (211, 1, 3, 0, 4431, 6, 12, 15); -- Bunch Of San dOrian Grapes
INSERT INTO `gardening_results` VALUES (212, 1, 3, 0, 4468, 6, 12, 10); -- Pamamas
INSERT INTO `gardening_results` VALUES (213, 1, 3, 0, 4365, 6, 12, 10); -- Rolanberry
INSERT INTO `gardening_results` VALUES (214, 1, 3, 0, 770, 1, 2, 10); -- Blue Rock
INSERT INTO `gardening_results` VALUES (215, 1, 3, 0, 772, 1, 2, 10); -- Green Rock
INSERT INTO `gardening_results` VALUES (216, 1, 3, 1, 4097, 6, 12, 15); -- Ice Crystal
INSERT INTO `gardening_results` VALUES (217, 1, 3, 1, 4099, 6, 12, 15); -- Earth Crystal
INSERT INTO `gardening_results` VALUES (218, 1, 3, 1, 4392, 6, 12, 15); -- Saruta Orange
INSERT INTO `gardening_results` VALUES (219, 1, 3, 1, 4431, 6, 12, 15); -- Bunch Of San dOrian Grapes
INSERT INTO `gardening_results` VALUES (220, 1, 3, 1, 4445, 8, 16, 10); -- Yagudo Cherry
INSERT INTO `gardening_results` VALUES (221, 1, 3, 1, 4365, 6, 12, 10); -- Rolanberry
INSERT INTO `gardening_results` VALUES (222, 1, 3, 1, 769, 1, 2, 10); -- Red Rock
INSERT INTO `gardening_results` VALUES (223, 1, 3, 1, 772, 1, 2, 10); -- Green Rock
INSERT INTO `gardening_results` VALUES (224, 1, 3, 2, 4098, 6, 12, 15); -- Wind Crystal
INSERT INTO `gardening_results` VALUES (225, 1, 3, 2, 4099, 6, 12, 15); -- Earth Crystal
INSERT INTO `gardening_results` VALUES (226, 1, 3, 2, 4390, 6, 12, 15); -- Mithran Tomato
INSERT INTO `gardening_results` VALUES (227, 1, 3, 2, 4431, 6, 12, 15); -- Bunch Of San dOrian Grapes
INSERT INTO `gardening_results` VALUES (228, 1, 3, 2, 4503, 6, 12, 10); -- Buburimu Grape
INSERT INTO `gardening_results` VALUES (229, 1, 3, 2, 4365, 6, 12, 10); -- Rolanberry
INSERT INTO `gardening_results` VALUES (230, 1, 3, 2, 773, 1, 2, 10); -- Translucent Rock
INSERT INTO `gardening_results` VALUES (231, 1, 3, 2, 772, 1, 2, 10); -- Green Rock
INSERT INTO `gardening_results` VALUES (232, 1, 3, 3, 4099, 6, 12, 30); -- Earth Crystal
INSERT INTO `gardening_results` VALUES (233, 1, 3, 3, 4431, 6, 12, 30); -- Bunch Of San dOrian Grapes
INSERT INTO `gardening_results` VALUES (234, 1, 3, 3, 4365, 6, 12, 20); -- Rolanberry
INSERT INTO `gardening_results` VALUES (235, 1, 3, 3, 772, 1, 2, 20); -- Green Rock
INSERT INTO `gardening_results` VALUES (236, 1, 3, 4, 4099, 6, 12, 15); -- Earth Crystal
INSERT INTO `gardening_results` VALUES (237, 1, 3, 4, 4100, 6, 12, 15); -- Lightning Crystal
INSERT INTO `gardening_results` VALUES (238, 1, 3, 4, 4431, 6, 12, 15); -- Bunch Of San dOrian Grapes
INSERT INTO `gardening_results` VALUES (239, 1, 3, 4, 4389, 8, 16, 15); -- San dOrian Carrot
INSERT INTO `gardening_results` VALUES (240, 1, 3, 4, 4365, 6, 12, 10); -- Rolanberry
INSERT INTO `gardening_results` VALUES (241, 1, 3, 4, 4388, 8, 16, 10); -- Eggplant
INSERT INTO `gardening_results` VALUES (242, 1, 3, 4, 772, 1, 2, 10); -- Green Rock
INSERT INTO `gardening_results` VALUES (243, 1, 3, 4, 771, 1, 2, 10); -- Yellow Rock
INSERT INTO `gardening_results` VALUES (244, 1, 3, 5, 4099, 6, 12, 15); -- Earth Crystal
INSERT INTO `gardening_results` VALUES (245, 1, 3, 5, 4101, 6, 12, 10); -- Water Crystal
INSERT INTO `gardening_results` VALUES (246, 1, 3, 5, 4431, 6, 12, 15); -- Bunch Of San dOrian Grapes
INSERT INTO `gardening_results` VALUES (247, 1, 3, 5, 4412, 6, 12, 10); -- Thundermelon
INSERT INTO `gardening_results` VALUES (248, 1, 3, 5, 4365, 6, 12, 10); -- Rolanberry
INSERT INTO `gardening_results` VALUES (249, 1, 3, 5, 4352, 6, 12, 10); -- Derfland Pear
INSERT INTO `gardening_results` VALUES (250, 1, 3, 5, 772, 1, 2, 10); -- Green Rock
INSERT INTO `gardening_results` VALUES (251, 1, 3, 5, 4450, 6, 12, 10); -- Coral Fungus
INSERT INTO `gardening_results` VALUES (252, 1, 3, 5, 774, 1, 2, 10); -- Purple Rock
INSERT INTO `gardening_results` VALUES (253, 1, 3, 6, 4099, 6, 12, 15); -- Earth Crystal
INSERT INTO `gardening_results` VALUES (254, 1, 3, 6, 17396, 12, 24, 10); -- Little Worm
INSERT INTO `gardening_results` VALUES (255, 1, 3, 6, 4431, 6, 12, 15); -- Bunch Of San dOrian Grapes
INSERT INTO `gardening_results` VALUES (256, 1, 3, 6, 4096, 6, 12, 10); -- Fire Crystal
INSERT INTO `gardening_results` VALUES (257, 1, 3, 6, 4365, 6, 12, 10); -- Rolanberry
INSERT INTO `gardening_results` VALUES (258, 1, 3, 6, 4491, 6, 12, 10); -- Watermelon
INSERT INTO `gardening_results` VALUES (259, 1, 3, 6, 772, 1, 2, 10); -- Green Rock
INSERT INTO `gardening_results` VALUES (260, 1, 3, 6, 4432, 6, 12, 10); -- Kazham Pineapple
INSERT INTO `gardening_results` VALUES (261, 1, 3, 6, 770, 1, 2, 10); -- Blue Rock
INSERT INTO `gardening_results` VALUES (262, 1, 3, 7, 4099, 6, 12, 15); -- Earth Crystal
INSERT INTO `gardening_results` VALUES (263, 1, 3, 7, 4103, 6, 12, 15); -- Dark Crystal
INSERT INTO `gardening_results` VALUES (264, 1, 3, 7, 4431, 6, 12, 15); -- Bunch Of San dOrian Grapes
INSERT INTO `gardening_results` VALUES (265, 1, 3, 7, 4363, 6, 12, 10); -- Faerie Apple
INSERT INTO `gardening_results` VALUES (266, 1, 3, 7, 4365, 6, 12, 10); -- Rolanberry
INSERT INTO `gardening_results` VALUES (267, 1, 3, 7, 4449, 1, 2, 15); -- Reishi Mushroom
INSERT INTO `gardening_results` VALUES (268, 1, 3, 7, 772, 1, 2, 10); -- Green Rock
INSERT INTO `gardening_results` VALUES (269, 1, 3, 7, 776, 1, 2, 10); -- White Rock
INSERT INTO `gardening_results` VALUES (270, 1, 3, 8, 4099, 6, 12, 15); -- Earth Crystal
INSERT INTO `gardening_results` VALUES (271, 1, 3, 8, 4102, 6, 12, 15); -- Light Crystal
INSERT INTO `gardening_results` VALUES (272, 1, 3, 8, 4431, 6, 12, 15); -- Bunch Of San dOrian Grapes
INSERT INTO `gardening_results` VALUES (273, 1, 3, 8, 4392, 6, 12, 15); -- Saruta Orange
INSERT INTO `gardening_results` VALUES (274, 1, 3, 8, 4365, 6, 12, 10); -- Rolanberry
INSERT INTO `gardening_results` VALUES (275, 1, 3, 8, 4375, 6, 12, 10); -- Danceshroom
INSERT INTO `gardening_results` VALUES (276, 1, 3, 8, 772, 1, 2, 10); -- Green Rock
INSERT INTO `gardening_results` VALUES (277, 1, 3, 8, 775, 1, 2, 10); -- Black Rock
INSERT INTO `gardening_results` VALUES (278, 1, 4, 0, 936, 12, 24, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (279, 1, 4, 0, 4100, 6, 12, 15); -- Lightning Crystal
INSERT INTO `gardening_results` VALUES (280, 1, 4, 0, 4449, 1, 2, 15); -- Reishi Mushroom
INSERT INTO `gardening_results` VALUES (281, 1, 4, 0, 4389, 8, 16, 15); -- San dOrian Carrot
INSERT INTO `gardening_results` VALUES (282, 1, 4, 0, 4468, 6, 12, 10); -- Pamamas
INSERT INTO `gardening_results` VALUES (283, 1, 4, 0, 4388, 8, 16, 10); -- Eggplant
INSERT INTO `gardening_results` VALUES (284, 1, 4, 0, 770, 1, 2, 10); -- Blue Rock
INSERT INTO `gardening_results` VALUES (285, 1, 4, 0, 771, 1, 2, 10); -- Yellow Rock
INSERT INTO `gardening_results` VALUES (286, 1, 4, 1, 4097, 6, 12, 15); -- Ice Crystal
INSERT INTO `gardening_results` VALUES (287, 1, 4, 1, 4100, 6, 12, 15); -- Lightning Crystal
INSERT INTO `gardening_results` VALUES (288, 1, 4, 1, 4392, 6, 12, 15); -- Saruta Orange
INSERT INTO `gardening_results` VALUES (289, 1, 4, 1, 4389, 8, 16, 15); -- San dOrian Carrot
INSERT INTO `gardening_results` VALUES (290, 1, 4, 1, 4445, 8, 16, 10); -- Yagudo Cherry
INSERT INTO `gardening_results` VALUES (291, 1, 4, 1, 4388, 8, 16, 10); -- Eggplant
INSERT INTO `gardening_results` VALUES (292, 1, 4, 1, 769, 1, 2, 10); -- Red Rock
INSERT INTO `gardening_results` VALUES (293, 1, 4, 1, 771, 1, 2, 10); -- Yellow Rock
INSERT INTO `gardening_results` VALUES (294, 1, 4, 2, 4098, 6, 12, 15); -- Wind Crystal
INSERT INTO `gardening_results` VALUES (295, 1, 4, 2, 4100, 6, 12, 15); -- Lightning Crystal
INSERT INTO `gardening_results` VALUES (296, 1, 4, 2, 4390, 6, 12, 15); -- Mithran Tomato
INSERT INTO `gardening_results` VALUES (297, 1, 4, 2, 4389, 8, 16, 15); -- San dOrian Carrot
INSERT INTO `gardening_results` VALUES (298, 1, 4, 2, 4503, 6, 12, 10); -- Buburimu Grape
INSERT INTO `gardening_results` VALUES (299, 1, 4, 2, 4388, 8, 16, 10); -- Eggplant
INSERT INTO `gardening_results` VALUES (300, 1, 4, 2, 773, 1, 2, 10); -- Translucent Rock
INSERT INTO `gardening_results` VALUES (301, 1, 4, 2, 771, 1, 2, 10); -- Yellow Rock
INSERT INTO `gardening_results` VALUES (302, 1, 4, 3, 4099, 6, 12, 15); -- Earth Crystal
INSERT INTO `gardening_results` VALUES (303, 1, 4, 3, 4100, 6, 12, 15); -- Lightning Crystal
INSERT INTO `gardening_results` VALUES (304, 1, 4, 3, 4431, 6, 12, 15); -- Bunch Of San dOrian Grapes
INSERT INTO `gardening_results` VALUES (305, 1, 4, 3, 4389, 8, 16, 15); -- San dOrian Carrot
INSERT INTO `gardening_results` VALUES (306, 1, 4, 3, 4365, 6, 12, 10); -- Rolanberry
INSERT INTO `gardening_results` VALUES (307, 1, 4, 3, 4388, 8, 16, 10); -- Eggplant
INSERT INTO `gardening_results` VALUES (308, 1, 4, 3, 772, 1, 2, 10); -- Green Rock
INSERT INTO `gardening_results` VALUES (309, 1, 4, 3, 771, 1, 2, 10); -- Yellow Rock
INSERT INTO `gardening_results` VALUES (310, 1, 4, 4, 4100, 6, 12, 30); -- Lightning Crystal
INSERT INTO `gardening_results` VALUES (311, 1, 4, 4, 4389, 8, 16, 30); -- San dOrian Carrot
INSERT INTO `gardening_results` VALUES (312, 1, 4, 4, 4388, 8, 16, 20); -- Eggplant
INSERT INTO `gardening_results` VALUES (313, 1, 4, 4, 771, 1, 2, 20); -- Yellow Rock
INSERT INTO `gardening_results` VALUES (314, 1, 4, 5, 4100, 6, 12, 15); -- Lightning Crystal
INSERT INTO `gardening_results` VALUES (315, 1, 4, 5, 4101, 6, 12, 10); -- Water Crystal
INSERT INTO `gardening_results` VALUES (316, 1, 4, 5, 4389, 8, 16, 15); -- San dOrian Carrot
INSERT INTO `gardening_results` VALUES (317, 1, 4, 5, 4412, 6, 12, 10); -- Thundermelon
INSERT INTO `gardening_results` VALUES (318, 1, 4, 5, 4388, 8, 16, 10); -- Eggplant
INSERT INTO `gardening_results` VALUES (319, 1, 4, 5, 4352, 6, 12, 10); -- Derfland Pear
INSERT INTO `gardening_results` VALUES (320, 1, 4, 5, 771, 1, 2, 10); -- Yellow Rock
INSERT INTO `gardening_results` VALUES (321, 1, 4, 5, 4450, 6, 12, 10); -- Coral Fungus
INSERT INTO `gardening_results` VALUES (322, 1, 4, 5, 774, 1, 2, 10); -- Purple Rock
INSERT INTO `gardening_results` VALUES (323, 1, 4, 6, 4100, 6, 12, 15); -- Lightning Crystal
INSERT INTO `gardening_results` VALUES (324, 1, 4, 6, 17396, 12, 24, 10); -- Little Worm
INSERT INTO `gardening_results` VALUES (325, 1, 4, 6, 4389, 8, 16, 15); -- San dOrian Carrot
INSERT INTO `gardening_results` VALUES (326, 1, 4, 6, 4096, 6, 12, 10); -- Fire Crystal
INSERT INTO `gardening_results` VALUES (327, 1, 4, 6, 4388, 8, 16, 10); -- Eggplant
INSERT INTO `gardening_results` VALUES (328, 1, 4, 6, 4491, 6, 12, 10); -- Watermelon
INSERT INTO `gardening_results` VALUES (329, 1, 4, 6, 771, 1, 2, 10); -- Yellow Rock
INSERT INTO `gardening_results` VALUES (330, 1, 4, 6, 4432, 6, 12, 10); -- Kazham Pineapple
INSERT INTO `gardening_results` VALUES (331, 1, 4, 6, 770, 1, 2, 10); -- Blue Rock
INSERT INTO `gardening_results` VALUES (332, 1, 4, 7, 4100, 6, 12, 15); -- Lightning Crystal
INSERT INTO `gardening_results` VALUES (333, 1, 4, 7, 4103, 6, 12, 15); -- Dark Crystal
INSERT INTO `gardening_results` VALUES (334, 1, 4, 7, 4389, 8, 16, 15); -- San dOrian Carrot
INSERT INTO `gardening_results` VALUES (335, 1, 4, 7, 4363, 6, 12, 10); -- Faerie Apple
INSERT INTO `gardening_results` VALUES (336, 1, 4, 7, 4388, 8, 16, 10); -- Eggplant
INSERT INTO `gardening_results` VALUES (337, 1, 4, 7, 4449, 1, 2, 15); -- Reishi Mushroom
INSERT INTO `gardening_results` VALUES (338, 1, 4, 7, 771, 1, 2, 10); -- Yellow Rock
INSERT INTO `gardening_results` VALUES (339, 1, 4, 7, 776, 1, 2, 10); -- White Rock
INSERT INTO `gardening_results` VALUES (340, 1, 4, 8, 4100, 6, 12, 15); -- Lightning Crystal
INSERT INTO `gardening_results` VALUES (341, 1, 4, 8, 4102, 6, 12, 15); -- Light Crystal
INSERT INTO `gardening_results` VALUES (342, 1, 4, 8, 4389, 8, 16, 15); -- San dOrian Carrot
INSERT INTO `gardening_results` VALUES (343, 1, 4, 8, 4392, 6, 12, 15); -- Saruta Orange
INSERT INTO `gardening_results` VALUES (344, 1, 4, 8, 4388, 8, 16, 10); -- Eggplant
INSERT INTO `gardening_results` VALUES (345, 1, 4, 8, 4375, 6, 12, 10); -- Danceshroom
INSERT INTO `gardening_results` VALUES (346, 1, 4, 8, 771, 1, 2, 10); -- Yellow Rock
INSERT INTO `gardening_results` VALUES (347, 1, 4, 8, 775, 1, 2, 10); -- Black Rock
INSERT INTO `gardening_results` VALUES (348, 1, 5, 0, 936, 12, 24, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (349, 1, 5, 0, 4101, 6, 12, 10); -- Water Crystal
INSERT INTO `gardening_results` VALUES (350, 1, 5, 0, 4449, 1, 2, 15); -- Reishi Mushroom
INSERT INTO `gardening_results` VALUES (351, 1, 5, 0, 4412, 6, 12, 10); -- Thundermelon
INSERT INTO `gardening_results` VALUES (352, 1, 5, 0, 4468, 6, 12, 10); -- Pamamas
INSERT INTO `gardening_results` VALUES (353, 1, 5, 0, 4352, 6, 12, 10); -- Derfland Pear
INSERT INTO `gardening_results` VALUES (354, 1, 5, 0, 770, 1, 2, 10); -- Blue Rock
INSERT INTO `gardening_results` VALUES (355, 1, 5, 0, 4450, 6, 12, 10); -- Coral Fungus
INSERT INTO `gardening_results` VALUES (356, 1, 5, 0, 774, 1, 2, 10); -- Purple Rock
INSERT INTO `gardening_results` VALUES (357, 1, 5, 1, 4097, 6, 12, 15); -- Ice Crystal
INSERT INTO `gardening_results` VALUES (358, 1, 5, 1, 4101, 6, 12, 10); -- Water Crystal
INSERT INTO `gardening_results` VALUES (359, 1, 5, 1, 4392, 6, 12, 15); -- Saruta Orange
INSERT INTO `gardening_results` VALUES (360, 1, 5, 1, 4412, 6, 12, 10); -- Thundermelon
INSERT INTO `gardening_results` VALUES (361, 1, 5, 1, 4445, 8, 16, 10); -- Yagudo Cherry
INSERT INTO `gardening_results` VALUES (362, 1, 5, 1, 4352, 6, 12, 10); -- Derfland Pear
INSERT INTO `gardening_results` VALUES (363, 1, 5, 1, 769, 1, 2, 10); -- Red Rock
INSERT INTO `gardening_results` VALUES (364, 1, 5, 1, 4450, 6, 12, 10); -- Coral Fungus
INSERT INTO `gardening_results` VALUES (365, 1, 5, 1, 774, 1, 2, 10); -- Purple Rock
INSERT INTO `gardening_results` VALUES (366, 1, 5, 2, 4098, 6, 12, 15); -- Wind Crystal
INSERT INTO `gardening_results` VALUES (367, 1, 5, 2, 4101, 6, 12, 10); -- Water Crystal
INSERT INTO `gardening_results` VALUES (368, 1, 5, 2, 4390, 6, 12, 15); -- Mithran Tomato
INSERT INTO `gardening_results` VALUES (369, 1, 5, 2, 4412, 6, 12, 10); -- Thundermelon
INSERT INTO `gardening_results` VALUES (370, 1, 5, 2, 4503, 6, 12, 10); -- Buburimu Grape
INSERT INTO `gardening_results` VALUES (371, 1, 5, 2, 4352, 6, 12, 10); -- Derfland Pear
INSERT INTO `gardening_results` VALUES (372, 1, 5, 2, 773, 1, 2, 10); -- Translucent Rock
INSERT INTO `gardening_results` VALUES (373, 1, 5, 2, 4450, 6, 12, 10); -- Coral Fungus
INSERT INTO `gardening_results` VALUES (374, 1, 5, 2, 774, 1, 2, 10); -- Purple Rock
INSERT INTO `gardening_results` VALUES (375, 1, 5, 3, 4099, 6, 12, 15); -- Earth Crystal
INSERT INTO `gardening_results` VALUES (376, 1, 5, 3, 4101, 6, 12, 10); -- Water Crystal
INSERT INTO `gardening_results` VALUES (377, 1, 5, 3, 4431, 6, 12, 15); -- Bunch Of San dOrian Grapes
INSERT INTO `gardening_results` VALUES (378, 1, 5, 3, 4412, 6, 12, 10); -- Thundermelon
INSERT INTO `gardening_results` VALUES (379, 1, 5, 3, 4365, 6, 12, 10); -- Rolanberry
INSERT INTO `gardening_results` VALUES (380, 1, 5, 3, 4352, 6, 12, 10); -- Derfland Pear
INSERT INTO `gardening_results` VALUES (381, 1, 5, 3, 772, 1, 2, 10); -- Green Rock
INSERT INTO `gardening_results` VALUES (382, 1, 5, 3, 4450, 6, 12, 10); -- Coral Fungus
INSERT INTO `gardening_results` VALUES (383, 1, 5, 3, 774, 1, 2, 10); -- Purple Rock
INSERT INTO `gardening_results` VALUES (384, 1, 5, 4, 4100, 6, 12, 15); -- Lightning Crystal
INSERT INTO `gardening_results` VALUES (385, 1, 5, 4, 4101, 6, 12, 10); -- Water Crystal
INSERT INTO `gardening_results` VALUES (386, 1, 5, 4, 4389, 8, 16, 15); -- San dOrian Carrot
INSERT INTO `gardening_results` VALUES (387, 1, 5, 4, 4412, 6, 12, 10); -- Thundermelon
INSERT INTO `gardening_results` VALUES (388, 1, 5, 4, 4388, 8, 16, 10); -- Eggplant
INSERT INTO `gardening_results` VALUES (389, 1, 5, 4, 4352, 6, 12, 10); -- Derfland Pear
INSERT INTO `gardening_results` VALUES (390, 1, 5, 4, 771, 1, 2, 10); -- Yellow Rock
INSERT INTO `gardening_results` VALUES (391, 1, 5, 4, 4450, 6, 12, 10); -- Coral Fungus
INSERT INTO `gardening_results` VALUES (392, 1, 5, 4, 774, 1, 2, 10); -- Purple Rock
INSERT INTO `gardening_results` VALUES (393, 1, 5, 5, 4101, 6, 12, 20); -- Water Crystal
INSERT INTO `gardening_results` VALUES (394, 1, 5, 5, 4412, 6, 12, 20); -- Thundermelon
INSERT INTO `gardening_results` VALUES (395, 1, 5, 5, 4352, 6, 12, 20); -- Derfland Pear
INSERT INTO `gardening_results` VALUES (396, 1, 5, 5, 4450, 6, 12, 20); -- Coral Fungus
INSERT INTO `gardening_results` VALUES (397, 1, 5, 5, 774, 1, 2, 20); -- Purple Rock
INSERT INTO `gardening_results` VALUES (398, 1, 5, 6, 4101, 6, 12, 10); -- Water Crystal
INSERT INTO `gardening_results` VALUES (399, 1, 5, 6, 17396, 12, 24, 10); -- Little Worm
INSERT INTO `gardening_results` VALUES (400, 1, 5, 6, 4412, 6, 12, 10); -- Thundermelon
INSERT INTO `gardening_results` VALUES (401, 1, 5, 6, 4096, 6, 12, 10); -- Fire Crystal
INSERT INTO `gardening_results` VALUES (402, 1, 5, 6, 4352, 6, 12, 10); -- Derfland Pear
INSERT INTO `gardening_results` VALUES (403, 1, 5, 6, 4491, 6, 12, 10); -- Watermelon
INSERT INTO `gardening_results` VALUES (404, 1, 5, 6, 4450, 6, 12, 10); -- Coral Fungus
INSERT INTO `gardening_results` VALUES (405, 1, 5, 6, 4432, 6, 12, 10); -- Kazham Pineapple
INSERT INTO `gardening_results` VALUES (406, 1, 5, 6, 774, 1, 2, 10); -- Purple Rock
INSERT INTO `gardening_results` VALUES (407, 1, 5, 6, 770, 1, 2, 10); -- Blue Rock
INSERT INTO `gardening_results` VALUES (408, 1, 5, 7, 4101, 6, 12, 10); -- Water Crystal
INSERT INTO `gardening_results` VALUES (409, 1, 5, 7, 4103, 6, 12, 15); -- Dark Crystal
INSERT INTO `gardening_results` VALUES (410, 1, 5, 7, 4412, 6, 12, 10); -- Thundermelon
INSERT INTO `gardening_results` VALUES (411, 1, 5, 7, 4363, 6, 12, 10); -- Faerie Apple
INSERT INTO `gardening_results` VALUES (412, 1, 5, 7, 4352, 6, 12, 10); -- Derfland Pear
INSERT INTO `gardening_results` VALUES (413, 1, 5, 7, 4449, 1, 2, 15); -- Reishi Mushroom
INSERT INTO `gardening_results` VALUES (414, 1, 5, 7, 4450, 6, 12, 10); -- Coral Fungus
INSERT INTO `gardening_results` VALUES (415, 1, 5, 7, 776, 1, 2, 10); -- White Rock
INSERT INTO `gardening_results` VALUES (416, 1, 5, 7, 774, 1, 2, 10); -- Purple Rock
INSERT INTO `gardening_results` VALUES (417, 1, 5, 8, 4101, 6, 12, 10); -- Water Crystal
INSERT INTO `gardening_results` VALUES (418, 1, 5, 8, 4102, 6, 12, 15); -- Light Crystal
INSERT INTO `gardening_results` VALUES (419, 1, 5, 8, 4412, 6, 12, 10); -- Thundermelon
INSERT INTO `gardening_results` VALUES (420, 1, 5, 8, 4392, 6, 12, 15); -- Saruta Orange
INSERT INTO `gardening_results` VALUES (421, 1, 5, 8, 4352, 6, 12, 10); -- Derfland Pear
INSERT INTO `gardening_results` VALUES (422, 1, 5, 8, 4375, 6, 12, 10); -- Danceshroom
INSERT INTO `gardening_results` VALUES (423, 1, 5, 8, 4450, 6, 12, 10); -- Coral Fungus
INSERT INTO `gardening_results` VALUES (424, 1, 5, 8, 775, 1, 2, 10); -- Black Rock
INSERT INTO `gardening_results` VALUES (425, 1, 5, 8, 774, 1, 2, 10); -- Purple Rock
INSERT INTO `gardening_results` VALUES (426, 1, 6, 0, 936, 12, 24, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (427, 1, 6, 0, 17396, 12, 24, 10); -- Little Worm
INSERT INTO `gardening_results` VALUES (428, 1, 6, 0, 4449, 1, 2, 15); -- Reishi Mushroom
INSERT INTO `gardening_results` VALUES (429, 1, 6, 0, 4096, 6, 12, 10); -- Fire Crystal
INSERT INTO `gardening_results` VALUES (430, 1, 6, 0, 4468, 6, 12, 10); -- Pamamas
INSERT INTO `gardening_results` VALUES (431, 1, 6, 0, 4491, 6, 12, 10); -- Watermelon
INSERT INTO `gardening_results` VALUES (432, 1, 6, 0, 770, 1, 2, 20); -- Blue Rock
INSERT INTO `gardening_results` VALUES (433, 1, 6, 0, 4432, 6, 12, 10); -- Kazham Pineapple
INSERT INTO `gardening_results` VALUES (434, 1, 6, 1, 4097, 6, 12, 15); -- Ice Crystal
INSERT INTO `gardening_results` VALUES (435, 1, 6, 1, 17396, 12, 24, 10); -- Little Worm
INSERT INTO `gardening_results` VALUES (436, 1, 6, 1, 4392, 6, 12, 15); -- Saruta Orange
INSERT INTO `gardening_results` VALUES (437, 1, 6, 1, 4096, 6, 12, 10); -- Fire Crystal
INSERT INTO `gardening_results` VALUES (438, 1, 6, 1, 4445, 8, 16, 10); -- Yagudo Cherry
INSERT INTO `gardening_results` VALUES (439, 1, 6, 1, 4491, 6, 12, 10); -- Watermelon
INSERT INTO `gardening_results` VALUES (440, 1, 6, 1, 769, 1, 2, 10); -- Red Rock
INSERT INTO `gardening_results` VALUES (441, 1, 6, 1, 4432, 6, 12, 10); -- Kazham Pineapple
INSERT INTO `gardening_results` VALUES (442, 1, 6, 1, 770, 1, 2, 10); -- Blue Rock
INSERT INTO `gardening_results` VALUES (443, 1, 6, 2, 4098, 6, 12, 15); -- Wind Crystal
INSERT INTO `gardening_results` VALUES (444, 1, 6, 2, 17396, 12, 24, 10); -- Little Worm
INSERT INTO `gardening_results` VALUES (445, 1, 6, 2, 4390, 6, 12, 15); -- Mithran Tomato
INSERT INTO `gardening_results` VALUES (446, 1, 6, 2, 4096, 6, 12, 10); -- Fire Crystal
INSERT INTO `gardening_results` VALUES (447, 1, 6, 2, 4503, 6, 12, 10); -- Buburimu Grape
INSERT INTO `gardening_results` VALUES (448, 1, 6, 2, 4491, 6, 12, 10); -- Watermelon
INSERT INTO `gardening_results` VALUES (449, 1, 6, 2, 773, 1, 2, 10); -- Translucent Rock
INSERT INTO `gardening_results` VALUES (450, 1, 6, 2, 4432, 6, 12, 10); -- Kazham Pineapple
INSERT INTO `gardening_results` VALUES (451, 1, 6, 2, 770, 1, 2, 10); -- Blue Rock
INSERT INTO `gardening_results` VALUES (452, 1, 6, 3, 4099, 6, 12, 15); -- Earth Crystal
INSERT INTO `gardening_results` VALUES (453, 1, 6, 3, 17396, 12, 24, 10); -- Little Worm
INSERT INTO `gardening_results` VALUES (454, 1, 6, 3, 4431, 6, 12, 15); -- Bunch Of San dOrian Grapes
INSERT INTO `gardening_results` VALUES (455, 1, 6, 3, 4096, 6, 12, 10); -- Fire Crystal
INSERT INTO `gardening_results` VALUES (456, 1, 6, 3, 4365, 6, 12, 10); -- Rolanberry
INSERT INTO `gardening_results` VALUES (457, 1, 6, 3, 4491, 6, 12, 10); -- Watermelon
INSERT INTO `gardening_results` VALUES (458, 1, 6, 3, 772, 1, 2, 10); -- Green Rock
INSERT INTO `gardening_results` VALUES (459, 1, 6, 3, 4432, 6, 12, 10); -- Kazham Pineapple
INSERT INTO `gardening_results` VALUES (460, 1, 6, 3, 770, 1, 2, 10); -- Blue Rock
INSERT INTO `gardening_results` VALUES (461, 1, 6, 4, 4100, 6, 12, 15); -- Lightning Crystal
INSERT INTO `gardening_results` VALUES (462, 1, 6, 4, 17396, 12, 24, 10); -- Little Worm
INSERT INTO `gardening_results` VALUES (463, 1, 6, 4, 4389, 8, 16, 15); -- San dOrian Carrot
INSERT INTO `gardening_results` VALUES (464, 1, 6, 4, 4096, 6, 12, 10); -- Fire Crystal
INSERT INTO `gardening_results` VALUES (465, 1, 6, 4, 4388, 8, 16, 10); -- Eggplant
INSERT INTO `gardening_results` VALUES (466, 1, 6, 4, 4491, 6, 12, 10); -- Watermelon
INSERT INTO `gardening_results` VALUES (467, 1, 6, 4, 771, 1, 2, 10); -- Yellow Rock
INSERT INTO `gardening_results` VALUES (468, 1, 6, 4, 4432, 6, 12, 10); -- Kazham Pineapple
INSERT INTO `gardening_results` VALUES (469, 1, 6, 4, 770, 1, 2, 10); -- Blue Rock
INSERT INTO `gardening_results` VALUES (470, 1, 6, 5, 4101, 6, 12, 10); -- Water Crystal
INSERT INTO `gardening_results` VALUES (471, 1, 6, 5, 17396, 12, 24, 10); -- Little Worm
INSERT INTO `gardening_results` VALUES (472, 1, 6, 5, 4412, 6, 12, 10); -- Thundermelon
INSERT INTO `gardening_results` VALUES (473, 1, 6, 5, 4096, 6, 12, 10); -- Fire Crystal
INSERT INTO `gardening_results` VALUES (474, 1, 6, 5, 4352, 6, 12, 10); -- Derfland Pear
INSERT INTO `gardening_results` VALUES (475, 1, 6, 5, 4491, 6, 12, 10); -- Watermelon
INSERT INTO `gardening_results` VALUES (476, 1, 6, 5, 4450, 6, 12, 10); -- Coral Fungus
INSERT INTO `gardening_results` VALUES (477, 1, 6, 5, 4432, 6, 12, 10); -- Kazham Pineapple
INSERT INTO `gardening_results` VALUES (478, 1, 6, 5, 774, 1, 2, 10); -- Purple Rock
INSERT INTO `gardening_results` VALUES (479, 1, 6, 5, 770, 1, 2, 10); -- Blue Rock
INSERT INTO `gardening_results` VALUES (480, 1, 6, 6, 17396, 12, 24, 20); -- Little Worm
INSERT INTO `gardening_results` VALUES (481, 1, 6, 6, 4096, 6, 12, 20); -- Fire Crystal
INSERT INTO `gardening_results` VALUES (482, 1, 6, 6, 4491, 6, 12, 20); -- Watermelon
INSERT INTO `gardening_results` VALUES (483, 1, 6, 6, 4432, 6, 12, 20); -- Kazham Pineapple
INSERT INTO `gardening_results` VALUES (484, 1, 6, 6, 770, 1, 2, 20); -- Blue Rock
INSERT INTO `gardening_results` VALUES (485, 1, 6, 7, 17396, 12, 24, 10); -- Little Worm
INSERT INTO `gardening_results` VALUES (486, 1, 6, 7, 4103, 6, 12, 15); -- Dark Crystal
INSERT INTO `gardening_results` VALUES (487, 1, 6, 7, 4096, 6, 12, 10); -- Fire Crystal
INSERT INTO `gardening_results` VALUES (488, 1, 6, 7, 4363, 6, 12, 10); -- Faerie Apple
INSERT INTO `gardening_results` VALUES (489, 1, 6, 7, 4491, 6, 12, 10); -- Watermelon
INSERT INTO `gardening_results` VALUES (490, 1, 6, 7, 4449, 1, 2, 15); -- Reishi Mushroom
INSERT INTO `gardening_results` VALUES (491, 1, 6, 7, 4432, 6, 12, 10); -- Kazham Pineapple
INSERT INTO `gardening_results` VALUES (492, 1, 6, 7, 776, 1, 2, 10); -- White Rock
INSERT INTO `gardening_results` VALUES (493, 1, 6, 7, 770, 1, 2, 10); -- Blue Rock
INSERT INTO `gardening_results` VALUES (494, 1, 6, 8, 17396, 12, 24, 10); -- Little Worm
INSERT INTO `gardening_results` VALUES (495, 1, 6, 8, 4102, 6, 12, 15); -- Light Crystal
INSERT INTO `gardening_results` VALUES (496, 1, 6, 8, 4096, 6, 12, 10); -- Fire Crystal
INSERT INTO `gardening_results` VALUES (497, 1, 6, 8, 4392, 6, 12, 15); -- Saruta Orange
INSERT INTO `gardening_results` VALUES (498, 1, 6, 8, 4491, 6, 12, 10); -- Watermelon
INSERT INTO `gardening_results` VALUES (499, 1, 6, 8, 4375, 6, 12, 10); -- Danceshroom
INSERT INTO `gardening_results` VALUES (500, 1, 6, 8, 4432, 6, 12, 10); -- Kazham Pineapple
INSERT INTO `gardening_results` VALUES (501, 1, 6, 8, 775, 1, 2, 10); -- Black Rock
INSERT INTO `gardening_results` VALUES (502, 1, 6, 8, 770, 1, 2, 10); -- Blue Rock
INSERT INTO `gardening_results` VALUES (503, 1, 7, 0, 936, 12, 24, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (504, 1, 7, 0, 4103, 6, 12, 15); -- Dark Crystal
INSERT INTO `gardening_results` VALUES (505, 1, 7, 0, 4449, 1, 2, 30); -- Reishi Mushroom
INSERT INTO `gardening_results` VALUES (506, 1, 7, 0, 4363, 6, 12, 10); -- Faerie Apple
INSERT INTO `gardening_results` VALUES (507, 1, 7, 0, 4468, 6, 12, 10); -- Pamamas
INSERT INTO `gardening_results` VALUES (508, 1, 7, 0, 770, 1, 2, 10); -- Blue Rock
INSERT INTO `gardening_results` VALUES (509, 1, 7, 0, 776, 1, 2, 10); -- White Rock
INSERT INTO `gardening_results` VALUES (510, 1, 7, 1, 4097, 6, 12, 15); -- Ice Crystal
INSERT INTO `gardening_results` VALUES (511, 1, 7, 1, 4103, 6, 12, 15); -- Dark Crystal
INSERT INTO `gardening_results` VALUES (512, 1, 7, 1, 4392, 6, 12, 15); -- Saruta Orange
INSERT INTO `gardening_results` VALUES (513, 1, 7, 1, 4363, 6, 12, 10); -- Faerie Apple
INSERT INTO `gardening_results` VALUES (514, 1, 7, 1, 4445, 8, 16, 10); -- Yagudo Cherry
INSERT INTO `gardening_results` VALUES (515, 1, 7, 1, 4449, 1, 2, 15); -- Reishi Mushroom
INSERT INTO `gardening_results` VALUES (516, 1, 7, 1, 769, 1, 2, 10); -- Red Rock
INSERT INTO `gardening_results` VALUES (517, 1, 7, 1, 776, 1, 2, 10); -- White Rock
INSERT INTO `gardening_results` VALUES (518, 1, 7, 2, 4098, 6, 12, 15); -- Wind Crystal
INSERT INTO `gardening_results` VALUES (519, 1, 7, 2, 4103, 6, 12, 15); -- Dark Crystal
INSERT INTO `gardening_results` VALUES (520, 1, 7, 2, 4390, 6, 12, 15); -- Mithran Tomato
INSERT INTO `gardening_results` VALUES (521, 1, 7, 2, 4363, 6, 12, 10); -- Faerie Apple
INSERT INTO `gardening_results` VALUES (522, 1, 7, 2, 4503, 6, 12, 10); -- Buburimu Grape
INSERT INTO `gardening_results` VALUES (523, 1, 7, 2, 4449, 1, 2, 15); -- Reishi Mushroom
INSERT INTO `gardening_results` VALUES (524, 1, 7, 2, 773, 1, 2, 10); -- Translucent Rock
INSERT INTO `gardening_results` VALUES (525, 1, 7, 2, 776, 1, 2, 10); -- White Rock
INSERT INTO `gardening_results` VALUES (526, 1, 7, 3, 4099, 6, 12, 15); -- Earth Crystal
INSERT INTO `gardening_results` VALUES (527, 1, 7, 3, 4103, 6, 12, 15); -- Dark Crystal
INSERT INTO `gardening_results` VALUES (528, 1, 7, 3, 4431, 6, 12, 15); -- Bunch Of San dOrian Grapes
INSERT INTO `gardening_results` VALUES (529, 1, 7, 3, 4363, 6, 12, 10); -- Faerie Apple
INSERT INTO `gardening_results` VALUES (530, 1, 7, 3, 4365, 6, 12, 10); -- Rolanberry
INSERT INTO `gardening_results` VALUES (531, 1, 7, 3, 4449, 1, 2, 15); -- Reishi Mushroom
INSERT INTO `gardening_results` VALUES (532, 1, 7, 3, 772, 1, 2, 10); -- Green Rock
INSERT INTO `gardening_results` VALUES (533, 1, 7, 3, 776, 1, 2, 10); -- White Rock
INSERT INTO `gardening_results` VALUES (534, 1, 7, 4, 4100, 6, 12, 15); -- Lightning Crystal
INSERT INTO `gardening_results` VALUES (535, 1, 7, 4, 4103, 6, 12, 15); -- Dark Crystal
INSERT INTO `gardening_results` VALUES (536, 1, 7, 4, 4389, 8, 16, 15); -- San dOrian Carrot
INSERT INTO `gardening_results` VALUES (537, 1, 7, 4, 4363, 6, 12, 10); -- Faerie Apple
INSERT INTO `gardening_results` VALUES (538, 1, 7, 4, 4388, 8, 16, 10); -- Eggplant
INSERT INTO `gardening_results` VALUES (539, 1, 7, 4, 4449, 1, 2, 15); -- Reishi Mushroom
INSERT INTO `gardening_results` VALUES (540, 1, 7, 4, 771, 1, 2, 10); -- Yellow Rock
INSERT INTO `gardening_results` VALUES (541, 1, 7, 4, 776, 1, 2, 10); -- White Rock
INSERT INTO `gardening_results` VALUES (542, 1, 7, 5, 4101, 6, 12, 10); -- Water Crystal
INSERT INTO `gardening_results` VALUES (543, 1, 7, 5, 4103, 6, 12, 15); -- Dark Crystal
INSERT INTO `gardening_results` VALUES (544, 1, 7, 5, 4412, 6, 12, 10); -- Thundermelon
INSERT INTO `gardening_results` VALUES (545, 1, 7, 5, 4363, 6, 12, 10); -- Faerie Apple
INSERT INTO `gardening_results` VALUES (546, 1, 7, 5, 4352, 6, 12, 10); -- Derfland Pear
INSERT INTO `gardening_results` VALUES (547, 1, 7, 5, 4449, 1, 2, 15); -- Reishi Mushroom
INSERT INTO `gardening_results` VALUES (548, 1, 7, 5, 4450, 6, 12, 10); -- Coral Fungus
INSERT INTO `gardening_results` VALUES (549, 1, 7, 5, 776, 1, 2, 10); -- White Rock
INSERT INTO `gardening_results` VALUES (550, 1, 7, 5, 774, 1, 2, 10); -- Purple Rock
INSERT INTO `gardening_results` VALUES (551, 1, 7, 6, 17396, 12, 24, 10); -- Little Worm
INSERT INTO `gardening_results` VALUES (552, 1, 7, 6, 4103, 6, 12, 15); -- Dark Crystal
INSERT INTO `gardening_results` VALUES (553, 1, 7, 6, 4096, 6, 12, 10); -- Fire Crystal
INSERT INTO `gardening_results` VALUES (554, 1, 7, 6, 4363, 6, 12, 10); -- Faerie Apple
INSERT INTO `gardening_results` VALUES (555, 1, 7, 6, 4491, 6, 12, 10); -- Watermelon
INSERT INTO `gardening_results` VALUES (556, 1, 7, 6, 4449, 1, 2, 15); -- Reishi Mushroom
INSERT INTO `gardening_results` VALUES (557, 1, 7, 6, 4432, 6, 12, 10); -- Kazham Pineapple
INSERT INTO `gardening_results` VALUES (558, 1, 7, 6, 776, 1, 2, 10); -- White Rock
INSERT INTO `gardening_results` VALUES (559, 1, 7, 6, 770, 1, 2, 10); -- Blue Rock
INSERT INTO `gardening_results` VALUES (560, 1, 7, 7, 4103, 6, 12, 30); -- Dark Crystal
INSERT INTO `gardening_results` VALUES (561, 1, 7, 7, 4363, 6, 12, 20); -- Faerie Apple
INSERT INTO `gardening_results` VALUES (562, 1, 7, 7, 4449, 1, 2, 30); -- Reishi Mushroom
INSERT INTO `gardening_results` VALUES (563, 1, 7, 7, 776, 1, 2, 20); -- White Rock
INSERT INTO `gardening_results` VALUES (564, 1, 7, 8, 4103, 6, 12, 15); -- Dark Crystal
INSERT INTO `gardening_results` VALUES (565, 1, 7, 8, 4102, 6, 12, 15); -- Light Crystal
INSERT INTO `gardening_results` VALUES (566, 1, 7, 8, 4363, 6, 12, 10); -- Faerie Apple
INSERT INTO `gardening_results` VALUES (567, 1, 7, 8, 4392, 6, 12, 15); -- Saruta Orange
INSERT INTO `gardening_results` VALUES (568, 1, 7, 8, 4449, 1, 2, 15); -- Reishi Mushroom
INSERT INTO `gardening_results` VALUES (569, 1, 7, 8, 4375, 6, 12, 10); -- Danceshroom
INSERT INTO `gardening_results` VALUES (570, 1, 7, 8, 776, 1, 2, 10); -- White Rock
INSERT INTO `gardening_results` VALUES (571, 1, 7, 8, 775, 1, 2, 10); -- Black Rock
INSERT INTO `gardening_results` VALUES (572, 1, 8, 0, 936, 12, 24, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (573, 1, 8, 0, 4102, 6, 12, 15); -- Light Crystal
INSERT INTO `gardening_results` VALUES (574, 1, 8, 0, 4449, 1, 2, 15); -- Reishi Mushroom
INSERT INTO `gardening_results` VALUES (575, 1, 8, 0, 4392, 6, 12, 15); -- Saruta Orange
INSERT INTO `gardening_results` VALUES (576, 1, 8, 0, 4468, 6, 12, 10); -- Pamamas
INSERT INTO `gardening_results` VALUES (577, 1, 8, 0, 4375, 6, 12, 10); -- Danceshroom
INSERT INTO `gardening_results` VALUES (578, 1, 8, 0, 770, 1, 2, 10); -- Blue Rock
INSERT INTO `gardening_results` VALUES (579, 1, 8, 0, 775, 1, 2, 10); -- Black Rock
INSERT INTO `gardening_results` VALUES (580, 1, 8, 1, 4097, 6, 12, 15); -- Ice Crystal
INSERT INTO `gardening_results` VALUES (581, 1, 8, 1, 4102, 6, 12, 15); -- Light Crystal
INSERT INTO `gardening_results` VALUES (582, 1, 8, 1, 4392, 6, 12, 30); -- Saruta Orange
INSERT INTO `gardening_results` VALUES (583, 1, 8, 1, 4445, 8, 16, 10); -- Yagudo Cherry
INSERT INTO `gardening_results` VALUES (584, 1, 8, 1, 4375, 6, 12, 10); -- Danceshroom
INSERT INTO `gardening_results` VALUES (585, 1, 8, 1, 769, 1, 2, 10); -- Red Rock
INSERT INTO `gardening_results` VALUES (586, 1, 8, 1, 775, 1, 2, 10); -- Black Rock
INSERT INTO `gardening_results` VALUES (587, 1, 8, 2, 4098, 6, 12, 15); -- Wind Crystal
INSERT INTO `gardening_results` VALUES (588, 1, 8, 2, 4102, 6, 12, 15); -- Light Crystal
INSERT INTO `gardening_results` VALUES (589, 1, 8, 2, 4390, 6, 12, 15); -- Mithran Tomato
INSERT INTO `gardening_results` VALUES (590, 1, 8, 2, 4392, 6, 12, 15); -- Saruta Orange
INSERT INTO `gardening_results` VALUES (591, 1, 8, 2, 4503, 6, 12, 10); -- Buburimu Grape
INSERT INTO `gardening_results` VALUES (592, 1, 8, 2, 4375, 6, 12, 10); -- Danceshroom
INSERT INTO `gardening_results` VALUES (593, 1, 8, 2, 773, 1, 2, 10); -- Translucent Rock
INSERT INTO `gardening_results` VALUES (594, 1, 8, 2, 775, 1, 2, 10); -- Black Rock
INSERT INTO `gardening_results` VALUES (595, 1, 8, 3, 4099, 6, 12, 15); -- Earth Crystal
INSERT INTO `gardening_results` VALUES (596, 1, 8, 3, 4102, 6, 12, 15); -- Light Crystal
INSERT INTO `gardening_results` VALUES (597, 1, 8, 3, 4431, 6, 12, 15); -- Bunch Of San dOrian Grapes
INSERT INTO `gardening_results` VALUES (598, 1, 8, 3, 4392, 6, 12, 15); -- Saruta Orange
INSERT INTO `gardening_results` VALUES (599, 1, 8, 3, 4365, 6, 12, 10); -- Rolanberry
INSERT INTO `gardening_results` VALUES (600, 1, 8, 3, 4375, 6, 12, 10); -- Danceshroom
INSERT INTO `gardening_results` VALUES (601, 1, 8, 3, 772, 1, 2, 10); -- Green Rock
INSERT INTO `gardening_results` VALUES (602, 1, 8, 3, 775, 1, 2, 10); -- Black Rock
INSERT INTO `gardening_results` VALUES (603, 1, 8, 4, 4100, 6, 12, 15); -- Lightning Crystal
INSERT INTO `gardening_results` VALUES (604, 1, 8, 4, 4102, 6, 12, 15); -- Light Crystal
INSERT INTO `gardening_results` VALUES (605, 1, 8, 4, 4389, 8, 16, 15); -- San dOrian Carrot
INSERT INTO `gardening_results` VALUES (606, 1, 8, 4, 4392, 6, 12, 15); -- Saruta Orange
INSERT INTO `gardening_results` VALUES (607, 1, 8, 4, 4388, 8, 16, 10); -- Eggplant
INSERT INTO `gardening_results` VALUES (608, 1, 8, 4, 4375, 6, 12, 10); -- Danceshroom
INSERT INTO `gardening_results` VALUES (609, 1, 8, 4, 771, 1, 2, 10); -- Yellow Rock
INSERT INTO `gardening_results` VALUES (610, 1, 8, 4, 775, 1, 2, 10); -- Black Rock
INSERT INTO `gardening_results` VALUES (611, 1, 8, 5, 4101, 6, 12, 10); -- Water Crystal
INSERT INTO `gardening_results` VALUES (612, 1, 8, 5, 4102, 6, 12, 15); -- Light Crystal
INSERT INTO `gardening_results` VALUES (613, 1, 8, 5, 4412, 6, 12, 10); -- Thundermelon
INSERT INTO `gardening_results` VALUES (614, 1, 8, 5, 4392, 6, 12, 15); -- Saruta Orange
INSERT INTO `gardening_results` VALUES (615, 1, 8, 5, 4352, 6, 12, 10); -- Derfland Pear
INSERT INTO `gardening_results` VALUES (616, 1, 8, 5, 4375, 6, 12, 10); -- Danceshroom
INSERT INTO `gardening_results` VALUES (617, 1, 8, 5, 4450, 6, 12, 10); -- Coral Fungus
INSERT INTO `gardening_results` VALUES (618, 1, 8, 5, 775, 1, 2, 10); -- Black Rock
INSERT INTO `gardening_results` VALUES (619, 1, 8, 5, 774, 1, 2, 10); -- Purple Rock
INSERT INTO `gardening_results` VALUES (620, 1, 8, 6, 17396, 12, 24, 10); -- Little Worm
INSERT INTO `gardening_results` VALUES (621, 1, 8, 6, 4102, 6, 12, 15); -- Light Crystal
INSERT INTO `gardening_results` VALUES (622, 1, 8, 6, 4096, 6, 12, 10); -- Fire Crystal
INSERT INTO `gardening_results` VALUES (623, 1, 8, 6, 4392, 6, 12, 15); -- Saruta Orange
INSERT INTO `gardening_results` VALUES (624, 1, 8, 6, 4491, 6, 12, 10); -- Watermelon
INSERT INTO `gardening_results` VALUES (625, 1, 8, 6, 4375, 6, 12, 10); -- Danceshroom
INSERT INTO `gardening_results` VALUES (626, 1, 8, 6, 4432, 6, 12, 10); -- Kazham Pineapple
INSERT INTO `gardening_results` VALUES (627, 1, 8, 6, 775, 1, 2, 10); -- Black Rock
INSERT INTO `gardening_results` VALUES (628, 1, 8, 6, 770, 1, 2, 10); -- Blue Rock
INSERT INTO `gardening_results` VALUES (629, 1, 8, 7, 4103, 6, 12, 15); -- Dark Crystal
INSERT INTO `gardening_results` VALUES (630, 1, 8, 7, 4102, 6, 12, 15); -- Light Crystal
INSERT INTO `gardening_results` VALUES (631, 1, 8, 7, 4363, 6, 12, 10); -- Faerie Apple
INSERT INTO `gardening_results` VALUES (632, 1, 8, 7, 4392, 6, 12, 15); -- Saruta Orange
INSERT INTO `gardening_results` VALUES (633, 1, 8, 7, 4449, 1, 2, 15); -- Reishi Mushroom
INSERT INTO `gardening_results` VALUES (634, 1, 8, 7, 4375, 6, 12, 10); -- Danceshroom
INSERT INTO `gardening_results` VALUES (635, 1, 8, 7, 776, 1, 2, 10); -- White Rock
INSERT INTO `gardening_results` VALUES (636, 1, 8, 7, 775, 1, 2, 10); -- Black Rock
INSERT INTO `gardening_results` VALUES (637, 1, 8, 8, 4102, 6, 12, 30); -- Light Crystal
INSERT INTO `gardening_results` VALUES (638, 1, 8, 8, 4392, 6, 12, 30); -- Saruta Orange
INSERT INTO `gardening_results` VALUES (639, 1, 8, 8, 4375, 6, 12, 20); -- Danceshroom
INSERT INTO `gardening_results` VALUES (640, 1, 8, 8, 775, 1, 2, 20); -- Black Rock
INSERT INTO `gardening_results` VALUES (641, 2, 0, 0, 936, 12, 24, 30); -- Rock Salt
INSERT INTO `gardening_results` VALUES (642, 2, 0, 0, 957, 4, 8, 30); -- Amaryllis
INSERT INTO `gardening_results` VALUES (643, 2, 0, 0, 772, 1, 2, 20); -- Green Rock
INSERT INTO `gardening_results` VALUES (644, 2, 0, 0, 4386, 1, 2, 20); -- King Truffle
INSERT INTO `gardening_results` VALUES (645, 2, 1, 0, 4097, 4, 12, 40); -- Ice Crystal
INSERT INTO `gardening_results` VALUES (646, 2, 1, 0, 612, 12, 24, 30); -- Kazham Peppers
INSERT INTO `gardening_results` VALUES (647, 2, 1, 0, 5195, 4, 8, 30); -- Sprig Of Misareaux Parsley
INSERT INTO `gardening_results` VALUES (648, 2, 2, 0, 936, 12, 24, 30); -- Rock Salt
INSERT INTO `gardening_results` VALUES (649, 2, 2, 0, 4098, 4, 12, 20); -- Wind Crystal
INSERT INTO `gardening_results` VALUES (650, 2, 2, 0, 636, 4, 8, 20); -- Chamomile
INSERT INTO `gardening_results` VALUES (651, 2, 2, 0, 4374, 1, 5, 30); -- Sleepshroom
INSERT INTO `gardening_results` VALUES (652, 2, 3, 0, 17396, 12, 24, 30); -- Little Worm
INSERT INTO `gardening_results` VALUES (653, 2, 3, 0, 4099, 4, 12, 20); -- Earth Crystal
INSERT INTO `gardening_results` VALUES (654, 2, 3, 0, 638, 4, 8, 30); -- Sage
INSERT INTO `gardening_results` VALUES (655, 2, 3, 0, 772, 1, 2, 20); -- Green Rock
INSERT INTO `gardening_results` VALUES (656, 2, 4, 0, 4100, 4, 12, 40); -- Lightning Crystal
INSERT INTO `gardening_results` VALUES (657, 2, 4, 0, 948, 4, 8, 30); -- Carnation
INSERT INTO `gardening_results` VALUES (658, 2, 4, 0, 626, 4, 8, 30); -- Black Pepper
INSERT INTO `gardening_results` VALUES (659, 2, 5, 0, 4101, 4, 12, 40); -- Water Crystal
INSERT INTO `gardening_results` VALUES (660, 2, 5, 0, 614, 4, 8, 30); -- Mhaura Garlic
INSERT INTO `gardening_results` VALUES (661, 2, 5, 0, 4565, 1, 5, 30); -- Sobbing Fungus
INSERT INTO `gardening_results` VALUES (662, 2, 6, 0, 4096, 4, 12, 40); -- Fire Crystal
INSERT INTO `gardening_results` VALUES (663, 2, 6, 0, 623, 4, 8, 30); -- Bay Leaves
INSERT INTO `gardening_results` VALUES (664, 2, 6, 0, 1590, 1, 5, 30); -- Holy Basil
INSERT INTO `gardening_results` VALUES (665, 2, 7, 0, 4103, 4, 12, 40); -- Dark Crystal
INSERT INTO `gardening_results` VALUES (666, 2, 7, 0, 614, 6, 12, 30); -- Mhaura Garlic
INSERT INTO `gardening_results` VALUES (667, 2, 7, 0, 2112, 1, 5, 30); -- Vanilla
INSERT INTO `gardening_results` VALUES (668, 2, 8, 0, 4102, 4, 12, 40); -- Light Crystal
INSERT INTO `gardening_results` VALUES (669, 2, 8, 0, 957, 4, 8, 30); -- Amaryllis
INSERT INTO `gardening_results` VALUES (670, 2, 8, 0, 4566, 1, 2, 30); -- Deathball
INSERT INTO `gardening_results` VALUES (671, 3, 0, 0, 936, 12, 24, 30); -- Rock Salt
INSERT INTO `gardening_results` VALUES (672, 3, 0, 0, 958, 1, 5, 30); -- Marguerite
INSERT INTO `gardening_results` VALUES (673, 3, 0, 0, 769, 1, 2, 20); -- Red Rock
INSERT INTO `gardening_results` VALUES (674, 3, 0, 0, 4448, 1, 2, 20); -- Puffball
INSERT INTO `gardening_results` VALUES (675, 3, 1, 0, 17396, 12, 24, 30); -- Little Worm
INSERT INTO `gardening_results` VALUES (676, 3, 1, 0, 4097, 4, 12, 20); -- Ice Crystal
INSERT INTO `gardening_results` VALUES (677, 3, 1, 0, 620, 8, 16, 30); -- Tarutaru Rice
INSERT INTO `gardening_results` VALUES (678, 3, 1, 0, 769, 1, 2, 20); -- Red Rock
INSERT INTO `gardening_results` VALUES (679, 3, 2, 0, 4098, 4, 12, 60); -- Wind Crystal
INSERT INTO `gardening_results` VALUES (680, 3, 2, 0, 632, 12, 24, 40); -- Kukuru Bean
INSERT INTO `gardening_results` VALUES (681, 3, 3, 0, 4099, 4, 12, 60); -- Earth Crystal
INSERT INTO `gardening_results` VALUES (682, 3, 3, 0, 629, 12, 24, 40); -- Millioncorn
INSERT INTO `gardening_results` VALUES (683, 3, 4, 0, 4100, 4, 12, 60); -- Lightning Crystal
INSERT INTO `gardening_results` VALUES (684, 3, 4, 0, 620, 4, 8, 40); -- Tarutaru Rice
INSERT INTO `gardening_results` VALUES (685, 3, 5, 0, 4101, 4, 12, 40); -- Water Crystal
INSERT INTO `gardening_results` VALUES (686, 3, 5, 0, 958, 1, 5, 30); -- Marguerite
INSERT INTO `gardening_results` VALUES (687, 3, 5, 0, 4450, 1, 5, 30); -- Coral Fungus
INSERT INTO `gardening_results` VALUES (688, 3, 6, 0, 936, 12, 24, 30); -- Rock Salt
INSERT INTO `gardening_results` VALUES (689, 3, 6, 0, 4096, 4, 12, 40); -- Fire Crystal
INSERT INTO `gardening_results` VALUES (690, 3, 6, 0, 618, 12, 24, 30); -- Blue Peas
INSERT INTO `gardening_results` VALUES (691, 3, 7, 0, 4103, 4, 12, 60); -- Dark Crystal
INSERT INTO `gardening_results` VALUES (692, 3, 7, 0, 4505, 12, 24, 40); -- Sunflower Seeds
INSERT INTO `gardening_results` VALUES (693, 3, 8, 0, 4102, 4, 12, 40); -- Light Crystal
INSERT INTO `gardening_results` VALUES (694, 3, 8, 0, 620, 8, 16, 30); -- Tarutaru Rice
INSERT INTO `gardening_results` VALUES (695, 3, 8, 0, 4450, 1, 5, 30); -- Coral Fungus
INSERT INTO `gardening_results` VALUES (696, 4, 0, 0, 936, 12, 24, 30); -- Rock Salt
INSERT INTO `gardening_results` VALUES (697, 4, 0, 0, 949, 6, 12, 30); -- Rain Lily
INSERT INTO `gardening_results` VALUES (698, 4, 0, 0, 771, 1, 2, 20); -- Yellow Rock
INSERT INTO `gardening_results` VALUES (699, 4, 0, 0, 4373, 1, 2, 20); -- Woozyshroom
INSERT INTO `gardening_results` VALUES (700, 4, 1, 0, 4097, 4, 12, 40); -- Ice Crystal
INSERT INTO `gardening_results` VALUES (701, 4, 1, 0, 619, 8, 16, 30); -- Popoto
INSERT INTO `gardening_results` VALUES (702, 4, 1, 0, 5651, 1, 5, 30); -- Burdock
INSERT INTO `gardening_results` VALUES (703, 4, 2, 0, 4098, 4, 12, 60); -- Wind Crystal
INSERT INTO `gardening_results` VALUES (704, 4, 2, 0, 834, 1, 5, 40); -- Saruta Cotton
INSERT INTO `gardening_results` VALUES (705, 4, 3, 0, 936, 12, 24, 40); -- Rock Salt
INSERT INTO `gardening_results` VALUES (706, 4, 3, 0, 4099, 4, 12, 30); -- Earth Crystal
INSERT INTO `gardening_results` VALUES (707, 4, 3, 0, 4545, 6, 12, 30); -- Bunch Of Gysahl Greens
INSERT INTO `gardening_results` VALUES (708, 4, 4, 0, 17396, 12, 24, 30); -- Little Worm
INSERT INTO `gardening_results` VALUES (709, 4, 4, 0, 4100, 4, 12, 30); -- Lightning Crystal
INSERT INTO `gardening_results` VALUES (710, 4, 4, 0, 4382, 8, 16, 20); -- Frost Turnip
INSERT INTO `gardening_results` VALUES (711, 4, 4, 0, 771, 1, 2, 20); -- Yellow Rock
INSERT INTO `gardening_results` VALUES (712, 4, 5, 0, 4101, 4, 12, 60); -- Water Crystal
INSERT INTO `gardening_results` VALUES (713, 4, 5, 0, 4387, 1, 5, 40); -- Wild Onion
INSERT INTO `gardening_results` VALUES (714, 4, 6, 0, 4096, 4, 12, 40); -- Fire Crystal
INSERT INTO `gardening_results` VALUES (715, 4, 6, 0, 4366, 8, 16, 30); -- La Theine Cabbage
INSERT INTO `gardening_results` VALUES (716, 4, 6, 0, 5907, 1, 2, 30); -- Winterflower
INSERT INTO `gardening_results` VALUES (717, 4, 7, 0, 4103, 4, 12, 60); -- Dark Crystal
INSERT INTO `gardening_results` VALUES (718, 4, 7, 0, 617, 1, 5, 40); -- Ginger
INSERT INTO `gardening_results` VALUES (719, 4, 8, 0, 4102, 4, 12, 40); -- Light Crystal
INSERT INTO `gardening_results` VALUES (720, 4, 8, 0, 4373, 1, 2, 30); -- Woozyshroom
INSERT INTO `gardening_results` VALUES (721, 4, 8, 0, 4447, 1, 2, 30); -- Scream Fungus
INSERT INTO `gardening_results` VALUES (722, 5, 0, 0, 936, 24, 48, 84); -- Rock Salt
INSERT INTO `gardening_results` VALUES (723, 5, 0, 0, 646, 1, 2, 16); -- Adaman Ore
INSERT INTO `gardening_results` VALUES (724, 5, 0, 1, 936, 24, 48, 42); -- Rock Salt
INSERT INTO `gardening_results` VALUES (725, 5, 0, 1, 17396, 24, 48, 15); -- Little Worm
INSERT INTO `gardening_results` VALUES (726, 5, 0, 1, 646, 1, 2, 8); -- Adaman Ore
INSERT INTO `gardening_results` VALUES (727, 5, 0, 1, 4097, 12, 24, 15); -- Ice Crystal
INSERT INTO `gardening_results` VALUES (728, 5, 0, 1, 640, 8, 16, 10); -- Copper Ore
INSERT INTO `gardening_results` VALUES (729, 5, 0, 1, 769, 1, 5, 10); -- Red Rock
INSERT INTO `gardening_results` VALUES (730, 5, 0, 2, 936, 24, 48, 42); -- Rock Salt
INSERT INTO `gardening_results` VALUES (731, 5, 0, 2, 17396, 24, 48, 15); -- Little Worm
INSERT INTO `gardening_results` VALUES (732, 5, 0, 2, 646, 1, 2, 8); -- Adaman Ore
INSERT INTO `gardening_results` VALUES (733, 5, 0, 2, 4098, 12, 24, 15); -- Wind Crystal
INSERT INTO `gardening_results` VALUES (734, 5, 0, 2, 737, 1, 5, 10); -- Gold Ore
INSERT INTO `gardening_results` VALUES (735, 5, 0, 2, 773, 1, 5, 10); -- Translucent Rock
INSERT INTO `gardening_results` VALUES (736, 5, 0, 3, 936, 24, 48, 57); -- Rock Salt
INSERT INTO `gardening_results` VALUES (737, 5, 0, 3, 646, 1, 2, 8); -- Adaman Ore
INSERT INTO `gardening_results` VALUES (738, 5, 0, 3, 4099, 12, 24, 15); -- Earth Crystal
INSERT INTO `gardening_results` VALUES (739, 5, 0, 3, 641, 8, 16, 10); -- Tin Ore
INSERT INTO `gardening_results` VALUES (740, 5, 0, 3, 772, 1, 5, 10); -- Green Rock
INSERT INTO `gardening_results` VALUES (741, 5, 0, 4, 936, 24, 48, 57); -- Rock Salt
INSERT INTO `gardening_results` VALUES (742, 5, 0, 4, 646, 1, 2, 8); -- Adaman Ore
INSERT INTO `gardening_results` VALUES (743, 5, 0, 4, 4100, 12, 24, 15); -- Lightning Crystal
INSERT INTO `gardening_results` VALUES (744, 5, 0, 4, 643, 4, 12, 10); -- Iron Ore
INSERT INTO `gardening_results` VALUES (745, 5, 0, 4, 771, 1, 5, 10); -- Yellow Rock
INSERT INTO `gardening_results` VALUES (746, 5, 0, 5, 936, 24, 48, 57); -- Rock Salt
INSERT INTO `gardening_results` VALUES (747, 5, 0, 5, 646, 1, 2, 8); -- Adaman Ore
INSERT INTO `gardening_results` VALUES (748, 5, 0, 5, 4101, 12, 24, 15); -- Water Crystal
INSERT INTO `gardening_results` VALUES (749, 5, 0, 5, 736, 1, 5, 10); -- Silver Ore
INSERT INTO `gardening_results` VALUES (750, 5, 0, 5, 774, 1, 5, 10); -- Purple Rock
INSERT INTO `gardening_results` VALUES (751, 5, 0, 6, 936, 24, 48, 57); -- Rock Salt
INSERT INTO `gardening_results` VALUES (752, 5, 0, 6, 646, 1, 2, 8); -- Adaman Ore
INSERT INTO `gardening_results` VALUES (753, 5, 0, 6, 768, 12, 24, 15); -- Flint Stone
INSERT INTO `gardening_results` VALUES (754, 5, 0, 6, 4096, 12, 24, 10); -- Fire Crystal
INSERT INTO `gardening_results` VALUES (755, 5, 0, 6, 770, 1, 5, 10); -- Blue Rock
INSERT INTO `gardening_results` VALUES (756, 5, 0, 7, 936, 24, 48, 57); -- Rock Salt
INSERT INTO `gardening_results` VALUES (757, 5, 0, 7, 646, 1, 2, 8); -- Adaman Ore
INSERT INTO `gardening_results` VALUES (758, 5, 0, 7, 4103, 12, 24, 15); -- Dark Crystal
INSERT INTO `gardening_results` VALUES (759, 5, 0, 7, 642, 4, 12, 10); -- Zinc Ore
INSERT INTO `gardening_results` VALUES (760, 5, 0, 7, 776, 1, 5, 10); -- White Rock
INSERT INTO `gardening_results` VALUES (761, 5, 0, 8, 936, 24, 48, 52); -- Rock Salt
INSERT INTO `gardening_results` VALUES (762, 5, 0, 8, 646, 1, 2, 8); -- Adaman Ore
INSERT INTO `gardening_results` VALUES (763, 5, 0, 8, 4102, 12, 24, 10); -- Light Crystal
INSERT INTO `gardening_results` VALUES (764, 5, 0, 8, 845, 4, 8, 10); -- Black Chocobo Feather
INSERT INTO `gardening_results` VALUES (765, 5, 0, 8, 775, 1, 5, 10); -- Black Rock
INSERT INTO `gardening_results` VALUES (766, 5, 0, 8, 645, 1, 2, 10); -- Darksteel Ore
INSERT INTO `gardening_results` VALUES (767, 5, 1, 0, 936, 24, 48, 42); -- Rock Salt
INSERT INTO `gardening_results` VALUES (768, 5, 1, 0, 17396, 24, 48, 15); -- Little Worm
INSERT INTO `gardening_results` VALUES (769, 5, 1, 0, 646, 1, 2, 8); -- Adaman Ore
INSERT INTO `gardening_results` VALUES (770, 5, 1, 0, 4097, 12, 24, 15); -- Ice Crystal
INSERT INTO `gardening_results` VALUES (771, 5, 1, 0, 640, 8, 16, 10); -- Copper Ore
INSERT INTO `gardening_results` VALUES (772, 5, 1, 0, 769, 1, 5, 10); -- Red Rock
INSERT INTO `gardening_results` VALUES (773, 5, 1, 1, 17396, 24, 48, 30); -- Little Worm
INSERT INTO `gardening_results` VALUES (774, 5, 1, 1, 4097, 12, 24, 30); -- Ice Crystal
INSERT INTO `gardening_results` VALUES (775, 5, 1, 1, 640, 8, 16, 20); -- Copper Ore
INSERT INTO `gardening_results` VALUES (776, 5, 1, 1, 769, 1, 5, 20); -- Red Rock
INSERT INTO `gardening_results` VALUES (777, 5, 1, 2, 17396, 24, 48, 30); -- Little Worm
INSERT INTO `gardening_results` VALUES (778, 5, 1, 2, 4097, 12, 24, 15); -- Ice Crystal
INSERT INTO `gardening_results` VALUES (779, 5, 1, 2, 4098, 12, 24, 15); -- Wind Crystal
INSERT INTO `gardening_results` VALUES (780, 5, 1, 2, 640, 8, 16, 10); -- Copper Ore
INSERT INTO `gardening_results` VALUES (781, 5, 1, 2, 737, 1, 5, 10); -- Gold Ore
INSERT INTO `gardening_results` VALUES (782, 5, 1, 2, 769, 1, 5, 10); -- Red Rock
INSERT INTO `gardening_results` VALUES (783, 5, 1, 2, 773, 1, 5, 10); -- Translucent Rock
INSERT INTO `gardening_results` VALUES (784, 5, 1, 3, 17396, 24, 48, 15); -- Little Worm
INSERT INTO `gardening_results` VALUES (785, 5, 1, 3, 936, 24, 48, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (786, 5, 1, 3, 4097, 12, 24, 15); -- Ice Crystal
INSERT INTO `gardening_results` VALUES (787, 5, 1, 3, 4099, 12, 24, 15); -- Earth Crystal
INSERT INTO `gardening_results` VALUES (788, 5, 1, 3, 640, 8, 16, 10); -- Copper Ore
INSERT INTO `gardening_results` VALUES (789, 5, 1, 3, 641, 8, 16, 10); -- Tin Ore
INSERT INTO `gardening_results` VALUES (790, 5, 1, 3, 769, 1, 5, 10); -- Red Rock
INSERT INTO `gardening_results` VALUES (791, 5, 1, 3, 772, 1, 5, 10); -- Green Rock
INSERT INTO `gardening_results` VALUES (792, 5, 1, 4, 17396, 24, 48, 15); -- Little Worm
INSERT INTO `gardening_results` VALUES (793, 5, 1, 4, 936, 24, 48, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (794, 5, 1, 4, 4097, 12, 24, 15); -- Ice Crystal
INSERT INTO `gardening_results` VALUES (795, 5, 1, 4, 4100, 12, 24, 15); -- Lightning Crystal
INSERT INTO `gardening_results` VALUES (796, 5, 1, 4, 640, 8, 16, 10); -- Copper Ore
INSERT INTO `gardening_results` VALUES (797, 5, 1, 4, 643, 4, 12, 10); -- Iron Ore
INSERT INTO `gardening_results` VALUES (798, 5, 1, 4, 769, 1, 5, 10); -- Red Rock
INSERT INTO `gardening_results` VALUES (799, 5, 1, 4, 771, 1, 5, 10); -- Yellow Rock
INSERT INTO `gardening_results` VALUES (800, 5, 1, 5, 17396, 24, 48, 15); -- Little Worm
INSERT INTO `gardening_results` VALUES (801, 5, 1, 5, 936, 24, 48, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (802, 5, 1, 5, 4097, 12, 24, 15); -- Ice Crystal
INSERT INTO `gardening_results` VALUES (803, 5, 1, 5, 4101, 12, 24, 15); -- Water Crystal
INSERT INTO `gardening_results` VALUES (804, 5, 1, 5, 640, 8, 16, 10); -- Copper Ore
INSERT INTO `gardening_results` VALUES (805, 5, 1, 5, 736, 1, 5, 10); -- Silver Ore
INSERT INTO `gardening_results` VALUES (806, 5, 1, 5, 769, 1, 5, 10); -- Red Rock
INSERT INTO `gardening_results` VALUES (807, 5, 1, 5, 774, 1, 5, 10); -- Purple Rock
INSERT INTO `gardening_results` VALUES (808, 5, 1, 6, 17396, 24, 48, 15); -- Little Worm
INSERT INTO `gardening_results` VALUES (809, 5, 1, 6, 936, 24, 48, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (810, 5, 1, 6, 4097, 12, 24, 15); -- Ice Crystal
INSERT INTO `gardening_results` VALUES (811, 5, 1, 6, 768, 12, 24, 15); -- Flint Stone
INSERT INTO `gardening_results` VALUES (812, 5, 1, 6, 640, 8, 16, 10); -- Copper Ore
INSERT INTO `gardening_results` VALUES (813, 5, 1, 6, 4096, 12, 24, 10); -- Fire Crystal
INSERT INTO `gardening_results` VALUES (814, 5, 1, 6, 769, 1, 5, 10); -- Red Rock
INSERT INTO `gardening_results` VALUES (815, 5, 1, 6, 770, 1, 5, 10); -- Blue Rock
INSERT INTO `gardening_results` VALUES (816, 5, 1, 7, 17396, 24, 48, 15); -- Little Worm
INSERT INTO `gardening_results` VALUES (817, 5, 1, 7, 936, 24, 48, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (818, 5, 1, 7, 4097, 12, 24, 15); -- Ice Crystal
INSERT INTO `gardening_results` VALUES (819, 5, 1, 7, 4103, 12, 24, 15); -- Dark Crystal
INSERT INTO `gardening_results` VALUES (820, 5, 1, 7, 640, 8, 16, 10); -- Copper Ore
INSERT INTO `gardening_results` VALUES (821, 5, 1, 7, 642, 4, 12, 10); -- Zinc Ore
INSERT INTO `gardening_results` VALUES (822, 5, 1, 7, 769, 1, 5, 10); -- Red Rock
INSERT INTO `gardening_results` VALUES (823, 5, 1, 7, 776, 1, 5, 10); -- White Rock
INSERT INTO `gardening_results` VALUES (824, 5, 1, 8, 17396, 24, 48, 15); -- Little Worm
INSERT INTO `gardening_results` VALUES (825, 5, 1, 8, 936, 24, 48, 10); -- Rock Salt
INSERT INTO `gardening_results` VALUES (826, 5, 1, 8, 4097, 12, 24, 15); -- Ice Crystal
INSERT INTO `gardening_results` VALUES (827, 5, 1, 8, 4102, 12, 24, 10); -- Light Crystal
INSERT INTO `gardening_results` VALUES (828, 5, 1, 8, 640, 8, 16, 10); -- Copper Ore
INSERT INTO `gardening_results` VALUES (829, 5, 1, 8, 845, 4, 8, 10); -- Black Chocobo Feather
INSERT INTO `gardening_results` VALUES (830, 5, 1, 8, 769, 1, 5, 10); -- Red Rock
INSERT INTO `gardening_results` VALUES (831, 5, 1, 8, 775, 1, 5, 10); -- Black Rock
INSERT INTO `gardening_results` VALUES (832, 5, 1, 8, 645, 1, 2, 10); -- Darksteel Ore
INSERT INTO `gardening_results` VALUES (833, 5, 2, 0, 936, 24, 48, 42); -- Rock Salt
INSERT INTO `gardening_results` VALUES (834, 5, 2, 0, 17396, 24, 48, 15); -- Little Worm
INSERT INTO `gardening_results` VALUES (835, 5, 2, 0, 646, 1, 2, 8); -- Adaman Ore
INSERT INTO `gardening_results` VALUES (836, 5, 2, 0, 4098, 12, 24, 15); -- Wind Crystal
INSERT INTO `gardening_results` VALUES (837, 5, 2, 0, 737, 1, 5, 10); -- Gold Ore
INSERT INTO `gardening_results` VALUES (838, 5, 2, 0, 773, 1, 5, 10); -- Translucent Rock
INSERT INTO `gardening_results` VALUES (839, 5, 2, 1, 17396, 24, 48, 30); -- Little Worm
INSERT INTO `gardening_results` VALUES (840, 5, 2, 1, 4097, 12, 24, 15); -- Ice Crystal
INSERT INTO `gardening_results` VALUES (841, 5, 2, 1, 4098, 12, 24, 15); -- Wind Crystal
INSERT INTO `gardening_results` VALUES (842, 5, 2, 1, 640, 8, 16, 10); -- Copper Ore
INSERT INTO `gardening_results` VALUES (843, 5, 2, 1, 737, 1, 5, 10); -- Gold Ore
INSERT INTO `gardening_results` VALUES (844, 5, 2, 1, 769, 1, 5, 10); -- Red Rock
INSERT INTO `gardening_results` VALUES (845, 5, 2, 1, 773, 1, 5, 10); -- Translucent Rock
INSERT INTO `gardening_results` VALUES (846, 5, 2, 2, 17396, 24, 48, 30); -- Little Worm
INSERT INTO `gardening_results` VALUES (847, 5, 2, 2, 4098, 12, 24, 30); -- Wind Crystal
INSERT INTO `gardening_results` VALUES (848, 5, 2, 2, 737, 1, 5, 20); -- Gold Ore
INSERT INTO `gardening_results` VALUES (849, 5, 2, 2, 773, 1, 5, 20); -- Translucent Rock
INSERT INTO `gardening_results` VALUES (850, 5, 2, 3, 17396, 24, 48, 15); -- Little Worm
INSERT INTO `gardening_results` VALUES (851, 5, 2, 3, 936, 24, 48, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (852, 5, 2, 3, 4098, 12, 24, 15); -- Wind Crystal
INSERT INTO `gardening_results` VALUES (853, 5, 2, 3, 4099, 12, 24, 15); -- Earth Crystal
INSERT INTO `gardening_results` VALUES (854, 5, 2, 3, 737, 1, 5, 10); -- Gold Ore
INSERT INTO `gardening_results` VALUES (855, 5, 2, 3, 641, 8, 16, 10); -- Tin Ore
INSERT INTO `gardening_results` VALUES (856, 5, 2, 3, 773, 1, 5, 10); -- Translucent Rock
INSERT INTO `gardening_results` VALUES (857, 5, 2, 3, 772, 1, 5, 10); -- Green Rock
INSERT INTO `gardening_results` VALUES (858, 5, 2, 4, 17396, 24, 48, 15); -- Little Worm
INSERT INTO `gardening_results` VALUES (859, 5, 2, 4, 936, 24, 48, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (860, 5, 2, 4, 4098, 12, 24, 15); -- Wind Crystal
INSERT INTO `gardening_results` VALUES (861, 5, 2, 4, 4100, 12, 24, 15); -- Lightning Crystal
INSERT INTO `gardening_results` VALUES (862, 5, 2, 4, 737, 1, 5, 10); -- Gold Ore
INSERT INTO `gardening_results` VALUES (863, 5, 2, 4, 643, 4, 12, 10); -- Iron Ore
INSERT INTO `gardening_results` VALUES (864, 5, 2, 4, 773, 1, 5, 10); -- Translucent Rock
INSERT INTO `gardening_results` VALUES (865, 5, 2, 4, 771, 1, 5, 10); -- Yellow Rock
INSERT INTO `gardening_results` VALUES (866, 5, 2, 5, 17396, 24, 48, 15); -- Little Worm
INSERT INTO `gardening_results` VALUES (867, 5, 2, 5, 936, 24, 48, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (868, 5, 2, 5, 4098, 12, 24, 15); -- Wind Crystal
INSERT INTO `gardening_results` VALUES (869, 5, 2, 5, 4101, 12, 24, 15); -- Water Crystal
INSERT INTO `gardening_results` VALUES (870, 5, 2, 5, 737, 1, 5, 10); -- Gold Ore
INSERT INTO `gardening_results` VALUES (871, 5, 2, 5, 736, 1, 5, 10); -- Silver Ore
INSERT INTO `gardening_results` VALUES (872, 5, 2, 5, 773, 1, 5, 10); -- Translucent Rock
INSERT INTO `gardening_results` VALUES (873, 5, 2, 5, 774, 1, 5, 10); -- Purple Rock
INSERT INTO `gardening_results` VALUES (874, 5, 2, 6, 17396, 24, 48, 15); -- Little Worm
INSERT INTO `gardening_results` VALUES (875, 5, 2, 6, 936, 24, 48, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (876, 5, 2, 6, 4098, 12, 24, 15); -- Wind Crystal
INSERT INTO `gardening_results` VALUES (877, 5, 2, 6, 768, 12, 24, 15); -- Flint Stone
INSERT INTO `gardening_results` VALUES (878, 5, 2, 6, 737, 1, 5, 10); -- Gold Ore
INSERT INTO `gardening_results` VALUES (879, 5, 2, 6, 4096, 12, 24, 10); -- Fire Crystal
INSERT INTO `gardening_results` VALUES (880, 5, 2, 6, 773, 1, 5, 10); -- Translucent Rock
INSERT INTO `gardening_results` VALUES (881, 5, 2, 6, 770, 1, 5, 10); -- Blue Rock
INSERT INTO `gardening_results` VALUES (882, 5, 2, 7, 17396, 24, 48, 15); -- Little Worm
INSERT INTO `gardening_results` VALUES (883, 5, 2, 7, 936, 24, 48, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (884, 5, 2, 7, 4098, 12, 24, 15); -- Wind Crystal
INSERT INTO `gardening_results` VALUES (885, 5, 2, 7, 4103, 12, 24, 15); -- Dark Crystal
INSERT INTO `gardening_results` VALUES (886, 5, 2, 7, 737, 1, 5, 10); -- Gold Ore
INSERT INTO `gardening_results` VALUES (887, 5, 2, 7, 642, 4, 12, 10); -- Zinc Ore
INSERT INTO `gardening_results` VALUES (888, 5, 2, 7, 773, 1, 5, 10); -- Translucent Rock
INSERT INTO `gardening_results` VALUES (889, 5, 2, 7, 776, 1, 5, 10); -- White Rock
INSERT INTO `gardening_results` VALUES (890, 5, 2, 8, 17396, 24, 48, 15); -- Little Worm
INSERT INTO `gardening_results` VALUES (891, 5, 2, 8, 936, 24, 48, 10); -- Rock Salt
INSERT INTO `gardening_results` VALUES (892, 5, 2, 8, 4098, 12, 24, 15); -- Wind Crystal
INSERT INTO `gardening_results` VALUES (893, 5, 2, 8, 4102, 12, 24, 10); -- Light Crystal
INSERT INTO `gardening_results` VALUES (894, 5, 2, 8, 737, 1, 5, 10); -- Gold Ore
INSERT INTO `gardening_results` VALUES (895, 5, 2, 8, 845, 4, 8, 10); -- Black Chocobo Feather
INSERT INTO `gardening_results` VALUES (896, 5, 2, 8, 773, 1, 5, 10); -- Translucent Rock
INSERT INTO `gardening_results` VALUES (897, 5, 2, 8, 775, 1, 5, 10); -- Black Rock
INSERT INTO `gardening_results` VALUES (898, 5, 2, 8, 645, 1, 2, 10); -- Darksteel Ore
INSERT INTO `gardening_results` VALUES (899, 5, 3, 0, 936, 24, 48, 57); -- Rock Salt
INSERT INTO `gardening_results` VALUES (900, 5, 3, 0, 646, 1, 2, 8); -- Adaman Ore
INSERT INTO `gardening_results` VALUES (901, 5, 3, 0, 4099, 12, 24, 15); -- Earth Crystal
INSERT INTO `gardening_results` VALUES (902, 5, 3, 0, 641, 8, 16, 10); -- Tin Ore
INSERT INTO `gardening_results` VALUES (903, 5, 3, 0, 772, 1, 5, 10); -- Green Rock
INSERT INTO `gardening_results` VALUES (904, 5, 3, 1, 17396, 24, 48, 15); -- Little Worm
INSERT INTO `gardening_results` VALUES (905, 5, 3, 1, 936, 24, 48, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (906, 5, 3, 1, 4097, 12, 24, 15); -- Ice Crystal
INSERT INTO `gardening_results` VALUES (907, 5, 3, 1, 4099, 12, 24, 15); -- Earth Crystal
INSERT INTO `gardening_results` VALUES (908, 5, 3, 1, 640, 8, 16, 10); -- Copper Ore
INSERT INTO `gardening_results` VALUES (909, 5, 3, 1, 641, 8, 16, 10); -- Tin Ore
INSERT INTO `gardening_results` VALUES (910, 5, 3, 1, 769, 1, 5, 10); -- Red Rock
INSERT INTO `gardening_results` VALUES (911, 5, 3, 1, 772, 1, 5, 10); -- Green Rock
INSERT INTO `gardening_results` VALUES (912, 5, 3, 2, 17396, 24, 48, 15); -- Little Worm
INSERT INTO `gardening_results` VALUES (913, 5, 3, 2, 936, 24, 48, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (914, 5, 3, 2, 4098, 12, 24, 15); -- Wind Crystal
INSERT INTO `gardening_results` VALUES (915, 5, 3, 2, 4099, 12, 24, 15); -- Earth Crystal
INSERT INTO `gardening_results` VALUES (916, 5, 3, 2, 737, 1, 5, 10); -- Gold Ore
INSERT INTO `gardening_results` VALUES (917, 5, 3, 2, 641, 8, 16, 10); -- Tin Ore
INSERT INTO `gardening_results` VALUES (918, 5, 3, 2, 773, 1, 5, 10); -- Translucent Rock
INSERT INTO `gardening_results` VALUES (919, 5, 3, 2, 772, 1, 5, 10); -- Green Rock
INSERT INTO `gardening_results` VALUES (920, 5, 3, 3, 936, 24, 48, 30); -- Rock Salt
INSERT INTO `gardening_results` VALUES (921, 5, 3, 3, 4099, 12, 24, 30); -- Earth Crystal
INSERT INTO `gardening_results` VALUES (922, 5, 3, 3, 641, 8, 16, 20); -- Tin Ore
INSERT INTO `gardening_results` VALUES (923, 5, 3, 3, 772, 1, 5, 20); -- Green Rock
INSERT INTO `gardening_results` VALUES (924, 5, 3, 4, 936, 24, 48, 30); -- Rock Salt
INSERT INTO `gardening_results` VALUES (925, 5, 3, 4, 4099, 12, 24, 15); -- Earth Crystal
INSERT INTO `gardening_results` VALUES (926, 5, 3, 4, 4100, 12, 24, 15); -- Lightning Crystal
INSERT INTO `gardening_results` VALUES (927, 5, 3, 4, 641, 8, 16, 10); -- Tin Ore
INSERT INTO `gardening_results` VALUES (928, 5, 3, 4, 643, 4, 12, 10); -- Iron Ore
INSERT INTO `gardening_results` VALUES (929, 5, 3, 4, 772, 1, 5, 10); -- Green Rock
INSERT INTO `gardening_results` VALUES (930, 5, 3, 4, 771, 1, 5, 10); -- Yellow Rock
INSERT INTO `gardening_results` VALUES (931, 5, 3, 5, 936, 24, 48, 30); -- Rock Salt
INSERT INTO `gardening_results` VALUES (932, 5, 3, 5, 4099, 12, 24, 15); -- Earth Crystal
INSERT INTO `gardening_results` VALUES (933, 5, 3, 5, 4101, 12, 24, 15); -- Water Crystal
INSERT INTO `gardening_results` VALUES (934, 5, 3, 5, 641, 8, 16, 10); -- Tin Ore
INSERT INTO `gardening_results` VALUES (935, 5, 3, 5, 736, 1, 5, 10); -- Silver Ore
INSERT INTO `gardening_results` VALUES (936, 5, 3, 5, 772, 1, 5, 10); -- Green Rock
INSERT INTO `gardening_results` VALUES (937, 5, 3, 5, 774, 1, 5, 10); -- Purple Rock
INSERT INTO `gardening_results` VALUES (938, 5, 3, 6, 936, 24, 48, 30); -- Rock Salt
INSERT INTO `gardening_results` VALUES (939, 5, 3, 6, 4099, 12, 24, 15); -- Earth Crystal
INSERT INTO `gardening_results` VALUES (940, 5, 3, 6, 768, 12, 24, 15); -- Flint Stone
INSERT INTO `gardening_results` VALUES (941, 5, 3, 6, 641, 8, 16, 10); -- Tin Ore
INSERT INTO `gardening_results` VALUES (942, 5, 3, 6, 4096, 12, 24, 10); -- Fire Crystal
INSERT INTO `gardening_results` VALUES (943, 5, 3, 6, 772, 1, 5, 10); -- Green Rock
INSERT INTO `gardening_results` VALUES (944, 5, 3, 6, 770, 1, 5, 10); -- Blue Rock
INSERT INTO `gardening_results` VALUES (945, 5, 3, 7, 936, 24, 48, 30); -- Rock Salt
INSERT INTO `gardening_results` VALUES (946, 5, 3, 7, 4099, 12, 24, 15); -- Earth Crystal
INSERT INTO `gardening_results` VALUES (947, 5, 3, 7, 4103, 12, 24, 15); -- Dark Crystal
INSERT INTO `gardening_results` VALUES (948, 5, 3, 7, 641, 8, 16, 10); -- Tin Ore
INSERT INTO `gardening_results` VALUES (949, 5, 3, 7, 642, 4, 12, 10); -- Zinc Ore
INSERT INTO `gardening_results` VALUES (950, 5, 3, 7, 772, 1, 5, 10); -- Green Rock
INSERT INTO `gardening_results` VALUES (951, 5, 3, 7, 776, 1, 5, 10); -- White Rock
INSERT INTO `gardening_results` VALUES (952, 5, 3, 8, 936, 24, 48, 25); -- Rock Salt
INSERT INTO `gardening_results` VALUES (953, 5, 3, 8, 4099, 12, 24, 15); -- Earth Crystal
INSERT INTO `gardening_results` VALUES (954, 5, 3, 8, 4102, 12, 24, 10); -- Light Crystal
INSERT INTO `gardening_results` VALUES (955, 5, 3, 8, 641, 8, 16, 10); -- Tin Ore
INSERT INTO `gardening_results` VALUES (956, 5, 3, 8, 845, 4, 8, 10); -- Black Chocobo Feather
INSERT INTO `gardening_results` VALUES (957, 5, 3, 8, 772, 1, 5, 10); -- Green Rock
INSERT INTO `gardening_results` VALUES (958, 5, 3, 8, 775, 1, 5, 10); -- Black Rock
INSERT INTO `gardening_results` VALUES (959, 5, 3, 8, 645, 1, 2, 10); -- Darksteel Ore
INSERT INTO `gardening_results` VALUES (960, 5, 4, 0, 936, 24, 48, 57); -- Rock Salt
INSERT INTO `gardening_results` VALUES (961, 5, 4, 0, 646, 1, 2, 8); -- Adaman Ore
INSERT INTO `gardening_results` VALUES (962, 5, 4, 0, 4100, 12, 24, 15); -- Lightning Crystal
INSERT INTO `gardening_results` VALUES (963, 5, 4, 0, 643, 4, 12, 10); -- Iron Ore
INSERT INTO `gardening_results` VALUES (964, 5, 4, 0, 771, 1, 5, 10); -- Yellow Rock
INSERT INTO `gardening_results` VALUES (965, 5, 4, 1, 17396, 24, 48, 15); -- Little Worm
INSERT INTO `gardening_results` VALUES (966, 5, 4, 1, 936, 24, 48, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (967, 5, 4, 1, 4097, 12, 24, 15); -- Ice Crystal
INSERT INTO `gardening_results` VALUES (968, 5, 4, 1, 4100, 12, 24, 15); -- Lightning Crystal
INSERT INTO `gardening_results` VALUES (969, 5, 4, 1, 640, 8, 16, 10); -- Copper Ore
INSERT INTO `gardening_results` VALUES (970, 5, 4, 1, 643, 4, 12, 10); -- Iron Ore
INSERT INTO `gardening_results` VALUES (971, 5, 4, 1, 769, 1, 5, 10); -- Red Rock
INSERT INTO `gardening_results` VALUES (972, 5, 4, 1, 771, 1, 5, 10); -- Yellow Rock
INSERT INTO `gardening_results` VALUES (973, 5, 4, 2, 17396, 24, 48, 15); -- Little Worm
INSERT INTO `gardening_results` VALUES (974, 5, 4, 2, 936, 24, 48, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (975, 5, 4, 2, 4098, 12, 24, 15); -- Wind Crystal
INSERT INTO `gardening_results` VALUES (976, 5, 4, 2, 4100, 12, 24, 15); -- Lightning Crystal
INSERT INTO `gardening_results` VALUES (977, 5, 4, 2, 737, 1, 5, 10); -- Gold Ore
INSERT INTO `gardening_results` VALUES (978, 5, 4, 2, 643, 4, 12, 10); -- Iron Ore
INSERT INTO `gardening_results` VALUES (979, 5, 4, 2, 773, 1, 5, 10); -- Translucent Rock
INSERT INTO `gardening_results` VALUES (980, 5, 4, 2, 771, 1, 5, 10); -- Yellow Rock
INSERT INTO `gardening_results` VALUES (981, 5, 4, 3, 936, 24, 48, 30); -- Rock Salt
INSERT INTO `gardening_results` VALUES (982, 5, 4, 3, 4099, 12, 24, 15); -- Earth Crystal
INSERT INTO `gardening_results` VALUES (983, 5, 4, 3, 4100, 12, 24, 15); -- Lightning Crystal
INSERT INTO `gardening_results` VALUES (984, 5, 4, 3, 641, 8, 16, 10); -- Tin Ore
INSERT INTO `gardening_results` VALUES (985, 5, 4, 3, 643, 4, 12, 10); -- Iron Ore
INSERT INTO `gardening_results` VALUES (986, 5, 4, 3, 772, 1, 5, 10); -- Green Rock
INSERT INTO `gardening_results` VALUES (987, 5, 4, 3, 771, 1, 5, 10); -- Yellow Rock
INSERT INTO `gardening_results` VALUES (988, 5, 4, 4, 936, 24, 48, 30); -- Rock Salt
INSERT INTO `gardening_results` VALUES (989, 5, 4, 4, 4100, 12, 24, 30); -- Lightning Crystal
INSERT INTO `gardening_results` VALUES (990, 5, 4, 4, 643, 4, 12, 20); -- Iron Ore
INSERT INTO `gardening_results` VALUES (991, 5, 4, 4, 771, 1, 5, 20); -- Yellow Rock
INSERT INTO `gardening_results` VALUES (992, 5, 4, 5, 936, 24, 48, 30); -- Rock Salt
INSERT INTO `gardening_results` VALUES (993, 5, 4, 5, 4100, 12, 24, 15); -- Lightning Crystal
INSERT INTO `gardening_results` VALUES (994, 5, 4, 5, 4101, 12, 24, 15); -- Water Crystal
INSERT INTO `gardening_results` VALUES (995, 5, 4, 5, 643, 4, 12, 10); -- Iron Ore
INSERT INTO `gardening_results` VALUES (996, 5, 4, 5, 736, 1, 5, 10); -- Silver Ore
INSERT INTO `gardening_results` VALUES (997, 5, 4, 5, 771, 1, 5, 10); -- Yellow Rock
INSERT INTO `gardening_results` VALUES (998, 5, 4, 5, 774, 1, 5, 10); -- Purple Rock
INSERT INTO `gardening_results` VALUES (999, 5, 4, 6, 936, 24, 48, 30); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1000, 5, 4, 6, 4100, 12, 24, 15); -- Lightning Crystal
INSERT INTO `gardening_results` VALUES (1001, 5, 4, 6, 768, 12, 24, 15); -- Flint Stone
INSERT INTO `gardening_results` VALUES (1002, 5, 4, 6, 643, 4, 12, 10); -- Iron Ore
INSERT INTO `gardening_results` VALUES (1003, 5, 4, 6, 4096, 12, 24, 10); -- Fire Crystal
INSERT INTO `gardening_results` VALUES (1004, 5, 4, 6, 771, 1, 5, 10); -- Yellow Rock
INSERT INTO `gardening_results` VALUES (1005, 5, 4, 6, 770, 1, 5, 10); -- Blue Rock
INSERT INTO `gardening_results` VALUES (1006, 5, 4, 7, 936, 24, 48, 30); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1007, 5, 4, 7, 4100, 12, 24, 15); -- Lightning Crystal
INSERT INTO `gardening_results` VALUES (1008, 5, 4, 7, 4103, 12, 24, 15); -- Dark Crystal
INSERT INTO `gardening_results` VALUES (1009, 5, 4, 7, 643, 4, 12, 10); -- Iron Ore
INSERT INTO `gardening_results` VALUES (1010, 5, 4, 7, 642, 4, 12, 10); -- Zinc Ore
INSERT INTO `gardening_results` VALUES (1011, 5, 4, 7, 771, 1, 5, 10); -- Yellow Rock
INSERT INTO `gardening_results` VALUES (1012, 5, 4, 7, 776, 1, 5, 10); -- White Rock
INSERT INTO `gardening_results` VALUES (1013, 5, 4, 8, 936, 24, 48, 25); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1014, 5, 4, 8, 4100, 12, 24, 15); -- Lightning Crystal
INSERT INTO `gardening_results` VALUES (1015, 5, 4, 8, 4102, 12, 24, 10); -- Light Crystal
INSERT INTO `gardening_results` VALUES (1016, 5, 4, 8, 643, 4, 12, 10); -- Iron Ore
INSERT INTO `gardening_results` VALUES (1017, 5, 4, 8, 845, 4, 8, 10); -- Black Chocobo Feather
INSERT INTO `gardening_results` VALUES (1018, 5, 4, 8, 771, 1, 5, 10); -- Yellow Rock
INSERT INTO `gardening_results` VALUES (1019, 5, 4, 8, 775, 1, 5, 10); -- Black Rock
INSERT INTO `gardening_results` VALUES (1020, 5, 4, 8, 645, 1, 2, 10); -- Darksteel Ore
INSERT INTO `gardening_results` VALUES (1021, 5, 5, 0, 936, 24, 48, 57); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1022, 5, 5, 0, 646, 1, 2, 8); -- Adaman Ore
INSERT INTO `gardening_results` VALUES (1023, 5, 5, 0, 4101, 12, 24, 15); -- Water Crystal
INSERT INTO `gardening_results` VALUES (1024, 5, 5, 0, 736, 1, 5, 10); -- Silver Ore
INSERT INTO `gardening_results` VALUES (1025, 5, 5, 0, 774, 1, 5, 10); -- Purple Rock
INSERT INTO `gardening_results` VALUES (1026, 5, 5, 1, 17396, 24, 48, 15); -- Little Worm
INSERT INTO `gardening_results` VALUES (1027, 5, 5, 1, 936, 24, 48, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1028, 5, 5, 1, 4097, 12, 24, 15); -- Ice Crystal
INSERT INTO `gardening_results` VALUES (1029, 5, 5, 1, 4101, 12, 24, 15); -- Water Crystal
INSERT INTO `gardening_results` VALUES (1030, 5, 5, 1, 640, 8, 16, 10); -- Copper Ore
INSERT INTO `gardening_results` VALUES (1031, 5, 5, 1, 736, 1, 5, 10); -- Silver Ore
INSERT INTO `gardening_results` VALUES (1032, 5, 5, 1, 769, 1, 5, 10); -- Red Rock
INSERT INTO `gardening_results` VALUES (1033, 5, 5, 1, 774, 1, 5, 10); -- Purple Rock
INSERT INTO `gardening_results` VALUES (1034, 5, 5, 2, 17396, 24, 48, 15); -- Little Worm
INSERT INTO `gardening_results` VALUES (1035, 5, 5, 2, 936, 24, 48, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1036, 5, 5, 2, 4098, 12, 24, 15); -- Wind Crystal
INSERT INTO `gardening_results` VALUES (1037, 5, 5, 2, 4101, 12, 24, 15); -- Water Crystal
INSERT INTO `gardening_results` VALUES (1038, 5, 5, 2, 737, 1, 5, 10); -- Gold Ore
INSERT INTO `gardening_results` VALUES (1039, 5, 5, 2, 736, 1, 5, 10); -- Silver Ore
INSERT INTO `gardening_results` VALUES (1040, 5, 5, 2, 773, 1, 5, 10); -- Translucent Rock
INSERT INTO `gardening_results` VALUES (1041, 5, 5, 2, 774, 1, 5, 10); -- Purple Rock
INSERT INTO `gardening_results` VALUES (1042, 5, 5, 3, 936, 24, 48, 30); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1043, 5, 5, 3, 4099, 12, 24, 15); -- Earth Crystal
INSERT INTO `gardening_results` VALUES (1044, 5, 5, 3, 4101, 12, 24, 15); -- Water Crystal
INSERT INTO `gardening_results` VALUES (1045, 5, 5, 3, 641, 8, 16, 10); -- Tin Ore
INSERT INTO `gardening_results` VALUES (1046, 5, 5, 3, 736, 1, 5, 10); -- Silver Ore
INSERT INTO `gardening_results` VALUES (1047, 5, 5, 3, 772, 1, 5, 10); -- Green Rock
INSERT INTO `gardening_results` VALUES (1048, 5, 5, 3, 774, 1, 5, 10); -- Purple Rock
INSERT INTO `gardening_results` VALUES (1049, 5, 5, 4, 936, 24, 48, 30); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1050, 5, 5, 4, 4100, 12, 24, 15); -- Lightning Crystal
INSERT INTO `gardening_results` VALUES (1051, 5, 5, 4, 4101, 12, 24, 15); -- Water Crystal
INSERT INTO `gardening_results` VALUES (1052, 5, 5, 4, 643, 4, 12, 10); -- Iron Ore
INSERT INTO `gardening_results` VALUES (1053, 5, 5, 4, 736, 1, 5, 10); -- Silver Ore
INSERT INTO `gardening_results` VALUES (1054, 5, 5, 4, 771, 1, 5, 10); -- Yellow Rock
INSERT INTO `gardening_results` VALUES (1055, 5, 5, 4, 774, 1, 5, 10); -- Purple Rock
INSERT INTO `gardening_results` VALUES (1056, 5, 5, 5, 936, 24, 48, 30); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1057, 5, 5, 5, 4101, 12, 24, 30); -- Water Crystal
INSERT INTO `gardening_results` VALUES (1058, 5, 5, 5, 736, 1, 5, 20); -- Silver Ore
INSERT INTO `gardening_results` VALUES (1059, 5, 5, 5, 774, 1, 5, 20); -- Purple Rock
INSERT INTO `gardening_results` VALUES (1060, 5, 5, 6, 936, 24, 48, 30); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1061, 5, 5, 6, 4101, 12, 24, 15); -- Water Crystal
INSERT INTO `gardening_results` VALUES (1062, 5, 5, 6, 768, 12, 24, 15); -- Flint Stone
INSERT INTO `gardening_results` VALUES (1063, 5, 5, 6, 736, 1, 5, 10); -- Silver Ore
INSERT INTO `gardening_results` VALUES (1064, 5, 5, 6, 4096, 12, 24, 10); -- Fire Crystal
INSERT INTO `gardening_results` VALUES (1065, 5, 5, 6, 774, 1, 5, 10); -- Purple Rock
INSERT INTO `gardening_results` VALUES (1066, 5, 5, 6, 770, 1, 5, 10); -- Blue Rock
INSERT INTO `gardening_results` VALUES (1067, 5, 5, 7, 936, 24, 48, 30); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1068, 5, 5, 7, 4101, 12, 24, 15); -- Water Crystal
INSERT INTO `gardening_results` VALUES (1069, 5, 5, 7, 4103, 12, 24, 15); -- Dark Crystal
INSERT INTO `gardening_results` VALUES (1070, 5, 5, 7, 736, 1, 5, 10); -- Silver Ore
INSERT INTO `gardening_results` VALUES (1071, 5, 5, 7, 642, 4, 12, 10); -- Zinc Ore
INSERT INTO `gardening_results` VALUES (1072, 5, 5, 7, 774, 1, 5, 10); -- Purple Rock
INSERT INTO `gardening_results` VALUES (1073, 5, 5, 7, 776, 1, 5, 10); -- White Rock
INSERT INTO `gardening_results` VALUES (1074, 5, 5, 8, 936, 24, 48, 25); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1075, 5, 5, 8, 4101, 12, 24, 15); -- Water Crystal
INSERT INTO `gardening_results` VALUES (1076, 5, 5, 8, 4102, 12, 24, 10); -- Light Crystal
INSERT INTO `gardening_results` VALUES (1077, 5, 5, 8, 736, 1, 5, 10); -- Silver Ore
INSERT INTO `gardening_results` VALUES (1078, 5, 5, 8, 845, 4, 8, 10); -- Black Chocobo Feather
INSERT INTO `gardening_results` VALUES (1079, 5, 5, 8, 774, 1, 5, 10); -- Purple Rock
INSERT INTO `gardening_results` VALUES (1080, 5, 5, 8, 775, 1, 5, 10); -- Black Rock
INSERT INTO `gardening_results` VALUES (1081, 5, 5, 8, 645, 1, 2, 10); -- Darksteel Ore
INSERT INTO `gardening_results` VALUES (1082, 5, 6, 0, 936, 24, 48, 57); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1083, 5, 6, 0, 646, 1, 2, 8); -- Adaman Ore
INSERT INTO `gardening_results` VALUES (1084, 5, 6, 0, 768, 12, 24, 15); -- Flint Stone
INSERT INTO `gardening_results` VALUES (1085, 5, 6, 0, 4096, 12, 24, 10); -- Fire Crystal
INSERT INTO `gardening_results` VALUES (1086, 5, 6, 0, 770, 1, 5, 10); -- Blue Rock
INSERT INTO `gardening_results` VALUES (1087, 5, 6, 1, 17396, 24, 48, 15); -- Little Worm
INSERT INTO `gardening_results` VALUES (1088, 5, 6, 1, 936, 24, 48, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1089, 5, 6, 1, 4097, 12, 24, 15); -- Ice Crystal
INSERT INTO `gardening_results` VALUES (1090, 5, 6, 1, 768, 12, 24, 15); -- Flint Stone
INSERT INTO `gardening_results` VALUES (1091, 5, 6, 1, 640, 8, 16, 10); -- Copper Ore
INSERT INTO `gardening_results` VALUES (1092, 5, 6, 1, 4096, 12, 24, 10); -- Fire Crystal
INSERT INTO `gardening_results` VALUES (1093, 5, 6, 1, 769, 1, 5, 10); -- Red Rock
INSERT INTO `gardening_results` VALUES (1094, 5, 6, 1, 770, 1, 5, 10); -- Blue Rock
INSERT INTO `gardening_results` VALUES (1095, 5, 6, 2, 17396, 24, 48, 15); -- Little Worm
INSERT INTO `gardening_results` VALUES (1096, 5, 6, 2, 936, 24, 48, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1097, 5, 6, 2, 4098, 12, 24, 15); -- Wind Crystal
INSERT INTO `gardening_results` VALUES (1098, 5, 6, 2, 768, 12, 24, 15); -- Flint Stone
INSERT INTO `gardening_results` VALUES (1099, 5, 6, 2, 737, 1, 5, 10); -- Gold Ore
INSERT INTO `gardening_results` VALUES (1100, 5, 6, 2, 4096, 12, 24, 10); -- Fire Crystal
INSERT INTO `gardening_results` VALUES (1101, 5, 6, 2, 773, 1, 5, 10); -- Translucent Rock
INSERT INTO `gardening_results` VALUES (1102, 5, 6, 2, 770, 1, 5, 10); -- Blue Rock
INSERT INTO `gardening_results` VALUES (1103, 5, 6, 3, 936, 24, 48, 30); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1104, 5, 6, 3, 4099, 12, 24, 15); -- Earth Crystal
INSERT INTO `gardening_results` VALUES (1105, 5, 6, 3, 768, 12, 24, 15); -- Flint Stone
INSERT INTO `gardening_results` VALUES (1106, 5, 6, 3, 641, 8, 16, 10); -- Tin Ore
INSERT INTO `gardening_results` VALUES (1107, 5, 6, 3, 4096, 12, 24, 10); -- Fire Crystal
INSERT INTO `gardening_results` VALUES (1108, 5, 6, 3, 772, 1, 5, 10); -- Green Rock
INSERT INTO `gardening_results` VALUES (1109, 5, 6, 3, 770, 1, 5, 10); -- Blue Rock
INSERT INTO `gardening_results` VALUES (1110, 5, 6, 4, 936, 24, 48, 30); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1111, 5, 6, 4, 4100, 12, 24, 15); -- Lightning Crystal
INSERT INTO `gardening_results` VALUES (1112, 5, 6, 4, 768, 12, 24, 15); -- Flint Stone
INSERT INTO `gardening_results` VALUES (1113, 5, 6, 4, 643, 4, 12, 10); -- Iron Ore
INSERT INTO `gardening_results` VALUES (1114, 5, 6, 4, 4096, 12, 24, 10); -- Fire Crystal
INSERT INTO `gardening_results` VALUES (1115, 5, 6, 4, 771, 1, 5, 10); -- Yellow Rock
INSERT INTO `gardening_results` VALUES (1116, 5, 6, 4, 770, 1, 5, 10); -- Blue Rock
INSERT INTO `gardening_results` VALUES (1117, 5, 6, 5, 936, 24, 48, 30); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1118, 5, 6, 5, 4101, 12, 24, 15); -- Water Crystal
INSERT INTO `gardening_results` VALUES (1119, 5, 6, 5, 768, 12, 24, 15); -- Flint Stone
INSERT INTO `gardening_results` VALUES (1120, 5, 6, 5, 736, 1, 5, 10); -- Silver Ore
INSERT INTO `gardening_results` VALUES (1121, 5, 6, 5, 4096, 12, 24, 10); -- Fire Crystal
INSERT INTO `gardening_results` VALUES (1122, 5, 6, 5, 774, 1, 5, 10); -- Purple Rock
INSERT INTO `gardening_results` VALUES (1123, 5, 6, 5, 770, 1, 5, 10); -- Blue Rock
INSERT INTO `gardening_results` VALUES (1124, 5, 6, 6, 936, 24, 48, 30); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1125, 5, 6, 6, 768, 12, 24, 30); -- Flint Stone
INSERT INTO `gardening_results` VALUES (1126, 5, 6, 6, 4096, 12, 24, 20); -- Fire Crystal
INSERT INTO `gardening_results` VALUES (1127, 5, 6, 6, 770, 1, 5, 20); -- Blue Rock
INSERT INTO `gardening_results` VALUES (1128, 5, 6, 7, 936, 24, 48, 30); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1129, 5, 6, 7, 768, 12, 24, 15); -- Flint Stone
INSERT INTO `gardening_results` VALUES (1130, 5, 6, 7, 4103, 12, 24, 15); -- Dark Crystal
INSERT INTO `gardening_results` VALUES (1131, 5, 6, 7, 4096, 12, 24, 10); -- Fire Crystal
INSERT INTO `gardening_results` VALUES (1132, 5, 6, 7, 642, 4, 12, 10); -- Zinc Ore
INSERT INTO `gardening_results` VALUES (1133, 5, 6, 7, 770, 1, 5, 10); -- Blue Rock
INSERT INTO `gardening_results` VALUES (1134, 5, 6, 7, 776, 1, 5, 10); -- White Rock
INSERT INTO `gardening_results` VALUES (1135, 5, 6, 8, 936, 24, 48, 25); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1136, 5, 6, 8, 768, 12, 24, 15); -- Flint Stone
INSERT INTO `gardening_results` VALUES (1137, 5, 6, 8, 4102, 12, 24, 10); -- Light Crystal
INSERT INTO `gardening_results` VALUES (1138, 5, 6, 8, 4096, 12, 24, 10); -- Fire Crystal
INSERT INTO `gardening_results` VALUES (1139, 5, 6, 8, 845, 4, 8, 10); -- Black Chocobo Feather
INSERT INTO `gardening_results` VALUES (1140, 5, 6, 8, 770, 1, 5, 10); -- Blue Rock
INSERT INTO `gardening_results` VALUES (1141, 5, 6, 8, 775, 1, 5, 10); -- Black Rock
INSERT INTO `gardening_results` VALUES (1142, 5, 6, 8, 645, 1, 2, 10); -- Darksteel Ore
INSERT INTO `gardening_results` VALUES (1143, 5, 7, 0, 936, 24, 48, 57); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1144, 5, 7, 0, 646, 1, 2, 8); -- Adaman Ore
INSERT INTO `gardening_results` VALUES (1145, 5, 7, 0, 4103, 12, 24, 15); -- Dark Crystal
INSERT INTO `gardening_results` VALUES (1146, 5, 7, 0, 642, 4, 12, 10); -- Zinc Ore
INSERT INTO `gardening_results` VALUES (1147, 5, 7, 0, 776, 1, 5, 10); -- White Rock
INSERT INTO `gardening_results` VALUES (1148, 5, 7, 1, 17396, 24, 48, 15); -- Little Worm
INSERT INTO `gardening_results` VALUES (1149, 5, 7, 1, 936, 24, 48, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1150, 5, 7, 1, 4097, 12, 24, 15); -- Ice Crystal
INSERT INTO `gardening_results` VALUES (1151, 5, 7, 1, 4103, 12, 24, 15); -- Dark Crystal
INSERT INTO `gardening_results` VALUES (1152, 5, 7, 1, 640, 8, 16, 10); -- Copper Ore
INSERT INTO `gardening_results` VALUES (1153, 5, 7, 1, 642, 4, 12, 10); -- Zinc Ore
INSERT INTO `gardening_results` VALUES (1154, 5, 7, 1, 769, 1, 5, 10); -- Red Rock
INSERT INTO `gardening_results` VALUES (1155, 5, 7, 1, 776, 1, 5, 10); -- White Rock
INSERT INTO `gardening_results` VALUES (1156, 5, 7, 2, 17396, 24, 48, 15); -- Little Worm
INSERT INTO `gardening_results` VALUES (1157, 5, 7, 2, 936, 24, 48, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1158, 5, 7, 2, 4098, 12, 24, 15); -- Wind Crystal
INSERT INTO `gardening_results` VALUES (1159, 5, 7, 2, 4103, 12, 24, 15); -- Dark Crystal
INSERT INTO `gardening_results` VALUES (1160, 5, 7, 2, 737, 1, 5, 10); -- Gold Ore
INSERT INTO `gardening_results` VALUES (1161, 5, 7, 2, 642, 4, 12, 10); -- Zinc Ore
INSERT INTO `gardening_results` VALUES (1162, 5, 7, 2, 773, 1, 5, 10); -- Translucent Rock
INSERT INTO `gardening_results` VALUES (1163, 5, 7, 2, 776, 1, 5, 10); -- White Rock
INSERT INTO `gardening_results` VALUES (1164, 5, 7, 3, 936, 24, 48, 30); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1165, 5, 7, 3, 4099, 12, 24, 15); -- Earth Crystal
INSERT INTO `gardening_results` VALUES (1166, 5, 7, 3, 4103, 12, 24, 15); -- Dark Crystal
INSERT INTO `gardening_results` VALUES (1167, 5, 7, 3, 641, 8, 16, 10); -- Tin Ore
INSERT INTO `gardening_results` VALUES (1168, 5, 7, 3, 642, 4, 12, 10); -- Zinc Ore
INSERT INTO `gardening_results` VALUES (1169, 5, 7, 3, 772, 1, 5, 10); -- Green Rock
INSERT INTO `gardening_results` VALUES (1170, 5, 7, 3, 776, 1, 5, 10); -- White Rock
INSERT INTO `gardening_results` VALUES (1171, 5, 7, 4, 936, 24, 48, 30); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1172, 5, 7, 4, 4100, 12, 24, 15); -- Lightning Crystal
INSERT INTO `gardening_results` VALUES (1173, 5, 7, 4, 4103, 12, 24, 15); -- Dark Crystal
INSERT INTO `gardening_results` VALUES (1174, 5, 7, 4, 643, 4, 12, 10); -- Iron Ore
INSERT INTO `gardening_results` VALUES (1175, 5, 7, 4, 642, 4, 12, 10); -- Zinc Ore
INSERT INTO `gardening_results` VALUES (1176, 5, 7, 4, 771, 1, 5, 10); -- Yellow Rock
INSERT INTO `gardening_results` VALUES (1177, 5, 7, 4, 776, 1, 5, 10); -- White Rock
INSERT INTO `gardening_results` VALUES (1178, 5, 7, 5, 936, 24, 48, 30); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1179, 5, 7, 5, 4101, 12, 24, 15); -- Water Crystal
INSERT INTO `gardening_results` VALUES (1180, 5, 7, 5, 4103, 12, 24, 15); -- Dark Crystal
INSERT INTO `gardening_results` VALUES (1181, 5, 7, 5, 736, 1, 5, 10); -- Silver Ore
INSERT INTO `gardening_results` VALUES (1182, 5, 7, 5, 642, 4, 12, 10); -- Zinc Ore
INSERT INTO `gardening_results` VALUES (1183, 5, 7, 5, 774, 1, 5, 10); -- Purple Rock
INSERT INTO `gardening_results` VALUES (1184, 5, 7, 5, 776, 1, 5, 10); -- White Rock
INSERT INTO `gardening_results` VALUES (1185, 5, 7, 6, 936, 24, 48, 30); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1186, 5, 7, 6, 768, 12, 24, 15); -- Flint Stone
INSERT INTO `gardening_results` VALUES (1187, 5, 7, 6, 4103, 12, 24, 15); -- Dark Crystal
INSERT INTO `gardening_results` VALUES (1188, 5, 7, 6, 4096, 12, 24, 10); -- Fire Crystal
INSERT INTO `gardening_results` VALUES (1189, 5, 7, 6, 642, 4, 12, 10); -- Zinc Ore
INSERT INTO `gardening_results` VALUES (1190, 5, 7, 6, 770, 1, 5, 10); -- Blue Rock
INSERT INTO `gardening_results` VALUES (1191, 5, 7, 6, 776, 1, 5, 10); -- White Rock
INSERT INTO `gardening_results` VALUES (1192, 5, 7, 7, 936, 24, 48, 30); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1193, 5, 7, 7, 4103, 12, 24, 30); -- Dark Crystal
INSERT INTO `gardening_results` VALUES (1194, 5, 7, 7, 642, 4, 12, 20); -- Zinc Ore
INSERT INTO `gardening_results` VALUES (1195, 5, 7, 7, 776, 1, 5, 20); -- White Rock
INSERT INTO `gardening_results` VALUES (1196, 5, 7, 8, 936, 24, 48, 25); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1197, 5, 7, 8, 4103, 12, 24, 15); -- Dark Crystal
INSERT INTO `gardening_results` VALUES (1198, 5, 7, 8, 4102, 12, 24, 10); -- Light Crystal
INSERT INTO `gardening_results` VALUES (1199, 5, 7, 8, 642, 4, 12, 10); -- Zinc Ore
INSERT INTO `gardening_results` VALUES (1200, 5, 7, 8, 845, 4, 8, 10); -- Black Chocobo Feather
INSERT INTO `gardening_results` VALUES (1201, 5, 7, 8, 776, 1, 5, 10); -- White Rock
INSERT INTO `gardening_results` VALUES (1202, 5, 7, 8, 775, 1, 5, 10); -- Black Rock
INSERT INTO `gardening_results` VALUES (1203, 5, 7, 8, 645, 1, 2, 10); -- Darksteel Ore
INSERT INTO `gardening_results` VALUES (1204, 5, 8, 0, 936, 24, 48, 52); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1205, 5, 8, 0, 646, 1, 2, 8); -- Adaman Ore
INSERT INTO `gardening_results` VALUES (1206, 5, 8, 0, 4102, 12, 24, 10); -- Light Crystal
INSERT INTO `gardening_results` VALUES (1207, 5, 8, 0, 845, 4, 8, 10); -- Black Chocobo Feather
INSERT INTO `gardening_results` VALUES (1208, 5, 8, 0, 775, 1, 5, 10); -- Black Rock
INSERT INTO `gardening_results` VALUES (1209, 5, 8, 0, 645, 1, 2, 10); -- Darksteel Ore
INSERT INTO `gardening_results` VALUES (1210, 5, 8, 1, 17396, 24, 48, 15); -- Little Worm
INSERT INTO `gardening_results` VALUES (1211, 5, 8, 1, 936, 24, 48, 10); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1212, 5, 8, 1, 4097, 12, 24, 15); -- Ice Crystal
INSERT INTO `gardening_results` VALUES (1213, 5, 8, 1, 4102, 12, 24, 10); -- Light Crystal
INSERT INTO `gardening_results` VALUES (1214, 5, 8, 1, 640, 8, 16, 10); -- Copper Ore
INSERT INTO `gardening_results` VALUES (1215, 5, 8, 1, 845, 4, 8, 10); -- Black Chocobo Feather
INSERT INTO `gardening_results` VALUES (1216, 5, 8, 1, 769, 1, 5, 10); -- Red Rock
INSERT INTO `gardening_results` VALUES (1217, 5, 8, 1, 775, 1, 5, 10); -- Black Rock
INSERT INTO `gardening_results` VALUES (1218, 5, 8, 1, 645, 1, 2, 10); -- Darksteel Ore
INSERT INTO `gardening_results` VALUES (1219, 5, 8, 2, 17396, 24, 48, 15); -- Little Worm
INSERT INTO `gardening_results` VALUES (1220, 5, 8, 2, 936, 24, 48, 10); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1221, 5, 8, 2, 4098, 12, 24, 15); -- Wind Crystal
INSERT INTO `gardening_results` VALUES (1222, 5, 8, 2, 4102, 12, 24, 10); -- Light Crystal
INSERT INTO `gardening_results` VALUES (1223, 5, 8, 2, 737, 1, 5, 10); -- Gold Ore
INSERT INTO `gardening_results` VALUES (1224, 5, 8, 2, 845, 4, 8, 10); -- Black Chocobo Feather
INSERT INTO `gardening_results` VALUES (1225, 5, 8, 2, 773, 1, 5, 10); -- Translucent Rock
INSERT INTO `gardening_results` VALUES (1226, 5, 8, 2, 775, 1, 5, 10); -- Black Rock
INSERT INTO `gardening_results` VALUES (1227, 5, 8, 2, 645, 1, 2, 10); -- Darksteel Ore
INSERT INTO `gardening_results` VALUES (1228, 5, 8, 3, 936, 24, 48, 25); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1229, 5, 8, 3, 4099, 12, 24, 15); -- Earth Crystal
INSERT INTO `gardening_results` VALUES (1230, 5, 8, 3, 4102, 12, 24, 10); -- Light Crystal
INSERT INTO `gardening_results` VALUES (1231, 5, 8, 3, 641, 8, 16, 10); -- Tin Ore
INSERT INTO `gardening_results` VALUES (1232, 5, 8, 3, 845, 4, 8, 10); -- Black Chocobo Feather
INSERT INTO `gardening_results` VALUES (1233, 5, 8, 3, 772, 1, 5, 10); -- Green Rock
INSERT INTO `gardening_results` VALUES (1234, 5, 8, 3, 775, 1, 5, 10); -- Black Rock
INSERT INTO `gardening_results` VALUES (1235, 5, 8, 3, 645, 1, 2, 10); -- Darksteel Ore
INSERT INTO `gardening_results` VALUES (1236, 5, 8, 4, 936, 24, 48, 25); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1237, 5, 8, 4, 4100, 12, 24, 15); -- Lightning Crystal
INSERT INTO `gardening_results` VALUES (1238, 5, 8, 4, 4102, 12, 24, 10); -- Light Crystal
INSERT INTO `gardening_results` VALUES (1239, 5, 8, 4, 643, 4, 12, 10); -- Iron Ore
INSERT INTO `gardening_results` VALUES (1240, 5, 8, 4, 845, 4, 8, 10); -- Black Chocobo Feather
INSERT INTO `gardening_results` VALUES (1241, 5, 8, 4, 771, 1, 5, 10); -- Yellow Rock
INSERT INTO `gardening_results` VALUES (1242, 5, 8, 4, 775, 1, 5, 10); -- Black Rock
INSERT INTO `gardening_results` VALUES (1243, 5, 8, 4, 645, 1, 2, 10); -- Darksteel Ore
INSERT INTO `gardening_results` VALUES (1244, 5, 8, 5, 936, 24, 48, 25); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1245, 5, 8, 5, 4101, 12, 24, 15); -- Water Crystal
INSERT INTO `gardening_results` VALUES (1246, 5, 8, 5, 4102, 12, 24, 10); -- Light Crystal
INSERT INTO `gardening_results` VALUES (1247, 5, 8, 5, 736, 1, 5, 10); -- Silver Ore
INSERT INTO `gardening_results` VALUES (1248, 5, 8, 5, 845, 4, 8, 10); -- Black Chocobo Feather
INSERT INTO `gardening_results` VALUES (1249, 5, 8, 5, 774, 1, 5, 10); -- Purple Rock
INSERT INTO `gardening_results` VALUES (1250, 5, 8, 5, 775, 1, 5, 10); -- Black Rock
INSERT INTO `gardening_results` VALUES (1251, 5, 8, 5, 645, 1, 2, 10); -- Darksteel Ore
INSERT INTO `gardening_results` VALUES (1252, 5, 8, 6, 936, 24, 48, 25); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1253, 5, 8, 6, 768, 12, 24, 15); -- Flint Stone
INSERT INTO `gardening_results` VALUES (1254, 5, 8, 6, 4102, 12, 24, 10); -- Light Crystal
INSERT INTO `gardening_results` VALUES (1255, 5, 8, 6, 4096, 12, 24, 10); -- Fire Crystal
INSERT INTO `gardening_results` VALUES (1256, 5, 8, 6, 845, 4, 8, 10); -- Black Chocobo Feather
INSERT INTO `gardening_results` VALUES (1257, 5, 8, 6, 770, 1, 5, 10); -- Blue Rock
INSERT INTO `gardening_results` VALUES (1258, 5, 8, 6, 775, 1, 5, 10); -- Black Rock
INSERT INTO `gardening_results` VALUES (1259, 5, 8, 6, 645, 1, 2, 10); -- Darksteel Ore
INSERT INTO `gardening_results` VALUES (1260, 5, 8, 7, 936, 24, 48, 25); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1261, 5, 8, 7, 4103, 12, 24, 15); -- Dark Crystal
INSERT INTO `gardening_results` VALUES (1262, 5, 8, 7, 4102, 12, 24, 10); -- Light Crystal
INSERT INTO `gardening_results` VALUES (1263, 5, 8, 7, 642, 4, 12, 10); -- Zinc Ore
INSERT INTO `gardening_results` VALUES (1264, 5, 8, 7, 845, 4, 8, 10); -- Black Chocobo Feather
INSERT INTO `gardening_results` VALUES (1265, 5, 8, 7, 776, 1, 5, 10); -- White Rock
INSERT INTO `gardening_results` VALUES (1266, 5, 8, 7, 775, 1, 5, 10); -- Black Rock
INSERT INTO `gardening_results` VALUES (1267, 5, 8, 7, 645, 1, 2, 10); -- Darksteel Ore
INSERT INTO `gardening_results` VALUES (1268, 5, 8, 8, 936, 24, 48, 20); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1269, 5, 8, 8, 4102, 12, 24, 20); -- Light Crystal
INSERT INTO `gardening_results` VALUES (1270, 5, 8, 8, 845, 4, 8, 20); -- Black Chocobo Feather
INSERT INTO `gardening_results` VALUES (1271, 5, 8, 8, 775, 1, 5, 20); -- Black Rock
INSERT INTO `gardening_results` VALUES (1272, 5, 8, 8, 645, 1, 2, 20); -- Darksteel Ore
INSERT INTO `gardening_results` VALUES (1273, 6, 0, 0, 936, 4, 8, 26); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1274, 6, 0, 0, 17397, 24, 48, 26); -- Shell Bug
INSERT INTO `gardening_results` VALUES (1275, 6, 0, 0, 1225, 4, 8, 20); -- Gold Nugget
INSERT INTO `gardening_results` VALUES (1276, 6, 0, 0, 1238, 1, 2, 28); -- Tree Saplings
INSERT INTO `gardening_results` VALUES (1277, 6, 0, 1, 936, 4, 8, 23); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1278, 6, 0, 1, 17397, 24, 48, 13); -- Shell Bug
INSERT INTO `gardening_results` VALUES (1279, 6, 0, 1, 4097, 12, 24, 10); -- Ice Crystal
INSERT INTO `gardening_results` VALUES (1280, 6, 0, 1, 1225, 4, 8, 10); -- Gold Nugget
INSERT INTO `gardening_results` VALUES (1281, 6, 0, 1, 1231, 12, 24, 10); -- Brass Nugget
INSERT INTO `gardening_results` VALUES (1282, 6, 0, 1, 1238, 1, 2, 14); -- Tree Saplings
INSERT INTO `gardening_results` VALUES (1283, 6, 0, 1, 941, 8, 16, 10); -- Red Rose
INSERT INTO `gardening_results` VALUES (1284, 6, 0, 1, 751, 1, 5, 10); -- Platinum Beastcoin
INSERT INTO `gardening_results` VALUES (1285, 6, 0, 2, 936, 4, 8, 13); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1286, 6, 0, 2, 17396, 12, 24, 15); -- Little Worm
INSERT INTO `gardening_results` VALUES (1287, 6, 0, 2, 17397, 24, 48, 13); -- Shell Bug
INSERT INTO `gardening_results` VALUES (1288, 6, 0, 2, 4098, 12, 24, 15); -- Wind Crystal
INSERT INTO `gardening_results` VALUES (1289, 6, 0, 2, 1225, 4, 8, 10); -- Gold Nugget
INSERT INTO `gardening_results` VALUES (1290, 6, 0, 2, 920, 4, 8, 10); -- Malboro Vine
INSERT INTO `gardening_results` VALUES (1291, 6, 0, 2, 1238, 1, 2, 14); -- Tree Saplings
INSERT INTO `gardening_results` VALUES (1292, 6, 0, 2, 1235, 4, 12, 10); -- Steel Nugget
INSERT INTO `gardening_results` VALUES (1293, 6, 0, 3, 936, 4, 8, 28); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1294, 6, 0, 3, 17397, 24, 48, 13); -- Shell Bug
INSERT INTO `gardening_results` VALUES (1295, 6, 0, 3, 4099, 12, 24, 15); -- Earth Crystal
INSERT INTO `gardening_results` VALUES (1296, 6, 0, 3, 1225, 4, 8, 10); -- Gold Nugget
INSERT INTO `gardening_results` VALUES (1297, 6, 0, 3, 1230, 8, 16, 10); -- Copper Nugget
INSERT INTO `gardening_results` VALUES (1298, 6, 0, 3, 1238, 1, 2, 14); -- Tree Saplings
INSERT INTO `gardening_results` VALUES (1299, 6, 0, 3, 748, 1, 5, 10); -- Gold Beastcoin
INSERT INTO `gardening_results` VALUES (1300, 6, 0, 4, 936, 4, 8, 23); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1301, 6, 0, 4, 17397, 24, 48, 13); -- Shell Bug
INSERT INTO `gardening_results` VALUES (1302, 6, 0, 4, 4100, 12, 24, 10); -- Lightning Crystal
INSERT INTO `gardening_results` VALUES (1303, 6, 0, 4, 1225, 4, 8, 10); -- Gold Nugget
INSERT INTO `gardening_results` VALUES (1304, 6, 0, 4, 841, 4, 12, 10); -- Yagudo Feather
INSERT INTO `gardening_results` VALUES (1305, 6, 0, 4, 1238, 1, 2, 14); -- Tree Saplings
INSERT INTO `gardening_results` VALUES (1306, 6, 0, 4, 839, 4, 8, 10); -- Crawler Cocoon
INSERT INTO `gardening_results` VALUES (1307, 6, 0, 4, 1234, 4, 12, 10); -- Iron Nugget
INSERT INTO `gardening_results` VALUES (1308, 6, 0, 5, 936, 4, 8, 23); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1309, 6, 0, 5, 17397, 24, 48, 13); -- Shell Bug
INSERT INTO `gardening_results` VALUES (1310, 6, 0, 5, 4101, 12, 24, 10); -- Water Crystal
INSERT INTO `gardening_results` VALUES (1311, 6, 0, 5, 1225, 4, 8, 10); -- Gold Nugget
INSERT INTO `gardening_results` VALUES (1312, 6, 0, 5, 1233, 4, 12, 10); -- Silver Nugget
INSERT INTO `gardening_results` VALUES (1313, 6, 0, 5, 1238, 1, 2, 14); -- Tree Saplings
INSERT INTO `gardening_results` VALUES (1314, 6, 0, 5, 918, 1, 2, 10); -- Mistletoe
INSERT INTO `gardening_results` VALUES (1315, 6, 0, 5, 749, 1, 5, 10); -- Mythril Beastcoin
INSERT INTO `gardening_results` VALUES (1316, 6, 0, 6, 936, 4, 8, 23); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1317, 6, 0, 6, 17397, 24, 48, 13); -- Shell Bug
INSERT INTO `gardening_results` VALUES (1318, 6, 0, 6, 4096, 12, 24, 10); -- Fire Crystal
INSERT INTO `gardening_results` VALUES (1319, 6, 0, 6, 1225, 4, 8, 10); -- Gold Nugget
INSERT INTO `gardening_results` VALUES (1320, 6, 0, 6, 1232, 8, 16, 10); -- Bronze Nugget
INSERT INTO `gardening_results` VALUES (1321, 6, 0, 6, 1238, 1, 2, 14); -- Tree Saplings
INSERT INTO `gardening_results` VALUES (1322, 6, 0, 6, 750, 4, 8, 10); -- Silver Beastcoin
INSERT INTO `gardening_results` VALUES (1323, 6, 0, 6, 1226, 4, 12, 10); -- Mythril Nugget
INSERT INTO `gardening_results` VALUES (1324, 6, 0, 7, 936, 4, 8, 23); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1325, 6, 0, 7, 17397, 24, 48, 13); -- Shell Bug
INSERT INTO `gardening_results` VALUES (1326, 6, 0, 7, 4103, 12, 24, 10); -- Dark Crystal
INSERT INTO `gardening_results` VALUES (1327, 6, 0, 7, 1225, 4, 8, 10); -- Gold Nugget
INSERT INTO `gardening_results` VALUES (1328, 6, 0, 7, 4570, 4, 12, 10); -- Bird Egg
INSERT INTO `gardening_results` VALUES (1329, 6, 0, 7, 1238, 1, 2, 14); -- Tree Saplings
INSERT INTO `gardening_results` VALUES (1330, 6, 0, 7, 842, 1, 5, 10); -- Giant Bird Feather
INSERT INTO `gardening_results` VALUES (1331, 6, 0, 7, 1227, 4, 12, 10); -- Platinum Nugget
INSERT INTO `gardening_results` VALUES (1332, 6, 0, 8, 936, 4, 8, 23); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1333, 6, 0, 8, 17397, 24, 48, 13); -- Shell Bug
INSERT INTO `gardening_results` VALUES (1334, 6, 0, 8, 4102, 12, 24, 10); -- Light Crystal
INSERT INTO `gardening_results` VALUES (1335, 6, 0, 8, 1225, 4, 8, 10); -- Gold Nugget
INSERT INTO `gardening_results` VALUES (1336, 6, 0, 8, 4274, 4, 8, 10); -- Persikos
INSERT INTO `gardening_results` VALUES (1337, 6, 0, 8, 1238, 1, 2, 14); -- Tree Saplings
INSERT INTO `gardening_results` VALUES (1338, 6, 0, 8, 845, 4, 8, 10); -- Black Chocobo Feather
INSERT INTO `gardening_results` VALUES (1339, 6, 0, 8, 1228, 4, 12, 10); -- Darksteel Nugget
INSERT INTO `gardening_results` VALUES (1340, 6, 1, 0, 936, 4, 8, 23); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1341, 6, 1, 0, 17397, 24, 48, 13); -- Shell Bug
INSERT INTO `gardening_results` VALUES (1342, 6, 1, 0, 4097, 12, 24, 10); -- Ice Crystal
INSERT INTO `gardening_results` VALUES (1343, 6, 1, 0, 1225, 4, 8, 10); -- Gold Nugget
INSERT INTO `gardening_results` VALUES (1344, 6, 1, 0, 1231, 12, 24, 10); -- Brass Nugget
INSERT INTO `gardening_results` VALUES (1345, 6, 1, 0, 1238, 1, 2, 14); -- Tree Saplings
INSERT INTO `gardening_results` VALUES (1346, 6, 1, 0, 941, 8, 16, 10); -- Red Rose
INSERT INTO `gardening_results` VALUES (1347, 6, 1, 0, 751, 1, 5, 10); -- Platinum Beastcoin
INSERT INTO `gardening_results` VALUES (1348, 6, 1, 1, 936, 12, 24, 20); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1349, 6, 1, 1, 4097, 12, 24, 20); -- Ice Crystal
INSERT INTO `gardening_results` VALUES (1350, 6, 1, 1, 1231, 12, 24, 20); -- Brass Nugget
INSERT INTO `gardening_results` VALUES (1351, 6, 1, 1, 941, 8, 16, 20); -- Red Rose
INSERT INTO `gardening_results` VALUES (1352, 6, 1, 1, 751, 1, 5, 20); -- Platinum Beastcoin
INSERT INTO `gardening_results` VALUES (1353, 6, 1, 2, 936, 12, 24, 10); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1354, 6, 1, 2, 17396, 12, 24, 15); -- Little Worm
INSERT INTO `gardening_results` VALUES (1355, 6, 1, 2, 4097, 12, 24, 10); -- Ice Crystal
INSERT INTO `gardening_results` VALUES (1356, 6, 1, 2, 4098, 12, 24, 15); -- Wind Crystal
INSERT INTO `gardening_results` VALUES (1357, 6, 1, 2, 1231, 12, 24, 10); -- Brass Nugget
INSERT INTO `gardening_results` VALUES (1358, 6, 1, 2, 920, 4, 8, 10); -- Malboro Vine
INSERT INTO `gardening_results` VALUES (1359, 6, 1, 2, 941, 8, 16, 10); -- Red Rose
INSERT INTO `gardening_results` VALUES (1360, 6, 1, 2, 1235, 4, 12, 10); -- Steel Nugget
INSERT INTO `gardening_results` VALUES (1361, 6, 1, 2, 751, 1, 5, 10); -- Platinum Beastcoin
INSERT INTO `gardening_results` VALUES (1362, 6, 1, 3, 936, 12, 24, 25); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1363, 6, 1, 3, 4097, 12, 24, 10); -- Ice Crystal
INSERT INTO `gardening_results` VALUES (1364, 6, 1, 3, 4099, 12, 24, 15); -- Earth Crystal
INSERT INTO `gardening_results` VALUES (1365, 6, 1, 3, 1231, 12, 24, 10); -- Brass Nugget
INSERT INTO `gardening_results` VALUES (1366, 6, 1, 3, 1230, 8, 16, 10); -- Copper Nugget
INSERT INTO `gardening_results` VALUES (1367, 6, 1, 3, 941, 8, 16, 10); -- Red Rose
INSERT INTO `gardening_results` VALUES (1368, 6, 1, 3, 748, 1, 5, 10); -- Gold Beastcoin
INSERT INTO `gardening_results` VALUES (1369, 6, 1, 3, 751, 1, 5, 10); -- Platinum Beastcoin
INSERT INTO `gardening_results` VALUES (1370, 6, 1, 4, 936, 12, 24, 20); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1371, 6, 1, 4, 4097, 12, 24, 10); -- Ice Crystal
INSERT INTO `gardening_results` VALUES (1372, 6, 1, 4, 4100, 12, 24, 10); -- Lightning Crystal
INSERT INTO `gardening_results` VALUES (1373, 6, 1, 4, 1231, 12, 24, 10); -- Brass Nugget
INSERT INTO `gardening_results` VALUES (1374, 6, 1, 4, 841, 4, 12, 10); -- Yagudo Feather
INSERT INTO `gardening_results` VALUES (1375, 6, 1, 4, 941, 8, 16, 10); -- Red Rose
INSERT INTO `gardening_results` VALUES (1376, 6, 1, 4, 839, 4, 8, 10); -- Crawler Cocoon
INSERT INTO `gardening_results` VALUES (1377, 6, 1, 4, 751, 1, 5, 10); -- Platinum Beastcoin
INSERT INTO `gardening_results` VALUES (1378, 6, 1, 4, 1234, 4, 12, 10); -- Iron Nugget
INSERT INTO `gardening_results` VALUES (1379, 6, 1, 5, 936, 12, 24, 20); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1380, 6, 1, 5, 4097, 12, 24, 10); -- Ice Crystal
INSERT INTO `gardening_results` VALUES (1381, 6, 1, 5, 4101, 12, 24, 10); -- Water Crystal
INSERT INTO `gardening_results` VALUES (1382, 6, 1, 5, 1231, 12, 24, 10); -- Brass Nugget
INSERT INTO `gardening_results` VALUES (1383, 6, 1, 5, 1233, 4, 12, 10); -- Silver Nugget
INSERT INTO `gardening_results` VALUES (1384, 6, 1, 5, 941, 8, 16, 10); -- Red Rose
INSERT INTO `gardening_results` VALUES (1385, 6, 1, 5, 918, 1, 2, 10); -- Mistletoe
INSERT INTO `gardening_results` VALUES (1386, 6, 1, 5, 751, 1, 5, 10); -- Platinum Beastcoin
INSERT INTO `gardening_results` VALUES (1387, 6, 1, 5, 749, 1, 5, 10); -- Mythril Beastcoin
INSERT INTO `gardening_results` VALUES (1388, 6, 1, 6, 936, 12, 24, 20); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1389, 6, 1, 6, 4097, 12, 24, 10); -- Ice Crystal
INSERT INTO `gardening_results` VALUES (1390, 6, 1, 6, 4096, 12, 24, 10); -- Fire Crystal
INSERT INTO `gardening_results` VALUES (1391, 6, 1, 6, 1231, 12, 24, 10); -- Brass Nugget
INSERT INTO `gardening_results` VALUES (1392, 6, 1, 6, 1232, 8, 16, 10); -- Bronze Nugget
INSERT INTO `gardening_results` VALUES (1393, 6, 1, 6, 941, 8, 16, 10); -- Red Rose
INSERT INTO `gardening_results` VALUES (1394, 6, 1, 6, 750, 4, 8, 10); -- Silver Beastcoin
INSERT INTO `gardening_results` VALUES (1395, 6, 1, 6, 751, 1, 5, 10); -- Platinum Beastcoin
INSERT INTO `gardening_results` VALUES (1396, 6, 1, 6, 1226, 4, 12, 10); -- Mythril Nugget
INSERT INTO `gardening_results` VALUES (1397, 6, 1, 7, 936, 12, 24, 20); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1398, 6, 1, 7, 4097, 12, 24, 10); -- Ice Crystal
INSERT INTO `gardening_results` VALUES (1399, 6, 1, 7, 4103, 12, 24, 10); -- Dark Crystal
INSERT INTO `gardening_results` VALUES (1400, 6, 1, 7, 1231, 12, 24, 10); -- Brass Nugget
INSERT INTO `gardening_results` VALUES (1401, 6, 1, 7, 4570, 4, 12, 10); -- Bird Egg
INSERT INTO `gardening_results` VALUES (1402, 6, 1, 7, 941, 8, 16, 10); -- Red Rose
INSERT INTO `gardening_results` VALUES (1403, 6, 1, 7, 842, 1, 5, 10); -- Giant Bird Feather
INSERT INTO `gardening_results` VALUES (1404, 6, 1, 7, 751, 1, 5, 10); -- Platinum Beastcoin
INSERT INTO `gardening_results` VALUES (1405, 6, 1, 7, 1227, 4, 12, 10); -- Platinum Nugget
INSERT INTO `gardening_results` VALUES (1406, 6, 1, 8, 936, 12, 24, 20); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1407, 6, 1, 8, 4097, 12, 24, 10); -- Ice Crystal
INSERT INTO `gardening_results` VALUES (1408, 6, 1, 8, 4102, 12, 24, 10); -- Light Crystal
INSERT INTO `gardening_results` VALUES (1409, 6, 1, 8, 1231, 12, 24, 10); -- Brass Nugget
INSERT INTO `gardening_results` VALUES (1410, 6, 1, 8, 4274, 4, 8, 10); -- Persikos
INSERT INTO `gardening_results` VALUES (1411, 6, 1, 8, 941, 8, 16, 10); -- Red Rose
INSERT INTO `gardening_results` VALUES (1412, 6, 1, 8, 845, 4, 8, 10); -- Black Chocobo Feather
INSERT INTO `gardening_results` VALUES (1413, 6, 1, 8, 751, 1, 5, 10); -- Platinum Beastcoin
INSERT INTO `gardening_results` VALUES (1414, 6, 1, 8, 1228, 4, 12, 10); -- Darksteel Nugget
INSERT INTO `gardening_results` VALUES (1415, 6, 2, 0, 936, 4, 8, 13); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1416, 6, 2, 0, 17396, 12, 24, 15); -- Little Worm
INSERT INTO `gardening_results` VALUES (1417, 6, 2, 0, 17397, 24, 48, 13); -- Shell Bug
INSERT INTO `gardening_results` VALUES (1418, 6, 2, 0, 4098, 12, 24, 15); -- Wind Crystal
INSERT INTO `gardening_results` VALUES (1419, 6, 2, 0, 1225, 4, 8, 10); -- Gold Nugget
INSERT INTO `gardening_results` VALUES (1420, 6, 2, 0, 920, 4, 8, 10); -- Malboro Vine
INSERT INTO `gardening_results` VALUES (1421, 6, 2, 0, 1238, 1, 2, 14); -- Tree Saplings
INSERT INTO `gardening_results` VALUES (1422, 6, 2, 0, 1235, 4, 12, 10); -- Steel Nugget
INSERT INTO `gardening_results` VALUES (1423, 6, 2, 1, 936, 12, 24, 10); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1424, 6, 2, 1, 17396, 12, 24, 15); -- Little Worm
INSERT INTO `gardening_results` VALUES (1425, 6, 2, 1, 4097, 12, 24, 10); -- Ice Crystal
INSERT INTO `gardening_results` VALUES (1426, 6, 2, 1, 4098, 12, 24, 15); -- Wind Crystal
INSERT INTO `gardening_results` VALUES (1427, 6, 2, 1, 1231, 12, 24, 10); -- Brass Nugget
INSERT INTO `gardening_results` VALUES (1428, 6, 2, 1, 920, 4, 8, 10); -- Malboro Vine
INSERT INTO `gardening_results` VALUES (1429, 6, 2, 1, 941, 8, 16, 10); -- Red Rose
INSERT INTO `gardening_results` VALUES (1430, 6, 2, 1, 1235, 4, 12, 10); -- Steel Nugget
INSERT INTO `gardening_results` VALUES (1431, 6, 2, 1, 751, 1, 5, 10); -- Platinum Beastcoin
INSERT INTO `gardening_results` VALUES (1432, 6, 2, 2, 17396, 12, 24, 30); -- Little Worm
INSERT INTO `gardening_results` VALUES (1433, 6, 2, 2, 4098, 12, 24, 30); -- Wind Crystal
INSERT INTO `gardening_results` VALUES (1434, 6, 2, 2, 920, 4, 8, 20); -- Malboro Vine
INSERT INTO `gardening_results` VALUES (1435, 6, 2, 2, 1235, 4, 12, 20); -- Steel Nugget
INSERT INTO `gardening_results` VALUES (1436, 6, 2, 3, 17396, 12, 24, 15); -- Little Worm
INSERT INTO `gardening_results` VALUES (1437, 6, 2, 3, 936, 12, 24, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1438, 6, 2, 3, 4098, 12, 24, 15); -- Wind Crystal
INSERT INTO `gardening_results` VALUES (1439, 6, 2, 3, 4099, 12, 24, 15); -- Earth Crystal
INSERT INTO `gardening_results` VALUES (1440, 6, 2, 3, 920, 4, 8, 10); -- Malboro Vine
INSERT INTO `gardening_results` VALUES (1441, 6, 2, 3, 1230, 8, 16, 10); -- Copper Nugget
INSERT INTO `gardening_results` VALUES (1442, 6, 2, 3, 1235, 4, 12, 10); -- Steel Nugget
INSERT INTO `gardening_results` VALUES (1443, 6, 2, 3, 748, 1, 5, 10); -- Gold Beastcoin
INSERT INTO `gardening_results` VALUES (1444, 6, 2, 4, 17396, 12, 24, 15); -- Little Worm
INSERT INTO `gardening_results` VALUES (1445, 6, 2, 4, 936, 12, 24, 10); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1446, 6, 2, 4, 4098, 12, 24, 15); -- Wind Crystal
INSERT INTO `gardening_results` VALUES (1447, 6, 2, 4, 4100, 12, 24, 10); -- Lightning Crystal
INSERT INTO `gardening_results` VALUES (1448, 6, 2, 4, 920, 4, 8, 10); -- Malboro Vine
INSERT INTO `gardening_results` VALUES (1449, 6, 2, 4, 841, 4, 12, 10); -- Yagudo Feather
INSERT INTO `gardening_results` VALUES (1450, 6, 2, 4, 1235, 4, 12, 10); -- Steel Nugget
INSERT INTO `gardening_results` VALUES (1451, 6, 2, 4, 839, 4, 8, 10); -- Crawler Cocoon
INSERT INTO `gardening_results` VALUES (1452, 6, 2, 4, 1234, 4, 12, 10); -- Iron Nugget
INSERT INTO `gardening_results` VALUES (1453, 6, 2, 5, 17396, 12, 24, 15); -- Little Worm
INSERT INTO `gardening_results` VALUES (1454, 6, 2, 5, 936, 12, 24, 10); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1455, 6, 2, 5, 4098, 12, 24, 15); -- Wind Crystal
INSERT INTO `gardening_results` VALUES (1456, 6, 2, 5, 4101, 12, 24, 10); -- Water Crystal
INSERT INTO `gardening_results` VALUES (1457, 6, 2, 5, 920, 4, 8, 10); -- Malboro Vine
INSERT INTO `gardening_results` VALUES (1458, 6, 2, 5, 1233, 4, 12, 10); -- Silver Nugget
INSERT INTO `gardening_results` VALUES (1459, 6, 2, 5, 1235, 4, 12, 10); -- Steel Nugget
INSERT INTO `gardening_results` VALUES (1460, 6, 2, 5, 918, 1, 2, 10); -- Mistletoe
INSERT INTO `gardening_results` VALUES (1461, 6, 2, 5, 749, 1, 5, 10); -- Mythril Beastcoin
INSERT INTO `gardening_results` VALUES (1462, 6, 2, 6, 17396, 12, 24, 15); -- Little Worm
INSERT INTO `gardening_results` VALUES (1463, 6, 2, 6, 936, 12, 24, 10); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1464, 6, 2, 6, 4098, 12, 24, 15); -- Wind Crystal
INSERT INTO `gardening_results` VALUES (1465, 6, 2, 6, 4096, 12, 24, 10); -- Fire Crystal
INSERT INTO `gardening_results` VALUES (1466, 6, 2, 6, 920, 4, 8, 10); -- Malboro Vine
INSERT INTO `gardening_results` VALUES (1467, 6, 2, 6, 1232, 8, 16, 10); -- Bronze Nugget
INSERT INTO `gardening_results` VALUES (1468, 6, 2, 6, 1235, 4, 12, 10); -- Steel Nugget
INSERT INTO `gardening_results` VALUES (1469, 6, 2, 6, 750, 4, 8, 10); -- Silver Beastcoin
INSERT INTO `gardening_results` VALUES (1470, 6, 2, 6, 1226, 4, 12, 10); -- Mythril Nugget
INSERT INTO `gardening_results` VALUES (1471, 6, 2, 7, 17396, 12, 24, 15); -- Little Worm
INSERT INTO `gardening_results` VALUES (1472, 6, 2, 7, 936, 12, 24, 10); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1473, 6, 2, 7, 4098, 12, 24, 15); -- Wind Crystal
INSERT INTO `gardening_results` VALUES (1474, 6, 2, 7, 4103, 12, 24, 10); -- Dark Crystal
INSERT INTO `gardening_results` VALUES (1475, 6, 2, 7, 920, 4, 8, 10); -- Malboro Vine
INSERT INTO `gardening_results` VALUES (1476, 6, 2, 7, 4570, 4, 12, 10); -- Bird Egg
INSERT INTO `gardening_results` VALUES (1477, 6, 2, 7, 1235, 4, 12, 10); -- Steel Nugget
INSERT INTO `gardening_results` VALUES (1478, 6, 2, 7, 842, 1, 5, 10); -- Giant Bird Feather
INSERT INTO `gardening_results` VALUES (1479, 6, 2, 7, 1227, 4, 12, 10); -- Platinum Nugget
INSERT INTO `gardening_results` VALUES (1480, 6, 2, 8, 17396, 12, 24, 15); -- Little Worm
INSERT INTO `gardening_results` VALUES (1481, 6, 2, 8, 936, 12, 24, 10); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1482, 6, 2, 8, 4098, 12, 24, 15); -- Wind Crystal
INSERT INTO `gardening_results` VALUES (1483, 6, 2, 8, 4102, 12, 24, 10); -- Light Crystal
INSERT INTO `gardening_results` VALUES (1484, 6, 2, 8, 920, 4, 8, 10); -- Malboro Vine
INSERT INTO `gardening_results` VALUES (1485, 6, 2, 8, 4274, 4, 8, 10); -- Persikos
INSERT INTO `gardening_results` VALUES (1486, 6, 2, 8, 1235, 4, 12, 10); -- Steel Nugget
INSERT INTO `gardening_results` VALUES (1487, 6, 2, 8, 845, 4, 8, 10); -- Black Chocobo Feather
INSERT INTO `gardening_results` VALUES (1488, 6, 2, 8, 1228, 4, 12, 10); -- Darksteel Nugget
INSERT INTO `gardening_results` VALUES (1489, 6, 3, 0, 936, 4, 8, 28); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1490, 6, 3, 0, 17397, 24, 48, 13); -- Shell Bug
INSERT INTO `gardening_results` VALUES (1491, 6, 3, 0, 4099, 12, 24, 15); -- Earth Crystal
INSERT INTO `gardening_results` VALUES (1492, 6, 3, 0, 1225, 4, 8, 10); -- Gold Nugget
INSERT INTO `gardening_results` VALUES (1493, 6, 3, 0, 1230, 8, 16, 10); -- Copper Nugget
INSERT INTO `gardening_results` VALUES (1494, 6, 3, 0, 1238, 1, 2, 14); -- Tree Saplings
INSERT INTO `gardening_results` VALUES (1495, 6, 3, 0, 748, 1, 5, 10); -- Gold Beastcoin
INSERT INTO `gardening_results` VALUES (1496, 6, 3, 1, 936, 12, 24, 25); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1497, 6, 3, 1, 4097, 12, 24, 10); -- Ice Crystal
INSERT INTO `gardening_results` VALUES (1498, 6, 3, 1, 4099, 12, 24, 15); -- Earth Crystal
INSERT INTO `gardening_results` VALUES (1499, 6, 3, 1, 1231, 12, 24, 10); -- Brass Nugget
INSERT INTO `gardening_results` VALUES (1500, 6, 3, 1, 1230, 8, 16, 10); -- Copper Nugget
INSERT INTO `gardening_results` VALUES (1501, 6, 3, 1, 941, 8, 16, 10); -- Red Rose
INSERT INTO `gardening_results` VALUES (1502, 6, 3, 1, 748, 1, 5, 10); -- Gold Beastcoin
INSERT INTO `gardening_results` VALUES (1503, 6, 3, 1, 751, 1, 5, 10); -- Platinum Beastcoin
INSERT INTO `gardening_results` VALUES (1504, 6, 3, 2, 17396, 12, 24, 15); -- Little Worm
INSERT INTO `gardening_results` VALUES (1505, 6, 3, 2, 936, 12, 24, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1506, 6, 3, 2, 4098, 12, 24, 15); -- Wind Crystal
INSERT INTO `gardening_results` VALUES (1507, 6, 3, 2, 4099, 12, 24, 15); -- Earth Crystal
INSERT INTO `gardening_results` VALUES (1508, 6, 3, 2, 920, 4, 8, 10); -- Malboro Vine
INSERT INTO `gardening_results` VALUES (1509, 6, 3, 2, 1230, 8, 16, 10); -- Copper Nugget
INSERT INTO `gardening_results` VALUES (1510, 6, 3, 2, 1235, 4, 12, 10); -- Steel Nugget
INSERT INTO `gardening_results` VALUES (1511, 6, 3, 2, 748, 1, 5, 10); -- Gold Beastcoin
INSERT INTO `gardening_results` VALUES (1512, 6, 3, 3, 936, 12, 24, 30); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1513, 6, 3, 3, 4099, 12, 24, 30); -- Earth Crystal
INSERT INTO `gardening_results` VALUES (1514, 6, 3, 3, 1230, 8, 16, 20); -- Copper Nugget
INSERT INTO `gardening_results` VALUES (1515, 6, 3, 3, 748, 1, 5, 20); -- Gold Beastcoin
INSERT INTO `gardening_results` VALUES (1516, 6, 3, 4, 936, 12, 24, 25); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1517, 6, 3, 4, 4099, 12, 24, 15); -- Earth Crystal
INSERT INTO `gardening_results` VALUES (1518, 6, 3, 4, 4100, 12, 24, 10); -- Lightning Crystal
INSERT INTO `gardening_results` VALUES (1519, 6, 3, 4, 1230, 8, 16, 10); -- Copper Nugget
INSERT INTO `gardening_results` VALUES (1520, 6, 3, 4, 841, 4, 12, 10); -- Yagudo Feather
INSERT INTO `gardening_results` VALUES (1521, 6, 3, 4, 748, 1, 5, 10); -- Gold Beastcoin
INSERT INTO `gardening_results` VALUES (1522, 6, 3, 4, 839, 4, 8, 10); -- Crawler Cocoon
INSERT INTO `gardening_results` VALUES (1523, 6, 3, 4, 1234, 4, 12, 10); -- Iron Nugget
INSERT INTO `gardening_results` VALUES (1524, 6, 3, 5, 936, 12, 24, 25); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1525, 6, 3, 5, 4099, 12, 24, 15); -- Earth Crystal
INSERT INTO `gardening_results` VALUES (1526, 6, 3, 5, 4101, 12, 24, 10); -- Water Crystal
INSERT INTO `gardening_results` VALUES (1527, 6, 3, 5, 1230, 8, 16, 10); -- Copper Nugget
INSERT INTO `gardening_results` VALUES (1528, 6, 3, 5, 1233, 4, 12, 10); -- Silver Nugget
INSERT INTO `gardening_results` VALUES (1529, 6, 3, 5, 748, 1, 5, 10); -- Gold Beastcoin
INSERT INTO `gardening_results` VALUES (1530, 6, 3, 5, 918, 1, 2, 10); -- Mistletoe
INSERT INTO `gardening_results` VALUES (1531, 6, 3, 5, 749, 1, 5, 10); -- Mythril Beastcoin
INSERT INTO `gardening_results` VALUES (1532, 6, 3, 6, 936, 12, 24, 25); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1533, 6, 3, 6, 4099, 12, 24, 15); -- Earth Crystal
INSERT INTO `gardening_results` VALUES (1534, 6, 3, 6, 4096, 12, 24, 10); -- Fire Crystal
INSERT INTO `gardening_results` VALUES (1535, 6, 3, 6, 1230, 8, 16, 10); -- Copper Nugget
INSERT INTO `gardening_results` VALUES (1536, 6, 3, 6, 1232, 8, 16, 10); -- Bronze Nugget
INSERT INTO `gardening_results` VALUES (1537, 6, 3, 6, 748, 1, 5, 10); -- Gold Beastcoin
INSERT INTO `gardening_results` VALUES (1538, 6, 3, 6, 750, 4, 8, 10); -- Silver Beastcoin
INSERT INTO `gardening_results` VALUES (1539, 6, 3, 6, 1226, 4, 12, 10); -- Mythril Nugget
INSERT INTO `gardening_results` VALUES (1540, 6, 3, 7, 936, 12, 24, 25); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1541, 6, 3, 7, 4099, 12, 24, 15); -- Earth Crystal
INSERT INTO `gardening_results` VALUES (1542, 6, 3, 7, 4103, 12, 24, 10); -- Dark Crystal
INSERT INTO `gardening_results` VALUES (1543, 6, 3, 7, 1230, 8, 16, 10); -- Copper Nugget
INSERT INTO `gardening_results` VALUES (1544, 6, 3, 7, 4570, 4, 12, 10); -- Bird Egg
INSERT INTO `gardening_results` VALUES (1545, 6, 3, 7, 748, 1, 5, 10); -- Gold Beastcoin
INSERT INTO `gardening_results` VALUES (1546, 6, 3, 7, 842, 1, 5, 10); -- Giant Bird Feather
INSERT INTO `gardening_results` VALUES (1547, 6, 3, 7, 1227, 4, 12, 10); -- Platinum Nugget
INSERT INTO `gardening_results` VALUES (1548, 6, 3, 8, 936, 12, 24, 25); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1549, 6, 3, 8, 4099, 12, 24, 15); -- Earth Crystal
INSERT INTO `gardening_results` VALUES (1550, 6, 3, 8, 4102, 12, 24, 10); -- Light Crystal
INSERT INTO `gardening_results` VALUES (1551, 6, 3, 8, 1230, 8, 16, 10); -- Copper Nugget
INSERT INTO `gardening_results` VALUES (1552, 6, 3, 8, 4274, 4, 8, 10); -- Persikos
INSERT INTO `gardening_results` VALUES (1553, 6, 3, 8, 748, 1, 5, 10); -- Gold Beastcoin
INSERT INTO `gardening_results` VALUES (1554, 6, 3, 8, 845, 4, 8, 10); -- Black Chocobo Feather
INSERT INTO `gardening_results` VALUES (1555, 6, 3, 8, 1228, 4, 12, 10); -- Darksteel Nugget
INSERT INTO `gardening_results` VALUES (1556, 6, 4, 0, 936, 4, 8, 23); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1557, 6, 4, 0, 17397, 24, 48, 13); -- Shell Bug
INSERT INTO `gardening_results` VALUES (1558, 6, 4, 0, 4100, 12, 24, 10); -- Lightning Crystal
INSERT INTO `gardening_results` VALUES (1559, 6, 4, 0, 1225, 4, 8, 10); -- Gold Nugget
INSERT INTO `gardening_results` VALUES (1560, 6, 4, 0, 841, 4, 12, 10); -- Yagudo Feather
INSERT INTO `gardening_results` VALUES (1561, 6, 4, 0, 1238, 1, 2, 14); -- Tree Saplings
INSERT INTO `gardening_results` VALUES (1562, 6, 4, 0, 839, 4, 8, 10); -- Crawler Cocoon
INSERT INTO `gardening_results` VALUES (1563, 6, 4, 0, 1234, 4, 12, 10); -- Iron Nugget
INSERT INTO `gardening_results` VALUES (1564, 6, 4, 1, 936, 12, 24, 20); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1565, 6, 4, 1, 4097, 12, 24, 10); -- Ice Crystal
INSERT INTO `gardening_results` VALUES (1566, 6, 4, 1, 4100, 12, 24, 10); -- Lightning Crystal
INSERT INTO `gardening_results` VALUES (1567, 6, 4, 1, 1231, 12, 24, 10); -- Brass Nugget
INSERT INTO `gardening_results` VALUES (1568, 6, 4, 1, 841, 4, 12, 10); -- Yagudo Feather
INSERT INTO `gardening_results` VALUES (1569, 6, 4, 1, 941, 8, 16, 10); -- Red Rose
INSERT INTO `gardening_results` VALUES (1570, 6, 4, 1, 839, 4, 8, 10); -- Crawler Cocoon
INSERT INTO `gardening_results` VALUES (1571, 6, 4, 1, 751, 1, 5, 10); -- Platinum Beastcoin
INSERT INTO `gardening_results` VALUES (1572, 6, 4, 1, 1234, 4, 12, 10); -- Iron Nugget
INSERT INTO `gardening_results` VALUES (1573, 6, 4, 2, 17396, 12, 24, 15); -- Little Worm
INSERT INTO `gardening_results` VALUES (1574, 6, 4, 2, 936, 12, 24, 10); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1575, 6, 4, 2, 4098, 12, 24, 15); -- Wind Crystal
INSERT INTO `gardening_results` VALUES (1576, 6, 4, 2, 4100, 12, 24, 10); -- Lightning Crystal
INSERT INTO `gardening_results` VALUES (1577, 6, 4, 2, 920, 4, 8, 10); -- Malboro Vine
INSERT INTO `gardening_results` VALUES (1578, 6, 4, 2, 841, 4, 12, 10); -- Yagudo Feather
INSERT INTO `gardening_results` VALUES (1579, 6, 4, 2, 1235, 4, 12, 10); -- Steel Nugget
INSERT INTO `gardening_results` VALUES (1580, 6, 4, 2, 839, 4, 8, 10); -- Crawler Cocoon
INSERT INTO `gardening_results` VALUES (1581, 6, 4, 2, 1234, 4, 12, 10); -- Iron Nugget
INSERT INTO `gardening_results` VALUES (1582, 6, 4, 3, 936, 12, 24, 25); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1583, 6, 4, 3, 4099, 12, 24, 15); -- Earth Crystal
INSERT INTO `gardening_results` VALUES (1584, 6, 4, 3, 4100, 12, 24, 10); -- Lightning Crystal
INSERT INTO `gardening_results` VALUES (1585, 6, 4, 3, 1230, 8, 16, 10); -- Copper Nugget
INSERT INTO `gardening_results` VALUES (1586, 6, 4, 3, 841, 4, 12, 10); -- Yagudo Feather
INSERT INTO `gardening_results` VALUES (1587, 6, 4, 3, 748, 1, 5, 10); -- Gold Beastcoin
INSERT INTO `gardening_results` VALUES (1588, 6, 4, 3, 839, 4, 8, 10); -- Crawler Cocoon
INSERT INTO `gardening_results` VALUES (1589, 6, 4, 3, 1234, 4, 12, 10); -- Iron Nugget
INSERT INTO `gardening_results` VALUES (1590, 6, 4, 4, 936, 12, 24, 20); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1591, 6, 4, 4, 4100, 12, 24, 20); -- Lightning Crystal
INSERT INTO `gardening_results` VALUES (1592, 6, 4, 4, 841, 4, 12, 20); -- Yagudo Feather
INSERT INTO `gardening_results` VALUES (1593, 6, 4, 4, 839, 4, 8, 20); -- Crawler Cocoon
INSERT INTO `gardening_results` VALUES (1594, 6, 4, 4, 1234, 4, 12, 20); -- Iron Nugget
INSERT INTO `gardening_results` VALUES (1595, 6, 4, 5, 936, 12, 24, 20); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1596, 6, 4, 5, 4100, 12, 24, 10); -- Lightning Crystal
INSERT INTO `gardening_results` VALUES (1597, 6, 4, 5, 4101, 12, 24, 10); -- Water Crystal
INSERT INTO `gardening_results` VALUES (1598, 6, 4, 5, 841, 4, 12, 10); -- Yagudo Feather
INSERT INTO `gardening_results` VALUES (1599, 6, 4, 5, 1233, 4, 12, 10); -- Silver Nugget
INSERT INTO `gardening_results` VALUES (1600, 6, 4, 5, 839, 4, 8, 10); -- Crawler Cocoon
INSERT INTO `gardening_results` VALUES (1601, 6, 4, 5, 918, 1, 2, 10); -- Mistletoe
INSERT INTO `gardening_results` VALUES (1602, 6, 4, 5, 1234, 4, 12, 10); -- Iron Nugget
INSERT INTO `gardening_results` VALUES (1603, 6, 4, 5, 749, 1, 5, 10); -- Mythril Beastcoin
INSERT INTO `gardening_results` VALUES (1604, 6, 4, 6, 936, 12, 24, 20); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1605, 6, 4, 6, 4100, 12, 24, 10); -- Lightning Crystal
INSERT INTO `gardening_results` VALUES (1606, 6, 4, 6, 4096, 12, 24, 10); -- Fire Crystal
INSERT INTO `gardening_results` VALUES (1607, 6, 4, 6, 841, 4, 12, 10); -- Yagudo Feather
INSERT INTO `gardening_results` VALUES (1608, 6, 4, 6, 1232, 8, 16, 10); -- Bronze Nugget
INSERT INTO `gardening_results` VALUES (1609, 6, 4, 6, 839, 4, 8, 10); -- Crawler Cocoon
INSERT INTO `gardening_results` VALUES (1610, 6, 4, 6, 750, 4, 8, 10); -- Silver Beastcoin
INSERT INTO `gardening_results` VALUES (1611, 6, 4, 6, 1234, 4, 12, 10); -- Iron Nugget
INSERT INTO `gardening_results` VALUES (1612, 6, 4, 6, 1226, 4, 12, 10); -- Mythril Nugget
INSERT INTO `gardening_results` VALUES (1613, 6, 4, 7, 936, 12, 24, 20); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1614, 6, 4, 7, 4100, 12, 24, 10); -- Lightning Crystal
INSERT INTO `gardening_results` VALUES (1615, 6, 4, 7, 4103, 12, 24, 10); -- Dark Crystal
INSERT INTO `gardening_results` VALUES (1616, 6, 4, 7, 841, 4, 12, 10); -- Yagudo Feather
INSERT INTO `gardening_results` VALUES (1617, 6, 4, 7, 4570, 4, 12, 10); -- Bird Egg
INSERT INTO `gardening_results` VALUES (1618, 6, 4, 7, 839, 4, 8, 10); -- Crawler Cocoon
INSERT INTO `gardening_results` VALUES (1619, 6, 4, 7, 842, 1, 5, 10); -- Giant Bird Feather
INSERT INTO `gardening_results` VALUES (1620, 6, 4, 7, 1234, 4, 12, 10); -- Iron Nugget
INSERT INTO `gardening_results` VALUES (1621, 6, 4, 7, 1227, 4, 12, 10); -- Platinum Nugget
INSERT INTO `gardening_results` VALUES (1622, 6, 4, 8, 936, 12, 24, 20); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1623, 6, 4, 8, 4100, 12, 24, 10); -- Lightning Crystal
INSERT INTO `gardening_results` VALUES (1624, 6, 4, 8, 4102, 12, 24, 10); -- Light Crystal
INSERT INTO `gardening_results` VALUES (1625, 6, 4, 8, 841, 4, 12, 10); -- Yagudo Feather
INSERT INTO `gardening_results` VALUES (1626, 6, 4, 8, 4274, 4, 8, 10); -- Persikos
INSERT INTO `gardening_results` VALUES (1627, 6, 4, 8, 839, 4, 8, 10); -- Crawler Cocoon
INSERT INTO `gardening_results` VALUES (1628, 6, 4, 8, 845, 4, 8, 10); -- Black Chocobo Feather
INSERT INTO `gardening_results` VALUES (1629, 6, 4, 8, 1234, 4, 12, 10); -- Iron Nugget
INSERT INTO `gardening_results` VALUES (1630, 6, 4, 8, 1228, 4, 12, 10); -- Darksteel Nugget
INSERT INTO `gardening_results` VALUES (1631, 6, 5, 0, 936, 4, 8, 23); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1632, 6, 5, 0, 17397, 24, 48, 13); -- Shell Bug
INSERT INTO `gardening_results` VALUES (1633, 6, 5, 0, 4101, 12, 24, 10); -- Water Crystal
INSERT INTO `gardening_results` VALUES (1634, 6, 5, 0, 1225, 4, 8, 10); -- Gold Nugget
INSERT INTO `gardening_results` VALUES (1635, 6, 5, 0, 1233, 4, 12, 10); -- Silver Nugget
INSERT INTO `gardening_results` VALUES (1636, 6, 5, 0, 1238, 1, 2, 14); -- Tree Saplings
INSERT INTO `gardening_results` VALUES (1637, 6, 5, 0, 918, 1, 2, 10); -- Mistletoe
INSERT INTO `gardening_results` VALUES (1638, 6, 5, 0, 749, 1, 5, 10); -- Mythril Beastcoin
INSERT INTO `gardening_results` VALUES (1639, 6, 5, 1, 936, 12, 24, 20); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1640, 6, 5, 1, 4097, 12, 24, 10); -- Ice Crystal
INSERT INTO `gardening_results` VALUES (1641, 6, 5, 1, 4101, 12, 24, 10); -- Water Crystal
INSERT INTO `gardening_results` VALUES (1642, 6, 5, 1, 1231, 12, 24, 10); -- Brass Nugget
INSERT INTO `gardening_results` VALUES (1643, 6, 5, 1, 1233, 4, 12, 10); -- Silver Nugget
INSERT INTO `gardening_results` VALUES (1644, 6, 5, 1, 941, 8, 16, 10); -- Red Rose
INSERT INTO `gardening_results` VALUES (1645, 6, 5, 1, 918, 1, 2, 10); -- Mistletoe
INSERT INTO `gardening_results` VALUES (1646, 6, 5, 1, 751, 1, 5, 10); -- Platinum Beastcoin
INSERT INTO `gardening_results` VALUES (1647, 6, 5, 1, 749, 1, 5, 10); -- Mythril Beastcoin
INSERT INTO `gardening_results` VALUES (1648, 6, 5, 2, 17396, 12, 24, 15); -- Little Worm
INSERT INTO `gardening_results` VALUES (1649, 6, 5, 2, 936, 12, 24, 10); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1650, 6, 5, 2, 4098, 12, 24, 15); -- Wind Crystal
INSERT INTO `gardening_results` VALUES (1651, 6, 5, 2, 4101, 12, 24, 10); -- Water Crystal
INSERT INTO `gardening_results` VALUES (1652, 6, 5, 2, 920, 4, 8, 10); -- Malboro Vine
INSERT INTO `gardening_results` VALUES (1653, 6, 5, 2, 1233, 4, 12, 10); -- Silver Nugget
INSERT INTO `gardening_results` VALUES (1654, 6, 5, 2, 1235, 4, 12, 10); -- Steel Nugget
INSERT INTO `gardening_results` VALUES (1655, 6, 5, 2, 918, 1, 2, 10); -- Mistletoe
INSERT INTO `gardening_results` VALUES (1656, 6, 5, 2, 749, 1, 5, 10); -- Mythril Beastcoin
INSERT INTO `gardening_results` VALUES (1657, 6, 5, 3, 936, 12, 24, 25); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1658, 6, 5, 3, 4099, 12, 24, 15); -- Earth Crystal
INSERT INTO `gardening_results` VALUES (1659, 6, 5, 3, 4101, 12, 24, 10); -- Water Crystal
INSERT INTO `gardening_results` VALUES (1660, 6, 5, 3, 1230, 8, 16, 10); -- Copper Nugget
INSERT INTO `gardening_results` VALUES (1661, 6, 5, 3, 1233, 4, 12, 10); -- Silver Nugget
INSERT INTO `gardening_results` VALUES (1662, 6, 5, 3, 748, 1, 5, 10); -- Gold Beastcoin
INSERT INTO `gardening_results` VALUES (1663, 6, 5, 3, 918, 1, 2, 10); -- Mistletoe
INSERT INTO `gardening_results` VALUES (1664, 6, 5, 3, 749, 1, 5, 10); -- Mythril Beastcoin
INSERT INTO `gardening_results` VALUES (1665, 6, 5, 4, 936, 12, 24, 20); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1666, 6, 5, 4, 4100, 12, 24, 10); -- Lightning Crystal
INSERT INTO `gardening_results` VALUES (1667, 6, 5, 4, 4101, 12, 24, 10); -- Water Crystal
INSERT INTO `gardening_results` VALUES (1668, 6, 5, 4, 841, 4, 12, 10); -- Yagudo Feather
INSERT INTO `gardening_results` VALUES (1669, 6, 5, 4, 1233, 4, 12, 10); -- Silver Nugget
INSERT INTO `gardening_results` VALUES (1670, 6, 5, 4, 839, 4, 8, 10); -- Crawler Cocoon
INSERT INTO `gardening_results` VALUES (1671, 6, 5, 4, 918, 1, 2, 10); -- Mistletoe
INSERT INTO `gardening_results` VALUES (1672, 6, 5, 4, 1234, 4, 12, 10); -- Iron Nugget
INSERT INTO `gardening_results` VALUES (1673, 6, 5, 4, 749, 1, 5, 10); -- Mythril Beastcoin
INSERT INTO `gardening_results` VALUES (1674, 6, 5, 5, 936, 12, 24, 20); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1675, 6, 5, 5, 4101, 12, 24, 20); -- Water Crystal
INSERT INTO `gardening_results` VALUES (1676, 6, 5, 5, 1233, 4, 12, 20); -- Silver Nugget
INSERT INTO `gardening_results` VALUES (1677, 6, 5, 5, 918, 1, 2, 20); -- Mistletoe
INSERT INTO `gardening_results` VALUES (1678, 6, 5, 5, 749, 1, 5, 20); -- Mythril Beastcoin
INSERT INTO `gardening_results` VALUES (1679, 6, 5, 6, 936, 12, 24, 20); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1680, 6, 5, 6, 4101, 12, 24, 10); -- Water Crystal
INSERT INTO `gardening_results` VALUES (1681, 6, 5, 6, 4096, 12, 24, 10); -- Fire Crystal
INSERT INTO `gardening_results` VALUES (1682, 6, 5, 6, 1233, 4, 12, 10); -- Silver Nugget
INSERT INTO `gardening_results` VALUES (1683, 6, 5, 6, 1232, 8, 16, 10); -- Bronze Nugget
INSERT INTO `gardening_results` VALUES (1684, 6, 5, 6, 918, 1, 2, 10); -- Mistletoe
INSERT INTO `gardening_results` VALUES (1685, 6, 5, 6, 750, 4, 8, 10); -- Silver Beastcoin
INSERT INTO `gardening_results` VALUES (1686, 6, 5, 6, 749, 1, 5, 10); -- Mythril Beastcoin
INSERT INTO `gardening_results` VALUES (1687, 6, 5, 6, 1226, 4, 12, 10); -- Mythril Nugget
INSERT INTO `gardening_results` VALUES (1688, 6, 5, 7, 936, 12, 24, 20); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1689, 6, 5, 7, 4101, 12, 24, 10); -- Water Crystal
INSERT INTO `gardening_results` VALUES (1690, 6, 5, 7, 4103, 12, 24, 10); -- Dark Crystal
INSERT INTO `gardening_results` VALUES (1691, 6, 5, 7, 1233, 4, 12, 10); -- Silver Nugget
INSERT INTO `gardening_results` VALUES (1692, 6, 5, 7, 4570, 4, 12, 10); -- Bird Egg
INSERT INTO `gardening_results` VALUES (1693, 6, 5, 7, 918, 1, 2, 10); -- Mistletoe
INSERT INTO `gardening_results` VALUES (1694, 6, 5, 7, 842, 1, 5, 10); -- Giant Bird Feather
INSERT INTO `gardening_results` VALUES (1695, 6, 5, 7, 749, 1, 5, 10); -- Mythril Beastcoin
INSERT INTO `gardening_results` VALUES (1696, 6, 5, 7, 1227, 4, 12, 10); -- Platinum Nugget
INSERT INTO `gardening_results` VALUES (1697, 6, 5, 8, 936, 12, 24, 20); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1698, 6, 5, 8, 4101, 12, 24, 10); -- Water Crystal
INSERT INTO `gardening_results` VALUES (1699, 6, 5, 8, 4102, 12, 24, 10); -- Light Crystal
INSERT INTO `gardening_results` VALUES (1700, 6, 5, 8, 1233, 4, 12, 10); -- Silver Nugget
INSERT INTO `gardening_results` VALUES (1701, 6, 5, 8, 4274, 4, 8, 10); -- Persikos
INSERT INTO `gardening_results` VALUES (1702, 6, 5, 8, 918, 1, 2, 10); -- Mistletoe
INSERT INTO `gardening_results` VALUES (1703, 6, 5, 8, 845, 4, 8, 10); -- Black Chocobo Feather
INSERT INTO `gardening_results` VALUES (1704, 6, 5, 8, 749, 1, 5, 10); -- Mythril Beastcoin
INSERT INTO `gardening_results` VALUES (1705, 6, 5, 8, 1228, 4, 12, 10); -- Darksteel Nugget
INSERT INTO `gardening_results` VALUES (1706, 6, 6, 0, 936, 4, 8, 23); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1707, 6, 6, 0, 17397, 24, 48, 13); -- Shell Bug
INSERT INTO `gardening_results` VALUES (1708, 6, 6, 0, 4096, 12, 24, 10); -- Fire Crystal
INSERT INTO `gardening_results` VALUES (1709, 6, 6, 0, 1225, 4, 8, 10); -- Gold Nugget
INSERT INTO `gardening_results` VALUES (1710, 6, 6, 0, 1232, 8, 16, 10); -- Bronze Nugget
INSERT INTO `gardening_results` VALUES (1711, 6, 6, 0, 1238, 1, 2, 14); -- Tree Saplings
INSERT INTO `gardening_results` VALUES (1712, 6, 6, 0, 750, 4, 8, 10); -- Silver Beastcoin
INSERT INTO `gardening_results` VALUES (1713, 6, 6, 0, 1226, 4, 12, 10); -- Mythril Nugget
INSERT INTO `gardening_results` VALUES (1714, 6, 6, 1, 936, 12, 24, 20); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1715, 6, 6, 1, 4097, 12, 24, 10); -- Ice Crystal
INSERT INTO `gardening_results` VALUES (1716, 6, 6, 1, 4096, 12, 24, 10); -- Fire Crystal
INSERT INTO `gardening_results` VALUES (1717, 6, 6, 1, 1231, 12, 24, 10); -- Brass Nugget
INSERT INTO `gardening_results` VALUES (1718, 6, 6, 1, 1232, 8, 16, 10); -- Bronze Nugget
INSERT INTO `gardening_results` VALUES (1719, 6, 6, 1, 941, 8, 16, 10); -- Red Rose
INSERT INTO `gardening_results` VALUES (1720, 6, 6, 1, 750, 4, 8, 10); -- Silver Beastcoin
INSERT INTO `gardening_results` VALUES (1721, 6, 6, 1, 751, 1, 5, 10); -- Platinum Beastcoin
INSERT INTO `gardening_results` VALUES (1722, 6, 6, 1, 1226, 4, 12, 10); -- Mythril Nugget
INSERT INTO `gardening_results` VALUES (1723, 6, 6, 2, 17396, 12, 24, 15); -- Little Worm
INSERT INTO `gardening_results` VALUES (1724, 6, 6, 2, 936, 12, 24, 10); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1725, 6, 6, 2, 4098, 12, 24, 15); -- Wind Crystal
INSERT INTO `gardening_results` VALUES (1726, 6, 6, 2, 4096, 12, 24, 10); -- Fire Crystal
INSERT INTO `gardening_results` VALUES (1727, 6, 6, 2, 920, 4, 8, 10); -- Malboro Vine
INSERT INTO `gardening_results` VALUES (1728, 6, 6, 2, 1232, 8, 16, 10); -- Bronze Nugget
INSERT INTO `gardening_results` VALUES (1729, 6, 6, 2, 1235, 4, 12, 10); -- Steel Nugget
INSERT INTO `gardening_results` VALUES (1730, 6, 6, 2, 750, 4, 8, 10); -- Silver Beastcoin
INSERT INTO `gardening_results` VALUES (1731, 6, 6, 2, 1226, 4, 12, 10); -- Mythril Nugget
INSERT INTO `gardening_results` VALUES (1732, 6, 6, 3, 936, 12, 24, 25); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1733, 6, 6, 3, 4099, 12, 24, 15); -- Earth Crystal
INSERT INTO `gardening_results` VALUES (1734, 6, 6, 3, 4096, 12, 24, 10); -- Fire Crystal
INSERT INTO `gardening_results` VALUES (1735, 6, 6, 3, 1230, 8, 16, 10); -- Copper Nugget
INSERT INTO `gardening_results` VALUES (1736, 6, 6, 3, 1232, 8, 16, 10); -- Bronze Nugget
INSERT INTO `gardening_results` VALUES (1737, 6, 6, 3, 748, 1, 5, 10); -- Gold Beastcoin
INSERT INTO `gardening_results` VALUES (1738, 6, 6, 3, 750, 4, 8, 10); -- Silver Beastcoin
INSERT INTO `gardening_results` VALUES (1739, 6, 6, 3, 1226, 4, 12, 10); -- Mythril Nugget
INSERT INTO `gardening_results` VALUES (1740, 6, 6, 4, 936, 12, 24, 20); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1741, 6, 6, 4, 4100, 12, 24, 10); -- Lightning Crystal
INSERT INTO `gardening_results` VALUES (1742, 6, 6, 4, 4096, 12, 24, 10); -- Fire Crystal
INSERT INTO `gardening_results` VALUES (1743, 6, 6, 4, 841, 4, 12, 10); -- Yagudo Feather
INSERT INTO `gardening_results` VALUES (1744, 6, 6, 4, 1232, 8, 16, 10); -- Bronze Nugget
INSERT INTO `gardening_results` VALUES (1745, 6, 6, 4, 839, 4, 8, 10); -- Crawler Cocoon
INSERT INTO `gardening_results` VALUES (1746, 6, 6, 4, 750, 4, 8, 10); -- Silver Beastcoin
INSERT INTO `gardening_results` VALUES (1747, 6, 6, 4, 1234, 4, 12, 10); -- Iron Nugget
INSERT INTO `gardening_results` VALUES (1748, 6, 6, 4, 1226, 4, 12, 10); -- Mythril Nugget
INSERT INTO `gardening_results` VALUES (1749, 6, 6, 5, 936, 12, 24, 20); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1750, 6, 6, 5, 4101, 12, 24, 10); -- Water Crystal
INSERT INTO `gardening_results` VALUES (1751, 6, 6, 5, 4096, 12, 24, 10); -- Fire Crystal
INSERT INTO `gardening_results` VALUES (1752, 6, 6, 5, 1233, 4, 12, 10); -- Silver Nugget
INSERT INTO `gardening_results` VALUES (1753, 6, 6, 5, 1232, 8, 16, 10); -- Bronze Nugget
INSERT INTO `gardening_results` VALUES (1754, 6, 6, 5, 918, 1, 2, 10); -- Mistletoe
INSERT INTO `gardening_results` VALUES (1755, 6, 6, 5, 750, 4, 8, 10); -- Silver Beastcoin
INSERT INTO `gardening_results` VALUES (1756, 6, 6, 5, 749, 1, 5, 10); -- Mythril Beastcoin
INSERT INTO `gardening_results` VALUES (1757, 6, 6, 5, 1226, 4, 12, 10); -- Mythril Nugget
INSERT INTO `gardening_results` VALUES (1758, 6, 6, 6, 936, 12, 24, 20); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1759, 6, 6, 6, 4096, 12, 24, 20); -- Fire Crystal
INSERT INTO `gardening_results` VALUES (1760, 6, 6, 6, 1232, 8, 16, 20); -- Bronze Nugget
INSERT INTO `gardening_results` VALUES (1761, 6, 6, 6, 750, 4, 8, 20); -- Silver Beastcoin
INSERT INTO `gardening_results` VALUES (1762, 6, 6, 6, 1226, 4, 12, 20); -- Mythril Nugget
INSERT INTO `gardening_results` VALUES (1763, 6, 6, 7, 936, 12, 24, 20); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1764, 6, 6, 7, 4096, 12, 24, 10); -- Fire Crystal
INSERT INTO `gardening_results` VALUES (1765, 6, 6, 7, 4103, 12, 24, 10); -- Dark Crystal
INSERT INTO `gardening_results` VALUES (1766, 6, 6, 7, 1232, 8, 16, 10); -- Bronze Nugget
INSERT INTO `gardening_results` VALUES (1767, 6, 6, 7, 4570, 4, 12, 10); -- Bird Egg
INSERT INTO `gardening_results` VALUES (1768, 6, 6, 7, 750, 4, 8, 10); -- Silver Beastcoin
INSERT INTO `gardening_results` VALUES (1769, 6, 6, 7, 842, 1, 5, 10); -- Giant Bird Feather
INSERT INTO `gardening_results` VALUES (1770, 6, 6, 7, 1226, 4, 12, 10); -- Mythril Nugget
INSERT INTO `gardening_results` VALUES (1771, 6, 6, 7, 1227, 4, 12, 10); -- Platinum Nugget
INSERT INTO `gardening_results` VALUES (1772, 6, 6, 8, 936, 12, 24, 20); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1773, 6, 6, 8, 4096, 12, 24, 10); -- Fire Crystal
INSERT INTO `gardening_results` VALUES (1774, 6, 6, 8, 4102, 12, 24, 10); -- Light Crystal
INSERT INTO `gardening_results` VALUES (1775, 6, 6, 8, 1232, 8, 16, 10); -- Bronze Nugget
INSERT INTO `gardening_results` VALUES (1776, 6, 6, 8, 4274, 4, 8, 10); -- Persikos
INSERT INTO `gardening_results` VALUES (1777, 6, 6, 8, 750, 4, 8, 10); -- Silver Beastcoin
INSERT INTO `gardening_results` VALUES (1778, 6, 6, 8, 845, 4, 8, 10); -- Black Chocobo Feather
INSERT INTO `gardening_results` VALUES (1779, 6, 6, 8, 1226, 4, 12, 10); -- Mythril Nugget
INSERT INTO `gardening_results` VALUES (1780, 6, 6, 8, 1228, 4, 12, 10); -- Darksteel Nugget
INSERT INTO `gardening_results` VALUES (1781, 6, 7, 0, 936, 4, 8, 23); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1782, 6, 7, 0, 17397, 24, 48, 13); -- Shell Bug
INSERT INTO `gardening_results` VALUES (1783, 6, 7, 0, 4103, 12, 24, 10); -- Dark Crystal
INSERT INTO `gardening_results` VALUES (1784, 6, 7, 0, 1225, 4, 8, 10); -- Gold Nugget
INSERT INTO `gardening_results` VALUES (1785, 6, 7, 0, 4570, 4, 12, 10); -- Bird Egg
INSERT INTO `gardening_results` VALUES (1786, 6, 7, 0, 1238, 1, 2, 14); -- Tree Saplings
INSERT INTO `gardening_results` VALUES (1787, 6, 7, 0, 842, 1, 5, 10); -- Giant Bird Feather
INSERT INTO `gardening_results` VALUES (1788, 6, 7, 0, 1227, 4, 12, 10); -- Platinum Nugget
INSERT INTO `gardening_results` VALUES (1789, 6, 7, 1, 936, 12, 24, 20); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1790, 6, 7, 1, 4097, 12, 24, 10); -- Ice Crystal
INSERT INTO `gardening_results` VALUES (1791, 6, 7, 1, 4103, 12, 24, 10); -- Dark Crystal
INSERT INTO `gardening_results` VALUES (1792, 6, 7, 1, 1231, 12, 24, 10); -- Brass Nugget
INSERT INTO `gardening_results` VALUES (1793, 6, 7, 1, 4570, 4, 12, 10); -- Bird Egg
INSERT INTO `gardening_results` VALUES (1794, 6, 7, 1, 941, 8, 16, 10); -- Red Rose
INSERT INTO `gardening_results` VALUES (1795, 6, 7, 1, 842, 1, 5, 10); -- Giant Bird Feather
INSERT INTO `gardening_results` VALUES (1796, 6, 7, 1, 751, 1, 5, 10); -- Platinum Beastcoin
INSERT INTO `gardening_results` VALUES (1797, 6, 7, 1, 1227, 4, 12, 10); -- Platinum Nugget
INSERT INTO `gardening_results` VALUES (1798, 6, 7, 2, 17396, 12, 24, 15); -- Little Worm
INSERT INTO `gardening_results` VALUES (1799, 6, 7, 2, 936, 12, 24, 10); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1800, 6, 7, 2, 4098, 12, 24, 15); -- Wind Crystal
INSERT INTO `gardening_results` VALUES (1801, 6, 7, 2, 4103, 12, 24, 10); -- Dark Crystal
INSERT INTO `gardening_results` VALUES (1802, 6, 7, 2, 920, 4, 8, 10); -- Malboro Vine
INSERT INTO `gardening_results` VALUES (1803, 6, 7, 2, 4570, 4, 12, 10); -- Bird Egg
INSERT INTO `gardening_results` VALUES (1804, 6, 7, 2, 1235, 4, 12, 10); -- Steel Nugget
INSERT INTO `gardening_results` VALUES (1805, 6, 7, 2, 842, 1, 5, 10); -- Giant Bird Feather
INSERT INTO `gardening_results` VALUES (1806, 6, 7, 2, 1227, 4, 12, 10); -- Platinum Nugget
INSERT INTO `gardening_results` VALUES (1807, 6, 7, 3, 936, 12, 24, 25); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1808, 6, 7, 3, 4099, 12, 24, 15); -- Earth Crystal
INSERT INTO `gardening_results` VALUES (1809, 6, 7, 3, 4103, 12, 24, 10); -- Dark Crystal
INSERT INTO `gardening_results` VALUES (1810, 6, 7, 3, 1230, 8, 16, 10); -- Copper Nugget
INSERT INTO `gardening_results` VALUES (1811, 6, 7, 3, 4570, 4, 12, 10); -- Bird Egg
INSERT INTO `gardening_results` VALUES (1812, 6, 7, 3, 748, 1, 5, 10); -- Gold Beastcoin
INSERT INTO `gardening_results` VALUES (1813, 6, 7, 3, 842, 1, 5, 10); -- Giant Bird Feather
INSERT INTO `gardening_results` VALUES (1814, 6, 7, 3, 1227, 4, 12, 10); -- Platinum Nugget
INSERT INTO `gardening_results` VALUES (1815, 6, 7, 4, 936, 12, 24, 20); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1816, 6, 7, 4, 4100, 12, 24, 10); -- Lightning Crystal
INSERT INTO `gardening_results` VALUES (1817, 6, 7, 4, 4103, 12, 24, 10); -- Dark Crystal
INSERT INTO `gardening_results` VALUES (1818, 6, 7, 4, 841, 4, 12, 10); -- Yagudo Feather
INSERT INTO `gardening_results` VALUES (1819, 6, 7, 4, 4570, 4, 12, 10); -- Bird Egg
INSERT INTO `gardening_results` VALUES (1820, 6, 7, 4, 839, 4, 8, 10); -- Crawler Cocoon
INSERT INTO `gardening_results` VALUES (1821, 6, 7, 4, 842, 1, 5, 10); -- Giant Bird Feather
INSERT INTO `gardening_results` VALUES (1822, 6, 7, 4, 1234, 4, 12, 10); -- Iron Nugget
INSERT INTO `gardening_results` VALUES (1823, 6, 7, 4, 1227, 4, 12, 10); -- Platinum Nugget
INSERT INTO `gardening_results` VALUES (1824, 6, 7, 5, 936, 12, 24, 20); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1825, 6, 7, 5, 4101, 12, 24, 10); -- Water Crystal
INSERT INTO `gardening_results` VALUES (1826, 6, 7, 5, 4103, 12, 24, 10); -- Dark Crystal
INSERT INTO `gardening_results` VALUES (1827, 6, 7, 5, 1233, 4, 12, 10); -- Silver Nugget
INSERT INTO `gardening_results` VALUES (1828, 6, 7, 5, 4570, 4, 12, 10); -- Bird Egg
INSERT INTO `gardening_results` VALUES (1829, 6, 7, 5, 918, 1, 2, 10); -- Mistletoe
INSERT INTO `gardening_results` VALUES (1830, 6, 7, 5, 842, 1, 5, 10); -- Giant Bird Feather
INSERT INTO `gardening_results` VALUES (1831, 6, 7, 5, 749, 1, 5, 10); -- Mythril Beastcoin
INSERT INTO `gardening_results` VALUES (1832, 6, 7, 5, 1227, 4, 12, 10); -- Platinum Nugget
INSERT INTO `gardening_results` VALUES (1833, 6, 7, 6, 936, 12, 24, 20); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1834, 6, 7, 6, 4096, 12, 24, 10); -- Fire Crystal
INSERT INTO `gardening_results` VALUES (1835, 6, 7, 6, 4103, 12, 24, 10); -- Dark Crystal
INSERT INTO `gardening_results` VALUES (1836, 6, 7, 6, 1232, 8, 16, 10); -- Bronze Nugget
INSERT INTO `gardening_results` VALUES (1837, 6, 7, 6, 4570, 4, 12, 10); -- Bird Egg
INSERT INTO `gardening_results` VALUES (1838, 6, 7, 6, 750, 4, 8, 10); -- Silver Beastcoin
INSERT INTO `gardening_results` VALUES (1839, 6, 7, 6, 842, 1, 5, 10); -- Giant Bird Feather
INSERT INTO `gardening_results` VALUES (1840, 6, 7, 6, 1226, 4, 12, 10); -- Mythril Nugget
INSERT INTO `gardening_results` VALUES (1841, 6, 7, 6, 1227, 4, 12, 10); -- Platinum Nugget
INSERT INTO `gardening_results` VALUES (1842, 6, 7, 7, 936, 12, 24, 20); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1843, 6, 7, 7, 4103, 12, 24, 20); -- Dark Crystal
INSERT INTO `gardening_results` VALUES (1844, 6, 7, 7, 4570, 4, 12, 20); -- Bird Egg
INSERT INTO `gardening_results` VALUES (1845, 6, 7, 7, 842, 1, 5, 20); -- Giant Bird Feather
INSERT INTO `gardening_results` VALUES (1846, 6, 7, 7, 1227, 4, 12, 20); -- Platinum Nugget
INSERT INTO `gardening_results` VALUES (1847, 6, 7, 8, 936, 12, 24, 20); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1848, 6, 7, 8, 4103, 12, 24, 10); -- Dark Crystal
INSERT INTO `gardening_results` VALUES (1849, 6, 7, 8, 4102, 12, 24, 10); -- Light Crystal
INSERT INTO `gardening_results` VALUES (1850, 6, 7, 8, 4570, 4, 12, 10); -- Bird Egg
INSERT INTO `gardening_results` VALUES (1851, 6, 7, 8, 4274, 4, 8, 10); -- Persikos
INSERT INTO `gardening_results` VALUES (1852, 6, 7, 8, 842, 1, 5, 10); -- Giant Bird Feather
INSERT INTO `gardening_results` VALUES (1853, 6, 7, 8, 845, 4, 8, 10); -- Black Chocobo Feather
INSERT INTO `gardening_results` VALUES (1854, 6, 7, 8, 1227, 4, 12, 10); -- Platinum Nugget
INSERT INTO `gardening_results` VALUES (1855, 6, 7, 8, 1228, 4, 12, 10); -- Darksteel Nugget
INSERT INTO `gardening_results` VALUES (1856, 6, 8, 0, 936, 4, 8, 23); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1857, 6, 8, 0, 17397, 24, 48, 13); -- Shell Bug
INSERT INTO `gardening_results` VALUES (1858, 6, 8, 0, 4102, 12, 24, 10); -- Light Crystal
INSERT INTO `gardening_results` VALUES (1859, 6, 8, 0, 1225, 4, 8, 10); -- Gold Nugget
INSERT INTO `gardening_results` VALUES (1860, 6, 8, 0, 4274, 4, 8, 10); -- Persikos
INSERT INTO `gardening_results` VALUES (1861, 6, 8, 0, 1238, 1, 2, 14); -- Tree Saplings
INSERT INTO `gardening_results` VALUES (1862, 6, 8, 0, 845, 4, 8, 10); -- Black Chocobo Feather
INSERT INTO `gardening_results` VALUES (1863, 6, 8, 0, 1228, 4, 12, 10); -- Darksteel Nugget
INSERT INTO `gardening_results` VALUES (1864, 6, 8, 1, 936, 12, 24, 20); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1865, 6, 8, 1, 4097, 12, 24, 10); -- Ice Crystal
INSERT INTO `gardening_results` VALUES (1866, 6, 8, 1, 4102, 12, 24, 10); -- Light Crystal
INSERT INTO `gardening_results` VALUES (1867, 6, 8, 1, 1231, 12, 24, 10); -- Brass Nugget
INSERT INTO `gardening_results` VALUES (1868, 6, 8, 1, 4274, 4, 8, 10); -- Persikos
INSERT INTO `gardening_results` VALUES (1869, 6, 8, 1, 941, 8, 16, 10); -- Red Rose
INSERT INTO `gardening_results` VALUES (1870, 6, 8, 1, 845, 4, 8, 10); -- Black Chocobo Feather
INSERT INTO `gardening_results` VALUES (1871, 6, 8, 1, 751, 1, 5, 10); -- Platinum Beastcoin
INSERT INTO `gardening_results` VALUES (1872, 6, 8, 1, 1228, 4, 12, 10); -- Darksteel Nugget
INSERT INTO `gardening_results` VALUES (1873, 6, 8, 2, 17396, 12, 24, 15); -- Little Worm
INSERT INTO `gardening_results` VALUES (1874, 6, 8, 2, 936, 12, 24, 10); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1875, 6, 8, 2, 4098, 12, 24, 15); -- Wind Crystal
INSERT INTO `gardening_results` VALUES (1876, 6, 8, 2, 4102, 12, 24, 10); -- Light Crystal
INSERT INTO `gardening_results` VALUES (1877, 6, 8, 2, 920, 4, 8, 10); -- Malboro Vine
INSERT INTO `gardening_results` VALUES (1878, 6, 8, 2, 4274, 4, 8, 10); -- Persikos
INSERT INTO `gardening_results` VALUES (1879, 6, 8, 2, 1235, 4, 12, 10); -- Steel Nugget
INSERT INTO `gardening_results` VALUES (1880, 6, 8, 2, 845, 4, 8, 10); -- Black Chocobo Feather
INSERT INTO `gardening_results` VALUES (1881, 6, 8, 2, 1228, 4, 12, 10); -- Darksteel Nugget
INSERT INTO `gardening_results` VALUES (1882, 6, 8, 3, 936, 12, 24, 25); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1883, 6, 8, 3, 4099, 12, 24, 15); -- Earth Crystal
INSERT INTO `gardening_results` VALUES (1884, 6, 8, 3, 4102, 12, 24, 10); -- Light Crystal
INSERT INTO `gardening_results` VALUES (1885, 6, 8, 3, 1230, 8, 16, 10); -- Copper Nugget
INSERT INTO `gardening_results` VALUES (1886, 6, 8, 3, 4274, 4, 8, 10); -- Persikos
INSERT INTO `gardening_results` VALUES (1887, 6, 8, 3, 748, 1, 5, 10); -- Gold Beastcoin
INSERT INTO `gardening_results` VALUES (1888, 6, 8, 3, 845, 4, 8, 10); -- Black Chocobo Feather
INSERT INTO `gardening_results` VALUES (1889, 6, 8, 3, 1228, 4, 12, 10); -- Darksteel Nugget
INSERT INTO `gardening_results` VALUES (1890, 6, 8, 4, 936, 12, 24, 20); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1891, 6, 8, 4, 4100, 12, 24, 10); -- Lightning Crystal
INSERT INTO `gardening_results` VALUES (1892, 6, 8, 4, 4102, 12, 24, 10); -- Light Crystal
INSERT INTO `gardening_results` VALUES (1893, 6, 8, 4, 841, 4, 12, 10); -- Yagudo Feather
INSERT INTO `gardening_results` VALUES (1894, 6, 8, 4, 4274, 4, 8, 10); -- Persikos
INSERT INTO `gardening_results` VALUES (1895, 6, 8, 4, 839, 4, 8, 10); -- Crawler Cocoon
INSERT INTO `gardening_results` VALUES (1896, 6, 8, 4, 845, 4, 8, 10); -- Black Chocobo Feather
INSERT INTO `gardening_results` VALUES (1897, 6, 8, 4, 1234, 4, 12, 10); -- Iron Nugget
INSERT INTO `gardening_results` VALUES (1898, 6, 8, 4, 1228, 4, 12, 10); -- Darksteel Nugget
INSERT INTO `gardening_results` VALUES (1899, 6, 8, 5, 936, 12, 24, 20); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1900, 6, 8, 5, 4101, 12, 24, 10); -- Water Crystal
INSERT INTO `gardening_results` VALUES (1901, 6, 8, 5, 4102, 12, 24, 10); -- Light Crystal
INSERT INTO `gardening_results` VALUES (1902, 6, 8, 5, 1233, 4, 12, 10); -- Silver Nugget
INSERT INTO `gardening_results` VALUES (1903, 6, 8, 5, 4274, 4, 8, 10); -- Persikos
INSERT INTO `gardening_results` VALUES (1904, 6, 8, 5, 918, 1, 2, 10); -- Mistletoe
INSERT INTO `gardening_results` VALUES (1905, 6, 8, 5, 845, 4, 8, 10); -- Black Chocobo Feather
INSERT INTO `gardening_results` VALUES (1906, 6, 8, 5, 749, 1, 5, 10); -- Mythril Beastcoin
INSERT INTO `gardening_results` VALUES (1907, 6, 8, 5, 1228, 4, 12, 10); -- Darksteel Nugget
INSERT INTO `gardening_results` VALUES (1908, 6, 8, 6, 936, 12, 24, 20); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1909, 6, 8, 6, 4096, 12, 24, 10); -- Fire Crystal
INSERT INTO `gardening_results` VALUES (1910, 6, 8, 6, 4102, 12, 24, 10); -- Light Crystal
INSERT INTO `gardening_results` VALUES (1911, 6, 8, 6, 1232, 8, 16, 10); -- Bronze Nugget
INSERT INTO `gardening_results` VALUES (1912, 6, 8, 6, 4274, 4, 8, 10); -- Persikos
INSERT INTO `gardening_results` VALUES (1913, 6, 8, 6, 750, 4, 8, 10); -- Silver Beastcoin
INSERT INTO `gardening_results` VALUES (1914, 6, 8, 6, 845, 4, 8, 10); -- Black Chocobo Feather
INSERT INTO `gardening_results` VALUES (1915, 6, 8, 6, 1226, 4, 12, 10); -- Mythril Nugget
INSERT INTO `gardening_results` VALUES (1916, 6, 8, 6, 1228, 4, 12, 10); -- Darksteel Nugget
INSERT INTO `gardening_results` VALUES (1917, 6, 8, 7, 936, 12, 24, 20); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1918, 6, 8, 7, 4103, 12, 24, 10); -- Dark Crystal
INSERT INTO `gardening_results` VALUES (1919, 6, 8, 7, 4102, 12, 24, 10); -- Light Crystal
INSERT INTO `gardening_results` VALUES (1920, 6, 8, 7, 4570, 4, 12, 10); -- Bird Egg
INSERT INTO `gardening_results` VALUES (1921, 6, 8, 7, 4274, 4, 8, 10); -- Persikos
INSERT INTO `gardening_results` VALUES (1922, 6, 8, 7, 842, 1, 5, 10); -- Giant Bird Feather
INSERT INTO `gardening_results` VALUES (1923, 6, 8, 7, 845, 4, 8, 10); -- Black Chocobo Feather
INSERT INTO `gardening_results` VALUES (1924, 6, 8, 7, 1227, 4, 12, 10); -- Platinum Nugget
INSERT INTO `gardening_results` VALUES (1925, 6, 8, 7, 1228, 4, 12, 10); -- Darksteel Nugget
INSERT INTO `gardening_results` VALUES (1926, 6, 8, 8, 936, 12, 24, 20); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1927, 6, 8, 8, 4102, 12, 24, 20); -- Light Crystal
INSERT INTO `gardening_results` VALUES (1928, 6, 8, 8, 4274, 4, 8, 20); -- Persikos
INSERT INTO `gardening_results` VALUES (1929, 6, 8, 8, 845, 4, 8, 20); -- Black Chocobo Feather
INSERT INTO `gardening_results` VALUES (1930, 6, 8, 8, 1228, 4, 12, 20); -- Darksteel Nugget
INSERT INTO `gardening_results` VALUES (1931, 7, 0, 0, 936, 12, 24, 30); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1932, 7, 0, 0, 4449, 1, 2, 30); -- Reishi Mushroom
INSERT INTO `gardening_results` VALUES (1933, 7, 0, 0, 1309, 4, 12, 28); -- Gold Leaf
INSERT INTO `gardening_results` VALUES (1934, 7, 0, 0, 1261, 1, 2, 12); -- Light Ore
INSERT INTO `gardening_results` VALUES (1935, 7, 0, 1, 936, 12, 24, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1936, 7, 0, 1, 4105, 1, 2, 24); -- Ice Cluster
INSERT INTO `gardening_results` VALUES (1937, 7, 0, 1, 4449, 1, 2, 15); -- Reishi Mushroom
INSERT INTO `gardening_results` VALUES (1938, 7, 0, 1, 628, 1, 2, 20); -- Cinnamon
INSERT INTO `gardening_results` VALUES (1939, 7, 0, 1, 1309, 4, 12, 14); -- Gold Leaf
INSERT INTO `gardening_results` VALUES (1940, 7, 0, 1, 1255, 1, 2, 6); -- Fire Ore
INSERT INTO `gardening_results` VALUES (1941, 7, 0, 1, 1261, 1, 2, 6); -- Light Ore
INSERT INTO `gardening_results` VALUES (1942, 7, 0, 2, 936, 12, 24, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1943, 7, 0, 2, 4106, 1, 2, 24); -- Wind Cluster
INSERT INTO `gardening_results` VALUES (1944, 7, 0, 2, 4449, 1, 2, 15); -- Reishi Mushroom
INSERT INTO `gardening_results` VALUES (1945, 7, 0, 2, 1310, 6, 12, 20); -- Platinum Leaf
INSERT INTO `gardening_results` VALUES (1946, 7, 0, 2, 1309, 4, 12, 14); -- Gold Leaf
INSERT INTO `gardening_results` VALUES (1947, 7, 0, 2, 1256, 1, 2, 6); -- Ice Ore
INSERT INTO `gardening_results` VALUES (1948, 7, 0, 2, 1261, 1, 2, 6); -- Light Ore
INSERT INTO `gardening_results` VALUES (1949, 7, 0, 3, 936, 12, 24, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1950, 7, 0, 3, 4107, 1, 2, 24); -- Earth Cluster
INSERT INTO `gardening_results` VALUES (1951, 7, 0, 3, 4449, 1, 2, 15); -- Reishi Mushroom
INSERT INTO `gardening_results` VALUES (1952, 7, 0, 3, 635, 24, 48, 20); -- Clump Of Windurstian Tea Leaves
INSERT INTO `gardening_results` VALUES (1953, 7, 0, 3, 1309, 4, 12, 14); -- Gold Leaf
INSERT INTO `gardening_results` VALUES (1954, 7, 0, 3, 1257, 1, 2, 6); -- Wind Ore
INSERT INTO `gardening_results` VALUES (1955, 7, 0, 3, 1261, 1, 2, 6); -- Light Ore
INSERT INTO `gardening_results` VALUES (1956, 7, 0, 4, 936, 12, 24, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1957, 7, 0, 4, 4108, 1, 2, 24); -- Lightning Cluster
INSERT INTO `gardening_results` VALUES (1958, 7, 0, 4, 4449, 1, 2, 15); -- Reishi Mushroom
INSERT INTO `gardening_results` VALUES (1959, 7, 0, 4, 4273, 8, 16, 20); -- Kitron
INSERT INTO `gardening_results` VALUES (1960, 7, 0, 4, 1309, 4, 12, 14); -- Gold Leaf
INSERT INTO `gardening_results` VALUES (1961, 7, 0, 4, 1258, 1, 2, 6); -- Earth Ore
INSERT INTO `gardening_results` VALUES (1962, 7, 0, 4, 1261, 1, 2, 6); -- Light Ore
INSERT INTO `gardening_results` VALUES (1963, 7, 0, 5, 936, 12, 24, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1964, 7, 0, 5, 4109, 1, 2, 24); -- Water Cluster
INSERT INTO `gardening_results` VALUES (1965, 7, 0, 5, 4449, 1, 2, 15); -- Reishi Mushroom
INSERT INTO `gardening_results` VALUES (1966, 7, 0, 5, 1307, 8, 16, 20); -- Silver Leaf
INSERT INTO `gardening_results` VALUES (1967, 7, 0, 5, 1309, 4, 12, 14); -- Gold Leaf
INSERT INTO `gardening_results` VALUES (1968, 7, 0, 5, 1259, 1, 2, 6); -- Lightning Ore
INSERT INTO `gardening_results` VALUES (1969, 7, 0, 5, 1261, 1, 2, 6); -- Light Ore
INSERT INTO `gardening_results` VALUES (1970, 7, 0, 6, 936, 12, 24, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1971, 7, 0, 6, 4104, 1, 2, 24); -- Fire Cluster
INSERT INTO `gardening_results` VALUES (1972, 7, 0, 6, 4449, 1, 2, 15); -- Reishi Mushroom
INSERT INTO `gardening_results` VALUES (1973, 7, 0, 6, 1308, 6, 12, 20); -- Mythril Leaf
INSERT INTO `gardening_results` VALUES (1974, 7, 0, 6, 1309, 4, 12, 14); -- Gold Leaf
INSERT INTO `gardening_results` VALUES (1975, 7, 0, 6, 1260, 1, 2, 6); -- Water Ore
INSERT INTO `gardening_results` VALUES (1976, 7, 0, 6, 1261, 1, 2, 6); -- Light Ore
INSERT INTO `gardening_results` VALUES (1977, 7, 0, 7, 936, 12, 24, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1978, 7, 0, 7, 17397, 24, 48, 15); -- Shell Bug
INSERT INTO `gardening_results` VALUES (1979, 7, 0, 7, 4449, 1, 2, 15); -- Reishi Mushroom
INSERT INTO `gardening_results` VALUES (1980, 7, 0, 7, 4111, 1, 2, 15); -- Dark Cluster
INSERT INTO `gardening_results` VALUES (1981, 7, 0, 7, 1309, 4, 12, 34); -- Gold Leaf
INSERT INTO `gardening_results` VALUES (1982, 7, 0, 7, 1261, 1, 2, 6); -- Light Ore
INSERT INTO `gardening_results` VALUES (1983, 7, 0, 8, 936, 12, 24, 30); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1984, 7, 0, 8, 4449, 1, 2, 15); -- Reishi Mushroom
INSERT INTO `gardening_results` VALUES (1985, 7, 0, 8, 4110, 1, 2, 15); -- Light Cluster
INSERT INTO `gardening_results` VALUES (1986, 7, 0, 8, 1309, 4, 12, 14); -- Gold Leaf
INSERT INTO `gardening_results` VALUES (1987, 7, 0, 8, 4274, 4, 8, 14); -- Persikos
INSERT INTO `gardening_results` VALUES (1988, 7, 0, 8, 1261, 1, 2, 6); -- Light Ore
INSERT INTO `gardening_results` VALUES (1989, 7, 0, 8, 1262, 1, 2, 6); -- Dark Ore
INSERT INTO `gardening_results` VALUES (1990, 7, 1, 0, 936, 12, 24, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (1991, 7, 1, 0, 4105, 1, 2, 24); -- Ice Cluster
INSERT INTO `gardening_results` VALUES (1992, 7, 1, 0, 4449, 1, 2, 15); -- Reishi Mushroom
INSERT INTO `gardening_results` VALUES (1993, 7, 1, 0, 628, 1, 2, 20); -- Cinnamon
INSERT INTO `gardening_results` VALUES (1994, 7, 1, 0, 1309, 4, 12, 14); -- Gold Leaf
INSERT INTO `gardening_results` VALUES (1995, 7, 1, 0, 1255, 1, 2, 6); -- Fire Ore
INSERT INTO `gardening_results` VALUES (1996, 7, 1, 0, 1261, 1, 2, 6); -- Light Ore
INSERT INTO `gardening_results` VALUES (1997, 7, 1, 1, 4105, 1, 2, 48); -- Ice Cluster
INSERT INTO `gardening_results` VALUES (1998, 7, 1, 1, 628, 1, 2, 40); -- Cinnamon
INSERT INTO `gardening_results` VALUES (1999, 7, 1, 1, 1255, 1, 2, 12); -- Fire Ore
INSERT INTO `gardening_results` VALUES (2000, 7, 1, 2, 4105, 1, 2, 24); -- Ice Cluster
INSERT INTO `gardening_results` VALUES (2001, 7, 1, 2, 4106, 1, 2, 24); -- Wind Cluster
INSERT INTO `gardening_results` VALUES (2002, 7, 1, 2, 628, 1, 2, 20); -- Cinnamon
INSERT INTO `gardening_results` VALUES (2003, 7, 1, 2, 1310, 6, 12, 20); -- Platinum Leaf
INSERT INTO `gardening_results` VALUES (2004, 7, 1, 2, 1255, 1, 2, 6); -- Fire Ore
INSERT INTO `gardening_results` VALUES (2005, 7, 1, 2, 1256, 1, 2, 6); -- Ice Ore
INSERT INTO `gardening_results` VALUES (2006, 7, 1, 3, 4105, 1, 2, 24); -- Ice Cluster
INSERT INTO `gardening_results` VALUES (2007, 7, 1, 3, 4107, 1, 2, 24); -- Earth Cluster
INSERT INTO `gardening_results` VALUES (2008, 7, 1, 3, 628, 1, 2, 20); -- Cinnamon
INSERT INTO `gardening_results` VALUES (2009, 7, 1, 3, 635, 24, 48, 20); -- Clump Of Windurstian Tea Leaves
INSERT INTO `gardening_results` VALUES (2010, 7, 1, 3, 1255, 1, 2, 6); -- Fire Ore
INSERT INTO `gardening_results` VALUES (2011, 7, 1, 3, 1257, 1, 2, 6); -- Wind Ore
INSERT INTO `gardening_results` VALUES (2012, 7, 1, 4, 4105, 1, 2, 24); -- Ice Cluster
INSERT INTO `gardening_results` VALUES (2013, 7, 1, 4, 4108, 1, 2, 24); -- Lightning Cluster
INSERT INTO `gardening_results` VALUES (2014, 7, 1, 4, 628, 1, 2, 20); -- Cinnamon
INSERT INTO `gardening_results` VALUES (2015, 7, 1, 4, 4273, 8, 16, 20); -- Kitron
INSERT INTO `gardening_results` VALUES (2016, 7, 1, 4, 1255, 1, 2, 6); -- Fire Ore
INSERT INTO `gardening_results` VALUES (2017, 7, 1, 4, 1258, 1, 2, 6); -- Earth Ore
INSERT INTO `gardening_results` VALUES (2018, 7, 1, 5, 4105, 1, 2, 24); -- Ice Cluster
INSERT INTO `gardening_results` VALUES (2019, 7, 1, 5, 4109, 1, 2, 24); -- Water Cluster
INSERT INTO `gardening_results` VALUES (2020, 7, 1, 5, 628, 1, 2, 20); -- Cinnamon
INSERT INTO `gardening_results` VALUES (2021, 7, 1, 5, 1307, 8, 16, 20); -- Silver Leaf
INSERT INTO `gardening_results` VALUES (2022, 7, 1, 5, 1255, 1, 2, 6); -- Fire Ore
INSERT INTO `gardening_results` VALUES (2023, 7, 1, 5, 1259, 1, 2, 6); -- Lightning Ore
INSERT INTO `gardening_results` VALUES (2024, 7, 1, 6, 4105, 1, 2, 24); -- Ice Cluster
INSERT INTO `gardening_results` VALUES (2025, 7, 1, 6, 4104, 1, 2, 24); -- Fire Cluster
INSERT INTO `gardening_results` VALUES (2026, 7, 1, 6, 628, 1, 2, 20); -- Cinnamon
INSERT INTO `gardening_results` VALUES (2027, 7, 1, 6, 1308, 6, 12, 20); -- Mythril Leaf
INSERT INTO `gardening_results` VALUES (2028, 7, 1, 6, 1255, 1, 2, 6); -- Fire Ore
INSERT INTO `gardening_results` VALUES (2029, 7, 1, 6, 1260, 1, 2, 6); -- Water Ore
INSERT INTO `gardening_results` VALUES (2030, 7, 1, 7, 4105, 1, 2, 24); -- Ice Cluster
INSERT INTO `gardening_results` VALUES (2031, 7, 1, 7, 17397, 24, 48, 15); -- Shell Bug
INSERT INTO `gardening_results` VALUES (2032, 7, 1, 7, 628, 1, 2, 20); -- Cinnamon
INSERT INTO `gardening_results` VALUES (2033, 7, 1, 7, 4111, 1, 2, 15); -- Dark Cluster
INSERT INTO `gardening_results` VALUES (2034, 7, 1, 7, 1255, 1, 2, 6); -- Fire Ore
INSERT INTO `gardening_results` VALUES (2035, 7, 1, 7, 1309, 4, 12, 20); -- Gold Leaf
INSERT INTO `gardening_results` VALUES (2036, 7, 1, 8, 4105, 1, 2, 24); -- Ice Cluster
INSERT INTO `gardening_results` VALUES (2037, 7, 1, 8, 936, 12, 24, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (2038, 7, 1, 8, 628, 1, 2, 20); -- Cinnamon
INSERT INTO `gardening_results` VALUES (2039, 7, 1, 8, 4110, 1, 2, 15); -- Light Cluster
INSERT INTO `gardening_results` VALUES (2040, 7, 1, 8, 1255, 1, 2, 6); -- Fire Ore
INSERT INTO `gardening_results` VALUES (2041, 7, 1, 8, 4274, 4, 8, 14); -- Persikos
INSERT INTO `gardening_results` VALUES (2042, 7, 1, 8, 1262, 1, 2, 6); -- Dark Ore
INSERT INTO `gardening_results` VALUES (2043, 7, 2, 0, 936, 12, 24, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (2044, 7, 2, 0, 4106, 1, 2, 24); -- Wind Cluster
INSERT INTO `gardening_results` VALUES (2045, 7, 2, 0, 4449, 1, 2, 15); -- Reishi Mushroom
INSERT INTO `gardening_results` VALUES (2046, 7, 2, 0, 1310, 6, 12, 20); -- Platinum Leaf
INSERT INTO `gardening_results` VALUES (2047, 7, 2, 0, 1309, 4, 12, 14); -- Gold Leaf
INSERT INTO `gardening_results` VALUES (2048, 7, 2, 0, 1256, 1, 2, 6); -- Ice Ore
INSERT INTO `gardening_results` VALUES (2049, 7, 2, 0, 1261, 1, 2, 6); -- Light Ore
INSERT INTO `gardening_results` VALUES (2050, 7, 2, 1, 4105, 1, 2, 24); -- Ice Cluster
INSERT INTO `gardening_results` VALUES (2051, 7, 2, 1, 4106, 1, 2, 24); -- Wind Cluster
INSERT INTO `gardening_results` VALUES (2052, 7, 2, 1, 628, 1, 2, 20); -- Cinnamon
INSERT INTO `gardening_results` VALUES (2053, 7, 2, 1, 1310, 6, 12, 20); -- Platinum Leaf
INSERT INTO `gardening_results` VALUES (2054, 7, 2, 1, 1255, 1, 2, 6); -- Fire Ore
INSERT INTO `gardening_results` VALUES (2055, 7, 2, 1, 1256, 1, 2, 6); -- Ice Ore
INSERT INTO `gardening_results` VALUES (2056, 7, 2, 2, 4106, 1, 2, 48); -- Wind Cluster
INSERT INTO `gardening_results` VALUES (2057, 7, 2, 2, 1310, 6, 12, 40); -- Platinum Leaf
INSERT INTO `gardening_results` VALUES (2058, 7, 2, 2, 1256, 1, 2, 12); -- Ice Ore
INSERT INTO `gardening_results` VALUES (2059, 7, 2, 3, 4106, 1, 2, 24); -- Wind Cluster
INSERT INTO `gardening_results` VALUES (2060, 7, 2, 3, 4107, 1, 2, 24); -- Earth Cluster
INSERT INTO `gardening_results` VALUES (2061, 7, 2, 3, 1310, 6, 12, 20); -- Platinum Leaf
INSERT INTO `gardening_results` VALUES (2062, 7, 2, 3, 635, 24, 48, 20); -- Clump Of Windurstian Tea Leaves
INSERT INTO `gardening_results` VALUES (2063, 7, 2, 3, 1256, 1, 2, 6); -- Ice Ore
INSERT INTO `gardening_results` VALUES (2064, 7, 2, 3, 1257, 1, 2, 6); -- Wind Ore
INSERT INTO `gardening_results` VALUES (2065, 7, 2, 4, 4106, 1, 2, 24); -- Wind Cluster
INSERT INTO `gardening_results` VALUES (2066, 7, 2, 4, 4108, 1, 2, 24); -- Lightning Cluster
INSERT INTO `gardening_results` VALUES (2067, 7, 2, 4, 1310, 6, 12, 20); -- Platinum Leaf
INSERT INTO `gardening_results` VALUES (2068, 7, 2, 4, 4273, 8, 16, 20); -- Kitron
INSERT INTO `gardening_results` VALUES (2069, 7, 2, 4, 1256, 1, 2, 6); -- Ice Ore
INSERT INTO `gardening_results` VALUES (2070, 7, 2, 4, 1258, 1, 2, 6); -- Earth Ore
INSERT INTO `gardening_results` VALUES (2071, 7, 2, 5, 4106, 1, 2, 24); -- Wind Cluster
INSERT INTO `gardening_results` VALUES (2072, 7, 2, 5, 4109, 1, 2, 24); -- Water Cluster
INSERT INTO `gardening_results` VALUES (2073, 7, 2, 5, 1310, 6, 12, 20); -- Platinum Leaf
INSERT INTO `gardening_results` VALUES (2074, 7, 2, 5, 1307, 8, 16, 20); -- Silver Leaf
INSERT INTO `gardening_results` VALUES (2075, 7, 2, 5, 1256, 1, 2, 6); -- Ice Ore
INSERT INTO `gardening_results` VALUES (2076, 7, 2, 5, 1259, 1, 2, 6); -- Lightning Ore
INSERT INTO `gardening_results` VALUES (2077, 7, 2, 6, 4106, 1, 2, 24); -- Wind Cluster
INSERT INTO `gardening_results` VALUES (2078, 7, 2, 6, 4104, 1, 2, 24); -- Fire Cluster
INSERT INTO `gardening_results` VALUES (2079, 7, 2, 6, 1310, 6, 12, 20); -- Platinum Leaf
INSERT INTO `gardening_results` VALUES (2080, 7, 2, 6, 1308, 6, 12, 20); -- Mythril Leaf
INSERT INTO `gardening_results` VALUES (2081, 7, 2, 6, 1256, 1, 2, 6); -- Ice Ore
INSERT INTO `gardening_results` VALUES (2082, 7, 2, 6, 1260, 1, 2, 6); -- Water Ore
INSERT INTO `gardening_results` VALUES (2083, 7, 2, 7, 4106, 1, 2, 24); -- Wind Cluster
INSERT INTO `gardening_results` VALUES (2084, 7, 2, 7, 17397, 24, 48, 15); -- Shell Bug
INSERT INTO `gardening_results` VALUES (2085, 7, 2, 7, 1310, 6, 12, 20); -- Platinum Leaf
INSERT INTO `gardening_results` VALUES (2086, 7, 2, 7, 4111, 1, 2, 15); -- Dark Cluster
INSERT INTO `gardening_results` VALUES (2087, 7, 2, 7, 1256, 1, 2, 6); -- Ice Ore
INSERT INTO `gardening_results` VALUES (2088, 7, 2, 7, 1309, 4, 12, 20); -- Gold Leaf
INSERT INTO `gardening_results` VALUES (2089, 7, 2, 8, 4106, 1, 2, 24); -- Wind Cluster
INSERT INTO `gardening_results` VALUES (2090, 7, 2, 8, 936, 12, 24, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (2091, 7, 2, 8, 1310, 6, 12, 20); -- Platinum Leaf
INSERT INTO `gardening_results` VALUES (2092, 7, 2, 8, 4110, 1, 2, 15); -- Light Cluster
INSERT INTO `gardening_results` VALUES (2093, 7, 2, 8, 1256, 1, 2, 6); -- Ice Ore
INSERT INTO `gardening_results` VALUES (2094, 7, 2, 8, 4274, 4, 8, 14); -- Persikos
INSERT INTO `gardening_results` VALUES (2095, 7, 2, 8, 1262, 1, 2, 6); -- Dark Ore
INSERT INTO `gardening_results` VALUES (2096, 7, 3, 0, 936, 12, 24, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (2097, 7, 3, 0, 4107, 1, 2, 24); -- Earth Cluster
INSERT INTO `gardening_results` VALUES (2098, 7, 3, 0, 4449, 1, 2, 15); -- Reishi Mushroom
INSERT INTO `gardening_results` VALUES (2099, 7, 3, 0, 635, 24, 48, 20); -- Clump Of Windurstian Tea Leaves
INSERT INTO `gardening_results` VALUES (2100, 7, 3, 0, 1309, 4, 12, 14); -- Gold Leaf
INSERT INTO `gardening_results` VALUES (2101, 7, 3, 0, 1257, 1, 2, 6); -- Wind Ore
INSERT INTO `gardening_results` VALUES (2102, 7, 3, 0, 1261, 1, 2, 6); -- Light Ore
INSERT INTO `gardening_results` VALUES (2103, 7, 3, 1, 4105, 1, 2, 24); -- Ice Cluster
INSERT INTO `gardening_results` VALUES (2104, 7, 3, 1, 4107, 1, 2, 24); -- Earth Cluster
INSERT INTO `gardening_results` VALUES (2105, 7, 3, 1, 628, 1, 2, 20); -- Cinnamon
INSERT INTO `gardening_results` VALUES (2106, 7, 3, 1, 635, 24, 48, 20); -- Clump Of Windurstian Tea Leaves
INSERT INTO `gardening_results` VALUES (2107, 7, 3, 1, 1255, 1, 2, 6); -- Fire Ore
INSERT INTO `gardening_results` VALUES (2108, 7, 3, 1, 1257, 1, 2, 6); -- Wind Ore
INSERT INTO `gardening_results` VALUES (2109, 7, 3, 2, 4106, 1, 2, 24); -- Wind Cluster
INSERT INTO `gardening_results` VALUES (2110, 7, 3, 2, 4107, 1, 2, 24); -- Earth Cluster
INSERT INTO `gardening_results` VALUES (2111, 7, 3, 2, 1310, 6, 12, 20); -- Platinum Leaf
INSERT INTO `gardening_results` VALUES (2112, 7, 3, 2, 635, 24, 48, 20); -- Clump Of Windurstian Tea Leaves
INSERT INTO `gardening_results` VALUES (2113, 7, 3, 2, 1256, 1, 2, 6); -- Ice Ore
INSERT INTO `gardening_results` VALUES (2114, 7, 3, 2, 1257, 1, 2, 6); -- Wind Ore
INSERT INTO `gardening_results` VALUES (2115, 7, 3, 3, 4107, 1, 2, 48); -- Earth Cluster
INSERT INTO `gardening_results` VALUES (2116, 7, 3, 3, 635, 24, 48, 40); -- Clump Of Windurstian Tea Leaves
INSERT INTO `gardening_results` VALUES (2117, 7, 3, 3, 1257, 1, 2, 12); -- Wind Ore
INSERT INTO `gardening_results` VALUES (2118, 7, 3, 4, 4107, 1, 2, 24); -- Earth Cluster
INSERT INTO `gardening_results` VALUES (2119, 7, 3, 4, 4108, 1, 2, 24); -- Lightning Cluster
INSERT INTO `gardening_results` VALUES (2120, 7, 3, 4, 635, 24, 48, 20); -- Clump Of Windurstian Tea Leaves
INSERT INTO `gardening_results` VALUES (2121, 7, 3, 4, 4273, 8, 16, 20); -- Kitron
INSERT INTO `gardening_results` VALUES (2122, 7, 3, 4, 1257, 1, 2, 6); -- Wind Ore
INSERT INTO `gardening_results` VALUES (2123, 7, 3, 4, 1258, 1, 2, 6); -- Earth Ore
INSERT INTO `gardening_results` VALUES (2124, 7, 3, 5, 4107, 1, 2, 24); -- Earth Cluster
INSERT INTO `gardening_results` VALUES (2125, 7, 3, 5, 4109, 1, 2, 24); -- Water Cluster
INSERT INTO `gardening_results` VALUES (2126, 7, 3, 5, 635, 24, 48, 20); -- Clump Of Windurstian Tea Leaves
INSERT INTO `gardening_results` VALUES (2127, 7, 3, 5, 1307, 8, 16, 20); -- Silver Leaf
INSERT INTO `gardening_results` VALUES (2128, 7, 3, 5, 1257, 1, 2, 6); -- Wind Ore
INSERT INTO `gardening_results` VALUES (2129, 7, 3, 5, 1259, 1, 2, 6); -- Lightning Ore
INSERT INTO `gardening_results` VALUES (2130, 7, 3, 6, 4107, 1, 2, 24); -- Earth Cluster
INSERT INTO `gardening_results` VALUES (2131, 7, 3, 6, 4104, 1, 2, 24); -- Fire Cluster
INSERT INTO `gardening_results` VALUES (2132, 7, 3, 6, 635, 24, 48, 20); -- Clump Of Windurstian Tea Leaves
INSERT INTO `gardening_results` VALUES (2133, 7, 3, 6, 1308, 6, 12, 20); -- Mythril Leaf
INSERT INTO `gardening_results` VALUES (2134, 7, 3, 6, 1257, 1, 2, 6); -- Wind Ore
INSERT INTO `gardening_results` VALUES (2135, 7, 3, 6, 1260, 1, 2, 6); -- Water Ore
INSERT INTO `gardening_results` VALUES (2136, 7, 3, 7, 4107, 1, 2, 24); -- Earth Cluster
INSERT INTO `gardening_results` VALUES (2137, 7, 3, 7, 17397, 24, 48, 15); -- Shell Bug
INSERT INTO `gardening_results` VALUES (2138, 7, 3, 7, 635, 24, 48, 20); -- Clump Of Windurstian Tea Leaves
INSERT INTO `gardening_results` VALUES (2139, 7, 3, 7, 4111, 1, 2, 15); -- Dark Cluster
INSERT INTO `gardening_results` VALUES (2140, 7, 3, 7, 1257, 1, 2, 6); -- Wind Ore
INSERT INTO `gardening_results` VALUES (2141, 7, 3, 7, 1309, 4, 12, 20); -- Gold Leaf
INSERT INTO `gardening_results` VALUES (2142, 7, 3, 8, 4107, 1, 2, 24); -- Earth Cluster
INSERT INTO `gardening_results` VALUES (2143, 7, 3, 8, 936, 12, 24, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (2144, 7, 3, 8, 635, 24, 48, 20); -- Clump Of Windurstian Tea Leaves
INSERT INTO `gardening_results` VALUES (2145, 7, 3, 8, 4110, 1, 2, 15); -- Light Cluster
INSERT INTO `gardening_results` VALUES (2146, 7, 3, 8, 1257, 1, 2, 6); -- Wind Ore
INSERT INTO `gardening_results` VALUES (2147, 7, 3, 8, 4274, 4, 8, 14); -- Persikos
INSERT INTO `gardening_results` VALUES (2148, 7, 3, 8, 1262, 1, 2, 6); -- Dark Ore
INSERT INTO `gardening_results` VALUES (2149, 7, 4, 0, 936, 12, 24, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (2150, 7, 4, 0, 4108, 1, 2, 24); -- Lightning Cluster
INSERT INTO `gardening_results` VALUES (2151, 7, 4, 0, 4449, 1, 2, 15); -- Reishi Mushroom
INSERT INTO `gardening_results` VALUES (2152, 7, 4, 0, 4273, 8, 16, 20); -- Kitron
INSERT INTO `gardening_results` VALUES (2153, 7, 4, 0, 1309, 4, 12, 14); -- Gold Leaf
INSERT INTO `gardening_results` VALUES (2154, 7, 4, 0, 1258, 1, 2, 6); -- Earth Ore
INSERT INTO `gardening_results` VALUES (2155, 7, 4, 0, 1261, 1, 2, 6); -- Light Ore
INSERT INTO `gardening_results` VALUES (2156, 7, 4, 1, 4105, 1, 2, 24); -- Ice Cluster
INSERT INTO `gardening_results` VALUES (2157, 7, 4, 1, 4108, 1, 2, 24); -- Lightning Cluster
INSERT INTO `gardening_results` VALUES (2158, 7, 4, 1, 628, 1, 2, 20); -- Cinnamon
INSERT INTO `gardening_results` VALUES (2159, 7, 4, 1, 4273, 8, 16, 20); -- Kitron
INSERT INTO `gardening_results` VALUES (2160, 7, 4, 1, 1255, 1, 2, 6); -- Fire Ore
INSERT INTO `gardening_results` VALUES (2161, 7, 4, 1, 1258, 1, 2, 6); -- Earth Ore
INSERT INTO `gardening_results` VALUES (2162, 7, 4, 2, 4106, 1, 2, 24); -- Wind Cluster
INSERT INTO `gardening_results` VALUES (2163, 7, 4, 2, 4108, 1, 2, 24); -- Lightning Cluster
INSERT INTO `gardening_results` VALUES (2164, 7, 4, 2, 1310, 6, 12, 20); -- Platinum Leaf
INSERT INTO `gardening_results` VALUES (2165, 7, 4, 2, 4273, 8, 16, 20); -- Kitron
INSERT INTO `gardening_results` VALUES (2166, 7, 4, 2, 1256, 1, 2, 6); -- Ice Ore
INSERT INTO `gardening_results` VALUES (2167, 7, 4, 2, 1258, 1, 2, 6); -- Earth Ore
INSERT INTO `gardening_results` VALUES (2168, 7, 4, 3, 4107, 1, 2, 24); -- Earth Cluster
INSERT INTO `gardening_results` VALUES (2169, 7, 4, 3, 4108, 1, 2, 24); -- Lightning Cluster
INSERT INTO `gardening_results` VALUES (2170, 7, 4, 3, 635, 24, 48, 20); -- Clump Of Windurstian Tea Leaves
INSERT INTO `gardening_results` VALUES (2171, 7, 4, 3, 4273, 8, 16, 20); -- Kitron
INSERT INTO `gardening_results` VALUES (2172, 7, 4, 3, 1257, 1, 2, 6); -- Wind Ore
INSERT INTO `gardening_results` VALUES (2173, 7, 4, 3, 1258, 1, 2, 6); -- Earth Ore
INSERT INTO `gardening_results` VALUES (2174, 7, 4, 4, 4108, 1, 2, 48); -- Lightning Cluster
INSERT INTO `gardening_results` VALUES (2175, 7, 4, 4, 4273, 8, 16, 40); -- Kitron
INSERT INTO `gardening_results` VALUES (2176, 7, 4, 4, 1258, 1, 2, 12); -- Earth Ore
INSERT INTO `gardening_results` VALUES (2177, 7, 4, 5, 4108, 1, 2, 24); -- Lightning Cluster
INSERT INTO `gardening_results` VALUES (2178, 7, 4, 5, 4109, 1, 2, 24); -- Water Cluster
INSERT INTO `gardening_results` VALUES (2179, 7, 4, 5, 4273, 8, 16, 20); -- Kitron
INSERT INTO `gardening_results` VALUES (2180, 7, 4, 5, 1307, 8, 16, 20); -- Silver Leaf
INSERT INTO `gardening_results` VALUES (2181, 7, 4, 5, 1258, 1, 2, 6); -- Earth Ore
INSERT INTO `gardening_results` VALUES (2182, 7, 4, 5, 1259, 1, 2, 6); -- Lightning Ore
INSERT INTO `gardening_results` VALUES (2183, 7, 4, 6, 4108, 1, 2, 24); -- Lightning Cluster
INSERT INTO `gardening_results` VALUES (2184, 7, 4, 6, 4104, 1, 2, 24); -- Fire Cluster
INSERT INTO `gardening_results` VALUES (2185, 7, 4, 6, 4273, 8, 16, 20); -- Kitron
INSERT INTO `gardening_results` VALUES (2186, 7, 4, 6, 1308, 6, 12, 20); -- Mythril Leaf
INSERT INTO `gardening_results` VALUES (2187, 7, 4, 6, 1258, 1, 2, 6); -- Earth Ore
INSERT INTO `gardening_results` VALUES (2188, 7, 4, 6, 1260, 1, 2, 6); -- Water Ore
INSERT INTO `gardening_results` VALUES (2189, 7, 4, 7, 4108, 1, 2, 24); -- Lightning Cluster
INSERT INTO `gardening_results` VALUES (2190, 7, 4, 7, 17397, 24, 48, 15); -- Shell Bug
INSERT INTO `gardening_results` VALUES (2191, 7, 4, 7, 4273, 8, 16, 20); -- Kitron
INSERT INTO `gardening_results` VALUES (2192, 7, 4, 7, 4111, 1, 2, 15); -- Dark Cluster
INSERT INTO `gardening_results` VALUES (2193, 7, 4, 7, 1258, 1, 2, 6); -- Earth Ore
INSERT INTO `gardening_results` VALUES (2194, 7, 4, 7, 1309, 4, 12, 20); -- Gold Leaf
INSERT INTO `gardening_results` VALUES (2195, 7, 4, 8, 4108, 1, 2, 24); -- Lightning Cluster
INSERT INTO `gardening_results` VALUES (2196, 7, 4, 8, 936, 12, 24, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (2197, 7, 4, 8, 4273, 8, 16, 20); -- Kitron
INSERT INTO `gardening_results` VALUES (2198, 7, 4, 8, 4110, 1, 2, 15); -- Light Cluster
INSERT INTO `gardening_results` VALUES (2199, 7, 4, 8, 1258, 1, 2, 6); -- Earth Ore
INSERT INTO `gardening_results` VALUES (2200, 7, 4, 8, 4274, 4, 8, 14); -- Persikos
INSERT INTO `gardening_results` VALUES (2201, 7, 4, 8, 1262, 1, 2, 6); -- Dark Ore
INSERT INTO `gardening_results` VALUES (2202, 7, 5, 0, 936, 12, 24, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (2203, 7, 5, 0, 4109, 1, 2, 24); -- Water Cluster
INSERT INTO `gardening_results` VALUES (2204, 7, 5, 0, 4449, 1, 2, 15); -- Reishi Mushroom
INSERT INTO `gardening_results` VALUES (2205, 7, 5, 0, 1307, 8, 16, 20); -- Silver Leaf
INSERT INTO `gardening_results` VALUES (2206, 7, 5, 0, 1309, 4, 12, 14); -- Gold Leaf
INSERT INTO `gardening_results` VALUES (2207, 7, 5, 0, 1259, 1, 2, 6); -- Lightning Ore
INSERT INTO `gardening_results` VALUES (2208, 7, 5, 0, 1261, 1, 2, 6); -- Light Ore
INSERT INTO `gardening_results` VALUES (2209, 7, 5, 1, 4105, 1, 2, 24); -- Ice Cluster
INSERT INTO `gardening_results` VALUES (2210, 7, 5, 1, 4109, 1, 2, 24); -- Water Cluster
INSERT INTO `gardening_results` VALUES (2211, 7, 5, 1, 628, 1, 2, 20); -- Cinnamon
INSERT INTO `gardening_results` VALUES (2212, 7, 5, 1, 1307, 8, 16, 20); -- Silver Leaf
INSERT INTO `gardening_results` VALUES (2213, 7, 5, 1, 1255, 1, 2, 6); -- Fire Ore
INSERT INTO `gardening_results` VALUES (2214, 7, 5, 1, 1259, 1, 2, 6); -- Lightning Ore
INSERT INTO `gardening_results` VALUES (2215, 7, 5, 2, 4106, 1, 2, 24); -- Wind Cluster
INSERT INTO `gardening_results` VALUES (2216, 7, 5, 2, 4109, 1, 2, 24); -- Water Cluster
INSERT INTO `gardening_results` VALUES (2217, 7, 5, 2, 1310, 6, 12, 20); -- Platinum Leaf
INSERT INTO `gardening_results` VALUES (2218, 7, 5, 2, 1307, 8, 16, 20); -- Silver Leaf
INSERT INTO `gardening_results` VALUES (2219, 7, 5, 2, 1256, 1, 2, 6); -- Ice Ore
INSERT INTO `gardening_results` VALUES (2220, 7, 5, 2, 1259, 1, 2, 6); -- Lightning Ore
INSERT INTO `gardening_results` VALUES (2221, 7, 5, 3, 4107, 1, 2, 24); -- Earth Cluster
INSERT INTO `gardening_results` VALUES (2222, 7, 5, 3, 4109, 1, 2, 24); -- Water Cluster
INSERT INTO `gardening_results` VALUES (2223, 7, 5, 3, 635, 24, 48, 20); -- Clump Of Windurstian Tea Leaves
INSERT INTO `gardening_results` VALUES (2224, 7, 5, 3, 1307, 8, 16, 20); -- Silver Leaf
INSERT INTO `gardening_results` VALUES (2225, 7, 5, 3, 1257, 1, 2, 6); -- Wind Ore
INSERT INTO `gardening_results` VALUES (2226, 7, 5, 3, 1259, 1, 2, 6); -- Lightning Ore
INSERT INTO `gardening_results` VALUES (2227, 7, 5, 4, 4108, 1, 2, 24); -- Lightning Cluster
INSERT INTO `gardening_results` VALUES (2228, 7, 5, 4, 4109, 1, 2, 24); -- Water Cluster
INSERT INTO `gardening_results` VALUES (2229, 7, 5, 4, 4273, 8, 16, 20); -- Kitron
INSERT INTO `gardening_results` VALUES (2230, 7, 5, 4, 1307, 8, 16, 20); -- Silver Leaf
INSERT INTO `gardening_results` VALUES (2231, 7, 5, 4, 1258, 1, 2, 6); -- Earth Ore
INSERT INTO `gardening_results` VALUES (2232, 7, 5, 4, 1259, 1, 2, 6); -- Lightning Ore
INSERT INTO `gardening_results` VALUES (2233, 7, 5, 5, 4109, 1, 2, 48); -- Water Cluster
INSERT INTO `gardening_results` VALUES (2234, 7, 5, 5, 1307, 8, 16, 40); -- Silver Leaf
INSERT INTO `gardening_results` VALUES (2235, 7, 5, 5, 1259, 1, 2, 12); -- Lightning Ore
INSERT INTO `gardening_results` VALUES (2236, 7, 5, 6, 4109, 1, 2, 24); -- Water Cluster
INSERT INTO `gardening_results` VALUES (2237, 7, 5, 6, 4104, 1, 2, 24); -- Fire Cluster
INSERT INTO `gardening_results` VALUES (2238, 7, 5, 6, 1307, 8, 16, 20); -- Silver Leaf
INSERT INTO `gardening_results` VALUES (2239, 7, 5, 6, 1308, 6, 12, 20); -- Mythril Leaf
INSERT INTO `gardening_results` VALUES (2240, 7, 5, 6, 1259, 1, 2, 6); -- Lightning Ore
INSERT INTO `gardening_results` VALUES (2241, 7, 5, 6, 1260, 1, 2, 6); -- Water Ore
INSERT INTO `gardening_results` VALUES (2242, 7, 5, 7, 4109, 1, 2, 24); -- Water Cluster
INSERT INTO `gardening_results` VALUES (2243, 7, 5, 7, 17397, 24, 48, 15); -- Shell Bug
INSERT INTO `gardening_results` VALUES (2244, 7, 5, 7, 1307, 8, 16, 20); -- Silver Leaf
INSERT INTO `gardening_results` VALUES (2245, 7, 5, 7, 4111, 1, 2, 15); -- Dark Cluster
INSERT INTO `gardening_results` VALUES (2246, 7, 5, 7, 1259, 1, 2, 6); -- Lightning Ore
INSERT INTO `gardening_results` VALUES (2247, 7, 5, 7, 1309, 4, 12, 20); -- Gold Leaf
INSERT INTO `gardening_results` VALUES (2248, 7, 5, 8, 4109, 1, 2, 24); -- Water Cluster
INSERT INTO `gardening_results` VALUES (2249, 7, 5, 8, 936, 12, 24, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (2250, 7, 5, 8, 1307, 8, 16, 20); -- Silver Leaf
INSERT INTO `gardening_results` VALUES (2251, 7, 5, 8, 4110, 1, 2, 15); -- Light Cluster
INSERT INTO `gardening_results` VALUES (2252, 7, 5, 8, 1259, 1, 2, 6); -- Lightning Ore
INSERT INTO `gardening_results` VALUES (2253, 7, 5, 8, 4274, 4, 8, 14); -- Persikos
INSERT INTO `gardening_results` VALUES (2254, 7, 5, 8, 1262, 1, 2, 6); -- Dark Ore
INSERT INTO `gardening_results` VALUES (2255, 7, 6, 0, 936, 12, 24, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (2256, 7, 6, 0, 4104, 1, 2, 24); -- Fire Cluster
INSERT INTO `gardening_results` VALUES (2257, 7, 6, 0, 4449, 1, 2, 15); -- Reishi Mushroom
INSERT INTO `gardening_results` VALUES (2258, 7, 6, 0, 1308, 6, 12, 20); -- Mythril Leaf
INSERT INTO `gardening_results` VALUES (2259, 7, 6, 0, 1309, 4, 12, 14); -- Gold Leaf
INSERT INTO `gardening_results` VALUES (2260, 7, 6, 0, 1260, 1, 2, 6); -- Water Ore
INSERT INTO `gardening_results` VALUES (2261, 7, 6, 0, 1261, 1, 2, 6); -- Light Ore
INSERT INTO `gardening_results` VALUES (2262, 7, 6, 1, 4105, 1, 2, 24); -- Ice Cluster
INSERT INTO `gardening_results` VALUES (2263, 7, 6, 1, 4104, 1, 2, 24); -- Fire Cluster
INSERT INTO `gardening_results` VALUES (2264, 7, 6, 1, 628, 1, 2, 20); -- Cinnamon
INSERT INTO `gardening_results` VALUES (2265, 7, 6, 1, 1308, 6, 12, 20); -- Mythril Leaf
INSERT INTO `gardening_results` VALUES (2266, 7, 6, 1, 1255, 1, 2, 6); -- Fire Ore
INSERT INTO `gardening_results` VALUES (2267, 7, 6, 1, 1260, 1, 2, 6); -- Water Ore
INSERT INTO `gardening_results` VALUES (2268, 7, 6, 2, 4106, 1, 2, 24); -- Wind Cluster
INSERT INTO `gardening_results` VALUES (2269, 7, 6, 2, 4104, 1, 2, 24); -- Fire Cluster
INSERT INTO `gardening_results` VALUES (2270, 7, 6, 2, 1310, 6, 12, 20); -- Platinum Leaf
INSERT INTO `gardening_results` VALUES (2271, 7, 6, 2, 1308, 6, 12, 20); -- Mythril Leaf
INSERT INTO `gardening_results` VALUES (2272, 7, 6, 2, 1256, 1, 2, 6); -- Ice Ore
INSERT INTO `gardening_results` VALUES (2273, 7, 6, 2, 1260, 1, 2, 6); -- Water Ore
INSERT INTO `gardening_results` VALUES (2274, 7, 6, 3, 4107, 1, 2, 24); -- Earth Cluster
INSERT INTO `gardening_results` VALUES (2275, 7, 6, 3, 4104, 1, 2, 24); -- Fire Cluster
INSERT INTO `gardening_results` VALUES (2276, 7, 6, 3, 635, 24, 48, 20); -- Clump Of Windurstian Tea Leaves
INSERT INTO `gardening_results` VALUES (2277, 7, 6, 3, 1308, 6, 12, 20); -- Mythril Leaf
INSERT INTO `gardening_results` VALUES (2278, 7, 6, 3, 1257, 1, 2, 6); -- Wind Ore
INSERT INTO `gardening_results` VALUES (2279, 7, 6, 3, 1260, 1, 2, 6); -- Water Ore
INSERT INTO `gardening_results` VALUES (2280, 7, 6, 4, 4108, 1, 2, 24); -- Lightning Cluster
INSERT INTO `gardening_results` VALUES (2281, 7, 6, 4, 4104, 1, 2, 24); -- Fire Cluster
INSERT INTO `gardening_results` VALUES (2282, 7, 6, 4, 4273, 8, 16, 20); -- Kitron
INSERT INTO `gardening_results` VALUES (2283, 7, 6, 4, 1308, 6, 12, 20); -- Mythril Leaf
INSERT INTO `gardening_results` VALUES (2284, 7, 6, 4, 1258, 1, 2, 6); -- Earth Ore
INSERT INTO `gardening_results` VALUES (2285, 7, 6, 4, 1260, 1, 2, 6); -- Water Ore
INSERT INTO `gardening_results` VALUES (2286, 7, 6, 5, 4109, 1, 2, 24); -- Water Cluster
INSERT INTO `gardening_results` VALUES (2287, 7, 6, 5, 4104, 1, 2, 24); -- Fire Cluster
INSERT INTO `gardening_results` VALUES (2288, 7, 6, 5, 1307, 8, 16, 20); -- Silver Leaf
INSERT INTO `gardening_results` VALUES (2289, 7, 6, 5, 1308, 6, 12, 20); -- Mythril Leaf
INSERT INTO `gardening_results` VALUES (2290, 7, 6, 5, 1259, 1, 2, 6); -- Lightning Ore
INSERT INTO `gardening_results` VALUES (2291, 7, 6, 5, 1260, 1, 2, 6); -- Water Ore
INSERT INTO `gardening_results` VALUES (2292, 7, 6, 6, 4104, 1, 2, 48); -- Fire Cluster
INSERT INTO `gardening_results` VALUES (2293, 7, 6, 6, 1308, 6, 12, 40); -- Mythril Leaf
INSERT INTO `gardening_results` VALUES (2294, 7, 6, 6, 1260, 1, 2, 12); -- Water Ore
INSERT INTO `gardening_results` VALUES (2295, 7, 6, 7, 4104, 1, 2, 24); -- Fire Cluster
INSERT INTO `gardening_results` VALUES (2296, 7, 6, 7, 17397, 24, 48, 15); -- Shell Bug
INSERT INTO `gardening_results` VALUES (2297, 7, 6, 7, 1308, 6, 12, 20); -- Mythril Leaf
INSERT INTO `gardening_results` VALUES (2298, 7, 6, 7, 4111, 1, 2, 15); -- Dark Cluster
INSERT INTO `gardening_results` VALUES (2299, 7, 6, 7, 1260, 1, 2, 6); -- Water Ore
INSERT INTO `gardening_results` VALUES (2300, 7, 6, 7, 1309, 4, 12, 20); -- Gold Leaf
INSERT INTO `gardening_results` VALUES (2301, 7, 6, 8, 4104, 1, 2, 24); -- Fire Cluster
INSERT INTO `gardening_results` VALUES (2302, 7, 6, 8, 936, 12, 24, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (2303, 7, 6, 8, 1308, 6, 12, 20); -- Mythril Leaf
INSERT INTO `gardening_results` VALUES (2304, 7, 6, 8, 4110, 1, 2, 15); -- Light Cluster
INSERT INTO `gardening_results` VALUES (2305, 7, 6, 8, 1260, 1, 2, 6); -- Water Ore
INSERT INTO `gardening_results` VALUES (2306, 7, 6, 8, 4274, 4, 8, 14); -- Persikos
INSERT INTO `gardening_results` VALUES (2307, 7, 6, 8, 1262, 1, 2, 6); -- Dark Ore
INSERT INTO `gardening_results` VALUES (2308, 7, 7, 0, 936, 12, 24, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (2309, 7, 7, 0, 17397, 24, 48, 15); -- Shell Bug
INSERT INTO `gardening_results` VALUES (2310, 7, 7, 0, 4449, 1, 2, 15); -- Reishi Mushroom
INSERT INTO `gardening_results` VALUES (2311, 7, 7, 0, 4111, 1, 2, 15); -- Dark Cluster
INSERT INTO `gardening_results` VALUES (2312, 7, 7, 0, 1309, 4, 12, 34); -- Gold Leaf
INSERT INTO `gardening_results` VALUES (2313, 7, 7, 0, 1261, 1, 2, 6); -- Light Ore
INSERT INTO `gardening_results` VALUES (2314, 7, 7, 1, 4105, 1, 2, 24); -- Ice Cluster
INSERT INTO `gardening_results` VALUES (2315, 7, 7, 1, 17397, 24, 48, 15); -- Shell Bug
INSERT INTO `gardening_results` VALUES (2316, 7, 7, 1, 628, 1, 2, 20); -- Cinnamon
INSERT INTO `gardening_results` VALUES (2317, 7, 7, 1, 4111, 1, 2, 15); -- Dark Cluster
INSERT INTO `gardening_results` VALUES (2318, 7, 7, 1, 1255, 1, 2, 6); -- Fire Ore
INSERT INTO `gardening_results` VALUES (2319, 7, 7, 1, 1309, 4, 12, 20); -- Gold Leaf
INSERT INTO `gardening_results` VALUES (2320, 7, 7, 2, 4106, 1, 2, 24); -- Wind Cluster
INSERT INTO `gardening_results` VALUES (2321, 7, 7, 2, 17397, 24, 48, 15); -- Shell Bug
INSERT INTO `gardening_results` VALUES (2322, 7, 7, 2, 1310, 6, 12, 20); -- Platinum Leaf
INSERT INTO `gardening_results` VALUES (2323, 7, 7, 2, 4111, 1, 2, 15); -- Dark Cluster
INSERT INTO `gardening_results` VALUES (2324, 7, 7, 2, 1256, 1, 2, 6); -- Ice Ore
INSERT INTO `gardening_results` VALUES (2325, 7, 7, 2, 1309, 4, 12, 20); -- Gold Leaf
INSERT INTO `gardening_results` VALUES (2326, 7, 7, 3, 4107, 1, 2, 24); -- Earth Cluster
INSERT INTO `gardening_results` VALUES (2327, 7, 7, 3, 17397, 24, 48, 15); -- Shell Bug
INSERT INTO `gardening_results` VALUES (2328, 7, 7, 3, 635, 24, 48, 20); -- Clump Of Windurstian Tea Leaves
INSERT INTO `gardening_results` VALUES (2329, 7, 7, 3, 4111, 1, 2, 15); -- Dark Cluster
INSERT INTO `gardening_results` VALUES (2330, 7, 7, 3, 1257, 1, 2, 6); -- Wind Ore
INSERT INTO `gardening_results` VALUES (2331, 7, 7, 3, 1309, 4, 12, 20); -- Gold Leaf
INSERT INTO `gardening_results` VALUES (2332, 7, 7, 4, 4108, 1, 2, 24); -- Lightning Cluster
INSERT INTO `gardening_results` VALUES (2333, 7, 7, 4, 17397, 24, 48, 15); -- Shell Bug
INSERT INTO `gardening_results` VALUES (2334, 7, 7, 4, 4273, 8, 16, 20); -- Kitron
INSERT INTO `gardening_results` VALUES (2335, 7, 7, 4, 4111, 1, 2, 15); -- Dark Cluster
INSERT INTO `gardening_results` VALUES (2336, 7, 7, 4, 1258, 1, 2, 6); -- Earth Ore
INSERT INTO `gardening_results` VALUES (2337, 7, 7, 4, 1309, 4, 12, 20); -- Gold Leaf
INSERT INTO `gardening_results` VALUES (2338, 7, 7, 5, 4109, 1, 2, 24); -- Water Cluster
INSERT INTO `gardening_results` VALUES (2339, 7, 7, 5, 17397, 24, 48, 15); -- Shell Bug
INSERT INTO `gardening_results` VALUES (2340, 7, 7, 5, 1307, 8, 16, 20); -- Silver Leaf
INSERT INTO `gardening_results` VALUES (2341, 7, 7, 5, 4111, 1, 2, 15); -- Dark Cluster
INSERT INTO `gardening_results` VALUES (2342, 7, 7, 5, 1259, 1, 2, 6); -- Lightning Ore
INSERT INTO `gardening_results` VALUES (2343, 7, 7, 5, 1309, 4, 12, 20); -- Gold Leaf
INSERT INTO `gardening_results` VALUES (2344, 7, 7, 6, 4104, 1, 2, 24); -- Fire Cluster
INSERT INTO `gardening_results` VALUES (2345, 7, 7, 6, 17397, 24, 48, 15); -- Shell Bug
INSERT INTO `gardening_results` VALUES (2346, 7, 7, 6, 1308, 6, 12, 20); -- Mythril Leaf
INSERT INTO `gardening_results` VALUES (2347, 7, 7, 6, 4111, 1, 2, 15); -- Dark Cluster
INSERT INTO `gardening_results` VALUES (2348, 7, 7, 6, 1260, 1, 2, 6); -- Water Ore
INSERT INTO `gardening_results` VALUES (2349, 7, 7, 6, 1309, 4, 12, 20); -- Gold Leaf
INSERT INTO `gardening_results` VALUES (2350, 7, 7, 7, 17397, 24, 48, 30); -- Shell Bug
INSERT INTO `gardening_results` VALUES (2351, 7, 7, 7, 4111, 1, 2, 30); -- Dark Cluster
INSERT INTO `gardening_results` VALUES (2352, 7, 7, 7, 1309, 4, 12, 40); -- Gold Leaf
INSERT INTO `gardening_results` VALUES (2353, 7, 7, 8, 17397, 24, 48, 15); -- Shell Bug
INSERT INTO `gardening_results` VALUES (2354, 7, 7, 8, 936, 12, 24, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (2355, 7, 7, 8, 4111, 1, 2, 15); -- Dark Cluster
INSERT INTO `gardening_results` VALUES (2356, 7, 7, 8, 4110, 1, 2, 15); -- Light Cluster
INSERT INTO `gardening_results` VALUES (2357, 7, 7, 8, 1309, 4, 12, 20); -- Gold Leaf
INSERT INTO `gardening_results` VALUES (2358, 7, 7, 8, 4274, 4, 8, 14); -- Persikos
INSERT INTO `gardening_results` VALUES (2359, 7, 7, 8, 1262, 1, 2, 6); -- Dark Ore
INSERT INTO `gardening_results` VALUES (2360, 7, 8, 0, 936, 12, 24, 30); -- Rock Salt
INSERT INTO `gardening_results` VALUES (2361, 7, 8, 0, 4449, 1, 2, 15); -- Reishi Mushroom
INSERT INTO `gardening_results` VALUES (2362, 7, 8, 0, 4110, 1, 2, 15); -- Light Cluster
INSERT INTO `gardening_results` VALUES (2363, 7, 8, 0, 1309, 4, 12, 14); -- Gold Leaf
INSERT INTO `gardening_results` VALUES (2364, 7, 8, 0, 4274, 4, 8, 14); -- Persikos
INSERT INTO `gardening_results` VALUES (2365, 7, 8, 0, 1261, 1, 2, 6); -- Light Ore
INSERT INTO `gardening_results` VALUES (2366, 7, 8, 0, 1262, 1, 2, 6); -- Dark Ore
INSERT INTO `gardening_results` VALUES (2367, 7, 8, 1, 4105, 1, 2, 24); -- Ice Cluster
INSERT INTO `gardening_results` VALUES (2368, 7, 8, 1, 936, 12, 24, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (2369, 7, 8, 1, 628, 1, 2, 20); -- Cinnamon
INSERT INTO `gardening_results` VALUES (2370, 7, 8, 1, 4110, 1, 2, 15); -- Light Cluster
INSERT INTO `gardening_results` VALUES (2371, 7, 8, 1, 1255, 1, 2, 6); -- Fire Ore
INSERT INTO `gardening_results` VALUES (2372, 7, 8, 1, 4274, 4, 8, 14); -- Persikos
INSERT INTO `gardening_results` VALUES (2373, 7, 8, 1, 1262, 1, 2, 6); -- Dark Ore
INSERT INTO `gardening_results` VALUES (2374, 7, 8, 2, 4106, 1, 2, 24); -- Wind Cluster
INSERT INTO `gardening_results` VALUES (2375, 7, 8, 2, 936, 12, 24, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (2376, 7, 8, 2, 1310, 6, 12, 20); -- Platinum Leaf
INSERT INTO `gardening_results` VALUES (2377, 7, 8, 2, 4110, 1, 2, 15); -- Light Cluster
INSERT INTO `gardening_results` VALUES (2378, 7, 8, 2, 1256, 1, 2, 6); -- Ice Ore
INSERT INTO `gardening_results` VALUES (2379, 7, 8, 2, 4274, 4, 8, 14); -- Persikos
INSERT INTO `gardening_results` VALUES (2380, 7, 8, 2, 1262, 1, 2, 6); -- Dark Ore
INSERT INTO `gardening_results` VALUES (2381, 7, 8, 3, 4107, 1, 2, 24); -- Earth Cluster
INSERT INTO `gardening_results` VALUES (2382, 7, 8, 3, 936, 12, 24, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (2383, 7, 8, 3, 635, 24, 48, 20); -- Clump Of Windurstian Tea Leaves
INSERT INTO `gardening_results` VALUES (2384, 7, 8, 3, 4110, 1, 2, 15); -- Light Cluster
INSERT INTO `gardening_results` VALUES (2385, 7, 8, 3, 1257, 1, 2, 6); -- Wind Ore
INSERT INTO `gardening_results` VALUES (2386, 7, 8, 3, 4274, 4, 8, 14); -- Persikos
INSERT INTO `gardening_results` VALUES (2387, 7, 8, 3, 1262, 1, 2, 6); -- Dark Ore
INSERT INTO `gardening_results` VALUES (2388, 7, 8, 4, 4108, 1, 2, 24); -- Lightning Cluster
INSERT INTO `gardening_results` VALUES (2389, 7, 8, 4, 936, 12, 24, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (2390, 7, 8, 4, 4273, 8, 16, 20); -- Kitron
INSERT INTO `gardening_results` VALUES (2391, 7, 8, 4, 4110, 1, 2, 15); -- Light Cluster
INSERT INTO `gardening_results` VALUES (2392, 7, 8, 4, 1258, 1, 2, 6); -- Earth Ore
INSERT INTO `gardening_results` VALUES (2393, 7, 8, 4, 4274, 4, 8, 14); -- Persikos
INSERT INTO `gardening_results` VALUES (2394, 7, 8, 4, 1262, 1, 2, 6); -- Dark Ore
INSERT INTO `gardening_results` VALUES (2395, 7, 8, 5, 4109, 1, 2, 24); -- Water Cluster
INSERT INTO `gardening_results` VALUES (2396, 7, 8, 5, 936, 12, 24, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (2397, 7, 8, 5, 1307, 8, 16, 20); -- Silver Leaf
INSERT INTO `gardening_results` VALUES (2398, 7, 8, 5, 4110, 1, 2, 15); -- Light Cluster
INSERT INTO `gardening_results` VALUES (2399, 7, 8, 5, 1259, 1, 2, 6); -- Lightning Ore
INSERT INTO `gardening_results` VALUES (2400, 7, 8, 5, 4274, 4, 8, 14); -- Persikos
INSERT INTO `gardening_results` VALUES (2401, 7, 8, 5, 1262, 1, 2, 6); -- Dark Ore
INSERT INTO `gardening_results` VALUES (2402, 7, 8, 6, 4104, 1, 2, 24); -- Fire Cluster
INSERT INTO `gardening_results` VALUES (2403, 7, 8, 6, 936, 12, 24, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (2404, 7, 8, 6, 1308, 6, 12, 20); -- Mythril Leaf
INSERT INTO `gardening_results` VALUES (2405, 7, 8, 6, 4110, 1, 2, 15); -- Light Cluster
INSERT INTO `gardening_results` VALUES (2406, 7, 8, 6, 1260, 1, 2, 6); -- Water Ore
INSERT INTO `gardening_results` VALUES (2407, 7, 8, 6, 4274, 4, 8, 14); -- Persikos
INSERT INTO `gardening_results` VALUES (2408, 7, 8, 6, 1262, 1, 2, 6); -- Dark Ore
INSERT INTO `gardening_results` VALUES (2409, 7, 8, 7, 17397, 24, 48, 15); -- Shell Bug
INSERT INTO `gardening_results` VALUES (2410, 7, 8, 7, 936, 12, 24, 15); -- Rock Salt
INSERT INTO `gardening_results` VALUES (2411, 7, 8, 7, 4111, 1, 2, 15); -- Dark Cluster
INSERT INTO `gardening_results` VALUES (2412, 7, 8, 7, 4110, 1, 2, 15); -- Light Cluster
INSERT INTO `gardening_results` VALUES (2413, 7, 8, 7, 1309, 4, 12, 20); -- Gold Leaf
INSERT INTO `gardening_results` VALUES (2414, 7, 8, 7, 4274, 4, 8, 14); -- Persikos
INSERT INTO `gardening_results` VALUES (2415, 7, 8, 7, 1262, 1, 2, 6); -- Dark Ore
INSERT INTO `gardening_results` VALUES (2416, 7, 8, 8, 936, 12, 24, 30); -- Rock Salt
INSERT INTO `gardening_results` VALUES (2417, 7, 8, 8, 4110, 1, 2, 30); -- Light Cluster
INSERT INTO `gardening_results` VALUES (2418, 7, 8, 8, 4274, 4, 8, 28); -- Persikos
INSERT INTO `gardening_results` VALUES (2419, 7, 8, 8, 1262, 1, 2, 12); -- Dark Ore
INSERT INTO `gardening_results` VALUES (2420, 8, 0, 0, 936, 12, 24, 30); -- Rock Salt
INSERT INTO `gardening_results` VALUES (2421, 8, 0, 0, 4366, 6, 12, 20); -- La Theine Cabbage
INSERT INTO `gardening_results` VALUES (2422, 8, 0, 0, 774, 1, 2, 30); -- Purple Rock
INSERT INTO `gardening_results` VALUES (2423, 8, 0, 0, 2205, 1, 5, 20); -- Gregarious Worm
INSERT INTO `gardening_results` VALUES (2424, 8, 1, 0, 4097, 4, 12, 40); -- Ice Crystal
INSERT INTO `gardening_results` VALUES (2425, 8, 1, 0, 4545, 12, 24, 30); -- Gysahl Greens
INSERT INTO `gardening_results` VALUES (2426, 8, 1, 0, 2202, 8, 16, 30); -- Clump Of Garidav Wildgrass
INSERT INTO `gardening_results` VALUES (2427, 8, 2, 0, 4098, 4, 12, 40); -- Wind Crystal
INSERT INTO `gardening_results` VALUES (2428, 8, 2, 0, 5608, 6, 12, 30); -- Zegham Carrot
INSERT INTO `gardening_results` VALUES (2429, 8, 2, 0, 5606, 6, 12, 30); -- Azouph Greens
INSERT INTO `gardening_results` VALUES (2430, 8, 3, 0, 4099, 4, 12, 60); -- Earth Crystal
INSERT INTO `gardening_results` VALUES (2431, 8, 3, 0, 4545, 8, 16, 40); -- Bunch Of Gysahl Greens
INSERT INTO `gardening_results` VALUES (2432, 8, 4, 0, 936, 12, 24, 40); -- Rock Salt
INSERT INTO `gardening_results` VALUES (2433, 8, 4, 0, 4100, 4, 12, 30); -- Lightning Crystal
INSERT INTO `gardening_results` VALUES (2434, 8, 4, 0, 5607, 8, 16, 30); -- Vomp Carrot
INSERT INTO `gardening_results` VALUES (2435, 8, 5, 0, 17396, 12, 24, 30); -- Little Worm
INSERT INTO `gardening_results` VALUES (2436, 8, 5, 0, 4101, 4, 12, 20); -- Water Crystal
INSERT INTO `gardening_results` VALUES (2437, 8, 5, 0, 5605, 8, 16, 30); -- Sharug Greens
INSERT INTO `gardening_results` VALUES (2438, 8, 5, 0, 774, 1, 2, 20); -- Purple Rock
INSERT INTO `gardening_results` VALUES (2439, 8, 6, 0, 4096, 4, 12, 60); -- Fire Crystal
INSERT INTO `gardening_results` VALUES (2440, 8, 6, 0, 2201, 8, 16, 40); -- Clump Of Tokopekko Wildgrass
INSERT INTO `gardening_results` VALUES (2441, 8, 7, 0, 4103, 4, 12, 60); -- Dark Crystal
INSERT INTO `gardening_results` VALUES (2442, 8, 7, 0, 2203, 1, 5, 40); -- Cupid Worm
INSERT INTO `gardening_results` VALUES (2443, 8, 8, 0, 4102, 4, 12, 60); -- Light Crystal
INSERT INTO `gardening_results` VALUES (2444, 8, 8, 0, 2204, 1, 5, 40); -- Parasite Worm
