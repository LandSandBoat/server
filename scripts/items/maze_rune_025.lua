-----------------------------------
-- ID: 28824
-- Maze Rune 025
-- A small stone engraved with a runic symbol, shaped to fit in the notches of a Maze Tabula.
-- The rune reads "Thunder."
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
