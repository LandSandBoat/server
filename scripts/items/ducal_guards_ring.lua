-----------------------------------
-- ID: 14657
-- Ducal Guard Ring
-- Enchantment: "Teleport-RuLude Gardens"
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    local result = 0
    if not target:hasVisitedZone(xi.zone.RULUDE_GARDENS) then
        result = 56
    end

    return result
end

itemObject.onItemUse = function(target, user)
    target:addStatusEffect(xi.effect.TELEPORT, { power = xi.teleport.id.DUCALGUARD, duration = 4, origin = user, icon = 0 })
end

return itemObject
