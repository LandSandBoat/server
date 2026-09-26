/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Table structure for table `accounts_profile`
--

DROP TABLE IF EXISTS `accounts_profile`;
CREATE TABLE `accounts_profile` (
  `accid` int(10) unsigned NOT NULL,
  `client_addr` int(10) unsigned NOT NULL DEFAULT '0',
  `session_hash` binary(16) NOT NULL,
  `refreshed` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `open_status` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`accid`),
  KEY `idx_accounts_profile_client_addr` (`client_addr`),
  CONSTRAINT `fk_accounts_profile_accid` FOREIGN KEY (`accid`) REFERENCES `accounts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
