--
-- Table structure for table `fishing_contest_entries`
-- This table holds the history for submissions to the fish ranking contests
--

CREATE TABLE IF NOT EXISTS `fishing_contest_entries` (
  `contestid`   tinyint(3)  unsigned    NOT NULL,
  `name`        varchar(15)             NOT NULL,
  `mjob`        tinyint(2)  unsigned    NOT NULL,
  `sjob`        tinyint(2)  unsigned    NOT NULL,
  `mlevel`      tinyint(2)  unsigned    NOT NULL,
  `slevel`      tinyint(2)  unsigned    NOT NULL,
  `race`        tinyint(2)  unsigned    NOT NULL,
  `allegiance`  tinyint(2)  unsigned    NOT NULL,
  `fishrank`    tinyint(2)  unsigned    NOT NULL,
  `score`       int(4)      unsigned    NOT NULL DEFAULT 0,
  `submittime`  int(4)      unsigned    NOT NULL DEFAULT 0,
  `contestrank` tinyint(2)  unsigned    NOT NULL DEFAULT 0,
    PRIMARY KEY (`contestid`, `name`) -- Only one entry per character per contest
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
