-----------------------------------
-- ID: 14657
-- Ducal Guard Ring
-- Enchantment: "Teleport-RuLude Gardens"
-----------------------------------
require("scripts/globals/teleports")
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if not target:isZoneVisited(243) then
        result = 56
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffectEx(tpz.effect.TELEPORT, 0, tpz.teleport.id.DUCALGUARD, 0, 3)
end

return item_object
