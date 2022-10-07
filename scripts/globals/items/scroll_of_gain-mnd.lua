-----------------------------------
-- ID: 5092
-- Scroll of Gain-MND
-- Teaches the white magic Gain-MND
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(491)
end

itemObject.onItemUse = function(target)
    target:addSpell(491)
end

return itemObject
