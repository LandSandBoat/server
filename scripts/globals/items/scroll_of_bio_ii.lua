-----------------------------------
-- ID: 4839
-- Scroll of Bio II
-- Teaches the black magic Bio II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(231)
end

itemObject.onItemUse = function(target)
    target:addSpell(231)
end

return itemObject
