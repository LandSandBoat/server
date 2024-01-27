SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for blue_spell_list
-- ----------------------------
DROP TABLE IF EXISTS `blue_spell_list`;
CREATE TABLE `blue_spell_list` (
  `spellid` smallint(3) NOT NULL,
  `mob_skill_id` smallint(4) unsigned NOT NULL,
  `set_points` smallint(2) NOT NULL,
  `trait_category` smallint(2) NOT NULL,
  `trait_category_weight` smallint(2) NOT NULL,
  `primary_sc` smallint(2) NOT NULL,
  `secondary_sc` smallint(2) NOT NULL,
  `tertiary_sc` smallint(2) NOT NULL,
  PRIMARY KEY (`spellid`,`mob_skill_id`)
) ENGINE=Aria TRANSACTIONAL=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records
-- ----------------------------

INSERT INTO `blue_spell_list` VALUES (513,1572,3,4,1,0,0,0); -- Venom Shell
INSERT INTO `blue_spell_list` VALUES (515,462,5,4,1,0,0,0); -- Maelstrom
INSERT INTO `blue_spell_list` VALUES (517,448,1,10,1,0,0,0); -- Metallic Body
INSERT INTO `blue_spell_list` VALUES (519,452,3,18,1,1,4,0); -- Screwdriver
INSERT INTO `blue_spell_list` VALUES (521,421,4,0,1,0,0,0); -- MP Drainkiss
INSERT INTO `blue_spell_list` VALUES (522,437,2,0,1,0,0,0); -- Death Ray
INSERT INTO `blue_spell_list` VALUES (524,426,2,0,1,0,0,0); -- Sandspin
INSERT INTO `blue_spell_list` VALUES (527,513,3,7,1,6,0,0); -- Smite of Rage
INSERT INTO `blue_spell_list` VALUES (529,683,2,7,1,3,0,0); -- Bludgeon
INSERT INTO `blue_spell_list` VALUES (530,569,4,0,1,0,0,0); -- Refueling
INSERT INTO `blue_spell_list` VALUES (531,676,3,13,1,0,0,0); -- Ice Break
INSERT INTO `blue_spell_list` VALUES (532,535,4,0,1,0,0,0); -- Blitzstrahl
INSERT INTO `blue_spell_list` VALUES (533,511,3,14,2,0,0,0); -- Self-Destruct
INSERT INTO `blue_spell_list` VALUES (534,523,4,10,1,0,0,0); -- Mysterious Light
INSERT INTO `blue_spell_list` VALUES (535,1646,1,14,1,0,0,0); -- Cold Wave
INSERT INTO `blue_spell_list` VALUES (536,466,1,4,1,0,0,0); -- Poison Breath
INSERT INTO `blue_spell_list` VALUES (537,489,2,14,1,0,0,0); -- Stinking Gas
INSERT INTO `blue_spell_list` VALUES (538,530,4,6,1,0,0,0); -- Memento Mori
INSERT INTO `blue_spell_list` VALUES (539,475,3,11,1,2,5,0); -- Terror Touch
INSERT INTO `blue_spell_list` VALUES (540,1778,4,8,1,4,6,0); -- Spinal Cleave
INSERT INTO `blue_spell_list` VALUES (541,485,2,0,1,0,0,0); -- Blood Saber
INSERT INTO `blue_spell_list` VALUES (542,433,2,0,1,0,0,0); -- Digest
INSERT INTO `blue_spell_list` VALUES (543,279,2,12,1,7,0,0); -- Mandibular Bite
INSERT INTO `blue_spell_list` VALUES (544,659,2,6,1,0,0,0); -- Cursed Sphere
INSERT INTO `blue_spell_list` VALUES (545,810,4,20,1,2,0,0); -- Sickle Slash
INSERT INTO `blue_spell_list` VALUES (547,346,1,0,1,0,0,0); -- Cocoon
INSERT INTO `blue_spell_list` VALUES (548,364,3,4,1,0,0,0); -- Filamented Hold
INSERT INTO `blue_spell_list` VALUES (549,335,1,5,1,0,0,0); -- Pollen
INSERT INTO `blue_spell_list` VALUES (551,338,1,12,1,5,0,0); -- Power Attack
INSERT INTO `blue_spell_list` VALUES (554,353,5,8,1,2,5,0); -- Death Scissors
INSERT INTO `blue_spell_list` VALUES (555,791,3,13,1,0,0,0); -- Magnetite Cloud
INSERT INTO `blue_spell_list` VALUES (557,549,4,6,1,0,0,0); -- Eyes On Me
INSERT INTO `blue_spell_list` VALUES (560,1711,3,16,1,7,0,0); -- Frenetic Rip
INSERT INTO `blue_spell_list` VALUES (561,501,3,14,2,0,0,0); -- Frightful Roar
INSERT INTO `blue_spell_list` VALUES (563,560,3,10,1,0,0,0); -- Hecatomb Wave
INSERT INTO `blue_spell_list` VALUES (564,645,4,15,1,8,0,0); -- Body Slam
INSERT INTO `blue_spell_list` VALUES (565,821,4,0,1,0,0,0); -- Radiant Breath
INSERT INTO `blue_spell_list` VALUES (567,622,2,0,1,1,0,0); -- Helldive
INSERT INTO `blue_spell_list` VALUES (569,395,4,9,1,8,0,0); -- Jet Stream
INSERT INTO `blue_spell_list` VALUES (570,394,2,0,1,0,0,0); -- Blood Drain
INSERT INTO `blue_spell_list` VALUES (572,410,1,6,1,0,0,0); -- Sound Blast
INSERT INTO `blue_spell_list` VALUES (573,1701,3,4,1,0,0,0); -- Feather Tickle
INSERT INTO `blue_spell_list` VALUES (574,402,2,19,1,0,0,0); -- Feather Barrier
INSERT INTO `blue_spell_list` VALUES (575,2828,4,0,1,0,0,0); -- Jettatura
INSERT INTO `blue_spell_list` VALUES (576,1713,3,5,1,0,0,0); -- Yawn
INSERT INTO `blue_spell_list` VALUES (577,257,2,3,1,6,0,0); -- Foot Kick
INSERT INTO `blue_spell_list` VALUES (578,323,3,5,1,0,0,0); -- Wild Carrot
INSERT INTO `blue_spell_list` VALUES (579,1707,4,14,3,0,0,0); -- Voracious Trunk
INSERT INTO `blue_spell_list` VALUES (581,287,4,2,1,0,0,0); -- Healing Breeze
INSERT INTO `blue_spell_list` VALUES (582,653,2,17,1,0,0,0); -- Chaotic Eye
INSERT INTO `blue_spell_list` VALUES (584,264,2,2,1,0,0,0); -- Sheep Song
INSERT INTO `blue_spell_list` VALUES (585,266,4,3,1,12,0,0); -- Ram Charge
INSERT INTO `blue_spell_list` VALUES (587,273,2,3,1,4,0,0); -- Claw Cyclone
INSERT INTO `blue_spell_list` VALUES (588,497,2,4,1,0,0,0); -- Lowing
INSERT INTO `blue_spell_list` VALUES (589,255,5,16,1,1,8,0); -- Dimensional Death
INSERT INTO `blue_spell_list` VALUES (591,800,4,6,1,0,0,0); -- Heat Breath
INSERT INTO `blue_spell_list` VALUES (592,292,2,0,1,0,0,0); -- Blank Gaze
INSERT INTO `blue_spell_list` VALUES (593,295,3,5,1,0,0,0); -- Magic Fruit
INSERT INTO `blue_spell_list` VALUES (594,584,3,8,1,3,8,0); -- Uppercut
INSERT INTO `blue_spell_list` VALUES (595,322,5,1,1,0,0,0); -- 1000 Needles
INSERT INTO `blue_spell_list` VALUES (596,329,2,0,1,3,0,0); -- Pinecone Bomb
INSERT INTO `blue_spell_list` VALUES (597,687,2,1,1,5,0,0); -- Sprout Smack
INSERT INTO `blue_spell_list` VALUES (598,434,4,4,1,0,0,0); -- Soporific
INSERT INTO `blue_spell_list` VALUES (599,310,2,0,1,2,0,0); -- Queasyshroom
INSERT INTO `blue_spell_list` VALUES (603,302,3,1,1,1,0,0); -- Wild Oats
INSERT INTO `blue_spell_list` VALUES (604,319,5,22,1,0,0,0); -- Bad Breath
INSERT INTO `blue_spell_list` VALUES (605,516,3,0,1,0,0,0); -- Geist Wall
INSERT INTO `blue_spell_list` VALUES (606,386,2,4,1,0,0,0); -- Awful Eye
INSERT INTO `blue_spell_list` VALUES (608,377,3,17,1,0,0,0); -- Frost Breath
INSERT INTO `blue_spell_list` VALUES (610,372,4,0,1,0,0,0); -- Infrasonics
INSERT INTO `blue_spell_list` VALUES (611,1384,5,16,1,10,0,0); -- Disseverment
INSERT INTO `blue_spell_list` VALUES (612,1441,4,14,4,0,0,0); -- Actinic Burst
INSERT INTO `blue_spell_list` VALUES (613,1463,5,6,1,0,0,0); -- Reactor Cool
INSERT INTO `blue_spell_list` VALUES (614,1352,3,11,1,0,0,0); -- Saline Coat
INSERT INTO `blue_spell_list` VALUES (615,1358,5,14,4,0,0,0); -- Plasma Charge
INSERT INTO `blue_spell_list` VALUES (616,1366,5,8,1,0,0,0); -- Temporal Shift
INSERT INTO `blue_spell_list` VALUES (617,1447,3,11,1,9,0,0); -- Vertical Cleave
INSERT INTO `blue_spell_list` VALUES (618,638,2,0,1,0,0,0); -- Blastbomb
INSERT INTO `blue_spell_list` VALUES (620,609,3,8,1,8,0,0); -- Battle Dance
INSERT INTO `blue_spell_list` VALUES (621,1727,2,4,1,0,0,0); -- Sandspray
INSERT INTO `blue_spell_list` VALUES (622,665,2,11,1,7,0,0); -- Grand Slam
INSERT INTO `blue_spell_list` VALUES (623,612,3,0,1,8,0,0); -- Head Butt
INSERT INTO `blue_spell_list` VALUES (626,591,3,0,1,0,0,0); -- Bomb Toss
INSERT INTO `blue_spell_list` VALUES (628,1081,3,15,1,8,0,0); -- Frypan
INSERT INTO `blue_spell_list` VALUES (629,360,3,15,1,0,0,0); -- Flying Hip Press
INSERT INTO `blue_spell_list` VALUES (631,777,3,9,1,5,0,0); -- Hydro Shot
INSERT INTO `blue_spell_list` VALUES (632,1744,3,0,1,0,0,0); -- Diamondhide
INSERT INTO `blue_spell_list` VALUES (633,1745,5,21,1,0,0,0); -- Enervation
INSERT INTO `blue_spell_list` VALUES (634,785,5,14,2,0,0,0); -- Light of Penance
INSERT INTO `blue_spell_list` VALUES (636,1734,4,4,1,0,0,0); -- Warm-Up
INSERT INTO `blue_spell_list` VALUES (637,1733,5,17,1,0,0,0); -- Firespit
INSERT INTO `blue_spell_list` VALUES (638,617,3,9,1,1,0,0); -- Feather Storm
INSERT INTO `blue_spell_list` VALUES (640,1771,4,20,1,5,0,0); -- Tail Slap
INSERT INTO `blue_spell_list` VALUES (641,1753,5,18,1,6,0,0); -- Hysteric Barrage
-- INSERT INTO `blue_spell_list` VALUES (641,1766,5,18,1,6,0,0); -- Hysteric Barrage
INSERT INTO `blue_spell_list` VALUES (642,1821,3,0,1,0,0,0); -- Amplification
INSERT INTO `blue_spell_list` VALUES (643,1818,3,0,1,11,0,0); -- Cannonball
INSERT INTO `blue_spell_list` VALUES (644,1963,4,4,1,0,0,0); -- Mind Blast
INSERT INTO `blue_spell_list` VALUES (645,1955,4,5,1,0,0,0); -- Exuviation
INSERT INTO `blue_spell_list` VALUES (646,1958,4,6,1,0,0,0); -- Magic Hammer
INSERT INTO `blue_spell_list` VALUES (647,1722,2,17,1,0,0,0); -- Zephyr Mantle
INSERT INTO `blue_spell_list` VALUES (648,2153,1,19,1,0,0,0); -- Regurgitation
INSERT INTO `blue_spell_list` VALUES (650,2163,2,1,1,7,6,0); -- Seedspray
INSERT INTO `blue_spell_list` VALUES (651,2185,4,4,1,0,0,0); -- Corrosive Ooze
INSERT INTO `blue_spell_list` VALUES (652,2181,3,12,1,1,0,0); -- Spiral Spin
INSERT INTO `blue_spell_list` VALUES (653,2176,2,21,1,3,8,0); -- Asuran Claws
INSERT INTO `blue_spell_list` VALUES (654,2436,4,22,1,12,0,0); -- Sub-Zero Smash
INSERT INTO `blue_spell_list` VALUES (655,2423,3,0,1,0,0,0); -- Triumphant Roar
INSERT INTO `blue_spell_list` VALUES (656,2562,3,24,1,0,0,0); -- Acrid Stream
INSERT INTO `blue_spell_list` VALUES (657,2564,3,25,1,0,0,0); -- Blazing Bound
INSERT INTO `blue_spell_list` VALUES (658,2173,4,0,1,0,0,0); -- Plenilune Embrace
INSERT INTO `blue_spell_list` VALUES (658,2174,4,0,1,0,0,0); -- Plenilune Embrace
INSERT INTO `blue_spell_list` VALUES (659,2101,4,24,1,0,0,0); -- Demoralizing Roar
INSERT INTO `blue_spell_list` VALUES (660,2161,3,27,1,0,0,0); -- Cimicine Discharge
INSERT INTO `blue_spell_list` VALUES (661,1782,5,25,1,0,0,0); -- Animating Wail
INSERT INTO `blue_spell_list` VALUES (662,525,3,0,1,0,0,0); -- Battery Charge
INSERT INTO `blue_spell_list` VALUES (663,331,4,27,1,0,0,0); -- Leafstorm
INSERT INTO `blue_spell_list` VALUES (664,461,2,0,1,0,0,0); -- Regeneration
INSERT INTO `blue_spell_list` VALUES (665,336,1,26,1,11,0,0); -- Final Sting
INSERT INTO `blue_spell_list` VALUES (666,590,3,23,1,11,8,0); -- Goblin Rush
INSERT INTO `blue_spell_list` VALUES (667,388,2,16,1,0,0,0); -- Vanity Dive
INSERT INTO `blue_spell_list` VALUES (668,555,3,10,1,0,0,0); -- Magic Barrier
INSERT INTO `blue_spell_list` VALUES (669,514,2,26,1,4,6,0); -- Whirl of Rage
INSERT INTO `blue_spell_list` VALUES (670,2629,4,23,1,9,1,0); -- Benthic Typhoon
INSERT INTO `blue_spell_list` VALUES (671,1220,4,22,1,0,0,0); -- Auroral Drape
INSERT INTO `blue_spell_list` VALUES (672,2631,5,13,1,0,0,0); -- Osmosis
INSERT INTO `blue_spell_list` VALUES (673,741,4,25,1,10,4,0); -- Quadratic Continuum
INSERT INTO `blue_spell_list` VALUES (674,580,1,20,1,0,0,0); -- Fantod
INSERT INTO `blue_spell_list` VALUES (675,1817,3,8,1,0,0,0); -- Thermal Pulse
INSERT INTO `blue_spell_list` VALUES (677,1230,3,24,1,2,4,0); -- Empty Thrash
INSERT INTO `blue_spell_list` VALUES (678,301,3,6,1,0,0,0); -- Dream Flower
INSERT INTO `blue_spell_list` VALUES (679,1255,3,18,1,0,0,0); -- Occultation
INSERT INTO `blue_spell_list` VALUES (680,483,4,28,1,0,0,0); -- Charged Whisker
INSERT INTO `blue_spell_list` VALUES (681,1245,5,14,4,0,0,0); -- Winds of Promyvion
INSERT INTO `blue_spell_list` VALUES (682,2154,2,25,1,3,6,0); -- Delta Thrust
INSERT INTO `blue_spell_list` VALUES (683,920,4,28,1,0,0,0); -- Everyones Grudge
INSERT INTO `blue_spell_list` VALUES (684,2431,4,27,1,0,0,0); -- Reaving Wind
INSERT INTO `blue_spell_list` VALUES (685,1703,3,15,1,0,0,0); -- Barrier Tusk
INSERT INTO `blue_spell_list` VALUES (686,502,4,25,1,0,0,0); -- Mortal Ray
INSERT INTO `blue_spell_list` VALUES (687,1959,2,17,1,0,0,0); -- Water Bomb
INSERT INTO `blue_spell_list` VALUES (688,675,2,24,1,12,1,0); -- Heavy Strike
INSERT INTO `blue_spell_list` VALUES (689,2421,3,21,1,0,0,0); -- Dark Orb
INSERT INTO `blue_spell_list` VALUES (690,1724,5,2,1,0,0,0); -- White Wind
INSERT INTO `blue_spell_list` VALUES (692,2178,4,20,1,6,0,0); -- Sudden Lunge
INSERT INTO `blue_spell_list` VALUES (693,1149,5,23,1,3,4,8); -- Quadrastrike
INSERT INTO `blue_spell_list` VALUES (694,1354,3,10,1,0,0,0); -- Vapor Spray
INSERT INTO `blue_spell_list` VALUES (695,820,4,15,1,0,0,0); -- Thunder Breath
INSERT INTO `blue_spell_list` VALUES (696,2201,5,21,1,0,0,0); -- Orcish Counterstance
INSERT INTO `blue_spell_list` VALUES (697,1824,4,28,1,9,0,0); -- Amorphic Spikes
INSERT INTO `blue_spell_list` VALUES (698,644,2,22,1,0,0,0); -- Wind breath
INSERT INTO `blue_spell_list` VALUES (699,253,2,25,1,10,4,0); -- Barbed Crescent
-- INSERT INTO `blue_spell_list` VALUES (700,2945,6,16,8,0,0,0); -- Natures Meditation
-- INSERT INTO `blue_spell_list` VALUES (701,2950,6,18,8,0,0,0); -- Tempestuous Upheaval
-- INSERT INTO `blue_spell_list` VALUES (702,2958,6,13,8,0,0,0); -- Rending Deluge
-- INSERT INTO `blue_spell_list` VALUES (703,2967,6,8,8,0,0,0); -- Embalming Earth
-- INSERT INTO `blue_spell_list` VALUES (704,2970,6,23,8,9,0,0); -- Paralyzing Triad
-- INSERT INTO `blue_spell_list` VALUES (705,2974,4,29,8,0,0,0); -- Foul Waters
-- INSERT INTO `blue_spell_list` VALUES (706,2988,2,15,8,12,0,0); -- Glutinous Dart
-- INSERT INTO `blue_spell_list` VALUES (707,3030,5,17,8,0,0,0); -- Retinal Glare
-- INSERT INTO `blue_spell_list` VALUES (708,2930,6,24,8,0,0,0); -- Subduction
-- INSERT INTO `blue_spell_list` VALUES (709,256,7,24,3,11,0,0); -- Thrashing Assault
-- INSERT INTO `blue_spell_list` VALUES (710,1952,4,17,2,0,0,0); -- Erratic Flutter
-- INSERT INTO `blue_spell_list` VALUES (711,256,0,0,0,0,0,0); -- Restoral
-- INSERT INTO `blue_spell_list` VALUES (712,256,0,0,0,0,0,0); -- Rail Cannon
-- INSERT INTO `blue_spell_list` VALUES (713,2054,0,0,0,0,0,0); -- Diffusion Ray
-- INSERT INTO `blue_spell_list` VALUES (714,2073,0,0,0,9,5,0); -- Sinker Drill
-- INSERT INTO `blue_spell_list` VALUES (723,0,0,0,0,12,10,0); -- Saurian Slide
INSERT INTO `blue_spell_list` VALUES (736,629,0,0,0,0,0,0); -- Thunderbolt
INSERT INTO `blue_spell_list` VALUES (737,807,0,0,0,0,0,0); -- Harden Shell
INSERT INTO `blue_spell_list` VALUES (738,1305,0,0,0,0,0,0); -- Absolute Terror
INSERT INTO `blue_spell_list` VALUES (739,1790,0,0,0,0,0,0); -- Gates of Hades
INSERT INTO `blue_spell_list` VALUES (740,2024,0,0,0,13,12,0); -- Tourbillion
INSERT INTO `blue_spell_list` VALUES (741,1831,0,0,0,0,0,0); -- Pyric Bulwark
INSERT INTO `blue_spell_list` VALUES (742,2118,0,0,0,14,9,0); -- Bilgestorm
INSERT INTO `blue_spell_list` VALUES (743,2106,0,0,0,14,10,0); -- Bloodrake
INSERT INTO `blue_spell_list` VALUES (744,3005,0,0,0,0,0,0); -- Droning Whirlwind
INSERT INTO `blue_spell_list` VALUES (745,3014,0,0,0,0,0,0); -- Carcharian Verve
INSERT INTO `blue_spell_list` VALUES (746,3020,0,0,0,0,0,0); -- Blistering Roar
