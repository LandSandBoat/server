------------------------------
-- Area: Quicksand Caves
--   NM: Nussknacker
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 435)
end
