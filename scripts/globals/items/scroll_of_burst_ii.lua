-----------------------------------------
-- ID: 4821
-- Scroll of Burst II
-- Teaches the black magic Burst II
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(213)
end

item_object.onItemUse = function(target)
    target:addSpell(213)
end

return item_object
