-----------------------------------
-- Area: Ship bound for Mhaura Pirates
--  Mob: Crossbones
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
end

entity.onMobSpawn = function(mob)
    mob:setRespawnTime(60) -- respawns every 60s while the pirate ship is alongside
end

return entity
