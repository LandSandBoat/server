
DROP TABLE IF EXISTS `audit_chat`;
CREATE TABLE `audit_chat` (
    `lineID` INT(10) NOT NULL AUTO_INCREMENT,
    `speaker` TINYTEXT NOT NULL,
    `type` TINYTEXT NOT NULL,
    `lsName` TINYTEXT NULL,
    `zoneid` smallint(3) unsigned NULL,
    `unity` tinyint(4) NULL,
    `recipient` TINYTEXT NULL,
    `message` BLOB,
    `datetime` DATETIME NOT NULL,
    PRIMARY KEY (`lineID`)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
