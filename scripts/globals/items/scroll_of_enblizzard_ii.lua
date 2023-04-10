-----------------------------------
-- ID: 4723
-- Scroll of Enblizzard II
-- Teaches the white magic Enblizzard II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(313)
end

itemObject.onItemUse = function(target)
    target:addSpell(313)
end

return itemObject
