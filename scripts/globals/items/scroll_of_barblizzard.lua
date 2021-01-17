-----------------------------------------
-- ID: 4669
-- Scroll of Barblizzard
-- Teaches the white magic Barblizzard
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(61)
end

item_object.onItemUse = function(target)
    target:addSpell(61)
end

return item_object
