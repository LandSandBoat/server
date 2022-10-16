-----------------------------------
-- ID: 11274
-- Item: custom top +1
-- Teleport's user to Purgonorgo Isle
-----------------------------------
local itemObject = {}

require("scripts/globals/teleports")

itemObject.onItemCheck = function(target)
    local result = 0
    if (target:isZoneVisited(xi.zone.BIBIKI_BAY) == false) then
        result = 56
    end
    return result
end

itemObject.onItemUse = function(target)
    xi.teleport.to(target, xi.teleport.id.PURGONORGO)
end

return itemObject
