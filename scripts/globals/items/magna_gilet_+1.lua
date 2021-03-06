-----------------------------------
-- ID: 11275
-- Item: magna gilet +1
-- Teleport's user to Purgonorgo Isle
-----------------------------------
local item_object = {}

require("scripts/globals/teleports")

item_object.onItemCheck = function(target)
    local result = 0
    if (target:isZoneVisited(4) == false) then
        result = 56
    end
    return result
end

item_object.onItemUse = function(target)
    xi.teleport.to(target, xi.teleport.id.PURGONORGO)
end

return item_object
