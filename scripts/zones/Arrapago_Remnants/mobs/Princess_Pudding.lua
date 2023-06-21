-----------------------------------
-- Area: Arrapago Remnants
--  Mob: Princess Pudding
-----------------------------------
local ID = require("scripts/zones/Arrapago_Remnants/IDs")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    local instance = mob:getInstance()
    local slot = GetNPCByID(ID.npc[2][2].SLOT, instance)
        slot:setStatus(xi.status.DISAPPEAR)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
end

return entity
