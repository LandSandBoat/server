-----------------------------------------
-- ID: 4608, 4609
-- Scroll of Cure
-- Teaches the white magic Cure
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(1)
end

item_object.onItemUse = function(target)
    target:addSpell(1)
end

return item_object
