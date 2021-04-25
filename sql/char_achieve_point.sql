--
-- Structure de la table `char_achieve_point`
--

DROP TABLE IF EXISTS `char_achieve_point`;
CREATE TABLE `char_achieve_point` (
	`charid` INT(10) UNSIGNED NOT NULL,
	`totalPoint` INT(10) UNSIGNED NOT NULL,
	`nowPoint` INT(10) UNSIGNED NOT NULL,
	PRIMARY KEY (`charid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=85;
