--
-- Table structure for table `fishing_contest_rewards`
-- This table logs the status of rewards for the contest having been granted
--

CREATE TABLE IF NOT EXISTS `fishing_contest_rewards` (
  `contestid`   tinyint(3)  unsigned    NOT NULL,
  `name`        varchar(15)             NOT NULL,
  `time`        integer(10) unsigned    NOT NULL,
  PRIMARY KEY (`contestid`, `name`) -- Only one entry per character per contest
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
