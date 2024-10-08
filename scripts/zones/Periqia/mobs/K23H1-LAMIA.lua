-----------------------------------
-- Area: Periqia (Shades of Vengeance)
--  Mob: K23H1-LAMIA
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    local instance = mob:getInstance()
    if not instance then
        return
    end

    local progress = math.random(1, 4)
    instance:setProgress(instance:getProgress() + progress)
end

return entity
