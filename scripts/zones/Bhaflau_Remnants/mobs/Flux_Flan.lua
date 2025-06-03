-----------------------------------
-- Area: Bhaflau Remnants
-- MOB: Flux Flan
-----------------------------------
local ID = zones[xi.zone.BHAFLAU_REMNANTS]
mixins = { require('scripts/mixins/families/flan') }
-----------------------------------

---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    local instance = mob:getInstance()

    if instance then
        GetNPCByID(ID.npc.SOCKET, instance):setStatus(xi.status.DISAPPEAR)
        if instance:getProgress() == 1 then
            mob:setMaxHP(5150)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    if
        optParams.isKiller or
        optParams.noKiller
    then
        xi.salvage.handleSocketCells(mob, player)
    end
end

return entity
