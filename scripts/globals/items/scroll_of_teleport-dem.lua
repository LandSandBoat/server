-----------------------------------------
-- ID: 4731
-- Scroll of Teleport-Dem
-- Teaches the white magic Teleport-Dem
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(123)
end

item_object.onItemUse = function(target)
    target:addSpell(123)
end

return item_object
