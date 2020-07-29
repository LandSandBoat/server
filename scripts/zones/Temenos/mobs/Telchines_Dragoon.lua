-----------------------------------
-- Area: Temenos N T
--  Mob: Telchines Dragoon
-----------------------------------
require("scripts/globals/limbus")
-----------------------------------

function onMobEngaged(mob, target)
        GetMobByID(16928791):updateEnmity(target)
end

function onMobDeath(mob, player, isKiller)
    GetNPCByID(16928770+452):setStatus(tpz.status.NORMAL)
end
