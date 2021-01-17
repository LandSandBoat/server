-----------------------------------------
-- ID: 4853
-- Scroll of Drain
-- Teaches the black magic Drain
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(245)
end

item_object.onItemUse = function(target)
    target:addSpell(245)
end

return item_object
