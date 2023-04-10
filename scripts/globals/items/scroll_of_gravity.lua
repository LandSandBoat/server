-----------------------------------
-- ID: 4824
-- Scroll of Gravity
-- Teaches the black magic Gravity
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(216)
end

itemObject.onItemUse = function(target)
    target:addSpell(216)
end

return itemObject
