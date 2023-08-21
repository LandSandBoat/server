-----------------------------------
-- ID: 5346
-- Dvucca Fireflies
-- Transports the user to Dvucca Isle Staging Point
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    if target:getZoneID() == xi.zone.PERIQIA then
        return 0
    end

    return xi.msg.basic.ITEM_UNABLE_TO_USE_2
end

itemObject.onItemUse = function(target)
    target:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.DVUCCA, 0, 1)
end

itemObject.onItemDrop = function(target, item)
    target:addTempItem(xi.item.CAGE_OF_DVUCCA_FIREFLIES)
end

return itemObject
