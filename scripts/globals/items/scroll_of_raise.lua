-----------------------------------
-- ID: 4620
-- Scroll of Raise
-- Teaches the white magic Raise
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(12)
end

itemObject.onItemUse = function(target)
    target:addSpell(12)
end

return itemObject
