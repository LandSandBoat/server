-----------------------------------
-- Area: Promyvion-Dem
--  Mob: Satiator
-----------------------------------
mixins = { require('scripts/mixins/families/empty_terroanima') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  -44.317, y =  0.000, z = -242.987 },
    { x = -205.880, y = -0.500, z =  268.850 }
}

entity.onMobInitialize = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(3600 + math.random(600, 900)) -- 1 hour, plus 10 to 15 min
    mob:setMod(xi.mod.REGAIN, 100)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(3600 + math.random(600, 900)) -- 1 hour, plus 10 to 15 min
end

return entity
