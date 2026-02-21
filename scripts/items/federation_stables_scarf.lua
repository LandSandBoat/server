-----------------------------------
-- ID: 13181
-- Item: Federation Stables Scarf
-- Teleports to Chocobo Stables (Windurst)
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    local result = 0
    if not target:hasVisitedZone(xi.zone.WINDURST_WOODS) then
        result = xi.msg.basic.ITEM_UNABLE_TO_USE_2
    end

    return result
end

itemObject.onItemUse = function(target, user)
    target:addStatusEffect(xi.effect.TELEPORT, { power = xi.teleport.id.CHOCO_WINDURST, duration = 4, origin = user, icon = 0 })
end

return itemObject
