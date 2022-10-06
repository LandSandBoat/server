-----------------------------------
-- ID: 4615
-- Scroll of Curaga
-- Teaches the white magic Curaga
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(7)
end

itemObject.onItemUse = function(target)
    target:addSpell(7)
end

return itemObject
