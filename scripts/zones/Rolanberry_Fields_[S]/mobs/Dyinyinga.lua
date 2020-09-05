------------------------------
-- Area: Rolanberry Fields [S]
--   NM: Dyinyinga
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 511)
end
