-- --------------------------------------------------------
-- Removes non-CoP era guild point items and adds back CoP era items
-- --------------------------------------------------------

-- IMPORTANT NOTE
-- Only apply after the guild_item_points.sql in era/sql was run and check the IMPORTANT NOTE in that file

LOCK TABLES
    `guild_item_points` WRITE;

-- remove non-CoP era items added by guild_item_points.sql in era/sql
DELETE FROM `guild_item_points` WHERE `itemid` IN (5598, 5599, 5572, 5573, 5600, 5601);

-- add back original CoP era items
INSERT INTO `guild_item_points` (`guildid`, `itemid`, `rank`, `points`, `max_points`, `pattern`) VALUES 
    (8, 4556, 5, 504, 3840, 4),
    (8, 4594, 5, 560, 3840, 4),
    (8, 4556, 5, 504, 3840, 6),
    (8, 4594, 5, 560, 3840, 6),
    (8, 5147, 6, 375, 3680, 2),
    (8, 5155, 6, 875, 3680, 2),
    (8, 5147, 6, 375, 3680, 7),
    (8, 5155, 6, 875, 3680, 7);

UNLOCK TABLES;
