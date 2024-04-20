SET FOREIGN_KEY_CHECKS=0;
-- ------------------------------
-- Table structure for char_flags 
-- ------------------------------
DROP TABLE IF EXISTS `char_flags`;
CREATE TABLE `char_flags` (
  `charid` int(10) unsigned NOT NULL,
  `disconnecting` smallint(3) NOT NULL DEFAULT '0',
  `gmModeEnabled` smallint(3) NOT NULL DEFAULT '0',
  `gmHiddenEnabled` smallint(3) NOT NULL DEFAULT '0',
  PRIMARY KEY (`charid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
