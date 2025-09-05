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
    { x = -162.000, y = -15.000, z =  154.000 }
}

entity.phList =
{
    [ID.mob.NORTHERN_SHADOW - 4] = ID.mob.NORTHERN_SHADOW, -- -159.000 -16.000 146.000
}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
