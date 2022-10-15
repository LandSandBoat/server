-----------------------------------
-- ID: 4821
-- Scroll of Burst II
-- Teaches the black magic Burst II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(213)
end

itemObject.onItemUse = function(target)
    target:addSpell(213)
end

return itemObject
