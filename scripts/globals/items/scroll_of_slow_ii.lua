-----------------------------------------
-- ID: 6569
-- Scroll of Slow II
-- Teaches the white magic Slow II
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(79)
end

item_object.onItemUse = function(target)
    target:addSpell(79)
end

return item_object
