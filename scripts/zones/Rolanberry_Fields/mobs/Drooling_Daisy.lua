------------------------------
-- Area: Rolanberry Fields
--   NM: Drooling Daisy
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 216)
end
