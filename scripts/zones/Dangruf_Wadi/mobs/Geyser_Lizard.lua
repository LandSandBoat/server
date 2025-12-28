-----------------------------------
-- Area: Dangruf Wadi (191)
--  Mob: Geyser Lizard
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x = -211.909, y =  3.537, z =  549.528 },
    { x = -447.935, y =  3.412, z =  230.371 },
    { x = -413.266, y =  4.000, z =  120.417 }
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobSpawn = function(mob)
    DespawnMob(mob:getID(), 600)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 225)
end

entity.onMobDespawn = function(mob)
    mob:setLocalVar('pop', GetSystemTime() + (math.random(45, 75) * 60))
end

return entity
