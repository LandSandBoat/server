-----------------------------------------
-- ID: 4629
-- Scroll of Holy
-- Teaches the white magic Holy
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(21)
end

item_object.onItemUse = function(target)
    target:addSpell(21)
end

return item_object
