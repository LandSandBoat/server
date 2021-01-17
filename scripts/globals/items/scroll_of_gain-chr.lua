-----------------------------------------
-- ID: 5093
-- Scroll of Gain-CHR
-- Teaches the white magic Gain-CHR
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(492)
end

item_object.onItemUse = function(target)
    target:addSpell(492)
end

return item_object
