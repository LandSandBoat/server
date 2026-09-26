/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Table structure for table `accounts_messages`
--

DROP TABLE IF EXISTS `accounts_messages`;
CREATE TABLE `accounts_messages` (
  `accid` int(10) unsigned NOT NULL,
  `name` varbinary(255) NOT NULL,
  `sender_accid` int(10) unsigned NOT NULL,
  `type` tinyint(3) unsigned NOT NULL,
  `data` blob NOT NULL,
  `sent` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`accid`, `name`),
  KEY `idx_accounts_messages_sender_accid` (`sender_accid`),
  CONSTRAINT `fk_accounts_messages_accid` FOREIGN KEY (`accid`) REFERENCES `accounts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_accounts_messages_sender_accid` FOREIGN KEY (`sender_accid`) REFERENCES `accounts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
