------------------------------
-- Area: Upper Delkfutts Tower
--   NM: Ixtab
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 332)
end
