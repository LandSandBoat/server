--
-- Table structure for table `fishing_contest`
-- This table holds the history for fish ranking contests
--

CREATE TABLE IF NOT EXISTS `fishing_contest` (
  `contestid`   smallint(3) unsigned NOT NULL,
  `status`      tinyint(2)  unsigned NOT NULL,
  `criteria`    tinyint(2)  unsigned NOT NULL,
  `measure`     tinyint(2)  unsigned NOT NULL,
  `fishid`      int(2)      unsigned NOT NULL,
  `starttime`   int(10)     unsigned NOT NULL,
  PRIMARY KEY (`contestid`) -- Only one entry per character per contest
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
