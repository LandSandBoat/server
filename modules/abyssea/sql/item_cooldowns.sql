------------------------------------
-- Reverts Moogle Cap to its original 3 day cooldown
------------------------------------
-- Source: https://www.bg-wiki.com/ffxi/Version_Update_(05/09/2011)
------------------------------------

UPDATE `item_usable` SET reuseDelay = 259200 WHERE `name` = "moogle_cap"; -- 72 hours (in seconds)
UPDATE `item_usable` SET reuseDelay = 259200 WHERE `name` = "nomad_cap";  -- 72 hours (in seconds)
