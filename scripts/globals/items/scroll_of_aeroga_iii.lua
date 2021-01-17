-----------------------------------------
-- ID: 4794
-- Scroll of Aeroga III
-- Teaches the black magic Aeroga III
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(186)
end

item_object.onItemUse = function(target)
    target:addSpell(186)
end

return item_object
