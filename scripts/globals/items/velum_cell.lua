-----------------------------------
-- Velum Cell
-- ID 5380
-- Removes INT Down effect
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/salvage")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return salvageUtil.onCellItemCheck(target, tpz.effect.DEBILITATION, 0x010)
end

item_object.onItemUse = function(target)
    return salvageUtil.onCellItemUse(target, tpz.effect.DEBILITATION, 0x010, 15)
end

return item_object
