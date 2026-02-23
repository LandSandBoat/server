-----------------------------------
-- ID: 5399
-- A. Rem. Fireflies
-- Transports the user out of Arrapago Remnants
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:getZoneID() == xi.zone.ARRAPAGO_REMNANTS then
        return 0
    end

    return xi.msg.basic.ITEM_UNABLE_TO_USE_2
end

itemObject.onItemUse = function(target, user)
    target:addStatusEffect(xi.effect.TELEPORT, { power = xi.teleport.id.A_REM, duration = 1, origin = user, icon = 0 })
end

itemObject.onItemDrop = function(target, item)
    target:addTempItem(xi.item.CAGE_OF_A_REMNANTS_FIREFLIES)
end

return itemObject
