------------------------------
-- Area: Quicksand Caves
--   NM: Diamond Daig
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 428)
end
