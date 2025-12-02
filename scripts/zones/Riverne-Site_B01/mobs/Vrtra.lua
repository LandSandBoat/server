-----------------------------------
-- The Wyrmking Descends
-- Vrtra
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Ziryu')
end

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
