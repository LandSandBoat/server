-----------------------------------
-- ID: 11277
-- Item: wonder mailot +1
-- Teleport's user to Purgonorgo Isle
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    local result = 0
    if not target:hasVisitedZone(xi.zone.BIBIKI_BAY) then
        result = xi.msg.basic.ITEM_UNABLE_TO_USE_2
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.PURGONORGO, 0, 3)
end

return itemObject
