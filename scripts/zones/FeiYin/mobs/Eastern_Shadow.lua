-----------------------------------
-- Area: Fei'Yin
--   NM: Eastern Shadow
-----------------------------------
local ID = zones[xi.zone.FEIYIN]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -83.000, y = -15.000, z =  171.000 },
    { x = -73.000, y = -15.000, z =  166.000 },
    { x = -75.000, y = -15.000, z =  154.000 },
    { x = -86.000, y = -15.000, z =  154.000 }
}

entity.phList =
{
    [ID.mob.EASTERN_SHADOW - 2] = ID.mob.EASTERN_SHADOW, -- -159.000 -16.000 146.000
}

entity.onMobInitialize = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 0)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
end

return entity
