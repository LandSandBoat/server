-----------------------------------
-- Area: Leujaoam Sanctum (Leujaoam Cleansing)
--  Mob: Leujaoam Worm
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
end

function onMobDespawn(mob)
    local instance = mob:getInstance()
    instance:setProgress(instance:getProgress() + 1)
end

return entity
