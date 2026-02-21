-----------------------------------
-- ID: 5348
-- Alzadaal Fireflies
-- Transports the user to Nyzul Isle Staging Point
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:getZoneID() == xi.zone.NYZUL_ISLE then
        return 0
    end

    return xi.msg.basic.ITEM_UNABLE_TO_USE_2
end

itemObject.onItemUse = function(target, user)
    target:addStatusEffect(xi.effect.TELEPORT, { power = xi.teleport.id.ALZADAAL, duration = 1, origin = user, icon = 0 })
end

itemObject.onItemDrop = function(target, item)
    target:addTempItem(xi.item.UNDERSEA_RUINS_FIREFLIES)
end

return itemObject
