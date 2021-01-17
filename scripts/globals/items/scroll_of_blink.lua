-----------------------------------------
-- ID: 4661
-- Scroll of Blink
-- Teaches the white magic Blink
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(53)
end

item_object.onItemUse = function(target)
    target:addSpell(53)
end

return item_object
