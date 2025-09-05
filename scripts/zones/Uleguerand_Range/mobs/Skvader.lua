-----------------------------------
-- Area: Uleguerand Range
--   NM: Skvader
-----------------------------------
local ID = zones[xi.zone.ULEGUERAND_RANGE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  186.278, y =  0.072, z = -278.215 }
}

entity.phList =
{
    [ID.mob.SKVADER - 1] = ID.mob.SKVADER,
}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 20)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 321)
end

return entity
