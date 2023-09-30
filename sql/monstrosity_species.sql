DROP TABLE IF EXISTS `monstrosity_species`;
CREATE TABLE `monstrosity_species` (
    `monstrosity_id` smallint(30) DEFAULT NULL, -- Used as the shift offset into the monstrosity.levels array
    `name` varchar(30) DEFAULT NULL, -- Human-readable name. Only used for this file and logging.
    `look` smallint(3) unsigned NOT NULL,       -- Look data sent from the client
  -- `family_id` smallint(3) unsigned NOT NULL,
    PRIMARY KEY (`monstrosity_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

INSERT INTO `monstrosity_species` VALUES (1, "RABBIT", 0x010C);
INSERT INTO `monstrosity_species` VALUES (2, "BEHEMOTH", 0x0194); -- Look guessed not capped
INSERT INTO `monstrosity_species` VALUES (3, "TIGER", 0x0134); -- Look guessed not capped
INSERT INTO `monstrosity_species` VALUES (4, "SHEEP", 0x0154); -- Look guessed not capped
INSERT INTO `monstrosity_species` VALUES (5, "RAM", 0x0000);
INSERT INTO `monstrosity_species` VALUES (6, "DHALMEL", 0x0000);
INSERT INTO `monstrosity_species` VALUES (7, "COEURL", 0x0000);
INSERT INTO `monstrosity_species` VALUES (8, "OPO_OPO", 0x0000);
INSERT INTO `monstrosity_species` VALUES (9, "MANTICORE", 0x0000);
INSERT INTO `monstrosity_species` VALUES (10, "BUFFALO", 0x0000);
INSERT INTO `monstrosity_species` VALUES (11, "MARID", 0x0000);
INSERT INTO `monstrosity_species` VALUES (12, "CERBERUS", 0x0000);
INSERT INTO `monstrosity_species` VALUES (13, "GNOLE", 0x0000);

INSERT INTO `monstrosity_species` VALUES (15, "FUNGUAR", 0x0000);
INSERT INTO `monstrosity_species` VALUES (16, "TREANT_SAPLING", 0x0000);
INSERT INTO `monstrosity_species` VALUES (17, "MORBOL", 0x0000);
INSERT INTO `monstrosity_species` VALUES (18, "MANDRAGORA", 0x012C);
INSERT INTO `monstrosity_species` VALUES (19, "SABOTENDER", 0x0000);
INSERT INTO `monstrosity_species` VALUES (20, "FLYTRAP", 0x0000);
INSERT INTO `monstrosity_species` VALUES (21, "GOOBBUE", 0x0000);
INSERT INTO `monstrosity_species` VALUES (22, "RAFFLESIA", 0x0000);
INSERT INTO `monstrosity_species` VALUES (23, "PANOPT", 0x0000);

INSERT INTO `monstrosity_species` VALUES (27, "BEE", 0x0000);
INSERT INTO `monstrosity_species` VALUES (28, "BEETLE", 0x0000);
INSERT INTO `monstrosity_species` VALUES (29, "CRAWLER", 0x0000);
INSERT INTO `monstrosity_species` VALUES (30, "FLY", 0x0000);
INSERT INTO `monstrosity_species` VALUES (31, "SCORPION", 0x0000);
INSERT INTO `monstrosity_species` VALUES (32, "SPIDER", 0x0000);
INSERT INTO `monstrosity_species` VALUES (33, "ANTLION", 0x0000);
INSERT INTO `monstrosity_species` VALUES (34, "DIREMITE", 0x0000);
INSERT INTO `monstrosity_species` VALUES (35, "CHIGOE", 0x0000);
INSERT INTO `monstrosity_species` VALUES (36, "WAMOURACAMPA", 0x0000);
INSERT INTO `monstrosity_species` VALUES (37, "LADYBUG", 0x0000);
INSERT INTO `monstrosity_species` VALUES (38, "GNAT", 0x0000);

INSERT INTO `monstrosity_species` VALUES (43, "LIZARD", 0x0148);
INSERT INTO `monstrosity_species` VALUES (44, "RAPTOR", 0x0000);
INSERT INTO `monstrosity_species` VALUES (45, "ADAMANTOISE", 0x0000);
INSERT INTO `monstrosity_species` VALUES (46, "BUGARD", 0x0000);
INSERT INTO `monstrosity_species` VALUES (47, "EFT", 0x0000);
INSERT INTO `monstrosity_species` VALUES (48, "WIVRE", 0x0000);
INSERT INTO `monstrosity_species` VALUES (49, "PEISTE", 0x0000);

INSERT INTO `monstrosity_species` VALUES (52, "SLIME", 0x0000);
INSERT INTO `monstrosity_species` VALUES (53, "HECTEYES", 0x0000);
INSERT INTO `monstrosity_species` VALUES (54, "FLAN", 0x0000);
INSERT INTO `monstrosity_species` VALUES (56, "SLUG", 0x0000);
INSERT INTO `monstrosity_species` VALUES (57, "SANDWORM", 0x0000);
INSERT INTO `monstrosity_species` VALUES (58, "LEECH", 0x0000);

INSERT INTO `monstrosity_species` VALUES (60, "CRAB", 0x0000);
INSERT INTO `monstrosity_species` VALUES (61, "PUGIL", 0x0000);
INSERT INTO `monstrosity_species` VALUES (62, "SEA_MONK", 0x0000);
INSERT INTO `monstrosity_species` VALUES (63, "URAGNITE", 0x0000);
INSERT INTO `monstrosity_species` VALUES (64, "OROBON", 0x0000);
INSERT INTO `monstrosity_species` VALUES (65, "RUSZOR", 0x0000);
INSERT INTO `monstrosity_species` VALUES (66, "TOAD", 0x0000);

INSERT INTO `monstrosity_species` VALUES (69, "BIRD", 0x0000);
INSERT INTO `monstrosity_species` VALUES (70, "COCKATRICE", 0x0000);
INSERT INTO `monstrosity_species` VALUES (71, "ROC", 0x0000);
INSERT INTO `monstrosity_species` VALUES (72, "BAT", 0x0000);
INSERT INTO `monstrosity_species` VALUES (73, "HIPPOGRYPH", 0x0000);
INSERT INTO `monstrosity_species` VALUES (74, "APKALLU", 0x0000);
INSERT INTO `monstrosity_species` VALUES (75, "COLIBRI", 0x0000);
INSERT INTO `monstrosity_species` VALUES (76, "AMPHIPTERE", 0x0000);

INSERT INTO `monstrosity_species` VALUES (126, "DQ_SLIME", 0x0B41);
INSERT INTO `monstrosity_species` VALUES (127, "FFXIV_SPRIGGAN", 0x0B5D); -- Look guessed not capped
