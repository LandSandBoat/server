-----------------------------------
-- Undulatus Cell
-- ID 5371
-- Unlocks ranged and ammo equipment
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.salvage.onCellItemCheck(target, xi.effect.ENCUMBRANCE_I, 0x000C)
end

itemObject.onItemUse = function(target)
    return xi.salvage.onCellItemUse(target, xi.effect.ENCUMBRANCE_I, 0x000C, 6)
end

return itemObject
