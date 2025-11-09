-----------------------------------
-- Area: Phomiuna_Aqueducts
--   NM: Mahisha
-- Notes: Alternates spawns with Eba
-----------------------------------
local ID = zones[xi.zone.PHOMIUNA_AQUEDUCTS]
mixins = { require('scripts/mixins/fomor_hate') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setLocalVar('fomorHateAdj', 1)
end

entity.onMobDespawn = function(mob)
    -- Respawn is shared with Eba, random to see which spawns next
    local eba = GetMobByID(ID.mob.EBA)
    if not eba then
        return
    end

    -- Eba spawns next
    if math.random(1, 100) <= 50 then
        DisallowRespawn(mob:getID(), true)
        DisallowRespawn(eba:getID(), false)
        eba:setRespawnTime(math.random(28800, 43200)) -- 8 to 12 hours

    -- Mahisha spawns next
    else
        DisallowRespawn(eba:getID(), true)
        DisallowRespawn(mob:getID(), false)
        mob:setRespawnTime(math.random(28800, 43200)) -- 8 to 12 hours
    end
end

return entity
