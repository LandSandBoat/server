-----------------------------------
-- Radiatus Cell
-- ID 5368
-- Unlocks hand equipment
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.salvage.onCellItemCheck(target, xi.effect.ENCUMBRANCE_I, 0x0040)
end

itemObject.onItemUse = function(target)
    return xi.salvage.onCellItemUse(target, xi.effect.ENCUMBRANCE_I, 0x0040, 3)
end

return itemObject
