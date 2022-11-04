-----------------------------------
-- ID: 11273
-- Item: custom gilet +1
-- Teleport's user to Purgonorgo Isle
-----------------------------------
local itemObject = {}

require("scripts/globals/teleports")

itemObject.onItemCheck = function(target)
    local result = 0
    if target:hasVisitedZone(4) == false then
        result = 56
    end
    return result
end

itemObject.onItemUse = function(target)
    xi.teleport.to(target, xi.teleport.id.PURGONORGO)
end

return itemObject
