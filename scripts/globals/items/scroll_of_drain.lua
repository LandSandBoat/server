-----------------------------------
-- ID: 4853
-- Scroll of Drain
-- Teaches the black magic Drain
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(245)
end

itemObject.onItemUse = function(target)
    target:addSpell(245)
end

return itemObject
