-----------------------------------------
-- ID: 4702
-- Scroll of Sacrifice
-- Teaches the white magic Sacrifice
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(94)
end

item_object.onItemUse = function(target)
    target:addSpell(94)
end

return item_object
