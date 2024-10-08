-----------------------------------
-- ID: 4218
-- Item: Air Rider
-- A goblin in a Santa outfit rides a sleigh in a downward spiral
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target)
end

return itemObject
