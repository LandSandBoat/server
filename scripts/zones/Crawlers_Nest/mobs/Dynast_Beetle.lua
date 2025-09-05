-----------------------------------
-- Area: Crawlers' Nest (197)
--   NM: Dynast Beetle
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -216.800, y = -0.931, z = -345.600 }
}

entity.onMobInitialize = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(5400, 7200))

    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.SLOW)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 237)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(5400, 7200)) -- 90 to 120 minutes
end

return entity
