------------------------------
-- Area: Grauberg [S]
--   NM: Vasiliceratops
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 505)
end
