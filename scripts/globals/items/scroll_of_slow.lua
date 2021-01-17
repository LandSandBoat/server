-----------------------------------------
-- ID: 4664
-- Scroll of Slow
-- Teaches the white magic Slow
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(56)
end

item_object.onItemUse = function(target)
    target:addSpell(56)
end

return item_object
