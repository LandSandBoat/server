-----------------------------------
-- ID: 4854
-- Scroll of Drain II
-- Teaches the black magic Drain II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(246)
end

itemObject.onItemUse = function(target)
    target:addSpell(246)
end

return itemObject
