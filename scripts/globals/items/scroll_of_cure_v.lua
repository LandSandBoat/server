-----------------------------------------
-- ID: 4613
-- Scroll of Cure V
-- Teaches the white magic Cure V
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(5)
end

item_object.onItemUse = function(target)
    target:addSpell(5)
end

return item_object
