-----------------------------------
-- Area: Temenos
--  Mob: Temenos Ghrah
-----------------------------------
local ID = require("scripts/zones/Temenos/IDs")

function onMobDeath(mob, player, isKiller)
    if isKiller then
        local battlefield = player:getBattlefield()
        battlefield:setLocalVar("lootSpawned", 0)
        GetNPCByID(ID.npc.TEMENOS_C_CRATE[5]):setStatus(tpz.status.NORMAL)
    end
end
