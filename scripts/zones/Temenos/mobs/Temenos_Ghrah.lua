-----------------------------------
-- Area: Temenos
--  Mob: Temenos Ghrah
-----------------------------------
require("scripts/globals/limbus")
-----------------------------------

function onMobDeath(mob, player, isKiller)
    GetNPCByID(16928770+475):setStatus(tpz.status.NORMAL)
end
