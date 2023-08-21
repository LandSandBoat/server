-----------------------------------
-- ID: 5344
-- Bhaflau Fireflies
-- Transports the user to Mamool Ja Staging Point
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    if target:getZoneID() == xi.zone.MAMOOL_JA_TRAINING_GROUNDS then
        return 0
    end

    return xi.msg.basic.ITEM_UNABLE_TO_USE_2
end

itemObject.onItemUse = function(target)
    target:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.BHAFLAU, 0, 1)
end

itemObject.onItemDrop = function(target, item)
    target:addTempItem(xi.item.CAGE_OF_BHAFLAU_FIREFLIES)
end

return itemObject
