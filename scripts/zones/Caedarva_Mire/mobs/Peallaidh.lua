-----------------------------------
-- Area: Caedarva Mire
--  Mob: Peallaidh
-----------------------------------
require("scripts/globals/hunts")

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 468)
end
