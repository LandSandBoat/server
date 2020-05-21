------------------------------
-- Area: The Eldieme Necropolis [S]
--   NM: Tethra
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, isKiller)
end
