-----------------------------------------
-- ID: 4764
-- Scroll of Aero III
-- Teaches the black magic Aero III
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(156)
end

item_object.onItemUse = function(target)
    target:addSpell(156)
end

return item_object
