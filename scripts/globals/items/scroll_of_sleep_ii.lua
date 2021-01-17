-----------------------------------------
-- ID: 4867
-- Scroll of Sleep II
-- Teaches the black magic Sleep II
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(259)
end

item_object.onItemUse = function(target)
    target:addSpell(259)
end

return item_object
