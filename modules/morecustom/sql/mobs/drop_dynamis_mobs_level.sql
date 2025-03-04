-- decrease the level range of Dynamis mobs that are above level 50 by 10
UPDATE mob_groups SET minLevel = minLevel - 10, maxLevel = maxLevel - 10 WHERE minLevel > 50 and zoneid = 39; -- Dynamis - Valkurm
UPDATE mob_groups SET minLevel = minLevel - 10, maxLevel = maxLevel - 10 WHERE minLevel > 50 and zoneid = 40; -- Dynamis - Buburimu
UPDATE mob_groups SET minLevel = minLevel - 10, maxLevel = maxLevel - 10 WHERE minLevel > 50 and zoneid = 41; -- Dynamis - Qufim
UPDATE mob_groups SET minLevel = minLevel - 10, maxLevel = maxLevel - 10 WHERE minLevel > 50 and zoneid = 42; -- Dynamis - Tavnazia
UPDATE mob_groups SET minLevel = minLevel - 10, maxLevel = maxLevel - 10 WHERE minLevel > 50 and zoneid = 134; -- Dynamis - Beaucedine
UPDATE mob_groups SET minLevel = minLevel - 10, maxLevel = maxLevel - 10 WHERE minLevel > 50 and zoneid = 135; -- Dynamis - Xarcabard
UPDATE mob_groups SET minLevel = minLevel - 10, maxLevel = maxLevel - 10 WHERE minLevel > 50 and zoneid = 185; -- Dynamis - San d'Oria
UPDATE mob_groups SET minLevel = minLevel - 10, maxLevel = maxLevel - 10 WHERE minLevel > 50 and zoneid = 186; -- Dynamis - Bastok
UPDATE mob_groups SET minLevel = minLevel - 10, maxLevel = maxLevel - 10 WHERE minLevel > 50 and zoneid = 187; -- Dynamis - Windurst
UPDATE mob_groups SET minLevel = minLevel - 10, maxLevel = maxLevel - 10 WHERE minLevel > 50 and zoneid = 188; -- Dynamis - Jeuno