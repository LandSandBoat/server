-----------------------------------
-- The Wyrmking Descends
-- Vrtra
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobFight = function(mob, target)
    local drawInTable =
    {
        conditions =
        {
            mob:checkDistance(target) >= 15,
        },
        position = mob:getPos(),
    }
    utils.drawIn(target, drawInTable)
end

return entity
