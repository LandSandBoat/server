-----------------------------------------
-- ID: 6043
-- Ionohelix Schema
-- Teaches the black magic Ionohelix
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(283)
end

item_object.onItemUse = function(target)
    target:addSpell(283)
end

return item_object
