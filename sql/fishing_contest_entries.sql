--
-- Table structure for table `fishing_contest_entries`
-- This table holds the submissions to the fish ranking contest
--

DROP TABLE IF EXISTS `fishing_contest_entries`;
CREATE TABLE IF NOT EXISTS `fishing_contest_entries` (
    `charid`      int(10)     unsigned    NOT NULL,
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
    `share`       tinyint(2)  unsigned    NOT NULL DEFAULT 0,
    `claimed`     tinyint(1)  unsigned    NOT NULL DEFAULT 0,
    PRIMARY KEY (`charid`) -- Only one entry per character
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
