-----------------------------------
-- ID: 4664
-- Scroll of Slow
-- Teaches the white magic Slow
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(56)
end

itemObject.onItemUse = function(target)
    target:addSpell(56)
end

return itemObject
