--
-- Table structure for table `char_fishing_contest_history`
-- This table holds the data for number of times a player achieved a given rank in the fish ranking contest
--

DROP TABLE IF EXISTS `char_fishing_contest_history`;
CREATE TABLE IF NOT EXISTS `char_fishing_contest_history` (
    `charid`           int(10)      unsigned NOT NULL,
    `contest_rank_1`   smallint(3)  unsigned NOT NULL DEFAULT 0,
    `contest_rank_2`   smallint(3)  unsigned NOT NULL DEFAULT 0,
    `contest_rank_3`   smallint(3)  unsigned NOT NULL DEFAULT 0,
    `contest_rank_4`   smallint(3)  unsigned NOT NULL DEFAULT 0,
    PRIMARY KEY (`charid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
