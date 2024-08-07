-----------------------------------
-- Area: Lebros Cavern (Wamoura Farm Raid)
--  Mob: Ranch Wamoura
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    local instance = mob:getInstance()
    instance:setProgress(instance:getProgress() + 1)
end

return entity
