-----------------------------------
-- Area: Arrapago Remnants
--  Mob: Princess Pudding
-----------------------------------
local ID = zones[xi.zone.ARRAPAGO_REMNANTS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    local instance = mob:getInstance()
    if not instance then
        return
    end

    local slot = GetNPCByID(ID.npc[2][2].SLOT, instance)

    if slot then
        slot:setStatus(xi.status.DISAPPEAR)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
end

return entity
