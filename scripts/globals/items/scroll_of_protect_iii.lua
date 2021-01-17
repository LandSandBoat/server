-----------------------------------------
-- ID: 4653
-- Scroll of Protect III
-- Teaches the white magic Protect III
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(45)
end

item_object.onItemUse = function(target)
    target:addSpell(45)
end

return item_object
