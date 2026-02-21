-----------------------------------
-- ID: 5347
-- Reef Fireflies
-- Transports the user to Ilrusi Atoll Staging Point
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:getZoneID() == xi.zone.ILRUSI_ATOLL then
        return 0
    end

    return xi.msg.basic.ITEM_UNABLE_TO_USE_2
end

itemObject.onItemUse = function(target, user)
    target:addStatusEffect(xi.effect.TELEPORT, { power = xi.teleport.id.REEF, duration = 1, origin = user, icon = 0 })
end

itemObject.onItemDrop = function(target, item)
    target:addTempItem(xi.item.CAGE_OF_REEF_FIREFLIES)
end

return itemObject
