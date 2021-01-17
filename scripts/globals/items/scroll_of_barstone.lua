-----------------------------------------
-- ID: 4671
-- Scroll of Barstone
-- Teaches the white magic Barstone
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(63)
end

item_object.onItemUse = function(target)
    target:addSpell(63)
end

return item_object
