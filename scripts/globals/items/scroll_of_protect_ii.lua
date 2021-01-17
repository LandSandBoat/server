-----------------------------------------
-- ID: 4652
-- Scroll of Protect II
-- Teaches the white magic Protect II
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(44)
end

item_object.onItemUse = function(target)
    target:addSpell(44)
end

return item_object
