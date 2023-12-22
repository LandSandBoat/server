DROP TABLE IF EXISTS `monstrosity_species`;
CREATE TABLE `monstrosity_species` (
    `monstrosity_id` smallint(30) unsigned NOT NULL,
    `monstrosity_species_code` smallint(30) unsigned NOT NULL,
    `name` varchar(60) DEFAULT NULL,
    `mjob` tinyint(3) unsigned NOT NULL,
    `sjob` tinyint(3) unsigned NOT NULL,
    `size` tinyint(3) unsigned NOT NULL, -- 0: small, 1: medium, 2: large
    `look` varbinary(4) NOT NULL,
    PRIMARY KEY (`monstrosity_id`, `monstrosity_species_code`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- TODO: Double check the mjob/sjob values for everything using both resources:
-- https://ffxiclopedia.fandom.com/wiki/Category:Monipulators
-- https://www.bg-wiki.com/ffxi/Category:Monstrosity/Species

-- NOTE: The mjob/sjob of MONs rise at the same level, so the only difference between which
--     : order you specify them is is which 2H ability you get.

-- NOTE: Since there are so many variants of model that SEEM THE SAME BUT ACT DIFFERENTLY,
--     : guessing the model IDs isn't always good enough - they all need to eventually be
--     : properly captured.

INSERT INTO `monstrosity_species` VALUES (1,1,'Rabbit',1,1,0,0x010C);
INSERT INTO `monstrosity_species` VALUES (1,256,'Onyx Rabbit',1,4,0,0x010D); -- TODO: Look guessed not capped
INSERT INTO `monstrosity_species` VALUES (1,257,'Alabaster Rabbit',1,3,0,0x010E); -- TODO: Look guessed not capped
INSERT INTO `monstrosity_species` VALUES (1,258,'Lapinion (Rabbit)',3,4,0,0x0791); -- TODO: Look guessed not capped

INSERT INTO `monstrosity_species` VALUES (2,2,'Behemoth',1,6,2,0x0194); -- TODO: Look guessed not capped
INSERT INTO `monstrosity_species` VALUES (2,259,'Elasamoth (Behemoth)',8,6,2,0x0195); -- TODO: Look guessed not capped

INSERT INTO `monstrosity_species` VALUES (3,3,'Tiger',1,1,1,0x0134); -- TODO: Look guessed not capped
INSERT INTO `monstrosity_species` VALUES (3,261,'Legendary Tiger',1,6,1,0x0135); -- TODO: Look guessed not capped
INSERT INTO `monstrosity_species` VALUES (3,262,'Smilodon (Tiger)',1,1,1,0x08C8); -- TODO: Look guessed not capped

INSERT INTO `monstrosity_species` VALUES (4,4,'Sheep',1,1,1,0x0154);
INSERT INTO `monstrosity_species` VALUES (4,263,'Karakul (Sheep)',1,1,1,0x0951); -- TODO: Look guessed not capped

INSERT INTO `monstrosity_species` VALUES (5,5,'Ram (Sheep)',1,1,2,0x0000); -- TODO

INSERT INTO `monstrosity_species` VALUES (6,6,'Dhalmel',1,1,2,0x0000); -- TODO

INSERT INTO `monstrosity_species` VALUES (7,7,'Coeurl',1,1,1,0x0000); -- TODO
INSERT INTO `monstrosity_species` VALUES (7,266,'Lynx (Coeurl)',1,4,1,0x0000); -- TODO
INSERT INTO `monstrosity_species` VALUES (7,267,'Collared Lynx (Coeurl)',5,4,1,0x0000); -- TODO

INSERT INTO `monstrosity_species` VALUES (8,8,'Opo-opo',1,1,0,0x0000); -- TODO

INSERT INTO `monstrosity_species` VALUES (9,9,'Manticore',1,1,1,0x0000); -- TODO
INSERT INTO `monstrosity_species` VALUES (9,268,'Legendary Manticore',5,4,1,0x0000); -- TODO

INSERT INTO `monstrosity_species` VALUES (10,10,'Buffalo',7,7,2,0x0000); -- TODO

INSERT INTO `monstrosity_species` VALUES (11,11,'Marid',1,1,2,0x06CA); -- TODO: Look guessed not capped

INSERT INTO `monstrosity_species` VALUES (12,12,'Cerberus',1,1,2,0x0701); -- TODO: Look guessed not capped
INSERT INTO `monstrosity_species` VALUES (12,269,'Orthrus (Cerberus)',1,4,2,0x0702); -- TODO

INSERT INTO `monstrosity_species` VALUES (13,13,'Gnole',2,2,1,0x0000); -- TODO
INSERT INTO `monstrosity_species` VALUES (13,270,'Bipedal Gnole',2,2,1,0x0000); -- TODO

INSERT INTO `monstrosity_species` VALUES (15,15,'Funguar',1,1,0,0x0178);
INSERT INTO `monstrosity_species` VALUES (15,271,'Coppercap (Funguar)',1,1,0,0x0000); -- TODO

INSERT INTO `monstrosity_species` VALUES (16,16,'Treant Sapling',1,1,0,0x0188);
INSERT INTO `monstrosity_species` VALUES (16,272,'Treant',1,4,2,0x0B3C);
INSERT INTO `monstrosity_species` VALUES (16,273,'Flowering Treant',1,4,2,0x0000); -- TODO
INSERT INTO `monstrosity_species` VALUES (16,274,'Scarlet-tinged Treant',1,4,2,0x0000); -- TODO
INSERT INTO `monstrosity_species` VALUES (16,275,'Barren Treant',1,4,2,0x0000); -- TODO
INSERT INTO `monstrosity_species` VALUES (16,276,'Necklaced Treant',1,4,2,0x0000); -- TODO

INSERT INTO `monstrosity_species` VALUES (17,17,'Morbol',1,1,2,0x017C);
INSERT INTO `monstrosity_species` VALUES (17,277,'Pygmy Morbol',1,1,1,0x0950);
INSERT INTO `monstrosity_species` VALUES (17,278,'Scarce Morbol',1,1,2,0x00017D);
INSERT INTO `monstrosity_species` VALUES (17,279,'Ameretat (Morbol)',1,1,2,0x08B6); -- TODO: Look guessed not capped
INSERT INTO `monstrosity_species` VALUES (17,280,'Purbol (Morbol)',1,4,2,0x017F); -- TODO: Look guessed not capped

INSERT INTO `monstrosity_species` VALUES (18,18,'Mandragora',2,2,0,0x012C);
INSERT INTO `monstrosity_species` VALUES (18,281,'Korrigan (Mandragora)',2,4,0,0x012D); -- TODO: Look guessed not capped
INSERT INTO `monstrosity_species` VALUES (18,282,'Lycopodium (Mandragora)',2,3,0,0x08C7); -- TODO: Look guessed not capped
INSERT INTO `monstrosity_species` VALUES (18,283,'Pygmy Mandragora',2,2,0,0x089C); -- TODO: Look guessed not capped
INSERT INTO `monstrosity_species` VALUES (18,284,'Adenium (Mandragora)',2,5,0,0x0950); -- TODO: Look guessed not capped
INSERT INTO `monstrosity_species` VALUES (18,285,'Pachypodium (Mandragora)',2,2,0,0x0949); -- TODO: Look guessed not capped
INSERT INTO `monstrosity_species` VALUES (18,286,'Enlightened Mandragora',2,2,0,0x0930); -- TODO: Look guessed not capped, this is the wrong id?
INSERT INTO `monstrosity_species` VALUES (18,287,'New Year Mandragora',2,13,0,0x0B48);

INSERT INTO `monstrosity_species` VALUES (19,19,'Sabotender',1,1,0,0x0000); -- TODO
INSERT INTO `monstrosity_species` VALUES (19,288,'Sabotender Florido',1,5,0,0x0000); -- TODO

INSERT INTO `monstrosity_species` VALUES (20,20,'Flytrap',1,1,0,0x0000); -- TODO

INSERT INTO `monstrosity_species` VALUES (21,21,'Goobbue',1,1,2,0x0000); -- TODO

INSERT INTO `monstrosity_species` VALUES (22,22,'Rafflesia',8,1,1,0x0000); -- TODO
INSERT INTO `monstrosity_species` VALUES (22,289,'Mitrastema (Rafflesia)',8,4,1,0x0000); -- TODO

INSERT INTO `monstrosity_species` VALUES (23,23,'Panopt',4,4,0,0x0205);

INSERT INTO `monstrosity_species` VALUES (27,27,'Bee',1,1,0,0x0110);
INSERT INTO `monstrosity_species` VALUES (27,290,'Vermillion and Onyx Bee',1,5,0,0x0111);
INSERT INTO `monstrosity_species` VALUES (27,291,'Zaffre Bee',1,4,0,0x0790);

INSERT INTO `monstrosity_species` VALUES (28,28,'Beetle',7,7,0,0x0198);
INSERT INTO `monstrosity_species` VALUES (28,292,'Onyx Beetle',7,4,0,0x0000); -- TODO
INSERT INTO `monstrosity_species` VALUES (28,293,'Gamboge Beetle',7,5,0,0x0000); -- TODO

INSERT INTO `monstrosity_species` VALUES (29,29,'Crawler',1,1,1,0x0000); -- TODO
INSERT INTO `monstrosity_species` VALUES (29,294,'Eruca (Crawler)',1,5,1,0x0000); -- TODO
INSERT INTO `monstrosity_species` VALUES (29,295,'Emerald Crawler',3,4,1,0x0000); -- TODO
INSERT INTO `monstrosity_species` VALUES (29,296,'Pygmy Emerald Crawler',3,4,0,0x0000); -- TODO

INSERT INTO `monstrosity_species` VALUES (30,30,'Fly',1,1,1,0x01C0);
INSERT INTO `monstrosity_species` VALUES (30,297,'Vermillion Fly',1,5,1,0x0000); -- TODO

INSERT INTO `monstrosity_species` VALUES (31,31,'Scorpion',1,1,1,0x0000); -- TODO
INSERT INTO `monstrosity_species` VALUES (31,298,'Scolopendrid (Scorpion)',1,4,1,0x0000); -- TODO
INSERT INTO `monstrosity_species` VALUES (31,299,'Unusual Scolopendrid (Scorpion)',8,4,1,0x0000); -- TODO

INSERT INTO `monstrosity_species` VALUES (32,32,'Spider',1,1,0,0x0000); -- TODO
INSERT INTO `monstrosity_species` VALUES (32,300,'Reticulated Spider',1,8,0,0x0000); -- TODO
INSERT INTO `monstrosity_species` VALUES (32,301,'Vermillion and Onyx Spider',1,5,0,0x0000); -- TODO

INSERT INTO `monstrosity_species` VALUES (33,33,'Antlion',1,1,2,0x0000); -- TODO
INSERT INTO `monstrosity_species` VALUES (33,302,'Onyx Antlion',1,4,2,0x0000); -- TODO
INSERT INTO `monstrosity_species` VALUES (33,303,'Formiceros (Antlion)',8,4,2,0x0000); -- TODO

INSERT INTO `monstrosity_species` VALUES (34,34,'Diremite',8,8,1,0x0000); -- TODO
INSERT INTO `monstrosity_species` VALUES (34,304,'Arundemite (Diremite)',8,8,2,0x0000); -- TODO

INSERT INTO `monstrosity_species` VALUES (35,35,'Chigoe',6,6,0,0x0000); -- TODO
INSERT INTO `monstrosity_species` VALUES (35,305,'Azure Chigoe',6,4,0,0x0000); -- TODO

INSERT INTO `monstrosity_species` VALUES (36,36,'Wamouracampa (Wamoura larva)',7,7,1,0x0000); -- TODO
INSERT INTO `monstrosity_species` VALUES (36,306,'Coiled Wamouracampa (Wamoura larva)',7,7,1,0x0000); -- TODO
INSERT INTO `monstrosity_species` VALUES (36,307,'Wamoura',1,7,2,0x0000); -- TODO
INSERT INTO `monstrosity_species` VALUES (36,308,'Coral Wamoura',4,7,2,0x0000); -- TODO

INSERT INTO `monstrosity_species` VALUES (37,37,'Ladybug',6,6,0,0x0000); -- TODO
INSERT INTO `monstrosity_species` VALUES (37,309,'Gold Ladybug',6,5,0,0x0000); -- TODO

INSERT INTO `monstrosity_species` VALUES (38,38,'Gnat',1,1,0,0x0000); -- TODO
INSERT INTO `monstrosity_species` VALUES (38,310,'Midge (Gnat)',1,1,0,0x0000); -- TODO

INSERT INTO `monstrosity_species` VALUES (43,43,'Lizard',1,1,0,0x0148);
INSERT INTO `monstrosity_species` VALUES (43,315,'Ashen Lizard',1,4,0,0x0149);

INSERT INTO `monstrosity_species` VALUES (44,44,'Raptor',1,1,1,0x013C);
INSERT INTO `monstrosity_species` VALUES (44,316,'Emerald Raptor',1,1,1,0x0000); -- TODO
INSERT INTO `monstrosity_species` VALUES (44,317,'Vermillion Raptor',1,1,1,0x0000); -- TODO

INSERT INTO `monstrosity_species` VALUES (45,45,'Adamantoise',1,1,2,0x0000); -- TODO
INSERT INTO `monstrosity_species` VALUES (45,318,'Pygmy Adamantoise',1,1,1,0x0000); -- TODO
INSERT INTO `monstrosity_species` VALUES (45,319,'Legendary Adamantoise',1,1,2,0x0000); -- TODO
INSERT INTO `monstrosity_species` VALUES (45,320,'Ferromantoise (Adamantoise)',1,1,2,0x0000); -- TODO

INSERT INTO `monstrosity_species` VALUES (46,46,'Bugard',1,1,2,0x0547);
INSERT INTO `monstrosity_species` VALUES (46,321,'Abyssobugard (Bugard)',1,1,2,0x0548);

INSERT INTO `monstrosity_species` VALUES (47,47,'Eft',1,1,0,0x0000); -- TODO
INSERT INTO `monstrosity_species` VALUES (47,322,'Tarichuk (Eft)',1,1,0,0x0000); -- TODO

INSERT INTO `monstrosity_species` VALUES (48,48,'Wivre',1,1,2,0x08B9);
INSERT INTO `monstrosity_species` VALUES (48,323,'Unusual Wivre',1,1,2,0x0000); -- TODO

INSERT INTO `monstrosity_species` VALUES (49,49,'Peiste',1,1,1,0x0000); -- TODO
INSERT INTO `monstrosity_species` VALUES (49,324,'Sibilus (Peiste)',1,1,2,0x0000); -- TODO

INSERT INTO `monstrosity_species` VALUES (52,52,'Slime',1,1,0,0x0000); -- TODO
INSERT INTO `monstrosity_species` VALUES (52,329,'Clot (Slime)',1,1,0,0x0000); -- TODO
INSERT INTO `monstrosity_species` VALUES (52,330,'Gold Slime',1,1,0,0x0000); -- TODO
INSERT INTO `monstrosity_species` VALUES (52,331,'Boil (Slime)',1,1,2,0x0000); -- TODO

INSERT INTO `monstrosity_species` VALUES (53,53,'Hecteyes',1,1,0,0x0000); -- TODO

INSERT INTO `monstrosity_species` VALUES (54,54,'Flan',1,1,0,0x0000); -- TODO
INSERT INTO `monstrosity_species` VALUES (54,332,'Gold Flan',1,1,0,0x0000); -- TODO
INSERT INTO `monstrosity_species` VALUES (54,333,'Blancmange (Flan)',1,1,0,0x0000); -- TODO

INSERT INTO `monstrosity_species` VALUES (56,56,'Slug',1,1,0,0x0000); -- TODO

INSERT INTO `monstrosity_species` VALUES (57,57,'Sandworm',1,1,2,0x0000); -- TODO
INSERT INTO `monstrosity_species` VALUES (57,334,'Pygmy Sandworm',1,1,1,0x0000); -- TODO
INSERT INTO `monstrosity_species` VALUES (57,335,'Gigaworm (Sandworm)',1,1,2,0x0000); -- TODO

INSERT INTO `monstrosity_species` VALUES (58,58,'Leech',1,1,0,0x0114);
INSERT INTO `monstrosity_species` VALUES (58,336,'Azure Leech',1,1,0,0x0115);
INSERT INTO `monstrosity_species` VALUES (58,337,'Obdella (Leech)',1,1,0,0x078E); -- TODO: Look guessed not capped

INSERT INTO `monstrosity_species` VALUES (60,60,'Crab',1,1,0,0x0164);
INSERT INTO `monstrosity_species` VALUES (60,340,'Vermillion Crab',1,1,0,0x0165); -- TODO: Look guessed not capped
INSERT INTO `monstrosity_species` VALUES (60,341,'Basket-burdened Crab',1,1,0,0x0000); -- TODO
INSERT INTO `monstrosity_species` VALUES (60,342,'Vermillion Basket-burdened Crab',1,1,0,0x0000); -- TODO
INSERT INTO `monstrosity_species` VALUES (60,343,'Porter Crab (Crab)',1,1,0,0x0000); -- TODO

INSERT INTO `monstrosity_species` VALUES (61,61,'Pugil',1,1,0,0x015C);
INSERT INTO `monstrosity_species` VALUES (61,344,'Jagil (Pugil)',1,1,0,0x0000); -- TODO

INSERT INTO `monstrosity_species` VALUES (62,62,'Sea Monk',1,1,1,0x0000); -- TODO
INSERT INTO `monstrosity_species` VALUES (62,345,'Azure Sea Monk',1,1,1,0x0000); -- TODO

INSERT INTO `monstrosity_species` VALUES (63,63,'Uragnite',1,1,1,0x0000); -- TODO
INSERT INTO `monstrosity_species` VALUES (63,346,'Limascabra (Uragnite)',1,1,1,0x0000); -- TODO

INSERT INTO `monstrosity_species` VALUES (64,64,'Orobon',1,1,1,0x0000); -- TODO
INSERT INTO `monstrosity_species` VALUES (64,347,'Pygmy Orobon',1,1,0,0x0000); -- TODO
INSERT INTO `monstrosity_species` VALUES (64,348,'Ogrebon (Orobon)',1,1,2,0x0000); -- TODO

INSERT INTO `monstrosity_species` VALUES (65,65,'Ruszor',1,1,2,0x0000); -- TODO

INSERT INTO `monstrosity_species` VALUES (66,66,'Toad',1,1,0,0x0000); -- TODO
INSERT INTO `monstrosity_species` VALUES (66,349,'Azure Toad',1,1,0,0x0000); -- TODO
INSERT INTO `monstrosity_species` VALUES (66,350,'Vermillion Toad',1,1,0,0x0000); -- TODO

INSERT INTO `monstrosity_species` VALUES (69,69,'Bird',1,1,0,0x0000); -- TODO
INSERT INTO `monstrosity_species` VALUES (69,351,'Onyx Bird',1,1,0,0x0000); -- TODO

INSERT INTO `monstrosity_species` VALUES (70,70,'Cockatrice',1,1,1,0x0000); -- TODO
INSERT INTO `monstrosity_species` VALUES (70,352,'Ziz (Cockatrice)',1,1,1,0x0000); -- TODO

INSERT INTO `monstrosity_species` VALUES (71,71,'Roc',1,1,1,0x0000); -- TODO
INSERT INTO `monstrosity_species` VALUES (71,353,'Legendary Roc',1,1,1,0x0000); -- TODO
INSERT INTO `monstrosity_species` VALUES (71,354,'Gagana (Roc)',1,1,2,0x0000); -- TODO

INSERT INTO `monstrosity_species` VALUES (72,72,'Bat',1,1,0,0x0000); -- TODO
INSERT INTO `monstrosity_species` VALUES (72,355,'Bats',1,1,0,0x0000); -- TODO
INSERT INTO `monstrosity_species` VALUES (72,356,'Vermillion Bat',1,1,0,0x0000); -- TODO
INSERT INTO `monstrosity_species` VALUES (72,357,'Vermillion Bats',1,1,0,0x0000); -- TODO

INSERT INTO `monstrosity_species` VALUES (73,73,'Hippogryph',1,1,1,0x0000); -- TODO

INSERT INTO `monstrosity_species` VALUES (74,74,'Apkallu',2,2,0,0x0000); -- TODO
INSERT INTO `monstrosity_species` VALUES (74,358,'Inguza (Apkallu)',13,2,0,0x0000); -- TODO

INSERT INTO `monstrosity_species` VALUES (75,75,'Colibri',5,5,0,0x0000); -- TODO
INSERT INTO `monstrosity_species` VALUES (75,359,'Toucalibri (Colibri)',10,5,0,0x0000); -- TODO

INSERT INTO `monstrosity_species` VALUES (76,76,'Amphiptere',1,4,2,0x0000); -- TODO
INSERT INTO `monstrosity_species` VALUES (76,360,'Sanguiptere (Amphiptere)',4,1,2,0x0000); -- TODO

INSERT INTO `monstrosity_species` VALUES (126,254,'Astoltian Slime',1,1,0,0x0B41);
INSERT INTO `monstrosity_species` VALUES (126,508,'Astoltian She-Slime',1,1,0,0x0B5B);
INSERT INTO `monstrosity_species` VALUES (126,509,'Astoltian Metal Slime',4,1,0,0x0B5C);

INSERT INTO `monstrosity_species` VALUES (127,255,'Eorzean Spriggan',1,4,0,0x0B42);
INSERT INTO `monstrosity_species` VALUES (127,510,'Eorzean Spriggan.C',1,4,0,0x0B5D);
INSERT INTO `monstrosity_species` VALUES (127,511,'Eorzean Spriggan.G',4,1,0,0x0B5E);
