-----------------------------------------
-- ID: 5094
-- Scroll of Boost-STR
-- Teaches the white magic Boost-STR
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(479)
end

item_object.onItemUse = function(target)
    target:addSpell(479)
end

return item_object
