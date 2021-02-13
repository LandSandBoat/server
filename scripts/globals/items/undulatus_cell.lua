-----------------------------------
-- Undulatus Cell
-- ID 5371
-- Unlocks ranged and ammo equipment
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/salvage")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return salvageUtil.onCellItemCheck(target, tpz.effect.ENCUMBRANCE_I, 0x000C)
end

item_object.onItemUse = function(target)
    return salvageUtil.onCellItemUse(target, tpz.effect.ENCUMBRANCE_I, 0x000C, 6)
end

return item_object
