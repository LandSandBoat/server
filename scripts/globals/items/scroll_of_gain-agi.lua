-----------------------------------
-- ID: 5090
-- Scroll of Gain-AGI
-- Teaches the white magic Gain-AGI
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(489)
end

itemObject.onItemUse = function(target)
    target:addSpell(489)
end

return itemObject
