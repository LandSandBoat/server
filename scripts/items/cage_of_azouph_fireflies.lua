-----------------------------------
-- ID: 5343
-- Azouph Fireflies
-- Transports the user to Azouph Isle
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:getZoneID() == xi.zone.LEUJAOAM_SANCTUM then
        return 0
    end

    return xi.msg.basic.ITEM_UNABLE_TO_USE_2
end

itemObject.onItemUse = function(target, user)
    target:addStatusEffect(xi.effect.TELEPORT, { power = xi.teleport.id.AZOUPH, duration = 1, origin = user, icon = 0 })
end

itemObject.onItemDrop = function(target, item)
    target:addTempItem(xi.item.CAGE_OF_AZOUPH_FIREFLIES)
end

return itemObject
