-----------------------------------------
-- ID: 5089
-- Scroll of Gain-VIT
-- Teaches the white magic Gain-VIT
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(488)
end

item_object.onItemUse = function(target)
    target:addSpell(488)
end

return item_object
