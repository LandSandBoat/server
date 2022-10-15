-----------------------------------
-- Humilus Cell
-- ID 5383
-- Removes HP Down effect
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/salvage")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return salvageUtil.onCellItemCheck(target, xi.effect.DEBILITATION, 0x080)
end

itemObject.onItemUse = function(target)
    return salvageUtil.onCellItemUse(target, xi.effect.DEBILITATION, 0x080, 18)
end

return itemObject
