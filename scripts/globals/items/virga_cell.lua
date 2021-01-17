-----------------------------------------
-- Virga Cell
-- ID 5372
-- Unlocks earring and ring equipment
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/salvage")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return salvageUtil.onCellItemCheck(target, tpz.effect.ENCUMBRANCE_I, 0x7800)
end

item_object.onItemUse = function(target)
    return salvageUtil.onCellItemUse(target, tpz.effect.ENCUMBRANCE_I, 0x7800, 7)
end

return item_object
