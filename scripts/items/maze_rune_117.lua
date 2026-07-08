-----------------------------------
-- ID: 28916
-- Maze Rune 117
-- A small stone engraved with a runic symbol, shaped to fit in the notches of a Maze Tabula.
-- The rune reads "Salinity Shift."
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
