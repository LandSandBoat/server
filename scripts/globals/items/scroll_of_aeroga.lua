-----------------------------------
-- ID: 4792
-- Scroll of Aeroga
-- Teaches the black magic Aeroga
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(184)
end

itemObject.onItemUse = function(target)
    target:addSpell(184)
end

return itemObject
