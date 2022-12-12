-----------------------------------
-- ID: 14665
-- Teleport ring: Yhoat
-- Enchantment: "Teleport-Yhoat"
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/keyitems")
require("scripts/globals/teleports")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if not target:hasKeyItem(xi.ki.YHOATOR_GATE_CRYSTAL) then
        result = 445
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.YHOAT, 0, 1)
end

return itemObject
