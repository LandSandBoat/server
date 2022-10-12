-----------------------------------
-- ID: 4613
-- Scroll of Cure V
-- Teaches the white magic Cure V
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(5)
end

itemObject.onItemUse = function(target)
    target:addSpell(5)
end

return itemObject
