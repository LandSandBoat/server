-----------------------------------------
-- ID: 14665
-- Teleport ring: Yhoat
-- Enchantment: "Teleport-Yhoat"
-----------------------------------------
local item_object = {}

require("scripts/globals/status")
require("scripts/globals/keyitems")
require("scripts/globals/teleports")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if (target:hasKeyItem(tpz.ki.YHOATOR_GATE_CRYSTAL) == false) then
        result = 445
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffectEx(tpz.effect.TELEPORT, 0, tpz.teleport.id.YHOAT, 0, 1)
end

return item_object
