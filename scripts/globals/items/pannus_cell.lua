-----------------------------------------
-- Pannus Cell
-- ID 5376
-- Removes STR Down effect
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/salvage")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return salvageUtil.onCellItemCheck(target, tpz.effect.DEBILITATION, 0x001)
end

item_object.onItemUse = function(target)
    return salvageUtil.onCellItemUse(target, tpz.effect.DEBILITATION, 0x001, 11)
end

return item_object
