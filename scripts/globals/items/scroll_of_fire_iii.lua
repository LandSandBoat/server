-----------------------------------------
-- ID: 4754
-- Scroll of Fire III
-- Teaches the black magic Fire III
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(146)
end

item_object.onItemUse = function(target)
    target:addSpell(146)
end

return item_object
