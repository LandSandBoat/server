-----------------------------------------
-- ID: 4633
-- Scroll of Dia III
-- Teaches the white magic Dia III
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(25)
end

item_object.onItemUse = function(target)
    target:addSpell(25)
end

return item_object
