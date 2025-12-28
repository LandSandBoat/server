-----------------------------------
-- Area: Riverne - Site A01
-- Mob: Water Elemental
-- Notes: in Ouryu Cometh
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ROAM_DISTANCE, 500)
end

entity.onMobSpawn = function(mob)
    -- TODO: add building sleep resistance after added to LSB
    -- capture shows about 1 second shorter sleep each time
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(60)
end

return entity
