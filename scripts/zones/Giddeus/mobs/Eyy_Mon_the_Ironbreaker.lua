-----------------------------------
-- Area: Giddeus (145)
--   NM: Eyy Mon the Ironbreaker
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.GIL_MIN, 20)
    mob:setMobMod(xi.mobMod.GIL_MAX, 40)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(240, 360)) -- 4 to 6 minutes
end

return entity
