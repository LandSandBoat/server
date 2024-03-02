DROP TABLE IF EXISTS `monstrosity_tp_skills`;
CREATE TABLE IF NOT EXISTS `monstrosity_tp_skills` (
  `monstrosity_species_name` varchar(60) DEFAULT NULL,
  `monstrosity_species_id` smallint(5) unsigned NOT NULL,
  `skill_name` varchar(60) DEFAULT NULL,
  `dat_skill_id` smallint(5) unsigned NOT NULL,
  `mob_skill_id` smallint(3) unsigned NOT NULL,
  `unlock_level` smallint(3) unsigned NOT NULL,
  `tp_cost` smallint(3) unsigned NOT NULL,
  PRIMARY KEY (`monstrosity_species_id`, `dat_skill_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

INSERT INTO `monstrosity_tp_skills` VALUES ('Rabbit', '1', 'foot_kick', '257', '257', '1', '1000');
INSERT INTO `monstrosity_tp_skills` VALUES ('Rabbit', '1', 'dust_cloud', '258', '258', '10', '800');
INSERT INTO `monstrosity_tp_skills` VALUES ('Rabbit', '1', 'whirl_claws', '259', '259', '20', '1800');
INSERT INTO `monstrosity_tp_skills` VALUES ('Rabbit', '1', 'wild_carrot', '314', '323', '30', '1000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Behemoth', '2', 'wild_horn', '444', '628', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Behemoth', '2', 'shock_wave', '446', '631', '10', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Behemoth', '2', 'flame_armor', '447', '632', '20', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Behemoth', '2', 'howl', '448', '766', '30', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Behemoth', '2', 'howl', '448', '1079', '30', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Behemoth', '2', 'howl', '448', '762', '30', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Behemoth', '2', 'howl', '448', '633', '30', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Behemoth', '2', 'howl', '448', '764', '30', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Behemoth', '2', 'thunderbolt', '445', '629', '40', '2000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Tiger', '3', 'razor_fang', '271', '271', '1', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Tiger', '3', 'razor_fang', '271', '3849', '1', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Tiger', '3', 'claw_cyclone', '272', '273', '10', '1800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Tiger', '3', 'roar', '270', '270', '20', '1000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Sheep', '4', 'sheep_charge', '262', '262', '1', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Sheep', '4', 'rage', '261', '265', '10', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Sheep', '4', 'rage', '261', '261', '10', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Sheep', '4', 'rage', '261', '3858', '10', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Sheep', '4', 'sheep_song', '264', '264', '20', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Sheep', '4', 'lamb_chop', '260', '260', '30', '1300');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Ram (Sheep)', '5', 'ram_charge', '266', '266', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Ram (Sheep)', '5', 'rage', '265', '3858', '10', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Ram (Sheep)', '5', 'rage', '265', '265', '10', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Ram (Sheep)', '5', 'rage', '265', '261', '10', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Ram (Sheep)', '5', 'rumble', '267', '267', '20', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Ram (Sheep)', '5', 'petribreath', '269', '269', '40', '2000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Dhalmel', '6', 'stomping', '278', '281', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Dhalmel', '6', 'cold_stare', '279', '284', '10', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Dhalmel', '6', 'whistle', '280', '285', '20', '600');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Dhalmel', '6', 'sonic_wave', '277', '280', '30', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Dhalmel', '6', 'berserk', '281', '537', '40', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Dhalmel', '6', 'berserk', '281', '510', '40', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Dhalmel', '6', 'berserk', '281', '2217', '40', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Dhalmel', '6', 'berserk', '281', '1647', '40', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Dhalmel', '6', 'berserk', '281', '598', '40', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Dhalmel', '6', 'berserk', '281', '286', '40', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Dhalmel', '6', 'healing_breeze', '282', '287', '50', '2000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Coeurl', '7', 'frenzied_rage', '413', '1336', '1', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Coeurl', '7', 'pounce', '414', '482', '10', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Coeurl', '7', 'chaotic_eye', '452', '653', '20', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Coeurl', '7', 'blaster', '451', '652', '30', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Coeurl', '7', 'charged_whisker', '415', '483', '50', '1500');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Opo-opo', '8', 'vicious_claw', '283', '288', '1', '1300');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Opo-opo', '8', 'stone_throw', '284', '289', '10', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Opo-opo', '8', 'spinning_claw', '285', '290', '20', '1800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Opo-opo', '8', 'claw_storm', '286', '291', '30', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Opo-opo', '8', 'blank_gaze', '287', '3358', '40', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Opo-opo', '8', 'blank_gaze', '287', '586', '40', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Opo-opo', '8', 'eye_scratch', '288', '294', '50', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Opo-opo', '8', 'magic_fruit', '289', '295', '60', '1500');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Manticore', '9', 'tail_swing', '467', '798', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Manticore', '9', 'tail_smash', '468', '799', '10', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Manticore', '9', 'riddle', '470', '801', '20', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Manticore', '9', 'heat_breath', '469', '800', '30', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Manticore', '9', 'great_sandstorm', '471', '802', '40', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Manticore', '9', 'great_whirlwind', '472', '803', '50', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Manticore', '9', 'deadly_hold', '466', '797', '60', '1000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Buffalo', '10', 'big_horn', '417', '494', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Buffalo', '10', 'snort', '418', '495', '20', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Buffalo', '10', 'rampant_gnaw', '416', '493', '30', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Buffalo', '10', 'lowing', '420', '497', '40', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Buffalo', '10', 'mighty_snort', '503', '1364', '50', '1200');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Marid', '11', 'onrush', '519', '1704', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Marid', '11', 'flailing_trunk', '521', '1706', '10', '1600');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Marid', '11', 'voracious_trunk', '522', '1707', '20', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Marid', '11', 'stampede', '520', '1705', '30', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Marid', '11', 'barrier_tusk', '518', '1703', '40', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Marid', '11', 'proboscis_shower', '523', '1708', '50', '1500');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Cerberus', '12', 'lava_spit', '529', '1785', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Cerberus', '12', 'sulfurous_breath', '530', '1786', '10', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Cerberus', '12', 'ululation', '531', '1788', '30', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Cerberus', '12', 'magma_hoplon', '532', '1789', '50', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Cerberus', '12', 'gates_of_hades', '533', '1790', '60', '2500');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Gnole', '13', 'asuran_claws', '580', '2176', '1', '1800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Gnole', '13', 'fevered_pitch', '576', '2170', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Gnole', '13', 'nox_blast', '579', '2175', '10', '1500');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Funguar', '15', 'frogkick', '300', '308', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Funguar', '15', 'spore', '301', '309', '10', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Funguar', '15', 'queasyshroom', '302', '310', '20', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Funguar', '15', 'numbshroom', '303', '311', '30', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Funguar', '15', 'shakeshroom', '304', '312', '40', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Funguar', '15', 'silence_gas', '305', '314', '50', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Funguar', '15', 'dark_spore', '306', '315', '60', '1200');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Treant Sapling', '16', 'sprout_smack', '458', '687', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Treant Sapling', '16', 'sprout_spin', '456', '685', '10', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Treant Sapling', '16', 'slumber_powder', '457', '686', '20', '1000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Morbol', '17', 'impale', '307', '725', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Morbol', '17', 'impale', '307', '316', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Morbol', '17', 'vampiric_lash', '308', '317', '10', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Morbol', '17', 'sweet_breath', '311', '728', '20', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Morbol', '17', 'sweet_breath', '311', '320', '20', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Morbol', '17', 'bad_breath', '310', '727', '30', '2000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Morbol', '17', 'bad_breath', '310', '319', '30', '2000');

INSERT INTO `monstrosity_tp_skills` VALUES ('Mandragora', '18', 'head_butt', '294', '300', '50', '1000');
INSERT INTO `monstrosity_tp_skills` VALUES ('Mandragora', '18', 'dream_flower', '295', '301', '40', '1200');
INSERT INTO `monstrosity_tp_skills` VALUES ('Mandragora', '18', 'wild_oats', '296', '302', '1', '500');
INSERT INTO `monstrosity_tp_skills` VALUES ('Mandragora', '18', 'photosynthesis', '297', '304', '20', '1500');
INSERT INTO `monstrosity_tp_skills` VALUES ('Mandragora', '18', 'leaf_dagger', '298', '305', '30', '800');
INSERT INTO `monstrosity_tp_skills` VALUES ('Mandragora', '18', 'scream', '299', '306', '10', '500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Mandragora', '18', 'demonic_flower', '603', '2410', '60', '1000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Sabotender', '19', 'needleshot', '312', '321', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Sabotender', '19', 'photosynthesis', '315', '324', '10', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Sabotender', '19', 'photosynthesis', '315', '304', '10', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Sabotender', '19', '1000_needles', '313', '322', '20', '1300');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Flytrap', '20', 'gloeosuccus', '389', '436', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Flytrap', '20', 'palsy_pollen', '388', '435', '10', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Flytrap', '20', 'soporific', '387', '434', '20', '1500');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Goobbue', '21', 'beatdown', '437', '583', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Goobbue', '21', 'uppercut', '438', '3356', '10', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Goobbue', '21', 'uppercut', '438', '584', '10', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Goobbue', '21', 'blow', '436', '3355', '20', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Goobbue', '21', 'blow', '436', '581', '20', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Goobbue', '21', 'blank_gaze', '439', '586', '30', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Goobbue', '21', 'blank_gaze', '439', '3358', '30', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Goobbue', '21', 'antiphase', '440', '587', '40', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Goobbue', '21', 'antiphase', '440', '3357', '40', '1000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Rafflesia', '22', 'seedspray', '572', '2163', '10', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Rafflesia', '22', 'bloody_caress', '575', '2167', '30', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Rafflesia', '22', 'viscid_emission', '573', '2164', '40', '1500');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Panopt', '23', 'retinal_glare', '678', '3030', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Panopt', '23', 'sylvan_slumber', '679', '3031', '10', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Panopt', '23', 'crushing_gaze', '680', '3032', '20', '1000');

INSERT INTO `monstrosity_tp_skills` VALUES ('Bee', '27', 'sharp_sting', '319', '334', '1', '1000');
INSERT INTO `monstrosity_tp_skills` VALUES ('Bee', '27', 'pollen', '320', '335', '10', '1500');
INSERT INTO `monstrosity_tp_skills` VALUES ('Bee', '27', 'final_sting', '321', '336', '20', '2000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Beetle', '28', 'power_attack', '322', '666', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Beetle', '28', 'spoil', '326', '343', '10', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Beetle', '28', 'hi-freq_field', '323', '339', '20', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Beetle', '28', 'rhino_guard', '325', '341', '30', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Beetle', '28', 'rhino_attack', '324', '340', '40', '1200');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Crawler', '29', 'sticky_thread', '327', '344', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Crawler', '29', 'cocoon', '329', '346', '10', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Crawler', '29', 'poison_breath', '328', '345', '20', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Crawler', '29', 'poison_breath', '328', '466', '20', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Crawler', '29', 'poison_breath', '328', '643', '20', '1200');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Fly', '30', 'venom', '454', '660', '1', '700');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Fly', '30', 'cursed_sphere', '453', '659', '10', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Fly', '30', 'somersault', '309', '318', '20', '1300');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Scorpion', '31', 'mandible_bite', '332', '350', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Scorpion', '31', 'sharp_strike', '337', '356', '1', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Scorpion', '31', 'poison_sting', '333', '351', '10', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Scorpion', '31', 'cold_breath', '331', '349', '20', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Scorpion', '31', 'earth_pounder', '336', '355', '30', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Scorpion', '31', 'wild_rage', '335', '354', '40', '1300');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Scorpion', '31', 'death_scissors', '334', '353', '50', '2000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Scorpion', '31', 'numbing_breath', '330', '348', '50', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Scorpion', '31', 'critical_bite', '460', '719', '60', '1300');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Scorpion', '31', 'venom_breath', '459', '717', '60', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Scorpion', '31', 'evasion', '465', '724', '70', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Scorpion', '31', 'venom_storm', '463', '722', '70', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Scorpion', '31', 'stasis', '462', '721', '80', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Scorpion', '31', 'venom_sting', '461', '720', '80', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Scorpion', '31', 'earthbreaker', '464', '723', '90', '1500');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Spider', '32', 'acid_spray', '480', '811', '1', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Spider', '32', 'spider_web', '481', '812', '10', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Spider', '32', 'sickle_slash', '479', '1446', '20', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Spider', '32', 'sickle_slash', '479', '810', '20', '1200');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Antlion', '33', 'venom_spray', '275', '277', '20', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Antlion', '33', 'mandibular_bite', '276', '279', '30', '1200');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Diremite', '34', 'double_claw', '338', '362', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Diremite', '34', 'grapple', '339', '363', '10', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Diremite', '34', 'filamented_hold', '340', '364', '20', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Diremite', '34', 'spinning_top', '341', '365', '30', '1200');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Wamouracampa (Wamoura larva)', '36', 'amber_scutum', '536', '1815', '1', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Wamouracampa (Wamoura larva)', '36', 'heat_barrier', '540', '1819', '10', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Wamouracampa (Wamoura larva)', '36', 'vitriolic_spray', '537', '1816', '20', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Wamouracampa (Wamoura larva)', '36', 'cannonball', '539', '1818', '20', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Wamouracampa (Wamoura larva)', '36', 'thermal_pulse', '538', '1817', '30', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Wamouracampa (Wamoura larva)', '36', 'vitriolic_shower', '541', '1820', '40', '1500');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Ladybug', '37', 'sudden_lunge', '582', '2178', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Ladybug', '37', 'noisome_powder', '583', '2179', '10', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Ladybug', '37', 'spiral_spin', '585', '2181', '20', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Ladybug', '37', 'nepenthean_hum', '584', '2180', '30', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Ladybug', '37', 'spiral_burst', '586', '2182', '40', '1200');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Gnat', '38', 'insipid_nip', '567', '2158', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Gnat', '38', 'bombilation', '569', '2160', '10', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Gnat', '38', 'cimicine_discharge', '570', '2161', '20', '1500');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Twitherym', '41', 'slice_n_dice', '671', '2951', '10', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Twitherym', '41', 'blackout', '672', '2952', '20', '1000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Chapuli', '42', 'tegmina_buffet', '667', '2947', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Chapuli', '42', 'sensilla_blades', '666', '2946', '10', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Chapuli', '42', 'sanguinary_slash', '668', '2948', '20', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Chapuli', '42', 'orthopterror', '669', '2949', '40', '1000');

INSERT INTO `monstrosity_tp_skills` VALUES ('Lizard', '43', 'tail_blow', '342', '366', '70', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Lizard', '43', 'fireball', '343', '367', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Lizard', '43', 'blockhead', '344', '368', '30', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Lizard', '43', 'brain_crush', '345', '369', '20', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Lizard', '43', 'baleful_gaze', '346', '370', '40', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Lizard', '43', 'infrasonics', '348', '372', '60', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Lizard', '43', 'secretion', '349', '373', '10', '500');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Raptor', '44', 'ripper_fang', '350', '374', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Raptor', '44', 'chomp_rush', '354', '379', '10', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Raptor', '44', 'scythe_tail', '355', '380', '20', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Raptor', '44', 'thunderbolt', '353', '629', '30', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Raptor', '44', 'frost_breath', '352', '377', '40', '1500');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Adamantoise', '45', 'head_butt', '474', '300', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Adamantoise', '45', 'head_butt', '474', '1076', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Adamantoise', '45', 'head_butt', '474', '3354', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Adamantoise', '45', 'head_butt', '474', '612', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Adamantoise', '45', 'tortoise_stomp', '475', '806', '10', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Adamantoise', '45', 'harden_shell', '476', '807', '20', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Adamantoise', '45', 'tortoise_song', '473', '804', '30', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Adamantoise', '45', 'earth_breath', '477', '808', '40', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Adamantoise', '45', 'aqua_breath', '478', '809', '50', '1000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Bugard', '46', 'scutum', '358', '384', '1', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Bugard', '46', 'tusk', '357', '383', '10', '2000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Bugard', '46', 'tail_roll', '356', '382', '20', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Bugard', '46', 'awful_eye', '360', '386', '30', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Bugard', '46', 'heavy_bellow', '361', '387', '40', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Bugard', '46', 'bone_crunch', '359', '385', '50', '1000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Eft', '47', 'toxic_spit', '426', '515', '1', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Eft', '47', 'nimble_snap', '429', '518', '10', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Eft', '47', 'numbing_noise', '428', '517', '20', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Eft', '47', 'cyclotail', '430', '519', '30', '1300');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Eft', '47', 'geist_wall', '427', '516', '40', '1200');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Wivre', '48', 'granite_skin', '560', '2103', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Wivre', '48', 'demoralizing_roar', '558', '2101', '10', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Wivre', '48', 'batterhorn', '557', '2099', '20', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Wivre', '48', 'boiling_blood', '559', '2102', '30', '1500');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Peiste', '49', 'torpefying_charge', '565', '2155', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Peiste', '49', 'delta_thrust', '564', '2154', '10', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Peiste', '49', 'regurgitation', '563', '2153', '20', '1300');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Peiste', '49', 'aqua_fortis', '562', '2152', '30', '1300');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Slime', '52', 'fluid_toss', '385', '432', '1', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Slime', '52', 'fluid_spread', '384', '431', '10', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Slime', '52', 'digest', '386', '433', '10', '1000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Hecteyes', '53', 'death_ray', '390', '437', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Hecteyes', '53', 'hex_eye', '391', '438', '10', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Hecteyes', '53', 'petro_gaze', '392', '439', '20', '1300');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Hecteyes', '53', 'catharsis', '393', '440', '30', '1000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Flan', '54', 'amplification', '542', '1821', '1', '1300');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Flan', '54', 'boiling_point', '543', '1822', '10', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Flan', '54', 'amorphic_spikes', '545', '1824', '30', '1000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Slug', '56', 'purulent_ooze', '588', '2184', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Slug', '56', 'fuscous_ooze', '587', '2183', '10', '2000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Slug', '56', 'corrosive_ooze', '589', '2185', '20', '1500');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Sandworm', '57', 'dustvoid', '591', '2187', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Sandworm', '57', 'slaverous_gale', '592', '2188', '10', '2000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Sandworm', '57', 'aeolian_void', '593', '2189', '20', '1800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Sandworm', '57', 'desiccation', '595', '2191', '90', '3000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Leech', '58', 'suction', '376', '414', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Leech', '58', 'random_kiss', '316', '325', '10', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Leech', '58', 'sand_breath', '378', '416', '20', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Leech', '58', 'acid_mist', '377', '415', '30', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Leech', '58', 'regeneration', '380', '418', '40', '600');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Leech', '58', 'regeneration', '380', '461', '40', '600');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Leech', '58', 'regeneration', '380', '3548', '40', '600');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Leech', '58', 'mp_drainkiss', '382', '421', '50', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Leech', '58', 'drainkiss', '379', '417', '50', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Leech', '58', 'tp_drainkiss', '381', '420', '50', '700');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Leech', '58', 'brain_drain', '383', '423', '60', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Leech', '58', 'absorbing_kiss', '317', '326', '70', '2000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Leech', '58', 'deep_kiss', '318', '327', '80', '1800');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Acuex', '59', 'foul_waters', '674', '2974', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Acuex', '59', 'pestilent_plume', '675', '2975', '10', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Acuex', '59', 'deadening_haze', '676', '2976', '20', '1000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Crab', '60', 'big_scissors', '396', '444', '1', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Crab', '60', 'bubble_curtain', '395', '443', '10', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Crab', '60', 'bubble_shower', '394', '442', '20', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Crab', '60', 'scissor_guard', '397', '445', '30', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Crab', '60', 'metallic_body', '398', '448', '40', '800');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Pugil', '61', 'intimidate', '399', '449', '1', '750');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Pugil', '61', 'aqua_ball', '400', '450', '10', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Pugil', '61', 'splash_breath', '401', '451', '20', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Pugil', '61', 'screwdriver', '402', '452', '30', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Pugil', '61', 'water_wall', '403', '453', '40', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Pugil', '61', 'water_shield', '404', '454', '50', '800');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Sea Monk', '62', 'tentacle', '405', '456', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Sea Monk', '62', 'ink_jet', '406', '458', '10', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Sea Monk', '62', 'hard_membrane', '407', '3547', '20', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Sea Monk', '62', 'hard_membrane', '407', '459', '20', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Sea Monk', '62', 'cross_attack', '408', '460', '30', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Sea Monk', '62', 'regeneration', '409', '461', '40', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Sea Monk', '62', 'regeneration', '409', '3548', '40', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Sea Monk', '62', 'regeneration', '409', '418', '40', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Sea Monk', '62', 'whirlwind', '411', '463', '50', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Sea Monk', '62', 'maelstrom', '410', '462', '60', '1200');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Uragnite', '63', 'gas_shell', '421', '1571', '1', '600');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Uragnite', '63', 'painful_whip', '424', '1574', '10', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Uragnite', '63', 'suctorial_tentacle', '425', '1575', '20', '600');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Uragnite', '63', 'palsynyxis', '423', '1573', '30', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Uragnite', '63', 'venom_shell', '422', '1572', '40', '1200');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Orobon', '64', 'hypnic_lamp', '511', '1695', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Orobon', '64', 'seaspray', '513', '1697', '10', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Orobon', '64', 'seismic_tail', '512', '1696', '30', '2000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Orobon', '64', 'vile_belch', '510', '1694', '40', '1500');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Ruszor', '65', 'severing_fang', '609', '2435', '1', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Ruszor', '65', 'aqua_blast', '610', '2437', '10', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Ruszor', '65', 'frozen_mist', '611', '2438', '30', '3000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Ruszor', '65', 'hydro_wave', '612', '2439', '40', '2500');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Bird', '69', 'helldive', '442', '622', '1', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Bird', '69', 'wing_cutter', '443', '623', '10', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Bird', '69', 'damnation_dive', '490', '1445', '40', '1500');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Cockatrice', '70', 'sound_vacuum', '373', '408', '1', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Cockatrice', '70', 'sound_vacuum', '373', '429', '1', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Cockatrice', '70', 'sound_blast', '374', '410', '10', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Cockatrice', '70', 'baleful_gaze', '375', '411', '20', '1300');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Cockatrice', '70', 'baleful_gaze', '375', '370', '20', '1300');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Cockatrice', '70', 'hammer_beak', '371', '406', '30', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Cockatrice', '70', 'poison_pick', '372', '407', '40', '1000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Roc', '71', 'blind_vortex', '366', '922', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Roc', '71', 'giga_scream', '367', '923', '10', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Roc', '71', 'dread_dive', '368', '924', '20', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Roc', '71', 'feather_barrier', '369', '402', '30', '500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Roc', '71', 'stormwind', '370', '403', '40', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Roc', '71', 'stormwind', '370', '926', '40', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Bat', '72', 'ultrasonics', '362', '392', '1', '750');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Bat', '72', 'blood_drain', '364', '394', '10', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Bat', '72', 'subsonics', '484', '1155', '20', '750');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Bat', '72', 'marrow_drain', '485', '1156', '30', '1000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Hippogryph', '73', 'back_heel', '431', '576', '1', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Hippogryph', '73', 'nihility_song', '433', '578', '30', '1300');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Hippogryph', '73', 'jettatura', '432', '2828', '40', '2000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Hippogryph', '73', 'hoof_volley', '494', '1330', '50', '2000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Apkallu', '74', 'yawn', '524', '1713', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Apkallu', '74', 'beak_lunge', '526', '1715', '10', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Apkallu', '74', 'frigid_shuffle', '527', '1716', '20', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Apkallu', '74', 'wing_slap', '525', '1714', '30', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Apkallu', '74', 'wing_whirl', '528', '1717', '40', '1500');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Colibri', '75', 'snatch_morsel', '516', '1700', '1', '600');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Colibri', '75', 'pecking_flurry', '515', '1699', '10', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Colibri', '75', 'feather_tickle', '517', '1701', '20', '1000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Amphiptere', '76', 'storm_wing', '607', '2432', '1', '1300');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Amphiptere', '76', 'bloody_beak', '604', '2428', '10', '1300');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Amphiptere', '76', 'reaving_wind', '606', '2431', '20', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Amphiptere', '76', 'calamitous_wind', '608', '2433', '30', '1700');

INSERT INTO `monstrosity_tp_skills` VALUES ('Onyx Rabbit', '256', 'foot_kick', '257', '257', '1', '1000');
INSERT INTO `monstrosity_tp_skills` VALUES ('Onyx Rabbit', '256', 'dust_cloud', '258', '258', '10', '800');
INSERT INTO `monstrosity_tp_skills` VALUES ('Onyx Rabbit', '256', 'whirl_claws', '259', '259', '20', '1800');
INSERT INTO `monstrosity_tp_skills` VALUES ('Onyx Rabbit', '256', 'wild_carrot', '314', '323', '30', '1000');

INSERT INTO `monstrosity_tp_skills` VALUES ('Alabaster Rabbit', '257', 'foot_kick', '257', '257', '1', '1000');
INSERT INTO `monstrosity_tp_skills` VALUES ('Alabaster Rabbit', '257', 'whirl_claws', '259', '259', '20', '1800');
INSERT INTO `monstrosity_tp_skills` VALUES ('Alabaster Rabbit', '257', 'wild_carrot', '314', '323', '30', '1000');
INSERT INTO `monstrosity_tp_skills` VALUES ('Alabaster Rabbit', '257', 'snow_cloud', '455', '661', '40', '1000');
INSERT INTO `monstrosity_tp_skills` VALUES ('Alabaster Rabbit', '257', 'wild_ginseng', '501', '1362', '50', '1000');

INSERT INTO `monstrosity_tp_skills` VALUES ('Lapinion (Rabbit)', '258', 'foot_kick', '257', '257', '1', '1000');
INSERT INTO `monstrosity_tp_skills` VALUES ('Lapinion (Rabbit)', '258', 'dust_cloud', '258', '258', '10', '800');
INSERT INTO `monstrosity_tp_skills` VALUES ('Lapinion (Rabbit)', '258', 'whirl_claws', '259', '259', '20', '1800');
INSERT INTO `monstrosity_tp_skills` VALUES ('Lapinion (Rabbit)', '258', 'wild_carrot', '314', '323', '30', '1000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Elasmoth (Behemoth)', '259', 'wild_horn', '444', '628', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Elasmoth (Behemoth)', '259', 'shock_wave', '446', '631', '10', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Elasmoth (Behemoth)', '259', 'flame_armor', '447', '632', '20', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Elasmoth (Behemoth)', '259', 'howl', '448', '1079', '30', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Elasmoth (Behemoth)', '259', 'howl', '448', '762', '30', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Elasmoth (Behemoth)', '259', 'howl', '448', '633', '30', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Elasmoth (Behemoth)', '259', 'howl', '448', '764', '30', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Elasmoth (Behemoth)', '259', 'howl', '448', '766', '30', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Elasmoth (Behemoth)', '259', 'thunderbolt', '445', '629', '40', '2000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Legendary Tiger', '261', 'razor_fang', '271', '271', '1', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Legendary Tiger', '261', 'razor_fang', '271', '3849', '1', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Legendary Tiger', '261', 'claw_cyclone', '272', '273', '10', '1800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Legendary Tiger', '261', 'roar', '270', '270', '20', '1000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Smilodon (Tiger)', '262', 'razor_fang', '271', '271', '1', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Smilodon (Tiger)', '262', 'razor_fang', '271', '3849', '1', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Smilodon (Tiger)', '262', 'claw_cyclone', '272', '273', '10', '1800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Smilodon (Tiger)', '262', 'roar', '270', '270', '20', '1000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Karakul (Sheep)', '263', 'sheep_charge', '262', '262', '1', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Karakul (Sheep)', '263', 'rage', '261', '3858', '10', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Karakul (Sheep)', '263', 'rage', '261', '265', '10', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Karakul (Sheep)', '263', 'rage', '261', '261', '10', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Karakul (Sheep)', '263', 'sheep_song', '264', '264', '20', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Karakul (Sheep)', '263', 'lamb_chop', '260', '260', '30', '1300');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Karakul (Sheep)', '263', 'feeble_bleat', '548', '1837', '50', '1000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Lucerewe (Sheep)', '264', 'sheep_charge', '262', '262', '1', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Lucerewe (Sheep)', '264', 'rage', '261', '261', '10', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Lucerewe (Sheep)', '264', 'rage', '261', '3858', '10', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Lucerewe (Sheep)', '264', 'rage', '261', '265', '10', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Lucerewe (Sheep)', '264', 'sheep_song', '264', '264', '20', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Lucerewe (Sheep)', '264', 'lamb_chop', '260', '260', '30', '1300');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Lucerewe (Sheep)', '264', 'feeble_bleat', '548', '1837', '50', '1000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Ovim (Sheep)', '265', 'ram_charge', '266', '266', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Ovim (Sheep)', '265', 'rage', '265', '3858', '10', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Ovim (Sheep)', '265', 'rage', '265', '265', '10', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Ovim (Sheep)', '265', 'rage', '265', '261', '10', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Ovim (Sheep)', '265', 'rumble', '267', '267', '20', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Ovim (Sheep)', '265', 'petribreath', '269', '269', '40', '2000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Lynx (Coeurl)', '266', 'frenzied_rage', '413', '1336', '1', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Lynx (Coeurl)', '266', 'pounce', '414', '482', '10', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Lynx (Coeurl)', '266', 'chaotic_eye', '452', '653', '20', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Lynx (Coeurl)', '266', 'blaster', '451', '652', '30', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Lynx (Coeurl)', '266', 'charged_whisker', '415', '483', '50', '1500');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Collared Lynx (Coeurl)', '267', 'frenzied_rage', '413', '1336', '1', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Collared Lynx (Coeurl)', '267', 'pounce', '414', '482', '10', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Collared Lynx (Coeurl)', '267', 'chaotic_eye', '452', '653', '20', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Collared Lynx (Coeurl)', '267', 'blaster', '451', '652', '30', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Collared Lynx (Coeurl)', '267', 'charged_whisker', '415', '483', '50', '1500');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Legendary Manticore', '268', 'tail_swing', '467', '798', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Legendary Manticore', '268', 'tail_smash', '468', '799', '10', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Legendary Manticore', '268', 'riddle', '470', '801', '20', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Legendary Manticore', '268', 'heat_breath', '469', '800', '30', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Legendary Manticore', '268', 'great_sandstorm', '471', '802', '40', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Legendary Manticore', '268', 'great_whirlwind', '472', '803', '50', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Legendary Manticore', '268', 'deadly_hold', '466', '797', '60', '1000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Orthrus (Cerberus)', '269', 'lava_spit', '529', '1785', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Orthrus (Cerberus)', '269', 'sulfurous_breath', '530', '1786', '10', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Orthrus (Cerberus)', '269', 'ululation', '531', '1788', '30', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Orthrus (Cerberus)', '269', 'magma_hoplon', '532', '1789', '50', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Orthrus (Cerberus)', '269', 'gates_of_hades', '533', '1790', '60', '2500');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Bipedal Gnole', '270', 'asuran_claws', '580', '2176', '1', '1800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Bipedal Gnole', '270', 'nox_blast', '579', '2175', '10', '1500');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Coppercap (Funguar)', '271', 'frogkick', '300', '308', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Coppercap (Funguar)', '271', 'spore', '301', '309', '10', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Coppercap (Funguar)', '271', 'queasyshroom', '302', '310', '20', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Coppercap (Funguar)', '271', 'numbshroom', '303', '311', '30', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Coppercap (Funguar)', '271', 'shakeshroom', '304', '312', '40', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Coppercap (Funguar)', '271', 'silence_gas', '305', '314', '50', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Coppercap (Funguar)', '271', 'dark_spore', '306', '315', '60', '1200');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Treant', '272', 'entangle', '293', '332', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Treant', '272', 'drill_branch', '290', '328', '10', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Treant', '272', 'pinecone_bomb', '291', '329', '20', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Treant', '272', 'leafstorm', '292', '331', '30', '1000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Flowering Treant', '273', 'entangle', '293', '332', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Flowering Treant', '273', 'drill_branch', '290', '328', '10', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Flowering Treant', '273', 'pinecone_bomb', '291', '329', '20', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Flowering Treant', '273', 'leafstorm', '292', '331', '30', '1000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Scarlet-tinged Treant', '274', 'entangle', '293', '332', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Scarlet-tinged Treant', '274', 'drill_branch', '290', '328', '10', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Scarlet-tinged Treant', '274', 'pinecone_bomb', '291', '329', '20', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Scarlet-tinged Treant', '274', 'leafstorm', '292', '331', '30', '1000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Barren Treant', '275', 'entangle', '293', '332', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Barren Treant', '275', 'drill_branch', '290', '328', '10', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Barren Treant', '275', 'pinecone_bomb', '291', '329', '20', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Barren Treant', '275', 'leafstorm', '292', '331', '30', '1000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Necklaced Treant', '276', 'entangle', '293', '332', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Necklaced Treant', '276', 'drill_branch', '290', '328', '10', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Necklaced Treant', '276', 'pinecone_bomb', '291', '329', '20', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Necklaced Treant', '276', 'leafstorm', '292', '331', '30', '1000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Pygmy Morbol', '277', 'impale', '307', '725', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Pygmy Morbol', '277', 'impale', '307', '316', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Pygmy Morbol', '277', 'vampiric_lash', '308', '317', '10', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Pygmy Morbol', '277', 'sweet_breath', '311', '728', '20', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Pygmy Morbol', '277', 'sweet_breath', '311', '320', '20', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Pygmy Morbol', '277', 'bad_breath', '310', '727', '30', '2000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Pygmy Morbol', '277', 'bad_breath', '310', '319', '30', '2000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Scarce Morbol', '278', 'impale', '307', '725', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Scarce Morbol', '278', 'impale', '307', '316', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Scarce Morbol', '278', 'vampiric_lash', '308', '317', '10', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Scarce Morbol', '278', 'sweet_breath', '311', '320', '20', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Scarce Morbol', '278', 'sweet_breath', '311', '728', '20', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Scarce Morbol', '278', 'bad_breath', '310', '319', '30', '2000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Scarce Morbol', '278', 'bad_breath', '310', '727', '30', '2000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Ameretat (Morbol)', '279', 'impale', '307', '725', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Ameretat (Morbol)', '279', 'impale', '307', '316', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Ameretat (Morbol)', '279', 'vampiric_lash', '308', '317', '10', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Ameretat (Morbol)', '279', 'sweet_breath', '311', '728', '20', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Ameretat (Morbol)', '279', 'sweet_breath', '311', '320', '20', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Ameretat (Morbol)', '279', 'bad_breath', '310', '727', '30', '2000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Ameretat (Morbol)', '279', 'bad_breath', '310', '319', '30', '2000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Ameretat (Morbol)', '279', 'vampiric_root', '535', '1793', '70', '1500');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Purbol (Morbol)', '280', 'impale', '307', '725', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Purbol (Morbol)', '280', 'impale', '307', '316', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Purbol (Morbol)', '280', 'vampiric_lash', '308', '317', '10', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Purbol (Morbol)', '280', 'sweet_breath', '311', '728', '20', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Purbol (Morbol)', '280', 'sweet_breath', '311', '320', '20', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Purbol (Morbol)', '280', 'bad_breath', '310', '319', '30', '2000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Purbol (Morbol)', '280', 'bad_breath', '310', '727', '30', '2000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Korrigan (Mandragora)', '281', 'wild_oats', '296', '3351', '1', '500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Korrigan (Mandragora)', '281', 'wild_oats', '296', '302', '1', '500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Korrigan (Mandragora)', '281', 'scream', '299', '306', '10', '500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Korrigan (Mandragora)', '281', 'photosynthesis', '297', '324', '20', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Korrigan (Mandragora)', '281', 'photosynthesis', '297', '304', '20', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Korrigan (Mandragora)', '281', 'leaf_dagger', '298', '305', '30', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Korrigan (Mandragora)', '281', 'dream_flower', '295', '301', '40', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Korrigan (Mandragora)', '281', 'head_butt', '294', '300', '50', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Korrigan (Mandragora)', '281', 'head_butt', '294', '3354', '50', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Korrigan (Mandragora)', '281', 'head_butt', '294', '1076', '50', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Korrigan (Mandragora)', '281', 'head_butt', '294', '612', '50', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Korrigan (Mandragora)', '281', 'demonic_flower', '603', '2410', '60', '1000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Lycopodium (Mandragora)', '282', 'wild_oats', '296', '302', '1', '500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Lycopodium (Mandragora)', '282', 'wild_oats', '296', '3351', '1', '500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Lycopodium (Mandragora)', '282', 'scream', '299', '306', '10', '500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Lycopodium (Mandragora)', '282', 'photosynthesis', '297', '304', '20', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Lycopodium (Mandragora)', '282', 'photosynthesis', '297', '324', '20', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Lycopodium (Mandragora)', '282', 'leaf_dagger', '298', '305', '30', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Lycopodium (Mandragora)', '282', 'dream_flower', '295', '301', '40', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Lycopodium (Mandragora)', '282', 'head_butt', '294', '612', '50', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Lycopodium (Mandragora)', '282', 'head_butt', '294', '300', '50', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Lycopodium (Mandragora)', '282', 'head_butt', '294', '3354', '50', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Lycopodium (Mandragora)', '282', 'head_butt', '294', '1076', '50', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Lycopodium (Mandragora)', '282', 'demonic_flower', '603', '2410', '60', '1000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Pygmy Mandragora', '283', 'wild_oats', '296', '302', '1', '500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Pygmy Mandragora', '283', 'wild_oats', '296', '3351', '1', '500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Pygmy Mandragora', '283', 'scream', '299', '306', '10', '500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Pygmy Mandragora', '283', 'photosynthesis', '297', '324', '20', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Pygmy Mandragora', '283', 'photosynthesis', '297', '304', '20', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Pygmy Mandragora', '283', 'leaf_dagger', '298', '305', '30', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Pygmy Mandragora', '283', 'dream_flower', '295', '301', '40', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Pygmy Mandragora', '283', 'head_butt', '294', '300', '50', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Pygmy Mandragora', '283', 'head_butt', '294', '3354', '50', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Pygmy Mandragora', '283', 'head_butt', '294', '1076', '50', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Pygmy Mandragora', '283', 'head_butt', '294', '612', '50', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Pygmy Mandragora', '283', 'demonic_flower', '603', '2410', '60', '1000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Adenium (Mandragora)', '284', 'wild_oats', '296', '3351', '1', '500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Adenium (Mandragora)', '284', 'wild_oats', '296', '302', '1', '500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Adenium (Mandragora)', '284', 'scream', '299', '306', '10', '500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Adenium (Mandragora)', '284', 'photosynthesis', '297', '324', '20', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Adenium (Mandragora)', '284', 'photosynthesis', '297', '304', '20', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Adenium (Mandragora)', '284', 'leaf_dagger', '298', '305', '30', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Adenium (Mandragora)', '284', 'dream_flower', '295', '301', '40', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Adenium (Mandragora)', '284', 'head_butt', '294', '3354', '50', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Adenium (Mandragora)', '284', 'head_butt', '294', '1076', '50', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Adenium (Mandragora)', '284', 'head_butt', '294', '612', '50', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Adenium (Mandragora)', '284', 'head_butt', '294', '300', '50', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Adenium (Mandragora)', '284', 'petal_pirouette', '599', '2210', '60', '1300');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Adenium (Mandragora)', '284', 'demonic_flower', '603', '2410', '60', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Adenium (Mandragora)', '284', 'petal_pirouette', '599', '3353', '60', '1300');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Pachypodium (Mandragora)', '285', 'wild_oats', '296', '302', '1', '500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Pachypodium (Mandragora)', '285', 'wild_oats', '296', '3351', '1', '500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Pachypodium (Mandragora)', '285', 'scream', '299', '306', '10', '500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Pachypodium (Mandragora)', '285', 'photosynthesis', '297', '304', '20', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Pachypodium (Mandragora)', '285', 'photosynthesis', '297', '324', '20', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Pachypodium (Mandragora)', '285', 'leaf_dagger', '298', '305', '30', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Pachypodium (Mandragora)', '285', 'dream_flower', '295', '301', '40', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Pachypodium (Mandragora)', '285', 'head_butt', '294', '612', '50', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Pachypodium (Mandragora)', '285', 'head_butt', '294', '300', '50', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Pachypodium (Mandragora)', '285', 'head_butt', '294', '3354', '50', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Pachypodium (Mandragora)', '285', 'head_butt', '294', '1076', '50', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Pachypodium (Mandragora)', '285', 'demonic_flower', '603', '2410', '60', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Pachypodium (Mandragora)', '285', 'petal_pirouette', '599', '3353', '60', '1300');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Pachypodium (Mandragora)', '285', 'petal_pirouette', '599', '2210', '60', '1300');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Enlightened Mandragora', '286', 'wild_oats', '296', '302', '1', '500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Enlightened Mandragora', '286', 'wild_oats', '296', '3351', '1', '500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Enlightened Mandragora', '286', 'scream', '299', '306', '10', '500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Enlightened Mandragora', '286', 'photosynthesis', '297', '324', '20', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Enlightened Mandragora', '286', 'photosynthesis', '297', '304', '20', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Enlightened Mandragora', '286', 'leaf_dagger', '298', '305', '30', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Enlightened Mandragora', '286', 'dream_flower', '295', '301', '40', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Enlightened Mandragora', '286', 'head_butt', '294', '300', '50', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Enlightened Mandragora', '286', 'head_butt', '294', '3354', '50', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Enlightened Mandragora', '286', 'head_butt', '294', '1076', '50', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Enlightened Mandragora', '286', 'head_butt', '294', '612', '50', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Enlightened Mandragora', '286', 'demonic_flower', '603', '2410', '60', '1000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('New Year Mandragora', '287', 'wild_oats', '296', '3351', '1', '500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('New Year Mandragora', '287', 'wild_oats', '296', '302', '1', '500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('New Year Mandragora', '287', 'scream', '299', '306', '10', '500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('New Year Mandragora', '287', 'photosynthesis', '297', '324', '20', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('New Year Mandragora', '287', 'photosynthesis', '297', '304', '20', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('New Year Mandragora', '287', 'leaf_dagger', '298', '305', '30', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('New Year Mandragora', '287', 'dream_flower', '295', '301', '40', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('New Year Mandragora', '287', 'head_butt', '294', '612', '50', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('New Year Mandragora', '287', 'head_butt', '294', '300', '50', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('New Year Mandragora', '287', 'head_butt', '294', '3354', '50', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('New Year Mandragora', '287', 'head_butt', '294', '1076', '50', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('New Year Mandragora', '287', 'demonic_flower', '603', '2410', '60', '1000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Sabotender Florido', '288', 'needleshot', '312', '321', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Sabotender Florido', '288', 'photosynthesis', '315', '324', '10', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Sabotender Florido', '288', 'photosynthesis', '315', '304', '10', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Sabotender Florido', '288', '1000_needles', '313', '322', '20', '1300');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Mitrastema (Rafflesia)', '289', 'seedspray', '572', '2163', '10', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Mitrastema (Rafflesia)', '289', 'bloody_caress', '575', '2167', '30', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Mitrastema (Rafflesia)', '289', 'viscid_emission', '573', '2164', '40', '1500');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Vermilion and Onyx Bee', '290', 'sharp_sting', '319', '334', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Vermilion and Onyx Bee', '290', 'pollen', '320', '335', '10', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Vermilion and Onyx Bee', '290', 'final_sting', '321', '336', '20', '2000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Zaffre Bee', '291', 'sharp_sting', '319', '334', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Zaffre Bee', '291', 'pollen', '320', '335', '10', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Zaffre Bee', '291', 'final_sting', '321', '336', '20', '2000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Onyx Beetle', '292', 'power_attack', '322', '666', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Onyx Beetle', '292', 'spoil', '326', '343', '10', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Onyx Beetle', '292', 'hi-freq_field', '323', '339', '20', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Onyx Beetle', '292', 'rhino_guard', '325', '341', '30', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Onyx Beetle', '292', 'rhino_attack', '324', '340', '40', '1200');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Gamboge Beetle', '293', 'power_attack', '322', '666', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Gamboge Beetle', '293', 'spoil', '326', '343', '10', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Gamboge Beetle', '293', 'hi-freq_field', '323', '339', '20', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Gamboge Beetle', '293', 'rhino_guard', '325', '341', '30', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Gamboge Beetle', '293', 'rhino_attack', '324', '340', '40', '1200');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Eruca (Crawler)', '294', 'sticky_thread', '327', '344', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Eruca (Crawler)', '294', 'cocoon', '329', '346', '10', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Eruca (Crawler)', '294', 'incinerate', '534', '1791', '30', '1200');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Emerald Crawler', '295', 'sticky_thread', '327', '344', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Emerald Crawler', '295', 'cocoon', '329', '346', '10', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Emerald Crawler', '295', 'poison_breath', '328', '643', '20', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Emerald Crawler', '295', 'poison_breath', '328', '345', '20', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Emerald Crawler', '295', 'poison_breath', '328', '466', '20', '1200');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Pygmy Emerald Crawler', '296', 'sticky_thread', '327', '344', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Pygmy Emerald Crawler', '296', 'cocoon', '329', '346', '10', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Pygmy Emerald Crawler', '296', 'poison_breath', '328', '345', '20', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Pygmy Emerald Crawler', '296', 'poison_breath', '328', '466', '20', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Pygmy Emerald Crawler', '296', 'poison_breath', '328', '643', '20', '1200');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Vermilion Fly', '297', 'venom', '454', '660', '1', '700');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Vermilion Fly', '297', 'cursed_sphere', '453', '659', '10', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Vermilion Fly', '297', 'somersault', '309', '318', '20', '1300');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Scolopendrid (Scorpion)', '298', 'mandible_bite', '332', '350', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Scolopendrid (Scorpion)', '298', 'sharp_strike', '337', '356', '1', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Scolopendrid (Scorpion)', '298', 'poison_sting', '333', '351', '10', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Scolopendrid (Scorpion)', '298', 'cold_breath', '331', '349', '20', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Scolopendrid (Scorpion)', '298', 'earth_pounder', '336', '355', '30', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Scolopendrid (Scorpion)', '298', 'wild_rage', '335', '354', '40', '1300');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Scolopendrid (Scorpion)', '298', 'numbing_breath', '330', '348', '50', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Scolopendrid (Scorpion)', '298', 'death_scissors', '334', '353', '50', '2000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Scolopendrid (Scorpion)', '298', 'critical_bite', '460', '719', '60', '1300');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Scolopendrid (Scorpion)', '298', 'venom_breath', '459', '717', '60', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Scolopendrid (Scorpion)', '298', 'evasion', '465', '724', '70', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Scolopendrid (Scorpion)', '298', 'venom_storm', '463', '722', '70', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Scolopendrid (Scorpion)', '298', 'stasis', '462', '721', '80', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Scolopendrid (Scorpion)', '298', 'venom_sting', '461', '720', '80', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Scolopendrid (Scorpion)', '298', 'earthbreaker', '464', '723', '90', '1500');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Unusual Scolopendrid (Scorpion)', '299', 'sharp_strike', '337', '356', '1', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Unusual Scolopendrid (Scorpion)', '299', 'mandible_bite', '332', '350', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Unusual Scolopendrid (Scorpion)', '299', 'poison_sting', '333', '351', '10', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Unusual Scolopendrid (Scorpion)', '299', 'earth_pounder', '336', '355', '30', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Unusual Scolopendrid (Scorpion)', '299', 'wild_rage', '335', '354', '40', '1300');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Unusual Scolopendrid (Scorpion)', '299', 'death_scissors', '334', '353', '50', '2000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Unusual Scolopendrid (Scorpion)', '299', 'numbing_breath', '330', '348', '50', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Unusual Scolopendrid (Scorpion)', '299', 'critical_bite', '460', '719', '60', '1300');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Unusual Scolopendrid (Scorpion)', '299', 'venom_breath', '459', '717', '60', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Unusual Scolopendrid (Scorpion)', '299', 'evasion', '465', '724', '70', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Unusual Scolopendrid (Scorpion)', '299', 'venom_storm', '463', '722', '70', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Unusual Scolopendrid (Scorpion)', '299', 'stasis', '462', '721', '80', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Unusual Scolopendrid (Scorpion)', '299', 'venom_sting', '461', '720', '80', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Unusual Scolopendrid (Scorpion)', '299', 'earthbreaker', '464', '723', '90', '1500');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Reticulated Spider', '300', 'acid_spray', '480', '811', '1', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Reticulated Spider', '300', 'spider_web', '481', '812', '10', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Reticulated Spider', '300', 'sickle_slash', '479', '810', '20', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Reticulated Spider', '300', 'sickle_slash', '479', '1446', '20', '1200');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Vermilion and Onyx Spider', '301', 'acid_spray', '480', '811', '1', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Vermilion and Onyx Spider', '301', 'spider_web', '481', '812', '10', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Vermilion and Onyx Spider', '301', 'sickle_slash', '479', '1446', '20', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Vermilion and Onyx Spider', '301', 'sickle_slash', '479', '810', '20', '1200');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Onyx Antlion', '302', 'venom_spray', '275', '277', '20', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Onyx Antlion', '302', 'mandibular_bite', '276', '279', '30', '1200');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Formiceros (Antlion)', '303', 'venom_spray', '275', '277', '20', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Formiceros (Antlion)', '303', 'mandibular_bite', '276', '279', '30', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Formiceros (Antlion)', '303', 'quake_blast', '619', '2517', '50', '2000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Arundimite (Diremite)', '304', 'double_claw', '338', '362', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Arundimite (Diremite)', '304', 'grapple', '339', '363', '10', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Arundimite (Diremite)', '304', 'filamented_hold', '340', '364', '20', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Arundimite (Diremite)', '304', 'spinning_top', '341', '365', '30', '1200');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Coiled Wamouracampa (Wamoura larva)', '306', 'amber_scutum', '536', '1815', '1', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Coiled Wamouracampa (Wamoura larva)', '306', 'heat_barrier', '540', '1819', '10', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Coiled Wamouracampa (Wamoura larva)', '306', 'cannonball', '539', '1818', '20', '1000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Wamoura', '307', 'magma_fan', '550', '1951', '50', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Wamoura', '307', 'erratic_flutter', '551', '1952', '60', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Wamoura', '307', 'exuviation', '554', '1955', '70', '2000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Wamoura', '307', 'erosion_dust', '553', '1954', '80', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Wamoura', '307', 'proboscis', '552', '1953', '90', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Wamoura', '307', 'fire_break', '555', '1956', '95', '2000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Coral Wamoura', '308', 'magma_fan', '550', '1951', '50', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Coral Wamoura', '308', 'erratic_flutter', '551', '1952', '60', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Coral Wamoura', '308', 'exuviation', '554', '1955', '70', '2000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Coral Wamoura', '308', 'erosion_dust', '553', '1954', '80', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Coral Wamoura', '308', 'proboscis', '552', '1953', '90', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Coral Wamoura', '308', 'fire_break', '555', '1956', '95', '2000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Gold Ladybug', '309', 'sudden_lunge', '582', '2178', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Gold Ladybug', '309', 'noisome_powder', '583', '2179', '10', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Gold Ladybug', '309', 'spiral_spin', '585', '2181', '20', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Gold Ladybug', '309', 'nepenthean_hum', '584', '2180', '30', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Gold Ladybug', '309', 'spiral_burst', '586', '2182', '40', '1200');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Midge (Gnat)', '310', 'insipid_nip', '567', '2158', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Midge (Gnat)', '310', 'bombilation', '569', '2160', '10', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Midge (Gnat)', '310', 'cimicine_discharge', '570', '2161', '20', '1500');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Ashen Lizard', '315', 'snowball', '441', '621', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Ashen Lizard', '315', 'secretion', '349', '373', '10', '500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Ashen Lizard', '315', 'brain_crush', '345', '369', '20', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Ashen Lizard', '315', 'blockhead', '344', '368', '30', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Ashen Lizard', '315', 'baleful_gaze', '346', '411', '40', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Ashen Lizard', '315', 'baleful_gaze', '346', '370', '40', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Ashen Lizard', '315', 'infrasonics', '348', '372', '60', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Ashen Lizard', '315', 'tail_blow', '342', '366', '70', '1000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Emerald Raptor', '316', 'ripper_fang', '350', '374', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Emerald Raptor', '316', 'chomp_rush', '354', '379', '10', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Emerald Raptor', '316', 'scythe_tail', '355', '380', '20', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Emerald Raptor', '316', 'thunderbolt', '353', '629', '30', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Emerald Raptor', '316', 'foul_breath', '351', '376', '40', '1500');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Vermilion Raptor', '317', 'ripper_fang', '350', '374', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Vermilion Raptor', '317', 'chomp_rush', '354', '379', '10', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Vermilion Raptor', '317', 'scythe_tail', '355', '380', '20', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Vermilion Raptor', '317', 'thunderbolt', '353', '629', '30', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Vermilion Raptor', '317', 'foul_breath', '351', '376', '40', '1500');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Pygmy Adamantoise', '318', 'head_butt', '474', '300', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Pygmy Adamantoise', '318', 'head_butt', '474', '3354', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Pygmy Adamantoise', '318', 'head_butt', '474', '1076', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Pygmy Adamantoise', '318', 'head_butt', '474', '612', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Pygmy Adamantoise', '318', 'tortoise_stomp', '475', '806', '10', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Pygmy Adamantoise', '318', 'harden_shell', '476', '807', '20', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Pygmy Adamantoise', '318', 'tortoise_song', '473', '804', '30', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Pygmy Adamantoise', '318', 'earth_breath', '477', '808', '40', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Pygmy Adamantoise', '318', 'aqua_breath', '478', '809', '50', '1000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Legendary Adamantoise', '319', 'head_butt', '474', '300', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Legendary Adamantoise', '319', 'head_butt', '474', '3354', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Legendary Adamantoise', '319', 'head_butt', '474', '1076', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Legendary Adamantoise', '319', 'head_butt', '474', '612', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Legendary Adamantoise', '319', 'tortoise_stomp', '475', '806', '10', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Legendary Adamantoise', '319', 'harden_shell', '476', '807', '20', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Legendary Adamantoise', '319', 'tortoise_song', '473', '804', '30', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Legendary Adamantoise', '319', 'earth_breath', '477', '808', '40', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Legendary Adamantoise', '319', 'aqua_breath', '478', '809', '50', '1000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Ferromantoise (Adamantoise)', '320', 'head_butt', '474', '612', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Ferromantoise (Adamantoise)', '320', 'head_butt', '474', '300', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Ferromantoise (Adamantoise)', '320', 'head_butt', '474', '3354', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Ferromantoise (Adamantoise)', '320', 'head_butt', '474', '1076', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Ferromantoise (Adamantoise)', '320', 'tortoise_stomp', '475', '806', '10', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Ferromantoise (Adamantoise)', '320', 'harden_shell', '476', '807', '20', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Ferromantoise (Adamantoise)', '320', 'tortoise_song', '473', '804', '30', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Ferromantoise (Adamantoise)', '320', 'earth_breath', '477', '808', '40', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Ferromantoise (Adamantoise)', '320', 'aqua_breath', '478', '809', '50', '1000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Abyssobugard (Bugard)', '321', 'scutum', '358', '384', '1', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Abyssobugard (Bugard)', '321', 'tusk', '357', '383', '10', '2000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Abyssobugard (Bugard)', '321', 'tail_roll', '356', '382', '20', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Abyssobugard (Bugard)', '321', 'awful_eye', '360', '386', '30', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Abyssobugard (Bugard)', '321', 'heavy_bellow', '361', '387', '40', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Abyssobugard (Bugard)', '321', 'bone_crunch', '359', '385', '50', '1000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Tarichuk (Eft)', '322', 'toxic_spit', '426', '515', '1', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Tarichuk (Eft)', '322', 'nimble_snap', '429', '518', '10', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Tarichuk (Eft)', '322', 'numbing_noise', '428', '517', '20', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Tarichuk (Eft)', '322', 'cyclotail', '430', '519', '30', '1300');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Tarichuk (Eft)', '322', 'geist_wall', '427', '516', '40', '1200');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Unusual Wivre', '323', 'granite_skin', '560', '2103', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Unusual Wivre', '323', 'demoralizing_roar', '558', '2101', '10', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Unusual Wivre', '323', 'batterhorn', '557', '2099', '20', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Unusual Wivre', '323', 'boiling_blood', '559', '2102', '30', '1500');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Sibilus (Peiste)', '324', 'torpefying_charge', '565', '2155', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Sibilus (Peiste)', '324', 'delta_thrust', '564', '2154', '10', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Sibilus (Peiste)', '324', 'regurgitation', '563', '2153', '20', '1300');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Sibilus (Peiste)', '324', 'aqua_fortis', '562', '2152', '30', '1300');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Clot (Slime)', '329', 'fluid_toss', '385', '432', '1', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Clot (Slime)', '329', 'fluid_spread', '384', '431', '10', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Clot (Slime)', '329', 'digest', '386', '433', '10', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Clot (Slime)', '329', 'mucus_spread', '491', '1317', '20', '750');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Clot (Slime)', '329', 'epoxy_spread', '492', '1319', '30', '750');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Gold Slime', '330', 'fluid_toss', '385', '432', '1', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Gold Slime', '330', 'fluid_spread', '384', '431', '10', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Gold Slime', '330', 'digest', '386', '433', '10', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Gold Slime', '330', 'mucus_spread', '491', '1317', '20', '750');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Gold Slime', '330', 'epoxy_spread', '492', '1319', '30', '750');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Boil (Slime)', '331', 'fluid_toss', '621', '432', '1', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Boil (Slime)', '331', 'fluid_spread', '620', '431', '10', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Boil (Slime)', '331', 'mucus_spread', '623', '1317', '20', '750');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Boil (Slime)', '331', 'epoxy_spread', '624', '1319', '30', '750');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Boil (Slime)', '331', 'cytokinesis', '617', '2514', '40', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Boil (Slime)', '331', 'dissolve', '622', '2550', '50', '3000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Gold Flan', '332', 'amplification', '542', '1821', '1', '1300');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Gold Flan', '332', 'boiling_point', '543', '1822', '10', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Gold Flan', '332', 'amorphic_spikes', '545', '1824', '30', '1000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Blancmange (Flan)', '333', 'amplification', '542', '1821', '1', '1300');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Blancmange (Flan)', '333', 'boiling_point', '543', '1822', '10', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Blancmange (Flan)', '333', 'amorphic_spikes', '545', '1824', '30', '1000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Pygmy Sandworm', '334', 'dustvoid', '591', '2187', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Pygmy Sandworm', '334', 'slaverous_gale', '592', '2188', '10', '2000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Pygmy Sandworm', '334', 'aeolian_void', '593', '2189', '20', '1800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Pygmy Sandworm', '334', 'desiccation', '595', '2191', '90', '3000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Gigaworm (Sandworm)', '335', 'dustvoid', '591', '2187', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Gigaworm (Sandworm)', '335', 'slaverous_gale', '592', '2188', '10', '2000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Gigaworm (Sandworm)', '335', 'aeolian_void', '593', '2189', '20', '1800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Gigaworm (Sandworm)', '335', 'desiccation', '595', '2191', '90', '3000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Azure Leech', '336', 'suction', '376', '414', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Azure Leech', '336', 'random_kiss', '316', '325', '10', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Azure Leech', '336', 'sand_breath', '378', '416', '20', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Azure Leech', '336', 'acid_mist', '377', '415', '30', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Azure Leech', '336', 'regeneration', '380', '3548', '40', '600');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Azure Leech', '336', 'regeneration', '380', '418', '40', '600');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Azure Leech', '336', 'regeneration', '380', '461', '40', '600');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Azure Leech', '336', 'mp_drainkiss', '382', '421', '50', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Azure Leech', '336', 'drainkiss', '379', '417', '50', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Azure Leech', '336', 'tp_drainkiss', '381', '420', '50', '700');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Azure Leech', '336', 'brain_drain', '383', '423', '60', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Azure Leech', '336', 'absorbing_kiss', '317', '326', '70', '2000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Azure Leech', '336', 'deep_kiss', '318', '327', '80', '1800');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Obdella (Leech)', '337', 'suction', '376', '414', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Obdella (Leech)', '337', 'random_kiss', '316', '325', '10', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Obdella (Leech)', '337', 'sand_breath', '378', '416', '20', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Obdella (Leech)', '337', 'acid_mist', '377', '415', '30', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Obdella (Leech)', '337', 'regeneration', '380', '461', '40', '600');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Obdella (Leech)', '337', 'regeneration', '380', '3548', '40', '600');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Obdella (Leech)', '337', 'regeneration', '380', '418', '40', '600');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Obdella (Leech)', '337', 'mp_drainkiss', '382', '421', '50', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Obdella (Leech)', '337', 'tp_drainkiss', '381', '420', '50', '700');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Obdella (Leech)', '337', 'drainkiss', '379', '417', '50', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Obdella (Leech)', '337', 'brain_drain', '383', '423', '60', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Obdella (Leech)', '337', 'absorbing_kiss', '317', '326', '70', '2000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Obdella (Leech)', '337', 'deep_kiss', '318', '327', '80', '1800');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Vermilion Crab', '340', 'big_scissors', '396', '444', '1', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Vermilion Crab', '340', 'bubble_curtain', '395', '443', '10', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Vermilion Crab', '340', 'bubble_shower', '394', '442', '20', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Vermilion Crab', '340', 'scissor_guard', '397', '445', '30', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Vermilion Crab', '340', 'metallic_body', '398', '448', '40', '800');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Basket-burdened Crab', '341', 'big_scissors', '396', '444', '1', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Basket-burdened Crab', '341', 'bubble_curtain', '395', '443', '10', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Basket-burdened Crab', '341', 'bubble_shower', '394', '442', '20', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Basket-burdened Crab', '341', 'scissor_guard', '397', '445', '30', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Basket-burdened Crab', '341', 'metallic_body', '398', '448', '40', '800');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Vermilion Basket-burdened Crab', '342', 'big_scissors', '396', '444', '1', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Vermilion Basket-burdened Crab', '342', 'bubble_curtain', '395', '443', '10', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Vermilion Basket-burdened Crab', '342', 'bubble_shower', '394', '442', '20', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Vermilion Basket-burdened Crab', '342', 'scissor_guard', '397', '445', '30', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Vermilion Basket-burdened Crab', '342', 'metallic_body', '398', '448', '40', '800');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Porter Crab (Crab)', '343', 'big_scissors', '396', '444', '1', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Porter Crab (Crab)', '343', 'bubble_curtain', '395', '443', '10', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Porter Crab (Crab)', '343', 'bubble_shower', '394', '442', '20', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Porter Crab (Crab)', '343', 'scissor_guard', '397', '445', '30', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Porter Crab (Crab)', '343', 'metallic_body', '398', '448', '40', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Porter Crab (Crab)', '343', 'mega_scissors', '616', '2513', '50', '2000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Porter Crab (Crab)', '343', 'venom_shower', '615', '2512', '60', '2500');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Jagil (Pugil)', '344', 'intimidate', '399', '449', '1', '750');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Jagil (Pugil)', '344', 'aqua_ball', '400', '450', '10', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Jagil (Pugil)', '344', 'splash_breath', '401', '451', '20', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Jagil (Pugil)', '344', 'screwdriver', '402', '452', '30', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Jagil (Pugil)', '344', 'water_wall', '403', '453', '40', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Jagil (Pugil)', '344', 'water_shield', '404', '454', '50', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Jagil (Pugil)', '344', 'recoil_dive', '450', '641', '60', '1250');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Azure Sea Monk', '345', 'tentacle', '405', '456', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Azure Sea Monk', '345', 'ink_jet', '406', '458', '10', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Azure Sea Monk', '345', 'hard_membrane', '407', '3547', '20', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Azure Sea Monk', '345', 'hard_membrane', '407', '459', '20', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Azure Sea Monk', '345', 'cross_attack', '408', '460', '30', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Azure Sea Monk', '345', 'regeneration', '409', '3548', '40', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Azure Sea Monk', '345', 'regeneration', '409', '418', '40', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Azure Sea Monk', '345', 'regeneration', '409', '461', '40', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Azure Sea Monk', '345', 'whirlwind', '411', '463', '50', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Azure Sea Monk', '345', 'maelstrom', '410', '462', '60', '1200');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Limascabra (Uragnite)', '346', 'gas_shell', '421', '1571', '1', '600');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Limascabra (Uragnite)', '346', 'painful_whip', '424', '1574', '10', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Limascabra (Uragnite)', '346', 'suctorial_tentacle', '425', '1575', '20', '600');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Limascabra (Uragnite)', '346', 'palsynyxis', '423', '1573', '30', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Limascabra (Uragnite)', '346', 'venom_shell', '422', '1572', '40', '1200');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Pygmy Orobon', '347', 'hypnic_lamp', '511', '1695', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Pygmy Orobon', '347', 'seaspray', '513', '1697', '10', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Pygmy Orobon', '347', 'seismic_tail', '512', '1696', '30', '2000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Pygmy Orobon', '347', 'vile_belch', '510', '1694', '40', '1500');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Ogrebon (Orobon)', '348', 'hypnic_lamp', '511', '1695', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Ogrebon (Orobon)', '348', 'seaspray', '513', '1697', '10', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Ogrebon (Orobon)', '348', 'seismic_tail', '512', '1696', '30', '2000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Ogrebon (Orobon)', '348', 'vile_belch', '510', '1694', '40', '1500');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Onyx Bird', '351', 'helldive', '442', '622', '1', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Onyx Bird', '351', 'wing_cutter', '443', '623', '10', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Onyx Bird', '351', 'damnation_dive', '490', '1445', '40', '1500');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Ziz (Cockatrice)', '352', 'sound_vacuum', '373', '408', '1', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Ziz (Cockatrice)', '352', 'sound_vacuum', '373', '429', '1', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Ziz (Cockatrice)', '352', 'sound_blast', '374', '410', '10', '800');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Ziz (Cockatrice)', '352', 'baleful_gaze', '375', '370', '20', '1300');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Ziz (Cockatrice)', '352', 'baleful_gaze', '375', '411', '20', '1300');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Ziz (Cockatrice)', '352', 'hammer_beak', '371', '406', '30', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Ziz (Cockatrice)', '352', 'poison_pick', '372', '407', '40', '1000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Legendary Roc', '353', 'blind_vortex', '366', '922', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Legendary Roc', '353', 'giga_scream', '367', '923', '10', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Legendary Roc', '353', 'dread_dive', '368', '924', '20', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Legendary Roc', '353', 'feather_barrier', '369', '402', '30', '500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Legendary Roc', '353', 'stormwind', '370', '926', '40', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Legendary Roc', '353', 'stormwind', '370', '403', '40', '1500');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Gagana (Roc)', '354', 'blind_vortex', '366', '922', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Gagana (Roc)', '354', 'giga_scream', '367', '923', '10', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Gagana (Roc)', '354', 'dread_dive', '368', '924', '20', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Gagana (Roc)', '354', 'feather_barrier', '369', '402', '30', '500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Gagana (Roc)', '354', 'stormwind', '370', '926', '40', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Gagana (Roc)', '354', 'stormwind', '370', '403', '40', '1500');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Bats', '355', 'sonic_boom', '363', '393', '1', '750');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Bats', '355', 'jet_stream', '365', '395', '10', '1000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Vermilion Bat', '356', 'ultrasonics', '362', '392', '1', '750');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Vermilion Bat', '356', 'blood_drain', '364', '394', '10', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Vermilion Bat', '356', 'subsonics', '484', '1155', '20', '750');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Vermilion Bat', '356', 'marrow_drain', '485', '1156', '30', '1000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Vermilion Bats', '357', 'sonic_boom', '363', '393', '1', '750');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Vermilion Bats', '357', 'jet_stream', '365', '395', '10', '1000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Inguza (Apkallu)', '358', 'yawn', '653', '1713', '1', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Inguza (Apkallu)', '358', 'beak_lunge', '655', '1715', '10', '1200');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Inguza (Apkallu)', '358', 'frigid_shuffle', '656', '1716', '20', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Inguza (Apkallu)', '358', 'wing_slap', '654', '1714', '30', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Inguza (Apkallu)', '358', 'wing_whirl', '657', '1717', '40', '1500');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Toucalibri (Colibri)', '359', 'snatch_morsel', '516', '1700', '1', '600');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Toucalibri (Colibri)', '359', 'pecking_flurry', '515', '1699', '10', '1000');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Toucalibri (Colibri)', '359', 'feather_tickle', '517', '1701', '20', '1000');

-- INSERT INTO `monstrosity_tp_skills` VALUES ('Sanguiptere (Amphiptere)', '360', 'storm_wing', '607', '2432', '1', '1300');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Sanguiptere (Amphiptere)', '360', 'bloody_beak', '604', '2428', '10', '1300');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Sanguiptere (Amphiptere)', '360', 'reaving_wind', '606', '2431', '20', '1500');
-- INSERT INTO `monstrosity_tp_skills` VALUES ('Sanguiptere (Amphiptere)', '360', 'calamitous_wind', '608', '2433', '30', '1700');
