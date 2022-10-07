-----------------------------------
-- ID: 4913
-- Scroll of Distract
-- Teaches the black magic Distract II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(842)
end

itemObject.onItemUse = function(target)
    target:addSpell(842)
end

return itemObject
