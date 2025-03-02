-----------------------------------
-- Area: Cape Teriggan
--   NM: Killer Jonny
--  WOTG Nov 2009 NM: Immune to Bind, Sleep, Gravity. Uses only 1 TP move.
-----------------------------------
---@type TMobEntity
local entity = {}

local spawnPoints =
{
    { x = -90.636, y = -8.859, z = 152.899 },
    { x = -80.809, y = -7.032, z = 147.464 },
    { x = -77.167, y = -8.000, z = 156.316 },
    { x = -61.131, y = -7.005, z = 151.069 },
    { x = -54.285, y = -8.151, z = 165.535 },
    { x = -35.874, y = -8.162, z = 166.132 },
}

entity.onMobInitialize = function(mob)
    xi.mob.updateNMSpawnPoint(mob, spawnPoints)
    mob:setRespawnTime(math.random(28800, 86400)) -- 8 to 24 hours
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 100)
end

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.BIND)
    mob:setMod(xi.mod.STORETP, 80)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.POISON, { power = 120 })
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 407)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob, spawnPoints)
    mob:setRespawnTime(math.random(28800, 86400)) -- 8 to 24 hours
end

return entity
