-----------------------------------------
-- ID: 5090
-- Scroll of Gain-AGI
-- Teaches the white magic Gain-AGI
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(489)
end

item_object.onItemUse = function(target)
    target:addSpell(489)
end

return item_object
