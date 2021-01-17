-----------------------------------------
-- ID: 4847
-- Scroll of Shock
-- Teaches the black magic Shock
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(239)
end

item_object.onItemUse = function(target)
    target:addSpell(239)
end

return item_object
