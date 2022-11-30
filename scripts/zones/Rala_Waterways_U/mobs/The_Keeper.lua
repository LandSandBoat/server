-----------------------------------
-- Area: Rala Waterways [U]
-----------------------------------
local entity = {}

entity.onMobEngaged = function(mob, target)
    local instance = mob:getInstance()
    instance:setLocalVar("FIGHT_STARTED", 1)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
