/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Table structure for table `accounts_friends`
--

DROP TABLE IF EXISTS `accounts_friends`;
CREATE TABLE `accounts_friends` (
  `accid` int(10) unsigned NOT NULL,
  `blacklist` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `list_index` tinyint(3) unsigned NOT NULL,
  `friend_accid` int(10) unsigned NOT NULL DEFAULT '0',
  `display_order` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `name` varbinary(16) NOT NULL DEFAULT '',
  `pending` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`accid`, `blacklist`, `list_index`),
  UNIQUE KEY `idx_accounts_friends_friend` (`accid`, `blacklist`, `friend_accid`),
  KEY `idx_accounts_friends_friend_accid` (`friend_accid`),
  CONSTRAINT `fk_accounts_friends_accid` FOREIGN KEY (`accid`) REFERENCES `accounts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_accounts_friends_friend_accid` FOREIGN KEY (`friend_accid`) REFERENCES `accounts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
