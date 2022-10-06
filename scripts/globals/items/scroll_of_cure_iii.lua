-----------------------------------
-- ID: 4611
-- Scroll of Cure III
-- Teaches the white magic Cure III
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(3)
end

itemObject.onItemUse = function(target)
    target:addSpell(3)
end

return itemObject
