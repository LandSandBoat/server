-----------------------------------
-- Area: The Shrouded Maw
-- Mob: Diremite
-- Mission: Darkness Named
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setWallhackAllowed(false)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
