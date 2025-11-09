-----------------------------------
-- Area: Promyvion-Holla
--  Mob: Cerebrator
-----------------------------------
mixins = { require('scripts/mixins/families/empty_terroanima') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  117.680, y = -0.307, z =  302.450 },
    { x = -236.055, y = -0.500, z =  124.179 }
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
