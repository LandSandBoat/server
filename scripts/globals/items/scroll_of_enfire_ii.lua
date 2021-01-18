-----------------------------------
-- ID: 4722
-- Scroll of Enfire II
-- Teaches the white magic Enfire II
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(312)
end

item_object.onItemUse = function(target)
    target:addSpell(312)
end

return item_object
