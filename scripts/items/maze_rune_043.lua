-----------------------------------
-- ID: 28842
-- Maze Rune 043
-- A small stone engraved with a runic symbol, shaped to fit in the notches of a Maze Tabula.
-- The rune reads "Enhancing Magic."
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
