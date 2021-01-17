-----------------------------------------
-- ID: 5099
-- Scroll of Boost-MND
-- Teaches the white magic Boost-MND
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(484)
end

item_object.onItemUse = function(target)
    target:addSpell(484)
end

return item_object
