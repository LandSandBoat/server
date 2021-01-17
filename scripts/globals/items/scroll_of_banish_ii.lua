-----------------------------------------
-- ID: 4637
-- Scroll of Banish II
-- Teaches the white magic Banish II
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(29)
end

item_object.onItemUse = function(target)
    target:addSpell(29)
end

return item_object
