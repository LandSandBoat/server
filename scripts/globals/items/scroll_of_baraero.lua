-----------------------------------------
-- ID: 4670
-- Scroll of Baraero
-- Teaches the white magic Baraero
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(62)
end

item_object.onItemUse = function(target)
    target:addSpell(62)
end

return item_object
