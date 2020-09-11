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

INSERT INTO `gardening_results` (`resultId`, `seed`, `element1`, `element2`, `result`, `min_quantity`, `max_quantity`, `weight`) VALUES
    (1, 1, 0, 0, 936, 12, 24, 30), -- Rock Salt
    (2, 1, 0, 0, 4449, 1, 2, 30), -- Reishi Mushroom
    (3, 1, 0, 0, 4468, 6, 12, 20), -- Pamamas
    (4, 1, 0, 0, 770, 1, 2, 20), -- Blue Rock
    (5, 1, 0, 1, 936, 12, 24, 15), -- Rock Salt
    (6, 1, 0, 1, 4097, 6, 12, 15), -- Ice Crystal
    (7, 1, 0, 1, 4449, 1, 2, 15), -- Reishi Mushroom
    (8, 1, 0, 1, 4392, 6, 12, 15), -- Saruta Orange
    (9, 1, 0, 1, 4468, 6, 12, 10), -- Pamamas
    (10, 1, 0, 1, 4445, 8, 16, 10), -- Yagudo Cherry
    (11, 1, 0, 1, 770, 1, 2, 10), -- Blue Rock
    (12, 1, 0, 1, 769, 1, 2, 10), -- Red Rock
    (13, 1, 0, 2, 936, 12, 24, 15), -- Rock Salt
    (14, 1, 0, 2, 4098, 6, 12, 15), -- Wind Crystal
    (15, 1, 0, 2, 4449, 1, 2, 15), -- Reishi Mushroom
    (16, 1, 0, 2, 4390, 6, 12, 15), -- Mithran Tomato
    (17, 1, 0, 2, 4468, 6, 12, 10), -- Pamamas
    (18, 1, 0, 2, 4503, 6, 12, 10), -- Buburimu Grape
    (19, 1, 0, 2, 770, 1, 2, 10), -- Blue Rock
    (20, 1, 0, 2, 773, 1, 2, 10), -- Translucent Rock
    (21, 1, 0, 3, 936, 12, 24, 15), -- Rock Salt
    (22, 1, 0, 3, 4099, 6, 12, 15), -- Earth Crystal
    (23, 1, 0, 3, 4449, 1, 2, 15), -- Reishi Mushroom
    (24, 1, 0, 3, 4431, 6, 12, 15), -- Bunch Of San dOrian Grapes
    (25, 1, 0, 3, 4468, 6, 12, 10), -- Pamamas
    (26, 1, 0, 3, 4365, 6, 12, 10), -- Rolanberry
    (27, 1, 0, 3, 770, 1, 2, 10), -- Blue Rock
    (28, 1, 0, 3, 772, 1, 2, 10), -- Green Rock
    (29, 1, 0, 4, 936, 12, 24, 15), -- Rock Salt
    (30, 1, 0, 4, 4100, 6, 12, 15), -- Lightning Crystal
    (31, 1, 0, 4, 4449, 1, 2, 15), -- Reishi Mushroom
    (32, 1, 0, 4, 4389, 8, 16, 15), -- San dOrian Carrot
    (33, 1, 0, 4, 4468, 6, 12, 10), -- Pamamas
    (34, 1, 0, 4, 4388, 8, 16, 10), -- Eggplant
    (35, 1, 0, 4, 770, 1, 2, 10), -- Blue Rock
    (36, 1, 0, 4, 771, 1, 2, 10), -- Yellow Rock
    (37, 1, 0, 5, 936, 12, 24, 15), -- Rock Salt
    (38, 1, 0, 5, 4101, 6, 12, 10), -- Water Crystal
    (39, 1, 0, 5, 4449, 1, 2, 15), -- Reishi Mushroom
    (40, 1, 0, 5, 4412, 6, 12, 10), -- Thundermelon
    (41, 1, 0, 5, 4468, 6, 12, 10), -- Pamamas
    (42, 1, 0, 5, 4352, 6, 12, 10), -- Derfland Pear
    (43, 1, 0, 5, 770, 1, 2, 10), -- Blue Rock
    (44, 1, 0, 5, 4450, 6, 12, 10), -- Coral Fungus
    (45, 1, 0, 5, 774, 1, 2, 10), -- Purple Rock
    (46, 1, 0, 6, 936, 12, 24, 15), -- Rock Salt
    (47, 1, 0, 6, 17396, 12, 24, 10), -- Little Worm
    (48, 1, 0, 6, 4449, 1, 2, 15), -- Reishi Mushroom
    (49, 1, 0, 6, 4096, 6, 12, 10), -- Fire Crystal
    (50, 1, 0, 6, 4468, 6, 12, 10), -- Pamamas
    (51, 1, 0, 6, 4491, 6, 12, 10), -- Watermelon
    (52, 1, 0, 6, 770, 1, 2, 20), -- Blue Rock
    (53, 1, 0, 6, 4432, 6, 12, 10), -- Kazham Pineapple
    (54, 1, 0, 7, 936, 12, 24, 15), -- Rock Salt
    (55, 1, 0, 7, 4103, 6, 12, 15), -- Dark Crystal
    (56, 1, 0, 7, 4449, 1, 2, 30), -- Reishi Mushroom
    (57, 1, 0, 7, 4363, 6, 12, 10), -- Faerie Apple
    (58, 1, 0, 7, 4468, 6, 12, 10), -- Pamamas
    (59, 1, 0, 7, 770, 1, 2, 10), -- Blue Rock
    (60, 1, 0, 7, 776, 1, 2, 10), -- White Rock
    (61, 1, 0, 8, 936, 12, 24, 15), -- Rock Salt
    (62, 1, 0, 8, 4102, 6, 12, 15), -- Light Crystal
    (63, 1, 0, 8, 4449, 1, 2, 15), -- Reishi Mushroom
    (64, 1, 0, 8, 4392, 6, 12, 15), -- Saruta Orange
    (65, 1, 0, 8, 4468, 6, 12, 10), -- Pamamas
    (66, 1, 0, 8, 4375, 6, 12, 10), -- Danceshroom
    (67, 1, 0, 8, 770, 1, 2, 10), -- Blue Rock
    (68, 1, 0, 8, 775, 1, 2, 10), -- Black Rock
    (69, 1, 1, 0, 936, 12, 24, 15), -- Rock Salt
    (70, 1, 1, 0, 4097, 6, 12, 15), -- Ice Crystal
    (71, 1, 1, 0, 4449, 1, 2, 15), -- Reishi Mushroom
    (72, 1, 1, 0, 4392, 6, 12, 15), -- Saruta Orange
    (73, 1, 1, 0, 4468, 6, 12, 10), -- Pamamas
    (74, 1, 1, 0, 4445, 8, 16, 10), -- Yagudo Cherry
    (75, 1, 1, 0, 770, 1, 2, 10), -- Blue Rock
    (76, 1, 1, 0, 769, 1, 2, 10), -- Red Rock
    (77, 1, 1, 1, 4097, 6, 12, 30), -- Ice Crystal
    (78, 1, 1, 1, 4392, 6, 12, 30), -- Saruta Orange
    (79, 1, 1, 1, 4445, 8, 16, 20), -- Yagudo Cherry
    (80, 1, 1, 1, 769, 1, 2, 20), -- Red Rock
    (81, 1, 1, 2, 4097, 6, 12, 15), -- Ice Crystal
    (82, 1, 1, 2, 4098, 6, 12, 15), -- Wind Crystal
    (83, 1, 1, 2, 4392, 6, 12, 15), -- Saruta Orange
    (84, 1, 1, 2, 4390, 6, 12, 15), -- Mithran Tomato
    (85, 1, 1, 2, 4445, 8, 16, 10), -- Yagudo Cherry
    (86, 1, 1, 2, 4503, 6, 12, 10), -- Buburimu Grape
    (87, 1, 1, 2, 769, 1, 2, 10), -- Red Rock
    (88, 1, 1, 2, 773, 1, 2, 10), -- Translucent Rock
    (89, 1, 1, 3, 4097, 6, 12, 15), -- Ice Crystal
    (90, 1, 1, 3, 4099, 6, 12, 15), -- Earth Crystal
    (91, 1, 1, 3, 4392, 6, 12, 15), -- Saruta Orange
    (92, 1, 1, 3, 4431, 6, 12, 15), -- Bunch Of San dOrian Grapes
    (93, 1, 1, 3, 4445, 8, 16, 10), -- Yagudo Cherry
    (94, 1, 1, 3, 4365, 6, 12, 10), -- Rolanberry
    (95, 1, 1, 3, 769, 1, 2, 10), -- Red Rock
    (96, 1, 1, 3, 772, 1, 2, 10), -- Green Rock
    (97, 1, 1, 4, 4097, 6, 12, 15), -- Ice Crystal
    (98, 1, 1, 4, 4100, 6, 12, 15), -- Lightning Crystal
    (99, 1, 1, 4, 4392, 6, 12, 15), -- Saruta Orange
    (100, 1, 1, 4, 4389, 8, 16, 15), -- San dOrian Carrot
    (101, 1, 1, 4, 4445, 8, 16, 10), -- Yagudo Cherry
    (102, 1, 1, 4, 4388, 8, 16, 10), -- Eggplant
    (103, 1, 1, 4, 769, 1, 2, 10), -- Red Rock
    (104, 1, 1, 4, 771, 1, 2, 10), -- Yellow Rock
    (105, 1, 1, 5, 4097, 6, 12, 15), -- Ice Crystal
    (106, 1, 1, 5, 4101, 6, 12, 10), -- Water Crystal
    (107, 1, 1, 5, 4392, 6, 12, 15), -- Saruta Orange
    (108, 1, 1, 5, 4412, 6, 12, 10), -- Thundermelon
    (109, 1, 1, 5, 4445, 8, 16, 10), -- Yagudo Cherry
    (110, 1, 1, 5, 4352, 6, 12, 10), -- Derfland Pear
    (111, 1, 1, 5, 769, 1, 2, 10), -- Red Rock
    (112, 1, 1, 5, 4450, 6, 12, 10), -- Coral Fungus
    (113, 1, 1, 5, 774, 1, 2, 10), -- Purple Rock
    (114, 1, 1, 6, 4097, 6, 12, 15), -- Ice Crystal
    (115, 1, 1, 6, 17396, 12, 24, 10), -- Little Worm
    (116, 1, 1, 6, 4392, 6, 12, 15), -- Saruta Orange
    (117, 1, 1, 6, 4096, 6, 12, 10), -- Fire Crystal
    (118, 1, 1, 6, 4445, 8, 16, 10), -- Yagudo Cherry
    (119, 1, 1, 6, 4491, 6, 12, 10), -- Watermelon
    (120, 1, 1, 6, 769, 1, 2, 10), -- Red Rock
    (121, 1, 1, 6, 4432, 6, 12, 10), -- Kazham Pineapple
    (122, 1, 1, 6, 770, 1, 2, 10), -- Blue Rock
    (123, 1, 1, 7, 4097, 6, 12, 15), -- Ice Crystal
    (124, 1, 1, 7, 4103, 6, 12, 15), -- Dark Crystal
    (125, 1, 1, 7, 4392, 6, 12, 15), -- Saruta Orange
    (126, 1, 1, 7, 4363, 6, 12, 10), -- Faerie Apple
    (127, 1, 1, 7, 4445, 8, 16, 10), -- Yagudo Cherry
    (128, 1, 1, 7, 4449, 1, 2, 15), -- Reishi Mushroom
    (129, 1, 1, 7, 769, 1, 2, 10), -- Red Rock
    (130, 1, 1, 7, 776, 1, 2, 10), -- White Rock
    (131, 1, 1, 8, 4097, 6, 12, 15), -- Ice Crystal
    (132, 1, 1, 8, 4102, 6, 12, 15), -- Light Crystal
    (133, 1, 1, 8, 4392, 6, 12, 30), -- Saruta Orange
    (134, 1, 1, 8, 4445, 8, 16, 10), -- Yagudo Cherry
    (135, 1, 1, 8, 4375, 6, 12, 10), -- Danceshroom
    (136, 1, 1, 8, 769, 1, 2, 10), -- Red Rock
    (137, 1, 1, 8, 775, 1, 2, 10), -- Black Rock
    (138, 1, 2, 0, 936, 12, 24, 15), -- Rock Salt
    (139, 1, 2, 0, 4098, 6, 12, 15), -- Wind Crystal
    (140, 1, 2, 0, 4449, 1, 2, 15), -- Reishi Mushroom
    (141, 1, 2, 0, 4390, 6, 12, 15), -- Mithran Tomato
    (142, 1, 2, 0, 4468, 6, 12, 10), -- Pamamas
    (143, 1, 2, 0, 4503, 6, 12, 10), -- Buburimu Grape
    (144, 1, 2, 0, 770, 1, 2, 10), -- Blue Rock
    (145, 1, 2, 0, 773, 1, 2, 10), -- Translucent Rock
    (146, 1, 2, 1, 4097, 6, 12, 15), -- Ice Crystal
    (147, 1, 2, 1, 4098, 6, 12, 15), -- Wind Crystal
    (148, 1, 2, 1, 4392, 6, 12, 15), -- Saruta Orange
    (149, 1, 2, 1, 4390, 6, 12, 15), -- Mithran Tomato
    (150, 1, 2, 1, 4445, 8, 16, 10), -- Yagudo Cherry
    (151, 1, 2, 1, 4503, 6, 12, 10), -- Buburimu Grape
    (152, 1, 2, 1, 769, 1, 2, 10), -- Red Rock
    (153, 1, 2, 1, 773, 1, 2, 10), -- Translucent Rock
    (154, 1, 2, 2, 4098, 6, 12, 30), -- Wind Crystal
    (155, 1, 2, 2, 4390, 6, 12, 30), -- Mithran Tomato
    (156, 1, 2, 2, 4503, 6, 12, 20), -- Buburimu Grape
    (157, 1, 2, 2, 773, 1, 2, 20), -- Translucent Rock
    (158, 1, 2, 3, 4098, 6, 12, 15), -- Wind Crystal
    (159, 1, 2, 3, 4099, 6, 12, 15), -- Earth Crystal
    (160, 1, 2, 3, 4390, 6, 12, 15), -- Mithran Tomato
    (161, 1, 2, 3, 4431, 6, 12, 15), -- Bunch Of San dOrian Grapes
    (162, 1, 2, 3, 4503, 6, 12, 10), -- Buburimu Grape
    (163, 1, 2, 3, 4365, 6, 12, 10), -- Rolanberry
    (164, 1, 2, 3, 773, 1, 2, 10), -- Translucent Rock
    (165, 1, 2, 3, 772, 1, 2, 10), -- Green Rock
    (166, 1, 2, 4, 4098, 6, 12, 15), -- Wind Crystal
    (167, 1, 2, 4, 4100, 6, 12, 15), -- Lightning Crystal
    (168, 1, 2, 4, 4390, 6, 12, 15), -- Mithran Tomato
    (169, 1, 2, 4, 4389, 8, 16, 15), -- San dOrian Carrot
    (170, 1, 2, 4, 4503, 6, 12, 10), -- Buburimu Grape
    (171, 1, 2, 4, 4388, 8, 16, 10), -- Eggplant
    (172, 1, 2, 4, 773, 1, 2, 10), -- Translucent Rock
    (173, 1, 2, 4, 771, 1, 2, 10), -- Yellow Rock
    (174, 1, 2, 5, 4098, 6, 12, 15), -- Wind Crystal
    (175, 1, 2, 5, 4101, 6, 12, 10), -- Water Crystal
    (176, 1, 2, 5, 4390, 6, 12, 15), -- Mithran Tomato
    (177, 1, 2, 5, 4412, 6, 12, 10), -- Thundermelon
    (178, 1, 2, 5, 4503, 6, 12, 10), -- Buburimu Grape
    (179, 1, 2, 5, 4352, 6, 12, 10), -- Derfland Pear
    (180, 1, 2, 5, 773, 1, 2, 10), -- Translucent Rock
    (181, 1, 2, 5, 4450, 6, 12, 10), -- Coral Fungus
    (182, 1, 2, 5, 774, 1, 2, 10), -- Purple Rock
    (183, 1, 2, 6, 4098, 6, 12, 15), -- Wind Crystal
    (184, 1, 2, 6, 17396, 12, 24, 10), -- Little Worm
    (185, 1, 2, 6, 4390, 6, 12, 15), -- Mithran Tomato
    (186, 1, 2, 6, 4096, 6, 12, 10), -- Fire Crystal
    (187, 1, 2, 6, 4503, 6, 12, 10), -- Buburimu Grape
    (188, 1, 2, 6, 4491, 6, 12, 10), -- Watermelon
    (189, 1, 2, 6, 773, 1, 2, 10), -- Translucent Rock
    (190, 1, 2, 6, 4432, 6, 12, 10), -- Kazham Pineapple
    (191, 1, 2, 6, 770, 1, 2, 10), -- Blue Rock
    (192, 1, 2, 7, 4098, 6, 12, 15), -- Wind Crystal
    (193, 1, 2, 7, 4103, 6, 12, 15), -- Dark Crystal
    (194, 1, 2, 7, 4390, 6, 12, 15), -- Mithran Tomato
    (195, 1, 2, 7, 4363, 6, 12, 10), -- Faerie Apple
    (196, 1, 2, 7, 4503, 6, 12, 10), -- Buburimu Grape
    (197, 1, 2, 7, 4449, 1, 2, 15), -- Reishi Mushroom
    (198, 1, 2, 7, 773, 1, 2, 10), -- Translucent Rock
    (199, 1, 2, 7, 776, 1, 2, 10), -- White Rock
    (200, 1, 2, 8, 4098, 6, 12, 15), -- Wind Crystal
    (201, 1, 2, 8, 4102, 6, 12, 15), -- Light Crystal
    (202, 1, 2, 8, 4390, 6, 12, 15), -- Mithran Tomato
    (203, 1, 2, 8, 4392, 6, 12, 15), -- Saruta Orange
    (204, 1, 2, 8, 4503, 6, 12, 10), -- Buburimu Grape
    (205, 1, 2, 8, 4375, 6, 12, 10), -- Danceshroom
    (206, 1, 2, 8, 773, 1, 2, 10), -- Translucent Rock
    (207, 1, 2, 8, 775, 1, 2, 10), -- Black Rock
    (208, 1, 3, 0, 936, 12, 24, 15), -- Rock Salt
    (209, 1, 3, 0, 4099, 6, 12, 15), -- Earth Crystal
    (210, 1, 3, 0, 4449, 1, 2, 15), -- Reishi Mushroom
    (211, 1, 3, 0, 4431, 6, 12, 15), -- Bunch Of San dOrian Grapes
    (212, 1, 3, 0, 4468, 6, 12, 10), -- Pamamas
    (213, 1, 3, 0, 4365, 6, 12, 10), -- Rolanberry
    (214, 1, 3, 0, 770, 1, 2, 10), -- Blue Rock
    (215, 1, 3, 0, 772, 1, 2, 10), -- Green Rock
    (216, 1, 3, 1, 4097, 6, 12, 15), -- Ice Crystal
    (217, 1, 3, 1, 4099, 6, 12, 15), -- Earth Crystal
    (218, 1, 3, 1, 4392, 6, 12, 15), -- Saruta Orange
    (219, 1, 3, 1, 4431, 6, 12, 15), -- Bunch Of San dOrian Grapes
    (220, 1, 3, 1, 4445, 8, 16, 10), -- Yagudo Cherry
    (221, 1, 3, 1, 4365, 6, 12, 10), -- Rolanberry
    (222, 1, 3, 1, 769, 1, 2, 10), -- Red Rock
    (223, 1, 3, 1, 772, 1, 2, 10), -- Green Rock
    (224, 1, 3, 2, 4098, 6, 12, 15), -- Wind Crystal
    (225, 1, 3, 2, 4099, 6, 12, 15), -- Earth Crystal
    (226, 1, 3, 2, 4390, 6, 12, 15), -- Mithran Tomato
    (227, 1, 3, 2, 4431, 6, 12, 15), -- Bunch Of San dOrian Grapes
    (228, 1, 3, 2, 4503, 6, 12, 10), -- Buburimu Grape
    (229, 1, 3, 2, 4365, 6, 12, 10), -- Rolanberry
    (230, 1, 3, 2, 773, 1, 2, 10), -- Translucent Rock
    (231, 1, 3, 2, 772, 1, 2, 10), -- Green Rock
    (232, 1, 3, 3, 4099, 6, 12, 30), -- Earth Crystal
    (233, 1, 3, 3, 4431, 6, 12, 30), -- Bunch Of San dOrian Grapes
    (234, 1, 3, 3, 4365, 6, 12, 20), -- Rolanberry
    (235, 1, 3, 3, 772, 1, 2, 20), -- Green Rock
    (236, 1, 3, 4, 4099, 6, 12, 15), -- Earth Crystal
    (237, 1, 3, 4, 4100, 6, 12, 15), -- Lightning Crystal
    (238, 1, 3, 4, 4431, 6, 12, 15), -- Bunch Of San dOrian Grapes
    (239, 1, 3, 4, 4389, 8, 16, 15), -- San dOrian Carrot
    (240, 1, 3, 4, 4365, 6, 12, 10), -- Rolanberry
    (241, 1, 3, 4, 4388, 8, 16, 10), -- Eggplant
    (242, 1, 3, 4, 772, 1, 2, 10), -- Green Rock
    (243, 1, 3, 4, 771, 1, 2, 10), -- Yellow Rock
    (244, 1, 3, 5, 4099, 6, 12, 15), -- Earth Crystal
    (245, 1, 3, 5, 4101, 6, 12, 10), -- Water Crystal
    (246, 1, 3, 5, 4431, 6, 12, 15), -- Bunch Of San dOrian Grapes
    (247, 1, 3, 5, 4412, 6, 12, 10), -- Thundermelon
    (248, 1, 3, 5, 4365, 6, 12, 10), -- Rolanberry
    (249, 1, 3, 5, 4352, 6, 12, 10), -- Derfland Pear
    (250, 1, 3, 5, 772, 1, 2, 10), -- Green Rock
    (251, 1, 3, 5, 4450, 6, 12, 10), -- Coral Fungus
    (252, 1, 3, 5, 774, 1, 2, 10), -- Purple Rock
    (253, 1, 3, 6, 4099, 6, 12, 15), -- Earth Crystal
    (254, 1, 3, 6, 17396, 12, 24, 10), -- Little Worm
    (255, 1, 3, 6, 4431, 6, 12, 15), -- Bunch Of San dOrian Grapes
    (256, 1, 3, 6, 4096, 6, 12, 10), -- Fire Crystal
    (257, 1, 3, 6, 4365, 6, 12, 10), -- Rolanberry
    (258, 1, 3, 6, 4491, 6, 12, 10), -- Watermelon
    (259, 1, 3, 6, 772, 1, 2, 10), -- Green Rock
    (260, 1, 3, 6, 4432, 6, 12, 10), -- Kazham Pineapple
    (261, 1, 3, 6, 770, 1, 2, 10), -- Blue Rock
    (262, 1, 3, 7, 4099, 6, 12, 15), -- Earth Crystal
    (263, 1, 3, 7, 4103, 6, 12, 15), -- Dark Crystal
    (264, 1, 3, 7, 4431, 6, 12, 15), -- Bunch Of San dOrian Grapes
    (265, 1, 3, 7, 4363, 6, 12, 10), -- Faerie Apple
    (266, 1, 3, 7, 4365, 6, 12, 10), -- Rolanberry
    (267, 1, 3, 7, 4449, 1, 2, 15), -- Reishi Mushroom
    (268, 1, 3, 7, 772, 1, 2, 10), -- Green Rock
    (269, 1, 3, 7, 776, 1, 2, 10), -- White Rock
    (270, 1, 3, 8, 4099, 6, 12, 15), -- Earth Crystal
    (271, 1, 3, 8, 4102, 6, 12, 15), -- Light Crystal
    (272, 1, 3, 8, 4431, 6, 12, 15), -- Bunch Of San dOrian Grapes
    (273, 1, 3, 8, 4392, 6, 12, 15), -- Saruta Orange
    (274, 1, 3, 8, 4365, 6, 12, 10), -- Rolanberry
    (275, 1, 3, 8, 4375, 6, 12, 10), -- Danceshroom
    (276, 1, 3, 8, 772, 1, 2, 10), -- Green Rock
    (277, 1, 3, 8, 775, 1, 2, 10), -- Black Rock
    (278, 1, 4, 0, 936, 12, 24, 15), -- Rock Salt
    (279, 1, 4, 0, 4100, 6, 12, 15), -- Lightning Crystal
    (280, 1, 4, 0, 4449, 1, 2, 15), -- Reishi Mushroom
    (281, 1, 4, 0, 4389, 8, 16, 15), -- San dOrian Carrot
    (282, 1, 4, 0, 4468, 6, 12, 10), -- Pamamas
    (283, 1, 4, 0, 4388, 8, 16, 10), -- Eggplant
    (284, 1, 4, 0, 770, 1, 2, 10), -- Blue Rock
    (285, 1, 4, 0, 771, 1, 2, 10), -- Yellow Rock
    (286, 1, 4, 1, 4097, 6, 12, 15), -- Ice Crystal
    (287, 1, 4, 1, 4100, 6, 12, 15), -- Lightning Crystal
    (288, 1, 4, 1, 4392, 6, 12, 15), -- Saruta Orange
    (289, 1, 4, 1, 4389, 8, 16, 15), -- San dOrian Carrot
    (290, 1, 4, 1, 4445, 8, 16, 10), -- Yagudo Cherry
    (291, 1, 4, 1, 4388, 8, 16, 10), -- Eggplant
    (292, 1, 4, 1, 769, 1, 2, 10), -- Red Rock
    (293, 1, 4, 1, 771, 1, 2, 10), -- Yellow Rock
    (294, 1, 4, 2, 4098, 6, 12, 15), -- Wind Crystal
    (295, 1, 4, 2, 4100, 6, 12, 15), -- Lightning Crystal
    (296, 1, 4, 2, 4390, 6, 12, 15), -- Mithran Tomato
    (297, 1, 4, 2, 4389, 8, 16, 15), -- San dOrian Carrot
    (298, 1, 4, 2, 4503, 6, 12, 10), -- Buburimu Grape
    (299, 1, 4, 2, 4388, 8, 16, 10), -- Eggplant
    (300, 1, 4, 2, 773, 1, 2, 10), -- Translucent Rock
    (301, 1, 4, 2, 771, 1, 2, 10), -- Yellow Rock
    (302, 1, 4, 3, 4099, 6, 12, 15), -- Earth Crystal
    (303, 1, 4, 3, 4100, 6, 12, 15), -- Lightning Crystal
    (304, 1, 4, 3, 4431, 6, 12, 15), -- Bunch Of San dOrian Grapes
    (305, 1, 4, 3, 4389, 8, 16, 15), -- San dOrian Carrot
    (306, 1, 4, 3, 4365, 6, 12, 10), -- Rolanberry
    (307, 1, 4, 3, 4388, 8, 16, 10), -- Eggplant
    (308, 1, 4, 3, 772, 1, 2, 10), -- Green Rock
    (309, 1, 4, 3, 771, 1, 2, 10), -- Yellow Rock
    (310, 1, 4, 4, 4100, 6, 12, 30), -- Lightning Crystal
    (311, 1, 4, 4, 4389, 8, 16, 30), -- San dOrian Carrot
    (312, 1, 4, 4, 4388, 8, 16, 20), -- Eggplant
    (313, 1, 4, 4, 771, 1, 2, 20), -- Yellow Rock
    (314, 1, 4, 5, 4100, 6, 12, 15), -- Lightning Crystal
    (315, 1, 4, 5, 4101, 6, 12, 10), -- Water Crystal
    (316, 1, 4, 5, 4389, 8, 16, 15), -- San dOrian Carrot
    (317, 1, 4, 5, 4412, 6, 12, 10), -- Thundermelon
    (318, 1, 4, 5, 4388, 8, 16, 10), -- Eggplant
    (319, 1, 4, 5, 4352, 6, 12, 10), -- Derfland Pear
    (320, 1, 4, 5, 771, 1, 2, 10), -- Yellow Rock
    (321, 1, 4, 5, 4450, 6, 12, 10), -- Coral Fungus
    (322, 1, 4, 5, 774, 1, 2, 10), -- Purple Rock
    (323, 1, 4, 6, 4100, 6, 12, 15), -- Lightning Crystal
    (324, 1, 4, 6, 17396, 12, 24, 10), -- Little Worm
    (325, 1, 4, 6, 4389, 8, 16, 15), -- San dOrian Carrot
    (326, 1, 4, 6, 4096, 6, 12, 10), -- Fire Crystal
    (327, 1, 4, 6, 4388, 8, 16, 10), -- Eggplant
    (328, 1, 4, 6, 4491, 6, 12, 10), -- Watermelon
    (329, 1, 4, 6, 771, 1, 2, 10), -- Yellow Rock
    (330, 1, 4, 6, 4432, 6, 12, 10), -- Kazham Pineapple
    (331, 1, 4, 6, 770, 1, 2, 10), -- Blue Rock
    (332, 1, 4, 7, 4100, 6, 12, 15), -- Lightning Crystal
    (333, 1, 4, 7, 4103, 6, 12, 15), -- Dark Crystal
    (334, 1, 4, 7, 4389, 8, 16, 15), -- San dOrian Carrot
    (335, 1, 4, 7, 4363, 6, 12, 10), -- Faerie Apple
    (336, 1, 4, 7, 4388, 8, 16, 10), -- Eggplant
    (337, 1, 4, 7, 4449, 1, 2, 15), -- Reishi Mushroom
    (338, 1, 4, 7, 771, 1, 2, 10), -- Yellow Rock
    (339, 1, 4, 7, 776, 1, 2, 10), -- White Rock
    (340, 1, 4, 8, 4100, 6, 12, 15), -- Lightning Crystal
    (341, 1, 4, 8, 4102, 6, 12, 15), -- Light Crystal
    (342, 1, 4, 8, 4389, 8, 16, 15), -- San dOrian Carrot
    (343, 1, 4, 8, 4392, 6, 12, 15), -- Saruta Orange
    (344, 1, 4, 8, 4388, 8, 16, 10), -- Eggplant
    (345, 1, 4, 8, 4375, 6, 12, 10), -- Danceshroom
    (346, 1, 4, 8, 771, 1, 2, 10), -- Yellow Rock
    (347, 1, 4, 8, 775, 1, 2, 10), -- Black Rock
    (348, 1, 5, 0, 936, 12, 24, 15), -- Rock Salt
    (349, 1, 5, 0, 4101, 6, 12, 10), -- Water Crystal
    (350, 1, 5, 0, 4449, 1, 2, 15), -- Reishi Mushroom
    (351, 1, 5, 0, 4412, 6, 12, 10), -- Thundermelon
    (352, 1, 5, 0, 4468, 6, 12, 10), -- Pamamas
    (353, 1, 5, 0, 4352, 6, 12, 10), -- Derfland Pear
    (354, 1, 5, 0, 770, 1, 2, 10), -- Blue Rock
    (355, 1, 5, 0, 4450, 6, 12, 10), -- Coral Fungus
    (356, 1, 5, 0, 774, 1, 2, 10), -- Purple Rock
    (357, 1, 5, 1, 4097, 6, 12, 15), -- Ice Crystal
    (358, 1, 5, 1, 4101, 6, 12, 10), -- Water Crystal
    (359, 1, 5, 1, 4392, 6, 12, 15), -- Saruta Orange
    (360, 1, 5, 1, 4412, 6, 12, 10), -- Thundermelon
    (361, 1, 5, 1, 4445, 8, 16, 10), -- Yagudo Cherry
    (362, 1, 5, 1, 4352, 6, 12, 10), -- Derfland Pear
    (363, 1, 5, 1, 769, 1, 2, 10), -- Red Rock
    (364, 1, 5, 1, 4450, 6, 12, 10), -- Coral Fungus
    (365, 1, 5, 1, 774, 1, 2, 10), -- Purple Rock
    (366, 1, 5, 2, 4098, 6, 12, 15), -- Wind Crystal
    (367, 1, 5, 2, 4101, 6, 12, 10), -- Water Crystal
    (368, 1, 5, 2, 4390, 6, 12, 15), -- Mithran Tomato
    (369, 1, 5, 2, 4412, 6, 12, 10), -- Thundermelon
    (370, 1, 5, 2, 4503, 6, 12, 10), -- Buburimu Grape
    (371, 1, 5, 2, 4352, 6, 12, 10), -- Derfland Pear
    (372, 1, 5, 2, 773, 1, 2, 10), -- Translucent Rock
    (373, 1, 5, 2, 4450, 6, 12, 10), -- Coral Fungus
    (374, 1, 5, 2, 774, 1, 2, 10), -- Purple Rock
    (375, 1, 5, 3, 4099, 6, 12, 15), -- Earth Crystal
    (376, 1, 5, 3, 4101, 6, 12, 10), -- Water Crystal
    (377, 1, 5, 3, 4431, 6, 12, 15), -- Bunch Of San dOrian Grapes
    (378, 1, 5, 3, 4412, 6, 12, 10), -- Thundermelon
    (379, 1, 5, 3, 4365, 6, 12, 10), -- Rolanberry
    (380, 1, 5, 3, 4352, 6, 12, 10), -- Derfland Pear
    (381, 1, 5, 3, 772, 1, 2, 10), -- Green Rock
    (382, 1, 5, 3, 4450, 6, 12, 10), -- Coral Fungus
    (383, 1, 5, 3, 774, 1, 2, 10), -- Purple Rock
    (384, 1, 5, 4, 4100, 6, 12, 15), -- Lightning Crystal
    (385, 1, 5, 4, 4101, 6, 12, 10), -- Water Crystal
    (386, 1, 5, 4, 4389, 8, 16, 15), -- San dOrian Carrot
    (387, 1, 5, 4, 4412, 6, 12, 10), -- Thundermelon
    (388, 1, 5, 4, 4388, 8, 16, 10), -- Eggplant
    (389, 1, 5, 4, 4352, 6, 12, 10), -- Derfland Pear
    (390, 1, 5, 4, 771, 1, 2, 10), -- Yellow Rock
    (391, 1, 5, 4, 4450, 6, 12, 10), -- Coral Fungus
    (392, 1, 5, 4, 774, 1, 2, 10), -- Purple Rock
    (393, 1, 5, 5, 4101, 6, 12, 20), -- Water Crystal
    (394, 1, 5, 5, 4412, 6, 12, 20), -- Thundermelon
    (395, 1, 5, 5, 4352, 6, 12, 20), -- Derfland Pear
    (396, 1, 5, 5, 4450, 6, 12, 20), -- Coral Fungus
    (397, 1, 5, 5, 774, 1, 2, 20), -- Purple Rock
    (398, 1, 5, 6, 4101, 6, 12, 10), -- Water Crystal
    (399, 1, 5, 6, 17396, 12, 24, 10), -- Little Worm
    (400, 1, 5, 6, 4412, 6, 12, 10), -- Thundermelon
    (401, 1, 5, 6, 4096, 6, 12, 10), -- Fire Crystal
    (402, 1, 5, 6, 4352, 6, 12, 10), -- Derfland Pear
    (403, 1, 5, 6, 4491, 6, 12, 10), -- Watermelon
    (404, 1, 5, 6, 4450, 6, 12, 10), -- Coral Fungus
    (405, 1, 5, 6, 4432, 6, 12, 10), -- Kazham Pineapple
    (406, 1, 5, 6, 774, 1, 2, 10), -- Purple Rock
    (407, 1, 5, 6, 770, 1, 2, 10), -- Blue Rock
    (408, 1, 5, 7, 4101, 6, 12, 10), -- Water Crystal
    (409, 1, 5, 7, 4103, 6, 12, 15), -- Dark Crystal
    (410, 1, 5, 7, 4412, 6, 12, 10), -- Thundermelon
    (411, 1, 5, 7, 4363, 6, 12, 10), -- Faerie Apple
    (412, 1, 5, 7, 4352, 6, 12, 10), -- Derfland Pear
    (413, 1, 5, 7, 4449, 1, 2, 15), -- Reishi Mushroom
    (414, 1, 5, 7, 4450, 6, 12, 10), -- Coral Fungus
    (415, 1, 5, 7, 776, 1, 2, 10), -- White Rock
    (416, 1, 5, 7, 774, 1, 2, 10), -- Purple Rock
    (417, 1, 5, 8, 4101, 6, 12, 10), -- Water Crystal
    (418, 1, 5, 8, 4102, 6, 12, 15), -- Light Crystal
    (419, 1, 5, 8, 4412, 6, 12, 10), -- Thundermelon
    (420, 1, 5, 8, 4392, 6, 12, 15), -- Saruta Orange
    (421, 1, 5, 8, 4352, 6, 12, 10), -- Derfland Pear
    (422, 1, 5, 8, 4375, 6, 12, 10), -- Danceshroom
    (423, 1, 5, 8, 4450, 6, 12, 10), -- Coral Fungus
    (424, 1, 5, 8, 775, 1, 2, 10), -- Black Rock
    (425, 1, 5, 8, 774, 1, 2, 10), -- Purple Rock
    (426, 1, 6, 0, 936, 12, 24, 15), -- Rock Salt
    (427, 1, 6, 0, 17396, 12, 24, 10), -- Little Worm
    (428, 1, 6, 0, 4449, 1, 2, 15), -- Reishi Mushroom
    (429, 1, 6, 0, 4096, 6, 12, 10), -- Fire Crystal
    (430, 1, 6, 0, 4468, 6, 12, 10), -- Pamamas
    (431, 1, 6, 0, 4491, 6, 12, 10), -- Watermelon
    (432, 1, 6, 0, 770, 1, 2, 20), -- Blue Rock
    (433, 1, 6, 0, 4432, 6, 12, 10), -- Kazham Pineapple
    (434, 1, 6, 1, 4097, 6, 12, 15), -- Ice Crystal
    (435, 1, 6, 1, 17396, 12, 24, 10), -- Little Worm
    (436, 1, 6, 1, 4392, 6, 12, 15), -- Saruta Orange
    (437, 1, 6, 1, 4096, 6, 12, 10), -- Fire Crystal
    (438, 1, 6, 1, 4445, 8, 16, 10), -- Yagudo Cherry
    (439, 1, 6, 1, 4491, 6, 12, 10), -- Watermelon
    (440, 1, 6, 1, 769, 1, 2, 10), -- Red Rock
    (441, 1, 6, 1, 4432, 6, 12, 10), -- Kazham Pineapple
    (442, 1, 6, 1, 770, 1, 2, 10), -- Blue Rock
    (443, 1, 6, 2, 4098, 6, 12, 15), -- Wind Crystal
    (444, 1, 6, 2, 17396, 12, 24, 10), -- Little Worm
    (445, 1, 6, 2, 4390, 6, 12, 15), -- Mithran Tomato
    (446, 1, 6, 2, 4096, 6, 12, 10), -- Fire Crystal
    (447, 1, 6, 2, 4503, 6, 12, 10), -- Buburimu Grape
    (448, 1, 6, 2, 4491, 6, 12, 10), -- Watermelon
    (449, 1, 6, 2, 773, 1, 2, 10), -- Translucent Rock
    (450, 1, 6, 2, 4432, 6, 12, 10), -- Kazham Pineapple
    (451, 1, 6, 2, 770, 1, 2, 10), -- Blue Rock
    (452, 1, 6, 3, 4099, 6, 12, 15), -- Earth Crystal
    (453, 1, 6, 3, 17396, 12, 24, 10), -- Little Worm
    (454, 1, 6, 3, 4431, 6, 12, 15), -- Bunch Of San dOrian Grapes
    (455, 1, 6, 3, 4096, 6, 12, 10), -- Fire Crystal
    (456, 1, 6, 3, 4365, 6, 12, 10), -- Rolanberry
    (457, 1, 6, 3, 4491, 6, 12, 10), -- Watermelon
    (458, 1, 6, 3, 772, 1, 2, 10), -- Green Rock
    (459, 1, 6, 3, 4432, 6, 12, 10), -- Kazham Pineapple
    (460, 1, 6, 3, 770, 1, 2, 10), -- Blue Rock
    (461, 1, 6, 4, 4100, 6, 12, 15), -- Lightning Crystal
    (462, 1, 6, 4, 17396, 12, 24, 10), -- Little Worm
    (463, 1, 6, 4, 4389, 8, 16, 15), -- San dOrian Carrot
    (464, 1, 6, 4, 4096, 6, 12, 10), -- Fire Crystal
    (465, 1, 6, 4, 4388, 8, 16, 10), -- Eggplant
    (466, 1, 6, 4, 4491, 6, 12, 10), -- Watermelon
    (467, 1, 6, 4, 771, 1, 2, 10), -- Yellow Rock
    (468, 1, 6, 4, 4432, 6, 12, 10), -- Kazham Pineapple
    (469, 1, 6, 4, 770, 1, 2, 10), -- Blue Rock
    (470, 1, 6, 5, 4101, 6, 12, 10), -- Water Crystal
    (471, 1, 6, 5, 17396, 12, 24, 10), -- Little Worm
    (472, 1, 6, 5, 4412, 6, 12, 10), -- Thundermelon
    (473, 1, 6, 5, 4096, 6, 12, 10), -- Fire Crystal
    (474, 1, 6, 5, 4352, 6, 12, 10), -- Derfland Pear
    (475, 1, 6, 5, 4491, 6, 12, 10), -- Watermelon
    (476, 1, 6, 5, 4450, 6, 12, 10), -- Coral Fungus
    (477, 1, 6, 5, 4432, 6, 12, 10), -- Kazham Pineapple
    (478, 1, 6, 5, 774, 1, 2, 10), -- Purple Rock
    (479, 1, 6, 5, 770, 1, 2, 10), -- Blue Rock
    (480, 1, 6, 6, 17396, 12, 24, 20), -- Little Worm
    (481, 1, 6, 6, 4096, 6, 12, 20), -- Fire Crystal
    (482, 1, 6, 6, 4491, 6, 12, 20), -- Watermelon
    (483, 1, 6, 6, 4432, 6, 12, 20), -- Kazham Pineapple
    (484, 1, 6, 6, 770, 1, 2, 20), -- Blue Rock
    (485, 1, 6, 7, 17396, 12, 24, 10), -- Little Worm
    (486, 1, 6, 7, 4103, 6, 12, 15), -- Dark Crystal
    (487, 1, 6, 7, 4096, 6, 12, 10), -- Fire Crystal
    (488, 1, 6, 7, 4363, 6, 12, 10), -- Faerie Apple
    (489, 1, 6, 7, 4491, 6, 12, 10), -- Watermelon
    (490, 1, 6, 7, 4449, 1, 2, 15), -- Reishi Mushroom
    (491, 1, 6, 7, 4432, 6, 12, 10), -- Kazham Pineapple
    (492, 1, 6, 7, 776, 1, 2, 10), -- White Rock
    (493, 1, 6, 7, 770, 1, 2, 10), -- Blue Rock
    (494, 1, 6, 8, 17396, 12, 24, 10), -- Little Worm
    (495, 1, 6, 8, 4102, 6, 12, 15), -- Light Crystal
    (496, 1, 6, 8, 4096, 6, 12, 10), -- Fire Crystal
    (497, 1, 6, 8, 4392, 6, 12, 15), -- Saruta Orange
    (498, 1, 6, 8, 4491, 6, 12, 10), -- Watermelon
    (499, 1, 6, 8, 4375, 6, 12, 10), -- Danceshroom
    (500, 1, 6, 8, 4432, 6, 12, 10), -- Kazham Pineapple
    (501, 1, 6, 8, 775, 1, 2, 10), -- Black Rock
    (502, 1, 6, 8, 770, 1, 2, 10), -- Blue Rock
    (503, 1, 7, 0, 936, 12, 24, 15), -- Rock Salt
    (504, 1, 7, 0, 4103, 6, 12, 15), -- Dark Crystal
    (505, 1, 7, 0, 4449, 1, 2, 30), -- Reishi Mushroom
    (506, 1, 7, 0, 4363, 6, 12, 10), -- Faerie Apple
    (507, 1, 7, 0, 4468, 6, 12, 10), -- Pamamas
    (508, 1, 7, 0, 770, 1, 2, 10), -- Blue Rock
    (509, 1, 7, 0, 776, 1, 2, 10), -- White Rock
    (510, 1, 7, 1, 4097, 6, 12, 15), -- Ice Crystal
    (511, 1, 7, 1, 4103, 6, 12, 15), -- Dark Crystal
    (512, 1, 7, 1, 4392, 6, 12, 15), -- Saruta Orange
    (513, 1, 7, 1, 4363, 6, 12, 10), -- Faerie Apple
    (514, 1, 7, 1, 4445, 8, 16, 10), -- Yagudo Cherry
    (515, 1, 7, 1, 4449, 1, 2, 15), -- Reishi Mushroom
    (516, 1, 7, 1, 769, 1, 2, 10), -- Red Rock
    (517, 1, 7, 1, 776, 1, 2, 10), -- White Rock
    (518, 1, 7, 2, 4098, 6, 12, 15), -- Wind Crystal
    (519, 1, 7, 2, 4103, 6, 12, 15), -- Dark Crystal
    (520, 1, 7, 2, 4390, 6, 12, 15), -- Mithran Tomato
    (521, 1, 7, 2, 4363, 6, 12, 10), -- Faerie Apple
    (522, 1, 7, 2, 4503, 6, 12, 10), -- Buburimu Grape
    (523, 1, 7, 2, 4449, 1, 2, 15), -- Reishi Mushroom
    (524, 1, 7, 2, 773, 1, 2, 10), -- Translucent Rock
    (525, 1, 7, 2, 776, 1, 2, 10), -- White Rock
    (526, 1, 7, 3, 4099, 6, 12, 15), -- Earth Crystal
    (527, 1, 7, 3, 4103, 6, 12, 15), -- Dark Crystal
    (528, 1, 7, 3, 4431, 6, 12, 15), -- Bunch Of San dOrian Grapes
    (529, 1, 7, 3, 4363, 6, 12, 10), -- Faerie Apple
    (530, 1, 7, 3, 4365, 6, 12, 10), -- Rolanberry
    (531, 1, 7, 3, 4449, 1, 2, 15), -- Reishi Mushroom
    (532, 1, 7, 3, 772, 1, 2, 10), -- Green Rock
    (533, 1, 7, 3, 776, 1, 2, 10), -- White Rock
    (534, 1, 7, 4, 4100, 6, 12, 15), -- Lightning Crystal
    (535, 1, 7, 4, 4103, 6, 12, 15), -- Dark Crystal
    (536, 1, 7, 4, 4389, 8, 16, 15), -- San dOrian Carrot
    (537, 1, 7, 4, 4363, 6, 12, 10), -- Faerie Apple
    (538, 1, 7, 4, 4388, 8, 16, 10), -- Eggplant
    (539, 1, 7, 4, 4449, 1, 2, 15), -- Reishi Mushroom
    (540, 1, 7, 4, 771, 1, 2, 10), -- Yellow Rock
    (541, 1, 7, 4, 776, 1, 2, 10), -- White Rock
    (542, 1, 7, 5, 4101, 6, 12, 10), -- Water Crystal
    (543, 1, 7, 5, 4103, 6, 12, 15), -- Dark Crystal
    (544, 1, 7, 5, 4412, 6, 12, 10), -- Thundermelon
    (545, 1, 7, 5, 4363, 6, 12, 10), -- Faerie Apple
    (546, 1, 7, 5, 4352, 6, 12, 10), -- Derfland Pear
    (547, 1, 7, 5, 4449, 1, 2, 15), -- Reishi Mushroom
    (548, 1, 7, 5, 4450, 6, 12, 10), -- Coral Fungus
    (549, 1, 7, 5, 776, 1, 2, 10), -- White Rock
    (550, 1, 7, 5, 774, 1, 2, 10), -- Purple Rock
    (551, 1, 7, 6, 17396, 12, 24, 10), -- Little Worm
    (552, 1, 7, 6, 4103, 6, 12, 15), -- Dark Crystal
    (553, 1, 7, 6, 4096, 6, 12, 10), -- Fire Crystal
    (554, 1, 7, 6, 4363, 6, 12, 10), -- Faerie Apple
    (555, 1, 7, 6, 4491, 6, 12, 10), -- Watermelon
    (556, 1, 7, 6, 4449, 1, 2, 15), -- Reishi Mushroom
    (557, 1, 7, 6, 4432, 6, 12, 10), -- Kazham Pineapple
    (558, 1, 7, 6, 776, 1, 2, 10), -- White Rock
    (559, 1, 7, 6, 770, 1, 2, 10), -- Blue Rock
    (560, 1, 7, 7, 4103, 6, 12, 30), -- Dark Crystal
    (561, 1, 7, 7, 4363, 6, 12, 20), -- Faerie Apple
    (562, 1, 7, 7, 4449, 1, 2, 30), -- Reishi Mushroom
    (563, 1, 7, 7, 776, 1, 2, 20), -- White Rock
    (564, 1, 7, 8, 4103, 6, 12, 15), -- Dark Crystal
    (565, 1, 7, 8, 4102, 6, 12, 15), -- Light Crystal
    (566, 1, 7, 8, 4363, 6, 12, 10), -- Faerie Apple
    (567, 1, 7, 8, 4392, 6, 12, 15), -- Saruta Orange
    (568, 1, 7, 8, 4449, 1, 2, 15), -- Reishi Mushroom
    (569, 1, 7, 8, 4375, 6, 12, 10), -- Danceshroom
    (570, 1, 7, 8, 776, 1, 2, 10), -- White Rock
    (571, 1, 7, 8, 775, 1, 2, 10), -- Black Rock
    (572, 1, 8, 0, 936, 12, 24, 15), -- Rock Salt
    (573, 1, 8, 0, 4102, 6, 12, 15), -- Light Crystal
    (574, 1, 8, 0, 4449, 1, 2, 15), -- Reishi Mushroom
    (575, 1, 8, 0, 4392, 6, 12, 15), -- Saruta Orange
    (576, 1, 8, 0, 4468, 6, 12, 10), -- Pamamas
    (577, 1, 8, 0, 4375, 6, 12, 10), -- Danceshroom
    (578, 1, 8, 0, 770, 1, 2, 10), -- Blue Rock
    (579, 1, 8, 0, 775, 1, 2, 10), -- Black Rock
    (580, 1, 8, 1, 4097, 6, 12, 15), -- Ice Crystal
    (581, 1, 8, 1, 4102, 6, 12, 15), -- Light Crystal
    (582, 1, 8, 1, 4392, 6, 12, 30), -- Saruta Orange
    (583, 1, 8, 1, 4445, 8, 16, 10), -- Yagudo Cherry
    (584, 1, 8, 1, 4375, 6, 12, 10), -- Danceshroom
    (585, 1, 8, 1, 769, 1, 2, 10), -- Red Rock
    (586, 1, 8, 1, 775, 1, 2, 10), -- Black Rock
    (587, 1, 8, 2, 4098, 6, 12, 15), -- Wind Crystal
    (588, 1, 8, 2, 4102, 6, 12, 15), -- Light Crystal
    (589, 1, 8, 2, 4390, 6, 12, 15), -- Mithran Tomato
    (590, 1, 8, 2, 4392, 6, 12, 15), -- Saruta Orange
    (591, 1, 8, 2, 4503, 6, 12, 10), -- Buburimu Grape
    (592, 1, 8, 2, 4375, 6, 12, 10), -- Danceshroom
    (593, 1, 8, 2, 773, 1, 2, 10), -- Translucent Rock
    (594, 1, 8, 2, 775, 1, 2, 10), -- Black Rock
    (595, 1, 8, 3, 4099, 6, 12, 15), -- Earth Crystal
    (596, 1, 8, 3, 4102, 6, 12, 15), -- Light Crystal
    (597, 1, 8, 3, 4431, 6, 12, 15), -- Bunch Of San dOrian Grapes
    (598, 1, 8, 3, 4392, 6, 12, 15), -- Saruta Orange
    (599, 1, 8, 3, 4365, 6, 12, 10), -- Rolanberry
    (600, 1, 8, 3, 4375, 6, 12, 10), -- Danceshroom
    (601, 1, 8, 3, 772, 1, 2, 10), -- Green Rock
    (602, 1, 8, 3, 775, 1, 2, 10), -- Black Rock
    (603, 1, 8, 4, 4100, 6, 12, 15), -- Lightning Crystal
    (604, 1, 8, 4, 4102, 6, 12, 15), -- Light Crystal
    (605, 1, 8, 4, 4389, 8, 16, 15), -- San dOrian Carrot
    (606, 1, 8, 4, 4392, 6, 12, 15), -- Saruta Orange
    (607, 1, 8, 4, 4388, 8, 16, 10), -- Eggplant
    (608, 1, 8, 4, 4375, 6, 12, 10), -- Danceshroom
    (609, 1, 8, 4, 771, 1, 2, 10), -- Yellow Rock
    (610, 1, 8, 4, 775, 1, 2, 10), -- Black Rock
    (611, 1, 8, 5, 4101, 6, 12, 10), -- Water Crystal
    (612, 1, 8, 5, 4102, 6, 12, 15), -- Light Crystal
    (613, 1, 8, 5, 4412, 6, 12, 10), -- Thundermelon
    (614, 1, 8, 5, 4392, 6, 12, 15), -- Saruta Orange
    (615, 1, 8, 5, 4352, 6, 12, 10), -- Derfland Pear
    (616, 1, 8, 5, 4375, 6, 12, 10), -- Danceshroom
    (617, 1, 8, 5, 4450, 6, 12, 10), -- Coral Fungus
    (618, 1, 8, 5, 775, 1, 2, 10), -- Black Rock
    (619, 1, 8, 5, 774, 1, 2, 10), -- Purple Rock
    (620, 1, 8, 6, 17396, 12, 24, 10), -- Little Worm
    (621, 1, 8, 6, 4102, 6, 12, 15), -- Light Crystal
    (622, 1, 8, 6, 4096, 6, 12, 10), -- Fire Crystal
    (623, 1, 8, 6, 4392, 6, 12, 15), -- Saruta Orange
    (624, 1, 8, 6, 4491, 6, 12, 10), -- Watermelon
    (625, 1, 8, 6, 4375, 6, 12, 10), -- Danceshroom
    (626, 1, 8, 6, 4432, 6, 12, 10), -- Kazham Pineapple
    (627, 1, 8, 6, 775, 1, 2, 10), -- Black Rock
    (628, 1, 8, 6, 770, 1, 2, 10), -- Blue Rock
    (629, 1, 8, 7, 4103, 6, 12, 15), -- Dark Crystal
    (630, 1, 8, 7, 4102, 6, 12, 15), -- Light Crystal
    (631, 1, 8, 7, 4363, 6, 12, 10), -- Faerie Apple
    (632, 1, 8, 7, 4392, 6, 12, 15), -- Saruta Orange
    (633, 1, 8, 7, 4449, 1, 2, 15), -- Reishi Mushroom
    (634, 1, 8, 7, 4375, 6, 12, 10), -- Danceshroom
    (635, 1, 8, 7, 776, 1, 2, 10), -- White Rock
    (636, 1, 8, 7, 775, 1, 2, 10), -- Black Rock
    (637, 1, 8, 8, 4102, 6, 12, 30), -- Light Crystal
    (638, 1, 8, 8, 4392, 6, 12, 30), -- Saruta Orange
    (639, 1, 8, 8, 4375, 6, 12, 20), -- Danceshroom
    (640, 1, 8, 8, 775, 1, 2, 20), -- Black Rock
    (641, 2, 0, 0, 936, 12, 24, 30), -- Rock Salt
    (642, 2, 0, 0, 957, 4, 8, 30), -- Amaryllis
    (643, 2, 0, 0, 772, 1, 2, 20), -- Green Rock
    (644, 2, 0, 0, 4386, 1, 2, 20), -- King Truffle
    (645, 2, 1, 0, 4097, 4, 12, 40), -- Ice Crystal
    (646, 2, 1, 0, 612, 12, 24, 30), -- Kazham Peppers
    (647, 2, 1, 0, 5195, 4, 8, 30), -- Sprig Of Misareaux Parsley
    (648, 2, 2, 0, 936, 12, 24, 30), -- Rock Salt
    (649, 2, 2, 0, 4098, 4, 12, 20), -- Wind Crystal
    (650, 2, 2, 0, 636, 4, 8, 20), -- Chamomile
    (651, 2, 2, 0, 4374, 1, 5, 30), -- Sleepshroom
    (652, 2, 3, 0, 17396, 12, 24, 30), -- Little Worm
    (653, 2, 3, 0, 4099, 4, 12, 20), -- Earth Crystal
    (654, 2, 3, 0, 638, 4, 8, 30), -- Sage
    (655, 2, 3, 0, 772, 1, 2, 20), -- Green Rock
    (656, 2, 4, 0, 4100, 4, 12, 40), -- Lightning Crystal
    (657, 2, 4, 0, 948, 4, 8, 30), -- Carnation
    (658, 2, 4, 0, 626, 4, 8, 30), -- Black Pepper
    (659, 2, 5, 0, 4101, 4, 12, 40), -- Water Crystal
    (660, 2, 5, 0, 614, 4, 8, 30), -- Mhaura Garlic
    (661, 2, 5, 0, 4565, 1, 5, 30), -- Sobbing Fungus
    (662, 2, 6, 0, 4096, 4, 12, 40), -- Fire Crystal
    (663, 2, 6, 0, 623, 4, 8, 30), -- Bay Leaves
    (664, 2, 6, 0, 1590, 1, 5, 30), -- Holy Basil
    (665, 2, 7, 0, 4103, 4, 12, 40), -- Dark Crystal
    (666, 2, 7, 0, 614, 6, 12, 30), -- Mhaura Garlic
    (667, 2, 7, 0, 2112, 1, 5, 30), -- Vanilla
    (668, 2, 8, 0, 4102, 4, 12, 40), -- Light Crystal
    (669, 2, 8, 0, 957, 4, 8, 30), -- Amaryllis
    (670, 2, 8, 0, 4566, 1, 2, 30), -- Deathball
    (671, 3, 0, 0, 936, 12, 24, 30), -- Rock Salt
    (672, 3, 0, 0, 958, 1, 5, 30), -- Marguerite
    (673, 3, 0, 0, 769, 1, 2, 20), -- Red Rock
    (674, 3, 0, 0, 4448, 1, 2, 20), -- Puffball
    (675, 3, 1, 0, 17396, 12, 24, 30), -- Little Worm
    (676, 3, 1, 0, 4097, 4, 12, 20), -- Ice Crystal
    (677, 3, 1, 0, 620, 8, 16, 30), -- Tarutaru Rice
    (678, 3, 1, 0, 769, 1, 2, 20), -- Red Rock
    (679, 3, 2, 0, 4098, 4, 12, 60), -- Wind Crystal
    (680, 3, 2, 0, 632, 12, 24, 40), -- Kukuru Bean
    (681, 3, 3, 0, 4099, 4, 12, 60), -- Earth Crystal
    (682, 3, 3, 0, 629, 12, 24, 40), -- Millioncorn
    (683, 3, 4, 0, 4100, 4, 12, 60), -- Lightning Crystal
    (684, 3, 4, 0, 620, 4, 8, 40), -- Tarutaru Rice
    (685, 3, 5, 0, 4101, 4, 12, 40), -- Water Crystal
    (686, 3, 5, 0, 958, 1, 5, 30), -- Marguerite
    (687, 3, 5, 0, 4450, 1, 5, 30), -- Coral Fungus
    (688, 3, 6, 0, 936, 12, 24, 30), -- Rock Salt
    (689, 3, 6, 0, 4096, 4, 12, 40), -- Fire Crystal
    (690, 3, 6, 0, 618, 12, 24, 30), -- Blue Peas
    (691, 3, 7, 0, 4103, 4, 12, 60), -- Dark Crystal
    (692, 3, 7, 0, 4505, 12, 24, 40), -- Sunflower Seeds
    (693, 3, 8, 0, 4102, 4, 12, 40), -- Light Crystal
    (694, 3, 8, 0, 620, 8, 16, 30), -- Tarutaru Rice
    (695, 3, 8, 0, 4450, 1, 5, 30), -- Coral Fungus
    (696, 4, 0, 0, 936, 12, 24, 30), -- Rock Salt
    (697, 4, 0, 0, 949, 6, 12, 30), -- Rain Lily
    (698, 4, 0, 0, 771, 1, 2, 20), -- Yellow Rock
    (699, 4, 0, 0, 4373, 1, 2, 20), -- Woozyshroom
    (700, 4, 1, 0, 4097, 4, 12, 40), -- Ice Crystal
    (701, 4, 1, 0, 619, 8, 16, 30), -- Popoto
    (702, 4, 1, 0, 5651, 1, 5, 30), -- Burdock
    (703, 4, 2, 0, 4098, 4, 12, 60), -- Wind Crystal
    (704, 4, 2, 0, 834, 1, 5, 40), -- Saruta Cotton
    (705, 4, 3, 0, 936, 12, 24, 40), -- Rock Salt
    (706, 4, 3, 0, 4099, 4, 12, 30), -- Earth Crystal
    (707, 4, 3, 0, 4545, 6, 12, 30), -- Bunch Of Gysahl Greens
    (708, 4, 4, 0, 17396, 12, 24, 30), -- Little Worm
    (709, 4, 4, 0, 4100, 4, 12, 30), -- Lightning Crystal
    (710, 4, 4, 0, 4382, 8, 16, 20), -- Frost Turnip
    (711, 4, 4, 0, 771, 1, 2, 20), -- Yellow Rock
    (712, 4, 5, 0, 4101, 4, 12, 60), -- Water Crystal
    (713, 4, 5, 0, 4387, 1, 5, 40), -- Wild Onion
    (714, 4, 6, 0, 4096, 4, 12, 40), -- Fire Crystal
    (715, 4, 6, 0, 4366, 8, 16, 30), -- La Theine Cabbage
    (716, 4, 6, 0, 5907, 1, 2, 30), -- Winterflower
    (717, 4, 7, 0, 4103, 4, 12, 60), -- Dark Crystal
    (718, 4, 7, 0, 617, 1, 5, 40), -- Ginger
    (719, 4, 8, 0, 4102, 4, 12, 40), -- Light Crystal
    (720, 4, 8, 0, 4373, 1, 2, 30), -- Woozyshroom
    (721, 4, 8, 0, 4447, 1, 2, 30), -- Scream Fungus
    (722, 5, 0, 0, 936, 24, 48, 84), -- Rock Salt
    (723, 5, 0, 0, 646, 1, 2, 16), -- Adaman Ore
    (724, 5, 0, 1, 936, 24, 48, 42), -- Rock Salt
    (725, 5, 0, 1, 17396, 24, 48, 15), -- Little Worm
    (726, 5, 0, 1, 646, 1, 2, 8), -- Adaman Ore
    (727, 5, 0, 1, 4097, 12, 24, 15), -- Ice Crystal
    (728, 5, 0, 1, 640, 8, 16, 10), -- Copper Ore
    (729, 5, 0, 1, 769, 1, 5, 10), -- Red Rock
    (730, 5, 0, 2, 936, 24, 48, 42), -- Rock Salt
    (731, 5, 0, 2, 17396, 24, 48, 15), -- Little Worm
    (732, 5, 0, 2, 646, 1, 2, 8), -- Adaman Ore
    (733, 5, 0, 2, 4098, 12, 24, 15), -- Wind Crystal
    (734, 5, 0, 2, 737, 1, 5, 10), -- Gold Ore
    (735, 5, 0, 2, 773, 1, 5, 10), -- Translucent Rock
    (736, 5, 0, 3, 936, 24, 48, 57), -- Rock Salt
    (737, 5, 0, 3, 646, 1, 2, 8), -- Adaman Ore
    (738, 5, 0, 3, 4099, 12, 24, 15), -- Earth Crystal
    (739, 5, 0, 3, 641, 8, 16, 10), -- Tin Ore
    (740, 5, 0, 3, 772, 1, 5, 10), -- Green Rock
    (741, 5, 0, 4, 936, 24, 48, 57), -- Rock Salt
    (742, 5, 0, 4, 646, 1, 2, 8), -- Adaman Ore
    (743, 5, 0, 4, 4100, 12, 24, 15), -- Lightning Crystal
    (744, 5, 0, 4, 643, 4, 12, 10), -- Iron Ore
    (745, 5, 0, 4, 771, 1, 5, 10), -- Yellow Rock
    (746, 5, 0, 5, 936, 24, 48, 57), -- Rock Salt
    (747, 5, 0, 5, 646, 1, 2, 8), -- Adaman Ore
    (748, 5, 0, 5, 4101, 12, 24, 15), -- Water Crystal
    (749, 5, 0, 5, 736, 1, 5, 10), -- Silver Ore
    (750, 5, 0, 5, 774, 1, 5, 10), -- Purple Rock
    (751, 5, 0, 6, 936, 24, 48, 57), -- Rock Salt
    (752, 5, 0, 6, 646, 1, 2, 8), -- Adaman Ore
    (753, 5, 0, 6, 768, 12, 24, 15), -- Flint Stone
    (754, 5, 0, 6, 4096, 12, 24, 10), -- Fire Crystal
    (755, 5, 0, 6, 770, 1, 5, 10), -- Blue Rock
    (756, 5, 0, 7, 936, 24, 48, 57), -- Rock Salt
    (757, 5, 0, 7, 646, 1, 2, 8), -- Adaman Ore
    (758, 5, 0, 7, 4103, 12, 24, 15), -- Dark Crystal
    (759, 5, 0, 7, 642, 4, 12, 10), -- Zinc Ore
    (760, 5, 0, 7, 776, 1, 5, 10), -- White Rock
    (761, 5, 0, 8, 936, 24, 48, 52), -- Rock Salt
    (762, 5, 0, 8, 646, 1, 2, 8), -- Adaman Ore
    (763, 5, 0, 8, 4102, 12, 24, 10), -- Light Crystal
    (764, 5, 0, 8, 845, 4, 8, 10), -- Black Chocobo Feather
    (765, 5, 0, 8, 775, 1, 5, 10), -- Black Rock
    (766, 5, 0, 8, 645, 1, 2, 10), -- Darksteel Ore
    (767, 5, 1, 0, 936, 24, 48, 42), -- Rock Salt
    (768, 5, 1, 0, 17396, 24, 48, 15), -- Little Worm
    (769, 5, 1, 0, 646, 1, 2, 8), -- Adaman Ore
    (770, 5, 1, 0, 4097, 12, 24, 15), -- Ice Crystal
    (771, 5, 1, 0, 640, 8, 16, 10), -- Copper Ore
    (772, 5, 1, 0, 769, 1, 5, 10), -- Red Rock
    (773, 5, 1, 1, 17396, 24, 48, 30), -- Little Worm
    (774, 5, 1, 1, 4097, 12, 24, 30), -- Ice Crystal
    (775, 5, 1, 1, 640, 8, 16, 20), -- Copper Ore
    (776, 5, 1, 1, 769, 1, 5, 20), -- Red Rock
    (777, 5, 1, 2, 17396, 24, 48, 30), -- Little Worm
    (778, 5, 1, 2, 4097, 12, 24, 15), -- Ice Crystal
    (779, 5, 1, 2, 4098, 12, 24, 15), -- Wind Crystal
    (780, 5, 1, 2, 640, 8, 16, 10), -- Copper Ore
    (781, 5, 1, 2, 737, 1, 5, 10), -- Gold Ore
    (782, 5, 1, 2, 769, 1, 5, 10), -- Red Rock
    (783, 5, 1, 2, 773, 1, 5, 10), -- Translucent Rock
    (784, 5, 1, 3, 17396, 24, 48, 15), -- Little Worm
    (785, 5, 1, 3, 936, 24, 48, 15), -- Rock Salt
    (786, 5, 1, 3, 4097, 12, 24, 15), -- Ice Crystal
    (787, 5, 1, 3, 4099, 12, 24, 15), -- Earth Crystal
    (788, 5, 1, 3, 640, 8, 16, 10), -- Copper Ore
    (789, 5, 1, 3, 641, 8, 16, 10), -- Tin Ore
    (790, 5, 1, 3, 769, 1, 5, 10), -- Red Rock
    (791, 5, 1, 3, 772, 1, 5, 10), -- Green Rock
    (792, 5, 1, 4, 17396, 24, 48, 15), -- Little Worm
    (793, 5, 1, 4, 936, 24, 48, 15), -- Rock Salt
    (794, 5, 1, 4, 4097, 12, 24, 15), -- Ice Crystal
    (795, 5, 1, 4, 4100, 12, 24, 15), -- Lightning Crystal
    (796, 5, 1, 4, 640, 8, 16, 10), -- Copper Ore
    (797, 5, 1, 4, 643, 4, 12, 10), -- Iron Ore
    (798, 5, 1, 4, 769, 1, 5, 10), -- Red Rock
    (799, 5, 1, 4, 771, 1, 5, 10), -- Yellow Rock
    (800, 5, 1, 5, 17396, 24, 48, 15), -- Little Worm
    (801, 5, 1, 5, 936, 24, 48, 15), -- Rock Salt
    (802, 5, 1, 5, 4097, 12, 24, 15), -- Ice Crystal
    (803, 5, 1, 5, 4101, 12, 24, 15), -- Water Crystal
    (804, 5, 1, 5, 640, 8, 16, 10), -- Copper Ore
    (805, 5, 1, 5, 736, 1, 5, 10), -- Silver Ore
    (806, 5, 1, 5, 769, 1, 5, 10), -- Red Rock
    (807, 5, 1, 5, 774, 1, 5, 10), -- Purple Rock
    (808, 5, 1, 6, 17396, 24, 48, 15), -- Little Worm
    (809, 5, 1, 6, 936, 24, 48, 15), -- Rock Salt
    (810, 5, 1, 6, 4097, 12, 24, 15), -- Ice Crystal
    (811, 5, 1, 6, 768, 12, 24, 15), -- Flint Stone
    (812, 5, 1, 6, 640, 8, 16, 10), -- Copper Ore
    (813, 5, 1, 6, 4096, 12, 24, 10), -- Fire Crystal
    (814, 5, 1, 6, 769, 1, 5, 10), -- Red Rock
    (815, 5, 1, 6, 770, 1, 5, 10), -- Blue Rock
    (816, 5, 1, 7, 17396, 24, 48, 15), -- Little Worm
    (817, 5, 1, 7, 936, 24, 48, 15), -- Rock Salt
    (818, 5, 1, 7, 4097, 12, 24, 15), -- Ice Crystal
    (819, 5, 1, 7, 4103, 12, 24, 15), -- Dark Crystal
    (820, 5, 1, 7, 640, 8, 16, 10), -- Copper Ore
    (821, 5, 1, 7, 642, 4, 12, 10), -- Zinc Ore
    (822, 5, 1, 7, 769, 1, 5, 10), -- Red Rock
    (823, 5, 1, 7, 776, 1, 5, 10), -- White Rock
    (824, 5, 1, 8, 17396, 24, 48, 15), -- Little Worm
    (825, 5, 1, 8, 936, 24, 48, 10), -- Rock Salt
    (826, 5, 1, 8, 4097, 12, 24, 15), -- Ice Crystal
    (827, 5, 1, 8, 4102, 12, 24, 10), -- Light Crystal
    (828, 5, 1, 8, 640, 8, 16, 10), -- Copper Ore
    (829, 5, 1, 8, 845, 4, 8, 10), -- Black Chocobo Feather
    (830, 5, 1, 8, 769, 1, 5, 10), -- Red Rock
    (831, 5, 1, 8, 775, 1, 5, 10), -- Black Rock
    (832, 5, 1, 8, 645, 1, 2, 10), -- Darksteel Ore
    (833, 5, 2, 0, 936, 24, 48, 42), -- Rock Salt
    (834, 5, 2, 0, 17396, 24, 48, 15), -- Little Worm
    (835, 5, 2, 0, 646, 1, 2, 8), -- Adaman Ore
    (836, 5, 2, 0, 4098, 12, 24, 15), -- Wind Crystal
    (837, 5, 2, 0, 737, 1, 5, 10), -- Gold Ore
    (838, 5, 2, 0, 773, 1, 5, 10), -- Translucent Rock
    (839, 5, 2, 1, 17396, 24, 48, 30), -- Little Worm
    (840, 5, 2, 1, 4097, 12, 24, 15), -- Ice Crystal
    (841, 5, 2, 1, 4098, 12, 24, 15), -- Wind Crystal
    (842, 5, 2, 1, 640, 8, 16, 10), -- Copper Ore
    (843, 5, 2, 1, 737, 1, 5, 10), -- Gold Ore
    (844, 5, 2, 1, 769, 1, 5, 10), -- Red Rock
    (845, 5, 2, 1, 773, 1, 5, 10), -- Translucent Rock
    (846, 5, 2, 2, 17396, 24, 48, 30), -- Little Worm
    (847, 5, 2, 2, 4098, 12, 24, 30), -- Wind Crystal
    (848, 5, 2, 2, 737, 1, 5, 20), -- Gold Ore
    (849, 5, 2, 2, 773, 1, 5, 20), -- Translucent Rock
    (850, 5, 2, 3, 17396, 24, 48, 15), -- Little Worm
    (851, 5, 2, 3, 936, 24, 48, 15), -- Rock Salt
    (852, 5, 2, 3, 4098, 12, 24, 15), -- Wind Crystal
    (853, 5, 2, 3, 4099, 12, 24, 15), -- Earth Crystal
    (854, 5, 2, 3, 737, 1, 5, 10), -- Gold Ore
    (855, 5, 2, 3, 641, 8, 16, 10), -- Tin Ore
    (856, 5, 2, 3, 773, 1, 5, 10), -- Translucent Rock
    (857, 5, 2, 3, 772, 1, 5, 10), -- Green Rock
    (858, 5, 2, 4, 17396, 24, 48, 15), -- Little Worm
    (859, 5, 2, 4, 936, 24, 48, 15), -- Rock Salt
    (860, 5, 2, 4, 4098, 12, 24, 15), -- Wind Crystal
    (861, 5, 2, 4, 4100, 12, 24, 15), -- Lightning Crystal
    (862, 5, 2, 4, 737, 1, 5, 10), -- Gold Ore
    (863, 5, 2, 4, 643, 4, 12, 10), -- Iron Ore
    (864, 5, 2, 4, 773, 1, 5, 10), -- Translucent Rock
    (865, 5, 2, 4, 771, 1, 5, 10), -- Yellow Rock
    (866, 5, 2, 5, 17396, 24, 48, 15), -- Little Worm
    (867, 5, 2, 5, 936, 24, 48, 15), -- Rock Salt
    (868, 5, 2, 5, 4098, 12, 24, 15), -- Wind Crystal
    (869, 5, 2, 5, 4101, 12, 24, 15), -- Water Crystal
    (870, 5, 2, 5, 737, 1, 5, 10), -- Gold Ore
    (871, 5, 2, 5, 736, 1, 5, 10), -- Silver Ore
    (872, 5, 2, 5, 773, 1, 5, 10), -- Translucent Rock
    (873, 5, 2, 5, 774, 1, 5, 10), -- Purple Rock
    (874, 5, 2, 6, 17396, 24, 48, 15), -- Little Worm
    (875, 5, 2, 6, 936, 24, 48, 15), -- Rock Salt
    (876, 5, 2, 6, 4098, 12, 24, 15), -- Wind Crystal
    (877, 5, 2, 6, 768, 12, 24, 15), -- Flint Stone
    (878, 5, 2, 6, 737, 1, 5, 10), -- Gold Ore
    (879, 5, 2, 6, 4096, 12, 24, 10), -- Fire Crystal
    (880, 5, 2, 6, 773, 1, 5, 10), -- Translucent Rock
    (881, 5, 2, 6, 770, 1, 5, 10), -- Blue Rock
    (882, 5, 2, 7, 17396, 24, 48, 15), -- Little Worm
    (883, 5, 2, 7, 936, 24, 48, 15), -- Rock Salt
    (884, 5, 2, 7, 4098, 12, 24, 15), -- Wind Crystal
    (885, 5, 2, 7, 4103, 12, 24, 15), -- Dark Crystal
    (886, 5, 2, 7, 737, 1, 5, 10), -- Gold Ore
    (887, 5, 2, 7, 642, 4, 12, 10), -- Zinc Ore
    (888, 5, 2, 7, 773, 1, 5, 10), -- Translucent Rock
    (889, 5, 2, 7, 776, 1, 5, 10), -- White Rock
    (890, 5, 2, 8, 17396, 24, 48, 15), -- Little Worm
    (891, 5, 2, 8, 936, 24, 48, 10), -- Rock Salt
    (892, 5, 2, 8, 4098, 12, 24, 15), -- Wind Crystal
    (893, 5, 2, 8, 4102, 12, 24, 10), -- Light Crystal
    (894, 5, 2, 8, 737, 1, 5, 10), -- Gold Ore
    (895, 5, 2, 8, 845, 4, 8, 10), -- Black Chocobo Feather
    (896, 5, 2, 8, 773, 1, 5, 10), -- Translucent Rock
    (897, 5, 2, 8, 775, 1, 5, 10), -- Black Rock
    (898, 5, 2, 8, 645, 1, 2, 10), -- Darksteel Ore
    (899, 5, 3, 0, 936, 24, 48, 57), -- Rock Salt
    (900, 5, 3, 0, 646, 1, 2, 8), -- Adaman Ore
    (901, 5, 3, 0, 4099, 12, 24, 15), -- Earth Crystal
    (902, 5, 3, 0, 641, 8, 16, 10), -- Tin Ore
    (903, 5, 3, 0, 772, 1, 5, 10), -- Green Rock
    (904, 5, 3, 1, 17396, 24, 48, 15), -- Little Worm
    (905, 5, 3, 1, 936, 24, 48, 15), -- Rock Salt
    (906, 5, 3, 1, 4097, 12, 24, 15), -- Ice Crystal
    (907, 5, 3, 1, 4099, 12, 24, 15), -- Earth Crystal
    (908, 5, 3, 1, 640, 8, 16, 10), -- Copper Ore
    (909, 5, 3, 1, 641, 8, 16, 10), -- Tin Ore
    (910, 5, 3, 1, 769, 1, 5, 10), -- Red Rock
    (911, 5, 3, 1, 772, 1, 5, 10), -- Green Rock
    (912, 5, 3, 2, 17396, 24, 48, 15), -- Little Worm
    (913, 5, 3, 2, 936, 24, 48, 15), -- Rock Salt
    (914, 5, 3, 2, 4098, 12, 24, 15), -- Wind Crystal
    (915, 5, 3, 2, 4099, 12, 24, 15), -- Earth Crystal
    (916, 5, 3, 2, 737, 1, 5, 10), -- Gold Ore
    (917, 5, 3, 2, 641, 8, 16, 10), -- Tin Ore
    (918, 5, 3, 2, 773, 1, 5, 10), -- Translucent Rock
    (919, 5, 3, 2, 772, 1, 5, 10), -- Green Rock
    (920, 5, 3, 3, 936, 24, 48, 30), -- Rock Salt
    (921, 5, 3, 3, 4099, 12, 24, 30), -- Earth Crystal
    (922, 5, 3, 3, 641, 8, 16, 20), -- Tin Ore
    (923, 5, 3, 3, 772, 1, 5, 20), -- Green Rock
    (924, 5, 3, 4, 936, 24, 48, 30), -- Rock Salt
    (925, 5, 3, 4, 4099, 12, 24, 15), -- Earth Crystal
    (926, 5, 3, 4, 4100, 12, 24, 15), -- Lightning Crystal
    (927, 5, 3, 4, 641, 8, 16, 10), -- Tin Ore
    (928, 5, 3, 4, 643, 4, 12, 10), -- Iron Ore
    (929, 5, 3, 4, 772, 1, 5, 10), -- Green Rock
    (930, 5, 3, 4, 771, 1, 5, 10), -- Yellow Rock
    (931, 5, 3, 5, 936, 24, 48, 30), -- Rock Salt
    (932, 5, 3, 5, 4099, 12, 24, 15), -- Earth Crystal
    (933, 5, 3, 5, 4101, 12, 24, 15), -- Water Crystal
    (934, 5, 3, 5, 641, 8, 16, 10), -- Tin Ore
    (935, 5, 3, 5, 736, 1, 5, 10), -- Silver Ore
    (936, 5, 3, 5, 772, 1, 5, 10), -- Green Rock
    (937, 5, 3, 5, 774, 1, 5, 10), -- Purple Rock
    (938, 5, 3, 6, 936, 24, 48, 30), -- Rock Salt
    (939, 5, 3, 6, 4099, 12, 24, 15), -- Earth Crystal
    (940, 5, 3, 6, 768, 12, 24, 15), -- Flint Stone
    (941, 5, 3, 6, 641, 8, 16, 10), -- Tin Ore
    (942, 5, 3, 6, 4096, 12, 24, 10), -- Fire Crystal
    (943, 5, 3, 6, 772, 1, 5, 10), -- Green Rock
    (944, 5, 3, 6, 770, 1, 5, 10), -- Blue Rock
    (945, 5, 3, 7, 936, 24, 48, 30), -- Rock Salt
    (946, 5, 3, 7, 4099, 12, 24, 15), -- Earth Crystal
    (947, 5, 3, 7, 4103, 12, 24, 15), -- Dark Crystal
    (948, 5, 3, 7, 641, 8, 16, 10), -- Tin Ore
    (949, 5, 3, 7, 642, 4, 12, 10), -- Zinc Ore
    (950, 5, 3, 7, 772, 1, 5, 10), -- Green Rock
    (951, 5, 3, 7, 776, 1, 5, 10), -- White Rock
    (952, 5, 3, 8, 936, 24, 48, 25), -- Rock Salt
    (953, 5, 3, 8, 4099, 12, 24, 15), -- Earth Crystal
    (954, 5, 3, 8, 4102, 12, 24, 10), -- Light Crystal
    (955, 5, 3, 8, 641, 8, 16, 10), -- Tin Ore
    (956, 5, 3, 8, 845, 4, 8, 10), -- Black Chocobo Feather
    (957, 5, 3, 8, 772, 1, 5, 10), -- Green Rock
    (958, 5, 3, 8, 775, 1, 5, 10), -- Black Rock
    (959, 5, 3, 8, 645, 1, 2, 10), -- Darksteel Ore
    (960, 5, 4, 0, 936, 24, 48, 57), -- Rock Salt
    (961, 5, 4, 0, 646, 1, 2, 8), -- Adaman Ore
    (962, 5, 4, 0, 4100, 12, 24, 15), -- Lightning Crystal
    (963, 5, 4, 0, 643, 4, 12, 10), -- Iron Ore
    (964, 5, 4, 0, 771, 1, 5, 10), -- Yellow Rock
    (965, 5, 4, 1, 17396, 24, 48, 15), -- Little Worm
    (966, 5, 4, 1, 936, 24, 48, 15), -- Rock Salt
    (967, 5, 4, 1, 4097, 12, 24, 15), -- Ice Crystal
    (968, 5, 4, 1, 4100, 12, 24, 15), -- Lightning Crystal
    (969, 5, 4, 1, 640, 8, 16, 10), -- Copper Ore
    (970, 5, 4, 1, 643, 4, 12, 10), -- Iron Ore
    (971, 5, 4, 1, 769, 1, 5, 10), -- Red Rock
    (972, 5, 4, 1, 771, 1, 5, 10), -- Yellow Rock
    (973, 5, 4, 2, 17396, 24, 48, 15), -- Little Worm
    (974, 5, 4, 2, 936, 24, 48, 15), -- Rock Salt
    (975, 5, 4, 2, 4098, 12, 24, 15), -- Wind Crystal
    (976, 5, 4, 2, 4100, 12, 24, 15), -- Lightning Crystal
    (977, 5, 4, 2, 737, 1, 5, 10), -- Gold Ore
    (978, 5, 4, 2, 643, 4, 12, 10), -- Iron Ore
    (979, 5, 4, 2, 773, 1, 5, 10), -- Translucent Rock
    (980, 5, 4, 2, 771, 1, 5, 10), -- Yellow Rock
    (981, 5, 4, 3, 936, 24, 48, 30), -- Rock Salt
    (982, 5, 4, 3, 4099, 12, 24, 15), -- Earth Crystal
    (983, 5, 4, 3, 4100, 12, 24, 15), -- Lightning Crystal
    (984, 5, 4, 3, 641, 8, 16, 10), -- Tin Ore
    (985, 5, 4, 3, 643, 4, 12, 10), -- Iron Ore
    (986, 5, 4, 3, 772, 1, 5, 10), -- Green Rock
    (987, 5, 4, 3, 771, 1, 5, 10), -- Yellow Rock
    (988, 5, 4, 4, 936, 24, 48, 30), -- Rock Salt
    (989, 5, 4, 4, 4100, 12, 24, 30), -- Lightning Crystal
    (990, 5, 4, 4, 643, 4, 12, 20), -- Iron Ore
    (991, 5, 4, 4, 771, 1, 5, 20), -- Yellow Rock
    (992, 5, 4, 5, 936, 24, 48, 30), -- Rock Salt
    (993, 5, 4, 5, 4100, 12, 24, 15), -- Lightning Crystal
    (994, 5, 4, 5, 4101, 12, 24, 15), -- Water Crystal
    (995, 5, 4, 5, 643, 4, 12, 10), -- Iron Ore
    (996, 5, 4, 5, 736, 1, 5, 10), -- Silver Ore
    (997, 5, 4, 5, 771, 1, 5, 10), -- Yellow Rock
    (998, 5, 4, 5, 774, 1, 5, 10), -- Purple Rock
    (999, 5, 4, 6, 936, 24, 48, 30), -- Rock Salt
    (1000, 5, 4, 6, 4100, 12, 24, 15), -- Lightning Crystal
    (1001, 5, 4, 6, 768, 12, 24, 15), -- Flint Stone
    (1002, 5, 4, 6, 643, 4, 12, 10), -- Iron Ore
    (1003, 5, 4, 6, 4096, 12, 24, 10), -- Fire Crystal
    (1004, 5, 4, 6, 771, 1, 5, 10), -- Yellow Rock
    (1005, 5, 4, 6, 770, 1, 5, 10), -- Blue Rock
    (1006, 5, 4, 7, 936, 24, 48, 30), -- Rock Salt
    (1007, 5, 4, 7, 4100, 12, 24, 15), -- Lightning Crystal
    (1008, 5, 4, 7, 4103, 12, 24, 15), -- Dark Crystal
    (1009, 5, 4, 7, 643, 4, 12, 10), -- Iron Ore
    (1010, 5, 4, 7, 642, 4, 12, 10), -- Zinc Ore
    (1011, 5, 4, 7, 771, 1, 5, 10), -- Yellow Rock
    (1012, 5, 4, 7, 776, 1, 5, 10), -- White Rock
    (1013, 5, 4, 8, 936, 24, 48, 25), -- Rock Salt
    (1014, 5, 4, 8, 4100, 12, 24, 15), -- Lightning Crystal
    (1015, 5, 4, 8, 4102, 12, 24, 10), -- Light Crystal
    (1016, 5, 4, 8, 643, 4, 12, 10), -- Iron Ore
    (1017, 5, 4, 8, 845, 4, 8, 10), -- Black Chocobo Feather
    (1018, 5, 4, 8, 771, 1, 5, 10), -- Yellow Rock
    (1019, 5, 4, 8, 775, 1, 5, 10), -- Black Rock
    (1020, 5, 4, 8, 645, 1, 2, 10), -- Darksteel Ore
    (1021, 5, 5, 0, 936, 24, 48, 57), -- Rock Salt
    (1022, 5, 5, 0, 646, 1, 2, 8), -- Adaman Ore
    (1023, 5, 5, 0, 4101, 12, 24, 15), -- Water Crystal
    (1024, 5, 5, 0, 736, 1, 5, 10), -- Silver Ore
    (1025, 5, 5, 0, 774, 1, 5, 10), -- Purple Rock
    (1026, 5, 5, 1, 17396, 24, 48, 15), -- Little Worm
    (1027, 5, 5, 1, 936, 24, 48, 15), -- Rock Salt
    (1028, 5, 5, 1, 4097, 12, 24, 15), -- Ice Crystal
    (1029, 5, 5, 1, 4101, 12, 24, 15), -- Water Crystal
    (1030, 5, 5, 1, 640, 8, 16, 10), -- Copper Ore
    (1031, 5, 5, 1, 736, 1, 5, 10), -- Silver Ore
    (1032, 5, 5, 1, 769, 1, 5, 10), -- Red Rock
    (1033, 5, 5, 1, 774, 1, 5, 10), -- Purple Rock
    (1034, 5, 5, 2, 17396, 24, 48, 15), -- Little Worm
    (1035, 5, 5, 2, 936, 24, 48, 15), -- Rock Salt
    (1036, 5, 5, 2, 4098, 12, 24, 15), -- Wind Crystal
    (1037, 5, 5, 2, 4101, 12, 24, 15), -- Water Crystal
    (1038, 5, 5, 2, 737, 1, 5, 10), -- Gold Ore
    (1039, 5, 5, 2, 736, 1, 5, 10), -- Silver Ore
    (1040, 5, 5, 2, 773, 1, 5, 10), -- Translucent Rock
    (1041, 5, 5, 2, 774, 1, 5, 10), -- Purple Rock
    (1042, 5, 5, 3, 936, 24, 48, 30), -- Rock Salt
    (1043, 5, 5, 3, 4099, 12, 24, 15), -- Earth Crystal
    (1044, 5, 5, 3, 4101, 12, 24, 15), -- Water Crystal
    (1045, 5, 5, 3, 641, 8, 16, 10), -- Tin Ore
    (1046, 5, 5, 3, 736, 1, 5, 10), -- Silver Ore
    (1047, 5, 5, 3, 772, 1, 5, 10), -- Green Rock
    (1048, 5, 5, 3, 774, 1, 5, 10), -- Purple Rock
    (1049, 5, 5, 4, 936, 24, 48, 30), -- Rock Salt
    (1050, 5, 5, 4, 4100, 12, 24, 15), -- Lightning Crystal
    (1051, 5, 5, 4, 4101, 12, 24, 15), -- Water Crystal
    (1052, 5, 5, 4, 643, 4, 12, 10), -- Iron Ore
    (1053, 5, 5, 4, 736, 1, 5, 10), -- Silver Ore
    (1054, 5, 5, 4, 771, 1, 5, 10), -- Yellow Rock
    (1055, 5, 5, 4, 774, 1, 5, 10), -- Purple Rock
    (1056, 5, 5, 5, 936, 24, 48, 30), -- Rock Salt
    (1057, 5, 5, 5, 4101, 12, 24, 30), -- Water Crystal
    (1058, 5, 5, 5, 736, 1, 5, 20), -- Silver Ore
    (1059, 5, 5, 5, 774, 1, 5, 20), -- Purple Rock
    (1060, 5, 5, 6, 936, 24, 48, 30), -- Rock Salt
    (1061, 5, 5, 6, 4101, 12, 24, 15), -- Water Crystal
    (1062, 5, 5, 6, 768, 12, 24, 15), -- Flint Stone
    (1063, 5, 5, 6, 736, 1, 5, 10), -- Silver Ore
    (1064, 5, 5, 6, 4096, 12, 24, 10), -- Fire Crystal
    (1065, 5, 5, 6, 774, 1, 5, 10), -- Purple Rock
    (1066, 5, 5, 6, 770, 1, 5, 10), -- Blue Rock
    (1067, 5, 5, 7, 936, 24, 48, 30), -- Rock Salt
    (1068, 5, 5, 7, 4101, 12, 24, 15), -- Water Crystal
    (1069, 5, 5, 7, 4103, 12, 24, 15), -- Dark Crystal
    (1070, 5, 5, 7, 736, 1, 5, 10), -- Silver Ore
    (1071, 5, 5, 7, 642, 4, 12, 10), -- Zinc Ore
    (1072, 5, 5, 7, 774, 1, 5, 10), -- Purple Rock
    (1073, 5, 5, 7, 776, 1, 5, 10), -- White Rock
    (1074, 5, 5, 8, 936, 24, 48, 25), -- Rock Salt
    (1075, 5, 5, 8, 4101, 12, 24, 15), -- Water Crystal
    (1076, 5, 5, 8, 4102, 12, 24, 10), -- Light Crystal
    (1077, 5, 5, 8, 736, 1, 5, 10), -- Silver Ore
    (1078, 5, 5, 8, 845, 4, 8, 10), -- Black Chocobo Feather
    (1079, 5, 5, 8, 774, 1, 5, 10), -- Purple Rock
    (1080, 5, 5, 8, 775, 1, 5, 10), -- Black Rock
    (1081, 5, 5, 8, 645, 1, 2, 10), -- Darksteel Ore
    (1082, 5, 6, 0, 936, 24, 48, 57), -- Rock Salt
    (1083, 5, 6, 0, 646, 1, 2, 8), -- Adaman Ore
    (1084, 5, 6, 0, 768, 12, 24, 15), -- Flint Stone
    (1085, 5, 6, 0, 4096, 12, 24, 10), -- Fire Crystal
    (1086, 5, 6, 0, 770, 1, 5, 10), -- Blue Rock
    (1087, 5, 6, 1, 17396, 24, 48, 15), -- Little Worm
    (1088, 5, 6, 1, 936, 24, 48, 15), -- Rock Salt
    (1089, 5, 6, 1, 4097, 12, 24, 15), -- Ice Crystal
    (1090, 5, 6, 1, 768, 12, 24, 15), -- Flint Stone
    (1091, 5, 6, 1, 640, 8, 16, 10), -- Copper Ore
    (1092, 5, 6, 1, 4096, 12, 24, 10), -- Fire Crystal
    (1093, 5, 6, 1, 769, 1, 5, 10), -- Red Rock
    (1094, 5, 6, 1, 770, 1, 5, 10), -- Blue Rock
    (1095, 5, 6, 2, 17396, 24, 48, 15), -- Little Worm
    (1096, 5, 6, 2, 936, 24, 48, 15), -- Rock Salt
    (1097, 5, 6, 2, 4098, 12, 24, 15), -- Wind Crystal
    (1098, 5, 6, 2, 768, 12, 24, 15), -- Flint Stone
    (1099, 5, 6, 2, 737, 1, 5, 10), -- Gold Ore
    (1100, 5, 6, 2, 4096, 12, 24, 10), -- Fire Crystal
    (1101, 5, 6, 2, 773, 1, 5, 10), -- Translucent Rock
    (1102, 5, 6, 2, 770, 1, 5, 10), -- Blue Rock
    (1103, 5, 6, 3, 936, 24, 48, 30), -- Rock Salt
    (1104, 5, 6, 3, 4099, 12, 24, 15), -- Earth Crystal
    (1105, 5, 6, 3, 768, 12, 24, 15), -- Flint Stone
    (1106, 5, 6, 3, 641, 8, 16, 10), -- Tin Ore
    (1107, 5, 6, 3, 4096, 12, 24, 10), -- Fire Crystal
    (1108, 5, 6, 3, 772, 1, 5, 10), -- Green Rock
    (1109, 5, 6, 3, 770, 1, 5, 10), -- Blue Rock
    (1110, 5, 6, 4, 936, 24, 48, 30), -- Rock Salt
    (1111, 5, 6, 4, 4100, 12, 24, 15), -- Lightning Crystal
    (1112, 5, 6, 4, 768, 12, 24, 15), -- Flint Stone
    (1113, 5, 6, 4, 643, 4, 12, 10), -- Iron Ore
    (1114, 5, 6, 4, 4096, 12, 24, 10), -- Fire Crystal
    (1115, 5, 6, 4, 771, 1, 5, 10), -- Yellow Rock
    (1116, 5, 6, 4, 770, 1, 5, 10), -- Blue Rock
    (1117, 5, 6, 5, 936, 24, 48, 30), -- Rock Salt
    (1118, 5, 6, 5, 4101, 12, 24, 15), -- Water Crystal
    (1119, 5, 6, 5, 768, 12, 24, 15), -- Flint Stone
    (1120, 5, 6, 5, 736, 1, 5, 10), -- Silver Ore
    (1121, 5, 6, 5, 4096, 12, 24, 10), -- Fire Crystal
    (1122, 5, 6, 5, 774, 1, 5, 10), -- Purple Rock
    (1123, 5, 6, 5, 770, 1, 5, 10), -- Blue Rock
    (1124, 5, 6, 6, 936, 24, 48, 30), -- Rock Salt
    (1125, 5, 6, 6, 768, 12, 24, 30), -- Flint Stone
    (1126, 5, 6, 6, 4096, 12, 24, 20), -- Fire Crystal
    (1127, 5, 6, 6, 770, 1, 5, 20), -- Blue Rock
    (1128, 5, 6, 7, 936, 24, 48, 30), -- Rock Salt
    (1129, 5, 6, 7, 768, 12, 24, 15), -- Flint Stone
    (1130, 5, 6, 7, 4103, 12, 24, 15), -- Dark Crystal
    (1131, 5, 6, 7, 4096, 12, 24, 10), -- Fire Crystal
    (1132, 5, 6, 7, 642, 4, 12, 10), -- Zinc Ore
    (1133, 5, 6, 7, 770, 1, 5, 10), -- Blue Rock
    (1134, 5, 6, 7, 776, 1, 5, 10), -- White Rock
    (1135, 5, 6, 8, 936, 24, 48, 25), -- Rock Salt
    (1136, 5, 6, 8, 768, 12, 24, 15), -- Flint Stone
    (1137, 5, 6, 8, 4102, 12, 24, 10), -- Light Crystal
    (1138, 5, 6, 8, 4096, 12, 24, 10), -- Fire Crystal
    (1139, 5, 6, 8, 845, 4, 8, 10), -- Black Chocobo Feather
    (1140, 5, 6, 8, 770, 1, 5, 10), -- Blue Rock
    (1141, 5, 6, 8, 775, 1, 5, 10), -- Black Rock
    (1142, 5, 6, 8, 645, 1, 2, 10), -- Darksteel Ore
    (1143, 5, 7, 0, 936, 24, 48, 57), -- Rock Salt
    (1144, 5, 7, 0, 646, 1, 2, 8), -- Adaman Ore
    (1145, 5, 7, 0, 4103, 12, 24, 15), -- Dark Crystal
    (1146, 5, 7, 0, 642, 4, 12, 10), -- Zinc Ore
    (1147, 5, 7, 0, 776, 1, 5, 10), -- White Rock
    (1148, 5, 7, 1, 17396, 24, 48, 15), -- Little Worm
    (1149, 5, 7, 1, 936, 24, 48, 15), -- Rock Salt
    (1150, 5, 7, 1, 4097, 12, 24, 15), -- Ice Crystal
    (1151, 5, 7, 1, 4103, 12, 24, 15), -- Dark Crystal
    (1152, 5, 7, 1, 640, 8, 16, 10), -- Copper Ore
    (1153, 5, 7, 1, 642, 4, 12, 10), -- Zinc Ore
    (1154, 5, 7, 1, 769, 1, 5, 10), -- Red Rock
    (1155, 5, 7, 1, 776, 1, 5, 10), -- White Rock
    (1156, 5, 7, 2, 17396, 24, 48, 15), -- Little Worm
    (1157, 5, 7, 2, 936, 24, 48, 15), -- Rock Salt
    (1158, 5, 7, 2, 4098, 12, 24, 15), -- Wind Crystal
    (1159, 5, 7, 2, 4103, 12, 24, 15), -- Dark Crystal
    (1160, 5, 7, 2, 737, 1, 5, 10), -- Gold Ore
    (1161, 5, 7, 2, 642, 4, 12, 10), -- Zinc Ore
    (1162, 5, 7, 2, 773, 1, 5, 10), -- Translucent Rock
    (1163, 5, 7, 2, 776, 1, 5, 10), -- White Rock
    (1164, 5, 7, 3, 936, 24, 48, 30), -- Rock Salt
    (1165, 5, 7, 3, 4099, 12, 24, 15), -- Earth Crystal
    (1166, 5, 7, 3, 4103, 12, 24, 15), -- Dark Crystal
    (1167, 5, 7, 3, 641, 8, 16, 10), -- Tin Ore
    (1168, 5, 7, 3, 642, 4, 12, 10), -- Zinc Ore
    (1169, 5, 7, 3, 772, 1, 5, 10), -- Green Rock
    (1170, 5, 7, 3, 776, 1, 5, 10), -- White Rock
    (1171, 5, 7, 4, 936, 24, 48, 30), -- Rock Salt
    (1172, 5, 7, 4, 4100, 12, 24, 15), -- Lightning Crystal
    (1173, 5, 7, 4, 4103, 12, 24, 15), -- Dark Crystal
    (1174, 5, 7, 4, 643, 4, 12, 10), -- Iron Ore
    (1175, 5, 7, 4, 642, 4, 12, 10), -- Zinc Ore
    (1176, 5, 7, 4, 771, 1, 5, 10), -- Yellow Rock
    (1177, 5, 7, 4, 776, 1, 5, 10), -- White Rock
    (1178, 5, 7, 5, 936, 24, 48, 30), -- Rock Salt
    (1179, 5, 7, 5, 4101, 12, 24, 15), -- Water Crystal
    (1180, 5, 7, 5, 4103, 12, 24, 15), -- Dark Crystal
    (1181, 5, 7, 5, 736, 1, 5, 10), -- Silver Ore
    (1182, 5, 7, 5, 642, 4, 12, 10), -- Zinc Ore
    (1183, 5, 7, 5, 774, 1, 5, 10), -- Purple Rock
    (1184, 5, 7, 5, 776, 1, 5, 10), -- White Rock
    (1185, 5, 7, 6, 936, 24, 48, 30), -- Rock Salt
    (1186, 5, 7, 6, 768, 12, 24, 15), -- Flint Stone
    (1187, 5, 7, 6, 4103, 12, 24, 15), -- Dark Crystal
    (1188, 5, 7, 6, 4096, 12, 24, 10), -- Fire Crystal
    (1189, 5, 7, 6, 642, 4, 12, 10), -- Zinc Ore
    (1190, 5, 7, 6, 770, 1, 5, 10), -- Blue Rock
    (1191, 5, 7, 6, 776, 1, 5, 10), -- White Rock
    (1192, 5, 7, 7, 936, 24, 48, 30), -- Rock Salt
    (1193, 5, 7, 7, 4103, 12, 24, 30), -- Dark Crystal
    (1194, 5, 7, 7, 642, 4, 12, 20), -- Zinc Ore
    (1195, 5, 7, 7, 776, 1, 5, 20), -- White Rock
    (1196, 5, 7, 8, 936, 24, 48, 25), -- Rock Salt
    (1197, 5, 7, 8, 4103, 12, 24, 15), -- Dark Crystal
    (1198, 5, 7, 8, 4102, 12, 24, 10), -- Light Crystal
    (1199, 5, 7, 8, 642, 4, 12, 10), -- Zinc Ore
    (1200, 5, 7, 8, 845, 4, 8, 10), -- Black Chocobo Feather
    (1201, 5, 7, 8, 776, 1, 5, 10), -- White Rock
    (1202, 5, 7, 8, 775, 1, 5, 10), -- Black Rock
    (1203, 5, 7, 8, 645, 1, 2, 10), -- Darksteel Ore
    (1204, 5, 8, 0, 936, 24, 48, 52), -- Rock Salt
    (1205, 5, 8, 0, 646, 1, 2, 8), -- Adaman Ore
    (1206, 5, 8, 0, 4102, 12, 24, 10), -- Light Crystal
    (1207, 5, 8, 0, 845, 4, 8, 10), -- Black Chocobo Feather
    (1208, 5, 8, 0, 775, 1, 5, 10), -- Black Rock
    (1209, 5, 8, 0, 645, 1, 2, 10), -- Darksteel Ore
    (1210, 5, 8, 1, 17396, 24, 48, 15), -- Little Worm
    (1211, 5, 8, 1, 936, 24, 48, 10), -- Rock Salt
    (1212, 5, 8, 1, 4097, 12, 24, 15), -- Ice Crystal
    (1213, 5, 8, 1, 4102, 12, 24, 10), -- Light Crystal
    (1214, 5, 8, 1, 640, 8, 16, 10), -- Copper Ore
    (1215, 5, 8, 1, 845, 4, 8, 10), -- Black Chocobo Feather
    (1216, 5, 8, 1, 769, 1, 5, 10), -- Red Rock
    (1217, 5, 8, 1, 775, 1, 5, 10), -- Black Rock
    (1218, 5, 8, 1, 645, 1, 2, 10), -- Darksteel Ore
    (1219, 5, 8, 2, 17396, 24, 48, 15), -- Little Worm
    (1220, 5, 8, 2, 936, 24, 48, 10), -- Rock Salt
    (1221, 5, 8, 2, 4098, 12, 24, 15), -- Wind Crystal
    (1222, 5, 8, 2, 4102, 12, 24, 10), -- Light Crystal
    (1223, 5, 8, 2, 737, 1, 5, 10), -- Gold Ore
    (1224, 5, 8, 2, 845, 4, 8, 10), -- Black Chocobo Feather
    (1225, 5, 8, 2, 773, 1, 5, 10), -- Translucent Rock
    (1226, 5, 8, 2, 775, 1, 5, 10), -- Black Rock
    (1227, 5, 8, 2, 645, 1, 2, 10), -- Darksteel Ore
    (1228, 5, 8, 3, 936, 24, 48, 25), -- Rock Salt
    (1229, 5, 8, 3, 4099, 12, 24, 15), -- Earth Crystal
    (1230, 5, 8, 3, 4102, 12, 24, 10), -- Light Crystal
    (1231, 5, 8, 3, 641, 8, 16, 10), -- Tin Ore
    (1232, 5, 8, 3, 845, 4, 8, 10), -- Black Chocobo Feather
    (1233, 5, 8, 3, 772, 1, 5, 10), -- Green Rock
    (1234, 5, 8, 3, 775, 1, 5, 10), -- Black Rock
    (1235, 5, 8, 3, 645, 1, 2, 10), -- Darksteel Ore
    (1236, 5, 8, 4, 936, 24, 48, 25), -- Rock Salt
    (1237, 5, 8, 4, 4100, 12, 24, 15), -- Lightning Crystal
    (1238, 5, 8, 4, 4102, 12, 24, 10), -- Light Crystal
    (1239, 5, 8, 4, 643, 4, 12, 10), -- Iron Ore
    (1240, 5, 8, 4, 845, 4, 8, 10), -- Black Chocobo Feather
    (1241, 5, 8, 4, 771, 1, 5, 10), -- Yellow Rock
    (1242, 5, 8, 4, 775, 1, 5, 10), -- Black Rock
    (1243, 5, 8, 4, 645, 1, 2, 10), -- Darksteel Ore
    (1244, 5, 8, 5, 936, 24, 48, 25), -- Rock Salt
    (1245, 5, 8, 5, 4101, 12, 24, 15), -- Water Crystal
    (1246, 5, 8, 5, 4102, 12, 24, 10), -- Light Crystal
    (1247, 5, 8, 5, 736, 1, 5, 10), -- Silver Ore
    (1248, 5, 8, 5, 845, 4, 8, 10), -- Black Chocobo Feather
    (1249, 5, 8, 5, 774, 1, 5, 10), -- Purple Rock
    (1250, 5, 8, 5, 775, 1, 5, 10), -- Black Rock
    (1251, 5, 8, 5, 645, 1, 2, 10), -- Darksteel Ore
    (1252, 5, 8, 6, 936, 24, 48, 25), -- Rock Salt
    (1253, 5, 8, 6, 768, 12, 24, 15), -- Flint Stone
    (1254, 5, 8, 6, 4102, 12, 24, 10), -- Light Crystal
    (1255, 5, 8, 6, 4096, 12, 24, 10), -- Fire Crystal
    (1256, 5, 8, 6, 845, 4, 8, 10), -- Black Chocobo Feather
    (1257, 5, 8, 6, 770, 1, 5, 10), -- Blue Rock
    (1258, 5, 8, 6, 775, 1, 5, 10), -- Black Rock
    (1259, 5, 8, 6, 645, 1, 2, 10), -- Darksteel Ore
    (1260, 5, 8, 7, 936, 24, 48, 25), -- Rock Salt
    (1261, 5, 8, 7, 4103, 12, 24, 15), -- Dark Crystal
    (1262, 5, 8, 7, 4102, 12, 24, 10), -- Light Crystal
    (1263, 5, 8, 7, 642, 4, 12, 10), -- Zinc Ore
    (1264, 5, 8, 7, 845, 4, 8, 10), -- Black Chocobo Feather
    (1265, 5, 8, 7, 776, 1, 5, 10), -- White Rock
    (1266, 5, 8, 7, 775, 1, 5, 10), -- Black Rock
    (1267, 5, 8, 7, 645, 1, 2, 10), -- Darksteel Ore
    (1268, 5, 8, 8, 936, 24, 48, 20), -- Rock Salt
    (1269, 5, 8, 8, 4102, 12, 24, 20), -- Light Crystal
    (1270, 5, 8, 8, 845, 4, 8, 20), -- Black Chocobo Feather
    (1271, 5, 8, 8, 775, 1, 5, 20), -- Black Rock
    (1272, 5, 8, 8, 645, 1, 2, 20), -- Darksteel Ore
    (1273, 6, 0, 0, 936, 4, 8, 26), -- Rock Salt
    (1274, 6, 0, 0, 17397, 24, 48, 26), -- Shell Bug
    (1275, 6, 0, 0, 1225, 4, 8, 20), -- Gold Nugget
    (1276, 6, 0, 0, 1238, 1, 2, 28), -- Tree Saplings
    (1277, 6, 0, 1, 936, 4, 8, 23), -- Rock Salt
    (1278, 6, 0, 1, 17397, 24, 48, 13), -- Shell Bug
    (1279, 6, 0, 1, 4097, 12, 24, 10), -- Ice Crystal
    (1280, 6, 0, 1, 1225, 4, 8, 10), -- Gold Nugget
    (1281, 6, 0, 1, 1231, 12, 24, 10), -- Brass Nugget
    (1282, 6, 0, 1, 1238, 1, 2, 14), -- Tree Saplings
    (1283, 6, 0, 1, 941, 8, 16, 10), -- Red Rose
    (1284, 6, 0, 1, 751, 1, 5, 10), -- Platinum Beastcoin
    (1285, 6, 0, 2, 936, 4, 8, 13), -- Rock Salt
    (1286, 6, 0, 2, 17396, 12, 24, 15), -- Little Worm
    (1287, 6, 0, 2, 17397, 24, 48, 13), -- Shell Bug
    (1288, 6, 0, 2, 4098, 12, 24, 15), -- Wind Crystal
    (1289, 6, 0, 2, 1225, 4, 8, 10), -- Gold Nugget
    (1290, 6, 0, 2, 920, 4, 8, 10), -- Malboro Vine
    (1291, 6, 0, 2, 1238, 1, 2, 14), -- Tree Saplings
    (1292, 6, 0, 2, 1235, 4, 12, 10), -- Steel Nugget
    (1293, 6, 0, 3, 936, 4, 8, 28), -- Rock Salt
    (1294, 6, 0, 3, 17397, 24, 48, 13), -- Shell Bug
    (1295, 6, 0, 3, 4099, 12, 24, 15), -- Earth Crystal
    (1296, 6, 0, 3, 1225, 4, 8, 10), -- Gold Nugget
    (1297, 6, 0, 3, 1230, 8, 16, 10), -- Copper Nugget
    (1298, 6, 0, 3, 1238, 1, 2, 14), -- Tree Saplings
    (1299, 6, 0, 3, 748, 1, 5, 10), -- Gold Beastcoin
    (1300, 6, 0, 4, 936, 4, 8, 23), -- Rock Salt
    (1301, 6, 0, 4, 17397, 24, 48, 13), -- Shell Bug
    (1302, 6, 0, 4, 4100, 12, 24, 10), -- Lightning Crystal
    (1303, 6, 0, 4, 1225, 4, 8, 10), -- Gold Nugget
    (1304, 6, 0, 4, 841, 4, 12, 10), -- Yagudo Feather
    (1305, 6, 0, 4, 1238, 1, 2, 14), -- Tree Saplings
    (1306, 6, 0, 4, 839, 4, 8, 10), -- Crawler Cocoon
    (1307, 6, 0, 4, 1234, 4, 12, 10), -- Iron Nugget
    (1308, 6, 0, 5, 936, 4, 8, 23), -- Rock Salt
    (1309, 6, 0, 5, 17397, 24, 48, 13), -- Shell Bug
    (1310, 6, 0, 5, 4101, 12, 24, 10), -- Water Crystal
    (1311, 6, 0, 5, 1225, 4, 8, 10), -- Gold Nugget
    (1312, 6, 0, 5, 1233, 4, 12, 10), -- Silver Nugget
    (1313, 6, 0, 5, 1238, 1, 2, 14), -- Tree Saplings
    (1314, 6, 0, 5, 918, 1, 2, 10), -- Mistletoe
    (1315, 6, 0, 5, 749, 1, 5, 10), -- Mythril Beastcoin
    (1316, 6, 0, 6, 936, 4, 8, 23), -- Rock Salt
    (1317, 6, 0, 6, 17397, 24, 48, 13), -- Shell Bug
    (1318, 6, 0, 6, 4096, 12, 24, 10), -- Fire Crystal
    (1319, 6, 0, 6, 1225, 4, 8, 10), -- Gold Nugget
    (1320, 6, 0, 6, 1232, 8, 16, 10), -- Bronze Nugget
    (1321, 6, 0, 6, 1238, 1, 2, 14), -- Tree Saplings
    (1322, 6, 0, 6, 750, 4, 8, 10), -- Silver Beastcoin
    (1323, 6, 0, 6, 1226, 4, 12, 10), -- Mythril Nugget
    (1324, 6, 0, 7, 936, 4, 8, 23), -- Rock Salt
    (1325, 6, 0, 7, 17397, 24, 48, 13), -- Shell Bug
    (1326, 6, 0, 7, 4103, 12, 24, 10), -- Dark Crystal
    (1327, 6, 0, 7, 1225, 4, 8, 10), -- Gold Nugget
    (1328, 6, 0, 7, 4570, 4, 12, 10), -- Bird Egg
    (1329, 6, 0, 7, 1238, 1, 2, 14), -- Tree Saplings
    (1330, 6, 0, 7, 842, 1, 5, 10), -- Giant Bird Feather
    (1331, 6, 0, 7, 1227, 4, 12, 10), -- Platinum Nugget
    (1332, 6, 0, 8, 936, 4, 8, 23), -- Rock Salt
    (1333, 6, 0, 8, 17397, 24, 48, 13), -- Shell Bug
    (1334, 6, 0, 8, 4102, 12, 24, 10), -- Light Crystal
    (1335, 6, 0, 8, 1225, 4, 8, 10), -- Gold Nugget
    (1336, 6, 0, 8, 4274, 4, 8, 10), -- Persikos
    (1337, 6, 0, 8, 1238, 1, 2, 14), -- Tree Saplings
    (1338, 6, 0, 8, 845, 4, 8, 10), -- Black Chocobo Feather
    (1339, 6, 0, 8, 1228, 4, 12, 10), -- Darksteel Nugget
    (1340, 6, 1, 0, 936, 4, 8, 23), -- Rock Salt
    (1341, 6, 1, 0, 17397, 24, 48, 13), -- Shell Bug
    (1342, 6, 1, 0, 4097, 12, 24, 10), -- Ice Crystal
    (1343, 6, 1, 0, 1225, 4, 8, 10), -- Gold Nugget
    (1344, 6, 1, 0, 1231, 12, 24, 10), -- Brass Nugget
    (1345, 6, 1, 0, 1238, 1, 2, 14), -- Tree Saplings
    (1346, 6, 1, 0, 941, 8, 16, 10), -- Red Rose
    (1347, 6, 1, 0, 751, 1, 5, 10), -- Platinum Beastcoin
    (1348, 6, 1, 1, 936, 12, 24, 20), -- Rock Salt
    (1349, 6, 1, 1, 4097, 12, 24, 20), -- Ice Crystal
    (1350, 6, 1, 1, 1231, 12, 24, 20), -- Brass Nugget
    (1351, 6, 1, 1, 941, 8, 16, 20), -- Red Rose
    (1352, 6, 1, 1, 751, 1, 5, 20), -- Platinum Beastcoin
    (1353, 6, 1, 2, 936, 12, 24, 10), -- Rock Salt
    (1354, 6, 1, 2, 17396, 12, 24, 15), -- Little Worm
    (1355, 6, 1, 2, 4097, 12, 24, 10), -- Ice Crystal
    (1356, 6, 1, 2, 4098, 12, 24, 15), -- Wind Crystal
    (1357, 6, 1, 2, 1231, 12, 24, 10), -- Brass Nugget
    (1358, 6, 1, 2, 920, 4, 8, 10), -- Malboro Vine
    (1359, 6, 1, 2, 941, 8, 16, 10), -- Red Rose
    (1360, 6, 1, 2, 1235, 4, 12, 10), -- Steel Nugget
    (1361, 6, 1, 2, 751, 1, 5, 10), -- Platinum Beastcoin
    (1362, 6, 1, 3, 936, 12, 24, 25), -- Rock Salt
    (1363, 6, 1, 3, 4097, 12, 24, 10), -- Ice Crystal
    (1364, 6, 1, 3, 4099, 12, 24, 15), -- Earth Crystal
    (1365, 6, 1, 3, 1231, 12, 24, 10), -- Brass Nugget
    (1366, 6, 1, 3, 1230, 8, 16, 10), -- Copper Nugget
    (1367, 6, 1, 3, 941, 8, 16, 10), -- Red Rose
    (1368, 6, 1, 3, 748, 1, 5, 10), -- Gold Beastcoin
    (1369, 6, 1, 3, 751, 1, 5, 10), -- Platinum Beastcoin
    (1370, 6, 1, 4, 936, 12, 24, 20), -- Rock Salt
    (1371, 6, 1, 4, 4097, 12, 24, 10), -- Ice Crystal
    (1372, 6, 1, 4, 4100, 12, 24, 10), -- Lightning Crystal
    (1373, 6, 1, 4, 1231, 12, 24, 10), -- Brass Nugget
    (1374, 6, 1, 4, 841, 4, 12, 10), -- Yagudo Feather
    (1375, 6, 1, 4, 941, 8, 16, 10), -- Red Rose
    (1376, 6, 1, 4, 839, 4, 8, 10), -- Crawler Cocoon
    (1377, 6, 1, 4, 751, 1, 5, 10), -- Platinum Beastcoin
    (1378, 6, 1, 4, 1234, 4, 12, 10), -- Iron Nugget
    (1379, 6, 1, 5, 936, 12, 24, 20), -- Rock Salt
    (1380, 6, 1, 5, 4097, 12, 24, 10), -- Ice Crystal
    (1381, 6, 1, 5, 4101, 12, 24, 10), -- Water Crystal
    (1382, 6, 1, 5, 1231, 12, 24, 10), -- Brass Nugget
    (1383, 6, 1, 5, 1233, 4, 12, 10), -- Silver Nugget
    (1384, 6, 1, 5, 941, 8, 16, 10), -- Red Rose
    (1385, 6, 1, 5, 918, 1, 2, 10), -- Mistletoe
    (1386, 6, 1, 5, 751, 1, 5, 10), -- Platinum Beastcoin
    (1387, 6, 1, 5, 749, 1, 5, 10), -- Mythril Beastcoin
    (1388, 6, 1, 6, 936, 12, 24, 20), -- Rock Salt
    (1389, 6, 1, 6, 4097, 12, 24, 10), -- Ice Crystal
    (1390, 6, 1, 6, 4096, 12, 24, 10), -- Fire Crystal
    (1391, 6, 1, 6, 1231, 12, 24, 10), -- Brass Nugget
    (1392, 6, 1, 6, 1232, 8, 16, 10), -- Bronze Nugget
    (1393, 6, 1, 6, 941, 8, 16, 10), -- Red Rose
    (1394, 6, 1, 6, 750, 4, 8, 10), -- Silver Beastcoin
    (1395, 6, 1, 6, 751, 1, 5, 10), -- Platinum Beastcoin
    (1396, 6, 1, 6, 1226, 4, 12, 10), -- Mythril Nugget
    (1397, 6, 1, 7, 936, 12, 24, 20), -- Rock Salt
    (1398, 6, 1, 7, 4097, 12, 24, 10), -- Ice Crystal
    (1399, 6, 1, 7, 4103, 12, 24, 10), -- Dark Crystal
    (1400, 6, 1, 7, 1231, 12, 24, 10), -- Brass Nugget
    (1401, 6, 1, 7, 4570, 4, 12, 10), -- Bird Egg
    (1402, 6, 1, 7, 941, 8, 16, 10), -- Red Rose
    (1403, 6, 1, 7, 842, 1, 5, 10), -- Giant Bird Feather
    (1404, 6, 1, 7, 751, 1, 5, 10), -- Platinum Beastcoin
    (1405, 6, 1, 7, 1227, 4, 12, 10), -- Platinum Nugget
    (1406, 6, 1, 8, 936, 12, 24, 20), -- Rock Salt
    (1407, 6, 1, 8, 4097, 12, 24, 10), -- Ice Crystal
    (1408, 6, 1, 8, 4102, 12, 24, 10), -- Light Crystal
    (1409, 6, 1, 8, 1231, 12, 24, 10), -- Brass Nugget
    (1410, 6, 1, 8, 4274, 4, 8, 10), -- Persikos
    (1411, 6, 1, 8, 941, 8, 16, 10), -- Red Rose
    (1412, 6, 1, 8, 845, 4, 8, 10), -- Black Chocobo Feather
    (1413, 6, 1, 8, 751, 1, 5, 10), -- Platinum Beastcoin
    (1414, 6, 1, 8, 1228, 4, 12, 10), -- Darksteel Nugget
    (1415, 6, 2, 0, 936, 4, 8, 13), -- Rock Salt
    (1416, 6, 2, 0, 17396, 12, 24, 15), -- Little Worm
    (1417, 6, 2, 0, 17397, 24, 48, 13), -- Shell Bug
    (1418, 6, 2, 0, 4098, 12, 24, 15), -- Wind Crystal
    (1419, 6, 2, 0, 1225, 4, 8, 10), -- Gold Nugget
    (1420, 6, 2, 0, 920, 4, 8, 10), -- Malboro Vine
    (1421, 6, 2, 0, 1238, 1, 2, 14), -- Tree Saplings
    (1422, 6, 2, 0, 1235, 4, 12, 10), -- Steel Nugget
    (1423, 6, 2, 1, 936, 12, 24, 10), -- Rock Salt
    (1424, 6, 2, 1, 17396, 12, 24, 15), -- Little Worm
    (1425, 6, 2, 1, 4097, 12, 24, 10), -- Ice Crystal
    (1426, 6, 2, 1, 4098, 12, 24, 15), -- Wind Crystal
    (1427, 6, 2, 1, 1231, 12, 24, 10), -- Brass Nugget
    (1428, 6, 2, 1, 920, 4, 8, 10), -- Malboro Vine
    (1429, 6, 2, 1, 941, 8, 16, 10), -- Red Rose
    (1430, 6, 2, 1, 1235, 4, 12, 10), -- Steel Nugget
    (1431, 6, 2, 1, 751, 1, 5, 10), -- Platinum Beastcoin
    (1432, 6, 2, 2, 17396, 12, 24, 30), -- Little Worm
    (1433, 6, 2, 2, 4098, 12, 24, 30), -- Wind Crystal
    (1434, 6, 2, 2, 920, 4, 8, 20), -- Malboro Vine
    (1435, 6, 2, 2, 1235, 4, 12, 20), -- Steel Nugget
    (1436, 6, 2, 3, 17396, 12, 24, 15), -- Little Worm
    (1437, 6, 2, 3, 936, 12, 24, 15), -- Rock Salt
    (1438, 6, 2, 3, 4098, 12, 24, 15), -- Wind Crystal
    (1439, 6, 2, 3, 4099, 12, 24, 15), -- Earth Crystal
    (1440, 6, 2, 3, 920, 4, 8, 10), -- Malboro Vine
    (1441, 6, 2, 3, 1230, 8, 16, 10), -- Copper Nugget
    (1442, 6, 2, 3, 1235, 4, 12, 10), -- Steel Nugget
    (1443, 6, 2, 3, 748, 1, 5, 10), -- Gold Beastcoin
    (1444, 6, 2, 4, 17396, 12, 24, 15), -- Little Worm
    (1445, 6, 2, 4, 936, 12, 24, 10), -- Rock Salt
    (1446, 6, 2, 4, 4098, 12, 24, 15), -- Wind Crystal
    (1447, 6, 2, 4, 4100, 12, 24, 10), -- Lightning Crystal
    (1448, 6, 2, 4, 920, 4, 8, 10), -- Malboro Vine
    (1449, 6, 2, 4, 841, 4, 12, 10), -- Yagudo Feather
    (1450, 6, 2, 4, 1235, 4, 12, 10), -- Steel Nugget
    (1451, 6, 2, 4, 839, 4, 8, 10), -- Crawler Cocoon
    (1452, 6, 2, 4, 1234, 4, 12, 10), -- Iron Nugget
    (1453, 6, 2, 5, 17396, 12, 24, 15), -- Little Worm
    (1454, 6, 2, 5, 936, 12, 24, 10), -- Rock Salt
    (1455, 6, 2, 5, 4098, 12, 24, 15), -- Wind Crystal
    (1456, 6, 2, 5, 4101, 12, 24, 10), -- Water Crystal
    (1457, 6, 2, 5, 920, 4, 8, 10), -- Malboro Vine
    (1458, 6, 2, 5, 1233, 4, 12, 10), -- Silver Nugget
    (1459, 6, 2, 5, 1235, 4, 12, 10), -- Steel Nugget
    (1460, 6, 2, 5, 918, 1, 2, 10), -- Mistletoe
    (1461, 6, 2, 5, 749, 1, 5, 10), -- Mythril Beastcoin
    (1462, 6, 2, 6, 17396, 12, 24, 15), -- Little Worm
    (1463, 6, 2, 6, 936, 12, 24, 10), -- Rock Salt
    (1464, 6, 2, 6, 4098, 12, 24, 15), -- Wind Crystal
    (1465, 6, 2, 6, 4096, 12, 24, 10), -- Fire Crystal
    (1466, 6, 2, 6, 920, 4, 8, 10), -- Malboro Vine
    (1467, 6, 2, 6, 1232, 8, 16, 10), -- Bronze Nugget
    (1468, 6, 2, 6, 1235, 4, 12, 10), -- Steel Nugget
    (1469, 6, 2, 6, 750, 4, 8, 10), -- Silver Beastcoin
    (1470, 6, 2, 6, 1226, 4, 12, 10), -- Mythril Nugget
    (1471, 6, 2, 7, 17396, 12, 24, 15), -- Little Worm
    (1472, 6, 2, 7, 936, 12, 24, 10), -- Rock Salt
    (1473, 6, 2, 7, 4098, 12, 24, 15), -- Wind Crystal
    (1474, 6, 2, 7, 4103, 12, 24, 10), -- Dark Crystal
    (1475, 6, 2, 7, 920, 4, 8, 10), -- Malboro Vine
    (1476, 6, 2, 7, 4570, 4, 12, 10), -- Bird Egg
    (1477, 6, 2, 7, 1235, 4, 12, 10), -- Steel Nugget
    (1478, 6, 2, 7, 842, 1, 5, 10), -- Giant Bird Feather
    (1479, 6, 2, 7, 1227, 4, 12, 10), -- Platinum Nugget
    (1480, 6, 2, 8, 17396, 12, 24, 15), -- Little Worm
    (1481, 6, 2, 8, 936, 12, 24, 10), -- Rock Salt
    (1482, 6, 2, 8, 4098, 12, 24, 15), -- Wind Crystal
    (1483, 6, 2, 8, 4102, 12, 24, 10), -- Light Crystal
    (1484, 6, 2, 8, 920, 4, 8, 10), -- Malboro Vine
    (1485, 6, 2, 8, 4274, 4, 8, 10), -- Persikos
    (1486, 6, 2, 8, 1235, 4, 12, 10), -- Steel Nugget
    (1487, 6, 2, 8, 845, 4, 8, 10), -- Black Chocobo Feather
    (1488, 6, 2, 8, 1228, 4, 12, 10), -- Darksteel Nugget
    (1489, 6, 3, 0, 936, 4, 8, 28), -- Rock Salt
    (1490, 6, 3, 0, 17397, 24, 48, 13), -- Shell Bug
    (1491, 6, 3, 0, 4099, 12, 24, 15), -- Earth Crystal
    (1492, 6, 3, 0, 1225, 4, 8, 10), -- Gold Nugget
    (1493, 6, 3, 0, 1230, 8, 16, 10), -- Copper Nugget
    (1494, 6, 3, 0, 1238, 1, 2, 14), -- Tree Saplings
    (1495, 6, 3, 0, 748, 1, 5, 10), -- Gold Beastcoin
    (1496, 6, 3, 1, 936, 12, 24, 25), -- Rock Salt
    (1497, 6, 3, 1, 4097, 12, 24, 10), -- Ice Crystal
    (1498, 6, 3, 1, 4099, 12, 24, 15), -- Earth Crystal
    (1499, 6, 3, 1, 1231, 12, 24, 10), -- Brass Nugget
    (1500, 6, 3, 1, 1230, 8, 16, 10), -- Copper Nugget
    (1501, 6, 3, 1, 941, 8, 16, 10), -- Red Rose
    (1502, 6, 3, 1, 748, 1, 5, 10), -- Gold Beastcoin
    (1503, 6, 3, 1, 751, 1, 5, 10), -- Platinum Beastcoin
    (1504, 6, 3, 2, 17396, 12, 24, 15), -- Little Worm
    (1505, 6, 3, 2, 936, 12, 24, 15), -- Rock Salt
    (1506, 6, 3, 2, 4098, 12, 24, 15), -- Wind Crystal
    (1507, 6, 3, 2, 4099, 12, 24, 15), -- Earth Crystal
    (1508, 6, 3, 2, 920, 4, 8, 10), -- Malboro Vine
    (1509, 6, 3, 2, 1230, 8, 16, 10), -- Copper Nugget
    (1510, 6, 3, 2, 1235, 4, 12, 10), -- Steel Nugget
    (1511, 6, 3, 2, 748, 1, 5, 10), -- Gold Beastcoin
    (1512, 6, 3, 3, 936, 12, 24, 30), -- Rock Salt
    (1513, 6, 3, 3, 4099, 12, 24, 30), -- Earth Crystal
    (1514, 6, 3, 3, 1230, 8, 16, 20), -- Copper Nugget
    (1515, 6, 3, 3, 748, 1, 5, 20), -- Gold Beastcoin
    (1516, 6, 3, 4, 936, 12, 24, 25), -- Rock Salt
    (1517, 6, 3, 4, 4099, 12, 24, 15), -- Earth Crystal
    (1518, 6, 3, 4, 4100, 12, 24, 10), -- Lightning Crystal
    (1519, 6, 3, 4, 1230, 8, 16, 10), -- Copper Nugget
    (1520, 6, 3, 4, 841, 4, 12, 10), -- Yagudo Feather
    (1521, 6, 3, 4, 748, 1, 5, 10), -- Gold Beastcoin
    (1522, 6, 3, 4, 839, 4, 8, 10), -- Crawler Cocoon
    (1523, 6, 3, 4, 1234, 4, 12, 10), -- Iron Nugget
    (1524, 6, 3, 5, 936, 12, 24, 25), -- Rock Salt
    (1525, 6, 3, 5, 4099, 12, 24, 15), -- Earth Crystal
    (1526, 6, 3, 5, 4101, 12, 24, 10), -- Water Crystal
    (1527, 6, 3, 5, 1230, 8, 16, 10), -- Copper Nugget
    (1528, 6, 3, 5, 1233, 4, 12, 10), -- Silver Nugget
    (1529, 6, 3, 5, 748, 1, 5, 10), -- Gold Beastcoin
    (1530, 6, 3, 5, 918, 1, 2, 10), -- Mistletoe
    (1531, 6, 3, 5, 749, 1, 5, 10), -- Mythril Beastcoin
    (1532, 6, 3, 6, 936, 12, 24, 25), -- Rock Salt
    (1533, 6, 3, 6, 4099, 12, 24, 15), -- Earth Crystal
    (1534, 6, 3, 6, 4096, 12, 24, 10), -- Fire Crystal
    (1535, 6, 3, 6, 1230, 8, 16, 10), -- Copper Nugget
    (1536, 6, 3, 6, 1232, 8, 16, 10), -- Bronze Nugget
    (1537, 6, 3, 6, 748, 1, 5, 10), -- Gold Beastcoin
    (1538, 6, 3, 6, 750, 4, 8, 10), -- Silver Beastcoin
    (1539, 6, 3, 6, 1226, 4, 12, 10), -- Mythril Nugget
    (1540, 6, 3, 7, 936, 12, 24, 25), -- Rock Salt
    (1541, 6, 3, 7, 4099, 12, 24, 15), -- Earth Crystal
    (1542, 6, 3, 7, 4103, 12, 24, 10), -- Dark Crystal
    (1543, 6, 3, 7, 1230, 8, 16, 10), -- Copper Nugget
    (1544, 6, 3, 7, 4570, 4, 12, 10), -- Bird Egg
    (1545, 6, 3, 7, 748, 1, 5, 10), -- Gold Beastcoin
    (1546, 6, 3, 7, 842, 1, 5, 10), -- Giant Bird Feather
    (1547, 6, 3, 7, 1227, 4, 12, 10), -- Platinum Nugget
    (1548, 6, 3, 8, 936, 12, 24, 25), -- Rock Salt
    (1549, 6, 3, 8, 4099, 12, 24, 15), -- Earth Crystal
    (1550, 6, 3, 8, 4102, 12, 24, 10), -- Light Crystal
    (1551, 6, 3, 8, 1230, 8, 16, 10), -- Copper Nugget
    (1552, 6, 3, 8, 4274, 4, 8, 10), -- Persikos
    (1553, 6, 3, 8, 748, 1, 5, 10), -- Gold Beastcoin
    (1554, 6, 3, 8, 845, 4, 8, 10), -- Black Chocobo Feather
    (1555, 6, 3, 8, 1228, 4, 12, 10), -- Darksteel Nugget
    (1556, 6, 4, 0, 936, 4, 8, 23), -- Rock Salt
    (1557, 6, 4, 0, 17397, 24, 48, 13), -- Shell Bug
    (1558, 6, 4, 0, 4100, 12, 24, 10), -- Lightning Crystal
    (1559, 6, 4, 0, 1225, 4, 8, 10), -- Gold Nugget
    (1560, 6, 4, 0, 841, 4, 12, 10), -- Yagudo Feather
    (1561, 6, 4, 0, 1238, 1, 2, 14), -- Tree Saplings
    (1562, 6, 4, 0, 839, 4, 8, 10), -- Crawler Cocoon
    (1563, 6, 4, 0, 1234, 4, 12, 10), -- Iron Nugget
    (1564, 6, 4, 1, 936, 12, 24, 20), -- Rock Salt
    (1565, 6, 4, 1, 4097, 12, 24, 10), -- Ice Crystal
    (1566, 6, 4, 1, 4100, 12, 24, 10), -- Lightning Crystal
    (1567, 6, 4, 1, 1231, 12, 24, 10), -- Brass Nugget
    (1568, 6, 4, 1, 841, 4, 12, 10), -- Yagudo Feather
    (1569, 6, 4, 1, 941, 8, 16, 10), -- Red Rose
    (1570, 6, 4, 1, 839, 4, 8, 10), -- Crawler Cocoon
    (1571, 6, 4, 1, 751, 1, 5, 10), -- Platinum Beastcoin
    (1572, 6, 4, 1, 1234, 4, 12, 10), -- Iron Nugget
    (1573, 6, 4, 2, 17396, 12, 24, 15), -- Little Worm
    (1574, 6, 4, 2, 936, 12, 24, 10), -- Rock Salt
    (1575, 6, 4, 2, 4098, 12, 24, 15), -- Wind Crystal
    (1576, 6, 4, 2, 4100, 12, 24, 10), -- Lightning Crystal
    (1577, 6, 4, 2, 920, 4, 8, 10), -- Malboro Vine
    (1578, 6, 4, 2, 841, 4, 12, 10), -- Yagudo Feather
    (1579, 6, 4, 2, 1235, 4, 12, 10), -- Steel Nugget
    (1580, 6, 4, 2, 839, 4, 8, 10), -- Crawler Cocoon
    (1581, 6, 4, 2, 1234, 4, 12, 10), -- Iron Nugget
    (1582, 6, 4, 3, 936, 12, 24, 25), -- Rock Salt
    (1583, 6, 4, 3, 4099, 12, 24, 15), -- Earth Crystal
    (1584, 6, 4, 3, 4100, 12, 24, 10), -- Lightning Crystal
    (1585, 6, 4, 3, 1230, 8, 16, 10), -- Copper Nugget
    (1586, 6, 4, 3, 841, 4, 12, 10), -- Yagudo Feather
    (1587, 6, 4, 3, 748, 1, 5, 10), -- Gold Beastcoin
    (1588, 6, 4, 3, 839, 4, 8, 10), -- Crawler Cocoon
    (1589, 6, 4, 3, 1234, 4, 12, 10), -- Iron Nugget
    (1590, 6, 4, 4, 936, 12, 24, 20), -- Rock Salt
    (1591, 6, 4, 4, 4100, 12, 24, 20), -- Lightning Crystal
    (1592, 6, 4, 4, 841, 4, 12, 20), -- Yagudo Feather
    (1593, 6, 4, 4, 839, 4, 8, 20), -- Crawler Cocoon
    (1594, 6, 4, 4, 1234, 4, 12, 20), -- Iron Nugget
    (1595, 6, 4, 5, 936, 12, 24, 20), -- Rock Salt
    (1596, 6, 4, 5, 4100, 12, 24, 10), -- Lightning Crystal
    (1597, 6, 4, 5, 4101, 12, 24, 10), -- Water Crystal
    (1598, 6, 4, 5, 841, 4, 12, 10), -- Yagudo Feather
    (1599, 6, 4, 5, 1233, 4, 12, 10), -- Silver Nugget
    (1600, 6, 4, 5, 839, 4, 8, 10), -- Crawler Cocoon
    (1601, 6, 4, 5, 918, 1, 2, 10), -- Mistletoe
    (1602, 6, 4, 5, 1234, 4, 12, 10), -- Iron Nugget
    (1603, 6, 4, 5, 749, 1, 5, 10), -- Mythril Beastcoin
    (1604, 6, 4, 6, 936, 12, 24, 20), -- Rock Salt
    (1605, 6, 4, 6, 4100, 12, 24, 10), -- Lightning Crystal
    (1606, 6, 4, 6, 4096, 12, 24, 10), -- Fire Crystal
    (1607, 6, 4, 6, 841, 4, 12, 10), -- Yagudo Feather
    (1608, 6, 4, 6, 1232, 8, 16, 10), -- Bronze Nugget
    (1609, 6, 4, 6, 839, 4, 8, 10), -- Crawler Cocoon
    (1610, 6, 4, 6, 750, 4, 8, 10), -- Silver Beastcoin
    (1611, 6, 4, 6, 1234, 4, 12, 10), -- Iron Nugget
    (1612, 6, 4, 6, 1226, 4, 12, 10), -- Mythril Nugget
    (1613, 6, 4, 7, 936, 12, 24, 20), -- Rock Salt
    (1614, 6, 4, 7, 4100, 12, 24, 10), -- Lightning Crystal
    (1615, 6, 4, 7, 4103, 12, 24, 10), -- Dark Crystal
    (1616, 6, 4, 7, 841, 4, 12, 10), -- Yagudo Feather
    (1617, 6, 4, 7, 4570, 4, 12, 10), -- Bird Egg
    (1618, 6, 4, 7, 839, 4, 8, 10), -- Crawler Cocoon
    (1619, 6, 4, 7, 842, 1, 5, 10), -- Giant Bird Feather
    (1620, 6, 4, 7, 1234, 4, 12, 10), -- Iron Nugget
    (1621, 6, 4, 7, 1227, 4, 12, 10), -- Platinum Nugget
    (1622, 6, 4, 8, 936, 12, 24, 20), -- Rock Salt
    (1623, 6, 4, 8, 4100, 12, 24, 10), -- Lightning Crystal
    (1624, 6, 4, 8, 4102, 12, 24, 10), -- Light Crystal
    (1625, 6, 4, 8, 841, 4, 12, 10), -- Yagudo Feather
    (1626, 6, 4, 8, 4274, 4, 8, 10), -- Persikos
    (1627, 6, 4, 8, 839, 4, 8, 10), -- Crawler Cocoon
    (1628, 6, 4, 8, 845, 4, 8, 10), -- Black Chocobo Feather
    (1629, 6, 4, 8, 1234, 4, 12, 10), -- Iron Nugget
    (1630, 6, 4, 8, 1228, 4, 12, 10), -- Darksteel Nugget
    (1631, 6, 5, 0, 936, 4, 8, 23), -- Rock Salt
    (1632, 6, 5, 0, 17397, 24, 48, 13), -- Shell Bug
    (1633, 6, 5, 0, 4101, 12, 24, 10), -- Water Crystal
    (1634, 6, 5, 0, 1225, 4, 8, 10), -- Gold Nugget
    (1635, 6, 5, 0, 1233, 4, 12, 10), -- Silver Nugget
    (1636, 6, 5, 0, 1238, 1, 2, 14), -- Tree Saplings
    (1637, 6, 5, 0, 918, 1, 2, 10), -- Mistletoe
    (1638, 6, 5, 0, 749, 1, 5, 10), -- Mythril Beastcoin
    (1639, 6, 5, 1, 936, 12, 24, 20), -- Rock Salt
    (1640, 6, 5, 1, 4097, 12, 24, 10), -- Ice Crystal
    (1641, 6, 5, 1, 4101, 12, 24, 10), -- Water Crystal
    (1642, 6, 5, 1, 1231, 12, 24, 10), -- Brass Nugget
    (1643, 6, 5, 1, 1233, 4, 12, 10), -- Silver Nugget
    (1644, 6, 5, 1, 941, 8, 16, 10), -- Red Rose
    (1645, 6, 5, 1, 918, 1, 2, 10), -- Mistletoe
    (1646, 6, 5, 1, 751, 1, 5, 10), -- Platinum Beastcoin
    (1647, 6, 5, 1, 749, 1, 5, 10), -- Mythril Beastcoin
    (1648, 6, 5, 2, 17396, 12, 24, 15), -- Little Worm
    (1649, 6, 5, 2, 936, 12, 24, 10), -- Rock Salt
    (1650, 6, 5, 2, 4098, 12, 24, 15), -- Wind Crystal
    (1651, 6, 5, 2, 4101, 12, 24, 10), -- Water Crystal
    (1652, 6, 5, 2, 920, 4, 8, 10), -- Malboro Vine
    (1653, 6, 5, 2, 1233, 4, 12, 10), -- Silver Nugget
    (1654, 6, 5, 2, 1235, 4, 12, 10), -- Steel Nugget
    (1655, 6, 5, 2, 918, 1, 2, 10), -- Mistletoe
    (1656, 6, 5, 2, 749, 1, 5, 10), -- Mythril Beastcoin
    (1657, 6, 5, 3, 936, 12, 24, 25), -- Rock Salt
    (1658, 6, 5, 3, 4099, 12, 24, 15), -- Earth Crystal
    (1659, 6, 5, 3, 4101, 12, 24, 10), -- Water Crystal
    (1660, 6, 5, 3, 1230, 8, 16, 10), -- Copper Nugget
    (1661, 6, 5, 3, 1233, 4, 12, 10), -- Silver Nugget
    (1662, 6, 5, 3, 748, 1, 5, 10), -- Gold Beastcoin
    (1663, 6, 5, 3, 918, 1, 2, 10), -- Mistletoe
    (1664, 6, 5, 3, 749, 1, 5, 10), -- Mythril Beastcoin
    (1665, 6, 5, 4, 936, 12, 24, 20), -- Rock Salt
    (1666, 6, 5, 4, 4100, 12, 24, 10), -- Lightning Crystal
    (1667, 6, 5, 4, 4101, 12, 24, 10), -- Water Crystal
    (1668, 6, 5, 4, 841, 4, 12, 10), -- Yagudo Feather
    (1669, 6, 5, 4, 1233, 4, 12, 10), -- Silver Nugget
    (1670, 6, 5, 4, 839, 4, 8, 10), -- Crawler Cocoon
    (1671, 6, 5, 4, 918, 1, 2, 10), -- Mistletoe
    (1672, 6, 5, 4, 1234, 4, 12, 10), -- Iron Nugget
    (1673, 6, 5, 4, 749, 1, 5, 10), -- Mythril Beastcoin
    (1674, 6, 5, 5, 936, 12, 24, 20), -- Rock Salt
    (1675, 6, 5, 5, 4101, 12, 24, 20), -- Water Crystal
    (1676, 6, 5, 5, 1233, 4, 12, 20), -- Silver Nugget
    (1677, 6, 5, 5, 918, 1, 2, 20), -- Mistletoe
    (1678, 6, 5, 5, 749, 1, 5, 20), -- Mythril Beastcoin
    (1679, 6, 5, 6, 936, 12, 24, 20), -- Rock Salt
    (1680, 6, 5, 6, 4101, 12, 24, 10), -- Water Crystal
    (1681, 6, 5, 6, 4096, 12, 24, 10), -- Fire Crystal
    (1682, 6, 5, 6, 1233, 4, 12, 10), -- Silver Nugget
    (1683, 6, 5, 6, 1232, 8, 16, 10), -- Bronze Nugget
    (1684, 6, 5, 6, 918, 1, 2, 10), -- Mistletoe
    (1685, 6, 5, 6, 750, 4, 8, 10), -- Silver Beastcoin
    (1686, 6, 5, 6, 749, 1, 5, 10), -- Mythril Beastcoin
    (1687, 6, 5, 6, 1226, 4, 12, 10), -- Mythril Nugget
    (1688, 6, 5, 7, 936, 12, 24, 20), -- Rock Salt
    (1689, 6, 5, 7, 4101, 12, 24, 10), -- Water Crystal
    (1690, 6, 5, 7, 4103, 12, 24, 10), -- Dark Crystal
    (1691, 6, 5, 7, 1233, 4, 12, 10), -- Silver Nugget
    (1692, 6, 5, 7, 4570, 4, 12, 10), -- Bird Egg
    (1693, 6, 5, 7, 918, 1, 2, 10), -- Mistletoe
    (1694, 6, 5, 7, 842, 1, 5, 10), -- Giant Bird Feather
    (1695, 6, 5, 7, 749, 1, 5, 10), -- Mythril Beastcoin
    (1696, 6, 5, 7, 1227, 4, 12, 10), -- Platinum Nugget
    (1697, 6, 5, 8, 936, 12, 24, 20), -- Rock Salt
    (1698, 6, 5, 8, 4101, 12, 24, 10), -- Water Crystal
    (1699, 6, 5, 8, 4102, 12, 24, 10), -- Light Crystal
    (1700, 6, 5, 8, 1233, 4, 12, 10), -- Silver Nugget
    (1701, 6, 5, 8, 4274, 4, 8, 10), -- Persikos
    (1702, 6, 5, 8, 918, 1, 2, 10), -- Mistletoe
    (1703, 6, 5, 8, 845, 4, 8, 10), -- Black Chocobo Feather
    (1704, 6, 5, 8, 749, 1, 5, 10), -- Mythril Beastcoin
    (1705, 6, 5, 8, 1228, 4, 12, 10), -- Darksteel Nugget
    (1706, 6, 6, 0, 936, 4, 8, 23), -- Rock Salt
    (1707, 6, 6, 0, 17397, 24, 48, 13), -- Shell Bug
    (1708, 6, 6, 0, 4096, 12, 24, 10), -- Fire Crystal
    (1709, 6, 6, 0, 1225, 4, 8, 10), -- Gold Nugget
    (1710, 6, 6, 0, 1232, 8, 16, 10), -- Bronze Nugget
    (1711, 6, 6, 0, 1238, 1, 2, 14), -- Tree Saplings
    (1712, 6, 6, 0, 750, 4, 8, 10), -- Silver Beastcoin
    (1713, 6, 6, 0, 1226, 4, 12, 10), -- Mythril Nugget
    (1714, 6, 6, 1, 936, 12, 24, 20), -- Rock Salt
    (1715, 6, 6, 1, 4097, 12, 24, 10), -- Ice Crystal
    (1716, 6, 6, 1, 4096, 12, 24, 10), -- Fire Crystal
    (1717, 6, 6, 1, 1231, 12, 24, 10), -- Brass Nugget
    (1718, 6, 6, 1, 1232, 8, 16, 10), -- Bronze Nugget
    (1719, 6, 6, 1, 941, 8, 16, 10), -- Red Rose
    (1720, 6, 6, 1, 750, 4, 8, 10), -- Silver Beastcoin
    (1721, 6, 6, 1, 751, 1, 5, 10), -- Platinum Beastcoin
    (1722, 6, 6, 1, 1226, 4, 12, 10), -- Mythril Nugget
    (1723, 6, 6, 2, 17396, 12, 24, 15), -- Little Worm
    (1724, 6, 6, 2, 936, 12, 24, 10), -- Rock Salt
    (1725, 6, 6, 2, 4098, 12, 24, 15), -- Wind Crystal
    (1726, 6, 6, 2, 4096, 12, 24, 10), -- Fire Crystal
    (1727, 6, 6, 2, 920, 4, 8, 10), -- Malboro Vine
    (1728, 6, 6, 2, 1232, 8, 16, 10), -- Bronze Nugget
    (1729, 6, 6, 2, 1235, 4, 12, 10), -- Steel Nugget
    (1730, 6, 6, 2, 750, 4, 8, 10), -- Silver Beastcoin
    (1731, 6, 6, 2, 1226, 4, 12, 10), -- Mythril Nugget
    (1732, 6, 6, 3, 936, 12, 24, 25), -- Rock Salt
    (1733, 6, 6, 3, 4099, 12, 24, 15), -- Earth Crystal
    (1734, 6, 6, 3, 4096, 12, 24, 10), -- Fire Crystal
    (1735, 6, 6, 3, 1230, 8, 16, 10), -- Copper Nugget
    (1736, 6, 6, 3, 1232, 8, 16, 10), -- Bronze Nugget
    (1737, 6, 6, 3, 748, 1, 5, 10), -- Gold Beastcoin
    (1738, 6, 6, 3, 750, 4, 8, 10), -- Silver Beastcoin
    (1739, 6, 6, 3, 1226, 4, 12, 10), -- Mythril Nugget
    (1740, 6, 6, 4, 936, 12, 24, 20), -- Rock Salt
    (1741, 6, 6, 4, 4100, 12, 24, 10), -- Lightning Crystal
    (1742, 6, 6, 4, 4096, 12, 24, 10), -- Fire Crystal
    (1743, 6, 6, 4, 841, 4, 12, 10), -- Yagudo Feather
    (1744, 6, 6, 4, 1232, 8, 16, 10), -- Bronze Nugget
    (1745, 6, 6, 4, 839, 4, 8, 10), -- Crawler Cocoon
    (1746, 6, 6, 4, 750, 4, 8, 10), -- Silver Beastcoin
    (1747, 6, 6, 4, 1234, 4, 12, 10), -- Iron Nugget
    (1748, 6, 6, 4, 1226, 4, 12, 10), -- Mythril Nugget
    (1749, 6, 6, 5, 936, 12, 24, 20), -- Rock Salt
    (1750, 6, 6, 5, 4101, 12, 24, 10), -- Water Crystal
    (1751, 6, 6, 5, 4096, 12, 24, 10), -- Fire Crystal
    (1752, 6, 6, 5, 1233, 4, 12, 10), -- Silver Nugget
    (1753, 6, 6, 5, 1232, 8, 16, 10), -- Bronze Nugget
    (1754, 6, 6, 5, 918, 1, 2, 10), -- Mistletoe
    (1755, 6, 6, 5, 750, 4, 8, 10), -- Silver Beastcoin
    (1756, 6, 6, 5, 749, 1, 5, 10), -- Mythril Beastcoin
    (1757, 6, 6, 5, 1226, 4, 12, 10), -- Mythril Nugget
    (1758, 6, 6, 6, 936, 12, 24, 20), -- Rock Salt
    (1759, 6, 6, 6, 4096, 12, 24, 20), -- Fire Crystal
    (1760, 6, 6, 6, 1232, 8, 16, 20), -- Bronze Nugget
    (1761, 6, 6, 6, 750, 4, 8, 20), -- Silver Beastcoin
    (1762, 6, 6, 6, 1226, 4, 12, 20), -- Mythril Nugget
    (1763, 6, 6, 7, 936, 12, 24, 20), -- Rock Salt
    (1764, 6, 6, 7, 4096, 12, 24, 10), -- Fire Crystal
    (1765, 6, 6, 7, 4103, 12, 24, 10), -- Dark Crystal
    (1766, 6, 6, 7, 1232, 8, 16, 10), -- Bronze Nugget
    (1767, 6, 6, 7, 4570, 4, 12, 10), -- Bird Egg
    (1768, 6, 6, 7, 750, 4, 8, 10), -- Silver Beastcoin
    (1769, 6, 6, 7, 842, 1, 5, 10), -- Giant Bird Feather
    (1770, 6, 6, 7, 1226, 4, 12, 10), -- Mythril Nugget
    (1771, 6, 6, 7, 1227, 4, 12, 10), -- Platinum Nugget
    (1772, 6, 6, 8, 936, 12, 24, 20), -- Rock Salt
    (1773, 6, 6, 8, 4096, 12, 24, 10), -- Fire Crystal
    (1774, 6, 6, 8, 4102, 12, 24, 10), -- Light Crystal
    (1775, 6, 6, 8, 1232, 8, 16, 10), -- Bronze Nugget
    (1776, 6, 6, 8, 4274, 4, 8, 10), -- Persikos
    (1777, 6, 6, 8, 750, 4, 8, 10), -- Silver Beastcoin
    (1778, 6, 6, 8, 845, 4, 8, 10), -- Black Chocobo Feather
    (1779, 6, 6, 8, 1226, 4, 12, 10), -- Mythril Nugget
    (1780, 6, 6, 8, 1228, 4, 12, 10), -- Darksteel Nugget
    (1781, 6, 7, 0, 936, 4, 8, 23), -- Rock Salt
    (1782, 6, 7, 0, 17397, 24, 48, 13), -- Shell Bug
    (1783, 6, 7, 0, 4103, 12, 24, 10), -- Dark Crystal
    (1784, 6, 7, 0, 1225, 4, 8, 10), -- Gold Nugget
    (1785, 6, 7, 0, 4570, 4, 12, 10), -- Bird Egg
    (1786, 6, 7, 0, 1238, 1, 2, 14), -- Tree Saplings
    (1787, 6, 7, 0, 842, 1, 5, 10), -- Giant Bird Feather
    (1788, 6, 7, 0, 1227, 4, 12, 10), -- Platinum Nugget
    (1789, 6, 7, 1, 936, 12, 24, 20), -- Rock Salt
    (1790, 6, 7, 1, 4097, 12, 24, 10), -- Ice Crystal
    (1791, 6, 7, 1, 4103, 12, 24, 10), -- Dark Crystal
    (1792, 6, 7, 1, 1231, 12, 24, 10), -- Brass Nugget
    (1793, 6, 7, 1, 4570, 4, 12, 10), -- Bird Egg
    (1794, 6, 7, 1, 941, 8, 16, 10), -- Red Rose
    (1795, 6, 7, 1, 842, 1, 5, 10), -- Giant Bird Feather
    (1796, 6, 7, 1, 751, 1, 5, 10), -- Platinum Beastcoin
    (1797, 6, 7, 1, 1227, 4, 12, 10), -- Platinum Nugget
    (1798, 6, 7, 2, 17396, 12, 24, 15), -- Little Worm
    (1799, 6, 7, 2, 936, 12, 24, 10), -- Rock Salt
    (1800, 6, 7, 2, 4098, 12, 24, 15), -- Wind Crystal
    (1801, 6, 7, 2, 4103, 12, 24, 10), -- Dark Crystal
    (1802, 6, 7, 2, 920, 4, 8, 10), -- Malboro Vine
    (1803, 6, 7, 2, 4570, 4, 12, 10), -- Bird Egg
    (1804, 6, 7, 2, 1235, 4, 12, 10), -- Steel Nugget
    (1805, 6, 7, 2, 842, 1, 5, 10), -- Giant Bird Feather
    (1806, 6, 7, 2, 1227, 4, 12, 10), -- Platinum Nugget
    (1807, 6, 7, 3, 936, 12, 24, 25), -- Rock Salt
    (1808, 6, 7, 3, 4099, 12, 24, 15), -- Earth Crystal
    (1809, 6, 7, 3, 4103, 12, 24, 10), -- Dark Crystal
    (1810, 6, 7, 3, 1230, 8, 16, 10), -- Copper Nugget
    (1811, 6, 7, 3, 4570, 4, 12, 10), -- Bird Egg
    (1812, 6, 7, 3, 748, 1, 5, 10), -- Gold Beastcoin
    (1813, 6, 7, 3, 842, 1, 5, 10), -- Giant Bird Feather
    (1814, 6, 7, 3, 1227, 4, 12, 10), -- Platinum Nugget
    (1815, 6, 7, 4, 936, 12, 24, 20), -- Rock Salt
    (1816, 6, 7, 4, 4100, 12, 24, 10), -- Lightning Crystal
    (1817, 6, 7, 4, 4103, 12, 24, 10), -- Dark Crystal
    (1818, 6, 7, 4, 841, 4, 12, 10), -- Yagudo Feather
    (1819, 6, 7, 4, 4570, 4, 12, 10), -- Bird Egg
    (1820, 6, 7, 4, 839, 4, 8, 10), -- Crawler Cocoon
    (1821, 6, 7, 4, 842, 1, 5, 10), -- Giant Bird Feather
    (1822, 6, 7, 4, 1234, 4, 12, 10), -- Iron Nugget
    (1823, 6, 7, 4, 1227, 4, 12, 10), -- Platinum Nugget
    (1824, 6, 7, 5, 936, 12, 24, 20), -- Rock Salt
    (1825, 6, 7, 5, 4101, 12, 24, 10), -- Water Crystal
    (1826, 6, 7, 5, 4103, 12, 24, 10), -- Dark Crystal
    (1827, 6, 7, 5, 1233, 4, 12, 10), -- Silver Nugget
    (1828, 6, 7, 5, 4570, 4, 12, 10), -- Bird Egg
    (1829, 6, 7, 5, 918, 1, 2, 10), -- Mistletoe
    (1830, 6, 7, 5, 842, 1, 5, 10), -- Giant Bird Feather
    (1831, 6, 7, 5, 749, 1, 5, 10), -- Mythril Beastcoin
    (1832, 6, 7, 5, 1227, 4, 12, 10), -- Platinum Nugget
    (1833, 6, 7, 6, 936, 12, 24, 20), -- Rock Salt
    (1834, 6, 7, 6, 4096, 12, 24, 10), -- Fire Crystal
    (1835, 6, 7, 6, 4103, 12, 24, 10), -- Dark Crystal
    (1836, 6, 7, 6, 1232, 8, 16, 10), -- Bronze Nugget
    (1837, 6, 7, 6, 4570, 4, 12, 10), -- Bird Egg
    (1838, 6, 7, 6, 750, 4, 8, 10), -- Silver Beastcoin
    (1839, 6, 7, 6, 842, 1, 5, 10), -- Giant Bird Feather
    (1840, 6, 7, 6, 1226, 4, 12, 10), -- Mythril Nugget
    (1841, 6, 7, 6, 1227, 4, 12, 10), -- Platinum Nugget
    (1842, 6, 7, 7, 936, 12, 24, 20), -- Rock Salt
    (1843, 6, 7, 7, 4103, 12, 24, 20), -- Dark Crystal
    (1844, 6, 7, 7, 4570, 4, 12, 20), -- Bird Egg
    (1845, 6, 7, 7, 842, 1, 5, 20), -- Giant Bird Feather
    (1846, 6, 7, 7, 1227, 4, 12, 20), -- Platinum Nugget
    (1847, 6, 7, 8, 936, 12, 24, 20), -- Rock Salt
    (1848, 6, 7, 8, 4103, 12, 24, 10), -- Dark Crystal
    (1849, 6, 7, 8, 4102, 12, 24, 10), -- Light Crystal
    (1850, 6, 7, 8, 4570, 4, 12, 10), -- Bird Egg
    (1851, 6, 7, 8, 4274, 4, 8, 10), -- Persikos
    (1852, 6, 7, 8, 842, 1, 5, 10), -- Giant Bird Feather
    (1853, 6, 7, 8, 845, 4, 8, 10), -- Black Chocobo Feather
    (1854, 6, 7, 8, 1227, 4, 12, 10), -- Platinum Nugget
    (1855, 6, 7, 8, 1228, 4, 12, 10), -- Darksteel Nugget
    (1856, 6, 8, 0, 936, 4, 8, 23), -- Rock Salt
    (1857, 6, 8, 0, 17397, 24, 48, 13), -- Shell Bug
    (1858, 6, 8, 0, 4102, 12, 24, 10), -- Light Crystal
    (1859, 6, 8, 0, 1225, 4, 8, 10), -- Gold Nugget
    (1860, 6, 8, 0, 4274, 4, 8, 10), -- Persikos
    (1861, 6, 8, 0, 1238, 1, 2, 14), -- Tree Saplings
    (1862, 6, 8, 0, 845, 4, 8, 10), -- Black Chocobo Feather
    (1863, 6, 8, 0, 1228, 4, 12, 10), -- Darksteel Nugget
    (1864, 6, 8, 1, 936, 12, 24, 20), -- Rock Salt
    (1865, 6, 8, 1, 4097, 12, 24, 10), -- Ice Crystal
    (1866, 6, 8, 1, 4102, 12, 24, 10), -- Light Crystal
    (1867, 6, 8, 1, 1231, 12, 24, 10), -- Brass Nugget
    (1868, 6, 8, 1, 4274, 4, 8, 10), -- Persikos
    (1869, 6, 8, 1, 941, 8, 16, 10), -- Red Rose
    (1870, 6, 8, 1, 845, 4, 8, 10), -- Black Chocobo Feather
    (1871, 6, 8, 1, 751, 1, 5, 10), -- Platinum Beastcoin
    (1872, 6, 8, 1, 1228, 4, 12, 10), -- Darksteel Nugget
    (1873, 6, 8, 2, 17396, 12, 24, 15), -- Little Worm
    (1874, 6, 8, 2, 936, 12, 24, 10), -- Rock Salt
    (1875, 6, 8, 2, 4098, 12, 24, 15), -- Wind Crystal
    (1876, 6, 8, 2, 4102, 12, 24, 10), -- Light Crystal
    (1877, 6, 8, 2, 920, 4, 8, 10), -- Malboro Vine
    (1878, 6, 8, 2, 4274, 4, 8, 10), -- Persikos
    (1879, 6, 8, 2, 1235, 4, 12, 10), -- Steel Nugget
    (1880, 6, 8, 2, 845, 4, 8, 10), -- Black Chocobo Feather
    (1881, 6, 8, 2, 1228, 4, 12, 10), -- Darksteel Nugget
    (1882, 6, 8, 3, 936, 12, 24, 25), -- Rock Salt
    (1883, 6, 8, 3, 4099, 12, 24, 15), -- Earth Crystal
    (1884, 6, 8, 3, 4102, 12, 24, 10), -- Light Crystal
    (1885, 6, 8, 3, 1230, 8, 16, 10), -- Copper Nugget
    (1886, 6, 8, 3, 4274, 4, 8, 10), -- Persikos
    (1887, 6, 8, 3, 748, 1, 5, 10), -- Gold Beastcoin
    (1888, 6, 8, 3, 845, 4, 8, 10), -- Black Chocobo Feather
    (1889, 6, 8, 3, 1228, 4, 12, 10), -- Darksteel Nugget
    (1890, 6, 8, 4, 936, 12, 24, 20), -- Rock Salt
    (1891, 6, 8, 4, 4100, 12, 24, 10), -- Lightning Crystal
    (1892, 6, 8, 4, 4102, 12, 24, 10), -- Light Crystal
    (1893, 6, 8, 4, 841, 4, 12, 10), -- Yagudo Feather
    (1894, 6, 8, 4, 4274, 4, 8, 10), -- Persikos
    (1895, 6, 8, 4, 839, 4, 8, 10), -- Crawler Cocoon
    (1896, 6, 8, 4, 845, 4, 8, 10), -- Black Chocobo Feather
    (1897, 6, 8, 4, 1234, 4, 12, 10), -- Iron Nugget
    (1898, 6, 8, 4, 1228, 4, 12, 10), -- Darksteel Nugget
    (1899, 6, 8, 5, 936, 12, 24, 20), -- Rock Salt
    (1900, 6, 8, 5, 4101, 12, 24, 10), -- Water Crystal
    (1901, 6, 8, 5, 4102, 12, 24, 10), -- Light Crystal
    (1902, 6, 8, 5, 1233, 4, 12, 10), -- Silver Nugget
    (1903, 6, 8, 5, 4274, 4, 8, 10), -- Persikos
    (1904, 6, 8, 5, 918, 1, 2, 10), -- Mistletoe
    (1905, 6, 8, 5, 845, 4, 8, 10), -- Black Chocobo Feather
    (1906, 6, 8, 5, 749, 1, 5, 10), -- Mythril Beastcoin
    (1907, 6, 8, 5, 1228, 4, 12, 10), -- Darksteel Nugget
    (1908, 6, 8, 6, 936, 12, 24, 20), -- Rock Salt
    (1909, 6, 8, 6, 4096, 12, 24, 10), -- Fire Crystal
    (1910, 6, 8, 6, 4102, 12, 24, 10), -- Light Crystal
    (1911, 6, 8, 6, 1232, 8, 16, 10), -- Bronze Nugget
    (1912, 6, 8, 6, 4274, 4, 8, 10), -- Persikos
    (1913, 6, 8, 6, 750, 4, 8, 10), -- Silver Beastcoin
    (1914, 6, 8, 6, 845, 4, 8, 10), -- Black Chocobo Feather
    (1915, 6, 8, 6, 1226, 4, 12, 10), -- Mythril Nugget
    (1916, 6, 8, 6, 1228, 4, 12, 10), -- Darksteel Nugget
    (1917, 6, 8, 7, 936, 12, 24, 20), -- Rock Salt
    (1918, 6, 8, 7, 4103, 12, 24, 10), -- Dark Crystal
    (1919, 6, 8, 7, 4102, 12, 24, 10), -- Light Crystal
    (1920, 6, 8, 7, 4570, 4, 12, 10), -- Bird Egg
    (1921, 6, 8, 7, 4274, 4, 8, 10), -- Persikos
    (1922, 6, 8, 7, 842, 1, 5, 10), -- Giant Bird Feather
    (1923, 6, 8, 7, 845, 4, 8, 10), -- Black Chocobo Feather
    (1924, 6, 8, 7, 1227, 4, 12, 10), -- Platinum Nugget
    (1925, 6, 8, 7, 1228, 4, 12, 10), -- Darksteel Nugget
    (1926, 6, 8, 8, 936, 12, 24, 20), -- Rock Salt
    (1927, 6, 8, 8, 4102, 12, 24, 20), -- Light Crystal
    (1928, 6, 8, 8, 4274, 4, 8, 20), -- Persikos
    (1929, 6, 8, 8, 845, 4, 8, 20), -- Black Chocobo Feather
    (1930, 6, 8, 8, 1228, 4, 12, 20), -- Darksteel Nugget
    (1931, 7, 0, 0, 936, 12, 24, 30), -- Rock Salt
    (1932, 7, 0, 0, 4449, 1, 2, 30), -- Reishi Mushroom
    (1933, 7, 0, 0, 1309, 4, 12, 28), -- Gold Leaf
    (1934, 7, 0, 0, 1261, 1, 2, 12), -- Light Ore
    (1935, 7, 0, 1, 936, 12, 24, 15), -- Rock Salt
    (1936, 7, 0, 1, 4105, 1, 2, 24), -- Ice Cluster
    (1937, 7, 0, 1, 4449, 1, 2, 15), -- Reishi Mushroom
    (1938, 7, 0, 1, 628, 1, 2, 20), -- Cinnamon
    (1939, 7, 0, 1, 1309, 4, 12, 14), -- Gold Leaf
    (1940, 7, 0, 1, 1255, 1, 2, 6), -- Fire Ore
    (1941, 7, 0, 1, 1261, 1, 2, 6), -- Light Ore
    (1942, 7, 0, 2, 936, 12, 24, 15), -- Rock Salt
    (1943, 7, 0, 2, 4106, 1, 2, 24), -- Wind Cluster
    (1944, 7, 0, 2, 4449, 1, 2, 15), -- Reishi Mushroom
    (1945, 7, 0, 2, 1310, 6, 12, 20), -- Platinum Leaf
    (1946, 7, 0, 2, 1309, 4, 12, 14), -- Gold Leaf
    (1947, 7, 0, 2, 1256, 1, 2, 6), -- Ice Ore
    (1948, 7, 0, 2, 1261, 1, 2, 6), -- Light Ore
    (1949, 7, 0, 3, 936, 12, 24, 15), -- Rock Salt
    (1950, 7, 0, 3, 4107, 1, 2, 24), -- Earth Cluster
    (1951, 7, 0, 3, 4449, 1, 2, 15), -- Reishi Mushroom
    (1952, 7, 0, 3, 635, 24, 48, 20), -- Clump Of Windurstian Tea Leaves
    (1953, 7, 0, 3, 1309, 4, 12, 14), -- Gold Leaf
    (1954, 7, 0, 3, 1257, 1, 2, 6), -- Wind Ore
    (1955, 7, 0, 3, 1261, 1, 2, 6), -- Light Ore
    (1956, 7, 0, 4, 936, 12, 24, 15), -- Rock Salt
    (1957, 7, 0, 4, 4108, 1, 2, 24), -- Lightning Cluster
    (1958, 7, 0, 4, 4449, 1, 2, 15), -- Reishi Mushroom
    (1959, 7, 0, 4, 4273, 8, 16, 20), -- Kitron
    (1960, 7, 0, 4, 1309, 4, 12, 14), -- Gold Leaf
    (1961, 7, 0, 4, 1258, 1, 2, 6), -- Earth Ore
    (1962, 7, 0, 4, 1261, 1, 2, 6), -- Light Ore
    (1963, 7, 0, 5, 936, 12, 24, 15), -- Rock Salt
    (1964, 7, 0, 5, 4109, 1, 2, 24), -- Water Cluster
    (1965, 7, 0, 5, 4449, 1, 2, 15), -- Reishi Mushroom
    (1966, 7, 0, 5, 1307, 8, 16, 20), -- Silver Leaf
    (1967, 7, 0, 5, 1309, 4, 12, 14), -- Gold Leaf
    (1968, 7, 0, 5, 1259, 1, 2, 6), -- Lightning Ore
    (1969, 7, 0, 5, 1261, 1, 2, 6), -- Light Ore
    (1970, 7, 0, 6, 936, 12, 24, 15), -- Rock Salt
    (1971, 7, 0, 6, 4104, 1, 2, 24), -- Fire Cluster
    (1972, 7, 0, 6, 4449, 1, 2, 15), -- Reishi Mushroom
    (1973, 7, 0, 6, 1308, 6, 12, 20), -- Mythril Leaf
    (1974, 7, 0, 6, 1309, 4, 12, 14), -- Gold Leaf
    (1975, 7, 0, 6, 1260, 1, 2, 6), -- Water Ore
    (1976, 7, 0, 6, 1261, 1, 2, 6), -- Light Ore
    (1977, 7, 0, 7, 936, 12, 24, 15), -- Rock Salt
    (1978, 7, 0, 7, 17397, 24, 48, 15), -- Shell Bug
    (1979, 7, 0, 7, 4449, 1, 2, 15), -- Reishi Mushroom
    (1980, 7, 0, 7, 4111, 1, 2, 15), -- Dark Cluster
    (1981, 7, 0, 7, 1309, 4, 12, 34), -- Gold Leaf
    (1982, 7, 0, 7, 1261, 1, 2, 6), -- Light Ore
    (1983, 7, 0, 8, 936, 12, 24, 30), -- Rock Salt
    (1984, 7, 0, 8, 4449, 1, 2, 15), -- Reishi Mushroom
    (1985, 7, 0, 8, 4110, 1, 2, 15), -- Light Cluster
    (1986, 7, 0, 8, 1309, 4, 12, 14), -- Gold Leaf
    (1987, 7, 0, 8, 4274, 4, 8, 14), -- Persikos
    (1988, 7, 0, 8, 1261, 1, 2, 6), -- Light Ore
    (1989, 7, 0, 8, 1262, 1, 2, 6), -- Dark Ore
    (1990, 7, 1, 0, 936, 12, 24, 15), -- Rock Salt
    (1991, 7, 1, 0, 4105, 1, 2, 24), -- Ice Cluster
    (1992, 7, 1, 0, 4449, 1, 2, 15), -- Reishi Mushroom
    (1993, 7, 1, 0, 628, 1, 2, 20), -- Cinnamon
    (1994, 7, 1, 0, 1309, 4, 12, 14), -- Gold Leaf
    (1995, 7, 1, 0, 1255, 1, 2, 6), -- Fire Ore
    (1996, 7, 1, 0, 1261, 1, 2, 6), -- Light Ore
    (1997, 7, 1, 1, 4105, 1, 2, 48), -- Ice Cluster
    (1998, 7, 1, 1, 628, 1, 2, 40), -- Cinnamon
    (1999, 7, 1, 1, 1255, 1, 2, 12), -- Fire Ore
    (2000, 7, 1, 2, 4105, 1, 2, 24), -- Ice Cluster
    (2001, 7, 1, 2, 4106, 1, 2, 24), -- Wind Cluster
    (2002, 7, 1, 2, 628, 1, 2, 20), -- Cinnamon
    (2003, 7, 1, 2, 1310, 6, 12, 20), -- Platinum Leaf
    (2004, 7, 1, 2, 1255, 1, 2, 6), -- Fire Ore
    (2005, 7, 1, 2, 1256, 1, 2, 6), -- Ice Ore
    (2006, 7, 1, 3, 4105, 1, 2, 24), -- Ice Cluster
    (2007, 7, 1, 3, 4107, 1, 2, 24), -- Earth Cluster
    (2008, 7, 1, 3, 628, 1, 2, 20), -- Cinnamon
    (2009, 7, 1, 3, 635, 24, 48, 20), -- Clump Of Windurstian Tea Leaves
    (2010, 7, 1, 3, 1255, 1, 2, 6), -- Fire Ore
    (2011, 7, 1, 3, 1257, 1, 2, 6), -- Wind Ore
    (2012, 7, 1, 4, 4105, 1, 2, 24), -- Ice Cluster
    (2013, 7, 1, 4, 4108, 1, 2, 24), -- Lightning Cluster
    (2014, 7, 1, 4, 628, 1, 2, 20), -- Cinnamon
    (2015, 7, 1, 4, 4273, 8, 16, 20), -- Kitron
    (2016, 7, 1, 4, 1255, 1, 2, 6), -- Fire Ore
    (2017, 7, 1, 4, 1258, 1, 2, 6), -- Earth Ore
    (2018, 7, 1, 5, 4105, 1, 2, 24), -- Ice Cluster
    (2019, 7, 1, 5, 4109, 1, 2, 24), -- Water Cluster
    (2020, 7, 1, 5, 628, 1, 2, 20), -- Cinnamon
    (2021, 7, 1, 5, 1307, 8, 16, 20), -- Silver Leaf
    (2022, 7, 1, 5, 1255, 1, 2, 6), -- Fire Ore
    (2023, 7, 1, 5, 1259, 1, 2, 6), -- Lightning Ore
    (2024, 7, 1, 6, 4105, 1, 2, 24), -- Ice Cluster
    (2025, 7, 1, 6, 4104, 1, 2, 24), -- Fire Cluster
    (2026, 7, 1, 6, 628, 1, 2, 20), -- Cinnamon
    (2027, 7, 1, 6, 1308, 6, 12, 20), -- Mythril Leaf
    (2028, 7, 1, 6, 1255, 1, 2, 6), -- Fire Ore
    (2029, 7, 1, 6, 1260, 1, 2, 6), -- Water Ore
    (2030, 7, 1, 7, 4105, 1, 2, 24), -- Ice Cluster
    (2031, 7, 1, 7, 17397, 24, 48, 15), -- Shell Bug
    (2032, 7, 1, 7, 628, 1, 2, 20), -- Cinnamon
    (2033, 7, 1, 7, 4111, 1, 2, 15), -- Dark Cluster
    (2034, 7, 1, 7, 1255, 1, 2, 6), -- Fire Ore
    (2035, 7, 1, 7, 1309, 4, 12, 20), -- Gold Leaf
    (2036, 7, 1, 8, 4105, 1, 2, 24), -- Ice Cluster
    (2037, 7, 1, 8, 936, 12, 24, 15), -- Rock Salt
    (2038, 7, 1, 8, 628, 1, 2, 20), -- Cinnamon
    (2039, 7, 1, 8, 4110, 1, 2, 15), -- Light Cluster
    (2040, 7, 1, 8, 1255, 1, 2, 6), -- Fire Ore
    (2041, 7, 1, 8, 4274, 4, 8, 14), -- Persikos
    (2042, 7, 1, 8, 1262, 1, 2, 6), -- Dark Ore
    (2043, 7, 2, 0, 936, 12, 24, 15), -- Rock Salt
    (2044, 7, 2, 0, 4106, 1, 2, 24), -- Wind Cluster
    (2045, 7, 2, 0, 4449, 1, 2, 15), -- Reishi Mushroom
    (2046, 7, 2, 0, 1310, 6, 12, 20), -- Platinum Leaf
    (2047, 7, 2, 0, 1309, 4, 12, 14), -- Gold Leaf
    (2048, 7, 2, 0, 1256, 1, 2, 6), -- Ice Ore
    (2049, 7, 2, 0, 1261, 1, 2, 6), -- Light Ore
    (2050, 7, 2, 1, 4105, 1, 2, 24), -- Ice Cluster
    (2051, 7, 2, 1, 4106, 1, 2, 24), -- Wind Cluster
    (2052, 7, 2, 1, 628, 1, 2, 20), -- Cinnamon
    (2053, 7, 2, 1, 1310, 6, 12, 20), -- Platinum Leaf
    (2054, 7, 2, 1, 1255, 1, 2, 6), -- Fire Ore
    (2055, 7, 2, 1, 1256, 1, 2, 6), -- Ice Ore
    (2056, 7, 2, 2, 4106, 1, 2, 48), -- Wind Cluster
    (2057, 7, 2, 2, 1310, 6, 12, 40), -- Platinum Leaf
    (2058, 7, 2, 2, 1256, 1, 2, 12), -- Ice Ore
    (2059, 7, 2, 3, 4106, 1, 2, 24), -- Wind Cluster
    (2060, 7, 2, 3, 4107, 1, 2, 24), -- Earth Cluster
    (2061, 7, 2, 3, 1310, 6, 12, 20), -- Platinum Leaf
    (2062, 7, 2, 3, 635, 24, 48, 20), -- Clump Of Windurstian Tea Leaves
    (2063, 7, 2, 3, 1256, 1, 2, 6), -- Ice Ore
    (2064, 7, 2, 3, 1257, 1, 2, 6), -- Wind Ore
    (2065, 7, 2, 4, 4106, 1, 2, 24), -- Wind Cluster
    (2066, 7, 2, 4, 4108, 1, 2, 24), -- Lightning Cluster
    (2067, 7, 2, 4, 1310, 6, 12, 20), -- Platinum Leaf
    (2068, 7, 2, 4, 4273, 8, 16, 20), -- Kitron
    (2069, 7, 2, 4, 1256, 1, 2, 6), -- Ice Ore
    (2070, 7, 2, 4, 1258, 1, 2, 6), -- Earth Ore
    (2071, 7, 2, 5, 4106, 1, 2, 24), -- Wind Cluster
    (2072, 7, 2, 5, 4109, 1, 2, 24), -- Water Cluster
    (2073, 7, 2, 5, 1310, 6, 12, 20), -- Platinum Leaf
    (2074, 7, 2, 5, 1307, 8, 16, 20), -- Silver Leaf
    (2075, 7, 2, 5, 1256, 1, 2, 6), -- Ice Ore
    (2076, 7, 2, 5, 1259, 1, 2, 6), -- Lightning Ore
    (2077, 7, 2, 6, 4106, 1, 2, 24), -- Wind Cluster
    (2078, 7, 2, 6, 4104, 1, 2, 24), -- Fire Cluster
    (2079, 7, 2, 6, 1310, 6, 12, 20), -- Platinum Leaf
    (2080, 7, 2, 6, 1308, 6, 12, 20), -- Mythril Leaf
    (2081, 7, 2, 6, 1256, 1, 2, 6), -- Ice Ore
    (2082, 7, 2, 6, 1260, 1, 2, 6), -- Water Ore
    (2083, 7, 2, 7, 4106, 1, 2, 24), -- Wind Cluster
    (2084, 7, 2, 7, 17397, 24, 48, 15), -- Shell Bug
    (2085, 7, 2, 7, 1310, 6, 12, 20), -- Platinum Leaf
    (2086, 7, 2, 7, 4111, 1, 2, 15), -- Dark Cluster
    (2087, 7, 2, 7, 1256, 1, 2, 6), -- Ice Ore
    (2088, 7, 2, 7, 1309, 4, 12, 20), -- Gold Leaf
    (2089, 7, 2, 8, 4106, 1, 2, 24), -- Wind Cluster
    (2090, 7, 2, 8, 936, 12, 24, 15), -- Rock Salt
    (2091, 7, 2, 8, 1310, 6, 12, 20), -- Platinum Leaf
    (2092, 7, 2, 8, 4110, 1, 2, 15), -- Light Cluster
    (2093, 7, 2, 8, 1256, 1, 2, 6), -- Ice Ore
    (2094, 7, 2, 8, 4274, 4, 8, 14), -- Persikos
    (2095, 7, 2, 8, 1262, 1, 2, 6), -- Dark Ore
    (2096, 7, 3, 0, 936, 12, 24, 15), -- Rock Salt
    (2097, 7, 3, 0, 4107, 1, 2, 24), -- Earth Cluster
    (2098, 7, 3, 0, 4449, 1, 2, 15), -- Reishi Mushroom
    (2099, 7, 3, 0, 635, 24, 48, 20), -- Clump Of Windurstian Tea Leaves
    (2100, 7, 3, 0, 1309, 4, 12, 14), -- Gold Leaf
    (2101, 7, 3, 0, 1257, 1, 2, 6), -- Wind Ore
    (2102, 7, 3, 0, 1261, 1, 2, 6), -- Light Ore
    (2103, 7, 3, 1, 4105, 1, 2, 24), -- Ice Cluster
    (2104, 7, 3, 1, 4107, 1, 2, 24), -- Earth Cluster
    (2105, 7, 3, 1, 628, 1, 2, 20), -- Cinnamon
    (2106, 7, 3, 1, 635, 24, 48, 20), -- Clump Of Windurstian Tea Leaves
    (2107, 7, 3, 1, 1255, 1, 2, 6), -- Fire Ore
    (2108, 7, 3, 1, 1257, 1, 2, 6), -- Wind Ore
    (2109, 7, 3, 2, 4106, 1, 2, 24), -- Wind Cluster
    (2110, 7, 3, 2, 4107, 1, 2, 24), -- Earth Cluster
    (2111, 7, 3, 2, 1310, 6, 12, 20), -- Platinum Leaf
    (2112, 7, 3, 2, 635, 24, 48, 20), -- Clump Of Windurstian Tea Leaves
    (2113, 7, 3, 2, 1256, 1, 2, 6), -- Ice Ore
    (2114, 7, 3, 2, 1257, 1, 2, 6), -- Wind Ore
    (2115, 7, 3, 3, 4107, 1, 2, 48), -- Earth Cluster
    (2116, 7, 3, 3, 635, 24, 48, 40), -- Clump Of Windurstian Tea Leaves
    (2117, 7, 3, 3, 1257, 1, 2, 12), -- Wind Ore
    (2118, 7, 3, 4, 4107, 1, 2, 24), -- Earth Cluster
    (2119, 7, 3, 4, 4108, 1, 2, 24), -- Lightning Cluster
    (2120, 7, 3, 4, 635, 24, 48, 20), -- Clump Of Windurstian Tea Leaves
    (2121, 7, 3, 4, 4273, 8, 16, 20), -- Kitron
    (2122, 7, 3, 4, 1257, 1, 2, 6), -- Wind Ore
    (2123, 7, 3, 4, 1258, 1, 2, 6), -- Earth Ore
    (2124, 7, 3, 5, 4107, 1, 2, 24), -- Earth Cluster
    (2125, 7, 3, 5, 4109, 1, 2, 24), -- Water Cluster
    (2126, 7, 3, 5, 635, 24, 48, 20), -- Clump Of Windurstian Tea Leaves
    (2127, 7, 3, 5, 1307, 8, 16, 20), -- Silver Leaf
    (2128, 7, 3, 5, 1257, 1, 2, 6), -- Wind Ore
    (2129, 7, 3, 5, 1259, 1, 2, 6), -- Lightning Ore
    (2130, 7, 3, 6, 4107, 1, 2, 24), -- Earth Cluster
    (2131, 7, 3, 6, 4104, 1, 2, 24), -- Fire Cluster
    (2132, 7, 3, 6, 635, 24, 48, 20), -- Clump Of Windurstian Tea Leaves
    (2133, 7, 3, 6, 1308, 6, 12, 20), -- Mythril Leaf
    (2134, 7, 3, 6, 1257, 1, 2, 6), -- Wind Ore
    (2135, 7, 3, 6, 1260, 1, 2, 6), -- Water Ore
    (2136, 7, 3, 7, 4107, 1, 2, 24), -- Earth Cluster
    (2137, 7, 3, 7, 17397, 24, 48, 15), -- Shell Bug
    (2138, 7, 3, 7, 635, 24, 48, 20), -- Clump Of Windurstian Tea Leaves
    (2139, 7, 3, 7, 4111, 1, 2, 15), -- Dark Cluster
    (2140, 7, 3, 7, 1257, 1, 2, 6), -- Wind Ore
    (2141, 7, 3, 7, 1309, 4, 12, 20), -- Gold Leaf
    (2142, 7, 3, 8, 4107, 1, 2, 24), -- Earth Cluster
    (2143, 7, 3, 8, 936, 12, 24, 15), -- Rock Salt
    (2144, 7, 3, 8, 635, 24, 48, 20), -- Clump Of Windurstian Tea Leaves
    (2145, 7, 3, 8, 4110, 1, 2, 15), -- Light Cluster
    (2146, 7, 3, 8, 1257, 1, 2, 6), -- Wind Ore
    (2147, 7, 3, 8, 4274, 4, 8, 14), -- Persikos
    (2148, 7, 3, 8, 1262, 1, 2, 6), -- Dark Ore
    (2149, 7, 4, 0, 936, 12, 24, 15), -- Rock Salt
    (2150, 7, 4, 0, 4108, 1, 2, 24), -- Lightning Cluster
    (2151, 7, 4, 0, 4449, 1, 2, 15), -- Reishi Mushroom
    (2152, 7, 4, 0, 4273, 8, 16, 20), -- Kitron
    (2153, 7, 4, 0, 1309, 4, 12, 14), -- Gold Leaf
    (2154, 7, 4, 0, 1258, 1, 2, 6), -- Earth Ore
    (2155, 7, 4, 0, 1261, 1, 2, 6), -- Light Ore
    (2156, 7, 4, 1, 4105, 1, 2, 24), -- Ice Cluster
    (2157, 7, 4, 1, 4108, 1, 2, 24), -- Lightning Cluster
    (2158, 7, 4, 1, 628, 1, 2, 20), -- Cinnamon
    (2159, 7, 4, 1, 4273, 8, 16, 20), -- Kitron
    (2160, 7, 4, 1, 1255, 1, 2, 6), -- Fire Ore
    (2161, 7, 4, 1, 1258, 1, 2, 6), -- Earth Ore
    (2162, 7, 4, 2, 4106, 1, 2, 24), -- Wind Cluster
    (2163, 7, 4, 2, 4108, 1, 2, 24), -- Lightning Cluster
    (2164, 7, 4, 2, 1310, 6, 12, 20), -- Platinum Leaf
    (2165, 7, 4, 2, 4273, 8, 16, 20), -- Kitron
    (2166, 7, 4, 2, 1256, 1, 2, 6), -- Ice Ore
    (2167, 7, 4, 2, 1258, 1, 2, 6), -- Earth Ore
    (2168, 7, 4, 3, 4107, 1, 2, 24), -- Earth Cluster
    (2169, 7, 4, 3, 4108, 1, 2, 24), -- Lightning Cluster
    (2170, 7, 4, 3, 635, 24, 48, 20), -- Clump Of Windurstian Tea Leaves
    (2171, 7, 4, 3, 4273, 8, 16, 20), -- Kitron
    (2172, 7, 4, 3, 1257, 1, 2, 6), -- Wind Ore
    (2173, 7, 4, 3, 1258, 1, 2, 6), -- Earth Ore
    (2174, 7, 4, 4, 4108, 1, 2, 48), -- Lightning Cluster
    (2175, 7, 4, 4, 4273, 8, 16, 40), -- Kitron
    (2176, 7, 4, 4, 1258, 1, 2, 12), -- Earth Ore
    (2177, 7, 4, 5, 4108, 1, 2, 24), -- Lightning Cluster
    (2178, 7, 4, 5, 4109, 1, 2, 24), -- Water Cluster
    (2179, 7, 4, 5, 4273, 8, 16, 20), -- Kitron
    (2180, 7, 4, 5, 1307, 8, 16, 20), -- Silver Leaf
    (2181, 7, 4, 5, 1258, 1, 2, 6), -- Earth Ore
    (2182, 7, 4, 5, 1259, 1, 2, 6), -- Lightning Ore
    (2183, 7, 4, 6, 4108, 1, 2, 24), -- Lightning Cluster
    (2184, 7, 4, 6, 4104, 1, 2, 24), -- Fire Cluster
    (2185, 7, 4, 6, 4273, 8, 16, 20), -- Kitron
    (2186, 7, 4, 6, 1308, 6, 12, 20), -- Mythril Leaf
    (2187, 7, 4, 6, 1258, 1, 2, 6), -- Earth Ore
    (2188, 7, 4, 6, 1260, 1, 2, 6), -- Water Ore
    (2189, 7, 4, 7, 4108, 1, 2, 24), -- Lightning Cluster
    (2190, 7, 4, 7, 17397, 24, 48, 15), -- Shell Bug
    (2191, 7, 4, 7, 4273, 8, 16, 20), -- Kitron
    (2192, 7, 4, 7, 4111, 1, 2, 15), -- Dark Cluster
    (2193, 7, 4, 7, 1258, 1, 2, 6), -- Earth Ore
    (2194, 7, 4, 7, 1309, 4, 12, 20), -- Gold Leaf
    (2195, 7, 4, 8, 4108, 1, 2, 24), -- Lightning Cluster
    (2196, 7, 4, 8, 936, 12, 24, 15), -- Rock Salt
    (2197, 7, 4, 8, 4273, 8, 16, 20), -- Kitron
    (2198, 7, 4, 8, 4110, 1, 2, 15), -- Light Cluster
    (2199, 7, 4, 8, 1258, 1, 2, 6), -- Earth Ore
    (2200, 7, 4, 8, 4274, 4, 8, 14), -- Persikos
    (2201, 7, 4, 8, 1262, 1, 2, 6), -- Dark Ore
    (2202, 7, 5, 0, 936, 12, 24, 15), -- Rock Salt
    (2203, 7, 5, 0, 4109, 1, 2, 24), -- Water Cluster
    (2204, 7, 5, 0, 4449, 1, 2, 15), -- Reishi Mushroom
    (2205, 7, 5, 0, 1307, 8, 16, 20), -- Silver Leaf
    (2206, 7, 5, 0, 1309, 4, 12, 14), -- Gold Leaf
    (2207, 7, 5, 0, 1259, 1, 2, 6), -- Lightning Ore
    (2208, 7, 5, 0, 1261, 1, 2, 6), -- Light Ore
    (2209, 7, 5, 1, 4105, 1, 2, 24), -- Ice Cluster
    (2210, 7, 5, 1, 4109, 1, 2, 24), -- Water Cluster
    (2211, 7, 5, 1, 628, 1, 2, 20), -- Cinnamon
    (2212, 7, 5, 1, 1307, 8, 16, 20), -- Silver Leaf
    (2213, 7, 5, 1, 1255, 1, 2, 6), -- Fire Ore
    (2214, 7, 5, 1, 1259, 1, 2, 6), -- Lightning Ore
    (2215, 7, 5, 2, 4106, 1, 2, 24), -- Wind Cluster
    (2216, 7, 5, 2, 4109, 1, 2, 24), -- Water Cluster
    (2217, 7, 5, 2, 1310, 6, 12, 20), -- Platinum Leaf
    (2218, 7, 5, 2, 1307, 8, 16, 20), -- Silver Leaf
    (2219, 7, 5, 2, 1256, 1, 2, 6), -- Ice Ore
    (2220, 7, 5, 2, 1259, 1, 2, 6), -- Lightning Ore
    (2221, 7, 5, 3, 4107, 1, 2, 24), -- Earth Cluster
    (2222, 7, 5, 3, 4109, 1, 2, 24), -- Water Cluster
    (2223, 7, 5, 3, 635, 24, 48, 20), -- Clump Of Windurstian Tea Leaves
    (2224, 7, 5, 3, 1307, 8, 16, 20), -- Silver Leaf
    (2225, 7, 5, 3, 1257, 1, 2, 6), -- Wind Ore
    (2226, 7, 5, 3, 1259, 1, 2, 6), -- Lightning Ore
    (2227, 7, 5, 4, 4108, 1, 2, 24), -- Lightning Cluster
    (2228, 7, 5, 4, 4109, 1, 2, 24), -- Water Cluster
    (2229, 7, 5, 4, 4273, 8, 16, 20), -- Kitron
    (2230, 7, 5, 4, 1307, 8, 16, 20), -- Silver Leaf
    (2231, 7, 5, 4, 1258, 1, 2, 6), -- Earth Ore
    (2232, 7, 5, 4, 1259, 1, 2, 6), -- Lightning Ore
    (2233, 7, 5, 5, 4109, 1, 2, 48), -- Water Cluster
    (2234, 7, 5, 5, 1307, 8, 16, 40), -- Silver Leaf
    (2235, 7, 5, 5, 1259, 1, 2, 12), -- Lightning Ore
    (2236, 7, 5, 6, 4109, 1, 2, 24), -- Water Cluster
    (2237, 7, 5, 6, 4104, 1, 2, 24), -- Fire Cluster
    (2238, 7, 5, 6, 1307, 8, 16, 20), -- Silver Leaf
    (2239, 7, 5, 6, 1308, 6, 12, 20), -- Mythril Leaf
    (2240, 7, 5, 6, 1259, 1, 2, 6), -- Lightning Ore
    (2241, 7, 5, 6, 1260, 1, 2, 6), -- Water Ore
    (2242, 7, 5, 7, 4109, 1, 2, 24), -- Water Cluster
    (2243, 7, 5, 7, 17397, 24, 48, 15), -- Shell Bug
    (2244, 7, 5, 7, 1307, 8, 16, 20), -- Silver Leaf
    (2245, 7, 5, 7, 4111, 1, 2, 15), -- Dark Cluster
    (2246, 7, 5, 7, 1259, 1, 2, 6), -- Lightning Ore
    (2247, 7, 5, 7, 1309, 4, 12, 20), -- Gold Leaf
    (2248, 7, 5, 8, 4109, 1, 2, 24), -- Water Cluster
    (2249, 7, 5, 8, 936, 12, 24, 15), -- Rock Salt
    (2250, 7, 5, 8, 1307, 8, 16, 20), -- Silver Leaf
    (2251, 7, 5, 8, 4110, 1, 2, 15), -- Light Cluster
    (2252, 7, 5, 8, 1259, 1, 2, 6), -- Lightning Ore
    (2253, 7, 5, 8, 4274, 4, 8, 14), -- Persikos
    (2254, 7, 5, 8, 1262, 1, 2, 6), -- Dark Ore
    (2255, 7, 6, 0, 936, 12, 24, 15), -- Rock Salt
    (2256, 7, 6, 0, 4104, 1, 2, 24), -- Fire Cluster
    (2257, 7, 6, 0, 4449, 1, 2, 15), -- Reishi Mushroom
    (2258, 7, 6, 0, 1308, 6, 12, 20), -- Mythril Leaf
    (2259, 7, 6, 0, 1309, 4, 12, 14), -- Gold Leaf
    (2260, 7, 6, 0, 1260, 1, 2, 6), -- Water Ore
    (2261, 7, 6, 0, 1261, 1, 2, 6), -- Light Ore
    (2262, 7, 6, 1, 4105, 1, 2, 24), -- Ice Cluster
    (2263, 7, 6, 1, 4104, 1, 2, 24), -- Fire Cluster
    (2264, 7, 6, 1, 628, 1, 2, 20), -- Cinnamon
    (2265, 7, 6, 1, 1308, 6, 12, 20), -- Mythril Leaf
    (2266, 7, 6, 1, 1255, 1, 2, 6), -- Fire Ore
    (2267, 7, 6, 1, 1260, 1, 2, 6), -- Water Ore
    (2268, 7, 6, 2, 4106, 1, 2, 24), -- Wind Cluster
    (2269, 7, 6, 2, 4104, 1, 2, 24), -- Fire Cluster
    (2270, 7, 6, 2, 1310, 6, 12, 20), -- Platinum Leaf
    (2271, 7, 6, 2, 1308, 6, 12, 20), -- Mythril Leaf
    (2272, 7, 6, 2, 1256, 1, 2, 6), -- Ice Ore
    (2273, 7, 6, 2, 1260, 1, 2, 6), -- Water Ore
    (2274, 7, 6, 3, 4107, 1, 2, 24), -- Earth Cluster
    (2275, 7, 6, 3, 4104, 1, 2, 24), -- Fire Cluster
    (2276, 7, 6, 3, 635, 24, 48, 20), -- Clump Of Windurstian Tea Leaves
    (2277, 7, 6, 3, 1308, 6, 12, 20), -- Mythril Leaf
    (2278, 7, 6, 3, 1257, 1, 2, 6), -- Wind Ore
    (2279, 7, 6, 3, 1260, 1, 2, 6), -- Water Ore
    (2280, 7, 6, 4, 4108, 1, 2, 24), -- Lightning Cluster
    (2281, 7, 6, 4, 4104, 1, 2, 24), -- Fire Cluster
    (2282, 7, 6, 4, 4273, 8, 16, 20), -- Kitron
    (2283, 7, 6, 4, 1308, 6, 12, 20), -- Mythril Leaf
    (2284, 7, 6, 4, 1258, 1, 2, 6), -- Earth Ore
    (2285, 7, 6, 4, 1260, 1, 2, 6), -- Water Ore
    (2286, 7, 6, 5, 4109, 1, 2, 24), -- Water Cluster
    (2287, 7, 6, 5, 4104, 1, 2, 24), -- Fire Cluster
    (2288, 7, 6, 5, 1307, 8, 16, 20), -- Silver Leaf
    (2289, 7, 6, 5, 1308, 6, 12, 20), -- Mythril Leaf
    (2290, 7, 6, 5, 1259, 1, 2, 6), -- Lightning Ore
    (2291, 7, 6, 5, 1260, 1, 2, 6), -- Water Ore
    (2292, 7, 6, 6, 4104, 1, 2, 48), -- Fire Cluster
    (2293, 7, 6, 6, 1308, 6, 12, 40), -- Mythril Leaf
    (2294, 7, 6, 6, 1260, 1, 2, 12), -- Water Ore
    (2295, 7, 6, 7, 4104, 1, 2, 24), -- Fire Cluster
    (2296, 7, 6, 7, 17397, 24, 48, 15), -- Shell Bug
    (2297, 7, 6, 7, 1308, 6, 12, 20), -- Mythril Leaf
    (2298, 7, 6, 7, 4111, 1, 2, 15), -- Dark Cluster
    (2299, 7, 6, 7, 1260, 1, 2, 6), -- Water Ore
    (2300, 7, 6, 7, 1309, 4, 12, 20), -- Gold Leaf
    (2301, 7, 6, 8, 4104, 1, 2, 24), -- Fire Cluster
    (2302, 7, 6, 8, 936, 12, 24, 15), -- Rock Salt
    (2303, 7, 6, 8, 1308, 6, 12, 20), -- Mythril Leaf
    (2304, 7, 6, 8, 4110, 1, 2, 15), -- Light Cluster
    (2305, 7, 6, 8, 1260, 1, 2, 6), -- Water Ore
    (2306, 7, 6, 8, 4274, 4, 8, 14), -- Persikos
    (2307, 7, 6, 8, 1262, 1, 2, 6), -- Dark Ore
    (2308, 7, 7, 0, 936, 12, 24, 15), -- Rock Salt
    (2309, 7, 7, 0, 17397, 24, 48, 15), -- Shell Bug
    (2310, 7, 7, 0, 4449, 1, 2, 15), -- Reishi Mushroom
    (2311, 7, 7, 0, 4111, 1, 2, 15), -- Dark Cluster
    (2312, 7, 7, 0, 1309, 4, 12, 34), -- Gold Leaf
    (2313, 7, 7, 0, 1261, 1, 2, 6), -- Light Ore
    (2314, 7, 7, 1, 4105, 1, 2, 24), -- Ice Cluster
    (2315, 7, 7, 1, 17397, 24, 48, 15), -- Shell Bug
    (2316, 7, 7, 1, 628, 1, 2, 20), -- Cinnamon
    (2317, 7, 7, 1, 4111, 1, 2, 15), -- Dark Cluster
    (2318, 7, 7, 1, 1255, 1, 2, 6), -- Fire Ore
    (2319, 7, 7, 1, 1309, 4, 12, 20), -- Gold Leaf
    (2320, 7, 7, 2, 4106, 1, 2, 24), -- Wind Cluster
    (2321, 7, 7, 2, 17397, 24, 48, 15), -- Shell Bug
    (2322, 7, 7, 2, 1310, 6, 12, 20), -- Platinum Leaf
    (2323, 7, 7, 2, 4111, 1, 2, 15), -- Dark Cluster
    (2324, 7, 7, 2, 1256, 1, 2, 6), -- Ice Ore
    (2325, 7, 7, 2, 1309, 4, 12, 20), -- Gold Leaf
    (2326, 7, 7, 3, 4107, 1, 2, 24), -- Earth Cluster
    (2327, 7, 7, 3, 17397, 24, 48, 15), -- Shell Bug
    (2328, 7, 7, 3, 635, 24, 48, 20), -- Clump Of Windurstian Tea Leaves
    (2329, 7, 7, 3, 4111, 1, 2, 15), -- Dark Cluster
    (2330, 7, 7, 3, 1257, 1, 2, 6), -- Wind Ore
    (2331, 7, 7, 3, 1309, 4, 12, 20), -- Gold Leaf
    (2332, 7, 7, 4, 4108, 1, 2, 24), -- Lightning Cluster
    (2333, 7, 7, 4, 17397, 24, 48, 15), -- Shell Bug
    (2334, 7, 7, 4, 4273, 8, 16, 20), -- Kitron
    (2335, 7, 7, 4, 4111, 1, 2, 15), -- Dark Cluster
    (2336, 7, 7, 4, 1258, 1, 2, 6), -- Earth Ore
    (2337, 7, 7, 4, 1309, 4, 12, 20), -- Gold Leaf
    (2338, 7, 7, 5, 4109, 1, 2, 24), -- Water Cluster
    (2339, 7, 7, 5, 17397, 24, 48, 15), -- Shell Bug
    (2340, 7, 7, 5, 1307, 8, 16, 20), -- Silver Leaf
    (2341, 7, 7, 5, 4111, 1, 2, 15), -- Dark Cluster
    (2342, 7, 7, 5, 1259, 1, 2, 6), -- Lightning Ore
    (2343, 7, 7, 5, 1309, 4, 12, 20), -- Gold Leaf
    (2344, 7, 7, 6, 4104, 1, 2, 24), -- Fire Cluster
    (2345, 7, 7, 6, 17397, 24, 48, 15), -- Shell Bug
    (2346, 7, 7, 6, 1308, 6, 12, 20), -- Mythril Leaf
    (2347, 7, 7, 6, 4111, 1, 2, 15), -- Dark Cluster
    (2348, 7, 7, 6, 1260, 1, 2, 6), -- Water Ore
    (2349, 7, 7, 6, 1309, 4, 12, 20), -- Gold Leaf
    (2350, 7, 7, 7, 17397, 24, 48, 30), -- Shell Bug
    (2351, 7, 7, 7, 4111, 1, 2, 30), -- Dark Cluster
    (2352, 7, 7, 7, 1309, 4, 12, 40), -- Gold Leaf
    (2353, 7, 7, 8, 17397, 24, 48, 15), -- Shell Bug
    (2354, 7, 7, 8, 936, 12, 24, 15), -- Rock Salt
    (2355, 7, 7, 8, 4111, 1, 2, 15), -- Dark Cluster
    (2356, 7, 7, 8, 4110, 1, 2, 15), -- Light Cluster
    (2357, 7, 7, 8, 1309, 4, 12, 20), -- Gold Leaf
    (2358, 7, 7, 8, 4274, 4, 8, 14), -- Persikos
    (2359, 7, 7, 8, 1262, 1, 2, 6), -- Dark Ore
    (2360, 7, 8, 0, 936, 12, 24, 30), -- Rock Salt
    (2361, 7, 8, 0, 4449, 1, 2, 15), -- Reishi Mushroom
    (2362, 7, 8, 0, 4110, 1, 2, 15), -- Light Cluster
    (2363, 7, 8, 0, 1309, 4, 12, 14), -- Gold Leaf
    (2364, 7, 8, 0, 4274, 4, 8, 14), -- Persikos
    (2365, 7, 8, 0, 1261, 1, 2, 6), -- Light Ore
    (2366, 7, 8, 0, 1262, 1, 2, 6), -- Dark Ore
    (2367, 7, 8, 1, 4105, 1, 2, 24), -- Ice Cluster
    (2368, 7, 8, 1, 936, 12, 24, 15), -- Rock Salt
    (2369, 7, 8, 1, 628, 1, 2, 20), -- Cinnamon
    (2370, 7, 8, 1, 4110, 1, 2, 15), -- Light Cluster
    (2371, 7, 8, 1, 1255, 1, 2, 6), -- Fire Ore
    (2372, 7, 8, 1, 4274, 4, 8, 14), -- Persikos
    (2373, 7, 8, 1, 1262, 1, 2, 6), -- Dark Ore
    (2374, 7, 8, 2, 4106, 1, 2, 24), -- Wind Cluster
    (2375, 7, 8, 2, 936, 12, 24, 15), -- Rock Salt
    (2376, 7, 8, 2, 1310, 6, 12, 20), -- Platinum Leaf
    (2377, 7, 8, 2, 4110, 1, 2, 15), -- Light Cluster
    (2378, 7, 8, 2, 1256, 1, 2, 6), -- Ice Ore
    (2379, 7, 8, 2, 4274, 4, 8, 14), -- Persikos
    (2380, 7, 8, 2, 1262, 1, 2, 6), -- Dark Ore
    (2381, 7, 8, 3, 4107, 1, 2, 24), -- Earth Cluster
    (2382, 7, 8, 3, 936, 12, 24, 15), -- Rock Salt
    (2383, 7, 8, 3, 635, 24, 48, 20), -- Clump Of Windurstian Tea Leaves
    (2384, 7, 8, 3, 4110, 1, 2, 15), -- Light Cluster
    (2385, 7, 8, 3, 1257, 1, 2, 6), -- Wind Ore
    (2386, 7, 8, 3, 4274, 4, 8, 14), -- Persikos
    (2387, 7, 8, 3, 1262, 1, 2, 6), -- Dark Ore
    (2388, 7, 8, 4, 4108, 1, 2, 24), -- Lightning Cluster
    (2389, 7, 8, 4, 936, 12, 24, 15), -- Rock Salt
    (2390, 7, 8, 4, 4273, 8, 16, 20), -- Kitron
    (2391, 7, 8, 4, 4110, 1, 2, 15), -- Light Cluster
    (2392, 7, 8, 4, 1258, 1, 2, 6), -- Earth Ore
    (2393, 7, 8, 4, 4274, 4, 8, 14), -- Persikos
    (2394, 7, 8, 4, 1262, 1, 2, 6), -- Dark Ore
    (2395, 7, 8, 5, 4109, 1, 2, 24), -- Water Cluster
    (2396, 7, 8, 5, 936, 12, 24, 15), -- Rock Salt
    (2397, 7, 8, 5, 1307, 8, 16, 20), -- Silver Leaf
    (2398, 7, 8, 5, 4110, 1, 2, 15), -- Light Cluster
    (2399, 7, 8, 5, 1259, 1, 2, 6), -- Lightning Ore
    (2400, 7, 8, 5, 4274, 4, 8, 14), -- Persikos
    (2401, 7, 8, 5, 1262, 1, 2, 6), -- Dark Ore
    (2402, 7, 8, 6, 4104, 1, 2, 24), -- Fire Cluster
    (2403, 7, 8, 6, 936, 12, 24, 15), -- Rock Salt
    (2404, 7, 8, 6, 1308, 6, 12, 20), -- Mythril Leaf
    (2405, 7, 8, 6, 4110, 1, 2, 15), -- Light Cluster
    (2406, 7, 8, 6, 1260, 1, 2, 6), -- Water Ore
    (2407, 7, 8, 6, 4274, 4, 8, 14), -- Persikos
    (2408, 7, 8, 6, 1262, 1, 2, 6), -- Dark Ore
    (2409, 7, 8, 7, 17397, 24, 48, 15), -- Shell Bug
    (2410, 7, 8, 7, 936, 12, 24, 15), -- Rock Salt
    (2411, 7, 8, 7, 4111, 1, 2, 15), -- Dark Cluster
    (2412, 7, 8, 7, 4110, 1, 2, 15), -- Light Cluster
    (2413, 7, 8, 7, 1309, 4, 12, 20), -- Gold Leaf
    (2414, 7, 8, 7, 4274, 4, 8, 14), -- Persikos
    (2415, 7, 8, 7, 1262, 1, 2, 6), -- Dark Ore
    (2416, 7, 8, 8, 936, 12, 24, 30), -- Rock Salt
    (2417, 7, 8, 8, 4110, 1, 2, 30), -- Light Cluster
    (2418, 7, 8, 8, 4274, 4, 8, 28), -- Persikos
    (2419, 7, 8, 8, 1262, 1, 2, 12), -- Dark Ore
    (2420, 8, 0, 0, 936, 12, 24, 30), -- Rock Salt
    (2421, 8, 0, 0, 4366, 6, 12, 20), -- La Theine Cabbage
    (2422, 8, 0, 0, 774, 1, 2, 30), -- Purple Rock
    (2423, 8, 0, 0, 2205, 1, 5, 20), -- Gregarious Worm
    (2424, 8, 1, 0, 4097, 4, 12, 40), -- Ice Crystal
    (2425, 8, 1, 0, 4545, 12, 24, 30), -- Gysahl Greens
    (2426, 8, 1, 0, 2202, 8, 16, 30), -- Clump Of Garidav Wildgrass
    (2427, 8, 2, 0, 4098, 4, 12, 40), -- Wind Crystal
    (2428, 8, 2, 0, 5608, 6, 12, 30), -- Zegham Carrot
    (2429, 8, 2, 0, 5606, 6, 12, 30), -- Azouph Greens
    (2430, 8, 3, 0, 4099, 4, 12, 60), -- Earth Crystal
    (2431, 8, 3, 0, 4545, 8, 16, 40), -- Bunch Of Gysahl Greens
    (2432, 8, 4, 0, 936, 12, 24, 40), -- Rock Salt
    (2433, 8, 4, 0, 4100, 4, 12, 30), -- Lightning Crystal
    (2434, 8, 4, 0, 5607, 8, 16, 30), -- Vomp Carrot
    (2435, 8, 5, 0, 17396, 12, 24, 30), -- Little Worm
    (2436, 8, 5, 0, 4101, 4, 12, 20), -- Water Crystal
    (2437, 8, 5, 0, 5605, 8, 16, 30), -- Sharug Greens
    (2438, 8, 5, 0, 774, 1, 2, 20), -- Purple Rock
    (2439, 8, 6, 0, 4096, 4, 12, 60), -- Fire Crystal
    (2440, 8, 6, 0, 2201, 8, 16, 40), -- Clump Of Tokopekko Wildgrass
    (2441, 8, 7, 0, 4103, 4, 12, 60), -- Dark Crystal
    (2442, 8, 7, 0, 2203, 1, 5, 40), -- Cupid Worm
    (2443, 8, 8, 0, 4102, 4, 12, 60), -- Light Crystal
    (2444, 8, 8, 0, 2204, 1, 5, 40); -- Parasite Worm