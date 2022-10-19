-----------------------------------
-- ID: 5088
-- Scroll of Gain-DEX
-- Teaches the white magic Gain-DEX
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(487)
end

itemObject.onItemUse = function(target)
    target:addSpell(487)
end

return itemObject
