-----------------------------------------
-- ID: 4750
-- Scroll of Reraise III
-- Teaches the white magic Reraise III
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(142)
end

item_object.onItemUse = function(target)
    target:addSpell(142)
end

return item_object
