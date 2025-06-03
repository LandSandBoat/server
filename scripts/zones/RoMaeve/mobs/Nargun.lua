-----------------------------------
-- Area: RoMaeve
--   NM: Nargun
-----------------------------------
---@type TMobEntity
local entity = {}

local spawnPoints =
{
    { x = -107.888, y = 4.000, z = 112.399 },
    { x = -111.739, y = 4.000, z = 114.772 },
    { x = -119.399, y = 4.000, z = 109.537 },
    { x = -127.626, y = 4.000, z = 106.828 },
    { x = -143.349, y = 4.000, z = 108.313 },
    { x = -147.202, y = 4.000, z = 99.363 },
    { x = -144.044, y = 4.000, z = 90.136 },
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.TERROR)

    xi.mob.updateNMSpawnPoint(mob, spawnPoints)
    mob:setRespawnTime(7200)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.STORETP, 135)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.STUN)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 330)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob, spawnPoints)
    mob:setRespawnTime(7200)
end

return entity
