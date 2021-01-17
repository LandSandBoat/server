-----------------------------------------
-- ID: 4869
-- Scroll of Warp
-- Teaches the black magic Warp
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(261)
end

item_object.onItemUse = function(target)
    target:addSpell(261)
end

return item_object
