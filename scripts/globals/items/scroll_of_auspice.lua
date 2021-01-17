-----------------------------------------
-- ID: 4704
-- Scroll of Auspice
-- Teaches the white magic Auspice
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(96)
end

item_object.onItemUse = function(target)
    target:addSpell(96)
end

return item_object
