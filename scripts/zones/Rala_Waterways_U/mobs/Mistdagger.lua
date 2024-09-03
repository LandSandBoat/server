-----------------------------------
-- Area: Rala Waterways [U]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobEngage = function(mob, target)
    local instance = mob:getInstance()
    if not instance then
        return
    end

    instance:setLocalVar('FIGHT_STARTED', 1)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
