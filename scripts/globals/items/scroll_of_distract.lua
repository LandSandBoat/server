-----------------------------------
-- ID: 4912
-- Scroll of Distract
-- Teaches the black magic Distract
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(841)
end

itemObject.onItemUse = function(target)
    target:addSpell(841)
end

return itemObject
