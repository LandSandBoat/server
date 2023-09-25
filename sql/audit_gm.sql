--
-- Table structure for table `audit_gm`
--

DROP TABLE IF EXISTS `audit_gm`;
CREATE TABLE `audit_gm` (
  `date_time` datetime NOT NULL,
  `gm_name` varchar(16) NOT NULL,
  `command` varchar(40) NOT NULL,
  `full_string` varchar(200) NOT NULL,
  PRIMARY KEY (`date_time`,`gm_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
