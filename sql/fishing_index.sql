--
-- Table structure for table `fishing_index`
-- This table is used to map the bit index against the fishID to support Fisherman's Heart
--

DROP TABLE IF EXISTS `fishing_index`;
CREATE TABLE IF NOT EXISTS `fishing_index` (
  `fishindex` tinyint(3) unsigned NOT NULL,
  `fishid`    int(5)     unsigned NOT NULL,
  PRIMARY KEY (`fishindex`, `fishid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `fishing_index` WRITE;

INSERT INTO `fishing_index` VALUES (1  , 5816 );  -- King Perch
INSERT INTO `fishing_index` VALUES (2  , 4318 );  -- Bibiki Urchin
INSERT INTO `fishing_index` VALUES (3  , 2216 );  -- Lamp Marimo
INSERT INTO `fishing_index` VALUES (4  , 5125 );  -- Phanauet Newt
INSERT INTO `fishing_index` VALUES (5  , 4443 );  -- Cobalt Jellyfish
INSERT INTO `fishing_index` VALUES (6  , 5447 );  -- Denizanasi
INSERT INTO `fishing_index` VALUES (7  , 4472 );  -- Crayfish
INSERT INTO `fishing_index` VALUES (8  , 4314 );  -- Bibikibo
INSERT INTO `fishing_index` VALUES (9  , 4360 );  -- Bastore Sardine
INSERT INTO `fishing_index` VALUES (10 , 5449 );  -- Hamsi
INSERT INTO `fishing_index` VALUES (11 , 4401 );  -- Moat Carp
INSERT INTO `fishing_index` VALUES (12 , 5473 );  -- Bastore Sweeper
INSERT INTO `fishing_index` VALUES (13 , 4500 );  -- Greedie
INSERT INTO `fishing_index` VALUES (14 , 4515 );  -- Copper Frog
INSERT INTO `fishing_index` VALUES (15 , 4403 );  -- Yellow Globe
INSERT INTO `fishing_index` VALUES (16 , 5126 );  -- Muddy Siredon
INSERT INTO `fishing_index` VALUES (17 , 5136 );  -- Istavrit
INSERT INTO `fishing_index` VALUES (18 , 4514 );  -- Quus
INSERT INTO `fishing_index` VALUES (19 , 4310 );  -- Tiny Goldfish
INSERT INTO `fishing_index` VALUES (20 , 4289 );  -- Forest Carp
INSERT INTO `fishing_index` VALUES (21 , 4379 );  -- Cheval Salmon
INSERT INTO `fishing_index` VALUES (22 , 4501 );  -- Fat Greedie
INSERT INTO `fishing_index` VALUES (23 , 5121 );  -- Moorish Idol
INSERT INTO `fishing_index` VALUES (24 , 5132 );  -- Gurnard
INSERT INTO `fishing_index` VALUES (25 , 4426 );  -- Tricolored Carp
INSERT INTO `fishing_index` VALUES (26 , 4361 );  -- Nebimonite
INSERT INTO `fishing_index` VALUES (27 , 4313 );  -- Blindfish
INSERT INTO `fishing_index` VALUES (28 , 4464 );  -- Pipira
INSERT INTO `fishing_index` VALUES (29 , 4483 );  -- Tiger Cod
INSERT INTO `fishing_index` VALUES (30 , 4290 );  -- Elshimo Frog
INSERT INTO `fishing_index` VALUES (31 , 5465 );  -- Caedarva Frog
INSERT INTO `fishing_index` VALUES (32 , 4469 );  -- Giant Catfish
INSERT INTO `fishing_index` VALUES (33 , 5540 );  -- Kokuryu
INSERT INTO `fishing_index` VALUES (34 , 5463 );  -- Yayinbaligi
INSERT INTO `fishing_index` VALUES (35 , 5537 );  -- Soryu
INSERT INTO `fishing_index` VALUES (36 , 4315 );  -- Lungfish
INSERT INTO `fishing_index` VALUES (37 , 5475 );  -- Gigant Octopus
INSERT INTO `fishing_index` VALUES (38 , 4428 );  -- Dark Bass
INSERT INTO `fishing_index` VALUES (39 , 4528 );  -- Crystal Bass
INSERT INTO `fishing_index` VALUES (40 , 4481 );  -- Ogre Eel
INSERT INTO `fishing_index` VALUES (41 , 4354 );  -- Shining Trout
INSERT INTO `fishing_index` VALUES (42 , 5461 );  -- Alabaligi
INSERT INTO `fishing_index` VALUES (43 , 5141 );  -- Veydal Wrasse
INSERT INTO `fishing_index` VALUES (44 , 5812 );  -- Blowfish
INSERT INTO `fishing_index` VALUES (45 , 4482 );  -- Nosteau Herring
INSERT INTO `fishing_index` VALUES (46 , 4580 );  -- Coral Butterfly
INSERT INTO `fishing_index` VALUES (47 , 4480 );  -- Gugru Tuna
INSERT INTO `fishing_index` VALUES (48 , 5450 );  -- Lakerda
INSERT INTO `fishing_index` VALUES (49 , 5469 );  -- Brass Loach
INSERT INTO `fishing_index` VALUES (50 , 4385 );  -- Zafmlug Bass
INSERT INTO `fishing_index` VALUES (51 , 4383 );  -- Gold Lobster
INSERT INTO `fishing_index` VALUES (52 , 5453 );  -- Istakoz
INSERT INTO `fishing_index` VALUES (53 , 4429 );  -- Black Eel
INSERT INTO `fishing_index` VALUES (54 , 5458 );  -- Yilanbaligi
INSERT INTO `fishing_index` VALUES (55 , 5128 );  -- Cone Calamary
INSERT INTO `fishing_index` VALUES (56 , 5448 );  -- Kalamar
INSERT INTO `fishing_index` VALUES (57 , 4470 );  -- Icefish
INSERT INTO `fishing_index` VALUES (58 , 4291 );  -- Sandfish
INSERT INTO `fishing_index` VALUES (59 , 4306 );  -- Giant Donko
INSERT INTO `fishing_index` VALUES (60 , 4462 );  -- Monke-Onke
INSERT INTO `fishing_index` VALUES (61 , 4402 );  -- Red Terrapin
INSERT INTO `fishing_index` VALUES (62 , 4484 );  -- Shall Shell
INSERT INTO `fishing_index` VALUES (63 , 5131 );  -- Vongola Clam
INSERT INTO `fishing_index` VALUES (64 , 5456 );  -- Istiridye
INSERT INTO `fishing_index` VALUES (65 , 5464 );  -- Kaplumbaga
INSERT INTO `fishing_index` VALUES (66 , 4399 );  -- Bluetail
INSERT INTO `fishing_index` VALUES (67 , 5452 );  -- Uskumru
INSERT INTO `fishing_index` VALUES (68 , 4427 );  -- Gold Carp
INSERT INTO `fishing_index` VALUES (69 , 5459 );  -- Sazanbaligi
INSERT INTO `fishing_index` VALUES (70 , 5815 );  -- Pelazoea
INSERT INTO `fishing_index` VALUES (71 , 4317 );  -- Trilobite
INSERT INTO `fishing_index` VALUES (72 , 4579 );  -- Elshimo Newt
INSERT INTO `fishing_index` VALUES (73 , 4479 );  -- Bhefhel Marlin
INSERT INTO `fishing_index` VALUES (74 , 5451 );  -- Kilicbaligi
INSERT INTO `fishing_index` VALUES (75 , 5466 );  -- Trumpet Shell
INSERT INTO `fishing_index` VALUES (76 , 4485 );  -- Noble Lady
INSERT INTO `fishing_index` VALUES (77 , 5139 );  -- Betta
INSERT INTO `fishing_index` VALUES (78 , 4473 );  -- Crescent Fish
INSERT INTO `fishing_index` VALUES (79 , 4288 );  -- Zebra Eel
INSERT INTO `fishing_index` VALUES (80 , 4471 );  -- Bladefish
INSERT INTO `fishing_index` VALUES (81 , 5135 );  -- Rhinochimera
INSERT INTO `fishing_index` VALUES (82 , 5130 );  -- Tavnazian Goby
INSERT INTO `fishing_index` VALUES (83 , 5460 );  -- Kayabaligi
INSERT INTO `fishing_index` VALUES (84 , 4451 );  -- Silver Shark
INSERT INTO `fishing_index` VALUES (85 , 5474 );  -- Ca Cuong
INSERT INTO `fishing_index` VALUES (86 , 4307 );  -- Jungle Catfish
INSERT INTO `fishing_index` VALUES (87 , 4477 );  -- Gavial Fish
INSERT INTO `fishing_index` VALUES (88 , 4478 );  -- Three-eyed Fish
INSERT INTO `fishing_index` VALUES (89 , 5470 );  -- Pirarucu
INSERT INTO `fishing_index` VALUES (90 , 5472 );  -- Garpike
INSERT INTO `fishing_index` VALUES (91 , 4461 );  -- Bastore Bream
INSERT INTO `fishing_index` VALUES (92 , 5454 );  -- Mercanbaligi
INSERT INTO `fishing_index` VALUES (93 , 5138 );  -- Black Ghost
INSERT INTO `fishing_index` VALUES (94 , 5813 );  -- Dorado Gar
INSERT INTO `fishing_index` VALUES (95 , 4304 );  -- Grimmonite
INSERT INTO `fishing_index` VALUES (96 , 5455 );  -- Ahtapot
INSERT INTO `fishing_index` VALUES (97 , 4454 );  -- Emperor Fish
INSERT INTO `fishing_index` VALUES (98 , 4474 );  -- Gigant Squid
INSERT INTO `fishing_index` VALUES (99 , 5462 );  -- Morinabaligi
INSERT INTO `fishing_index` VALUES (100, 5467 );  -- Megalodon
INSERT INTO `fishing_index` VALUES (101, 4384 );  -- Black Sole
INSERT INTO `fishing_index` VALUES (102, 5457 );  -- Dil
INSERT INTO `fishing_index` VALUES (103, 5133 );  -- Pterygotus
INSERT INTO `fishing_index` VALUES (104, 4463 );  -- Takitaro
INSERT INTO `fishing_index` VALUES (105, 4475 );  -- Sea zombie
INSERT INTO `fishing_index` VALUES (106, 4476 );  -- Titanictus
INSERT INTO `fishing_index` VALUES (107, 5140 );  -- Kalkanbaligi
INSERT INTO `fishing_index` VALUES (108, 5137 );  -- Turnabaligi
INSERT INTO `fishing_index` VALUES (109, 4316 );  -- Armored Pisces
INSERT INTO `fishing_index` VALUES (110, 4308 );  -- Giant Chirai
INSERT INTO `fishing_index` VALUES (111, 5814 );  -- Crocodilos
INSERT INTO `fishing_index` VALUES (112, 5446 );  -- Red Bubble-eye
INSERT INTO `fishing_index` VALUES (113, 5120 );  -- Titanic Sawfish
INSERT INTO `fishing_index` VALUES (114, 4319 );  -- Tricorn
INSERT INTO `fishing_index` VALUES (115, 5134 );  -- Mola Mola
INSERT INTO `fishing_index` VALUES (116, 5471 );  -- Gerrothorax
INSERT INTO `fishing_index` VALUES (117, 4305 );  -- Ryugu Titan
INSERT INTO `fishing_index` VALUES (118, 4309 );  -- Cave Cherax
INSERT INTO `fishing_index` VALUES (119, 5127 );  -- Gugrusaurus
INSERT INTO `fishing_index` VALUES (120, 5129 );  -- Lik
INSERT INTO `fishing_index` VALUES (121, 5476 );  -- Abaia
INSERT INTO `fishing_index` VALUES (122, 5468 );  -- Matsya
INSERT INTO `fishing_index` VALUES (123, 5538 );  -- Sekiryu
INSERT INTO `fishing_index` VALUES (124, 5539 );  -- Hakuryu
INSERT INTO `fishing_index` VALUES (125, 5817 );  -- Tiger Shark
INSERT INTO `fishing_index` VALUES (126, 5960 );  -- Ulbukan Lobster
INSERT INTO `fishing_index` VALUES (127, 5963 );  -- Senroh Sardine
INSERT INTO `fishing_index` VALUES (128, 5950 );  -- Mackerel
INSERT INTO `fishing_index` VALUES (129, 5993 );  -- Senroh Frog
INSERT INTO `fishing_index` VALUES (130, 5961 );  -- Contortopus
-- INSERT INTO `fishing_index` VALUES (131,      );  -- Unused
INSERT INTO `fishing_index` VALUES (132, 5949 );  -- Mussel
INSERT INTO `fishing_index` VALUES (133, 5952 );  -- Ruddy Seema
INSERT INTO `fishing_index` VALUES (134, 5948 );  -- Black Prawn
INSERT INTO `fishing_index` VALUES (135, 5955 );  -- Yawning Catfish
INSERT INTO `fishing_index` VALUES (136, 5995 );  -- Malicious Perch
INSERT INTO `fishing_index` VALUES (137, 6001 );  -- Clotflagration
INSERT INTO `fishing_index` VALUES (138, 5951 );  -- Bloodblotch
INSERT INTO `fishing_index` VALUES (139, 5959 );  -- Dragonfish
INSERT INTO `fishing_index` VALUES (140, 5997 );  -- Shen
INSERT INTO `fishing_index` VALUES (141, 5534 );  -- Apkallufa
INSERT INTO `fishing_index` VALUES (142, 5535 );  -- Deademoiselle
INSERT INTO `fishing_index` VALUES (143, 5536 );  -- Yorchete
INSERT INTO `fishing_index` VALUES (144, 6144 );  -- Frigorifish
INSERT INTO `fishing_index` VALUES (145, 6145 );  -- Dwarf Remora
INSERT INTO `fishing_index` VALUES (146, 6146 );  -- Remora
INSERT INTO `fishing_index` VALUES (147, 6333 );  -- Translucent Salpa
INSERT INTO `fishing_index` VALUES (148, 6334 );  -- Ra'Kaznar Shellfish
INSERT INTO `fishing_index` VALUES (149, 6335 );  -- White Lobster
INSERT INTO `fishing_index` VALUES (150, 6336 );  -- Bonefish
INSERT INTO `fishing_index` VALUES (151, 6337 );  -- Thysanopeltis
INSERT INTO `fishing_index` VALUES (152, 6338 );  -- Cameroceras
INSERT INTO `fishing_index` VALUES (153, 9077 );  -- Duskcrawler
INSERT INTO `fishing_index` VALUES (154, 6376 );  -- Tusoteuthis Longa
INSERT INTO `fishing_index` VALUES (155, 6373 );  -- Ancient Carp
INSERT INTO `fishing_index` VALUES (156, 6372 );  -- Lord of Ulbuka
INSERT INTO `fishing_index` VALUES (157, 6374 );  -- Dragon's Tabernacle
INSERT INTO `fishing_index` VALUES (158, 6371 );  -- Quicksilver Blade
INSERT INTO `fishing_index` VALUES (159, 6375 );  -- Phantom Serpent
INSERT INTO `fishing_index` VALUES (160, 9146 );  -- Ashen Crayfish
INSERT INTO `fishing_index` VALUES (161, 5953 );  -- Dragonfly Trout
INSERT INTO `fishing_index` VALUES (162, 5957 );  -- Shockfish
INSERT INTO `fishing_index` VALUES (163, 6489 );  -- Far East Puffer
INSERT INTO `fishing_index` VALUES (164, 9216 );  -- Voidsnapper
-- INSERT INTO `fishing_index` VALUES (165,      );  -- Hoptoad (Not added yet)

UNLOCK TABLES;
