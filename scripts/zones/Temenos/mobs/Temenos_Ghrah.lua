-----------------------------------
-- Area: Temenos
--  Mob: Temenos Ghrah
-----------------------------------
local ID = require("scripts/zones/Temenos/IDs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        local battlefield = mob:getBattlefield()
        battlefield:setLocalVar("lootSpawned", 0)
        GetNPCByID(ID.npc.TEMENOS_C_CRATE[5]):setStatus(xi.status.NORMAL)
    end
end

return entity
