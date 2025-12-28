-----------------------------------
-- Area: Eastern Altepa Desert (114)
--   NM: Nandi
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -231.100, y =  0.360, z = -24.000 }
}

entity.onMobInitialize = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(3600, 4200))
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.SLOW)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 409)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(3600, 4200))
end

return entity
