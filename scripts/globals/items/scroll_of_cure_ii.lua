-----------------------------------
-- ID: 4610
-- Scroll of Cure II
-- Teaches the white magic Cure II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(2)
end

itemObject.onItemUse = function(target)
    target:addSpell(2)
end

return itemObject
