-- --------------------------------------------------------
-- Add history for player fishing data
-- --------------------------------------------------------

DROP TABLE IF EXISTS `char_fishing_history`;
CREATE TABLE IF NOT EXISTS `char_fishing_history` (
    `charid`           int(10) unsigned NOT NULL,
    `fish_catches`     blob,
    `fish_linescast`   int(6)  unsigned NOT NULL DEFAULT 0,
    `fish_reeled`      int(5)  unsigned NOT NULL DEFAULT 0,
    `fish_longest`     int(4)  unsigned NOT NULL DEFAULT 0,
    `fish_longest_id`  int(4)  unsigned NOT NULL DEFAULT 0,
    `fish_heaviest`    int(4)  unsigned NOT NULL DEFAULT 0,
    `fish_heaviest_id` int(4)  unsigned NOT NULL DEFAULT 0,
    PRIMARY KEY (`charid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
