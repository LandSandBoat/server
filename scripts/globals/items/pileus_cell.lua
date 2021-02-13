-----------------------------------
-- Pileus Cell
-- ID 5381
-- Removes MND Down effect
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/salvage")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return salvageUtil.onCellItemCheck(target, tpz.effect.DEBILITATION, 0x020)
end

item_object.onItemUse = function(target)
    return salvageUtil.onCellItemUse(target, tpz.effect.DEBILITATION, 0x020, 16)
end

return item_object
