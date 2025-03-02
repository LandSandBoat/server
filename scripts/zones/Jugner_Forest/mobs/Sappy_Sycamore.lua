-----------------------------------
-- Area: Jugner_Forest
--   NM: Sappy Sycamore
-----------------------------------
---@type TMobEntity
local entity = {}

local spawnPoints =
{
    { x = 276.000, y = 0.000, z = 265.000 },
    { x = 290.000, y = 0.000, z = 211.000 },
    { x = 320.000, y = 0.000, z = 177.000 },
    { x = 270.000, y = 0.000, z = 156.000 },
    { x = 236.000, y = 0.000, z = 210.000 },
    { x = 215.000, y = 0.000, z = 241.000 },
    { x = 172.000, y = 0.000, z = 279.000 },
    { x = 233.000, y = 0.000, z = 290.000 },
    { x = 291.000, y = 0.000, z = 283.000 },
    { x = 313.000, y = 0.000, z = 280.000 },
    { x = 283.000, y = 0.000, z = 265.000 },
}

entity.onMobInitialize = function(mob)
    xi.mob.updateNMSpawnPoint(mob, spawnPoints)
    mob:setRespawnTime(math.random(3600, 4200)) -- 60 to 70 min

    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:addMod(xi.mod.SLEEP_MEVA, 20)
    mob:addMod(xi.mod.BIND_MEVA, 20)
    mob:addMod(xi.mod.EARTH_MEVA, 100)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.SLOW, { power = 1500, duration = math.random(15, 25) })
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 159)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob, spawnPoints)
    mob:setRespawnTime(math.random(3600, 4200)) -- 60 to 70 min
end

return entity
