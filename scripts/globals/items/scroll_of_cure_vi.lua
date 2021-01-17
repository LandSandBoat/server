-----------------------------------------
-- ID: 4614
-- Scroll of Cure VI
-- Teaches the white magic Cure VI
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(6)
end

item_object.onItemUse = function(target)
    target:addSpell(6)
end

return item_object
