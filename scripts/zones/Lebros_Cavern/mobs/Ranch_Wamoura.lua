-----------------------------------
-- Area: Lebros Cavern (Wamoura Farm Raid)
--  Mob: Ranch Wamoura
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    local instance = mob:getInstance()
    if not instance then
        return
    end

    instance:setProgress(instance:getProgress() + 1)
end

return entity
