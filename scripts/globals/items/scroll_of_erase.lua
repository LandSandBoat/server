-----------------------------------------
-- ID: 4751
-- Scroll of Erase
-- Teaches the white magic Erase
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(143)
end

item_object.onItemUse = function(target)
    target:addSpell(143)
end

return item_object
