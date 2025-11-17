-----------------------------------
-- Area: Promyvion-Mea
--  Mob: Coveter
-----------------------------------
mixins = { require('scripts/mixins/families/empty_terroanima') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -169.471, y =  0.000, z =   84.318 },
    { x = -293.877, y = -0.500, z = -122.258 }
}

entity.onMobInitialize = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(3600, 21600))
    mob:setMod(xi.mod.REGAIN, 100)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(3600, 21600))
end

return entity
