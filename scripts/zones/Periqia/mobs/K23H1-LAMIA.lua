-----------------------------------
-- Area: Periqia (Shades of Vengeance)
--  Mob: K23H1-LAMIA
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDespawn = function(mob)
    local instance = mob:getInstance()
    if not instance then
        return
    end

    local progress = math.randomInt(1, 4)
    instance:setProgress(instance:getProgress() + progress)
end

return entity
