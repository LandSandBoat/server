-----------------------------------------
-- ID: 4610
-- Scroll of Cure II
-- Teaches the white magic Cure II
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(2)
end

item_object.onItemUse = function(target)
    target:addSpell(2)
end

return item_object
