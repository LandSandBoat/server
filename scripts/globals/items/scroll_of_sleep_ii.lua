-----------------------------------
-- ID: 4867
-- Scroll of Sleep II
-- Teaches the black magic Sleep II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(259)
end

itemObject.onItemUse = function(target)
    target:addSpell(259)
end

return itemObject
