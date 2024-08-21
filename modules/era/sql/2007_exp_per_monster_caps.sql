-- XP values as of 08/28/2007 gathered from https://ffxiclopedia.fandom.com/wiki/Experience_Points?oldid=334881#Base_Experience

-- Drop all rows of existing table
DELETE FROM `exp_per_monster_caps`;

INSERT INTO `exp_per_monster_caps` VALUES(50, 200.00);
INSERT INTO `exp_per_monster_caps` VALUES(60, 250.00);

-- Else, fall through to this:
INSERT INTO `exp_per_monster_caps` VALUES(99, 300.00);
