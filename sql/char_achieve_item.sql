--
-- Structure de la table `char_achieve_item`
--

DROP TABLE IF EXISTS `char_achieve_item`;
CREATE TABLE `char_achieve_item` (
	`charid` INT(10) UNSIGNED NOT NULL,
	`itemId` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '65535',
	`timecreated` TIMESTAMP NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
	PRIMARY KEY (`charid`, `itemId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=85;
