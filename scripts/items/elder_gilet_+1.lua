-----------------------------------
-- ID: 11280
-- Item: Elder Gilet +1
-- Teleport's user to Purgonorgo Isle
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if not target:hasVisitedZone(xi.zone.BIBIKI_BAY) then
        result = 56
    end

    return result
end

itemObject.onItemUse = function(target)
    xi.teleport.to(target, xi.teleport.id.PURGONORGO)
end

return itemObject
