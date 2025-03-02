-----------------------------------
-- Area: The Sanctuary of ZiTah
--   NM: Bastet
--  WOTG Nov 2009 NM: Immune to Bind, Sleep, Gravity.
-----------------------------------
---@type TMobEntity
local entity = {}

local spawnPoints =
{
    { x = -292.801, y = -0.292, z = 196.281 },
    { x = -513.329, y =  0.879, z = 222.353 },
    { x = -481.339, y =  0.000, z = 238.461 },
    { x = -452.624, y =  0.458, z = 239.152 },
    { x = -429.475, y =  0.325, z = 282.488 },
    { x = -400.346, y =  0.000, z = 278.538 },
    { x = -375.992, y =  1.059, z = 296.278 },
    { x = -340.516, y =  0.973, z = 321.054 },
    { x = -288.632, y =  0.343, z = 247.113 },
    { x = -339.312, y =  2.639, z = 164.708 },
    { x = -336.081, y =  2.986, z = 101.906 },
    { x = -406.237, y =  0.185, z =  45.638 },
}

entity.onMobInitialize = function(mob)
    xi.mob.updateNMSpawnPoint(mob, spawnPoints)
end

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.SILENCE)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 325)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob, spawnPoints)
end

return entity
