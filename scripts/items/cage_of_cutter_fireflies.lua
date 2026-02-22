-----------------------------------
-- ID: 5349
-- Cutter Fireflies
-- Transports the user to Arrapago Reef
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:getZoneID() == xi.zone.THE_ASHU_TALIF then
        return 0
    end

    return xi.msg.basic.ITEM_UNABLE_TO_USE_2
end

itemObject.onItemUse = function(target, user)
    target:addStatusEffect(xi.effect.TELEPORT, { power = xi.teleport.id.CUTTER, duration = 1, origin = user, icon = 0 })
end

itemObject.onItemDrop = function(target, item)
    target:addTempItem(xi.item.CAGE_OF_CUTTER_FIREFLIES)
end

return itemObject
