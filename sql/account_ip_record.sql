SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

--
-- Table structure for table `account_ip_record`
--

DROP TABLE IF EXISTS `account_ip_record`;
CREATE TABLE `account_ip_record` (
  `login_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `accid` int(10) NOT NULL,
  `charid` int(10) NOT NULL,
  `client_ip` tinytext NOT NULL,
  PRIMARY KEY (`login_time`,`accid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
