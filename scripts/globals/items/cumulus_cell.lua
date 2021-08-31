-----------------------------------
-- Cumulus Cell
-- ID 5367
-- Unlocks body equipment
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/salvage")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return salvageUtil.onCellItemCheck(target, xi.effect.ENCUMBRANCE_I, 0x0020)
end

item_object.onItemUse = function(target)
    return salvageUtil.onCellItemUse(target, xi.effect.ENCUMBRANCE_I, 0x0020, 2)
end

return item_object
