-----------------------------------
-- ID: 28812
-- Maze Rune 013
-- A small stone engraved with a runic symbol, shaped to fit in the notches of a Maze Tabula.
-- The rune reads "Great Warrior."
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return xi.mmm.onRuneCheck(target, item)
end

itemObject.onItemUse = function(target, user, item, action)
    return xi.mmm.onRuneUse(target, item, action)
end

return itemObject
