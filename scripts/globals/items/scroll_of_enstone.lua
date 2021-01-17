-----------------------------------------
-- ID: 4711
-- Scroll of Enstone
-- Teaches the white magic Enstone
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(103)
end

item_object.onItemUse = function(target)
    target:addSpell(103)
end

return item_object
