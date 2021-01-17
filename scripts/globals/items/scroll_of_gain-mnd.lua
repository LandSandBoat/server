-----------------------------------------
-- ID: 5092
-- Scroll of Gain-MND
-- Teaches the white magic Gain-MND
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(491)
end

item_object.onItemUse = function(target)
    target:addSpell(491)
end

return item_object
