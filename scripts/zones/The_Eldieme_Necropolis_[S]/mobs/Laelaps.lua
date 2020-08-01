------------------------------
-- Area: The Eldieme Necropolis [S]
--   NM: Laelaps
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 495)
end
