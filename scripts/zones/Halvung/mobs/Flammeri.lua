------------------------------
-- Area: Halvung
--   NM: Flammeri
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 467)
end
