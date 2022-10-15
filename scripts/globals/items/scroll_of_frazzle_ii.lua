-----------------------------------
-- ID: 4915
-- Scroll of Frazzle II
-- Teaches the black magic Frazzle II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(844)
end

itemObject.onItemUse = function(target)
    target:addSpell(844)
end

return itemObject
