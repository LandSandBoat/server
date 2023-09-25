-----------------------------------
-- ID: 14657
-- Ducal Guard Ring
-- Enchantment: "Teleport-RuLude Gardens"
-----------------------------------
require("scripts/globals/teleports")
require("scripts/globals/zone")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if not target:hasVisitedZone(xi.zone.RULUDE_GARDENS) then
        result = 56
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.DUCALGUARD, 0, 3)
end

return itemObject
