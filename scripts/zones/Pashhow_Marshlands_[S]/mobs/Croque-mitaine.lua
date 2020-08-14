------------------------------
-- Area: Pashhow Marshlands [S]
--   NM: Croque-mitaine
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 506)
end
