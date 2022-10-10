-----------------------------------
-- ID: 4616
-- Scroll of Curaga II
-- Teaches the white magic Curaga II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(8)
end

itemObject.onItemUse = function(target)
    target:addSpell(8)
end

return itemObject
