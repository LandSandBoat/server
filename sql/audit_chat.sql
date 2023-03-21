
DROP TABLE IF EXISTS `audit_chat`;
CREATE TABLE `audit_chat` (
    `lineID` INT(10) NOT NULL AUTO_INCREMENT,
    `speaker` TINYTEXT NOT NULL,
    `type` TINYTEXT NOT NULL,
    `lsName` TINYTEXT NULL,
    `recipient` TINYTEXT NULL,
    `message` BLOB,
    `datetime` DATETIME NOT NULL,
    PRIMARY KEY (`lineID`)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
