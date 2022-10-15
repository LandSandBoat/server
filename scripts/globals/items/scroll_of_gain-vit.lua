-----------------------------------
-- ID: 5089
-- Scroll of Gain-VIT
-- Teaches the white magic Gain-VIT
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(488)
end

itemObject.onItemUse = function(target)
    target:addSpell(488)
end

return itemObject
