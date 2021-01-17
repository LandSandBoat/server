-----------------------------------------
-- ID: 4856
-- Scroll of Aspir II
-- Teaches the black magic Aspir II
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(248)
end

item_object.onItemUse = function(target)
    target:addSpell(248)
end

return item_object
