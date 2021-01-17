-----------------------------------------
-- ID: 5087
-- Scroll of Gain-STR
-- Teaches the white magic Gain-STR
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(486)
end

item_object.onItemUse = function(target)
    target:addSpell(486)
end

return item_object
