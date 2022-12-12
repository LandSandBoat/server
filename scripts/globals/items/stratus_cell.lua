-----------------------------------
-- Stratus Cell
-- ID 5369
-- Unlocks leg and feet equipment
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/salvage")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.salvage.onCellItemCheck(target, xi.effect.ENCUMBRANCE_I, 0x0180)
end

itemObject.onItemUse = function(target)
    return xi.salvage.onCellItemUse(target, xi.effect.ENCUMBRANCE_I, 0x0180, 4)
end

return itemObject
