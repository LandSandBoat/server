-----------------------------------
-- ID: 4817
-- Scroll of Tornado II
-- Teaches the black magic Tornado II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(209)
end

itemObject.onItemUse = function(target)
    target:addSpell(209)
end

return itemObject
