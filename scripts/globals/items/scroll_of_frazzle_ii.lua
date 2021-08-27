-----------------------------------
-- ID: 4915
-- Scroll of Frazzle II
-- Teaches the black magic Frazzle II
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(844)
end

item_object.onItemUse = function(target)
    target:addSpell(844)
end

return item_object
