--
-- Table structure for table `augments`
--

DROP TABLE IF EXISTS `augments`;
CREATE TABLE `augments` (
  `augmentId` smallint(5) unsigned NOT NULL,
  `multiplier` smallint(2) NOT NULL DEFAULT 0,
  `modId` smallint(5) unsigned NOT NULL DEFAULT 0,
  `value` smallint(5) NOT NULL DEFAULT 0,
  `isPet` tinyint(1) NOT NULL DEFAULT 0,
  `petType` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`augmentId`,`multiplier`,`modId`,`isPet`,`petType`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `augments`
--

-- WARNING: do not comment out augmentId records, zero their modId and values instead.
-- Zero is MOD_NONE and should be fine..
-- The IDs follow the packet not the dat so windower resources and polutils dumps will not match
INSERT INTO `augments` VALUES (1,0,2,1,0,0); -- HP+1
INSERT INTO `augments` VALUES (2,0,2,33,0,0); -- HP+33
INSERT INTO `augments` VALUES (3,0,2,65,0,0); -- HP+65
INSERT INTO `augments` VALUES (4,0,2,97,0,0); -- HP+97
INSERT INTO `augments` VALUES (5,0,2,-1,0,0); -- HP-1
INSERT INTO `augments` VALUES (6,0,2,-33,0,0); -- HP-33
INSERT INTO `augments` VALUES (7,0,2,-65,0,0); -- HP-65
INSERT INTO `augments` VALUES (8,0,2,-97,0,0); -- HP-97
INSERT INTO `augments` VALUES (9,0,5,1,0,0); -- MP+1
INSERT INTO `augments` VALUES (10,0,5,33,0,0); -- MP+33
INSERT INTO `augments` VALUES (11,0,5,65,0,0); -- MP+65
INSERT INTO `augments` VALUES (12,0,5,97,0,0); -- MP+97
INSERT INTO `augments` VALUES (13,0,5,-1,0,0); -- MP-1
INSERT INTO `augments` VALUES (14,0,5,-33,0,0); -- MP-33
INSERT INTO `augments` VALUES (15,0,5,-65,0,0); -- MP-65
INSERT INTO `augments` VALUES (16,0,5,-97,0,0); -- MP-97
INSERT INTO `augments` VALUES (17,0,2,1,0,0); -- HP+1 MP+1
INSERT INTO `augments` VALUES (17,0,5,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (18,0,2,33,0,0); -- HP+33 MP+33
INSERT INTO `augments` VALUES (18,0,5,33,0,0); -- Cont.
INSERT INTO `augments` VALUES (19,0,2,1,0,0); -- HP+1 MP-1
INSERT INTO `augments` VALUES (19,0,5,-1,0,0); -- Cont.
INSERT INTO `augments` VALUES (20,0,2,33,0,0); -- HP+33 MP-33
INSERT INTO `augments` VALUES (20,0,5,-33,0,0); -- Cont.
INSERT INTO `augments` VALUES (21,0,2,-1,0,0); -- HP-1 MP+1
INSERT INTO `augments` VALUES (21,0,5,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (22,0,2,-33,0,0); -- HP-33 MP+33
INSERT INTO `augments` VALUES (22,0,5,33,0,0); -- Cont.
INSERT INTO `augments` VALUES (23,0,25,1,0,0); -- Accuracy+1
INSERT INTO `augments` VALUES (24,0,25,-1,0,0); -- Accuracy-1
INSERT INTO `augments` VALUES (25,0,23,1,0,0); -- Attack+1
INSERT INTO `augments` VALUES (26,0,23,-1,0,0); -- Attack-1
INSERT INTO `augments` VALUES (27,0,26,1,0,0); -- Rng.Acc.+1
INSERT INTO `augments` VALUES (28,0,26,-1,0,0); -- Rng.Acc.-1
INSERT INTO `augments` VALUES (29,0,24,1,0,0); -- Rng.Atk.+1
INSERT INTO `augments` VALUES (30,0,24,-1,0,0); -- Rng.Atk.-1
INSERT INTO `augments` VALUES (31,0,68,1,0,0); -- Evasion+1
INSERT INTO `augments` VALUES (32,0,68,-1,0,0); -- Evasion-1
INSERT INTO `augments` VALUES (33,0,1,1,0,0); -- DEF+1
INSERT INTO `augments` VALUES (34,0,1,-1,0,0); -- DEF-1
INSERT INTO `augments` VALUES (35,0,30,1,0,0); -- Mag.Acc.+1
INSERT INTO `augments` VALUES (36,0,30,-1,0,0); -- Mag.Acc.-1
INSERT INTO `augments` VALUES (37,0,31,1,0,0); -- Mag.Evasion+1
INSERT INTO `augments` VALUES (38,0,31,-1,0,0); -- Mag.Evasion-1
INSERT INTO `augments` VALUES (39,0,27,1,0,0); -- Enmity+1
INSERT INTO `augments` VALUES (40,0,27,-1,0,0); -- Enmity-1
INSERT INTO `augments` VALUES (41,0,165,1,0,0); -- Crit.hit rate+1%
INSERT INTO `augments` VALUES (42,0,166,-1,0,0); -- Enemy crit. hit rate-1%
INSERT INTO `augments` VALUES (43,0,391,1,0,0); -- Charm+1 Could not determine retail AUGMENT effect. Duration? Chance to land charm? Just set as chance for now.
INSERT INTO `augments` VALUES (44,0,73,1,0,0); -- Store TP+1 Subtle Blow+1
INSERT INTO `augments` VALUES (44,0,289,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (45,0,287,1,0,0);  -- DMG:+(X+1), Increases damage rating of this weapon (Maximum X=31 for DMG+32) (Retail: melee,not ranged...Mainhand only?) Item displays a value 1 larger than stored in item
INSERT INTO `augments` VALUES (46,0,287,-1,0,0); -- DMG:-(X+1), Decreases damage rating of this weapon (Maximum X=31 for DMG-32) (Retail: melee,not ranged...Mainhand only?) Item displays a (negative) value 1 larger than stored in item
INSERT INTO `augments` VALUES (47,0,380,1,0,0); -- Delay:+1% (melee,not ranged)
INSERT INTO `augments` VALUES (48,0,380,-1,0,0); -- Delay:-1% (melee,not ranged)
INSERT INTO `augments` VALUES (49,100,384,1,0,0); -- Haste+1
INSERT INTO `augments` VALUES (50,100,384,-1,0,0); -- Slow+1
INSERT INTO `augments` VALUES (51,0,72,1,0,0); -- HP recovered while healing+1
INSERT INTO `augments` VALUES (52,0,71,1,0,0); -- MP recovered while healing+1
INSERT INTO `augments` VALUES (53,0,168,-1,0,0); -- Spell interruption rate down 1%
INSERT INTO `augments` VALUES (54,100,161,-1,0,0); -- Phys. dmg. taken -1%
INSERT INTO `augments` VALUES (55,100,163,-1,0,0); -- Magic dmg. taken -1%
INSERT INTO `augments` VALUES (56,100,162,-1,0,0); -- Breath dmg. taken -1%
INSERT INTO `augments` VALUES (57,0,562,1,0,0); -- Magic crit. hit rate+1%
INSERT INTO `augments` VALUES (58,0,29,-1,0,0); -- Mag.Def.Bns.-1
INSERT INTO `augments` VALUES (59,0,0,0,0,0); -- Latent effect: Regain+10 (Do via Latent: triggered with your current weapon drawn for 10 TP/tick.)
INSERT INTO `augments` VALUES (60,0,0,0,0,0); -- Latent effect: Refresh+1 (Do via Latent: triggered with your current weapon not drawn for 1 MP/tick. Refresh is not present while resting(/heal),chocobo or /sit.)
INSERT INTO `augments` VALUES (61,0,958,1,0,0); -- Occ. inc. resist to stat ailments+1
INSERT INTO `augments` VALUES (62,0,25,33,0,0); -- Accuracy +33
INSERT INTO `augments` VALUES (63,0,26,33,0,0); -- Rng.Accuracy +33
INSERT INTO `augments` VALUES (64,0,30,33,0,0); -- Mag. Acc. +33
INSERT INTO `augments` VALUES (65,0,23,33,0,0); -- Attack +33
INSERT INTO `augments` VALUES (66,0,24,33,0,0); -- Rng.Attack +33
INSERT INTO `augments` VALUES (67,0,452,1,0,0); -- All songs +1
INSERT INTO `augments` VALUES (68,0,25,1,0,0); -- Accuracy +1 Attack +1
INSERT INTO `augments` VALUES (68,0,23,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (69,0,26,1,0,0); -- Rng.Acc. +1 Rng.Atk. +1
INSERT INTO `augments` VALUES (69,0,24,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (70,0,30,33,0,0); -- Mag. Acc. +33 Mag.Atk.Bns +33
INSERT INTO `augments` VALUES (70,0,28,33,0,0); -- Cont.
INSERT INTO `augments` VALUES (71,0,160,-100,0,0); -- Damage Taken -1%
INSERT INTO `augments` VALUES (72,0,0,1,0,0); -- Exp. Point +1%
INSERT INTO `augments` VALUES (73,0,0,33,0,0); -- Exp. Point +33%
INSERT INTO `augments` VALUES (74,0,915,1,0,0); -- Cap. Point +1%
INSERT INTO `augments` VALUES (75,0,915,33,0,0); -- Cap. Point +33%
INSERT INTO `augments` VALUES (76,0,0,0,0,0); -- DMG +33 Unsure if main hand or off hand so leaving values blank for now,goes up in increments of 1 after the initial 33.
INSERT INTO `augments` VALUES (77,0,0,0,0,0); -- Delay -33% Unsure if main hand or off hand so leaving values blank for now,goes up in increments of 1 after the initial 33.
INSERT INTO `augments` VALUES (78,0,2,2,0,0); -- HP +2 (count by 2)
INSERT INTO `augments` VALUES (79,0,2,3,0,0); -- HP +3 (count by 3)
INSERT INTO `augments` VALUES (80,0,30,1,0,0); -- Mag. Acc. +1/Mag. Dmg. +1
INSERT INTO `augments` VALUES (80,0,311,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (81,0,0,0,0,0); -- Eva +1/Mag. Eva + d (corrupted)
INSERT INTO `augments` VALUES (82,0,5,2,0,0); -- MP +2 (count by 2)
INSERT INTO `augments` VALUES (83,0,5,3,0,0); -- MP +3 (count by 3)

-- 84 to 95 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (84,0,0,0,0,0);
INSERT INTO `augments` VALUES (85,0,0,0,0,0);
INSERT INTO `augments` VALUES (86,0,0,0,0,0);
INSERT INTO `augments` VALUES (87,0,0,0,0,0);
INSERT INTO `augments` VALUES (88,0,0,0,0,0);
INSERT INTO `augments` VALUES (89,0,0,0,0,0);
INSERT INTO `augments` VALUES (90,0,0,0,0,0);
INSERT INTO `augments` VALUES (91,0,0,0,0,0);
INSERT INTO `augments` VALUES (92,0,0,0,0,0);
INSERT INTO `augments` VALUES (93,0,0,0,0,0);
INSERT INTO `augments` VALUES (94,0,0,0,0,0);
INSERT INTO `augments` VALUES (95,0,0,0,0,0);
-- End unused block

INSERT INTO `augments` VALUES (96,0,25,1,1,0); -- Pet: Accuracy+1 Rng.Acc+1
INSERT INTO `augments` VALUES (96,0,26,1,1,0); -- Cont.
INSERT INTO `augments` VALUES (97,0,23,1,1,0); -- Pet: Attack+1 Rng.Atk.+1
INSERT INTO `augments` VALUES (97,0,24,1,1,0); -- Cont.
INSERT INTO `augments` VALUES (98,0,68,1,1,0); -- Pet: Evasion+1
INSERT INTO `augments` VALUES (99,0,1,1,1,0); -- Pet: DEF+1
INSERT INTO `augments` VALUES (100,0,30,1,1,0); -- Pet: Mag.Acc.+1
INSERT INTO `augments` VALUES (101,0,28,1,1,0); -- Pet: Mag.Atk.Bns.+1
INSERT INTO `augments` VALUES (102,0,165,1,1,0); -- Pet: Crit.hit rate+1%
INSERT INTO `augments` VALUES (103,0,166,-1,1,0); -- Pet: Enemy crit. hit rate -1%
INSERT INTO `augments` VALUES (104,0,27,1,1,0); -- Pet: Enmity+1
INSERT INTO `augments` VALUES (105,0,27,-1,1,0); -- Pet: Enmity-1
INSERT INTO `augments` VALUES (106,0,25,1,1,0); -- Pet: Accuracy+1 Rng.Acc.+1
INSERT INTO `augments` VALUES (106,0,26,1,1,0); -- Cont.
INSERT INTO `augments` VALUES (107,0,23,1,1,0); -- Pet: Attack+1 Rng.Atk.+1
INSERT INTO `augments` VALUES (107,0,24,1,1,0); -- Cont.
INSERT INTO `augments` VALUES (108,0,30,1,1,0); -- Pet: Mag.Acc.+1 Mag.Atk.Bns.+1
INSERT INTO `augments` VALUES (108,0,28,1,1,0); -- Cont.
INSERT INTO `augments` VALUES (109,0,288,1,1,0); -- Pet: Dbl.Atk.+1% Crit.hit rate+1
INSERT INTO `augments` VALUES (109,0,165,1,1,0); -- Cont.
INSERT INTO `augments` VALUES (110,0,370,1,1,0); -- Pet: Regen+1
INSERT INTO `augments` VALUES (111,0,384,100,1,0); -- Pet: Haste+1
INSERT INTO `augments` VALUES (112,0,160,-100,1,0); -- Pet: Damage taken -1%
INSERT INTO `augments` VALUES (113,0,26,1,1,0); -- Pet: Rng.Acc.+1
INSERT INTO `augments` VALUES (114,0,24,1,1,0); -- Pet: Rng.Atk.+1
INSERT INTO `augments` VALUES (115,0,73,1,1,0); -- Pet: Store TP+1
INSERT INTO `augments` VALUES (116,0,289,1,1,0); -- Pet: Subtle Blow+1
INSERT INTO `augments` VALUES (117,0,31,1,1,0); -- Pet: Mag. Evasion+1
INSERT INTO `augments` VALUES (118,100,161,-1,1,0); -- Pet: Phys. dmg. taken -1%
INSERT INTO `augments` VALUES (119,0,29,1,1,0); -- Pet: Mag.Def.Bns.+1
INSERT INTO `augments` VALUES (120,0,28,1,1,1); -- Avatar: Mag.Atk.Bns.+1
INSERT INTO `augments` VALUES (121,0,0,0,1,0); -- Pet: Breath +1
INSERT INTO `augments` VALUES (122,0,345,20,1,0); -- Pet: TP Bonus +20
INSERT INTO `augments` VALUES (123,0,288,1,1,0); -- Pet: Dbl.Att.+1%
INSERT INTO `augments` VALUES (124,0,23,1,1,0); -- Pet: Acc+1 R.Acc+1 Atk.+1 R.Atk.+1
INSERT INTO `augments` VALUES (124,0,24,1,1,0); -- Cont.
INSERT INTO `augments` VALUES (124,0,25,1,1,0); -- Cont.
INSERT INTO `augments` VALUES (124,0,26,1,1,0); -- Cont.
INSERT INTO `augments` VALUES (125,0,30,1,1,0); -- Pet: Mag.Acc.+1 Mag.Dmg.+1
INSERT INTO `augments` VALUES (125,0,311,1,1,0); -- Cont.
INSERT INTO `augments` VALUES (126,0,311,1,1,0); -- Pet: Magic Damage +1
INSERT INTO `augments` VALUES (127,100,163,-1,1,0); -- Pet: Magic Damage Taken -1%
INSERT INTO `augments` VALUES (128,0,0,0,0,0); -- 128 doesnt seem to be a valid Augment,incomplete or garbled text displays
INSERT INTO `augments` VALUES (129,0,25,1,0,0); -- Accuracy+1 Rng.Acc.+1
INSERT INTO `augments` VALUES (129,0,26,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (130,0,23,1,0,0); -- Attack+1 Rng.Atk.+1
INSERT INTO `augments` VALUES (130,0,24,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (131,0,30,1,0,0); -- Mag. Acc.+1 Mag.Atk.Bns+1
INSERT INTO `augments` VALUES (131,0,28,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (132,0,288,1,0,0); -- Dbl.Atk.+1% Crit.hit rate+1%
INSERT INTO `augments` VALUES (132,0,165,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (133,0,28,1,0,0); -- Mag.Atk.Bns.+1
INSERT INTO `augments` VALUES (134,0,29,1,0,0); -- Mag.Def.Bns.+1
INSERT INTO `augments` VALUES (135,0,0,0,0,0); -- 135 doesnt seem to be a valid Augment,incomplete or garbled text displays
INSERT INTO `augments` VALUES (136,0,0,0,0,0); -- 136 doesnt seem to be a valid Augment,incomplete or garbled text displays
INSERT INTO `augments` VALUES (137,0,370,1,0,0); -- Regen+1
INSERT INTO `augments` VALUES (138,0,369,1,0,0); -- Refresh+1
INSERT INTO `augments` VALUES (139,0,359,1,0,0); -- Rapid Shot+1
INSERT INTO `augments` VALUES (140,0,170,1,0,0); -- Fast Cast+1%
INSERT INTO `augments` VALUES (141,0,296,1,0,0); -- Conserve MP+1
INSERT INTO `augments` VALUES (142,0,73,1,0,0); -- Store TP+1
INSERT INTO `augments` VALUES (143,0,288,1,0,0); -- Dbl.Atk.+1%
INSERT INTO `augments` VALUES (144,0,302,1,0,0); -- Triple Atk.+1%
INSERT INTO `augments` VALUES (145,0,291,1,0,0); -- Counter+1
INSERT INTO `augments` VALUES (146,0,259,1,0,0); -- Dual Wield+1
INSERT INTO `augments` VALUES (147,0,303,1,0,0); -- Treasure Hunter+1
INSERT INTO `augments` VALUES (148,0,897,1,0,0); -- Gilfinder+1
INSERT INTO `augments` VALUES (149,0,0,0,0,0); -- 149 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (150,0,0,0,0,0); -- 150 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (151,0,173,1,0,0); -- Martial Arts+1
INSERT INTO `augments` VALUES (152,0,0,0,0,0); -- 152 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (153,0,485,1,0,0); -- Shield Mastery+1 (tested in retail,this is correct)

-- 154 to 175 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (154,0,0,0,0,0);
INSERT INTO `augments` VALUES (155,0,0,0,0,0);
INSERT INTO `augments` VALUES (156,0,0,0,0,0);
INSERT INTO `augments` VALUES (157,0,0,0,0,0);
INSERT INTO `augments` VALUES (158,0,0,0,0,0);
INSERT INTO `augments` VALUES (159,0,0,0,0,0);
INSERT INTO `augments` VALUES (160,0,0,0,0,0);
INSERT INTO `augments` VALUES (161,0,0,0,0,0);
INSERT INTO `augments` VALUES (162,0,0,0,0,0);
INSERT INTO `augments` VALUES (163,0,0,0,0,0);
INSERT INTO `augments` VALUES (164,0,0,0,0,0);
INSERT INTO `augments` VALUES (165,0,0,0,0,0);
INSERT INTO `augments` VALUES (166,0,0,0,0,0);
INSERT INTO `augments` VALUES (167,0,0,0,0,0);
INSERT INTO `augments` VALUES (168,0,0,0,0,0);
INSERT INTO `augments` VALUES (169,0,0,0,0,0);
INSERT INTO `augments` VALUES (170,0,0,0,0,0);
INSERT INTO `augments` VALUES (171,0,0,0,0,0);
INSERT INTO `augments` VALUES (172,0,0,0,0,0);
INSERT INTO `augments` VALUES (173,0,0,0,0,0);
INSERT INTO `augments` VALUES (174,0,0,0,0,0);
INSERT INTO `augments` VALUES (175,0,0,0,0,0);
-- End unused block

INSERT INTO `augments` VALUES (176,0,240,1,0,0); -- Resist Sleep+1
INSERT INTO `augments` VALUES (177,0,241,1,0,0); -- Resist Poison+1
INSERT INTO `augments` VALUES (178,0,242,1,0,0); -- Resist Paralyze+1
INSERT INTO `augments` VALUES (179,0,243,1,0,0); -- Resist Blind+1
INSERT INTO `augments` VALUES (180,0,244,1,0,0); -- Resist Silence+1
INSERT INTO `augments` VALUES (181,0,245,1,0,0); -- Resist Virus+1
INSERT INTO `augments` VALUES (182,0,246,1,0,0); -- Resist Petrify+1
INSERT INTO `augments` VALUES (183,0,247,1,0,0); -- Resist Bind+1
INSERT INTO `augments` VALUES (184,0,248,1,0,0); -- Resist Curse+1
INSERT INTO `augments` VALUES (185,0,249,1,0,0); -- Resist Gravity+1
INSERT INTO `augments` VALUES (186,0,250,1,0,0); -- Resist Slow+1
INSERT INTO `augments` VALUES (187,0,251,1,0,0); -- Resist Stun+1
INSERT INTO `augments` VALUES (188,0,252,1,0,0); -- Resist Charm+1
INSERT INTO `augments` VALUES (189,0,0,0,0,0); -- 189 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (190,0,0,0,0,0); -- 190 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (191,0,0,0,0,0); -- 191 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (192,0,0,0,0,0); -- 192 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (193,0,0,0,0,0); -- 193 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (194,0,292,1,0,0); -- Kick Attacks+1 Rate or Damage? Assuming Rate for now.
INSERT INTO `augments` VALUES (195,0,289,1,0,0); -- Subtle Blow+1
INSERT INTO `augments` VALUES (196,0,0,0,0,0); -- 196 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (197,0,0,0,0,0); -- 197 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (198,0,306,1,0,0); -- Zanshin+1

-- 199 to 210 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (199,0,0,0,0,0);
INSERT INTO `augments` VALUES (200,0,0,0,0,0);
INSERT INTO `augments` VALUES (201,0,0,0,0,0);
INSERT INTO `augments` VALUES (202,0,0,0,0,0);
INSERT INTO `augments` VALUES (203,0,0,0,0,0);
INSERT INTO `augments` VALUES (204,0,0,0,0,0);
INSERT INTO `augments` VALUES (205,0,0,0,0,0);
INSERT INTO `augments` VALUES (206,0,0,0,0,0);
INSERT INTO `augments` VALUES (207,0,0,0,0,0);
INSERT INTO `augments` VALUES (208,0,0,0,0,0);
INSERT INTO `augments` VALUES (209,0,0,0,0,0);
INSERT INTO `augments` VALUES (210,0,0,0,0,0);
-- End unused block

INSERT INTO `augments` VALUES (211,0,365,1,0,0); -- Snapshot+1
INSERT INTO `augments` VALUES (212,0,305,1,0,0); -- Recycle+1
INSERT INTO `augments` VALUES (213,0,0,0,0,0); -- 213 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (214,0,0,0,0,0); -- 214 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (215,0,308,1,0,0); -- Ninja tool expertise+1

-- 216 to 231 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (216,0,0,0,0,0);
INSERT INTO `augments` VALUES (217,0,0,0,0,0);
INSERT INTO `augments` VALUES (218,0,0,0,0,0);
INSERT INTO `augments` VALUES (219,0,0,0,0,0);
INSERT INTO `augments` VALUES (220,0,0,0,0,0);
INSERT INTO `augments` VALUES (221,0,0,0,0,0);
INSERT INTO `augments` VALUES (222,0,0,0,0,0);
INSERT INTO `augments` VALUES (223,0,0,0,0,0);
INSERT INTO `augments` VALUES (224,0,0,0,0,0);
INSERT INTO `augments` VALUES (225,0,0,0,0,0);
INSERT INTO `augments` VALUES (226,0,0,0,0,0);
INSERT INTO `augments` VALUES (227,0,0,0,0,0);
INSERT INTO `augments` VALUES (228,0,0,0,0,0);
INSERT INTO `augments` VALUES (229,0,0,0,0,0);
INSERT INTO `augments` VALUES (230,0,0,0,0,0);
INSERT INTO `augments` VALUES (231,0,0,0,0,0);
INSERT INTO `augments` VALUES (232,0,0,0,0,0); -- True Shot +1
-- End unused block

INSERT INTO `augments` VALUES (233,0,913,1,0,0); -- Blood Boon+1

-- 234 to 236 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (234,0,0,0,0,0);
INSERT INTO `augments` VALUES (235,0,0,0,0,0);
INSERT INTO `augments` VALUES (236,0,0,0,0,0);
-- End unused block

INSERT INTO `augments` VALUES (237,0,902,1,0,0); -- Occult Acumen+1

-- 238 to 250 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (238,0,0,0,0,0);
INSERT INTO `augments` VALUES (239,0,0,0,0,0);
INSERT INTO `augments` VALUES (240,0,0,0,0,0);
INSERT INTO `augments` VALUES (241,0,0,0,0,0);
INSERT INTO `augments` VALUES (242,0,0,0,0,0);
INSERT INTO `augments` VALUES (243,0,0,0,0,0);
INSERT INTO `augments` VALUES (244,0,0,0,0,0);
INSERT INTO `augments` VALUES (245,0,0,0,0,0);
INSERT INTO `augments` VALUES (246,0,0,0,0,0);
INSERT INTO `augments` VALUES (247,0,0,0,0,0);
INSERT INTO `augments` VALUES (248,0,0,0,0,0);
INSERT INTO `augments` VALUES (249,0,0,0,0,0);
INSERT INTO `augments` VALUES (250,0,0,0,0,0);
-- End unused block

INSERT INTO `augments` VALUES (251,1,911,0,0,0); -- Daken +1

-- 252 to 256 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (252,0,0,0,0,0);
INSERT INTO `augments` VALUES (253,0,0,0,0,0);
INSERT INTO `augments` VALUES (254,0,0,0,0,0);
INSERT INTO `augments` VALUES (255,0,0,0,0,0);
INSERT INTO `augments` VALUES (256,0,0,0,0,0);
-- End unused block

INSERT INTO `augments` VALUES (257,0,80,1,0,0); -- Hand-to-Hand skill+1
INSERT INTO `augments` VALUES (258,0,81,1,0,0); -- Dagger skill+1
INSERT INTO `augments` VALUES (259,0,82,1,0,0); -- Sword skill+1
INSERT INTO `augments` VALUES (260,0,83,1,0,0); -- Great Sword skill+1
INSERT INTO `augments` VALUES (261,0,84,1,0,0); -- Axe skill+1
INSERT INTO `augments` VALUES (262,0,85,1,0,0); -- Great Axe skill+1
INSERT INTO `augments` VALUES (263,0,86,1,0,0); -- Scythe skill+1
INSERT INTO `augments` VALUES (264,0,87,1,0,0); -- Polearm skill+1
INSERT INTO `augments` VALUES (265,0,88,1,0,0); -- Katana skill+1
INSERT INTO `augments` VALUES (266,0,89,1,0,0); -- Great Katana skill+1
INSERT INTO `augments` VALUES (267,0,90,1,0,0); -- Club skill+1
INSERT INTO `augments` VALUES (268,0,91,1,0,0); -- Staff skill+1

-- 269 to 277 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (269,0,0,0,0,0);
INSERT INTO `augments` VALUES (270,0,0,0,0,0);
INSERT INTO `augments` VALUES (271,0,0,0,0,0);
INSERT INTO `augments` VALUES (272,0,0,0,0,0);
INSERT INTO `augments` VALUES (273,0,0,0,0,0);
INSERT INTO `augments` VALUES (274,0,0,0,0,0);
INSERT INTO `augments` VALUES (275,0,0,0,0,0);
INSERT INTO `augments` VALUES (276,0,0,0,0,0);
INSERT INTO `augments` VALUES (277,0,0,0,0,0);
-- End unused block

INSERT INTO `augments` VALUES (278,0,101,1,0,0); -- Melee skill+1 (for automaton)
INSERT INTO `augments` VALUES (279,0,102,1,0,0); -- Ranged skill+1 (for automaton)
INSERT INTO `augments` VALUES (280,0,103,1,0,0); -- Magic skill+1 (for automaton)
INSERT INTO `augments` VALUES (281,0,104,1,0,0); -- Archery skill+1
INSERT INTO `augments` VALUES (282,0,105,1,0,0); -- Marksmanship skill+1
INSERT INTO `augments` VALUES (283,0,106,1,0,0); -- Throwing skill+1
INSERT INTO `augments` VALUES (284,0,0,0,0,0); -- 284 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (285,0,0,0,0,0); -- 285 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (286,0,109,1,0,0); -- Shield skill+1
INSERT INTO `augments` VALUES (287,1,110,1,0,0); -- Parrying Skill +1
INSERT INTO `augments` VALUES (288,0,111,1,0,0); -- Divine magic skill+1
INSERT INTO `augments` VALUES (289,0,112,1,0,0); -- Healing magic skill+1
INSERT INTO `augments` VALUES (290,0,113,1,0,0); -- Enha.mag. skill+1
INSERT INTO `augments` VALUES (291,0,114,1,0,0); -- Enfb.mag. skill+1
INSERT INTO `augments` VALUES (292,0,115,1,0,0); -- Elem. magic skill+1
INSERT INTO `augments` VALUES (293,0,116,1,0,0); -- Dark magic skill+1
INSERT INTO `augments` VALUES (294,0,117,1,0,0); -- Summoning magic skill+1
INSERT INTO `augments` VALUES (295,0,118,1,0,0); -- Ninjutsu skill+1
INSERT INTO `augments` VALUES (296,0,119,1,0,0); -- Singing skill+1
INSERT INTO `augments` VALUES (297,0,120,1,0,0); -- String instrument skill+1
INSERT INTO `augments` VALUES (298,0,121,1,0,0); -- Wind instrument skill+1
INSERT INTO `augments` VALUES (299,0,122,1,0,0); -- Blue Magic skill+1
INSERT INTO `augments` VALUES (300,0,123,1,0,0); -- Geomancy Skill+1
INSERT INTO `augments` VALUES (301,0,124,1,0,0); -- Handbell Skill+1

-- 302 to 319 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (302,0,0,0,0,0);
INSERT INTO `augments` VALUES (303,0,0,0,0,0);
INSERT INTO `augments` VALUES (304,0,0,0,0,0);
INSERT INTO `augments` VALUES (305,0,0,0,0,0);
INSERT INTO `augments` VALUES (306,0,0,0,0,0);
INSERT INTO `augments` VALUES (307,0,0,0,0,0);
INSERT INTO `augments` VALUES (308,0,0,0,0,0);
INSERT INTO `augments` VALUES (309,0,0,0,0,0);
INSERT INTO `augments` VALUES (310,0,0,0,0,0);
INSERT INTO `augments` VALUES (311,0,0,0,0,0);
INSERT INTO `augments` VALUES (312,0,0,0,0,0);
INSERT INTO `augments` VALUES (313,0,0,0,0,0);
INSERT INTO `augments` VALUES (314,0,0,0,0,0);
INSERT INTO `augments` VALUES (315,0,0,0,0,0);
INSERT INTO `augments` VALUES (316,0,0,0,0,0);
INSERT INTO `augments` VALUES (317,0,0,0,0,0);
INSERT INTO `augments` VALUES (318,0,0,0,0,0);
INSERT INTO `augments` VALUES (319,0,0,0,0,0);
-- End unused block

INSERT INTO `augments` VALUES (320,0,357,1,0,0); -- Blood Pact ability delay -1
INSERT INTO `augments` VALUES (321,0,346,1,0,0); -- Avatar perpetuation cost -1
INSERT INTO `augments` VALUES (322,0,455,1,0,0); -- Song spellcasting time -1%
INSERT INTO `augments` VALUES (323,0,519,1,0,0); -- Cure spellcasting time -1%
INSERT INTO `augments` VALUES (324,0,572,1,0,0); -- Call Beast ability delay -1
INSERT INTO `augments` VALUES (325,0,1060,1,0,0); -- Quick Draw ability delay -1
INSERT INTO `augments` VALUES (326,0,48,1,0,0); -- Weapon Skill Acc.+1
INSERT INTO `augments` VALUES (327,0,840,1,0,0); -- Weapon skill damage+1% "However, some sources apply to all swings of the weapon skill (like Magian Trials Weapon Skill Damage +n% weapons)" (i.e. this indicates the augment is for all hits)
INSERT INTO `augments` VALUES (328,0,421,1,0,0); -- Crit. hit damage+1%
INSERT INTO `augments` VALUES (329,0,374,1,0,0); -- Cure potency+1%
INSERT INTO `augments` VALUES (330,0,491,1,0,0); -- Waltz potency+1%
INSERT INTO `augments` VALUES (331,0,497,-1,0,0); -- Waltz ability delay -1
INSERT INTO `augments` VALUES (332,100,175,1,0,0); -- Sklchn.dmg.+1%
INSERT INTO `augments` VALUES (333,0,944,1,0,0); -- Conserve TP+1
INSERT INTO `augments` VALUES (334,0,487,1,0,0); -- Magic burst dmg.+1%
INSERT INTO `augments` VALUES (335,0,563,1,0,0); -- Mag. crit. hit dmg.+1%
INSERT INTO `augments` VALUES (336,0,1052,1,0,0); -- Sic and Ready ability delay -1
INSERT INTO `augments` VALUES (337,0,833,1,0,0); -- Song recast delay -1
INSERT INTO `augments` VALUES (338,0,138,1,0,0); -- Barrage+1 (additional shots,NOT acc)
INSERT INTO `augments` VALUES (339,5,540,1,0,0); -- Elemental Siphon+5 (value*5) Use Multiplier field.
INSERT INTO `augments` VALUES (340,0,1076,1,0,0); -- Phantom Roll ability delay -1
INSERT INTO `augments` VALUES (341,0,854,1,0,0); -- Repair potency+1%
INSERT INTO `augments` VALUES (342,0,139,1,0,0); -- Waltz TP cost -1
INSERT INTO `augments` VALUES (343,0,315,1,0,0); -- "Drain" and "Aspir" Potency +1

-- 344 to 346 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (344,0,0,0,0,0);
INSERT INTO `augments` VALUES (345,0,0,0,0,0);
INSERT INTO `augments` VALUES (346,0,0,0,0,0);
-- End unused block

INSERT INTO `augments` VALUES (347,0,0,0,0,0); -- Healing Magic Recast Delay -1
INSERT INTO `augments` VALUES (348,0,0,0,0,0); -- Elemental Magic Recast Delay -1
INSERT INTO `augments` VALUES (349,0,0,0,0,0); -- Enfeebling Magic Recast Delay -1
INSERT INTO `augments` VALUES (350,0,0,0,0,0); -- Occ. maximizes magic accuracy+1%
INSERT INTO `augments` VALUES (351,0,909,1,0,0); -- Occ. quickens spellcasting+1%
INSERT INTO `augments` VALUES (352,0,0,0,0,0); -- Occ. grants dmg. bonus based on TP+1%
INSERT INTO `augments` VALUES (353,0,345,50,0,0); -- TP Bonus +50
INSERT INTO `augments` VALUES (354,0,430,1,0,0);  -- Quadruple Attack+1%
INSERT INTO `augments` VALUES (355,0,0,0,0,0); -- Enhancing Magic Recast Delay -1
INSERT INTO `augments` VALUES (356,0,375,1,0,0); -- Potency of Cure received+1%

-- 354 to 362 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (357,0,0,0,0,0);
INSERT INTO `augments` VALUES (358,0,0,0,0,0);
INSERT INTO `augments` VALUES (359,0,0,0,0,0);
INSERT INTO `augments` VALUES (360,0,880,10,0,0); -- Save TP+10: Mod undefined as of yet so leaving blank.
INSERT INTO `augments` VALUES (361,0,0,0,0,0);
-- End unused block

INSERT INTO `augments` VALUES (362,0,311,1,0,0); -- Magic Damage+1
INSERT INTO `augments` VALUES (363,0,518,1,0,0); -- Chance of successful block+1
INSERT INTO `augments` VALUES (364,0,0,0,0,0); -- 364 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (365,0,0,0,0,0); -- 365 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (366,0,0,0,0,0); -- Blood Pact Ability Delay II: (modId is 541 but no idea what the value of the augment is so leaving zero until the value is determined)
INSERT INTO `augments` VALUES (367,0,0,0,0,0); -- 367 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (368,0,301,1,0,0); -- Phalanx+1
INSERT INTO `augments` VALUES (369,0,126,1,1,1); -- Avatar: Blood Pact Dmg+1
INSERT INTO `augments` VALUES (370,0,836,1,0,0); -- Reverse Flourish+1
INSERT INTO `augments` VALUES (371,0,989,1,0,0); -- Regen Potency+1
INSERT INTO `augments` VALUES (372,0,0,0,0,0); -- Embolden+1: Mod undefined as of yet so leaving blank.

INSERT INTO `augments` VALUES (373,0,0,0,0,0);
INSERT INTO `augments` VALUES (374,0,0,0,0,0); -- Enhancing Magic Duration +1
INSERT INTO `augments` VALUES (375,0,0,0,0,0);
INSERT INTO `augments` VALUES (376,0,0,0,0,0);
INSERT INTO `augments` VALUES (377,0,0,0,0,0);
INSERT INTO `augments` VALUES (378,0,0,0,0,0);
INSERT INTO `augments` VALUES (379,0,0,0,0,0); -- Enmity +1 for each Utsusemi
INSERT INTO `augments` VALUES (380,0,0,0,0,0); -- Physical Damage Limit +1%

-- 381 to 511 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (381,0,0,0,0,0);
INSERT INTO `augments` VALUES (382,0,0,0,0,0);
INSERT INTO `augments` VALUES (383,0,0,0,0,0);
INSERT INTO `augments` VALUES (384,0,0,0,0,0);
INSERT INTO `augments` VALUES (385,0,0,0,0,0);
INSERT INTO `augments` VALUES (386,0,0,0,0,0);
INSERT INTO `augments` VALUES (387,0,0,0,0,0);
INSERT INTO `augments` VALUES (388,0,0,0,0,0);
INSERT INTO `augments` VALUES (389,0,0,0,0,0);
INSERT INTO `augments` VALUES (390,0,0,0,0,0);
INSERT INTO `augments` VALUES (391,0,0,0,0,0);
INSERT INTO `augments` VALUES (392,0,0,0,0,0);
INSERT INTO `augments` VALUES (393,0,0,0,0,0);
INSERT INTO `augments` VALUES (394,0,0,0,0,0);
INSERT INTO `augments` VALUES (395,0,0,0,0,0);
INSERT INTO `augments` VALUES (396,0,0,0,0,0);
INSERT INTO `augments` VALUES (397,0,0,0,0,0);
INSERT INTO `augments` VALUES (398,0,0,0,0,0);
INSERT INTO `augments` VALUES (399,0,0,0,0,0);
INSERT INTO `augments` VALUES (400,0,0,0,0,0);
INSERT INTO `augments` VALUES (401,0,0,0,0,0);
INSERT INTO `augments` VALUES (402,0,0,0,0,0);
INSERT INTO `augments` VALUES (403,0,0,0,0,0);
INSERT INTO `augments` VALUES (404,0,0,0,0,0);
INSERT INTO `augments` VALUES (405,0,0,0,0,0);
INSERT INTO `augments` VALUES (406,0,0,0,0,0);
INSERT INTO `augments` VALUES (407,0,0,0,0,0);
INSERT INTO `augments` VALUES (408,0,0,0,0,0);
INSERT INTO `augments` VALUES (409,0,0,0,0,0);
INSERT INTO `augments` VALUES (410,0,0,0,0,0);
INSERT INTO `augments` VALUES (411,0,0,0,0,0);
INSERT INTO `augments` VALUES (412,0,0,0,0,0);
INSERT INTO `augments` VALUES (413,0,0,0,0,0);
INSERT INTO `augments` VALUES (414,0,0,0,0,0);
INSERT INTO `augments` VALUES (415,0,0,0,0,0);
INSERT INTO `augments` VALUES (416,0,0,0,0,0);
INSERT INTO `augments` VALUES (417,0,0,0,0,0);
INSERT INTO `augments` VALUES (418,0,0,0,0,0);
INSERT INTO `augments` VALUES (419,0,0,0,0,0);
INSERT INTO `augments` VALUES (420,0,0,0,0,0);
INSERT INTO `augments` VALUES (421,0,0,0,0,0);
INSERT INTO `augments` VALUES (422,0,0,0,0,0);
INSERT INTO `augments` VALUES (423,0,0,0,0,0);
INSERT INTO `augments` VALUES (424,0,0,0,0,0);
INSERT INTO `augments` VALUES (425,0,0,0,0,0);
INSERT INTO `augments` VALUES (426,0,0,0,0,0);
INSERT INTO `augments` VALUES (427,0,0,0,0,0);
INSERT INTO `augments` VALUES (428,0,0,0,0,0);
INSERT INTO `augments` VALUES (429,0,0,0,0,0);
INSERT INTO `augments` VALUES (430,0,0,0,0,0);
INSERT INTO `augments` VALUES (431,0,0,0,0,0);
INSERT INTO `augments` VALUES (432,0,0,0,0,0);
INSERT INTO `augments` VALUES (433,0,0,0,0,0);
INSERT INTO `augments` VALUES (434,0,0,0,0,0);
INSERT INTO `augments` VALUES (435,0,0,0,0,0);
INSERT INTO `augments` VALUES (436,0,0,0,0,0);
INSERT INTO `augments` VALUES (437,0,0,0,0,0);
INSERT INTO `augments` VALUES (438,0,0,0,0,0);
INSERT INTO `augments` VALUES (439,0,0,0,0,0);
INSERT INTO `augments` VALUES (440,0,0,0,0,0);
INSERT INTO `augments` VALUES (441,0,0,0,0,0);
INSERT INTO `augments` VALUES (442,0,0,0,0,0);
INSERT INTO `augments` VALUES (443,0,0,0,0,0);
INSERT INTO `augments` VALUES (444,0,0,0,0,0);
INSERT INTO `augments` VALUES (445,0,0,0,0,0);
INSERT INTO `augments` VALUES (446,0,0,0,0,0);
INSERT INTO `augments` VALUES (447,0,0,0,0,0);
INSERT INTO `augments` VALUES (448,0,0,0,0,0);
INSERT INTO `augments` VALUES (449,0,0,0,0,0);
INSERT INTO `augments` VALUES (450,0,0,0,0,0);
INSERT INTO `augments` VALUES (451,0,0,0,0,0);
INSERT INTO `augments` VALUES (452,0,0,0,0,0);
INSERT INTO `augments` VALUES (453,0,0,0,0,0);
INSERT INTO `augments` VALUES (454,0,0,0,0,0);
INSERT INTO `augments` VALUES (455,0,0,0,0,0);
INSERT INTO `augments` VALUES (456,0,0,0,0,0);
INSERT INTO `augments` VALUES (457,0,0,0,0,0);
INSERT INTO `augments` VALUES (458,0,0,0,0,0);
INSERT INTO `augments` VALUES (459,0,0,0,0,0);
INSERT INTO `augments` VALUES (460,0,0,0,0,0);
INSERT INTO `augments` VALUES (461,0,0,0,0,0);
INSERT INTO `augments` VALUES (462,0,0,0,0,0);
INSERT INTO `augments` VALUES (463,0,0,0,0,0);
INSERT INTO `augments` VALUES (464,0,0,0,0,0);
INSERT INTO `augments` VALUES (465,0,0,0,0,0);
INSERT INTO `augments` VALUES (466,0,0,0,0,0);
INSERT INTO `augments` VALUES (467,0,0,0,0,0);
INSERT INTO `augments` VALUES (468,0,0,0,0,0);
INSERT INTO `augments` VALUES (469,0,0,0,0,0);
INSERT INTO `augments` VALUES (470,0,0,0,0,0);
INSERT INTO `augments` VALUES (471,0,0,0,0,0);
INSERT INTO `augments` VALUES (472,0,0,0,0,0);
INSERT INTO `augments` VALUES (473,0,0,0,0,0);
INSERT INTO `augments` VALUES (474,0,0,0,0,0);
INSERT INTO `augments` VALUES (475,0,0,0,0,0);
INSERT INTO `augments` VALUES (476,0,0,0,0,0);
INSERT INTO `augments` VALUES (477,0,0,0,0,0);
INSERT INTO `augments` VALUES (478,0,0,0,0,0);
INSERT INTO `augments` VALUES (479,0,0,0,0,0);
INSERT INTO `augments` VALUES (480,0,0,0,0,0);
INSERT INTO `augments` VALUES (481,0,0,0,0,0);
INSERT INTO `augments` VALUES (482,0,0,0,0,0);
INSERT INTO `augments` VALUES (483,0,0,0,0,0);
INSERT INTO `augments` VALUES (484,0,0,0,0,0);
INSERT INTO `augments` VALUES (485,0,0,0,0,0);
INSERT INTO `augments` VALUES (486,0,0,0,0,0);
INSERT INTO `augments` VALUES (487,0,0,0,0,0);
INSERT INTO `augments` VALUES (488,0,0,0,0,0);
INSERT INTO `augments` VALUES (489,0,0,0,0,0);
INSERT INTO `augments` VALUES (490,0,0,0,0,0);
INSERT INTO `augments` VALUES (491,0,0,0,0,0);
INSERT INTO `augments` VALUES (492,0,0,0,0,0);
INSERT INTO `augments` VALUES (493,0,0,0,0,0);
INSERT INTO `augments` VALUES (494,0,0,0,0,0);
INSERT INTO `augments` VALUES (495,0,0,0,0,0);
INSERT INTO `augments` VALUES (496,0,0,0,0,0);
INSERT INTO `augments` VALUES (497,0,0,0,0,0);
INSERT INTO `augments` VALUES (498,0,0,0,0,0);
INSERT INTO `augments` VALUES (499,0,0,0,0,0);
INSERT INTO `augments` VALUES (500,0,0,0,0,0);
INSERT INTO `augments` VALUES (501,0,0,0,0,0);
INSERT INTO `augments` VALUES (502,0,0,0,0,0);
INSERT INTO `augments` VALUES (503,0,0,0,0,0);
INSERT INTO `augments` VALUES (504,0,0,0,0,0);
INSERT INTO `augments` VALUES (505,0,0,0,0,0);
INSERT INTO `augments` VALUES (506,0,0,0,0,0);
INSERT INTO `augments` VALUES (507,0,0,0,0,0);
INSERT INTO `augments` VALUES (508,0,0,0,0,0);
INSERT INTO `augments` VALUES (509,0,0,0,0,0);
INSERT INTO `augments` VALUES (510,0,0,0,0,0);
INSERT INTO `augments` VALUES (511,0,0,0,0,0);
-- End unused block

INSERT INTO `augments` VALUES (512,0,8,1,0,0); -- STR+1
INSERT INTO `augments` VALUES (513,0,9,1,0,0); -- DEX+1
INSERT INTO `augments` VALUES (514,0,10,1,0,0); -- VIT+1
INSERT INTO `augments` VALUES (515,0,11,1,0,0); -- AGI+1
INSERT INTO `augments` VALUES (516,0,12,1,0,0); -- INT+1
INSERT INTO `augments` VALUES (517,0,13,1,0,0); -- MND+1
INSERT INTO `augments` VALUES (518,0,14,1,0,0); -- CHR+1
INSERT INTO `augments` VALUES (519,0,8,-1,0,0); -- STR-1
INSERT INTO `augments` VALUES (520,0,9,-1,0,0); -- DEX-1
INSERT INTO `augments` VALUES (521,0,10,-1,0,0); -- VIT-1
INSERT INTO `augments` VALUES (522,0,11,-1,0,0); -- AGI-1
INSERT INTO `augments` VALUES (523,0,12,-1,0,0); -- INT-1
INSERT INTO `augments` VALUES (524,0,13,-1,0,0); -- MND-1
INSERT INTO `augments` VALUES (525,0,14,-1,0,0); -- CHR-1
INSERT INTO `augments` VALUES (526,0,8,1,0,0); -- STR+1 DEX-1 VIT-1
INSERT INTO `augments` VALUES (526,0,9,-1,0,0); -- Cont.
INSERT INTO `augments` VALUES (526,0,10,-1,0,0); -- Cont.
INSERT INTO `augments` VALUES (527,0,8,1,0,0); -- STR+1 DEX-1 AGI-1
INSERT INTO `augments` VALUES (527,0,9,-1,0,0); -- Cont.
INSERT INTO `augments` VALUES (527,0,11,-1,0,0); -- Cont.
INSERT INTO `augments` VALUES (528,0,8,1,0,0); -- STR+1 VIT-1 AGI-1
INSERT INTO `augments` VALUES (528,0,10,-1,0,0); -- Cont.
INSERT INTO `augments` VALUES (528,0,11,-1,0,0); -- Cont.
INSERT INTO `augments` VALUES (529,0,8,-1,0,0); -- STR-1 DEX+1 VIT-1
INSERT INTO `augments` VALUES (529,0,9,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (529,0,10,-1,0,0); -- Cont.
INSERT INTO `augments` VALUES (530,0,8,-1,0,0); -- STR-1 DEX+1 AGI-1
INSERT INTO `augments` VALUES (530,0,9,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (530,0,11,-1,0,0); -- Cont.
INSERT INTO `augments` VALUES (531,0,9,1,0,0); -- DEX+1 VIT-1 AGI-1
INSERT INTO `augments` VALUES (531,0,10,-1,0,0); -- Cont.
INSERT INTO `augments` VALUES (531,0,11,-1,0,0); -- Cont.
INSERT INTO `augments` VALUES (532,0,8,-1,0,0); -- STR-1 DEX-1 VIT+1
INSERT INTO `augments` VALUES (532,0,9,-1,0,0); -- Cont.
INSERT INTO `augments` VALUES (532,0,10,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (533,0,8,-1,0,0); -- STR-1 VIT+1 AGI-1
INSERT INTO `augments` VALUES (533,0,10,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (533,0,11,-1,0,0); -- Cont.
INSERT INTO `augments` VALUES (534,0,9,-1,0,0); -- DEX-1 VIT+1 AGI-1
INSERT INTO `augments` VALUES (534,0,10,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (534,0,11,-1,0,0); -- Cont.
INSERT INTO `augments` VALUES (535,0,8,-1,0,0); -- STR-1 DEX-1 AGI+1
INSERT INTO `augments` VALUES (535,0,9,-1,0,0); -- Cont.
INSERT INTO `augments` VALUES (535,0,11,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (536,0,8,-1,0,0); -- STR-1 VIT-1 AGI+1
INSERT INTO `augments` VALUES (536,0,10,-1,0,0); -- Cont.
INSERT INTO `augments` VALUES (536,0,11,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (537,0,9,-1,0,0); -- DEX-1 VIT-1 AGI+1
INSERT INTO `augments` VALUES (537,0,10,-1,0,0); -- Cont.
INSERT INTO `augments` VALUES (537,0,11,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (538,0,11,1,0,0); -- AGI+1 INT-1 MND-1
INSERT INTO `augments` VALUES (538,0,12,-1,0,0); -- Cont.
INSERT INTO `augments` VALUES (538,0,13,-1,0,0); -- Cont.
INSERT INTO `augments` VALUES (539,0,11,1,0,0); -- AGI+1 INT-1 CHR-1
INSERT INTO `augments` VALUES (539,0,12,-1,0,0); -- Cont.
INSERT INTO `augments` VALUES (539,0,14,-1,0,0); -- Cont.
INSERT INTO `augments` VALUES (540,0,11,1,0,0); -- AGI+1 MND-1 CHR-1
INSERT INTO `augments` VALUES (540,0,13,-1,0,0); -- Cont.
INSERT INTO `augments` VALUES (540,0,14,-1,0,0); -- Cont.
INSERT INTO `augments` VALUES (541,0,11,-1,0,0); -- AGI-1 INT+1 MND-1
INSERT INTO `augments` VALUES (541,0,12,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (541,0,13,-1,0,0); -- Cont.
INSERT INTO `augments` VALUES (542,0,11,-1,0,0); -- AGI-1 INT+1 CHR-1
INSERT INTO `augments` VALUES (542,0,12,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (542,0,14,-1,0,0); -- Cont.
INSERT INTO `augments` VALUES (543,0,12,1,0,0); -- INT+1 MND-1 CHR-1
INSERT INTO `augments` VALUES (543,0,13,-1,0,0); -- Cont.
INSERT INTO `augments` VALUES (543,0,14,-1,0,0); -- Cont.
INSERT INTO `augments` VALUES (544,0,11,-1,0,0); -- AGI-1 INT-1 MND+1
INSERT INTO `augments` VALUES (544,0,12,-1,0,0); -- Cont.
INSERT INTO `augments` VALUES (544,0,13,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (545,0,11,-1,0,0); -- AGI-1 MND+1 CHR-1
INSERT INTO `augments` VALUES (545,0,13,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (545,0,14,-1,0,0); -- Cont.
INSERT INTO `augments` VALUES (546,0,12,-1,0,0); -- INT-1 MND+1 CHR-1
INSERT INTO `augments` VALUES (546,0,13,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (546,0,14,-1,0,0); -- Cont.
INSERT INTO `augments` VALUES (547,0,11,-1,0,0); -- AGI-1 INT-1 CHR+1
INSERT INTO `augments` VALUES (547,0,12,-1,0,0); -- Cont.
INSERT INTO `augments` VALUES (547,0,14,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (548,0,11,-1,0,0); -- AGI-1 MND-1 CHR+1
INSERT INTO `augments` VALUES (548,0,13,-1,0,0); -- Cont.
INSERT INTO `augments` VALUES (548,0,14,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (549,0,12,-1,0,0); -- INT-1 MND-1 CHR+1
INSERT INTO `augments` VALUES (549,0,13,-1,0,0); -- Cont.
INSERT INTO `augments` VALUES (549,0,14,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (550,0,8,1,0,0); -- STR+1 DEX+1
INSERT INTO `augments` VALUES (550,0,9,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (551,0,8,1,0,0); -- STR+1 VIT+1
INSERT INTO `augments` VALUES (551,0,10,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (552,0,8,1,0,0); -- STR+1 AGI+1
INSERT INTO `augments` VALUES (552,0,11,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (553,0,9,1,0,0); -- DEX+1 AGI+1
INSERT INTO `augments` VALUES (553,0,11,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (554,0,12,1,0,0); -- INT+1 MND+1
INSERT INTO `augments` VALUES (554,0,13,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (555,0,13,1,0,0); -- MND+1 CHR+1
INSERT INTO `augments` VALUES (555,0,14,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (556,0,12,1,0,0); -- INT+1 MND+1 CHR+1
INSERT INTO `augments` VALUES (556,0,13,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (556,0,14,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (557,0,8,1,0,0); -- STR+1 CHR+1
INSERT INTO `augments` VALUES (557,0,14,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (558,0,8,1,0,0); -- STR+1 INT+1
INSERT INTO `augments` VALUES (558,0,12,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (559,0,8,1,0,0); -- STR+1 MND+1
INSERT INTO `augments` VALUES (559,0,13,1,0,0); -- Cont.

-- 560 to 739 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (560,0,0,0,0,0);
INSERT INTO `augments` VALUES (561,0,0,0,0,0);
INSERT INTO `augments` VALUES (562,0,0,0,0,0);
INSERT INTO `augments` VALUES (563,0,0,0,0,0);
INSERT INTO `augments` VALUES (564,0,0,0,0,0);
INSERT INTO `augments` VALUES (565,0,0,0,0,0);
INSERT INTO `augments` VALUES (566,0,0,0,0,0);
INSERT INTO `augments` VALUES (567,0,0,0,0,0);
INSERT INTO `augments` VALUES (568,0,0,0,0,0);
INSERT INTO `augments` VALUES (569,0,0,0,0,0);
INSERT INTO `augments` VALUES (570,0,0,0,0,0);
INSERT INTO `augments` VALUES (571,0,0,0,0,0);
INSERT INTO `augments` VALUES (572,0,0,0,0,0);
INSERT INTO `augments` VALUES (573,0,0,0,0,0);
INSERT INTO `augments` VALUES (574,0,0,0,0,0);
INSERT INTO `augments` VALUES (575,0,0,0,0,0);
INSERT INTO `augments` VALUES (576,0,0,0,0,0);
INSERT INTO `augments` VALUES (577,0,0,0,0,0);
INSERT INTO `augments` VALUES (578,0,0,0,0,0);
INSERT INTO `augments` VALUES (579,0,0,0,0,0);
INSERT INTO `augments` VALUES (580,0,0,0,0,0);
INSERT INTO `augments` VALUES (581,0,0,0,0,0);
INSERT INTO `augments` VALUES (582,0,0,0,0,0);
INSERT INTO `augments` VALUES (583,0,0,0,0,0);
INSERT INTO `augments` VALUES (584,0,0,0,0,0);
INSERT INTO `augments` VALUES (585,0,0,0,0,0);
INSERT INTO `augments` VALUES (586,0,0,0,0,0);
INSERT INTO `augments` VALUES (587,0,0,0,0,0);
INSERT INTO `augments` VALUES (588,0,0,0,0,0);
INSERT INTO `augments` VALUES (589,0,0,0,0,0);
INSERT INTO `augments` VALUES (590,0,0,0,0,0);
INSERT INTO `augments` VALUES (591,0,0,0,0,0);
INSERT INTO `augments` VALUES (592,0,0,0,0,0);
INSERT INTO `augments` VALUES (593,0,0,0,0,0);
INSERT INTO `augments` VALUES (594,0,0,0,0,0);
INSERT INTO `augments` VALUES (595,0,0,0,0,0);
INSERT INTO `augments` VALUES (596,0,0,0,0,0);
INSERT INTO `augments` VALUES (597,0,0,0,0,0);
INSERT INTO `augments` VALUES (598,0,0,0,0,0);
INSERT INTO `augments` VALUES (599,0,0,0,0,0);
INSERT INTO `augments` VALUES (600,0,0,0,0,0);
INSERT INTO `augments` VALUES (601,0,0,0,0,0);
INSERT INTO `augments` VALUES (602,0,0,0,0,0);
INSERT INTO `augments` VALUES (603,0,0,0,0,0);
INSERT INTO `augments` VALUES (604,0,0,0,0,0);
INSERT INTO `augments` VALUES (605,0,0,0,0,0);
INSERT INTO `augments` VALUES (606,0,0,0,0,0);
INSERT INTO `augments` VALUES (607,0,0,0,0,0);
INSERT INTO `augments` VALUES (608,0,0,0,0,0);
INSERT INTO `augments` VALUES (609,0,0,0,0,0);
INSERT INTO `augments` VALUES (610,0,0,0,0,0);
INSERT INTO `augments` VALUES (611,0,0,0,0,0);
INSERT INTO `augments` VALUES (612,0,0,0,0,0);
INSERT INTO `augments` VALUES (613,0,0,0,0,0);
INSERT INTO `augments` VALUES (614,0,0,0,0,0);
INSERT INTO `augments` VALUES (615,0,0,0,0,0);
INSERT INTO `augments` VALUES (616,0,0,0,0,0);
INSERT INTO `augments` VALUES (617,0,0,0,0,0);
INSERT INTO `augments` VALUES (618,0,0,0,0,0);
INSERT INTO `augments` VALUES (619,0,0,0,0,0);
INSERT INTO `augments` VALUES (620,0,0,0,0,0);
INSERT INTO `augments` VALUES (621,0,0,0,0,0);
INSERT INTO `augments` VALUES (622,0,0,0,0,0);
INSERT INTO `augments` VALUES (623,0,0,0,0,0);
INSERT INTO `augments` VALUES (624,0,0,0,0,0);
INSERT INTO `augments` VALUES (625,0,0,0,0,0);
INSERT INTO `augments` VALUES (626,0,0,0,0,0);
INSERT INTO `augments` VALUES (627,0,0,0,0,0);
INSERT INTO `augments` VALUES (628,0,0,0,0,0);
INSERT INTO `augments` VALUES (629,0,0,0,0,0);
INSERT INTO `augments` VALUES (630,0,0,0,0,0);
INSERT INTO `augments` VALUES (631,0,0,0,0,0);
INSERT INTO `augments` VALUES (632,0,0,0,0,0);
INSERT INTO `augments` VALUES (633,0,0,0,0,0);
INSERT INTO `augments` VALUES (634,0,0,0,0,0);
INSERT INTO `augments` VALUES (635,0,0,0,0,0);
INSERT INTO `augments` VALUES (636,0,0,0,0,0);
INSERT INTO `augments` VALUES (637,0,0,0,0,0);
INSERT INTO `augments` VALUES (638,0,0,0,0,0);
INSERT INTO `augments` VALUES (639,0,0,0,0,0);
INSERT INTO `augments` VALUES (640,2,291,2,0,0); -- Counter +2 (increases by 2)
INSERT INTO `augments` VALUES (641,0,0,0,0,0);
INSERT INTO `augments` VALUES (642,0,0,0,0,0);
INSERT INTO `augments` VALUES (643,0,0,0,0,0);
INSERT INTO `augments` VALUES (644,0,0,0,0,0);
INSERT INTO `augments` VALUES (645,0,0,0,0,0);
INSERT INTO `augments` VALUES (646,0,0,0,0,0);
INSERT INTO `augments` VALUES (647,0,0,0,0,0);
INSERT INTO `augments` VALUES (648,0,0,0,0,0);
INSERT INTO `augments` VALUES (649,0,0,0,0,0);
INSERT INTO `augments` VALUES (650,0,0,0,0,0);
INSERT INTO `augments` VALUES (651,0,0,0,0,0);
INSERT INTO `augments` VALUES (652,0,0,0,0,0);
INSERT INTO `augments` VALUES (653,0,0,0,0,0);
INSERT INTO `augments` VALUES (654,0,0,0,0,0);
INSERT INTO `augments` VALUES (655,0,0,0,0,0);
INSERT INTO `augments` VALUES (656,0,0,0,0,0);
INSERT INTO `augments` VALUES (657,0,0,0,0,0);
INSERT INTO `augments` VALUES (658,0,0,0,0,0);
INSERT INTO `augments` VALUES (659,0,0,0,0,0);
INSERT INTO `augments` VALUES (660,0,0,0,0,0);
INSERT INTO `augments` VALUES (661,0,0,0,0,0);
INSERT INTO `augments` VALUES (662,0,0,0,0,0);
INSERT INTO `augments` VALUES (663,0,0,0,0,0);
INSERT INTO `augments` VALUES (664,0,0,0,0,0);
INSERT INTO `augments` VALUES (665,0,0,0,0,0);
INSERT INTO `augments` VALUES (666,0,0,0,0,0);
INSERT INTO `augments` VALUES (667,0,0,0,0,0);
INSERT INTO `augments` VALUES (668,0,0,0,0,0);
INSERT INTO `augments` VALUES (669,0,0,0,0,0);
INSERT INTO `augments` VALUES (670,0,0,0,0,0);
INSERT INTO `augments` VALUES (671,0,0,0,0,0);
INSERT INTO `augments` VALUES (672,0,0,0,0,0);
INSERT INTO `augments` VALUES (673,0,0,0,0,0);
INSERT INTO `augments` VALUES (674,0,0,0,0,0);
INSERT INTO `augments` VALUES (675,0,0,0,0,0);
INSERT INTO `augments` VALUES (676,0,0,0,0,0);
INSERT INTO `augments` VALUES (677,0,0,0,0,0);
INSERT INTO `augments` VALUES (678,0,0,0,0,0);
INSERT INTO `augments` VALUES (679,0,0,0,0,0);
INSERT INTO `augments` VALUES (680,0,0,0,0,0);
INSERT INTO `augments` VALUES (681,0,0,0,0,0);
INSERT INTO `augments` VALUES (682,0,0,0,0,0);
INSERT INTO `augments` VALUES (683,0,0,0,0,0);
INSERT INTO `augments` VALUES (684,0,0,0,0,0);
INSERT INTO `augments` VALUES (685,0,0,0,0,0);
INSERT INTO `augments` VALUES (686,0,0,0,0,0);
INSERT INTO `augments` VALUES (687,0,0,0,0,0);
INSERT INTO `augments` VALUES (688,0,0,0,0,0);
INSERT INTO `augments` VALUES (689,0,0,0,0,0);
INSERT INTO `augments` VALUES (690,0,0,0,0,0);
INSERT INTO `augments` VALUES (691,0,0,0,0,0);
INSERT INTO `augments` VALUES (692,0,0,0,0,0);
INSERT INTO `augments` VALUES (693,0,0,0,0,0);
INSERT INTO `augments` VALUES (694,0,0,0,0,0);
INSERT INTO `augments` VALUES (695,0,0,0,0,0);
INSERT INTO `augments` VALUES (696,0,0,0,0,0);
INSERT INTO `augments` VALUES (697,0,0,0,0,0);
INSERT INTO `augments` VALUES (698,0,0,0,0,0);
INSERT INTO `augments` VALUES (699,0,0,0,0,0);
INSERT INTO `augments` VALUES (700,0,0,0,0,0);
INSERT INTO `augments` VALUES (701,0,0,0,0,0);
INSERT INTO `augments` VALUES (702,0,0,0,0,0);
INSERT INTO `augments` VALUES (703,0,0,0,0,0);
INSERT INTO `augments` VALUES (704,0,0,0,0,0);
INSERT INTO `augments` VALUES (705,0,0,0,0,0);
INSERT INTO `augments` VALUES (706,0,0,0,0,0);
INSERT INTO `augments` VALUES (707,0,0,0,0,0);
INSERT INTO `augments` VALUES (708,0,0,0,0,0);
INSERT INTO `augments` VALUES (709,0,0,0,0,0);
INSERT INTO `augments` VALUES (710,0,0,0,0,0);
INSERT INTO `augments` VALUES (711,0,0,0,0,0);
INSERT INTO `augments` VALUES (712,0,0,0,0,0);
INSERT INTO `augments` VALUES (713,0,0,0,0,0);
INSERT INTO `augments` VALUES (714,0,0,0,0,0);
INSERT INTO `augments` VALUES (715,0,0,0,0,0);
INSERT INTO `augments` VALUES (716,0,0,0,0,0);
INSERT INTO `augments` VALUES (717,0,0,0,0,0);
INSERT INTO `augments` VALUES (718,0,0,0,0,0);
INSERT INTO `augments` VALUES (719,0,0,0,0,0);
INSERT INTO `augments` VALUES (720,0,0,0,0,0);
INSERT INTO `augments` VALUES (721,0,0,0,0,0);
INSERT INTO `augments` VALUES (722,0,0,0,0,0);
INSERT INTO `augments` VALUES (723,0,0,0,0,0);
INSERT INTO `augments` VALUES (724,0,0,0,0,0);
INSERT INTO `augments` VALUES (725,0,0,0,0,0);
INSERT INTO `augments` VALUES (726,0,0,0,0,0);
INSERT INTO `augments` VALUES (727,0,0,0,0,0);
INSERT INTO `augments` VALUES (728,0,0,0,0,0);
INSERT INTO `augments` VALUES (729,0,0,0,0,0);
INSERT INTO `augments` VALUES (730,0,0,0,0,0);
INSERT INTO `augments` VALUES (731,0,0,0,0,0);
INSERT INTO `augments` VALUES (732,0,0,0,0,0);
INSERT INTO `augments` VALUES (733,0,0,0,0,0);
INSERT INTO `augments` VALUES (734,0,0,0,0,0);
INSERT INTO `augments` VALUES (735,0,0,0,0,0);
INSERT INTO `augments` VALUES (736,0,0,0,0,0);
INSERT INTO `augments` VALUES (737,0,0,0,0,0);
INSERT INTO `augments` VALUES (738,0,0,0,0,0);
INSERT INTO `augments` VALUES (739,0,0,0,0,0);
-- End unused block

INSERT INTO `augments` VALUES (740,0,0,0,0,0); -- DMG:+1
insert into `augments` values (741,0,0,0,0,0); -- Dmg:+33   Needs to work in either hand,whichever one the weapon is equipped in.
insert into `augments` values (742,0,0,0,0,0); -- Dmg:+65   Ranged weapons use diff AugID (starts at 746) and diff ModID.
insert into `augments` values (743,0,0,0,0,0); -- Dmg:+97    (melee,not ranged)
insert into `augments` values (744,0,0,0,0,0); -- Dmg:-1    (melee,not ranged)
insert into `augments` values (745,0,0,0,0,0); -- Dmg:-33    (melee,not ranged)
insert into `augments` values (746,0,0,0,0,0); -- Dmg:+1    (ranged,not melee)
insert into `augments` values (747,0,0,0,0,0); -- Dmg:+33    (ranged,not melee)
insert into `augments` values (748,0,0,0,0,0); -- Dmg:+65    (ranged,not melee)
insert into `augments` values (749,0,0,0,0,0); -- Dmg:+97    (ranged,not melee)
insert into `augments` values (750,0,0,0,0,0); -- Dmg:-1    (ranged,not melee)
insert into `augments` values (751,0,0,0,0,0); -- Dmg:-33    (ranged,not melee)
insert into `augments` values (752,0,0,0,0,0); -- Delay:+1    (melee,not ranged)
insert into `augments` values (753,0,0,0,0,0); -- Delay:+33    (melee,not ranged)
insert into `augments` values (754,0,0,0,0,0); -- Delay:+65    (melee,not ranged)
insert into `augments` values (755,0,0,0,0,0); -- Delay:+97    (melee,not ranged)
insert into `augments` values (756,0,0,0,0,0); -- Delay:-1    (melee,not ranged)
insert into `augments` values (757,0,0,0,0,0); -- Delay:-33    (melee,not ranged)
insert into `augments` values (758,0,0,0,0,0); -- Delay:-65    (melee,not ranged)
insert into `augments` values (759,0,0,0,0,0); -- Delay:-97    (melee,not ranged)
insert into `augments` values (760,0,0,0,0,0); -- Delay:+1    (ranged,not melee)
insert into `augments` values (761,0,0,0,0,0); -- Delay:+33    (ranged,not melee)
insert into `augments` values (762,0,0,0,0,0); -- Delay:+65    (ranged,not melee)
insert into `augments` values (763,0,0,0,0,0); -- Delay:+97    (ranged,not melee)
insert into `augments` values (764,0,0,0,0,0); -- Delay:-1    (ranged,not melee)
insert into `augments` values (765,0,0,0,0,0); -- Delay:-33    (ranged,not melee)
insert into `augments` values (766,0,0,0,0,0); -- Delay:-65    (ranged,not melee)
insert into `augments` values (767,0,0,0,0,0); -- Delay:-97    (ranged,not melee)
INSERT INTO `augments` VALUES (768,0,15,1,0,0); -- Fire resist+1
INSERT INTO `augments` VALUES (769,0,16,1,0,0); -- Ice resist+1
INSERT INTO `augments` VALUES (770,0,17,1,0,0); -- Wind resist+1
INSERT INTO `augments` VALUES (771,0,18,1,0,0); -- Earth resist+1
INSERT INTO `augments` VALUES (772,0,19,1,0,0); -- Lightning resist+1
INSERT INTO `augments` VALUES (773,0,20,1,0,0); -- Water resist+1
INSERT INTO `augments` VALUES (774,0,21,1,0,0); -- Light resist+1
INSERT INTO `augments` VALUES (775,0,22,1,0,0); -- Dark resist+1
INSERT INTO `augments` VALUES (776,0,15,-1,0,0); -- Fire resist-1
INSERT INTO `augments` VALUES (777,0,16,-1,0,0); -- Ice resist-1
INSERT INTO `augments` VALUES (778,0,17,-1,0,0); -- Wind resist-1
INSERT INTO `augments` VALUES (779,0,18,-1,0,0); -- Earth resist-1
INSERT INTO `augments` VALUES (780,0,19,-1,0,0); -- Lightning resist-1
INSERT INTO `augments` VALUES (781,0,20,-1,0,0); -- Water resist-1
INSERT INTO `augments` VALUES (782,0,21,-1,0,0); -- Light resist-1
INSERT INTO `augments` VALUES (783,0,22,-1,0,0); -- Dark resist-1
INSERT INTO `augments` VALUES (784,0,15,1,0,0); -- Fire resist+1 Water resist-1
INSERT INTO `augments` VALUES (784,0,20,-1,0,0); -- Cont.
INSERT INTO `augments` VALUES (785,0,15,-1,0,0); -- Fire resist-1 Water resist+1
INSERT INTO `augments` VALUES (785,0,20,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (786,0,16,-1,0,0); -- Ice resist-1 Wind resist+1
INSERT INTO `augments` VALUES (786,0,17,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (787,0,17,-1,0,0); -- Wind resist-1 Earth resist+1
INSERT INTO `augments` VALUES (787,0,18,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (788,0,18,-1,0,0); -- Earth resist-1 Lightning resist+1
INSERT INTO `augments` VALUES (788,0,19,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (789,0,19,-1,0,0); -- Lightning resist-1 Water resist+1
INSERT INTO `augments` VALUES (789,0,20,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (790,0,21,1,0,0); -- Light resist+1 Dark resist-1
INSERT INTO `augments` VALUES (790,0,22,-1,0,0); -- Cont.
INSERT INTO `augments` VALUES (791,0,21,-1,0,0); -- Light resist-1 Dark resist+1
INSERT INTO `augments` VALUES (791,0,22,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (792,0,15,1,0,0); -- Fire,Wind,Lightning,Light resists+1
INSERT INTO `augments` VALUES (792,0,17,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (792,0,19,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (792,0,21,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (793,0,16,1,0,0); -- Ice,Earth,Water,Dark resists+1
INSERT INTO `augments` VALUES (793,0,18,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (793,0,20,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (793,0,22,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (794,0,15,1,0,0); -- Fire,Wind,Lightning,Light resists+1,Ice,Earth,Water,Dark resists-1
INSERT INTO `augments` VALUES (794,0,17,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (794,0,19,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (794,0,21,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (794,0,16,-1,0,0); -- Cont.
INSERT INTO `augments` VALUES (794,0,18,-1,0,0); -- Cont.
INSERT INTO `augments` VALUES (794,0,20,-1,0,0); -- Cont.
INSERT INTO `augments` VALUES (794,0,22,-1,0,0); -- Cont.
INSERT INTO `augments` VALUES (795,0,15,-1,0,0); -- Fire,Wind,Lightning,Light resists-1,Ice,Earth,Water,Dark resists+1
INSERT INTO `augments` VALUES (795,0,17,-1,0,0); -- Cont.
INSERT INTO `augments` VALUES (795,0,19,-1,0,0); -- Cont.
INSERT INTO `augments` VALUES (795,0,21,-1,0,0); -- Cont.
INSERT INTO `augments` VALUES (795,0,16,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (795,0,18,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (795,0,20,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (795,0,22,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (796,0,15,1,0,0); -- All elemental resists+1
INSERT INTO `augments` VALUES (796,0,16,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (796,0,17,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (796,0,18,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (796,0,19,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (796,0,20,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (796,0,21,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (796,0,22,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (797,0,15,-1,0,0); -- All elemental resists -1
INSERT INTO `augments` VALUES (797,0,16,-1,0,0); -- Cont.
INSERT INTO `augments` VALUES (797,0,17,-1,0,0); -- Cont.
INSERT INTO `augments` VALUES (797,0,18,-1,0,0); -- Cont.
INSERT INTO `augments` VALUES (797,0,19,-1,0,0); -- Cont.
INSERT INTO `augments` VALUES (797,0,20,-1,0,0); -- Cont.
INSERT INTO `augments` VALUES (797,0,21,-1,0,0); -- Cont.
INSERT INTO `augments` VALUES (797,0,22,-1,0,0); -- Cont.

-- 798 to 927 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (798,0,0,0,0,0);
INSERT INTO `augments` VALUES (799,0,0,0,0,0);
INSERT INTO `augments` VALUES (800,0,0,0,0,0);
INSERT INTO `augments` VALUES (801,0,0,0,0,0);
INSERT INTO `augments` VALUES (802,0,0,0,0,0);
INSERT INTO `augments` VALUES (803,0,0,0,0,0);
INSERT INTO `augments` VALUES (804,0,0,0,0,0);
INSERT INTO `augments` VALUES (805,0,0,0,0,0);
INSERT INTO `augments` VALUES (806,0,0,0,0,0);
INSERT INTO `augments` VALUES (807,0,0,0,0,0);
INSERT INTO `augments` VALUES (808,0,0,0,0,0);
INSERT INTO `augments` VALUES (809,0,0,0,0,0);
INSERT INTO `augments` VALUES (810,0,0,0,0,0);
INSERT INTO `augments` VALUES (811,0,0,0,0,0);
INSERT INTO `augments` VALUES (812,0,0,0,0,0);
INSERT INTO `augments` VALUES (813,0,0,0,0,0);
INSERT INTO `augments` VALUES (814,0,0,0,0,0);
INSERT INTO `augments` VALUES (815,0,0,0,0,0);
INSERT INTO `augments` VALUES (816,0,0,0,0,0);
INSERT INTO `augments` VALUES (817,0,0,0,0,0);
INSERT INTO `augments` VALUES (818,0,0,0,0,0);
INSERT INTO `augments` VALUES (819,0,0,0,0,0);
INSERT INTO `augments` VALUES (820,0,0,0,0,0);
INSERT INTO `augments` VALUES (821,0,0,0,0,0);
INSERT INTO `augments` VALUES (822,0,0,0,0,0);
INSERT INTO `augments` VALUES (823,0,0,0,0,0);
INSERT INTO `augments` VALUES (824,0,0,0,0,0);
INSERT INTO `augments` VALUES (825,0,0,0,0,0);
INSERT INTO `augments` VALUES (826,0,0,0,0,0);
INSERT INTO `augments` VALUES (827,0,0,0,0,0);
INSERT INTO `augments` VALUES (828,0,0,0,0,0);
INSERT INTO `augments` VALUES (829,0,0,0,0,0);
INSERT INTO `augments` VALUES (830,0,0,0,0,0);
INSERT INTO `augments` VALUES (831,0,0,0,0,0);
-- NOTICE: additional effect augments will not work until we finish refactoring additional effects and fill in values here.
INSERT INTO `augments` VALUES (832,0,0,0,0,0); -- Additional Effect: Fire Dmg      (Base of 5,each additional point +1 for range of 5 to 36)
INSERT INTO `augments` VALUES (833,0,0,0,0,0); -- Additional Effect: Ice Dmg       (Base of 5,each additional point +1 for range of 5 to 36)
INSERT INTO `augments` VALUES (834,0,0,0,0,0); -- Additional Effect: Wind Dmg      (Base of 5,each additional point +1 for range of 5 to 36)
INSERT INTO `augments` VALUES (835,0,0,0,0,0); -- Additional Effect: Earth Dmg     (Base of 5,each additional point +1 for range of 5 to 36)
INSERT INTO `augments` VALUES (836,0,0,0,0,0); -- Additional Effect: Lightning Dmg (Base of 5,each additional point +1 for range of 5 to 36)
INSERT INTO `augments` VALUES (837,0,0,0,0,0); -- Additional Effect: Water Dmg     (Base of 5,each additional point +1 for range of 5 to 36)
INSERT INTO `augments` VALUES (838,0,0,0,0,0); -- Additional Effect: Light Dmg     (Base of 5,each additional point +1 for range of 5 to 36)
INSERT INTO `augments` VALUES (839,0,0,0,0,0); -- Additional Effect: Darkness Dmg  (Base of 5,each additional point +1 for range of 5 to 36)
INSERT INTO `augments` VALUES (840,0,0,0,0,0); -- Additional Effect: Disease +1
INSERT INTO `augments` VALUES (841,0,0,0,0,0); -- Additional Effect: Paralysis +1
INSERT INTO `augments` VALUES (842,0,0,0,0,0); -- Additional Effect: Silence +1
INSERT INTO `augments` VALUES (843,0,0,0,0,0); -- Additional Effect: Slow +1
INSERT INTO `augments` VALUES (844,0,0,0,0,0); -- Additional Effect: Stun +1
INSERT INTO `augments` VALUES (845,0,0,0,0,0); -- Additional Effect: Poison +1
INSERT INTO `augments` VALUES (846,0,0,0,0,0); -- Additional Effect: Flash +1
INSERT INTO `augments` VALUES (847,0,0,0,0,0); -- Additional Effect: Blindness +1
INSERT INTO `augments` VALUES (848,0,0,0,0,0); -- Additional Effect: Weakens Defense +1
INSERT INTO `augments` VALUES (849,0,0,0,0,0); -- Additional Effect: Sleep +1
INSERT INTO `augments` VALUES (850,0,0,0,0,0); -- Additional Effect: Weakens Attack +1
INSERT INTO `augments` VALUES (851,0,0,0,0,0); -- Additional Effect: Impairs Evasion +1
INSERT INTO `augments` VALUES (852,0,0,0,0,0); -- Additional Effect: Lowers Accuracy +1
INSERT INTO `augments` VALUES (853,0,0,0,0,0); -- Additional Effect: Lowers Magic Evasion +1
INSERT INTO `augments` VALUES (854,0,0,0,0,0); -- Additional Effect: Lowers Magic Attack +1
INSERT INTO `augments` VALUES (855,0,0,0,0,0); -- Additional Effect: Lowers Magic Defense +1
INSERT INTO `augments` VALUES (856,0,0,0,0,0); -- Additional Effect: Lowers Magic Accuracy +1
INSERT INTO `augments` VALUES (857,0,0,0,0,0);
INSERT INTO `augments` VALUES (858,0,0,0,0,0);
INSERT INTO `augments` VALUES (859,0,0,0,0,0);
INSERT INTO `augments` VALUES (860,0,0,0,0,0);
INSERT INTO `augments` VALUES (861,0,0,0,0,0);
INSERT INTO `augments` VALUES (862,0,0,0,0,0);
INSERT INTO `augments` VALUES (863,0,0,0,0,0);
INSERT INTO `augments` VALUES (864,0,0,0,0,0);
INSERT INTO `augments` VALUES (865,0,0,0,0,0);
INSERT INTO `augments` VALUES (866,0,0,0,0,0);
INSERT INTO `augments` VALUES (867,0,0,0,0,0);
INSERT INTO `augments` VALUES (868,0,0,0,0,0);
INSERT INTO `augments` VALUES (869,0,0,0,0,0);
INSERT INTO `augments` VALUES (870,0,0,0,0,0);
INSERT INTO `augments` VALUES (871,0,0,0,0,0);
INSERT INTO `augments` VALUES (872,0,0,0,0,0);
INSERT INTO `augments` VALUES (873,0,0,0,0,0);
INSERT INTO `augments` VALUES (874,0,0,0,0,0);
INSERT INTO `augments` VALUES (875,0,0,0,0,0);
INSERT INTO `augments` VALUES (876,0,0,0,0,0);
INSERT INTO `augments` VALUES (877,0,0,0,0,0);
INSERT INTO `augments` VALUES (878,0,0,0,0,0);
INSERT INTO `augments` VALUES (879,0,0,0,0,0);
INSERT INTO `augments` VALUES (880,0,0,0,0,0);
INSERT INTO `augments` VALUES (881,0,0,0,0,0);
INSERT INTO `augments` VALUES (882,0,0,0,0,0);
INSERT INTO `augments` VALUES (883,0,0,0,0,0);
INSERT INTO `augments` VALUES (884,0,0,0,0,0);
INSERT INTO `augments` VALUES (885,0,0,0,0,0);
INSERT INTO `augments` VALUES (886,0,0,0,0,0);
INSERT INTO `augments` VALUES (887,0,0,0,0,0);
INSERT INTO `augments` VALUES (888,0,0,0,0,0);
INSERT INTO `augments` VALUES (889,0,0,0,0,0);
INSERT INTO `augments` VALUES (890,0,0,0,0,0);
INSERT INTO `augments` VALUES (891,0,0,0,0,0);
INSERT INTO `augments` VALUES (892,0,0,0,0,0);
INSERT INTO `augments` VALUES (893,0,0,0,0,0);
INSERT INTO `augments` VALUES (894,0,0,0,0,0);
INSERT INTO `augments` VALUES (895,0,0,0,0,0);
INSERT INTO `augments` VALUES (896,0,432,1,0,0); -- Sword Enhancement Spell Damage +1
INSERT INTO `augments` VALUES (897,0,96,1,0,0); -- Enhances Souleater Effect +1%
INSERT INTO `augments` VALUES (898,0,0,0,0,0);
INSERT INTO `augments` VALUES (899,0,0,0,0,0); --  Sword Enhancement spell damage +1% (Percent Damage)
INSERT INTO `augments` VALUES (900,0,0,0,0,0);
INSERT INTO `augments` VALUES (901,0,0,0,0,0);
INSERT INTO `augments` VALUES (902,0,0,0,0,0);
INSERT INTO `augments` VALUES (903,0,0,0,0,0);
INSERT INTO `augments` VALUES (904,0,0,0,0,0);
INSERT INTO `augments` VALUES (905,0,0,0,0,0);
INSERT INTO `augments` VALUES (906,0,0,0,0,0);
INSERT INTO `augments` VALUES (907,0,0,0,0,0);
INSERT INTO `augments` VALUES (908,0,0,0,0,0);
INSERT INTO `augments` VALUES (909,0,0,0,0,0);
INSERT INTO `augments` VALUES (910,0,0,0,0,0);
INSERT INTO `augments` VALUES (911,0,0,0,0,0);
INSERT INTO `augments` VALUES (912,0,0,0,0,0);
INSERT INTO `augments` VALUES (913,0,169,6,0,0); -- Movement Speed
INSERT INTO `augments` VALUES (914,0,0,0,0,0);
INSERT INTO `augments` VALUES (915,0,0,0,0,0);
INSERT INTO `augments` VALUES (916,0,0,0,0,0);
INSERT INTO `augments` VALUES (917,0,0,0,0,0);
INSERT INTO `augments` VALUES (918,0,0,0,0,0);
INSERT INTO `augments` VALUES (919,0,0,0,0,0);
INSERT INTO `augments` VALUES (920,0,0,0,0,0);
INSERT INTO `augments` VALUES (921,0,0,0,0,0);
INSERT INTO `augments` VALUES (922,0,0,0,0,0);
INSERT INTO `augments` VALUES (923,0,0,0,0,0);
INSERT INTO `augments` VALUES (924,0,0,0,0,0);
INSERT INTO `augments` VALUES (925,0,0,0,0,0);
INSERT INTO `augments` VALUES (926,0,0,0,0,0);
INSERT INTO `augments` VALUES (927,0,0,0,0,0);
-- End unused block

-- The Elemental affinity increase matches value,not displayed if value is zero.
INSERT INTO `augments` VALUES (928,0,347,1,0,0); -- Fire Affinity+1
INSERT INTO `augments` VALUES (928,0,544,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (928,0,553,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (929,0,348,1,0,0); -- Ice Affinity+1
INSERT INTO `augments` VALUES (929,0,545,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (929,0,554,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (930,0,349,1,0,0); -- Wind Affinity+1
INSERT INTO `augments` VALUES (930,0,546,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (930,0,555,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (931,0,350,1,0,0); -- Earth Affinity+1
INSERT INTO `augments` VALUES (931,0,547,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (931,0,556,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (932,0,351,1,0,0); -- Lightning Affinity+1
INSERT INTO `augments` VALUES (932,0,548,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (932,0,557,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (933,0,352,1,0,0); -- Water Affinity+1
INSERT INTO `augments` VALUES (933,0,549,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (933,0,558,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (934,0,353,1,0,0); -- Light Affinity+1
INSERT INTO `augments` VALUES (934,0,550,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (934,0,559,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (935,0,354,1,0,0); -- Dark Affinity+1
INSERT INTO `augments` VALUES (935,0,551,1,0,0); -- Cont.
INSERT INTO `augments` VALUES (935,0,560,1,0,0); -- Cont.

INSERT INTO `augments` VALUES (936,0,544,1,0,0); -- Fire Affinity Magic Accuracy+1
INSERT INTO `augments` VALUES (937,0,545,1,0,0); -- Ice Affinity Magic Accuracy+1
INSERT INTO `augments` VALUES (938,0,546,1,0,0); -- Wind Affinity Magic Accuracy+1
INSERT INTO `augments` VALUES (939,0,547,1,0,0); -- Earth Affinity Magic Accuracy+1
INSERT INTO `augments` VALUES (940,0,548,1,0,0); -- Lightning Affinity Magic Accuracy+1
INSERT INTO `augments` VALUES (941,0,549,1,0,0); -- Water Affinity Magic Accuracy+1
INSERT INTO `augments` VALUES (942,0,550,1,0,0); -- Light Affinity Magic Accuracy+1
INSERT INTO `augments` VALUES (943,0,551,1,0,0); -- Dark Affinity Magic Accuracy+1
INSERT INTO `augments` VALUES (944,0,347,1,0,0); -- Fire Affinity Magic Damage+1
INSERT INTO `augments` VALUES (945,0,348,1,0,0); -- Ice Affinity Magic Damage+1
INSERT INTO `augments` VALUES (946,0,349,1,0,0); -- Wind Affinity Magic Damage+1
INSERT INTO `augments` VALUES (947,0,350,1,0,0); -- Earth Affinity Magic Damage+1
INSERT INTO `augments` VALUES (948,0,351,1,0,0); -- Lightning Affinity Magic Damage+1
INSERT INTO `augments` VALUES (949,0,352,1,0,0); -- Water Affinity Magic Damage+1
INSERT INTO `augments` VALUES (950,0,353,1,0,0); -- Light Affinity Magic Damage+1
INSERT INTO `augments` VALUES (951,0,354,1,0,0); -- Dark Affinity Magic Damage+1
INSERT INTO `augments` VALUES (952,0,553,1,0,0); -- Fire Affinity: Avatar perp. cost -1
INSERT INTO `augments` VALUES (953,0,554,1,0,0); -- Ice Affinity: Avatar perp. cost -1
INSERT INTO `augments` VALUES (954,0,555,1,0,0); -- Wind Affinity: Avatar perp. cost -1
INSERT INTO `augments` VALUES (955,0,556,1,0,0); -- Earth Affinity: Avatar perp. cost -1
INSERT INTO `augments` VALUES (956,0,557,1,0,0); -- Thunder Affinity: Avatar perp. cost -1
INSERT INTO `augments` VALUES (957,0,558,1,0,0); -- Water Affinity: Avatar perp. cost -1
INSERT INTO `augments` VALUES (958,0,559,1,0,0); -- Light Affinity: Avatar perp. cost -1
INSERT INTO `augments` VALUES (959,0,560,1,0,0); -- Dark Affinity: Avatar perp. cost -1

-- For 960 to 975 and 984 to 1015 the values behave differently.
-- The Magic Accuracy increase matches value,not displayed if value is zero.
INSERT INTO `augments` VALUES (960,0,544,1,0,0); -- Fire Affinity: Magic Accuracy+0 Recast time -2% (Increases by 2)
INSERT INTO `augments` VALUES (960,0,0,0,0,0); -- Cont.
INSERT INTO `augments` VALUES (961,0,545,1,0,0); -- Ice Affinity: (otherwise same as augID 960)
INSERT INTO `augments` VALUES (961,0,0,0,0,0); -- Cont.
INSERT INTO `augments` VALUES (962,0,546,1,0,0); -- Wind Affinity: (otherwise same as augID 960)
INSERT INTO `augments` VALUES (962,0,0,0,0,0); -- Cont.
INSERT INTO `augments` VALUES (963,0,547,1,0,0); -- Earth Affinity: (otherwise same as augID 960)
INSERT INTO `augments` VALUES (963,0,0,0,0,0); -- Cont.
INSERT INTO `augments` VALUES (964,0,548,1,0,0); -- Lightning Affinity: (otherwise same as augID 960)
INSERT INTO `augments` VALUES (964,0,0,0,0,0); -- Cont.
INSERT INTO `augments` VALUES (965,0,549,1,0,0); -- Water Affinity: (otherwise same as augID 960)
INSERT INTO `augments` VALUES (965,0,0,0,0,0); -- Cont.
INSERT INTO `augments` VALUES (966,0,550,1,0,0); -- Light Affinity: (otherwise same as augID 960)
INSERT INTO `augments` VALUES (966,0,0,0,0,0); -- Cont.
INSERT INTO `augments` VALUES (967,0,551,1,0,0); -- Dark Affinity: (otherwise same as augID 960)
INSERT INTO `augments` VALUES (967,0,0,0,0,0); -- Cont.

-- The Magic Damage increase matches value,not displayed if value is zero.
INSERT INTO `augments` VALUES (968,0,347,1,0,0); -- Fire Affinity: Magic Damage+0,Fire Affinity: Casting time -2% (Increases by 2)
INSERT INTO `augments` VALUES (968,0,0,0,0,0); -- Cont.
INSERT INTO `augments` VALUES (969,0,348,1,0,0); -- Ice Affinity: (otherwise same as augID 968)
INSERT INTO `augments` VALUES (969,0,0,0,0,0); -- Cont.
INSERT INTO `augments` VALUES (970,0,349,1,0,0); -- Wind Affinity: (otherwise same as augID 968)
INSERT INTO `augments` VALUES (970,0,0,0,0,0); -- Cont.
INSERT INTO `augments` VALUES (971,0,350,1,0,0); -- Earth Affinity: (otherwise same as augID 968)
INSERT INTO `augments` VALUES (971,0,0,0,0,0); -- Cont.
INSERT INTO `augments` VALUES (972,0,351,1,0,0); -- Lightning Affinity: (otherwise same as augID 968)
INSERT INTO `augments` VALUES (972,0,0,0,0,0); -- Cont.
INSERT INTO `augments` VALUES (973,0,352,1,0,0); -- Water Affinity: (otherwise same as augID 968)
INSERT INTO `augments` VALUES (973,0,0,0,0,0); -- Cont.
INSERT INTO `augments` VALUES (974,0,353,1,0,0); -- Light Affinity: (otherwise same as augID 968)
INSERT INTO `augments` VALUES (974,0,0,0,0,0); -- Cont.
INSERT INTO `augments` VALUES (975,0,354,1,0,0); -- Dark Affinity: (otherwise same as augID 968)
INSERT INTO `augments` VALUES (975,0,0,0,0,0); -- Cont.
INSERT INTO `augments` VALUES (976,0,0,0,0,0); -- Fire Affin.: Blood Pact delay -1
INSERT INTO `augments` VALUES (977,0,0,0,0,0); -- Ice Affin.: Blood Pact delay -1
INSERT INTO `augments` VALUES (978,0,0,0,0,0); -- Wind Affin.: Blood Pact delay -1
INSERT INTO `augments` VALUES (979,0,0,0,0,0); -- Earth Affin.: Blood Pact delay -1
INSERT INTO `augments` VALUES (980,0,0,0,0,0); -- Lightning Affin.: Blood Pact delay -1
INSERT INTO `augments` VALUES (981,0,0,0,0,0); -- Water Affin.: Blood Pact delay -1
INSERT INTO `augments` VALUES (982,0,0,0,0,0); -- Light Affin.: Blood Pact delay -1
INSERT INTO `augments` VALUES (983,0,0,0,0,0); -- Dark Affin.: Blood Pact delay -1
INSERT INTO `augments` VALUES (984,0,0,0,0,0); -- Fire Affin.: Recast time-2% (increases by 2)
INSERT INTO `augments` VALUES (985,0,0,0,0,0); -- Ice Affin.: (otherwise same as augID 984)
INSERT INTO `augments` VALUES (986,0,0,0,0,0); -- Wind Affin.: (otherwise same as augID 984)
INSERT INTO `augments` VALUES (987,0,0,0,0,0); -- Earth Affin.: (otherwise same as augID 984)
INSERT INTO `augments` VALUES (988,0,0,0,0,0); -- Lightning Affin.: (otherwise same as augID 984)
INSERT INTO `augments` VALUES (989,0,0,0,0,0); -- Water Affin.: (otherwise same as augID 984)
INSERT INTO `augments` VALUES (990,0,0,0,0,0); -- Light Affin.: (otherwise same as augID 984)
INSERT INTO `augments` VALUES (991,0,0,0,0,0); -- Dark Affin.: (otherwise same as augID 984)
INSERT INTO `augments` VALUES (992,0,0,0,0,0); -- Fire Affinity: Castin time -2% (increases by 2)
INSERT INTO `augments` VALUES (993,0,0,0,0,0); -- Ice Affinity: (otherwise same as augID 992)
INSERT INTO `augments` VALUES (994,0,0,0,0,0); -- Wind Affinity: (otherwise same as augID 992)
INSERT INTO `augments` VALUES (995,0,0,0,0,0); -- Earth Affinity: (otherwise same as augID 992)
INSERT INTO `augments` VALUES (996,0,0,0,0,0); -- Lightning Affinity: (otherwise same as augID 992)
INSERT INTO `augments` VALUES (997,0,0,0,0,0); -- Water Affinity: (otherwise same as augID 992)
INSERT INTO `augments` VALUES (998,0,0,0,0,0); -- Light Affinity: (otherwise same as augID 992)
INSERT INTO `augments` VALUES (999,0,0,0,0,0); -- Dark Affinity: (otherwise same as augID 992)

-- The Magic Accuracy increase matches value,not displayed if value is zero.
INSERT INTO `augments` VALUES (1000,0,544,1,0,0); -- Fire Affinity: Magic Accuracy+0,Fire Affinity: Casting time -6% (increases by 6)
INSERT INTO `augments` VALUES (1000,0,0,0,0,0); -- Cont.
INSERT INTO `augments` VALUES (1001,0,545,1,0,0); -- Ice Affinity: (otherwise same as augID 1000)
INSERT INTO `augments` VALUES (1001,0,0,0,0,0); -- Cont.
INSERT INTO `augments` VALUES (1002,0,546,1,0,0); -- Wind Affinity: (otherwise same as augID 1000)
INSERT INTO `augments` VALUES (1002,0,0,0,0,0); -- Cont.
INSERT INTO `augments` VALUES (1003,0,547,1,0,0); -- Earth Affinity: (otherwise same as augID 1000)
INSERT INTO `augments` VALUES (1003,0,0,0,0,0); -- Cont.
INSERT INTO `augments` VALUES (1004,0,548,1,0,0); -- Lightning Affinity: (otherwise same as augID 1000)
INSERT INTO `augments` VALUES (1004,0,0,0,0,0); -- Cont.
INSERT INTO `augments` VALUES (1005,0,549,1,0,0); -- Water Affintiy: (otherwise same as augID 1000)
INSERT INTO `augments` VALUES (1005,0,0,0,0,0); -- Cont.
INSERT INTO `augments` VALUES (1006,0,550,1,0,0); -- Light Affinity: (otherwise same as augID 1000)
INSERT INTO `augments` VALUES (1006,0,0,0,0,0); -- Cont.
INSERT INTO `augments` VALUES (1007,0,551,1,0,0); -- Dark Affinity: (otherwise same as augID 1000)
INSERT INTO `augments` VALUES (1007,0,0,0,0,0); -- Cont.

-- The Magic Damage increase matches value,not displayed if value is zero.
INSERT INTO `augments` VALUES (1008,0,347,1,0,0); -- Fire Affinity: Magic Damage+0,Fire Affinity: Recast time -6%
INSERT INTO `augments` VALUES (1008,0,0,0,0,0); -- Cont.
INSERT INTO `augments` VALUES (1009,0,348,1,0,0); -- Ice Affinity: (otherwise same as augID 1008)
INSERT INTO `augments` VALUES (1009,0,0,0,0,0); -- Cont.
INSERT INTO `augments` VALUES (1010,0,349,1,0,0); -- Wind Affinity: (otherwise same as augID 1008)
INSERT INTO `augments` VALUES (1010,0,0,0,0,0); -- Cont.
INSERT INTO `augments` VALUES (1011,0,350,1,0,0); -- Earth Affinity: (otherwise same as augID 1008)
INSERT INTO `augments` VALUES (1011,0,0,0,0,0); -- Cont.
INSERT INTO `augments` VALUES (1012,0,351,1,0,0); -- Lightning Affinity: (otherwise same as augID 1008)
INSERT INTO `augments` VALUES (1012,0,0,0,0,0); -- Cont.
INSERT INTO `augments` VALUES (1013,0,352,1,0,0); -- Water Affinity: (otherwise same as augID 1008)
INSERT INTO `augments` VALUES (1013,0,0,0,0,0); -- Cont.
INSERT INTO `augments` VALUES (1014,0,353,1,0,0); -- Light Affinity: (otherwise same as augID 1008)
INSERT INTO `augments` VALUES (1014,0,0,0,0,0); -- Cont.
INSERT INTO `augments` VALUES (1015,0,354,1,0,0); -- Dark Affinity: (otherwise same as augID 1008)
INSERT INTO `augments` VALUES (1015,0,0,0,0,0); -- Cont.

-- 1016 to 1023 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (1016,0,0,0,0,0);
INSERT INTO `augments` VALUES (1017,0,0,0,0,0);
INSERT INTO `augments` VALUES (1018,0,0,0,0,0);
INSERT INTO `augments` VALUES (1019,0,0,0,0,0);
INSERT INTO `augments` VALUES (1020,0,0,0,0,0);
INSERT INTO `augments` VALUES (1021,0,0,0,0,0);
INSERT INTO `augments` VALUES (1022,0,0,0,0,0);
INSERT INTO `augments` VALUES (1023,0,0,0,0,0);
-- End unused block

-- For 1024 to 1080 values,count by 5 each increase
-- ModId = WEAPONSKILL_DAMAGE_BASE(570)+WsId
INSERT INTO `augments` VALUES (1024,5,574,1,0,0); -- Backhand Blow:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1025,5,576,1,0,0); -- Spinning Attack:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1026,5,577,1,0,0); -- Howling Fist:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1027,5,578,1,0,0); -- Dragon Kick:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1028,5,587,1,0,0); -- Viper Bite:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1029,5,588,1,0,0); -- Shadowstitch:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1030,5,590,1,0,0); -- Cyclone:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1031,5,595,1,0,0); -- Evisceration:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1032,5,603,1,0,0); -- Burning Blade:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1033,5,606,1,0,0); -- Shining Blade:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1034,5,608,1,0,0); -- Circle Blade:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1035,5,612,1,0,0); -- Savage Blade:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1036,5,621,1,0,0); -- Freezebite:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1037,5,622,1,0,0); -- Shockwave:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1038,5,626,1,0,0); -- Ground Strike:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1039,5,624,1,0,0); -- Sickle Moon:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1040,5,636,1,0,0); -- Gale Axe:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1041,5,638,1,0,0); -- Spinning Axe:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1042,5,640,1,0,0); -- Calamity:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1043,5,642,1,0,0); -- Decimation:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1044,5,651,1,0,0); -- Iron Tempest:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1045,5,652,1,0,0); -- Sturmwind:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1046,5,654,1,0,0); -- Keen Edge:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1047,5,658,1,0,0); -- Steel Cyclone:DMG+5% (increase by 5)
INSERT INTO `augments` VALUES (1048,5,669,1,0,0); -- Nightmare Scythe:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1049,5,670,1,0,0); -- Spinning Scythe:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1050,5,671,1,0,0); -- Vorpal Scythe:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1051,5,674,1,0,0); -- Spiral Hell:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1052,5,685,1,0,0); -- Leg Sweep:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1053,5,687,1,0,0); -- Vorpal Thrust:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1054,5,688,1,0,0); -- Skewer:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1055,5,690,1,0,0); -- Impulse Drive:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1056,5,701,1,0,0); -- Blade: To:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1057,5,702,1,0,0); -- Blade: Chi:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1058,5,705,1,0,0); -- Blade: Ten:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1059,5,706,1,0,0); -- Blade: Ku:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1060,5,716,1,0,0); -- Tachi: Goten:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1061,5,718,1,0,0); -- Tachi: Jinpu:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1062,5,719,1,0,0); -- Tachi: Koki:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1063,5,722,1,0,0); -- Tachi: Kasha:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1064,5,732,1,0,0); -- Brainshaker:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1065,5,735,1,0,0); -- Skullbreaker:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1066,5,737,1,0,0); -- Judgment:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1067,5,739,1,0,0); -- Black Halo:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1068,5,747,1,0,0); -- Rock Crusher:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1069,5,751,1,0,0); -- Shell Crusher:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1070,5,752,1,0,0); -- Full Swing:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1071,5,754,1,0,0); -- Retribution:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1072,5,764,1,0,0); -- Dulling Arrow:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1073,5,767,1,0,0); -- Blast Arrow:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1074,5,768,1,0,0); -- Arching Arrow:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1075,5,769,1,0,0); -- Empyreal Arrow:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1076,5,778,1,0,0); -- Hot Shot:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1077,5,779,1,0,0); -- Split Shot:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1078,5,780,1,0,0); -- Sniper Shot:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1079,5,785,1,0,0); -- Detonator:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1080,5,840,1,0,0); -- Weapon Skill:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1081,5,580,1,0,0); -- Final Heaven:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1082,5,581,1,0,0); -- Ascetics Fury:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1083,5,582,1,0,0); -- Stringing Pummel:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1084,5,584,1,0,0); -- Victory Smite:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1085,5,596,1,0,0); -- Mercy Stroke:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1086,5,599,1,0,0); -- Pyric Kleos:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1087,5,597,1,0,0); -- Mandalic Stab:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1088,5,598,1,0,0); -- Mordant Rime:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1089,5,601,1,0,0); -- Rudra's Storm:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1090,5,613,1,0,0); -- Knights of Round:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1091,5,614,1,0,0); -- Death Blossom:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1092,5,616,1,0,0); -- Expiacion:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1093,5,795,1,0,0); -- Chant du Cygne:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1094,5,740,1,0,0); -- Randgrith:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1095,5,741,1,0,0); -- Mystic Boon:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1096,5,627,1,0,0); -- Scourge:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1097,5,629,1,0,0); -- Torcleaver:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1098,5,643,1,0,0); -- Onslaught:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1099,5,644,1,0,0); -- Primal Rend:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1100,5,646,1,0,0); -- Cloudsplitter:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1101,5,659,1,0,0); -- Metatron Torment:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1102,5,660,1,0,0); -- King's Justice:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1103,5,662,1,0,0); -- Ukko's Fury:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1104,5,675,1,0,0); -- Catastrophe:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1105,5,676,1,0,0); -- Insurgency:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1106,5,678,1,0,0); -- Quietus:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1107,5,691,1,0,0); -- Geirskogul:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1108,5,692,1,0,0); -- Drakesbane:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1109,5,694,1,0,0); -- Camlann's Torment:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1110,5,707,1,0,0); -- Blade: Metsu:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1111,5,708,1,0,0); -- Blade: Kamu:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1112,5,710,1,0,0); -- Blade: Hi:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1113,5,723,1,0,0); -- Tachi: Kaiten:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1114,5,724,1,0,0); -- Tachi: Rana:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1115,5,726,1,0,0); -- Tachi: Fudo:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1116,5,755,1,0,0); -- Gate of Tartarus:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1117,5,758,1,0,0); -- Omniscience:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1118,5,756,1,0,0); -- Vidohunir:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1119,5,757,1,0,0); -- Garland of Bliss:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1120,5,770,1,0,0); -- Namas Arrow:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1121,5,702,1,0,0); -- Jishnu's Radiance:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1122,5,787,1,0,0); -- Trueflight:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1123,5,786,1,0,0); -- Coronach:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1124,5,788,1,0,0); -- Leaden Salute:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1125,5,790,1,0,0); -- Wildfire:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1126,5,631,1,0,0); -- Dimidiation:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1127,5,0,1,0,0); -- Exudation:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1128,5,585,1,0,0); -- Shijin Spiral:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1129,5,794,1,0,0); -- Exenterator:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1130,5,796,1,0,0); -- Requiescat:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1131,5,663,1,0,0); -- Upheaval:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1132,5,679,1,0,0); -- Entropy:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1133,5,695,1,0,0); -- Stardiver:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1134,5,711,1,0,0); -- Blade: Shun:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1135,5,727,1,0,0); -- Tachi: Shoha:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1136,5,744,1,0,0); -- Realmrazer:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1137,5,761,1,0,0); -- Shattersoul:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1138,5,630,1,0,0); -- Resolution:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1139,5,647,1,0,0); -- Ruinator:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1140,5,791,1,0,0); -- Last Stand:DMG+5% (increases by 5)

-- 1141 to 1151 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (1141,0,0,0,0,0);
INSERT INTO `augments` VALUES (1142,0,0,0,0,0);
INSERT INTO `augments` VALUES (1143,0,0,0,0,0);
INSERT INTO `augments` VALUES (1144,0,0,0,0,0);
INSERT INTO `augments` VALUES (1145,0,0,0,0,0);
INSERT INTO `augments` VALUES (1146,0,0,0,0,0);
INSERT INTO `augments` VALUES (1147,0,0,0,0,0);
INSERT INTO `augments` VALUES (1148,0,0,0,0,0);
INSERT INTO `augments` VALUES (1149,0,0,0,0,0);
INSERT INTO `augments` VALUES (1150,0,0,0,0,0);
INSERT INTO `augments` VALUES (1151,0,0,0,0,0);
-- End unused block

INSERT INTO `augments` VALUES (1152,0,1,10,0,0); -- DEF +10
INSERT INTO `augments` VALUES (1153,0,68,3,0,0); -- Evasion +3
INSERT INTO `augments` VALUES (1154,0,31,3,0,0); -- Mag. Evasion +3
INSERT INTO `augments` VALUES (1155,100,161,-2,0,0); -- Physical Damage Taken -2%
INSERT INTO `augments` VALUES (1156,100,163,-2,0,0); -- Magic Damage Taken -2%
INSERT INTO `augments` VALUES (1157,0,168,2,0,0); -- Spell Interruption Rate Down 2%
INSERT INTO `augments` VALUES (1158,0,958,2,0,0); -- Occ. Resistance to Status Ailments +2

-- 1159 to 1248 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (1159,0,0,0,0,0);
INSERT INTO `augments` VALUES (1160,0,0,0,0,0);
INSERT INTO `augments` VALUES (1161,0,0,0,0,0);
INSERT INTO `augments` VALUES (1162,0,0,0,0,0);
INSERT INTO `augments` VALUES (1163,0,0,0,0,0);
INSERT INTO `augments` VALUES (1164,0,0,0,0,0);
INSERT INTO `augments` VALUES (1165,0,0,0,0,0);
INSERT INTO `augments` VALUES (1166,0,0,0,0,0);
INSERT INTO `augments` VALUES (1167,0,0,0,0,0);
INSERT INTO `augments` VALUES (1168,0,0,0,0,0);
INSERT INTO `augments` VALUES (1169,0,0,0,0,0);
INSERT INTO `augments` VALUES (1170,0,0,0,0,0);
INSERT INTO `augments` VALUES (1171,0,0,0,0,0);
INSERT INTO `augments` VALUES (1172,0,0,0,0,0);
INSERT INTO `augments` VALUES (1173,0,0,0,0,0);
INSERT INTO `augments` VALUES (1174,0,0,0,0,0);
INSERT INTO `augments` VALUES (1175,0,0,0,0,0);
INSERT INTO `augments` VALUES (1176,0,0,0,0,0);
INSERT INTO `augments` VALUES (1177,0,0,0,0,0);
INSERT INTO `augments` VALUES (1178,0,0,0,0,0);
INSERT INTO `augments` VALUES (1179,0,0,0,0,0);
INSERT INTO `augments` VALUES (1180,0,0,0,0,0);
INSERT INTO `augments` VALUES (1181,0,0,0,0,0);
INSERT INTO `augments` VALUES (1182,0,0,0,0,0);
INSERT INTO `augments` VALUES (1183,0,0,0,0,0);
INSERT INTO `augments` VALUES (1184,0,0,0,0,0);
INSERT INTO `augments` VALUES (1185,0,0,0,0,0);
INSERT INTO `augments` VALUES (1186,0,0,0,0,0);
INSERT INTO `augments` VALUES (1187,0,0,0,0,0);
INSERT INTO `augments` VALUES (1188,0,0,0,0,0);
INSERT INTO `augments` VALUES (1189,0,0,0,0,0);
INSERT INTO `augments` VALUES (1190,0,0,0,0,0);
INSERT INTO `augments` VALUES (1191,0,0,0,0,0);
INSERT INTO `augments` VALUES (1192,0,0,0,0,0);
INSERT INTO `augments` VALUES (1193,0,0,0,0,0);
INSERT INTO `augments` VALUES (1194,0,0,0,0,0);
INSERT INTO `augments` VALUES (1195,0,0,0,0,0);
INSERT INTO `augments` VALUES (1196,0,0,0,0,0);
INSERT INTO `augments` VALUES (1197,0,0,0,0,0);
INSERT INTO `augments` VALUES (1198,0,0,0,0,0);
INSERT INTO `augments` VALUES (1199,0,0,0,0,0);
INSERT INTO `augments` VALUES (1200,0,0,0,0,0);
INSERT INTO `augments` VALUES (1201,0,0,0,0,0);
INSERT INTO `augments` VALUES (1202,0,0,0,0,0);
INSERT INTO `augments` VALUES (1203,0,0,0,0,0);
INSERT INTO `augments` VALUES (1204,0,0,0,0,0);
INSERT INTO `augments` VALUES (1205,0,0,0,0,0);
INSERT INTO `augments` VALUES (1206,0,0,0,0,0);
INSERT INTO `augments` VALUES (1207,0,0,0,0,0);
INSERT INTO `augments` VALUES (1208,0,0,0,0,0);
INSERT INTO `augments` VALUES (1209,0,0,0,0,0);
INSERT INTO `augments` VALUES (1210,0,0,0,0,0);
INSERT INTO `augments` VALUES (1211,0,0,0,0,0);
INSERT INTO `augments` VALUES (1212,0,0,0,0,0);
INSERT INTO `augments` VALUES (1213,0,0,0,0,0);
INSERT INTO `augments` VALUES (1214,0,0,0,0,0);
INSERT INTO `augments` VALUES (1215,0,0,0,0,0);
INSERT INTO `augments` VALUES (1216,0,0,0,0,0);
INSERT INTO `augments` VALUES (1217,0,0,0,0,0);
INSERT INTO `augments` VALUES (1218,0,0,0,0,0);
INSERT INTO `augments` VALUES (1219,0,0,0,0,0);
INSERT INTO `augments` VALUES (1220,0,0,0,0,0);
INSERT INTO `augments` VALUES (1221,0,0,0,0,0);
INSERT INTO `augments` VALUES (1222,0,0,0,0,0);
INSERT INTO `augments` VALUES (1223,0,0,0,0,0);
INSERT INTO `augments` VALUES (1224,0,0,0,0,0);
INSERT INTO `augments` VALUES (1225,0,0,0,0,0);
INSERT INTO `augments` VALUES (1226,0,0,0,0,0);
INSERT INTO `augments` VALUES (1227,0,0,0,0,0);
INSERT INTO `augments` VALUES (1228,0,0,0,0,0);
INSERT INTO `augments` VALUES (1229,0,0,0,0,0);
INSERT INTO `augments` VALUES (1230,0,0,0,0,0);
INSERT INTO `augments` VALUES (1231,0,0,0,0,0);
INSERT INTO `augments` VALUES (1232,0,0,0,0,0);
INSERT INTO `augments` VALUES (1233,0,0,0,0,0);
INSERT INTO `augments` VALUES (1234,0,0,0,0,0);
INSERT INTO `augments` VALUES (1235,0,0,0,0,0);
INSERT INTO `augments` VALUES (1236,0,0,0,0,0);
INSERT INTO `augments` VALUES (1237,0,0,0,0,0);
INSERT INTO `augments` VALUES (1238,0,0,0,0,0);
INSERT INTO `augments` VALUES (1239,0,0,0,0,0);
INSERT INTO `augments` VALUES (1240,0,0,0,0,0);
INSERT INTO `augments` VALUES (1241,0,0,0,0,0);
INSERT INTO `augments` VALUES (1242,0,0,0,0,0);
INSERT INTO `augments` VALUES (1243,0,0,0,0,0);
INSERT INTO `augments` VALUES (1244,0,0,0,0,0);
INSERT INTO `augments` VALUES (1245,0,0,0,0,0);
-- End unused block

INSERT INTO `augments` VALUES (1246,100,161,-2,1,0); -- Pet: Phy. Dmg. Taken -2%
INSERT INTO `augments` VALUES (1247,100,163,-2,1,0); -- Pet: Magic Dmg. Taken -2%
INSERT INTO `augments` VALUES (1248,0,890,1,0,0); -- Enhancing Magic Effect Duration +1
INSERT INTO `augments` VALUES (1249,0,477,1,0,0); -- Helix Effect Duration+1
INSERT INTO `augments` VALUES (1250,0,960,1,0,0); -- Indi Effect Duration+1
INSERT INTO `augments` VALUES (1251,0,0,0,0,0); -- Enfeebling Magic Duration +1

-- 1252 to 1263 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (1252,0,0,0,0,0);
INSERT INTO `augments` VALUES (1253,0,0,0,0,0);
INSERT INTO `augments` VALUES (1254,0,0,0,0,0);
INSERT INTO `augments` VALUES (1255,0,0,0,0,0);
INSERT INTO `augments` VALUES (1256,0,0,0,0,0);
INSERT INTO `augments` VALUES (1257,0,0,0,0,0);
INSERT INTO `augments` VALUES (1258,0,0,0,0,0);
INSERT INTO `augments` VALUES (1259,0,0,0,0,0);
INSERT INTO `augments` VALUES (1260,0,0,0,0,0);
INSERT INTO `augments` VALUES (1261,0,0,0,0,0);
INSERT INTO `augments` VALUES (1262,0,0,0,0,0);
INSERT INTO `augments` VALUES (1263,0,0,0,0,0);
-- End unused block

INSERT INTO `augments` VALUES (1264,0,94,1,0,0); -- Meditate Effect Duration +1

-- 1265 to 1279 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (1265,0,0,0,0,0);
INSERT INTO `augments` VALUES (1266,0,0,0,0,0);
INSERT INTO `augments` VALUES (1267,0,0,0,0,0);
INSERT INTO `augments` VALUES (1268,0,0,0,0,0);
INSERT INTO `augments` VALUES (1269,0,0,0,0,0);
INSERT INTO `augments` VALUES (1270,0,0,0,0,0);
INSERT INTO `augments` VALUES (1271,0,0,0,0,0);
INSERT INTO `augments` VALUES (1272,0,0,0,0,0);
INSERT INTO `augments` VALUES (1273,0,0,0,0,0);
INSERT INTO `augments` VALUES (1274,0,0,0,0,0);
INSERT INTO `augments` VALUES (1275,0,0,0,0,0);
INSERT INTO `augments` VALUES (1276,0,0,0,0,0);
INSERT INTO `augments` VALUES (1277,0,0,0,0,0);
INSERT INTO `augments` VALUES (1278,0,0,0,0,0);
INSERT INTO `augments` VALUES (1279,0,0,0,0,0);
-- End unused block

INSERT INTO `augments` VALUES (1280,0,0,0,0,0); -- Enhances Mighty Strikes effect
INSERT INTO `augments` VALUES (1281,0,0,0,0,0); -- Enhances Hundred Fists effect
INSERT INTO `augments` VALUES (1282,0,0,0,0,0); -- Enhances Benediction effect
INSERT INTO `augments` VALUES (1283,0,0,0,0,0); -- Enhances Manafont effect
INSERT INTO `augments` VALUES (1284,0,0,0,0,0); -- Enhances Chainspell effect
INSERT INTO `augments` VALUES (1285,0,0,0,0,0); -- Enhances Perfect Dodge effect
INSERT INTO `augments` VALUES (1286,0,0,0,0,0); -- Enhances Invincible effect
INSERT INTO `augments` VALUES (1287,10,1070,1,0,0); -- Enhances Blood Weapon effect
INSERT INTO `augments` VALUES (1288,0,0,0,0,0); -- Enhances Familiar effect
INSERT INTO `augments` VALUES (1289,0,0,0,0,0); -- Enhances Soul Voice effect
INSERT INTO `augments` VALUES (1290,0,0,0,0,0); -- Enhances Eagle Eye Shot effect
INSERT INTO `augments` VALUES (1291,0,0,0,0,0); -- Enhances Meikyo Shisui effect
INSERT INTO `augments` VALUES (1292,0,0,0,0,0); -- Enhances Mijin Gakure effect
INSERT INTO `augments` VALUES (1293,0,0,0,0,0); -- Enhances Spirit Surge effect
INSERT INTO `augments` VALUES (1294,0,0,0,0,0); -- Enhances Astral Flow effect
INSERT INTO `augments` VALUES (1295,0,0,0,0,0); -- Enhances Azure Lore effect
INSERT INTO `augments` VALUES (1296,0,0,0,0,0); -- Enhances Wild Card effect
INSERT INTO `augments` VALUES (1297,0,0,0,0,0); -- Enhances Overdrive effect
INSERT INTO `augments` VALUES (1298,0,0,0,0,0); -- Enhances Trance effect
INSERT INTO `augments` VALUES (1299,0,0,0,0,0); -- Enhances Tablua Rasa effect
INSERT INTO `augments` VALUES (1300,0,1028,1,0,0); -- Enhances Bolster effect
INSERT INTO `augments` VALUES (1301,0,0,0,0,0); -- Enhances Elemental Sforzo effect

 -- 1302 to 1327 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (1302,0,0,0,0,0);
INSERT INTO `augments` VALUES (1303,0,0,0,0,0);
INSERT INTO `augments` VALUES (1304,0,0,0,0,0);
INSERT INTO `augments` VALUES (1305,0,0,0,0,0);
INSERT INTO `augments` VALUES (1306,0,0,0,0,0);
INSERT INTO `augments` VALUES (1307,0,0,0,0,0);
INSERT INTO `augments` VALUES (1308,0,0,0,0,0);
INSERT INTO `augments` VALUES (1309,0,0,0,0,0);
INSERT INTO `augments` VALUES (1310,0,0,0,0,0);
INSERT INTO `augments` VALUES (1311,0,0,0,0,0);
INSERT INTO `augments` VALUES (1312,0,0,0,0,0);
INSERT INTO `augments` VALUES (1313,0,0,0,0,0);
INSERT INTO `augments` VALUES (1314,0,0,0,0,0);
INSERT INTO `augments` VALUES (1315,0,0,0,0,0);
INSERT INTO `augments` VALUES (1316,0,0,0,0,0);
INSERT INTO `augments` VALUES (1317,0,0,0,0,0);
INSERT INTO `augments` VALUES (1318,0,0,0,0,0);
INSERT INTO `augments` VALUES (1319,0,0,0,0,0);
INSERT INTO `augments` VALUES (1320,0,0,0,0,0);
INSERT INTO `augments` VALUES (1321,0,0,0,0,0);
INSERT INTO `augments` VALUES (1322,0,0,0,0,0);
INSERT INTO `augments` VALUES (1323,0,0,0,0,0);
INSERT INTO `augments` VALUES (1324,0,0,0,0,0);
INSERT INTO `augments` VALUES (1325,0,0,0,0,0);
INSERT INTO `augments` VALUES (1326,0,0,0,0,0);
INSERT INTO `augments` VALUES (1327,0,0,0,0,0);
-- End unused block

INSERT INTO `augments` VALUES (1328,0,0,0,0,0); -- Enhances "Savagery" effect
INSERT INTO `augments` VALUES (1329,0,0,0,0,0); -- Enhances "Aggressive Aim" effect
INSERT INTO `augments` VALUES (1330,0,0,0,0,0); -- Enhances "Warriors Charge" effect
INSERT INTO `augments` VALUES (1331,0,0,0,0,0); -- Enhances "Tomahawk" effect
INSERT INTO `augments` VALUES (1332,0,0,0,0,0); -- 1332 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (1333,0,0,0,0,0); -- 1333 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (1334,0,0,0,0,0); -- Enhances "Penance" effect
INSERT INTO `augments` VALUES (1335,0,0,0,0,0); -- Enhances "Formless Strikes" effect
INSERT INTO `augments` VALUES (1336,0,0,0,0,0); -- Enhances "Invigorate" effect
INSERT INTO `augments` VALUES (1337,0,0,0,0,0); -- Enhances "Mantra" effect
INSERT INTO `augments` VALUES (1338,0,0,0,0,0); -- 1338 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (1339,0,0,0,0,0); -- 1339 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (1340,0,0,0,0,0); -- Enhances "Protectra V" effect
INSERT INTO `augments` VALUES (1341,0,0,0,0,0); -- Enhances "Martyr" effect
INSERT INTO `augments` VALUES (1342,0,0,0,0,0); -- Enhances "Shellra V" effect
INSERT INTO `augments` VALUES (1343,0,0,0,0,0); -- Enhances "Devotion" effect
INSERT INTO `augments` VALUES (1344,0,0,0,0,0); -- 1344 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (1345,0,0,0,0,0); -- 1345 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (1346,0,0,0,0,0); -- Increases Ancient Magic II damage
INSERT INTO `augments` VALUES (1347,0,0,0,0,0); -- Reduces Ancient Magic II casting time
INSERT INTO `augments` VALUES (1348,0,0,0,0,0); -- Increases Ancient Magic II accuracy
INSERT INTO `augments` VALUES (1349,0,0,0,0,0); -- Reduces Ancient Magic II MP cost
INSERT INTO `augments` VALUES (1350,0,0,0,0,0); -- 1350 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (1351,0,0,0,0,0); -- 1351 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (1352,0,0,0,0,0); -- Enhances "Dia III" effect
INSERT INTO `augments` VALUES (1353,0,0,0,0,0); -- Enhances "Slow II" effect
INSERT INTO `augments` VALUES (1354,0,0,0,0,0); -- Enhances "Phalanx II" effect
INSERT INTO `augments` VALUES (1355,0,0,0,0,0); -- Enhances "Bio III" effect
INSERT INTO `augments` VALUES (1356,0,0,0,0,0); -- Enhances "Blind II" effect
INSERT INTO `augments` VALUES (1357,0,0,0,0,0); -- Enhances "Paralyze II" effect
INSERT INTO `augments` VALUES (1358,0,0,0,0,0); -- Enhances "Aura Steal" effect
INSERT INTO `augments` VALUES (1359,0,0,0,0,0); -- Enhances "Ambush" effect
INSERT INTO `augments` VALUES (1360,0,0,0,0,0); -- Enhances "Feint" effect
INSERT INTO `augments` VALUES (1361,0,886,1,0,0); -- Enh. "Assassins Charge" effect
INSERT INTO `augments` VALUES (1362,0,0,0,0,0); -- 1362 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (1363,0,0,0,0,0); -- 1363 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (1364,3,1064,1,0,0); -- Enhances "Iron Will" effect
INSERT INTO `augments` VALUES (1365,4,1063,1,0,0); -- Enhances "Fealty" effect
INSERT INTO `augments` VALUES (1366,5,1061,1,0,0); -- Enhances "Chivalry" effect
INSERT INTO `augments` VALUES (1367,2,1065,1,0,0); -- Enhances "Guardian" effect
INSERT INTO `augments` VALUES (1368,0,0,0,0,0); -- 1368 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (1369,0,0,0,0,0); -- 1369 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (1370,10,1073,1,0,0); -- Enhances "Dark Seal" effect
INSERT INTO `augments` VALUES (1371,0,0,0,0,0); -- Enhances "Diabolic Eye" effect
INSERT INTO `augments` VALUES (1372,0,0,0,0,0); -- Enhances "Muted Soul" effect
INSERT INTO `augments` VALUES (1373,0,0,0,0,0); -- Enhances "Desperate Blows" effect
INSERT INTO `augments` VALUES (1374,0,0,0,0,0); -- 1374 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (1375,0,0,0,0,0); -- 1375 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (1376,0,0,0,0,0); -- Enhances "Killer Instinct" effect
INSERT INTO `augments` VALUES (1377,0,503,1,0,0); -- Enhances "Feral Howl effect"
INSERT INTO `augments` VALUES (1378,0,0,0,0,0); -- Enhances Beast Affinity effect
INSERT INTO `augments` VALUES (1379,0,0,0,0,0); -- Enhances Beast Healer effect
INSERT INTO `augments` VALUES (1380,0,0,0,0,0); -- 1380 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (1381,0,0,0,0,0); -- 1381 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (1382,0,0,0,0,0); -- Enhances "Foe Sirvente" effect
INSERT INTO `augments` VALUES (1383,0,0,0,0,0); -- Enhances "Troubadour" effect
INSERT INTO `augments` VALUES (1384,0,0,0,0,0); -- Enh. "Adventurers Dirge" effect
INSERT INTO `augments` VALUES (1385,0,0,0,0,0); -- Enhances "Nightingale" effect
INSERT INTO `augments` VALUES (1386,0,0,0,0,0); -- 1386 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (1387,0,0,0,0,0); -- 1387 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (1388,0,0,0,0,0); -- Enhances "Recycle" effect
INSERT INTO `augments` VALUES (1389,0,0,0,0,0); -- Enhances "Snapshot" effect
INSERT INTO `augments` VALUES (1390,0,0,0,0,0); -- Enhances "Flashy Shot" effect
INSERT INTO `augments` VALUES (1391,0,0,0,0,0); -- Enhances "Stealth Shot" effect
INSERT INTO `augments` VALUES (1392,0,0,0,0,0); -- 1392 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (1393,0,0,0,0,0); -- 1393 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (1394,0,0,0,0,0); -- Enhances "Shikikoyo" effect
INSERT INTO `augments` VALUES (1395,0,0,0,0,0); -- Enhances "Overwhelm" effect
INSERT INTO `augments` VALUES (1396,0,0,0,0,0); -- Enhances "Blade Bash" effect
INSERT INTO `augments` VALUES (1397,0,0,0,0,0); -- Enhances "Ikishoten" effect
INSERT INTO `augments` VALUES (1398,0,0,0,0,0); -- 1398 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (1399,0,0,0,0,0); -- 1399 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (1400,0,0,0,0,0); -- Increases elem. ninjutsu III damage
INSERT INTO `augments` VALUES (1401,0,0,0,0,0); -- Enhances "Sange" effect
INSERT INTO `augments` VALUES (1402,0,0,0,0,0); -- Enh. Ninja Tool Expertise effect
INSERT INTO `augments` VALUES (1403,0,0,0,0,0); -- Reduces elem. ninjutsu III cast time
INSERT INTO `augments` VALUES (1404,0,0,0,0,0); -- 1404 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (1405,0,0,0,0,0); -- 1405 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (1406,0,0,0,0,0); -- Enhances Deep Breathing effect
INSERT INTO `augments` VALUES (1407,0,0,0,0,0); -- Enhances Angon effect
INSERT INTO `augments` VALUES (1408,0,0,0,0,0); -- Enhances Strafe effect
INSERT INTO `augments` VALUES (1409,0,0,0,0,0); -- Enhances Empathy effect
INSERT INTO `augments` VALUES (1410,0,0,0,0,0); -- 1410 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (1411,0,0,0,0,0); -- 1411 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (1412,0,0,0,0,0); -- Reduces Sp Blood Pact MP cost
INSERT INTO `augments` VALUES (1413,0,0,0,0,0); -- Inc Sp Blood Pact magic burst dmg
INSERT INTO `augments` VALUES (1414,0,0,0,0,0); -- Increases Sp Blood Pact accuracy
INSERT INTO `augments` VALUES (1415,0,0,0,0,0); -- Inc. Sp. Blood Pact magic crit. dmg.
INSERT INTO `augments` VALUES (1416,0,0,0,0,0); -- 1416 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (1417,0,0,0,0,0); -- 1417 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (1418,0,0,0,0,0); -- Enhances "Convergence" effect
INSERT INTO `augments` VALUES (1419,0,0,0,0,0); -- Enhances "Enchainment" effect
INSERT INTO `augments` VALUES (1420,0,0,0,0,0); -- Enhances "Assimilation" effect
INSERT INTO `augments` VALUES (1421,0,0,0,0,0); -- Enhances "Diffusion" effect
INSERT INTO `augments` VALUES (1422,0,0,0,0,0); -- 1422 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (1423,0,0,0,0,0); -- 1423 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (1424,0,0,0,0,0); -- Enhances "Winning Streak" effect
INSERT INTO `augments` VALUES (1425,0,0,0,0,0); -- Enhances "Loaded Deck" effect
INSERT INTO `augments` VALUES (1426,0,0,0,0,0); -- Enhances "Fold" effect
INSERT INTO `augments` VALUES (1427,0,0,0,0,0); -- Enhances "Snake Eye" effect
INSERT INTO `augments` VALUES (1428,0,0,0,0,0); -- 1428 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (1429,0,0,0,0,0); -- 1429 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (1430,0,0,0,0,0); -- Enhances "Optimization" effect
INSERT INTO `augments` VALUES (1431,0,0,0,0,0); -- Enhances "Fine-Tuning" effect
INSERT INTO `augments` VALUES (1432,0,0,0,0,0); -- Enhances "Ventriloquy" effect
INSERT INTO `augments` VALUES (1433,0,0,0,0,0); -- Enhances "Role Reversal" effect
INSERT INTO `augments` VALUES (1434,0,0,0,0,0); -- 1434 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (1435,0,0,0,0,0); -- 1435 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (1436,0,0,0,0,0); -- Enhances "No Foot" Rise effect
INSERT INTO `augments` VALUES (1437,0,0,0,0,0); -- Enhances "Fan Dance" effect
INSERT INTO `augments` VALUES (1438,0,0,0,0,0); -- Enhances "Saber Dance" effect
INSERT INTO `augments` VALUES (1439,0,0,0,0,0); -- Enhances "Closed Position" effect
INSERT INTO `augments` VALUES (1440,0,0,0,0,0); -- 1440 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (1441,0,0,0,0,0); -- 1441 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (1442,0,0,0,0,0); -- Enh. "Altruism" and "Focalization"
INSERT INTO `augments` VALUES (1443,0,0,0,0,0); -- Enhances "Enlightenment" effect
INSERT INTO `augments` VALUES (1444,0,0,0,0,0); -- Enh. "Tranquility" and "Equanimity"
INSERT INTO `augments` VALUES (1445,0,0,0,0,0); -- Enhances Stormsurge effect
INSERT INTO `augments` VALUES (1446,0,0,0,0,0); -- 1446 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (1447,0,0,0,0,0); -- 1447 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (1448,0,968,1,0,0); -- Enhances "Mending Halation" effect
INSERT INTO `augments` VALUES (1449,0,969,1,0,0); -- Enhances "Radial Arcana" effect
INSERT INTO `augments` VALUES (1450,0,970,1,0,0); -- Enhances "Curative Recantation" effect
INSERT INTO `augments` VALUES (1451,0,971,1,0,0); -- Enhances "Primeval Zeal" effect
INSERT INTO `augments` VALUES (1452,0,0,0,0,0); -- 1452 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (1453,0,0,0,0,0); -- 1453 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (1454,0,0,0,0,0); -- Enhances "Battuta" effect
INSERT INTO `augments` VALUES (1455,0,0,0,0,0); -- Enhances "Rayke" effect
INSERT INTO `augments` VALUES (1456,0,0,0,0,0); -- Enhances "Inspire" effect
INSERT INTO `augments` VALUES (1457,0,0,0,0,0); -- Enhances "Sleight of Sword" effect

-- 1458 to 1471 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (1458,0,0,0,0,0);
INSERT INTO `augments` VALUES (1459,0,0,0,0,0);
INSERT INTO `augments` VALUES (1460,0,0,0,0,0);
INSERT INTO `augments` VALUES (1461,0,0,0,0,0);
INSERT INTO `augments` VALUES (1462,0,0,0,0,0);
INSERT INTO `augments` VALUES (1463,0,0,0,0,0);
INSERT INTO `augments` VALUES (1464,0,0,0,0,0);
INSERT INTO `augments` VALUES (1465,0,0,0,0,0);
INSERT INTO `augments` VALUES (1466,0,0,0,0,0);
INSERT INTO `augments` VALUES (1467,0,0,0,0,0);
INSERT INTO `augments` VALUES (1468,0,0,0,0,0);
INSERT INTO `augments` VALUES (1469,0,0,0,0,0);
INSERT INTO `augments` VALUES (1470,0,0,0,0,0);
INSERT INTO `augments` VALUES (1471,0,0,0,0,0);
-- End unused block

INSERT INTO `augments` VALUES (1472,0,963,1,0,0); -- Parrying rate +1% (not +skill)

-- 1473 to 1791 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (1473,0,0,0,0,0);
INSERT INTO `augments` VALUES (1474,0,0,0,0,0);
INSERT INTO `augments` VALUES (1475,0,0,0,0,0);
INSERT INTO `augments` VALUES (1476,0,0,0,0,0);
INSERT INTO `augments` VALUES (1477,0,0,0,0,0);
INSERT INTO `augments` VALUES (1478,0,0,0,0,0);
INSERT INTO `augments` VALUES (1479,0,0,0,0,0);
INSERT INTO `augments` VALUES (1480,0,0,0,0,0);
INSERT INTO `augments` VALUES (1481,0,0,0,0,0);
INSERT INTO `augments` VALUES (1482,0,0,0,0,0);
INSERT INTO `augments` VALUES (1483,0,0,0,0,0);
INSERT INTO `augments` VALUES (1484,0,0,0,0,0);
INSERT INTO `augments` VALUES (1485,0,0,0,0,0);
INSERT INTO `augments` VALUES (1486,0,0,0,0,0);
INSERT INTO `augments` VALUES (1487,0,0,0,0,0);
INSERT INTO `augments` VALUES (1488,0,0,0,0,0);
INSERT INTO `augments` VALUES (1489,0,0,0,0,0);
INSERT INTO `augments` VALUES (1490,0,0,0,0,0);
INSERT INTO `augments` VALUES (1491,0,0,0,0,0);
INSERT INTO `augments` VALUES (1492,0,0,0,0,0);
INSERT INTO `augments` VALUES (1493,0,0,0,0,0);
INSERT INTO `augments` VALUES (1494,0,0,0,0,0);
INSERT INTO `augments` VALUES (1495,0,0,0,0,0);
INSERT INTO `augments` VALUES (1496,0,0,0,0,0);
INSERT INTO `augments` VALUES (1497,0,0,0,0,0);
INSERT INTO `augments` VALUES (1498,0,0,0,0,0);
INSERT INTO `augments` VALUES (1499,0,0,0,0,0);
INSERT INTO `augments` VALUES (1500,0,0,0,0,0);
INSERT INTO `augments` VALUES (1501,0,0,0,0,0);
INSERT INTO `augments` VALUES (1502,0,0,0,0,0);
INSERT INTO `augments` VALUES (1503,0,0,0,0,0);
INSERT INTO `augments` VALUES (1504,0,0,0,0,0);
INSERT INTO `augments` VALUES (1505,0,0,0,0,0);
INSERT INTO `augments` VALUES (1506,0,0,0,0,0);
INSERT INTO `augments` VALUES (1507,0,0,0,0,0);
INSERT INTO `augments` VALUES (1508,0,0,0,0,0);
INSERT INTO `augments` VALUES (1509,0,0,0,0,0);
INSERT INTO `augments` VALUES (1510,0,0,0,0,0);
INSERT INTO `augments` VALUES (1511,0,0,0,0,0);
INSERT INTO `augments` VALUES (1512,0,0,0,0,0);
INSERT INTO `augments` VALUES (1513,0,0,0,0,0);
INSERT INTO `augments` VALUES (1514,0,0,0,0,0);
INSERT INTO `augments` VALUES (1515,0,0,0,0,0);
INSERT INTO `augments` VALUES (1516,0,0,0,0,0);
INSERT INTO `augments` VALUES (1517,0,0,0,0,0);
INSERT INTO `augments` VALUES (1518,0,0,0,0,0);
INSERT INTO `augments` VALUES (1519,0,0,0,0,0);
INSERT INTO `augments` VALUES (1520,0,0,0,0,0);
INSERT INTO `augments` VALUES (1521,0,0,0,0,0);
INSERT INTO `augments` VALUES (1522,0,0,0,0,0);
INSERT INTO `augments` VALUES (1523,0,0,0,0,0);
INSERT INTO `augments` VALUES (1524,0,0,0,0,0);
INSERT INTO `augments` VALUES (1525,0,0,0,0,0);
INSERT INTO `augments` VALUES (1526,0,0,0,0,0);
INSERT INTO `augments` VALUES (1527,0,0,0,0,0);
INSERT INTO `augments` VALUES (1528,0,0,0,0,0);
INSERT INTO `augments` VALUES (1529,0,0,0,0,0);
INSERT INTO `augments` VALUES (1530,0,0,0,0,0);
INSERT INTO `augments` VALUES (1531,0,0,0,0,0);
INSERT INTO `augments` VALUES (1532,0,0,0,0,0);
INSERT INTO `augments` VALUES (1533,0,0,0,0,0);
INSERT INTO `augments` VALUES (1534,0,0,0,0,0);
INSERT INTO `augments` VALUES (1535,0,0,0,0,0);
INSERT INTO `augments` VALUES (1536,5,574,1,0,0); -- Backhand Blow:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1537,5,576,1,0,0); -- Spinning Attack:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1538,5,577,1,0,0); -- Howling Fist:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1539,5,578,1,0,0); -- Dragon Kick:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1540,5,587,1,0,0); -- Viper Bite:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1541,5,588,1,0,0); -- Shadowstitch:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1542,5,590,1,0,0); -- Cyclone:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1543,5,595,1,0,0); -- Evisceration:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1544,5,603,1,0,0); -- Burning Blade:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1545,5,606,1,0,0); -- Shining Blade:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1546,5,608,1,0,0); -- Circle Blade:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1547,5,612,1,0,0); -- Savage Blade:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1548,5,621,1,0,0); -- Freezebite:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1549,5,622,1,0,0); -- Shockwave:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1550,5,626,1,0,0); -- Ground Strike:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1551,5,624,1,0,0); -- Sickle Moon:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1552,5,636,1,0,0); -- Gale Axe:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1553,5,638,1,0,0); -- Spinning Axe:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1554,5,640,1,0,0); -- Calamity:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1555,5,642,1,0,0); -- Decimation:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1556,5,651,1,0,0); -- Iron Tempest:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1557,5,652,1,0,0); -- Sturmwind:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1558,5,654,1,0,0); -- Keen Edge:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1559,5,658,1,0,0); -- Steel Cyclone:DMG+5% (increase by 5)
INSERT INTO `augments` VALUES (1560,5,669,1,0,0); -- Nightmare Scythe:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1561,5,670,1,0,0); -- Spinning Scythe:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1562,5,671,1,0,0); -- Vorpal Scythe:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1563,5,674,1,0,0); -- Spiral Hell:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1564,5,685,1,0,0); -- Leg Sweep:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1565,5,687,1,0,0); -- Vorpal Thrust:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1566,5,688,1,0,0); -- Skewer:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1567,5,690,1,0,0); -- Impulse Drive:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1568,5,701,1,0,0); -- Blade: To:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1569,5,702,1,0,0); -- Blade: Chi:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1570,5,705,1,0,0); -- Blade: Ten:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1571,5,706,1,0,0); -- Blade: Ku:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1572,5,716,1,0,0); -- Tachi: Goten:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1573,5,718,1,0,0); -- Tachi: Jinpu:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1574,5,719,1,0,0); -- Tachi: Koki:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1575,5,722,1,0,0); -- Tachi: Kasha:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1576,5,732,1,0,0); -- Brainshaker:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1577,5,735,1,0,0); -- Skullbreaker:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1578,5,737,1,0,0); -- Judgment:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1579,5,739,1,0,0); -- Black Halo:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1580,5,747,1,0,0); -- Rock Crusher:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1581,5,751,1,0,0); -- Shell Crusher:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1582,5,752,1,0,0); -- Full Swing:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1583,5,754,1,0,0); -- Retribution:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1584,5,764,1,0,0); -- Dulling Arrow:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1585,5,767,1,0,0); -- Blast Arrow:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1586,5,768,1,0,0); -- Arching Arrow:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1587,5,769,1,0,0); -- Empyreal Arrow:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1588,5,779,1,0,0); -- Split Shot:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1589,5,778,1,0,0); -- Hot Shot:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1590,5,780,1,0,0); -- Sniper Shot:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1591,5,785,1,0,0); -- Detonator:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1592,5,840,1,0,0); -- Weapon Skill:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1593,5,580,1,0,0); -- Final Heaven:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1594,5,581,1,0,0); -- Ascetics Fury:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1595,5,582,1,0,0); -- Stringing Pummel:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1596,5,584,1,0,0); -- Victory Smite:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1597,5,596,1,0,0); -- Mercy Stroke:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1598,5,599,1,0,0); -- Pyric Kleos:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1599,5,597,1,0,0); -- Mandalic Stab:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1600,5,598,1,0,0); -- Mordant Rime:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1601,5,601,1,0,0); -- Rudra's Storm:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1602,5,613,1,0,0); -- Knights of Round:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1603,5,614,1,0,0); -- Death Blossom:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1604,5,616,1,0,0); -- Expiacion:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1605,5,795,1,0,0); -- Chant du Cygne:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1606,5,740,1,0,0); -- Randgrith:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1607,5,741,1,0,0); -- Mystic Boon:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1608,5,627,1,0,0); -- Scourge:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1609,5,629,1,0,0); -- Torcleaver:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1610,5,643,1,0,0); -- Onslaught:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1611,5,644,1,0,0); -- Primal Rend:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1612,5,646,1,0,0); -- Cloudsplitter:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1613,5,659,1,0,0); -- Metatron Torment:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1614,5,660,1,0,0); -- King's Justice:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1615,5,662,1,0,0); -- Ukko's Fury:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1616,5,675,1,0,0); -- Catastrophe:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1617,5,676,1,0,0); -- Insurgency:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1618,5,678,1,0,0); -- Quietus:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1619,5,691,1,0,0); -- Geirskogul:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1620,5,692,1,0,0); -- Drakesbane:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1621,5,694,1,0,0); -- Camlann's Torment:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1622,5,707,1,0,0); -- Blade: Metsu:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1623,5,708,1,0,0); -- Blade: Kamu:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1624,5,710,1,0,0); -- Blade: Hi:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1625,5,723,1,0,0); -- Tachi: Kaiten:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1626,5,724,1,0,0); -- Tachi: Rana:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1627,5,726,1,0,0); -- Tachi: Fudo:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1628,5,755,1,0,0); -- Gate of Tartarus:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1629,5,758,1,0,0); -- Omniscience:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1630,5,756,1,0,0); -- Vidohunir:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1631,5,757,1,0,0); -- Garland of Bliss:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1632,5,770,1,0,0); -- Namas Arrow:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1633,5,702,1,0,0); -- Jishnu's Radiance:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1634,5,787,1,0,0); -- Trueflight:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1635,5,786,1,0,0); -- Coronach:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1636,5,788,1,0,0); -- Leaden Salute:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1637,5,790,1,0,0); -- Wildfire:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1638,5,631,1,0,0); -- Dimidiation:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1639,5,0,1,0,0); -- Exudation:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1640,5,585,1,0,0); -- Shijin Spiral:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1641,5,794,1,0,0); -- Exenterator:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1642,5,796,1,0,0); -- Requiescat:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1643,5,663,1,0,0); -- Upheaval:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1644,5,679,1,0,0); -- Entropy:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1645,5,695,1,0,0); -- Stardiver:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1646,5,711,1,0,0); -- Blade: Shun:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1647,5,727,1,0,0); -- Tachi: Shoha:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1648,5,744,1,0,0); -- Realmrazer:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1649,5,761,1,0,0); -- Shattersoul:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1650,5,630,1,0,0); -- Resolution:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1651,5,647,1,0,0); -- Ruinator:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1652,5,791,1,0,0); -- Last Stand:DMG+5% (increases by 5)
INSERT INTO `augments` VALUES (1653,0,0,0,0,0);
INSERT INTO `augments` VALUES (1654,0,0,0,0,0);
INSERT INTO `augments` VALUES (1655,0,0,0,0,0);
INSERT INTO `augments` VALUES (1656,0,0,0,0,0);
INSERT INTO `augments` VALUES (1657,0,0,0,0,0);
INSERT INTO `augments` VALUES (1658,0,0,0,0,0);
INSERT INTO `augments` VALUES (1659,0,0,0,0,0);
INSERT INTO `augments` VALUES (1660,0,0,0,0,0);
INSERT INTO `augments` VALUES (1661,0,0,0,0,0);
INSERT INTO `augments` VALUES (1662,0,0,0,0,0);
INSERT INTO `augments` VALUES (1663,0,0,0,0,0);
INSERT INTO `augments` VALUES (1664,0,0,0,0,0);
INSERT INTO `augments` VALUES (1665,0,0,0,0,0);
INSERT INTO `augments` VALUES (1666,0,0,0,0,0);
INSERT INTO `augments` VALUES (1667,0,0,0,0,0);
INSERT INTO `augments` VALUES (1668,0,0,0,0,0);
INSERT INTO `augments` VALUES (1669,0,0,0,0,0);
INSERT INTO `augments` VALUES (1670,0,0,0,0,0);
INSERT INTO `augments` VALUES (1671,0,0,0,0,0);
INSERT INTO `augments` VALUES (1672,0,0,0,0,0);
INSERT INTO `augments` VALUES (1673,0,0,0,0,0);
INSERT INTO `augments` VALUES (1674,0,0,0,0,0);
INSERT INTO `augments` VALUES (1675,0,0,0,0,0);
INSERT INTO `augments` VALUES (1676,0,0,0,0,0);
INSERT INTO `augments` VALUES (1677,0,0,0,0,0);
INSERT INTO `augments` VALUES (1678,0,0,0,0,0);
INSERT INTO `augments` VALUES (1679,0,0,0,0,0);
INSERT INTO `augments` VALUES (1680,0,0,0,0,0);
INSERT INTO `augments` VALUES (1681,0,0,0,0,0);
INSERT INTO `augments` VALUES (1682,0,0,0,0,0);
INSERT INTO `augments` VALUES (1683,0,0,0,0,0);
INSERT INTO `augments` VALUES (1684,0,0,0,0,0);
INSERT INTO `augments` VALUES (1685,0,0,0,0,0);
INSERT INTO `augments` VALUES (1686,0,0,0,0,0);
INSERT INTO `augments` VALUES (1687,0,0,0,0,0);
INSERT INTO `augments` VALUES (1688,0,0,0,0,0);
INSERT INTO `augments` VALUES (1689,0,0,0,0,0);
INSERT INTO `augments` VALUES (1690,0,0,0,0,0);
INSERT INTO `augments` VALUES (1691,0,0,0,0,0);
INSERT INTO `augments` VALUES (1692,0,0,0,0,0);
INSERT INTO `augments` VALUES (1693,0,0,0,0,0);
INSERT INTO `augments` VALUES (1694,0,0,0,0,0);
INSERT INTO `augments` VALUES (1695,0,0,0,0,0);
INSERT INTO `augments` VALUES (1696,0,0,0,0,0);
INSERT INTO `augments` VALUES (1697,0,0,0,0,0);
INSERT INTO `augments` VALUES (1698,0,0,0,0,0);
INSERT INTO `augments` VALUES (1699,0,0,0,0,0);
INSERT INTO `augments` VALUES (1700,0,0,0,0,0);
INSERT INTO `augments` VALUES (1701,0,0,0,0,0);
INSERT INTO `augments` VALUES (1702,0,0,0,0,0);
INSERT INTO `augments` VALUES (1703,0,0,0,0,0);
INSERT INTO `augments` VALUES (1704,0,0,0,0,0);
INSERT INTO `augments` VALUES (1705,0,0,0,0,0);
INSERT INTO `augments` VALUES (1706,0,0,0,0,0);
INSERT INTO `augments` VALUES (1707,0,0,0,0,0);
INSERT INTO `augments` VALUES (1708,0,0,0,0,0);
INSERT INTO `augments` VALUES (1709,0,0,0,0,0);
INSERT INTO `augments` VALUES (1710,0,0,0,0,0);
INSERT INTO `augments` VALUES (1711,0,0,0,0,0);
INSERT INTO `augments` VALUES (1712,0,0,0,0,0);
INSERT INTO `augments` VALUES (1713,0,0,0,0,0);
INSERT INTO `augments` VALUES (1714,0,0,0,0,0);
INSERT INTO `augments` VALUES (1715,0,0,0,0,0);
INSERT INTO `augments` VALUES (1716,0,0,0,0,0);
INSERT INTO `augments` VALUES (1717,0,0,0,0,0);
INSERT INTO `augments` VALUES (1718,0,0,0,0,0);
INSERT INTO `augments` VALUES (1719,0,0,0,0,0);
INSERT INTO `augments` VALUES (1720,0,0,0,0,0);
INSERT INTO `augments` VALUES (1721,0,0,0,0,0);
INSERT INTO `augments` VALUES (1722,0,0,0,0,0);
INSERT INTO `augments` VALUES (1723,0,0,0,0,0);
INSERT INTO `augments` VALUES (1724,0,0,0,0,0);
INSERT INTO `augments` VALUES (1725,0,0,0,0,0);
INSERT INTO `augments` VALUES (1726,0,0,0,0,0);
INSERT INTO `augments` VALUES (1727,0,0,0,0,0);
INSERT INTO `augments` VALUES (1728,0,0,0,0,0);
INSERT INTO `augments` VALUES (1729,0,0,0,0,0);
INSERT INTO `augments` VALUES (1730,0,0,0,0,0);
INSERT INTO `augments` VALUES (1731,0,0,0,0,0);
INSERT INTO `augments` VALUES (1732,0,0,0,0,0);
INSERT INTO `augments` VALUES (1733,0,0,0,0,0);
INSERT INTO `augments` VALUES (1734,0,0,0,0,0);
INSERT INTO `augments` VALUES (1735,0,0,0,0,0);
INSERT INTO `augments` VALUES (1736,0,0,0,0,0);
INSERT INTO `augments` VALUES (1737,0,0,0,0,0);
INSERT INTO `augments` VALUES (1738,0,0,0,0,0);
INSERT INTO `augments` VALUES (1739,0,0,0,0,0);
INSERT INTO `augments` VALUES (1740,0,0,0,0,0);
INSERT INTO `augments` VALUES (1741,0,0,0,0,0);
INSERT INTO `augments` VALUES (1742,0,0,0,0,0);
INSERT INTO `augments` VALUES (1743,0,0,0,0,0);
INSERT INTO `augments` VALUES (1744,0,0,0,0,0);
INSERT INTO `augments` VALUES (1745,0,0,0,0,0);
INSERT INTO `augments` VALUES (1746,0,0,0,0,0);
INSERT INTO `augments` VALUES (1747,0,0,0,0,0);
INSERT INTO `augments` VALUES (1748,0,0,0,0,0);
INSERT INTO `augments` VALUES (1749,0,0,0,0,0);
INSERT INTO `augments` VALUES (1750,0,0,0,0,0);
INSERT INTO `augments` VALUES (1751,0,0,0,0,0);
INSERT INTO `augments` VALUES (1752,0,0,0,0,0);
INSERT INTO `augments` VALUES (1753,0,0,0,0,0);
INSERT INTO `augments` VALUES (1754,0,0,0,0,0);
INSERT INTO `augments` VALUES (1755,0,0,0,0,0);
INSERT INTO `augments` VALUES (1756,0,0,0,0,0);
INSERT INTO `augments` VALUES (1757,0,0,0,0,0);
INSERT INTO `augments` VALUES (1758,0,0,0,0,0);
INSERT INTO `augments` VALUES (1759,0,0,0,0,0);
INSERT INTO `augments` VALUES (1760,0,0,0,0,0);
INSERT INTO `augments` VALUES (1761,0,0,0,0,0);
INSERT INTO `augments` VALUES (1762,0,0,0,0,0);
INSERT INTO `augments` VALUES (1763,0,0,0,0,0);
INSERT INTO `augments` VALUES (1764,0,0,0,0,0);
INSERT INTO `augments` VALUES (1765,0,0,0,0,0);
INSERT INTO `augments` VALUES (1766,0,0,0,0,0);
INSERT INTO `augments` VALUES (1767,0,0,0,0,0);
INSERT INTO `augments` VALUES (1768,0,0,0,0,0);
INSERT INTO `augments` VALUES (1769,0,0,0,0,0);
INSERT INTO `augments` VALUES (1770,0,0,0,0,0);
INSERT INTO `augments` VALUES (1771,0,0,0,0,0);
INSERT INTO `augments` VALUES (1772,0,0,0,0,0);
INSERT INTO `augments` VALUES (1773,0,0,0,0,0);
INSERT INTO `augments` VALUES (1774,0,0,0,0,0);
INSERT INTO `augments` VALUES (1775,0,0,0,0,0);
INSERT INTO `augments` VALUES (1776,0,0,0,0,0);
INSERT INTO `augments` VALUES (1777,0,0,0,0,0);
INSERT INTO `augments` VALUES (1778,0,0,0,0,0);
INSERT INTO `augments` VALUES (1779,0,0,0,0,0);
INSERT INTO `augments` VALUES (1780,0,0,0,0,0);
INSERT INTO `augments` VALUES (1781,0,0,0,0,0);
INSERT INTO `augments` VALUES (1782,0,0,0,0,0);
INSERT INTO `augments` VALUES (1783,0,0,0,0,0);
INSERT INTO `augments` VALUES (1784,0,0,0,0,0);
INSERT INTO `augments` VALUES (1785,0,0,0,0,0);
INSERT INTO `augments` VALUES (1786,0,0,0,0,0);
INSERT INTO `augments` VALUES (1787,0,0,0,0,0);
INSERT INTO `augments` VALUES (1788,0,0,0,0,0);
INSERT INTO `augments` VALUES (1789,0,0,0,0,0);
INSERT INTO `augments` VALUES (1790,0,0,0,0,0);
INSERT INTO `augments` VALUES (1791,0,0,0,0,0);
-- End unused block

INSERT INTO `augments` VALUES (1792,0,8,1,1,0); -- Pet: STR+1
INSERT INTO `augments` VALUES (1793,0,9,1,1,0); -- Pet: DEX+1
INSERT INTO `augments` VALUES (1794,0,10,1,1,0); -- Pet: VIT+1
INSERT INTO `augments` VALUES (1795,0,11,1,1,0); -- Pet: AGI+1
INSERT INTO `augments` VALUES (1796,0,12,1,1,0); -- Pet: INT+1
INSERT INTO `augments` VALUES (1797,0,13,1,1,0); -- Pet: MND+1
INSERT INTO `augments` VALUES (1798,0,14,1,1,0); -- Pet: CHR+1
INSERT INTO `augments` VALUES (1799,0,8,-1,1,0); -- Pet: STR-1
INSERT INTO `augments` VALUES (1800,0,9,-1,1,0); -- Pet: DEX-1
INSERT INTO `augments` VALUES (1801,0,10,-1,1,0); -- Pet: VIT-1
INSERT INTO `augments` VALUES (1802,0,11,-1,1,0); -- Pet: AGI-1
INSERT INTO `augments` VALUES (1803,0,12,-1,1,0); -- Pet: INT-1
INSERT INTO `augments` VALUES (1804,0,13,-1,1,0); -- Pet: MND-1
INSERT INTO `augments` VALUES (1805,0,14,-1,1,0); -- Pet: CHR-1
INSERT INTO `augments` VALUES (1806,0,8,1,1,0); -- Pet: STR+1 DEX+1 VIT+1
INSERT INTO `augments` VALUES (1806,0,9,1,1,0); -- Cont.
INSERT INTO `augments` VALUES (1806,0,10,1,1,0); -- Cont.
INSERT INTO `augments` VALUES (1807,0,0,0,0,0); -- Pet: <dummy>
INSERT INTO `augments` VALUES (1808,0,0,0,0,0); -- Pet: <dummy>
INSERT INTO `augments` VALUES (1809,0,0,0,0,0); -- Pet: <dummy>
INSERT INTO `augments` VALUES (1810,0,0,0,0,0); -- Pet: <dummy>
INSERT INTO `augments` VALUES (1811,0,0,0,0,0); -- Pet: <dummy>
INSERT INTO `augments` VALUES (1812,0,0,0,0,0); -- Pet: <dummy>
INSERT INTO `augments` VALUES (1813,0,0,0,0,0); -- Pet: <dummy>
INSERT INTO `augments` VALUES (1814,0,0,0,0,0); -- Pet: <dummy>
INSERT INTO `augments` VALUES (1815,0,0,0,0,0); -- Pet: <dummy>
INSERT INTO `augments` VALUES (1816,0,0,0,0,0); -- Pet: <dummy>
INSERT INTO `augments` VALUES (1817,0,0,0,0,0); -- Pet: <dummy>
INSERT INTO `augments` VALUES (1818,0,0,0,0,0); -- Pet: <dummy>
INSERT INTO `augments` VALUES (1819,0,0,0,0,0); -- Pet: <dummy>
INSERT INTO `augments` VALUES (1820,0,0,0,0,0); -- Pet: <dummy>
INSERT INTO `augments` VALUES (1821,0,0,0,0,0); -- Pet: <dummy>
INSERT INTO `augments` VALUES (1822,0,0,0,0,0); -- Pet: <dummy>
INSERT INTO `augments` VALUES (1823,0,0,0,0,0); -- Pet: <dummy>

-- 1824 to 2046 currently unused. Leave at zero. Edit+move or remove this note as new augments get discovered.
INSERT INTO `augments` VALUES (1824,0,0,0,0,0);
INSERT INTO `augments` VALUES (1825,0,0,0,0,0);
INSERT INTO `augments` VALUES (1826,0,0,0,0,0);
INSERT INTO `augments` VALUES (1827,0,0,0,0,0);
INSERT INTO `augments` VALUES (1828,0,0,0,0,0);
INSERT INTO `augments` VALUES (1829,0,0,0,0,0);
INSERT INTO `augments` VALUES (1830,0,0,0,0,0);
INSERT INTO `augments` VALUES (1831,0,0,0,0,0);
INSERT INTO `augments` VALUES (1832,0,0,0,0,0);
INSERT INTO `augments` VALUES (1833,0,0,0,0,0);
INSERT INTO `augments` VALUES (1834,0,0,0,0,0);
INSERT INTO `augments` VALUES (1835,0,0,0,0,0);
INSERT INTO `augments` VALUES (1836,0,0,0,0,0);
INSERT INTO `augments` VALUES (1837,0,0,0,0,0);
INSERT INTO `augments` VALUES (1838,0,0,0,0,0);
INSERT INTO `augments` VALUES (1839,0,0,0,0,0);
INSERT INTO `augments` VALUES (1840,0,0,0,0,0);
INSERT INTO `augments` VALUES (1841,0,0,0,0,0);
INSERT INTO `augments` VALUES (1842,0,0,0,0,0);
INSERT INTO `augments` VALUES (1843,0,0,0,0,0);
INSERT INTO `augments` VALUES (1844,0,0,0,0,0);
INSERT INTO `augments` VALUES (1845,0,0,0,0,0);
INSERT INTO `augments` VALUES (1846,0,0,0,0,0);
INSERT INTO `augments` VALUES (1847,0,0,0,0,0);
INSERT INTO `augments` VALUES (1848,0,0,0,0,0);
INSERT INTO `augments` VALUES (1849,0,0,0,0,0);
INSERT INTO `augments` VALUES (1850,0,0,0,0,0);
INSERT INTO `augments` VALUES (1851,0,0,0,0,0);
INSERT INTO `augments` VALUES (1852,0,0,0,0,0);
INSERT INTO `augments` VALUES (1853,0,0,0,0,0);
INSERT INTO `augments` VALUES (1854,0,0,0,0,0);
INSERT INTO `augments` VALUES (1855,0,0,0,0,0);
INSERT INTO `augments` VALUES (1856,0,0,0,0,0);
INSERT INTO `augments` VALUES (1857,0,0,0,0,0);
INSERT INTO `augments` VALUES (1858,0,0,0,0,0);
INSERT INTO `augments` VALUES (1859,0,0,0,0,0);
INSERT INTO `augments` VALUES (1860,0,0,0,0,0);
INSERT INTO `augments` VALUES (1861,0,0,0,0,0);
INSERT INTO `augments` VALUES (1862,0,0,0,0,0);
INSERT INTO `augments` VALUES (1863,0,0,0,0,0);
INSERT INTO `augments` VALUES (1864,0,0,0,0,0);
INSERT INTO `augments` VALUES (1865,0,0,0,0,0);
INSERT INTO `augments` VALUES (1866,0,0,0,0,0);
INSERT INTO `augments` VALUES (1867,0,0,0,0,0);
INSERT INTO `augments` VALUES (1868,0,0,0,0,0);
INSERT INTO `augments` VALUES (1869,0,0,0,0,0);
INSERT INTO `augments` VALUES (1870,0,0,0,0,0);
INSERT INTO `augments` VALUES (1871,0,0,0,0,0);
INSERT INTO `augments` VALUES (1872,0,0,0,0,0);
INSERT INTO `augments` VALUES (1873,0,0,0,0,0);
INSERT INTO `augments` VALUES (1874,0,0,0,0,0);
INSERT INTO `augments` VALUES (1875,0,0,0,0,0);
INSERT INTO `augments` VALUES (1876,0,0,0,0,0);
INSERT INTO `augments` VALUES (1877,0,0,0,0,0);
INSERT INTO `augments` VALUES (1878,0,0,0,0,0);
INSERT INTO `augments` VALUES (1879,0,0,0,0,0);
INSERT INTO `augments` VALUES (1880,0,0,0,0,0);
INSERT INTO `augments` VALUES (1881,0,0,0,0,0);
INSERT INTO `augments` VALUES (1882,0,0,0,0,0);
INSERT INTO `augments` VALUES (1883,0,0,0,0,0);
INSERT INTO `augments` VALUES (1884,0,0,0,0,0);
INSERT INTO `augments` VALUES (1885,0,0,0,0,0);
INSERT INTO `augments` VALUES (1886,0,0,0,0,0);
INSERT INTO `augments` VALUES (1887,0,0,0,0,0);
INSERT INTO `augments` VALUES (1888,0,0,0,0,0);
INSERT INTO `augments` VALUES (1889,0,0,0,0,0);
INSERT INTO `augments` VALUES (1890,0,0,0,0,0);
INSERT INTO `augments` VALUES (1891,0,0,0,0,0);
INSERT INTO `augments` VALUES (1892,0,0,0,0,0);
INSERT INTO `augments` VALUES (1893,0,0,0,0,0);
INSERT INTO `augments` VALUES (1894,0,0,0,0,0);
INSERT INTO `augments` VALUES (1895,0,0,0,0,0);
INSERT INTO `augments` VALUES (1896,0,0,0,0,0);
INSERT INTO `augments` VALUES (1897,0,0,0,0,0);
INSERT INTO `augments` VALUES (1898,0,0,0,0,0);
INSERT INTO `augments` VALUES (1899,0,0,0,0,0);
INSERT INTO `augments` VALUES (1900,0,0,0,0,0);
INSERT INTO `augments` VALUES (1901,0,0,0,0,0);
INSERT INTO `augments` VALUES (1902,0,0,0,0,0);
INSERT INTO `augments` VALUES (1903,0,0,0,0,0);
INSERT INTO `augments` VALUES (1904,0,0,0,0,0);
INSERT INTO `augments` VALUES (1905,0,0,0,0,0);
INSERT INTO `augments` VALUES (1906,0,0,0,0,0);
INSERT INTO `augments` VALUES (1907,0,0,0,0,0);
INSERT INTO `augments` VALUES (1908,0,0,0,0,0);
INSERT INTO `augments` VALUES (1909,0,0,0,0,0);
INSERT INTO `augments` VALUES (1910,0,0,0,0,0);
INSERT INTO `augments` VALUES (1911,0,0,0,0,0);
INSERT INTO `augments` VALUES (1912,0,0,0,0,0);
INSERT INTO `augments` VALUES (1913,0,0,0,0,0);
INSERT INTO `augments` VALUES (1914,0,0,0,0,0);
INSERT INTO `augments` VALUES (1915,0,0,0,0,0);
INSERT INTO `augments` VALUES (1916,0,0,0,0,0);
INSERT INTO `augments` VALUES (1917,0,0,0,0,0);
INSERT INTO `augments` VALUES (1918,0,0,0,0,0);
INSERT INTO `augments` VALUES (1919,0,0,0,0,0);
INSERT INTO `augments` VALUES (1920,0,0,0,0,0);
INSERT INTO `augments` VALUES (1921,0,0,0,0,0);
INSERT INTO `augments` VALUES (1922,0,0,0,0,0);
INSERT INTO `augments` VALUES (1923,0,0,0,0,0);
INSERT INTO `augments` VALUES (1924,0,0,0,0,0);
INSERT INTO `augments` VALUES (1925,0,0,0,0,0);
INSERT INTO `augments` VALUES (1926,0,0,0,0,0);
INSERT INTO `augments` VALUES (1927,0,0,0,0,0);
INSERT INTO `augments` VALUES (1928,0,0,0,0,0);
INSERT INTO `augments` VALUES (1929,0,0,0,0,0);
INSERT INTO `augments` VALUES (1930,0,0,0,0,0);
INSERT INTO `augments` VALUES (1931,0,0,0,0,0);
INSERT INTO `augments` VALUES (1932,0,0,0,0,0);
INSERT INTO `augments` VALUES (1933,0,0,0,0,0);
INSERT INTO `augments` VALUES (1934,0,0,0,0,0);
INSERT INTO `augments` VALUES (1935,0,0,0,0,0);
INSERT INTO `augments` VALUES (1936,0,0,0,0,0);
INSERT INTO `augments` VALUES (1937,0,0,0,0,0);
INSERT INTO `augments` VALUES (1938,0,0,0,0,0);
INSERT INTO `augments` VALUES (1939,0,0,0,0,0);
INSERT INTO `augments` VALUES (1940,0,0,0,0,0);
INSERT INTO `augments` VALUES (1941,0,0,0,0,0);
INSERT INTO `augments` VALUES (1942,0,0,0,0,0);
INSERT INTO `augments` VALUES (1943,0,0,0,0,0);
INSERT INTO `augments` VALUES (1944,0,0,0,0,0);
INSERT INTO `augments` VALUES (1945,0,0,0,0,0);
INSERT INTO `augments` VALUES (1946,0,0,0,0,0);
INSERT INTO `augments` VALUES (1947,0,0,0,0,0);
INSERT INTO `augments` VALUES (1948,0,0,0,0,0);
INSERT INTO `augments` VALUES (1949,0,0,0,0,0);
INSERT INTO `augments` VALUES (1950,0,0,0,0,0);
INSERT INTO `augments` VALUES (1951,0,0,0,0,0);
INSERT INTO `augments` VALUES (1952,0,0,0,0,0);
INSERT INTO `augments` VALUES (1953,0,0,0,0,0);
INSERT INTO `augments` VALUES (1954,0,0,0,0,0);
INSERT INTO `augments` VALUES (1955,0,0,0,0,0);
INSERT INTO `augments` VALUES (1956,0,0,0,0,0);
INSERT INTO `augments` VALUES (1957,0,0,0,0,0);
INSERT INTO `augments` VALUES (1958,0,0,0,0,0);
INSERT INTO `augments` VALUES (1959,0,0,0,0,0);
INSERT INTO `augments` VALUES (1960,0,0,0,0,0);
INSERT INTO `augments` VALUES (1961,0,0,0,0,0);
INSERT INTO `augments` VALUES (1962,0,0,0,0,0);
INSERT INTO `augments` VALUES (1963,0,0,0,0,0);
INSERT INTO `augments` VALUES (1964,0,0,0,0,0);
INSERT INTO `augments` VALUES (1965,0,0,0,0,0);
INSERT INTO `augments` VALUES (1966,0,0,0,0,0);
INSERT INTO `augments` VALUES (1967,0,0,0,0,0);
INSERT INTO `augments` VALUES (1968,0,0,0,0,0);
INSERT INTO `augments` VALUES (1969,0,0,0,0,0);
INSERT INTO `augments` VALUES (1970,0,0,0,0,0);
INSERT INTO `augments` VALUES (1971,0,0,0,0,0);
INSERT INTO `augments` VALUES (1972,0,0,0,0,0);
INSERT INTO `augments` VALUES (1973,0,0,0,0,0);
INSERT INTO `augments` VALUES (1974,0,0,0,0,0);
INSERT INTO `augments` VALUES (1975,0,0,0,0,0);
INSERT INTO `augments` VALUES (1976,0,0,0,0,0);
INSERT INTO `augments` VALUES (1977,0,0,0,0,0);
INSERT INTO `augments` VALUES (1978,0,0,0,0,0);
INSERT INTO `augments` VALUES (1979,0,0,0,0,0);
INSERT INTO `augments` VALUES (1980,0,0,0,0,0);
INSERT INTO `augments` VALUES (1981,0,0,0,0,0);
INSERT INTO `augments` VALUES (1982,0,0,0,0,0);
INSERT INTO `augments` VALUES (1983,0,0,0,0,0);
INSERT INTO `augments` VALUES (1984,0,0,0,0,0);
INSERT INTO `augments` VALUES (1985,0,0,0,0,0);
INSERT INTO `augments` VALUES (1986,0,0,0,0,0);
INSERT INTO `augments` VALUES (1987,0,0,0,0,0);
INSERT INTO `augments` VALUES (1988,0,0,0,0,0);
INSERT INTO `augments` VALUES (1989,0,0,0,0,0);
INSERT INTO `augments` VALUES (1990,0,0,0,0,0);
INSERT INTO `augments` VALUES (1991,0,0,0,0,0);
INSERT INTO `augments` VALUES (1992,0,0,0,0,0);
INSERT INTO `augments` VALUES (1993,0,0,0,0,0);
INSERT INTO `augments` VALUES (1994,0,0,0,0,0);
INSERT INTO `augments` VALUES (1995,0,0,0,0,0);
INSERT INTO `augments` VALUES (1996,0,0,0,0,0);
INSERT INTO `augments` VALUES (1997,0,0,0,0,0);
INSERT INTO `augments` VALUES (1998,0,0,0,0,0);
INSERT INTO `augments` VALUES (1999,0,0,0,0,0);
INSERT INTO `augments` VALUES (2000,0,0,0,0,0);
INSERT INTO `augments` VALUES (2001,0,0,0,0,0);
INSERT INTO `augments` VALUES (2002,0,0,0,0,0);
INSERT INTO `augments` VALUES (2003,0,0,0,0,0);
INSERT INTO `augments` VALUES (2004,0,0,0,0,0);
INSERT INTO `augments` VALUES (2005,0,0,0,0,0);
INSERT INTO `augments` VALUES (2006,0,0,0,0,0);
INSERT INTO `augments` VALUES (2007,0,0,0,0,0);
INSERT INTO `augments` VALUES (2008,0,0,0,0,0);
INSERT INTO `augments` VALUES (2009,0,0,0,0,0);
INSERT INTO `augments` VALUES (2010,0,0,0,0,0);
INSERT INTO `augments` VALUES (2011,0,0,0,0,0);
INSERT INTO `augments` VALUES (2012,0,0,0,0,0);
INSERT INTO `augments` VALUES (2013,0,0,0,0,0);
INSERT INTO `augments` VALUES (2014,0,0,0,0,0);
INSERT INTO `augments` VALUES (2015,0,0,0,0,0);
INSERT INTO `augments` VALUES (2016,0,0,0,0,0);
INSERT INTO `augments` VALUES (2017,0,0,0,0,0);
INSERT INTO `augments` VALUES (2018,0,0,0,0,0);
INSERT INTO `augments` VALUES (2019,0,0,0,0,0);
INSERT INTO `augments` VALUES (2020,0,0,0,0,0);
INSERT INTO `augments` VALUES (2021,0,0,0,0,0);
INSERT INTO `augments` VALUES (2022,0,0,0,0,0);
INSERT INTO `augments` VALUES (2023,0,0,0,0,0);
INSERT INTO `augments` VALUES (2024,0,0,0,0,0);
INSERT INTO `augments` VALUES (2025,0,0,0,0,0);
INSERT INTO `augments` VALUES (2026,0,0,0,0,0);
INSERT INTO `augments` VALUES (2027,0,0,0,0,0);
INSERT INTO `augments` VALUES (2028,0,0,0,0,0);
INSERT INTO `augments` VALUES (2029,0,0,0,0,0);
INSERT INTO `augments` VALUES (2030,0,0,0,0,0);
INSERT INTO `augments` VALUES (2031,0,0,0,0,0);
INSERT INTO `augments` VALUES (2032,0,0,0,0,0);
INSERT INTO `augments` VALUES (2033,0,0,0,0,0);
INSERT INTO `augments` VALUES (2034,0,0,0,0,0);
INSERT INTO `augments` VALUES (2035,0,0,0,0,0);
INSERT INTO `augments` VALUES (2036,0,0,0,0,0);
INSERT INTO `augments` VALUES (2037,0,0,0,0,0);
INSERT INTO `augments` VALUES (2038,0,0,0,0,0);
INSERT INTO `augments` VALUES (2039,0,0,0,0,0);
INSERT INTO `augments` VALUES (2040,0,0,0,0,0);
INSERT INTO `augments` VALUES (2041,0,0,0,0,0);
INSERT INTO `augments` VALUES (2042,0,0,0,0,0);
INSERT INTO `augments` VALUES (2043,0,0,0,0,0);
INSERT INTO `augments` VALUES (2044,0,0,0,0,0);
INSERT INTO `augments` VALUES (2045,0,0,0,0,0);
INSERT INTO `augments` VALUES (2046,0,0,0,0,0);
-- End unused block

INSERT INTO `augments` VALUES (2047,0,0,0,0,0); -- ??? (it literally just says "???")
