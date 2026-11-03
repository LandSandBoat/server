--
-- Table structure for table `help_desk`
--

DROP TABLE IF EXISTS `help_desk`;
CREATE TABLE `help_desk` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `charid` int(10) unsigned NOT NULL,
  `message` blob NOT NULL,
  `response` blob DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `responded_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_pending` (`charid`, `deleted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
