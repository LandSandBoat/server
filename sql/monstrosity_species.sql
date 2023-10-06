DROP TABLE IF EXISTS `monstrosity_species`;
CREATE TABLE `monstrosity_species` (
    `monstrosity_id` smallint(30) unsigned NOT NULL,
    `monstrosity_species_code` smallint(30) unsigned NOT NULL,
    `name` varchar(60) DEFAULT NULL,
    `look` smallint(3) unsigned NOT NULL,
    PRIMARY KEY (`monstrosity_id`, `monstrosity_species_code`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

INSERT INTO `monstrosity_species` VALUES (1, 1, "Rabbit", 0x010C);
INSERT INTO `monstrosity_species` VALUES (1, 256, "Onyx Rabbit", 0x010D); -- TODO: Look guessed not capped
INSERT INTO `monstrosity_species` VALUES (1, 257, "Alabaster Rabbit", 0x010E); -- TODO: Look guessed not capped
INSERT INTO `monstrosity_species` VALUES (1, 258, "Lapinion (Rabbit)", 0x0791); -- TODO: Look guessed not capped

INSERT INTO `monstrosity_species` VALUES (2, 2, "Behemoth", 0x0194); -- TODO: Look guessed not capped
INSERT INTO `monstrosity_species` VALUES (2, 259, "Elasamoth (Behemoth)", 0x0195); -- TODO: Look guessed not capped

INSERT INTO `monstrosity_species` VALUES (3, 3, "Tiger", 0x0134); -- TODO: Look guessed not capped
INSERT INTO `monstrosity_species` VALUES (3, 261, "Legendary Tiger", 0x0134); -- TODO: Look guessed not capped, this is the wrong id
INSERT INTO `monstrosity_species` VALUES (3, 262, "Smilodon (Tiger)", 0x0134); -- TODO: Look guessed not capped, this is the wrong id

INSERT INTO `monstrosity_species` VALUES (4, 4, "Sheep", 0x0154); -- TODO: Look guessed not capped, this is the wrong id
INSERT INTO `monstrosity_species` VALUES (4, 263, "Karakul (Sheep)", 0x0154); -- TODO: Look guessed not capped, this is the wrong id

INSERT INTO `monstrosity_species` VALUES (5, 5, "Ram (Sheep)", 0x0000);

INSERT INTO `monstrosity_species` VALUES (6, 6, "Dhalmel", 0x0000);

INSERT INTO `monstrosity_species` VALUES (7, 7, "Coeurl", 0x0000);
INSERT INTO `monstrosity_species` VALUES (7, 266, "Lynx (Coeurl)", 0x0000);
INSERT INTO `monstrosity_species` VALUES (7, 267, "Collared Lynx (Coeurl)", 0x0000);

INSERT INTO `monstrosity_species` VALUES (8, 8, "Opo-opo", 0x0000);

INSERT INTO `monstrosity_species` VALUES (9, 9, "Manticore", 0x0000);
INSERT INTO `monstrosity_species` VALUES (9, 268, "Legendary Manticore", 0x0000);

INSERT INTO `monstrosity_species` VALUES (10, 10, "Buffalo", 0x0000);

INSERT INTO `monstrosity_species` VALUES (11, 11, "Marid", 0x0000);

INSERT INTO `monstrosity_species` VALUES (12, 12, "Cerberus", 0x0000);
INSERT INTO `monstrosity_species` VALUES (12, 269, "Orthrus (Cerberus)", 0x0000);

INSERT INTO `monstrosity_species` VALUES (13, 13, "Gnole", 0x0000);
INSERT INTO `monstrosity_species` VALUES (13, 270, "Bipedal Gnole", 0x0000);

INSERT INTO `monstrosity_species` VALUES (15, 15, "Funguar", 0x0000);
INSERT INTO `monstrosity_species` VALUES (15, 271, "Coppercap (Funguar)", 0x0000);

INSERT INTO `monstrosity_species` VALUES (16, 16, "Treant Sapling", 0x0000);
INSERT INTO `monstrosity_species` VALUES (16, 272, "Treant", 0x0000);
INSERT INTO `monstrosity_species` VALUES (16, 273, "Flowering Treant", 0x0000);
INSERT INTO `monstrosity_species` VALUES (16, 274, "Scarlet-tinged Treant", 0x0000);
INSERT INTO `monstrosity_species` VALUES (16, 275, "Barren Treant", 0x0000);
INSERT INTO `monstrosity_species` VALUES (16, 276, "Necklaced Treant", 0x0000);

INSERT INTO `monstrosity_species` VALUES (17, 17, "Morbol", 0x0000);
INSERT INTO `monstrosity_species` VALUES (17, 277, "Pygmy Morbol", 0x0000);
INSERT INTO `monstrosity_species` VALUES (17, 278, "Scarce Morbol", 0x0000);
INSERT INTO `monstrosity_species` VALUES (17, 279, "Ameretat (Morbol)", 0x0000);
INSERT INTO `monstrosity_species` VALUES (17, 280, "Purbol (Morbol)", 0x0000);

INSERT INTO `monstrosity_species` VALUES (18, 18, "Mandragora", 0x012C);
INSERT INTO `monstrosity_species` VALUES (18, 281, "Korrigan (Mandragora)", 0x012C); -- TODO: Look guessed not capped
INSERT INTO `monstrosity_species` VALUES (18, 282, "Lycopodium (Mandragora)", 0x012C); -- TODO: Look guessed not capped
INSERT INTO `monstrosity_species` VALUES (18, 283, "Pygmy Mandragora", 0x012C); -- TODO: Look guessed not capped
INSERT INTO `monstrosity_species` VALUES (18, 284, "Adenium (Mandragora)", 0x012C); -- TODO: Look guessed not capped
INSERT INTO `monstrosity_species` VALUES (18, 285, "Pachypodium (Mandragora)", 0x012C); -- TODO: Look guessed not capped
INSERT INTO `monstrosity_species` VALUES (18, 286, "Enlightened Mandragora", 0x012C); -- TODO: Look guessed not capped
INSERT INTO `monstrosity_species` VALUES (18, 287, "New Year Mandragora", 0x0B48);

INSERT INTO `monstrosity_species` VALUES (19, 19, "Sabotender", 0x0000);
INSERT INTO `monstrosity_species` VALUES (19, 288, "Sabotender Florido", 0x0000);

INSERT INTO `monstrosity_species` VALUES (20, 20, "Flytrap", 0x0000);

INSERT INTO `monstrosity_species` VALUES (21, 21, "Goobbue", 0x0000);

INSERT INTO `monstrosity_species` VALUES (22, 22, "Rafflesia", 0x0000);
INSERT INTO `monstrosity_species` VALUES (22, 289, "Mitrastema (Rafflesia)", 0x0000);

INSERT INTO `monstrosity_species` VALUES (23, 23, "Panopt", 0x0000);

INSERT INTO `monstrosity_species` VALUES (27, 27, "Bee", 0x0000);
INSERT INTO `monstrosity_species` VALUES (27, 290, "Vermillion and Onyx Bee", 0x0000);
INSERT INTO `monstrosity_species` VALUES (27, 291, "Zaffre Bee", 0x0000);

INSERT INTO `monstrosity_species` VALUES (28, 28, "Beetle", 0x0000);
INSERT INTO `monstrosity_species` VALUES (28, 292, "Onyx Beetle", 0x0000);
INSERT INTO `monstrosity_species` VALUES (28, 293, "Gamboge Beetle", 0x0000);

INSERT INTO `monstrosity_species` VALUES (29, 29, "Crawler", 0x0000);
INSERT INTO `monstrosity_species` VALUES (29, 294, "Eruca (Crawler)", 0x0000);
INSERT INTO `monstrosity_species` VALUES (29, 295, "Emerald Crawler", 0x0000);
INSERT INTO `monstrosity_species` VALUES (29, 296, "Pygmy Emerald Crawler", 0x0000);

INSERT INTO `monstrosity_species` VALUES (30, 30, "Fly", 0x0000);
INSERT INTO `monstrosity_species` VALUES (30, 297, "Vermillion Fly", 0x0000);

INSERT INTO `monstrosity_species` VALUES (31, 31, "Scorpion", 0x0000);
INSERT INTO `monstrosity_species` VALUES (31, 298, "Scolopendrid (Scorpion)", 0x0000);
INSERT INTO `monstrosity_species` VALUES (31, 299, "Unusual Scolopendrid (Scorpion)", 0x0000);

INSERT INTO `monstrosity_species` VALUES (32, 32, "Spider", 0x0000);
INSERT INTO `monstrosity_species` VALUES (32, 300, "Reticulated Spider", 0x0000);
INSERT INTO `monstrosity_species` VALUES (32, 301, "Vermillion and Onyx Spider", 0x0000);

INSERT INTO `monstrosity_species` VALUES (33, 33, "Antlion", 0x0000);
INSERT INTO `monstrosity_species` VALUES (33, 302, "Onyx Antlion", 0x0000);
INSERT INTO `monstrosity_species` VALUES (33, 303, "Formiceros (Antlion)", 0x0000);

INSERT INTO `monstrosity_species` VALUES (34, 34, "Diremite", 0x0000);
INSERT INTO `monstrosity_species` VALUES (34, 304, "Arundemite (Diremite)", 0x0000);

INSERT INTO `monstrosity_species` VALUES (35, 35, "Chigoe", 0x0000);
INSERT INTO `monstrosity_species` VALUES (35, 305, "Azure Chigoe", 0x0000);

INSERT INTO `monstrosity_species` VALUES (36, 36, "Wamouracampa (Wamoura larva)", 0x0000);
INSERT INTO `monstrosity_species` VALUES (36, 306, "Coiled Wamouracampa (Wamoura larva)", 0x0000);
INSERT INTO `monstrosity_species` VALUES (36, 307, "Wamoura", 0x0000);
INSERT INTO `monstrosity_species` VALUES (36, 308, "Coral Wamoura", 0x0000);

INSERT INTO `monstrosity_species` VALUES (37, 37, "Ladybug", 0x0000);
INSERT INTO `monstrosity_species` VALUES (37, 309, "Gold Ladybug", 0x0000);

INSERT INTO `monstrosity_species` VALUES (38, 38, "Gnat", 0x0000);
INSERT INTO `monstrosity_species` VALUES (38, 310, "Midge (Gnat)", 0x0000);

INSERT INTO `monstrosity_species` VALUES (43, 43, "Lizard", 0x0148);
INSERT INTO `monstrosity_species` VALUES (43, 315, "Ashen Lizard", 0x0148); -- TODO: Look guessed not capped

INSERT INTO `monstrosity_species` VALUES (44, 44, "Raptor", 0x0000);
INSERT INTO `monstrosity_species` VALUES (44, 316, "Emerald Raptor", 0x0000);
INSERT INTO `monstrosity_species` VALUES (44, 317, "Vermillion Raptor", 0x0000);

INSERT INTO `monstrosity_species` VALUES (45, 45, "Adamantoise", 0x0000);
INSERT INTO `monstrosity_species` VALUES (45, 318, "Pygmy Adamantoise", 0x0000);
INSERT INTO `monstrosity_species` VALUES (45, 319, "Legendary Adamantoise", 0x0000);
INSERT INTO `monstrosity_species` VALUES (45, 320, "Ferromantoise (Adamantoise)", 0x0000);

INSERT INTO `monstrosity_species` VALUES (46, 46, "Bugard", 0x0000);
INSERT INTO `monstrosity_species` VALUES (46, 321, "Abyssobugard (Bugard)", 0x0000);

INSERT INTO `monstrosity_species` VALUES (47, 47, "Eft", 0x0000);
INSERT INTO `monstrosity_species` VALUES (47, 322, "Tarichuk (Eft)", 0x0000);

INSERT INTO `monstrosity_species` VALUES (48, 48, "Wivre", 0x0000);
INSERT INTO `monstrosity_species` VALUES (48, 323, "Unusual Wivre", 0x0000);

INSERT INTO `monstrosity_species` VALUES (49, 49, "Peiste", 0x0000);
INSERT INTO `monstrosity_species` VALUES (49, 324, "Sibilus (Peiste)", 0x0000);

INSERT INTO `monstrosity_species` VALUES (52, 52, "Slime", 0x0000);
INSERT INTO `monstrosity_species` VALUES (52, 329, "Clot (Slime)", 0x0000);
INSERT INTO `monstrosity_species` VALUES (52, 330, "Gold Slime", 0x0000);
INSERT INTO `monstrosity_species` VALUES (52, 331, "Boil (Slime)", 0x0000);

INSERT INTO `monstrosity_species` VALUES (53, 53, "Hecteyes", 0x0000);

INSERT INTO `monstrosity_species` VALUES (54, 54, "Flan", 0x0000);
INSERT INTO `monstrosity_species` VALUES (54, 332, "Gold Flan", 0x0000);
INSERT INTO `monstrosity_species` VALUES (54, 333, "Blancmange (Flan)", 0x0000);

INSERT INTO `monstrosity_species` VALUES (56, 56, "Slug", 0x0000);

INSERT INTO `monstrosity_species` VALUES (57, 57, "Sandworm", 0x0000);
INSERT INTO `monstrosity_species` VALUES (57, 334, "Pygmy Sandworm", 0x0000);
INSERT INTO `monstrosity_species` VALUES (57, 335, "Gigaworm (Sandworm)", 0x0000);

INSERT INTO `monstrosity_species` VALUES (58, 58, "Leech", 0x0000);
INSERT INTO `monstrosity_species` VALUES (58, 336, "Azure Leech", 0x0000);
INSERT INTO `monstrosity_species` VALUES (58, 337, "Obdella (Leech)", 0x0000);

INSERT INTO `monstrosity_species` VALUES (60, 60, "Crab", 0x0000);
INSERT INTO `monstrosity_species` VALUES (60, 340, "Vermillion Crab", 0x0000);
INSERT INTO `monstrosity_species` VALUES (60, 341, "Basket-burdened Crab", 0x0000);
INSERT INTO `monstrosity_species` VALUES (60, 342, "Vermillion Basket-burdened Crab", 0x0000);
INSERT INTO `monstrosity_species` VALUES (60, 343, "Porter Crab (Crab)", 0x0000);

INSERT INTO `monstrosity_species` VALUES (61, 61, "Pugil", 0x0000);
INSERT INTO `monstrosity_species` VALUES (61, 344, "Jagil (Pugil)", 0x0000);

INSERT INTO `monstrosity_species` VALUES (62, 62, "Sea Monk", 0x0000);
INSERT INTO `monstrosity_species` VALUES (62, 345, "Azure Sea Monk", 0x0000);

INSERT INTO `monstrosity_species` VALUES (63, 63, "Uragnite", 0x0000);
INSERT INTO `monstrosity_species` VALUES (63, 346, "Limascabra (Uragnite)", 0x0000);

INSERT INTO `monstrosity_species` VALUES (64, 64, "Orobon", 0x0000);
INSERT INTO `monstrosity_species` VALUES (64, 347, "Pygmy Orobon", 0x0000);
INSERT INTO `monstrosity_species` VALUES (64, 348, "Ogrebon (Orobon)", 0x0000);

INSERT INTO `monstrosity_species` VALUES (65, 65, "Ruszor", 0x0000);

INSERT INTO `monstrosity_species` VALUES (66, 66, "Toad", 0x0000);
INSERT INTO `monstrosity_species` VALUES (66, 349, "Azure Toad", 0x0000);
INSERT INTO `monstrosity_species` VALUES (66, 350, "Vermillion Toad", 0x0000);

INSERT INTO `monstrosity_species` VALUES (69, 69, "Bird", 0x0000);
INSERT INTO `monstrosity_species` VALUES (69, 351, "Onyx Bird", 0x0000);

INSERT INTO `monstrosity_species` VALUES (70, 70, "Cockatrice", 0x0000);
INSERT INTO `monstrosity_species` VALUES (70, 352, "Ziz (Cockatrice)", 0x0000);

INSERT INTO `monstrosity_species` VALUES (71, 71, "Roc", 0x0000);
INSERT INTO `monstrosity_species` VALUES (71, 353, "Legendary Roc", 0x0000);
INSERT INTO `monstrosity_species` VALUES (71, 354, "Gagana (Roc)", 0x0000);

INSERT INTO `monstrosity_species` VALUES (72, 72, "Bat", 0x0000);
INSERT INTO `monstrosity_species` VALUES (72, 355, "Bats", 0x0000);
INSERT INTO `monstrosity_species` VALUES (72, 356, "Vermillion Bat", 0x0000);
INSERT INTO `monstrosity_species` VALUES (72, 357, "Vermillion Bats", 0x0000);

INSERT INTO `monstrosity_species` VALUES (73, 73, "Hippogryph", 0x0000);

INSERT INTO `monstrosity_species` VALUES (74, 74, "Apkallu", 0x0000);
INSERT INTO `monstrosity_species` VALUES (74, 358, "Inguza (Apkallu)", 0x0000);

INSERT INTO `monstrosity_species` VALUES (75, 75, "Colibri", 0x0000);
INSERT INTO `monstrosity_species` VALUES (75, 359, "Toucalibri (Colibri)", 0x0000);

INSERT INTO `monstrosity_species` VALUES (76, 76, "Amphiptere", 0x0000);
INSERT INTO `monstrosity_species` VALUES (76, 360, "Sanguiptere (Amphiptere)", 0x0000);

INSERT INTO `monstrosity_species` VALUES (126, 254, "Astoltian Slime", 0x0B41); -- TODO: Look guessed not capped
INSERT INTO `monstrosity_species` VALUES (126, 508, "Astoltian She-Slime", 0x0B5B); -- TODO: Look guessed not capped
INSERT INTO `monstrosity_species` VALUES (126, 509, "Astoltian Metal Slime", 0x0B5C); -- TODO: Look guessed not capped

INSERT INTO `monstrosity_species` VALUES (127, 255, "Eorzean Spriggan", 0x0B42); -- TODO: Look guessed not capped
INSERT INTO `monstrosity_species` VALUES (127, 510, "Eorzean Spriggan.C", 0x0B5D); -- TODO: Look guessed not capped
INSERT INTO `monstrosity_species` VALUES (127, 511, "Eorzean Spriggan.G", 0x0B5E); -- TODO: Look guessed not capped
