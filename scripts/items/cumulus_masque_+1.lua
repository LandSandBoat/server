-----------------------------------
-- ID: 10385
-- Item: Cumulus Masque +1
-- Teleport's user to the place of parting (Resienjima)
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    local result = 0
    if not target:hasVisitedZone(xi.zone.REISENJIMA) then
        result = xi.msg.basic.ITEM_UNABLE_TO_USE_2
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.CUMULUS_MASQUE, 0, 8)
end

return itemObject
