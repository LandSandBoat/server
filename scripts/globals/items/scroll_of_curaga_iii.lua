-----------------------------------
-- ID: 4617
-- Scroll of Curaga III
-- Teaches the white magic Curaga III
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(9)
end

itemObject.onItemUse = function(target)
    target:addSpell(9)
end

return itemObject
