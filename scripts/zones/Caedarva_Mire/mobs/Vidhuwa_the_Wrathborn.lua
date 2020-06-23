------------------------------
-- Area: Caedarva Mire
--   NM: Vidhuwa the Wrathborn
------------------------------
require("scripts/globals/hunts")
------------------------------

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 471)
end
