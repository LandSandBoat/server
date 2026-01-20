-----------------------------------
-- Area: Fei'Yin
--   NM: Northern Shadow
-----------------------------------
local ID = zones[xi.zone.FEIYIN]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -162.000, y = -15.000, z =  154.000 },
    { x = -168.635, y = -15.948, z =  166.821 },
    { x = -154.830, y = -15.904, z =  169.081 },
    { x = -150.543, y = -15.858, z =  156.672 }
}

entity.phList =
{
    [ID.mob.NORTHERN_SHADOW - 4] = ID.mob.NORTHERN_SHADOW, -- -159.000 -16.000 146.000
}

entity.onMobInitialize = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
end

return entity
