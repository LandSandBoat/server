-----------------------------------
-- ID: 4828
-- Scroll of Poison
-- Teaches the black magic Poison
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(220)
end

itemObject.onItemUse = function(target)
    target:addSpell(220)
end

return itemObject
