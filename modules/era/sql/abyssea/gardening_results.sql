-----------------------------------
-- Gardening result removal module for Abyssea era
-----------------------------------
-- Burdock and Winterflower became harvestable from Vegetable Seeds in the December 2012 version update.
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(12/12/2012)
-- Source: https://wiki.ffo.jp/html/27533.html
-----------------------------------

DELETE FROM `gardening_results` WHERE `seed` = 4 AND `element1` = 1 AND `element2` = 0 AND `result` = 5651; -- Burdock (Vegetable Seeds, Fire Crystal)
DELETE FROM `gardening_results` WHERE `seed` = 4 AND `element1` = 6 AND `element2` = 0 AND `result` = 5907; -- Winterflower (Vegetable Seeds, Water Crystal)
