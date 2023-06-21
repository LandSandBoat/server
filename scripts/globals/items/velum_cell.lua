-----------------------------------
-- Velum Cell
-- ID 5380
-- Removes INT Down effect
-----------------------------------
require("scripts/globals/salvage")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.salvage.onCellItemCheck(target, xi.effect.DEBILITATION, 0x010)
end

itemObject.onItemUse = function(target)
    return xi.salvage.onCellItemUse(target, xi.effect.DEBILITATION, 0x010, 15)
end

return itemObject
