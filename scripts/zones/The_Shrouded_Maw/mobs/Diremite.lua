-----------------------------------
-- Area: The Shrouded Maw
-- Mob: Diremite
-- Mission: Darkness Named
-- There is navmesh issue with the multi-level such that these diremites currently do not aggro
-- because they think cannot see the player (specifically CMobController::CanSeePoint fails)
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setWallhackAllowed(false)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(10) -- respawn in 10 seconds
end

return entity
