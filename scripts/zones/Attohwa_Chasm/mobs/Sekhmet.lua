-----------------------------------
-- Area: Attohwa Chasm
--   NM: Sekhmet
-----------------------------------
---@type TMobEntity
local entity = {}

local spawnPoints =
{
    { x = 316.000, y = 20.000, z = -141.000 },
    { x = 307.000, y = 20.000, z = -186.000 },
    { x = 322.000, y = 20.000, z = -199.000 },
    { x = 359.000, y = 20.000, z = -158.000 },
    { x = 360.000, y = 20.000, z = -202.000 },
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 10)
    mob:setMod(xi.mod.FASTCAST, 15)

    xi.mob.updateNMSpawnPoint(mob, spawnPoints)
    mob:setRespawnTime(math.random(5400, 7200)) -- When server restarts, reset timer
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.MP_DRAIN, { power = math.random(1, 10) })
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 276)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(5400, 7200)) -- 1.5 to 2 hours.
    xi.mob.updateNMSpawnPoint(mob, spawnPoints)
end

return entity
