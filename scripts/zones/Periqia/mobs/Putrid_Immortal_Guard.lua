-----------------------------------
-- Area: Periqia (Requiem)
--  Mob: Putrid Immortal Guard
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    local instance = mob:getInstance()
    instance:setProgress(instance:getProgress() + 1)
end

return entity
