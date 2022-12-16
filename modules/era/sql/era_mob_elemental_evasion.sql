-- --------------------------------------------------------
-- Mob Elemental Evasion
-- --------------------------------------------------------
-- This module is used to apply elemental evasion to mobs
-- Default is 100
-- Negative values indicate absorption
-- Zero values indicate immunity
-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `mob_ele_evasion` (
	`ele_eva_id` SMALLINT(4) UNSIGNED NOT NULL,
	`fire_eem` SMALLINT(4) NULL DEFAULT '100',
	`ice_eem` SMALLINT(4) NULL DEFAULT '100',
	`wind_eem` SMALLINT(4) NULL DEFAULT '100',
	`earth_eem` SMALLINT(4) NULL DEFAULT '100',
	`lightning_eem` SMALLINT(4) NULL DEFAULT '100',
	`water_eem` SMALLINT(4) NULL DEFAULT '100',
	`light_eem` SMALLINT(4) NULL DEFAULT '100',
	`dark_eem` SMALLINT(4) NULL DEFAULT '100',
	PRIMARY KEY (`ele_eva_id`)
)
ENGINE=InnoDB
;

LOCK TABLES
	`mob_pools` WRITE,
	`mob_ele_evasion` WRITE;

-- Modify the mob_pools table to add an evasion_id lookup as a foreign key to this table
ALTER TABLE `mob_pools`
	ADD COLUMN IF NOT EXISTS `ele_eva_id` SMALLINT(4) UNSIGNED NOT NULL DEFAULT 164 AFTER `resist_id`,
	ADD CONSTRAINT `Elemental_Evasion_ID` FOREIGN KEY (`ele_eva_id`) REFERENCES `mob_ele_evasion` (`ele_eva_id`) ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Add the data into the evasion tables
REPLACE INTO `mob_ele_evasion` (`ele_eva_id`, `fire_eem`, `ice_eem`, `wind_eem`, `earth_eem`, `lightning_eem`, `water_eem`, `light_eem`, `dark_eem`) VALUES
	(1, 150, 150, 150, 150, 150, 150, 150, 150),
	(2, 150, 150, 150, 100, 150, 100, 100, 150),
	(3, 150, 130, 130, 130, 130, 130, 130, 130),
	(4, 150, 130, 130, 130, 130, 130, 50, 50),
	(5, 150, 130, 130, 130, 130, 50, 130, 50),
	(6, 150, 130, 130, 100, 130, 100, 100, 150),
	(7, 150, 115, 115, 115, 115, 60, 60, 115),
	(8, 150, 115, 60, 100, 100, 60, 60, 115),
	(9, 150, 100, 130, 130, 130, 130, 150, 100),
	(10, 150, 100, 130, 130, 130, 130, 150, 50),
	(11, 150, 100, 100, 130, 130, 130, 130, 130),
	(12, 150, 100, 100, 100, 150, 130, 100, 100),
	(13, 150, 100, 100, 60, 100, 40, 130, 100),
	(14, 150, 85, 50, 85, 60, 85, 85, 85),
	(15, 150, 70, 100, 100, 100, 100, 150, 70),
	(16, 150, 50, 150, 50, 100, 50, 70, 10),
	(17, 150, 50, 130, 100, 130, 130, 150, 50),
	(18, 150, 50, 70, 50, 70, 20, 5, 50),
	(19, 150, 50, 50, 50, 50, 50, 50, 50),
	(20, 150, 5, 85, 85, 150, 5, 85, 85),
	(21, 150, 5, 5, 100, 100, 100, 100, 100),
	(22, 150, 100, 5, 5, 5, 5, 5, 5),
	(23, 130, 150, 130, 130, 150, 70, 130, 130),
	(24, 130, 150, 130, 130, 150, 50, 130, 130),
	(25, 130, 150, 130, 130, 150, 30, 130, 130),
	(26, 130, 150, 130, 100, 150, 130, 100, 150),
	(27, 130, 150, 115, 100, 100, 130, 100, 130),
	(28, 130, 150, 100, 100, 130, 130, 130, 130),
	(29, 130, 150, 100, 100, 130, 50, 50, 150),
	(30, 130, 150, 70, 130, 130, 130, 130, 130),
	(31, 130, 130, 150, 70, 130, 130, 150, 100),
	(32, 130, 130, 150, 70, 70, 130, 130, 130),
	(33, 130, 130, 130, 150, 100, 130, 130, 130),
	(34, 130, 130, 130, 130, 130, 130, 150, 100),
	(35, 130, 130, 130, 130, 130, 130, 130, 130),
	(36, 130, 130, 130, 130, 130, 130, 130, 70),
	(37, 130, 130, 130, 130, 130, 50, 150, 50),
	(38, 130, 130, 130, 130, 130, 50, 85, 130),
	(39, 130, 130, 115, 60, 130, 70, 70, 130),
	(40, 130, 130, 100, 130, 130, 130, 100, 100),
	(41, 130, 130, 100, 100, 100, 50, 150, 70),
	(42, 130, 130, 50, 70, 50, 60, 70, 50),
	(43, 130, 115, 150, 130, 130, 130, 150, 30),
	(44, 130, 115, 130, 115, 150, 150, 115, 150),
	(45, 130, 115, 115, 115, 115, 50, 115, 50),
	(46, 130, 115, 115, 85, 115, 85, 85, 130),
	(47, 130, 100, 150, 100, 150, 130, 130, 130),
	(48, 130, 100, 130, 130, 150, 150, 130, 130),
	(49, 130, 100, 115, 60, 85, 100, 70, 100),
	(50, 130, 100, 100, 100, 100, 100, 150, 10),
	(51, 130, 100, 100, 100, 100, 100, 100, 130),
	(52, 130, 100, 100, 100, 100, 50, 130, 50),
	(53, 130, 100, 50, 70, 130, 50, 100, 100),
	(54, 130, 85, 130, 130, 115, 130, 130, 130),
	(55, 130, 85, 100, 85, 115, 115, 85, 85),
	(56, 130, 85, 85, 85, 130, 115, 85, 85),
	(57, 130, 70, 115, 115, 115, 115, 130, 50),
	(58, 130, 70, 115, 115, 115, 115, 115, 115),
	(59, 130, 70, 115, 115, 115, 115, 115, 70),
	(60, 130, 70, 115, 70, 115, 115, 150, 60),
	(61, 130, 70, 70, 30, 50, 70, 85, 85),
	(62, 130, 60, 100, 100, 100, 70, 130, 20),
	(63, 130, 60, 60, 60, 60, 60, 60, 60),
	(64, 130, 50, 115, 85, 115, 115, 130, 50),
	(65, 130, 50, 100, 100, 100, 100, 130, 50),
	(66, 130, 50, 100, 100, 100, 100, 100, 100),
	(67, 130, 50, 85, 100, 100, 100, 130, 50),
	(68, 130, 40, 115, 100, 130, 115, 130, 40),
	(69, 130, 30, 70, 60, 70, 60, 130, 15),
	(70, 130, 5, 130, 5, 130, 5, 130, 5),
	(71, 130, 5, 5, 100, 100, 100, 100, 100),
	(72, 130, 5, 5, 10, 15, 70, 30, 45),
	(73, 115, 150, 115, 100, 130, 85, 50, 100),
	(74, 115, 130, 150, 50, 115, 115, 130, 50),
	(75, 115, 130, 115, 115, 130, 60, 130, 70),
	(76, 115, 130, 115, 115, 130, 30, 115, 115),
	(77, 115, 130, 85, 85, 115, 115, 115, 115),
	(78, 115, 130, 70, 70, 115, 70, 115, 115),
	(79, 115, 130, 60, 100, 130, 85, 130, 50),
	(80, 115, 130, 30, 100, 115, 115, 100, 130),
	(81, 115, 130, 100, 115, 100, 115, 115, 115),
	(82, 115, 115, 130, 115, 115, 115, 85, 85),
	(83, 115, 115, 130, 70, 100, 115, 115, 100),
	(84, 115, 115, 130, 70, 70, 115, 115, 115),
	(85, 115, 115, 115, 115, 115, 150, 130, 60),
	(86, 115, 115, 115, 115, 115, 115, 130, 85),
	(87, 115, 115, 115, 115, 115, 115, 130, 70),
	(88, 115, 115, 115, 115, 115, 115, 115, 115),
	(89, 115, 115, 115, 115, 115, 115, 30, 130),
	(90, 115, 115, 115, 115, 115, 40, 130, 50),
	(91, 115, 115, 115, 100, 115, 115, 150, 70),
	(92, 115, 115, 115, 60, 115, 60, 115, 50),
	(93, 115, 115, 115, 60, 100, 115, 115, 100),
	(94, 115, 115, 100, 100, 115, 100, 100, 100),
	(95, 115, 115, 70, 115, 115, 115, 130, 30),
	(96, 115, 115, 60, 135, 60, 115, 115, 115),
	(97, 115, 100, 115, 115, 130, 50, 100, 100),
	(98, 115, 100, 100, 100, 100, 100, 40, 40),
	(99, 115, 100, 60, 100, 100, 100, 130, 50),
	(100, 115, 85, 130, 40, 85, 70, 60, 115),
	(101, 115, 85, 115, 115, 130, 130, 115, 115),
	(102, 115, 85, 115, 115, 130, 30, 130, 60),
	(103, 115, 85, 115, 100, 115, 85, 50, 40),
	(104, 115, 85, 115, 85, 130, 130, 115, 115),
	(105, 115, 85, 115, 85, 115, 85, 130, 50),
	(106, 115, 85, 100, 100, 100, 100, 115, 60),
	(107, 115, 85, 85, 85, 115, 60, 115, 70),
	(108, 115, 85, 85, 70, 85, 115, 85, 85),
	(109, 115, 85, 85, 60, 85, 115, 85, 85),
	(110, 115, 70, 115, 115, 115, 130, 115, 115),
	(111, 115, 70, 115, 115, 100, 130, 115, 115),
	(112, 115, 60, 85, 85, 85, 85, 85, 85),
	(113, 115, 50, 115, 100, 115, 85, 50, 25),
	(114, 115, 50, 85, 100, 115, 40, 100, 85),
	(115, 115, 50, 70, 15, 30, 20, 50, 30),
	(116, 115, 35, 35, 35, 35, 115, 25, 25),
	(117, 115, 30, 100, 50, 100, 85, 50, 30),
	(118, 100, 150, 150, 100, 100, 130, 130, 130),
	(119, 100, 150, 100, 100, 130, 130, 150, 100),
	(120, 100, 150, 100, 100, 115, 115, 100, 100),
	(121, 100, 150, 100, 100, 100, 100, 150, 100),
	(122, 100, 150, 100, 5, 100, 100, 130, 100),
	(123, 100, 150, 5, 5, 100, 100, 100, 100),
	(124, 100, 130, 130, 130, 150, 100, 130, 130),
	(125, 100, 130, 130, 130, 130, 130, 85, 115),
	(126, 100, 130, 130, 60, 85, 115, 115, 115),
	(127, 100, 130, 130, 30, 50, 130, 130, 100),
	(128, 100, 130, 115, 115, 150, 50, 100, 100),
	(129, 100, 130, 115, 85, 115, 115, 100, 100),
	(130, 100, 130, 100, 100, 150, 5, 100, 100),
	(131, 100, 130, 100, 100, 130, 50, 100, 100),
	(132, 100, 130, 100, 100, 130, 50, 100, 70),
	(133, 100, 130, 100, 50, 130, 130, 70, 100),
	(134, 100, 130, 85, 115, 115, 115, 115, 115),
	(135, 100, 130, 70, 100, 115, 100, 100, 115),
	(136, 100, 130, 70, 70, 130, 130, 100, 70),
	(137, 100, 130, 70, 70, 100, 30, 30, 100),
	(138, 100, 130, 50, 50, 100, 100, 100, 100),
	(139, 100, 130, 30, 70, 100, 100, 115, 60),
	(140, 100, 130, 30, 70, 100, 100, 100, 100),
	(141, 100, 115, 115, 130, 60, 115, 115, 115),
	(142, 100, 115, 115, 70, 115, 100, 115, 115),
	(143, 100, 115, 100, 60, 100, 40, 130, 100),
	(144, 100, 115, 70, 70, 100, 100, 100, 100),
	(145, 100, 115, 70, 70, 50, 130, 100, 70),
	(146, 100, 115, 50, 50, 100, 130, 70, 70),
	(147, 100, 100, 150, 5, 5, 100, 100, 100),
	(148, 100, 100, 130, 130, 130, 150, 130, 130),
	(149, 100, 100, 130, 60, 100, 100, 150, 60),
	(150, 100, 100, 130, 5, 5, 100, 100, 100),
	(151, 100, 100, 100, 150, 5, 5, 100, 100),
	(152, 100, 100, 100, 130, 50, 100, 100, 100),
	(153, 100, 100, 100, 130, 30, 100, 70, 115),
	(154, 100, 100, 100, 100, 150, 100, 100, 100),
	(155, 100, 100, 100, 100, 115, 100, 100, 100),
	(156, 100, 100, 100, 100, 115, 100, 100, 5),
	(157, 100, 100, 100, 100, 100, 130, 115, 50),
	(158, 100, 100, 100, 100, 100, 100, 150, 5),
	(159, 100, 100, 100, 100, 100, 100, 130, 100),
	(160, 100, 100, 100, 100, 100, 100, 130, 30),
	(161, 100, 100, 100, 100, 100, 100, 130, 5),
	(162, 100, 100, 100, 100, 100, 100, 115, 70),
	(163, 100, 100, 100, 100, 100, 100, 100, 150),
	(164, 100, 100, 100, 100, 100, 100, 100, 100),
	(165, 100, 100, 100, 100, 100, 100, 100, 15),
	(166, 100, 100, 100, 100, 100, 100, 70, 50),
	(167, 100, 100, 100, 100, 100, 100, 10, 10),
	(168, 100, 100, 100, 100, 100, 100, 5, 150),
	(169, 100, 100, 100, 70, 100, 60, 100, 100),
	(170, 100, 100, 100, 50, 100, 50, 50, 40),
	(171, 100, 100, 100, 50, 20, 130, 115, 50),
	(172, 100, 100, 85, 40, 100, 50, 50, 100),
	(173, 100, 100, 60, 100, 100, 100, 115, 20),
	(174, 100, 100, 25, 85, 100, 100, 85, 115),
	(175, 100, 85, 85, 85, 50, 115, 50, 85),
	(176, 100, 70, 115, 50, 85, 100, 115, 40),
	(177, 100, 70, 100, 100, 115, 25, 115, 50),
	(178, 100, 70, 100, 100, 100, 15, 115, 5),
	(179, 100, 70, 100, 100, 70, 100, 100, 100),
	(180, 100, 70, 100, 85, 115, 20, 30, 100),
	(181, 100, 70, 100, 70, 115, 115, 100, 100),
	(182, 100, 70, 100, 70, 100, 70, 115, 30),
	(183, 100, 70, 85, 40, 60, 70, 50, 70),
	(184, 100, 70, 85, 25, 85, 30, 50, 30),
	(185, 100, 70, 70, 70, 100, 50, 100, 60),
	(186, 100, 70, 70, 70, 100, 50, 50, 60),
	(187, 100, 70, 50, 70, 85, 70, 60, 40),
	(188, 100, 60, 100, 60, 100, 60, 20, 10),
	(189, 100, 60, 60, 60, 70, 100, 30, 5),
	(190, 100, 50, 70, 70, 100, 50, 70, 70),
	(191, 100, 50, 70, 70, 100, 100, 70, 70),
	(192, 100, 50, 50, 50, 100, 30, 85, 40),
	(193, 100, 50, 50, 100, 100, 0, 50, 15),
	(194, 100, 40, 70, 60, 70, 70, 100, 15),
	(195, 100, 30, 130, 5, 5, 70, 100, 70),
	(196, 100, 30, 85, 70, 85, 85, 100, 30),
	(197, 100, 30, 85, 60, 85, 85, 100, 30),
	(198, 100, 30, 70, 5, 5, 10, 50, 30),
	(199, 100, 30, 60, 30, 60, 15, 5, 30),
	(200, 100, 25, 60, 60, 60, 60, 130, 10),
	(201, 100, 15, 30, 30, 50, 70, 70, 85),
	(202, 100, 100, 70, 70, 100, 50, 70, 70),
	(203, 85, 150, 50, 85, 85, 85, 85, 85),
	(204, 85, 150, 5, 150, 5, 85, 85, 85),
	(205, 85, 130, 130, 60, 85, 115, 115, 115),
	(206, 85, 130, 115, 70, 100, 130, 115, 100),
	(207, 85, 130, 100, 85, 115, 115, 130, 85),
	(208, 85, 130, 50, 85, 85, 85, 85, 85),
	(209, 85, 115, 115, 115, 130, 85, 115, 115),
	(210, 85, 115, 115, 100, 115, 130, 100, 115),
	(211, 85, 115, 50, 85, 100, 85, 85, 100),
	(212, 85, 100, 100, 100, 100, 100, 100, 100),
	(213, 85, 100, 85, 85, 100, 40, 100, 50),
	(214, 85, 100, 15, 40, 85, 85, 85, 85),
	(215, 85, 85, 150, 5, 85, 85, 150, 5),
	(216, 85, 85, 115, 115, 130, 40, 115, 115),
	(217, 85, 85, 115, 115, 115, 130, 115, 115),
	(218, 85, 85, 85, 85, 85, 85, 115, 85),
	(219, 85, 85, 85, 85, 85, 85, 115, 25),
	(220, 85, 85, 85, 85, 85, 85, 100, 50),
	(221, 85, 85, 85, 85, 85, 85, 85, 85),
	(222, 85, 85, 85, 85, 70, 85, 100, 70),
	(223, 85, 85, 85, 70, 85, 85, 100, 70),
	(224, 85, 85, 70, 85, 85, 85, 100, 70),
	(225, 85, 85, 5, 85, 85, 85, 85, 20),
	(226, 85, 85, 5, 85, 85, 85, 20, 85),
	(227, 85, 70, 85, 85, 85, 70, 100, 70),
	(228, 85, 60, 85, 85, 85, 85, 130, 50),
	(229, 85, 60, 60, 85, 70, 70, 50, 70),
	(230, 85, 60, 60, 85, 50, 20, 50, 70),
	(231, 85, 50, 60, 60, 85, 85, 115, 5),
	(232, 85, 30, 30, 30, 85, 15, 60, 50),
	(233, 70, 130, 115, 115, 115, 115, 70, 115),
	(234, 70, 100, 100, 100, 115, 70, 100, 100),
	(235, 70, 100, 70, 130, 30, 70, 85, 70),
	(236, 70, 100, 70, 50, 100, 100, 70, 70),
	(237, 70, 100, 70, 50, 70, 30, 15, 70),
	(238, 70, 100, 70, 25, 70, 85, 85, 85),
	(239, 70, 100, 50, 100, 50, 70, 70, 70),
	(240, 70, 100, 50, 100, 100, 70, 70, 70),
	(241, 70, 100, 30, 50, 70, 70, 70, 70),
	(242, 70, 100, 30, 30, 70, 100, 70, 70),
	(243, 70, 100, 100, 100, 50, 70, 70, 70),
	(244, 70, 85, 85, 85, 85, 85, 100, 70),
	(245, 70, 85, 50, 50, 70, 70, 70, 70),
	(246, 70, 85, 20, 100, 70, 70, 70, 50),
	(247, 70, 70, 100, 100, 100, 130, 100, 100),
	(248, 70, 70, 100, 50, 70, 70, 100, 50),
	(249, 70, 70, 70, 130, 30, 70, 100, 50),
	(250, 70, 70, 70, 70, 150, 70, 70, 70),
	(251, 70, 70, 70, 70, 70, 70, 100, 5),
	(252, 70, 70, 70, 70, 70, 70, 70, 70),
	(253, 70, 70, 70, 70, 70, 70, 20, 115),
	(254, 70, 70, 70, 60, 150, 70, 70, 70),
	(255, 70, 70, 70, 50, 70, 40, 70, 70),
	(256, 70, 70, 60, 60, 25, 100, 40, 60),
	(257, 70, 70, 40, 115, 70, 70, 50, 85),
	(258, 70, 70, 15, 15, 50, 50, 30, 50),
	(259, 70, 60, 60, 60, 25, 100, 40, 60),
	(260, 70, 50, 70, 130, 30, 70, 85, 70),
	(261, 70, 50, 70, 85, 70, 15, 70, 5),
	(262, 70, 50, 70, 70, 70, 10, 85, 5),
	(263, 70, 50, 70, 60, 85, 5, 20, 70),
	(264, 70, 50, 70, 50, 70, 50, 100, 20),
	(265, 70, 50, 70, 50, 70, 50, 100, 5),
	(266, 70, 50, 70, 50, 70, 50, 85, 30),
	(267, 70, 50, 70, 50, 70, 50, 50, 20),
	(268, 70, 50, 20, 50, 70, 20, 70, 20),
	(269, 70, 40, 60, 20, 40, 25, 40, 60),
	(270, 70, 30, 30, 130, 30, 70, 85, 85),
	(271, 70, 30, 30, 20, 50, 20, 50, 5),
	(272, 70, 15, 15, 50, 50, 50, 30, 70),
	(273, 70, 10, 30, 30, 30, 30, 70, 10),
	(274, 70, 5, 70, 5, 70, 5, 70, 5),
	(275, 60, 115, 115, 115, 150, 60, 115, 115),
	(276, 60, 115, 50, 40, 60, 85, 85, 100),
	(277, 60, 100, 115, 100, 100, 130, 115, 115),
	(278, 60, 100, 70, 100, 115, 115, 115, 130),
	(279, 60, 85, 60, 85, 60, 85, 30, 130),
	(280, 60, 70, 100, 20, 60, 60, 70, 20),
	(281, 60, 60, 60, 100, 100, 100, 100, 100),
	(282, 60, 60, 60, 60, 60, 60, 130, 5),
	(283, 60, 60, 60, 60, 60, 60, 85, 60),
	(284, 60, 60, 60, 60, 60, 60, 85, 40),
	(285, 60, 60, 60, 60, 60, 60, 60, 60),
	(286, 60, 60, 60, 60, 60, 60, 30, 60),
	(287, 60, 60, 60, 60, 60, 60, 30, 30),
	(288, 60, 60, 60, 60, 60, 60, 25, 115),
	(289, 60, 60, 60, 60, 60, 60, 20, 20),
	(290, 60, 60, 60, 25, 50, 60, 60, 50),
	(291, 60, 60, 5, 60, 60, 60, 15, 60),
	(292, 60, 50, 60, 50, 60, 50, 115, 15),
	(293, 60, 50, 25, 50, 50, 50, 70, 20),
	(294, 60, 40, 60, 60, 100, 60, 40, 40),
	(295, 60, 40, 60, 60, 60, 60, 100, 30),
	(296, 60, 30, 50, 40, 60, 50, 60, 5),
	(297, 60, 30, 40, 40, 60, 60, 85, 5),
	(298, 60, 30, 40, 40, 60, 60, 50, 5),
	(299, 60, 15, 60, 15, 60, 15, 70, 5),
	(300, 60, 15, 30, 20, 60, 30, 60, 5),
	(301, 60, 10, 60, 10, 60, 10, 60, 10),
	(302, 50, 130, 50, 130, 130, 150, 100, 100),
	(303, 50, 130, 50, 130, 70, 70, 70, 70),
	(304, 50, 130, 50, 5, 5, 5, 50, 50),
	(305, 50, 130, 10, 10, 50, 50, 50, 50),
	(306, 50, 100, 100, 100, 130, 130, 130, 150),
	(307, 50, 100, 100, 100, 130, 50, 100, 100),
	(308, 50, 100, 100, 100, 100, 100, 100, 30),
	(309, 50, 100, 50, 100, 130, 130, 130, 150),
	(310, 50, 90, 100, 100, 130, 130, 130, 150),
	(311, 50, 85, 20, 70, 20, 70, 70, 5),
	(312, 50, 70, 70, 70, 85, 50, 70, 70),
	(313, 50, 70, 70, 70, 70, 100, 50, 100),
	(314, 50, 70, 70, 70, 70, 100, 100, 100),
	(315, 50, 70, 70, 70, 70, 85, 70, 70),
	(316, 50, 70, 50, 50, 70, 20, 50, 30),
	(317, 50, 70, 50, 15, 50, 60, 60, 60),
	(318, 50, 70, 15, 70, 15, 50, 50, 30),
	(319, 50, 70, 15, 15, 50, 50, 50, 50),
	(320, 50, 70, 100, 5, 50, 50, 5, 70),
	(321, 50, 60, 5, 5, 50, 50, 50, 30),
	(322, 50, 50, 130, 10, 10, 50, 50, 50),
	(323, 50, 50, 100, 100, 100, 130, 100, 100),
	(324, 50, 50, 85, 5, 50, 50, 50, 50),
	(325, 50, 50, 70, 70, 70, 100, 70, 70),
	(326, 50, 50, 70, 70, 70, 85, 70, 70),
	(327, 50, 50, 60, 20, 130, 50, 30, 130),
	(328, 50, 50, 50, 70, 15, 15, 50, 50),
	(329, 50, 50, 50, 50, 130, 50, 30, 130),
	(330, 50, 50, 50, 50, 50, 50, 50, 50),
	(331, 50, 50, 50, 50, 50, 50, 10, 130),
	(332, 50, 50, 50, 50, 50, 50, 5, 150),
	(333, 50, 50, 50, 50, 50, 50, 5, 70),
	(334, 50, 30, 60, 5, 5, 15, 50, 10),
	(335, 50, 30, 50, 50, 100, 70, 50, 50),
	(336, 50, 30, 50, 30, 50, 30, 70, 5),
	(337, 50, 10, 40, 30, 40, 40, 50, 10),
	(338, 50, 5, 50, 5, 50, 5, 50, 5),
	(339, 40, 80, 40, 50, 30, 80, 50, 80),
	(340, 40, 70, 85, 70, 70, 100, 85, 85),
	(341, 40, 60, 40, 50, 100, 60, 50, 60),
	(342, 40, 40, 40, 40, 40, 40, 100, 10),
	(343, 40, 40, 40, 40, 40, 40, 5, 40),
	(344, 40, 25, 40, 25, 40, 25, 50, 5),
	(345, 30, 100, 100, 5, 30, 30, 30, 30),
	(346, 30, 60, 30, 60, 60, 10, 60, 60),
	(347, 30, 50, 5, 115, 100, 20, 30, 20),
	(348, 30, 30, 50, 50, 50, 30, 30, 5),
	(349, 30, 30, 50, 50, 30, 50, 30, 5),
	(350, 30, 30, 30, 60, 60, 60, 60, 60),
	(351, 30, 30, 30, 30, 30, 100, 20, 5),
	(352, 30, 30, 30, 30, 30, 30, 100, 100),
	(353, 25, 100, 70, 50, 70, 130, 85, 85),
	(354, 25, 25, 70, 25, 25, 70, 50, 50),
	(355, 20, 70, 70, 70, 70, 70, 70, 70),
	(356, 20, 25, 25, 60, 5, 15, 25, 20),
	(357, 20, 20, 20, 20, 20, 70, 20, 5),
	(358, 15, 70, 30, 130, 5, 5, 30, 50),
	(359, 15, 50, 50, 70, 70, 15, 50, 30),
	(360, 15, 15, 50, 50, 70, 70, 30, 50),
	(361, 10, 85, 85, 85, 85, 130, 85, 85),
	(362, 10, 60, 10, 60, 10, 60, 10, 60),
	(363, 10, 50, 50, 50, 130, 10, 50, 50),
	(364, 10, 10, 50, 50, 50, 130, 50, 50),
	(365, 5, 150, 100, 5, 5, 5, 5, 5),
	(366, 5, 130, 70, 115, 100, 130, 100, 115),
	(367, 5, 130, 5, 130, 5, 130, 5, 130),
	(368, 5, 100, 100, 100, 150, 5, 100, 100),
	(369, 5, 100, 100, 100, 100, 150, 100, 100),
	(370, 5, 100, 50, 85, 70, 100, 70, 70),
	(371, 5, 85, 85, 85, 85, 150, 5, 150),
	(372, 5, 70, 70, 70, 100, 5, 130, 130),
	(373, 5, 70, 70, 70, 100, 5, 70, 70),
	(374, 5, 70, 5, 70, 5, 70, 5, 70),
	(375, 5, 50, 30, 20, 30, 15, 30, 30),
	(376, 5, 50, 5, 50, 5, 50, 5, 50),
	(377, 5, 30, 30, 30, 100, 100, 30, 30),
	(378, 5, 5, 150, 100, 5, 5, 5, 5),
	(379, 5, 5, 100, 100, 100, 150, 100, 100),
	(380, 5, 5, 100, 100, 100, 130, 100, 100),
	(381, 5, 5, 5, 150, 100, 5, 5, 5),
	(382, 5, 5, 5, 5, 150, 100, 5, 5),
	(383, 0, 115, 50, 40, 60, 85, 85, 100),
	(384, 100, 100, 100, 100, 100, 100, 10, 10),
	(385, 100, 70, 70, 70, 70, 100, 50, 100),
	(386, 100, 5, 5, 5, 5, 150, 5, 5),

	(387,130,130,150,70,130,130,150,100), -- Worm
	(388,130,150,100,100,130,130,130,130), -- Fly
	(389,130,150,130,130,150,70,130,130), -- Crab
	(390,130,115,130,115,150,150,115,150), -- Rabbit
	(391,130,100,150,100,150,130,130,130), -- Dhalmel
	(392,100,150,100,100,100,100,150,100), -- Beetle
	(393,130,150,130,100,150,130,100,150), -- Crawler
	(394,130,115,150,130,130,130,150,30), -- Bat
	(395,130,115,150,130,130,130,150,30), -- Bat_Trio
	(396,130,130,130,130,130,130,150,100), -- Goblin
	(397,100,100,100,130,50,100,100,100), -- Gigas
	(398,100,150,150,100,100,130,130,130), -- Lizard
	(399,130,70,115,115,115,115,115,115), -- Lizard-Ice
	(400,150,100,130,130,130,130,150,50), -- Skeleton
	(401,130,150,130,130,150,30,130,130), -- Pugil
	(402,130,100,130,130,150,150,130,130), -- Sheep
	(403,130,150,100,100,130,130,130,130), -- Bird
	(404,100,100,130,130,130,150,130,130), -- Orc
	(405,100,100,130,130,130,150,130,130), -- Orc-NM
	(406,100,150,100,100,115,115,100,100), -- Spider
	(407,85,115,115,115,130,85,115,115), -- Quadav
	(408,85,115,115,115,130,85,115,115), -- Quadav-NM
	(409,150,130,130,100,130,100,100,150), -- Sapling
	(410,130,130,100,100,100,50,150,70), -- Leech
	(411,150,100,100,100,150,130,100,100), -- Tiger
	(412,150,115,60,100,100,60,60,115), -- Flytrap
	(413,130,150,100,100,130,130,130,130), -- Yagudo
	(414,130,150,100,100,130,130,130,130), -- Yagudo-NM
	(415,100,100,130,130,130,150,130,130), -- Raptor
	(416,150,100,100,130,130,130,130,130), -- Raptor
	(417,115,115,115,115,115,150,130,60), -- Diremite
	(418,85,150,50,85,85,85,85,85), -- Greater_Bird
	(419,60,115,115,115,150,60,115,115), -- Uragnite
	(420,150,100,130,130,130,130,150,100), -- Evil_Weapon
	(421,130,130,130,150,100,130,130,130), -- Coeurl
	(422,100,150,5,5,100,100,100,100), -- Elemental-Air
	(423,100,100,100,100,100,100,150,5), -- Elemental-Dark
	(424,100,100,150,5,5,100,100,100), -- Elemental-Earth
	(425,5,5,100,100,100,150,100,100), -- Elemental-Fire
	(426,150,5,5,100,100,100,100,100), -- Elemental-Ice
	(427,100,100,100,100,100,100,5,150), -- Elemental-Light
	(428,100,100,100,150,5,5,100,100), -- Elemental-Lightning
	(429,5,100,100,100,150,5,100,100), -- Elemental-Water
	(430,150,150,150,100,150,100,100,150), -- Mandragora
	(431,115,130,150,50,115,115,130,50), -- Antica
	(432,130,130,130,130,130,50,150,50), -- Funguar
	(433,100,100,130,60,100,100,150,60), -- Antlion
	(434,115,115,115,115,115,115,30,130), -- Aern
	(435,100,100,100,100,100,100,130,30), -- Ahriman
	(436,50,130,50,5,5,5,50,50), -- Adamantoise
	(437,130,70,100,115,100,115,130,100), -- AnimatedWeapon-Archery
	(438,130,70,100,115,100,115,130,100), -- AnimatedWeapon-Axe
	(439,130,70,100,115,100,115,130,100), -- AnimatedWeapon-Club
	(440,130,70,100,115,100,115,130,100), -- AnimatedWeapon-Dagger
	(441,130,70,100,115,100,115,130,100), -- AnimatedWeapon-Greataxe
	(442,130,70,100,115,100,115,130,100), -- AnimatedWeapon-Greatkatana
	(443,130,70,100,115,100,115,130,100), -- AnimatedWeapon-Greatsword
	(444,130,70,100,115,100,115,130,100), -- AnimatedWeapon-Handtohand
	(445,130,70,100,115,100,115,130,100), -- AnimatedWeapon-Instrument
	(446,130,70,100,115,100,115,130,100), -- AnimatedWeapon-Katana
	(447,130,70,100,115,100,115,130,100), -- AnimatedWeapon-Marksmanship
	(448,130,70,100,115,100,115,130,100), -- AnimatedWeapon-Polearm
	(449,130,70,100,115,100,115,130,100), -- AnimatedWeapon-Scythe
	(450,130,70,100,115,100,115,130,100), -- AnimatedWeapon-Shield
	(451,130,70,100,115,100,115,130,100), -- AnimatedWeapon-Staff
	(452,130,70,100,115,100,115,130,100), -- AnimatedWeapon-Sword
	(453,100,60,60,60,70,100,30,5), -- Acrolith
	(454,70,70,100,50,70,70,100,50), -- Amoeban
	(455,85,85,115,115,130,40,115,115), -- Apkallu
	(456,70,70,70,70,70,70,70,70), -- Behemoth
	(457,130,40,115,100,130,115,130,40), -- Bhoot
	(458,150,50,50,50,50,50,50,50), -- Bomb
	(459,115,70,115,115,115,130,115,115), -- Buffalo
	(460,70,130,115,115,115,115,70,115), -- Bugard
	(461,115,115,115,100,115,115,150,70), -- Bugbear
	(462,130,130,130,130,130,130,130,130), -- Cardian
	(463,100,100,100,100,100,100,100,100), -- Cerberus
	(465,115,115,130,115,115,115,85,85), -- Slime-Clot
	(466,115,115,130,115,115,115,85,85), -- Slime-GlutinousClot
	(467,130,60,60,60,60,60,60,60), -- Cluster
	(468,130,60,60,60,60,60,60,60), -- Cluster
	(469,130,130,150,70,70,130,130,130), -- Cockatrice
	(470,130,70,115,70,115,115,150,60), -- Corse
	(471,130,150,130,130,150,70,130,130), -- Crab
	(472,130,150,130,130,150,70,130,130), -- Crab
	(473,150,5,5,100,100,100,100,100), -- Craver
	(474,70,70,70,70,150,70,70,70), -- Doll
	(475,70,70,70,70,150,70,70,70), -- Doll
	(476,70,70,70,70,150,70,70,70), -- Doll
	(477,130,60,100,100,100,70,130,20), -- Doomed
	(478,70,70,70,70,70,70,70,70), -- Dragon
	(479,115,115,115,115,115,115,130,85), -- DynamisStatue-Goblin
	(480,85,85,115,115,115,130,115,115), -- DynamisStatue-Orc
	(481,85,115,115,115,130,85,115,115), -- DynamisStatue-Quadav
	(482,115,130,85,85,115,115,115,115), -- DynamisStatue-Yagudo
	(483,115,130,70,70,115,70,115,115), -- Eft
	(484,85,115,115,100,115,130,100,115), -- Eruca
	(485,85,115,115,100,115,130,100,115), -- Eruca
	(486,150,115,115,115,115,60,60,115), -- Euvhi
	(487,115,85,85,85,115,60,115,70), -- Flan
	(488,150,50,130,100,130,130,150,50), -- Ghost
	(489,70,70,70,70,70,70,70,70), -- Golem
	(490,130,100,100,100,100,100,100,130), -- Goobbue
	(491,60,60,60,60,60,60,60,60), -- Gorger
	(492,60,60,60,60,60,60,60,60), -- Gorger
	(493,130,130,130,130,130,130,130,70), -- Hecteyes
	(494,115,115,60,135,60,115,115,115), -- Hippogryph
	(496,150,50,130,100,130,130,150,50), -- Hound
	(497,150,50,130,100,130,130,150,50), -- Hound
	(498,100,130,130,130,130,130,85,115), -- Hpemde
	(509,115,85,115,85,130,130,115,115), -- Karakul
	(510,100,100,100,100,100,100,130,100), -- Kindred
	(511,70,70,70,70,70,70,70,70), -- Magic_Pot
	(512,50,130,50,130,130,150,100,100), -- Manticore
	(513,100,115,115,70,115,100,115,115), -- Marid
	(514,100,100,100,100,100,100,100,100), -- MemoryReceptacle
	(515,100,100,100,100,100,100,100,100), -- Mimic
	(516,115,115,115,100,115,115,150,70), -- Moblin
	(518,130,150,115,100,100,130,100,130), -- Opo-opo
	(519,150,130,130,130,130,130,50,50), -- Orc-Warmachine
	(520,115,85,115,115,130,30,130,60), -- Orobon
	(521,100,100,100,70,100,60,100,100), -- Peiste
	(522,130,130,130,130,130,130,130,130), -- Wyvern-Pet
	(523,130,130,130,130,130,50,85,130), -- Phuabo
	(524,85,115,115,115,130,85,115,115), -- Quadav
	(525,85,115,115,115,130,85,115,115), -- Quadav
	(526,115,85,115,115,130,130,115,115), -- Ram
	(527,130,150,100,100,130,50,50,150), -- Sabotender
	(528,100,130,115,115,150,50,100,100), -- Sahagin
	(529,100,150,100,100,130,130,150,100), -- Scorpion
	(530,130,150,130,130,150,50,130,130), -- Sea_Monk
	(531,130,150,130,130,150,50,130,130), -- Sea_Monk
	(532,5,5,100,100,100,150,100,100), -- Seether
	(533,150,70,100,100,100,100,150,70), -- Shadow
	(534,150,70,100,100,100,100,150,70), -- Shadow
	(535,150,70,100,100,100,100,150,70), -- Shadow
	(536,100,100,100,100,100,100,100,15), -- ShadowLord
	(537,100,100,100,100,100,100,100,15), -- ShadowLord
	(538,150,130,130,130,130,130,130,130), -- Slime
	(539,150,130,130,130,130,130,130,130), -- Slime
	(540,150,130,130,130,130,130,130,130), -- Slime
	(541,100,100,100,100,150,100,100,100), -- Spheroid
	(543,115,115,115,115,115,115,130,70), -- Tauri
	(544,60,60,60,60,60,60,60,60), -- Thinker
	(545,115,150,115,100,130,85,50,100), -- Tonberry
	(546,115,150,115,100,130,85,50,100), -- Tonberry
	(547,150,130,130,100,130,100,100,150), -- Treant
	(548,150,5,5,100,100,100,100,100), -- Wanderer
	(549,100,100,100,100,100,100,150,5), -- Weeper
	(550,100,100,130,5,5,100,100,100), -- Wyrm-Ouryu
	(551,5,5,100,100,100,130,130,100), -- Wyrm-Fafnir
	(552,5,5,100,100,100,130,100,100), -- Wyrm-Cynoprosopi
	(553,5,5,100,100,100,130,100,100), -- Wyrm
	(554,5,5,100,100,100,130,130,100), -- Wyrm-Nidhogg
	(555,5,5,100,100,100,130,100,100), -- Wyrm
	(556,130,130,130,130,130,130,130,130), -- Wyvern-Pet
	(557,50,90,100,100,130,130,130,150), -- Wyvern-Guivre
	(558,130,130,100,130,130,130,100,100), -- Xzomit
	(559,100,100,100,130,30,100,70,115), -- Yovra
	(560,70,70,70,70,70,70,70,70), -- Zdei
	(561,100,100,100,100,100,100,100,100), -- ArkAngel-EV
	(562,100,100,100,100,100,100,100,100), -- ArkAngel-GK
	(563,100,100,100,100,100,100,100,100), -- ArkAngel-HM
	(564,100,100,100,100,100,100,100,100), -- ArkAngel-MR
	(565,100,100,100,100,100,100,100,100), -- ArkAngel-TT
	(566,100,130,100,100,130,50,100,100), -- Scorpion-Serket
	(567,100,130,100,100,130,50,100,100), -- Scorpion-KingV
	(568,115,150,115,100,130,85,50,100), -- Tonberry-ZM4
	(569,100,100,100,100,100,100,130,100), -- Kindred
	(570,130,50,100,100,100,100,130,50), -- Fomor
	(571,130,130,100,100,100,50,150,70), -- Leech
	(572,100,100,130,130,130,150,130,130), -- Raptor
	(573,100,100,100,100,100,100,130,5), -- Wyrm-Vrtra
	(574,130,5,5,100,100,100,100,100), -- Wyrm-Jormungand
	(575,5,5,100,100,100,130,100,100), -- Wyrm-Tiamat
	(576,50,100,100,100,100,100,100,30), -- Bahamut
	(577,60,60,60,60,60,60,30,30), -- Shinryu
	(578,100,130,70,70,100,30,30,100), -- Sabotender-Florido
	(579,100,100,100,100,100,100,150,5), -- Ghrah
	(580,100,100,100,100,100,100,150,5), -- Ghrah
	(581,100,100,100,100,100,100,150,5); -- Ghrah

-- Update the mob resistance table to bind to an elemental evasion set
-- Update large family blocks
-- Start to fix EEMs
UPDATE `mob_pools` SET `ele_eva_id` = 387 WHERE `familyid` = 258; -- Worm
UPDATE `mob_pools` SET `ele_eva_id` = 388 WHERE `familyid` = 113; -- Fly
UPDATE `mob_pools` SET `ele_eva_id` = 389 WHERE `familyid` = 75; -- Crab
UPDATE `mob_pools` SET `ele_eva_id` = 390 WHERE `familyid` = 206; -- Rabbit
UPDATE `mob_pools` SET `ele_eva_id` = 391 WHERE `familyid` = 80; -- Dhalmel
UPDATE `mob_pools` SET `ele_eva_id` = 392 WHERE `familyid` = 49; -- Beetle
UPDATE `mob_pools` SET `ele_eva_id` = 393 WHERE `familyid` = 79; -- Crawler
UPDATE `mob_pools` SET `ele_eva_id` = 394 WHERE `familyid` = 46; -- Bat
UPDATE `mob_pools` SET `ele_eva_id` = 395 WHERE `familyid` = 47; -- Bat_Trio
UPDATE `mob_pools` SET `ele_eva_id` = 396 WHERE `familyid` = 133; -- Goblin
UPDATE `mob_pools` SET `ele_eva_id` = 397 WHERE `familyid` = 126; -- Gigas
UPDATE `mob_pools` SET `ele_eva_id` = 398 WHERE `familyid` = 174; -- Lizard
UPDATE `mob_pools` SET `ele_eva_id` = 399 WHERE `familyid` = 97; -- Lizard-Ice
UPDATE `mob_pools` SET `ele_eva_id` = 400 WHERE `familyid` = 227; -- Skeleton
UPDATE `mob_pools` SET `ele_eva_id` = 401 WHERE `familyid` = 197; -- Pugil
UPDATE `mob_pools` SET `ele_eva_id` = 402 WHERE `familyid` = 226; -- Sheep
UPDATE `mob_pools` SET `ele_eva_id` = 403 WHERE `familyid` = 55; -- Bird
UPDATE `mob_pools` SET `ele_eva_id` = 404 WHERE `familyid` = 189; -- Orc
UPDATE `mob_pools` SET `ele_eva_id` = 405 WHERE `familyid` = 334; -- Orc-NM
UPDATE `mob_pools` SET `ele_eva_id` = 406 WHERE `familyid` = 235; -- Spider
UPDATE `mob_pools` SET `ele_eva_id` = 407 WHERE `familyid` = 200; -- Quadav
UPDATE `mob_pools` SET `ele_eva_id` = 408 WHERE `familyid` = 337; -- Quadav-NM
UPDATE `mob_pools` SET `ele_eva_id` = 409 WHERE `familyid` = 216; -- Sapling
UPDATE `mob_pools` SET `ele_eva_id` = 410 WHERE `familyid` = 172; -- Leech
UPDATE `mob_pools` SET `ele_eva_id` = 411 WHERE `familyid` = 242; -- Tiger
UPDATE `mob_pools` SET `ele_eva_id` = 412 WHERE `familyid` = 114; -- Flytrap
UPDATE `mob_pools` SET `ele_eva_id` = 413 WHERE `familyid` = 270; -- Yagudo
UPDATE `mob_pools` SET `ele_eva_id` = 414 WHERE `familyid` = 360; -- Yagudo-NM
UPDATE `mob_pools` SET `ele_eva_id` = 415 WHERE `familyid` = 210; -- Raptor
UPDATE `mob_pools` SET `ele_eva_id` = 416 WHERE `familyid` = 377; -- Raptor
UPDATE `mob_pools` SET `ele_eva_id` = 417 WHERE `familyid` = 81; -- Diremite
UPDATE `mob_pools` SET `ele_eva_id` = 418 WHERE `familyid` = 125; -- Greater_Bird
UPDATE `mob_pools` SET `ele_eva_id` = 419 WHERE `familyid` = 251; -- Uragnite
UPDATE `mob_pools` SET `ele_eva_id` = 420 WHERE `familyid` = 110; -- Evil_Weapon
UPDATE `mob_pools` SET `ele_eva_id` = 421 WHERE `familyid` = 71; -- Coeurl
UPDATE `mob_pools` SET `ele_eva_id` = 422 WHERE `familyid` = 99; -- Elemental-Air
UPDATE `mob_pools` SET `ele_eva_id` = 423 WHERE `familyid` = 100; -- Elemental-Dark
UPDATE `mob_pools` SET `ele_eva_id` = 424 WHERE `familyid` = 101; -- Elemental-Earth
UPDATE `mob_pools` SET `ele_eva_id` = 425 WHERE `familyid` = 102; -- Elemental-Fire
UPDATE `mob_pools` SET `ele_eva_id` = 426 WHERE `familyid` = 103; -- Elemental-Ice
UPDATE `mob_pools` SET `ele_eva_id` = 427 WHERE `familyid` = 104; -- Elemental-Light
UPDATE `mob_pools` SET `ele_eva_id` = 428 WHERE `familyid` = 105; -- Elemental-Lightning
UPDATE `mob_pools` SET `ele_eva_id` = 429 WHERE `familyid` = 106; -- Elemental-Water
UPDATE `mob_pools` SET `ele_eva_id` = 430 WHERE `familyid` = 178; -- Mandragora
UPDATE `mob_pools` SET `ele_eva_id` = 431 WHERE `familyid` = 25; -- Antica
UPDATE `mob_pools` SET `ele_eva_id` = 432 WHERE `familyid` = 116; -- Funguar
UPDATE `mob_pools` SET `ele_eva_id` = 433 WHERE `familyid` = 26; -- Antlion
UPDATE `mob_pools` SET `ele_eva_id` = 434 WHERE `familyid` = 3; -- Aern
UPDATE `mob_pools` SET `ele_eva_id` = 435 WHERE `familyid` = 4; -- Ahriman
UPDATE `mob_pools` SET `ele_eva_id` = 436 WHERE `familyid` = 2; -- Adamantoise
UPDATE `mob_pools` SET `ele_eva_id` = 437 WHERE `familyid` = 7; -- AnimatedWeapon-Archery
UPDATE `mob_pools` SET `ele_eva_id` = 438 WHERE `familyid` = 8; -- AnimatedWeapon-Axe
UPDATE `mob_pools` SET `ele_eva_id` = 439 WHERE `familyid` = 9; -- AnimatedWeapon-Club
UPDATE `mob_pools` SET `ele_eva_id` = 440 WHERE `familyid` = 11; -- AnimatedWeapon-Dagger
UPDATE `mob_pools` SET `ele_eva_id` = 441 WHERE `familyid` = 12; -- AnimatedWeapon-Greataxe
UPDATE `mob_pools` SET `ele_eva_id` = 442 WHERE `familyid` = 13; -- AnimatedWeapon-Greatkatana
UPDATE `mob_pools` SET `ele_eva_id` = 443 WHERE `familyid` = 14; -- AnimatedWeapon-Greatsword
UPDATE `mob_pools` SET `ele_eva_id` = 444 WHERE `familyid` = 15; -- AnimatedWeapon-Handtohand
UPDATE `mob_pools` SET `ele_eva_id` = 445 WHERE `familyid` = 16; -- AnimatedWeapon-Instrument
UPDATE `mob_pools` SET `ele_eva_id` = 446 WHERE `familyid` = 17; -- AnimatedWeapon-Katana
UPDATE `mob_pools` SET `ele_eva_id` = 447 WHERE `familyid` = 18; -- AnimatedWeapon-Marksmanship
UPDATE `mob_pools` SET `ele_eva_id` = 448 WHERE `familyid` = 19; -- AnimatedWeapon-Polearm
UPDATE `mob_pools` SET `ele_eva_id` = 449 WHERE `familyid` = 20; -- AnimatedWeapon-Scythe
UPDATE `mob_pools` SET `ele_eva_id` = 450 WHERE `familyid` = 21; -- AnimatedWeapon-Shield
UPDATE `mob_pools` SET `ele_eva_id` = 451 WHERE `familyid` = 23; -- AnimatedWeapon-Staff
UPDATE `mob_pools` SET `ele_eva_id` = 452 WHERE `familyid` = 24; -- AnimatedWeapon-Sword
UPDATE `mob_pools` SET `ele_eva_id` = 453 WHERE `familyid` = 1; -- Acrolith
UPDATE `mob_pools` SET `ele_eva_id` = 454 WHERE `familyid` = 5; -- Amoeban
UPDATE `mob_pools` SET `ele_eva_id` = 455 WHERE `familyid` = 27; -- Apkallu
UPDATE `mob_pools` SET `ele_eva_id` = 456 WHERE `familyid` = 51; -- Behemoth
UPDATE `mob_pools` SET `ele_eva_id` = 457 WHERE `familyid` = 52; -- Bhoot
UPDATE `mob_pools` SET `ele_eva_id` = 458 WHERE `familyid` = 56; -- Bomb
UPDATE `mob_pools` SET `ele_eva_id` = 459 WHERE `familyid` = 57; -- Buffalo
UPDATE `mob_pools` SET `ele_eva_id` = 460 WHERE `familyid` = 58; -- Bugard
UPDATE `mob_pools` SET `ele_eva_id` = 461 WHERE `familyid` = 59; -- Bugbear
UPDATE `mob_pools` SET `ele_eva_id` = 462 WHERE `familyid` = 61; -- Cardian
UPDATE `mob_pools` SET `ele_eva_id` = 463 WHERE `familyid` = 62; -- Cerberus
UPDATE `mob_pools` SET `ele_eva_id` = 465 WHERE `familyid` = 66; -- Slime-Clot
UPDATE `mob_pools` SET `ele_eva_id` = 466 WHERE `familyid` = 67; -- Slime-GlutinousClot
UPDATE `mob_pools` SET `ele_eva_id` = 467 WHERE `familyid` = 68; -- Cluster
UPDATE `mob_pools` SET `ele_eva_id` = 468 WHERE `familyid` = 69; -- Cluster
UPDATE `mob_pools` SET `ele_eva_id` = 469 WHERE `familyid` = 70; -- Cockatrice
UPDATE `mob_pools` SET `ele_eva_id` = 470 WHERE `familyid` = 74; -- Corse
UPDATE `mob_pools` SET `ele_eva_id` = 471 WHERE `familyid` = 76; -- Crab
UPDATE `mob_pools` SET `ele_eva_id` = 472 WHERE `familyid` = 77; -- Crab
UPDATE `mob_pools` SET `ele_eva_id` = 473 WHERE `familyid` = 78; -- Craver
UPDATE `mob_pools` SET `ele_eva_id` = 474 WHERE `familyid` = 83; -- Doll
UPDATE `mob_pools` SET `ele_eva_id` = 475 WHERE `familyid` = 84; -- Doll
UPDATE `mob_pools` SET `ele_eva_id` = 476 WHERE `familyid` = 85; -- Doll
UPDATE `mob_pools` SET `ele_eva_id` = 477 WHERE `familyid` = 86; -- Doomed
UPDATE `mob_pools` SET `ele_eva_id` = 478 WHERE `familyid` = 87; -- Dragon
UPDATE `mob_pools` SET `ele_eva_id` = 479 WHERE `familyid` = 92; -- DynamisStatue-Goblin
UPDATE `mob_pools` SET `ele_eva_id` = 480 WHERE `familyid` = 93; -- DynamisStatue-Orc
UPDATE `mob_pools` SET `ele_eva_id` = 481 WHERE `familyid` = 94; -- DynamisStatue-Quadav
UPDATE `mob_pools` SET `ele_eva_id` = 482 WHERE `familyid` = 95; -- DynamisStatue-Yagudo
UPDATE `mob_pools` SET `ele_eva_id` = 483 WHERE `familyid` = 98; -- Eft
UPDATE `mob_pools` SET `ele_eva_id` = 484 WHERE `familyid` = 107; -- Eruca
UPDATE `mob_pools` SET `ele_eva_id` = 485 WHERE `familyid` = 108; -- Eruca
UPDATE `mob_pools` SET `ele_eva_id` = 486 WHERE `familyid` = 109; -- Euvhi
UPDATE `mob_pools` SET `ele_eva_id` = 487 WHERE `familyid` = 112; -- Flan
UPDATE `mob_pools` SET `ele_eva_id` = 488 WHERE `familyid` = 121; -- Ghost
UPDATE `mob_pools` SET `ele_eva_id` = 489 WHERE `familyid` = 135; -- Golem
UPDATE `mob_pools` SET `ele_eva_id` = 490 WHERE `familyid` = 136; -- Goobbue
UPDATE `mob_pools` SET `ele_eva_id` = 491 WHERE `familyid` = 137; -- Gorger
UPDATE `mob_pools` SET `ele_eva_id` = 492 WHERE `familyid` = 138; -- Gorger
UPDATE `mob_pools` SET `ele_eva_id` = 493 WHERE `familyid` = 139; -- Hecteyes
UPDATE `mob_pools` SET `ele_eva_id` = 494 WHERE `familyid` = 140; -- Hippogryph
UPDATE `mob_pools` SET `ele_eva_id` = 496 WHERE `familyid` = 142; -- Hound
UPDATE `mob_pools` SET `ele_eva_id` = 497 WHERE `familyid` = 143; -- Hound
UPDATE `mob_pools` SET `ele_eva_id` = 498 WHERE `familyid` = 144; -- Hpemde
UPDATE `mob_pools` SET `ele_eva_id` = 509 WHERE `familyid` = 167; -- Karakul
UPDATE `mob_pools` SET `ele_eva_id` = 510 WHERE `familyid` = 169; -- Kindred
UPDATE `mob_pools` SET `ele_eva_id` = 511 WHERE `familyid` = 175; -- Magic_Pot
UPDATE `mob_pools` SET `ele_eva_id` = 512 WHERE `familyid` = 179; -- Manticore
UPDATE `mob_pools` SET `ele_eva_id` = 513 WHERE `familyid` = 180; -- Marid
UPDATE `mob_pools` SET `ele_eva_id` = 514 WHERE `familyid` = 181; -- MemoryReceptacle
UPDATE `mob_pools` SET `ele_eva_id` = 515 WHERE `familyid` = 183; -- Mimic
UPDATE `mob_pools` SET `ele_eva_id` = 516 WHERE `familyid` = 184; -- Moblin
UPDATE `mob_pools` SET `ele_eva_id` = 517 WHERE `familyid` = 186; -- Morbol
UPDATE `mob_pools` SET `ele_eva_id` = 518 WHERE `familyid` = 188; -- Opo-opo
UPDATE `mob_pools` SET `ele_eva_id` = 519 WHERE `familyid` = 190; -- Orc-Warmachine
UPDATE `mob_pools` SET `ele_eva_id` = 520 WHERE `familyid` = 191; -- Orobon
UPDATE `mob_pools` SET `ele_eva_id` = 521 WHERE `familyid` = 192; -- Peiste
UPDATE `mob_pools` SET `ele_eva_id` = 522 WHERE `familyid` = 193; -- Wyvern-Pet
UPDATE `mob_pools` SET `ele_eva_id` = 523 WHERE `familyid` = 194; -- Phuabo
UPDATE `mob_pools` SET `ele_eva_id` = 524 WHERE `familyid` = 201; -- Quadav
UPDATE `mob_pools` SET `ele_eva_id` = 525 WHERE `familyid` = 202; -- Quadav
UPDATE `mob_pools` SET `ele_eva_id` = 526 WHERE `familyid` = 208; -- Ram
UPDATE `mob_pools` SET `ele_eva_id` = 527 WHERE `familyid` = 212; -- Sabotender
UPDATE `mob_pools` SET `ele_eva_id` = 528 WHERE `familyid` = 213; -- Sahagin
UPDATE `mob_pools` SET `ele_eva_id` = 529 WHERE `familyid` = 217; -- Scorpion
UPDATE `mob_pools` SET `ele_eva_id` = 530 WHERE `familyid` = 218; -- Sea_Monk
UPDATE `mob_pools` SET `ele_eva_id` = 531 WHERE `familyid` = 219; -- Sea_Monk
UPDATE `mob_pools` SET `ele_eva_id` = 532 WHERE `familyid` = 220; -- Seether
UPDATE `mob_pools` SET `ele_eva_id` = 533 WHERE `familyid` = 221; -- Shadow
UPDATE `mob_pools` SET `ele_eva_id` = 534 WHERE `familyid` = 222; -- Shadow
UPDATE `mob_pools` SET `ele_eva_id` = 535 WHERE `familyid` = 223; -- Shadow
UPDATE `mob_pools` SET `ele_eva_id` = 536 WHERE `familyid` = 224; -- ShadowLord
UPDATE `mob_pools` SET `ele_eva_id` = 537 WHERE `familyid` = 225; -- ShadowLord
UPDATE `mob_pools` SET `ele_eva_id` = 538 WHERE `familyid` = 228; -- Slime
UPDATE `mob_pools` SET `ele_eva_id` = 539 WHERE `familyid` = 229; -- Slime
UPDATE `mob_pools` SET `ele_eva_id` = 540 WHERE `familyid` = 230; -- Slime
UPDATE `mob_pools` SET `ele_eva_id` = 541 WHERE `familyid` = 234; -- Spheroid
UPDATE `mob_pools` SET `ele_eva_id` = 543 WHERE `familyid` = 240; -- Tauri
UPDATE `mob_pools` SET `ele_eva_id` = 544 WHERE `familyid` = 241; -- Thinker
UPDATE `mob_pools` SET `ele_eva_id` = 545 WHERE `familyid` = 243; -- Tonberry
UPDATE `mob_pools` SET `ele_eva_id` = 546 WHERE `familyid` = 244; -- Tonberry
UPDATE `mob_pools` SET `ele_eva_id` = 547 WHERE `familyid` = 245; -- Treant
UPDATE `mob_pools` SET `ele_eva_id` = 548 WHERE `familyid` = 255; -- Wanderer
UPDATE `mob_pools` SET `ele_eva_id` = 549 WHERE `familyid` = 256; -- Weeper
UPDATE `mob_pools` SET `ele_eva_id` = 550 WHERE `familyid` = 259; -- Wyrm-Ouryu
UPDATE `mob_pools` SET `ele_eva_id` = 551 WHERE `familyid` = 260; -- Wyrm-Fafnir
UPDATE `mob_pools` SET `ele_eva_id` = 552 WHERE `familyid` = 261; -- Wyrm-Cynoprosopi
UPDATE `mob_pools` SET `ele_eva_id` = 553 WHERE `familyid` = 262; -- Wyrm
UPDATE `mob_pools` SET `ele_eva_id` = 554 WHERE `familyid` = 263; -- Wyrm-Nidhogg
UPDATE `mob_pools` SET `ele_eva_id` = 555 WHERE `familyid` = 264; -- Wyrm
UPDATE `mob_pools` SET `ele_eva_id` = 556 WHERE `familyid` = 266; -- Wyvern-Pet
UPDATE `mob_pools` SET `ele_eva_id` = 557 WHERE `familyid` = 267; -- Wyvern-Guivre
UPDATE `mob_pools` SET `ele_eva_id` = 558 WHERE `familyid` = 269; -- Xzomit
UPDATE `mob_pools` SET `ele_eva_id` = 559 WHERE `familyid` = 271; -- Yovra
UPDATE `mob_pools` SET `ele_eva_id` = 560 WHERE `familyid` = 272; -- Zdei
UPDATE `mob_pools` SET `ele_eva_id` = 561 WHERE `familyid` = 352; -- ArkAngel-EV
UPDATE `mob_pools` SET `ele_eva_id` = 562 WHERE `familyid` = 353; -- ArkAngel-GK
UPDATE `mob_pools` SET `ele_eva_id` = 563 WHERE `familyid` = 354; -- ArkAngel-HM
UPDATE `mob_pools` SET `ele_eva_id` = 564 WHERE `familyid` = 355; -- ArkAngel-MR
UPDATE `mob_pools` SET `ele_eva_id` = 565 WHERE `familyid` = 356; -- ArkAngel-TT
UPDATE `mob_pools` SET `ele_eva_id` = 566 WHERE `familyid` = 273; -- Scorpion-Serket
UPDATE `mob_pools` SET `ele_eva_id` = 567 WHERE `familyid` = 274; -- Scorpion-KingV
UPDATE `mob_pools` SET `ele_eva_id` = 568 WHERE `familyid` = 336; -- Tonberry-ZM4
UPDATE `mob_pools` SET `ele_eva_id` = 569 WHERE `familyid` = 358; -- Kindred
UPDATE `mob_pools` SET `ele_eva_id` = 570 WHERE `familyid` = 359; -- Fomor
UPDATE `mob_pools` SET `ele_eva_id` = 571 WHERE `familyid` = 369; -- Leech
UPDATE `mob_pools` SET `ele_eva_id` = 572 WHERE `familyid` = 376; -- Raptor
UPDATE `mob_pools` SET `ele_eva_id` = 573 WHERE `familyid` = 391; -- Wyrm-Vrtra
UPDATE `mob_pools` SET `ele_eva_id` = 574 WHERE `familyid` = 392; -- Wyrm-Jormungand
UPDATE `mob_pools` SET `ele_eva_id` = 575 WHERE `familyid` = 393; -- Wyrm-Tiamat
UPDATE `mob_pools` SET `ele_eva_id` = 576 WHERE `familyid` = 449; -- Bahamut
UPDATE `mob_pools` SET `ele_eva_id` = 577 WHERE `familyid` = 475; -- Shinryu
UPDATE `mob_pools` SET `ele_eva_id` = 578 WHERE `familyid` = 362; -- Sabotender-Florido
UPDATE `mob_pools` SET `ele_eva_id` = 579 WHERE `familyid` = 122; -- Ghrah
UPDATE `mob_pools` SET `ele_eva_id` = 580 WHERE `familyid` = 123; -- Ghrah
UPDATE `mob_pools` SET `ele_eva_id` = 581 WHERE `familyid` = 124; -- Ghrah


-- Update individual pools

UPDATE `mob_pools` SET `ele_eva_id` = 89 WHERE `poolid` = 21; -- Absolute Virtue
UPDATE `mob_pools` SET `ele_eva_id` = 283 WHERE `poolid` = 4692; -- Abununnu
UPDATE `mob_pools` SET `ele_eva_id` = 233 WHERE `poolid` = 26; -- Abyssobugard
UPDATE `mob_pools` SET `ele_eva_id` = 360 WHERE `poolid` = 4677; -- Achuka
UPDATE `mob_pools` SET `ele_eva_id` = 200 WHERE `poolid` = 0; -- Acrimonious Dullahan
UPDATE `mob_pools` SET `ele_eva_id` = 189 WHERE `poolid` = 39; -- Acrolith
UPDATE `mob_pools` SET `ele_eva_id` = 209 WHERE `poolid` = 43; -- Adamantking Effigy
UPDATE `mob_pools` SET `ele_eva_id` = 304 WHERE `poolid` = 44; -- Adamantoise
UPDATE `mob_pools` SET `ele_eva_id` = 214 WHERE `poolid` = 4720; -- Aello
UPDATE `mob_pools` SET `ele_eva_id` = 35 WHERE `poolid` = 6152; -- Aerns Wynav
UPDATE `mob_pools` SET `ele_eva_id` = 321 WHERE `poolid` = 4701; -- Agathos
UPDATE `mob_pools` SET `ele_eva_id` = 278 WHERE `poolid` = 74; -- Ajattara
UPDATE `mob_pools` SET `ele_eva_id` = 304 WHERE `poolid` = 4684; -- Akupara
UPDATE `mob_pools` SET `ele_eva_id` = 160 WHERE `poolid` = 5162; -- Akvan
UPDATE `mob_pools` SET `ele_eva_id` = 269 WHERE `poolid` = 5605; -- Albumen
UPDATE `mob_pools` SET `ele_eva_id` = 343 WHERE `poolid` = 82; -- Alexander
UPDATE `mob_pools` SET `ele_eva_id` = 350 WHERE `poolid` = 83; -- Alfard
UPDATE `mob_pools` SET `ele_eva_id` = 164 WHERE `poolid` = 87; -- Alkyoneus
UPDATE `mob_pools` SET `ele_eva_id` = 124 WHERE `poolid` = 125; -- Ancient Quadav
UPDATE `mob_pools` SET `ele_eva_id` = 60 WHERE `poolid` = 133; -- Andhrimnir
UPDATE `mob_pools` SET `ele_eva_id` = 265 WHERE `poolid` = 142; -- Anguis
UPDATE `mob_pools` SET `ele_eva_id` = 148 WHERE `poolid` = 5099; -- Animosiraptor
UPDATE `mob_pools` SET `ele_eva_id` = 74 WHERE `poolid` = 165; -- Antica Aedilis
UPDATE `mob_pools` SET `ele_eva_id` = 74 WHERE `poolid` = 190; -- Antica Triarius
UPDATE `mob_pools` SET `ele_eva_id` = 341 WHERE `poolid` = 195; -- Apademak
UPDATE `mob_pools` SET `ele_eva_id` = 50 WHERE `poolid` = 5006; -- Appetent Umbril
UPDATE `mob_pools` SET `ele_eva_id` = 60 WHERE `poolid` = 225; -- Arch Corse
UPDATE `mob_pools` SET `ele_eva_id` = 221 WHERE `poolid` = 6059; -- Arch Dynamis Lord
UPDATE `mob_pools` SET `ele_eva_id` = 259 WHERE `poolid` = 216; -- Archaic Chariot
UPDATE `mob_pools` SET `ele_eva_id` = 175 WHERE `poolid` = 218; -- Archaic Gear
UPDATE `mob_pools` SET `ele_eva_id` = 175 WHERE `poolid` = 219; -- Archaic Gears
UPDATE `mob_pools` SET `ele_eva_id` = 14 WHERE `poolid` = 221; -- Archaic Rampart
UPDATE `mob_pools` SET `ele_eva_id` = 274 WHERE `poolid` = 5496; -- Arciela
UPDATE `mob_pools` SET `ele_eva_id` = 374 WHERE `poolid` = 5965; -- Arciela
UPDATE `mob_pools` SET `ele_eva_id` = 263 WHERE `poolid` = 234; -- Ariri Samariri
UPDATE `mob_pools` SET `ele_eva_id` = 164 WHERE `poolid` = 5993; -- Ark Angel EV
UPDATE `mob_pools` SET `ele_eva_id` = 222 WHERE `poolid` = 235; -- Ark Angel EV
UPDATE `mob_pools` SET `ele_eva_id` = 223 WHERE `poolid` = 236; -- Ark Angel GK
UPDATE `mob_pools` SET `ele_eva_id` = 244 WHERE `poolid` = 237; -- Ark Angel HM
UPDATE `mob_pools` SET `ele_eva_id` = 224 WHERE `poolid` = 238; -- Ark Angel MR
UPDATE `mob_pools` SET `ele_eva_id` = 227 WHERE `poolid` = 242; -- Ark Angel TT
UPDATE `mob_pools` SET `ele_eva_id` = 256 WHERE `poolid` = 246; -- Armored Chariot
UPDATE `mob_pools` SET `ele_eva_id` = 216 WHERE `poolid` = 253; -- Arrapago Apkallu
UPDATE `mob_pools` SET `ele_eva_id` = 12 WHERE `poolid` = 4809; -- Ashen Tiger
UPDATE `mob_pools` SET `ele_eva_id` = 325 WHERE `poolid` = 5554; -- Ashmaker Gotblut
UPDATE `mob_pools` SET `ele_eva_id` = 311 WHERE `poolid` = 5506; -- Ashrakk
UPDATE `mob_pools` SET `ele_eva_id` = 254 WHERE `poolid` = 5073; -- Asperous Marolith
UPDATE `mob_pools` SET `ele_eva_id` = 304 WHERE `poolid` = 268; -- Aspidochelone
UPDATE `mob_pools` SET `ele_eva_id` = 13 WHERE `poolid` = 5248; -- Astringent Acuex
UPDATE `mob_pools` SET `ele_eva_id` = 332 WHERE `poolid` = 5984; -- August
UPDATE `mob_pools` SET `ele_eva_id` = 252 WHERE `poolid` = 289; -- Aura Statue
UPDATE `mob_pools` SET `ele_eva_id` = 7 WHERE `poolid` = 299; -- Aweuvhi
UPDATE `mob_pools` SET `ele_eva_id` = 158 WHERE `poolid` = 300; -- Awghrah
UPDATE `mob_pools` SET `ele_eva_id` = 252 WHERE `poolid` = 301; -- Awzdei
UPDATE `mob_pools` SET `ele_eva_id` = 371 WHERE `poolid` = 323; -- Baelfyr
UPDATE `mob_pools` SET `ele_eva_id` = 308 WHERE `poolid` = 325; -- Bahamut
UPDATE `mob_pools` SET `ele_eva_id` = 271 WHERE `poolid` = 5505; -- Balamor
UPDATE `mob_pools` SET `ele_eva_id` = 271 WHERE `poolid` = 5983; -- Balamor
UPDATE `mob_pools` SET `ele_eva_id` = 43 WHERE `poolid` = 6443; -- Balas Bats
UPDATE `mob_pools` SET `ele_eva_id` = 1 WHERE `poolid` = 334; -- Balrahn
UPDATE `mob_pools` SET `ele_eva_id` = 120 WHERE `poolid` = 344; -- Bark Tarantula
UPDATE `mob_pools` SET `ele_eva_id` = 23 WHERE `poolid` = 5047; -- Barnacle Crab
UPDATE `mob_pools` SET `ele_eva_id` = 221 WHERE `poolid` = 6056; -- Baron Avnas
UPDATE `mob_pools` SET `ele_eva_id` = 259 WHERE `poolid` = 365; -- Battleclad Chariot
UPDATE `mob_pools` SET `ele_eva_id` = 44 WHERE `poolid` = 378; -- Beach Bunny
UPDATE `mob_pools` SET `ele_eva_id` = 187 WHERE `poolid` = 5027; -- Beady Panopt
UPDATE `mob_pools` SET `ele_eva_id` = 54 WHERE `poolid` = 4803; -- Bedraggled Lucerewe
UPDATE `mob_pools` SET `ele_eva_id` = 252 WHERE `poolid` = 387; -- Behemoth
UPDATE `mob_pools` SET `ele_eva_id` = 30 WHERE `poolid` = 5009; -- Belaboring Wasp
UPDATE `mob_pools` SET `ele_eva_id` = 78 WHERE `poolid` = 5097; -- Bellicose Tarichuk
UPDATE `mob_pools` SET `ele_eva_id` = 291 WHERE `poolid` = 5152; -- Belphoebe
UPDATE `mob_pools` SET `ele_eva_id` = 176 WHERE `poolid` = 392; -- Benumbed Vodoriga
UPDATE `mob_pools` SET `ele_eva_id` = 218 WHERE `poolid` = 396; -- Berserker Demon
UPDATE `mob_pools` SET `ele_eva_id` = 291 WHERE `poolid` = 4688; -- Bhishani
UPDATE `mob_pools` SET `ele_eva_id` = 23 WHERE `poolid` = 413; -- Bigclaw
UPDATE `mob_pools` SET `ele_eva_id` = 275 WHERE `poolid` = 5002; -- Bight Uragnite
UPDATE `mob_pools` SET `ele_eva_id` = 230 WHERE `poolid` = 4669; -- Bismarck
UPDATE `mob_pools` SET `ele_eva_id` = 2 WHERE `poolid` = 5001; -- Blanched Mandragora
UPDATE `mob_pools` SET `ele_eva_id` = 66 WHERE `poolid` = 453; -- Blizzard Gigas
UPDATE `mob_pools` SET `ele_eva_id` = 41 WHERE `poolid` = 469; -- Blood Ball
UPDATE `mob_pools` SET `ele_eva_id` = 312 WHERE `poolid` = 516; -- Bo'Dho Hundredfist
UPDATE `mob_pools` SET `ele_eva_id` = 192 WHERE `poolid` = 4734; -- Botulus Rex
UPDATE `mob_pools` SET `ele_eva_id` = 31 WHERE `poolid` = 4580; -- Boulder Eater
UPDATE `mob_pools` SET `ele_eva_id` = 290 WHERE `poolid` = 30000; -- Bozetto Breadwinner
UPDATE `mob_pools` SET `ele_eva_id` = 263 WHERE `poolid` = 5207; -- Brekekekex
UPDATE `mob_pools` SET `ele_eva_id` = 28 WHERE `poolid` = 5028; -- Broad Scarlet
UPDATE `mob_pools` SET `ele_eva_id` = 90 WHERE `poolid` = 4934; -- Bronzecap
UPDATE `mob_pools` SET `ele_eva_id` = 105 WHERE `poolid` = 547; -- Brunhilde
UPDATE `mob_pools` SET `ele_eva_id` = 91 WHERE `poolid` = 561; -- Bugbear Deathsman
UPDATE `mob_pools` SET `ele_eva_id` = 146 WHERE `poolid` = 5023; -- Burning Mantis
UPDATE `mob_pools` SET `ele_eva_id` = 331 WHERE `poolid` = 592; -- Byakko
UPDATE `mob_pools` SET `ele_eva_id` = 215 WHERE `poolid` = 593; -- Byrgen
UPDATE `mob_pools` SET `ele_eva_id` = 253 WHERE `poolid` = 5775; -- Cait Sith
UPDATE `mob_pools` SET `ele_eva_id` = 121 WHERE `poolid` = 5022; -- Canopycrusher Beetle
UPDATE `mob_pools` SET `ele_eva_id` = 216 WHERE `poolid` = 4987; -- Canyon Apkallu
UPDATE `mob_pools` SET `ele_eva_id` = 52 WHERE `poolid` = 630; -- Capricious Cassie
UPDATE `mob_pools` SET `ele_eva_id` = 352 WHERE `poolid` = 636; -- Carbuncle Prime
UPDATE `mob_pools` SET `ele_eva_id` = 133 WHERE `poolid` = 5007; -- Careening Twitherym
UPDATE `mob_pools` SET `ele_eva_id` = 149 WHERE `poolid` = 662; -- Cave Antlion
UPDATE `mob_pools` SET `ele_eva_id` = 214 WHERE `poolid` = 6890; -- Celaeno
UPDATE `mob_pools` SET `ele_eva_id` = 266 WHERE `poolid` = 6821; -- Cetus
UPDATE `mob_pools` SET `ele_eva_id` = 27 WHERE `poolid` = 4930; -- Cheeky Opo-opo
UPDATE `mob_pools` SET `ele_eva_id` = 201 WHERE `poolid` = 6939; -- Cherti
UPDATE `mob_pools` SET `ele_eva_id` = 180 WHERE `poolid` = 5208; -- Chorus Toad
UPDATE `mob_pools` SET `ele_eva_id` = 59 WHERE `poolid` = 4807; -- Cicatricose Raaz
UPDATE `mob_pools` SET `ele_eva_id` = 177 WHERE `poolid` = 729; -- Cirein-croin
UPDATE `mob_pools` SET `ele_eva_id` = 180 WHERE `poolid` = 4989; -- Cliffclinger Toad
UPDATE `mob_pools` SET `ele_eva_id` = 299 WHERE `poolid` = 4819; -- Cloud of Darkness
UPDATE `mob_pools` SET `ele_eva_id` = 128 WHERE `poolid` = 752; -- Coastal Sahagin
UPDATE `mob_pools` SET `ele_eva_id` = 98 WHERE `poolid` = 761; -- Cogtooth Skagnogg
UPDATE `mob_pools` SET `ele_eva_id` = 258 WHERE `poolid` = 4927; -- Colkhab
UPDATE `mob_pools` SET `ele_eva_id` = 129 WHERE `poolid` = 5016; -- Colossal Spider
UPDATE `mob_pools` SET `ele_eva_id` = 28 WHERE `poolid` = 5342; -- Condor
UPDATE `mob_pools` SET `ele_eva_id` = 221 WHERE `poolid` = 775; -- Confederate Belfry
UPDATE `mob_pools` SET `ele_eva_id` = 49 WHERE `poolid` = 4938; -- Corpse Flower
UPDATE `mob_pools` SET `ele_eva_id` = 164 WHERE `poolid` = 4656; -- Cottus
UPDATE `mob_pools` SET `ele_eva_id` = 204 WHERE `poolid` = 4767; -- Crackling Ungeweder
UPDATE `mob_pools` SET `ele_eva_id` = 21 WHERE `poolid` = 6643; -- Craver
UPDATE `mob_pools` SET `ele_eva_id` = 273 WHERE `poolid` = 5579; -- Crom Dubh
UPDATE `mob_pools` SET `ele_eva_id` = 73 WHERE `poolid` = 854; -- Cryptonberry Plaguer
UPDATE `mob_pools` SET `ele_eva_id` = 182 WHERE `poolid` = 882; -- Cyhiraeth
UPDATE `mob_pools` SET `ele_eva_id` = 301 WHERE `poolid` = 5934; -- D. Shantotto
UPDATE `mob_pools` SET `ele_eva_id` = 315 WHERE `poolid` = 894; -- Dahak
UPDATE `mob_pools` SET `ele_eva_id` = 158 WHERE `poolid` = 913; -- Dark Elemental
UPDATE `mob_pools` SET `ele_eva_id` = 326 WHERE `poolid` = 904; -- Darkheir Grradhod
UPDATE `mob_pools` SET `ele_eva_id` = 124 WHERE `poolid` = 907; -- Darksteel Quadav
UPDATE `mob_pools` SET `ele_eva_id` = 56 WHERE `poolid` = 5499; -- Darrcuiln
UPDATE `mob_pools` SET `ele_eva_id` = 193 WHERE `poolid` = 5582; -- Dazzling Dolores
UPDATE `mob_pools` SET `ele_eva_id` = 193 WHERE `poolid` = 5582; -- Dazzling Dolores
UPDATE `mob_pools` SET `ele_eva_id` = 102 WHERE `poolid` = 5004; -- Deathmaw Orobon
UPDATE `mob_pools` SET `ele_eva_id` = 128 WHERE `poolid` = 965; -- Delta Sahagin
UPDATE `mob_pools` SET `ele_eva_id` = 5 WHERE `poolid` = 978; -- Demonic Rose
UPDATE `mob_pools` SET `ele_eva_id` = 47 WHERE `poolid` = 1006; -- Desert Dhalmel
UPDATE `mob_pools` SET `ele_eva_id` = 185 WHERE `poolid` = 1020; -- Dextrose
UPDATE `mob_pools` SET `ele_eva_id` = 261 WHERE `poolid` = 5500; -- Dhokmak
UPDATE `mob_pools` SET `ele_eva_id` = 220 WHERE `poolid` = 1027; -- Diabolos
UPDATE `mob_pools` SET `ele_eva_id` = 312 WHERE `poolid` = 1066; -- Di'Dha Adamantfist
UPDATE `mob_pools` SET `ele_eva_id` = 196 WHERE `poolid` = 5198; -- Dimgruzub
UPDATE `mob_pools` SET `ele_eva_id` = 85 WHERE `poolid` = 1043; -- Diremite Stalker
UPDATE `mob_pools` SET `ele_eva_id` = 160 WHERE `poolid` = 6607; -- Doom Lens
UPDATE `mob_pools` SET `ele_eva_id` = 28 WHERE `poolid` = 5017; -- Downy Emerald
UPDATE `mob_pools` SET `ele_eva_id` = 35 WHERE `poolid` = 1112; -- Draugar's Wyvern
UPDATE `mob_pools` SET `ele_eva_id` = 268 WHERE `poolid` = 6987; -- Duke Vepar
UPDATE `mob_pools` SET `ele_eva_id` = 69 WHERE `poolid` = 5250; -- Dullahan
UPDATE `mob_pools` SET `ele_eva_id` = 182 WHERE `poolid` = 1150; -- Dybbuk
UPDATE `mob_pools` SET `ele_eva_id` = 221 WHERE `poolid` = 1154; -- Dynamis Lord
UPDATE `mob_pools` SET `ele_eva_id` = 221 WHERE `poolid` = 1158; -- Eald'narche
UPDATE `mob_pools` SET `ele_eva_id` = 147 WHERE `poolid` = 1160; -- Earth Elemental
UPDATE `mob_pools` SET `ele_eva_id` = 107 WHERE `poolid` = 1170; -- Ebony Pudding
UPDATE `mob_pools` SET `ele_eva_id` = 51 WHERE `poolid` = 1191; -- Elder Goobbue
UPDATE `mob_pools` SET `ele_eva_id` = 234 WHERE `poolid` = 1192; -- Elder Quadav
UPDATE `mob_pools` SET `ele_eva_id` = 46 WHERE `poolid` = 1193; -- Elder Treant
UPDATE `mob_pools` SET `ele_eva_id` = 369 WHERE `poolid` = 1197; -- Elemental Gyves
UPDATE `mob_pools` SET `ele_eva_id` = 239 WHERE `poolid` = 1258; -- Escarp Murex
UPDATE `mob_pools` SET `ele_eva_id` = 42 WHERE `poolid` = 5429; -- Eschan Jewelweed
UPDATE `mob_pools` SET `ele_eva_id` = 79 WHERE `poolid` = 5543; -- Eschan Mosquito
UPDATE `mob_pools` SET `ele_eva_id` = 257 WHERE `poolid` = 5632; -- Eschan Porxie
UPDATE `mob_pools` SET `ele_eva_id` = 221 WHERE `poolid` = 1270; -- Exoplates
UPDATE `mob_pools` SET `ele_eva_id` = 37 WHERE `poolid` = 1271; -- Exoray
UPDATE `mob_pools` SET `ele_eva_id` = 213 WHERE `poolid` = 1272; -- Experimental Lamia
UPDATE `mob_pools` SET `ele_eva_id` = 277 WHERE `poolid` = 6750; -- Fahrafahr the Bloodied
UPDATE `mob_pools` SET `ele_eva_id` = 226 WHERE `poolid` = 1301; -- Farfadet
UPDATE `mob_pools` SET `ele_eva_id` = 210 WHERE `poolid` = 4859; -- Felsic Eruca
UPDATE `mob_pools` SET `ele_eva_id` = 282 WHERE `poolid` = 1322; -- Fenrir
UPDATE `mob_pools` SET `ele_eva_id` = 136 WHERE `poolid` = 5005; -- Fernfelling Chapuli
UPDATE `mob_pools` SET `ele_eva_id` = 55 WHERE `poolid` = 1338; -- Fighting Smilodon
UPDATE `mob_pools` SET `ele_eva_id` = 379 WHERE `poolid` = 1341; -- Fire Elemental
UPDATE `mob_pools` SET `ele_eva_id` = 383 WHERE `poolid` = 4737; -- Firedance Magmaal Ja
UPDATE `mob_pools` SET `ele_eva_id` = 336 WHERE `poolid` = 6814; -- Fjalar
UPDATE `mob_pools` SET `ele_eva_id` = 28 WHERE `poolid` = 1360; -- Flamingo
UPDATE `mob_pools` SET `ele_eva_id` = 353 WHERE `poolid` = 5720; -- Fleetstalker
UPDATE `mob_pools` SET `ele_eva_id` = 31 WHERE `poolid` = 1369; -- Flesh Eater
UPDATE `mob_pools` SET `ele_eva_id` = 48 WHERE `poolid` = 5000; -- Fluffy Sheep
UPDATE `mob_pools` SET `ele_eva_id` = 133 WHERE `poolid` = 5243; -- Flutrurini
UPDATE `mob_pools` SET `ele_eva_id` = 65 WHERE `poolid` = 1390; -- Fomor Samurai
UPDATE `mob_pools` SET `ele_eva_id` = 164 WHERE `poolid` = 1422; -- Freke
UPDATE `mob_pools` SET `ele_eva_id` = 146 WHERE `poolid` = 5008; -- Frenzied Mantis
UPDATE `mob_pools` SET `ele_eva_id` = 43 WHERE `poolid` = 6424; -- Funnel Bats
UPDATE `mob_pools` SET `ele_eva_id` = 176 WHERE `poolid` = 1462; -- Gargouille
UPDATE `mob_pools` SET `ele_eva_id` = 250 WHERE `poolid` = 1463; -- Gargoyle
UPDATE `mob_pools` SET `ele_eva_id` = 365 WHERE `poolid` = 1473; -- Garuda Prime
UPDATE `mob_pools` SET `ele_eva_id` = 345 WHERE `poolid` = 4647; -- Garuda Prime
UPDATE `mob_pools` SET `ele_eva_id` = 103 WHERE `poolid` = 5179; -- Gasha
UPDATE `mob_pools` SET `ele_eva_id` = 363 WHERE `poolid` = 1491; -- Genbu
UPDATE `mob_pools` SET `ele_eva_id` = 241 WHERE `poolid` = 5838; -- Gessho
UPDATE `mob_pools` SET `ele_eva_id` = 313 WHERE `poolid` = 1548; -- Gigadaphnia
UPDATE `mob_pools` SET `ele_eva_id` = 233 WHERE `poolid` = 1549; -- Gigantobugard
UPDATE `mob_pools` SET `ele_eva_id` = 252 WHERE `poolid` = 1558; -- Gigas Deckhand
UPDATE `mob_pools` SET `ele_eva_id` = 152 WHERE `poolid` = 1573; -- Gigas Martialist
UPDATE `mob_pools` SET `ele_eva_id` = 6 WHERE `poolid` = 1602; -- Gilagoge Tlugvi
UPDATE `mob_pools` SET `ele_eva_id` = 117 WHERE `poolid` = 5178; -- Giltine
UPDATE `mob_pools` SET `ele_eva_id` = 82 WHERE `poolid` = 4964; -- Glutinous Clot
UPDATE `mob_pools` SET `ele_eva_id` = 238 WHERE `poolid` = 4808; -- Gnarring Yztarg
UPDATE `mob_pools` SET `ele_eva_id` = 99 WHERE `poolid` = 1628; -- Gnat
UPDATE `mob_pools` SET `ele_eva_id` = 34 WHERE `poolid` = 1637; -- Goblin Bandit
UPDATE `mob_pools` SET `ele_eva_id` = 34 WHERE `poolid` = 1687; -- Goblin Mercenary
UPDATE `mob_pools` SET `ele_eva_id` = 86 WHERE `poolid` = 1707; -- Goblin Replica
UPDATE `mob_pools` SET `ele_eva_id` = 162 WHERE `poolid` = 1713; -- Goblin Skirmisher
UPDATE `mob_pools` SET `ele_eva_id` = 91 WHERE `poolid` = 1719; -- Goblin Swordman
UPDATE `mob_pools` SET `ele_eva_id` = 333 WHERE `poolid` = 5580; -- Golden Kist
UPDATE `mob_pools` SET `ele_eva_id` = 123 WHERE `poolid` = 6644; -- Gorger
UPDATE `mob_pools` SET `ele_eva_id` = 339 WHERE `poolid` = 1769; -- Gorgimera
UPDATE `mob_pools` SET `ele_eva_id` = 211 WHERE `poolid` = 1773; -- Gotoh Zha the Redolent
UPDATE `mob_pools` SET `ele_eva_id` = 96 WHERE `poolid` = 1793; -- Grauberg Hippogryph
UPDATE `mob_pools` SET `ele_eva_id` = 246 WHERE `poolid` = 1800; -- Greater Amphiptere
UPDATE `mob_pools` SET `ele_eva_id` = 43 WHERE `poolid` = 5080; -- Grossular Bat
UPDATE `mob_pools` SET `ele_eva_id` = 250 WHERE `poolid` = 1827; -- Groundkeeper
UPDATE `mob_pools` SET `ele_eva_id` = 68 WHERE `poolid` = 1833; -- Guard Bhoot
UPDATE `mob_pools` SET `ele_eva_id` = 295 WHERE `poolid` = 5150; -- Gugalanna
UPDATE `mob_pools` SET `ele_eva_id` = 319 WHERE `poolid` = 1846; -- Gulool Ja Ja
UPDATE `mob_pools` SET `ele_eva_id` = 354 WHERE `poolid` = 1851; -- Gurfurlur the Menacing
UPDATE `mob_pools` SET `ele_eva_id` = 267 WHERE `poolid` = 5163; -- Gwynn ap Nudd
UPDATE `mob_pools` SET `ele_eva_id` = 300 WHERE `poolid` = 5495; -- Hades
UPDATE `mob_pools` SET `ele_eva_id` = 300 WHERE `poolid` = 5497; -- Hades
UPDATE `mob_pools` SET `ele_eva_id` = 252 WHERE `poolid` = 1872; -- Hadhayosh
UPDATE `mob_pools` SET `ele_eva_id` = 194 WHERE `poolid` = 5164; -- Hahava
UPDATE `mob_pools` SET `ele_eva_id` = 112 WHERE `poolid` = 4806; -- Hailstone
UPDATE `mob_pools` SET `ele_eva_id` = 17 WHERE `poolid` = 1898; -- Hati
UPDATE `mob_pools` SET `ele_eva_id` = 36 WHERE `poolid` = 6388; -- Hecteyes
UPDATE `mob_pools` SET `ele_eva_id` = 381 WHERE `poolid` = 1931; -- Henchman Moogle
UPDATE `mob_pools` SET `ele_eva_id` = 95 WHERE `poolid` = 1933; -- Heraldic Imp
UPDATE `mob_pools` SET `ele_eva_id` = 277 WHERE `poolid` = 1952; -- Hilltroll Ranger
UPDATE `mob_pools` SET `ele_eva_id` = 277 WHERE `poolid` = 1954; -- Hilltroll Warrior
UPDATE `mob_pools` SET `ele_eva_id` = 53 WHERE `poolid` = 5095; -- Hoary Craklaw
UPDATE `mob_pools` SET `ele_eva_id` = 183 WHERE `poolid` = 6847; -- Holy Moly
UPDATE `mob_pools` SET `ele_eva_id` = 134 WHERE `poolid` = 2013; -- Hunting Raptor
UPDATE `mob_pools` SET `ele_eva_id` = 318 WHERE `poolid` = 4678; -- Hurkan
UPDATE `mob_pools` SET `ele_eva_id` = 350 WHERE `poolid` = 2018; -- Hydra
UPDATE `mob_pools` SET `ele_eva_id` = 65 WHERE `poolid` = 2035; -- Hydra Warrior
UPDATE `mob_pools` SET `ele_eva_id` = 21 WHERE `poolid` = 2043; -- Ice Elemental
UPDATE `mob_pools` SET `ele_eva_id` = 386 WHERE `poolid` = 2050; -- Ifrit Prime
UPDATE `mob_pools` SET `ele_eva_id` = 292 WHERE `poolid` = 4693; -- Ig-Alima
UPDATE `mob_pools` SET `ele_eva_id` = 310 WHERE `poolid` = 2051; -- Ignidrake
UPDATE `mob_pools` SET `ele_eva_id` = 284 WHERE `poolid` = 2052; -- Ignis Djinn
UPDATE `mob_pools` SET `ele_eva_id` = 59 WHERE `poolid` = 5370; -- Indomitable Faaz
UPDATE `mob_pools` SET `ele_eva_id` = 279 WHERE `poolid` = 2075; -- Indrik
UPDATE `mob_pools` SET `ele_eva_id` = 171 WHERE `poolid` = 5714; -- Ionos
UPDATE `mob_pools` SET `ele_eva_id` = 335 WHERE `poolid` = 5287; -- Iron Cranium
UPDATE `mob_pools` SET `ele_eva_id` = 335 WHERE `poolid` = 5288; -- Iron Cranium
UPDATE `mob_pools` SET `ele_eva_id` = 335 WHERE `poolid` = 5258; -- Ironclad
UPDATE `mob_pools` SET `ele_eva_id` = 335 WHERE `poolid` = 5290; -- Ironclad Vaporizer
UPDATE `mob_pools` SET `ele_eva_id` = 44 WHERE `poolid` = 2107; -- Island Rarab
UPDATE `mob_pools` SET `ele_eva_id` = 252 WHERE `poolid` = 2114; -- Ix'zdei
UPDATE `mob_pools` SET `ele_eva_id` = 62 WHERE `poolid` = 2154; -- Jnun
UPDATE `mob_pools` SET `ele_eva_id` = 71 WHERE `poolid` = 2156; -- Jormungand
UPDATE `mob_pools` SET `ele_eva_id` = 152 WHERE `poolid` = 2159; -- Jotunn Hallkeeper
UPDATE `mob_pools` SET `ele_eva_id` = 19 WHERE `poolid` = 6588; -- Kaboom
UPDATE `mob_pools` SET `ele_eva_id` = 194 WHERE `poolid` = 4708; -- Kalasutrax
UPDATE `mob_pools` SET `ele_eva_id` = 285 WHERE `poolid` = 2184; -- Kam'lanaut
UPDATE `mob_pools` SET `ele_eva_id` = 249 WHERE `poolid` = 2194; -- Karkadann
UPDATE `mob_pools` SET `ele_eva_id` = 130 WHERE `poolid` = 2195; -- Karkatakam
UPDATE `mob_pools` SET `ele_eva_id` = 95 WHERE `poolid` = 5233; -- Keep Imp
UPDATE `mob_pools` SET `ele_eva_id` = 312 WHERE `poolid` = 2224; -- Khroma Quadav
UPDATE `mob_pools` SET `ele_eva_id` = 340 WHERE `poolid` = 2223; -- Khromasoul Bhurborlor
UPDATE `mob_pools` SET `ele_eva_id` = 159 WHERE `poolid` = 6619; -- Kindred Dark Knight
UPDATE `mob_pools` SET `ele_eva_id` = 35 WHERE `poolid` = 2247; -- Kindred's Wyvern
UPDATE `mob_pools` SET `ele_eva_id` = 110 WHERE `poolid` = 2256; -- King Buffalo
UPDATE `mob_pools` SET `ele_eva_id` = 336 WHERE `poolid` = 2257; -- King Goldemar
UPDATE `mob_pools` SET `ele_eva_id` = 322 WHERE `poolid` = 2265; -- Kirin
UPDATE `mob_pools` SET `ele_eva_id` = 35 WHERE `poolid` = 5064; -- Knotted Root
UPDATE `mob_pools` SET `ele_eva_id` = 24 WHERE `poolid` = 5213; -- Kopffussler
UPDATE `mob_pools` SET `ele_eva_id` = 2 WHERE `poolid` = 2282; -- Korrigan
UPDATE `mob_pools` SET `ele_eva_id` = 272 WHERE `poolid` = 4799; -- Kumhau
UPDATE `mob_pools` SET `ele_eva_id` = 25 WHERE `poolid` = 2381; -- La Vaule Pugil
UPDATE `mob_pools` SET `ele_eva_id` = 166 WHERE `poolid` = 2316; -- Lady Lilith
UPDATE `mob_pools` SET `ele_eva_id` = 76 WHERE `poolid` = 2318; -- Lahama
UPDATE `mob_pools` SET `ele_eva_id` = 75 WHERE `poolid` = 2332; -- Lamia Fatedealer
UPDATE `mob_pools` SET `ele_eva_id` = 276 WHERE `poolid` = 2370; -- Lancelord Gaheel Ja
UPDATE `mob_pools` SET `ele_eva_id` = 276 WHERE `poolid` = 2370; -- Lancelord Gaheel Ja
UPDATE `mob_pools` SET `ele_eva_id` = 133 WHERE `poolid` = 4979; -- Leafdancer Twitherym
UPDATE `mob_pools` SET `ele_eva_id` = 382 WHERE `poolid` = 2402; -- Leviathan Prime
UPDATE `mob_pools` SET `ele_eva_id` = 377 WHERE `poolid` = 4646; -- Leviathan Prime
UPDATE `mob_pools` SET `ele_eva_id` = 168 WHERE `poolid` = 2413; -- Light Elemental
UPDATE `mob_pools` SET `ele_eva_id` = 289 WHERE `poolid` = 2416; -- Lilith Ascendant
UPDATE `mob_pools` SET `ele_eva_id` = 106 WHERE `poolid` = 2428; -- Lobison
UPDATE `mob_pools` SET `ele_eva_id` = 259 WHERE `poolid` = 2431; -- Long-armed Chariot
UPDATE `mob_pools` SET `ele_eva_id` = 259 WHERE `poolid` = 2433; -- Long-Bowed Chariot
UPDATE `mob_pools` SET `ele_eva_id` = 80 WHERE `poolid` = 4990; -- Longface Colibri
UPDATE `mob_pools` SET `ele_eva_id` = 82 WHERE `poolid` = 5311; -- Lorbulcrud
UPDATE `mob_pools` SET `ele_eva_id` = 298 WHERE `poolid` = 5189; -- Lord Asag
UPDATE `mob_pools` SET `ele_eva_id` = 139 WHERE `poolid` = 5386; -- Lucani
UPDATE `mob_pools` SET `ele_eva_id` = 122 WHERE `poolid` = 2450; -- Lumber Jack
UPDATE `mob_pools` SET `ele_eva_id` = 39 WHERE `poolid` = 2456; -- Lycopodium
UPDATE `mob_pools` SET `ele_eva_id` = 141 WHERE `poolid` = 2458; -- Lynx
UPDATE `mob_pools` SET `ele_eva_id` = 252 WHERE `poolid` = 2479; -- Magic Millstone
UPDATE `mob_pools` SET `ele_eva_id` = 262 WHERE `poolid` = 2489; -- Mahjlaef the Paintorn
UPDATE `mob_pools` SET `ele_eva_id` = 375 WHERE `poolid` = 6793; -- Maju
UPDATE `mob_pools` SET `ele_eva_id` = 155 WHERE `poolid` = 2500; -- Mammet - 22 Zeta
UPDATE `mob_pools` SET `ele_eva_id` = 135 WHERE `poolid` = 2508; -- Mamool Ja Bounder
UPDATE `mob_pools` SET `ele_eva_id` = 135 WHERE `poolid` = 2533; -- Mamool Ja Savant
UPDATE `mob_pools` SET `ele_eva_id` = 35 WHERE `poolid` = 2541; -- Mamool Ja's Wyvern
UPDATE `mob_pools` SET `ele_eva_id` = 77 WHERE `poolid` = 5122; -- Manifest Icon
UPDATE `mob_pools` SET `ele_eva_id` = 142 WHERE `poolid` = 2562; -- Marid
UPDATE `mob_pools` SET `ele_eva_id` = 140 WHERE `poolid` = 2564; -- Mariehene
UPDATE `mob_pools` SET `ele_eva_id` = 328 WHERE `poolid` = 2606; -- Medusa
UPDATE `mob_pools` SET `ele_eva_id` = 170 WHERE `poolid` = 4683; -- Melancholic Moira
UPDATE `mob_pools` SET `ele_eva_id` = 164 WHERE `poolid` = 6647; -- Memory Receptacle
UPDATE `mob_pools` SET `ele_eva_id` = 97 WHERE `poolid` = 2619; -- Merrow Chantress
UPDATE `mob_pools` SET `ele_eva_id` = 31 WHERE `poolid` = 6421; -- Metalcruncher Worm
UPDATE `mob_pools` SET `ele_eva_id` = 251 WHERE `poolid` = 4820; -- Metus
UPDATE `mob_pools` SET `ele_eva_id` = 164 WHERE `poolid` = 4725; -- Mimic Mage
UPDATE `mob_pools` SET `ele_eva_id` = 264 WHERE `poolid` = 5300; -- Mingyi
UPDATE `mob_pools` SET `ele_eva_id` = 91 WHERE `poolid` = 2684; -- Moblin Aidman
UPDATE `mob_pools` SET `ele_eva_id` = 91 WHERE `poolid` = 2702; -- Moblin Roadman
UPDATE `mob_pools` SET `ele_eva_id` = 91 WHERE `poolid` = 2704; -- Moblin Scalpelman
UPDATE `mob_pools` SET `ele_eva_id` = 87 WHERE `poolid` = 2721; -- Molech
UPDATE `mob_pools` SET `ele_eva_id` = 245 WHERE `poolid` = 1247; -- Moo Ouzi the Swiftblade
UPDATE `mob_pools` SET `ele_eva_id` = 163 WHERE `poolid` = 5501; -- Morimar
UPDATE `mob_pools` SET `ele_eva_id` = 184 WHERE `poolid` = 4668; -- Morta
UPDATE `mob_pools` SET `ele_eva_id` = 181 WHERE `poolid` = 2753; -- Mosshorn
UPDATE `mob_pools` SET `ele_eva_id` = 169 WHERE `poolid` = 4956; -- Mountain Peiste
UPDATE `mob_pools` SET `ele_eva_id` = 207 WHERE `poolid` = 2760; -- Mountain Scolopendrid
UPDATE `mob_pools` SET `ele_eva_id` = 26 WHERE `poolid` = 4578; -- Mourning Crawler
UPDATE `mob_pools` SET `ele_eva_id` = 73 WHERE `poolid` = 5312; -- Murk-veined Baneberry
UPDATE `mob_pools` SET `ele_eva_id` = 119 WHERE `poolid` = 6332; -- Mushussu
UPDATE `mob_pools` SET `ele_eva_id` = 6 WHERE `poolid` = 4940; -- Nascent Sapling
UPDATE `mob_pools` SET `ele_eva_id` = 346 WHERE `poolid` = 6794; -- Neak
UPDATE `mob_pools` SET `ele_eva_id` = 157 WHERE `poolid` = 6726; -- Neith
UPDATE `mob_pools` SET `ele_eva_id` = 63 WHERE `poolid` = 2891; -- Nitro Cluster
UPDATE `mob_pools` SET `ele_eva_id` = 11 WHERE `poolid` = 2892; -- Nival Raptor
UPDATE `mob_pools` SET `ele_eva_id` = 270 WHERE `poolid` = 5716; -- Nosoi
UPDATE `mob_pools` SET `ele_eva_id` = 41 WHERE `poolid` = 5249; -- Obfuscous Obdella
UPDATE `mob_pools` SET `ele_eva_id` = 187 WHERE `poolid` = 5367; -- Obstreperous Panopt
UPDATE `mob_pools` SET `ele_eva_id` = 214 WHERE `poolid` = 4679; -- Ocythoe
UPDATE `mob_pools` SET `ele_eva_id` = 158 WHERE `poolid` = 2942; -- Odin Image
UPDATE `mob_pools` SET `ele_eva_id` = 344 WHERE `poolid` = 2941; -- Odin Prime
UPDATE `mob_pools` SET `ele_eva_id` = 149 WHERE `poolid` = 5161; -- Ogbunabali
UPDATE `mob_pools` SET `ele_eva_id` = 3 WHERE `poolid` = 2957; -- Oil Slick
UPDATE `mob_pools` SET `ele_eva_id` = 89 WHERE `poolid` = 6206; -- Om'aern
UPDATE `mob_pools` SET `ele_eva_id` = 155 WHERE `poolid` = 2973; -- Omega
UPDATE `mob_pools` SET `ele_eva_id` = 125 WHERE `poolid` = 2976; -- Om'hpemde
UPDATE `mob_pools` SET `ele_eva_id` = 38 WHERE `poolid` = 2977; -- Om'phuabo
UPDATE `mob_pools` SET `ele_eva_id` = 40 WHERE `poolid` = 2978; -- Om'xzomit
UPDATE `mob_pools` SET `ele_eva_id` = 153 WHERE `poolid` = 2979; -- Om'yovra
UPDATE `mob_pools` SET `ele_eva_id` = 325 WHERE `poolid` = 6759; -- One-eyed Gwajboj
UPDATE `mob_pools` SET `ele_eva_id` = 217 WHERE `poolid` = 4140; -- Orcish Bugler
UPDATE `mob_pools` SET `ele_eva_id` = 148 WHERE `poolid` = 3000; -- Orcish Champion
UPDATE `mob_pools` SET `ele_eva_id` = 247 WHERE `poolid` = 5230; -- Orcish Dreadnought
UPDATE `mob_pools` SET `ele_eva_id` = 148 WHERE `poolid` = 3007; -- Orcish Dreadnought
UPDATE `mob_pools` SET `ele_eva_id` = 148 WHERE `poolid` = 3019; -- Orcish Hexspinner
UPDATE `mob_pools` SET `ele_eva_id` = 148 WHERE `poolid` = 3027; -- Orcish Overlord
UPDATE `mob_pools` SET `ele_eva_id` = 4 WHERE `poolid` = 3034; -- Orcish Stonelauncher
UPDATE `mob_pools` SET `ele_eva_id` = 325 WHERE `poolid` = 3037; -- Orcish Strongarm
UPDATE `mob_pools` SET `ele_eva_id` = 325 WHERE `poolid` = 3040; -- Orcish Turret
UPDATE `mob_pools` SET `ele_eva_id` = 384 WHERE `poolid` = 3061; -- Orthrus
UPDATE `mob_pools` SET `ele_eva_id` = 31 WHERE `poolid` = 3946; -- Ossuary Worm
UPDATE `mob_pools` SET `ele_eva_id` = 150 WHERE `poolid` = 3070; -- Ouryu
UPDATE `mob_pools` SET `ele_eva_id` = 9 WHERE `poolid` = 3078; -- Over Weapon
UPDATE `mob_pools` SET `ele_eva_id` = 323 WHERE `poolid` = 3075; -- Overlord Bakgodek
UPDATE `mob_pools` SET `ele_eva_id` = 39 WHERE `poolid` = 3082; -- Pachypodium
UPDATE `mob_pools` SET `ele_eva_id` = 266 WHERE `poolid` = 5688; -- Pakecet
UPDATE `mob_pools` SET `ele_eva_id` = 347 WHERE `poolid` = 5674; -- Palila
UPDATE `mob_pools` SET `ele_eva_id` = 172 WHERE `poolid` = 4711; -- Pancimanci
UPDATE `mob_pools` SET `ele_eva_id` = 336 WHERE `poolid` = 3090; -- Pandemonium Warden
UPDATE `mob_pools` SET `ele_eva_id` = 23 WHERE `poolid` = 5096; -- Perfidious Crab
UPDATE `mob_pools` SET `ele_eva_id` = 18 WHERE `poolid` = 4962; -- Playful Leafkin
UPDATE `mob_pools` SET `ele_eva_id` = 44 WHERE `poolid` = 3168; -- Polar Hare
UPDATE `mob_pools` SET `ele_eva_id` = 180 WHERE `poolid` = 3177; -- Poroggo
UPDATE `mob_pools` SET `ele_eva_id` = 221 WHERE `poolid` = 3199; -- Prishe
UPDATE `mob_pools` SET `ele_eva_id` = 26 WHERE `poolid` = 3200; -- Processionaire
UPDATE `mob_pools` SET `ele_eva_id` = 251 WHERE `poolid` = 3205; -- Promathia
UPDATE `mob_pools` SET `ele_eva_id` = 248 WHERE `poolid` = 3210; -- Protoamoeban
UPDATE `mob_pools` SET `ele_eva_id` = 156 WHERE `poolid` = 3208; -- Proto-Omega
UPDATE `mob_pools` SET `ele_eva_id` = 155 WHERE `poolid` = 3209; -- Proto-Ultima
UPDATE `mob_pools` SET `ele_eva_id` = 286 WHERE `poolid` = 4654; -- Provenance Watcher
UPDATE `mob_pools` SET `ele_eva_id` = 81 WHERE `poolid` = 3223; -- Puk
UPDATE `mob_pools` SET `ele_eva_id` = 83 WHERE `poolid` = 3254; -- Qiqirn Goldsmith
UPDATE `mob_pools` SET `ele_eva_id` = 92 WHERE `poolid` = 5103; -- Qohanyk
UPDATE `mob_pools` SET `ele_eva_id` = 312 WHERE `poolid` = 3277; -- Quadav Turret
UPDATE `mob_pools` SET `ele_eva_id` = 64 WHERE `poolid` = 3294; -- Qutrub
UPDATE `mob_pools` SET `ele_eva_id` = 381 WHERE `poolid` = 3317; -- Ramuh Prime
UPDATE `mob_pools` SET `ele_eva_id` = 57 WHERE `poolid` = 6575; -- Reserve Draugar
UPDATE `mob_pools` SET `ele_eva_id` = 140 WHERE `poolid` = 5015; -- Resplendent Luckybug
UPDATE `mob_pools` SET `ele_eva_id` = 1 WHERE `poolid` = 3367; -- Riko Kupenreich
UPDATE `mob_pools` SET `ele_eva_id` = 3 WHERE `poolid` = 4986; -- Riverscum
UPDATE `mob_pools` SET `ele_eva_id` = 180 WHERE `poolid` = 5093; -- Riverwashed Toad
UPDATE `mob_pools` SET `ele_eva_id` = 203 WHERE `poolid` = 3376; -- Roc
UPDATE `mob_pools` SET `ele_eva_id` = 186 WHERE `poolid` = 5147; -- Roly-Poly
UPDATE `mob_pools` SET `ele_eva_id` = 116 WHERE `poolid` = 4709; -- Rw Nw Prt M Hrw
UPDATE `mob_pools` SET `ele_eva_id` = 29 WHERE `poolid` = 3426; -- Sabotender
UPDATE `mob_pools` SET `ele_eva_id` = 137 WHERE `poolid` = 6851; -- Sabotender Campeador
UPDATE `mob_pools` SET `ele_eva_id` = 306 WHERE `poolid` = 3446; -- Saltopus
UPDATE `mob_pools` SET `ele_eva_id` = 121 WHERE `poolid` = 3450; -- Sand Beetle
UPDATE `mob_pools` SET `ele_eva_id` = 124 WHERE `poolid` = 7037; -- Sapphire Quadav
UPDATE `mob_pools` SET `ele_eva_id` = 8 WHERE `poolid` = 4948; -- Saptrap
UPDATE `mob_pools` SET `ele_eva_id` = 164 WHERE `poolid` = 3465; -- Sarameya
UPDATE `mob_pools` SET `ele_eva_id` = 160 WHERE `poolid` = 5325; -- Scowlenkos
UPDATE `mob_pools` SET `ele_eva_id` = 94 WHERE `poolid` = 4969; -- Scummy Slug
UPDATE `mob_pools` SET `ele_eva_id` = 119 WHERE `poolid` = 5012; -- Sedge Scorpion
UPDATE `mob_pools` SET `ele_eva_id` = 164 WHERE `poolid` = 3529; -- Seed Crystal
UPDATE `mob_pools` SET `ele_eva_id` = 379 WHERE `poolid` = 6648; -- Seether
UPDATE `mob_pools` SET `ele_eva_id` = 305 WHERE `poolid` = 3540; -- Seiryu
UPDATE `mob_pools` SET `ele_eva_id` = 45 WHERE `poolid` = 5715; -- Sensual Sandy
UPDATE `mob_pools` SET `ele_eva_id` = 217 WHERE `poolid` = 3548; -- Serjeant Tombstone
UPDATE `mob_pools` SET `ele_eva_id` = 131 WHERE `poolid` = 3549; -- Serket
UPDATE `mob_pools` SET `ele_eva_id` = 252 WHERE `poolid` = 3575; -- Shadow Dragon
UPDATE `mob_pools` SET `ele_eva_id` = 164 WHERE `poolid` = 3579; -- Shadow Lord
UPDATE `mob_pools` SET `ele_eva_id` = 165 WHERE `poolid` = 4593; -- Shadow Lord
UPDATE `mob_pools` SET `ele_eva_id` = 164 WHERE `poolid` = 3580; -- Shadow of Rage
UPDATE `mob_pools` SET `ele_eva_id` = 111 WHERE `poolid` = 4804; -- Shaggy Ovim
UPDATE `mob_pools` SET `ele_eva_id` = 264 WHERE `poolid` = 4667; -- Shah
UPDATE `mob_pools` SET `ele_eva_id` = 362 WHERE `poolid` = 3584; -- Shantotto
UPDATE `mob_pools` SET `ele_eva_id` = 164 WHERE `poolid` = 3600; -- Shikaree Y
UPDATE `mob_pools` SET `ele_eva_id` = 287 WHERE `poolid` = 3604; -- Shinryu
UPDATE `mob_pools` SET `ele_eva_id` = 22 WHERE `poolid` = 3607; -- Shiva Prime
UPDATE `mob_pools` SET `ele_eva_id` = 229 WHERE `poolid` = 5721; -- Shockmaw
UPDATE `mob_pools` SET `ele_eva_id` = 167 WHERE `poolid` = 4748; -- Shy Heartwing
UPDATE `mob_pools` SET `ele_eva_id` = 179 WHERE `poolid` = 5104; -- Sinewy Matamata
UPDATE `mob_pools` SET `ele_eva_id` = 320 WHERE `poolid` = 6170; -- Siren
UPDATE `mob_pools` SET `ele_eva_id` = 32 WHERE `poolid` = 3648; -- Skewer Sam
UPDATE `mob_pools` SET `ele_eva_id` = 109 WHERE `poolid` = 4971; -- Skinsipper Chigoe
UPDATE `mob_pools` SET `ele_eva_id` = 113 WHERE `poolid` = 4735; -- Smierc
UPDATE `mob_pools` SET `ele_eva_id` = 81 WHERE `poolid` = 4577; -- Snaggletooth Peapuk
UPDATE `mob_pools` SET `ele_eva_id` = 42 WHERE `poolid` = 4946; -- Snapweed
UPDATE `mob_pools` SET `ele_eva_id` = 58 WHERE `poolid` = 3689; -- Snow Lizard
UPDATE `mob_pools` SET `ele_eva_id` = 120 WHERE `poolid` = 3701; -- Son of Anansi
UPDATE `mob_pools` SET `ele_eva_id` = 245 WHERE `poolid` = 3703; -- Soo Luma the Ascended
UPDATE `mob_pools` SET `ele_eva_id` = 30 WHERE `poolid` = 3707; -- Soul Stinger
UPDATE `mob_pools` SET `ele_eva_id` = 178 WHERE `poolid` = 3704; -- Soulflayer
UPDATE `mob_pools` SET `ele_eva_id` = 15 WHERE `poolid` = 3710; -- Southern Spriggan
UPDATE `mob_pools` SET `ele_eva_id` = 73 WHERE `poolid` = 3711; -- Sozu Bliberry
UPDATE `mob_pools` SET `ele_eva_id` = 10 WHERE `poolid` = 3720; -- Spartoi Warrior
UPDATE `mob_pools` SET `ele_eva_id` = 154 WHERE `poolid` = 3722; -- Spectator
UPDATE `mob_pools` SET `ele_eva_id` = 252 WHERE `poolid` = 3744; -- Sprinkler
UPDATE `mob_pools` SET `ele_eva_id` = 67 WHERE `poolid` = 5437; -- Spurned Nightstalker
UPDATE `mob_pools` SET `ele_eva_id` = 164 WHERE `poolid` = 3798; -- Sturdy Pyxis
UPDATE `mob_pools` SET `ele_eva_id` = 120 WHERE `poolid` = 5071; -- Subterrane Spider
UPDATE `mob_pools` SET `ele_eva_id` = 364 WHERE `poolid` = 3816; -- Suzaku
UPDATE `mob_pools` SET `ele_eva_id` = 305 WHERE `poolid` = 3817; -- Svelldrake
UPDATE `mob_pools` SET `ele_eva_id` = 63 WHERE `poolid` = 3825; -- Sweeping Cluster
UPDATE `mob_pools` SET `ele_eva_id` = 108 WHERE `poolid` = 4933; -- Swollen Chigoe
UPDATE `mob_pools` SET `ele_eva_id` = 307 WHERE `poolid` = 5180; -- Tangaroa
UPDATE `mob_pools` SET `ele_eva_id` = 228 WHERE `poolid` = 3845; -- Tarbotaur
UPDATE `mob_pools` SET `ele_eva_id` = 101 WHERE `poolid` = 3853; -- Tavnazian Ram
UPDATE `mob_pools` SET `ele_eva_id` = 359 WHERE `poolid` = 4925; -- Tchakka
UPDATE `mob_pools` SET `ele_eva_id` = 35 WHERE `poolid` = 3876; -- Ten of Batons
UPDATE `mob_pools` SET `ele_eva_id` = 35 WHERE `poolid` = 3875; -- Tenzen
UPDATE `mob_pools` SET `ele_eva_id` = 296 WHERE `poolid` = 5986; -- Teodor
UPDATE `mob_pools` SET `ele_eva_id` = 118 WHERE `poolid` = 5101; -- Tephra Lizard
UPDATE `mob_pools` SET `ele_eva_id` = 147 WHERE `poolid` = 6649; -- Thinker
UPDATE `mob_pools` SET `ele_eva_id` = 151 WHERE `poolid` = 3912; -- Thunder Elemental
UPDATE `mob_pools` SET `ele_eva_id` = 380 WHERE `poolid` = 3916; -- Tiamat
UPDATE `mob_pools` SET `ele_eva_id` = 281 WHERE `poolid` = 3922; -- Tinnin
UPDATE `mob_pools` SET `ele_eva_id` = 378 WHERE `poolid` = 3931; -- Titan Prime
UPDATE `mob_pools` SET `ele_eva_id` = 73 WHERE `poolid` = 3959; -- Tonberry Imprecator
UPDATE `mob_pools` SET `ele_eva_id` = 33 WHERE `poolid` = 3976; -- Torama
UPDATE `mob_pools` SET `ele_eva_id` = 149 WHERE `poolid` = 3983; -- Tracker Antlion
UPDATE `mob_pools` SET `ele_eva_id` = 164 WHERE `poolid` = 3992; -- Treasure Chest
UPDATE `mob_pools` SET `ele_eva_id` = 20 WHERE `poolid` = 4972; -- Treefrost Gefyrst
UPDATE `mob_pools` SET `ele_eva_id` = 88 WHERE `poolid` = 4035; -- Troll's Automaton
UPDATE `mob_pools` SET `ele_eva_id` = 242 WHERE `poolid` = 6739; -- Tsui-Goab
UPDATE `mob_pools` SET `ele_eva_id` = 303 WHERE `poolid` = 4999; -- Tulfaire
UPDATE `mob_pools` SET `ele_eva_id` = 78 WHERE `poolid` = 4957; -- Tundra Eft
UPDATE `mob_pools` SET `ele_eva_id` = 118 WHERE `poolid` = 5069; -- Tunnel Lizard
UPDATE `mob_pools` SET `ele_eva_id` = 44 WHERE `poolid` = 5003; -- Twigtrip Lapinion
UPDATE `mob_pools` SET `ele_eva_id` = 43 WHERE `poolid` = 4984; -- Twilight Bat
UPDATE `mob_pools` SET `ele_eva_id` = 138 WHERE `poolid` = 4072; -- Tzee Xicu the Manifest
UPDATE `mob_pools` SET `ele_eva_id` = 6 WHERE `poolid` = 4077; -- Ulagohvsdi Tlugvi
UPDATE `mob_pools` SET `ele_eva_id` = 324 WHERE `poolid` = 4080; -- Ulhuadshi
UPDATE `mob_pools` SET `ele_eva_id` = 30 WHERE `poolid` = 5010; -- Undergrowth Hornet
UPDATE `mob_pools` SET `ele_eva_id` = 225 WHERE `poolid` = 4101; -- Unseelie
UPDATE `mob_pools` SET `ele_eva_id` = 194 WHERE `poolid` = 4719; -- Uptala
UPDATE `mob_pools` SET `ele_eva_id` = 356 WHERE `poolid` = 5722; -- Urmahlullu
UPDATE `mob_pools` SET `ele_eva_id` = 255 WHERE `poolid` = 6820; -- Ushumgal
UPDATE `mob_pools` SET `ele_eva_id` = 302 WHERE `poolid` = 4125; -- Valley Manticore
UPDATE `mob_pools` SET `ele_eva_id` = 41 WHERE `poolid` = 4966; -- Vampire Leech
UPDATE `mob_pools` SET `ele_eva_id` = 297 WHERE `poolid` = 4130; -- Vampyr Jarl
UPDATE `mob_pools` SET `ele_eva_id` = 173 WHERE `poolid` = 5191; -- Vanasarvik
UPDATE `mob_pools` SET `ele_eva_id` = 77 WHERE `poolid` = 4137; -- Vanguard Assasin
UPDATE `mob_pools` SET `ele_eva_id` = 209 WHERE `poolid` = 4146; -- Vanguard Drakekeeper
UPDATE `mob_pools` SET `ele_eva_id` = 219 WHERE `poolid` = 4149; -- Vanguard Eye (Dynamis - Xarcabard)
UPDATE `mob_pools` SET `ele_eva_id` = 209 WHERE `poolid` = 4164; -- Vanguard Minstrel
UPDATE `mob_pools` SET `ele_eva_id` = 217 WHERE `poolid` = 4172; -- Vanguard Pillager
UPDATE `mob_pools` SET `ele_eva_id` = 77 WHERE `poolid` = 4176; -- Vanguard Priest
UPDATE `mob_pools` SET `ele_eva_id` = 86 WHERE `poolid` = 4179; -- Vanguard Ronin
UPDATE `mob_pools` SET `ele_eva_id` = 86 WHERE `poolid` = 4182; -- Vanguard Shaman
UPDATE `mob_pools` SET `ele_eva_id` = 36 WHERE `poolid` = 4187; -- Vanguard's Hecteyes
UPDATE `mob_pools` SET `ele_eva_id` = 35 WHERE `poolid` = 4190; -- Vanguard's Wyvern
UPDATE `mob_pools` SET `ele_eva_id` = 231 WHERE `poolid` = 6581; -- Varkolak
UPDATE `mob_pools` SET `ele_eva_id` = 245 WHERE `poolid` = 4212; -- Vee Qiqa the Decreer
UPDATE `mob_pools` SET `ele_eva_id` = 190 WHERE `poolid` = 4216; -- Veld Clionid
UPDATE `mob_pools` SET `ele_eva_id` = 132 WHERE `poolid` = 4968; -- Velkk Destructeur
UPDATE `mob_pools` SET `ele_eva_id` = 132 WHERE `poolid` = 4967; -- Velkk Sage
UPDATE `mob_pools` SET `ele_eva_id` = 148 WHERE `poolid` = 4218; -- Velociraptor
UPDATE `mob_pools` SET `ele_eva_id` = 6 WHERE `poolid` = 5034; -- Verdant Treant
UPDATE `mob_pools` SET `ele_eva_id` = 173 WHERE `poolid` = 4221; -- Verdelet
UPDATE `mob_pools` SET `ele_eva_id` = 324 WHERE `poolid` = 4533; -- Vermes Carnium
UPDATE `mob_pools` SET `ele_eva_id` = 115 WHERE `poolid` = 5989; -- Vir'ava
UPDATE `mob_pools` SET `ele_eva_id` = 205 WHERE `poolid` = 4960; -- Volcanic Wivre
UPDATE `mob_pools` SET `ele_eva_id` = 99 WHERE `poolid` = 4974; -- Vorst Gnat
UPDATE `mob_pools` SET `ele_eva_id` = 161 WHERE `poolid` = 4261; -- Vrtra
UPDATE `mob_pools` SET `ele_eva_id` = 366 WHERE `poolid` = 4280; -- Wamoura
UPDATE `mob_pools` SET `ele_eva_id` = 206 WHERE `poolid` = 4282; -- Wamoura Prince
UPDATE `mob_pools` SET `ele_eva_id` = 21 WHERE `poolid` = 4283; -- Wanderer
UPDATE `mob_pools` SET `ele_eva_id` = 121 WHERE `poolid` = 6072; -- Warden Beetle
UPDATE `mob_pools` SET `ele_eva_id` = 288 WHERE `poolid` = 5697; -- Warder of Courage
UPDATE `mob_pools` SET `ele_eva_id` = 252 WHERE `poolid` = 5698; -- Warder's Wynav
UPDATE `mob_pools` SET `ele_eva_id` = 368 WHERE `poolid` = 4309; -- Water Elemental
UPDATE `mob_pools` SET `ele_eva_id` = 158 WHERE `poolid` = 6652; -- Weeper
UPDATE `mob_pools` SET `ele_eva_id` = 104 WHERE `poolid` = 4342; -- Wild Karakul
UPDATE `mob_pools` SET `ele_eva_id` = 123 WHERE `poolid` = 71; -- Wind Elemental
UPDATE `mob_pools` SET `ele_eva_id` = 126 WHERE `poolid` = 4355; -- Wivre
UPDATE `mob_pools` SET `ele_eva_id` = 17 WHERE `poolid` = 4379; -- Wraith
UPDATE `mob_pools` SET `ele_eva_id` = 380 WHERE `poolid` = 4385; -- Wyrm
UPDATE `mob_pools` SET `ele_eva_id` = 28 WHERE `poolid` = 4418; -- Yagudo Flagellant
UPDATE `mob_pools` SET `ele_eva_id` = 245 WHERE `poolid` = 4420; -- Yagudo Genja
UPDATE `mob_pools` SET `ele_eva_id` = 144 WHERE `poolid` = 4436; -- Yagudo Nokizaru
UPDATE `mob_pools` SET `ele_eva_id` = 28 WHERE `poolid` = 5494; -- Yagudo Prelate
UPDATE `mob_pools` SET `ele_eva_id` = 245 WHERE `poolid` = 4458; -- Yagudo Turret
UPDATE `mob_pools` SET `ele_eva_id` = 334 WHERE `poolid` = 5596; -- Yakshi
UPDATE `mob_pools` SET `ele_eva_id` = 174 WHERE `poolid` = 6755; -- Yalungur
UPDATE `mob_pools` SET `ele_eva_id` = 208 WHERE `poolid` = 4703; -- Yatagarasu
UPDATE `mob_pools` SET `ele_eva_id` = 198 WHERE `poolid` = 4926; -- Yumcax
UPDATE `mob_pools` SET `ele_eva_id` = 164 WHERE `poolid` = 4498; -- Zeid
UPDATE `mob_pools` SET `ele_eva_id` = 232 WHERE `poolid` = 5598; -- Zerde
UPDATE `mob_pools` SET `ele_eva_id` = 84 WHERE `poolid` = 4508; -- Ziz
UPDATE `mob_pools` SET `ele_eva_id` = 25 WHERE `poolid` = 5094; -- Zoldeff Jagil

UNLOCK TABLES;
