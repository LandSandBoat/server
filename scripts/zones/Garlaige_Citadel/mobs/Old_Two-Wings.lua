-----------------------------------
-- Area: Garlaige Citadel (200)
--   NM: Old Two-Wings
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setRespawnTime(math.randomInt(75600, 86400))
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
end

entity.onMobDespawn = function(mob)
    -- Set Old_Two_Wings's spawnpoint and respawn time (21-24 hours)
    mob:setRespawnTime(math.randomInt(75600, 86400))
end

return entity
