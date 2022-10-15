-----------------------------------
-- ID: 4709
-- Scroll of Enblizzard
-- Teaches the white magic Enblizzard
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(101)
end

itemObject.onItemUse = function(target)
    target:addSpell(101)
end

return itemObject
