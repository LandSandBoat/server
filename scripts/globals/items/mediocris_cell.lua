-----------------------------------
-- Mediocris Cell
-- ID 5382
-- Removes CHR Down effect
-----------------------------------
require("scripts/globals/salvage")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.salvage.onCellItemCheck(target, xi.effect.DEBILITATION, 0x040)
end

itemObject.onItemUse = function(target)
    return xi.salvage.onCellItemUse(target, xi.effect.DEBILITATION, 0x040, 17)
end

return itemObject
