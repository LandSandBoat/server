-----------------------------------------
-- ID: 6052
-- Hailstorm Schema
-- Teaches the white magic Hailstorm
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(116)
end

item_object.onItemUse = function(target)
    target:addSpell(116)
end

return item_object
