--
-- Table: dynamis_instances
-- Purpose: Tracks instances of dynamis
--

CREATE TABLE IF NOT EXISTS `dynamis_instances` (
  `instanceid` int(10) unsigned NOT NULL DEFAULT '0',
  `zoneid` int(10) unsigned NOT NULL DEFAULT '0',
  `charid` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`instanceid`, `zoneid`),
  INDEX (`zoneid`, `charid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


--
-- Table: dynamis_participants
-- Purpose: Tracks players who have registered for dynamis
--

CREATE TABLE IF NOT EXISTS `dynamis_participants` (
  `instanceid` int(10) unsigned NOT NULL DEFAULT '0',
  `charid` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`instanceid`, `charid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Table: dynamis_instance_state
-- Purpose: Tracks which mob indicies are alive
--

CREATE TABLE IF NOT EXISTS `dynamis_instance_state` (
  `instanceid` int(10) unsigned NOT NULL DEFAULT '0',
  `mobindex` smallint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`instanceid`, `mobindex`),
  INDEX (`instanceid`, `mobindex`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;