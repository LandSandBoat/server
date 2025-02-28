-----------------------------------
-- Area: Castle Zvahl Baileys (161)
--   NM: Marquis Naberius
-----------------------------------
---@type TMobEntity
local entity = {}

local spawnPoints =
{
    { x = 80.000, y = -8.000, z = 160.000 },
    { x = 86.188, y = -8.000, z = 146.140 },
    { x = 94.838, y = -8.000, z = 156.127 },
    { x = 96.365, y = -8.000, z = 168.130 },
    { x = 92.109, y = -8.000, z = 176.818 },
    { x = 80.239, y = -8.000, z = 178.892 },
    { x = 71.010, y = -8.000, z = 177.824 },
    { x = 64.585, y = -8.000, z = 171.116 },
    { x = 63.067, y = -8.000, z = 161.044 },
    { x = 64.131, y = -8.000, z = 150.840 },
    { x = 68.483, y = -8.000, z = 144.183 },
    { x = 80.855, y = -8.000, z = 142.809 },
    { x = 80.022, y = -8.000, z = 154.056 },
    { x = 73.322, y = -8.000, z = 165.036 },
    { x = 83.239, y = -8.000, z = 164.735 },
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    xi.mob.updateNMSpawnPoint(mob, spawnPoints)
    mob:setRespawnTime(math.random(900, 10800))
end

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.SILENCE)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENAERO)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 350)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob, spawnPoints)
    mob:setRespawnTime(math.random(3600, 7200)) -- 1 to 2 hours
end

return entity
