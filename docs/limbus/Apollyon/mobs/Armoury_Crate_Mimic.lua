-----------------------------------
-- Area: Apollyon NW
--  NPC: Armoury Crate Mimic
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobFight = function(mob, target)
    local distance = mob:checkDistance(target)
    local drawInTable =
    {
        conditions =
        {
            distance >= mob:getMeleeRange(target) and distance <= 20,
        },
        position = mob:getPos(),
    }
    utils.drawIn(target, drawInTable)
end

return entity
