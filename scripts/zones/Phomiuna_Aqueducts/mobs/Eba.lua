-----------------------------------
-- Area: Phomiuna_Aqueducts
--   NM: Eba
-- Notes: Alternates spawns with Mahisha
-----------------------------------
local ID = zones[xi.zone.PHOMIUNA_AQUEDUCTS]
mixins = { require('scripts/mixins/fomor_hate') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setLocalVar('fomorHateAdj', 4)
end

entity.onMobDespawn = function(mob)
    -- Respawn is shared with Mahisha, random to see which spawns next
    local mahisha = GetMobByID(ID.mob.MAHISHA)
    if not mahisha then
        return
    end

    -- Mahisha spawns next
    if math.random(1, 100) <= 50 then
        DisallowRespawn(mob:getID(), true)
        DisallowRespawn(mahisha:getID(), false)
        mahisha:setRespawnTime(math.random(28800, 43200)) -- 8 to 12 hours

    -- Eba spawns next
    else
        DisallowRespawn(mahisha:getID(), true)
        DisallowRespawn(mob:getID(), false)
        mob:setRespawnTime(math.random(28800, 43200)) -- 8 to 12 hours
    end
end

return entity
