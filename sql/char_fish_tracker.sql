-- --------------------------------------------------------
-- Add tracker for suspect fishers
-- --------------------------------------------------------

CREATE TABLE IF NOT EXISTS `char_fish_tracker` (
    `index`              int(11) AUTO_INCREMENT,
    `charid`             int(10) unsigned NOT NULL,
    `fish_id`            int(5)  unsigned NOT NULL,
    `char_fishing_skill` int(4)  unsigned NOT NULL,
    `rod`                int(5)  unsigned NOT NULL,
    `catch_time`         datetime NOT NULL,
    PRIMARY KEY (`index`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
