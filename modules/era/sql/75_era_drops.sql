-- ---------------------------------------------------------------------------
--  Notes: Changes drop rates or removes drops that are out of Era.
-- ---------------------------------------------------------------------------

UPDATE mob_droplist SET itemRate = 0 WHERE itemId = 4994 -- Remove Mage's Ballad as a drop, quested only at 75 cap

