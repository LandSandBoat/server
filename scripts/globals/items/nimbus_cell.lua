-----------------------------------
-- Nimbus Cell
-- 5379
-- Removes AGI Down effect
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/salvage")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return salvageUtil.onCellItemCheck(target, xi.effect.DEBILITATION, 0x008)
end

itemObject.onItemUse = function(target)
    return salvageUtil.onCellItemUse(target, xi.effect.DEBILITATION, 0x008, 14)
end

return itemObject
