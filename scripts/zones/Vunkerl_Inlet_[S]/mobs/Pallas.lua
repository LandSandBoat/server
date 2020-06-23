------------------------------
-- Area: Vunkerl Inlet [S]
--   NM: Pallas
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 489)
end
