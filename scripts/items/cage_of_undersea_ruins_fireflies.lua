-----------------------------------
-- ID: 5348
-- Alzadaal Fireflies
-- Transports the user to Nyzul Isle Staging Point
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    if target:getZoneID() == xi.zone.NYZUL_ISLE then
        return 0
    end

    return xi.msg.basic.ITEM_UNABLE_TO_USE_2
end

itemObject.onItemUse = function(target)
    target:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.ALZADAAL, 0, 1)
end

itemObject.onItemDrop = function(target, item)
    target:addTempItem(xi.item.UNDERSEA_RUINS_FIREFLIES)
end

return itemObject
