-----------------------------------
-- ID: 5401
-- S. Rem. Fireflies
-- Transports the user out of Silver Sea Remnants
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    if target:getZoneID() == xi.zone.SILVER_SEA_REMNANTS then
        return 0
    end

    return xi.msg.basic.ITEM_UNABLE_TO_USE_2
end

itemObject.onItemUse = function(target)
    target:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.S_REM, 0, 1)
end

itemObject.onItemDrop = function(target, item)
    target:addTempItem(xi.item.CAGE_OF_S_REMNANTS_FIREFLIES)
end

return itemObject
