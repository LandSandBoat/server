-----------------------------------
-- Congestus Cell
-- ID 5378
-- Removes VIT Down effect
-----------------------------------
require("scripts/globals/salvage")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.salvage.onCellItemCheck(target, xi.effect.DEBILITATION, 0x004)
end

itemObject.onItemUse = function(target)
    return xi.salvage.onCellItemUse(target, xi.effect.DEBILITATION, 0x004, 13)
end

return itemObject
