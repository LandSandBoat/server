-----------------------------------
-- Area: Temenos N T
--  Mob: Kari
-----------------------------------
require("scripts/globals/limbus")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    GetNPCByID(16928770+451):setStatus(tpz.status.NORMAL)
end
