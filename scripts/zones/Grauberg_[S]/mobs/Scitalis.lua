------------------------------
-- Area: Grauberg [S]
--   NM: Scitalis
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 503)
end
