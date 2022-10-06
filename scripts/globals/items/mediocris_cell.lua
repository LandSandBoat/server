-----------------------------------
-- Mediocris Cell
-- ID 5382
-- Removes CHR Down effect
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/salvage")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return salvageUtil.onCellItemCheck(target, xi.effect.DEBILITATION, 0x040)
end

itemObject.onItemUse = function(target)
    return salvageUtil.onCellItemUse(target, xi.effect.DEBILITATION, 0x040, 17)
end

return itemObject
