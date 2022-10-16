-----------------------------------
-- Fractus Cell
-- 5377
-- Removes DEX Down effect
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/salvage")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return salvageUtil.onCellItemCheck(target, xi.effect.DEBILITATION, 0x002)
end

itemObject.onItemUse = function(target)
    return salvageUtil.onCellItemUse(target, xi.effect.DEBILITATION, 0x002, 12)
end

return itemObject
