DROP TABLE IF EXISTS `monstrosity_species`;
CREATE TABLE `monstrosity_species` (
    `monstrosity_id` smallint(30) DEFAULT NULL, -- Used as the shift offset into the monstrosity.levels array
    `name` varchar(30) DEFAULT NULL, -- Human-readable name. Only used for this file and logging.
  -- `species_id` smallint(5) unsigned NOT NULL, -- Species ID sent from the client
  -- `name_id` smallint(3) unsigned NOT NULL,    -- Name ID sent from the client (re-used for variants)
  -- `look` smallint(3) unsigned NOT NULL,       -- Look data sent from the client
  -- `family_id` smallint(3) unsigned NOT NULL,
    PRIMARY KEY (`monstrosity_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

INSERT INTO `monstrosity_species` VALUES (1, "RABBIT");
INSERT INTO `monstrosity_species` VALUES (2, "BEHEMOTH");
INSERT INTO `monstrosity_species` VALUES (3, "TIGER");
INSERT INTO `monstrosity_species` VALUES (4, "SHEEP");
INSERT INTO `monstrosity_species` VALUES (5, "RAM");
INSERT INTO `monstrosity_species` VALUES (6, "DHALMEL");
INSERT INTO `monstrosity_species` VALUES (7, "COEURL");
INSERT INTO `monstrosity_species` VALUES (8, "OPO_OPO");
INSERT INTO `monstrosity_species` VALUES (9, "MANTICORE");
INSERT INTO `monstrosity_species` VALUES (10, "BUFFALO");
INSERT INTO `monstrosity_species` VALUES (11, "MARID");
INSERT INTO `monstrosity_species` VALUES (12, "CERBERUS");
INSERT INTO `monstrosity_species` VALUES (13, "GNOLE");

INSERT INTO `monstrosity_species` VALUES (15, "FUNGUAR");
INSERT INTO `monstrosity_species` VALUES (16, "TREANT_SAPLING");
INSERT INTO `monstrosity_species` VALUES (17, "MORBOL");
INSERT INTO `monstrosity_species` VALUES (18, "MANDRAGORA");
INSERT INTO `monstrosity_species` VALUES (19, "SABOTENDER");
INSERT INTO `monstrosity_species` VALUES (20, "FLYTRAP");
INSERT INTO `monstrosity_species` VALUES (21, "GOOBBUE");
INSERT INTO `monstrosity_species` VALUES (22, "RAFFLESIA");
INSERT INTO `monstrosity_species` VALUES (23, "PANOPT");

INSERT INTO `monstrosity_species` VALUES (27, "BEE");
INSERT INTO `monstrosity_species` VALUES (28, "BEETLE");
INSERT INTO `monstrosity_species` VALUES (29, "CRAWLER");
INSERT INTO `monstrosity_species` VALUES (30, "FLY");
INSERT INTO `monstrosity_species` VALUES (31, "SCORPION");
INSERT INTO `monstrosity_species` VALUES (32, "SPIDER");
INSERT INTO `monstrosity_species` VALUES (33, "ANTLION");
INSERT INTO `monstrosity_species` VALUES (34, "DIREMITE");
INSERT INTO `monstrosity_species` VALUES (35, "CHIGOE");
INSERT INTO `monstrosity_species` VALUES (36, "WAMOURACAMPA");
INSERT INTO `monstrosity_species` VALUES (37, "LADYBUG");
INSERT INTO `monstrosity_species` VALUES (38, "GNAT");

INSERT INTO `monstrosity_species` VALUES (43, "LIZARD");
INSERT INTO `monstrosity_species` VALUES (44, "RAPTOR");
INSERT INTO `monstrosity_species` VALUES (45, "ADAMANTOISE");
INSERT INTO `monstrosity_species` VALUES (46, "BUGARD");
INSERT INTO `monstrosity_species` VALUES (47, "EFT");
INSERT INTO `monstrosity_species` VALUES (48, "WIVRE");
INSERT INTO `monstrosity_species` VALUES (49, "PEISTE");

INSERT INTO `monstrosity_species` VALUES (52, "SLIME");
INSERT INTO `monstrosity_species` VALUES (53, "HECTEYES");
INSERT INTO `monstrosity_species` VALUES (54, "FLAN");
INSERT INTO `monstrosity_species` VALUES (56, "SLUG");
INSERT INTO `monstrosity_species` VALUES (57, "SANDWORM");
INSERT INTO `monstrosity_species` VALUES (58, "LEECH");

INSERT INTO `monstrosity_species` VALUES (60, "CRAB");
INSERT INTO `monstrosity_species` VALUES (61, "PUGIL");
INSERT INTO `monstrosity_species` VALUES (62, "SEA_MONK");
INSERT INTO `monstrosity_species` VALUES (63, "URAGNITE");
INSERT INTO `monstrosity_species` VALUES (64, "OROBON");
INSERT INTO `monstrosity_species` VALUES (65, "RUSZOR");
INSERT INTO `monstrosity_species` VALUES (66, "TOAD");

INSERT INTO `monstrosity_species` VALUES (69, "BIRD");
INSERT INTO `monstrosity_species` VALUES (70, "COCKATRICE");
INSERT INTO `monstrosity_species` VALUES (71, "ROC");
INSERT INTO `monstrosity_species` VALUES (72, "BAT");
INSERT INTO `monstrosity_species` VALUES (73, "HIPPOGRYPH");
INSERT INTO `monstrosity_species` VALUES (74, "APKALLU");
INSERT INTO `monstrosity_species` VALUES (75, "COLIBRI");
INSERT INTO `monstrosity_species` VALUES (76, "AMPHIPTERE");

INSERT INTO `monstrosity_species` VALUES (126, "DQ_SLIME");
INSERT INTO `monstrosity_species` VALUES (127, "FFXIV_SPRIGGAN");
