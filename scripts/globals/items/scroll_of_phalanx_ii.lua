-----------------------------------------
-- ID: 6571
-- Scroll of Phalanx II
-- Teaches the white magic Phalanx II
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(107)
end

item_object.onItemUse = function(target)
    target:addSpell(107)
end

return item_object
