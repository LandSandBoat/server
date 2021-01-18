-----------------------------------
-- Stratus Cell
-- ID 5369
-- Unlocks leg and feet equipment
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/salvage")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return salvageUtil.onCellItemCheck(target, tpz.effect.ENCUMBRANCE_I, 0x0180)
end

item_object.onItemUse = function(target)
    return salvageUtil.onCellItemUse(target, tpz.effect.ENCUMBRANCE_I, 0x0180, 4)
end

return item_object
