------------------------------
-- Area: Halvung
--   NM: Copper Borer
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 465)
end
