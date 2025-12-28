-----------------------------------
-- Area: Sauromugue Champaign [S]
--   NM: Coquecigrue
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =   51.000, y =  32.000, z =  279.000 },
    { x =  199.000, y =   0.000, z = -234.000 }
}

entity.onMobInitialize = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(7200, 7800))

    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.PETRIFY)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 532)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setRespawnTime(math.random(7200, 7800)) -- 2 hours plus 10 minute window
end

return entity
