-----------------------------------
-- ID: 11273
-- Item: custom gilet +1
-- Teleport's user to Purgonorgo Isle
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    local result = 0
    if not target:hasVisitedZone(xi.zone.BIBIKI_BAY) then
        result = xi.msg.basic.ITEM_UNABLE_TO_USE_2
    end

    return result
end

itemObject.onItemUse = function(target, user)
    target:addStatusEffect(xi.effect.TELEPORT, { power = xi.teleport.id.PURGONORGO, duration = 3, origin = user, icon = 0 })
end

return itemObject
