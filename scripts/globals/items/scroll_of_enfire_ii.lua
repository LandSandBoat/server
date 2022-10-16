-----------------------------------
-- ID: 4722
-- Scroll of Enfire II
-- Teaches the white magic Enfire II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(312)
end

itemObject.onItemUse = function(target)
    target:addSpell(312)
end

return itemObject
