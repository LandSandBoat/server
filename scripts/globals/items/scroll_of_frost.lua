-----------------------------------------
-- ID: 4844
-- Scroll of Frost
-- Teaches the black magic Frost
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(236)
end

item_object.onItemUse = function(target)
    target:addSpell(236)
end

return item_object
