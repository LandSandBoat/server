-----------------------------------------
-- ID: 4828
-- Scroll of Poison
-- Teaches the black magic Poison
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(220)
end

item_object.onItemUse = function(target)
    target:addSpell(220)
end

return item_object
