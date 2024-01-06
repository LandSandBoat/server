--
-- Table structure for table `auction_house_items`
--

DROP TABLE IF EXISTS `auction_house_items`;
CREATE TABLE `auction_house_items` (
  `itemid` smallint(5) unsigned NOT NULL,
  PRIMARY KEY `itemid` (`itemid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
