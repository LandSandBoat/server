/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

SET FOREIGN_KEY_CHECKS=0;

DROP TABLE IF EXISTS `site_discord_users`;
CREATE TABLE `site_discord_users` (
  `discord_id`    varchar(32) NOT NULL,
  `username`      varchar(64) NOT NULL,
  `global_name`   varchar(128) DEFAULT NULL,
  `avatar_url`    varchar(512) DEFAULT NULL,
  `last_login_at` timestamp NULL DEFAULT NULL,
  `created_at`    timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`discord_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
