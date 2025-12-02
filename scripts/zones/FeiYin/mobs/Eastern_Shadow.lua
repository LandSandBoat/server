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

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
