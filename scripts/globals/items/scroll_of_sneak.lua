-----------------------------------------
-- ID: 4745
-- Scroll of Sneak
-- Teaches the white magic Sneak
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(137)
end

item_object.onItemUse = function(target)
    target:addSpell(137)
end

return item_object
