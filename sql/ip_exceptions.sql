DROP TABLE IF EXISTS `ip_exceptions`;
CREATE TABLE IF NOT EXISTS `ip_exceptions` (
    `accid` int(10) unsigned NOT NULL DEFAULT '0',
    `exception` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
    `comment` varchar(512) DEFAULT NULL,
    PRIMARY KEY (`accid`)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
