-----------------------------------
-- ID: 25757
-- Item: Wyrmking Suit +1
-- Teleport's user to Riverne Site #B-01
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    local result = 0
    if not target:hasVisitedZone(xi.zone.RIVERNE_SITE_B01) then
        result = xi.msg.basic.ITEM_UNABLE_TO_USE_2
    end

    return result
end

itemObject.onItemUse = function(target, user)
    target:addStatusEffect(xi.effect.TELEPORT, { power = xi.teleport.id.WYRMKING_SUIT, duration = 3, origin = user, icon = 0 })
end

return itemObject
