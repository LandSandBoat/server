-----------------------------------------
-- ID: 4675
-- Scroll of Barblizzara
-- Teaches the white magic Barblizzara
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(67)
end

item_object.onItemUse = function(target)
    target:addSpell(67)
end

return item_object
