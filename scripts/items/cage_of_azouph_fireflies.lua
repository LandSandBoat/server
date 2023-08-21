-----------------------------------
-- ID: 5343
-- Azouph Fireflies
-- Transports the user to Azouph Isle
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    if target:getZoneID() == xi.zone.LEUJAOAM_SANCTUM then
        return 0
    end

    return xi.msg.basic.ITEM_UNABLE_TO_USE_2
end

itemObject.onItemUse = function(target)
    target:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.AZOUPH, 0, 1)
end

itemObject.onItemDrop = function(target, item)
    target:addTempItem(xi.item.CAGE_OF_AZOUPH_FIREFLIES)
end

return itemObject
