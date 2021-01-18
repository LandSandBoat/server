-----------------------------------
-- Fractus Cell
-- 5377
-- Removes DEX Down effect
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/salvage")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return salvageUtil.onCellItemCheck(target, tpz.effect.DEBILITATION, 0x002)
end

item_object.onItemUse = function(target)
    return salvageUtil.onCellItemUse(target, tpz.effect.DEBILITATION, 0x002, 12)
end

return item_object
