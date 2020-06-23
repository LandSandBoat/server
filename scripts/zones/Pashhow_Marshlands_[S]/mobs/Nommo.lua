------------------------------
-- Area: Pashhow Marshlands [S]
--   NM: Nommo
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 509)
end
