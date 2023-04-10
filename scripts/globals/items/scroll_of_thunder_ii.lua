-----------------------------------
-- ID: 4773
-- Scroll of Thunder II
-- Teaches the black magic Thunder II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(165)
end

itemObject.onItemUse = function(target)
    target:addSpell(165)
end

return itemObject
