-----------------------------------
-- Castellanus Cell
-- ID 5366
-- Unlocks head and neck equipment
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/salvage")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return salvageUtil.onCellItemCheck(target, xi.effect.ENCUMBRANCE_I, 0x0210)
end

item_object.onItemUse = function(target)
    return salvageUtil.onCellItemUse(target, xi.effect.ENCUMBRANCE_I, 0x0210, 1)
end

return item_object
